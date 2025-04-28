Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D43C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD57282140;
	Mon, 28 Apr 2025 19:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="qAYM1t/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B93782385; Mon, 28 Apr 2025 10:38:04 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC982820B7
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso35597265e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829477; x=1746434277;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XFi48a5J2cqrfG1p+/C/71EoybNOcKi6qk0N3VdQPfs=;
 b=qAYM1t/zRFHEDo5qDQpvjLMpNkE4IgmRfcfgSR/NTmjOAITAQ5qEIX+5/LgMm/freX
 4fJ/0UF2+ivvbgasDdHaGjYFHu9AsVQjNZ080ALrsSy42dZCK5AIcWEbFrpGake8G2JF
 64ZJeVlR5rLUOYlY3l2sPe8K+y8+JilKYUdHRnpejey09tCqGxSi7R/kSuGRdnAtCV8f
 wFdflygnT/odpdyoAqYzgIEmv1T5E2KxA9u4sTLWeXAJEj9icOX/K6ZRLHVQlY66ydE9
 i3X/BrC01yVDklhSbaEA+nepcujDSYFuMQPDgTxNY1dTyyC0bOSPiNetzsydIBHGzP8/
 vxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829477; x=1746434277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFi48a5J2cqrfG1p+/C/71EoybNOcKi6qk0N3VdQPfs=;
 b=kYJJa7LPsHOVQ8xUgpQMXUBOBJ1bSUFGANBJ5U1fBXLQ933dEDziSAZWzuf8SXKy22
 gkBwxH8Y+5ft1vYP9UwsQ1bNCVIsVMyc0ZT50zd1FYijpiN7D0vQN7d/BkMY+v2Mvutr
 gecIE7rz6Xxfg8h4BqioLXyNsmbPZtSDLStnA6DodUiMzTML/JMp//C+rP+pdtnhfDT6
 iY0BVOi+bOaVNqXHgOsu0K5M1zILhQAdLwmVecCmid/+IqG2wU8vN2rweRbfvzSKbQy9
 S4SZBsDcvzBn1qdXIinRSwInGx9t/Z8Ok4VlG89h7r/3GnphEiIfy/TAVinwiL0I0J7M
 mHcA==
X-Gm-Message-State: AOJu0Yzxueus6SeoyNJL6jxIiYPbhBfotqcaT0vb/eS7N51BXV+W4hEx
 bEjkkl0kQqQRwACo3Xb7CcKP6nu7aG6qg2zzHZx31zpjUo02QoY/C6BAG0qw4hA=
X-Gm-Gg: ASbGncuB/iU3Vd0lHiEmWKG0b+mEtB3xBkkS+qAJiSVvDuPY+NErzwzcSi7qrnT+8BS
 R5yyqA9QuK0M8eZYrRBSWbKvrjGRe6aZyt7wNt5Xx05bhORsRVMe/cr6mACMRLDof7KLlG3Y6wM
 /hwBc73tQquOzmp5w1hOST0WtxXywxN/SEv8Ff/pLd478cmX2gMpUbsclDPo1lflNNwIeeQbl5z
 BeFPbjT59S9RU7j/7mOLfd3q6YfP4s+G8SrI6uRSaFg7lCUVK/G5OH1OK+01WAVfoqsgTmx/fy4
 ITIkaZlMQBC9K+Zs8fLgQ8PwBnaiAe20rlVSBSY=
X-Google-Smtp-Source: AGHT+IGnGBPuJNqKnssKs328DqS8juBUESpnDlcE/q0T1+03PS9amryrhy54bwvSyoEAwoTJzR5ZLw==
X-Received: by 2002:a05:600c:4ec6:b0:440:66a4:8d1a with SMTP id
 5b1f17b1804b1-440a65ba116mr73183515e9.7.1745829477371; 
 Mon, 28 Apr 2025 01:37:57 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:57 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 10:37:37 +0200
Subject: [PATCH v3 4/6] watchdog: at91sam9_wdt: Add SAM9X60 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v3-4-86f0c5d92c32@hifiphile.com>
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

