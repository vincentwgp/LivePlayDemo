//
//  ViewController.m
//  LivePlayDemo
//
//  Created by yougou-sk on 2017/6/7.
//  Copyright © 2017年 yougou. All rights reserved.
//

#import "ViewController.h"
#import <LFLiveKit.h>
#import "LFLivePreview.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface ViewController ()


@property (nonatomic,strong) IJKFFMoviePlayerController *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self startLive];
    
//    IJKFFMoviePlayerController * _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"rtmp://10.0.60.65:1935/rtmplive/room" withOptions:nil];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault]; //使用默认配置
    NSURL * url = [NSURL URLWithString:@"rtmp://10.0.60.65:1935/rtmplive/room"];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options]; //初始化播放器，播放在线视频或直播(RTMP)
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit; //缩放模式
    self.player.shouldAutoplay = YES; //开启自动播放
    
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
    //    [self.view addSubview:[[LFLivePreview alloc] initWithFrame:self.view.bounds]];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.player prepareToPlay];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
