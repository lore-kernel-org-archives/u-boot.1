Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC9CC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346E2887E4;
	Mon, 12 Aug 2024 12:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+fd1N8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F212488755; Mon, 12 Aug 2024 12:33:06 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E4787D6B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-429d2d7be1eso2032795e9.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458784; x=1724063584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FZwEhbDpC3QRsL4OcntQ5ExiSIPebNKwOaMYQduXGxg=;
 b=S+fd1N8saHEGaELbFlK1SnhhKTQX44k5Va5RbIAvNFOAA2hKnPh95dIZitZDAdZJds
 b3Oij7/zv9FLEY0vSEr0bJ/ygpEmIUH5wskk6RfiWhpAruw+QQKe5bqI23h24T981aJc
 tWLTO21XtcUi4oZehrkFe27AoATqY/YFAe9CPQuVOhwu9lkFbcNfG93kBqSA+TbtCXlZ
 XHuEB9yBZ5kqRFR0RCvU3m+6uhPpwLmb7Ih1zrSwy/LeKObv3LKl2zLuORS+vIuPf6EJ
 5KtwKhjDMIwX0bm8+yxdFubRARcIbIbH9pIcHO4tGm87ITP2NCaxOFYcO3rxv1G8qFOg
 l4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458784; x=1724063584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZwEhbDpC3QRsL4OcntQ5ExiSIPebNKwOaMYQduXGxg=;
 b=PK0Ghqy+uyNsaQ8jATQhKJk1MBqUFGWtH7jWISm6PWQF4Kwix9d+ixQ9q6oF1Wt9u9
 0jw81jo4dvBCE+DJ58cYopXZiXmiRQ8V/XLBf8GNb0/ZXeUJEX17g7txVkRg3QmWgtz+
 xNjH6tjNWnOb/5AK+bLfnjUvVGrXhURD1ycXvwEU1w/175rfL4WUKA+0QOQpa/oqO6bm
 gmKDGXoG1aDlBO27fxOrG/l5a+rsP/Vhv6ofgRYIA0DkPUhChv3TBirUrOtpJ8s6eXNC
 blcg0Kykz9dGLopzZ5CHuTGYc6Kn37GJZ0DUYBAt+gbFeQ4MFHBMMeSZeKRCUKx+on63
 VPRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs8NSfumc6CbkDLMenDDs3agYVw9EH33FZO16JLPmfFHwFD9vdkHGEnvZFEMH2Dz94UvS2kDi1iBavERkvusdTa5n1ng==
X-Gm-Message-State: AOJu0YzyG2+EB7vAX+0gqqWKIi3mFcF+SCaSChWBaxY8/PogfuQW+P2f
 7aejNdk+/bzq8ZdwbNf+eDFCV/2RsXx+xHEDX58XHMyxPygmiNMo
X-Google-Smtp-Source: AGHT+IGuowygy2zLp2ELmjnsaQfN03VuGBXWcU4jJY7own0BVbYWBaWmo0I54m2npP7ECSX9YUZOKA==
X-Received: by 2002:a05:600c:358c:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-429c3abd9a7mr76533005e9.4.1723458784046; 
 Mon, 12 Aug 2024 03:33:04 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:03 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 2/9] led: implement led_set_state/period_by_label
Date: Mon, 12 Aug 2024 12:32:44 +0200
Message-ID: <20240812103254.26972-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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

