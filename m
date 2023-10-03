Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52540E7542D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BA586DD5;
	Tue,  3 Oct 2023 09:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB30086E14; Tue,  3 Oct 2023 09:23:50 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71]) by phobos.denx.de (Postfix) with ESMTP id 73B4986DD3
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by fd01.gateway.ufhost.com (Postfix) with ESMTP id A817A8109;
 Tue,  3 Oct 2023 15:23:43 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Oct
 2023 15:23:43 +0800
Received: from localhost.localdomain (115.135.197.53) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42;
 Tue, 3 Oct 2023 15:23:39 +0800
From: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
To: <u-boot@lists.denx.de>
CC: <yuklin.soo@starfivetech.com>, <weiliang.lim@starfivetech.com>, "Kuan Lim
 Lee" <kuanlim.lee@linux.starfivetech.com>, Kuan Lim Lee
 <kuanlim.lee@starfivetech.com>
Subject: [PATCH] mmc: sdhci-cadence: Add support for Cadence sdmmc v6
Date: Tue, 3 Oct 2023 15:22:58 +0800
Message-ID: <20231003072320.2008-1-kuanlim.lee@starfivetech.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.135.197.53]
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

From: Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>

Cadence SDMMC v6 controller has a lot of changes on initialize
compared to v4 controller. PHY is needed by v6 controller.

Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
Reviewed-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>
---
 drivers/mmc/Kconfig              |  13 ++
 drivers/mmc/Makefile             |   1 +
 drivers/mmc/sdhci-cadence.c      |  63 ++-----
 drivers/mmc/sdhci-cadence.h      |  68 +++++++
 drivers/mmc/sdhci-cadence6-phy.c | 302 +++++++++++++++++++++++++++++++
 5 files changed, 396 insertions(+), 51 deletions(-)
 create mode 100644 drivers/mmc/sdhci-cadence.h
 create mode 100644 drivers/mmc/sdhci-cadence6-phy.c

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index de01b9687b..cec881d862 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -573,6 +573,19 @@ config MMC_SDHCI_CADENCE
=20
 	  If unsure, say N.
=20
+config MMC_SDHCI_CADENCE_V6
+	bool "SDHCI support for the Cadence SD/SDIO/eMMC controller & driver ve=
rsion 6"
+	depends on BLK && DM_MMC
+	depends on MMC_SDHCI
+	depends on OF_CONTROL
+	select MMC_SDHCI_CADENCE
+	help
+	  This selects the Cadence SD/SDIO/eMMC driver version 6.
+
+	  If you have a controller with this interface, say Y here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_AM654
 	bool "SDHCI Controller on TI's Am654 devices"
 	depends on ARCH_K3
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 2c65c4765a..cdcce55b8b 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_MMC_SDHCI_ATMEL)		+=3D atmel_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+=3D bcm2835_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_BCMSTB)		+=3D bcmstb_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+=3D sdhci-cadence.o
+obj-$(CONFIG_MMC_SDHCI_CADENCE_V6)	+=3D sdhci-cadence6-phy.o
 obj-$(CONFIG_MMC_SDHCI_AM654)		+=3D am654_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+=3D iproc_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_KONA)		+=3D kona_sdhci.o
diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 327a05ad11..d7a270e74c 100644
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
@@ -112,8 +63,11 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns=
_plat *plat,
 }
=20
 static int sdhci_cdns_phy_init(struct sdhci_cdns_plat *plat,
-				const void *fdt, int nodeoffset)
+			       const void *fdt, int nodeoffset)
 {
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
+		return sdhci_cdns6_phy_init(plat, SDHCI_CDNS_HRS06_MODE_SD);
+
 	const fdt32_t *prop;
 	int ret, i;
=20
@@ -163,6 +117,9 @@ static void sdhci_cdns_set_control_reg(struct sdhci_h=
ost *host)
 	tmp &=3D ~SDHCI_CDNS_HRS06_MODE;
 	tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS06);
+
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
+		sdhci_cdns6_phy_init(plat, mode);
 }
=20
 static const struct sdhci_ops sdhci_cdns_ops =3D {
@@ -172,6 +129,9 @@ static const struct sdhci_ops sdhci_cdns_ops =3D {
 static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
 				   unsigned int val)
 {
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_CADENCE_V6))
+		return sdhci_cdns6_set_tune_val(plat, val);
+
 	void __iomem *reg =3D plat->hrs_addr + SDHCI_CDNS_HRS06;
 	u32 tmp;
 	int i, ret;
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
index 0000000000..2c42cff2f3
--- /dev/null
+++ b/drivers/mmc/sdhci-cadence.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Starfive.
+ *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
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
+int sdhci_cdns6_phy_init(struct sdhci_cdns_plat *plat, u32 mode);
+int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int =
val);
+
+#endif
diff --git a/drivers/mmc/sdhci-cadence6-phy.c b/drivers/mmc/sdhci-cadence=
6-phy.c
new file mode 100644
index 0000000000..dd3df27dc8
--- /dev/null
+++ b/drivers/mmc/sdhci-cadence6-phy.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-platform_driver
+/*
+ * Copyright (C) 2022 Starfive.
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
+#define   SDHCI_CDNS_HRS07_RW_COMPENSATE		GENMASK(20, 16)
+#define   SDHCI_CDNS_HRS07_IDELAY_VAL			GENMASK(4, 0)
+
+#define SDHCI_CDNS_HRS09		0x24		/* PHY Control and Status */
+#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
+#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
+#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
+#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
+#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
+#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
+
+#define SDHCI_CDNS_HRS10		0x28		/* SDCLK adjustment */
+#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
+
+#define SDHCI_CDNS_HRS16		0x40		/* CMD/DAT output delay */
+
+/* PHY Special Function Registers */
+//#define DLL_PHY_REG_BASE		0x2000
+
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
+/* register to control the global settings for PHY */
+#define PHY_CTRL_REG_ADDR		0x2080
+
+struct phy_reg {
+	u32 phy_dqs_timing;
+	u32 phy_gate_lpbk_ctrl;
+	//u32 phy_dll_master_ctrl;
+	u32 phy_dll_slave_ctrl;
+	//u32 phy_ctrl;
+	u32 phy_dq_timing;
+	//cp_sw_half_cycle_shift; ASIC
+};
+
+struct controller_reg {
+	u32 hrs07;
+	u32 hrs09;
+	u32 hrs10;
+	u32 hrs16;
+};
+
+static struct phy_reg sd_ds_phy_cfg =3D {
+	0x00380004,
+	0x01A00040,
+	0x00000000,
+	0x00000001,
+};
+
+static struct phy_reg emmc_sdr_phy_cfg =3D {
+	0x00380004,
+	0x01A00040,
+	0x00000000,
+	0x00000001,
+};
+
+static struct phy_reg emmc_ddr_phy_cfg =3D {
+	0x00380004,
+	0x01A00040,
+	0x00000000,
+	0x10000001,
+};
+
+static struct phy_reg emmc_hs200_phy_cfg =3D {
+	0x00380004,
+	0x01A00040,
+	0x00DADA00,
+	0x00000001,
+};
+
+static struct phy_reg emmc_hs400_phy_cfg =3D {
+	0x00280004,
+	0x01A00040,
+	0x00DAD800,
+	0x00000001,
+};
+
+static struct controller_reg sd_ds_ctrl_cfg =3D {
+	0x00080000,
+	0x0001800C,
+	0x00020000,
+	0x00000000,
+};
+
+static struct controller_reg emmc_sdr_ctrl_cfg =3D {
+	0x00080000,
+	0x0001800C,
+	0x00030000,
+	0x00000000,
+};
+
+static struct controller_reg emmc_ddr_ctrl_cfg =3D {
+	0x00090001,
+	0x0001800C,
+	0x00020000,
+	0x11000001,
+};
+
+static struct controller_reg emmc_hs200_ctrl_cfg =3D {
+	0x00090000,
+	0x00018000,
+	0x00080000,
+	0x00000000,
+};
+
+static struct controller_reg emmc_hs400_ctrl_cfg =3D {
+	0x00080000,
+	0x00018000,
+	0x00080000,
+	0x11000000,
+};
+
+static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_plat *pla=
t,=20
+					     u32 addr)
+{
+	u32 data =3D 0;
+
+	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
+	data =3D readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
+	return data;
+}
+
+static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat,=20
+				      u32 addr, u32 data)
+{
+	u32 readdat =3D 0;
+
+	writel(addr, plat->hrs_addr + SDHCI_CDNS_HRS04);
+	writel(data, plat->hrs_addr + SDHCI_CDNS_HRS05);
+	readdat =3D readl(plat->hrs_addr + SDHCI_CDNS_HRS05);
+
+	if (readdat !=3D data) {
+		pr_err("Error, %s: Writing failed!: address: 0x%x, value : 0x%x,=20
+		       readval: 0x%x\n", __func__, addr, data, readdat);
+	}
+}
+
+static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat,=20
+				     unsigned int reset)
+{
+	void __iomem *reg =3D plat->hrs_addr + SDHCI_CDNS_HRS09;
+	u32 tmp;
+	int ret;
+
+	tmp =3D readl(reg);
+	tmp &=3D ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
+
+	if (reset)	/* Switch On DLL Reset */
+		tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 0);
+	else		/* Switch Off DLL Reset */
+		tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 1);
+
+	writel(tmp, reg);
+
+	if (!reset) {
+		ret =3D readl_poll_timeout(reg, tmp,=20
+					 (tmp & SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
+					 3000);
+	}
+
+	return ret;
+}
+
+int sdhci_cdns6_phy_init(struct sdhci_cdns_plat *plat, u32 mode)
+{
+	struct phy_reg *phy_cfgs;
+	struct controller_reg *ctrl_cfgs;
+	void __iomem *reg =3D NULL;
+	u32 tmp;
+	int ret;
+
+	switch (mode) {
+	case SDHCI_CDNS_HRS06_MODE_SD:
+		phy_cfgs =3D &sd_ds_phy_cfg;
+		ctrl_cfgs =3D &sd_ds_ctrl_cfg;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_SDR:
+		phy_cfgs =3D &emmc_sdr_phy_cfg;
+		ctrl_cfgs =3D &emmc_sdr_ctrl_cfg;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_DDR:
+		phy_cfgs =3D &emmc_ddr_phy_cfg;
+		ctrl_cfgs =3D &emmc_ddr_ctrl_cfg;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_HS200:
+		phy_cfgs =3D &emmc_hs200_phy_cfg;
+		ctrl_cfgs =3D &emmc_hs200_ctrl_cfg;
+		break;
+
+	case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
+		phy_cfgs =3D &emmc_hs400_phy_cfg;
+		ctrl_cfgs =3D &emmc_hs400_ctrl_cfg;
+		break;
+	}
+
+	/* Switch On the DLL Reset */
+	sdhci_cdns6_reset_phy_dll(plat, 1);
+
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR,=20
+				  phy_cfgs->phy_dqs_timing);
+	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR,=20
+				  phy_cfgs->phy_gate_lpbk_ctrl);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,=20
+				  phy_cfgs->phy_dll_slave_ctrl);
+
+	/* Switch Off the DLL Reset */
+	ret =3D sdhci_cdns6_reset_phy_dll(plat, 0);
+	if (ret) {
+		printf("sdhci_cdns6_reset_phy is not completed\n");
+		return ret;
+	}
+
+	/* Set PHY DQ TIMING control register */
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR,=20
+				  phy_cfgs->phy_dq_timing);
+
+	/* Set HRS09 register */
+	reg =3D plat->hrs_addr + SDHCI_CDNS_HRS09;
+	tmp =3D readl(reg);
+	tmp &=3D ~(SDHCI_CDNS_HRS09_EXTENDED_WR_MODE |
+		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
+		 SDHCI_CDNS_HRS09_RDDATA_EN |
+		 SDHCI_CDNS_HRS09_RDCMD_EN);
+	tmp |=3D ctrl_cfgs->hrs09;
+	writel(tmp, reg);
+
+	/* Set HRS10 register */
+	reg =3D plat->hrs_addr + SDHCI_CDNS_HRS10;
+	tmp =3D readl(reg);
+	tmp &=3D ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
+	tmp |=3D ctrl_cfgs->hrs10;
+	writel(tmp, reg);
+
+	/* Set HRS16 register */
+	reg =3D plat->hrs_addr + SDHCI_CDNS_HRS16;
+	tmp =3D ctrl_cfgs->hrs16;
+	writel(tmp, reg);
+
+	/* Set HRS07 register */
+	reg =3D plat->hrs_addr + SDHCI_CDNS_HRS07;
+	tmp =3D ctrl_cfgs->hrs07;
+	writel(tmp, reg);
+
+	return 0;
+}
+
+int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat,=20
+			     unsigned int val)
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

