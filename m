Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB95C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727B0812C8;
	Tue,  4 Mar 2025 17:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364A8807EE; Tue,  4 Mar 2025 17:38:04 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id A4F28807EE
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: XbdI0JXCSyi8Iy4oRjm2vA==
X-CSE-MsgGUID: vqYyBNTFSeCp8yCh/3oEAA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 05 Mar 2025 01:38:01 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id A80F84024115;
 Wed,  5 Mar 2025 01:37:58 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 4/5] phy: rcar: Support RZ/G2L USB PHY
Date: Tue,  4 Mar 2025 16:37:34 +0000
Message-ID: <20250304163736.89326-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
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

Extend the existing Renesas R-Car gen3 USB 2.0 PHY driver to support the
RZ/G2L and related SoCs.

Also enable this driver by default for the RZ/G2L SoC family.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/phy/Kconfig         |  4 +-
 drivers/phy/phy-rcar-gen3.c | 79 ++++++++++++++++++++++++++++++-------
 2 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index e12347e8a031..a3a500bb49b3 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -163,8 +163,8 @@ config PHY_RCAR_GEN2
 
 config PHY_RCAR_GEN3
 	tristate "Renesas R-Car Gen3 USB PHY"
-	depends on PHY && RCAR_GEN3 && CLK && DM_REGULATOR
-	default y if RCAR_GEN3
+	depends on PHY && CLK && DM_REGULATOR && (RCAR_GEN3 || RZG2L)
+	default y if (RCAR_GEN3 || RZG2L)
 	help
 	  Support for the Renesas R-Car Gen3 USB PHY. This driver operates the
 	  PHY connected to EHCI USB module and controls USB OTG operation.
diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index 8c004eaf4c62..d06861c4f790 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -55,6 +55,7 @@
 
 /* VBCTRL */
 #define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
+#define USB2_VBCTRL_VBOUT		BIT(0)
 
 /* LINECTRL1 */
 #define USB2_LINECTRL1_DPRPD_EN		BIT(19)
@@ -68,6 +69,13 @@
 #define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
 #define USB2_ADPCTRL_DRVVBUS		BIT(4)
 
+/*  RZ/G2L specific */
+#define USB2_OBINT_IDCHG_EN		BIT(0)
+#define USB2_LINECTRL1_USB2_IDMON	BIT(0)
+
+/* Device flags */
+#define RCAR_GEN3_PHY_NO_ADPCTRL	BIT(0)
+
 struct rcar_gen3_phy {
 	fdt_addr_t	regs;
 	struct clk	clk;
@@ -122,15 +130,50 @@ static int rcar_gen3_phy_phy_power_off(struct phy *phy)
 	return regulator_set_enable(priv->vbus_supply, false);
 }
 
+static bool rcar_gen3_phy_check_id(struct phy *phy)
+{
+	const u32 adpdevmask = USB2_ADPCTRL_IDDIG | USB2_ADPCTRL_OTGSESSVLD;
+	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
+	ulong flags = dev_get_driver_data(phy->dev);
+	u32 val;
+
+	if (flags & RCAR_GEN3_PHY_NO_ADPCTRL) {
+		val = readl(priv->regs + USB2_LINECTRL1);
+		return !!(val & USB2_LINECTRL1_USB2_IDMON);
+	}
+
+	val = readl(priv->regs + USB2_ADPCTRL);
+	return (val & adpdevmask) == adpdevmask;
+}
+
+static void rcar_gen3_phy_set_vbus(struct phy *phy, bool enable)
+{
+	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
+	ulong flags = dev_get_driver_data(phy->dev);
+	u32 bits = USB2_ADPCTRL_DRVVBUS;
+	u64 reg = USB2_ADPCTRL;
+
+	if (flags & RCAR_GEN3_PHY_NO_ADPCTRL) {
+		bits = USB2_VBCTRL_VBOUT;
+		reg = USB2_VBCTRL;
+	}
+
+	if (enable)
+		setbits_le32(priv->regs + reg, bits);
+	else
+		clrbits_le32(priv->regs + reg, bits);
+}
+
 static int rcar_gen3_phy_phy_set_mode(struct phy *phy, enum phy_mode mode,
 				      int submode)
 {
-	const u32 adpdevmask = USB2_ADPCTRL_IDDIG | USB2_ADPCTRL_OTGSESSVLD;
 	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
-	u32 adpctrl;
+	ulong flags = dev_get_driver_data(phy->dev);
 
 	if (mode == PHY_MODE_USB_OTG) {
 		if (submode) {
+			u32 obint_enable_bits;
+
 			/* OTG submode is used as initialization indicator */
 			writel(USB2_INT_ENABLE_UCOM_INTEN |
 			       USB2_INT_ENABLE_USBH_INTB_EN |
@@ -138,13 +181,16 @@ static int rcar_gen3_phy_phy_set_mode(struct phy *phy, enum phy_mode mode,
 			       priv->regs + USB2_INT_ENABLE);
 			setbits_le32(priv->regs + USB2_VBCTRL,
 				     USB2_VBCTRL_DRVVBUSSEL);
-			writel(USB2_OBINT_SESSVLDCHG | USB2_OBINT_IDDIGCHG,
-			       priv->regs + USB2_OBINTSTA);
-			setbits_le32(priv->regs + USB2_OBINTEN,
-				     USB2_OBINT_SESSVLDCHG |
-				     USB2_OBINT_IDDIGCHG);
-			setbits_le32(priv->regs + USB2_ADPCTRL,
-				     USB2_ADPCTRL_IDPULLUP);
+			if (flags & RCAR_GEN3_PHY_NO_ADPCTRL) {
+				obint_enable_bits = USB2_OBINT_IDCHG_EN;
+			} else {
+				obint_enable_bits = USB2_OBINT_SESSVLDCHG |
+						    USB2_OBINT_IDDIGCHG;
+				setbits_le32(priv->regs + USB2_ADPCTRL,
+					     USB2_ADPCTRL_IDPULLUP);
+			}
+			writel(obint_enable_bits, priv->regs + USB2_OBINTSTA);
+			setbits_le32(priv->regs + USB2_OBINTEN, obint_enable_bits);
 			clrsetbits_le32(priv->regs + USB2_LINECTRL1,
 					USB2_LINECTRL1_DP_RPD |
 					USB2_LINECTRL1_DM_RPD |
@@ -154,8 +200,7 @@ static int rcar_gen3_phy_phy_set_mode(struct phy *phy, enum phy_mode mode,
 					USB2_LINECTRL1_DMRPD_EN);
 		}
 
-		adpctrl = readl(priv->regs + USB2_ADPCTRL);
-		if ((adpctrl & adpdevmask) == adpdevmask)
+		if (rcar_gen3_phy_check_id(phy))
 			mode = PHY_MODE_USB_DEVICE;
 		else
 			mode = PHY_MODE_USB_HOST;
@@ -165,13 +210,13 @@ static int rcar_gen3_phy_phy_set_mode(struct phy *phy, enum phy_mode mode,
 		clrbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
 		setbits_le32(priv->regs + USB2_LINECTRL1,
 			     USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
-		setbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
+		rcar_gen3_phy_set_vbus(phy, true);
 	} else if (mode == PHY_MODE_USB_DEVICE) {
 		setbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
 		clrsetbits_le32(priv->regs + USB2_LINECTRL1,
 				USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD,
 				USB2_LINECTRL1_DM_RPD);
-		clrbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
+		rcar_gen3_phy_set_vbus(phy, false);
 	} else {
 		dev_err(phy->dev, "Unknown mode %d\n", mode);
 		return -EINVAL;
@@ -226,7 +271,13 @@ static int rcar_gen3_phy_remove(struct udevice *dev)
 }
 
 static const struct udevice_id rcar_gen3_phy_of_match[] = {
-	{ .compatible = "renesas,rcar-gen3-usb2-phy", },
+	{
+		.compatible = "renesas,rcar-gen3-usb2-phy",
+	},
+	{
+		.compatible = "renesas,rzg2l-usb2-phy",
+		.data = RCAR_GEN3_PHY_NO_ADPCTRL,
+	},
 	{ },
 };
 
-- 
2.43.0

