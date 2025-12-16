Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD1CD5C0C0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 04:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E703C80077;
	Tue, 16 Dec 2025 05:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8c+026t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA24B800AB; Tue, 16 Dec 2025 05:14:53 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAA88003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 05:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so4086398b3a.3
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 20:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765858489; x=1766463289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f3pLmiGqeUt9DvOJSvkhVM5smAwLPGXGWZrDGLJ00ro=;
 b=e8c+026tLo34ECuwPc6QbKaWh4KsKFbAWIhJVpTs2Jfwxj8+pQK2elYVsY/IkRjDlT
 VPhz9IpDpMD3afZhztNBNc9r/L879Mblqs94ChbMM4aed+Jp+snvy0lEXG8n0fs5yzoJ
 uCF9PevW2kdVIHAUzeJ7utkE3Sb/FtSYVQzTDbfaCR6fCVfnIGrRNbhzkaMgXOBRCnPX
 mh/sI+1Mf3dJ9sr3OndlvONLcggudNbMgUCt7gx6NkronZuzTiovaMgVTvVDPVjK/Kp8
 KZ67WIZe8Pp7vuUS4wduKoG0MWe1C7DznGPTK8n96kYJo2i27OWjpFdBYSFqJQcC20X/
 uu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765858489; x=1766463289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3pLmiGqeUt9DvOJSvkhVM5smAwLPGXGWZrDGLJ00ro=;
 b=wKSm3XAfAKf07zN5oVZ7GkeUbh4brq1g1oOzVBwmjlHhLrzwuLoVZd/4wZnb8NYGh8
 lFKtCVul4wYgHAFvwkkkE+SqG0RKCG/kSbPr+Loa1sZ2Hghd3SyGaqy9Snfez6xZRsm7
 LeD7W+le3BiwrEHvTGhLRdYaDoSHhy0wzMCPqJtn0M1ILFlTZmnbvsvLS+gnOiNWS4j8
 duPdL9/+zeJcVvvnApipUhqXD01nfLY0/f8henb5TQOTDYWQGSICjYNLPEiN/cwTWaBX
 OqWAZjYjn9tuU6FB9zs62u9LRyvt3clKjwvUY+oDooIbXpLrW6gziey52MaHATR7VgQa
 Cw+A==
X-Gm-Message-State: AOJu0Yy9XahcA6ElMEAt6KEcEbofCMbMtenpC1Er/WLhXjgIcjLSz9jp
 QqheZRvspn/EOhxB4Zeorj8Aq5uVGqr1RDcUGShlwfQxio036y+hDvAq
X-Gm-Gg: AY/fxX61KGJZnW7BBd2PLcMI4m6E1XTxpI2iDEjzr3DB8ZvQhgs6jWenrpc9mZwwjR1
 TVb4uR0XMuw4xHXCck6hQmY5IUIScX2z8ln8I8h3B3hakPHfejL6CZwrLw5LCinfDKn2C3PFZmJ
 eTmByskUaZJMR6GlpI2PB953TEPZtLZoh4Jnh7gx4ZKA5dYH16Oug9+S/Ju5yQ6P+iIW7qM/W+w
 zJ/pGmiHwmfXE8vmP44c5Xpra2auNQWE7RIgVG64I1CE9+ObIXadbAETGQxjoSO+2rVs0S2blCF
 Wzuhr25YtJm8zKDADB+DrgdyWqzBoIIdzgoEIVcY5dyIUK8o9jLH1Sy4lvFEyFiHraYzPzqX3kO
 wDyhGNlWqMPxl+BKxfO4UbDT0xZU2pVmW1YoCFrHObX+BmYiL6PgF72ZoUuI4MS/Ym82Rx8+NI7
 i87pDnScIras/0toH9Feg58nps
X-Google-Smtp-Source: AGHT+IG1iaI6N3PjEHaGFbSDgtFygT7vvxsSW6FPcBcq4fNmwp4EexqwY2RdnqTUDxx6L6lEWdTngA==
X-Received: by 2002:a05:6a00:4510:b0:7e8:4398:b36d with SMTP id
 d2e1a72fcca58-7f669c8a50fmr14507798b3a.64.1765858488717; 
 Mon, 15 Dec 2025 20:14:48 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:6e81:75c6:bc48:733d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c2379972sm14064264b3a.9.2025.12.15.20.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 20:14:48 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: stefan.roese@mailbox.org,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] watchdog: orion_wdt: Add support for armada-xp
Date: Tue, 16 Dec 2025 17:14:38 +1300
Message-ID: <20251216041438.1945123-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the orion_wdt.c to support armada-xp and similar SoCs. The WDT
block used in armada-xp is fairly close to the armada-380 with just a
few differences that can be handled based on the compatible property.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 drivers/watchdog/orion_wdt.c | 99 +++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4562b2a37e34..3b76c0fd2ea1 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -43,8 +43,14 @@ struct orion_wdt_priv {
 #define TIMER_A370_STATUS		0x04
 
 #define WDT_AXP_FIXED_ENABLE_BIT	BIT(10)
+#define TIMER1_FIXED_ENABLE_BIT	BIT(12)
 #define WDT_A370_EXPIRED		BIT(31)
 
+struct orion_watchdog_data {
+	int (*plat_start)(struct udevice *dev, u64 timeout, ulong flags);
+	int (*plat_stop)(struct udevice *dev);
+};
+
 static int orion_wdt_reset(struct udevice *dev)
 {
 	struct orion_wdt_priv *priv = dev_get_priv(dev);
@@ -56,7 +62,59 @@ static int orion_wdt_reset(struct udevice *dev)
 	return 0;
 }
 
-static int orion_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+static int armadaxp_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct orion_wdt_priv *priv = dev_get_priv(dev);
+	u32 reg;
+
+	priv->timeout = DIV_ROUND_UP(timeout_ms, 1000);
+
+	/* Fix the wdt and timer1 clock freqency to 25MHz */
+	reg = readl(priv->reg + TIMER_CTRL);
+	reg |= (WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT);
+	writel(reg, priv->reg + TIMER_CTRL);
+
+	/* Set watchdog duration */
+	writel(priv->clk_rate * priv->timeout,
+	       priv->reg + priv->wdt_counter_offset);
+
+	/* Clear the watchdog expiration bit */
+	reg = readl(priv->reg + TIMER_A370_STATUS);
+	reg &= ~WDT_A370_EXPIRED;
+	writel(reg, priv->reg + TIMER_A370_STATUS);
+
+	/* Enable watchdog timer */
+	reg = readl(priv->reg + TIMER_CTRL);
+	reg |= WDT_ENABLE_BIT;
+	writel(reg, priv->reg + TIMER_CTRL);
+
+	/* Enable reset on watchdog */
+	reg = readl(priv->rstout);
+	reg |= RSTOUT_ENABLE_BIT;
+	writel(reg, priv->rstout);
+
+	return 0;
+}
+
+static int armadaxp_wdt_stop(struct udevice *dev)
+{
+	struct orion_wdt_priv *priv = dev_get_priv(dev);
+	u32 reg;
+
+	/* Disable reset on watchdog */
+	reg = readl(priv->rstout);
+	reg &= ~RSTOUT_ENABLE_BIT;
+	writel(reg, priv->rstout);
+
+	/* Disable watchdog timer */
+	reg = readl(priv->reg + TIMER_CTRL);
+	reg &= ~WDT_ENABLE_BIT;
+	writel(reg, priv->reg + TIMER_CTRL);
+
+	return 0;
+}
+
+static int armada380_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	struct orion_wdt_priv *priv = dev_get_priv(dev);
 	u32 reg;
@@ -94,7 +152,7 @@ static int orion_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	return 0;
 }
 
-static int orion_wdt_stop(struct udevice *dev)
+static int armada380_wdt_stop(struct udevice *dev)
 {
 	struct orion_wdt_priv *priv = dev_get_priv(dev);
 	u32 reg;
@@ -116,6 +174,22 @@ static int orion_wdt_stop(struct udevice *dev)
 	return 0;
 }
 
+static int orion_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct orion_watchdog_data *data =
+			(struct orion_watchdog_data *)dev_get_driver_data(dev);
+
+	return data->plat_start(dev, timeout_ms, flags);
+}
+
+static int orion_wdt_stop(struct udevice *dev)
+{
+	struct orion_watchdog_data *data =
+			(struct orion_watchdog_data *)dev_get_driver_data(dev);
+
+	return data->plat_stop(dev);
+}
+
 static inline bool save_reg_from_ofdata(struct udevice *dev, int index,
 					void __iomem **reg, int *offset)
 {
@@ -144,8 +218,10 @@ static int orion_wdt_of_to_plat(struct udevice *dev)
 	if (!save_reg_from_ofdata(dev, 1, &priv->rstout, NULL))
 		goto err;
 
-	if (!save_reg_from_ofdata(dev, 2, &priv->rstout_mask, NULL))
-		goto err;
+	if (device_is_compatible(dev, "marvell,armada-380-wdt")) {
+		if (!save_reg_from_ofdata(dev, 2, &priv->rstout_mask, NULL))
+			goto err;
+	}
 
 	return 0;
 err:
@@ -176,9 +252,20 @@ static const struct wdt_ops orion_wdt_ops = {
 	.stop = orion_wdt_stop,
 };
 
+static struct orion_watchdog_data armada380_data = {
+	.plat_start = armada380_wdt_start,
+	.plat_stop = armada380_wdt_stop,
+};
+
+static struct orion_watchdog_data armadaxp_data = {
+	.plat_start = armadaxp_wdt_start,
+	.plat_stop = armadaxp_wdt_stop,
+};
+
 static const struct udevice_id orion_wdt_ids[] = {
-	{ .compatible = "marvell,armada-380-wdt" },
-	{}
+	{ .compatible = "marvell,armada-380-wdt", .data = (ulong)&armada380_data},
+	{ .compatible = "marvell,armada-xp-wdt", .data = (ulong)&armadaxp_data},
+	{ }
 };
 
 U_BOOT_DRIVER(orion_wdt) = {
-- 
2.52.0

