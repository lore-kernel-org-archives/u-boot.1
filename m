Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97E7CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E20839D6;
	Mon, 10 Nov 2025 10:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1762766013;
	bh=dqac5NkjmsnhIEr9hZslGrhzc9Qp3iMra+cLa8Rp7Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wp4FKNEbz1Q0FlQR+Lja1ViMYkcEGXSBrLRQk+Tvh+m48nZyCTReyOvvGKok5j+ej
	 AJvPRwQwCEsVVsXrfxTBWMYGgwUvzGSCGBz/dh1iVMTup4PwwijC8AV1EbH/z/jw0J
	 /CFgSRqoRk/AUkcREa1R3VWY/SH3Ed1sFiLpZLTLqTOYAxGgsRvMv+OR8QPoGsInvu
	 v/NgnMAnHYuKfrMNbgUtSABZObly0d5XN32sn6psFcWcp+EI3J8vTMUX/ksPD4ufFx
	 V04QEHfqPTE5DpOU3gjr6e5dmCBn9DlVxlAoYzeI2oR9WPp1CKF/3BB97J0peMyh73
	 nSQS6F/Ylfupw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EADD839DE; Mon, 10 Nov 2025 10:13:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DEE83959
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dlt4EL4h"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7D7A103CF2A2; Mon, 10 Nov 2025 10:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1762766009; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=dqac5NkjmsnhIEr9hZslGrhzc9Qp3iMra+cLa8Rp7Es=;
 b=dlt4EL4hOTNhW842Zl4ScwwJ0/3FelYrEwSzW4R5K7KXber9fM6rF0zBwyH+th74HD0QWa
 Uyb3OOQ4rveRxODNUeqIMG/O4/dcv2Yiy3EQ9IMvjFLYbmAT+pKRGwE14lRXuDhL+iOvBC
 Ufw9lr2ljKoUSQUzBjiGBSXuAh1HPX6uxLhaCKCVkJKpTWg9LhICFjcT0g5h6wYsY3hePD
 6Jdrz1gq4ccGWfAgh0z8DKnKcpcKXC9ENPY58ijDBQ4UPR6SxIcrdgoZrSiFil0vL7rKyL
 0BX3xXd9afp3NNBw23C/PrX3Fy1nKqm/mtVsf9xEn4JOOhWqi7Vkq4ONrIqKNA==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v5 1/3] Image size checks: Use HAS_SIZE_LIMIT consistently
Date: Mon, 10 Nov 2025 10:12:54 +0100
Message-Id: <20251110091256.2422534-2-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251110091256.2422534-1-pro@denx.de>
References: <20251110091256.2422534-1-pro@denx.de>
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

Use a consistent logic for image size checks. No functional change.

Before this commit, there were two concurrent approaches of how image
size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
dedicated Kconfig symbol to achieve this, all the other size checks were
disabled by assigning them a limit of zero bytes.

By this commit we achieve a consistent logic for size limiting, by
introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
have it yet.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v5: Use HAS_XXX_SIZE_LIMIT in the ifeq-statements of the Makefile

 Makefile                              |  8 ++++----
 arch/arm/mach-socfpga/Kconfig         |  6 ------
 arch/mips/mach-mtmips/Kconfig         |  3 ---
 arch/x86/cpu/apollolake/Kconfig       |  3 ---
 common/spl/Kconfig                    | 23 +++++++++++++++++++----
 common/spl/Kconfig.tpl                |  9 ++++++++-
 common/spl/Kconfig.vpl                |  7 ++++++-
 configs/am64x_evm_r5_defconfig        |  1 +
 configs/am65x_evm_r5_defconfig        |  1 +
 configs/am65x_evm_r5_usbmsc_defconfig |  1 +
 configs/brcp150_defconfig             |  1 +
 configs/brcp170_defconfig             |  1 +
 configs/brcp1_1r_defconfig            |  1 +
 configs/brcp1_1r_switch_defconfig     |  1 +
 configs/brcp1_2r_defconfig            |  1 +
 configs/brsmarc2_defconfig            |  1 +
 configs/evb-ast2600_defconfig         |  1 +
 configs/evb-rk3288_defconfig          |  1 +
 configs/firefly-rk3288_defconfig      |  1 +
 configs/ibex-ast2700_defconfig        |  1 +
 configs/ibm-sbp1_defconfig            |  1 +
 configs/imx28_btt3_defconfig          |  1 +
 configs/imx28_xea_defconfig           |  1 +
 configs/imxrt1020-evk_defconfig       |  1 +
 configs/imxrt1050-evk_defconfig       |  1 +
 configs/imxrt1050-evk_fspi_defconfig  |  1 +
 configs/imxrt1170-evk_defconfig       |  1 +
 configs/kontron_sl28_defconfig        |  1 +
 configs/phycore_am64x_r5_defconfig    |  1 +
 configs/stm32746g-eval_spl_defconfig  |  1 +
 configs/stm32f746-disco_spl_defconfig |  1 +
 configs/stm32f769-disco_spl_defconfig |  1 +
 configs/tinker-rk3288_defconfig       |  1 +
 configs/tinker-s-rk3288_defconfig     |  1 +
 configs/verdin-am62p_a53_defconfig    |  1 +
 configs/xilinx_mbv32_defconfig        |  1 +
 configs/xilinx_zynqmp_kria_defconfig  |  1 +
 configs/xilinx_zynqmp_virt_defconfig  |  1 +
 38 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 62a24e38283..617106ad79e 100644
--- a/Makefile
+++ b/Makefile
@@ -1104,25 +1104,25 @@ LDPPFLAGS += \
 #########################################################################
 #########################################################################
 
-ifneq ($(CONFIG_BOARD_SIZE_LIMIT),)
+ifeq ($(CONFIG_HAS_BOARD_SIZE_LIMIT),y)
 BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 else
 BOARD_SIZE_CHECK =
 endif
 
-ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
+ifeq ($(CONFIG_HAS_SPL_SIZE_LIMIT),y)
 SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
 else
 SPL_SIZE_CHECK =
 endif
 
-ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
+ifeq ($(CONFIG_HAS_TPL_SIZE_LIMIT),y)
 TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
 else
 TPL_SIZE_CHECK =
 endif
 
-ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
+ifeq ($(CONFIG_HAS_VPL_SIZE_LIMIT),y)
 VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
 else
 VPL_SIZE_CHECK =
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..db00ada25ee 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -22,12 +22,6 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
 	bool "Allow non-FIT VAB signed images"
 	depends on SOCFPGA_SECURE_VAB_AUTH
 
-config SPL_SIZE_LIMIT
-	default 0x10000 if TARGET_SOCFPGA_GEN5
-
-config SPL_SIZE_LIMIT_PROVIDE_STACK
-	default 0x200 if TARGET_SOCFPGA_GEN5
-
 config SPL_STACK_R_ADDR
 	default 0x00800000 if TARGET_SOCFPGA_GEN5
 
diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
index 3fcd0b8465b..49fc499e744 100644
--- a/arch/mips/mach-mtmips/Kconfig
+++ b/arch/mips/mach-mtmips/Kconfig
@@ -36,9 +36,6 @@ config SPL_TEXT_BASE
 	default 0x9c000000 if !SOC_MT7621
 	default 0x80100000 if SOC_MT7621
 
-config SPL_SIZE_LIMIT
-	default 0x30000 if SOC_MT7621
-
 config TPL_TEXT_BASE
 	default 0xbfc00000 if SOC_MT7621
 
diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
index 5dd866ffcfe..fe15353fca6 100644
--- a/arch/x86/cpu/apollolake/Kconfig
+++ b/arch/x86/cpu/apollolake/Kconfig
@@ -78,9 +78,6 @@ config MMCONF_BASE_ADDRESS
 	hex
 	default 0xe0000000
 
-config TPL_SIZE_LIMIT
-	default 0x7800
-
 config CPU_ADDR_BITS
 	default 39
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 8dade2b501e..97c7bfdad47 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -36,19 +36,33 @@ config SPL_FRAMEWORK_BOARD_INIT_F
 	  - initialize the serial (preloader_console_init)
 	  Unless you want to provide your own board_init_f, you should say Y.
 
+config HAS_SPL_SIZE_LIMIT
+	bool "Enable size limit check for the SPL image"
+	depends on !COMPILE_TEST
+	depends on SPL
+	default y if ARCH_MX6
+	default y if ARCH_MVEBU && ARMADA_32BIT
+	default y if ARMADA_38X
+	default y if K3_DM_FW
+	default y if SOC_K3_AM625
+	default y if SOC_MT7621
+	default y if TARGET_SOCFPGA_GEN5
+
 config SPL_SIZE_LIMIT
 	hex "Maximum size of SPL image"
+	depends on HAS_SPL_SIZE_LIMIT
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
-	default 0x0
+	default 0x30000 if SOC_MT7621
+	default 0x10000 if TARGET_SOCFPGA_GEN5
 	help
 	  Specifies the maximum length of the U-Boot SPL image.
 	  If this value is zero, it is ignored.
 
 config SPL_SIZE_LIMIT_SUBTRACT_GD
 	bool "SPL image size check: provide space for global data"
-	depends on SPL_SIZE_LIMIT > 0
+	depends on HAS_SPL_SIZE_LIMIT
 	help
 	  If enabled, aligned size of global data is reserved in
 	  SPL_SIZE_LIMIT check to ensure such an image does not overflow SRAM
@@ -57,7 +71,7 @@ config SPL_SIZE_LIMIT_SUBTRACT_GD
 
 config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
 	bool "SPL image size check: provide space for malloc() pool before relocation"
-	depends on SPL_SIZE_LIMIT > 0
+	depends on HAS_SPL_SIZE_LIMIT
 	help
 	  If enabled, SPL_SYS_MALLOC_F_LEN is reserved in SPL_SIZE_LIMIT check
 	  to ensure such an image does not overflow SRAM if SPL_SIZE_LIMIT
@@ -66,7 +80,8 @@ config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
 
 config SPL_SIZE_LIMIT_PROVIDE_STACK
 	hex "SPL image size check: provide stack space before relocation"
-	depends on SPL_SIZE_LIMIT > 0
+	depends on HAS_SPL_SIZE_LIMIT
+	default 0x200 if TARGET_SOCFPGA_GEN5
 	default 0x0
 	help
 	  If set, this size is reserved in SPL_SIZE_LIMIT check to ensure such
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd3..82ed0a06c89 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -1,9 +1,16 @@
 menu "TPL configuration options"
 	depends on TPL
 
+config HAS_TPL_SIZE_LIMIT
+	bool "Enable size limit check for the TPL image"
+	depends on !COMPILE_TEST
+	depends on TPL
+	default y if INTEL_APOLLOLAKE
+
 config TPL_SIZE_LIMIT
 	hex "Maximum size of TPL image"
-	default 0x0
+	depends on HAS_TPL_SIZE_LIMIT
+	default 0x7800 if INTEL_APOLLOLAKE
 	help
 	  Specifies the maximum length of the U-Boot TPL image.
 	  If this value is zero, it is ignored.
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 434562443ac..1945fa22b6b 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -220,9 +220,14 @@ config VPL_SERIAL
 	  Enable support for serial in VPL. See SPL_SERIAL for
 	  details.
 
+config HAS_VPL_SIZE_LIMIT
+	bool "Enable size limit check for the VPL image"
+	depends on !COMPILE_TEST
+	depends on VPL
+
 config VPL_SIZE_LIMIT
 	hex "Maximum size of VPL image"
-	default 0x0
+	depends on HAS_VPL_SIZE_LIMIT
 	help
 	  Specifies the maximum length of the U-Boot VPL image.
 	  If this value is zero, it is ignored.
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index a675ea84fca..e060ba81147 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_BSS_START_ADDR=0x7019b800
 CONFIG_SPL_BSS_MAX_SIZE=0x4000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x190000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 6733dcfdd85..8d368ce9f19 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c7effc
 CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x7ec00
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 37b5c6a43e7..df4c1faae96 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c7effc
 CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x7ec00
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/brcp150_defconfig b/configs/brcp150_defconfig
index bae185e8126..82402f33bdf 100644
--- a/configs/brcp150_defconfig
+++ b/configs/brcp150_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp170_defconfig b/configs/brcp170_defconfig
index f8e17ece276..e3a42aeb1cb 100644
--- a/configs/brcp170_defconfig
+++ b/configs/brcp170_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp1_1r_defconfig b/configs/brcp1_1r_defconfig
index 568313d4860..77f5866b53f 100644
--- a/configs/brcp1_1r_defconfig
+++ b/configs/brcp1_1r_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp1_1r_switch_defconfig b/configs/brcp1_1r_switch_defconfig
index 805de796df6..563df86d6b0 100644
--- a/configs/brcp1_1r_switch_defconfig
+++ b/configs/brcp1_1r_switch_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp1_2r_defconfig b/configs/brcp1_2r_defconfig
index e92d8381bbb..09255ab111a 100644
--- a/configs/brcp1_2r_defconfig
+++ b/configs/brcp1_2r_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brsmarc2_defconfig b/configs/brsmarc2_defconfig
index 2ed54817af4..b460ee11ea6 100644
--- a/configs/brsmarc2_defconfig
+++ b/configs/brsmarc2_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/evb-ast2600_defconfig b/configs/evb-ast2600_defconfig
index 16e8a58ccc0..393ed3e1873 100644
--- a/configs/evb-ast2600_defconfig
+++ b/configs/evb-ast2600_defconfig
@@ -26,6 +26,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x83000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x10000
 CONFIG_SPL=y
 # CONFIG_ARMV7_NONSEC is not set
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
index 02347b58c22..3f8bb365cde 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288_defconfig
@@ -20,6 +20,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x4b000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index d7b01e67db9..35ade7f99a3 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -13,6 +13,7 @@ CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_FIREFLY_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
index 088eec1ec70..19aec40f4f6 100644
--- a/configs/ibex-ast2700_defconfig
+++ b/configs/ibex-ast2700_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_TEXT_BASE=0x14bc0080
 CONFIG_SPL_BSS_START_ADDR=0x14bd7800
 CONFIG_SPL_BSS_MAX_SIZE=0x800
 CONFIG_SYS_LOAD_ADDR=0x83000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x16000
 CONFIG_SPL=y
 CONFIG_SYS_MEM_TOP_HIDE=0x10000000
diff --git a/configs/ibm-sbp1_defconfig b/configs/ibm-sbp1_defconfig
index 5f16301e5b5..26420c6f831 100644
--- a/configs/ibm-sbp1_defconfig
+++ b/configs/ibm-sbp1_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x83000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x10000
 CONFIG_SPL=y
 # CONFIG_ARMV7_NONSEC is not set
diff --git a/configs/imx28_btt3_defconfig b/configs/imx28_btt3_defconfig
index 6516350e4c3..02c2e28ef26 100644
--- a/configs/imx28_btt3_defconfig
+++ b/configs/imx28_btt3_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_TEXT_BASE=0x1000
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SF_DEFAULT_BUS=2
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0xa000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x90000
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 7e4956090ea..160045c5e30 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SPL_TEXT_BASE=0x1000
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SF_DEFAULT_BUS=2
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0xa000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x90000
diff --git a/configs/imxrt1020-evk_defconfig b/configs/imxrt1020-evk_defconfig
index 17c650e6950..7fc6afafc1b 100644
--- a/configs/imxrt1020-evk_defconfig
+++ b/configs/imxrt1020-evk_defconfig
@@ -17,6 +17,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_TEXT_BASE=0x20209000
 CONFIG_SYS_LOAD_ADDR=0x20209000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_HAVE_SYS_UBOOT_START=y
diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index 5faf964759d..6ba608f20a4 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_TEXT_BASE=0x20002000
 CONFIG_SYS_LOAD_ADDR=0x20002000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_HAVE_SYS_UBOOT_START=y
diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
index cc7e8a3e10b..7d6a41403fc 100644
--- a/configs/imxrt1050-evk_fspi_defconfig
+++ b/configs/imxrt1050-evk_fspi_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_TEXT_BASE=0x20002000
 CONFIG_SYS_LOAD_ADDR=0x20002000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_HAVE_SYS_UBOOT_START=y
diff --git a/configs/imxrt1170-evk_defconfig b/configs/imxrt1170-evk_defconfig
index 9bd3874143c..4f7e6104c78 100644
--- a/configs/imxrt1170-evk_defconfig
+++ b/configs/imxrt1170-evk_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_TEXT_BASE=0x202C0000
 CONFIG_SYS_LOAD_ADDR=0x202C0000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_HAVE_SYS_UBOOT_START=y
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index e97534ecc0a..cb57538b597 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3f0000
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index d8117b1c1ae..8716b8f3cbd 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -26,6 +26,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x7019b800
 CONFIG_SPL_BSS_MAX_SIZE=0x4000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x190000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/stm32746g-eval_spl_defconfig b/configs/stm32746g-eval_spl_defconfig
index 432d35d0d5a..5ce93a34b9e 100644
--- a/configs/stm32746g-eval_spl_defconfig
+++ b/configs/stm32746g-eval_spl_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_SYS_LOAD_ADDR=0x8009000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x9000
 CONFIG_STM32F7=y
 CONFIG_TARGET_STM32F746_DISCO=y
diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
index 699ae9d08fc..b629c5eeefd 100644
--- a/configs/stm32f746-disco_spl_defconfig
+++ b/configs/stm32f746-disco_spl_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_SYS_LOAD_ADDR=0x8009000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x9000
 CONFIG_STM32F7=y
 CONFIG_TARGET_STM32F746_DISCO=y
diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
index 74210fe8252..f82bcd9d937 100644
--- a/configs/stm32f769-disco_spl_defconfig
+++ b/configs/stm32f769-disco_spl_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_SYS_LOAD_ADDR=0x8009000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x9000
 CONFIG_STM32F7=y
 CONFIG_TARGET_STM32F746_DISCO=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index afbb394228f..9c56fe10bfd 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -12,6 +12,7 @@ CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_TINKER_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x4b000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 876086573d3..2f830eb8c88 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -12,6 +12,7 @@ CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_TINKER_RK3288=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x4b000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index dd032427987..6c3ef4a8762 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x40000000
 CONFIG_SYS_LOAD_ADDR=0x88200000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SYS_MEMTEST_START=0x80000000
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 88d9e5ce6b2..46d5a2eae0e 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 8ad05e37189..95c2eb07fef 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x2a000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x2220000
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 525744b0f61..584cbf52281 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -14,6 +14,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x2a000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x1E80000
-- 
2.39.5

