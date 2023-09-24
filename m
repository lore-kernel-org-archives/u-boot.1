Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BECCE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5DE86C42;
	Sun, 24 Sep 2023 22:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lj4i2726";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4415D86BE1; Sun, 24 Sep 2023 22:40:43 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209B286BF4
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79fa425855cso126022539f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588039; x=1696192839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSrQGh2DXmOLXUWEJ1Qj1lNXc4xtDY4JgWswuDSfCvk=;
 b=lj4i27263oQ0Uv9ZPg+gDWPwsuDgqOYRU4O4AK4s4zgGPtH2w+feaNd0t48dA9RXXg
 1PH7TSoSI8p6ml5usrqhiXELo3EN2zVtea197fYVl1JAFvCrbkgPb2iw1AzOZetKIkzK
 2tNjHh2d2dr+n/SfZpQICvGyU3O7aKXhy/fzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588039; x=1696192839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSrQGh2DXmOLXUWEJ1Qj1lNXc4xtDY4JgWswuDSfCvk=;
 b=drFa2BLPBVmnZLzR/WEIeDK2JN4N+0L+2RXF+lS4es8VEY2l65QAMm7uLmNx73BnM7
 Q7Muxel7MQf8zhijJoSQ1N7djZufr2rAcewxuSVziSPftSQqZF8IMTCfTkfNaMeiaFoS
 U3AyjqZ5inYmX+OjOmErZ8gLFhz57Nj8eAj1FfXdJBTvrplzAvFCR7+vy+G585ZZMj7t
 uHUS8AuavjoCEE13SlRJ0gIFjZAZjDMSZ7ydQa4zBc65knu32eSLJovGfTVcQMM80Goh
 p4olUNd7hM3oyn9GNr1cy+/4zh38TfyELfDgX6Clr878SlgHopEuay2ijS+i4cAeG/M4
 VEvQ==
X-Gm-Message-State: AOJu0Yxv6ZCV3ZumVNE1GcW3P4B+x4zsrz4iz9ypICLCfwefvgo6COZm
 Kzyb0dnLxiG+BNPdiren65Amrjr+gI9jKFNPf7M=
X-Google-Smtp-Source: AGHT+IHhhHjjwRXKnjkzrUb7WjwVcqLdNh3or8A1BjFpra+QXSqwqRXQWUGK+YYecEgDXh3TB5ORKQ==
X-Received: by 2002:a5d:8051:0:b0:792:82f8:749d with SMTP id
 b17-20020a5d8051000000b0079282f8749dmr5551661ior.10.1695588039666; 
 Sun, 24 Sep 2023 13:40:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 23/25] cmd: Make all commands depend on CMDLINE
Date: Sun, 24 Sep 2023 14:39:41 -0600
Message-ID: <20230924203953.1829820-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

 cmd/Kconfig | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c3428d19f31d..7aa689e91f6f 100644
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
 	help
 	  Enable U-Boot's command-line functions. This provides a means
@@ -11,9 +9,10 @@ config CMDLINE
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
@@ -25,7 +24,6 @@ config HUSH_PARSER
 
 config CMDLINE_EDITING
 	bool "Enable command line editing"
-	depends on CMDLINE
 	default y
 	help
 	  Enable editing and History functions for interactive command line
@@ -40,15 +38,13 @@ config CMDLINE_PS_SUPPORT
 
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
@@ -86,8 +82,7 @@ config SYS_CBSIZE
 
 config SYS_XTRACE
 	bool "Command execution tracer"
-	depends on CMDLINE
-	default y if CMDLINE
+	default y
 	help
 	  This option enables the possiblity to print all commands before
 	  executing them and after all variables are evaluated (similar
@@ -219,7 +214,6 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
-	depends on CMDLINE
 	default y
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
@@ -409,7 +403,6 @@ source lib/efi_selftest/Kconfig
 
 config CMD_BOOTMENU
 	bool "bootmenu"
-	depends on CMDLINE
 	select MENU
 	select CHARSET
 	help
@@ -476,7 +469,6 @@ config CMD_GO
 
 config CMD_RUN
 	bool "run"
-	depends on CMDLINE
 	default y
 	help
 	  Run the command in the given environment variable.
@@ -572,7 +564,6 @@ menu "Environment commands"
 
 config CMD_ASKENV
 	bool "ask for env variable"
-	depends on CMDLINE
 	help
 	  Ask for environment variable
 
@@ -1687,7 +1678,6 @@ if NET
 
 menuconfig CMD_NET
 	bool "Network commands"
-	depends on CMDLINE
 	default y
 	imply NETDEVICES
 
@@ -1991,7 +1981,6 @@ config CMD_ETHSW
 
 config CMD_PXE
 	bool "pxe"
-	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via network using PXE protocol
@@ -2126,7 +2115,6 @@ config CMD_EFICONFIG
 
 config CMD_EXCEPTION
 	bool "exception - raise exception"
-	depends on CMDLINE
 	depends on ARM || RISCV || SANDBOX || X86
 	help
 	  Enable the 'exception' command which allows to raise an exception.
@@ -2227,14 +2215,12 @@ config CMD_SOUND
 
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
@@ -2883,4 +2869,5 @@ config CMD_MESON
 	default y
 	help
 	  Enable useful commands for the Meson Soc family developed by Amlogic Inc.
-endmenu
+
+endif # CMDLINE
-- 
2.42.0.515.g380fc7ccd1-goog

