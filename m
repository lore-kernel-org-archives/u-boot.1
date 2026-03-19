Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1551091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C1083FF5;
	Thu, 19 Mar 2026 21:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NpM41KtV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD1083E36; Thu, 19 Mar 2026 21:02:19 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B54F83F00
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so104483a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950533; x=1774555333;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xkvwj0duTkG2HxsrKQDQnF52NzeLzoe/CYmYq2+6c8Y=;
 b=NpM41KtVpz7o1rQO3zF90tZtWzlXa3YpFt0IVWm1fu8lFKZlM4WHQHCACsOjY1zpWz
 sU+9bepclL8Dl23TitoDlfbjXqBbWeP80SsEUTiQBnRHzEmExQyJ97+EiPfaXvP3bHcz
 q59Im9nvJDxFs38mHmYv97ECjAnUXVcF3QeTe5xLjoU30FSu38ouxlnpAOHl1/nKromY
 KHCPikHiNBl4p3WBkqjzrCRSJKyfsL1JCJeSsbiKZpVgz9pLX17pxBDZRWTmOwOjLtxX
 DphPl0fR9lEQzAlNzHUNdh3/g/GkTALqgQJBNGyfn7ZLVa9ZUjv6iZJRFEbSgEgj6dcf
 MnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950533; x=1774555333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xkvwj0duTkG2HxsrKQDQnF52NzeLzoe/CYmYq2+6c8Y=;
 b=TdStT+J1fDUxmzyQ+9ky8nqFFitFbRZeJcvST+N74oIHGSt8ah53Qbi5gptR8CCMRl
 oP79ee48xyZY25kz5d8+JzmDR8mCHaa/G+HBH4jWVirhxQD8dkh3k9pXnlFBlxBZwXny
 ss6JjSQVsaQ2CDQEisIF9DXVFVlHl2IwVrwoZQ6AM2iwiN+2ylsw6J3Awsvczla4EMYl
 tSNnspi2ORuU5K+BaqXgFzbQkfmSh/MMUV0HKDANikXQB3Y0E+hijTqGk4Gcc/pLtba1
 r+HrtoGCkzWngvJOwjjJfM04RElsE1wE5/pEsOZv0MOl5bmjVhfHIUE2d3uomACKEZIN
 jBQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe8V3aNfbcFKgm7KGw/DM6DUbw6RlRz95lGfvQpc5B7mzpmR1at1N1Nw4xdUNAkzCOL3VhZuM=@lists.denx.de
X-Gm-Message-State: AOJu0YzzbkfqND1pehfJGkvub1bIuhL7I/lfTWuJoxHvtMWzN0egXA4S
 Ea8uNwt1+8AjcjbDEq49EBNMA7XMo62aKqJegeqJ/bXMUyxQPfF37XKdS6ttsj2NR4M=
X-Gm-Gg: ATEYQzxH/H0Q5WpHLB6fxFCnUkHHkokDSg04u0GII5sMXQzLBGDrlo1d+NleYaOhZnI
 1bC9lxBKHLUNdrIvp9aJClGLe19K95ShVepSG46ZTyWBr7BRm8nVhH7EbjB1tB86dPIJiZfEeKS
 St2XjrvBohmy+A5qjivAnIUlOsFUCEIT4GI6zZUiI7i4ymK5ysE5cFRBCxWkAWaplY9dmww3Sx9
 DVJ90wn91sFzE7TsV79WbHYmBmFujWDD7xkDOVdyTiFujKYmtn+4rEJEI3WMj1jUwDlsJFYw/Rm
 /TqxWb2EsovP/PcuoYtWuPklkwAXnuUTlrUgmP3xbM7zk+XL9zg7xuxVYQzK8pYzjSAoYgjLyv5
 /tfQWDbYAK5VpfJbu2klIf8iDV6y0z42vURwLLLGXtWo24oRNtNBmF5cCUdiKNbPSniYedv+332
 8zNMipLzZDohdKM2/SVVfkjpGFEqLd
X-Received: by 2002:a05:6820:1ca4:b0:67b:f37d:1e6b with SMTP id
 006d021491bc7-67c22bd0b33mr574946eaf.14.1773950532932; 
 Thu, 19 Mar 2026 13:02:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:08 -0500
Subject: [PATCH 05/17] arm: mediatek: mt8188: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-5-6171ec141f40@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ax63hfmL5f0W279D5Wjf8gR7F8O8cCfi/qU89CBBu4Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXnXp2Xs2F2qx4ECt/imh/h2kyRKQ7oP2a12
 FO8HJOxRAeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV5xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+NAIAJ789rUvJa6OjDPYj0DkqvxLVsS+zMtFzoOljd9
 LZRx+Aq9mjEn78hl+ZU4170v91BHCAJ15YdKoUSdH9rrxXicF9WexMbvDEfNW7b7dstdmCkB2J6
 Z+eK4px9KL1vamvtEMlRYb+gx8ZlCRcskmW8raNW2aNO9GpY9aYE2YyxYOsqMDCDeHdb1r/WYgi
 L75YALsYs3JLseFiNKNt/KwaanS7L8XbjjGylrKeaDNU98JK086C/KIH4WmmWOM/rGjpq2wtw18
 xoVEVa6sNmnNPLBTj3NLH6nJGl8d/Pkz0kMg9M63ep5bQeJ3+So/fmbQlgYdcCBjefPFVztyL7T
 jke8=
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

Drop override of dram_init_banksize() weak function for mt8188. This is
effectively the same as the default implementation, so we do not need
to override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index 9743e39d582..61676e8437a 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -37,14 +37,6 @@ int dram_init(void)
 	return 0;
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

