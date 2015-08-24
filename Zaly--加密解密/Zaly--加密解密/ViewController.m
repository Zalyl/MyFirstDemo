//
//  ViewController.m
//  Zaly--加密解密
//
//  Created by 张玉 on 15/8/24.
//  Copyright (c) 2015年 ZY. All rights reserved.
//....

#import "ViewController.h"
#import "CryptorTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self RSADemo];
    [self AESDemo];
    
    
}
-(void)RSADemo{
    CryptorTools *tools = [[CryptorTools alloc]init];
    //加载公钥
    NSString *pubPath = [[NSBundle mainBundle] pathForResource:@"rsacert.der" ofType:nil];
    [tools loadPublicKeyWithFilePath:pubPath];
    
    // 1. 使用公钥加密
    NSString *result = [tools RSAEncryptString:@"i love u"];
    NSLog(@"%@",result);
    
    // 2. 加载私钥 － 密码是导出 p12 的密码
    NSString *privatePath = [[NSBundle mainBundle]pathForResource:@"p.p12" ofType:nil];
    [tools loadPrivateKey:privatePath password:@"123456"];
    
    
    // 3. 使用私钥解密
    NSLog(@"%@",[tools RSADecryptString:result]);
    
    
    
}
-(void)AESDemo{
    // ECB
    NSString *key = @"Zayl";
    NSString *str = @"i love u";
    NSString *result = [CryptorTools AESEncryptString:str keyString:key iv:nil];
    NSLog(@"ECB 加密%@", result);
    NSLog(@"ECB 解密%@", [CryptorTools AESDecryptString:result keyString:key iv:nil]);
    
    
    // CBC
    uint8_t iv[3] = {1,2,3};
    NSData *ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    NSString *result1 = [CryptorTools AESEncryptString:str keyString:key iv:ivData];
    NSLog(@"CBC 加密%@", result1);
    NSLog(@"CBC 解密%@",[CryptorTools AESDecryptString:str keyString:key iv:ivData]);
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
