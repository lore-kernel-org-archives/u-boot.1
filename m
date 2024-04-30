Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9F3C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E0688A77;
	Tue, 30 Apr 2024 15:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PGCqaFRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8883C88A57; Tue, 30 Apr 2024 15:36:37 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDD688A62
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c86560e96eso1167767b6e.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484193; x=1715088993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7TwQCWGoePT+ZUyqKp9ibUQON8f+8jiEACMXnaTuQk=;
 b=PGCqaFRK0DcykzkdhiAvBSgZWEf2doEIwQNXFylg9xC73G1AmTUyOz3rhZmotoWn6u
 YiTANq5cX93GtqaVnjFKkDpnvRX9CJ6cl5KX+5lFHeah0RTEtMgbJ+Ato4iFROnzXhl7
 Kdx4UVLuGHvVVmXT1Gp6UDojwvSo04v3ez0yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484193; x=1715088993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7TwQCWGoePT+ZUyqKp9ibUQON8f+8jiEACMXnaTuQk=;
 b=T/HuQviBVbVlTEkfq/isqtd8VIKZ9yd8zdrPiJQ015B2tyo7ao4LsPaIbdv7oqz89x
 M1zaflC4KPlE+wnP6fjdOX5pyOlBaPSBe0V57EGEMK99LxQEHoXZ0t396SlxiePpT/bR
 HVn+6QrXQt0moY3zyHGBMQpQDhVnUPrKDYmOXrSjRzHBl0TU0sSdpXTqS4tmVPY/K2t1
 RRpJ2aTYf6B9oxtZ1U/qyz6txuEU7m09gcfjJtpoO27YKq6mQSep7aIIKl8Z9srycyzf
 wMKMboJMWbYsRUDT1W/cLD7GgvAd///wnatD4CnYUMOHl6bk1CkIGcOKcBdk9uy04Hb2
 HEcQ==
X-Gm-Message-State: AOJu0YweUzjjor4boPbaJLoZrVO/tzHfQOUsqPQCdxBxiS0DDVZ4zbr6
 K5tfr8n22IMmpcGA7x0plWU1j7sizQU0pgsJR262/dubIt6s5eNo1sOcLKtsRVHBl9sljiOSi/n
 GcrrQiA==
X-Google-Smtp-Source: AGHT+IGA/qEkpwZVgdpf10IBqrkTNUjWxw0TTJ9xijNkaXRNmvyEURiZVRGcrCkz8Hrpxz9fEy5ZhQ==
X-Received: by 2002:a05:6808:1828:b0:3c8:65ee:6795 with SMTP id
 bh40-20020a056808182800b003c865ee6795mr8828485oib.22.1714484193330; 
 Tue, 30 Apr 2024 06:36:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH 29/33] arm: at91: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:55 -0600
Message-Id: <20240430133559.1836389-29-trini@konsulko.com>
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

Remove <common.h> from all mach-at91 files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Eugen Hristev <eugen.hristev@collabora.com>
---
 arch/arm/mach-at91/arm920t/at91rm9200_devices.c       | 1 -
 arch/arm/mach-at91/arm920t/clock.c                    | 2 +-
 arch/arm/mach-at91/arm920t/cpu.c                      | 2 +-
 arch/arm/mach-at91/arm920t/reset.c                    | 1 -
 arch/arm/mach-at91/arm920t/timer.c                    | 2 +-
 arch/arm/mach-at91/arm926ejs/at91sam9260_devices.c    | 1 -
 arch/arm/mach-at91/arm926ejs/at91sam9261_devices.c    | 1 -
 arch/arm/mach-at91/arm926ejs/at91sam9263_devices.c    | 1 -
 arch/arm/mach-at91/arm926ejs/at91sam9m10g45_devices.c | 1 -
 arch/arm/mach-at91/arm926ejs/at91sam9n12_devices.c    | 1 -
 arch/arm/mach-at91/arm926ejs/at91sam9rl_devices.c     | 1 -
 arch/arm/mach-at91/arm926ejs/at91sam9x5_devices.c     | 1 -
 arch/arm/mach-at91/arm926ejs/clock.c                  | 3 ++-
 arch/arm/mach-at91/arm926ejs/cpu.c                    | 2 +-
 arch/arm/mach-at91/arm926ejs/eflash.c                 | 1 -
 arch/arm/mach-at91/arm926ejs/reset.c                  | 1 -
 arch/arm/mach-at91/arm926ejs/sam9x60_devices.c        | 1 -
 arch/arm/mach-at91/arm926ejs/timer.c                  | 1 -
 arch/arm/mach-at91/armv7/clock.c                      | 2 +-
 arch/arm/mach-at91/armv7/cpu.c                        | 2 +-
 arch/arm/mach-at91/armv7/sama5d2_devices.c            | 1 -
 arch/arm/mach-at91/armv7/sama5d3_devices.c            | 1 -
 arch/arm/mach-at91/armv7/sama5d4_devices.c            | 1 -
 arch/arm/mach-at91/armv7/timer.c                      | 1 -
 arch/arm/mach-at91/atmel_sfr.c                        | 2 +-
 arch/arm/mach-at91/clock.c                            | 2 +-
 arch/arm/mach-at91/include/mach/at91_common.h         | 2 ++
 arch/arm/mach-at91/matrix.c                           | 1 -
 arch/arm/mach-at91/mpddrc.c                           | 1 -
 arch/arm/mach-at91/phy.c                              | 2 +-
 arch/arm/mach-at91/sdram.c                            | 1 -
 arch/arm/mach-at91/spl.c                              | 1 -
 arch/arm/mach-at91/spl_at91.c                         | 2 +-
 arch/arm/mach-at91/spl_atmel.c                        | 2 +-
 34 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-at91/arm920t/at91rm9200_devices.c b/arch/arm/mach-at91/arm920t/at91rm9200_devices.c
index c849885bc2bb..459edadb5876 100644
--- a/arch/arm/mach-at91/arm920t/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/arm920t/at91rm9200_devices.c
@@ -10,7 +10,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/arm920t/clock.c b/arch/arm/mach-at91/arm920t/clock.c
index 09ac66d619d2..ac55a61be647 100644
--- a/arch/arm/mach-at91/arm920t/clock.c
+++ b/arch/arm/mach-at91/arm920t/clock.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) 2009 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/arm920t/cpu.c b/arch/arm/mach-at91/arm920t/cpu.c
index 9bf03fd68ecc..579e76b339d8 100644
--- a/arch/arm/mach-at91/arm920t/cpu.c
+++ b/arch/arm/mach-at91/arm920t/cpu.c
@@ -10,7 +10,7 @@
  * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/arm920t/reset.c b/arch/arm/mach-at91/arm920t/reset.c
index 91e375146ad7..7582cef417ff 100644
--- a/arch/arm/mach-at91/arm920t/reset.c
+++ b/arch/arm/mach-at91/arm920t/reset.c
@@ -13,7 +13,6 @@
  * Alex Zuepke <azu@sysgo.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/arm920t/timer.c b/arch/arm/mach-at91/arm920t/timer.c
index 8ef5764e3153..f7b4116344ca 100644
--- a/arch/arm/mach-at91/arm920t/timer.c
+++ b/arch/arm/mach-at91/arm920t/timer.c
@@ -13,7 +13,7 @@
  * Alex Zuepke <azu@sysgo.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9260_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9260_devices.c
index c10571fa28a0..201c99ade4ec 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9260_devices.c
@@ -5,7 +5,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <asm/arch/at91sam9260_matrix.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9261_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9261_devices.c
index 0c2b9f2ecc9b..b8d209cbec84 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9261_devices.c
@@ -5,7 +5,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9263_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9263_devices.c
index 3b8a4623866c..1749662dae9c 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9263_devices.c
@@ -9,7 +9,6 @@
  * esd electronic system design gmbh <www.esd.eu>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9m10g45_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9m10g45_devices.c
index d517810c991a..4c481484c3d2 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9m10g45_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9m10g45_devices.c
@@ -5,7 +5,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9n12_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9n12_devices.c
index 9f98ce7a45ca..4dc6e51aba83 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9n12_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9n12_devices.c
@@ -4,7 +4,6 @@
  * Josh Wu <josh.wu@atmel.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/at91_pio.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9rl_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9rl_devices.c
index b4002eb75046..4f5bafb8c2e8 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9rl_devices.c
@@ -5,7 +5,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/arm926ejs/at91sam9x5_devices.c b/arch/arm/mach-at91/arm926ejs/at91sam9x5_devices.c
index f44760bed31b..40c8a58b5635 100644
--- a/arch/arm/mach-at91/arm926ejs/at91sam9x5_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/at91sam9x5_devices.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2012 Atmel Corporation
  */
 
-#include <common.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/gpio.h>
diff --git a/arch/arm/mach-at91/arm926ejs/clock.c b/arch/arm/mach-at91/arm926ejs/clock.c
index 013daf43b742..241de6a53788 100644
--- a/arch/arm/mach-at91/arm926ejs/clock.c
+++ b/arch/arm/mach-at91/arm926ejs/clock.c
@@ -7,7 +7,8 @@
  * Copyright (C) 2009 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 
-#include <common.h>
+#include <config.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/arm926ejs/cpu.c b/arch/arm/mach-at91/arm926ejs/cpu.c
index 5e84b0a40e13..e476cd5bcf3d 100644
--- a/arch/arm/mach-at91/arm926ejs/cpu.c
+++ b/arch/arm/mach-at91/arm926ejs/cpu.c
@@ -6,7 +6,7 @@
  * Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <vsprintf.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-at91/arm926ejs/eflash.c b/arch/arm/mach-at91/arm926ejs/eflash.c
index aade13cc014b..bb66700566e5 100644
--- a/arch/arm/mach-at91/arm926ejs/eflash.c
+++ b/arch/arm/mach-at91/arm926ejs/eflash.c
@@ -42,7 +42,6 @@
  *	someone puts a jffs2 into them)
  * do a read-modify-write for partially programmed pages
  */
-#include <common.h>
 #include <display_options.h>
 #include <flash.h>
 #include <log.h>
diff --git a/arch/arm/mach-at91/arm926ejs/reset.c b/arch/arm/mach-at91/arm926ejs/reset.c
index 6acbfa33011d..01b2663f96c9 100644
--- a/arch/arm/mach-at91/arm926ejs/reset.c
+++ b/arch/arm/mach-at91/arm926ejs/reset.c
@@ -5,7 +5,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/arm926ejs/sam9x60_devices.c b/arch/arm/mach-at91/arm926ejs/sam9x60_devices.c
index e3d3dd880cad..97c572deaaf0 100644
--- a/arch/arm/mach-at91/arm926ejs/sam9x60_devices.c
+++ b/arch/arm/mach-at91/arm926ejs/sam9x60_devices.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries
  */
 
-#include <common.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/gpio.h>
diff --git a/arch/arm/mach-at91/arm926ejs/timer.c b/arch/arm/mach-at91/arm926ejs/timer.c
index a8cf0e4bd799..137a5e5b8fd0 100644
--- a/arch/arm/mach-at91/arm926ejs/timer.c
+++ b/arch/arm/mach-at91/arm926ejs/timer.c
@@ -5,7 +5,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-at91/armv7/clock.c b/arch/arm/mach-at91/armv7/clock.c
index 6bfa02d1d0a3..5357b4cffc2c 100644
--- a/arch/arm/mach-at91/armv7/clock.c
+++ b/arch/arm/mach-at91/armv7/clock.c
@@ -9,7 +9,7 @@
  * Copyright (C) 2015 Wenyou Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-at91/armv7/cpu.c b/arch/arm/mach-at91/armv7/cpu.c
index 5ea7e2609f59..f4b2f4f351cb 100644
--- a/arch/arm/mach-at91/armv7/cpu.c
+++ b/arch/arm/mach-at91/armv7/cpu.c
@@ -8,7 +8,7 @@
  * Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <vsprintf.h>
diff --git a/arch/arm/mach-at91/armv7/sama5d2_devices.c b/arch/arm/mach-at91/armv7/sama5d2_devices.c
index edc20574c31b..469c22117665 100644
--- a/arch/arm/mach-at91/armv7/sama5d2_devices.c
+++ b/arch/arm/mach-at91/armv7/sama5d2_devices.c
@@ -4,7 +4,6 @@
  *		      Wenyou Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/sama5d2.h>
diff --git a/arch/arm/mach-at91/armv7/sama5d3_devices.c b/arch/arm/mach-at91/armv7/sama5d3_devices.c
index 04b700a94d73..67b63208edaa 100644
--- a/arch/arm/mach-at91/armv7/sama5d3_devices.c
+++ b/arch/arm/mach-at91/armv7/sama5d3_devices.c
@@ -4,7 +4,6 @@
  * Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
 #include <asm/arch/sama5d3.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/armv7/sama5d4_devices.c b/arch/arm/mach-at91/armv7/sama5d4_devices.c
index e68ae9940788..76fff9cd466c 100644
--- a/arch/arm/mach-at91/armv7/sama5d4_devices.c
+++ b/arch/arm/mach-at91/armv7/sama5d4_devices.c
@@ -4,7 +4,6 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-at91/armv7/timer.c b/arch/arm/mach-at91/armv7/timer.c
index 1f54c5dcad98..bfdb75ce39a9 100644
--- a/arch/arm/mach-at91/armv7/timer.c
+++ b/arch/arm/mach-at91/armv7/timer.c
@@ -8,7 +8,6 @@
  * Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-at91/atmel_sfr.c b/arch/arm/mach-at91/atmel_sfr.c
index 62108d2bd0a5..019ef930022f 100644
--- a/arch/arm/mach-at91/atmel_sfr.c
+++ b/arch/arm/mach-at91/atmel_sfr.c
@@ -4,7 +4,7 @@
  *		      Wenyou Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/arch/at91_sfr.h>
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 8344daeb39a2..442b822fe77f 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -4,8 +4,8 @@
  *		      Wenyou Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <dm.h>
+#include <time.h>
 #include <wdt.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/include/mach/at91_common.h b/arch/arm/mach-at91/include/mach/at91_common.h
index f7b411cf7dfa..683e539b1b3c 100644
--- a/arch/arm/mach-at91/include/mach/at91_common.h
+++ b/arch/arm/mach-at91/include/mach/at91_common.h
@@ -8,6 +8,8 @@
 #ifndef AT91_COMMON_H
 #define AT91_COMMON_H
 
+#include <linux/types.h>
+
 void at91_can_hw_init(void);
 void at91_gmac_hw_init(void);
 void at91_macb_hw_init(void);
diff --git a/arch/arm/mach-at91/matrix.c b/arch/arm/mach-at91/matrix.c
index 2fa8493a0bd6..3bef5648d4a1 100644
--- a/arch/arm/mach-at91/matrix.c
+++ b/arch/arm/mach-at91/matrix.c
@@ -4,7 +4,6 @@
  *		      Wenyou Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/arch/sama5_matrix.h>
diff --git a/arch/arm/mach-at91/mpddrc.c b/arch/arm/mach-at91/mpddrc.c
index 5422c05456e0..ac6a719d9c08 100644
--- a/arch/arm/mach-at91/mpddrc.c
+++ b/arch/arm/mach-at91/mpddrc.c
@@ -7,7 +7,6 @@
  *		      Wenyou Yang <wenyou.yang@atmel.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/atmel_mpddrc.h>
 #include <asm/arch/at91_common.h>
diff --git a/arch/arm/mach-at91/phy.c b/arch/arm/mach-at91/phy.c
index f4484a77c7de..ec38f5bc9315 100644
--- a/arch/arm/mach-at91/phy.c
+++ b/arch/arm/mach-at91/phy.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 DENX Software Engineering, hs@denx.de
  */
 
-#include <common.h>
+#include <time.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-at91/sdram.c b/arch/arm/mach-at91/sdram.c
index 6638aa82bb64..be3e91c7dbad 100644
--- a/arch/arm/mach-at91/sdram.c
+++ b/arch/arm/mach-at91/sdram.c
@@ -9,7 +9,6 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/at91sam9_sdramc.h>
diff --git a/arch/arm/mach-at91/spl.c b/arch/arm/mach-at91/spl.c
index 8d537998c984..5feb8f735511 100644
--- a/arch/arm/mach-at91/spl.c
+++ b/arch/arm/mach-at91/spl.c
@@ -4,7 +4,6 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/io.h>
 #include <asm/arch/at91_common.h>
diff --git a/arch/arm/mach-at91/spl_at91.c b/arch/arm/mach-at91/spl_at91.c
index dfba9f730c12..cde1700a2839 100644
--- a/arch/arm/mach-at91/spl_at91.c
+++ b/arch/arm/mach-at91/spl_at91.c
@@ -8,7 +8,7 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-at91/spl_atmel.c b/arch/arm/mach-at91/spl_atmel.c
index a30c4f6c075f..62a7df8a195f 100644
--- a/arch/arm/mach-at91/spl_atmel.c
+++ b/arch/arm/mach-at91/spl_atmel.c
@@ -4,7 +4,7 @@
  *		      Bo Shen <voice.shen@atmel.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

