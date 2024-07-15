Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2581AC3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 19:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F0988898;
	Mon, 15 Jul 2024 21:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FF/oIs4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA562888CC; Mon, 15 Jul 2024 21:36:04 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DE58888F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 21:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7035b717880so2832883a34.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721072161; x=1721676961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxVh37p70MKsFa6rS1cWTEPb4NmVhUOAcEfqKkLGbcE=;
 b=FF/oIs4nZrYubKRAWXt9KpmJGNFocxlpPKKpSW5kRP8nIzfLOK1bNMGwQ+6mqc/Pg0
 GdBXMC9Ryd1ldcs0bTTESDl1G3uoGUvetGIcVdQaIhQWCQgS4QdQyttm560WbARoExcS
 OBSBKKDZ2wgP68Px5hck1bCRLjYpmbAZOgFWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721072161; x=1721676961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxVh37p70MKsFa6rS1cWTEPb4NmVhUOAcEfqKkLGbcE=;
 b=DsQGmORIwp3hpcYpdCVEMPp11cN3dBJ/lrsvxOxmytE8YSt1NaABbrD45xcCUmzB4S
 R0Jfz+yj0s6tRqxhhtRX3V+n8nqcXuD1n9qgCJ9+mLY5RC3Z6yrEI5LfrOgdefdnv0b7
 pheehH4cbYjrFQ+ssvq/yKxoBYDHBAiJp4+P3wX4tZDH1lIQ0A9TRM5UxESfB02VEuqZ
 p4Ra5G9VnXAcARgm8V7MLvmQ1NW/qb5VSHGt8JicY38Vv8K7OxJXVJzWssFITuaU+Ha1
 gD053bRSwxCS53BVtSUzaF4Ng5dOIRAVo5ABAz4Ko8bm9Pf4nHEDjbGaDGGqwKlfqhPM
 HIkQ==
X-Gm-Message-State: AOJu0YzTa7I+sOZnA8tJ2RUCFJ8lXxdjY6Au42pv3qaMOQsAtXhYUDZm
 iE9CXxxP5pmqEMyqldmJhEOdAml+TW3aMlJtAVS0ARiag2kvd9E386AT8iHuF8waAIXuW+WjAJJ
 N
X-Google-Smtp-Source: AGHT+IFpUTKXJ6vyYYXhuzqRMzU4EpLJFh6aI81w9MLRkxTtUCb7B5RUWqAajNqdO6lInikFfbaf8g==
X-Received: by 2002:a05:6870:4153:b0:260:2571:2782 with SMTP id
 586e51a60fabf-260b5f980ccmr345567fac.2.1721072160668; 
 Mon, 15 Jul 2024 12:36:00 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260752a6059sm1084531fac.37.2024.07.15.12.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 12:36:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 4/5] arm: Remove devkit3250 board
Date: Mon, 15 Jul 2024 13:35:54 -0600
Message-Id: <20240715193555.564528-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715193555.564528-1-trini@konsulko.com>
References: <20240715193555.564528-1-trini@konsulko.com>
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

This board has not been converted to CONFIG_DM_I2C by the deadline.
Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-lpc32xx/Kconfig           |  4 --
 board/timll/devkit3250/Kconfig          | 12 ----
 board/timll/devkit3250/MAINTAINERS      |  6 --
 board/timll/devkit3250/Makefile         |  7 --
 board/timll/devkit3250/devkit3250.c     | 83 ----------------------
 board/timll/devkit3250/devkit3250_spl.c | 66 -----------------
 configs/devkit3250_defconfig            | 93 ------------------------
 include/configs/devkit3250.h            | 94 -------------------------
 8 files changed, 365 deletions(-)
 delete mode 100644 board/timll/devkit3250/Kconfig
 delete mode 100644 board/timll/devkit3250/MAINTAINERS
 delete mode 100644 board/timll/devkit3250/Makefile
 delete mode 100644 board/timll/devkit3250/devkit3250.c
 delete mode 100644 board/timll/devkit3250/devkit3250_spl.c
 delete mode 100644 configs/devkit3250_defconfig
 delete mode 100644 include/configs/devkit3250.h

diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
index 185bda41c224..f34c6728f420 100644
--- a/arch/arm/mach-lpc32xx/Kconfig
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -6,9 +6,6 @@ config SYS_SOC
 choice
 	prompt "NXP LPC32xx board select"
 
-config TARGET_DEVKIT3250
-	bool "Timll DevKit3250"
-
 config TARGET_WORK_92105
 	bool "Work Microwave Work_92105"
 
@@ -17,7 +14,6 @@ config TARGET_EA_LPC3250DEVKITV2
 
 endchoice
 
-source "board/timll/devkit3250/Kconfig"
 source "board/work-microwave/work_92105/Kconfig"
 source "board/ea/ea-lpc3250devkitv2/Kconfig"
 
diff --git a/board/timll/devkit3250/Kconfig b/board/timll/devkit3250/Kconfig
deleted file mode 100644
index 5129c2dcae54..000000000000
--- a/board/timll/devkit3250/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-if TARGET_DEVKIT3250
-
-config SYS_BOARD
-	default "devkit3250"
-
-config SYS_VENDOR
-	default "timll"
-
-config SYS_CONFIG_NAME
-	default "devkit3250"
-
-endif
diff --git a/board/timll/devkit3250/MAINTAINERS b/board/timll/devkit3250/MAINTAINERS
deleted file mode 100644
index cb93563feda5..000000000000
--- a/board/timll/devkit3250/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-DEVKIT3250 BOARD
-M:	Vladimir Zapolskiy <vz@mleia.com>
-S:	Maintained
-F:	board/timll/devkit3250/
-F:	include/configs/devkit3250.h
-F:	configs/devkit3250_defconfig
diff --git a/board/timll/devkit3250/Makefile b/board/timll/devkit3250/Makefile
deleted file mode 100644
index 056813995eb8..000000000000
--- a/board/timll/devkit3250/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2011 by Vladimir Zapolskiy <vz@mleia.com>
-# Copyright (C) 2008, Guennadi Liakhovetski <lg@denx.de>
-
-obj-y	:= devkit3250.o
-obj-$(CONFIG_SPL_BUILD) += devkit3250_spl.o
diff --git a/board/timll/devkit3250/devkit3250.c b/board/timll/devkit3250/devkit3250.c
deleted file mode 100644
index f0c0f03deeb8..000000000000
--- a/board/timll/devkit3250/devkit3250.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Embest/Timll DevKit3250 board support
- *
- * Copyright (C) 2011-2015 Vladimir Zapolskiy <vz@mleia.com>
- */
-
-#include <config.h>
-#include <init.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch/clk.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/emc.h>
-#include <asm/arch/wdt.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <linux/delay.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static struct emc_regs *emc = (struct emc_regs *)EMC_BASE;
-static struct clk_pm_regs *clk = (struct clk_pm_regs *)CLK_PM_BASE;
-static struct wdt_regs *wdt = (struct wdt_regs *)WDT_BASE;
-
-void reset_periph(void)
-{
-	/* This function resets peripherals by triggering RESOUT_N */
-	setbits_le32(&clk->timclk_ctrl, CLK_TIMCLK_WATCHDOG);
-	writel(WDTIM_MCTRL_RESFRC1, &wdt->mctrl);
-	udelay(300);
-
-	writel(0, &wdt->mctrl);
-	clrbits_le32(&clk->timclk_ctrl, CLK_TIMCLK_WATCHDOG);
-
-	/* Such a long delay is needed to initialize SMSC phy */
-	udelay(10000);
-}
-
-int board_early_init_f(void)
-{
-	lpc32xx_uart_init(CONFIG_CONS_INDEX);
-	lpc32xx_i2c_init(1);
-	lpc32xx_i2c_init(2);
-	lpc32xx_ssp_init();
-	lpc32xx_mac_init();
-
-	/*
-	 * nWP may be controlled by GPO19, but unpopulated by default R23
-	 * makes no sense to configure this GPIO level, nWP is always high
-	 */
-	lpc32xx_slc_nand_init();
-
-	return 0;
-}
-
-int board_init(void)
-{
-	/* adress of boot parameters */
-	gd->bd->bi_boot_params  = CFG_SYS_SDRAM_BASE + 0x100;
-
-#ifdef CONFIG_SYS_FLASH_CFI
-	/* Use 16-bit memory interface for NOR Flash */
-	emc->stat[0].config	= EMC_STAT_CONFIG_PB | EMC_STAT_CONFIG_16BIT;
-
-	/* Change the NOR timings to optimum value to get maximum bandwidth */
-	emc->stat[0].waitwen	= EMC_STAT_WAITWEN(1);
-	emc->stat[0].waitoen	= EMC_STAT_WAITOEN(0);
-	emc->stat[0].waitrd	= EMC_STAT_WAITRD(12);
-	emc->stat[0].waitpage	= EMC_STAT_WAITPAGE(12);
-	emc->stat[0].waitwr	= EMC_STAT_WAITWR(5);
-	emc->stat[0].waitturn	= EMC_STAT_WAITTURN(2);
-#endif
-
-	return 0;
-}
-
-int dram_init(void)
-{
-	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE,
-				    CFG_SYS_SDRAM_SIZE);
-
-	return 0;
-}
diff --git a/board/timll/devkit3250/devkit3250_spl.c b/board/timll/devkit3250/devkit3250_spl.c
deleted file mode 100644
index 07a367c3ad15..000000000000
--- a/board/timll/devkit3250/devkit3250_spl.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Timll DevKit3250 board support, SPL board configuration
- *
- * (C) Copyright 2015 Vladimir Zapolskiy <vz@mleia.com>
- */
-
-#include <asm/io.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch/cpu.h>
-#include <asm/arch/emc.h>
-#include <asm/arch-lpc32xx/gpio.h>
-#include <spl.h>
-
-static struct gpio_regs *gpio = (struct gpio_regs *)GPIO_BASE;
-
-/*
- * SDRAM K4S561632N-LC60 settings are selected in assumption that
- * SDRAM clock may be set up to 166 MHz, however at the moment
- * it is 104 MHz. Most delay values are converted to be a multiple of
- * base clock, and precise pinned values are not needed here.
- */
-struct emc_dram_settings dram_64mb = {
-	.cmddelay	= 0x0001C000,
-	.config0	= 0x00005682,
-	.rascas0	= 0x00000302,
-	.rdconfig	= 0x00000011,	/* undocumented but crucial value */
-
-	.trp	= 83333333,
-	.tras	= 23809524,
-	.tsrex	= 12500000,
-	.twr	= 83000000,		/* tWR = tRDL = 2 CLK */
-	.trc	= 15384616,
-	.trfc	= 15384616,
-	.txsr	= 12500000,
-	.trrd	= 1,
-	.tmrd	= 1,
-	.tcdlr	= 0,
-
-	.refresh	= 130000,	/* 800 clock cycles */
-
-	.mode	= 0x00018000,
-	.emode	= 0x02000000,
-};
-
-void spl_board_init(void)
-{
-	/* First of all silence buzzer controlled by GPO_20 */
-	writel((1 << 20), &gpio->p3_outp_clr);
-
-	lpc32xx_uart_init(CONFIG_CONS_INDEX);
-	preloader_console_init();
-
-	ddr_init(&dram_64mb);
-
-	/*
-	 * NAND initialization is done by nand_init(),
-	 * here just enable NAND SLC clocks
-	 */
-	lpc32xx_slc_nand_init();
-}
-
-u32 spl_boot_device(void)
-{
-	return BOOT_DEVICE_NAND;
-}
diff --git a/configs/devkit3250_defconfig b/configs/devkit3250_defconfig
deleted file mode 100644
index 569b156c9970..000000000000
--- a/configs/devkit3250_defconfig
+++ /dev/null
@@ -1,93 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_SYS_ICACHE_OFF=y
-CONFIG_SYS_DCACHE_OFF=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_LPC32XX=y
-CONFIG_TEXT_BASE=0x83F00000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SYS_MALLOC_F_LEN=0x400
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80000f20
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0xA0000
-CONFIG_SPL_TEXT_BASE=0x00000000
-CONFIG_SYS_MONITOR_LEN=393216
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_STACK=0xfff8
-CONFIG_SPL=y
-CONFIG_SYS_LOAD_ADDR=0x80008000
-CONFIG_BOOTDELAY=1
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200n8"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="dhcp; tftp ${loadaddr} ${serverip}:${tftpdir}/${bootfile}; tftp ${dtbaddr} ${serverip}:${tftpdir}/devkit3250.dtb; setenv nfsargs ip=dhcp root=/dev/nfs nfsroot=${serverip}:${nfsroot},tcp; setenv bootargs ${bootargs} ${nfsargs} ${userargs}; bootm ${loadaddr} - ${dtbaddr}"
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_NO_BSS_LIMIT=y
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_NAND_RAW_ONLY=y
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
-CONFIG_SPL_NAND_SOFTECC=y
-CONFIG_SPL_NAND_SIMPLE=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_NAND=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
-CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_VERSION_VARIABLE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
-CONFIG_DMA_LPC32XX=y
-CONFIG_LPC32XX_GPIO=y
-CONFIG_SYS_I2C_LEGACY=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_SYS_I2C_LPC32XX=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_PROTECTION=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=71
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_USE_FLASH_BBT=y
-CONFIG_NAND_LPC32XX_SLC=y
-CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-# CONFIG_SYS_NAND_5_ADDR_CYCLE is not set
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x40000
-CONFIG_PHYLIB=y
-CONFIG_PHY_ADDR_ENABLE=y
-CONFIG_PHY_ADDR=31
-CONFIG_PHY_SMSC=y
-CONFIG_RMII=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_CONS_INDEX=5
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_USB=y
-CONFIG_SYS_USB_OHCI_SLOT_NAME="lpc32xx-ohci"
-CONFIG_USB_OHCI_LPC32XX=y
-CONFIG_OF_LIBFDT=y
diff --git a/include/configs/devkit3250.h b/include/configs/devkit3250.h
deleted file mode 100644
index d85aeaafe519..000000000000
--- a/include/configs/devkit3250.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Embest/Timll DevKit3250 board configuration file
- *
- * Copyright (C) 2011-2015 Vladimir Zapolskiy <vz@mleia.com>
- */
-
-#ifndef __CONFIG_DEVKIT3250_H__
-#define __CONFIG_DEVKIT3250_H__
-
-/* SoC and board defines */
-#include <linux/sizes.h>
-#include <asm/arch/cpu.h>
-
-/*
- * Memory configurations
- */
-#define CFG_SYS_SDRAM_BASE		EMC_DYCS0_BASE
-#define CFG_SYS_SDRAM_SIZE		SZ_64M
-
-/*
- * DMA
- */
-
-/*
- * GPIO
- */
-
-/*
- * NOR Flash
- */
-#define CFG_SYS_FLASH_BASE		EMC_CS0_BASE
-#define CFG_SYS_FLASH_SIZE		SZ_4M
-
-/*
- * NAND controller
- */
-#define CFG_SYS_NAND_BASE		SLC_NAND_BASE
-#define CFG_SYS_NAND_BASE_LIST	{ CFG_SYS_NAND_BASE }
-
-/*
- * NAND chip timings
- */
-#define CFG_LPC32XX_NAND_SLC_WDR_CLKS	14
-#define CFG_LPC32XX_NAND_SLC_WWIDTH		66666666
-#define CFG_LPC32XX_NAND_SLC_WHOLD		200000000
-#define CFG_LPC32XX_NAND_SLC_WSETUP		50000000
-#define CFG_LPC32XX_NAND_SLC_RDR_CLKS	14
-#define CFG_LPC32XX_NAND_SLC_RWIDTH		66666666
-#define CFG_LPC32XX_NAND_SLC_RHOLD		200000000
-#define CFG_LPC32XX_NAND_SLC_RSETUP		50000000
-
-/*
- * USB
- */
-#define CFG_USB_ISP1301_I2C_ADDR		0x2d
-
-/*
- * U-Boot General Configurations
- */
-
-/*
- * Pass open firmware flat tree
- */
-
-/*
- * Environment
- */
-
-#define CFG_EXTRA_ENV_SETTINGS		\
-	"ethaddr=00:01:90:00:C0:81\0"		\
-	"dtbaddr=0x81000000\0"			\
-	"nfsroot=/opt/projects/images/vladimir/oe/devkit3250/rootfs\0"	\
-	"tftpdir=vladimir/oe/devkit3250\0"	\
-	"userargs=oops=panic\0"
-
-/*
- * U-Boot Commands
- */
-
-/* U-Boot will be 0x60000 bytes, loaded and run at CONFIG_TEXT_BASE */
-#define CFG_SYS_NAND_U_BOOT_SIZE	0x60000
-
-#define CFG_SYS_NAND_U_BOOT_START	CONFIG_TEXT_BASE
-#define CFG_SYS_NAND_U_BOOT_DST	CONFIG_TEXT_BASE
-
-/* See common/spl/spl.c  spl_set_header_raw_uboot() */
-
-/*
- * Include SoC specific configuration
- */
-#include <asm/arch/config.h>
-
-#endif  /* __CONFIG_DEVKIT3250_H__*/
-- 
2.34.1

