Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C835BC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CD787815;
	Wed, 13 Dec 2023 04:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kzDaPESY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75BB87813; Wed, 13 Dec 2023 04:17:00 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BB98749E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ba00fe4e94so2762423b6e.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437413; x=1703042213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoASDofddKjMTsJrIPH1yXA9e/CL/xYJR32TzdjQmHo=;
 b=kzDaPESYR3uLadMuFzpW1Kl6A9C3jrwomjUpfE9afyeykdcQR1T40c0NRWORvtDWeo
 StDr8GgMF0I/07RrQWwuxqdsUTa+0y051RRHhmp5BnJSUOqm2Gpg/tuosbFt/q3blmc/
 nLf0VDBMQxP9ynr75EekLuruEZ2CAykjkfCQU8682VSr86VUfXMIMKHlEfoSy2JT1DP7
 v6X8yTOe1Uf6fqGtHKgfQzeNKb9zgGcYHtRJBtAb6/tg90A8EBnchg/lPiftU6OlEcg6
 d9KixMaSf/C3GHOOnvsjUIQVvLOLg6Tr9HLsEs029wJyMw2LsmyH+jKaeMZpgdIwv/8Z
 aQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437413; x=1703042213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OoASDofddKjMTsJrIPH1yXA9e/CL/xYJR32TzdjQmHo=;
 b=jRZoB58kWTBl3vygDfKFavDVvW6X+1/jLEu+99Dtn/BoNWK4o2NSEGzFcZVHQzRaDt
 kwbJWedSHRayp6FqO5BIE9KuBSbP819dy31V/4pz+qbFDL2/mKPs+NOgM2YHVf5hynFP
 haxqd15CYHe7P8HnSr46QbLNS0w/KMhlouRr9rH4GFyW77WpmpO92uaWJfYK0mNREXW2
 1bpdXwklkwTUmPtCFruCmD0OwmLVPMkR7eHLoHTJhoaK7vdzZpbZ+iEeALUtOlYa9osU
 LF8N68e6EbGcEfLr+B3iZu/zll2tTKdbrRMvTYCTyFw999djt5X1xm4DY0mgsXeeCMMb
 x2Kw==
X-Gm-Message-State: AOJu0YxjoqiswH+XByanGG+CulwlM0eMxu+KJwJkAKvhUPoDpkp7peFH
 ZUTm3o4k0HiBeINgypjx64ZMfg==
X-Google-Smtp-Source: AGHT+IHPGKPEFvTND/+sKDxGnDM37fY7iWJggwnxarBUJuwHcuSxaNpyNjA++ZHEeoZPtE5vPKrblA==
X-Received: by 2002:a05:6808:1290:b0:3b8:9b7f:40e8 with SMTP id
 a16-20020a056808129000b003b89b7f40e8mr9741875oiw.17.1702437412828; 
 Tue, 12 Dec 2023 19:16:52 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 a23-20020a056808099700b003b9f6ecb222sm2242503oic.6.2023.12.12.19.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:52 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 06/13] clk: exynos: Move pll code into clk-exynos7420
Date: Tue, 12 Dec 2023 21:16:39 -0600
Message-Id: <20231213031646.28828-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

PLL utilities code is only used by clk-exynos7420 driver at the moment.
Move it into clk-exynos7420 to make clk-pll.c file available for CCF PLL
clocks implementation, which is coming in the next patches.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/Makefile         |  1 -
 drivers/clk/exynos/clk-exynos7420.c | 25 +++++++++++++++++++++-
 drivers/clk/exynos/clk-pll.c        | 32 -----------------------------
 drivers/clk/exynos/clk-pll.h        | 13 ------------
 4 files changed, 24 insertions(+), 47 deletions(-)
 delete mode 100644 drivers/clk/exynos/clk-pll.c
 delete mode 100644 drivers/clk/exynos/clk-pll.h

diff --git a/drivers/clk/exynos/Makefile b/drivers/clk/exynos/Makefile
index c9f29c873e9b..7faf238571ef 100644
--- a/drivers/clk/exynos/Makefile
+++ b/drivers/clk/exynos/Makefile
@@ -3,5 +3,4 @@
 # Copyright (C) 2016 Samsung Electronics
 # Thomas Abraham <thomas.ab@samsung.com>
 
-obj-y				+= clk-pll.o
 obj-$(CONFIG_CLK_EXYNOS7420)	+= clk-exynos7420.o
diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
index 7d869eb02b8e..9caa932e12fb 100644
--- a/drivers/clk/exynos/clk-exynos7420.c
+++ b/drivers/clk/exynos/clk-exynos7420.c
@@ -10,8 +10,15 @@
 #include <errno.h>
 #include <clk-uclass.h>
 #include <asm/io.h>
+#include <div64.h>
 #include <dt-bindings/clock/exynos7420-clk.h>
-#include "clk-pll.h"
+
+#define PLL145X_MDIV_SHIFT	16
+#define PLL145X_MDIV_MASK	0x3ff
+#define PLL145X_PDIV_SHIFT	8
+#define PLL145X_PDIV_MASK	0x3f
+#define PLL145X_SDIV_SHIFT	0
+#define PLL145X_SDIV_MASK	0x7
 
 #define DIVIDER(reg, shift, mask)	\
 	(((readl(reg) >> shift) & mask) + 1)
@@ -64,6 +71,22 @@ struct exynos7420_clk_top0_priv {
 	unsigned long sclk_uart2;
 };
 
+static unsigned long pll145x_get_rate(unsigned int *con1,
+				      unsigned long fin_freq)
+{
+	unsigned long pll_con1 = readl(con1);
+	unsigned long mdiv, sdiv, pdiv;
+	u64 fvco = fin_freq;
+
+	mdiv = (pll_con1 >> PLL145X_MDIV_SHIFT) & PLL145X_MDIV_MASK;
+	pdiv = (pll_con1 >> PLL145X_PDIV_SHIFT) & PLL145X_PDIV_MASK;
+	sdiv = (pll_con1 >> PLL145X_SDIV_SHIFT) & PLL145X_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+	return (unsigned long)fvco;
+}
+
 static ulong exynos7420_topc_get_rate(struct clk *clk)
 {
 	struct exynos7420_clk_topc_priv *priv = dev_get_priv(clk->dev);
diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
deleted file mode 100644
index 407fc71d415b..000000000000
--- a/drivers/clk/exynos/clk-pll.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Exynos PLL helper functions for clock drivers.
- * Copyright (C) 2016 Samsung Electronics
- * Thomas Abraham <thomas.ab@samsung.com>
- */
-
-#include <common.h>
-#include <asm/io.h>
-#include <div64.h>
-
-#define PLL145X_MDIV_SHIFT	16
-#define PLL145X_MDIV_MASK	0x3ff
-#define PLL145X_PDIV_SHIFT	8
-#define PLL145X_PDIV_MASK	0x3f
-#define PLL145X_SDIV_SHIFT	0
-#define PLL145X_SDIV_MASK	0x7
-
-unsigned long pll145x_get_rate(unsigned int *con1, unsigned long fin_freq)
-{
-	unsigned long pll_con1 = readl(con1);
-	unsigned long mdiv, sdiv, pdiv;
-	uint64_t fvco = fin_freq;
-
-	mdiv = (pll_con1 >> PLL145X_MDIV_SHIFT) & PLL145X_MDIV_MASK;
-	pdiv = (pll_con1 >> PLL145X_PDIV_SHIFT) & PLL145X_PDIV_MASK;
-	sdiv = (pll_con1 >> PLL145X_SDIV_SHIFT) & PLL145X_SDIV_MASK;
-
-	fvco *= mdiv;
-	do_div(fvco, (pdiv << sdiv));
-	return (unsigned long)fvco;
-}
diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
deleted file mode 100644
index 7b7af5e67612..000000000000
--- a/drivers/clk/exynos/clk-pll.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Exynos PLL helper functions for clock drivers.
- * Copyright (C) 2016 Samsung Electronics
- * Thomas Abraham <thomas.ab@samsung.com>
- */
-
-#ifndef __EXYNOS_CLK_PLL_H
-#define __EXYNOS_CLK_PLL_H
-
-unsigned long pll145x_get_rate(unsigned int *con1, unsigned long fin_freq);
-
-#endif /* __EXYNOS_CLK_PLL_H */
-- 
2.39.2

