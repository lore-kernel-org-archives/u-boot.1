Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DE1F46C7C
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5B683E36;
	Mon,  6 Apr 2026 22:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="R1Evhtsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C28840BE; Mon,  6 Apr 2026 22:14:40 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2841183F98
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbb89ab229so3005104a34.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506473; x=1776111273;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+h7lhIpBgiiFE6Z5wj/ru8J/4UP+A7QCgf93BchKfxc=;
 b=R1Evhtsk1DAzx1VAgUIhtT+LhepLjKar8ZXunN+t/ljQ2s3/pI/UHkqoChCUrOHfSs
 yWfCOkUl3nzPwIk9BqLdmlDF4wt5E8jxRnWUYGZ2c3fUZLeyPQ0K7NVAYP3s8h+u/wUq
 aFodXYrtTH5JuKeElBhtpCOYmSHdOvtforRQsR1mufYAui+3wDUpS1dFP2+oSz+EEyUq
 zt+4aKT6V8Zr/YQf1tYm1x9fW/hd8nTEY0yrlJ+6XezWgohNVHsdvrNcmhr3X6teLCIw
 dTA/PKayQqhUkygHJiVGJrb3/McjdUge9XO/tZsrX10NQLyquAGYtO579Qgf9uHNrX76
 GYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506473; x=1776111273;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+h7lhIpBgiiFE6Z5wj/ru8J/4UP+A7QCgf93BchKfxc=;
 b=nwg7qOTvAPCmQraM7i/zPn/OUtPd4ahTliiwwhgA9TDbS/zQZcUVDKEZUuMzY54owU
 zOnkADfcCATPX0r2TN5XbPbzgJsqyunMuPklGjyaQC16A71LzI2uvetOFAuy8mi8VcoV
 Ra5FX2J/fr5fqgJt7LaouvxY47Eu1C4zXxorvHCcJ4AyD1C/S9NyL6mpevacgjamYjTO
 hN8bgstdsks8ev1TjvOTAiAlHYBNDriQQOvVBTCDyOHQDO9xrFNtKu2mRKXzKbUMSuvK
 B7HtctwHFH4KTPi9n3hamL5mmrkK92Lhdmz17he3vLfdLq6m4Yk9aMprmA9Ek2JmB0LO
 Sgfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjhaRNTBGj8Js5HqNgOwiiKuAMMnrm6dI8o2crWvqveRd3LWguyWNIDLpQC75JLrgWpBFAyw8=@lists.denx.de
X-Gm-Message-State: AOJu0YxSLAZOs7q0C+fJASRp06gAMTp3o6n/riPYll2+8DcRIiFhcIFg
 cGaX1NjuoUHha6pTjZj3qJaEroVA0WnWOurJpMGP1UYBKO/Lx0jxFMiO8TkgSgqsp7iox04DQSM
 gqcuQ
X-Gm-Gg: AeBDiesVyuVzByMq8JZIZqD1jAWi5NS2h2jNWPHEtdR0cwDqDn/j2uD4uCTxaG4zoC7
 O/PAWjzKdE9aimr8fFstwvo2md77K5cycaFVdPC4KH6gf7CJgETrmKIFI8h1Eo8c4CoHFjr+Iz/
 ir2o2DClTjkUjiqebmUspLRCHMkCJOTwjz60fQEn2WJpMHvMBUm11LRo95M1ypTvRRlNXVkY7Ub
 NYCtjuXFLBHez97HDKMmLAzblY3lJjH5jFX/r6g9jDPUp/ZSndoPCI3HQvMIFWRuzmU99a9GjvI
 pZu+wNoP/cdqocM7f7JTuP3TyUMZbZod6lI7VueU+4uIl76WOYV3/wf5oxTpW2pFKNYuZPheAdb
 KFWE9D0iu668WNFyfxpHoqRF2BrFNwrClpIxwwGV7H/n73J+1kYGzK6O4srLoSukqpYKthy6iBv
 p1Vj8vATPoioL2BpfHvtfVVcicfQM=
X-Received: by 2002:a05:6820:168d:b0:680:aa7c:ac0c with SMTP id
 006d021491bc7-6821f487dddmr8068095eaf.43.1775506472799; 
 Mon, 06 Apr 2026 13:14:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:27 -0500
Subject: [PATCH 1/8] spi: mtk_snor: clean up comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-1-66f675cbbd3e@baylibre.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, "Noah.Shen" <noah.shen@mediatek.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7FKiLIsWrE5M09dO22Anx5t9LOBM17EPAAsIQzZDDEc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BPyJBWwGe/4nIWzzzl/rCs/nroBfkTu+B1vh
 TrtAnuFt+SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQT8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7VIIAIysvkIFVIaj4zs8CGxqtNIihbxUMe4JsW1v7x9
 S5NAAY6b8JsFHhQl+Lk2Z0p0TMNoBss5BPSRsmXqQ896EhID66eE47K9lPRxAmIROdL/xeL1gbv
 ea/E3RQKvz4PbiZHJ/rve6w7PJ4BGl+Y7IVWoUs8Bzcw93M8JXM7sR2zkW1XfXPvuwmOW7g4Ion
 Ckv439HIUq20MM2VmB0fjJgTx0Tb/c2CzJdGSGMI+oP8wj5tD55bbSFgxyBOoJXf5eeiKz8skHT
 /ii/DsQPe/5qqrA3p3JHKmeZZUB9Adb7jXy1vhdAA7wvHfHH/WDbkQbYsH1+GXZta9rkrAdKLzX
 v9mI=
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

From: "Noah.Shen" <noah.shen@mediatek.com>

Avoid use of C++-style comments and fix multi-line comment style.

Signed-off-by: Noah.Shen <noah.shen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index f202b2f49f5..eb36c9dd5e8 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-//
-// Mediatek SPI-NOR controller driver
-//
-// Copyright (C) 2020 SkyLake Huang <SkyLake.Huang@mediatek.com>
-//
-// Some parts are based on drivers/spi/spi-mtk-nor.c of linux version
+/*
+ * Mediatek SPI-NOR controller driver
+ *
+ * Copyright (C) 2020 SkyLake Huang <SkyLake.Huang@mediatek.com>
+ *
+ * Some parts are based on drivers/spi/spi-mtk-nor.c of linux version
+ */
 
 #include <clk.h>
 #include <cpu_func.h>
@@ -89,13 +90,13 @@
 #define MTK_NOR_REG_DMA_END_DADR 0x724
 
 #define MTK_NOR_PRG_MAX_SIZE 6
-// Reading DMA src/dst addresses have to be 16-byte aligned
+/* Reading DMA src/dst addresses have to be 16-byte aligned */
 #define MTK_NOR_DMA_ALIGN 16
 #define MTK_NOR_DMA_ALIGN_MASK (MTK_NOR_DMA_ALIGN - 1)
-// and we allocate a bounce buffer if destination address isn't aligned.
+/* and we allocate a bounce buffer if destination address isn't aligned. */
 #define MTK_NOR_BOUNCE_BUF_SIZE PAGE_SIZE
 
-// Buffered page program can do one 128-byte transfer
+/* Buffered page program can do one 128-byte transfer */
 #define MTK_NOR_PP_SIZE 128
 
 #define CLK_TO_US(priv, clkcnt) DIV_ROUND_UP(clkcnt, (priv)->spi_freq / 1000000)
@@ -168,8 +169,8 @@ static int mtk_snor_adjust_op_size(struct spi_slave *slave,
 		return 0;
 
 	if (op->addr.nbytes == 3 || op->addr.nbytes == 4) {
-		if (op->data.dir == SPI_MEM_DATA_IN) { //&&
-			// limit size to prevent timeout calculation overflow
+		if (op->data.dir == SPI_MEM_DATA_IN) {
+			/* limit size to prevent timeout calculation overflow */
 			if (op->data.nbytes > 0x400000)
 				op->data.nbytes = 0x400000;
 			if (op->addr.val & MTK_NOR_DMA_ALIGN_MASK ||
@@ -496,7 +497,8 @@ static int mtk_snor_probe(struct udevice *bus)
 	priv->spi_freq = clk_get_rate(&priv->spi_clk);
 	printf("spi frequency: %d Hz\n", priv->spi_freq);
 
-	/* With this setting, we issue one command at a time to
+	/*
+	 * With this setting, we issue one command at a time to
 	 * accommodate to SPI-mem framework.
 	 */
 	writel(MTK_NOR_ENABLE_SF_CMD, priv->base + MTK_NOR_REG_WP);
@@ -504,7 +506,8 @@ static int mtk_snor_probe(struct udevice *bus)
 	mtk_snor_rmw(priv, MTK_NOR_REG_CFG3,
 		     MTK_NOR_DISABLE_WREN | MTK_NOR_DISABLE_SR_POLL, 0);
 
-	/* Unlock all blocks using write status command.
+	/*
+	 * Unlock all blocks using write status command.
 	 * SPI-MEM hasn't implemented unlock procedure on MXIC devices.
 	 * We may remove this later.
 	 */
@@ -521,7 +524,8 @@ static int mtk_snor_probe(struct udevice *bus)
 
 static int mtk_snor_set_speed(struct udevice *bus, uint speed)
 {
-	/* MTK's SNOR controller does not have a bus clock divider.
+	/*
+	 * MTK's SNOR controller does not have a bus clock divider.
 	 * We setup maximum bus clock in dts.
 	 */
 
@@ -530,8 +534,7 @@ static int mtk_snor_set_speed(struct udevice *bus, uint speed)
 
 static int mtk_snor_set_mode(struct udevice *bus, uint mode)
 {
-	/* We set up mode later for each transmission.
-	 */
+	/* We set up mode later for each transmission. */
 	return 0;
 }
 

-- 
2.43.0

