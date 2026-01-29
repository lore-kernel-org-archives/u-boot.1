Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA4BD73E89
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 21:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7D784120;
	Thu, 29 Jan 2026 22:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kv+k3R3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B2884105; Thu, 29 Jan 2026 22:02:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B912984118
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 22:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769720539; bh=AVMUxlzGjwbyyN8dyC6Rb4uJxlaW/oBHwDLu6vWlh+Q=;
 b=kv+k3R3UX4MC24sIh+vWclOEdxiTwec0ZZqKhgbDJeOlR1aSOHobflsGcA7a6bbIQSXnr1pGu
 D1kbEktueejsiRVWm7tke0ID0VnAPo1p52bQJleU4FLJscNjUeKiW/1PM1nfV7N0wbGEgZ+gcU1
 y8kSKp27Gx+dpG+48Y8dLKUOo6t3lKFHgqYNS3Sn+sWkM53RvLWkWnXGQ6tKQlm3vqbL7n8cSrd
 FXv+Fklod4p2eizdVGilimyYHOApjP7VIavnq1xJh3k4uvxv/saBFTc9bXJ5b3+xApgCM2vTKL1
 nClobMyzCsQ2mkf+yebYaw8lvxX3ursWi8F0uDZvBNpQ==
X-Forward-Email-ID: 697bcad48bac728cb531c6bb
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
Subject: [PATCH 2/4] net: dwc_eth_qos: Initialize the transmit tail pointer in
 eqos_start()
Date: Thu, 29 Jan 2026 21:01:50 +0000
Message-ID: <20260129210159.2279888-3-jonas@kwiboo.se>
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
descriptors up to one location less than the one indicated by the
descriptor tail pointer are owned by the DMA. The DMA continues to
process the descriptors until the following condition occurs:

  Current Descriptor Pointer == Descriptor Tail Pointer

The DMA goes into suspend mode when this condition occurs, and updating
the tail pointer resume the DMA processing.

Configure the transmit tail pointer to the first (current) descriptor
pointer so that the tail pointer is a valid address instead of being
initialized to NULL when transmit DMA is started.

Also update the receive tail pointer comment to state that by pointing
to the last descriptor we are actually implying that all receive
descriptors are owned by and can be processed by the DMA.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 74cdaa27644f..08332210afb4 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1011,12 +1011,17 @@ static int eqos_start(struct udevice *dev)
 	setbits_le32(&eqos->mac_regs->configuration,
 		     EQOS_MAC_CONFIGURATION_TE | EQOS_MAC_CONFIGURATION_RE);
 
-	/* TX tail pointer not written until we need to TX a packet */
 	/*
-	 * Point RX tail pointer at last descriptor. Ideally, we'd point at the
-	 * first descriptor, implying all descriptors were available. However,
-	 * that's not distinguishable from none of the descriptors being
-	 * available.
+	 * Point TX tail pointer at the first descriptor, implying no descriptor
+	 * are owned by the DMA. We advance the tail pointer when we need to TX
+	 * a packet in eqos_send().
+	 */
+	addr64 = (ulong)eqos_get_desc(eqos, 0, false);
+	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_txdesc_tail_pointer);
+
+	/*
+	 * Point RX tail pointer at the last descriptor, implying all
+	 * descriptors are owned by the DMA.
 	 */
 	addr64 = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
 	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_tail_pointer);
-- 
2.52.0

