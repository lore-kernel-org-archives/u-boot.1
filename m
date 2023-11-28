Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E06C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 06:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3070C87569;
	Tue, 28 Nov 2023 07:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F312F87579; Tue, 28 Nov 2023 07:39:24 +0100 (CET)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71]) by phobos.denx.de (Postfix) with ESMTP id E214D8755D
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 07:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8717B24DB83;
 Tue, 28 Nov 2023 14:39:17 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Nov
 2023 14:39:17 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42;
 Tue, 28 Nov 2023 14:39:15 +0800
From: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
To: <u-boot@lists.denx.de>
CC: <jh80.chung@samsung.com>, <cheehong.ang@starfivetech.com>, Kuan Lim Lee
 <kuanlim.lee@starfivetech.com>, Alex Soo <yuklin.soo@starfivetech.com>, "Wei
 Liang Lim" <weiliang.lim@starfivetech.com>
Subject: [PATCH v2] mmc: sdhci-cadence: Add support for Cadence sdmmc v6
Date: Tue, 28 Nov 2023 14:38:30 +0800
Message-ID: <20231128063859.615-1-kuanlim.lee@starfivetech.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
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

Cadence SDMMC v6 controller has a lot of changes on initialize
compared to v4 controller. PHY is needed by v6 controller.

Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
Co-developed-by: Alex Soo <yuklin.soo@starfivetech.com>
Signed-off-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
---
Changes in v2
- Rename file sdhci-cadence6-phy.c to sdhci-cadence6.c
- Remove CONFIG_MMC_SDHCI_CADENCE_V6
- Rewrite code of v6 configuration part
- Add sdhci_cdns6_phy_init() function
---
 drivers/mmc/Makefile         |   1 +
 drivers/mmc/sdhci-cadence.c  |  63 ++------
 drivers/mmc/sdhci-cadence.h  |  69 ++++++++
 drivers/mmc/sdhci-cadence6.c | 294 +++++++++++++++++++++++++++++++++++
 4 files changed, 376 insertions(+), 51 deletions(-)
 create mode 100644 drivers/mmc/sdhci-cadence.h
 create mode 100644 drivers/mmc/sdhci-cadence6.c

diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 2c65c4765a..136f06600a 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_MMC_SDHCI_ATMEL)		+=3D atmel_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+=3D bcm2835_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCMSTB)		+=3D bcmstb_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+=3D sdhci-cadence.o
+obj-$(CONFIG_MMC_SDHCI_CADENCE)		+=3D sdhci-cadence6.o
 obj-$(CONFIG_MMC_SDHCI_AM654)		+=3D am654_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+=3D iproc_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_KONA)		+=3D kona_sdhci.o
diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 327a05ad11..a5533af045 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -17,56 +17,7 @@
 #include <linux/libfdt.h>
 #include <mmc.h>
 #include <sdhci.h>
-
-/* HRS - Host Register Set (specific to Cadence) */
-#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
-#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
-#define   SDHCI_CDNS_HRS04_RD			BIT(25)
-#define   SDHCI_CDNS_HRS04_WR			BIT(24)
-#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
-#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
-#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
-
-#define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
-#define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
-#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
-#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
-#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
-#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
-#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
-#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
-#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
-#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
-
-/* SRS - Slot Register Set (SDHCI-compatible) */
-#define SDHCI_CDNS_SRS_BASE		0x200
-
-/* PHY */
-#define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
-#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
-#define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
-#define SDHCI_CDNS_PHY_DLY_UHS_SDR25	0x03
-#define SDHCI_CDNS_PHY_DLY_UHS_SDR50	0x04
-#define SDHCI_CDNS_PHY_DLY_UHS_DDR50	0x05
-#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
-#define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
-#define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
-#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
-#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
-#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
-
-/*
- * The tuned val register is 6 bit-wide, but not the whole of the range =
is
- * available.  The range 0-42 seems to be available (then 43 wraps aroun=
d to 0)
- * but I am not quite sure if it is official.  Use only 0 to 39 for safe=
ty.
- */
-#define SDHCI_CDNS_MAX_TUNING_LOOP	40
-
-struct sdhci_cdns_plat {
-	struct mmc_config cfg;
-	struct mmc mmc;
-	void __iomem *hrs_addr;
-};
+#include "sdhci-cadence.h"
=20
 struct sdhci_cdns_phy_cfg {
 	const char *property;
@@ -163,6 +114,9 @@ static void sdhci_cdns_set_control_reg(struct sdhci_h=
ost *host)
 	tmp &=3D ~SDHCI_CDNS_HRS06_MODE;
 	tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS06);
+
+	if (device_is_compatible(mmc->dev, "cdns,sd6hc"))
+		sdhci_cdns6_phy_adj(mmc->dev, plat, mode);
 }
=20
 static const struct sdhci_ops sdhci_cdns_ops =3D {
@@ -176,6 +130,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_cdns_=
plat *plat,
 	u32 tmp;
 	int i, ret;
=20
+	if (device_is_compatible(plat->mmc.dev, "cdns,sd6hc"))
+		return sdhci_cdns6_set_tune_val(plat, val);
+
 	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
 		return -EINVAL;
=20
@@ -282,7 +239,10 @@ static int sdhci_cdns_probe(struct udevice *dev)
 	if (ret)
 		return ret;
=20
-	ret =3D sdhci_cdns_phy_init(plat, gd->fdt_blob, dev_of_offset(dev));
+	if (device_is_compatible(dev, "cdns,sd6hc"))
+		ret =3D sdhci_cdns6_phy_init(dev, plat);
+	else
+		ret =3D sdhci_cdns_phy_init(plat, gd->fdt_blob, dev_of_offset(dev));
 	if (ret)
 		return ret;
=20
@@ -301,6 +261,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 static const struct udevice_id sdhci_cdns_match[] =3D {
 	{ .compatible =3D "socionext,uniphier-sd4hc" },
 	{ .compatible =3D "cdns,sd4hc" },
+	{ .compatible =3D "cdns,sd6hc" },
 	{ /* sentinel */ }
 };
=20
diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
new file mode 100644
index 0000000000..c20efd899a
--- /dev/null
+++ b/drivers/mmc/sdhci-cadence.h
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ */
+
+#ifndef SDHCI_CADENCE_H_
+#define SDHCI_CADENCE_H_
+
+/* HRS - Host Register Set (specific to Cadence) */
+/* PHY access port */
+#define SDHCI_CDNS_HRS04		0x10
+/* Cadence V4 HRS04 Description*/
+#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
+#define   SDHCI_CDNS_HRS04_RD			BIT(25)
+#define   SDHCI_CDNS_HRS04_WR			BIT(24)
+#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
+#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
+#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
+
+#define SDHCI_CDNS_HRS05		0x14
+
+/* eMMC control */
+#define SDHCI_CDNS_HRS06		0x18
+#define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
+#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
+#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
+#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
+#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
+#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
+
+/* SRS - Slot Register Set (SDHCI-compatible) */
+#define SDHCI_CDNS_SRS_BASE		0x200
+
+/* Cadence V4 PHY Setting*/
+#define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
+#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
+#define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
+#define SDHCI_CDNS_PHY_DLY_UHS_SDR25	0x03
+#define SDHCI_CDNS_PHY_DLY_UHS_SDR50	0x04
+#define SDHCI_CDNS_PHY_DLY_UHS_DDR50	0x05
+#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
+#define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
+#define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
+#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
+#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
+#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
+
+/*
+ * The tuned val register is 6 bit-wide, but not the whole of the range =
is
+ * available.  The range 0-42 seems to be available (then 43 wraps aroun=
d to 0)
+ * but I am not quite sure if it is official.  Use only 0 to 39 for safe=
ty.
+ */
+#define SDHCI_CDNS_MAX_TUNING_LOOP	40
+
+struct sdhci_cdns_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+	void __iomem *hrs_addr;
+};
+
+int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *pla=
t, u32 mode);
+int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *pl=
at);
+int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int =
val);
+
+#endif
diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
new file mode 100644
index 0000000000..ea0857e655
--- /dev/null
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-or-platform_driver
+/*
+ * Copyright (C) 2023 Starfive.
+ *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <asm/global_data.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/sizes.h>
+#include <linux/libfdt.h>
+#include <mmc.h>
+#include <sdhci.h>
+#include "sdhci-cadence.h"
+
+/* IO Delay Information */
+#define SDHCI_CDNS_HRS07		0X1C
+#define   SDHCI_CDNS_HRS07_RW_COMPENSATE	GENMASK(20, 16)
+#define   SDHCI_CDNS_HRS07_IDELAY_VAL		GENMASK(4, 0)
+
+/* PHY Control and Status */
+#define SDHCI_CDNS_HRS09		0x24
+#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
+#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
+#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
+#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
+#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
+#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
+
+/* SDCLK adjustment */
+#define SDHCI_CDNS_HRS10		0x28
+#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
+
+/* CMD/DAT output delay */
+#define SDHCI_CDNS_HRS16		0x40
+
+/* PHY Special Function Registers */
+/* register to control the DQ related timing */
+#define PHY_DQ_TIMING_REG_ADDR		0x2000
+
+/* register to control the DQS related timing */
+#define PHY_DQS_TIMING_REG_ADDR		0x2004
+
+/* register to control the gate and loopback control related timing */
+#define PHY_GATE_LPBK_CTRL_REG_ADDR	0x2008
+
+/* register to control the Master DLL logic */
+#define PHY_DLL_MASTER_CTRL_REG_ADDR	0x200C
+
+/* register to control the Slave DLL logic */
+#define PHY_DLL_SLAVE_CTRL_REG_ADDR	0x2010
+#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
+#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
+
+#define SDHCI_CDNS6_PHY_CFG_NUM		4
+#define SDHCI_CDNS6_CTRL_CFG_NUM	4
+
+struct sdhci_cdns6_phy_cfg {
+	const char *property;
+	u32 val;
+};
+
+struct sdhci_cdns6_ctrl_cfg {
+	const char *property;
+	u32 val;
+};
+
+static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] =3D {
+	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-ds", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
+	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
+};
+
+static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] =3D {
+	{ "cdns,phy-dqs-timing-delay-semmc-sdr", 0x00380004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-sdr", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
+	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
+};
+
+static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] =3D {
+	{ "cdns,phy-dqs-timing-delay-emmc-ddr", 0x00380004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-ddr", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
+	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
+};
+
+static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] =3D {
+	{ "cdns,phy-dqs-timing-delay-emmc-hs200", 0x00380004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-hs200", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
+	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
+};
+
+static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] =3D {
+	{ "cdns,phy-dqs-timing-delay-emmc-hs400", 0x00280004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-hs400", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
+	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
+};
+
+static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] =3D {
+	{ "cdns,ctrl-hrs09-timing-delay-sd-ds", 0x0001800C, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-ds", 0x00020000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-sd-ds", 0x00000000, },
+	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
+};
+
+static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] =3D {
+	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-sdr", 0x00030000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-sdr", 0x00000000, },
+	{ "cdns,ctrl-hrs07-timing-delay-emmc-sdr", 0x00080000, },
+};
+
+static struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] =3D {
+	{ "cdns,ctrl-hrs09-timing-delay-emmc-ddr", 0x0001800C, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-ddr", 0x00020000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-ddr", 0x11000001, },
+	{ "cdns,ctrl-hrs07-timing-delay-emmc-ddr", 0x00090001, },
+};
+
+static struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] =3D {
+	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs200", 0x00018000, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-hs200", 0x00080000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs200", 0x00000000, },
+	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs200", 0x00090000, },
+};
+
+static struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] =3D {
+	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs400", 0x00018000, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-hs400", 0x00080000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs400", 0x11000000, },
+	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs400", 0x00080000, },
+};
+
+static u32 sdhci_cdns6_read_phy_reg(struct sdhci_cdns_plat *plat, u32 ad=
dr)
+{
+	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
+	return readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, u32 =
addr, u32 val)
+{
+	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
+	writel(val, plat->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool =
reset)
+{
+	void __iomem *reg =3D plat->hrs_addr + SDHCI_CDNS_HRS09;
+	u32 tmp;
+	int ret;
+
+	tmp =3D readl(reg);
+	tmp &=3D ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
+
+	/* Switch On DLL Reset */
+	if (reset)
+		tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 0);
+	else
+		tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 1);
+
+	writel(tmp, reg);
+
+	/* After reset, wait until HRS09.PHY_INIT_COMPLETE is set to 1 within 3=
000us*/
+	if (!reset) {
+		ret =3D readl_poll_timeout(reg, tmp, (tmp & SDHCI_CDNS_HRS09_PHY_INIT_=
COMPLETE),
+					 3000);
+	}
+
+	return ret;
+}
+
+int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *pla=
t, u32 mode)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	struct sdhci_cdns6_phy_cfg *sdhci_cdns6_phy_cfgs;
+	struct sdhci_cdns6_ctrl_cfg *sdhci_cdns6_ctrl_cfgs;
+	const fdt32_t *prop;
+	u32 tmp;
+	int i, ret;
+
+	switch (mode) {
+	case SDHCI_CDNS_HRS06_MODE_SD:
+		sdhci_cdns6_phy_cfgs =3D sd_ds_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs =3D sd_ds_ctrl_cfgs;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_SDR:
+		sdhci_cdns6_phy_cfgs =3D emmc_sdr_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs =3D emmc_sdr_ctrl_cfgs;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_DDR:
+		sdhci_cdns6_phy_cfgs =3D emmc_ddr_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs =3D emmc_ddr_ctrl_cfgs;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_HS200:
+		sdhci_cdns6_phy_cfgs =3D emmc_hs200_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs =3D emmc_hs200_ctrl_cfgs;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
+		sdhci_cdns6_phy_cfgs =3D emmc_hs400_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs =3D emmc_hs400_ctrl_cfgs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++) {
+		prop =3D fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
+				   sdhci_cdns6_phy_cfgs[i].property, NULL);
+		if (prop)
+			sdhci_cdns6_phy_cfgs[i].val =3D *prop;
+	}
+
+	for (i =3D 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++) {
+		prop =3D fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
+				   sdhci_cdns6_ctrl_cfgs[i].property, NULL);
+		if (prop)
+			sdhci_cdns6_ctrl_cfgs[i].val =3D *prop;
+	}
+
+	/* Switch On the DLL Reset */
+	sdhci_cdns6_reset_phy_dll(plat, true);
+
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_ph=
y_cfgs[0].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns=
6_phy_cfgs[1].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns=
6_phy_cfgs[2].val);
+
+	/* Switch Off the DLL Reset */
+	ret =3D sdhci_cdns6_reset_phy_dll(plat, false);
+	if (ret) {
+		printf("sdhci_cdns6_reset_phy is not completed\n");
+		return ret;
+	}
+
+	/* Set PHY DQ TIMING control register */
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, sdhci_cdns6_phy=
_cfgs[3].val);
+
+	/* Set HRS09 register */
+	tmp =3D readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
+	tmp &=3D ~(SDHCI_CDNS_HRS09_EXTENDED_WR_MODE |
+		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
+		 SDHCI_CDNS_HRS09_RDDATA_EN |
+		 SDHCI_CDNS_HRS09_RDCMD_EN);
+	tmp |=3D sdhci_cdns6_ctrl_cfgs[0].val;
+	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
+
+	/* Set HRS10 register */
+	tmp =3D readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
+	tmp &=3D ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
+	tmp |=3D sdhci_cdns6_ctrl_cfgs[1].val;
+	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
+
+	/* Set HRS16 register */
+	writel(sdhci_cdns6_ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16)=
;
+
+	/* Set HRS07 register */
+	writel(sdhci_cdns6_ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07)=
;
+
+	return 0;
+}
+
+int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *pl=
at)
+{
+	return sdhci_cdns6_phy_adj(dev, plat, SDHCI_CDNS_HRS06_MODE_SD);
+}
+
+int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int =
val)
+{
+	u32 tmp, tuneval;
+
+	tuneval =3D (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
+
+	tmp =3D sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
+	tmp &=3D ~(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY |
+		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
+	tmp |=3D FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval)=
 |
+		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
+
+	return 0;
+}
--=20
2.34.1

