Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E266AC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 18:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8B6810F2;
	Wed, 19 Mar 2025 19:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p2CW5bMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E453E810F4; Wed, 19 Mar 2025 19:55:06 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9915B80FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 19:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JIt097403604
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 13:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742410500;
 bh=tU7NRqpIMJJkz72jzqKGovILXOeHaNCkKr/XCXDTnu8=;
 h=From:To:CC:Subject:Date;
 b=p2CW5bMWfOP/uEa3swBjznBfFq1cUJXeJ2yx7zl7LIRb9L8YdLZdYu0xvgA6rC3sz
 KTQ+YiYEI7Dw/s2afw1W13tqbFlaf+zyLmxpCoLduncoxwivO6BaGmKvfjblOiU8IT
 8KkOU/xM3BQdobTccGkKFybSMF5cHHuEhhyGPZ0E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JIt0TG029608
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 13:55:00 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 13:55:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 13:55:00 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JIsxSQ117632;
 Wed, 19 Mar 2025 13:54:59 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: mach-k3: j721e: Split out J7200 SoC support from J721e
Date: Wed, 19 Mar 2025 13:54:58 -0500
Message-ID: <20250319185458.270297-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Currently in j721e_init.c we check which firewalls to remove using
the board configuration (e.g CONFIG_TARGET_J721E_R5_EVM). We do this
as J721e and J7200 have different IP and firewalls but use the same
SoC definition (SOC_K3_J721E) even though they are different SoCs.

The idea was they would be similar enough that they both could use
the same SoC config to help with common code sharing. Board checks
would then be used differentiate.

This has grown far too messy to maintain any more, especially now
that there is more than one board using J721e (EVM, SK, Beagle AI64).
As differentiation is done based on board, every one of these boards
would have to have checks added for them. Instead let's split J7200
support out from J721e like how normal new SoC support is done.

This patch touches several subsystems and could not be split much better
as when we add SOC_K3_J7200 we want to make use of it in all spots that
once used the combined SOC_K3_J721E so we can turn off SOC_K3_J721E when
building for J7200 boards.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/Makefile                         |  3 +-
 arch/arm/dts/k3-j7200-binman.dtsi             | 40 -------------------
 arch/arm/mach-k3/Kconfig                      | 19 +++++----
 arch/arm/mach-k3/Makefile                     |  1 +
 arch/arm/mach-k3/include/mach/hardware.h      |  4 ++
 arch/arm/mach-k3/include/mach/spl.h           |  4 ++
 arch/arm/mach-k3/j7200/Kconfig                | 36 +++++++++++++++++
 arch/arm/mach-k3/j7200/Makefile               |  7 ++++
 arch/arm/mach-k3/j721e/Kconfig                | 21 ----------
 arch/arm/mach-k3/j721e/j721e_init.c           |  6 +--
 arch/arm/mach-k3/r5/Makefile                  |  2 +-
 board/ti/j7200/Kconfig                        | 40 +++++++++++++++++++
 board/ti/j7200/MAINTAINERS                    |  7 ++++
 board/ti/j7200/Makefile                       |  7 ++++
 .../board-cfg.yaml}                           |  0
 board/ti/{j721e/j721e.env => j7200/j7200.env} | 19 +--------
 .../pm-cfg_j7200.yaml => j7200/pm-cfg.yaml}   |  0
 .../rm-cfg_j7200.yaml => j7200/rm-cfg.yaml}   |  0
 .../sec-cfg_j7200.yaml => j7200/sec-cfg.yaml} |  0
 board/ti/j721e/Kconfig                        | 36 -----------------
 board/ti/j721e/MAINTAINERS                    |  2 -
 board/ti/j721e/j721e.env                      | 17 +-------
 configs/j7200_evm_a72_defconfig               |  2 +-
 configs/j7200_evm_r5_defconfig                |  2 +-
 drivers/clk/ti/clk-k3.c                       |  2 +
 drivers/dma/ti/Makefile                       |  1 +
 drivers/dma/ti/k3-psil.c                      |  2 +
 drivers/firmware/ti_sci_static_data.h         |  2 +-
 drivers/power/domain/ti-power-domain.c        |  2 +
 drivers/ram/Kconfig                           |  2 +-
 30 files changed, 134 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm/mach-k3/j7200/Kconfig
 create mode 100644 arch/arm/mach-k3/j7200/Makefile
 create mode 100644 board/ti/j7200/Kconfig
 create mode 100644 board/ti/j7200/MAINTAINERS
 create mode 100644 board/ti/j7200/Makefile
 rename board/ti/{j721e/board-cfg_j7200.yaml => j7200/board-cfg.yaml} (100%)
 copy board/ti/{j721e/j721e.env => j7200/j7200.env} (52%)
 rename board/ti/{j721e/pm-cfg_j7200.yaml => j7200/pm-cfg.yaml} (100%)
 rename board/ti/{j721e/rm-cfg_j7200.yaml => j7200/rm-cfg.yaml} (100%)
 rename board/ti/{j721e/sec-cfg_j7200.yaml => j7200/sec-cfg.yaml} (100%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 267b0179a5f..e9eb8a37b7f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1103,10 +1103,11 @@ dtb-$(CONFIG_SOC_K3_AM654) += \
 	k3-am654-r5-base-board.dtb
 
 dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-r5-common-proc-board.dtb \
-			      k3-j7200-r5-common-proc-board.dtb \
 			      k3-j721e-r5-sk.dtb \
 			      k3-j721e-r5-beagleboneai64.dtb
 
+dtb-$(CONFIG_SOC_K3_J7200) += k3-j7200-r5-common-proc-board.dtb
+
 dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-r5-base-board.dtb\
 			       k3-j721s2-r5-common-proc-board.dtb
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index ef7d4594f69..423badd7cb5 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -7,46 +7,6 @@
 
 #ifdef CONFIG_TARGET_J7200_R5_EVM
 
-&bcfg_yaml {
-	config = "board-cfg_j7200.yaml";
-};
-
-&rcfg_yaml {
-	config = "rm-cfg_j7200.yaml";
-};
-
-&pcfg_yaml {
-	config = "pm-cfg_j7200.yaml";
-};
-
-&scfg_yaml {
-	config = "sec-cfg_j7200.yaml";
-};
-
-&bcfg_yaml_tifs {
-	config = "board-cfg_j7200.yaml";
-};
-
-&rcfg_yaml_tifs {
-	config = "rm-cfg_j7200.yaml";
-};
-
-&pcfg_yaml_tifs {
-	config = "pm-cfg_j7200.yaml";
-};
-
-&scfg_yaml_tifs {
-	config = "sec-cfg_j7200.yaml";
-};
-
-&rcfg_yaml_dm {
-	config = "rm-cfg_j7200.yaml";
-};
-
-&pcfg_yaml_dm {
-	config = "pm-cfg_j7200.yaml";
-};
-
 &binman {
 	tiboot3-j7200-hs-evm.bin {
 		filename = "tiboot3-j7200-hs-evm.bin";
diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a3ac490f677..789ca5c715a 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -22,6 +22,9 @@ config SOC_K3_AM654
 config SOC_K3_J721E
 	bool "TI's K3 based J721E SoC Family Support"
 
+config SOC_K3_J7200
+	bool "TI's K3 based J7200 SoC Family Support"
+
 config SOC_K3_J721S2
 	bool "TI's K3 based J721S2 SoC Family Support"
 
@@ -33,18 +36,13 @@ config SOC_K3_J784S4
 
 endchoice
 
-if SOC_K3_J721E
-config SOC_K3_J721E_J7200
-	bool "TI's K3 based J7200 SoC variant Family Support"
-endif
-
 config SYS_SOC
 	default "k3"
 
 config SYS_K3_NON_SECURE_MSRAM_SIZE
 	hex
 	default 0x80000 if SOC_K3_AM654
-	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
+	default 0x100000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x1c0000 if SOC_K3_AM642
 	default 0x3c000 if SOC_K3_AM625 || SOC_K3_AM62A7
 	help
@@ -56,7 +54,7 @@ config SYS_K3_NON_SECURE_MSRAM_SIZE
 config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
 	hex
 	default 0x58000 if SOC_K3_AM654
-	default 0xc0000 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
+	default 0xc0000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x180000 if SOC_K3_AM642
 	default 0x38000 if SOC_K3_AM625 || SOC_K3_AM62A7
 	help
@@ -66,21 +64,21 @@ config SYS_K3_MAX_DOWNLODABLE_IMAGE_SIZE
 config SYS_K3_MCU_SCRATCHPAD_BASE
 	hex
 	default 0x40280000 if SOC_K3_AM654
-	default 0x41cff9fc if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
+	default 0x41cff9fc if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J784S4
 	help
 	  Describes the base address of MCU Scratchpad RAM.
 
 config SYS_K3_MCU_SCRATCHPAD_SIZE
 	hex
 	default 0x200 if SOC_K3_AM654
-	default 0x200 if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
+	default 0x200 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J784S4
 	help
 	  Describes the size of MCU Scratchpad RAM.
 
 config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	hex
 	default 0x41c7fbfc if SOC_K3_AM654
-	default 0x41cffbfc if SOC_K3_J721E
+	default 0x41cffbfc if SOC_K3_J721E || SOC_K3_J7200
 	default 0x41cfdbfc if SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x701bebfc if SOC_K3_AM642
 	default 0x43c3f290 if SOC_K3_AM625
@@ -169,6 +167,7 @@ source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
 source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
+source "arch/arm/mach-k3/j7200/Kconfig"
 source "arch/arm/mach-k3/j721s2/Kconfig"
 source "arch/arm/mach-k3/j722s/Kconfig"
 source "arch/arm/mach-k3/j784s4/Kconfig"
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 5ce7fc62d80..b2fd5810b67 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM654) += am65x/
 obj-$(CONFIG_SOC_K3_J721E) += j721e/
+obj-$(CONFIG_SOC_K3_J7200) += j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_J722S) += j722s/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index b191d53a0f5..2e56b26673d 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -32,6 +32,10 @@
 #include "j721e_hardware.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_J7200
+#include "j721e_hardware.h"
+#endif
+
 #ifdef CONFIG_SOC_K3_J721S2
 #include "j721s2_hardware.h"
 #endif
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index ac1a34502ed..a47441ae6a5 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -14,6 +14,10 @@
 #include "j721e_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_J7200
+#include "j721e_spl.h"
+#endif
+
 #ifdef CONFIG_SOC_K3_J721S2
 #include "j721s2_spl.h"
 #endif
diff --git a/arch/arm/mach-k3/j7200/Kconfig b/arch/arm/mach-k3/j7200/Kconfig
new file mode 100644
index 00000000000..399daad8767
--- /dev/null
+++ b/arch/arm/mach-k3/j7200/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+if SOC_K3_J7200
+
+choice
+	prompt "K3 J7200 based boards"
+	optional
+
+config TARGET_J7200_A72_EVM
+	bool "TI K3 based J7200 EVM running on A72"
+	select ARM64
+	select BOARD_LATE_INIT
+	imply TI_I2C_BOARD_DETECT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J7200_R5_EVM
+	bool "TI K3 based J7200 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
+
+endchoice
+
+source "board/ti/j7200/Kconfig"
+
+endif
diff --git a/arch/arm/mach-k3/j7200/Makefile b/arch/arm/mach-k3/j7200/Makefile
new file mode 100644
index 00000000000..6d3ff36e363
--- /dev/null
+++ b/arch/arm/mach-k3/j7200/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#	Andrew Davis <afd@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += ../j721e/j721e_fdt.o
+obj-$(CONFIG_XPL_BUILD) += ../j721e/j721e_init.o
diff --git a/arch/arm/mach-k3/j721e/Kconfig b/arch/arm/mach-k3/j721e/Kconfig
index 0761b82b15a..4d01f2c8af2 100644
--- a/arch/arm/mach-k3/j721e/Kconfig
+++ b/arch/arm/mach-k3/j721e/Kconfig
@@ -29,27 +29,6 @@ config TARGET_J721E_R5_EVM
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
-config TARGET_J7200_A72_EVM
-	bool "TI K3 based J7200 EVM running on A72"
-	select ARM64
-	select SOC_K3_J721E_J7200
-	select BOARD_LATE_INIT
-	imply TI_I2C_BOARD_DETECT
-	select SYS_DISABLE_DCACHE_OPS
-	select BINMAN
-
-config TARGET_J7200_R5_EVM
-	bool "TI K3 based J7200 EVM running on R5"
-	select CPU_V7R
-	select SYS_THUMB_BUILD
-	select K3_LOAD_SYSFW
-	select RAM
-	select SPL_RAM
-	select K3_DDRSS
-	select BINMAN
-	imply SYS_K3_SPL_ATF
-	imply TI_I2C_BOARD_DETECT
-
 endchoice
 
 source "board/beagle/beagleboneai64/Kconfig"
diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index 7e2d2c16b45..f31c20f7ed6 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -48,7 +48,7 @@
 
 #ifdef CONFIG_K3_LOAD_SYSFW
 struct fwl_data cbass_hc_cfg0_fwls[] = {
-#if defined(CONFIG_TARGET_J721E_R5_EVM)
+#if defined(CONFIG_SOC_K3_J721E)
 	{ "PCIE0_CFG", 2560, 8 },
 	{ "PCIE1_CFG", 2561, 8 },
 	{ "USB3SS0_CORE", 2568, 4 },
@@ -57,11 +57,11 @@ struct fwl_data cbass_hc_cfg0_fwls[] = {
 	{ "UFS_HCI0_CFG", 2580, 4 },
 	{ "SERDES0", 2584, 1 },
 	{ "SERDES1", 2585, 1 },
-#elif defined(CONFIG_TARGET_J7200_R5_EVM)
+#elif defined(CONFIG_SOC_K3_J7200)
 	{ "PCIE1_CFG", 2561, 7 },
 #endif
 }, cbass_hc0_fwls[] = {
-#if defined(CONFIG_TARGET_J721E_R5_EVM)
+#if defined(CONFIG_SOC_K3_J721E)
 	{ "PCIE0_HP", 2528, 24 },
 	{ "PCIE0_LP", 2529, 24 },
 	{ "PCIE1_HP", 2530, 24 },
diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index f533c5e7743..074e3b61a26 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_J721E) += j721e/
-obj-$(CONFIG_SOC_K3_J721E) += j7200/
+obj-$(CONFIG_SOC_K3_J7200) += j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_J722S) += j722s/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
diff --git a/board/ti/j7200/Kconfig b/board/ti/j7200/Kconfig
new file mode 100644
index 00000000000..093d23e7bf8
--- /dev/null
+++ b/board/ti/j7200/Kconfig
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
+#	Lokesh Vutla <lokeshvutla@ti.com>
+
+if TARGET_J7200_A72_EVM
+
+config SYS_BOARD
+       default "j7200"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j721e_evm"
+
+config ENV_SOURCE_FILE
+       default "j7200"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_J7200_R5_EVM
+
+config SYS_BOARD
+       default "j7200"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j721e_evm"
+
+config ENV_SOURCE_FILE
+       default "j7200"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/j7200/MAINTAINERS b/board/ti/j7200/MAINTAINERS
new file mode 100644
index 00000000000..626141367a5
--- /dev/null
+++ b/board/ti/j7200/MAINTAINERS
@@ -0,0 +1,7 @@
+J7200 BOARD
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/j7200
+F:	include/configs/j7200_evm.h
+F:	configs/j7200_evm_r5_defconfig
+F:	configs/j7200_evm_a72_defconfig
diff --git a/board/ti/j7200/Makefile b/board/ti/j7200/Makefile
new file mode 100644
index 00000000000..4ae69aaea7b
--- /dev/null
+++ b/board/ti/j7200/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y += ../j721e/evm.o
diff --git a/board/ti/j721e/board-cfg_j7200.yaml b/board/ti/j7200/board-cfg.yaml
similarity index 100%
rename from board/ti/j721e/board-cfg_j7200.yaml
rename to board/ti/j7200/board-cfg.yaml
diff --git a/board/ti/j721e/j721e.env b/board/ti/j7200/j7200.env
similarity index 52%
copy from board/ti/j721e/j721e.env
copy to board/ti/j7200/j7200.env
index 38bfd7d4963..6cc92bf0d8d 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j7200/j7200.env
@@ -13,10 +13,7 @@ args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
-#if CONFIG_TARGET_J721E_R5_EVM
-addr_mcur5f0_0load=0x89000000
-name_mcur5f0_0fw=/lib/firmware/j7-mcu-r5f0_0-fw
-#elif CONFIG_TARGET_J7200_R5_EVM
+#if CONFIG_TARGET_J7200_R5_EVM
 addr_mcur5f0_0load=0x89000000
 name_mcur5f0_0fw=/lib/firmware/j7200-mcu-r5f0_0-fw
 #endif
@@ -36,20 +33,6 @@ main_cpsw0_qsgmii_phyinit=
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -eq 1 && test ${boot} = mmc; then
 		run init_main_cpsw0_qsgmii_phy;
 	fi;
-#elif CONFIG_TARGET_J721E_A72_EVM
-init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
-	gpio clear gpio@22_16
-main_cpsw0_qsgmii_phyinit=
-	if test $board_name = J721EX-PM1-SOM || test $board_name = J721EX-PM2-SOM || test $board_name = j721e; then
-		do_main_cpsw0_qsgmii_phyinit=1; else
-		do_main_cpsw0_qsgmii_phyinit=0; fi;
-	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -eq 1 && test ${boot} = mmc; then
-		run init_main_cpsw0_qsgmii_phy;			\
-	fi;
-#endif
-
-#if CONFIG_TARGET_J721E_A72_EVM
-rproc_fw_binaries=2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
 #endif
 
 #if CONFIG_TARGET_J7200_A72_EVM
diff --git a/board/ti/j721e/pm-cfg_j7200.yaml b/board/ti/j7200/pm-cfg.yaml
similarity index 100%
rename from board/ti/j721e/pm-cfg_j7200.yaml
rename to board/ti/j7200/pm-cfg.yaml
diff --git a/board/ti/j721e/rm-cfg_j7200.yaml b/board/ti/j7200/rm-cfg.yaml
similarity index 100%
rename from board/ti/j721e/rm-cfg_j7200.yaml
rename to board/ti/j7200/rm-cfg.yaml
diff --git a/board/ti/j721e/sec-cfg_j7200.yaml b/board/ti/j7200/sec-cfg.yaml
similarity index 100%
rename from board/ti/j721e/sec-cfg_j7200.yaml
rename to board/ti/j7200/sec-cfg.yaml
diff --git a/board/ti/j721e/Kconfig b/board/ti/j721e/Kconfig
index 6990f6ef4a4..7c7e23988d8 100644
--- a/board/ti/j721e/Kconfig
+++ b/board/ti/j721e/Kconfig
@@ -38,39 +38,3 @@ config ENV_SOURCE_FILE
 source "board/ti/common/Kconfig"
 
 endif
-
-if TARGET_J7200_A72_EVM
-
-config SYS_BOARD
-       default "j721e"
-
-config SYS_VENDOR
-       default "ti"
-
-config SYS_CONFIG_NAME
-       default "j721e_evm"
-
-config ENV_SOURCE_FILE
-       default "j721e"
-
-source "board/ti/common/Kconfig"
-
-endif
-
-if TARGET_J7200_R5_EVM
-
-config SYS_BOARD
-       default "j721e"
-
-config SYS_VENDOR
-       default "ti"
-
-config SYS_CONFIG_NAME
-       default "j721e_evm"
-
-config ENV_SOURCE_FILE
-       default "j721e"
-
-source "board/ti/common/Kconfig"
-
-endif
diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
index 06aba53d9b0..19199dbeadd 100644
--- a/board/ti/j721e/MAINTAINERS
+++ b/board/ti/j721e/MAINTAINERS
@@ -7,5 +7,3 @@ F:	configs/j721e_evm_r5_defconfig
 F:	configs/j721e_evm_a72_defconfig
 F:	configs/j721e_sk_r5_defconfig
 F:	configs/j721e_sk_a72_defconfig
-F:	configs/j7200_evm_r5_defconfig
-F:	configs/j7200_evm_a72_defconfig
diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index 38bfd7d4963..e5b4225b3ce 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -16,9 +16,6 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 #if CONFIG_TARGET_J721E_R5_EVM
 addr_mcur5f0_0load=0x89000000
 name_mcur5f0_0fw=/lib/firmware/j7-mcu-r5f0_0-fw
-#elif CONFIG_TARGET_J7200_R5_EVM
-addr_mcur5f0_0load=0x89000000
-name_mcur5f0_0fw=/lib/firmware/j7200-mcu-r5f0_0-fw
 #endif
 
 boot_targets=mmc1 mmc0 usb pxe dhcp
@@ -28,15 +25,7 @@ bootpart=1:2
 bootdir=/boot
 rd_spec=-
 
-#if CONFIG_TARGET_J7200_A72_EVM
-do_main_cpsw0_qsgmii_phyinit=1
-init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
-	gpio clear gpio@22_16
-main_cpsw0_qsgmii_phyinit=
-	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -eq 1 && test ${boot} = mmc; then
-		run init_main_cpsw0_qsgmii_phy;
-	fi;
-#elif CONFIG_TARGET_J721E_A72_EVM
+#if CONFIG_TARGET_J721E_A72_EVM
 init_main_cpsw0_qsgmii_phy=gpio set gpio@22_17;
 	gpio clear gpio@22_16
 main_cpsw0_qsgmii_phyinit=
@@ -51,7 +40,3 @@ main_cpsw0_qsgmii_phyinit=
 #if CONFIG_TARGET_J721E_A72_EVM
 rproc_fw_binaries=2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
 #endif
-
-#if CONFIG_TARGET_J7200_A72_EVM
-rproc_fw_binaries=2 /lib/firmware/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
-#endif
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index ac5b10ba149..71066b53a04 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -6,7 +6,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SOC_K3_J721E=y
+CONFIG_SOC_K3_J7200=y
 CONFIG_TARGET_J7200_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 265ae2e8e07..e05d1bcbb26 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SOC_K3_J721E=y
+CONFIG_SOC_K3_J7200=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J7200_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index bf65f573cb8..f699945cac3 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -82,6 +82,8 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
 		.family = "J721E",
 		.data = &j721e_clk_platdata,
 	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_J7200)
 	{
 		.family = "J7200",
 		.data = &j7200_clk_platdata,
diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 94ec13ba7ca..90c20a6a3fa 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_TI_K3_PSIL) += k3-psil-data.o
 k3-psil-data-y += k3-psil.o
 k3-psil-data-$(CONFIG_SOC_K3_AM654) += k3-psil-am654.o
 k3-psil-data-$(CONFIG_SOC_K3_J721E) += k3-psil-j721e.o
+k3-psil-data-$(CONFIG_SOC_K3_J7200) += k3-psil-j721e.o
 k3-psil-data-$(CONFIG_SOC_K3_J721S2) += k3-psil-j721s2.o
 k3-psil-data-$(CONFIG_SOC_K3_AM642) += k3-psil-am64.o
 k3-psil-data-$(CONFIG_SOC_K3_AM625) += k3-psil-am62.o
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 369e679886f..39798844a8a 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -20,6 +20,8 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 			soc_ep_map = &am654_ep_map;
 		else if (IS_ENABLED(CONFIG_SOC_K3_J721E))
 			soc_ep_map = &j721e_ep_map;
+		else if (IS_ENABLED(CONFIG_SOC_K3_J7200))
+			soc_ep_map = &j721e_ep_map;
 		else if (IS_ENABLED(CONFIG_SOC_K3_J721S2))
 			soc_ep_map = &j721s2_ep_map;
 		else if (IS_ENABLED(CONFIG_SOC_K3_AM642))
diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 3370f80231d..2e61e0c7de1 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -16,7 +16,7 @@ struct ti_sci_resource_static_data {
 
 #if IS_ENABLED(CONFIG_K3_DM_FW)
 
-#if IS_ENABLED(CONFIG_SOC_K3_J721E)
+#if IS_ENABLED(CONFIG_SOC_K3_J721E) || IS_ENABLED(CONFIG_SOC_K3_J7200)
 static struct ti_sci_resource_static_data rm_static_data[] = {
 	/* Free rings */
 	{
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index 5e7a4c5648d..1eaddbf8247 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -94,6 +94,8 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.family = "J721E",
 		.data = &j721e_pd_platdata,
 	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_J7200)
 	{
 		.family = "J7200",
 		.data = &j7200_pd_platdata,
diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 899d7585489..2a40b0c9f81 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -71,7 +71,7 @@ choice
 	depends on K3_DDRSS
 	prompt "K3 DDRSS Arch Support"
 
-	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
+	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J784S4
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
 	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S
-- 
2.39.2

