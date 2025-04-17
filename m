Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B82C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6AC78304A;
	Thu, 17 Apr 2025 14:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="CJzXjAtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40A68303E; Thu, 17 Apr 2025 11:10:10 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB27E82FC7
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso262624f8f.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881007; x=1745485807;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mlAuOD+vTyXfQv1BXCsnfisXupuzpvwN2h1BJe7TnM8=;
 b=CJzXjAtYxr3ORm+SiFCHnK2MXf68ChWzvwMm6AKPeNAlmtkJiTzSAjnpUtwV2efc6a
 esf+tvbc4TdxBkMBBJBWxCPwTKJPgFnWx7Z0rhyONZyboU2cyRVWfz+xYJTlKIa4L0jS
 9HR5tkdPLXLIZAcU4M2l8gWkwsJSrcFbRKlruasZUAbQkZRgZMleqYKWDGslrzA701+i
 vNHCdO5GDTxBUjN9Qjqo6N39eahB9cnxRq9zbmsuDEp2SFqPuPLX7efw5lkFBliO++2W
 ly3FXz0J2jTF50qmCz8Bsb1B3RLYdMQ90XsbwBtPMTh99Mxhr5RWRDnKp8tXhJA1Aadh
 YL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881007; x=1745485807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlAuOD+vTyXfQv1BXCsnfisXupuzpvwN2h1BJe7TnM8=;
 b=m1hy0T1E3H2WjZLeoX8/N25LHnFeT1cwi6j9i9eLJ3l7NFqqxxKdfF8F5XhZMaOJLf
 FU+7O0FmbynULyQjpKjYkPpjSE2QlRn+8lwaS0M5uWbnXp6UqzPrCkEObGUK/fvJzury
 SY5TC2zSWY2PY3hxvAq9BN9VrY82If5AuGjzFmTmDbb5cSr+3liUe+5K3sUEeibWUxp+
 BVC4UTszyAV2WPfr9hZk5xvr38wguaTVz/GVaO7q5wLbk0X5vHwT5eZXVk/uM6ApQOIb
 aAp1CG61BS78uTwWtueJV/JXpzDOuv0kCSkK+ogM3xMSWoIsAoshcRqFD/LkurNBfxxP
 29pg==
X-Gm-Message-State: AOJu0YyUzkH/cKrqJ/TSbIfV0tDeIfsr2lz3jKUQXKYHX6j78p65e1nJ
 1jT3mFMDu8s1TMzrZtF2a+4rxlQ3gs9jARxkQ1DahZwUP605ikIIayi0FVGbtv92ZGb1gf7YCkr
 L
X-Gm-Gg: ASbGncsjUn9sAthT+npr//36JjoE8+Jb7xyFC4VppzgI1/mkKW1QnAog7y23krPhSI8
 /axNy2h7tMSKfWs1Scaz6+ehl32C++MWoP9jssbiflXhCjrz+Zo7EIOzrWDNXqgu4Mh9IAW7arQ
 S/GWCSbk7k3Cqx/xby2bjJ0JQ4aPSed5aWhEJdBhxn6OE/2HhkRQsSmoqcSitcREKQ4/XTICTHo
 OYGqUyh3d1RnKaIdEkjq6xmxhswwhCDw7nLVuMukIXQrxDdYEh/D/tf/cz7vWRrHye4tHLW5rkr
 /YwxKGFdoEUeFgXAgbnoJNRxt0dkkpVOQOqbnq00DkwTH4PWRw==
X-Google-Smtp-Source: AGHT+IHmgbMejl9V+8ue3xdU5JkDEqESvbvLb1RmTYKMahNgvT7BWaaL5wyuAHy9h1Nm8FhS+NrG+Q==
X-Received: by 2002:a05:6000:430e:b0:391:3998:2660 with SMTP id
 ffacd0b85a97d-39ee5b13056mr3962777f8f.7.1744881007262; 
 Thu, 17 Apr 2025 02:10:07 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:06 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:50 +0200
Subject: [PATCH v2 3/8] arm: at91: wdt: Rename regval in priv data to mr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-3-49939de473e1@hifiphile.com>
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
In-Reply-To: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
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

