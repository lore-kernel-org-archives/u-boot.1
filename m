Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0C6C27C79
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53289887B5;
	Wed, 12 Jun 2024 04:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4OS+aBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F7388757; Wed, 12 Jun 2024 01:14:55 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFADF886B1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so3494880f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147693; x=1718752493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LiJxSrHUQxU7ezUE98DdkJgahWdu8Tg6y94tQni3u9Y=;
 b=W4OS+aBAXoBddeN9e9N1WNZXZ+4Fh4TVN8Ok/B3yyY/htx0c+S/e9ZuSLCw1Kird7F
 hVn6zpTH1Oyvei7hCys4leVAhHNkx+RwArOaE4NCcYgFUKxOSJr0+zPF3ysvc/iJ/rlb
 jf5gxqTB37NMz78pqVIRoTPSrp3DWkEedbnv6AVQpKsnhI2VCs7IVQgtDaerh/1MR7V+
 +N1ZMSeOg5E8NmffdiL2e8ADz6kQj5H3LgBaIpXkBFtz/x52YIu/o5m2CPm1/DZ2iYZp
 4tQIVsXnqBhlPyC0i2el60MQf7Vjn0QgTEETSI3xtb1XwshXADrYYPg7Mv53uu5JNSzy
 w4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147693; x=1718752493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiJxSrHUQxU7ezUE98DdkJgahWdu8Tg6y94tQni3u9Y=;
 b=jjbmhPHY+cRJXcmM8OXwhs1Rxd5VpV5o9Yf/gOc4H5dwScGCpJJ/38Lt9wJJLatvK/
 5abETX4q95ObIDJ/CDQkyHDCxscXcWS8NXoM+OyEbNTuOWlT7V5c4J7FbryFeoVCksoP
 fBPgvdAbwwxd/4BT89qwzldetoM0KWvQxCxqNSWHSX/kgJwN3ZKYgQR0XhKoauyJTe4K
 SE9GL5e6Yvbyq4kP6qc5PjMyMeeQEXWLM/sRzVhjLHI0t7RGxCJUo7WdsBEC9pKLXa/9
 sQyTekPyajAgrQL/DN7bMI3tRKqXUPKgoLIEdULYITBLKrYpZnmxyYDay9ThECV3bgjC
 MAJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOMQ/j0jRT7ACWXpyVqgi9mj2EqRMaOOOBp7cOHHSlZxPB1lJONZ/aJpZ21wV0IIAfKiM4URpIDtbOWEJ5NM/49aGZSg==
X-Gm-Message-State: AOJu0YykLrxr3J1tJvmcHYtiVqbQo6wlFbj3+DaJyMO84WqrWNvnKNJU
 wYNBxXfsdbY7d1t1wBHI3WTB95tmix0P/+LOGCnqB66eno44hCDT
X-Google-Smtp-Source: AGHT+IFKpwmdY7O1phZqj4a/xgSTdWCPGPs2jFdFQTc5jx9GceREIwMo6kfDjqtJ8pCLzhF8j0O8Tg==
X-Received: by 2002:adf:fc88:0:b0:35f:29e6:dbd2 with SMTP id
 ffacd0b85a97d-35fe8926243mr38505f8f.64.1718147693020; 
 Tue, 11 Jun 2024 16:14:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:52 -0700 (PDT)
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
Subject: [PATCH v3 3/9] led: status_led: add function to toggle a status LED
Date: Wed, 12 Jun 2024 01:14:18 +0200
Message-ID: <20240611231435.10366-4-ansuelsmth@gmail.com>
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

Add function to toggle a status LED by using the status LED ID reference
configs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/status_led.c | 28 +++++++++++++++++++++++-----
 include/status_led.h      |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
index a6e9c03a02e..93bfb410662 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -103,17 +103,24 @@ void status_led_tick(ulong timestamp)
 	}
 }
 
-void status_led_set(int led, int state)
+static led_dev_t *status_get_led_dev(int led)
 {
-	led_dev_t *ld;
-
 	if (led < 0 || led >= MAX_LED_DEV)
-		return;
+		return NULL;
 
 	if (!status_led_init_done)
 		status_led_init();
 
-	ld = &led_dev[led];
+	return &led_dev[led];
+}
+
+void status_led_set(int led, int state)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
 
 	ld->state = state;
 	if (state == CONFIG_LED_STATUS_BLINKING) {
@@ -122,3 +129,14 @@ void status_led_set(int led, int state)
 	}
 	__led_set (ld->mask, state);
 }
+
+void status_led_toggle(int led)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
+
+	__led_toggle(ld->mask);
+}
diff --git a/include/status_led.h b/include/status_led.h
index 5ce4522b029..fe0c84fb4b4 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -38,6 +38,7 @@
 void status_led_init(void);
 void status_led_tick(unsigned long timestamp);
 void status_led_set(int led, int state);
+void status_led_toggle(int led);
 
 /*****  MVS v1  **********************************************************/
 #if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
-- 
2.43.0

