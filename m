Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C34C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8304388A40;
	Tue, 30 Apr 2024 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pwQBq1YW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC8888A20; Tue, 30 Apr 2024 15:36:17 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32CE888A2B
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78f0440656eso355307785a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484172; x=1715088972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDMXVwpB8shSFBq9hn8qNyrjb0hsAo2x2dGPLXy4r1k=;
 b=pwQBq1YWU1hEICoBknhTxkJ01HMO55kz/K59YsMLadC4LCqJAT127NR3VtQWvSuAvH
 HAQCjno2wniDs+/47iL2QZvpI+9YJkxkiqzefPvwXcqsncd5p/1jIWyT+90uorXt0XUH
 IP7oSrMgKmvNsac9nbkytAoYqWLckERPeE/40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484172; x=1715088972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDMXVwpB8shSFBq9hn8qNyrjb0hsAo2x2dGPLXy4r1k=;
 b=IL2AX/tCSiBKEholkZSnA69uZ3neLzcQUL80546JQcgNj7qWQATHqxZbhYAV/sz7Iz
 wVqImbM+66ScHqOA5sQemOaYH6Dwc4eVCMZyYwOFlxcOCLTjdX2l4tyPepZO9Vrd4J3j
 4NGpN85ryHJl13GY0dq24dEFjNo7uiQ39j1Ey81NcG8OjpgrSMqeKA7Vv7POCbFKMclp
 ld/cyBS9EzabX60+qEXa9/b78RgDUXKjdIZSCwS7BMC1g+NKen6fK5PzEw8uTVHYhlLN
 EKobg4ElJRoc8DiPt6ytlSsFd9S2YII92azXcu+wjoDCYx8zClpmAicHMVMl7WdYu1Hy
 vbBw==
X-Gm-Message-State: AOJu0YzMejNyVJMwv8xHxLYrTqKaMR4wJMOjfB1EfCQUilTMeW7cO5zk
 BAG6/SQ8djHJcUcpnrs+yrYwBRWd4w92p3RfXzv7+63iB2k+9cYjDlnQcwxDuoX6x9yHqvbT9NL
 zBE1iww==
X-Google-Smtp-Source: AGHT+IHYvO4Say9dzkXVOd5K3pGMT8xQ4y2VurZAXgF5jaLu3YqWTO9ISPRfNzsrs8IFZzWhtcrIsA==
X-Received: by 2002:a05:6214:5292:b0:6a0:9b16:c33f with SMTP id
 kj18-20020a056214529200b006a09b16c33fmr2271486qvb.40.1714484172531; 
 Tue, 30 Apr 2024 06:36:12 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>
Subject: [PATCH 09/33] arm: s5pc1xx: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:35 -0600
Message-Id: <20240430133559.1836389-9-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-s5pc1xx and cpu/armv7/s5p-common files
and when needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Minkyu Kang <mk7.kang@samsung.com>
---
 arch/arm/cpu/armv7/s5p-common/cpu_info.c | 1 -
 arch/arm/cpu/armv7/s5p-common/pwm.c      | 2 +-
 arch/arm/cpu/armv7/s5p-common/sromc.c    | 2 +-
 arch/arm/cpu/armv7/s5p-common/timer.c    | 1 -
 arch/arm/mach-s5pc1xx/cache.c            | 1 -
 arch/arm/mach-s5pc1xx/clock.c            | 2 +-
 arch/arm/mach-s5pc1xx/pinmux.c           | 1 -
 7 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/cpu/armv7/s5p-common/cpu_info.c b/arch/arm/cpu/armv7/s5p-common/cpu_info.c
index fb2920950d42..4331dde7643d 100644
--- a/arch/arm/cpu/armv7/s5p-common/cpu_info.c
+++ b/arch/arm/cpu/armv7/s5p-common/cpu_info.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2009 Samsung Electronics
  * Minkyu Kang <mk7.kang@samsung.com>
  */
-#include <common.h>
 #include <display_options.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/arch/arm/cpu/armv7/s5p-common/pwm.c b/arch/arm/cpu/armv7/s5p-common/pwm.c
index 5068327d3c5f..986b585b70e9 100644
--- a/arch/arm/cpu/armv7/s5p-common/pwm.c
+++ b/arch/arm/cpu/armv7/s5p-common/pwm.c
@@ -5,7 +5,7 @@
  * Donghwa Lee <dh09.lee@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <asm/arch/pwm.h>
diff --git a/arch/arm/cpu/armv7/s5p-common/sromc.c b/arch/arm/cpu/armv7/s5p-common/sromc.c
index 0fc170936ae4..c0035fb18ebb 100644
--- a/arch/arm/cpu/armv7/s5p-common/sromc.c
+++ b/arch/arm/cpu/armv7/s5p-common/sromc.c
@@ -4,7 +4,7 @@
  * Naveen Krishna Ch <ch.naveen@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/sromc.h>
 
diff --git a/arch/arm/cpu/armv7/s5p-common/timer.c b/arch/arm/cpu/armv7/s5p-common/timer.c
index 9d981cce145d..12994ecc843e 100644
--- a/arch/arm/cpu/armv7/s5p-common/timer.c
+++ b/arch/arm/cpu/armv7/s5p-common/timer.c
@@ -6,7 +6,6 @@
  * Minkyu Kang <mk7.kang@samsung.com>
  */
 
-#include <common.h>
 #include <div64.h>
 #include <init.h>
 #include <time.h>
diff --git a/arch/arm/mach-s5pc1xx/cache.c b/arch/arm/mach-s5pc1xx/cache.c
index b390bdf82784..f0aec7c0fe02 100644
--- a/arch/arm/mach-s5pc1xx/cache.c
+++ b/arch/arm/mach-s5pc1xx/cache.c
@@ -7,7 +7,6 @@
  * based on arch/arm/cpu/armv7/omap3/cache.S
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm/mach-s5pc1xx/clock.c b/arch/arm/mach-s5pc1xx/clock.c
index c90c341b5082..b92ce1152f66 100644
--- a/arch/arm/mach-s5pc1xx/clock.c
+++ b/arch/arm/mach-s5pc1xx/clock.c
@@ -5,7 +5,7 @@
  * Heungjun Kim <riverful.kim@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-s5pc1xx/pinmux.c b/arch/arm/mach-s5pc1xx/pinmux.c
index 818d75164dee..23b9252827ae 100644
--- a/arch/arm/mach-s5pc1xx/pinmux.c
+++ b/arch/arm/mach-s5pc1xx/pinmux.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <asm/arch/pinmux.h>
 
 int exynos_pinmux_config(int peripheral, int flags)
-- 
2.34.1

