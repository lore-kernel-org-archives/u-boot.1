Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429A8C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC60D82893;
	Mon, 28 Apr 2025 19:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="w3aWcMbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2378214A; Mon, 28 Apr 2025 11:16:32 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC33820B7
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so39687865e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831790; x=1746436590;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XFi48a5J2cqrfG1p+/C/71EoybNOcKi6qk0N3VdQPfs=;
 b=w3aWcMbvTCjDm2kBCe1RicLWB1+uwIrt4YUt/HMuyemGG9nTQvCL6QN6tgdR+shjfA
 Od9ePgOO4y/ZzlX1KNFduBztyCb3ox6L5LliL17ECx1uMq8iPLBcAdI7xnSvbDMz+XGs
 RGbRGtRvV9Ortgi5tMZr/wp/LaJ9iZ3piuS1JxHQ1QRkjHsMAGc91kJUpJBheHm+2DjH
 UU5jGzr7zoCHe6vY5NP53PxGPCf+iXeTjPIiZTAziQwKCQBLJR+mZiXnPHyhE+xoQL70
 kA1fFF7YnXFU0KOs7JrIbKlSk9vJxwboLTFU1RPpzpXf9D0mU+DnVGKYTUblxAu0CdNh
 nI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831790; x=1746436590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFi48a5J2cqrfG1p+/C/71EoybNOcKi6qk0N3VdQPfs=;
 b=sUMlmuXdbaKLDjMMeDlLLtpLKek0mSEMA6oHQBkiV6DNNqC84yMAkxL0qo8+KfwPYH
 dvGY6jmwSUlGiAC55X0CLx2IT1GLu1462cadGg9k+iVx9t/8wdFWftWuL6loqBBq8sQ9
 0ie7L320IGCITe/XHh3N4+uXQZgEXg7VlHgsSee4eE2jdzgpsa1HWDWrpVzQ301NJGXb
 2fFx9SafPpwPzvFwOF907e0yxEw9jvhTuOZcmwtIOXJNlAtmOYlNDRFfLkU1Tbj0CxEo
 qHJ+X/a//L/vc2eJZZ7e7iZ+BpCQrwgE5KKfcwtY5apD9Vx84ZDWlMBmOZWuf3FyGJU6
 X6HQ==
X-Gm-Message-State: AOJu0YzSXj8nLI3j9SB0iVPwniniYK2oGbLktPNQHhGlfvrPqGPq3sLR
 Rfaq387ORVGWRU8mssJJOFe5VM5BESodMghBbtd8IAXqGF7mcSq+p1p3Ri31Dxk=
X-Gm-Gg: ASbGncvGEF/4tbt0bniw3+OU2CI4d0u4zJCND6+0g0vBYMgF+NmT+gKliIts8GFW7qN
 B88MABMTo4xjUyiHWwI6madvgOyjSUUzfMrjg8RX4QTQv48/hLYuuiJ31TsWgFiEm+ET7/nGwXs
 KyG68CIxdH/SWkJfz2bYn29UECGpLaOiQSu+BBNiL65GVdGqN3fFvfD8MjjQ6QqybAfHRS+6dyY
 kEY8OUjnfizwSR84TtdyV1YSm5eElLJ0PEb1/g3IdIVbebXSLVtRnwq6sBk+2aEa6VqNmrBddCs
 5uW0+u9R08hiap0IUrWDZ8BYg/Y20ofWKWwTBWs=
X-Google-Smtp-Source: AGHT+IGvttAPaOmzjT1zaTxDUkTs0xdsIyfoRPP6eOyXdx0P9QqHHZa0/aLxQSnG1B/cQGGkUSC9Hg==
X-Received: by 2002:a05:6000:1888:b0:39c:1401:679e with SMTP id
 ffacd0b85a97d-3a074cdb940mr7265459f8f.5.1745831789752; 
 Mon, 28 Apr 2025 02:16:29 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:29 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 11:16:26 +0200
Subject: [PATCH v4 4/6] watchdog: at91sam9_wdt: Add SAM9X60 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v4-4-bb7d1c7c051a@hifiphile.com>
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

SAM9X60 has a slightly different watchdog implementation:
- Timer value moved into a new register WLR
- Some MR register fields have their position changed

This patch add SAM9X60 support, also adds a compatible
for SAMA5D4 which is the same as existing SAM9260.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 19 +++++++++++++--
 drivers/watchdog/at91sam9_wdt.c            | 39 ++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index a5accbae52186e99de0b113d6982a4cc54e36095..9a3976d9e970c212d348daeabc14c2fd6c54a8b5 100644
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
@@ -33,14 +40,22 @@ struct at91_wdt_priv {
 
 /* Watchdog Mode Register*/
 #define AT91_WDT_MR			0X04
-#define AT91_WDT_MR_WDV(x)		(x & 0xfff)
+#define AT91_WDT_MR_WDV(x)		((x) & 0xfff)
+#define AT91_SAM9X60_MR_PERIODRST	0x00000010
 #define AT91_WDT_MR_WDFIEN		0x00001000
+#define AT91_SAM9X60_MR_WDDIS		0x00001000
 #define AT91_WDT_MR_WDRSTEN		0x00002000
 #define AT91_WDT_MR_WDRPROC		0x00004000
 #define AT91_WDT_MR_WDDIS		0x00008000
-#define AT91_WDT_MR_WDD(x)		((x & 0xfff) << 16)
+#define AT91_WDT_MR_WDD(x)		(((x) & 0xfff) << 16)
 #define AT91_WDT_MR_WDDBGHLT		0x10000000
+#define AT91_SAM9X60_MR_WDIDLEHLT	0x10000000
 #define AT91_WDT_MR_WDIDLEHLT		0x20000000
+#define AT91_SAM9X60_MR_WDDBGHLT	0x20000000
+
+/* Watchdog Window Level Register */
+#define AT91_SAM9X60_WLR		0x0c
+#define AT91_SAM9X60_WLR_COUNTER(x)	((x) & 0xfff)
 
 /* Hardware timeout in seconds */
 #define WDT_MAX_TIMEOUT		16
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

