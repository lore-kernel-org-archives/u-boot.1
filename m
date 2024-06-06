Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D3C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38004884C0;
	Thu,  6 Jun 2024 18:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUEMxiJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE2988423; Thu,  6 Jun 2024 16:30:46 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E95787D9B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35dce610207so1167462f8f.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684243; x=1718289043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RUt1XdB6mSawd1Ij7o9mOYvIaDuwwQy604vSSdO7Xo0=;
 b=jUEMxiJlFaE55p9TBsuglv6WHdpKeclp3BbxJuWI2t2vtfp5EMu/eDOxAt7GIH8ec0
 HrNapn6pJP732Cl0j+RcY+nEHMIbw5nLwCV75b3vcMehXzK2ABqEY5xOqcZDTN/TpPm9
 muZZPbGeOaBnFlDTfCeresFm1XVJdoYackJT8tQR1a4LOHKE5IiVWU+p1Q63qeb6jN7U
 36W9ZZhpww5EhhdBP/jg3eTDdx35gD+S/MLgXpkE6jmoJdiopDUXb+cKb08cHW77hUX1
 WX4n4UrwP+Kw1tf/uTHukIQlWTFFc4AE2TZsdDz3IuNKTr6lX0iGT8yqaB5F1Q0SUNcc
 ALrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684243; x=1718289043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUt1XdB6mSawd1Ij7o9mOYvIaDuwwQy604vSSdO7Xo0=;
 b=UfRZH+bWnA1UeJzbYKMrJIve6cVrWr2hLAgcgr06dAx3t2tgd8+s0pPOCBN1PiBJkW
 S8KCy+FOItxGkOAZA2NmZ9y1A2AyHO8rcIe16cSCi/auOD02P7HfFsl3DOLB22WjQ6gI
 ek19ezTWFu0aKqTLVjcGNb2UyoQFbalpUk6DxctYLUD2x4VVG7VYDO8p3alB4d9HTFW1
 9iYWVOpUnVne8faclqDXwilfvH9x4r2g/PCcIaic/mJDDm874zwEW0HEukFARY+yoepx
 x3mZIPul3g1RDNETqTB5dFPpUejalHV37fFlphIc4kBPCM0wcMgJQiq0J/iH+ruzMQdJ
 d8vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4jq8TPC/f2h3M0iJw4rAby9oj8R2b6hUcK9JaPzBD/G1jeGjBr/ZKC4F9xEIt853bFStZ47345mn/dlvmueR42w51kg==
X-Gm-Message-State: AOJu0YyI2P7jRYhk+ykElhBB1XjBUPtDmXXxzhccck/73cDe4sxW1CI3
 Kxsy2e+TVD9PkFkzJbeTlRu5oLzxgjw8BrhhEEkWMLbSabkOZrBY
X-Google-Smtp-Source: AGHT+IFK2UaBwxr8Ii2+/Wx/mXlIGaAUbYG2vZ12VMA4GtnMONuF0pmTmTSZhtCAutxaJj3ut73Qmg==
X-Received: by 2002:a5d:4e87:0:b0:354:e0f0:2943 with SMTP id
 ffacd0b85a97d-35e8ef2c428mr5166159f8f.37.1717684243555; 
 Thu, 06 Jun 2024 07:30:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:43 -0700 (PDT)
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
Subject: [PATCH v2 4/8] led: status_led: add new activity LED config and
 functions
Date: Thu,  6 Jun 2024 16:29:25 +0200
Message-ID: <20240606143024.20024-5-ansuelsmth@gmail.com>
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

Add a new activity LED config and additional functions to implement a
simple software blink feature to signal activity of any kind.

Usual activity might be a file transfer with TFTP, a flash write...

User of this API will call status_led_activity_start/stop() on each
activity and LED will be toggled based on the defined FREQ config value.

With this enabled, cyclic API are also enabled as this makes use of
cyclic API to handle LED blink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig       | 16 +++++++++++++++
 drivers/misc/status_led.c | 41 +++++++++++++++++++++++++++++++++++++++
 include/status_led.h      |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 6c4f02d71f2..869ed78e87f 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -359,6 +359,22 @@ config LED_STATUS_BOOT
 
 endif # LED_STATUS_BOOT_ENABLE
 
+config LED_STATUS_ACTIVITY_ENABLE
+	bool "Enable BOOT LED"
+	select CYCLIC
+	help
+	  Enable to turn an LED on when the board is doing some
+	  activity (flash write, file download).
+
+if LED_STATUS_ACTIVITY_ENABLE
+
+config LED_STATUS_ACTIVITY
+	int "LED to light when the board is doing some activity"
+	help
+	  Valid enabled LED device number.
+
+endif # LED_STATUS_ACTIVITY_ENABLE
+
 config LED_STATUS_RED_ENABLE
 	bool "Enable red LED"
 	help
diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
index 93bfb410662..5ee68c7c77d 100644
--- a/drivers/misc/status_led.c
+++ b/drivers/misc/status_led.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cyclic.h>
 #include <status_led.h>
 
 /*
@@ -23,6 +24,7 @@ typedef struct {
 	int state;
 	int period;
 	int cnt;
+	struct cyclic_info *cyclic;
 } led_dev_t;
 
 led_dev_t led_dev[] = {
@@ -140,3 +142,42 @@ void status_led_toggle(int led)
 
 	__led_toggle(ld->mask);
 }
+
+static void status_led_activity_toggle(void *ctx)
+{
+	__led_toggle(*(led_id_t *)ctx);
+}
+
+void status_led_activity_start(int led)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
+
+	if (ld->cyclic) {
+		printf("Cyclic for activity status LED already registered. THIS IS AN ERROR.\n");
+		cyclic_unregister(ld->cyclic);
+	}
+
+	status_led_set(led, CONFIG_LED_STATUS_BLINKING);
+
+	ld->cyclic = cyclic_register(status_led_activity_toggle,
+				     ld->period * 500, "activity", &ld->mask);
+	if (!ld->cyclic)
+		printf("Registering of cyclic function for activity status LED failed\n");
+}
+
+void status_led_activity_stop(int led)
+{
+	led_dev_t *ld;
+
+	ld = status_get_led_dev(led);
+	if (!ld)
+		return;
+
+	cyclic_unregister(ld->cyclic);
+	ld->cyclic = NULL
+	status_led_set(led, CONFIG_LED_STATUS_OFF);
+}
diff --git a/include/status_led.h b/include/status_led.h
index fe0c84fb4b4..7de40551621 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -39,6 +39,8 @@ void status_led_init(void);
 void status_led_tick(unsigned long timestamp);
 void status_led_set(int led, int state);
 void status_led_toggle(int led);
+void status_led_activity_start(int led);
+void status_led_activity_stop(int led);
 
 /*****  MVS v1  **********************************************************/
 #if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
-- 
2.43.0

