Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DACC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02430884BE;
	Wed,  5 Jun 2024 21:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z/++txgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167718831D; Wed,  5 Jun 2024 21:22:02 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D2F87AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421555a4454so2268095e9.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615319; x=1718220119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=USHF67Hvkkr6X6WZ90mIvVSk959Bhec2gU9xl0MKgOk=;
 b=Z/++txgCngDR0da7G+Mp5xfsUUteD4Y2xoOKqr2CwFMt5X3NDraDHZMwWmq+c+pKmV
 XJDMiQul/BmajE/KyXoUTJyuYmTd99i3i2e1o6G+qCzW4q+ToBjyHRaViW0LGKioSnLd
 P10JTpRgudPIttXzGfIqB76N+nzncm8jDQ9HXfVLKic5N3+j7uILd4AeT0MHLzAFT2lt
 BhEmJHRFtNVhee/eAfXtKTHzPPHeiiVOCAfR1rnAKrp01y3jf2bM2gDXWqwlrSPEw9+R
 ivq79JmTjkzRRCqTFWvhzcjneKeleoRk6T+L5gnC8fCNP6c9ujoRJsaTlaOmQzLgPKo9
 DvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615319; x=1718220119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USHF67Hvkkr6X6WZ90mIvVSk959Bhec2gU9xl0MKgOk=;
 b=gKlO611XRyD3/ThFyzm9aIVQZsnL4w/aophWX9C/W/SAC3Z3Ie3KLWin3k8rrU6U2z
 drKUcGOI7yOmrVlyxEylLG/sMuxMlxkMfDLPDqmyTXyfoAbwpVjMS4eLinrJLOQn48Uu
 4rEsdj14hwZeFGpC6pjrdFs5l2/REeIZjQ5xnxqumJnerJnMPPkWRcq84AKiGQJSlPe8
 V+7DohcKhd3GDzNTrEdHLOt+zL+y3B6oMD7dVkMWfZdDhH8bTXP1SyitEE/SugQUH1EU
 6qCcZ6Kr+Qm1nYn4vMMknXLSzW7hQBW6IProgO03GwUId31bEI9Shei9Ttjr7hSfGnnu
 SguQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNkzV0dRgVp0v3F5+3eb+Gmc0mGXWQFpI+WbtoYcKIuUdymwwVx5nAdJzVHzz6ZldMOQBWuD+8L3/Bs/zwDK2qVTK5ow==
X-Gm-Message-State: AOJu0Yz236UpXP9ehxHe5hZXkB7d1srHvVC6LLCF5B8DB/FjMZuDL4xe
 RJSB3UmMO5qRk3g2XBYPp4pH5icAD38Iu12N9hRkVj4PTK/ct5DS
X-Google-Smtp-Source: AGHT+IHZ0wYpyHUSXQ8ZIXozoCjCIJNrBDTdg9RKNpUSV5pazuk4h51GXpcdi5R8IdtM6JRcIn2Jag==
X-Received: by 2002:a05:600c:45c8:b0:41c:2931:e670 with SMTP id
 5b1f17b1804b1-421562d4717mr28226085e9.2.1717615319498; 
 Wed, 05 Jun 2024 12:21:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:21:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 2/7] led: status_led: add support for white LED colour
Date: Wed,  5 Jun 2024 21:21:34 +0200
Message-ID: <20240605192146.19052-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

