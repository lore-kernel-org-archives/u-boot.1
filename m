Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60488C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8D583869;
	Thu, 31 Jul 2025 13:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753962079;
	bh=2puaFnI/r7/VQDz/o4YEeFWnAIAUdqCylccayck2kCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWxt6os5kbscH7CC5+za2tX6MAvI93tpHdcivW/YNjVa6gEFiEIc79DxHiVKAMybq
	 90/vyoXF/9YnQM5fDhKdDzBM5APm+ajwd3WRUhqUM0bnUOo8Dq9eFr+wDQaPdqvruX
	 JeyB/IwbPVOans5RPx0cOE4DL1uKxf3aqYAEjhEvn8QQM4VOq3rGWlo7LTVykw5Ou3
	 8dJp39D5IPYCzXBOCBUrdiwpU+Vynjg1Hdy129pUtgWaUMgNDzANwGWYzIKZX6eI/3
	 uRC6f8PDSNJZZTvXPd1u+vftLp6WrTzQVQxShk+gd22ATGfnRn2YPyox+2YYVAlki4
	 T9DJTAQn7ZDkg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1661A8386B; Thu, 31 Jul 2025 13:41:19 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A216883816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SB0YM6Ms"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08DCA1038C128; 
 Thu, 31 Jul 2025 13:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753962076; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=2puaFnI/r7/VQDz/o4YEeFWnAIAUdqCylccayck2kCY=;
 b=SB0YM6MsKJmJ2RTyN6rUfuDQAcPu06qFABXQv/DCrsO1shrUKLwI3+XdaZtWDoQ/dGuloq
 obkDaGN9chZwWFcztROKAk7Eww68TUOUo8T4/q43JzQPujZWiRy329x/Dn8rcN7y+RyN10
 u//qWAg9al8pS9PREOTl3epPqrPNAMD5OzH4IOpkQI45Vl7cfUvKufdp+5k15/EFZZI2Fx
 LBCXmGi/IzjIMv+5PpXqv8ql+l6KCO3KJ8oq+3+NpDJYq+CqDvtvMlfEDLZMMgGmXNnJTr
 QvElVPXUiDXYPNiMNs8+gfLkMT4bAqF5JPCQlXkkefJWqe/WlTABDL7o1lb+zA==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [RFC PATCH v1 2/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Date: Thu, 31 Jul 2025 13:40:43 +0200
Message-Id: <20250731114044.264745-3-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731114044.264745-1-pro@denx.de>
References: <20250731114044.264745-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

CONFIG_HAS_BOARD_SIZE_LIMIT is superfluous, if we interpret the value
"zero" as "unlimited". This is exactly how all the other
CONFIG_XXX_SIZE_LIMIT work.

No functional changes.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Kconfig                                        | 10 +---------
 cmd/Kconfig                                    |  2 +-
 configs/bk4r1_defconfig                        |  1 -
 configs/chromebook_link_defconfig              |  1 -
 configs/colibri_vf_defconfig                   |  1 -
 configs/ea-lpc3250devkitv2_defconfig           |  1 -
 configs/gardena-smart-gateway-mt7688_defconfig |  1 -
 configs/guruplug_defconfig                     |  1 -
 configs/imx28_btt3_defconfig                   |  1 -
 configs/imx28_xea_defconfig                    |  1 -
 configs/legoev3_defconfig                      |  1 -
 configs/linkit-smart-7688_defconfig            |  1 -
 configs/lschlv2_defconfig                      |  1 -
 configs/lsxhl_defconfig                        |  1 -
 configs/lxr2_defconfig                         |  1 -
 configs/mx51evk_defconfig                      |  1 -
 configs/mx53loco_defconfig                     |  1 -
 configs/mx6sabresd_defconfig                   |  1 -
 configs/mx7ulp_com_defconfig                   |  1 -
 configs/openrd_base_defconfig                  |  1 -
 configs/openrd_client_defconfig                |  1 -
 configs/openrd_ultimate_defconfig              |  1 -
 configs/pcm052_defconfig                       |  1 -
 configs/pico-dwarf-imx6ul_defconfig            |  1 -
 configs/pico-dwarf-imx7d_defconfig             |  1 -
 configs/pico-hobbit-imx6ul_defconfig           |  1 -
 configs/pico-hobbit-imx7d_defconfig            |  1 -
 configs/pico-imx6_defconfig                    |  1 -
 configs/pico-imx6ul_defconfig                  |  1 -
 configs/pico-imx7d_bl33_defconfig              |  1 -
 configs/pico-imx7d_defconfig                   |  1 -
 configs/pico-nymph-imx7d_defconfig             |  1 -
 configs/pico-pi-imx6ul_defconfig               |  1 -
 configs/pico-pi-imx7d_defconfig                |  1 -
 configs/sheevaplug_defconfig                   |  1 -
 configs/stm32mp15_dhsom.config                 |  1 -
 configs/tbs2910_defconfig                      |  1 -
 configs/turris_1x_nor_defconfig                |  1 -
 configs/turris_1x_sdcard_defconfig             |  1 -
 configs/turris_omnia_defconfig                 |  1 -
 configs/udoo_neo_defconfig                     |  1 -
 configs/vf610twr_defconfig                     |  1 -
 configs/vf610twr_nand_defconfig                |  1 -
 configs/warp7_bl33_defconfig                   |  1 -
 configs/warp7_defconfig                        |  1 -
 lib/efi_loader/Kconfig                         |  6 +++---
 46 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/Kconfig b/Kconfig
index c883f115459..d0c0a6a1d53 100644
--- a/Kconfig
+++ b/Kconfig
@@ -535,19 +535,11 @@ config BUILD_TARGET
 	  special image will be automatically built upon calling
 	  make / buildman.
 
-config HAS_BOARD_SIZE_LIMIT
-	bool "Define a maximum size for the U-Boot image"
-	depends on !COMPILE_TEST
-	default y if RCAR_32 || RCAR_64
-	help
-	  In some cases, we need to enforce a hard limit on how big the U-Boot
-	  image itself can be.
-
 config BOARD_SIZE_LIMIT
 	int "Maximum size of the U-Boot image in bytes"
+	default 0
 	default 524288 if RCAR_32
 	default 1048576 if RCAR_64
-	depends on HAS_BOARD_SIZE_LIMIT
 	help
 	  Maximum size of the U-Boot image. When defined, the build system
 	  checks that the actual size does not exceed it.  This does not
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b3b5be1ea79..99d91e9e5a9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2331,7 +2331,7 @@ config CMD_EFIDEBUG
 
 config CMD_EFICONFIG
 	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
-	default y if !HAS_BOARD_SIZE_LIMIT
+	default y if BOARD_SIZE_LIMIT = 0
 	depends on EFI_BOOTMGR
 	select MENU
 	help
diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index fd3b6188776..ca63cf71db8 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -18,7 +18,6 @@ CONFIG_TARGET_BK4R1=y
 CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index b5b3851a010..9bdeb604292 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -15,7 +15,6 @@ CONFIG_DEBUG_UART=y
 CONFIG_HAVE_MRC=y
 CONFIG_SMP=y
 CONFIG_HAVE_VGA_BIOS=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=630000
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 1364fe45291..9c3077cc16f 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -15,7 +15,6 @@ CONFIG_TARGET_COLIBRI_VF=y
 CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
 # CONFIG_EFI_LOADER is not set
 CONFIG_BOOTDELAY=1
diff --git a/configs/ea-lpc3250devkitv2_defconfig b/configs/ea-lpc3250devkitv2_defconfig
index c3af7afced1..5a3cdb45f7c 100644
--- a/configs/ea-lpc3250devkitv2_defconfig
+++ b/configs/ea-lpc3250devkitv2_defconfig
@@ -12,7 +12,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80000f20
 CONFIG_TARGET_EA_LPC3250DEVKITV2=y
 CONFIG_DEFAULT_DEVICE_TREE="lpc3250-ea3250"
 CONFIG_SYS_LOAD_ADDR=0x80100000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048575
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_AUTOBOOT is not set
diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 3c2bcc6a3c4..39e3cd04251 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -27,7 +27,6 @@ CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
 # CONFIG_MIPS_BOOT_ENV_LEGACY is not set
 CONFIG_MIPS_BOOT_FDT=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=655360
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
index e046a5ee8b1..a8697113cd3 100644
--- a/configs/guruplug_defconfig
+++ b/configs/guruplug_defconfig
@@ -13,7 +13,6 @@ CONFIG_ENV_OFFSET=0xE0000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-guruplug-server-plus"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nMarvell-GuruPlug"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=917504
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/imx28_btt3_defconfig b/configs/imx28_btt3_defconfig
index 07c805faa2f..0efbea20109 100644
--- a/configs/imx28_btt3_defconfig
+++ b/configs/imx28_btt3_defconfig
@@ -31,7 +31,6 @@ CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=458752
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 8715893bbcc..9a54efdb8da 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -29,7 +29,6 @@ CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=458752
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
diff --git a/configs/legoev3_defconfig b/configs/legoev3_defconfig
index dee19a95d55..571ff928029 100644
--- a/configs/legoev3_defconfig
+++ b/configs/legoev3_defconfig
@@ -14,7 +14,6 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="da850-lego-ev3"
 CONFIG_SYS_LOAD_ADDR=0xc0700000
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=262144
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_BOOTDELAY=0
diff --git a/configs/linkit-smart-7688_defconfig b/configs/linkit-smart-7688_defconfig
index 1602ff5b73a..e2f232d549b 100644
--- a/configs/linkit-smart-7688_defconfig
+++ b/configs/linkit-smart-7688_defconfig
@@ -23,7 +23,6 @@ CONFIG_MIPS_CACHE_DISABLE=y
 CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
 # CONFIG_MIPS_BOOT_ENV_LEGACY is not set
 CONFIG_MIPS_BOOT_FDT=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/lschlv2_defconfig b/configs/lschlv2_defconfig
index 3a53d49ba83..b296feeec1b 100644
--- a/configs/lschlv2_defconfig
+++ b/configs/lschlv2_defconfig
@@ -18,7 +18,6 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-lschlv2"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING=" LS-CHLv2"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=393216
 # CONFIG_BOOTSTD is not set
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/lsxhl_defconfig b/configs/lsxhl_defconfig
index 83a0a6f5415..ff1ce7a79cc 100644
--- a/configs/lsxhl_defconfig
+++ b/configs/lsxhl_defconfig
@@ -19,7 +19,6 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-lsxhl"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING=" LS-XHL"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=393216
 # CONFIG_BOOTSTD is not set
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index f2afed1c4ba..c9852fb6470 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -26,7 +26,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715766
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
diff --git a/configs/mx51evk_defconfig b/configs/mx51evk_defconfig
index bcbef81d1d4..14b7e80c86b 100644
--- a/configs/mx51evk_defconfig
+++ b/configs/mx51evk_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx51-babbage"
 CONFIG_SYS_LOAD_ADDR=0x92000000
 # CONFIG_CMD_BMODE is not set
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=785408
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
diff --git a/configs/mx53loco_defconfig b/configs/mx53loco_defconfig
index 1f7da84fbea..0413e2ee55a 100644
--- a/configs/mx53loco_defconfig
+++ b/configs/mx53loco_defconfig
@@ -11,7 +11,6 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx53-qsb"
 CONFIG_SYS_LOAD_ADDR=0x72000000
 # CONFIG_CMD_BMODE is not set
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=785408
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 75a655a0e0d..9c5105883a0 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -20,7 +20,6 @@ CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_PCI=y
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715766
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index a49cb2a728f..22ceae1c0ba 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -12,7 +12,6 @@ CONFIG_LDO_ENABLED_MODE=y
 CONFIG_TARGET_MX7ULP_COM=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
 CONFIG_SYS_LOAD_ADDR=0x60800000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=785408
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if run loadimage; then run mmcboot; fi"
diff --git a/configs/openrd_base_defconfig b/configs/openrd_base_defconfig
index cfad5fb037b..6811c9a29da 100644
--- a/configs/openrd_base_defconfig
+++ b/configs/openrd_base_defconfig
@@ -16,7 +16,6 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-base"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nOpenRD-Base"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/openrd_client_defconfig b/configs/openrd_client_defconfig
index e0a393e478c..8b745c8d5e2 100644
--- a/configs/openrd_client_defconfig
+++ b/configs/openrd_client_defconfig
@@ -17,7 +17,6 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-client"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nOpenRD-Client"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/openrd_ultimate_defconfig b/configs/openrd_ultimate_defconfig
index 23415ef12ee..a14fb130ffe 100644
--- a/configs/openrd_ultimate_defconfig
+++ b/configs/openrd_ultimate_defconfig
@@ -17,7 +17,6 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-ultimate"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nOpenRD-Ultimate"
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
index 64f5f777e5c..434495bf417 100644
--- a/configs/pcm052_defconfig
+++ b/configs/pcm052_defconfig
@@ -14,7 +14,6 @@ CONFIG_ENV_OFFSET_REDUND=0xC0000
 CONFIG_TARGET_PCM052=y
 CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
 # CONFIG_EFI_LOADER is not set
 CONFIG_BOOTDELAY=3
diff --git a/configs/pico-dwarf-imx6ul_defconfig b/configs/pico-dwarf-imx6ul_defconfig
index e1f6e6f91f2..296095f0103 100644
--- a/configs/pico-dwarf-imx6ul_defconfig
+++ b/configs/pico-dwarf-imx6ul_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/pico-dwarf-imx7d_defconfig b/configs/pico-dwarf-imx7d_defconfig
index c1389ac4066..cc9cead2e0e 100644
--- a/configs/pico-dwarf-imx7d_defconfig
+++ b/configs/pico-dwarf-imx7d_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-imx6ul_defconfig
index 137541d373a..6ef97863ce9 100644
--- a/configs/pico-hobbit-imx6ul_defconfig
+++ b/configs/pico-hobbit-imx6ul_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/pico-hobbit-imx7d_defconfig b/configs/pico-hobbit-imx7d_defconfig
index 72e1a3bccc1..34ad3627193 100644
--- a/configs/pico-hobbit-imx7d_defconfig
+++ b/configs/pico-hobbit-imx7d_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
diff --git a/configs/pico-imx6_defconfig b/configs/pico-imx6_defconfig
index 6f46d9bf8a1..139fa6e863c 100644
--- a/configs/pico-imx6_defconfig
+++ b/configs/pico-imx6_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
diff --git a/configs/pico-imx6ul_defconfig b/configs/pico-imx6ul_defconfig
index 70b79622be1..2f9fa4911fc 100644
--- a/configs/pico-imx6ul_defconfig
+++ b/configs/pico-imx6ul_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/pico-imx7d_bl33_defconfig b/configs/pico-imx7d_bl33_defconfig
index b5485bf8d0b..ff9b9104f9b 100644
--- a/configs/pico-imx7d_bl33_defconfig
+++ b/configs/pico-imx7d_bl33_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xa0000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/pico-imx7d_defconfig b/configs/pico-imx7d_defconfig
index 4707062053b..a55a293fda5 100644
--- a/configs/pico-imx7d_defconfig
+++ b/configs/pico-imx7d_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
diff --git a/configs/pico-nymph-imx7d_defconfig b/configs/pico-nymph-imx7d_defconfig
index c1389ac4066..cc9cead2e0e 100644
--- a/configs/pico-nymph-imx7d_defconfig
+++ b/configs/pico-nymph-imx7d_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 40db7e23797..99abd245db7 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 26fccf90db7..1b68ba18463 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
index a7f6c73ecba..a7bd54c37cd 100644
--- a/configs/sheevaplug_defconfig
+++ b/configs/sheevaplug_defconfig
@@ -17,7 +17,6 @@ CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-sheevaplug"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index 565b49584e3..52b2215fc6c 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -21,7 +21,6 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
 CONFIG_DM_HWSPINLOCK=y
 CONFIG_DM_REGULATOR_STM32_VREFBUF=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_HWSPINLOCK_STM32=y
 CONFIG_KS8851_MLL=y
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index 070dce234d6..37532bf2686 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -15,7 +15,6 @@ CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x10000000
 CONFIG_SYS_MEMTEST_END=0x2f400000
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=392192
 # CONFIG_EFI_LOADER is not set
 # CONFIG_BOOTSTD is not set
diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index cc7d4a1e0d6..df2b781aa1a 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -21,7 +21,6 @@ CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_OPTIMIZE_INLINING=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=786432
 CONFIG_MP=y
 CONFIG_FIT=y
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index ee18cc21443..77bf6f5f065 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -30,7 +30,6 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048576
 CONFIG_MP=y
 CONFIG_FIT=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index de39e19ec6d..4461ceeaaf3 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -36,7 +36,6 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x00800000
 CONFIG_SYS_MEMTEST_END=0x00ffffff
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=983040
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index d4fb271e03a..ef5f6b207e6 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_CMD_BMODE is not set
 CONFIG_LTO=y
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=523264
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
diff --git a/configs/vf610twr_defconfig b/configs/vf610twr_defconfig
index 556190728e1..b16b1522d1a 100644
--- a/configs/vf610twr_defconfig
+++ b/configs/vf610twr_defconfig
@@ -12,7 +12,6 @@ CONFIG_DEFAULT_DEVICE_TREE="vf610-twr"
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/vf610twr_nand_defconfig b/configs/vf610twr_nand_defconfig
index 7fe9d822110..31b1468650e 100644
--- a/configs/vf610twr_nand_defconfig
+++ b/configs/vf610twr_nand_defconfig
@@ -12,7 +12,6 @@ CONFIG_DEFAULT_DEVICE_TREE="vf610-twr"
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
diff --git a/configs/warp7_bl33_defconfig b/configs/warp7_bl33_defconfig
index 5a94062f5e2..eb047236f87 100644
--- a/configs/warp7_bl33_defconfig
+++ b/configs/warp7_bl33_defconfig
@@ -11,7 +11,6 @@ CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_HAB=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xa0000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=785408
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig
index 03d68aa9a3f..22f611f4ccd 100644
--- a/configs/warp7_defconfig
+++ b/configs/warp7_defconfig
@@ -14,7 +14,6 @@ CONFIG_IMX_BOOTAUX=y
 CONFIG_IMX_HAB=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xa0000000
-CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=785408
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c2aa88f59fb..36eed766d31 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -74,7 +74,7 @@ config EFI_SIGNATURE_SUPPORT
 
 config EFI_DEBUG_SUPPORT
 	bool "EFI Debug Support"
-	default y if !HAS_BOARD_SIZE_LIMIT
+	default y if BOARD_SIZE_LIMIT = 0
 	help
 	  Select this option if you want to setup the EFI Debug Support
 	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
@@ -396,7 +396,7 @@ config EFI_DT_FIXUP
 
 config EFI_LOADER_HII
 	bool "HII protocols"
-	default y if !HAS_BOARD_SIZE_LIMIT
+	default y if BOARD_SIZE_LIMIT = 0
 	help
 	  The Human Interface Infrastructure is a complicated framework that
 	  allows UEFI applications to draw fancy menus and hook strings using
@@ -416,7 +416,7 @@ if EFI_UNICODE_COLLATION_PROTOCOL2
 
 config EFI_UNICODE_CAPITALIZATION
 	bool "Support Unicode capitalization"
-	default y if !HAS_BOARD_SIZE_LIMIT
+	default y if BOARD_SIZE_LIMIT = 0
 	help
 	  Select this option to enable correct handling of the capitalization of
 	  Unicode codepoints in the range 0x0000-0xffff. If this option is not
-- 
2.39.5

