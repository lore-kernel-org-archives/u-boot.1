Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A320C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156B188C25;
	Wed,  7 Aug 2024 21:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SnA9H64r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3974C88BCC; Wed,  7 Aug 2024 21:54:36 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D97588D64
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so1605135e9.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060472; x=1723665272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3vrCt0ijs6fK3vz97R5dEjaLgyd9RHDevZjmK3tYKxg=;
 b=SnA9H64r/r2xDkwDKPnFDr6vcQfxp0XU0iv379SpJ0oFz5muUlqULhCDN364fYiTl4
 dEvp38KwqFpxlMHuJ7m4ovBR7A7qI3kO+PYr7FpTWOamLU6Mq0tjygnUkwS6WY5tI0L6
 ELV7p9NuLR0mC96g4Xbwj55amQpgBn5ugxepP8nuJtDJt+ZFj47RSocBtMtOELT/SyNF
 tOzze6qgz1oYlMsb6QYXIC4QXhan2jqyQeY5/MAbZcVv9xBxi/4bdlFF+J4Vgus0Fs36
 GwKpiI0oJWKvFZ22FekENRT0B1TwoIgDGhec44f8FMOiTxjVxg5yHLg36wIm1qLGsKUK
 3Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060472; x=1723665272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vrCt0ijs6fK3vz97R5dEjaLgyd9RHDevZjmK3tYKxg=;
 b=VKnbMgwwwnXoxvUlsEe44tjuVanCDJt8LEMhzmPOTXQ9u0sPh9Kwi7HK8OlUs9G3kz
 6czyXxGzC6r+7z4pSx/k6duu9IQpDEHsD2alQ8pATuJ/+NARm8c35Db7WiIQCxeS6a6A
 VRbMIoBpTD47bAiyhKNLSD1423RO3p9mY8xhNtuXbgCsELvUSv1nLzsKm8cFMglx2zUL
 +URVC48g9HS6ABk7I833pkUtr2XKEk5FgH4j6u0MTiwzGJmKwdp5DovyXJBilL0btPIp
 zbkcP6H27UdHxYlV1yP68BfGGmgElVzP7g8rQyRy4DeXhDQRx3bAj27+wN+eH3KwKvFW
 SXZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3x/taDTyy092swGVP2GXpJa5U5qdlxDK1wvDj3WwEepg4yMt0mye1acux2nyK/5Rm9qRjwJh3zMlz2gsjNLU+nLOg7w==
X-Gm-Message-State: AOJu0Yyk+iKHJp1DV4U0tMMUKttbM3Ezx56lb5E+U/Z2EDtwG8zFrXXg
 II3bvMVHkE2SP7TclmU8+qc1/ShORcX54H+LCL5Sub+SzaHGlknl
X-Google-Smtp-Source: AGHT+IH0lZcqmaTdcwbeGrGBa4PXeWugTOlYAD3NEEA50PcAzkCcOzvONJCfE8pFdZ8Y3XmF45N3Ug==
X-Received: by 2002:a05:600c:1c27:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-428e6af7a3amr133244155e9.2.1723060471290; 
 Wed, 07 Aug 2024 12:54:31 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:30 -0700 (PDT)
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
Subject: [PATCH v2 5/9] led: implement LED activity API
Date: Wed,  7 Aug 2024 21:54:08 +0200
Message-ID: <20240807195413.30456-6-ansuelsmth@gmail.com>
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

Implement LED activity API similar to BOOT LED API.

Usual activity might be a file transfer with TFTP, a flash write...

User of this API will call led_activity_on/off/blink() to signal these
kind of activity.

New Kconfig are implemented similar to BOOT LED, LED_ACTIVITY_ENABLE to
enable support for it, LED_ACTIVITY_LABEL to assign the LED in DT for
activity usage and LED_ACTIVITY_PERIOD to set the blinking period.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig | 21 +++++++++++++++++++++
 include/led.h       | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index fd9442edaf3..1336f943dab 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -29,6 +29,27 @@ config LED_BOOT_PERIOD
 	help
 	  LED boot blink period in ms.
 
+config LED_ACTIVITY_ENABLE
+	bool "Enable LED activity support"
+	help
+	  Enable LED activity support.
+
+	  LED activity is a specific LED assigned to signal activity operation
+	  like file trasnfer, flash write/erase...
+
+config LED_ACTIVITY_LABEL
+	string "LED activity label"
+	depends on LED_ACTIVITY_ENABLE
+	help
+	  LED label defined in DT to assign for LED activity usage.
+
+config LED_ACTIVITY_PERIOD
+	int "LED activity period"
+	depends on LED_ACTIVITY_ENABLE && (LED_BLINK || LED_SW_BLINK)
+	default 2
+	help
+	  LED activity blink period in ms.
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/include/led.h b/include/led.h
index 7bbe165d838..61ece70a975 100644
--- a/include/led.h
+++ b/include/led.h
@@ -203,4 +203,48 @@ static inline int led_boot_blink(void)
 #endif
 #endif
 
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+
+/**
+ * led_activity_on() - turn ON the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_activity_on(void)
+{
+	return led_set_state_by_label(CONFIG_LED_ACTIVITY_LABEL, LEDST_ON);
+}
+
+/**
+ * led_activity_off() - turn OFF the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_activity_off(void)
+{
+	return led_set_state_by_label(CONFIG_LED_ACTIVITY_LABEL, LEDST_OFF);
+}
+
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
+/**
+ * led_activity_blink() - turn ON the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_activity_blink(void)
+{
+	int ret;
+
+	ret = led_set_period_by_label(CONFIG_LED_ACTIVITY_LABEL, CONFIG_LED_BOOT_PERIOD);
+	if (ret)
+		return ret;
+
+	return led_set_state_by_label(CONFIG_LED_ACTIVITY_LABEL, LEDST_BLINK);
+}
+#else
+/* If LED BLINK is not supported/enabled, fallback to LED ON */
+#define led_activity_blink led_activity_on
+#endif
+#endif
+
 #endif
-- 
2.45.2

