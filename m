Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92DEE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 17:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2200C8946D;
	Sun,  8 Dec 2024 18:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuKpjSSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D758689473; Sun,  8 Dec 2024 18:46:36 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9966B893D9
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 18:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa64412dbbfso37153266b.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733679994; x=1734284794; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHiMRTefADvn/TtXMdLKMaLYQDojwqb4Xo9GH9ly3kk=;
 b=SuKpjSSB+SXJGMIGKJroZtxRJxtUegwu9p9WVongBZttr/jCHiANSw0a9G/f7LACxx
 oN/iO0HvwAlACLn9728Mq9p/hWEazzztqJIAY6H+iigWl/m0hMfLaY4kgt7n4bp1mfnB
 wA+2Uk5Se2oAUrQkkwjAKm48BhwX+twQqxc11rs8YRu2TuOQ1JERRBgizfZ1nK0AgJkS
 kprOzmQ0ESESXY1gpyZHVZXuNQWXFpRxRyN9lsekZxClZ9vq/baTDK5KnK7Q22PFqJZt
 CPaPTXI9mbcy9Bc43dmscdJ5gyDsPlQYKR7qoU/oOaC85I3nZhBCv6zOMKLBAsA4ZY7a
 bBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733679994; x=1734284794;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oHiMRTefADvn/TtXMdLKMaLYQDojwqb4Xo9GH9ly3kk=;
 b=B1HJBWiMKI8kpE82RmmT+JHK8f/uuoxQNMdTKojEGFb/T0+Nipmqf5+JasTL835ZPq
 Y+PaxMqgbPNJL3SLopKnvAYj/caABric9xaMCXCbby+BnZJU9aDtjkbtkVOhxXsJGJ/i
 GN66ZNeMtkR+XOewfnH0DpP8KmGYW748uYhHx6DC2E1JXtNaqe9jrV81tra8fAeBQ44E
 yqVx1eJwkguFwuhkeUd3sa6LzyYgTXQVUr6eEJv3NU0ENtXfAH3u0Zjne5d/92GNzCuE
 UkFY5uAZj4haLu1jJdwDkVKueBz05kAw6JKX+2nbn8/+ucy2T38TXQ62VHHI90qNnns2
 noWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQFQxIUMAQBVa0gHNnAjDZrevD+De6LlDm7LkCfiOmKl+6JVZBTolwOl3Yt88rvlgoJn0fT4U=@lists.denx.de
X-Gm-Message-State: AOJu0YzFqIAagedEDpJ6PA9H6HthnLLRwAZuZifVPfHMcLh7HnoB3G0Y
 4BQI0fSm7afpjnSaWPv78FYy2d51vwbopegTDpJKPBmLC2ncxPS0
X-Gm-Gg: ASbGncvwlrVvrUAFK0WBggq8pvKI3Jy5azy41Hyte1+mbGirZdSCOg578DCEr0B3SaW
 YLoxSh8LiJS+p+nq+ABmtNZFjUpduLS+Tyro1Yef00zo9r9wNpyZHMzNTpiWWfxmjGV66q7gC7h
 SWU13Rxo3ZGUWt10yIyY3GpdIF/U9faQq06/xb9QPfhGOmEA9ArX+TnbEB08KkrIlorxu0VDLjj
 ymsT1d39TThYPw/iXbaqJFEMTxsPhsRn9ClTqb/9WXYubIphfo5DUkObWKlgdLEaCya2IZG46Pe
 EEMrRqcveHCkIw==
X-Google-Smtp-Source: AGHT+IEUZNWW05nCR2vAGt/JudR/4O2nPs4djQ4tgCCNRME7nhzZRmDmUMvTjWr9dG8xNEGKSNKqrQ==
X-Received: by 2002:a05:6402:4305:b0:5d2:7356:e0e2 with SMTP id
 4fb4d7f45d1cf-5d3be69c8fbmr3722680a12.4.1733679993692; 
 Sun, 08 Dec 2024 09:46:33 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3cbd14892sm3568329a12.39.2024.12.08.09.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 09:46:32 -0800 (PST)
Message-ID: <74ac3e9a-f688-4e49-b54c-6756b6d40a65@gmail.com>
Date: Sun, 8 Dec 2024 18:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] rockchip: rk3066a/rk3188: use includes from dts/upstream
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The clock and power DT includes for rk3066a and rk3188 are now
available in the dts/upstream directory, so remove the ones that
are now redundant.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/clock/rk3066a-cru.h       |  31 ---
 include/dt-bindings/clock/rk3188-cru-common.h | 261 ------------------
 include/dt-bindings/clock/rk3188-cru.h        |  47 ----
 include/dt-bindings/power/rk3066-power.h      |  22 --
 include/dt-bindings/power/rk3188-power.h      |  24 --
 5 files changed, 385 deletions(-)
 delete mode 100644 include/dt-bindings/clock/rk3066a-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3188-cru-common.h
 delete mode 100644 include/dt-bindings/clock/rk3188-cru.h
 delete mode 100644 include/dt-bindings/power/rk3066-power.h
 delete mode 100644 include/dt-bindings/power/rk3188-power.h

diff --git a/include/dt-bindings/clock/rk3066a-cru.h b/include/dt-bindings/clock/rk3066a-cru.h
deleted file mode 100644
index 014eec586689..000000000000
--- a/include/dt-bindings/clock/rk3066a-cru.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2014 MundoReader S.L.
- * Author: Heiko Stuebner <heiko@sntech.de>
- */
-
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3066A_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK3066A_H
-
-#include <dt-bindings/clock/rk3188-cru-common.h>
-
-/* soft-reset indices */
-#define SRST_SRST1		0
-#define SRST_SRST2		1
-
-#define SRST_L2MEM		18
-#define SRST_I2S0		23
-#define SRST_I2S1		24
-#define SRST_I2S2		25
-#define SRST_TIMER2		29
-
-#define SRST_GPIO4		36
-#define SRST_GPIO6		38
-
-#define SRST_TSADC		92
-
-#define SRST_HDMI		96
-#define SRST_HDMI_APB		97
-#define SRST_CIF1		111
-
-#endif
diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
deleted file mode 100644
index afad90680fce..000000000000
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ /dev/null
@@ -1,261 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2014 MundoReader S.L.
- * Author: Heiko Stuebner <heiko@sntech.de>
- */
-
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3188_COMMON_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK3188_COMMON_H
-
-/* core clocks from */
-#define PLL_APLL		1
-#define PLL_DPLL		2
-#define PLL_CPLL		3
-#define PLL_GPLL		4
-#define CORE_PERI		5
-#define CORE_L2C		6
-#define ARMCLK			7
-
-/* sclk gates (special clocks) */
-#define SCLK_UART0		64
-#define SCLK_UART1		65
-#define SCLK_UART2		66
-#define SCLK_UART3		67
-#define SCLK_MAC		68
-#define SCLK_SPI0		69
-#define SCLK_SPI1		70
-#define SCLK_SARADC		71
-#define SCLK_SDMMC		72
-#define SCLK_SDIO		73
-#define SCLK_EMMC		74
-#define SCLK_I2S0		75
-#define SCLK_I2S1		76
-#define SCLK_I2S2		77
-#define SCLK_SPDIF		78
-#define SCLK_CIF0		79
-#define SCLK_CIF1		80
-#define SCLK_OTGPHY0		81
-#define SCLK_OTGPHY1		82
-#define SCLK_HSADC		83
-#define SCLK_TIMER0		84
-#define SCLK_TIMER1		85
-#define SCLK_TIMER2		86
-#define SCLK_TIMER3		87
-#define SCLK_TIMER4		88
-#define SCLK_TIMER5		89
-#define SCLK_TIMER6		90
-#define SCLK_JTAG		91
-#define SCLK_SMC		92
-#define SCLK_TSADC		93
-
-#define DCLK_LCDC0		190
-#define DCLK_LCDC1		191
-
-/* aclk gates */
-#define ACLK_DMA1		192
-#define ACLK_DMA2		193
-#define ACLK_GPS		194
-#define ACLK_LCDC0		195
-#define ACLK_LCDC1		196
-#define ACLK_GPU		197
-#define ACLK_SMC		198
-#define ACLK_CIF1		199
-#define ACLK_IPP		200
-#define ACLK_RGA		201
-#define ACLK_CIF0		202
-#define ACLK_CPU		203
-#define ACLK_PERI		204
-#define ACLK_VEPU		205
-#define ACLK_VDPU		206
-
-/* pclk gates */
-#define PCLK_GRF		320
-#define PCLK_PMU		321
-#define PCLK_TIMER0		322
-#define PCLK_TIMER1		323
-#define PCLK_TIMER2		324
-#define PCLK_TIMER3		325
-#define PCLK_PWM01		326
-#define PCLK_PWM23		327
-#define PCLK_SPI0		328
-#define PCLK_SPI1		329
-#define PCLK_SARADC		330
-#define PCLK_WDT		331
-#define PCLK_UART0		332
-#define PCLK_UART1		333
-#define PCLK_UART2		334
-#define PCLK_UART3		335
-#define PCLK_I2C0		336
-#define PCLK_I2C1		337
-#define PCLK_I2C2		338
-#define PCLK_I2C3		339
-#define PCLK_I2C4		340
-#define PCLK_GPIO0		341
-#define PCLK_GPIO1		342
-#define PCLK_GPIO2		343
-#define PCLK_GPIO3		344
-#define PCLK_GPIO4		345
-#define PCLK_GPIO6		346
-#define PCLK_EFUSE		347
-#define PCLK_TZPC		348
-#define PCLK_TSADC		349
-#define PCLK_CPU		350
-#define PCLK_PERI		351
-#define PCLK_DDRUPCTL		352
-#define PCLK_PUBL		353
-
-/* hclk gates */
-#define HCLK_SDMMC		448
-#define HCLK_SDIO		449
-#define HCLK_EMMC		450
-#define HCLK_OTG0		451
-#define HCLK_EMAC		452
-#define HCLK_SPDIF		453
-#define HCLK_I2S0		454
-#define HCLK_I2S1		455
-#define HCLK_I2S2		456
-#define HCLK_OTG1		457
-#define HCLK_HSIC		458
-#define HCLK_HSADC		459
-#define HCLK_PIDF		460
-#define HCLK_LCDC0		461
-#define HCLK_LCDC1		462
-#define HCLK_ROM		463
-#define HCLK_CIF0		464
-#define HCLK_IPP		465
-#define HCLK_RGA		466
-#define HCLK_NANDC0		467
-#define HCLK_CPU		468
-#define HCLK_PERI		469
-#define HCLK_CIF1		470
-#define HCLK_VEPU		471
-#define HCLK_VDPU		472
-#define HCLK_HDMI		473
-
-#define CLK_NR_CLKS		(HCLK_HDMI + 1)
-
-/* soft-reset indices */
-#define SRST_MCORE		2
-#define SRST_CORE0		3
-#define SRST_CORE1		4
-#define SRST_MCORE_DBG		7
-#define SRST_CORE0_DBG		8
-#define SRST_CORE1_DBG		9
-#define SRST_CORE0_WDT		12
-#define SRST_CORE1_WDT		13
-#define SRST_STRC_SYS		14
-#define SRST_L2C		15
-
-#define SRST_CPU_AHB		17
-#define SRST_AHB2APB		19
-#define SRST_DMA1		20
-#define SRST_INTMEM		21
-#define SRST_ROM		22
-#define SRST_SPDIF		26
-#define SRST_TIMER0		27
-#define SRST_TIMER1		28
-#define SRST_EFUSE		30
-
-#define SRST_GPIO0		32
-#define SRST_GPIO1		33
-#define SRST_GPIO2		34
-#define SRST_GPIO3		35
-
-#define SRST_UART0		39
-#define SRST_UART1		40
-#define SRST_UART2		41
-#define SRST_UART3		42
-#define SRST_I2C0		43
-#define SRST_I2C1		44
-#define SRST_I2C2		45
-#define SRST_I2C3		46
-#define SRST_I2C4		47
-
-#define SRST_PWM0		48
-#define SRST_PWM1		49
-#define SRST_DAP_PO		50
-#define SRST_DAP		51
-#define SRST_DAP_SYS		52
-#define SRST_TPIU_ATB		53
-#define SRST_PMU_APB		54
-#define SRST_GRF		55
-#define SRST_PMU		56
-#define SRST_PERI_AXI		57
-#define SRST_PERI_AHB		58
-#define SRST_PERI_APB		59
-#define SRST_PERI_NIU		60
-#define SRST_CPU_PERI		61
-#define SRST_EMEM_PERI		62
-#define SRST_USB_PERI		63
-
-#define SRST_DMA2		64
-#define SRST_SMC		65
-#define SRST_MAC		66
-#define SRST_NANC0		68
-#define SRST_USBOTG0		69
-#define SRST_USBPHY0		70
-#define SRST_OTGC0		71
-#define SRST_USBOTG1		72
-#define SRST_USBPHY1		73
-#define SRST_OTGC1		74
-#define SRST_HSADC		76
-#define SRST_PIDFILTER		77
-#define SRST_DDR_MSCH		79
-
-#define SRST_TZPC		80
-#define SRST_SDMMC		81
-#define SRST_SDIO		82
-#define SRST_EMMC		83
-#define SRST_SPI0		84
-#define SRST_SPI1		85
-#define SRST_WDT		86
-#define SRST_SARADC		87
-#define SRST_DDRPHY		88
-#define SRST_DDRPHY_APB		89
-#define SRST_DDRCTL		90
-#define SRST_DDRCTL_APB		91
-#define SRST_DDRPUB		93
-
-#define SRST_VIO0_AXI		98
-#define SRST_VIO0_AHB		99
-#define SRST_LCDC0_AXI		100
-#define SRST_LCDC0_AHB		101
-#define SRST_LCDC0_DCLK		102
-#define SRST_LCDC1_AXI		103
-#define SRST_LCDC1_AHB		104
-#define SRST_LCDC1_DCLK		105
-#define SRST_IPP_AXI		106
-#define SRST_IPP_AHB		107
-#define SRST_RGA_AXI		108
-#define SRST_RGA_AHB		109
-#define SRST_CIF0		110
-
-#define SRST_VCODEC_AXI		112
-#define SRST_VCODEC_AHB		113
-#define SRST_VIO1_AXI		114
-#define SRST_VCODEC_CPU		115
-#define SRST_VCODEC_NIU		116
-#define SRST_GPU		120
-#define SRST_GPU_NIU		122
-#define SRST_TFUN_ATB		125
-#define SRST_TFUN_APB		126
-#define SRST_CTI4_APB		127
-
-#define SRST_TPIU_APB		128
-#define SRST_TRACE		129
-#define SRST_CORE_DBG		130
-#define SRST_DBG_APB		131
-#define SRST_CTI0		132
-#define SRST_CTI0_APB		133
-#define SRST_CTI1		134
-#define SRST_CTI1_APB		135
-#define SRST_PTM_CORE0		136
-#define SRST_PTM_CORE1		137
-#define SRST_PTM0		138
-#define SRST_PTM0_ATB		139
-#define SRST_PTM1		140
-#define SRST_PTM1_ATB		141
-#define SRST_CTM		142
-#define SRST_TS			143
-
-#endif
diff --git a/include/dt-bindings/clock/rk3188-cru.h b/include/dt-bindings/clock/rk3188-cru.h
deleted file mode 100644
index 1da306e1788c..000000000000
--- a/include/dt-bindings/clock/rk3188-cru.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2014 MundoReader S.L.
- * Author: Heiko Stuebner <heiko@sntech.de>
- */
-
-#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3188_H
-#define _DT_BINDINGS_CLK_ROCKCHIP_RK3188_H
-
-#include <dt-bindings/clock/rk3188-cru-common.h>
-
-/* soft-reset indices */
-#define SRST_PTM_CORE2		0
-#define SRST_PTM_CORE3		1
-#define SRST_CORE2		5
-#define SRST_CORE3		6
-#define SRST_CORE2_DBG		10
-#define SRST_CORE3_DBG		11
-
-#define SRST_TIMER2		16
-#define SRST_TIMER4		23
-#define SRST_I2S0		24
-#define SRST_TIMER5		25
-#define SRST_TIMER3		29
-#define SRST_TIMER6		31
-
-#define SRST_PTM3		36
-#define SRST_PTM3_ATB		37
-
-#define SRST_GPS		67
-#define SRST_HSICPHY		75
-#define SRST_TIMER		78
-
-#define SRST_PTM2		92
-#define SRST_CORE2_WDT		94
-#define SRST_CORE3_WDT		95
-
-#define SRST_PTM2_ATB		111
-
-#define SRST_HSIC		117
-#define SRST_CTI2		118
-#define SRST_CTI2_APB		119
-#define SRST_GPU_BRIDGE		121
-#define SRST_CTI3		123
-#define SRST_CTI3_APB		124
-
-#endif
diff --git a/include/dt-bindings/power/rk3066-power.h b/include/dt-bindings/power/rk3066-power.h
deleted file mode 100644
index acf9f310ac53..000000000000
--- a/include/dt-bindings/power/rk3066-power.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_BINDINGS_POWER_RK3066_POWER_H__
-#define __DT_BINDINGS_POWER_RK3066_POWER_H__
-
-/* VD_CORE */
-#define RK3066_PD_A9_0		0
-#define RK3066_PD_A9_1		1
-#define RK3066_PD_DBG		4
-#define RK3066_PD_SCU		5
-
-/* VD_LOGIC */
-#define RK3066_PD_VIDEO		6
-#define RK3066_PD_VIO		7
-#define RK3066_PD_GPU		8
-#define RK3066_PD_PERI		9
-#define RK3066_PD_CPU		10
-#define RK3066_PD_ALIVE		11
-
-/* VD_PMU */
-#define RK3066_PD_RTC		12
-
-#endif
diff --git a/include/dt-bindings/power/rk3188-power.h b/include/dt-bindings/power/rk3188-power.h
deleted file mode 100644
index 93d23dfba33f..000000000000
--- a/include/dt-bindings/power/rk3188-power.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_BINDINGS_POWER_RK3188_POWER_H__
-#define __DT_BINDINGS_POWER_RK3188_POWER_H__
-
-/* VD_CORE */
-#define RK3188_PD_A9_0		0
-#define RK3188_PD_A9_1		1
-#define RK3188_PD_A9_2		2
-#define RK3188_PD_A9_3		3
-#define RK3188_PD_DBG		4
-#define RK3188_PD_SCU		5
-
-/* VD_LOGIC */
-#define RK3188_PD_VIDEO		6
-#define RK3188_PD_VIO		7
-#define RK3188_PD_GPU		8
-#define RK3188_PD_PERI		9
-#define RK3188_PD_CPU		10
-#define RK3188_PD_ALIVE		11
-
-/* VD_PMU */
-#define RK3188_PD_RTC		12
-
-#endif
--
2.39.5

