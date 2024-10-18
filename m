Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E07D3C547
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 04:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1C588EF7;
	Sat, 19 Oct 2024 06:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="lvBHpmJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DDE88BB2; Fri, 18 Oct 2024 23:58:19 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFB088BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 23:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so22560765e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1729288697; x=1729893497;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4yl7rg5f4hMNSQsfTUJEi8FrJLdjkHIaKf5O9eVjYq4=;
 b=lvBHpmJOtmhRwTmeSJoDPSuLf/JiC6qlj/fkwd+7lgFMhjuLU4hD8d41jodWjFKyg3
 Ho2d6sC6TTtEG2cO9tyLq3syNSGXV5R846Vj6cDU8L8urVIXy/qViKrQ+Y0ScnylaKWQ
 iI6k35onr8Q7EEDwHd97jZbbz8sj5dFXff830xMEDz6XFUx3iYBikFgZaO7ns6OnJmLq
 CgxyKVRNofpOa2ds2oGIyun791HuOb7dMIPkIAIHUnTy3LryK8hOrGe1P0uHwa/xA5cN
 U1HihQRA88+t+SndZ2rAeTHJAfYsJiHtoWC0vQ+1K21IICe6koW6RnGEcWeonVb1p6RD
 LGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729288697; x=1729893497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4yl7rg5f4hMNSQsfTUJEi8FrJLdjkHIaKf5O9eVjYq4=;
 b=WbEeMJcuFmpK3sfm1hpKELMd/9QH3Kh729s2ck7lYXLa/713bmUYMqWMHqj89pbTQ2
 nw2tSCut7g+Ndnq8tGsoUZ5iyQe8mbrAu15axRMVS659TcNbI4FdOvrdXVsZVnOI3+Ce
 ZWjkLYeH9u+yOhks9KwYLP6FMNEjcBTQU7Q2KRDMrfLrDOc/pHM17K+CC6eUt5Qm2Gxl
 VVs+zJSZoPcIxE9Z5kiIVIKHAwVtXtSWQWHjhptn3bOyJfgNSWhv4Vmorz9UHJc8iLW5
 vmOM6oTgLDIQ0adhmyI29EDVkv45gPj2perZMxMb1NycGheHY0uzftm3dmRIRcilcjzp
 30ng==
X-Gm-Message-State: AOJu0YyTNpe9nnvQhzkvUrOiO2Csw76wiKDLcmhYWRmttwgfFF9bFxvR
 1M10Wso9ZK8oIbZEGILn47gZvFvVEu+zXLRp7sDpvzFI6X6HXnfx3IOflPQ3OQA=
X-Google-Smtp-Source: AGHT+IHuy7s2abMxvxXGVKsCrddEBzmFL8Ku+q2g8PWDsMFz88z/dc3REm5mGlm0ys4K0e/zqHRZJw==
X-Received: by 2002:a05:600c:34d4:b0:431:588a:44a2 with SMTP id
 5b1f17b1804b1-43161636685mr30540545e9.12.1729288696637; 
 Fri, 18 Oct 2024 14:58:16 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43160e443a4sm33841795e9.37.2024.10.18.14.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 14:58:16 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH v2 3/3] gpio: at91: Implement ops get_flags
Date: Fri, 18 Oct 2024 23:57:51 +0200
Message-ID: <20241018215751.322145-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Oct 2024 06:39:29 +0200
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
---
 drivers/gpio/at91_gpio.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 7828f9b447..c44e02cd90 100644
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
+	return !(val & mask);
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

