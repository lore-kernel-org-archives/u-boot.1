Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4056C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 04:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D081483B80;
	Fri,  8 Aug 2025 06:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="N7P2REzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F4E83C01; Fri,  8 Aug 2025 06:01:24 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A399F83AE7
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 06:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3EFBB103F85; Fri,  8 Aug 2025 06:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1754625680;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=VGtnyygh+gbj+3/b/Q7q+dj46Gv95/1kR1C45qlv54o=;
 b=N7P2REzIAg//4Hf88tB32kYFqSF/ic2drneBTvPLwn0XOUkhq0fNDRjxflPPuyKye34CR2
 AGpn2MMrR/Wu5oIX9sYvZCH2K8+/dMBpOwgxrepdtmPRn72AKM6ZqizZhYS5e2wh2fI4g2
 hjz1FWqSfA9aBIBNXLA0uOC8lLPKrhHgvEmKB/JYevlJK+jKPpwCv9pT6DSuPwo9Wcfr4/
 g42DJZU0ru25YwbRkzVT4zFbRJvRUyHe/pHSirr1kXGo5Ni1zCWPC2lRWSlaffOQ9Rt3c/
 LN0BHsXQG4BLqYXjiwhVt+nJxxbWIvfVOGlwzfaa2+Jfb4IlBwMublqUQo47cw==
Message-ID: <ac81671e-a784-1dce-09db-2435c79c5b26@nabladev.com>
Date: Fri, 8 Aug 2025 06:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>
References: <20250806183543.GR124814@bill-the-cat>
 <3e98b2c9-7e14-5bee-a03d-352a51eaab93@nabladev.com>
 <PH7PR03MB6942E3C1339738845D3F3D0EF72FA@PH7PR03MB6942.namprd03.prod.outlook.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <PH7PR03MB6942E3C1339738845D3F3D0EF72FA@PH7PR03MB6942.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dinesh,

On 08.08.25 05:37, Maniyam, Dinesh wrote:
> Hi
> 
>> -----Original Message-----
>> From: Heiko Schocher <hs@nabladev.com>
>> Sent: Thursday, 7 August 2025 5:17 pm
>> To: u-boot@lists.denx.de; Maniyam, Dinesh <dinesh.maniyam@altera.com>
>> Cc: Tom Rini <trini@konsulko.com>; Heiko Schocher <hs@denx.de>
>> Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
>>
>> [CAUTION: This email is from outside your organization. Unless you trust the
>> sender, do not click on links or open attachments as it may be a fraudulent email
>> attempting to steal your information and/or compromise your computer.]
>>
>> Hello Dinesh,
>>
>> On 06.08.25 20:35, Tom Rini wrote:
>>> Here's the latest report. Lets get these new issues addressed ASAP
>>> please, thanks.
>>>
>>> ---------- Forwarded message ---------
>>> From: <scan-admin@coverity.com>
>>> Date: Wed, Aug 6, 2025 at 12:23 PM
>>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>>> To: <tom.rini@gmail.com>
>>>
>>>
>>> Hi,
>>>
>>> Please find the latest report on new defect(s) introduced to *Das
>>> U-Boot* found with Coverity Scan.
>>>
>>>      - *New Defects Found:* 8
>>>      - 4 defect(s), reported by Coverity Scan earlier, were marked fixed in
>>>      the recent build analyzed by Coverity Scan.
>>>      - *Defects Shown:* Showing 8 of 8 defect(s)
>>>
>>> Defect Details
>>>
>>> ** CID 583812:       Integer handling issues  (BAD_SHIFT)
>>> /drivers/i3c/master/dw-i3c-master.c: 1001           in dw_i3c_probe()
>>
>> Could you please look at the issues on i3c parts, as I go on vacation, thanks!
>>
> 
> Yes, I am working on it, give me just a couple of days!

Of course, Thanks for your time!

bye,
Heiko
> 
> Thanks
> Dinesh
> 
>> @Tom: Feel free to pick up fixes, thanks!
>>
>> bye,
>> Heiko
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 583812:         Integer handling issues  (BAD_SHIFT)
>>> /drivers/i3c/master/dw-i3c-master.c: 1001             in dw_i3c_probe()
>>> 995           ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
>>> 996           master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
>>> 997
>>> 998           ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
>>> 999           master->datstartaddr = ret;
>>> 1000          master->maxdevs = ret >> 16;
>>>>>>       CID 583812:         Integer handling issues  (BAD_SHIFT)
>>>>>>       In expression "0xffffffffffffffffUL >> 63 - (master->maxdevs - 1)", right
>> shifting by more than 63 bits has undefined behavior.  The shift amount, "63 -
>> (master->maxdevs - 1)", is 64.
>>> 1001          master->free_pos = GENMASK(master->maxdevs - 1, 0);
>>> 1002
>>> 1003          ret = i3c_master_register(&master->base, dev,
>>> 1004                                    &dw_mipi_i3c_ops, false);
>>> 1005          if (ret)
>>> 1006                  goto err_assert_rst;
>>>
>>> ** CID 583811:         (RESOURCE_LEAK)
>>> /drivers/i3c/master.c: 1610           in of_i3c_master_add_i3c_boardinfo()
>>> /drivers/i3c/master.c: 1586           in of_i3c_master_add_i3c_boardinfo()
>>> /drivers/i3c/master.c: 1591           in of_i3c_master_add_i3c_boardinfo()
>>> /drivers/i3c/master.c: 1598           in of_i3c_master_add_i3c_boardinfo()
>>> /drivers/i3c/master.c: 1603           in of_i3c_master_add_i3c_boardinfo()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 583811:           (RESOURCE_LEAK)
>>> /drivers/i3c/master.c: 1610             in of_i3c_master_add_i3c_boardinfo()
>>> 1604          }
>>> 1605
>>> 1606          boardinfo->pid = ((u64)reg[1] << 32) | reg[2];
>>> 1607
>>> 1608          if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
>>> 1609              I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
>>>>>>       CID 583811:           (RESOURCE_LEAK)
>>>>>>       Variable "boardinfo" going out of scope leaks the storage it points to.
>>> 1610                  return -EINVAL;
>>> 1611
>>> 1612          boardinfo->init_dyn_addr = init_dyn_addr;
>>> 1613          boardinfo->of_node = node;
>>> 1614          list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
>>> 1615
>>> /drivers/i3c/master.c: 1586             in of_i3c_master_add_i3c_boardinfo()
>>> 1580          boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
>>> 1581          if (!boardinfo)
>>> 1582                  return -ENOMEM;
>>> 1583
>>> 1584          if (reg[0]) {
>>> 1585                  if (reg[0] > I3C_MAX_ADDR)
>>>>>>       CID 583811:           (RESOURCE_LEAK)
>>>>>>       Variable "boardinfo" going out of scope leaks the storage it points to.
>>> 1586                          return -EINVAL;
>>> 1587
>>> 1588                  addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
>>> 1589                                                            reg[0]);
>>> 1590                  if (addrstatus != I3C_ADDR_SLOT_FREE)
>>> 1591                          return -EINVAL;
>>> /drivers/i3c/master.c: 1591             in of_i3c_master_add_i3c_boardinfo()
>>> 1585                  if (reg[0] > I3C_MAX_ADDR)
>>> 1586                          return -EINVAL;
>>> 1587
>>> 1588                  addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
>>> 1589                                                            reg[0]);
>>> 1590                  if (addrstatus != I3C_ADDR_SLOT_FREE)
>>>>>>       CID 583811:           (RESOURCE_LEAK)
>>>>>>       Variable "boardinfo" going out of scope leaks the storage it points to.
>>> 1591                          return -EINVAL;
>>> 1592          }
>>> 1593
>>> 1594          boardinfo->static_addr = reg[0];
>>> 1595
>>> 1596          if (!dev_read_u32(dev, "assigned-address", &init_dyn_addr)) {
>>> /drivers/i3c/master.c: 1598             in of_i3c_master_add_i3c_boardinfo()
>>> 1592          }
>>> 1593
>>> 1594          boardinfo->static_addr = reg[0];
>>> 1595
>>> 1596          if (!dev_read_u32(dev, "assigned-address", &init_dyn_addr)) {
>>> 1597                  if (init_dyn_addr > I3C_MAX_ADDR)
>>>>>>       CID 583811:           (RESOURCE_LEAK)
>>>>>>       Variable "boardinfo" going out of scope leaks the storage it points to.
>>> 1598                          return -EINVAL;
>>> 1599
>>> 1600                  addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
>>> 1601                                                            init_dyn_addr);
>>> 1602                  if (addrstatus != I3C_ADDR_SLOT_FREE)
>>> 1603                          return -EINVAL;
>>> /drivers/i3c/master.c: 1603             in of_i3c_master_add_i3c_boardinfo()
>>> 1597                  if (init_dyn_addr > I3C_MAX_ADDR)
>>> 1598                          return -EINVAL;
>>> 1599
>>> 1600                  addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
>>> 1601                                                            init_dyn_addr);
>>> 1602                  if (addrstatus != I3C_ADDR_SLOT_FREE)
>>>>>>       CID 583811:           (RESOURCE_LEAK)
>>>>>>       Variable "boardinfo" going out of scope leaks the storage it points to.
>>> 1603                          return -EINVAL;
>>> 1604          }
>>> 1605
>>> 1606          boardinfo->pid = ((u64)reg[1] << 32) | reg[2];
>>> 1607
>>> 1608          if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
>>>
>>> ** CID 298388:       Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 579           in dw_i3c_ccc_get()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 298388:         Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 579             in dw_i3c_ccc_get()
>>> 573                   return -ENOMEM;
>>> 574
>>> 575           cmd = xfer->cmds;
>>> 576           cmd->rx_buf = ccc->dests[0].payload.data;
>>> 577           cmd->rx_len = ccc->dests[0].payload.len;
>>> 578
>>>>>>       CID 298388:         Integer handling issues  (SIGN_EXTENSION)
>>>>>>       Suspicious implicit sign extension: "ccc->dests[0].payload.len" with type
>> "u16" (16 bits, unsigned) is promoted in "ccc->dests[0].payload.len << 16" to type
>> "int" (32 bits, signed), then sign-extended to type "unsigned long" (64 bits,
>> unsigned).  If "ccc->dests[0].payload.len << 16" is greater than 0x7FFFFFFF, the
>> upper bits of the result will all be 1.
>>> 579           cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(ccc-
>>> dests[0].payload.len) |
>>> 580                         COMMAND_PORT_TRANSFER_ARG;
>>> 581
>>> 582           cmd->cmd_lo = COMMAND_PORT_READ_TRANSFER |
>>> 583                         COMMAND_PORT_CP |
>>> 584                         COMMAND_PORT_DEV_INDEX(pos) |
>>>
>>> ** CID 298037:       Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 375           in dw_i3c_clk_cfg()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 298037:         Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 375             in dw_i3c_clk_cfg()
>>> 369           scl_timing = SCL_EXT_LCNT_1(lcnt);
>>> 370           lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
>>> 371           scl_timing |= SCL_EXT_LCNT_2(lcnt);
>>> 372           lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
>>> 373           scl_timing |= SCL_EXT_LCNT_3(lcnt);
>>> 374           lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
>>>>>>       CID 298037:         Integer handling issues  (SIGN_EXTENSION)
>>>>>>       Suspicious implicit sign extension: "lcnt" with type "u8" (8 bits, unsigned)
>> is promoted in "lcnt << 24" to type "int" (32 bits, signed), then sign-extended to
>> type "unsigned long" (64 bits, unsigned).  If "lcnt << 24" is greater than
>> 0x7FFFFFFF, the upper bits of the result will all be 1.
>>> 375           scl_timing |= SCL_EXT_LCNT_4(lcnt);
>>> 376           writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
>>> 377
>>> 378           return 0;
>>> 379     }
>>> 380
>>>
>>> ** CID 296053:       Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 535           in dw_i3c_ccc_set()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 296053:         Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 535             in dw_i3c_ccc_set()
>>> 529                   return -ENOMEM;
>>> 530
>>> 531           cmd = xfer->cmds;
>>> 532           cmd->tx_buf = ccc->dests[0].payload.data;
>>> 533           cmd->tx_len = ccc->dests[0].payload.len;
>>> 534
>>>>>>       CID 296053:         Integer handling issues  (SIGN_EXTENSION)
>>>>>>       Suspicious implicit sign extension: "ccc->dests[0].payload.len" with type
>> "u16" (16 bits, unsigned) is promoted in "ccc->dests[0].payload.len << 16" to type
>> "int" (32 bits, signed), then sign-extended to type "unsigned long" (64 bits,
>> unsigned).  If "ccc->dests[0].payload.len << 16" is greater than 0x7FFFFFFF, the
>> upper bits of the result will all be 1.
>>> 535           cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(ccc-
>>> dests[0].payload.len) |
>>> 536                         COMMAND_PORT_TRANSFER_ARG;
>>> 537
>>> 538           cmd->cmd_lo = COMMAND_PORT_CP |
>>> 539                         COMMAND_PORT_DEV_INDEX(pos) |
>>> 540                         COMMAND_PORT_CMD(ccc->id) |
>>>
>>> ** CID 295976:         (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 395           in dw_i2c_clk_cfg()
>>> /drivers/i3c/master/dw-i3c-master.c: 401           in dw_i2c_clk_cfg()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 295976:           (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 395             in dw_i2c_clk_cfg()
>>> 389                   return -EINVAL;
>>> 390
>>> 391           core_period = DIV_ROUND_UP(1000000000, core_rate);
>>> 392
>>> 393           lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS,
>> core_period);
>>> 394           hcnt = DIV_ROUND_UP(core_rate,
>> I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
>>>>>>       CID 295976:           (SIGN_EXTENSION)
>>>>>>       Suspicious implicit sign extension: "hcnt" with type "u16" (16 bits,
>> unsigned) is promoted in "hcnt << 16" to type "int" (32 bits, signed), then sign-
>> extended to type "unsigned long" (64 bits, unsigned).  If "hcnt << 16" is greater
>> than 0x7FFFFFFF, the upper bits of the result will all be 1.
>>> 395           scl_timing = SCL_I2C_FMP_TIMING_HCNT(hcnt) |
>>> 396                        SCL_I2C_FMP_TIMING_LCNT(lcnt);
>>> 397           writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
>>> 398
>>> 399           lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS,
>> core_period);
>>> 400           hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) -
>> lcnt;
>>> /drivers/i3c/master/dw-i3c-master.c: 401             in dw_i2c_clk_cfg()
>>> 395           scl_timing = SCL_I2C_FMP_TIMING_HCNT(hcnt) |
>>> 396                        SCL_I2C_FMP_TIMING_LCNT(lcnt);
>>> 397           writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
>>> 398
>>> 399           lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS,
>> core_period);
>>> 400           hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) -
>> lcnt;
>>>>>>       CID 295976:           (SIGN_EXTENSION)
>>>>>>       Suspicious implicit sign extension: "hcnt" with type "u16" (16 bits,
>> unsigned) is promoted in "hcnt << 16" to type "int" (32 bits, signed), then sign-
>> extended to type "unsigned long" (64 bits, unsigned).  If "hcnt << 16" is greater
>> than 0x7FFFFFFF, the upper bits of the result will all be 1.
>>> 401           scl_timing = SCL_I2C_FM_TIMING_HCNT(hcnt) |
>>> 402                        SCL_I2C_FM_TIMING_LCNT(lcnt);
>>> 403           writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
>>> 404
>>> 405           writel(BUS_I3C_MST_FREE(lcnt), master->regs +
>> BUS_FREE_TIMING);
>>> 406           writel(readl(master->regs + DEVICE_CTRL) |
>> DEV_CTRL_I2C_SLAVE_PRESENT,
>>>
>>> ** CID 294913:       Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 724           in dw_i3c_master_priv_xfers()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 294913:         Integer handling issues  (SIGN_EXTENSION)
>>> /drivers/i3c/master/dw-i3c-master.c: 724             in
>>> dw_i3c_master_priv_xfers()
>>> 718           if (!xfer)
>>> 719                   return -ENOMEM;
>>> 720
>>> 721           for (i = 0; i < i3c_nxfers; i++) {
>>> 722                   struct dw_i3c_cmd *cmd = &xfer->cmds[i];
>>> 723
>>>>>>       CID 294913:         Integer handling issues  (SIGN_EXTENSION)
>>>>>>       Suspicious implicit sign extension: "i3c_xfers[i].len" with type "u16" (16
>> bits, unsigned) is promoted in "i3c_xfers[i].len << 16" to type "int" (32 bits,
>> signed), then sign-extended to type "unsigned long" (64 bits, unsigned).  If
>> "i3c_xfers[i].len << 16" is greater than 0x7FFFFFFF, the upper bits of the result will
>> all be 1.
>>> 724                   cmd->cmd_hi =
>> COMMAND_PORT_ARG_DATA_LEN(i3c_xfers[i].len) |
>>> 725                           COMMAND_PORT_TRANSFER_ARG;
>>> 726
>>> 727                   if (i3c_xfers[i].rnw) {
>>> 728                           cmd->rx_buf = i3c_xfers[i].data.in;
>>> 729                           cmd->rx_len = i3c_xfers[i].len;
>>>
>>> ** CID 294627:       Integer handling issues  (BAD_SHIFT)
>>> /drivers/i3c/master.c: 181           in i3c_bus_get_addr_slot_status()
>>>
>>>
>>>
>> _________________________________________________________________
>> ____________________________
>>> *** CID 294627:         Integer handling issues  (BAD_SHIFT)
>>> /drivers/i3c/master.c: 181             in i3c_bus_get_addr_slot_status()
>>> 175           int status, bitpos = addr * 2;
>>> 176
>>> 177           if (addr > I2C_MAX_ADDR)
>>> 178                   return I3C_ADDR_SLOT_RSVD;
>>> 179
>>> 180           status = bus->addrslots[bitpos / BITS_PER_LONG];
>>>>>>       CID 294627:         Integer handling issues  (BAD_SHIFT)
>>>>>>       In expression "status >>= bitpos % 64", right shifting by more than 31 bits
>> has undefined behavior.  The shift amount, "bitpos % 64", is as much as 63.
>>> 181           status >>= bitpos % BITS_PER_LONG;
>>> 182
>>> 183           return status & I3C_ADDR_SLOT_STATUS_MASK;
>>> 184     }
>>> 185
>>> 186     static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
>>>
>>>
>>>
>>> View Defects in Coverity Scan
>>> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
>>>
>>> Best regards,
>>>
>>> The Coverity Scan Admin Team
>>>
>>> ----- End forwarded message -----
>>>
>>
>> --
>> Nabla Software Engineering
>> HRB 40522 Augsburg
>> Phone: +49 821 45592596
>> E-Mail: office@nabladev.com
>> Geschäftsführer : Stefano Babic

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
