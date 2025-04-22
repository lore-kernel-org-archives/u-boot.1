Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD63C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AE28144A;
	Tue, 22 Apr 2025 12:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z3I6e70g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C29281273; Tue, 22 Apr 2025 12:54:46 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEA98206E
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f4b7211badso7017172a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319284; x=1745924084; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ObBkIYdiEtTaC73pm0GTTLysgzJRL6ojUUcKl245PKA=;
 b=z3I6e70g1GQP6vi9yigHWbJivQSXLsTvyPO1Rpozu02a6BDHwwQkfwa5Hl7s2RFnyF
 C3QZl28ntoj/ay7bsBKOgl+xVFz91TKLO/g7JWo70yIjaA092hnxd7KQYlAoCBrETlrl
 YTuSuCzWvPIO8QU8d5djUd2nqJJoUlWKMKDc3/d2qU6d/ovMa0RC+61c6/9krpEbOwjH
 RyKxwQqy1BpvfPqIqsvLF34FXbnu5W2tlIda7ridES4pmOcNCcSqa3ZqBDKL4DKVkK3M
 wUGX4qNPpGJvFlbMbFV+g6+t53S8Jl3d8GYELYQx5zxRHRgviHmJm5CFUtrdAP5Dx7mX
 wVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319284; x=1745924084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObBkIYdiEtTaC73pm0GTTLysgzJRL6ojUUcKl245PKA=;
 b=R7We1Tj1HhZNMYHY0Kr6rVb449R9O9IKn2IvJaPE0HsvhaTerkTytKXRn2PlYoFXBE
 8ct/pewrO687CxW+tpC07CjZHCkdSrTXk0k8blTAYA63Pd2+0J/TQ8jd6S6moeUMn33R
 Vzyb+sNSCw90eMFkgy2g+Wr6bCC/yIkdFlEgrJvFkTkD7hKogHXRCK2NTTLbX25R1I/u
 V6O11fhRTRuDfKvY6+L2Q5WXHjATaSftgND6ydm+FTW6GGXP9QEtsHP1Gw+1KEf47TU6
 p/NLC2eBU1VR+kiP8MmOGMhjWWyHAVVU5+z4qEwYUvu5BAI7qOAlSOGZNZ8RyeHSTcW4
 vvgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9alS77naqr11BZRl9RrfkXVcxTlSlOeqRoIrLO1/E4i2cdFVbElgLuPg70cYdWzpCeQbthiA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbn46J+3FNlH5vvmyQYtokon8rMlZy/CuEIaX5AssNBxPNIiUC
 l76IYlidGZ8KVBGDWoqt8lIYVx3v/dBaWZ9nQW5gw/GGYV67EhLbRs4jQXCjZ6k=
X-Gm-Gg: ASbGnctX/t24+Ns/ZTwuYH9YlaTkuU1MMkq9Bsh7esLmhJdxD4ps6zLuQAid63tovQb
 Bm7e5YddDEAOWAD+e+sBMrZs8WCeJnhAmRCHMpswQM75vb5uM9NpTFZHQtrz03sKqSKxrFzda9v
 jZEn7lzthkUjgix/uz23VKikNujgpr44D9aP/a6ee1s2JaZkdEhu+AJKD/iRXKK/PlHhQM8Md4c
 mP447gHy2afwXCrHUDvq7+KhtkpKoa8elJmOoZKkqz/femDxSOUxVyvL7UMrbSm8rANwawSeqkD
 8xY2YsNDExBIKmA093cMfwIDyrkoQlvY1rL1ZobnyLdZT+eIoZr8Ow==
X-Google-Smtp-Source: AGHT+IFHMuBgWCH9RELqwZz80B1ypcmkVoS+vQmIUTeOVxq9jICaC0gg+c+40y4NGlnP99+TOQDJrg==
X-Received: by 2002:a05:6402:350d:b0:5e4:9348:72c3 with SMTP id
 4fb4d7f45d1cf-5f6285336femr11586787a12.10.1745319283676; 
 Tue, 22 Apr 2025 03:54:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:42 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 22 Apr 2025 12:54:11 +0200
Subject: [PATCH 6/6] clk: qcom: apq8016: Fix SDCC clock warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-apq8016-clock-fixes2-v1-6-bfc9dd933da6@linaro.org>
References: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
In-Reply-To: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
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
function and convert them to the equivalent BRANCH_CLK() definitions.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 4eb2ba52be0c6f59a987acd0eacea4c7490345a7..ad824aaed73ff15e3a7dd4ea75f7b0cf2ba825cb 100644
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
 	BRANCH_CLK(GCC_PRNG_AHB_CLK,		0x45004, BIT(8), 0x13004),
+	BRANCH_CLK(GCC_SDCC1_AHB_CLK,		0x4201c, BIT(0), 0x4201c),
+	BRANCH_CLK(GCC_SDCC1_APPS_CLK,		0x42018, BIT(0), 0x42018),
+	BRANCH_CLK(GCC_SDCC2_AHB_CLK,		0x4301c, BIT(0), 0x4301c),
+	BRANCH_CLK(GCC_SDCC2_APPS_CLK,		0x43018, BIT(0), 0x43018),
 	BRANCH_CLK(GCC_USB_HS_AHB_CLK,		0x41008, BIT(0), 0x41008),
 	BRANCH_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0), 0x41004),
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

