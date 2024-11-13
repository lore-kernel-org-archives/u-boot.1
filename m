Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989EBD41C3F
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE601895A7;
	Wed, 13 Nov 2024 14:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="1A+NZXYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA1E89559; Wed, 13 Nov 2024 11:11:30 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9D289554
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so4459007f8f.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731492687; x=1732097487;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DdTB6YDh8O2zIG09S1w93scaAA4EupOeh0yUpozgh7o=;
 b=1A+NZXYjCD6DF1J8WsAJVZyIWkBMD1ii6IrxBPgKJ1J2sWjUoadmqaOdn1jZ79Dsf4
 2GadFN7cEL7I6Gt/UdGP1ChwUfAUf7UaH2ANQ+EdHBSIhw9yKkx3Ji+vcBrCIFt3eFbM
 YKJ7EARGSlgsVhQgwbI1+XkvUpE/Yy1Q9UhRFQH4dKbudnTjoU9vDygzJ4h00fXgtHO5
 hDZCKFC/+9phpwcn5BgOWQ8JH7MAycR+o9a9cfMpAnwkgIFIabLDyujvByVw9o/LfNk6
 N9LDkzaupJmYbvQXTuAPGNlAeGeuTbHyFmI+FZ81q0fQzsXbhLXbaF/k9Dl7baWf1Vrn
 Nqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731492687; x=1732097487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdTB6YDh8O2zIG09S1w93scaAA4EupOeh0yUpozgh7o=;
 b=P/+AO3LiAqvmoJ9n9IJ5InRcTcd5TDX50e79htND9nRVOxywWDttJERMuPMwj+CrMu
 9GtRBGeyZb2f3lQiGkSGgkVLBjRk7XwLBZH+6ID7XF15OsmRwqe8OwxU/UVKs0YWoshS
 4TpsF/QLiUOHS9rRnbEu5WVD/6xaYifxtge5iladjO7AcnWjaQp8SFicM54X8A/rBrdr
 RsNTQtD3/6nHfZyyAw7TgzjGOv7PZlsL86LKDSqcNf8NaKeKfVyFpr7RRCULyOvTuX/U
 eGxGvIPVFcyBSKmT9Nuew4bXh7he8MDBUg/hY1PuU9EppY34Y/s8k1esg4hidZwpqDR0
 5GJQ==
X-Gm-Message-State: AOJu0Yw8ocopQrMeheWczPH2qboUKBuMmAbDcNo5ku+Nd2rVSfdPxtVE
 SbnD0SH2+J0dec+NRi6qFa0CZ5Zt5lLZfH1EsSwjXu0w3Oqc2Hs1590nfb+Cwno=
X-Google-Smtp-Source: AGHT+IEaj7C6zLDQump3Rs2lgXbeCd1SsR7knWS/R8iqBw0Vb+CqyZYkn6159PfSN3O88nZI+M/vxQ==
X-Received: by 2002:a05:6000:788:b0:37c:d537:9dc0 with SMTP id
 ffacd0b85a97d-382080f696fmr4834447f8f.12.1731492687507; 
 Wed, 13 Nov 2024 02:11:27 -0800 (PST)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381ed987d95sm18106298f8f.44.2024.11.13.02.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 02:11:27 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH v3 3/3] gpio: at91: Implement ops get_flags
Date: Wed, 13 Nov 2024 11:11:09 +0100
Message-ID: <20241113101109.2915784-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:05 +0100
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
Changes in v2:
- Fix pullup read polarity
Changes in v3:
- Use clamp (!!) to turn return value into a bool
---
 drivers/gpio/at91_gpio.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 758cb4a806..a0a200b3ca 100644
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
+	return !!(val & mask);
+}
+
+static bool at91_get_port_pullup(struct at91_port *at91_port, int offset)
+{
+	u32 mask, val;
+
+	mask = 1 << offset;
+	val = readl(&at91_port->pusr);
+	return !(val & mask);
+}
 #endif

 static void at91_set_port_input(struct at91_port *at91_port, int offset,
@@ -606,6 +624,32 @@ static int at91_gpio_set_flags(struct udevice *dev, unsigned int offset,
 	return 0;
 }

+static int at91_gpio_get_flags(struct udevice *dev, unsigned int offset,
+			       ulong *flagsp)
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
@@ -635,6 +679,7 @@ static const struct dm_gpio_ops gpio_at91_ops = {
 	.set_value		= at91_gpio_set_value,
 	.get_function		= at91_gpio_get_function,
 	.set_flags		= at91_gpio_set_flags,
+	.get_flags		= at91_gpio_get_flags,
 };

 static int at91_gpio_probe(struct udevice *dev)
--
2.46.2

