Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D330C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC568855C;
	Sun, 11 Aug 2024 14:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KSSl7k0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC2888617; Sun, 11 Aug 2024 14:29:39 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216F18852E
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-81f8f01981aso136132839f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379376; x=1723984176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vTSWX4XsUv7hazuNMwfv8h9SJvWHPcc9YieR9CkCrI=;
 b=KSSl7k0dGhxZfYuuqmQ1e2nY/C6j9Naok7Eke8paFuSUMsHDTmOEKl53Nj0amq32gB
 Ws1prp8syY7/imudQPfjMCDl1yHjU54iScJmi4cmsu0kQKaiQ8edbLQN3VIef2F9lqkU
 PrGpggyToOfOp/PLZGhmp42igMHXTpAmnCas0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379376; x=1723984176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vTSWX4XsUv7hazuNMwfv8h9SJvWHPcc9YieR9CkCrI=;
 b=QEfvSssOySSGfkfAy+jgUo20A8pohKxuGBxm0DAwdAqZrJ9Wxls8l14YpOA7L4b2na
 6U7NnuxFlBpMhp6FrVVTHNrBtsuaxXA+Kofx9Amjeqg+7ONzXbWXAPdaF6p0nt2Wz8fs
 HYD2zqRwoHytP4+G6iH4LOJpgR79EojMxCLeWHJ+U/LZkJqmR21iyYJKDEWuH4yiqocc
 YHfLJMBZKVEJk0b6C+WL5iJSyxwbylGAHIa75hgyL/WO/v4YjUH/8N0tWTjG9Jjuewgo
 gHgN2k7xnBbb8GLhQ4ArlFpDtmrXcxRXovlEyIBlLOiNRsNzmB4f7/qa5fp9PaLgX5xD
 bI8w==
X-Gm-Message-State: AOJu0YxYHwM192ukFqaZMQT7c2Db3DSL70Jt3pyi7qx2sg6AXqZO2gX+
 h5K8WQAhwPjl37g/4ZaSv/pzm7MSBMOVzH4S1etXkwcuUH5EywAY8pu1oXWhX5KZW5Ztwwgn3Nc
 =
X-Google-Smtp-Source: AGHT+IGxuWhvOjnlOkQe8dBa8g0x8j+IYRmcmx7MQbvwo+77zL4dmgSeevHEGPlP5/Qe6GQRbXLLgw==
X-Received: by 2002:a05:6602:341c:b0:803:83c0:6422 with SMTP id
 ca18e2360f4ac-8225ee8437dmr989249939f.9.1723379375684; 
 Sun, 11 Aug 2024 05:29:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 02/15] rockchip: Move the default timer init to a common
 file
Date: Sun, 11 Aug 2024 06:29:11 -0600
Message-Id: <20240811122924.4035982-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

Rather than repeating the same code in two files (SPL and TPL), move it
to a shared filed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Drop unused constants from spl.c file

 arch/arm/include/asm/arch-rockchip/timer.h |  3 ++
 arch/arm/mach-rockchip/Makefile            |  4 +--
 arch/arm/mach-rockchip/spl.c               | 28 +----------------
 arch/arm/mach-rockchip/spl_common.c        | 36 ++++++++++++++++++++++
 arch/arm/mach-rockchip/tpl.c               | 30 +-----------------
 5 files changed, 43 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/spl_common.c

diff --git a/arch/arm/include/asm/arch-rockchip/timer.h b/arch/arm/include/asm/arch-rockchip/timer.h
index 77b54220447..b5fc738c98c 100644
--- a/arch/arm/include/asm/arch-rockchip/timer.h
+++ b/arch/arm/include/asm/arch-rockchip/timer.h
@@ -15,4 +15,7 @@ struct rk_timer {
 	u32 timer_int_status;
 };
 
+/** rockchip_stimer_init() - Set up the timer ready for use */
+void rockchip_stimer_init(void);
+
 #endif
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index c07bdaee4c3..3b13891ec24 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -8,9 +8,9 @@
 # inaccessible/protected memory (and the bootrom-helper assumes that
 # the stack-pointer is valid before switching to the U-Boot stack).
 obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
-obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
+obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
 obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
-obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o
+obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
 obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 3ce7e792b5a..f4d29bbdd17 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -13,6 +13,7 @@
 #include <ram.h>
 #include <spl.h>
 #include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/timer.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
@@ -79,33 +80,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return MMCSD_MODE_RAW;
 }
 
-#define TIMER_LOAD_COUNT_L	0x00
-#define TIMER_LOAD_COUNT_H	0x04
-#define TIMER_CONTROL_REG	0x10
-#define TIMER_EN	0x1
-#define	TIMER_FMODE	BIT(0)
-#define	TIMER_RMODE	BIT(1)
-
-__weak void rockchip_stimer_init(void)
-{
-#if defined(CONFIG_ROCKCHIP_STIMER_BASE)
-	/* If Timer already enabled, don't re-init it */
-	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-
-	if (reg & TIMER_EN)
-		return;
-#ifndef CONFIG_ARM64
-	asm volatile("mcr p15, 0, %0, c14, c0, 0"
-		     : : "r"(CONFIG_COUNTER_FREQUENCY));
-#endif
-	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
-	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
-	       TIMER_CONTROL_REG);
-#endif
-}
-
 __weak int board_early_init_f(void)
 {
 	return 0;
diff --git a/arch/arm/mach-rockchip/spl_common.c b/arch/arm/mach-rockchip/spl_common.c
new file mode 100644
index 00000000000..b29f33448ab
--- /dev/null
+++ b/arch/arm/mach-rockchip/spl_common.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2019 Rockchip Electronics Co., Ltd
+ */
+
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+#define TIMER_LOAD_COUNT_L	0x00
+#define TIMER_LOAD_COUNT_H	0x04
+#define TIMER_CONTROL_REG	0x10
+#define TIMER_EN	0x1
+#define	TIMER_FMODE	BIT(0)
+#define	TIMER_RMODE	BIT(1)
+
+__weak void rockchip_stimer_init(void)
+{
+#if defined(CONFIG_ROCKCHIP_STIMER_BASE)
+	/* If Timer already enabled, don't re-init it */
+	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
+
+	if (reg & TIMER_EN)
+		return;
+
+#ifndef CONFIG_ARM64
+	asm volatile("mcr p15, 0, %0, c14, c0, 0"
+		     : : "r"(CONFIG_COUNTER_FREQUENCY));
+#endif
+
+	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
+	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
+	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
+	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
+	       TIMER_CONTROL_REG);
+#endif
+}
diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index 597a5caa84b..bbb9329e725 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -14,41 +14,13 @@
 #include <version.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/timer.h>
 #include <linux/bitops.h>
 
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
 #include <timestamp.h>
 #endif
 
-#define TIMER_LOAD_COUNT_L	0x00
-#define TIMER_LOAD_COUNT_H	0x04
-#define TIMER_CONTROL_REG	0x10
-#define TIMER_EN	0x1
-#define	TIMER_FMODE	BIT(0)
-#define	TIMER_RMODE	BIT(1)
-
-__weak void rockchip_stimer_init(void)
-{
-#if defined(CONFIG_ROCKCHIP_STIMER_BASE)
-	/* If Timer already enabled, don't re-init it */
-	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-
-	if (reg & TIMER_EN)
-		return;
-
-#ifndef CONFIG_ARM64
-	asm volatile("mcr p15, 0, %0, c14, c0, 0"
-		     : : "r"(CONFIG_COUNTER_FREQUENCY));
-#endif
-
-	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
-	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
-	       TIMER_CONTROL_REG);
-#endif
-}
-
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
-- 
2.34.1

