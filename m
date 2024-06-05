Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46A0C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571A5884C6;
	Wed,  5 Jun 2024 21:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iI08PEPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8385D88354; Wed,  5 Jun 2024 21:22:03 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBD3882E6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-421555a4454so2268385e9.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615321; x=1718220121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LiJxSrHUQxU7ezUE98DdkJgahWdu8Tg6y94tQni3u9Y=;
 b=iI08PEPSFc7uMoI+sYAkd/WoRG21YWt0yJK773fe37AtUFsgvs3GcSDIxw2UnYQvAP
 2XSH8sa+LKlwFNjF9e41DPcufeenWo7Npq5h726ngRuBrE2gRNLd8PFvsbFBCU+/1PjV
 hZE2AiCT5GKAxwH22/a4vzEarlsTAXkLer2y2xjS6Gs0ddzujE62y8sONqnLyrOcz/D4
 43rl3n7pKQ9G7poiOSMuTll61o8WwEJEIMYBES4u15TZ2+xgwoXrCp8ocb4ceos0RmSi
 t1x30CpyYxzM0b2CyVW8YS2ATWCtvZjnbDi2Tp1qNczyw1OnzJJSGplms4EKxWJ/3UWN
 3zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615321; x=1718220121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiJxSrHUQxU7ezUE98DdkJgahWdu8Tg6y94tQni3u9Y=;
 b=H8lELUy2N06yhoNnKKkh5dcYPZp9+/QGX8rza0F1shq0hVaV2OmLV6T/Rp3XORsyn2
 Yi0QuQYWTh/htzAgwaJ5IW1imYaZh4ZZV2X4WZuNUwIPFJbdPnA0fbxC6cj8jF45qR3C
 7BlWLIepBLK4r7lOzvJy0Km3x/kgZwnIshDF63+Q2yzyztKPxJWQPNluh33wPB1mD2kA
 OSlJ0mAyW6TBzbA8KnaAVeyJnEAm4kOMmJogRtPPdk7Fo6EubySBvovclLJV91uYesUq
 QEelF+fEyImmHle3zVLiZqNhMS50Zi1/42bv1PMSM5D1JGSvGHhePA0FzJOFYbKaSOWH
 DrMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDWcn3VBZypyMbZ4kacTouybWmTtr5KE21doUaEOGeOpI9usL45S7imkE7u88m12zo/65LDS7mPfWK5FVxnXMuOmyxcA==
X-Gm-Message-State: AOJu0Yymt0Xm+9wkDxwtMjqKlznGxwpD09GcdIIKsaBoEiEirmyh2PDu
 lPqAS6XQfbOm1YveyLWrs4EThBboFZs8t2ss2bw8s494mpkbtrqj
X-Google-Smtp-Source: AGHT+IEcIGWepmfZIMz/OWkBKNnKbEV8M208yOqrxXgNuSuoz1JEz0a1XPJDZMKrECQWr+VITpIopQ==
X-Received: by 2002:a05:600c:35ca:b0:421:494c:9e74 with SMTP id
 5b1f17b1804b1-421562f0f7bmr28441515e9.23.1717615321107; 
 Wed, 05 Jun 2024 12:22:01 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:22:00 -0700 (PDT)
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
Subject: [PATCH 3/7] led: status_led: add function to toggle a status LED
Date: Wed,  5 Jun 2024 21:21:35 +0200
Message-ID: <20240605192146.19052-4-ansuelsmth@gmail.com>
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

