Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECC6D73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 21:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A0C8410B;
	Thu, 29 Jan 2026 22:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="P1K516GM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC1C8410B; Thu, 29 Jan 2026 22:02:17 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F8A84105
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 22:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769720533; bh=EijAnNR3AYgaz4bq8v4hhcGW0v9av1TRaW5tArA78fI=;
 b=P1K516GMiOXIKZTOuuaEe0P/I5CF9+QNIWWxqUppEquo+HvJUS3uYaSTR7O1hRn1WkkY0hrqJ
 gcliimog3n/qGafQYuHRfh2NN0t1kNgL4Iyd+pZpKqsEWLo94YMR6BgBK1ctJNFsspndOYehYf5
 0M+lBjDocEyg4FM+DrPsMGa62p4wzRQtXalAaAqvT4P4IC+EUx9eHiXA/BrZLYiYzH+6LlQUMfz
 v2Eazj//Z3VtBXj+IwV2e0AyWtb/YeKswyLhnoc+wmgfy6gkbH0k6Mf2A9mAihlYgnhEcCKpSBQ
 cd4OYMaupdJNWXwrU+rPl4/VvYAd0/mgAevYHPKFtOPg==
X-Forward-Email-ID: 697bcad18bac728cb531c69e
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
Subject: [PATCH 1/4] net: dwc_eth_qos: Use lower_32_bits() for tail pointers
Date: Thu, 29 Jan 2026 21:01:49 +0000
Message-ID: <20260129210159.2279888-2-jonas@kwiboo.se>
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

The DesignWare Cores Ethernet Quality-of-Service databook state that the
descriptor address from the start to the end of the ring must not cross
the 4GB boundary.

Use lower_32_bits() to write the lower 32 bits of descriptor addresses,
including the 32-bit tail pointers, consistently. No functional change
is intended.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 551ee0ea6a02..74cdaa27644f 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -683,7 +683,6 @@ static int eqos_start(struct udevice *dev)
 	int ret, i;
 	ulong rate;
 	u32 val, tx_fifo_sz, rx_fifo_sz, tqs, rqs, pbl;
-	ulong last_rx_desc;
 	ulong desc_pad;
 	ulong addr64;
 
@@ -1019,8 +1018,8 @@ static int eqos_start(struct udevice *dev)
 	 * that's not distinguishable from none of the descriptors being
 	 * available.
 	 */
-	last_rx_desc = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
-	writel(last_rx_desc, &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+	addr64 = (ulong)eqos_get_desc(eqos, EQOS_DESCRIPTORS_RX - 1, true);
+	writel(lower_32_bits(addr64), &eqos->dma_regs->ch0_rxdesc_tail_pointer);
 
 	eqos->started = true;
 
@@ -1116,8 +1115,8 @@ static int eqos_send(struct udevice *dev, void *packet, int length)
 	tx_desc->des3 = EQOS_DESC3_OWN | EQOS_DESC3_FD | EQOS_DESC3_LD | length;
 	eqos->config->ops->eqos_flush_desc(tx_desc);
 
-	writel((ulong)eqos_get_desc(eqos, eqos->tx_desc_idx, false),
-		&eqos->dma_regs->ch0_txdesc_tail_pointer);
+	writel(lower_32_bits((ulong)eqos_get_desc(eqos, eqos->tx_desc_idx, false)),
+	       &eqos->dma_regs->ch0_txdesc_tail_pointer);
 
 	for (i = 0; i < 1000000; i++) {
 		eqos->config->ops->eqos_inval_desc(tx_desc);
@@ -1198,7 +1197,8 @@ static int eqos_free_pkt(struct udevice *dev, uchar *packet, int length)
 			rx_desc->des3 = EQOS_DESC3_OWN | EQOS_DESC3_BUF1V;
 			eqos->config->ops->eqos_flush_desc(rx_desc);
 		}
-		writel((ulong)rx_desc, &eqos->dma_regs->ch0_rxdesc_tail_pointer);
+		writel(lower_32_bits((ulong)rx_desc),
+		       &eqos->dma_regs->ch0_rxdesc_tail_pointer);
 	}
 
 	eqos->rx_desc_idx++;
-- 
2.52.0

