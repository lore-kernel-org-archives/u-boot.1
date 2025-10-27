Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB6ECCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FE283959;
	Mon, 27 Oct 2025 17:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wFknlY3k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vh/pgWsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5C183959; Mon, 27 Oct 2025 17:47:09 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AB4838FA
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwKDB5nZHz9spj;
 Mon, 27 Oct 2025 17:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kp1v/+6s1PSTYAmym969I2unkXiYrGOTyZyL801oki4=;
 b=wFknlY3kZghnqkBEX6udoXFdlHhiVlQj6pJ1GCzDo0etNagFyDV0D2D5vOzEPYpWnOT0Bp
 Tp8F03NrQCZNkv8tpfoxh8wzFmLrp+ZmxgAbM1Hgf5DIJ8InWI4BXbmH8rblAsDgBCygbZ
 EvThcVmdRQ4PPr6LrPkHryrSy2BbIlZUPeM2Oh+jmDdJt8FeTptwNU3SkYBdB7J34ZfM93
 Pfrase9fccY9qqZiXW3gQ7lyTf0O5tYKLSM70V/lUovR7BCtPiM6CS7idA5we8s0ND0+Y/
 Xo9R6k+V2TKyDNDB3wgVBaNIv7DsF4oBMkSRfMA2pcpjhObPC9wexYIBGbL32g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Vh/pgWsT";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kp1v/+6s1PSTYAmym969I2unkXiYrGOTyZyL801oki4=;
 b=Vh/pgWsTTHGnxFAbcwPdz6lAW2r5X+dGj7Shp2xLNLhEXKIq1dXqWujbIfkaYOZ/wTB+0s
 thPdcGUfadpKNUAHFQphHDJWCFGrhlsGzjgwF7S6NGZCn/Gx/QTVP04I5llZpJPasv/Yzh
 1H2NbWkVnTcRI48uCqeo7KfnrovPKCi0QXCQGpPyenf+WOoBi4IEfvJgqcKb7j5aRMOrFU
 5X12qFkVOadClb1flO8MRowiGABOZh9w6XX9EcIgTAjYNKXwvfBTBQoHl7zGCrcLDQAAqj
 xYC0ac5QxquI/VLpslQUOVeO9vZHmvheYZJHTdMOoha3dLlTSHBtDIp3Avqzpw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/12] net: rswitch: Parametize COMA, ETHA, GWCA offsets
Date: Mon, 27 Oct 2025 17:45:36 +0100
Message-ID: <20251027164643.12443-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ypg9oc9s8nqe5bbmu7pxuxnxpt6epaza
X-MBO-RS-ID: 377c6e3dd675bb83482
X-Rspamd-Queue-Id: 4cwKDB5nZHz9spj
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

The COMA, ETHA, GWCA offsets differ across variants of this IP in
R-Car S4 and R-Car X5H. Parametrize these offsets in preparation
for R-Car X5H addition into this driver. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 54 ++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index b4e84ccaa41..c568b0bedd6 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -33,14 +33,11 @@
 #define RSWITCH_MAX_CTAG_PCP	7
 
 /* Registers */
-#define RSWITCH_COMA_OFFSET	0x00009000
-#define RSWITCH_ETHA_OFFSET	0x0000a000	/* with RMAC */
 #define RSWITCH_ETHA_SIZE	0x00002000	/* with RMAC */
-#define RSWITCH_GWCA_OFFSET	0x00010000
 #define RSWITCH_GWCA_SIZE	0x00002000
 
 #define FWRO			0
-#define CARO			RSWITCH_COMA_OFFSET
+#define CARO			0
 #define GWRO			0
 #define TARO			0
 #define RMRO			0x1000
@@ -265,6 +262,7 @@ struct rswitch_rxdesc {
 
 struct rswitch_port_priv {
 	void __iomem		*addr;
+	struct rswitch_drv_data	*drv_data;
 	struct phy		serdes;
 	struct rswitch_etha	etha;
 	struct rswitch_gwca	gwca;
@@ -280,6 +278,12 @@ struct rswitch_priv {
 	struct clk_bulk		rsw_clk;
 };
 
+struct rswitch_drv_data {
+	u32			coma_offset;
+	u32			etha_offset;
+	u32			gwca_offset;
+};
+
 static inline void rswitch_flush_dcache(u32 addr, u32 len)
 {
 	flush_dcache_range(addr, addr + len);
@@ -295,14 +299,17 @@ static inline void rswitch_invalidate_dcache(u32 addr, u32 len)
 
 static void rswitch_agent_clock_ctrl(struct rswitch_port_priv *priv, int port, int enable)
 {
+	struct rswitch_drv_data *drv_data = priv->drv_data;
 	u32 val;
 
 	if (enable) {
-		val = readl(priv->addr + RCEC);
-		if ((val & (RCEC_RCE | BIT(port))) != (RCEC_RCE | BIT(port)))
-			writel(val | RCEC_RCE | BIT(port), priv->addr + RCEC);
+		val = readl(priv->addr + drv_data->coma_offset + RCEC);
+		if ((val & (RCEC_RCE | BIT(port))) != (RCEC_RCE | BIT(port))) {
+			writel(val | RCEC_RCE | BIT(port),
+			       priv->addr + drv_data->coma_offset + RCEC);
+		}
 	} else {
-		setbits_le32(priv->addr + RCDC, BIT(port));
+		setbits_le32(priv->addr + drv_data->coma_offset + RCDC, BIT(port));
 	}
 }
 
@@ -537,10 +544,11 @@ static int rswitch_check_link(struct rswitch_etha_io *etha_serdes)
 
 static int rswitch_reset(struct rswitch_port_priv *priv)
 {
+	struct rswitch_drv_data *drv_data = priv->drv_data;
 	int ret;
 
-	setbits_le32(priv->addr + RRC, RRC_RR);
-	clrbits_le32(priv->addr + RRC, RRC_RR);
+	setbits_le32(priv->addr + drv_data->coma_offset + RRC, RRC_RR);
+	clrbits_le32(priv->addr + drv_data->coma_offset + RRC, RRC_RR);
 
 	ret = rswitch_gwca_change_mode(priv, GWMC_OPC_DISABLE);
 	if (ret)
@@ -641,21 +649,24 @@ static void rswitch_rx_desc_init(struct rswitch_port_priv *priv)
 
 static void rswitch_clock_enable(struct rswitch_port_priv *priv)
 {
+	struct rswitch_drv_data *drv_data = priv->drv_data;
 	struct rswitch_etha *etha = &priv->etha;
 	struct rswitch_gwca *gwca = &priv->gwca;
 	int etha_index = etha->serdes.index;
 
-	setbits_le32(priv->addr + RCEC, BIT(etha_index) | BIT(gwca->index) | RCEC_RCE);
+	setbits_le32(priv->addr + drv_data->coma_offset + RCEC,
+		     BIT(etha_index) | BIT(gwca->index) | RCEC_RCE);
 }
 
 static int rswitch_bpool_init(struct rswitch_port_priv *priv)
 {
+	struct rswitch_drv_data *drv_data = priv->drv_data;
 	u32 pval;
 
-	writel(CABPIRM_BPIOG, priv->addr + CABPIRM);
+	writel(CABPIRM_BPIOG, priv->addr + drv_data->coma_offset + CABPIRM);
 
-	return readl_poll_sleep_timeout(priv->addr + CABPIRM, pval,
-					pval & CABPIRM_BPR,
+	return readl_poll_sleep_timeout(priv->addr + drv_data->coma_offset + CABPIRM,
+					pval, pval & CABPIRM_BPR,
 					RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 }
 
@@ -1013,6 +1024,7 @@ static int rswitch_port_probe(struct udevice *dev)
 	int ret;
 
 	priv->addr = rpriv->addr;
+	priv->drv_data = (void *)dev_get_driver_data(dev->parent);
 
 	ret = generic_phy_get_by_index(dev, 0, &priv->serdes);
 	if (ret)
@@ -1022,13 +1034,13 @@ static int rswitch_port_probe(struct udevice *dev)
 
 	etha->mii.index = dev_read_u32_default(dev, "reg", 0);
 	etha->serdes.index = priv->serdes.id;
-	etha->mii.addr = priv->addr + RSWITCH_ETHA_OFFSET +
+	etha->mii.addr = priv->addr + priv->drv_data->etha_offset +
 			 etha->mii.index * RSWITCH_ETHA_SIZE;
-	etha->serdes.addr = priv->addr + RSWITCH_ETHA_OFFSET +
+	etha->serdes.addr = priv->addr + priv->drv_data->etha_offset +
 			    etha->serdes.index * RSWITCH_ETHA_SIZE;
 
 	gwca->index = 1;
-	gwca->addr = priv->addr + RSWITCH_GWCA_OFFSET + gwca->index * RSWITCH_GWCA_SIZE;
+	gwca->addr = priv->addr + priv->drv_data->gwca_offset + gwca->index * RSWITCH_GWCA_SIZE;
 	gwca->index = GWCA_TO_HW_INDEX(gwca->index);
 
 	/* Toggle the reset so we can access the PHYs */
@@ -1176,8 +1188,14 @@ static int rswitch_bind(struct udevice *parent)
 	return 0;
 }
 
+static const struct rswitch_drv_data r8a779f0_drv_data = {
+	.coma_offset	= 0x9000,
+	.etha_offset	= 0xa000,
+	.gwca_offset	= 0x10000,
+};
+
 static const struct udevice_id rswitch_ids[] = {
-	{ .compatible = "renesas,r8a779f0-ether-switch" },
+	{ .compatible = "renesas,r8a779f0-ether-switch", .data = (ulong)&r8a779f0_drv_data },
 	{ }
 };
 
-- 
2.51.0

