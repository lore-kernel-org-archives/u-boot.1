Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1527EE95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD18E86F88;
	Sun,  8 Oct 2023 01:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ltVSNLln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727C586EC6; Sun,  8 Oct 2023 01:14:53 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582BB86F1E
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35135b79b6aso13494885ab.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720403; x=1697325203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2CdtAnI3hL6CqaQfkPBop3ToDaRjFDzyLHkyRcZei0=;
 b=ltVSNLlnsdt7Pbw+4IvFx9BL4MlZyBIrHvJmVPblUyzHUu72GcfsLIa6hGWBO7Jiep
 9cqTzgHXiP8nFk8mbGuJFfmDsZ/oSpAR9bzF5/KElIO2pT/2xk5eS7yJRJ1bwkaRPqcg
 fbV7CnQiCuCj0qBXE+0auY+716fl5sFKSfkI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720403; x=1697325203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e2CdtAnI3hL6CqaQfkPBop3ToDaRjFDzyLHkyRcZei0=;
 b=X3aPVKbOIPc4zqsdpemJlN2srAZznxSS+EiSWHOmcJ4qPTXcxDUDPQUozgvVs7WUMM
 KY0Yw+kofWlPxnMMG7ybgREQrcbRszCNmCGOpuDbXwNDHvbRHyHG1+1bWnu8Ygb/Dfzd
 nQSGL/Yxszk5QgBy+o7VgBfoFlEUe/lfHq+MMTSiHmabJKnssgYPKpT69a/Cd9Gpz3Sf
 NR9sl46A0/Qedo374Vrh/A/JbQxSvATnOIYtHxGQN5cm0VimfwPYYJr26pI6yCuKpJQ9
 zsv1kvV+ZIofmrVYnWpJrQRUe55pifYSzns/R1FfXfHp9uBH1VZmHjU5rMzUjO7EG2lz
 BerA==
X-Gm-Message-State: AOJu0Yz81bVybpm2kT1NGfh1wkMpaawGJyXzXjlwGIJsvryo6TFPHkWi
 bXGia3fJRMBbFZt7uIzIXN8QouryPeLquxUTlUk=
X-Google-Smtp-Source: AGHT+IFV26HcGWqz/82VCLqAFaXyfnUpYr+/Qw9zfeHlwE8Yjo7ZuLLLpVYaQJDaGmbxNkf9HHlSyg==
X-Received: by 2002:a92:cdad:0:b0:34c:c0ad:69e0 with SMTP id
 g13-20020a92cdad000000b0034cc0ad69e0mr15470014ild.1.1696720402947; 
 Sat, 07 Oct 2023 16:13:22 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/27] cmd: Make all commands depend on CMDLINE
Date: Sat,  7 Oct 2023 17:12:42 -0600
Message-ID: <20231007231255.277623-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

 cmd/Kconfig | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c952b2e286cd..0a8c3e07242a 100644
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
@@ -567,7 +559,6 @@ menu "Environment commands"
 
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
2.42.0.609.gbb76f46606-goog

