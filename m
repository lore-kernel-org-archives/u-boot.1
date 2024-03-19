Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FA7C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA0F88078;
	Tue, 19 Mar 2024 13:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ESb3w9c4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A5A8808B; Tue, 19 Mar 2024 13:22:46 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEE787F76
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33ec7e1d542so2993398f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850962; x=1711455762; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4lb8PEob9/JiYx6ZN3WF/j0PD2DXtiyVJcX5Mb4avcQ=;
 b=ESb3w9c4Vmf+ZHL4s2O7TGBvBJfZVmZYLrVX34W7jZ+olGXtq0mOF5xLSYuvmzIeuA
 qnR5V+L5qIAPONDqw3IAVpC+21qbNipKisxDipRFmeOmX9f1axHsqskLwCzir1Y6isVc
 lg9XxwHS8Q5yX8gnkKJ9c/mXpmp6CLyGAWDvKef6kP3TAhRooCdvy8hSrfD/3Lot6t2J
 IhSAaLq7Zfw80tqZrZJ87apHG327a9BrPgZJfWhtAafH6rjNWb7Rytj0mFVVbNi1jFr3
 4n+TrWaL1c6zjM1irapY+br4Rf2dlpSG2IgxlxBVLZ4M/yXZxBsUaOYZvFNhJKv5kle4
 5omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850962; x=1711455762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lb8PEob9/JiYx6ZN3WF/j0PD2DXtiyVJcX5Mb4avcQ=;
 b=WJByfVFu1ETZL00Mww20FMRZSThInMBTwwBX6zX5/UziUIVEm2XEPui7CgaGLTiQE9
 dnMFs92Sjega0Mdsw9ar8Cher3xJKW7/6bKpJWxvvuGDHXqc+9I7B3KOPty1IuGbvVug
 9fuVQ/wLNt6AaNnoIYQMN4GQx2KgnoCZcLEWg9vZCgc5bg22YRxWli5FpZNrP5r4wjWf
 TA7Ej+nMAM34W1VLfgWsw04SJrMo1K92iAqM7ghL7+IvTzXm+g3egPRpolOpbiZfO613
 J+xIfogfJ2NZGmAw5zVH0Py89KUKZs5Ux3k1zsfVI3+9EbAw5eOdOxLYHZWoJwQOsmyj
 Hc4A==
X-Gm-Message-State: AOJu0YxhkcjiwnmdiG8itXfxHRzhRbQzJOn6iFy+JF0ODJ1+Fmhj13wO
 MFs++Sg5aauUu6bL25Gep/Sy/6198zpZFADeUtArrzMr9KevhdfkB6QbJA2xAshbyhvnbZFLU5y
 K
X-Google-Smtp-Source: AGHT+IEgVwxO7TtT04U07OidVjoLMHelqD2FZZfOLUPvK4CYqluVwXmLPjgVFKz5WqGM2ItZqUbw4w==
X-Received: by 2002:a5d:62d1:0:b0:33d:524f:7bfb with SMTP id
 o17-20020a5d62d1000000b0033d524f7bfbmr1515640wrv.71.1710850962272; 
 Tue, 19 Mar 2024 05:22:42 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:05 +0000
Subject: [PATCH v3 06/14] clk/qcom: sdm845: add gdscs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-6-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=NiVaW0NdVxESjcJwJJNmAYR7pzUuvaSjYCNONaTI9A0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzZ3rPllcXLXE2C+9/N/tJ5dWsBl9b9y1T/fwBJ3cB
 9V6Mp4OHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiNqwM/8zPPTv9UsRE7usr
 SdmV29eXhaX8/tc34x9js3Lt5DL5KiuGfxqpVuVMjN+fzbzOULEhuvPe4oifG1fb7fPYn3bmeDD
 T58MA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Define the GDSC power domains for SDM845.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sdm845.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index ccb0cf245d33..b7154360894a 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -145,13 +145,31 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
 };
 
+static const struct qcom_power_map sdm845_gdscs[] = {
+	[PCIE_0_GDSC] = { 0x6b004 },
+	[PCIE_1_GDSC] = { 0x8d004 },
+	[UFS_CARD_GDSC] = { 0x75004 },
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
+	[USB30_SEC_GDSC] = { 0x10004 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+};
+
 static struct msm_clk_data sdm845_clk_data = {
 	.resets = sdm845_gcc_resets,
 	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
 	.clks = sdm845_clks,
 	.num_clks = ARRAY_SIZE(sdm845_clks),
+	.power_domains = sdm845_gdscs,
+	.num_power_domains = ARRAY_SIZE(sdm845_gdscs),
 
 	.enable = sdm845_clk_enable,
 	.set_rate = sdm845_clk_set_rate,
 };

-- 
2.44.0

