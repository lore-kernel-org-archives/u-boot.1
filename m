Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65819C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 16:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941EE82115;
	Fri, 25 Apr 2025 18:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OmKuh3DH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC1482115; Fri, 25 Apr 2025 18:00:14 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5158212A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 18:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 449FD44201;
 Fri, 25 Apr 2025 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1745596811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GOsyxSG4q2o7JPbN/FKCNQ4KLcoSFaYwi6f70uRkUvE=;
 b=OmKuh3DHp5ctbe62YDKIO6kzc3Ean5K+M17rOedVovdRQ+nrdZeqrpFVYLCDCeE9vJrb1w
 UIlAnMjdEkdJ5HzXlRSozwQLCrk06yH4uUGa7osozBoSE/hwrJIaC0DIAJSUU6r/Ap7LiC
 U3g1GV7rnQxuajxXLqRwP6ClgdNFFbG/RWv6vTGuoEr9aHaY0nmIeaPmIfkPIr/i8hZ2vY
 0VT3TA87c0f+abNQdnGtYxXE8+vO3WwXhsm177+9CMeSkuNw8/8u+Iy/nrUojjj8aXAmG5
 JxMvlWZle3pT5VoWLm6AxHXIYLiMmO7AuTF10tWZ9ls9jBpqI3h9n+tKcDpNTQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Robert Nelson <robertcnelson@gmail.com>,
 Bajjuri Praneeth <praneeth@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Paul Kocialkowski <contact@paulk.fr>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>
Subject: [PATCH] board: ti: am33xx: Add support for BeagleBoard Green Eco
Date: Fri, 25 Apr 2025 17:59:25 +0200
Message-Id: <20250425155927.798941-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedugedvkeelhfehfeeuieeigeetgeetuedugeetuddvveffieekgfejkefgudeknecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeefleefugemsgegieelmegtkegstgemrgejvgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemfeelfegumegsgeeileemtgeksggtmegrjegvledphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtrddrpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtoheprhhosggvrhhttghnvghlshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehprhgrnhgvvghthhesthhirdgtohhmpdhrtghpt
 hhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopegrfhgusehtihdrtghomhdprhgtphhtthhopehkvghvvghrrdihrghnghesrhhotghkqdgthhhiphhsrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com
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

SeeedStudio BeagleBone Green Eco (BBGE) is a clone of the BeagleBone Green
(BBG). It has minor differences from the BBG, such as a different PMIC,
a different Ethernet PHY, and a larger eMMC.

The PMIC is not yet supported in mainline, but the work is ongoing.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/dts/Makefile                 |  1 +
 arch/arm/dts/am335x-bonegreen-eco.dts | 34 +++++++++++++++++++++++++++
 board/ti/am335x/board.c               |  9 ++++++-
 board/ti/am335x/board.h               |  5 ++++
 configs/am335x_evm_defconfig          |  2 +-
 configs/am335x_evm_spiboot_defconfig  |  2 +-
 configs/am335x_hs_evm_defconfig       |  2 +-
 configs/am335x_hs_evm_uart_defconfig  |  2 +-
 include/configs/am335x_evm.h          |  2 ++
 9 files changed, 54 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/am335x-bonegreen-eco.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index bcf3f4be36e..3846df93abb 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -419,6 +419,7 @@ dtb-$(CONFIG_AM33XX) += \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
 	am335x-bonegreen.dtb \
+	am335x-bonegreen-eco.dtb \
 	am335x-bonegreen-wireless.dtb \
 	am335x-icev2.dtb \
 	am335x-pocketbeagle.dtb \
diff --git a/arch/arm/dts/am335x-bonegreen-eco.dts b/arch/arm/dts/am335x-bonegreen-eco.dts
new file mode 100644
index 00000000000..f3363d1ebcc
--- /dev/null
+++ b/arch/arm/dts/am335x-bonegreen-eco.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Bootlin
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include "am335x-bone-common.dtsi"
+#include "am335x-bonegreen-common.dtsi"
+
+/ {
+	model = "TI AM335x BeagleBone Green Eco";
+	compatible = "ti,am335x-bone-green-eco", "ti,am335x-bone-green",
+		     "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
+
+	cpus {
+		cpu@0 {
+			/delete-property/ cpu0-supply;
+		};
+	};
+};
+
+&usb0 {
+	interrupts-extended = <&intc 18>;
+	interrupt-names = "mc";
+};
+
+&baseboard_eeprom {
+	/delete-property/ vcc-supply;
+};
+
+&i2c0 {
+	/delete-node/ tps@24;
+};
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index f738cba7bd1..4ada8b534c1 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -307,6 +307,9 @@ const struct dpll_params *get_dpll_mpu_params(void)
 	if (board_is_pb() || board_is_bone_lt())
 		freq = MPUPLL_M_1000;
 
+	if (board_is_bbge())
+		freq = MPUPLL_M_600;
+
 	switch (freq) {
 	case MPUPLL_M_1000:
 		return &dpll_mpu_opp[ind][5];
@@ -823,6 +826,8 @@ int board_late_init(void)
 
 	if (board_is_bbg1())
 		name = "BBG1";
+	if (board_is_bbge())
+		name = "BBGE";
 	if (board_is_bben()) {
 		char subtype_id = board_ti_get_config()[1];
 
@@ -955,7 +960,7 @@ int board_fit_config_name_match(const char *name)
 		return 0;
 	else if (board_is_bone() && !strcmp(name, "am335x-bone"))
 		return 0;
-	else if (board_is_bone_lt() && !board_is_bbg1() &&
+	else if (board_is_bone_lt() && !board_is_bbg1() && !board_is_bbge() &&
 		 !strcmp(name, "am335x-boneblack"))
 		return 0;
 	else if (board_is_pb() && !strcmp(name, "am335x-pocketbeagle"))
@@ -964,6 +969,8 @@ int board_fit_config_name_match(const char *name)
 		return 0;
 	else if (board_is_bbg1() && !strcmp(name, "am335x-bonegreen"))
 		return 0;
+	else if (board_is_bbge() && !strcmp(name, "am335x-bonegreen-eco"))
+		return 0;
 	else if (board_is_icev2() && !strcmp(name, "am335x-icev2"))
 		return 0;
 	else if (board_is_bben()) {
diff --git a/board/ti/am335x/board.h b/board/ti/am335x/board.h
index b0a3842423f..2fe88d3d3f8 100644
--- a/board/ti/am335x/board.h
+++ b/board/ti/am335x/board.h
@@ -45,6 +45,11 @@ static inline int board_is_bbg1(void)
 	return board_is_bone_lt() && !strncmp(board_ti_get_rev(), "BBG1", 4);
 }
 
+static inline int board_is_bbge(void)
+{
+	return board_is_bone_lt() && !strncmp(board_ti_get_rev(), "BBGE", 4);
+}
+
 static inline int board_is_bben(void)
 {
 	return board_is_bone_lt() && !strncmp(board_ti_get_rev(), "SE", 2);
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 6d1da0cfc7c..674ad6c06ee 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -52,7 +52,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
+CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 221b2f26a43..d53d1b6e906 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_MTDPARTS=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
+CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index 396e7432c40..55f1519f0e0 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -39,7 +39,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
+CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index 4be0b2f3933..1bf7b5f8a12 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -41,7 +41,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle"
+CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index cf43fc05025..d2164b41d6d 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -126,6 +126,8 @@
 			"setenv fdtfile am335x-bonegreen.dtb; fi; " \
 		"if test $board_name = BBGW; then " \
 			"setenv fdtfile am335x-bonegreen-wireless.dtb; fi; " \
+		"if test $board_name = BBGE; then " \
+			"setenv fdtfile am335x-bonegreen-eco.dtb; fi; " \
 		"if test $board_name = BBBL; then " \
 			"setenv fdtfile am335x-boneblue.dtb; fi; " \
 		"if test $board_name = BBEN; then " \
-- 
2.34.1

