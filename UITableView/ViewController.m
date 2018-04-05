//
//  ViewController.m
//  UITableView
//
//  Created by 张储祺 on 2018/4/3.
//  Copyright © 2018年 张储祺. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView ;

@end

@implementation ViewController

-(UITableView *)tableView{
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] ;
        //设置代理和数据源
        _tableView.dataSource = self ;
        _tableView.delegate = self ;
        //分割线
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
        _tableView.separatorColor = [UIColor brownColor] ;
        
        //索引栏
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor] ;
        //索引文字
        _tableView.sectionIndexColor = [UIColor redColor] ;
    }
    return _tableView ;
}

//dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20 ;
}
//设置section头尾部文字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * message = [[NSString alloc] initWithFormat:@"这是第%ld个section头部视图",(long)section] ;
    return message ;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString * message = [[NSString alloc] initWithFormat:@"这是第%ld个section尾部视图",(long)section] ;
    return message ;
}

//自定义view设置section样式
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)] ;
    headerView.backgroundColor = [UIColor brownColor] ;
    return headerView ;
}
*/

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    footerView.backgroundColor = [UIColor darkGrayColor] ;
    return footerView ;
}

//索引样式制定
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"s0",@"s1",@"s2",@"s3"] ;
}

//cell制定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //reuse
    static NSString * cellID = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID] ;
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] ;
    }
    NSString * text = [NSString stringWithFormat:@"%ld",(long)indexPath.row] ;
    cell.textLabel.text = text ;
    cell.detailTextLabel.text = @"this is a learning test" ;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryNone ;
    return cell ;
}

//delegate
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES ;
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.textLabel.text = @"highlighted" ;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"在%@调用willselect方法",indexPath) ;
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.textLabel.text = [NSString stringWithFormat:@"cell at %@ will select",indexPath] ;
    return indexPath ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"调用didselect方法") ;
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.textLabel.text = @"didselect" ;
    printf("调用didselect方法\n") ;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row] ;
    
}

//cell的编辑方法

//设置按钮
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction * action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"添加" handler:nil] ;
    UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"移动" handler:nil] ;
    UITableViewRowAction * action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除的单元格在第%ld行", (long)indexPath.row) ;
        [tableView reloadData] ;
    }];
    
    NSArray * actionArray = @[action1,action2,action3] ;
    
    return actionArray ;
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
