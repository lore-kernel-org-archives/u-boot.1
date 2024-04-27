Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83EC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC168858D;
	Sat, 27 Apr 2024 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gVgVPywM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F94C88429; Sat, 27 Apr 2024 16:11:30 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E9B88427
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78edc3e7cd9so216802885a.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227085; x=1714831885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzK7ivFR5NbYe1ewWocbmYn7mSHEUuMr7tjy/KlMq5o=;
 b=gVgVPywMyvaKVR88a3yUMh3njTWDnLkuaQnJyokcowq7zs4GsnMsM1YtX52RtNW6Oz
 nCBFdngOW0dGBmtwUGMDvhk+fn8U+QIgmyT5q99kk/tYHAf1/zOxhNpCBV+CFXNkGJiI
 bzejPm8a4Gd5+xGTmsypuRriUStXlkQ4zhFcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227085; x=1714831885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzK7ivFR5NbYe1ewWocbmYn7mSHEUuMr7tjy/KlMq5o=;
 b=nd22ei2U/Tkw0bDEpT+8hFpxWGLnBGi1rAg3hKri0Md9PiGcRdAYyTeY2HJ1X4h5XY
 Jq0r2r3F9CY56fCANUx5ovf69gWZoPu8/92mna5UEe7/rbeQn1WOJouC6cUGjbSxaonw
 e+HcWf180yxc5htz6IlDKkxLTQDAsCO4zTfPsWk6zvpLUC2SwYnJGi0UF30hSabXIJfh
 TtVuDpCk1bsHST3z8We/koLTBnROVoxnvV1rEDnkdP+y+yCzgkuH/HutjQmmSym1FUbv
 tjRlYHTE3eSDJkMrSNrVqPv8Rb4zMTACFmjmIPmvCzFuvoD6iwNjuDy826e2sRGo9Ew2
 5+1A==
X-Gm-Message-State: AOJu0Yzuc9zgkLuh52U0DQ4hbuvIzp1RPhEWt8yYoqOxK4amKZ4Tlceh
 bhk2s/33flGmVYC54ZA22TnQBo9fzxeZQMMCAqLHr595pqjXotD3a7Ptl8O4QEWpeNFSA/CcbIX
 WqkyQ4A==
X-Google-Smtp-Source: AGHT+IEvS9eXhW3sy6gKWp8oRcQN1hZe7rM1/WCOGa+OfI8ZNcyUF/DH9X1otkx7Of9TYg/9YVBE4g==
X-Received: by 2002:a05:620a:1026:b0:78d:6d44:35fe with SMTP id
 a6-20020a05620a102600b0078d6d4435femr6954646qkk.37.1714227084781; 
 Sat, 27 Apr 2024 07:11:24 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 12/18] common: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:00 -0600
Message-Id: <20240427141106.3406000-13-trini@konsulko.com>
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

Remove <common.h> from all "commmon/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/autoboot.c              | 3 ++-
 common/bloblist.c              | 1 -
 common/board_f.c               | 2 +-
 common/board_info.c            | 1 -
 common/board_r.c               | 2 +-
 common/bootstage.c             | 1 -
 common/bouncebuf.c             | 1 -
 common/cli.c                   | 1 -
 common/cli_getch.c             | 4 +++-
 common/cli_hush.c              | 1 -
 common/cli_readline.c          | 2 +-
 common/cli_simple.c            | 1 -
 common/command.c               | 3 ++-
 common/console.c               | 1 -
 common/cros_ec.c               | 1 -
 common/ddr_spd.c               | 2 +-
 common/dfu.c                   | 1 -
 common/dlmalloc.c              | 1 -
 common/edid.c                  | 1 -
 common/eeprom/eeprom_field.c   | 3 ++-
 common/eeprom/eeprom_layout.c  | 2 +-
 common/event.c                 | 2 +-
 common/exports.c               | 1 -
 common/flash.c                 | 2 +-
 common/hash.c                  | 1 -
 common/hwconfig.c              | 1 -
 common/init/board_init.c       | 2 +-
 common/init/handoff.c          | 2 +-
 common/iomux.c                 | 1 -
 common/iotrace.c               | 1 -
 common/kallsyms.c              | 1 -
 common/kgdb.c                  | 1 -
 common/kgdb_stubs.c            | 1 -
 common/log.c                   | 1 -
 common/log_console.c           | 1 -
 common/log_syslog.c            | 1 -
 common/main.c                  | 1 -
 common/malloc_simple.c         | 1 -
 common/memsize.c               | 2 +-
 common/menu.c                  | 1 -
 common/miiphyutil.c            | 1 -
 common/s_record.c              | 1 -
 common/scp03.c                 | 3 ++-
 common/spl/spl.c               | 2 +-
 common/spl/spl_atf.c           | 1 -
 common/spl/spl_blk_fs.c        | 1 -
 common/spl/spl_bootrom.c       | 1 -
 common/spl/spl_dfu.c           | 1 -
 common/spl/spl_ext.c           | 1 -
 common/spl/spl_fat.c           | 1 -
 common/spl/spl_fit.c           | 1 -
 common/spl/spl_imx_container.c | 1 -
 common/spl/spl_legacy.c        | 1 -
 common/spl/spl_mmc.c           | 1 -
 common/spl/spl_nand.c          | 1 -
 common/spl/spl_net.c           | 1 -
 common/spl/spl_nor.c           | 2 +-
 common/spl/spl_nvme.c          | 1 -
 common/spl/spl_onenand.c       | 1 -
 common/spl/spl_opensbi.c       | 1 -
 common/spl/spl_ram.c           | 1 -
 common/spl/spl_sata.c          | 1 -
 common/spl/spl_sdp.c           | 1 -
 common/spl/spl_semihosting.c   | 1 -
 common/spl/spl_spi.c           | 2 +-
 common/spl/spl_ubi.c           | 1 -
 common/spl/spl_usb.c           | 1 -
 common/spl/spl_xip.c           | 2 +-
 common/spl/spl_ymodem.c        | 1 -
 common/splash.c                | 3 ++-
 common/splash_source.c         | 1 -
 common/stackprot.c             | 1 -
 common/stdio.c                 | 1 -
 common/update.c                | 1 -
 common/usb.c                   | 1 -
 common/usb_hub.c               | 2 +-
 common/usb_kbd.c               | 2 +-
 common/usb_onboard_hub.c       | 1 -
 common/usb_storage.c           | 1 -
 common/xyzModem.c              | 3 ++-
 include/atf_common.h           | 2 ++
 include/autoboot.h             | 1 +
 include/bmp_layout.h           | 2 ++
 include/ddr_spd.h              | 2 ++
 include/flash.h                | 2 ++
 include/gzip.h                 | 2 ++
 include/handoff.h              | 1 +
 include/nand.h                 | 2 --
 include/s_record.h             | 2 ++
 89 files changed, 45 insertions(+), 82 deletions(-)

diff --git a/common/autoboot.c b/common/autoboot.c
index 6f0aeae6bf33..898a57bc92bd 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -4,13 +4,14 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <autoboot.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
 #include <console.h>
 #include <env.h>
+#include <errno.h>
 #include <fdtdec.h>
 #include <hash.h>
 #include <log.h>
diff --git a/common/bloblist.c b/common/bloblist.c
index ad06d7a1795d..11d6422b695a 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY	LOGC_BLOBLIST
 
-#include <common.h>
 #include <bloblist.h>
 #include <display_options.h>
 #include <log.h>
diff --git a/common/board_f.c b/common/board_f.c
index 039d6d712d05..212ffb3090b2 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -9,7 +9,7 @@
  * Marius Groeger <mgroeger@sysgo.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <bloblist.h>
 #include <bootstage.h>
 #include <clock_legacy.h>
diff --git a/common/board_info.c b/common/board_info.c
index f4c385add90c..33c260b404e8 100644
--- a/common/board_info.c
+++ b/common/board_info.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <sysinfo.h>
diff --git a/common/board_r.c b/common/board_r.c
index da0b80f24ff0..c823cd262f16 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -9,7 +9,7 @@
  * Marius Groeger <mgroeger@sysgo.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <api.h>
 #include <bootstage.h>
 #include <cpu_func.h>
diff --git a/common/bootstage.c b/common/bootstage.c
index 0e6d80718fd5..fb6befcbc4a8 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -11,7 +11,6 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
-#include <common.h>
 #include <bootstage.h>
 #include <hang.h>
 #include <log.h>
diff --git a/common/bouncebuf.c b/common/bouncebuf.c
index 934b83f7ec3f..b2f87e4d939b 100644
--- a/common/bouncebuf.c
+++ b/common/bouncebuf.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2012 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/common/cli.c b/common/cli.c
index 1c33daf1149a..4694a35cd0e0 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -10,7 +10,6 @@
 
 #define pr_fmt(fmt) "cli: %s: " fmt, __func__
 
-#include <common.h>
 #include <ansi.h>
 #include <bootstage.h>
 #include <cli.h>
diff --git a/common/cli_getch.c b/common/cli_getch.c
index 0ee790877748..a5ed6eb6fcfa 100644
--- a/common/cli_getch.c
+++ b/common/cli_getch.c
@@ -6,8 +6,10 @@
  * Copyright 2022 Google LLC
  */
 
-#include <common.h>
 #include <cli.h>
+#include <stdio.h>
+#include <string.h>
+#include <linux/errno.h>
 
 /**
  * enum cli_esc_state_t - indicates what to do with an escape character
diff --git a/common/cli_hush.c b/common/cli_hush.c
index 9cda97f30e3c..96a98209b9d2 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -75,7 +75,6 @@
 
 #define __U_BOOT__
 #ifdef __U_BOOT__
-#include <common.h>         /* readline */
 #include <env.h>
 #include <malloc.h>         /* malloc, free, realloc*/
 #include <linux/ctype.h>    /* isalpha, isdigit */
diff --git a/common/cli_readline.c b/common/cli_readline.c
index cf4339d0e509..4cb82b40149a 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -8,7 +8,6 @@
  * JinHua Luo, GuangDong Linux Center, <luo.jinhua@gd-linux.com>
  */
 
-#include <common.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
@@ -16,6 +15,7 @@
 #include <malloc.h>
 #include <time.h>
 #include <watchdog.h>
+#include <linux/errno.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/common/cli_simple.c b/common/cli_simple.c
index f89ba92d1b05..266c444334eb 100644
--- a/common/cli_simple.c
+++ b/common/cli_simple.c
@@ -8,7 +8,6 @@
  * JinHua Luo, GuangDong Linux Center, <luo.jinhua@gd-linux.com>
  */
 
-#include <common.h>
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
diff --git a/common/command.c b/common/command.c
index af8ffdba8f8c..3f691399cbee 100644
--- a/common/command.c
+++ b/common/command.c
@@ -8,7 +8,7 @@
  *  Command Processor Table
  */
 
-#include <common.h>
+#include <config.h>
 #include <compiler.h>
 #include <command.h>
 #include <console.h>
@@ -16,6 +16,7 @@
 #include <image.h>
 #include <log.h>
 #include <mapmem.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <linux/ctype.h>
 
diff --git a/common/console.c b/common/console.c
index aa3053bc4414..63f78004fdbc 100644
--- a/common/console.c
+++ b/common/console.c
@@ -4,7 +4,6 @@
  * Paolo Scaffardi, AIRVENT SAM s.p.a - RIMINI(ITALY), arsenio@tin.it
  */
 
-#include <common.h>
 #include <console.h>
 #include <debug_uart.h>
 #include <display_options.h>
diff --git a/common/cros_ec.c b/common/cros_ec.c
index 249d1f19411e..9ccc8fa16cdb 100644
--- a/common/cros_ec.c
+++ b/common/cros_ec.c
@@ -8,7 +8,6 @@
  * Software Foundation.
  */
 
-#include <common.h>
 #include <cros_ec.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/common/ddr_spd.c b/common/ddr_spd.c
index 58dc9b3781b7..2f6eb99bf0cf 100644
--- a/common/ddr_spd.c
+++ b/common/ddr_spd.c
@@ -3,8 +3,8 @@
  * Copyright 2008-2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <ddr_spd.h>
+#include <stdio.h>
 
 /* used for ddr1 and ddr2 spd */
 static int
diff --git a/common/dfu.c b/common/dfu.c
index 0d154e8d4c48..1af8194139c3 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -10,7 +10,6 @@
  *	    Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <watchdog.h>
diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index a0616217d495..9549c59f3585 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -12,7 +12,6 @@
 #define DEBUG
 #endif
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 
diff --git a/common/edid.c b/common/edid.c
index 556c4e3434b6..865ba9daa78a 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -9,7 +9,6 @@
  * Copyright (C) Nalin Dahyabhai <bigfun@pobox.com>
  */
 
-#include <common.h>
 #include <edid.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/common/eeprom/eeprom_field.c b/common/eeprom/eeprom_field.c
index f56eebe679f7..3bacb1ae7eb7 100644
--- a/common/eeprom/eeprom_field.c
+++ b/common/eeprom/eeprom_field.c
@@ -6,7 +6,8 @@
  *	    Igor Grinberg <grinberg@compulab.co.il>
  */
 
-#include <common.h>
+#include <stdio.h>
+#include <vsprintf.h>
 #include <linux/string.h>
 #include <eeprom_field.h>
 
diff --git a/common/eeprom/eeprom_layout.c b/common/eeprom/eeprom_layout.c
index 5a9be1da061f..1a425c1754d4 100644
--- a/common/eeprom/eeprom_layout.c
+++ b/common/eeprom/eeprom_layout.c
@@ -6,8 +6,8 @@
  *	    Igor Grinberg <grinberg@compulab.co.il>
  */
 
-#include <common.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <eeprom_layout.h>
 #include <eeprom_field.h>
 
diff --git a/common/event.c b/common/event.c
index 16c2ba6cc921..dda569d44785 100644
--- a/common/event.c
+++ b/common/event.c
@@ -9,13 +9,13 @@
 
 #define LOG_CATEGORY	LOGC_EVENT
 
-#include <common.h>
 #include <event.h>
 #include <event_internal.h>
 #include <log.h>
 #include <linker_lists.h>
 #include <malloc.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 #include <linux/list.h>
 #include <relocate.h>
 
diff --git a/common/exports.c b/common/exports.c
index 20d8b759bc25..48b084c38613 100644
--- a/common/exports.c
+++ b/common/exports.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <command.h>
 #include <exports.h>
 #include <malloc.h>
diff --git a/common/flash.c b/common/flash.c
index 848f44e59dfd..24ddc8bee724 100644
--- a/common/flash.c
+++ b/common/flash.c
@@ -6,10 +6,10 @@
 
 /* #define DEBUG */
 
-#include <common.h>
 #include <flash.h>
 #include <log.h>
 #include <uuid.h>
+#include <linux/string.h>
 
 #include <mtd/cfi_flash.h>
 
diff --git a/common/hash.c b/common/hash.c
index 3d6b84de4738..ac63803fed95 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -10,7 +10,6 @@
  */
 
 #ifndef USE_HOSTCC
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <log.h>
diff --git a/common/hwconfig.c b/common/hwconfig.c
index cac0b6348f46..afaa6cb37ab4 100644
--- a/common/hwconfig.c
+++ b/common/hwconfig.c
@@ -10,7 +10,6 @@
 
 #ifndef HWCONFIG_TEST
 #include <config.h>
-#include <common.h>
 #include <env.h>
 #include <exports.h>
 #include <hwconfig.h>
diff --git a/common/init/board_init.c b/common/init/board_init.c
index ed2365daa35e..a06ec1caa2ca 100644
--- a/common/init/board_init.c
+++ b/common/init/board_init.c
@@ -6,7 +6,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/common/init/handoff.c b/common/init/handoff.c
index d0be1bb17a2c..687513bda353 100644
--- a/common/init/handoff.c
+++ b/common/init/handoff.c
@@ -5,9 +5,9 @@
  * Copyright 2018 Google, Inc
  */
 
-#include <common.h>
 #include <handoff.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/iomux.c b/common/iomux.c
index c428f7110a7a..1224c15eb718 100644
--- a/common/iomux.c
+++ b/common/iomux.c
@@ -4,7 +4,6 @@
  * Gary Jennejohn, DENX Software Engineering GmbH, garyj@denx.de.
  */
 
-#include <common.h>
 #include <console.h>
 #include <serial.h>
 #include <malloc.h>
diff --git a/common/iotrace.c b/common/iotrace.c
index 63d0cca3a004..a0a5613bd9b3 100644
--- a/common/iotrace.c
+++ b/common/iotrace.c
@@ -5,7 +5,6 @@
 
 #define IOTRACE_IMPL
 
-#include <common.h>
 #include <mapmem.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/common/kallsyms.c b/common/kallsyms.c
index 13344e634b99..49b3897078ae 100644
--- a/common/kallsyms.c
+++ b/common/kallsyms.c
@@ -5,7 +5,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <common.h>
 
 /* We need the weak marking as this symbol is provided specially */
 extern const char system_map[] __attribute__((weak));
diff --git a/common/kgdb.c b/common/kgdb.c
index 29b09fcfe56b..01a09f176286 100644
--- a/common/kgdb.c
+++ b/common/kgdb.c
@@ -87,7 +87,6 @@
  *
  ****************************************************************************/
 
-#include <common.h>
 #include <asm/ptrace.h>
 
 #include <kgdb.h>
diff --git a/common/kgdb_stubs.c b/common/kgdb_stubs.c
index 66aed7cea1c7..256d88697d7e 100644
--- a/common/kgdb_stubs.c
+++ b/common/kgdb_stubs.c
@@ -7,7 +7,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <kgdb.h>
 #include <serial.h>
diff --git a/common/log.c b/common/log.c
index 42d35f04b689..dfee250b158a 100644
--- a/common/log.c
+++ b/common/log.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/common/log_console.c b/common/log_console.c
index bb091ce21a4a..c27101b8fe22 100644
--- a/common/log_console.c
+++ b/common/log_console.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 
diff --git a/common/log_syslog.c b/common/log_syslog.c
index 53c4def5d1c0..d01bb749c22d 100644
--- a/common/log_syslog.c
+++ b/common/log_syslog.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <log.h>
 #include <net.h>
 #include <asm/global_data.h>
diff --git a/common/main.c b/common/main.c
index 82d3aafa53c9..b0b6e74f5d3d 100644
--- a/common/main.c
+++ b/common/main.c
@@ -6,7 +6,6 @@
 
 /* #define	DEBUG	*/
 
-#include <common.h>
 #include <autoboot.h>
 #include <button.h>
 #include <bootstage.h>
diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 0a004d40e1ec..4e6d7952b3ca 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_ALLOC
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/common/memsize.c b/common/memsize.c
index d646df8b04cb..86109579c954 100644
--- a/common/memsize.c
+++ b/common/memsize.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <cpu_func.h>
diff --git a/common/menu.c b/common/menu.c
index b55cf7b99967..e48424995b64 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -5,7 +5,6 @@
  */
 
 #include <ansi.h>
-#include <common.h>
 #include <cli.h>
 #include <malloc.h>
 #include <errno.h>
diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 194c84e7e89d..9b8744e5d8bf 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -9,7 +9,6 @@
  * channel.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <miiphy.h>
diff --git a/common/s_record.c b/common/s_record.c
index 2b7651fcffca..486dd93abd41 100644
--- a/common/s_record.c
+++ b/common/s_record.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <s_record.h>
 
 static int hex1_bin (char  c);
diff --git a/common/scp03.c b/common/scp03.c
index 09ef7b5ba3dc..54b1bd54b604 100644
--- a/common/scp03.c
+++ b/common/scp03.c
@@ -4,10 +4,11 @@
  *
  */
 
-#include <common.h>
 #include <scp03.h>
 #include <tee.h>
 #include <tee/optee_ta_scp03.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 
 static int scp03_enable(bool provision)
 {
diff --git a/common/spl/spl.c b/common/spl/spl.c
index e06bc75d36b2..4e92771ecaae 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -6,7 +6,7 @@
  * Aneesh V <aneesh@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <bloblist.h>
 #include <binman_sym.h>
 #include <bootstage.h>
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3bdd013a35fe..0b1c981a105d 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <atf_common.h>
 #include <cpu_func.h>
 #include <errno.h>
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 04eac6f306bd..bc551c5c074c 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <spl.h>
 #include <spl_load.h>
 #include <image.h>
diff --git a/common/spl/spl_bootrom.c b/common/spl/spl_bootrom.c
index 0eefd39a5198..e172a2d7b83c 100644
--- a/common/spl/spl_bootrom.c
+++ b/common/spl/spl_bootrom.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Theobroma Systems Design und Consulting GmH
  */
 
-#include <common.h>
 #include <spl.h>
 
 __weak int board_return_to_bootrom(struct spl_image_info *spl_image,
diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
index 8a779da8fa1e..e9f381c392cd 100644
--- a/common/spl/spl_dfu.c
+++ b/common/spl/spl_dfu.c
@@ -5,7 +5,6 @@
  *
  * Ravi B <ravibabu@ti.com>
  */
-#include <common.h>
 #include <env.h>
 #include <spl.h>
 #include <linux/compiler.h>
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 2be6f04b02c5..2399e1d806d4 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <env.h>
 #include <part.h>
 #include <spl.h>
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index a52f9e178e66..2e320ba7c018 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -8,7 +8,6 @@
  * FAT Image Functions copied from spl_mmc.c
  */
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <spl.h>
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index e5195d460c49..988125be008d 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <fpga.h>
 #include <gzip.h>
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index b4ea9241d685..2c31777fcd3a 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -4,7 +4,6 @@
  */
 
 #define LOG_CATEGORY LOGC_ARCH
-#include <common.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <imx_container.h>
diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index 08687ca8f6c4..a77893455f25 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 3d032bb27ce3..f4481b90463a 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -5,7 +5,6 @@
  *
  * Aneesh V <aneesh@ti.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <part.h>
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 3b0a15242389..5631fa6d5635 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011
  * Corscience GmbH & Co. KG - Simon Schwarz <schwarz@corscience.de>
  */
-#include <common.h>
 #include <config.h>
 #include <fdt_support.h>
 #include <image.h>
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index 898f9df705a2..be7278bb9334 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -6,7 +6,6 @@
  * (C) Copyright 2012
  * Ilya Yanok <ilya.yanok@gmail.com>
  */
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <image.h>
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 70745114efed..ed76b5e1293b 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2012 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
diff --git a/common/spl/spl_nvme.c b/common/spl/spl_nvme.c
index c8774d67ecf1..0e15a3c7545a 100644
--- a/common/spl/spl_nvme.c
+++ b/common/spl/spl_nvme.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <spl.h>
 #include <nvme.h>
 
diff --git a/common/spl/spl_onenand.c b/common/spl/spl_onenand.c
index 53a8c6de89eb..f6f65286c216 100644
--- a/common/spl/spl_onenand.c
+++ b/common/spl/spl_onenand.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2011
  * Corscience GmbH & Co. KG - Simon Schwarz <schwarz@corscience.de>
  */
-#include <common.h>
 #include <config.h>
 #include <image.h>
 #include <log.h>
diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index ec62aab929b9..5a26d7c31a43 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -5,7 +5,6 @@
  *
  * Based on common/spl/spl_atf.c
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <hang.h>
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 8aeda237be13..5a23841f6981 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -9,7 +9,6 @@
  * Michal Simek <michal.simek@amd.com>
  * Stefan Agner <stefan.agner@toradex.com>
  */
-#include <common.h>
 #include <binman_sym.h>
 #include <image.h>
 #include <log.h>
diff --git a/common/spl/spl_sata.c b/common/spl/spl_sata.c
index 32746ce9f3cf..18acc40e46fc 100644
--- a/common/spl/spl_sata.c
+++ b/common/spl/spl_sata.c
@@ -8,7 +8,6 @@
  * Derived work from spl_usb.c
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/u-boot.h>
 #include <sata.h>
diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
index 9143c27bbf1d..9ca80bd534f8 100644
--- a/common/spl/spl_sdp.c
+++ b/common/spl/spl_sdp.c
@@ -4,7 +4,6 @@
  * Author: Stefan Agner <stefan.agner@toradex.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <spl.h>
 #include <usb.h>
diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 941fa911040e..2047248f39b0 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022 Sean Anderson <sean.anderson@seco.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <log.h>
 #include <semihosting.h>
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 89de73c726cd..8ab4803f7c4b 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -8,7 +8,7 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index d7ab9efd1108..a8d3f43b4528 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -4,7 +4,6 @@
  * Ladislav Michl <ladis@linux-mips.org>
  */
 
-#include <common.h>
 #include <config.h>
 #include <image.h>
 #include <nand.h>
diff --git a/common/spl/spl_usb.c b/common/spl/spl_usb.c
index 479e2dc1826e..31fc4b57d486 100644
--- a/common/spl/spl_usb.c
+++ b/common/spl/spl_usb.c
@@ -8,7 +8,6 @@
  * Derived work from spl_mmc.c
  */
 
-#include <common.h>
 #include <log.h>
 #include <spl.h>
 #include <asm/u-boot.h>
diff --git a/common/spl/spl_xip.c b/common/spl/spl_xip.c
index 959915ffa610..1465c3e46b92 100644
--- a/common/spl/spl_xip.c
+++ b/common/spl/spl_xip.c
@@ -4,7 +4,7 @@
  * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <log.h>
 #include <spl.h>
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 1faaa2c938d4..fd48f80f75e3 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -8,7 +8,6 @@
  *
  * Matt Porter <mporter@ti.com>
  */
-#include <common.h>
 #include <gzip.h>
 #include <image.h>
 #include <log.h>
diff --git a/common/splash.c b/common/splash.c
index 6820db683bd6..c5591293634a 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -20,11 +20,12 @@
  *
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <env.h>
 #include <splash.h>
 #include <video.h>
+#include <vsprintf.h>
+#include <linux/kernel.h>
 
 static struct splash_location default_splash_locations[] = {
 	{
diff --git a/common/splash_source.c b/common/splash_source.c
index 2ce0768833d9..5b2711604495 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -5,7 +5,6 @@
  * Authors: Igor Grinberg <grinberg@compulab.co.il>
  */
 
-#include <common.h>
 #include <bmp_layout.h>
 #include <command.h>
 #include <env.h>
diff --git a/common/stackprot.c b/common/stackprot.c
index 6495951a773c..4e3297b7d006 100644
--- a/common/stackprot.c
+++ b/common/stackprot.c
@@ -3,7 +3,6 @@
  *  Copyright 2021 Broadcom
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/common/stdio.c b/common/stdio.c
index e3354f092dc9..a61220ce4b9c 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -9,7 +9,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/common/update.c b/common/update.c
index ec302ca68fb0..eb0b60a2ce48 100644
--- a/common/update.c
+++ b/common/update.c
@@ -6,7 +6,6 @@
  *             Bartlomiej Sieka <tur@semihalf.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <image.h>
 #include <linux/printk.h>
diff --git a/common/usb.c b/common/usb.c
index 99e6b857c74c..84b10f5c7d8c 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -25,7 +25,6 @@
  *
  * For each transfer (except "Interrupt") we wait for completion.
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/common/usb_hub.c b/common/usb_hub.c
index 2e054eb93537..807f490bb609 100644
--- a/common/usb_hub.c
+++ b/common/usb_hub.c
@@ -21,7 +21,6 @@
  * Probes device for being a hub and configurate it
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -29,6 +28,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <time.h>
 #include <asm/processor.h>
 #include <asm/unaligned.h>
 #include <linux/ctype.h>
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index 820f591fc5bb..f3b4a3c94e6d 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -6,7 +6,6 @@
  * Part of this source has been derived from the Linux USB
  * project.
  */
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <env.h>
@@ -15,6 +14,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <stdio_dev.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/byteorder.h>
 #ifdef CONFIG_SANDBOX
diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 89e18a2ddad6..68a04ac0412b 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,7 +7,6 @@
  * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <power/regulator.h>
diff --git a/common/usb_storage.c b/common/usb_storage.c
index 774d5bdf54b4..a79ed2e23a44 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -32,7 +32,6 @@
  */
 
 
-#include <common.h>
 #include <blk.h>
 #include <bootdev.h>
 #include <command.h>
diff --git a/common/xyzModem.c b/common/xyzModem.c
index fb319f711907..9feb240de281 100644
--- a/common/xyzModem.c
+++ b/common/xyzModem.c
@@ -21,12 +21,13 @@
  *
  *==========================================================================
  */
-#include <common.h>
 #include <xyzModem.h>
 #include <stdarg.h>
+#include <time.h>
 #include <u-boot/crc.h>
 #include <watchdog.h>
 #include <env.h>
+#include <vsprintf.h>
 
 /* Assumption - run xyzModem protocol over the console port */
 
diff --git a/include/atf_common.h b/include/atf_common.h
index d69892fac6cb..5ae450902523 100644
--- a/include/atf_common.h
+++ b/include/atf_common.h
@@ -74,6 +74,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 /*******************************************************************************
  * Structure used for telling the next BL how much of a particular type of
  * memory is available for its use and how much is already used.
diff --git a/include/autoboot.h b/include/autoboot.h
index eb204995d079..c68bd79f8dca 100644
--- a/include/autoboot.h
+++ b/include/autoboot.h
@@ -12,6 +12,7 @@
 #define __AUTOBOOT_H
 
 #include <stdbool.h>
+#include <stddef.h>
 
 #ifdef CONFIG_SANDBOX
 
diff --git a/include/bmp_layout.h b/include/bmp_layout.h
index a5c9498dc9fb..eabbd25a3309 100644
--- a/include/bmp_layout.h
+++ b/include/bmp_layout.h
@@ -10,6 +10,8 @@
 #ifndef _BMP_H_
 #define _BMP_H_
 
+#include <linux/compiler.h>
+
 struct __packed bmp_color_table_entry {
 	__u8	blue;
 	__u8	green;
diff --git a/include/ddr_spd.h b/include/ddr_spd.h
index fe163da43e56..c4d199fd7e14 100644
--- a/include/ddr_spd.h
+++ b/include/ddr_spd.h
@@ -6,6 +6,8 @@
 #ifndef _DDR_SPD_H_
 #define _DDR_SPD_H_
 
+#include <linux/types.h>
+
 /*
  * Format from "JEDEC Standard No. 21-C,
  * Appendix D: Rev 1.0: SPD's for DDR SDRAM
diff --git a/include/flash.h b/include/flash.h
index 3710a2731b76..0f7369774117 100644
--- a/include/flash.h
+++ b/include/flash.h
@@ -7,6 +7,8 @@
 #ifndef _FLASH_H_
 #define _FLASH_H_
 
+#include <linux/types.h>
+
 /*-----------------------------------------------------------------------
  * FLASH Info: contains chip specific data, per FLASH bank
  */
diff --git a/include/gzip.h b/include/gzip.h
index e578b283edcd..5e0d0ec07fbc 100644
--- a/include/gzip.h
+++ b/include/gzip.h
@@ -7,6 +7,8 @@
 #ifndef __GZIP_H
 #define __GZIP_H
 
+#include <linux/types.h>
+
 struct blk_desc;
 
 /**
diff --git a/include/handoff.h b/include/handoff.h
index 0104b834f2c4..c0ae7b19a759 100644
--- a/include/handoff.h
+++ b/include/handoff.h
@@ -10,6 +10,7 @@
 
 #if CONFIG_IS_ENABLED(HANDOFF)
 
+#include <linux/types.h>
 #include <asm/handoff.h>
 
 /**
diff --git a/include/nand.h b/include/nand.h
index 220ffa202ef9..cdba7384ad14 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -8,8 +8,6 @@
 #ifndef _NAND_H_
 #define _NAND_H_
 
-#include <config.h>
-
 extern void nand_init(void);
 void nand_reinit(void);
 unsigned long nand_size(void);
diff --git a/include/s_record.h b/include/s_record.h
index 3ece695941d3..aab09d9c3c81 100644
--- a/include/s_record.h
+++ b/include/s_record.h
@@ -4,6 +4,8 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <linux/types.h>
+
 /*--------------------------------------------------------------------------
  *
  * Motorola S-Record Format:
-- 
2.34.1

