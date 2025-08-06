Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD3C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1641C84308;
	Wed,  6 Aug 2025 16:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U//HOk2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F320A842FD; Wed,  6 Aug 2025 16:56:56 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05AA3842F3
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-619b164c0b9so5714eaf.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492213; x=1755097013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peSePiIQQs/qw3ZsqJ72OJt+e0eLS8kvHixld93w3g0=;
 b=U//HOk2tK8uWVNaRwgEdFTMwCA/tDgNA2yb1IeEPAondPtYaZcdneYVk8vllyoFa1p
 /2ihbVQbMynDJZ0YoHwi3YfNUIENKOD15Qi6ZtS8VjMAWQ1XGGcRYqR4aQbB7yUcW/oj
 r/173C5Xe8rcXGdJpH6bKxZ9FHrYEG5N6G/ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492213; x=1755097013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peSePiIQQs/qw3ZsqJ72OJt+e0eLS8kvHixld93w3g0=;
 b=lrMvpKYRj3v8H6OxmAsnfUlgufEsjyqSIHQkxJJiZ87pSGy/0/I7qzQjz96p5r+zAS
 +dlXAbuU/QjB7cQ/Tf9LTi0axkLogIWa/lJ6e+8CQKbQaoAx2cPHQBJu8mGsmAr8negv
 Iti2wZgVZmAZV3grIXqW4GQ4W4v6TkLPIubd5mcxC9BPa/IR+r5Y4W+JJpbv/zM2OGB5
 qWlAPCvk8r2gciDvVNbpkjfNxuEcAaM78Yi6y5SETZ94e32OhqIPVFTQZJyEf3/J5FZT
 0fubgtaFd0FGjLgkBEQ7D4kHZmSSEg1VN2eIHnRTmZxWWlzq4UTGOTBAo5fdf2yg+Ode
 l7ow==
X-Gm-Message-State: AOJu0Yzv4WEXYconBNPSxvLdtKVvH5JB98R3/vnabqdBi61vpXpcCdGy
 5SBwiyh2o2GhLQys1XqoSj25aCicCOGyyCjFTNtO95YKbYxPbYI5yh/L9ggA1Lgo1H3i/atjkl2
 GHRIrgo8=
X-Gm-Gg: ASbGncuCJb6H+DawcO1ofU+VQckb1QGVu0UH6CaX+y9YNByGp9XcCYuTqSd8ciuYC04
 1FOVzddeL/lJY5+J4Mr543nEs6zSVhw8pCXgseRvAAg/p9TS7koTuZWxZ9d8FLU45RtvtdV3LgX
 WM3j3JH+GaaPBeIkM8WaJ4KYDROByOgs9A2i5EWWOO5yJOJL+mMI0eKZl3WmyMmgcYJ84rAmJ55
 fZVv+2wgaCW8/4GS/82pNktroEsKN24tQvsuKXWd+lvzMdgi6oIKnSp5r074lH5Gb4YVKCuue1b
 wMqP04H3QE4zSKzln7yijAf+LjbhvVkkmGBMUFWzt+76Pop2lLeYtBw5HxIm8wQuHPLYixHnkBz
 PhRAHOI9BGVTLmvEqDorVLj4SaUi7ugSU8xDkpw5Je4QnB5QD3w8arF25E+8=
X-Google-Smtp-Source: AGHT+IHIAnm81d6t5rR5cpkJur3DnNtHHapoXyD19wivaSEXtnzCfFUH8hW0mYUbyJKlrbmxZVlJoA==
X-Received: by 2002:a05:6820:1523:b0:613:90e1:729a with SMTP id
 006d021491bc7-61b5f80f9c8mr2049830eaf.4.1754492212670; 
 Wed, 06 Aug 2025 07:56:52 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6199c99b222sm1644790eaf.28.2025.08.06.07.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 3/8] video: tegra: Rework some of the driver dependencies
Date: Wed,  6 Aug 2025 08:56:44 -0600
Message-ID: <20250806145649.1664724-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145649.1664724-1-trini@konsulko.com>
References: <20250806145649.1664724-1-trini@konsulko.com>
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

Looking these drivers over, all of them cannot build without access to
some platform specific header files. Express those requirements in
Kconfig as well. Furthermore, update the logic a bit more to reflect
which parts are optional when other drivers are enabled and which parts
cannot be enabled (meaningfully) by themselves.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/star_defconfig      |  1 +
 drivers/video/tegra/Kconfig | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/configs/star_defconfig b/configs/star_defconfig
index 38cbdec1c3a0..1547f724f062 100644
--- a/configs/star_defconfig
+++ b/configs/star_defconfig
@@ -89,4 +89,5 @@ CONFIG_VIDEO_LCD_LG_LH400WV3=y
 CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA=y
 CONFIG_BACKLIGHT_AAT2870=y
 CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_TEGRA=y
 CONFIG_TEGRA_8BIT_CPU_BRIDGE=y
diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
index f32972d937e5..8bc29f2838bd 100644
--- a/drivers/video/tegra/Kconfig
+++ b/drivers/video/tegra/Kconfig
@@ -1,10 +1,12 @@
 config HOST1X_TEGRA
-	bool "NVIDIA Tegra host1x BUS support"
-	depends on SIMPLE_BUS
+	bool
+	select SIMPLE_BUS
+	help
+	  NVIDIA Tegra host1x BUS support
 
 config VIDEO_TEGRA
 	bool "Enable Display Controller support on Tegra devices"
-	depends on OF_CONTROL
+	depends on OF_CONTROL && ARCH_TEGRA
 	select HOST1X_TEGRA
 	help
 	   Enable support for Display Controller found in Tegra SoC. The
@@ -17,7 +19,7 @@ config VIDEO_TEGRA
 
 config VIDEO_DSI_TEGRA
 	bool "Enable DSI controller support on Tegra devices"
-	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO && ARCH_TEGRA
 	select VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
@@ -27,7 +29,7 @@ config VIDEO_DSI_TEGRA
 
 config VIDEO_HDMI_TEGRA
 	bool "Enable HDMI support on Tegra devices"
-	depends on VIDEO_BRIDGE && DM_I2C
+	depends on VIDEO_BRIDGE && DM_I2C && ARCH_TEGRA
 	select I2C_EDID
 	select VIDEO_TEGRA
 	help
@@ -36,16 +38,14 @@ config VIDEO_HDMI_TEGRA
 
 config TEGRA_BACKLIGHT_PWM
 	bool "Enable Tegra DC PWM backlight support"
-	depends on BACKLIGHT
-	select VIDEO_TEGRA
+	depends on BACKLIGHT && VIDEO_TEGRA
 	help
 	   Enable support for the Display Controller dependent PWM backlight
 	   found in the Tegra SoC and usually used with DSI panels.
 
 config TEGRA_8BIT_CPU_BRIDGE
 	bool "Enable 8 bit panel communication protocol for Tegra 20/30"
-	depends on VIDEO_BRIDGE && DM_GPIO
-	select VIDEO_TEGRA
+	depends on VIDEO_BRIDGE && DM_GPIO && VIDEO_TEGRA
 	select VIDEO_MIPI_DSI
 	help
 	   Tegra 20 and Tegra 30 feature 8 bit CPU driver panel control
@@ -54,6 +54,7 @@ config TEGRA_8BIT_CPU_BRIDGE
 
 config VIDEO_TEGRA124
 	bool "Enable video support on Tegra124"
+	depends on ARCH_TEGRA
 	imply VIDEO_DAMAGE
 	help
 	   Tegra124 supports many video output options including eDP and
-- 
2.43.0

