Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CB0C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0427820F6;
	Mon, 28 Apr 2025 19:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="OjaHM6uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B582826AA; Mon, 28 Apr 2025 10:37:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527E480EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso31254235e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829477; x=1746434277;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KDNDf38hmz4ezf7Qlr8d8SB+WtVky07NqgNOy98MtjM=;
 b=OjaHM6uy2I02AarfTSpuD/QE+ggDHykxuWg/r69tZ/tjCiQy/ukpD37t2BAoRlgeAt
 LR8cd3/58NdP71iJLeUlOuTWy/mClMLbFmDL2SLiBpbi+cCfiPirErnbidUBCxrgglCG
 O1gJ4UVpfGtk9qmfejFJDD5nh7JlnLC/oC8GncCNWqc0aXy2DjbmIq1ahued1Ihg82hI
 6wdElZK/0JfQ32AeNV81bkWyMP4un8I5kc7mGs+DeCEM3y1RA4vkY/bvBOeN/zFf6Isr
 8mP9chbnyYtMyeFpLAz9QLJ+6pf6dvTvKFhkfcZ5T6zkHEZqJt0V7BZ4MVcz182KLrYk
 29KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829477; x=1746434277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDNDf38hmz4ezf7Qlr8d8SB+WtVky07NqgNOy98MtjM=;
 b=kOqrAKtrRzZNkAR30Mu3vqjcaylgDy0k6S5Y0iS/oS8OC1sI6wAAqLqVpD0c3Zx16i
 7Ro3DR2Q+Z6Jy57WINVFhmAjsTLCI002QZkcZ314GPzoQ7FPBMNOHnQM4skh651+g+vG
 k4JasDO49q60VuY4oyiUlbknWuUqKWYeA4IaFNYcDPmXNVxRv5VCB4EpjuSnuErb+xXz
 GtPbFbnUSHjE6BF8816/QfN2SF/dSpk5bhLQaFziqZvhJPD0rjvEtnef1uB7PimBCwpH
 hSJjoNc9Cq48Qwy5pi9ysqc3u1XsZA/jCVPfPQ1aryE/IoH3i+2IdFC5OJDvBieUMLz5
 YSrA==
X-Gm-Message-State: AOJu0YwDmV7z3wUTKSIaQYYQIj3EjaL/0KRT8Css/q7kta/CAwJie/6g
 Lre/K57zcwD9zGbRcGWGpYezgCJ6AviiNH1AoAPaI78IDs1eJXD6htHkT4DS16U=
X-Gm-Gg: ASbGncv9HlDThqgDwpHSUpukZgSgzeTIe37WsKdll6+ab8lYNiYxeEK7lZ9DA6Nquho
 sLSmI9nMdrWkX1JhYSJWgLpuLdMhcf0yF40Z/2dIb1+YTsztRkQFkYQF7o0exbVNRdw7iZWhhbs
 lyz9FSXl3uEseWfF7dgL7M7RBWbpH1qXqOouF2HkuqLhc/UN3HpnbcyY8YFDkibxtZtZuHbaBUm
 L0ebblrxZyT5CyQH51LneOr6RdVvhLXTZFah+2IL77RwrmcWngb/gELVagLGD+pqF/aJF/sqPE/
 87d+Lw5hchkkDY79DeYKcKHnKu+i/peLSXJYUA1pyF+D/vd9UQ==
X-Google-Smtp-Source: AGHT+IGd03+txDQ5+ORzfo5+NmcXHhv+Wvl5Sdg7d0up/Ye7jjicy0/5YF0GmQ8qEwDPlGOrtgaL2Q==
X-Received: by 2002:a05:600c:1f91:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-440ab7b7969mr81432885e9.10.1745829476777; 
 Mon, 28 Apr 2025 01:37:56 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:56 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 10:37:36 +0200
Subject: [PATCH v3 3/6] watchdog: at91sam9_wdt: Rename priv to wdt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v3-3-86f0c5d92c32@hifiphile.com>
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

