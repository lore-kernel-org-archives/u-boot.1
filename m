Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D147C83F07
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5CF7830B3;
	Mon,  7 Jul 2025 00:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A6582F30; Sun,  6 Jul 2025 13:29:51 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C9D82F14
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6fad8b4c927so25590676d6.0
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801388; x=1752406188;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4jjkq9atXqUIB70vOLaX2w/ru0XCQFel7S1VVzCxj4=;
 b=Xdinp9NvYl+3qXoSXWBuRyOVa1ZUDWp/9KFOAEl1yxdX/S0NjZx26fW2NX8jrxDfOe
 tSaWLL4mb74sIoW3SWXnm5vRsZEYL1Rh84aGqCh0tjALDNVEKKY8vFKeXJM0CwCIBRjb
 D7sXV2FQ1RK5cIyAmpR4VTeqnrKbOv7vv064hGhnI/rwzy7jCHi768tYKD3bVbGaNbC/
 oYa/MTZ3uwLlluh+zjxFSx6fgb2Bcro+EqfzaEzAxxl/IXIb630YotyARDd+3sptO0l8
 wJOvHD/TalaFkLMjuGBF52SsdNKHHvkowFPatJDnPKgKZNjX32nYAni9VaX8Cf9sW7x4
 Njkw==
X-Gm-Message-State: AOJu0Yz4lCcW29F9P1t8NS+7e7ufM7IhK7j3xKHzlX7VDlQ1/WIuFTVp
 CJPmWn+5PXZiMlPsRM5rBK4r8AZFC/w4IiLD5uCcEvXbqvwfHdxnLbKQ1mFFqAQe
X-Gm-Gg: ASbGncuQUwvr7mGgEQORISFo60P/xLS1vuBueXeKhPipDOqrqQfpesWM0j6ZJ6llrfj
 nExhdLNPtEpPAn1geEUOZIs7saNKlrgo0prb/EOmzdMgvP0dyRk+6txfXxlhA0cqRg2/+s4mHoy
 8mmv14HTatX/iAF4h+9b2pN03FWiTJ0hYGeztPfogWTEPXfnHNv1vIPK0lQJQaONXn8Fha1ZwmB
 vE5B2HdMe6xCt3MYyI92Is2vbtUOgoaUv1zT5E7HwoeoWjXtY5CLzJtiiLAQB5Nuc5oogdySIG6
 JZhNS5ATT8xQmxuqJBrgOd5SlFox1pn4gVGs34GZ40rLge6N+dwglm8dWzAg/YmLZgEYkrQH38a
 ogmduWbOMnRx5o75FTA==
X-Google-Smtp-Source: AGHT+IHyAu9GRk9hdc8nGwIqu6DjyDMunNrDPv4EMlTiQsAbVMhKeGhdaX9fZRoIqAx+6szuWtbYQA==
X-Received: by 2002:a05:6214:e4b:b0:6fa:fcb0:b88d with SMTP id
 6a1803df08f44-702c6d79cf4mr129936986d6.28.1751801387745; 
 Sun, 06 Jul 2025 04:29:47 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4cc7751sm43060246d6.10.2025.07.06.04.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:29:47 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 Magnus Damm <damm@opensource.se>, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:29:45 +0200
Message-Id: <175180138513.86839.112101475183122753.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 9/9] ARM: renesas: Add RZ/A2 RZA2MBTC board support
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

Add initial RZ/A2 RZA2MBTC  board support. Serial console, SPI Flash and
Ethernet are known to work however on-board SDRAM is not yet enabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - new patch

 Please pick DT board file from the following patch in series:
 [PATCH 6/6] ARM: dts: renesas: rza2mbtc: initial board support
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=979368

 Makefile                                  |    2 +
 arch/arm/dts/Makefile                     |    3 +-
 arch/arm/dts/r7s9210-rza2mbtc-u-boot.dtsi |   28 +++++++++++++++++++++++
 arch/arm/mach-renesas/Kconfig.rza2        |    4 +++
 board/aprg/rza2mbtc/Kconfig               |   15 ++++++++++++
 board/aprg/rza2mbtc/MAINTAINERS           |    5 ++++
 board/aprg/rza2mbtc/Makefile              |    1 
 board/aprg/rza2mbtc/rza2mbtc.c            |   34 +++++++++++++++++++++++++++++
 configs/rza2mbtc_defconfig                |   17 ++++++++++++++
 include/configs/rza2mbtc.h                |   27 +++++++++++++++++++++++
 10 files changed, 135 insertions(+), 1 deletion(-)

--- 0013/Makefile
+++ work/Makefile	2025-07-05 19:47:10.480068691 +0900
@@ -868,9 +868,11 @@ c_flags := $(KBUILD_CFLAGS) $(cpp_flags)
 # U-Boot objects....order is important (i.e. start must be first)
 
 HAVE_VENDOR_COMMON_LIB = $(if $(wildcard $(srctree)/board/$(VENDOR)/common/Makefile),y,n)
+HAVE_SOC_COMMON_LIB = $(if $(wildcard $(srctree)/board/$(SOC)/common/Makefile),y,n)
 
 libs-$(CONFIG_API) += api/
 libs-$(HAVE_VENDOR_COMMON_LIB) += board/$(VENDOR)/common/
+libs-$(HAVE_SOC_COMMON_LIB) += board/$(SOC)/common/
 libs-y += boot/
 libs-$(CONFIG_CMDLINE) += cmd/
 libs-y += common/
--- 0021/arch/arm/dts/Makefile
+++ work/arch/arm/dts/Makefile	2025-07-05 19:47:10.480068691 +0900
@@ -928,7 +928,8 @@ dtb-$(CONFIG_RZA1) += \
 	r7s72100-gr-peach.dtb
 
 dtb-$(CONFIG_RZA2) += \
-	r7s9210-gr-mango.dtb
+	r7s9210-gr-mango.dtb \
+	r7s9210-rza2mbtc.dtb
 
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
 
--- /dev/null
+++ work/arch/arm/dts/r7s9210-rza2mbtc-u-boot.dtsi	2025-07-05 19:57:05.029546662 +0900
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the RZ/A2M BTC board
+ * Based on GR Peach, Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
+ */
+
+/ {
+	soc {
+		bootph-all;
+	};
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
+&scif1 {
+	bootph-all;
+	clock = <66666666>;     /* ToDo: Replace by DM clock driver */
+};
+
+&scif1_pins {
+	bootph-all;
+};
--- 0021/arch/arm/mach-renesas/Kconfig.rza2
+++ work/arch/arm/mach-renesas/Kconfig.rza2	2025-07-05 19:47:10.480068691 +0900
@@ -11,10 +11,14 @@ choice
 config TARGET_GRMANGO
 	bool "GR-MANGO board"
 
+config TARGET_RZA2MBTC
+	bool "RZA2MBTC board"
+
 endchoice
 
 # Renesas Supported Boards
 source "board/renesas/grmango/Kconfig"
 
+source "board/aprg/rza2mbtc/Kconfig"
 
 endif
--- /dev/null
+++ work/board/aprg/rza2mbtc/Kconfig	2025-07-05 19:47:11.525074804 +0900
@@ -0,0 +1,15 @@
+if TARGET_RZA2MBTC
+
+config SYS_SOC
+        default "renesas"
+
+config SYS_BOARD
+	default "rza2mbtc"
+
+config SYS_VENDOR
+	default "aprg"
+
+config SYS_CONFIG_NAME
+	default "rza2mbtc"
+
+endif
--- /dev/null
+++ work/board/aprg/rza2mbtc/MAINTAINERS	2025-07-05 19:47:11.532074845 +0900
@@ -0,0 +1,5 @@
+RZA2MBTC BOARD
+M:	Magnus Damm <damm@opensource.se>
+F:	arch/arm/dts/r7s9210*
+F:	board/aprg/rza2mbtc/
+N:	rza2mbtc
--- /dev/null
+++ work/board/aprg/rza2mbtc/Makefile	2025-07-05 19:47:11.539074886 +0900
@@ -0,0 +1 @@
+obj-y	:= rza2mbtc.o
--- /dev/null
+++ work/board/aprg/rza2mbtc/rza2mbtc.c	2025-07-05 19:48:16.442454560 +0900
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Renesas Electronics
+ * Copyright (C) Chris Brandt
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+	return 0;
+}
+
+/*
+ * Make use of the RZ/A2M on-chip memory which is 4 MiB at CFG_SYS_SDRAM_BASE.
+ */
+
+int dram_init(void)
+{
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+	gd->ram_size = 4 << 20;
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
+++ work/configs/rza2mbtc_defconfig	2025-07-05 19:47:11.553074968 +0900
@@ -0,0 +1,17 @@
+#include <configs/renesas_rza2.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s9210-rza2mbtc"
+CONFIG_TARGET_RZA2MBTC=y
+
+CONFIG_DM_SPI_FLASH=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_OFFSET=0xe0000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_MTD=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_MACRONIX=y
--- /dev/null
+++ work/include/configs/rza2mbtc.h	2025-07-05 19:47:11.560075010 +0900
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration settings for the Renesas GRMANGO board
+ *
+ * Copyright (C) 2017-2019 Renesas Electronics
+ */
+
+#ifndef __GRMANGO_H
+#define __GRMANGO_H
+
+/* Internal RAM Size */
+/*
+ * u-boot will be relocated to internal RAM during boot.
+ * RZ/A2M = 4MB
+ */
+#define CFG_SYS_SDRAM_BASE           0x80000000
+#define CFG_SYS_SDRAM_SIZE           (4 * 1024 * 1024)
+
+/* Network interface */
+#define CFG_SH_ETHER_USE_PORT 1
+#define CFG_SH_ETHER_PHY_ADDR 0
+#define CFG_SH_ETHER_PHY_MODE PHY_INTERFACE_MODE_RMII
+#define CFG_SH_ETHER_CACHE_WRITEBACK
+#define CFG_SH_ETHER_CACHE_INVALIDATE
+#define CFG_SH_ETHER_ALIGNE_SIZE	64
+
+#endif	/* __GRMANGO_H */
