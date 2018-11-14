#! /usr/bin/env octave 
# Reproduce the plots from https://arxiv.org/pdf/1202.3033.pdf . The paper
# should also be included in the same directory as this script.

1; # tell octave this is not a function file.

# N is used to control the 'width' of each spiral. Such that the width is 1/N.
# Increasing N causes the spiral to approach the Euler spiral.
function plot_spiral (N)
    # Define parametric equations for x and y coordinates
    x = @(t)  quad (@(u) cos (sqrt ((2 * pi * N) ^ 2 - u ^ 2)), 0, t);
    y = @(t) -quad (@(u) sin (sqrt ((2 * pi * N) ^ 2 - u ^ 2)), 0, t);

    # Range of t taken from the paper. Interval is arbitrary.
    t_bounds = t = [-2*pi*N : .1 : 2*pi*N];

    # Plot does not plot functions directly so, we must generate vectors for the
    # points we want to plot.
    xs = arrayfun(x, t_bounds);
    ys = arrayfun(y, t_bounds);

    # plot functions and write image to file.
    f = figure("visible", "off");
    plot(xs, ys);
    output_file = sprintf("peel_plot_%d.png", N);
    print(output_file, "-dpng");
endfunction

# Get N from command line args and call to spiral plotting function.
N = str2num(argv(){1});
plot_spiral(N);
