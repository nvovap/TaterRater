//
//  PotatoTasks.swift
//  TaterRater
//
//  Created by Vladimir Nevinniy on 10/3/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import CoreData



extension NSPersistentContainer {
  func importPotatoes() {
    // 1
    performBackgroundTask { context in
      // 2
      let request: NSFetchRequest<Potato> = Potato.fetchRequest()
      do {
        // 3
        if try context.count(for: request) == 0 {
          sleep(3)
          guard let spudsURL = Bundle.main.url(forResource: "Potatoes",
                                               withExtension: "txt") else { return }
          let spuds = try String(contentsOf: spudsURL)
          let spudList = spuds.components(separatedBy: .newlines)
          for spud in spudList {
            let potato = Potato(context: context)
            potato.variety = spud
            potato.crowdRating = Float(arc4random_uniform(50)) / Float(10)
          }
          try context.save()
        }
      } catch {
        print("Error importing potatoes: \(error.localizedDescription)")
      }
    } }
}
