Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA793D41C3F
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674E5895A5;
	Wed, 13 Nov 2024 14:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="Pf8xTmmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED3289558; Wed, 13 Nov 2024 11:11:01 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797B989554
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so6661104e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731492659; x=1732097459;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6sX9NOZfe40mSuYEvP7zVXvSADO0t5wDn0QeB6fKmeA=;
 b=Pf8xTmmLyapgaprnpQD0VILBQTLbu70K4Yd/r2fB1uge3XbkVtiABOFoxwHqXUaTIQ
 2yCCNzmKLc4XOO5w+zinntQsQJJYaYkkODb0ic7Fn30G8mi8hMwz3MUc5XO/E3ko5onP
 d2xBlOFz7rDX7Uz9sEGG1BoRaSN0Oc/fSBTCUpQUmUZraYrPWEdUaugnURywuXQSi73F
 zkx8az4y8atETEUjK5lLlOJEfR/HGC7ympDnuZTHanXGU6J7zfi27nxMKJg+3kl/Ntkt
 LeTAUcN9xkZW3mSJgWIzlZairwcriGzmXjIquhD/HdDjW+oFkS6Wwj0Og8UBF3cns4ND
 llBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731492659; x=1732097459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6sX9NOZfe40mSuYEvP7zVXvSADO0t5wDn0QeB6fKmeA=;
 b=d8Tv/XDw4dcACBfjeqZHUhAeW2kPnCRdtncf5XanZ10hDdOVY6SBCVEg/T1P7nZ3Nq
 lZpD4xjY97llZ86VoxUZpjsaBVvyNqsx5VGqg939rG0x05vMDrlaV8DWW/MdchNeOwJs
 UR/Ba3QUFZ0jQmIN4bHpxAK715iAmNpUkd30zlzI8XjsabPeyzrAFBY1izLky6tYD+6/
 KT4gM/XPP41qgPklsJoZ9lV4nar3R64M155Q1Ih4VYxeFDT3MvS+TIXEu9IjcHj81+UN
 iCxGxmz6rihFZXDxzyhUDxNRVRPaPQuLF6pAxl5cDxOa+aIWm1a1kblh2aJ5VSWrX9x9
 xQAg==
X-Gm-Message-State: AOJu0YzhgmanSvsoO1aJ796qb71bbmmD24voSqfMMJ7/MwqhTVhhmoDV
 FbZUEsn3QV6wnDXE7RHa9kXtsYWqEo4FFXiJuDqvVw+M3MvfBUb3MQz3Zu2rCCc=
X-Google-Smtp-Source: AGHT+IF+XvJ4MFBz8KX/H2PMAv0eW+JYYo3m8/CLYUXOe7NgLIkQ0PJp8rDOLA6AMAT2vENUojRLWg==
X-Received: by 2002:a05:6512:3c97:b0:536:73b5:d971 with SMTP id
 2adb3069b0e04-53d862ebeccmr10367937e87.38.1731492658570; 
 Wed, 13 Nov 2024 02:10:58 -0800 (PST)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432d54f829asm18997075e9.13.2024.11.13.02.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 02:10:58 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH v2 2/3] gpio: at91: Implement ops set_flags
Date: Wed, 13 Nov 2024 11:10:54 +0100
Message-ID: <20241113101054.2915628-1-admin@hifiphile.com>
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

Support GPIO configuration with following flags:
- in, out, out_active
- open_drain, pull_up

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Changes in v2:
- Return ENOTSUPP if flag is unsupported.
- Inline port output variable.
---
 drivers/gpio/at91_gpio.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 173315d45f..758cb4a806 100644
--- a/drivers/gpio/at91_gpio.c
+++ b/drivers/gpio/at91_gpio.c
@@ -229,6 +229,17 @@ static bool at91_is_port_gpio(struct at91_port *at91_port, int offset)
 	val = readl(&at91_port->psr);
 	return !!(val & mask);
 }
+
+static void at91_set_port_multi_drive(struct at91_port *at91_port, int offset, int is_on)
+{
+	u32 mask;
+
+	mask = 1 << offset;
+	if (is_on)
+		writel(mask, &at91_port->mder);
+	else
+		writel(mask, &at91_port->mddr);
+}
 #endif

 static void at91_set_port_input(struct at91_port *at91_port, int offset,
@@ -568,6 +579,33 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
 		return GPIOF_INPUT;
 }

+static int at91_gpio_set_flags(struct udevice *dev, unsigned int offset,
+			       ulong flags)
+{
+	struct at91_port_priv *port = dev_get_priv(dev);
+	ulong supported_mask;
+
+	supported_mask = GPIOD_OPEN_DRAIN | GPIOD_MASK_DIR | GPIOD_PULL_UP;
+	if (flags & ~supported_mask)
+		return -ENOTSUPP;
+
+	if (flags & GPIOD_IS_OUT) {
+		if (flags & GPIOD_OPEN_DRAIN)
+			at91_set_port_multi_drive(port->regs, offset, true);
+		else
+			at91_set_port_multi_drive(port->regs, offset, false);
+
+		at91_set_port_output(port->regs, offset, flags & GPIOD_IS_OUT_ACTIVE);
+
+	} else if (flags & GPIOD_IS_IN) {
+		at91_set_port_input(port->regs, offset, false);
+	}
+	if (flags & GPIOD_PULL_UP)
+		at91_set_port_pullup(port->regs, offset, true);
+
+	return 0;
+}
+
 static const char *at91_get_bank_name(uint32_t base_addr)
 {
 	switch (base_addr) {
@@ -596,6 +634,7 @@ static const struct dm_gpio_ops gpio_at91_ops = {
 	.get_value		= at91_gpio_get_value,
 	.set_value		= at91_gpio_set_value,
 	.get_function		= at91_gpio_get_function,
+	.set_flags		= at91_gpio_set_flags,
 };

 static int at91_gpio_probe(struct udevice *dev)
--
2.46.2

