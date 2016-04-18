//
//  ViewController.m
//  Hangman
//
//  Created by Demond Childers on 4/14/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#pragma mark - Properties

//@property (nonatomic, weak)     IBOutlet UIImageView    *backgroundImageview;
//@property (nonatomic, strong)            NSArray        *hangmanImageArray;
@property (nonatomic, strong)            NSArray        *wordListArray;
@property (nonatomic, strong)            NSString       *currentWord;
@property (nonatomic, strong)            NSString       *correctLetter;
@property (nonatomic, strong)            NSString       *wrongLetter;
@property (nonatomic, strong)            NSArray        *hangmanImageArray;
@property (nonatomic, weak) IBOutlet UIImageView        *hangmanImageView;

@end

@implementation ViewController

#pragma mark - Global Variables

int failedAttemptCount = 0;
int currentImage = 0;

#pragma mark - Core Methods

- (NSString *)readBundleFileToString:(NSString *)filename ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

- (NSArray *)convertCSVStringToArray:(NSString *)csvString {
    NSString *cleanString = [[csvString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
    return [cleanString componentsSeparatedByCharactersInSet:set];
}

- (void)randomWords {
    long randomWordIndex = arc4random_uniform((uint32_t)_wordListArray.count);
    _currentWord = [_wordListArray[randomWordIndex] lowercaseString];
    NSLog(@"%@",_currentWord);
}

#pragma mark - Interactivity Methods

- (IBAction)newGameButtonPressed:(id)sender {
    NSLog(@"New Game");
    failedAttemptCount = 0;
    [self randomWords];
}

- (IBAction)letterPressed: (UIButton *)button {
    NSString *buttonLetter = [button.titleLabel.text lowercaseString];
    bool isFound = false;
    for (int i = 0; i < [_currentWord length]; i++) {
        NSString *currentLetter = [_currentWord substringWithRange:NSMakeRange(i, 1)];
        if ([currentLetter isEqualToString:buttonLetter]) {
            NSLog(@"Found an %@ at %i", buttonLetter,i);
            isFound = true;
        } else {
            NSLog(@"Didn't find an %@ at %i", buttonLetter,i);
        }
        
        
            if (currentImage < (_hangmanImageArray.count - 1)) {
                currentImage += 1;
            } else {
                currentImage = 0;
            }
        currentImage = arc4random_uniform((uint32_t)_hangmanImageArray.count);
        [_hangmanImageView setImage:[UIImage imageNamed:_hangmanImageArray[currentImage]]];
//Number of Tries
    if (!isFound) {
        failedAttemptCount++;
        NSLog(@"You Now Have %i Wrong",failedAttemptCount);
    } else {
        NSLog(@"Good Guess");
    }
    if (failedAttemptCount >= 10) {
        NSLog(@"Game Over");
    }
}



//if (_wordLabel.text == _currentWord) {
//    gameover = true;
//    [self disableAllLetters];
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Congratulations" message:@"You have won!" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:defaultAction];
//    UIAlertAction* newAction = [UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        [self startGame];
//    }];
//    [alert addAction:newAction];
//    [self presentViewController:alert animated:YES completion:nil];
//
#pragma mark - Life Cycle Methods

//
}

    @end

