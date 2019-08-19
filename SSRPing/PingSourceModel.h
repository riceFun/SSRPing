//
//  PingSourceModel.h
//  SSRPing
//
//  Created by riceFun on 2019/8/6.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PingSourceModel : NSObject

+ (NSArray *)handlePingSourceData;
    
+ (NSString *)sourceString;
@end

NS_ASSUME_NONNULL_END
