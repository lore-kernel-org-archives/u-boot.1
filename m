Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20ABC369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6437782757;
	Mon, 28 Apr 2025 19:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="bjpoOB8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513858214A; Mon, 28 Apr 2025 11:16:31 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFAB80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so3231779f8f.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831789; x=1746436589;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KDNDf38hmz4ezf7Qlr8d8SB+WtVky07NqgNOy98MtjM=;
 b=bjpoOB8iPcFbJZlRtKpbHGkhCdvdBrOdh2Mg9he96xRA+TEOMM8CfClzyOEcxnTEV6
 fIBYwklsh2CvtqTpVJPxog5u74zQJ65HFI8XeOcbPdyd9wskL0g1v4XJ5kJH9MvwM/Bf
 y/o7xkJ/clF5XY/KaQM8acQ8JOvcRW50PlmrYMRcvvKTRcQEZ8Kcy4mfaOPJVCw16FMV
 Ty8dvuOx8DRQ83S8oncUVjehSL3eFNDolsz1dE+3az8cVKvmnX+lu7c5j1KuuCm/3F/y
 2OPGlHLRi4gVrKZwSP7ni7Uo9wuJ+ijb9z5O05opk5yWXkuikTaHpm2sFUVy0k9PqxBy
 sMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831789; x=1746436589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDNDf38hmz4ezf7Qlr8d8SB+WtVky07NqgNOy98MtjM=;
 b=MzLzFKLRa1KVZnarrW1WiEJj5m20BM7As+v2hRIenngt4gqcMGUQROOB5aMrlTPbgH
 sb34253C60Iqy1h43CCKoYjEPktEV8Gp2YmPIk5KPyaxseg9rwoSbzs+JAnzXw87PQ8z
 RvyihaJQjHW/oj6m78kGjoT0Qq5kbszgA/3uqIZhOks+qgQ70tjWHsDJ2cBsvXGNhdg1
 pLQwdsMPklpsAmfkq/Yl7+9cJu+Cx8eFpSfKJVxGEX2SknIe6E0Ig+t1freeEcLPbvCZ
 IFLzs9ASqKMJh9VwAPrv3hHiVOcgnyYpXNmoMegLRheLIvqWNXi/cvwejb3ITbVpwBcr
 I74Q==
X-Gm-Message-State: AOJu0YzGbUixRu9+IWvQT9Ka+ut3B9096IO6exOUW6AsISV68j9IOWrc
 WnE/hLTTrCfHMXpoQG0F7VisAHKjIwtg9or9pSwGl1y4tp7N8WPNsbvhEYe8waN2p3c/erlrXCc
 d
X-Gm-Gg: ASbGncumMTNxwyJsGp4tx9DFSrhQSk0sabJ6T0aG0DFWW3BjnzYZYrDkF9PtT9KTaxj
 GhBeNaasFzfwztM498YS0xTYiWi37mID0ShzpXiPP0ZahhuVylLIWFr7TWNCqiT6GV2YU+ecLk2
 AOQ2yC1wAqqCIUX2HqfBRkXfOYNc0lsH4UwK8TBfXl/Vox4RzPBDi0FBBhQCbWX8n0hoyPFV+eQ
 QnEKfWYNXGtu3TmpRwXDh/kAYys5UopgnLq5v4UMbzC1lHUD7W8r5LgyVcQYv9j9cBpKqxjuNEq
 /K6h76/uy6W07VRg/j7TdKjI5zdd3MCBR9B7Jwc=
X-Google-Smtp-Source: AGHT+IFzt25BMBhB+TJd58zy8bMiMmNK8XcMifREHqVpJxXqhC76TxlS4kh6EYEv6EyBnjHoQtF/Pg==
X-Received: by 2002:a5d:5f43:0:b0:390:d6b0:b89 with SMTP id
 ffacd0b85a97d-3a074f48123mr8371676f8f.50.1745831788807; 
 Mon, 28 Apr 2025 02:16:28 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:28 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 11:16:25 +0200
Subject: [PATCH v4 3/6] watchdog: at91sam9_wdt: Rename priv to wdt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v4-3-bb7d1c7c051a@hifiphile.com>
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

