//
//  main.m
//  SocketServer
//
//  Created by ZXJ on 2017/4/29.
//  Copyright © 2017年 maodenden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatServer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        ChatServer *cs = [[ChatServer alloc] init];
        [cs start];
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
