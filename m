Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0938CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614DE83544;
	Wed,  3 Sep 2025 12:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756897053;
	bh=7vZBYLwZMPQ9C8LieXedN6/Ha9zhLFzfyz16MjFFJaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ImggWOXt415jzDnZ8KoixUspJ7/iap7wwY7DCIAKL7gdafqCzs+0euA4NfJ6P7QXe
	 sxdHgdlDTJPBqwBjTCFPfTt/xpHOITW8cDYF113f4JGlNaApO+c7edC7HdhGJv2Vxs
	 rYJrRI6PAi39frlRviW1I3h8gkLLoYiX+3leFG0e7bBek4DkWO6dQswezXGuP5888v
	 IlJDms7bd7a8n57ujmIkcCZFK9xTYjqoPa9yaUsKk2vnhAoFqCNr4/DC50jvtAhcf5
	 UBNxA86vvy5M/lAHQsqx3w7ZpE6zBj9TsM62j0drzYmRSxWy6DqkSK6BEdsfLdsi6h
	 BGlLzmMOYBwcw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FF6C83390; Wed,  3 Sep 2025 12:57:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEED38353A
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EAH8srw5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 375081038C103; 
 Wed,  3 Sep 2025 12:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756897049; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=7vZBYLwZMPQ9C8LieXedN6/Ha9zhLFzfyz16MjFFJaE=;
 b=EAH8srw548BWWoOR8ysAIjNhXagqU1LASuV6scizKJZzITN6cmIhiSsPwCCFAcD8eA0lat
 IO2nML+C62eJRF9cyrKdjpB5hk5hQA3nG3j3+o/7E/OKHZ7/H2ATIQJjg0ulm7p33YIbB8
 kybfLYDbf4qJPdnj/8hKaY/kt6utBgbEP/MtorQ76NnlvTFvwtRbH1gJFra+GZuNl8yfkw
 kb/z+9BgY1pQ/UVG5KWnf+qbznAWMIwaK/hV69cZF9FhXs4zjfh263dphMUpEnyxP2swk6
 Oyg4h8YKTcXLszTyuU2N3o6sQlzEp1gOnilZfwi0X42CY0lccm9DLfWJiDx1PA==
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
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
Date: Wed,  3 Sep 2025 12:56:50 +0200
Message-Id: <20250903105653.335417-3-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250903105653.335417-1-pro@denx.de>
References: <20250903105653.335417-1-pro@denx.de>
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
 Kconfig                                   | 30 ++++++++++++++++-------
 Makefile                                  |  6 ++---
 arch/arm/mach-socfpga/Kconfig             |  5 +++-
 arch/mips/mach-mtmips/Kconfig             |  5 +++-
 arch/x86/cpu/apollolake/Kconfig           |  5 +++-
 configs/am62ax_evm_r5_defconfig           |  1 +
 configs/am62px_evm_r5_defconfig           |  1 +
 configs/am62x_beagleplay_a53_defconfig    |  1 +
 configs/am62x_beagleplay_r5_defconfig     |  1 +
 configs/am62x_evm_a53_defconfig           |  1 +
 configs/am62x_evm_a53_ethboot_defconfig   |  1 +
 configs/am62x_evm_r5_defconfig            |  1 +
 configs/am64x_evm_r5_defconfig            |  1 +
 configs/am65x_evm_r5_defconfig            |  1 +
 configs/am65x_evm_r5_usbmsc_defconfig     |  1 +
 configs/am67a_beagley_ai_r5_defconfig     |  1 +
 configs/brcp150_defconfig                 |  1 +
 configs/brcp170_defconfig                 |  1 +
 configs/brcp1_1r_defconfig                |  1 +
 configs/brcp1_1r_switch_defconfig         |  1 +
 configs/brcp1_2r_defconfig                |  1 +
 configs/brsmarc2_defconfig                |  1 +
 configs/evb-ast2600_defconfig             |  1 +
 configs/evb-rk3288_defconfig              |  1 +
 configs/firefly-rk3288_defconfig          |  1 +
 configs/ibex-ast2700_defconfig            |  1 +
 configs/ibm-sbp1_defconfig                |  1 +
 configs/imx28_btt3_defconfig              |  1 +
 configs/imx28_xea_defconfig               |  1 +
 configs/imx6q_bosch_acc_defconfig         |  1 +
 configs/imxrt1020-evk_defconfig           |  1 +
 configs/imxrt1050-evk_defconfig           |  1 +
 configs/imxrt1050-evk_fspi_defconfig      |  1 +
 configs/imxrt1170-evk_defconfig           |  1 +
 configs/j721e_beagleboneai64_r5_defconfig |  1 +
 configs/j721e_evm_r5_defconfig            |  1 +
 configs/j721s2_evm_r5_defconfig           |  1 +
 configs/j722s_evm_r5_defconfig            |  1 +
 configs/j784s4_evm_r5_defconfig           |  1 +
 configs/kontron_sl28_defconfig            |  1 +
 configs/phycore_am62ax_r5_defconfig       |  1 +
 configs/phycore_am62x_a53_defconfig       |  1 +
 configs/phycore_am62x_r5_defconfig        |  1 +
 configs/phycore_am64x_r5_defconfig        |  1 +
 configs/stm32746g-eval_spl_defconfig      |  1 +
 configs/stm32f746-disco_spl_defconfig     |  1 +
 configs/stm32f769-disco_spl_defconfig     |  1 +
 configs/tinker-rk3288_defconfig           |  1 +
 configs/tinker-s-rk3288_defconfig         |  1 +
 configs/verdin-am62_a53_defconfig         |  1 +
 configs/verdin-am62_r5_defconfig          |  1 +
 configs/verdin-am62p_a53_defconfig        |  1 +
 configs/verdin-am62p_r5_defconfig         |  1 +
 configs/xilinx_mbv32_defconfig            |  1 +
 configs/xilinx_mbv32_smode_defconfig      |  1 +
 configs/xilinx_mbv64_defconfig            |  1 +
 configs/xilinx_mbv64_smode_defconfig      |  1 +
 configs/xilinx_zynqmp_kria_defconfig      |  1 +
 configs/xilinx_zynqmp_virt_defconfig      |  1 +
 59 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/Kconfig b/Kconfig
index f1a6be299e8..e73dd91a408 100644
--- a/Kconfig
+++ b/Kconfig
@@ -556,36 +556,48 @@ config BOARD_SIZE_LIMIT
 	  include SPL nor TPL, on platforms that use that functionality, they
 	  have separate options to restrict size.
 
-config VPL_SIZE_LIMIT
+config HAS_VPL_SIZE_LIMIT
+	bool "Enable size limit check for the VPL image"
+	depends on !COMPILE_TEST
 	depends on VPL
+
+config VPL_SIZE_LIMIT
 	hex "Maximum size of VPL image"
-	default 0x0
+	depends on HAS_VPL_SIZE_LIMIT
 	help
 	  Specifies the maximum length of the U-Boot VPL image.
 	  If this value is zero, it is ignored.
 
-config TPL_SIZE_LIMIT
+config HAS_TPL_SIZE_LIMIT
+	bool "Enable size limit check for the TPL image"
+	depends on !COMPILE_TEST
 	depends on TPL
+
+config TPL_SIZE_LIMIT
 	hex "Maximum size of TPL image"
-	default 0x0
+	depends on HAS_TPL_SIZE_LIMIT
 	help
 	  Specifies the maximum length of the U-Boot TPL image.
 	  If this value is zero, it is ignored.
 
-config SPL_SIZE_LIMIT
+config HAS_SPL_SIZE_LIMIT
+	bool "Enable size limit check for the SPL image"
+	depends on !COMPILE_TEST
 	depends on SPL
+
+config SPL_SIZE_LIMIT
 	hex "Maximum size of SPL image"
+	depends on HAS_SPL_SIZE_LIMIT
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
-	default 0x0
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
@@ -594,7 +606,7 @@ config SPL_SIZE_LIMIT_SUBTRACT_GD
 
 config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
 	bool "SPL image size check: provide space for malloc() pool before relocation"
-	depends on SPL_SIZE_LIMIT > 0
+	depends on HAS_SPL_SIZE_LIMIT
 	help
 	  If enabled, SPL_SYS_MALLOC_F_LEN is reserved in SPL_SIZE_LIMIT check
 	  to ensure such an image does not overflow SRAM if SPL_SIZE_LIMIT
@@ -603,7 +615,7 @@ config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
 
 config SPL_SIZE_LIMIT_PROVIDE_STACK
 	hex "SPL image size check: provide stack space before relocation"
-	depends on SPL_SIZE_LIMIT > 0
+	depends on HAS_SPL_SIZE_LIMIT
 	default 0x0
 	help
 	  If set, this size is reserved in SPL_SIZE_LIMIT check to ensure such
diff --git a/Makefile b/Makefile
index b4f10c08d75..a17d8b57196 100644
--- a/Makefile
+++ b/Makefile
@@ -1109,19 +1109,19 @@ else
 BOARD_SIZE_CHECK =
 endif
 
-ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
+ifneq ($(CONFIG_SPL_SIZE_LIMIT),)
 SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
 else
 SPL_SIZE_CHECK =
 endif
 
-ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
+ifneq ($(CONFIG_TPL_SIZE_LIMIT),)
 TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
 else
 TPL_SIZE_CHECK =
 endif
 
-ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
+ifneq ($(CONFIG_VPL_SIZE_LIMIT),)
 VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
 else
 VPL_SIZE_CHECK =
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..d4d46100736 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -22,8 +22,11 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
 	bool "Allow non-FIT VAB signed images"
 	depends on SOCFPGA_SECURE_VAB_AUTH
 
+config HAS_SPL_SIZE_LIMIT
+	default y if TARGET_SOCFPGA_GEN5
+
 config SPL_SIZE_LIMIT
-	default 0x10000 if TARGET_SOCFPGA_GEN5
+	default 0x10000 if TARGET_SOCFPGA_GEN5 && HAS_SPL_SIZE_LIMIT
 
 config SPL_SIZE_LIMIT_PROVIDE_STACK
 	default 0x200 if TARGET_SOCFPGA_GEN5
diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
index 3fcd0b8465b..d2a1652954c 100644
--- a/arch/mips/mach-mtmips/Kconfig
+++ b/arch/mips/mach-mtmips/Kconfig
@@ -36,8 +36,11 @@ config SPL_TEXT_BASE
 	default 0x9c000000 if !SOC_MT7621
 	default 0x80100000 if SOC_MT7621
 
+config HAS_SPL_SIZE_LIMIT
+	default y if SOC_MT7621
+
 config SPL_SIZE_LIMIT
-	default 0x30000 if SOC_MT7621
+	default 0x30000 if SOC_MT7621 && HAS_SPL_SIZE_LIMIT
 
 config TPL_TEXT_BASE
 	default 0xbfc00000 if SOC_MT7621
diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
index 5dd866ffcfe..d70e8def36f 100644
--- a/arch/x86/cpu/apollolake/Kconfig
+++ b/arch/x86/cpu/apollolake/Kconfig
@@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
 	hex
 	default 0xe0000000
 
+config HAS_TPL_SIZE_LIMIT
+	default y
+
 config TPL_SIZE_LIMIT
-	default 0x7800
+	default 0x7800 if HAS_TPL_SIZE_LIMIT
 
 config CPU_ADDR_BITS
 	default 39
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 64886986c42..003e35d32dd 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -20,6 +20,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4..ad56354a252 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c4b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3C000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 05853317fea..dfac96379ce 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -20,6 +20,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index ce503000e4c..3f5d1642b29 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 4da668396d0..d368cc99c84 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am62x_evm_a53_ethboot_defconfig b/configs/am62x_evm_a53_ethboot_defconfig
index 9d3c6b889f0..5d073bebb9a 100644
--- a/configs/am62x_evm_a53_ethboot_defconfig
+++ b/configs/am62x_evm_a53_ethboot_defconfig
@@ -6,6 +6,7 @@ CONFIG_SOC_K3_AM625=y
 CONFIG_TARGET_AM625_A53_EVM=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-sk"
 CONFIG_SPL_STACK_R_ADDR=0x83000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 18ffc991b25..4eaa8d3e3ac 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 491e0dd102e..b49370d2a34 100644
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
diff --git a/configs/am67a_beagley_ai_r5_defconfig b/configs/am67a_beagley_ai_r5_defconfig
index 00c6ba6e2b5..7d461fb93bb 100644
--- a/configs/am67a_beagley_ai_r5_defconfig
+++ b/configs/am67a_beagley_ai_r5_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c7b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3C000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/brcp150_defconfig b/configs/brcp150_defconfig
index 6d2b92e1ec3..68d7ba2a507 100644
--- a/configs/brcp150_defconfig
+++ b/configs/brcp150_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp170_defconfig b/configs/brcp170_defconfig
index 44460c510f1..b92db4dc6d4 100644
--- a/configs/brcp170_defconfig
+++ b/configs/brcp170_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp1_1r_defconfig b/configs/brcp1_1r_defconfig
index 684800228ef..050c743641d 100644
--- a/configs/brcp1_1r_defconfig
+++ b/configs/brcp1_1r_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp1_1r_switch_defconfig b/configs/brcp1_1r_switch_defconfig
index 9b45961ef8e..79b7bea5935 100644
--- a/configs/brcp1_1r_switch_defconfig
+++ b/configs/brcp1_1r_switch_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x30000
diff --git a/configs/brcp1_2r_defconfig b/configs/brcp1_2r_defconfig
index 357eef38601..bbc3756bcf9 100644
--- a/configs/brcp1_2r_defconfig
+++ b/configs/brcp1_2r_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_STACK_R=y
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
index 8e8259f291d..5c6b31944c5 100644
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
index 07c805faa2f..87db48a2ac5 100644
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
index 8715893bbcc..2ba2b7f72af 100644
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
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 6f0ef2eaee3..30b2af737b1 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -18,6 +18,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=8
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=69632
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x1ff000
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
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index 50a9d95d7bf..8e9450326b1 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_BSS_START_ADDR=0x41cf59f0
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0xf59f0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index ceb2e273b54..4499073c5d9 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41cf59f0
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0xf59f0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index aaf8fd32879..9cbb841ce49 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c76000
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 8e2741c8d42..590bb9452df 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c7b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3C000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index cc340a2fe76..21b040d6399 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -26,6 +26,7 @@ CONFIG_SPL_BSS_START_ADDR=0x41c76000
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
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
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index 01d100842de..657c2fe2612 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index fdbe79d3e32..f146ee30488 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_ENV_OFFSET_REDUND=0x6c0000
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index 0368d4ef474..a41c09569df 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -26,6 +26,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index d1ac992dc7a..4bbe38536d1 100644
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
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 2c0573cd54e..f7cbcd2e48a 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SYS_BOOTM_LEN=0x40000000
 CONFIG_SYS_LOAD_ADDR=0x88200000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_SYS_MEMTEST_START=0x80000000
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index efba857ad70..d2fcd38a161 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -22,6 +22,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_LIBDISK_SUPPORT=y
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index c46b883a9c6..f04e184a079 100644
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
diff --git a/configs/verdin-am62p_r5_defconfig b/configs/verdin-am62p_r5_defconfig
index a8b0e942b61..076111b30d9 100644
--- a/configs/verdin-am62p_r5_defconfig
+++ b/configs/verdin-am62p_r5_defconfig
@@ -22,6 +22,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c4b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x3C000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
 CONFIG_SPL_LIBDISK_SUPPORT=y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index e3341179a68..94cd6c7112b 100644
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
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index c95b4497395..9058bdf8030 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index a3cc1a5669e..2f00466ff9e 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 3d49670c60c..ec5598025bf 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
+CONFIG_HAS_SPL_SIZE_LIMIT=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x40600000
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 3e2ac614405..d1238687ce3 100644
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
index 65c8a4bbaad..11a39595680 100644
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

