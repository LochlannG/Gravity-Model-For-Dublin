%% Population/Distance Gravity Model Greater Dublin Area
% Reads in an editted census spreadsheet and uses that to calculate a
% population & distance gravity model of Dublin and it's surrounding
% towns. To use please replace values in the 'GDA.csv' spreadsheet with
% corresponding values for your study area. Column names should remain the
% same but as many rows can be added as you wish.
%
% Version:  1.0
% Author:   Lochlann

clc; clear; close all;

% Parameters for user to control aspects of model
param           = struct();
param.gravPower = 2;
param.fileName  = "GDA.csv";

% Read & parse in all the data
GDAdata         = readtable(param.fileName);
s               = ones(height(GDAdata)-1, 1);
t               = 2:height(GDAdata);

% Calculate the distances between each point
d               = hypot(GDAdata.Longitude(1) - GDAdata.Longitude(2:end), GDAdata.Latitude(1) - GDAdata.Latitude(2:end));

% Place them into a graph object and change the edge's weights to their
% gravity value
G6              = graph(s, t);
G6.Edges.Weight = (GDAdata.Population(1, 1)*GDAdata.Population(2:end, 1)./d.^param.gravPower);

% Call the function to plot the graph
p               = plot(G6, 'XData', GDAdata.Longitude, 'YData', GDAdata.Latitude);
axis('equal')

% Make the node and edges based on population and gravity
p.LineWidth     = G6.Edges.Weight*10/max(G6.Edges.Weight);
p.MarkerSize    = (GDAdata.Population)*10/max(GDAdata.Population);

% label the nodes & remove axis ticks
p.NodeLabel     = GDAdata.Name;
g               = gca;
set(g, 'xtick', []);
set(g, 'ytick', []);

% Labelling the plot
title("Population/Distance Gravity Model of Major Towns in the GDA")