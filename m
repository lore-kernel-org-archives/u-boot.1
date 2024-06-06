Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C798C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02E6884B5;
	Thu,  6 Jun 2024 18:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B2/JPV/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF00A881D3; Thu,  6 Jun 2024 16:30:44 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E754F88414
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-354be94c874so768925f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684242; x=1718289042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LiJxSrHUQxU7ezUE98DdkJgahWdu8Tg6y94tQni3u9Y=;
 b=B2/JPV/BFvWLmIGooYPnZeAZ5OxbpXsOITaumbrIA0EuezQOy1XkysmG/1ZDVdsRgD
 UgnHOsbRZLiZVNJv5O+Y/LhD/U8mE7/ssNPR3EMx7W9Y9WCXynNX/tuvc1zsTW667Hik
 7+4J0wVy4G7piJeHXKl97k4TKQfWXKkBqTebqo0Xn0+SpU0MiD14D/Qm0EuUrKP5zv8y
 LslqFboi9LfFHaV2ABtJFnOYjV/RBVNqIqE4IHdXq46LVP2azZYQyVMqFriQO1I9ryzG
 H5zXerp0g5WQtEDqLtih4oypmgGC7thp8BAMFJAjePDYAKJcbNtKAfXLbZHC106xqGMJ
 hdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684242; x=1718289042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiJxSrHUQxU7ezUE98DdkJgahWdu8Tg6y94tQni3u9Y=;
 b=Gfcm0EG0pOF/EDzeXVci/i4AdBeGR8VhhXPoImgMSiteutp3zuQgBoWPaXldnznldx
 RZ5vbPJDsyLFhJ7hVaIWImNbnNEuY9UUxinaja40H4ImqzYqd8Zsrfu2enw/BcVh4l84
 EZg4fC4bH9ZfugkTLXB9azGD9ueXLhhKzowcR+Rf+TbW8tqQ6Xe8aQDbLxNU7lTR2AiV
 AI/rqWkfVXj/AGorsxQy6rEB2B9mYb7a7KnO+Bj9+3cIKgS1KlGk/Z276MfjQzj5GKiq
 +nD99PoO6imDnI7gB/ueMTPzXAzCN3nKocqy37X0n6PtU5RIIimIggAvg7j2gzX9luOX
 Kvmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt9GWqmfsCKVz9HCduS/ZXcobl3h7Fo/lW0piUrGMHxonOQ5V/by8Ha8F3Pm4VwZfiWmWN3wEttKtgSeVdc7HGpVA6NQ==
X-Gm-Message-State: AOJu0YysO96976sMY90ljiQW+3W5kb4TErLKqOu7pX5XASQNSTuyI3GU
 /t7NlCLoZwIK5+l7Y2KfWrZ0o4str2E8wyAK4nQFQlJgCDdK0BiY
X-Google-Smtp-Source: AGHT+IHnffo12hwRkygdK+cMdsRLB7friUAatvD5ssf/WH/rUDgqdW55AoVf+XKPqwr21adqWGZcfg==
X-Received: by 2002:adf:a3c2:0:b0:354:fbb6:1b16 with SMTP id
 ffacd0b85a97d-35e8ef8fecdmr4565191f8f.52.1717684242172; 
 Thu, 06 Jun 2024 07:30:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v2 3/8] led: status_led: add function to toggle a status LED
Date: Thu,  6 Jun 2024 16:29:24 +0200
Message-ID: <20240606143024.20024-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143024.20024-1-ansuelsmth@gmail.com>
References: <20240606143024.20024-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

