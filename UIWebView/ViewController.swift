

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        loadURL("https://litpers.bidpropamkaltim.com")
    }

    private func loadURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            let req = URLRequest(url: url)
            webView.loadRequest(req)
        }
    }
}

// MARK: - Button Click

extension ViewController {

    @IBAction func backButtonClicked(_ sender: Any) {
        if webView.canGoBack {
            print("Back Success")
            webView.goBack()
        } else {
            print("Back Fail")
        }

    }

    @IBAction func reloadButtonClicked(_ sender: Any) {
        print("Reload")
        webView.reload()
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        if webView.canGoForward {
            print("Next Success")
            webView.goForward()
        } else {
            print("Next Fail")
        }
    }

    @IBAction func runJSButtonClicked(_ sender: Any) {
        print("Run JS")
        let js = "document.title;";
        let value = webView.stringByEvaluatingJavaScript(from: js)
        print(value)
    }
}

// MARK: - WebView

extension ViewController: UIWebViewDelegate {
    // các type tương ứng của navigationType
    /*
     public enum UIWebViewNavigationType : Int {


     case linkClicked

     case formSubmitted

     case backForward

     case reload

     case formResubmitted
     
     case other
     }
    */
    // request: là request hiện tại mà webView chuẩn bị thực hiện
    // webView sẽ chứa request của lần trước, ban đầu sẽ nil
    // return true sẽ thực hiện request, false thì không
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("1.1. shouldStartLoadWith navigationType ", navigationType.rawValue)
        print("1.2. shouldStartLoadWith request ", request.url?.absoluteString)
        print("1.3. shouldStartLoadWith webView ", webView.request?.url?.absoluteString)
        return true
    }
    // giống biến webView ở hàm shouldStartLoadWith
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("2. webViewDidStartLoad webView ", webView.request?.url?.absoluteString)
        indicator.startAnimating()
    }
    // webView chứa request ở shouldStartLoadWith sau khi thực hiện thành công
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("3. webViewDidFinishLoad webView ", webView.request?.url?.absoluteString)
        indicator.stopAnimating()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("4. didFailLoadWithError webView ", webView.request?.url?.absoluteString)
        indicator.stopAnimating()
    }
}
