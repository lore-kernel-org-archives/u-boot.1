Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C2DC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2023588C29;
	Wed,  7 Aug 2024 21:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXFgxapE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E1A88BF9; Wed,  7 Aug 2024 21:54:28 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72DB88BF9
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so1620205e9.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060466; x=1723665266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FZwEhbDpC3QRsL4OcntQ5ExiSIPebNKwOaMYQduXGxg=;
 b=kXFgxapEshltzGYgmlvNkp8n+ECn7hjnVq7xR4I4T1tkD+P6mZiSZk7eZZBJujRMh4
 qfcrFZrQF0DFLoXpDlstAD0HxWijSpi8eYjn6hQ4R8I5SgEAOg32PWjGwZnBWkiJXOtr
 RB8s7LgHEPeNDE/AOsMcZKB701k540FAfeROfyGutgd2I3tPz4IpcgSgfIKBT4kY0WPT
 JtHN96F/7X8b/H1d4yhLrfoupTdh+4RfqD6LNosUFmfPgoMvgWn5W9lob6kQjF9uOgDM
 K6N2RmsMaUuZUTVFW1VwdH5DsifyowK9AYVc5b6qbqsJ329YPgrLRo7T1BIpMc6LecLu
 Wf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060466; x=1723665266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZwEhbDpC3QRsL4OcntQ5ExiSIPebNKwOaMYQduXGxg=;
 b=fysRlkajmWy5v7fkFJtkBLPm2CXE+drFVraZix9CjFRFynq09ALq7hk2BLlJUxQlJr
 VfoaKI5X1WQawq3EDScTwvmd/J1DWXOoaLPRqLSSEuHhe4a40LifyFZINbczRHJCx+jN
 iAkU6xlyWNmzwjuu1Piok3fOHAzx4stkoOLxYqEZDv5gp/pCM8x6xsXCllTvjK5Xgdvt
 JtdpwQ3UwT7L8xaWruSm8j5+w+bE4UkfQvpDofd2mA1wheN3q//RW01g8l7klkxa7HHM
 G+Gpe4CzwquUrh1PCsYE0g25POWZv72g6r2DCahlfELMWErpnOcLEL6HwTDy2ir7R0lK
 8LDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX54JsUYYyp0o5bucNQZi5fO+HcDkF2XwgZKFq5ZQ7Htcvm+VJ0seDcyfYssiR2xKcHV/gm9Ujm+GeyzHyk9uzQnitsMw==
X-Gm-Message-State: AOJu0Yycgfwp07zJTO/69+Gfudu6FeMTaxih9qh3g2Z5TP+BunVBIq9e
 FIDQRUSMpZU/9NB+C3NuCvxY5IE1+37WozAu12EIwtdGlc6N2TJb
X-Google-Smtp-Source: AGHT+IEOY6iOgDzabyO6wcqyyKi0d4lYbp7OxP4pFzrlARLT2i/yKjfhK+2foK9W/1I6xf1Oq+e8HA==
X-Received: by 2002:a05:600c:4449:b0:426:6618:146a with SMTP id
 5b1f17b1804b1-428e6af1afcmr134945775e9.2.1723060465615; 
 Wed, 07 Aug 2024 12:54:25 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/9] led: implement led_set_state/period_by_label
Date: Wed,  7 Aug 2024 21:54:05 +0200
Message-ID: <20240807195413.30456-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807195413.30456-1-ansuelsmth@gmail.com>
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Introduce new API led_set_state/period_by label as a shorthand to set
LED state and LED blink period by referencing them by label.

This is needed for the upcoming additional API that will declare LED in
.confg and reference them by their LED label name.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/led-uclass.c | 28 ++++++++++++++++++++++++++++
 include/led.h            | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 199d68bc25a..b2b96d7d48b 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -65,6 +65,20 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
 	return ops->set_state(dev, state);
 }
 
+int led_set_state_by_label(const char *label, enum led_state_t state)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = led_get_by_label(label, &dev);
+	if (ret) {
+		printf("Failed to get LED by label %s\n", label);
+		return ret;
+	}
+
+	return led_set_state(dev, state);
+}
+
 enum led_state_t led_get_state(struct udevice *dev)
 {
 	struct led_ops *ops = led_get_ops(dev);
@@ -94,6 +108,20 @@ int led_set_period(struct udevice *dev, int period_ms)
 	return -ENOSYS;
 }
 
+int led_set_period_by_label(const char *label, int period_ms)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = led_get_by_label(label, &dev);
+	if (ret) {
+		printf("Failed to get LED by label %s\n", label);
+		return ret;
+	}
+
+	return led_set_period(dev, period_ms);
+}
+
 static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
diff --git a/include/led.h b/include/led.h
index 99f93c5ef86..c1f3380f253 100644
--- a/include/led.h
+++ b/include/led.h
@@ -111,6 +111,15 @@ int led_get_by_label(const char *label, struct udevice **devp);
  */
 int led_set_state(struct udevice *dev, enum led_state_t state);
 
+/**
+ * led_set_state_by_label - set the state of an LED referenced by Label
+ *
+ * @label:	LED label
+ * @state:	LED state to set
+ * Return: 0 if OK, -ve on error
+ */
+int led_set_state_by_label(const char *label, enum led_state_t state);
+
 /**
  * led_get_state() - get the state of an LED
  *
@@ -128,6 +137,15 @@ enum led_state_t led_get_state(struct udevice *dev);
  */
 int led_set_period(struct udevice *dev, int period_ms);
 
+/**
+ * led_set_period_by_label - set the blink period of an LED referenced by Label
+ *
+ * @label:	LED label
+ * @period_ms:	LED blink period in milliseconds
+ * Return: 0 if OK, -ve on error
+ */
+int led_set_period_by_label(const char *label, int period_ms);
+
 /**
  * led_bind_generic() - bind children of parent to given driver
  *
-- 
2.45.2

