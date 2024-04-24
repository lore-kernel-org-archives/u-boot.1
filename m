Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF9EC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB4E887A5;
	Wed, 24 Apr 2024 14:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PA5Z1shW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD093887B4; Wed, 24 Apr 2024 14:53:46 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57EC887AC
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713963224; x=1716555224;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9nQsr/ujXNUvMCd59VLlgaFVuxTfaDvxVX3O60zqSVw=;
 b=PA5Z1shWQdK83fcUqc8RZO20uzrumZfqqa3omof7ePB57QcQBBDEEJjIm/3WWfdA
 Lt6LY9nCe9k/gG3sZBtEzD8VGBgDZXGqFsLj4OCmED8tc339uE8nvcsYVTGdJnas
 yY7m9GKU8YLwR6wB0+aT+auk4eUT4WCujA0kmTF7OcE=;
X-AuditID: ac14000a-fadff7000000290d-32-662900d8e4b4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 19.3A.10509.8D009266;
 Wed, 24 Apr 2024 14:53:44 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Apr
 2024 14:53:44 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 1/2] board: phytec: Commonize board code for K3 based SoMs
Date: Wed, 24 Apr 2024 14:53:34 +0200
Message-ID: <20240424125335.2306132-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424125335.2306132-1-w.egorov@phytec.de>
References: <20240424125335.2306132-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWyRpKBR/cGg2aawY/H6hZv93ayW3S/U3dg
 8jh7ZwejR393C2sAUxSXTUpqTmZZapG+XQJXxo6zr1gKjqhVbJr7grWB8Y18FyMnh4SAicSC
 VfMYuxi5OIQEljBJzN1/ig3Cecwo8eraEVaQKjYBdYk7G76B2SICUhIvOzcydzFycDALyEks
 6y8CCQsLeElcPDiLESTMIqAqcagxGCTMK2Ap8WvBSiaIXfISMy99ZwexOQWsJKZPnQZmCwHV
 rO6/yg5RLyhxcuYTFhCbGai+eetsZghbQuLgixfMEPXyEi8uLWeBmTnt3GtmCDtUYuuX7UwT
 GIVmIRk1C8moWUhGLWBkXsUolJuZnJ1alJmtV5BRWZKarJeSuokRFLwiDFw7GPvmeBxiZOJg
 PMQowcGsJMJ786NGmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZ
 Jg5OqQbG9ND1Gfx7YjM4Fkns+9rKH9iSMmlSpupZ27aHSuKbJjI89Xs054bqS5MrVZor2m4n
 ZQg84esu5H3o46MovstU0DDzhZ9ZxLl9jg0iB9mWmn/kS+h7Pe3nsRWcTevZ1m+sXM4jbmvt
 eC135o6Ejk27Hr9SWScqkizz1kUp7NTyE1WMFve3CJUrsRRnJBpqMRcVJwIAA0dChEwCAAA=
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

Environment handling code can be reused across all our K3 based SoMs.
Instead of adding the same code for every new SoM, move it to a common
board.c file.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/Makefile               |  2 +
 board/phytec/common/k3/Makefile            |  2 +
 board/phytec/common/k3/board.c             | 73 ++++++++++++++++++++++
 board/phytec/phycore_am62x/phycore-am62x.c | 67 --------------------
 4 files changed, 77 insertions(+), 67 deletions(-)
 create mode 100644 board/phytec/common/k3/Makefile
 create mode 100644 board/phytec/common/k3/board.c

diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 35c81741306..0c738041565 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -5,6 +5,8 @@
 ifdef CONFIG_SPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
+else
+obj-$(CONFIG_ARCH_K3) += k3/
 endif
 
 obj-y += phytec_som_detection.o
diff --git a/board/phytec/common/k3/Makefile b/board/phytec/common/k3/Makefile
new file mode 100644
index 00000000000..bcca1a9f846
--- /dev/null
+++ b/board/phytec/common/k3/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+obj-y += board.o
diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
new file mode 100644
index 00000000000..9cb168c36cb
--- /dev/null
+++ b/board/phytec/common/k3/board.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#include <env_internal.h>
+#include <spl.h>
+#include <asm/arch/hardware.h>
+
+#if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
+int mmc_get_env_dev(void)
+{
+	u32 boot_device = get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		return 0;
+	case BOOT_DEVICE_MMC2:
+		return 1;
+	};
+
+	return CONFIG_SYS_MMC_ENV_DEV;
+}
+#endif
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u32 boot_device = get_boot_device();
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+			return ENVL_MMC;
+	case BOOT_DEVICE_SPI:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+	default:
+		return ENVL_NOWHERE;
+	};
+}
+
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	u32 boot_device = get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		env_set_ulong("mmcdev", 0);
+		env_set("boot", "mmc");
+		break;
+	case BOOT_DEVICE_MMC2:
+		env_set_ulong("mmcdev", 1);
+		env_set("boot", "mmc");
+		break;
+	case BOOT_DEVICE_SPI:
+		env_set("boot", "spi");
+		break;
+	case BOOT_DEVICE_ETHERNET:
+		env_set("boot", "net");
+		break;
+	};
+
+	return 0;
+}
+#endif
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 618b4c370d1..a082b886bda 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -5,11 +5,8 @@
  */
 
 #include <asm/io.h>
-#include <env.h>
-#include <env_internal.h>
 #include <spl.h>
 #include <fdt_support.h>
-#include <asm/arch/hardware.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -57,67 +54,3 @@ void spl_board_init(void)
 	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
 }
 #endif
-
-#if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
-int mmc_get_env_dev(void)
-{
-	u32 boot_device = get_boot_device();
-
-	switch (boot_device) {
-	case BOOT_DEVICE_MMC1:
-		return 0;
-	case BOOT_DEVICE_MMC2:
-		return 1;
-	};
-
-	return CONFIG_SYS_MMC_ENV_DEV;
-}
-#endif
-
-enum env_location env_get_location(enum env_operation op, int prio)
-{
-	u32 boot_device = get_boot_device();
-
-	if (prio)
-		return ENVL_UNKNOWN;
-
-	switch (boot_device) {
-	case BOOT_DEVICE_MMC1:
-	case BOOT_DEVICE_MMC2:
-		if (CONFIG_IS_ENABLED(ENV_IS_IN_FAT))
-			return ENVL_FAT;
-		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
-			return ENVL_MMC;
-	case BOOT_DEVICE_SPI:
-		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
-			return ENVL_SPI_FLASH;
-	default:
-		return ENVL_NOWHERE;
-	};
-}
-
-#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
-int board_late_init(void)
-{
-	u32 boot_device = get_boot_device();
-
-	switch (boot_device) {
-	case BOOT_DEVICE_MMC1:
-		env_set_ulong("mmcdev", 0);
-		env_set("boot", "mmc");
-		break;
-	case BOOT_DEVICE_MMC2:
-		env_set_ulong("mmcdev", 1);
-		env_set("boot", "mmc");
-		break;
-	case BOOT_DEVICE_SPI:
-		env_set("boot", "spi");
-		break;
-	case BOOT_DEVICE_ETHERNET:
-		env_set("boot", "net");
-		break;
-	};
-
-	return 0;
-}
-#endif
-- 
2.34.1

