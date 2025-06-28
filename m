Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F3EC7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3215D82E52;
	Sat, 28 Jun 2025 14:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7393A82DA1; Sat, 28 Jun 2025 10:36:23 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE5682B34
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 10:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4a745fc9bafso45740601cf.1
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 01:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751099776; x=1751704576;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8OIhD8PwGM6DuXe5LQGg2ePwJ3ZLQZNFc+1pWUSU44=;
 b=G0AB7rkOcvc75zvU64O5KDzPjAN8EJ9e6AQaSQ3L8MHNNDrPwhZWjd2Sps4NSB2kBK
 ZDAA4I0vu2/b2tmqUQqu0fxKxy0ysCmHMD2qEgNhoQDHbGS567Cbr1IxMCe/FBrjYyNE
 WdpSdgYyD+m3FF1qZSsBcSc5wMmKi2miSjss+goKgtDqghI9f2nOuOHjg1KjLC73QgPA
 U+aCY3QeoSaGLxSYwHA2AVi+WuVktOI9jWlc3C0k8vu1TbeiPea9OTZMGbJwbsX3P3CJ
 p52i445YdW+hx36bFp4qMDbuhwKBEAwx/X8abCzQkz+ADLjEzhJHbiSUx65pWfByld3I
 le9A==
X-Gm-Message-State: AOJu0Yzuyt00GDCElZdRdlg9yl71dhPYe+LRKMgzxP0mTp2Ife5fFNXo
 wldAgtfuLINJHjfIlG0IcwdCCONMU0jqBw6h7rR+EpX8Jw4RlqEmcE6sGD3jlKLJNoQ=
X-Gm-Gg: ASbGnctH07sQTsaxOBWU1p3RRhpseYeya8mboY1B2J0oQT1ecVNiZBGw+nMv+ARzCfF
 hyGe5kj1vBlk8HiOoR/9X8P3/Ck8kPaqmNvLaxLm6UqIRH+U7VgRNuzTmk+16lY4itZO2YsTGbA
 o+Jmj8rjj6Slk/eK0hfSfm3g2ltF0dWtIGf37d/MPUCarNzCw9dpG+ngnqgNBXhwlER6aEguOKU
 fo8JX0WuH3Od+V1XFYeNrRyTgsKh/a4ign2snj330Rarex/4YyKzrU6kRoyASIpqBLl2nP0+kmx
 wJ12u6RqJuF56wkBemrE5zb9AHYBgZ/jmlm6CyWD2MyGq1umvGOhCNasosCASPLfpAjcMyh4lbl
 OM2hldbE=
X-Google-Smtp-Source: AGHT+IFrg9ToIOvv/+PUG3joLRTjA7S2s4VTCZ/VzegTEyH6IvE8XFHv4GKWlkzIan00GKoJYSXxgw==
X-Received: by 2002:a05:622a:114d:b0:4a6:f00f:6618 with SMTP id
 d75a77b69052e-4a7f2de1992mr186010791cf.10.1751099776294; 
 Sat, 28 Jun 2025 01:36:16 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc1064b5sm25312181cf.14.2025.06.28.01.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 01:36:15 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 geert+renesas@glider.be, marek.vasut+renesas@gmail.com
Date: Sat, 28 Jun 2025 10:36:13 +0200
Message-Id: <175109977385.52679.11567533613173532148.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH 2/2] Add support for the r7s72100 Genmai board
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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

From: Magnus Damm <damm@opensource.se>

Add r7s72100 Genmai board support. Serial console, NOR Flash and
Ethernet are known to work however on-board SDRAM is not yet enabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/dts/Makefile                    |    3 -
 arch/arm/dts/r7s72100-genmai-u-boot.dtsi |   33 ++++++++++++
 arch/arm/mach-renesas/Kconfig.rza1       |    4 +
 board/renesas/genmai/Kconfig             |   12 ++++
 board/renesas/genmai/MAINTAINERS         |    7 ++
 board/renesas/genmai/Makefile            |   10 +++
 board/renesas/genmai/genmai.c            |   49 ++++++++++++++++++
 configs/genmai_defconfig                 |   81 ++++++++++++++++++++++++++++++
 configs/grpeach_defconfig                |    1 
 include/configs/genmai.h                 |   27 ++++++++++
 10 files changed, 226 insertions(+), 1 deletion(-)

diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/arch/arm/dts/Makefile u-boot-v2025.07-rc5-genmai-v12/arch/arm/dts/Makefile
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/arch/arm/dts/Makefile	2025-06-06 19:15:44.845179216 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/arch/arm/dts/Makefile	2025-06-28 05:47:57.247120095 +0900
@@ -924,7 +924,8 @@
 	imxrt1170-evk.dtb \
 
 dtb-$(CONFIG_RZA1) += \
-	r7s72100-gr-peach.dtb
+	r7s72100-gr-peach.dtb \
+	r7s72100-genmai.dtb
 
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
 
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/arch/arm/dts/r7s72100-genmai-u-boot.dtsi u-boot-v2025.07-rc5-genmai-v12/arch/arm/dts/r7s72100-genmai-u-boot.dtsi
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/arch/arm/dts/r7s72100-genmai-u-boot.dtsi	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/arch/arm/dts/r7s72100-genmai-u-boot.dtsi	2025-06-28 05:47:57.247120095 +0900
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Genmai board
+ * Based on GR Peach, Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
+ */
+
+
+/ {
+	soc {
+		bootph-all;
+	};
+};
+
+&bsc {
+	bootph-all;
+};
+
+&ostm0 {
+	bootph-all;
+};
+
+&pinctrl {
+	bootph-all;
+};
+
+&scif2 {
+	bootph-all;
+	clock = <66666666>;	/* ToDo: Replace by DM clock driver */
+};
+
+&scif2_pins {
+	bootph-all;
+};
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/arch/arm/mach-renesas/Kconfig.rza1 u-boot-v2025.07-rc5-genmai-v12/arch/arm/mach-renesas/Kconfig.rza1
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/arch/arm/mach-renesas/Kconfig.rza1	2024-05-18 16:38:52.679533996 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/arch/arm/mach-renesas/Kconfig.rza1	2025-06-28 05:47:57.247120095 +0900
@@ -17,9 +17,13 @@
 config TARGET_GRPEACH
 	bool "GR-PEACH board"
 
+config TARGET_GENMAI
+	bool "GENMAI board"
+
 endchoice
 
 # Renesas Supported Boards
 source "board/renesas/grpeach/Kconfig"
+source "board/renesas/genmai/Kconfig"
 
 endif
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/genmai.c u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/genmai.c
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/genmai.c	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/genmai.c	2025-06-28 05:47:57.248120101 +0900
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Magnus Damm <damm@opensource.se>
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+
+#define RZA1_BCR_BASE (0x3FFFC000)
+#define CS0BCR (RZA1_BCR_BASE + 0x04)
+#define CS0WCR (RZA1_BCR_BASE + 0x28)
+#define CS1BCR (RZA1_BCR_BASE + 0x08)
+#define CS1WCR (RZA1_BCR_BASE + 0x2c)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = (CFG_SYS_SDRAM_BASE + 0x100);
+
+	/* setup NOR Flash on CS0 and CS1 */
+	writel(0x00000b40, CS0WCR);
+	writel(0x10000c00, CS0BCR);
+	writel(0x00000b40, CS1WCR);
+	writel(0x10000c00, CS1BCR);
+	return 0;
+}
+
+/*
+ * The Genmai DT will most likely contain memory nodes describing the external
+ * SDRAM memory connected to CS2 and CS3, however we do not yet have any code
+ * in U-Boot to setup the memory controller. For now ignore DT and make use of
+ * the RZ/A1H on-chip memory which is 10 MiB at CFG_SYS_SDRAM_BASE.
+ */
+
+int dram_init(void)
+{
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+	gd->ram_size = 10 << 20;
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = gd->ram_size;
+	return 0;
+}
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/Kconfig u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/Kconfig
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/Kconfig	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/Kconfig	2025-06-28 05:47:57.248120101 +0900
@@ -0,0 +1,12 @@
+if TARGET_GENMAI
+
+config SYS_BOARD
+	default "genmai"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "genmai"
+
+endif
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/MAINTAINERS u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/MAINTAINERS
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/MAINTAINERS	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/MAINTAINERS	2025-06-28 05:47:57.248120101 +0900
@@ -0,0 +1,7 @@
+GENMAI BOARD
+M:	Magnus Damm <damm@opensource.se>
+S:	Maintained
+F:	arch/arm/dts/r7s72100*
+F:	board/renesas/genmai/
+F:	configs/genmai_defconfig
+F:	include/configs/genmai.h
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/Makefile u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/Makefile
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/board/renesas/genmai/Makefile	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/board/renesas/genmai/Makefile	2025-06-28 05:47:57.248120101 +0900
@@ -0,0 +1,10 @@
+#
+# board/renesas/genmai/Makefile
+#
+# Copyright (C) 2025 Magnus Damm <damm@opensource.se>
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-y	:= genmai.o
+
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/configs/genmai_defconfig u-boot-v2025.07-rc5-genmai-v12/configs/genmai_defconfig
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/configs/genmai_defconfig	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/configs/genmai_defconfig	2025-06-28 05:47:57.248120101 +0900
@@ -0,0 +1,81 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_TEXT_BASE=0x20024000
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x400
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20900000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x80000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-genmai"
+CONFIG_RZA1=y
+CONFIG_TARGET_GENMAI=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SYS_LOAD_ADDR=0x20400000
+CONFIG_SYS_CLK_FREQ=66666666
+# CONFIG_EFI_LOADER is not set
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="ignore_loglevel"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=256
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_BOARD_EARLY_INIT_F is not set
+CONFIG_HUSH_PARSER=y
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_MAC_PARTITION=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MTD=y
+CONFIG_ENV_MTD_DEV="nor0"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_RZA1_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_CFI_FLASH=y
+CONFIG_FLASH_CFI_DRIVER=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_PROTECTION=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_BITBANGMII=y
+CONFIG_PHY_SMSC=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_SH_ETHER=y
+CONFIG_PINCTRL=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_RENESAS_RPC_SPI=y
+CONFIG_TIMER=y
+CONFIG_RENESAS_OSTM_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_R8A66597_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_SYS_MEMTEST_START=0x08000000
+CONFIG_SYS_MEMTEST_END=0x10000000
+CONFIG_CMD_MEMTEST=y
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/configs/grpeach_defconfig u-boot-v2025.07-rc5-genmai-v12/configs/grpeach_defconfig
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/configs/grpeach_defconfig	2025-02-14 15:36:58.170816484 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/configs/grpeach_defconfig	2025-06-28 05:47:57.248120101 +0900
@@ -13,6 +13,7 @@
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-gr-peach"
 CONFIG_RZA1=y
+CONFIG_TARGET_GRPEACH=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SYS_LOAD_ADDR=0x20400000
diff -urN u-boot-v2025.07-rc5-renesas-common-a1-v2/include/configs/genmai.h u-boot-v2025.07-rc5-genmai-v12/include/configs/genmai.h
--- u-boot-v2025.07-rc5-renesas-common-a1-v2/include/configs/genmai.h	1970-01-01 09:00:00.000000000 +0900
+++ u-boot-v2025.07-rc5-genmai-v12/include/configs/genmai.h	2025-06-28 05:47:57.248120101 +0900
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration settings for the Renesas GENMAI board
+ *
+ * Copyright (C) 2017-2019 Renesas Electronics
+ */
+
+#ifndef __GENMAI_H
+#define __GENMAI_H
+
+/* Board Clock , P1 clock frequency (XTAL=13.33MHz) */
+
+/* Miscellaneous */
+
+/* Internal RAM Size (RZ/A1=3M, RZ/A1M=5M, RZ/A1H=10M) */
+#define CFG_SYS_SDRAM_BASE		0x20000000
+#define CFG_SYS_SDRAM_SIZE		(10 * 1024 * 1024)
+
+/* Network interface */
+#define CFG_SH_ETHER_USE_PORT	0
+#define CFG_SH_ETHER_PHY_ADDR	0
+#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_MII
+#define CFG_SH_ETHER_CACHE_WRITEBACK
+#define CFG_SH_ETHER_CACHE_INVALIDATE
+#define CFG_SH_ETHER_ALIGNE_SIZE	64
+
+#endif	/* __GENAMI_H */
