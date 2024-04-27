Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D9EC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1907288427;
	Sat, 27 Apr 2024 16:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lhgNjXL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BBD88429; Sat, 27 Apr 2024 16:11:30 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589C688407
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5aa400b917dso1997858eaf.0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227087; x=1714831887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4n0kxIn9F5AGJVNqtg7IEHiJq445KiIMtSa/+cb72Q0=;
 b=lhgNjXL0snAiCpAbZK+AGksU6MphtLgM5f1mnSkhZDDnRixrFynalejbD6F1Xcfuah
 d4AsIc1HRmaLhh1dWNSL4CemY86YBn5A0PyQ8zJnjK5Nyccpqv29pF4zDsIH1PMu1s4y
 WGSls5bNLCe8+snAcERrLWTGupG4Qm3pMGhg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227087; x=1714831887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4n0kxIn9F5AGJVNqtg7IEHiJq445KiIMtSa/+cb72Q0=;
 b=q/23OXPeYNENEjMZapJ9m4N5CNo8x7SWOoZZ+IyTbQs8Qndd+kiFD7/nA9uBjALhOO
 BcE90q5QOJxTV6pqm3eolBrm6OFcPPSifJ+MkY2zzHtmZnVSvhh/N+l8UmbQh/c7siWn
 j6oEXBTkbQ6C16NVt5jwcWPfvSgRnLYdO/1YIskRkCu8xPpTsOS6AM0ekpJEIqe8wHEI
 YcFyPt2STui5bVhXzlkTaYn6EocTTbHB3tpX6tZxKOUUFc2FutQCi9e2VMTXOaijBmXA
 NugruwkF99HG0Revh55g6syfcFg0YON+DOvtlogSjD+OPRFBDWOzAoKrzNg6WCpnjUts
 AKqg==
X-Gm-Message-State: AOJu0Yykkgy9k7kn8l8egu/zlsaI9t7MmlYwp2lw53h1wb3y906bdeRr
 b8hOXJvNtFQq/On4x3QT7YLGuQ3V0Aa+PcOFkJxxWVjBAkMxm0y4pfFOqCU+I0IqcYb7vE8611j
 mhxXWoA==
X-Google-Smtp-Source: AGHT+IGhP2FxLYmZC+lxKwluTKfkFZdc321vN3yhqJyuOIvX1VjmIvBwUxOeV0vfq9KnZLx7qhSOIw==
X-Received: by 2002:a05:6870:8995:b0:22e:a61f:d59b with SMTP id
 f21-20020a056870899500b0022ea61fd59bmr7292748oaq.33.1714227086800; 
 Sat, 27 Apr 2024 07:11:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 14/18] boot: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:02 -0600
Message-Id: <20240427141106.3406000-15-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all "boot/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/android_ab.c        | 1 -
 boot/boot_fit.c          | 1 -
 boot/bootdev-uclass.c    | 1 -
 boot/bootflow.c          | 1 -
 boot/bootflow_menu.c     | 1 -
 boot/bootm.c             | 1 -
 boot/bootm_os.c          | 1 -
 boot/bootmeth-uclass.c   | 1 -
 boot/bootmeth_cros.c     | 1 -
 boot/bootmeth_efi.c      | 1 -
 boot/bootmeth_efi_mgr.c  | 1 -
 boot/bootmeth_extlinux.c | 1 -
 boot/bootmeth_pxe.c      | 1 -
 boot/bootmeth_qfw.c      | 1 -
 boot/bootmeth_sandbox.c  | 1 -
 boot/bootmeth_script.c   | 1 -
 boot/bootretry.c         | 3 ++-
 boot/bootstd-uclass.c    | 1 -
 boot/cedit.c             | 1 -
 boot/common_fit.c        | 1 -
 boot/expo.c              | 1 -
 boot/expo_build.c        | 1 -
 boot/fdt_simplefb.c      | 1 -
 boot/fdt_support.c       | 1 -
 boot/image-android-dt.c  | 1 -
 boot/image-android.c     | 1 -
 boot/image-board.c       | 2 +-
 boot/image-cipher.c      | 1 -
 boot/image-fdt.c         | 1 -
 boot/image-fit-sig.c     | 1 -
 boot/image-fit.c         | 1 -
 boot/image-pre-load.c    | 1 -
 boot/image-sig.c         | 1 -
 boot/image.c             | 1 -
 boot/pxe_utils.c         | 1 -
 boot/scene.c             | 1 -
 boot/scene_menu.c        | 1 -
 boot/scene_textline.c    | 4 +++-
 boot/vbe.c               | 1 -
 boot/vbe_request.c       | 1 -
 boot/vbe_simple.c        | 1 -
 boot/vbe_simple_fw.c     | 1 -
 boot/vbe_simple_os.c     | 1 -
 43 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 1e5aa81b7503..143f373aae96 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017 The Android Open Source Project
  */
-#include <common.h>
 #include <android_ab.h>
 #include <android_bootloader_message.h>
 #include <blk.h>
diff --git a/boot/boot_fit.c b/boot/boot_fit.c
index 9d3941265636..4dcaf95c6ae3 100644
--- a/boot/boot_fit.c
+++ b/boot/boot_fit.c
@@ -7,7 +7,6 @@
  */
 
 #include <boot_fit.h>
-#include <common.h>
 #include <errno.h>
 #include <image.h>
 #include <log.h>
diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 46815ea2fdbf..7c7bba088c99 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <dm.h>
 #include <bootdev.h>
 #include <bootflow.h>
diff --git a/boot/bootflow.c b/boot/bootflow.c
index 68bf99329ab0..9aa3179c3881 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 16f9cd8f8ca5..143ef8413326 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootflow.h>
 #include <bootstd.h>
 #include <cli.h>
diff --git a/boot/bootm.c b/boot/bootm.c
index 032f5a4a1605..6fa8edab021e 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -5,7 +5,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <bootm.h>
 #include <bootstage.h>
 #include <cli.h>
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ccde72d22c17..15297ddb530b 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <bootstage.h>
 #include <cpu_func.h>
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 1d157d54dbdd..c0abadef97ca 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index f015f2e1c75f..645b8bed1020 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <blk.h>
 #include <bootdev.h>
 #include <bootflow.h>
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index aebc5207fc01..c7035c0d0c4e 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index b7d429f2c3da..23ae1e610ac7 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index ae0ad1d53e3f..9b55686948f7 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 70f693aa239b..03d2589c264f 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
index 8ebbc3ebcd58..dfaa944594e3 100644
--- a/boot/bootmeth_qfw.c
+++ b/boot/bootmeth_qfw.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <command.h>
 #include <bootdev.h>
 #include <bootflow.h>
diff --git a/boot/bootmeth_sandbox.c b/boot/bootmeth_sandbox.c
index aabc57e635a8..0bc8f688e30b 100644
--- a/boot/bootmeth_sandbox.c
+++ b/boot/bootmeth_sandbox.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 06340e43d2d7..0e05d28d4d9b 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/bootretry.c b/boot/bootretry.c
index 8d850df9d487..587b2de7d6b0 100644
--- a/boot/bootretry.c
+++ b/boot/bootretry.c
@@ -4,12 +4,13 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <env.h>
 #include <errno.h>
 #include <time.h>
+#include <vsprintf.h>
 #include <watchdog.h>
 
 static uint64_t endtime;  /* must be set, default is instant timeout */
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 81555d341e32..5de8efce19a5 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootflow.h>
 #include <bootstd.h>
 #include <dm.h>
diff --git a/boot/cedit.c b/boot/cedit.c
index 8c654dba6dc3..c29a2be14ce2 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_EXPO
 
-#include <common.h>
 #include <abuf.h>
 #include <cedit.h>
 #include <cli.h>
diff --git a/boot/common_fit.c b/boot/common_fit.c
index cde2dc45e907..a2f9b8d83c3b 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <image.h>
 #include <log.h>
diff --git a/boot/expo.c b/boot/expo.c
index cadb6a0ad6e3..ed01483f1d3a 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
-#include <common.h>
 #include <dm.h>
 #include <expo.h>
 #include <malloc.h>
diff --git a/boot/expo_build.c b/boot/expo_build.c
index 04d88a2c3081..a4df798adebd 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
-#include <common.h>
 #include <expo.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 837920bd3a33..53415548459a 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -6,7 +6,6 @@
  * Stephen Warren <swarren@wwwdotorg.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <asm/global_data.h>
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2bd80a9dfb18..874ca4d6f5af 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -6,7 +6,6 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <abuf.h>
 #include <env.h>
 #include <log.h>
diff --git a/boot/image-android-dt.c b/boot/image-android-dt.c
index fb014190d445..3b25018c2e77 100644
--- a/boot/image-android-dt.c
+++ b/boot/image-android-dt.c
@@ -6,7 +6,6 @@
 
 #include <image-android-dt.h>
 #include <dt_table.h>
-#include <common.h>
 #include <linux/libfdt.h>
 #include <mapmem.h>
 
diff --git a/boot/image-android.c b/boot/image-android.c
index 88e40bc7ec6c..ddd8ffd5e540 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
-#include <common.h>
 #include <env.h>
 #include <image.h>
 #include <image-android-dt.h>
diff --git a/boot/image-board.c b/boot/image-board.c
index 09b6e4e0bdca..b7884b8c5dc7 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -8,7 +8,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <display_options.h>
diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index b9061489396c..9d389f26cea5 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -7,7 +7,6 @@
 #include "mkimage.h"
 #include <time.h>
 #else
-#include <common.h>
 #include <malloc.h>
 #include <asm/global_data.h>
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index f09716cba303..56dd7687f51c 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -8,7 +8,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 12369896fe3f..fe328df4a850 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -7,7 +7,6 @@
 #include "mkimage.h"
 #include <time.h>
 #else
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563ce6..fb03cab831bd 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -19,7 +19,6 @@
 #else
 #include <linux/compiler.h>
 #include <linux/sizes.h>
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index b504ab42a544..cc19017404c8 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Philippe Reynes <philippe.reynes@softathome.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
diff --git a/boot/image-sig.c b/boot/image-sig.c
index 0421a61b0406..6bc74866eaed 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013, Google Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
diff --git a/boot/image.c b/boot/image.c
index 073931cd7a3f..eb12e4be04ac 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -7,7 +7,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <env.h>
 #include <display_options.h>
 #include <init.h>
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 962056267503..db2ae7047928 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/boot/scene.c b/boot/scene.c
index d4dfb49ada15..ac976aa26bbe 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
-#include <common.h>
 #include <dm.h>
 #include <expo.h>
 #include <malloc.h>
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 63994165efba..80bd7457cb1a 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
-#include <common.h>
 #include <dm.h>
 #include <expo.h>
 #include <malloc.h>
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 6ea072a1c268..bba8663b98da 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -8,10 +8,12 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
-#include <common.h>
 #include <expo.h>
 #include <menu.h>
+#include <log.h>
 #include <video_console.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 #include "scene_internal.h"
 
 int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
diff --git a/boot/vbe.c b/boot/vbe.c
index 52b328300374..00673de7ee2e 100644
--- a/boot/vbe.c
+++ b/boot/vbe.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
diff --git a/boot/vbe_request.c b/boot/vbe_request.c
index 917251afa1ca..dc15b04f5bbf 100644
--- a/boot/vbe_request.c
+++ b/boot/vbe_request.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
-#include <common.h>
 #include <dm.h>
 #include <event.h>
 #include <image.h>
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index 12682abd3996..189e86d2a223 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/boot/vbe_simple_fw.c b/boot/vbe_simple_fw.c
index d59a704ddbad..4d6da9490a76 100644
--- a/boot/vbe_simple_fw.c
+++ b/boot/vbe_simple_fw.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
-#include <common.h>
 #include <bloblist.h>
 #include <bootdev.h>
 #include <bootflow.h>
diff --git a/boot/vbe_simple_os.c b/boot/vbe_simple_os.c
index 84626cdeaf24..b4126d8d2d0b 100644
--- a/boot/vbe_simple_os.c
+++ b/boot/vbe_simple_os.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
-#include <common.h>
 #include <dm.h>
 #include <bootflow.h>
 #include <vbe.h>
-- 
2.34.1

