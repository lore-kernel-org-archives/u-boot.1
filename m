Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FDBC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 08:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D483581D5D;
	Wed, 23 Apr 2025 10:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gTE+xPlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFC08144A; Wed, 23 Apr 2025 10:43:03 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FC280EE5
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 10:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so93865215ad.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745397779; x=1746002579;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08hGVKvJljLPuQk7wEdoyKrFGTlDytmnWY6SeLup23w=;
 b=gTE+xPlv9U0S99iVnZD+qUiqxiTf7zxhgOjAlfbRDGFMjEV/SGVX3JeahflJYSEWbq
 69s78V1RgaJ4IGw7xFAWJIdC/fvl08Me0La07Zgv1IL93HaIhm7GaoptMFMKs8KCs/+K
 pUJvkWJnx0kku5bnj1YW7KSnA0S3/LUqUQKXGdFVGbkeKwRc9NpQnmtA7G0MZxBQicV0
 jXAHancUwfnl0mGVOD0fmOeynKXeShjH24Q22nvnp6vZxWbdnabtSl3vieQRRV7bvuRv
 psPvdU41xNmiu9FZJpc3fIhBfHk0t8D+qHHYve+YgiCvvGv0Lpj7RbgEESbHGeRCDLyi
 UC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745397779; x=1746002579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08hGVKvJljLPuQk7wEdoyKrFGTlDytmnWY6SeLup23w=;
 b=O14L/a2oOZ4RrX1vn9SBs+BOV89SRrGF+DgYp8QdHmV44GIaKTdOV6O0e0Spm/k4bF
 2Kb2zp682WbhXusyARflB0QZwkDpQn7xiC6GyvUgC5+5QjuWSoIIjYk3tBgSrT3Q1GAB
 4TWHKZl4dNe/ZniHPtBo5n4m5b4SGxkvHqlUxyo8+kmEvW+cc8+TEDSWAxjVc4X2i2iH
 zwcDKKXNg8egyF+exXweFhdU4C81NEb2mYNec4gHtCZIjEn4TI36eHl6TXLx5WZhiRBe
 tu3D3Q7n+tonXV394yqDdeVdc0VoV+zXJVdwqQjm3fKGsrOjzpsJK2HxoZatItEv/V2C
 PRQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbFQ7l4do26RSJ90vMH94HKsBi4KQZVsmIoC6rHSyZuwx1kZ2Ev5C1aTnLzFj/XWM8kEYgEfg=@lists.denx.de
X-Gm-Message-State: AOJu0YyGzrUZxpJTXqXbgDvvCbJv6lA/si863en79F/U3+8gT+2pSR8u
 VE/JLeka58BD0fsu92IVBREeakJ0NIXJaj3l5pwzE3btMtPSRL7lSlsugzWnarw=
X-Gm-Gg: ASbGnctB9ccpXIrzBeaWSnODO/3mNNsAMqK5cOD22Fg+vClul7kcROxBq2v8mVNBREf
 bmfHDZhV4zIp6Xl0COdn76zdeNPW6as5t8E+oqSyeMPH2db4bcGH+oT2IXY47kH4daRNMGYxKHf
 XEIQJDCB1v9V/A9K3eeWEyiWJWwwwuWE6SJfQ/jpdZBOnpV6ZXwKyAOLarL6yXcUuU5CYvJ6Q/Q
 eQa5AbaQaVkugZp0aSVvXifpSzGImcZt4CmFrS+EM9H9N6fBofCjCAftdyQiwmuYj9B+V30Z2/C
 /gS9TrCHWzoN7rnghfB409lXjesine2njCrpvIDS8wjKaACGvXBp/tKNZWkTwwqMIZJFoEa3G9X
 1wGw=
X-Google-Smtp-Source: AGHT+IFL+w1e7G65fZYaHOjICKgj3aM3fEsfwNHTjnZ5f5cAsWFvtAnqzalvV0GSzolRUxW6ESWNnQ==
X-Received: by 2002:a17:903:3d07:b0:223:668d:eba9 with SMTP id
 d9443c01a7336-22c53568411mr336445705ad.10.1745397778907; 
 Wed, 23 Apr 2025 01:42:58 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdae69sm98860085ad.1.2025.04.23.01.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 01:42:58 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 3/3] board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing
Date: Wed, 23 Apr 2025 01:42:49 -0700
Message-Id: <20250423084249.197101-4-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423084249.197101-1-sbellary@baylibre.com>
References: <20250423084249.197101-1-sbellary@baylibre.com>
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

On AM335x EVM[1],
1. pin AM335X_ECAP0_IN_PWM0_OUT is used to enable the
backlight. ECAP0 can be configured in single channel PWM mode.
If CONFIG_PWM_TI_ECAP is enabled, perform eCAP0 pin muxing.

2. Pins LCD_DATA0 - LCD_DATA15, gpmc_ad8 - gpmc_ad15 and
lcd_vsync, lcd_sync, lcd_ac_bias_en, lcd_pclk are used for driving LCD.
If CONFIG_AM335X_LCD is enabled, perform the LCD pin muxing.

This is required to enable splash screen support on AM335x EVM.
[1] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 board/ti/am335x/mux.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
index 960de15398f8..a359d1d6b2b4 100644
--- a/board/ti/am335x/mux.c
+++ b/board/ti/am335x/mux.c
@@ -274,6 +274,47 @@ static struct module_pin_mux uart3_icev2_pin_mux[] = {
 	{-1},
 };
 
+#if (IS_ENABLED(CONFIG_AM335X_LCD))
+static struct module_pin_mux lcd_pin_mux[] = {
+	{OFFSET(lcd_data0), (MODE(0))},		/* LCD-Data(0) */
+	{OFFSET(lcd_data1), (MODE(0))},		/* LCD-Data(1) */
+	{OFFSET(lcd_data2), (MODE(0))},		/* LCD-Data(2) */
+	{OFFSET(lcd_data3), (MODE(0))},		/* LCD-Data(3) */
+	{OFFSET(lcd_data4), (MODE(0))},		/* LCD-Data(4) */
+	{OFFSET(lcd_data5), (MODE(0))},		/* LCD-Data(5) */
+	{OFFSET(lcd_data6), (MODE(0))},		/* LCD-Data(6) */
+	{OFFSET(lcd_data7), (MODE(0))},		/* LCD-Data(7) */
+	{OFFSET(lcd_data8), (MODE(0))},		/* LCD-Data(8) */
+	{OFFSET(lcd_data9), (MODE(0))},		/* LCD-Data(9) */
+	{OFFSET(lcd_data10), (MODE(0))},	/* LCD-Data(10) */
+	{OFFSET(lcd_data11), (MODE(0))},	/* LCD-Data(11) */
+	{OFFSET(lcd_data12), (MODE(0))},	/* LCD-Data(12) */
+	{OFFSET(lcd_data13), (MODE(0))},	/* LCD-Data(13) */
+	{OFFSET(lcd_data14), (MODE(0))},	/* LCD-Data(14) */
+	{OFFSET(lcd_data15), (MODE(0))},	/* LCD-Data(15) */
+	{OFFSET(gpmc_ad15), (MODE(1))},		/* LCD-Data(16) */
+	{OFFSET(gpmc_ad14), (MODE(1))},		/* LCD-Data(17) */
+	{OFFSET(gpmc_ad13), (MODE(1))},		/* LCD-Data(18) */
+	{OFFSET(gpmc_ad12), (MODE(1))},		/* LCD-Data(19) */
+	{OFFSET(gpmc_ad11), (MODE(1))},		/* LCD-Data(20) */
+	{OFFSET(gpmc_ad10), (MODE(1))},		/* LCD-Data(21) */
+	{OFFSET(gpmc_ad9), (MODE(1))},		/* LCD-Data(22) */
+	{OFFSET(gpmc_ad8), (MODE(1))},		/* LCD-Data(23) */
+	{OFFSET(lcd_vsync), (MODE(0))},		/* LCD-VSync */
+	{OFFSET(lcd_hsync), (MODE(0))},		/* LCD-HSync */
+	{OFFSET(lcd_ac_bias_en), (MODE(0))},	/* LCD-DE */
+	{OFFSET(lcd_pclk), (MODE(0))},		/* LCD-CLK */
+	{-1},
+};
+#endif
+
+#if (IS_ENABLED(CONFIG_PWM_TI_ECAP))
+static struct module_pin_mux ecap_pin_mux[] = {
+	{OFFSET(ecap0_in_pwm0_out), (MODE(0))},         /* ecap0_in_pwm0_out */
+	{-1},
+};
+#endif
+
 #if defined(CONFIG_NOR_BOOT)
 void enable_norboot_pin_mux(void)
 {
@@ -389,6 +430,12 @@ void enable_board_pin_mux(void)
 			configure_module_pin_mux(mmc1_pin_mux);
 			configure_module_pin_mux(spi0_pin_mux);
 		}
+
+		if (IS_ENABLED(CONFIG_AM335X_LCD))
+			configure_module_pin_mux(lcd_pin_mux);
+
+		if (IS_ENABLED(CONFIG_PWM_TI_ECAP))
+			configure_module_pin_mux(ecap_pin_mux);
 	} else if (board_is_idk()) {
 		/* Industrial Motor Control (IDK) */
 		configure_module_pin_mux(mii1_pin_mux);
-- 
2.34.1

