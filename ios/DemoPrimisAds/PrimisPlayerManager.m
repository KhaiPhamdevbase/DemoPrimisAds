// PrimisPlayerManager.m
 
#import <React/RCTViewManager.h>
#import <PrimisPlayer/PrimisPlayer-Swift.h>
 
 
@interface PrimisPlayerManager : RCTViewManager
@end
 
 
@implementation PrimisPlayerManager
 
RCT_EXPORT_MODULE(PrimisPlayerMAP)
 
PrimisPlayer *player;
 
- (UIView *)view {
  // 1. Create a view to contain the player
  // 2. Create Primis player and add its view to the container
  // 3. Return the container
  UIView* container = [self setupContainerView];
  [self setupPrimisPlayer: container];
  return container;
}
 
- (UIView *)setupContainerView {
  // The container width is [window's width - padding]
  // Padding is same as paddingHorizontal for sectionContainer in App.js
  // The container height will be updated later by the player
  int paddingHorizontal = 24*2;
  int width = [[[UIApplication sharedApplication] delegate] window].frame.size.width - paddingHorizontal;
  
  UIView *view = [[UIView alloc] init];
  view.translatesAutoresizingMaskIntoConstraints = NO;
  [view.widthAnchor constraintEqualToConstant: width].active = YES;
  [view.heightAnchor constraintEqualToConstant: 0].active = YES;
  return view;
}
 
- (void)setupPrimisPlayer: (UIView *)container {
  // Create Primis player and configure it
  player = [[PrimisPlayer alloc] init];
  [player configure: @{
    @(PrimisConfigKeyPlacementId): @(YOUR_PLACEMENT_ID_STRING),
    @(PrimisConfigKeyContainerView): container,
    @(PrimisConfigKeyDebugLogActive): @YES,
  }];
  // Add Primis player to the react-native view controller
  UIViewController *rnVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  [player addTo: rnVC];
}
 
- (void)dealloc {
  [player remove];
  player = nil;
}
 
@end
