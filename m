Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A39CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6953186F5F;
	Tue, 17 Oct 2023 00:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NnHOUDT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A2B803AE; Tue, 17 Oct 2023 00:32:54 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB7586EE3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77575233633so362630785a.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495567; x=1698100367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXFqehmLVhNeOJtN5biaVlaeQwlKgxrcWw0bs/J9Yis=;
 b=NnHOUDT0SBm8GplrpNO3vm8fjEwzdJ8MdSJgzryLyxMbs9KlHetlu6r17DpfYfybul
 O5B959dWBd/guYjA86AfZ8MqqkR5QPRbPwben44QUD3O0Gqdd1egOzBfTttkWlkRcu++
 GGTyD1ftrfeDml5LnVhvSXXDxGzpbjxD4E5Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495567; x=1698100367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXFqehmLVhNeOJtN5biaVlaeQwlKgxrcWw0bs/J9Yis=;
 b=iEGDK+IR3wcjAqpMMCihJatyYvVULeHhcFoiju3gW/XTE8mQ5zTfHKiFzCFxQLAkGv
 eHcOXjX+/2OTHXOTKo2sWm2DXfjqopw6bbqwLiIuEw6Zuo3W71y3G3HOeRTxUz3hIG03
 h2ChMBK4IlbAr0r/43GSbQEkUIzZo+Z5F1QTzNSJjdBHwzvMMiNWqujOprXjoMJl+wAv
 wLDVh1LU22DChc8hxwLQd7z9N3h8MVdHbRIuxhTzHAC9qwTdDYI2bw1lXmmR0UCtZqso
 kBEN//fjEx7mFkPwSEGzA8nkuAYZV1f4qUAvoMLUbdXKQz96RiSMRTlTe0/l+xrlYuOx
 N2Og==
X-Gm-Message-State: AOJu0YwAqpwyLX8d2m5YMqcnpvCMJMqlJtYvr1madp+9NAtX5ZQdAlkE
 QqmlxJJa9FcXwb52w1c3hAW+tkCW78h7CfOBt9txmg==
X-Google-Smtp-Source: AGHT+IF51mpIqxlYza5fdje81FL00tYA8Xs7OIwFIKzGbGfXsd4NdmEyh8irfvTiATg/DVZPtUd83w==
X-Received: by 2002:a05:620a:459e:b0:774:2e8f:2170 with SMTP id
 bp30-20020a05620a459e00b007742e8f2170mr616312qkb.4.1697495567031; 
 Mon, 16 Oct 2023 15:32:47 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:32:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 27/32] cmd: Make all commands depend on CMDLINE
Date: Mon, 16 Oct 2023 16:28:18 -0600
Message-ID: <20231016222835.596572-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

If this option is disabled, commands should not be available. Convert
the CMDLINE option into a menuconfig and make every command in
cmd/Kconfig depend on it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 491737ca8ba7..b6fdbc6ff3b1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1,7 +1,5 @@
-menu "Command line interface"
-
-config CMDLINE
-	bool "Support U-Boot commands"
+menuconfig CMDLINE
+	bool "Command line interface"
 	default y
 	select CLI_READLINE
 	help
@@ -12,9 +10,10 @@ config CMDLINE
 	  Depending on the number of commands enabled, this can add
 	  substantially to the size of U-Boot.
 
+if CMDLINE
+
 config HUSH_PARSER
 	bool "Use hush shell"
-	depends on CMDLINE
 	help
 	  This option enables the "hush" shell (from Busybox) as command line
 	  interpreter, thus enabling powerful command line syntax like
@@ -26,7 +25,6 @@ config HUSH_PARSER
 
 config CMDLINE_EDITING
 	bool "Enable command line editing"
-	depends on CMDLINE
 	default y
 	help
 	  Enable an editing function for interactive, command-line-input
@@ -52,15 +50,13 @@ config CMDLINE_PS_SUPPORT
 
 config AUTO_COMPLETE
 	bool "Enable auto complete using TAB"
-	depends on CMDLINE
 	default y
 	help
 	  Enable auto completion of commands using TAB.
 
 config SYS_LONGHELP
 	bool "Enable long help messages"
-	depends on CMDLINE
-	default y if CMDLINE
+	default y
 	help
 	  Defined when you want long help messages included
 	  Do not set this option when short of memory.
@@ -98,8 +94,7 @@ config SYS_CBSIZE
 
 config SYS_XTRACE
 	bool "Command execution tracer"
-	depends on CMDLINE
-	default y if CMDLINE
+	default y
 	help
 	  This option enables the possiblity to print all commands before
 	  executing them and after all variables are evaluated (similar
@@ -238,7 +233,6 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
-	depends on CMDLINE
 	default y
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
@@ -405,7 +399,7 @@ config SYS_BOOTM_LEN
 
 config CMD_BOOTEFI
 	bool "bootefi"
-	depends on EFI_LOADER && CMDLINE
+	depends on EFI_LOADER
 	default y
 	help
 	  Boot an EFI image from memory.
@@ -437,7 +431,6 @@ source lib/efi_selftest/Kconfig
 
 config CMD_BOOTMENU
 	bool "bootmenu"
-	depends on CMDLINE
 	select MENU
 	select CHARSET
 	help
@@ -504,7 +497,6 @@ config CMD_GO
 
 config CMD_RUN
 	bool "run"
-	depends on CMDLINE
 	default y
 	help
 	  Run the command in the given environment variable.
@@ -595,7 +587,6 @@ menu "Environment commands"
 
 config CMD_ASKENV
 	bool "ask for env variable"
-	depends on CMDLINE
 	help
 	  Ask for environment variable
 
@@ -1715,7 +1706,6 @@ if NET
 
 menuconfig CMD_NET
 	bool "Network commands"
-	depends on CMDLINE
 	default y
 	imply NETDEVICES
 
@@ -2019,7 +2009,6 @@ config CMD_ETHSW
 
 config CMD_PXE
 	bool "pxe"
-	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via network using PXE protocol
@@ -2154,7 +2143,6 @@ config CMD_EFICONFIG
 
 config CMD_EXCEPTION
 	bool "exception - raise exception"
-	depends on CMDLINE
 	depends on ARM || RISCV || SANDBOX || X86
 	help
 	  Enable the 'exception' command which allows to raise an exception.
@@ -2255,14 +2243,12 @@ config CMD_SOUND
 
 config CMD_SYSBOOT
 	bool "sysboot"
-	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via local extlinux.conf file
 
 config CMD_QFW
 	bool "qfw"
-	depends on CMDLINE
 	select QFW
 	help
 	  This provides access to the QEMU firmware interface.  The main
@@ -2911,4 +2897,5 @@ config CMD_MESON
 	default y
 	help
 	  Enable useful commands for the Meson Soc family developed by Amlogic Inc.
-endmenu
+
+endif # CMDLINE
-- 
2.42.0.655.g421f12c284-goog

