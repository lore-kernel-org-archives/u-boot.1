Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F9CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC92889AE;
	Sat, 21 Sep 2024 04:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgNiOuLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B495B880D8; Sat, 21 Sep 2024 00:52:08 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E1A8817C
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so1695717f8f.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872726; x=1727477526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V5eWNU266He6A+/t13MeJTalkxc3ldDl87xEfT6nr4Q=;
 b=LgNiOuLyRymjiKPibYU672pm0wpJOdwmxQenv+O45i7J2Oa+qHokBPwA5uHXlE46Ag
 1VFqAUhy50A5SSvMWuTwsKpCPfK6wi5JJto+kmUOzV713c8sjPr9ZegUSstkr6ncff6j
 EqRMdhEc49NrXdIUE3mBI3zumLNrQSM0NVG7d6CS/fU8PLGGVf1g4ZWz6Vybadc7uSY/
 FCAUifJqbmANJhk6BtDk9NKBEcJraszsHt23GRHDrFWvzKmcZQyggtQY+UWoQw9vsy9n
 wZQ/0U1HIsWxiBoKYG6fG75C8Brviaub7dJMzbnnAFEXXLYmnxnUV/nMxz5AJIbELOpU
 qCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872726; x=1727477526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5eWNU266He6A+/t13MeJTalkxc3ldDl87xEfT6nr4Q=;
 b=f5y0T4LufGqE9yIoQ4al+oqGNk8xW35yLLpUAORJdyLbcqyG9yefLTcddE/yW7cUqG
 4EQcAIwLf3Z1Yj5eO0+3jV3Wp8zofm1Cnu79T+WDC+p+myiVwzpO0uHDzmhc7eLjcVzm
 7Pdekcr41EAAJd2+5c1onrvfl7ovgMPHAmeuwb/rXk/kwOVyzN8Mxmhf63S+F5WCWuKn
 p7t/h19/ovxu9CFg+AzSU9dSF9gpKi+dwUxaGQj6sJJEmGf3atxDDdXfGdZX20dZCcYT
 nR//Kl7eZjNUm+GDGnFNNsdyFsss62Ah/LW5Wj0Qp7NtY2LwdtFPYx1HUKZP7/4Mo7pQ
 DG1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOXRR8g7dGY/4D82C/frAtrCWUv0yaAVBxtT/VNHArvELJsunHa1Lc6+tMCcDYqWUJY7lGov4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+XCKvXQYSGOcnc6ZjaM50v054Ex/hG324+q5DNbjtvZ0mPRkv
 mpTHMrB5QtVVmSxUWIiw0bF7NQxmvBbf14W3Hz17HvYCN//xFloG
X-Google-Smtp-Source: AGHT+IGhT8OYIfp4w43excmVvDy6dfQ218/MP1yeQD1rZHC15fXUjhBFpOEBymqtFdB6psqB9dxLeg==
X-Received: by 2002:a5d:68d1:0:b0:374:c287:2af9 with SMTP id
 ffacd0b85a97d-37a431ad53amr2261672f8f.46.1726872725633; 
 Fri, 20 Sep 2024 15:52:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:52:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 09/11] doc: introduce led.rst documentation
Date: Sat, 21 Sep 2024 00:50:02 +0200
Message-ID: <20240920225101.2008-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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
index bba8c0009ca..a9dd55efd1f 100644
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

