//
//  AppDelegate.m
//  bitcoinPrice
//
//  Created by Kevin Mitchell on 7/16/15.
//  Copyright (c) 2015 Kevin Mitchell. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL buttonPressed;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getPrice) userInfo:nil repeats:YES];
   // [self getPrice];
    
                       
                       
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void)getPrice {
    NSURL *url = [NSURL URLWithString:@"https://api.coinbase.com/v1/prices/spot_rate"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error == nil) {
             NSDictionary *spotPrice = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             
             _statusItem.title = [[[spotPrice objectForKey:@"amount"] stringByAppendingString:@" "] stringByAppendingString:[spotPrice objectForKey:@"currency"]];
         }

     }];
}

@end
