Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D77C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 20:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6878129F;
	Wed, 19 Mar 2025 21:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h4MTe3K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD5B81CC5; Wed, 19 Mar 2025 21:25:27 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7229C8193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 21:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fd89d036so149749055ad.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742415923; x=1743020723;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rh5g2SsSoJW5x0eqnBTy1KqRtOqymTlg5NBVyE8KxZ8=;
 b=h4MTe3K1Zshck7/PMxSX7Lfcjt9vaHJQ6X3TferQ0yTzXOTuGOK94Pb7dGSDOTRzAx
 v2qf5bgKcJgCkm7DhC9/Tu/G5M0CCw2e856YK9GeL97Va7RvxhDeVz49lL9GrKoNSqwe
 fM8oRn8pcCZ29bfGMiELMVoUEe5HHFjLFfsiM0yg9yVT2cYgJ2UY96TTFoiC4RBfpa/N
 IwCplSQYtoBlJpMPrepXUv4I9Oy7kqskE+XcwSJqknovLY1nxHa6y6BwRthgxQcdSG4y
 Pq4eFH7hUigdWub0bgm7P2TAB81xCHf5GJ9MbU4OT602EuFl1XlbwgQNoK/wMKwcTF2U
 6gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742415923; x=1743020723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rh5g2SsSoJW5x0eqnBTy1KqRtOqymTlg5NBVyE8KxZ8=;
 b=PVoxVtYLOUP9AvdjvdsAMTfYvzzeYTvLFhcd0Bn4hEry3UJLe8odzRkVzI/2if5kja
 f1WzInMFpArG4vqcqin6OfXzmdC4UFOacjLRxXA0ecof5EruezzCXFcpoHpqOEfcyxOX
 Z+EZPUwMC89AuDWz6arJQScTaXO6PriS3qCZYKX3vm48iT+EfXGb0lztCp/4Aq43/0Fu
 SvfhcZc3Z810uea/aiP2QaNefJ6BfvwnciKdCIog+NLLXDPYf3iHTfRgrzikVXRfKIJT
 amXdSDep4kP0WHPT+jRl1IxdltDJNCgjxMDJ3f8Mx98aWBgQkB7FT2DCpIyISnpHZmRC
 17XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNtDcZ04DmA3BorcEjmDq9X+KudENeb2d/OygXyeZQWR5abYQrWX6lhbU2ZW4+/ZCiKvGuo7E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4fiF3Mxqi32jlES3uUPsinlPCG183MClOxj40WAmh/YaKkZGF
 7zrrKS1c8y5vhmlgKqjzDF6zDnb09f0fETTAhCg7k/DiAeM7tI6etFIXHtquj2g=
X-Gm-Gg: ASbGnctonyr1E89gEf71HUSnjYzRm0rvfYIVT4TfuU+iK2bwJZMOxVNhViwGamST2Xz
 WUY54e4UP4pz/1JOH9D1zP2PdEWvXXERgThdjVdB0mI7PLXJ2sNs5c4Sl9k0mrzB+dXlEF0qOoh
 dOsShuXJ1xqFIjxAz4QPHnO4TkcW/1PVZJPDobOUel6YXPN01xssMoE54xF5MXC4ktARxqMpCkc
 934mqRlys4rAHi9pCOrr9Jg64FAHFQvlsqZ5AJ1M0vHGGSLZtWBzTcHZKmSlKFry5CtuL+xohrA
 mTaCxlY/t8Xae5+fQmTChas2vJPVGbqMhDkWf2aNBtX5ObqnNiP5vJ0Vnx0TO/DDBn7SVHJlnBk
 FzQI1Nx2qnK7ZMVcSVg==
X-Google-Smtp-Source: AGHT+IHJDCZt+dsXUCQkuaCPo1TRxUrxdN8tcJXwHydSlipEKP1W0WV3DL3eslN6LFFpPfauII2K3A==
X-Received: by 2002:a05:6a00:1885:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-7376d70bb8cmr6587934b3a.20.1742415922924; 
 Wed, 19 Mar 2025 13:25:22 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com.
 [76.88.115.8]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73730ca057csm8886757b3a.48.2025.03.19.13.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:25:22 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 2/3] board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing
Date: Wed, 19 Mar 2025 13:25:15 -0700
Message-Id: <20250319202516.3300444-3-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319202516.3300444-1-sbellary@baylibre.com>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
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
 board/ti/am335x/mux.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
index 960de15398f8..b661731a038d 100644
--- a/board/ti/am335x/mux.c
+++ b/board/ti/am335x/mux.c
@@ -274,6 +274,47 @@ static struct module_pin_mux uart3_icev2_pin_mux[] = {
 	{-1},
 };
 
+#if IS_ENABLED(CONFIG_AM335X_LCD)
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
+#if IS_ENABLED(CONFIG_PWM_TI_ECAP)
+static struct module_pin_mux ecap_pin_mux[] = {
+	{OFFSET(ecap0_in_pwm0_out), (MODE(0))},         /* ecap0_in_pwm0_out */
+	{-1},
+};
+#endif
+
 #if defined(CONFIG_NOR_BOOT)
 void enable_norboot_pin_mux(void)
 {
@@ -389,6 +430,14 @@ void enable_board_pin_mux(void)
 			configure_module_pin_mux(mmc1_pin_mux);
 			configure_module_pin_mux(spi0_pin_mux);
 		}
+
+		#if IS_ENABLED(CONFIG_AM335X_LCD)
+			configure_module_pin_mux(lcd_pin_mux);
+		#endif
+
+		#if IS_ENABLED(CONFIG_PWM_TI_ECAP)
+			configure_module_pin_mux(ecap_pin_mux);
+		#endif
 	} else if (board_is_idk()) {
 		/* Industrial Motor Control (IDK) */
 		configure_module_pin_mux(mii1_pin_mux);
-- 
2.34.1

