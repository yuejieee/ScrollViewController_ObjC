//
//  BaseScrollViewController.m
//  HappyOneHundred
//
//  Created by 岳杰 on 2017/2/14.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "BaseScrollViewController.h"
#import "Marco.h"
#import "Header.h"
#import "Config.h"

#define btnW kScreen_Width/self.titleArray.count
#define titleH 80 * kScale

@interface BaseScrollViewController ()
<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation BaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.btnArray = [NSMutableArray array];
    [self setupPageSubviews];
    [self setupPageSubviewsProperty];
}

- (void)setupPageSubviews {
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, titleH)];
    [self.view addSubview:self.titleScrollView];
    
    self.lineView = [[UIView alloc] init];
    [self.titleScrollView addSubview:self.lineView];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleH, kScreen_Width, kScreen_Height - titleH)];
    [self.view addSubview:self.contentScrollView];
}

- (void)setupPageSubviewsProperty {
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.contentSize = CGSizeMake(btnW, 0);
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    self.titleScrollView.delegate = self;
    
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.backgroundColor = ARC4RANDOM_COLOR;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    
    self.lineView.backgroundColor = RED_COLOR;
}

- (void)setupTitle {
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleScrollView addSubview:button];
        button.frame = CGRectMake(i * btnW, 0, btnW, titleH - 2);
        button.tag = 1000 + i;
        button.titleLabel.font = FontWithSize(34);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
    }
    self.lineView.frame = CGRectMake(0, titleH - 2, btnW, 2);
    self.contentScrollView.contentSize = CGSizeMake(self.titleArray.count * kScreen_Width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        CGFloat offsetX = scrollView.contentOffset.x;
        self.lineView.frame = CGRectMake(offsetX/kScreen_Width * btnW, titleH - 2, btnW, 2);
    }
}

- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    NSInteger index = self.childViewControllers.count - 1;
    [self.contentScrollView addSubview:childController.view];
    self.contentScrollView.subviews[index].frame = CGRectMake(index * kScreen_Width, 0, kScreen_Width, kScreen_Height - 64 - 80 * kScale);
}

#pragma mark - event response
- (void)click:(UIButton *)button {
    NSInteger index = button.tag - 1000;
    [self.contentScrollView setContentOffset:CGPointMake(index * kScreen_Width, 0) animated:YES];
}

#pragma mark - getters and setters
- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self setupTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
