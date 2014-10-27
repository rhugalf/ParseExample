//
//  ViewController.m
//  ParseExample
//
//  Created by Hugo on 10/27/14.
//  Copyright (c) 2014 Hugo. All rights reserved.
//

#import "ParseViewController.h"
#import <Parse/Parse.h>

@interface ParseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property NSArray *people;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onAddPersonButtonTaped:(id)sender {
    PFObject *person = [PFObject objectWithClassName:@"Person"];
    
    person[@"name"] = @"Johnny La gente esta muy loca";
    person[@"age"] = @22;
    person[@"esPuto"] = @YES;
    
    [person saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error %@",[error userInfo]);
        }
        else{
            [self refreshDisplay];
        }
    }];
}

-(void)refreshDisplay{
    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error : %@",error.userInfo);
            self.people = [NSArray array];
        }else{
            self.people=objects;
            [self.tableView reloadData];
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    cell.textLabel.text =[self.people objectAtIndex:indexPath.row][@"name"];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.people.count;
}
@end
