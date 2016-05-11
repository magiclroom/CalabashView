//
//  ViewController.m
//  CalabashView
//
//  Created by magicrom on 16/5/11.
//  Copyright © 2016年 forlink. All rights reserved.
//

#import "ViewController.h"
#import "CalabashView.h"

@interface ViewController ()

@property (nonatomic, weak) CalabashView *calabashView;

@end

@implementation ViewController

- (CalabashView *)calabashView {
    if (!_calabashView) {
        CalabashView *calabashView = [[CalabashView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:calabashView];
        _calabashView = calabashView;
    }
    return _calabashView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calabashView.backgroundColor = [UIColor clearColor];
    self.calabashView.bacgroundLineColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.calabashView.frame = CGRectMake(50, 50, 36, 350);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
