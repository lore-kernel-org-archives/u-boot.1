Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DB3C5AD49
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 23:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7DC83197;
	Wed, 28 May 2025 01:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PL9tCXTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869A4831D5; Wed, 28 May 2025 01:50:52 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03EBB8318E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2e404edf6b3so2630488fac.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748389842; x=1748994642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cxgvh7jr1PTxqrMM15e1Cj/SF36/W4R7Y53f0+aKUhI=;
 b=PL9tCXTXDzW5B/bO5wkBnbbqsrfFA0xHLmjOIhRuJxQjwWwL2wtJp2tkgE4S9bgAOL
 iQCByruVHvnNZkMZSiZnEHKIXKMcWdyIlhzR4MfeM9xy1aL9cqUkmL/AsoGeIzofxaMq
 6DgA8kx4XS0uEjEeKEAKjzhJfYS61YoeUfLY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748389842; x=1748994642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxgvh7jr1PTxqrMM15e1Cj/SF36/W4R7Y53f0+aKUhI=;
 b=DxEno5G/Cmu47psIKQME8SyrwyNoqLzfKwcA8J0ZyeeMkBF1xVJw2zUwO9F8M6wg4M
 M2qvaB7GRzWtxu0sAcl4ZUfyeb9F9fqfU6IhZy+MHUNcXm7EBxqn5JsMGQdqu68uTawD
 Qg/LJf1TXoHH9FUgLKiqGdoz1e9lyYXqYCGxcQfUXxnn4SNzLRKRu2RSalh/5nDUP49E
 6UGhaif/bf9fPNRhHuIypQvTdTnTMqjD1jGEo+a2v46X7Q6jmt/wzJCc1ytKbY31uOoq
 L+cMGC9UyeAmscE0izU0Sv6n9w6t5kHLd68PMlmxsKeCf6fo5CnjmZ72y032vg7xKMja
 ky/g==
X-Gm-Message-State: AOJu0YyY/FQX8+07MqR0JxbTajIc8sQMVUFCpYk1htDC3iHHous6TpE5
 LsXNJzOp4V3eeFDEN9SX/9KYsgyTwzFLTf+KoCUHO6ZuGCBASOVHRpDPXRQhI0aP9Vw8TfyTGYj
 o5f0MBiM=
X-Gm-Gg: ASbGncuRg9c0PX6kwfcJ7lxrnM1cgjeKXLG9Ca1St26Mkm5+BYcZmC51Xq0mSQDpsIW
 3bPEBghuYcJfyhEW4vW18xUUjkgH05PvNBRKAdel6h4ivS9sc237aiOFW7J1SWVE8nr0HIvT5xV
 rGs7uYM8YYMfZRmF31aH1RF5X4su6cNdDAeMQYhd8CL4hN5yFPnoQk2ah3phL+Qj3tkJMKUbWsq
 TgJ2Yx3RK794bJNw30kEOfeeyvQruqj+2vlgBJafXcAfhJrw1KXN45mUhI+7srdtVUXrGejByGD
 AISYI+mUJbQVx46aIjqQGXTqw+Qo9fxZkAJAnnVcuFbzqpZKjW+P4Axhge9EhgJZQav9wVXop2s
 I48qt/G2GyBqyZwk=
X-Google-Smtp-Source: AGHT+IFJEMDQ/GL8MMF5OTM87UfcN8qg5/Wg69p//uOBoaEXpTrNbkW8aHz6aAhD34bh/XrWDZRjcg==
X-Received: by 2002:a05:6870:7013:b0:2c2:174b:c829 with SMTP id
 586e51a60fabf-2e861e74a8emr7871445fac.15.1748389842128; 
 Tue, 27 May 2025 16:50:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1727e33sm8090fac.20.2025.05.27.16.50.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:50:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] include/dt-bindings: Remove functionally identical headers
Date: Tue, 27 May 2025 17:50:37 -0600
Message-ID: <20250527235040.2996531-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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
directory and differ only in combinations of spacing changes and/or
switching to SPDX license tags. We can safely remove the copies under
include/dt-bindings now to prevent future conflicts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/dt-bindings/bus/ti-sysc.h             |  28 -
 include/dt-bindings/clock/bcm6328-clock.h     |  24 -
 include/dt-bindings/clock/maxim,max77802.h    |  22 -
 include/dt-bindings/clock/tegra124-car.h      |  19 -
 include/dt-bindings/clock/tegra186-clock.h    | 940 ------------------
 include/dt-bindings/dma/at91.h                |  51 -
 include/dt-bindings/gpio/aspeed-gpio.h        |  51 -
 include/dt-bindings/gpio/tegra-gpio.h         |  51 -
 include/dt-bindings/media/omap3-isp.h         |  22 -
 include/dt-bindings/mfd/st,stpmic1.h          |  50 -
 include/dt-bindings/net/ti-dp83867.h          |  53 -
 include/dt-bindings/pinctrl/dra.h             |  79 --
 include/dt-bindings/pinctrl/hisi.h            |  74 --
 include/dt-bindings/pinctrl/mt65xx.h          |  41 -
 include/dt-bindings/pinctrl/omap.h            |  91 --
 .../dt-bindings/pinctrl/pinctrl-tegra-xusb.h  |   7 -
 include/dt-bindings/pinctrl/pinctrl-tegra.h   |  37 -
 .../dt-bindings/pinctrl/r7s72100-pinctrl.h    |  18 -
 include/dt-bindings/power/raspberrypi-power.h |  41 -
 .../dt-bindings/power/tegra186-powergate.h    |  28 -
 .../dt-bindings/regulator/maxim,max77802.h    |  18 -
 include/dt-bindings/reset/altr,rst-mgr-a10.h  | 110 --
 include/dt-bindings/reset/altr,rst-mgr.h      |  82 --
 include/dt-bindings/reset/bcm6328-reset.h     |  23 -
 include/dt-bindings/reset/bcm6358-reset.h     |  20 -
 include/dt-bindings/reset/bcm6362-reset.h     |  27 -
 include/dt-bindings/reset/bcm6368-reset.h     |  21 -
 .../dt-bindings/reset/nuvoton,npcm7xx-reset.h |  91 --
 include/dt-bindings/reset/tegra124-car.h      |  12 -
 include/dt-bindings/reset/tegra186-reset.h    | 205 ----
 include/dt-bindings/reset/ti-syscon.h         |  38 -
 31 files changed, 2374 deletions(-)
 delete mode 100644 include/dt-bindings/bus/ti-sysc.h
 delete mode 100644 include/dt-bindings/clock/bcm6328-clock.h
 delete mode 100644 include/dt-bindings/clock/maxim,max77802.h
 delete mode 100644 include/dt-bindings/clock/tegra124-car.h
 delete mode 100644 include/dt-bindings/clock/tegra186-clock.h
 delete mode 100644 include/dt-bindings/dma/at91.h
 delete mode 100644 include/dt-bindings/gpio/aspeed-gpio.h
 delete mode 100644 include/dt-bindings/gpio/tegra-gpio.h
 delete mode 100644 include/dt-bindings/media/omap3-isp.h
 delete mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 delete mode 100644 include/dt-bindings/net/ti-dp83867.h
 delete mode 100644 include/dt-bindings/pinctrl/dra.h
 delete mode 100644 include/dt-bindings/pinctrl/hisi.h
 delete mode 100644 include/dt-bindings/pinctrl/mt65xx.h
 delete mode 100644 include/dt-bindings/pinctrl/omap.h
 delete mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h
 delete mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra.h
 delete mode 100644 include/dt-bindings/pinctrl/r7s72100-pinctrl.h
 delete mode 100644 include/dt-bindings/power/raspberrypi-power.h
 delete mode 100644 include/dt-bindings/power/tegra186-powergate.h
 delete mode 100644 include/dt-bindings/regulator/maxim,max77802.h
 delete mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10.h
 delete mode 100644 include/dt-bindings/reset/altr,rst-mgr.h
 delete mode 100644 include/dt-bindings/reset/bcm6328-reset.h
 delete mode 100644 include/dt-bindings/reset/bcm6358-reset.h
 delete mode 100644 include/dt-bindings/reset/bcm6362-reset.h
 delete mode 100644 include/dt-bindings/reset/bcm6368-reset.h
 delete mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
 delete mode 100644 include/dt-bindings/reset/tegra124-car.h
 delete mode 100644 include/dt-bindings/reset/tegra186-reset.h
 delete mode 100644 include/dt-bindings/reset/ti-syscon.h

diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
deleted file mode 100644
index eae427454374..000000000000
--- a/include/dt-bindings/bus/ti-sysc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* TI sysc interconnect target module defines */
-
-/* Generic sysc found on omap2 and later, also known as type1 */
-#define SYSC_OMAP2_CLOCKACTIVITY	(3 << 8)
-#define SYSC_OMAP2_EMUFREE		(1 << 5)
-#define SYSC_OMAP2_ENAWAKEUP		(1 << 2)
-#define SYSC_OMAP2_SOFTRESET		(1 << 1)
-#define SYSC_OMAP2_AUTOIDLE		(1 << 0)
-
-/* Generic sysc found on omap4 and later, also known as type2 */
-#define SYSC_OMAP4_DMADISABLE		(1 << 16)
-#define SYSC_OMAP4_FREEEMU		(1 << 1)	/* Also known as EMUFREE */
-#define SYSC_OMAP4_SOFTRESET		(1 << 0)
-
-/* SmartReflex sysc found on 36xx and later */
-#define SYSC_OMAP3_SR_ENAWAKEUP		(1 << 26)
-
-#define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
-
-/* PRUSS sysc found on AM33xx/AM43xx/AM57xx */
-#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
-#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
-
-/* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
-#define SYSC_IDLE_FORCE			0
-#define SYSC_IDLE_NO			1
-#define SYSC_IDLE_SMART			2
-#define SYSC_IDLE_SMART_WKUP		3
diff --git a/include/dt-bindings/clock/bcm6328-clock.h b/include/dt-bindings/clock/bcm6328-clock.h
deleted file mode 100644
index 6f1e018a74bb..000000000000
--- a/include/dt-bindings/clock/bcm6328-clock.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM6328_H
-#define __DT_BINDINGS_CLOCK_BCM6328_H
-
-#define BCM6328_CLK_PHYMIPS	0
-#define BCM6328_CLK_ADSL_QPROC	1
-#define BCM6328_CLK_ADSL_AFE	2
-#define BCM6328_CLK_ADSL	3
-#define BCM6328_CLK_MIPS	4
-#define BCM6328_CLK_SAR		5
-#define BCM6328_CLK_PCM		6
-#define BCM6328_CLK_USBD	7
-#define BCM6328_CLK_USBH	8
-#define BCM6328_CLK_HSSPI	9
-#define BCM6328_CLK_PCIE	10
-#define BCM6328_CLK_ROBOSW	11
-
-#endif /* __DT_BINDINGS_CLOCK_BCM6328_H */
diff --git a/include/dt-bindings/clock/maxim,max77802.h b/include/dt-bindings/clock/maxim,max77802.h
deleted file mode 100644
index 997312edcbb5..000000000000
--- a/include/dt-bindings/clock/maxim,max77802.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2014 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Device Tree binding constants clocks for the Maxim 77802 PMIC.
- */
-
-#ifndef _DT_BINDINGS_CLOCK_MAXIM_MAX77802_CLOCK_H
-#define _DT_BINDINGS_CLOCK_MAXIM_MAX77802_CLOCK_H
-
-/* Fixed rate clocks. */
-
-#define MAX77802_CLK_32K_AP		0
-#define MAX77802_CLK_32K_CP		1
-
-/* Total number of clocks. */
-#define MAX77802_CLKS_NUM		(MAX77802_CLK_32K_CP + 1)
-
-#endif /* _DT_BINDINGS_CLOCK_MAXIM_MAX77802_CLOCK_H */
diff --git a/include/dt-bindings/clock/tegra124-car.h b/include/dt-bindings/clock/tegra124-car.h
deleted file mode 100644
index 2860737f0443..000000000000
--- a/include/dt-bindings/clock/tegra124-car.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * This header provides Tegra124-specific constants for binding
- * nvidia,tegra124-car.
- */
-
-#include <dt-bindings/clock/tegra124-car-common.h>
-
-#ifndef _DT_BINDINGS_CLOCK_TEGRA124_CAR_H
-#define _DT_BINDINGS_CLOCK_TEGRA124_CAR_H
-
-#define TEGRA124_CLK_PLL_X		227
-#define TEGRA124_CLK_PLL_X_OUT0		228
-
-#define TEGRA124_CLK_CCLK_G		262
-#define TEGRA124_CLK_CCLK_LP		263
-
-#define TEGRA124_CLK_CLK_MAX		315
-
-#endif	/* _DT_BINDINGS_CLOCK_TEGRA124_CAR_H */
diff --git a/include/dt-bindings/clock/tegra186-clock.h b/include/dt-bindings/clock/tegra186-clock.h
deleted file mode 100644
index f73d32098f99..000000000000
--- a/include/dt-bindings/clock/tegra186-clock.h
+++ /dev/null
@@ -1,940 +0,0 @@
-/** @file */
-
-#ifndef _MACH_T186_CLK_T186_H
-#define _MACH_T186_CLK_T186_H
-
-/**
- * @defgroup clock_ids Clock Identifiers
- * @{
- *   @defgroup extern_input external input clocks
- *   @{
- *     @def TEGRA186_CLK_OSC
- *     @def TEGRA186_CLK_CLK_32K
- *     @def TEGRA186_CLK_DTV_INPUT
- *     @def TEGRA186_CLK_SOR0_PAD_CLKOUT
- *     @def TEGRA186_CLK_SOR1_PAD_CLKOUT
- *     @def TEGRA186_CLK_I2S1_SYNC_INPUT
- *     @def TEGRA186_CLK_I2S2_SYNC_INPUT
- *     @def TEGRA186_CLK_I2S3_SYNC_INPUT
- *     @def TEGRA186_CLK_I2S4_SYNC_INPUT
- *     @def TEGRA186_CLK_I2S5_SYNC_INPUT
- *     @def TEGRA186_CLK_I2S6_SYNC_INPUT
- *     @def TEGRA186_CLK_SPDIFIN_SYNC_INPUT
- *   @}
- *
- *   @defgroup extern_output external output clocks
- *   @{
- *     @def TEGRA186_CLK_EXTPERIPH1
- *     @def TEGRA186_CLK_EXTPERIPH2
- *     @def TEGRA186_CLK_EXTPERIPH3
- *     @def TEGRA186_CLK_EXTPERIPH4
- *   @}
- *
- *   @defgroup display_clks display related clocks
- *   @{
- *     @def TEGRA186_CLK_CEC
- *     @def TEGRA186_CLK_DSIC
- *     @def TEGRA186_CLK_DSIC_LP
- *     @def TEGRA186_CLK_DSID
- *     @def TEGRA186_CLK_DSID_LP
- *     @def TEGRA186_CLK_DPAUX1
- *     @def TEGRA186_CLK_DPAUX
- *     @def TEGRA186_CLK_HDA2HDMICODEC
- *     @def TEGRA186_CLK_NVDISPLAY_DISP
- *     @def TEGRA186_CLK_NVDISPLAY_DSC
- *     @def TEGRA186_CLK_NVDISPLAY_P0
- *     @def TEGRA186_CLK_NVDISPLAY_P1
- *     @def TEGRA186_CLK_NVDISPLAY_P2
- *     @def TEGRA186_CLK_NVDISPLAYHUB
- *     @def TEGRA186_CLK_SOR_SAFE
- *     @def TEGRA186_CLK_SOR0
- *     @def TEGRA186_CLK_SOR0_OUT
- *     @def TEGRA186_CLK_SOR1
- *     @def TEGRA186_CLK_SOR1_OUT
- *     @def TEGRA186_CLK_DSI
- *     @def TEGRA186_CLK_MIPI_CAL
- *     @def TEGRA186_CLK_DSIA_LP
- *     @def TEGRA186_CLK_DSIB
- *     @def TEGRA186_CLK_DSIB_LP
- *   @}
- *
- *   @defgroup camera_clks camera related clocks
- *   @{
- *     @def TEGRA186_CLK_NVCSI
- *     @def TEGRA186_CLK_NVCSILP
- *     @def TEGRA186_CLK_VI
- *   @}
- *
- *   @defgroup audio_clks audio related clocks
- *   @{
- *     @def TEGRA186_CLK_ACLK
- *     @def TEGRA186_CLK_ADSP
- *     @def TEGRA186_CLK_ADSPNEON
- *     @def TEGRA186_CLK_AHUB
- *     @def TEGRA186_CLK_APE
- *     @def TEGRA186_CLK_APB2APE
- *     @def TEGRA186_CLK_AUD_MCLK
- *     @def TEGRA186_CLK_DMIC1
- *     @def TEGRA186_CLK_DMIC2
- *     @def TEGRA186_CLK_DMIC3
- *     @def TEGRA186_CLK_DMIC4
- *     @def TEGRA186_CLK_DSPK1
- *     @def TEGRA186_CLK_DSPK2
- *     @def TEGRA186_CLK_HDA
- *     @def TEGRA186_CLK_HDA2CODEC_2X
- *     @def TEGRA186_CLK_I2S1
- *     @def TEGRA186_CLK_I2S2
- *     @def TEGRA186_CLK_I2S3
- *     @def TEGRA186_CLK_I2S4
- *     @def TEGRA186_CLK_I2S5
- *     @def TEGRA186_CLK_I2S6
- *     @def TEGRA186_CLK_MAUD
- *     @def TEGRA186_CLK_PLL_A_OUT0
- *     @def TEGRA186_CLK_SPDIF_DOUBLER
- *     @def TEGRA186_CLK_SPDIF_IN
- *     @def TEGRA186_CLK_SPDIF_OUT
- *     @def TEGRA186_CLK_SYNC_DMIC1
- *     @def TEGRA186_CLK_SYNC_DMIC2
- *     @def TEGRA186_CLK_SYNC_DMIC3
- *     @def TEGRA186_CLK_SYNC_DMIC4
- *     @def TEGRA186_CLK_SYNC_DMIC5
- *     @def TEGRA186_CLK_SYNC_DSPK1
- *     @def TEGRA186_CLK_SYNC_DSPK2
- *     @def TEGRA186_CLK_SYNC_I2S1
- *     @def TEGRA186_CLK_SYNC_I2S2
- *     @def TEGRA186_CLK_SYNC_I2S3
- *     @def TEGRA186_CLK_SYNC_I2S4
- *     @def TEGRA186_CLK_SYNC_I2S5
- *     @def TEGRA186_CLK_SYNC_I2S6
- *     @def TEGRA186_CLK_SYNC_SPDIF
- *   @}
- *
- *   @defgroup uart_clks UART clocks
- *   @{
- *     @def TEGRA186_CLK_AON_UART_FST_MIPI_CAL
- *     @def TEGRA186_CLK_UARTA
- *     @def TEGRA186_CLK_UARTB
- *     @def TEGRA186_CLK_UARTC
- *     @def TEGRA186_CLK_UARTD
- *     @def TEGRA186_CLK_UARTE
- *     @def TEGRA186_CLK_UARTF
- *     @def TEGRA186_CLK_UARTG
- *     @def TEGRA186_CLK_UART_FST_MIPI_CAL
- *   @}
- *
- *   @defgroup i2c_clks I2C clocks
- *   @{
- *     @def TEGRA186_CLK_AON_I2C_SLOW
- *     @def TEGRA186_CLK_I2C1
- *     @def TEGRA186_CLK_I2C2
- *     @def TEGRA186_CLK_I2C3
- *     @def TEGRA186_CLK_I2C4
- *     @def TEGRA186_CLK_I2C5
- *     @def TEGRA186_CLK_I2C6
- *     @def TEGRA186_CLK_I2C8
- *     @def TEGRA186_CLK_I2C9
- *     @def TEGRA186_CLK_I2C1
- *     @def TEGRA186_CLK_I2C12
- *     @def TEGRA186_CLK_I2C13
- *     @def TEGRA186_CLK_I2C14
- *     @def TEGRA186_CLK_I2C_SLOW
- *     @def TEGRA186_CLK_VI_I2C
- *   @}
- *
- *   @defgroup spi_clks SPI clocks
- *   @{
- *     @def TEGRA186_CLK_SPI1
- *     @def TEGRA186_CLK_SPI2
- *     @def TEGRA186_CLK_SPI3
- *     @def TEGRA186_CLK_SPI4
- *   @}
- *
- *   @defgroup storage storage related clocks
- *   @{
- *     @def TEGRA186_CLK_SATA
- *     @def TEGRA186_CLK_SATA_OOB
- *     @def TEGRA186_CLK_SATA_IOBIST
- *     @def TEGRA186_CLK_SDMMC_LEGACY_TM
- *     @def TEGRA186_CLK_SDMMC1
- *     @def TEGRA186_CLK_SDMMC2
- *     @def TEGRA186_CLK_SDMMC3
- *     @def TEGRA186_CLK_SDMMC4
- *     @def TEGRA186_CLK_QSPI
- *     @def TEGRA186_CLK_QSPI_OUT
- *     @def TEGRA186_CLK_UFSDEV_REF
- *     @def TEGRA186_CLK_UFSHC
- *   @}
- *
- *   @defgroup pwm_clks PWM clocks
- *   @{
- *     @def TEGRA186_CLK_PWM1
- *     @def TEGRA186_CLK_PWM2
- *     @def TEGRA186_CLK_PWM3
- *     @def TEGRA186_CLK_PWM4
- *     @def TEGRA186_CLK_PWM5
- *     @def TEGRA186_CLK_PWM6
- *     @def TEGRA186_CLK_PWM7
- *     @def TEGRA186_CLK_PWM8
- *   @}
- *
- *   @defgroup plls PLLs and related clocks
- *   @{
- *     @def TEGRA186_CLK_PLLREFE_OUT_GATED
- *     @def TEGRA186_CLK_PLLREFE_OUT1
- *     @def TEGRA186_CLK_PLLD_OUT1
- *     @def TEGRA186_CLK_PLLP_OUT0
- *     @def TEGRA186_CLK_PLLP_OUT5
- *     @def TEGRA186_CLK_PLLA
- *     @def TEGRA186_CLK_PLLE_PWRSEQ
- *     @def TEGRA186_CLK_PLLA_OUT1
- *     @def TEGRA186_CLK_PLLREFE_REF
- *     @def TEGRA186_CLK_UPHY_PLL0_PWRSEQ
- *     @def TEGRA186_CLK_UPHY_PLL1_PWRSEQ
- *     @def TEGRA186_CLK_PLLREFE_PLLE_PASSTHROUGH
- *     @def TEGRA186_CLK_PLLREFE_PEX
- *     @def TEGRA186_CLK_PLLREFE_IDDQ
- *     @def TEGRA186_CLK_PLLC_OUT_AON
- *     @def TEGRA186_CLK_PLLC_OUT_ISP
- *     @def TEGRA186_CLK_PLLC_OUT_VE
- *     @def TEGRA186_CLK_PLLC4_OUT
- *     @def TEGRA186_CLK_PLLREFE_OUT
- *     @def TEGRA186_CLK_PLLREFE_PLL_REF
- *     @def TEGRA186_CLK_PLLE
- *     @def TEGRA186_CLK_PLLC
- *     @def TEGRA186_CLK_PLLP
- *     @def TEGRA186_CLK_PLLD
- *     @def TEGRA186_CLK_PLLD2
- *     @def TEGRA186_CLK_PLLREFE_VCO
- *     @def TEGRA186_CLK_PLLC2
- *     @def TEGRA186_CLK_PLLC3
- *     @def TEGRA186_CLK_PLLDP
- *     @def TEGRA186_CLK_PLLC4_VCO
- *     @def TEGRA186_CLK_PLLA1
- *     @def TEGRA186_CLK_PLLNVCSI
- *     @def TEGRA186_CLK_PLLDISPHUB
- *     @def TEGRA186_CLK_PLLD3
- *     @def TEGRA186_CLK_PLLBPMPCAM
- *     @def TEGRA186_CLK_PLLAON
- *     @def TEGRA186_CLK_PLLU
- *     @def TEGRA186_CLK_PLLC4_VCO_DIV2
- *     @def TEGRA186_CLK_PLL_REF
- *     @def TEGRA186_CLK_PLLREFE_OUT1_DIV5
- *     @def TEGRA186_CLK_UTMIP_PLL_PWRSEQ
- *     @def TEGRA186_CLK_PLL_U_48M
- *     @def TEGRA186_CLK_PLL_U_480M
- *     @def TEGRA186_CLK_PLLC4_OUT0
- *     @def TEGRA186_CLK_PLLC4_OUT1
- *     @def TEGRA186_CLK_PLLC4_OUT2
- *     @def TEGRA186_CLK_PLLC4_OUT_MUX
- *     @def TEGRA186_CLK_DFLLDISP_DIV
- *     @def TEGRA186_CLK_PLLDISPHUB_DIV
- *     @def TEGRA186_CLK_PLLP_DIV8
- *   @}
- *
- *   @defgroup nafll_clks NAFLL clock sources
- *   @{
- *     @def TEGRA186_CLK_NAFLL_AXI_CBB
- *     @def TEGRA186_CLK_NAFLL_BCPU
- *     @def TEGRA186_CLK_NAFLL_BPMP
- *     @def TEGRA186_CLK_NAFLL_DISP
- *     @def TEGRA186_CLK_NAFLL_GPU
- *     @def TEGRA186_CLK_NAFLL_ISP
- *     @def TEGRA186_CLK_NAFLL_MCPU
- *     @def TEGRA186_CLK_NAFLL_NVDEC
- *     @def TEGRA186_CLK_NAFLL_NVENC
- *     @def TEGRA186_CLK_NAFLL_NVJPG
- *     @def TEGRA186_CLK_NAFLL_SCE
- *     @def TEGRA186_CLK_NAFLL_SE
- *     @def TEGRA186_CLK_NAFLL_TSEC
- *     @def TEGRA186_CLK_NAFLL_TSECB
- *     @def TEGRA186_CLK_NAFLL_VI
- *     @def TEGRA186_CLK_NAFLL_VIC
- *   @}
- *
- *   @defgroup mphy MPHY related clocks
- *   @{
- *     @def TEGRA186_CLK_MPHY_L0_RX_SYMB
- *     @def TEGRA186_CLK_MPHY_L0_RX_LS_BIT
- *     @def TEGRA186_CLK_MPHY_L0_TX_SYMB
- *     @def TEGRA186_CLK_MPHY_L0_TX_LS_3XBIT
- *     @def TEGRA186_CLK_MPHY_L0_RX_ANA
- *     @def TEGRA186_CLK_MPHY_L1_RX_ANA
- *     @def TEGRA186_CLK_MPHY_IOBIST
- *     @def TEGRA186_CLK_MPHY_TX_1MHZ_REF
- *     @def TEGRA186_CLK_MPHY_CORE_PLL_FIXED
- *   @}
- *
- *   @defgroup eavb EAVB related clocks
- *   @{
- *     @def TEGRA186_CLK_EQOS_AXI
- *     @def TEGRA186_CLK_EQOS_PTP_REF
- *     @def TEGRA186_CLK_EQOS_RX
- *     @def TEGRA186_CLK_EQOS_RX_INPUT
- *     @def TEGRA186_CLK_EQOS_TX
- *   @}
- *
- *   @defgroup usb USB related clocks
- *   @{
- *     @def TEGRA186_CLK_PEX_USB_PAD0_MGMT
- *     @def TEGRA186_CLK_PEX_USB_PAD1_MGMT
- *     @def TEGRA186_CLK_HSIC_TRK
- *     @def TEGRA186_CLK_USB2_TRK
- *     @def TEGRA186_CLK_USB2_HSIC_TRK
- *     @def TEGRA186_CLK_XUSB_CORE_SS
- *     @def TEGRA186_CLK_XUSB_CORE_DEV
- *     @def TEGRA186_CLK_XUSB_FALCON
- *     @def TEGRA186_CLK_XUSB_FS
- *     @def TEGRA186_CLK_XUSB
- *     @def TEGRA186_CLK_XUSB_DEV
- *     @def TEGRA186_CLK_XUSB_HOST
- *     @def TEGRA186_CLK_XUSB_SS
- *   @}
- *
- *   @defgroup bigblock compute block related clocks
- *   @{
- *     @def TEGRA186_CLK_GPCCLK
- *     @def TEGRA186_CLK_GPC2CLK
- *     @def TEGRA186_CLK_GPU
- *     @def TEGRA186_CLK_HOST1X
- *     @def TEGRA186_CLK_ISP
- *     @def TEGRA186_CLK_NVDEC
- *     @def TEGRA186_CLK_NVENC
- *     @def TEGRA186_CLK_NVJPG
- *     @def TEGRA186_CLK_SE
- *     @def TEGRA186_CLK_TSEC
- *     @def TEGRA186_CLK_TSECB
- *     @def TEGRA186_CLK_VIC
- *   @}
- *
- *   @defgroup can CAN bus related clocks
- *   @{
- *     @def TEGRA186_CLK_CAN1
- *     @def TEGRA186_CLK_CAN1_HOST
- *     @def TEGRA186_CLK_CAN2
- *     @def TEGRA186_CLK_CAN2_HOST
- *   @}
- *
- *   @defgroup system basic system clocks
- *   @{
- *     @def TEGRA186_CLK_ACTMON
- *     @def TEGRA186_CLK_AON_APB
- *     @def TEGRA186_CLK_AON_CPU_NIC
- *     @def TEGRA186_CLK_AON_NIC
- *     @def TEGRA186_CLK_AXI_CBB
- *     @def TEGRA186_CLK_BPMP_APB
- *     @def TEGRA186_CLK_BPMP_CPU_NIC
- *     @def TEGRA186_CLK_BPMP_NIC_RATE
- *     @def TEGRA186_CLK_CLK_M
- *     @def TEGRA186_CLK_EMC
- *     @def TEGRA186_CLK_MSS_ENCRYPT
- *     @def TEGRA186_CLK_SCE_APB
- *     @def TEGRA186_CLK_SCE_CPU_NIC
- *     @def TEGRA186_CLK_SCE_NIC
- *     @def TEGRA186_CLK_TSC
- *   @}
- *
- *   @defgroup pcie_clks PCIe related clocks
- *   @{
- *     @def TEGRA186_CLK_AFI
- *     @def TEGRA186_CLK_PCIE
- *     @def TEGRA186_CLK_PCIE2_IOBIST
- *     @def TEGRA186_CLK_PCIERX0
- *     @def TEGRA186_CLK_PCIERX1
- *     @def TEGRA186_CLK_PCIERX2
- *     @def TEGRA186_CLK_PCIERX3
- *     @def TEGRA186_CLK_PCIERX4
- *   @}
- */
-
-/** @brief output of gate CLK_ENB_FUSE */
-#define TEGRA186_CLK_FUSE 0
-/**
- * @brief It's not what you think
- * @details output of gate CLK_ENB_GPU. This output connects to the GPU
- * pwrclk. @warning: This is almost certainly not the clock you think
- * it is. If you're looking for the clock of the graphics engine, see
- * TEGRA186_GPCCLK
- */
-#define TEGRA186_CLK_GPU 1
-/** @brief output of gate CLK_ENB_PCIE */
-#define TEGRA186_CLK_PCIE 3
-/** @brief output of the divider IPFS_CLK_DIVISOR */
-#define TEGRA186_CLK_AFI 4
-/** @brief output of gate CLK_ENB_PCIE2_IOBIST */
-#define TEGRA186_CLK_PCIE2_IOBIST 5
-/** @brief output of gate CLK_ENB_PCIERX0*/
-#define TEGRA186_CLK_PCIERX0 6
-/** @brief output of gate CLK_ENB_PCIERX1*/
-#define TEGRA186_CLK_PCIERX1 7
-/** @brief output of gate CLK_ENB_PCIERX2*/
-#define TEGRA186_CLK_PCIERX2 8
-/** @brief output of gate CLK_ENB_PCIERX3*/
-#define TEGRA186_CLK_PCIERX3 9
-/** @brief output of gate CLK_ENB_PCIERX4*/
-#define TEGRA186_CLK_PCIERX4 10
-/** @brief output branch of PLL_C for ISP, controlled by gate CLK_ENB_PLLC_OUT_ISP */
-#define TEGRA186_CLK_PLLC_OUT_ISP 11
-/** @brief output branch of PLL_C for VI, controlled by gate CLK_ENB_PLLC_OUT_VE */
-#define TEGRA186_CLK_PLLC_OUT_VE 12
-/** @brief output branch of PLL_C for AON domain, controlled by gate CLK_ENB_PLLC_OUT_AON */
-#define TEGRA186_CLK_PLLC_OUT_AON 13
-/** @brief output of gate CLK_ENB_SOR_SAFE */
-#define TEGRA186_CLK_SOR_SAFE 39
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S2 */
-#define TEGRA186_CLK_I2S2 42
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S3 */
-#define TEGRA186_CLK_I2S3 43
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPDF_IN */
-#define TEGRA186_CLK_SPDIF_IN 44
-/** @brief output of gate CLK_ENB_SPDIF_DOUBLER */
-#define TEGRA186_CLK_SPDIF_DOUBLER 45
-/**  @clkdesc{spi_clks, out, mux, CLK_RST_CONTROLLER_CLK_SOURCE_SPI3} */
-#define TEGRA186_CLK_SPI3 46
-/** @clkdesc{i2c_clks, out, mux, CLK_RST_CONTROLLER_CLK_SOURCE_I2C1} */
-#define TEGRA186_CLK_I2C1 47
-/** @clkdesc{i2c_clks, out, mux, CLK_RST_CONTROLLER_CLK_SOURCE_I2C5} */
-#define TEGRA186_CLK_I2C5 48
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPI1 */
-#define TEGRA186_CLK_SPI1 49
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_ISP */
-#define TEGRA186_CLK_ISP 50
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_VI */
-#define TEGRA186_CLK_VI 51
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC1 */
-#define TEGRA186_CLK_SDMMC1 52
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC2 */
-#define TEGRA186_CLK_SDMMC2 53
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC4 */
-#define TEGRA186_CLK_SDMMC4 54
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTA */
-#define TEGRA186_CLK_UARTA 55
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTB */
-#define TEGRA186_CLK_UARTB 56
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HOST1X */
-#define TEGRA186_CLK_HOST1X 57
-/**
- * @brief controls the EMC clock frequency.
- * @details Doing a clk_set_rate on this clock will select the
- * appropriate clock source, program the source rate and execute a
- * specific sequence to switch to the new clock source for both memory
- * controllers. This can be used to control the balance between memory
- * throughput and memory controller power.
- */
-#define TEGRA186_CLK_EMC 58
-/* @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH4 */
-#define TEGRA186_CLK_EXTPERIPH4 73
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPI4 */
-#define TEGRA186_CLK_SPI4 74
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C3 */
-#define TEGRA186_CLK_I2C3 75
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC3 */
-#define TEGRA186_CLK_SDMMC3 76
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTD */
-#define TEGRA186_CLK_UARTD 77
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S1 */
-#define TEGRA186_CLK_I2S1 79
-/** output of gate CLK_ENB_DTV */
-#define TEGRA186_CLK_DTV 80
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TSEC */
-#define TEGRA186_CLK_TSEC 81
-/** @brief output of gate CLK_ENB_DP2 */
-#define TEGRA186_CLK_DP2 82
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S4 */
-#define TEGRA186_CLK_I2S4 84
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S5 */
-#define TEGRA186_CLK_I2S5 85
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C4 */
-#define TEGRA186_CLK_I2C4 86
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AHUB */
-#define TEGRA186_CLK_AHUB 87
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HDA2CODEC_2X */
-#define TEGRA186_CLK_HDA2CODEC_2X 88
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH1 */
-#define TEGRA186_CLK_EXTPERIPH1 89
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH2 */
-#define TEGRA186_CLK_EXTPERIPH2 90
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH3 */
-#define TEGRA186_CLK_EXTPERIPH3 91
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C_SLOW */
-#define TEGRA186_CLK_I2C_SLOW 92
-/** @brief output of the SOR1_CLK_SRC mux in CLK_RST_CONTROLLER_CLK_SOURCE_SOR1 */
-#define TEGRA186_CLK_SOR1 93
-/** @brief output of gate CLK_ENB_CEC */
-#define TEGRA186_CLK_CEC 94
-/** @brief output of gate CLK_ENB_DPAUX1 */
-#define TEGRA186_CLK_DPAUX1 95
-/** @brief output of gate CLK_ENB_DPAUX */
-#define TEGRA186_CLK_DPAUX 96
-/** @brief output of the SOR0_CLK_SRC mux in CLK_RST_CONTROLLER_CLK_SOURCE_SOR0 */
-#define TEGRA186_CLK_SOR0 97
-/** @brief output of gate CLK_ENB_HDA2HDMICODEC */
-#define TEGRA186_CLK_HDA2HDMICODEC 98
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SATA */
-#define TEGRA186_CLK_SATA 99
-/** @brief output of gate CLK_ENB_SATA_OOB */
-#define TEGRA186_CLK_SATA_OOB 100
-/** @brief output of gate CLK_ENB_SATA_IOBIST */
-#define TEGRA186_CLK_SATA_IOBIST 101
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HDA */
-#define TEGRA186_CLK_HDA 102
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SE */
-#define TEGRA186_CLK_SE 103
-/** @brief output of gate CLK_ENB_APB2APE */
-#define TEGRA186_CLK_APB2APE 104
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_APE */
-#define TEGRA186_CLK_APE 105
-/** @brief output of gate CLK_ENB_IQC1 */
-#define TEGRA186_CLK_IQC1 106
-/** @brief output of gate CLK_ENB_IQC2 */
-#define TEGRA186_CLK_IQC2 107
-/** divide by 2 version of TEGRA186_CLK_PLLREFE_VCO */
-#define TEGRA186_CLK_PLLREFE_OUT 108
-/** @brief output of gate CLK_ENB_PLLREFE_PLL_REF */
-#define TEGRA186_CLK_PLLREFE_PLL_REF 109
-/** @brief output of gate CLK_ENB_PLLC4_OUT */
-#define TEGRA186_CLK_PLLC4_OUT 110
-/** @brief output of mux xusb_core_clk_switch on page 67 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB 111
-/** controls xusb_dev_ce signal on page 66 and 67 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_DEV 112
-/** controls xusb_host_ce signal on page 67 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_HOST 113
-/** controls xusb_ss_ce signal on page 67 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_SS 114
-/** @brief output of gate CLK_ENB_DSI */
-#define TEGRA186_CLK_DSI 115
-/** @brief output of gate CLK_ENB_MIPI_CAL */
-#define TEGRA186_CLK_MIPI_CAL 116
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSIA_LP */
-#define TEGRA186_CLK_DSIA_LP 117
-/** @brief output of gate CLK_ENB_DSIB */
-#define TEGRA186_CLK_DSIB 118
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSIB_LP */
-#define TEGRA186_CLK_DSIB_LP 119
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC1 */
-#define TEGRA186_CLK_DMIC1 122
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC2 */
-#define TEGRA186_CLK_DMIC2 123
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AUD_MCLK */
-#define TEGRA186_CLK_AUD_MCLK 124
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C6 */
-#define TEGRA186_CLK_I2C6 125
-/**output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UART_FST_MIPI_CAL */
-#define TEGRA186_CLK_UART_FST_MIPI_CAL 126
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_VIC */
-#define TEGRA186_CLK_VIC 127
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC_LEGACY_TM */
-#define TEGRA186_CLK_SDMMC_LEGACY_TM 128
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDEC */
-#define TEGRA186_CLK_NVDEC 129
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVJPG */
-#define TEGRA186_CLK_NVJPG 130
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVENC */
-#define TEGRA186_CLK_NVENC 131
-/** @brief output of the QSPI_CLK_SRC mux in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI */
-#define TEGRA186_CLK_QSPI 132
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_VI_I2C */
-#define TEGRA186_CLK_VI_I2C 133
-/** @brief output of gate CLK_ENB_HSIC_TRK */
-#define TEGRA186_CLK_HSIC_TRK 134
-/** @brief output of gate CLK_ENB_USB2_TRK */
-#define TEGRA186_CLK_USB2_TRK 135
-/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_MAUD */
-#define TEGRA186_CLK_MAUD 136
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TSECB */
-#define TEGRA186_CLK_TSECB 137
-/** @brief output of gate CLK_ENB_ADSP */
-#define TEGRA186_CLK_ADSP 138
-/** @brief output of gate CLK_ENB_ADSPNEON */
-#define TEGRA186_CLK_ADSPNEON 139
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_L0_RX_LS_SYMB */
-#define TEGRA186_CLK_MPHY_L0_RX_SYMB 140
-/** @brief output of gate CLK_ENB_MPHY_L0_RX_LS_BIT */
-#define TEGRA186_CLK_MPHY_L0_RX_LS_BIT 141
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_L0_TX_LS_SYMB */
-#define TEGRA186_CLK_MPHY_L0_TX_SYMB 142
-/** @brief output of gate CLK_ENB_MPHY_L0_TX_LS_3XBIT */
-#define TEGRA186_CLK_MPHY_L0_TX_LS_3XBIT 143
-/** @brief output of gate CLK_ENB_MPHY_L0_RX_ANA */
-#define TEGRA186_CLK_MPHY_L0_RX_ANA 144
-/** @brief output of gate CLK_ENB_MPHY_L1_RX_ANA */
-#define TEGRA186_CLK_MPHY_L1_RX_ANA 145
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_IOBIST */
-#define TEGRA186_CLK_MPHY_IOBIST 146
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_TX_1MHZ_REF */
-#define TEGRA186_CLK_MPHY_TX_1MHZ_REF 147
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_CORE_PLL_FIXED */
-#define TEGRA186_CLK_MPHY_CORE_PLL_FIXED 148
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AXI_CBB */
-#define TEGRA186_CLK_AXI_CBB 149
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC3 */
-#define TEGRA186_CLK_DMIC3 150
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC4 */
-#define TEGRA186_CLK_DMIC4 151
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSPK1 */
-#define TEGRA186_CLK_DSPK1 152
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSPK2 */
-#define TEGRA186_CLK_DSPK2 153
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C6 */
-#define TEGRA186_CLK_I2S6 154
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P0 */
-#define TEGRA186_CLK_NVDISPLAY_P0 155
-/** @brief output of the NVDISPLAY_DISP_CLK_SRC mux in CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_DISP */
-#define TEGRA186_CLK_NVDISPLAY_DISP 156
-/** @brief output of gate CLK_ENB_NVDISPLAY_DSC */
-#define TEGRA186_CLK_NVDISPLAY_DSC 157
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAYHUB */
-#define TEGRA186_CLK_NVDISPLAYHUB 158
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P1 */
-#define TEGRA186_CLK_NVDISPLAY_P1 159
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P2 */
-#define TEGRA186_CLK_NVDISPLAY_P2 160
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TACH */
-#define TEGRA186_CLK_TACH 166
-/** @brief output of gate CLK_ENB_EQOS */
-#define TEGRA186_CLK_EQOS_AXI 167
-/** @brief output of gate CLK_ENB_EQOS_RX */
-#define TEGRA186_CLK_EQOS_RX 168
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UFSHC_CG_SYS */
-#define TEGRA186_CLK_UFSHC 178
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UFSDEV_REF */
-#define TEGRA186_CLK_UFSDEV_REF 179
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVCSI */
-#define TEGRA186_CLK_NVCSI 180
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVCSILP */
-#define TEGRA186_CLK_NVCSILP 181
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C7 */
-#define TEGRA186_CLK_I2C7 182
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C9 */
-#define TEGRA186_CLK_I2C9 183
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C12 */
-#define TEGRA186_CLK_I2C12 184
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C13 */
-#define TEGRA186_CLK_I2C13 185
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C14 */
-#define TEGRA186_CLK_I2C14 186
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM1 */
-#define TEGRA186_CLK_PWM1 187
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM2 */
-#define TEGRA186_CLK_PWM2 188
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM3 */
-#define TEGRA186_CLK_PWM3 189
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM5 */
-#define TEGRA186_CLK_PWM5 190
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM6 */
-#define TEGRA186_CLK_PWM6 191
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM7 */
-#define TEGRA186_CLK_PWM7 192
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM8 */
-#define TEGRA186_CLK_PWM8 193
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTE */
-#define TEGRA186_CLK_UARTE 194
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTF */
-#define TEGRA186_CLK_UARTF 195
-/** @deprecated */
-#define TEGRA186_CLK_DBGAPB 196
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_BPMP_CPU_NIC */
-#define TEGRA186_CLK_BPMP_CPU_NIC 197
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_BPMP_APB */
-#define TEGRA186_CLK_BPMP_APB 199
-/** @brief output of mux controlled by TEGRA186_CLK_SOC_ACTMON */
-#define TEGRA186_CLK_ACTMON 201
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AON_CPU_NIC */
-#define TEGRA186_CLK_AON_CPU_NIC 208
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_CAN1 */
-#define TEGRA186_CLK_CAN1 210
-/** @brief output of gate CLK_ENB_CAN1_HOST */
-#define TEGRA186_CLK_CAN1_HOST 211
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_CAN2 */
-#define TEGRA186_CLK_CAN2 212
-/** @brief output of gate CLK_ENB_CAN2_HOST */
-#define TEGRA186_CLK_CAN2_HOST 213
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AON_APB */
-#define TEGRA186_CLK_AON_APB 214
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTC */
-#define TEGRA186_CLK_UARTC 215
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTG */
-#define TEGRA186_CLK_UARTG 216
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AON_UART_FST_MIPI_CAL */
-#define TEGRA186_CLK_AON_UART_FST_MIPI_CAL 217
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C2 */
-#define TEGRA186_CLK_I2C2 218
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C8 */
-#define TEGRA186_CLK_I2C8 219
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C10 */
-#define TEGRA186_CLK_I2C10 220
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AON_I2C_SLOW */
-#define TEGRA186_CLK_AON_I2C_SLOW 221
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPI2 */
-#define TEGRA186_CLK_SPI2 222
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC5 */
-#define TEGRA186_CLK_DMIC5 223
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AON_TOUCH */
-#define TEGRA186_CLK_AON_TOUCH 224
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM4 */
-#define TEGRA186_CLK_PWM4 225
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TSC. This clock object is read only and is used for all timers in the system. */
-#define TEGRA186_CLK_TSC 226
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_MSS_ENCRYPT */
-#define TEGRA186_CLK_MSS_ENCRYPT 227
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SCE_CPU_NIC */
-#define TEGRA186_CLK_SCE_CPU_NIC 228
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SCE_APB */
-#define TEGRA186_CLK_SCE_APB 230
-/** @brief output of gate CLK_ENB_DSIC */
-#define TEGRA186_CLK_DSIC 231
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSIC_LP */
-#define TEGRA186_CLK_DSIC_LP 232
-/** @brief output of gate CLK_ENB_DSID */
-#define TEGRA186_CLK_DSID 233
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSID_LP */
-#define TEGRA186_CLK_DSID_LP 234
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_PEX_SATA_USB_RX_BYP */
-#define TEGRA186_CLK_PEX_SATA_USB_RX_BYP 236
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPDIF_OUT */
-#define TEGRA186_CLK_SPDIF_OUT 238
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_EQOS_PTP_REF_CLK_0 */
-#define TEGRA186_CLK_EQOS_PTP_REF 239
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_EQOS_TX_CLK */
-#define TEGRA186_CLK_EQOS_TX 240
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_USB2_HSIC_TRK */
-#define TEGRA186_CLK_USB2_HSIC_TRK 241
-/** @brief output of mux xusb_ss_clk_switch on page 66 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_CORE_SS 242
-/** @brief output of mux xusb_core_dev_clk_switch on page 67 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_CORE_DEV 243
-/** @brief output of mux xusb_core_falcon_clk_switch on page 67 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_FALCON 244
-/** @brief output of mux xusb_fs_clk_switch on page 66 of T186_Clocks_IAS.doc */
-#define TEGRA186_CLK_XUSB_FS 245
-/** @brief output of the divider CLK_RST_CONTROLLER_PLLA_OUT */
-#define TEGRA186_CLK_PLL_A_OUT0 246
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S1 */
-#define TEGRA186_CLK_SYNC_I2S1 247
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S2 */
-#define TEGRA186_CLK_SYNC_I2S2 248
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S3 */
-#define TEGRA186_CLK_SYNC_I2S3 249
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S4 */
-#define TEGRA186_CLK_SYNC_I2S4 250
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S5 */
-#define TEGRA186_CLK_SYNC_I2S5 251
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S6 */
-#define TEGRA186_CLK_SYNC_I2S6 252
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DSPK1 */
-#define TEGRA186_CLK_SYNC_DSPK1 253
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DSPK2 */
-#define TEGRA186_CLK_SYNC_DSPK2 254
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC1 */
-#define TEGRA186_CLK_SYNC_DMIC1 255
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC2 */
-#define TEGRA186_CLK_SYNC_DMIC2 256
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC3 */
-#define TEGRA186_CLK_SYNC_DMIC3 257
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC4 */
-#define TEGRA186_CLK_SYNC_DMIC4 259
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_SPDIF */
-#define TEGRA186_CLK_SYNC_SPDIF 260
-/** @brief output of gate CLK_ENB_PLLREFE_OUT */
-#define TEGRA186_CLK_PLLREFE_OUT_GATED 261
-/** @brief output of the divider PLLREFE_DIVP in CLK_RST_CONTROLLER_PLLREFE_BASE. PLLREFE has 2 outputs:
-  *      * VCO/pdiv defined by this clock object
-  *      * VCO/2 defined by TEGRA186_CLK_PLLREFE_OUT
-  */
-#define TEGRA186_CLK_PLLREFE_OUT1 262
-#define TEGRA186_CLK_PLLD_OUT1 267
-/** @brief output of the divider PLLP_DIVP in CLK_RST_CONTROLLER_PLLP_BASE */
-#define TEGRA186_CLK_PLLP_OUT0 269
-/** @brief output of the divider CLK_RST_CONTROLLER_PLLP_OUTC */
-#define TEGRA186_CLK_PLLP_OUT5 270
-/** PLL controlled by CLK_RST_CONTROLLER_PLLA_BASE for use by audio clocks */
-#define TEGRA186_CLK_PLLA 271
-/** @brief output of mux controlled by CLK_RST_CONTROLLER_ACLK_BURST_POLICY divided by the divider controlled by ACLK_CLK_DIVISOR in CLK_RST_CONTROLLER_SUPER_ACLK_DIVIDER */
-#define TEGRA186_CLK_ACLK 273
-/** fixed 48MHz clock divided down from TEGRA186_CLK_PLL_U */
-#define TEGRA186_CLK_PLL_U_48M 274
-/** fixed 480MHz clock divided down from TEGRA186_CLK_PLL_U */
-#define TEGRA186_CLK_PLL_U_480M 275
-/** @brief output of the divider PLLC4_DIVP in CLK_RST_CONTROLLER_PLLC4_BASE. Output frequency is TEGRA186_CLK_PLLC4_VCO/PLLC4_DIVP */
-#define TEGRA186_CLK_PLLC4_OUT0 276
-/** fixed /3 divider. Output frequency of this clock is TEGRA186_CLK_PLLC4_VCO/3 */
-#define TEGRA186_CLK_PLLC4_OUT1 277
-/** fixed /5 divider. Output frequency of this clock is TEGRA186_CLK_PLLC4_VCO/5 */
-#define TEGRA186_CLK_PLLC4_OUT2 278
-/** @brief output of mux controlled by PLLC4_CLK_SEL in CLK_RST_CONTROLLER_PLLC4_MISC1 */
-#define TEGRA186_CLK_PLLC4_OUT_MUX 279
-/** @brief output of divider NVDISPLAY_DISP_CLK_DIVISOR in CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_DISP when DFLLDISP_DIV is selected in NVDISPLAY_DISP_CLK_SRC */
-#define TEGRA186_CLK_DFLLDISP_DIV 284
-/** @brief output of divider NVDISPLAY_DISP_CLK_DIVISOR in CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_DISP when PLLDISPHUB_DIV is selected in NVDISPLAY_DISP_CLK_SRC */
-#define TEGRA186_CLK_PLLDISPHUB_DIV 285
-/** fixed /8 divider which is used as the input for TEGRA186_CLK_SOR_SAFE */
-#define TEGRA186_CLK_PLLP_DIV8 286
-/** @brief output of divider CLK_RST_CONTROLLER_BPMP_NIC_RATE */
-#define TEGRA186_CLK_BPMP_NIC 287
-/** @brief output of the divider CLK_RST_CONTROLLER_PLLA1_OUT1 */
-#define TEGRA186_CLK_PLL_A_OUT1 288
-/** @deprecated */
-#define TEGRA186_CLK_GPC2CLK 289
-/** A fake clock which must be enabled during KFUSE read operations to ensure adequate VDD_CORE voltage. */
-#define TEGRA186_CLK_KFUSE 293
-/**
- * @brief controls the PLLE hardware sequencer.
- * @details This clock only has enable and disable methods. When the
- * PLLE hw sequencer is enabled, PLLE, will be enabled or disabled by
- * hw based on the control signals from the PCIe, SATA and XUSB
- * clocks. When the PLLE hw sequencer is disabled, the state of PLLE
- * is controlled by sw using clk_enable/clk_disable on
- * TEGRA186_CLK_PLLE.
- */
-#define TEGRA186_CLK_PLLE_PWRSEQ 294
-/** fixed 60MHz clock divided down from, TEGRA186_CLK_PLL_U */
-#define TEGRA186_CLK_PLLREFE_REF 295
-/** @brief output of mux controlled by SOR0_CLK_SEL0 and SOR0_CLK_SEL1 in CLK_RST_CONTROLLER_CLK_SOURCE_SOR0 */
-#define TEGRA186_CLK_SOR0_OUT 296
-/** @brief output of mux controlled by SOR1_CLK_SEL0 and SOR1_CLK_SEL1 in CLK_RST_CONTROLLER_CLK_SOURCE_SOR1 */
-#define TEGRA186_CLK_SOR1_OUT 297
-/** @brief fixed /5 divider.  Output frequency of this clock is TEGRA186_CLK_PLLREFE_OUT1/5. Used as input for TEGRA186_CLK_EQOS_AXI */
-#define TEGRA186_CLK_PLLREFE_OUT1_DIV5 298
-/** @brief controls the UTMIP_PLL (aka PLLU) hardware sqeuencer */
-#define TEGRA186_CLK_UTMIP_PLL_PWRSEQ 301
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_PEX_USB_PAD_PLL0_MGMT */
-#define TEGRA186_CLK_PEX_USB_PAD0_MGMT 302
-/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_PEX_USB_PAD_PLL1_MGMT */
-#define TEGRA186_CLK_PEX_USB_PAD1_MGMT 303
-/** @brief controls the UPHY_PLL0 hardware sqeuencer */
-#define TEGRA186_CLK_UPHY_PLL0_PWRSEQ 304
-/** @brief controls the UPHY_PLL1 hardware sqeuencer */
-#define TEGRA186_CLK_UPHY_PLL1_PWRSEQ 305
-/** @brief control for PLLREFE_IDDQ in CLK_RST_CONTROLLER_PLLREFE_MISC so the bypass output even be used when the PLL is disabled */
-#define TEGRA186_CLK_PLLREFE_PLLE_PASSTHROUGH 306
-/** @brief output of the mux controlled by PLLREFE_SEL_CLKIN_PEX in CLK_RST_CONTROLLER_PLLREFE_MISC */
-#define TEGRA186_CLK_PLLREFE_PEX 307
-/** @brief control for PLLREFE_IDDQ in CLK_RST_CONTROLLER_PLLREFE_MISC to turn on the PLL when enabled */
-#define TEGRA186_CLK_PLLREFE_IDDQ 308
-/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI */
-#define TEGRA186_CLK_QSPI_OUT 309
-/**
- * @brief GPC2CLK-div-2
- * @details fixed /2 divider. Output frequency is
- * TEGRA186_CLK_GPC2CLK/2. The frequency of this clock is the
- * frequency at which the GPU graphics engine runs. */
-#define TEGRA186_CLK_GPCCLK 310
-/** @brief output of divider CLK_RST_CONTROLLER_AON_NIC_RATE */
-#define TEGRA186_CLK_AON_NIC 450
-/** @brief output of divider CLK_RST_CONTROLLER_SCE_NIC_RATE */
-#define TEGRA186_CLK_SCE_NIC 451
-/** Fixed 100MHz PLL for PCIe, SATA and superspeed USB */
-#define TEGRA186_CLK_PLLE 512
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC_BASE */
-#define TEGRA186_CLK_PLLC 513
-/** Fixed 408MHz PLL for use by peripheral clocks */
-#define TEGRA186_CLK_PLLP 516
-/** @deprecated */
-#define TEGRA186_CLK_PLL_P TEGRA186_CLK_PLLP
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLD_BASE for use by DSI */
-#define TEGRA186_CLK_PLLD 518
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLD2_BASE for use by HDMI or DP */
-#define TEGRA186_CLK_PLLD2 519
-/**
- * @brief PLL controlled by CLK_RST_CONTROLLER_PLLREFE_BASE.
- * @details Note that this clock only controls the VCO output, before
- * the post-divider. See TEGRA186_CLK_PLLREFE_OUT1 for more
- * information.
- */
-#define TEGRA186_CLK_PLLREFE_VCO 520
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC2_BASE */
-#define TEGRA186_CLK_PLLC2 521
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC3_BASE */
-#define TEGRA186_CLK_PLLC3 522
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLDP_BASE for use as the DP link clock */
-#define TEGRA186_CLK_PLLDP 523
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC4_BASE */
-#define TEGRA186_CLK_PLLC4_VCO 524
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLA1_BASE for use by audio clocks */
-#define TEGRA186_CLK_PLLA1 525
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLNVCSI_BASE */
-#define TEGRA186_CLK_PLLNVCSI 526
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLDISPHUB_BASE */
-#define TEGRA186_CLK_PLLDISPHUB 527
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLD3_BASE for use by HDMI or DP */
-#define TEGRA186_CLK_PLLD3 528
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLBPMPCAM_BASE */
-#define TEGRA186_CLK_PLLBPMPCAM 531
-/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLAON_BASE for use by IP blocks in the AON domain */
-#define TEGRA186_CLK_PLLAON 532
-/** Fixed frequency 960MHz PLL for USB and EAVB */
-#define TEGRA186_CLK_PLLU 533
-/** fixed /2 divider. Output frequency is TEGRA186_CLK_PLLC4_VCO/2 */
-#define TEGRA186_CLK_PLLC4_VCO_DIV2 535
-/** @brief NAFLL clock source for AXI_CBB */
-#define TEGRA186_CLK_NAFLL_AXI_CBB 564
-/** @brief NAFLL clock source for BPMP */
-#define TEGRA186_CLK_NAFLL_BPMP 565
-/** @brief NAFLL clock source for ISP */
-#define TEGRA186_CLK_NAFLL_ISP 566
-/** @brief NAFLL clock source for NVDEC */
-#define TEGRA186_CLK_NAFLL_NVDEC 567
-/** @brief NAFLL clock source for NVENC */
-#define TEGRA186_CLK_NAFLL_NVENC 568
-/** @brief NAFLL clock source for NVJPG */
-#define TEGRA186_CLK_NAFLL_NVJPG 569
-/** @brief NAFLL clock source for SCE */
-#define TEGRA186_CLK_NAFLL_SCE 570
-/** @brief NAFLL clock source for SE */
-#define TEGRA186_CLK_NAFLL_SE 571
-/** @brief NAFLL clock source for TSEC */
-#define TEGRA186_CLK_NAFLL_TSEC 572
-/** @brief NAFLL clock source for TSECB */
-#define TEGRA186_CLK_NAFLL_TSECB 573
-/** @brief NAFLL clock source for VI */
-#define TEGRA186_CLK_NAFLL_VI 574
-/** @brief NAFLL clock source for VIC */
-#define TEGRA186_CLK_NAFLL_VIC 575
-/** @brief NAFLL clock source for DISP */
-#define TEGRA186_CLK_NAFLL_DISP 576
-/** @brief NAFLL clock source for GPU */
-#define TEGRA186_CLK_NAFLL_GPU 577
-/** @brief NAFLL clock source for M-CPU cluster */
-#define TEGRA186_CLK_NAFLL_MCPU 578
-/** @brief NAFLL clock source for B-CPU cluster */
-#define TEGRA186_CLK_NAFLL_BCPU 579
-/** @brief input from Tegra's CLK_32K_IN pad */
-#define TEGRA186_CLK_CLK_32K 608
-/** @brief output of divider CLK_RST_CONTROLLER_CLK_M_DIVIDE */
-#define TEGRA186_CLK_CLK_M 609
-/** @brief output of divider PLL_REF_DIV in CLK_RST_CONTROLLER_OSC_CTRL */
-#define TEGRA186_CLK_PLL_REF 610
-/** @brief input from Tegra's XTAL_IN */
-#define TEGRA186_CLK_OSC 612
-/** @brief clock recovered from EAVB input */
-#define TEGRA186_CLK_EQOS_RX_INPUT 613
-/** @brief clock recovered from DTV input */
-#define TEGRA186_CLK_DTV_INPUT 614
-/** @brief SOR0 brick output which feeds into SOR0_CLK_SEL mux in CLK_RST_CONTROLLER_CLK_SOURCE_SOR0*/
-#define TEGRA186_CLK_SOR0_PAD_CLKOUT 615
-/** @brief SOR1 brick output which feeds into SOR1_CLK_SEL mux in CLK_RST_CONTROLLER_CLK_SOURCE_SOR1*/
-#define TEGRA186_CLK_SOR1_PAD_CLKOUT 616
-/** @brief clock recovered from I2S1 input */
-#define TEGRA186_CLK_I2S1_SYNC_INPUT 617
-/** @brief clock recovered from I2S2 input */
-#define TEGRA186_CLK_I2S2_SYNC_INPUT 618
-/** @brief clock recovered from I2S3 input */
-#define TEGRA186_CLK_I2S3_SYNC_INPUT 619
-/** @brief clock recovered from I2S4 input */
-#define TEGRA186_CLK_I2S4_SYNC_INPUT 620
-/** @brief clock recovered from I2S5 input */
-#define TEGRA186_CLK_I2S5_SYNC_INPUT 621
-/** @brief clock recovered from I2S6 input */
-#define TEGRA186_CLK_I2S6_SYNC_INPUT 622
-/** @brief clock recovered from SPDIFIN input */
-#define TEGRA186_CLK_SPDIFIN_SYNC_INPUT 623
-
-/**
- * @brief subject to change
- * @details maximum clock identifier value plus one.
- */
-#define TEGRA186_CLK_CLK_MAX 624
-
-/** @} */
-
-#endif
diff --git a/include/dt-bindings/dma/at91.h b/include/dt-bindings/dma/at91.h
deleted file mode 100644
index 0e7814b0dce9..000000000000
--- a/include/dt-bindings/dma/at91.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * This header provides macros for at91 dma bindings.
- *
- * Copyright (C) 2013 Ludovic Desroches <ludovic.desroches@atmel.com>
- *
- * GPLv2 only
- */
-
-#ifndef __DT_BINDINGS_AT91_DMA_H__
-#define __DT_BINDINGS_AT91_DMA_H__
-
-/* ---------- HDMAC ---------- */
-
-/*
- * Source and/or destination peripheral ID
- */
-#define AT91_DMA_CFG_PER_ID_MASK	(0xff)
-#define AT91_DMA_CFG_PER_ID(id)		(id & AT91_DMA_CFG_PER_ID_MASK)
-
-/*
- * FIFO configuration: it defines when a request is serviced.
- */
-#define AT91_DMA_CFG_FIFOCFG_OFFSET	(8)
-#define AT91_DMA_CFG_FIFOCFG_MASK	(0xf << AT91_DMA_CFG_FIFOCFG_OFFSET)
-#define AT91_DMA_CFG_FIFOCFG_HALF	(0x0 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* half FIFO (default behavior) */
-#define AT91_DMA_CFG_FIFOCFG_ALAP	(0x1 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* largest defined AHB burst */
-#define AT91_DMA_CFG_FIFOCFG_ASAP	(0x2 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* single AHB access */
-
-/* ---------- XDMAC ---------- */
-#define AT91_XDMAC_DT_MEM_IF_MASK	(0x1)
-#define AT91_XDMAC_DT_MEM_IF_OFFSET	(13)
-#define AT91_XDMAC_DT_MEM_IF(mem_if)	(((mem_if) & AT91_XDMAC_DT_MEM_IF_MASK) \
-					<< AT91_XDMAC_DT_MEM_IF_OFFSET)
-#define AT91_XDMAC_DT_GET_MEM_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_MEM_IF_OFFSET) \
-					& AT91_XDMAC_DT_MEM_IF_MASK)
-
-#define AT91_XDMAC_DT_PER_IF_MASK	(0x1)
-#define AT91_XDMAC_DT_PER_IF_OFFSET	(14)
-#define AT91_XDMAC_DT_PER_IF(per_if)	(((per_if) & AT91_XDMAC_DT_PER_IF_MASK) \
-					<< AT91_XDMAC_DT_PER_IF_OFFSET)
-#define AT91_XDMAC_DT_GET_PER_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_PER_IF_OFFSET) \
-					& AT91_XDMAC_DT_PER_IF_MASK)
-
-#define AT91_XDMAC_DT_PERID_MASK	(0x7f)
-#define AT91_XDMAC_DT_PERID_OFFSET	(24)
-#define AT91_XDMAC_DT_PERID(perid)	(((perid) & AT91_XDMAC_DT_PERID_MASK) \
-					<< AT91_XDMAC_DT_PERID_OFFSET)
-#define AT91_XDMAC_DT_GET_PERID(cfg)	(((cfg) >> AT91_XDMAC_DT_PERID_OFFSET) \
-					& AT91_XDMAC_DT_PERID_MASK)
-
-#endif /* __DT_BINDINGS_AT91_DMA_H__ */
diff --git a/include/dt-bindings/gpio/aspeed-gpio.h b/include/dt-bindings/gpio/aspeed-gpio.h
deleted file mode 100644
index a49f5d5b5af0..000000000000
--- a/include/dt-bindings/gpio/aspeed-gpio.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2022 IBM Corp.
- *
- * This header provides constants for binding aspeed,*-gpio.
- *
- * The first cell in Aspeed's GPIO specifier is the GPIO ID. The macros below
- * provide names for this.
- *
- * The second cell contains standard flag values specified in gpio.h.
- */
-
-#ifndef _DT_BINDINGS_GPIO_ASPEED_GPIO_H
-#define _DT_BINDINGS_GPIO_ASPEED_GPIO_H
-
-#include <dt-bindings/gpio/gpio.h>
-
-#define ASPEED_GPIO_PORT_A 0
-#define ASPEED_GPIO_PORT_B 1
-#define ASPEED_GPIO_PORT_C 2
-#define ASPEED_GPIO_PORT_D 3
-#define ASPEED_GPIO_PORT_E 4
-#define ASPEED_GPIO_PORT_F 5
-#define ASPEED_GPIO_PORT_G 6
-#define ASPEED_GPIO_PORT_H 7
-#define ASPEED_GPIO_PORT_I 8
-#define ASPEED_GPIO_PORT_J 9
-#define ASPEED_GPIO_PORT_K 10
-#define ASPEED_GPIO_PORT_L 11
-#define ASPEED_GPIO_PORT_M 12
-#define ASPEED_GPIO_PORT_N 13
-#define ASPEED_GPIO_PORT_O 14
-#define ASPEED_GPIO_PORT_P 15
-#define ASPEED_GPIO_PORT_Q 16
-#define ASPEED_GPIO_PORT_R 17
-#define ASPEED_GPIO_PORT_S 18
-#define ASPEED_GPIO_PORT_T 19
-#define ASPEED_GPIO_PORT_U 20
-#define ASPEED_GPIO_PORT_V 21
-#define ASPEED_GPIO_PORT_W 22
-#define ASPEED_GPIO_PORT_X 23
-#define ASPEED_GPIO_PORT_Y 24
-#define ASPEED_GPIO_PORT_Z 25
-#define ASPEED_GPIO_PORT_AA 26
-#define ASPEED_GPIO_PORT_AB 27
-#define ASPEED_GPIO_PORT_AC 28
-
-#define ASPEED_GPIO(port, offset) \
-	((ASPEED_GPIO_PORT_##port * 8) + (offset))
-
-#endif
diff --git a/include/dt-bindings/gpio/tegra-gpio.h b/include/dt-bindings/gpio/tegra-gpio.h
deleted file mode 100644
index a1c09e88e80b..000000000000
--- a/include/dt-bindings/gpio/tegra-gpio.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * This header provides constants for binding nvidia,tegra*-gpio.
- *
- * The first cell in Tegra's GPIO specifier is the GPIO ID. The macros below
- * provide names for this.
- *
- * The second cell contains standard flag values specified in gpio.h.
- */
-
-#ifndef _DT_BINDINGS_GPIO_TEGRA_GPIO_H
-#define _DT_BINDINGS_GPIO_TEGRA_GPIO_H
-
-#include <dt-bindings/gpio/gpio.h>
-
-#define TEGRA_GPIO_PORT_A 0
-#define TEGRA_GPIO_PORT_B 1
-#define TEGRA_GPIO_PORT_C 2
-#define TEGRA_GPIO_PORT_D 3
-#define TEGRA_GPIO_PORT_E 4
-#define TEGRA_GPIO_PORT_F 5
-#define TEGRA_GPIO_PORT_G 6
-#define TEGRA_GPIO_PORT_H 7
-#define TEGRA_GPIO_PORT_I 8
-#define TEGRA_GPIO_PORT_J 9
-#define TEGRA_GPIO_PORT_K 10
-#define TEGRA_GPIO_PORT_L 11
-#define TEGRA_GPIO_PORT_M 12
-#define TEGRA_GPIO_PORT_N 13
-#define TEGRA_GPIO_PORT_O 14
-#define TEGRA_GPIO_PORT_P 15
-#define TEGRA_GPIO_PORT_Q 16
-#define TEGRA_GPIO_PORT_R 17
-#define TEGRA_GPIO_PORT_S 18
-#define TEGRA_GPIO_PORT_T 19
-#define TEGRA_GPIO_PORT_U 20
-#define TEGRA_GPIO_PORT_V 21
-#define TEGRA_GPIO_PORT_W 22
-#define TEGRA_GPIO_PORT_X 23
-#define TEGRA_GPIO_PORT_Y 24
-#define TEGRA_GPIO_PORT_Z 25
-#define TEGRA_GPIO_PORT_AA 26
-#define TEGRA_GPIO_PORT_BB 27
-#define TEGRA_GPIO_PORT_CC 28
-#define TEGRA_GPIO_PORT_DD 29
-#define TEGRA_GPIO_PORT_EE 30
-#define TEGRA_GPIO_PORT_FF 31
-
-#define TEGRA_GPIO(port, offset) \
-	((TEGRA_GPIO_PORT_##port * 8) + offset)
-
-#endif
diff --git a/include/dt-bindings/media/omap3-isp.h b/include/dt-bindings/media/omap3-isp.h
deleted file mode 100644
index 4e4208462142..000000000000
--- a/include/dt-bindings/media/omap3-isp.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * include/dt-bindings/media/omap3-isp.h
- *
- * Copyright (C) 2015 Sakari Ailus
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-#ifndef __DT_BINDINGS_OMAP3_ISP_H__
-#define __DT_BINDINGS_OMAP3_ISP_H__
-
-#define OMAP3ISP_PHY_TYPE_COMPLEX_IO   0
-#define OMAP3ISP_PHY_TYPE_CSIPHY       1
-
-#endif /* __DT_BINDINGS_OMAP3_ISP_H__ */
diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
deleted file mode 100644
index 321cd08797d9..000000000000
--- a/include/dt-bindings/mfd/st,stpmic1.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
- * Author: Philippe Peurichard <philippe.peurichard@st.com>,
- * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
- */
-
-#ifndef __DT_BINDINGS_STPMIC1_H__
-#define __DT_BINDINGS_STPMIC1_H__
-
-/* IRQ definitions */
-#define IT_PONKEY_F	0
-#define IT_PONKEY_R	1
-#define IT_WAKEUP_F	2
-#define IT_WAKEUP_R	3
-#define IT_VBUS_OTG_F	4
-#define IT_VBUS_OTG_R	5
-#define IT_SWOUT_F	6
-#define IT_SWOUT_R	7
-
-#define IT_CURLIM_BUCK1	8
-#define IT_CURLIM_BUCK2	9
-#define IT_CURLIM_BUCK3	10
-#define IT_CURLIM_BUCK4	11
-#define IT_OCP_OTG	12
-#define IT_OCP_SWOUT	13
-#define IT_OCP_BOOST	14
-#define IT_OVP_BOOST	15
-
-#define IT_CURLIM_LDO1	16
-#define IT_CURLIM_LDO2	17
-#define IT_CURLIM_LDO3	18
-#define IT_CURLIM_LDO4	19
-#define IT_CURLIM_LDO5	20
-#define IT_CURLIM_LDO6	21
-#define IT_SHORT_SWOTG	22
-#define IT_SHORT_SWOUT	23
-
-#define IT_TWARN_F	24
-#define IT_TWARN_R	25
-#define IT_VINLOW_F	26
-#define IT_VINLOW_R	27
-#define IT_SWIN_F	30
-#define IT_SWIN_R	31
-
-/* BUCK MODES definitions */
-#define STPMIC1_BUCK_MODE_NORMAL 0
-#define STPMIC1_BUCK_MODE_LP 2
-
-#endif /* __DT_BINDINGS_STPMIC1_H__ */
diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
deleted file mode 100644
index 6fc4b445d3a1..000000000000
--- a/include/dt-bindings/net/ti-dp83867.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Device Tree constants for the Texas Instruments DP83867 PHY
- *
- * Author: Dan Murphy <dmurphy@ti.com>
- *
- * Copyright:   (C) 2015 Texas Instruments, Inc.
- */
-
-#ifndef _DT_BINDINGS_TI_DP83867_H
-#define _DT_BINDINGS_TI_DP83867_H
-
-/* PHY CTRL bits */
-#define DP83867_PHYCR_FIFO_DEPTH_3_B_NIB	0x00
-#define DP83867_PHYCR_FIFO_DEPTH_4_B_NIB	0x01
-#define DP83867_PHYCR_FIFO_DEPTH_6_B_NIB	0x02
-#define DP83867_PHYCR_FIFO_DEPTH_8_B_NIB	0x03
-
-/* RGMIIDCTL internal delay for rx and tx */
-#define	DP83867_RGMIIDCTL_250_PS	0x0
-#define	DP83867_RGMIIDCTL_500_PS	0x1
-#define	DP83867_RGMIIDCTL_750_PS	0x2
-#define	DP83867_RGMIIDCTL_1_NS		0x3
-#define	DP83867_RGMIIDCTL_1_25_NS	0x4
-#define	DP83867_RGMIIDCTL_1_50_NS	0x5
-#define	DP83867_RGMIIDCTL_1_75_NS	0x6
-#define	DP83867_RGMIIDCTL_2_00_NS	0x7
-#define	DP83867_RGMIIDCTL_2_25_NS	0x8
-#define	DP83867_RGMIIDCTL_2_50_NS	0x9
-#define	DP83867_RGMIIDCTL_2_75_NS	0xa
-#define	DP83867_RGMIIDCTL_3_00_NS	0xb
-#define	DP83867_RGMIIDCTL_3_25_NS	0xc
-#define	DP83867_RGMIIDCTL_3_50_NS	0xd
-#define	DP83867_RGMIIDCTL_3_75_NS	0xe
-#define	DP83867_RGMIIDCTL_4_00_NS	0xf
-
-/* IO_MUX_CFG - Clock output selection */
-#define DP83867_CLK_O_SEL_CHN_A_RCLK		0x0
-#define DP83867_CLK_O_SEL_CHN_B_RCLK		0x1
-#define DP83867_CLK_O_SEL_CHN_C_RCLK		0x2
-#define DP83867_CLK_O_SEL_CHN_D_RCLK		0x3
-#define DP83867_CLK_O_SEL_CHN_A_RCLK_DIV5	0x4
-#define DP83867_CLK_O_SEL_CHN_B_RCLK_DIV5	0x5
-#define DP83867_CLK_O_SEL_CHN_C_RCLK_DIV5	0x6
-#define DP83867_CLK_O_SEL_CHN_D_RCLK_DIV5	0x7
-#define DP83867_CLK_O_SEL_CHN_A_TCLK		0x8
-#define DP83867_CLK_O_SEL_CHN_B_TCLK		0x9
-#define DP83867_CLK_O_SEL_CHN_C_TCLK		0xA
-#define DP83867_CLK_O_SEL_CHN_D_TCLK		0xB
-#define DP83867_CLK_O_SEL_REF_CLK		0xC
-/* Special flag to indicate clock should be off */
-#define DP83867_CLK_O_SEL_OFF			0xFFFFFFFF
-#endif
diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
deleted file mode 100644
index 765c385f7b2c..000000000000
--- a/include/dt-bindings/pinctrl/dra.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * This header provides constants for DRA pinctrl bindings.
- *
- * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- * Author: Rajendra Nayak <rnayak@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_DRA_H
-#define _DT_BINDINGS_PINCTRL_DRA_H
-
-/* DRA7 mux mode options for each pin. See TRM for options */
-#define MUX_MODE0	0x0
-#define MUX_MODE1	0x1
-#define MUX_MODE2	0x2
-#define MUX_MODE3	0x3
-#define MUX_MODE4	0x4
-#define MUX_MODE5	0x5
-#define MUX_MODE6	0x6
-#define MUX_MODE7	0x7
-#define MUX_MODE8	0x8
-#define MUX_MODE9	0x9
-#define MUX_MODE10	0xa
-#define MUX_MODE11	0xb
-#define MUX_MODE12	0xc
-#define MUX_MODE13	0xd
-#define MUX_MODE14	0xe
-#define MUX_MODE15	0xf
-
-/* Certain pins need virtual mode, but note: they may glitch */
-#define MUX_VIRTUAL_MODE0	(MODE_SELECT | (0x0 << 4))
-#define MUX_VIRTUAL_MODE1	(MODE_SELECT | (0x1 << 4))
-#define MUX_VIRTUAL_MODE2	(MODE_SELECT | (0x2 << 4))
-#define MUX_VIRTUAL_MODE3	(MODE_SELECT | (0x3 << 4))
-#define MUX_VIRTUAL_MODE4	(MODE_SELECT | (0x4 << 4))
-#define MUX_VIRTUAL_MODE5	(MODE_SELECT | (0x5 << 4))
-#define MUX_VIRTUAL_MODE6	(MODE_SELECT | (0x6 << 4))
-#define MUX_VIRTUAL_MODE7	(MODE_SELECT | (0x7 << 4))
-#define MUX_VIRTUAL_MODE8	(MODE_SELECT | (0x8 << 4))
-#define MUX_VIRTUAL_MODE9	(MODE_SELECT | (0x9 << 4))
-#define MUX_VIRTUAL_MODE10	(MODE_SELECT | (0xa << 4))
-#define MUX_VIRTUAL_MODE11	(MODE_SELECT | (0xb << 4))
-#define MUX_VIRTUAL_MODE12	(MODE_SELECT | (0xc << 4))
-#define MUX_VIRTUAL_MODE13	(MODE_SELECT | (0xd << 4))
-#define MUX_VIRTUAL_MODE14	(MODE_SELECT | (0xe << 4))
-#define MUX_VIRTUAL_MODE15	(MODE_SELECT | (0xf << 4))
-
-#define MODE_SELECT		(1 << 8)
-
-#define PULL_ENA		(0 << 16)
-#define PULL_DIS		(1 << 16)
-#define PULL_UP			(1 << 17)
-#define INPUT_EN		(1 << 18)
-#define SLEWCONTROL		(1 << 19)
-#define WAKEUP_EN		(1 << 24)
-#define WAKEUP_EVENT		(1 << 25)
-
-/* Active pin states */
-#define PIN_OUTPUT		(0 | PULL_DIS)
-#define PIN_OUTPUT_PULLUP	(PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(0)
-#define PIN_INPUT		(INPUT_EN | PULL_DIS)
-#define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
-#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
-
-/*
- * Macro to allow using the absolute physical address instead of the
- * padconf registers instead of the offset from padconf base.
- */
-#define DRA7XX_CORE_IOPAD(pa, val)	(((pa) & 0xffff) - 0x3400) (val)
-
-/* DRA7 IODELAY configuration parameters */
-#define A_DELAY_PS(val)			((val) & 0xffff)
-#define G_DELAY_PS(val)			((val) & 0xffff)
-#endif
diff --git a/include/dt-bindings/pinctrl/hisi.h b/include/dt-bindings/pinctrl/hisi.h
deleted file mode 100644
index 0359bfdc9119..000000000000
--- a/include/dt-bindings/pinctrl/hisi.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * This header provides constants for hisilicon pinctrl bindings.
- *
- * Copyright (c) 2015 Hisilicon Limited.
- * Copyright (c) 2015 Linaro Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_HISI_H
-#define _DT_BINDINGS_PINCTRL_HISI_H
-
-/* iomg bit definition */
-#define MUX_M0		0
-#define MUX_M1		1
-#define MUX_M2		2
-#define MUX_M3		3
-#define MUX_M4		4
-#define MUX_M5		5
-#define MUX_M6		6
-#define MUX_M7		7
-
-/* iocg bit definition */
-#define PULL_MASK	(3)
-#define PULL_DIS	(0)
-#define PULL_UP		(1 << 0)
-#define PULL_DOWN	(1 << 1)
-
-/* drive strength definition */
-#define DRIVE_MASK	(7 << 4)
-#define DRIVE1_02MA	(0 << 4)
-#define DRIVE1_04MA	(1 << 4)
-#define DRIVE1_08MA	(2 << 4)
-#define DRIVE1_10MA	(3 << 4)
-#define DRIVE2_02MA	(0 << 4)
-#define DRIVE2_04MA	(1 << 4)
-#define DRIVE2_08MA	(2 << 4)
-#define DRIVE2_10MA	(3 << 4)
-#define DRIVE3_04MA	(0 << 4)
-#define DRIVE3_08MA	(1 << 4)
-#define DRIVE3_12MA	(2 << 4)
-#define DRIVE3_16MA	(3 << 4)
-#define DRIVE3_20MA	(4 << 4)
-#define DRIVE3_24MA	(5 << 4)
-#define DRIVE3_32MA	(6 << 4)
-#define DRIVE3_40MA	(7 << 4)
-#define DRIVE4_02MA	(0 << 4)
-#define DRIVE4_04MA	(2 << 4)
-#define DRIVE4_08MA	(4 << 4)
-#define DRIVE4_10MA	(6 << 4)
-
-/* drive strength definition for hi3660 */
-#define DRIVE6_MASK	(15 << 4)
-#define DRIVE6_04MA	(0 << 4)
-#define DRIVE6_12MA	(4 << 4)
-#define DRIVE6_19MA	(8 << 4)
-#define DRIVE6_27MA	(10 << 4)
-#define DRIVE6_32MA	(15 << 4)
-#define DRIVE7_02MA	(0 << 4)
-#define DRIVE7_04MA	(1 << 4)
-#define DRIVE7_06MA	(2 << 4)
-#define DRIVE7_08MA	(3 << 4)
-#define DRIVE7_10MA	(4 << 4)
-#define DRIVE7_12MA	(5 << 4)
-#define DRIVE7_14MA	(6 << 4)
-#define DRIVE7_16MA	(7 << 4)
-#endif
diff --git a/include/dt-bindings/pinctrl/mt65xx.h b/include/dt-bindings/pinctrl/mt65xx.h
deleted file mode 100644
index fbea8d35bcf1..000000000000
--- a/include/dt-bindings/pinctrl/mt65xx.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2022 MediaTek Inc.
- * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_MT65XX_H
-#define _DT_BINDINGS_PINCTRL_MT65XX_H
-
-#define MTK_PIN_NO(x)		((x) << 8)
-#define MTK_GET_PIN_NO(x)	((x) >> 8)
-#define MTK_GET_PIN_FUNC(x)	((x) & 0xf)
-
-#define MTK_PUPD_SET_R1R0_00	100
-#define MTK_PUPD_SET_R1R0_01	101
-#define MTK_PUPD_SET_R1R0_10	102
-#define MTK_PUPD_SET_R1R0_11	103
-
-#define MTK_PULL_SET_RSEL_000	200
-#define MTK_PULL_SET_RSEL_001	201
-#define MTK_PULL_SET_RSEL_010	202
-#define MTK_PULL_SET_RSEL_011	203
-#define MTK_PULL_SET_RSEL_100	204
-#define MTK_PULL_SET_RSEL_101	205
-#define MTK_PULL_SET_RSEL_110	206
-#define MTK_PULL_SET_RSEL_111	207
-
-#define MTK_DRIVE_2mA		2
-#define MTK_DRIVE_4mA		4
-#define MTK_DRIVE_6mA		6
-#define MTK_DRIVE_8mA		8
-#define MTK_DRIVE_10mA		10
-#define MTK_DRIVE_12mA		12
-#define MTK_DRIVE_14mA		14
-#define MTK_DRIVE_16mA		16
-#define MTK_DRIVE_20mA		20
-#define MTK_DRIVE_24mA		24
-#define MTK_DRIVE_28mA		28
-#define MTK_DRIVE_32mA		32
-
-#endif /* _DT_BINDINGS_PINCTRL_MT65XX_H */
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
deleted file mode 100644
index 4c060ee0e0ad..000000000000
--- a/include/dt-bindings/pinctrl/omap.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for OMAP pinctrl bindings.
- *
- * Copyright (C) 2009 Nokia
- * Copyright (C) 2009-2010 Texas Instruments
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_OMAP_H
-#define _DT_BINDINGS_PINCTRL_OMAP_H
-
-/* 34xx mux mode options for each pin. See TRM for options */
-#define MUX_MODE0	0
-#define MUX_MODE1	1
-#define MUX_MODE2	2
-#define MUX_MODE3	3
-#define MUX_MODE4	4
-#define MUX_MODE5	5
-#define MUX_MODE6	6
-#define MUX_MODE7	7
-
-/* 24xx/34xx mux bit defines */
-#define PULL_ENA		(1 << 3)
-#define PULL_UP			(1 << 4)
-#define ALTELECTRICALSEL	(1 << 5)
-
-/* omap3/4/5 specific mux bit defines */
-#define INPUT_EN		(1 << 8)
-#define OFF_EN			(1 << 9)
-#define OFFOUT_EN		(1 << 10)
-#define OFFOUT_VAL		(1 << 11)
-#define OFF_PULL_EN		(1 << 12)
-#define OFF_PULL_UP		(1 << 13)
-#define WAKEUP_EN		(1 << 14)
-#define WAKEUP_EVENT		(1 << 15)
-
-/* Active pin states */
-#define PIN_OUTPUT		0
-#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
-#define PIN_INPUT		INPUT_EN
-#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
-
-/* Off mode states */
-#define PIN_OFF_NONE		0
-#define PIN_OFF_OUTPUT_HIGH	(OFF_EN | OFFOUT_EN | OFFOUT_VAL)
-#define PIN_OFF_OUTPUT_LOW	(OFF_EN | OFFOUT_EN)
-#define PIN_OFF_INPUT_PULLUP	(OFF_EN | OFFOUT_EN | OFF_PULL_EN | OFF_PULL_UP)
-#define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFFOUT_EN | OFF_PULL_EN)
-#define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
-
-/*
- * Macros to allow using the absolute physical address instead of the
- * padconf registers instead of the offset from padconf base.
- */
-#define OMAP_IOPAD_OFFSET(pa, offset)	(((pa) & 0xffff) - (offset))
-
-#define OMAP2420_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0030) (val)
-#define OMAP2430_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
-#define OMAP3_CORE1_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
-#define OMAP3430_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25d8) (val)
-#define OMAP3630_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25a0) (val)
-#define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
-#define DM814X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define DM816X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val) (0)
-#define AM33XX_PADCONF(pa, conf, mux)	OMAP_IOPAD_OFFSET((pa), 0x0800) (conf) (mux)
-
-/*
- * Macros to allow using the offset from the padconf physical address
- * instead  of the offset from padconf base.
- */
-#define OMAP_PADCONF_OFFSET(offset, base_offset)	((offset) - (base_offset))
-
-#define OMAP4_IOPAD(offset, val)	OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
-#define OMAP5_IOPAD(offset, val)	OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
-
-/*
- * Define some commonly used pins configured by the boards.
- * Note that some boards use alternative pins, so check
- * the schematics before using these.
- */
-#define OMAP3_UART1_RX		0x152
-#define OMAP3_UART2_RX		0x14a
-#define OMAP3_UART3_RX		0x16e
-#define OMAP4_UART2_RX		0xdc
-#define OMAP4_UART3_RX		0x104
-#define OMAP4_UART4_RX		0x11c
-
-#endif
diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h b/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h
deleted file mode 100644
index 914d56da9324..000000000000
--- a/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _DT_BINDINGS_PINCTRL_TEGRA_XUSB_H
-#define _DT_BINDINGS_PINCTRL_TEGRA_XUSB_H 1
-
-#define TEGRA_XUSB_PADCTL_PCIE 0
-#define TEGRA_XUSB_PADCTL_SATA 1
-
-#endif /* _DT_BINDINGS_PINCTRL_TEGRA_XUSB_H */
diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h
deleted file mode 100644
index c9b57408de68..000000000000
--- a/include/dt-bindings/pinctrl/pinctrl-tegra.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for Tegra pinctrl bindings.
- *
- * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Author: Laxman Dewangan <ldewangan@nvidia.com>
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_TEGRA_H
-#define _DT_BINDINGS_PINCTRL_TEGRA_H
-
-/*
- * Enable/disable for diffeent dt properties. This is applicable for
- * properties nvidia,enable-input, nvidia,tristate, nvidia,open-drain,
- * nvidia,lock, nvidia,rcv-sel, nvidia,high-speed-mode, nvidia,schmitt.
- */
-#define TEGRA_PIN_DISABLE				0
-#define TEGRA_PIN_ENABLE				1
-
-#define TEGRA_PIN_PULL_NONE				0
-#define TEGRA_PIN_PULL_DOWN				1
-#define TEGRA_PIN_PULL_UP				2
-
-/* Low power mode driver */
-#define TEGRA_PIN_LP_DRIVE_DIV_8			0
-#define TEGRA_PIN_LP_DRIVE_DIV_4			1
-#define TEGRA_PIN_LP_DRIVE_DIV_2			2
-#define TEGRA_PIN_LP_DRIVE_DIV_1			3
-
-/* Rising/Falling slew rate */
-#define TEGRA_PIN_SLEW_RATE_FASTEST			0
-#define TEGRA_PIN_SLEW_RATE_FAST			1
-#define TEGRA_PIN_SLEW_RATE_SLOW			2
-#define TEGRA_PIN_SLEW_RATE_SLOWEST			3
-
-#endif
diff --git a/include/dt-bindings/pinctrl/r7s72100-pinctrl.h b/include/dt-bindings/pinctrl/r7s72100-pinctrl.h
deleted file mode 100644
index 31ee37610eb2..000000000000
--- a/include/dt-bindings/pinctrl/r7s72100-pinctrl.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Defines macros and constants for Renesas RZ/A1 pin controller pin
- * muxing functions.
- */
-#ifndef __DT_BINDINGS_PINCTRL_RENESAS_RZA1_H
-#define __DT_BINDINGS_PINCTRL_RENESAS_RZA1_H
-
-#define RZA1_PINS_PER_PORT	16
-
-/*
- * Create the pin index from its bank and position numbers and store in
- * the upper 16 bits the alternate function identifier
- */
-#define RZA1_PINMUX(b, p, f)	\
-	((b) * RZA1_PINS_PER_PORT + (p) | ((f) << 16))
-
-#endif /* __DT_BINDINGS_PINCTRL_RENESAS_RZA1_H */
diff --git a/include/dt-bindings/power/raspberrypi-power.h b/include/dt-bindings/power/raspberrypi-power.h
deleted file mode 100644
index b3ff8e09a78f..000000000000
--- a/include/dt-bindings/power/raspberrypi-power.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *  Copyright © 2015 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
-#define _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
-
-/* These power domain indices are the firmware interface's indices
- * minus one.
- */
-#define RPI_POWER_DOMAIN_I2C0		0
-#define RPI_POWER_DOMAIN_I2C1		1
-#define RPI_POWER_DOMAIN_I2C2		2
-#define RPI_POWER_DOMAIN_VIDEO_SCALER	3
-#define RPI_POWER_DOMAIN_VPU1		4
-#define RPI_POWER_DOMAIN_HDMI		5
-#define RPI_POWER_DOMAIN_USB		6
-#define RPI_POWER_DOMAIN_VEC		7
-#define RPI_POWER_DOMAIN_JPEG		8
-#define RPI_POWER_DOMAIN_H264		9
-#define RPI_POWER_DOMAIN_V3D		10
-#define RPI_POWER_DOMAIN_ISP		11
-#define RPI_POWER_DOMAIN_UNICAM0	12
-#define RPI_POWER_DOMAIN_UNICAM1	13
-#define RPI_POWER_DOMAIN_CCP2RX		14
-#define RPI_POWER_DOMAIN_CSI2		15
-#define RPI_POWER_DOMAIN_CPI		16
-#define RPI_POWER_DOMAIN_DSI0		17
-#define RPI_POWER_DOMAIN_DSI1		18
-#define RPI_POWER_DOMAIN_TRANSPOSER	19
-#define RPI_POWER_DOMAIN_CCP2TX		20
-#define RPI_POWER_DOMAIN_CDP		21
-#define RPI_POWER_DOMAIN_ARM		22
-
-#define RPI_POWER_DOMAIN_COUNT		23
-
-#endif /* _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H */
diff --git a/include/dt-bindings/power/tegra186-powergate.h b/include/dt-bindings/power/tegra186-powergate.h
deleted file mode 100644
index 17e75498563c..000000000000
--- a/include/dt-bindings/power/tegra186-powergate.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2015-2016, NVIDIA CORPORATION.
- */
-
-#ifndef _DT_BINDINGS_POWER_TEGRA186_POWERGATE_H
-#define _DT_BINDINGS_POWER_TEGRA186_POWERGATE_H
-
-#define TEGRA186_POWER_DOMAIN_AUD	0
-#define TEGRA186_POWER_DOMAIN_DFD	1
-#define TEGRA186_POWER_DOMAIN_DISP	2
-#define TEGRA186_POWER_DOMAIN_DISPB	3
-#define TEGRA186_POWER_DOMAIN_DISPC	4
-#define TEGRA186_POWER_DOMAIN_ISPA	5
-#define TEGRA186_POWER_DOMAIN_NVDEC	6
-#define TEGRA186_POWER_DOMAIN_NVJPG	7
-#define TEGRA186_POWER_DOMAIN_MPE	8
-#define TEGRA186_POWER_DOMAIN_PCX	9
-#define TEGRA186_POWER_DOMAIN_SAX	10
-#define TEGRA186_POWER_DOMAIN_VE	11
-#define TEGRA186_POWER_DOMAIN_VIC	12
-#define TEGRA186_POWER_DOMAIN_XUSBA	13
-#define TEGRA186_POWER_DOMAIN_XUSBB	14
-#define TEGRA186_POWER_DOMAIN_XUSBC	15
-#define TEGRA186_POWER_DOMAIN_GPU	43
-#define TEGRA186_POWER_DOMAIN_MAX	44
-
-#endif
diff --git a/include/dt-bindings/regulator/maxim,max77802.h b/include/dt-bindings/regulator/maxim,max77802.h
deleted file mode 100644
index cf28631d7109..000000000000
--- a/include/dt-bindings/regulator/maxim,max77802.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 2014 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Device Tree binding constants for the Maxim 77802 PMIC regulators
- */
-
-#ifndef _DT_BINDINGS_REGULATOR_MAXIM_MAX77802_H
-#define _DT_BINDINGS_REGULATOR_MAXIM_MAX77802_H
-
-/* Regulator operating modes */
-#define MAX77802_OPMODE_LP	1
-#define MAX77802_OPMODE_NORMAL	3
-
-#endif /* _DT_BINDINGS_REGULATOR_MAXIM_MAX77802_H */
diff --git a/include/dt-bindings/reset/altr,rst-mgr-a10.h b/include/dt-bindings/reset/altr,rst-mgr-a10.h
deleted file mode 100644
index acb0bbf4f9f5..000000000000
--- a/include/dt-bindings/reset/altr,rst-mgr-a10.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * Copyright (c) 2014, Steffen Trumtrar <s.trumtrar@pengutronix.de>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_A10_H
-#define _DT_BINDINGS_RESET_ALTR_RST_MGR_A10_H
-
-/* MPUMODRST */
-#define CPU0_RESET		0
-#define CPU1_RESET		1
-#define WDS_RESET		2
-#define SCUPER_RESET		3
-
-/* PER0MODRST */
-#define EMAC0_RESET		32
-#define EMAC1_RESET		33
-#define EMAC2_RESET		34
-#define USB0_RESET		35
-#define USB1_RESET		36
-#define NAND_RESET		37
-#define QSPI_RESET		38
-#define SDMMC_RESET		39
-#define EMAC0_OCP_RESET		40
-#define EMAC1_OCP_RESET		41
-#define EMAC2_OCP_RESET		42
-#define USB0_OCP_RESET		43
-#define USB1_OCP_RESET		44
-#define NAND_OCP_RESET		45
-#define QSPI_OCP_RESET		46
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
-#define L4WD0_RESET		64
-#define L4WD1_RESET		65
-#define L4SYSTIMER0_RESET	66
-#define L4SYSTIMER1_RESET	67
-#define SPTIMER0_RESET		68
-#define SPTIMER1_RESET		69
-/* 70-71 is reserved */
-#define I2C0_RESET		72
-#define I2C1_RESET		73
-#define I2C2_RESET		74
-#define I2C3_RESET		75
-#define I2C4_RESET		76
-/* 77-79 is reserved */
-#define UART0_RESET		80
-#define UART1_RESET		81
-/* 82-87 is reserved */
-#define GPIO0_RESET		88
-#define GPIO1_RESET		89
-#define GPIO2_RESET		90
-
-/* BRGMODRST */
-#define HPS2FPGA_RESET		96
-#define LWHPS2FPGA_RESET	97
-#define FPGA2HPS_RESET		98
-#define F2SSDRAM0_RESET		99
-#define F2SSDRAM1_RESET		100
-#define F2SSDRAM2_RESET		101
-#define DDRSCH_RESET		102
-
-/* SYSMODRST*/
-#define ROM_RESET		128
-#define OCRAM_RESET		129
-/* 130 is reserved */
-#define FPGAMGR_RESET		131
-#define S2F_RESET		132
-#define SYSDBG_RESET		133
-#define OCRAM_OCP_RESET		134
-
-/* COLDMODRST */
-#define CLKMGRCOLD_RESET	160
-/* 161-162 is reserved */
-#define S2FCOLD_RESET		163
-#define TIMESTAMPCOLD_RESET	164
-#define TAPCOLD_RESET		165
-#define HMCCOLD_RESET		166
-#define IOMGRCOLD_RESET		167
-
-/* NRSTMODRST */
-#define NRSTPINOE_RESET		192
-
-/* DBGMODRST */
-#define DBG_RESET		224
-#endif
diff --git a/include/dt-bindings/reset/altr,rst-mgr.h b/include/dt-bindings/reset/altr,rst-mgr.h
deleted file mode 100644
index 5b7ad7396524..000000000000
--- a/include/dt-bindings/reset/altr,rst-mgr.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2014, Steffen Trumtrar <s.trumtrar@pengutronix.de>
- */
-
-#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_H
-#define _DT_BINDINGS_RESET_ALTR_RST_MGR_H
-
-/* MPUMODRST */
-#define CPU0_RESET		0
-#define CPU1_RESET		1
-#define WDS_RESET		2
-#define SCUPER_RESET		3
-#define L2_RESET		4
-
-/* PERMODRST */
-#define EMAC0_RESET		32
-#define EMAC1_RESET		33
-#define USB0_RESET		34
-#define USB1_RESET		35
-#define NAND_RESET		36
-#define QSPI_RESET		37
-#define L4WD0_RESET		38
-#define L4WD1_RESET		39
-#define OSC1TIMER0_RESET	40
-#define OSC1TIMER1_RESET	41
-#define SPTIMER0_RESET		42
-#define SPTIMER1_RESET		43
-#define I2C0_RESET		44
-#define I2C1_RESET		45
-#define I2C2_RESET		46
-#define I2C3_RESET		47
-#define UART0_RESET		48
-#define UART1_RESET		49
-#define SPIM0_RESET		50
-#define SPIM1_RESET		51
-#define SPIS0_RESET		52
-#define SPIS1_RESET		53
-#define SDMMC_RESET		54
-#define CAN0_RESET		55
-#define CAN1_RESET		56
-#define GPIO0_RESET		57
-#define GPIO1_RESET		58
-#define GPIO2_RESET		59
-#define DMA_RESET		60
-#define SDR_RESET		61
-
-/* PER2MODRST */
-#define DMAIF0_RESET		64
-#define DMAIF1_RESET		65
-#define DMAIF2_RESET		66
-#define DMAIF3_RESET		67
-#define DMAIF4_RESET		68
-#define DMAIF5_RESET		69
-#define DMAIF6_RESET		70
-#define DMAIF7_RESET		71
-
-/* BRGMODRST */
-#define HPS2FPGA_RESET		96
-#define LWHPS2FPGA_RESET	97
-#define FPGA2HPS_RESET		98
-
-/* MISCMODRST*/
-#define ROM_RESET		128
-#define OCRAM_RESET		129
-#define SYSMGR_RESET		130
-#define SYSMGRCOLD_RESET	131
-#define FPGAMGR_RESET		132
-#define ACPIDMAP_RESET		133
-#define S2F_RESET		134
-#define S2FCOLD_RESET		135
-#define NRSTPIN_RESET		136
-#define TIMESTAMPCOLD_RESET	137
-#define CLKMGRCOLD_RESET	138
-#define SCANMGR_RESET		139
-#define FRZCTRLCOLD_RESET	140
-#define SYSDBG_RESET		141
-#define DBG_RESET		142
-#define TAPCOLD_RESET		143
-#define SDRCOLD_RESET		144
-
-#endif
diff --git a/include/dt-bindings/reset/bcm6328-reset.h b/include/dt-bindings/reset/bcm6328-reset.h
deleted file mode 100644
index f2dd4f79cc61..000000000000
--- a/include/dt-bindings/reset/bcm6328-reset.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6328_H
-#define __DT_BINDINGS_RESET_BCM6328_H
-
-#define BCM6328_RST_SPI		0
-#define BCM6328_RST_EPHY	1
-#define BCM6328_RST_SAR		2
-#define BCM6328_RST_ENETSW	3
-#define BCM6328_RST_USBS	4
-#define BCM6328_RST_USBH	5
-#define BCM6328_RST_PCM		6
-#define BCM6328_RST_PCIE_CORE	7
-#define BCM6328_RST_PCIE	8
-#define BCM6328_RST_PCIE_EXT	9
-#define BCM6328_RST_PCIE_HARD	10
-
-#endif /* __DT_BINDINGS_RESET_BCM6328_H */
diff --git a/include/dt-bindings/reset/bcm6358-reset.h b/include/dt-bindings/reset/bcm6358-reset.h
deleted file mode 100644
index 075706eff7ad..000000000000
--- a/include/dt-bindings/reset/bcm6358-reset.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6358_H
-#define __DT_BINDINGS_RESET_BCM6358_H
-
-#define BCM6358_RST_SPI		0
-#define BCM6358_RST_ENET	2
-#define BCM6358_RST_MPI		3
-#define BCM6358_RST_EPHY	6
-#define BCM6358_RST_SAR		7
-#define BCM6358_RST_USBH	12
-#define BCM6358_RST_PCM		13
-#define BCM6358_RST_ADSL	14
-
-#endif /* __DT_BINDINGS_RESET_BCM6358_H */
diff --git a/include/dt-bindings/reset/bcm6362-reset.h b/include/dt-bindings/reset/bcm6362-reset.h
deleted file mode 100644
index 8202e4991905..000000000000
--- a/include/dt-bindings/reset/bcm6362-reset.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6362_H
-#define __DT_BINDINGS_RESET_BCM6362_H
-
-#define BCM6362_RST_SPI		0
-#define BCM6362_RST_IPSEC	1
-#define BCM6362_RST_EPHY	2
-#define BCM6362_RST_SAR		3
-#define BCM6362_RST_ENETSW	4
-#define BCM6362_RST_USBD	5
-#define BCM6362_RST_USBH	6
-#define BCM6362_RST_PCM		7
-#define BCM6362_RST_PCIE_CORE	8
-#define BCM6362_RST_PCIE	9
-#define BCM6362_RST_PCIE_EXT	10
-#define BCM6362_RST_WLAN_SHIM	11
-#define BCM6362_RST_DDR_PHY	12
-#define BCM6362_RST_FAP		13
-#define BCM6362_RST_WLAN_UBUS	14
-
-#endif /* __DT_BINDINGS_RESET_BCM6362_H */
diff --git a/include/dt-bindings/reset/bcm6368-reset.h b/include/dt-bindings/reset/bcm6368-reset.h
deleted file mode 100644
index 0038a7ccf5c6..000000000000
--- a/include/dt-bindings/reset/bcm6368-reset.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6368_H
-#define __DT_BINDINGS_RESET_BCM6368_H
-
-#define BCM6368_RST_SPI		0
-#define BCM6368_RST_MPI		3
-#define BCM6368_RST_IPSEC	4
-#define BCM6368_RST_EPHY	6
-#define BCM6368_RST_SAR		7
-#define BCM6368_RST_SWITCH	10
-#define BCM6368_RST_USBD	11
-#define BCM6368_RST_USBH	12
-#define BCM6368_RST_PCM		13
-
-#endif /* __DT_BINDINGS_RESET_BCM6368_H */
diff --git a/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
deleted file mode 100644
index 757f5e34c814..000000000000
--- a/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (c) 2020 Nuvoton Technology corporation.
-
-#ifndef _DT_BINDINGS_NPCM7XX_RESET_H
-#define _DT_BINDINGS_NPCM7XX_RESET_H
-
-#define NPCM7XX_RESET_IPSRST1		0x20
-#define NPCM7XX_RESET_IPSRST2		0x24
-#define NPCM7XX_RESET_IPSRST3		0x34
-
-/* Reset lines on IP1 reset module (NPCM7XX_RESET_IPSRST1) */
-#define NPCM7XX_RESET_FIU3		1
-#define NPCM7XX_RESET_UDC1		5
-#define NPCM7XX_RESET_EMC1		6
-#define NPCM7XX_RESET_UART_2_3		7
-#define NPCM7XX_RESET_UDC2		8
-#define NPCM7XX_RESET_PECI		9
-#define NPCM7XX_RESET_AES		10
-#define NPCM7XX_RESET_UART_0_1		11
-#define NPCM7XX_RESET_MC		12
-#define NPCM7XX_RESET_SMB2		13
-#define NPCM7XX_RESET_SMB3		14
-#define NPCM7XX_RESET_SMB4		15
-#define NPCM7XX_RESET_SMB5		16
-#define NPCM7XX_RESET_PWM_M0		18
-#define NPCM7XX_RESET_TIMER_0_4		19
-#define NPCM7XX_RESET_TIMER_5_9		20
-#define NPCM7XX_RESET_EMC2		21
-#define NPCM7XX_RESET_UDC4		22
-#define NPCM7XX_RESET_UDC5		23
-#define NPCM7XX_RESET_UDC6		24
-#define NPCM7XX_RESET_UDC3		25
-#define NPCM7XX_RESET_ADC		27
-#define NPCM7XX_RESET_SMB6		28
-#define NPCM7XX_RESET_SMB7		29
-#define NPCM7XX_RESET_SMB0		30
-#define NPCM7XX_RESET_SMB1		31
-
-/* Reset lines on IP2 reset module (NPCM7XX_RESET_IPSRST2) */
-#define NPCM7XX_RESET_MFT0		0
-#define NPCM7XX_RESET_MFT1		1
-#define NPCM7XX_RESET_MFT2		2
-#define NPCM7XX_RESET_MFT3		3
-#define NPCM7XX_RESET_MFT4		4
-#define NPCM7XX_RESET_MFT5		5
-#define NPCM7XX_RESET_MFT6		6
-#define NPCM7XX_RESET_MFT7		7
-#define NPCM7XX_RESET_MMC		8
-#define NPCM7XX_RESET_SDHC		9
-#define NPCM7XX_RESET_GFX_SYS		10
-#define NPCM7XX_RESET_AHB_PCIBRG	11
-#define NPCM7XX_RESET_VDMA		12
-#define NPCM7XX_RESET_ECE		13
-#define NPCM7XX_RESET_VCD		14
-#define NPCM7XX_RESET_OTP		16
-#define NPCM7XX_RESET_SIOX1		18
-#define NPCM7XX_RESET_SIOX2		19
-#define NPCM7XX_RESET_3DES		21
-#define NPCM7XX_RESET_PSPI1		22
-#define NPCM7XX_RESET_PSPI2		23
-#define NPCM7XX_RESET_GMAC2		25
-#define NPCM7XX_RESET_USB_HOST		26
-#define NPCM7XX_RESET_GMAC1		28
-#define NPCM7XX_RESET_CP		31
-
-/* Reset lines on IP3 reset module (NPCM7XX_RESET_IPSRST3) */
-#define NPCM7XX_RESET_PWM_M1		0
-#define NPCM7XX_RESET_SMB12		1
-#define NPCM7XX_RESET_SPIX		2
-#define NPCM7XX_RESET_SMB13		3
-#define NPCM7XX_RESET_UDC0		4
-#define NPCM7XX_RESET_UDC7		5
-#define NPCM7XX_RESET_UDC8		6
-#define NPCM7XX_RESET_UDC9		7
-#define NPCM7XX_RESET_PCI_MAILBOX	9
-#define NPCM7XX_RESET_SMB14		12
-#define NPCM7XX_RESET_SHA		13
-#define NPCM7XX_RESET_SEC_ECC		14
-#define NPCM7XX_RESET_PCIE_RC		15
-#define NPCM7XX_RESET_TIMER_10_14	16
-#define NPCM7XX_RESET_RNG		17
-#define NPCM7XX_RESET_SMB15		18
-#define NPCM7XX_RESET_SMB8		19
-#define NPCM7XX_RESET_SMB9		20
-#define NPCM7XX_RESET_SMB10		21
-#define NPCM7XX_RESET_SMB11		22
-#define NPCM7XX_RESET_ESPI		23
-#define NPCM7XX_RESET_USB_PHY_1		24
-#define NPCM7XX_RESET_USB_PHY_2		25
-
-#endif
diff --git a/include/dt-bindings/reset/tegra124-car.h b/include/dt-bindings/reset/tegra124-car.h
deleted file mode 100644
index 070e4f6e7486..000000000000
--- a/include/dt-bindings/reset/tegra124-car.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * This header provides Tegra124-specific constants for binding
- * nvidia,tegra124-car.
- */
-
-#ifndef _DT_BINDINGS_RESET_TEGRA124_CAR_H
-#define _DT_BINDINGS_RESET_TEGRA124_CAR_H
-
-#define TEGRA124_RESET(x)		(6 * 32 + (x))
-#define TEGRA124_RST_DFLL_DVCO		TEGRA124_RESET(0)
-
-#endif	/* _DT_BINDINGS_RESET_TEGRA124_CAR_H */
diff --git a/include/dt-bindings/reset/tegra186-reset.h b/include/dt-bindings/reset/tegra186-reset.h
deleted file mode 100644
index 7efec9200532..000000000000
--- a/include/dt-bindings/reset/tegra186-reset.h
+++ /dev/null
@@ -1,205 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2015, NVIDIA CORPORATION.
- */
-
-#ifndef _ABI_MACH_T186_RESET_T186_H_
-#define _ABI_MACH_T186_RESET_T186_H_
-
-#define TEGRA186_RESET_ACTMON			0
-#define TEGRA186_RESET_AFI			1
-#define TEGRA186_RESET_CEC			2
-#define TEGRA186_RESET_CSITE			3
-#define TEGRA186_RESET_DP2			4
-#define TEGRA186_RESET_DPAUX			5
-#define TEGRA186_RESET_DSI			6
-#define TEGRA186_RESET_DSIB			7
-#define TEGRA186_RESET_DTV			8
-#define TEGRA186_RESET_DVFS			9
-#define TEGRA186_RESET_ENTROPY			10
-#define TEGRA186_RESET_EXTPERIPH1		11
-#define TEGRA186_RESET_EXTPERIPH2		12
-#define TEGRA186_RESET_EXTPERIPH3		13
-#define TEGRA186_RESET_GPU			14
-#define TEGRA186_RESET_HDA			15
-#define TEGRA186_RESET_HDA2CODEC_2X		16
-#define TEGRA186_RESET_HDA2HDMICODEC		17
-#define TEGRA186_RESET_HOST1X			18
-#define TEGRA186_RESET_I2C1			19
-#define TEGRA186_RESET_I2C2			20
-#define TEGRA186_RESET_I2C3			21
-#define TEGRA186_RESET_I2C4			22
-#define TEGRA186_RESET_I2C5			23
-#define TEGRA186_RESET_I2C6			24
-#define TEGRA186_RESET_ISP			25
-#define TEGRA186_RESET_KFUSE			26
-#define TEGRA186_RESET_LA			27
-#define TEGRA186_RESET_MIPI_CAL			28
-#define TEGRA186_RESET_PCIE			29
-#define TEGRA186_RESET_PCIEXCLK			30
-#define TEGRA186_RESET_SATA			31
-#define TEGRA186_RESET_SATACOLD			32
-#define TEGRA186_RESET_SDMMC1			33
-#define TEGRA186_RESET_SDMMC2			34
-#define TEGRA186_RESET_SDMMC3			35
-#define TEGRA186_RESET_SDMMC4			36
-#define TEGRA186_RESET_SE			37
-#define TEGRA186_RESET_SOC_THERM		38
-#define TEGRA186_RESET_SOR0			39
-#define TEGRA186_RESET_SPI1			40
-#define TEGRA186_RESET_SPI2			41
-#define TEGRA186_RESET_SPI3			42
-#define TEGRA186_RESET_SPI4			43
-#define TEGRA186_RESET_TMR			44
-#define TEGRA186_RESET_TRIG_SYS			45
-#define TEGRA186_RESET_TSEC			46
-#define TEGRA186_RESET_UARTA			47
-#define TEGRA186_RESET_UARTB			48
-#define TEGRA186_RESET_UARTC			49
-#define TEGRA186_RESET_UARTD			50
-#define TEGRA186_RESET_VI			51
-#define TEGRA186_RESET_VIC			52
-#define TEGRA186_RESET_XUSB_DEV			53
-#define TEGRA186_RESET_XUSB_HOST		54
-#define TEGRA186_RESET_XUSB_PADCTL		55
-#define TEGRA186_RESET_XUSB_SS			56
-#define TEGRA186_RESET_AON_APB			57
-#define TEGRA186_RESET_AXI_CBB			58
-#define TEGRA186_RESET_BPMP_APB			59
-#define TEGRA186_RESET_CAN1			60
-#define TEGRA186_RESET_CAN2			61
-#define TEGRA186_RESET_DMIC5			62
-#define TEGRA186_RESET_DSIC			63
-#define TEGRA186_RESET_DSID			64
-#define TEGRA186_RESET_EMC_EMC			65
-#define TEGRA186_RESET_EMC_MEM			66
-#define TEGRA186_RESET_EMCSB_EMC		67
-#define TEGRA186_RESET_EMCSB_MEM		68
-#define TEGRA186_RESET_EQOS			69
-#define TEGRA186_RESET_GPCDMA			70
-#define TEGRA186_RESET_GPIO_CTL0		71
-#define TEGRA186_RESET_GPIO_CTL1		72
-#define TEGRA186_RESET_GPIO_CTL2		73
-#define TEGRA186_RESET_GPIO_CTL3		74
-#define TEGRA186_RESET_GPIO_CTL4		75
-#define TEGRA186_RESET_GPIO_CTL5		76
-#define TEGRA186_RESET_I2C10			77
-#define TEGRA186_RESET_I2C12			78
-#define TEGRA186_RESET_I2C13			79
-#define TEGRA186_RESET_I2C14			80
-#define TEGRA186_RESET_I2C7			81
-#define TEGRA186_RESET_I2C8			82
-#define TEGRA186_RESET_I2C9			83
-#define TEGRA186_RESET_JTAG2AXI			84
-#define TEGRA186_RESET_MPHY_IOBIST		85
-#define TEGRA186_RESET_MPHY_L0_RX		86
-#define TEGRA186_RESET_MPHY_L0_TX		87
-#define TEGRA186_RESET_NVCSI			88
-#define TEGRA186_RESET_NVDISPLAY0_HEAD0		89
-#define TEGRA186_RESET_NVDISPLAY0_HEAD1		90
-#define TEGRA186_RESET_NVDISPLAY0_HEAD2		91
-#define TEGRA186_RESET_NVDISPLAY0_MISC		92
-#define TEGRA186_RESET_NVDISPLAY0_WGRP0		93
-#define TEGRA186_RESET_NVDISPLAY0_WGRP1		94
-#define TEGRA186_RESET_NVDISPLAY0_WGRP2		95
-#define TEGRA186_RESET_NVDISPLAY0_WGRP3		96
-#define TEGRA186_RESET_NVDISPLAY0_WGRP4		97
-#define TEGRA186_RESET_NVDISPLAY0_WGRP5		98
-#define TEGRA186_RESET_PWM1			99
-#define TEGRA186_RESET_PWM2			100
-#define TEGRA186_RESET_PWM3			101
-#define TEGRA186_RESET_PWM4			102
-#define TEGRA186_RESET_PWM5			103
-#define TEGRA186_RESET_PWM6			104
-#define TEGRA186_RESET_PWM7			105
-#define TEGRA186_RESET_PWM8			106
-#define TEGRA186_RESET_SCE_APB			107
-#define TEGRA186_RESET_SOR1			108
-#define TEGRA186_RESET_TACH			109
-#define TEGRA186_RESET_TSC			110
-#define TEGRA186_RESET_UARTF			111
-#define TEGRA186_RESET_UARTG			112
-#define TEGRA186_RESET_UFSHC			113
-#define TEGRA186_RESET_UFSHC_AXI_M		114
-#define TEGRA186_RESET_UPHY			115
-#define TEGRA186_RESET_ADSP			116
-#define TEGRA186_RESET_ADSPDBG			117
-#define TEGRA186_RESET_ADSPINTF			118
-#define TEGRA186_RESET_ADSPNEON			119
-#define TEGRA186_RESET_ADSPPERIPH		120
-#define TEGRA186_RESET_ADSPSCU			121
-#define TEGRA186_RESET_ADSPWDT			122
-#define TEGRA186_RESET_APE			123
-#define TEGRA186_RESET_DPAUX1			124
-#define TEGRA186_RESET_NVDEC			125
-#define TEGRA186_RESET_NVENC			126
-#define TEGRA186_RESET_NVJPG			127
-#define TEGRA186_RESET_PEX_USB_UPHY		128
-#define TEGRA186_RESET_QSPI			129
-#define TEGRA186_RESET_TSECB			130
-#define TEGRA186_RESET_VI_I2C			131
-#define TEGRA186_RESET_UARTE			132
-#define TEGRA186_RESET_TOP_GTE			133
-#define TEGRA186_RESET_SHSP			134
-#define TEGRA186_RESET_PEX_USB_UPHY_L5		135
-#define TEGRA186_RESET_PEX_USB_UPHY_L4		136
-#define TEGRA186_RESET_PEX_USB_UPHY_L3		137
-#define TEGRA186_RESET_PEX_USB_UPHY_L2		138
-#define TEGRA186_RESET_PEX_USB_UPHY_L1		139
-#define TEGRA186_RESET_PEX_USB_UPHY_L0		140
-#define TEGRA186_RESET_PEX_USB_UPHY_PLL1	141
-#define TEGRA186_RESET_PEX_USB_UPHY_PLL0	142
-#define TEGRA186_RESET_TSCTNVI			143
-#define TEGRA186_RESET_EXTPERIPH4		144
-#define TEGRA186_RESET_DSIPADCTL		145
-#define TEGRA186_RESET_AUD_MCLK			146
-#define TEGRA186_RESET_MPHY_CLK_CTL		147
-#define TEGRA186_RESET_MPHY_L1_RX		148
-#define TEGRA186_RESET_MPHY_L1_TX		149
-#define TEGRA186_RESET_UFSHC_LP			150
-#define TEGRA186_RESET_BPMP_NIC			151
-#define TEGRA186_RESET_BPMP_NSYSPORESET		152
-#define TEGRA186_RESET_BPMP_NRESET		153
-#define TEGRA186_RESET_BPMP_DBGRESETN		154
-#define TEGRA186_RESET_BPMP_PRESETDBGN		155
-#define TEGRA186_RESET_BPMP_PM			156
-#define TEGRA186_RESET_BPMP_CVC			157
-#define TEGRA186_RESET_BPMP_DMA			158
-#define TEGRA186_RESET_BPMP_HSP			159
-#define TEGRA186_RESET_TSCTNBPMP		160
-#define TEGRA186_RESET_BPMP_TKE			161
-#define TEGRA186_RESET_BPMP_GTE			162
-#define TEGRA186_RESET_BPMP_PM_ACTMON		163
-#define TEGRA186_RESET_AON_NIC			164
-#define TEGRA186_RESET_AON_NSYSPORESET		165
-#define TEGRA186_RESET_AON_NRESET		166
-#define TEGRA186_RESET_AON_DBGRESETN		167
-#define TEGRA186_RESET_AON_PRESETDBGN		168
-#define TEGRA186_RESET_AON_ACTMON		169
-#define TEGRA186_RESET_AOPM			170
-#define TEGRA186_RESET_AOVC			171
-#define TEGRA186_RESET_AON_DMA			172
-#define TEGRA186_RESET_AON_GPIO			173
-#define TEGRA186_RESET_AON_HSP			174
-#define TEGRA186_RESET_TSCTNAON			175
-#define TEGRA186_RESET_AON_TKE			176
-#define TEGRA186_RESET_AON_GTE			177
-#define TEGRA186_RESET_SCE_NIC			178
-#define TEGRA186_RESET_SCE_NSYSPORESET		179
-#define TEGRA186_RESET_SCE_NRESET		180
-#define TEGRA186_RESET_SCE_DBGRESETN		181
-#define TEGRA186_RESET_SCE_PRESETDBGN		182
-#define TEGRA186_RESET_SCE_ACTMON		183
-#define TEGRA186_RESET_SCE_PM			184
-#define TEGRA186_RESET_SCE_DMA			185
-#define TEGRA186_RESET_SCE_HSP			186
-#define TEGRA186_RESET_TSCTNSCE			187
-#define TEGRA186_RESET_SCE_TKE			188
-#define TEGRA186_RESET_SCE_GTE			189
-#define TEGRA186_RESET_SCE_CFG			190
-#define TEGRA186_RESET_ADSP_ALL			191
-/** @brief controls the power up/down sequence of UFSHC PSW partition. Controls LP_PWR_READY, LP_ISOL_EN, and LP_RESET_N signals */
-#define TEGRA186_RESET_UFSHC_LP_SEQ		192
-#define TEGRA186_RESET_SIZE			193
-
-#endif
diff --git a/include/dt-bindings/reset/ti-syscon.h b/include/dt-bindings/reset/ti-syscon.h
deleted file mode 100644
index 1427ff140f11..000000000000
--- a/include/dt-bindings/reset/ti-syscon.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * TI Syscon Reset definitions
- *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __DT_BINDINGS_RESET_TI_SYSCON_H__
-#define __DT_BINDINGS_RESET_TI_SYSCON_H__
-
-/*
- * The reset does not support the feature and corresponding
- * values are not valid
- */
-#define ASSERT_NONE	(1 << 0)
-#define DEASSERT_NONE	(1 << 1)
-#define STATUS_NONE	(1 << 2)
-
-/* When set this function is activated by setting(vs clearing) this bit */
-#define ASSERT_SET	(1 << 3)
-#define DEASSERT_SET	(1 << 4)
-#define STATUS_SET	(1 << 5)
-
-/* The following are the inverse of the above and are added for consistency */
-#define ASSERT_CLEAR	(0 << 3)
-#define DEASSERT_CLEAR	(0 << 4)
-#define STATUS_CLEAR	(0 << 5)
-
-#endif
-- 
2.43.0

