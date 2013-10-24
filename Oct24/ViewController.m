//
//  ViewController.m
//  Oct24
//
//  Created by John Tabbone on 10/24/13.
//  Copyright (c) 2013 John V. Tabbone, Inc. All rights reserved.
//
#import "ViewController.h"

@implementation ViewController

UIImageView * dayImg;
UIImageView * nightImg;
UIImageView* ghostImg;

#define CENTER  CGPointMake( 160,210)

- (void)viewDidLoad
{
        // Day Image on bottom
    dayImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"day.png"]];
    [self.view addSubview:dayImg];
    
        // Night Image on top
    nightImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"night.png"]];
    [self.view addSubview:nightImg];
    
    ghostImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ghost.png"]];
    ghostImg.frame = CGRectMake(10,-100,50,50);
    
    [self.view addSubview:ghostImg];
    
    [self animateGhostTo:CENTER];
    [self startBackgroundAnimation];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    [self animateGhostTo:p];
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    [self animateGhostTo:p];
    
    
}

-(void)animateGhostTo:(CGPoint) aPoint
{
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         ghostImg.alpha = .5;
                         [self ghostMoveTo:aPoint];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              ghostImg.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              [self bounceGhost];
                                          }];
                     }];
    
}


-(void)bounceGhost{
    
    [UIView animateWithDuration:.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self ghostJumpUp:15];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:.25
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              [self ghostJumpDown:15];
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
    ;
}



-(void) ghostMoveTo:(CGPoint) aPoint
{
    ghostImg.center = aPoint ;
}

-(void) ghostJumpUp:(float) aJump
{
    ghostImg.center = CGPointMake( ghostImg.center.x,ghostImg.center.y - aJump);
}

-(void) ghostJumpDown:(float) aJump
{
    ghostImg.center = CGPointMake( ghostImg.center.x,ghostImg.center.y + aJump);
}



-(void)startBackgroundAnimation{
    
    [UIView animateWithDuration:2.0 animations:^{
        
        nightImg.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2.0 animations:^{
            
            nightImg.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [self startBackgroundAnimation];
        }];
    }];    
}

@end

