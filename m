Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA04C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D2A83092;
	Thu, 17 Apr 2025 14:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="lKx0UTGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104D78300B; Thu, 17 Apr 2025 11:10:14 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0037C82FC7
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so3649455e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881010; x=1745485810;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z+7Ymw7Kv6Zhb4nEsNzc8UYUnZR5dOvZirkcVTALkRM=;
 b=lKx0UTGZsiEQPa67zK8+JAWLuFDp/6pf8VioOxHR41l3W+u0Hiy23YSByhQ169fQut
 HofF1kcthO1h16Ax0Z9aoFFx/wpeYCymsiGViz7XXaKwYptf12OI0LPI7g2fzUJcUQb4
 47OZiMj8H/VKqBO9oUp6TDB+bKcQYGIxwZyhWJHGFTZyTI9mhywBkDw6yCDtdhf/fEHR
 TRpB9+FpOOSYiOwC0AARNshVG191AS+0llXVDnJ9j13HuIA5VUA6YBxkml2QvTRRjQik
 OFm0cjkrYP2b4u4xHaOXygZT02IfmmZeikJYvavDH7Uiggr1wse7FUenXqemA/8CI4qW
 61bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881010; x=1745485810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+7Ymw7Kv6Zhb4nEsNzc8UYUnZR5dOvZirkcVTALkRM=;
 b=Sdlx0vo2N216wJNsaO7+W0P5WRJbq9YEfs4PES4BwY0uoUOBf8VLWAn8osd+C59IFH
 /vISq4yZtSJ40dAvADLIKWkKHEBZTzRWD3GkbLJptmZYVa80le5gvIkeOoqkH9FyPKs0
 in0jyM1yJ3QpWfIBMEa8zTS5M9yb+zVEbDCZ0XLAvLhh3oA9mFgvDHwI5jEfS4i3KsB3
 qjTjSCQUzGxH/5APqZ6c2KZYPUoMjOhMwlonSSKatGSfvQRfa8tTMb+i22Az6atr15hV
 y/eky4XF8Q1NtJADlhi3tGgC8mziCw+puh3KW5ol+ZzIA7HBr9zNxJFIBW3H/3RAcp8P
 xU8A==
X-Gm-Message-State: AOJu0YzvlipQEH3uBXPfgmniUBAXkNGKMf7HlUIf5hF/t5lCRcxHhKVH
 tHzi4vxh/wlKPRxDBGsuG/9pEdEN2WClW2LkXRFDldON9bhK0GlrRA4D26hyYLkHziY2AAyUeOQ
 w
X-Gm-Gg: ASbGncvofqffONhGvi76lgcIOfdPESq0Er3CnLvBnQFhH+bBj77GsWOQD2Yyw3fhdWD
 C0hPBhK5y1WnoPU7Shq8YhsI2Oj5+tnPDEpC+1VjIlBjKiibWIWGPabiUdIIzw3CF6/AxQMBO9s
 EQyUijxY3EPEC0PTHzJQ816fIgZQW8xb4zpVlTGhcDn/JR6Zu6Umu4Dp1cOmrcjm1qjMh7ce+Zq
 1fg8lnMnAujXSfFK8mUtNtL/Hyp0YiV8rUFcPWOc7c2MK9i1B/yDChw7N/syoDaaH84HKf9O6UT
 CDsEVBfcv3k2FdQbhJXqY1ho7eJzQ+p7Oxobxo4=
X-Google-Smtp-Source: AGHT+IFVOEOwRNJa5m3rqQmNnohGDRcbq3OdAxP0jiRE5cSEgUo45D6wQuI3pCIjX7+gFFwWoseYTw==
X-Received: by 2002:a05:600c:5116:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-4405d62a526mr49699705e9.17.1744881010549; 
 Thu, 17 Apr 2025 02:10:10 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:09 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:53 +0200
Subject: [PATCH v2 6/8] watchdog: at91sam9_wdt: Add SAM9X60 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-6-49939de473e1@hifiphile.com>
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

SAM9X60 has a slightly different watchdog implementation:
- Timer value moved into a new register WLR
- Some MR register fields have their position changed

This patch add SAM9X60 support, also adds a compatible
for SAMA5D4 who is the same as existing SAM9260.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h |  7 ++++++
 drivers/watchdog/at91sam9_wdt.c            | 39 ++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 9ba5283123bcf637bb1c3c66f7b98104e232ae05..9a3976d9e970c212d348daeabc14c2fd6c54a8b5 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -19,9 +19,16 @@
 
 #else
 
+enum {
+	AT91_WDT_MODE_SAM9260 = 0,
+	AT91_WDT_MODE_SAM9X60 = 1
+};
+
 struct at91_wdt_priv {
 	void __iomem *regs;
 	u32 mr;
+	u32 wddis;
+	u8 mode;
 };
 
 #endif
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 5ca3e5a5fdefb3101c97754f10b65c0acd69a522..72e13787448e366036dce4a451cc2294e5b60a0d 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -49,7 +49,7 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	ticks = WDT_SEC2TICKS(timeout);
 
 	/* Check if disabled */
-	if (readl(wdt->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
+	if (readl(wdt->regs + AT91_WDT_MR) & wdt->wddis) {
 		printf("sorry, watchdog is disabled\n");
 		return -1;
 	}
@@ -60,11 +60,21 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	 * Since WDV is a 12-bit counter, the maximum period is
 	 * 4096 / 256 = 16 seconds.
 	 */
-	wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
-		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
-		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
-		| AT91_WDT_MR_WDV(ticks);	/* timer value */
-	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
+
+	if (wdt->mode == AT91_WDT_MODE_SAM9260) {
+		wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
+		    | AT91_WDT_MR_WDDBGHLT	/* disabled in debug mode */
+		    | AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
+		    | AT91_WDT_MR_WDV(ticks);	/* timer value */
+		writel(wdt->mr, wdt->regs + AT91_WDT_MR);
+	} else if (wdt->mode == AT91_WDT_MODE_SAM9X60) {
+		writel(AT91_SAM9X60_WLR_COUNTER(ticks),	/* timer value */
+		       wdt->regs + AT91_SAM9X60_WLR);
+
+		wdt->mr = AT91_SAM9X60_MR_PERIODRST /* causes watchdog reset */
+			| AT91_SAM9X60_MR_WDDBGHLT; /* disabled in debug mode */
+		writel(wdt->mr, wdt->regs + AT91_WDT_MR);
+	}
 
 	return 0;
 }
@@ -74,7 +84,7 @@ static int at91_wdt_stop(struct udevice *dev)
 	struct at91_wdt_priv *wdt = dev_get_priv(dev);
 
 	/* Disable Watchdog Timer */
-	wdt->mr |= AT91_WDT_MR_WDDIS;
+	wdt->mr |= wdt->wddis;
 	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
 
 	return 0;
@@ -96,7 +106,14 @@ static const struct wdt_ops at91_wdt_ops = {
 };
 
 static const struct udevice_id at91_wdt_ids[] = {
-	{ .compatible = "atmel,at91sam9260-wdt" },
+	{ .compatible = "atmel,at91sam9260-wdt",
+	  .data = AT91_WDT_MODE_SAM9260 },
+	{ .compatible = "atmel,sama5d4-wdt",
+	  .data = AT91_WDT_MODE_SAM9260 },
+	{ .compatible = "microchip,sam9x60-wdt",
+	  .data = AT91_WDT_MODE_SAM9X60 },
+	{ .compatible = "microchip,sama7g5-wdt",
+	  .data = AT91_WDT_MODE_SAM9X60 },
 	{}
 };
 
@@ -108,6 +125,12 @@ static int at91_wdt_probe(struct udevice *dev)
 	if (!wdt->regs)
 		return -EINVAL;
 
+	wdt->mode = dev_get_driver_data(dev);
+	if (wdt->mode == AT91_WDT_MODE_SAM9260)
+		wdt->wddis = AT91_WDT_MR_WDDIS;
+	else if (wdt->mode == AT91_WDT_MODE_SAM9X60)
+		wdt->wddis = AT91_SAM9X60_MR_WDDIS;
+
 	debug("%s: Probing wdt%u\n", __func__, dev_seq(dev));
 
 	return 0;

-- 
2.49.0

