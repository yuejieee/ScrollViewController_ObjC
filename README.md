# ScrollViewController_ObjC
##Description
类似一些新闻客户端的滚动视图，可实现顶部button和下方视图的联动切换
##Usage
首先创建一个新的类继承于此类
```
  // 设置顶部标题
  self.titleArray = @[@"1", @"2", @"3"];
  // 添加子视图
  for (NSInteger i = 0; i < 3; i++) {
    UIViewController *vc = [[UIViewController alloc] init];
      [self addChildViewController:vc];
    }
```
