Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4479EC021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 13:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE06801B0;
	Sat, 22 Feb 2025 14:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sima.ai header.i=@sima.ai header.b="aS8K2Jxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F52B80548; Sat, 22 Feb 2025 07:07:42 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4165800C1
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 07:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikunj.kela@sima.ai
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2217875d103so6601015ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 22:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sima.ai; s=google; t=1740204458; x=1740809258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JvJYBT4rxeJQB6pcp0IL8Irhv5LEtsu5QMQJG5DDlOQ=;
 b=aS8K2JxgOIR/3XBGg/X8d7eFXI0R2lxvda6OREcvyPu1jlbQ25Ifa5hAlhaDut6JLE
 Z+G6DLXl4ytNkOYHWCGPWRSVyHlIYYHvgr+JVFfaq3iWKdly9u83/FoH2OwUzzHLCT1G
 jz+t+TI1VwxEEKeZatOF0cufY7zZmfnbobrai6oGsXxKkIxQe6yIYfmM5TjItonKUWG4
 v8C05y/uQTyKzUMgtH0SeVcw9p79fWRWWijA8B+d03NdoR/cppqz51UwdCEol/2RwvrA
 rlCWiYbGiI7uXaREQtR9OpJbL1tgpoB31m7Xf+9vBA9GXpjh+HcSgmU0+JpSfw+LlRVR
 BgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740204458; x=1740809258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvJYBT4rxeJQB6pcp0IL8Irhv5LEtsu5QMQJG5DDlOQ=;
 b=U9W4qyikJGP+mvcO6Vb7Nqd1v2eFQWZGXoFutD5S2ar+n5kszWxfq2RldBiweVbaiH
 TVbN5lycQBWoAeOp5jc4IkC04mPtHpF7HXziDxItNDTKQEfcMxug1YsRmcnXrHD/dZec
 oLtpa0EsRwAt1j1AfkaOntDAXT92UAU41yWvduzhylCJorr/rruoNvUPiEKaLIT0qvRF
 jJIEaKMrmunrKbaG9N6sI0YT5pW7hc5ANFGBCigG6wyLN148bvDdEm5oef4ISNl1EdqT
 m53O/sZG13BbZm4pa4KMpFRsxfpxqYQLI6uddsZPctndwCysO34ZO3NDi6+0XOWnbMKQ
 5fGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMeHlXW3Jt2Urqor5Kd7x2Ru5USKlTKO+GZaDb8RFCfN0big7dxSXzOzpX/AQoCHTddU+iJXo=@lists.denx.de
X-Gm-Message-State: AOJu0YzZFHzT2IqFpb5AFvSaQpMVOjtf9ldFTfOUPdYTITxRL64EIzXE
 vQMiqIhNm9qbOqcvIy3GZoQtYSGuu4kiJCuZxOksinsGbO7rawha2ktF6glwce0=
X-Gm-Gg: ASbGncuN0wFefCujEAPs4gC7ee69KClYVee8AdHbi7iVnQWy+Qz/AL05H8YLJiUw0Ey
 zvo8shWbZII2eXjeVcbARaD2rBnZ+G3M0xx04jdIVD9HIRc/NE3UupQbX/w/xDH0m5zJbHz0qq0
 4Anip0xCKCniY2oedcTacjBNstlBbsfYQ/ZdqYPsCzMIqSrNnGz9kTSRPpWgJghMQLESNI8yRKL
 RjO6rzAHmH7AEOVkrWgp8qVXXTT0TXqY7dz5tuxpi29FUjxfDpZlnyXcSv9uoYGmyuev0oYQU1L
 5Kh9AMR02YmDoFv1dq5Kr1fTLkYe7zaYM97B9zpt3TUe
X-Google-Smtp-Source: AGHT+IHA1zZQmMpBmJdaBFhF6M8ncP4gr98xHYfSLktL3wnG/v99Z0YR26QMqez6GAOUvCEW2YS+gA==
X-Received: by 2002:a17:902:d488:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-2219ff4e328mr34924105ad.1.1740204458286; 
 Fri, 21 Feb 2025 22:07:38 -0800 (PST)
Received: from nikunj-kela-u22.eng.sima.ai ([205.234.21.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d559089asm145612545ad.241.2025.02.21.22.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 22:07:37 -0800 (PST)
From: Nikunj Kela <nikunj.kela@sima.ai>
To: joe.hershberger@ni.com,
	rfried.dev@gmail.com
Cc: trini@konsulko.com, boon.khai.ng@intel.com, tien.fong.chee@intel.com,
 u-boot@lists.denx.de, Nikunj Kela <nikunj.kela@sima.ai>
Subject: [PATCH] net: dwc: xgmac: Allow DMA buffers above 4GB
Date: Fri, 21 Feb 2025 22:07:34 -0800
Message-Id: <20250222060734.1367838-1-nikunj.kela@sima.ai>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 22 Feb 2025 14:14:11 +0100
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

Currently, Synopsis xgmac driver only works if DMA region is under 4GB.
This change enables the DMA buffers allocations above 4GB memory
regions.

Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
---
 drivers/net/dwc_eth_xgmac.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index cf8227b1b4d..03959ea95a5 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -45,6 +45,7 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
 #include "dwc_eth_xgmac.h"
 
 static void *xgmac_alloc_descs(struct xgmac_priv *xgmac, unsigned int num)
@@ -457,7 +458,7 @@ static int xgmac_start(struct udevice *dev)
 	int ret, i;
 	u32 val, tx_fifo_sz, rx_fifo_sz, tqs, rqs, pbl;
 	ulong last_rx_desc;
-	ulong desc_pad;
+	ulong desc_pad, address;
 
 	struct xgmac_desc *tx_desc = NULL;
 	struct xgmac_desc *rx_desc = NULL;
@@ -702,8 +703,11 @@ static int xgmac_start(struct udevice *dev)
 	for (i = 0; i < XGMAC_DESCRIPTORS_RX; i++) {
 		rx_desc = (struct xgmac_desc *)xgmac_get_desc(xgmac, i, true);
 
-		rx_desc->des0 = (uintptr_t)(xgmac->rx_dma_buf +
-					    (i * XGMAC_MAX_PACKET_SIZE));
+		address = (uintptr_t)(xgmac->rx_dma_buf +
+					(i * XGMAC_MAX_PACKET_SIZE));
+
+		rx_desc->des0 = lower_32_bits(address);
+		rx_desc->des1 = upper_32_bits(address);
 		rx_desc->des3 = XGMAC_DESC3_OWN;
 		/* Flush the cache to the memory */
 		mb();
@@ -713,13 +717,17 @@ static int xgmac_start(struct udevice *dev)
 						       XGMAC_MAX_PACKET_SIZE);
 	}
 
-	writel(0, &xgmac->dma_regs->ch0_txdesc_list_haddress);
-	writel((ulong)xgmac_get_desc(xgmac, 0, false),
+	address = (ulong)xgmac_get_desc(xgmac, 0, false);
+	writel(upper_32_bits(address),
+	       &xgmac->dma_regs->ch0_txdesc_list_haddress);
+	writel(lower_32_bits(address),
 	       &xgmac->dma_regs->ch0_txdesc_list_address);
 	writel(XGMAC_DESCRIPTORS_TX - 1,
 	       &xgmac->dma_regs->ch0_txdesc_ring_length);
-	writel(0, &xgmac->dma_regs->ch0_rxdesc_list_haddress);
-	writel((ulong)xgmac_get_desc(xgmac, 0, true),
+	address = (ulong)xgmac_get_desc(xgmac, 0, true);
+	writel(upper_32_bits(address),
+	       &xgmac->dma_regs->ch0_rxdesc_list_haddress);
+	writel(lower_32_bits(address),
 	       &xgmac->dma_regs->ch0_rxdesc_list_address);
 	writel(XGMAC_DESCRIPTORS_RX - 1,
 	       &xgmac->dma_regs->ch0_rxdesc_ring_length);
@@ -844,8 +852,8 @@ static int xgmac_send(struct udevice *dev, void *packet, int length)
 	xgmac->tx_desc_idx++;
 	xgmac->tx_desc_idx %= XGMAC_DESCRIPTORS_TX;
 
-	tx_desc->des0 = (ulong)xgmac->tx_dma_buf;
-	tx_desc->des1 = 0;
+	tx_desc->des0 = lower_32_bits((ulong)xgmac->tx_dma_buf);
+	tx_desc->des1 = upper_32_bits((ulong)xgmac->tx_dma_buf);
 	tx_desc->des2 = length;
 	/*
 	 * Make sure that if HW sees the _OWN write below, it will see all the
@@ -901,6 +909,7 @@ static int xgmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 	u32 idx, idx_mask = xgmac->desc_per_cacheline - 1;
 	uchar *packet_expected;
 	struct xgmac_desc *rx_desc;
+	ulong address;
 
 	debug("%s(packet=%p, length=%d)\n", __func__, packet, length);
 
@@ -920,13 +929,15 @@ static int xgmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 		     idx++) {
 			rx_desc = xgmac_get_desc(xgmac, idx, true);
 			rx_desc->des0 = 0;
+			rx_desc->des1 = 0;
 			/* Flush the cache to the memory */
 			mb();
 			xgmac->config->ops->xgmac_flush_desc(rx_desc);
 			xgmac->config->ops->xgmac_inval_buffer(packet, length);
-			rx_desc->des0 = (u32)(ulong)(xgmac->rx_dma_buf +
-					     (idx * XGMAC_MAX_PACKET_SIZE));
-			rx_desc->des1 = 0;
+			address = (ulong)(xgmac->rx_dma_buf +
+					(idx * XGMAC_MAX_PACKET_SIZE));
+			rx_desc->des0 = lower_32_bits(address);
+			rx_desc->des1 = upper_32_bits(address);
 			rx_desc->des2 = 0;
 			/*
 			 * Make sure that if HW sees the _OWN write below,
-- 
2.34.1

