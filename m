Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E403ACDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424D78747C;
	Thu, 19 Oct 2023 17:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OhCQLVEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9142887436; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9208C8725A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7af45084eso103418177b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727678; x=1698332478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RuBlM41tPdXb89yBAXTFbLd9eqhlSwYh2NtQbaxUX8=;
 b=OhCQLVEAqtpDj7wZom8kUMlX/oV4e9GCh0co6gd51lCOWi1ZjyKrI9ozgVWKVZi4M1
 U891rj8fRR1HKYwW23GiUiqb16cw4RQd+osdwdQKFqIRrYkf/mvb0GGg9t9h1MC0OvDf
 jNlT8q+p+LEeu5+7r6W7gJgCcegcUXES0SBNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727678; x=1698332478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RuBlM41tPdXb89yBAXTFbLd9eqhlSwYh2NtQbaxUX8=;
 b=mI6FrZ2U6RwYWUS6fqxfhSWBVCH3+xOG0Itwpa9mpDKsS6t+IY2TcQOC6G3Hg1oYJj
 EwFiVjFGtxw0O9cbHDCWs/rrox2qGBBG7hPPM4o22Oun+NkM0lFdVdHdb03Ws24PA4U0
 Zh4LDeBnVmpW0j67yUTnUD98wH17qDSPcoIlE2k35TK4GKZcLpLzdNhA0hngtdgFlDy4
 fX1kRH941DgrqWPTJpyKLds+DqZzoh3iuxtqTVpUtE4IsOjOawOeSHcKdWmSrUYmvb69
 UmEhFE6AHxI3hZtSxW+aVUOzx9mnV22SBhrFLMjR4N/iyd9V9vF7UtLE//9pLC5G70o1
 s8zQ==
X-Gm-Message-State: AOJu0Yxz8XLBOPVWL3w7mJ2rL2R30EJezN04OEu6W727N2yLMLvyDXFn
 OPVDmqZzzhR56WZ+WBUJ+iLAilGPrZe7ZqiVTQmD/g==
X-Google-Smtp-Source: AGHT+IFeBKJbIJMdjjQAev6Rd3u+JIhQbIWLD8Hc7oWPWsfU4nl1FQs5SSCAcWELal0+sI67J5Ca+g==
X-Received: by 2002:a81:6cc9:0:b0:59f:7fb9:621a with SMTP id
 h192-20020a816cc9000000b0059f7fb9621amr2529903ywc.22.1697727678107; 
 Thu, 19 Oct 2023 08:01:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Date: Thu, 19 Oct 2023 11:00:52 -0400
Message-Id: <20231019150105.714407-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

The command should not be used to enable library functionality. Add a
new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
same code is built.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Changes in v4:
- Integrate AKASHI Takahiro's feedback from v3
- Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
---
 cmd/Kconfig             | 11 ++++++++++-
 lib/efi_loader/Kconfig  |  6 +++---
 lib/efi_loader/Makefile |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 16e5cb8f0633..872cb49150cc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -379,6 +379,15 @@ config CMD_BOOTEFI
 	help
 	  Boot an EFI image from memory.
 
+config CMD_BOOTEFI_BOOTMGR
+	bool "UEFI Boot Manager command"
+	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
+	default y
+	help
+	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
+	  This subcommand will allow you to select the UEFI binary to be booted
+	  via UEFI variables Boot####, BootOrder, and BootNext.
+
 config CMD_BOOTEFI_HELLO_COMPILE
 	bool "Compile a standard EFI hello world binary for testing"
 	depends on CMD_BOOTEFI && !CPU_V7M
@@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
 config CMD_EFICONFIG
 	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
 	default y if !HAS_BOARD_SIZE_LIMIT
-	depends on CMD_BOOTEFI_BOOTMGR
+	depends on BOOTEFI_BOOTMGR
 	select MENU
 	help
 	  Enable the 'eficonfig' command which provides the menu-driven UEFI
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6dba4..13cad6342c36 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -32,14 +32,14 @@ config EFI_LOADER
 
 if EFI_LOADER
 
-config CMD_BOOTEFI_BOOTMGR
+config BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager"
 	default y
 	select BOOTMETH_GLOBAL if BOOTSTD
 	help
 	  Select this option if you want to select the UEFI binary to be booted
-	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
-	  'bootefi bootmgr' command.
+	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
+	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
 
 choice
 	prompt "Store for non-volatile UEFI variables"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8d31fc61c601..0a2cb6e3c476 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -42,7 +42,7 @@ targets += initrddump.o
 endif
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
-obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += efi_bootmgr.o
+obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
 obj-y += efi_boottime.o
 obj-y += efi_helper.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
-- 
2.34.1

