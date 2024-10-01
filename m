Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B55CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C5B891F5;
	Tue,  1 Oct 2024 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ke0Xdeqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D60891CA; Tue,  1 Oct 2024 14:26:05 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55596891B8
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cfa129074so123841f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785563; x=1728390363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=guWSoBziwmzGibPUpLXQOAbzmdb6H+UaN+ZAPqFRVXY=;
 b=Ke0XdeqqqyCTQmMScc7kL5WfcaRL3A5BIyA/4SeCXt9FJecZ3xpRat6N5cel7xgmEV
 F+6r8VwkyUUxTxTFYoHgYvQRBpFeQCtHenXSwZJg4hiaXw2QXL+MpCWWMLHioXnUbRjH
 db+5/OZAYuofBpAo25XFBxF3md6g2D/ftQYEvIKd/yKlXzEd5HMhz3J1p9+3h1FH8+8W
 YDr5GuDlcj95zKRipPdzhyMlH6jrt4CCdoNjJf7OpBva1KinLL213oqw9Z+rk5qWNPW2
 JP+zrmVWQ6oc4j4E8H8MzWPVMlDbVCKAzVUdJSLZgu3NnURaCWHBljSdfnfUWugf3Rnw
 rc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785563; x=1728390363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guWSoBziwmzGibPUpLXQOAbzmdb6H+UaN+ZAPqFRVXY=;
 b=Vi0vPyAM5bs2SovzeRTLfwni9MUQJ/7lHCK0XgkaSLzBqXZJmkAp0wTk8+YOHR/noR
 CrBv0zf3u1uEXC+acYUlcJ1zKzKsNrYJrrBiRwxV8k/SBv+2yRjPNj8N+hS11msLijIp
 A00/B7g5tAB95Ui4ZxfHPsgfIKjMbhlRNK1+KcFO9dFsykOVB/7mdeySSmHHH/FNVMG1
 MTIboxhO8526RUxmIm6c11mFvsMRKc8mwno6D6ZR2qiCgoTyw2tNhbhcK4aR7yqETpSn
 8Hyo3rQkI26jQhnK7HVCryHluiUytgIDxEnXdrdFXEDN5eWjGQm+OujUFmiZpiZUl7hI
 ZmRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWyoJcDv9PzQpBwI7wsVBGS6+m61J3kCWcFstnix4GUHvz4SwIGUqpz6hNpkFtimvlSTWgENY=@lists.denx.de
X-Gm-Message-State: AOJu0YywSbUtb13iB/3NEOyFmlniKmGWpeXouNKegvR+lH9hhwfZOtLb
 4Bfj81fi6Ijx+HT8BnmT0fHuYDd2msaOakx8sPPt3TXXFBXDFJBr
X-Google-Smtp-Source: AGHT+IEzJkGy3nbPRi2r059cgFx6yfS5DtYbaNWGDpEUO6qdvZ8tWSuxDGdA/nM4mzY8l5q9X6MBjg==
X-Received: by 2002:a5d:6849:0:b0:374:c4c2:fc23 with SMTP id
 ffacd0b85a97d-37cd5b1054cmr9718335f8f.56.1727785562493; 
 Tue, 01 Oct 2024 05:26:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:26:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 09/11] doc: introduce led.rst documentation
Date: Tue,  1 Oct 2024 14:24:42 +0200
Message-ID: <20241001122511.8832-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

Also add missing definition for sw_blink in led_uc_plat struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/api/index.rst |  1 +
 doc/api/led.rst   | 10 ++++++++++
 include/led.h     | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
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
index 19d92d6441a..64247cd3a70 100644
--- a/include/led.h
+++ b/include/led.h
@@ -11,6 +11,46 @@
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
+ * To enable a Boot LED, enable `CONFIG_LED_BOOT` and define in `/options/u-boot` root node the
+ * property `boot-led`. This will enable the specified LED to blink and turn ON when
+ * the bootloader initializes correctly.
+ *
+ * To enable an Activity LED, enable `CONFIG_LED_ACTIVITY` and define in `/options/u-boot` root
+ * node the property `activity-led`.
+ * This will enable the specified LED to blink and turn ON during file transfers or flash
+ * write/erase operations.
+ *
+ * Both Boot and Activity LEDs provide a simple API to turn the LED ON or OFF:
+ * `led_boot_on()`, `led_boot_off()`, `led_activity_on()`, and `led_activity_off()`.
+ *
+ * Both configurations can optionally define a `boot/activity-led-period` property
+ * if `CONFIG_LED_BLINK` or `CONFIG_LED_SW_BLINK` is enabled for LED blink operations, which
+ * is usually used by the Activity LED. If not defined the default value of 250 (ms) is used.
+ *
+ * When `CONFIG_LED_BLINK` or `CONFIG_LED_SW_BLINK` is enabled, additional APIs are exposed:
+ * `led_boot_blink()` and `led_activity_blink()`. Note that if `CONFIG_LED_BLINK` or
+ * `CONFIG_LED_SW_BLINK` is disabled, these APIs will behave like the `led_boot_on()` and
+ * `led_activity_on()` APIs, respectively.
+ */
+
 struct udevice;
 
 enum led_state_t {
@@ -41,6 +81,7 @@ struct led_sw_blink {
  *
  * @label:	LED label
  * @default_state:	LED default state
+ * @sw_blink:	LED software blink struct
  */
 struct led_uc_plat {
 	const char *label;
-- 
2.45.2

