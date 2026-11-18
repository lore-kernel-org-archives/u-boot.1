Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C91606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Si+dMivN;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TspCsj8J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F1E34069A;
	Wed, 18 Nov 2026 20:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5URw58uFpg-q; Wed, 18 Nov 2026 20:30:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5468940662
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033812;
	b=AjrouTgVS793k6GBuG3alY/yrFFav3/A0rSZlFLWlT2FDQcUQuo0wNBUaNZ5xTKHXz1T
	 pumg7wKR5qZnbSodxinVuZBbEU3AGiWSpYb7dGXh15q37sGAUjypRGmoDLfLbwESMaJUE
	 5qW9BkA8QXH6AKk8xNJlBWAvt1qa1uUVbHF//WFmjOblSG1RA7o+7SI5mApXGb2IyQT91
	 Ol6Gvb7Dp8t3ATCPlqaMiGwp00e5WaJRWhRusjihNALewlmC1uYplf4JADLlwEv8KGAjN
	 rI/M/IulvOMyllSzHzoAWPyGBq2C7xPUsxM88jLVY8C9Rz3G5tEd6xCLt63f66wPRXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vzYAyTSgaUa3PtaMwUDlJsCrHKfin96GbkQAuO7+MEo=;
	b=kH5eOxMHzErS57h7H63pTSpDF6x4P4T5dYdrkUtRMCrOYNLU/lALQJ9OnEZmDRoHkjmi
	 apBIb5I1UfqK4/xKQB//yV1uFWLudgi0H42BYVR/eHbhuL7YrrXvFBm/Y+o0bhiF51zQc
	 Ks6pwMzo0ANikRLmjLQxODQB4cUfZGIT+fomCicl4YuH7qR3U6EvZPTDb99A19ARhNGp1
	 TgfZz24ZuPpvn3LUVfXJTuAk7uuOVp0kCJrGCuPN3XH+4VutAS8tJxUo4ubQPnlBle6UD
	 TJfBQNL6YnYZQOprQIHmMl9mMjTXgBGRvsTQ4UAc/TQmIOgNEffFvzBHkbHBXZK4CcQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033812;
	bh=vzYAyTSgaUa3PtaMwUDlJsCrHKfin96GbkQAuO7+MEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Si+dMivNNRTxMCdG5LoRUiggzKvQwvHoaksoLMJKmB0UkAO9ZowpVVezEvsj8F0UF
	 65ECI6rLQ7sF6qA1AFaqDm3Cpt8Aq3Z2kwqeQt+cLxOHnsGJa4HMwR0ZgtbcBb7a8M
	 p/7nwYsOd4vF9p/k3czVL0PC3+iPg0EvWFnk687QqR/RA9iVVAKlqdkWA1M7xq94Ay
	 JOcRylQe4FytSxV2ILe7cErVipyJbsGKDp4kNaHSB4oB9eupiEA0RCpbla1Nk6ya4J
	 o+BgKwShqVDlnGmySlW6tpeAjoYdW8FSYclbDhaYli5+yGNODNszHk20MRzrWCalO3
	 gvbQLnt70EhRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5468940662;
	Wed, 18 Nov 2026 20:30:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E78849B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2362F6063A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGsUlAihP71W for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 21392605D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TspCsj8J
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21392605D7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:07 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so14736705e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033806; x=1795638606;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vzYAyTSgaUa3PtaMwUDlJsCrHKfin96GbkQAuO7+MEo=;
 b=TspCsj8JOvhfXgpYpwkLsvl2Hw2s1tmrNAq890XTsiIVmx6gEsRlr0AL2lh1B2BEKt
 1MiofVUkDikE76oR8DFc7PHFFazvnIKQnul+yXfImxphPd4XTdkhbfsxp6WQ5JOKrBv9
 ZQ09fvi0RJtc7kIUBYV/y0TB7A6QSqv2G2+gj69uKZcoh/10mgHKuFFcJsAk8NwSPZpK
 hlQfKfMac7osKCJR1yQsgvK8Ql5gGIc4hCoadvBnv8l0DLSoTz61OI6C/csahXVe39nq
 bPU9tAN/zeaZABNZIowjg3ZcR3OBBN2Gm3fNIytfqnTGrAkoVu0NzakE3OulVuS/0wFN
 tA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033806; x=1795638606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vzYAyTSgaUa3PtaMwUDlJsCrHKfin96GbkQAuO7+MEo=;
 b=qLwz2O2Xt6NjYLSvbN/yF4qnI7XZyIb/deP6ncsrT8RWQ0e6v4WKS++Qul6fsZrTn9
 erNhWBl1pllFO3QLqfDoz6d+qUoq4/YJM8kmoUb1NWJSMFn85Nzo23fb6ExZHgT6Gx+U
 IlSER7bJ5xNNeBB6Q1di9HWeJkRgSLsxv9JNUN+qh2JKhFxOii/PXzeQ/ZOkmhGcv2Rh
 9ijEwO+B3X+RxWOV+o2njPDjO6WnXPAZE+kM5AarCxvW1/3+2raKsAZnXwB8SNA7ule8
 KxlEnQI9gsteFMxc0XHXOQJiQTatjcH4fGiljLORmElcTt2K3ciXh36dH2Sce/zwgqUH
 QSEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGuHmImHwibJOmCv7E0c9Hti7t5sp/Mb5xMCg8sUPIjfAEpqT0roNwIZSTW80uXybdiqsWCDkc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+rYPTXOakF4ju30c9MXGGBfZvj71cCDTxAgNgTPsVdABQ8StD8
 rqNoUtQZcdkZYldTXwlhlOgWZvZCqyfBBqaos2pO9JiEo9lhT53eK6bbYCaRgY0tEH0=
X-Gm-Gg: AYBFou1NMKU60C2gMdWwyHYaeo4ioEOIvY/2mQ85DzhIiw3KvXQYuXBfL2T8XZ0UOie
 SXyraVDDbDGrmb2hkq2OMNN4W9ipIA+EJ5odDDyaG5y1yGctaDaAd8Oeiq3egdhGCIfGY948u9Q
 mhnLmSLTfVnSpRcY8jCOBLJ3pU/TkA0OZUtBke2n1MRz/6hARh/QnQngTZ2Yxd/8MyiW6Tl+akz
 rHodoJfVTTleNJffiyvZiViaEFR4u/ttKE9yC3S42ePP7GgpKn53sl/1Pos8qCNUVguZgOi3uYA
 N/+NTy1ItkP9OX178hHsZNxP3HRDM+E2A0RIy3mE50Q9rn5Oso90Fd4fZGuHbo7E745h0V7E+cy
 lIFeLh0F1PvEFmwxVF1e6hb7EKy3uIaAi9bWigFwN0A8h5xB9YOoAZVFnr2qBiPahZQddFzOt4f
 pkP+FgsU5RLEcKHReNjwjy6pCDAWrscrBmpNKxV+4x4/vsWlTTMI3PJ/jCb9IUThdxUh9nD1fas
 uRikpF5XQSbe2/h0VS8lubJqgmR0iku2bSsAh+HaKLaoELnIUHDw5R1Z/OjVFV1d7q02FObP+Y9
 gkmTDRu/44NlJ3GDWLATDJEAbXrXkxxDxqyr+eXt/kQpCxIS0UCQXfyqv7araQAU/zdw3Mkjj+g
 KWmZdIc8UZE6fv29kAQ==
X-Received: by 2002:a05:600c:83c4:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4bb7da0c192mr69251005e9.9.1795033805890; 
 Wed, 18 Nov 2026 12:30:05 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:05 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:47 +0100
Subject: [PATCH 1/7] i2c: mediatek: align DMA buffers and handle 36-bit
 addresses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-1-916dd6cc8d1a@baylibre.com>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use cache-line-aligned buffers so DMA cache maintenance cannot affect
data next to an I2C message. Program the upper address bits on 36-bit
controllers and reject addresses the hardware cannot reach.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/i2c/mtk_i2c.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 55381dbece..767542f42a 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -12,6 +12,8 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#include <mapmem.h>
+#include <memalign.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -121,6 +123,8 @@ enum DMA_REGS_OFFSET {
 	REG_RX_MEM_ADDR = 0x20,
 	REG_TX_LEN = 0x24,
 	REG_RX_LEN = 0x28,
+	REG_TX_4G_MODE = 0x54,
+	REG_RX_4G_MODE = 0x58,
 };
 
 static const uint mt_i2c_regs_v1[] = {
@@ -212,6 +216,7 @@ struct mtk_i2c_soc_data {
 	const uint *regs;
 	uint dma_sync: 1;
 	uint ltiming_adjust: 1;
+	uint dma_36bit: 1;
 };
 
 struct mtk_i2c_priv {
@@ -505,7 +510,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 			       struct i2c_msg *msgs,
 			       int num, int left_num)
 {
+	ALLOC_CACHE_ALIGN_BUFFER(u8, tx_buf, MAX_I2C_LEN);
+	ALLOC_CACHE_ALIGN_BUFFER(u8, rx_buf, MAX_I2C_LEN);
 	struct i2c_msg *msg_rx = NULL;
+	u64 tx_addr = map_to_sysmem(tx_buf);
+	u64 rx_addr = map_to_sysmem(rx_buf);
+	uint dma_bits = priv->soc_data->dma_36bit ? 36 : 32;
 	uint restart_flag = 0;
 	uint trans_error = 0;
 	uint irq_stat = 0;
@@ -516,6 +526,11 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	uint addr_reg;
 	int ret = 0;
 
+	if ((priv->op & I2C_MASTER_WR) && (tx_addr >> dma_bits))
+		return -ERANGE;
+	if ((priv->op & I2C_MASTER_RD) && (rx_addr >> dma_bits))
+		return -ERANGE;
+
 	if (priv->auto_restart)
 		restart_flag = I2C_RS_TRANSFER;
 
@@ -567,32 +582,34 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	/* Clear DMA interrupt flag */
 	writel(I2C_DMA_INT_FLAG_NONE, priv->pdmabase + REG_INT_FLAG);
 
-	/* Flush cache for first msg */
-	flush_cache((ulong)msgs->buf, msgs->len);
-
 	/*
 	 * prepare buffer data to start transfer
 	 * three cases here: read, write, write then read
 	 */
 	if (priv->op & I2C_MASTER_WR) {
+		if (msgs->len)
+			memcpy(tx_buf, msgs->buf, msgs->len);
+		flush_cache((ulong)tx_buf, ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
+
 		/* Set DMA direction TX (w/ or w/o RX) */
 		writel(I2C_DMA_CON_TX, priv->pdmabase + REG_CON);
 
 		/* Write the tx buffer address to dma register */
-		writel((ulong)msgs->buf, priv->pdmabase + REG_TX_MEM_ADDR);
+		writel(lower_32_bits(tx_addr), priv->pdmabase + REG_TX_MEM_ADDR);
+		if (priv->soc_data->dma_36bit)
+			writel(upper_32_bits(tx_addr), priv->pdmabase + REG_TX_4G_MODE);
 		/* Write the tx length to dma register */
 		writel(msgs->len, priv->pdmabase + REG_TX_LEN);
 
 		if (priv->op & I2C_MASTER_RD) {
 			/* write then read */
 			msg_rx = msgs + 1;
-
-			/* Flush cache for second msg */
-			flush_cache((ulong)msg_rx->buf, msg_rx->len);
 		}
 	}
 
 	if (priv->op & I2C_MASTER_RD) {
+		flush_cache((ulong)rx_buf, ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
+
 		if (!msg_rx) {
 			/* Set DMA direction RX */
 			writel(I2C_DMA_CON_RX, priv->pdmabase + REG_CON);
@@ -601,7 +618,9 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		}
 
 		/* Write the rx buffer address to dma register */
-		writel((ulong)msg_rx->buf, priv->pdmabase + REG_RX_MEM_ADDR);
+		writel(lower_32_bits(rx_addr), priv->pdmabase + REG_RX_MEM_ADDR);
+		if (priv->soc_data->dma_36bit)
+			writel(upper_32_bits(rx_addr), priv->pdmabase + REG_RX_4G_MODE);
 		/* Write the rx length to dma register */
 		writel(msg_rx->len, priv->pdmabase + REG_RX_LEN);
 	}
@@ -660,6 +679,12 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 		mtk_i2c_init_hw(priv);
 	}
 
+	if (!ret && msg_rx && msg_rx->len) {
+		invalidate_dcache_range((ulong)rx_buf,
+					(ulong)rx_buf + ALIGN(MAX_I2C_LEN, ARCH_DMA_MINALIGN));
+		memcpy(msg_rx->buf, rx_buf, msg_rx->len);
+	}
+
 	return ret;
 }
 

-- 
2.56.1

