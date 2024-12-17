Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D87AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D425F801CF;
	Tue, 17 Dec 2024 12:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VA8AqbDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23FA8020C; Tue, 17 Dec 2024 12:19:01 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D07C801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163dc5155fso43964275ad.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734434338; x=1735039138; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bMiL7Hthlft+6Qw9xlJZzi472yWWQ8YZgBX4z5IUDfQ=;
 b=VA8AqbDEFR5u2i+k+p4HVhoOGN42bNQhJqOLwpkjcr4mBMP4zt7JUBPss/ieb4cZH+
 vKRQm67VKINgbMVlA4zTpOCNQGtUMLn3gXPSR5ZvGYGINxrX+fIRW143edjEgeEIuVND
 35op7lgOJHzqWHPu6Ph3UgeY8z0wtR6H3utqyN2zIaOiqO78rm2vtlQU6eaFG6JjYSxu
 71qy4wWW1FrCo3uc+7JPEPiDJW8zl8apY48/J/vlul4MeYLvXCNaGZjo72Fm0n2I1U4L
 xBBr9VL71GcnWH1h/ranD/9/LtSp1hvhCuKRWcodxR8h4RGwgpXcLZbmHa2zJkNK14o6
 FCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734434338; x=1735039138;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bMiL7Hthlft+6Qw9xlJZzi472yWWQ8YZgBX4z5IUDfQ=;
 b=oXxYIQ8V4DlmCnTxmEdQDUEQvx9NMmGbTGGf1ckf0tFvg9FU4N8HTAGaaBVGr/jMm+
 nK7Z3MfjSEWPs+dQ28KdZ7DP6GfMnFVI4O/W876lUgMKLUEz1uB4UaKw6omPQNRxnuhW
 71kxnp8/mxCuzS0TpUBGGwcbdCUwWxs8+IWeTSgt8F8SArL4811gN0DfRIV7hJIaEbhN
 NoPdjm6HKWqxJtDeY0Z2Fz6MjQovQBcid8lE339SlhDTKwb9OJuFwYbR45EyrL8cff2+
 Yk/5BVH8u2NcRHnUWRBEL+IO+Qgc6TWOFWq5Z2azCVHf0Eq3U1e1cvx4GrvSh4VS6TFI
 pvhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1dttVS+ecWMhtFtrriMcFxYPj8x2pcty/ixCWNf2ICBiiTUFPACjM5hagYazrjuVxhRtnkTY=@lists.denx.de
X-Gm-Message-State: AOJu0YypGp2uCDKx/9Nd72WGt6bEDRzm+lT4dCQWu4nGrCt80kwXuZbu
 4wSh8+5k1NU9zWktAlUW2xK3h3dJhVZt2wKyqlaYrHyYvCFlHwJa
X-Gm-Gg: ASbGncs0+gty4+MFnUx1oCyo8I3EI5ZaLdYwKbz0hp3xVGbb7ZGAQEpo9nzcCUMI4s/
 wIzA3tf7q7XDbSd9d3ZLja8662SFesNmK0Q4ZqqXN/zepQEnEq/7/UcqlSktfa5z6Ev4YUdjAmg
 8a/bM++2DCfwMFZ/1T/yzOxfDdu4A0XfzbJTv4WZ2/7Fxk+TcAsEDUhxkBro+hDtTpIrx7m4A1b
 jEiw3cLx0G8CPVRnwup1vyTVqIm3tb7Cd6c5qjLSb1fsUEr3xOkuEWew4wqWVrzHFakGNRCJUgl
 GulEvx09kSA54Ao=
X-Google-Smtp-Source: AGHT+IF84m9AaztOQKjkAyQK7ZLof6xiTe+K/vjfLace8ehjCfE/Y6GeNSRuliScgHSrViz66LPIMQ==
X-Received: by 2002:a17:903:2b08:b0:216:138a:5956 with SMTP id
 d9443c01a7336-218c8dbfa33mr45754985ad.19.1734434337754; 
 Tue, 17 Dec 2024 03:18:57 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5ae9abbsm5553164a12.50.2024.12.17.03.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 03:18:57 -0800 (PST)
Date: Tue, 17 Dec 2024 08:18:50 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
 <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
 <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
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

> 
> Okay. Please try changing the value of ram_top to 0x1_0000_0000
> instead of 0xFFFF_FFFF. That should work.
>

Changing ram_top to 0x1_0000_0000 worked:

U-Boot SPL 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
DDR configured as dual rank
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
Find img info 0x4802d400, size 1116
Need continue download 1024
NOTICE:  BL31: v2.6(release):lf_v2.6-g3c1583ba0a
NOTICE:  BL31: Built : 11:00:38, Nov 21 2022


U-Boot 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)

CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
CPU:   Industrial temperature grade (-40C to 105C) at 54C
Reset cause: POR
DRAM:  Ram top: 100000000
8 GiB
Core:  183 devices, 31 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(2)... OK
In:    serial@30880000
Out:   serial@30880000
Err:   serial@30880000
Model: Toradex 0070 Verdin iMX8M Plus Quad 8GB WB IT V1.1A
Serial#: 15207893
Carrier: Toradex Dahlia V1.1C, Serial# 11060859
SEC0:  RNG instantiated
Setting variant to wifi
Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
Hit any key to stop autoboot:  0 
MMC: no card present
switch to partitions #0, OK
mmc2(part 0) is current device
Scanning mmc 2:1...
Found U-Boot script /boot.scr
5974 bytes read in 1 ms (5.7 MiB/s)
## Executing script at 50280000
Loading DeviceTree: imx8mp-verdin-wifi-dev.dtb
...
Starting kernel ...

The change is shown in the patch below, but I am unsure if this is the
correct solution. Should ram_top be the last valid address or the upper
bound?

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 9588b8b28bf2..e01774ebc8a4 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
         * space below the 4G address boundary (which is 3GiB big),
         * even when the effective available memory is bigger.
         */
-       top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xffffffff);
+       top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0x100000000);
 
        /*
         * rom_pointer[0] stores the TEE memory start address.

Best Regards,
João Paulo Gonçalves
