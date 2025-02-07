Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F955C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE69580EB5;
	Fri,  7 Feb 2025 19:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CeQj2Ch/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5442B807AE; Fri,  7 Feb 2025 19:32:32 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1C680812
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84cdb6fba9bso178161039f.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953148; x=1739557948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVlVD7kKZKl1a7NVWDhrYNL8s5SxTQOBeew3z6f+ODU=;
 b=CeQj2Ch/BxepPhuLwKxDseDMBTe3kwKw8tizd9JUstlnohylaQ7Xc7Ys9w2qJYIeOy
 0MVF7G7MhFgHwD1J5QEHkBKgIusMilBQL5OqGqxOumOFqQCHHeNyf36AEy/JdOnyUsh3
 3xMeJakOZT99a1amNY3ZgSf92/LrmOLMCGuZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953148; x=1739557948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVlVD7kKZKl1a7NVWDhrYNL8s5SxTQOBeew3z6f+ODU=;
 b=quibos8dia1rk/92zwsTpqkMiSSJd15Gcn9jYcQnKT7k3GB32GxdC9tmAlHzXSOPR5
 eH4FAZDCmzg9+8pSRXPS55JcfJFvBLJ82cBSdxdMGjU6rQrdsEZxYVlG7KiaVVodRiBk
 BZuuqa5uRWUlkD6sbvBK3y/MyRLEbH56axdd6Ova8+rPWgytLYiW1O7/2jEgpu97cwom
 R7UAusZ7/T3Up4hAdvOlHv2+ZxYFrf5Fpfl10Qk/ci8ILwDNvocw/MbtrFgAwas0pgL5
 9TfMfj02Hn3Qo179skamRH58ZaTCDxcf6Yg39On/pvqHowaxVRS3kDRa/pPPE0uCq6YT
 J45g==
X-Gm-Message-State: AOJu0Yx/ySaHAJ/t5uW9QY8XVSoSmaCSmjVTvKRLGh+IlDo3it1x/xDS
 Saz/fCrN5FnMm5Ze/7N3xl2P3qPxjqGvjqQn8Tz7xPLosb8FKjzUxT+KUf8wiQFjO2HsH6VeUsM
 =
X-Gm-Gg: ASbGncuWPR0VhNHR77oTh5XWLQmBK/uSHGT4fe8R/uVo8epE5qGsRrNSmWuUE5vuwPB
 mnzQ/0x8WdYuIrrbslyJpzi4SRdFYl/k7idzkTSv4p9MF+YTgRMqFMIPkohSs/HEL1wh2KAD3gO
 nIGvAA0VKs6uNA/gtkj7pA3Vt7kOGR/LiMAKzbnvtki2HcHLQqZKFuHlSVzDyYsN3afjBDRGO4m
 fz+g8CvuH1hSawiKAyb05DQp7Ub0qdSlGjqjXCl3gJw2x6mVOu6hYUd1WVNaVKMi5GjpMmbRANq
 yb/0HgYuoP4bo2ysoOJ8e0XMYERF5OkHMbAmFr9Uq30JNFO3heJh
X-Google-Smtp-Source: AGHT+IHipr1lW4/lqUxLFJNZoZcYviAxHMOvb1mQ7HV2QqN2S0MljIaHD3/hQsskCi8kLLtmQiz+9Q==
X-Received: by 2002:a05:6602:6a46:b0:847:560c:e7b7 with SMTP id
 ca18e2360f4ac-854fd896f14mr579732939f.4.1738953147945; 
 Fri, 07 Feb 2025 10:32:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 25/29] test: Drop suites.h
Date: Fri,  7 Feb 2025 11:30:56 -0700
Message-ID: <20250207183121.117663-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

This file is empty now. Remove it and its uses.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h                 | 10 ----------
 test/boot/bootdev.c                   |  1 -
 test/boot/bootflow.c                  |  1 -
 test/boot/bootm.c                     |  1 -
 test/boot/bootmeth.c                  |  1 -
 test/boot/bootstd_common.c            |  1 -
 test/boot/expo.c                      |  1 -
 test/boot/image.c                     |  1 -
 test/boot/measurement.c               |  1 -
 test/boot/upl.c                       |  1 -
 test/boot/vbe_simple.c                |  1 -
 test/cmd/addrmap.c                    |  1 -
 test/cmd/bdinfo.c                     |  1 -
 test/cmd/exit.c                       |  1 -
 test/cmd/fdt.c                        |  1 -
 test/cmd/font.c                       |  1 -
 test/cmd/loadm.c                      |  1 -
 test/cmd/mbr.c                        |  1 -
 test/cmd/pci_mps.c                    |  1 -
 test/cmd/seama.c                      |  1 -
 test/cmd/setexpr.c                    |  1 -
 test/cmd_ut.c                         |  1 -
 test/common/bloblist.c                |  1 -
 test/env/cmd_ut_env.c                 |  1 -
 test/fdt_overlay/cmd_ut_fdt_overlay.c |  1 -
 test/log/cont_test.c                  |  1 -
 test/log/nolog_test.c                 |  1 -
 test/log/pr_cont_test.c               |  1 -
 test/log/syslog_test.c                |  1 -
 test/log/syslog_test_ndebug.c         |  1 -
 test/optee/optee.c                    |  1 -
 31 files changed, 40 deletions(-)
 delete mode 100644 include/test/suites.h

diff --git a/include/test/suites.h b/include/test/suites.h
deleted file mode 100644
index f817da747c2..00000000000
--- a/include/test/suites.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * (C) Copyright 2015
- * Joe Hershberger, National Instruments, joe.hershberger@ni.com
- */
-
-#ifndef __TEST_SUITES_H__
-#define __TEST_SUITES_H__
-
-#endif /* __TEST_SUITES_H__ */
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 8c44afd9297..5f07430714e 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -12,7 +12,6 @@
 #include <bootflow.h>
 #include <mapmem.h>
 #include <os.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index bd96564c915..49ef4d0c3ab 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -25,7 +25,6 @@
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
 #include <linux/libfdt.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 #include "../../boot/bootflow_internal.h"
diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index 1ce5c3cd6bf..2437fa6f3f6 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -7,7 +7,6 @@
 
 #include <bootm.h>
 #include <asm/global_data.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 18ae6d7fe13..577f259fb37 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -9,7 +9,6 @@
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index 6a84810983c..052c0fe5cc6 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -13,7 +13,6 @@
 #include <mmc.h>
 #include <usb.h>
 #include <linux/log2.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include <u-boot/crc.h>
 #include "bootstd_common.h"
diff --git a/test/boot/expo.c b/test/boot/expo.c
index db14ff86f8b..1d283a2ac95 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -10,7 +10,6 @@
 #include <menu.h>
 #include <video.h>
 #include <linux/input.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 #include <test/cedit-test.h>
diff --git a/test/boot/image.c b/test/boot/image.c
index 0894e30587f..4df7b17ce88 100644
--- a/test/boot/image.c
+++ b/test/boot/image.c
@@ -7,7 +7,6 @@
  */
 
 #include <image.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 
diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 5a49c7a6b23..1d38663fc0f 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -8,7 +8,6 @@
 
 #include <bootm.h>
 #include <malloc.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <asm/io.h>
diff --git a/test/boot/upl.c b/test/boot/upl.c
index aa58cdf083b..eec89026fc3 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -10,7 +10,6 @@
 #include <mapmem.h>
 #include <upl.h>
 #include <dm/ofnode.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
diff --git a/test/boot/vbe_simple.c b/test/boot/vbe_simple.c
index 2fe74e1f6c6..c37de627c52 100644
--- a/test/boot/vbe_simple.c
+++ b/test/boot/vbe_simple.c
@@ -11,7 +11,6 @@
 #include <image.h>
 #include <of_live.h>
 #include <vbe.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index 1f2deb15052..72798b96edd 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -6,7 +6,6 @@
  */
 
 #include <console.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 /* Declare a new addrmap test */
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 11f717bf43e..78055eaceef 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -10,7 +10,6 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <dm/uclass.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include <dm.h>
 #include <env.h>
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index 71c37edcdf6..fdde054b928 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -8,7 +8,6 @@
 #include <console.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index ab6dbd45e54..c11c181c807 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -10,7 +10,6 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/test/cmd/font.c b/test/cmd/font.c
index af88d1b5459..7ae648d7395 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -8,7 +8,6 @@
 #include <console.h>
 #include <dm.h>
 #include <video_console.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 /* Declare a new fdt test */
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index 3c623aa655f..043cd25dfb6 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -13,7 +13,6 @@
 #include <mapmem.h>
 #include <asm/global_data.h>
 #include <dm/test.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 45bab04923a..e651256a4cb 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -15,7 +15,6 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <linux/sizes.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index 8b3ea4a6134..6618c247d13 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -8,7 +8,6 @@
  */
 
 #include <console.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 #define PCI_MPS_TEST(_name, _flags) UNIT_TEST(_name, _flags, pci_mps)
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index 1edc3fcac5a..39f85f1c502 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -7,7 +7,6 @@
 
 #include <command.h>
 #include <dm.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 7f318a42ead..3bfcc9aad72 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -9,7 +9,6 @@
 #include <console.h>
 #include <mapmem.h>
 #include <dm/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 #define BUF_SIZE	0x100
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 31ded16325f..b44e60d5a87 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -7,7 +7,6 @@
 #include <command.h>
 #include <console.h>
 #include <vsprintf.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 9467abfa8e1..44a2310b390 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -6,7 +6,6 @@
 #include <bloblist.h>
 #include <log.h>
 #include <mapmem.h>
-#include <test/suites.h>
 #include <test/test.h>
 #include <test/ut.h>
 
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 81d1bb2f80d..43f1b7d1cef 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -5,7 +5,6 @@
  */
 
 #include <test/env.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 static int env_test_env_cmd(struct unit_test_state *uts)
diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index 3244f2d3582..0084033b6ca 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -16,7 +16,6 @@
 
 #include <test/fdt_overlay.h>
 #include <test/ut.h>
-#include <test/suites.h>
 
 /* 4k ought to be enough for anybody */
 #define FDT_COPY_SIZE	(4 * SZ_1K)
diff --git a/test/log/cont_test.c b/test/log/cont_test.c
index 32b1c792367..3b3b791f025 100644
--- a/test/log/cont_test.c
+++ b/test/log/cont_test.c
@@ -9,7 +9,6 @@
 #include <asm/global_data.h>
 #include <test/log.h>
 #include <test/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/test/log/nolog_test.c b/test/log/nolog_test.c
index 341dbfc9310..1913e6817a7 100644
--- a/test/log/nolog_test.c
+++ b/test/log/nolog_test.c
@@ -13,7 +13,6 @@
 #include <asm/global_data.h>
 #include <test/log.h>
 #include <test/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/test/log/pr_cont_test.c b/test/log/pr_cont_test.c
index 7734e927f98..67d8ac59db9 100644
--- a/test/log/pr_cont_test.c
+++ b/test/log/pr_cont_test.c
@@ -8,7 +8,6 @@
 #include <console.h>
 #include <test/log.h>
 #include <test/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include <asm/global_data.h>
 #include <linux/printk.h>
diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
index c4180f775b9..98b91436580 100644
--- a/test/log/syslog_test.c
+++ b/test/log/syslog_test.c
@@ -15,7 +15,6 @@
 #include <hexdump.h>
 #include <test/log.h>
 #include <test/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include <asm/eth.h>
 #include "syslog_test.h"
diff --git a/test/log/syslog_test_ndebug.c b/test/log/syslog_test_ndebug.c
index b10e636812b..dfd0217c1e4 100644
--- a/test/log/syslog_test_ndebug.c
+++ b/test/log/syslog_test_ndebug.c
@@ -12,7 +12,6 @@
 #include <hexdump.h>
 #include <test/log.h>
 #include <test/test.h>
-#include <test/suites.h>
 #include <test/ut.h>
 #include <asm/eth.h>
 #include "syslog_test.h"
diff --git a/test/optee/optee.c b/test/optee/optee.c
index df7b877025f..658621fa2fa 100644
--- a/test/optee/optee.c
+++ b/test/optee/optee.c
@@ -14,7 +14,6 @@
 
 #include <test/ut.h>
 #include <test/optee.h>
-#include <test/suites.h>
 
 /* 4k ought to be enough for anybody */
 #define FDT_COPY_SIZE	(4 * SZ_1K)
-- 
2.43.0

