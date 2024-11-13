Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E534D41C3E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C5A8959F;
	Wed, 13 Nov 2024 14:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="3fODM8k0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713528904A; Wed, 13 Nov 2024 11:10:49 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7143389554
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb4af0b6beso92020541fa.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731492647; x=1732097447;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnCJ4+6ymcqhIURLlrgRj3oo9xvZ6lElRnwG/wDdvuQ=;
 b=3fODM8k015KX6B0kLBofqJTSktevJftXxBSWlTygNbPIETz9EPIfkIiEkpgwQ0O1/O
 bKwVPMLA0tVhXUkj3Fw5UmLMthdjbGL1x8st9OVmaJaqULXPpFrsiz19VdY1I47UQ0zR
 OPzqPKZ53g+kNYcVM5TaaJMmJOCodqyikkn69o88Ao0EihETLAGqlvl1+DYhOuJjtCdc
 uiC9DpBqIiteMvriXZEuRcZ5ABUGgS7xdlPoaY2IrvF/gGT7lcm4VXWvCCGz+zrT/OZN
 Tqcz/EIVqOVJK4dgHx/e9uQC7E7/d3Hn2v1jqkkEpu3WARLuerwjTQp9TcHkkdPGy9E2
 Xi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731492647; x=1732097447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZnCJ4+6ymcqhIURLlrgRj3oo9xvZ6lElRnwG/wDdvuQ=;
 b=Xsgm1Ad0u/OYvJ7ZJ2V0WvcgrnmAXU14Xi0Xbt6JL+pdatS1mT2Uoj3R0RnnlcJ5Po
 CVt8ZK5VrT9aQiQHrIrC8TBhnjlSKm7fMe/prZsXVyw78Y/h9dI6dFoiCYco4WfvUpn9
 x1VDIdRw6Io6dvIsZ6pxzyzxCRbUxS/8Rpt9mGv+ED8ea9f1Rfu78PBGahdN4FoVbUf0
 xLcUl+MHR6jgVYvAKdBsdLkMANenkv9EheCFQm3hPtnsL1dxcPZNCPZBoViPKRwk8qFi
 syXV2u/wFzCemasEzv5nyvLMCfryEmYH9/LbmUvWO9s4pPLc93mpUqaD2Ycfa2HnDO6k
 d1OA==
X-Gm-Message-State: AOJu0YwGLddauc9NjSa+X8YGyw2qviGXbBrv+sugIKUUyAjaSmUyuyph
 6LlhNQRjqSpdaych9sieg1Y7OeY3GCBwgTkSupXPqDPdsAMJOEtmrUgnT+VzPm0=
X-Google-Smtp-Source: AGHT+IHcjRzKmcQwQO7GHO772d7eKj+tL5M5bSbtckRGBOw/BvOjhtuzOMvjv0xNq3IQignecWgx9g==
X-Received: by 2002:a2e:bd02:0:b0:2f7:5a41:b0b with SMTP id
 38308e7fff4ca-2ff2028aa9dmr150354181fa.26.1731492646539; 
 Wed, 13 Nov 2024 02:10:46 -0800 (PST)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432d550bf33sm19422835e9.31.2024.11.13.02.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 02:10:46 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH v2 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
Date: Wed, 13 Nov 2024 11:10:22 +0100
Message-ID: <20241113101022.2915364-1-admin@hifiphile.com>
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

This patch adds support for determining whether a gpio pin is mapped as
peripheral function.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Changes in v2:
- Rename function
---
 drivers/gpio/at91_gpio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 1409db5dc1..173315d45f 100644
--- a/drivers/gpio/at91_gpio.c
+++ b/drivers/gpio/at91_gpio.c
@@ -220,6 +220,15 @@ static bool at91_get_port_output(struct at91_port *at91_port, int offset)
 	val = readl(&at91_port->osr);
 	return val & mask;
 }
+
+static bool at91_is_port_gpio(struct at91_port *at91_port, int offset)
+{
+	u32 mask, val;
+
+	mask = 1 << offset;
+	val = readl(&at91_port->psr);
+	return !!(val & mask);
+}
 #endif

 static void at91_set_port_input(struct at91_port *at91_port, int offset,
@@ -550,7 +559,9 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
 {
 	struct at91_port_priv *port = dev_get_priv(dev);

-	/* GPIOF_FUNC is not implemented yet */
+	if (!at91_is_port_gpio(port->regs, offset))
+		return GPIOF_FUNC;
+
 	if (at91_get_port_output(port->regs, offset))
 		return GPIOF_OUTPUT;
 	else
--
2.46.2

