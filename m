Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FA6C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF9187B44;
	Mon, 22 Jan 2024 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gkUWwMC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB04879CB; Mon, 22 Jan 2024 15:33:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6771A87949
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8BD6B614F1;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E140C433F1;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705934006;
 bh=HiRZyyXC+JA0MQ1SbsqYBAPdtpB9R8g4hb3l8/6pBWw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=gkUWwMC1fR77u5IdGykCqHDkPx61bTdQnpXiA5dgz52POod+jM/QadUzbXpxOY8vQ
 o7zz6lzbkcWW7MYXTY94RY3A6buMVpKATWPY9jXZsVQn2NQY36xxIAsLdb/tGs4++x
 5oLw+ihxvbkSa8T5EpNg1ubSiT9babBafea6CCYsVQlwmobnp0pmMhY/vfxkYxy0Py
 dmHzX8oI5JwbPeReJIg6CYvyFu57ai8Ypq7Qt/JUUrtUhgjNU5BwLtkAy6aSZDEzbU
 vYk6bmDUsu73xy7KnGmx4C/tVoc/fCW+3EpdAOPc2Z7yaBmBfqpC7/PnHEXfzBS/Ak
 RZtNt1KpA8Nlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 267DFC47DDF;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 22 Jan 2024 22:33:21 +0800
Subject: [PATCH v3 2/5] net: hifemac: fix log reporting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-net-v3-2-f1e80564725b@outlook.com>
References: <20240122-net-v3-0-f1e80564725b@outlook.com>
In-Reply-To: <20240122-net-v3-0-f1e80564725b@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705934004; l=6569;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=5cyUg5mF3yyXwrX1AvQvJQpfQ3oNcmSAKW0TIb3hMNo=;
 b=rqDWHjn6Y21cKrIi0JafNnANBBEA/JNYWAlTZ1EqacysYhwRcwyEv9VuaoF+iwaFMLuZvU+TK
 9rerlWNqz3QCb7oqwk8sbwqUq+R2EuxtTYg6en08kGPRugZaY+5IizF
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

shrink the first argument of log_msg_ret(), add dev_xxx() functions for
error reporting.

Fixes: 9d8f78a2a79f7 ("net: add hifemac Ethernet driver for HiSilicon platform")

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/hifemac.c | 110 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 37 deletions(-)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index b61a29e636..1088f3eca3 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -245,8 +245,10 @@ static int hisi_femac_start(struct udevice *dev)
 	hisi_femac_rx_refill(priv);
 
 	ret = phy_startup(priv->phy);
-	if (ret)
-		return log_msg_ret("Failed to startup phy", ret);
+	if (ret) {
+		dev_err(dev, "Failed to startup phy: %d\n", ret);
+		return log_msg_ret("phy", ret);
+	}
 
 	if (!priv->phy->link) {
 		debug("%s: link down\n", __func__);
@@ -281,8 +283,10 @@ static int hisi_femac_send(struct udevice *dev, void *packet, int length)
 
 	// wait until FIFO is empty
 	ret = wait_for_bit_le32(priv->glb_base + GLB_IRQ_RAW, IRQ_INT_TX_PER_PACKET, true, 50, false);
-	if (ret == -ETIMEDOUT)
-		return log_msg_ret("FIFO timeout", ret);
+	if (ret == -ETIMEDOUT) {
+		dev_err(dev, "FIFO timeout\n");
+		return log_msg_ret("net", ret);
+	}
 
 	return 0;
 }
@@ -340,35 +344,45 @@ int hisi_femac_of_to_plat(struct udevice *dev)
 	};
 
 	priv->port_base = dev_remap_addr_name(dev, "port");
-	if (IS_ERR(priv->port_base))
-		return log_msg_ret("Failed to remap port address space", PTR_ERR(priv->port_base));
+	if (!priv->port_base) {
+		dev_err(dev, "Failed to remap port address space\n");
+		return log_msg_ret("net", -EINVAL);
+	}
 
 	priv->glb_base = dev_remap_addr_name(dev, "glb");
-	if (IS_ERR(priv->glb_base))
-		return log_msg_ret("Failed to remap global address space", PTR_ERR(priv->glb_base));
+	if (IS_ERR(priv->glb_base)) {
+		dev_err(dev, "Failed to remap global address space\n");
+		return log_msg_ret("net", -EINVAL);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(clk_strs); i++) {
 		priv->clks[i] = devm_clk_get(dev, clk_strs[i]);
 		if (IS_ERR(priv->clks[i])) {
 			dev_err(dev, "Error getting clock %s\n", clk_strs[i]);
-			return log_msg_ret("Failed to get clocks", PTR_ERR(priv->clks[i]));
+			return log_msg_ret("clk", PTR_ERR(priv->clks[i]));
 		}
 	}
 
 	priv->mac_rst = devm_reset_control_get(dev, "mac");
-	if (IS_ERR(priv->mac_rst))
-		return log_msg_ret("Failed to get MAC reset", PTR_ERR(priv->mac_rst));
+	if (IS_ERR(priv->mac_rst)) {
+		dev_err(dev, "Failed to get MAC reset %ld\n", PTR_ERR(priv->mac_rst));
+		return log_msg_ret("rst", PTR_ERR(priv->mac_rst));
+	}
 
 	priv->phy_rst = devm_reset_control_get(dev, "phy");
-	if (IS_ERR(priv->phy_rst))
-		return log_msg_ret("Failed to get PHY reset", PTR_ERR(priv->phy_rst));
+	if (IS_ERR(priv->phy_rst)) {
+		dev_err(dev, "Failed to get PHY reset %ld\n", PTR_ERR(priv->phy_rst));
+		return log_msg_ret("rst", PTR_ERR(priv->phy_rst));
+	}
 
 	ret = dev_read_u32_array(dev,
 				 PHY_RESET_DELAYS_PROPERTY,
 				 priv->phy_reset_delays,
 				 DELAYS_NUM);
-	if (ret < 0)
-		return log_msg_ret("Failed to get PHY reset delays", ret);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get PHY reset delays %d\n", ret);
+		return log_msg_ret("rst", ret);
+	}
 
 	priv->mac_reset_delay = dev_read_u32_default(dev,
 						     MAC_RESET_DELAY_PROPERTY,
@@ -385,32 +399,44 @@ static int hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 
 	// Disable MAC clk before phy reset
 	ret = clk_disable(priv->clks[CLK_MAC]);
-	if (ret < 0)
-		return log_msg_ret("Failed to disable MAC clock", ret);
+	if (ret < 0) {
+		pr_err("%s: Failed to disable MAC clock %d\n", __func__, ret);
+		return log_msg_ret("clk", ret);
+	}
 	ret = clk_disable(priv->clks[CLK_BUS]);
-	if (ret < 0)
-		return log_msg_ret("Failed to disable bus clock", ret);
+	if (ret < 0) {
+		pr_err("%s: Failed to disable bus clock %d\n", __func__, ret);
+		return log_msg_ret("clk", ret);
+	}
 
 	udelay(delays[PRE_DELAY]);
 
 	ret = reset_assert(rst);
-	if (ret < 0)
-		return log_msg_ret("Failed to assert reset", ret);
+	if (ret < 0) {
+		pr_err("%s: Failed to assert reset %d\n", __func__, ret);
+		return log_msg_ret("rst", ret);
+	}
 
 	udelay(delays[PULSE]);
 
 	ret = reset_deassert(rst);
-	if (ret < 0)
-		return log_msg_ret("Failed to deassert reset", ret);
+	if (ret < 0) {
+		pr_err("%s: Failed to deassert reset %d\n", __func__, ret);
+		return log_msg_ret("rst", ret);
+	}
 
 	udelay(delays[POST_DELAY]);
 
 	ret = clk_enable(priv->clks[CLK_MAC]);
-	if (ret < 0)
-		return log_msg_ret("Failed to enable MAC clock", ret);
+	if (ret < 0) {
+		pr_err("%s: Failed to enable MAC clock %d\n", __func__, ret);
+		return log_msg_ret("clk", ret);
+	}
 	ret = clk_enable(priv->clks[CLK_BUS]);
-	if (ret < 0)
-		return log_msg_ret("Failed to enable MAC bus clock", ret);
+	if (ret < 0) {
+		pr_err("%s: Failed to enable MAC bus clock %d\n", __func__, ret);
+		return log_msg_ret("clk", ret);
+	}
 
 	return 0;
 }
@@ -423,30 +449,40 @@ int hisi_femac_probe(struct udevice *dev)
 	// Enable clocks
 	for (i = 0; i < CLK_NUM; i++) {
 		ret = clk_prepare_enable(priv->clks[i]);
-		if (ret < 0)
-			return log_msg_ret("Failed to enable clks", ret);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable clk %d: %d\n", i, ret);
+			return log_msg_ret("clk", ret);
+		}
 	}
 
 	// Reset MAC
 	ret = reset_assert(priv->mac_rst);
-	if (ret < 0)
-		return log_msg_ret("Failed to assert MAC reset", ret);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert MAC reset: %d\n", ret);
+		return log_msg_ret("net", ret);
+	}
 
 	udelay(priv->mac_reset_delay);
 
 	ret = reset_deassert(priv->mac_rst);
-	if (ret < 0)
-		return log_msg_ret("Failed to deassert MAC reset", ret);
+	if (ret < 0) {
+		dev_err(dev, "Failed to deassert MAC reset: %d\n", ret);
+		return log_msg_ret("net", ret);
+	}
 
 	// Reset PHY
 	ret = hisi_femac_phy_reset(priv);
-	if (ret < 0)
-		return log_msg_ret("Failed to reset phy", ret);
+	if (ret < 0) {
+		dev_err(dev, "Failed to reset PHY: %d\n", ret);
+		return log_msg_ret("net", ret);
+	}
 
 	// Connect to PHY
 	priv->phy = dm_eth_phy_connect(dev);
-	if (!priv->phy)
-		return log_msg_ret("Failed to connect to phy", -EINVAL);
+	if (!priv->phy) {
+		dev_err(dev, "Failed to connect to phy\n");
+		return log_msg_ret("phy", -EINVAL);
+	}
 
 	hisi_femac_port_init(priv);
 	return 0;

-- 
2.43.0

