//
//  AppInfoViewController.swift
//  Skill Shot
//
//  Created by Will Clarke on 12/31/15.
//
//

import UIKit

class AppInfoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            guard let info = Bundle.main.infoDictionary, let version = info["CFBundleShortVersionString"] as? String,
                let build = info["CFBundleVersion"] as? String else
            {
                return super.tableView(tableView, titleForFooterInSection: section)
            }
            return "Version \(version) (\(build))"
        } else {
            return super.tableView(tableView, titleForFooterInSection: section)
        }
    }

    // MARK: - IBActions

    @IBAction func doneButtonTapped(_ sender: AnyObject) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func iconsButtonTapped(_ sender: AnyObject) {
        if let webURL = URL(string: "https://icons8.com") {
            UIApplication.shared.open(webURL, options: [String : Any](), completionHandler: nil)
        }
    }
    
    @IBAction func alamofireButtonTapped(_ sender: AnyObject) {
        if let webURL = URL(string: "https://github.com/Alamofire/Alamofire") {
            UIApplication.shared.open(webURL, options: [String : Any](), completionHandler: nil)
        }
    }
    
    @IBAction func willClarkeButtonTapped(_ sender: AnyObject) {
        if let willClarkeURL = URL(string: "fb://profile/12801403") {
            if UIApplication.shared.canOpenURL(willClarkeURL) {
                UIApplication.shared.open(willClarkeURL, options: [String : Any](), completionHandler: nil)
            } else if let willClarkeWebURL = URL(string: "http://facebook.com/willclarkedotnet") {
                UIApplication.shared.open(willClarkeWebURL, options: [String : Any](), completionHandler: nil)
            }
        }
    }
}
