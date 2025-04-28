Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF69C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05B78209C;
	Mon, 28 Apr 2025 19:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="BA8bCZvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BC480EFB; Mon, 28 Apr 2025 10:37:57 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1828215F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so31433245e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829475; x=1746434275;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l/CE2kwFO2qZYUKG9bbswiG1ALPqoRJCEF+u5PVGRGY=;
 b=BA8bCZvTgEjRrUPAd+qpEZSADNCRsSbJaPXYfLlGamXdvjiom0nfcCLjeLEcD1gQkk
 c4WyIBfVIEAl7ptPKPzyYmKyDaxNnjSr5sc9V49K7QQFmieMPCEmD9bxYK82RK2DvI21
 0VLzRuug6NESFKuLKxTFTshfv00Yq15DbI6NDOnZLP4HPSs8ZQ+MewISsN0/lMd6ni0E
 u9EuxjLE0i2XtDDcfejkX0JdQg7l/iXy4gvV/tZ4Hc67AyFsiuQ/uTc332dYhGI/IBo3
 /O3R5qLmBWjwDvElrbp+D2aDISPdy9lGzPC1cYImhrhDdsMTTRMZXTa81x+J67+DheCA
 vi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829475; x=1746434275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/CE2kwFO2qZYUKG9bbswiG1ALPqoRJCEF+u5PVGRGY=;
 b=w7tE+WyPTxGZewKnof6uMnjL3fSqSl5OGUiaSZ/rte0qU/4ZmjlfMjiPG1pECy0ZS2
 DW+ZTBovV+EEAAcwxLOqeftSmfKETkSUCr5GKOyjvGQh2+SZnvkP4i2BVqWrZ06nWwm0
 9mNbfLnGDsREBwt3yRvCdO+RDk/O1w6YrHe2+o/LJHigzmDLy4xxot1AHnQPPN2SBmV3
 ipya8gT0Hkr2KqfUxat384Uz2V/v4eGv9XjkzpGeP9fn+N/1x6fD2cH0HsQZymf3tO+c
 v7hNL7NGdE/c5EmlO2rK/asxA8fTEZvJvTrpDmhlRALBCAbw4TFq/Amgsq4oaohbHq6O
 /Vqg==
X-Gm-Message-State: AOJu0YzrYaZg5PZeK2T6Wnioh0VGl0zkE7THlsYz38YGhSn76FFHDtKI
 JlUprg1i/iOK3q+S8cZb5fY2Kie7jabzVbHrVBpeizt44NGN6aqwYXf5JPmsE+M=
X-Gm-Gg: ASbGnct7920cC6FNoWQSoUKcxhB7/meYi8r1QJWE0Ml4jD5FuFAM39OH62wWUeSHpUt
 LvSjGZvo7pf/adRk4dahLQsY5KqH71ue7DsPdPQBvdNrZjLorNm8slQxVBEWkuC6JiyXgt+lI/C
 pwA+44AzrtM9eU1tG5uRyLMXtbFxklghS7waHR+t6Yt2RQGgqVlMCcbJWXZQZe83riEPhDZWA+U
 35xM5PCbjco191KHDJHO1U03U0N58Q9mbdAy48wLPLtgEmlk7cvqcwal91RiDO0huU6WT93mB/L
 8F9U6pXTHjBFYpvlnSNY4v42hsb3QF56KXyBFnQ=
X-Google-Smtp-Source: AGHT+IG/AggizgpRkFTWbMcGmZGGFHVun2hV+p0n3jqAeEZF1nWgW4RCS+e2gGh8pF35l8fFqvQHzw==
X-Received: by 2002:a05:600c:c17:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-440a6692a28mr86203055e9.10.1745829474561; 
 Mon, 28 Apr 2025 01:37:54 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:54 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 10:37:34 +0200
Subject: [PATCH v3 1/6] arm: at91: wdt: Remove at91_wdt struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v3-1-86f0c5d92c32@hifiphile.com>
References: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
In-Reply-To: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

at91_wdt struct is only used by spl, remove this reference and the struct
itself.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
 arch/arm/mach-at91/spl.c                   | 4 +---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 8ef8e007d7767308a5b46be46b02c51073723a41..78ad0453fd9eb3e42674d10cb11ce3da820cdc6a 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -19,12 +19,6 @@
 
 #else
 
-typedef struct at91_wdt {
-	u32	cr;
-	u32	mr;
-	u32	sr;
-} at91_wdt_t;
-
 struct at91_wdt_priv {
 	void __iomem *regs;
 	u32 regval;
diff --git a/arch/arm/mach-at91/spl.c b/arch/arm/mach-at91/spl.c
index 5feb8f735511a45dd37ee04bb3742f57d8f2e067..a814973242a723c47af210bd76db9210db061063 100644
--- a/arch/arm/mach-at91/spl.c
+++ b/arch/arm/mach-at91/spl.c
@@ -14,9 +14,7 @@
 #if !defined(CONFIG_WDT_AT91)
 void at91_disable_wdt(void)
 {
-	struct at91_wdt *wdt = (struct at91_wdt *)ATMEL_BASE_WDT;
-
-	writel(AT91_WDT_MR_WDDIS, &wdt->mr);
+	writel(AT91_WDT_MR_WDDIS, ATMEL_BASE_WDT + AT91_WDT_MR);
 }
 #endif
 

-- 
2.49.0

