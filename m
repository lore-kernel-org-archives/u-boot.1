Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841BCC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 21:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155C380137;
	Mon,  3 Feb 2025 22:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gws/D5zQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4057280050; Mon,  3 Feb 2025 22:54:40 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AF580087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 22:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 513Ls4dl3096910
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Feb 2025 15:54:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738619644;
 bh=92fuOkOofI1ejdm4AX2zjwXyKiA+x5g1GC5QzABWijs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gws/D5zQY/tPuEQ8+G5R6NMdAhXvkuQuaR/oTUpK1YabtILkldEtOs2i+my6f1r8l
 jmcihgdU/re8y1guLY4+camdw4VPTr5YHShgsDNpEvafc8N/Upxhy7bWd0q6YKiCDD
 Rmb6noUm2i4e9sfyX8uYRsDQijdI4VsVNus6Ku8w=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 513Ls32G043270;
 Mon, 3 Feb 2025 15:54:04 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Feb 2025 15:54:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Feb 2025 15:54:02 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 513Ls21r058841;
 Mon, 3 Feb 2025 15:54:02 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, "Michal
 Simek" <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski
 <lukma@denx.de>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 2/2] board: remove capsule update support in set_dfu_alt_info()
Date: Mon, 3 Feb 2025 15:53:51 -0600
Message-ID: <20250203215351.2840144-3-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203215351.2840144-1-j-humphreys@ti.com>
References: <20250203215351.2840144-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 03 Feb 2025 22:57:27 +0100
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

Now that capsule update sets the dfu_alt_info environment variable
explicitly, there is no need to support it in the set_dfu_alt_info()
function. Decouple SET_DFU_ALT_INFO from EFI_CAPSULE_FIRMWARE_FIT and
EFI_CAPSULE_FIRMWARE_RAW. For many boards, this was the only use of
set_dfu_alt_info() so remove the function entirely.

Fixes commit a9e6f01a941f ("efi: Define set_dfu_alt_info() for boards with UEFI capsule update enabled")

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 board/beagle/beagleboneai64/beagleboneai64.c       | 8 --------
 board/beagle/beagleplay/beagleplay.c               | 8 --------
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 --
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 --
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 --
 board/phytec/common/k3/board.c                     | 8 --------
 board/ti/am62px/evm.c                              | 8 --------
 board/ti/am62x/evm.c                               | 8 --------
 board/ti/am64x/evm.c                               | 8 --------
 board/ti/j721e/evm.c                               | 8 --------
 board/ti/j784s4/evm.c                              | 8 --------
 lib/efi_loader/Kconfig                             | 2 --
 lib/efi_loader/efi_firmware.c                      | 5 -----
 13 files changed, 77 deletions(-)

diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
index e8d07f1f95f..99eb8972cf3 100644
--- a/board/beagle/beagleboneai64/beagleboneai64.c
+++ b/board/beagle/beagleboneai64/beagleboneai64.c
@@ -45,14 +45,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index fae69b37585..78635810585 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
index e45cfd5d8a3..24363d21ab0 100644
--- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
+++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
@@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
 {
 	if (strcmp(interface, "ram") == 0)
 		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
-	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
 }
 #endif
 
diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index 94cf5b4361f..42442f26acc 100644
--- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -38,8 +38,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
 {
 	if (strcmp(interface, "ram") == 0)
 		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
-	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
 }
 #endif
 
diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
index f641db5a494..5223f1c8ab8 100644
--- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
+++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
@@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
 {
 	if (strcmp(interface, "ram") == 0)
 		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
-	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
 }
 #endif
 
diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 9d833456810..58859f279f1 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -82,14 +82,6 @@ void configure_capsule_updates(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
 int mmc_get_env_dev(void)
 {
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 75359fa1614..379d1a5b316 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 279ceba9554..3051a0a27a1 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -74,14 +74,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 6a17737d266..35fd30dbceb 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -54,14 +54,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 1fa78ff7b30..0525f6e6f97 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -65,14 +65,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index d317f3eccbb..c6e46b7ee0e 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -40,14 +40,6 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
-		env_set("dfu_alt_info", update_info.dfu_string);
-}
-#endif
-
 int board_init(void)
 {
 	return 0;
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d4f6b56afaa..1be11aed901 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -304,7 +304,6 @@ config EFI_CAPSULE_FIRMWARE_FIT
 	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
 	select UPDATE_FIT
 	select DFU
-	select SET_DFU_ALT_INFO
 	select EFI_CAPSULE_FIRMWARE
 	help
 	  Select this option if you want to enable firmware management protocol
@@ -316,7 +315,6 @@ config EFI_CAPSULE_FIRMWARE_RAW
 	depends on SANDBOX || (!SANDBOX && !EFI_CAPSULE_FIRMWARE_FIT)
 	select DFU_WRITE_ALT
 	select DFU
-	select SET_DFU_ALT_INFO
 	select EFI_CAPSULE_FIRMWARE
 	help
 	  Select this option if you want to enable firmware management protocol
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index d8b6d34ccab..3e92a143b90 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -56,11 +56,6 @@ struct fmp_state {
 	u32 last_attempt_status; /* not used */
 };
 
-__weak void set_dfu_alt_info(char *interface, char *devstr)
-{
-	env_set("dfu_alt_info", update_info.dfu_string);
-}
-
 /**
  * efi_firmware_get_image_type_id - get image_type_id
  * @image_index:	image index
-- 
2.34.1

