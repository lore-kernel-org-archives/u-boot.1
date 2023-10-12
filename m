Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C610CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E18A86E5D;
	Fri, 13 Oct 2023 01:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qOlP/ZrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8666386D41; Fri, 13 Oct 2023 01:04:58 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE35686E2F
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7ab31fb8bso17915437b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151844; x=1697756644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtFD3tWyDFRWcXgCw9Jkw0wGOIvWaUR+FYfNfCf6VWw=;
 b=qOlP/ZrGGj3A/NKrZ0CtXi9jTxUI/9XwbbgQozHP7yAEtcHWo1VTZ3/taDHoRzqNml
 Xpw6QKoTjy6lqRvGSLPcJzVwcHwXx2jG7WTKDqGpzlfWGcCOBNYj/sK2tGb48Zhg6Nzw
 sgw2qv0vZp1R9JKXW6i2cMfhLEdX/4yhQvqXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151844; x=1697756644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtFD3tWyDFRWcXgCw9Jkw0wGOIvWaUR+FYfNfCf6VWw=;
 b=Sa6afeoY8pxftoMa4O+HTitSaZSCkiGDzKyjQ1YubIgUjSYWEHVkp5cEf/RQJnlJrZ
 Jeh4dV20h/9M6l2KNi1BvxhFZSwXIJ45L6ZUzi/M17D3GMtpjBSUGXVnSmFdDk3P+brD
 3AoPClE4bprDvDnjQtAggWw9uM9qrC/UIdncT3vjAubrcTgjvIPmyNc2VI5tMFSe+K41
 t6lckzVzrqHthamQEedus6VV3sdRhcvdsEmaPetmlEMYGpC4xQvEhaF7Ek0lurkf6us6
 /s2bb7Lo8MbNrgXzhYyE4Srci9V/ewx9IvnOY1qzqQT1ge6/40M8AZHCVFgTolXF2BJ+
 6/9Q==
X-Gm-Message-State: AOJu0YxkfmKrWAqD6OyqlLLidgeiPrbf1sEkaGwhtDHoeesHJFih9crA
 sKYSRyDqtHRQF54k+39wxK7i8H7Y1JYVDtACs3JRgQ==
X-Google-Smtp-Source: AGHT+IG0Ijj7MgfG78vaEFDJfYNK+O2d20iA2K54dLEYITb/LwzjjZV8br+RYt5YGy04z/Kwsb0Frw==
X-Received: by 2002:a05:690c:fd3:b0:5a8:17d4:aea1 with SMTP id
 dg19-20020a05690c0fd300b005a817d4aea1mr1145513ywb.28.1697151843531; 
 Thu, 12 Oct 2023 16:04:03 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 4/7] m68k: Remove common.h usage
Date: Thu, 12 Oct 2023 19:03:56 -0400
Message-Id: <20231012230359.2005249-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012230359.2005249-1-trini@konsulko.com>
References: <20231012230359.2005249-1-trini@konsulko.com>
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

We can remove common.h from most cases of the code here, and only a few
places need an additional header instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
---
 arch/m68k/cpu/mcf523x/cpu.c         | 1 -
 arch/m68k/cpu/mcf523x/cpu_init.c    | 1 -
 arch/m68k/cpu/mcf523x/interrupts.c  | 1 -
 arch/m68k/cpu/mcf523x/speed.c       | 1 -
 arch/m68k/cpu/mcf52x2/cpu.c         | 1 -
 arch/m68k/cpu/mcf52x2/cpu_init.c    | 3 +--
 arch/m68k/cpu/mcf52x2/interrupts.c  | 1 -
 arch/m68k/cpu/mcf52x2/speed.c       | 1 -
 arch/m68k/cpu/mcf530x/cpu.c         | 1 -
 arch/m68k/cpu/mcf530x/cpu_init.c    | 1 -
 arch/m68k/cpu/mcf530x/interrupts.c  | 1 -
 arch/m68k/cpu/mcf530x/speed.c       | 1 -
 arch/m68k/cpu/mcf532x/cpu.c         | 1 -
 arch/m68k/cpu/mcf532x/cpu_init.c    | 1 -
 arch/m68k/cpu/mcf532x/interrupts.c  | 1 -
 arch/m68k/cpu/mcf532x/speed.c       | 1 -
 arch/m68k/cpu/mcf5445x/cpu.c        | 1 -
 arch/m68k/cpu/mcf5445x/cpu_init.c   | 1 -
 arch/m68k/cpu/mcf5445x/dspi.c       | 1 -
 arch/m68k/cpu/mcf5445x/interrupts.c | 1 -
 arch/m68k/cpu/mcf5445x/speed.c      | 1 -
 arch/m68k/cpu/mcf5445x/start.S      | 1 -
 arch/m68k/include/asm/immap.h       | 1 +
 arch/m68k/include/asm/immap_520x.h  | 1 +
 arch/m68k/include/asm/immap_5235.h  | 1 +
 arch/m68k/include/asm/immap_5272.h  | 1 +
 arch/m68k/include/asm/immap_5275.h  | 1 +
 arch/m68k/include/asm/immap_5282.h  | 1 +
 arch/m68k/include/asm/immap_5301x.h | 1 +
 arch/m68k/include/asm/immap_5307.h  | 2 ++
 arch/m68k/include/asm/immap_5329.h  | 1 +
 arch/m68k/include/asm/immap_5441x.h | 1 +
 arch/m68k/lib/bdinfo.c              | 3 ++-
 arch/m68k/lib/bootm.c               | 1 -
 arch/m68k/lib/cache.c               | 2 +-
 arch/m68k/lib/fec.c                 | 2 +-
 arch/m68k/lib/interrupts.c          | 2 +-
 arch/m68k/lib/time.c                | 1 -
 arch/m68k/lib/traps.c               | 1 -
 39 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/arch/m68k/cpu/mcf523x/cpu.c b/arch/m68k/cpu/mcf523x/cpu.c
index bef67767b425..c843a381ea1f 100644
--- a/arch/m68k/cpu/mcf523x/cpu.c
+++ b/arch/m68k/cpu/mcf523x/cpu.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <vsprintf.h>
diff --git a/arch/m68k/cpu/mcf523x/cpu_init.c b/arch/m68k/cpu/mcf523x/cpu_init.c
index 10be73822fa5..a05cbdcb3852 100644
--- a/arch/m68k/cpu/mcf523x/cpu_init.c
+++ b/arch/m68k/cpu/mcf523x/cpu_init.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
diff --git a/arch/m68k/cpu/mcf523x/interrupts.c b/arch/m68k/cpu/mcf523x/interrupts.c
index 09c7f9e67cc7..46c9207a93bb 100644
--- a/arch/m68k/cpu/mcf523x/interrupts.c
+++ b/arch/m68k/cpu/mcf523x/interrupts.c
@@ -6,7 +6,6 @@
  */
 
 /* CPU specific interrupt routine */
-#include <common.h>
 #include <irq_func.h>
 #include <asm/immap.h>
 #include <asm/io.h>
diff --git a/arch/m68k/cpu/mcf523x/speed.c b/arch/m68k/cpu/mcf523x/speed.c
index 6b08a12af0b6..2eb43cc7eb9a 100644
--- a/arch/m68k/cpu/mcf523x/speed.c
+++ b/arch/m68k/cpu/mcf523x/speed.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/cpu/mcf52x2/cpu.c b/arch/m68k/cpu/mcf52x2/cpu.c
index 5042a38b3e9e..6bfde5e9bd70 100644
--- a/arch/m68k/cpu/mcf52x2/cpu.c
+++ b/arch/m68k/cpu/mcf52x2/cpu.c
@@ -13,7 +13,6 @@
  * Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <vsprintf.h>
diff --git a/arch/m68k/cpu/mcf52x2/cpu_init.c b/arch/m68k/cpu/mcf52x2/cpu_init.c
index 99eb61f16758..4506eb39edfc 100644
--- a/arch/m68k/cpu/mcf52x2/cpu_init.c
+++ b/arch/m68k/cpu/mcf52x2/cpu_init.c
@@ -17,7 +17,7 @@
  * Copyright (C) 2008 Arthur Shipkowski (art@videon-central.com)
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
@@ -25,7 +25,6 @@
 #include <asm/io.h>
 
 #if defined(CONFIG_CMD_NET)
-#include <config.h>
 #include <net.h>
 #include <asm/fec.h>
 #endif
diff --git a/arch/m68k/cpu/mcf52x2/interrupts.c b/arch/m68k/cpu/mcf52x2/interrupts.c
index c5ed06007369..264bdc7d6c7e 100644
--- a/arch/m68k/cpu/mcf52x2/interrupts.c
+++ b/arch/m68k/cpu/mcf52x2/interrupts.c
@@ -7,7 +7,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <irq_func.h>
 #include <watchdog.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/cpu/mcf52x2/speed.c b/arch/m68k/cpu/mcf52x2/speed.c
index 6c7628252b59..538e4c623d42 100644
--- a/arch/m68k/cpu/mcf52x2/speed.c
+++ b/arch/m68k/cpu/mcf52x2/speed.c
@@ -7,7 +7,6 @@
  * Hayden Fraser (Hayden.Fraser@freescale.com)
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/cpu/mcf530x/cpu.c b/arch/m68k/cpu/mcf530x/cpu.c
index 53a25d8362cd..92a0ef76895c 100644
--- a/arch/m68k/cpu/mcf530x/cpu.c
+++ b/arch/m68k/cpu/mcf530x/cpu.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <command.h>
 #include <init.h>
 #include <vsprintf.h>
diff --git a/arch/m68k/cpu/mcf530x/cpu_init.c b/arch/m68k/cpu/mcf530x/cpu_init.c
index dad47d87ab31..8f6e668d103a 100644
--- a/arch/m68k/cpu/mcf530x/cpu_init.c
+++ b/arch/m68k/cpu/mcf530x/cpu_init.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
diff --git a/arch/m68k/cpu/mcf530x/interrupts.c b/arch/m68k/cpu/mcf530x/interrupts.c
index 11686202dc73..99cf86385037 100644
--- a/arch/m68k/cpu/mcf530x/interrupts.c
+++ b/arch/m68k/cpu/mcf530x/interrupts.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <irq_func.h>
 #include <asm/immap.h>
 #include <asm/io.h>
diff --git a/arch/m68k/cpu/mcf530x/speed.c b/arch/m68k/cpu/mcf530x/speed.c
index c8d079016f2e..6542fc43ab10 100644
--- a/arch/m68k/cpu/mcf530x/speed.c
+++ b/arch/m68k/cpu/mcf530x/speed.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/cpu/mcf532x/cpu.c b/arch/m68k/cpu/mcf532x/cpu.c
index 18d20a892655..6973af9d045d 100644
--- a/arch/m68k/cpu/mcf532x/cpu.c
+++ b/arch/m68k/cpu/mcf532x/cpu.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <vsprintf.h>
diff --git a/arch/m68k/cpu/mcf532x/cpu_init.c b/arch/m68k/cpu/mcf532x/cpu_init.c
index 844d2cd7600f..62a45f96314d 100644
--- a/arch/m68k/cpu/mcf532x/cpu_init.c
+++ b/arch/m68k/cpu/mcf532x/cpu_init.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
diff --git a/arch/m68k/cpu/mcf532x/interrupts.c b/arch/m68k/cpu/mcf532x/interrupts.c
index 4f72fa88e58c..e37893c3e535 100644
--- a/arch/m68k/cpu/mcf532x/interrupts.c
+++ b/arch/m68k/cpu/mcf532x/interrupts.c
@@ -6,7 +6,6 @@
  */
 
 /* CPU specific interrupt routine */
-#include <common.h>
 #include <irq_func.h>
 #include <asm/immap.h>
 #include <asm/io.h>
diff --git a/arch/m68k/cpu/mcf532x/speed.c b/arch/m68k/cpu/mcf532x/speed.c
index 32ffac08135d..166916526eb9 100644
--- a/arch/m68k/cpu/mcf532x/speed.c
+++ b/arch/m68k/cpu/mcf532x/speed.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/cpu/mcf5445x/cpu.c b/arch/m68k/cpu/mcf5445x/cpu.c
index d9a71c6b920d..b811ac355e4d 100644
--- a/arch/m68k/cpu/mcf5445x/cpu.c
+++ b/arch/m68k/cpu/mcf5445x/cpu.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <vsprintf.h>
diff --git a/arch/m68k/cpu/mcf5445x/cpu_init.c b/arch/m68k/cpu/mcf5445x/cpu_init.c
index bc3a2f3aed63..3277617120c7 100644
--- a/arch/m68k/cpu/mcf5445x/cpu_init.c
+++ b/arch/m68k/cpu/mcf5445x/cpu_init.c
@@ -8,7 +8,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
diff --git a/arch/m68k/cpu/mcf5445x/dspi.c b/arch/m68k/cpu/mcf5445x/dspi.c
index 456af171a4e2..13eb6ecee101 100644
--- a/arch/m68k/cpu/mcf5445x/dspi.c
+++ b/arch/m68k/cpu/mcf5445x/dspi.c
@@ -6,7 +6,6 @@
  * CPU specific dspi routines
  */
 
-#include <common.h>
 #include <asm/immap.h>
 #include <asm/io.h>
 
diff --git a/arch/m68k/cpu/mcf5445x/interrupts.c b/arch/m68k/cpu/mcf5445x/interrupts.c
index 400f3dee879e..913290086dca 100644
--- a/arch/m68k/cpu/mcf5445x/interrupts.c
+++ b/arch/m68k/cpu/mcf5445x/interrupts.c
@@ -9,7 +9,6 @@
  */
 
 /* CPU specific interrupt routine */
-#include <common.h>
 #include <irq_func.h>
 #include <asm/immap.h>
 #include <asm/io.h>
diff --git a/arch/m68k/cpu/mcf5445x/speed.c b/arch/m68k/cpu/mcf5445x/speed.c
index 5c78eb983496..41cb9e999adc 100644
--- a/arch/m68k/cpu/mcf5445x/speed.c
+++ b/arch/m68k/cpu/mcf5445x/speed.c
@@ -5,7 +5,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/cpu/mcf5445x/start.S b/arch/m68k/cpu/mcf5445x/start.S
index 5c3bfff79183..f0264671d386 100644
--- a/arch/m68k/cpu/mcf5445x/start.S
+++ b/arch/m68k/cpu/mcf5445x/start.S
@@ -7,7 +7,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <asm-offsets.h>
 #include <config.h>
 #include <asm/cache.h>
diff --git a/arch/m68k/include/asm/immap.h b/arch/m68k/include/asm/immap.h
index aafa4f40cb35..411b00899c25 100644
--- a/arch/m68k/include/asm/immap.h
+++ b/arch/m68k/include/asm/immap.h
@@ -9,6 +9,7 @@
 #ifndef __IMMAP_H
 #define __IMMAP_H
 
+#include <config.h>
 #if defined(CONFIG_MCF520x)
 #include <asm/immap_520x.h>
 #include <asm/m520x.h>
diff --git a/arch/m68k/include/asm/immap_520x.h b/arch/m68k/include/asm/immap_520x.h
index 7c7443b96885..d3c2f4a4091d 100644
--- a/arch/m68k/include/asm/immap_520x.h
+++ b/arch/m68k/include/asm/immap_520x.h
@@ -36,6 +36,7 @@
 #define MMAP_GPIO	(CFG_SYS_MBAR + 0x000A4000)
 #define MMAP_SDRAM	(CFG_SYS_MBAR + 0x000A8000)
 
+#include <linux/types.h>
 #include <asm/coldfire/crossbar.h>
 #include <asm/coldfire/edma.h>
 #include <asm/coldfire/eport.h>
diff --git a/arch/m68k/include/asm/immap_5235.h b/arch/m68k/include/asm/immap_5235.h
index a1825c2a944f..d9b0be1d7d41 100644
--- a/arch/m68k/include/asm/immap_5235.h
+++ b/arch/m68k/include/asm/immap_5235.h
@@ -46,6 +46,7 @@
 #define MMAP_ETPU	(CFG_SYS_MBAR + 0x001D0000)
 #define MMAP_CAN2	(CFG_SYS_MBAR + 0x001F0000)
 
+#include <linux/types.h>
 #include <asm/coldfire/eport.h>
 #include <asm/coldfire/flexbus.h>
 #include <asm/coldfire/flexcan.h>
diff --git a/arch/m68k/include/asm/immap_5272.h b/arch/m68k/include/asm/immap_5272.h
index c5c3cc751258..5378ed1aac16 100644
--- a/arch/m68k/include/asm/immap_5272.h
+++ b/arch/m68k/include/asm/immap_5272.h
@@ -27,6 +27,7 @@
 #define MMAP_FEC	(CFG_SYS_MBAR + 0x00000840)
 #define MMAP_USB	(CFG_SYS_MBAR + 0x00001000)
 
+#include <linux/types.h>
 #include <asm/coldfire/pwm.h>
 
 /* System configuration registers */
diff --git a/arch/m68k/include/asm/immap_5275.h b/arch/m68k/include/asm/immap_5275.h
index 9b8d71d30d44..c4cce3f94f14 100644
--- a/arch/m68k/include/asm/immap_5275.h
+++ b/arch/m68k/include/asm/immap_5275.h
@@ -49,6 +49,7 @@
 #define MMAP_USB	(CFG_SYS_MBAR + 0x001C0000)
 #define MMAP_PWM0	(CFG_SYS_MBAR + 0x001D0000)
 
+#include <linux/types.h>
 #include <asm/coldfire/eport.h>
 #include <asm/coldfire/flexbus.h>
 #include <asm/coldfire/intctrl.h>
diff --git a/arch/m68k/include/asm/immap_5282.h b/arch/m68k/include/asm/immap_5282.h
index f810a4dd5cb5..e5f400e6ae32 100644
--- a/arch/m68k/include/asm/immap_5282.h
+++ b/arch/m68k/include/asm/immap_5282.h
@@ -45,6 +45,7 @@
 #define MMAP_CFMC	(CFG_SYS_MBAR + 0x001D0000)
 #define MMAP_CFMMEM	(CFG_SYS_MBAR + 0x04000000)
 
+#include <linux/types.h>
 #include <asm/coldfire/eport.h>
 #include <asm/coldfire/flexbus.h>
 #include <asm/coldfire/flexcan.h>
diff --git a/arch/m68k/include/asm/immap_5301x.h b/arch/m68k/include/asm/immap_5301x.h
index e1f7858b1007..3ade4f04756c 100644
--- a/arch/m68k/include/asm/immap_5301x.h
+++ b/arch/m68k/include/asm/immap_5301x.h
@@ -50,6 +50,7 @@
 #define MMAP_IIM	(CFG_SYS_MBAR + 0x000C8000)
 #define MMAP_ESDHC	(CFG_SYS_MBAR + 0x000CC000)
 
+#include <linux/types.h>
 #include <asm/coldfire/crossbar.h>
 #include <asm/coldfire/dspi.h>
 #include <asm/coldfire/edma.h>
diff --git a/arch/m68k/include/asm/immap_5307.h b/arch/m68k/include/asm/immap_5307.h
index d6442d95b4ba..d96dd146efb0 100644
--- a/arch/m68k/include/asm/immap_5307.h
+++ b/arch/m68k/include/asm/immap_5307.h
@@ -17,6 +17,8 @@
 #define MMAP_UART1	(CFG_SYS_MBAR + 0x00000200)
 #define MMAP_GPIO	(CFG_SYS_MBAR + 0x00000244)
 
+#include <linux/types.h>
+
 typedef struct sim {
 	u8  rsr;
 	u8  sypcr;
diff --git a/arch/m68k/include/asm/immap_5329.h b/arch/m68k/include/asm/immap_5329.h
index dbf3a2260eed..6f1795a207a1 100644
--- a/arch/m68k/include/asm/immap_5329.h
+++ b/arch/m68k/include/asm/immap_5329.h
@@ -51,6 +51,7 @@
 #define MMAP_SSI	0xFC0BC000
 #define MMAP_PLL	0xFC0C0000
 
+#include <linux/types.h>
 #include <asm/coldfire/crossbar.h>
 #include <asm/coldfire/edma.h>
 #include <asm/coldfire/eport.h>
diff --git a/arch/m68k/include/asm/immap_5441x.h b/arch/m68k/include/asm/immap_5441x.h
index 708d0db755a8..c8f3effe2407 100644
--- a/arch/m68k/include/asm/immap_5441x.h
+++ b/arch/m68k/include/asm/immap_5441x.h
@@ -76,6 +76,7 @@
 #define MMAP_CCM	0xEC090000
 #define MMAP_GPIO	0xEC094000
 
+#include <linux/types.h>
 #include <asm/coldfire/crossbar.h>
 #include <asm/coldfire/dspi.h>
 #include <asm/coldfire/edma.h>
diff --git a/arch/m68k/lib/bdinfo.c b/arch/m68k/lib/bdinfo.c
index 0b4629f1c8a7..3719f11c03c6 100644
--- a/arch/m68k/lib/bdinfo.c
+++ b/arch/m68k/lib/bdinfo.c
@@ -6,8 +6,9 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
+#include <asm/u-boot.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index f18bed235d45..79d8b34c0d56 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <env.h>
diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
index 57e5632fdb5b..de04124404cf 100644
--- a/arch/m68k/lib/cache.c
+++ b/arch/m68k/lib/cache.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <asm/immap.h>
 #include <asm/cache.h>
diff --git a/arch/m68k/lib/fec.c b/arch/m68k/lib/fec.c
index eecea7a02354..d6f238e4b347 100644
--- a/arch/m68k/lib/fec.c
+++ b/arch/m68k/lib/fec.c
@@ -3,8 +3,8 @@
  * (C) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
+#include <linux/errno.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 
diff --git a/arch/m68k/lib/interrupts.c b/arch/m68k/lib/interrupts.c
index 799daab5612d..175ec689533e 100644
--- a/arch/m68k/lib/interrupts.c
+++ b/arch/m68k/lib/interrupts.c
@@ -7,7 +7,7 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <irq_func.h>
 #include <watchdog.h>
 #include <asm/processor.h>
diff --git a/arch/m68k/lib/time.c b/arch/m68k/lib/time.c
index 61db1e6c5002..4249488c01d1 100644
--- a/arch/m68k/lib/time.c
+++ b/arch/m68k/lib/time.c
@@ -6,7 +6,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <irq_func.h>
 #include <time.h>
diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
index 28fe803928ea..c283351181d8 100644
--- a/arch/m68k/lib/traps.c
+++ b/arch/m68k/lib/traps.c
@@ -7,7 +7,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <watchdog.h>
 #include <command.h>
-- 
2.34.1

