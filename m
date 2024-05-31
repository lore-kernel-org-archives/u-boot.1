Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D8C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E78588854;
	Sat,  1 Jun 2024 00:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r03KKkFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3668883C; Sat,  1 Jun 2024 00:21:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B8B8880B
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLYxx127059;
 Fri, 31 May 2024 17:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717194094;
 bh=CpOKD3C8F8kXy+HsorTDYSmdIwf8bURGVQ5d/FM3wt4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=r03KKkFXcUageRT9qIEQhIOVpM/jcqphwt14f/oCSavJdOzeB+wEWg1d0CdWkJmFb
 XpMTRlKSHJRNzK9+h/z8dvaySu/G0tU9eUMNB1Y7YFe5GiPddk+v4Lp7kI9quPclXi
 PXAOgaYMJQqXL8SdCBZ73fx8AiEyKqoHQrnTXAMY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMLYCm089475
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:21:34 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:21:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:21:33 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLXxA026052;
 Fri, 31 May 2024 17:21:33 -0500
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
Subject: [PATCH v5 06/23] board: j721e: Define capsule update firmware info
Date: Fri, 31 May 2024 17:21:01 -0500
Message-ID: <20240531222118.2618041-7-j-humphreys@ti.com>
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
defining capsule GUIDs for the various firmware components for the
SK-TDA4VM.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/ti/j721e/evm.c        | 40 +++++++++++++++++++++++++++++++++++++
 include/configs/j721e_evm.h | 29 +++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 539eaf47186..f3452ff0a8f 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <efi_loader.h>
 #include <generic-phy.h>
 #include <image.h>
 #include <net.h>
@@ -32,6 +33,45 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
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
+	.dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
+	"tispl.bin raw 80000 200000;u-boot.img raw 280000 400000;"
+	"sysfw.itb raw 6C0000 100000",
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

