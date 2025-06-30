Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3EFC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 633E182E6A;
	Mon, 30 Jun 2025 20:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q3kp8P1d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mCjixCpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EFA82EA9; Mon, 30 Jun 2025 20:51:51 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1783F81FFC
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bWFcr5fPmz9tPp;
 Mon, 30 Jun 2025 20:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xbFwvdHQts9W2lfDmzElwK4c74BVFfGx9+gtdBqiIlw=;
 b=q3kp8P1d6gl6lC+fhNnEvixX7zpEMrpF/Ux2W2toam/5CHuPxlWTn4265mXiskw6IMYq+5
 I3bk4PZFdhzhbi8SYgoFJQFVXY8fCimaTo4ap/6k7XTRAweoa7YDKkb7l/JMH5vnLV2Va5
 8AN0jEhuj9dWznCbyk9t15DrmzAAuBl6ULt7kXXXqyiXLtPryzcLRL6Lb2D1HwBtVRWDH0
 iQUD/y6JcoPG1KHQP+CPsv9DjpWYfoTSYAdznPrIXviD/n2hm6tQGOcUoxhYPYNZy4zF8X
 clqkAEqIwqMlBMsqvkDkyrBhaxs5kctThiM9mRfbMu2wgOPCE4MywqvPl8TRJg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xbFwvdHQts9W2lfDmzElwK4c74BVFfGx9+gtdBqiIlw=;
 b=mCjixCpwL+i5HIZ5IX2LvZi1D1OujGTur04O18PdYCUoxJEgFTEveo8QfREYXb1NckC22m
 61YTf7kX/Ca06nKYE8jEhEcejg+geQS6SrrqZ60OGt7A2m633TeXcqAPQmlZlujhtq6/pu
 1XLoJH2C0WC9MmperZQ3wJvMa+e3qR8zTrY/X3A96Pn1H/fXa9YK4xSpqluD7dd98Lz9y2
 m3S4ri5gqjjLQn7a4TNKmm0KCxJDLpMYg00qte8YFr09kIpfhVvOExulwLCXI045v1uZdt
 MeRt+vssA7J71yGvuAV622oP6s/cB93iDscLi2aYMAy7aOIA404chp89d0Hwxg==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] net: sh_eth: Pass struct port_info around
Date: Mon, 30 Jun 2025 20:51:10 +0200
Message-ID: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bors7485biixaw6m7ju43fy5eq6en1qg
X-MBO-RS-ID: 50b610e32db3b0dea39
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

The struct sh_eth_dev .port member is always set to 0, therefore only
single-ported SH Ethernet is ever used. Support for multiple SH Ethernet
ports implemented on driver level is a remnant from before U-Boot DM
existed.

Pass struct sh_eth_info port_info around directly and remove the
struct sh_eth_dev entirely. Handling of multiple ports should be done
by U-Boot DM and multiple per-driver-instance private data.

No functional change intended.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/sh_eth.c | 136 +++++++++++++++++--------------------------
 drivers/net/sh_eth.h |   8 ---
 2 files changed, 52 insertions(+), 92 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index f695a3a41d2..339a4771586 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -64,10 +64,9 @@
 
 #define TIMEOUT_CNT 1000
 
-static int sh_eth_send_common(struct sh_eth_dev *eth, void *packet, int len)
+static int sh_eth_send_common(struct sh_eth_info *port_info, void *packet, int len)
 {
 	int ret = 0, timeout;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 
 	if (!packet || len > 0xffff) {
 		printf(SHETHER_NAME ": %s: Invalid argument\n", __func__);
@@ -121,10 +120,8 @@ err:
 	return ret;
 }
 
-static int sh_eth_recv_start(struct sh_eth_dev *eth)
+static int sh_eth_recv_start(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
 	/* Check if the rx descriptor is ready */
 	invalidate_cache(port_info->rx_desc_cur, sizeof(struct rx_desc_s));
 	if (port_info->rx_desc_cur->rd0 & RD_RACT)
@@ -137,10 +134,8 @@ static int sh_eth_recv_start(struct sh_eth_dev *eth)
 	return port_info->rx_desc_cur->rd1 & 0xffff;
 }
 
-static void sh_eth_recv_finish(struct sh_eth_dev *eth)
+static void sh_eth_recv_finish(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
 	invalidate_cache(ADDR_TO_P2(port_info->rx_desc_cur->rd2), MAX_BUF_SIZE);
 
 	/* Make current descriptor available again */
@@ -159,9 +154,8 @@ static void sh_eth_recv_finish(struct sh_eth_dev *eth)
 		port_info->rx_desc_cur = port_info->rx_desc_base;
 }
 
-static int sh_eth_reset(struct sh_eth_dev *eth)
+static int sh_eth_reset(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
 	int ret = 0, i;
 
@@ -192,12 +186,11 @@ static int sh_eth_reset(struct sh_eth_dev *eth)
 #endif
 }
 
-static int sh_eth_tx_desc_init(struct sh_eth_dev *eth)
+static int sh_eth_tx_desc_init(struct sh_eth_info *port_info)
 {
-	int i, ret = 0;
 	u32 alloc_desc_size = NUM_TX_DESC * sizeof(struct tx_desc_s);
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 	struct tx_desc_s *cur_tx_desc;
+	int i, ret = 0;
 
 	/*
 	 * Allocate rx descriptors. They must be aligned to size of struct
@@ -244,11 +237,10 @@ err:
 	return ret;
 }
 
-static int sh_eth_rx_desc_init(struct sh_eth_dev *eth)
+static int sh_eth_rx_desc_init(struct sh_eth_info *port_info)
 {
 	int i, ret = 0;
 	u32 alloc_desc_size = NUM_RX_DESC * sizeof(struct rx_desc_s);
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 	struct rx_desc_s *cur_rx_desc;
 	u8 *rx_buf;
 
@@ -318,20 +310,16 @@ err:
 	return ret;
 }
 
-static void sh_eth_tx_desc_free(struct sh_eth_dev *eth)
+static void sh_eth_tx_desc_free(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
 	if (port_info->tx_desc_alloc) {
 		free(port_info->tx_desc_alloc);
 		port_info->tx_desc_alloc = NULL;
 	}
 }
 
-static void sh_eth_rx_desc_free(struct sh_eth_dev *eth)
+static void sh_eth_rx_desc_free(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
 	if (port_info->rx_desc_alloc) {
 		free(port_info->rx_desc_alloc);
 		port_info->rx_desc_alloc = NULL;
@@ -343,21 +331,21 @@ static void sh_eth_rx_desc_free(struct sh_eth_dev *eth)
 	}
 }
 
-static int sh_eth_desc_init(struct sh_eth_dev *eth)
+static int sh_eth_desc_init(struct sh_eth_info *port_info)
 {
 	int ret = 0;
 
-	ret = sh_eth_tx_desc_init(eth);
+	ret = sh_eth_tx_desc_init(port_info);
 	if (ret)
 		goto err_tx_init;
 
-	ret = sh_eth_rx_desc_init(eth);
+	ret = sh_eth_rx_desc_init(port_info);
 	if (ret)
 		goto err_rx_init;
 
 	return ret;
 err_rx_init:
-	sh_eth_tx_desc_free(eth);
+	sh_eth_tx_desc_free(port_info);
 
 err_tx_init:
 	return ret;
@@ -375,9 +363,8 @@ static void sh_eth_write_hwaddr(struct sh_eth_info *port_info,
 	sh_eth_write(port_info, val, MALR);
 }
 
-static void sh_eth_mac_regs_config(struct sh_eth_dev *eth, unsigned char *mac)
+static void sh_eth_mac_regs_config(struct sh_eth_info *port_info, unsigned char *mac)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 	unsigned long edmr;
 
 	/* Configure e-dmac registers */
@@ -422,9 +409,8 @@ static void sh_eth_mac_regs_config(struct sh_eth_dev *eth, unsigned char *mac)
 #endif
 }
 
-static int sh_eth_phy_regs_config(struct sh_eth_dev *eth)
+static int sh_eth_phy_regs_config(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 	struct phy_device *phy = port_info->phydev;
 	int ret = 0;
 	u32 val = 0;
@@ -470,10 +456,8 @@ static int sh_eth_phy_regs_config(struct sh_eth_dev *eth)
 	return ret;
 }
 
-static void sh_eth_start(struct sh_eth_dev *eth)
+static void sh_eth_start(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
 	/*
 	 * Enable the e-dmac receiver only. The transmitter will be enabled when
 	 * we have something to transmit
@@ -481,33 +465,30 @@ static void sh_eth_start(struct sh_eth_dev *eth)
 	sh_eth_write(port_info, EDRRR_R, EDRRR);
 }
 
-static void sh_eth_stop(struct sh_eth_dev *eth)
+static void sh_eth_stop(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
 	sh_eth_write(port_info, ~EDRRR_R, EDRRR);
 }
 
-static int sh_eth_init_common(struct sh_eth_dev *eth, unsigned char *mac)
+static int sh_eth_init_common(struct sh_eth_info *port_info, unsigned char *mac)
 {
 	int ret = 0;
 
-	ret = sh_eth_reset(eth);
+	ret = sh_eth_reset(port_info);
 	if (ret)
 		return ret;
 
-	ret = sh_eth_desc_init(eth);
+	ret = sh_eth_desc_init(port_info);
 	if (ret)
 		return ret;
 
-	sh_eth_mac_regs_config(eth, mac);
+	sh_eth_mac_regs_config(port_info, mac);
 
 	return 0;
 }
 
-static int sh_eth_start_common(struct sh_eth_dev *eth)
+static int sh_eth_start_common(struct sh_eth_info *port_info)
 {
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 	int ret;
 
 	ret = phy_startup(port_info->phydev);
@@ -516,17 +497,17 @@ static int sh_eth_start_common(struct sh_eth_dev *eth)
 		return ret;
 	}
 
-	ret = sh_eth_phy_regs_config(eth);
+	ret = sh_eth_phy_regs_config(port_info);
 	if (ret)
 		return ret;
 
-	sh_eth_start(eth);
+	sh_eth_start(port_info);
 
 	return 0;
 }
 
 struct sh_ether_priv {
-	struct sh_eth_dev	shdev;
+	struct sh_eth_info	port_info;
 
 	struct mii_dev		*bus;
 	phys_addr_t		iobase;
@@ -536,20 +517,19 @@ struct sh_ether_priv {
 static int sh_ether_send(struct udevice *dev, void *packet, int len)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
+	struct sh_eth_info *port_info = &priv->port_info;
 
-	return sh_eth_send_common(eth, packet, len);
+	return sh_eth_send_common(port_info, packet, len);
 }
 
 static int sh_ether_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = &priv->port_info;
 	uchar *packet = (uchar *)ADDR_TO_P2((uintptr_t)port_info->rx_desc_cur->rd2);
 	int len;
 
-	len = sh_eth_recv_start(eth);
+	len = sh_eth_recv_start(port_info);
 	if (len > 0) {
 		invalidate_cache(packet, len);
 		*packetp = packet;
@@ -567,10 +547,9 @@ static int sh_ether_recv(struct udevice *dev, int flags, uchar **packetp)
 static int sh_ether_free_pkt(struct udevice *dev, uchar *packet, int length)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = &priv->port_info;
 
-	sh_eth_recv_finish(eth);
+	sh_eth_recv_finish(port_info);
 
 	/* Restart the receiver if disabled */
 	if (!(sh_eth_read(port_info, EDRRR) & EDRRR_R))
@@ -582,8 +561,7 @@ static int sh_ether_free_pkt(struct udevice *dev, uchar *packet, int length)
 static int sh_ether_write_hwaddr(struct udevice *dev)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = &priv->port_info;
 	struct eth_pdata *pdata = dev_get_plat(dev);
 
 	sh_eth_write_hwaddr(port_info, pdata->enetaddr);
@@ -595,10 +573,9 @@ static int sh_eth_phy_config(struct udevice *dev)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
-	int ret = 0;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = &priv->port_info;
 	struct phy_device *phydev;
+	int ret = 0;
 
 	phydev = phy_connect(priv->bus, -1, dev, pdata->phy_interface);
 	if (!phydev)
@@ -614,40 +591,38 @@ static int sh_ether_start(struct udevice *dev)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
+	struct sh_eth_info *port_info = &priv->port_info;
 	int ret;
 
-	ret = sh_eth_init_common(eth, pdata->enetaddr);
+	ret = sh_eth_init_common(port_info, pdata->enetaddr);
 	if (ret)
 		return ret;
 
-	ret = sh_eth_start_common(eth);
+	ret = sh_eth_start_common(port_info);
 	if (ret)
 		goto err_start;
 
 	return 0;
 
 err_start:
-	sh_eth_tx_desc_free(eth);
-	sh_eth_rx_desc_free(eth);
+	sh_eth_tx_desc_free(port_info);
+	sh_eth_rx_desc_free(port_info);
 	return ret;
 }
 
 static void sh_ether_stop(struct udevice *dev)
 {
 	struct sh_ether_priv *priv = dev_get_priv(dev);
-	struct sh_eth_dev *eth = &priv->shdev;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = &priv->port_info;
 
 	phy_shutdown(port_info->phydev);
-	sh_eth_stop(&priv->shdev);
+	sh_eth_stop(port_info);
 }
 
 /******* for bb_miiphy *******/
 static int sh_eth_bb_mdio_active(struct mii_dev *miidev)
 {
-	struct sh_eth_dev *eth = miidev->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = miidev->priv;
 
 	sh_eth_write(port_info, sh_eth_read(port_info, PIR) | PIR_MMD, PIR);
 
@@ -656,8 +631,7 @@ static int sh_eth_bb_mdio_active(struct mii_dev *miidev)
 
 static int sh_eth_bb_mdio_tristate(struct mii_dev *miidev)
 {
-	struct sh_eth_dev *eth = miidev->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = miidev->priv;
 
 	sh_eth_write(port_info, sh_eth_read(port_info, PIR) & ~PIR_MMD, PIR);
 
@@ -666,8 +640,7 @@ static int sh_eth_bb_mdio_tristate(struct mii_dev *miidev)
 
 static int sh_eth_bb_set_mdio(struct mii_dev *miidev, int v)
 {
-	struct sh_eth_dev *eth = miidev->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = miidev->priv;
 
 	if (v)
 		sh_eth_write(port_info,
@@ -681,8 +654,7 @@ static int sh_eth_bb_set_mdio(struct mii_dev *miidev, int v)
 
 static int sh_eth_bb_get_mdio(struct mii_dev *miidev, int *v)
 {
-	struct sh_eth_dev *eth = miidev->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = miidev->priv;
 
 	*v = (sh_eth_read(port_info, PIR) & PIR_MDI) >> 3;
 
@@ -691,8 +663,7 @@ static int sh_eth_bb_get_mdio(struct mii_dev *miidev, int *v)
 
 static int sh_eth_bb_set_mdc(struct mii_dev *miidev, int v)
 {
-	struct sh_eth_dev *eth = miidev->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = miidev->priv;
 
 	if (v)
 		sh_eth_write(port_info,
@@ -738,7 +709,7 @@ static int sh_ether_probe(struct udevice *udev)
 {
 	struct eth_pdata *pdata = dev_get_plat(udev);
 	struct sh_ether_priv *priv = dev_get_priv(udev);
-	struct sh_eth_dev *eth = &priv->shdev;
+	struct sh_eth_info *port_info = &priv->port_info;
 	struct mii_dev *mdiodev;
 	int ret;
 
@@ -757,7 +728,7 @@ static int sh_ether_probe(struct udevice *udev)
 
 	mdiodev->read = sh_eth_bb_miiphy_read;
 	mdiodev->write = sh_eth_bb_miiphy_write;
-	mdiodev->priv = eth;
+	mdiodev->priv = port_info;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	ret = mdio_register(mdiodev);
@@ -766,10 +737,8 @@ static int sh_ether_probe(struct udevice *udev)
 
 	priv->bus = mdiodev;
 
-	eth->port = CFG_SH_ETHER_USE_PORT;
-	eth->port_info[eth->port].phy_addr = CFG_SH_ETHER_PHY_ADDR;
-	eth->port_info[eth->port].iobase =
-		(void __iomem *)(uintptr_t)(BASE_IO_ADDR + 0x800 * eth->port);
+	port_info->phy_addr = CFG_SH_ETHER_PHY_ADDR;
+	port_info->iobase = (void __iomem *)(uintptr_t)BASE_IO_ADDR;
 
 #if CONFIG_IS_ENABLED(CLK)
 	ret = clk_enable(&priv->clk);
@@ -777,7 +746,7 @@ static int sh_ether_probe(struct udevice *udev)
 		goto err_mdio_register;
 #endif
 
-	ret = sh_eth_init_common(eth, pdata->enetaddr);
+	ret = sh_eth_init_common(port_info, pdata->enetaddr);
 	if (ret)
 		goto err_phy_config;
 
@@ -801,8 +770,7 @@ err_mdio_register:
 static int sh_ether_remove(struct udevice *udev)
 {
 	struct sh_ether_priv *priv = dev_get_priv(udev);
-	struct sh_eth_dev *eth = &priv->shdev;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+	struct sh_eth_info *port_info = &priv->port_info;
 
 #if CONFIG_IS_ENABLED(CLK)
 	clk_disable(&priv->clk);
diff --git a/drivers/net/sh_eth.h b/drivers/net/sh_eth.h
index ecf4a697e27..6b7f8ae5154 100644
--- a/drivers/net/sh_eth.h
+++ b/drivers/net/sh_eth.h
@@ -33,9 +33,6 @@
 #define CFG_SH_ETHER_ALIGNE_SIZE 16
 #endif
 
-/* Number of supported ports */
-#define MAX_PORT_NUM	2
-
 /* Buffers must be big enough to hold the largest ethernet frame. Also, rx
    buffers must be a multiple of 32 bytes */
 #define MAX_BUF_SIZE	(48 * 32)
@@ -90,11 +87,6 @@ struct sh_eth_info {
 	void __iomem *iobase;
 };
 
-struct sh_eth_dev {
-	int port;
-	struct sh_eth_info port_info[MAX_PORT_NUM];
-};
-
 /* from linux/drivers/net/ethernet/renesas/sh_eth.h */
 enum {
 	/* E-DMAC registers */
-- 
2.47.2

