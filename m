Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7C8C83F03
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 20:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1C982F4E;
	Wed,  2 Jul 2025 22:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE9D82F4E; Wed,  2 Jul 2025 19:14:01 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1603D82ADA
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d09f11657cso659292785a.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476437; x=1752081237;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+EPRgN+sT6eHDV3SZ9TuMEW+9VIsHo3H9GUC9iL1Dc=;
 b=ilVz8zNY109k0eSgEfasf0TOy/RA4VNaMm3ssN7r2naBpgCnsDcwYOaAGDet2GPkeI
 Ecoc2Jfafw8fpDfLEnKT1opegbJzfND9EpqZH3mT8AOwzHiJUi5bkBnreKNh2J+SA+h8
 N5b+XB5tbS5lefWGCqEc0B/7cr64oqF9w/8RWVEzUVwYOJFtwOp3VfhlocrUyRmnp5Zy
 naX8Gb3aThqVou9vSyDE1iyjYIH/VF5iq+ZtemsPm0yo1vMK+1rOZVuDP+J2yKqrV3sP
 CcCvLs8KHJq2B+qpcVsaAolfWY3lnLxF6NuJxWJZ4wDI+hMckhMvCGU7Fi8reHRbyeQB
 xhEQ==
X-Gm-Message-State: AOJu0Yy5wKbQBrmnXwNYEAvNHeWVy6etk4U0a4XuQKyZYIncjj5G8nOF
 BsGD7pQ98DoIe/j2es7k9jrjZxN2CQtSl/SGdn8+TktNs9H+Iw5f8AnlG/sglja7
X-Gm-Gg: ASbGnctZ1UbsvpW4x2NuBeiSga4h6LLJ70DBEryGeMILOVq3Z5TB4Sqg8YxYSTNVdkh
 Keo1ZYckleWsWe50Z9qAHaHUXl8NOTKCvSnMggz7RqfZtIoWaNofMAmGWgPbshfrn1m/AcpPBS1
 OediJLYXb4CxEoTrXxinrNnFHEMuT61s8eLfN2VTnENDr8nYVWJApcUjdmcz8OfhPPme+8UREjP
 N6OIiKDG1xi5pya/DLGbF/vDMAw4agjeZ/D2va+VkCD9FiuLO7e3UuM71YAFSDZzOsuB3zIHapw
 j5BxurM0J4Llo3yHEAb5nggu4mu0GeKDOgbSzF1c55O9IQ2DwcO8oB/+6BDEqcsYaJ3LmpEw/3E
 I3yS8ZeP+cS5g
X-Google-Smtp-Source: AGHT+IFDG+eLrTwR6jxcXvkRkStgiiNc6QnmSzS95vDRud3IlivNMuh/vxf9t7nptB9F1lfk9Oqiag==
X-Received: by 2002:a05:620a:2692:b0:7c5:4b18:c4c3 with SMTP id
 af79cd13be357-7d5c47988a8mr392451385a.30.1751476436741; 
 Wed, 02 Jul 2025 10:13:56 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443204d75sm974214385a.72.2025.07.02.10.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:56 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 marek.vasut+renesas@mailbox.org, geert+renesas@glider.be
Date: Wed, 02 Jul 2025 19:13:54 +0200
Message-Id: <175147643405.69121.7407824209859295259.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v2 2/2] ARM: renesas: Add support for the r7s72100 Genmai board
X-Mailman-Approved-At: Wed, 02 Jul 2025 22:17:46 +0200
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

 Changes since v1:
 - Include fixup changes from Marek, thank you.
 - Rebase on top of u-boot next and patches from Marek.
 - The defconfig has been updated to use
   CONFIG_POSITION_INDEPENDENT=y and CONFIG_SYS_TEXT_BASE=0x0 

 arch/arm/dts/Makefile                    |    1 
 arch/arm/dts/r7s72100-genmai-u-boot.dtsi |   32 +++++++++++++++++++
 arch/arm/mach-renesas/Kconfig.rza1       |    4 ++
 board/renesas/genmai/Kconfig             |   12 +++++++
 board/renesas/genmai/MAINTAINERS         |    5 +++
 board/renesas/genmai/Makefile            |    7 ++++
 board/renesas/genmai/genmai.c            |   49 ++++++++++++++++++++++++++++++
 configs/genmai_defconfig                 |   17 ++++++++++
 include/configs/genmai.h                 |   15 +++++++++
 9 files changed, 142 insertions(+)

--- 0001/arch/arm/dts/Makefile
+++ work/arch/arm/dts/Makefile	2025-07-02 22:41:57.823241689 +0900
@@ -924,6 +924,7 @@ dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-ev
 	imxrt1170-evk.dtb \
 
 dtb-$(CONFIG_RZA1) += \
+	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb
 
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
--- /dev/null
+++ work/arch/arm/dts/r7s72100-genmai-u-boot.dtsi	2025-07-02 22:41:57.823241689 +0900
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Genmai board
+ * Based on GR Peach, Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
+ */
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
--- 0001/arch/arm/mach-renesas/Kconfig.rza1
+++ work/arch/arm/mach-renesas/Kconfig.rza1	2025-07-02 22:41:57.823241689 +0900
@@ -14,12 +14,16 @@ choice
 	prompt "Renesas RZ/A1 board select"
 
 # Renesas Supported Boards
+config TARGET_GENMAI
+	bool "GENMAI board"
+
 config TARGET_GRPEACH
 	bool "GR-PEACH board"
 
 endchoice
 
 # Renesas Supported Boards
+source "board/renesas/genmai/Kconfig"
 source "board/renesas/grpeach/Kconfig"
 
 endif
--- /dev/null
+++ work/board/renesas/genmai/Kconfig	2025-07-02 22:39:54.701474070 +0900
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
--- /dev/null
+++ work/board/renesas/genmai/MAINTAINERS	2025-07-02 22:41:57.823241689 +0900
@@ -0,0 +1,5 @@
+GENMAI BOARD
+M:	Magnus Damm <damm@opensource.se>
+S:	Maintained
+F:	arch/arm/dts/r7s72100*
+N:	genmai
--- /dev/null
+++ work/board/renesas/genmai/Makefile	2025-07-02 22:41:57.823241689 +0900
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Magnus Damm <damm@opensource.se>
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-y	:= genmai.o
--- /dev/null
+++ work/board/renesas/genmai/genmai.c	2025-07-02 22:43:27.465800567 +0900
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
+#define RZA1_BCR_BASE	0x3FFFC000
+#define CS0BCR		(RZA1_BCR_BASE + 0x04)
+#define CS0WCR		(RZA1_BCR_BASE + 0x28)
+#define CS1BCR		(RZA1_BCR_BASE + 0x08)
+#define CS1WCR		(RZA1_BCR_BASE + 0x2c)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
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
--- /dev/null
+++ work/configs/genmai_defconfig	2025-07-03 00:46:55.755261108 +0900
@@ -0,0 +1,17 @@
+#include <configs/renesas_rza1.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-genmai"
+CONFIG_TARGET_GENMAI=y
+
+CONFIG_ENV_IS_IN_MTD=y
+CONFIG_ENV_MTD_DEV="nor0"
+CONFIG_ENV_OFFSET=0x80000
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_MTD=y
+CONFIG_SYS_MAX_FLASH_BANKS=2
--- /dev/null
+++ work/include/configs/genmai.h	2025-07-02 22:41:57.824241695 +0900
@@ -0,0 +1,15 @@
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
+/* Internal RAM Size (RZ/A1=3M, RZ/A1M=5M, RZ/A1H=10M) */
+#define CFG_SYS_SDRAM_BASE		0x20000000
+#define CFG_SYS_SDRAM_SIZE		(10 * 1024 * 1024)
+
+#endif	/* __GENAMI_H */
