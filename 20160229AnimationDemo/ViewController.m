//
//  ViewController.m
//  20160229AnimationDemo
//
//  Created by majian on 16/2/29.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self demo_initScaleLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self demo_keyFrameAnimation];
}

#pragma mark - Private Method
- (void)demo_initScaleLayer {
    //演员初始化
    CALayer * subLayer = [[CALayer alloc] init];
    [self.view.layer addSublayer:subLayer];
    subLayer.backgroundColor = [UIColor orangeColor].CGColor;
    subLayer.frame = CGRectMake(100, 20, 50, 50);
    subLayer.cornerRadius = 10.0f;
    subLayer.masksToBounds = YES;
    
    //设定剧本
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = @(1.0f);
    basicAnimation.toValue = @(1.5f);
    basicAnimation.repeatCount = 10000;
    basicAnimation.autoreverses = YES;
    basicAnimation.fillMode = kCAFillModeBackwards;
    basicAnimation.duration = 1.0;
    
    CABasicAnimation * positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 100)];
    positionAnimation.duration = 2.0f;
    positionAnimation.fillMode = kCAFillModeBackwards;
    positionAnimation.repeatCount = MAXFLOAT;
    positionAnimation.autoreverses = YES;
    
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.fromValue = @(0.0);
    rotationAnimation.toValue = @(6 * M_PI);
    rotationAnimation.fillMode = kCAFillModeBackwards;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 2.0f;
    
    CAAnimationGroup * groupAnimatios = [[CAAnimationGroup alloc] init];
    groupAnimatios.animations = @[basicAnimation,positionAnimation,rotationAnimation];
    groupAnimatios.duration = 2.0f;
    groupAnimatios.repeatCount = MAXFLOAT;
    groupAnimatios.fillMode = kCAFillModeBackwards;
    groupAnimatios.autoreverses = YES;
    
    //开始演戏
    [subLayer addAnimation:groupAnimatios forKey:@"groupAnimation"];
}

- (void)demo_keyFrameAnimation {
    CAKeyframeAnimation *aniamtion = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    aniamtion.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:
                         CATransform3DRotate(CATransform3DMakeScale(0.01, 0.01, 0.1),
                                             -M_PI, 0, 0, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
    aniamtion.keyTimes = [NSArray arrayWithObjects:
                          @(0),
                          @(0.6),
                          @(1.0), nil];
    aniamtion.timingFunctions = [NSArray arrayWithObjects:
                                 [CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                 nil];
    aniamtion.duration = 2.0;
    //    aniamtion.delegate = self;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor orangeColor];
    
    [view.layer addAnimation:aniamtion forKey:@"keyFrameAnimation"];
}


@end
