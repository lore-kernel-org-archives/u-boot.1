Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B01C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 20:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C35A81112;
	Wed, 26 Feb 2025 21:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CN8nFs/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A14C810F4; Wed, 26 Feb 2025 21:31:29 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B57810EA
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-47220d28138so2624461cf.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740601886; x=1741206686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lc9uelWGUxbsP75/nhwg4K/aad6UTtxYE8DrEtq+ro4=;
 b=CN8nFs/mlR/Kz5vT0crHue6IWXKBic/xFRvc4ZR5iImktJ5LPLRm+s/v64ht3F/cfm
 xActIM/W8QQPzyqdQhV2WRcP8/WApRvaXjR8D//Q+dVbOmKNBW4RexpyttJz2dODiohM
 02w2q49fC+6zkr5L2ZpK8FKQh7tgX7gXkpVEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740601886; x=1741206686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lc9uelWGUxbsP75/nhwg4K/aad6UTtxYE8DrEtq+ro4=;
 b=MhKDtYK8S1BjOVoZ4buuj4q1Uac0VlFlhp0iWtIGTEBE7NFLXeHnKSfWSv7tJ+tWKg
 oTYS4uOQd9ak/A4W9jBAKAnI3kc8GFofddswhWA4tddQ3x6m8161jmyMP7P9ASB+wHj6
 fFB0BFeIpw6yQevqSZHYV39zMxKt5XU/Mz3N1e7uss6AOBNW+/Krdy1w5bRJgVMvLl1s
 9Wnh+X8Dh3PVXwr3G40s2pNQynXixu5hH6KDf19YQAJzx0A7DE987BbQDr7dEcC5Yilo
 ksBVxpS5l8z19Bz+3515A8RGBUtzr1Aye7d1XNn+THYosWqj9sZ3GxezeMt2TWqJyO1L
 JYCA==
X-Gm-Message-State: AOJu0YzsPXNJak6lMo/7W1yCZB6QdXeiFZwqfOXWnzeu5sT0WwlykyDH
 LiDLWXmAdgvmxiFAL7ASnlrZrd8HC8NstQfwGktYdPxFHYeqaCruHUnAtCEA5KrvRFMAwn6IUFD
 F
X-Gm-Gg: ASbGncv6yZuDuodctRZzzzKUmVszXH55Q93/BSgSf0/ns66eExkQfS7f/cThIsSAic/
 V608/bXHwVS6OjIgZ755kn2W2cRXsF/ObiPPYFq8M4TqRW20z988eeB3ryQaCDK98HGzb3n7C1Y
 W/pClhgUw+d9IQGQSiGP2TzQRzzJxFDCMSSiPksDhfafksKPswwsH+vqqMB0dXU0dqkxR/WAUlC
 xPOOYmU7FlgIDVZO2Uh42p7akYQ+scCY5wcjrRaDJ8I20LPaH+ox9kMU34bxAm/Hzd3+hVIsfhD
 2ImHztJechG9TAj07FYIEy2knuk=
X-Google-Smtp-Source: AGHT+IGC+lKUeq2UD4RMuNin6SJRu8s3J/y5W1YeawbjvxsBrPbv/FYI+yOPnHlaQtKEUbUT8qFLsA==
X-Received: by 2002:ac8:5f54:0:b0:472:1512:c602 with SMTP id
 d75a77b69052e-47377227fe7mr107881431cf.25.1740601885606; 
 Wed, 26 Feb 2025 12:31:25 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4746b4f944dsm494651cf.29.2025.02.26.12.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 12:31:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH] clk: rockchip: Correct usage of IS_ENABLED() macro
Date: Wed, 26 Feb 2025 14:31:23 -0600
Message-ID: <20250226203123.3831960-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

These two files were using IS_ENABLED() to test for CONFIG flags but omitted
the CONFIG_ prefix and so did not work as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/clk/rockchip/clk_rk3568.c | 4 ++--
 drivers/clk/rockchip/clk_rk3588.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 977699d509d6..533031caead6 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2680,7 +2680,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 	return ret;
 };
 
-#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
 static int rk3568_gmac0_src_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct rk3568_clk_priv *priv = dev_get_priv(clk->dev);
@@ -2859,7 +2859,7 @@ static int rk3568_clk_set_parent(struct clk *clk, struct clk *parent)
 static struct clk_ops rk3568_clk_ops = {
 	.get_rate = rk3568_clk_get_rate,
 	.set_rate = rk3568_clk_set_rate,
-#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
 	.set_parent = rk3568_clk_set_parent,
 #endif
 };
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 6042fc10cdbd..8c3a113526f9 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1822,7 +1822,7 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
  */
 #define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC 60
 
-#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
 static int __maybe_unused rk3588_dclk_vop_set_parent(struct clk *clk,
 						     struct clk *parent)
 {
@@ -1915,7 +1915,7 @@ static int rk3588_clk_set_parent(struct clk *clk, struct clk *parent)
 static struct clk_ops rk3588_clk_ops = {
 	.get_rate = rk3588_clk_get_rate,
 	.set_rate = rk3588_clk_set_rate,
-#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+#if (CONFIG_IS_ENABLED(OF_CONTROL)) || (!CONFIG_IS_ENABLED(OF_PLATDATA))
 	.set_parent = rk3588_clk_set_parent,
 #endif
 };
-- 
2.43.0

