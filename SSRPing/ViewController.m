//
//  ViewController.m
//  SSRPing
//
//  Created by riceFun on 2019/8/6.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "ViewController.h"
#import "QDNetDiagnostics.h"
#import "PingSourceModel.h"

#import "STDPingServices.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) QDNetDiagnostics *netDiagnostics;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *ipArray;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
    
    // device info ping and traceroute
    //    self.netDiagnostics = [[QDNetDiagnostics alloc] initWithHostName:@"162.220.51.58"];
    // 162.220.51.58
    //百度 14.215.177.39
    //www.suning.com
    
    //    [self.netDiagnostics startDiagnosticAndNetInfo:^(NSString *info) {
    //        NSLog(@"%@",info);
    //    }];
    
    // ping
    //    [self.netDiagnostics startPingAndCallback:^(NSString *info) {
    //        NSLog(@"%@",info);
    //    }];
    
    //traceroute
    //    [self.netDiagnostics startTracerouteAndCallback:^(NSString *info) {
    //        NSLog(@"%@",info);
    //    }];
    
    
}
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ipArray.count;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kkk"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"kkk"];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    NSDictionary *dic = self.ipArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",dic[@"ip"],dic[@"port"]];
    
    
    
    
    STDPingServices *pingServices = [STDPingServices startPingAddress:@"www.baidu.com" callbackHandler:^(STDPingItem *pingItem, NSArray *pingItems) {
        if (pingItem.status != STDPingStatusFinished) {
            cell.detailTextLabel.text = pingItem.description;
        } else {
            cell.detailTextLabel.text = [STDPingItem statisticsWithPingItems:pingItems];
        }
    }];
    
    
    
    
    
//    
//    QDNetDiagnostics *netDiagnostics = [[QDNetDiagnostics alloc]initWithHostName:dic[@"ip"]];
//    
//    // ping
//    //    __weak typeof weakCell(cell) = cell;
//    [netDiagnostics startPingAndCallback:^(NSString *info) {
//        NSLog(@"%@",info);
//        CGFloat pingValue = [info floatValue];
//        if (0 < pingValue && pingValue < 100) {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms",pingValue];
//            cell.detailTextLabel.textColor = [UIColor greenColor];
//        }else if (100 < pingValue && pingValue <= 200) {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms",pingValue];
//            cell.detailTextLabel.textColor = [UIColor yellowColor];
//        }else if (200 < pingValue && pingValue <= 300) {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms",pingValue];
//            cell.detailTextLabel.textColor = [UIColor orangeColor];
//        }else if (300 < pingValue && pingValue < 100000000) {
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms",pingValue];
//            cell.detailTextLabel.textColor = [UIColor redColor];
//        }else {
//            cell.detailTextLabel.text = @"timeout";
//            cell.detailTextLabel.textColor = [UIColor redColor];
//        }
//        
//    }];
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.ipArray[indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"link"]] options:@{} completionHandler:nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = dic[@"link"];
}
    
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
    
}
    
-(NSArray *)ipArray {
    if (!_ipArray) {
        _ipArray = @[
                     @"14.215.177.39",
                     @"162.220.51.58",
                     @"23.254.204.203",
                     @"185.186.245.44",
                     @"54.65.244.39",
                     @"13.115.220.222",
                     @"54.65.155.40",
                     @"13.115.220.222",
                     @"54.65.244.39",
                     ];
        _ipArray = [PingSourceModel handlePingSourceData];
    }
    return _ipArray;
}



@end
