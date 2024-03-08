Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF5EC54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 19:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2426187D49;
	Fri,  8 Mar 2024 20:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fduw5+bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B8987D49; Fri,  8 Mar 2024 20:38:20 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E659487D47
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 20:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-788412a4b78so58744085a.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 11:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709926695; x=1710531495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jxVZUKkYQVlorKAVri/zknyOZO41d5wfRMfUtol9nZ4=;
 b=Fduw5+bpFiEtJQc04TIfmI/2fd2zZAQIvADU5v90tKnY1wnxYwmtlCnYOy65uboyMx
 Y56pWW4obgLrnoCW13mKIFPaQAjzgT/D54gNjxRu3Bn08TAeoqJi6Fdqw85RORa9Kwcz
 4bVCiQ7hmKmA2SnYiFKWnL9YGGZC6mWq0snk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709926695; x=1710531495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxVZUKkYQVlorKAVri/zknyOZO41d5wfRMfUtol9nZ4=;
 b=AEJzWEqlvP/1HSA22TtmrODwXuseDbUIute3idd3EKirMtYj8aR5KTJ9XAJSBi0WMe
 fNOV8v9KPQznBiEa4WqiXjQzJtRKmPkUg3aHNxhM8NE7z1WqdEWgnQNmF7ySgcWQnqAA
 +Z0WjjBc291UBg8KTPKWL11rfjuNVSI40GklQZ6OZdu0ZciJnduSSQ8Xu4YAlrjffFKe
 5Ew/nf4ibQqYTziT9zz5MrE8iGMt/vbDpgUvdm14lLRCunuAWtMpYKCRPGextsEw9mDN
 hbznwhy+WGqdXwX940kzJOSsg7pLmAsJsgY5A7Egrs/HeowMs8GnfuGZBFVSuRDRvA2B
 /2AQ==
X-Gm-Message-State: AOJu0YxF3oQIBGYdsh5UNrfBVd2VFKN9UBVB/HXQkanwT3GOeibNubv7
 k2ikfd8OEjTGsvz9wD97bo8AUlUX2vedbRHRppvnYY1TykR6RiTcCupaVTT3WHLfWnzAb49uPlw
 B
X-Google-Smtp-Source: AGHT+IGUr/34dGDYLDNpefiqMzCa52Mp3O2mufB447sgkvQaAtJwhD6Aii8mo5RiVxwICxhq3YC3WA==
X-Received: by 2002:a05:620a:4942:b0:788:1e8e:fab1 with SMTP id
 vz2-20020a05620a494200b007881e8efab1mr43205qkn.61.1709926694926; 
 Fri, 08 Mar 2024 11:38:14 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 c2-20020a05620a134200b0078821ef8162sm54577qkl.9.2024.03.08.11.38.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 11:38:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] stv0991: Remove stv0991 board and architecture code
Date: Fri,  8 Mar 2024 14:38:13 -0500
Message-Id: <20240308193813.359949-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This architecture and related board are unmaintained currently and have
been for a long time. Remove them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS                                   |   7 -
 arch/arm/Kconfig                              |  15 --
 arch/arm/cpu/armv7/Makefile                   |   1 -
 arch/arm/cpu/armv7/stv0991/Makefile           |   7 -
 arch/arm/cpu/armv7/stv0991/clock.c            |  42 ------
 arch/arm/cpu/armv7/stv0991/lowlevel.S         |  11 --
 arch/arm/cpu/armv7/stv0991/pinmux.c           |  66 ---------
 arch/arm/cpu/armv7/stv0991/reset.c            |  27 ----
 arch/arm/cpu/armv7/stv0991/timer.c            | 114 ---------------
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/stv0991.dts                      |  55 --------
 arch/arm/include/asm/arch-stv0991/gpio.h      |  21 ---
 arch/arm/include/asm/arch-stv0991/hardware.h  |  72 ----------
 .../include/asm/arch-stv0991/stv0991_cgu.h    | 130 ------------------
 .../include/asm/arch-stv0991/stv0991_creg.h   | 103 --------------
 .../include/asm/arch-stv0991/stv0991_defs.h   |  14 --
 .../include/asm/arch-stv0991/stv0991_gpt.h    |  41 ------
 .../include/asm/arch-stv0991/stv0991_periph.h |  45 ------
 .../include/asm/arch-stv0991/stv0991_wdru.h   |  27 ----
 board/st/stv0991/Kconfig                      |  15 --
 board/st/stv0991/MAINTAINERS                  |   6 -
 board/st/stv0991/Makefile                     |   6 -
 board/st/stv0991/stv0991.c                    | 119 ----------------
 configs/stv0991_defconfig                     |  44 ------
 include/configs/stv0991.h                     |  25 ----
 25 files changed, 1014 deletions(-)
 delete mode 100644 arch/arm/cpu/armv7/stv0991/Makefile
 delete mode 100644 arch/arm/cpu/armv7/stv0991/clock.c
 delete mode 100644 arch/arm/cpu/armv7/stv0991/lowlevel.S
 delete mode 100644 arch/arm/cpu/armv7/stv0991/pinmux.c
 delete mode 100644 arch/arm/cpu/armv7/stv0991/reset.c
 delete mode 100644 arch/arm/cpu/armv7/stv0991/timer.c
 delete mode 100644 arch/arm/dts/stv0991.dts
 delete mode 100644 arch/arm/include/asm/arch-stv0991/gpio.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/hardware.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/stv0991_cgu.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/stv0991_creg.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/stv0991_defs.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/stv0991_gpt.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/stv0991_periph.h
 delete mode 100644 arch/arm/include/asm/arch-stv0991/stv0991_wdru.h
 delete mode 100644 board/st/stv0991/Kconfig
 delete mode 100644 board/st/stv0991/MAINTAINERS
 delete mode 100644 board/st/stv0991/Makefile
 delete mode 100644 board/st/stv0991/stv0991.c
 delete mode 100644 configs/stv0991_defconfig
 delete mode 100644 include/configs/stv0991.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fbb82b3df5d4..e90cc094a7f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -683,13 +683,6 @@ F:	tools/stm32image.c
 N:	stm
 N:	stm32
 
-
-ARM STM STV0991
-M:	Vikas Manocha <vikas.manocha@st.com>
-S:	Maintained
-F:	arch/arm/cpu/armv7/stv0991/
-F:	arch/arm/include/asm/arch-stv0991/
-
 ARM SUNXI
 M:	Jagan Teki <jagan@amarulasolutions.com>
 M:	Andre Przywara <andre.przywara@arm.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 65fa7ba4ce77..d15ccc7bb284 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -631,20 +631,6 @@ config ARCH_ORION5X
 	select SPL_SEPARATE_BSS if SPL
 	select TIMER
 
-config TARGET_STV0991
-	bool "Support stv0991"
-	select CPU_V7A
-	select DM
-	select DM_SERIAL
-	select DM_SPI
-	select DM_SPI_FLASH
-	select GPIO_EXTRA_HEADER
-	select PL01X_SERIAL
-	select MTD
-	select SPI
-	select SPI_FLASH
-	imply CMD_DM
-
 config ARCH_BCM283X
 	bool "Broadcom BCM283X family"
 	select DM
@@ -2358,7 +2344,6 @@ source "board/samsung/common/Kconfig"
 source "board/siemens/common/Kconfig"
 source "board/seeed/npi_imx6ull/Kconfig"
 source "board/socionext/developerbox/Kconfig"
-source "board/st/stv0991/Kconfig"
 source "board/tcl/sl50/Kconfig"
 source "board/traverse/ten64/Kconfig"
 source "board/variscite/dart_6ul/Kconfig"
diff --git a/arch/arm/cpu/armv7/Makefile b/arch/arm/cpu/armv7/Makefile
index 653eef8ad79e..99cf9eb515f9 100644
--- a/arch/arm/cpu/armv7/Makefile
+++ b/arch/arm/cpu/armv7/Makefile
@@ -37,7 +37,6 @@ obj-$(if $(filter bcm281xx,$(SOC)),y) += bcm281xx/
 obj-$(if $(filter bcmcygnus,$(SOC)),y) += bcmcygnus/
 obj-$(if $(filter bcmnsp,$(SOC)),y) += bcmnsp/
 obj-$(if $(filter ls102xa,$(SOC)),y) += ls102xa/
-obj-$(if $(filter stv0991,$(SOC)),y) += stv0991/
 obj-$(CONFIG_ARCH_SUNXI) += sunxi/
 obj-$(CONFIG_VF610) += vf610/
 obj-$(CONFIG_ARCH_S5P4418) += s5p4418/
diff --git a/arch/arm/cpu/armv7/stv0991/Makefile b/arch/arm/cpu/armv7/stv0991/Makefile
deleted file mode 100644
index 3be5eba4b122..000000000000
--- a/arch/arm/cpu/armv7/stv0991/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2014, STMicroelectronics - All Rights Reserved
-# Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
-
-obj-y	:= timer.o clock.o pinmux.o reset.o
-obj-y	+= lowlevel.o
diff --git a/arch/arm/cpu/armv7/stv0991/clock.c b/arch/arm/cpu/armv7/stv0991/clock.c
deleted file mode 100644
index 1e35deed3530..000000000000
--- a/arch/arm/cpu/armv7/stv0991/clock.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#include <asm/io.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/stv0991_cgu.h>
-#include<asm/arch/stv0991_periph.h>
-
-static struct stv0991_cgu_regs *const stv0991_cgu_regs = \
-				(struct stv0991_cgu_regs *) (CGU_BASE_ADDR);
-
-void enable_pll1(void)
-{
-	/* pll1 already configured for 1000Mhz, just need to enable it */
-	writel(readl(&stv0991_cgu_regs->pll1_ctrl) & ~(0x01),
-			&stv0991_cgu_regs->pll1_ctrl);
-}
-
-void clock_setup(int peripheral)
-{
-	switch (peripheral) {
-	case UART_CLOCK_CFG:
-		writel(UART_CLK_CFG, &stv0991_cgu_regs->uart_freq);
-		break;
-	case ETH_CLOCK_CFG:
-		enable_pll1();
-		writel(ETH_CLK_CFG, &stv0991_cgu_regs->eth_freq);
-
-		/* Clock selection for ethernet tx_clk & rx_clk*/
-		writel((readl(&stv0991_cgu_regs->eth_ctrl) & ETH_CLK_MASK)
-				| ETH_CLK_CTRL, &stv0991_cgu_regs->eth_ctrl);
-		break;
-	case QSPI_CLOCK_CFG:
-		writel(QSPI_CLK_CTRL, &stv0991_cgu_regs->qspi_freq);
-		break;
-	default:
-		break;
-	}
-}
diff --git a/arch/arm/cpu/armv7/stv0991/lowlevel.S b/arch/arm/cpu/armv7/stv0991/lowlevel.S
deleted file mode 100644
index 5733eaa15c0b..000000000000
--- a/arch/arm/cpu/armv7/stv0991/lowlevel.S
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2014 STMicroelectronics
- */
-
-#include <config.h>
-#include <linux/linkage.h>
-
-ENTRY(lowlevel_init)
-	mov	pc, lr
-ENDPROC(lowlevel_init)
diff --git a/arch/arm/cpu/armv7/stv0991/pinmux.c b/arch/arm/cpu/armv7/stv0991/pinmux.c
deleted file mode 100644
index 6c44ffe50e81..000000000000
--- a/arch/arm/cpu/armv7/stv0991/pinmux.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#include <asm/io.h>
-#include <asm/arch/stv0991_creg.h>
-#include <asm/arch/stv0991_periph.h>
-#include <asm/arch/hardware.h>
-
-static struct stv0991_creg *const stv0991_creg = \
-			(struct stv0991_creg *)CREG_BASE_ADDR;
-
-int stv0991_pinmux_config(int peripheral)
-{
-	switch (peripheral) {
-	case UART_GPIOC_30_31:
-		/* SSDA/SSCL pad muxing to UART Rx/Dx */
-		writel((readl(&stv0991_creg->mux12) & GPIOC_31_MUX_MASK) |
-				CFG_GPIOC_31_UART_RX,
-				&stv0991_creg->mux12);
-		writel((readl(&stv0991_creg->mux12) & GPIOC_30_MUX_MASK) |
-				CFG_GPIOC_30_UART_TX,
-				&stv0991_creg->mux12);
-		/* SSDA/SSCL pad config to push pull*/
-		writel((readl(&stv0991_creg->cfg_pad6) & GPIOC_31_MODE_MASK) |
-				CFG_GPIOC_31_MODE_PP,
-				&stv0991_creg->cfg_pad6);
-		writel((readl(&stv0991_creg->cfg_pad6) & GPIOC_30_MODE_MASK) |
-				CFG_GPIOC_30_MODE_HIGH,
-				&stv0991_creg->cfg_pad6);
-		break;
-	case UART_GPIOB_16_17:
-		/* ethernet rx_6/7 to UART Rx/Dx */
-		writel((readl(&stv0991_creg->mux7) & GPIOB_17_MUX_MASK) |
-				CFG_GPIOB_17_UART_RX,
-				&stv0991_creg->mux7);
-		writel((readl(&stv0991_creg->mux7) & GPIOB_16_MUX_MASK) |
-				CFG_GPIOB_16_UART_TX,
-				&stv0991_creg->mux7);
-		break;
-	case ETH_GPIOB_10_31_C_0_4:
-		writel(readl(&stv0991_creg->mux6) & 0x000000FF,
-				&stv0991_creg->mux6);
-		writel(0x00000000, &stv0991_creg->mux7);
-		writel(0x00000000, &stv0991_creg->mux8);
-		writel(readl(&stv0991_creg->mux9) & 0xFFF00000,
-				&stv0991_creg->mux9);
-		/* Ethernet Voltage configuration to 1.8V*/
-		writel((readl(&stv0991_creg->vdd_pad1) & VDD_ETH_PS_MASK) |
-				ETH_VDD_CFG, &stv0991_creg->vdd_pad1);
-		writel((readl(&stv0991_creg->vdd_pad1) & VDD_ETH_PS_MASK) |
-				ETH_M_VDD_CFG, &stv0991_creg->vdd_pad1);
-
-		break;
-	case QSPI_CS_CLK_PAD:
-		writel((readl(&stv0991_creg->mux13) & FLASH_CS_NC_MASK) |
-				CFG_FLASH_CS_NC, &stv0991_creg->mux13);
-		writel((readl(&stv0991_creg->mux13) & FLASH_CLK_MASK) |
-				CFG_FLASH_CLK, &stv0991_creg->mux13);
-	default:
-		break;
-	}
-	return 0;
-}
diff --git a/arch/arm/cpu/armv7/stv0991/reset.c b/arch/arm/cpu/armv7/stv0991/reset.c
deleted file mode 100644
index 77d4477c8dc5..000000000000
--- a/arch/arm/cpu/armv7/stv0991/reset.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#include <common.h>
-#include <cpu_func.h>
-#include <asm/io.h>
-#include <asm/arch/stv0991_wdru.h>
-#include <linux/delay.h>
-void reset_cpu(void)
-{
-	puts("System is going to reboot ...\n");
-	/*
-	 * This 1 second delay will allow the above message
-	 * to be printed before reset
-	 */
-	udelay((1000 * 1000));
-
-	/* Setting bit 1 of the WDRU unit will reset the SoC */
-	writel(WDRU_RST_SYS, &stv0991_wd_ru_ptr->wdru_ctrl1);
-
-	/* system will restart */
-	while (1)
-		;
-}
diff --git a/arch/arm/cpu/armv7/stv0991/timer.c b/arch/arm/cpu/armv7/stv0991/timer.c
deleted file mode 100644
index f7cc45772f91..000000000000
--- a/arch/arm/cpu/armv7/stv0991/timer.c
+++ /dev/null
@@ -1,114 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#include <common.h>
-#include <init.h>
-#include <time.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/arch-stv0991/hardware.h>
-#include <asm/arch-stv0991/stv0991_cgu.h>
-#include <asm/arch-stv0991/stv0991_gpt.h>
-#include <linux/delay.h>
-
-static struct stv0991_cgu_regs *const stv0991_cgu_regs = \
-				(struct stv0991_cgu_regs *) (CGU_BASE_ADDR);
-
-#define READ_TIMER()	(readl(&gpt1_regs_ptr->cnt) & GPT_FREE_RUNNING)
-#define GPT_RESOLUTION	(CFG_SYS_HZ_CLOCK / CONFIG_SYS_HZ)
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#define timestamp gd->arch.tbl
-#define lastdec gd->arch.lastinc
-
-static ulong get_timer_masked(void);
-
-int timer_init(void)
-{
-	/* Timer1 clock configuration */
-	writel(TIMER1_CLK_CFG, &stv0991_cgu_regs->tim_freq);
-	writel(readl(&stv0991_cgu_regs->cgu_enable_2) |
-			TIMER1_CLK_EN, &stv0991_cgu_regs->cgu_enable_2);
-
-	/* Stop the timer */
-	writel(readl(&gpt1_regs_ptr->cr1) & ~GPT_CR1_CEN, &gpt1_regs_ptr->cr1);
-	writel(GPT_PRESCALER_128, &gpt1_regs_ptr->psc);
-	/* Configure timer for auto-reload */
-	writel(readl(&gpt1_regs_ptr->cr1) | GPT_MODE_AUTO_RELOAD,
-			&gpt1_regs_ptr->cr1);
-
-	/* load value for free running */
-	writel(GPT_FREE_RUNNING, &gpt1_regs_ptr->arr);
-
-	/* start timer */
-	writel(readl(&gpt1_regs_ptr->cr1) | GPT_CR1_CEN,
-			&gpt1_regs_ptr->cr1);
-
-	/* Reset the timer */
-	lastdec = READ_TIMER();
-	timestamp = 0;
-
-	return 0;
-}
-
-/*
- * timer without interrupts
- */
-ulong get_timer(ulong base)
-{
-	return (get_timer_masked() / GPT_RESOLUTION) - base;
-}
-
-void __udelay(unsigned long usec)
-{
-	ulong tmo;
-	ulong start = get_timer_masked();
-	ulong tenudelcnt = CFG_SYS_HZ_CLOCK / (1000 * 100);
-	ulong rndoff;
-
-	rndoff = (usec % 10) ? 1 : 0;
-
-	/* tenudelcnt timer tick gives 10 microsecconds delay */
-	tmo = ((usec / 10) + rndoff) * tenudelcnt;
-
-	while ((ulong) (get_timer_masked() - start) < tmo)
-		;
-}
-
-static ulong get_timer_masked(void)
-{
-	ulong now = READ_TIMER();
-
-	if (now >= lastdec) {
-		/* normal mode */
-		timestamp += now - lastdec;
-	} else {
-		/* we have an overflow ... */
-		timestamp += now + GPT_FREE_RUNNING - lastdec;
-	}
-	lastdec = now;
-
-	return timestamp;
-}
-
-/*
- * This function is derived from PowerPC code (read timebase as long long).
- * On ARM it just returns the timer value.
- */
-unsigned long long get_ticks(void)
-{
-	return get_timer(0);
-}
-
-/*
- * This function is derived from PowerPC code (timebase clock frequency).
- * On ARM it returns the number of timer ticks per second.
- */
-ulong get_tbclk(void)
-{
-	return CONFIG_SYS_HZ;
-}
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 971a4065faff..f4ef7f09af80 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -569,7 +569,6 @@ dtb-$(CONFIG_TARGET_AM57XX_EVM) += am57xx-beagle-x15.dtb \
 	am574x-idk.dtb \
 	am572x-idk.dtb	\
 	am571x-idk.dtb
-dtb-$(CONFIG_TARGET_STV0991) += stv0991.dtb
 
 dtb-$(CONFIG_ARCH_LS1021A) += ls1021a-qds-duart.dtb \
 	ls1021a-qds-lpuart.dtb \
diff --git a/arch/arm/dts/stv0991.dts b/arch/arm/dts/stv0991.dts
deleted file mode 100644
index b04e89971c77..000000000000
--- a/arch/arm/dts/stv0991.dts
+++ /dev/null
@@ -1,55 +0,0 @@
-/dts-v1/;
-
-/ {
-	model = "ST STV0991 application board";
-	compatible = "st,stv0991";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	chosen {
-		stdout-path = &uart0;
-	};
-
-	memory {
-		device_type="memory";
-		reg = <0x0 0x198000>;
-	};
-
-	uart0: serial@0x80406000 {
-		compatible = "arm,pl011", "arm,primecell";
-		reg = <0x80406000 0x1000>;
-		clock = <2700000>;
-	};
-
-	aliases {
-		spi0 = "/spi@80203000";		/* QSPI */
-	};
-
-	qspi: spi@80203000 {
-			compatible = "cdns,qspi-nor";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x80203000 0x100>,
-				<0x40000000 0x1000000>;
-			clocks = <3750000>;
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			cdns,trigger-address = <0x40000000>;
-			status = "okay";
-
-			flash0: n25q32@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "jedec,spi-nor";
-				reg = <0>;		/* chip select */
-				spi-max-frequency = <50000000>;
-				m25p,fast-read;
-				page-size = <256>;
-				block-size = <16>; 	/* 2^16, 64KB */
-				cdns,tshsl-ns = <50>;
-				cdns,tsd2d-ns = <50>;
-				cdns,tchsh-ns = <4>;
-				cdns,tslch-ns = <4>;
-			};
-	};
-};
diff --git a/arch/arm/include/asm/arch-stv0991/gpio.h b/arch/arm/include/asm/arch-stv0991/gpio.h
deleted file mode 100644
index b27f4078582c..000000000000
--- a/arch/arm/include/asm/arch-stv0991/gpio.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef __ASM_ARCH_STV0991_GPIO_H
-#define __ASM_ARCH_STV0991_GPIO_H
-
-enum gpio_direction {
-	GPIO_DIRECTION_IN,
-	GPIO_DIRECTION_OUT,
-};
-
-struct gpio_regs {
-	u32 data;		/* offset 0x0 */
-	u32 reserved[0xff];	/* 0x4--0x3fc */
-	u32 dir;		/* offset 0x400 */
-};
-
-#endif	/* __ASM_ARCH_STV0991_GPIO_H */
diff --git a/arch/arm/include/asm/arch-stv0991/hardware.h b/arch/arm/include/asm/arch-stv0991/hardware.h
deleted file mode 100644
index ea8f8206300a..000000000000
--- a/arch/arm/include/asm/arch-stv0991/hardware.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef _ASM_ARCH_HARDWARE_H
-#define _ASM_ARCH_HARDWARE_H
-
-/* STV0991 */
-#define SRAM0_BASE_ADDR                          0x00000000UL
-#define SRAM1_BASE_ADDR                          0x00068000UL
-#define SRAM2_BASE_ADDR                          0x000D0000UL
-#define SRAM3_BASE_ADDR                          0x00138000UL
-#define CFS_SRAM0_BASE_ADDR                      0x00198000UL
-#define CFS_SRAM1_BASE_ADDR                      0x001B8000UL
-#define FAST_SRAM_BASE_ADDR                      0x001D8000UL
-#define FLASH_BASE_ADDR                          0x40000000UL
-#define PL310_BASE_ADDR                          0x70000000UL
-#define HSAXIM_BASE_ADDR                         0x70100000UL
-#define IMGSS_BASE_ADDR                          0x70200000UL
-#define ADC_BASE_ADDR                            0x80000000UL
-#define GPIOA_BASE_ADDR                          0x80001000UL
-#define GPIOB_BASE_ADDR                          0x80002000UL
-#define GPIOC_BASE_ADDR                          0x80003000UL
-#define HDM_BASE_ADDR                            0x80004000UL
-#define THSENS_BASE_ADDR                         0x80200000UL
-#define GPTIMER2_BASE_ADDR                       0x80201000UL
-#define GPTIMER1_BASE_ADDR                       0x80202000UL
-#define QSPI_BASE_ADDR                           0x80203000UL
-#define CGU_BASE_ADDR                            0x80204000UL
-#define CREG_BASE_ADDR                           0x80205000UL
-#define PEC_BASE_ADDR                            0x80206000UL
-#define WDRU_BASE_ADDR                           0x80207000UL
-#define BSEC_BASE_ADDR                           0x80208000UL
-#define DAP_ROM_BASE_ADDR                        0x80210000UL
-#define SOC_CTI_BASE_ADDR                        0x80211000UL
-#define TPIU_BASE_ADDR                           0x80212000UL
-#define TMC_ETF_BASE_ADDR                        0x80213000UL
-#define R4_ETM_BASE_ADDR                         0x80214000UL
-#define R4_CTI_BASE_ADDR                         0x80215000UL
-#define R4_DBG_BASE_ADDR                         0x80216000UL
-#define GMAC_BASE_ADDR                           0x80300000UL
-#define RNSS_BASE_ADDR                           0x80302000UL
-#define CRYP_BASE_ADDR                           0x80303000UL
-#define HASH_BASE_ADDR                           0x80304000UL
-#define GPDMA_BASE_ADDR                          0x80305000UL
-#define ISA_BASE_ADDR                            0x8032A000UL
-#define HCI_BASE_ADDR                            0x80400000UL
-#define I2C1_BASE_ADDR                           0x80401000UL
-#define I2C2_BASE_ADDR                           0x80402000UL
-#define SAI_BASE_ADDR                            0x80403000UL
-#define USI_BASE_ADDR                            0x80404000UL
-#define SPI1_BASE_ADDR                           0x80405000UL
-#define UART_BASE_ADDR                           0x80406000UL
-#define SPI2_BASE_ADDR                           0x80500000UL
-#define CAN_BASE_ADDR                            0x80501000UL
-#define USART1_BASE_ADDR                         0x80502000UL
-#define USART2_BASE_ADDR                         0x80503000UL
-#define USART3_BASE_ADDR                         0x80504000UL
-#define USART4_BASE_ADDR                         0x80505000UL
-#define USART5_BASE_ADDR                         0x80506000UL
-#define USART6_BASE_ADDR                         0x80507000UL
-#define SDI2_BASE_ADDR                           0x80600000UL
-#define SDI1_BASE_ADDR                           0x80601000UL
-#define VICA_BASE_ADDR                           0x81000000UL
-#define VICB_BASE_ADDR                           0x81001000UL
-#define STM_CHANNELS_BASE_ADDR                   0x81100000UL
-#define STM_BASE_ADDR                            0x81110000UL
-#define SROM_BASE_ADDR                           0xFFFF0000UL
-
-#endif /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/include/asm/arch-stv0991/stv0991_cgu.h b/arch/arm/include/asm/arch-stv0991/stv0991_cgu.h
deleted file mode 100644
index df9dd54e5a85..000000000000
--- a/arch/arm/include/asm/arch-stv0991/stv0991_cgu.h
+++ /dev/null
@@ -1,130 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef _STV0991_CGU_H
-#define _STV0991_CGU_H
-
-struct stv0991_cgu_regs {
-	u32 cpu_freq;		/* offset 0x0 */
-	u32 icn2_freq;		/* offset 0x4 */
-	u32 dma_freq;		/* offset 0x8 */
-	u32 isp_freq;		/* offset 0xc */
-	u32 h264_freq;		/* offset 0x10 */
-	u32 osif_freq;		/* offset 0x14 */
-	u32 ren_freq;		/* offset 0x18 */
-	u32 tim_freq;		/* offset 0x1c */
-	u32 sai_freq;		/* offset 0x20 */
-	u32 eth_freq;		/* offset 0x24 */
-	u32 i2c_freq;		/* offset 0x28 */
-	u32 spi_freq;		/* offset 0x2c */
-	u32 uart_freq;		/* offset 0x30 */
-	u32 qspi_freq;		/* offset 0x34 */
-	u32 sdio_freq;		/* offset 0x38 */
-	u32 usi_freq;		/* offset 0x3c */
-	u32 can_line_freq;	/* offset 0x40 */
-	u32 debug_freq;		/* offset 0x44 */
-	u32 trace_freq;		/* offset 0x48 */
-	u32 stm_freq;		/* offset 0x4c */
-	u32 eth_ctrl;		/* offset 0x50 */
-	u32 reserved[3];	/* offset 0x54 */
-	u32 osc_ctrl;		/* offset 0x60 */
-	u32 pll1_ctrl;		/* offset 0x64 */
-	u32 pll1_freq;		/* offset 0x68 */
-	u32 pll1_fract;		/* offset 0x6c */
-	u32 pll1_spread;	/* offset 0x70 */
-	u32 pll1_status;	/* offset 0x74 */
-	u32 pll2_ctrl;		/* offset 0x78 */
-	u32 pll2_freq;		/* offset 0x7c */
-	u32 pll2_fract;		/* offset 0x80 */
-	u32 pll2_spread;	/* offset 0x84 */
-	u32 pll2_status;	/* offset 0x88 */
-	u32 cgu_enable_1;	/* offset 0x8c */
-	u32 cgu_enable_2;	/* offset 0x90 */
-	u32 cgu_isp_pulse;	/* offset 0x94 */
-	u32 cgu_h264_pulse;	/* offset 0x98 */
-	u32 cgu_osif_pulse;	/* offset 0x9c */
-	u32 cgu_ren_pulse;	/* offset 0xa0 */
-
-};
-
-/* CGU Timer */
-#define CLK_TMR_OSC			0
-#define CLK_TMR_MCLK			1
-#define CLK_TMR_PLL1			2
-#define CLK_TMR_PLL2			3
-#define MDIV_SHIFT_TMR			3
-#define DIV_SHIFT_TMR			6
-
-#define TIMER1_CLK_CFG			(0 << DIV_SHIFT_TMR \
-					| 0 << MDIV_SHIFT_TMR | CLK_TMR_MCLK)
-
-/* Clock Enable/Disable */
-
-#define TIMER1_CLK_EN			(1 << 15)
-
-/* CGU Uart config */
-#define CLK_UART_MCLK			0
-#define CLK_UART_PLL1			1
-#define CLK_UART_PLL2			2
-
-#define MDIV_SHIFT_UART			3
-#define DIV_SHIFT_UART			6
-
-#define UART_CLK_CFG			(4 << DIV_SHIFT_UART \
-					| 1 << MDIV_SHIFT_UART | CLK_UART_MCLK)
-
-/* CGU Ethernet clock config */
-#define CLK_ETH_MCLK			0
-#define CLK_ETH_PLL1			1
-#define CLK_ETH_PLL2			2
-
-#define MDIV_SHIFT_ETH			3
-#define DIV_SHIFT_ETH			6
-#define DIV_ETH_125			9
-#define DIV_ETH_50			12
-#define DIV_ETH_P2P			15
-
-#define ETH_CLK_CFG			(4 << DIV_ETH_P2P | 4 << DIV_ETH_50 \
-					| 1 << DIV_ETH_125 \
-					| 0 << DIV_SHIFT_ETH \
-					| 3 << MDIV_SHIFT_ETH | CLK_ETH_PLL1)
- /* CGU Ethernet control */
-
-#define ETH_CLK_TX_EXT_PHY		0
-#define ETH_CLK_TX_125M			1
-#define ETH_CLK_TX_25M			2
-#define ETH_CLK_TX_2M5			3
-#define ETH_CLK_TX_DIS			7
-
-#define ETH_CLK_RX_EXT_PHY		0
-#define ETH_CLK_RX_25M			1
-#define ETH_CLK_RX_2M5			2
-#define ETH_CLK_RX_DIS			3
-#define RX_CLK_SHIFT			3
-#define ETH_CLK_MASK			~(0x1F)
-
-#define ETH_PHY_MODE_GMII		0
-#define ETH_PHY_MODE_RMII		1
-#define ETH_PHY_CLK_DIS			1
-
-#define ETH_CLK_CTRL			(ETH_CLK_RX_EXT_PHY << RX_CLK_SHIFT \
-					| ETH_CLK_TX_EXT_PHY)
-/* CGU qspi clock */
-#define DIV_HCLK1_SHIFT			9
-#define DIV_CRYP_SHIFT			6
-#define MDIV_QSPI_SHIFT			3
-
-#define CLK_QSPI_OSC			0
-#define CLK_QSPI_MCLK			1
-#define CLK_QSPI_PLL1			2
-#define CLK_QSPI_PLL2			3
-
-#define QSPI_CLK_CTRL			(3 << DIV_HCLK1_SHIFT \
-					| 1 << DIV_CRYP_SHIFT \
-					| 0 << MDIV_QSPI_SHIFT \
-					| CLK_QSPI_OSC)
-
-#endif
diff --git a/arch/arm/include/asm/arch-stv0991/stv0991_creg.h b/arch/arm/include/asm/arch-stv0991/stv0991_creg.h
deleted file mode 100644
index 4d444a6df16c..000000000000
--- a/arch/arm/include/asm/arch-stv0991/stv0991_creg.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef _STV0991_CREG_H
-#define _STV0991_CREG_H
-
-struct stv0991_creg {
-	u32 version;		/* offset 0x0 */
-	u32 hdpctl;		/* offset 0x4 */
-	u32 hdpval;		/* offset 0x8 */
-	u32 hdpgposet;		/* offset 0xc */
-	u32 hdpgpoclr;		/* offset 0x10 */
-	u32 hdpgpoval;		/* offset 0x14 */
-	u32 stm_mux;		/* offset 0x18 */
-	u32 sysctrl_1;		/* offset 0x1c */
-	u32 sysctrl_2;		/* offset 0x20 */
-	u32 sysctrl_3;		/* offset 0x24 */
-	u32 sysctrl_4;		/* offset 0x28 */
-	u32 reserved_1[0x35];	/* offset 0x2C-0xFC */
-	u32 mux1;		/* offset 0x100 */
-	u32 mux2;		/* offset 0x104 */
-	u32 mux3;		/* offset 0x108 */
-	u32 mux4;		/* offset 0x10c */
-	u32 mux5;		/* offset 0x110 */
-	u32 mux6;		/* offset 0x114 */
-	u32 mux7;		/* offset 0x118 */
-	u32 mux8;		/* offset 0x11c */
-	u32 mux9;		/* offset 0x120 */
-	u32 mux10;		/* offset 0x124 */
-	u32 mux11;		/* offset 0x128 */
-	u32 mux12;		/* offset 0x12c */
-	u32 mux13;		/* offset 0x130 */
-	u32 reserved_2[0x33];	/* offset 0x134-0x1FC */
-	u32 cfg_pad1;		/* offset 0x200 */
-	u32 cfg_pad2;		/* offset 0x204 */
-	u32 cfg_pad3;		/* offset 0x208 */
-	u32 cfg_pad4;		/* offset 0x20c */
-	u32 cfg_pad5;		/* offset 0x210 */
-	u32 cfg_pad6;		/* offset 0x214 */
-	u32 cfg_pad7;		/* offset 0x218 */
-	u32 reserved_3[0x39];	/* offset 0x21C-0x2FC */
-	u32 vdd_pad1;		/* offset 0x300 */
-	u32 vdd_pad2;		/* offset 0x304 */
-	u32 reserved_4[0x3e];	/* offset 0x308-0x3FC */
-	u32 vdd_comp1;		/* offset 0x400 */
-};
-
-/* CREG MUX 13 register */
-#define FLASH_CS_NC_SHIFT	4
-#define FLASH_CS_NC_MASK	~(7 << FLASH_CS_NC_SHIFT)
-#define CFG_FLASH_CS_NC		(0 << FLASH_CS_NC_SHIFT)
-
-#define FLASH_CLK_SHIFT		0
-#define FLASH_CLK_MASK		~(7 << FLASH_CLK_SHIFT)
-#define CFG_FLASH_CLK		(0 << FLASH_CLK_SHIFT)
-
-/* CREG MUX 12 register */
-#define GPIOC_30_MUX_SHIFT	24
-#define GPIOC_30_MUX_MASK	~(1 << GPIOC_30_MUX_SHIFT)
-#define CFG_GPIOC_30_UART_TX	(1 << GPIOC_30_MUX_SHIFT)
-
-#define GPIOC_31_MUX_SHIFT	28
-#define GPIOC_31_MUX_MASK	~(1 << GPIOC_31_MUX_SHIFT)
-#define CFG_GPIOC_31_UART_RX	(1 << GPIOC_31_MUX_SHIFT)
-
-/* CREG MUX 7 register */
-#define GPIOB_16_MUX_SHIFT	0
-#define GPIOB_16_MUX_MASK	~(1 << GPIOB_16_MUX_SHIFT)
-#define CFG_GPIOB_16_UART_TX	(1 << GPIOB_16_MUX_SHIFT)
-
-#define GPIOB_17_MUX_SHIFT	4
-#define GPIOB_17_MUX_MASK	~(1 << GPIOB_17_MUX_SHIFT)
-#define CFG_GPIOB_17_UART_RX	(1 << GPIOB_17_MUX_SHIFT)
-
-/* CREG CFG_PAD6 register */
-
-#define GPIOC_31_MODE_SHIFT	30
-#define GPIOC_31_MODE_MASK	~(1 << GPIOC_31_MODE_SHIFT)
-#define CFG_GPIOC_31_MODE_OD	(0 << GPIOC_31_MODE_SHIFT)
-#define CFG_GPIOC_31_MODE_PP	(1 << GPIOC_31_MODE_SHIFT)
-
-#define GPIOC_30_MODE_SHIFT	28
-#define GPIOC_30_MODE_MASK	~(1 << GPIOC_30_MODE_SHIFT)
-#define CFG_GPIOC_30_MODE_LOW	(0 << GPIOC_30_MODE_SHIFT)
-#define CFG_GPIOC_30_MODE_HIGH	(1 << GPIOC_30_MODE_SHIFT)
-
-/* CREG Ethernet pad config */
-
-#define VDD_ETH_PS_1V8		0
-#define VDD_ETH_PS_2V5		2
-#define VDD_ETH_PS_3V3		3
-#define VDD_ETH_PS_MASK		0x3
-
-#define VDD_ETH_PS_SHIFT	12
-#define ETH_VDD_CFG		(VDD_ETH_PS_1V8 << VDD_ETH_PS_SHIFT)
-
-#define VDD_ETH_M_PS_SHIFT	28
-#define ETH_M_VDD_CFG		(VDD_ETH_PS_1V8 << VDD_ETH_M_PS_SHIFT)
-
-#endif
diff --git a/arch/arm/include/asm/arch-stv0991/stv0991_defs.h b/arch/arm/include/asm/arch-stv0991/stv0991_defs.h
deleted file mode 100644
index 98d7cde85bc2..000000000000
--- a/arch/arm/include/asm/arch-stv0991/stv0991_defs.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef __STV0991_DEFS_H__
-#define __STV0991_DEFS_H__
-#include <asm/arch/stv0991_periph.h>
-
-extern int stv0991_pinmux_config(enum periph_id);
-extern int clock_setup(enum periph_clock);
-
-#endif
diff --git a/arch/arm/include/asm/arch-stv0991/stv0991_gpt.h b/arch/arm/include/asm/arch-stv0991/stv0991_gpt.h
deleted file mode 100644
index eb1ddca60028..000000000000
--- a/arch/arm/include/asm/arch-stv0991/stv0991_gpt.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef _STV0991_GPT_H
-#define _STV0991_GPT_H
-
-#include <asm/arch-stv0991/hardware.h>
-
-struct gpt_regs {
-	u32 cr1;
-	u32 cr2;
-	u32 reserved_1;
-	u32 dier;	/* dma_int_en */
-	u32 sr;		/* status reg */
-	u32 egr;	/* event gen */
-	u32 reserved_2[3];	/* offset 0x18--0x20*/
-	u32 cnt;
-	u32 psc;
-	u32 arr;
-};
-
-struct gpt_regs *const gpt1_regs_ptr =
-	(struct gpt_regs *) GPTIMER1_BASE_ADDR;
-
-/* Timer control1 register  */
-#define GPT_CR1_CEN			0x0001
-#define GPT_MODE_AUTO_RELOAD		(1 << 7)
-
-/* Timer prescalar reg */
-#define GPT_PRESCALER_128		0x128
-
-/* Auto reload register for free running config */
-#define GPT_FREE_RUNNING		0xFFFF
-
-/* Timer, HZ specific defines */
-#define CFG_SYS_HZ_CLOCK		((27 * 1000 * 1000) / GPT_PRESCALER_128)
-
-#endif
diff --git a/arch/arm/include/asm/arch-stv0991/stv0991_periph.h b/arch/arm/include/asm/arch-stv0991/stv0991_periph.h
deleted file mode 100644
index 7a50be183d41..000000000000
--- a/arch/arm/include/asm/arch-stv0991/stv0991_periph.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef __ASM_ARM_ARCH_PERIPH_H
-#define __ASM_ARM_ARCH_PERIPH_H
-
-/*
- * Peripherals required for pinmux configuration. List will
- * grow with support for more devices getting added.
- * Numbering based on interrupt table.
- *
- */
-enum periph_id {
-	UART_GPIOC_30_31 = 0,
-	UART_GPIOB_16_17,
-	ETH_GPIOB_10_31_C_0_4,
-	QSPI_CS_CLK_PAD,
-	PERIPH_ID_I2C0,
-	PERIPH_ID_I2C1,
-	PERIPH_ID_I2C2,
-	PERIPH_ID_I2C3,
-	PERIPH_ID_I2C4,
-	PERIPH_ID_I2C5,
-	PERIPH_ID_I2C6,
-	PERIPH_ID_I2C7,
-	PERIPH_ID_SPI0,
-	PERIPH_ID_SPI1,
-	PERIPH_ID_SPI2,
-	PERIPH_ID_SDMMC0,
-	PERIPH_ID_SDMMC1,
-	PERIPH_ID_SDMMC2,
-	PERIPH_ID_SDMMC3,
-	PERIPH_ID_I2S1,
-};
-
-enum periph_clock {
-	UART_CLOCK_CFG = 0,
-	ETH_CLOCK_CFG,
-	QSPI_CLOCK_CFG,
-};
-
-#endif /* __ASM_ARM_ARCH_PERIPH_H */
diff --git a/arch/arm/include/asm/arch-stv0991/stv0991_wdru.h b/arch/arm/include/asm/arch-stv0991/stv0991_wdru.h
deleted file mode 100644
index 8cb8a8a61375..000000000000
--- a/arch/arm/include/asm/arch-stv0991/stv0991_wdru.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef _STV0991_WD_RST_H
-#define _STV0991_WD_RST_H
-#include <asm/arch-stv0991/hardware.h>
-
-struct stv0991_wd_ru {
-	u32 wdru_config;
-	u32 wdru_ctrl1;
-	u32 wdru_ctrl2;
-	u32 wdru_tim;
-	u32 wdru_count;
-	u32 wdru_stat;
-	u32 wdru_wrlock;
-};
-
-struct stv0991_wd_ru *const stv0991_wd_ru_ptr = \
-		(struct stv0991_wd_ru *)WDRU_BASE_ADDR;
-
-/* Watchdog control register */
-#define WDRU_RST_SYS		0x1
-
-#endif
diff --git a/board/st/stv0991/Kconfig b/board/st/stv0991/Kconfig
deleted file mode 100644
index 007712f9c61d..000000000000
--- a/board/st/stv0991/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_STV0991
-
-config SYS_BOARD
-	default "stv0991"
-
-config SYS_VENDOR
-	default "st"
-
-config SYS_SOC
-	default "stv0991"
-
-config SYS_CONFIG_NAME
-	default "stv0991"
-
-endif
diff --git a/board/st/stv0991/MAINTAINERS b/board/st/stv0991/MAINTAINERS
deleted file mode 100644
index e7a2ccaa1f2d..000000000000
--- a/board/st/stv0991/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-STV0991 APPLICATION BOARD
-M:	Vikas Manocha <vikas.manocha@st.com>
-S:	Maintained
-F:	board/st/stv0991/
-F:	include/configs/stv0991.h
-F:	configs/stv0991_defconfig
diff --git a/board/st/stv0991/Makefile b/board/st/stv0991/Makefile
deleted file mode 100644
index 7f6d719c3227..000000000000
--- a/board/st/stv0991/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2014, STMicroelectronics - All Rights Reserved
-# Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
-
-obj-y	:= stv0991.o
diff --git a/board/st/stv0991/stv0991.c b/board/st/stv0991/stv0991.c
deleted file mode 100644
index 57ca9f659c16..000000000000
--- a/board/st/stv0991/stv0991.c
+++ /dev/null
@@ -1,119 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#include <common.h>
-#include <bootstage.h>
-#include <dm.h>
-#include <init.h>
-#include <miiphy.h>
-#include <net.h>
-#include <asm/arch/stv0991_periph.h>
-#include <asm/arch/stv0991_defs.h>
-#include <asm/arch/hardware.h>
-#include <asm/arch/gpio.h>
-#include <netdev.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <dm/platform_data/serial_pl01x.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-struct gpio_regs *const gpioa_regs =
-		(struct gpio_regs *) GPIOA_BASE_ADDR;
-
-#ifndef CONFIG_OF_CONTROL
-static const struct pl01x_serial_plat serial_plat = {
-	.base = 0x80406000,
-	.type = TYPE_PL011,
-	.clock = 2700 * 1000,
-};
-
-U_BOOT_DRVINFO(stv09911_serials) = {
-	.name = "serial_pl01x",
-	.plat = &serial_plat,
-};
-#endif
-
-#if CONFIG_IS_ENABLED(BOOTSTAGE)
-void show_boot_progress(int progress)
-{
-	printf("%i\n", progress);
-}
-#endif
-
-void enable_eth_phy(void)
-{
-	/* Set GPIOA_06 pad HIGH (Appli board)*/
-	writel(readl(&gpioa_regs->dir) | 0x40, &gpioa_regs->dir);
-	writel(readl(&gpioa_regs->data) | 0x40, &gpioa_regs->data);
-}
-int board_eth_enable(void)
-{
-	stv0991_pinmux_config(ETH_GPIOB_10_31_C_0_4);
-	clock_setup(ETH_CLOCK_CFG);
-	enable_eth_phy();
-	return 0;
-}
-
-int board_qspi_enable(void)
-{
-	stv0991_pinmux_config(QSPI_CS_CLK_PAD);
-	clock_setup(QSPI_CLOCK_CFG);
-	return 0;
-}
-
-/*
- * Miscellaneous platform dependent initialisations
- */
-int board_init(void)
-{
-	board_eth_enable();
-	board_qspi_enable();
-	return 0;
-}
-
-int board_uart_init(void)
-{
-	stv0991_pinmux_config(UART_GPIOC_30_31);
-	clock_setup(UART_CLOCK_CFG);
-	return 0;
-}
-
-#ifdef CONFIG_BOARD_EARLY_INIT_F
-int board_early_init_f(void)
-{
-	board_uart_init();
-	return 0;
-}
-#endif
-
-int dram_init(void)
-{
-	gd->ram_size = PHYS_SDRAM_1_SIZE;
-	return 0;
-}
-
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
-
-	return 0;
-}
-
-#ifdef CONFIG_CMD_NET
-int board_eth_init(struct bd_info *bis)
-{
-	int ret = 0;
-
-#if defined(CONFIG_ETH_DESIGNWARE)
-	u32 interface = PHY_INTERFACE_MODE_MII;
-	if (designware_initialize(GMAC_BASE_ADDR, interface) >= 0)
-		ret++;
-#endif
-	return ret;
-}
-#endif
diff --git a/configs/stv0991_defconfig b/configs/stv0991_defconfig
deleted file mode 100644
index e70db42d7420..000000000000
--- a/configs/stv0991_defconfig
+++ /dev/null
@@ -1,44 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_DCACHE_OFF=y
-CONFIG_TARGET_STV0991=y
-CONFIG_TEXT_BASE=0x00010000
-CONFIG_SYS_MALLOC_LEN=0x14000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x30000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="stv0991"
-CONFIG_SYS_LOAD_ADDR=0x0
-CONFIG_ENV_ADDR=0x188000
-CONFIG_SYS_MEMTEST_START=0x00000000
-CONFIG_SYS_MEMTEST_END=0x00100000
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
-CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="go 0x40040000"
-CONFIG_SYS_PBSIZE=1050
-# CONFIG_DISPLAY_CPUINFO is not set
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_SYS_PROMPT="STV0991> "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_SPI=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_PING=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-# CONFIG_MMC is not set
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ8XXX=y
-CONFIG_PHY_RESET_DELAY=10000
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_DW_ALTDESCRIPTOR=y
-CONFIG_MII=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_HAS_CQSPI_REF_CLK=y
-CONFIG_CQSPI_REF_CLK=3000000
diff --git a/include/configs/stv0991.h b/include/configs/stv0991.h
deleted file mode 100644
index 7eadb6d421e5..000000000000
--- a/include/configs/stv0991.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, STMicroelectronics - All Rights Reserved
- * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
- */
-
-#ifndef __CONFIG_STV0991_H
-#define __CONFIG_STV0991_H
-#define CFG_SYS_EXCEPTION_VECTORS_HIGH
-
-/* ram memory-related information */
-#define PHYS_SDRAM_1				0x00000000
-#define CFG_SYS_SDRAM_BASE			PHYS_SDRAM_1
-#define PHYS_SDRAM_1_SIZE			0x00198000
-
-/* user interface */
-
-/* MISC */
-#define CFG_SYS_INIT_RAM_SIZE		0x8000
-#define CFG_SYS_INIT_RAM_ADDR		0x00190000
-/* U-Boot Load Address */
-
-/* Misc configuration */
-
-#endif /* __CONFIG_H */
-- 
2.34.1

