Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBAA1067036
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 14:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19016842D7;
	Thu, 12 Mar 2026 15:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ay6mnPdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F370842AB; Thu, 12 Mar 2026 15:31:38 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CC68425A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 15:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=M/Jvm/nxLkuNlEq6eDxWo7jxesBJKuVH0ezA0nK+mFs=; b=ay6mnPdt7/DW6kHTT0lSRAL1f1
 DKktvQf3/0mydfTSMd1G/0XnCjHB6zpYKw1I180Mt3RbTVjI3nXCoCOwWfWb9SpPYtgcr9CVt/XVw
 nnWs1PAGvgM4fqZZwqp1NELp7rKmopr9B/9HKIw1wIWn5qftJwWRt2X5LGj1ywvXXihlDyYAk7XWN
 Kf4aCHSS+xi0pDSZcyEIIba/wj3DZptn0z4WN7bOkAHC0Yn0mqGDARbVwvvP8CRqKy8Agkl53bDFC
 VBefhkaw9TjK+f8v5s6LhPZu7UYNoVnDSvMAWiV9oPqZCZjy/HC0ap2O21rHdNjAsT+TPjiGDuOqb
 VetucJ5w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w0h4V-000FLc-26; Thu, 12 Mar 2026 15:31:31 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w0h4V-0003V8-0h; Thu, 12 Mar 2026 15:31:31 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 6/8] board: tqma7: add code for u-boot with spl
Date: Thu, 12 Mar 2026 15:31:16 +0100
Message-Id: <20260312143118.1677859-7-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
References: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

The TQMa7x is a SoM family with a pluggable board connector based on the
i.MX7 SoCs. Add support for the SoM and its combination with our
MBa7x carrier board.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 MAINTAINERS                    |   2 +
 arch/arm/mach-imx/mx7/Kconfig  |  16 +++
 board/tq/tqma7/Kconfig         | 103 +++++++++++++++++++
 board/tq/tqma7/Makefile        |  14 +++
 board/tq/tqma7/spl.c           | 123 ++++++++++++++++++++++
 board/tq/tqma7/spl_mba7.c      | 182 +++++++++++++++++++++++++++++++++
 board/tq/tqma7/spl_tqma7_ram.c | 171 +++++++++++++++++++++++++++++++
 board/tq/tqma7/tqma7.c         |  96 +++++++++++++++++
 board/tq/tqma7/tqma7.cfg       |  26 +++++
 board/tq/tqma7/tqma7.env       |  36 +++++++
 board/tq/tqma7/tqma7_mba7.c    | 148 +++++++++++++++++++++++++++
 include/configs/tqma7.h        |  71 +++++++++++++
 include/configs/tqma7_mba7.h   |  16 +++
 include/env/tq/spi.env         |   4 +
 14 files changed, 1008 insertions(+)
 create mode 100644 board/tq/tqma7/Kconfig
 create mode 100644 board/tq/tqma7/Makefile
 create mode 100644 board/tq/tqma7/spl.c
 create mode 100644 board/tq/tqma7/spl_mba7.c
 create mode 100644 board/tq/tqma7/spl_tqma7_ram.c
 create mode 100644 board/tq/tqma7/tqma7.c
 create mode 100644 board/tq/tqma7/tqma7.cfg
 create mode 100644 board/tq/tqma7/tqma7.env
 create mode 100644 board/tq/tqma7/tqma7_mba7.c
 create mode 100644 include/configs/tqma7.h
 create mode 100644 include/configs/tqma7_mba7.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fd3cb69ad8b..294712c0466 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1850,7 +1850,9 @@ L:	u-boot@ew.tq-group.com
 W:	https://www.tq-group.com/en/products/tq-embedded/
 S:	Maintained
 F:	arch/arm/dts/*mba6*.dts*
+F:	arch/arm/dts/*mba7*.dts*
 F:	arch/arm/dts/*tqma6*.dts*
+F:	arch/arm/dts/*tqma7*.dts*
 F:	board/tq/*
 F:	configs/tq*config
 F:	doc/board/tq/*
diff --git a/arch/arm/mach-imx/mx7/Kconfig b/arch/arm/mach-imx/mx7/Kconfig
index f576ee650f0..597eca142af 100644
--- a/arch/arm/mach-imx/mx7/Kconfig
+++ b/arch/arm/mach-imx/mx7/Kconfig
@@ -90,6 +90,21 @@ config TARGET_COLIBRI_IMX7
 	select MX7D
 	imply CMD_DM
 
+config TARGET_TQMA7
+	bool "TQ-Systems TQMa7x SoM"
+	select BOARD_LATE_INIT
+	select SUPPORT_SPL
+	select SPL_SEPARATE_BSS if SPL
+	select DM
+	select DM_SERIAL
+	select MX7
+	imply MX7D
+	imply CMD_DM
+	imply DM_THERMAL
+	help
+	  TQMa7x is a TQ SoM with i.MX7 CPU
+	  The SoM can be used on various baseboards.
+
 endchoice
 
 config SYS_SOC
@@ -102,6 +117,7 @@ source "board/novtech/meerkat96/Kconfig"
 source "board/storopack/smegw01/Kconfig"
 source "board/technexion/pico-imx7d/Kconfig"
 source "board/toradex/colibri_imx7/Kconfig"
+source "board/tq/tqma7/Kconfig"
 source "board/warp7/Kconfig"
 
 endif
diff --git a/board/tq/tqma7/Kconfig b/board/tq/tqma7/Kconfig
new file mode 100644
index 00000000000..477ce3f3d53
--- /dev/null
+++ b/board/tq/tqma7/Kconfig
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Markus Niebel, Steffen Doster
+#
+
+if TARGET_TQMA7
+
+config SYS_BOARD
+	default "tqma7"
+
+config SYS_VENDOR
+	default "tq"
+
+config SYS_CONFIG_NAME
+	default "tqma7"
+
+choice
+	prompt "TQMa7x RAM configuration"
+	default TQMA7_RAM_MULTI
+	help
+	  Select RAM configuration. Normally use default here but for
+	  specific setup it is possible to use a single RAM size.
+
+config TQMA7_RAM_MULTI
+	bool "TQMa7x with 512/1024/2048 MB RAM - Single image"
+	select TQMA7_RAM_2G
+	select TQMA7_RAM_1G
+	select TQMA7_RAM_512M
+	help
+	  Build a single U-Boot solely for variants
+	  with 512/1024/2048 MB RAM.
+
+config TQMA7_RAM_SINGLE_2G
+	bool "TQMa7x with 2 GB RAM"
+	select TQMA7_RAM_2G
+	help
+	  Build U-Boot solely for variants
+	  with 2 GB RAM.
+
+config TQMA7_RAM_SINGLE_1G
+	bool "TQMa7x with 1 GB RAM"
+	select TQMA7_RAM_1G
+	help
+	  Build U-Boot solely for variants
+	  with 1 GB RAM.
+
+config TQMA7_RAM_SINGLE_512M
+	bool "TQMa7x with 512 MB RAM"
+	select TQMA7_RAM_512M
+	help
+	  Build U-Boot solely for variants
+	  with 512 MB RAM.
+
+endchoice
+
+config TQMA7_RAM_2G
+	bool
+
+config TQMA7_RAM_1G
+	bool
+
+config TQMA7_RAM_512M
+	bool
+
+choice
+	prompt "TQMa7x base board variant"
+	default MBA7
+	help
+	  Select base board
+	  for TQMa7x
+
+config MBA7
+	bool "TQMa7x on MBa7x Starterkit"
+	select TQ_COMMON_BB
+	select TQ_COMMON_SOM
+	select TQ_COMMON_SYSINFO
+	select I2C_EEPROM
+	select MISC
+	imply USB
+	imply CMD_USB
+	imply USB_STORAGE
+	imply PHYLIB
+	imply CONFIG_PHY_TI_DP83867
+	select MXC_UART
+	select DM_MMC
+	select DM_SPI
+	select DM_I2C
+	select DM_GPIO
+	imply DM_ETH
+	help
+	  Select the MBa7x
+	  starterkit.
+
+endchoice
+
+config IMX_CONFIG
+	default "board/tq/tqma7/tqma7.cfg"
+
+source "board/tq/common/Kconfig"
+
+endif
diff --git a/board/tq/tqma7/Makefile b/board/tq/tqma7/Makefile
new file mode 100644
index 00000000000..b1fb270e861
--- /dev/null
+++ b/board/tq/tqma7/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+
+
+obj-y += tqma7.o
+obj-$(CONFIG_MBA7) += tqma7_mba7.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+obj-y += spl_tqma7_ram.o
+obj-$(CONFIG_MBA7) += spl_mba7.o
+endif
diff --git a/board/tq/tqma7/spl.c b/board/tq/tqma7/spl.c
new file mode 100644
index 00000000000..62db30e81f2
--- /dev/null
+++ b/board/tq/tqma7/spl.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Feilke
+ */
+
+#include <fsl_esdhc_imx.h>
+#include <hang.h>
+#include <spl.h>
+#include <asm/arch/clock.h>
+#include <asm/arch-mx7/mx7d_pins.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/iomux-v3.h>
+
+#include "../common/tq_bb.h"
+#include "../common/tq_som.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define USDHC_PAD_CTRL		(PAD_CTL_DSE_3P3V_49OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PU47KOHM)
+
+#define USDHC_CMD_PAD_CTRL	(PAD_CTL_DSE_3P3V_49OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PU47KOHM)
+
+#define USDHC_CLK_PAD_CTRL	(PAD_CTL_DSE_3P3V_98OHM | \
+	PAD_CTL_SRE_SLOW | PAD_CTL_PUS_PU47KOHM)
+
+#define USDHC_STROBE_PAD_CTRL	(PAD_CTL_DSE_3P3V_49OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PD100KOHM)
+
+/* eMMC on USDHCI3 always present */
+static const iomux_v3_cfg_t tqma7_usdhc3_pads[] = {
+	NEW_PAD_CTRL(MX7D_PAD_SD3_CLK__SD3_CLK,		USDHC_CLK_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_CMD__SD3_CMD,		USDHC_CMD_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA0__SD3_DATA0,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA1__SD3_DATA1,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA2__SD3_DATA2,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA3__SD3_DATA3,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA4__SD3_DATA4,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA5__SD3_DATA5,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA6__SD3_DATA6,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_DATA7__SD3_DATA7,	USDHC_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD3_STROBE__SD3_STROBE,	USDHC_STROBE_PAD_CTRL),
+};
+
+static struct fsl_esdhc_cfg tqma7_usdhc3_cfg = {
+	.esdhc_base = USDHC3_BASE_ADDR,
+	.max_bus_width = 8,
+};
+
+int board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC3_BASE_ADDR)
+		/* eMMC/uSDHC3 is always present */
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
+	if (cfg->esdhc_base == USDHC3_BASE_ADDR)
+		/* eMMC/uSDHC3 is not WP */
+		ret = 0;
+	else
+		ret = tq_bb_board_mmc_getwp(mmc);
+
+	return ret;
+}
+
+int board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(tqma7_usdhc3_pads,
+					 ARRAY_SIZE(tqma7_usdhc3_pads));
+
+	tqma7_usdhc3_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+
+	if (fsl_esdhc_initialize(bis, &tqma7_usdhc3_cfg))
+		puts("Warning: failed to initialize eMMC dev\n");
+
+	tq_bb_board_mmc_init(bis);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
+
+	return tq_bb_board_init();
+}
+
+/*
+ * called from C runtime startup code (arch/arm/lib/crt0.S:_main)
+ * - we have a stack and a place to store GD, both in SRAM
+ * - no variable global data is available
+ */
+void board_init_f(ulong dummy)
+{
+	/* setup AIPS and disable watchdog */
+	arch_cpu_init();
+
+	timer_init();
+
+	tq_bb_board_early_init_f();
+
+	preloader_console_init();
+
+	/* DDR initialization */
+	tq_som_ram_init();
+}
+
diff --git a/board/tq/tqma7/spl_mba7.c b/board/tq/tqma7/spl_mba7.c
new file mode 100644
index 00000000000..13438247731
--- /dev/null
+++ b/board/tq/tqma7/spl_mba7.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Feilke
+ */
+
+#include <fsl_esdhc_imx.h>
+#include <spl.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/arch-mx7/mx7d_pins.h>
+
+#include "../common/tq_bb.h"
+
+#define UART_RX_PAD_CTRL       (PAD_CTL_DSE_3P3V_49OHM | PAD_CTL_PUS_PU100KOHM | \
+	PAD_CTL_PUE | PAD_CTL_HYS | PAD_CTL_SRE_SLOW)
+
+#define UART_TX_PAD_CTRL       (PAD_CTL_DSE_3P3V_49OHM | PAD_CTL_PUS_PU100KOHM | \
+	PAD_CTL_PUE | PAD_CTL_SRE_SLOW)
+
+#define USDHC_DATA_PAD_CTRL	(PAD_CTL_DSE_3P3V_98OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PU47KOHM)
+
+#define USDHC_CMD_PAD_CTRL	(PAD_CTL_DSE_3P3V_98OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PU47KOHM)
+
+#define USDHC_CLK_PAD_CTRL	(PAD_CTL_DSE_3P3V_49OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_PUE | PAD_CTL_PUS_PU47KOHM)
+
+#define USDHC_STROBE_PAD_CTRL	(PAD_CTL_DSE_3P3V_98OHM | PAD_CTL_SRE_FAST | \
+	PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PUS_PD100KOHM)
+
+#define GPIO_IN_PAD_CTRL	(PAD_CTL_PUS_PU100KOHM | \
+	PAD_CTL_DSE_3P3V_196OHM | PAD_CTL_HYS | PAD_CTL_SRE_SLOW)
+#define GPIO_OUT_PAD_CTRL	(PAD_CTL_PUS_PU100KOHM | \
+	PAD_CTL_DSE_3P3V_98OHM | PAD_CTL_HYS | PAD_CTL_SRE_SLOW)
+
+static const iomux_v3_cfg_t mba7_uart6_pads[] = {
+	NEW_PAD_CTRL(MX7D_PAD_EPDC_DATA08__UART6_DCE_RX, UART_RX_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_EPDC_DATA09__UART6_DCE_TX, UART_TX_PAD_CTRL),
+};
+
+static void mba7_setup_iomuxc_uart(void)
+{
+	imx_iomux_v3_setup_multiple_pads(mba7_uart6_pads, ARRAY_SIZE(mba7_uart6_pads));
+}
+
+static const iomux_v3_cfg_t mba7_usdhc1_pads[] = {
+	NEW_PAD_CTRL(MX7D_PAD_SD1_CLK__SD1_CLK,		USDHC_CLK_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD1_CMD__SD1_CMD,		USDHC_CMD_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD1_DATA0__SD1_DATA0,	USDHC_DATA_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD1_DATA1__SD1_DATA1,	USDHC_DATA_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD1_DATA2__SD1_DATA2,	USDHC_DATA_PAD_CTRL),
+	NEW_PAD_CTRL(MX7D_PAD_SD1_DATA3__SD1_DATA3,	USDHC_DATA_PAD_CTRL),
+	/* CD */
+	NEW_PAD_CTRL(MX7D_PAD_SD1_CD_B__GPIO5_IO0,	GPIO_IN_PAD_CTRL),
+	/* WP */
+	NEW_PAD_CTRL(MX7D_PAD_SD1_WP__GPIO5_IO1,	GPIO_IN_PAD_CTRL),
+};
+
+#define USDHC1_CD_GPIO	IMX_GPIO_NR(5, 0)
+#define USDHC1_WP_GPIO	IMX_GPIO_NR(5, 1)
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
+static struct fsl_esdhc_cfg mba7_usdhc_cfg = {
+	.esdhc_base = USDHC1_BASE_ADDR,
+	.max_bus_width = 4,
+};
+
+int tq_bb_board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(mba7_usdhc1_pads,
+					 ARRAY_SIZE(mba7_usdhc1_pads));
+	gpio_request(USDHC1_CD_GPIO, "usdhc1-cd");
+	gpio_request(USDHC1_WP_GPIO, "usdhc1-wp");
+	gpio_direction_input(USDHC1_CD_GPIO);
+	gpio_direction_input(USDHC1_WP_GPIO);
+
+	mba7_usdhc_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK);
+	if (fsl_esdhc_initialize(bis, &mba7_usdhc_cfg))
+		puts("Warning: failed to initialize SD\n");
+
+	return 0;
+}
+
+int tq_bb_board_early_init_f(void)
+{
+	/* iomux and setup of uart */
+	mba7_setup_iomuxc_uart();
+
+	return 0;
+}
+
+/*
+ * This is done per baseboard to allow different implementations
+ */
+void board_boot_order(u32 *spl_boot_list)
+{
+	enum boot_device bd;
+	/*
+	 * try to get sd card slots in order:
+	 * eMMC: on Module
+	 * -> therefore index 0 for bootloader
+	 * index n in kernel (controller instance 3) -> patches needed for
+	 * alias indexing
+	 * SD1: on Mainboard
+	 * index n in kernel (controller instance 1) -> patches needed for
+	 * alias indexing
+	 * we assume to have a kernel patch that will present mmcblk dev
+	 * indexed like controller devs
+	 */
+	puts("Boot: ");
+
+	bd = get_boot_device();
+	switch (bd) {
+	case MMC3_BOOT:
+		puts("USDHC3(eMMC)\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+		break;
+	case SD1_BOOT:
+		puts("USDHC1(SD)\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC2;
+		break;
+	case QSPI_BOOT:
+		puts("QSPI\n");
+		spl_boot_list[0] = BOOT_DEVICE_NOR;
+		break;
+	case USB_BOOT:
+		puts("USB\n");
+		spl_boot_list[0] = BOOT_DEVICE_BOARD;
+		break;
+	default:
+		/* Default - BOOT_DEVICE_MMC1 */
+		puts("WARN: unknown boot device, fallback to eMMC\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+		break;
+	}
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	char *config = NULL;
+
+	if (is_cpu_type(MXC_CPU_MX7S))
+		config = "imx7s-mba7";
+	else if (is_cpu_type(MXC_CPU_MX7D))
+		config = "imx7d-mba7";
+
+	if (strcmp(config, name))
+		return -EINVAL;
+
+	printf("Device tree: %s\n", name);
+
+	return 0;
+}
diff --git a/board/tq/tqma7/spl_tqma7_ram.c b/board/tq/tqma7/spl_tqma7_ram.c
new file mode 100644
index 00000000000..903df5d9d0f
--- /dev/null
+++ b/board/tq/tqma7/spl_tqma7_ram.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Feilke
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <linux/sizes.h>
+
+#include "../common/tq_som.h"
+
+#define DDRC_RFSHTMG_512M 0x0020002B
+#define DDRC_RFSHTMG_1G   0x00200045
+#define DDRC_RFSHTMG_2G   0x0020005D
+
+#define DDRC_ADDRMAP1_512M 0x00161616
+#define DDRC_ADDRMAP1_1G   0x00171717
+#define DDRC_ADDRMAP1_2G   0x00181818
+
+#define DDRC_ADDRMAP6_512M 0x0F0F0404
+#define DDRC_ADDRMAP6_1G   0x0F040404
+#define DDRC_ADDRMAP6_2G   0x04040404
+
+#define DDR_PHY_OFFSET_RD_CON0_512M 0x0B0B0B0B
+#define DDR_PHY_OFFSET_RD_CON0_1G   0x0B0B0B0B
+#define DDR_PHY_OFFSET_RD_CON0_2G   0x0A0A0A0A
+
+#define DDR_PHY_OFFSET_WR_CON0_512M 0x06060606
+#define DDR_PHY_OFFSET_WR_CON0_1G   0x06060606
+#define DDR_PHY_OFFSET_WR_CON0_2G   0x04040404
+
+static void tqma7_ddr_exit_retention(void)
+{
+	/* Clear then set bit30 to ensure exit from DDR retention */
+	tq_som_init_write_reg(0x30360388, 0x40000000);
+	tq_som_init_write_reg(0x30360384, 0x40000000);
+}
+
+static void gpr_init(void)
+{
+	/* reset default and enable GPR OCRAM EPDC */
+	tq_som_init_write_reg(0x30340004, 0x4F400005);
+}
+
+static void tqma7_ccgr_init(void)
+{
+	tq_som_init_write_reg(0x30384130, 0x00000000); /* CCM_CCGR19 */
+	tq_som_init_write_reg(0x30340020, 0x00000178); /* IOMUXC_GPR_GPR8 */
+	tq_som_init_write_reg(0x30384130, 0x00000002); /* CCM_CCGR19 */
+	tq_som_init_write_reg(0x30790018, 0x0000000f); /* DDR_PHY_LP_CON0 */
+
+	/* wait for auto-ZQ calibration to complete */
+	tq_som_check_bits_set(0x307a0004, 0x1); /* DDRC_STAT */
+}
+
+static void ddr_init_error(const char *msg)
+{
+	pr_err("%s", msg);
+	hang();
+}
+
+#define TQMA7_SELECT_DDR_VALUE(SIZE, NAME) \
+	((SIZE) == SZ_512M ? NAME ## _512M : \
+	((SIZE) == SZ_1G ? NAME ## _1G :     \
+	((SIZE) == SZ_2G ? NAME ## _2G :     \
+	(ddr_init_error("Invalid DDR RAM size detected"), 0))))
+
+static void tqma7_init_ddr_controller(u32 size)
+{
+	gpr_init();
+
+	/* TQMa7 DDR config */
+	/* TQMa7x DRAM Timing REV0201A */
+	/* DCD Code i.MX7D/S 528 MHz 512 MByte Samsung K4B2G1646F */
+	tq_som_init_write_reg(0x30360070, 0x0070302C);   /*CCM_ANALOG_PLL_DDRx*/
+	tq_som_init_write_reg(0x30360090, 0x00000000);   /*CCM_ANALOG_PLL_NUM*/
+	tq_som_init_write_reg(0x30360070, 0x0060302C);   /*CCM_ANALOG_PLL_DDRx*/
+
+	tq_som_check_bits_set(0x30360070, 0x80000000);
+
+	tq_som_init_write_reg(0x30391000, 0x00000002);   /*SRC_DDRC_RCR*/
+	tq_som_init_write_reg(0x307a0000, 0x01040001);   /*DDRC_MSTR*/
+	tq_som_init_write_reg(0x307a01a0, 0x80400003);   /*DDRC_DFIUPD0*/
+	tq_som_init_write_reg(0x307a01a4, 0x00100020);   /*DDRC_DFIUPD1*/
+	tq_som_init_write_reg(0x307a01a8, 0x80100004);   /*DDRC_DFIUPD2*/
+	tq_som_init_write_reg(0x307a0064, TQMA7_SELECT_DDR_VALUE(size, DDRC_RFSHTMG));
+	tq_som_init_write_reg(0x307a0490, 0x00000001);   /*DDRC_MP_PCTRL_0*/
+	tq_som_init_write_reg(0x307a00d0, 0x00020081);   /*DDRC_INIT0*/
+	tq_som_init_write_reg(0x307a00d4, 0x00680000);   /*DDRC_INIT1*/
+	tq_som_init_write_reg(0x307a00dc, 0x09300004);   /*DDRC_INIT3*/
+	tq_som_init_write_reg(0x307a00e0, 0x00480000);   /*DDRC_INIT4*/
+	tq_som_init_write_reg(0x307a00e4, 0x00100004);   /*DDRC_INIT5*/
+	tq_som_init_write_reg(0x307a00f4, 0x0000033F);   /*DDRC_RANKCTL*/
+	tq_som_init_write_reg(0x307a0100, 0x090E0809);   /*DDRC_DRAMTMG0*/
+	tq_som_init_write_reg(0x307a0104, 0x0007020E);   /*DDRC_DRAMTMG1*/
+	tq_som_init_write_reg(0x307a0108, 0x03040407);   /*DDRC_DRAMTMG2*/
+	tq_som_init_write_reg(0x307a010c, 0x00002006);   /*DDRC_DRAMTMG3*/
+	tq_som_init_write_reg(0x307a0110, 0x04020304);   /*DDRC_DRAMTMG4*/
+	tq_som_init_write_reg(0x307a0114, 0x03030202);   /*DDRC_DRAMTMG5*/
+	tq_som_init_write_reg(0x307a0120, 0x00000803);   /*DDRC_DRAMTMG8*/
+	tq_som_init_write_reg(0x307a0180, 0x00800020);   /*DDRC_ZQCTL0*/
+	tq_som_init_write_reg(0x307a0190, 0x02098204);   /*DDRC_DFITMG0*/
+	tq_som_init_write_reg(0x307a0194, 0x00030303);   /*DDRC_DFITMG1*/
+	tq_som_init_write_reg(0x307a0200, 0x0000001F);   /*DDRC_ADDRMAP0*/
+	tq_som_init_write_reg(0x307a0204, TQMA7_SELECT_DDR_VALUE(size, DDRC_ADDRMAP1));
+	tq_som_init_write_reg(0x307a020C, 0x00000000);   /*DDRC_ADDRMAP3*/
+	tq_som_init_write_reg(0x307a0210, 0x00000F0F);   /*DDRC_ADDRMAP4*/
+	tq_som_init_write_reg(0x307a0214, 0x04040404);   /*DDRC_ADDRMAP5*/
+	tq_som_init_write_reg(0x307a0218, TQMA7_SELECT_DDR_VALUE(size, DDRC_ADDRMAP6));
+	tq_som_init_write_reg(0x307a0240, 0x06000604);   /*DDRC_ODTCFG*/
+	tq_som_init_write_reg(0x307a0244, 0x00000001);   /*DDRC_ODTMAP*/
+	tq_som_init_write_reg(0x30391000, 0x00000000);   /*SRC_DDRC_RCR*/
+	tq_som_init_write_reg(0x30790000, 0x17420F40);   /*DDR_PHY_PHY_CON0*/
+	tq_som_init_write_reg(0x30790004, 0x10210100);   /*DDR_PHY_PHY_CON1*/
+	tq_som_init_write_reg(0x30790010, 0x00060807);   /*DDR_PHY_PHY_CON4*/
+	tq_som_init_write_reg(0x307900b0, 0x1010007E);   /*DDR_PHY_MDLL_CON0*/
+	tq_som_init_write_reg(0x3079009c, 0x00000924);   /*DDR_PHY_DRVDS_CON0*/
+
+	tq_som_init_write_reg(0x30790020, TQMA7_SELECT_DDR_VALUE(size, DDR_PHY_OFFSET_RD_CON0));
+	tq_som_init_write_reg(0x30790030, TQMA7_SELECT_DDR_VALUE(size, DDR_PHY_OFFSET_WR_CON0));
+	tq_som_init_write_reg(0x30790050, 0x01000010);   /*DDR_PHY_CMD_SDLL_CON0*/
+	tq_som_init_write_reg(0x30790050, 0x00000010);   /*DDR_PHY_CMD_SDLL_CON0*/
+
+	tq_som_init_write_reg(0x307900c0, 0x0C407304);   /*DDR_PHY_ZQ_CON0*/
+	tq_som_init_write_reg(0x307900c0, 0x0C447304);   /*DDR_PHY_ZQ_CON0*/
+	tq_som_init_write_reg(0x307900c0, 0x0C447306);   /*DDR_PHY_ZQ_CON0*/
+
+	tq_som_check_bits_set(0x307900c4, 0x1);      /*ZQ Calibration is finished*/
+
+	tq_som_init_write_reg(0x307900c0, 0x0C447304);   /*DDR_PHY_ZQ_CON0*/
+	tq_som_init_write_reg(0x307900c0, 0x0C407304);   /*DDR_PHY_ZQ_CON0*/
+
+	tqma7_ccgr_init();
+}
+
+void tq_som_ram_init(void)
+{
+	/* RAM sizes need to be in descending order */
+	static const u32 ram_sizes[] = {
+#if IS_ENABLED(CONFIG_TQMA7_RAM_2G)
+		SZ_2G,
+#endif
+#if IS_ENABLED(CONFIG_TQMA7_RAM_1G)
+		SZ_1G,
+#endif
+#if IS_ENABLED(CONFIG_TQMA7_RAM_512M)
+		SZ_512M,
+#endif
+	};
+	int i;
+
+	debug("SPL: tqma7 iomux ....\n");
+	tqma7_ddr_exit_retention();
+
+	for (i = 0; i < ARRAY_SIZE(ram_sizes); i++) {
+		tqma7_init_ddr_controller(ram_sizes[i]);
+		if (tq_som_ram_check_size(ram_sizes[i]))
+			break;
+	}
+
+	if (i < ARRAY_SIZE(ram_sizes)) {
+		debug("SPL: tqma7 ddr init done ...\n");
+	} else {
+		pr_err("Error: Invalid DDR RAM size\n");
+		hang();
+	}
+}
diff --git a/board/tq/tqma7/tqma7.c b/board/tq/tqma7/tqma7.c
new file mode 100644
index 00000000000..30bd155713d
--- /dev/null
+++ b/board/tq/tqma7/tqma7.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Steffen Doster
+ */
+
+#include <env.h>
+#include <fdt_support.h>
+#include <mtd_node.h>
+#include <spi_flash.h>
+#include <asm/bootm.h>
+#include <asm/setup.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+
+#include "../common/tq_bb.h"
+#include "../common/tq_som.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_size = imx_ddr_size();
+	return 0;
+}
+
+#if (!IS_ENABLED(CONFIG_SPL_BUILD))
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
+
+	if (IS_ENABLED(CONFIG_FSL_QSPI))
+		set_clk_qspi();
+
+	return tq_bb_board_init();
+}
+
+static const char *tqma7_get_boardname(void)
+{
+	switch (get_cpu_type()) {
+	case MXC_CPU_MX7S:
+		return "TQMa7S";
+	case MXC_CPU_MX7D:
+		return "TQMa7D";
+	default:
+		return "??";
+	};
+}
+
+int board_late_init(void)
+{
+	const char *bname = tqma7_get_boardname();
+
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
+		struct tag_serialnr serialnr;
+
+		get_board_serial(&serialnr);
+
+		printf("UID:   %08x%08x\n", serialnr.high, serialnr.low);
+	}
+
+	env_set_runtime("board_name", bname);
+
+	return tq_bb_board_late_init();
+}
+
+static u32 tqma7_get_board_rev(void)
+{
+	/* REV.0100 is unsupported */
+	return 200;
+}
+
+int checkboard(void)
+{
+	printf("Board: %s REV.%04u\n", tq_bb_get_boardname(), tqma7_get_board_rev());
+	return 0;
+}
+
+/*
+ * Device Tree Support
+ */
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT)
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	tq_bb_ft_board_setup(blob, bd);
+
+	return 0;
+}
+#endif /* defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT) */
+
+#endif /* !IS_ENABLED(CONFIG_SPL_BUILD) */
diff --git a/board/tq/tqma7/tqma7.cfg b/board/tq/tqma7/tqma7.cfg
new file mode 100644
index 00000000000..2e807d62348
--- /dev/null
+++ b/board/tq/tqma7/tqma7.cfg
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Steffen Doster
+ *
+ * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
+ * and create imximage boot image
+ *
+ * The syntax is taken as close as possible with the kwbimage
+ */
+
+/* image version */
+IMAGE_VERSION 2
+
+#include <config.h>
+
+/*
+ * Set to sd even for QSPI boot on i.MX7, as i.MX7 uses offset 0x400 rather
+ * than 0x1000 for QSPI
+ */
+BOOT_FROM      sd
+
+#if IS_ENABLED(CONFIG_IMX_HAB)
+CSF CONFIG_CSF_SIZE
+#endif
diff --git a/board/tq/tqma7/tqma7.env b/board/tq/tqma7/tqma7.env
new file mode 100644
index 00000000000..dd4fff10859
--- /dev/null
+++ b/board/tq/tqma7/tqma7.env
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Feilke
+ *
+ * TQMa7x environment
+ */
+
+#include <env/tq/tq-imx-shared.env>
+
+board=tqma7
+boot_os=bootz "${kernel_addr_r}" - "${fdt_addr_r}"
+emmc_bootp_start=TQMA7_MMC_UBOOT_SECTOR_START
+emmc_dev=0
+fdt_addr_r=TQMA7_FDT_ADDRESS
+fdtoverlay_addr_r=FDT_OVERLAY_ADDR
+image=zImage
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+netdev=eth0
+rootpath=CONFIG_ROOTPATH
+pxefile_addr_r=CONFIG_SYS_LOAD_ADDR
+ramdisk_addr_r=TQMA7_INITRD_ADDRESS
+sd_dev=1
+uboot=u-boot-with-spl.imx
+uboot_mmc_start=TQMA7_MMC_UBOOT_SECTOR_START
+uboot_mmc_size=TQMA7_MMC_UBOOT_SECTOR_COUNT
+uboot_spi_sector_size=TQMA7_SPI_FLASH_SECTOR_SIZE
+uboot_spi_start=TQMA7_SPI_UBOOT_START
+uboot_spi_size=TQMA7_SPI_UBOOT_SIZE
+
+#ifdef CONFIG_FASTBOOT_UUU_SUPPORT
+fastboot_partition_alias_all=CONFIG_FASTBOOT_FLASH_MMC_DEV:0
+fastboot_raw_partition_bootloader=TQMA7_MMC_UBOOT_SECTOR_START TQMA7_MMC_UBOOT_SECTOR_COUNT mmcpart 1
+fastbootcmd=fastboot usb 0
+#endif
diff --git a/board/tq/tqma7/tqma7_mba7.c b/board/tq/tqma7/tqma7_mba7.c
new file mode 100644
index 00000000000..65c6c08771d
--- /dev/null
+++ b/board/tq/tqma7/tqma7_mba7.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Steffen Doster
+ */
+
+#include <env.h>
+#include <errno.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch-mx7/imx-regs.h>
+#include <asm/mach-imx/boot_mode.h>
+
+#include "../common/tq_bb.h"
+
+const char *tq_bb_get_boardname(void)
+{
+	return "MBa7x";
+}
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+
+static int mba7_setup_fec(int fec_id)
+{
+	struct iomuxc_gpr_base_regs *const iomuxc_gpr_regs =
+		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
+	int ret;
+
+	switch (fec_id) {
+	case 0:
+		/* Use 125M anatop REF_CLK1 for ENET1, clear gpr1[13], gpr1[17]*/
+		clrsetbits_le32(&iomuxc_gpr_regs->gpr[1],
+				IOMUXC_GPR_GPR1_GPR_ENET1_TX_CLK_SEL_MASK |
+				IOMUXC_GPR_GPR1_GPR_ENET1_CLK_DIR_MASK, 0);
+		break;
+	case 1:
+		/* Use 125M anatop REF_CLK2 for ENET2, clear gpr1[14], gpr1[18]*/
+		clrsetbits_le32(&iomuxc_gpr_regs->gpr[1],
+				IOMUXC_GPR_GPR1_GPR_ENET2_TX_CLK_SEL_MASK |
+				IOMUXC_GPR_GPR1_GPR_ENET2_CLK_DIR_MASK, 0);
+		break;
+	default:
+		printf("FEC%d: unsupported\n", fec_id);
+		return -EINVAL;
+	}
+
+	ret = set_clk_enet(ENET_125MHZ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int tq_bb_board_init(void)
+{
+	mba7_setup_fec(0);
+
+	if (!is_cpu_type(MXC_CPU_MX7S))
+		mba7_setup_fec(1);
+
+	return 0;
+}
+
+int tq_bb_board_late_init(void)
+{
+	puts("Boot:  ");
+
+	if (is_boot_from_usb()) {
+		puts("USB\n");
+		env_set_runtime("boot_dev", "mmc");
+		env_set_runtime("mmcdev", "0");
+		env_set_runtime("mmcblkdev", "0");
+	} else {
+		/*
+		 * try to get sd card slots in order:
+		 * eMMC: on Module
+		 * -> therefore index 0 for bootloader
+		 * index n in kernel (controller instance 3) -> patches needed for
+		 * alias indexing
+		 * SD1: on Mainboard
+		 * index n in kernel (controller instance 1) -> patches needed for
+		 * alias indexing
+		 * we assume to have a kernel patch that will present mmcblk dev
+		 * indexed like controller devs
+		 */
+		enum boot_device bd = get_boot_device();
+
+		switch (bd) {
+		case MMC3_BOOT:
+			puts("USDHC3(eMMC)\n");
+			env_set_runtime("boot_dev", "mmc");
+			env_set_runtime("mmcdev", "0");
+			env_set_runtime("mmcblkdev", "0");
+			break;
+		case SD1_BOOT:
+			puts("USDHC1(SD)\n");
+			env_set_runtime("boot_dev", "mmc");
+			env_set_runtime("mmcdev", "1");
+			env_set_runtime("mmcblkdev", "1");
+			break;
+		case QSPI_BOOT:
+			puts("QSPI\n");
+			env_set_runtime("boot_dev", "qspi");
+			env_set_runtime("mmcdev", "0");
+			env_set_runtime("mmcblkdev", "0");
+			break;
+		default:
+			printf("unhandled boot device %d\n", (int)bd);
+			env_set_runtime("mmcdev", "0");
+			env_set_runtime("mmcblkdev", "0");
+		}
+	}
+
+	if (!env_get("fdtfile")) {
+		/* provide default setting for fdtfile if nothing in env is set */
+
+		switch (get_cpu_type()) {
+		case MXC_CPU_MX7S:
+			env_set_runtime("fdtfile", "imx7s-mba7.dtb");
+			break;
+		case MXC_CPU_MX7D:
+			env_set_runtime("fdtfile", "imx7d-mba7.dtb");
+			break;
+		default:
+			debug("unknown CPU");
+		}
+	}
+
+	return 0;
+}
+
+int board_mmc_get_env_dev(int devno)
+{
+	switch (devno) {
+	case 2:
+		/* eMMC */
+		return 0;
+	case 0:
+		/* SD card */
+		return 1;
+	default:
+		/* Unknown */
+		return 0;
+	}
+}
+
+#endif /* !IS_ENABLED(CONFIG_SPL_BUILD) */
diff --git a/include/configs/tqma7.h b/include/configs/tqma7.h
new file mode 100644
index 00000000000..6b77139f09d
--- /dev/null
+++ b/include/configs/tqma7.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Steffen Doster
+ *
+ * Configuration settings for the TQ-Systems TQMa7x SOM
+ */
+
+#ifndef __TQMA7_CONFIG_H
+#define __TQMA7_CONFIG_H
+
+#include "mx7_common.h"
+#include <linux/build_bug.h>
+
+/* MMC Configs */
+#define CFG_SYS_FSL_ESDHC_ADDR	0
+
+/*
+ * 128 MiB offset as recommended in Linux' `Documentation/arch/arm/booting.rst`
+ * TQMA7_FDT_ADDRESS = MMDC0_ARB_BASE_ADDR + 0x8000000
+ */
+#define TQMA7_FDT_ADDRESS		0x88000000
+/* FDT_OVERLAY_ADDR = (TQMA7_FDT_ADDRESS + SZ_256K) */
+#define FDT_OVERLAY_ADDR		0x88040000
+/*
+ * DTB is loaded at 128 MiB, so use just 16 MiB more
+ * TQMA7_INITRD_ADDRESS = (TQMA7_FDT_ADDRESS + SZ_16M)
+ */
+#define TQMA7_INITRD_ADDRESS		0x89000000
+
+#ifndef __ASSEMBLY__
+
+static_assert(TQMA7_FDT_ADDRESS == (MMDC0_ARB_BASE_ADDR + 0x8000000));
+static_assert(FDT_OVERLAY_ADDR == (TQMA7_FDT_ADDRESS + SZ_256K));
+static_assert(TQMA7_INITRD_ADDRESS == (TQMA7_FDT_ADDRESS + SZ_16M));
+
+#endif
+
+#define TQMA7_UBOOT_OFFSET		SZ_1K
+#define TQMA7_MMC_UBOOT_SECTOR_START	0x2
+#define TQMA7_MMC_UBOOT_SECTOR_COUNT	0x7fe
+#define TQMA7_SPI_FLASH_SECTOR_SIZE	SZ_64K
+#define TQMA7_SPI_UBOOT_START		0x1000
+#define TQMA7_SPI_UBOOT_SIZE		0xf0000
+
+/* Physical Memory Map */
+#define PHYS_SDRAM		MMDC0_ARB_BASE_ADDR
+
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM
+#define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
+#define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
+
+/* u-boot.img base address for SPI-NOR boot */
+#define CFG_SYS_UBOOT_BASE	(QSPI0_ARB_BASE_ADDR + TQMA7_UBOOT_OFFSET + CONFIG_SPL_PAD_TO)
+
+/*
+ * All the defines above are for the TQMa7x SoM
+ *
+ * Now include the baseboard specific configuration
+ */
+
+#if IS_ENABLED(CONFIG_MBA7)
+#include "tqma7_mba7.h"
+#else
+#error "No baseboard for the TQMa7x SOM defined!"
+#endif
+
+#endif /* __TQMA7_CONFIG_H */
diff --git a/include/configs/tqma7_mba7.h b/include/configs/tqma7_mba7.h
new file mode 100644
index 00000000000..8b6ac6d4fc0
--- /dev/null
+++ b/include/configs/tqma7_mba7.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Steffen Doster
+ *
+ * Configuration settings for the TQ-Systems MBa7x carrier board for
+ * TQMa7x module.
+ */
+
+#ifndef __CONFIG_TQMA7_MBA7_H
+#define __CONFIG_TQMA7_MBA7_H
+
+#define CFG_MXC_UART_BASE	UART6_IPS_BASE_ADDR
+
+#endif /* __CONFIG_TQMA7_MBA7_H */
diff --git a/include/env/tq/spi.env b/include/env/tq/spi.env
index 47dcfea7d3f..242aa4da784 100644
--- a/include/env/tq/spi.env
+++ b/include/env/tq/spi.env
@@ -20,4 +20,8 @@ update_uboot_spi=
 		fi;
 	fi;
 
+#ifdef CONFIG_CMD_QSPIHDR
+write_uboot_spi=qspihdr init ${loadaddr} ${filesize} safe;
+#else
 write_uboot_spi=sf update "${loadaddr}" "${uboot_spi_start}" "${filesize}"
+#endif
-- 
2.34.1

