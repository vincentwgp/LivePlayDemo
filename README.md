# LivePlayDemo
了解下直播 参考http://www.cocoachina.com/ios/20161111/18050.html

简述总体内容

1.直播流程介绍
2.Mac搭建nginx+rtmp服务器(模拟推流拉流)
3.简单的集成推流拉流(实用篇)

#二:Mac搭建nginx+rtmp服务器(模拟推流拉流)

  手动输入命令的时候容易出现了bug(所以, 建议大家直接复制命令, 不要手动输入命令). 所以记录一份详细的搭建步骤,参考Mac搭建nginx+rtmp服务器

  1.打开终端, 查看是否已经安装了Homebrew, 直接终端输入命令
     man brew
  如果Mac已经安装了, 会显示一些命令的帮助信息. 此时输入Q退出即可, 直接进入第二步.反之, 如果没有安装,执行命令
  
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  如果安装后, 想要卸载
  
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  2.安装nginx

  先clone nginx项目到本地

    brew tap homebrew/nginx
  执行安装:

    brew install nginx-full --with-rtmp-module
  此时, nginx和rtmp模块就安装好了
  输入命令:

    nginx
  在浏览器里打开http://localhost:8080
    brew info nginx-full
  编辑 vim /usr/local/etc/nginx/nginx.conf
  
  在http节点后面加上rtmp配置：
  
  rtmp {
    server {
    listen 1935;
    application rtmplive {
        live on;
        record off;
      }
    }
 }
 
 然后重启nginx(其中的1.10.1要换成你自己安装的nginx版本号, 查看版本号用nginx -v命令即可)
 

  /usr/local/Cellar/nginx-full/1.10.1/bin/nginx -s reload
 
 4.安装ffmpeg
 
 brew install ffmpeg
 
 推流
 
 ffmpeg -re -i /Users/jinqianxiang/Desktop/BigBuck.m4v -vcodec libx264 -acodec aac -strict -2 -f flv rtmp://localhost:1935/rtmplive/room


#三.简单的集成推流拉流(实用篇)

  1，推流集成LFLiveKit，参考github demo
  
  pod 'LFLiveKit'
  
  2.拉流集成 ijkplayer
    编译参考：http://www.jianshu.com/p/1f06b27b3ac0
  
    IJKFFOptions *options = [IJKFFOptions optionsByDefault]; //使用默认配置
    NSURL * url = [NSURL URLWithString:@"rtmp://10.0.60.65:1935/rtmplive/room"];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options]; //初始化播放器，播放在线视频或直播(RTMP)
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit; //缩放模式
    self.player.shouldAutoplay = YES; //开启自动播放
    
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
    
    








