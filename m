Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE7FB5164
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03A68416F;
	Mon,  6 Apr 2026 22:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="VCPBqWP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D55D84180; Mon,  6 Apr 2026 22:14:49 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E72684132
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso2212717a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775506479; x=1776111279;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YkzBUEwC2v9qmeZvd71kTNOste1uNMuasMqNTcNUFlw=;
 b=VCPBqWP/z/S97CCq8oYDgWdBS4aiJyfvhyf1+d3+T2ua1PO27g/thcolzWi3qWhLcm
 pPnQdbdHFgzaW8vtEW8of2Ny/QIp93mnKd58OX7anNjs8krCfBbkIjpcIHNER8Kah52D
 y7nJW9Vp/J5fnSJFlcf85euCj+VjhEqzDuW0NYDcKK8jTfAtgHOMnRoEzaWm8Q0VH9Gy
 QA/RzUP2Zj9hil1EpSWxt2cJwKowiJVWwcmcc69/EuzgM7KWY14+VoM6A94dZPZolsIW
 /7Y5tCSInARK/XlOPYCLxGvkiN/MjsVacucFLGu+oh7gF9P/3sRhkQ3tarRhmIDo6DAp
 H7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506479; x=1776111279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YkzBUEwC2v9qmeZvd71kTNOste1uNMuasMqNTcNUFlw=;
 b=PaxPl7NKKU6H41RQK1N1g75J4z9ifHEDCReC6pTnxWxz4WiFoYq9IwdJIGoiQMeCmm
 AN1K7PEBYcRf4RYxAGomj+eTc5qBtv/We0a7mb+EvdwaNSQMwvuN8YkqVPmsjWahET/Z
 boYvi2qdTNect3Knftr3YlB6oyKBpNQVL0fbsLUW6TK3vTjz3q6lLjSjUJqhShEZU8Yf
 8S44mnzcfdyVtSjyn5htN10tMw4zov5e3p7w8Vg2EIi2V/YvN2G+Tp4tKa8DwZq+P64u
 VOSIU+IN7tnFwALV1KPOHb3sm/wQYFlaPBC9UndSr9VNRKdLla/upGwkge9/sARMmclj
 KeDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVhLeZVNrac0amQOO0j3Vl/fwRmU67znhgPydR+3MVC7Khj3HAjjgBhv/SUZG+li3NPAE9ZeM=@lists.denx.de
X-Gm-Message-State: AOJu0YyiLIESIenaqnQDmpTuTYEj8ZPQrPvMX5DIIQEYc0WZmZxELOJP
 gSdSuHyZWbBywSMx8kjp2qGG21mfK2fr8dYiTfe+L6RaF32Scu+lEQ+wIURV24HYvytkRNHXz5n
 lkzGZ
X-Gm-Gg: AeBDieuz7yGil4BqVxXNjfOqqmh9pTzbaNWKvx2HUEZ0jOA7DsNAMaJyUmFsbBZc40b
 XSldEG7W0ThN3isujdOhDI7vWo5JIBXKQ2y+bVqm1pz8/Aakfm9b9JcjFJFyypCRjpwHgrPfJa3
 t9QgStbEN3RxOk3UmoGUDfP0Kayl3ngiU0rD3Key/6A6FqX28BMw4TEapvpWZKiz6Ieeoqg7hQr
 3c7+wVKlvK1ay+kcXzZmfhKB7l/BVYI84YxDIgaWAGVLeodQdfW9veYgP8apZd+jt4XR5aeVp/5
 1uwthOpc4u70d/LrNHcqLExdDqg1sBVwMcivhI6sAgisVILw2kuxNtiPVxBtQqWiLv2bvhY7hC/
 hKemRauN5w00w4SrdRwUHiBO2HfqlwptgKifBEUmyqzt26k6F/MXgNa5kRb/Sq1doaocpO6I+/7
 SCBXJWNOuVuTNPhx4cNJZ+B0ZfHwc=
X-Received: by 2002:a05:6820:998:b0:67e:f8c:6bdb with SMTP id
 006d021491bc7-6821d7479fcmr8063789eaf.24.1775506479062; 
 Mon, 06 Apr 2026 13:14:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68597f6c7bdsm2642044eaf.3.2026.04.06.13.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:14:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:13:34 -0500
Subject: [PATCH 8/8] spi: mtk_snor: Remove status register write procedure
 in probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-spi-nor-improvements-v1-8-66f675cbbd3e@baylibre.com>
References: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
In-Reply-To: <20260406-mtk-spi-nor-improvements-v1-0-66f675cbbd3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2nm1syoc0LTHjBxPzxjjFrdQ3yb1Ks7EUFE6mEqRayU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BQgfCDYk61GwwHXNX56XM4F+DrCr1+ezT/CN
 3258zVMvJqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQUIBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArqUH/0LrjSMkuX9CU+mFmaGawkzFlvwgFpC2nmlhFeR
 6LgTgyrH3Po8dO3j2Ngq/OBCpbAqLRR45rU4m+2pU5/d/mFaHHy8xBG8gEmrPYhX2MX43yGyVBo
 M/ZVXwQ30fZjFItXHa3HgsFlmlv0ijlJHHwwy+rkoEdm0HxSTX3Xft7Br22rNx5Z0crfttFF2wD
 IGeSUF4r9SiXeJO04VkMrTG9ICp/079kJ4YaVo3WoIzTtnaQyMU+sv/NB7cqfTSvGvfXFd0wMGC
 lrIAwMAGTtfvXLL9glpPPCPhVHWj3UT3SWbWtVJ5jauByDkNJ57g4VgNamsPUeAkRqN6af35BES
 HnGc=
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

From: Meiker Gao <ot_meiker.gao@mediatek.com>

Remove status register write procedure in probe(). This is handled in
spi-nor-core by the SPI_NOR_HAS_LOCK flag.

Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 21ac115e3c3..3b9eac383ab 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -567,19 +567,6 @@ static int mtk_snor_probe(struct udevice *bus)
 	mtk_snor_rmw(priv, MTK_NOR_REG_CFG3,
 		     MTK_NOR_DISABLE_WREN | MTK_NOR_DISABLE_SR_POLL, 0);
 
-	/*
-	 * Unlock all blocks using write status command.
-	 * SPI-MEM hasn't implemented unlock procedure on MXIC devices.
-	 * We may remove this later.
-	 */
-	writel(2 * BITS_PER_BYTE, priv->base + MTK_NOR_REG_PRG_CNT);
-	writel(MTK_NOR_UNLOCK_ALL, priv->base + MTK_NOR_REG_PRGDATA(5));
-	writel(MTK_NOR_IRQ_WRSR, priv->base + MTK_NOR_REG_IRQ_EN);
-	writel(MTK_NOR_CMD_WRSR, priv->base + MTK_NOR_REG_CMD);
-	ret = readl_poll_timeout(priv->base + MTK_NOR_REG_IRQ_STAT, reg,
-				 !(reg & MTK_NOR_IRQ_WRSR),
-				 ((3 * BITS_PER_BYTE) + 1) * 200);
-
 	return 0;
 }
 

-- 
2.43.0

