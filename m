Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EBEC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2365888A23;
	Tue, 30 Apr 2024 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IN2qooez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936B2889A2; Tue, 30 Apr 2024 15:36:17 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44D188A1D
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a06b12027cso59948216d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484170; x=1715088970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZBiflpcthKhHqdqbnciDBRUtQzPjARq6C9GrbLK5QY=;
 b=IN2qooezC6prThkuRF6pd0myagJNLknGoMR+DfmscVNct/L2vzSsSdkpFa5D5Kpny2
 6uk8nxblTKYW/tXupov9MxJahNCZ9GyUry8BEr8gTp65xRQ6lX7ETVf5mQ1bSoz4fq+S
 SmOIc6g7zdj9vkiUeEx9RNbc2O8NbkNQV4O6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484170; x=1715088970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZBiflpcthKhHqdqbnciDBRUtQzPjARq6C9GrbLK5QY=;
 b=xU4LZ2YbT/TZK8BHDUOCkjfnp/1c9Wkw5ZffKb7DpizFSye/PyhKiy8iQwjSuZwYeN
 s9szfa0ZBYd+6tUaDsazN6ZEV9MAP+Z4LbePLNsjaF7IMOCXFCghbkX7c5crQnxM6+5X
 Nl7DgYtX2JztM8XyHqwZ3Xf8toLbqwVXtyPLwrieBGbT0/CBKbaBM8SAsmoc0/mwXgBj
 +OP3X/q05MmApSPoMy+SMHFyrVOxzXnGz/uAyZIQDGHF0VLz7txsGVIwf/aDM03+smlE
 SvTRnqEZvlqI2NpT5GwOgtexOSw9uqcqGukPfHaD0SOuS8ayg224yKPCOYHj372hkMmu
 nDnw==
X-Gm-Message-State: AOJu0YyVqtahfKEgxE67JeV+CTmElu1kPX9fLBYCOTF2YCZXBGcLXFd/
 27SJBdWcGD053chfCQj/omVV9yB2ds5YsvZwOo0SleQZDPdRaP4uTgnP8y7M2Ish0v0QIPseMwb
 ZVsR3TA==
X-Google-Smtp-Source: AGHT+IEUH6Zx2jzhBuo+9h0pL2AEvMstK31jjx0C7/lEG0hXjve2PmEYj5u0ASS81uMEx7vXdTnJuA==
X-Received: by 2002:ad4:56e3:0:b0:6a0:deb6:7b0f with SMTP id
 cr3-20020ad456e3000000b006a0deb67b0fmr2625066qvb.29.1714484170523; 
 Tue, 30 Apr 2024 06:36:10 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 07/33] arm: sunxi: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:33 -0600
Message-Id: <20240430133559.1836389-7-trini@konsulko.com>
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

Remove <common.h> from all mach-sunxi and board/sunxi files and when
needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c                     | 1 -
 arch/arm/cpu/armv7/sunxi/sram.c                     | 1 -
 arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c         | 1 -
 arch/arm/mach-sunxi/dram_timings/ddr3_1333.c        | 1 -
 arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c   | 1 -
 arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c      | 1 -
 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c | 1 -
 arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c     | 1 -
 arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c        | 1 -
 arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c     | 1 -
 board/sunxi/board.c                                 | 1 -
 board/sunxi/chip.c                                  | 1 -
 board/sunxi/dram_sun4i_auto.c                       | 1 -
 board/sunxi/dram_sun5i_auto.c                       | 1 -
 board/sunxi/gmac.c                                  | 1 -
 15 files changed, 15 deletions(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 5cb8cfa6cf3f..4c30f3294b7a 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -7,7 +7,6 @@
  * which was based on code by Carl van Schaik <carl@ok-labs.com>.
  */
 #include <config.h>
-#include <common.h>
 #include <asm/cache.h>
 
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/cpu/armv7/sunxi/sram.c b/arch/arm/cpu/armv7/sunxi/sram.c
index 28ff6a1b7c23..bc25719c9c46 100644
--- a/arch/arm/cpu/armv7/sunxi/sram.c
+++ b/arch/arm/cpu/armv7/sunxi/sram.c
@@ -9,7 +9,6 @@
  * SRAM init for older sunxi SoCs.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c b/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c
index 9077f86a8b4c..3666dddca15c 100644
--- a/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c
+++ b/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c
index 0471e8a49e58..ceaafd6ec6fa 100644
--- a/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 232b4fe2df7f..3faf8d5bd974 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -11,7 +11,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index b6d6a6874682..ce2ffa7a020e 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -11,7 +11,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index c11cb8678f64..e6446b9180da 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -9,7 +9,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
index 2136ca3a4cb0..afe8e25c7f58 100644
--- a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
@@ -19,7 +19,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
index 10008601134a..c243b574406d 100644
--- a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
@@ -6,7 +6,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c b/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c
index bd57e2f6aac2..bc47a4638533 100644
--- a/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c
+++ b/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 1313b01dcea5..ed86f1df5dc4 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -10,7 +10,6 @@
  * Some board init for the Allwinner A10-evb board.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <dm.h>
 #include <env.h>
diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
index eeee6319e799..270af2506d21 100644
--- a/board/sunxi/chip.c
+++ b/board/sunxi/chip.c
@@ -5,7 +5,6 @@
  * Based on initial code from Maxime Ripard
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <dm.h>
 #include <w1.h>
diff --git a/board/sunxi/dram_sun4i_auto.c b/board/sunxi/dram_sun4i_auto.c
index 547d1c0cb4de..4b78919a5baa 100644
--- a/board/sunxi/dram_sun4i_auto.c
+++ b/board/sunxi/dram_sun4i_auto.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <init.h>
 #include <asm/arch/dram.h>
 
diff --git a/board/sunxi/dram_sun5i_auto.c b/board/sunxi/dram_sun5i_auto.c
index 517506ccc4f0..8976e3b16d68 100644
--- a/board/sunxi/dram_sun5i_auto.c
+++ b/board/sunxi/dram_sun5i_auto.c
@@ -1,6 +1,5 @@
 /* DRAM parameters for auto dram configuration on sun5i and sun7i */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/dram.h>
 
diff --git a/board/sunxi/gmac.c b/board/sunxi/gmac.c
index 2a885305ebe0..710e821e3fc8 100644
--- a/board/sunxi/gmac.c
+++ b/board/sunxi/gmac.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <asm/io.h>
-- 
2.34.1

