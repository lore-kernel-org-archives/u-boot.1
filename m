Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E92F54AD6
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 01:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96E28352B;
	Wed, 25 Mar 2026 02:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sSLHYIQ4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RO3Dw4DU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0893283A91; Wed, 25 Mar 2026 02:11:27 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A393B81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fgTPm1cy8z9tvd;
 Wed, 25 Mar 2026 02:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774401084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n+B80JOCxb4B85qiKEuMosQJwGqMyVUP0K8cWoxNQyI=;
 b=sSLHYIQ4rL2I83efUd+MoOaLq7RA2b6G+ORjvAtgEr6YeJ2cesZRx9+w/GG/j/QBj2gWuI
 HEzhuW0B8TK++j5Ojv6fxxN4F1L6W0UhVTg3UQzcjJ137zap+JOG6vEpZ2uWUOIt2z2ZRD
 YHnTI4PHEuiF1E+fTQVq6ppj9VRLLW2sPvdpknxaXr/KnLfSUggRQ50akAVPv/TXoedPxM
 SlhkZi1nNntaB/ch+0Dk+8zck2EO1E1a+qDvZJ4Fqf/Orw/R9Xw93ha3fi12ulHRo/mkCh
 CdCkGTzLsIw3yXPOTAm1GUGdDnl4Xcej7TZ/iGYACfcr3bf9cFV4kr7j+xcd1w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774401082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n+B80JOCxb4B85qiKEuMosQJwGqMyVUP0K8cWoxNQyI=;
 b=RO3Dw4DUtYCkah2JqJHQxRyBMfHhaDTY5HsyMfoc+hjAdrlTjeMjCZ7xnxXR/Pramh2Vea
 awLu2k+x/2kF/9u/q4DdLeqcvNt1L8qShC73jkbre56L3+s6LliSCPeucBkFrY0BS/cYJJ
 9ZJR+FiNODectms3NLOz3Dq+oMW3zwRBcZLhpVmaXIdOLDKVCeZCLDBM5vcJ6SUZs9XzOt
 kaCCoW4JFfjGCsDq3JzR3y1esakPIhKOH19iy+75m5vIIc7YXj57tiGyeCNV4M/O0g/o9v
 CUavpXfspIn6/tw0kVLFqTJ9/4XTCjRfcAsbqV3TpJj5zrEcWo/MbJWKy5dk/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Phong Hoang <phong.hoang.wz@renesas.com>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: rswitch: Remap CPU to bus addresses using
 dev_phys_to_bus()
Date: Wed, 25 Mar 2026 02:10:43 +0100
Message-ID: <20260325011119.287660-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 888a15918140ea98528
X-MBO-RS-META: yiyy3dkne1ccdryuxjctcdjfbcixfptb
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

Use dev_phys_to_bus() to convert CPU addresses of DMA descriptors
into bus addresses of DMA descriptors. This is necessary on hardware
which does not have 1:1 mapping between CPU and memory addressed by
the DMA. This has no impact on other hardware which does not need
this conversion.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Phong Hoang <phong.hoang.wz@renesas.com>
Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
Cc: Thanh Quan <thanh.quan.xn@renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 80 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index c51908ed8f3..52fc3edd4e0 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -9,6 +9,7 @@
 
 #include <asm/io.h>
 #include <clk.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
@@ -23,6 +24,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <miiphy.h>
+#include <phys2bus.h>
 
 #define RSWITCH_SLEEP_US	1000
 #define RSWITCH_TIMEOUT_US	1000000
@@ -587,9 +589,11 @@ static void rswitch_bat_desc_init(struct rswitch_port_priv *priv)
 	rswitch_flush_dcache((uintptr_t)priv->bat_desc, desc_size);
 }
 
-static void rswitch_tx_desc_init(struct rswitch_port_priv *priv)
+static void rswitch_tx_desc_init(struct udevice *dev)
 {
+	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	const u32 desc_size = RSWITCH_NUM_TX_DESC * sizeof(struct rswitch_desc);
+	dma_addr_t tx_desc_ba;
 	u64 tx_desc_addr;
 	int i;
 
@@ -603,21 +607,25 @@ static void rswitch_tx_desc_init(struct rswitch_port_priv *priv)
 	/* Mark the end of the descriptors */
 	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].die_dt = DT_LINKFIX;
 	tx_desc_addr = (uintptr_t)priv->tx_desc;
-	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrl = lower_32_bits(tx_desc_addr);
-	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrh = upper_32_bits(tx_desc_addr);
+	tx_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)tx_desc_addr);
+
+	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrl = lower_32_bits(tx_desc_ba);
+	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrh = upper_32_bits(tx_desc_ba);
 	rswitch_flush_dcache(tx_desc_addr, desc_size);
 
 	/* Point the controller to the TX descriptor list */
 	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].die_dt = DT_LINKFIX;
-	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrl = lower_32_bits(tx_desc_addr);
-	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrh = upper_32_bits(tx_desc_addr);
+	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrl = lower_32_bits(tx_desc_ba);
+	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrh = upper_32_bits(tx_desc_ba);
 	rswitch_flush_dcache((uintptr_t)&priv->bat_desc[RSWITCH_TX_CHAIN_INDEX],
 			     sizeof(struct rswitch_desc));
 }
 
-static void rswitch_rx_desc_init(struct rswitch_port_priv *priv)
+static void rswitch_rx_desc_init(struct udevice *dev)
 {
+	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	const u32 desc_size = RSWITCH_NUM_RX_DESC * sizeof(struct rswitch_rxdesc);
+	dma_addr_t packet_ba, next_rx_desc_ba, rx_desc_ba;
 	int i;
 	u64 packet_addr;
 	u64 next_rx_desc_addr;
@@ -631,26 +639,29 @@ static void rswitch_rx_desc_init(struct rswitch_port_priv *priv)
 		priv->rx_desc[i].data.die_dt = DT_FEMPTY;
 		priv->rx_desc[i].data.info_ds = PKTSIZE_ALIGN;
 		packet_addr = (uintptr_t)priv->rx_desc[i].packet;
-		priv->rx_desc[i].data.dptrl = lower_32_bits(packet_addr);
-		priv->rx_desc[i].data.dptrh = upper_32_bits(packet_addr);
+		packet_ba = dev_phys_to_bus(dev, (phys_addr_t)packet_addr);
+		priv->rx_desc[i].data.dptrl = lower_32_bits(packet_ba);
+		priv->rx_desc[i].data.dptrh = upper_32_bits(packet_ba);
 
 		priv->rx_desc[i].link.die_dt = DT_LINKFIX;
 		next_rx_desc_addr = (uintptr_t)&priv->rx_desc[i + 1];
-		priv->rx_desc[i].link.dptrl = lower_32_bits(next_rx_desc_addr);
-		priv->rx_desc[i].link.dptrh = upper_32_bits(next_rx_desc_addr);
+		next_rx_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)next_rx_desc_addr);
+		priv->rx_desc[i].link.dptrl = lower_32_bits(next_rx_desc_ba);
+		priv->rx_desc[i].link.dptrh = upper_32_bits(next_rx_desc_ba);
 	}
 
 	/* Mark the end of the descriptors */
 	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.die_dt = DT_LINKFIX;
 	rx_desc_addr = (uintptr_t)priv->rx_desc;
-	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrl = lower_32_bits(rx_desc_addr);
-	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrh = upper_32_bits(rx_desc_addr);
+	rx_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)rx_desc_addr);
+	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrl = lower_32_bits(rx_desc_ba);
+	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrh = upper_32_bits(rx_desc_ba);
 	rswitch_flush_dcache(rx_desc_addr, desc_size);
 
 	/* Point the controller to the rx descriptor list */
 	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].die_dt = DT_LINKFIX;
-	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrl = lower_32_bits(rx_desc_addr);
-	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrh = upper_32_bits(rx_desc_addr);
+	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrl = lower_32_bits(rx_desc_ba);
+	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrh = upper_32_bits(rx_desc_ba);
 	rswitch_flush_dcache((uintptr_t)&priv->bat_desc[RSWITCH_RX_CHAIN_INDEX],
 			     sizeof(struct rswitch_desc));
 }
@@ -741,9 +752,11 @@ static int rswitch_gwca_axi_ram_reset(struct rswitch_gwca *gwca)
 					RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
 }
 
-static int rswitch_gwca_init(struct rswitch_port_priv *priv)
+static int rswitch_gwca_init(struct udevice *dev)
 {
+	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	struct rswitch_gwca *gwca = &priv->gwca;
+	dma_addr_t bat_desc_ba;
 	int ret;
 
 	ret = rswitch_gwca_change_mode(priv, GWMC_OPC_DISABLE);
@@ -765,9 +778,11 @@ static int rswitch_gwca_init(struct rswitch_port_priv *priv)
 	/* Setting flow */
 	writel(GWVCC_VEM_SC_TAG, gwca->addr + GWVCC);
 	writel(0, gwca->addr + GWTTFC);
-	writel(upper_32_bits((uintptr_t)priv->bat_desc) & GWDCBAC0_DCBAUP,
+
+	bat_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)(priv->bat_desc));
+	writel(upper_32_bits(bat_desc_ba) & GWDCBAC0_DCBAUP,
 	       gwca->addr + GWDCBAC0 + priv->drv_data->gwdcbac_offset);
-	writel(lower_32_bits((uintptr_t)priv->bat_desc),
+	writel(lower_32_bits(bat_desc_ba),
 	       gwca->addr + GWDCBAC1 + priv->drv_data->gwdcbac_offset);
 	writel(GWDCC_DQT | GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_TX_CHAIN_INDEX));
 	writel(GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_RX_CHAIN_INDEX));
@@ -844,8 +859,9 @@ static int rswitch_etha_init(struct rswitch_port_priv *priv)
 	return 0;
 }
 
-static int rswitch_init(struct rswitch_port_priv *priv)
+static int rswitch_start(struct udevice *dev)
 {
+	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	struct rswitch_etha *etha = &priv->etha;
 	int ret;
 
@@ -875,8 +891,8 @@ static int rswitch_init(struct rswitch_port_priv *priv)
 		return ret;
 
 	rswitch_bat_desc_init(priv);
-	rswitch_tx_desc_init(priv);
-	rswitch_rx_desc_init(priv);
+	rswitch_tx_desc_init(dev);
+	rswitch_rx_desc_init(dev);
 
 	rswitch_clock_enable(priv);
 
@@ -886,7 +902,7 @@ static int rswitch_init(struct rswitch_port_priv *priv)
 
 	rswitch_mfwd_init(priv);
 
-	ret = rswitch_gwca_init(priv);
+	ret = rswitch_gwca_init(dev);
 	if (ret)
 		return ret;
 
@@ -897,23 +913,12 @@ static int rswitch_init(struct rswitch_port_priv *priv)
 	return 0;
 }
 
-static int rswitch_start(struct udevice *dev)
-{
-	struct rswitch_port_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = rswitch_init(priv);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 #define RSWITCH_TX_TIMEOUT_MS	1000
 static int rswitch_send(struct udevice *dev, void *packet, int len)
 {
 	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	struct rswitch_desc *desc = &priv->tx_desc[priv->tx_desc_index];
+	dma_addr_t bpacket = dev_phys_to_bus(dev, (phys_addr_t)packet);
 	struct rswitch_gwca *gwca = &priv->gwca;
 	u32 gwtrc_index, start;
 
@@ -923,8 +928,8 @@ static int rswitch_send(struct udevice *dev, void *packet, int len)
 	memset(desc, 0x0, sizeof(*desc));
 	desc->die_dt = DT_FSINGLE;
 	desc->info_ds = len;
-	desc->dptrl = lower_32_bits((uintptr_t)packet);
-	desc->dptrh = upper_32_bits((uintptr_t)packet);
+	desc->dptrl = lower_32_bits(bpacket);
+	desc->dptrh = upper_32_bits(bpacket);
 	rswitch_flush_dcache((uintptr_t)desc, sizeof(*desc));
 
 	/* Start transmission */
@@ -954,6 +959,7 @@ static int rswitch_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct rswitch_port_priv *priv = dev_get_priv(dev);
 	struct rswitch_rxdesc *desc = &priv->rx_desc[priv->rx_desc_index];
+	dma_addr_t dpacket;
 	u8 *packet;
 	int len;
 
@@ -963,7 +969,9 @@ static int rswitch_recv(struct udevice *dev, int flags, uchar **packetp)
 		return -EAGAIN;
 
 	len = desc->data.info_ds & RX_DS;
-	packet = (u8 *)(((uintptr_t)(desc->data.dptrh) << 32) | (uintptr_t)desc->data.dptrl);
+	dpacket = ((u64)(desc->data.dptrh) << 32) | (u64)(desc->data.dptrl);
+	packet = (u8 *)(uintptr_t)dev_bus_to_phys(dev, dpacket);
+
 	rswitch_invalidate_dcache((uintptr_t)packet, len);
 
 	*packetp = packet;
-- 
2.53.0

