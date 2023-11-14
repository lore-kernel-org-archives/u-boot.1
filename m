Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC71C4167D
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB228722B;
	Tue, 14 Nov 2023 17:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hmhmUYoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B6586940; Tue, 14 Nov 2023 17:00:07 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72723871D0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AEFxwFv034345;
 Tue, 14 Nov 2023 09:59:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699977598;
 bh=EFqrWhPI4ghJEXVGCrZ4z8/XfPL8KluYzvYzdEMMK7k=;
 h=From:To:CC:Subject:Date;
 b=hmhmUYoJpzNsO+pSWANMl5Y7lBIsVbG4TjKKJ7TUdp21QGcjC54eNlQTw4VqEiBAx
 3uL6Ia93nwCkQEMLH31HGfBKBlZkbEYZqjDtyo/awNQnU6g8H8X2vUn9z5FQipHCFh
 5ooza2IhqmmqF2agu61nrkmQfY84fOj5iV06iz5o=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AEFxvvn004344
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 09:59:57 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 09:59:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 09:59:57 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AEFxvpT021295;
 Tue, 14 Nov 2023 09:59:57 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/3] arm: mach-k3: Move R5 specific code into new r5/ directory
Date: Tue, 14 Nov 2023 09:59:48 -0600
Message-ID: <20231114155950.296644-1-afd@ti.com>
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

This makes it clear these are only to be used by the R5 builds of SPL.
And this will be used to later more cleanly split the two builds.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Makefile                         |  6 +-----
 arch/arm/mach-k3/r5/Makefile                      | 13 +++++++++++++
 arch/arm/mach-k3/{ => r5}/am62ax/Makefile         |  0
 arch/arm/mach-k3/{ => r5}/am62ax/am62a_qos_data.c |  0
 arch/arm/mach-k3/{ => r5}/am62ax/clk-data.c       |  0
 arch/arm/mach-k3/{ => r5}/am62ax/dev-data.c       |  0
 arch/arm/mach-k3/{ => r5}/am62x/Makefile          |  0
 arch/arm/mach-k3/{ => r5}/am62x/clk-data.c        |  0
 arch/arm/mach-k3/{ => r5}/am62x/dev-data.c        |  0
 arch/arm/mach-k3/{ => r5}/j7200/Makefile          |  0
 arch/arm/mach-k3/{ => r5}/j7200/clk-data.c        |  0
 arch/arm/mach-k3/{ => r5}/j7200/dev-data.c        |  0
 arch/arm/mach-k3/{ => r5}/j721e/Makefile          |  0
 arch/arm/mach-k3/{ => r5}/j721e/clk-data.c        |  0
 arch/arm/mach-k3/{ => r5}/j721e/dev-data.c        |  0
 arch/arm/mach-k3/{ => r5}/j721s2/Makefile         |  0
 arch/arm/mach-k3/{ => r5}/j721s2/clk-data.c       |  0
 arch/arm/mach-k3/{ => r5}/j721s2/dev-data.c       |  0
 arch/arm/mach-k3/{ => r5}/lowlevel_init.S         |  0
 arch/arm/mach-k3/{ => r5}/r5_mpu.c                |  2 +-
 20 files changed, 15 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-k3/r5/Makefile
 rename arch/arm/mach-k3/{ => r5}/am62ax/Makefile (100%)
 rename arch/arm/mach-k3/{ => r5}/am62ax/am62a_qos_data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/am62ax/clk-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/am62ax/dev-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/am62x/Makefile (100%)
 rename arch/arm/mach-k3/{ => r5}/am62x/clk-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/am62x/dev-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/j7200/Makefile (100%)
 rename arch/arm/mach-k3/{ => r5}/j7200/clk-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/j7200/dev-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/j721e/Makefile (100%)
 rename arch/arm/mach-k3/{ => r5}/j721e/clk-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/j721e/dev-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/j721s2/Makefile (100%)
 rename arch/arm/mach-k3/{ => r5}/j721s2/clk-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/j721s2/dev-data.c (100%)
 rename arch/arm/mach-k3/{ => r5}/lowlevel_init.S (100%)
 rename arch/arm/mach-k3/{ => r5}/r5_mpu.c (98%)

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index c7ca0fdce56..215c755c5dc 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -3,12 +3,8 @@
 # Copyright (C) 2017-2018 Texas Instruments Incorporated - https://www.ti.com/
 #	Lokesh Vutla <lokeshvutla@ti.com>
 
-obj-$(CONFIG_SOC_K3_J721E) += j721e/ j7200/
-obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
-obj-$(CONFIG_SOC_K3_AM625) += am62x/
-obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
+obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_ARM64) += arm64-mmu.o
-obj-$(CONFIG_CPU_V7R) += r5_mpu.o lowlevel_init.o
 obj-$(CONFIG_ARM64) += cache.o
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
 ifeq ($(CONFIG_OF_LIBFDT)$(CONFIG_OF_SYSTEM_SETUP),yy)
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
new file mode 100644
index 00000000000..8a6af73a44e
--- /dev/null
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_SOC_K3_J721E) += j721e/
+obj-$(CONFIG_SOC_K3_J721E) += j7200/
+obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
+obj-$(CONFIG_SOC_K3_AM625) += am62x/
+obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
+
+obj-y += lowlevel_init.o
+obj-y += r5_mpu.o
diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/r5/am62ax/Makefile
similarity index 100%
rename from arch/arm/mach-k3/am62ax/Makefile
rename to arch/arm/mach-k3/r5/am62ax/Makefile
diff --git a/arch/arm/mach-k3/am62ax/am62a_qos_data.c b/arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
similarity index 100%
rename from arch/arm/mach-k3/am62ax/am62a_qos_data.c
rename to arch/arm/mach-k3/r5/am62ax/am62a_qos_data.c
diff --git a/arch/arm/mach-k3/am62ax/clk-data.c b/arch/arm/mach-k3/r5/am62ax/clk-data.c
similarity index 100%
rename from arch/arm/mach-k3/am62ax/clk-data.c
rename to arch/arm/mach-k3/r5/am62ax/clk-data.c
diff --git a/arch/arm/mach-k3/am62ax/dev-data.c b/arch/arm/mach-k3/r5/am62ax/dev-data.c
similarity index 100%
rename from arch/arm/mach-k3/am62ax/dev-data.c
rename to arch/arm/mach-k3/r5/am62ax/dev-data.c
diff --git a/arch/arm/mach-k3/am62x/Makefile b/arch/arm/mach-k3/r5/am62x/Makefile
similarity index 100%
rename from arch/arm/mach-k3/am62x/Makefile
rename to arch/arm/mach-k3/r5/am62x/Makefile
diff --git a/arch/arm/mach-k3/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
similarity index 100%
rename from arch/arm/mach-k3/am62x/clk-data.c
rename to arch/arm/mach-k3/r5/am62x/clk-data.c
diff --git a/arch/arm/mach-k3/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
similarity index 100%
rename from arch/arm/mach-k3/am62x/dev-data.c
rename to arch/arm/mach-k3/r5/am62x/dev-data.c
diff --git a/arch/arm/mach-k3/j7200/Makefile b/arch/arm/mach-k3/r5/j7200/Makefile
similarity index 100%
rename from arch/arm/mach-k3/j7200/Makefile
rename to arch/arm/mach-k3/r5/j7200/Makefile
diff --git a/arch/arm/mach-k3/j7200/clk-data.c b/arch/arm/mach-k3/r5/j7200/clk-data.c
similarity index 100%
rename from arch/arm/mach-k3/j7200/clk-data.c
rename to arch/arm/mach-k3/r5/j7200/clk-data.c
diff --git a/arch/arm/mach-k3/j7200/dev-data.c b/arch/arm/mach-k3/r5/j7200/dev-data.c
similarity index 100%
rename from arch/arm/mach-k3/j7200/dev-data.c
rename to arch/arm/mach-k3/r5/j7200/dev-data.c
diff --git a/arch/arm/mach-k3/j721e/Makefile b/arch/arm/mach-k3/r5/j721e/Makefile
similarity index 100%
rename from arch/arm/mach-k3/j721e/Makefile
rename to arch/arm/mach-k3/r5/j721e/Makefile
diff --git a/arch/arm/mach-k3/j721e/clk-data.c b/arch/arm/mach-k3/r5/j721e/clk-data.c
similarity index 100%
rename from arch/arm/mach-k3/j721e/clk-data.c
rename to arch/arm/mach-k3/r5/j721e/clk-data.c
diff --git a/arch/arm/mach-k3/j721e/dev-data.c b/arch/arm/mach-k3/r5/j721e/dev-data.c
similarity index 100%
rename from arch/arm/mach-k3/j721e/dev-data.c
rename to arch/arm/mach-k3/r5/j721e/dev-data.c
diff --git a/arch/arm/mach-k3/j721s2/Makefile b/arch/arm/mach-k3/r5/j721s2/Makefile
similarity index 100%
rename from arch/arm/mach-k3/j721s2/Makefile
rename to arch/arm/mach-k3/r5/j721s2/Makefile
diff --git a/arch/arm/mach-k3/j721s2/clk-data.c b/arch/arm/mach-k3/r5/j721s2/clk-data.c
similarity index 100%
rename from arch/arm/mach-k3/j721s2/clk-data.c
rename to arch/arm/mach-k3/r5/j721s2/clk-data.c
diff --git a/arch/arm/mach-k3/j721s2/dev-data.c b/arch/arm/mach-k3/r5/j721s2/dev-data.c
similarity index 100%
rename from arch/arm/mach-k3/j721s2/dev-data.c
rename to arch/arm/mach-k3/r5/j721s2/dev-data.c
diff --git a/arch/arm/mach-k3/lowlevel_init.S b/arch/arm/mach-k3/r5/lowlevel_init.S
similarity index 100%
rename from arch/arm/mach-k3/lowlevel_init.S
rename to arch/arm/mach-k3/r5/lowlevel_init.S
diff --git a/arch/arm/mach-k3/r5_mpu.c b/arch/arm/mach-k3/r5/r5_mpu.c
similarity index 98%
rename from arch/arm/mach-k3/r5_mpu.c
rename to arch/arm/mach-k3/r5/r5_mpu.c
index 605f7931518..e409fdcfea8 100644
--- a/arch/arm/mach-k3/r5_mpu.c
+++ b/arch/arm/mach-k3/r5/r5_mpu.c
@@ -9,7 +9,7 @@
 #include <common.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
-#include "common.h"
+#include <asm/armv7_mpu.h>
 
 struct mpu_region_config k3_mpu_regions[16] = {
 	/*
-- 
2.39.2

