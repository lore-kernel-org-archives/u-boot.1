Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D29C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7991988845;
	Mon, 12 Aug 2024 12:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LY+e0xJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5720887D6B; Mon, 12 Aug 2024 12:33:13 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A1C87F19
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so30546535e9.2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458791; x=1724063591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTp4D3gMYy7OE1wuBDKAirYogref0q7WmKNyHnlQe5Y=;
 b=LY+e0xJh7CRMTuN+UzdFrJndfGqfzIkswpvwTUX3FamhHJhu+A7fo0rNUDxr0cbPPF
 41+76RfODo382BMuNvevRwr/FXKcgKhDTSWbXjajuhsEM3gQt5i58VFQin1+MctvIufA
 KtAChAiDr6e/RtH5BL60s7yP/CTPOwWjXgcI58Lp1l+4DMaFqXkCKSTAL5Vvc2iIsvf2
 PglvZKrOI7RyUN9LNbgVMqCHLpT+eoznhuG2HVi4zsXqoPzl9MDE4c7IgdXLt36h7CQT
 WskBraNhqTuFRP6elRCDs8045XgKXWVHOeTY0DOnvRfL1pbD3Yc2M6rTCMI/Zv4G0H1/
 37AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458791; x=1724063591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTp4D3gMYy7OE1wuBDKAirYogref0q7WmKNyHnlQe5Y=;
 b=n0IYMftTi219qeqrSjTgxjRGwXFRrpPE+iGgB6jebSmprETqQLkr0Dl/M4qFV3T5uG
 Z5jP5cMwFKPruSc8Gz0L11P3PqxhZAjcm2/3fF9JnJJtNGF1ZZ2v/nQe6pRGcJbcMGR+
 oDuvnpH1qDLp/7SIhi3GW72Qn4WyWs9yQwGRCr5s/sI5tDf8zB73gh+XYne9P1zI9Mlm
 vZE1rgHL8H0babPi36qv0GHn4q6TiNdLU9WxQiIKcnFpHmtjQMmknMSp502c+kwKLPfC
 ojZxLmLNlUUuxe1sScayzOc7PoifVSXNndzXD2A3Jt7/EpoJ3wbQDn3zj8VuK6Yg4pSg
 6TRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtD+99z5R9IexL6qvYTLQnEbzW3embXL6jPtcn28qi7FVGS0KFIZxECNab+cTy311aiCm4UetgdwsrlWmbv3gK6i4mjw==
X-Gm-Message-State: AOJu0YxzOx6RUJ8SR6w7WgLMM8pz6X2woS+9LXSCYFShhp4L1wyig22l
 eQznnqhsjPGiNbcXjkwbZ4PspKVvky58BkVIDFPloXh8fC9WGETn
X-Google-Smtp-Source: AGHT+IGGgEtQeontU6KXiHeq9TbVYldrHDkUhoptQsr9ETIrgQSAK7vRSpk0SnPHsy/TGurfQgkCHA==
X-Received: by 2002:a05:600c:4f8f:b0:426:6ea8:5037 with SMTP id
 5b1f17b1804b1-429c3a643bdmr60411265e9.37.1723458790428; 
 Mon, 12 Aug 2024 03:33:10 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:10 -0700 (PDT)
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
Subject: [PATCH v3 5/9] led: implement LED activity API
Date: Mon, 12 Aug 2024 12:32:47 +0200
Message-ID: <20240812103254.26972-6-ansuelsmth@gmail.com>
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

Implement LED activity API similar to BOOT LED API.

Usual activity might be a file transfer with TFTP, a flash write...

User of this API will call led_activity_on/off/blink() to signal these
kind of activity.

New Kconfig are implemented similar to BOOT LED, LED_ACTIVITY_ENABLE to
enable support for it.

It's introduced a new /config property "u-boot,activity-led" and
"u-boot,activity-led-period" to define the activity LED label and the
default period when the activity LED is set to blink mode.

If "u-boot,activity-led-period" is not defined, the value of 250 (ms) is
used by default.

If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
led_boot_blink call will fallback to simple LED ON.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/device-tree-bindings/config.txt |  4 ++
 drivers/led/Kconfig                 | 21 ++++++++++
 include/led.h                       | 63 +++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index 68edd177040..cd9ec88909b 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -30,8 +30,12 @@ u-boot,boot-led (string)
 u-boot,error-led (string)
 	This is used to specify the label for an LED to indicate an error and
 	a successful boot, on supported hardware.
+u-boot,activity-led (string)
+	This is used to specify the label for an LED to indicate an activity
+	if supported by the operation.
 
 u-boot,boot-led-period (int)
+u-boot,activity-led-period (int)
 	This is used to specify the default period for an LED in blink mode.
 
 bootsecure (int)
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
index 2d3b89674e2..6a1471dae85 100644
--- a/include/led.h
+++ b/include/led.h
@@ -223,4 +223,67 @@ static inline int led_boot_blink(void)
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
+	const char *led_name;
+
+	led_name = ofnode_conf_read_str("u-boot,activity-led");
+	if (!led_name)
+		return -ENOENT;
+
+	return led_set_state_by_label(led_name, LEDST_ON);
+}
+
+/**
+ * led_activity_off() - turn OFF the designated LED for activity
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static inline int led_activity_off(void)
+{
+	const char *led_name;
+
+	led_name = ofnode_conf_read_str("u-boot,activity-led");
+	if (!led_name)
+		return -ENOENT;
+
+	return led_set_state_by_label(led_name, LEDST_OFF);
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
+	const char *led_name;
+	int led_period, ret;
+
+	led_name = ofnode_conf_read_str("u-boot,activity-led");
+	if (!led_name)
+		return -ENOENT;
+
+	led_period = ofnode_conf_read_int("u-boot,activity-led-period", 250);
+
+	ret = led_set_period_by_label(led_name, led_period);
+	if (ret)
+		return ret;
+
+	return led_set_state_by_label(led_name, LEDST_BLINK);
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

