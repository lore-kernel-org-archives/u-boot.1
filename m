Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6954BC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 07:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D0486FCE;
	Fri, 17 Nov 2023 08:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NgL0VvxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 698C486FCE; Fri, 17 Nov 2023 08:53:11 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918FF86FB7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 08:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso564996366b.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 23:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700207585; x=1700812385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6gneQ2sXEeyyzBU4kdxtSWkxO3t6IRX/CX3EbT4uNk=;
 b=NgL0VvxIgVAvCWS9Xjnp16xdgIcL6uR448bnntu5QmIlWgsiBVe0UsnZpdnuzga3Al
 fLz/9+eDqQMIuoK5cdlNRT0YrtrioHKSFczRfnNXWkT/HoxHVOiW4EFsFb1UT9RsLWP3
 u2QggKEgJKAudYI29eylA0v8mi+Ryvx9NmIrlMYbhA/9I5cJHhAVgfxPj/Bt4f9n1Fo0
 Sj+LY3V79XNK0Hj3pAKg8z47tm5DOhrkJqqkh3ruNx4AzfwMbNzsv5rUhSPbCFvPxzn0
 bZQbwZ5ZLtpJ/rsekIRaX2xlVOMliprGlqT31tPXaeU7k3TvvKwHJRxOo72stIARFqLC
 pPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700207585; x=1700812385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6gneQ2sXEeyyzBU4kdxtSWkxO3t6IRX/CX3EbT4uNk=;
 b=L4FLO2nBNA5oTfTl3fFefHcNDryBd713ytg/IcL7PhnrEpq4dgMC9vrXOJbjN9hF5l
 uRZ3e+R5iQ6N+0p1crWUqfqmCSUCM9nQgAZrsTxDdwHxdijQYcJDRKrV2BQbLND3xC6b
 AFg0DBllT3qy9sCh4yo+U5GMnS2CumZV+QsyR4K3Tgn7lZ/HU9N7LA2Gi2OpbrWThIiu
 xp9COY9RmcAn2O7XV1lPRFSaBPPR/gtS5QPbZ/wLWn4Wf+9vhvx2Z6jrtXuEnEDjooBq
 1obn11usZR5VJRflzICnwvO8koQg6jxsP8/BHk/l5JgfU4Ouj7qu6vxBCBIETKAnHK0k
 8M7g==
X-Gm-Message-State: AOJu0YwBvmDoBgHh2K0mZqgaAf7LsV6iW7bKsc4L7qcLfqel3FmaQ11p
 CveD47LZLVQ3iq1C627RnfLDWug8rOE=
X-Google-Smtp-Source: AGHT+IFeOdxt+kjHuXBu9aJUNkqRzo9fgrsLsz/tjCQwsx377t2t+bx6m7kXfUBfo/o4AH+reNfuig==
X-Received: by 2002:a17:906:c111:b0:9ee:9d98:7d8c with SMTP id
 do17-20020a170906c11100b009ee9d987d8cmr4585232ejc.6.1700207585391; 
 Thu, 16 Nov 2023 23:53:05 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lo7-20020a170906fa0700b00988e953a586sm503967ejb.61.2023.11.16.23.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 23:53:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] clk: clk-gpio: add actual gated clock
Date: Fri, 17 Nov 2023 09:52:40 +0200
Message-Id: <20231117075240.15741-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117075240.15741-1-clamor95@gmail.com>
References: <20231117075240.15741-1-clamor95@gmail.com>
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
 drivers/clk/clk-gpio.c | 47 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 26d795b978..a55470cfbf 100644
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
 	struct gpio_desc	enable;
+	struct clk		*clk;
 };
 
 static int clk_gpio_enable(struct clk *clk)
 {
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
+	clk_prepare_enable(priv->clk);
 	dm_gpio_set_value(&priv->enable, 1);
 
 	return 0;
@@ -26,21 +30,50 @@ static int clk_gpio_disable(struct clk *clk)
 	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
 
 	dm_gpio_set_value(&priv->enable, 0);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
 
+static ulong clk_gpio_get_rate(struct clk *clk)
+{
+	struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
+	int ret;
+
+	ret = dm_gpio_get_value(&priv->enable);
+	if (ret)
+		return clk_get_rate(priv->clk);
+	else
+		return -EINVAL;
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
+		log_err("%s: Could not get gated clock: %ld\n",
+			__func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0,
+				   &priv->enable, GPIOD_IS_OUT);
+	if (ret) {
+		log_err("%s: Could not decode enable-gpios (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -59,7 +92,7 @@ U_BOOT_DRIVER(gpio_gate_clock) = {
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

