Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B3C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E094288684;
	Sat, 27 Apr 2024 16:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DHBarbyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635B588407; Sat, 27 Apr 2024 16:11:37 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029438827F
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a077a861e7so19954426d6.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227093; x=1714831893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mIX9bVhUzWBVSerwNqOPyfpTNd6KZwki6R6SWYOgd0Y=;
 b=DHBarbyYFAUgnwO2/5ksUqkaW6uf3+GA+0IHl8Hn9IO8VvWTFS/cibMniA9qJ5o6rh
 YGA68nhKqNu3sMRBm/llAe7t0gAVKXvXlBpsUkMqKEplGrLPtJeVmDtQVB1xiUWpXa7Z
 5CSQbdUtmUmDk6e4HWsQD+/Xmfrq/OEXo+3Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227093; x=1714831893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIX9bVhUzWBVSerwNqOPyfpTNd6KZwki6R6SWYOgd0Y=;
 b=iU8Z4lR7qdzYT3aSQzfo9M6xs5xvtaRINtm1rxOGxSuDYaSOtDwO/2Rkwqpa8g9TFj
 Gkr/RiNGgyyrCLeTN6LQIF8JdsgFRkLOeH7TItlNOlqNqm5twSWsWdKfkkVx9Ini0L/2
 QmDN7bmMo4gDG2kve1GiBhAWE3GBrQFclDm60n6ICkv4nHpvgeOrNf2CEXYcwlpT71po
 SeYPMWnBQi6ylZW4OJiMl2cyYiVqqVxobqR+Pywsxapis0ZEBfvkGcP93kewrHrvX5U+
 n46KMbDfHgpuDFiw99qE2mE5Vynb6PW8mbcge7h036IpcrDPEil0Iq/oLxcoHCDF1Vka
 xWig==
X-Gm-Message-State: AOJu0Yzr83zi/5U3/ac2vb3Ym383DGpyIVWxmaij+Tg0DfFhpvAvkl76
 aIlLwklli1FrwHJd2kFBCyrepCmLWP/JLOB6UJpSC7VHo83STyRNEI5I6Y6/kWPXaMhh6baT2M+
 TjMyf6g==
X-Google-Smtp-Source: AGHT+IHwcybnHPyzf9p6ykTvpNj64V9u399TCwUz9Tt388iyLo+7q0dVM0nOGcz0ecIPzeOkoCv8FA==
X-Received: by 2002:a05:6214:f07:b0:698:fd40:dec9 with SMTP id
 gw7-20020a0562140f0700b00698fd40dec9mr6935562qvb.32.1714227090987; 
 Sat, 27 Apr 2024 07:11:30 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 18/18] post: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:06 -0600
Message-Id: <20240427141106.3406000-19-trini@konsulko.com>
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

Remove <common.h> from all "post/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 post/cpu/mpc83xx/ecc.c                        | 2 +-
 post/drivers/flash.c                          | 2 +-
 post/drivers/i2c.c                            | 2 +-
 post/drivers/memory.c                         | 2 +-
 post/drivers/rtc.c                            | 2 +-
 post/lib_powerpc/andi.c                       | 2 +-
 post/lib_powerpc/b.c                          | 2 +-
 post/lib_powerpc/cmp.c                        | 2 +-
 post/lib_powerpc/cmpi.c                       | 2 +-
 post/lib_powerpc/complex.c                    | 2 +-
 post/lib_powerpc/cpu.c                        | 2 +-
 post/lib_powerpc/cr.c                         | 2 +-
 post/lib_powerpc/fpu/20001122-1.c             | 2 +-
 post/lib_powerpc/fpu/20010114-2.c             | 2 +-
 post/lib_powerpc/fpu/20010226-1.c             | 2 +-
 post/lib_powerpc/fpu/980619-1.c               | 2 +-
 post/lib_powerpc/fpu/acc1.c                   | 2 +-
 post/lib_powerpc/fpu/compare-fp-1.c           | 2 +-
 post/lib_powerpc/fpu/fpu.c                    | 2 +-
 post/lib_powerpc/fpu/mul-subnormal-single-1.c | 2 +-
 post/lib_powerpc/load.c                       | 2 +-
 post/lib_powerpc/multi.c                      | 2 +-
 post/lib_powerpc/rlwimi.c                     | 2 +-
 post/lib_powerpc/rlwinm.c                     | 2 +-
 post/lib_powerpc/rlwnm.c                      | 2 +-
 post/lib_powerpc/srawi.c                      | 2 +-
 post/lib_powerpc/store.c                      | 2 +-
 post/lib_powerpc/string.c                     | 2 +-
 post/lib_powerpc/three.c                      | 2 +-
 post/lib_powerpc/threei.c                     | 2 +-
 post/lib_powerpc/threex.c                     | 2 +-
 post/lib_powerpc/two.c                        | 2 +-
 post/lib_powerpc/twox.c                       | 2 +-
 post/post.c                                   | 2 +-
 post/tests.c                                  | 3 ++-
 35 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/post/cpu/mpc83xx/ecc.c b/post/cpu/mpc83xx/ecc.c
index 68da8ff41716..766eafa00e71 100644
--- a/post/cpu/mpc83xx/ecc.c
+++ b/post/cpu/mpc83xx/ecc.c
@@ -8,7 +8,7 @@
  * Dave Liu <daveliu@freescale.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <irq_func.h>
 #include <log.h>
diff --git a/post/drivers/flash.c b/post/drivers/flash.c
index a1fcf1f135d9..21e2f940fe92 100644
--- a/post/drivers/flash.c
+++ b/post/drivers/flash.c
@@ -7,7 +7,7 @@
  */
 
 #if CFG_POST & CFG_SYS_POST_FLASH
-#include <common.h>
+#include <config.h>
 #include <malloc.h>
 #include <post.h>
 #include <flash.h>
diff --git a/post/drivers/i2c.c b/post/drivers/i2c.c
index 557d6329a4f0..11c3c8323523 100644
--- a/post/drivers/i2c.c
+++ b/post/drivers/i2c.c
@@ -21,7 +21,7 @@
  * #endif
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <post.h>
 #include <i2c.h>
diff --git a/post/drivers/memory.c b/post/drivers/memory.c
index 1be2b41df45d..8d4ae6fc6f1e 100644
--- a/post/drivers/memory.c
+++ b/post/drivers/memory.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/global_data.h>
 
diff --git a/post/drivers/rtc.c b/post/drivers/rtc.c
index cc7a49847ccd..030954ef3dca 100644
--- a/post/drivers/rtc.c
+++ b/post/drivers/rtc.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 
 /*
  * RTC test
diff --git a/post/lib_powerpc/andi.c b/post/lib_powerpc/andi.c
index 4f3021668800..3f525f516760 100644
--- a/post/lib_powerpc/andi.c
+++ b/post/lib_powerpc/andi.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/b.c b/post/lib_powerpc/b.c
index 0ec032dcb152..9c9931c4f3a9 100644
--- a/post/lib_powerpc/b.c
+++ b/post/lib_powerpc/b.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/cmp.c b/post/lib_powerpc/cmp.c
index 57f2b9694c33..9237dd539979 100644
--- a/post/lib_powerpc/cmp.c
+++ b/post/lib_powerpc/cmp.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/cmpi.c b/post/lib_powerpc/cmpi.c
index 6e2bd636d74d..6436586b2914 100644
--- a/post/lib_powerpc/cmpi.c
+++ b/post/lib_powerpc/cmpi.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/complex.c b/post/lib_powerpc/complex.c
index 751bce673785..2899dece2c1d 100644
--- a/post/lib_powerpc/complex.c
+++ b/post/lib_powerpc/complex.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/cpu.c b/post/lib_powerpc/cpu.c
index 98a8c6392c3a..e41e6b3b97b1 100644
--- a/post/lib_powerpc/cpu.c
+++ b/post/lib_powerpc/cpu.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 
 /*
diff --git a/post/lib_powerpc/cr.c b/post/lib_powerpc/cr.c
index 3c7b61138467..1e011f12159e 100644
--- a/post/lib_powerpc/cr.c
+++ b/post/lib_powerpc/cr.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/fpu/20001122-1.c b/post/lib_powerpc/fpu/20001122-1.c
index 9c1c886fc4f7..d6b7bc656f69 100644
--- a/post/lib_powerpc/fpu/20001122-1.c
+++ b/post/lib_powerpc/fpu/20001122-1.c
@@ -7,7 +7,7 @@
  * This file is originally a part of the GCC testsuite.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/fpu/20010114-2.c b/post/lib_powerpc/fpu/20010114-2.c
index 01bac5003836..5e79c4c69843 100644
--- a/post/lib_powerpc/fpu/20010114-2.c
+++ b/post/lib_powerpc/fpu/20010114-2.c
@@ -7,7 +7,7 @@
  * This file is originally a part of the GCC testsuite.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/fpu/20010226-1.c b/post/lib_powerpc/fpu/20010226-1.c
index cc4aa0dca645..a65ffcedb49a 100644
--- a/post/lib_powerpc/fpu/20010226-1.c
+++ b/post/lib_powerpc/fpu/20010226-1.c
@@ -7,7 +7,7 @@
  * This file is originally a part of the GCC testsuite.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/fpu/980619-1.c b/post/lib_powerpc/fpu/980619-1.c
index 111a2013fb58..8ad256efa9f8 100644
--- a/post/lib_powerpc/fpu/980619-1.c
+++ b/post/lib_powerpc/fpu/980619-1.c
@@ -7,7 +7,7 @@
  * This file is originally a part of the GCC testsuite.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/fpu/acc1.c b/post/lib_powerpc/fpu/acc1.c
index 63cc3eeafc30..408c391ce42b 100644
--- a/post/lib_powerpc/fpu/acc1.c
+++ b/post/lib_powerpc/fpu/acc1.c
@@ -7,7 +7,7 @@
  * This file is originally a part of the GCC testsuite.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/fpu/compare-fp-1.c b/post/lib_powerpc/fpu/compare-fp-1.c
index 4b4589664f12..4b8537ea3db3 100644
--- a/post/lib_powerpc/fpu/compare-fp-1.c
+++ b/post/lib_powerpc/fpu/compare-fp-1.c
@@ -9,7 +9,7 @@
  * This file is originally a part of the GCC testsuite.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/fpu/fpu.c b/post/lib_powerpc/fpu/fpu.c
index 59109f71e36a..2afe27ab3559 100644
--- a/post/lib_powerpc/fpu/fpu.c
+++ b/post/lib_powerpc/fpu/fpu.c
@@ -6,7 +6,7 @@
  * Author: Sergei Poselenov <sposelenov@emcraft.com>
  */
 
-#include <common.h>
+#include <config.h>
 
 /*
  * FPU test
diff --git a/post/lib_powerpc/fpu/mul-subnormal-single-1.c b/post/lib_powerpc/fpu/mul-subnormal-single-1.c
index 891aa95685fe..6b86e55e409e 100644
--- a/post/lib_powerpc/fpu/mul-subnormal-single-1.c
+++ b/post/lib_powerpc/fpu/mul-subnormal-single-1.c
@@ -9,7 +9,7 @@
  * numbers) are rounded to within 0.5 ulp.  PR other/14354.
  */
 
-#include <common.h>
+#include <config.h>
 
 #include <post.h>
 
diff --git a/post/lib_powerpc/load.c b/post/lib_powerpc/load.c
index e4ac6bf186f9..0a2a4222846c 100644
--- a/post/lib_powerpc/load.c
+++ b/post/lib_powerpc/load.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/multi.c b/post/lib_powerpc/multi.c
index 4df45790ab65..6f991443741c 100644
--- a/post/lib_powerpc/multi.c
+++ b/post/lib_powerpc/multi.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 #include <log.h>
 
diff --git a/post/lib_powerpc/rlwimi.c b/post/lib_powerpc/rlwimi.c
index da2191322570..35a9e9b83bf0 100644
--- a/post/lib_powerpc/rlwimi.c
+++ b/post/lib_powerpc/rlwimi.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/rlwinm.c b/post/lib_powerpc/rlwinm.c
index b0b976f98af4..2995eb358ef4 100644
--- a/post/lib_powerpc/rlwinm.c
+++ b/post/lib_powerpc/rlwinm.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/rlwnm.c b/post/lib_powerpc/rlwnm.c
index 22cd4568fc88..3ba3a7607ab3 100644
--- a/post/lib_powerpc/rlwnm.c
+++ b/post/lib_powerpc/rlwnm.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/srawi.c b/post/lib_powerpc/srawi.c
index a103df75eb1a..bd59ac4f36b5 100644
--- a/post/lib_powerpc/srawi.c
+++ b/post/lib_powerpc/srawi.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/store.c b/post/lib_powerpc/store.c
index 71a4b6aba431..470ea37e77d0 100644
--- a/post/lib_powerpc/store.c
+++ b/post/lib_powerpc/store.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/string.c b/post/lib_powerpc/string.c
index 21e02bcb2664..c4ea5cf9ba9d 100644
--- a/post/lib_powerpc/string.c
+++ b/post/lib_powerpc/string.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/three.c b/post/lib_powerpc/three.c
index 68339b05ef27..e65d7f023f95 100644
--- a/post/lib_powerpc/three.c
+++ b/post/lib_powerpc/three.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/threei.c b/post/lib_powerpc/threei.c
index 885dd8cb095e..0c3a2e6674b8 100644
--- a/post/lib_powerpc/threei.c
+++ b/post/lib_powerpc/threei.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/threex.c b/post/lib_powerpc/threex.c
index 62ac713ecff7..24ebc98d48df 100644
--- a/post/lib_powerpc/threex.c
+++ b/post/lib_powerpc/threex.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/two.c b/post/lib_powerpc/two.c
index 7985669ba6eb..28c70ec88977 100644
--- a/post/lib_powerpc/two.c
+++ b/post/lib_powerpc/two.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/lib_powerpc/twox.c b/post/lib_powerpc/twox.c
index 33d1a1d8d91d..7f6a898d6397 100644
--- a/post/lib_powerpc/twox.c
+++ b/post/lib_powerpc/twox.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <irq_func.h>
 
 /*
diff --git a/post/post.c b/post/post.c
index 946d9094d451..705f94ccc919 100644
--- a/post/post.c
+++ b/post/post.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <env.h>
 #include <log.h>
diff --git a/post/tests.c b/post/tests.c
index 8cea428fcdc7..208710a48ba7 100644
--- a/post/tests.c
+++ b/post/tests.c
@@ -4,7 +4,8 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
+#include <linux/kernel.h>
 
 #include <post.h>
 
-- 
2.34.1

