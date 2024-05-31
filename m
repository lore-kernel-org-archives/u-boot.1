Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A47C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BCB8882F;
	Sat,  1 Jun 2024 00:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AVYcEEkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE95088607; Sat,  1 Jun 2024 00:21:53 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A79E88826
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLYXg017889;
 Fri, 31 May 2024 17:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717194094;
 bh=sPa4d6nOCoSTRgkssq0Y8RJ87tcIu5h48K93bhXcoGY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=AVYcEEkBTVzTlahAObpKw1JiMSfi7AQQURVVsZA8ch+Rka3XNUgpnqwSgHjpfLQEW
 eBF0kC9ZtGc9PsUDRNIJHQ5kb/up5mwVLvJ8WNXqsoqphYULks4oMJn27hccU9qMaD
 DrZHj3Yx0zOSOONp/obRRnwr6o5CaangVDBuirUY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMLYko089482
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:21:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:21:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:21:34 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLYP3006268;
 Fri, 31 May 2024 17:21:34 -0500
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
Subject: [PATCH v5 15/23] board: am62px: Define capsule update firmware info
Date: Fri, 31 May 2024 17:21:10 -0500
Message-ID: <20240531222118.2618041-16-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531222118.2618041-1-j-humphreys@ti.com>
References: <20240531222118.2618041-1-j-humphreys@ti.com>
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
defining capsule GUIDs for the various firmware components for the AM62px
SK.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/ti/am62px/evm.c        | 34 ++++++++++++++++++++++++++++++++++
 include/configs/am62px_evm.h | 24 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 97a95ce8cc2..1a2c46c462b 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <efi_loader.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
@@ -13,6 +14,39 @@
 #include <fdt_support.h>
 #include <spl.h>
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = AM62PX_SK_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"AM62PX_SK_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = AM62PX_SK_SPL_IMAGE_GUID,
+		.fw_name = u"AM62PX_SK_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = AM62PX_SK_UBOOT_IMAGE_GUID,
+		.fw_name = u"AM62PX_SK_UBOOT",
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
diff --git a/include/configs/am62px_evm.h b/include/configs/am62px_evm.h
index 06b12860e21..57a1ba9dc3c 100644
--- a/include/configs/am62px_evm.h
+++ b/include/configs/am62px_evm.h
@@ -8,6 +8,30 @@
 #ifndef __CONFIG_AM62PX_EVM_H
 #define __CONFIG_AM62PX_EVM_H
 
+/**
+ * define AM62PX_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM62PX sk tiboot3.bin
+ * define AM62PX_SK_SPL_IMAGE_GUID     - firmware GUID for AM62PX sk SPL
+ * define AM62PX_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM62PX sk UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define AM62PX_SK_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0xb08471b7, 0xbe2d, 0x4489, 0x87, 0xa1, \
+		0xca, 0xb2, 0x8a, 0x0c, 0xf7, 0x43)
+
+#define AM62PX_SK_SPL_IMAGE_GUID \
+	EFI_GUID(0xd02ed781, 0x6d71, 0x4c1a, 0xa9, 0x99, \
+		0x3c, 0x6a, 0x41, 0xc3, 0x63, 0x24)
+
+#define AM62PX_SK_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x7e6aea51, 0x965c, 0x44ab, 0xb3, 0x88, \
+		0xda, 0xeb, 0x03, 0xb5, 0x4f, 0x66)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.34.1

