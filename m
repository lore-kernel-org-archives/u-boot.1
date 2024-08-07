Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B35EC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8803488D8D;
	Wed,  7 Aug 2024 21:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6n6j1D3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD7488BE0; Wed,  7 Aug 2024 21:54:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A7988D74
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so2402355e9.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060479; x=1723665279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L3shv0mqVno8ExTRpKcG8NYIykVr1ivHiHnRmpP2dz0=;
 b=h6n6j1D3p66w/ES9LEmkyuwkV6rTXbqGJjyv8SXqGAH1a3pu1WVQL0TPbWmf7X5R4r
 JHZMosCvSIwDBBlLBAAfuIjNACMfSaorKttWGTFBeiE2yN/QTBMY1i+ifED7dqK20oV3
 021tukVKfUvhUfCRiXOCb+3nQ47/KepkzwdJDvYhDiKVPR9zZOrv3tDqpQBP7Ba2K2Vp
 ePrvk+pKGI9dnrdfBUOgTQIVeIPluTbbJ7OgAIcqOIuZwcNOlmFabuWUzHt22av35td5
 Eoo04s9y0SrtuHiTYuRYxs/3MFn1qVK9MyNHF+Wgr8MYM3PZ/2Xrqm+TbCifI0DfmUuW
 5+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060479; x=1723665279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3shv0mqVno8ExTRpKcG8NYIykVr1ivHiHnRmpP2dz0=;
 b=JfZAL5cJV25rT8mT/Zq3K4bBftjrnI4fEOxQ9H6wWoAt3gZ7RhlbfxIG7aObZXP7Sz
 Gg3ZJTJKVA9SE75FwKgJYaH6hBrZd6eptUPkjBpDnAixYoLUNNFwz26adxFReqdX6zHP
 G10+ijZiquqS3zNVMHr0+6OEo4rCxnFZ0qWAh9ciMufFCxQ0D/RdVM9bhCoQdckWCNM4
 3xA9Zv7eyRtP6fcS7ghQv1BfYgAEU2iJYH3Qj9U6OuicHkXUE+HQ+zIzX9k/xLfzUMns
 Q/nnyVNpXsbD8pFF3+1l7ZxAwEcE1p9A6uODyBaDKFX7hmzUZyrWS+tQJZPa3Za5nBm3
 qdcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3QBj0RaobuwtHNJ/p7tgU5LXR6A9rv0z++8fPkPQGIDdxQy42G+blyZpwos9AOrmgR04vdRWfltT86x2EKUK0+zU8g==
X-Gm-Message-State: AOJu0YwwtZ6JTuZ6brd4WKFiCd3JlaIZo+WL5Adzw15YsmNBrIWqhUzT
 XGqF7KJjOQUIcNG8iozTojnba1LHTCPpqAn9seywpjkBW9KsYVmL
X-Google-Smtp-Source: AGHT+IFex5pEo8ENBvuwr7+EI3w/h8XtpsvYi9tke1lBjaiqXaGjArcwVUfucaCsifwaaqeNBZL+VQ==
X-Received: by 2002:a05:600c:4588:b0:428:15b0:c8dd with SMTP id
 5b1f17b1804b1-428e6b2f14emr185113635e9.20.1723060478903; 
 Wed, 07 Aug 2024 12:54:38 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:38 -0700 (PDT)
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
Subject: [PATCH v2 9/9] doc: introduce led.rst documentation
Date: Wed,  7 Aug 2024 21:54:12 +0200
Message-ID: <20240807195413.30456-10-ansuelsmth@gmail.com>
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

Introduce simple led.rst documentation to document all the additional
Kconfig and the current limitation of LED_BLINK and GPIO software blink.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/api/index.rst |  1 +
 doc/api/led.rst   | 10 ++++++++++
 include/led.h     | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
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
index 61ece70a975..77b18ddffbf 100644
--- a/include/led.h
+++ b/include/led.h
@@ -10,6 +10,44 @@
 #include <stdbool.h>
 #include <cyclic.h>
 
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
+ * To enable a Boot LED, enable `CONFIG_LED_BOOT_ENABLE` and define `CONFIG_LED_BOOT_LABEL`. This
+ * will enable the specified LED to blink and turn ON when the bootloader initializes correctly.
+ *
+ * To enable an Activity LED, enable `CONFIG_LED_ACTIVITY_ENABLE` and define
+ * `CONFIG_LED_ACTIVITY_LABEL`.
+ * This will enable the specified LED to blink and turn ON during file transfers or flash
+ * write/erase operations.
+ *
+ * Both Boot and Activity LEDs provide a simple API to turn the LED ON or OFF:
+ * `led_boot_on()`, `led_boot_off()`, `led_activity_on()`, and `led_activity_off()`.
+ *
+ * Both configurations can optionally define a `_PERIOD` option if `CONFIG_LED_BLINK` or
+ * `CONFIG_LED_SW_BLINK` is enabled for LED blink operations, which is usually used by
+ * the Activity LED.
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

