Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1057CC83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A074E82FE1;
	Mon,  7 Jul 2025 00:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F968277D; Sun,  6 Jul 2025 13:28:58 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7372F80FA8
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7d0a2220fb0so342555585a.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801334; x=1752406134;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EkuiDL3Gbwd6Pd7/nhhq2aZczmaCXBURVBnbZ9JZXXo=;
 b=jq9n/B/LXD6xGbOwguJU8BgNlyg1sjbczJhPsFJPqCslmTe0CEu9vhXSkJOjcMNbbs
 lPwTqWz6nG4h0OuawFDpTB4yvIHcQ/Snkc42OtOjRazNrzQEpnKI0rZt1XPFhHJDqXF2
 ENMrRH0VwYmyaD3mdFFbMIOvCfide4qSkIsWh0V7DSTjfFDrx46V3JAUjKujtrrCFQwY
 wqmlc/OH3kjVS8aGq7/ZZIFwRNOUhJJbk7MpvY3xV7ZldUN84SXS2FCeeDQDf2Ne82VI
 lcTJTQZ5Omt/nH9OVTbCXREvjqXRAq03XizABmrBy+ibBz8FiE9/41ZqCuTgITnUUFQ5
 LXHw==
X-Gm-Message-State: AOJu0Yx44rjqc2p0wfHel5sh0VCZHf8UctyNvFwDezvDQA1vIiDc+e6E
 M0ThJtjQRve2OJpI7lEyQdDWhe+BcUrcFcfH1yH3vQE2/d/r6CaX0T1tUId0WZ26
X-Gm-Gg: ASbGnct0/Qaon/8D26AAZdBzDAK3cYCiHqHJG4DB1nBm+2AC+QnnIHyBnXvsDjBEkl6
 iDlh/cNPr+MXKkJzXr3nFGa+iwAUfgoqfOCil2Y4yWNpT+ieQsQCCdwh8KXgY7WnJxDDIAd88Vr
 40gm4Rv/xdPZ696nyVNFH82MPKYado/1Ys5Ju1z+CEz18aaA6zeAbCzAEXCD60jsX+Uw7TbYePH
 U4dZmv78S/7X1ThxB0RMjfLG/JHnfDxnJR9506OA4F2F4cL2m4SmQ4jlMi+u4Qu2MPpAHDo/e+R
 aYpXY7+weEmnNI8soLo7+ky4bt4JO2o9wvgb30sModDlBoE+37nibuTEQ7f9mSh+JJyjt6Hz8CA
 XzRGBg8g=
X-Google-Smtp-Source: AGHT+IForuQBkY/CT4rKFyiMewHc2uO8BQUl20EDGeOb+2Gaqm+8dKILu9ftMEdCKJr6wwcclNDAmQ==
X-Received: by 2002:a05:620a:172c:b0:7d3:b9b6:f1b9 with SMTP id
 af79cd13be357-7d5df13c4f7mr1086666385a.26.1751801334118; 
 Sun, 06 Jul 2025 04:28:54 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9949f990dsm46606191cf.27.2025.07.06.04.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:28:53 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 marek.vasut+renesas@mailbox.org, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:28:51 +0200
Message-Id: <175180133137.86839.17595996246907826319.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 2/9] ARM: renesas: Add RZ/A1 Genmai board support
X-Mailman-Approved-At: Mon, 07 Jul 2025 00:18:49 +0200
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

Add r7s72100 Genmai board support. Serial console and Ethernet are known
to work. Parallel NOR flash might work, but it is broken on my board.
SPI flash can be used to save and restore the U-Boot environment.
On-board SDRAM is yet to be enabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - Update defconfig to make use of CONFIG_ENV_IS_IN_SPI_FLASH=y
   (this requires updated DT files that include rpc-if nodes)

 Changes since v1:
 - Include fixup changes from Marek, thank you.
 - Rebase on top of u-boot next and patches from Marek.
 - The defconfig has been updated to use
   CONFIG_POSITION_INDEPENDENT=y and CONFIG_SYS_TEXT_BASE=0x0 

 Please pick DT board file from the following patch in series:
 [PATCH 4/6] ARM: dts: renesas: genmai: add rpc-if SPI NOR flash
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=979368

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
+++ work/arch/arm/dts/Makefile	2025-07-03 04:37:02.000000000 +0900
@@ -924,6 +924,7 @@ dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-ev
 	imxrt1170-evk.dtb \
 
 dtb-$(CONFIG_RZA1) += \
+	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb
 
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
--- /dev/null
+++ work/arch/arm/dts/r7s72100-genmai-u-boot.dtsi	2025-07-03 04:37:03.000000000 +0900
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
+++ work/arch/arm/mach-renesas/Kconfig.rza1	2025-07-03 04:37:02.000000000 +0900
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
+++ work/board/renesas/genmai/Kconfig	2025-07-03 04:37:03.227872942 +0900
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
+++ work/board/renesas/genmai/MAINTAINERS	2025-07-03 04:37:03.000000000 +0900
@@ -0,0 +1,5 @@
+GENMAI BOARD
+M:	Magnus Damm <damm@opensource.se>
+S:	Maintained
+F:	arch/arm/dts/r7s72100*
+N:	genmai
--- /dev/null
+++ work/board/renesas/genmai/Makefile	2025-07-03 04:37:03.241873019 +0900
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Magnus Damm <damm@opensource.se>
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-y	:= genmai.o
--- /dev/null
+++ work/board/renesas/genmai/genmai.c	2025-07-03 04:37:03.000000000 +0900
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
+++ work/configs/genmai_defconfig	2025-07-05 01:35:27.679067500 +0900
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
+CONFIG_DM_SPI_FLASH=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_OFFSET=0x80000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_MTD=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_SPANSION=y
--- /dev/null
+++ work/include/configs/genmai.h	2025-07-03 04:37:03.263873139 +0900
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
