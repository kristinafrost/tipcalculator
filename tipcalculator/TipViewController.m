//
//  TipViewController.m
//  tipcalculator
//
//  Created by Kristina Frost on 5/27/14.
//  Copyright (c) 2014 Kristina Frost. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *partyTextField;
@property (weak, nonatomic) IBOutlet UILabel *perPersonLabel;

- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    
    [self.billTextField becomeFirstResponder];
    self.billTextField.delegate = self;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    int partySize;
    if (self.partyTextField.text && self.partyTextField.text.length > 0) {
        partySize = [self.partyTextField.text intValue];
    } else {
        partySize = 1;
    }
    
    
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    NSUInteger tipControlIndex = self.tipControl.selectedSegmentIndex;
    NSNumber *tipValue = tipValues[tipControlIndex];
    
    float tipAmount = billAmount * [tipValue floatValue];
    float totalAmount = ceilf(tipAmount + billAmount);
    
    self.tipLabel.text = [NSString stringWithFormat: @"$%0.2f", totalAmount-billAmount];
    self.totalLabel.text = [NSString stringWithFormat: @"$%0.2f", totalAmount];
    self.perPersonLabel.text = [NSString stringWithFormat: @"$%0.2f", totalAmount/partySize];
    
    // roundf(number)
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"location: %i length: %i",range.location,range.length);
    
    return YES;
}

@end
