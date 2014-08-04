//
//  ViewController.m
//  AudioButton
//
//  Created by lei xue on 14-8-4.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import "ViewController.h"
#import "CustomProgressView.h"
#import "ProgressLayers.h"
#import "AudioButton.h"

@interface ViewController ()<CustomProgressViewDelegate, ProgressLayersDelegate>
@property (assign, nonatomic) BOOL isPlaying;
@property (strong, nonatomic) CustomProgressView *customProgressView;
@property (strong, nonatomic) UIButton *buttonWithProgressLayers;
@property (strong, nonatomic) ProgressLayers *progressLayers;
@property (strong, nonatomic) AudioButton *audioButton;
@property (strong, nonatomic) AudioButton *audioButtonRound;
@end

@implementation ViewController
@synthesize isPlaying;
@synthesize customProgressView;
@synthesize buttonWithProgressLayers;
@synthesize progressLayers;
@synthesize audioButton;
@synthesize audioButtonRound;

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*
     两种方式生成边框带progress效果的控件：
     1. 将CustomProgressView放在控件的后面，控件backgroundImage设为边缘透明的图片，效果控制通过CustomProgressView对象执行。
     2. 将ProgressLayers加到控件上，效果控制通过ProgressLayers对象执行。
     */
    //    self.rounRectProgressView = [[CustomProgressView alloc] initWithFrame:CGRectMake(30, 100, 100, 100) backColor:[UIColor colorWithRed:236.0 / 255.0 green:236.0 / 255.0 blue:236.0 / 255.0 alpha:1.0] progressColor:[UIColor colorWithRed:82.0 / 255.0 green:135.0 / 255.0 blue:237.0 / 255.0 alpha:1.0] lineWidth:5 progressShape:(CustomProgressShapeCircle)];
    
    self.customProgressView = [[CustomProgressView alloc] initWithFrame:CGRectMake(130, 50, 60, 60) backColor:[UIColor colorWithRed:236.0 / 255.0 green:236.0 / 255.0 blue:236.0 / 255.0 alpha:1.0] progressColor:[UIColor colorWithRed:82.0 / 255.0 green:135.0 / 255.0 blue:237.0 / 255.0 alpha:1.0] lineWidth:5 progressShape:(CustomProgressShapeCircle)];
    self.customProgressView.delegate = self;
    [self.view addSubview:customProgressView];
    [customProgressView startLoading];
    
    buttonWithProgressLayers = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonWithProgressLayers.frame = CGRectMake(60, 120, 200, 60);
    CGFloat cornRadius = 0;
    progressLayers = [[ProgressLayers alloc] initWithView:buttonWithProgressLayers backColor:[UIColor colorWithRed:236.0 / 255.0 green:236.0 / 255.0 blue:236.0 / 255.0 alpha:1.0] progressColor:[UIColor colorWithRed:82.0 / 255.0 green:135.0 / 255.0 blue:237.0 / 255.0 alpha:1.0] lineWidth:5 progressShape:ProgressLayersShapeRoundRectangle cornRadius:&cornRadius];
    buttonWithProgressLayers.layer.cornerRadius = cornRadius;
    progressLayers.delegate = self;
    [progressLayers startLoading];
    [self.view addSubview:buttonWithProgressLayers];
    
    UIButton *controlButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    controlButton.frame = CGRectMake(60, 190, 200, 20);
    controlButton.layer.borderColor = [UIColor grayColor].CGColor;
    controlButton.layer.borderWidth = 1.0f;
    controlButton.layer.cornerRadius = 2.0f;
    [controlButton setTitle:@"play or stop animation" forState:UIControlStateNormal];
    [controlButton addTarget:self action:@selector(playOrStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:controlButton];
    
    audioButtonRound = [AudioButton buttonWithType:UIButtonTypeCustom];
    [audioButtonRound setupWithFrame:CGRectMake(135, 250, 50, 50) isRound:YES backgroundColor:[UIColor whiteColor] audioPath:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample" ofType:@"m4a"]]];
    [self.view addSubview:audioButtonRound];
    
    audioButton = [AudioButton buttonWithType:UIButtonTypeCustom];
    [audioButton setupWithFrame:CGRectMake(30, 310, 220, 50) isRound:NO backgroundColor:[UIColor whiteColor] audioPath:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample" ofType:@"m4a"]]];
    [self.view addSubview:audioButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)currentProgress{
    static CGFloat progress = 0.0f;
    progress += 0.05f;
    if (progress > 1.0f) {
        progress = 0.0f;
    }
    
    return progress;
}

-(void)playOrStop{
    isPlaying = !isPlaying;
    if (isPlaying) {
        [customProgressView play];
        [progressLayers play];
    }
    else{
        [customProgressView stop];
        [progressLayers stop];
    }
    
}

@end
