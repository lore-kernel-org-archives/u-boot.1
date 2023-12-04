Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3EEC10DC3
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8880887884;
	Mon,  4 Dec 2023 01:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I62TzyxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6639987873; Mon,  4 Dec 2023 01:32:36 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336D4878D1
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d7e56f6845so2117869a34.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649953; x=1702254753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqoXB8lT0tftj0t5t3BJmz83h389O8r4EXr4ZrAh7E4=;
 b=I62TzyxO+XcspHHNgrhEdsPoPVvkxkMnj9N81XT5q6nUfrnjOIivn/khgpeUFBwXVr
 BYnmC2TbYoAlrp4Wc4NHaKFjKJv0uskKq4TB6/zsHWVFDac4ZzjDTpYwrWyXZ0AR3kSc
 EXemUjYFiSC/x77SrfVmCsuS6DAyrD5uDLujY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649953; x=1702254753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqoXB8lT0tftj0t5t3BJmz83h389O8r4EXr4ZrAh7E4=;
 b=FzxYmh/p+OAtNvpWSQ0TQtpw4zSKldk2TEBtNnQ6x3k13rKqJbVgIpy8lVcz+8N+xX
 fkXBEsFbqYtpLl3rDuqDvk9w7tTz2x+Owbt4NTwbcaeZf1sh4+xZ9mmNsDBl2SrxksJ8
 JMQE5X7KjD5CyUArD8K28sbcPKakij2Ic0E/ZZrmiHQr909yE55DNWMnI1uC1h/eV1id
 d5f7lRT9KpPi2vcHM/RVTYSvxG1NznFiJyHfczGVKrSX9c1DNwC/senWa2lkeT1XqHmh
 qPc7ui1DpVr5esZ8lTPCdfdIWB2qGYMSWPrRLsStEqreCKC8teTv47TK8suHjQSbiEIL
 YUJQ==
X-Gm-Message-State: AOJu0Yw1j1TbYjAfO3DFCCVle8fnWygaQWZGF1MqHHCPHOw53AdkzoJ0
 6OKVE6cQJs+2bbGVBpxhtpN1UajgEv7HcgIiqhgUSA==
X-Google-Smtp-Source: AGHT+IHWmmPRLiX4eP26a1Tkiolh5Q9Zm+6fT87la4A8hMHg6XEH0POHcKL5Qhotr10qxr+ZzTKsSQ==
X-Received: by 2002:a05:6871:2306:b0:1fb:1373:c883 with SMTP id
 sf6-20020a056871230600b001fb1373c883mr3700399oab.64.1701649952754; 
 Sun, 03 Dec 2023 16:32:32 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 03/14] bootm: Make OS booting dependent on BOOTM
Date: Sun,  3 Dec 2023 17:31:27 -0700
Message-ID: <20231204003144.899097-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

Booting an OS does not require the 'bootm' command, so change the
condition for these options.

Move them into boot/ so they don't depend on CMDLINE

Note that CMD_BOOTM_PRE_LOAD has been put directly into the bootm code
so will need some additional refactoring (and a test!) to allow it to
change over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/Kconfig  | 49 -------------------------------------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8b32a51f7e7c..9fa8789bc2b1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -689,6 +689,55 @@ config BOOTM
 	  This option should normally be enabled. It is used to implement the
 	  'bootm' command.
 
+config BOOTM_LINUX
+	bool "Support booting Linux OS images"
+	depends on BOOTM || CMD_BOOTZ || CMD_BOOTI
+	default y
+	help
+	  Support booting the Linux kernel directly via a command such as bootm
+	  or booti or bootz.
+
+config BOOTM_NETBSD
+	bool "Support booting NetBSD (non-EFI) loader images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting NetBSD via the bootm command.
+
+config BOOTM_OPENRTOS
+	bool "Support booting OPENRTOS / FreeRTOS images"
+	depends on BOOTM
+	help
+	  Support booting OPENRTOS / FreeRTOS via the bootm command.
+
+config BOOTM_OSE
+	bool "Support booting Enea OSE images"
+	depends on (ARM && (ARM64 || CPU_V7A || CPU_V7R) || SANDBOX || PPC || X86)
+	depends on BOOTM
+	help
+	  Support booting Enea OSE images via the bootm command.
+
+config BOOTM_PLAN9
+	bool "Support booting Plan9 OS images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting Plan9 images via the bootm command.
+
+config BOOTM_RTEMS
+	bool "Support booting RTEMS OS images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting RTEMS images via the bootm command.
+
+config BOOTM_VXWORKS
+	bool "Support booting VxWorks OS images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting VxWorks images via the bootm command.
+
 config ANDROID_BOOT_IMAGE
 	bool "Android Boot Images"
 	default y if FASTBOOT
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 74e1950e51fc..758e817e2eae 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -291,48 +291,6 @@ config CMD_BOOTI
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
 
-config BOOTM_LINUX
-	bool "Support booting Linux OS images"
-	depends on CMD_BOOTM || CMD_BOOTZ || CMD_BOOTI
-	default y
-	help
-	  Support booting the Linux kernel directly via a command such as bootm
-	  or booti or bootz.
-
-config BOOTM_NETBSD
-	bool "Support booting NetBSD (non-EFI) loader images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting NetBSD via the bootm command.
-
-config BOOTM_OPENRTOS
-	bool "Support booting OPENRTOS / FreeRTOS images"
-	depends on CMD_BOOTM
-	help
-	  Support booting OPENRTOS / FreeRTOS via the bootm command.
-
-config BOOTM_OSE
-	bool "Support booting Enea OSE images"
-	depends on (ARM && (ARM64 || CPU_V7A || CPU_V7R) || SANDBOX || PPC || X86)
-	depends on CMD_BOOTM
-	help
-	  Support booting Enea OSE images via the bootm command.
-
-config BOOTM_PLAN9
-	bool "Support booting Plan9 OS images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting Plan9 images via the bootm command.
-
-config BOOTM_RTEMS
-	bool "Support booting RTEMS OS images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting RTEMS images via the bootm command.
-
 config CMD_SEAMA
 	bool "Support read SEAMA NAND images"
 	depends on MTD_RAW_NAND
@@ -349,13 +307,6 @@ config CMD_VBE
 	  is used to boot. Updating the parameters is not currently
 	  supported.
 
-config BOOTM_VXWORKS
-	bool "Support booting VxWorks OS images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting VxWorks images via the bootm command.
-
 config CMD_BOOTEFI
 	bool "bootefi"
 	depends on EFI_LOADER
-- 
2.43.0.rc2.451.g8631bc7472-goog

