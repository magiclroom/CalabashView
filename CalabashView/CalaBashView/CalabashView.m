//
//  CalabashView.m
//  animationdemo
//
//  Created by magicrom on 16/4/15.
//  Copyright © 2016年 forlink. All rights reserved.
//

#import "CalabashView.h"
#import "CalabashBtn.h"
#import "Masonry.h"

#define backgroundLineWidth 7
#define btnCount 7
#define btnWidth 36
#define kThemeColor [UIColor orangeColor]

typedef enum : NSUInteger {
    DrectionTop,
    DrectionBottom
} Drection;

@interface CalabashView ()

@property (nonatomic, weak) UIView *backgroundLine;
@property (nonatomic, assign) CGFloat moveDistance;
@property (nonatomic, strong) NSMutableArray *topBtns;
@property (nonatomic, strong) NSMutableArray *bottomBtns;

@end

@implementation CalabashView

- (CGFloat)moveDistance {
    return self.frame.size.height - (btnCount - 1) * btnWidth;
}

- (NSMutableArray *)topBtns {
    if (!_topBtns) {
        NSMutableArray *topBtns = [NSMutableArray array];
        _topBtns = topBtns;
    }
    return _topBtns;
}

- (NSMutableArray *)bottomBtns {
    if (!_bottomBtns) {
        NSMutableArray *bottomBtns = [NSMutableArray array];
        _bottomBtns = bottomBtns;
    }
    return _bottomBtns;
}

- (UIView *)backgroundLine {
    if (!_backgroundLine) {
        UIView *backgroundLine = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:backgroundLine];
        _backgroundLine = backgroundLine;
    }
    return _backgroundLine;
}

- (void)setBacgroundLineColor:(UIColor *)bacgroundLineColor {
    _bacgroundLineColor = bacgroundLineColor;
    self.backgroundLine.backgroundColor = bacgroundLineColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    [self makeConstraits];
}

- (void)makeConstraits {
    [self.backgroundLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(@(backgroundLineWidth));
        make.centerX.equalTo(self.mas_centerX);
    }];
//    self.backgroundLine.frame = CGRectMake((self.frame.size.width - backgroundLineWidth) * 0.5, 0, backgroundLineWidth, self.frame.size.height);
}

- (void)addBtns {
    NSArray *titles = @[@"葫芦1",@"葫芦2",@"葫芦3",@"葫芦4",@"葫芦5",@"葫芦6",@"葫芦7"];
    
    CGFloat btnCenterX = self.frame.size.width * 0.5;
    CGFloat btnCnterY = 0;
    CGFloat btnW = btnWidth;
    CGFloat btnH = btnW;
    for (int i = 0; i < btnCount; i++) {
        btnCnterY = i * btnWidth;
        CalabashBtn *btn = [CalabashBtn buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 18;
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self addSubview:btn];
        
        btn.frame = CGRectMake(btnCenterX - btnWidth * 0.5, btnCnterY - btnWidth * 0.5, btnW, btnH);
        
        if (i == 0) {
            btn.TopBtn = YES;
            btn.backgroundColor = kThemeColor;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [[UIColor whiteColor] CGColor];
            [self.topBtns addObject:btn];
        } else {
            btn.TopBtn = NO;
            [btn setTitleColor:kThemeColor forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [kThemeColor CGColor];
            [self moveBtn:btn withDistance:self.moveDistance tooDirection:DrectionBottom andDuration:0];
            [self.bottomBtns addObject:btn];
        }
    }
}

- (void)clickBtn:(CalabashBtn *)btn {
    
    NSLog(@"%zd", btn.TopBtn);
    if (!btn.isTopBtn) {
        NSMutableArray *newBottomBtns = [NSMutableArray array];
        for (CalabashBtn *calabashBtn in self.bottomBtns) {
            
            if (calabashBtn.tag <= btn.tag) {
                [self moveBtn:calabashBtn withDistance:self.moveDistance tooDirection:DrectionTop andDuration:0.2];
                calabashBtn.TopBtn = YES;
                [self.topBtns addObject:calabashBtn];
            } else {
                [newBottomBtns addObject:calabashBtn];
            }
        }
        self.bottomBtns = newBottomBtns;
        for (CalabashBtn *calabashBtn in self.topBtns) {
            if (calabashBtn.tag == btn.tag) {
                [calabashBtn setBackgroundColor:kThemeColor];
                [calabashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                calabashBtn.layer.borderWidth = 1;
                calabashBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            } else {
                [calabashBtn setBackgroundColor:[UIColor whiteColor]];
                [calabashBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
                calabashBtn.layer.borderWidth = 1;
                calabashBtn.layer.borderColor = [kThemeColor CGColor];
            }
        }
    } else {
        NSMutableArray *newTopBtns = [NSMutableArray array];
        for (CalabashBtn *calabashBtn in self.topBtns) {
            if (calabashBtn.tag > btn.tag) {
                [self moveBtn:calabashBtn withDistance:self.moveDistance tooDirection:DrectionBottom andDuration:0.2];
                calabashBtn.TopBtn = NO;
                [self.bottomBtns addObject:calabashBtn];
            } else {
                [newTopBtns addObject:calabashBtn];
            }
        }
        self.topBtns = newTopBtns;
        for (CalabashBtn *calabashBtn in self.topBtns) {
            if (calabashBtn.tag == btn.tag) {
                [calabashBtn setBackgroundColor:kThemeColor];
                [calabashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                calabashBtn.layer.borderWidth = 1;
                calabashBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
            }
        }
        for (CalabashBtn *calabashBtn in self.bottomBtns) {
            [calabashBtn setBackgroundColor:[UIColor whiteColor]];
            [calabashBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
            calabashBtn.layer.borderWidth = 1;
            calabashBtn.layer.borderColor = [kThemeColor CGColor];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickCalabashBtn" object:@(btn.tag)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addBtns];
}

- (void)moveBtn:(UIButton *)btn withDistance:(CGFloat)distance tooDirection:(Drection)direction andDuration:(CGFloat)duration {
    if (direction == DrectionBottom) {
        [UIView animateWithDuration:duration animations:^{
            
            CGRect tempFrame = btn.frame;
            tempFrame.origin.y += distance + btnWidth * 0.5;
            btn.frame = tempFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration animations:^{
                CGRect tempFrame = btn.frame;
                tempFrame.origin.y -= btnWidth * 0.5;
                btn.frame = tempFrame;
            }];
        }];
    } else if (direction == DrectionTop) {
        [UIView animateWithDuration:duration animations:^{
            
            CGRect tempFrame = btn.frame;
            tempFrame.origin.y -= distance + btnWidth * 0.5;
            btn.frame = tempFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration animations:^{
                CGRect tempFrame = btn.frame;
                tempFrame.origin.y += btnWidth * 0.5;
                btn.frame = tempFrame;
            }];
        }];
    }
    
}

@end
