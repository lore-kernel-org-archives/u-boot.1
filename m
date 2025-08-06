Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C01C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DEFF83AB9;
	Wed,  6 Aug 2025 20:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fewb2O2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2B683ACA; Wed,  6 Aug 2025 20:35:51 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2046183A35
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3e3f449fa6fso1234145ab.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754505347; x=1755110147; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olgsdqvKDHCnjOueuzM12PTRqjtE412jTiS6aHmIyX0=;
 b=Fewb2O2EAGqQyVzIsvvmPGc7tYcIxk8wwCLG4A+hFqCTaMVUok+A3LCMFMollfzk6x
 KHLHedVkrY0G7TqUHO/cwgEK3D50hAziUZc99S/84p/SF5tg6nO6c+GtxZGZqql9B4sN
 60PeNeh2ziOHjs5/vPVgqAhM7s6JZ/TX+l5sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754505347; x=1755110147;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=olgsdqvKDHCnjOueuzM12PTRqjtE412jTiS6aHmIyX0=;
 b=dPzN4GZM61gGu6yXXZUVhdvE9t6rFYXmH3hZ9sIK22d5dSPhv0KqK8Rm6coa1xGvVr
 9Mf3uzYLwF/DR7sLhK4VlwiIq2B5IZdWkh6ipGx4I7yhObSMtUhymvMcqswlUZOosnV2
 XQola7yr33mUgrE63Kjd1EocCNwPxQp3p+0CAoH6PEVkoYFQcZ5h1RSVjAhnkfmbYZsk
 QBgskiEZJtS30LZgn/onhpCICT/msWslpHGpF3YoF7Ajs5+ZJUpJWrR91TWEKagZlMgh
 CeUGH7Hl+11sPODQQLPaXwGl9O3L3VZD8Q5APDRGsBa/puUyn+q98mSCHv6TdMi/fevj
 sydw==
X-Gm-Message-State: AOJu0YwP8IH3/kPEe8BkLcdta1OIHBB3DO1+/tXgMIBH5CTqum3UptOH
 WExe44NsQ2kFQnyV9qZHnfuUTrikfW/0b4wXJlfJx63K1N/OwEp4qQBBIutQqtW/28Nj01nkLai
 bOB6JXag=
X-Gm-Gg: ASbGnctSYtifVoE3ww7AHhiNvyfhGzAndIvBhBLHd/yNaelYmMyiSUDPZ/IWI8c6K4g
 Ji3/THS2ta6/2Lp0ysju4JWNovEzlEk6rhWLn2kVEFvrdV/0xAE9oG5H1ywMlBpbq+jYddsw1jS
 WiuoYCJmjnUBintDfy7HAAg4rlmJk363edgkeZ+V4D2eplvdSVEAZ6WnKQyDWLlpjHFCwkMnm9W
 lZzmlxpVRH5tSxllESTcgSSPqWHCDkqmSLQHjjclBpT0abhfhJRiAZOr7jfgmvDTeHkDEyDqm7l
 8xiGxZ2iQc47dfheu5aLZ6UGcFE9/ryGiqiIWn5Ih6P8imEjqlvDHvJ2No0NkLhug85Ey/ScVC7
 p4YbNnRU9wDlvIyARiI1NdxnKZwM8hJc69auCD9M7jz20jgVvrg/bNr4T
X-Google-Smtp-Source: AGHT+IFyVETtcpfQ3EE9XOTckvPiS5MmJ6L1aU9XXz8EFoSJV+CgiqixAMoM93bDdXmzYAmai0uadA==
X-Received: by 2002:a05:6e02:19c8:b0:3e3:fc32:3182 with SMTP id
 e9e14a558f8ab-3e5258ac7b3mr5195985ab.5.1754505346634; 
 Wed, 06 Aug 2025 11:35:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50abf02ad52sm1202309173.45.2025.08.06.11.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:35:45 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:35:43 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250806183543.GR124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="odqRfJYLLGROZhRv"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--odqRfJYLLGROZhRv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report. Lets get these new issues addressed ASAP
please, thanks.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Wed, Aug 6, 2025 at 12:23=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 8
   - 4 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 8 of 8 defect(s)

Defect Details

** CID 583812:       Integer handling issues  (BAD_SHIFT)
/drivers/i3c/master/dw-i3c-master.c: 1001           in dw_i3c_probe()


___________________________________________________________________________=
__________________
*** CID 583812:         Integer handling issues  (BAD_SHIFT)
/drivers/i3c/master/dw-i3c-master.c: 1001             in dw_i3c_probe()
995     	ret =3D readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
996     	master->caps.datafifodepth =3D DATA_BUFFER_STATUS_LEVEL_TX(ret);
997
998     	ret =3D readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
999     	master->datstartaddr =3D ret;
1000     	master->maxdevs =3D ret >> 16;
>>>     CID 583812:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "0xffffffffffffffffUL >> 63 - (master->maxdevs - 1)",=
 right shifting by more than 63 bits has undefined behavior.  The shift amo=
unt, "63 - (master->maxdevs - 1)", is 64.
1001     	master->free_pos =3D GENMASK(master->maxdevs - 1, 0);
1002
1003     	ret =3D i3c_master_register(&master->base, dev,
1004     				  &dw_mipi_i3c_ops, false);
1005     	if (ret)
1006     		goto err_assert_rst;

** CID 583811:         (RESOURCE_LEAK)
/drivers/i3c/master.c: 1610           in of_i3c_master_add_i3c_boardinfo()
/drivers/i3c/master.c: 1586           in of_i3c_master_add_i3c_boardinfo()
/drivers/i3c/master.c: 1591           in of_i3c_master_add_i3c_boardinfo()
/drivers/i3c/master.c: 1598           in of_i3c_master_add_i3c_boardinfo()
/drivers/i3c/master.c: 1603           in of_i3c_master_add_i3c_boardinfo()


___________________________________________________________________________=
__________________
*** CID 583811:           (RESOURCE_LEAK)
/drivers/i3c/master.c: 1610             in of_i3c_master_add_i3c_boardinfo()
1604     	}
1605
1606     	boardinfo->pid =3D ((u64)reg[1] << 32) | reg[2];
1607
1608     	if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
1609     	    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
>>>     CID 583811:           (RESOURCE_LEAK)
>>>     Variable "boardinfo" going out of scope leaks the storage it points=
 to.
1610     		return -EINVAL;
1611
1612     	boardinfo->init_dyn_addr =3D init_dyn_addr;
1613     	boardinfo->of_node =3D node;
1614     	list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
1615
/drivers/i3c/master.c: 1586             in of_i3c_master_add_i3c_boardinfo()
1580     	boardinfo =3D devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
1581     	if (!boardinfo)
1582     		return -ENOMEM;
1583
1584     	if (reg[0]) {
1585     		if (reg[0] > I3C_MAX_ADDR)
>>>     CID 583811:           (RESOURCE_LEAK)
>>>     Variable "boardinfo" going out of scope leaks the storage it points=
 to.
1586     			return -EINVAL;
1587
1588     		addrstatus =3D i3c_bus_get_addr_slot_status(&master->bus,
1589     							  reg[0]);
1590     		if (addrstatus !=3D I3C_ADDR_SLOT_FREE)
1591     			return -EINVAL;
/drivers/i3c/master.c: 1591             in of_i3c_master_add_i3c_boardinfo()
1585     		if (reg[0] > I3C_MAX_ADDR)
1586     			return -EINVAL;
1587
1588     		addrstatus =3D i3c_bus_get_addr_slot_status(&master->bus,
1589     							  reg[0]);
1590     		if (addrstatus !=3D I3C_ADDR_SLOT_FREE)
>>>     CID 583811:           (RESOURCE_LEAK)
>>>     Variable "boardinfo" going out of scope leaks the storage it points=
 to.
1591     			return -EINVAL;
1592     	}
1593
1594     	boardinfo->static_addr =3D reg[0];
1595
1596     	if (!dev_read_u32(dev, "assigned-address", &init_dyn_addr)) {
/drivers/i3c/master.c: 1598             in of_i3c_master_add_i3c_boardinfo()
1592     	}
1593
1594     	boardinfo->static_addr =3D reg[0];
1595
1596     	if (!dev_read_u32(dev, "assigned-address", &init_dyn_addr)) {
1597     		if (init_dyn_addr > I3C_MAX_ADDR)
>>>     CID 583811:           (RESOURCE_LEAK)
>>>     Variable "boardinfo" going out of scope leaks the storage it points=
 to.
1598     			return -EINVAL;
1599
1600     		addrstatus =3D i3c_bus_get_addr_slot_status(&master->bus,
1601     							  init_dyn_addr);
1602     		if (addrstatus !=3D I3C_ADDR_SLOT_FREE)
1603     			return -EINVAL;
/drivers/i3c/master.c: 1603             in of_i3c_master_add_i3c_boardinfo()
1597     		if (init_dyn_addr > I3C_MAX_ADDR)
1598     			return -EINVAL;
1599
1600     		addrstatus =3D i3c_bus_get_addr_slot_status(&master->bus,
1601     							  init_dyn_addr);
1602     		if (addrstatus !=3D I3C_ADDR_SLOT_FREE)
>>>     CID 583811:           (RESOURCE_LEAK)
>>>     Variable "boardinfo" going out of scope leaks the storage it points=
 to.
1603     			return -EINVAL;
1604     	}
1605
1606     	boardinfo->pid =3D ((u64)reg[1] << 32) | reg[2];
1607
1608     	if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||

** CID 298388:       Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 579           in dw_i3c_ccc_get()


___________________________________________________________________________=
__________________
*** CID 298388:         Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 579             in dw_i3c_ccc_get()
573     		return -ENOMEM;
574
575     	cmd =3D xfer->cmds;
576     	cmd->rx_buf =3D ccc->dests[0].payload.data;
577     	cmd->rx_len =3D ccc->dests[0].payload.len;
578
>>>     CID 298388:         Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "ccc->dests[0].payload.len" wit=
h type "u16" (16 bits, unsigned) is promoted in "ccc->dests[0].payload.len =
<< 16" to type "int" (32 bits, signed), then sign-extended to type "unsigne=
d long" (64 bits, unsigned).  If "ccc->dests[0].payload.len << 16" is great=
er than 0x7FFFFFFF, the upper bits of the result will all be 1.
579     	cmd->cmd_hi =3D COMMAND_PORT_ARG_DATA_LEN(ccc->dests[0].payload.le=
n) |
580     		      COMMAND_PORT_TRANSFER_ARG;
581
582     	cmd->cmd_lo =3D COMMAND_PORT_READ_TRANSFER |
583     		      COMMAND_PORT_CP |
584     		      COMMAND_PORT_DEV_INDEX(pos) |

** CID 298037:       Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 375           in dw_i3c_clk_cfg()


___________________________________________________________________________=
__________________
*** CID 298037:         Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 375             in dw_i3c_clk_cfg()
369     	scl_timing =3D SCL_EXT_LCNT_1(lcnt);
370     	lcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
371     	scl_timing |=3D SCL_EXT_LCNT_2(lcnt);
372     	lcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
373     	scl_timing |=3D SCL_EXT_LCNT_3(lcnt);
374     	lcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
>>>     CID 298037:         Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "lcnt" with type "u8" (8 bits, =
unsigned) is promoted in "lcnt << 24" to type "int" (32 bits, signed), then=
 sign-extended to type "unsigned long" (64 bits, unsigned).  If "lcnt << 24=
" is greater than 0x7FFFFFFF, the upper bits of the result will all be 1.
375     	scl_timing |=3D SCL_EXT_LCNT_4(lcnt);
376     	writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
377
378     	return 0;
379     }
380

** CID 296053:       Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 535           in dw_i3c_ccc_set()


___________________________________________________________________________=
__________________
*** CID 296053:         Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 535             in dw_i3c_ccc_set()
529     		return -ENOMEM;
530
531     	cmd =3D xfer->cmds;
532     	cmd->tx_buf =3D ccc->dests[0].payload.data;
533     	cmd->tx_len =3D ccc->dests[0].payload.len;
534
>>>     CID 296053:         Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "ccc->dests[0].payload.len" wit=
h type "u16" (16 bits, unsigned) is promoted in "ccc->dests[0].payload.len =
<< 16" to type "int" (32 bits, signed), then sign-extended to type "unsigne=
d long" (64 bits, unsigned).  If "ccc->dests[0].payload.len << 16" is great=
er than 0x7FFFFFFF, the upper bits of the result will all be 1.
535     	cmd->cmd_hi =3D COMMAND_PORT_ARG_DATA_LEN(ccc->dests[0].payload.le=
n) |
536     		      COMMAND_PORT_TRANSFER_ARG;
537
538     	cmd->cmd_lo =3D COMMAND_PORT_CP |
539     		      COMMAND_PORT_DEV_INDEX(pos) |
540     		      COMMAND_PORT_CMD(ccc->id) |

** CID 295976:         (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 395           in dw_i2c_clk_cfg()
/drivers/i3c/master/dw-i3c-master.c: 401           in dw_i2c_clk_cfg()


___________________________________________________________________________=
__________________
*** CID 295976:           (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 395             in dw_i2c_clk_cfg()
389     		return -EINVAL;
390
391     	core_period =3D DIV_ROUND_UP(1000000000, core_rate);
392
393     	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
394     	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - l=
cnt;
>>>     CID 295976:           (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "hcnt" with type "u16" (16 bits=
, unsigned) is promoted in "hcnt << 16" to type "int" (32 bits, signed), th=
en sign-extended to type "unsigned long" (64 bits, unsigned).  If "hcnt << =
16" is greater than 0x7FFFFFFF, the upper bits of the result will all be 1.
395     	scl_timing =3D SCL_I2C_FMP_TIMING_HCNT(hcnt) |
396     		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
397     	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
398
399     	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
400     	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
/drivers/i3c/master/dw-i3c-master.c: 401             in dw_i2c_clk_cfg()
395     	scl_timing =3D SCL_I2C_FMP_TIMING_HCNT(hcnt) |
396     		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
397     	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
398
399     	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
400     	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
>>>     CID 295976:           (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "hcnt" with type "u16" (16 bits=
, unsigned) is promoted in "hcnt << 16" to type "int" (32 bits, signed), th=
en sign-extended to type "unsigned long" (64 bits, unsigned).  If "hcnt << =
16" is greater than 0x7FFFFFFF, the upper bits of the result will all be 1.
401     	scl_timing =3D SCL_I2C_FM_TIMING_HCNT(hcnt) |
402     		     SCL_I2C_FM_TIMING_LCNT(lcnt);
403     	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
404
405     	writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
406     	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_I2C_SLAVE_PRES=
ENT,

** CID 294913:       Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 724           in dw_i3c_master_priv_xf=
ers()


___________________________________________________________________________=
__________________
*** CID 294913:         Integer handling issues  (SIGN_EXTENSION)
/drivers/i3c/master/dw-i3c-master.c: 724             in
dw_i3c_master_priv_xfers()
718     	if (!xfer)
719     		return -ENOMEM;
720
721     	for (i =3D 0; i < i3c_nxfers; i++) {
722     		struct dw_i3c_cmd *cmd =3D &xfer->cmds[i];
723
>>>     CID 294913:         Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension: "i3c_xfers[i].len" with type "u=
16" (16 bits, unsigned) is promoted in "i3c_xfers[i].len << 16" to type "in=
t" (32 bits, signed), then sign-extended to type "unsigned long" (64 bits, =
unsigned).  If "i3c_xfers[i].len << 16" is greater than 0x7FFFFFFF, the upp=
er bits of the result will all be 1.
724     		cmd->cmd_hi =3D COMMAND_PORT_ARG_DATA_LEN(i3c_xfers[i].len) |
725     			COMMAND_PORT_TRANSFER_ARG;
726
727     		if (i3c_xfers[i].rnw) {
728     			cmd->rx_buf =3D i3c_xfers[i].data.in;
729     			cmd->rx_len =3D i3c_xfers[i].len;

** CID 294627:       Integer handling issues  (BAD_SHIFT)
/drivers/i3c/master.c: 181           in i3c_bus_get_addr_slot_status()


___________________________________________________________________________=
__________________
*** CID 294627:         Integer handling issues  (BAD_SHIFT)
/drivers/i3c/master.c: 181             in i3c_bus_get_addr_slot_status()
175     	int status, bitpos =3D addr * 2;
176
177     	if (addr > I2C_MAX_ADDR)
178     		return I3C_ADDR_SLOT_RSVD;
179
180     	status =3D bus->addrslots[bitpos / BITS_PER_LONG];
>>>     CID 294627:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "status >>=3D bitpos % 64", right shifting by more th=
an 31 bits has undefined behavior.  The shift amount, "bitpos % 64", is as =
much as 63.
181     	status >>=3D bitpos % BITS_PER_LONG;
182
183     	return status & I3C_ADDR_SLOT_STATUS_MASK;
184     }
185
186     static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 a=
ddr,



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--odqRfJYLLGROZhRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJOgewAKCRAr4qD1Cr/k
Cp9dAQDWIFoCRKOqaE3IbDIJ3gWDSQn4Nsg6NXqCRshnNSEw2QEAgPM8pIV0eg+c
6DrIMpRGTuzZOlQ+ZOcYgxA3+HKIags=
=gG1S
-----END PGP SIGNATURE-----

--odqRfJYLLGROZhRv--
