Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF857C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D988E88CB7;
	Thu,  2 May 2024 03:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tE0eNHLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F6088D1F; Thu,  2 May 2024 03:34:19 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3110688D13
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-43969307359so46367421cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613656; x=1715218456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=53pSYpHv1PKTar/jKYo4afnkpdu+vE29Cd6TwhAV3oQ=;
 b=tE0eNHLTC81kAO8cYVO3Uh/9U1YfjrhxF3dVeD2YJlGNk3190ySAJfmhjwbPewzthY
 ZNhqw5xwobntIo7RDewxnFAnSaofK7aQYvoAapB1UIshGQ3a1VOHtBvl/wcYeRuRcwHa
 WcMjnnhTIhBMQG8O9eH2hLQ6ngOsUdJuAMerE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613656; x=1715218456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53pSYpHv1PKTar/jKYo4afnkpdu+vE29Cd6TwhAV3oQ=;
 b=CCsbWRZtlkmOm8SW1UbLVKyKUA+twZJkGoTqD6Po4s/Fm5Tuna8/UDiuv+b4NVxLoe
 S1YeJFetyx1r7is63jxzKTRRuqGnVaRGCqgmIk2/ndWSwy+7QNMHqFxhtqzQgBdw9qX4
 kB2tM8e+RJCKCl9+LFIZxKlDUpWomo2yw4LPSsB5pTmdp2OcHqT+9Nk3sqK0+V8YkR0W
 WkVhKbZQpZh+6Q1Qw0D6ZppS2zdNmHJV6EJNEKDY/B6NNnm1Eh/dzBxVFLFKN3ts+NO2
 G7Cc7JXXlKHUD3nk/N4X0iBqT4c8wMuL+3MBP1SalMrh0lgd3a7tz1/I99YiSyr1KABM
 BccQ==
X-Gm-Message-State: AOJu0YyzSVYP2dMEz0FRKSHwH6zSV9/y+jaLATu5aU7P8KJL8odMoeuH
 uabGY98ssuSCYE+mfNrRtp8qdRHh0lBI7lSZviz35LeFppzfu/bxOgoNQOTqcp0ej7X2kvLIjQe
 I2/yW/fo2
X-Google-Smtp-Source: AGHT+IGugaHjtDWGfxWjkbuchNZGp0OJ7WWH4Xo+JCiu1yvavld24lGe0kSnmieajBRLyig+skpUmQ==
X-Received: by 2002:a05:622a:178b:b0:43a:e77c:352a with SMTP id
 s11-20020a05622a178b00b0043ae77c352amr5080569qtk.17.1714613655485; 
 Wed, 01 May 2024 18:34:15 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 80/81] api: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:37 -0600
Message-Id: <20240502013138.2383421-80-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from here and when needed add missing include files
directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 api/api.c                           | 4 +++-
 api/api_display.c                   | 2 +-
 api/api_net.c                       | 1 -
 api/api_storage.c                   | 2 +-
 examples/api/demo.c                 | 2 +-
 examples/api/glue.c                 | 1 -
 examples/api/libgenwrap.c           | 1 -
 examples/standalone/atmel_df_pow2.c | 1 -
 examples/standalone/sched.c         | 1 -
 examples/standalone/stubs.c         | 1 -
 include/api_public.h                | 2 ++
 11 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/api/api.c b/api/api.c
index 89003c161c2f..d22132f62fe3 100644
--- a/api/api.c
+++ b/api/api.c
@@ -7,11 +7,13 @@
 
 #include <config.h>
 #include <command.h>
-#include <common.h>
 #include <env.h>
 #include <malloc.h>
+#include <time.h>
 #include <env_internal.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <api_public.h>
 #include <u-boot/crc.h>
diff --git a/api/api_display.c b/api/api_display.c
index 2e877a85d147..8fd078c8c4aa 100644
--- a/api/api_display.c
+++ b/api/api_display.c
@@ -3,9 +3,9 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <api_public.h>
 #include <log.h>
+#include <linux/types.h>
 
 /* TODO(clchiou): add support of video device */
 
diff --git a/api/api_net.c b/api/api_net.c
index 7515c26e8b44..264ff530563b 100644
--- a/api/api_net.c
+++ b/api/api_net.c
@@ -6,7 +6,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <net.h>
 #include <linux/types.h>
 #include <api_public.h>
diff --git a/api/api_storage.c b/api/api_storage.c
index 78becbe39fb6..3d2d9d6ef4c1 100644
--- a/api/api_storage.c
+++ b/api/api_storage.c
@@ -6,10 +6,10 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <api_public.h>
 #include <part.h>
 #include <scsi.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_CMD_USB) && defined(CONFIG_USB_STORAGE)
 #include <usb.h>
diff --git a/examples/api/demo.c b/examples/api/demo.c
index d586174ce8c9..677d13b307a1 100644
--- a/examples/api/demo.c
+++ b/examples/api/demo.c
@@ -5,7 +5,7 @@
  * Written by: Rafal Jaworowski <raj@semihalf.com>
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <env.h>
 #include <linux/types.h>
 #include <api_public.h>
diff --git a/examples/api/glue.c b/examples/api/glue.c
index 075d307ae261..08c21a8cb9c1 100644
--- a/examples/api/glue.c
+++ b/examples/api/glue.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2007-2008 Semihalf, Rafal Jaworowski <raj@semihalf.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <linux/types.h>
 #include <api_public.h>
diff --git a/examples/api/libgenwrap.c b/examples/api/libgenwrap.c
index 3aa222866ff5..bfd88e100d6e 100644
--- a/examples/api/libgenwrap.c
+++ b/examples/api/libgenwrap.c
@@ -9,7 +9,6 @@
  * existing code e.g. operations on strings and similar.
  */
 
-#include <common.h>
 #include <command.h>
 #include <hang.h>
 #include <linux/delay.h>
diff --git a/examples/standalone/atmel_df_pow2.c b/examples/standalone/atmel_df_pow2.c
index dcb25da94986..ed0d7aeaadca 100644
--- a/examples/standalone/atmel_df_pow2.c
+++ b/examples/standalone/atmel_df_pow2.c
@@ -6,7 +6,6 @@
  * Licensed under the 2-clause BSD.
  */
 
-#include <common.h>
 #include <exports.h>
 #include <spi.h>
 #include <linux/delay.h>
diff --git a/examples/standalone/sched.c b/examples/standalone/sched.c
index 1c5296071322..d507163f6f34 100644
--- a/examples/standalone/sched.c
+++ b/examples/standalone/sched.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <exports.h>
 
 /*
diff --git a/examples/standalone/stubs.c b/examples/standalone/stubs.c
index 65115570e8eb..04e8acb8abe9 100644
--- a/examples/standalone/stubs.c
+++ b/examples/standalone/stubs.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <exports.h>
 #include <linux/compiler.h>
 
diff --git a/include/api_public.h b/include/api_public.h
index 5a4465ea893d..e89572c00a4b 100644
--- a/include/api_public.h
+++ b/include/api_public.h
@@ -8,6 +8,8 @@
 #ifndef _API_PUBLIC_H_
 #define _API_PUBLIC_H_
 
+#include <linux/types.h>
+
 #define API_EINVAL		1	/* invalid argument(s)	*/
 #define API_ENODEV		2	/* no device		*/
 #define API_ENOMEM		3	/* no memory		*/
-- 
2.34.1

