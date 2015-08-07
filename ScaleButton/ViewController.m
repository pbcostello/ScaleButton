//
//  ViewController.m
//  ScaleButton
//
//  Created by Patrick Costello.
//  Copyright (c) 2015 Patrick Costello. All rights reserved.
//

#import "ViewController.h"
#import "ScaleButtonView.h"

@interface ViewController ()
@property (nonatomic) IBOutlet UILabel *count1Label;
@property (nonatomic) IBOutlet UILabel *count2Label;
@end

@implementation ViewController

-(IBAction)pressedButton1:(ScaleButtonView*)button
{
    static int count = 0;
    _count1Label.text = @(++count).stringValue;
}

-(IBAction)pressedButton2:(ScaleButtonView*)button
{
    static int count = 0;
    _count2Label.text = @(++count).stringValue;
}

@end
