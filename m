Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0793DC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB29886E7;
	Mon, 12 Aug 2024 12:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUJaLXtJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0167888533; Mon, 12 Aug 2024 12:33:23 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E8E8861A
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso31253305e9.0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458799; x=1724063599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qmou0XV7PQ5ykpqTk04er3tkk7KlBhskbL8qRGM38GE=;
 b=eUJaLXtJU/bhY8UQTn9kkjnivHPcq7qAONd/u0etfC/w7KeaRubn0AtD/TYE+5sFHf
 0L0Ow1hCRosdnqlErhaGAxUNVSoi++DkbUQ1rmPbNohaBPeyW78WM3kaTPkB58tqS9qP
 WBFMdAUcoDfD9BXpd5vPeD3gigQVFv9K+RY5szLtFEF5kxC5Bbg/FU4keIFFKhybCyoP
 HEjTr59/9/p3Zz48GoLK+DMDkvx+pp/G+qSWqLpM7aUPhAYz84wIK24jJzd35XbHWy8K
 f9NgO1cxSxPMM41eh1e6ikrLQDHG1madoVbdti2s4CNE7ntTR2xzDFkp17EB0b5dJGff
 5jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458799; x=1724063599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qmou0XV7PQ5ykpqTk04er3tkk7KlBhskbL8qRGM38GE=;
 b=focMdgqM1zdD/Nj3xu5coSp6Ay33/ONl4fDOO5qGsE03WwZ3yTGqRTPtHcSWhXIhZz
 XuPgXltffKqCllOXjXK4UScPR4wIqEICWsrZCtLfP6ZR3is/aRaAHf8ZR04qI2b26RvT
 s+mC3sg5kSTjtKByyn0KIN06IWbDWv9JqK4u0TFVMZM3NjWjKDc4YpXKVhsod6seiNku
 RIKwz/0iB5uYZ3W/rXu2EtuRzuQP4UWs2utR8RB7aVXyW31RYCZO1O8ha7+8QknPFzLR
 kAv0EbVnh4OD/d+ODPuFu6Wbm6mG54XQcWhUd4KDwFsYYnJLV3kJQcDBtClK/CmHIk0y
 f4ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtFO7a4EWsck7Rgs+jfaISdQlq9GwHhNu4Gw1h0NEokHfELJI/RiyAc3iRfuvTxNcmmCt2nOT2Fmex04uNOSE86COPUA==
X-Gm-Message-State: AOJu0YzHck/1ScK1zYux1StzOCDvAegueMptwtV94nlGZFUZ6pC5y2Jt
 OJYRuccJlb0XZI9lqbhO5O39W5nINVyOUHGScnR0QIL2yMue/DhW
X-Google-Smtp-Source: AGHT+IG9bBm/JCED2GOyOJjdipWSDpEF/ACQFyBD5eL2zJt6hbtzmQEYOEHui6rvKGrVtIagir5c/g==
X-Received: by 2002:a05:600c:5248:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-429c3a5690bmr58656655e9.26.1723458798970; 
 Mon, 12 Aug 2024 03:33:18 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:18 -0700 (PDT)
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
Subject: [PATCH v3 9/9] doc: introduce led.rst documentation
Date: Mon, 12 Aug 2024 12:32:51 +0200
Message-ID: <20240812103254.26972-10-ansuelsmth@gmail.com>
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

Introduce simple led.rst documentation to document all the additional
Kconfig and the current limitation of LED_BLINK and GPIO software blink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/api/index.rst |  1 +
 doc/api/led.rst   | 10 ++++++++++
 include/led.h     | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 doc/api/led.rst

diff --git a/doc/api/index.rst b/doc/api/index.rst
index ec0b8adb2cf..9f7f23f868f 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -14,6 +14,7 @@ U-Boot API documentation
    event
    getopt
    interrupt
+   led
    linker_lists
    lmb
    logging
diff --git a/doc/api/led.rst b/doc/api/led.rst
new file mode 100644
index 00000000000..e52e350d1bb
--- /dev/null
+++ b/doc/api/led.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+LED
+===
+
+.. kernel-doc:: include/led.h
+   :doc: Overview
+
+.. kernel-doc:: include/led.h
+   :internal:
\ No newline at end of file
diff --git a/include/led.h b/include/led.h
index 6a1471dae85..fe66192eeae 100644
--- a/include/led.h
+++ b/include/led.h
@@ -11,6 +11,45 @@
 #include <cyclic.h>
 #include <dm/ofnode.h>
 
+/**
+ * DOC: Overview
+ *
+ * Generic LED API provided when a supported compatible is defined in DeviceTree.
+ *
+ * To enable support for LEDs, enable the `CONFIG_LED` Kconfig option.
+ *
+ * The most common implementation is for GPIO-connected LEDs. If using GPIO-connected LEDs,
+ * enable the `LED_GPIO` Kconfig option.
+ *
+ * `LED_BLINK` support requires LED driver support and is therefore optional. If LED blink
+ * functionality is needed, enable the `LED_BLINK` Kconfig option. If LED driver doesn't
+ * support HW Blink, SW Blink can be used with the Cyclic framework by enabling the
+ * CONFIG_LED_SW_BLINK.
+ *
+ * Boot and Activity LEDs are also supported. These LEDs can signal various system operations
+ * during runtime, such as boot initialization, file transfers, and flash write/erase operations.
+ *
+ * To enable a Boot LED, enable `CONFIG_LED_BOOT_ENABLE` and define in `/config` root node the
+ * property `u-boot,boot-led`. This will enable the specified LED to blink and turn ON when
+ * the bootloader initializes correctly.
+ *
+ * To enable an Activity LED, enable `CONFIG_LED_ACTIVITY_ENABLE` and define in `/config` root
+ * node the property `u-boot,activity-led`.
+ * This will enable the specified LED to blink and turn ON during file transfers or flash
+ * write/erase operations.
+ *
+ * Both Boot and Activity LEDs provide a simple API to turn the LED ON or OFF:
+ * `led_boot_on()`, `led_boot_off()`, `led_activity_on()`, and `led_activity_off()`.
+ *
+ * Both configurations can optionally define a `u-boot,boot/activity-led-period` property
+ * if `CONFIG_LED_BLINK` or `CONFIG_LED_SW_BLINK` is enabled for LED blink operations, which
+ * is usually used by the Activity LED. If not defined the default value of 250 (ms) is used.
+ *
+ * When `CONFIG_LED_BLINK` or `CONFIG_LED_SW_BLINK` is enabled, additional APIs are exposed:
+ * `led_boot_blink()` and `led_activity_blink()`. Note that if `CONFIG_LED_BLINK` is disabled,
+ * these APIs will behave like the `led_boot_on()` and `led_activity_on()` APIs, respectively.
+ */
+
 struct udevice;
 
 enum led_state_t {
-- 
2.45.2

