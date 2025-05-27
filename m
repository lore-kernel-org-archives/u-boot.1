Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3324C5AD49
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 23:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045AE8319F;
	Wed, 28 May 2025 01:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PP5oUK/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5826831B4; Wed, 28 May 2025 01:50:47 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8218319C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60634f82c77so759267eaf.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748389843; x=1748994643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CHiSt+sxRr2adxz+YOnvb9Ey3YSRSbgAdpa+D7SIcDY=;
 b=PP5oUK/dSN4U59DhnN+SgB01aG1bs5H97xFX9+wrPyE1S+AUSnt47ek87rnB8V2Ane
 hT/JpXcPlQvEb7L4W4Tonm+tlKxt+QKNYCH82sl+dunTAfwIoajsyRvUsbTtZhTmryc0
 4DIoKr0zOEulDS/jy/gFZFfsd/mEZlrVsp5gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748389843; x=1748994643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHiSt+sxRr2adxz+YOnvb9Ey3YSRSbgAdpa+D7SIcDY=;
 b=cH5aaPLjBkqh6IgxjDiYUCLf61IhDL1hT8+OXw12AGj0P/I1VaujmTsV9Rkyu0pXfC
 2oYyVbwOIZbmNiHQ+C/WJUFtRN4qCxwv0z9LgQz33bCCSLNusf3vl0IyvCJOp3niyaX3
 3QP/I+UhQWgzYKd3/UdELYRj/rL/IlVhhPNfRkvqb4r+zJZcts9m93qHJM9V2lBrNPhY
 stCr0sRY4Hj9zuLDGx0ZX+qri0Ff+2uclMKxsejygfUzM0pgoLWhaod8QCbU5Me2lCne
 rpfo1onZtLymuADH8GPw1O3OkYCpZpBF4p0lnOe5U7KC5ubK9Cqc2+SZIm3NWJ0hybFv
 bjhg==
X-Gm-Message-State: AOJu0YziNIVMyxMNNlcD3WQch0yhHYQmyIYO+P6xZXL0wb10MCESJYPM
 N8LeoXrHkK705Gebow3suscV6z6wqJySNdOWVQuAQzZTpsMwQ6/EpkML5nntc7i7U+Msqu5Phut
 m4If4p7Q=
X-Gm-Gg: ASbGncs8Or1LWLi28oYLmI0OzLsr0Yxvy4FJ4LnkuXjWS0uL0Y1EL54FjvltZ4ldHbC
 INxha9qmp46I7dj3PHL4bshRACsZhuKiJihKbZOTQH2FzxAbmhip2Apgmfbk0xDY7LrunAX++DW
 4E4wFWlro4VUKMHF9l8yeDrwgRbJitRrJkNaZZDi/bKBN/iVQrrc53ox+Y0YdB/pKutQ0Bxbk0p
 O07Fzr1xvSvDs1D5CxfOgACxDjHr9Z0KmnE1SyLWFdTYm9GnFd++rpguUvOkR12i3WZYuhfG9wX
 PKgHUOY+cBdKCXdVHCxEBRiDrCSZO9XPV5i7f5keRXZ35zFRo3XkmyH3aIbbO1jGIO+zrBB3THV
 NUGr+z7RBIuCZTVs=
X-Google-Smtp-Source: AGHT+IH4S795uyybGmlxTpyuv+Jac6hXnBXzW45qdSr7osUUtzaGqe2UMBXQHzBXFqlbMWc3yyk78g==
X-Received: by 2002:a05:6870:af91:b0:2b8:2f9c:d513 with SMTP id
 586e51a60fabf-2e861ea4892mr7327172fac.19.1748389843066; 
 Tue, 27 May 2025 16:50:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1727e33sm8090fac.20.2025.05.27.16.50.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:50:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] include/dt-bindings: Remove strict subset headers
Date: Tue, 27 May 2025 17:50:38 -0600
Message-ID: <20250527235040.2996531-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527235040.2996531-1-trini@konsulko.com>
References: <20250527235040.2996531-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

As part of moving to using OF_UPSTREAM and so the upstream dt-bindings
headers we have a number of these headers that are in our include
directory and differ in being a strict subset of what is found upstream.
We can safely remove the copies under include/dt-bindings now to prevent
future conflicts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/dt-bindings/clock/at91.h              |  23 --
 include/dt-bindings/clock/mt7622-clk.h        | 276 ------------------
 include/dt-bindings/clock/sun50i-a64-ccu.h    | 138 ---------
 .../interrupt-controller/apple-aic.h          |  15 -
 include/dt-bindings/memory/tegra114-mc.h      |  25 --
 include/dt-bindings/memory/tegra124-mc.h      |  31 --
 include/dt-bindings/memory/tegra210-mc.h      |  36 ---
 include/dt-bindings/memory/tegra30-mc.h       |  24 --
 include/dt-bindings/reset/altr,rst-mgr-s10.h  |  96 ------
 include/dt-bindings/reset/bcm63268-reset.h    |  31 --
 .../dt-bindings/thermal/tegra124-soctherm.h   |  14 -
 11 files changed, 709 deletions(-)
 delete mode 100644 include/dt-bindings/clock/at91.h
 delete mode 100644 include/dt-bindings/clock/mt7622-clk.h
 delete mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 delete mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h
 delete mode 100644 include/dt-bindings/memory/tegra114-mc.h
 delete mode 100644 include/dt-bindings/memory/tegra124-mc.h
 delete mode 100644 include/dt-bindings/memory/tegra210-mc.h
 delete mode 100644 include/dt-bindings/memory/tegra30-mc.h
 delete mode 100644 include/dt-bindings/reset/altr,rst-mgr-s10.h
 delete mode 100644 include/dt-bindings/reset/bcm63268-reset.h
 delete mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h

diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
deleted file mode 100644
index ab3ee241d10c..000000000000
--- a/include/dt-bindings/clock/at91.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * This header provides constants for AT91 pmc status.
- *
- * The constants defined in this header are being used in dts.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef _DT_BINDINGS_CLK_AT91_H
-#define _DT_BINDINGS_CLK_AT91_H
-
-#define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-#define AT91_PMC_LOCKA		1		/* PLLA Lock */
-#define AT91_PMC_LOCKB		2		/* PLLB Lock */
-#define AT91_PMC_MCKRDY		3		/* Master Clock */
-#define AT91_PMC_LOCKU		6		/* UPLL Lock */
-#define AT91_PMC_PCKRDY(id)	(8 + (id))	/* Programmable Clock */
-#define AT91_PMC_MOSCSELS	16		/* Main Oscillator Selection */
-#define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
-#define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
-#define AT91_PMC_GCKRDY		24		/* Generated Clocks */
-
-#endif
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
deleted file mode 100644
index cdbcaef76eb0..000000000000
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ /dev/null
@@ -1,276 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2019 MediaTek Inc.
- */
-#ifndef _DT_BINDINGS_CLK_MT7622_H
-#define _DT_BINDINGS_CLK_MT7622_H
-
-/* TOPCKGEN */
-
-/* FIXED_CLKS */
-#define CLK_TOP_TO_U2_PHY		0
-#define CLK_TOP_TO_U2_PHY_1P		1
-#define CLK_TOP_PCIE0_PIPE_EN		2
-#define CLK_TOP_PCIE1_PIPE_EN		3
-#define CLK_TOP_SSUSB_TX250M		4
-#define CLK_TOP_SSUSB_EQ_RX250M		5
-#define CLK_TOP_SSUSB_CDR_REF		6
-#define CLK_TOP_SSUSB_CDR_FB		7
-#define CLK_TOP_SATA_ASIC		8
-#define CLK_TOP_SATA_RBC		9
-/* FIXED_DIVS */
-#define CLK_TOP_TO_USB3_SYS		10
-#define CLK_TOP_P1_1MHZ			11
-#define CLK_TOP_4MHZ			12
-#define CLK_TOP_P0_1MHZ			13
-#define CLK_TOP_TXCLK_SRC_PRE		14
-#define CLK_TOP_RTC			15
-#define CLK_TOP_MEMPLL			16
-#define CLK_TOP_DMPLL			17
-#define CLK_TOP_SYSPLL_D2		18
-#define CLK_TOP_SYSPLL1_D2		19
-#define CLK_TOP_SYSPLL1_D4		20
-#define CLK_TOP_SYSPLL1_D8		21
-#define CLK_TOP_SYSPLL2_D4		22
-#define CLK_TOP_SYSPLL2_D8		23
-#define CLK_TOP_SYSPLL_D5		24
-#define CLK_TOP_SYSPLL3_D2		25
-#define CLK_TOP_SYSPLL3_D4		26
-#define CLK_TOP_SYSPLL4_D2		27
-#define CLK_TOP_SYSPLL4_D4		28
-#define CLK_TOP_SYSPLL4_D16		29
-#define CLK_TOP_UNIVPLL			30
-#define CLK_TOP_UNIVPLL_D2		31
-#define CLK_TOP_UNIVPLL1_D2		32
-#define CLK_TOP_UNIVPLL1_D4		33
-#define CLK_TOP_UNIVPLL1_D8		34
-#define CLK_TOP_UNIVPLL1_D16		35
-#define CLK_TOP_UNIVPLL2_D2		36
-#define CLK_TOP_UNIVPLL2_D4		37
-#define CLK_TOP_UNIVPLL2_D8		38
-#define CLK_TOP_UNIVPLL2_D16		39
-#define CLK_TOP_UNIVPLL_D5		40
-#define CLK_TOP_UNIVPLL3_D2		41
-#define CLK_TOP_UNIVPLL3_D4		42
-#define CLK_TOP_UNIVPLL3_D16		43
-#define CLK_TOP_UNIVPLL_D7		44
-#define CLK_TOP_UNIVPLL_D80_D4		45
-#define CLK_TOP_UNIV48M			46
-#define CLK_TOP_SGMIIPLL		47
-#define CLK_TOP_SGMIIPLL_D2		48
-#define CLK_TOP_AUD1PLL			49
-#define CLK_TOP_AUD2PLL			50
-#define CLK_TOP_AUD_I2S2_MCK		51
-#define CLK_TOP_TO_USB3_REF		52
-#define CLK_TOP_PCIE1_MAC_EN		53
-#define CLK_TOP_PCIE0_MAC_EN		54
-#define CLK_TOP_ETH_500M		55
-/* TOP_MUXES */
-#define CLK_TOP_AXI_SEL			56
-#define CLK_TOP_MEM_SEL			57
-#define CLK_TOP_DDRPHYCFG_SEL		58
-#define CLK_TOP_ETH_SEL			59
-#define CLK_TOP_PWM_SEL			60
-#define CLK_TOP_F10M_REF_SEL		61
-#define CLK_TOP_NFI_INFRA_SEL		62
-#define CLK_TOP_FLASH_SEL		63
-#define CLK_TOP_UART_SEL		64
-#define CLK_TOP_SPI0_SEL		65
-#define CLK_TOP_SPI1_SEL		66
-#define CLK_TOP_MSDC50_0_SEL		67
-#define CLK_TOP_MSDC30_0_SEL		68
-#define CLK_TOP_MSDC30_1_SEL		69
-#define CLK_TOP_A1SYS_HP_SEL		70
-#define CLK_TOP_A2SYS_HP_SEL		71
-#define CLK_TOP_INTDIR_SEL		72
-#define CLK_TOP_AUD_INTBUS_SEL		73
-#define CLK_TOP_PMICSPI_SEL		74
-#define CLK_TOP_SCP_SEL			75
-#define CLK_TOP_ATB_SEL			76
-#define CLK_TOP_HIF_SEL			77
-#define CLK_TOP_AUDIO_SEL		78
-#define CLK_TOP_U2_SEL			79
-#define CLK_TOP_AUD1_SEL		80
-#define CLK_TOP_AUD2_SEL		81
-#define CLK_TOP_IRRX_SEL		82
-#define CLK_TOP_IRTX_SEL		83
-#define CLK_TOP_ASM_L_SEL		84
-#define CLK_TOP_ASM_M_SEL		85
-#define CLK_TOP_ASM_H_SEL		86
-#define CLK_TOP_APLL1_SEL		87
-#define CLK_TOP_APLL2_SEL		88
-#define CLK_TOP_I2S0_MCK_SEL		89
-#define CLK_TOP_I2S1_MCK_SEL		90
-#define CLK_TOP_I2S2_MCK_SEL		91
-#define CLK_TOP_I2S3_MCK_SEL		92
-#define CLK_TOP_APLL1_DIV		93
-#define CLK_TOP_APLL2_DIV		94
-#define CLK_TOP_I2S0_MCK_DIV		95
-#define CLK_TOP_I2S1_MCK_DIV		96
-#define CLK_TOP_I2S2_MCK_DIV		97
-#define CLK_TOP_I2S3_MCK_DIV		98
-#define CLK_TOP_A1SYS_HP_DIV		99
-#define CLK_TOP_A2SYS_HP_DIV		100
-#define CLK_TOP_APLL1_DIV_PD		101
-#define CLK_TOP_APLL2_DIV_PD		102
-#define CLK_TOP_I2S0_MCK_DIV_PD		103
-#define CLK_TOP_I2S1_MCK_DIV_PD		104
-#define CLK_TOP_I2S2_MCK_DIV_PD		105
-#define CLK_TOP_I2S3_MCK_DIV_PD		106
-#define CLK_TOP_A1SYS_HP_DIV_PD		107
-#define CLK_TOP_A2SYS_HP_DIV_PD		108
-
-/* INFRACFG */
-
-#define CLK_INFRA_MUX1_SEL		0
-#define CLK_INFRA_DBGCLK_PD		1
-#define CLK_INFRA_AUDIO_PD		2
-#define CLK_INFRA_IRRX_PD		3
-#define CLK_INFRA_APXGPT_PD		4
-#define CLK_INFRA_PMIC_PD		5
-#define CLK_INFRA_TRNG			6
-
-/* PERICFG */
-
-#define CLK_PERIBUS_SEL			0
-#define CLK_PERI_THERM_PD		1
-#define CLK_PERI_PWM1_PD		2
-#define CLK_PERI_PWM2_PD		3
-#define CLK_PERI_PWM3_PD		4
-#define CLK_PERI_PWM4_PD		5
-#define CLK_PERI_PWM5_PD		6
-#define CLK_PERI_PWM6_PD		7
-#define CLK_PERI_PWM7_PD		8
-#define CLK_PERI_PWM_PD			9
-#define CLK_PERI_AP_DMA_PD		10
-#define CLK_PERI_MSDC30_0_PD		11
-#define CLK_PERI_MSDC30_1_PD		12
-#define CLK_PERI_UART0_PD		13
-#define CLK_PERI_UART1_PD		14
-#define CLK_PERI_UART2_PD		15
-#define CLK_PERI_UART3_PD		16
-#define CLK_PERI_UART4_PD		17
-#define CLK_PERI_BTIF_PD		18
-#define CLK_PERI_I2C0_PD		19
-#define CLK_PERI_I2C1_PD		20
-#define CLK_PERI_I2C2_PD		21
-#define CLK_PERI_SPI1_PD		22
-#define CLK_PERI_AUXADC_PD		23
-#define CLK_PERI_SPI0_PD		24
-#define CLK_PERI_SNFI_PD		25
-#define CLK_PERI_NFI_PD			26
-#define CLK_PERI_NFIECC_PD		27
-#define CLK_PERI_FLASH_PD		28
-#define CLK_PERI_IRTX_PD		29
-
-/* APMIXEDSYS */
-
-#define CLK_APMIXED_ARMPLL		0
-#define CLK_APMIXED_MAINPLL		1
-#define CLK_APMIXED_UNIV2PLL		2
-#define CLK_APMIXED_ETH1PLL		3
-#define CLK_APMIXED_ETH2PLL		4
-#define CLK_APMIXED_AUD1PLL		5
-#define CLK_APMIXED_AUD2PLL		6
-#define CLK_APMIXED_TRGPLL		7
-#define CLK_APMIXED_SGMIPLL		8
-#define CLK_APMIXED_MAIN_CORE_EN	9
-
-/* AUDIOSYS */
-
-#define CLK_AUDIO_AFE			0
-#define CLK_AUDIO_HDMI			1
-#define CLK_AUDIO_SPDF			2
-#define CLK_AUDIO_APLL			3
-#define CLK_AUDIO_I2SIN1		4
-#define CLK_AUDIO_I2SIN2		5
-#define CLK_AUDIO_I2SIN3		6
-#define CLK_AUDIO_I2SIN4		7
-#define CLK_AUDIO_I2SO1			8
-#define CLK_AUDIO_I2SO2			9
-#define CLK_AUDIO_I2SO3			10
-#define CLK_AUDIO_I2SO4			11
-#define CLK_AUDIO_ASRCI1		12
-#define CLK_AUDIO_ASRCI2		13
-#define CLK_AUDIO_ASRCO1		14
-#define CLK_AUDIO_ASRCO2		15
-#define CLK_AUDIO_INTDIR		16
-#define CLK_AUDIO_A1SYS			17
-#define CLK_AUDIO_A2SYS			18
-#define CLK_AUDIO_UL1			19
-#define CLK_AUDIO_UL2			20
-#define CLK_AUDIO_UL3			21
-#define CLK_AUDIO_UL4			22
-#define CLK_AUDIO_UL5			23
-#define CLK_AUDIO_UL6			24
-#define CLK_AUDIO_DL1			25
-#define CLK_AUDIO_DL2			26
-#define CLK_AUDIO_DL3			27
-#define CLK_AUDIO_DL4			28
-#define CLK_AUDIO_DL5			29
-#define CLK_AUDIO_DL6			30
-#define CLK_AUDIO_DLMCH			31
-#define CLK_AUDIO_ARB1			32
-#define CLK_AUDIO_AWB			33
-#define CLK_AUDIO_AWB2			34
-#define CLK_AUDIO_DAI			35
-#define CLK_AUDIO_MOD			36
-#define CLK_AUDIO_ASRCI3		37
-#define CLK_AUDIO_ASRCI4		38
-#define CLK_AUDIO_ASRCO3		39
-#define CLK_AUDIO_ASRCO4		40
-#define CLK_AUDIO_MEM_ASRC1		41
-#define CLK_AUDIO_MEM_ASRC2		42
-#define CLK_AUDIO_MEM_ASRC3		43
-#define CLK_AUDIO_MEM_ASRC4		44
-#define CLK_AUDIO_MEM_ASRC5		45
-#define CLK_AUDIO_AFE_CONN		46
-#define CLK_AUDIO_NR_CLK		47
-
-/* SSUSBSYS */
-
-#define CLK_SSUSB_U2_PHY_1P_EN		0
-#define CLK_SSUSB_U2_PHY_EN		1
-#define CLK_SSUSB_REF_EN		2
-#define CLK_SSUSB_SYS_EN		3
-#define CLK_SSUSB_MCU_EN		4
-#define CLK_SSUSB_DMA_EN		5
-#define CLK_SSUSB_NR_CLK		6
-
-/* PCIESYS */
-
-#define CLK_PCIE_P1_AUX_EN		0
-#define CLK_PCIE_P1_OBFF_EN		1
-#define CLK_PCIE_P1_AHB_EN		2
-#define CLK_PCIE_P1_AXI_EN		3
-#define CLK_PCIE_P1_MAC_EN		4
-#define CLK_PCIE_P1_PIPE_EN		5
-#define CLK_PCIE_P0_AUX_EN		6
-#define CLK_PCIE_P0_OBFF_EN		7
-#define CLK_PCIE_P0_AHB_EN		8
-#define CLK_PCIE_P0_AXI_EN		9
-#define CLK_PCIE_P0_MAC_EN		10
-#define CLK_PCIE_P0_PIPE_EN		11
-#define CLK_SATA_AHB_EN			12
-#define CLK_SATA_AXI_EN			13
-#define CLK_SATA_ASIC_EN		14
-#define CLK_SATA_RBC_EN			15
-#define CLK_SATA_PM_EN			16
-#define CLK_PCIE_NR_CLK			17
-
-/* ETHSYS */
-
-#define CLK_ETH_HSDMA_EN		0
-#define CLK_ETH_ESW_EN			1
-#define CLK_ETH_GP2_EN			2
-#define CLK_ETH_GP1_EN			3
-#define CLK_ETH_GP0_EN			4
-
-/* SGMIISYS */
-
-#define CLK_SGMII_TX250M_EN		0
-#define CLK_SGMII_RX250M_EN		1
-#define CLK_SGMII_CDR_REF		2
-#define CLK_SGMII_CDR_FB		3
-
-#endif /* _DT_BINDINGS_CLK_MT7622_H */
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
deleted file mode 100644
index 175892189e9d..000000000000
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
-#define _DT_BINDINGS_CLK_SUN50I_A64_H_
-
-#define CLK_PLL_VIDEO0		7
-#define CLK_PLL_PERIPH0		11
-
-#define CLK_CPUX		21
-#define CLK_BUS_MIPI_DSI	28
-#define CLK_BUS_CE		29
-#define CLK_BUS_DMA		30
-#define CLK_BUS_MMC0		31
-#define CLK_BUS_MMC1		32
-#define CLK_BUS_MMC2		33
-#define CLK_BUS_NAND		34
-#define CLK_BUS_DRAM		35
-#define CLK_BUS_EMAC		36
-#define CLK_BUS_TS		37
-#define CLK_BUS_HSTIMER		38
-#define CLK_BUS_SPI0		39
-#define CLK_BUS_SPI1		40
-#define CLK_BUS_OTG		41
-#define CLK_BUS_EHCI0		42
-#define CLK_BUS_EHCI1		43
-#define CLK_BUS_OHCI0		44
-#define CLK_BUS_OHCI1		45
-#define CLK_BUS_VE		46
-#define CLK_BUS_TCON0		47
-#define CLK_BUS_TCON1		48
-#define CLK_BUS_DEINTERLACE	49
-#define CLK_BUS_CSI		50
-#define CLK_BUS_HDMI		51
-#define CLK_BUS_DE		52
-#define CLK_BUS_GPU		53
-#define CLK_BUS_MSGBOX		54
-#define CLK_BUS_SPINLOCK	55
-#define CLK_BUS_CODEC		56
-#define CLK_BUS_SPDIF		57
-#define CLK_BUS_PIO		58
-#define CLK_BUS_THS		59
-#define CLK_BUS_I2S0		60
-#define CLK_BUS_I2S1		61
-#define CLK_BUS_I2S2		62
-#define CLK_BUS_I2C0		63
-#define CLK_BUS_I2C1		64
-#define CLK_BUS_I2C2		65
-#define CLK_BUS_SCR		66
-#define CLK_BUS_UART0		67
-#define CLK_BUS_UART1		68
-#define CLK_BUS_UART2		69
-#define CLK_BUS_UART3		70
-#define CLK_BUS_UART4		71
-#define CLK_BUS_DBG		72
-#define CLK_THS			73
-#define CLK_NAND		74
-#define CLK_MMC0		75
-#define CLK_MMC1		76
-#define CLK_MMC2		77
-#define CLK_TS			78
-#define CLK_CE			79
-#define CLK_SPI0		80
-#define CLK_SPI1		81
-#define CLK_I2S0		82
-#define CLK_I2S1		83
-#define CLK_I2S2		84
-#define CLK_SPDIF		85
-#define CLK_USB_PHY0		86
-#define CLK_USB_PHY1		87
-#define CLK_USB_HSIC		88
-#define CLK_USB_HSIC_12M	89
-
-#define CLK_USB_OHCI0		91
-
-#define CLK_USB_OHCI1		93
-#define CLK_DRAM		94
-#define CLK_DRAM_VE		95
-#define CLK_DRAM_CSI		96
-#define CLK_DRAM_DEINTERLACE	97
-#define CLK_DRAM_TS		98
-#define CLK_DE			99
-#define CLK_TCON0		100
-#define CLK_TCON1		101
-#define CLK_DEINTERLACE		102
-#define CLK_CSI_MISC		103
-#define CLK_CSI_SCLK		104
-#define CLK_CSI_MCLK		105
-#define CLK_VE			106
-#define CLK_AC_DIG		107
-#define CLK_AC_DIG_4X		108
-#define CLK_AVS			109
-#define CLK_HDMI		110
-#define CLK_HDMI_DDC		111
-#define CLK_MBUS		112
-#define CLK_DSI_DPHY		113
-#define CLK_GPU			114
-
-#endif /* _DT_BINDINGS_CLK_SUN50I_H_ */
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
deleted file mode 100644
index 9ac56a7e6d3f..000000000000
--- a/include/dt-bindings/interrupt-controller/apple-aic.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-#define AIC_IRQ	0
-#define AIC_FIQ	1
-
-#define AIC_TMR_HV_PHYS		0
-#define AIC_TMR_HV_VIRT		1
-#define AIC_TMR_GUEST_PHYS	2
-#define AIC_TMR_GUEST_VIRT	3
-
-#endif
diff --git a/include/dt-bindings/memory/tegra114-mc.h b/include/dt-bindings/memory/tegra114-mc.h
deleted file mode 100644
index 8f48985a3139..000000000000
--- a/include/dt-bindings/memory/tegra114-mc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef DT_BINDINGS_MEMORY_TEGRA114_MC_H
-#define DT_BINDINGS_MEMORY_TEGRA114_MC_H
-
-#define TEGRA_SWGROUP_PTC	0
-#define TEGRA_SWGROUP_DC	1
-#define TEGRA_SWGROUP_DCB	2
-#define TEGRA_SWGROUP_EPP	3
-#define TEGRA_SWGROUP_G2	4
-#define TEGRA_SWGROUP_AVPC	5
-#define TEGRA_SWGROUP_NV	6
-#define TEGRA_SWGROUP_HDA	7
-#define TEGRA_SWGROUP_HC	8
-#define TEGRA_SWGROUP_MSENC	9
-#define TEGRA_SWGROUP_PPCS	10
-#define TEGRA_SWGROUP_VDE	11
-#define TEGRA_SWGROUP_MPCORELP	12
-#define TEGRA_SWGROUP_MPCORE	13
-#define TEGRA_SWGROUP_VI	14
-#define TEGRA_SWGROUP_ISP	15
-#define TEGRA_SWGROUP_XUSB_HOST	16
-#define TEGRA_SWGROUP_XUSB_DEV	17
-#define TEGRA_SWGROUP_EMUCIF	18
-#define TEGRA_SWGROUP_TSEC	19
-
-#endif
diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h
deleted file mode 100644
index 7d8ee798f34e..000000000000
--- a/include/dt-bindings/memory/tegra124-mc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef DT_BINDINGS_MEMORY_TEGRA124_MC_H
-#define DT_BINDINGS_MEMORY_TEGRA124_MC_H
-
-#define TEGRA_SWGROUP_PTC	0
-#define TEGRA_SWGROUP_DC	1
-#define TEGRA_SWGROUP_DCB	2
-#define TEGRA_SWGROUP_AFI	3
-#define TEGRA_SWGROUP_AVPC	4
-#define TEGRA_SWGROUP_HDA	5
-#define TEGRA_SWGROUP_HC	6
-#define TEGRA_SWGROUP_MSENC	7
-#define TEGRA_SWGROUP_PPCS	8
-#define TEGRA_SWGROUP_SATA	9
-#define TEGRA_SWGROUP_VDE	10
-#define TEGRA_SWGROUP_MPCORELP	11
-#define TEGRA_SWGROUP_MPCORE	12
-#define TEGRA_SWGROUP_ISP2	13
-#define TEGRA_SWGROUP_XUSB_HOST	14
-#define TEGRA_SWGROUP_XUSB_DEV	15
-#define TEGRA_SWGROUP_ISP2B	16
-#define TEGRA_SWGROUP_TSEC	17
-#define TEGRA_SWGROUP_A9AVP	18
-#define TEGRA_SWGROUP_GPU	19
-#define TEGRA_SWGROUP_SDMMC1A	20
-#define TEGRA_SWGROUP_SDMMC2A	21
-#define TEGRA_SWGROUP_SDMMC3A	22
-#define TEGRA_SWGROUP_SDMMC4A	23
-#define TEGRA_SWGROUP_VIC	24
-#define TEGRA_SWGROUP_VI	25
-
-#endif
diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bindings/memory/tegra210-mc.h
deleted file mode 100644
index d1731bc14dbc..000000000000
--- a/include/dt-bindings/memory/tegra210-mc.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef DT_BINDINGS_MEMORY_TEGRA210_MC_H
-#define DT_BINDINGS_MEMORY_TEGRA210_MC_H
-
-#define TEGRA_SWGROUP_PTC	0
-#define TEGRA_SWGROUP_DC	1
-#define TEGRA_SWGROUP_DCB	2
-#define TEGRA_SWGROUP_AFI	3
-#define TEGRA_SWGROUP_AVPC	4
-#define TEGRA_SWGROUP_HDA	5
-#define TEGRA_SWGROUP_HC	6
-#define TEGRA_SWGROUP_NVENC	7
-#define TEGRA_SWGROUP_PPCS	8
-#define TEGRA_SWGROUP_SATA	9
-#define TEGRA_SWGROUP_MPCORE	10
-#define TEGRA_SWGROUP_ISP2	11
-#define TEGRA_SWGROUP_XUSB_HOST	12
-#define TEGRA_SWGROUP_XUSB_DEV	13
-#define TEGRA_SWGROUP_ISP2B	14
-#define TEGRA_SWGROUP_TSEC	15
-#define TEGRA_SWGROUP_A9AVP	16
-#define TEGRA_SWGROUP_GPU	17
-#define TEGRA_SWGROUP_SDMMC1A	18
-#define TEGRA_SWGROUP_SDMMC2A	19
-#define TEGRA_SWGROUP_SDMMC3A	20
-#define TEGRA_SWGROUP_SDMMC4A	21
-#define TEGRA_SWGROUP_VIC	22
-#define TEGRA_SWGROUP_VI	23
-#define TEGRA_SWGROUP_NVDEC	24
-#define TEGRA_SWGROUP_APE	25
-#define TEGRA_SWGROUP_NVJPG	26
-#define TEGRA_SWGROUP_SE	27
-#define TEGRA_SWGROUP_AXIAP	28
-#define TEGRA_SWGROUP_ETR	29
-#define TEGRA_SWGROUP_TSECB	30
-
-#endif
diff --git a/include/dt-bindings/memory/tegra30-mc.h b/include/dt-bindings/memory/tegra30-mc.h
deleted file mode 100644
index 502beb03d777..000000000000
--- a/include/dt-bindings/memory/tegra30-mc.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef DT_BINDINGS_MEMORY_TEGRA30_MC_H
-#define DT_BINDINGS_MEMORY_TEGRA30_MC_H
-
-#define TEGRA_SWGROUP_PTC	0
-#define TEGRA_SWGROUP_DC	1
-#define TEGRA_SWGROUP_DCB	2
-#define TEGRA_SWGROUP_EPP	3
-#define TEGRA_SWGROUP_G2	4
-#define TEGRA_SWGROUP_MPE	5
-#define TEGRA_SWGROUP_VI	6
-#define TEGRA_SWGROUP_AFI	7
-#define TEGRA_SWGROUP_AVPC	8
-#define TEGRA_SWGROUP_NV	9
-#define TEGRA_SWGROUP_NV2	10
-#define TEGRA_SWGROUP_HDA	11
-#define TEGRA_SWGROUP_HC	12
-#define TEGRA_SWGROUP_PPCS	13
-#define TEGRA_SWGROUP_SATA	14
-#define TEGRA_SWGROUP_VDE	15
-#define TEGRA_SWGROUP_MPCORELP	16
-#define TEGRA_SWGROUP_MPCORE	17
-#define TEGRA_SWGROUP_ISP	18
-
-#endif
diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bindings/reset/altr,rst-mgr-s10.h
deleted file mode 100644
index 1fdcf8ae1531..000000000000
--- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2016-2018 Intel Corporation. All rights reserved
- * Copyright (C) 2016 Altera Corporation. All rights reserved
- * derived from Steffen Trumtrar's "altr,rst-mgr-a10.h"
- */
-
-#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_S10_H
-#define _DT_BINDINGS_RESET_ALTR_RST_MGR_S10_H
-
-/* MPUMODRST */
-#define CPU0_RESET		0
-#define CPU1_RESET		1
-#define CPU2_RESET		2
-#define CPU3_RESET		3
-
-/* PER0MODRST */
-#define EMAC0_RESET		32
-#define EMAC1_RESET		33
-#define EMAC2_RESET		34
-#define USB0_RESET		35
-#define USB1_RESET		36
-#define NAND_RESET		37
-/* 38 is empty */
-#define SDMMC_RESET		39
-#define EMAC0_OCP_RESET		40
-#define EMAC1_OCP_RESET		41
-#define EMAC2_OCP_RESET		42
-#define USB0_OCP_RESET		43
-#define USB1_OCP_RESET		44
-#define NAND_OCP_RESET		45
-/* 46 is empty */
-#define SDMMC_OCP_RESET		47
-#define DMA_RESET		48
-#define SPIM0_RESET		49
-#define SPIM1_RESET		50
-#define SPIS0_RESET		51
-#define SPIS1_RESET		52
-#define DMA_OCP_RESET		53
-#define EMAC_PTP_RESET		54
-/* 55 is empty*/
-#define DMAIF0_RESET		56
-#define DMAIF1_RESET		57
-#define DMAIF2_RESET		58
-#define DMAIF3_RESET		59
-#define DMAIF4_RESET		60
-#define DMAIF5_RESET		61
-#define DMAIF6_RESET		62
-#define DMAIF7_RESET		63
-
-/* PER1MODRST */
-#define WATCHDOG0_RESET		64
-#define WATCHDOG1_RESET		65
-#define WATCHDOG2_RESET		66
-#define WATCHDOG3_RESET		67
-#define L4SYSTIMER0_RESET	68
-#define L4SYSTIMER1_RESET	69
-#define SPTIMER0_RESET		70
-#define SPTIMER1_RESET		71
-#define I2C0_RESET		72
-#define I2C1_RESET		73
-#define I2C2_RESET		74
-#define I2C3_RESET		75
-#define I2C4_RESET		76
-/* 77-79 is empty */
-#define UART0_RESET		80
-#define UART1_RESET		81
-/* 82-87 is empty */
-#define GPIO0_RESET		88
-#define GPIO1_RESET		89
-
-/* BRGMODRST */
-#define SOC2FPGA_RESET		96
-#define LWHPS2FPGA_RESET	97
-#define FPGA2SOC_RESET		98
-#define F2SSDRAM0_RESET		99
-#define F2SSDRAM1_RESET		100
-#define F2SSDRAM2_RESET		101
-#define DDRSCH_RESET		102
-
-/* COLDMODRST */
-#define CPUPO0_RESET		160
-#define CPUPO1_RESET		161
-#define CPUPO2_RESET		162
-#define CPUPO3_RESET		163
-/* 164-167 is empty */
-#define L2_RESET		168
-
-/* DBGMODRST */
-#define DBG_RESET		224
-#define CSDAP_RESET		225
-
-/* TAPMODRST */
-#define TAP_RESET		256
-
-#endif
diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
deleted file mode 100644
index a45abed1ceb7..000000000000
--- a/include/dt-bindings/reset/bcm63268-reset.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM63268_H
-#define __DT_BINDINGS_RESET_BCM63268_H
-
-#define BCM63268_RST_SPI	0
-#define BCM63268_RST_IPSEC	1
-#define BCM63268_RST_EPHY	2
-#define BCM63268_RST_SAR	3
-#define BCM63268_RST_ENETSW	4
-#define BCM63268_RST_USBS	5
-#define BCM63268_RST_USBH	6
-#define BCM63268_RST_PCM	7
-#define BCM63268_RST_PCIE_CORE	8
-#define BCM63268_RST_PCIE	9
-#define BCM63268_RST_PCIE_EXT	10
-#define BCM63268_RST_WLAN_SHIM	11
-#define BCM63268_RST_DDR_PHY	12
-#define BCM63268_RST_FAP0	13
-#define BCM63268_RST_WLAN_UBUS	14
-#define BCM63268_RST_DECT	15
-#define BCM63268_RST_FAP1	16
-#define BCM63268_RST_PCIE_HARD	17
-#define BCM63268_RST_GPHY	18
-
-#endif /* __DT_BINDINGS_RESET_BCM63268_H */
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
deleted file mode 100644
index 729ab9fc325e..000000000000
--- a/include/dt-bindings/thermal/tegra124-soctherm.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * This header provides constants for binding nvidia,tegra124-soctherm.
- */
-
-#ifndef _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
-#define _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
-
-#define TEGRA124_SOCTHERM_SENSOR_CPU 0
-#define TEGRA124_SOCTHERM_SENSOR_MEM 1
-#define TEGRA124_SOCTHERM_SENSOR_GPU 2
-#define TEGRA124_SOCTHERM_SENSOR_PLLX 3
-#define TEGRA124_SOCTHERM_SENSOR_NUM 4
-
-#endif
-- 
2.43.0

