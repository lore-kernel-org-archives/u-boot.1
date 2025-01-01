Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF30E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01888031D;
	Wed,  1 Jan 2025 23:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IDFVbGCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA2380317; Wed,  1 Jan 2025 23:10:48 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4343A800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-215770613dbso107600875ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769444; x=1736374244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvysklEbVG4qylSODwpJGD5okgd2FCNTVYdudFVbicc=;
 b=IDFVbGCfAu5TKUrBDUZTU2klvzqEV4uKuC/dF9onZvDhqtB4187n8J1CQWbq6brlv5
 SZekIeVhvUAXDAbp0uocCw5Z0J4swfznnovZfcIE7EjAd3sVqc/BpoFQtIhWnsTJkffZ
 qTgrVKLFp+H1QR/NtdNOhwCTvocG41WD3997A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769444; x=1736374244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvysklEbVG4qylSODwpJGD5okgd2FCNTVYdudFVbicc=;
 b=ZurFk3QvSkCvt990S/486hjaxMXSupfT33SHG/avBZDSn95DUk4+DvrVhjtyCxePgo
 FpJV80G95NpWbHj6QhdRfgngZ1/JOjs83fTlwn0KkNh0EufnsuRnOdHwsS/30pxs4Tcd
 70vgIpQmb452+YU9r/0SCLM85DSLnvHPnU5Glr8DQRttvZkmXLay5p0BOfDxdrkHQH1v
 30gQLwnL855eKAxHazOZnuIpwBQ2TQpeUqUJ4MqgOSQr4OFyMqGXu9S/BbonvmdQJyA1
 aH5Xbq2NEoOW9I5lJrXtwWsJXYLVgVE+ZnNP/mc8pHfQ9CEIyG6ab+0FqpkKRBexJxQs
 GKXQ==
X-Gm-Message-State: AOJu0YzTFHkZkuwTLEMJ/tV9qyI8xVt/Y+Fatkcu1JP5js8sIbO6gU9y
 Kd7A9lNYOqKqGw1t1iXozjevjsui1layalpEvV8RFGusEHNxq++x+JjRabGZ+YK0AESd7wMsaHc
 =
X-Gm-Gg: ASbGncuB6xygUjaCIdmgEYoxcADXewwNTVJJgqBRKF4NS49+dldXsP1XL5OVQIFW342
 wyG4O7WWkalXEbbOhunbD7ZJVI1GCQSP0KvYv1bdIL4EaaQUFCVHoU/kZUklROFa25AzVBmVVSD
 /PdW3+2TsrpSReBobi9uP4ueNX2B5rGRu1cQ/JdrRNACRqzzWk1D4jZq09m5OX+sGD2kJFPzZ+4
 HExbGcnpyY3PaW+XUiZ+IH5EtGFQ68p5csC9gpPdH+qyqYtGd0/9uM=
X-Google-Smtp-Source: AGHT+IG3fGU39oolCT8BW1Qh1YlwlU+GHP34svC/olyIm7B1oeWQc6DKS1MH/fWV0dFvN0cbjnGkRA==
X-Received: by 2002:a05:6a21:670b:b0:1dc:7907:6d67 with SMTP id
 adf61e73a8af0-1e5e081c8d0mr74305595637.40.1735769443834; 
 Wed, 01 Jan 2025 14:10:43 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:10:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/67] bloblist: Make BLOBLIST_ALLOC the default
Date: Thu,  2 Jan 2025 11:08:47 +1300
Message-ID: <20250101221003.1944600-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

We want to encourage people to use an allocated bloblist since it is
more flexible than a fixed one. Make this the default, being sure not to
change existing users.

The unit tests require BLOBLIST_FIXED so add a dependency in the
Makefile to avoid build errors.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Kconfig                         | 15 ++++++++-------
 configs/chromebook_bob_defconfig       |  1 +
 configs/chromebook_coral_defconfig     |  1 +
 configs/chromebook_kevin_defconfig     |  1 +
 configs/chromebook_samus_tpl_defconfig |  1 +
 configs/qemu-x86_64_defconfig          |  1 +
 test/common/Makefile                   |  4 ++++
 7 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index e8d89bf6eb9..a00387a4609 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1039,16 +1039,10 @@ if BLOBLIST
 
 choice
 	prompt "Bloblist location"
+	default BLOBLIST_FIXED if SANDBOX
 	help
 	  Select the location of the bloblist, via various means.
 
-config BLOBLIST_FIXED
-	bool "Place bloblist at a fixed address in memory"
-	help
-	  Select this to used a fixed memory address for the bloblist. If the
-	  bloblist exists at this address from a previous phase, it used as is.
-	  If not it is created at this address in U-Boot.
-
 config BLOBLIST_ALLOC
 	bool "Allocate bloblist"
 	help
@@ -1056,6 +1050,13 @@ config BLOBLIST_ALLOC
 	  specify a fixed address on systems where this is unknown or can
 	  change at runtime.
 
+config BLOBLIST_FIXED
+	bool "Place bloblist at a fixed address in memory"
+	help
+	  Select this to used a fixed memory address for the bloblist. If the
+	  bloblist exists at this address from a previous phase, it used as is.
+	  If not it is created at this address in U-Boot.
+
 endchoice
 
 config BLOBLIST_ADDR
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index decac2e1935..072311465d9 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -36,6 +36,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 0fb73049738..b1999b4ef20 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -44,6 +44,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BLOBLIST=y
 # CONFIG_TPL_BLOBLIST is not set
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x30000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 5bbea6c42a8..13c0998dbab 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -37,6 +37,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index fc524da5480..42337d7a11e 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0xff7c0000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 812b20687e5..f93721fceb8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -34,6 +34,7 @@ CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/test/common/Makefile b/test/common/Makefile
index 53c4f16164d..95bd00741a3 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,9 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
+
 ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+ifdef CONFIG_BLOBLIST_FIXED
 obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
 endif
+endif
+
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
-- 
2.43.0

