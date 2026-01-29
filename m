Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F73AD73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 21:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B285F84113;
	Thu, 29 Jan 2026 22:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dBjqrNYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A818D84114; Thu, 29 Jan 2026 22:02:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705A984113
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 22:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769720538; bh=XARPRlW9Rq6fWqU+jFohSp3mdtnraHUEmLP3thgp1lM=;
 b=dBjqrNYX6hBk64755gMa8WbIKeHZZbGMZibn29c1SiUzVgGc5GmSI1Z6IsR0kh0zYMm/VjiU4
 GNw6NM/q3vQ+77qWHbCkOUjnGG4C6Dsh1x9i1QlvjWuvo74PXkS3xi3SC2Hx3jIp1cAweW2s2GW
 WJ2QmeGgKL6qkND8gA30FeeNNk0Y2bcb+rviQmCGkTxk6G8ap1U4NVEEmMBo48bwJrN/fmvYlZE
 41KGe7XWUQB3GNUQfPz2OetIXA2Wp/izaV6PW+AJj8RDVCrsEMaUmXul+wL+JtF2pCNamZK/3tA
 ddLqFGJutIQQVvzN2wShctrOJXpg0qjybJdvV6mlL8Wg==
X-Forward-Email-ID: 697bcad88bac728cb531c6d6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/4] net: dwc_eth_qos: Start DMA and MAC after tail pointers
 are initialized
Date: Thu, 29 Jan 2026 21:01:51 +0000
Message-ID: <20260129210159.2279888-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210159.2279888-1-jonas@kwiboo.se>
References: <20260129210159.2279888-1-jonas@kwiboo.se>
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

The DesignWare Cores Ethernet Quality-of-Service databook state that
receive and transmit descriptor list address and also transmit and
receive tail pointer registers should be initialized before the receive
and transmit DMAs are started.

It also state to enable the MAC receiver only after the DMA is active.
Otherwise, received frames can fill the Rx FIFO and overflow.

Move the activation of receive and transmit DMA and MAC receiver until
after tail pointer registers have been initialized.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 08332210afb4..b104d4e47255 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1003,14 +1003,6 @@ static int eqos_start(struct udevice *dev)
 	writel(EQOS_DESCRIPTORS_RX - 1,
 	       &eqos->dma_regs->ch0_rxdesc_ring_length);
 
-	/* Enable everything */
-	setbits_le32(&eqos->dma_regs->ch0_tx_control,
-		     EQOS_DMA_CH0_TX_CONTROL_ST);
-	setbits_le32(&eqos->dma_regs->ch0_rx_control,
-		     EQOS_DMA_CH0_RX_CONTROL_SR);
-	setbits_le32(&eqos->mac_regs->configuration,
-		     EQOS_MAC_CONFIGURATION_TE | EQOS_MAC_CONFIGURATION_RE);
-
 	/*
 	 * Point TX tail pointer at the first descriptor, implying no descriptor
 	 * are owned by the DMA. We advance the tail pointer when we need to TX
@@ -1026,6 +1018,14 @@ static int eqos_start(struct udevice *dev)
 	addr64 = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
 	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_tail_pointer);
 
+	/* Enable everything */
+	setbits_le32(&eqos->dma_regs->ch0_tx_control,
+		     EQOS_DMA_CH0_TX_CONTROL_ST);
+	setbits_le32(&eqos->dma_regs->ch0_rx_control,
+		     EQOS_DMA_CH0_RX_CONTROL_SR);
+	setbits_le32(&eqos->mac_regs->configuration,
+		     EQOS_MAC_CONFIGURATION_TE | EQOS_MAC_CONFIGURATION_RE);
+
 	eqos->started = true;
 
 	debug("%s: OK\n", __func__);
-- 
2.52.0

