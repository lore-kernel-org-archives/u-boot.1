Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B25C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 21:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B561D8874D;
	Thu, 25 Apr 2024 23:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="obscg2f4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33232886E3; Thu, 25 Apr 2024 23:38:38 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F418871D
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 23:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PLcW86084954;
 Thu, 25 Apr 2024 16:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714081112;
 bh=IyKxreCKHamoW1Z1nn67bD7wlj9xE0asJSGZRiwqqM4=;
 h=From:To:CC:Subject:Date;
 b=obscg2f4ObG+JtKV8LwZjNb8kDcnHfuCVMysj9hQOVPL/VJultDfyQv2pdIVtWIWK
 oChUzewQsJMDhYzLq/ct3PtbchLurH6ThtYUrufO4rwmgZTE67YX3SFYxD04oezD5x
 5AH5brvQmWAR8VXYlPT0UyDnQ4tYMqWxgc7Kb3AI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PLcWQP090169
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 16:38:32 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 16:38:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 16:38:32 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.8])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PLcW9f081978; 
 Thu, 25 Apr 2024 16:38:32 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: mach-k3: Move code specific to a SoC into that SoC's
 directory
Date: Thu, 25 Apr 2024 16:38:32 -0500
Message-ID: <20240425213832.518539-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Each SoC now has a directory in mach-k3, let's move the SoC specific
files into their respective directories.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Makefile                   | 27 ++++++---------------
 arch/arm/mach-k3/am62ax/Makefile            |  7 ++++++
 arch/arm/mach-k3/{ => am62ax}/am62a7_fdt.c  |  3 ++-
 arch/arm/mach-k3/{ => am62ax}/am62a7_init.c |  5 ++--
 arch/arm/mach-k3/am62px/Makefile            |  6 +++++
 arch/arm/mach-k3/{ => am62px}/am62p5_init.c |  5 ++--
 arch/arm/mach-k3/am62x/Makefile             |  3 +++
 arch/arm/mach-k3/{ => am62x}/am625_fdt.c    |  3 ++-
 arch/arm/mach-k3/{ => am62x}/am625_init.c   |  5 ++--
 arch/arm/mach-k3/am64x/Makefile             |  6 +++++
 arch/arm/mach-k3/{ => am64x}/am642_init.c   |  5 ++--
 arch/arm/mach-k3/am65x/Makefile             |  7 ++++++
 arch/arm/mach-k3/{ => am65x}/am654_fdt.c    |  3 ++-
 arch/arm/mach-k3/{ => am65x}/am654_init.c   |  5 ++--
 arch/arm/mach-k3/j721e/Makefile             |  7 ++++++
 arch/arm/mach-k3/{ => j721e}/j721e_fdt.c    |  3 ++-
 arch/arm/mach-k3/{ => j721e}/j721e_init.c   |  5 ++--
 arch/arm/mach-k3/j721s2/Makefile            |  7 ++++++
 arch/arm/mach-k3/{ => j721s2}/j721s2_fdt.c  |  3 ++-
 arch/arm/mach-k3/{ => j721s2}/j721s2_init.c |  5 ++--
 arch/arm/mach-k3/j784s4/Makefile            |  7 ++++++
 arch/arm/mach-k3/{ => j784s4}/j784s4_fdt.c  |  3 ++-
 arch/arm/mach-k3/{ => j784s4}/j784s4_init.c |  5 ++--
 23 files changed, 94 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62ax/Makefile
 rename arch/arm/mach-k3/{ => am62ax}/am62a7_fdt.c (93%)
 rename arch/arm/mach-k3/{ => am62ax}/am62a7_init.c (99%)
 create mode 100644 arch/arm/mach-k3/am62px/Makefile
 rename arch/arm/mach-k3/{ => am62px}/am62p5_init.c (99%)
 rename arch/arm/mach-k3/{ => am62x}/am625_fdt.c (98%)
 rename arch/arm/mach-k3/{ => am62x}/am625_init.c (99%)
 create mode 100644 arch/arm/mach-k3/am64x/Makefile
 rename arch/arm/mach-k3/{ => am64x}/am642_init.c (99%)
 create mode 100644 arch/arm/mach-k3/am65x/Makefile
 rename arch/arm/mach-k3/{ => am65x}/am654_fdt.c (88%)
 rename arch/arm/mach-k3/{ => am65x}/am654_init.c (99%)
 create mode 100644 arch/arm/mach-k3/j721e/Makefile
 rename arch/arm/mach-k3/{ => j721e}/j721e_fdt.c (88%)
 rename arch/arm/mach-k3/{ => j721e}/j721e_init.c (99%)
 create mode 100644 arch/arm/mach-k3/j721s2/Makefile
 rename arch/arm/mach-k3/{ => j721s2}/j721s2_fdt.c (88%)
 rename arch/arm/mach-k3/{ => j721s2}/j721s2_init.c (99%)
 create mode 100644 arch/arm/mach-k3/j784s4/Makefile
 rename arch/arm/mach-k3/{ => j784s4}/j784s4_fdt.c (92%)
 rename arch/arm/mach-k3/{ => j784s4}/j784s4_init.c (99%)

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 1bd523329a4..10e73463471 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -6,23 +6,12 @@
 obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
-ifeq ($(CONFIG_OF_LIBFDT)$(CONFIG_OF_SYSTEM_SETUP),yy)
-obj-$(CONFIG_SOC_K3_AM654) += am654_fdt.o
-obj-$(CONFIG_SOC_K3_J721E) += j721e_fdt.o
-obj-$(CONFIG_SOC_K3_J721S2) += j721s2_fdt.o
-obj-$(CONFIG_SOC_K3_AM625) += am625_fdt.o
-obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_fdt.o
-obj-$(CONFIG_SOC_K3_J784S4) += j784s4_fdt.o
-endif
-ifeq ($(CONFIG_SPL_BUILD),y)
-obj-$(CONFIG_SOC_K3_AM654) += am654_init.o
-obj-$(CONFIG_SOC_K3_J721E) += j721e_init.o
-obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
-obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
-obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
-obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
-obj-$(CONFIG_SOC_K3_J784S4) += j784s4_init.o
-obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_init.o
-endif
-obj-y += common.o security.o
+obj-$(CONFIG_SOC_K3_AM654) += am65x/
+obj-$(CONFIG_SOC_K3_J721E) += j721e/
+obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
+obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
+obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
+obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
+obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
+obj-y += common.o security.o
diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/am62ax/Makefile
new file mode 100644
index 00000000000..1717ca343d6
--- /dev/null
+++ b/arch/arm/mach-k3/am62ax/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am62a7_fdt.o
+obj-$(CONFIG_SPL_BUILD) += am62a7_init.o
diff --git a/arch/arm/mach-k3/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
similarity index 93%
rename from arch/arm/mach-k3/am62a7_fdt.c
rename to arch/arm/mach-k3/am62ax/am62a7_fdt.c
index d67f012a5dc..7f764ab36b5 100644
--- a/arch/arm/mach-k3/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -4,9 +4,10 @@
  */
 
 #include <asm/hardware.h>
-#include "common_fdt.h"
 #include <fdt_support.h>
 
+#include "../common_fdt.h"
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
diff --git a/arch/arm/mach-k3/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
similarity index 99%
rename from arch/arm/mach-k3/am62a7_init.c
rename to arch/arm/mach-k3/am62ax/am62a7_init.c
index 2a0221a3718..5a75aa8aeef 100644
--- a/arch/arm/mach-k3/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -8,12 +8,13 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 struct fwl_data cbass_main_fwls[] = {
        { "FSS_DAT_REG3", 7, 8 },
 };
diff --git a/arch/arm/mach-k3/am62px/Makefile b/arch/arm/mach-k3/am62px/Makefile
new file mode 100644
index 00000000000..5902862b29c
--- /dev/null
+++ b/arch/arm/mach-k3/am62px/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_SPL_BUILD) += am62p5_init.o
diff --git a/arch/arm/mach-k3/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
similarity index 99%
rename from arch/arm/mach-k3/am62p5_init.c
rename to arch/arm/mach-k3/am62px/am62p5_init.c
index aab99aa0c95..34ed01cd78c 100644
--- a/arch/arm/mach-k3/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -8,12 +8,13 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
 };
diff --git a/arch/arm/mach-k3/am62x/Makefile b/arch/arm/mach-k3/am62x/Makefile
index acf09c3426c..8494cdda482 100644
--- a/arch/arm/mach-k3/am62x/Makefile
+++ b/arch/arm/mach-k3/am62x/Makefile
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier:	GPL-2.0+
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am625_fdt.o
+obj-$(CONFIG_SPL_BUILD) += am625_init.o
 obj-y += boot.o
diff --git a/arch/arm/mach-k3/am625_fdt.c b/arch/arm/mach-k3/am62x/am625_fdt.c
similarity index 98%
rename from arch/arm/mach-k3/am625_fdt.c
rename to arch/arm/mach-k3/am62x/am625_fdt.c
index c56adef13bd..8fe200a4231 100644
--- a/arch/arm/mach-k3/am625_fdt.c
+++ b/arch/arm/mach-k3/am62x/am625_fdt.c
@@ -4,9 +4,10 @@
  */
 
 #include <asm/hardware.h>
-#include "common_fdt.h"
 #include <fdt_support.h>
 
+#include "../common_fdt.h"
+
 static void fdt_fixup_cores_nodes_am625(void *blob, int core_nr)
 {
 	char node_path[32];
diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
similarity index 99%
rename from arch/arm/mach-k3/am625_init.c
rename to arch/arm/mach-k3/am62x/am625_init.c
index 668f9a51ef4..ed8d24e0433 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -9,13 +9,14 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 #include <dm/ofnode.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 #define RTC_BASE_ADDRESS		0x2b1f0000
 #define REG_K3RTC_S_CNT_LSW		(RTC_BASE_ADDRESS + 0x18)
 #define REG_K3RTC_KICK0			(RTC_BASE_ADDRESS + 0x70)
diff --git a/arch/arm/mach-k3/am64x/Makefile b/arch/arm/mach-k3/am64x/Makefile
new file mode 100644
index 00000000000..b6d3432a10d
--- /dev/null
+++ b/arch/arm/mach-k3/am64x/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_SPL_BUILD) += am642_init.o
diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
similarity index 99%
rename from arch/arm/mach-k3/am642_init.c
rename to arch/arm/mach-k3/am64x/am642_init.c
index ddf47ef0a9b..86297424aa4 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am64x/am642_init.c
@@ -11,8 +11,6 @@
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
@@ -21,6 +19,9 @@
 #include <dm/root.h>
 #include <command.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 #define CTRLMMR_MCU_RST_CTRL			0x04518170
 
 #define CTRLMMR_MCU_RST_SRC                    (MCU_CTRL_MMR0_BASE + 0x18178)
diff --git a/arch/arm/mach-k3/am65x/Makefile b/arch/arm/mach-k3/am65x/Makefile
new file mode 100644
index 00000000000..20d5f1d3bf1
--- /dev/null
+++ b/arch/arm/mach-k3/am65x/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am654_fdt.o
+obj-$(CONFIG_SPL_BUILD) += am654_init.o
diff --git a/arch/arm/mach-k3/am654_fdt.c b/arch/arm/mach-k3/am65x/am654_fdt.c
similarity index 88%
rename from arch/arm/mach-k3/am654_fdt.c
rename to arch/arm/mach-k3/am65x/am654_fdt.c
index 652fe8d32bb..bcb15208be9 100644
--- a/arch/arm/mach-k3/am654_fdt.c
+++ b/arch/arm/mach-k3/am65x/am654_fdt.c
@@ -3,9 +3,10 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
-#include "common_fdt.h"
 #include <fdt_support.h>
 
+#include "../common_fdt.h"
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/am654_init.c b/arch/arm/mach-k3/am65x/am654_init.c
similarity index 99%
rename from arch/arm/mach-k3/am654_init.c
rename to arch/arm/mach-k3/am65x/am654_init.c
index 7c2a143ed1b..a4f038029d7 100644
--- a/arch/arm/mach-k3/am654_init.c
+++ b/arch/arm/mach-k3/am65x/am654_init.c
@@ -12,8 +12,6 @@
 #include <asm/io.h>
 #include <spl.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
@@ -22,6 +20,9 @@
 #include <mmc.h>
 #include <stdlib.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #ifdef CONFIG_K3_LOAD_SYSFW
diff --git a/arch/arm/mach-k3/j721e/Makefile b/arch/arm/mach-k3/j721e/Makefile
new file mode 100644
index 00000000000..982b88db57d
--- /dev/null
+++ b/arch/arm/mach-k3/j721e/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += j721e_fdt.o
+obj-$(CONFIG_SPL_BUILD) += j721e_init.o
diff --git a/arch/arm/mach-k3/j721e_fdt.c b/arch/arm/mach-k3/j721e/j721e_fdt.c
similarity index 88%
rename from arch/arm/mach-k3/j721e_fdt.c
rename to arch/arm/mach-k3/j721e/j721e_fdt.c
index 652fe8d32bb..bcb15208be9 100644
--- a/arch/arm/mach-k3/j721e_fdt.c
+++ b/arch/arm/mach-k3/j721e/j721e_fdt.c
@@ -3,9 +3,10 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
-#include "common_fdt.h"
 #include <fdt_support.h>
 
+#include "../common_fdt.h"
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
similarity index 99%
rename from arch/arm/mach-k3/j721e_init.c
rename to arch/arm/mach-k3/j721e/j721e_init.c
index 7ee9b75de4d..c2024f2500d 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -11,8 +11,6 @@
 #include <asm/io.h>
 #include <asm/armv7_mpu.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
@@ -22,6 +20,9 @@
 #include <mmc.h>
 #include <remoteproc.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 #ifdef CONFIG_K3_LOAD_SYSFW
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 #if defined(CONFIG_TARGET_J721E_R5_EVM)
diff --git a/arch/arm/mach-k3/j721s2/Makefile b/arch/arm/mach-k3/j721s2/Makefile
new file mode 100644
index 00000000000..ceef68297c9
--- /dev/null
+++ b/arch/arm/mach-k3/j721s2/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += j721s2_fdt.o
+obj-$(CONFIG_SPL_BUILD) += j721s2_init.o
diff --git a/arch/arm/mach-k3/j721s2_fdt.c b/arch/arm/mach-k3/j721s2/j721s2_fdt.c
similarity index 88%
rename from arch/arm/mach-k3/j721s2_fdt.c
rename to arch/arm/mach-k3/j721s2/j721s2_fdt.c
index 652fe8d32bb..bcb15208be9 100644
--- a/arch/arm/mach-k3/j721s2_fdt.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_fdt.c
@@ -3,9 +3,10 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
-#include "common_fdt.h"
 #include <fdt_support.h>
 
+#include "../common_fdt.h"
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
similarity index 99%
rename from arch/arm/mach-k3/j721s2_init.c
rename to arch/arm/mach-k3/j721s2/j721s2_init.c
index 3374889558a..fe9766e9b4b 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -11,8 +11,6 @@
 #include <asm/io.h>
 #include <asm/armv7_mpu.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
@@ -21,6 +19,9 @@
 #include <mmc.h>
 #include <remoteproc.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 	{ "PCIE0_CFG", 2577, 7 },
 	{ "EMMC8SS0_CFG", 2579, 4 },
diff --git a/arch/arm/mach-k3/j784s4/Makefile b/arch/arm/mach-k3/j784s4/Makefile
new file mode 100644
index 00000000000..6d1841e3f9e
--- /dev/null
+++ b/arch/arm/mach-k3/j784s4/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += j784s4_fdt.o
+obj-$(CONFIG_SPL_BUILD) += j784s4_init.o
diff --git a/arch/arm/mach-k3/j784s4_fdt.c b/arch/arm/mach-k3/j784s4/j784s4_fdt.c
similarity index 92%
rename from arch/arm/mach-k3/j784s4_fdt.c
rename to arch/arm/mach-k3/j784s4/j784s4_fdt.c
index d05ed8b9911..e1275097051 100644
--- a/arch/arm/mach-k3/j784s4_fdt.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_fdt.c
@@ -6,9 +6,10 @@
  *	Apurva Nandan <a-nandan@ti.com>
  */
 
-#include "common_fdt.h"
 #include <fdt_support.h>
 
+#include "../common_fdt.h"
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
similarity index 99%
rename from arch/arm/mach-k3/j784s4_init.c
rename to arch/arm/mach-k3/j784s4/j784s4_init.c
index ae4420362d0..1ce13e0f494 100644
--- a/arch/arm/mach-k3/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -11,8 +11,6 @@
 #include <asm/io.h>
 #include <asm/armv7_mpu.h>
 #include <asm/arch/hardware.h>
-#include "sysfw-loader.h"
-#include "common.h"
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
@@ -20,6 +18,9 @@
 #include <mmc.h>
 #include <remoteproc.h>
 
+#include "../sysfw-loader.h"
+#include "../common.h"
+
 #define J784S4_MAX_DDR_CONTROLLERS	4
 
 struct fwl_data infra_cbass0_fwls[] = {
-- 
2.39.2

