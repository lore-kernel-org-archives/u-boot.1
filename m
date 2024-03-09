Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A0C5475B
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 02:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6759187F06;
	Sat,  9 Mar 2024 03:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709950750;
	bh=r7N7m1mL4wi1n85P7C4DDQjUnm5i7J9O/r1UUiXvkUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J4AV3T+9x+dfpTERZt1kdkZZ8zvvRG6nO1Ttj2pQ65VnQrAr4np6Uf3XrY8MZ5FGC
	 M2vp95nFgnL+m+GEGWkpyfH/kW3M2WwWadfe6BboHspUIHOz8NiG1mFLE2sBTnsKEe
	 ti1bhbN1hNrEvWSMFcW5eBeCeVcXUSi6AWa1SPoPSeqXzjgOyDz7F3daxWz6hwYhHQ
	 f+GyJ1m5hLw6Jv20vQoPbmuy4Au3K5X5imn9ZkZ94RfC0xttR5NW+ZBchQkxq8QKYV
	 kMZKJUsuy2vDxbvNOnmaHMLQOFWft6cN8V/Y0VXyqB81QBHQEmn0Qk7zBVwvkmW5a6
	 kQpEJHiICxiLQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7406E87DA5;
 Sat,  9 Mar 2024 03:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709950739;
 bh=r7N7m1mL4wi1n85P7C4DDQjUnm5i7J9O/r1UUiXvkUg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HqhkHQdRNYfT9zp/6Gw3otlSk1NI03MOC+hGWhg8HFVtLc2ZlUoL9u+4XP5rlDKtS
 g5WiQa0zji98tUbPKZNU8NIinMUb9mdMt6zly+FRA763HDWFLkZ6QSu+ntlDYBgjs7
 K5nW9FJzGRHlK/jG+xwwx3kYogZE7g9WTiOdGFgTPPQThvMU7cI0V3WZ9oj2sg0+lg
 wnmjJKhejbg/k+upNLR4xWT61Soc7wYYSHJgpmoKf1rLTvKx31RbNNsXBAd9yD1Pzv
 GexBBJVnNn11fMSE0JIvOACuokgETcuuZ88MNK13j8Or2dCUe8bNMPOfMJ6FGTZQU1
 IliG8g6+w5GMA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 07/11] net: dwc_eth_qos: Use consistent logging prints
Date: Sat,  9 Mar 2024 03:11:28 +0100
Message-ID: <20240309021831.264018-8-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309021831.264018-1-marex@denx.de>
References: <20240309021831.264018-1-marex@denx.de>
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

Use dev_*() only to print all the logs from this glue code,
instead of mixing dev_*(), log_*(), pr_*() all in one code.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/net/dwc_eth_qos_stm32.c | 52 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index 38037c47954..72f65f80540 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -63,36 +63,36 @@ static int eqos_start_clks_stm32(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK))
 		return 0;
 
-	debug("%s(dev=%p):\n", __func__, dev);
+	dev_dbg(dev, "%s:\n", __func__);
 
 	ret = clk_enable(&eqos->clk_master_bus);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_master_bus) failed: %d", ret);
+		dev_err(dev, "clk_enable(clk_master_bus) failed: %d\n", ret);
 		goto err;
 	}
 
 	ret = clk_enable(&eqos->clk_rx);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_rx) failed: %d", ret);
+		dev_err(dev, "clk_enable(clk_rx) failed: %d\n", ret);
 		goto err_disable_clk_master_bus;
 	}
 
 	ret = clk_enable(&eqos->clk_tx);
 	if (ret < 0) {
-		pr_err("clk_enable(clk_tx) failed: %d", ret);
+		dev_err(dev, "clk_enable(clk_tx) failed: %d\n", ret);
 		goto err_disable_clk_rx;
 	}
 
 	if (clk_valid(&eqos->clk_ck) && !eqos->clk_ck_enabled) {
 		ret = clk_enable(&eqos->clk_ck);
 		if (ret < 0) {
-			pr_err("clk_enable(clk_ck) failed: %d", ret);
+			dev_err(dev, "clk_enable(clk_ck) failed: %d\n", ret);
 			goto err_disable_clk_tx;
 		}
 		eqos->clk_ck_enabled = true;
 	}
 
-	debug("%s: OK\n", __func__);
+	dev_dbg(dev, "%s: OK\n", __func__);
 	return 0;
 
 err_disable_clk_tx:
@@ -102,7 +102,8 @@ err_disable_clk_rx:
 err_disable_clk_master_bus:
 	clk_disable(&eqos->clk_master_bus);
 err:
-	debug("%s: FAILED: %d\n", __func__, ret);
+	dev_dbg(dev, "%s: FAILED: %d\n", __func__, ret);
+
 	return ret;
 }
 
@@ -113,13 +114,14 @@ static int eqos_stop_clks_stm32(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK))
 		return 0;
 
-	debug("%s(dev=%p):\n", __func__, dev);
+	dev_dbg(dev, "%s:\n", __func__);
 
 	clk_disable(&eqos->clk_tx);
 	clk_disable(&eqos->clk_rx);
 	clk_disable(&eqos->clk_master_bus);
 
-	debug("%s: OK\n", __func__);
+	dev_dbg(dev, "%s: OK\n", __func__);
+
 	return 0;
 }
 
@@ -143,20 +145,20 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 
 	switch (interface_type) {
 	case PHY_INTERFACE_MODE_MII:
-		log_debug("PHY_INTERFACE_MODE_MII\n");
+		dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
 		value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_GMII:
-		log_debug("PHY_INTERFACE_MODE_GMII\n");
+		dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
 		if (eth_clk_sel_reg)
 			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		log_debug("PHY_INTERFACE_MODE_RMII\n");
+		dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_RMII);
 		if (eth_ref_clk_sel_reg)
@@ -166,15 +168,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		log_debug("PHY_INTERFACE_MODE_RGMII\n");
+		dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
 		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
 				   SYSCFG_PMCSETR_ETH_SEL_RGMII);
 		if (eth_clk_sel_reg)
 			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
 		break;
 	default:
-		log_debug("Do not manage %d interface\n",
-			  interface_type);
+		dev_dbg(dev, "Do not manage %d interface\n",
+			interface_type);
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
@@ -194,12 +196,12 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 	phy_interface_t interface;
 	int ret;
 
-	debug("%s(dev=%p):\n", __func__, dev);
+	dev_dbg(dev, "%s:\n", __func__);
 
 	interface = eqos->config->interface(dev);
 
 	if (interface == PHY_INTERFACE_MODE_NA) {
-		pr_err("Invalid PHY interface\n");
+		dev_err(dev, "Invalid PHY interface\n");
 		return -EINVAL;
 	}
 
@@ -209,39 +211,41 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 
 	ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
 	if (ret) {
-		pr_err("clk_get_by_name(master_bus) failed: %d", ret);
+		dev_err(dev, "clk_get_by_name(master_bus) failed: %d\n", ret);
 		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "mac-clk-rx", &eqos->clk_rx);
 	if (ret) {
-		pr_err("clk_get_by_name(rx) failed: %d", ret);
+		dev_err(dev, "clk_get_by_name(rx) failed: %d\n", ret);
 		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "mac-clk-tx", &eqos->clk_tx);
 	if (ret) {
-		pr_err("clk_get_by_name(tx) failed: %d", ret);
+		dev_err(dev, "clk_get_by_name(tx) failed: %d\n", ret);
 		goto err_probe;
 	}
 
 	/*  Get ETH_CLK clocks (optional) */
 	ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
 	if (ret)
-		pr_warn("No phy clock provided %d", ret);
+		dev_warn(dev, "No phy clock provided %d\n", ret);
+
+	dev_dbg(dev, "%s: OK\n", __func__);
 
-	debug("%s: OK\n", __func__);
 	return 0;
 
 err_probe:
 
-	debug("%s: returns %d\n", __func__, ret);
+	dev_dbg(dev, "%s: returns %d\n", __func__, ret);
+
 	return ret;
 }
 
 static int eqos_remove_resources_stm32(struct udevice *dev)
 {
-	debug("%s(dev=%p):\n", __func__, dev);
+	dev_dbg(dev, "%s:\n", __func__);
 
 	return 0;
 }
-- 
2.43.0

