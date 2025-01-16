Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EDBC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F9580775;
	Thu, 16 Jan 2025 05:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000348;
	bh=q5z3GanD5Zh05MWAtOUMgedlALl3N/6tWyul7SKyQYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFiR0rJY7/B+G0w+7dolq7q0RDeFqd2gL1rnOVfNKcZqUTQJPt1ukMwgpfblc10Eb
	 cJ42h4HRNT/Cz8UGr0/o5f7rx/KBdC0ffZ6Tfk4zKCpBRmLk/HVNq43RRaSGzHfyZM
	 3rvGppGmsKDDgdlG/un36pUHNm2VLozJ8GwajRqkeGJSkrTz/xW4h/Yn/A5Vw2vY/t
	 I3jcVva8Vkr6GfI4/ojadGkvTOuMKiBZ2AeWqnCZass0Yg6ZwjEPVVLmAT7RHO8mUA
	 Ye+cRx5YNrxuWOC+D7yWg7cv4I+8KAMClaVcDUcG3F0RMmW86rddUr4SMVRgD1F8n6
	 nNI9NDNIME8VA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6A7806D4; Thu, 16 Jan 2025 05:05:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C1D80748
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Qkb+K80P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BDE59109403D9; Thu, 16 Jan 2025 05:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5z3GanD5Zh05MWAtOUMgedlALl3N/6tWyul7SKyQYk=;
 b=Qkb+K80PwkhA0yUt/xFWBWltIkPaAZu8IsIzRiZJps6LXNuwH4e5XNxXuQyIJjT5k7EdtD
 Fbs0wEx1pUWAaSIG1Y/i0uqfUzpgN0gdcjb+t8NpQwt0MZhucOWKW7ohHKQ0Uh1saoCe6B
 5QHO3jvbyJV4wQ+3+hjPtGq81HAnLl+6z+TpU7SfSKt0gg1A2zugwopaXqIOfbf5o07yqU
 mq9eCy7d9gY7HKU+eOsu2ZP6imriDno2agAqlGwOUg8AZAD/4uggBsgPs/d0uzAlJGw6AE
 2EV8GH9mNKIT2oMml8maY7NFGJYkEC+8PPTAIJ6IzhUbvAc2jRGee7R8U4ojzw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 08/13] net: fsl_enetc: Split register accessors
Date: Thu, 16 Jan 2025 05:03:25 +0100
Message-ID: <20250116040449.306098-8-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
References: <20250116040449.306098-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Split register accessors to the port base/station interface/port/mac
registers as those are at different offsets on different SoCs. This
is a preparatory patch which will allow addition of adjusted offsets
for new SoCs easily.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c | 68 +++++++++++++++++++++++++++++++----------
 drivers/net/fsl_enetc.h | 25 +++++++++------
 2 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index ace1069efd9..532a367c241 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -56,14 +56,52 @@ static void enetc_write(struct enetc_priv *priv, u32 off, u32 val)
 	enetc_write_reg(priv->regs_base + off, val);
 }
 
+/* base port register accessors */
+static void enetc_write_pmr(struct enetc_priv *priv, u32 val)
+{
+	const u32 off = ENETC_PMR + ENETC_PMR_OFFSET_LS;
+
+	enetc_write_reg(priv->port_regs + off, val);
+}
+
+static void enetc_write_psipmar(struct enetc_priv *priv, int n, u32 val)
+{
+	const u32 off = (n ? ENETC_PSIPMAR1 : ENETC_PSIPMAR0) +
+			ENETC_PSIPMARn_OFFSET_LS;
+
+	enetc_write_reg(priv->port_regs + off, val);
+}
+
+/* port station register accessors */
+static void enetc_write_psicfgr(struct enetc_priv *priv, int port, u32 val)
+{
+	const u32 off = ENETC_PSICFGR(port, ENETC_PSICFGR_SHIFT_LS) +
+			ENETC_PSICFGR_OFFSET_LS;
+
+	enetc_write_reg(priv->port_regs + off, val);
+}
+
 /* port register accessors */
-static u32 enetc_read_port(struct enetc_priv *priv, u32 off)
+static u32 enetc_read_pcapr_mdio(struct enetc_priv *priv)
+{
+	const u32 off = ENETC_PCAPR0 + ENETC_PCAPR_OFFSET_LS;
+	u32 reg = enetc_read_reg(priv->port_regs + off);
+
+	return reg & ENETC_PCAPRO_MDIO;
+}
+
+/* MAC port register accessors */
+static u32 enetc_read_mac_port(struct enetc_priv *priv, u32 off)
 {
+	off += ENETC_PM_OFFSET_LS;
+
 	return enetc_read_reg(priv->port_regs + off);
 }
 
-static void enetc_write_port(struct enetc_priv *priv, u32 off, u32 val)
+static void enetc_write_mac_port(struct enetc_priv *priv, u32 off, u32 val)
 {
+	off += ENETC_PM_OFFSET_LS;
+
 	enetc_write_reg(priv->port_regs + off, val);
 }
 
@@ -234,7 +272,7 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 	struct enetc_priv *priv = dev_get_priv(dev);
 	u32 old_val, val;
 
-	old_val = val = enetc_read_port(priv, ENETC_PM_IF_MODE);
+	old_val = val = enetc_read_mac_port(priv, ENETC_PM_IF_MODE);
 
 	/* disable unreliable RGMII in-band signaling and force the MAC into
 	 * the speed negotiated by the PHY.
@@ -260,7 +298,7 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 	if (val == old_val)
 		return;
 
-	enetc_write_port(priv, ENETC_PM_IF_MODE, val);
+	enetc_write_mac_port(priv, ENETC_PM_IF_MODE, val);
 }
 
 /* set up MAC configuration for the given interface type */
@@ -280,9 +318,9 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10GBASER:
 		/* set ifmode to (US)XGMII */
-		if_mode = enetc_read_port(priv, ENETC_PM_IF_MODE);
+		if_mode = enetc_read_mac_port(priv, ENETC_PM_IF_MODE);
 		if_mode &= ~ENETC_PM_IF_IFMODE_MASK;
-		enetc_write_port(priv, ENETC_PM_IF_MODE, if_mode);
+		enetc_write_mac_port(priv, ENETC_PM_IF_MODE, if_mode);
 		break;
 	};
 }
@@ -313,7 +351,7 @@ static void enetc_start_pcs(struct udevice *dev)
 	struct enetc_priv *priv = dev_get_priv(dev);
 
 	/* register internal MDIO for debug purposes */
-	if (enetc_read_port(priv, ENETC_PCAPR0) & ENETC_PCAPRO_MDIO) {
+	if (enetc_read_pcapr_mdio(priv)) {
 		priv->imdio.read = enetc_mdio_read;
 		priv->imdio.write = enetc_mdio_write;
 		priv->imdio.priv = priv->port_regs + ENETC_PM_IMDIO_BASE;
@@ -472,8 +510,8 @@ static int enetc_write_hwaddr(struct udevice *dev)
 	u16 lower = *(const u16 *)(addr + 4);
 	u32 upper = *(const u32 *)addr;
 
-	enetc_write_port(priv, ENETC_PSIPMAR0, upper);
-	enetc_write_port(priv, ENETC_PSIPMAR1, lower);
+	enetc_write_psipmar(priv, 0, upper);
+	enetc_write_psipmar(priv, 1, lower);
 
 	return 0;
 }
@@ -482,18 +520,16 @@ static int enetc_write_hwaddr(struct udevice *dev)
 static void enetc_enable_si_port(struct udevice *dev)
 {
 	struct enetc_priv *priv = dev_get_priv(dev);
-	u32 val;
 
 	/* set Rx/Tx BDR count */
-	val = ENETC_PSICFGR_SET_TXBDR(ENETC_TX_BDR_CNT);
-	val |= ENETC_PSICFGR_SET_RXBDR(ENETC_RX_BDR_CNT);
-	enetc_write_port(priv, ENETC_PSICFGR(0), val);
+	enetc_write_psicfgr(priv, 0, ENETC_PSICFGR_SET_BDR(ENETC_RX_BDR_CNT,
+							   ENETC_TX_BDR_CNT));
 	/* set Rx max frame size */
-	enetc_write_port(priv, ENETC_PM_MAXFRM, ENETC_RX_MAXFRM_SIZE);
+	enetc_write_mac_port(priv, ENETC_PM_MAXFRM, ENETC_RX_MAXFRM_SIZE);
 	/* enable MAC port */
-	enetc_write_port(priv, ENETC_PM_CC, ENETC_PM_CC_RX_TX_EN);
+	enetc_write_mac_port(priv, ENETC_PM_CC, ENETC_PM_CC_RX_TX_EN);
 	/* enable port */
-	enetc_write_port(priv, ENETC_PMR, ENETC_PMR_SI0_EN);
+	enetc_write_pmr(priv, ENETC_PMR_SI0_EN);
 	/* set SI cache policy */
 	enetc_write(priv, ENETC_SICAR0,
 		    ENETC_SICAR_RD_CFG | ENETC_SICAR_WR_CFG);
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index da7414cbe99..15408b669b4 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -57,24 +57,29 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PORT_REGS_OFF		0x10000
 
 /* Port registers */
+#define ENETC_PMR_OFFSET_LS		0x0000
 #define ENETC_PMR			0x0000
 #define  ENETC_PMR_SI0_EN		BIT(16)
 #define ENETC_PSIPMMR			0x0018
-#define ENETC_PSIPMAR0			0x0100
-#define ENETC_PSIPMAR1			0x0104
-#define ENETC_PCAPR0			0x0900
+#define ENETC_PSIPMARn_OFFSET_LS	0x0080
+#define ENETC_PSIPMAR0			0x0080
+#define ENETC_PSIPMAR1			0x0084
+#define ENETC_PCAPR_OFFSET_LS		0x0900
+#define ENETC_PCAPR0			0x0000
 #define  ENETC_PCAPRO_MDIO		BIT(11)
-#define ENETC_PSICFGR(n)		(0x0940 + (n) * 0x10)
-#define  ENETC_PSICFGR_SET_TXBDR(val)	((val) & 0xff)
-#define  ENETC_PSICFGR_SET_RXBDR(val)	(((val) & 0xff) << 16)
+#define ENETC_PSICFGR_OFFSET_LS		0x0940
+#define ENETC_PSICFGR_SHIFT_LS		0x10
+#define ENETC_PSICFGR(n, s)		((n) * (s))
+#define  ENETC_PSICFGR_SET_BDR(rx, tx)	(((rx) << 16) | (tx))
 /* MAC configuration */
-#define ENETC_PM_CC			0x8008
+#define ENETC_PM_OFFSET_LS		0x8000
+#define ENETC_PM_CC			0x0008
 #define  ENETC_PM_CC_DEFAULT		0x0810
 #define  ENETC_PM_CC_RX_TX_EN		0x8813
-#define ENETC_PM_MAXFRM			0x8014
+#define ENETC_PM_MAXFRM			0x0014
 #define  ENETC_RX_MAXFRM_SIZE		PKTSIZE_ALIGN
-#define ENETC_PM_IMDIO_BASE		0x8030
-#define ENETC_PM_IF_MODE		0x8300
+#define ENETC_PM_IMDIO_BASE		0x0030
+#define ENETC_PM_IF_MODE		0x0300
 #define  ENETC_PM_IF_MODE_RG		BIT(2)
 #define  ENETC_PM_IF_MODE_AN_ENA	BIT(15)
 #define  ENETC_PM_IFM_SSP_MASK		GENMASK(14, 13)
-- 
2.45.2

