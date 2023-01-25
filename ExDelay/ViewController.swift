//
//  ViewController.swift
//  ExDelay
//
//  Created by 김종권 on 2023/01/25.
//

import UIKit

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let tableView: HighlightedTableView = {
        let view = HighlightedTableView()
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.bounces = true
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        view.estimatedRowHeight = 34
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(button)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor),
        ])
        
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath)
        return cell
    }
}

final class HighlightedTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .grouped)
        
        delaysContentTouches = false
        canCancelContentTouches = true
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl {
            return true // enable drag
        }
        return super.touchesShouldCancel(in: view)
    }
}

final class TableViewCell: UITableViewCell {
    static let id = "TableViewCell"

    // MARK: UI
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    @objc private func didTap() {
        print("tap")
    }
}

