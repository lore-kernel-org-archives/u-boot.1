Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A7C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 11:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47463836D5;
	Thu, 24 Jul 2025 13:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XGCQ3ly2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCF583744; Thu, 24 Jul 2025 13:37:42 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE01F836A3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 13:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so433055f8f.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753357059; x=1753961859; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tavawb6UbZESjqhA8MVNvd4nDHqluf+xtxrYIIODa/U=;
 b=XGCQ3ly2A+mhHjYmOnuT2n8fZ1uAnfs414bGB/o/5PNGJRI/5iA5xI+ObliIQMl86H
 ECTHwnz8bPqu1wwVpwHbxyR/98/WrC62WW5v08VQ5uEaWl4ivzJHgOE18slK2CIJoYxr
 kUmvJYJ3pfOmlEG2jhgmsd0JU0TgRCP8ZSGovkfITFvWpsBbSDvCwLpdyWHL4kuqPfxP
 EAvp6z3RVnGvVbkD9JBIPEm2nTztdJPLa7x1/0VaE3NQLPWpKr8e3mel8XxWnCBZjA3X
 fPtXpe/oJBpEqBxff5zohqYe6hqVJrdZ4XpLtvEvXiDJFpumGgIt3LNCWp0+P7UqXpEz
 BhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753357059; x=1753961859;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tavawb6UbZESjqhA8MVNvd4nDHqluf+xtxrYIIODa/U=;
 b=DHCeZctkDkQiY+acZdwc4e4FAxhxkdvHybEDzcJf7kiVKs7fXpWGd0dNAeBf42/8GW
 lBR4zCCxiVEa2Otr3G1TXBA4Wt4CORIUORtQJ6OuE8Ws5ztCgnOd3615xLuEtwcwAyDr
 yFDxAOGN6xvZ6Evm0GfC8TZ4gewKSmawGhmt1TJsH2miW0wi+wLPAmAfyNjXI/HE4wgw
 I3qzsJt53AfISPTmem1+zoOAGIq2bbuXTydjbIbikMbUlk2GheNp6UpdsVn4ZfmEFce0
 tYCrEtF7Lh+ZHbcOrVEVSlskeBp9j52ALf915YAW6OcEJ5PzsiZJuNp9ANpqtFR2kZec
 TFcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW7yhphms8eLJ76hajm9OgmB7ZFrgODKJgVPkPxNC/9iu1dDke1wCcI2JFGuxQw7vWbMmUglg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywa4vvOjULS1Wumjo0yTzTO/cbplk4hXoBiXbdVRvH3vDJiHKMc
 PShE6wOHY8UsN4tM46GE2q8iEVneza2SdFpdLGQA7paV5eZQQn1T37sK4HlHqIyPFL9e/veesZb
 mXjLJ4Fo=
X-Gm-Gg: ASbGncuZAsyjuHgOw4njvDm//gVs3n768IYrr1wI1YAWCV8QuX499xkVxA4xbtRMpUJ
 sAqy9owX/EfCIq9+yhstEhgTYacJFNosN2POerYohvjEfvk/Sq5RCkCuJgNh7x2RCBvGLkFgq6V
 00fYCewb4gAI5I4+W/MQ5Um66op2x1hsVyu2ResTtn7RHs6uXX5Rerje8CQN1pb9/OKjx0MsYX4
 SWuOEdDBE7isEIG/snYBA/yIv7BPkvobd1t3ytcZAfS6JpDRv8UG+krnesXPyJJ6a67N6MKKfp8
 l3ROy2ruMHl9fo12LkzbGkkiiWwGB2YQ+VVQm9S/YiIRpNk4jMeXTfkJWjixHrYSMbql6mG9jFv
 7yGOj/ULbsW0dK8Smvnc+M3/XBs9XQXGuj/kXSaDgXfqlsXgiexs=
X-Google-Smtp-Source: AGHT+IEw4iHqJh6Ei5lkkIxQHxUu3cEuE8y5MLFC1QLb+YgKVC4L9LlVV20dGLX/KwC9GrUNVMfGyg==
X-Received: by 2002:a05:6000:2288:b0:3aa:c9a8:a387 with SMTP id
 ffacd0b85a97d-3b768c585a3mr5586666f8f.0.1753357058968; 
 Thu, 24 Jul 2025 04:37:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc60585sm1935490f8f.5.2025.07.24.04.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:37:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 24 Jul 2025 12:37:38 +0100
Subject: [PATCH] clk: stm32: Wrong macros used in register read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-clk_stm32-v1-1-c12dd33d28c2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAEbgmgC/x2NUQqDMBAFryL73UC6sYi9SimSxI0u1ii7Ugri3
 Y39HN48ZgclYVJ4VjsIfVl5yQXutwri6PNAhvvCgBYftsHaxM/U6TY7NMG2Te8wuUQtFD94JRP
 E5zhej9nrRnINq1Di3z/yeh/HCReqSQF0AAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Tom Rini <trini@konsulko.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported a warning about a shift macro being used as a mask. Make
the obvious changes to make this register read calculation work the same
as the previous ones.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
This fix is somewhat speculative as it is being made without
reference to any manual.
---
 drivers/clk/stm32/clk-stm32h7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32h7.c b/drivers/clk/stm32/clk-stm32h7.c
index aa3be414a29..df82db69738 100644
--- a/drivers/clk/stm32/clk-stm32h7.c
+++ b/drivers/clk/stm32/clk-stm32h7.c
@@ -549,8 +549,8 @@ static u32 stm32_get_PLL1_rate(struct stm32_rcc_regs *regs,
 	divr1 = readl(&regs->pll1divr) & RCC_PLL1DIVR_DIVR1_MASK;
 	divr1 = (divr1 >> RCC_PLL1DIVR_DIVR1_SHIFT) + 1;
 
-	fracn1 = readl(&regs->pll1fracr) & RCC_PLL1DIVR_DIVR1_MASK;
-	fracn1 = fracn1 & RCC_PLL1DIVR_DIVR1_SHIFT;
+	fracn1 = readl(&regs->pll1fracr) & RCC_PLL1FRACR_FRACN1_MASK;
+	fracn1 = (fracn1 >> RCC_PLL1FRACR_FRACN1_SHIFT) + 1;
 
 	vco = (pllsrc / divm1) * divn1;
 	rate = (pllsrc * fracn1) / (divm1 * 8192);

---
base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
change-id: 20250724-clk_stm32-b097d32f3fe9

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

