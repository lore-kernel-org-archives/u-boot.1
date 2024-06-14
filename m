Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B548C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6063C88A37;
	Fri, 14 Jun 2024 18:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UshW41NG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D94E88A60; Fri, 14 Jun 2024 18:36:12 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07EF688A2D
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZthF013689;
 Fri, 14 Jun 2024 11:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718382955;
 bh=QNvfHLQcs03DH5hIm/9nnRKpAnrqHb3XwG3RIdOIoOw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UshW41NGpY0RRiZY7dtdxVSyvpR1+CGYXhjNk38Y0zaJ8o0UNc3Q2OZl6dlaP4N0t
 3YiGYtZNlwtCq5baw5/+oFclBxqmRfrv3LpsF5sgTrrVKIxpEa7zUc+6UEmC2KWv5R
 6rbX+M435coZCBb2Ok/JiY1pBFJPvjalGcAEjyl4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EGZtGn030336
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 11:35:55 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 11:35:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 11:35:54 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZsNh027225;
 Fri, 14 Jun 2024 11:35:54 -0500
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
Subject: [PATCH v7 22/24] board: sk-am69: Define capsule update firmware info
Date: Fri, 14 Jun 2024 11:35:49 -0500
Message-ID: <20240614163551.2610212-23-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614163551.2610212-1-j-humphreys@ti.com>
References: <20240614163551.2610212-1-j-humphreys@ti.com>
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
defining capsule GUIDs for the various firmware components for the AM69
SK.

TODO: possibly make the struct's sk specific.
TODO: add doc commit (and make sure doc is sk/NOR specific, and add OSIP
boot mode)
TODO: update doc to show sk defconfig when building

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/ti/j784s4/evm.c        | 34 ++++++++++++++++++++++++++++++++++
 include/configs/j784s4_evm.h | 24 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index aed0ea5b949..548dbd5925d 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -7,12 +7,46 @@
  *
  */
 
+#include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
 #include "../common/fdt_ops.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = AM69_SK_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"AM69_SK_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = AM69_SK_SPL_IMAGE_GUID,
+		.fw_name = u"AM69_SK_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = AM69_SK_UBOOT_IMAGE_GUID,
+		.fw_name = u"AM69_SK_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
+	"tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
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
diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
index 4a2ccdce144..53eb2bff221 100644
--- a/include/configs/j784s4_evm.h
+++ b/include/configs/j784s4_evm.h
@@ -9,6 +9,30 @@
 #ifndef __CONFIG_J784S4_EVM_H
 #define __CONFIG_J784S4_EVM_H
 
+/**
+ * define AM69_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM69 SK tiboot3.bin
+ * define AM69_SK_SPL_IMAGE_GUID     - firmware GUID for AM69 SK SPL
+ * define AM69_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM69 SK UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define AM69_SK_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0xadf49ec5, 0x61bb, 0x4dbe, 0x8b, 0x8d,	\
+		 0x39, 0xdf, 0x4d, 0x7e, 0xbf, 0x46)
+
+#define AM69_SK_SPL_IMAGE_GUID \
+	EFI_GUID(0x787f0059, 0x63a1, 0x461c, 0xa1, 0x8e, \
+		 0x9d, 0x83, 0x83, 0x45, 0xfe, 0x8e)
+
+#define AM69_SK_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x9300505d, 0x6ec5, 0x4ff8, 0x99, 0xe4, \
+		 0x54, 0x59, 0xa0, 0x4b, 0xe6, 0x17)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.34.1

