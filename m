Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7B3D3F29E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 840A188DFF;
	Fri, 18 Oct 2024 22:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="JVY0oFZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E3888DA0; Fri, 18 Oct 2024 22:27:26 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D84E88D5B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so32298895e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1729283244; x=1729888044;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cU8ffk7avq6dqi+FK+yp8rCXvS00d7UDYCrxvClces=;
 b=JVY0oFZL0wXNz38BYV2q0rfHL7H/GiTzfa7W/hbHCcU2jtZwp83I5u/sRa1Qf5sVji
 uyH8wpuh5htZKASkswolXD5xsuTZTmIIq55vKZK4ZskYmt2ujNCIri9UMVwkg6DM9361
 /EiYYHJ/PXNy5G/K957I88GQn9SrUPS7SB7wsilb+U+SQELgWn+QklBl8P3vbz+fN0U3
 XQUTgvYTKaCTWGOfoZ2GuycHtzjqzrNqGu9WSWv2ld6ksjM04Kzc5TCKak2f6D0DAAx1
 LDaFbTRQ3lPBGBET7WJu6oYcWxyXtDyhj5IX2pxDnwI/HBSGlhdORUisFptBlOolgVB5
 8dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729283244; x=1729888044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cU8ffk7avq6dqi+FK+yp8rCXvS00d7UDYCrxvClces=;
 b=pAKvYBtyosczXI8xntJvCeYmsrFpqXX8ODm+1NFmyBp5E0e41NAKUspq2bKknTRQMR
 pq2lXjACwgbr8j/gWIaL7Vn8wNfFlvyknSOJdDpT7ZXkH8zXL+gG1+z+jie62r59xQJ0
 zDgsDMZfW7diOvYxivpUiIUhMDp3308plOWgeUtTVlGLzPtbOnjbEmSxmD8pveMv3lty
 0BaLWYRFg/gvRaApIlqLqBoitr2dmERxXHwNzoL0sxFSGv65nZmYcyexpey/1UAYPSN8
 wCpWmeoaTweH2w7NcZDS8D9f92AJnoraIaN8c8Z22KtwPZHLhrIKKN4mgIVMMz7/1PRN
 mAnA==
X-Gm-Message-State: AOJu0YyI94M3O9XQhZlY27JbR1dLaB34N4CSvBBck+Kp7+oKoUjT/lyR
 w4VC9SE2cJSIOGOBH8jY2haHmfqohdrGVdpfTqY83u38JYkMoipKNZtGSa346lRsW75Lc4uI1Z2
 P
X-Google-Smtp-Source: AGHT+IFPssC9dXTGivPgVfTmeSxZ/4z8E40V5JCpbvExUk+5Q71JyQUAdYSqE56rWVL5vn+4oTOqgg==
X-Received: by 2002:a05:600c:5489:b0:431:24c3:dbaa with SMTP id
 5b1f17b1804b1-4316161eeaamr34227795e9.2.1729283243509; 
 Fri, 18 Oct 2024 13:27:23 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm35810395e9.10.2024.10.18.13.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 13:27:22 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH 2/3] gpio: at91: Implement ops set_flags
Date: Fri, 18 Oct 2024 22:27:14 +0200
Message-ID: <20241018202715.283011-2-admin@hifiphile.com>
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

Support GPIO configuration with following flags:
- in, out, out_active
- open_drain, pull_up

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/gpio/at91_gpio.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 64a6e8a4a5..7828f9b447 100644
--- a/drivers/gpio/at91_gpio.c
+++ b/drivers/gpio/at91_gpio.c
@@ -229,6 +229,17 @@ static bool at91_get_port_pio(struct at91_port *at91_port, int offset)
 	val = readl(&at91_port->psr);
 	return val & mask;
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
@@ -568,6 +579,35 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
 		return GPIOF_INPUT;
 }
 
+static int at91_gpio_set_flags(struct udevice *dev, unsigned int offset,
+				ulong flags)
+{
+	struct at91_port_priv *port = dev_get_priv(dev);
+	ulong supported_mask;
+
+	supported_mask = GPIOD_OPEN_DRAIN | GPIOD_MASK_DIR | GPIOD_PULL_UP;
+	if (flags & ~supported_mask)
+		return -EINVAL;
+
+	if (flags & GPIOD_IS_OUT) {
+		bool value = flags & GPIOD_IS_OUT_ACTIVE;
+
+		if (flags & GPIOD_OPEN_DRAIN)
+			at91_set_port_multi_drive(port->regs, offset, true);
+		else
+			at91_set_port_multi_drive(port->regs, offset, false);
+
+		at91_set_port_output(port->regs, offset, value);
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
@@ -596,6 +636,7 @@ static const struct dm_gpio_ops gpio_at91_ops = {
 	.get_value		= at91_gpio_get_value,
 	.set_value		= at91_gpio_set_value,
 	.get_function		= at91_gpio_get_function,
+	.set_flags		= at91_gpio_set_flags,
 };
 
 static int at91_gpio_probe(struct udevice *dev)
-- 
2.46.2

