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
