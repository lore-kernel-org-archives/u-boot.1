Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CB1C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B187826AD;
	Mon, 28 Apr 2025 19:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="NGx5+OMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DB382169; Mon, 28 Apr 2025 11:16:30 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07498214A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so3231768f8f.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831788; x=1746436588;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mlAuOD+vTyXfQv1BXCsnfisXupuzpvwN2h1BJe7TnM8=;
 b=NGx5+OMVTUoxTS6F7inFfNz65K/n5f65BkDLXyZHOzUWz5BKBmU/Pa012l3V9Efveh
 uG7jeZAdoc+u4zSY76HhURxynfTfqJuZ1OrdxGMZugdzsnISOssH/axjpVgRnvQbt1pC
 Ul1uFtP/dvtm6+h9XGpePeKNMG/UA8fT40erNIY6P49PbXAIkpIFFPy/yBJMrv8viJmU
 1wplBd/yQBpIgsDneQh2p4euytl/KYLqHaC9EBmkEFRREorX/0ogeec0ZzfqFsj6julT
 0CYYeLp6jt9vuo3kYMyK+SwOc3mLXhrY7Tab/OA+IFEjuSTzTEfyZZwxfKtMTD9az6C3
 Falg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831788; x=1746436588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlAuOD+vTyXfQv1BXCsnfisXupuzpvwN2h1BJe7TnM8=;
 b=hlPklMyxF2UCP1dBFoKpHTeT7ZTWniya7AlYJnE5uIIRvNaAWU0cToVDGmI6RiOBKP
 FsulcW+TBgfNglrqdHo5jQsaPe3hnAc6ESMELVNGLgfwYXCSb8A9I100Q00O8DscIIxT
 AlTBKo9jgWXkTU3L85TF9CwqmQQfvreORY6NGKX2KYXn9rkoEjlC4LJa69UvZT2i0M6v
 BSJYYedjGRkQBpH9y3UqLjH9qNPpCzkLns49NMs6D+gq0cxoyM2Ec+AyhJNS4sGGLOEn
 5vrthbH1aUGxdYtN5pI5iXU21UZ0PJ2Yt7jz1RnDduxRUFvX3xqFTc/mPC4zkqNRu68J
 fR9w==
X-Gm-Message-State: AOJu0Ywmwf95r++mYYgGrKti4u0JWk7v4JG9RLBmVg5GZnh5ViN51Sks
 Hh12/j4/McGrWCY6SRRtMRuRDch+3wucTa6/fInAh6zx/nxafnShDwLdC0RV4vFH/arkdOqWq1U
 x
X-Gm-Gg: ASbGncsQCL6sBvpr/uyy7x0Pei+PSjEUD9IiaqpN6B5Fn5zRK5CCUI9xXkBV4qg27CG
 /C1SatBX0JYirRYn3joA9wKGKK4jZt4tX9cCrICBf8HaQZ10LG2qo+RdnH1LHaLgxyuPDnmh2nB
 qyrFicH/6/4PrFtW+NbpKzhptgQW8E1WADKRCSLnyojPjGLt5btVHql4wSvg6gcmM8aSU+IMWR5
 Kc2/CZ9sr4DV/+J8uIFq3wFNcF/5mo4lUh+h4TYS9Bb4an+b8V9HjbJoZb9w+CnrJkTc0pxAPvK
 4Rt3YeUEQO4OB3t89Gg+g6ESaVoYBmjPhpXmmfk=
X-Google-Smtp-Source: AGHT+IEAbjLDb7N4uxM3dfcB5W8opB6/69B2GNb/Sa5FC+NKoidRD8MAcweoJMlh2AmGlz/GjUBdBg==
X-Received: by 2002:a5d:588b:0:b0:39c:1257:dba8 with SMTP id
 ffacd0b85a97d-3a074f8fb48mr8521650f8f.56.1745831788255; 
 Mon, 28 Apr 2025 02:16:28 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:27 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 11:16:24 +0200
Subject: [PATCH v4 2/6] arm: at91: wdt: Rename regval in priv data to mr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v4-2-bb7d1c7c051a@hifiphile.com>
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
In-Reply-To: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
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

Use the name "mr" since we are referring to timer mode register.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 2 +-
 drivers/watchdog/at91sam9_wdt.c            | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 78ad0453fd9eb3e42674d10cb11ce3da820cdc6a..a5accbae52186e99de0b113d6982a4cc54e36095 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -21,7 +21,7 @@
 
 struct at91_wdt_priv {
 	void __iomem *regs;
-	u32 regval;
+	u32 mr;
 };
 
 #endif
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index c809a8936b8968c3322db4c86bc0571fbdfe3ae2..dab7b6a9b8ca09e6113109391560434ffe1f7cb6 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -60,11 +60,11 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	 * Since WDV is a 12-bit counter, the maximum period is
 	 * 4096 / 256 = 16 seconds.
 	 */
-	priv->regval = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
+	priv->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
 		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
 		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
 		| AT91_WDT_MR_WDV(ticks);	/* timer value */
-	writel(priv->regval, priv->regs + AT91_WDT_MR);
+	writel(priv->mr, priv->regs + AT91_WDT_MR);
 
 	return 0;
 }
@@ -74,8 +74,8 @@ static int at91_wdt_stop(struct udevice *dev)
 	struct at91_wdt_priv *priv = dev_get_priv(dev);
 
 	/* Disable Watchdog Timer */
-	priv->regval |= AT91_WDT_MR_WDDIS;
-	writel(priv->regval, priv->regs + AT91_WDT_MR);
+	priv->mr |= AT91_WDT_MR_WDDIS;
+	writel(priv->mr, priv->regs + AT91_WDT_MR);
 
 	return 0;
 }

-- 
2.49.0

