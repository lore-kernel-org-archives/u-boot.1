Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9D8CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D188B84956;
	Mon,  8 Jun 2026 15:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1YTzsdwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D9184895; Mon,  8 Jun 2026 15:12:50 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB1D848BF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D33904E40B9B;
 Mon,  8 Jun 2026 13:12:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A083E5FFB7;
 Mon,  8 Jun 2026 13:12:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 17EAA106A28D0; 
 Mon,  8 Jun 2026 15:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780924365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=K1Km5UxaVdSP0nxlFLN3pmF1OfWviblCxNIBMigg0x8=;
 b=1YTzsdwJx+S/X5eErYEANj/jfWb/z8TYj1/gIb0DL3cx2xOlWnUK2r2bXfroYxyw90DCG1
 9L5NFFMXZFxr07sLxRuM8Klq8rkXk+c0ypyHZUDpS0ovsMc9f6R7H6F+pIBTZoI5PJLF5q
 1UyjPVS6NzuA407qJATI/enBD9vZIiOIq6M6JLTplQCHWLhOx6blGo1iBqqKHU9KzrTzWA
 M7e4ZjWnAMIrhDHkTCGVEa3319U7k1wU/LOQwmQYJXBzhaCELYttK30Da89SqmuV18dvzi
 ZAFKDaBFAZsDkx/o3nRrEdSRWC47/O7lWTX/QFsTnJ5AIRsmVBA///+tptDHXg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 15:12:02 +0200
Subject: [PATCH v3 6/6] board: variscite: add support for the omap4_var_som
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-omap4-support-v3-6-8595ccd203f0@bootlin.com>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
In-Reply-To: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Fuzzy: e02ab1d04f3ab1e6561657e880f384526471ff569180fb953eafbeb49f04af626e90870b3516d3631bd91d86259190c4620ac5215845234a3ae40d1139488608
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:31 +0200
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

OMAP4 support is present but there isn't any board using it.

Add minimal support for the Variscite OMAP4-SoM (debug console + boot
from SD card).
Use the ti/omap/omap4-var-stk-om44 device-tree from the Linux kernel. The
real representation of the SoM's hardware is located in
ti/omap/omap4-var-som-om44.dtsi included in it.

Set myself as maintainer for it.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 MAINTAINERS                                       |   1 +
 arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi       |  54 +++++++
 arch/arm/include/asm/mach-types.h                 |   1 +
 arch/arm/mach-omap2/omap4/Kconfig                 |  17 +++
 board/variscite/omap4_var_som/Kconfig             |  12 ++
 board/variscite/omap4_var_som/MAINTAINERS         |   4 +
 board/variscite/omap4_var_som/Makefile            |   6 +
 board/variscite/omap4_var_som/omap4_var_som.c     | 172 ++++++++++++++++++++++
 board/variscite/omap4_var_som/omap4_var_som_mux.h |  32 ++++
 configs/omap4_var_som_defconfig                   |  75 ++++++++++
 10 files changed, 374 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d4af983596..5114d691f4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -838,6 +838,7 @@ F:	arch/arm/dts/omap4*
 F:	arch/arm/include/asm/arch-omap4/
 F:	arch/arm/mach-omap2/omap4/
 F:	include/configs/ti_omap4_common.h
+N:	omap4_var_som
 
 ARM U8500
 M:	Stephan Gerhold <stephan@gerhold.net>
diff --git a/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi b/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi
new file mode 100644
index 00000000000..431a02b2ffd
--- /dev/null
+++ b/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Basically we override some "simple-pm-bus" compatibles with "simple-bus".
+ * It allows to access the basic hardware without power-domain support. The
+ * hardware that can be accessed this way is:
+ *  - the console's UART
+ *  - the TWL6030 power regulator through I2C1
+ *  - the SD card reader (MMC1)
+ *
+ */
+
+/ {
+	ocp {
+		compatible = "simple-bus";
+	};
+
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&l4_per {
+	compatible = "simple-bus";
+
+	segment@0 {
+		/* UART 3 / I2C1 (TWL6030) / MMC1 */
+		compatible = "simple-bus";
+
+		/* MMC3 (wifi) */
+		target-module@d1000 {
+			mmc@0 {
+				status = "disabled";
+			};
+		};
+
+		/* MMC4 */
+		target-module@d5000 {
+			mmc@0 {
+				status = "disabled";
+			};
+		};
+	};
+};
+
+&l4_cfg {
+	compatible = "simple-bus";
+
+	segment@0 {
+		/* MMC1's clock */
+		compatible = "simple-bus";
+	};
+};
diff --git a/arch/arm/include/asm/mach-types.h b/arch/arm/include/asm/mach-types.h
index 2713b1d2c55..e73df782d2c 100644
--- a/arch/arm/include/asm/mach-types.h
+++ b/arch/arm/include/asm/mach-types.h
@@ -5050,4 +5050,5 @@
 #define MACH_TYPE_NASM25               5112
 #define MACH_TYPE_TOMATO               5113
 #define MACH_TYPE_OMAP3_MRC3D          5114
+#define MACH_TYPE_OMAP4_VAR_SOM        5115
 #endif
diff --git a/arch/arm/mach-omap2/omap4/Kconfig b/arch/arm/mach-omap2/omap4/Kconfig
index b320490d666..a170467f452 100644
--- a/arch/arm/mach-omap2/omap4/Kconfig
+++ b/arch/arm/mach-omap2/omap4/Kconfig
@@ -1,6 +1,23 @@
 if OMAP44XX
 
+choice
+	prompt "OMAP4 board select"
+	optional
+	help
+	  Select your OMAP4 board, available boards are:
+	  - TI OMAP4 Variscite SOM
+
+config TARGET_OMAP4_VAR_SOM
+	bool "TI OMAP4 Variscite SOM"
+	help
+	  OMAP4-based system on module.
+	  Boots from the SD card reader
+
+endchoice
+
 config SYS_SOC
 	default "omap4"
 
+source "board/variscite/omap4_var_som/Kconfig"
+
 endif
diff --git a/board/variscite/omap4_var_som/Kconfig b/board/variscite/omap4_var_som/Kconfig
new file mode 100644
index 00000000000..dc943b3366e
--- /dev/null
+++ b/board/variscite/omap4_var_som/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_OMAP4_VAR_SOM
+
+config SYS_BOARD
+	default "omap4_var_som"
+
+config SYS_VENDOR
+	default "variscite"
+
+config SYS_CONFIG_NAME
+	default "ti_omap4_common"
+
+endif
diff --git a/board/variscite/omap4_var_som/MAINTAINERS b/board/variscite/omap4_var_som/MAINTAINERS
new file mode 100644
index 00000000000..a8680bc75d3
--- /dev/null
+++ b/board/variscite/omap4_var_som/MAINTAINERS
@@ -0,0 +1,4 @@
+ARM OMAP4 VARISCITE VAR-SOM-OM44 MODULE
+M:	Bastien Curutchet <bastien.curutchet@bootlin.com>
+S:	Maintained
+N:	omap4_var_som
diff --git a/board/variscite/omap4_var_som/Makefile b/board/variscite/omap4_var_som/Makefile
new file mode 100644
index 00000000000..c88ab3cac7b
--- /dev/null
+++ b/board/variscite/omap4_var_som/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2000, 2001, 2002
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+
+obj-y	:= omap4_var_som.o
diff --git a/board/variscite/omap4_var_som/omap4_var_som.c b/board/variscite/omap4_var_som/omap4_var_som.c
new file mode 100644
index 00000000000..f2fc790dd4b
--- /dev/null
+++ b/board/variscite/omap4_var_som/omap4_var_som.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/mmc_host_def.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/gpio.h>
+#include <asm/emif.h>
+#include <asm/global_data.h>
+#include <asm/mach-types.h>
+#include <asm-generic/gpio.h>
+#include <env.h>
+#include <init.h>
+#include <linux/delay.h>
+#include <log.h>
+#include <serial.h>
+
+#include "omap4_var_som_mux.h"
+
+#define VAR_SOM_REV_GPIO		   52
+
+DECLARE_GLOBAL_DATA_PTR;
+
+const struct omap_sysinfo sysinfo = {
+	"Board: OMAP4 VAR-SOM-OM44\n"
+};
+
+struct omap4_scrm_regs *const scrm = (struct omap4_scrm_regs *)0x4a30a000;
+
+/**
+ * @brief board_init
+ *
+ * Return: 0
+ */
+int board_init(void)
+{
+	gpmc_init();
+
+	gd->bd->bi_arch_number = MACH_TYPE_OMAP4_VAR_SOM;
+	gd->bd->bi_boot_params = (0x80000000 + 0x100); /* boot param addr */
+
+	return 0;
+}
+
+static const struct emif_regs emif_regs_hynix_kdpm_400_mhz_1cs = {
+	.sdram_config_init		= 0x80000eb2,
+	.sdram_config			= 0x80001ab2,
+	.ref_ctrl			= 0x000005cd,
+	.sdram_tim1			= 0x10cb0622,
+	.sdram_tim2			= 0x20350d52,
+	.sdram_tim3			= 0x00b1431f,
+	.read_idle_ctrl			= 0x000501ff,
+	.zq_config			= 0x500b3214,
+	.temp_alert_config		= 0x58016893,
+	.emif_ddr_phy_ctlr_1_init	= 0x049ffff5,
+	.emif_ddr_phy_ctlr_1		= 0x049ff418
+};
+
+const struct emif_regs emif_regs_hynix_kdpm_400_mhz_2cs = {
+	.sdram_config_init		= 0x80000eb9,
+	.sdram_config			= 0x80001ab9,
+	.ref_ctrl			= 0x00000618,
+	.sdram_tim1			= 0x10eb0662,
+	.sdram_tim2			= 0x20370dd2,
+	.sdram_tim3			= 0x00b1c33f,
+	.read_idle_ctrl			= 0x000501ff,
+	.zq_config			= 0xd00b3214,
+	.temp_alert_config		= 0xd8016893,
+	.emif_ddr_phy_ctlr_1_init	= 0x049ffff5,
+	.emif_ddr_phy_ctlr_1		= 0x049ff418
+};
+
+/*
+ * emif_get_reg_dump() - emif_get_reg_dump strong function
+ *
+ * @emif_nr - emif base
+ * @regs - reg dump of timing values
+ *
+ * Strong function to override emif_get_reg_dump weak function in sdram_elpida.c
+ */
+void emif_get_reg_dump(u32 emif_nr, const struct emif_regs **regs)
+{
+	u32 rev;
+
+	gpio_direction_input(VAR_SOM_REV_GPIO);
+	rev = gpio_get_value(VAR_SOM_REV_GPIO);
+
+	if (rev == 1)
+		*regs = &emif_regs_hynix_kdpm_400_mhz_1cs;
+	else
+		*regs = &emif_regs_hynix_kdpm_400_mhz_2cs;
+}
+
+void emif_get_dmm_regs(const struct dmm_lisa_map_regs
+						**dmm_lisa_regs)
+{
+	u32 omap_rev = omap_revision();
+
+	if (omap_rev == OMAP4430_ES1_0)
+		*dmm_lisa_regs = &lisa_map_2G_x_1_x_2;
+	else if (omap_rev == OMAP4430_ES2_3)
+		*dmm_lisa_regs = &lisa_map_2G_x_2_x_2;
+	else if (omap_rev < OMAP4460_ES1_0)
+		*dmm_lisa_regs = &lisa_map_2G_x_2_x_2;
+	else
+		*dmm_lisa_regs = &ma_lisa_map_2G_x_2_x_2;
+}
+
+void emif_get_device_timings(u32 emif_nr,
+			     const struct lpddr2_device_timings **cs0_device_timings,
+			     const struct lpddr2_device_timings **cs1_device_timings)
+{
+	/* Identical devices on EMIF1 & EMIF2 */
+	*cs0_device_timings = &elpida_2G_S4_timings;
+	*cs1_device_timings = NULL;
+}
+
+/**
+ * @brief misc_init_r() - VAR-SOM configuration
+ *
+ * Configure VAR-SOM board specific configurations such as power configurations.
+ *
+ * Return: 0
+ */
+int misc_init_r(void)
+{
+	u32 auxclk, altclksrc;
+
+	auxclk = readl(&scrm->auxclk3);
+	/* Select sys_clk */
+	auxclk &= ~AUXCLK_SRCSELECT_MASK;
+	auxclk |=  AUXCLK_SRCSELECT_SYS_CLK << AUXCLK_SRCSELECT_SHIFT;
+	/* Set the divisor to 2 */
+	auxclk &= ~AUXCLK_CLKDIV_MASK;
+	auxclk |= AUXCLK_CLKDIV_2 << AUXCLK_CLKDIV_SHIFT;
+	/* Request auxilary clock #3 */
+	auxclk |= AUXCLK_ENABLE_MASK;
+
+	writel(auxclk, &scrm->auxclk3);
+
+	altclksrc = readl(&scrm->altclksrc);
+
+	/* Activate alternate system clock supplier */
+	altclksrc &= ~ALTCLKSRC_MODE_MASK;
+	altclksrc |= ALTCLKSRC_MODE_ACTIVE;
+
+	/* enable clocks */
+	altclksrc |= ALTCLKSRC_ENABLE_INT_MASK | ALTCLKSRC_ENABLE_EXT_MASK;
+
+	writel(altclksrc, &scrm->altclksrc);
+
+	return 0;
+}
+
+void set_muxconf_regs(void)
+{
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		do_set_mux((*ctrl)->control_padconf_core_base,
+			   core_padconf_array_essential,
+			   sizeof(core_padconf_array_essential) /
+			   sizeof(struct pad_conf_entry));
+
+		do_set_mux((*ctrl)->control_padconf_wkup_base,
+			   wkup_padconf_array_essential,
+			   sizeof(wkup_padconf_array_essential) /
+			   sizeof(struct pad_conf_entry));
+	}
+}
+
+int board_mmc_init(struct bd_info *bis)
+{
+	if (IS_ENABLED(CONFIG_MMC))
+		return omap_mmc_init(0, 0, 0, -1, -1);
+}
diff --git a/board/variscite/omap4_var_som/omap4_var_som_mux.h b/board/variscite/omap4_var_som/omap4_var_som_mux.h
new file mode 100644
index 00000000000..fe0b99daf75
--- /dev/null
+++ b/board/variscite/omap4_var_som/omap4_var_som_mux.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _VAR_SOM_OM44_MUX_DATA_H_
+#define _VAR_SOM_OM44_MUX_DATA_H_
+
+#include <asm/arch/mux_omap4.h>
+
+const struct pad_conf_entry core_padconf_array_essential[] = {
+{GPMC_AD0, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)},  /* sdmmc2_dat0 */
+{GPMC_AD1, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)},  /* sdmmc2_dat1 */
+{GPMC_AD2, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)},  /* sdmmc2_dat2 */
+{GPMC_AD3, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)},  /* sdmmc2_dat3 */
+{GPMC_NCS2, (PTD | IEN | M3)},  /* gpio52 som rev */
+{GPMC_NOE, (PTU | IEN | OFF_EN | OFF_OUT_PTD | M1)},  /* sdmmc2_clk */
+{GPMC_NWE, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)},  /* sdmmc2_cmd */
+{I2C1_SCL, (PTU | IEN | M0)},  /* i2c1_scl */
+{I2C1_SDA, (PTU | IEN | M0)},  /* i2c1_sda */
+{UART3_RX_IRRX, (IEN | M0)},  /* uart3_rx */
+{UART3_TX_IRTX, (M0)},  /* uart3_tx */
+};
+
+const struct pad_conf_entry wkup_padconf_array_essential[] = {
+{PAD0_FREF_CLK3_OUT, (M0)}, /* fref_clk3_out */
+{PAD0_FREF_SLICER_IN, (M0)},  /* fref_slicer_in */
+{PAD1_FREF_CLK_IOREQ, (M0)},  /* fref_clk_ioreq */
+{PAD0_FREF_CLK0_OUT, (M2)},  /* sys_drm_msecure */
+{PAD1_SYS_32K, (IEN | M0)},  /* sys_32k */
+{PAD0_SYS_NRESPWRON, (M0)},  /* sys_nrespwron */
+{PAD1_SYS_NRESWARM, (M0)},  /* sys_nreswarm */
+{PAD0_SYS_PWR_REQ, (PTU | M0)},  /* sys_pwr_req */
+};
+
+#endif /* _VAR_SOM_OM44_MUX_DATA_H_ */
diff --git a/configs/omap4_var_som_defconfig b/configs/omap4_var_som_defconfig
new file mode 100644
index 00000000000..e906b98025d
--- /dev/null
+++ b/configs/omap4_var_som_defconfig
@@ -0,0 +1,75 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2_PL310=y
+CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_INITRD_TAG=y
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030df00
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap4-var-stk-om44"
+CONFIG_OMAP44XX=y
+CONFIG_TARGET_OMAP4_VAR_SOM=y
+CONFIG_SPL_TEXT_BASE=0x40300000
+CONFIG_SPL=y
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_EFILOADER is not set
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_DEFAULT_FDT_FILE="omap4-var-stk-om44"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_MAX_SIZE=0xbc00
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_HUSH_PARSER=y
+# CONFIG_BOOTM_EFI is not set
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_BOOTEFI is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_SPL=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_ISO_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NO_NET=y
+CONFIG_DM_WARN=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+# CONFIG_INPUT is not set
+CONFIG_MMC_OMAP_HS=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_REGULATOR=y
+# CONFIG_SPL_SERIAL_PRESENT is not set
+CONFIG_CONS_INDEX=3
+CONFIG_DM_SERIAL=y
+CONFIG_EXT4_WRITE=y
+CONFIG_SPL_CRC8=y

-- 
2.54.0

