当前cordova 版本6.5.0


```
cordova create Cordova_IOS_Version com.wdxxl.cordova HelloWorldApp
cd Cordova_IOS_Version
cordova platform add ios
```

```
cordova build
cordova emulate ios
cordova serve ios
```

```
双击打开HelloWorldApp.xcodeproj
修改Staging/www/下的 index.html
修改Staging下的 config.xml
在Plugins下创建 WdxxlSwiftPlugin.swift 并且选择创建 HelloWorldApp-Bridging-Header.h
```


index.html 内容
```
<html>
    <head>
        <title>口令验证</title>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <script type="text/javascript" charset="utf-8" src="cordova.js"></script>
        <script type="text/javascript" charset="utf-8">
            function verify(){
                var password = document.getElementById("pwd").value;
                Cordova.exec(successFunction, failFunction,
                             "WdxxlSwiftPlugin", "verifyPassword",[password]);
            }
        
            function successFunction(){
                alert("口令验证成功!");
            }
        
            function failFunction(message){
                alert("验证失败: " + message);
            }
        </script>
    </head>
    <body style="padding-top: 50px">
        <input type="text" id="pwd"/>
        <button onclick="verify();">验证</button>
    </body>
</html>
```

config.xml 内容
```
<feature name="WdxxlSwiftPlugin">
    <param name="ios-package" value="WSP_WdxxlSwiftPlugin" />
</feature>
```

WdxxlSwiftPlugin.swift 内容
```
import Foundation

@objc(WSP_WdxxlSwiftPlugin) class WdxxlSwiftPlugin : CDVPlugin {
    
    // 验证口令方法
    @objc(verifyPassword:)
    func verifyPassword(command:CDVInvokedUrlCommand) {
        // 返回结果
        var pluginResult:CDVPluginResult?
        // 获得参数
        let password = command.arguments[0] as? String
        
        // 开始验证
        if password == nil || password == "" {
            pluginResult = CDVPluginResult(status:CDVCommandStatus_ERROR,
                                           messageAs:"口令不能为空")
        } else if password != "wdxxl" {
            pluginResult = CDVPluginResult(status:CDVCommandStatus_ERROR,
                                           messageAs:"口令不正确")
        } else {
            pluginResult = CDVPluginResult(status:CDVCommandStatus_OK)
        }
        
        // 发送结果
        self.commandDelegate.send(pluginResult, callbackId:command.callbackId);
    }
}

```

HelloWorldApp-Bridging-Header.h 内容
```
#import <Cordova/CDV.h>
```
