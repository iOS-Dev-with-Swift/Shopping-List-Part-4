//
//  ViewController.swift
//  Shopping List Part 1
//
//  Created by LT Carbonell on 2/26/17.
//  Copyright © 2017 LT Carbonell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shoppingList: [String] = []
    let cellIdentifier = "cell"
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var newItem: UITextField!
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if defaults.object(forKey: "list") != nil {
            shoppingList = defaults.object(forKey: "list") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = shoppingList.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let item = shoppingList[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            shoppingList.remove(at: indexPath.row)
            defaults.setValue(shoppingList, forKey: "list")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = shoppingList[sourceIndexPath.row]
        shoppingList.remove(at: sourceIndexPath.row)
        shoppingList.insert(itemToMove, at: destinationIndexPath.row)
        defaults.set(shoppingList, forKey: "list")
    }
    
    @IBAction func addItem(_ sender: Any) {
        if newItem.text != "" {
            shoppingList.append(newItem.text!)
            defaults.set(shoppingList, forKey: "list")
            listTable.reloadData()
            newItem.text = ""
        }
        
    }
    
    @IBAction func editList(_ sender: Any) {
        listTable.isEditing = !listTable.isEditing
        if listTable.isEditing {
            (sender as AnyObject).setTitle("Done", for: .normal)
        }
        else {
            (sender as AnyObject).setTitle("Edit", for: .normal)
        }
    }
    
}

