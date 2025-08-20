Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F84CA0EE6
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 02:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7F882E05;
	Wed, 20 Aug 2025 04:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="uWY9Plv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D86D82F30; Wed, 20 Aug 2025 04:21:09 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34718211F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 04:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 496794167d6c11f08729452bf625a8b4-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=S/NggYGZx0JH9xYqOuh9iOWZnb8zFm6adEeT+7wBNY8=; 
 b=uWY9Plv8IxRn1XsbFTw4ZqmiJZNM+TIlcJA0lu4X9o6q4/P587CnZl9/BBHYQV+bFHXAvjdeYgLIlGINC2qfV+qIocw8JVe15OpxDYOf1a74hB1hn6Q3NfmuCedBNCi4WQcFhqBFGMEOlMucT+6iFZtkjuaappw1OQDTHou8eT0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:651ce040-9a8d-463f-904a-36975269b1a4, IP:0,
 UR
 L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-25
X-CID-META: VersionHash:f1326cf, CLOUDID:b919507a-966c-41bd-96b5-7d0b3c22e782,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 -3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 496794167d6c11f08729452bf625a8b4-20250820
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 735773420; Wed, 20 Aug 2025 10:20:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 10:20:46 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 10:20:45 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, Sky Huang
 <SkyLake.Huang@mediatek.com>
Subject: [PATCH 2/4] net: phy: Add MediaTek built-in 2.5Gb ethernet PHY driver
Date: Wed, 20 Aug 2025 10:20:46 +0800
Message-ID: <e75b959b758c252acc200a5f15c5f0a88e298cb3.1755655935.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1755655935.git.weijie.gao@mediatek.com>
References: <cover.1755655935.git.weijie.gao@mediatek.com>
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

The MediaTek MT7987/MT7988 SoCs features a built-in 2.5Gb PHY
connected to GMAC1. The PHY supports 10/100/1000/2500 Mbps
full-duplex only.

The PHY requires one or two firmware files. Firmware for MT7988 has
already been added to upstream: mediatek/mt7988/i2p5ge-phy-pmb.bin.
MT7987 has two firmware files which will be add to upstream later:
i2p5ge-phy-pmb.bin and i2p5ge-phy-DSPBitTb.bin.

This driver currently provides dedicated weak functions to be
overridden by board to provide the firmware data:
mt7987_i2p5ge_get_fw() for MT7987
mt7988_i2p5ge_get_fw() for MT7988

Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/phy/Kconfig                |   2 +
 drivers/net/phy/Makefile               |   1 +
 drivers/net/phy/mediatek/Kconfig       |  15 +
 drivers/net/phy/mediatek/Makefile      |   4 +
 drivers/net/phy/mediatek/mtk-2p5ge.c   | 586 +++++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c | 106 +++++
 drivers/net/phy/mediatek/mtk.h         | 103 +++++
 7 files changed, 817 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 21bf983056a..185c6a3156e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -184,6 +184,8 @@ config PHY_MARVELL_10G
 	help
 	  Support for the Marvell Alaska MV88X3310 and compatible PHYs.
 
+source "drivers/net/phy/mediatek/Kconfig"
+
 config PHY_MESON_GXL
 	bool "Amlogic Meson GXL Internal PHY support"
 
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index a119eb5e177..a339b8ac29d 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PHY_ET1011C) += et1011c.o
 obj-$(CONFIG_PHY_LXT) += lxt.o
 obj-$(CONFIG_PHY_MARVELL) += marvell.o
 obj-$(CONFIG_PHY_MARVELL_10G) += marvell10g.o
+obj-y += mediatek/
 obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
 obj-$(CONFIG_PHY_MICREL_KSZ90X1) += micrel_ksz90x1.o
 obj-$(CONFIG_PHY_MESON_GXL) += meson-gxl.o
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
new file mode 100644
index 00000000000..16313249373
--- /dev/null
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config MTK_NET_PHYLIB
+	tristate
+
+config PHY_MEDIATEK_2P5GE
+	tristate "MediaTek built-in 2.5Gb ethernet PHYs"
+	depends on OF_CONTROL && (TARGET_MT7987 || TARGET_MT7988)
+	select MTK_NET_PHYLIB
+	help
+	  Supports MediaTek SoC built-in 2.5Gb ethernet PHYs.
+
+	  This driver requires firmware download for PHY to enable its
+	  functionality. The board must override certian firmware downloading
+	  function to provide the firmware data.
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
new file mode 100644
index 00000000000..bc8dd4e878c
--- /dev/null
+++ b/drivers/net/phy/mediatek/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
+obj-$(CONFIG_PHY_MEDIATEK_2P5GE)	+= mtk-2p5ge.o
diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
new file mode 100644
index 00000000000..08c29f3af52
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc. All Rights Reserved.
+ *
+ * Author: Sky Huang <SkyLake.Huang@mediatek.com>
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ */
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <dm/of_access.h>
+#include <dm/pinctrl.h>
+#include <dm/ofnode.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <phy.h>
+#include "mtk.h"
+
+#define PBUS_BASE				0x0f000000
+#define PBUS_SIZE				0x1f0024
+
+#define MTK_2P5GPHY_PMD_REG			0x010000
+#define DO_NOT_RESET				(MTK_2P5GPHY_PMD_REG + 0x28)
+#define   DO_NOT_RESET_XBZ			BIT(0)
+#define   DO_NOT_RESET_PMA			BIT(3)
+#define   DO_NOT_RESET_RX			BIT(5)
+#define FNPLL_PWR_CTRL1				(MTK_2P5GPHY_PMD_REG + 0x208)
+#define   RG_SPEED_MASK				GENMASK(3, 0)
+#define   RG_SPEED_2500				BIT(3)
+#define   RG_SPEED_100				BIT(0)
+#define FNPLL_PWR_CTRL_STATUS			(MTK_2P5GPHY_PMD_REG + 0x20c)
+#define   RG_STABLE_MASK			GENMASK(3, 0)
+#define   RG_SPEED_2500_STABLE			BIT(3)
+#define   RG_SPEED_100_STABLE			BIT(0)
+
+#define MTK_2P5GPHY_XBZ_PCS			0x030000
+#define PHY_CTRL_CONFIG				(MTK_2P5GPHY_XBZ_PCS + 0x200)
+#define PMU_WP					(MTK_2P5GPHY_XBZ_PCS + 0x800)
+#define   WRITE_PROTECT_KEY			0xCAFEF00D
+#define PMU_PMA_AUTO_CFG			(MTK_2P5GPHY_XBZ_PCS + 0x820)
+#define   POWER_ON_AUTO_MODE			BIT(16)
+#define   PMU_AUTO_MODE_EN			BIT(0)
+#define PMU_PMA_STATUS				(MTK_2P5GPHY_XBZ_PCS + 0x840)
+#define   CLK_IS_DISABLED			BIT(3)
+
+#define MTK_2P5GPHY_XBZ_PMA_RX			0x080000
+#define SMEM_WDAT0				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5000)
+#define SMEM_WDAT1				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5004)
+#define SMEM_WDAT2				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5008)
+#define SMEM_WDAT3				(MTK_2P5GPHY_XBZ_PMA_RX + 0x500c)
+#define SMEM_CTRL				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5024)
+#define   SMEM_HW_RDATA_ZERO			BIT(24)
+#define SMEM_ADDR_REF_ADDR			(MTK_2P5GPHY_XBZ_PMA_RX + 0x502c)
+#define CM_CTRL_P01				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5100)
+#define CM_CTRL_P23				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5124)
+#define DM_CTRL_P01				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5200)
+#define DM_CTRL_P23				(MTK_2P5GPHY_XBZ_PMA_RX + 0x5224)
+
+#define MTK_2P5GPHY_CHIP_SCU			0x0cf800
+#define SYS_SW_RESET				(MTK_2P5GPHY_CHIP_SCU + 0x128)
+#define   RESET_RST_CNT				BIT(0)
+
+#define MTK_2P5GPHY_MCU_CSR			0x0f0000
+#define MD32_EN_CFG				(MTK_2P5GPHY_MCU_CSR + 0x18)
+#define   MD32_EN				BIT(0)
+
+#define MTK_2P5GPHY_PMB_FW			0x100000
+
+#define MTK_2P5GPHY_FCM_BASE			0x0e0000
+#define FC_LWM					(MTK_2P5GPHY_FCM_BASE + 0x14)
+#define   TX_FC_LWM_MASK			GENMASK(31, 16)
+#define MIN_IPG_NUM				(MTK_2P5GPHY_FCM_BASE + 0x2c)
+#define   LS_MIN_IPG_NUM_MASK			GENMASK(7, 0)
+#define FIFO_CTRL				(MTK_2P5GPHY_FCM_BASE + 0x40)
+#define   TX_SFIFO_IDLE_CNT_MASK		GENMASK(31, 28)
+#define   TX_SFIFO_DEL_IPG_WM_MASK		GENMASK(23, 16)
+
+#define MTK_2P5GPHY_APB_BASE			0x11c30000
+#define MTK_2P5GPHY_APB_SIZE			0x9c
+#define SW_RESET				0x94
+#define   MD32_RESTART_EN_CLEAR			BIT(9)
+
+/* Registers on CL22 page 0 */
+#define PHY_AUX_CTRL_STATUS			0x1d
+#define   PHY_AUX_DPX_MASK			GENMASK(5, 5)
+#define   PHY_AUX_SPEED_MASK			GENMASK(4, 2)
+
+enum {
+	PHY_AUX_SPD_10 = 0,
+	PHY_AUX_SPD_100,
+	PHY_AUX_SPD_1000,
+	PHY_AUX_SPD_2500,
+};
+
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_LINK_STATUS_RELATED		0x147
+#define   MTK_PHY_BYPASS_LINK_STATUS_OK		BIT(4)
+#define   MTK_PHY_FORCE_LINK_STATUS_HCD		BIT(3)
+
+#define MTK_PHY_AN_FORCE_SPEED_REG		0x313
+#define   MTK_PHY_MASTER_FORCE_SPEED_SEL_EN	BIT(7)
+#define   MTK_PHY_MASTER_FORCE_SPEED_SEL_MASK	GENMASK(6, 0)
+
+#define MTK_PHY_LPI_PCS_DSP_CTRL		0x121
+#define   MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK	GENMASK(12, 8)
+
+#define MTK_PHY_PMA_PMD_SPPED_ABILITY		0x300
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AUTO_NP_10XEN				BIT(6)
+
+/* Firmware file size */
+#define MT7987_2P5GE_PMB_FW_SIZE		0x18000
+#define MT7988_2P5GE_PMB_FW_SIZE		0x20000
+
+#define MT7987_2P5GE_DSPBITTB_SIZE		0x7000
+
+struct mtk_i2p5ge_fw_info {
+	u8 datecode[4];
+	u8 plat[2];
+	u8 ver[2];
+};
+
+struct mtk_i2p5ge_priv {
+	void __iomem *reg_base;
+	bool pd_en;
+	bool gbe_min_ipg_11_bytes;
+	bool auto_downshift_en;
+};
+
+static inline void pbus_write(struct mtk_i2p5ge_priv *priv, u32 offset,
+			      u32 val)
+{
+	writel(val, priv->reg_base + offset);
+}
+
+static inline void pbus_rmw(struct mtk_i2p5ge_priv *priv, u32 offset, u32 clr,
+			    u32 set)
+{
+	clrsetbits_le32(priv->reg_base + offset, clr, set);
+}
+
+static int mt798x_i2p5ge_download_fw(struct mtk_i2p5ge_priv *priv,
+				     size_t fwsize, const void *fwdata)
+{
+	u32 __iomem *fwmem = priv->reg_base + MTK_2P5GPHY_PMB_FW;
+	const u32 *fw;
+	u32 i;
+
+	/* Assume fw data is 4-byte aligned */
+	fw = fwdata;
+
+	for (i = 0; i < (fwsize >> 2); i++)
+		writel(fw[i], &fwmem[i]);
+
+	return 0;
+}
+
+static int mt798x_i2p5ge_phy_probe(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_priv *priv;
+
+	priv = malloc(sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+
+	priv->reg_base = ioremap(PBUS_BASE, PBUS_SIZE);
+	if (!priv->reg_base) {
+		free(priv);
+		return -ENODEV;
+	}
+
+	/* Initialize with default values */
+	priv->pd_en = true;
+	priv->gbe_min_ipg_11_bytes = false;
+	priv->auto_downshift_en = true;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int mt798x_i2p5ge_phy_config(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_priv *priv = phydev->priv;
+	ofnode node = phydev->node;
+
+	if (ofnode_valid(node)) {
+		priv->pd_en = !ofnode_read_bool(node, "pd-disable");
+		priv->gbe_min_ipg_11_bytes = ofnode_read_bool(node, "gbe-min-ipg-11-bytes");
+		priv->auto_downshift_en = !ofnode_read_bool(node, "auto-downshift-disable");
+	}
+
+	/* Setup LED */
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
+			 MTK_PHY_LED_ON_LINK10 |
+			 MTK_PHY_LED_ON_LINK100 |
+			 MTK_PHY_LED_ON_LINK1000 |
+			 MTK_PHY_LED_ON_LINK2500);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
+			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
+
+	/* Switch pinctrl after setting polarity to avoid bogus blinking */
+	pinctrl_select_state(phydev->dev, "i2p5gbe-led");
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LPI_PCS_DSP_CTRL,
+		       MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK, 0);
+
+	/* Enable 16-bit next page exchange bit if 1000-BT isn't advertising */
+	mtk_tr_modify(phydev, 0x0, 0xf, 0x3c, AUTO_NP_10XEN,
+		      FIELD_PREP(AUTO_NP_10XEN, 0x1));
+
+	/* Set HW auto downshift according to dts */
+	if (priv->auto_downshift_en) {
+		mtk_phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_1);
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       MTK_PHY_AUX_CTRL_AND_STATUS, 0,
+			       MTK_PHY_ENABLE_DOWNSHIFT);
+		mtk_phy_restore_page(phydev);
+	}
+
+	/* Configure parallel detction functionality */
+	if (priv->pd_en) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      MTK_PHY_PMA_PMD_SPPED_ABILITY, 0xf7cf);
+		phy_modify(phydev, MDIO_DEVAD_NONE, MII_ADVERTISE, 0,
+			   ADVERTISE_100HALF | ADVERTISE_10HALF);
+	}
+
+	return 0;
+}
+
+static void mt798x_i2p5ge_print_fw_info(const void *fwdata, size_t fwsize)
+{
+	const struct mtk_i2p5ge_fw_info *info;
+	u8 ver_minor, ver_patch;
+
+	info = (const void *)((uintptr_t)fwdata + fwsize - sizeof(*info));
+
+	ver_minor = info->ver[1] >> 4;
+	ver_patch = info->ver[1] & 0xf;
+
+	printf("Firmware loaded, date %02x%02x/%02x/%02x, ver %x.%u.%u\n",
+	       info->datecode[0], info->datecode[1], info->datecode[2],
+	       info->datecode[3], info->ver[0], ver_minor, ver_patch);
+}
+
+int __weak mt7987_i2p5ge_get_fw(const void **fw, size_t *fwsize,
+				const void **dspfw, size_t *dspfwsize)
+{
+	return -1;
+}
+
+static int mt7987_i2p5ge_download_dspfw(struct mtk_i2p5ge_priv *priv,
+					const void *dspfw_data)
+{
+	const u32 *dspfw;
+	u32 i;
+
+	pbus_rmw(priv, SMEM_CTRL, 0, SMEM_HW_RDATA_ZERO);
+
+	pbus_rmw(priv, PHY_CTRL_CONFIG, 0, BIT(16));
+
+	/* Initialize data memory */
+	pbus_rmw(priv, DM_CTRL_P01, 0, BIT(28));
+	pbus_rmw(priv, DM_CTRL_P23, 0, BIT(28));
+
+	/* Initialize coefficient memory */
+	pbus_rmw(priv, CM_CTRL_P01, 0, BIT(28));
+	pbus_rmw(priv, CM_CTRL_P23, 0, BIT(28));
+
+	/* Initialize PM offset */
+	pbus_write(priv, SMEM_ADDR_REF_ADDR, 0);
+
+	/* Assume DSP bit data is 4-byte aligned */
+	dspfw = dspfw_data;
+
+	for (i = 0; i < (MT7987_2P5GE_DSPBITTB_SIZE >> 2); i += 4) {
+		pbus_write(priv, SMEM_WDAT0, dspfw[i]);
+		pbus_write(priv, SMEM_WDAT1, dspfw[i + 1]);
+		pbus_write(priv, SMEM_WDAT2, dspfw[i + 2]);
+		pbus_write(priv, SMEM_WDAT3, dspfw[i + 3]);
+	}
+
+	pbus_rmw(priv, DM_CTRL_P01, BIT(28), 0);
+	pbus_rmw(priv, DM_CTRL_P23, BIT(28), 0);
+
+	pbus_rmw(priv, CM_CTRL_P01, BIT(28), 0);
+	pbus_rmw(priv, CM_CTRL_P23, BIT(28), 0);
+
+	return 0;
+}
+
+static int mt7987_i2p5ge_phy_load_fw(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_priv *priv = phydev->priv;
+	size_t fw_size, dspfw_size;
+	void __iomem *apb_base;
+	const u8 *fw, *dspfw;
+	int ret, fwrc;
+	u32 reg;
+
+	apb_base = ioremap(MTK_2P5GPHY_APB_BASE, MTK_2P5GPHY_APB_SIZE);
+	if (!apb_base)
+		return -ENODEV;
+
+	fwrc = mt7987_i2p5ge_get_fw((const void **)&fw, &fw_size,
+				    (const void **)&dspfw, &dspfw_size);
+	if (fwrc < 0) {
+		dev_err(phydev->dev, "Failed to get firmware data\n");
+		return -EINVAL;
+	}
+
+	if (fw_size != MT7987_2P5GE_PMB_FW_SIZE) {
+		dev_err(phydev->dev,
+			"PMB firmware size mismatch (0x%zx != 0x%x)\n",
+			fw_size, MT7987_2P5GE_PMB_FW_SIZE);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (dspfw_size != MT7987_2P5GE_DSPBITTB_SIZE) {
+		dev_err(phydev->dev,
+			"DSP code size mismatch (0x%zx != 0x%x)\n",
+			dspfw_size, MT7987_2P5GE_DSPBITTB_SIZE);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/* Force 2.5Gphy back to AN state */
+	phy_set_bits_mmd(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_RESET);
+	mdelay(5);
+	phy_set_bits_mmd(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_PDOWN);
+
+	clrbits_le16(apb_base + SW_RESET, MD32_RESTART_EN_CLEAR);
+	setbits_le16(apb_base + SW_RESET, MD32_RESTART_EN_CLEAR);
+	clrbits_le16(apb_base + SW_RESET, MD32_RESTART_EN_CLEAR);
+
+	pbus_rmw(priv, MD32_EN_CFG, MD32_EN, 0);
+
+	ret = mt798x_i2p5ge_download_fw(priv, MT7987_2P5GE_PMB_FW_SIZE, fw);
+	if (ret)
+		goto cleanup;
+
+	/* Enable 100Mbps module clock. */
+	pbus_rmw(priv, FNPLL_PWR_CTRL1, RG_SPEED_MASK, RG_SPEED_100);
+
+	/* Check if 100Mbps module clock is ready. */
+	ret = readl_poll_timeout(priv->reg_base + FNPLL_PWR_CTRL_STATUS, reg,
+				 reg & RG_SPEED_100_STABLE, 10000);
+	if (ret) {
+		dev_err(phydev->dev,
+			"Timed out enabling 100Mbps module clock\n");
+	}
+
+	/* Enable 2.5Gbps module clock. */
+	pbus_rmw(priv, FNPLL_PWR_CTRL1, RG_SPEED_MASK, RG_SPEED_2500);
+
+	/* Check if 2.5Gbps module clock is ready. */
+	ret = readl_poll_timeout(priv->reg_base + FNPLL_PWR_CTRL_STATUS, reg,
+				 reg & RG_SPEED_2500_STABLE, 10000);
+
+	if (ret) {
+		dev_err(phydev->dev,
+			"Timed out enabling 2.5Gbps module clock\n");
+	}
+
+	/* Disable AN */
+	phy_clear_bits_mmd(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_ANENABLE);
+
+	/* Force to run at 2.5G speed */
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_AN_FORCE_SPEED_REG,
+		       MTK_PHY_MASTER_FORCE_SPEED_SEL_MASK,
+		       MTK_PHY_MASTER_FORCE_SPEED_SEL_EN |
+		       FIELD_PREP(MTK_PHY_MASTER_FORCE_SPEED_SEL_MASK, 0x1b));
+
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_RELATED,
+			 MTK_PHY_BYPASS_LINK_STATUS_OK |
+			 MTK_PHY_FORCE_LINK_STATUS_HCD);
+
+	/* Set xbz, pma and rx as "do not reset" in order to input DSP code. */
+	pbus_rmw(priv, DO_NOT_RESET, 0,
+		 DO_NOT_RESET_XBZ | DO_NOT_RESET_PMA | DO_NOT_RESET_RX);
+
+	pbus_rmw(priv, SYS_SW_RESET, RESET_RST_CNT, 0);
+
+	pbus_write(priv, PMU_WP, WRITE_PROTECT_KEY);
+
+	pbus_rmw(priv, PMU_PMA_AUTO_CFG, 0,
+		 PMU_AUTO_MODE_EN | POWER_ON_AUTO_MODE);
+
+	/* Check if clock in auto mode is disabled. */
+	ret = readl_poll_timeout(priv->reg_base + PMU_PMA_STATUS, reg,
+				 (reg & CLK_IS_DISABLED) == 0x0, 100000);
+	if (ret)
+		dev_err(phydev->dev, "Timed out enabling clock auto mode\n");
+
+	ret = mt7987_i2p5ge_download_dspfw(priv, dspfw);
+	if (ret)
+		goto cleanup;
+
+	pbus_rmw(priv, MD32_EN_CFG, 0, MD32_EN);
+
+	phy_set_bits_mmd(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_RESET);
+
+	/* We need a delay here to stabilize initialization of MCU */
+	mdelay(8);
+
+	mt798x_i2p5ge_print_fw_info(fw, fw_size);
+
+cleanup:
+	if (fwrc > 0) {
+		free((void *)fw);
+		free((void *)dspfw);
+	}
+
+	iounmap(apb_base);
+
+	return ret;
+}
+
+static int mt7987_i2p5ge_phy_config(struct phy_device *phydev)
+{
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
+			   MTK_PHY_LED_ON_POLARITY);
+
+	return mt798x_i2p5ge_phy_config(phydev);
+}
+
+static int mt7987_i2p5ge_phy_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mt798x_i2p5ge_phy_probe(phydev);
+	if (ret)
+		return ret;
+
+	return mt7987_i2p5ge_phy_load_fw(phydev);
+}
+
+int __weak mt7988_i2p5ge_get_fw(const void **fw, size_t *size)
+{
+	return -1;
+}
+
+static int mt7988_i2p5ge_phy_load_fw(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_priv *priv = phydev->priv;
+	size_t fw_size;
+	int ret, fwrc;
+	const u8 *fw;
+
+	fwrc = mt7988_i2p5ge_get_fw((const void **)&fw, &fw_size);
+	if (fwrc < 0) {
+		dev_err(phydev->dev, "Failed to get firmware data\n");
+		return -EINVAL;
+	}
+
+	if (fw_size != MT7988_2P5GE_PMB_FW_SIZE) {
+		dev_err(phydev->dev, "Firmware size mismatch (0x%zx != 0x%x)\n",
+			fw_size, MT7988_2P5GE_PMB_FW_SIZE);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = mt798x_i2p5ge_download_fw(priv, MT7988_2P5GE_PMB_FW_SIZE, fw);
+	if (ret)
+		goto cleanup;
+
+	pbus_rmw(priv, MD32_EN_CFG, MD32_EN, 0);
+	pbus_rmw(priv, MD32_EN_CFG, 0, MD32_EN);
+
+	phy_set_bits_mmd(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_RESET);
+
+	/* We need a delay here to stabilize initialization of MCU */
+	mdelay(8);
+
+	mt798x_i2p5ge_print_fw_info(fw, fw_size);
+
+cleanup:
+	if (fwrc > 0)
+		free((void *)fw);
+
+	return ret;
+}
+
+static int mt7988_i2p5ge_phy_config(struct phy_device *phydev)
+{
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
+			 MTK_PHY_LED_ON_POLARITY);
+
+	return mt798x_i2p5ge_phy_config(phydev);
+}
+
+static int mt7988_i2p5ge_phy_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mt798x_i2p5ge_phy_probe(phydev);
+	if (ret)
+		return ret;
+
+	return mt7988_i2p5ge_phy_load_fw(phydev);
+}
+
+static int mt798x_i2p5ge_phy_startup(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_priv *priv = phydev->priv;
+	int ret;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	/* Initialize speed/duplex */
+	phydev->speed = SPEED_10;
+	phydev->duplex = DUPLEX_HALF;
+
+	if (phydev->link) {
+		ret = phy_read(phydev, MDIO_DEVAD_NONE, PHY_AUX_CTRL_STATUS);
+		if (ret < 0)
+			return ret;
+
+		switch (FIELD_GET(PHY_AUX_SPEED_MASK, ret)) {
+		case PHY_AUX_SPD_10:
+			phydev->speed = SPEED_10;
+			break;
+
+		case PHY_AUX_SPD_100:
+			phydev->speed = SPEED_100;
+			break;
+
+		case PHY_AUX_SPD_1000:
+			/* Apply gbe_min_ipg_11_bytes setting for 1000Mbps */
+			if (!priv->gbe_min_ipg_11_bytes) {
+				pbus_rmw(priv, FIFO_CTRL,
+					 TX_SFIFO_IDLE_CNT_MASK | TX_SFIFO_DEL_IPG_WM_MASK,
+					 FIELD_PREP(TX_SFIFO_IDLE_CNT_MASK, 0x1) |
+					 FIELD_PREP(TX_SFIFO_DEL_IPG_WM_MASK, 0x10));
+				pbus_rmw(priv, MIN_IPG_NUM, LS_MIN_IPG_NUM_MASK,
+					 FIELD_PREP(LS_MIN_IPG_NUM_MASK, 0xa));
+				pbus_rmw(priv, FC_LWM, TX_FC_LWM_MASK,
+					 FIELD_PREP(TX_FC_LWM_MASK, 0x340));
+			}
+			phydev->speed = SPEED_1000;
+			break;
+
+		case PHY_AUX_SPD_2500:
+			phydev->speed = SPEED_2500;
+			break;
+
+		default:
+			break;
+		}
+
+		/* This PHY always operates in full duplex */
+		phydev->duplex = DUPLEX_FULL;
+	}
+
+	return 0;
+}
+
+U_BOOT_PHY_DRIVER(mt7987_i2p5ge) = {
+	.name = "MediaTek MT7987 built-in 2.5GbE PHY",
+	.uid = 0x00339c91,
+	.mask = 0xfffffff0,
+	.features = PHY_10G_FEATURES,
+	.mmds = (MDIO_MMD_PCS | MDIO_MMD_AN | MDIO_MMD_VEND1 | MDIO_MMD_VEND2),
+	.probe = &mt7987_i2p5ge_phy_probe,
+	.config = &mt7987_i2p5ge_phy_config,
+	.startup = &mt798x_i2p5ge_phy_startup,
+	.shutdown = &genphy_shutdown,
+};
+
+U_BOOT_PHY_DRIVER(mt7988_i2p5ge) = {
+	.name = "MediaTek MT7988 built-in 2.5GbE PHY",
+	.uid = 0x00339c11,
+	.mask = 0xfffffff0,
+	.features = PHY_10G_FEATURES,
+	.mmds = (MDIO_MMD_PCS | MDIO_MMD_AN | MDIO_MMD_VEND1 | MDIO_MMD_VEND2),
+	.probe = &mt7988_i2p5ge_phy_probe,
+	.config = &mt7988_i2p5ge_phy_config,
+	.startup = &mt798x_i2p5ge_phy_startup,
+	.shutdown = &genphy_shutdown,
+};
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
new file mode 100644
index 00000000000..55e7a6b6eec
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc. All Rights Reserved.
+ *
+ * Author: Sky Huang <SkyLake.Huang@mediatek.com>
+ */
+#include <dm/device_compat.h>
+#include <phy.h>
+
+#include "mtk.h"
+
+void mtk_phy_select_page(struct phy_device *phydev, int page)
+{
+	phy_write(phydev, MDIO_DEVAD_NONE, MTK_EXT_PAGE_ACCESS, page);
+}
+
+void mtk_phy_restore_page(struct phy_device *phydev)
+{
+	phy_write(phydev, MDIO_DEVAD_NONE, MTK_EXT_PAGE_ACCESS,
+		  MTK_PHY_PAGE_STANDARD);
+}
+
+/* Difference between functions with mtk_tr* and __mtk_tr* prefixes is
+ * mtk_tr* functions: wrapped by page switching operations
+ * __mtk_tr* functions: no page switching operations
+ */
+static void __mtk_tr_access(struct phy_device *phydev, bool read, u8 ch_addr,
+			    u8 node_addr, u8 data_addr)
+{
+	u16 tr_cmd = BIT(15); /* bit 14 & 0 are reserved */
+
+	if (read)
+		tr_cmd |= BIT(13);
+
+	tr_cmd |= (((ch_addr & 0x3) << 11) |
+		   ((node_addr & 0xf) << 7) |
+		   ((data_addr & 0x3f) << 1));
+	dev_dbg(phydev->dev, "tr_cmd: 0x%x\n", tr_cmd);
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x10, tr_cmd);
+}
+
+static void __mtk_tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+			  u8 data_addr, u16 *tr_high, u16 *tr_low)
+{
+	__mtk_tr_access(phydev, true, ch_addr, node_addr, data_addr);
+	*tr_low = phy_read(phydev, MDIO_DEVAD_NONE, 0x11);
+	*tr_high = phy_read(phydev, MDIO_DEVAD_NONE, 0x12);
+	dev_dbg(phydev->dev, "tr_high read: 0x%x, tr_low read: 0x%x\n",
+		*tr_high, *tr_low);
+}
+
+u32 mtk_tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		u8 data_addr)
+{
+	u16 tr_high;
+	u16 tr_low;
+
+	mtk_phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
+	mtk_phy_restore_page(phydev);
+
+	return (tr_high << 16) | tr_low;
+}
+
+static void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+			   u8 data_addr, u32 tr_data)
+{
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x11, tr_data & 0xffff);
+	phy_write(phydev, MDIO_DEVAD_NONE, 0x12, tr_data >> 16);
+	dev_dbg(phydev->dev, "tr_high write: 0x%x, tr_low write: 0x%x\n",
+		tr_data >> 16, tr_data & 0xffff);
+	__mtk_tr_access(phydev, false, ch_addr, node_addr, data_addr);
+}
+
+void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		     u8 data_addr, u32 mask, u32 set)
+{
+	u32 tr_data;
+	u16 tr_high;
+	u16 tr_low;
+
+	__mtk_tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
+	tr_data = (tr_high << 16) | tr_low;
+	tr_data = (tr_data & ~mask) | set;
+	__mtk_tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
+}
+
+void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 mask, u32 set)
+{
+	mtk_phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_modify(phydev, ch_addr, node_addr, data_addr, mask, set);
+	mtk_phy_restore_page(phydev);
+}
+
+void __mtk_tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 set)
+{
+	__mtk_tr_modify(phydev, ch_addr, node_addr, data_addr, 0, set);
+}
+
+void __mtk_tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 clr)
+{
+	__mtk_tr_modify(phydev, ch_addr, node_addr, data_addr, clr, 0);
+}
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
new file mode 100644
index 00000000000..68044cbdb32
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 MediaTek Inc. All Rights Reserved.
+ *
+ * Author: Sky Huang <SkyLake.Huang@mediatek.com>
+ *
+ * Common definition for Mediatek Ethernet PHYs
+ */
+
+#ifndef _MTK_EPHY_H_
+#define _MTK_EPHY_H_
+
+#define MTK_EXT_PAGE_ACCESS			0x1f
+#define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
+#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
+/* suprv_media_select_RefClk */
+#define   MTK_PHY_LP_DETECTED_MASK		GENMASK(7, 6)
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
+#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x2 */
+#define   AN_STATE_MASK				GENMASK(22, 19)
+#define   AN_STATE_SHIFT			19
+#define   AN_STATE_TX_DISABLE			1
+
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AN_NEW_LP_CNT_LIMIT_MASK		GENMASK(23, 20)
+#define AUTO_NP_10XEN				BIT(6)
+
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_LINK_STATUS_MISC		(0xa2)
+#define   MTK_PHY_FINAL_SPEED_1000		BIT(3)
+
+/* Registers on MDIO_MMD_VEND2 */
+#define MTK_PHY_LED0_ON_CTRL			0x24
+#define MTK_PHY_LED1_ON_CTRL			0x26
+#define   MTK_GPHY_LED_ON_MASK			GENMASK(6, 0)
+#define   MTK_2P5GPHY_LED_ON_MASK		GENMASK(7, 0)
+#define   MTK_PHY_LED_ON_LINK1000		BIT(0)
+#define   MTK_PHY_LED_ON_LINK100		BIT(1)
+#define   MTK_PHY_LED_ON_LINK10			BIT(2)
+#define   MTK_PHY_LED_ON_LINKDOWN		BIT(3)
+#define   MTK_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
+#define   MTK_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
+#define   MTK_PHY_LED_ON_FORCE_ON		BIT(6)
+#define   MTK_PHY_LED_ON_LINK2500		BIT(7)
+#define   MTK_PHY_LED_ON_POLARITY		BIT(14)
+#define   MTK_PHY_LED_ON_ENABLE			BIT(15)
+
+#define MTK_PHY_LED0_BLINK_CTRL			0x25
+#define MTK_PHY_LED1_BLINK_CTRL			0x27
+#define   MTK_PHY_LED_BLINK_1000TX		BIT(0)
+#define   MTK_PHY_LED_BLINK_1000RX		BIT(1)
+#define   MTK_PHY_LED_BLINK_100TX		BIT(2)
+#define   MTK_PHY_LED_BLINK_100RX		BIT(3)
+#define   MTK_PHY_LED_BLINK_10TX		BIT(4)
+#define   MTK_PHY_LED_BLINK_10RX		BIT(5)
+#define   MTK_PHY_LED_BLINK_COLLISION		BIT(6)
+#define   MTK_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
+#define   MTK_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
+#define   MTK_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
+#define   MTK_PHY_LED_BLINK_2500TX		BIT(10)
+#define   MTK_PHY_LED_BLINK_2500RX		BIT(11)
+
+#define MTK_GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK1000 | \
+						 MTK_PHY_LED_ON_LINK100 | \
+						 MTK_PHY_LED_ON_LINK10)
+#define MTK_GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
+						 MTK_PHY_LED_BLINK_100RX | \
+						 MTK_PHY_LED_BLINK_10RX)
+#define MTK_GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
+						 MTK_PHY_LED_BLINK_100RX | \
+						 MTK_PHY_LED_BLINK_10RX)
+
+#define MTK_2P5GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK2500 | \
+						 MTK_GPHY_LED_ON_SET)
+#define MTK_2P5GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+						 MTK_GPHY_LED_RX_BLINK_SET)
+#define MTK_2P5GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+						 MTK_GPHY_LED_TX_BLINK_SET)
+
+#define MTK_PHY_LED_STATE_FORCE_ON		0
+#define MTK_PHY_LED_STATE_FORCE_BLINK		1
+#define MTK_PHY_LED_STATE_NETDEV		2
+
+void mtk_phy_select_page(struct phy_device *phydev, int page);
+void mtk_phy_restore_page(struct phy_device *phydev);
+
+u32 mtk_tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		u8 data_addr);
+void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		     u8 data_addr, u32 mask, u32 set);
+void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		   u8 data_addr, u32 mask, u32 set);
+void __mtk_tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 set);
+void __mtk_tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		       u8 data_addr, u32 clr);
+
+#endif /* _MTK_EPHY_H_ */
-- 
2.34.1

