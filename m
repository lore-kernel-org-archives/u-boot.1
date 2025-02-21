Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5056C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 10:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 830F880FC2;
	Fri, 21 Feb 2025 11:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="tR5mWWPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4956980F7A; Fri, 21 Feb 2025 11:05:05 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E6480F88
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1402d5598=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1740132298; x=1771668298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3uFgvq8rFPhviPwEk3g1izpkQStGIkh35FIF9MieU3g=;
 b=tR5mWWPj2hjK24T4Za/V0Cyu0YjhiqEgT6C6viN61HuLW19bH/JKWv0E
 x1DD58Vl3DVr8koWsww0l2Wi8HHDo/52K3MRPQeZg9mwdVhXd26PouFT7
 u4Kfn6mB/yD8l+BlSq/89bdfZJ2MJ2g3QgKgVzvqHqxServDsTG6N9nyi
 Xsk1XvaDltcpwBCCkLV+c1RQV79UqDevUXHmfUP5URHOAausUa2I8tsIH
 NHcbYm6+36VvyQ7RKhE6CBYr89vcKa2IXvfQmbH7mluWBo0ppHfan2n1d
 LXIpBS2MP7RG/30PyRwu65OfdgaVVuPyZ5XSo2M+4ExrzXC1Hp72aWBwk A==;
X-CSE-ConnectionGUID: ic7/hmYaThOq/xctbVh6lg==
X-CSE-MsgGUID: 7kSnY+0fSMm5WfREs7APlA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732604400"; d="scan'208";a="205507947"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Feb 2025 03:04:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Feb 2025 03:04:25 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 21 Feb 2025 03:04:17 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, 
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>, 
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <nicolas.ferre@microchip.com>, <mihai.sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 7/8] board: sam9x75_curiosity: Add support for sam9x75
 curiosity
Date: Fri, 21 Feb 2025 15:33:13 +0530
Message-ID: <20250221100314.464818-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221100314.464818-1-manikandan.m@microchip.com>
References: <20250221100314.464818-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add board specific functions for sam9x75 curiosity

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/mach-at91/Kconfig                    |  7 ++
 board/atmel/sam9x75_curiosity/Kconfig         | 15 +++++
 board/atmel/sam9x75_curiosity/MAINTAINERS     |  6 ++
 board/atmel/sam9x75_curiosity/Makefile        |  7 ++
 .../sam9x75_curiosity/sam9x75_curiosity.c     | 66 +++++++++++++++++++
 include/configs/sam9x75_curiosity.h           | 23 +++++++
 6 files changed, 124 insertions(+)
 create mode 100644 board/atmel/sam9x75_curiosity/Kconfig
 create mode 100644 board/atmel/sam9x75_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sam9x75_curiosity/Makefile
 create mode 100644 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
 create mode 100644 include/configs/sam9x75_curiosity.h

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 5429257875d..019116b5b89 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -158,6 +158,12 @@ config TARGET_SAM9X60_CURIOSITY
         select BOARD_EARLY_INIT_F
         select BOARD_LATE_INIT
 
+config TARGET_SAM9X75_CURIOSITY
+	bool "SAM9X75 CURIOSITY board"
+	select SAM9X7
+	select BOARD_EARLY_INIT_F
+	select BOARD_LATE_INIT
+
 config TARGET_SAMA5D2_PTC_EK
 	bool "SAMA5D2 PTC EK board"
 	select BOARD_EARLY_INIT_F
@@ -355,6 +361,7 @@ source "board/atmel/at91sam9rlek/Kconfig"
 source "board/atmel/at91sam9x5ek/Kconfig"
 source "board/atmel/sam9x60ek/Kconfig"
 source "board/atmel/sam9x60_curiosity/Kconfig"
+source "board/atmel/sam9x75_curiosity/Kconfig"
 source "board/atmel/sama7g5ek/Kconfig"
 source "board/atmel/sama7g54_curiosity/Kconfig"
 source "board/atmel/sama5d2_ptc_ek/Kconfig"
diff --git a/board/atmel/sam9x75_curiosity/Kconfig b/board/atmel/sam9x75_curiosity/Kconfig
new file mode 100644
index 00000000000..8ea93a21aa3
--- /dev/null
+++ b/board/atmel/sam9x75_curiosity/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_SAM9X75_CURIOSITY
+
+config SYS_BOARD
+	default "sam9x75_curiosity"
+
+config SYS_VENDOR
+	default "atmel"
+
+config SYS_SOC
+	default "at91"
+
+config SYS_CONFIG_NAME
+	default "sam9x75_curiosity"
+
+endif
diff --git a/board/atmel/sam9x75_curiosity/MAINTAINERS b/board/atmel/sam9x75_curiosity/MAINTAINERS
new file mode 100644
index 00000000000..c60f1f52c7c
--- /dev/null
+++ b/board/atmel/sam9x75_curiosity/MAINTAINERS
@@ -0,0 +1,6 @@
+SAM9X75 CURIOSITY BOARD
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+S:	Maintained
+F:	board/atmel/sam9x75_curiosity/
+F:	include/configs/sam9x75_curiosity.h
+F:	arch/arm/dts/at91-sam9x75_curiosity*
diff --git a/board/atmel/sam9x75_curiosity/Makefile b/board/atmel/sam9x75_curiosity/Makefile
new file mode 100644
index 00000000000..1f36d613229
--- /dev/null
+++ b/board/atmel/sam9x75_curiosity/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+#
+# Author: Manikandan Muralidharan <manikandan.m@microchip.com>
+
+obj-y += sam9x75_curiosity.o
diff --git a/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c b/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
new file mode 100644
index 00000000000..4e7c5667e21
--- /dev/null
+++ b/board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
+ */
+
+#include <debug_uart.h>
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch/at91sam9_smc.h>
+#include <asm/arch/at91_common.h>
+#include <asm/arch/at91_rstc.h>
+#include <asm/arch/at91_sfr.h>
+#include <asm/arch/clk.h>
+#include <asm/arch/gpio.h>
+#include <asm/mach-types.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void at91_prepare_cpu_var(void);
+
+int board_late_init(void)
+{
+	at91_prepare_cpu_var();
+
+	return 0;
+}
+
+#if (IS_ENABLED(CONFIG_DEBUG_UART_BOARD_INIT))
+static void board_dbgu0_hw_init(void)
+{
+	at91_pio3_set_a_periph(AT91_PIO_PORTA, 26, 1);	/* DRXD */
+	at91_pio3_set_a_periph(AT91_PIO_PORTA, 27, 1);	/* DTXD */
+
+	at91_periph_clk_enable(ATMEL_ID_DBGU);
+}
+
+void board_debug_uart_init(void)
+{
+	board_dbgu0_hw_init();
+}
+#endif
+
+int board_early_init_f(void)
+{
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = gd->bd->bi_dram[0].start + 0x100;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
diff --git a/include/configs/sam9x75_curiosity.h b/include/configs/sam9x75_curiosity.h
new file mode 100644
index 00000000000..62a855d9f01
--- /dev/null
+++ b/include/configs/sam9x75_curiosity.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration settings for the SAM9X75 CURIOSITY board.
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
+ */
+
+#ifndef __CONFIG_H__
+#define __CONFIG_H__
+
+#define CFG_SYS_AT91_SLOW_CLOCK	32768
+#define CFG_SYS_AT91_MAIN_CLOCK	24000000	/* 24 MHz crystal */
+
+#define CFG_USART_BASE   ATMEL_BASE_DBGU
+#define CFG_USART_ID     0 /* ignored in arm */
+
+/* SDRAM */
+#define CFG_SYS_SDRAM_BASE		0x20000000
+#define CFG_SYS_SDRAM_SIZE		0x10000000      /* 256 megs */
+
+#endif
-- 
2.25.1

