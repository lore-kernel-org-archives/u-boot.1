Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17958C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5643387A36;
	Thu, 11 Jan 2024 04:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="svLcMEU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361738792C; Thu, 11 Jan 2024 04:09:28 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA20287ADC
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6dde00025faso1794422a34.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942557; x=1705547357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZamB8HQFE3xnEU3Kog2EvJx83VWjNRAeNl6NTTGjZQ=;
 b=svLcMEU96uDWY5OFf4iBa9hfMJUvHOu08EFI8rQV9eZaxUJIPPC9lylJ2CCZBHmnXv
 qvmTy5XntQ9XllOKNbXqJu76EjoeY51YV+aHXgutx6ZGQVvr3lVDy/TvMkTTTIexnS1u
 XmXEHx7Qfy3p8w4mO6zJa83lewhxcrkiiDNaamyNoQW2qpRs2eAU5A/oUe5pof0gHGh9
 /wlzOHbioIhnqRpf7gTYewwdI+944BQyqqB+Bmm6iFAf8lwwBqQNhrv5kwiYsodFC0mV
 2byVpm//WDCTJb4cMYzJHNvkqNWX+gNDO0BvO1ULcvOfsDBOFiYDzeEt6Kwc/ygHjfdv
 Pb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942557; x=1705547357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZamB8HQFE3xnEU3Kog2EvJx83VWjNRAeNl6NTTGjZQ=;
 b=mAPgFOwghkJbdF09JkUXwDnUsReU1rjH2U78j3D0aqSirKaBx5cYTZ+PF88ix7TgtS
 GGFlgyoVJKf7B6fq2EFvUh0p2nEflIx8GafLB5L7u77ZSEQkRhJwSE3qRuuSMytNhKgb
 T+c95G/W0V5DXUFdsUWCgJmAkywRc3BUzPRZNHbN7aH/iswVrj2Ft6Dj9c1FjMWnw2tV
 omIOhPVkF5pTjYZjmiELxT6MMn61nZMJSttSWVG9z9Q4RCnr7LISWRbFRbohFgzqYLrp
 UlifNgXDp5dtRXPCVNyybjmXpISg+CQr0chj2HSTH+E9J5uUScROeGRH5KfLJzbs7Mnv
 VhgA==
X-Gm-Message-State: AOJu0YyKAQhKGZOWzfI7ZzrQoBhOCmH/CpQNO79GMCoZWpb54Rt33lk+
 /UK+XObOuPBwPTo9YUBL2sqI90AAaMzxNA==
X-Google-Smtp-Source: AGHT+IH1kp5+BI14h9pnnvOKGlh9lPIFbnhUlXT5VpMYHIg6Hug+MvdPtovjpI9Px7NaoEMpQOJE3g==
X-Received: by 2002:a9d:6301:0:b0:6dd:dda6:67b3 with SMTP id
 q1-20020a9d6301000000b006dddda667b3mr621811otk.67.1704942557342; 
 Wed, 10 Jan 2024 19:09:17 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 w10-20020a4aa44a000000b00598a2ef41ddsm11493ool.44.2024.01.10.19.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:16 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 06/13] clk: exynos: Move pll code into clk-exynos7420
Date: Wed, 10 Jan 2024 21:09:02 -0600
Message-Id: <20240111030909.27373-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111030909.27373-1-semen.protsenko@linaro.org>
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
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
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
---
Changes in v2:
  - Added R-b tag

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

