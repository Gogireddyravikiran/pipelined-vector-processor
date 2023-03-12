`timescale 1ns/1ps
module vector_alu (
	input clk,
	input reset,
	//issue instruction to packed alu
	input [7:0] instruction,
	input  alu_enb,
	output alu_done,
	//operand Input/Output
	input  [511:0] opA,
	input  [511:0] opB,
	input  [511:0] opC,
	output [511:0] alu_out,
	//CSR PASSDOWN
	input [31:0] SEW,
	input [3:0]  vap,
    input [31:0] vlmax);
    wire done1, done2, done3, done4, done5, done6, done7, done8, done9, done10, done11, done12, done13, done14, done15, done16;
    assign alu_done = &{done1, done2, done3, done4, done5, done6, done7, done8, done9, done10, done11, done12, done13, done14, done15, done16};
    //opBunpacked
    localparam instr_vadd__vv = 8'h00 ;
    localparam instr_vsub__vv = 8'h01 ;
    localparam instr_vmul__vv = 8'h02 ;
    localparam instr_vmacc_vv = 8'h03 ;
    localparam instr_vmulvarp = 8'h04 ;
    localparam instr_vaddvarp = 8'h05 ;
    localparam instr_vsubvarp = 8'h06 ;

    reg [511:0] opBunpacked;
    always @(*)begin
        if(|{instruction == instr_vmulvarp,instruction == instr_vsubvarp,instruction == instr_vaddvarp})begin
            case(vap)
			0: opBunpacked ={ opB[511:511], 15'b000000000000000 , opB[510:510], 15'b000000000000000 , opB[509:509], 15'b000000000000000 , opB[508:508], 15'b000000000000000 , opB[507:507], 15'b000000000000000 , opB[506:506], 15'b000000000000000 , opB[505:505], 15'b000000000000000 , opB[504:504], 15'b000000000000000 , opB[503:503], 15'b000000000000000 , opB[502:502], 15'b000000000000000 , opB[501:501], 15'b000000000000000 , opB[500:500], 15'b000000000000000 , opB[499:499], 15'b000000000000000 , opB[498:498], 15'b000000000000000 , opB[497:497], 15'b000000000000000 , opB[496:496], 15'b000000000000000 , opB[495:495], 15'b000000000000000 , opB[494:494], 15'b000000000000000 , opB[493:493], 15'b000000000000000 , opB[492:492], 15'b000000000000000 , opB[491:491], 15'b000000000000000 , opB[490:490], 15'b000000000000000 , opB[489:489], 15'b000000000000000 , opB[488:488], 15'b000000000000000 , opB[487:487], 15'b000000000000000 , opB[486:486], 15'b000000000000000 , opB[485:485], 15'b000000000000000 , opB[484:484], 15'b000000000000000 , opB[483:483], 15'b000000000000000 , opB[482:482], 15'b000000000000000 , opB[481:481], 15'b000000000000000 , opB[480:480], 15'b000000000000000 };
			1: opBunpacked ={ opB[511:510], 14'b00000000000000 , opB[509:508], 14'b00000000000000 , opB[507:506], 14'b00000000000000 , opB[505:504], 14'b00000000000000 , opB[503:502], 14'b00000000000000 , opB[501:500], 14'b00000000000000 , opB[499:498], 14'b00000000000000 , opB[497:496], 14'b00000000000000 , opB[495:494], 14'b00000000000000 , opB[493:492], 14'b00000000000000 , opB[491:490], 14'b00000000000000 , opB[489:488], 14'b00000000000000 , opB[487:486], 14'b00000000000000 , opB[485:484], 14'b00000000000000 , opB[483:482], 14'b00000000000000 , opB[481:480], 14'b00000000000000 , opB[479:478], 14'b00000000000000 , opB[477:476], 14'b00000000000000 , opB[475:474], 14'b00000000000000 , opB[473:472], 14'b00000000000000 , opB[471:470], 14'b00000000000000 , opB[469:468], 14'b00000000000000 , opB[467:466], 14'b00000000000000 , opB[465:464], 14'b00000000000000 , opB[463:462], 14'b00000000000000 , opB[461:460], 14'b00000000000000 , opB[459:458], 14'b00000000000000 , opB[457:456], 14'b00000000000000 , opB[455:454], 14'b00000000000000 , opB[453:452], 14'b00000000000000 , opB[451:450], 14'b00000000000000 , opB[449:448], 14'b00000000000000 };
			2: opBunpacked ={ opB[511:509], 13'b0000000000000 , opB[508:506], 13'b0000000000000 , opB[505:503], 13'b0000000000000 , opB[502:500], 13'b0000000000000 , opB[499:497], 13'b0000000000000 , opB[496:494], 13'b0000000000000 , opB[493:491], 13'b0000000000000 , opB[490:488], 13'b0000000000000 , opB[487:485], 13'b0000000000000 , opB[484:482], 13'b0000000000000 , opB[481:479], 13'b0000000000000 , opB[478:476], 13'b0000000000000 , opB[475:473], 13'b0000000000000 , opB[472:470], 13'b0000000000000 , opB[469:467], 13'b0000000000000 , opB[466:464], 13'b0000000000000 , opB[463:461], 13'b0000000000000 , opB[460:458], 13'b0000000000000 , opB[457:455], 13'b0000000000000 , opB[454:452], 13'b0000000000000 , opB[451:449], 13'b0000000000000 , opB[448:446], 13'b0000000000000 , opB[445:443], 13'b0000000000000 , opB[442:440], 13'b0000000000000 , opB[439:437], 13'b0000000000000 , opB[436:434], 13'b0000000000000 , opB[433:431], 13'b0000000000000 , opB[430:428], 13'b0000000000000 , opB[427:425], 13'b0000000000000 , opB[424:422], 13'b0000000000000 , opB[421:419], 13'b0000000000000 , opB[418:416], 13'b0000000000000 };
			3: opBunpacked ={ opB[511:508], 12'b000000000000 , opB[507:504], 12'b000000000000 , opB[503:500], 12'b000000000000 , opB[499:496], 12'b000000000000 , opB[495:492], 12'b000000000000 , opB[491:488], 12'b000000000000 , opB[487:484], 12'b000000000000 , opB[483:480], 12'b000000000000 , opB[479:476], 12'b000000000000 , opB[475:472], 12'b000000000000 , opB[471:468], 12'b000000000000 , opB[467:464], 12'b000000000000 , opB[463:460], 12'b000000000000 , opB[459:456], 12'b000000000000 , opB[455:452], 12'b000000000000 , opB[451:448], 12'b000000000000 , opB[447:444], 12'b000000000000 , opB[443:440], 12'b000000000000 , opB[439:436], 12'b000000000000 , opB[435:432], 12'b000000000000 , opB[431:428], 12'b000000000000 , opB[427:424], 12'b000000000000 , opB[423:420], 12'b000000000000 , opB[419:416], 12'b000000000000 , opB[415:412], 12'b000000000000 , opB[411:408], 12'b000000000000 , opB[407:404], 12'b000000000000 , opB[403:400], 12'b000000000000 , opB[399:396], 12'b000000000000 , opB[395:392], 12'b000000000000 , opB[391:388], 12'b000000000000 , opB[387:384], 12'b000000000000 };
			4: opBunpacked ={ opB[511:507], 11'b00000000000 , opB[506:502], 11'b00000000000 , opB[501:497], 11'b00000000000 , opB[496:492], 11'b00000000000 , opB[491:487], 11'b00000000000 , opB[486:482], 11'b00000000000 , opB[481:477], 11'b00000000000 , opB[476:472], 11'b00000000000 , opB[471:467], 11'b00000000000 , opB[466:462], 11'b00000000000 , opB[461:457], 11'b00000000000 , opB[456:452], 11'b00000000000 , opB[451:447], 11'b00000000000 , opB[446:442], 11'b00000000000 , opB[441:437], 11'b00000000000 , opB[436:432], 11'b00000000000 , opB[431:427], 11'b00000000000 , opB[426:422], 11'b00000000000 , opB[421:417], 11'b00000000000 , opB[416:412], 11'b00000000000 , opB[411:407], 11'b00000000000 , opB[406:402], 11'b00000000000 , opB[401:397], 11'b00000000000 , opB[396:392], 11'b00000000000 , opB[391:387], 11'b00000000000 , opB[386:382], 11'b00000000000 , opB[381:377], 11'b00000000000 , opB[376:372], 11'b00000000000 , opB[371:367], 11'b00000000000 , opB[366:362], 11'b00000000000 , opB[361:357], 11'b00000000000 , opB[356:352], 11'b00000000000 };
			5: opBunpacked ={ opB[511:506], 10'b0000000000 , opB[505:500], 10'b0000000000 , opB[499:494], 10'b0000000000 , opB[493:488], 10'b0000000000 , opB[487:482], 10'b0000000000 , opB[481:476], 10'b0000000000 , opB[475:470], 10'b0000000000 , opB[469:464], 10'b0000000000 , opB[463:458], 10'b0000000000 , opB[457:452], 10'b0000000000 , opB[451:446], 10'b0000000000 , opB[445:440], 10'b0000000000 , opB[439:434], 10'b0000000000 , opB[433:428], 10'b0000000000 , opB[427:422], 10'b0000000000 , opB[421:416], 10'b0000000000 , opB[415:410], 10'b0000000000 , opB[409:404], 10'b0000000000 , opB[403:398], 10'b0000000000 , opB[397:392], 10'b0000000000 , opB[391:386], 10'b0000000000 , opB[385:380], 10'b0000000000 , opB[379:374], 10'b0000000000 , opB[373:368], 10'b0000000000 , opB[367:362], 10'b0000000000 , opB[361:356], 10'b0000000000 , opB[355:350], 10'b0000000000 , opB[349:344], 10'b0000000000 , opB[343:338], 10'b0000000000 , opB[337:332], 10'b0000000000 , opB[331:326], 10'b0000000000 , opB[325:320], 10'b0000000000 };
			6: opBunpacked ={ opB[511:505], 9'b000000000 , opB[504:498], 9'b000000000 , opB[497:491], 9'b000000000 , opB[490:484], 9'b000000000 , opB[483:477], 9'b000000000 , opB[476:470], 9'b000000000 , opB[469:463], 9'b000000000 , opB[462:456], 9'b000000000 , opB[455:449], 9'b000000000 , opB[448:442], 9'b000000000 , opB[441:435], 9'b000000000 , opB[434:428], 9'b000000000 , opB[427:421], 9'b000000000 , opB[420:414], 9'b000000000 , opB[413:407], 9'b000000000 , opB[406:400], 9'b000000000 , opB[399:393], 9'b000000000 , opB[392:386], 9'b000000000 , opB[385:379], 9'b000000000 , opB[378:372], 9'b000000000 , opB[371:365], 9'b000000000 , opB[364:358], 9'b000000000 , opB[357:351], 9'b000000000 , opB[350:344], 9'b000000000 , opB[343:337], 9'b000000000 , opB[336:330], 9'b000000000 , opB[329:323], 9'b000000000 , opB[322:316], 9'b000000000 , opB[315:309], 9'b000000000 , opB[308:302], 9'b000000000 , opB[301:295], 9'b000000000 , opB[294:288], 9'b000000000 };
			7: opBunpacked ={ opB[511:504], 8'b00000000 , opB[503:496], 8'b00000000 , opB[495:488], 8'b00000000 , opB[487:480], 8'b00000000 , opB[479:472], 8'b00000000 , opB[471:464], 8'b00000000 , opB[463:456], 8'b00000000 , opB[455:448], 8'b00000000 , opB[447:440], 8'b00000000 , opB[439:432], 8'b00000000 , opB[431:424], 8'b00000000 , opB[423:416], 8'b00000000 , opB[415:408], 8'b00000000 , opB[407:400], 8'b00000000 , opB[399:392], 8'b00000000 , opB[391:384], 8'b00000000 , opB[383:376], 8'b00000000 , opB[375:368], 8'b00000000 , opB[367:360], 8'b00000000 , opB[359:352], 8'b00000000 , opB[351:344], 8'b00000000 , opB[343:336], 8'b00000000 , opB[335:328], 8'b00000000 , opB[327:320], 8'b00000000 , opB[319:312], 8'b00000000 , opB[311:304], 8'b00000000 , opB[303:296], 8'b00000000 , opB[295:288], 8'b00000000 , opB[287:280], 8'b00000000 , opB[279:272], 8'b00000000 , opB[271:264], 8'b00000000 , opB[263:256], 8'b00000000 };
			8: opBunpacked ={ opB[511:503], 7'b0000000 , opB[502:494], 7'b0000000 , opB[493:485], 7'b0000000 , opB[484:476], 7'b0000000 , opB[475:467], 7'b0000000 , opB[466:458], 7'b0000000 , opB[457:449], 7'b0000000 , opB[448:440], 7'b0000000 , opB[439:431], 7'b0000000 , opB[430:422], 7'b0000000 , opB[421:413], 7'b0000000 , opB[412:404], 7'b0000000 , opB[403:395], 7'b0000000 , opB[394:386], 7'b0000000 , opB[385:377], 7'b0000000 , opB[376:368], 7'b0000000 , opB[367:359], 7'b0000000 , opB[358:350], 7'b0000000 , opB[349:341], 7'b0000000 , opB[340:332], 7'b0000000 , opB[331:323], 7'b0000000 , opB[322:314], 7'b0000000 , opB[313:305], 7'b0000000 , opB[304:296], 7'b0000000 , opB[295:287], 7'b0000000 , opB[286:278], 7'b0000000 , opB[277:269], 7'b0000000 , opB[268:260], 7'b0000000 , opB[259:251], 7'b0000000 , opB[250:242], 7'b0000000 , opB[241:233], 7'b0000000 , opB[232:224], 7'b0000000 };
			9: opBunpacked ={ opB[511:502], 6'b000000 , opB[501:492], 6'b000000 , opB[491:482], 6'b000000 , opB[481:472], 6'b000000 , opB[471:462], 6'b000000 , opB[461:452], 6'b000000 , opB[451:442], 6'b000000 , opB[441:432], 6'b000000 , opB[431:422], 6'b000000 , opB[421:412], 6'b000000 , opB[411:402], 6'b000000 , opB[401:392], 6'b000000 , opB[391:382], 6'b000000 , opB[381:372], 6'b000000 , opB[371:362], 6'b000000 , opB[361:352], 6'b000000 , opB[351:342], 6'b000000 , opB[341:332], 6'b000000 , opB[331:322], 6'b000000 , opB[321:312], 6'b000000 , opB[311:302], 6'b000000 , opB[301:292], 6'b000000 , opB[291:282], 6'b000000 , opB[281:272], 6'b000000 , opB[271:262], 6'b000000 , opB[261:252], 6'b000000 , opB[251:242], 6'b000000 , opB[241:232], 6'b000000 , opB[231:222], 6'b000000 , opB[221:212], 6'b000000 , opB[211:202], 6'b000000 , opB[201:192], 6'b000000 };
			10: opBunpacked ={ opB[511:501], 5'b00000 , opB[500:490], 5'b00000 , opB[489:479], 5'b00000 , opB[478:468], 5'b00000 , opB[467:457], 5'b00000 , opB[456:446], 5'b00000 , opB[445:435], 5'b00000 , opB[434:424], 5'b00000 , opB[423:413], 5'b00000 , opB[412:402], 5'b00000 , opB[401:391], 5'b00000 , opB[390:380], 5'b00000 , opB[379:369], 5'b00000 , opB[368:358], 5'b00000 , opB[357:347], 5'b00000 , opB[346:336], 5'b00000 , opB[335:325], 5'b00000 , opB[324:314], 5'b00000 , opB[313:303], 5'b00000 , opB[302:292], 5'b00000 , opB[291:281], 5'b00000 , opB[280:270], 5'b00000 , opB[269:259], 5'b00000 , opB[258:248], 5'b00000 , opB[247:237], 5'b00000 , opB[236:226], 5'b00000 , opB[225:215], 5'b00000 , opB[214:204], 5'b00000 , opB[203:193], 5'b00000 , opB[192:182], 5'b00000 , opB[181:171], 5'b00000 , opB[170:160], 5'b00000 };
			11: opBunpacked ={ opB[511:500], 4'b0000 , opB[499:488], 4'b0000 , opB[487:476], 4'b0000 , opB[475:464], 4'b0000 , opB[463:452], 4'b0000 , opB[451:440], 4'b0000 , opB[439:428], 4'b0000 , opB[427:416], 4'b0000 , opB[415:404], 4'b0000 , opB[403:392], 4'b0000 , opB[391:380], 4'b0000 , opB[379:368], 4'b0000 , opB[367:356], 4'b0000 , opB[355:344], 4'b0000 , opB[343:332], 4'b0000 , opB[331:320], 4'b0000 , opB[319:308], 4'b0000 , opB[307:296], 4'b0000 , opB[295:284], 4'b0000 , opB[283:272], 4'b0000 , opB[271:260], 4'b0000 , opB[259:248], 4'b0000 , opB[247:236], 4'b0000 , opB[235:224], 4'b0000 , opB[223:212], 4'b0000 , opB[211:200], 4'b0000 , opB[199:188], 4'b0000 , opB[187:176], 4'b0000 , opB[175:164], 4'b0000 , opB[163:152], 4'b0000 , opB[151:140], 4'b0000 , opB[139:128], 4'b0000 };
			12: opBunpacked ={ opB[511:499], 3'b000 , opB[498:486], 3'b000 , opB[485:473], 3'b000 , opB[472:460], 3'b000 , opB[459:447], 3'b000 , opB[446:434], 3'b000 , opB[433:421], 3'b000 , opB[420:408], 3'b000 , opB[407:395], 3'b000 , opB[394:382], 3'b000 , opB[381:369], 3'b000 , opB[368:356], 3'b000 , opB[355:343], 3'b000 , opB[342:330], 3'b000 , opB[329:317], 3'b000 , opB[316:304], 3'b000 , opB[303:291], 3'b000 , opB[290:278], 3'b000 , opB[277:265], 3'b000 , opB[264:252], 3'b000 , opB[251:239], 3'b000 , opB[238:226], 3'b000 , opB[225:213], 3'b000 , opB[212:200], 3'b000 , opB[199:187], 3'b000 , opB[186:174], 3'b000 , opB[173:161], 3'b000 , opB[160:148], 3'b000 , opB[147:135], 3'b000 , opB[134:122], 3'b000 , opB[121:109], 3'b000 , opB[108:96], 3'b000 };
			13: opBunpacked ={ opB[511:498], 2'b00 , opB[497:484], 2'b00 , opB[483:470], 2'b00 , opB[469:456], 2'b00 , opB[455:442], 2'b00 , opB[441:428], 2'b00 , opB[427:414], 2'b00 , opB[413:400], 2'b00 , opB[399:386], 2'b00 , opB[385:372], 2'b00 , opB[371:358], 2'b00 , opB[357:344], 2'b00 , opB[343:330], 2'b00 , opB[329:316], 2'b00 , opB[315:302], 2'b00 , opB[301:288], 2'b00 , opB[287:274], 2'b00 , opB[273:260], 2'b00 , opB[259:246], 2'b00 , opB[245:232], 2'b00 , opB[231:218], 2'b00 , opB[217:204], 2'b00 , opB[203:190], 2'b00 , opB[189:176], 2'b00 , opB[175:162], 2'b00 , opB[161:148], 2'b00 , opB[147:134], 2'b00 , opB[133:120], 2'b00 , opB[119:106], 2'b00 , opB[105:92], 2'b00 , opB[91:78], 2'b00 , opB[77:64], 2'b00 };
			14: opBunpacked ={ opB[511:497], 1'b0 , opB[496:482], 1'b0 , opB[481:467], 1'b0 , opB[466:452], 1'b0 , opB[451:437], 1'b0 , opB[436:422], 1'b0 , opB[421:407], 1'b0 , opB[406:392], 1'b0 , opB[391:377], 1'b0 , opB[376:362], 1'b0 , opB[361:347], 1'b0 , opB[346:332], 1'b0 , opB[331:317], 1'b0 , opB[316:302], 1'b0 , opB[301:287], 1'b0 , opB[286:272], 1'b0 , opB[271:257], 1'b0 , opB[256:242], 1'b0 , opB[241:227], 1'b0 , opB[226:212], 1'b0 , opB[211:197], 1'b0 , opB[196:182], 1'b0 , opB[181:167], 1'b0 , opB[166:152], 1'b0 , opB[151:137], 1'b0 , opB[136:122], 1'b0 , opB[121:107], 1'b0 , opB[106:92], 1'b0 , opB[91:77], 1'b0 , opB[76:62], 1'b0 , opB[61:47], 1'b0 , opB[46:32], 1'b0 };
			15: opBunpacked ={ opB[511:496], opB[495:480], opB[479:464], opB[463:448], opB[447:432], opB[431:416], opB[415:400], opB[399:384], opB[383:368], opB[367:352], opB[351:336], opB[335:320], opB[319:304], opB[303:288], opB[287:272], opB[271:256], opB[255:240], opB[239:224], opB[223:208], opB[207:192], opB[191:176], opB[175:160], opB[159:144], opB[143:128], opB[127:112], opB[111:96], opB[95:80], opB[79:64], opB[63:48], opB[47:32], opB[31:16], opB[15:0] };

			endcase
        end
        else
            opBunpacked = opB;
    end
  
    vector_processing_element pe1(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done1),.opA(opA[511:480]),.opB(opBunpacked[511:480]),.opC(opC[511:480]),.peout(alu_out[511:480]),.SEW(SEW),.vap(vap));
    vector_processing_element pe2(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done2),.opA(opA[479:448]),.opB(opBunpacked[479:448]),.opC(opC[479:448]),.peout(alu_out[479:448]),.SEW(SEW),.vap(vap));
    vector_processing_element pe3(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done3),.opA(opA[447:416]),.opB(opBunpacked[447:416]),.opC(opC[447:416]),.peout(alu_out[447:416]),.SEW(SEW),.vap(vap));
    vector_processing_element pe4(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done4),.opA(opA[415:384]),.opB(opBunpacked[415:384]),.opC(opC[415:384]),.peout(alu_out[415:384]),.SEW(SEW),.vap(vap));
    vector_processing_element pe5(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done5),.opA(opA[383:352]),.opB(opBunpacked[383:352]),.opC(opC[383:352]),.peout(alu_out[383:352]),.SEW(SEW),.vap(vap));
    vector_processing_element pe6(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done6),.opA(opA[351:320]),.opB(opBunpacked[351:320]),.opC(opC[351:320]),.peout(alu_out[351:320]),.SEW(SEW),.vap(vap));
    vector_processing_element pe7(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done7),.opA(opA[319:288]),.opB(opBunpacked[319:288]),.opC(opC[319:288]),.peout(alu_out[319:288]),.SEW(SEW),.vap(vap));
    vector_processing_element pe8(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done8),.opA(opA[287:256]),.opB(opBunpacked[287:256]),.opC(opC[287:256]),.peout(alu_out[287:256]),.SEW(SEW),.vap(vap));
    vector_processing_element pe9(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done9),.opA(opA[255:224]),.opB(opBunpacked[255:224]),.opC(opC[255:224]),.peout(alu_out[255:224]),.SEW(SEW),.vap(vap));
    vector_processing_element pe10(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done10),.opA(opA[223:192]),.opB(opBunpacked[223:192]),.opC(opC[223:192]),.peout(alu_out[223:192]),.SEW(SEW),.vap(vap));
    vector_processing_element pe11(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done11),.opA(opA[191:160]),.opB(opBunpacked[191:160]),.opC(opC[191:160]),.peout(alu_out[191:160]),.SEW(SEW),.vap(vap));
    vector_processing_element pe12(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done12),.opA(opA[159:128]),.opB(opBunpacked[159:128]),.opC(opC[159:128]),.peout(alu_out[159:128]),.SEW(SEW),.vap(vap));
    vector_processing_element pe13(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done13),.opA(opA[127:96]),.opB(opBunpacked[127:96]),.opC(opC[127:96]),.peout(alu_out[127:96]),.SEW(SEW),.vap(vap));
    vector_processing_element pe14(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done14),.opA(opA[95:64]),.opB(opBunpacked[95:64]),.opC(opC[95:64]),.peout(alu_out[95:64]),.SEW(SEW),.vap(vap));
    vector_processing_element pe15(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done15),.opA(opA[63:32]),.opB(opBunpacked[63:32]),.opC(opC[63:32]),.peout(alu_out[63:32]),.SEW(SEW),.vap(vap));
    vector_processing_element pe16(.clk(clk),.reset(reset),.instruction(instruction),.start(alu_enb),.done(done16),.opA(opA[31:0]),.opB(opBunpacked[31:0]),.opC(opC[31:0]),.peout(alu_out[31:0]),.SEW(SEW),.vap(vap));

endmodule


module vector_processing_element(
    input clk,
    input reset,
    
    input [7:0] instruction,
	input start,
	output reg done,
	
    input [31:0] opA,
    input [31:0] opB,
    input [31:0] opC,
    output reg [31:0] peout,

	input [31:0] SEW,
	input [3:0 ] vap);

reg [3:0] states;
localparam startstate = 4'h0 ;
localparam multstate  = 4'h1 ;
localparam completestate = 4'h2 ;



localparam instr_vadd__vv = 8'h00 ;
localparam instr_vsub__vv = 8'h01 ;
localparam instr_vmul__vv = 8'h02 ;
localparam instr_vmacc_vv = 8'h03 ;
localparam instr_vmulvarp = 8'h04 ;
localparam instr_vaddvarp = 8'h05 ;
localparam instr_vsubvarp = 8'h06 ;

reg [31:0] accumulator;
reg [7:0]  cycles;
reg first_cmpte;
reg [31:0] copB;

always @(posedge clk) begin
    if(reset) begin
        states = 0;
        peout  = 0;
        accumulator = 0;
        first_cmpte = 0;
        cycles = 0;
        copB = 0;
        done = 0;
    end
    case(states)
        startstate:begin
           if(start)begin
                done = 0;
                accumulator = 0;
                if(|{instruction == instr_vmul__vv,instruction == instr_vmulvarp,instruction == instr_vmacc_vv}) begin
                    states = multstate;
                    cycles = (instruction==instr_vmulvarp )? ({4'h0,vap}+1 ):SEW[7:0];

                    first_cmpte = 1;
                     // to retain local copy and not interfere with other changer is depacking module
                end
                else
                    states = completestate;
                
           end
           else
                done = 0;
        end
        multstate: begin
            if(SEW==32 && !(instruction == instr_vmulvarp)) begin
                if(first_cmpte)begin
                    accumulator = (opB[31])?-opA:0;
                    copB= opB << 1;
                    cycles = cycles -1;
                    first_cmpte = 0;
                    end
                else begin
                    accumulator = ((accumulator<<1) + ((copB[31])?opA:0));
                    copB       = copB <<1;
                    cycles = cycles -1;
                end
            end
            else if(SEW==8 && !(instruction == instr_vmulvarp)) begin
                if(first_cmpte)begin
                    accumulator[31:24] = (opB[31])?-opA[31:24]:0;
                    accumulator[23:16] = (opB[23])?-opA[23:16]:0;
                    accumulator[15:8 ] = (opB[15])?-opA[15:8 ]:0;
                    accumulator[7 :0 ] = (opB[ 7])?-opA[7 :0 ]:0;
                    
                    copB[31:24]= opB[31:24] << 1;
                    copB[23:16]= opB[23:16] << 1;
                    copB[15:8 ]= opB[15:8 ] << 1;
                    copB[7 :0 ]= opB[7 :0 ] << 1;
                    cycles = cycles -1;
                    first_cmpte = 0;
                    end
                else begin
                    accumulator[31:24] = ((accumulator[31:24]<<1) + ((copB[31])?opA[31:24]:0));
                    accumulator[23:16] = ((accumulator[23:16]<<1) + ((copB[23])?opA[23:16]:0));
                    accumulator[15: 8] = ((accumulator[15: 8]<<1) + ((copB[15])?opA[15: 8]:0));
                    accumulator[7 : 0] = ((accumulator[7 : 0]<<1) + ((copB[7 ])?opA[7 : 0]:0));
                    
                    copB[31:24]= copB[31:24] << 1;
                    copB[23:16]= copB[23:16] << 1;
                    copB[15:8 ]= copB[15:8 ] << 1;
                    copB[7 :0 ]= copB[7 :0 ] << 1;
                    cycles = cycles -1;
                end
            end
            else begin
                if(first_cmpte)begin
                    if(vap==0) begin
                        accumulator[31:16] = (opB[31])?-opA[31:16]:opA[31:16];
                        accumulator[15: 0] = (opB[15])?-opA[15: 0]:opA[15: 0];
                    end
                    else begin
                        accumulator[31:16] = (opB[31])?-opA[31:16]:0;
                        accumulator[15: 0] = (opB[15])?-opA[15: 0]:0;
                    end
                    copB[31:16]= opB[31:16] << 1;
                    copB[15: 0]= opB[15: 0] << 1;
                    cycles = cycles -1;
                    first_cmpte = 0;
                    end
                else begin
                    accumulator[31:16] = ((accumulator[31:16]<<1) + ((copB[31])?opA[31:16]:0));
                    accumulator[15: 0] = ((accumulator[15: 0]<<1) + ((copB[15])?opA[15: 0]:0));
                    copB[31:16]       = copB[31:16] <<1;
                    copB[15: 0]       = copB[15: 0] <<1;
                    cycles = cycles -1;
                end
            end

            if(cycles==0)
                states=completestate;

        end
        completestate:begin
            if(|{instruction == instr_vadd__vv,instruction==instr_vsub__vv,instruction==instr_vmacc_vv})begin
                if(SEW==32)begin
                    accumulator = ((instruction==instr_vmacc_vv)?accumulator : opA) + ((instruction == instr_vadd__vv)?opB:((instruction == instr_vsub__vv)?(-opB):opC));
                end
                else if(SEW==16)begin
                    accumulator[31:16] = ((instruction==instr_vmacc_vv)?accumulator[31:16] : opA[31:16]) + ((instruction == instr_vadd__vv)?opB[31:16]:((instruction == instr_vsub__vv)?(-opB[31:16]):opC[31:16]));
                    accumulator[15:0]  = ((instruction==instr_vmacc_vv)?accumulator[15:0] : opA[15:0])  + ((instruction == instr_vadd__vv)?opB[15:0] :((instruction == instr_vsub__vv)?(-opB[15:0] ):opC[15:0])) ;
                end
                else if(SEW==8)begin
                    $display("%x",accumulator);
                    accumulator[31:24] = ((instruction==instr_vmacc_vv)?accumulator[31:24] : opA[31:24]) + ((instruction == instr_vadd__vv)?opB[31:24]:((instruction == instr_vsub__vv)?(-opB[31:24]):opC[31:24]));
                    accumulator[23:16] = ((instruction==instr_vmacc_vv)?accumulator[23:16] : opA[23:16]) + ((instruction == instr_vadd__vv)?opB[23:16]:((instruction == instr_vsub__vv)?(-opB[23:16]):opC[23:16]));
                    accumulator[15:8 ] = ((instruction==instr_vmacc_vv)?accumulator[15:8] : opA[15:8 ]) + ((instruction == instr_vadd__vv)?opB[15:8 ]:((instruction == instr_vsub__vv)?(-opB[15:8 ]):opC[15:8 ]));
                    accumulator[7:0  ] = ((instruction==instr_vmacc_vv)?accumulator[7:0] : opA[7:0  ]) + ((instruction == instr_vadd__vv)?opB[7:0  ]:((instruction == instr_vsub__vv)?(-opB[7:0  ]):opC[7:0  ]));
                    $display("enter");
                end
                peout = accumulator;
            end
            else if((|{instruction==instr_vsubvarp,instruction==instr_vaddvarp}) && SEW == 16) begin
                accumulator[31:16] = opA[31:16] + ((instruction == instr_vaddvarp)? ((opB[31:16]>>(15-vap)) | ((opB[31])?((16'hFFFF)<<(vap+1)):16'h0000)) : ( (instruction == instr_vsubvarp)?-((opB[31:16]>>(15-vap)) | ((opB[31])?((16'hFFFF)<<(vap+1)):16'h0000)) :0) );
                accumulator[15:0] = opA[15:0] + ((instruction == instr_vaddvarp)? ((opB[15:0]>>(15-vap)) | ((opB[15])?((16'hFFFF)<<(vap+1)):16'h0000)) : ( (instruction == instr_vsubvarp)?-((opB[15:0]>>(15-vap)) | ((opB[15])?((16'hFFFF)<<(vap+1)):16'h0000)) :0) );
                peout = accumulator;
            end
            else if(|{instruction==instr_vmul__vv,instruction==instr_vmulvarp})begin
                peout = accumulator;
            end
            done =1;
            states = startstate;

        end

    endcase

end

endmodule
