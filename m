Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3568CC30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEDA88576;
	Mon, 24 Jun 2024 23:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiwHBggv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E743D88119; Mon, 24 Jun 2024 23:46:48 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F808856B
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d07673185so4515053a12.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719265606; x=1719870406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dS4FLeyjqAXWjQ9DvKgAMPqYWa0no/rNxLNm3N6TAYY=;
 b=aiwHBggvhYORCXBaOYuElyUhU/AOaSHqxq8fnGiIjyC7l0HZSJtZG5IufBNLoL4Bvs
 oEbItox1LsGA75sur57IvKC+bpY46t9R1YWkK8JFsZauMztuNOF+9SEscPfSxhBC2c0J
 D4WMcNAgWKfhxa+VqwtgkIBlvN1uBk6MAtOOiFn/q9thlxRlrjEjwG5uP5KLYKaAlbd/
 Tau6lUFbCpFliNGuMbAOUgUetkfta1tKeDXHFSX1MLDKAtHJuGt+eCYEwaMKyGIFY8lx
 ZgIAkvd48FvER4rfBpHK5YxjchKgjzZVb1LBNFMRjnonrsY1+amS+avF20FYWTanzLfw
 gr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719265606; x=1719870406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dS4FLeyjqAXWjQ9DvKgAMPqYWa0no/rNxLNm3N6TAYY=;
 b=VVh5k0pYrdfD8gEOs1QCoSNkxraicvcYVJhy2GvUn3g0B+97n60F6dDDTbN4HHpKYZ
 fv2aNLeSypQvCZ5pUzmGG80I5DCgiZ9aRfW57j5HOzg4QTDl12s1R57jSNHSwHfpcOYH
 gJaRZLbC7I3/psz2HMm1fP86cLRECRjY6nFhfCOwlIAxQ23KNz6Gll9NsCYwZagfkCkJ
 lHuuNsgWhFsQ/cZMRJZGHwd+7TMCM2iCc5ZCIvRuLcLpJRPP43sSohUF8dhkdpY/np4U
 TfL7Als2HdUSyK9koZzTcwWjZmZ9M305CcFAa5f0AwydRwZPvAsLLmjeX0eXsmURZk5R
 vSGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLeXrbBrR/tt7weJGq3YoQ1Xz8gzJXmvjx9PTPZTvxSvPvTqp629ODxry8Y3BnN+QXrpvCdvtGhr0KFGNfTrxe6z/iBQ==
X-Gm-Message-State: AOJu0YyWhCVcYAT59iY+hZOcQCyEkKjxgv4iKuUFQQAqO61BD6PwTA4y
 2fvMJqacEZ/US3a2vUwpV4CZhbBLpH5GE7g856MvtDSnaZmft81M
X-Google-Smtp-Source: AGHT+IG0dpKD6R99TqAIUIWQJKUx1EhDaaTpWkG8faImZqNsgz2LRPx9Pg19qTRRY5i4GU67yxPaXg==
X-Received: by 2002:a50:cd93:0:b0:57a:2fe7:6699 with SMTP id
 4fb4d7f45d1cf-57d4a281750mr4432462a12.14.1719265606327; 
 Mon, 24 Jun 2024 14:46:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d7b1bsm5100588a12.11.2024.06.24.14.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:46:46 -0700 (PDT)
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
Subject: [PATCH 9/9] doc: introduce led.rst documentation
Date: Mon, 24 Jun 2024 23:46:19 +0200
Message-ID: <20240624214626.24336-10-ansuelsmth@gmail.com>
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
index 51b2013af36..6f11b94eac3 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -13,6 +13,7 @@ U-Boot API documentation
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
index 409397e1df9..4dac54338e4 100644
--- a/include/led.h
+++ b/include/led.h
@@ -7,6 +7,44 @@
 #ifndef __LED_H
 #define __LED_H
 
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
+ * functionality is needed, enable the `LED_BLINK` Kconfig option.
+ *
+ * GPIO-connected LEDs can simulate blinking via software using the Cyclic API. To utilize this,
+ * enable `CONFIG_LED_GPIO_SW_BLINK`. This will also select `CONFIG_LED_BLINK` and `CONFIG_CYCLIC`.
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
+ * Both configurations can optionally define a `_PERIOD` option if `CONFIG_LED_BLINK` is enabled
+ * for LED blink operations, which is usually used by the Activity LED.
+ *
+ * When `CONFIG_LED_BLINK` is enabled, additional APIs are exposed: `led_boot_blink()` and
+ * `led_activity_blink()`. Note that if `CONFIG_LED_BLINK` is disabled, these APIs will behave
+ * like the `led_boot_on()` and `led_activity_on()` APIs, respectively.
+ */
+
 struct udevice;
 
 enum led_state_t {
-- 
2.45.1

