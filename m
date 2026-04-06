Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0847F46C7B
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA8884105;
	Mon,  6 Apr 2026 22:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cX232ebJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A69C83C2B; Mon,  6 Apr 2026 22:14:46 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD49284129
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d556c1a79eso5559336a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506478; x=1776111278;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qu3c4s/89QU8gqEtybf2wBrHTswUYO3W72yymMWaZpE=;
 b=cX232ebJ/1JisVA6Fv5My3IvcPmxeE1U+Uvh6N6r0miIsJXmfS5QgCCePP47Jzm0pp
 +IDObtXODY2QFCuR3iZUbB5Jx0wDCwV5S+Fb/cgFwTSqNcbTEuIwcWiXk8cLDsBh/d/n
 uoGH8WT/Wpb/H/FKW8nQneq+epjSxwLl3TAkYPy5XR3Msz2bViNoAzIBvMZUDm1BIZp2
 mBw9OcSpz/1fhYHnVZ2KIblsZ5wt8miSKTJ9pNH6vYI6zZO7elkEuj+muDcbjGEF6xP8
 JQ5wRQl5+otrkWLux8KIfN3lbTLd5hKIgjVFxvO0do6gQGBRj2VjRMvKrLriHNp1kEp5
 opmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506478; x=1776111278;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qu3c4s/89QU8gqEtybf2wBrHTswUYO3W72yymMWaZpE=;
 b=QdOU6Knfr050jwPAOXYLcX8ixd7vmQg0jHJExQnlHbuTprPOOovOdxj1Zr54iy51av
 jpSspm5Iyy/bcIG5eamDuaVMW2GAFpRkbwfdc3zU5UCghvOj4RwXAworzWtAPnsyTPYK
 XqcH01/jvlg+PuNYN18rkrXhm60Sp1Ke59XCAUJ+qQb4d9pnRxvOIeOS/RuokKPTMNtu
 MmuB1JVdFErzoovoeOOFDGZmGQ2ZP45INE80IwnT0ikwGrrtRsMhQF5UJoBZ4kESRl+g
 yfi73XstzZE+hvl4WLQ1q8SwcVTWU4+A7kRPt9Fkg+w5hSCQ6fs9Osud7ztypQy91iKv
 azaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8zsftxrSbRcc8muVpKl6U4lfAHySSfA2MvUjmA6jZG46IOn2+bIeaySu3ykNNoxPtHrsefbk=@lists.denx.de
X-Gm-Message-State: AOJu0YzV+cT8VlhSORCKPRnBpTUdmsf/76VDOzwWzspurjreEbxGz+Jq
 cwLorabPZw/WSQrXuwrazKKqOAE/BJtvxW78jMZmdDYifSM36Q603dX8V4rDdF6Ru/mGcVaQshI
 lnZpt
X-Gm-Gg: AeBDiesOvbN8Wx5n2mtIaEQrvKPdQtf37B1p+V5OZ0wLmqGnGajZy50MUIHUD9WAjCr
 FXikfD4HiZy3s/PfPHR/WPVHFLmy5ihgtdJ9NNsxrcy9tyoGpmxdqA9RKB5APLa+fBWBCBQhRxy
 Zrxe5QAochHqOQ5eDkbCBiP+U8XPCjQGDh0XNtNvofFT0n+pA4A6H4B+5mAfj8V92AS2j/o5DL4
 9NT7sTt0kY1cQD08pct8SAMji7VCUfaJRIvaeKqaIDdeQGmqLP1Ws7fubWlp36/W6CyCc8pAlen
 VHM28WJDmXnlVvXqy0AOvcpedHlNj2oLQU2/a5cyt+fKok05UnT8/io1RzVdRqmIVcCFIWe7IhR
 tcm2Hs34N/iKbpqhWHPYOjnuW6rsePqzMoS3W4KrinUCkbhqxpc4LKQlxvwblrQV2zl6qx77v+Q
 zWif0OU9IyCcc6kOLVrEs/E49JVW0=
X-Received: by 2002:a05:6820:1842:b0:67b:f12a:dfcb with SMTP id
 006d021491bc7-6822103c55fmr7303982eaf.60.1775506478211; 
 Mon, 06 Apr 2026 13:14:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:33 -0500
Subject: [PATCH 7/8] spi: mtk_snor: fix zeroed data in DMA read bounce path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-7-66f675cbbd3e@baylibre.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ym/43kEQ32E/Ssd910K4K9MkAObkG/hxqt9ER0AK6ng=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BQZQ5hgipq3t+9DbSZ9u8lKTpfM/p/uyeS77
 ZzxlpWGOg6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQUGRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZjwH/2i/tySorGfaUiIdtXxLZVlDo7juU+GLgtbbO3e
 4J6HlKTsmHaolNu8XHLX0FmPIetqy+V7HQfYsPBLxYI/DTIw2d7iyFAwwsLLUgOCelIE4ILxgDQ
 NX4NYyFgTAHYvL5tB4KrC/GWcrMZlyFC3m9P4KAlK+Nz370N13H64Uts8eXJVYTer2oGTT4gzJu
 K75GLmtScxPiYHTT765VNbbCnvrZyLWv6KDrxDGJ7bGRA2dOysEnlIO2EkRXjWfXw9Rfuk3OFME
 g9gbRDObv0nm88hoV8W0rDNld9HmWcg9VVWfTQs4WW5ZyllkReOiqO35F6f5zSm5CiBrFbrjJn2
 G7KY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Implement proper bounce buffer handling for the read path to fix zeroed
data when using DMA. In the bounce path, map the bounce buffer with
dma_map_single(), perform DMA using bounce_dma, then copy data from the
bounce buffer to the user buffer, and finally unmap with
dma_unmap_single().

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 649bca5716c..21ac115e3c3 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -274,6 +274,7 @@ static int mtk_snor_read_bounce(struct mtk_snor_priv *priv,
 {
 	unsigned int rdlen;
 	int ret;
+	dma_addr_t bounce_dma;
 
 	if (op->data.nbytes & MTK_NOR_DMA_ALIGN_MASK)
 		rdlen = (op->data.nbytes + MTK_NOR_DMA_ALIGN) &
@@ -281,11 +282,21 @@ static int mtk_snor_read_bounce(struct mtk_snor_priv *priv,
 	else
 		rdlen = op->data.nbytes;
 
-	ret = mtk_snor_dma_exec(priv, op->addr.val, rdlen,
-				(dma_addr_t)priv->buffer);
+	/* Map bounce buffer for DMA */
+	bounce_dma = dma_map_single(priv->buffer, rdlen, DMA_FROM_DEVICE);
+	if (dma_mapping_error(priv->dev, bounce_dma)) {
+		dev_err(priv->dev, "bounce buffer dma map failed\n");
+		return -EINVAL;
+	}
 
-	if (!ret)
+	ret = mtk_snor_dma_exec(priv, op->addr.val, rdlen, bounce_dma);
+	/* Ensure DMA writes are visible to CPU and copy the requested bytes */
+	if (!ret) {
+		/* Synchronize cached data to CPU visible memory if needed */
 		memcpy(op->data.buf.in, priv->buffer, op->data.nbytes);
+	}
+	/* Unmap bounce buffer regardless of success/failure */
+	dma_unmap_single(bounce_dma, rdlen, DMA_FROM_DEVICE);
 
 	return ret;
 }

-- 
2.43.0

