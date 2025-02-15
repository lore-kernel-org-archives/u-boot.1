Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B658C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051BC80EE5;
	Sat, 15 Feb 2025 04:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SSGkc3aK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F1D80ECC; Sat, 15 Feb 2025 04:23:25 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB3980F30
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85521efa9b5so61964039f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589800; x=1740194600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReI2r2r986hQLOn9VLlqkQ/6Qk/zBNy5JwVcnfKG2OQ=;
 b=SSGkc3aKePmWmQqJJctmd9CzhWYY7P2cbY6Qa1U21X6D5ONPQA+PvVKek1x1IGpq1O
 J/yOdy1JeW+X24wXxqt7/08FcJw50Xieu0YJQBFrU6byBXrDwV8ce7Wx/H7AG+VZUdJd
 POnXDPJCUqd1vVPYtxMfBXGZiCj/y7XT8MLq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589800; x=1740194600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReI2r2r986hQLOn9VLlqkQ/6Qk/zBNy5JwVcnfKG2OQ=;
 b=tsygZBNp1wML58TIxJrxWgmpkkATzKt/Y+3xV7z909dfAu/j7Bt6gGNBwQmFNG5fos
 f4CRsUDvoNsCuu9JaZQR0P+tOotk5b9BhXSfEoR6y/JmdLPu3wcL5XzBa62KBaAb+kOc
 dkkkWdhzCI68HuA/aUgYALIwMZ2ALQP5d98Q2Q/R9cOed1xiEBHc2xl3dlaFTFjE/f53
 coerHb4RGJ1ddS71fZGFeHP+8H51LSGS0Vxe77spnR6K4lmWCbkKxXxKM39mafnX57La
 NOU/rT3Dn26JTZzhPtbcUZ5aX0HW7d1Mb83yzUeBUU8Mo8vxp6m802jHrsHoejGojcue
 0ubw==
X-Gm-Message-State: AOJu0YyaR3nKuB5R4ZhpgO5ygThw+F8LKy/zoj8A5aZqWszEa6q22ONw
 T0bJ46xiIzZk6H29Gz+nNSCh6t9Wxw9f1JSRAnel0lKLpXc3FCE1LjJa81VxPeqrkq1qKGgQfDo
 =
X-Gm-Gg: ASbGncu+ZXDyyUdfmapI3sLqzX5CJK48yMjuYR+usLsGXxHy95kt5ludjLDrfAPb36k
 0BP3IDLMXcA33HxBW0b77ISr1AQCySc7YD/9Z34AoPElxELJMn7k2KfBmi2tLRcfPW13BXJXTZv
 JFBnafanfrB2X+MNAG+OmNswExUWdt43AeLle9c7R6tMs6+dxJkSL9MUDlcQ7hvbpRq9oHAJOMt
 fRnuidh3jUiwG8dCbOJ5jvXGDyvX5vy8tN8nGrLhOFczhhFWAhEf8OEjGzTLWUlKceXH+BXqYBV
 1VZuJcsytCnyw+RHE4a8+24mH75LdIOuHn4m8651xqDnvGAoseqj
X-Google-Smtp-Source: AGHT+IHt4QKdJ3+kwKIMtI8Xn39QvS3mBJTlr4xeZDY+KxaDEM6eMlBxz/KBgvUahILk7PIxq8/EyQ==
X-Received: by 2002:a05:6e02:2411:b0:3d2:1206:cabe with SMTP id
 e9e14a558f8ab-3d28095152emr16267185ab.22.1739589800125; 
 Fri, 14 Feb 2025 19:23:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 05/29] efi: Rename app and payload to include x86
Date: Fri, 14 Feb 2025 20:22:26 -0700
Message-ID: <20250215032254.4121030-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

Since we plan to support the EFI app and payload on 64-bit ARM too,
rename the x86 target.

Adjust the Kconfig rules to allow non-x86 builds to be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Mention '64-bit ARM' here, rather than just 'ARM'

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

