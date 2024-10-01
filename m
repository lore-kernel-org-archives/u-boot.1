Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E61CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F611891FB;
	Tue,  1 Oct 2024 15:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d5yOIwNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7A6891B8; Tue,  1 Oct 2024 14:26:07 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D801891C6
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37ccd81de57so3406376f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785565; x=1728390365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w87C4Z/qR+AjxVgt/LCAEnP1+5uYeVUj4/5pIOTbt4c=;
 b=d5yOIwNRVN8w/pCHkocv+HrkzB7q1nWJi6gLSaNS2UgwmJnkJx9vsddW7lG2GcoODE
 i82X6zstXeI9ZhJlENCG0Tt2mYmpy7MDJI9JKlnFD10njyDL/l2kPzlC9jCx8r8TaaJg
 wI+aCRgShRdtt1XjKPVXmG9lnMlHe/Ndo02J9WryOFmrwPArbwKGNLj6LvmapuCL8XS2
 C/ptq1DUTZvRe4w82BQpBlkREP/ZeQo27t8PDBqxfdtqruTPtXDa6hfA/bB7ExoVMBk+
 OlkUW5i3j/OU1wayTBjUh5ta1FwZ4YiLhP264i7ppilleaPKVxTCT+yIJq4WRf+jxa4H
 5Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785565; x=1728390365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w87C4Z/qR+AjxVgt/LCAEnP1+5uYeVUj4/5pIOTbt4c=;
 b=TyqbkDaS0HGzTlnAcfGFhhVYw1Q6x1cbudZq38TT+FEq2XTqFATIO9ZiuuDba8nObg
 OGY2bEvAXWLqIKlHfd2x/8etWyruYQv+x/rmBV+8BCPyq7vieACe8h7noahy1oCRAPPF
 iwhC7trdfjDe9Hrt6T+ARpxwWovblFALJIhxtae7ZxNX0T1F7PBOUbG/yFB0nt7imfGt
 vJghu3btq3xFX0axLYXwcdgMacJkrpExZ/Fw6hlhTEOfw+GWAhJePfUhN5gCLF437m/G
 ui3Bhh9meYb3Md5iRTR3y8dij0kf/PtMWPe/1lnvAuprErzoHDy4uQn4cdS2hRlfckQB
 069A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgqeHj7fj0xa8sOC8f7wbEp63rN71LnggQmnoBFy7m4gFy6JUbOE9U7O54cBy1WMrSJFYdV1U=@lists.denx.de
X-Gm-Message-State: AOJu0YxpnraHMeJc9CuLXLw6ekhhxrG5zsK87KtnsA8X5WPTuInCd+t4
 pK5pH2XI9Jt1Ehk367byaSEc1eujcfszQiyonrLHnm1qkPUMtP0S
X-Google-Smtp-Source: AGHT+IFAujWJX1kzBnQi8zxZqAgHz4aT8OjyHwhxqx9Qu0o6a0GLh/dy4QQh6XDENNE4mwSu7IkFAA==
X-Received: by 2002:adf:eb92:0:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-37cf289b9ccmr1417211f8f.3.1727785564507; 
 Tue, 01 Oct 2024 05:26:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:26:03 -0700 (PDT)
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
Subject: [PATCH v5 10/11] test: dm: Add tests for LED boot and activity
Date: Tue,  1 Oct 2024 14:24:43 +0200
Message-ID: <20241001122511.8832-11-ansuelsmth@gmail.com>
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

Add tests for LED boot and activity feature and add required property in
sandbox test DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

