Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BFC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F60888563;
	Sat,  8 Jun 2024 00:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lqG0zz39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760258853E; Sat,  8 Jun 2024 00:39:46 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2BC884C6
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457MdUSt026912;
 Fri, 7 Jun 2024 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717799970;
 bh=/yj+eccG0P9U0pYe+1kKTynCBv8PQ7LB0yYB9E06a/c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lqG0zz39s6mV2wbeeM4TqlIQ6Ya6EgJkhrRsPRM2Hn7SuDIKl9T8hxaGvT4nDG9os
 Oc4XlJA5ECtNbqVp5kb/QYzfr769xYe6Sy90mQQeB2bR1tRU7Nd9lyY35LiE0GYdcd
 E1aDLvoAJ9+sFZcYukbulqbj0JVJlulH0e1JNNNQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457MdUeM083996
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 17:39:30 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 17:39:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 17:39:30 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457MdUPu011256;
 Fri, 7 Jun 2024 17:39:30 -0500
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
Subject: [PATCH v6 10/24] board: beagleplay: Define capsule update firmware
 info
Date: Fri, 7 Jun 2024 17:38:44 -0500
Message-ID: <20240607223858.1971290-11-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607223858.1971290-1-j-humphreys@ti.com>
References: <20240607223858.1971290-1-j-humphreys@ti.com>
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
BeaglePlay.

Note this involved creating BeaglePlay's own beagleplay.h board header file
instead of reusing am62_evm's.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/beagle/beagleplay/Kconfig      |  4 +--
 board/beagle/beagleplay/beagleplay.c | 34 +++++++++++++++++++++++
 include/configs/beagleplay.h         | 41 ++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 include/configs/beagleplay.h

diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
index 7dbd833acb4..b0e67dc8ef3 100644
--- a/board/beagle/beagleplay/Kconfig
+++ b/board/beagle/beagleplay/Kconfig
@@ -35,7 +35,7 @@ config SYS_VENDOR
        default "beagle"
 
 config SYS_CONFIG_NAME
-       default "am62x_evm"
+       default "beagleplay"
 
 source "board/ti/common/Kconfig"
 
@@ -50,7 +50,7 @@ config SYS_VENDOR
        default "beagle"
 
 config SYS_CONFIG_NAME
-       default "am62x_evm"
+       default "beagleplay"
 
 config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index af36439e2e2..a21f09e3122 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
+#include <efi_loader.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <fdt_support.h>
@@ -15,6 +16,39 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = BEAGLEPLAY_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"BEAGLEPLAY_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = BEAGLEPLAY_SPL_IMAGE_GUID,
+		.fw_name = u"BEAGLEPLAY_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = BEAGLEPLAY_UBOOT_IMAGE_GUID,
+		.fw_name = u"BEAGLEPLAY_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=tiboot3.bin raw 0 2000 mmcpart 1;"
+	"tispl.bin fat 0 1;u-boot.img fat 0 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		env_set("dfu_alt_info", update_info.dfu_string);
+}
+#endif
+
 int board_init(void)
 {
 	return 0;
diff --git a/include/configs/beagleplay.h b/include/configs/beagleplay.h
new file mode 100644
index 00000000000..4baeab664af
--- /dev/null
+++ b/include/configs/beagleplay.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration header file for BeaglePlay
+ *
+ * https://beagleplay.org/
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __CONFIG_BEAGLEPLAY_H
+#define __CONFIG_BEAGLEPLAY_H
+
+/**
+ * define BEAGLEPLAY_TIBOOT3_IMAGE_GUID - firmware GUID for BeaglePlay
+ *                                        tiboot3.bin
+ * define BEAGLEPLAY_SPL_IMAGE_GUID     - firmware GUID for BeaglePlay SPL
+ * define BEAGLEPLAY_UBOOT_IMAGE_GUID   - firmware GUID for BeaglePlay UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define BEAGLEPLAY_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0x0e225a09, 0xf720, 0x4d57, 0x91, 0x20, \
+		0xe2, 0x8f, 0x73, 0x7f, 0x5a, 0x5e)
+
+#define BEAGLEPLAY_SPL_IMAGE_GUID \
+	EFI_GUID(0xb2e7cc49, 0x1a5a, 0x4036, 0xae, 0x01, \
+		0x33, 0x87, 0xc3, 0xbe, 0xf6, 0x57)
+
+#define BEAGLEPLAY_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x92c92b11, 0xa7ee, 0x486f, 0xaa, 0xa2, \
+		0x71, 0x3d, 0x84, 0x42, 0x5b, 0x0e)
+
+/* Now for the remaining common defines */
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_BEAGLEPLAY_H */
-- 
2.34.1

