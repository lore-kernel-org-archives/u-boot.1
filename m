Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F91CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090208852D;
	Sat, 21 Sep 2024 04:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKIyW2Xf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F820882EF; Sat, 21 Sep 2024 00:52:11 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EE187FA7
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-378f90ad32dso1670300f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872729; x=1727477529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LbkXLyOGTi41VAljTp47rnT4xiyBCdUPzU9fqER1OL8=;
 b=BKIyW2XfTQLnTGrbpbzQCsS+nRwt+KHmGwaVoNhFyM/wDeF2Zsz7VjPQXywMl/v1jW
 KJPXBlu6MjWTCZoO+Kgw7LuEBJsKV9yPJoTRHYHf4hB3+eIZqWyzFF0cCC2UII3JPNWd
 Yb7+G8K6+TlNdv+4x/VJ5IyOfBCDr3OxOC0zWf9QnOPndYVSfxLtM3K3Rv2iFqlvabja
 2T+uLKAcTLVDY/V8YLSDoWilFmfWENL2j1Dq7XF9XQoAiI7SnjCx4fD/0kihdW7teN3V
 amtLmQZfYBhCuuBIkyHQOdQPOko9nCFYJMmZgYeVjs1/N2xYZs5Tv+JxjDjndnCCQeSa
 PyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872729; x=1727477529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbkXLyOGTi41VAljTp47rnT4xiyBCdUPzU9fqER1OL8=;
 b=FyHIXShsVOk3xDEabOvscN6nvGIsmU7vk2lNXBTSuehHhApi3RujmgzWkiYzitFAjE
 ReJkRKrUDDBdxTu5jdQPKwCxMNR/IGa8YN/YpeU87BP9fY9dPcYggsF7WSr+lEUtZr2B
 er9d1AMDYHlvYEv577WEv8+YD11107C8FPRxI/Jkr/LmDLnbIW4dq6nRgM30nMd7q/DX
 lzVjPulzMcw9q7CIHbVrz/qld5NwNWUxna23hNltML1lECqUDHEeIKNFXaL0uSreodcR
 fgtZLeLzAGcU0mH4jbgNsWungad1DdsICD1FgqzUarlgpaMv11mexPq7jP6PZAX8mgNz
 QbyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVzE/eg7EhNTYkhjFvmpMhaeG9liU5/TW8/19InTqZk0mvLLSSYGI13VVNcwWkiRmjN2Bfckw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+rvRSqAIPHD3aDn33afG5d7eWTv1ISOxx2nY42zbwJZml0XpR
 qYAaPLf/6ZDW/hi2OTF7fRRPyv3620pgGAtyp55PWyVpUK92BK5uq9Q6Bu7f
X-Google-Smtp-Source: AGHT+IEzvwqpxPMsj3gOPoubEZd16zsBr6AuZp072OFfQqfbBUf65MxFiov8omya7hgcGtk4Xf9RIw==
X-Received: by 2002:adf:e2ce:0:b0:374:c1cc:2eb7 with SMTP id
 ffacd0b85a97d-37a4315e487mr2583127f8f.35.1726872728869; 
 Fri, 20 Sep 2024 15:52:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:52:07 -0700 (PDT)
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
Subject: [PATCH v4 10/11] test: dm: Add tests for LED boot and activity
Date: Sat, 21 Sep 2024 00:50:03 +0200
Message-ID: <20240920225101.2008-11-ansuelsmth@gmail.com>
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

Add tests for LED boot and activity feature and add required property in
sandbox test DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts |  2 ++
 test/dm/led.c             | 72 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 5fb5eac862e..25859ad852d 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -101,6 +101,8 @@
 			bootscr-ram-offset = /bits/ 64 <0x12345678>;
 			bootscr-flash-offset = /bits/ 64 <0>;
 			bootscr-flash-size = /bits/ 64 <0x2000>;
+			boot-led = "sandbox:green";
+			activity-led = "sandbox:red";
 		};
 	};
 
diff --git a/test/dm/led.c b/test/dm/led.c
index c28fa044f45..4b019c71f3a 100644
--- a/test/dm/led.c
+++ b/test/dm/led.c
@@ -137,3 +137,75 @@ static int dm_test_led_blink(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_led_blink, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 #endif
+
+/* Test LED boot */
+#ifdef CONFIG_LED_BOOT
+static int dm_test_led_boot(struct unit_test_state *uts)
+{
+	struct udevice *dev
+
+	/* options/u-boot/boot-led is set to "sandbox:green" */
+	ut_assertok(led_get_by_label("sandbox:green", &dev));
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+	ut_assertok(led_boot_on());
+	ut_asserteq(LEDST_ON, led_get_state(dev));
+	ut_assertok(led_boot_off());
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+
+	return 0;
+}
+
+/* Test LED boot blink fallback */
+#ifndef CONFIG_LED_BLINK
+static int dm_test_led_boot(struct unit_test_state *uts)
+{
+	struct udevice *dev
+
+	/* options/u-boot/boot-led is set to "sandbox:green" */
+	ut_assertok(led_get_by_label("sandbox:green", &dev));
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+	ut_assertok(led_boot_blink());
+	ut_asserteq(LEDST_ON, led_get_state(dev));
+	ut_assertok(led_boot_off());
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+
+	return 0;
+}
+#endif
+#endif
+
+/* Test LED activity */
+#ifdef CONFIG_LED_ACTIVITY
+static int dm_test_led_boot(struct unit_test_state *uts)
+{
+	struct udevice *dev
+
+	/* options/u-boot/activity-led is set to "sandbox:red" */
+	ut_assertok(led_get_by_label("sandbox:red", &dev));
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+	ut_assertok(led_activity_on());
+	ut_asserteq(LEDST_ON, led_get_state(dev));
+	ut_assertok(led_activity_off());
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+
+	return 0;
+}
+
+/* Test LED activity blink fallback */
+#ifndef CONFIG_LED_BLINK
+static int dm_test_led_boot(struct unit_test_state *uts)
+{
+	struct udevice *dev
+
+	/* options/u-boot/activity-led is set to "sandbox:red" */
+	ut_assertok(led_get_by_label("sandbox:red", &dev));
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+	ut_assertok(led_activity_blink());
+	ut_asserteq(LEDST_ON, led_get_state(dev));
+	ut_assertok(led_activity_off());
+	ut_asserteq(LEDST_OFF, led_get_state(dev));
+
+	return 0;
+}
+#endif
+#endif
-- 
2.45.2

