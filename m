Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6276CD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73CF84717;
	Thu, 11 Jun 2026 22:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GWyHuayX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE078407D; Thu, 11 Jun 2026 22:32:04 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9465D838BB
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-485ecc0f2dfso245894b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209920; x=1781814720; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CiCbE1DbLlC9C5uZADN22ecqbsFNeyJu82YH3hTMh+4=;
 b=GWyHuayXtQkc2YFrbfTBw9kC7olXnG2LQ2v9CJRvGMTWSy4f8sLlJp5bMKMQaN/oOi
 U4ZF1C2X+Sv2XZplWbWWGskj3tWS+R68X1dleUj2Kmg7OKr8aP7KsdCdKaCUb/7xrb96
 bN7D611dyk1HAsjJ4a6zHRcfBIl4o8sNw8N0ksE0Z8HAoSbPyC4m5MsYylg5GFF7a37o
 D0rnLprYVYVkzuwf5aXl8kUAqwsUOegQOHj2HmmcEJ75SLYaQeTXJsFB9R61sfX0LxFe
 ICM7v5JzsoCW4K+tft0jOsk/C8zyBGSg/+OeA+B//hkH2x0ZO/XEUL0PXQ/CxZJdTvj1
 R8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209920; x=1781814720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CiCbE1DbLlC9C5uZADN22ecqbsFNeyJu82YH3hTMh+4=;
 b=BY2e/NV3ZN6L7tvjo39CO7nvihKL43nHZ4dBnApMKKmyLzP7Syn8MzYi6KbdaZMjZz
 UjFNQuAkXNrxHblY4MHZx9A8O8KbyRc5h8T2UtHL+6uFKF/4Pc4BLcFeLDFBscIzQc19
 U+xSwux+L22+zc7p8sXjPm76uBX57LGL/5UDnUAkMT2wsf8BH5tVF0f/TIrq/Z0VS+CR
 CTGvjC59iXcBNOZskXg/xHwCBFrrsidMofXR+v0a7bKoJtxY/hXJbvljte8lULAxRgUz
 3N7IE5JJefCM/oRai1u1MI3JLILfsnYwAcZGVxNnfw2N2VTn02dyiP4ZlxyyC3YKgS9J
 H8JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qJVu1t4YyBKEOrK8jMjBnwaouWj10KQnmAkr+mBHzrs0PdDwe0gcLqXyfPlRMa/51r41A2Pk=@lists.denx.de
X-Gm-Message-State: AOJu0YwbmcBO/4w7Epjju/GTvsjke3+oHzRMY3lhi1xoHooTslx0QXPR
 p6SOiRQzV1p2QKd08dG4vlWXsII3y7tW5EHVztrZMjQhGbyZ1V0D/KSgfyBxU1fGrjM=
X-Gm-Gg: Acq92OG9VksnHhzMlJFG6MtftCOzO1UF+iesyakVhUNkUFITLV4rqSD4dgncPET/795
 g4H1psbOCTuA62/kckyQQOIb6+rYwqNYGcr3yLUmbwhQdifE9J5ses7L74WCCdKmCx2M7/dSi8q
 SXn1hsNYCHZMyL3DDscPZm/lchYGo5cYES8hhyl6JL627txGBd3nbEfUgwrRnNF9mQh84N/Hew2
 QGfAHWh2eJ+kYhsiwjpegIBk4D9KY7iUK2I8to1qGpuvBj2t62p7KaGgCxtUbgI2LgiNWLZuLEf
 D6wne0tgL0Q3YejDGWXBPlOKzhdtO9FGlj+vgaLJjoqLbIMxjx8k7PVnMcmgJ4wCO5/IDpgSnAo
 NiJ6I3nTXSUDeku8dGTKB+pOqXotKIp/Svm3hLyGmrufD3KZdDzAL6YtxQZZ8+1oCCh6O8CBu7l
 OH6gHJJFhzk209FUWHwfs2xKB9QQM=
X-Received: by 2002:a05:6808:4fe3:b0:486:523e:d259 with SMTP id
 5614622812f47-4872f0aa778mr34215b6e.0.1781209920260; 
 Thu, 11 Jun 2026 13:32:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:31:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:00 -0500
Subject: [PATCH 1/7] lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit
 Mediatek SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
In-Reply-To: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=752; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=9kXsHBEJoNTbcFy2dJFkrLmo0jztu5FIt8gmGMUywZU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxsNGFk3yD0BQfdmaYtjB7YpoLZaVQDk3goDz
 sh80ByUOZ2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbDRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AktEH/1KavkmK4mfuDjMis82lyFYPN1HSlEZAUAEI/vV
 4sbLQ9vG/ONzTkQyAPdCDvZ8wc+clPwey0MvQ/bY3fL76UoNNVZMoqsillsSDL1G+b2dVy/lmQl
 OR0h8V8tyCwJvRonoetLgbDlO2wUYJXy/pGYdxLNvQNo+iu+M1jMA/NDuiT8yigo7JvMrvvDWR3
 dKYeNb66SJ3B7mTjRyWvvVhEoqbhwwDw9xDT82MLKDwefU8PiXcdu0EUuwXSbIbX/lpVd6d2JAX
 UV+XdyAA2QPO7o5qhKBgTyMHAEU3NAedJRPNipCB57VVWX9lFxoeO6/GFyEvU5hgf6yK5GKC89F
 vIuc=
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

Add 64-bit Mediatek ARM SoCs to the default y setting of
LMB_LIMIT_DMA_BELOW_RAM_TOP. These platforms have a 4GiB DMA limit, e.g.
for the SD/MMC controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index cf13ac1bdad..27ad43125e4 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
 config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
-	default y if ARCH_BCM283X
+	default y if ARCH_BCM283X || (ARCH_MEDIATEK && ARM64)
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the

-- 
2.43.0

