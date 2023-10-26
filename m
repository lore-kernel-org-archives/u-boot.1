Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879F2C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 21:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A746587642;
	Thu, 26 Oct 2023 23:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFat7GLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A5687654; Thu, 26 Oct 2023 23:02:10 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3201087641
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 23:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cacbd54b05so2461875ad.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698354124; x=1698958924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ikk9jsd2XcsknmM+TKJCi1Yg0Skv9YS08RCRP3cV0o=;
 b=ZFat7GLCsHVQSgmwi0Fa54RMgz7EUdVPrxjLTG6eTgbEIci9ne8XsK/TruSSw/JWM8
 JHyZz8mZDts8kHd8X99F/qXdk94Ya9pS70byswHhoFfWbL7omoYT/UT/hBUnI1r7BYO7
 kBInTK3lK66fC1OIPYtCML4NOGfXMnOPfIKrYTBe2ANg8bH9HUCv7Rmban4PZO2REAdK
 +1IQvZQ88NxWYLB5dFGfPlpT990/tj2ClUZAUZJm/RMzCPHIIa67hccxVMg2ylPbd/M8
 x3y0y4eSL/MYzUw5xzMD9N2WZWM4BGP3B7TJ1d8/aBNdqLlrMX3oJU0R5EmYH1gqv80s
 hSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698354124; x=1698958924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ikk9jsd2XcsknmM+TKJCi1Yg0Skv9YS08RCRP3cV0o=;
 b=pcYCBggjH7plyCD701b71VEDC82Q3dn0KJhqtbc2038VtRKL2pRzObLzaO/kvkDmiM
 HWbrXmADCMZSDwYENzX1Dk2CqjUXzO9WhqR1vMEoCdNvkmGSulCr6umUvo/WTLzM/91G
 IKbtHI690xRti7v5QVfDia7ztJHTjWd+qTwzqgjWJt0Z52sSLEYtWDCucv5cKoc51e4s
 nxK8qFLIwt0Iea/Qh+PwZxq1qskBFhHMDC0k36lV0AbSbiBYs5PlgNQNSSUuZ4/TFlnp
 p6fqmGnboAm4yuhxBFvWhsB/sf1ypA+haNwJLIeSvNxpKh9BR5OrEnSq2991ArEuf50s
 bhCA==
X-Gm-Message-State: AOJu0YyohbyYJYVF+DDUIYKBW2Vcv/hEi3XpWnKsqNydd+Sb8HIxYeGa
 npQHu89uQtYfLDMeBKXKqEE6jd5IAXE=
X-Google-Smtp-Source: AGHT+IHN0jNH4wMP4AWtdayCokq3kFaBqxo9BD3r1sTmeRwE25TPv1tPNfKSPBmZZ5tT/fXGL98cBg==
X-Received: by 2002:a17:902:e906:b0:1c0:bf60:ba82 with SMTP id
 k6-20020a170902e90600b001c0bf60ba82mr690617pld.5.1698354124156; 
 Thu, 26 Oct 2023 14:02:04 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:eeea:a81:8d4:d6a5])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a170902a41200b001c5fd2a28d3sm120980plq.28.2023.10.26.14.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 14:02:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] pico-pi-imx7d: Convert to watchdog driver model
Date: Thu, 26 Oct 2023 18:01:53 -0300
Message-Id: <20231026210153.26886-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx7d-pico-pi-u-boot.dtsi | 10 ++++++++++
 configs/pico-pi-imx7d_defconfig        |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
index 843b4583e53a..c6856823c64d 100644
--- a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
@@ -6,6 +6,12 @@
         usb0 = &usbotg1;
         display0 = &lcdif;
     };
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &usbotg1 {
@@ -45,6 +51,10 @@
 	};
 };
 
+&wdog1 {
+	bootph-pre-ram;
+};
+
 &iomuxc {
 	pinctrl_backlight: backlight {
 		fsl,pins = <
diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 48364c7548ee..5b615daf4a87 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -76,6 +76,8 @@ CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PFUZE100=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -95,3 +97,4 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

