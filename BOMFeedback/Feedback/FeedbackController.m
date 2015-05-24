//
//  FeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 19.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "FeedbackController.h"
#import "AbstractFeedbackViewController.h"

@interface FeedbackController ()

@end

@implementation FeedbackController

- (instancetype) init {
	if ((self = [super init])) {
		[self setup];
	}
	return self;
}

- (void) setup {
	NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Feedback" ofType:@"plist"]];
	if (!config) {
#ifdef DEBUG
		NSAssert(config, @"Feedback.plist missing");
#endif
		return;
	}

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:nil];
	NSMutableArray *viewControllers = [@[] mutableCopy];
	for (NSDictionary *module in config[@"modules"]) {
		NSString *controllerName = [NSString stringWithFormat:@"%@FeedbackViewController", [module[@"name"] capitalizedString]];
		AbstractFeedbackViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:controllerName];
		if (viewController) {
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
			navigationController.view.backgroundColor = [UIColor whiteColor];
			viewController.setupDict = module;
			[viewControllers addObject:navigationController];
		}
	}
	self.viewControllers = viewControllers;
	self.selectedIndex = 0;
}

@end
