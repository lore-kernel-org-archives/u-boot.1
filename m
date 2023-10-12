Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AA9CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3226C86D41;
	Fri, 13 Oct 2023 01:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qL+Jjy81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DF986E29; Fri, 13 Oct 2023 01:04:52 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6067886E14
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7b91faf40so18667267b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697151843; x=1697756643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDDWxFObcOzyD/5K86YshAwKABbQgEW7aLOLVkqTdNE=;
 b=qL+Jjy81Y7SlxaPEq61o96vdlcSlyOV9a/Gq1HMJ5QbatREMWRuEQCL/W78vVrRMiT
 nmTcLCGs9wstpt6mPlxIPWxoyrG2S3c5tEh1gMud35HegH0Uj+/vcnfwXjZujpfeV3D5
 PJSZ+kaPj/ipx1w6RYSTUIFcfVSISOB0ayGP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697151843; x=1697756643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDDWxFObcOzyD/5K86YshAwKABbQgEW7aLOLVkqTdNE=;
 b=PCxtoDq8UctF0sbQRKA2HkSjQgunPn87V3UwT2V6xckSAj26BfMMfT96LUizCkD5Sl
 Z3OLkqsnvnSEHWcHM+8b4Xvy/Ke9Q22JoPN5OIaTERam/sMfhmjwTzvMqD1ii8WVHvUU
 j7ZjpFoAsn6VoR5APqkUTqD0GcXMlSQ4Mxq8XXJOAQnJFeERDkqCUDSloW8yhkepH780
 ISPTRzO9lvpVBZybxb+n5P0VustLvJkpmjb2YDPSoPiIzQnSlfKsvdimzRm5eonH515L
 HvphTlm80TRSztBc/XLUAAT0IOFzwmzLSS0xdAcLKn1FmUX1JdGXyNFlPWtak4/hZLTo
 Ia1w==
X-Gm-Message-State: AOJu0YzrB9agpXunIAoDnp4fzmVW4L0VqMCp76Dl8t/SxsOqHrb/DmD2
 yRH4N4f5hcemkpN6E68RO74jFKE2Ijx/t+UWaYFouA==
X-Google-Smtp-Source: AGHT+IHJj5qR3ZlK9hpN93FZUHTIbTkuvHxceVdaithjjF37IQ0fVQYHo3pjPYQBPIeE6Dm02Jd2Gw==
X-Received: by 2002:a81:65d6:0:b0:59b:dbb7:5c74 with SMTP id
 z205-20020a8165d6000000b0059bdbb75c74mr25517646ywb.32.1697151842830; 
 Thu, 12 Oct 2023 16:04:02 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b005925765aa30sm278730ywc.135.2023.10.12.16.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 16:04:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH 3/7] arc: Remove common.h usage
Date: Thu, 12 Oct 2023 19:03:55 -0400
Message-Id: <20231012230359.2005249-3-trini@konsulko.com>
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
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: uboot-snps-arc@synopsys.com
---
 arch/arc/lib/bootm.c                   | 1 -
 arch/arc/lib/cache.c                   | 1 -
 arch/arc/lib/cpu.c                     | 1 -
 arch/arc/lib/init_helpers.c            | 1 -
 arch/arc/lib/interrupts.c              | 2 +-
 arch/arc/lib/relocate.c                | 1 -
 arch/arc/lib/reset.c                   | 1 -
 board/abilis/tb100/tb100.c             | 1 -
 board/synopsys/axs10x/axs10x.c         | 1 -
 board/synopsys/emsdp/emsdp.c           | 1 -
 board/synopsys/hsdk/clk-lib.h          | 1 -
 board/synopsys/hsdk/env-lib.c          | 2 ++
 board/synopsys/hsdk/env-lib.h          | 1 -
 board/synopsys/hsdk/hsdk.c             | 1 -
 board/synopsys/iot_devkit/iot_devkit.c | 1 -
 board/synopsys/nsim/nsim.c             | 1 -
 16 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 2dd003445f8f..44ec5864a1c6 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013-2014 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <env.h>
 #include <image.h>
diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
index d97a5787424e..22e748868a74 100644
--- a/arch/arc/lib/cache.c
+++ b/arch/arc/lib/cache.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
 #include <linux/bitops.h>
diff --git a/arch/arc/lib/cpu.c b/arch/arc/lib/cpu.c
index 156785796183..803dfd425580 100644
--- a/arch/arc/lib/cpu.c
+++ b/arch/arc/lib/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013-2014, 2018 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/arch/arc/lib/init_helpers.c b/arch/arc/lib/init_helpers.c
index 023eae190759..858b388cc0b9 100644
--- a/arch/arc/lib/init_helpers.c
+++ b/arch/arc/lib/init_helpers.c
@@ -5,7 +5,6 @@
 
 #include <init.h>
 #include <asm/cache.h>
-#include <common.h>
 
 int init_cache_f_r(void)
 {
diff --git a/arch/arc/lib/interrupts.c b/arch/arc/lib/interrupts.c
index db21fbb11428..523b44cb95a4 100644
--- a/arch/arc/lib/interrupts.c
+++ b/arch/arc/lib/interrupts.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2013-2014 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <irq_func.h>
+#include <vsprintf.h>
 #include <asm/arcregs.h>
 #include <asm/ptrace.h>
 
diff --git a/arch/arc/lib/relocate.c b/arch/arc/lib/relocate.c
index fd6f4fbc9304..95b6d5150c78 100644
--- a/arch/arc/lib/relocate.c
+++ b/arch/arc/lib/relocate.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013-2014 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <elf.h>
 #include <log.h>
 #include <asm/sections.h>
diff --git a/arch/arc/lib/reset.c b/arch/arc/lib/reset.c
index b8589d0f0a47..fa60fa963381 100644
--- a/arch/arc/lib/reset.c
+++ b/arch/arc/lib/reset.c
@@ -4,7 +4,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <cpu_func.h>
 
 __weak void reset_cpu(void)
diff --git a/board/abilis/tb100/tb100.c b/board/abilis/tb100/tb100.c
index 89e73225a7df..3dc9e14ef8c0 100644
--- a/board/abilis/tb100/tb100.c
+++ b/board/abilis/tb100/tb100.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2014 Pierrick Hascoet, Abilis Systems
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <net.h>
 #include <netdev.h>
diff --git a/board/synopsys/axs10x/axs10x.c b/board/synopsys/axs10x/axs10x.c
index 75e4d037623e..95297a18357f 100644
--- a/board/synopsys/axs10x/axs10x.c
+++ b/board/synopsys/axs10x/axs10x.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013-2014 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dwmmc.h>
 #include <init.h>
diff --git a/board/synopsys/emsdp/emsdp.c b/board/synopsys/emsdp/emsdp.c
index a3cee23411d0..adec7d321994 100644
--- a/board/synopsys/emsdp/emsdp.c
+++ b/board/synopsys/emsdp/emsdp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <dwmmc.h>
diff --git a/board/synopsys/hsdk/clk-lib.h b/board/synopsys/hsdk/clk-lib.h
index 970bcd4a17e7..e1140a10b23a 100644
--- a/board/synopsys/hsdk/clk-lib.h
+++ b/board/synopsys/hsdk/clk-lib.h
@@ -7,7 +7,6 @@
 #ifndef __BOARD_CLK_LIB_H
 #define __BOARD_CLK_LIB_H
 
-#include <common.h>
 #include <linux/bitops.h>
 
 enum clk_ctl_ops {
diff --git a/board/synopsys/hsdk/env-lib.c b/board/synopsys/hsdk/env-lib.c
index d85e8167332f..85a2249f17f2 100644
--- a/board/synopsys/hsdk/env-lib.c
+++ b/board/synopsys/hsdk/env-lib.c
@@ -7,6 +7,8 @@
 #include "env-lib.h"
 #include <env.h>
 #include <log.h>
+#include <vsprintf.h>
+#include <linux/errno.h>
 #include <linux/printk.h>
 
 #define MAX_CMD_LEN	25
diff --git a/board/synopsys/hsdk/env-lib.h b/board/synopsys/hsdk/env-lib.h
index 48c17c4d4f62..cabca1d0f3d3 100644
--- a/board/synopsys/hsdk/env-lib.h
+++ b/board/synopsys/hsdk/env-lib.h
@@ -7,7 +7,6 @@
 #ifndef __BOARD_ENV_LIB_H
 #define __BOARD_ENV_LIB_H
 
-#include <common.h>
 #include <config.h>
 #include <linux/kernel.h>
 
diff --git a/board/synopsys/hsdk/hsdk.c b/board/synopsys/hsdk/hsdk.c
index 6cbc89ae7874..8eb10f2226fc 100644
--- a/board/synopsys/hsdk/hsdk.c
+++ b/board/synopsys/hsdk/hsdk.c
@@ -4,7 +4,6 @@
  * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <config.h>
 #include <cpu_func.h>
diff --git a/board/synopsys/iot_devkit/iot_devkit.c b/board/synopsys/iot_devkit/iot_devkit.c
index 650958f94c26..dec49e3ce5d6 100644
--- a/board/synopsys/iot_devkit/iot_devkit.c
+++ b/board/synopsys/iot_devkit/iot_devkit.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/synopsys/nsim/nsim.c b/board/synopsys/nsim/nsim.c
index 00e5cc36414b..5953b365fd20 100644
--- a/board/synopsys/nsim/nsim.c
+++ b/board/synopsys/nsim/nsim.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Synopsys, Inc. All rights reserved.
  */
 
-#include <common.h>
 #include <init.h>
 #include <dm/device.h>
 #include <virtio_types.h>
-- 
2.34.1

