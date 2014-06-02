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

@property (weak, nonatomic) IBOutlet UILabel *billTotal;
@property (weak, nonatomic) IBOutlet UILabel *grandTotal;

@property (weak, nonatomic) IBOutlet UISlider *splitSlider;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UILabel *tipSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitSliderLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearAllButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *perPersonLabel;

- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"TipMe";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    
    [self.billTextField becomeFirstResponder];
    self.billTextField.delegate = self;
    self.billTextField.textColor = [UIColor lightGrayColor];
    
    [self.billTextField addTarget:self action:@selector(textFieldUpdated) forControlEvents:UIControlEventEditingChanged];

}

- (void) textFieldUpdated {
    self.billTextField.textColor = [UIColor darkGrayColor];
    NSMutableString *billAmountString = [NSMutableString stringWithString:self.billTextField.text];
    [billAmountString replaceOccurrencesOfString:@"$" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0,billAmountString.length)];
     [billAmountString replaceOccurrencesOfString:@"." withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0,billAmountString.length)];
    
    float dollarAmount = [billAmountString doubleValue] * 0.01;
    
    self.billTextField.text = [NSString stringWithFormat:@"$%.2f", dollarAmount];
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) resetCalculator {
    [self.billTextField setText:@"$0.00"];

    self.tipLabel.text = @"$0.00";
    self.billTotal.text = @"$0.00";
    self.grandTotal.text = @"$0.00";
    
    [self.tipSlider setValue:20];
    [self.splitSlider setValue:1];
     self.billTextField.textColor = [UIColor lightGrayColor];
    
    [self.billTextField becomeFirstResponder];
    
    [self updateValues];
    
}
- (IBAction)clearAllTapped:(id)sender {
    [self resetCalculator];
}


- (void)updateValues {
    
    NSMutableString *billAmountString = [NSMutableString stringWithString:self.billTextField.text];
    [billAmountString replaceOccurrencesOfString:@"$" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0,billAmountString.length)];
        
    float billAmount = [billAmountString doubleValue];
    float tipPercentage = self.tipSlider.value * 0.01;
    float splitValue = self.splitSlider.value;
    
    float totalTip = billAmount * tipPercentage;
    float personalTip = totalTip / splitValue;
    float personalTotal = billAmount / splitValue;
    float grandTotal = personalTip + personalTotal;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", personalTip];
    
    self.billTotal.text = [NSString stringWithFormat:@"$%.2f", personalTotal];
    
    self.grandTotal.text = [NSString stringWithFormat:@"$%.2f", grandTotal];
    
    self.tipSliderLabel.text = [NSString stringWithFormat:@"TIP %.f%%", self.tipSlider.value];
    self.splitSliderLabel.text = [NSString stringWithFormat:@"%.f WAYS", self.splitSlider.value];
    if (self.splitSlider.value == 1.0) {
        self.splitSliderLabel.text = @"NO SPLIT";
    }
    if (self.splitSlider.value == 1.0) {
        self.perPersonLabel.hidden = true;
        
    }
    else
    {
        self.perPersonLabel.hidden = false;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"location: %i length: %i",range.location,range.length);
    
    return YES;
}
- (IBAction)splitSliderValueChanged:(id)sender {

    int newValue = (int)ceil(self.splitSlider.value);
    [self.splitSlider setValue:newValue animated:YES];
    
    [self updateValues];

}

- (IBAction)tipSliderValueChanged:(id)sender {
    
    int nextInteger = (int)ceil(self.tipSlider.value);
    int nextValue = 25;
    
    if (nextInteger <= 5) {
        nextValue = 0;
    }
    
    if (nextInteger > 5 && nextInteger <= 10) {
        nextValue = 5;
    }
    
    if (nextInteger > 10 && nextInteger <= 15) {
        nextValue = 10;
    }
    
    if (nextInteger > 15 && nextInteger <= 20) {
        nextValue = 15;
    }
    
    if (nextInteger > 20 && nextInteger < 25) {
        nextValue = 20;
    }
    
    
    [self.tipSlider setValue:nextValue animated:YES];
    

    
    [self updateValues];
}

@end
