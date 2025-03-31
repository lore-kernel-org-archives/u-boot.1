Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34063C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79CF081F6B;
	Mon, 31 Mar 2025 21:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="njXWciGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1158681EBB; Mon, 31 Mar 2025 21:16:37 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CEF8171B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso53422625e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448594; x=1744053394;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Jr7I99k8BjtKagTkF8MBtnnRF50AYXL8US48Iy0eU8=;
 b=njXWciGO5QzVhzovY9b13AwWMj8uNlJ0hbaxsZGCImxzX2exja8ckCAnNiLwzQhZ1K
 sAiMSXlDXkvuu6WfV73jQBRQ4foQotLLArHeykJkxnrzqMO+n6+Pim4CI1Tpu7vOEjxx
 0R8MnMbdqRCAmjILVxcBmrjbPHk4Yy/1b52aYB+5UiVoiDyNKbGtlDo0nF9cpfqJZWBl
 F3nEelH56aypg5RYQXi9oTbCLNhD3kzuFVSXpH0i7pZ5SasTHubkmrvYCjZuK7ii7Etx
 YdWVbKZzuDykbLZgxI8hBzQCwdE3X6wPMgfRPz8tM1EYx7hIJw1jdnKdmOQTEi81SbJO
 qDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448594; x=1744053394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Jr7I99k8BjtKagTkF8MBtnnRF50AYXL8US48Iy0eU8=;
 b=Jgf61KS9TaIhirwiF7GIs2dzWlkowGVPFG9RKONeeyLIeFitG4BsYqG7dcCvMRfMUt
 IvWC2KH58FoKKbU8Ty8CuuQ+rJ+mfwzDQmjP5dif7UoWP2kBMrqa5yZ9O26ppdYa+ck2
 aUTaget7nS2F19QLiEEZoXgsn2ESzLMna2G4y77m1gkM6V76+5RY1xxqIS5Sa6ma5Q1X
 a9ngopClT0TNJl2I6lwqZGOn0/2PADapkrW7hYKJrmOeIRLQVqT/4jNxHXhOZ7u4fJpT
 MDvHmfd1ygR7M0ZFuc5hCzl+GA46qfWUxogmKqmlHnyPOWPZY0hKkf6hgnpTNlX3eGCR
 UVVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm7uuJ1E0UZ6Ba+kZTJh5HiecF5roLV/5d8y1xqdZ14kFKplYLo2XGOPw2zeEYj7SKlIEmNmM=@lists.denx.de
X-Gm-Message-State: AOJu0YzaWc+9L+fT8iQWpq7aElGgTxjYDGZPYs95zp4u5E97GdjPYkxk
 qYpe7ekYj4twP3a4EznF851CCFqtr5IYhTSv1VWkK7Ynixt8rcvDuBHIKhU6XK8LwYG2jZXaIJ0
 V
X-Gm-Gg: ASbGncupaJIb91P1qnO7gs4c8Ti2bthRw2WXX2FbnhWyjm/govzOCMFGW+VG5IGYcQ0
 lRcYUCmPIWt2U5aqXMRWyjOMpWwA2CWQbGXZ7K4hOT/luR1PF74eQWII5g7fzwFWR314FzLkQwS
 QamdyO8g7KL3BVIAFQ+WfgzNbcx4I8OWavr8tt6WU/HaF54rtG38UryKFj82h11mLoTU6+f4l2m
 lDfytcTTcw11Y9e7GRKU1Ov3lzG8tIdzY62hZZvM9CZ3sE++b3u9B5juAPoyjE3ieWi+wv4ZjKH
 EAKO7uvAvw6KBFoqHmYCbfdn8oFCOJtHX/zM12DtVtuRr22nCl2xkMRE
X-Google-Smtp-Source: AGHT+IGHS+yHIKYnRjNqa2Dx4ACRTV1VdI9gwEr/ycO4bYksNw5Pqw9lnJ5DVilcC89fQEMEFJ5ewA==
X-Received: by 2002:a05:600c:3844:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43db6249f8bmr93724615e9.15.1743448594241; 
 Mon, 31 Mar 2025 12:16:34 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:33 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 5/7] watchdog: at91sam9_wdt: Add SAM9X60 support
Date: Mon, 31 Mar 2025 21:15:14 +0200
Message-ID: <20250331191520.1805001-6-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-1-admin@hifiphile.com>
References: <20250331191520.1805001-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 21:19:48 +0200
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
 arch/arm/mach-at91/include/mach/at91_wdt.h |  7 ++++
 drivers/watchdog/at91sam9_wdt.c            | 39 +++++++++++++++++-----
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 9ba5283123b..9a3976d9e97 100644
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
index 5ca3e5a5fde..72e13787448 100644
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

