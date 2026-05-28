Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3267FCD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 12:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DA983FF5;
	Thu, 28 May 2026 14:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="tu75DPzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B2D8469D; Thu, 28 May 2026 14:57:40 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 196AF803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 14:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id A57D3B0057C;
 Thu, 28 May 2026 14:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779973057;
 bh=eCr8jyc2AHMDwidqXCdISBo1v2WlmAs2DN7YZfV/2BQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tu75DPzgveMlt9Burd45c7Ua4J9qIu6qIgv3ETJr4W657Z1AqCuhgTSKqfJWQxULd
 H5LFMhvCJx5/A7OpoqG64k9Xv7kL56RxEUx/p0bIbx/BW5gE2eZkn6D+m+XmCkEYuq
 Cj6VfZz1OfSGTyXxEWYDGGJ16VDdG8RPU4VZbEK1GBKhD0rbAdIuoBiVlQx9z061xn
 +F3x/7I2RAMUCroc5w4Z069OLTRAAvmQPMgU0lHBuP6/zPUjvdnSYjDYc2OoPRZIby
 31pd18ovW84Fs4vM+cwWuAzDL4bBOJQWb8lhyT1W8M1zRfLYesrnM0Yrx4z1da28bx
 laI7Bf1kVzmtg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@oss.nxp.com>, David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2] thermal: imx_tmu: extend with QorIQ/Layerscape TMU
Date: Thu, 28 May 2026 14:57:07 +0200
Message-ID: <20260528125712.716561-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <"<20260527134744.511819-1-vjardin@free.fr>">
References: <"<20260527134744.511819-1-vjardin@free.fr>">
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

Add support for the on-die Thermal Monitoring Unit (TMU) of the
new QorIQ/Layerscape SoCs (LX2160A, LS1028A, LS1088A, ...):

examples on a lx2160:
  => temperature list
  | Device                  | Driver  | Parent
  | tmu@1f80000             | imx_tmu | root_driver
  | cluster67-thermal       | imx_tmu | tmu@1f80000
  | ddr1-cluster5-thermal   | imx_tmu | tmu@1f80000
  | wriop-thermal           | imx_tmu | tmu@1f80000
  | dce-qbman-hsio2-thermal | imx_tmu | tmu@1f80000
  | ccn-dpaa-tbu-thermal    | imx_tmu | tmu@1f80000
  | cluster4-hsio3-thermal  | imx_tmu | tmu@1f80000
  | cluster23-thermal       | imx_tmu | tmu@1f80000

  => temperature get tmu@1f80000
  tmu@1f80000: 82000 mC

  => temperature get wriop-thermal
  wriop-thermal: 81000 mC

The parent tmu@... node owns the MMIO and calibration; one
UCLASS_THERMAL device is bound per/thermal-zones site so each shows
up by its zone name:

  => dm tree
   ...
   thermal   2  [ + ]   imx_tmu   |-- tmu@1f80000
   thermal   3  [ + ]   imx_tmu   |   |-- cluster67-thermal
   thermal   4  [ + ]   imx_tmu   |   |-- ddr1-cluster5-thermal
   thermal   5  [ + ]   imx_tmu   |   |-- wriop-thermal
   thermal   6  [ + ]   imx_tmu   |   |-- dce-qbman-hsio2-thermal
   thermal   7  [ + ]   imx_tmu   |   |-- ccn-dpaa-tbu-thermal
   thermal   8  [ + ]   imx_tmu   |   |-- cluster4-hsio3-thermal
   thermal   9  [ + ]   imx_tmu   |   `-- cluster23-thermal
   ...

The dtsi additions mirror the existing fsl-ls1028a.dtsi: the LX2160A
SoC dtsi gains the tmu@1f80000 node plus a thermal-zones hierarchy
with 7 sites:

  cluster67-thermal       site 0  A72 clusters 6 + 7
  ddr1-cluster5-thermal   site 1  DDR1 + A72 cluster 5
  wriop-thermal           site 2  WRIOP
  dce-qbman-hsio2-thermal site 3  DCE + QBMAN + HSIO2
  ccn-dpaa-tbu-thermal    site 4  CCN508 + DPAA + TBU
  cluster4-hsio3-thermal  site 5  A72 cluster 4 + HSIO3
  cluster23-thermal       site 6  A72 clusters 2 + 3

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Suggested-by: Tom Rini <trini@konsulko.com>
Inspired-by: Peng Fan <peng.fan@oss.nxp.com>

---

Changes in v2:
- Per Tom Rini's challenge: fold the QorIQ TMU into the existing
  drivers/thermal/imx_tmu.c, it is surgery.
- Provide get_cpu_temp_grade() on the Layerscape side
Patch-cc: Peng Fan <peng.fan@oss.nxp.com>
Patch-cc: Tom Rini <trini@konsulko.com>

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |  21 +++
 arch/arm/dts/fsl-lx2160a.dtsi                 |  58 ++++++++
 .../asm/arch-fsl-layerscape/sys_proto.h       |  30 +++++
 drivers/thermal/Kconfig                       |   9 +-
 drivers/thermal/imx_tmu.c                     | 125 +++++++++++++++++-
 5 files changed, 238 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-fsl-layerscape/sys_proto.h

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index cfbaa475701..7bd54cf1253 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -986,6 +986,27 @@ uint get_svr(void)
 }
 #endif
 
+/*
+ * Layerscape mirror of the i.MX get_cpu_temp_grade(). i.MX reads the
+ * OCOTP "CPU temp grade" fuses; Layerscape has no such fuse, so the
+ * limits come from the data sheet instead. LX2160A Reference Manual
+ * Rev. 1 (10/2021) section 1.12.1 specifies the maximum operating
+ * junction temperature at 105 degC for commercial / embedded parts;
+ * the lower bound is the standard -40 degC commercial low.
+ *
+ * The TMU itself is documented as accurate within +/- 3 degC (RM
+ * section 28.1), which the thermal driver clears by setting its
+ * alert threshold 10 degC below critical.
+ */
+u32 get_cpu_temp_grade(int *minc, int *maxc)
+{
+	if (minc)
+		*minc = -40;
+	if (maxc)
+		*maxc = 105;
+	return 0; /* commercial */
+}
+
 #ifdef CONFIG_DISPLAY_CPUINFO
 int print_cpuinfo(void)
 {
diff --git a/arch/arm/dts/fsl-lx2160a.dtsi b/arch/arm/dts/fsl-lx2160a.dtsi
index 680c69c7b73..e27839124f0 100644
--- a/arch/arm/dts/fsl-lx2160a.dtsi
+++ b/arch/arm/dts/fsl-lx2160a.dtsi
@@ -594,6 +594,64 @@
 		};
 	};
 
+	/* LX2160ARM Chapter 28 ("Thermal Monitoring Unit") */
+	tmu: tmu@1f80000 {
+		compatible = "fsl,qoriq-tmu";
+		reg = <0x0 0x1f80000 0x0 0x10000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,tmu-range = <0x800000e6 0x8001017d>;
+		fsl,tmu-calibration = <0x00000000 0x00000035
+				       0x00000001 0x00000154>;
+		little-endian;
+		#thermal-sensor-cells = <1>;
+		label = "lx2160a-tmu"; /* explicit naming */
+	};
+
+	/* explicit thermal-zones names per LX2160ARM Table 323 */
+	thermal-zones {
+		cluster67-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 0>;
+		};
+
+		ddr1-cluster5-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
+		};
+
+		wriop-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 2>;
+		};
+
+		dce-qbman-hsio2-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 3>;
+		};
+
+		ccn-dpaa-tbu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 4>;
+		};
+
+		cluster4-hsio3-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 5>;
+		};
+
+		cluster23-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 6>;
+		};
+	};
+
 	/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
 	emdio1: mdio@8b96000 {
 		compatible = "fsl,ls-mdio";
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/sys_proto.h b/arch/arm/include/asm/arch-fsl-layerscape/sys_proto.h
new file mode 100644
index 00000000000..3b78e73c726
--- /dev/null
+++ b/arch/arm/include/asm/arch-fsl-layerscape/sys_proto.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Layerscape mirror of the i.MX <asm/mach-imx/sys_proto.h>: declares
+ * the SoC-personality helpers consumed by generic drivers that work on
+ * both i.MX and QorIQ/Layerscape parts (e.g. drivers/thermal/imx_tmu.c
+ * for the QorIQ TMU variant).
+ */
+
+#ifndef _ASM_ARCH_FSL_LAYERSCAPE_SYS_PROTO_H
+#define _ASM_ARCH_FSL_LAYERSCAPE_SYS_PROTO_H
+
+#include <linux/types.h>
+
+/*
+ * Per LX2160A Reference Manual, Rev. 1 (10/2021):
+ *  - section 1.12.1: "NXP specs max power at 105 degC junction" for
+ *    commercial / embedded operating conditions.
+ *  - section 28.1:   TMU "Accuracy within +/- 3 degC".
+ *
+ * Layerscape SoCs do not expose an OCOTP-style "CPU temp grade" fuse,
+ * so the implementation returns the documented junction-temperature
+ * limit from the data sheet (-40 .. 105 degC commercial range). The
+ * thermal driver subtracts 10 degC for its alert threshold, which
+ * comfortably clears the +/- 3 degC TMU accuracy in both directions.
+ */
+u32 get_cpu_temp_grade(int *minc, int *maxc);
+
+#endif /* _ASM_ARCH_FSL_LAYERSCAPE_SYS_PROTO_H */
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91c39aa4dee..47eee475e8d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -27,11 +27,12 @@ config IMX_SCU_THERMAL
 	  trip is crossed
 
 config IMX_TMU
-        bool "Thermal Management Unit driver for NXP i.MX8M and iMX93"
-        depends on ARCH_IMX8M || IMX93
+	bool "Thermal Management Unit driver for NXP i.MX8M / i.MX93 and QorIQ"
+	depends on ARCH_IMX8M || IMX93 || FSL_LAYERSCAPE
         help
-          Support for Temperature sensors on NXP i.MX8M and iMX93.
-          It supports one critical trip point and one passive trip point.
+	  Support for the NXP Thermal Management Unit (TMU) sensors on
+	  i.MX8M, i.MX93 and on QorIQ/Layerscape SoCs (LX2160A,
+	  LS1028A, LS1088A, ...).
 	  The boot is hold to the cool device to throttle CPUs when the
 	  passive trip is crossed
 
diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 1bde4d07f52..da0825ecd34 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -6,14 +6,17 @@
 
 #include <config.h>
 #include <asm/io.h>
-#include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
+#if IS_ENABLED(CONFIG_ARCH_IMX8M) || IS_ENABLED(CONFIG_IMX93)
+#include <asm/arch/clock.h>
+#endif
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/device.h>
 #include <errno.h>
 #include <fuse.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <malloc.h>
 #include <thermal.h>
@@ -22,10 +25,12 @@
 #define FLAGS_VER2	0x1
 #define FLAGS_VER3	0x2
 #define FLAGS_VER4	0x4
+#define FLAGS_QORIQ	0x8
 
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define QORIQ_TMR_ALPF	(0x3 << 24)	/* QorIQ ALPF lives at bits[25:24] */
 #define TMTMIR_DEFAULT	0x00000002
 #define TIER_DISABLE	0x0
 
@@ -33,7 +38,19 @@
 #define TER_ADC_PD		0x40000000
 #define TER_ALPF		0x3
 
+/* default CPU delay time to cool down if over temperature */
 #define IMX_TMU_POLLING_DELAY_MS	5000
+
+/* TRITSR - QorIQ Immediate Temperature Site Register.
+ *
+ * Per LX2160A Reference Manual, Rev. 1 (10/2021) section 28.3.1.24
+ * the calibrated reading lives in TEMP[8:0] and is reported in
+ * degrees Kelvin (integer). The QorIQ regs_v1 variant has no
+ * fractional 0.5 degC bit, unlike the i.MX regs_v2 / VER4 layouts.
+ */
+#define TRITSR_V		BIT(31)		/* reading valid */
+#define TRITSR_TEMP_MASK	GENMASK(8, 0)	/* degrees Kelvin */
+#define TRITSR_KELVIN_OFFSET	273		/* TEMP[8:0] - 273 = degC */
 /*
  * i.MX TMU Registers
  */
@@ -148,11 +165,37 @@ struct imx_tmu_regs_v3 {
 	u32 trim;
 };
 
+/*
+ * fsl,qoriq-tmu (LX2160A, LS1028A, LS1088A, ...). Same TMU IP family as
+ * the i.MX "regs_v1" layout but: site-enable is a discrete TMSR at 0x08
+ * (TMTMIR moves to 0x0C), and the temperature range registers are
+ * variable-length at 0xF10 (a SoC may use fewer than 16). Calibration is
+ * taken from the DT (fsl,tmu-range / fsl,tmu-calibration) exactly like
+ * the i.MX regs_v1 path, so qoriq reuses imx_tmu_calibration()'s scheme.
+ */
+struct qoriq_tmu_regs {
+	u32 tmr;		/* 0x000 mode */
+	u32 tsr;		/* 0x004 status */
+	u32 tmsr;		/* 0x008 monitor-site enable (bit N = site N) */
+	u32 tmtmir;		/* 0x00C measurement interval */
+	u8 res0[0x10];
+	u32 tier;		/* 0x020 interrupt enable */
+	u32 tidr;		/* 0x024 interrupt detect */
+	u8 res1[0x58];
+	u32 ttcfgr;		/* 0x080 temperature config (cal walk) */
+	u32 tscfgr;		/* 0x084 sensor config (cal walk) */
+	u8 res2[0x78];
+	struct imx_tmu_site_regs site[SITES_MAX]; /* 0x100 */
+	u8 res3[0xd10];
+	u32 ttrcr[16];		/* 0xF10 temperature range control */
+};
+
 union tmu_regs {
 	struct imx_tmu_regs regs_v1;
 	struct imx_tmu_regs_v2 regs_v2;
 	struct imx_tmu_regs_v3 regs_v3;
 	struct imx_tmu_regs_v4 regs_v4;
+	struct qoriq_tmu_regs regs_qoriq;
 };
 
 struct imx_tmu_plat {
@@ -189,6 +232,9 @@ static int read_temperature(struct udevice *dev, int *temp)
 		} else if (drv_data & FLAGS_VER4) {
 			val = readl(&pdata->regs->regs_v4.tritsr0);
 			valid = val & 0x80000000;
+		} else if (drv_data & FLAGS_QORIQ) {
+			val = readl(&pdata->regs->regs_qoriq.site[pdata->id].tritsr);
+			valid = val & TRITSR_V;
 		} else {
 			val = readl(&pdata->regs->regs_v1.site[pdata->id].tritsr);
 			valid = val & 0x80000000;
@@ -213,6 +259,19 @@ static int read_temperature(struct udevice *dev, int *temp)
 
 			/* Convert Kelvin to Celsius */
 			*temp -= 273000;
+		} else if (drv_data & FLAGS_QORIQ) {
+			/*
+			 * LX2160A Reference Manual, Rev. 1 (10/2021)
+			 * section 28.3.1.24: TEMP[8:0] is the calibrated
+			 * reading in degrees Kelvin (integer, no 0.5 degC
+			 * bit on the regs_v1 variant). The calibration
+			 * point examples in the same RM section 28.1.3
+			 * use the same Kelvin/Celsius offset:
+			 *   TTR0CR=0x800000E6 -> 230K (-43 degC)
+			 *   TTR1CR=0x8001017D -> 381K (108 degC)
+			 */
+			*temp = ((val & TRITSR_TEMP_MASK) -
+				 TRITSR_KELVIN_OFFSET) * 1000;
 		} else {
 			*temp = (val & 0xff) * 1000;
 		}
@@ -265,6 +324,35 @@ static int imx_tmu_calibration(struct udevice *dev)
 	if (drv_data & (FLAGS_VER2 | FLAGS_VER3))
 		return 0;
 
+	if (drv_data & FLAGS_QORIQ) {
+		const fdt32_t *ranges;
+		int n;
+
+		ranges = dev_read_prop(dev, "fsl,tmu-range", &len);
+		if (!ranges || len % 4 ||
+		    len / 4 > (int)ARRAY_SIZE(pdata->regs->regs_qoriq.ttrcr)) {
+			dev_err(dev, "TMU: missing/invalid fsl,tmu-range\n");
+			return -ENODEV;
+		}
+		n = len / 4;
+		for (i = 0; i < n; i++)
+			writel(fdt32_to_cpu(ranges[i]),
+			       &pdata->regs->regs_qoriq.ttrcr[i]);
+
+		calibration = dev_read_prop(dev, "fsl,tmu-calibration", &len);
+		if (!calibration || len % 8) {
+			dev_err(dev, "TMU: invalid calibration data.\n");
+			return -ENODEV;
+		}
+		for (i = 0; i < len; i += 8, calibration += 2) {
+			writel(fdt32_to_cpu(*calibration),
+			       &pdata->regs->regs_qoriq.ttcfgr);
+			writel(fdt32_to_cpu(*(calibration + 1)),
+			       &pdata->regs->regs_qoriq.tscfgr);
+		}
+		return 0;
+	}
+
 	if (drv_data & FLAGS_VER4) {
 		calibration = dev_read_prop(dev, "fsl,tmu-calibration", &len);
 		if (!calibration || len % 8 || len > 128) {
@@ -402,6 +490,18 @@ static inline void imx_tmu_mx8mq_init(struct udevice *dev) { }
 
 static void imx_tmu_arch_init(struct udevice *dev)
 {
+	/*
+	 * QorIQ takes its calibration from the DT (fsl,tmu-calibration),
+	 * not from OCOTP fuses, so it has no per-SoC arch init. The #if
+	 * below is still required: the i.MX SoC-ID helpers and fuse API
+	 * (<asm/arch/sys_proto.h>) do not exist in a Layerscape build, so
+	 * the references must be removed at compile time, not merely
+	 * skipped at runtime.
+	 */
+	if (dev_get_driver_data(dev) & FLAGS_QORIQ)
+		return;
+
+#if IS_ENABLED(CONFIG_ARCH_IMX8M) || IS_ENABLED(CONFIG_IMX93)
 	if (is_imx8mm() || is_imx8mn())
 		imx_tmu_mx8mm_mx8mn_init(dev);
 	else if (is_imx8mp())
@@ -412,6 +512,7 @@ static void imx_tmu_arch_init(struct udevice *dev)
 		imx_tmu_mx8mq_init(dev);
 	else
 		dev_err(dev, "Unsupported SoC, TMU calibration not loaded!\n");
+#endif
 }
 
 static void imx_tmu_init(struct udevice *dev)
@@ -443,6 +544,15 @@ static void imx_tmu_init(struct udevice *dev)
 
 		/* Set update_interval */
 		writel(TMTMIR_DEFAULT, &pdata->regs->regs_v4.tmtmir);
+	} else if (drv_data & FLAGS_QORIQ) {
+		/* Disable monitoring */
+		writel(TMR_DISABLE, &pdata->regs->regs_qoriq.tmr);
+
+		/* Disable interrupt, using polling instead */
+		writel(TIER_DISABLE, &pdata->regs->regs_qoriq.tier);
+
+		/* Set update_interval */
+		writel(TMTMIR_DEFAULT, &pdata->regs->regs_qoriq.tmtmir);
 	} else {
 		/* Disable monitoring */
 		writel(TMR_DISABLE, &pdata->regs->regs_v1.tmr);
@@ -511,6 +621,18 @@ static int imx_tmu_enable_msite(struct udevice *dev)
 		/* Enable ME */
 		reg |= TMR_ME;
 		writel(reg, &pdata->regs->regs_v4.tmr);
+	} else if (drv_data & FLAGS_QORIQ) {
+		/* Clear ME, enable every site at once via the discrete TMSR */
+		reg = readl(&pdata->regs->regs_qoriq.tmr);
+		reg &= ~TMR_ME;
+		writel(reg, &pdata->regs->regs_qoriq.tmr);
+
+		writel(GENMASK(SITES_MAX - 1, 0),
+		       &pdata->regs->regs_qoriq.tmsr);
+
+		reg |= QORIQ_TMR_ALPF;
+		reg |= TMR_ME;
+		writel(reg, &pdata->regs->regs_qoriq.tmr);
 	} else {
 		/* Clear the ME before setting MSITE and ALPF*/
 		reg = readl(&pdata->regs->regs_v1.tmr);
@@ -650,6 +772,7 @@ static const struct udevice_id imx_tmu_ids[] = {
 	{ .compatible = "fsl,imx8mm-tmu", .data = FLAGS_VER2, },
 	{ .compatible = "fsl,imx8mp-tmu", .data = FLAGS_VER3, },
 	{ .compatible = "fsl,imx93-tmu", .data = FLAGS_VER4, },
+	{ .compatible = "fsl,qoriq-tmu", .data = FLAGS_QORIQ, },
 	{ }
 };
 
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/thermal-qoriq-v2
