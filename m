Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A092C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6033387608;
	Tue,  7 Nov 2023 22:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JO7P3TS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04E38760C; Tue,  7 Nov 2023 22:22:04 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6504F8760D
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b3f6dd612cso3627003b6e.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699392121; x=1699996921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dLCGF8YJJVWI3B78aL8znwuEHe9qxhGHsPhEzLlRGbg=;
 b=JO7P3TS5nYDjD/hH3BjJKkzr0x9juCJvm0R2XSIy1ouPFbWJWiTZyCm9pVflwSO1St
 LQp+X/J/sV6ar7lFxmbfgF9hNNTt1X3kHVO/E9JZIB5pqWXi5wY/6nPlwcmsfJrlXpTt
 l8B4cxNWKvWzlE3S9uET3AJ6OQuijEWLGtdLvpb4K7Nqfjs1uBVTCBI6LnalTSsjkFnP
 9dQs6XaMK1T07n1gNBSWC0Gdz19ZWj6K4RMWkNnSchNklDns58rb5HVrH3qiyg8Fj6vs
 sVRDsfplXh8GAettHjTeZwMB3gfo0gmisfODF5+HBGeRes9GolXBnDaXIKbnDhLXlW1l
 9qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699392121; x=1699996921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dLCGF8YJJVWI3B78aL8znwuEHe9qxhGHsPhEzLlRGbg=;
 b=w688FPfoWHPnmeguotQGbVnF2BKWt/qKnqL4J6Racms3QdxT0XCaiUizgFidUvQUMD
 2DyUJFYePrtP3C/xVgxDkz5DDAXi0dOSMmwGf8d6yBmXAMTqTQPQyP6/Ot7uTNkeHOLn
 YJ91yNsvJ9toS6cxbt8xPsgtFmw6a8j/wFP97KSNyGoSo3arprv5zUlq9pN0pq10+vd0
 +w65FSVqbTUqnsKe0uzultJLKG81ndjSjRYdbK5JwwY69avDx8K24iFhtwMHVv8roOsY
 o2lVDf1yDY2j2ToHdLDxN2hQ8gZUnz5Z0gXoUswkULPGQV2bfMMuS/8mdugdhEsQwPbi
 jQpQ==
X-Gm-Message-State: AOJu0Yw+h3lWU+h12Sao8dLLQpiUxekgjDbDWn46mATyMn5/QU2pASaE
 w/gdH7UTVPqykYL0fqHESanD4A==
X-Google-Smtp-Source: AGHT+IHtbv/4fiekjeqkG3bXdWpZoVjhPwmzq1ZBuUlf+214REhM5HqVEAFj1qrLDf1h7RE2wgHk3g==
X-Received: by 2002:aca:2b04:0:b0:3af:8672:36f8 with SMTP id
 i4-20020aca2b04000000b003af867236f8mr260410oik.7.1699392121068; 
 Tue, 07 Nov 2023 13:22:01 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 q27-20020a0568080a9b00b003b2daf09267sm1688094oij.48.2023.11.07.13.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:22:00 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Thomas Abraham <thomas.ab@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH] clk: exynos: Add header guard for clk-pll.h
Date: Tue,  7 Nov 2023 15:22:00 -0600
Message-Id: <20231107212200.1457-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The clk-pll.h is going to be included in multiple files soon. Add
missing header guard to prevent possible build errors in future.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 166097e87753 ("clk: exynos: add clock driver for Exynos7420 Soc")
---
 drivers/clk/exynos/clk-pll.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
index c79aac44258b..7b7af5e67612 100644
--- a/drivers/clk/exynos/clk-pll.h
+++ b/drivers/clk/exynos/clk-pll.h
@@ -5,4 +5,9 @@
  * Thomas Abraham <thomas.ab@samsung.com>
  */
 
+#ifndef __EXYNOS_CLK_PLL_H
+#define __EXYNOS_CLK_PLL_H
+
 unsigned long pll145x_get_rate(unsigned int *con1, unsigned long fin_freq);
+
+#endif /* __EXYNOS_CLK_PLL_H */
-- 
2.39.2

