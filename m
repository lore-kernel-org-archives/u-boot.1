Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11615C30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF9A883CD;
	Mon, 24 Jun 2024 23:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdzkEctt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A147F88548; Mon, 24 Jun 2024 23:46:43 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6921883DE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d0699fd02so2516069a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265601; x=1719870401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hFdiYLPFmEwefSVTZoSBcmSl62d4EleDoiEDFT53tAI=;
 b=hdzkEcttjAAuDxTWOMwkwB/I7WKxvNRXKREoudcC0k1WxuugPrpyI03qOCGCUZvxXY
 G9YEUZn+jcYXDIqQe8TEFj6KABTwOaiLq4+vVpkkArlU1wh8Kxj4dIj4TPWK8jZ4smlB
 2EJEv43BDgDY+BjEccyE/zdxmzK65xgdHQsRTiZhOkIqUOsKG4s7dMc0YAKCvBqe0eBV
 ErynwQeC1hpGQ1yakVU1X41ojHpmn02661wZ/vNLkjYL8QkFms+flzZi1cCGi80dc3Nl
 qLCCtKRLcnCXngih5OxVCOKrXZPQVkgduoFva2wnajU8vZ6SSQJVKBp1NSBzF+eiB+8I
 N1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265601; x=1719870401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFdiYLPFmEwefSVTZoSBcmSl62d4EleDoiEDFT53tAI=;
 b=Fm3ShTn1a6DQe+fe9qJQawxXNZ8yIQ+KLRf9hoMsEp6rtI5ffvFp0hsuiC+ohfV8ri
 +YQ0wxooqrQ5MaT1u47eIbI+bBt8w+fWXeCmGG4RM5/hppNPQ3ttF5TvKGytPgZ/eWDf
 aJAYmwGnhF0GJJlGR08A5hb7Rfl3sVWY6bpp0aNNRDWQWdykX/rm80L8t+w9R3vajIUZ
 3vfEOgHiSsAtxIyzg7mY/lnPevoGeEVGoUNM6YWD/SRPP08MqgdqEgrWjQqsYoymHAfU
 6mOOTeDSTLgSkVPrujVLtZLOiwOnhXHYfE8FwoMJ8Eaw5S2MokRYsLEviM6jN3q5yaig
 VaHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMPRGS4gwvzf1T0srYKXucd04v0tVCOKVQF3UcYUwpbxcKOou96/UiuIdV6WJ62Od4Ag6ZPtfkiwwfsVdBvBR9x6A1lw==
X-Gm-Message-State: AOJu0YyWaqsUKIlytL0GA2rzNBKbVxAMhrxqTdoLoTYwyue72e/L5KmK
 dfzWBK+f0KnQ0kJBiVYjPoEJWIxuaoZkH5pMCQ7cTVOTsBG/2V9+
X-Google-Smtp-Source: AGHT+IG3Z19HNcmsa1dP7Nq2xSpAhMpcpPfrziA4788/WcyGFoC/dV8Uly3aXu01Zs9YXDiyFZ7s4g==
X-Received: by 2002:a50:d50c:0:b0:57d:579:3ca2 with SMTP id
 4fb4d7f45d1cf-57d70069df6mr840732a12.30.1719265600908; 
 Mon, 24 Jun 2024 14:46:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:40 -0700 (PDT)
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
Subject: [PATCH 5/9] led: implement LED activity API
Date: Mon, 24 Jun 2024 23:46:15 +0200
Message-ID: <20240624214626.24336-6-ansuelsmth@gmail.com>
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

Implement LED activity API similar to BOOT LED API.

Usual activity might be a file transfer with TFTP, a flash write...

User of this API will call led_activity_on/off/blink() to signal these
kind of activity.

New Kconfig are implemented similar to BOOT LED, LED_ACTIVITY_ENABLE to
enable support for it, LED_ACTIVITY_LABEL to assign the LED in DT for
activity usage and LED_ACTIVITY_PERIOD to set the blinking period.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/led/Kconfig | 23 +++++++++++++++++++++++
 include/led.h       | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 0506a33b6ee..f53e5fb5bd3 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -31,6 +31,29 @@ config LED_BOOT_PERIOD
 
 	  Value is normalized per CONFIG_SYS_HZ.
 
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
+	depends on LED_ACTIVITY_ENABLE && LED_BLINK
+	default 2
+	help
+	  LED activity blink period in ms.
+
+	  Value is normalized per CONFIG_SYS_HZ.
+
 config LED_BCM6328
 	bool "LED Support for BCM6328"
 	depends on LED && ARCH_BMIPS
diff --git a/include/led.h b/include/led.h
index 479c6d17c5b..409397e1df9 100644
--- a/include/led.h
+++ b/include/led.h
@@ -176,4 +176,44 @@ static inline int led_boot_blink(void)
 #endif
 #endif
 
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+
+#define LED_ACTIVITY_PERIOD CONFIG_SYS_HZ / CONFIG_LED_ACTIVITY_PERIOD
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
+#ifdef CONFIG_LED_BLINK
+/**
+ * led_activity_blink() - turn ON the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_activity_blink(void)
+{
+	return led_set_period_by_label(CONFIG_LED_ACTIVITY_LABEL, LED_BOOT_PERIOD);
+}
+#else
+/* If LED BLINK is not supported/enabled, fallback to LED ON */
+#define led_activity_blink led_activity_on
+#endif
+#endif
+
 #endif
-- 
2.45.1

