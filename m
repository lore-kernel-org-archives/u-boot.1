Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92465C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD01A81F28;
	Mon, 31 Mar 2025 21:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="eDYjowI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4322E81E06; Mon, 31 Mar 2025 21:16:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C0581EBB
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso32470305e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448592; x=1744053392;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBZlIRVzkSqmCvxZVLTr0dUSlD8KOHQvVAlwmikk4RU=;
 b=eDYjowI6BT8ftNBUqMfU41X5H1xFmnYKfvLdUtC04s2QpjcJcvcLMXScticG2Otq9R
 odD/pSepLpWEzlffIemUxWUX71X/13r8pbh4hwl/mAUDel9gMLDNjq7t6rceNm4vs75Z
 Evao6dy+J/bE0CWyBMIZFScpSmDKljzi9sTNaRVonLkDeh4Pk/u3Cj6NvuY8Epp0V16E
 3ALnpsZBSIBV6AfqJc94m6Fj9rbAX97lzvxKAiSpHpAYztrhRyjpAGHYGmvT6Vm4k4ho
 +PzohTxPo7U95u2J9qEMQ2Fm/gYOP20iVLG5HSJN0dbPb/3anfDPHngAptv1H4eKq25+
 259g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448592; x=1744053392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBZlIRVzkSqmCvxZVLTr0dUSlD8KOHQvVAlwmikk4RU=;
 b=V6iQwt0nzRA7x0Ume87/QvbJhyvSCHkROFw6IzZ3ysqt3QAvSUZU8SVl9tesSwWR+G
 tyZHsF0yWg1BCmih7Hv/C0bC8S6yakSQlEUc5HxQ6XNhzHXKmkE4x8OTaO6BhgUVE0CC
 89CH8ZBPOE8b0fZ/a1CKNhToMMfOEy/EEQ+exb08Hcs1ZN90Pd85pAaUZDlH63qYEHLZ
 MF8GQM6Z4Gp9JKXc4Voqv05d4uIScTgOPi/L2w1+brIXG3HNo0cihdw67kDK+gwFQGmv
 8tOz8UNrMDfhXrNUp1Fb/yG86DVHLtyv3faiZD/t/wZCdI+NhCowzMqSKYEvwDY9oZUb
 RhOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCIPb9sB+EvUZIWNUN9NVJODT58ruyRR8d+N1n6TLcex5sjd3dboqoe/o2iFNzvw5yi97j/Uw=@lists.denx.de
X-Gm-Message-State: AOJu0YxBYq1Vk6d9uncWesnKjGAxrh1JzmnBuk0PwxgSD6T6BABe5xlr
 BKA+CDiwhuz258VtgKy+7I3NGYqoneRWPEcSEqSzkGVYHArsZezHrPInGv0IObe7tnCw22ye0Xf
 f
X-Gm-Gg: ASbGnctl+hLUwo1wl4CQhmlDwKuqaRhq5SwWDBZxjpzW8Tsibim8wFKSQwAIClr/STk
 9Z79+2vbNa+q4DLN/eRQVg6hsAK7mUsv7ozIxfSjN2J9PuRAlnH1BfATuGpeEyypqvJ/J4057zF
 4Ndd9HncmB7H5PXP7xs++JySVtKwRpjWsziTWvL7+BAv/Sns5bCtl+XeAN9TNiwxqhQ9fuk8ST7
 ensDabBjinr475aT2UKae/9l96YUnX1L2j3FxnjmiYBhAW/McXvxUjIruvfo+BqXe1CYYI3VQg1
 4YLBIxQwUJm43ompbz7TmTj39gYVDk8yoY6MK2jyFmBs0nwpB95VC0dx
X-Google-Smtp-Source: AGHT+IEXrpzgTp1Ci8RRZUTduYLQmRa8PQ8vmw8Dk+h+Sz8tQCvJEKEFEdG9NieVd6cA7fjAA1Gbjw==
X-Received: by 2002:a05:600c:c8d:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-43db61d0e8amr144065775e9.10.1743448591687; 
 Mon, 31 Mar 2025 12:16:31 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:31 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Stefan Roese <sr@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/7] watchdog: at91sam9_wdt: Rename priv to wdt
Date: Mon, 31 Mar 2025 21:15:12 +0200
Message-ID: <20250331191520.1805001-4-admin@hifiphile.com>
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

"wdt" is a better name for watchdog rather than generic "priv".

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/watchdog/at91sam9_wdt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index dab7b6a9b8c..5ca3e5a5fde 100644
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

