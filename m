Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C2BD3F29E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECCF988E2B;
	Fri, 18 Oct 2024 22:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="axQyPOwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3889E88D72; Fri, 18 Oct 2024 22:27:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F7E88B23
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so7431885e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1729283245; x=1729888045;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoCJD5Zngd/58b2dw/ExiyOu/rcLIvwRGXdTekrnXME=;
 b=axQyPOwxvnn1acE3PR+qAUEV1WGbPDQJX8hjFd8/0PK/JMhU5De4AwSL2ldqAxIWiV
 G9LQTM/h+ZGjK82EjwagZAniImWT6MhD0H8jJbJRGXGNcyG97du6o7eCy8QtxHwC7N3/
 18PfXCtlG/62yGONI3h7w2seGEEb36irxRJ0LGdXHn2vUtyXiF8wn4PwApvv3Ts81JE/
 8SjRF70oPp/FvyGkMJ2kwPikZQ6xwtj2c5y/NJ5j1q6rTouAABwIO/YbQgi7SEOp/yQP
 O4a9kqruo/gaS2gIsVFID+Wesz/LvlpHH0lz9+mbBoX0X/jwyhFBKozmma2LbT/Nnblw
 Vcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729283245; x=1729888045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoCJD5Zngd/58b2dw/ExiyOu/rcLIvwRGXdTekrnXME=;
 b=RX5Zy95w7VMOir+GkTadUS6cVJM7Wek1b5Nxg2vyEHYLu8njX80EBNi9tGTPWLuPE3
 JbK7Eqq3+8jPFwk+6AjeSlV/h7v5Bfa6SFnDqdilSwX+zPXU5gMvsApxsOv21vYiFKMy
 Q5ty97sD/R8n535l4bBpYFIYAN0a8InSkDk/PLkHZRcEGwAzGySwAmonGJ5txJIkxov6
 ISAIiQgVPvz57Rf6XzLx0Zkkvgqg6GooLypDl9so69/uhnMe80sdz5lwsJnDxGW0CTU0
 2si5ebCyjD87JsmMCST4yZ/KnMixyBgoPSty34t6Ituy2AtZyTQxddXOfwCCSO4WZkpi
 WnKA==
X-Gm-Message-State: AOJu0YxdVKPu2sW3JapjiUfWZB6qU6OmWS/GlByK/nBQGj7ha2ZNK262
 JhlBUCgQX6VKRsIwC9ezcPIruQA4Zr/iD/zmnij3cz3IpPYLpFQiwqRGQ2SUUI5o/Z2AUNeeWC0
 f
X-Google-Smtp-Source: AGHT+IFk4/Yy3K06l3JL0KglpA7Gs4L4mv+xyjVHjlf2Yayu5IbFme5mxDF/+KccCRf02FEqT4PrSw==
X-Received: by 2002:a05:600c:3151:b0:431:4fbd:f571 with SMTP id
 5b1f17b1804b1-43161685008mr24424795e9.13.1729283244743; 
 Fri, 18 Oct 2024 13:27:24 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm35810395e9.10.2024.10.18.13.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 13:27:23 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH 3/3] gpio: at91: Implement ops get_flags
Date: Fri, 18 Oct 2024 22:27:15 +0200
Message-ID: <20241018202715.283011-3-admin@hifiphile.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018202715.283011-1-admin@hifiphile.com>
References: <20241018202715.283011-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Oct 2024 22:46:12 +0200
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

Add ops get_dir_flags() to read status from GPIO registers.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/gpio/at91_gpio.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 7828f9b447..c986007716 100644
--- a/drivers/gpio/at91_gpio.c
+++ b/drivers/gpio/at91_gpio.c
@@ -240,6 +240,24 @@ static void at91_set_port_multi_drive(struct at91_port *at91_port, int offset, i
 	else
 		writel(mask, &at91_port->mddr);
 }
+
+static bool at91_get_port_multi_drive(struct at91_port *at91_port, int offset)
+{
+	u32 mask, val;
+
+	mask = 1 << offset;
+	val = readl(&at91_port->mdsr);
+	return val & mask;
+}
+
+static bool at91_get_port_pullup(struct at91_port *at91_port, int offset)
+{
+	u32 mask, val;
+
+	mask = 1 << offset;
+	val = readl(&at91_port->pusr);
+	return val & mask;
+}
 #endif
 
 static void at91_set_port_input(struct at91_port *at91_port, int offset,
@@ -608,6 +626,32 @@ static int at91_gpio_set_flags(struct udevice *dev, unsigned int offset,
 	return 0;
 }
 
+static int at91_gpio_get_flags(struct udevice *dev, unsigned int offset,
+				ulong *flagsp)
+{
+	struct at91_port_priv *port = dev_get_priv(dev);
+	ulong dir_flags = 0;
+
+	if (at91_get_port_output(port->regs, offset)) {
+		dir_flags |= GPIOD_IS_OUT;
+
+		if (at91_get_port_multi_drive(port->regs, offset))
+			dir_flags |= GPIOD_OPEN_DRAIN;
+
+		if (at91_get_port_value(port->regs, offset))
+			dir_flags |= GPIOD_IS_OUT_ACTIVE;
+	} else {
+		dir_flags |= GPIOD_IS_IN;
+	}
+
+	if (at91_get_port_pullup(port->regs, offset))
+		dir_flags |= GPIOD_PULL_UP;
+
+	*flagsp = dir_flags;
+
+	return 0;
+}
+
 static const char *at91_get_bank_name(uint32_t base_addr)
 {
 	switch (base_addr) {
@@ -637,6 +681,7 @@ static const struct dm_gpio_ops gpio_at91_ops = {
 	.set_value		= at91_gpio_set_value,
 	.get_function		= at91_gpio_get_function,
 	.set_flags		= at91_gpio_set_flags,
+	.get_flags		= at91_gpio_get_flags,
 };
 
 static int at91_gpio_probe(struct udevice *dev)
-- 
2.46.2

