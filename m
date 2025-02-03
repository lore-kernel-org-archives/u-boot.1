Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2498BC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696D8807A7;
	Mon,  3 Feb 2025 18:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AwPQf7Dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEABD80137; Mon,  3 Feb 2025 18:43:30 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F86800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f314ff6ffdso2672253b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604606; x=1739209406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyeK4RIFxV1ugtlAH/BulJ0cWKijQypNRNhobMx5Y7g=;
 b=AwPQf7DmNCwl2tI0jUdoQd3Dzbtg+n8ivMnN77yXtk8quSf8UcuMnCLAMtP/630Q5o
 2q/uybj+HTfbSCbIYa5Zu1tSKM6Ud1nYgmXQA9UUf293dhW2ks97Ti4OPmB+xNugqcv1
 NHCuXqfc5SaUfw6OGhwQ2P0R5gj5+czQay0GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604606; x=1739209406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyeK4RIFxV1ugtlAH/BulJ0cWKijQypNRNhobMx5Y7g=;
 b=ZfJ2DiOA2VOaUD2kK1iZoG37NNcZxIY8XVZf8TsPh4X6rzUBT0I9fDGN35gi7fcm6K
 qqQgbTe5Mhs5GJY1YUQkYr7m2fgSgh4H0FYcG0yQrYjXtA7DnuxlV5K8/Qgd6w2eOkfJ
 fif9YdTg1q2tflzUthU8CLHl/GRXlsA5eyHCp6YpZDG2src71Z6VEQUSUVsOgjcQ/7Wi
 etke7/RdPQfLmUKUnJyIWCS17vPzOvYSlbyvq4s7gqhHKeKWfmtL8f5Ccx7o1xqjx0ax
 Yr9Y0kdhj11vsgfs31XUO1XyX/34wqo/jc0IsPZrn5DaUEhzAmT1HnHXdwZkR9pJyJ2y
 N+/Q==
X-Gm-Message-State: AOJu0YxS7LbJJ3KxlhpkATLPGzYUvzSNS75EjE7TN3vCDhKfg7C5Es3c
 MFuYyydFcROINFyiG6Mb74Yo0gLKAaZymGZvr5yNJ2/3JMeL4xVnrNrIqnz7Gw1/drJ4gIdQzT8
 =
X-Gm-Gg: ASbGnctAWR231UuvdV12wa2FIDihW44GK8Tb57wZTB+Cf8kh9vThUXSBydsPVCs+5fr
 jbou46x04FWTjCS5QNVIkvyKMdkmhtiyaNv5gztP/aph6TB0XCjJMrbWdJsVZAIRQZWopNQfB7w
 WAVowTT8aCySgVeq2wxNnqIyz+bj4+8pJT4Obvrr3mOgXT+ThjA2a8ynk4fFwr0S/w6wRA17CIO
 ZAglhIUMpkK/8hG2TjwXodkVlS/9hjUyR3NLGxpmLMYaGNX0dmA8EfbbnsboZwPzAk6T8aSM4AF
 4QJJ/o8PUuFEozU7iUl6pDfjepFzPvTkoUutmO8a81gBlmKdPec/
X-Google-Smtp-Source: AGHT+IHIGFzFznRVD+sJnrjhWuA4h5V/sJ4vcMN5fELFshIo3N1LcifKmM4USJGcV5dfHM95UFVJ5Q==
X-Received: by 2002:a05:6808:2010:b0:3e6:1513:4c04 with SMTP id
 5614622812f47-3f323a5cb04mr16015552b6e.20.1738604606668; 
 Mon, 03 Feb 2025 09:43:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/32] efi: Rename app and payload to include x86
Date: Mon,  3 Feb 2025 10:42:01 -0700
Message-ID: <20250203174245.1331464-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Since we plan to support the EFI app and payload on ARM too, rename the
x86 target.

Adjust the Kconfig rules to allow non-x86 builds to be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/efi/Kconfig                   | 12 ++++++++----
 board/efi/efi-x86_payload/Kconfig   |  2 +-
 configs/efi-x86_app32_defconfig     |  2 +-
 configs/efi-x86_app64_defconfig     |  2 +-
 configs/efi-x86_payload32_defconfig |  2 +-
 configs/efi-x86_payload64_defconfig |  2 +-
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 3df6e31c8ba..9027ca8482c 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -4,7 +4,7 @@ choice
 	prompt "Mainboard model"
 	optional
 
-config TARGET_EFI_APP32
+config TARGET_EFI_X86_APP32
 	bool "32-bit efi application"
 	select EFI_APP
 	help
@@ -13,17 +13,17 @@ config TARGET_EFI_APP32
 	  takes over once the RAM, video and CPU are fully running.
 	  U-Boot is loaded as an application from EFI.
 
-config TARGET_EFI_APP64
+config TARGET_EFI_X86_APP64
 	bool "64-bit efi application"
 	select EFI_APP
-	select X86_64
+	select X86_64 if X86
 	help
 	  This target is used for running U-Boot on top of EFI in 64-bit mode.
 	  In this case EFI does the early initialisation, and U-Boot
 	  takes over once the RAM, video and CPU are fully running.
 	  U-Boot is loaded as an application from EFI.
 
-config TARGET_EFI_PAYLOAD
+config TARGET_EFI_X86_PAYLOAD
 	bool "efi payload"
 	help
 	  This target is used for running U-Boot on top of EFI. In
@@ -33,7 +33,11 @@ config TARGET_EFI_PAYLOAD
 
 endchoice
 
+if X86
+
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
 endif
+
+endif
diff --git a/board/efi/efi-x86_payload/Kconfig b/board/efi/efi-x86_payload/Kconfig
index c500ca02ebf..d181bf6de09 100644
--- a/board/efi/efi-x86_payload/Kconfig
+++ b/board/efi/efi-x86_payload/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_EFI_PAYLOAD
+if TARGET_EFI_X86_PAYLOAD
 
 config SYS_BOARD
 	default "efi-x86_payload"
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index b20c85f1cff..bfcef9afa88 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_app"
 CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_VENDOR_EFI=y
-CONFIG_TARGET_EFI_APP32=y
+CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
 CONFIG_FIT=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 0988ad45205..8f1319c0b4c 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -6,7 +6,7 @@ CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_X86_RUN_64BIT=y
 CONFIG_VENDOR_EFI=y
-CONFIG_TARGET_EFI_APP64=y
+CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_DEBUG_UART=y
 CONFIG_EFI=y
 CONFIG_EFI_APP_64BIT=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 957fd83e432..48e757f629d 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -4,7 +4,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_EFI=y
-CONFIG_TARGET_EFI_PAYLOAD=y
+CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
 CONFIG_FIT=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 71612d7fb19..2606ac261c1 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -4,7 +4,7 @@ CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_EFI=y
-CONFIG_TARGET_EFI_PAYLOAD=y
+CONFIG_TARGET_EFI_X86_PAYLOAD=y
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_STUB_64BIT=y
-- 
2.43.0

