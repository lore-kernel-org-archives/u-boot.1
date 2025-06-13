Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7967DC61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 06:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964D182AA7;
	Fri, 13 Jun 2025 08:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C4Rk8UET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ADA82B0F; Fri, 13 Jun 2025 08:21:29 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56DE828A2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 08:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55D6LPap1897128;
 Fri, 13 Jun 2025 01:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749795685;
 bh=Zja7n+rATpSVAWDcJyzyXQ/p2FwNY2nepL5HRNe0jd4=;
 h=From:To:CC:Subject:Date;
 b=C4Rk8UETMqFUcFJxVSROW8wxC4CJLqxCPHiM9RvOR9WZn6V0mpjz1CtM/lrB7Hcpo
 FfiV42lLfAvHuZik9iOyu/LvvTOyeQbOd6WxDyQ045KYUMzKPAf+ApUb1mU7e27RfO
 hpDsFHJQtq8vMVQfmzwD5YJ/jfDivccXzVWuDZx8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55D6LP9l2396888
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 13 Jun 2025 01:21:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 13
 Jun 2025 01:21:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 13 Jun 2025 01:21:24 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55D6LMdZ3318760;
 Fri, 13 Jun 2025 01:21:23 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH] phy: cadence: torrent: add support for three or more links
 using 2 protocols
Date: Fri, 13 Jun 2025 11:51:21 +0530
Message-ID: <20250613062121.222980-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This is a port of the corresponding commit in the Linux kernel which
adds the same support for the Cadence Torrent driver[0]. The commit
message below is taken as-is from the Linux kernel commit being ported.

The Torrent SERDES can support at most two different protocols (PHY types).
This only mandates that the device-tree sub-nodes used to represent the
configuration should describe links with at-most two different protocols.

The existing implementation however imposes an artificial constraint that
allows only two links (device-tree sub-nodes). As long as at-most two
protocols are chosen, using more than two links to describe them in an
alternating configuration is still a valid configuration of the Torrent
SERDES.

A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
Lane 0 => Protocol 1 => Link 1
Lane 1 => Protocol 1 => Link 1
Lane 2 => Protocol 2 => Link 2
Lane 3 => Protocol 1 => Link 3

A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
Lane 0 => Protocol 1 => Link 1
Lane 1 => Protocol 2 => Link 2
Lane 2 => Protocol 1 => Link 3
Lane 3 => Protocol 2 => Link 4

[0] https://github.com/torvalds/linux/commit/5b7b83a9839be643410c31d56f17c2d430245813

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on commit
59d00e20fce Merge tag 'v2025.07-rc4' into next

 drivers/phy/cadence/phy-cadence-torrent.c | 225 +++++++++++++---------
 1 file changed, 130 insertions(+), 95 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index d4e8ece4935..1f566d082f9 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -240,6 +240,7 @@ struct cdns_torrent_inst {
 
 struct cdns_torrent_phy {
 	void __iomem *sd_base;	/* SD0801 register base  */
+	u32 protocol_bitmask;
 	size_t size;
 	struct reset_control *phy_rst;
 	struct udevice *dev;
@@ -432,124 +433,155 @@ static int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_ph
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
-	u32 num_regs;
+	u32 num_regs, num_protocols, protocol;
+
+	num_protocols = hweight32(cdns_phy->protocol_bitmask);
 
-	/* Maximum 2 links (subnodes) are supported */
-	if (cdns_phy->nsubnodes != 2)
+	/* Maximum 2 protocols are supported */
+	if (num_protocols > 2) {
+		dev_err(cdns_phy->dev, "at most 2 protocols are supported\n");
 		return -EINVAL;
+	}
 
-	phy_t1 = cdns_phy->phys[0].phy_type;
-	phy_t2 = cdns_phy->phys[1].phy_type;
+	if (cdns_phy->nsubnodes == 2) {
+		phy_t1 = cdns_phy->phys[0].phy_type;
+		phy_t2 = cdns_phy->phys[1].phy_type;
+	} else {
+		if (num_protocols != 2) {
+			dev_err(cdns_phy->dev, "incorrect representation of link\n");
+			return -EINVAL;
+		}
+		phy_t1 = __ffs(cdns_phy->protocol_bitmask);
+		phy_t2 = __fls(cdns_phy->protocol_bitmask);
+	}
 
-	/*
-	 * First configure the PHY for first link with phy_t1. Geth the array
-	 * values are [phy_t1][phy_t2][ssc].
+	/**
+	 * Configure all links with the protocol phy_t1 first followed by
+	 * configuring all links with the protocol phy_t2.
+	 *
+	 * When phy_t1 = phy_t2, it is a single protocol and configuration
+	 * is performed with a single iteration of the protocol and multiple
+	 * iterations over the sub-nodes (links).
+	 *
+	 * When phy_t1 != phy_t2, there are two protocols and configuration
+	 * is performed by iterating over all sub-nodes matching the first
+	 * protocol and configuring them first, followed by iterating over
+	 * all sub-nodes matching the second protocol and configuring them
+	 * next.
 	 */
-	for (node = 0; node < cdns_phy->nsubnodes; node++) {
-		if (node == 1) {
-			/*
-			 * If fist link with phy_t1 is configured, then
-			 * configure the PHY for second link with phy_t2.
-			 * Get the array values as [phy_t2][phy_t1][ssc]
-			 */
+
+	for (protocol = 0; protocol < num_protocols; protocol++) {
+		/**
+		 * For the case where num_protocols is 1,
+		 * phy_t1 = phy_t2 and the swap is unnecessary.
+		 *
+		 * Swapping phy_t1 and phy_t2 is only required when the
+		 * number of protocols is 2 and there are 2 or more links.
+		 */
+		if (protocol == 1) {
 			tmp_phy_type = phy_t1;
 			phy_t1 = phy_t2;
 			phy_t2 = tmp_phy_type;
 		}
 
-		mlane = cdns_phy->phys[node].mlane;
-		ssc = cdns_phy->phys[node].ssc_mode;
-		num_lanes = cdns_phy->phys[node].num_lanes;
+		for (node = 0; node < cdns_phy->nsubnodes; node++) {
+			if (cdns_phy->phys[node].phy_type != phy_t1)
+				continue;
 
-		/**
-		 * PHY configuration specific registers:
-		 * link_cmn_vals depend on combination of PHY types being
-		 * configured and are common for both PHY types, so array
-		 * values should be same for [phy_t1][phy_t2][ssc] and
-		 * [phy_t2][phy_t1][ssc].
-		 * xcvr_diag_vals also depend on combination of PHY types
-		 * being configured, but these can be different for particular
-		 * PHY type and are per lane.
-		 */
-		link_cmn_vals = init_data->link_cmn_vals[phy_t1][phy_t2][ssc];
-		if (link_cmn_vals) {
-			reg_pairs = link_cmn_vals->reg_pairs;
-			num_regs = link_cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_common_cdb;
+			mlane = cdns_phy->phys[node].mlane;
+			ssc = cdns_phy->phys[node].ssc_mode;
+			num_lanes = cdns_phy->phys[node].num_lanes;
 
 			/**
-			 * First array value in link_cmn_vals must be of
-			 * PHY_PLL_CFG register
+			 * PHY configuration specific registers:
+			 * link_cmn_vals depend on combination of PHY types being
+			 * configured and are common for both PHY types, so array
+			 * values should be same for [phy_t1][phy_t2][ssc] and
+			 * [phy_t2][phy_t1][ssc].
+			 * xcvr_diag_vals also depend on combination of PHY types
+			 * being configured, but these can be different for particular
+			 * PHY type and are per lane.
 			 */
-			regmap_field_write(cdns_phy->phy_pll_cfg,
-					   reg_pairs[0].val);
-
-			for (i = 1; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+			link_cmn_vals = init_data->link_cmn_vals[phy_t1][phy_t2][ssc];
+			if (link_cmn_vals) {
+				reg_pairs = link_cmn_vals->reg_pairs;
+				num_regs = link_cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_common_cdb;
+
+				/**
+				 * First array value in link_cmn_vals must be of
+				 * PHY_PLL_CFG register
+				 */
+				regmap_field_write(cdns_phy->phy_pll_cfg,
+						   reg_pairs[0].val);
+
+				for (i = 1; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
+			}
 
-		xcvr_diag_vals = init_data->xcvr_diag_vals[phy_t1][phy_t2][ssc];
-		if (xcvr_diag_vals) {
-			reg_pairs = xcvr_diag_vals->reg_pairs;
-			num_regs = xcvr_diag_vals->num_regs;
-			for (i = 0; i < num_lanes; i++) {
-				regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
-				for (j = 0; j < num_regs; j++)
-					regmap_write(regmap, reg_pairs[j].off,
-						     reg_pairs[j].val);
+			xcvr_diag_vals = init_data->xcvr_diag_vals[phy_t1][phy_t2][ssc];
+			if (xcvr_diag_vals) {
+				reg_pairs = xcvr_diag_vals->reg_pairs;
+				num_regs = xcvr_diag_vals->num_regs;
+				for (i = 0; i < num_lanes; i++) {
+					regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
+					for (j = 0; j < num_regs; j++)
+						regmap_write(regmap, reg_pairs[j].off,
+							     reg_pairs[j].val);
+				}
 			}
-		}
 
-		/* PHY PCS common registers configurations */
-		pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
-		if (pcs_cmn_vals) {
-			reg_pairs = pcs_cmn_vals->reg_pairs;
-			num_regs = pcs_cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_phy_pcs_common_cdb;
-			for (i = 0; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+			/* PHY PCS common registers configurations */
+			pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
+			if (pcs_cmn_vals) {
+				reg_pairs = pcs_cmn_vals->reg_pairs;
+				num_regs = pcs_cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+				for (i = 0; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
+			}
 
-		/* PMA common registers configurations */
-		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
-		if (cmn_vals) {
-			reg_pairs = cmn_vals->reg_pairs;
-			num_regs = cmn_vals->num_regs;
-			regmap = cdns_phy->regmap_common_cdb;
-			for (i = 0; i < num_regs; i++)
-				regmap_write(regmap, reg_pairs[i].off,
-					     reg_pairs[i].val);
-		}
+			/* PMA common registers configurations */
+			cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
+			if (cmn_vals) {
+				reg_pairs = cmn_vals->reg_pairs;
+				num_regs = cmn_vals->num_regs;
+				regmap = cdns_phy->regmap_common_cdb;
+				for (i = 0; i < num_regs; i++)
+					regmap_write(regmap, reg_pairs[i].off,
+						     reg_pairs[i].val);
+			}
 
-		/* PMA TX lane registers configurations */
-		tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
-		if (tx_ln_vals) {
-			reg_pairs = tx_ln_vals->reg_pairs;
-			num_regs = tx_ln_vals->num_regs;
-			for (i = 0; i < num_lanes; i++) {
-				regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
-				for (j = 0; j < num_regs; j++)
-					regmap_write(regmap, reg_pairs[j].off,
-						     reg_pairs[j].val);
+			/* PMA TX lane registers configurations */
+			tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
+			if (tx_ln_vals) {
+				reg_pairs = tx_ln_vals->reg_pairs;
+				num_regs = tx_ln_vals->num_regs;
+				for (i = 0; i < num_lanes; i++) {
+					regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
+					for (j = 0; j < num_regs; j++)
+						regmap_write(regmap, reg_pairs[j].off,
+							     reg_pairs[j].val);
+				}
 			}
-		}
 
-		/* PMA RX lane registers configurations */
-		rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
-		if (rx_ln_vals) {
-			reg_pairs = rx_ln_vals->reg_pairs;
-			num_regs = rx_ln_vals->num_regs;
-			for (i = 0; i < num_lanes; i++) {
-				regmap = cdns_phy->regmap_rx_lane_cdb[i + mlane];
-				for (j = 0; j < num_regs; j++)
-					regmap_write(regmap, reg_pairs[j].off,
-						     reg_pairs[j].val);
+			/* PMA RX lane registers configurations */
+			rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
+			if (rx_ln_vals) {
+				reg_pairs = rx_ln_vals->reg_pairs;
+				num_regs = rx_ln_vals->num_regs;
+				for (i = 0; i < num_lanes; i++) {
+					regmap = cdns_phy->regmap_rx_lane_cdb[i + mlane];
+					for (j = 0; j < num_regs; j++)
+						regmap_write(regmap, reg_pairs[j].off,
+							     reg_pairs[j].val);
+				}
 			}
-		}
 
-		reset_deassert_bulk(cdns_phy->phys[node].lnk_rst);
+			reset_deassert_bulk(cdns_phy->phys[node].lnk_rst);
+		}
 	}
 
 	/* Take the PHY out of reset */
@@ -575,6 +607,7 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
 	/* Get init data for this phy  */
 	data = (struct cdns_torrent_data *)dev_get_driver_data(dev);
 	cdns_phy->init_data = data;
+	cdns_phy->protocol_bitmask = 0;
 
 	cdns_phy->phy_rst = devm_reset_control_get_by_index(dev, 0);
 	if (IS_ERR(cdns_phy->phy_rst)) {
@@ -677,6 +710,8 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
 		/* Get SSC mode */
 		ofnode_read_u32(child, "cdns,ssc-mode",
 				&cdns_phy->phys[node].ssc_mode);
+
+		cdns_phy->protocol_bitmask |= BIT(cdns_phy->phys[node].phy_type);
 		node++;
 	}
 
-- 
2.34.1

