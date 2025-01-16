Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BB2C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A59C580770;
	Thu, 16 Jan 2025 05:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000352;
	bh=jEyfRxUSKj1rsNxt82OncnR2fYm7vHJpBCCeUEARHBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pImaDGwsx5ZbpHKPi2FNkYU4TMmGvJx/rwwJjYwzDjCp+4CVm38wqJuyRQsEepCaW
	 lj4RzI5edCB324FLvpmxBLUbimnvugbdJhhIFOizqfAj48pruo1ZtmmVBupwfHvogs
	 bm/n0Mvovt/Jle+PuE9UiXHsoyaZqKrkKGRATiSRSjJ6sPx8Ha/g9npvr978Gx6ji5
	 DiUnioR+D56InG6vMmxOI2tHIDdggRru626zyM/crGnBCN8JyGJLMcg+Jl2ON81lZL
	 9WoNe/DqTEwsw8+GEd5gkLQVfG07Gckxy9kVd+jcVze74eaptEBKzzuqnLeROX6ndA
	 PTk4G5Rd8OKCA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40C280737; Thu, 16 Jan 2025 05:05:49 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B4E8070C
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KTkZhDED"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9CCBF10945660; Thu, 16 Jan 2025 05:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEyfRxUSKj1rsNxt82OncnR2fYm7vHJpBCCeUEARHBQ=;
 b=KTkZhDEDXEMWkjgVA76XMGGVRLLtYOWJ3Jtu8koELey+mJiEZsVMC3WU28wGySA2Q/VG5/
 oJLMYXt406uHSG6gkLcPjEOK4V/H0VfrOtFVZDelyR9lSIk+XgY5nN1qVt4/sDrL7tQQBp
 0FJTcBeZGeaVSZTQwnQE/eIac27YQQafWt1IhPgOZCls9YM51tbXnrtVxLq0kd6UvqHTvt
 /jmB9KrdbEY7MqLMSN9I3+E1EStZIWfMoetwZJzGL7f4kPMjkSVb5QkuLfVyZMR5pRgYn7
 TIpTfft5Y7o+jJiiOGvnKUNjrvB/Tx9kojWcWUgtFnXO3HAEk0L9C2pW6FvONA==
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
Subject: [PATCH 10/13] net: fsl_enetc: Pass udevice pointer to accessors
Date: Thu, 16 Jan 2025 05:03:27 +0100
Message-ID: <20250116040449.306098-10-marex@denx.de>
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

Pass struct udevice * into the register accessors, so the accessors can reach
driver data, which contain device specific register offsets.

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
 drivers/net/fsl_enetc.c | 64 +++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index c92626a8782..1a348f41ea0 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -57,52 +57,62 @@ static void enetc_write(struct enetc_priv *priv, u32 off, u32 val)
 }
 
 /* base port register accessors */
-static void enetc_write_pmr(struct enetc_priv *priv, u32 val)
+static void enetc_write_pmr(struct udevice *dev, u32 val)
 {
-	const u32 off = ENETC_PMR + ENETC_PMR_OFFSET_LS;
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
+	const u32 off = ENETC_PMR + data->reg_offset_pmr;
 
 	enetc_write_reg(priv->port_regs + off, val);
 }
 
-static void enetc_write_psipmar(struct enetc_priv *priv, int n, u32 val)
+static void enetc_write_psipmar(struct udevice *dev, int n, u32 val)
 {
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
 	const u32 off = (n ? ENETC_PSIPMAR1 : ENETC_PSIPMAR0) +
-			ENETC_PSIPMARn_OFFSET_LS;
+			data->reg_offset_psipmar;
 
 	enetc_write_reg(priv->port_regs + off, val);
 }
 
 /* port station register accessors */
-static void enetc_write_psicfgr(struct enetc_priv *priv, int port, u32 val)
+static void enetc_write_psicfgr(struct udevice *dev, int port, u32 val)
 {
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
 	const u32 off = ENETC_PSICFGR(port, ENETC_PSICFGR_SHIFT_LS) +
-			ENETC_PSICFGR_OFFSET_LS;
+			data->reg_offset_psicfgr;
 
 	enetc_write_reg(priv->port_regs + off, val);
 }
 
 /* port register accessors */
-static u32 enetc_read_pcapr_mdio(struct enetc_priv *priv)
+static u32 enetc_read_pcapr_mdio(struct udevice *dev)
 {
-	const u32 off = ENETC_PCAPR0 + ENETC_PCAPR_OFFSET_LS;
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
+	const u32 off = ENETC_PCAPR0 + data->reg_offset_pcapr;
 	u32 reg = enetc_read_reg(priv->port_regs + off);
 
 	return reg & ENETC_PCAPRO_MDIO;
 }
 
 /* MAC port register accessors */
-static u32 enetc_read_mac_port(struct enetc_priv *priv, u32 off)
+static u32 enetc_read_mac_port(struct udevice *dev, u32 off)
 {
-	off += ENETC_PM_OFFSET_LS;
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
 
-	return enetc_read_reg(priv->port_regs + off);
+	return enetc_read_reg(priv->port_regs + data->reg_offset_mac + off);
 }
 
-static void enetc_write_mac_port(struct enetc_priv *priv, u32 off, u32 val)
+static void enetc_write_mac_port(struct udevice *dev, u32 off, u32 val)
 {
-	off += ENETC_PM_OFFSET_LS;
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
 
-	enetc_write_reg(priv->port_regs + off, val);
+	enetc_write_reg(priv->port_regs + data->reg_offset_mac + off, val);
 }
 
 /* BDR register accessor, see also ENETC_BDR() */
@@ -269,10 +279,9 @@ static int enetc_init_sgmii(struct udevice *dev)
 /* set up MAC for RGMII */
 static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 {
-	struct enetc_priv *priv = dev_get_priv(dev);
 	u32 old_val, val;
 
-	old_val = val = enetc_read_mac_port(priv, ENETC_PM_IF_MODE);
+	old_val = val = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
 
 	/* disable unreliable RGMII in-band signaling and force the MAC into
 	 * the speed negotiated by the PHY.
@@ -298,7 +307,7 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 	if (val == old_val)
 		return;
 
-	enetc_write_mac_port(priv, ENETC_PM_IF_MODE, val);
+	enetc_write_mac_port(dev, ENETC_PM_IF_MODE, val);
 }
 
 /* set up MAC configuration for the given interface type */
@@ -318,9 +327,9 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10GBASER:
 		/* set ifmode to (US)XGMII */
-		if_mode = enetc_read_mac_port(priv, ENETC_PM_IF_MODE);
+		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
 		if_mode &= ~ENETC_PM_IF_IFMODE_MASK;
-		enetc_write_mac_port(priv, ENETC_PM_IF_MODE, if_mode);
+		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
 	};
 }
@@ -351,7 +360,7 @@ static void enetc_start_pcs(struct udevice *dev)
 	struct enetc_priv *priv = dev_get_priv(dev);
 
 	/* register internal MDIO for debug purposes */
-	if (enetc_read_pcapr_mdio(priv)) {
+	if (enetc_read_pcapr_mdio(dev)) {
 		priv->imdio.read = enetc_mdio_read;
 		priv->imdio.write = enetc_mdio_write;
 		priv->imdio.priv = priv->port_regs + ENETC_PM_IMDIO_BASE;
@@ -501,7 +510,6 @@ static int enetc_ls1028a_write_hwaddr(struct udevice *dev)
 static int enetc_write_hwaddr(struct udevice *dev)
 {
 	struct eth_pdata *plat = dev_get_plat(dev);
-	struct enetc_priv *priv = dev_get_priv(dev);
 	u8 *addr = plat->enetaddr;
 
 	if (enetc_is_ls1028a(dev))
@@ -510,8 +518,8 @@ static int enetc_write_hwaddr(struct udevice *dev)
 	u16 lower = *(const u16 *)(addr + 4);
 	u32 upper = *(const u32 *)addr;
 
-	enetc_write_psipmar(priv, 0, upper);
-	enetc_write_psipmar(priv, 1, lower);
+	enetc_write_psipmar(dev, 0, upper);
+	enetc_write_psipmar(dev, 1, lower);
 
 	return 0;
 }
@@ -522,14 +530,14 @@ static void enetc_enable_si_port(struct udevice *dev)
 	struct enetc_priv *priv = dev_get_priv(dev);
 
 	/* set Rx/Tx BDR count */
-	enetc_write_psicfgr(priv, 0, ENETC_PSICFGR_SET_BDR(ENETC_RX_BDR_CNT,
-							   ENETC_TX_BDR_CNT));
+	enetc_write_psicfgr(dev, 0, ENETC_PSICFGR_SET_BDR(ENETC_RX_BDR_CNT,
+							  ENETC_TX_BDR_CNT));
 	/* set Rx max frame size */
-	enetc_write_mac_port(priv, ENETC_PM_MAXFRM, ENETC_RX_MAXFRM_SIZE);
+	enetc_write_mac_port(dev, ENETC_PM_MAXFRM, ENETC_RX_MAXFRM_SIZE);
 	/* enable MAC port */
-	enetc_write_mac_port(priv, ENETC_PM_CC, ENETC_PM_CC_RX_TX_EN);
+	enetc_write_mac_port(dev, ENETC_PM_CC, ENETC_PM_CC_RX_TX_EN);
 	/* enable port */
-	enetc_write_pmr(priv, ENETC_PMR_SI0_EN);
+	enetc_write_pmr(dev, ENETC_PMR_SI0_EN);
 	/* set SI cache policy */
 	enetc_write(priv, ENETC_SICAR0,
 		    ENETC_SICAR_RD_CFG | ENETC_SICAR_WR_CFG);
-- 
2.45.2

