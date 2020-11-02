//
//  TableViewController.swift
//  IRDb_Phase2
//
//  Created by Miranda Ramirez Cospin on 11/1/20.
//

import UIKit

class TableViewController: UITableViewController {

    var mediaModel: MediaDataModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Childhood TVshows"
        
        // 1
        let nav = self.navigationController?.navigationBar

        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.init(red: 32/255, green: 134/255, blue: 120/255, alpha: 1)
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 32/255, green: 134/255, blue: 120/255, alpha: 1)]
        
        // call my dataController and then wait
        dataController.getJSONData(completion: { dataModel in
            self.mediaModel = dataModel
        })
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return mediaModel?.TVShows.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaModel?.TVShows[section].show.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mediaModel?.TVShows[section].org
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = mediaModel?.TVShows[indexPath.section].show[indexPath.row].name
        
        cell.detailTextLabel?.text = mediaModel?.TVShows[indexPath.section].show[indexPath.row].rate
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showMediaDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedObject = mediaModel!.TVShows[indexPath.section].show[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = selectedObject
            }
        }
    }

}
