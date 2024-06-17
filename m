Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0EAC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161E6883BB;
	Mon, 17 Jun 2024 19:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tFpEVOYz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uPDN9ofV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301ED883B6; Mon, 17 Jun 2024 19:38:08 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042CF8811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W2xtP5414z9sck;
 Mon, 17 Jun 2024 19:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718645885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Usdz/gIAoFcmuX7FqaBJNor+WDkJ4HoDhGwmvGbCf/U=;
 b=tFpEVOYzwD+QTEMyeAirEJLuO3QD8LVRSK9540ZXTkOhGwyngu3pbwhmwLHXdMYf7gKgJ6
 8dQ9nYExBqGtbPv7KKWiICumqs0C5IYRKimSfmcAmQDU0OYha2jm+w6l+Z2yAmFRKzoXif
 qM9eUJPBwZ7gL8TWZ5hZcDr909xHzGNDPqQvq5qjgFfoWdU5mmoiQ5KdwDM4lUgKP5Bvz1
 zrXFSgDxvMAcx/NbIkCOUGG1QgMcRl7UHpUvstwLjEZAjTdbZ7B/y7kh7AJzz/yMiYxZBt
 8DwK+aqeLj7fRWeuMZEJijD559WkommdmYw0OAe44Bwb1wvDwvHAS5trU1kJUw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718645883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Usdz/gIAoFcmuX7FqaBJNor+WDkJ4HoDhGwmvGbCf/U=;
 b=uPDN9ofVc4u99ou5HU8TOHjyOYUkWeYt6+DS+Eik2BEovHveQlxwMYPBpbKe3DGafxmrfY
 5phGbQfQNaDrYHSOrvjX3LDuDIbmtYD7qncLErDON5fDGIU0n3WNXnfYTm9hify8ZJSSTp
 VekpjBX+z5brC00n9OXciTLm5zu8CXnkG++d/7MYYtscni+2qKaGKAq7gwSh9sCnDVPuJv
 vRDp8eImjp0dawhfoxSSWzRhk2W+0tUvZjo5G/M9w5qc47aqC6oHyNjZIPAuWaOivyi55m
 vWSIZbX0W5cqE3wMY6QgmVyYblFVE5NjtEjXxdZGBusTmLLGIRWwwm4TKnN77g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 u-boot-qcom@groups.io
Subject: [PATCH v2 2/3] phy: rcar: Split init and set_mode operations
Date: Mon, 17 Jun 2024 19:36:04 +0200
Message-ID: <20240617173740.80822-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
References: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4c3f091174a3fc77ed5
X-MBO-RS-META: 87i9iwz3sit1ok4ahxoua3pctps7z9xj
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

The current init operation also sets the PHY into USB host mode.
Split the mode configuration into set_mode callback instead and
implement support for device and OTG modes as well.

The OTG mode performs auto-detection and selects either host or
device mode. In case the OTG mode is configured, submode field
can be used to select full PHY (re)initialization or only mode
auto-detection. The full (re)initialization is only necessary
once, on start up.

Since the OTG mode may enable IRQ generation in the PHY, disable
that IRQ generation in the exit callback again.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
V2: No change
---
 drivers/phy/phy-rcar-gen3.c | 90 ++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index 7c292cae0e2..b278f995f37 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -8,6 +8,7 @@
 #include <clk.h>
 #include <div64.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <fdtdec.h>
 #include <generic-phy.h>
 #include <malloc.h>
@@ -31,8 +32,13 @@
 #define USB2_LINECTRL1		0x610
 #define USB2_ADPCTRL		0x630
 
+/* INT_ENABLE */
+#define USB2_INT_ENABLE_UCOM_INTEN	BIT(3)
+#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
+#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)
+
 /* USBCTR */
-#define USB2_USBCTR_PLL_RST	BIT(1)
+#define USB2_USBCTR_PLL_RST		BIT(1)
 
 /* SPD_RSM_TIMSET */
 #define USB2_SPD_RSM_TIMSET_INIT	0x014e029b
@@ -43,11 +49,23 @@
 /* COMMCTRL */
 #define USB2_COMMCTRL_OTG_PERI		BIT(31)	/* 1 = Peripheral mode */
 
+/* OBINTSTA and OBINTEN */
+#define USB2_OBINT_SESSVLDCHG		BIT(12)
+#define USB2_OBINT_IDDIGCHG		BIT(11)
+
+/* VBCTRL */
+#define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
+
 /* LINECTRL1 */
+#define USB2_LINECTRL1_DPRPD_EN		BIT(19)
 #define USB2_LINECTRL1_DP_RPD		BIT(18)
+#define USB2_LINECTRL1_DMRPD_EN		BIT(17)
 #define USB2_LINECTRL1_DM_RPD		BIT(16)
 
 /* ADPCTRL */
+#define USB2_ADPCTRL_OTGSESSVLD		BIT(20)
+#define USB2_ADPCTRL_IDDIG		BIT(19)
+#define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
 #define USB2_ADPCTRL_DRVVBUS		BIT(4)
 
 struct rcar_gen3_phy {
@@ -65,12 +83,14 @@ static int rcar_gen3_phy_phy_init(struct phy *phy)
 	writel(USB2_SPD_RSM_TIMSET_INIT, priv->regs + USB2_SPD_RSM_TIMSET);
 	writel(USB2_OC_TIMSET_INIT, priv->regs + USB2_OC_TIMSET);
 
-	setbits_le32(priv->regs + USB2_LINECTRL1,
-		     USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
+	return 0;
+}
 
-	clrbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
+static int rcar_gen3_phy_phy_exit(struct phy *phy)
+{
+	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
 
-	setbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
+	writel(0, priv->regs + USB2_INT_ENABLE);
 
 	return 0;
 }
@@ -102,10 +122,70 @@ static int rcar_gen3_phy_phy_power_off(struct phy *phy)
 	return regulator_set_enable(priv->vbus_supply, false);
 }
 
+static int rcar_gen3_phy_phy_set_mode(struct phy *phy, enum phy_mode mode,
+				      int submode)
+{
+	const u32 adpdevmask = USB2_ADPCTRL_IDDIG | USB2_ADPCTRL_OTGSESSVLD;
+	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
+	u32 adpctrl;
+
+	if (mode == PHY_MODE_USB_OTG) {
+		if (submode) {
+			/* OTG submode is used as initialization indicator */
+			writel(USB2_INT_ENABLE_UCOM_INTEN |
+			       USB2_INT_ENABLE_USBH_INTB_EN |
+			       USB2_INT_ENABLE_USBH_INTA_EN,
+			       priv->regs + USB2_INT_ENABLE);
+			setbits_le32(priv->regs + USB2_VBCTRL,
+				     USB2_VBCTRL_DRVVBUSSEL);
+			writel(USB2_OBINT_SESSVLDCHG | USB2_OBINT_IDDIGCHG,
+			       priv->regs + USB2_OBINTSTA);
+			setbits_le32(priv->regs + USB2_OBINTEN,
+				     USB2_OBINT_SESSVLDCHG |
+				     USB2_OBINT_IDDIGCHG);
+			setbits_le32(priv->regs + USB2_ADPCTRL,
+				     USB2_ADPCTRL_IDPULLUP);
+			clrsetbits_le32(priv->regs + USB2_LINECTRL1,
+					USB2_LINECTRL1_DP_RPD |
+					USB2_LINECTRL1_DM_RPD |
+					USB2_LINECTRL1_DPRPD_EN |
+					USB2_LINECTRL1_DMRPD_EN,
+					USB2_LINECTRL1_DPRPD_EN |
+					USB2_LINECTRL1_DMRPD_EN);
+		}
+
+		adpctrl = readl(priv->regs + USB2_ADPCTRL);
+		if ((adpctrl & adpdevmask) == adpdevmask)
+			mode = PHY_MODE_USB_DEVICE;
+		else
+			mode = PHY_MODE_USB_HOST;
+	}
+
+	if (mode == PHY_MODE_USB_HOST) {
+		clrbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
+		setbits_le32(priv->regs + USB2_LINECTRL1,
+			     USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
+		setbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
+	} else if (mode == PHY_MODE_USB_DEVICE) {
+		setbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
+		clrsetbits_le32(priv->regs + USB2_LINECTRL1,
+				USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD,
+				USB2_LINECTRL1_DM_RPD);
+		clrbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
+	} else {
+		dev_err(phy->dev, "Unknown mode %d\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct phy_ops rcar_gen3_phy_phy_ops = {
 	.init		= rcar_gen3_phy_phy_init,
+	.exit		= rcar_gen3_phy_phy_exit,
 	.power_on	= rcar_gen3_phy_phy_power_on,
 	.power_off	= rcar_gen3_phy_phy_power_off,
+	.set_mode	= rcar_gen3_phy_phy_set_mode,
 };
 
 static int rcar_gen3_phy_probe(struct udevice *dev)
-- 
2.43.0

