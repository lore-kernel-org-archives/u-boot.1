Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE63C30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FC988481;
	Mon, 24 Jun 2024 23:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilg1XRRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80D888412; Mon, 24 Jun 2024 23:46:39 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17C6882DC
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d203d4682so5795309a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265597; x=1719870397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nBkr1XCfMuJlQSMMcwjBGGwlw9SBwzqro/e6vXMYw3o=;
 b=ilg1XRRx1rdF8nujzTd/GztOyCKb3r97VHDsZGdDbQLM+pIsMrMq0rmkXwcamc2bpE
 FZ2dMpE2AnJbZQAaDpvi6Pa1WmEYbOEceRcQC+55e4DBmOjb1MRIb4APef6NflybqVFT
 0d2UEq72HmDp8do55FImu5/0BDthNYW16QGayO1jHssGyL8GU7lMqRiELSyGZW6zakNA
 1+Sbsbm4SxyGKeSKgN+FpogDtY3+tVG0rcp+eAcvdOhlTyEp8oyx6aGTKc/HLj6QdE8Z
 +httFNWk9YaZ11qgCspcCUsBn/R6J+pWJSS3vlYRgp2Q8GjRhSq0kSRPCap/W2QBlDVX
 RDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265597; x=1719870397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBkr1XCfMuJlQSMMcwjBGGwlw9SBwzqro/e6vXMYw3o=;
 b=hNsCSlSljm66w1Q3/FIhnzD0LhR1VfZPxkL+iLY1DlboKBIQdwkOZtGH4TjIs4nD5W
 dJxb+Ac4rr1j/iJt2x31yV0I6Zv778vuBenKxk2J9zDYmPYCm+eaWhK1eRbZM5bSUy54
 Sa7tG35XOl5TUGz8VGpIG5Xs8kYper7+qJk9J1CTd1xmhmf8/hwFu95JXoYfLmrO05ss
 GgOkVs+GRx916LPD8Nq+RjyVZAWKptZfbZj4QYj7CKRoz7FBSejkFz5yHxDKZHbSZoMO
 BwG2MSPppXyNFoVfvVc9bQz5G8HE0KMTupXKqS+vESZTDvWx5gVHc+qDsF6Sn9x/5XbX
 n8tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK98v9kLjOdl2cILaPnpT5W5dBmmOwtR4cGhla6oMI0PHZy0J9TMZWKitxGVDeLnTCD5Osam7FYyaGcclJB9wxXknNlQ==
X-Gm-Message-State: AOJu0YzfRrLUn5v6RJDyoUNw0XMcWHdT8CFleKHu93ElTFoqepJfe/0N
 96LB2b/aBKiWFgemPAZoiPv++HVC6KieLZndouWk+XPG4o4bVfET
X-Google-Smtp-Source: AGHT+IFN8KXr+WUDPaZEuGllMibkBn3E4kmf4L/aPd1/iNbYGGzuOPtHXieUfHG2oT6Jbngn0xxxRg==
X-Received: by 2002:a50:d698:0:b0:57c:ff94:c817 with SMTP id
 4fb4d7f45d1cf-57d45791fb8mr3385031a12.16.1719265596852; 
 Mon, 24 Jun 2024 14:46:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 2/9] led: implement led_set_state/paeriod_by_label
Date: Mon, 24 Jun 2024 23:46:12 +0200
Message-ID: <20240624214626.24336-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624214626.24336-1-ansuelsmth@gmail.com>
References: <20240624214626.24336-1-ansuelsmth@gmail.com>
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
index f37bf6a1550..d1e9916bb33 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -61,6 +61,20 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
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
@@ -81,6 +95,20 @@ int led_set_period(struct udevice *dev, int period_ms)
 
 	return ops->set_period(dev, period_ms);
 }
+
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
 #endif
 
 static int led_post_bind(struct udevice *dev)
diff --git a/include/led.h b/include/led.h
index a6353166289..71dd7a28d93 100644
--- a/include/led.h
+++ b/include/led.h
@@ -93,6 +93,15 @@ int led_get_by_label(const char *label, struct udevice **devp);
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
@@ -110,6 +119,15 @@ enum led_state_t led_get_state(struct udevice *dev);
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
2.45.1

