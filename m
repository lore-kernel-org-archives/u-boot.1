Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F55E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 08:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7462B805E9;
	Fri, 10 Jan 2025 09:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="VbrZDhuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E172180608; Fri, 10 Jan 2025 09:41:28 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F01B4800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a8ae7d50cf2e11efbd192953cf12861f-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=T4Dq0Kha/RZ0nnupx5x58wiimA6RJPRUk9oN0XntsQI=; 
 b=VbrZDhuERBZ0RW6Nbfh67xebxl9CseZftTNHHMF4SbrUq6PknOECmV1nX400w51RaMEkI39vBnALl2kchP+eqlnEmvSUSEC4nw7zQn7OSCH/t9aFP3v0AY9pbJwGMjpfw4gYV/24TkH8kltuMuEyS+v9n6FA+kfXbmlh1mX1GV4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:8f9edfb2-ebcf-4bd7-971e-952dd32b134d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:c6c64b13-8831-4185-8e40-f83b1917e828,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,OSH
X-CID-BAS: 2,OSH,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8ae7d50cf2e11efbd192953cf12861f-20250110
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 573578636; Fri, 10 Jan 2025 16:41:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 16:41:16 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 16:41:15 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 1/3] net: mediatek: split ethernet switch code from mtk_eth.c
Date: Fri, 10 Jan 2025 16:41:13 +0800
Message-ID: <2c5b3ba88a618e719d9a692855fa2dcb8dcb472b.1736498083.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1736498083.git.weijie.gao@mediatek.com>
References: <cover.1736498083.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

mtk_eth.c contains not only the ethernet GMAC/DMA driver, but also
some ethernet switch initialization code. As we may add more switch
support in the future, it's better to move them out of mtk_eth.c to
avoid increasing the code complexity.

Since not all switches are supported for a particular board, Kconfig
options are added to allow user to select which switch should be
built into u-boot. If multiple switches are selected, auto-detecting
can also be enabled.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/Kconfig                 |  21 +-
 drivers/net/Makefile                |   2 +-
 drivers/net/mtk_eth/Kconfig         |  35 +
 drivers/net/mtk_eth/Makefile        |   9 +
 drivers/net/mtk_eth/mt7530.c        | 281 ++++++++
 drivers/net/mtk_eth/mt7531.c        | 293 +++++++++
 drivers/net/mtk_eth/mt753x.c        | 262 ++++++++
 drivers/net/mtk_eth/mt753x.h        | 286 ++++++++
 drivers/net/mtk_eth/mt7988.c        | 160 +++++
 drivers/net/{ => mtk_eth}/mtk_eth.c | 971 ++++------------------------
 drivers/net/{ => mtk_eth}/mtk_eth.h | 301 ++-------
 11 files changed, 1520 insertions(+), 1101 deletions(-)
 create mode 100644 drivers/net/mtk_eth/Kconfig
 create mode 100644 drivers/net/mtk_eth/Makefile
 create mode 100644 drivers/net/mtk_eth/mt7530.c
 create mode 100644 drivers/net/mtk_eth/mt7531.c
 create mode 100644 drivers/net/mtk_eth/mt753x.c
 create mode 100644 drivers/net/mtk_eth/mt753x.h
 create mode 100644 drivers/net/mtk_eth/mt7988.c
 rename drivers/net/{ => mtk_eth}/mtk_eth.c (62%)
 rename drivers/net/{ => mtk_eth}/mtk_eth.h (59%)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 88ff025a37b..e48e28d00a3 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -966,26 +966,7 @@ config TSEC_ENET
 	  This driver implements support for the (Enhanced) Three-Speed
 	  Ethernet Controller found on Freescale SoCs.
 
-config MEDIATEK_ETH
-	bool "MediaTek Ethernet GMAC Driver"
-	select PHYLIB
-	select DM_GPIO
-	select DM_RESET
-	help
-	  This Driver support MediaTek Ethernet GMAC
-	  Say Y to enable support for the MediaTek Ethernet GMAC.
-
-if MEDIATEK_ETH
-
-config MTK_ETH_SGMII
-	bool
-	default y if ARCH_MEDIATEK && !TARGET_MT7623
-
-config MTK_ETH_XGMII
-	bool
-	default y if TARGET_MT7987 || TARGET_MT7988
-
-endif # MEDIATEK_ETH
+source "drivers/net/mtk_eth/Kconfig"
 
 config HIFEMAC_ETH
 	bool "HiSilicon Fast Ethernet Controller"
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index e51a917933e..6f3d63dc4cd 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
 obj-$(CONFIG_MDIO_MUX_MMIOREG) += mdio_mux_mmioreg.o
 obj-$(CONFIG_MDIO_MUX_SANDBOX) += mdio_mux_sandbox.o
 obj-$(CONFIG_MDIO_SANDBOX) += mdio_sandbox.o
-obj-$(CONFIG_MEDIATEK_ETH) += mtk_eth.o
+obj-$(CONFIG_MEDIATEK_ETH) += mtk_eth/
 obj-$(CONFIG_MPC8XX_FEC) += mpc8xx_fec.o
 obj-$(CONFIG_MT7620_ETH) += mt7620-eth.o
 obj-$(CONFIG_MT7628_ETH) += mt7628-eth.o
diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
new file mode 100644
index 00000000000..8d012fb1374
--- /dev/null
+++ b/drivers/net/mtk_eth/Kconfig
@@ -0,0 +1,35 @@
+
+config MEDIATEK_ETH
+	bool "MediaTek Ethernet GMAC Driver"
+	select PHYLIB
+	select DM_GPIO
+	select DM_RESET
+	help
+	  This Driver support MediaTek Ethernet GMAC
+	  Say Y to enable support for the MediaTek Ethernet GMAC.
+
+if MEDIATEK_ETH
+
+config MTK_ETH_SGMII
+	bool
+	default y if ARCH_MEDIATEK && !TARGET_MT7623
+
+config MTK_ETH_XGMII
+	bool
+	default y if TARGET_MT7988
+
+config MTK_ETH_SWITCH_MT7530
+	bool "Support for MediaTek MT7530 ethernet switch"
+	default y if TARGET_MT7623 || SOC_MT7621
+
+config MTK_ETH_SWITCH_MT7531
+	bool "Support for MediaTek MT7531 ethernet switch"
+	default y if TARGET_MT7622 || TARGET_MT7629 || TARGET_MT7981 || \
+		     TARGET_MT7986
+
+config MTK_ETH_SWITCH_MT7988
+	bool "Support for MediaTek MT7988 built-in ethernet switch"
+	depends on TARGET_MT7988
+	default y
+
+endif # MEDIATEK_ETH
diff --git a/drivers/net/mtk_eth/Makefile b/drivers/net/mtk_eth/Makefile
new file mode 100644
index 00000000000..885375c5b38
--- /dev/null
+++ b/drivers/net/mtk_eth/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 MediaTek Inc.
+# Author: Weijie Gao <weijie.gao@mediatek.com>
+
+obj-y += mtk_eth.o
+obj-$(CONFIG_MTK_ETH_SWITCH_MT7530) += mt753x.o mt7530.o
+obj-$(CONFIG_MTK_ETH_SWITCH_MT7531) += mt753x.o mt7531.o
+obj-$(CONFIG_MTK_ETH_SWITCH_MT7988) += mt753x.o mt7988.o
diff --git a/drivers/net/mtk_eth/mt7530.c b/drivers/net/mtk_eth/mt7530.c
new file mode 100644
index 00000000000..3065d35e126
--- /dev/null
+++ b/drivers/net/mtk_eth/mt7530.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ *
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ * Author: Mark Lee <mark-mc.lee@mediatek.com>
+ */
+
+#include <miiphy.h>
+#include <linux/delay.h>
+#include <linux/mdio.h>
+#include <linux/mii.h>
+#include "mtk_eth.h"
+#include "mt753x.h"
+
+#define CHIP_REV			0x7ffc
+#define CHIP_NAME_S			16
+#define CHIP_NAME_M			0xffff0000
+#define CHIP_REV_S			0
+#define CHIP_REV_M			0x0f
+
+static void mt7530_core_reg_write(struct mt753x_switch_priv *priv, u32 reg,
+				  u32 val)
+{
+	u8 phy_addr = MT753X_PHY_ADDR(priv->phy_base, 0);
+
+	mtk_mmd_ind_write(priv->epriv.eth, phy_addr, 0x1f, reg, val);
+}
+
+static int mt7530_pad_clk_setup(struct mt753x_switch_priv *priv, int mode)
+{
+	u32 ncpo1, ssc_delta;
+
+	switch (mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		ncpo1 = 0x0c80;
+		ssc_delta = 0x87;
+		break;
+
+	default:
+		printf("error: xMII mode %d is not supported\n", mode);
+		return -EINVAL;
+	}
+
+	/* Disable MT7530 core clock */
+	mt7530_core_reg_write(priv, CORE_TRGMII_GSW_CLK_CG, 0);
+
+	/* Disable MT7530 PLL */
+	mt7530_core_reg_write(priv, CORE_GSWPLL_GRP1,
+			      (2 << RG_GSWPLL_POSDIV_200M_S) |
+			      (32 << RG_GSWPLL_FBKDIV_200M_S));
+
+	/* For MT7530 core clock = 500Mhz */
+	mt7530_core_reg_write(priv, CORE_GSWPLL_GRP2,
+			      (1 << RG_GSWPLL_POSDIV_500M_S) |
+			      (25 << RG_GSWPLL_FBKDIV_500M_S));
+
+	/* Enable MT7530 PLL */
+	mt7530_core_reg_write(priv, CORE_GSWPLL_GRP1,
+			      (2 << RG_GSWPLL_POSDIV_200M_S) |
+			      (32 << RG_GSWPLL_FBKDIV_200M_S) |
+			      RG_GSWPLL_EN_PRE);
+
+	udelay(20);
+
+	mt7530_core_reg_write(priv, CORE_TRGMII_GSW_CLK_CG, REG_GSWCK_EN);
+
+	/* Setup the MT7530 TRGMII Tx Clock */
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP5, ncpo1);
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP6, 0);
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP10, ssc_delta);
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP11, ssc_delta);
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP4, RG_SYSPLL_DDSFBK_EN |
+			      RG_SYSPLL_BIAS_EN | RG_SYSPLL_BIAS_LPF_EN);
+
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP2,
+			      RG_SYSPLL_EN_NORMAL | RG_SYSPLL_VODEN |
+			      (1 << RG_SYSPLL_POSDIV_S));
+
+	mt7530_core_reg_write(priv, CORE_PLL_GROUP7,
+			      RG_LCDDS_PCW_NCPO_CHG | (3 << RG_LCCDS_C_S) |
+			      RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
+
+	/* Enable MT7530 core clock */
+	mt7530_core_reg_write(priv, CORE_TRGMII_GSW_CLK_CG,
+			      REG_GSWCK_EN | REG_TRGMIICK_EN);
+
+	return 0;
+}
+
+static void mt7530_mac_control(struct mtk_eth_switch_priv *swpriv, bool enable)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	u32 pmcr = FORCE_MODE;
+
+	if (enable)
+		pmcr = priv->pmcr;
+
+	mt753x_reg_write(priv, PMCR_REG(6), pmcr);
+}
+
+static int mt7530_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
+{
+	struct mt753x_switch_priv *priv = bus->priv;
+
+	if (devad < 0)
+		return mtk_mii_read(priv->epriv.eth, addr, reg);
+
+	return mtk_mmd_ind_read(priv->epriv.eth, addr, devad, reg);
+}
+
+static int mt7530_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
+			     u16 val)
+{
+	struct mt753x_switch_priv *priv = bus->priv;
+
+	if (devad < 0)
+		return mtk_mii_write(priv->epriv.eth, addr, reg, val);
+
+	return mtk_mmd_ind_write(priv->epriv.eth, addr, devad, reg, val);
+}
+
+static int mt7530_mdio_register(struct mt753x_switch_priv *priv)
+{
+	struct mii_dev *mdio_bus = mdio_alloc();
+	int ret;
+
+	if (!mdio_bus)
+		return -ENOMEM;
+
+	mdio_bus->read = mt7530_mdio_read;
+	mdio_bus->write = mt7530_mdio_write;
+	snprintf(mdio_bus->name, sizeof(mdio_bus->name), priv->epriv.sw->name);
+
+	mdio_bus->priv = priv;
+
+	ret = mdio_register(mdio_bus);
+	if (ret) {
+		mdio_free(mdio_bus);
+		return ret;
+	}
+
+	priv->mdio_bus = mdio_bus;
+
+	return 0;
+}
+
+static int mt7530_setup(struct mtk_eth_switch_priv *swpriv)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	u16 phy_addr, phy_val;
+	u32 i, val, txdrv;
+
+	priv->smi_addr = MT753X_DFL_SMI_ADDR;
+	priv->reg_read = mt753x_mdio_reg_read;
+	priv->reg_write = mt753x_mdio_reg_write;
+
+	if (!MTK_HAS_CAPS(priv->epriv.soc->caps, MTK_TRGMII_MT7621_CLK)) {
+		/* Select 250MHz clk for RGMII mode */
+		mtk_ethsys_rmw(priv->epriv.eth, ETHSYS_CLKCFG0_REG,
+			       ETHSYS_TRGMII_CLK_SEL362_5, 0);
+
+		txdrv = 8;
+	} else {
+		txdrv = 4;
+	}
+
+	/* Modify HWTRAP first to allow direct access to internal PHYs */
+	mt753x_reg_read(priv, HWTRAP_REG, &val);
+	val |= CHG_TRAP;
+	val &= ~C_MDIO_BPS;
+	mt753x_reg_write(priv, MHWTRAP_REG, val);
+
+	/* Calculate the phy base address */
+	val = ((val & SMI_ADDR_M) >> SMI_ADDR_S) << 3;
+	priv->phy_base = (val | 0x7) + 1;
+
+	/* Turn off PHYs */
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mtk_mii_read(priv->epriv.eth, phy_addr, MII_BMCR);
+		phy_val |= BMCR_PDOWN;
+		mtk_mii_write(priv->epriv.eth, phy_addr, MII_BMCR, phy_val);
+	}
+
+	/* Force MAC link down before reset */
+	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE);
+	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE);
+
+	/* MT7530 reset */
+	mt753x_reg_write(priv, SYS_CTRL_REG, SW_SYS_RST | SW_REG_RST);
+	udelay(100);
+
+	val = (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
+	      MAC_MODE | FORCE_MODE |
+	      MAC_TX_EN | MAC_RX_EN |
+	      BKOFF_EN | BACKPR_EN |
+	      (SPEED_1000M << FORCE_SPD_S) |
+	      FORCE_DPX | FORCE_LINK;
+
+	/* MT7530 Port6: Forced 1000M/FD, FC disabled */
+	priv->pmcr = val;
+
+	/* MT7530 Port5: Forced link down */
+	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE);
+
+	/* Keep MAC link down before starting eth */
+	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE);
+
+	/* MT7530 Port6: Set to RGMII */
+	mt753x_reg_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_M, P6_INTF_MODE_RGMII);
+
+	/* Hardware Trap: Enable Port6, Disable Port5 */
+	mt753x_reg_read(priv, HWTRAP_REG, &val);
+	val |= CHG_TRAP | LOOPDET_DIS | P5_INTF_DIS |
+	       (P5_INTF_SEL_GMAC5 << P5_INTF_SEL_S) |
+	       (P5_INTF_MODE_RGMII << P5_INTF_MODE_S);
+	val &= ~(C_MDIO_BPS | P6_INTF_DIS);
+	mt753x_reg_write(priv, MHWTRAP_REG, val);
+
+	/* Setup switch core pll */
+	mt7530_pad_clk_setup(priv, priv->epriv.phy_interface);
+
+	/* Lower Tx Driving for TRGMII path */
+	for (i = 0 ; i < NUM_TRGMII_CTRL ; i++)
+		mt753x_reg_write(priv, MT7530_TRGMII_TD_ODT(i),
+				 (txdrv << TD_DM_DRVP_S) |
+				 (txdrv << TD_DM_DRVN_S));
+
+	for (i = 0 ; i < NUM_TRGMII_CTRL; i++)
+		mt753x_reg_rmw(priv, MT7530_TRGMII_RD(i), RD_TAP_M, 16);
+
+	/* Enable port isolation to block inter-port communication */
+	mt753x_port_isolation(priv);
+
+	/* Turn on PHYs */
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mtk_mii_read(priv->epriv.eth, phy_addr, MII_BMCR);
+		phy_val &= ~BMCR_PDOWN;
+		mtk_mii_write(priv->epriv.eth, phy_addr, MII_BMCR, phy_val);
+	}
+
+	return mt7530_mdio_register(priv);
+}
+
+static int mt7530_cleanup(struct mtk_eth_switch_priv *swpriv)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+
+	mdio_unregister(priv->mdio_bus);
+
+	return 0;
+}
+
+static int mt7530_detect(struct mtk_eth_priv *priv)
+{
+	int ret;
+	u32 rev;
+
+	ret = __mt753x_mdio_reg_read(priv, MT753X_DFL_SMI_ADDR, CHIP_REV, &rev);
+	if (ret)
+		return ret;
+
+	if (((rev & CHIP_NAME_M) >> CHIP_NAME_S) == 0x7530)
+		return 0;
+
+	return -ENODEV;
+}
+
+MTK_ETH_SWITCH(mt7530) = {
+	.name = "mt7530",
+	.desc = "MediaTek MT7530",
+	.priv_size = sizeof(struct mt753x_switch_priv),
+	.reset_wait_time = 1000,
+
+	.detect = mt7530_detect,
+	.setup = mt7530_setup,
+	.cleanup = mt7530_cleanup,
+	.mac_control = mt7530_mac_control,
+};
diff --git a/drivers/net/mtk_eth/mt7531.c b/drivers/net/mtk_eth/mt7531.c
new file mode 100644
index 00000000000..32d6bebbbdb
--- /dev/null
+++ b/drivers/net/mtk_eth/mt7531.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ *
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ * Author: Mark Lee <mark-mc.lee@mediatek.com>
+ */
+
+#include <miiphy.h>
+#include <linux/delay.h>
+#include <linux/mdio.h>
+#include <linux/mii.h>
+#include "mtk_eth.h"
+#include "mt753x.h"
+
+#define CHIP_REV			0x781C
+#define CHIP_NAME_S			16
+#define CHIP_NAME_M			0xffff0000
+#define CHIP_REV_S			0
+#define CHIP_REV_M			0x0f
+#define CHIP_REV_E1			0x0
+
+static int mt7531_core_reg_read(struct mt753x_switch_priv *priv, u32 reg)
+{
+	u8 phy_addr = MT753X_PHY_ADDR(priv->phy_base, 0);
+
+	return mt7531_mmd_read(priv, phy_addr, 0x1f, reg);
+}
+
+static void mt7531_core_reg_write(struct mt753x_switch_priv *priv, u32 reg,
+				  u32 val)
+{
+	u8 phy_addr = MT753X_PHY_ADDR(priv->phy_base, 0);
+
+	mt7531_mmd_write(priv, phy_addr, 0x1f, reg, val);
+}
+
+static void mt7531_core_pll_setup(struct mt753x_switch_priv *priv)
+{
+	/* Step 1 : Disable MT7531 COREPLL */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, EN_COREPLL, 0);
+
+	/* Step 2: switch to XTAL output */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, SW_CLKSW, SW_CLKSW);
+
+	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_EN, 0);
+
+	/* Step 3: disable PLLGP and enable program PLLGP */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, SW_PLLGP, SW_PLLGP);
+
+	/* Step 4: program COREPLL output frequency to 500MHz */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_POSDIV_M,
+		       2 << RG_COREPLL_POSDIV_S);
+	udelay(25);
+
+	/* Currently, support XTAL 25Mhz only */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_SDM_PCW_M,
+		       0x140000 << RG_COREPLL_SDM_PCW_S);
+
+	/* Set feedback divide ratio update signal to high */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_SDM_PCW_CHG,
+		       RG_COREPLL_SDM_PCW_CHG);
+
+	/* Wait for at least 16 XTAL clocks */
+	udelay(10);
+
+	/* Step 5: set feedback divide ratio update signal to low */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_SDM_PCW_CHG, 0);
+
+	/* add enable 325M clock for SGMII */
+	mt753x_reg_write(priv, MT7531_ANA_PLLGP_CR5, 0xad0000);
+
+	/* add enable 250SSC clock for RGMII */
+	mt753x_reg_write(priv, MT7531_ANA_PLLGP_CR2, 0x4f40000);
+
+	/*Step 6: Enable MT7531 PLL */
+	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_EN, RG_COREPLL_EN);
+
+	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, EN_COREPLL, EN_COREPLL);
+
+	udelay(25);
+}
+
+static int mt7531_port_sgmii_init(struct mt753x_switch_priv *priv, u32 port)
+{
+	if (port != 5 && port != 6) {
+		printf("mt7531: port %d is not a SGMII port\n", port);
+		return -EINVAL;
+	}
+
+	/* Set SGMII GEN2 speed(2.5G) */
+	mt753x_reg_rmw(priv, MT7531_PHYA_CTRL_SIGNAL3(port), SGMSYS_SPEED_MASK,
+		       FIELD_PREP(SGMSYS_SPEED_MASK, SGMSYS_SPEED_2500));
+
+	/* Disable SGMII AN */
+	mt753x_reg_rmw(priv, MT7531_PCS_CONTROL_1(port),
+		       SGMII_AN_ENABLE, 0);
+
+	/* SGMII force mode setting */
+	mt753x_reg_write(priv, MT7531_SGMII_MODE(port), SGMII_FORCE_MODE);
+
+	/* Release PHYA power down state */
+	mt753x_reg_rmw(priv, MT7531_QPHY_PWR_STATE_CTRL(port),
+		       SGMII_PHYA_PWD, 0);
+
+	return 0;
+}
+
+static int mt7531_port_rgmii_init(struct mt753x_switch_priv *priv, u32 port)
+{
+	u32 val;
+
+	if (port != 5) {
+		printf("error: RGMII mode is not available for port %d\n",
+		       port);
+		return -EINVAL;
+	}
+
+	mt753x_reg_read(priv, MT7531_CLKGEN_CTRL, &val);
+	val |= GP_CLK_EN;
+	val &= ~GP_MODE_M;
+	val |= GP_MODE_RGMII << GP_MODE_S;
+	val |= TXCLK_NO_REVERSE;
+	val |= RXCLK_NO_DELAY;
+	val &= ~CLK_SKEW_IN_M;
+	val |= CLK_SKEW_IN_NO_CHANGE << CLK_SKEW_IN_S;
+	val &= ~CLK_SKEW_OUT_M;
+	val |= CLK_SKEW_OUT_NO_CHANGE << CLK_SKEW_OUT_S;
+	mt753x_reg_write(priv, MT7531_CLKGEN_CTRL, val);
+
+	return 0;
+}
+
+static void mt7531_phy_setting(struct mt753x_switch_priv *priv)
+{
+	int i;
+	u32 val;
+
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		/* Enable HW auto downshift */
+		mt7531_mii_write(priv, i, 0x1f, 0x1);
+		val = mt7531_mii_read(priv, i, PHY_EXT_REG_14);
+		val |= PHY_EN_DOWN_SHFIT;
+		mt7531_mii_write(priv, i, PHY_EXT_REG_14, val);
+
+		/* PHY link down power saving enable */
+		val = mt7531_mii_read(priv, i, PHY_EXT_REG_17);
+		val |= PHY_LINKDOWN_POWER_SAVING_EN;
+		mt7531_mii_write(priv, i, PHY_EXT_REG_17, val);
+
+		val = mt7531_mmd_read(priv, i, 0x1e, PHY_DEV1E_REG_0C6);
+		val &= ~PHY_POWER_SAVING_M;
+		val |= PHY_POWER_SAVING_TX << PHY_POWER_SAVING_S;
+		mt7531_mmd_write(priv, i, 0x1e, PHY_DEV1E_REG_0C6, val);
+	}
+}
+
+static void mt7531_mac_control(struct mtk_eth_switch_priv *swpriv, bool enable)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	u32 pmcr = FORCE_MODE_LNK;
+
+	if (enable)
+		pmcr = priv->pmcr;
+
+	mt753x_reg_write(priv, PMCR_REG(5), pmcr);
+	mt753x_reg_write(priv, PMCR_REG(6), pmcr);
+}
+
+static int mt7531_setup(struct mtk_eth_switch_priv *swpriv)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	u32 i, val, pmcr, port5_sgmii;
+	u16 phy_addr, phy_val;
+
+	priv->smi_addr = MT753X_DFL_SMI_ADDR;
+	priv->phy_base = (priv->smi_addr + 1) & MT753X_SMI_ADDR_MASK;
+	priv->reg_read = mt753x_mdio_reg_read;
+	priv->reg_write = mt753x_mdio_reg_write;
+
+	/* Turn off PHYs */
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val |= BMCR_PDOWN;
+		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+	}
+
+	/* Force MAC link down before reset */
+	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE_LNK);
+	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE_LNK);
+
+	/* Switch soft reset */
+	mt753x_reg_write(priv, SYS_CTRL_REG, SW_SYS_RST | SW_REG_RST);
+	udelay(100);
+
+	/* Enable MDC input Schmitt Trigger */
+	mt753x_reg_rmw(priv, MT7531_SMT0_IOLB, SMT_IOLB_5_SMI_MDC_EN,
+		       SMT_IOLB_5_SMI_MDC_EN);
+
+	mt7531_core_pll_setup(priv);
+
+	mt753x_reg_read(priv, MT7531_TOP_SIG_SR, &val);
+	port5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
+
+	/* port5 support either RGMII or SGMII, port6 only support SGMII. */
+	switch (priv->epriv.phy_interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		if (!port5_sgmii)
+			mt7531_port_rgmii_init(priv, 5);
+		break;
+
+	case PHY_INTERFACE_MODE_2500BASEX:
+		mt7531_port_sgmii_init(priv, 6);
+		if (port5_sgmii)
+			mt7531_port_sgmii_init(priv, 5);
+		break;
+
+	default:
+		break;
+	}
+
+	pmcr = MT7531_FORCE_MODE |
+	       (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
+	       MAC_MODE | MAC_TX_EN | MAC_RX_EN |
+	       BKOFF_EN | BACKPR_EN |
+	       FORCE_RX_FC | FORCE_TX_FC |
+	       (SPEED_1000M << FORCE_SPD_S) | FORCE_DPX |
+	       FORCE_LINK;
+
+	priv->pmcr = pmcr;
+
+	/* Keep MAC link down before starting eth */
+	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE_LNK);
+	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE_LNK);
+
+	/* Enable port isolation to block inter-port communication */
+	mt753x_port_isolation(priv);
+
+	/* Turn on PHYs */
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val &= ~BMCR_PDOWN;
+		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+	}
+
+	mt7531_phy_setting(priv);
+
+	/* Enable Internal PHYs */
+	val = mt7531_core_reg_read(priv, CORE_PLL_GROUP4);
+	val |= MT7531_BYPASS_MODE;
+	val &= ~MT7531_POWER_ON_OFF;
+	mt7531_core_reg_write(priv, CORE_PLL_GROUP4, val);
+
+	return mt7531_mdio_register(priv);
+}
+
+static int mt7531_cleanup(struct mtk_eth_switch_priv *swpriv)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+
+	mdio_unregister(priv->mdio_bus);
+
+	return 0;
+}
+
+static int mt7531_detect(struct mtk_eth_priv *priv)
+{
+	int ret;
+	u32 rev;
+
+	ret = __mt753x_mdio_reg_read(priv, MT753X_DFL_SMI_ADDR, CHIP_REV, &rev);
+	if (ret)
+		return ret;
+
+	if (((rev & CHIP_NAME_M) >> CHIP_NAME_S) == 0x7531)
+		return 0;
+
+	return -ENODEV;
+}
+
+MTK_ETH_SWITCH(mt7531) = {
+	.name = "mt7531",
+	.desc = "MediaTek MT7531",
+	.priv_size = sizeof(struct mt753x_switch_priv),
+	.reset_wait_time = 200,
+
+	.detect = mt7531_detect,
+	.setup = mt7531_setup,
+	.cleanup = mt7531_cleanup,
+	.mac_control = mt7531_mac_control,
+};
diff --git a/drivers/net/mtk_eth/mt753x.c b/drivers/net/mtk_eth/mt753x.c
new file mode 100644
index 00000000000..cdd52f3ff1b
--- /dev/null
+++ b/drivers/net/mtk_eth/mt753x.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ *
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ * Author: Mark Lee <mark-mc.lee@mediatek.com>
+ */
+
+#include <errno.h>
+#include <time.h>
+#include "mtk_eth.h"
+#include "mt753x.h"
+
+/*
+ * MT753x Internal Register Address Bits
+ * -------------------------------------------------------------------
+ * | 15  14  13  12  11  10   9   8   7   6 | 5   4   3   2 | 1   0  |
+ * |----------------------------------------|---------------|--------|
+ * |              Page Address              |  Reg Address  | Unused |
+ * -------------------------------------------------------------------
+ */
+
+int __mt753x_mdio_reg_read(struct mtk_eth_priv *priv, u32 smi_addr, u32 reg,
+			   u32 *data)
+{
+	int ret, low_word, high_word;
+
+	/* Write page address */
+	ret = mtk_mii_write(priv, smi_addr, 0x1f, reg >> 6);
+	if (ret)
+		return ret;
+
+	/* Read low word */
+	low_word = mtk_mii_read(priv, smi_addr, (reg >> 2) & 0xf);
+	if (low_word < 0)
+		return low_word;
+
+	/* Read high word */
+	high_word = mtk_mii_read(priv, smi_addr, 0x10);
+	if (high_word < 0)
+		return high_word;
+
+	if (data)
+		*data = ((u32)high_word << 16) | (low_word & 0xffff);
+
+	return 0;
+}
+
+int mt753x_mdio_reg_read(struct mt753x_switch_priv *priv, u32 reg, u32 *data)
+{
+	return __mt753x_mdio_reg_read(priv->epriv.eth, priv->smi_addr, reg,
+				      data);
+}
+
+int mt753x_mdio_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data)
+{
+	int ret;
+
+	/* Write page address */
+	ret = mtk_mii_write(priv->epriv.eth, priv->smi_addr, 0x1f, reg >> 6);
+	if (ret)
+		return ret;
+
+	/* Write low word */
+	ret = mtk_mii_write(priv->epriv.eth, priv->smi_addr, (reg >> 2) & 0xf,
+			    data & 0xffff);
+	if (ret)
+		return ret;
+
+	/* Write high word */
+	return mtk_mii_write(priv->epriv.eth, priv->smi_addr, 0x10, data >> 16);
+}
+
+int mt753x_reg_read(struct mt753x_switch_priv *priv, u32 reg, u32 *data)
+{
+	return priv->reg_read(priv, reg, data);
+}
+
+int mt753x_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data)
+{
+	return priv->reg_write(priv, reg, data);
+}
+
+void mt753x_reg_rmw(struct mt753x_switch_priv *priv, u32 reg, u32 clr, u32 set)
+{
+	u32 val;
+
+	priv->reg_read(priv, reg, &val);
+	val &= ~clr;
+	val |= set;
+	priv->reg_write(priv, reg, val);
+}
+
+/* Indirect MDIO clause 22/45 access */
+static int mt7531_mii_rw(struct mt753x_switch_priv *priv, int phy, int reg,
+			 u16 data, u32 cmd, u32 st)
+{
+	u32 val, timeout_ms;
+	ulong timeout;
+	int ret = 0;
+
+	val = (st << MDIO_ST_S) |
+	      ((cmd << MDIO_CMD_S) & MDIO_CMD_M) |
+	      ((phy << MDIO_PHY_ADDR_S) & MDIO_PHY_ADDR_M) |
+	      ((reg << MDIO_REG_ADDR_S) & MDIO_REG_ADDR_M);
+
+	if (cmd == MDIO_CMD_WRITE || cmd == MDIO_CMD_ADDR)
+		val |= data & MDIO_RW_DATA_M;
+
+	mt753x_reg_write(priv, MT7531_PHY_IAC, val | PHY_ACS_ST);
+
+	timeout_ms = 100;
+	timeout = get_timer(0);
+	while (1) {
+		mt753x_reg_read(priv, MT7531_PHY_IAC, &val);
+
+		if ((val & PHY_ACS_ST) == 0)
+			break;
+
+		if (get_timer(timeout) > timeout_ms)
+			return -ETIMEDOUT;
+	}
+
+	if (cmd == MDIO_CMD_READ || cmd == MDIO_CMD_READ_C45) {
+		mt753x_reg_read(priv, MT7531_PHY_IAC, &val);
+		ret = val & MDIO_RW_DATA_M;
+	}
+
+	return ret;
+}
+
+int mt7531_mii_read(struct mt753x_switch_priv *priv, u8 phy, u8 reg)
+{
+	u8 phy_addr;
+
+	if (phy >= MT753X_NUM_PHYS)
+		return -EINVAL;
+
+	phy_addr = MT753X_PHY_ADDR(priv->phy_base, phy);
+
+	return mt7531_mii_rw(priv, phy_addr, reg, 0, MDIO_CMD_READ,
+			     MDIO_ST_C22);
+}
+
+int mt7531_mii_write(struct mt753x_switch_priv *priv, u8 phy, u8 reg, u16 val)
+{
+	u8 phy_addr;
+
+	if (phy >= MT753X_NUM_PHYS)
+		return -EINVAL;
+
+	phy_addr = MT753X_PHY_ADDR(priv->phy_base, phy);
+
+	return mt7531_mii_rw(priv, phy_addr, reg, val, MDIO_CMD_WRITE,
+			     MDIO_ST_C22);
+}
+
+int mt7531_mmd_read(struct mt753x_switch_priv *priv, u8 addr, u8 devad,
+		    u16 reg)
+{
+	u8 phy_addr;
+	int ret;
+
+	if (addr >= MT753X_NUM_PHYS)
+		return -EINVAL;
+
+	phy_addr = MT753X_PHY_ADDR(priv->phy_base, addr);
+
+	ret = mt7531_mii_rw(priv, phy_addr, devad, reg, MDIO_CMD_ADDR,
+			    MDIO_ST_C45);
+	if (ret)
+		return ret;
+
+	return mt7531_mii_rw(priv, phy_addr, devad, 0, MDIO_CMD_READ_C45,
+			     MDIO_ST_C45);
+}
+
+int mt7531_mmd_write(struct mt753x_switch_priv *priv, u8 addr, u8 devad,
+		     u16 reg, u16 val)
+{
+	u8 phy_addr;
+	int ret;
+
+	if (addr >= MT753X_NUM_PHYS)
+		return 0;
+
+	phy_addr = MT753X_PHY_ADDR(priv->phy_base, addr);
+
+	ret = mt7531_mii_rw(priv, phy_addr, devad, reg, MDIO_CMD_ADDR,
+			    MDIO_ST_C45);
+	if (ret)
+		return ret;
+
+	return mt7531_mii_rw(priv, phy_addr, devad, val, MDIO_CMD_WRITE,
+			     MDIO_ST_C45);
+}
+
+static int mt7531_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
+{
+	struct mt753x_switch_priv *priv = bus->priv;
+
+	if (devad < 0)
+		return mt7531_mii_read(priv, addr, reg);
+
+	return mt7531_mmd_read(priv, addr, devad, reg);
+}
+
+static int mt7531_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
+			     u16 val)
+{
+	struct mt753x_switch_priv *priv = bus->priv;
+
+	if (devad < 0)
+		return mt7531_mii_write(priv, addr, reg, val);
+
+	return mt7531_mmd_write(priv, addr, devad, reg, val);
+}
+
+int mt7531_mdio_register(struct mt753x_switch_priv *priv)
+{
+	struct mii_dev *mdio_bus = mdio_alloc();
+	int ret;
+
+	if (!mdio_bus)
+		return -ENOMEM;
+
+	mdio_bus->read = mt7531_mdio_read;
+	mdio_bus->write = mt7531_mdio_write;
+	snprintf(mdio_bus->name, sizeof(mdio_bus->name), priv->epriv.sw->name);
+
+	mdio_bus->priv = priv;
+
+	ret = mdio_register(mdio_bus);
+	if (ret) {
+		mdio_free(mdio_bus);
+		return ret;
+	}
+
+	priv->mdio_bus = mdio_bus;
+
+	return 0;
+}
+
+void mt753x_port_isolation(struct mt753x_switch_priv *priv)
+{
+	u32 i;
+
+	for (i = 0; i < MT753X_NUM_PORTS; i++) {
+		/* Set port matrix mode */
+		if (i != 6)
+			mt753x_reg_write(priv, PCR_REG(i),
+					 (0x40 << PORT_MATRIX_S));
+		else
+			mt753x_reg_write(priv, PCR_REG(i),
+					 (0x3f << PORT_MATRIX_S));
+
+		/* Set port mode to user port */
+		mt753x_reg_write(priv, PVC_REG(i),
+				 (0x8100 << STAG_VPID_S) |
+				 (VLAN_ATTR_USER << VLAN_ATTR_S));
+	}
+}
diff --git a/drivers/net/mtk_eth/mt753x.h b/drivers/net/mtk_eth/mt753x.h
new file mode 100644
index 00000000000..65046a1421c
--- /dev/null
+++ b/drivers/net/mtk_eth/mt753x.h
@@ -0,0 +1,286 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ *
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ * Author: Mark Lee <mark-mc.lee@mediatek.com>
+ */
+
+#ifndef _MTK_ETH_MT753X_H_
+#define _MTK_ETH_MT753X_H_
+
+#include <phy.h>
+#include <miiphy.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+
+struct mtk_eth_priv;
+
+#define MT753X_NUM_PHYS		5
+#define MT753X_NUM_PORTS	7
+#define MT753X_DFL_SMI_ADDR	31
+#define MT753X_SMI_ADDR_MASK	0x1f
+
+#define MT753X_PHY_ADDR(base, addr) \
+	(((base) + (addr)) & 0x1f)
+
+/* MT7530 Registers */
+#define PCR_REG(p)			(0x2004 + (p) * 0x100)
+#define PORT_MATRIX_S			16
+#define PORT_MATRIX_M			0xff0000
+
+#define PVC_REG(p)			(0x2010 + (p) * 0x100)
+#define STAG_VPID_S			16
+#define STAG_VPID_M			0xffff0000
+#define VLAN_ATTR_S			6
+#define VLAN_ATTR_M			0xc0
+
+/* VLAN_ATTR: VLAN attributes */
+#define VLAN_ATTR_USER			0
+#define VLAN_ATTR_STACK			1
+#define VLAN_ATTR_TRANSLATION		2
+#define VLAN_ATTR_TRANSPARENT		3
+
+#define PMCR_REG(p)			(0x3000 + (p) * 0x100)
+/* XXX: all fields of MT7530 are defined under GMAC_PORT_MCR
+ * MT7531 specific fields are defined below
+ */
+#define FORCE_MODE_EEE1G		BIT(25)
+#define FORCE_MODE_EEE100		BIT(26)
+#define FORCE_MODE_TX_FC		BIT(27)
+#define FORCE_MODE_RX_FC		BIT(28)
+#define FORCE_MODE_DPX			BIT(29)
+#define FORCE_MODE_SPD			BIT(30)
+#define FORCE_MODE_LNK			BIT(31)
+#define MT7531_FORCE_MODE		FORCE_MODE_TX_FC | FORCE_MODE_RX_FC | \
+					FORCE_MODE_DPX   | FORCE_MODE_SPD | \
+					FORCE_MODE_LNK
+#define MT7988_FORCE_MODE		FORCE_MODE_TX_FC | FORCE_MODE_RX_FC | \
+					FORCE_MODE_DPX   | FORCE_MODE_SPD | \
+					FORCE_MODE_LNK
+
+/* MT7531 SGMII Registers */
+#define MT7531_SGMII_REG_BASE		0x5000
+#define MT7531_SGMII_REG_PORT_BASE	0x1000
+#define MT7531_SGMII_REG(p, r)		(MT7531_SGMII_REG_BASE + \
+					(p) * MT7531_SGMII_REG_PORT_BASE + (r))
+#define MT7531_PCS_CONTROL_1(p)		MT7531_SGMII_REG(((p) - 5), 0x00)
+#define MT7531_SGMII_MODE(p)		MT7531_SGMII_REG(((p) - 5), 0x20)
+#define MT7531_QPHY_PWR_STATE_CTRL(p)	MT7531_SGMII_REG(((p) - 5), 0xe8)
+#define MT7531_PHYA_CTRL_SIGNAL3(p)	MT7531_SGMII_REG(((p) - 5), 0x128)
+#define MT7531_PHYA_ANA_SYSPLL(p)	MT7531_SGMII_REG(((p) - 5), 0x158)
+/* XXX: all fields of MT7531 SGMII  are defined under SGMSYS */
+
+/* MT753x System Control Register */
+#define SYS_CTRL_REG			0x7000
+#define SW_PHY_RST			BIT(2)
+#define SW_SYS_RST			BIT(1)
+#define SW_REG_RST			BIT(0)
+
+/* MT7531  */
+#define MT7531_PHY_IAC			0x701c
+/* XXX: all fields are defined under GMAC_PIAC_REG */
+
+#define MT7531_CLKGEN_CTRL		0x7500
+#define CLK_SKEW_OUT_S			8
+#define CLK_SKEW_OUT_M			0x300
+#define CLK_SKEW_IN_S			6
+#define CLK_SKEW_IN_M			0xc0
+#define RXCLK_NO_DELAY			BIT(5)
+#define TXCLK_NO_REVERSE		BIT(4)
+#define GP_MODE_S			1
+#define GP_MODE_M			0x06
+#define GP_CLK_EN			BIT(0)
+
+/* Values of GP_MODE */
+#define GP_MODE_RGMII			0
+#define GP_MODE_MII			1
+#define GP_MODE_REV_MII			2
+
+/* Values of CLK_SKEW_IN */
+#define CLK_SKEW_IN_NO_CHANGE		0
+#define CLK_SKEW_IN_DELAY_100PPS	1
+#define CLK_SKEW_IN_DELAY_200PPS	2
+#define CLK_SKEW_IN_REVERSE		3
+
+/* Values of CLK_SKEW_OUT */
+#define CLK_SKEW_OUT_NO_CHANGE		0
+#define CLK_SKEW_OUT_DELAY_100PPS	1
+#define CLK_SKEW_OUT_DELAY_200PPS	2
+#define CLK_SKEW_OUT_REVERSE		3
+
+#define HWTRAP_REG			0x7800
+/* MT7530 Modified Hardware Trap Status Registers */
+#define MHWTRAP_REG			0x7804
+#define CHG_TRAP			BIT(16)
+#define LOOPDET_DIS			BIT(14)
+#define P5_INTF_SEL_S			13
+#define P5_INTF_SEL_M			0x2000
+#define SMI_ADDR_S			11
+#define SMI_ADDR_M			0x1800
+#define XTAL_FSEL_S			9
+#define XTAL_FSEL_M			0x600
+#define P6_INTF_DIS			BIT(8)
+#define P5_INTF_MODE_S			7
+#define P5_INTF_MODE_M			0x80
+#define P5_INTF_DIS			BIT(6)
+#define C_MDIO_BPS			BIT(5)
+#define CHIP_MODE_S			0
+#define CHIP_MODE_M			0x0f
+
+/* P5_INTF_SEL: Interface type of Port5 */
+#define P5_INTF_SEL_GPHY		0
+#define P5_INTF_SEL_GMAC5		1
+
+/* P5_INTF_MODE: Interface mode of Port5 */
+#define P5_INTF_MODE_GMII_MII		0
+#define P5_INTF_MODE_RGMII		1
+
+#define MT7530_P6ECR			0x7830
+#define P6_INTF_MODE_M			0x3
+#define P6_INTF_MODE_S			0
+
+/* P6_INTF_MODE: Interface mode of Port6 */
+#define P6_INTF_MODE_RGMII		0
+#define P6_INTF_MODE_TRGMII		1
+
+#define MT7530_TRGMII_RD(n)		(0x7a10 + (n) * 8)
+#define RD_TAP_S			0
+#define RD_TAP_M			0x7f
+
+#define MT7530_TRGMII_TD_ODT(n)		(0x7a54 + (n) * 8)
+/* XXX: all fields are defined under GMAC_TRGMII_TD_ODT */
+
+/* TOP Signals Status Register */
+#define MT7531_TOP_SIG_SR		0x780c
+#define PAD_MCM_SMI_EN			BIT(0)
+#define PAD_DUAL_SGMII_EN		BIT(1)
+
+/* MT7531 PLLGP Registers */
+#define MT7531_PLLGP_EN			0x7820
+#define EN_COREPLL			BIT(2)
+#define SW_CLKSW			BIT(1)
+#define SW_PLLGP			BIT(0)
+
+#define MT7531_PLLGP_CR0		0x78a8
+#define RG_COREPLL_EN			BIT(22)
+#define RG_COREPLL_POSDIV_S		23
+#define RG_COREPLL_POSDIV_M		0x3800000
+#define RG_COREPLL_SDM_PCW_S		1
+#define RG_COREPLL_SDM_PCW_M		0x3ffffe
+#define RG_COREPLL_SDM_PCW_CHG		BIT(0)
+
+/* MT7531 RGMII and SGMII PLL clock */
+#define MT7531_ANA_PLLGP_CR2		0x78b0
+#define MT7531_ANA_PLLGP_CR5		0x78bc
+
+/* MT7531 GPIO GROUP IOLB SMT0 Control */
+#define MT7531_SMT0_IOLB		0x7f04
+#define SMT_IOLB_5_SMI_MDC_EN		BIT(5)
+
+/* MT7530 GPHY MDIO MMD Registers */
+#define CORE_PLL_GROUP2			0x401
+#define RG_SYSPLL_EN_NORMAL		BIT(15)
+#define RG_SYSPLL_VODEN			BIT(14)
+#define RG_SYSPLL_POSDIV_S		5
+#define RG_SYSPLL_POSDIV_M		0x60
+
+#define CORE_PLL_GROUP4			0x403
+#define MT7531_BYPASS_MODE		BIT(4)
+#define MT7531_POWER_ON_OFF		BIT(5)
+#define RG_SYSPLL_DDSFBK_EN		BIT(12)
+#define RG_SYSPLL_BIAS_EN		BIT(11)
+#define RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+
+#define CORE_PLL_GROUP5			0x404
+#define RG_LCDDS_PCW_NCPO1_S		0
+#define RG_LCDDS_PCW_NCPO1_M		0xffff
+
+#define CORE_PLL_GROUP6			0x405
+#define RG_LCDDS_PCW_NCPO0_S		0
+#define RG_LCDDS_PCW_NCPO0_M		0xffff
+
+#define CORE_PLL_GROUP7			0x406
+#define RG_LCDDS_PWDB			BIT(15)
+#define RG_LCDDS_ISO_EN			BIT(13)
+#define RG_LCCDS_C_S			4
+#define RG_LCCDS_C_M			0x70
+#define RG_LCDDS_PCW_NCPO_CHG		BIT(3)
+
+#define CORE_PLL_GROUP10		0x409
+#define RG_LCDDS_SSC_DELTA_S		0
+#define RG_LCDDS_SSC_DELTA_M		0xfff
+
+#define CORE_PLL_GROUP11		0x40a
+#define RG_LCDDS_SSC_DELTA1_S		0
+#define RG_LCDDS_SSC_DELTA1_M		0xfff
+
+#define CORE_GSWPLL_GRP1		0x40d
+#define RG_GSWPLL_POSDIV_200M_S		12
+#define RG_GSWPLL_POSDIV_200M_M		0x3000
+#define RG_GSWPLL_EN_PRE		BIT(11)
+#define RG_GSWPLL_FBKDIV_200M_S		0
+#define RG_GSWPLL_FBKDIV_200M_M		0xff
+
+#define CORE_GSWPLL_GRP2		0x40e
+#define RG_GSWPLL_POSDIV_500M_S		8
+#define RG_GSWPLL_POSDIV_500M_M		0x300
+#define RG_GSWPLL_FBKDIV_500M_S		0
+#define RG_GSWPLL_FBKDIV_500M_M		0xff
+
+#define CORE_TRGMII_GSW_CLK_CG		0x410
+#define REG_GSWCK_EN			BIT(0)
+#define REG_TRGMIICK_EN			BIT(1)
+
+/* Extend PHY Control Register 3 */
+#define PHY_EXT_REG_14			0x14
+
+/* Fields of PHY_EXT_REG_14 */
+#define PHY_EN_DOWN_SHFIT		BIT(4)
+
+/* Extend PHY Control Register 4 */
+#define PHY_EXT_REG_17			0x17
+
+/* Fields of PHY_EXT_REG_17 */
+#define PHY_LINKDOWN_POWER_SAVING_EN	BIT(4)
+
+/* PHY RXADC Control Register 7 */
+#define PHY_DEV1E_REG_0C6		0x0c6
+
+/* Fields of PHY_DEV1E_REG_0C6 */
+#define PHY_POWER_SAVING_S		8
+#define PHY_POWER_SAVING_M		0x300
+#define PHY_POWER_SAVING_TX		0x0
+
+struct mt753x_switch_priv {
+	struct mtk_eth_switch_priv epriv;
+	struct mii_dev *mdio_bus;
+	u32 smi_addr;
+	u32 phy_base;
+	u32 pmcr;
+
+	int (*reg_read)(struct mt753x_switch_priv *priv, u32 reg, u32 *data);
+	int (*reg_write)(struct mt753x_switch_priv *priv, u32 reg, u32 data);
+};
+
+int __mt753x_mdio_reg_read(struct mtk_eth_priv *priv, u32 smi_addr, u32 reg,
+			   u32 *data);
+int mt753x_mdio_reg_read(struct mt753x_switch_priv *priv, u32 reg, u32 *data);
+int mt753x_mdio_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data);
+
+int mt753x_reg_read(struct mt753x_switch_priv *priv, u32 reg, u32 *data);
+int mt753x_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data);
+void mt753x_reg_rmw(struct mt753x_switch_priv *priv, u32 reg, u32 clr, u32 set);
+
+int mt7531_mii_read(struct mt753x_switch_priv *priv, u8 phy, u8 reg);
+int mt7531_mii_write(struct mt753x_switch_priv *priv, u8 phy, u8 reg, u16 val);
+int mt7531_mmd_read(struct mt753x_switch_priv *priv, u8 addr, u8 devad,
+		    u16 reg);
+int mt7531_mmd_write(struct mt753x_switch_priv *priv, u8 addr, u8 devad,
+		     u16 reg, u16 val);
+
+int mt7531_mdio_register(struct mt753x_switch_priv *priv);
+
+void mt753x_port_isolation(struct mt753x_switch_priv *priv);
+
+#endif /* _MTK_ETH_MT753X_H_ */
diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
new file mode 100644
index 00000000000..a416d87840c
--- /dev/null
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ *
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ * Author: Mark Lee <mark-mc.lee@mediatek.com>
+ */
+
+#include <miiphy.h>
+#include <linux/delay.h>
+#include <linux/mdio.h>
+#include <linux/mii.h>
+#include <linux/io.h>
+#include "mtk_eth.h"
+#include "mt753x.h"
+
+static int mt7988_reg_read(struct mt753x_switch_priv *priv, u32 reg, u32 *data)
+{
+	*data = readl(priv->epriv.ethsys_base + GSW_BASE + reg);
+
+	return 0;
+}
+
+static int mt7988_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data)
+{
+	writel(data, priv->epriv.ethsys_base + GSW_BASE + reg);
+
+	return 0;
+}
+
+static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
+{
+	u16 val;
+	u32 i;
+
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		/* Enable HW auto downshift */
+		mt7531_mii_write(priv, i, 0x1f, 0x1);
+		val = mt7531_mii_read(priv, i, PHY_EXT_REG_14);
+		val |= PHY_EN_DOWN_SHFIT;
+		mt7531_mii_write(priv, i, PHY_EXT_REG_14, val);
+
+		/* PHY link down power saving enable */
+		val = mt7531_mii_read(priv, i, PHY_EXT_REG_17);
+		val |= PHY_LINKDOWN_POWER_SAVING_EN;
+		mt7531_mii_write(priv, i, PHY_EXT_REG_17, val);
+	}
+}
+
+static void mt7988_mac_control(struct mtk_eth_switch_priv *swpriv, bool enable)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	u32 pmcr = FORCE_MODE_LNK;
+
+	if (enable)
+		pmcr = priv->pmcr;
+
+	mt7988_reg_write(priv, PMCR_REG(6), pmcr);
+}
+
+static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	u16 phy_addr, phy_val;
+	u32 pmcr;
+	int i;
+
+	priv->smi_addr = MT753X_DFL_SMI_ADDR;
+	priv->phy_base = (priv->smi_addr + 1) & MT753X_SMI_ADDR_MASK;
+	priv->reg_read = mt7988_reg_read;
+	priv->reg_write = mt7988_reg_write;
+
+	/* Turn off PHYs */
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val |= BMCR_PDOWN;
+		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+	}
+
+	switch (priv->epriv.phy_interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+		/* Use CPU bridge instead of actual USXGMII path */
+
+		/* Disable GDM1 RX CRC stripping */
+		/* mtk_fe_rmw(priv, 0x500, BIT(16), 0); */
+
+		/* Set GDM1 no drop */
+		mtk_fe_rmw(priv->epriv.eth, PSE_NO_DROP_CFG_REG, 0,
+			   PSE_NO_DROP_GDM1);
+
+		/* Enable GSW CPU bridge as USXGMII */
+		/* mtk_fe_rmw(priv, 0x504, BIT(31), BIT(31)); */
+
+		/* Enable GDM1 to GSW CPU bridge */
+		mtk_gmac_rmw(priv->epriv.eth, GMAC_MAC_MISC_REG, 0, BIT(0));
+
+		/* XGMAC force link up */
+		mtk_gmac_rmw(priv->epriv.eth, GMAC_XGMAC_STS_REG, 0,
+			     P1_XGMAC_FORCE_LINK);
+
+		/* Setup GSW CPU bridge IPG */
+		mtk_gmac_rmw(priv->epriv.eth, GMAC_GSW_CFG_REG,
+			     GSWTX_IPG_M | GSWRX_IPG_M,
+			     (0xB << GSWTX_IPG_S) | (0xB << GSWRX_IPG_S));
+		break;
+	default:
+		printf("Error: MT7988 GSW does not support %s interface\n",
+		       phy_string_for_interface(priv->epriv.phy_interface));
+		break;
+	}
+
+	pmcr = MT7988_FORCE_MODE |
+	       (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
+	       MAC_MODE | MAC_TX_EN | MAC_RX_EN |
+	       BKOFF_EN | BACKPR_EN |
+	       FORCE_RX_FC | FORCE_TX_FC |
+	       (SPEED_1000M << FORCE_SPD_S) | FORCE_DPX |
+	       FORCE_LINK;
+
+	priv->pmcr = pmcr;
+
+	/* Keep MAC link down before starting eth */
+	mt7988_reg_write(priv, PMCR_REG(6), FORCE_MODE_LNK);
+
+	/* Enable port isolation to block inter-port communication */
+	mt753x_port_isolation(priv);
+
+	/* Turn on PHYs */
+	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val &= ~BMCR_PDOWN;
+		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+	}
+
+	mt7988_phy_setting(priv);
+
+	return mt7531_mdio_register(priv);
+}
+
+static int mt7531_cleanup(struct mtk_eth_switch_priv *swpriv)
+{
+	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+
+	mdio_unregister(priv->mdio_bus);
+
+	return 0;
+}
+
+MTK_ETH_SWITCH(mt7988) = {
+	.name = "mt7988",
+	.desc = "MediaTek MT7988 built-in switch",
+	.priv_size = sizeof(struct mt753x_switch_priv),
+	.reset_wait_time = 50,
+
+	.setup = mt7988_setup,
+	.cleanup = mt7531_cleanup,
+	.mac_control = mt7988_mac_control,
+};
diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth/mtk_eth.c
similarity index 62%
rename from drivers/net/mtk_eth.c
rename to drivers/net/mtk_eth/mtk_eth.c
index 454caa3cd3a..1e6b30769d1 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth/mtk_eth.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018 MediaTek Inc.
+ * Copyright (C) 2025 MediaTek Inc.
  *
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  * Author: Mark Lee <mark-mc.lee@mediatek.com>
@@ -35,14 +35,6 @@
 #define RX_TOTAL_BUF_SIZE	(NUM_RX_DESC * PKTSIZE_ALIGN)
 #define TOTAL_PKT_BUF_SIZE	(TX_TOTAL_BUF_SIZE + RX_TOTAL_BUF_SIZE)
 
-#define MT753X_NUM_PHYS		5
-#define MT753X_NUM_PORTS	7
-#define MT753X_DFL_SMI_ADDR	31
-#define MT753X_SMI_ADDR_MASK	0x1f
-
-#define MT753X_PHY_ADDR(base, addr) \
-	(((base) + (addr)) & 0x1f)
-
 #define GDMA_FWD_TO_CPU \
 	(0x20000000 | \
 	GDM_ICS_EN | \
@@ -75,32 +67,6 @@
 	(DP_DISCARD << MC_DP_S) | \
 	(DP_DISCARD << UN_DP_S))
 
-enum mtk_switch {
-	SW_NONE,
-	SW_MT7530,
-	SW_MT7531,
-	SW_MT7988,
-};
-
-/* struct mtk_soc_data -	This is the structure holding all differences
- *				among various plaforms
- * @caps			Flags shown the extra capability for the SoC
- * @ana_rgc3:			The offset for register ANA_RGC3 related to
- *				sgmiisys syscon
- * @gdma_count:			Number of GDMAs
- * @pdma_base:			Register base of PDMA block
- * @txd_size:			Tx DMA descriptor size.
- * @rxd_size:			Rx DMA descriptor size.
- */
-struct mtk_soc_data {
-	u32 caps;
-	u32 ana_rgc3;
-	u32 gdma_count;
-	u32 pdma_base;
-	u32 txd_size;
-	u32 rxd_size;
-};
-
 struct mtk_eth_priv {
 	char pkt_pool[TOTAL_PKT_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
 
@@ -113,7 +79,6 @@ struct mtk_eth_priv {
 	void __iomem *fe_base;
 	void __iomem *gmac_base;
 	void __iomem *sgmii_base;
-	void __iomem *gsw_base;
 
 	struct regmap *ethsys_regmap;
 
@@ -125,11 +90,6 @@ struct mtk_eth_priv {
 	struct regmap *toprgu_regmap;
 
 	struct mii_dev *mdio_bus;
-	int (*mii_read)(struct mtk_eth_priv *priv, u8 phy, u8 reg);
-	int (*mii_write)(struct mtk_eth_priv *priv, u8 phy, u8 reg, u16 val);
-	int (*mmd_read)(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg);
-	int (*mmd_write)(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg,
-			 u16 val);
 
 	const struct mtk_soc_data *soc;
 	int gmac_id;
@@ -143,13 +103,8 @@ struct mtk_eth_priv {
 	int phy_interface;
 	int phy_addr;
 
-	enum mtk_switch sw;
-	int (*switch_init)(struct mtk_eth_priv *priv);
-	void (*switch_mac_control)(struct mtk_eth_priv *priv, bool enable);
-	u32 mt753x_smi_addr;
-	u32 mt753x_phy_base;
-	u32 mt753x_pmcr;
-	u32 mt753x_reset_wait_time;
+	struct mtk_eth_switch_priv *swpriv;
+	const char *swname;
 
 	struct gpio_desc rst_gpio;
 	int mcm;
@@ -184,7 +139,7 @@ static void mtk_gdma_write(struct mtk_eth_priv *priv, int no, u32 reg,
 	writel(val, priv->fe_base + gdma_base + reg);
 }
 
-static void mtk_fe_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set)
+void mtk_fe_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set)
 {
 	clrsetbits_le32(priv->fe_base + reg, clr, set);
 }
@@ -199,13 +154,12 @@ static void mtk_gmac_write(struct mtk_eth_priv *priv, u32 reg, u32 val)
 	writel(val, priv->gmac_base + reg);
 }
 
-static void mtk_gmac_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set)
+void mtk_gmac_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set)
 {
 	clrsetbits_le32(priv->gmac_base + reg, clr, set);
 }
 
-static void mtk_ethsys_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr,
-			   u32 set)
+void mtk_ethsys_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set)
 {
 	uint val;
 
@@ -226,16 +180,6 @@ static void mtk_infra_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr,
 	regmap_write(priv->infra_regmap, reg, val);
 }
 
-static u32 mtk_gsw_read(struct mtk_eth_priv *priv, u32 reg)
-{
-	return readl(priv->gsw_base + reg);
-}
-
-static void mtk_gsw_write(struct mtk_eth_priv *priv, u32 reg, u32 val)
-{
-	writel(val, priv->gsw_base + reg);
-}
-
 /* Direct MDIO clause 22/45 access via SoC */
 static int mtk_mii_rw(struct mtk_eth_priv *priv, u8 phy, u8 reg, u16 data,
 		      u32 cmd, u32 st)
@@ -269,19 +213,19 @@ static int mtk_mii_rw(struct mtk_eth_priv *priv, u8 phy, u8 reg, u16 data,
 }
 
 /* Direct MDIO clause 22 read via SoC */
-static int mtk_mii_read(struct mtk_eth_priv *priv, u8 phy, u8 reg)
+int mtk_mii_read(struct mtk_eth_priv *priv, u8 phy, u8 reg)
 {
 	return mtk_mii_rw(priv, phy, reg, 0, MDIO_CMD_READ, MDIO_ST_C22);
 }
 
 /* Direct MDIO clause 22 write via SoC */
-static int mtk_mii_write(struct mtk_eth_priv *priv, u8 phy, u8 reg, u16 data)
+int mtk_mii_write(struct mtk_eth_priv *priv, u8 phy, u8 reg, u16 data)
 {
 	return mtk_mii_rw(priv, phy, reg, data, MDIO_CMD_WRITE, MDIO_ST_C22);
 }
 
 /* Direct MDIO clause 45 read via SoC */
-static int mtk_mmd_read(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg)
+int mtk_mmd_read(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg)
 {
 	int ret;
 
@@ -294,8 +238,8 @@ static int mtk_mmd_read(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg)
 }
 
 /* Direct MDIO clause 45 write via SoC */
-static int mtk_mmd_write(struct mtk_eth_priv *priv, u8 addr, u8 devad,
-			 u16 reg, u16 val)
+int mtk_mmd_write(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg,
+		  u16 val)
 {
 	int ret;
 
@@ -308,232 +252,52 @@ static int mtk_mmd_write(struct mtk_eth_priv *priv, u8 addr, u8 devad,
 }
 
 /* Indirect MDIO clause 45 read via MII registers */
-static int mtk_mmd_ind_read(struct mtk_eth_priv *priv, u8 addr, u8 devad,
-			    u16 reg)
+int mtk_mmd_ind_read(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg)
 {
 	int ret;
 
-	ret = priv->mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
-			      (MMD_ADDR << MMD_CMD_S) |
-			      ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
+	ret = mtk_mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
+			    (MMD_ADDR << MMD_CMD_S) |
+			    ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
 	if (ret)
 		return ret;
 
-	ret = priv->mii_write(priv, addr, MII_MMD_ADDR_DATA_REG, reg);
+	ret = mtk_mii_write(priv, addr, MII_MMD_ADDR_DATA_REG, reg);
 	if (ret)
 		return ret;
 
-	ret = priv->mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
-			      (MMD_DATA << MMD_CMD_S) |
-			      ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
+	ret = mtk_mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
+			    (MMD_DATA << MMD_CMD_S) |
+			    ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
 	if (ret)
 		return ret;
 
-	return priv->mii_read(priv, addr, MII_MMD_ADDR_DATA_REG);
+	return mtk_mii_read(priv, addr, MII_MMD_ADDR_DATA_REG);
 }
 
 /* Indirect MDIO clause 45 write via MII registers */
-static int mtk_mmd_ind_write(struct mtk_eth_priv *priv, u8 addr, u8 devad,
-			     u16 reg, u16 val)
+int mtk_mmd_ind_write(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg,
+		      u16 val)
 {
 	int ret;
 
-	ret = priv->mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
-			      (MMD_ADDR << MMD_CMD_S) |
-			      ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
-	if (ret)
-		return ret;
-
-	ret = priv->mii_write(priv, addr, MII_MMD_ADDR_DATA_REG, reg);
-	if (ret)
-		return ret;
-
-	ret = priv->mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
-			      (MMD_DATA << MMD_CMD_S) |
-			      ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
-	if (ret)
-		return ret;
-
-	return priv->mii_write(priv, addr, MII_MMD_ADDR_DATA_REG, val);
-}
-
-/*
- * MT7530 Internal Register Address Bits
- * -------------------------------------------------------------------
- * | 15  14  13  12  11  10   9   8   7   6 | 5   4   3   2 | 1   0  |
- * |----------------------------------------|---------------|--------|
- * |              Page Address              |  Reg Address  | Unused |
- * -------------------------------------------------------------------
- */
-
-static int mt753x_reg_read(struct mtk_eth_priv *priv, u32 reg, u32 *data)
-{
-	int ret, low_word, high_word;
-
-	if (priv->sw == SW_MT7988) {
-		*data = mtk_gsw_read(priv, reg);
-		return 0;
-	}
-
-	/* Write page address */
-	ret = mtk_mii_write(priv, priv->mt753x_smi_addr, 0x1f, reg >> 6);
+	ret = mtk_mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
+			    (MMD_ADDR << MMD_CMD_S) |
+			    ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
 	if (ret)
 		return ret;
 
-	/* Read low word */
-	low_word = mtk_mii_read(priv, priv->mt753x_smi_addr, (reg >> 2) & 0xf);
-	if (low_word < 0)
-		return low_word;
-
-	/* Read high word */
-	high_word = mtk_mii_read(priv, priv->mt753x_smi_addr, 0x10);
-	if (high_word < 0)
-		return high_word;
-
-	if (data)
-		*data = ((u32)high_word << 16) | (low_word & 0xffff);
-
-	return 0;
-}
-
-static int mt753x_reg_write(struct mtk_eth_priv *priv, u32 reg, u32 data)
-{
-	int ret;
-
-	if (priv->sw == SW_MT7988) {
-		mtk_gsw_write(priv, reg, data);
-		return 0;
-	}
-
-	/* Write page address */
-	ret = mtk_mii_write(priv, priv->mt753x_smi_addr, 0x1f, reg >> 6);
-	if (ret)
-		return ret;
-
-	/* Write low word */
-	ret = mtk_mii_write(priv, priv->mt753x_smi_addr, (reg >> 2) & 0xf,
-			    data & 0xffff);
-	if (ret)
-		return ret;
-
-	/* Write high word */
-	return mtk_mii_write(priv, priv->mt753x_smi_addr, 0x10, data >> 16);
-}
-
-static void mt753x_reg_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr,
-			   u32 set)
-{
-	u32 val;
-
-	mt753x_reg_read(priv, reg, &val);
-	val &= ~clr;
-	val |= set;
-	mt753x_reg_write(priv, reg, val);
-}
-
-/* Indirect MDIO clause 22/45 access */
-static int mt7531_mii_rw(struct mtk_eth_priv *priv, int phy, int reg, u16 data,
-			 u32 cmd, u32 st)
-{
-	ulong timeout;
-	u32 val, timeout_ms;
-	int ret = 0;
-
-	val = (st << MDIO_ST_S) |
-	      ((cmd << MDIO_CMD_S) & MDIO_CMD_M) |
-	      ((phy << MDIO_PHY_ADDR_S) & MDIO_PHY_ADDR_M) |
-	      ((reg << MDIO_REG_ADDR_S) & MDIO_REG_ADDR_M);
-
-	if (cmd == MDIO_CMD_WRITE || cmd == MDIO_CMD_ADDR)
-		val |= data & MDIO_RW_DATA_M;
-
-	mt753x_reg_write(priv, MT7531_PHY_IAC, val | PHY_ACS_ST);
-
-	timeout_ms = 100;
-	timeout = get_timer(0);
-	while (1) {
-		mt753x_reg_read(priv, MT7531_PHY_IAC, &val);
-
-		if ((val & PHY_ACS_ST) == 0)
-			break;
-
-		if (get_timer(timeout) > timeout_ms)
-			return -ETIMEDOUT;
-	}
-
-	if (cmd == MDIO_CMD_READ || cmd == MDIO_CMD_READ_C45) {
-		mt753x_reg_read(priv, MT7531_PHY_IAC, &val);
-		ret = val & MDIO_RW_DATA_M;
-	}
-
-	return ret;
-}
-
-static int mt7531_mii_ind_read(struct mtk_eth_priv *priv, u8 phy, u8 reg)
-{
-	u8 phy_addr;
-
-	if (phy >= MT753X_NUM_PHYS)
-		return -EINVAL;
-
-	phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, phy);
-
-	return mt7531_mii_rw(priv, phy_addr, reg, 0, MDIO_CMD_READ,
-			     MDIO_ST_C22);
-}
-
-static int mt7531_mii_ind_write(struct mtk_eth_priv *priv, u8 phy, u8 reg,
-				u16 val)
-{
-	u8 phy_addr;
-
-	if (phy >= MT753X_NUM_PHYS)
-		return -EINVAL;
-
-	phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, phy);
-
-	return mt7531_mii_rw(priv, phy_addr, reg, val, MDIO_CMD_WRITE,
-			     MDIO_ST_C22);
-}
-
-static int mt7531_mmd_ind_read(struct mtk_eth_priv *priv, u8 addr, u8 devad,
-			       u16 reg)
-{
-	u8 phy_addr;
-	int ret;
-
-	if (addr >= MT753X_NUM_PHYS)
-		return -EINVAL;
-
-	phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, addr);
-
-	ret = mt7531_mii_rw(priv, phy_addr, devad, reg, MDIO_CMD_ADDR,
-			    MDIO_ST_C45);
+	ret = mtk_mii_write(priv, addr, MII_MMD_ADDR_DATA_REG, reg);
 	if (ret)
 		return ret;
 
-	return mt7531_mii_rw(priv, phy_addr, devad, 0, MDIO_CMD_READ_C45,
-			     MDIO_ST_C45);
-}
-
-static int mt7531_mmd_ind_write(struct mtk_eth_priv *priv, u8 addr, u8 devad,
-				u16 reg, u16 val)
-{
-	u8 phy_addr;
-	int ret;
-
-	if (addr >= MT753X_NUM_PHYS)
-		return 0;
-
-	phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, addr);
-
-	ret = mt7531_mii_rw(priv, phy_addr, devad, reg, MDIO_CMD_ADDR,
-			    MDIO_ST_C45);
+	ret = mtk_mii_write(priv, addr, MII_MMD_ACC_CTL_REG,
+			    (MMD_DATA << MMD_CMD_S) |
+			    ((devad << MMD_DEVAD_S) & MMD_DEVAD_M));
 	if (ret)
 		return ret;
 
-	return mt7531_mii_rw(priv, phy_addr, devad, val, MDIO_CMD_WRITE,
-			     MDIO_ST_C45);
+	return mtk_mii_write(priv, addr, MII_MMD_ADDR_DATA_REG, val);
 }
 
 static int mtk_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
@@ -541,9 +305,9 @@ static int mtk_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
 	struct mtk_eth_priv *priv = bus->priv;
 
 	if (devad < 0)
-		return priv->mii_read(priv, addr, reg);
-	else
-		return priv->mmd_read(priv, addr, devad, reg);
+		return mtk_mii_read(priv, addr, reg);
+
+	return mtk_mmd_read(priv, addr, devad, reg);
 }
 
 static int mtk_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
@@ -552,9 +316,9 @@ static int mtk_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
 	struct mtk_eth_priv *priv = bus->priv;
 
 	if (devad < 0)
-		return priv->mii_write(priv, addr, reg, val);
-	else
-		return priv->mmd_write(priv, addr, devad, reg, val);
+		return mtk_mii_write(priv, addr, reg, val);
+
+	return mtk_mmd_write(priv, addr, devad, reg, val);
 }
 
 static int mtk_mdio_register(struct udevice *dev)
@@ -566,28 +330,6 @@ static int mtk_mdio_register(struct udevice *dev)
 	if (!mdio_bus)
 		return -ENOMEM;
 
-	/* Assign MDIO access APIs according to the switch/phy */
-	switch (priv->sw) {
-	case SW_MT7530:
-		priv->mii_read = mtk_mii_read;
-		priv->mii_write = mtk_mii_write;
-		priv->mmd_read = mtk_mmd_ind_read;
-		priv->mmd_write = mtk_mmd_ind_write;
-		break;
-	case SW_MT7531:
-	case SW_MT7988:
-		priv->mii_read = mt7531_mii_ind_read;
-		priv->mii_write = mt7531_mii_ind_write;
-		priv->mmd_read = mt7531_mmd_ind_read;
-		priv->mmd_write = mt7531_mmd_ind_write;
-		break;
-	default:
-		priv->mii_read = mtk_mii_read;
-		priv->mii_write = mtk_mii_write;
-		priv->mmd_read = mtk_mmd_read;
-		priv->mmd_write = mtk_mmd_write;
-	}
-
 	mdio_bus->read = mtk_mdio_read;
 	mdio_bus->write = mtk_mdio_write;
 	snprintf(mdio_bus->name, sizeof(mdio_bus->name), dev->name);
@@ -604,531 +346,91 @@ static int mtk_mdio_register(struct udevice *dev)
 	return 0;
 }
 
-static int mt753x_core_reg_read(struct mtk_eth_priv *priv, u32 reg)
-{
-	u8 phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, 0);
-
-	return priv->mmd_read(priv, phy_addr, 0x1f, reg);
-}
-
-static void mt753x_core_reg_write(struct mtk_eth_priv *priv, u32 reg, u32 val)
+static int mtk_switch_init(struct mtk_eth_priv *priv)
 {
-	u8 phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, 0);
-
-	priv->mmd_write(priv, phy_addr, 0x1f, reg, val);
-}
-
-static int mt7530_pad_clk_setup(struct mtk_eth_priv *priv, int mode)
-{
-	u32 ncpo1, ssc_delta;
-
-	switch (mode) {
-	case PHY_INTERFACE_MODE_RGMII:
-		ncpo1 = 0x0c80;
-		ssc_delta = 0x87;
-		break;
-	default:
-		printf("error: xMII mode %d not supported\n", mode);
-		return -EINVAL;
-	}
-
-	/* Disable MT7530 core clock */
-	mt753x_core_reg_write(priv, CORE_TRGMII_GSW_CLK_CG, 0);
-
-	/* Disable MT7530 PLL */
-	mt753x_core_reg_write(priv, CORE_GSWPLL_GRP1,
-			      (2 << RG_GSWPLL_POSDIV_200M_S) |
-			      (32 << RG_GSWPLL_FBKDIV_200M_S));
-
-	/* For MT7530 core clock = 500Mhz */
-	mt753x_core_reg_write(priv, CORE_GSWPLL_GRP2,
-			      (1 << RG_GSWPLL_POSDIV_500M_S) |
-			      (25 << RG_GSWPLL_FBKDIV_500M_S));
-
-	/* Enable MT7530 PLL */
-	mt753x_core_reg_write(priv, CORE_GSWPLL_GRP1,
-			      (2 << RG_GSWPLL_POSDIV_200M_S) |
-			      (32 << RG_GSWPLL_FBKDIV_200M_S) |
-			      RG_GSWPLL_EN_PRE);
-
-	udelay(20);
-
-	mt753x_core_reg_write(priv, CORE_TRGMII_GSW_CLK_CG, REG_GSWCK_EN);
-
-	/* Setup the MT7530 TRGMII Tx Clock */
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP5, ncpo1);
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP6, 0);
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP10, ssc_delta);
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP11, ssc_delta);
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP4, RG_SYSPLL_DDSFBK_EN |
-			      RG_SYSPLL_BIAS_EN | RG_SYSPLL_BIAS_LPF_EN);
-
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP2,
-			      RG_SYSPLL_EN_NORMAL | RG_SYSPLL_VODEN |
-			      (1 << RG_SYSPLL_POSDIV_S));
-
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP7,
-			      RG_LCDDS_PCW_NCPO_CHG | (3 << RG_LCCDS_C_S) |
-			      RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
-
-	/* Enable MT7530 core clock */
-	mt753x_core_reg_write(priv, CORE_TRGMII_GSW_CLK_CG,
-			      REG_GSWCK_EN | REG_TRGMIICK_EN);
-
-	return 0;
-}
-
-static void mt7530_mac_control(struct mtk_eth_priv *priv, bool enable)
-{
-	u32 pmcr = FORCE_MODE;
-
-	if (enable)
-		pmcr = priv->mt753x_pmcr;
-
-	mt753x_reg_write(priv, PMCR_REG(6), pmcr);
-}
-
-static int mt7530_setup(struct mtk_eth_priv *priv)
-{
-	u16 phy_addr, phy_val;
-	u32 val, txdrv;
-	int i;
-
-	if (!MTK_HAS_CAPS(priv->soc->caps, MTK_TRGMII_MT7621_CLK)) {
-		/* Select 250MHz clk for RGMII mode */
-		mtk_ethsys_rmw(priv, ETHSYS_CLKCFG0_REG,
-			       ETHSYS_TRGMII_CLK_SEL362_5, 0);
-
-		txdrv = 8;
-	} else {
-		txdrv = 4;
-	}
-
-	/* Modify HWTRAP first to allow direct access to internal PHYs */
-	mt753x_reg_read(priv, HWTRAP_REG, &val);
-	val |= CHG_TRAP;
-	val &= ~C_MDIO_BPS;
-	mt753x_reg_write(priv, MHWTRAP_REG, val);
-
-	/* Calculate the phy base address */
-	val = ((val & SMI_ADDR_M) >> SMI_ADDR_S) << 3;
-	priv->mt753x_phy_base = (val | 0x7) + 1;
-
-	/* Turn off PHYs */
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, i);
-		phy_val = priv->mii_read(priv, phy_addr, MII_BMCR);
-		phy_val |= BMCR_PDOWN;
-		priv->mii_write(priv, phy_addr, MII_BMCR, phy_val);
-	}
-
-	/* Force MAC link down before reset */
-	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE);
-	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE);
-
-	/* MT7530 reset */
-	mt753x_reg_write(priv, SYS_CTRL_REG, SW_SYS_RST | SW_REG_RST);
-	udelay(100);
-
-	val = (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
-	      MAC_MODE | FORCE_MODE |
-	      MAC_TX_EN | MAC_RX_EN |
-	      BKOFF_EN | BACKPR_EN |
-	      (SPEED_1000M << FORCE_SPD_S) |
-	      FORCE_DPX | FORCE_LINK;
-
-	/* MT7530 Port6: Forced 1000M/FD, FC disabled */
-	priv->mt753x_pmcr = val;
-
-	/* MT7530 Port5: Forced link down */
-	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE);
-
-	/* Keep MAC link down before starting eth */
-	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE);
-
-	/* MT7530 Port6: Set to RGMII */
-	mt753x_reg_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_M, P6_INTF_MODE_RGMII);
-
-	/* Hardware Trap: Enable Port6, Disable Port5 */
-	mt753x_reg_read(priv, HWTRAP_REG, &val);
-	val |= CHG_TRAP | LOOPDET_DIS | P5_INTF_DIS |
-	       (P5_INTF_SEL_GMAC5 << P5_INTF_SEL_S) |
-	       (P5_INTF_MODE_RGMII << P5_INTF_MODE_S);
-	val &= ~(C_MDIO_BPS | P6_INTF_DIS);
-	mt753x_reg_write(priv, MHWTRAP_REG, val);
-
-	/* Setup switch core pll */
-	mt7530_pad_clk_setup(priv, priv->phy_interface);
-
-	/* Lower Tx Driving for TRGMII path */
-	for (i = 0 ; i < NUM_TRGMII_CTRL ; i++)
-		mt753x_reg_write(priv, MT7530_TRGMII_TD_ODT(i),
-				 (txdrv << TD_DM_DRVP_S) |
-				 (txdrv << TD_DM_DRVN_S));
-
-	for (i = 0 ; i < NUM_TRGMII_CTRL; i++)
-		mt753x_reg_rmw(priv, MT7530_TRGMII_RD(i), RD_TAP_M, 16);
-
-	/* Turn on PHYs */
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, i);
-		phy_val = priv->mii_read(priv, phy_addr, MII_BMCR);
-		phy_val &= ~BMCR_PDOWN;
-		priv->mii_write(priv, phy_addr, MII_BMCR, phy_val);
-	}
-
-	return 0;
-}
-
-static void mt7531_core_pll_setup(struct mtk_eth_priv *priv, int mcm)
-{
-	/* Step 1 : Disable MT7531 COREPLL */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, EN_COREPLL, 0);
-
-	/* Step 2: switch to XTAL output */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, SW_CLKSW, SW_CLKSW);
-
-	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_EN, 0);
-
-	/* Step 3: disable PLLGP and enable program PLLGP */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, SW_PLLGP, SW_PLLGP);
-
-	/* Step 4: program COREPLL output frequency to 500MHz */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_POSDIV_M,
-		       2 << RG_COREPLL_POSDIV_S);
-	udelay(25);
-
-	/* Currently, support XTAL 25Mhz only */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_SDM_PCW_M,
-		       0x140000 << RG_COREPLL_SDM_PCW_S);
-
-	/* Set feedback divide ratio update signal to high */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_SDM_PCW_CHG,
-		       RG_COREPLL_SDM_PCW_CHG);
-
-	/* Wait for at least 16 XTAL clocks */
-	udelay(10);
-
-	/* Step 5: set feedback divide ratio update signal to low */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_SDM_PCW_CHG, 0);
-
-	/* add enable 325M clock for SGMII */
-	mt753x_reg_write(priv, MT7531_ANA_PLLGP_CR5, 0xad0000);
-
-	/* add enable 250SSC clock for RGMII */
-	mt753x_reg_write(priv, MT7531_ANA_PLLGP_CR2, 0x4f40000);
-
-	/*Step 6: Enable MT7531 PLL */
-	mt753x_reg_rmw(priv, MT7531_PLLGP_CR0, RG_COREPLL_EN, RG_COREPLL_EN);
-
-	mt753x_reg_rmw(priv, MT7531_PLLGP_EN, EN_COREPLL, EN_COREPLL);
-
-	udelay(25);
-}
-
-static int mt7531_port_sgmii_init(struct mtk_eth_priv *priv,
-				  u32 port)
-{
-	if (port != 5 && port != 6) {
-		printf("mt7531: port %d is not a SGMII port\n", port);
-		return -EINVAL;
-	}
-
-	/* Set SGMII GEN2 speed(2.5G) */
-	mt753x_reg_rmw(priv, MT7531_PHYA_CTRL_SIGNAL3(port), SGMSYS_SPEED_MASK,
-		       FIELD_PREP(SGMSYS_SPEED_MASK, SGMSYS_SPEED_2500));
-
-	/* Disable SGMII AN */
-	mt753x_reg_rmw(priv, MT7531_PCS_CONTROL_1(port),
-		       SGMII_AN_ENABLE, 0);
-
-	/* SGMII force mode setting */
-	mt753x_reg_write(priv, MT7531_SGMII_MODE(port), SGMII_FORCE_MODE);
-
-	/* Release PHYA power down state */
-	mt753x_reg_rmw(priv, MT7531_QPHY_PWR_STATE_CTRL(port),
-		       SGMII_PHYA_PWD, 0);
-
-	return 0;
-}
-
-static int mt7531_port_rgmii_init(struct mtk_eth_priv *priv, u32 port)
-{
-	u32 val;
-
-	if (port != 5) {
-		printf("error: RGMII mode is not available for port %d\n",
-		       port);
-		return -EINVAL;
-	}
-
-	mt753x_reg_read(priv, MT7531_CLKGEN_CTRL, &val);
-	val |= GP_CLK_EN;
-	val &= ~GP_MODE_M;
-	val |= GP_MODE_RGMII << GP_MODE_S;
-	val |= TXCLK_NO_REVERSE;
-	val |= RXCLK_NO_DELAY;
-	val &= ~CLK_SKEW_IN_M;
-	val |= CLK_SKEW_IN_NO_CHANGE << CLK_SKEW_IN_S;
-	val &= ~CLK_SKEW_OUT_M;
-	val |= CLK_SKEW_OUT_NO_CHANGE << CLK_SKEW_OUT_S;
-	mt753x_reg_write(priv, MT7531_CLKGEN_CTRL, val);
-
-	return 0;
-}
-
-static void mt7531_phy_setting(struct mtk_eth_priv *priv)
-{
-	int i;
-	u32 val;
-
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		/* Enable HW auto downshift */
-		priv->mii_write(priv, i, 0x1f, 0x1);
-		val = priv->mii_read(priv, i, PHY_EXT_REG_14);
-		val |= PHY_EN_DOWN_SHFIT;
-		priv->mii_write(priv, i, PHY_EXT_REG_14, val);
-
-		/* PHY link down power saving enable */
-		val = priv->mii_read(priv, i, PHY_EXT_REG_17);
-		val |= PHY_LINKDOWN_POWER_SAVING_EN;
-		priv->mii_write(priv, i, PHY_EXT_REG_17, val);
-
-		val = priv->mmd_read(priv, i, 0x1e, PHY_DEV1E_REG_0C6);
-		val &= ~PHY_POWER_SAVING_M;
-		val |= PHY_POWER_SAVING_TX << PHY_POWER_SAVING_S;
-		priv->mmd_write(priv, i, 0x1e, PHY_DEV1E_REG_0C6, val);
-	}
-}
-
-static void mt7531_mac_control(struct mtk_eth_priv *priv, bool enable)
-{
-	u32 pmcr = FORCE_MODE_LNK;
-
-	if (enable)
-		pmcr = priv->mt753x_pmcr;
-
-	mt753x_reg_write(priv, PMCR_REG(5), pmcr);
-	mt753x_reg_write(priv, PMCR_REG(6), pmcr);
-}
-
-static int mt7531_setup(struct mtk_eth_priv *priv)
-{
-	u16 phy_addr, phy_val;
-	u32 val;
-	u32 pmcr;
-	u32 port5_sgmii;
-	int i;
-
-	priv->mt753x_phy_base = (priv->mt753x_smi_addr + 1) &
-				MT753X_SMI_ADDR_MASK;
-
-	/* Turn off PHYs */
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, i);
-		phy_val = priv->mii_read(priv, phy_addr, MII_BMCR);
-		phy_val |= BMCR_PDOWN;
-		priv->mii_write(priv, phy_addr, MII_BMCR, phy_val);
-	}
-
-	/* Force MAC link down before reset */
-	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE_LNK);
-	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE_LNK);
-
-	/* Switch soft reset */
-	mt753x_reg_write(priv, SYS_CTRL_REG, SW_SYS_RST | SW_REG_RST);
-	udelay(100);
-
-	/* Enable MDC input Schmitt Trigger */
-	mt753x_reg_rmw(priv, MT7531_SMT0_IOLB, SMT_IOLB_5_SMI_MDC_EN,
-		       SMT_IOLB_5_SMI_MDC_EN);
-
-	mt7531_core_pll_setup(priv, priv->mcm);
-
-	mt753x_reg_read(priv, MT7531_TOP_SIG_SR, &val);
-	port5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
-
-	/* port5 support either RGMII or SGMII, port6 only support SGMII. */
-	switch (priv->phy_interface) {
-	case PHY_INTERFACE_MODE_RGMII:
-		if (!port5_sgmii)
-			mt7531_port_rgmii_init(priv, 5);
-		break;
-	case PHY_INTERFACE_MODE_2500BASEX:
-		mt7531_port_sgmii_init(priv, 6);
-		if (port5_sgmii)
-			mt7531_port_sgmii_init(priv, 5);
-		break;
-	default:
-		break;
-	}
-
-	pmcr = MT7531_FORCE_MODE |
-	       (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
-	       MAC_MODE | MAC_TX_EN | MAC_RX_EN |
-	       BKOFF_EN | BACKPR_EN |
-	       FORCE_RX_FC | FORCE_TX_FC |
-	       (SPEED_1000M << FORCE_SPD_S) | FORCE_DPX |
-	       FORCE_LINK;
-
-	priv->mt753x_pmcr = pmcr;
-
-	/* Keep MAC link down before starting eth */
-	mt753x_reg_write(priv, PMCR_REG(5), FORCE_MODE_LNK);
-	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE_LNK);
-
-	/* Turn on PHYs */
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, i);
-		phy_val = priv->mii_read(priv, phy_addr, MII_BMCR);
-		phy_val &= ~BMCR_PDOWN;
-		priv->mii_write(priv, phy_addr, MII_BMCR, phy_val);
-	}
-
-	mt7531_phy_setting(priv);
-
-	/* Enable Internal PHYs */
-	val = mt753x_core_reg_read(priv, CORE_PLL_GROUP4);
-	val |= MT7531_BYPASS_MODE;
-	val &= ~MT7531_POWER_ON_OFF;
-	mt753x_core_reg_write(priv, CORE_PLL_GROUP4, val);
-
-	return 0;
-}
-
-static void mt7988_phy_setting(struct mtk_eth_priv *priv)
-{
-	u16 val;
-	u32 i;
-
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		/* Enable HW auto downshift */
-		priv->mii_write(priv, i, 0x1f, 0x1);
-		val = priv->mii_read(priv, i, PHY_EXT_REG_14);
-		val |= PHY_EN_DOWN_SHFIT;
-		priv->mii_write(priv, i, PHY_EXT_REG_14, val);
-
-		/* PHY link down power saving enable */
-		val = priv->mii_read(priv, i, PHY_EXT_REG_17);
-		val |= PHY_LINKDOWN_POWER_SAVING_EN;
-		priv->mii_write(priv, i, PHY_EXT_REG_17, val);
-	}
-}
-
-static void mt7988_mac_control(struct mtk_eth_priv *priv, bool enable)
-{
-	u32 pmcr = FORCE_MODE_LNK;
-
-	if (enable)
-		pmcr = priv->mt753x_pmcr;
-
-	mt753x_reg_write(priv, PMCR_REG(6), pmcr);
-}
-
-static int mt7988_setup(struct mtk_eth_priv *priv)
-{
-	u16 phy_addr, phy_val;
-	u32 pmcr;
-	int i;
-
-	priv->gsw_base = regmap_get_range(priv->ethsys_regmap, 0) + GSW_BASE;
-
-	priv->mt753x_phy_base = (priv->mt753x_smi_addr + 1) &
-				MT753X_SMI_ADDR_MASK;
-
-	/* Turn off PHYs */
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, i);
-		phy_val = priv->mii_read(priv, phy_addr, MII_BMCR);
-		phy_val |= BMCR_PDOWN;
-		priv->mii_write(priv, phy_addr, MII_BMCR, phy_val);
-	}
-
-	switch (priv->phy_interface) {
-	case PHY_INTERFACE_MODE_USXGMII:
-		/* Use CPU bridge instead of actual USXGMII path */
-
-		/* Set GDM1 no drop */
-		mtk_fe_rmw(priv, PSE_NO_DROP_CFG_REG, 0, PSE_NO_DROP_GDM1);
-
-		/* Enable GDM1 to GSW CPU bridge */
-		mtk_gmac_rmw(priv, GMAC_MAC_MISC_REG, 0, BIT(0));
-
-		/* XGMAC force link up */
-		mtk_gmac_rmw(priv, GMAC_XGMAC_STS_REG, 0, P1_XGMAC_FORCE_LINK);
-
-		/* Setup GSW CPU bridge IPG */
-		mtk_gmac_rmw(priv, GMAC_GSW_CFG_REG, GSWTX_IPG_M | GSWRX_IPG_M,
-			     (0xB << GSWTX_IPG_S) | (0xB << GSWRX_IPG_S));
-		break;
-	default:
-		printf("Error: MT7988 GSW does not support %s interface\n",
-		       phy_string_for_interface(priv->phy_interface));
-		break;
-	}
+	struct mtk_eth_switch *swdrvs = ll_entry_start(struct mtk_eth_switch,
+						       mtk_eth_switch);
+	const u32 n_swdrvs = ll_entry_count(struct mtk_eth_switch,
+					    mtk_eth_switch);
+	struct mtk_eth_switch *tmp, *swdrv = NULL;
+	u32 reset_wait_time = 500;
+	size_t priv_size;
+	int ret;
 
-	pmcr = MT7988_FORCE_MODE |
-	       (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
-	       MAC_MODE | MAC_TX_EN | MAC_RX_EN |
-	       BKOFF_EN | BACKPR_EN |
-	       FORCE_RX_FC | FORCE_TX_FC |
-	       (SPEED_1000M << FORCE_SPD_S) | FORCE_DPX |
-	       FORCE_LINK;
-
-	priv->mt753x_pmcr = pmcr;
-
-	/* Keep MAC link down before starting eth */
-	mt753x_reg_write(priv, PMCR_REG(6), FORCE_MODE_LNK);
-
-	/* Turn on PHYs */
-	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->mt753x_phy_base, i);
-		phy_val = priv->mii_read(priv, phy_addr, MII_BMCR);
-		phy_val &= ~BMCR_PDOWN;
-		priv->mii_write(priv, phy_addr, MII_BMCR, phy_val);
+	if (strcmp(priv->swname, "auto")) {
+		for (tmp = swdrvs; tmp < swdrvs + n_swdrvs; tmp++) {
+			if (!strcmp(tmp->name, priv->swname)) {
+				swdrv = tmp;
+				break;
+			}
+		}
 	}
 
-	mt7988_phy_setting(priv);
-
-	return 0;
-}
-
-static int mt753x_switch_init(struct mtk_eth_priv *priv)
-{
-	int ret;
-	int i;
+	if (swdrv)
+		reset_wait_time = swdrv->reset_wait_time;
 
 	/* Global reset switch */
 	if (priv->mcm) {
 		reset_assert(&priv->rst_mcm);
 		udelay(1000);
 		reset_deassert(&priv->rst_mcm);
-		mdelay(priv->mt753x_reset_wait_time);
+		mdelay(reset_wait_time);
 	} else if (dm_gpio_is_valid(&priv->rst_gpio)) {
 		dm_gpio_set_value(&priv->rst_gpio, 0);
 		udelay(1000);
 		dm_gpio_set_value(&priv->rst_gpio, 1);
-		mdelay(priv->mt753x_reset_wait_time);
+		mdelay(reset_wait_time);
 	}
 
-	ret = priv->switch_init(priv);
-	if (ret)
-		return ret;
+	if (!swdrv) {
+		for (tmp = swdrvs; tmp < swdrvs + n_swdrvs; tmp++) {
+			if (!tmp->detect)
+				continue;
 
-	/* Set port isolation */
-	for (i = 0; i < MT753X_NUM_PORTS; i++) {
-		/* Set port matrix mode */
-		if (i != 6)
-			mt753x_reg_write(priv, PCR_REG(i),
-					 (0x40 << PORT_MATRIX_S));
-		else
-			mt753x_reg_write(priv, PCR_REG(i),
-					 (0x3f << PORT_MATRIX_S));
+			ret = tmp->detect(priv);
+			if (!ret) {
+				swdrv = tmp;
+				break;
+			}
+		}
 
-		/* Set port mode to user port */
-		mt753x_reg_write(priv, PVC_REG(i),
-				 (0x8100 << STAG_VPID_S) |
-				 (VLAN_ATTR_USER << VLAN_ATTR_S));
+		if (!swdrv) {
+			printf("Error: unable to detect switch\n");
+			return -ENODEV;
+		}
+	} else {
+		if (swdrv->detect) {
+			ret = swdrv->detect(priv);
+			if (ret) {
+				printf("Error: switch probing failed\n");
+				return -ENODEV;
+			}
+		}
+	}
+
+	printf("%s\n", swdrv->desc);
+
+	priv_size = swdrv->priv_size;
+	if (priv_size < sizeof(struct mtk_eth_switch_priv))
+		priv_size = sizeof(struct mtk_eth_switch_priv);
+
+	priv->swpriv = calloc(1, priv_size);
+	if (!priv->swpriv) {
+		printf("Error: no memory for switch data\n");
+		return -ENOMEM;
+	}
+
+	priv->swpriv->eth = priv;
+	priv->swpriv->soc = priv->soc;
+	priv->swpriv->phy_interface = priv->phy_interface;
+	priv->swpriv->sw = swdrv;
+	priv->swpriv->ethsys_base = regmap_get_range(priv->ethsys_regmap, 0);
+
+	ret = swdrv->setup(priv->swpriv);
+	if (ret) {
+		free(priv->swpriv);
+		priv->swpriv = NULL;
+		return ret;
 	}
 
 	return 0;
@@ -1759,7 +1061,8 @@ static int mtk_eth_start(struct udevice *dev)
 	}
 
 	if (MTK_HAS_CAPS(priv->soc->caps, MTK_NETSYS_V3)) {
-		if (priv->sw == SW_MT7988 && priv->gmac_id == 0) {
+		if (priv->swpriv && !strcmp(priv->swpriv->sw->name, "mt7988") &&
+		    priv->gmac_id == 0) {
 			mtk_gdma_write(priv, priv->gmac_id, GDMA_IG_CTRL_REG,
 				       GDMA_BRIDGE_TO_CPU);
 
@@ -1778,11 +1081,12 @@ static int mtk_eth_start(struct udevice *dev)
 
 	mtk_eth_fifo_init(priv);
 
-	if (priv->switch_mac_control)
-		priv->switch_mac_control(priv, true);
-
-	/* Start PHY */
-	if (priv->sw == SW_NONE) {
+	if (priv->swpriv) {
+		/* Enable communication with switch */
+		if (priv->swpriv->sw->mac_control)
+			priv->swpriv->sw->mac_control(priv->swpriv, true);
+	} else {
+		/* Start PHY */
 		ret = mtk_phy_start(priv);
 		if (ret)
 			return ret;
@@ -1799,8 +1103,10 @@ static void mtk_eth_stop(struct udevice *dev)
 {
 	struct mtk_eth_priv *priv = dev_get_priv(dev);
 
-	if (priv->switch_mac_control)
-		priv->switch_mac_control(priv, false);
+	if (priv->swpriv) {
+		if (priv->swpriv->sw->mac_control)
+			priv->swpriv->sw->mac_control(priv->swpriv, false);
+	}
 
 	mtk_pdma_rmw(priv, PDMA_GLO_CFG_REG,
 		     TX_WB_DDONE | RX_DMA_EN | TX_DMA_EN, 0);
@@ -1953,11 +1259,11 @@ static int mtk_eth_probe(struct udevice *dev)
 		return ret;
 
 	/* Probe phy if switch is not specified */
-	if (priv->sw == SW_NONE)
+	if (!priv->swname)
 		return mtk_phy_probe(dev);
 
 	/* Initialize switch */
-	return mt753x_switch_init(priv);
+	return mtk_switch_init(priv);
 }
 
 static int mtk_eth_remove(struct udevice *dev)
@@ -1971,6 +1277,12 @@ static int mtk_eth_remove(struct udevice *dev)
 	/* Stop possibly started DMA */
 	mtk_eth_stop(dev);
 
+	if (priv->swpriv) {
+		if (priv->swpriv->sw->cleanup)
+			priv->swpriv->sw->cleanup(priv->swpriv);
+		free(priv->swpriv);
+	}
+
 	return 0;
 }
 
@@ -1980,7 +1292,6 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 	struct mtk_eth_priv *priv = dev_get_priv(dev);
 	struct ofnode_phandle_args args;
 	struct regmap *regmap;
-	const char *str;
 	ofnode subnode;
 	int ret;
 
@@ -2126,36 +1437,8 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 			return PTR_ERR(priv->toprgu_regmap);
 	}
 
-	/* check for switch first, otherwise phy will be used */
-	priv->sw = SW_NONE;
-	priv->switch_init = NULL;
-	priv->switch_mac_control = NULL;
-	str = dev_read_string(dev, "mediatek,switch");
-
-	if (str) {
-		if (!strcmp(str, "mt7530")) {
-			priv->sw = SW_MT7530;
-			priv->switch_init = mt7530_setup;
-			priv->switch_mac_control = mt7530_mac_control;
-			priv->mt753x_smi_addr = MT753X_DFL_SMI_ADDR;
-			priv->mt753x_reset_wait_time = 1000;
-		} else if (!strcmp(str, "mt7531")) {
-			priv->sw = SW_MT7531;
-			priv->switch_init = mt7531_setup;
-			priv->switch_mac_control = mt7531_mac_control;
-			priv->mt753x_smi_addr = MT753X_DFL_SMI_ADDR;
-			priv->mt753x_reset_wait_time = 200;
-		} else if (!strcmp(str, "mt7988")) {
-			priv->sw = SW_MT7988;
-			priv->switch_init = mt7988_setup;
-			priv->switch_mac_control = mt7988_mac_control;
-			priv->mt753x_smi_addr = MT753X_DFL_SMI_ADDR;
-			priv->mt753x_reset_wait_time = 50;
-		} else {
-			printf("error: unsupported switch\n");
-			return -EINVAL;
-		}
-
+	priv->swname = dev_read_string(dev, "mediatek,switch");
+	if (priv->swname) {
 		priv->mcm = dev_read_bool(dev, "mediatek,mcm");
 		if (priv->mcm) {
 			ret = reset_get_by_name(dev, "mcm", &priv->rst_mcm);
@@ -2271,10 +1554,10 @@ U_BOOT_DRIVER(mtk_eth) = {
 	.id = UCLASS_ETH,
 	.of_match = mtk_eth_ids,
 	.of_to_plat = mtk_eth_of_to_plat,
-	.plat_auto	= sizeof(struct eth_pdata),
+	.plat_auto = sizeof(struct eth_pdata),
 	.probe = mtk_eth_probe,
 	.remove = mtk_eth_remove,
 	.ops = &mtk_eth_ops,
-	.priv_auto	= sizeof(struct mtk_eth_priv),
+	.priv_auto = sizeof(struct mtk_eth_priv),
 	.flags = DM_FLAG_ALLOC_PRIV_DMA,
 };
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth/mtk_eth.h
similarity index 59%
rename from drivers/net/mtk_eth.h
rename to drivers/net/mtk_eth/mtk_eth.h
index 1aa037907c5..0ad32799128 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth/mtk_eth.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 MediaTek Inc.
+ * Copyright (C) 2025 MediaTek Inc.
  *
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  * Author: Mark Lee <mark-mc.lee@mediatek.com>
@@ -9,9 +9,55 @@
 #ifndef _MTK_ETH_H_
 #define _MTK_ETH_H_
 
+#include <linker_lists.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
+struct mtk_eth_priv;
+struct mtk_eth_switch_priv;
+
+/* struct mtk_soc_data -	This is the structure holding all differences
+ *				among various plaforms
+ * @caps			Flags shown the extra capability for the SoC
+ * @ana_rgc3:			The offset for register ANA_RGC3 related to
+ *				sgmiisys syscon
+ * @gdma_count:			Number of GDMAs
+ * @pdma_base:			Register base of PDMA block
+ * @txd_size:			Tx DMA descriptor size.
+ * @rxd_size:			Rx DMA descriptor size.
+ */
+struct mtk_soc_data {
+	u32 caps;
+	u32 ana_rgc3;
+	u32 gdma_count;
+	u32 pdma_base;
+	u32 txd_size;
+	u32 rxd_size;
+};
+
+struct mtk_eth_switch {
+	const char *name;
+	const char *desc;
+	size_t priv_size;
+	u32 reset_wait_time;
+
+	int (*detect)(struct mtk_eth_priv *priv);
+	int (*setup)(struct mtk_eth_switch_priv *priv);
+	int (*cleanup)(struct mtk_eth_switch_priv *priv);
+	void (*mac_control)(struct mtk_eth_switch_priv *priv, bool enable);
+};
+
+#define MTK_ETH_SWITCH(__name)	\
+	ll_entry_declare(struct mtk_eth_switch, __name, mtk_eth_switch)
+
+struct mtk_eth_switch_priv {
+	struct mtk_eth_priv *eth;
+	const struct mtk_eth_switch *sw;
+	const struct mtk_soc_data *soc;
+	void *ethsys_base;
+	int phy_interface;
+};
+
 enum mkt_eth_capabilities {
 	MTK_TRGMII_BIT,
 	MTK_TRGMII_MT7621_CLK_BIT,
@@ -36,7 +82,6 @@ enum mkt_eth_capabilities {
 
 /* Supported path present on SoCs */
 #define MTK_ETH_PATH_GMAC1_TRGMII	BIT(MTK_ETH_PATH_GMAC1_TRGMII_BIT)
-
 #define MTK_ETH_PATH_GMAC2_SGMII	BIT(MTK_ETH_PATH_GMAC2_SGMII_BIT)
 #define MTK_ETH_PATH_MT7622_SGMII	BIT(MTK_ETH_PATH_MT7622_SGMII_BIT)
 #define MTK_ETH_PATH_MT7629_GMAC2	BIT(MTK_ETH_PATH_MT7629_GMAC2_BIT)
@@ -59,6 +104,8 @@ enum mkt_eth_capabilities {
 
 #define MT7986_CAPS  (MTK_NETSYS_V2)
 
+#define MT7987_CAPS  (MTK_NETSYS_V3 | MTK_GMAC2_U3_QPHY | MTK_INFRA)
+
 #define MT7988_CAPS  (MTK_NETSYS_V3 | MTK_INFRA)
 
 /* Frame Engine Register Bases */
@@ -72,7 +119,6 @@ enum mkt_eth_capabilities {
 #define GSW_BASE			0x20000
 
 /* Ethernet subsystem registers */
-
 #define ETHSYS_SYSCFG1_REG		0x14
 #define SYSCFG1_GE_MODE_S(n)		(12 + ((n) * 2))
 #define SYSCFG1_GE_MODE_M		0x3
@@ -191,7 +237,6 @@ enum mkt_eth_capabilities {
 #define DP_DISCARD			7
 
 /* GMAC Registers */
-
 #define GMAC_PPSC_REG			0x0000
 #define PHY_MDC_CFG			GENMASK(29, 24)
 #define MDC_TURBO			BIT(20)
@@ -272,6 +317,8 @@ enum mkt_eth_capabilities {
 #define RX_RST				BIT(31)
 #define RXC_DQSISEL			BIT(30)
 
+#define NUM_TRGMII_CTRL			5
+
 #define GMAC_TRGMII_TD_ODT(n)		(0x354 + (n) * 8)
 #define TD_DM_DRVN_S			4
 #define TD_DM_DRVN_M			0xf0
@@ -288,164 +335,7 @@ enum mkt_eth_capabilities {
 #define XGMAC_FORCE_TX_FC		BIT(5)
 #define XGMAC_FORCE_RX_FC		BIT(4)
 
-/* MT7530 Registers */
-
-#define PCR_REG(p)			(0x2004 + (p) * 0x100)
-#define PORT_MATRIX_S			16
-#define PORT_MATRIX_M			0xff0000
-
-#define PVC_REG(p)			(0x2010 + (p) * 0x100)
-#define STAG_VPID_S			16
-#define STAG_VPID_M			0xffff0000
-#define VLAN_ATTR_S			6
-#define VLAN_ATTR_M			0xc0
-
-/* VLAN_ATTR: VLAN attributes */
-#define VLAN_ATTR_USER			0
-#define VLAN_ATTR_STACK			1
-#define VLAN_ATTR_TRANSLATION		2
-#define VLAN_ATTR_TRANSPARENT		3
-
-#define PMCR_REG(p)			(0x3000 + (p) * 0x100)
-/* XXX: all fields of MT7530 are defined under GMAC_PORT_MCR
- * MT7531 specific fields are defined below
- */
-#define FORCE_MODE_EEE1G		BIT(25)
-#define FORCE_MODE_EEE100		BIT(26)
-#define FORCE_MODE_TX_FC		BIT(27)
-#define FORCE_MODE_RX_FC		BIT(28)
-#define FORCE_MODE_DPX			BIT(29)
-#define FORCE_MODE_SPD			BIT(30)
-#define FORCE_MODE_LNK			BIT(31)
-#define MT7531_FORCE_MODE		FORCE_MODE_EEE1G | FORCE_MODE_EEE100 |\
-					FORCE_MODE_TX_FC | FORCE_MODE_RX_FC | \
-					FORCE_MODE_DPX   | FORCE_MODE_SPD | \
-					FORCE_MODE_LNK
-#define MT7988_FORCE_MODE		FORCE_MODE_TX_FC | FORCE_MODE_RX_FC | \
-					FORCE_MODE_DPX   | FORCE_MODE_SPD | \
-					FORCE_MODE_LNK
-
-/* MT7531 SGMII Registers */
-#define MT7531_SGMII_REG_BASE		0x5000
-#define MT7531_SGMII_REG_PORT_BASE	0x1000
-#define MT7531_SGMII_REG(p, r)		(MT7531_SGMII_REG_BASE + \
-					(p) * MT7531_SGMII_REG_PORT_BASE + (r))
-#define MT7531_PCS_CONTROL_1(p)		MT7531_SGMII_REG(((p) - 5), 0x00)
-#define MT7531_SGMII_MODE(p)		MT7531_SGMII_REG(((p) - 5), 0x20)
-#define MT7531_QPHY_PWR_STATE_CTRL(p)	MT7531_SGMII_REG(((p) - 5), 0xe8)
-#define MT7531_PHYA_CTRL_SIGNAL3(p)	MT7531_SGMII_REG(((p) - 5), 0x128)
-/* XXX: all fields of MT7531 SGMII  are defined under SGMSYS */
-
-/* MT753x System Control Register */
-#define SYS_CTRL_REG			0x7000
-#define SW_PHY_RST			BIT(2)
-#define SW_SYS_RST			BIT(1)
-#define SW_REG_RST			BIT(0)
-
-/* MT7531  */
-#define MT7531_PHY_IAC			0x701c
-/* XXX: all fields are defined under GMAC_PIAC_REG */
-
-#define MT7531_CLKGEN_CTRL		0x7500
-#define CLK_SKEW_OUT_S			8
-#define CLK_SKEW_OUT_M			0x300
-#define CLK_SKEW_IN_S			6
-#define CLK_SKEW_IN_M			0xc0
-#define RXCLK_NO_DELAY			BIT(5)
-#define TXCLK_NO_REVERSE		BIT(4)
-#define GP_MODE_S			1
-#define GP_MODE_M			0x06
-#define GP_CLK_EN			BIT(0)
-
-/* Values of GP_MODE */
-#define GP_MODE_RGMII			0
-#define GP_MODE_MII			1
-#define GP_MODE_REV_MII			2
-
-/* Values of CLK_SKEW_IN */
-#define CLK_SKEW_IN_NO_CHANGE		0
-#define CLK_SKEW_IN_DELAY_100PPS	1
-#define CLK_SKEW_IN_DELAY_200PPS	2
-#define CLK_SKEW_IN_REVERSE		3
-
-/* Values of CLK_SKEW_OUT */
-#define CLK_SKEW_OUT_NO_CHANGE		0
-#define CLK_SKEW_OUT_DELAY_100PPS	1
-#define CLK_SKEW_OUT_DELAY_200PPS	2
-#define CLK_SKEW_OUT_REVERSE		3
-
-#define HWTRAP_REG			0x7800
-/* MT7530 Modified Hardware Trap Status Registers */
-#define MHWTRAP_REG			0x7804
-#define CHG_TRAP			BIT(16)
-#define LOOPDET_DIS			BIT(14)
-#define P5_INTF_SEL_S			13
-#define P5_INTF_SEL_M			0x2000
-#define SMI_ADDR_S			11
-#define SMI_ADDR_M			0x1800
-#define XTAL_FSEL_S			9
-#define XTAL_FSEL_M			0x600
-#define P6_INTF_DIS			BIT(8)
-#define P5_INTF_MODE_S			7
-#define P5_INTF_MODE_M			0x80
-#define P5_INTF_DIS			BIT(6)
-#define C_MDIO_BPS			BIT(5)
-#define CHIP_MODE_S			0
-#define CHIP_MODE_M			0x0f
-
-/* P5_INTF_SEL: Interface type of Port5 */
-#define P5_INTF_SEL_GPHY		0
-#define P5_INTF_SEL_GMAC5		1
-
-/* P5_INTF_MODE: Interface mode of Port5 */
-#define P5_INTF_MODE_GMII_MII		0
-#define P5_INTF_MODE_RGMII		1
-
-#define MT7530_P6ECR			0x7830
-#define P6_INTF_MODE_M			0x3
-#define P6_INTF_MODE_S			0
-
-/* P6_INTF_MODE: Interface mode of Port6 */
-#define P6_INTF_MODE_RGMII		0
-#define P6_INTF_MODE_TRGMII		1
-
-#define NUM_TRGMII_CTRL			5
-
-#define MT7530_TRGMII_RD(n)		(0x7a10 + (n) * 8)
-#define RD_TAP_S			0
-#define RD_TAP_M			0x7f
-
-#define MT7530_TRGMII_TD_ODT(n)		(0x7a54 + (n) * 8)
-/* XXX: all fields are defined under GMAC_TRGMII_TD_ODT */
-
-/* TOP Signals Status Register */
-#define MT7531_TOP_SIG_SR		0x780c
-#define PAD_MCM_SMI_EN			BIT(0)
-#define PAD_DUAL_SGMII_EN		BIT(1)
-
-/* MT7531 PLLGP Registers */
-#define MT7531_PLLGP_EN			0x7820
-#define EN_COREPLL			BIT(2)
-#define SW_CLKSW			BIT(1)
-#define SW_PLLGP			BIT(0)
-
-#define MT7531_PLLGP_CR0		0x78a8
-#define RG_COREPLL_EN			BIT(22)
-#define RG_COREPLL_POSDIV_S		23
-#define RG_COREPLL_POSDIV_M		0x3800000
-#define RG_COREPLL_SDM_PCW_S		1
-#define RG_COREPLL_SDM_PCW_M		0x3ffffe
-#define RG_COREPLL_SDM_PCW_CHG		BIT(0)
-
-/* MT7531 RGMII and SGMII PLL clock */
-#define MT7531_ANA_PLLGP_CR2		0x78b0
-#define MT7531_ANA_PLLGP_CR5		0x78bc
-
-/* MT7531 GPIO GROUP IOLB SMT0 Control */
-#define MT7531_SMT0_IOLB		0x7f04
-#define SMT_IOLB_5_SMI_MDC_EN		BIT(5)
-
-/* MT7530 GPHY MDIO Indirect Access Registers */
+/* MDIO Indirect Access Registers */
 #define MII_MMD_ACC_CTL_REG		0x0d
 #define MMD_CMD_S			14
 #define MMD_CMD_M			0xc000
@@ -460,80 +350,6 @@ enum mkt_eth_capabilities {
 
 #define MII_MMD_ADDR_DATA_REG		0x0e
 
-/* MT7530 GPHY MDIO MMD Registers */
-#define CORE_PLL_GROUP2			0x401
-#define RG_SYSPLL_EN_NORMAL		BIT(15)
-#define RG_SYSPLL_VODEN			BIT(14)
-#define RG_SYSPLL_POSDIV_S		5
-#define RG_SYSPLL_POSDIV_M		0x60
-
-#define CORE_PLL_GROUP4			0x403
-#define MT7531_BYPASS_MODE		BIT(4)
-#define MT7531_POWER_ON_OFF		BIT(5)
-#define RG_SYSPLL_DDSFBK_EN		BIT(12)
-#define RG_SYSPLL_BIAS_EN		BIT(11)
-#define RG_SYSPLL_BIAS_LPF_EN		BIT(10)
-
-#define CORE_PLL_GROUP5			0x404
-#define RG_LCDDS_PCW_NCPO1_S		0
-#define RG_LCDDS_PCW_NCPO1_M		0xffff
-
-#define CORE_PLL_GROUP6			0x405
-#define RG_LCDDS_PCW_NCPO0_S		0
-#define RG_LCDDS_PCW_NCPO0_M		0xffff
-
-#define CORE_PLL_GROUP7			0x406
-#define RG_LCDDS_PWDB			BIT(15)
-#define RG_LCDDS_ISO_EN			BIT(13)
-#define RG_LCCDS_C_S			4
-#define RG_LCCDS_C_M			0x70
-#define RG_LCDDS_PCW_NCPO_CHG		BIT(3)
-
-#define CORE_PLL_GROUP10		0x409
-#define RG_LCDDS_SSC_DELTA_S		0
-#define RG_LCDDS_SSC_DELTA_M		0xfff
-
-#define CORE_PLL_GROUP11		0x40a
-#define RG_LCDDS_SSC_DELTA1_S		0
-#define RG_LCDDS_SSC_DELTA1_M		0xfff
-
-#define CORE_GSWPLL_GRP1		0x40d
-#define RG_GSWPLL_POSDIV_200M_S		12
-#define RG_GSWPLL_POSDIV_200M_M		0x3000
-#define RG_GSWPLL_EN_PRE		BIT(11)
-#define RG_GSWPLL_FBKDIV_200M_S		0
-#define RG_GSWPLL_FBKDIV_200M_M		0xff
-
-#define CORE_GSWPLL_GRP2		0x40e
-#define RG_GSWPLL_POSDIV_500M_S		8
-#define RG_GSWPLL_POSDIV_500M_M		0x300
-#define RG_GSWPLL_FBKDIV_500M_S		0
-#define RG_GSWPLL_FBKDIV_500M_M		0xff
-
-#define CORE_TRGMII_GSW_CLK_CG		0x410
-#define REG_GSWCK_EN			BIT(0)
-#define REG_TRGMIICK_EN			BIT(1)
-
-/* Extend PHY Control Register 3 */
-#define PHY_EXT_REG_14			0x14
-
-/* Fields of PHY_EXT_REG_14 */
-#define PHY_EN_DOWN_SHFIT		BIT(4)
-
-/* Extend PHY Control Register 4 */
-#define PHY_EXT_REG_17			0x17
-
-/* Fields of PHY_EXT_REG_17 */
-#define PHY_LINKDOWN_POWER_SAVING_EN	BIT(4)
-
-/* PHY RXADC Control Register 7 */
-#define PHY_DEV1E_REG_0C6		0x0c6
-
-/* Fields of PHY_DEV1E_REG_0C6 */
-#define PHY_POWER_SAVING_S		8
-#define PHY_POWER_SAVING_M		0x300
-#define PHY_POWER_SAVING_TX		0x0
-
 /* PDMA descriptors */
 struct mtk_rx_dma {
 	unsigned int rxd1;
@@ -597,4 +413,17 @@ struct mtk_tx_dma_v2 {
 #define PDMA_V2_RXD2_PLEN0_GET(_v)	FIELD_GET(PDMA_V2_RXD2_PLEN0_M, (_v))
 #define PDMA_V2_RXD2_PLEN0_SET(_v)	FIELD_PREP(PDMA_V2_RXD2_PLEN0_M, (_v))
 
+void mtk_fe_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set);
+void mtk_gmac_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set);
+void mtk_ethsys_rmw(struct mtk_eth_priv *priv, u32 reg, u32 clr, u32 set);
+
+int mtk_mii_read(struct mtk_eth_priv *priv, u8 phy, u8 reg);
+int mtk_mii_write(struct mtk_eth_priv *priv, u8 phy, u8 reg, u16 data);
+int mtk_mmd_read(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg);
+int mtk_mmd_write(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg,
+		  u16 val);
+int mtk_mmd_ind_read(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg);
+int mtk_mmd_ind_write(struct mtk_eth_priv *priv, u8 addr, u8 devad, u16 reg,
+		      u16 val);
+
 #endif /* _MTK_ETH_H_ */
-- 
2.34.1

