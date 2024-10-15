Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EA0D1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 20:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3687988770;
	Tue, 15 Oct 2024 22:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1s+pjZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEC385B66; Tue, 15 Oct 2024 22:29:40 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F00889CA
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 22:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5389917ef34so6456733e87.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729024176; x=1729628976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2sLAKLrW5gHZLEvpHUVP4kNJ0S6AobuxiD8w9gaNX9Q=;
 b=j1s+pjZb1ayUezmHETqncfgZTOVUhKdVOlpxSGij4RxUleRRG3C5dC2Da2O2F6+m3H
 nwAI7c90SmBOE2b36aqRn4if7dxkKdE1Y5S1HHlZuQ+lT2C9gVEV5xsy4qXmFGJK1xCy
 DbsryHkF5oiK5rBwWZGULLqNyOkxRKk2LqZiHx0A6WsnjhqyeGndtw+Mz5dgl9mZ2heu
 nAzM+sbcgMQprlR8RDTFw+4nn5Je19SK/2DRM7ntBRFeLPkDSa0e30XFvPgW5NJ/dHYv
 xDN/smbjl7NFhWflrc3u2zTcBx5uldGm5qh+ssm67jxeteiaBYxQfSKLcxyS8Moh6kfI
 fDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729024176; x=1729628976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sLAKLrW5gHZLEvpHUVP4kNJ0S6AobuxiD8w9gaNX9Q=;
 b=ntJ3KcbgkbPScX3ywWGYhCPGhCAb8SByfUTkgQ2bPe9n/4HnM/GOUt1+QmlSKorudv
 9pkUmGOSuH2ydRi7Yw+7yamimNFawQsODTBGP9283cfSiD50WQhDCIGkzEMLWfc+NIaN
 A2/tpPz+cmANTMqIzGwfKor7qgYPxO+wDv+tUCHD5DArDMh62kNLlHUBWyhRF0ky26Yl
 PMtNfaKOftU1TcMJ3kIx/Nai4IEjEGJi0f2qtHZqqYBnIs8ic+Uncg8sFYvvCseRHYv3
 nrRCRUX+5QVY4hUSENIpywv11SdMXhQ/rwKGahGPqr2u8GeF8t077LVJN2WBC2HUAH9T
 LDaQ==
X-Gm-Message-State: AOJu0YwFUAHmOwgNxo+Q5oBye2pl7X1mn84NTwi3JCNEEAYrXax53Z6F
 wSZqjSY9ONZ6NFH75vYQ7v8p4dkWxRPFHyYoNPhLglGxrLOBH0v1m+4Frn7hfeg=
X-Google-Smtp-Source: AGHT+IG9O3hrmiBBVnj6/BIyyBuglu3PYg0qgEB/l5Micn8qCv4Q1cq//tyfrQ6h6QrdbKPY7UcwUg==
X-Received: by 2002:a05:6512:3402:b0:535:68ab:7fdd with SMTP id
 2adb3069b0e04-539e54f023amr6016864e87.19.1729024175648; 
 Tue, 15 Oct 2024 13:29:35 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539ffff3b2csm249543e87.124.2024.10.15.13.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 13:29:35 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: i2c-gpio: add support for i2c-gpio,sda-output-only
Date: Tue, 15 Oct 2024 23:29:31 +0300
Message-Id: <20241015202931.15270-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Some I2C slave devices are read-only and don't even answer with NACK.
For example FD65x segment LED controllers.
Make them usable with i2c-gpio,sda-output-only that are already supported
by Linux 6.3+.

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

 doc/device-tree-bindings/i2c/i2c-gpio.txt |  2 ++
 drivers/i2c/i2c-gpio.c                    | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/device-tree-bindings/i2c/i2c-gpio.txt b/doc/device-tree-bindings/i2c/i2c-gpio.txt
index b06b829933..bb00854f33 100644
--- a/doc/device-tree-bindings/i2c/i2c-gpio.txt
+++ b/doc/device-tree-bindings/i2c/i2c-gpio.txt
@@ -20,6 +20,8 @@ Optional:
    Run deblocking sequence when the driver gets probed.
 * i2c-gpio,scl-output-only;
    Set if SCL is an output only
+* i2c-gpio,sda-output-only;
+   Set if SDA is an output only
 
 Example:
 
diff --git a/drivers/i2c/i2c-gpio.c b/drivers/i2c/i2c-gpio.c
index e0a575fb4a..00aef40e34 100644
--- a/drivers/i2c/i2c-gpio.c
+++ b/drivers/i2c/i2c-gpio.c
@@ -101,7 +101,7 @@ static int i2c_gpio_read_bit(struct i2c_gpio_bus *bus, int delay)
 
 	bus->set_scl(bus, 1);
 	udelay(delay);
-	value = bus->get_sda(bus);
+	value = bus->get_sda ? bus->get_sda(bus) : 0;
 	udelay(delay);
 	bus->set_scl(bus, 0);
 	udelay(2 * delay);
@@ -256,6 +256,9 @@ static int i2c_gpio_read_data(struct i2c_gpio_bus *bus, uchar chip,
 {
 	unsigned int delay = bus->udelay;
 
+	if (!bus->get_sda)
+		return -EOPNOTSUPP;
+
 	debug("%s: chip %x buffer: %p len %d\n", __func__, chip, buffer, len);
 
 	while (len-- > 0)
@@ -353,7 +356,10 @@ static int i2c_gpio_of_to_plat(struct udevice *dev)
 	bus->udelay = dev_read_u32_default(dev, "i2c-gpio,delay-us",
 					   DEFAULT_UDELAY);
 
-	bus->get_sda = i2c_gpio_sda_get;
+	if (dev_read_bool(dev, "i2c-gpio,sda-output-only"))
+		bus->get_sda = NULL;
+	else
+		bus->get_sda = i2c_gpio_sda_get;
 	bus->set_sda = i2c_gpio_sda_set;
 	if (dev_read_bool(dev, "i2c-gpio,scl-output-only"))
 		bus->set_scl = i2c_gpio_scl_set_output_only;
-- 
2.34.1

