Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AE4D10C0C
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450388916D;
	Sun, 10 Nov 2024 12:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E8wt9w5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A558911A; Sun, 10 Nov 2024 12:51:40 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF4A8908A
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso20419955e9.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239498; x=1731844298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XA68RAvqKHOo6s9eir7rUFmwOpSSbzu5sM3S9VXrzjU=;
 b=E8wt9w5QOGzvgwYMfTbSPQW/zeJQhQbuh9gip4hHGz3NDBoJ1Krt04p5wFW6Z8eJI+
 M5YnnpC27l/zqy1223uCXcw3ED4mPt2l1mN3n6q32jdRXDt1AOpUidUhGy+M3qE+hOHz
 ZhOwsTIr+iBgXgrMhiDeXkX0TzaaNB2rzojBdisx9eGIKEYaADc04AYInZPIgMezGvZA
 QVjFrRjVEEDBfrq0kvXHRBGclRpnEARk4esLA9fhgL31v1ABX50d9huQBGcgB//Lrbas
 0AAso0OdGT9pgm/j9Uj+Dl5hDaurQVe0klW9GdkEqroaN7tFkrZRyZ1/4yoivQJeQgj6
 oUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239498; x=1731844298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XA68RAvqKHOo6s9eir7rUFmwOpSSbzu5sM3S9VXrzjU=;
 b=tF4hESkWXvjlpFfYvEXAQUGcdkHDvPmKSd4KWXAV6//evJ+wE1LZLGPLiixm6qNX7J
 dSvc5a8lIkfVwctWKbgTGDHCe6mCayQkjYvIIkGGRPFjCtq/HW67NbB5oJP9Iwu2SW1S
 ZweSTuu/deHKPkHe0cUsqEQbBvHNUUWGHhJlCaTnY9H94iwZgxjLCWwIBePhTvtyKfKJ
 dhPPdMZMUqxZF4wSzZbF62J13b1K3MmAmw5BqOglgxSzIkKyo3ChE5QcDHg6087tP0LG
 Vqog7ikoAOMs0/xII5imfC3ZlCX+cWmXovPyvqr+Mqq8cbEQp90ElNU/nTvc19WpRpOb
 KVBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0+JDu0S/aEJrT9O6+a4/Fn1WZMWEXUH7HgNA5ugpAu+vCYgWLAjRTnOSzZUVMxcV4bOhypHA=@lists.denx.de
X-Gm-Message-State: AOJu0YxtKzHOfjdzVwm2fiG0brIugVqFHcuqvOv56Ak82Vo0V96a3eph
 htJZ+AofCD9+WSaMikRbq4beM83/xI5RzV56BQJDo2cJ5B8oZ5/2
X-Google-Smtp-Source: AGHT+IEQHJweLb/HRXjXQIz/3Q3BPoQUcISfVDNUn0YaB8Jz2fp6qeOkA9j6oMkVwCnAJVBC1gqksw==
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-432b77fe58bmr76947475e9.0.1731239497856; 
 Sun, 10 Nov 2024 03:51:37 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:37 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 7/8] led: update LED boot/activity to new property
 implementation
Date: Sun, 10 Nov 2024 12:50:26 +0100
Message-ID: <20241110115054.2555-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
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

Update LED boot/activity to reference by phandle instead of label and
add to period property the "-ms" suffix.
This is a followup request by dt-schema maintainers that required LED
node to be referenced by a phandle to the node instead of indirectly by
the LED label and for timevalue to have a suffix.

While at it generalize the LED node label parsing since the logic is
common for generic LED bind and LED activity/boot.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/led-uclass.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 05e09909b7d..760750568c0 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -232,16 +232,24 @@ int led_activity_blink(void)
 #endif
 #endif
 
+static const char *led_get_label(ofnode node)
+{
+	const char *label;
+
+	label = ofnode_read_string(node, "label");
+	if (!label && !ofnode_read_string(node, "compatible"))
+		label = ofnode_get_name(node);
+
+	return label;
+}
+
 static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
 
 	if (!uc_plat->label)
-		uc_plat->label = dev_read_string(dev, "label");
-
-	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
-		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
+		uc_plat->label = led_get_label(dev_ofnode(dev));
 
 	uc_plat->default_state = LEDST_COUNT;
 
@@ -300,15 +308,21 @@ static int led_post_probe(struct udevice *dev)
 static int led_init(struct uclass *uc)
 {
 	struct led_uc_priv *priv = uclass_get_priv(uc);
+	ofnode led_node;
+	int ret;
 
 #ifdef CONFIG_LED_BOOT
-	priv->boot_led_label = ofnode_options_read_str("boot-led");
-	priv->boot_led_period = ofnode_options_read_int("boot-led-period", 250);
+	ret = ofnode_options_get_by_phandle("boot-led", &led_node);
+	if (!ret)
+		priv->boot_led_label = led_get_label(led_node);
+	priv->boot_led_period = ofnode_options_read_int("boot-led-period-ms", 250);
 #endif
 
 #ifdef CONFIG_LED_ACTIVITY
-	priv->activity_led_label = ofnode_options_read_str("activity-led");
-	priv->activity_led_period = ofnode_options_read_int("activity-led-period",
+	ret = ofnode_options_get_by_phandle("activity-led", &led_node);
+	if (!ret)
+		priv->activity_led_label = led_get_label(led_node);
+	priv->activity_led_period = ofnode_options_read_int("activity-led-period-ms",
 							    250);
 #endif
 
-- 
2.45.2

