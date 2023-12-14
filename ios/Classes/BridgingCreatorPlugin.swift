import Flutter
import UIKit
import SuperwallKit

protocol Bridgeable {
  static var name: String { get }
}

/// Creates a method channel for a particular unique instance of a class
public class BridgingCreatorPlugin: NSObject, FlutterPlugin {
  // TODO: CHANGE
  static var shared: BridgingCreatorPlugin!

  private let registrar: FlutterPluginRegistrar
  private var instances: [String: Any] = [:]

  init(registrar: FlutterPluginRegistrar) {
    self.registrar = registrar
  }

  func bridge<T>(for channelName: String) -> T? {
    return instances[channelName] as? T
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "SWK_BridgingCreatorPlugin", binaryMessenger: registrar.messenger())

    let plugin = BridgingCreatorPlugin(registrar: registrar)
    BridgingCreatorPlugin.shared = plugin

    registrar.addMethodCallDelegate(plugin, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "createSuperwallPlugin":
        result(createSuperwallPlugin())
      case "createSuperwallDelegateProxyPlugin":
        result(createSuperwallDelegateProxyPlugin())
      case "createPurchaseControllerProxyPlugin":
        result(createPurchaseControllerProxyPlugin())
      case "createCompletionBlockProxyBridge":
        result(createCompletionBlockProxyBridge())
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}

extension BridgingCreatorPlugin {
  func createSuperwallPlugin() -> String {
    let name = "\(SuperwallPlugin.name)-\(UUID().uuidString)"
    let channel = FlutterMethodChannel(name: name, binaryMessenger: registrar.messenger())

    let plugin = SuperwallPlugin(channel: channel)
    instances.updateValue(plugin, forKey: name)

    registrar.addMethodCallDelegate(plugin, channel: channel)

    return name
  }
}

extension BridgingCreatorPlugin {
  func createSuperwallDelegateProxyPlugin() -> String {
    let name = "\(SuperwallDelegateProxyPlugin.name)-\(UUID().uuidString)"
    let channel = FlutterMethodChannel(name: name, binaryMessenger: registrar.messenger())

    let plugin = SuperwallDelegateProxyPlugin(channel: channel)
    instances.updateValue(plugin, forKey: name)

    registrar.addMethodCallDelegate(plugin, channel: channel)

    return name
  }
}

extension BridgingCreatorPlugin {
  func createPurchaseControllerProxyPlugin() -> String {
    let name = "\(PurchaseControllerProxyPlugin.name)-\(UUID().uuidString)"
    let channel = FlutterMethodChannel(name: name, binaryMessenger: registrar.messenger())

    let plugin = PurchaseControllerProxyPlugin(channel: channel)
    instances.updateValue(plugin, forKey: name)

    registrar.addMethodCallDelegate(plugin, channel: channel)

    return name
  }
}

extension BridgingCreatorPlugin {
  func createCompletionBlockProxyBridge() -> String {
    let name = "\(CompletionBlockProxyBridge.name)-\(UUID().uuidString)"
    let channel = FlutterMethodChannel(name: name, binaryMessenger: registrar.messenger())

    let plugin = CompletionBlockProxyBridge(channel: channel)
    instances.updateValue(plugin, forKey: name)

    registrar.addMethodCallDelegate(plugin, channel: channel)

    return name
  }
}