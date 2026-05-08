Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615F4CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BBE84C9C;
	Fri,  8 May 2026 13:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gYowbBc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B60684C19; Fri,  8 May 2026 13:53:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6088284C7B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=OXB+RACmZC0n3isQcoYPZ3122PJMa0/UjRVj9jaWu3w=; b=gYowbBc8bsI4OAAnyfEBrcAtFg
 8EqLCw5er23soe/sUb2E2riOeHSlGkbHfnHA4vgWdVwVOeBMUBz4GZ/oelgxREtDT2Zx7EUNjsT03
 VDaws1tORBf5lo4qli6dvntH7NN2zRuYtoZFogw3xqoJQTCjF+dd7IXW5ygtEMD3ctnpRb24yxz1A
 NoeWkKLHl+rBTH3MClZZ/srgOJQDpUfkVc/F/HtwKMhdVWIonjz16WFL//O3TfbDPKA5cWhHeD5xT
 mDBSPfHMOt4rmsBq7SlULf8wjr5gPhj4MxQLwt+Hsf/zzA6yH7lO+3Pay+lEQ9IOWH8DxF/pZqhaT
 22AjLOdQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJln-000DVs-2l; Fri, 08 May 2026 13:53:27 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJln-000PER-14; Fri, 08 May 2026 13:53:27 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 4/5] board: tq: add TQMa6UL[L]x[L] SOM and MBa6ULx baseboard
Date: Fri,  8 May 2026 13:53:09 +0200
Message-ID: <20260508115315.252623-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Nora Schiffer <nora.schiffer@ew.tq-group.com>

Add Support for TQMa6UL SoM (imx6UL) Variants and MBa6ULx mainboard.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/mach-imx/mx6/Kconfig      |  21 +++
 board/tq/MAINTAINERS               |   2 +-
 board/tq/tqma6ul/Kconfig           | 114 ++++++++++++++++
 board/tq/tqma6ul/Makefile          |  16 +++
 board/tq/tqma6ul/spl.c             | 128 ++++++++++++++++++
 board/tq/tqma6ul/spl_mba6ul.c      | 177 ++++++++++++++++++++++++
 board/tq/tqma6ul/spl_tqma6ul_ram.c | 208 +++++++++++++++++++++++++++++
 board/tq/tqma6ul/tqma6ul.c         | 184 +++++++++++++++++++++++++
 board/tq/tqma6ul/tqma6ul.cfg       |  23 ++++
 board/tq/tqma6ul/tqma6ul.env       |  47 +++++++
 board/tq/tqma6ul/tqma6ul.h         |  25 ++++
 board/tq/tqma6ul/tqma6ul_mba6ul.c  | 138 +++++++++++++++++++
 doc/board/tq/index.rst             |   1 +
 doc/board/tq/tqma6ul.rst           | 105 +++++++++++++++
 include/configs/tqma6ul.h          |  46 +++++++
 include/configs/tqma6ul_mba6ul.h   |  19 +++
 16 files changed, 1253 insertions(+), 1 deletion(-)
 create mode 100644 board/tq/tqma6ul/Kconfig
 create mode 100644 board/tq/tqma6ul/Makefile
 create mode 100644 board/tq/tqma6ul/spl.c
 create mode 100644 board/tq/tqma6ul/spl_mba6ul.c
 create mode 100644 board/tq/tqma6ul/spl_tqma6ul_ram.c
 create mode 100644 board/tq/tqma6ul/tqma6ul.c
 create mode 100644 board/tq/tqma6ul/tqma6ul.cfg
 create mode 100644 board/tq/tqma6ul/tqma6ul.env
 create mode 100644 board/tq/tqma6ul/tqma6ul.h
 create mode 100644 board/tq/tqma6ul/tqma6ul_mba6ul.c
 create mode 100644 doc/board/tq/tqma6ul.rst
 create mode 100644 include/configs/tqma6ul.h
 create mode 100644 include/configs/tqma6ul_mba6ul.h

diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index d198d9932f4..7ed4b24b751 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -633,6 +633,26 @@ config TARGET_TQMA6
 	imply CMD_SF
 	imply CMD_DM
 
+config TARGET_TQMA6UL
+	bool "TQ-Systems TQMa6UL[L]x"
+	depends on MX6UL || MX6ULL
+	select TQ_COMMON_SOM
+	select BOARD_EARLY_INIT_F
+	select BOARD_LATE_INIT
+	select OF_SYSTEM_SETUP
+	select DM
+	select DM_I2C
+	select SUPPORT_SPL
+	select SPL_SEPARATE_BSS if SPL
+	imply DM_GPIO
+	imply DM_MMC
+	imply DM_SPI if SPI
+	imply DM_SPI_FLASH if SPI
+	imply SPI
+	help
+	  TQMa6UL[L]x is a TQ SoM with i.MX6UL/i.MX6ULL CPU
+	  The SoM can be used on various baseboards.
+
 config TARGET_UDOO
 	bool "udoo"
 	depends on MX6QDL
@@ -739,6 +759,7 @@ source "board/technexion/pico-imx6/Kconfig"
 source "board/technexion/pico-imx6ul/Kconfig"
 source "board/tbs/tbs2910/Kconfig"
 source "board/tq/tqma6/Kconfig"
+source "board/tq/tqma6ul/Kconfig"
 source "board/toradex/apalis_imx6/Kconfig"
 source "board/toradex/colibri_imx6/Kconfig"
 source "board/toradex/colibri-imx6ull/Kconfig"
diff --git a/board/tq/MAINTAINERS b/board/tq/MAINTAINERS
index b31c5793432..a04a36ba415 100644
--- a/board/tq/MAINTAINERS
+++ b/board/tq/MAINTAINERS
@@ -1,4 +1,4 @@
-TQMA6
+TQMA6 / TQMA6UL / TQMA6ULxL / TQMA6ULL / TQMA6ULLxL
 M:	Max Merchel <max.merchel@ew.tq-group.com>
 L:	u-boot@ew.tq-group.com
 S:	Maintained
diff --git a/board/tq/tqma6ul/Kconfig b/board/tq/tqma6ul/Kconfig
new file mode 100644
index 00000000000..5d85c68b359
--- /dev/null
+++ b/board/tq/tqma6ul/Kconfig
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Marco Felsch, Markus Niebel, Max Merchel
+#
+
+if TARGET_TQMA6UL
+
+config SYS_BOARD
+	default "tqma6ul"
+
+config SYS_VENDOR
+	default "tq"
+
+config SYS_CONFIG_NAME
+	default "tqma6ul_mba6ul" if MBA6UL
+
+choice
+	prompt "TQMa6UL module variant"
+	default TQMA6UL_VARIANT_STANDARD
+	help
+	  Select the variant of the TQMa6UL SoM module being used.
+	  By default, the variant with board-to-board connectors is used.
+
+config TQMA6UL_VARIANT_STANDARD
+	bool "standard module with board connector"
+	help
+	  Select for SoM variant connector
+	  with board to board connectors
+
+config TQMA6UL_VARIANT_LGA
+	bool "LGA module with solder balls"
+	help
+	  Select for SoM variant LGA
+	  with solder balls
+
+endchoice
+
+config TQMA6UL_RAM_256M
+	bool
+
+config TQMA6UL_RAM_512M
+	bool
+
+choice
+	prompt "TQMa6UL RAM configuration"
+	default TQMA6UL_RAM_MULTI
+	help
+	  Select RAM configuration. Normally use default here but for
+	  specific setup it is possible to use a single RAM size.
+
+config TQMA6UL_RAM_MULTI
+	bool "TQMa6ULx with 256/512 MB RAM - Single image"
+	select TQMA6UL_RAM_256M
+	select TQMA6UL_RAM_512M
+	help
+	  Build a single U-Boot solely for variants
+	  with 256/512 MB RAM.
+
+config TQMA6UL_RAM_SINGLE_256M
+	bool "TQMa6UL with 256 MB RAM"
+	select TQMA6UL_RAM_256M
+	help
+	  Build U-Boot solely for variants
+	  with 256 MB RAM.
+
+config TQMA6UL_RAM_SINGLE_512M
+	bool "TQMa6UL with 512 MB RAM"
+	select TQMA6UL_RAM_512M
+	help
+	  Build U-Boot solely for variants
+	  with 512 MB RAM.
+
+endchoice
+
+choice
+	prompt "TQMa6UL base board variant"
+	default MBA6UL
+	help
+	  Select the baseboard variant for the TQMa6UL module.
+	  By default the MBA6UL starterkit is used.
+
+config MBA6UL
+	bool "TQMa6UL on MBa6ULx Starterkit"
+	select TQ_COMMON_BB
+	select TQ_COMMON_SDMMC
+	select SYSINFO
+	select SYSINFO_TQ_EEPROM
+	select I2C_EEPROM
+	select MISC
+	select MXC_UART
+	imply DM_ETH
+	imply DM_GPIO
+	imply DM_MMC
+	imply DM_SERIAL
+	imply DM_SPI
+	imply OF_UPSTREAM
+	imply PHYLIB
+	imply PHY_SMSC
+	imply USB
+	imply USB_STORAGE
+	help
+	  Select the MBa6ULx starterkit.
+	  This is the default base board.
+
+endchoice
+
+config IMX_CONFIG
+	default "board/tq/tqma6ul/tqma6ul.cfg"
+
+source "board/tq/common/Kconfig"
+
+endif
diff --git a/board/tq/tqma6ul/Makefile b/board/tq/tqma6ul/Makefile
new file mode 100644
index 00000000000..f45ed4a15f6
--- /dev/null
+++ b/board/tq/tqma6ul/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2021-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Markus Niebel, Matthias Schiffer, Max Merchel
+#
+
+obj-y  := tqma6ul.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+obj-y += spl_tqma6ul_ram.o
+obj-$(CONFIG_MBA6UL) += spl_mba6ul.o
+else
+obj-$(CONFIG_MBA6UL) += tqma6ul_mba6ul.o
+endif
diff --git a/board/tq/tqma6ul/spl.c b/board/tq/tqma6ul/spl.c
new file mode 100644
index 00000000000..71c5134c4f6
--- /dev/null
+++ b/board/tq/tqma6ul/spl.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include <fsl_esdhc_imx.h>
+#include <hang.h>
+#include <init.h>
+#include <mmc.h>
+#include <spl.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/mx6ul_pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm-generic/sections.h>
+#include <linux/sizes.h>
+
+#include "../common/tq_bb.h"
+#include "../common/tq_som.h"
+
+static void ccgr_init(void)
+{
+	struct mxc_ccm_reg *ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+
+	writel(0xFFFFFFFF, &ccm->CCGR0);
+	writel(0xFFFFFFFF, &ccm->CCGR1);
+	writel(0xFFFFFFFF, &ccm->CCGR2);
+	writel(0xFFFFFFFF, &ccm->CCGR3);
+	writel(0xFFFFFFFF, &ccm->CCGR4);
+	writel(0xFFFFFFFF, &ccm->CCGR5);
+	writel(0xFFFFFFFF, &ccm->CCGR6);
+}
+
+#define USDHC_CLK_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define USDHC_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE |		\
+	PAD_CTL_PUS_22K_UP  | PAD_CTL_SPEED_LOW |		\
+	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+/* eMMC on USDHC2 */
+static const iomux_v3_cfg_t tqma6ul_usdhc2_pads[] = {
+	MX6_PAD_NAND_DATA00__USDHC2_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA01__USDHC2_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA02__USDHC2_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA03__USDHC2_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA04__USDHC2_DATA4 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA05__USDHC2_DATA5 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA06__USDHC2_DATA6 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_DATA07__USDHC2_DATA7 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_ALE__USDHC2_RESET_B | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_RE_B__USDHC2_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_NAND_WE_B__USDHC2_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+};
+
+static struct fsl_esdhc_cfg tqma6ul_usdhc2_cfg = {
+	.esdhc_base = USDHC2_BASE_ADDR,
+	.max_bus_width = 8,
+};
+
+int board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC2_BASE_ADDR)
+		/* eMMC/uSDHC2 is always present */
+		ret = 1;
+	else
+		ret = tq_bb_board_mmc_getcd(mmc);
+
+	return ret;
+}
+
+int board_mmc_getwp(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC2_BASE_ADDR)
+		/* eMMC/uSDHC2 is never WP */
+		ret = 0;
+	else
+		ret = tq_bb_board_mmc_getwp(mmc);
+
+	return ret;
+}
+
+int board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(tqma6ul_usdhc2_pads,
+					 ARRAY_SIZE(tqma6ul_usdhc2_pads));
+	tqma6ul_usdhc2_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC2_CLK);
+
+	if (fsl_esdhc_initialize(bis, &tqma6ul_usdhc2_cfg))
+		printf("Warning: failed to initialize eMMC dev\n");
+
+	tq_bb_board_mmc_init(bis);
+
+	return 0;
+}
+
+void board_init_f(ulong dummy)
+{
+	/* setup clock gating */
+	ccgr_init();
+
+	/* setup AIPS and disable watchdog */
+	arch_cpu_init();
+
+	/* setup AXI */
+	gpr_init();
+
+	/* iomux and setup of i2c */
+	board_early_init_f();
+
+	/* Setup GP timer */
+	timer_init();
+
+	/* UART clocks enabled and gd valid - init serial console */
+	preloader_console_init();
+
+	/* DDR initialization */
+	tq_som_ram_init();
+}
diff --git a/board/tq/tqma6ul/spl_mba6ul.c b/board/tq/tqma6ul/spl_mba6ul.c
new file mode 100644
index 00000000000..c6560e2e8b4
--- /dev/null
+++ b/board/tq/tqma6ul/spl_mba6ul.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include <fsl_esdhc_imx.h>
+#include <malloc.h>
+#include <spl.h>
+#include <spl_gpio.h>
+#include <asm/gpio.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/mx6ul_pins.h>
+#include <asm/mach-imx/sys_proto.h>
+
+#include "../common/tq_bb.h"
+#include "tqma6ul.h"
+
+#define GPIO_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
+		       PAD_CTL_DSE_40ohm | PAD_CTL_HYS)
+
+#define USDHC_CLK_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
+			    PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | \
+			    PAD_CTL_HYS)
+
+#define USDHC_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE | \
+			PAD_CTL_PUS_22K_UP  | PAD_CTL_SPEED_LOW | \
+			PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define UART_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE | \
+		       PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
+		       PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
+
+static const iomux_v3_cfg_t mba6ul_uart_pads[] = {
+	NEW_PAD_CTRL(MX6_PAD_UART1_TX_DATA__UART1_DCE_TX, UART_PAD_CTRL),
+	NEW_PAD_CTRL(MX6_PAD_UART1_RX_DATA__UART1_DCE_RX, UART_PAD_CTRL),
+};
+
+static void mba6ul_setup_iomuxc_uart(void)
+{
+	imx_iomux_v3_setup_multiple_pads(mba6ul_uart_pads,
+					 ARRAY_SIZE(mba6ul_uart_pads));
+}
+
+/* SD card on USDHC1 */
+static const iomux_v3_cfg_t mba6ul_usdhc1_pads[] = {
+	MX6_PAD_SD1_CLK__USDHC1_CLK |	MUX_PAD_CTRL(USDHC_CLK_PAD_CTRL),
+	MX6_PAD_SD1_CMD__USDHC1_CMD |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD1_DATA0__USDHC1_DATA0 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD1_DATA1__USDHC1_DATA1 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD1_DATA2__USDHC1_DATA2 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD1_DATA3__USDHC1_DATA3 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	/* WP */
+	MX6_PAD_UART1_CTS_B__GPIO1_IO18 |	MUX_PAD_CTRL(GPIO_PAD_CTRL),
+	/* CD */
+	MX6_PAD_UART1_RTS_B__GPIO1_IO19 |	MUX_PAD_CTRL(GPIO_PAD_CTRL),
+};
+
+#define USDHC1_CD_GPIO	IMX_GPIO_NR(1, 19)
+#define USDHC1_WP_GPIO	IMX_GPIO_NR(1, 18)
+
+static struct fsl_esdhc_cfg mba6ul_usdhc1_cfg = {
+	.esdhc_base = USDHC1_BASE_ADDR,
+	.max_bus_width = 4,
+};
+
+int tq_bb_board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC1_BASE_ADDR)
+		ret = !gpio_get_value(USDHC1_CD_GPIO);
+
+	return ret;
+}
+
+int tq_bb_board_mmc_getwp(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC1_BASE_ADDR)
+		ret = gpio_get_value(USDHC1_WP_GPIO);
+
+	return ret;
+}
+
+int tq_bb_board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(mba6ul_usdhc1_pads,
+					 ARRAY_SIZE(mba6ul_usdhc1_pads));
+	gpio_request(USDHC1_CD_GPIO, "usdhc1-cd");
+	gpio_request(USDHC1_WP_GPIO, "usdhc1-wp");
+	gpio_direction_input(USDHC1_CD_GPIO);
+	gpio_direction_input(USDHC1_WP_GPIO);
+
+	mba6ul_usdhc1_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK);
+	if (fsl_esdhc_initialize(bis, &mba6ul_usdhc1_cfg))
+		puts("Warning: failed to initialize SD card\n");
+
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	tq_bb_board_early_init_f();
+
+	mba6ul_setup_iomuxc_uart();
+
+	return 0;
+}
+
+/*
+ * This is done per baseboard to allow different implementations
+ */
+void board_boot_order(u32 *spl_boot_list)
+{
+	u32 bmode = imx6_src_get_boot_mode();
+	u8 imx6_bmode = (bmode & IMX6_BMODE_MASK) >> IMX6_BMODE_SHIFT;
+
+	/* USB boot */
+	if (spl_boot_device() == BOOT_DEVICE_BOARD) {
+		printf("USB\n");
+		spl_boot_list[0] = BOOT_DEVICE_BOARD;
+		return;
+	}
+
+	switch (imx6_bmode) {
+	case IMX6_BMODE_SD:
+	case IMX6_BMODE_ESD:
+		/* SD/eSD - BOOT_DEVICE_MMC2 */
+		printf("SD\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC2;
+		break;
+	case IMX6_BMODE_MMC:
+	case IMX6_BMODE_EMMC:
+		/* MMC/eMMC - BOOT_DEVICE_MMC1 */
+		printf("eMMC\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+		break;
+	case IMX6_BMODE_QSPI:
+		/* QSPI - BOOT_DEVICE_SPI */
+		printf("QSPI\n");
+		spl_boot_list[0] = BOOT_DEVICE_NOR;
+		break;
+	case IMX6_BMODE_SERIAL_ROM:
+		/* SERIAL_ROM - BOOT_DEVICE_BOARD */
+		printf("Serial ROM\n");
+		spl_boot_list[0] = BOOT_DEVICE_BOARD;
+		break;
+	default:
+		printf("Wrong board boot order\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+		break;
+	}
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	/* Longest FDT name */
+	char dt[] = "imx6ull-tqma6ull2l-mba6ulx";
+	enum tqma6ul_som_type somtype;
+
+	somtype = set_tqma6ul_dt_name(dt, sizeof(dt), "mba6ulx");
+	if (somtype == tqma6ul_som_type_unknown)
+		return -1;
+
+	if (!strcmp(name, dt)) {
+		printf("Device tree: %s\n", name);
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/board/tq/tqma6ul/spl_tqma6ul_ram.c b/board/tq/tqma6ul/spl_tqma6ul_ram.c
new file mode 100644
index 00000000000..40284dd79a2
--- /dev/null
+++ b/board/tq/tqma6ul/spl_tqma6ul_ram.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/iomux.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/mx6ul-ddr.h>
+#include <asm/arch/sys_proto.h>
+
+#include "../common/tq_som.h"
+
+static void tqma6ul_init_ddr_controller(u32 size)
+{
+	/* TQMa6ul DDR config */
+
+	/* reset DDR via Chip Select 0*/
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x03180000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x83180000);
+
+	debug("SPL: tqma6ul ddr iomux ....\n");
+
+	/* DDR IO TYPE: */
+	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRPKE, 0x00000000);
+	/* CLOCK: */
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_0, 0x00000030);
+	/* Control: */
+	tq_som_init_write_reg(MX6_IOM_DRAM_CAS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RAS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_ADDDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RESET, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDBA2, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_CTLDS, 0x00000030);
+	/* Data Strobes: */
+	tq_som_init_write_reg(MX6_IOM_DDRMODE_CTL, 0x00020000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS1, 0x00000030);
+	/* Data: */
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRMODE, 0x00020000);
+	tq_som_init_write_reg(MX6_IOM_GRP_B0DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B1DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM1, 0x00000030);
+
+	debug("tqma6ul ddr controller registers ....\n");
+
+	/* MMDC_MDSCR - MMDC Core Special Command Register */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+	debug("tqma6ul ddr calibrations ....\n");
+
+	/* DDR_PHY_P0_MPZQHWCTRL , enable both one-time & periodic HW ZQ calibration. */
+	tq_som_init_write_reg(MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003);
+
+	switch (size) {
+	case SZ_512M:
+		if (IS_ENABLED(CONFIG_MX6UL)) {
+			debug("tqma6ul ddr calibration standard variant ....\n");
+
+			tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00000000);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x41580150);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x40404E52);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x40404E4A);
+
+		} else if (IS_ENABLED(CONFIG_MX6ULL)) {
+			if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD)) {
+				debug("tqma6ull ddr calibration standard variant ....\n");
+
+				tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00090009);
+				tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x4140013C);
+				tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x40403A3E);
+				tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x40402E26);
+
+			} else if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_LGA)) {
+				debug("tqma6ull ddr calibration lga variant ....\n");
+
+				tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00050009);
+				tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x41340130);
+				tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x40403A3E);
+				tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x40402E28);
+
+			} else {
+				pr_err("invalid/unsupported SoM variant ....\n");
+				hang();
+			} /* IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD) */
+		} else {
+			pr_err("ERROR: invalid/unsupported CPU variant ....\n");
+			hang();
+		} /* IS_ENABLED(CONFIG_MX6UL) */
+		break;
+	case SZ_256M:
+		if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD)) {
+			debug("tqma6ul ddr calibration standard variant ....\n");
+
+			tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00000000);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x41480144);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x40404E54);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x40404E48);
+
+		} else if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_LGA)) {
+			debug("tqma6ul ddr calibration lga variant ....\n");
+
+			tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00130003);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x41540154);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x40405050);
+			tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x40404E4C);
+
+		} else {
+			pr_err("ERROR: invalid/unsupported SoM variant ....\n");
+			hang();
+		} /* IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD) */
+		break;
+	default:
+		pr_err("ERROR: invalid/unsupported RAM size ....\n");
+		hang();
+		break;
+	}
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333);
+
+	tq_som_init_write_reg(0x021B082C, 0xf3333333); /* MMDC_MPWRDQBY0DL */
+	tq_som_init_write_reg(0x021B0830, 0xf3333333); /* MMDC_MPWRDQBY1DL */
+	tq_som_init_write_reg(0x021B08C0, 0x00921012); /* MMDC_MPDCCR */
+
+	/*
+	 * Complete calibration by forced measurement:
+	 */
+	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002002D);
+
+	debug("tqma6ul ddr mmdc ....\n");
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x00333030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x676B52F3);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xB66D8B63);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00201740);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x006B1023);
+
+	switch (size) {
+	case SZ_512M:
+		tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x0000004F);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x84180000);
+		break;
+	case SZ_256M:
+		tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000047);
+		tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x83180000);
+		break;
+	default:
+		hang();
+		break;
+	}
+
+	debug("tqma6ul ddr cs0 ....\n");
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x02008032);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00048031);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x15208030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x04008040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDREF, 0x00000800);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPODTCTRL, 0x00000227);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002552D);
+	tq_som_init_write_reg(MX6_MMDC_P0_MAPSR, 0x00011006);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00000000);
+}
+
+void tq_som_ram_init(void)
+{
+	int i;
+	/* RAM sizes need to be in descending order */
+	static const u32 ram_sizes[] = {
+#if IS_ENABLED(CONFIG_TQMA6UL_RAM_512M)
+		SZ_512M,
+#endif
+#if IS_ENABLED(CONFIG_TQMA6UL_RAM_256M)
+		SZ_256M,
+#endif
+	};
+
+	if (!is_mx6ul() && !is_mx6ull()) {
+		pr_err("ERROR: Not running on TQMa6UL[L]\n");
+		hang();
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ram_sizes); i++) {
+		tqma6ul_init_ddr_controller(ram_sizes[i]);
+		if (tq_som_ram_check_size(ram_sizes[i]))
+			break;
+	}
+
+	if (i < ARRAY_SIZE(ram_sizes)) {
+		debug("tqma6ul ddr init done ...\n");
+	} else  {
+		pr_err("ERROR: Invalid DDR RAM size detected\n");
+		hang();
+	}
+}
diff --git a/board/tq/tqma6ul/tqma6ul.c b/board/tq/tqma6ul/tqma6ul.c
new file mode 100644
index 00000000000..999396f573d
--- /dev/null
+++ b/board/tq/tqma6ul/tqma6ul.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Marco Felsch, Nora Schiffer
+ *
+ */
+
+#include <env.h>
+#include <fdt_support.h>
+#include <mmc.h>
+#include <mtd_node.h>
+#include <spi_flash.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+
+#include "../common/tq_bb.h"
+#include "tqma6ul.h"
+
+int tq_bb_board_early_init_f(void)
+{
+	if (CONFIG_IS_ENABLED(FSL_QSPI))
+		enable_qspi_clk(0);
+
+	return 0;
+}
+
+/**
+ * Checks if CPU (imx6ul or ima6ull) matches the one set for the image.
+ */
+static const char *check_cpu_variant(void)
+{
+	const char *cpu;
+
+	if (is_mx6ul()) {
+		cpu = "ul";
+		if (!IS_ENABLED(CONFIG_MX6UL))
+			printf("*** ERROR: image not compiled for i.MX6UL!\n");
+	} else if (is_mx6ull()) {
+		cpu = "ull";
+		if (!IS_ENABLED(CONFIG_MX6ULL))
+			printf("*** ERROR: image not compiled for i.MX6ULL!\n");
+	} else {
+		printf("unknown CPU\n");
+		return NULL;
+	}
+
+	return cpu;
+}
+
+/**
+ * Checks configuration for TQMa6UL SoM module variant.
+ */
+enum tqma6ul_som_type check_tqma6ul_variant(void)
+{
+	if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD))
+		return tqma6ul_som_type_ca;
+
+	if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_LGA))
+		return tqma6ul_som_type_lga;
+
+	printf("unknown SoM variant\n");
+
+	return tqma6ul_som_type_unknown;
+}
+
+/**
+ * Adjusts device tree name based on CPU variant.
+ */
+enum tqma6ul_som_type set_tqma6ul_dt_name(char *dt, size_t dtsize, const char *mb)
+{
+	const char *tqma6ul_cpu, *tqma6ul_variant;
+	enum tqma6ul_som_type somtype;
+	u8 mx6ul_variant;
+
+	tqma6ul_cpu = check_cpu_variant();
+	if (!tqma6ul_cpu)
+		return tqma6ul_som_type_unknown;
+
+	/* MX6UL1 vs MX6UL2 */
+	mx6ul_variant = check_module_fused(MODULE_ENET2) ? 1 : 2;
+
+	somtype = check_tqma6ul_variant();
+	switch (somtype) {
+	case tqma6ul_som_type_ca:
+		tqma6ul_variant = "";
+		break;
+	case tqma6ul_som_type_lga:
+		tqma6ul_variant = "l";
+		break;
+	default:
+		return tqma6ul_som_type_unknown;
+	}
+
+	snprintf(dt, dtsize, "imx6%s-tqma6%s%u%s-%s",
+		 tqma6ul_cpu, tqma6ul_cpu, mx6ul_variant, tqma6ul_variant, mb);
+
+	return somtype;
+}
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+int dram_init(void)
+{
+	gd->ram_size = imx_ddr_size();
+
+	return 0;
+}
+
+const char *tq_som_get_modulename(void)
+{
+	if (is_mx6ul()) {
+		if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD))
+			return "TQMa6ULx";
+
+		if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_LGA))
+			return "TQMa6ULxL";
+	}
+
+	if (is_mx6ull()) {
+		if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_STANDARD))
+			return "TQMa6ULLx";
+
+		if (IS_ENABLED(CONFIG_TQMA6UL_VARIANT_LGA))
+			return "TQMa6ULLxL";
+	}
+
+	return "Unknown";
+}
+
+int checkboard(void)
+{
+	printf("Board: %s on %s\n", tq_som_get_modulename(),
+	       tq_bb_get_boardname());
+
+	return tq_bb_checkboard();
+}
+
+#if IS_ENABLED(CONFIG_CMD_BMODE)
+static const struct boot_mode tqma6ul_board_boot_modes[] = {
+	/* 4 bit bus width */
+	{"sd", MAKE_CFGVAL(0x42, 0x20, 0x00, 0x00)},
+	{"emmc", MAKE_CFGVAL(0x40, 0x28, 0x00, 0x00)},
+	{"qspi", MAKE_CFGVAL(0x10, 0x00, 0x00, 0x00)},
+	{NULL, 0},
+};
+#endif
+
+int tq_bb_board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_CMD_BMODE))
+		add_board_boot_modes(tqma6ul_board_boot_modes);
+
+	env_set_runtime("board_name", tq_som_get_modulename());
+
+	return 0;
+}
+
+int tq_bb_checkboard(void)
+{
+	if (is_mx6ul()) {
+		if (!IS_ENABLED(CONFIG_MX6UL))
+			printf("*** ERROR: image not compiled for i.MX6UL!\n");
+	} else if (is_mx6ull()) {
+		if (!IS_ENABLED(CONFIG_MX6ULL))
+			printf("*** ERROR: image not compiled for i.MX6ULL!\n");
+	} else {
+		printf("*** ERROR: unknown CPU variant!\n");
+	}
+
+	return 0;
+}
+
+/*
+ * Device Tree Support
+ */
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT)
+int tq_bb_ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT) */
+
+#endif /* !IS_ENABLED(CONFIG_SPL_BUILD) */
diff --git a/board/tq/tqma6ul/tqma6ul.cfg b/board/tq/tqma6ul/tqma6ul.cfg
new file mode 100644
index 00000000000..42821ae5c7a
--- /dev/null
+++ b/board/tq/tqma6ul/tqma6ul.cfg
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ */
+
+#include <config.h>
+
+/* image version */
+
+IMAGE_VERSION 2
+
+#if IS_ENABLED(CONFIG_QSPI_BOOT)
+BOOT_FROM	qspi
+#else
+BOOT_FROM	sd
+#endif
+
+#if IS_ENABLED(CONFIG_IMX_HAB)
+CSF CONFIG_CSF_SIZE
+#endif
diff --git a/board/tq/tqma6ul/tqma6ul.env b/board/tq/tqma6ul/tqma6ul.env
new file mode 100644
index 00000000000..12281c8a3a4
--- /dev/null
+++ b/board/tq/tqma6ul/tqma6ul.env
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * TQMa6UL environment
+ */
+
+#include <env/tq/tq-imx-shared.env>
+
+emmc_dev=0
+sd_dev=1
+board=tqma6ul
+boot_os=bootz "${kernel_addr_r}" - "${fdt_addr_r}"
+emmc_bootp_start=TQMA6UL_MMC_UBOOT_SECTOR_START
+fdt_addr_r=TQMA6UL_FDT_ADDRESS
+fdtoverlay_addr_r=TQMA6UL_FDT_OVERLAY_ADDR
+image=zImage
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+pxefile_addr_r=CONFIG_SYS_LOAD_ADDR
+ramdisk_addr_r=TQMA6UL_INITRD_ADDRESS
+mmcautodetect=yes
+mmcblkdev=0
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+netdev=eth1
+uboot=u-boot-with-spl.imx
+uboot_mmc_start=TQMA6UL_MMC_UBOOT_SECTOR_START
+uboot_mmc_size=TQMA6UL_MMC_UBOOT_SECTOR_COUNT
+uboot_spi_sector_size=TQMA6UL_SPI_FLASH_SECTOR_SIZE
+uboot_spi_start=TQMA6UL_SPI_UBOOT_START
+uboot_spi_size=TQMA6UL_SPI_UBOOT_SIZE
+
+#ifdef CONFIG_USB_FUNCTION_FASTBOOT
+
+/* 0=user 1=boot1 2=boot2 */
+fastboot_mmc_boot_partition = 1
+
+fastboot_partition_alias_all=CONFIG_FASTBOOT_FLASH_MMC_DEV :0
+
+fastboot_raw_partition_bootloader=
+	TQMA6UL_MMC_UBOOT_SECTOR_START TQMA6UL_MMC_UBOOT_SECTOR_COUNT mmcpart
+	"${fastboot_mmc_boot_partition}"
+
+fastbootcmd=fastboot usb 0
+
+#endif /* CONFIG_USB_FUNCTION_FASTBOOT */
diff --git a/board/tq/tqma6ul/tqma6ul.h b/board/tq/tqma6ul/tqma6ul.h
new file mode 100644
index 00000000000..595edc89e19
--- /dev/null
+++ b/board/tq/tqma6ul/tqma6ul.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ */
+
+enum tqma6ul_som_type {
+	/* unknown */
+	tqma6ul_som_type_unknown,
+	/* connector module */
+	tqma6ul_som_type_ca,
+	/* LGA Variant */
+	tqma6ul_som_type_lga,
+};
+
+/**
+ * Checks configuration for TQMa6UL SoM module variant
+ */
+enum tqma6ul_som_type check_tqma6ul_variant(void);
+
+/**
+ * Adjusts device tree name based on CPU variant.
+ */
+enum tqma6ul_som_type set_tqma6ul_dt_name(char *dt, size_t dtsize, const char *mb);
diff --git a/board/tq/tqma6ul/tqma6ul_mba6ul.c b/board/tq/tqma6ul/tqma6ul_mba6ul.c
new file mode 100644
index 00000000000..be78060cbda
--- /dev/null
+++ b/board/tq/tqma6ul/tqma6ul_mba6ul.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Marco Felsch, Nora Schiffer
+ */
+
+#include <env.h>
+#include <malloc.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/iomux.h>
+#include <asm/arch/mx6-pins.h>
+#include <asm/mach-imx/sys_proto.h>
+
+#include "../common/tq_bb.h"
+#include "tqma6ul.h"
+
+const char *tq_bb_get_boardname(void)
+{
+	return "MBa6ULx";
+}
+
+int board_early_init_f(void)
+{
+	return tq_bb_board_early_init_f();
+}
+
+static void mba6ul_setup_eth(void)
+{
+	struct iomuxc *const iomuxc_regs = (struct iomuxc *)IOMUXC_BASE_ADDR;
+
+	if (check_module_fused(MODULE_ENET1)) {
+		printf("FEC1: disabled by fuses\n");
+	} else {
+		/*
+		 * Use 50M anatop loopback REF_CLK1 for ENET1,
+		 * clear gpr1[13], set gpr1[17]
+		 */
+		clrsetbits_le32(&iomuxc_regs->gpr[1], IOMUX_GPR1_FEC1_MASK,
+				IOMUX_GPR1_FEC1_CLOCK_MUX1_SEL_MASK);
+
+		enable_fec_anatop_clock(0, ENET_50MHZ);
+	}
+
+	if (check_module_fused(MODULE_ENET2)) {
+		printf("FEC2: disabled by fuses\n");
+	} else {
+		/*
+		 * Use 50M anatop loopback REF_CLK1 for ENET2,
+		 * clear gpr1[14], set gpr1[18]
+		 */
+		clrsetbits_le32(&iomuxc_regs->gpr[1], IOMUX_GPR1_FEC2_MASK,
+				IOMUX_GPR1_FEC2_CLOCK_MUX1_SEL_MASK);
+
+		enable_fec_anatop_clock(1, ENET_50MHZ);
+	}
+
+	enable_enet_clk(1);
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+static void mba6ul_set_fdt_file(void)
+{
+	/* Longest FDT name */
+	char dt[] = "imx6ull-tqma6ull2l-mba6ulx.dtb";
+	enum tqma6ul_som_type somtype;
+
+	if (!env_get("fdtfile")) {
+		somtype = set_tqma6ul_dt_name(dt, sizeof(dt), "mba6ulx.dtb");
+		if (somtype == tqma6ul_som_type_unknown)
+			return;
+
+		env_set_runtime("fdtfile", dt);
+	}
+}
+
+int board_late_init(void)
+{
+	unsigned int bmode =
+		(imx6_src_get_boot_mode() & IMX6_BMODE_MASK) >> IMX6_BMODE_SHIFT;
+
+	tq_bb_board_late_init();
+
+	printf("Boot: ");
+
+	switch (bmode) {
+	case IMX6_BMODE_MMC:
+	case IMX6_BMODE_EMMC:
+		printf("eMMC\n");
+		env_set_runtime("boot_dev", "mmc");
+		board_late_mmc_env_init();
+		break;
+	case IMX6_BMODE_SD:
+	case IMX6_BMODE_ESD:
+		printf("SD\n");
+		env_set_runtime("boot_dev", "mmc");
+		board_late_mmc_env_init();
+		break;
+	case IMX6_BMODE_QSPI:
+	case IMX6_BMODE_NOR:
+		printf("QSPI\n");
+		env_set_runtime("boot_dev", "qspi");
+		break;
+	default:
+		printf("unhandled boot device %u\n", bmode);
+	}
+
+	mba6ul_set_fdt_file();
+	mba6ul_setup_eth();
+
+	return 0;
+}
+
+int board_mmc_get_env_dev(int devno)
+{
+	unsigned int port = (imx6_src_get_boot_mode() >> 11) & 0x3;
+
+	switch (port) {
+	case 0:
+		/* SDHC1 - SD card on MBa6ULx */
+		return 1;
+
+	default:
+		/* Return eMMC device otherwise */
+		return 0;
+	}
+}
+
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return tq_bb_ft_board_setup(blob, bd);
+}
+#endif /* IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT) */
diff --git a/doc/board/tq/index.rst b/doc/board/tq/index.rst
index d6dc6101c2c..775957474e7 100644
--- a/doc/board/tq/index.rst
+++ b/doc/board/tq/index.rst
@@ -9,4 +9,5 @@ TQ-Systems
 .. toctree::
    :maxdepth: 2
 
+   tqma6ul
    tqma7
diff --git a/doc/board/tq/tqma6ul.rst b/doc/board/tq/tqma6ul.rst
new file mode 100644
index 00000000000..2b346715642
--- /dev/null
+++ b/doc/board/tq/tqma6ul.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later or CC-BY-4.0
+
+.. Copyright (c) 2017-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+.. D-82229 Seefeld, Germany.
+
+########################################
+U-Boot for the TQ-Systems TQMa6x modules
+########################################
+
+The following hardware revisions are supported:
+
+Modules:
+
++------------+----------+
+| TQMa6ULx   | REV.030x |
++------------+----------+
+| TQMa6ULLx  | REV.030x |
++------------+----------+
+| TQMa6ULxL  | REV.030x |
++------------+----------+
+| TQMa6ULLxL | REV.030x |
++------------+----------+
+
+Mainboards:
+
++----------+----------+
+| MBa6ULx  | REV.020x |
++----------+----------+
+
+Hardware on modules TQMa6ULx, TQMa6ULxL, TQMa6ULLx and TQMa6ULLxL
+
+- eMMC
+- RTC
+- PMIC
+- SPI-NOR (optional)
+- EEPROM
+- Temperature sensor
+- RAM (256 MiB / 512 MiB)
+
+Supported hardware on Starterkit MBa6ULx:
+
+- 2 Ethernet PHY connected to FEC0 / FEC1 (usage depends on CPU)
+- SD-card slot
+- UART
+- USB
+
+Note: To change the Ethernet port to use for networking functionality, use the
+U-Boot generic environment variable ``ethact``.
+
+.. code-block:: bash
+
+    setenv ethact <FEC>
+
+***********
+Boot source
+***********
+
+- SD/eMMC
+- USB/SDP (with NXP UUU tool)
+- SPI NOR (functional but requires additional prepended NXP header.
+  Not supported in U-Boot.)
+
+********
+Building
+********
+
+To build U-Boot for the TQ-Systems TQMa6L modules:
+
+.. code-block:: bash
+
+	make <som>_<baseboard>_<boot>_defconfig
+	make
+
+
+**som**  is a placeholder for the module base variant:
+
++------------+------------+----------------+
+| tqma6ulx   | TQMa6ULx   | i.MX6UL        |
++------------+------------+----------------+
+| tqma6ullx  | TQMa6ULLx  | i.MX6ULL       |
++------------+------------+----------------+
+| tqma6ulxl  | TQMa6ULxL  | i.MX6UL (lga)  |
++------------+------------+----------------+
+| tqma6ullxl | TQMa6ULLxL | i.MX6ULL (lga) |
++------------+------------+----------------+
+
+**baseboard** is a placeholder for the mainboard to compile for:
+
++----------+----------+
+| mba6ul   | MBa6ULx  |
++----------+----------+
+
+**boot** is a placeholder for the boot device:
+
++------+---------+
+| mmc  | SD/eMMC |
++------+---------+
+| spi  | SPI-NOR |
++------+---------+
+
+************
+Support Wiki
+************
+
+See `TQ Embedded Wiki for TQMa6ulx <https://support.tq-group.com/en/arm/tqma6ulx>`_.
diff --git a/include/configs/tqma6ul.h b/include/configs/tqma6ul.h
new file mode 100644
index 00000000000..dce3816d0b7
--- /dev/null
+++ b/include/configs/tqma6ul.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Marco Felsch, Nora Schiffer
+ *
+ * Configuration settings for the TQ-Systems TQMa6UL[L]x[L] SOM family.
+ */
+
+#ifndef __TQMA6UL_CONFIG_H
+#define __TQMA6UL_CONFIG_H
+
+#include "mx6_common.h"
+
+/* 128 MiB offset as suggested in ARM related Linux docs */
+#define TQMA6UL_FDT_ADDRESS		0x88000000
+
+/* 256KiB above TQMA6UL_FDT_ADDRESS (TQMA6UL_FDT_ADDRESS + SZ_256K) */
+#define TQMA6UL_FDT_OVERLAY_ADDR	0x88040000
+
+/* 16MiB above TQMA6UL_FDT_ADDRESS (TQMA6UL_FDT_ADDRESS + SZ_16M) */
+#define TQMA6UL_INITRD_ADDRESS		0x89000000
+
+/* Physical Memory Map */
+#define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
+
+#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM
+#define CFG_SYS_INIT_RAM_ADDR		IRAM_BASE_ADDR
+#define CFG_SYS_INIT_RAM_SIZE		IRAM_SIZE
+
+/* u-boot.img base address for SPI-NOR boot */
+#define CFG_SYS_UBOOT_BASE	(QSPI0_AMBA_BASE + 0x1000 + CONFIG_SPL_PAD_TO)
+
+#define CFG_SYS_INIT_SP_OFFSET \
+	(CFG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
+#define CFG_SYS_INIT_SP_ADDR \
+	(CFG_SYS_INIT_RAM_ADDR + CFG_SYS_INIT_SP_OFFSET)
+
+#define TQMA6UL_MMC_UBOOT_SECTOR_START	0x2
+#define TQMA6UL_MMC_UBOOT_SECTOR_COUNT	0x7fe
+
+#define TQMA6UL_SPI_FLASH_SECTOR_SIZE	SZ_64K
+#define TQMA6UL_SPI_UBOOT_START		0x1000
+#define TQMA6UL_SPI_UBOOT_SIZE		0xf0000
+
+#endif /* __TQMA6UL_CONFIG_H */
diff --git a/include/configs/tqma6ul_mba6ul.h b/include/configs/tqma6ul_mba6ul.h
new file mode 100644
index 00000000000..76e0553c68d
--- /dev/null
+++ b/include/configs/tqma6ul_mba6ul.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Nora Schiffer
+ *
+ * Configuration settings for the TQ-Systems MBa6ULx carrier board for
+ * TQMa6UL[L]x[L] SOM family.
+ */
+
+#ifndef __CONFIG_TQMA6UL_MBA6UL_H
+#define __CONFIG_TQMA6UL_MBA6UL_H
+
+#include "tqma6ul.h"
+
+#define CFG_MXC_UART_BASE		UART1_BASE
+#define CFG_SYS_FSL_ESDHC_ADDR		0
+
+#endif /* __CONFIG_TQMA6UL_MBA6UL_H */
-- 
2.43.0

