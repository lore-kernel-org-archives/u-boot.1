Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C5CC36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4063181BC0;
	Mon, 24 Mar 2025 19:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yL5vqqEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE28A817EC; Mon, 24 Mar 2025 19:17:52 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2D1810E8
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso29759145e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840270; x=1743445070; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMPevC71NClrbba6eH6wmonogr1KKU7Fggc7bXV9A20=;
 b=yL5vqqEiyB6CRxWlLhp9FAEefec8Hccpk2QWmlhYybSL5dW/7/nU9TkoT+Jc1T0z4S
 oShEJbfaLKhPSaSiHzG+QJsi7eKhPyPOkF7nCVmr/DxPEICcY3B4wTZer8Ml/mIOXvRH
 QIFvHv8TIaVSnNEGF5VAW4b4pZJ+sRvp2IfFnLFoEyKuACSbdeNBRJd2eXq8/3Jol2zT
 UQESD7cX/2+z98OOfXztNl7ant1fdAw2ySwdWhAVYjeNB+XhkYfLUZWmRYO5IEyJtJ6U
 Xpafij54e3lnRiqls3PFyzSvlQvjyGhqMNeu7o3Vb7Md81swC76kOptOJuePbES9pEs7
 oSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840270; x=1743445070;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMPevC71NClrbba6eH6wmonogr1KKU7Fggc7bXV9A20=;
 b=cAnkUe89UVI2Vv1uvDRYXXPmYTumiknRH/PHJAnuUGtAqhBOp1/YAWXRVNUHpncsUs
 C8/5UL5Xt+5YwGLuNkqBc0hewld4/Gy//iNUa+k0BNvKRqQmTSmKqA26ImcRZ05bnZmr
 c+S9m7sqvy/6oZlHs58VJeVJiEgHjYRHmx2OFLC0mailSPVTz52CNxNZYCKVmup/m8ZS
 JIvhq7F9YcMhVBjEvx2zHoIHE00Wc1CujKx9DT/X8g0XQ38yyh/ZPP3tdNCqtvmI9tff
 tDKsYfQEzMHUQlzKuKlldj3nwcHZlVxyDYO9fTgB/pZNJGRCRGVtBZWdfDlOqpG77J3z
 rtsQ==
X-Gm-Message-State: AOJu0YyGfly2CsQe955vi+2n2+2Y+Og03JE5tfkUuWvT3K8mDscppSMp
 fBbT3S/7UDw7P8XjO550VS4Fzc/JJLmRpmzPxU+ljxW4Y/Gi9k7RMieWmFapS4k=
X-Gm-Gg: ASbGncvzdXwks5URoadrh/o8qqiwO4vsrZt5ZG2AZM6NFtCiN5PJWIgAA98YKy++Kyv
 DxzXA5hGLk5WUYM5WMVm6AuIVvLPM0+e5v0LtsVHnvWXgR+E2X1ZIY4SeK2GG1aUmntkH7u5Dxo
 /7BPaRLZdcqfjnNayZIvm4a8BruwtRyKIzSNjRLlzMw/HVMdgdgvh4hWcLogwIsXJo7YLM4Df2P
 y2F7n+JQWu7cG9w74gmyJhOdgcP6Wc4lF2tojBji59C2XNK0E6zcyfqZUHSw7BDldi+0FhWNYb8
 cVGGWp1Zh6IDepk85xAx5DAxikZH/QUkpalyhAJBNYAUFnzz3dRpQ08xFd/LbPBPo3b4zD0s4je
 tT23FOSBlOuq9
X-Google-Smtp-Source: AGHT+IGdfqFQMdQTQNuMsLUOVxmdfJMHohMalPCiSB9edgb59wqsT4Z8nC9n/TDkmO5tx5dA7+nkng==
X-Received: by 2002:a05:600c:b88:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-43d509f6eb5mr137428315e9.18.1742840269901; 
 Mon, 24 Mar 2025 11:17:49 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6450sm11690651f8f.70.2025.03.24.11.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:17:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 24 Mar 2025 19:17:38 +0100
Subject: [PATCH 2/4] clk/qcom: sdm845: add GCC_AGGRE_UFS_PHY_AXI_CLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sdm845-fixes-fastboot-v1-2-d177a10f336d@linaro.org>
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/f7z7vl7fH327abmHyR9X7FCg+qJI2o+GlDfCnqiY/0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4aHIPSNgZ4xxZ2wgtcwW5MJi1gJrqgSm5eGAx
 kiih2BvYyaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+GhyAAKCRAFgzErGV9k
 ttFeEACcZAMIkFLrKTLSq7f3Zg1LCLGKh0pXpE7jEQ802y0e+7PK5HPl06xlruNkcZKgzv+BFom
 Ev4sNK3drjjN9OtMdY+IJcSu17O+324Buxse8Qo1VxmyXMCjqQXEW4X8fjYhIvNZbIiv41qNE7H
 B141mz8Zv5d6Qxjnx1pTC5NoPQ5TzVQk8yHEHcgq1C+AD5p1i8z+YVky4W0u6UISyoJtYgVfNDH
 FTtsu0zBNSkgHZId/jlRiASF1V1q/zC6mKqrvfHxq0urYXo6y1o+R9sOyiRMvQYfaPxAPwWCGzG
 jt756QKKKwXRa5KTjkckYeFM8j86dcBgpfcjZvfdT2yxlW1vUP+QbY4SIOKjZLxNdDoov9mHPB3
 xShmNb/VLplA+XTaWjFaX242hNVUz43nnXVjqvqpAn3Fuca7M0E5gL+GoTmOqzpoQwr79zymjsd
 UjOTKm7e2LnYQ1sAR7nFMD7jP1hXIxBQG2iRvro2SbX19ejpz9Zxs5bTJvim5MAbnAXHsXjAA13
 O3voU6+Yg3shiFNW3vphPIwKVYI1k3pfjGyJyMKBx3HoyEyo8Cph8yIA2W5bNNugZxTko+7CNbO
 I2BUSGsupojAkNfKI59so1MKAxJQ3gMn2CqiicHl1dI/6rOyc0RsI1D9Zt7DmZIgI7S+51vpRsD
 I0H+b5XTia0QZgA==
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

Missing for UFS.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sdm845.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 7fd875e55d5443f170801172a373e0405041e1d1..5c8702ef2fe00a46a30dbdfddd6e649d20465006 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -113,8 +113,9 @@ static const struct gate_clk sdm845_clks[] = {
 	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750a8, 0x00000001),
 	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75014, 0x00000001),
 	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75054, 0x00000001),
 	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x82024, 0x00000001),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
 	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
 	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),

-- 
2.49.0

