//
//  ChatServer.m
//  SocketServer
//
//  Created by ZXJ on 2017/4/29.
//  Copyright © 2017年 maodenden. All rights reserved.
//

#import "ChatServer.h"
#import "GCDAsyncSocket.h"

#define PORT 9090

@interface ChatServer ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) GCDAsyncSocket *socket;
//@property (nonatomic, strong) dispat
@property (nonatomic, strong) NSMutableArray *socketMutableArray;
@end

@implementation ChatServer

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)start {
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    NSError *error;
    [self.socket acceptOnPort:PORT error:&error];
    
    if (error) {
        
    }
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    [self.socketMutableArray addObject:newSocket];
    [newSocket readDataWithTimeout:-1 tag:100];
    NSLog(@"------------%@", newSocket);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    [sock readDataWithTimeout:-1 tag:100];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    NSLog(@"------------%@==", string);
    [sock writeData:data withTimeout:-1 tag:100];
    
    if ([string isEqualToString:@"^]"]) {
        [sock disconnect];
        [self.socketMutableArray removeObject:sock];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)socketMutableArray {
    if (_socketMutableArray == nil) {
        _socketMutableArray = [NSMutableArray array];
    }
    return _socketMutableArray;
}
@end
