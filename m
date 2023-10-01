Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A339E78482
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B23870DC;
	Sun,  1 Oct 2023 21:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Y6sQfhUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECF1870CE; Sun,  1 Oct 2023 21:17:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B41870D0
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696187859; bh=HyUXCZEuCQ5MhKqG4Z1J5nKwfDLiDr0XP3nA0DKVrAQ=;
 b=Y6sQfhUZ7mUstabCrI05XHoGqJG/LFtgcsT+jw96zxcoGn2YJ+TFWeEtDmZH9oti67uXe+82/
 rWq8mlIqparFlccrSfOCw2L0jCpT1Gbjpwl/pG0m8TvY/QXZiPPTdFLjwspI442VJ0PO/KkLt/k
 Mq+aJj9MSE9/rAvmPXKkkaTnnyUq3FasmYkIA448B4mxlmlUnut1wL8nrclB/UNtB2qMWUIvxTH
 fvXTDztQRcfafWuwGSjUbU6w50IfnTAVoj/G3OvASQi7d5hl39H24MyyTdgNmVKYanvz+CEDjV6
 lu17M7Maambaxy/gY0jpC1I/t+3/bBNQGuNhiNKUCiiA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: David Wu <david.wu@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/7] net: dwc_eth_qos: Drop unused rx_pkt from eqos_priv
Date: Sun,  1 Oct 2023 19:17:16 +0000
Message-ID: <20231001191730.4167035-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001191730.4167035-1-jonas@kwiboo.se>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6519c5d325909c3c56c79d89
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

rx_pkt is allocated and not used for anything, remove it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag

 drivers/net/dwc_eth_qos.c | 11 -----------
 drivers/net/dwc_eth_qos.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 1e92bd9ca9c0..555eaee3bbc3 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1314,22 +1314,12 @@ static int eqos_probe_resources_core(struct udevice *dev)
 	}
 	debug("%s: rx_dma_buf=%p\n", __func__, eqos->rx_dma_buf);
 
-	eqos->rx_pkt = malloc(EQOS_MAX_PACKET_SIZE);
-	if (!eqos->rx_pkt) {
-		debug("%s: malloc(rx_pkt) failed\n", __func__);
-		ret = -ENOMEM;
-		goto err_free_rx_dma_buf;
-	}
-	debug("%s: rx_pkt=%p\n", __func__, eqos->rx_pkt);
-
 	eqos->config->ops->eqos_inval_buffer(eqos->rx_dma_buf,
 			EQOS_MAX_PACKET_SIZE * EQOS_DESCRIPTORS_RX);
 
 	debug("%s: OK\n", __func__);
 	return 0;
 
-err_free_rx_dma_buf:
-	free(eqos->rx_dma_buf);
 err_free_tx_dma_buf:
 	free(eqos->tx_dma_buf);
 err_free_descs:
@@ -1348,7 +1338,6 @@ static int eqos_remove_resources_core(struct udevice *dev)
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
-	free(eqos->rx_pkt);
 	free(eqos->rx_dma_buf);
 	free(eqos->tx_dma_buf);
 	eqos_free_descs(eqos->rx_descs);
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index a6b719af809f..06a082da72ef 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -273,7 +273,6 @@ struct eqos_priv {
 	unsigned int desc_per_cacheline;
 	void *tx_dma_buf;
 	void *rx_dma_buf;
-	void *rx_pkt;
 	bool started;
 	bool reg_access_ok;
 	bool clk_ck_enabled;
-- 
2.42.0

