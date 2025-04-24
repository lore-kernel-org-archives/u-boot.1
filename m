Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FB0C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8431E8209F;
	Thu, 24 Apr 2025 11:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mg12ebYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68285815D1; Thu, 24 Apr 2025 11:17:06 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 669838205A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4720605e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486224; x=1746091024; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9bwL1wd2CpXUlxB1fSA0JXQBPiq2c1OwdneCn7snAag=;
 b=mg12ebYvI+QytsZ9zrTxGrDNiTrvKpwgfEB1pUpFin+sNzVrsZy1ipzaqVERl2nHF9
 dK8H53ucwpWGVMAZisc5zZgUrW7b5a7JyqRMJTFREJ1OhSc2tm5F2VjsSTkDZPtcuuuG
 eSGNQ2OXmvyz5J3SFKzlqoBE/9PdJLJB22bC8Y1sbDnpsxFl+71kfoEK4wl0wIXYZIO/
 r+P75EGGNjBW7Z+lTSkfMeOBbsPKDhAWiiWsn01c5VBbq7tFiFrnNmOkIpJPlboNlsmC
 tqBktE/L7M5AYcSc/gS7e3K+rLpydcrzW1BNrhuawX9ZeXbELUBLl08rW3gAj4udp3z0
 +eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486224; x=1746091024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bwL1wd2CpXUlxB1fSA0JXQBPiq2c1OwdneCn7snAag=;
 b=NVjFUmJ7CJVNyku9rtfUFvJRPB2ZvIBwQKmvU8PCn/5gW0wxmO1WSKVofaOUz3ht3D
 5u+KhEKgXCQ3Dj18ZAlBcEqd+dMOxrNrLsQvNO1eYyRa0RxJ/NCWK65B72lrNm32rkS+
 xiOJhDOowsO2VBkbv9UeKdE/PFvRDwLzfWvKUygaWBcmh6n81PZd83TrpL3DiRhsIJU7
 xJHsmrXw5fyLFJ4d9auSuD02+pdSz4RGezc0tVXUO7ccknMFpoKzgOi05fuN+CzcB2pT
 dQXHpUpj76J/CUvKgzCFe1zjbuc+qO/++z9xyUH6tdNwLxVKZK+DaLVRXY0pBsEE5ssV
 831w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ6M+VKcvOk/zLlYZND0Lt1WrhIcxouoeNonOCAT3Flu6vnif4dg382rhpVhACA/RkQcFTjvg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywro6x9PF+583jUFbhYOxqQv8qf00wUJJQIgSfDfG+7t6teQVmt
 KPsuYxX1SUOpr3U8wN89NRgnyz2LxSh8BiKiFsdm3kESFGakjUlq61B+SJxKjsE=
X-Gm-Gg: ASbGnct1c0TCT8AnZT04o0n7A+uH4faP6Ivi+z3lB+T8LUW5YxvlNUd4CBl5NVu7BPt
 lwcjLlPWLOw6lRovyQNr9ohCKpCg/7PRDI+8vxmJHZfXv0AqAgT0eItehLxtxh+kYKL7CxJ6YoU
 QayhDethnMdDrmGgY4CkR80X3fTvD7PlSPB/ApD5cLhHBt4ZVun6czbsxVymaeZkMwYlh9v30tL
 D1SVOHkdbWozDLMkY8Cy4EN2GLURG4Y9aDoYsztnhRMH5jndIaD7nGmKqQphXXFs7jZY17vr90n
 5AqEs/NVOo+8Pb1xzVp7zNB+3x95UHlI72JJt+Y9iiGfrQpqao4iJbt5euoXOQ==
X-Google-Smtp-Source: AGHT+IGAKA2RleqChaAoVUcdbNXY/HKz2ZoHg25IknkDTL8F3SOpH0Mn0T2R+jzThy00PPzjr9cajQ==
X-Received: by 2002:a05:600c:524f:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-4409bd0d02cmr14485425e9.9.1745486223756; 
 Thu, 24 Apr 2025 02:17:03 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:17:03 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 24 Apr 2025 11:16:46 +0200
Subject: [PATCH v2 6/6] clk: qcom: apq8016: Fix SDCC clock warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-apq8016-clock-fixes2-v2-6-fcc371c9e45f@linaro.org>
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

As of commit dc8754e8e408 ("clk/qcom: apq8016: improve clk_enable logging")
there are now warnings in the U-Boot console on DragonBoard 410c:

  apq8016_clk_enable: unknown clk id 122
  apq8016_clk_enable: unknown clk id 123
  apq8016_clk_enable: unknown clk id 124
  apq8016_clk_enable: unknown clk id 125

This is because we don't implement enable() properly for the SDCC clocks.
Currently they are being enabled as part of set_rate().

Fix this by moving the enable calls out of the apq8016_clk_init_sdc()
function and convert them to the equivalent GATE_CLK_POLLED() definitions.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index e3a9807f580bc995395bd5debdb8d7a9dfa54795..b7bd9c9a342a4666738d87fb02eb679b2d189382 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -23,10 +23,7 @@
 #define APCS_GPLL_ENA_VOTE		(0x45000)
 #define APCS_CLOCK_BRANCH_ENA_VOTE (0x45004)
 
-#define SDCC_BCR(n)			(((n) * 0x1000) + 0x42000)
 #define SDCC_CMD_RCGR(n)		(((n) * 0x1000) + 0x42004)
-#define SDCC_APPS_CBCR(n)		(((n) * 0x1000) + 0x42018)
-#define SDCC_AHB_CBCR(n)		(((n) * 0x1000) + 0x4201C)
 
 /* BLSP1 AHB clock (root clock for BLSP) */
 #define BLSP1_AHB_CBCR			0x1008
@@ -55,6 +52,10 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 
 static const struct gate_clk apq8016_clks[] = {
 	GATE_CLK_POLLED(GCC_PRNG_AHB_CLK,	0x45004, BIT(8), 0x13004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,	0x4201c, BIT(0), 0x4201c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,	0x42018, BIT(0), 0x42018),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK,	0x4301c, BIT(0), 0x4301c),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK,	0x43018, BIT(0), 0x43018),
 	GATE_CLK_POLLED(GCC_USB_HS_AHB_CLK,	0x41008, BIT(0), 0x41008),
 	GATE_CLK_POLLED(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0), 0x41004),
 };
@@ -67,12 +68,10 @@ static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 	if (rate == 200000000)
 		div = 4;
 
-	clk_enable_cbc(priv->base + SDCC_AHB_CBCR(slot));
 	/* 800Mhz/div, gpll0 */
 	clk_rcg_set_rate_mnd(priv->base, SDCC_CMD_RCGR(slot), div, 0, 0,
 			     CFG_CLK_SRC_GPLL0, 8);
 	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
-	clk_enable_cbc(priv->base + SDCC_APPS_CBCR(slot));
 
 	return rate;
 }

-- 
2.47.2

