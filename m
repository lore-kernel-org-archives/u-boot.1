Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004C3C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 20:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2180B885FA;
	Fri, 19 Apr 2024 22:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H+P7gHst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285AC885AC; Fri, 19 Apr 2024 22:58:01 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D32B88668
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvkkx120844;
 Fri, 19 Apr 2024 15:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713560266;
 bh=Q/3JpoFtf1mfdBP6WOpW2/Quej/LgRm0c7DQW8Ronf8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=H+P7gHst6WOAXlYIMUR79w1rTedGL7Guqjml2RauYlm89rQUUuApsy26nWdSZ/7Uu
 KKLXKJOuY4WTALTno6ATm/a1yDq2snqjQ3YKPz0ttdnVn7s0F08uAV1958kSDyfm7Y
 BAfYoBlCZe7vuh9S5WnzSKismwMAinLH3KjQzkgA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JKvkRY068353
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 15:57:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 15:57:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 15:57:45 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvj2h090940;
 Fri, 19 Apr 2024 15:57:45 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v3 18/19] board: beagleboneai64: Define capsule update
 firmware info
Date: Fri, 19 Apr 2024 15:57:00 -0500
Message-ID: <20240419205701.163821-19-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419205701.163821-1-j-humphreys@ti.com>
References: <20240419205701.163821-1-j-humphreys@ti.com>
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

Define the firmware components updatable via EFI capsule update, including
defining capsule GUIDs for the various firmware components for the
BeagleBoneAI64.

Note this involved creating BeagleBoneAI64's own beagleboneai64.h board header
file instead of reusing j721e_evm's.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/beagle/beagleboneai64/Kconfig          |  4 +-
 board/beagle/beagleboneai64/beagleboneai64.c | 38 ++++++++++++++
 include/configs/beagleboneai64.h             | 55 ++++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 include/configs/beagleboneai64.h

diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
index 7cfccf9baf0..0f21582614d 100644
--- a/board/beagle/beagleboneai64/Kconfig
+++ b/board/beagle/beagleboneai64/Kconfig
@@ -37,7 +37,7 @@ config SYS_VENDOR
        default "beagle"
 
 config SYS_CONFIG_NAME
-       default "j721e_evm"
+       default "beagleboneai64"
 
 source "board/ti/common/Kconfig"
 
@@ -52,7 +52,7 @@ config SYS_VENDOR
        default "beagle"
 
 config SYS_CONFIG_NAME
-       default "j721e_evm"
+       default "beagleboneai64"
 
 source "board/ti/common/Kconfig"
 
diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
index c5b4ff7df47..05dec405b81 100644
--- a/board/beagle/beagleboneai64/beagleboneai64.c
+++ b/board/beagle/beagleboneai64/beagleboneai64.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
+#include <efi_loader.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <fdt_support.h>
@@ -14,6 +15,43 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"BEAGLEBONEAI64_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = BEAGLEBONEAI64_SPL_IMAGE_GUID,
+		.fw_name = u"BEAGLEBONEAI64_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = BEAGLEBONEAI64_UBOOT_IMAGE_GUID,
+		.fw_name = u"BEAGLEBONEAI64_UBOOT",
+		.image_index = 3,
+	},
+	{
+		.image_type_id = BEAGLEBONEAI64_SYSFW_IMAGE_GUID,
+		.fw_name = u"BEAGLEBONEAI64_SYSFW",
+		.image_index = 4,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=tiboot3.bin raw 0 2000 mmcpart 1;tispl.bin fat 0 1;u-boot.img fat 0 1; sysfw.itb fat 0 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	env_set("dfu_alt_info", update_info.dfu_string);
+}
+
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_init(void)
 {
 	return 0;
diff --git a/include/configs/beagleboneai64.h b/include/configs/beagleboneai64.h
new file mode 100644
index 00000000000..0fcf403c1c4
--- /dev/null
+++ b/include/configs/beagleboneai64.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Configuration header file for BeagleBoneAI64
+ *
+ * https://beagleboard.org/ai-64
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __CONFIG_BEAGLEBONEAI64_H
+#define __CONFIG_BEAGLEBONEAI64_H
+
+/* FLASH Configuration */
+#define CFG_SYS_FLASH_BASE		0x000000000
+
+/* SPL Loader Configuration */
+#define CFG_SYS_UBOOT_BASE		0x50080000
+
+/**
+ * define BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID - firmware GUID for BeagleBoneAI64
+ *                                            tiboot3.bin
+ * define BEAGLEBONEAI64_SPL_IMAGE_GUID     - firmware GUID for BeagleBoneAI64
+ *                                            SPL
+ * define BEAGLEBONEAI64_UBOOT_IMAGE_GUID   - firmware GUID for BeagleBoneAI64
+ *                                            UBOOT
+ * define BEAGLEBONEAI64_SYSFW_IMAGE_GUID   - firmware GUID for BeagleBoneAI64
+ *                                            SYSFW
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0x772a4810, 0x2194, 0x4923, 0x87, 0x54, \
+		0x01, 0x15, 0x87, 0x0e, 0xf3, 0x67)
+
+#define BEAGLEBONEAI64_SPL_IMAGE_GUID \
+	EFI_GUID(0x83447222, 0x1e26, 0x40cd, 0xa3, 0x95, \
+		0xb7, 0xde, 0x09, 0x57, 0xe8, 0x75)
+
+#define BEAGLEBONEAI64_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x4249ff77, 0xc17d, 0x4eb7, 0xa1, 0xdb, \
+		0x45, 0xaa, 0x98, 0x87, 0xd4, 0x9e)
+
+#define BEAGLEBONEAI64_SYSFW_IMAGE_GUID \
+	EFI_GUID(0xdfc9c683, 0x49b7, 0x46bd, 0xb3, 0xc1, \
+		0x3a, 0x3b, 0x2f, 0xdb, 0x13, 0x5b)
+
+/* Now for the remaining common defines */
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_BEAGLEBONEAI64_H */
-- 
2.34.1

