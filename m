Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799B3C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D3187DF3;
	Wed, 14 Feb 2024 17:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZbHFhTDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254A187EDB; Wed, 14 Feb 2024 17:30:30 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2ED87E45
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EGUCnv103514;
 Wed, 14 Feb 2024 10:30:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707928212;
 bh=BKLgxD648v7wb9LOYJX56Tei6tP5nbHvZUIP7aIB5Ys=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZbHFhTDgZ2ldOgM7QekRn4Oa4aG75/aotbODWVTv+s4dxxaallc8mOeMH7LxPOqyH
 7me6POiZqDUP49MdcBrP6DPfBIkgc3/nS551bLnmQy4fiYcTqESUyhixfP+kUON2Zu
 SWn/Imw6UwPAp7slpCuU8h8kGLqyKMBCAn2TEoGI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EGUC7K028193
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Feb 2024 10:30:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 10:30:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 10:30:11 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EGU9rw014388;
 Wed, 14 Feb 2024 10:30:11 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/6] arm: mach-k3: am62a: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Date: Wed, 14 Feb 2024 10:30:08 -0600
Message-ID: <20240214163009.983034-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214163009.983034-1-afd@ti.com>
References: <20240214163009.983034-1-afd@ti.com>
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

The address we load TFA and OP-TEE to is configurable by
CONFIG_K3_{ATF,OPTEE}_LOAD_ADDR, but the DT nodes reserving this memory
are static. Fix that by updating this node when the loaded address
does not match the address in DT.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Makefile       |  1 +
 arch/arm/mach-k3/am62a7_fdt.c   | 16 ++++++++++++++++
 arch/arm/mach-k3/am62ax/Kconfig |  1 +
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm/mach-k3/am62a7_fdt.c

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 42161376469..fdb442773e3 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SOC_K3_AM654) += am654_fdt.o
 obj-$(CONFIG_SOC_K3_J721E) += j721e_fdt.o
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2_fdt.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_fdt.o
+obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_fdt.o
 endif
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_SOC_K3_AM654) += am654_init.o
diff --git a/arch/arm/mach-k3/am62a7_fdt.c b/arch/arm/mach-k3/am62a7_fdt.c
new file mode 100644
index 00000000000..d67f012a5dc
--- /dev/null
+++ b/arch/arm/mach-k3/am62a7_fdt.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/hardware.h>
+#include "common_fdt.h"
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
+	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index c5f1ef87126..bbd5497f2ae 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -13,6 +13,7 @@ config TARGET_AM62A7_A53_EVM
 	bool "TI K3 based AM62A7 EVM running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 	imply BOARD
 	imply SPL_BOARD
 	imply TI_I2C_BOARD_DETECT
-- 
2.39.2

