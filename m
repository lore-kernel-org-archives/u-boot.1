Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479DDC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBCB87B90;
	Thu, 26 Oct 2023 20:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kL9OE6mC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D791087B5B; Thu, 26 Oct 2023 20:31:57 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D952687641
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ce37d0f1a9so763301a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345113; x=1698949913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J8iRd02341ZQdgxQo3hwYJbTVXYRRNfrSN3IVwCidv0=;
 b=kL9OE6mCFYA1rZzaPKOtS9hnJulUHbVNWwEv3Niv+VeKkr8O9Ed6OScX1IzHBRJx8N
 M2SX/U9CwXSt/aBnq3Qg6CkEbCq/2ZQu2Qh76nyOeli6fzf5FoxlBCnreLsZR+aB1RlC
 V0Uve4WB1XOlPIQQphAKyOFu8hptAmKFmwODA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345113; x=1698949913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8iRd02341ZQdgxQo3hwYJbTVXYRRNfrSN3IVwCidv0=;
 b=GeJhWVUaVgZkmwvdyrWbgDsFzOmnnnukek0fK9WVUmCQx8UlwkMSf49DG/rEWWSxht
 DIHb27wFLLG+2XgpRejhrIluJjvKrgz13zGfuQrMO/+P4Ali6YgXuLp2MaPVX6b/k2Kr
 ZeleqFtQXXNYCs5EWiJTHE0kuOif0jlJWtokAFldpOqadDHtFeKFjj8Vd5GvnCGx8bBr
 AY0JR3JZwspDgjkhpUmdphOl+JcfbyvZL4AzBqtln2sYm6dB+2D+Wyv8GrTxyz57OFxB
 KEsTvBQ8/5vRCOQ5neLFKbsWIaeJxvWknoePNHaEg9CHu8jwaIyEKaIBXS9KaGUmNGZv
 E3Vw==
X-Gm-Message-State: AOJu0Yw3ozZj7ADGM9PGHBxGK2jP/3zakQIC46S0wX9pTRfiq7SxFi+c
 O4mp+x1Ke4aVp7SaJlqSmRHumDQeWCg9FeTyXDmY5A==
X-Google-Smtp-Source: AGHT+IHFz5TzECoThgqGSdue2HRCwzMqvHy3PtEvxv0zBWk47TfQyQB2so8EegOiEGYTqAtfrvMZLQ==
X-Received: by 2002:a05:6871:a310:b0:1e9:9c04:9ca4 with SMTP id
 vx16-20020a056871a31000b001e99c049ca4mr528369oab.41.1698345113291; 
 Thu, 26 Oct 2023 11:31:53 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 16/30] boot: Rework BOOT_DEFAULTS to allow for CMDLINE to be
 disabled
Date: Thu, 26 Oct 2023 14:31:24 -0400
Message-Id: <20231026183138.636948-16-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

We split BOOT_DEFAULTS to have BOOT_DEFAULTS_FEATURES and
BOOT_DEFAULTS_CMDS that in turn list general features or commands that
we want enabled when BOOT_DEFAULTS is selected.  We only select
BOOT_DEFAULTS_CMDS if CMDLINE is set.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2075ecd34b1f..88b9296ee1bf 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -346,8 +346,16 @@ config PXE_UTILS
 	help
 	  Utilities for parsing PXE file formats.
 
-config BOOT_DEFAULTS
-	bool  # Common defaults for standard boot and distroboot
+config BOOT_DEFAULTS_FEATURES
+	bool
+	select SUPPORT_RAW_INITRD
+	select ENV_VARS_UBOOT_CONFIG
+	imply USB_STORAGE
+	imply EFI_PARTITION
+	imply ISO_PARTITION
+
+config BOOT_DEFAULTS_CMDS
+	bool
 	imply USE_BOOTCOMMAND
 	select CMD_ENV_EXISTS
 	select CMD_EXT2
@@ -358,14 +366,14 @@ config BOOT_DEFAULTS
 	select CMD_DHCP if CMD_NET
 	select CMD_PING if CMD_NET
 	select CMD_PXE if CMD_NET
-	select SUPPORT_RAW_INITRD
-	select ENV_VARS_UBOOT_CONFIG
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
 	imply CMD_MII if NET
-	imply USB_STORAGE
-	imply EFI_PARTITION
-	imply ISO_PARTITION
+
+config BOOT_DEFAULTS
+	bool  # Common defaults for standard boot and distroboot
+	select BOOT_DEFAULTS_FEATURES
+	select BOOT_DEFAULTS_CMDS if CMDLINE
 	help
 	  These are not required but are commonly needed to support a good
 	  selection of booting methods. Enable this to improve the capability
@@ -431,7 +439,6 @@ config BOOTSTD_FULL
 config BOOTSTD_DEFAULTS
 	bool "Select some common defaults for standard boot"
 	depends on BOOTSTD
-	imply USE_BOOTCOMMAND
 	select BOOT_DEFAULTS
 	select BOOTMETH_DISTRO
 	help
-- 
2.34.1

