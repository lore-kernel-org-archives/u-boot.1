Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F6DC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4588800B;
	Tue, 27 Feb 2024 14:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="HP+5o+Ai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212F888013; Tue, 27 Feb 2024 14:44:55 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79FB8800C
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709041493; x=1740577493;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JKPBSSI7KVMZRvnhH24TBMZcFRn/luIcfw5pkf30Z54=;
 b=HP+5o+Ai9va7MW3GkLtPkOfoFYyY3D70iv2a7tijCS2yw6tOfGrVUR8d
 YnHdt5rC3IfMy4YrUHtfgNurl6HUDMFyz8TVh8966/KcN+2Wu6vV/ub1h
 D60tSu+gjj//eRSp5AkIdduJGe4T3/ITNTYDDYjlY+BakctmhGcuZ+2Et
 EPPIFCJMYXKNN7Dc9SATSR5iT4embyqr3iuYBR6Uts54KFhOsymAR8A72
 ONYLEDSbtfXNTBiNam2vfaixFbUGwBKB8SpFmO/JGt7GmqsSld2az9Njf
 X4ccUnMi1qzs1XUyykzHPtRbt3STADJS1e4jugpI4LWseuHsxiOVAAKLJ w==;
X-CSE-ConnectionGUID: HJeNXA3BRTuID+cAO3ulFQ==
X-CSE-MsgGUID: OeSoHfXcQamhmGhao6T5Hg==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; d="scan'208";a="247638376"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2024 06:44:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:44:12 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:44:11 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 3/4] board: at91: sama7g54_curiosity: Add initial board
 support
Date: Tue, 27 Feb 2024 15:44:02 +0200
Message-ID: <20240227134403.10686-4-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227134403.10686-1-mihai.sain@microchip.com>
References: <20240227134403.10686-1-mihai.sain@microchip.com>
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

Add initial support for SAMA7G54 Curiosity board.

Hardware:
SoC: SAMA7G54D2G SiP 1000 MHz
DRAM: DDR3 256 MiB
PMIC: MCP16502
Debug: UART3
Flash: QSPI NOR 8 MiB, SLC NAND 512 MiB
M.2 slot for wireless
Mikrobus connectors x 2
SD-Card connectors x 1
USB 2.0 x 3

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/mach-at91/Kconfig                    | 10 ++++++
 board/atmel/sama7g54_curiosity/Kconfig        | 15 ++++++++
 board/atmel/sama7g54_curiosity/MAINTAINERS    |  9 +++++
 board/atmel/sama7g54_curiosity/Makefile       |  7 ++++
 .../sama7g54_curiosity/sama7g54_curiosity.c   | 36 +++++++++++++++++++
 5 files changed, 77 insertions(+)
 create mode 100644 board/atmel/sama7g54_curiosity/Kconfig
 create mode 100644 board/atmel/sama7g54_curiosity/MAINTAINERS
 create mode 100644 board/atmel/sama7g54_curiosity/Makefile
 create mode 100644 board/atmel/sama7g54_curiosity/sama7g54_curiosity.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c5fd869272..8a8ac53e4f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -286,6 +286,15 @@ config TARGET_SAMA7G5EK
        select BOARD_EARLY_INIT_F
        select BOARD_LATE_INIT
 
+config TARGET_SAMA7G54_CURIOSITY
+	bool "SAMA7G54 CURIOSITY board"
+	select SAMA7G5
+	select CPU_V7A
+	help
+	  The SAMA7G54 Curiosity embeds SAMA7G54D2G SiP (System in Package)
+	  with 2Gbit DDR3-SDRAM, 64Mbit QSPI nor-flash with MAC-address,
+	  4Gbit SLC nand-flash, MCP16502 PMIC, 2 x Mikrobus connectors,
+	  1 x SD-Card connector, 1 x M.2 slot, 3 x USB
 
 config TARGET_TAURUS
 	bool "Support taurus"
@@ -366,6 +375,7 @@ source "board/atmel/at91sam9x5ek/Kconfig"
 source "board/atmel/sam9x60ek/Kconfig"
 source "board/atmel/sam9x60_curiosity/Kconfig"
 source "board/atmel/sama7g5ek/Kconfig"
+source "board/atmel/sama7g54_curiosity/Kconfig"
 source "board/atmel/sama5d2_ptc_ek/Kconfig"
 source "board/atmel/sama5d2_xplained/Kconfig"
 source "board/atmel/sama5d27_som1_ek/Kconfig"
diff --git a/board/atmel/sama7g54_curiosity/Kconfig b/board/atmel/sama7g54_curiosity/Kconfig
new file mode 100644
index 0000000000..3e60d96712
--- /dev/null
+++ b/board/atmel/sama7g54_curiosity/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_SAMA7G54_CURIOSITY
+
+config SYS_BOARD
+	default "sama7g54_curiosity"
+
+config SYS_VENDOR
+	default "atmel"
+
+config SYS_SOC
+	default "at91"
+
+config SYS_CONFIG_NAME
+	default "sama7g54_curiosity"
+
+endif
diff --git a/board/atmel/sama7g54_curiosity/MAINTAINERS b/board/atmel/sama7g54_curiosity/MAINTAINERS
new file mode 100644
index 0000000000..b9f1a271c0
--- /dev/null
+++ b/board/atmel/sama7g54_curiosity/MAINTAINERS
@@ -0,0 +1,9 @@
+SAMA7G54 CURIOSITY BOARD
+M:     Mihai Sain <mihai.sain@microchip.com>
+S:     Maintained
+F:     board/atmel/sama7g54_curiosity.c
+F:     include/configs/sama7g54_curiosity.h
+F:     configs/sama7g54_curiosity_mmc_defconfig
+F:     configs/sama7g54_curiosity_nandflash_defconfig
+F:     configs/sama7g54_curiosity_qspiflash_defconfig
+F:     arch/arm/dts/at91-sama7g54_curiosity*
diff --git a/board/atmel/sama7g54_curiosity/Makefile b/board/atmel/sama7g54_curiosity/Makefile
new file mode 100644
index 0000000000..bc77655f35
--- /dev/null
+++ b/board/atmel/sama7g54_curiosity/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+#
+# Author: Mihai Sain <mihai.sain@microchip.com>
+
+obj-y += sama7g54_curiosity.o
diff --git a/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c b/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
new file mode 100644
index 0000000000..33cd0903d2
--- /dev/null
+++ b/board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Mihai Sain <mihai.sain@microchip.com>
+ *
+ */
+
+#include <common.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/at91_common.h>
+#include <asm/arch/atmel_pio4.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/sama7g5.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	// Address of boot parameters
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
-- 
2.44.0

