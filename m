Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D7CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 13:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BB1839A8;
	Wed, 27 May 2026 15:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="lINmYq6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945E28469D; Wed, 27 May 2026 15:48:11 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E13803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7FFBBB005A4;
 Wed, 27 May 2026 15:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779889688;
 bh=FBKigCXjHrKPrqWJ4Q2TbvHHK2HGpGHN8U85OGIj+LQ=;
 h=From:To:Cc:Subject:Date:From;
 b=lINmYq6sedID1DOM8U6HuJSH9llcrbRqTnfCZKpWWtkjBWbtMueMN+4QRwH2bG+RO
 gDxvIURYwD74Tso1spFs+TjU7Yhi4u6ejO0oWOe8bv4Q4cFiRfkgsO1oPLBxwbn3ny
 BHloMmf2FH1dk1MqAxcKmpD4uyCU3dTFmT/a9ztcitd5fglCMZYJsBuwBxJSHWn8oP
 oGjZzZ7ytd2fhTxKFFZRFrVkxfWJY2zjl0XdY7BN+L2IixvNhhyVud0YjfIcJAwUQs
 hcIkJ3RZu/YVsRtDUZ43EfGKNpLGLhIVAuDPU5yiuVcmBkqhY9hSXeMJEbYUSQ+nX/
 HgRQYwtDEOWEA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Peng Fan <peng.fan@oss.nxp.com>, Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v1] thermal: qoriq: add Layerscape on-die TMU
Date: Wed, 27 May 2026 15:46:45 +0200
Message-ID: <20260527134744.511819-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

Add the support for lx2160 and other layerscape for:
  => temperature list
     | cluster67-thermal   | qoriq_thermal | tmu@1f80000
     | ddr1-cluster5-...   | qoriq_thermal | tmu@1f80000
     ...

  => temperature get cluster67-thermal
     cluster67-thermal: 56000 mC

It is designed as a generic UCLASS_THERMAL driver for the
QorIQ/Layerscape on-die Thermal Monitoring Unit (TMU).

It is similar to the "regs_v1" variant already implemented in
drivers/thermal/imx_tmu.c, but the i.MX driver depends
on <asm/arch/clock.h>, is_imx8m*() arch helpers, and OCOTP fuse
reads that do not exist on Layerscape.

Rather than #ifdef the QorIQ bits, this driver is a clean Layerscape
counterpart binding the standard "fsl,qoriq-tmu" compatible used by
the Linux qoriq_thermal driver and by the existing fsl-ls10{28,88}a
DTSIs too!
The dtsi additions mirror the existing fsl-ls1028a.dtsi

For example, the LX2160A SoC dtsi gains the tmu@1f80000 node plus a
thermal-zones hierarchy with 7 sites:

  cluster67-thermal       site 0  A72 clusters 6 + 7
  ddr1-cluster5-thermal   site 1  DDR1 + A72 cluster 5
  wriop-thermal           site 2  WRIOP
  dce-qbman-hsio2-thermal site 3  DCE + QBMAN + HSIO2
  ccn-dpaa-tbu-thermal    site 4  CCN508 + DPAA + TBU
  cluster4-hsio3-thermal  site 5  A72 cluster 4 + HSIO3
  cluster23-thermal       site 6  A72 clusters 2 + 3

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 MAINTAINERS                     |   5 +
 arch/arm/dts/fsl-lx2160a.dtsi   |  58 +++++++
 drivers/thermal/Kconfig         |   8 +
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/qoriq_thermal.c | 283 ++++++++++++++++++++++++++++++++
 5 files changed, 355 insertions(+)
 create mode 100644 drivers/thermal/qoriq_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..fb2d834e432 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1521,6 +1521,11 @@ M:	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
 S:	Maintained
 F:	drivers/net/phy/nxp-c45-tja11xx.c
 
+NXP QORIQ / LAYERSCAPE THERMAL
+M:	Vincent Jardin <vjardin@free.fr>
+S:	Maintained
+F:	drivers/thermal/qoriq_thermal.c
+
 ONENAND
 #M:	Lukasz Majewski <l.majewski@majess.pl>
 S:	Orphaned (Since 2017-01)
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
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91c39aa4dee..1a2e2884591 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -55,4 +55,12 @@ config TI_LM74_THERMAL
 	 Enable thermal support for the Texas Instruments LM74 chip.
 	 The driver supports reading CPU temperature.
 
+config QORIQ_THERMAL
+	bool "NXP QorIQ / Layerscape on-die TMU"
+	depends on FSL_LAYERSCAPE || ARCH_LS1028A || ARCH_LS1088A
+	help
+	  Enable support for the on-die Thermal Monitoring Unit (TMU)
+	  found in NXP QorIQ / Layerscape SoCs (LX2160A, LS1088A,
+	  LS1028A, etc.).
+
 endif # if DM_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b6f06c00ed9..5a6a8064e68 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_RCAR_GEN3_THERMAL) += rcar_gen3_thermal.o
 obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
 obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
 obj-$(CONFIG_TI_LM74_THERMAL) += ti-lm74.o
+obj-$(CONFIG_QORIQ_THERMAL) += qoriq_thermal.o
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
new file mode 100644
index 00000000000..dce0f7d5d0f
--- /dev/null
+++ b/drivers/thermal/qoriq_thermal.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * NXP QorIQ / Layerscape Thermal Monitoring Unit (TMU) driver.
+ *
+ * Same on-die TMU IP block shared by LX2160A, LS1088A, LS1028A and
+ * other QorIQ / Layerscape SoCs.
+ *
+ * DT binding (variable-length range/calibration so SoCs needing
+ * fewer than 4 ranges, e.g. the LX2160A only uses 2 -- bind
+ * cleanly):
+ *
+ *   tmu: tmu@1f80000 {
+ *           compatible = "fsl,qoriq-tmu";
+ *           reg = <0x0 0x1f80000 0x0 0x10000>;
+ *           fsl,tmu-range = <range0 [range1 [range2 [range3]]]>;
+ *           fsl,tmu-calibration = <cfg0 sensor0 cfg1 sensor1 ...>;
+ *           #thermal-sensor-cells = <1>;
+ *           little-endian;
+ *   };
+ *
+ *   thermal-zones {
+ *           cluster67-thermal {
+ *                   thermal-sensors = <&tmu 0>;
+ *           };
+ *           ...
+ *   };
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <thermal.h>
+#include <asm/io.h>
+
+#define QORIQ_TMU_SITES_MAX	16
+
+#define TMR_DISABLE		0x0
+#define TMR_MODE_MONITOR	BIT(31)
+#define TMR_ALPF		(0x3 << 24)	/* heaviest filter (0.125) */
+
+#define TMTMIR_DEFAULT		0x00000002
+#define TIER_DISABLE		0x0
+
+#define TRITSR_V		BIT(31)
+#define TRITSR_TEMP_MASK	GENMASK(7, 0)
+
+#define QORIQ_TMU_READ_RETRIES	10
+#define QORIQ_TMU_READ_DELAY_MS	100
+
+struct qoriq_tmu_site_regs {
+	u32 tritsr;
+	u32 tratsr;
+	u8 res[0x8];
+};
+
+struct qoriq_tmu_regs {
+	u32 tmr;		/* 0x000 mode */
+	u32 tsr;		/* 0x004 status */
+	u32 tmsr;		/* 0x008 monitor-site enable (bit N = site N) */
+	u32 tmtmir;		/* 0x00C measurement interval */
+	u8 res0[0x10];		/* 0x010..0x01F */
+	u32 tier;		/* 0x020 interrupt enable */
+	u32 tidr;		/* 0x024 interrupt detect (W1C) */
+	u8 res1[0x8];		/* 0x028..0x02F */
+	u32 tiiscr;		/* 0x030 immediate site capture */
+	u32 tiascr;		/* 0x034 average site capture */
+	u32 ticscr;		/* 0x038 critical site capture */
+	u8 res2[0x4];		/* 0x03C */
+	u32 tmhtcr;		/* 0x040 high-temp capture */
+	u32 tmltcr;		/* 0x044 low-temp capture */
+	u32 tmrtrcr;		/* 0x048 rising-rate capture */
+	u32 tmftrcr;		/* 0x04C falling-rate capture */
+	u32 tmhtitr;		/* 0x050 high immediate threshold */
+	u32 tmhtatr;		/* 0x054 high average threshold */
+	u32 tmhtactr;		/* 0x058 high average critical threshold */
+	u8 res3[0x4];		/* 0x05C */
+	u32 tmltitr;		/* 0x060 low immediate threshold */
+	u32 tmltatr;		/* 0x064 low average threshold */
+	u32 tmltactr;		/* 0x068 low average critical threshold */
+	u8 res4[0x4];		/* 0x06C */
+	u32 tmrtrctr;		/* 0x070 rising-rate critical threshold */
+	u32 tmftrctr;		/* 0x074 falling-rate critical threshold */
+	u8 res5[0x8];		/* 0x078..0x07F */
+	u32 ttcfgr;		/* 0x080 temperature config (cal walk) */
+	u32 tscfgr;		/* 0x084 sensor config (cal walk) */
+	u8 res6[0x78];		/* 0x088..0x0FF */
+	struct qoriq_tmu_site_regs site[QORIQ_TMU_SITES_MAX]; /* 0x100..0x1FF */
+	u8 res7[0xd10];		/* 0x200..0xF0F */
+	u32 ttrcr[16];		/* 0xF10..0xF4C temperature range control */
+};
+
+struct qoriq_tmu_plat {
+	struct qoriq_tmu_regs *regs;
+	int id;		/* zone children: TMU site index, eg 0..6 */
+};
+
+static int qoriq_tmu_get_temp(struct udevice *dev, int *temp)
+{
+	struct qoriq_tmu_plat *pdata = dev_get_plat(dev);
+	u32 val = 0;
+	int retry = QORIQ_TMU_READ_RETRIES;
+
+	do {
+		mdelay(QORIQ_TMU_READ_DELAY_MS);
+		val = readl(&pdata->regs->site[pdata->id].tritsr);
+	} while (!(val & TRITSR_V) && --retry > 0);
+
+	if (!(val & TRITSR_V))
+		return -EIO;
+
+	/* TRITSRn[7:0] is the temperature in degrees C. Convert to mC. */
+	*temp = (val & TRITSR_TEMP_MASK) * 1000;
+	return 0;
+}
+
+static const struct dm_thermal_ops qoriq_tmu_ops = {
+	.get_temp	= qoriq_tmu_get_temp,
+};
+
+static int qoriq_tmu_calibration(struct udevice *dev)
+{
+	struct qoriq_tmu_plat *pdata = dev_get_plat(dev);
+	const fdt32_t *prop;
+	int len, i, n;
+
+	prop = dev_read_prop(dev, "fsl,tmu-range", &len);
+	if (!prop || len % 4 || len / 4 > ARRAY_SIZE(pdata->regs->ttrcr)) {
+		dev_err(dev, "TMU: missing or invalid fsl,tmu-range\n");
+		return -ENODEV;
+	}
+
+	n = len / 4;
+	for (i = 0; i < n; i++)
+		writel(fdt32_to_cpu(prop[i]), &pdata->regs->ttrcr[i]);
+
+	prop = dev_read_prop(dev, "fsl,tmu-calibration", &len);
+	if (!prop || len % 8) {
+		dev_err(dev, "TMU: missing or invalid fsl,tmu-calibration\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < len / 4; i += 2) {
+		writel(fdt32_to_cpu(prop[i]),     &pdata->regs->ttcfgr);
+		writel(fdt32_to_cpu(prop[i + 1]), &pdata->regs->tscfgr);
+	}
+
+	return 0;
+}
+
+static void qoriq_tmu_init(struct udevice *dev)
+{
+	struct qoriq_tmu_plat *pdata = dev_get_plat(dev);
+
+	writel(TMR_DISABLE,     &pdata->regs->tmr);
+	writel(TIER_DISABLE,    &pdata->regs->tier);
+	writel(TMTMIR_DEFAULT,  &pdata->regs->tmtmir);
+}
+
+static void qoriq_tmu_enable(struct udevice *dev)
+{
+	struct qoriq_tmu_plat *pdata = dev_get_plat(dev);
+	u32 reg;
+
+	reg = readl(&pdata->regs->tmr);
+	reg &= ~TMR_MODE_MONITOR;
+	writel(reg, &pdata->regs->tmr);
+
+	writel(GENMASK(QORIQ_TMU_SITES_MAX - 1, 0), &pdata->regs->tmsr);
+
+	reg |= TMR_ALPF;
+	reg |= TMR_MODE_MONITOR;
+	writel(reg, &pdata->regs->tmr);
+}
+
+static int qoriq_tmu_mmio_bind(struct udevice *dev)
+{
+	ofnode node, offset;
+	const char *name, *label;
+	struct udevice *zone;
+	int ret;
+
+	label = dev_read_string(dev, "label");
+	if (label && *label)
+		device_set_name(dev, label);
+
+	node = ofnode_path("/thermal-zones");
+	if (!ofnode_valid(node))
+		return 0;
+
+	ofnode_for_each_subnode(offset, node) {
+		name = ofnode_get_name(offset);
+		ret = device_bind_driver_to_node(dev, "qoriq_thermal",
+						 name, offset, &zone);
+		if (ret) {
+			dev_err(dev, "Error binding %s: %d\n", name, ret);
+			continue;
+		}
+
+		label = ofnode_read_string(offset, "label");
+		if (label && *label)
+			device_set_name(zone, label);
+	}
+
+	return 0;
+}
+
+static int qoriq_tmu_mmio_probe(struct udevice *dev)
+{
+	struct qoriq_tmu_plat *pdata = dev_get_plat(dev);
+	int ret;
+
+	pdata->regs = dev_read_addr_ptr(dev);
+	if (!pdata->regs)
+		return -EINVAL;
+
+	qoriq_tmu_init(dev);
+	ret = qoriq_tmu_calibration(dev);
+	if (ret)
+		return ret;
+	qoriq_tmu_enable(dev);
+	return 0;
+}
+
+static const struct udevice_id qoriq_tmu_ids[] = {
+	{ .compatible = "fsl,qoriq-tmu" },
+	{ }
+};
+
+U_BOOT_DRIVER(qoriq_thermal_tmu) = {
+	.name		= "qoriq_thermal_tmu",
+	.id		= UCLASS_NOP,
+	.of_match	= qoriq_tmu_ids,
+	.bind		= qoriq_tmu_mmio_bind,
+	.probe		= qoriq_tmu_mmio_probe,
+	.plat_auto	= sizeof(struct qoriq_tmu_plat),
+};
+
+/*
+ * Zone (/thermal-zones/<...>) driver: UCLASS_THERMAL.
+ *
+ * Bound exclusively by the parent's qoriq_tmu_mmio_bind() (no
+ * of_match)
+ */
+static int qoriq_tmu_zone_probe(struct udevice *dev)
+{
+	struct qoriq_tmu_plat *pdata = dev_get_plat(dev);
+	struct qoriq_tmu_plat *parent_plat = dev_get_plat(dev->parent);
+	struct ofnode_phandle_args args;
+	int ret;
+
+	if (!parent_plat || !parent_plat->regs)
+		return -ENODEV;
+	pdata->regs = parent_plat->regs;
+
+	ret = dev_read_phandle_with_args(dev, "thermal-sensors",
+					 "#thermal-sensor-cells",
+					 0, 0, &args);
+	if (ret)
+		return ret;
+
+	if (!ofnode_equal(args.node, dev_ofnode(dev->parent)))
+		return -EFAULT;
+
+	pdata->id = args.args_count >= 1 ? args.args[0] : 0;
+	if (pdata->id < 0 || pdata->id >= QORIQ_TMU_SITES_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(qoriq_thermal) = {
+	.name		= "qoriq_thermal",
+	.id		= UCLASS_THERMAL,
+	.probe		= qoriq_tmu_zone_probe,
+	.ops		= &qoriq_tmu_ops,
+	.plat_auto	= sizeof(struct qoriq_tmu_plat),
+};
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/thermal-qoriq
