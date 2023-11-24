// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 16
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    //input wb_clk_i,
    //input wb_rst_i,
    //input wbs_stb_i,
    //input wbs_cyc_i,
    //input wbs_we_i,
    //input [3:0] wbs_sel_i,
    //input [31:0] wbs_dat_i,
    //input [31:0] wbs_adr_i,
    //output wbs_ack_o,
    //output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    //input  [127:0] la_data_in,
    //output [127:0] la_data_out,
    //input  [127:0] la_oenb,

    // IOs
    input  [3:0] io_in,
    output [7:0] io_out,
    //output [BITS-1:0] io_oeb,

    // IRQ
    //output [2:0] irq

);

    // Declare internal wires for connecting to pes_se_M
    wire [3:0] A;
    wire [3:0] B;
    wire [7:0] product;

    // Connect io_in to A and B
    assign A = io_in;
    assign B = io_in; // Replace with actual connections

    // Instantiate pes_se_M
    pes_se_M pes_se_M_instance (
        .A(A),
        .B(B),
        .product(product)
    );

    // Connect the product to io_out or other logic
    assign io_out = product;
    
endmodule

`default_nettype wire
