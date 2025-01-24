module mac_tb();
    parameter DATA_WIDTH = 8;
    logic clk, rst_n, Clr;
    logic [DATA_WIDTH-1:0] Ain, Bin;
    logic  [DATA_WIDTH*3-1:0] Cout;
    MAC #(.DATA_WIDTH(DATA_WIDTH)) mac(
                                    .clk(clk),
                                    .rst_n(rst_n),
                                    .En(1'b1),
                                    .Clr(1'b0),
                                    .Ain(Ain),
                                    .Bin(Bin),
                                    .Cout(Cout)
                                );
    initial begin
        clk = 0;
        rst_n = 1;
        Clr = 0;
        
        @(negedge clk)  rst_n = 0;
        @(negedge clk) begin 
            rst_n = 1;
        end
        @(negedge clk) begin 
            rst_n = 1;
            Ain = 8;
            Bin = 8;
        end
        @(negedge clk) begin
            if (Cout != 64) begin
                $display("Cout is %d but should be 64!", Cout);
                $stop();
            end
            
            Ain = 2;
            Bin = 4;
        end
        @(negedge clk) begin
            Clr = 1;
            if (Cout != 72) begin
                $display("Cout is %d but should be 72!", Cout);
                $stop();
            end
        end
        @(negedge clk) begin
            if (Cout != 0) begin
                $display("Clear failed");
                $stop();
            end
        end
        $display("Yahoo! All test passed!");
        $stop();
    end
    always #5 clk = ~clk;
endmodule