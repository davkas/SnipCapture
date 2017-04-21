					//
//  ToolContainer.m
//  Snip
//
//  Created by liyue on 15/2/5.
//  Copyright (c) 2015年 liyue. All rights reserved.
//

#import "ToolContainer.h"
#import "SnipUtil.h"

@interface ToolContainer ()
@property ImageButton *rectButton;
@property ImageButton *ellipseButton;
@property ImageButton *arrowButton;
@property ImageButton *cancelButton;
@property ImageButton *okButton;
@end

/**
 *  framework中的图片不能直接读取，需要获得路径之后，使用路径加载图片
 *
 *  @param filename 图片名称
 *
 *  @return 图片路径
 */
NSString* getImageBundlePath(NSString* filename) {
//    NSBundle *libBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle].privateFrameworksPath stringByAppendingPathComponent:@"SnipCapture.framework"]];
//    if (libBundle && filename) {
//        NSString *path = [libBundle pathForImageResource:filename];
//        //NSLog(@"%@", path);
//        return path;
//    }
//    return nil;
    NSString * path = [[NSBundle mainBundle] pathForResource:filename ofType:@"tiff"];
    return path;
}

@implementation ToolContainer

- (instancetype)init
{
    if (self = [super init]) {
        
        _rectButton = [SnipUtil createButton:[[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_rect_ineffect")] withAlternate:nil];
        _rectButton.tag = ActionShapeRect;

        _ellipseButton = [SnipUtil createButton:[[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_ellipse_ineffect")] withAlternate:nil];
        _ellipseButton.tag = ActionShapeEllipse;

        _arrowButton = [SnipUtil createButton:[[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_arrow_ineffect")] withAlternate:nil];
        _arrowButton.tag = ActionShapeArrow;

        _cancelButton = [SnipUtil createButton:[[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_cross_normal")] withAlternate:nil];
        _cancelButton.tag = ActionCancel;

        _okButton = [SnipUtil createButton:[[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_tick_normal")] withAlternate:nil];
        _okButton.tag = ActionOK;

        _rectButton.target = self;
        _rectButton.action = @selector(onToolClick:);
        _ellipseButton.target = self;
        _ellipseButton.action = @selector(onToolClick:);
        _arrowButton.target = self;
        _arrowButton.action = @selector(onToolClick:);
        _cancelButton.target = self;
        _cancelButton.action = @selector(onToolClick:);
        _okButton.target = self;
        _okButton.action = @selector(onToolClick:);

        [self addSubview:_rectButton];
        [self addSubview:_ellipseButton];
        [self addSubview:_arrowButton];
        [self addSubview:_cancelButton];
        [self addSubview:_okButton];
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:3 yRadius:3];
    [bgPath setClip];
    [[NSColor colorWithCalibratedWhite:0.0 alpha:0.8f] setFill];
    NSRectFill(self.bounds);
    // Drawing code here.
}

- (void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    int step = 35;
    int margin = 10;
    [self.rectButton setFrame:NSMakeRect(margin, 0, 28, 26)];
    [self.ellipseButton setFrame:NSMakeRect(margin+step * 1, 0, 28, 26)];
    [self.arrowButton setFrame:NSMakeRect(margin+step * 2, 0, 28, 26)];
    [self.cancelButton setFrame:NSMakeRect(margin+step * 3, 0, 28, 26)];
    [self.okButton setFrame:NSMakeRect(margin+step * 4, 0, 28, 26)];

}

- (void)onToolClick:(NSControl *)sender
{
    //need refactor
    if (sender == self.rectButton) {
        self.rectButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_rect_effect")];
        self.ellipseButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_ellipse_ineffect")];
        self.arrowButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_arrow_ineffect")];
    }
    else if (sender == self.ellipseButton) {
        self.rectButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_rect_ineffect")];
        self.ellipseButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_ellipse_effect")];
        self.arrowButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_arrow_ineffect")];
    }
    else if (sender == self.arrowButton) {
        self.rectButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_rect_ineffect")];
        self.ellipseButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_ellipse_ineffect")];
        self.arrowButton.image = [[NSImage alloc] initWithContentsOfFile:getImageBundlePath(@"ScreenCapture_toolbar_arrow_effect")];
    }
    if (self.toolClick) {
        self.toolClick([sender tag]);
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
}

@end
