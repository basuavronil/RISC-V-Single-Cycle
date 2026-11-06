`timescale 1ns/1ps
module tb_cpu;
    reg clk = 0, reset = 1;
    cpu dut (.clk(clk), .reset(reset));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb_cpu);
        #12 reset = 0;
        #400;
        $display("x1 (sum 1..10)  = %0d", dut.u_rf.regs[1]);
        $display("x4 (loaded)     = %0d", dut.u_rf.regs[4]);
        $display("x5 (lui)        = 0x%08h", dut.u_rf.regs[5]);
        $display("x6 (sub 55-5)   = %0d", dut.u_rf.regs[6]);
        $display("mem[0]          = %0d", dut.u_dmem.mem[0]);
        if (dut.u_rf.regs[1] == 55 && dut.u_rf.regs[4] == 55 &&
            dut.u_rf.regs[5] == 32'h12345000 && dut.u_rf.regs[6] == 50 &&
            dut.u_dmem.mem[0] == 55)
            $display("PASS");
        else
            $display("FAIL");
        $finish;
    end
endmodule
