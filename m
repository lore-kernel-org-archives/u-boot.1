Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E918C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6060284312;
	Wed,  6 Aug 2025 16:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YRsYbaTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB92842F3; Wed,  6 Aug 2025 16:56:57 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E4483A9A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-742f798bb20so8191a34.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492214; x=1755097014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rd3Sl9aIlBKxHTyYFdKdFKvrO/1I3lFd19CiwnTwZnk=;
 b=YRsYbaTzo97mr0/LRF3VhzTSQRRxJLa2T6facYg+AoqA7LlTwRmAlJRAClMSIcsXu/
 ZE/uHBW8exzzgn3HPHxkt8COlstxNEpDq35nZzv32zVrtKYnBDSlxO6S0gqxvYhfOqpp
 MiGyBfoEN6IKqf5rIp8i9yf99IVtkVkZDzzlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492214; x=1755097014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rd3Sl9aIlBKxHTyYFdKdFKvrO/1I3lFd19CiwnTwZnk=;
 b=WTWAnq0TIcuyRsnIfnKddR59Zi2kF8pmYhwKaGEAJFCk22KWPxtyNotk0yiMSl4Kpf
 hDoR9NeuPhEHBzww8GomeTEYyyNdwcRhAUGraJz3Cy9LrwrBfxB+k3KchblaiMeFPzrp
 GWH7YuagSrXPheiPVRBn48J87/JJgqIqDgTzQkQ6eoDHgRs/kR/ok1jG1A+ku7T/pN7z
 aQHi+pD9nF5mEOy7oZdT17ovpJz9k6xZEj3X5IOLhxoEBrW//8SWoxgCCYzKLieAVeCN
 ggAi27Y2xXgQ/O/m4MHkGyioJPWi9kYRqR+AgnG6lBmrLVCOPYCJSKvd9AYv5mrhdhmG
 C4/w==
X-Gm-Message-State: AOJu0YwMaKVJro5VFZCwy3E9I0qnh0F3JJAtRoYlFkZpdkDS1UZsbtIV
 IR7T4NbcjRlOMMHDvN/34uDbewZZwhAZ98hO99AHpd+0tzCrPh0gmrwElNWVmfUwyjxe4jdDflZ
 jNHk153E=
X-Gm-Gg: ASbGncvXyc1QFL8qJBE3sn3UUbwzp2eR36ZLc13qfjRF4DRpunC1zp3xLEqPIlg7BJQ
 KPkYPMjPr0F7fgUYbfwQnbOXVWNnWJ8TBlKwIy4THc2UvKewJw3I0k/o1lrVb2MhHbF1VR4M/DC
 BxhW0TkuYlg3KwA6BSm8M+7pfiWXqsJ01iifbLy4iXi98Lb3S1cTUxVsQ0o9LXBYnA0vu8OzEbU
 c0tlOpyFb2qpDscRgRIJDPJhkwUGWeG3wXJfthDa3nK9EUY5rQyd+5AjP+MIjBHQcOmkyVPI/Gq
 9BHUtsWOsZqsvz9wVfuZF+wPwFePm06ptLdBmUzDt4z0joiZOTyrDL55H+vC79ot1w8Qp7xAeL6
 OUz/41Ng0yorDfrc3sp2Z/9R9M6kDpmRs1M8w6F0A7kXlepld3GsvIoRtajA=
X-Google-Smtp-Source: AGHT+IF1fTAZl7BhDq0triZnowMbfVke7zwT4L2EbRvI2FBCzhMQNi2RjjAFugFFtfG1Gl7H2KpNBg==
X-Received: by 2002:a05:6830:719c:b0:741:908a:e968 with SMTP id
 46e09a7af769-74308cf70bdmr2107945a34.4.1754492213650; 
 Wed, 06 Aug 2025 07:56:53 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6199c99b222sm1644790eaf.28.2025.08.06.07.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCH 4/8] video: Tighten some video driver dependencies
Date: Wed,  6 Aug 2025 08:56:45 -0600
Message-ID: <20250806145649.1664724-4-trini@konsulko.com>
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

A few video drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
---
 drivers/video/Kconfig          | 4 ++++
 drivers/video/bridge/Kconfig   | 2 +-
 drivers/video/exynos/Kconfig   | 2 +-
 drivers/video/imx/Kconfig      | 1 +
 drivers/video/meson/Kconfig    | 2 +-
 drivers/video/rockchip/Kconfig | 2 +-
 drivers/video/stm32/Kconfig    | 1 -
 drivers/video/ti/Kconfig       | 1 +
 8 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 95da1b123e60..4ceb30d2a3af 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -523,6 +523,7 @@ config ATMEL_LCD_BGR555
 
 config VIDEO_BCM2835
 	bool "Display support for BCM2835"
+	depends on ARCH_BCM283X
 	imply VIDEO_DAMAGE
 	help
 	  The graphics processor already sets up the display so this driver
@@ -738,6 +739,7 @@ source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
 	bool "Armada XP LCD controller"
+	depends on ARCH_MVEBU
 	imply VIDEO_DAMAGE
 	---help---
 	Support for the LCD controller integrated in the Marvell
@@ -779,6 +781,7 @@ config NXP_TDA19988
 
 config ATMEL_HLCD
 	bool "Enable ATMEL video support using HLCDC"
+	depends on ARCH_AT91
 	imply VIDEO_DAMAGE
 	help
 	   HLCDC supports video output to an attached LCD panel.
@@ -881,6 +884,7 @@ source "drivers/video/imx/Kconfig"
 
 config VIDEO_MXS
 	bool "Enable video support on i.MX28/i.MX6UL/i.MX7 SoCs"
+	depends on MACH_IMX
 	imply VIDEO_DAMAGE
 	help
 	  Enable framebuffer driver for i.MX28/i.MX6UL/i.MX7 processors
diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index be53034bd3d4..bc91fe837d51 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -53,7 +53,7 @@ config VIDEO_BRIDGE_SOLOMON_SSD2825
 
 config VIDEO_BRIDGE_TOSHIBA_TC358768
 	bool "Support Toshiba TC358768 MIPI DSI bridge"
-	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO && !64BIT
 	select VIDEO_MIPI_DSI
 	select DM_I2C
 	help
diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfig
index a2cf752aac03..1fffec5c9c5e 100644
--- a/drivers/video/exynos/Kconfig
+++ b/drivers/video/exynos/Kconfig
@@ -1,7 +1,7 @@
 
 menuconfig VIDEO_EXYNOS
 	bool "Enable Exynos video support"
-	depends on VIDEO
+	depends on VIDEO && ARCH_EXYNOS
 	help
 	  Enable support for various video output options on Exynos SoCs.
 
diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
index 4a1927c66d7d..b35ba965efc3 100644
--- a/drivers/video/imx/Kconfig
+++ b/drivers/video/imx/Kconfig
@@ -23,3 +23,4 @@ config IMX_LDB
 
 config IMX_LCDIF
 	bool "i.MX LCDIFv3 LCD controller"
+	depends on MACH_IMX
diff --git a/drivers/video/meson/Kconfig b/drivers/video/meson/Kconfig
index fcf486ca0a3a..77c3017382eb 100644
--- a/drivers/video/meson/Kconfig
+++ b/drivers/video/meson/Kconfig
@@ -6,7 +6,7 @@
 
 config VIDEO_MESON
 	bool "Enable Amlogic Meson video support"
-	depends on VIDEO
+	depends on VIDEO && ARCH_MESON
 	select DISPLAY
 	imply VIDEO_DAMAGE
 	help
diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 0f4550a29e38..96af6d28ef0b 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -10,7 +10,7 @@
 
 menuconfig VIDEO_ROCKCHIP
 	bool "Enable Rockchip Video Support"
-	depends on VIDEO
+	depends on VIDEO && ARCH_ROCKCHIP
 	imply VIDEO_DAMAGE
 	help
 	  Rockchip SoCs provide video output capabilities for High-Definition
diff --git a/drivers/video/stm32/Kconfig b/drivers/video/stm32/Kconfig
index c354c402c288..ea4ce6799fda 100644
--- a/drivers/video/stm32/Kconfig
+++ b/drivers/video/stm32/Kconfig
@@ -7,7 +7,6 @@
 
 menuconfig VIDEO_STM32
 	bool "Enable STM32 video support"
-	depends on VIDEO
 	imply VIDEO_DAMAGE
 	help
 	  STM32 supports many video output options including RGB and
diff --git a/drivers/video/ti/Kconfig b/drivers/video/ti/Kconfig
index 3081e9e8c09b..0483f760ea19 100644
--- a/drivers/video/ti/Kconfig
+++ b/drivers/video/ti/Kconfig
@@ -4,5 +4,6 @@
 #
 config AM335X_LCD
 	bool "Enable AM335x video support"
+	depends on ARCH_OMAP2PLUS
 	help
 	   Supports video output to an attached LCD panel.
-- 
2.43.0

