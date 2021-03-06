//
//  OCCrawlerCourseListingState.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerCourseListingState.h"
#import "OCJavascriptFunctions.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourseListingsViewController.h"
#import <SBJson.h>
#import "Course+CoreData.h"

@interface OCCrawlerCourseListingState()

@end

@implementation OCCrawlerCourseListingState

- (id)initWithWebview:(UIWebView *)webview
{
    self = [super init];
    if (self) {
        self.webviewCrawler = webview;
        self.webviewCrawler.delegate = self;
        [self loadRequest:@"https://www.coursera.org/"];
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    
    NSLog(@"request : %@",requestString);
    
    if ([requestString hasPrefix:@"js-frame:"]) {
        
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        
        NSString *function = (NSString*)[components objectAtIndex:1];
        if ([@"pageLoaded" isEqualToString:function]) {
            [self fetchAllCourse];
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsCallObjectiveCFunction]];
    [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] checkCourseLoaded]];
}

- (NSString *)executeJSFetchCourses
{
    return [self.webviewCrawler stringByEvaluatingJavaScriptFromString:[[OCJavascriptFunctions sharedInstance] jsFetchAllCourses]];
}

- (void)fetchAllCourse
{
    NSLog(@"fetching all course");
    NSString *jsonCourses = [self executeJSFetchCourses];
    NSArray *resArray = [jsonCourses JSONValue];

    //save to database
    [Course initCourses:resArray];
    [self broadcastFetchAllCoursesSuccessfully];
}

- (void)broadcastFetchAllCoursesSuccessfully
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FetchAllCoursesSuccessfully" object:nil];
}

@end
