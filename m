Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB683C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478A48210E;
	Mon, 28 Apr 2025 19:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="ZqzbdRB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D2C82163; Mon, 28 Apr 2025 10:38:03 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F658216C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so30334775e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829476; x=1746434276;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mlAuOD+vTyXfQv1BXCsnfisXupuzpvwN2h1BJe7TnM8=;
 b=ZqzbdRB6r9v0iKsKoZ+I0Fop5ktilIDdg3Yg1V0j8ElKndDlfX+Z1lkZ9UShWeDoJL
 TI1dLsvc3L9tW2r/bo06X/Gn2cB5f4IueukROO4xEEfM1NInqHVJ6VKzWJvDu2NQ4s05
 7d5YezpquWeU7beiK1FgxRjp/9yB+XViC7uBO4VgVZqCzd/Kt32fELDCLky0ly87xpRL
 zXT7gdQgxG/UXetRcXxEhfMl95YNW6I717sWeiIzuNP2NcH/YWEYuQQ5LMbWcgFp+K9j
 0p/GJvw0sMCE79/jkGLjY21pOEqSmQKZlwLDuo6vQ7OVE3tdyxg0Jnm90TQfDhXjdcSJ
 WwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829476; x=1746434276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlAuOD+vTyXfQv1BXCsnfisXupuzpvwN2h1BJe7TnM8=;
 b=k6pqA8Snu0lpUMrVVEWoN8SZ5B+JKK9UWIwHsw7nUPlqspt3mvIpukjGwM9efmR0c/
 M9P20cyh78JD99RP07UFMPod41lWzduI9ysscjmnw+pWFTnkvDODEhPuRSb/7CcCQD2w
 i43tigyWdE/0+PKNP0k3diq2gIOCURdRhOrJmpLavbt9hApyr7thfQklcSF4X9Lhgx/R
 bPxyOnMcI1bQjD6d6RpaxkVYFKvm0loFSHSkO2SrOPiIuxlv6V+BLy0ekk/AJsvloTh0
 i4SewcmQHAwbuypa9sWUM+EE0r5J+DnhPpJv4anscLcAYns6+toG3nr8dpCRqXp20Wi/
 pVrg==
X-Gm-Message-State: AOJu0YzjtQhJqVdrk3yIqaNzJrRh3FlGmoyhpOBMOASsiBrCsWOiMAZY
 0yB6+PQZWa6p93mNkz8dNuJoKtK/SEB19DXXdJW4ZQMGUQJOzkoRtebPx4Lhmjw=
X-Gm-Gg: ASbGncvUvcnbOiZa2troyKMl1EuiKaUXlqN/5xVMESIwuN8JUTg6H5hTagfV5Kl4gj7
 TQbyymwq/QqUWDXs6GZqkHWaQT62UAOvfk2Mm2SmiQxXwrJPrnCBYXQncbxjx098sGY02GnvrSj
 HpaFHjBB5e4FRuPvlRYVhlu5S76a9o+CleIHzV7w6tlwsJsOOvUJ4GuL5Mj0P8CflB7MyGDj3ak
 Q5ImroCSphTp5Im4c6YXgFxMyupmPQllVR6NFBvauaHY7GbyQ/6kzVw/seeoK+krudFXhzV+7OO
 HZlW0qS4ubKkJINzouZ7ydL9dNo8TwUFsuzk8OE=
X-Google-Smtp-Source: AGHT+IHzNxNBDIBfHXpLq6ZcQCovc3MfNgkeovUmd5ZmNxXqkL0XEc+nr7OZCBeicQijpyEZKoUu5Q==
X-Received: by 2002:a05:600c:3d96:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-440a65c6a6cmr88940115e9.6.1745829476170; 
 Mon, 28 Apr 2025 01:37:56 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:55 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 10:37:35 +0200
Subject: [PATCH v3 2/6] arm: at91: wdt: Rename regval in priv data to mr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v3-2-86f0c5d92c32@hifiphile.com>
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

