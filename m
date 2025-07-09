Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734BBC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 15:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA198834A3;
	Wed,  9 Jul 2025 17:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F978350A; Wed,  9 Jul 2025 17:24:14 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A66983390
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 17:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uZWeY-008cp4-82;
 Wed, 09 Jul 2025 15:24:10 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Alice Guo <alice.guo@oss.nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, peng.fan@nxp.com,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [RESEND PATCH] phy: phy-imx8mq-usb: Add support for i.MX95 USB3 PHY
Date: Wed,  9 Jul 2025 08:24:08 -0700
Message-Id: <20250709152408.3037701-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Add initial support for i.MX95 USB.30 PHY, which is similar to
the i.MX8MQ and i.MX8MP USB PHY.

The i.MX95 USB3 PHY has a Type-C Assist block (TCA) consisting of two
functional blocks (XBar assist and VBus assist) and is documented
in the i.MX95 RM Chapter 163.3.8 Type-C assist (TCA) block.

Instead of relying on an external MUX for Type-C plug orientation the
XBar can handle the flip internally.

Add initial support for i.MX95 by:
 - allowing the driver to be enabled i.MX95
 - resetting the XBar
 - configuring the TCA in System Configuration mode (which was determined
   to be necessary to enable the PHY in device-mode)

Follow-on support will need to be added to steer the XBar based on
either board design (if only one pair is brought out) or if used with a
Type-C controller.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/phy/Kconfig          |  6 +--
 drivers/phy/phy-imx8mq-usb.c | 91 +++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d3fe90d939e8..9f0c2bf04c4e 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -280,11 +280,11 @@ config PHY_NPCM_USB
 	  Support the USB PHY in NPCM SoCs
 
 config PHY_IMX8MQ_USB
-	bool "NXP i.MX8MQ/i.MX8MP USB PHY Driver"
+	bool "NXP i.MX8MQ/i.MX8MP/i.MX95 USB PHY Driver"
 	depends on PHY
-	depends on IMX8MQ || IMX8MP
+	depends on IMX8MQ || IMX8MP || IMX95
 	help
-	  Support the USB3.0 PHY in NXP i.MX8MQ or i.MX8MP SoC
+	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, and i.MX95 SoC
 
 config PHY_IMX8M_PCIE
 	bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
diff --git a/drivers/phy/phy-imx8mq-usb.c b/drivers/phy/phy-imx8mq-usb.c
index 75763046adc1..387db843c502 100644
--- a/drivers/phy/phy-imx8mq-usb.c
+++ b/drivers/phy/phy-imx8mq-usb.c
@@ -71,9 +71,57 @@
 #define PHY_STS0_FSVPLUS		BIT(3)
 #define PHY_STS0_FSVMINUS		BIT(2)
 
+#define TCA_CLK_RST			0x00
+#define TCA_CLK_RST_SW			BIT(9)
+#define TCA_CLK_RST_REF_CLK_EN		BIT(1)
+#define TCA_CLK_RST_SUSPEND_CLK_EN	BIT(0)
+
+#define TCA_INTR_EN			0x04
+#define TCA_INTR_STS			0x08
+
+#define TCA_GCFG			0x10
+#define TCA_GCFG_ROLE_HSTDEV		BIT(4)
+#define TCA_GCFG_OP_MODE		GENMASK(1, 0)
+#define TCA_GCFG_OP_MODE_SYSMODE	0
+#define TCA_GCFG_OP_MODE_SYNCMODE	1
+
+#define TCA_TCPC			0x14
+#define TCA_TCPC_VALID			BIT(4)
+#define TCA_TCPC_LOW_POWER_EN		BIT(3)
+#define TCA_TCPC_ORIENTATION_NORMAL	BIT(2)
+#define TCA_TCPC_MUX_CONTRL		GENMASK(1, 0)
+#define TCA_TCPC_MUX_CONTRL_NO_CONN	0
+#define TCA_TCPC_MUX_CONTRL_USB_CONN	1
+
+#define TCA_SYSMODE_CFG			0x18
+#define TCA_SYSMODE_TCPC_DISABLE	BIT(3)
+#define TCA_SYSMODE_TCPC_FLIP		BIT(2)
+
+#define TCA_CTRLSYNCMODE_CFG0		0x20
+#define TCA_CTRLSYNCMODE_CFG1           0x20
+
+#define TCA_PSTATE			0x30
+#define TCA_PSTATE_CM_STS		BIT(4)
+#define TCA_PSTATE_TX_STS		BIT(3)
+#define TCA_PSTATE_RX_PLL_STS		BIT(2)
+#define TCA_PSTATE_PIPE0_POWER_DOWN	GENMASK(1, 0)
+
+#define TCA_GEN_STATUS			0x34
+#define TCA_GEN_DEV_POR			BIT(12)
+#define TCA_GEN_REF_CLK_SEL		BIT(8)
+#define TCA_GEN_TYPEC_FLIP_INVERT	BIT(4)
+#define TCA_GEN_PHY_TYPEC_DISABLE	BIT(3)
+#define TCA_GEN_PHY_TYPEC_FLIP		BIT(2)
+
+#define TCA_VBUS_CTRL			0x40
+#define TCA_VBUS_STATUS			0x44
+
+#define TCA_INFO			0xfc
+
 enum imx8mpq_phy_type {
 	IMX8MQ_PHY,
 	IMX8MP_PHY,
+	IMX95_PHY,
 };
 
 struct imx8mq_usb_phy {
@@ -81,14 +129,49 @@ struct imx8mq_usb_phy {
 	void __iomem *base;
 	enum imx8mpq_phy_type type;
 	struct udevice *vbus_supply;
+	void __iomem *tca_base;
 };
 
 static const struct udevice_id imx8mq_usb_phy_of_match[] = {
 	{ .compatible = "fsl,imx8mq-usb-phy", .data = IMX8MQ_PHY },
 	{ .compatible = "fsl,imx8mp-usb-phy", .data = IMX8MP_PHY },
+	{ .compatible = "fsl,imx95-usb-phy", .data = IMX95_PHY },
 	{},
 };
 
+static void tca_blk_init(struct phy *usb_phy)
+{
+	struct udevice *dev = usb_phy->dev;
+	struct imx8mq_usb_phy *imx_phy = dev_get_priv(dev);
+	void __iomem *base = imx_phy->tca_base;
+	u32 val;
+
+	/* reset XBar block */
+	val = readl(base + TCA_CLK_RST);
+	val &= ~TCA_CLK_RST_SW;
+	writel(val, base + TCA_CLK_RST);
+
+	udelay(100);
+
+	/* clear reset */
+	val |= TCA_CLK_RST_SW;
+	writel(val, base + TCA_CLK_RST);
+
+	/*
+	 * use Controller Synced Mode for TCA low power enable and
+	 * put PHY to USB safe state.
+	 */
+	val = FIELD_PREP(TCA_GCFG_OP_MODE, TCA_GCFG_OP_MODE_SYNCMODE);
+	writel(val, base + TCA_GCFG);
+
+	val = TCA_TCPC_VALID | TCA_TCPC_LOW_POWER_EN;
+	writel(val, base + TCA_TCPC);
+
+	/* use System Configuration Mode for TCA mux control. */
+	val = FIELD_PREP(TCA_GCFG_OP_MODE, TCA_GCFG_OP_MODE_SYSMODE);
+	writel(val, base + TCA_GCFG);
+}
+
 static int imx8mq_usb_phy_init(struct phy *usb_phy)
 {
 	struct udevice *dev = usb_phy->dev;
@@ -154,6 +237,9 @@ static int imx8mp_usb_phy_init(struct phy *usb_phy)
 	value &= ~(PHY_CTRL1_RESET | PHY_CTRL1_ATERESET);
 	writel(value, imx_phy->base + PHY_CTRL1);
 
+	if (imx_phy->tca_base)
+		tca_blk_init(usb_phy);
+
 	return 0;
 }
 
@@ -162,7 +248,7 @@ static int imx8mpq_usb_phy_init(struct phy *usb_phy)
 	struct udevice *dev = usb_phy->dev;
 	struct imx8mq_usb_phy *imx_phy = dev_get_priv(dev);
 
-	if (imx_phy->type == IMX8MP_PHY)
+	if (imx_phy->type == IMX8MP_PHY || imx_phy->type == IMX95_PHY)
 		return imx8mp_usb_phy_init(usb_phy);
 	else
 		return imx8mq_usb_phy_init(usb_phy);
@@ -264,6 +350,9 @@ int imx8mq_usb_phy_probe(struct udevice *dev)
 		}
 	}
 
+	if (priv->type == IMX95_PHY)
+		priv->tca_base = dev_read_addr_index_ptr(dev, 1);
+
 	return 0;
 }
 
-- 
2.25.1

