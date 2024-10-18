Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E630DD3F29B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2935A88D5B;
	Fri, 18 Oct 2024 22:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="NLOYkJ4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F6388DA0; Fri, 18 Oct 2024 22:27:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8390A88B23
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso23897665e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1729283242; x=1729888042;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WluH7AQOLiL0GTH5xHlsLlNpMla8/qfLrtkMEUXGkcQ=;
 b=NLOYkJ4Fn5q8m0AqpoPZaNmTNxVSlSmeIEcqvUqHgXLs9Pe1B0snqP9mckZa0dsizP
 X9Xp70aUpzX0Qs3OGvlZE9QiGwlcTBy4JETg9C+vk7NgMmftLZAQWeLBV3L7PXhs375A
 vNlfv8mJJjJxzbz/G6L00TMTuOMrWW7z7m8A8NUhB9Et+ZXlfFlZbwSHa2jXnxTW2iWx
 3IQI6HQ560wFrdoXKta/wEBrtYPdt6sk43iPeJm4/pQ9eVJDqscyU0h1FxzXW7dbf+RU
 IuIok6PvnijC+sree1DQXgEhIBxcbiyis9NCA1+7eRyUYmKZ930mgAOu9Pep5bQgAf6Q
 6DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729283242; x=1729888042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WluH7AQOLiL0GTH5xHlsLlNpMla8/qfLrtkMEUXGkcQ=;
 b=T2DOeHFzmqwsPmnRMk+Si5BnuDIny3pKD809hMFMNryz7KWyQhLC831M/xZZP++A9M
 21Le31nrAS2s7rluoIGPoeg1eIUZ/5sU6//PPo65+VYCf+e9Wt0k1QrXQ6gtNcraIxcH
 2piALnz2SuvkOwnZYegq3t/ZmGWduBIQx50ijFZClvN5v/85RSPcKLAg0UjvSkllPkaU
 LcPHCQbGTUvp9FyLba+Y3Ptpai00Qrz/xcCV6ZnSH5+wP8/Yf6UdURvuVC6NBax+DYjs
 kgDd3DSBmrnLj+uerUwv+tfMUv8zJzzHq68ZcmuyI4ExRjyoncvSET+ETZhMRg0uicuj
 uxqA==
X-Gm-Message-State: AOJu0YzK0bKSSoKKL/Iry1lF+20wDBxb+J25dlFWnJjU3drH+uU9MIzA
 1CHsj+7ErAR29nSmifE7N1bUZqY78esMe6PbIvFrDh/iPCfWkDNApDBisBLkIMg=
X-Google-Smtp-Source: AGHT+IGvq+n7Z7qISUnOkllfD+7UpfdyWtTcc9x97wlNX5/5QMHr034eQTsK4jpBcVFm5RuTJNCWkA==
X-Received: by 2002:a05:600c:3d9b:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-431616ad787mr28883095e9.30.1729283241740; 
 Fri, 18 Oct 2024 13:27:21 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm35810395e9.10.2024.10.18.13.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 13:27:21 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Zixun LI <admin@hifiphile.com>
Subject: [PATCH 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
Date: Fri, 18 Oct 2024 22:27:13 +0200
Message-ID: <20241018202715.283011-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.46.2
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

This patch adds support for determining whether a gpio pin is mapped as
peripheral function.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/gpio/at91_gpio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 1409db5dc1..64a6e8a4a5 100644
--- a/drivers/gpio/at91_gpio.c
+++ b/drivers/gpio/at91_gpio.c
@@ -220,6 +220,15 @@ static bool at91_get_port_output(struct at91_port *at91_port, int offset)
 	val = readl(&at91_port->osr);
 	return val & mask;
 }
+
+static bool at91_get_port_pio(struct at91_port *at91_port, int offset)
+{
+	u32 mask, val;
+
+	mask = 1 << offset;
+	val = readl(&at91_port->psr);
+	return val & mask;
+}
 #endif
 
 static void at91_set_port_input(struct at91_port *at91_port, int offset,
@@ -550,7 +559,9 @@ static int at91_gpio_get_function(struct udevice *dev, unsigned offset)
 {
 	struct at91_port_priv *port = dev_get_priv(dev);
 
-	/* GPIOF_FUNC is not implemented yet */
+	if (!at91_get_port_pio(port->regs, offset))
+		return GPIOF_FUNC;
+
 	if (at91_get_port_output(port->regs, offset))
 		return GPIOF_OUTPUT;
 	else
-- 
2.46.2

