Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF23C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C471287CF9;
	Fri, 19 Jan 2024 18:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRGjTeF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213F287D24; Fri, 19 Jan 2024 18:25:44 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A43787CF5
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bc23738beaso54389b6e.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705685140; x=1706289940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TMuKzKgO07zkHGBhT5HamJkCdLxRUbM6j1aNel1iIcQ=;
 b=FRGjTeF+8HNWRgpk2dWIZx216qDDbJ71ImarWxJarnwQjCadnBBB2eBOI+fALjNfKp
 +CwrWIHWWY4fdX5MulA4N1Jve/SnF96FvT8oXZyo8bKvlFhBC4jCXrXUZqks8ByLkgJX
 +dOSZuRAt/UIybG4uqUrgUpkt1oFHh7g1vrzjNdAkWXyqy/fux45ZXbEGdqjJUK9T2K3
 +ekYE3Yotf454f7ZqYP8bVFSRcadBOfdxs8+zQkXUboAPoa0MqPevHQjedwEM0hPioH2
 e1tKlvITaQAFSkmhHEcflc9usEqr3AvhqpRNx7QZGpESaEH6mZPXwD7fwWqIOl5DS0Mk
 eIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705685140; x=1706289940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TMuKzKgO07zkHGBhT5HamJkCdLxRUbM6j1aNel1iIcQ=;
 b=w8Nz0s0yOxhRkOcGwiVENVGewHa5GAYdInozqc3kEowIthDch39QzenkDg8/wtyMQU
 lVOkYgrpPbp3T9CXaA3fBmvKC+jhbDo2FDw+OzGqRx40rpjSVCusUsE8lO0E9uu389rZ
 ZRp3lllG+G1p2k1AIqCV0zYjW2ezATvsz5qGXXanzzvqauhhFQ6tG25B0y0fkZ6KwjA8
 jvVhZQOF4qWKyBC7kG3lMNQYEzbAAwfe+mCEvzs0kNKOs1+UriXnHO01FtkT9OBUIFol
 oxnVY/wEaRO91HLXa87K21O56yGAISrhids9zh3CntA+KGFSopZ2ZyIvCz5YEk6fewhx
 zt5A==
X-Gm-Message-State: AOJu0YybtMnyW7OdrRr/eUMr/I5bzgEnJ2KSlnx9kyJwqnWqcJns0C/p
 TwhIFm+FnYBX5I44uGIDapqd5Hw3qDKwltmiKrETqMXSijAe5z9szTh+Fcke
X-Google-Smtp-Source: AGHT+IFC/LkFpd/JhvNSDxwIWuBGCvycwPDFZVhL+W4BqGIoPC20tUwKSDCGBtgrPhf9Pm2CxL5JKw==
X-Received: by 2002:a05:6808:150a:b0:3bd:a49e:b63e with SMTP id
 u10-20020a056808150a00b003bda49eb63emr126455oiw.3.1705685140500; 
 Fri, 19 Jan 2024 09:25:40 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a173:61bc:3362:89aa])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a056808011800b003bd4237b300sm670902oie.35.2024.01.19.09.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 09:25:40 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] wandboard: Convert to watchdog driver model
Date: Fri, 19 Jan 2024 14:25:33 -0300
Message-Id: <20240119172533.653865-1-festevam@gmail.com>
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/imx6qdl-wandboard-u-boot.dtsi | 10 ++++++++++
 configs/wandboard_defconfig                |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx6qdl-wandboard-u-boot.dtsi b/arch/arm/dts/imx6qdl-wandboard-u-boot.dtsi
index 46c4b3b31f4a..80921e80123f 100644
--- a/arch/arm/dts/imx6qdl-wandboard-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-wandboard-u-boot.dtsi
@@ -6,4 +6,14 @@
 	aliases {
 		mmc0 = &usdhc3;
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
+&wdog1 {
+	bootph-pre-ram;
 };
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index 168e2f086008..e9deab38038f 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -75,6 +75,8 @@ CONFIG_DM_PMIC_PFUZE100=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_VIDEO=y
@@ -88,3 +90,4 @@ CONFIG_IMX_HDMI=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

