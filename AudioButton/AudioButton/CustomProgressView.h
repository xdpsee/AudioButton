//
//  CustomProgressView.h
//  AudioButton
//
//  Created by lei xue on 14-8-4.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomProgressViewDelegate <NSObject>
-(CGFloat)currentProgress;
@end

typedef enum{
    CustomProgressShapeCircle,
    CustomProgressShapeRoundRectangle,
}CustomProgressShape;

@interface CustomProgressView : UIView
@property (assign, nonatomic) float progress;
@property (assign, nonatomic) id <CustomProgressViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame backColor:(UIColor *)aBackColor progressColor:(UIColor *)aProgressColor lineWidth:(CGFloat)aLineWidth progressShape:(CustomProgressShape)progressShape;

-(void)startLoading;
-(void)stopLoading;
- (void)play;
- (void)pause;
- (void)stop;

@end