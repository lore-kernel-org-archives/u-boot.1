Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECE2E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4249483C5E;
	Mon,  9 Feb 2026 19:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AVL/+Kde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B8F83CB5; Mon,  9 Feb 2026 19:03:52 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE118388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38319cbc8fbso27236451fa.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660230; x=1771265030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkrcySbn8El4YGV+XosdWifRE4BR4g/GRXFsIK2An10=;
 b=AVL/+KdeTma85pgGsZvHRJg3xfJT544EoejmKfV5VIHZrKtfhpsOf0bs9pdHn7b6GZ
 t8U7vDnInfjiOGXRLMYiqd8zSADrDr2W9+TMi8Cm+ZPgdtlwnlku2eMuMmm6eHpvBnnS
 niR2sbppdYhTrYRaSniHfCnXt7djmQ04PtFaBh9bsnVSHlCWpN1rKz9SkptzybJc/uGP
 rGQ9o1rjhtm6x0PFfP19pvFIUIFANQzO7bTKnMmcfLK3NClaT8XOIVnGL0bYDNHtxyum
 hMOmusxIDNQ1OFmp155ViqQCaDYpABuiS5BjrwluRWYxx99jVWlBq2otGP+yiBO/Uwsx
 6k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660230; x=1771265030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qkrcySbn8El4YGV+XosdWifRE4BR4g/GRXFsIK2An10=;
 b=Xp8rHn1hKeOTRKkF1Q+R4wQVdGkqXvQ7X+0oAxqYjyIYQZMd6IlvB20vhQMxIsDrwH
 vA4NUJXDG9jifCZDbXj4UpeuzCbYxMCsIIsdhYwoDTN67OanRYCVQsPFh+fN6JaWZ4n3
 bWWuKfL0F3y/sfDqi9BzD8HQxH8nNEzvopgLlGBpzEuTT8ZLaUxPtf862uWMybVGISnk
 ePIg8pH18Zdzoqp+E4LwIqc32ebJ+533TqTUpwU5zulyxhyMCm4ql9dJjTGoPwcKE26l
 E/JtHmtFkmNUHBDGJUkP4uCkhbaGmDIyKpl0yNSAsf9QdkH4nJEZT4GTIPvPlaD+QPcE
 IVsg==
X-Gm-Message-State: AOJu0YxVwapmhIRqzJo222+h4aI3t1HAM9FOOnVBIQdOcvMreXaSBGoz
 WWwGKyLnhr2PQ+HzjURS4MazxJHMm8HNbYf/PcAkpaPrXi9bwfIB2pz2
X-Gm-Gg: AZuq6aKLkTjc8tgFpHZlccx6dVz+8kW5mdKBLyeofTqC2zANfOBpW4TZ9IIqqoOsErT
 iAzSPEC5h5nOZAt+cKuNCNtsjeDPpaDodTqX/dX5SW2zgFWsbIa2HmmDeqgOLLPrnfhoulxKdZE
 CREWoySfUxupNca++p3XUC0qCmagtQ1YQGThlI9S/oXqZoPToch1neTmgDufPs2UZNpOzZQzCJd
 yvwjkLadV5cr8t1NdsR9YznriBZWFgcimVfCaFcah5GxPbyXjpWzn/18AzPZg+OyHPMZBs7qHN8
 2Zqz+PO67q9VbXI4CNI0MUA6aYT6/UR7bZc9h6g+g0D/YR6nPVsoU6Y2Tfzp6yF4YGa7uhZi8UK
 Lz2BxDTdFU0QNaWH7M4MqnHVJw+ynhHJlDQUIKFlnPe7Fd4Oa1EyAIjTCGyoVtem3p7IcQNHA0N
 nZ
X-Received: by 2002:a05:651c:1601:b0:37f:cf97:4957 with SMTP id
 38308e7fff4ca-386b517ef3cmr40257761fa.45.1770660230057; 
 Mon, 09 Feb 2026 10:03:50 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b6236383sm27285351fa.10.2026.02.09.10.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:03:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/4] pwm: tegra: add probe function
Date: Mon,  9 Feb 2026 20:03:23 +0200
Message-ID: <20260209180326.32190-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209180326.32190-1-clamor95@gmail.com>
References: <20260209180326.32190-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

When PWM config was updated the clock was restarted which caused loss of
previous configuration of other channels. Further this fixes a bug/hang
that can happen when set_enable was called before set_config.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pwm/tegra_pwm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/tegra_pwm.c b/drivers/pwm/tegra_pwm.c
index e3f1417f2ad..7105d6db90d 100644
--- a/drivers/pwm/tegra_pwm.c
+++ b/drivers/pwm/tegra_pwm.c
@@ -19,7 +19,6 @@ static int tegra_pwm_set_config(struct udevice *dev, uint channel,
 {
 	struct tegra_pwm_priv *priv = dev_get_priv(dev);
 	struct pwm_ctlr *regs = priv->regs;
-	const u32 pwm_max_freq = dev_get_driver_data(dev);
 	uint pulse_width;
 	u32 reg;
 
@@ -27,8 +26,6 @@ static int tegra_pwm_set_config(struct udevice *dev, uint channel,
 		return -EINVAL;
 	debug("%s: Configure '%s' channel %u\n", __func__, dev->name, channel);
 
-	clock_start_periph_pll(PERIPH_ID_PWM, CLOCK_ID_PERIPH, pwm_max_freq);
-
 	pulse_width = duty_ns * 255 / period_ns;
 
 	reg = pulse_width << PWM_WIDTH_SHIFT;
@@ -63,6 +60,15 @@ static int tegra_pwm_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int tegra_pwm_probe(struct udevice *dev)
+{
+	const u32 pwm_max_freq = dev_get_driver_data(dev);
+
+	clock_start_periph_pll(PERIPH_ID_PWM, CLOCK_ID_PERIPH, pwm_max_freq);
+
+	return 0;
+}
+
 static const struct pwm_ops tegra_pwm_ops = {
 	.set_config	= tegra_pwm_set_config,
 	.set_enable	= tegra_pwm_set_enable,
@@ -80,5 +86,6 @@ U_BOOT_DRIVER(tegra_pwm) = {
 	.of_match = tegra_pwm_ids,
 	.ops	= &tegra_pwm_ops,
 	.of_to_plat	= tegra_pwm_of_to_plat,
+	.probe		= tegra_pwm_probe,
 	.priv_auto	= sizeof(struct tegra_pwm_priv),
 };
-- 
2.51.0

