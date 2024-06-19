Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE9C27C53
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE459884F1;
	Thu, 20 Jun 2024 03:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="faFbuv2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4B8884B8; Thu, 20 Jun 2024 01:04:13 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA518846D
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4217990f8baso3461565e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718838251; x=1719443051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dL7hFHFmLjFbpbq57GZZpdbS1HS+ABxAkllXt+gP4F8=;
 b=faFbuv2Vgde2+O8jd0i5MPtn9Mg4xI+xCgraC08x9S1J72yNbBunW9bY9VB4/TPojY
 SIk+hYmZrQoeuN5fY1tsSTGr46HIFHJfa2RGNRcXazI5AxiAkWGJ9VQBescdGOQuSUUb
 0Hk5V9FV7GDUjX6wT9k9U00gjXLHeYh/qCIY0S28j4L1nCN+qqiXmzs5RTpQpmi4mjeP
 9WdKnCi3GZfdLgSQXVdyAAU0yQ12vQcH7zSX1d3JNWeCsHNefIG1i2HB3nu4xw1egfAk
 ELqh9y+w7oIYDPe0l9ob9kQhBbxqjU0MDO53j5TV4Kr84RSoaNE+Ye9/WglASRfsaHhZ
 yYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718838251; x=1719443051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dL7hFHFmLjFbpbq57GZZpdbS1HS+ABxAkllXt+gP4F8=;
 b=NxjoFNl6xpuma6F+5EwdB7DXSxJhGhG6Pxfr9IcPxBWtbuT4nztLSrybJvQ+EG7UZN
 qNCLYviv1mhriIdrR37ETGzS2fXNkpOsTdrZHBCh86HMmov7HXt8TLDVGSk/ttoSXveN
 pEL1gXBmChYVYrOFzqbqTGS+hi3Y+ojlvz5LdwpkdZiO9rRkBbhKBB3AdN1xymNctSq3
 C2NWiq7IyBKrrDeuI6vdgV4OtbW/54kP+B2cmZLV1E2DXrC7LYAjg/b1M6T7EBcJNBZc
 OBF4xwxXIMMvhbZCUbh/FHEwXPrBMlEnKQC4k9KSIuRA4Z6E6hDcekUi0O4581F936T0
 QneQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsu8dhfRRAh6CJhb5oIRxatAUD1ysDuRMNbk++GCAoNNl5k3HQPeJW5n9RuI8eIsmLRyrT1vH2buARquZQTFL+wfMndg==
X-Gm-Message-State: AOJu0Yws/kQ2NJO8JXF7dOA7DLPYcsyJo2RjQ2E/VViLC3jmRfxSc5xc
 rIBrlC6EkNZ2X7kWeDWf+yu5OSft3x9s3NfaW2UNVmrr3AKNdvKa
X-Google-Smtp-Source: AGHT+IHeRtvCq5fwE5x9wHLjxjiRyJmWq+wRYnFK4plyTrHhfiR5ptqEpq//yvrpRlbWN1PF9AFtdg==
X-Received: by 2002:a05:600c:1d08:b0:422:4fcd:d4b3 with SMTP id
 5b1f17b1804b1-4247529f03cmr24800325e9.37.1718838251053; 
 Wed, 19 Jun 2024 16:04:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm5410465e9.27.2024.06.19.16.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 16:04:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v4 3/9] led: status_led: add function to toggle a status LED
Date: Thu, 20 Jun 2024 01:03:21 +0200
Message-ID: <20240619230400.8459-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Jun 2024 03:31:55 +0200
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
index 3b1baa4f840..2b904bfa9c2 100644
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

