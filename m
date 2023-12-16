Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFBCC38147
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 08:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AEF87B59;
	Sat, 16 Dec 2023 09:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gBAeODWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD3E87AD2; Sat, 16 Dec 2023 09:49:08 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEFCE87AD2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 09:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c9f8faf57bso16972771fa.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702716545; x=1703321345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4S9dmTB4CyjJIpE5hsbNq+12+100fkLf58lp1eDHVE=;
 b=gBAeODWUniln2Jcbmx+QoveT9e5y91auC4zooH3IqdVAiRPMZ+vdUwcnc0h608i2kf
 Wnk/yoMsaklxrlLBqZ5Gq71ZVyb2tZOQECt7n2rtqaHSDRG2/4LWsrZBOh7Rz76TMm1Q
 HinsUOgkca+GRVltBW7tPPEyczzHnpFduirVoZGhLH/P51f7SKvA+qFUiJ2tkjtjMLQX
 MYL9PanwiTIOXsSPobLpi9/aR2SaiDCtkvY2YOBLAOF8SlCZzgEumwuKNqmD8YR1KDC9
 iQO5Hp3G+9ZWnr5a9kVS7DDS3PeyW2SiCbwI+bxL5B1nmwCnvSb+nVdM+tclEcpEuwtx
 oDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702716545; x=1703321345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4S9dmTB4CyjJIpE5hsbNq+12+100fkLf58lp1eDHVE=;
 b=OKi49yYcfCz/Zmcg++Zr+BAMDqZnmS4hLDcVCCjn1j5nmKtXWjZjaeK9JHGGFkKfwy
 IvWgX7NMgS4v+NWB/wf8ZUoQaUwrqQUqToxT4dF+nucuM7/8Z0eM4aeYyD7ZuEWkVytL
 rYHJ02LUOtJj8ScwlanEWQ4cfE7Hp6l5Vf5VKtbbcqHM1lujzEvcvxIg4pqHoAc5daz6
 Tk3ZKj5y2uRuyH0BXbCT6qsqgfVn/rqpkrTPLlyPoHGad8iUXaql4iPKCc49AN5N1IQU
 0cL0LibVAlUnUunsFJY4iM79EnEiPnT8V7FS0McD70uCrbGZnORZZ6KlxqpUCgosWYbt
 znVw==
X-Gm-Message-State: AOJu0YzVJS95LIukF8i9f4kvTufgAsRUsxC3S58au0+wP8FfP+VjQ7mV
 zNhhjJrpzuoAuABTSJJtQdo=
X-Google-Smtp-Source: AGHT+IEiX7N+182UaiXi8LR3Vib6houLgOkf88a8BQSihtAxnfr59G84cuuVo6iYkHDQz4Xwgk/6tg==
X-Received: by 2002:a2e:be0c:0:b0:2cc:200f:4392 with SMTP id
 z12-20020a2ebe0c000000b002cc200f4392mr5901878ljq.46.1702716544874; 
 Sat, 16 Dec 2023 00:49:04 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 f22-20020a056402195600b00552687b7b1fsm2525197edz.39.2023.12.16.00.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 00:49:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Date: Sat, 16 Dec 2023 10:48:38 +0200
Message-Id: <20231216084838.19403-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231216084838.19403-1-clamor95@gmail.com>
References: <20231216084838.19403-1-clamor95@gmail.com>
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

Existing gpio-gate-clock driver acts like a simple GPIO switch without any
effect on gated clock. Add actual clock actions into enable/disable ops and
implement get_rate op by passing gated clock if it is enabled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/clk-gpio.c | 44 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 26d795b978..72d9747a47 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -3,19 +3,23 @@
  * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
 
-#include <asm/gpio.h>
-#include <common.h>
-#include <clk-uclass.h>
+#include <clk.h>
 #include <dm.h>
+#include <clk-uclass.h>
+#include <linux/clk-provider.h>
+
+#include <asm/gpio.h>
 
 struct clk_gpio_priv {
-	struct gpio_desc	enable;
+	struct gpio_desc	enable;	/* GPIO, controlling the gate */
+	struct clk		*clk;	/* Gated clock */
 };
 
 static int clk_gpio_enable(struct clk *clk)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
+	clk_enable(priv->clk);
 	dm_gpio_set_value(&priv->enable, 1);
 
 	return 0;
@@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
 	dm_gpio_set_value(&priv->enable, 0);
+	clk_disable(priv->clk);
 
 	return 0;
 }
 
+static ulong clk_gpio_get_rate(struct clk *clk)
+{
+	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
+
+	return clk_get_rate(priv->clk);
+}
+
 const struct clk_ops clk_gpio_ops = {
 	.enable		= clk_gpio_enable,
 	.disable	= clk_gpio_disable,
+	.get_rate	= clk_gpio_get_rate,
 };
 
-static int clk_gpio_probe(struct udevice *dev)
+static int clk_gpio_of_to_plat(struct udevice *dev)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(dev);
+	int ret;
 
-	return gpio_request_by_name(dev, "enable-gpios", 0,
-				    &priv->enable, GPIOD_IS_OUT);
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_debug("%s: Could not get gated clock: %ld\n",
+			  __func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0,
+				   &priv->enable, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: Could not decode enable-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -59,7 +87,7 @@ U_BOOT_DRIVER(gpio_gate_clock) = {
 	.name		= "gpio_clock",
 	.id		= UCLASS_CLK,
 	.of_match	= clk_gpio_match,
-	.probe		= clk_gpio_probe,
+	.of_to_plat	= clk_gpio_of_to_plat,
 	.priv_auto	= sizeof(struct clk_gpio_priv),
 	.ops		= &clk_gpio_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
-- 
2.40.1

