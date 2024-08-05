const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() == .leak) @panic("leak");

    const alloc = gpa.allocator();

    const argv = [_][]const u8{ "python", "rbexp.py" };
    var proc = std.process.Child.init(&argv, alloc);
    try proc.spawn();
    proc.stdin_behavior = .Ignore;
    proc.stdout_behavior = .Ignore;
    proc.stderr_behavior = .Ignore;

    std.debug.print("Spawned process PID={}\n", .{proc.id});

    _ = try proc.wait();
}