Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03596C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1919388BFD;
	Sat, 20 Jul 2024 08:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZPV/gYKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9976D88C20; Sat, 20 Jul 2024 08:20:46 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879AE88BFC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso17066975e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456444; x=1722061244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+oW3CsyV+nYlYgMcVmTwgEEy6dSUqBDdsXPdBSw2yc=;
 b=ZPV/gYKHX9aGVapqhFtjPSkps0vwwqMISC/her+nJVlRIJ+NaUS7QKTe5SsqSmgqR/
 oqIzG0LfYxA3vEggwfVjF/F8sCmgSCAAXk3egdQ0AUARXtWqQH3npnJwTU2nTvzZo09q
 9ti4KPi5EHXNaP/Ula+MbqKEUkeyQKtk77UxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456444; x=1722061244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+oW3CsyV+nYlYgMcVmTwgEEy6dSUqBDdsXPdBSw2yc=;
 b=p9Zl3c06Vm2pjKfIGXSSqKnbM+r1goPwd5H1xQXkRrc+t20mqxTvrBhl5QKtx8zvx5
 ETW0DlJl/N9FQs3k4h1VPYlO5q0gNtvrzD1xFrgsixf9GvryCFaQq8AUec8L8nPJBW6J
 pq14G6u+RvQJsOIn9iVEGwvZ7Hmkae5bwLLDvs0PukpKAzWQng+XHupZ+UKEA59a7ete
 Qkbg4gL2BehmAGl3gZTGqgirvAIusS065QWz+q2FS2weNjFpIvJo48pZIEAokaLSTQI3
 /AEYNV56z1XUs2hO7vu6Fyw8RlRDVWfGH+U3oD75BdPqD72HyvoyUeIWjYBzRDXNXLuU
 rCgQ==
X-Gm-Message-State: AOJu0Yy4TVTUUFZ4GhhDTMUwq/8Gr9ceq8ITqNWuTtMXve9oAJCfZ3Kr
 xM9kxAZXH8N+VdETOmPbv5Dnjst3qYNLZwoaIbvFWr9xEOeHvdKWL0pGBrG/bVMex41wDzXLLbY
 =
X-Google-Smtp-Source: AGHT+IHrPz2Dzn/MnmtilUY9sfbkQLEmhm+oRdUyVCXJw2MexSt9KMhMefsrXnN0Xs7qa4QLSRiodA==
X-Received: by 2002:a05:600c:1f10:b0:426:59aa:e2fe with SMTP id
 5b1f17b1804b1-427dc558bebmr3115845e9.19.1721456443799; 
 Fri, 19 Jul 2024 23:20:43 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 01/14] rockchip: Move the default timer init to a common file
Date: Sat, 20 Jul 2024 07:16:53 +0100
Message-Id: <20240720061706.2644229-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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
---

 arch/arm/include/asm/arch-rockchip/timer.h |  3 ++
 arch/arm/mach-rockchip/Makefile            |  4 +--
 arch/arm/mach-rockchip/spl.c               | 21 +------------
 arch/arm/mach-rockchip/spl_common.c        | 36 ++++++++++++++++++++++
 arch/arm/mach-rockchip/tpl.c               | 30 +-----------------
 5 files changed, 43 insertions(+), 51 deletions(-)
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
index 3ce7e792b5a..bbd223bc524 100644
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
@@ -86,26 +87,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 #define	TIMER_FMODE	BIT(0)
 #define	TIMER_RMODE	BIT(1)
 
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
index 50f04f9474a..0e1da8c1c89 100644
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

