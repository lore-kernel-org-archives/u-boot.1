Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E30DC83F03
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 701A18309C;
	Mon,  7 Jul 2025 00:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CB481D6A; Sun,  6 Jul 2025 13:29:43 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BFB82F14
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fad4e6d949so13417606d6.0
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801380; x=1752406180;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRKWT0BvHip2jshSfspMmDUN2fq2hsxj8XQipziInpA=;
 b=BBYpvSZvC17VDgxMavQspt+Ia90aUBp4jWJ9Jzbb6diDUef2dd1ZIZOPqNPGUK5rlU
 7aBpzKoSufFuUGixpIMBtpBlzibjXt4WIXNpxei0jMgILaAmjNlFcAIb5IeBWwGYfHgZ
 j2MOsgsd9BXwnSqF1Nhb0CUjcRBhytxftiWGWfCQ+KgYiM/x7k7CRTldXvmaUpGQhTy0
 2V8FlB1pHcBkiH3AFGTGfG8aGvaS93hAc7WQ0CuHl3YpuKWpWzizg1rL3PjAKIzD+jGF
 gSxtoxiltzsuq6bv4AQD3wz4RhRnUX8flpbnENWRCYPwwwrLj+zKHnyT05UUGYd8od6Q
 LOmg==
X-Gm-Message-State: AOJu0YxvHm69a6WfVke3uFT9NJEvf527ApvBqflcuef4tD5a8xzmkF6g
 RdN3m4YNrOtSVIYY9w/ORUs2plbLBkgkb0cMnuUxtLLk7HpcVNhljgKlLx1PLMU7
X-Gm-Gg: ASbGncvUSWJZmi7ZXpg2/JDyV2kXWkZ3zXJxEptTiTTsjMf0ZYHYMo31S/f/xU8oSer
 pgFSHrzpNtx4Ce0QebOYhogUhxmEcW0CFiLwPY1G/3thwR6RzsQMsVm7hSxsiVw61bUqql5Gy39
 XfMoZa3WccbSvwMQ1Df0BMq9FAb32VJBxmKZBuZs6erYcPmuNSyy6hY4j5Z6v1qvRk520Su9lTE
 lw6o/P4aMZibmudCgSeYf7h6hyblAH30AxucK9iBSoAx12o9vkwkFg31peI9Dqv5njCtyv2nmIA
 eTJQ0pCpmasMpbqSNeDpmcsdvV8AC5LQ194IAy2XHa1jfrBo7asFCwLPpfjbTxJjvxpLm46fDnd
 N56eOHLQ=
X-Google-Smtp-Source: AGHT+IGMcRg3GvUq5SyQrPk0je4LghMWwIkJAV8Hx2UC2busqr0+QTqzpqp11jcf0mr4NH3QCMV3iA==
X-Received: by 2002:a05:6214:260c:b0:6f8:a825:adea with SMTP id
 6a1803df08f44-702c8b90c07mr116340446d6.15.1751801380113; 
 Sun, 06 Jul 2025 04:29:40 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4cc7534sm43219356d6.11.2025.07.06.04.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:29:39 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, Magnus Damm <damm@opensource.se>,
 marek.vasut+renesas@mailbox.org, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:29:37 +0200
Message-Id: <175180137742.86839.9519699030077029409.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 8/9] ARM: renesas: Add RZ/A2 GR-Mango board support
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

Add initial RZ/A2 GR-Peach board support. Serial console and Ethernet
are known to work however on-board SDRAM is not yet enabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - new patch

 Please pick DT board file from the following patch in series:
 [PATCH 5/6] ARM: dts: renesas: gr-mango: initial board support
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=979368

 arch/arm/dts/Makefile                     |    3 ++
 arch/arm/dts/r7s9210-gr-mango-u-boot.dtsi |   28 ++++++++++++++++++++
 arch/arm/mach-renesas/Kconfig.rza2        |   13 +++++++++
 board/renesas/grmango/Kconfig             |   12 ++++++++
 board/renesas/grmango/MAINTAINERS         |    5 +++
 board/renesas/grmango/Makefile            |    7 +++++
 board/renesas/grmango/grmango.c           |   40 +++++++++++++++++++++++++++++
 configs/grmango_defconfig                 |   10 +++++++
 include/configs/grmango.h                 |   15 ++++++++++
 9 files changed, 133 insertions(+)

--- 0020/arch/arm/dts/Makefile
+++ work/arch/arm/dts/Makefile	2025-07-05 18:10:31.000000000 +0900
@@ -927,6 +927,9 @@ dtb-$(CONFIG_RZA1) += \
 	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb
 
+dtb-$(CONFIG_RZA2) += \
+	r7s9210-gr-mango.dtb
+
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
 
 dtb-$(CONFIG_TARGET_PM9261) += at91sam9261ek.dtb
--- /dev/null
+++ work/arch/arm/dts/r7s9210-gr-mango-u-boot.dtsi	2025-07-05 18:10:32.845452021 +0900
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the GR Mango board
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
+&scif0 {
+	bootph-all;
+	clock = <66666666>;     /* ToDo: Replace by DM clock driver */
+};
+
+&scif0_pins {
+	bootph-all;
+};
--- 0020/arch/arm/mach-renesas/Kconfig.rza2
+++ work/arch/arm/mach-renesas/Kconfig.rza2	2025-07-05 18:10:31.000000000 +0900
@@ -4,4 +4,17 @@ config CPU_RZA2
 	bool
 	default y
 
+choice
+	prompt "Renesas RZ/A2 board select"
+
+# Renesas Supported Boards
+config TARGET_GRMANGO
+	bool "GR-MANGO board"
+
+endchoice
+
+# Renesas Supported Boards
+source "board/renesas/grmango/Kconfig"
+
+
 endif
--- /dev/null
+++ work/board/renesas/grmango/Kconfig	2025-07-05 18:10:32.859452100 +0900
@@ -0,0 +1,12 @@
+if TARGET_GRMANGO
+
+config SYS_BOARD
+	default "grmango"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "grmango"
+
+endif
--- /dev/null
+++ work/board/renesas/grmango/MAINTAINERS	2025-07-05 18:10:32.867452146 +0900
@@ -0,0 +1,5 @@
+GRMANGO BOARD
+M:	Magnus Damm <damm@opensource.se>
+F:	arch/arm/dts/r7s9210*
+F:	board/renesas/grmango/
+N:	grmango
--- /dev/null
+++ work/board/renesas/grmango/Makefile	2025-07-05 18:10:32.874452185 +0900
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2018 Renesas Electronics
+# Copyright (C) 2018 Chris Brandt
+#
+# SPDX-License-Identifier:	GPL-2.0+
+
+obj-y	:= grmango.o
--- /dev/null
+++ work/board/renesas/grmango/grmango.c	2025-07-05 19:42:53.297553497 +0900
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Renesas Electronics
+ * Copyright (C) Chris Brandt
+ */
+
+#include <init.h>
+#include <linux/io.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	/* configure PFENET register to use MII for Ethernet */
+	writeb(0x00, 0xfcffe2ff);
+	writeb(0x40, 0xfcffe2ff);
+	writeb(0x02, 0xfcffe820);
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
+++ work/configs/grmango_defconfig	2025-07-05 18:10:32.888452265 +0900
@@ -0,0 +1,10 @@
+#include <configs/renesas_rza2.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s9210-gr-mango"
+CONFIG_TARGET_GRMANGO=y
+
+CONFIG_ENV_IS_NOWHERE=y
--- /dev/null
+++ work/include/configs/grmango.h	2025-07-05 18:10:32.894452299 +0900
@@ -0,0 +1,15 @@
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
+/* Internal RAM Size: RZ/A2M = 4MB */
+#define CFG_SYS_SDRAM_BASE           0x80000000
+#define CFG_SYS_SDRAM_SIZE           (4 * 1024 * 1024)
+
+#endif	/* __GRMANGO_H */
