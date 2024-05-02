Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BE7C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDBC88C72;
	Thu,  2 May 2024 03:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J6Ff5slM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4BAF88CBE; Thu,  2 May 2024 03:33:38 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF11C88CB6
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43ad398f164so20691831cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613614; x=1715218414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIPsr/wXRKMqSJVQKzzRVNOOI3KiwQ6u3No+BAgP9gc=;
 b=J6Ff5slM/l7cp+QgJJnODUBMkUWm9OzEEigHB8mBy7+t3+Vf+nydBXv11/r9v4vSWW
 yK60PSx9YdMjj1Orr/Y+XoGRHj5786hTgoAMFab8n9EVNnQVch7mZwAvLkN+1vx6vQ4P
 o/COtW925xPoToiL/e02mDzZe+xRHW/oMT+Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613614; x=1715218414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIPsr/wXRKMqSJVQKzzRVNOOI3KiwQ6u3No+BAgP9gc=;
 b=If8ak/rywSNDLViD3RNMgLQmymKVUnpg5jERziuSWtTqCRY3oW6bZv1WS/Xj+zo6iN
 l+Du8IeyS8bveL6Ocpu1M9PduqKqqISua6r3xchV0w+fARgwbhu+9taq02fRSgq30cwh
 3RvqxlflIKfdsEhKTMPYpyXYu4ncWzoEYMhyoJV/pZaspqen09GLDXG3XDKUVEX2F6/n
 /PbSCyxQ7f9FmnuwU41RzESqOEwy8edOmYWP/gOgycdDbC7vs/Dm/TW0TFyEDWNqDIYP
 fnpUOfk0TlZerRtnkbSBBYnQwcyFmzc9l8OS4vA0ypV18jabESavCIT+Rjjs8KJhKUaA
 E6Yg==
X-Gm-Message-State: AOJu0YwKKgF6z+9+Bvr5XZF3XTFywhD4nxxVMEcrHN7aBhtvk4GZCodQ
 ABfyycAOg8eqQ+AhVU8iHN8cVz6bUEi7sonyUWcUkKPlyC8Kc+34WFW6PQYxKfEliwHctV93nfD
 +vF22XkZW
X-Google-Smtp-Source: AGHT+IE7LMT2pgXv8g0DblqdpRcugW1wbwpGDCroXLD4GwlsLa9l8oYGlpH0/AACA2gHR8Qg7th2oQ==
X-Received: by 2002:a05:622a:345:b0:43a:8877:e372 with SMTP id
 r5-20020a05622a034500b0043a8877e372mr534916qtw.48.1714613614203; 
 Wed, 01 May 2024 18:33:34 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 58/81] rtc: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:15 -0600
Message-Id: <20240502013138.2383421-58-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Michal Simek <michal.simek@amd.com>
---
 drivers/rtc/abx80x.c       | 1 -
 drivers/rtc/davinci.c      | 1 -
 drivers/rtc/ds1307.c       | 2 +-
 drivers/rtc/ds1337.c       | 2 +-
 drivers/rtc/ds1374.c       | 2 +-
 drivers/rtc/ds3231.c       | 2 +-
 drivers/rtc/ds3232.c       | 1 -
 drivers/rtc/emul_rtc.c     | 2 +-
 drivers/rtc/ht1380.c       | 1 -
 drivers/rtc/i2c_rtc_emul.c | 1 -
 drivers/rtc/isl1208.c      | 1 -
 drivers/rtc/m41t62.c       | 2 +-
 drivers/rtc/mc13xxx-rtc.c  | 1 -
 drivers/rtc/mc146818.c     | 1 -
 drivers/rtc/mcfrtc.c       | 1 -
 drivers/rtc/mvrtc.c        | 1 -
 drivers/rtc/mxsrtc.c       | 1 -
 drivers/rtc/pcf2127.c      | 1 -
 drivers/rtc/pcf8563.c      | 2 +-
 drivers/rtc/pl031.c        | 1 -
 drivers/rtc/pt7c4338.c     | 2 +-
 drivers/rtc/rtc-uclass.c   | 1 -
 drivers/rtc/rv3029.c       | 1 -
 drivers/rtc/rv8803.c       | 1 -
 drivers/rtc/rx8010sj.c     | 2 +-
 drivers/rtc/rx8025.c       | 1 -
 drivers/rtc/s35392a.c      | 1 -
 drivers/rtc/sandbox_rtc.c  | 1 -
 drivers/rtc/stm32_rtc.c    | 1 -
 drivers/rtc/zynqmp_rtc.c   | 1 -
 30 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/rtc/abx80x.c b/drivers/rtc/abx80x.c
index 823aff03f5f0..1235b840ab04 100644
--- a/drivers/rtc/abx80x.c
+++ b/drivers/rtc/abx80x.c
@@ -12,7 +12,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <rtc.h>
diff --git a/drivers/rtc/davinci.c b/drivers/rtc/davinci.c
index c7ce41bbf5cc..a20b73e1990a 100644
--- a/drivers/rtc/davinci.c
+++ b/drivers/rtc/davinci.c
@@ -4,7 +4,6 @@
  * Heiko Schocher <hs@denx.de>
  * Copyright (C) 2021 Dario Binacchi <dariobin@libero.it>
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <clk.h>
diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index 0e9d3d24dd89..ba06ff9f0bee 100644
--- a/drivers/rtc/ds1307.c
+++ b/drivers/rtc/ds1307.c
@@ -13,7 +13,7 @@
  * based on ds1337.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/ds1337.c b/drivers/rtc/ds1337.c
index 2c780ab8edfa..7eccf1cb8c54 100644
--- a/drivers/rtc/ds1337.c
+++ b/drivers/rtc/ds1337.c
@@ -11,7 +11,7 @@
  * DS1337 Real Time Clock (RTC).
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/ds1374.c b/drivers/rtc/ds1374.c
index 89442f9386ba..895dbbaf1c74 100644
--- a/drivers/rtc/ds1374.c
+++ b/drivers/rtc/ds1374.c
@@ -13,7 +13,7 @@
  * based on ds1337.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <rtc.h>
 #include <i2c.h>
diff --git a/drivers/rtc/ds3231.c b/drivers/rtc/ds3231.c
index bd32ed2dbf91..d6267d660d0d 100644
--- a/drivers/rtc/ds3231.c
+++ b/drivers/rtc/ds3231.c
@@ -14,7 +14,7 @@
  * copied from ds1337.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/ds3232.c b/drivers/rtc/ds3232.c
index 16501cfe5d3f..7314ba219dac 100644
--- a/drivers/rtc/ds3232.c
+++ b/drivers/rtc/ds3232.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019, Vaisala Oyj
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/rtc/emul_rtc.c b/drivers/rtc/emul_rtc.c
index 6f47d82522ba..97a8d9bb7df5 100644
--- a/drivers/rtc/emul_rtc.c
+++ b/drivers/rtc/emul_rtc.c
@@ -5,11 +5,11 @@
  * This driver emulates a real time clock based on timer ticks.
  */
 
-#include <common.h>
 #include <div64.h>
 #include <dm.h>
 #include <env.h>
 #include <rtc.h>
+#include <time.h>
 #include <timestamp.h>
 
 /**
diff --git a/drivers/rtc/ht1380.c b/drivers/rtc/ht1380.c
index 85fcee3e71e6..c202261e9999 100644
--- a/drivers/rtc/ht1380.c
+++ b/drivers/rtc/ht1380.c
@@ -15,7 +15,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <rtc.h>
 #include <bcd.h>
diff --git a/drivers/rtc/i2c_rtc_emul.c b/drivers/rtc/i2c_rtc_emul.c
index c307d6036dd5..ea11c72c964c 100644
--- a/drivers/rtc/i2c_rtc_emul.c
+++ b/drivers/rtc/i2c_rtc_emul.c
@@ -13,7 +13,6 @@
  * time-keeping. It does not change the system time.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
diff --git a/drivers/rtc/isl1208.c b/drivers/rtc/isl1208.c
index 59a60b75b307..83db505afe9e 100644
--- a/drivers/rtc/isl1208.c
+++ b/drivers/rtc/isl1208.c
@@ -11,7 +11,6 @@
  * ISL1208 Real Time Clock (RTC).
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <rtc.h>
diff --git a/drivers/rtc/m41t62.c b/drivers/rtc/m41t62.c
index 891fe09d311b..7bfea9e0b315 100644
--- a/drivers/rtc/m41t62.c
+++ b/drivers/rtc/m41t62.c
@@ -16,7 +16,7 @@
 
 /* #define	DEBUG	*/
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/mc13xxx-rtc.c b/drivers/rtc/mc13xxx-rtc.c
index 6c2aef89758b..9e396bcdae95 100644
--- a/drivers/rtc/mc13xxx-rtc.c
+++ b/drivers/rtc/mc13xxx-rtc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2008, Guennadi Liakhovetski <lg@denx.de>
  */
 
-#include <common.h>
 #include <rtc.h>
 #include <spi.h>
 #include <power/pmic.h>
diff --git a/drivers/rtc/mc146818.c b/drivers/rtc/mc146818.c
index 03ce081d5764..c0d86c6d063d 100644
--- a/drivers/rtc/mc146818.c
+++ b/drivers/rtc/mc146818.c
@@ -8,7 +8,6 @@
  * Date & Time support for the MC146818 (PIXX4) RTC
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <rtc.h>
diff --git a/drivers/rtc/mcfrtc.c b/drivers/rtc/mcfrtc.c
index d2ac889c3095..b5cc6b968816 100644
--- a/drivers/rtc/mcfrtc.c
+++ b/drivers/rtc/mcfrtc.c
@@ -4,7 +4,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 
 #include <command.h>
 #include <rtc.h>
diff --git a/drivers/rtc/mvrtc.c b/drivers/rtc/mvrtc.c
index 50240d57fa9e..f070c681b94e 100644
--- a/drivers/rtc/mvrtc.c
+++ b/drivers/rtc/mvrtc.c
@@ -8,7 +8,6 @@
  * Date & Time support for Marvell Integrated RTC
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <rtc.h>
diff --git a/drivers/rtc/mxsrtc.c b/drivers/rtc/mxsrtc.c
index be899a925408..69d22a4bdcb6 100644
--- a/drivers/rtc/mxsrtc.c
+++ b/drivers/rtc/mxsrtc.c
@@ -6,7 +6,6 @@
  * on behalf of DENX Software Engineering GmbH
  */
 
-#include <common.h>
 #include <rtc.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
diff --git a/drivers/rtc/pcf2127.c b/drivers/rtc/pcf2127.c
index 2f3fafb4968f..27a340f07d68 100644
--- a/drivers/rtc/pcf2127.c
+++ b/drivers/rtc/pcf2127.c
@@ -5,7 +5,6 @@
 
 /*	#define	DEBUG	*/
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/rtc/pcf8563.c b/drivers/rtc/pcf8563.c
index 91a412440b85..03bef68051ba 100644
--- a/drivers/rtc/pcf8563.c
+++ b/drivers/rtc/pcf8563.c
@@ -10,7 +10,7 @@
 
 /* #define	DEBUG	*/
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/pl031.c b/drivers/rtc/pl031.c
index a1d376611d65..855ee9134168 100644
--- a/drivers/rtc/pl031.c
+++ b/drivers/rtc/pl031.c
@@ -6,7 +6,6 @@
  * reference linux-2.6.20.6/drivers/rtc/rtc-pl031.c
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/rtc/pt7c4338.c b/drivers/rtc/pt7c4338.c
index e0a7bd3662fb..79df07814a6b 100644
--- a/drivers/rtc/pt7c4338.c
+++ b/drivers/rtc/pt7c4338.c
@@ -18,7 +18,7 @@
  * It has 56 bytes of nonvolatile RAM.
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/rtc-uclass.c b/drivers/rtc/rtc-uclass.c
index e5ae6ea4d5f3..8f6c0c6a0a78 100644
--- a/drivers/rtc/rtc-uclass.c
+++ b/drivers/rtc/rtc-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_RTC
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/rtc/rv3029.c b/drivers/rtc/rv3029.c
index 9c53c7f7dbc7..a82acec6f7e5 100644
--- a/drivers/rtc/rv3029.c
+++ b/drivers/rtc/rv3029.c
@@ -7,7 +7,6 @@
  *   Michael Buesch <m@bues.ch>
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/rtc/rv8803.c b/drivers/rtc/rv8803.c
index 06a4ae89fa96..82b43722ff51 100644
--- a/drivers/rtc/rv8803.c
+++ b/drivers/rtc/rv8803.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/rtc/rx8010sj.c b/drivers/rtc/rx8010sj.c
index bf93b557748b..0d778f4c328e 100644
--- a/drivers/rtc/rx8010sj.c
+++ b/drivers/rtc/rx8010sj.c
@@ -17,7 +17,7 @@
  */
 
 #include <command.h>
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <i2c.h>
 #include <rtc.h>
diff --git a/drivers/rtc/rx8025.c b/drivers/rtc/rx8025.c
index 1394c2306a44..c7895244283c 100644
--- a/drivers/rtc/rx8025.c
+++ b/drivers/rtc/rx8025.c
@@ -8,7 +8,6 @@
  * Epson RX8025 RTC driver.
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/rtc/s35392a.c b/drivers/rtc/s35392a.c
index 80f55c86233a..03fb9a0be914 100644
--- a/drivers/rtc/s35392a.c
+++ b/drivers/rtc/s35392a.c
@@ -18,7 +18,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <linux/bitrev.h>
diff --git a/drivers/rtc/sandbox_rtc.c b/drivers/rtc/sandbox_rtc.c
index 657e5c7be2cf..4404501c2f65 100644
--- a/drivers/rtc/sandbox_rtc.c
+++ b/drivers/rtc/sandbox_rtc.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <rtc.h>
diff --git a/drivers/rtc/stm32_rtc.c b/drivers/rtc/stm32_rtc.c
index ec7584c3d70c..ee70c11c8bcb 100644
--- a/drivers/rtc/stm32_rtc.c
+++ b/drivers/rtc/stm32_rtc.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_RTC
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
index ab9b93ca9793..15122a048382 100644
--- a/drivers/rtc/zynqmp_rtc.c
+++ b/drivers/rtc/zynqmp_rtc.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_RTC
 
-#include <common.h>
 #include <dm.h>
 #include <rtc.h>
 #include <asm/io.h>
-- 
2.34.1

