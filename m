Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CA6C27C78
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4818878B;
	Wed, 12 Jun 2024 04:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YfCJWoOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A67388757; Wed, 12 Jun 2024 01:14:55 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8809388758
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f223e7691so197697f8f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147692; x=1718752492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=USHF67Hvkkr6X6WZ90mIvVSk959Bhec2gU9xl0MKgOk=;
 b=YfCJWoOcIPJhhVI2yvCxDYnUsxgQMx2OhVHO65dd4gptmh1e5tzEaCWrOKxkajMyqR
 qEIs9KBZsNHFQqEzBNsWZgMDIhemlxdUqO6ZoXheMgqqwbOFYfNxIT7mGnFwwDwWGke1
 WUnVk8YBwWha1eYEyQfSruRDkistfyNgNXWpeJLKGmCGPu+3OhZSU4AaQlOrtx4cq/gd
 OuFrGQ9nV+BpMuGnpuMV0xs6XlW1JOWSvCLVcfq7YVLRcEvgHeHbpJjGSGbb/GTlg4U0
 Cz3s7gwqzOa4vxYKGAdlnwvILnxQ2EBfJmMyKutkov9Ix6gTJrvbpMCGX+LfCQznqqP7
 Jt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147692; x=1718752492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USHF67Hvkkr6X6WZ90mIvVSk959Bhec2gU9xl0MKgOk=;
 b=NfNXXJBWTZ3fignYWk/xPCYwqFN5/Sl5ikgq90K3rI/bId+thJ/wZLks22rcUkvgNL
 fOf0Xe21UHNCjrhQa5O2GpBJbptRWRSB/quc4TFr2VFycl6MA+TMgx07THG+BhnNbHO8
 P+X1C0/9O9+1rRzDNusxDu/xeeJa8eMQl3VDuYUmtqlxe2T81dBpi6YflkKSCu6hwsPQ
 Y9G13lrRhhcgmHFflcZMVH7KC10CXNN2+UVhyc9BmKutUJeSwowrFIV11OLhmKrReSKE
 mCEVLh1iy7cH8M64ZzRIjhEdQVC5I0ok4DRfzos+TdQK/UXPklrsrvxTo6e2RYgEmJ1r
 LhTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7eekzTLtpiqJjinnavQruEbv3nhcIT8h1kOA28zrpwkCPfNaRWKuW1bmhGusgzflMTqhzwRjhkxjW3+/OWgFQ+bvUtw==
X-Gm-Message-State: AOJu0YyAgzmqtLr4noK79HtdKTKYCMR95JlU2J/g18XYKQfJpE/yNJVe
 XuRngAg/VgjNLYjjO1BLzDc1rd0omHeRes45KLcf9vue18kfvT8f
X-Google-Smtp-Source: AGHT+IHc9IF2WJBnurqpChq8+IM1FQkiGO00sjPjl1C1CGrQwsn4iM6y0j4uUlOxKtbbYC9N0b022g==
X-Received: by 2002:a05:6000:1801:b0:35f:1da1:c077 with SMTP id
 ffacd0b85a97d-35f5a9bcb9dmr257486f8f.5.1718147691806; 
 Tue, 11 Jun 2024 16:14:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 2/9] led: status_led: add support for white LED colour
Date: Wed, 12 Jun 2024 01:14:17 +0200
Message-ID: <20240611231435.10366-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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

Add support for white LED colour present on many devices.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/legacy_led.c        |  6 ++++++
 common/board_f.c        |  2 ++
 drivers/led/Kconfig     | 14 ++++++++++++++
 drivers/misc/gpio_led.c | 12 ++++++++++++
 include/status_led.h    |  4 ++++
 5 files changed, 38 insertions(+)

diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 5256255f052..40dbc05a651 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -57,6 +57,9 @@ static const led_tbl_t led_commands[] = {
 #endif
 #ifdef CONFIG_LED_STATUS_BLUE
 	{ "blue", CONFIG_LED_STATUS_BLUE, blue_led_off, blue_led_on, NULL },
+#endif
+#ifdef CONFIG_LED_STATUS_WHITE
+	{ "white", CONFIG_LED_STATUS_WHITE, white_led_off, white_led_on, NULL },
 #endif
 	{ NULL, 0, NULL, NULL, NULL }
 };
@@ -180,6 +183,9 @@ U_BOOT_CMD(
 #endif
 #ifdef CONFIG_LED_STATUS_BLUE
 	"blue|"
+#endif
+#ifdef CONFIG_LED_STATUS_WHITE
+	"white|"
 #endif
 	"all] [on|off|toggle|blink] [blink-freq in ms]",
 	"[led_name] [on|off|toggle|blink] sets or clears led(s)"
diff --git a/common/board_f.c b/common/board_f.c
index 039d6d712d0..54e2009339e 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -72,6 +72,8 @@ __weak void yellow_led_on(void) {}
 __weak void yellow_led_off(void) {}
 __weak void blue_led_on(void) {}
 __weak void blue_led_off(void) {}
+__weak void white_led_on(void) {}
+__weak void white_led_off(void) {}
 
 /*
  * Why is gd allocated a register? Prior to reloc it might be better to
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..6c4f02d71f2 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -415,6 +415,20 @@ config LED_STATUS_GREEN
 
 endif # LED_STATUS_GREEN_ENABLE
 
+config LED_STATUS_WHITE_ENABLE
+	bool "Enable white LED"
+	help
+	  Enable white status LED.
+
+if LED_STATUS_WHITE_ENABLE
+
+config LED_STATUS_WHITE
+	int "White LED identification"
+	help
+	  Valid enabled LED device number (0-5).
+
+endif # LED_STATUS_WHITE_ENABLE
+
 config LED_STATUS_CMD
 	bool "Enable status LED commands"
 
diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
index 0f3682e1465..de84c206b6b 100644
--- a/drivers/misc/gpio_led.c
+++ b/drivers/misc/gpio_led.c
@@ -112,3 +112,15 @@ void blue_led_off(void)
 	__led_set(GPIO_BIT(CONFIG_LED_STATUS_BLUE), CONFIG_LED_STATUS_OFF);
 }
 #endif
+
+#ifdef CONFIG_LED_STATUS_WHITE
+void white_led_on(void)
+{
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_WHITE), CONFIG_LED_STATUS_ON);
+}
+
+void white_led_off(void)
+{
+	__led_set(GPIO_BIT(CONFIG_LED_STATUS_WHITE), CONFIG_LED_STATUS_OFF);
+}
+#endif
diff --git a/include/status_led.h b/include/status_led.h
index 6707ab1d29d..5ce4522b029 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -87,6 +87,8 @@ void yellow_led_on(void);
 void yellow_led_off(void);
 void blue_led_on(void);
 void blue_led_off(void);
+void white_led_on(void);
+void white_led_off(void);
 #else
 	.extern LED_init
 	.extern red_led_on
@@ -97,6 +99,8 @@ void blue_led_off(void);
 	.extern green_led_off
 	.extern blue_led_on
 	.extern blue_led_off
+	.extern white_led_on
+	.extern white_led_off
 #endif
 
 #endif	/* _STATUS_LED_H_	*/
-- 
2.43.0

