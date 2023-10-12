Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08240CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CB586EC5;
	Fri, 13 Oct 2023 01:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fr9KhAV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BDFF86D3F; Fri, 13 Oct 2023 01:04:50 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4DDE86E42
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7be61fe74so19601787b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151845; x=1697756645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=We9n4I/AhHSllFzQJ6yhqbkBuIxLBQgVcxL+OoVwbCI=;
 b=fr9KhAV4qEv0dJ9vJHGWXg/wn8tCptBxfRn0PFw0lBpwQ8tnxLXVRBVzfIKwLqJqxR
 gGwASIexHzaFJVv6QKpApBPG/ttr5473mgCHGrGcb5Wf4a19R+4z79cMd6EMztC6/Jfi
 lJhLxBmgEVJaOZ5XTksn/c6SPXY5w3p72q+7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151845; x=1697756645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=We9n4I/AhHSllFzQJ6yhqbkBuIxLBQgVcxL+OoVwbCI=;
 b=j99a5vexhnFemRVuBj2z5k4fZXaNryJ/w6KpPlUCkYOdjvr6/Q3WsybP9SWaYuXe/C
 Uz4fhyK2i5uVaGCcFnTNiFDQ3JitEIGCQ3Fx9Y5EDZrM4AXwkFE6AzSX8fED6LW1pSN/
 0DwSqo1Fwti25AsWsTQLthrJQFNbl3ln1bThnPu+G/mbuEnt9RmTFpgipNxubIfdAvq5
 YvGzmUxsHij/jLF+y22ox6m0t+d56Bx0sc/l6PiiZphV1xlzeqNQThyogyvB06txjV6L
 2tpkTxForlw0Pl9Ij5aycr9h5FsP8UGJgQRy3ED/EdXzcM9Ep1Y3vzjpV/xheOyq8cXx
 voWA==
X-Gm-Message-State: AOJu0YxzKMgzU68dm42kVnDfXbusJDxUNbaKGXKzq0bbyGoTriMwWRYk
 KdJwrORFA0cLsb2OOuf8P0ERpm1syBiCuFnt33IvVg==
X-Google-Smtp-Source: AGHT+IFYTJzs+xDXqrs73YNXA9inCDMORB5dpxq8rIWTUJ/zTTnJOwKQG/8fy9Ka0f62YBlOkK09Jw==
X-Received: by 2002:a0d:e2c6:0:b0:5a7:cadb:c721 with SMTP id
 l189-20020a0de2c6000000b005a7cadbc721mr8680645ywe.12.1697151845227; 
 Thu, 12 Oct 2023 16:04:05 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH 6/7] mips: Remove common.h usage
Date: Thu, 12 Oct 2023 19:03:58 -0400
Message-Id: <20231012230359.2005249-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012230359.2005249-1-trini@konsulko.com>
References: <20231012230359.2005249-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We can remove common.h from most cases of the code here, and only a few
places need an additional header instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
---
 arch/mips/cpu/cpu.c                    | 1 -
 arch/mips/cpu/interrupts.c             | 1 -
 arch/mips/cpu/time.c                   | 1 -
 arch/mips/include/asm/cacheops.h       | 1 +
 arch/mips/lib/boot.c                   | 1 -
 arch/mips/lib/bootm.c                  | 1 -
 arch/mips/lib/cache.c                  | 1 -
 arch/mips/lib/reloc.c                  | 1 -
 arch/mips/lib/spl.c                    | 1 -
 arch/mips/lib/stack.c                  | 1 -
 arch/mips/lib/traps.c                  | 3 ++-
 arch/mips/mach-ath79/ar933x/clk.c      | 1 -
 arch/mips/mach-ath79/ar933x/ddr.c      | 1 -
 arch/mips/mach-ath79/ar934x/clk.c      | 1 -
 arch/mips/mach-ath79/ar934x/cpu.c      | 2 --
 arch/mips/mach-ath79/ar934x/ddr.c      | 1 -
 arch/mips/mach-ath79/cpu.c             | 1 -
 arch/mips/mach-ath79/dram.c            | 1 -
 arch/mips/mach-ath79/qca953x/clk.c     | 1 -
 arch/mips/mach-ath79/qca953x/ddr.c     | 1 -
 arch/mips/mach-ath79/qca956x/clk.c     | 1 -
 arch/mips/mach-ath79/qca956x/cpu.c     | 2 --
 arch/mips/mach-ath79/qca956x/ddr.c     | 1 -
 arch/mips/mach-ath79/reset.c           | 1 -
 arch/mips/mach-bmips/dram.c            | 1 -
 arch/mips/mach-jz47xx/jz4780/gpio.c    | 1 -
 arch/mips/mach-jz47xx/jz4780/jz4780.c  | 1 -
 arch/mips/mach-jz47xx/jz4780/pll.c     | 1 -
 arch/mips/mach-jz47xx/jz4780/reset.c   | 1 -
 arch/mips/mach-jz47xx/jz4780/sdram.c   | 1 -
 arch/mips/mach-jz47xx/jz4780/timer.c   | 1 -
 arch/mips/mach-mscc/cpu.c              | 1 -
 arch/mips/mach-mscc/dram.c             | 1 -
 arch/mips/mach-mscc/gpio.c             | 1 -
 arch/mips/mach-mscc/include/mach/ddr.h | 1 +
 arch/mips/mach-mscc/phy.c              | 1 -
 arch/mips/mach-mscc/reset.c            | 2 --
 arch/mips/mach-mtmips/cpu.c            | 1 -
 arch/mips/mach-mtmips/ddr_cal.c        | 1 -
 arch/mips/mach-mtmips/ddr_init.c       | 1 -
 arch/mips/mach-mtmips/mt7628/ddr.c     | 1 -
 arch/mips/mach-mtmips/mt7628/init.c    | 1 -
 arch/mips/mach-mtmips/mt7628/serial.c  | 1 -
 arch/mips/mach-mtmips/spl.c            | 1 -
 arch/mips/mach-pic32/cpu.c             | 1 -
 arch/mips/mach-pic32/reset.c           | 1 -
 46 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/arch/mips/cpu/cpu.c b/arch/mips/cpu/cpu.c
index f0e20da28f76..acfc9dc43f17 100644
--- a/arch/mips/cpu/cpu.c
+++ b/arch/mips/cpu/cpu.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <init.h>
 #include <linux/compiler.h>
diff --git a/arch/mips/cpu/interrupts.c b/arch/mips/cpu/interrupts.c
index b3ba9aaeae1e..f7f9a185ed49 100644
--- a/arch/mips/cpu/interrupts.c
+++ b/arch/mips/cpu/interrupts.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
  */
 
-#include <common.h>
 #include <irq_func.h>
 
 int interrupt_init(void)
diff --git a/arch/mips/cpu/time.c b/arch/mips/cpu/time.c
index 5e7a7144d027..210709d3b81d 100644
--- a/arch/mips/cpu/time.c
+++ b/arch/mips/cpu/time.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <time.h>
 #include <asm/mipsregs.h>
 
diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
index 641e2ad58dec..c1015c885e14 100644
--- a/arch/mips/include/asm/cacheops.h
+++ b/arch/mips/include/asm/cacheops.h
@@ -11,6 +11,7 @@
 #include <asm/cache.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 static inline void mips_cache(int op, const volatile void *addr)
 {
diff --git a/arch/mips/lib/boot.c b/arch/mips/lib/boot.c
index 1b29d637ce9b..749625aa9748 100644
--- a/arch/mips/lib/boot.c
+++ b/arch/mips/lib/boot.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index ab92bd06b0ee..d6d2f7d9d031 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <env.h>
 #include <image.h>
diff --git a/arch/mips/lib/cache.c b/arch/mips/lib/cache.c
index d23b38d6b93f..d365578b926c 100644
--- a/arch/mips/lib/cache.c
+++ b/arch/mips/lib/cache.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <malloc.h>
 #include <asm/cache.h>
diff --git a/arch/mips/lib/reloc.c b/arch/mips/lib/reloc.c
index 9cf6809f4068..69dd63a31d21 100644
--- a/arch/mips/lib/reloc.c
+++ b/arch/mips/lib/reloc.c
@@ -26,7 +26,6 @@
  * terminating R_MIPS_NONE reloc includes no offset.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/relocs.h>
diff --git a/arch/mips/lib/spl.c b/arch/mips/lib/spl.c
index f96fda5b2de9..b4087546dd1d 100644
--- a/arch/mips/lib/spl.c
+++ b/arch/mips/lib/spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <spl.h>
diff --git a/arch/mips/lib/stack.c b/arch/mips/lib/stack.c
index 930d21856d90..5797271ae94e 100644
--- a/arch/mips/lib/stack.c
+++ b/arch/mips/lib/stack.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/arch/mips/lib/traps.c b/arch/mips/lib/traps.c
index 7a682f256a65..40469d1be090 100644
--- a/arch/mips/lib/traps.c
+++ b/arch/mips/lib/traps.c
@@ -10,9 +10,9 @@
  * Copyright (C) 2014, Imagination Technologies Ltd.
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
@@ -20,6 +20,7 @@
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
 #include <asm/system.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/mips/mach-ath79/ar933x/clk.c b/arch/mips/mach-ath79/ar933x/clk.c
index 68d48939d7d2..86fc40a657e1 100644
--- a/arch/mips/mach-ath79/ar933x/clk.c
+++ b/arch/mips/mach-ath79/ar933x/clk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/mips/mach-ath79/ar933x/ddr.c b/arch/mips/mach-ath79/ar933x/ddr.c
index 09166ecf8f07..a932efbfbd79 100644
--- a/arch/mips/mach-ath79/ar933x/ddr.c
+++ b/arch/mips/mach-ath79/ar933x/ddr.c
@@ -4,7 +4,6 @@
  * Based on Atheros LSDK/QSDK
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
 #include <asm/types.h>
diff --git a/arch/mips/mach-ath79/ar934x/clk.c b/arch/mips/mach-ath79/ar934x/clk.c
index 6ed4057353a8..bdaa6839a2bd 100644
--- a/arch/mips/mach-ath79/ar934x/clk.c
+++ b/arch/mips/mach-ath79/ar934x/clk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <command.h>
 #include <hang.h>
diff --git a/arch/mips/mach-ath79/ar934x/cpu.c b/arch/mips/mach-ath79/ar934x/cpu.c
index 7daac0367149..f2e4ef191eb5 100644
--- a/arch/mips/mach-ath79/ar934x/cpu.c
+++ b/arch/mips/mach-ath79/ar934x/cpu.c
@@ -3,7 +3,5 @@
  * Copyright (C) 2016 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
-
 /* The lowlevel_init() is not needed on AR934x */
 void lowlevel_init(void) {}
diff --git a/arch/mips/mach-ath79/ar934x/ddr.c b/arch/mips/mach-ath79/ar934x/ddr.c
index 9df48b97ef46..e260783d9597 100644
--- a/arch/mips/mach-ath79/ar934x/ddr.c
+++ b/arch/mips/mach-ath79/ar934x/ddr.c
@@ -5,7 +5,6 @@
  * Based on RAM init sequence by Piotr Dymacz <pepe2k@gmail.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/mach-ath79/cpu.c b/arch/mips/mach-ath79/cpu.c
index 79f419088a99..24160ef11521 100644
--- a/arch/mips/mach-ath79/cpu.c
+++ b/arch/mips/mach-ath79/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/mach-ath79/dram.c b/arch/mips/mach-ath79/dram.c
index 545b1199e106..247691d3378f 100644
--- a/arch/mips/mach-ath79/dram.c
+++ b/arch/mips/mach-ath79/dram.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/sizes.h>
diff --git a/arch/mips/mach-ath79/qca953x/clk.c b/arch/mips/mach-ath79/qca953x/clk.c
index f5438ef1c8d9..379085f1ff7f 100644
--- a/arch/mips/mach-ath79/qca953x/clk.c
+++ b/arch/mips/mach-ath79/qca953x/clk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/mips/mach-ath79/qca953x/ddr.c b/arch/mips/mach-ath79/qca953x/ddr.c
index 78f2370e09ce..0eb69d3a0fb1 100644
--- a/arch/mips/mach-ath79/qca953x/ddr.c
+++ b/arch/mips/mach-ath79/qca953x/ddr.c
@@ -4,7 +4,6 @@
  * Based on Atheros LSDK/QSDK
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
 #include <asm/types.h>
diff --git a/arch/mips/mach-ath79/qca956x/clk.c b/arch/mips/mach-ath79/qca956x/clk.c
index 6a58dba91f3f..6138a915efcd 100644
--- a/arch/mips/mach-ath79/qca956x/clk.c
+++ b/arch/mips/mach-ath79/qca956x/clk.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/arch/mips/mach-ath79/qca956x/cpu.c b/arch/mips/mach-ath79/qca956x/cpu.c
index 08a8c84e72dd..7da8d0e60f19 100644
--- a/arch/mips/mach-ath79/qca956x/cpu.c
+++ b/arch/mips/mach-ath79/qca956x/cpu.c
@@ -3,7 +3,5 @@
  * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  */
 
-#include <common.h>
-
 /* The lowlevel_init() is not needed on QCA956X */
 void lowlevel_init(void) {}
diff --git a/arch/mips/mach-ath79/qca956x/ddr.c b/arch/mips/mach-ath79/qca956x/ddr.c
index f9cf8daa2242..2e46e24f4830 100644
--- a/arch/mips/mach-ath79/qca956x/ddr.c
+++ b/arch/mips/mach-ath79/qca956x/ddr.c
@@ -5,7 +5,6 @@
  * Based on QSDK
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/mach-ath79/reset.c b/arch/mips/mach-ath79/reset.c
index 6cd5e77fd15a..62da8b92a7d4 100644
--- a/arch/mips/mach-ath79/reset.c
+++ b/arch/mips/mach-ath79/reset.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2018-2019 Rosy Song <rosysong@rosinson.com>
  */
 
-#include <common.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/arch/mips/mach-bmips/dram.c b/arch/mips/mach-bmips/dram.c
index bba6cd6f4aaf..eec8b44e47ea 100644
--- a/arch/mips/mach-bmips/dram.c
+++ b/arch/mips/mach-bmips/dram.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <ram.h>
diff --git a/arch/mips/mach-jz47xx/jz4780/gpio.c b/arch/mips/mach-jz47xx/jz4780/gpio.c
index d4884e7fa9f1..7f6717efc16f 100644
--- a/arch/mips/mach-jz47xx/jz4780/gpio.c
+++ b/arch/mips/mach-jz47xx/jz4780/gpio.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <mach/jz4780.h>
diff --git a/arch/mips/mach-jz47xx/jz4780/jz4780.c b/arch/mips/mach-jz47xx/jz4780/jz4780.c
index 56fdf04bca9d..1d6fb6a4e27c 100644
--- a/arch/mips/mach-jz47xx/jz4780/jz4780.c
+++ b/arch/mips/mach-jz47xx/jz4780/jz4780.c
@@ -7,7 +7,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <image.h>
diff --git a/arch/mips/mach-jz47xx/jz4780/pll.c b/arch/mips/mach-jz47xx/jz4780/pll.c
index 4519b478ccb0..8ef00f99a106 100644
--- a/arch/mips/mach-jz47xx/jz4780/pll.c
+++ b/arch/mips/mach-jz47xx/jz4780/pll.c
@@ -7,7 +7,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/arch/mips/mach-jz47xx/jz4780/reset.c b/arch/mips/mach-jz47xx/jz4780/reset.c
index bf6addccb5de..d2e9eb79e6df 100644
--- a/arch/mips/mach-jz47xx/jz4780/reset.c
+++ b/arch/mips/mach-jz47xx/jz4780/reset.c
@@ -7,7 +7,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <mach/jz4780.h>
diff --git a/arch/mips/mach-jz47xx/jz4780/sdram.c b/arch/mips/mach-jz47xx/jz4780/sdram.c
index 690f3c5601da..09296ee21ada 100644
--- a/arch/mips/mach-jz47xx/jz4780/sdram.c
+++ b/arch/mips/mach-jz47xx/jz4780/sdram.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2006-2013 Ingenic Semiconductor
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/mips/mach-jz47xx/jz4780/timer.c b/arch/mips/mach-jz47xx/jz4780/timer.c
index 82bb9e8c3bfa..94ef505f18fe 100644
--- a/arch/mips/mach-jz47xx/jz4780/timer.c
+++ b/arch/mips/mach-jz47xx/jz4780/timer.c
@@ -7,7 +7,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <div64.h>
 #include <init.h>
 #include <irq_func.h>
diff --git a/arch/mips/mach-mscc/cpu.c b/arch/mips/mach-mscc/cpu.c
index d484eb92c419..22b1b98e0ef4 100644
--- a/arch/mips/mach-mscc/cpu.c
+++ b/arch/mips/mach-mscc/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
diff --git a/arch/mips/mach-mscc/dram.c b/arch/mips/mach-mscc/dram.c
index f7fbd33cc4b9..c7c2040a11ab 100644
--- a/arch/mips/mach-mscc/dram.c
+++ b/arch/mips/mach-mscc/dram.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 
diff --git a/arch/mips/mach-mscc/gpio.c b/arch/mips/mach-mscc/gpio.c
index d6b4c5d7684b..6cd0e2436e78 100644
--- a/arch/mips/mach-mscc/gpio.c
+++ b/arch/mips/mach-mscc/gpio.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 
diff --git a/arch/mips/mach-mscc/include/mach/ddr.h b/arch/mips/mach-mscc/include/mach/ddr.h
index 75fb3ca00d2c..3ba33d27c178 100644
--- a/arch/mips/mach-mscc/include/mach/ddr.h
+++ b/arch/mips/mach-mscc/include/mach/ddr.h
@@ -6,6 +6,7 @@
 #ifndef __ASM_MACH_DDR_H
 #define __ASM_MACH_DDR_H
 
+#include <config.h>
 #include <asm/cacheops.h>
 #include <asm/io.h>
 #include <asm/reboot.h>
diff --git a/arch/mips/mach-mscc/phy.c b/arch/mips/mach-mscc/phy.c
index 83d3e5bdd28f..444d1f5315d5 100644
--- a/arch/mips/mach-mscc/phy.c
+++ b/arch/mips/mach-mscc/phy.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 
diff --git a/arch/mips/mach-mscc/reset.c b/arch/mips/mach-mscc/reset.c
index a1214573b51a..ca9a7c679d94 100644
--- a/arch/mips/mach-mscc/reset.c
+++ b/arch/mips/mach-mscc/reset.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
-
 #include <asm/sections.h>
 #include <asm/io.h>
 
diff --git a/arch/mips/mach-mtmips/cpu.c b/arch/mips/mach-mtmips/cpu.c
index e88dab10c76e..243938a0ebb7 100644
--- a/arch/mips/mach-mtmips/cpu.c
+++ b/arch/mips/mach-mtmips/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <event.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/arch/mips/mach-mtmips/ddr_cal.c b/arch/mips/mach-mtmips/ddr_cal.c
index 762619a960f3..e2e1760a6468 100644
--- a/arch/mips/mach-mtmips/ddr_cal.c
+++ b/arch/mips/mach-mtmips/ddr_cal.c
@@ -5,7 +5,6 @@
  * Author:  Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <asm/addrspace.h>
 #include <asm/cacheops.h>
 #include <asm/global_data.h>
diff --git a/arch/mips/mach-mtmips/ddr_init.c b/arch/mips/mach-mtmips/ddr_init.c
index 9c986daea6f5..cab53561e42e 100644
--- a/arch/mips/mach-mtmips/ddr_init.c
+++ b/arch/mips/mach-mtmips/ddr_init.c
@@ -5,7 +5,6 @@
  * Author:  Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/arch/mips/mach-mtmips/mt7628/ddr.c b/arch/mips/mach-mtmips/mt7628/ddr.c
index 4e72459906e8..198bf262f92b 100644
--- a/arch/mips/mach-mtmips/mt7628/ddr.c
+++ b/arch/mips/mach-mtmips/mt7628/ddr.c
@@ -5,7 +5,6 @@
  * Author:  Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <asm/addrspace.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
diff --git a/arch/mips/mach-mtmips/mt7628/init.c b/arch/mips/mach-mtmips/mt7628/init.c
index 6b535129df12..2996fd9ef4ee 100644
--- a/arch/mips/mach-mtmips/mt7628/init.c
+++ b/arch/mips/mach-mtmips/mt7628/init.c
@@ -5,7 +5,6 @@
  * Author:  Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/global_data.h>
diff --git a/arch/mips/mach-mtmips/mt7628/serial.c b/arch/mips/mach-mtmips/mt7628/serial.c
index e5f3f87a6737..11a2149e1273 100644
--- a/arch/mips/mach-mtmips/mt7628/serial.c
+++ b/arch/mips/mach-mtmips/mt7628/serial.c
@@ -5,7 +5,6 @@
  * Author:  Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include "mt7628.h"
 
diff --git a/arch/mips/mach-mtmips/spl.c b/arch/mips/mach-mtmips/spl.c
index fe5b49e702f1..0208bc423dfb 100644
--- a/arch/mips/mach-mtmips/spl.c
+++ b/arch/mips/mach-mtmips/spl.c
@@ -5,7 +5,6 @@
  * Author: Weijie Gao <weijie.gao@mediatek.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/sections.h>
diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
index 7ed306e045ea..dbf8c9cd221d 100644
--- a/arch/mips/mach-pic32/cpu.c
+++ b/arch/mips/mach-pic32/cpu.c
@@ -4,7 +4,6 @@
  * Purna Chandra Mandal <purna.mandal@microchip.com>
  *
  */
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <event.h>
diff --git a/arch/mips/mach-pic32/reset.c b/arch/mips/mach-pic32/reset.c
index 8071b13f7b48..efd6985b44a1 100644
--- a/arch/mips/mach-pic32/reset.c
+++ b/arch/mips/mach-pic32/reset.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <mach/pic32.h>
 
-- 
2.34.1

