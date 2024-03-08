Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51570C54798
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE0387DF8;
	Fri,  8 Mar 2024 03:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ar2pz6BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B0A87DED; Fri,  8 Mar 2024 03:19:23 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A45E87DEC
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6e4e952467fso240142a34.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709864341; x=1710469141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Juw2einEC1iQZ6BawJTpgpXHVSfj774S5RuBjjGBRY=;
 b=ar2pz6BYUM+Ks0iFhjfnE6nYiLE6iZD9S71ScJYac0iFri/4cTPei1ClUAWYraVw96
 C4ezTxbnJdwv/E5R1KRSeOJ+xOpzaUxIyzChtxYZlQMWlXOoqHZf4W/PEjj8C3fONUgx
 tzdhKRl+/npfRaA0CZsw/oPcQ4ToyJT0II5VfuhQwxXu8WIZGB6/b1/mHjNpuOj+zlGy
 I9wEBg3z0akmVqIVtnnaiSK8d9/mN2YDSuDjzEY80OpIYtlV/HTHTosLRkujIG11sCf+
 Lv/tiHbgNNruknSL/V/6r12L4+bFPoKe5cSP8B4+4gWjp7+lBGM0a3w3BwGj6nbsRXl2
 vFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709864341; x=1710469141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Juw2einEC1iQZ6BawJTpgpXHVSfj774S5RuBjjGBRY=;
 b=Jwudk+iNXY5/K6PPGelDF7hS7Rg/f2cqTUpYw3XEOu66DOttHOThApkMEv2vxHHzU1
 0MMwLbgpyFriEFGwGfsWqEdolJObd/X3YI2GuUcdPZ7kPjSksZqkx0bgU2Wm5hJdSq1e
 mgIWSAZPEyHzu+ZoeiMSBJClMkKUQUi1jzoZQb//thL+nm+zALTtLaXDVHFslRB0ERxz
 aiODnJigh/nWYM/sydj4WSzcCF2BmJBHCAjBO5/nZOvkN7GjbZGv4oLtM5X6Y+N4NhUs
 A2s1UCthdmeXtoXhiYIWY5TVN9bumGbrdiHo/RQ/9xoTDgUjdX4V1HNtA7JnDY/yaMjo
 zSbw==
X-Gm-Message-State: AOJu0Yx7k2v/rssj6RY/B78KgBWo4Ac8TR5j+XHfurGPUfXuwHzNdyNg
 nh8vAVcjX5eR5VFuK5O9OBd4lkTchwdhmz0Tk+CPMpWc1FHYrEJBN+gn8xK6mKo=
X-Google-Smtp-Source: AGHT+IFrrZ4qDVtSd4vOpq1N18k0wMqETfUbCt1bEN+fHTG/GVNDCEnochzMi/u/SZ8SKg+4qSyUkA==
X-Received: by 2002:a05:6870:414a:b0:221:45a1:b802 with SMTP id
 r10-20020a056870414a00b0022145a1b802mr1734993oad.24.1709864341011; 
 Thu, 07 Mar 2024 18:19:01 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 wh13-20020a056871a68d00b002208ca7a9aesm4302607oab.57.2024.03.07.18.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:19:00 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/4] clk: exynos: Don't expose prototypes for not used
 functions
Date: Thu,  7 Mar 2024 20:18:56 -0600
Message-Id: <20240308021858.28249-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308021858.28249-1-semen.protsenko@linaro.org>
References: <20240308021858.28249-1-semen.protsenko@linaro.org>
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

Samsung CCF is meant to be used from the clock drivers by calling the
CMU registration API, i.e.:
  - samsung_cmu_register_one() -- for top-level CMU
  - samsung_register_cmu() -- for the rest of CMUs

Functions for registering separate clocks is probably not going to be
very useful, and isn't used at the moment. Remove prototypes of those
functions to make the Samsung CCF interface more compact and clear.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/clk-pll.h |  6 ++++++
 drivers/clk/exynos/clk.c     | 12 ++++++------
 drivers/clk/exynos/clk.h     | 16 ----------------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
index bd79309fa1cf..00c750687072 100644
--- a/drivers/clk/exynos/clk-pll.h
+++ b/drivers/clk/exynos/clk-pll.h
@@ -15,9 +15,15 @@
 
 #include <linux/clk-provider.h>
 
+struct samsung_pll_clock;
+
 enum samsung_pll_type {
 	pll_0822x,
 	pll_0831x,
 };
 
+void samsung_clk_register_pll(void __iomem *base,
+			      const struct samsung_pll_clock *clk_list,
+			      unsigned int nr_clk);
+
 #endif /* __EXYNOS_CLK_PLL_H */
diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
index 430767f072d8..14ccd2cba374 100644
--- a/drivers/clk/exynos/clk.c
+++ b/drivers/clk/exynos/clk.c
@@ -10,7 +10,7 @@
 #include <dm.h>
 #include "clk.h"
 
-void samsung_clk_register_mux(void __iomem *base,
+static void samsung_clk_register_mux(void __iomem *base,
 			      const struct samsung_mux_clock *clk_list,
 			      unsigned int nr_clk)
 {
@@ -28,7 +28,7 @@ void samsung_clk_register_mux(void __iomem *base,
 	}
 }
 
-void samsung_clk_register_div(void __iomem *base,
+static void samsung_clk_register_div(void __iomem *base,
 			      const struct samsung_div_clock *clk_list,
 			      unsigned int nr_clk)
 {
@@ -46,7 +46,7 @@ void samsung_clk_register_div(void __iomem *base,
 	}
 }
 
-void samsung_clk_register_gate(void __iomem *base,
+static void samsung_clk_register_gate(void __iomem *base,
 			       const struct samsung_gate_clock *clk_list,
 			       unsigned int nr_clk)
 {
@@ -84,9 +84,9 @@ static const samsung_clk_register_fn samsung_clk_register_fns[] = {
  * Having the array of clock groups @clk_groups makes it possible to keep a
  * correct clocks registration order.
  */
-void samsung_cmu_register_clocks(void __iomem *base,
-				 const struct samsung_clk_group *clk_groups,
-				 unsigned int nr_groups)
+static void samsung_cmu_register_clocks(void __iomem *base,
+				const struct samsung_clk_group *clk_groups,
+				unsigned int nr_groups)
 {
 	unsigned int i;
 
diff --git a/drivers/clk/exynos/clk.h b/drivers/clk/exynos/clk.h
index 91a51b877a63..14e06b2030fb 100644
--- a/drivers/clk/exynos/clk.h
+++ b/drivers/clk/exynos/clk.h
@@ -179,22 +179,6 @@ struct samsung_clk_group {
 	unsigned int nr_clk;
 };
 
-void samsung_clk_register_mux(void __iomem *base,
-			      const struct samsung_mux_clock *clk_list,
-			      unsigned int nr_clk);
-void samsung_clk_register_div(void __iomem *base,
-			      const struct samsung_div_clock *clk_list,
-			      unsigned int nr_clk);
-void samsung_clk_register_gate(void __iomem *base,
-			       const struct samsung_gate_clock *clk_list,
-			       unsigned int nr_clk);
-void samsung_clk_register_pll(void __iomem *base,
-			      const struct samsung_pll_clock *clk_list,
-			      unsigned int nr_clk);
-
-void samsung_cmu_register_clocks(void __iomem *base,
-				 const struct samsung_clk_group *clk_groups,
-				 unsigned int nr_groups);
 int samsung_cmu_register_one(struct udevice *dev,
 			     const struct samsung_clk_group *clk_groups,
 			     unsigned int nr_groups);
-- 
2.39.2

