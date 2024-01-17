Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD3CC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9D387B52;
	Wed, 17 Jan 2024 18:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LqOco1KB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 596F587A1A; Wed, 17 Jan 2024 18:17:30 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B9C87B52
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55969c01168so4964217a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511846; x=1706116646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=LqOco1KBqrbf7SiCZUI/Ti1zjmQJR5f276nP/3EhoiVvXE3ZwP5SeuiCj1XdJ41whB
 w47ofBhUtevSlci0m5M/drwE2UaoAk3u5KZhlVI1oOTXtlZXgVOiqLTGsxhrgoxv2a8R
 mlnwmlCu9vy4H43PPM+mP93Cdz4A0Q3IYdHC2nQkw8/ds8qMyVvLi4YCMrU6moBhixUO
 q6o3XnbZraend5putkCkj5MCs7K3fjeDtMP+nW/T666OMBB4dtd4P/TTw0JM3onLWPm+
 QT8M4LEc8SynDIixrss1DKTyKIXxEj4T+GhtYQOPkl4NiuPavv6qgI90w3bRWKAbZee7
 sllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511846; x=1706116646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=mrlRz3tXunMnSjfA6iCWnmUMFJpRipUOINeqLJRRAAzRDUAWxBkhHZPhIqlBA1Mi0+
 xHnBjkMSYE5IZ9Qe15bLJ4aXuzAbrb0s61kl5Eto7ppRI0K+Rzvic+eCEa49Neab8Z2j
 g2BUDTzxHxOVv3DrlUISXgUX8CVOgk4+Fv9B6+x9jmaEeZOS+i5a4xgSu7YKa/7cg5NO
 qRCske3tPSG/7G22m48DdKKnSa4+K/sgYWick2E9sLyCQICZvkbnVBDCFF9NfHFQWsE4
 aGtlsFMetzXxG83P5s0bWmcIPpdZhUwT6QBnFe7QAsvsGvacwlua2nCoc5UYspPxjhBi
 OXpA==
X-Gm-Message-State: AOJu0YwoOL64mIJd8qJoJoLtEbZBt7IN8UDR/+R0KkKkemDEHA7S0Q4J
 4EKHuXZmeHj8GtPnV/2AltMpie5lX+TR3yNgvubZHO27KUOG5wYa
X-Google-Smtp-Source: AGHT+IG3dI7K1DzcAd6kskoBfMzAS6RXf1LUU654+c12xOM3tR3EX/yJmbCZ42J1x2n02SJkLvzZCw==
X-Received: by 2002:a17:906:da8c:b0:a28:a7cf:b014 with SMTP id
 xh12-20020a170906da8c00b00a28a7cfb014mr1605530ejb.2.1705511846714; 
 Wed, 17 Jan 2024 09:17:26 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 07/13] video: tegra20: dc: add powergate
Date: Wed, 17 Jan 2024 19:16:52 +0200
Message-Id: <20240117171658.22324-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

Add powergate use on T114 to complete resetting of DC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 35abb6fe46..9a18e38cd8 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -22,6 +22,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
 #include <asm/arch/pinmux.h>
+#include <asm/arch/powergate.h>
 #include <asm/arch/pwm.h>
 
 #include "tegra-dc.h"
@@ -32,6 +33,7 @@ DECLARE_GLOBAL_DATA_PTR;
 struct tegra_dc_soc_info {
 	bool has_timer;
 	bool has_rgb;
+	bool has_pgate;
 };
 
 /* Information about the display controller */
@@ -360,6 +362,28 @@ static int tegra_lcd_probe(struct udevice *dev)
 
 	clock_disable(priv->dc_clk[0]);
 
+	if (priv->soc->has_pgate) {
+		uint powergate;
+
+		if (priv->pipe)
+			powergate = TEGRA_POWERGATE_DISB;
+		else
+			powergate = TEGRA_POWERGATE_DIS;
+
+		ret = tegra_powergate_power_off(powergate);
+		if (ret < 0) {
+			log_err("failed to power off DISP gate: %d", ret);
+			return ret;
+		}
+
+		ret = tegra_powergate_sequence_power_up(powergate,
+							priv->dc_clk[0]);
+		if (ret < 0) {
+			log_err("failed to power up DISP gate: %d", ret);
+			return ret;
+		}
+	}
+
 	/* Reset everything set before */
 	reset_assert(&reset_ctl);
 	mdelay(4);
@@ -510,16 +534,19 @@ static const struct video_ops tegra_lcd_ops = {
 static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.has_timer = true,
 	.has_rgb = true,
+	.has_pgate = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.has_timer = false,
 	.has_rgb = true,
+	.has_pgate = false,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.has_timer = false,
 	.has_rgb = false,
+	.has_pgate = true,
 };
 
 static const struct udevice_id tegra_lcd_ids[] = {
-- 
2.40.1

