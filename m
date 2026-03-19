Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604E81091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29DB58409B;
	Thu, 19 Mar 2026 21:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nosPTL6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1B583FDC; Thu, 19 Mar 2026 21:02:33 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDA983FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-67ba5b0e00dso456730eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950542; x=1774555342;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=498fgupypkT/7ALUyxAdjjlQYQdw/jR520JOWJVQdoA=;
 b=nosPTL6NfwVr+VbXDUf6JX6rYUmEaFDrMGtYFFsTOhWePdQ7VkZfhneRlXq8fQ3V9M
 SzJJa8+10l3tBkrx1VvoUsz8BMzHJ34M2pg2Oowf26TVIdRTolmVnFw8rPN7taOPOD05
 3Sz/J+wCpsRpwBPZ5fY8JOXAhGsavax6BJp4rApCwCRj017WI+34h8+//2klENDP7hDY
 yZApo46yxOkj0ZQJTCB0rTB+Z5GhlSlmEU/tWctJdMwPQsH3nGU3uq5cOx2L1SmcmMA8
 7xSReBkLbeBy+3Vs33NVNe9+M664ujdGh/m6SPAsk4JzGOfkUCDf2uvepvFNSpAwRR4c
 1wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950542; x=1774555342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=498fgupypkT/7ALUyxAdjjlQYQdw/jR520JOWJVQdoA=;
 b=JVQwuYy3UAEnRuJHqgpzgPK8GInI9Y0tlEnlJ0ki5b6ecgXhpDQ5wGWMpVQsQWfh6d
 /9PMhIupOkvYxsrRWjhR9LJzHzD6jZxGqwN4Q330Uh3AeFL4mQLuKmvUE3OoR9p8WPEB
 IEJuuxNyZZRxQT54XFf/t4y0dzn54M2NQz1Z9tZGtfd7jnq+7FYroQB5LsQ1EuLP8gT1
 lyVEp+eIb2MM7Vkk7WEjWUWJ7+EsmKanhIbXWVjkVeHc1LYi4JiDuWh7/8Xos4fUnown
 uapG5P+QRQZNSHUS9ohjYuZbfFt82mUs6H1njb7fqcrvKhsOOUKzt8eJM+rxgQJaIO9n
 YRJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhuOJvKeQ/nTph8zqWaf1YejMKDH4cAMqXHQvHP1yz+AEmCz5amnkOvpVmWjMSRpUXH/ggIrs=@lists.denx.de
X-Gm-Message-State: AOJu0YwwK1kM8eGjhRQ8ErIJhVA4q7GuypLfKsz/BoKhBMbe9JZAz6o7
 svQGKiZL8Lyh1gbsTQ9CSmk0pCFcygomtv3z/mn1/7qvSqDzs0EFp60N9V03dxJDPyk=
X-Gm-Gg: ATEYQzw3ggI/KVITssSCSd3OZ+0mWTGMOyR9dAIDECpJBluz/woQDTXNamnewimT6Iz
 +GYpwmyMp/0qUWTwOLqwW/xv778FTYVSkw3P6yxpJgODVXt9Tg4GfKAQFTk7vXs0zuQspg2Pk6S
 hIaXdFN1g7ARlFQeYXs4vUFB9v635qIEkmOBSeTwJohVwKhJWW5NwYFPgk65N0g8ydnY8GODRey
 pXRS4PTpzRcEwjTRk67e+zg55kSAEBMTIPGu+T9kRlWc0TC38YLim5mF8FRIlR5TyWkxAj3IedC
 6XXS8XVcg4VnUygETzzbcG9wAYLbldc4mCynOn/iiIKHt+gBNtnxOpm1Dy81/978/TZlSu5XBeZ
 CYf9VyR7eLQhi20Vg/JOa0EDrCfkvxOLBrHnX6D539tfTR/nxWUwf8x+CJivOAUuF+m9XqU7OsY
 iwt1Rpo/ddO8P8WL24eRZRaUY5Lqq3JxEeD7EethY=
X-Received: by 2002:a05:6820:811a:b0:659:890b:3f9 with SMTP id
 006d021491bc7-67c22bd5f1dmr528235eaf.4.1773950541716; 
 Thu, 19 Mar 2026 13:02:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:16 -0500
Subject: [PATCH 13/17] arm: mediatek: mt8365: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-13-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=k6HsgA3Io6U+5aJO5gFpYh9AHHhooUU7fvkQMmIqF/U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYc4Ippk8c7iRQxpn5WYaItNagfCsg7OeQHz
 6RC1A7mnMSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWHBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALgMH/i+yjgbsAF28v8t+9exBKZwD1ceIWi9mHQ16j9y
 MNmfpgXKdWtQdacK3OUgrGBETkhxKDNX2DgdHv8Eq2WnTWmIL4/+rggTmn49NhOL3FsdkIDW69U
 dwGd0LWiJ4uYezjmjCumDLKZCLzkwcxvLgkBkvGzY/EQjYtpqOtF4yBVlROMsjjVG9smAXN9Nyn
 P5MZEnjuHV/I4pTk7pdoxPC3sohk1bhVpWvV4FtgPAnG9V7h6XkuaD5W3Xa0zIEb7N25WyONGTC
 B5aCGLZFrPzit8soTy7O2WksB3nfSYabGAmzu74xv4Ky1zMEPrXXaJAG9/cuZVuSyP6O7CYHpZG
 N0dk=
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

Drop override of dram_init_banksize() weak function for mt8365. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8365/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8365/init.c b/arch/arm/mach-mediatek/mt8365/init.c
index fb14a5a1902..1063dbf72a9 100644
--- a/arch/arm/mach-mediatek/mt8365/init.c
+++ b/arch/arm/mach-mediatek/mt8365/init.c
@@ -18,14 +18,6 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	struct udevice *wdt;

-- 
2.43.0

