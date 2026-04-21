Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041D6F8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A697583BC4;
	Tue, 21 Apr 2026 16:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="0VdCIfS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E632184258; Tue, 21 Apr 2026 16:24:42 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF816839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479ef2b7979so448131b6e.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781479; x=1777386279;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fAEBT09spuOYxu2lTO5AIoSm+CiDPPMkonMewyKeAyk=;
 b=0VdCIfS6dXK/sZ3DcLWK70L0WHB7+k/xZrdBYdMEy1GeUm22HFmqmpgmzh+1WXQ63Y
 zv5pVnd6Orm9g2hclnUbBb7pHCZE9HPyQASJKs0x87phjmywYIjRIxOwj3/ZudMjJcqR
 e4oYpQwlkrF/V1or3RjPZjGe8TJmjp9pdMPLzQJC2qySIL/9YqM0lhOTfeQR8FMmjrUw
 8P0OaUTKAcQqWf8ZYe1SRaNTn84uYrC2Q1DENhKL3pouMLvs0uE8rku2F9HXUh2KUAuP
 PxreNeeisLz4L5J73elumKh3TNSz0Yi4joEc4CocL0ob7Ni35xK816qvgzeTb1KLuVuc
 R84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781479; x=1777386279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fAEBT09spuOYxu2lTO5AIoSm+CiDPPMkonMewyKeAyk=;
 b=ijq1uMx7Oyz5+2ifVr7X75jKLmaR0JrAiXW4bZYuHr4/vdoiY2cncCNZNAI8uOCM9g
 SzCTLbK4wD+k/6l79901doi/Z8BqlUL6/rJIRaG+pHOQR2t4Ot7cfUODMnSi5xDdzqqI
 JR0JVYcd0mkTd15YQRewSntuGJP097WNh7aR1RoxkLxK0hSolPAS04MUCe54rvW9EHxq
 qaUdrP/T/ary3g4lgDpF7zh0ongCj80MCULhSIAh8DKHtqeAKcruK+8JfcrX1tiS6Yar
 NInJ7jU2k8pHXal60/tzxongq5IzG34SlHO7kZPTia0LFZ2EHjz57+Y7I3NIF7R14OER
 7Ncg==
X-Forwarded-Encrypted: i=1;
 AFNElJ//L+rfIq4W9pLwykqCPuIqcPQM2ZXq+swWxb2cvlUuaBTEzIydZAZBuWowSzaMu2CIs58WzS0=@lists.denx.de
X-Gm-Message-State: AOJu0YyIvCWAWoLbNcowwOS1iaXRytZ76UU6iyyFaKfm4xHTOz+QTvgE
 GI3Q41TFKL0s5O81C1HncENFzG0WbQzBYWbOaaJ6O47aeBGeMapNy+doCacdnIaSPVI=
X-Gm-Gg: AeBDiet5f0VdSlkIbnBv6/00v3RKqJ5Iwz2v9up2Ox2vZq/OLn+Xl2R9zHv/NBlE1RP
 yKkr/xEXmouKEsPdDVqd6Shgxm/cNSnTrn6I5oSzFgb8VF8FLUAZfe2VXV/MRZ+E0620s1s/VOo
 EkYIHx2oR4NeXGeGPxJ54lxRUuER0WoNIy4d4IuDdFh8Ya7ltaQvMXsnsHpEbnwtg2Z0bMn/t+z
 20wMX+41xkiTm4veRSbBbfwYowRdCqpfo2NuQKDZtLZXjEFavk5H7JrcI/ehytq4Wqrd7pqC0vp
 bDOrd0xUSHaUo+zCT71aFVblNONnbcd580kbfvnDOnZH7sP2//phyQycvxIchHEzPCt4A5P/fJM
 y/RUIiddmkqBKOci4ABJaxlQyZtTIfxmFCv+zzS+A6j6vtRcxuyM86lWfRhmhMClbbdNo/mbzyE
 TNuJLVJ+luIoOUPS2FD5NuYUAI9fyeQankTx4aGFc=
X-Received: by 2002:a05:6808:198c:b0:467:631:8b89 with SMTP id
 5614622812f47-4799c9892f2mr9859602b6e.23.1776781479339; 
 Tue, 21 Apr 2026 07:24:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fead505sm9217965b6e.2.2026.04.21.07.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:24:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:24:05 -0500
Subject: [PATCH 2/3] mmc: mtk-sd: enable async_fifo_crcsts on mt8189
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mmc-mtk-sd-fixes-v1-2-5b840c546af2@baylibre.com>
References: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
In-Reply-To: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
To: "ht.lin" <ht.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Weijie_Gao_=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ba28TO8vGnfZqKXBFz053S2Pe37poYR16A/W5LWZWuU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54iWSAXfsPfcplS4QKR4LuI2i2xfIQqLTirz+
 aFpV22N/kCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeIlhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6TIH/0pIa9MWapgL6yQZXHnne+yIxVeJCnJmwPLm5Kh
 UjeCrKazASKpNLl8zb8pRd3te4Xn6be2c3kDmyZr/WgPYUp7JEZok20HtYaxTAO6CA1VtOTLcgh
 7RL9Nv5qpL8HMNwshsCC/b7WrlMVj5Le4vuQp2vtaqjLwMaEP+ldtNi5mx2377Ne7/QgVNd8e+Y
 zURmUX21hqkME7eWAuwt0L7i3f49gOthi9M+UFJyKAxdQGf4u9j+t6142X5Uy+UXbdOPpKa5lUy
 Kae71i/vmNmnbpmix72YgxS6WRiOenFp1qEF1iE/gQL/KB+48LmbhF7+zwfnDMm0gKAZgq1K+QF
 whKw=
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

Enable the async_fifo_crcsts option for mediatek,mt8189-mmc compatible.

Without this option, writing will fail in HS200 mode.

Fixes: b3d16267b509 ("mmc: mtk-sd: add mediatek,mt8189-mmc compatible")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index d2472ae7efe..616cf3f360f 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1983,6 +1983,7 @@ static const struct msdc_compatible mt8189_compat = {
 	.clk_div_bits = 12,
 	.pad_tune0 = true,
 	.async_fifo = true,
+	.async_fifo_crcsts = true,
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,

-- 
2.43.0

