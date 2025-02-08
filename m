Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49258C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC7A808E6;
	Sat,  8 Feb 2025 18:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQ49uYuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3BB8091B; Sat,  8 Feb 2025 18:12:19 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085B5808AF
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so246865239f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034735; x=1739639535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhJ/hDdKERamCZNf/GiMGXxgE1833ikc7oG+RhHJaeM=;
 b=HQ49uYuNvaIT3IpQxDWb7E1SC8BeRIcof7cAgspgu+1ECJvpKne4smBjgGSWL33/aA
 Sm6F80orynTGRq0AXcoKjLFR0/xinNaMn8vlg8Ch9n5OzFZTLNzS+AmjdqM/W6s+xqSI
 MEmiLJ1xzbTql4CD50Qtzha5HG7PuM0MtJHi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034735; x=1739639535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhJ/hDdKERamCZNf/GiMGXxgE1833ikc7oG+RhHJaeM=;
 b=oTHZeimW8vwyFzG+PXIY8WkQLTqxSTpBs3TFcLaud31qDvYPWksAEvNz+0FavqfddA
 qZJTotRqohwbcQ7rWPBJpkyrhOa2/SAJHIIPlhiFI+M0oB3eIwrDeiAe9TeBC2L9B5Qc
 joLAZYqKkkD7HNy5MXIGBv2JAAE0EICvxQw8bkZMzyfYpJuXJCmyplexez9Q3V3Bqlxg
 0+GFjy035KulAY182bcvOUk9Xk0G0r+hyvYybwDTSxnTJaNGO/cFeuhEJRhlnWhRl9T9
 KD32+LH5AT7XYcvrIt+V0f3tm++pl3dnxB8YNRavMIAWY8btG0dhe0H801epIFZT1XX5
 j3cw==
X-Gm-Message-State: AOJu0YzwGKMDS/TILo+dV60yJeJLR3IhFuXSvrKP6xua2raelZILQXf9
 cofuUIKLVr4MF4MgneCGzwsyvTfjLXKupw9cm3Cz7TuvsP5lLZyBF277C6jvuu2nUFZtPifFTxo
 =
X-Gm-Gg: ASbGncvjy+ZhWSdcFyWIR64SewwxmLRya0yFYX9CkWpeeTzfPDCFMzchj3lmslQ4E+U
 a+CpK3jdWeB4WFhrZx0EDKAd3xkGTEPqUnrW2GPTHvASudzYYb48YOCUI+VdOR8FWJBhbk3h5gE
 jAEaPGBtbk5Bjp5iBqWTrO586DxRZL/aRJpe6p9UDRx0fDT7kWhGD+9InV6xuI7aOrhFP2j8fJs
 3pNPcadrkov11laT69ILIlfc/h0Z+5OUh+JlamKAwl8g2PMS1Zi9pFuSSe4GmTn07NiChqNghNO
 q/6Cl6AykhJs5Aili3AXxTWqFBUj3I1kKMaBS0LuKnPIXvCAEoRd
X-Google-Smtp-Source: AGHT+IF6SjKvqM/iKz3ozbfTAEcCPQYBDlz4U4Q+yUsJMMuRNOTnbZ3wU4cI4eDYbfpC06VoyOiHXg==
X-Received: by 2002:a05:6602:6a46:b0:841:950b:386d with SMTP id
 ca18e2360f4ac-854fd888feemr757184239f.3.1739034735246; 
 Sat, 08 Feb 2025 09:12:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 05/29] efi: Rename app and payload to include x86
Date: Sat,  8 Feb 2025 10:11:25 -0700
Message-ID: <20250208171154.1305761-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

