//
//  ScaleButtonView.m
//  ScaleButton
//
//  Created by Patrick Costello.
//  Copyright (c) 2015 Patrick Costello. All rights reserved.
//

#import "ScaleButtonView.h"

#define DefaultCornerRadius 4
#define PressedAlpha 0.8f

@interface ScaleButtonView()
@property (nonatomic) IBInspectable CGFloat pressScale;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@end

@implementation ScaleButtonView

-(void) awakeFromNib
{
    [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(buttonReleased:) forControlEvents:UIControlEventTouchCancel];
    
    for (UIView *view in self.subviews)
        [view setUserInteractionEnabled:NO];
    
    if (!_cornerRadius)
        _cornerRadius = DefaultCornerRadius;
}

-(void) roundCorners
{
    [[self layer] setMasksToBounds:YES];
    [self.layer setCornerRadius:_cornerRadius];
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.clipsToBounds)
        [self roundCorners];
}

-(void) buttonPressed:(id)sender
{
    if (self.enabled && _pressScale)
        [self scaleButton:_pressScale :PressedAlpha];
}

-(void) buttonReleased:(id)sender
{
    if (self.enabled)
        [self scaleButton:1.0f :1.0f];
}

-(void) scaleButton:(CGFloat)scale :(CGFloat)alpha
{
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = alpha;
                         self.transform = CGAffineTransformMakeScale(scale, scale);
                         [self.superview layoutIfNeeded];
                     }
                     completion:^(BOOL completed) {
                     }];
}

-(void) setEnabled:(BOOL)enabled
{
    BOOL e = self.enabled;
    [super setEnabled:enabled];
    if (e != enabled)
    {
        if (e)
        {
            [self scaleButton:1.0f :PressedAlpha];
        }
        else
        {
            [self scaleButton:1.0f :1.0f];
        }
    }
}

@end
