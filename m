Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38300C4828D
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C5987D7F;
	Fri,  2 Feb 2024 01:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cOGJnUnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A92787D67; Fri,  2 Feb 2024 01:25:04 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B0887D2F
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4120Oowe026529;
 Thu, 1 Feb 2024 18:24:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706833490;
 bh=0X5PF8yWHfu4ZLpLNZuoPiWYZof1mTleHvm6anXcGrA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=cOGJnUnnk5RXQyhDGFjP3+4myml/kH/bc3DwbvKXNZv79IvQ3vXg09EgOghBsB0af
 JnUiAllNo/tHBtkq1I1weAAa177VZXLuehrgZWKJ0OO5kIROII1OybIMqq7uMil8pz
 sTwc3cwwk08jobMtPiJFJU8zEnvy/EGZes5prZ9w=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4120Oonl003054
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 18:24:50 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 18:24:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 18:24:49 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4120OnBh107441;
 Thu, 1 Feb 2024 18:24:49 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/6] arm: mach-k3: Move disable_linefill_optimization() into
 R5 directory
Date: Thu, 1 Feb 2024 18:24:44 -0600
Message-ID: <20240202002448.1116407-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
References: <20240202002448.1116407-1-afd@ti.com>
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

The disable_linefill_optimization() function is only ever loaded by the
R5 core, move the code into the R5 directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/common.c    | 25 -------------------------
 arch/arm/mach-k3/r5/Makefile |  1 +
 arch/arm/mach-k3/r5/common.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-k3/r5/common.c

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index f411366778f..5d53efed85b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -453,31 +453,6 @@ void board_prep_linux(struct bootm_headers *images)
 }
 #endif
 
-#ifdef CONFIG_CPU_V7R
-void disable_linefill_optimization(void)
-{
-	u32 actlr;
-
-	/*
-	 * On K3 devices there are 2 conditions where R5F can deadlock:
-	 * 1.When software is performing series of store operations to
-	 *   cacheable write back/write allocate memory region and later
-	 *   on software execute barrier operation (DSB or DMB). R5F may
-	 *   hang at the barrier instruction.
-	 * 2.When software is performing a mix of load and store operations
-	 *   within a tight loop and store operations are all writing to
-	 *   cacheable write back/write allocates memory regions, R5F may
-	 *   hang at one of the load instruction.
-	 *
-	 * To avoid the above two conditions disable linefill optimization
-	 * inside Cortex R5F.
-	 */
-	asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (actlr));
-	actlr |= (1 << 13); /* Set DLFO bit  */
-	asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
-}
-#endif
-
 static void remove_fwl_regions(struct fwl_data fwl_data, size_t num_regions,
 			       enum k3_firewall_region_type fwl_type)
 {
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index b99199d3374..8ad86eb2798 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 
+obj-y += common.o
 obj-y += lowlevel_init.o
 obj-y += r5_mpu.o
 
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
new file mode 100644
index 00000000000..ef81f50c6c7
--- /dev/null
+++ b/arch/arm/mach-k3/r5/common.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * K3: R5 Common Architecture initialization
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/types.h>
+#include <asm/hardware.h>
+#include <asm/io.h>
+
+#include "../common.h"
+
+void disable_linefill_optimization(void)
+{
+	u32 actlr;
+
+	/*
+	 * On K3 devices there are 2 conditions where R5F can deadlock:
+	 * 1.When software is performing series of store operations to
+	 *   cacheable write back/write allocate memory region and later
+	 *   on software execute barrier operation (DSB or DMB). R5F may
+	 *   hang at the barrier instruction.
+	 * 2.When software is performing a mix of load and store operations
+	 *   within a tight loop and store operations are all writing to
+	 *   cacheable write back/write allocates memory regions, R5F may
+	 *   hang at one of the load instruction.
+	 *
+	 * To avoid the above two conditions disable linefill optimization
+	 * inside Cortex R5F.
+	 */
+	asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (actlr));
+	actlr |= (1 << 13); /* Set DLFO bit  */
+	asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
+}
-- 
2.39.2

