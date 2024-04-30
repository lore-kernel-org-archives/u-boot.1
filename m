Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53C6C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809A188A43;
	Tue, 30 Apr 2024 15:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qqgCq3+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595BE88A2E; Tue, 30 Apr 2024 15:36:20 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB0E88A34
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6a0c8fb3540so20772316d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484174; x=1715088974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Bw0gpJBPE8Eqed3X0M1A4J0+nzVu7kaou0nq1M1qLg=;
 b=qqgCq3+6GR2QugzEDuOt4bdHpSTM+GUu7uSFJRzaQK3zmXa5Jht1CZpBEUlpDD9H3X
 oZUxk4iS1ZvOLtFQVfqm1QXgJbkiWKMcV23eY95EUFOlLkyzQLKzP+Lnyq87GHT+vzud
 qprQZXRnhpzr2RJ+lFymjlsOrE2FiAgYCKvPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484174; x=1715088974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Bw0gpJBPE8Eqed3X0M1A4J0+nzVu7kaou0nq1M1qLg=;
 b=EgktF85h7PhGpA1sNUWtVXEQHpeM33W9gxxaBGaogSHI/acdS7h0LaT1704caSQXfE
 7/UFsuBz4dpHkcMcLbkduKI3A082W79VMvVHVGKfq6FRrZWBgFyKBkLwBFeN/m+K4j2Z
 MWkl5mN88pFj3GcOQnvNVLzDtSMlo4uEGUxpXRsZjDDYbb/i5wFD3EJYqc1kQ8UIWqGq
 pCaajAORRxkGzeXJZs/1I9upEPuoUTvOXou5ehmirlIel5MSTHR3lecevW4oQcNtcrb1
 3P76w4otCVEHJR0FiKwbLII69xpQOBK5aqB4XJ50GMno4lkp36BUBZL/9QvnWGqFjW/W
 8dgA==
X-Gm-Message-State: AOJu0YzupUy/gfvlKWAeQ+5RHbpcqJsZK+9LiW1/uG0rWALcYh0xk4ga
 3J4PYFkoMl1i1EPrdTx9EOKpqW1u/O8XXc6IgbpmHi7SEbejI1zo0vGFmL5WmlDrDMQlA6bZMWb
 /WM1V9A==
X-Google-Smtp-Source: AGHT+IG3+Hc2UQHd+z9fbZSOea8JAqUcJHWSupHK5Pd+ns/v5v8IhF6u0tC0KIEgxySqkySLY0FieQ==
X-Received: by 2002:ad4:4ee4:0:b0:69b:6b28:f941 with SMTP id
 dv4-20020ad44ee4000000b0069b6b28f941mr5247253qvb.20.1714484174018; 
 Tue, 30 Apr 2024 06:36:14 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 10/33] arm: rockchip: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:36 -0600
Message-Id: <20240430133559.1836389-10-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-rockchip and include/asm/arch-rockchip
files and when needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/include/asm/arch-rockchip/bootrom.h  | 2 ++
 arch/arm/include/asm/arch-rockchip/clock.h    | 2 ++
 arch/arm/mach-rockchip/board.c                | 2 +-
 arch/arm/mach-rockchip/boot_mode.c            | 1 -
 arch/arm/mach-rockchip/bootrom.c              | 1 -
 arch/arm/mach-rockchip/cpu-info.c             | 1 -
 arch/arm/mach-rockchip/px30-board-tpl.c       | 1 -
 arch/arm/mach-rockchip/px30/clk_px30.c        | 1 -
 arch/arm/mach-rockchip/px30/px30.c            | 1 -
 arch/arm/mach-rockchip/px30/syscon_px30.c     | 1 -
 arch/arm/mach-rockchip/rk3036-board-spl.c     | 1 -
 arch/arm/mach-rockchip/rk3036/clk_rk3036.c    | 1 -
 arch/arm/mach-rockchip/rk3036/rk3036.c        | 1 -
 arch/arm/mach-rockchip/rk3036/sdram_rk3036.c  | 2 +-
 arch/arm/mach-rockchip/rk3036/syscon_rk3036.c | 1 -
 arch/arm/mach-rockchip/rk3066/clk_rk3066.c    | 1 -
 arch/arm/mach-rockchip/rk3066/rk3066.c        | 1 -
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c | 1 -
 arch/arm/mach-rockchip/rk3128/clk_rk3128.c    | 1 -
 arch/arm/mach-rockchip/rk3128/syscon_rk3128.c | 1 -
 arch/arm/mach-rockchip/rk3188/clk_rk3188.c    | 1 -
 arch/arm/mach-rockchip/rk3188/rk3188.c        | 1 -
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c | 1 -
 arch/arm/mach-rockchip/rk322x/clk_rk322x.c    | 1 -
 arch/arm/mach-rockchip/rk322x/syscon_rk322x.c | 1 -
 arch/arm/mach-rockchip/rk3288/clk_rk3288.c    | 1 -
 arch/arm/mach-rockchip/rk3288/rk3288.c        | 1 -
 arch/arm/mach-rockchip/rk3288/syscon_rk3288.c | 1 -
 arch/arm/mach-rockchip/rk3308/clk_rk3308.c    | 1 -
 arch/arm/mach-rockchip/rk3308/rk3308.c        | 1 -
 arch/arm/mach-rockchip/rk3308/syscon_rk3308.c | 1 -
 arch/arm/mach-rockchip/rk3328/clk_rk3328.c    | 1 -
 arch/arm/mach-rockchip/rk3328/rk3328.c        | 1 -
 arch/arm/mach-rockchip/rk3328/syscon_rk3328.c | 1 -
 arch/arm/mach-rockchip/rk3368/clk_rk3368.c    | 1 -
 arch/arm/mach-rockchip/rk3368/rk3368.c        | 1 -
 arch/arm/mach-rockchip/rk3368/syscon_rk3368.c | 1 -
 arch/arm/mach-rockchip/rk3399/clk_rk3399.c    | 1 -
 arch/arm/mach-rockchip/rk3399/rk3399.c        | 1 -
 arch/arm/mach-rockchip/rk3399/syscon_rk3399.c | 1 -
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c    | 1 -
 arch/arm/mach-rockchip/rk3568/rk3568.c        | 1 -
 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 1 -
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c    | 1 -
 arch/arm/mach-rockchip/rk3588/rk3588.c        | 1 -
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 1 -
 arch/arm/mach-rockchip/rv1108/clk_rv1108.c    | 1 -
 arch/arm/mach-rockchip/rv1108/syscon_rv1108.c | 1 -
 arch/arm/mach-rockchip/rv1126/clk_rv1126.c    | 1 -
 arch/arm/mach-rockchip/rv1126/rv1126.c        | 1 -
 arch/arm/mach-rockchip/rv1126/syscon_rv1126.c | 1 -
 arch/arm/mach-rockchip/sdram.c                | 2 +-
 arch/arm/mach-rockchip/spl-boot-order.c       | 1 -
 arch/arm/mach-rockchip/tpl.c                  | 1 -
 54 files changed, 7 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index ecf3b4e7428c..e736772fda75 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_ARCH_BOOTROM_H
 #define _ASM_ARCH_BOOTROM_H
 
+#include <linux/types.h>
+
 /*
  * Saved Stack pointer address.
  * Access might be needed in some special cases.
diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index f01c5aeb71cb..73e5283108b1 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_ARCH_CLOCK_H
 #define _ASM_ARCH_CLOCK_H
 
+#include <linux/types.h>
+
 struct udevice;
 
 /* define pll mode */
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index cd226844b638..8a57b8217ff2 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -8,7 +8,7 @@
  * Based on puma-rk3399.c:
  *      (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index f9be396aa558..55e9456668ae 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <adc.h>
 #include <command.h>
 #include <env.h>
diff --git a/arch/arm/mach-rockchip/bootrom.c b/arch/arm/mach-rockchip/bootrom.c
index b36e559e8719..82a0b3efef92 100644
--- a/arch/arm/mach-rockchip/bootrom.c
+++ b/arch/arm/mach-rockchip/bootrom.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2017 Google, Inc
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/boot_mode.h>
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index a62ff53c6a04..14c7331e1ab2 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -4,7 +4,6 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
index db368a7b8c23..f0b3c5f83f47 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <init.h>
diff --git a/arch/arm/mach-rockchip/px30/clk_px30.c b/arch/arm/mach-rockchip/px30/clk_px30.c
index 7edf1321feb3..410134769f8c 100644
--- a/arch/arm/mach-rockchip/px30/clk_px30.c
+++ b/arch/arm/mach-rockchip/px30/clk_px30.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 2ec3289d75b7..8b1509e55f21 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2017 Rockchip Electronics Co., Ltd
  */
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <fdt_support.h>
diff --git a/arch/arm/mach-rockchip/px30/syscon_px30.c b/arch/arm/mach-rockchip/px30/syscon_px30.c
index 37e88f5ccb91..c9de57493d8c 100644
--- a/arch/arm/mach-rockchip/px30/syscon_px30.c
+++ b/arch/arm/mach-rockchip/px30/syscon_px30.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/rk3036-board-spl.c b/arch/arm/mach-rockchip/rk3036-board-spl.c
index 73f6d241a1ce..64e100172fac 100644
--- a/arch/arm/mach-rockchip/rk3036-board-spl.c
+++ b/arch/arm/mach-rockchip/rk3036-board-spl.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015-2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <debug_uart.h>
 #include <init.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-rockchip/rk3036/clk_rk3036.c b/arch/arm/mach-rockchip/rk3036/clk_rk3036.c
index 116dccd7b87a..9046601a75e8 100644
--- a/arch/arm/mach-rockchip/rk3036/clk_rk3036.c
+++ b/arch/arm/mach-rockchip/rk3036/clk_rk3036.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3036/rk3036.c b/arch/arm/mach-rockchip/rk3036/rk3036.c
index e8130abdd777..6c92b31dc846 100644
--- a/arch/arm/mach-rockchip/rk3036/rk3036.c
+++ b/arch/arm/mach-rockchip/rk3036/rk3036.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/arch-rockchip/grf_rk3036.h>
diff --git a/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c b/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c
index 07cd29a33e69..308b9e6b8a8a 100644
--- a/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c
+++ b/arch/arm/mach-rockchip/rk3036/sdram_rk3036.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2015 Rockchip Electronics Co., Ltd
  */
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/types.h>
 #include <asm/arch-rockchip/cru_rk3036.h>
diff --git a/arch/arm/mach-rockchip/rk3036/syscon_rk3036.c b/arch/arm/mach-rockchip/rk3036/syscon_rk3036.c
index c2fd16079902..23b75269d507 100644
--- a/arch/arm/mach-rockchip/rk3036/syscon_rk3036.c
+++ b/arch/arm/mach-rockchip/rk3036/syscon_rk3036.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3066/clk_rk3066.c b/arch/arm/mach-rockchip/rk3066/clk_rk3066.c
index c47526dca5de..88057fad0501 100644
--- a/arch/arm/mach-rockchip/rk3066/clk_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/clk_rk3066.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3066/rk3066.c b/arch/arm/mach-rockchip/rk3066/rk3066.c
index 9a95ff850417..70b55ca8abf6 100644
--- a/arch/arm/mach-rockchip/rk3066/rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/rk3066.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3066.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
index a598f6400de3..ff269b53b542 100644
--- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/rk3128/clk_rk3128.c b/arch/arm/mach-rockchip/rk3128/clk_rk3128.c
index a1b038c64866..ae552af3ff59 100644
--- a/arch/arm/mach-rockchip/rk3128/clk_rk3128.c
+++ b/arch/arm/mach-rockchip/rk3128/clk_rk3128.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2017 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3128/syscon_rk3128.c b/arch/arm/mach-rockchip/rk3128/syscon_rk3128.c
index 1406d5d0d325..f81c57a48bee 100644
--- a/arch/arm/mach-rockchip/rk3128/syscon_rk3128.c
+++ b/arch/arm/mach-rockchip/rk3128/syscon_rk3128.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3188/clk_rk3188.c b/arch/arm/mach-rockchip/rk3188/clk_rk3188.c
index 94d1d23e1f45..c0e71c3fa906 100644
--- a/arch/arm/mach-rockchip/rk3188/clk_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/clk_rk3188.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3188/rk3188.c b/arch/arm/mach-rockchip/rk3188/rk3188.c
index ffdcaa49a1e5..53b2eaa2d534 100644
--- a/arch/arm/mach-rockchip/rk3188/rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/rk3188.c
@@ -2,7 +2,6 @@
 /*
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
-#include <common.h>
 #include <dm.h>
 #include <hang.h>
 #include <init.h>
diff --git a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
index 917ff37c0fc1..6df054e5b27d 100644
--- a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/rk322x/clk_rk322x.c b/arch/arm/mach-rockchip/rk322x/clk_rk322x.c
index 2e57672b246d..4703125392eb 100644
--- a/arch/arm/mach-rockchip/rk322x/clk_rk322x.c
+++ b/arch/arm/mach-rockchip/rk322x/clk_rk322x.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk322x/syscon_rk322x.c b/arch/arm/mach-rockchip/rk322x/syscon_rk322x.c
index 0d9dca8173cd..c471a4c9fb74 100644
--- a/arch/arm/mach-rockchip/rk322x/syscon_rk322x.c
+++ b/arch/arm/mach-rockchip/rk322x/syscon_rk322x.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3288/clk_rk3288.c b/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
index fb4c0891d0dc..af6c5d1f59b2 100644
--- a/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c b/arch/arm/mach-rockchip/rk3288/rk3288.c
index 70cf50029121..d1170f7e23d0 100644
--- a/arch/arm/mach-rockchip/rk3288/rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2016 Rockchip Electronics Co., Ltd
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
index 8b2c2f323a71..6413d0a88a16 100644
--- a/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/syscon_rk3288.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dt-structs.h>
 #include <log.h>
diff --git a/arch/arm/mach-rockchip/rk3308/clk_rk3308.c b/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
index 201bf661f9bb..557e21f8199e 100644
--- a/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index a0915c72bfa0..6f88638d1569 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -2,7 +2,6 @@
 /*
  *Copyright (c) 2018 Rockchip Electronics Co., Ltd
  */
-#include <common.h>
 #include <init.h>
 #include <malloc.h>
 #include <asm/arch-rockchip/bootrom.h>
diff --git a/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c b/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
index b380ff572336..2d7e97110152 100644
--- a/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/syscon_rk3308.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2018 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3328/clk_rk3328.c b/arch/arm/mach-rockchip/rk3328/clk_rk3328.c
index 70c0eb6f98e7..b0c5af53da68 100644
--- a/arch/arm/mach-rockchip/rk3328/clk_rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/clk_rk3328.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3328.h>
diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index ca3fa81e1278..c86d11943d6d 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c b/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
index d2f267e63534..02ed366d8b6f 100644
--- a/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/syscon_rk3328.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <asm/arch-rockchip/clock.h>
 #include <dm.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/rk3368/clk_rk3368.c b/arch/arm/mach-rockchip/rk3368/clk_rk3368.c
index b075319720d9..c4d41e52af08 100644
--- a/arch/arm/mach-rockchip/rk3368/clk_rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/clk_rk3368.c
@@ -4,7 +4,6 @@
  * Author: Andy Yan <andy.yan@rock-chips.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c b/arch/arm/mach-rockchip/rk3368/rk3368.c
index 8f5ca1dfa7c9..f589bf67328d 100644
--- a/arch/arm/mach-rockchip/rk3368/rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2016 Andreas Färber
  */
 
-#include <common.h>
 #include <init.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
diff --git a/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c b/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
index dc2d831dd84f..7389c0283641 100644
--- a/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/rk3399/clk_rk3399.c b/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
index 9d9a837fc748..de552b5903b5 100644
--- a/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 7fa1d7c7b7af..2d7d0f82a2f1 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c b/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
index 2b5746cb31bb..b92ad54ede5c 100644
--- a/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
index 8917edcbd304..1c6b2ece602b 100644
--- a/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/clk_rk3568.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index b30ea04f737a..1b3e40074e3b 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
diff --git a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
index 5407e7827f52..255259eabfda 100644
--- a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
index 3df0bf223e30..250ec423bd24 100644
--- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index eb65dafe3a24..d3162d3447e0 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
diff --git a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
index 7b2cf37d9da1..f86567fcaf4f 100644
--- a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rv1108/clk_rv1108.c b/arch/arm/mach-rockchip/rv1108/clk_rv1108.c
index 44b53c407a78..5659ae03d711 100644
--- a/arch/arm/mach-rockchip/rv1108/clk_rv1108.c
+++ b/arch/arm/mach-rockchip/rv1108/clk_rv1108.c
@@ -4,7 +4,6 @@
  * Author: Andy Yan <andy.yan@rock-chips.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rv1108/syscon_rv1108.c b/arch/arm/mach-rockchip/rv1108/syscon_rv1108.c
index babdf5720b24..d68fbf1bd251 100644
--- a/arch/arm/mach-rockchip/rv1108/syscon_rv1108.c
+++ b/arch/arm/mach-rockchip/rv1108/syscon_rv1108.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rv1126/clk_rv1126.c b/arch/arm/mach-rockchip/rv1126/clk_rv1126.c
index bd8902718f20..3d64fcd45949 100644
--- a/arch/arm/mach-rockchip/rv1126/clk_rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/clk_rv1126.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
diff --git a/arch/arm/mach-rockchip/rv1126/rv1126.c b/arch/arm/mach-rockchip/rv1126/rv1126.c
index 40eb9eb7b196..1c10e9b9f233 100644
--- a/arch/arm/mach-rockchip/rv1126/rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/rv1126.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
-#include <common.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rv1126.h>
diff --git a/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c b/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
index 599ea66e3d67..67d2f18a8d0f 100644
--- a/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/syscon_rv1126.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index f2a3d6b14001..1fb01e1c4b13 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 3543267aa574..3dce9b30898d 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <log.h>
diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index 2c3e9789cc89..50f04f9474a0 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <debug_uart.h>
 #include <dm.h>
-- 
2.34.1

