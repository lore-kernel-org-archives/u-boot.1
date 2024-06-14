Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC23C41513
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03EC88A29;
	Fri, 14 Jun 2024 18:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ystffd7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570A088A47; Fri, 14 Jun 2024 18:36:10 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681E788A2B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZspX058036;
 Fri, 14 Jun 2024 11:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718382954;
 bh=c/HSmdc8MPPCjIo2ijPq89k2b0QGGPxMHPEQK9D/AXw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ystffd7TKt/7GmTKGB+BxZji60tT5YH39PSm7XnPW6sFTMvDP6bEypli14aDONs+d
 ioErXaRkR+faLq+PJOYza+gPqOhA4f2KtmGd31Lc3vylO2nPgGkxMUqkBCjORtoIuL
 zhMeal37G7PcvCtiEegYcqg4lI/w32WQQ6ar1TOk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EGZsv6030317
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 11:35:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 11:35:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 11:35:53 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZshp124108;
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
Subject: [PATCH v7 13/24] board: am62x: Define capsule update firmware info
Date: Fri, 14 Jun 2024 11:35:40 -0500
Message-ID: <20240614163551.2610212-14-j-humphreys@ti.com>
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
defining capsule GUIDs for the various firmware components for the AM62x
SK.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/ti/am62x/evm.c        | 34 ++++++++++++++++++++++++++++++++++
 include/configs/am62x_evm.h | 24 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index b3e8680dfab..9bdd0223cdb 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <efi_loader.h>
 #include <env.h>
 #include <spl.h>
 #include <init.h>
@@ -46,6 +47,39 @@ int splash_screen_prepare(void)
 }
 #endif
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = AM62X_SK_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"AM62X_SK_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = AM62X_SK_SPL_IMAGE_GUID,
+		.fw_name = u"AM62X_SK_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = AM62X_SK_UBOOT_IMAGE_GUID,
+		.fw_name = u"AM62X_SK_UBOOT",
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
diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
index c8fe59b7531..0d98f14a4bc 100644
--- a/include/configs/am62x_evm.h
+++ b/include/configs/am62x_evm.h
@@ -9,6 +9,30 @@
 #ifndef __CONFIG_AM625_EVM_H
 #define __CONFIG_AM625_EVM_H
 
+/**
+ * define AM62X_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM62X sk tiboot3.bin
+ * define AM62X_SK_SPL_IMAGE_GUID     - firmware GUID for AM62X sk SPL
+ * define AM62X_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM62X sk UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define AM62X_SK_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0xabcb83d2, 0x9cb6, 0x4351, 0xb8, 0xf1, \
+		0x64, 0x94, 0xbb, 0xe3, 0x70, 0x0a)
+
+#define AM62X_SK_SPL_IMAGE_GUID \
+	EFI_GUID(0xaee355fc, 0xbf97, 0x4264, 0x8c, 0x82, \
+		0x43, 0x72, 0x55, 0xef, 0xdc, 0x1d)
+
+#define AM62X_SK_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x28ab8c6c, 0xfca8, 0x41d3, 0x8e, 0xa1, \
+		0x5f, 0x17, 0x1b, 0x7d, 0x29, 0x29)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.34.1

