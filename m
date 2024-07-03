Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5142FC31D97
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 21:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC4C88875;
	Wed,  3 Jul 2024 23:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ez/KykmZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BFF88875; Wed,  3 Jul 2024 23:23:43 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A3BD886C3
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 23:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-702003e213eso3053576a34.3
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720041820; x=1720646620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YxuuXwFmqtZ7stiIy9auYrAaA5D09yCw96gIxHjFNi4=;
 b=ez/KykmZ+ExbbtiE4GlF6WVzDJf49z5G5CmP8ib7w/QoQuaS92r0bJ8vaEzgQHM086
 IhrPUNr5N6W7N6KIDtITFLeKgod4STDdj9yuOnCo7vFQ1zI/uuOgLJv4U8tCDGZzIZ9I
 g4tcMasBqTOQo4GtxHEgmDNx7+cpu/WAYTwZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720041820; x=1720646620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YxuuXwFmqtZ7stiIy9auYrAaA5D09yCw96gIxHjFNi4=;
 b=pcdhiV7Z9BF3QBQl6xPLWSCEjQPl44O3PoB1RP3KMDgK1UJfd2YD6/t/vOA4D/8tjl
 CadUBU3+8Tp0RurIjc4f087zWhMpAugTIo+AedsjAp21R82qkmaBIdWPDGZtWGMOpFmU
 JvKu/e6ns/tvbvgjI90mhuMhs/6st0LzWOSIfepdhoi8CgU01Vu6cv0/U8ARxwECTuy2
 GkYOa+PZCo0oGyGny6vs7l/cdsCEnd+UJEzpuT3K7Z+4pwsOMnZu+Sz4KYSlKuPQqij+
 QTfygvYAtuP3lxLSIeTmjywBfmojXKNc/a357uB3mzFzWzq47KDPW1Rja2Dx7OjZ78zQ
 HJ9w==
X-Gm-Message-State: AOJu0Yw44YNTH31FZXFiDUIbnNuYqQkoAMCax5LzzZjmGXW6/IlUfwoJ
 wAvRglm3sUjClllqY6ddq+MP3tk2cQhgrdNCj4N8lnNagjRLHIcQWoLSy0EHGcYPYN5d9F4aPvX
 J+g4=
X-Google-Smtp-Source: AGHT+IFtduKkfDIOQAmnvK1QFcn8PJ+0kJtfKnGJCCFvCP8Eq37dzfG+gga2vpiaaszz818hSVmv6w==
X-Received: by 2002:a9d:7f11:0:b0:702:10b5:8f5d with SMTP id
 46e09a7af769-70210b5a4b7mr10367606a34.35.1720041820280; 
 Wed, 03 Jul 2024 14:23:40 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7a99a58sm2098885a34.12.2024.07.03.14.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 14:23:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootstash: Do not provide a default address for all
Date: Wed,  3 Jul 2024 15:23:38 -0600
Message-Id: <20240703212338.1436606-1-trini@konsulko.com>
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

A valid memory location to stash bootstage information at will be
architecture dependent. Move the existing defaults to the main Kconfig
file for this option and set 0x0 as the default only for sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-stm32mp/Kconfig.13x | 3 ---
 arch/arm/mach-stm32mp/Kconfig.15x | 3 ---
 arch/arm/mach-stm32mp/Kconfig.25x | 3 ---
 boot/Kconfig                      | 4 +++-
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
index 4d74b35055b8..bc8b3f8cf77f 100644
--- a/arch/arm/mach-stm32mp/Kconfig.13x
+++ b/arch/arm/mach-stm32mp/Kconfig.13x
@@ -28,9 +28,6 @@ config PRE_CON_BUF_ADDR
 config PRE_CON_BUF_SZ
 	default 4096
 
-config BOOTSTAGE_STASH_ADDR
-	default 0xC3000000
-
 if BOOTCOUNT_GENERIC
 config SYS_BOOTCOUNT_SINGLEWORD
 	default y
diff --git a/arch/arm/mach-stm32mp/Kconfig.15x b/arch/arm/mach-stm32mp/Kconfig.15x
index d99aa9fd694a..42da36a73e85 100644
--- a/arch/arm/mach-stm32mp/Kconfig.15x
+++ b/arch/arm/mach-stm32mp/Kconfig.15x
@@ -86,9 +86,6 @@ config PRE_CON_BUF_ADDR
 config PRE_CON_BUF_SZ
 	default 4096
 
-config BOOTSTAGE_STASH_ADDR
-	default 0xC3000000
-
 if BOOTCOUNT_GENERIC
 config SYS_BOOTCOUNT_SINGLEWORD
 	default y
diff --git a/arch/arm/mach-stm32mp/Kconfig.25x b/arch/arm/mach-stm32mp/Kconfig.25x
index 2c0f691f8b54..7d2d8171845b 100644
--- a/arch/arm/mach-stm32mp/Kconfig.25x
+++ b/arch/arm/mach-stm32mp/Kconfig.25x
@@ -24,9 +24,6 @@ config PRE_CON_BUF_ADDR
 config PRE_CON_BUF_SZ
 	default 4096
 
-config BOOTSTAGE_STASH_ADDR
-	default 0x87000000
-
 if DEBUG_UART
 
 config DEBUG_UART_BOARD_INIT
diff --git a/boot/Kconfig b/boot/Kconfig
index 11175fb7bb26..6fb77b23f3c8 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1002,7 +1002,9 @@ config BOOTSTAGE_STASH
 
 config BOOTSTAGE_STASH_ADDR
 	hex "Address to stash boot timing information"
-	default 0x0
+	default 0xC3000000 if STM32MP13X || STM32MP15X
+	default 0x87000000 if STM32MP25X
+	default 0x0 if SANDBOX
 	help
 	  Provide an address which will not be overwritten by the OS when it
 	  starts, so that it can read this information when ready.
-- 
2.34.1

