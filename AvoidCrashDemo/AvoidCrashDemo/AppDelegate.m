//
//  AppDelegate.m
//  AvoidCrashDemo
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "AppDelegate.h"

#import "AvoidCrash.h"
#import "NSArray+AvoidCrash.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

// 全局异常处理
void RegisterExceptionHandler(void) {
    NSSetUncaughtExceptionHandler(&HandleException);
}

void HandleException(NSException *exception) {
    // 解析并注册需要防护的类
    [AvoidCrash registerProtectedClassFromException:exception];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册异常处理器 --- Haomissyou 2025-05-09 10:56:51
    RegisterExceptionHandler();
    
    // 清空持久化防护的类，根据需求，调用
    //[AvoidCrash resetPersistedProtectedClasses];
    
    /*
     *  [AvoidCrash becomeEffective]、[AvoidCrash makeAllEffective]
     *  是全局生效。若你只需要部分生效，你可以单个进行处理，比如:
     *  [NSArray avoidCrashExchangeMethod];
     *  [NSMutableArray avoidCrashExchangeMethod];
     *  .................
     *  .................
     */
    
    
    
    //启动防止崩溃功能(注意区分becomeEffective和makeAllEffective的区别)
    //具体区别请看 AvoidCrash.h中的描述
    //建议在didFinishLaunchingWithOptions最初始位置调用 上面的方法
    
    [AvoidCrash makeAllEffective];
    
    
    //注意:⚠️
    //setupNoneSelClassStringsArr:和setupNoneSelClassStringPrefixsArr:
    //可以同时配合使用
    
    
    
    //=============================================
    //   1、unrecognized selector sent to instance
    //=============================================
    
    //若出现unrecognized selector sent to instance并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString
    
    NSArray *noneSelClassStrings = @[
                                     @"NSString"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    
    //=============================================
    //   2、unrecognized selector sent to instance
    //=============================================
    
    //若需要防止某个前缀的类的unrecognized selector sent to instance
    //比如AvoidCrashPerson
    //你可以调用如下方法
    NSArray *noneSelClassPrefix = @[
                                    @"AvoidCrash"
                                    ];
    [AvoidCrash setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
    
    
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    return YES;
}




- (void)dealwithCrashMessage:(NSNotification *)note {
    //不论在哪个线程中导致的crash，这里都是在主线程
    
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    //详细讲解请查看 https://github.com/chenfanfang/AvoidCrash
}


@end

/*
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[1]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSConstantArray objectAtIndexedSubscript:]: index 100 beyond bounds [0 .. 1]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSArray objectsAtIndexes:]: index 100 in index set beyond bounds [0 .. 1]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSConstantArray getObjects:range:]: range {0, 11} extends beyond bounds [0 .. 2]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM objectAtIndexedSubscript:]: index 2 beyond bounds [0 .. 0]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM setObject:atIndexedSubscript:]: index 3 beyond bounds [0 .. 0]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM removeObjectsInRange:]: range {5, 1} extends beyond bounds [0 .. 1]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM insertObject:atIndex:]: index 5 beyond bounds [0 .. 0]'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM getObjects:range:]: range {0, 11} extends beyond bounds [0 .. 1]'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1]'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSDictionaryM setObject:forKeyedSubscript:]: key cannot be nil'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSDictionaryM setObject:forKey:]: key cannot be nil'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSDictionaryM removeObjectForKey:]: key cannot be nil'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFConstantString characterAtIndex:]: Range or index out of bounds'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFConstantString characterAtIndex:]: Range or index out of bounds'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSCFConstantString substringFromIndex:]: Index 100 out of bounds; string length 11'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSCFConstantString substringToIndex:]: Index 100 out of bounds; string length 11'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFConstantString substringWithRange:]: Range {0, 100} out of bounds; string length 11'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSCFConstantString stringByReplacingOccurrencesOfString:withString:options:range:]: nil argument'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFString replaceOccurrencesOfString:withString:options:range:]: Range {0, 1000} out of bounds; string length 11'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFString replaceCharactersInRange:withString:]: Range or index out of bounds'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFString replaceCharactersInRange:withString:]: Range or index out of bounds'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFString insertString:atIndex:]: Range or index out of bounds'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFString deleteCharactersInRange:]: Range or index out of bounds'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'NSConcreteAttributedString initWithString:: nil value'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'NSConcreteAttributedString initWithString:: nil value'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'NSConcreteAttributedString initWithString:: nil value'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'NSConcreteMutableAttributedString initWithString:: nil value'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'NSConcreteMutableAttributedString initWithString:attributes:: nil value'
 *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<UITableView 0x10302ec00> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key AvoidCrash.'
 *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<UITableView 0x104018000> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key AvoidCrash.'
 *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<UITableView 0x10982a200> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key name.'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFConstantString sleep]: unrecognized selector sent to instance 0x102d2c0f0'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[Dog objectForKey:]: unrecognized selector sent to instance 0x6000000142f0'
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[Dog sleep]: unrecognized selector sent to instance 0x60000000c0f0'
 *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSConstantArray getObjects:range:]: range {0, 11} extends beyond bounds [0 .. 2]'
 */

