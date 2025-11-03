//Zglfw
//Mit License
//
//Copyright (C) 2020 Iridescence Technologies
//
//Permission Is Hereby Granted, Free Of Charge, To Any Person Obtaining A Copy
//Of This Software And Associated Documentation Files (The "Software"), To Deal
//In The Software Without Restriction, Including Without Limitation The Rights
//To Use, Copy, Modify, Merge, Publish, Distribute, Sublicense, And/Or Sell
//Copies Of The Software, And To Permit Persons To Whom The Software Is
//Furnished To Do So, Subject To The Following Conditions:
//
//The Above Copyright Notice And This Permission Notice Shall Be Included In All
//Copies Or Substantial Portions Of The Software.
//
//The Software Is Provided "As Is", Without Warranty Of Any Kind, Express Or
//Implied, Including But Not Limited To The Warranties Of Merchantability,
//Fitness For A Particular Purpose And Noninfringement. In No Event Shall The
//Authors Or Copyright Holders Be Liable For Any Claim, Damages Or Other
//Liability, Whether In An Action Of Contract, Tort Or Otherwise, Arising From,
//Out Of Or In Connection With The Software Or The Use Or Other Dealings In The
//Software.
//

//Glfw
//Copyright (C) 2002-2006 Marcus Geelnard
//
//Copyright (C) 2006-2019 Camilla Löwy
//
//This Software Is Provided 'As-Is', Without Any Express Or Implied
//Warranty. In No Event Will The Authors Be Held Liable For Any Damages
//Arising From The Use Of This Software.
//
//Permission Is Granted To Anyone To Use This Software For Any Purpose,
//Including Commercial Applications, And To Alter It And Redistribute It
//Freely, Subject To The Following Restrictions:
//
//1. The Origin Of This Software Must Not Be Misrepresented; You Must Not
//   Claim That You Wrote The Original Software. If You Use This Software
//   In A Product, An Acknowledgment In The Product Documentation Would
//   Be Appreciated But Is Not Required.
//
//2. Altered Source Versions Must Be Plainly Marked As Such, And Must Not
//   Be Misrepresented As Being The Original Software.
//
//3. This Notice May Not Be Removed Or Altered From Any Source
//   Distribution.
//------------------------------------------------------------------------
// HELPER
//------------------------------------------------------------------------
fn cIntCast(value: anytype) c_int { // taken from zig-gamedev's zglfw bindings
    const ValueType = @TypeOf(value);
    return switch (@typeInfo(ValueType)) {
        .int => @intCast(value),
        .@"enum", .enum_literal => @intFromEnum(value),
        .bool => @intFromBool(value),
        else => @compileError("Cannot cast " ++ @typeName(ValueType) ++ "to int."),
    };
}
//------------------------------------------------------------------------
// BINDINGS
//------------------------------------------------------------------------
const builtin = @import("builtin");

pub const VersionMajor = 3;
pub const VersionMinor = 4;
pub const VersionRevision = 0;

pub const KeyState = enum(c_int) {
    release = 0,
    press = 1,
    repeat = 2,
};

pub const JoystickHat = enum(c_int) {
    centered = 0,
    up = 1,
    right = 2,
    down = 4,
    left = 8,
    right_up = (2 | 1),
    right_down = (2 | 4),
    left_up = (8 | 1),
    left_down = (8 | 4),
};

pub const Key = enum(c_int) {
    unknown = -1,
    space = 32,
    apostrophe = 39,
    comma = 44,
    minus = 45,
    period = 46,
    slash = 47,
    num0 = 48,
    num1 = 49,
    num2 = 50,
    num3 = 51,
    num4 = 52,
    num5 = 53,
    num6 = 54,
    num7 = 55,
    num8 = 56,
    num9 = 57,
    semicolon = 59,
    equal = 61,
    a = 65,
    b = 66,
    c = 67,
    d = 68,
    e = 69,
    f = 70,
    g = 71,
    h = 72,
    i = 73,
    j = 74,
    k = 75,
    l = 76,
    m = 77,
    n = 78,
    o = 79,
    p = 80,
    q = 81,
    r = 82,
    s = 83,
    t = 84,
    u = 85,
    v = 86,
    w = 87,
    x = 88,
    y = 89,
    z = 90,
    left_bracket = 91,
    backslash = 92,
    right_bracket = 93,
    grave_accent = 96,
    world1 = 161,
    world2 = 162,
    escape = 256,
    enter = 257,
    tab = 258,
    backspace = 259,
    insert = 260,
    delete = 261,
    right = 262,
    left = 263,
    down = 264,
    up = 265,
    page_up = 266,
    page_down = 267,
    home = 268,
    end = 269,
    caps_lock = 280,
    scroll_lock = 281,
    num_lock = 282,
    print_screen = 283,
    pause = 284,
    f1 = 290,
    f2 = 291,
    f3 = 292,
    f4 = 293,
    f5 = 294,
    f6 = 295,
    f7 = 296,
    f8 = 297,
    f9 = 298,
    f10 = 299,
    f11 = 300,
    f12 = 301,
    f13 = 302,
    f14 = 303,
    f15 = 304,
    f16 = 305,
    f17 = 306,
    f18 = 307,
    f19 = 308,
    f20 = 309,
    f21 = 310,
    f22 = 311,
    f23 = 312,
    f24 = 313,
    f25 = 314,
    kp0 = 320,
    kp1 = 321,
    kp2 = 322,
    kp3 = 323,
    kp4 = 324,
    kp5 = 325,
    kp6 = 326,
    kp7 = 327,
    kp8 = 328,
    kp9 = 329,
    kp_decimal = 330,
    kp_divide = 331,
    kp_multiply = 332,
    kp_subtract = 333,
    kp_add = 334,
    kp_enter = 335,
    kp_equal = 336,
    left_shift = 340,
    left_control = 341,
    left_alt = 342,
    left_super = 343,
    right_shift = 344,
    right_control = 345,
    right_alt = 346,
    right_super = 347,
    menu = 348,
    last = 348,
};

pub const Modifiers = enum(c_int) {
    shift = 0x0001,
    control = 0x0002,
    alt = 0x0004,
    super = 0x0008,
    caps_lock = 0x0010,
    num_lock = 0x0020,
};

pub const MouseButton = enum(c_int) {
    one = 0,
    two = 1,
    three = 2,
    four = 3,
    five = 4,
    six = 5,
    seven = 6,
    eight = 7,
    last = 7,
    left = 0,
    right = 1,
    middle = 2,
};

pub const JoystickButton = enum(c_int) {
    one = 0,
    two = 1,
    three = 2,
    four = 3,
    five = 4,
    six = 5,
    seven = 6,
    eight = 7,
    nine = 8,
    ten = 9,
    eleven = 10,
    twelve = 11,
    thirteen = 12,
    fourteen = 13,
    fifteenth = 14,
    sixteen = 15,
    last = 15,
};

pub const GamepadButton = enum(c_int) {
    a = 0,
    b = 1,
    x = 2,
    y = 3,
    left_bumper = 4,
    right_bumper = 5,
    back = 6,
    start = 7,
    guide = 8,
    left_thumb = 9,
    cross = 0,
    circle = 1,
    square = 2,
    triangle = 3,
    right_thumb = 10,
    dpad_up = 11,
    dpad_right = 12,
    dpad_down = 13,
    dpad_left = 14,
    last = 14,
};

pub const GamepadAxis = enum(c_int) {
    left_x = 0,
    left_y = 1,
    right_x = 2,
    right_y = 3,
    left_trigger = 4,
    right_trigger = 5,
    last = 5,
};

pub const GLFWError = error{
    NotInitialized,
    NoCurrentContext,
    InvalidEnum,
    InvalidValue,
    OutOfMemory,
    APIUnavailable,
    VersionUnavailable,
    PlatformError,
    FormatUnavailable,
    NoWindowContext,
    NoError,
};

pub const ErrorCode = enum(c_int) {
    NotInitialized = 0x00010001,
    NoCurrentContext = 0x00010002,
    InvalidEnum = 0x00010003,
    InvalidValue = 0x00010004,
    OutOfMemory = 0x00010005,
    APIUnavailable = 0x00010006,
    VersionUnavailable = 0x00010007,
    PlatformError = 0x00010008,
    FormatUnavailable = 0x00010009,
    NoWindowContext = 0x0001000A,
    NoError = 0,
};

pub const WindowHint = enum(c_int) {
    focused = 0x00020001, //
    iconified = 0x00020002, //
    resizable = 0x00020003, //
    visible = 0x00020004, //
    decorated = 0x00020005, //
    auto_iconify = 0x00020006, //
    floating = 0x00020007, //
    maximized = 0x00020008, //
    center_cursor = 0x00020009, //
    transparent_framebuffer = 0x0002000a, //
    hovered = 0x0002000b, //
    focus_on_show = 0x0002000c, //
    red_bits = 0x00021001, //
    green_bits = 0x00021002, //
    blue_bits = 0x00021003, //
    alpha_bits = 0x00021004, //
    depth_bits = 0x00021005, //
    stencil_bits = 0x00021006, //
    accum_red_bits = 0x00021007, //
    accum_green_bits = 0x00021008, //
    accum_blue_bits = 0x00021009, //
    accum_alpha_bits = 0x0002100a, //
    aux_buffers = 0x0002100b, //
    stereo = 0x0002100c, //
    samples = 0x0002100d, //
    srgb_capable = 0x0002100e, //
    refresh_rate = 0x0002100f, //
    doublebuffer = 0x00021010, //
    client_api = 0x00022001, //
    context_version_major = 0x00022002, //
    context_version_minor = 0x00022003, //
    context_revision = 0x00022004, //
    context_robustness = 0x00022005, //
    opengl_forward_compat = 0x00022006, //
    opengl_debug_context = 0x00022007, //
    opengl_profile = 0x00022008, //
    context_release_behavior = 0x00022009, //
    context_no_error = 0x0002200a, //
    context_creation_api = 0x0002200b, //
    scale_to_monitor = 0x0002200c, //
    cocoa_retina_framebuffer = 0x00023001, //
    cocoa_frame_name = 0x00023002, //
    cocoa_graphics_switching = 0x00023003, //
    x11_class_name = 0x00024001,
    x11_instance_name = 0x00024002,

    pub fn ValueType(comptime hint: WindowHint) type {
        return switch (hint) {
            .resizable,
            .visible,
            .decorated,
            .focused,
            .auto_iconify,
            .floating,
            .maximized,
            .center_cursor,
            .transparent_framebuffer,
            .focus_on_show,
            .scale_to_monitor,

            .iconified,
            .hovered,
            .stereo,
            .srgb_capable,
            .doublebuffer,
            .opengl_forward_compat,
            .opengl_debug_context,
            .cocoa_retina_framebuffer,
            .cocoa_graphics_switching,
            .context_no_error,
            => bool,

            .red_bits,
            .green_bits,
            .blue_bits,
            .alpha_bits,
            .depth_bits,
            .stencil_bits,

            .accum_red_bits,
            .accum_green_bits,
            .accum_blue_bits,
            .accum_alpha_bits,

            .aux_buffers,
            .samples,

            .context_version_major,
            .context_version_minor,
            .context_revision,
            => c_int,

            .refresh_rate => c_int,
            .client_api => ClientAPIAttribute,
            .context_creation_api => ContextAPIAttribute,
            .context_robustness => RobustnessAttribute,
            .opengl_profile => GLProfileAttribute,
            .context_release_behavior => ReleaseBehaviorAttribute,

            .cocoa_frame_name,
            .x11_class_name,
            .x11_instance_name,
            => [:0]const u8,
        };
    }
};

pub const ClientAPIAttribute = enum(c_int) {
    no_api = 0,
    open_gl_api = 0x00030001,
    open_gles_api = 0x00030002,
};

pub const RobustnessAttribute = enum(c_int) {
    no_robustness = 0,
    no_reset_notification = 0x00031001,
    lose_context_on_reset = 0x00031002,
};

pub const GLProfileAttribute = enum(c_int) {
    any_profile = 0,
    core_profile = 0x00032001,
    compat_profile = 0x00032002,
};

pub const InputMode = enum(c_int) {
    cursor = 0x00033001,
    sticky_keys = 0x00033002,
    sticky_mouse_buttons = 0x00033003,
    lock_key_mods = 0x00033004,
    raw_mouse_motion = 0x00033005,
};

pub const CursorVisibilityAttribute = enum(c_int) {
    normal = 0x00034001,
    hidden = 0x00034002,
    disabled = 0x00034003,
};

pub const ReleaseBehaviorAttribute = enum(c_int) {
    any_release_behavior = 0,
    release_behavior_flush = 0x00035001,
    release_behavior_none = 0x00035002,
};

pub const ContextAPIAttribute = enum(c_int) {
    native_context_api = 0x00036001,
    egl_context_api = 0x00036002,
    osmesa_context_api = 0x00036003,
};

pub const PlatformHint = enum(c_int) {
    any = 0x00060000,
    win32 = 0x00060001,
    cocoa = 0x00060002,
    wayland = 0x00060003,
    x11 = 0x00060004,
    null = 0x00060005,
};

pub const VkInstance = usize;
pub const VkPhysicalDevice = usize;
pub const VkSurfaceKHR = u64;
pub const VkResult = enum(i32) {
    success = 0,
    not_ready = 1,
    timeout = 2,
    event_set = 3,
    event_reset = 4,
    incomplete = 5,
    error_out_of_host_memory = -1,
    error_out_of_device_memory = -2,
    error_initialization_failed = -3,
    error_device_lost = -4,
    error_memory_map_failed = -5,
    error_layer_not_present = -6,
    error_extension_not_present = -7,
    error_feature_not_present = -8,
    error_incompatible_driver = -9,
    error_too_many_objects = -10,
    error_format_not_supported = -11,
    error_fragmented_pool = -12,
    error_unknown = -13,
    error_out_of_pool_memory = -1000069000,
    error_invalid_external_handle = -1000072003,
    error_fragmentation = -1000161000,
    error_invalid_opaque_capture_address = -1000257000,
    pipeline_compile_required = 1000297000,
    error_surface_lost_khr = -1000000000,
    error_native_window_in_use_khr = -1000000001,
    suboptimal_khr = 1000001003,
    error_out_of_date_khr = -1000001004,
    error_incompatible_display_khr = -1000003001,
    error_validation_failed_ext = -1000011001,
    error_invalid_shader_nv = -1000012000,
    error_image_usage_not_supported_khr = -1000023000,
    error_video_picture_layout_not_supported_khr = -1000023001,
    error_video_profile_operation_not_supported_khr = -1000023002,
    error_video_profile_format_not_supported_khr = -1000023003,
    error_video_profile_codec_not_supported_khr = -1000023004,
    error_video_std_version_not_supported_khr = -1000023005,
    error_invalid_drm_format_modifier_plane_layout_ext = -1000158000,
    error_not_permitted_khr = -1000174001,
    error_full_screen_exclusive_mode_lost_ext = -1000255000,
    thread_idle_khr = 1000268000,
    thread_done_khr = 1000268001,
    operation_deferred_khr = 1000268002,
    operation_not_deferred_khr = 1000268003,
    error_invalid_video_std_parameters_khr = -1000299000,
    error_compression_exhausted_ext = -1000338000,
    error_incompatible_shader_binary_ext = 1000482000,
    _,
};

pub const VkSystemAllocationScope = enum(i32) {
    command = 0,
    object = 1,
    cache = 2,
    device = 3,
    instance = 4,
    _,
};

pub const VkInternalAllocationType = enum(i32) {
    executable = 0,
    _,
};

pub const vulkan_call_conv: std.builtin.CallingConvention = if (builtin.os.tag == .windows and builtin.cpu.arch == .x86)
    .Stdcall
else if (builtin.abi == .android and (builtin.cpu.arch.isARM() or builtin.cpu.arch.isThumb()) and std.Target.arm.featureSetHas(builtin.cpu.features, .has_v7) and builtin.cpu.arch.ptrBitWidth() == 32)
    // On Android 32-bit ARM targets, Vulkan functions use the "hardfloat"
    // calling convention, i.e. float parameters are passed in registers. This
    // is true even if the rest of the application passes floats on the stack,
    // as it does by default when compiling for the armeabi-v7a NDK ABI.
    .AAPCSVFP
else
    .c;

pub const VkAllocationCallbacks = extern struct {
    p_user_data: ?*anyopaque = null,
    pfn_allocation: ?*const fn (p_user_data: ?*anyopaque, size: usize, alignment: usize, allocation_scope: VkSystemAllocationScope) callconv(vulkan_call_conv) ?*anyopaque,
    pfn_reallocation: ?*const fn (p_user_data: ?*anyopaque, p_original: ?*anyopaque, size: usize, alignment: usize, allocation_scope: VkSystemAllocationScope) callconv(vulkan_call_conv) ?*anyopaque,
    pfn_free: ?*const fn (p_user_data: ?*anyopaque, p_memory: ?*anyopaque) callconv(vulkan_call_conv) void,
    pfn_internal_allocation: ?*const fn (p_user_data: ?*anyopaque, size: usize, allocation_type: VkInternalAllocationType, allocation_scope: VkSystemAllocationScope) callconv(vulkan_call_conv) void = null,
    pfn_internal_free: ?*const fn (p_user_data: ?*anyopaque, size: usize, allocation_type: VkInternalAllocationType, allocation_scope: VkSystemAllocationScope) callconv(vulkan_call_conv) void = null,
};

pub const DontCare: c_int = -1;

pub const CursorShape = enum(c_int) {
    arrow = 0x00036001,
    ibeam = 0x00036002,
    crosshair = 0x00036003,
    hand = 0x00036004,
    hresize = 0x00036005,
    vresize = 0x00036006,
};

pub const Connection = enum(c_int) {
    connected = 0x00040001,
    disconnected = 0x00040002,
};

pub const InitHint = enum(c_int) {
    joystick_hat_buttons = 0x00050001,
    cocoa_chdir_resources = 0x00051001,
    cocoa_menubar = 0x00051002,
};

pub const GLproc = *const fn () callconv(.c) void;
pub const VKproc = *const fn () callconv(.c) void;

pub const Monitor = c_long;
pub const Window = c_long;
pub const CursorHandle = c_long;

pub const ErrorFun = *const fn (error_code: c_int, description: [*:0]u8) callconv(.c) void;
pub const WindowPosFun = *const fn (window: *Window, xpos: c_int, ypos: c_int) callconv(.c) void;
pub const WindowSizeFun = *const fn (window: *Window, width: c_int, height: c_int) callconv(.c) void;
pub const WindowCloseFun = *const fn (window: *Window) callconv(.c) void;
pub const WindowRefreshFun = *const fn (window: *Window) callconv(.c) void;
pub const WindowFocusFun = *const fn (window: *Window, focused: c_int) callconv(.c) void;
pub const WindowIconifyFun = *const fn (window: *Window, iconified: c_int) callconv(.c) void;
pub const WindowMaximizeFun = *const fn (window: *Window, iconified: c_int) callconv(.c) void;
pub const FramebufferSizeFun = *const fn (window: *Window, width: c_int, height: c_int) callconv(.c) void;
pub const WindowContentScaleFun = *const fn (window: *Window, xscale: f32, yscale: f32) callconv(.c) void;

//Mods is bitfield of modifiers, button is enum of mouse buttons, and action is enum of keystates.
pub const MouseButtonFun = *const fn (window: *Window, button: c_int, action: c_int, mods: c_int) callconv(.c) void;
pub const CursorPosFun = *const fn (window: *Window, xpos: f64, ypos: f64) callconv(.c) void;

//Entered is true or false
pub const CursorEnterFun = *const fn (window: *Window, entered: c_int) callconv(.c) void;
pub const ScrollFun = *const fn (window: *Window, xoffset: f64, yoffset: f64) callconv(.c) void;

//Mods is bitfield of modifiers, keys is enum of keys, and action is enum of keystates.
pub const KeyFun = *const fn (window: *Window, key: c_int, scancode: c_int, action: c_int, mods: c_int) callconv(.c) void;
pub const CharFun = *const fn (window: *Window, codepoint: c_uint) callconv(.c) void;

//Mods refers to the bitfield of Modifiers
pub const CharmodsFun = *const fn (window: *Window, codepoint: c_uint, mods: c_int) callconv(.c) void;
pub const DropFun = *const fn (window: *Window, path_count: c_int, paths: [*:0]const u8) callconv(.c) void;

//Event is one of two states defined by the enum 'Connection'
pub const MonitorFun = *const fn (monitor: *Monitor, event: c_int) callconv(.c) void;

//Event is one of two states defined by the enum 'Connection'
pub const JoystickFun = *const fn (id: c_int, event: c_int) callconv(.c) void;

pub const Vidmode = extern struct {
    width: i32,
    height: i32,
    redBits: i32,
    greenBits: i32,
    blueBits: i32,
    refreshRate: i32,
};

pub const Gammaramp = extern struct { red: ?[*]u16, green: ?[*]u16, blue: ?[*]u16, size: u32 };

pub const Image = extern struct { width: i32, height: i32, pixels: ?[*]u8 };

pub const GamepadState = extern struct { buttons: [15]u8, axes: [6]f32 };

pub const NSWindow = *anyopaque;
pub const X11Display = *anyopaque;
pub const X11Window = u64;
pub const WLDisplay = *anyopaque;
pub const WLSurface = *anyopaque;
pub const HWND = *anyopaque;

extern fn glfwInit() c_int;

pub fn init() !void {
    if (glfwInit() != 1) {
        return GLFWError.PlatformError;
    }
}

extern fn glfwTerminate() void;
extern fn glfwGetError(description: ?[*:0]const u8) c_int;

fn errorCheck() !void {
    const code: ErrorCode = @enumFromInt(glfwGetError(null));
    const err = switch (code) {
        .NotInitialized => GLFWError.NotInitialized,
        .NoCurrentContext => GLFWError.NoCurrentContext,
        .InvalidEnum => GLFWError.InvalidEnum,
        .InvalidValue => GLFWError.InvalidValue,
        .OutOfMemory => GLFWError.OutOfMemory,
        .APIUnavailable => GLFWError.APIUnavailable,
        .VersionUnavailable => GLFWError.VersionUnavailable,
        .PlatformError => GLFWError.PlatformError,
        .FormatUnavailable => GLFWError.FormatUnavailable,
        .NoWindowContext => GLFWError.NoWindowContext,
        .NoError => GLFWError.NoError,
    };
    return err;
}

fn errorCheck2() void {
    errorCheck() catch |err| {
        if (err != GLFWError.NoError) {
            std.log.scoped(.zGLFW).err("{s}", .{@errorName(err)});
        }
    };
}

pub fn terminate() void {
    glfwTerminate();
    errorCheck2();
}

extern fn glfwInitHint(hint: c_int, value: c_int) void;
pub fn initHint(hint: InitHint, value: c_int) void {
    glfwInitHint(@intFromEnum(hint), value);
    errorCheck2();
}

extern fn glfwGetVersion(major: *c_int, minor: *c_int, rev: *c_int) void;
extern fn glfwGetVersionString() [*:0]const u8;
pub const getVersion = glfwGetVersion;
pub const getVersionString = glfwGetVersionString;

extern fn glfwSetErrorCallback(callback: ErrorFun) ErrorFun;
pub const setErrorCallback = glfwSetErrorCallback;

extern fn glfwGetMonitors(count: *c_int) ?[*]*Monitor;
pub fn getMonitors(count: *c_int) ?[*]*Monitor {
    const res = glfwGetMonitors(count);
    errorCheck2();
    return res;
}

extern fn glfwGetPrimaryMonitor() *Monitor;
pub fn getPrimaryMonitor() *Monitor {
    const res = glfwGetPrimaryMonitor();
    errorCheck2();
    return res;
}

extern fn glfwGetMonitorPos(monitor: ?*Monitor, xpos: ?*c_int, ypos: ?*c_int) void;
pub fn getMonitorPos(monitor: ?*Monitor, xpos: ?*c_int, ypos: ?*c_int) void {
    glfwGetMonitorPos(monitor, xpos, ypos);
    errorCheck2();
}

extern fn glfwGetMonitorWorkarea(monitor: ?*Monitor, xpos: ?*c_int, ypos: ?*c_int, width: ?*c_int, height: ?*c_int) void;
pub fn getMonitorWorkarea(monitor: ?*Monitor, xpos: ?*c_int, ypos: ?*c_int, width: ?*c_int, height: ?*c_int) void {
    glfwGetMonitorWorkarea(monitor, xpos, ypos, width, height);
    errorCheck2();
}

extern fn glfwGetMonitorPhysicalSize(monitor: ?*Monitor, widthMM: ?*c_int, heightMM: ?*c_int) void;
pub fn getMonitorPhysicalSize(monitor: ?*Monitor, widthMM: ?*c_int, heightMM: ?*c_int) void {
    glfwGetMonitorPhysicalSize(monitor, widthMM, heightMM);
    errorCheck2();
}

extern fn glfwGetMonitorContentScale(monitor: ?*Monitor, xscale: ?*f32, yscale: ?*f32) void;
pub fn getMonitorContentScale(monitor: ?*Monitor, xscale: ?*f32, yscale: ?*f32) void {
    glfwGetMonitorContentScale(monitor, xscale, yscale);
    errorCheck2();
}

extern fn glfwGetMonitorName(monitor: ?*Monitor) ?[*:0]const u8;
pub fn getMonitorName(monitor: ?*Monitor) ?[*:0]const u8 {
    const res = glfwGetMonitorName(monitor);
    errorCheck2();
    return res;
}

extern fn glfwSetMonitorUserPointer(monitor: ?*Monitor, pointer: ?*anyopaque) void;
pub fn setMonitorUserPointer(monitor: ?*Monitor, pointer: ?*anyopaque) void {
    glfwSetMonitorUserPointer(monitor, pointer);
    errorCheck2();
}

extern fn glfwGetMonitorUserPointer(monitor: ?*Monitor) ?*anyopaque;
pub fn getMonitorUserPointer(monitor: ?*Monitor) ?*anyopaque {
    const res = glfwGetMonitorUserPointer(monitor);
    errorCheck2();
    return res;
}

extern fn glfwSetMonitorCallback(callback: MonitorFun) MonitorFun;
pub fn setMonitorCallback(callback: MonitorFun) MonitorFun {
    const res = glfwSetMonitorCallback(callback);
    errorCheck2();
    return res;
}

extern fn glfwGetVideoModes(monitor: ?*Monitor, count: *c_int) ?[*]Vidmode;
pub fn getVideoModes(monitor: ?*Monitor, count: *c_int) ?[*]Vidmode {
    const res = glfwGetVideoModes(monitor, count);
    errorCheck2();
    return res;
}

extern fn glfwGetVideoMode(monitor: ?*Monitor) ?*Vidmode;
pub fn getVideoMode(monitor: ?*Monitor) ?*Vidmode {
    const res = glfwGetVideoMode(monitor);
    errorCheck2();
    return res;
}

extern fn glfwSetGamma(monitor: ?*Monitor, gamma: f32) void;
pub fn setGamma(monitor: ?*Monitor, gamma: f32) void {
    glfwSetGamma(monitor, gamma);
    errorCheck2();
}

extern fn glfwGetGammaRamp(monitor: ?*Monitor) ?*Gammaramp;
pub fn getGammaRamp(monitor: ?*Monitor) ?*Gammaramp {
    const res = glfwGetGammaRamp(monitor);
    errorCheck2();
    return res;
}

extern fn glfwSetGammaRamp(monitor: ?*Monitor, ramp: ?*Gammaramp) void;
pub fn setGammaRamp(monitor: ?*Monitor, ramp: ?*Gammaramp) void {
    glfwSetGammaRamp(monitor, ramp);
    errorCheck2();
}

extern fn glfwDefaultWindowHints() void;
pub fn defaultWindowHints() void {
    glfwDefaultWindowHints();
    errorCheck2();
}

extern fn glfwWindowHint(hint: c_int, value: c_int) void;
pub fn windowHint(comptime hint: WindowHint, value: WindowHint.ValueType(hint)) void {
    const ValueType = @TypeOf(value);
    switch (ValueType) {
        [:0]const u8 => windowHintString(hint, value),
        else => {
            glfwWindowHint(@intFromEnum(hint), cIntCast(value));
            errorCheck2();
        },
    }
}

extern fn glfwWindowHintString(hint: c_int, value: [*:0]const u8) void;
pub fn windowHintString(hint: WindowHint, value: [*:0]const u8) void {
    glfwWindowHintString(@intFromEnum(hint), value);
    errorCheck2();
}

extern fn glfwCreateWindow(width: c_int, height: c_int, title: [*:0]const u8, monitor: ?*Monitor, share: ?*Window) ?*Window;
pub fn createWindow(width: c_int, height: c_int, title: [*:0]const u8, monitor: ?*Monitor, share: ?*Window) !*Window {
    const res = glfwCreateWindow(width, height, title, monitor, share);
    errorCheck2();
    if (res == null) {
        return GLFWError.PlatformError;
    }
    return res.?;
}

extern fn glfwDestroyWindow(window: ?*Window) void;
pub fn destroyWindow(window: ?*Window) void {
    glfwDestroyWindow(window);
    errorCheck2();
}

extern fn glfwWindowShouldClose(window: ?*Window) c_int;
pub fn windowShouldClose(window: ?*Window) bool {
    const res = glfwWindowShouldClose(window);
    errorCheck2();
    return res != 0;
}

extern fn glfwSetWindowShouldClose(window: ?*Window, value: c_int) void;
pub fn setWindowShouldClose(window: ?*Window, value: bool) void {
    glfwSetWindowShouldClose(window, @intFromBool(value));
    errorCheck2();
}

extern fn glfwSetWindowTitle(window: ?*Window, title: [*:0]const u8) void;
pub fn setWindowTitle(window: ?*Window, title: [*:0]const u8) void {
    glfwSetWindowTitle(window, title);
    errorCheck2();
}

extern fn glfwSetWindowIcon(window: ?*Window, count: c_int, images: ?[*]Image) void;
pub fn setWindowIcon(window: ?*Window, count: c_int, images: ?[*]Image) void {
    glfwSetWindowIcon(window, count, images);
    errorCheck2();
}

extern fn glfwGetWindowPos(window: ?*Window, xpos: *c_int, ypos: *c_int) void;
pub fn getWindowPos(window: ?*Window, xpos: *c_int, ypos: *c_int) void {
    glfwGetWindowPos(window, xpos, ypos);
    errorCheck2();
}

extern fn glfwSetWindowPos(window: ?*Window, xpos: c_int, ypos: c_int) void;
pub fn setWindowPos(window: ?*Window, xpos: c_int, ypos: c_int) void {
    glfwSetWindowPos(window, xpos, ypos);
    errorCheck2();
}

extern fn glfwGetWindowSize(window: ?*Window, width: *c_int, height: *c_int) void;
pub fn getWindowSize(window: ?*Window, width: *c_int, height: *c_int) void {
    glfwGetWindowSize(window, width, height);
    errorCheck2();
}

extern fn glfwSetWindowSizeLimits(window: ?*Window, minwidth: c_int, minheight: c_int, maxwidth: c_int, maxheight: c_int) void;
pub fn setWindowSizeLimits(window: ?*Window, minwidth: c_int, minheight: c_int, maxwidth: c_int, maxheight: c_int) void {
    glfwSetWindowSizeLimits(window, minwidth, minheight, maxwidth, maxheight);
    errorCheck2();
}

extern fn glfwSetWindowAspectRatio(window: ?*Window, numer: c_int, denom: c_int) void;
pub fn setWindowAspectRatio(window: ?*Window, numer: c_int, denom: c_int) void {
    glfwSetWindowAspectRatio(window, numer, denom);
    errorCheck2();
}

extern fn glfwSetWindowSize(window: ?*Window, width: c_int, height: c_int) void;
pub fn setWindowSize(window: ?*Window, width: c_int, height: c_int) void {
    glfwSetWindowSize(window, width, height);
    errorCheck2();
}

extern fn glfwGetFramebufferSize(window: ?*Window, width: *c_int, height: *c_int) void;
pub fn getFramebufferSize(window: ?*Window, width: *c_int, height: *c_int) void {
    glfwGetFramebufferSize(window, width, height);
    errorCheck2();
}

extern fn glfwGetWindowFrameSize(window: ?*Window, left: *c_int, top: *c_int, right: *c_int, bottom: *c_int) void;
pub fn getWindowFrameSize(window: ?*Window, left: *c_int, top: *c_int, right: *c_int, bottom: *c_int) void {
    glfwGetWindowFrameSize(window, left, top, right, bottom);
    errorCheck2();
}

extern fn glfwGetWindowContentScale(window: ?*Window, xscale: *f32, yscale: *f32) void;
pub fn getWindowContentScale(window: ?*Window, xscale: *f32, yscale: *f32) void {
    glfwGetWindowContentScale(window, xscale, yscale);
    errorCheck2();
}

extern fn glfwGetWindowOpacity(window: ?*Window) f32;
pub fn getWindowOpacity(window: ?*Window) f32 {
    const res = glfwGetWindowOpacity(window);
    errorCheck2();
    return res;
}

extern fn glfwSetWindowOpacity(window: ?*Window, opacity: f32) void;
pub fn setWindowOpacity(window: ?*Window, opacity: f32) void {
    glfwSetWindowOpacity(window, opacity);
    errorCheck2();
}

extern fn glfwIconifyWindow(window: ?*Window) void;
pub fn iconifyWindow(window: ?*Window) void {
    glfwIconifyWindow(window);
    errorCheck2();
}

extern fn glfwRestoreWindow(window: ?*Window) void;
pub fn restoreWindow(window: ?*Window) void {
    glfwRestoreWindow(window);
    errorCheck2();
}

extern fn glfwMaximizeWindow(window: ?*Window) void;
pub fn maximizeWindow(window: ?*Window) void {
    glfwMaximizeWindow(window);
    errorCheck2();
}

extern fn glfwShowWindow(window: ?*Window) void;
pub fn showWindow(window: ?*Window) void {
    glfwShowWindow(window);
    errorCheck2();
}

extern fn glfwHideWindow(window: ?*Window) void;
pub fn hideWindow(window: ?*Window) void {
    glfwHideWindow(window);
    errorCheck2();
}

extern fn glfwFocusWindow(window: ?*Window) void;
pub fn focusWindow(window: ?*Window) void {
    glfwFocusWindow(window);
    errorCheck2();
}

extern fn glfwRequestWindowAttention(window: ?*Window) void;
pub fn requestWindowAttention(window: ?*Window) void {
    glfwRequestWindowAttention(window);
    errorCheck2();
}

extern fn glfwGetWindowMonitor(window: ?*Window) ?*Monitor;
pub fn getWindowMonitor(window: ?*Window) ?*Monitor {
    const res = glfwGetWindowMonitor(window);
    errorCheck2();
    return res;
}

extern fn glfwSetWindowMonitor(window: ?*Window, monitor: ?*Monitor, xpos: c_int, ypos: c_int, width: c_int, height: c_int, refreshRate: c_int) void;
pub fn setWindowMonitor(window: ?*Window, monitor: ?*Monitor, xpos: c_int, ypos: c_int, width: c_int, height: c_int, refreshRate: c_int) void {
    glfwSetWindowMonitor(window, monitor, xpos, ypos, width, height, refreshRate);
    errorCheck2();
}

extern fn glfwGetWindowAttrib(window: ?*Window, attrib: c_int) c_int;
pub fn getWindowAttrib(window: ?*Window, attrib: WindowHint) c_int {
    const res = glfwGetWindowAttrib(window, @intFromEnum(attrib));
    errorCheck2();
    return res;
}

extern fn glfwSetWindowAttrib(window: ?*Window, attrib: c_int, value: c_int) void;
pub fn setWindowAttrib(window: ?*Window, attrib: WindowHint, value: c_int) void {
    glfwSetWindowAttrib(window, @intFromEnum(attrib), value);
    errorCheck2();
}

extern fn glfwSetWindowUserPointer(window: ?*Window, pointer: *anyopaque) void;
pub fn setWindowUserPointer(window: ?*Window, pointer: *anyopaque) void {
    glfwSetWindowUserPointer(window, pointer);
    errorCheck2();
}

extern fn glfwGetWindowUserPointer(window: ?*Window) ?*anyopaque;
pub fn getWindowUserPointer(window: ?*Window) ?*anyopaque {
    const res = glfwGetWindowUserPointer(window);
    errorCheck2();
    return res;
}

extern fn glfwSetWindowPosCallback(window: ?*Window, callback: WindowPosFun) WindowPosFun;
extern fn glfwSetWindowSizeCallback(window: ?*Window, callback: WindowSizeFun) WindowSizeFun;
extern fn glfwSetWindowCloseCallback(window: ?*Window, callback: WindowCloseFun) WindowCloseFun;
extern fn glfwSetWindowRefreshCallback(window: ?*Window, callback: WindowRefreshFun) WindowRefreshFun;
extern fn glfwSetWindowFocusCallback(window: ?*Window, callback: WindowFocusFun) WindowFocusFun;
extern fn glfwSetWindowIconifyCallback(window: ?*Window, callback: WindowIconifyFun) WindowIconifyFun;
extern fn glfwSetWindowMaximizeCallback(window: ?*Window, callback: WindowMaximizeFun) WindowMaximizeFun;
extern fn glfwSetFramebufferSizeCallback(window: ?*Window, callback: FramebufferSizeFun) FramebufferSizeFun;
extern fn glfwSetWindowContentScaleCallback(window: ?*Window, callback: WindowContentScaleFun) WindowContentScaleFun;

pub fn setWindowPosCallback(window: ?*Window, callback: WindowPosFun) WindowPosFun {
    const res = glfwSetWindowPosCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowSizeCallback(window: ?*Window, callback: WindowSizeFun) WindowSizeFun {
    const res = glfwSetWindowSizeCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowCloseCallback(window: ?*Window, callback: WindowCloseFun) WindowCloseFun {
    const res = glfwSetWindowCloseCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowRefreshCallback(window: ?*Window, callback: WindowRefreshFun) WindowRefreshFun {
    const res = glfwSetWindowRefreshCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowFocusCallback(window: ?*Window, callback: WindowFocusFun) WindowFocusFun {
    const res = glfwSetWindowFocusCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowIconifyCallback(window: ?*Window, callback: WindowIconifyFun) WindowIconifyFun {
    const res = glfwSetWindowIconifyCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowMaximizeCallback(window: ?*Window, callback: WindowMaximizeFun) WindowMaximizeFun {
    const res = glfwSetWindowMaximizeCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setFramebufferSizeCallback(window: ?*Window, callback: FramebufferSizeFun) FramebufferSizeFun {
    const res = glfwSetFramebufferSizeCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setWindowContentScaleCallback(window: ?*Window, callback: WindowContentScaleFun) WindowContentScaleFun {
    const res = glfwSetWindowContentScaleCallback(window, callback);
    errorCheck2();
    return res;
}

extern fn glfwPollEvents() void;
pub fn pollEvents() void {
    glfwPollEvents();
    errorCheck2();
}

extern fn glfwWaitEvents() void;
pub fn waitEvents() void {
    glfwWaitEvents();
    errorCheck2();
}

extern fn glfwWaitEventsTimeout(timeout: f64) void;
pub fn waitEventsTimeout(timeout: f64) void {
    glfwWaitEventsTimeout(timeout);
    errorCheck2();
}

extern fn glfwPostEmptyEvent() void;
pub fn postEmptyEvent() void {
    glfwPostEmptyEvent();
    errorCheck2();
}

extern fn glfwGetInputMode(window: ?*Window, mode: c_int) c_int;
//Depending on what your input mode is, you can change to true/false or one of the attribute enums
pub fn getInputMode(window: ?*Window, mode: InputMode) c_int {
    const res = glfwGetInputMode(window, @intFromEnum(mode));
    errorCheck2();
    return res;
}

extern fn glfwSetInputMode(window: ?*Window, mode: c_int, value: c_int) void;
pub fn setInputMode(window: ?*Window, mode: InputMode, value: c_int) void {
    glfwSetInputMode(window, @intFromEnum(mode), value);
    errorCheck2();
}

extern fn glfwRawMouseMotionSupported() c_int;
pub fn rawMouseMotionSupported() bool {
    const res = glfwRawMouseMotionSupported();
    errorCheck2();
    return res != 0;
}

const std = @import("std");
extern fn glfwGetKeyName(key: c_int, scancode: c_int) ?[*:0]const u8;
pub fn getKeyName(key: Key, scancode: c_int) ?[:0]const u8 {
    const res = glfwGetKeyName(@intFromEnum(key), scancode);
    errorCheck2();
    return std.mem.spanZ(res);
}

extern fn glfwGetKeyScancode(key: c_int) c_int;
pub fn getKeyScancode(key: Key) c_int {
    const res = glfwGetKeyScancode(@intFromEnum(key));
    errorCheck2();
    return res;
}

extern fn glfwGetKey(window: ?*Window, key: c_int) c_int;
pub fn getKey(window: ?*Window, key: Key) KeyState {
    const res = glfwGetKey(window, @intFromEnum(key));
    errorCheck2();
    return @enumFromInt(res);
}

extern fn glfwGetMouseButton(window: ?*Window, button: c_int) c_int;
pub fn getMouseButton(window: ?*Window, button: MouseButton) KeyState {
    const res = glfwGetMouseButton(window, @intFromEnum(button));
    errorCheck2();
    return @enumFromInt(res);
}

extern fn glfwGetCursorPos(window: ?*Window, xpos: *f64, ypos: *f64) void;
pub fn getCursorPos(window: ?*Window, xpos: *f64, ypos: *f64) void {
    glfwGetCursorPos(window, xpos, ypos);
    errorCheck2();
}

extern fn glfwSetCursorPos(window: ?*Window, xpos: f64, ypos: f64) void;
pub fn setCursorPos(window: ?*Window, xpos: f64, ypos: f64) void {
    glfwSetCursorPos(window, xpos, ypos);
    errorCheck2();
}

extern fn glfwCreateCursor(image: ?*Image, xhot: c_int, yhot: c_int) ?*CursorHandle;
pub fn createCursor(image: ?*Image, xhot: c_int, yhot: c_int) ?*CursorHandle {
    const res = glfwCreateCursor(image, xhot, yhot);
    errorCheck2();
    return res;
}

extern fn glfwCreateStandardCursor(shape: c_int) ?*CursorHandle;
pub fn createStandardCursor(shape: CursorShape) ?*CursorHandle {
    const res = glfwCreateStandardCursor(@intFromEnum(shape));
    errorCheck2();
    return res;
}

extern fn glfwDestroyCursor(cursor: ?*CursorHandle) void;
pub fn destroyCursor(cursor: ?*CursorHandle) void {
    glfwDestroyCursor(cursor);
    errorCheck2();
}

extern fn glfwSetCursor(window: ?*Window, cursor: ?*CursorHandle) void;
pub fn setCursor(window: ?*Window, cursor: ?*CursorHandle) void {
    glfwSetCursor(window, cursor);
    errorCheck2();
}

extern fn glfwSetKeyCallback(window: ?*Window, callback: KeyFun) KeyFun;
extern fn glfwSetCharCallback(window: ?*Window, callback: CharFun) CharFun;
extern fn glfwSetCharModsCallback(window: ?*Window, callback: CharmodsFun) CharmodsFun;
extern fn glfwSetMouseButtonCallback(window: ?*Window, callback: MouseButtonFun) MouseButtonFun;
extern fn glfwSetCursorPosCallback(window: ?*Window, callback: CursorPosFun) CursorPosFun;
extern fn glfwSetCursorEnterCallback(window: ?*Window, callback: CursorEnterFun) CursorEnterFun;
extern fn glfwSetScrollCallback(window: ?*Window, callback: ScrollFun) ScrollFun;
extern fn glfwSetDropCallback(window: ?*Window, callback: DropFun) DropFun;

pub fn setKeyCallback(window: ?*Window, callback: KeyFun) KeyFun {
    const res = glfwSetKeyCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setCharCallback(window: ?*Window, callback: CharFun) CharFun {
    const res = glfwSetCharCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setCharModsCallback(window: ?*Window, callback: CharmodsFun) CharmodsFun {
    const res = glfwSetCharModsCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setMouseButtonCallback(window: ?*Window, callback: MouseButtonFun) MouseButtonFun {
    const res = glfwSetMouseButtonCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setCursorPosCallback(window: ?*Window, callback: CursorPosFun) CursorPosFun {
    const res = glfwSetCursorPosCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setCursorEnterCallback(window: ?*Window, callback: CursorEnterFun) CursorEnterFun {
    const res = glfwSetCursorEnterCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setScrollCallback(window: ?*Window, callback: ScrollFun) ScrollFun {
    const res = glfwSetScrollCallback(window, callback);
    errorCheck2();
    return res;
}
pub fn setDropCallback(window: ?*Window, callback: DropFun) DropFun {
    const res = glfwSetDropCallback(window, callback);
    errorCheck2();
    return res;
}

extern fn glfwJoystickPresent(jid: c_int) c_int;
pub fn joystickPresent(jid: c_int) bool {
    const res = glfwJoystickPresent(jid);
    errorCheck2();
    return res != 0;
}

extern fn glfwGetJoystickAxes(jid: c_int, count: *c_int) ?[*]const f32;
pub fn getJoystickAxes(jid: c_int, count: *c_int) ?[*]const f32 {
    const res = glfwGetJoystickAxes(jid, count);
    errorCheck2();
    return res;
}

extern fn glfwGetJoystickButtons(jid: c_int, count: *c_int) ?[*]const u8;
pub fn getJoystickButtons(jid: c_int, count: *c_int) ?[*]const u8 {
    const res = glfwGetJoystickButtons(jid, count);
    errorCheck2();
    return res;
}

extern fn glfwGetJoystickHats(jid: c_int, count: *c_int) ?[*]const u8;
pub fn getJoystickHats(jid: c_int, count: *c_int) ?[*]const u8 {
    const res = glfwGetJoystickHats(jid, count);
    errorCheck2();
    return res;
}

extern fn glfwGetJoystickName(jid: c_int) ?[*:0]const u8;
pub fn getJoystickName(jid: c_int) ?[*:0]const u8 {
    const res = glfwGetJoystickName(jid);
    errorCheck2();
    return res;
}

extern fn glfwGetJoystickGUID(jid: c_int) ?[*:0]const u8;
pub fn getJoystickGUID(jid: c_int) ?[*:0]const u8 {
    const res = glfwGetJoystickGUID(jid);
    errorCheck2();
    return res;
}

extern fn glfwSetJoystickUserPointer(jid: c_int, pointer: *anyopaque) void;
pub fn setJoystickUserPointer(jid: c_int, pointer: *anyopaque) void {
    const res = glfwSetJoystickUserPointer(jid, pointer);
    errorCheck2();
    return res;
}

extern fn glfwGetJoystickUserPointer(jid: c_int) *anyopaque;
pub fn getJoystickUserPointer(jid: c_int) *anyopaque {
    const res = glfwGetJoystickUserPointer(jid);
    errorCheck2();
    return res;
}

extern fn glfwJoystickIsGamepad(jid: c_int) c_int;
pub fn joystickIsGamepad(jid: c_int) c_int {
    const res = glfwJoystickIsGamepad(jid);
    errorCheck2();
    return res;
}

extern fn glfwSetJoystickCallback(callback: JoystickFun) JoystickFun;
pub fn setJoystickCallback(callback: JoystickFun) JoystickFun {
    const res = glfwSetJoystickCallback(callback);
    errorCheck2();
    return res;
}

extern fn glfwUpdateGamepadMappings(string: [*:0]const u8) c_int;
pub fn updateGamepadMappings(string: [*:0]const u8) c_int {
    const res = glfwUpdateGamepadMappings(string);
    errorCheck2();
    return res;
}

extern fn glfwGetGamepadName(jid: c_int) ?[*:0]const u8;
pub fn getGamepadName(jid: c_int) ?[*:0]const u8 {
    const res = glfwGetGamepadName(jid);
    errorCheck2();
    return res;
}

extern fn glfwGetGamepadState(jid: c_int, state: ?*GamepadState) c_int;
pub fn getGamepadState(jid: c_int, state: ?*GamepadState) c_int {
    const res = glfwGetGamepadState(jid, state);
    errorCheck2();
    return res;
}

extern fn glfwSetClipboardString(window: ?*Window, string: [*:0]const u8) void;
pub fn setClipboardString(window: ?*Window, string: [*:0]const u8) void {
    glfwSetClipboardString(window, string);
    errorCheck2();
}

extern fn glfwGetClipboardString(window: ?*Window) ?[*:0]const u8;
pub fn getClipboardString(window: ?*Window) ?[:0]const u8 {
    const res = glfwGetClipboardString(window);
    errorCheck2();
    return std.mem.spanZ(res);
}

extern fn glfwGetTime() f64;
pub fn getTime() f64 {
    const res = glfwGetTime();
    errorCheck2();
    return res;
}

extern fn glfwSetTime(time: f64) void;
pub fn setTime(time: f64) void {
    glfwSetTime(time);
    errorCheck2();
}

extern fn glfwGetTimerValue() u64;
pub fn getTimerValue() u64 {
    const res = glfwGetTimerValue();
    errorCheck2();
    return res;
}

extern fn glfwGetTimerFrequency() u64;
pub fn getTimerFrequency() u64 {
    const res = glfwGetTimerFrequency();
    errorCheck2();
    return res();
}

//Context
extern fn glfwMakeContextCurrent(window: ?*Window) void;
pub fn makeContextCurrent(window: ?*Window) void {
    glfwMakeContextCurrent(window);
    errorCheck2();
}

extern fn glfwGetCurrentContext() ?*Window;
pub fn getCurrentContext(window: ?*Window) ?*Window {
    const res = glfwGetCurrentContext(window);
    errorCheck2();
    return res;
}

extern fn glfwSwapBuffers(window: ?*Window) void;
pub fn swapBuffers(window: ?*Window) void {
    glfwSwapBuffers(window);
    errorCheck2();
}

extern fn glfwSwapInterval(interval: c_int) void;
pub fn swapInterval(interval: c_int) void {
    glfwSwapInterval(interval);
    errorCheck2();
}

//GL Stuff
extern fn glfwExtensionSupported(extension: [*:0]const u8) c_int;
pub fn extensionSupported(extension: [*:0]const u8) c_int {
    const res = glfwExtensionSupported(extension);
    errorCheck2();
    return res;
}

extern fn glfwGetProcAddress(procname: [*:0]const u8) ?GLproc;
pub fn getProcAddress(procname: [*:0]const u8) ?GLproc {
    const res = glfwGetProcAddress(procname);
    errorCheck2();
    return res;
}

//Vulkan stuff
extern fn glfwGetInstanceProcAddress(instance: VkInstance, procname: [*:0]const u8) ?VKproc;
pub fn getInstanceProcAddress(instance: VkInstance, procname: [*:0]const u8) ?VKproc {
    const res = glfwGetInstanceProcAddress(instance, procname);
    errorCheck2();
    return res;
}

extern fn glfwGetPhysicalDevicePresentationSupport(instance: VkInstance, device: VkPhysicalDevice, queuefamily: u32) c_int;
pub fn getPhysicalDevicePresentationSupport(instance: VkInstance, device: VkPhysicalDevice, queuefamily: u32) bool {
    const res = glfwGetPhysicalDevicePresentationSupport(instance, device, queuefamily);
    errorCheck2();
    return res != 0;
}

extern fn glfwCreateWindowSurface(instance: VkInstance, window: *Window, allocator: ?*const VkAllocationCallbacks, surface: *VkSurfaceKHR) VkResult;
pub fn createWindowSurface(instance: VkInstance, window: *Window, allocator: ?*const VkAllocationCallbacks, surface: *VkSurfaceKHR) VkResult {
    const res = glfwCreateWindowSurface(instance, window, allocator, surface);
    errorCheck2();
    return res;
}

extern fn glfwVulkanSupported() c_int;
pub fn vulkanSupported() bool {
    const res = glfwVulkanSupported();
    errorCheck2();
    return res != 0;
}

extern fn glfwGetRequiredInstanceExtensions(count: *u32) ?[*][*:0]const u8;
pub fn getRequiredInstanceExtensions(count: *u32) ?[*][*:0]const u8 {
    const res = glfwGetRequiredInstanceExtensions(count);
    errorCheck2();
    return res;
}

extern fn glfwGetCocoaWindow(window: *Window) ?NSWindow;
pub fn getCocoaWindow(window: *Window) ?NSWindow {
    const res = glfwGetCocoaWindow(window);
    errorCheck2();
    return res;
}

extern fn glfwGetX11Display() ?X11Display;
pub fn getX11Display() ?X11Display {
    const res = glfwGetX11Display();
    errorCheck2();
    return res;
}

extern fn glfwGetX11Window(window: *Window) ?X11Window;
pub fn getX11Window(window: *Window) ?X11Window {
    const res = glfwGetX11Window(window);
    errorCheck2();
    return res;
}

extern fn glfwGetWaylandDisplay() ?WLDisplay;
pub fn getWaylandDisplay() ?WLDisplay {
    const res = glfwGetWaylandDisplay();
    errorCheck2();
    return res;
}

extern fn glfwGetWaylandWindow(window: *Window) ?WLSurface;
pub fn getWaylandWindow(window: *Window) ?WLSurface {
    const res = glfwGetWaylandWindow(window);
    errorCheck2();
    return res;
}

extern fn glfwGetWin32Window(window: *Window) ?HWND;
pub fn getWin32Window(window: *Window) ?HWND {
    const res = glfwGetWin32Window(window);
    errorCheck2();
    return res;
}

extern fn glfwPlatformSupported(platform: c_int) c_int;
pub fn platformSupported(platform: PlatformHint) c_int {
    const res = glfwPlatformSupported(@intFromEnum(platform));
    errorCheck2();
    return res;
}

extern fn glfwGetPlatform() c_int;
pub fn getPlatform() PlatformHint {
    const res: PlatformHint = @enumFromInt(glfwGetPlatform());
    errorCheck2();
    return res;
}
