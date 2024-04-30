Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CE8C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712A488A6D;
	Tue, 30 Apr 2024 15:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YJB+0cbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E765288A35; Tue, 30 Apr 2024 15:36:25 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761E288A41
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ee3a7cb9f1so1052488a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484182; x=1715088982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35kemroWsTwvH7sSIDNz7zx+o+qvS6JJHX9b8luIunE=;
 b=YJB+0cbGdswy9Cn5eNlq10xnQBdqikvdGaljdi/oL0rn/Vy7Dp7oFFt3l5fqY7QlKr
 EWiQjrGvtbKEfTs3b1MfKpTRWsfNmtmRUdb8LxHt8vQZClPxgZI5ijkbRngTYgTuisOE
 K6q9MY8h8kQqJK0L1B5TqBaBE7uOcrCAXpAiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484182; x=1715088982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35kemroWsTwvH7sSIDNz7zx+o+qvS6JJHX9b8luIunE=;
 b=ktQIqIiX3K6OV5mLoXW+vpzav4JmXSHzEwkwN5fXKtmXfYnU4JzrbinUF5vFmoSvMz
 i4djKSaLN2Jc3W+swvE+EwdLaKvKt/IRK4MCQyy6SV2uGbmNk+Lytg9S+igUi+hnfFDk
 TKPLasq+NglJZGIrZ6WyTbFOS7efwktykctK/5h8S4jL70n42FT0cvdJw2Cle46jXyKP
 l0ZynJpRoSi+cDraljz3MxJL5ofYfLXHfmUy7tNuXq08wUFFzd+sKn+lL9BQCfj5nB/S
 n+EVDOlOAZD+iCYj5itX5/ZtWiimBvzLh0mW+/tCf5OzAjp9cRDC+X2gqo6+MylM/BDn
 YPNQ==
X-Gm-Message-State: AOJu0YzIR0Ge+V5ossSKs5sgws5ngta37KPjSFoLO+aGjLAQgu/0pvCl
 /tRUZfVkkiq6HoqTcnJaq2MZnhXjpyZUUts0zbmQzLTNIlsmBtNpWZ/AK96onqN02fjsRyOLRu/
 a9BkTcA==
X-Google-Smtp-Source: AGHT+IEDeTL06urhMHuWQdbBLhx32HQZJobE7OslCMP+29tJ07cXJG/jhnjpIIe7axpwsld5GD9Xkw==
X-Received: by 2002:a9d:7b47:0:b0:6ee:203e:a669 with SMTP id
 f7-20020a9d7b47000000b006ee203ea669mr9211773oto.5.1714484181946; 
 Tue, 30 Apr 2024 06:36:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 18/33] arm: mvebu: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:44 -0600
Message-Id: <20240430133559.1836389-18-trini@konsulko.com>
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

Remove <common.h> from all mach-mvebu files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
Cc: "Marek Behún" <kabel@kernel.org>
---
 arch/arm/mach-mvebu/alleycat5/cpu.c                       | 2 +-
 arch/arm/mach-mvebu/alleycat5/soc.c                       | 1 -
 arch/arm/mach-mvebu/arm64-common.c                        | 2 +-
 arch/arm/mach-mvebu/armada3700/cpu.c                      | 1 -
 arch/arm/mach-mvebu/armada3700/efuse.c                    | 3 ++-
 arch/arm/mach-mvebu/armada3700/mbox.c                     | 2 +-
 arch/arm/mach-mvebu/armada8k/cpu.c                        | 1 -
 arch/arm/mach-mvebu/armada8k/dram.c                       | 3 ++-
 arch/arm/mach-mvebu/cpu.c                                 | 2 +-
 arch/arm/mach-mvebu/dram.c                                | 2 +-
 arch/arm/mach-mvebu/efuse.c                               | 1 -
 arch/arm/mach-mvebu/gpio.c                                | 1 -
 arch/arm/mach-mvebu/mbus.c                                | 2 +-
 arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec-38x.c | 1 -
 arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec.c     | 2 +-
 arch/arm/mach-mvebu/serdes/a38x/seq_exec.c                | 1 -
 arch/arm/mach-mvebu/serdes/a38x/sys_env_lib.c             | 1 -
 arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c       | 2 +-
 arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.c      | 1 -
 arch/arm/mach-mvebu/spl.c                                 | 1 -
 arch/arm/mach-mvebu/system-controller.c                   | 1 -
 21 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c b/arch/arm/mach-mvebu/alleycat5/cpu.c
index 0f72ae1709be..be2d9a25bf90 100644
--- a/arch/arm/mach-mvebu/alleycat5/cpu.c
+++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2018 Marvell International Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <linux/libfdt.h>
diff --git a/arch/arm/mach-mvebu/alleycat5/soc.c b/arch/arm/mach-mvebu/alleycat5/soc.c
index 734b0a87dd49..98e66735eb9e 100644
--- a/arch/arm/mach-mvebu/alleycat5/soc.c
+++ b/arch/arm/mach-mvebu/alleycat5/soc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Marvell International Ltd.
  */
 
-#include <common.h>
 #include <asm/arch-armada8k/cache_llc.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/arm64-common.c b/arch/arm/mach-mvebu/arm64-common.c
index 4c67f1aba4de..63a12f7d7743 100644
--- a/arch/arm/mach-mvebu/arm64-common.c
+++ b/arch/arm/mach-mvebu/arm64-common.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/arch/arm/mach-mvebu/armada3700/cpu.c b/arch/arm/mach-mvebu/armada3700/cpu.c
index ab72b304e5da..17525691e682 100644
--- a/arch/arm/mach-mvebu/armada3700/cpu.c
+++ b/arch/arm/mach-mvebu/armada3700/cpu.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2020 Marek Behún <kabel@kernel.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-mvebu/armada3700/efuse.c b/arch/arm/mach-mvebu/armada3700/efuse.c
index 07d5f394354c..84a1e388c11b 100644
--- a/arch/arm/mach-mvebu/armada3700/efuse.c
+++ b/arch/arm/mach-mvebu/armada3700/efuse.c
@@ -5,9 +5,10 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 #include <mach/mbox.h>
 #include <mach/soc.h>
 
diff --git a/arch/arm/mach-mvebu/armada3700/mbox.c b/arch/arm/mach-mvebu/armada3700/mbox.c
index 6555b8673ce0..5ac543abce5b 100644
--- a/arch/arm/mach-mvebu/armada3700/mbox.c
+++ b/arch/arm/mach-mvebu/armada3700/mbox.c
@@ -4,11 +4,11 @@
  * Copyright (C) 2021 Pali Rohár <pali@kernel.org>
  */
 
-#include <common.h>
 #include <asm/arch/soc.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <mach/mbox.h>
 
 #define RWTM_BASE		(MVEBU_REGISTER(0xb0000))
diff --git a/arch/arm/mach-mvebu/armada8k/cpu.c b/arch/arm/mach-mvebu/armada8k/cpu.c
index 939abce000f6..7908f75809c5 100644
--- a/arch/arm/mach-mvebu/armada8k/cpu.c
+++ b/arch/arm/mach-mvebu/armada8k/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-mvebu/armada8k/dram.c b/arch/arm/mach-mvebu/armada8k/dram.c
index 6c801bfa1db7..8a87e4a8e035 100644
--- a/arch/arm/mach-mvebu/armada8k/dram.c
+++ b/arch/arm/mach-mvebu/armada8k/dram.c
@@ -3,10 +3,11 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/sizes.h>
diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index 7c62a5dbb6a0..e603ab9ffb75 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2014-2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <ahci.h>
 #include <cpu_func.h>
 #include <init.h>
diff --git a/arch/arm/mach-mvebu/dram.c b/arch/arm/mach-mvebu/dram.c
index d398d0f7676a..daf2f8e3f671 100644
--- a/arch/arm/mach-mvebu/dram.c
+++ b/arch/arm/mach-mvebu/dram.c
@@ -6,9 +6,9 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
diff --git a/arch/arm/mach-mvebu/efuse.c b/arch/arm/mach-mvebu/efuse.c
index be5dc0e07d9b..475687955e05 100644
--- a/arch/arm/mach-mvebu/efuse.c
+++ b/arch/arm/mach-mvebu/efuse.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/gpio.c b/arch/arm/mach-mvebu/gpio.c
index 1d1e3df8ba90..587cbb00e7fc 100644
--- a/arch/arm/mach-mvebu/gpio.c
+++ b/arch/arm/mach-mvebu/gpio.c
@@ -5,7 +5,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
diff --git a/arch/arm/mach-mvebu/mbus.c b/arch/arm/mach-mvebu/mbus.c
index 959ca8e92602..9baeece3c850 100644
--- a/arch/arm/mach-mvebu/mbus.c
+++ b/arch/arm/mach-mvebu/mbus.c
@@ -46,7 +46,7 @@
  *   mvebu_mbus_del_window().
  */
 
-#include <common.h>
+#include <config.h>
 #include <malloc.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec-38x.c b/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec-38x.c
index 12596ec2d8bd..4582871556d9 100644
--- a/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec-38x.c
+++ b/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec-38x.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec.c b/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec.c
index 3349f4eb5491..efc31d5218ac 100644
--- a/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec.c
+++ b/arch/arm/mach-mvebu/serdes/a38x/high_speed_env_spec.c
@@ -3,7 +3,7 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
+#include <config.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/serdes/a38x/seq_exec.c b/arch/arm/mach-mvebu/serdes/a38x/seq_exec.c
index 2a51b7113ce4..9a1bbba7f2f4 100644
--- a/arch/arm/mach-mvebu/serdes/a38x/seq_exec.c
+++ b/arch/arm/mach-mvebu/serdes/a38x/seq_exec.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/serdes/a38x/sys_env_lib.c b/arch/arm/mach-mvebu/serdes/a38x/sys_env_lib.c
index fb8ec11dfb95..8290b861c079 100644
--- a/arch/arm/mach-mvebu/serdes/a38x/sys_env_lib.c
+++ b/arch/arm/mach-mvebu/serdes/a38x/sys_env_lib.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c
index 68f8eade2722..61b7f168697b 100644
--- a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c
+++ b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_lib.c
@@ -3,7 +3,7 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.c b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.c
index 539d237623a1..9b7bb2c38511 100644
--- a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.c
+++ b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-mvebu/spl.c b/arch/arm/mach-mvebu/spl.c
index 79f8877745b3..4f4f7e00e3cf 100644
--- a/arch/arm/mach-mvebu/spl.c
+++ b/arch/arm/mach-mvebu/spl.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014-2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 682431ee11d9..d94bde0777c8 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <regmap.h>
-- 
2.34.1

