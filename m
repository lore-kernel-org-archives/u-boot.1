Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D393C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3DA81E72;
	Thu, 24 Apr 2025 11:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U6R72Hfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96036809D4; Thu, 24 Apr 2025 11:17:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDDA815D1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso8083125e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486223; x=1746091023; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pXvkTRu6wqOFFqzFzfX5y0/x1cQjhfkMoGX0MNgjPQk=;
 b=U6R72HfyOzIFMMPJ0KyzHrXTm+BmKTkAUEigrH54TRHm75CYQu9+qgV9pAe0mD/nlE
 7PoiO9mV60pcfpGQqrdOjlzs4kconu/ONnk0cZaoEc3uyTC4LZYsV1Lu7UBu+XFXb8Dt
 eBAAgwC8hoVdEINF8G8pRy3nN9DygEE73JX2z3ZwfW9zzV8REFEis1RL3flI0S6FHUta
 g0A77aysrUQYUEMAGBR4maYs53GyyySFWiOFZLEM6jGITDM2YCUbs+X40yLE0nNcKSiF
 krL2qfxXZhn/WjnPnIEO/EXJ6jyo7pzs2ITA5jOAPJznL85sDJyUuvQ2Wqm3DqA6kYXe
 WYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486223; x=1746091023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXvkTRu6wqOFFqzFzfX5y0/x1cQjhfkMoGX0MNgjPQk=;
 b=HZNLG9SAW5hI9p0zfi9ujVgc6RcpY/Tr5efl5Yqv64/32WNbf/Fw5SA/g2mwVeRKHp
 YGngNcKnz2h9MMOdtSZEGKL1kxn9A/h6G+dpYKm08rpZz/nZ5O7jSPnP7STRZNdg3Cmn
 kxyJTIts6A0frfPNrdwZN0VzqpzPpVwwvydmDp5jdU+8lEJqNNQ9GkvBqk2JIvLwkE76
 ZgmneHKc5uQBv6D7h0c4/Eqm0fcnBqdsyPTGgDYzhIO3wrPXvKBUPJ1sn0vJdGdn4t4i
 D3B7Oud3J8bj9nOZQN2/efUMSQg5W0fQTtH2Xn2Q9tZjiO+z9viuoAKBktkO3qvkq8Fs
 rBXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULHfWllZkERXEShlnKE/k2Rwkba+eoAUu7I6uEnaeLoTYvuh9aLWnDX6lT65CRDnZzA4QtuEE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc09kOiuyl5dKy3sorlgrBhiZoRN0jbFUg1JFVLTOlDMWpFEq5
 oABHFTIcB+4ie+N27s7xmKNwF/qeObjLsdv6Em7+f7n/cSYlzZhtw2RlF7/hB+w=
X-Gm-Gg: ASbGnctQ1UCptwFnGAe4wUNY/6taa0m8jnQLKlEHsaxd0HWVgYhxVwZYP9X84a3pt28
 9fEegBFOnxjgBg6iVPPnzB2AxFucC6ZQnkA4q46ZwaCQAYyiFXubeK73I0nlctAslgB8/Nmrycf
 FjwzXpNKz1+CdpbPB29Tm2vXhYRR9dfBQvtMW1xslq0tHRFLYJAZXVnHyda7jM1jaKsToqb6zsS
 XWS7krLPuGU4YxwkODC70IZP39JsFGWnQN+bf/tUIa/NK+NFNiysCG35P9wuAcwkvNxku33FaM8
 LsLj7cphqpZLDBjILLf8Lq9Eqghn24raUxQhgPCiuh1fxNUbyHn56cTXcCyixA==
X-Google-Smtp-Source: AGHT+IGSMpvk4+PGIQNCamc7+Zl/NkWSl5GBruKNsk7MrhEWgw7UaAfSAAhP21azPh1qyZQcHC0i6w==
X-Received: by 2002:a05:600c:444f:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-4409bd8f0cbmr14272655e9.20.1745486222943; 
 Thu, 24 Apr 2025 02:17:02 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:17:02 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 24 Apr 2025 11:16:45 +0200
Subject: [PATCH v2 5/6] clk: qcom: apq8016: Convert GATE_CLK() to
 GATE_CLK_POLLED()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-apq8016-clock-fixes2-v2-5-fcc371c9e45f@linaro.org>
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

Convert the usages of GATE_CLK() in clock-apq8016 to GATE_CLK_POLLED() to
make sure that we poll the status when enabling clocks:

 - PRNG_AHB_CLK is a vote clock, so we poll a different register address.
 - The USB clocks are simple branches, so enable/poll is the same register.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 274c71c53ff76c9a7ea18e3698c12b20a9b1f418..e3a9807f580bc995395bd5debdb8d7a9dfa54795 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -54,9 +54,9 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 };
 
 static const struct gate_clk apq8016_clks[] = {
-	GATE_CLK(GCC_PRNG_AHB_CLK,	0x45004, BIT(8)),
-	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
-	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0)),
+	GATE_CLK_POLLED(GCC_PRNG_AHB_CLK,	0x45004, BIT(8), 0x13004),
+	GATE_CLK_POLLED(GCC_USB_HS_AHB_CLK,	0x41008, BIT(0), 0x41008),
+	GATE_CLK_POLLED(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0), 0x41004),
 };
 
 /* SDHCI */

-- 
2.47.2

