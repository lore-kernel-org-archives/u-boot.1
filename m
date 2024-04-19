Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22785C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFDD88742;
	Fri, 19 Apr 2024 22:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qDILHYrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC25886F9; Fri, 19 Apr 2024 22:58:05 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D675886B2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvjVw126613;
 Fri, 19 Apr 2024 15:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713560265;
 bh=Af5v7JrMQfJ4b2/p9XlJZOmnUiul0CLzFUJNAsZBDzQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qDILHYrtnXwO2KT5e2PjVJcV0l1umfIafda5HpTYhj8R+tZW8PjV4I6Tra9zrgBbE
 ok7LBQdk4Hy+PcCxCiM1OEwtlDRGH5M8BdmWpllYWEZjbhoPx/fuUbtscbRn3b2dKt
 8c/j5yN/E+UsN0HIhfozxGUd2EpTsSY9Boa03VyI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JKvjmV093685
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 15:57:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 15:57:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 15:57:45 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvj0U091779;
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
Subject: [PATCH v3 05/19] board: j721e: Define capsule update firmware info
Date: Fri, 19 Apr 2024 15:56:47 -0500
Message-ID: <20240419205701.163821-6-j-humphreys@ti.com>
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
defining capsule GUIDs for the various firmware components for the SK-TDA4VM.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/ti/j721e/evm.c        | 38 +++++++++++++++++++++++++++++++++++++
 include/configs/j721e_evm.h | 29 ++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 9dc3ed6dfff..de70027b2df 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <efi_loader.h>
 #include <generic-phy.h>
 #include <image.h>
 #include <net.h>
@@ -32,6 +33,43 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = J721E_SK_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"J721E_SK_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = J721E_SK_SPL_IMAGE_GUID,
+		.fw_name = u"J721E_SK_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = J721E_SK_UBOOT_IMAGE_GUID,
+		.fw_name = u"J721E_SK_UBOOT",
+		.image_index = 3,
+	},
+	{
+		.image_type_id = J721E_SK_SYSFW_IMAGE_GUID,
+		.fw_name = u"J721E_SK_SYSFW",
+		.image_index = 4,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;tispl.bin raw 80000 200000;u-boot.img raw 280000 400000;sysfw.itb raw 6C0000 100000",
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
diff --git a/include/configs/j721e_evm.h b/include/configs/j721e_evm.h
index c26438c8684..a5140ea6a11 100644
--- a/include/configs/j721e_evm.h
+++ b/include/configs/j721e_evm.h
@@ -22,6 +22,35 @@
 #define CFG_SYS_UBOOT_BASE		0x50080000
 #endif
 
+/**
+ * define J721E_SK_TIBOOT3_IMAGE_GUID - firmware GUID for J721e sk tiboot3.bin
+ * define J721E_SK_SPL_IMAGE_GUID     - firmware GUID for J721e sk SPL
+ * define J721E_SK_UBOOT_IMAGE_GUID   - firmware GUID for J721e sk UBOOT
+ * define J721E_SK_SYSFW_IMAGE_GUID   - firmware GUID for J721e sk SYSFW
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define J721E_SK_TIBOOT3_IMAGE_GUID \
+	EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
+		 0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
+
+#define J721E_SK_SPL_IMAGE_GUID \
+	EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
+		 0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
+
+#define J721E_SK_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
+		 0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
+
+#define J721E_SK_SYSFW_IMAGE_GUID \
+	EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
+		 0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.34.1

