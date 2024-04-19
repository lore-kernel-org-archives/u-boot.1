Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C77CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 20:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E2788684;
	Fri, 19 Apr 2024 22:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LXmkg9Ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC29885D7; Fri, 19 Apr 2024 22:58:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745A588125
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvjGP120826;
 Fri, 19 Apr 2024 15:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713560265;
 bh=fGuOJpOo3M7Rcf1VSatt7RYoqyULRmRnJebR5ihUzcg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LXmkg9EeZAPtwsW0/QX2snW4LXYy3xXX52daBpeW6JVqjuJ7RHP3FsIlCypsnCf9e
 hR1wWb29Rd4MpTWVl6FfJIR5RU6NStrObnSrIw2iZeg2rh5dO4ufFr6IPPo5/oIosH
 6uSfQx4d08uDe/stl/Ct9zdMI1lnsh2IDU9UDBN8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JKvjHK068337
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 15:57:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 15:57:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 15:57:45 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvjvu090909;
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
Subject: [PATCH v3 02/19] board: am64x: Define capsule update firmware info
Date: Fri, 19 Apr 2024 15:56:44 -0500
Message-ID: <20240419205701.163821-3-j-humphreys@ti.com>
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
defining capsule GUIDs for the various firmware components for the AM64x SK.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/ti/am64x/evm.c        | 33 +++++++++++++++++++++++++++++++++
 include/configs/am64x_evm.h | 24 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index b8de69da06c..83df75a6911 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <efi_loader.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
 #include <k3-ddrss.h>
@@ -27,6 +28,38 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = AM64X_SK_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"AM64X_SK_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = AM64X_SK_SPL_IMAGE_GUID,
+		.fw_name = u"AM64X_SK_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = AM64X_SK_UBOOT_IMAGE_GUID,
+		.fw_name = u"AM64X_SK_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "sf 0:0=tiboot3.bin raw 0 100000;tispl.bin raw 100000 200000;u-boot.img raw 300000 400000",
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
diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
index f9f8c7bc2f6..9db83621ea8 100644
--- a/include/configs/am64x_evm.h
+++ b/include/configs/am64x_evm.h
@@ -9,6 +9,30 @@
 #ifndef __CONFIG_AM642_EVM_H
 #define __CONFIG_AM642_EVM_H
 
+/**
+ * define AM64X_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM64X sk tiboot3.bin
+ * define AM64X_SK_SPL_IMAGE_GUID     - firmware GUID for AM64X sk SPL
+ * define AM64X_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM64X sk UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define AM64X_SK_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0xede0a0d5, 0x9116, 0x4bfb, 0xaa, 0x54, \
+		0x09, 0xe9, 0x7b, 0x5a, 0xfe, 0x1a)
+
+#define AM64X_SK_SPL_IMAGE_GUID \
+	EFI_GUID(0x77678f5c, 0x64d4, 0x4910, 0xad, 0x75, \
+		0x52, 0xc9, 0xd9, 0x5c, 0xdb, 0x1d)
+
+#define AM64X_SK_UBOOT_IMAGE_GUID \
+	EFI_GUID(0xc6ad43a9, 0x7d31, 0x4f5d, 0x83, 0xe9, \
+		0xb8, 0xef, 0xec, 0xae, 0x05, 0xbf)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.34.1

