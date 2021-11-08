import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';




class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final  _webViewPlugin = FlutterWebviewPlugin();
  @override
  void initState() {
    // TODO: implement initState
    disableCapture();
    super.initState();
    _webViewPlugin.onDestroy.listen((_) {
      if (Navigator.canPop(context)) {
        // exiting the screen
        Navigator.of(context).pop();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope (
        child: WebviewScaffold(
          url: "https://abraj-stars.actor/?student",
          withZoom: false,
          withLocalStorage: true,
          withJavascript: true,
          appCacheEnabled: true,
        ),
        onWillPop: () async {
          bool? result= await _webViewPlugin.close();
          if(result == null){
            result = false;
          }
          return result;
        },
      );
  }
  Future disableCapture() async {
    //disable screenshots and record screen in current screen
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

}

