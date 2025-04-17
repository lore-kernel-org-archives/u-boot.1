Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C19C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C81183055;
	Thu, 17 Apr 2025 14:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="D/hrGozW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E2E82FC8; Thu, 17 Apr 2025 11:10:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4E18300B
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so3988695e9.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881009; x=1745485809;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KDNDf38hmz4ezf7Qlr8d8SB+WtVky07NqgNOy98MtjM=;
 b=D/hrGozWTWRiyqk53xIQFhu3J/WFF8kTEoEOr6YNI99zHNFZGqnJ+KxHZh0zKKMhK+
 S6oolDRLHVU4UfZ+hnFTtIYYbgrDaYirFepq8Httms/ave/DVXfIGio77lgKvdFbU7QR
 OjNNPWkISeSKtoJckFqMAykTS53fvlFiFNAncByBFiJUmDKmNSYyomHCKMbzVjQLH76j
 UxZmxyHOKYcVMfrkaQeR0uy26lHwwxaiti988OqMmESL8g9T9bF4WrUke/vi9h/wW2Z7
 BiKkmHM2tZxryiHNl3k15GGeH1w8a4RC/4R/az2piGYC7eojn7pjXPNmhZvikJDpX9aj
 3dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881009; x=1745485809;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDNDf38hmz4ezf7Qlr8d8SB+WtVky07NqgNOy98MtjM=;
 b=kUTncysxkD8tfTchl+9gsqqJp+1fhRuWe/+Io3ru1ExJD1nRw83+mDuZ9iBTz/AXQe
 yUKjb0L8DVSedQfD/CgV1O2ap2cUp98XNxHJYqq/FL/no+b0QFAvy2cYYgYv+rZ2b+Yl
 7skdBbCfkwBFi1MvngJnozxOIZbgXCOcM7FIphXJ1lKsYaxYvbKMaBOqxSOKMb8eaH5V
 FF+W+pz1XvC3agwA5UJT44AolfWj8vO0yUqyy7Vbo5az3l/DKSFFuyvU3mbONqZGwDjj
 1EKLoGERBdZDavFOXdgLXGJnmj9XWQ1+yz/6L2SibbB7dJ1fDZirXZQwV20U8NX6hD+1
 HHOA==
X-Gm-Message-State: AOJu0YwV0ddr8NYHaYuZq3IdP0TSFlDrb0MjQb/GBkmFMjU3cOsTgXBa
 vRQy3s4UgjSu2CtmtuM//HMrURp9N36SvPoVTov7aYViiEKqe4t5LkrhE8Z+/dOspK+8SbKzFQx
 h
X-Gm-Gg: ASbGncvlXl94eyIORN/KaSXX+NBGQvvkRcqeFPPf1aDCelVOJ1XKELVt8bphh2XDOtr
 J4Orhoa8fCYJh9bWIyQbU/c2kfeMv/JBDMJQGHzI98VZkYZpsFhmUe9Qh8QDh0DDcRYqnUMdUCw
 LtCNT/IVzHQ7Tw67oolMCAUyPHTfyjDye5TMSbXyjPKsflP5uKzH8QmoltP0Ol/DDhbP8gBouNn
 xYL+IbXvzH/Zt6SJ2DY5igLherCUxXPJTIK8fn1WjwrM2MAccquIz8k11qXxcVyuMDgFkiqJBSI
 VghEz4LqAnnQs72VQ7y4DAlEB132+GASzZBxl+I=
X-Google-Smtp-Source: AGHT+IHiRLcd6uDd2BZYBNYqXAHsfDypA7838W1L/6XFwE5cmF1Gkmf6Ec7wJb4qv4V/PIkQcxOcig==
X-Received: by 2002:a05:600c:5494:b0:43d:fa59:bcee with SMTP id
 5b1f17b1804b1-4405d6cc6acmr39366635e9.33.1744881008760; 
 Thu, 17 Apr 2025 02:10:08 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:07 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:51 +0200
Subject: [PATCH v2 4/8] watchdog: at91sam9_wdt: Rename priv to wdt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-4-49939de473e1@hifiphile.com>
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

"wdt" is a better name for watchdog rather than generic "priv".

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/watchdog/at91sam9_wdt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index dab7b6a9b8ca09e6113109391560434ffe1f7cb6..5ca3e5a5fdefb3101c97754f10b65c0acd69a522 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -38,7 +38,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
-	struct at91_wdt_priv *priv = dev_get_priv(dev);
+	struct at91_wdt_priv *wdt = dev_get_priv(dev);
 	u64 timeout;
 	u32 ticks;
 
@@ -49,7 +49,7 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	ticks = WDT_SEC2TICKS(timeout);
 
 	/* Check if disabled */
-	if (readl(priv->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
+	if (readl(wdt->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
 		printf("sorry, watchdog is disabled\n");
 		return -1;
 	}
@@ -60,31 +60,31 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	 * Since WDV is a 12-bit counter, the maximum period is
 	 * 4096 / 256 = 16 seconds.
 	 */
-	priv->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
+	wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
 		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
 		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
 		| AT91_WDT_MR_WDV(ticks);	/* timer value */
-	writel(priv->mr, priv->regs + AT91_WDT_MR);
+	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
 
 	return 0;
 }
 
 static int at91_wdt_stop(struct udevice *dev)
 {
-	struct at91_wdt_priv *priv = dev_get_priv(dev);
+	struct at91_wdt_priv *wdt = dev_get_priv(dev);
 
 	/* Disable Watchdog Timer */
-	priv->mr |= AT91_WDT_MR_WDDIS;
-	writel(priv->mr, priv->regs + AT91_WDT_MR);
+	wdt->mr |= AT91_WDT_MR_WDDIS;
+	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
 
 	return 0;
 }
 
 static int at91_wdt_reset(struct udevice *dev)
 {
-	struct at91_wdt_priv *priv = dev_get_priv(dev);
+	struct at91_wdt_priv *wdt = dev_get_priv(dev);
 
-	writel(AT91_WDT_CR_WDRSTT | AT91_WDT_CR_KEY, priv->regs + AT91_WDT_CR);
+	writel(AT91_WDT_CR_WDRSTT | AT91_WDT_CR_KEY, wdt->regs + AT91_WDT_CR);
 
 	return 0;
 }
@@ -102,10 +102,10 @@ static const struct udevice_id at91_wdt_ids[] = {
 
 static int at91_wdt_probe(struct udevice *dev)
 {
-	struct at91_wdt_priv *priv = dev_get_priv(dev);
+	struct at91_wdt_priv *wdt = dev_get_priv(dev);
 
-	priv->regs = dev_remap_addr(dev);
-	if (!priv->regs)
+	wdt->regs = dev_remap_addr(dev);
+	if (!wdt->regs)
 		return -EINVAL;
 
 	debug("%s: Probing wdt%u\n", __func__, dev_seq(dev));

-- 
2.49.0

