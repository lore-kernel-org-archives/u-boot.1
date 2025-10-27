Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ADCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E020783948;
	Mon, 27 Oct 2025 17:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QbwLYpHI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jkWiDd0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72ADB83956; Mon, 27 Oct 2025 17:47:07 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B8B83923
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKD81N8Tz9tV7;
 Mon, 27 Oct 2025 17:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EGxX5/mckMEKy+pNzuzZ1X/M0M9aIpxcIhXYYeky1A=;
 b=QbwLYpHIKHtRv1sIaHG6kAr2WKPrvXpftLjOaG1XO/vnwZ4yHVDALRhv9RzYattBzs6zNs
 0MCFhh+LILacXOy+PxZeP1O5VRb+EF48WHg6qvukCYnGvM4p/Eodp55WPFALOAYliR0mMS
 Jbd6CoBCcAP6mNHYJSrfNwvI1JSj5ImlEG6Vyas48uhOSlQEGRCs3PT6LyBGcvWftN8ZfE
 HkLHtEOJavr1bfiQKF2dOXEKReRoSqREyeEMhcMj6SGG6B5xvwkloE9AdRjnIJQNvxKVKw
 y6n7gh5erlniI9UF80moQ1HH38E7P4cCx+nCsC/TU6iq9/E4L1hyEx55jHaqwg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jkWiDd0q;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EGxX5/mckMEKy+pNzuzZ1X/M0M9aIpxcIhXYYeky1A=;
 b=jkWiDd0qUVyRO5ZTYLRVptm3zTW0zp7ivwVxoFgG4xpr5P727wJm+S5bFMfg36IW01FYB2
 z48aEsV0qW/LuPqmH+8OdeimLhvOSfFJ+ocVoNdLfFw3A+qR45TCxiXJ2BM5w+ZyzvI9vh
 eLg9K9LHN7jZhRc8h3wGCx0s/8vNibxphHQ9iQVzsrE+KQJJ44NoVNfKoojGblUM9bULN7
 IHvG42p4RUgwO+Ti+omvYWqLaGECuTh2makvaIAugKGIwq+oJ4F6GILF4mf/cwgEEEqrO9
 UlTL/YLrqvV7QlPgb/jnVzZA8gwWKiWo5Gts33kESUgR0Qlk2d65y0IxDmnmMg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] net: rswitch: Add support for split MII and SerDes
Date: Mon, 27 Oct 2025 17:45:35 +0100
Message-ID: <20251027164643.12443-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4676e6c7ed216699c55
X-MBO-RS-META: ooqb89smjwpr8ue4cf6oj9ugzi3qs5pq
X-Rspamd-Queue-Id: 4cwKD81N8Tz9tV7
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

This IP does support operating MII and SerDes via different ports.
Currently, the driver assumes that MII and SerDes are always bound
together on the same port, but this may not be the case. Implement
support for controlling MII and SerDes separately.

While the change is extensive, the gist of the change is to pass
pointer to the selected port registers to MII or SerDes functions,
depending on which port and operations should be done on that port.
Each combined ETHA instance contains both MII and SerDes register
pointers, which may not point to the same port, and passes those
registers to MII and SerDes functions respectively to control the
MII or SerDes of each port.

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
 drivers/net/rswitch.c | 166 +++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 73 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 3048db365db..b4e84ccaa41 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -190,9 +190,14 @@ enum rswitch_gwca_mode {
 #define	GWDCC_DQT		BIT(11)
 #define GWDCC_BALR		BIT(24)
 
-struct rswitch_etha {
+struct rswitch_etha_io {
 	int			index;
 	void __iomem		*addr;
+};
+
+struct rswitch_etha {
+	struct rswitch_etha_io	mii;
+	struct rswitch_etha_io	serdes;
 	struct phy_device	*phydev;
 	struct mii_dev		*bus;
 	unsigned char		*enetaddr;
@@ -302,24 +307,24 @@ static void rswitch_agent_clock_ctrl(struct rswitch_port_priv *priv, int port, i
 }
 
 static int rswitch_etha_change_mode(struct rswitch_port_priv *priv,
+				    struct rswitch_etha_io *etha_io,
 				    enum rswitch_etha_mode mode)
 {
-	struct rswitch_etha *etha = &priv->etha;
 	u32 pval;
 	int ret;
 
 	/* Enable clock */
-	rswitch_agent_clock_ctrl(priv, etha->index, 1);
+	rswitch_agent_clock_ctrl(priv, etha_io->index, 1);
 
-	writel(mode, etha->addr + EAMC);
+	writel(mode, etha_io->addr + EAMC);
 
-	ret = readl_poll_sleep_timeout(etha->addr + EAMS, pval,
+	ret = readl_poll_sleep_timeout(etha_io->addr + EAMS, pval,
 				       (pval & EAMS_OPS_MASK) == mode,
 				       RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 
 	/* Disable clock */
 	if (mode == EAMC_OPC_DISABLE)
-		rswitch_agent_clock_ctrl(priv, etha->index, 0);
+		rswitch_agent_clock_ctrl(priv, etha_io->index, 0);
 
 	return ret;
 }
@@ -347,7 +352,7 @@ static int rswitch_gwca_change_mode(struct rswitch_port_priv *priv,
 	return ret;
 }
 
-static int rswitch_mii_access_c22(struct rswitch_etha *etha, bool read,
+static int rswitch_mii_access_c22(struct rswitch_etha_io *etha_io, bool read,
 				  int phyad, int regad, int data)
 {
 	const u32 pop = read ? MDIO_READ_C22 : MDIO_WRITE_C22;
@@ -355,18 +360,18 @@ static int rswitch_mii_access_c22(struct rswitch_etha *etha, bool read,
 	int ret;
 
 	/* Clear Station Management Mode : Clause 22 */
-	clrbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
+	clrbits_le32(etha_io->addr + MPSM, MPSM_MFF_C45);
 
 	/* Clear completion flags */
-	writel(MMIS1_CLEAR_FLAGS, etha->addr + MMIS1);
+	writel(MMIS1_CLEAR_FLAGS, etha_io->addr + MMIS1);
 
 	/* Submit C22 access to PHY */
 	val = MPSM_PSME | (pop << 13) | (regad << 8) | (phyad << 3);
 	if (!read)
 		val |= data << 16;
-	writel(val, etha->addr + MPSM);
+	writel(val, etha_io->addr + MPSM);
 
-	ret = readl_poll_sleep_timeout(etha->addr + MPSM, pval,
+	ret = readl_poll_sleep_timeout(etha_io->addr + MPSM, pval,
 				       !(pval & MPSM_PSME),
 				       RSWITCH_SLEEP_US,
 				       RSWITCH_TIMEOUT_US);
@@ -377,45 +382,45 @@ static int rswitch_mii_access_c22(struct rswitch_etha *etha, bool read,
 		return 0;
 
 	/* Read data */
-	ret = (readl(etha->addr + MPSM) & MPSM_PRD_MASK) >> 16;
+	ret = (readl(etha_io->addr + MPSM) & MPSM_PRD_MASK) >> 16;
 
 	/* Clear read completion flag */
-	setbits_le32(etha->addr + MMIS1, MMIS1_PRACS);
+	setbits_le32(etha_io->addr + MMIS1, MMIS1_PRACS);
 
 	return ret;
 }
 
-static int rswitch_mii_access_c45(struct rswitch_etha *etha, bool read,
+static int rswitch_mii_access_c45(struct rswitch_etha_io *etha_io, bool read,
 				  int phyad, int devad, int regad, int data)
 {
 	u32 pval, val;
 	int ret;
 
 	/* Set Station Management Mode : Clause 45 */
-	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
+	setbits_le32(etha_io->addr + MPSM, MPSM_MFF_C45);
 
 	/* Clear completion flags */
-	writel(MMIS1_CLEAR_FLAGS, etha->addr + MMIS1);
+	writel(MMIS1_CLEAR_FLAGS, etha_io->addr + MMIS1);
 
 	/* Submit address to PHY (MDIO_ADDR_C45 << 13) */
 	val = MPSM_PSME | MPSM_MFF_C45 | (devad << 8) | (phyad << 3);
-	writel((regad << 16) | val, etha->addr + MPSM);
+	writel((regad << 16) | val, etha_io->addr + MPSM);
 
-	ret = readl_poll_sleep_timeout(etha->addr + MMIS1, pval,
+	ret = readl_poll_sleep_timeout(etha_io->addr + MMIS1, pval,
 				       pval & MMIS1_PAACS,
 				       RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 	if (ret)
 		return ret;
 
 	/* Clear address completion flag */
-	setbits_le32(etha->addr + MMIS1, MMIS1_PAACS);
+	setbits_le32(etha_io->addr + MMIS1, MMIS1_PAACS);
 
 	/* Read/Write PHY register */
 	if (read) {
 		val |= MDIO_READ_C45 << 13;
-		writel(val, etha->addr + MPSM);
+		writel(val, etha_io->addr + MPSM);
 
-		ret = readl_poll_sleep_timeout(etha->addr + MMIS1, pval,
+		ret = readl_poll_sleep_timeout(etha_io->addr + MMIS1, pval,
 					       pval & MMIS1_PRACS,
 					       RSWITCH_SLEEP_US,
 					       RSWITCH_TIMEOUT_US);
@@ -423,16 +428,16 @@ static int rswitch_mii_access_c45(struct rswitch_etha *etha, bool read,
 			return ret;
 
 		/* Read data */
-		ret = (readl(etha->addr + MPSM) & MPSM_PRD_MASK) >> 16;
+		ret = (readl(etha_io->addr + MPSM) & MPSM_PRD_MASK) >> 16;
 
 		/* Clear read completion flag */
-		setbits_le32(etha->addr + MMIS1, MMIS1_PRACS);
+		setbits_le32(etha_io->addr + MMIS1, MMIS1_PRACS);
 	} else {
 		val |= MDIO_WRITE_C45 << 13;
 		val |= data << 16;
-		writel(val, etha->addr + MPSM);
+		writel(val, etha_io->addr + MPSM);
 
-		ret = readl_poll_sleep_timeout(etha->addr + MMIS1, pval,
+		ret = readl_poll_sleep_timeout(etha_io->addr + MMIS1, pval,
 					       pval & MMIS1_PWACS,
 					       RSWITCH_SLEEP_US,
 					       RSWITCH_TIMEOUT_US);
@@ -445,32 +450,33 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 {
 	struct rswitch_port_priv *priv = miidev->priv;
 	struct rswitch_etha *etha = &priv->etha;
+	struct rswitch_etha_io *etha_mii = &etha->mii;
 	int val;
 
 	/* Change to disable mode */
-	rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
+	rswitch_etha_change_mode(priv, etha_mii, EAMC_OPC_DISABLE);
 
 	/* Change to config mode */
-	rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
+	rswitch_etha_change_mode(priv, etha_mii, EAMC_OPC_CONFIG);
 
 	/* Enable Station Management clock */
-	clrsetbits_le32(etha->addr + MPIC,
+	clrsetbits_le32(etha_mii->addr + MPIC,
 			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 			MPIC_MDC_CLK_SET);
 
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
-		val = rswitch_mii_access_c45(etha, true, phyad, devad, regad, 0);
+		val = rswitch_mii_access_c45(etha_mii, true, phyad, devad, regad, 0);
 	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
-		val = rswitch_mii_access_c45(etha, true, phyad, 1, regad, 0);
+		val = rswitch_mii_access_c45(etha_mii, true, phyad, 1, regad, 0);
 	else
-		val = rswitch_mii_access_c22(etha, true, phyad, regad, 0);
+		val = rswitch_mii_access_c22(etha_mii, true, phyad, regad, 0);
 
 	/* Disable Station Management Clock */
-	clrbits_le32(etha->addr + MPIC, MPIC_PSMCS_MASK);
+	clrbits_le32(etha_mii->addr + MPIC, MPIC_PSMCS_MASK);
 
 	/* Change to disable mode */
-	rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
+	rswitch_etha_change_mode(priv, etha_mii, EAMC_OPC_DISABLE);
 
 	return val;
 }
@@ -479,45 +485,46 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 {
 	struct rswitch_port_priv *priv = miidev->priv;
 	struct rswitch_etha *etha = &priv->etha;
+	struct rswitch_etha_io *etha_mii = &etha->mii;
 
 	/* Change to disable mode */
-	rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
+	rswitch_etha_change_mode(priv, etha_mii, EAMC_OPC_DISABLE);
 
 	/* Change to config mode */
-	rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
+	rswitch_etha_change_mode(priv, etha_mii, EAMC_OPC_CONFIG);
 
 	/* Enable Station Management clock */
-	clrsetbits_le32(etha->addr + MPIC,
+	clrsetbits_le32(etha_mii->addr + MPIC,
 			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 			MPIC_MDC_CLK_SET);
 
 	/* Access PHY register */
 	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
-		rswitch_mii_access_c45(etha, false, phyad, devad, regad, data);
+		rswitch_mii_access_c45(etha_mii, false, phyad, devad, regad, data);
 	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
-		rswitch_mii_access_c45(etha, false, phyad, 1, regad, data);
+		rswitch_mii_access_c45(etha_mii, false, phyad, 1, regad, data);
 	else
-		rswitch_mii_access_c22(etha, false, phyad, regad, data);
+		rswitch_mii_access_c22(etha_mii, false, phyad, regad, data);
 
 	/* Disable Station Management Clock */
-	clrbits_le32(etha->addr + MPIC, MPIC_PSMCS_MASK);
+	clrbits_le32(etha_mii->addr + MPIC, MPIC_PSMCS_MASK);
 
 	/* Change to disable mode */
-	rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
+	rswitch_etha_change_mode(priv, etha_mii, EAMC_OPC_DISABLE);
 
 	return 0;
 }
 
-static int rswitch_check_link(struct rswitch_etha *etha)
+static int rswitch_check_link(struct rswitch_etha_io *etha_serdes)
 {
 	u32 pval;
 	int ret;
 
 	/* Request Link Verification */
-	writel(MLVC_PLV, etha->addr + MLVC);
+	writel(MLVC_PLV, etha_serdes->addr + MLVC);
 
 	/* Complete Link Verification */
-	ret = readl_poll_sleep_timeout(etha->addr + MLVC, pval,
+	ret = readl_poll_sleep_timeout(etha_serdes->addr + MLVC, pval,
 				       !(pval & MLVC_PLV),
 				       RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 	if (ret) {
@@ -539,7 +546,11 @@ static int rswitch_reset(struct rswitch_port_priv *priv)
 	if (ret)
 		return ret;
 
-	ret = rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
+	ret = rswitch_etha_change_mode(priv, &priv->etha.serdes, EAMC_OPC_DISABLE);
+	if (ret)
+		return ret;
+
+	ret = rswitch_etha_change_mode(priv, &priv->etha.mii, EAMC_OPC_DISABLE);
 	if (ret)
 		return ret;
 
@@ -632,8 +643,9 @@ static void rswitch_clock_enable(struct rswitch_port_priv *priv)
 {
 	struct rswitch_etha *etha = &priv->etha;
 	struct rswitch_gwca *gwca = &priv->gwca;
+	int etha_index = etha->serdes.index;
 
-	setbits_le32(priv->addr + RCEC, BIT(etha->index) | BIT(gwca->index) | RCEC_RCE);
+	setbits_le32(priv->addr + RCEC, BIT(etha_index) | BIT(gwca->index) | RCEC_RCE);
 }
 
 static int rswitch_bpool_init(struct rswitch_port_priv *priv)
@@ -651,34 +663,36 @@ static void rswitch_mfwd_init(struct rswitch_port_priv *priv)
 {
 	struct rswitch_etha *etha = &priv->etha;
 	struct rswitch_gwca *gwca = &priv->gwca;
+	int etha_index = etha->serdes.index;
 
-	writel(FWPC0_DEFAULT, priv->addr + FWPC0(etha->index));
+	writel(FWPC0_DEFAULT, priv->addr + FWPC0(etha_index));
 	writel(FWPC0_DEFAULT, priv->addr + FWPC0(gwca->index));
 
 	writel(RSWITCH_RX_CHAIN_INDEX,
-	       priv->addr + FWPBFCSDC(HW_INDEX_TO_GWCA(gwca->index), etha->index));
+	       priv->addr + FWPBFCSDC(HW_INDEX_TO_GWCA(gwca->index), etha_index));
 
 	writel(BIT(gwca->index),
-	       priv->addr + FWPBFC(etha->index));
+	       priv->addr + FWPBFC(etha_index));
 
-	writel(BIT(etha->index),
+	writel(BIT(etha_index),
 	       priv->addr + FWPBFC(gwca->index));
 }
 
 static void rswitch_rmac_init(struct rswitch_etha *etha)
 {
+	struct rswitch_etha_io *etha_serdes = &etha->serdes;
 	unsigned char *mac = etha->enetaddr;
 
 	/* Set MAC address */
-	writel((mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5],
-	       etha->addr + MRMAC1);
+	writel((mac[0] << 8) | mac[1], etha_serdes->addr + MRMAC0);
 
-	writel((mac[0] << 8) | mac[1], etha->addr + MRMAC0);
+	writel((mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5],
+	       etha_serdes->addr + MRMAC1);
 
 	/* Set MIIx */
-	writel(MPIC_PIS_GMII | MPIC_LSC_1000, etha->addr + MPIC);
+	writel(MPIC_PIS_GMII | MPIC_LSC_1000, etha_serdes->addr + MPIC);
 
-	writel(0x07E707E7, etha->addr + MRAFC);
+	writel(0x07E707E7, etha_serdes->addr + MRAFC);
 }
 
 static int rswitch_gwca_mcast_table_reset(struct rswitch_gwca *gwca)
@@ -743,13 +757,13 @@ static int rswitch_gwca_init(struct rswitch_port_priv *priv)
 	return 0;
 }
 
-static int rswitch_etha_tas_ram_reset(struct rswitch_etha *etha)
+static int rswitch_etha_tas_ram_reset(struct rswitch_etha_io *etha_serdes)
 {
 	u32 pval;
 
-	writel(EATASRIRM_TASRIOG, etha->addr + EATASRIRM);
+	writel(EATASRIRM_TASRIOG, etha_serdes->addr + EATASRIRM);
 
-	return readl_poll_sleep_timeout(etha->addr + EATASRIRM, pval,
+	return readl_poll_sleep_timeout(etha_serdes->addr + EATASRIRM, pval,
 					pval & EATASRIRM_TASRR,
 					RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 }
@@ -757,35 +771,36 @@ static int rswitch_etha_tas_ram_reset(struct rswitch_etha *etha)
 static int rswitch_etha_init(struct rswitch_port_priv *priv)
 {
 	struct rswitch_etha *etha = &priv->etha;
+	struct rswitch_etha_io *etha_serdes = &etha->serdes;
 	int ret;
 	u32 prio;
 
-	ret = rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
+	ret = rswitch_etha_change_mode(priv, etha_serdes, EAMC_OPC_DISABLE);
 	if (ret)
 		return ret;
 
-	ret = rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
+	ret = rswitch_etha_change_mode(priv, etha_serdes, EAMC_OPC_CONFIG);
 	if (ret)
 		return ret;
 
-	ret = rswitch_etha_tas_ram_reset(etha);
+	ret = rswitch_etha_tas_ram_reset(etha_serdes);
 	if (ret)
 		return ret;
 
 	/* Setting flow */
-	writel(0, etha->addr + EATTFC);
+	writel(0, etha_serdes->addr + EATTFC);
 
 	for (prio = 0; prio < RSWITCH_MAX_CTAG_PCP; prio++)
-		writel(EATDQDC_DQD, etha->addr + EATDQDC(prio));
+		writel(EATDQDC_DQD, etha_serdes->addr + EATDQDC(prio));
 
 	rswitch_rmac_init(etha);
 
-	ret = rswitch_etha_change_mode(priv, EAMC_OPC_OPERATION);
+	ret = rswitch_etha_change_mode(priv, etha_serdes, EAMC_OPC_OPERATION);
 	if (ret)
 		return ret;
 
 	/* Link Verification */
-	ret = rswitch_check_link(etha);
+	ret = rswitch_check_link(etha_serdes);
 	if (ret)
 		return ret;
 
@@ -950,13 +965,14 @@ static int rswitch_write_hwaddr(struct udevice *dev)
 {
 	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	struct rswitch_etha *etha = &priv->etha;
+	struct rswitch_etha_io *etha_serdes = &etha->serdes;
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	unsigned char *mac = pdata->enetaddr;
 
 	writel((mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5],
-	       etha->addr + MRMAC1);
+	       etha_serdes->addr + MRMAC1);
 
-	writel((mac[0] << 8) | mac[1], etha->addr + MRMAC0);
+	writel((mac[0] << 8) | mac[1], etha_serdes->addr + MRMAC0);
 
 	return 0;
 }
@@ -998,19 +1014,23 @@ static int rswitch_port_probe(struct udevice *dev)
 
 	priv->addr = rpriv->addr;
 
+	ret = generic_phy_get_by_index(dev, 0, &priv->serdes);
+	if (ret)
+		return ret;
+
 	etha->enetaddr = pdata->enetaddr;
 
-	etha->index = dev_read_u32_default(dev, "reg", 0);
-	etha->addr = priv->addr + RSWITCH_ETHA_OFFSET + etha->index * RSWITCH_ETHA_SIZE;
+	etha->mii.index = dev_read_u32_default(dev, "reg", 0);
+	etha->serdes.index = priv->serdes.id;
+	etha->mii.addr = priv->addr + RSWITCH_ETHA_OFFSET +
+			 etha->mii.index * RSWITCH_ETHA_SIZE;
+	etha->serdes.addr = priv->addr + RSWITCH_ETHA_OFFSET +
+			    etha->serdes.index * RSWITCH_ETHA_SIZE;
 
 	gwca->index = 1;
 	gwca->addr = priv->addr + RSWITCH_GWCA_OFFSET + gwca->index * RSWITCH_GWCA_SIZE;
 	gwca->index = GWCA_TO_HW_INDEX(gwca->index);
 
-	ret = generic_phy_get_by_index(dev, 0, &priv->serdes);
-	if (ret)
-		return ret;
-
 	/* Toggle the reset so we can access the PHYs */
 	ret = rswitch_reset(priv);
 	if (ret)
-- 
2.51.0

