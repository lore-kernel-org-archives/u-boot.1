Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80FC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690BD878E8;
	Mon,  4 Dec 2023 09:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="byiBUV5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4004875B6; Mon,  4 Dec 2023 09:21:13 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABA88787A
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50be58a751cso1992076e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678069; x=1702282869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2c/Fwyr4v9jFuG1B4HiXK+oJnmAVfgUGS+FbmBfe32A=;
 b=byiBUV5Gu9eTiBRqIBkGBRFBbJf91u2hxTVvBELxjGYeUQWVdxU0Ft5ojK5rOyfm+9
 zV0QnD96jaaXVB+BBm9qXvUuBgMNDh0Da3DBkML6+ttAr1rM28qhBdMg6bdJjn8U2FQg
 XFJFCbsaoKTf4JbYEgWlBG49QPW3ktSdrDdB9mVPnR+3QR8H/oe+6ry67QPmrdlll1S4
 Keg3WmTwaIw8zkDwIzhc1lX5QYQ7QSiJS6+7gZ2dNNmx77oguvyYP1tNvjnolhWb2PMP
 dXbVjHQPyhZLCaxnaHNEz3duKTGWBvREPO/5WpLn//+g+ODYkxmQx/1jR1/9tkxxg7rQ
 Sobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678069; x=1702282869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2c/Fwyr4v9jFuG1B4HiXK+oJnmAVfgUGS+FbmBfe32A=;
 b=Rl0fXqeqL6jR+i2L6LNk80UcUBBTqg6AuJlUOODVUDdTGEKXKOnlqTtMBXOl+2TnuS
 mLbqHHh0gxXb+/CQB4CUvPPzjyKAHyMKkuwnbaDd9K16f6lVhEthM1hJ2AGTrimPCKU0
 KdO1zu0qe8SypezAydxjrHP9HjpCXnU2EoMUyPm8dIKdsAhsvDO2LTDh5W4iLjPY9eqV
 UO5OGLhq/zglnU7vSYb4sRrG6Y0jAFpqAZfhwDewmJGgO+cPIdHB3nE+cRv9VPpMF2o8
 Sjdvu9uCR03wIVZU4zbxAqRFwbBttRqegVN8L2G0F8X9t/NvZRjskkJXIg29K9E9Zs9k
 I/og==
X-Gm-Message-State: AOJu0Yzpxnp3iWUIqjrlLnmBJ4p+AES1m1WKYrxd2SSWAmev+SxTjVFO
 tlJAdECwnqrHo7YvZDm8WYM=
X-Google-Smtp-Source: AGHT+IH5Sv8Wz1OlTQMwAXz952e0trzOE9FC8a5TN0DxDao1LezVWAMpBu99nMMno1cK21xkiMYwvw==
X-Received: by 2002:a05:6512:3da1:b0:50b:e790:e96c with SMTP id
 k33-20020a0565123da100b0050be790e96cmr1528280lfv.30.1701678069174; 
 Mon, 04 Dec 2023 00:21:09 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/8] drivers: pinctrl: tegra: incorporate existing code
Date: Mon,  4 Dec 2023 10:20:49 +0200
Message-Id: <20231204082054.4943-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
References: <20231204082054.4943-1-clamor95@gmail.com>
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

Move all existing pinmux and funcmux code into a dedicated folder in
pinctrl to simplify further maintenance.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig                   |  13 +-
 arch/arm/mach-tegra/Makefile                  |   1 -
 arch/arm/mach-tegra/board.c                   |   6 +-
 arch/arm/mach-tegra/board2.c                  |   2 +-
 arch/arm/mach-tegra/tegra114/Makefile         |   2 +-
 arch/arm/mach-tegra/tegra124/Makefile         |   2 -
 arch/arm/mach-tegra/tegra20/Makefile          |   2 +-
 arch/arm/mach-tegra/tegra210/Makefile         |   1 -
 arch/arm/mach-tegra/tegra30/Makefile          |   2 +-
 drivers/pinctrl/tegra/Makefile                |   8 +
 .../pinctrl/tegra/funcmux-tegra114.c          |   0
 .../pinctrl/tegra/funcmux-tegra124.c          |   0
 .../pinctrl/tegra/funcmux-tegra20.c           |   0
 .../pinctrl/tegra/funcmux-tegra210.c          |   0
 .../pinctrl/tegra/funcmux-tegra30.c           |   0
 .../pinctrl/tegra}/pinmux-common.c            |   0
 .../pinctrl/tegra/pinmux-tegra114.c           |   0
 .../pinctrl/tegra/pinmux-tegra124.c           |   0
 .../pinctrl/tegra/pinmux-tegra20.c            |   0
 drivers/pinctrl/tegra/pinmux-tegra210.c       | 190 ++++++++++++++++++
 .../pinctrl/tegra/pinmux-tegra30.c            |   0
 21 files changed, 212 insertions(+), 17 deletions(-)
 rename arch/arm/mach-tegra/tegra114/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra114.c (100%)
 rename arch/arm/mach-tegra/tegra124/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra124.c (100%)
 rename arch/arm/mach-tegra/tegra20/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra20.c (100%)
 rename arch/arm/mach-tegra/tegra210/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra210.c (100%)
 rename arch/arm/mach-tegra/tegra30/funcmux.c => drivers/pinctrl/tegra/funcmux-tegra30.c (100%)
 rename {arch/arm/mach-tegra => drivers/pinctrl/tegra}/pinmux-common.c (100%)
 rename arch/arm/mach-tegra/tegra114/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra114.c (100%)
 rename arch/arm/mach-tegra/tegra124/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra124.c (100%)
 rename arch/arm/mach-tegra/tegra20/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra20.c (100%)
 create mode 100644 drivers/pinctrl/tegra/pinmux-tegra210.c
 rename arch/arm/mach-tegra/tegra30/pinmux.c => drivers/pinctrl/tegra/pinmux-tegra30.c (100%)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 547372a639..b18885f4c1 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -33,9 +33,6 @@ config TEGRA_IVC
 config TEGRA_MC
 	bool
 
-config TEGRA_PINCTRL
-	bool
-
 config TEGRA_PMC
 	bool
 
@@ -75,9 +72,13 @@ config TEGRA_ARMV7_COMMON
 	bool "Tegra 32-bit common options"
 	select BINMAN
 	select CPU_V7A
+	select PINCTRL
+	select PINCTRL_TEGRA
 	select SPL
 	select SPL_BOARD_INIT if SPL
 	select SPL_DM if SPL
+	select SPL_PINCTRL if SPL
+	select SPL_PINCTRL_TEGRA if SPL
 	select SPL_SKIP_LOWLEVEL_INIT_ONLY if SPL
 	select SPL_SYSRESET if SPL
 	select SUPPORT_SPL
@@ -88,7 +89,6 @@ config TEGRA_ARMV7_COMMON
 	select TEGRA_GP_PADCTRL
 	select TEGRA_MC
 	select TEGRA_NO_BPMP
-	select TEGRA_PINCTRL
 	select TEGRA_PMC
 	select TEGRA_TIMER
 
@@ -135,6 +135,8 @@ config TEGRA124
 config TEGRA210
 	bool "Tegra210 family"
 	select GICV2
+	select PINCTRL
+	select PINCTRL_TEGRA
 	select TIMER
 	select TEGRA_ARMV8_COMMON
 	select TEGRA_CLKRST
@@ -142,7 +144,6 @@ config TEGRA210
 	select TEGRA_GP_PADCTRL
 	select TEGRA_MC
 	select TEGRA_NO_BPMP
-	select TEGRA_PINCTRL
 	select TEGRA_PMC
 	select TEGRA_PMC_SECURE
 	select TEGRA_TIMER
@@ -195,7 +196,7 @@ config TEGRA_SPI
 
 choice
 	prompt "UART to use for console"
-	depends on TEGRA_PINCTRL
+	depends on PINCTRL_TEGRA
 	default TEGRA_ENABLE_UARTA
 
 config TEGRA_ENABLE_UARTA
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index a5733b0bf6..1d22dc3942 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -17,7 +17,6 @@ obj-y += board.o board2.o
 obj-y += cache.o
 obj-$(CONFIG_TEGRA_CLKRST) += clock.o
 obj-$(CONFIG_$(SPL_)TEGRA_CRYPTO) += crypto.o
-obj-$(CONFIG_TEGRA_PINCTRL) += pinmux-common.o
 obj-$(CONFIG_TEGRA_PMC) += powergate.o
 obj-y += xusb-padctl-dummy.o
 
diff --git a/arch/arm/mach-tegra/board.c b/arch/arm/mach-tegra/board.c
index f8b61a2b3e..9224743d0e 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -17,7 +17,7 @@
 #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
 #include <asm/arch/clock.h>
 #endif
-#if IS_ENABLED(CONFIG_TEGRA_PINCTRL)
+#if CONFIG_IS_ENABLED(PINCTRL_TEGRA)
 #include <asm/arch/funcmux.h>
 #endif
 #if IS_ENABLED(CONFIG_TEGRA_MC)
@@ -163,7 +163,7 @@ int dram_init(void)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_TEGRA_PINCTRL)
+#if CONFIG_IS_ENABLED(PINCTRL_TEGRA)
 static int uart_configs[] = {
 #if defined(CONFIG_TEGRA20)
  #if defined(CONFIG_TEGRA_UARTA_UAA_UAB)
@@ -235,7 +235,7 @@ static void setup_uarts(int uart_ids)
 
 void board_init_uart_f(void)
 {
-#if IS_ENABLED(CONFIG_TEGRA_PINCTRL)
+#if CONFIG_IS_ENABLED(PINCTRL_TEGRA)
 	int uart_ids = 0;	/* bit mask of which UART ids to enable */
 
 #ifdef CONFIG_TEGRA_ENABLE_UARTA
diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 8ad76d5edf..adea12c9b7 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -34,7 +34,7 @@
 #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
 #include <asm/arch/clock.h>
 #endif
-#if IS_ENABLED(CONFIG_TEGRA_PINCTRL)
+#if CONFIG_IS_ENABLED(PINCTRL_TEGRA)
 #include <asm/arch/funcmux.h>
 #include <asm/arch/pinmux.h>
 #endif
diff --git a/arch/arm/mach-tegra/tegra114/Makefile b/arch/arm/mach-tegra/tegra114/Makefile
index 0e8f32cbd6..346d6cb569 100644
--- a/arch/arm/mach-tegra/tegra114/Makefile
+++ b/arch/arm/mach-tegra/tegra114/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SPL_BUILD) += cpu.o
 
-obj-y	+= clock.o funcmux.o pinmux.o
+obj-y	+= clock.o
diff --git a/arch/arm/mach-tegra/tegra124/Makefile b/arch/arm/mach-tegra/tegra124/Makefile
index d275dafdc4..6ea511e7b2 100644
--- a/arch/arm/mach-tegra/tegra124/Makefile
+++ b/arch/arm/mach-tegra/tegra124/Makefile
@@ -8,8 +8,6 @@
 obj-$(CONFIG_SPL_BUILD) += cpu.o
 
 obj-y	+= clock.o
-obj-y	+= funcmux.o
-obj-y	+= pinmux.o
 obj-y	+= pmc.o
 obj-y	+= xusb-padctl.o
 obj-y	+= ../xusb-padctl-common.o
diff --git a/arch/arm/mach-tegra/tegra20/Makefile b/arch/arm/mach-tegra/tegra20/Makefile
index 991cabeec5..c2ae98eb37 100644
--- a/arch/arm/mach-tegra/tegra20/Makefile
+++ b/arch/arm/mach-tegra/tegra20/Makefile
@@ -11,7 +11,7 @@ CFLAGS_warmboot_avp.o = -march=armv4t -U__LINUX_ARM_ARCH__ \
 	-D__LINUX_ARM_ARCH__=4
 CFLAGS_REMOVE_warmboot_avp.o := $(LTO_CFLAGS)
 
-obj-y	+= clock.o funcmux.o pinmux.o
+obj-y	+= clock.o
 obj-$(CONFIG_TEGRA_LP0) += warmboot.o warmboot_avp.o
 obj-$(CONFIG_TEGRA_CLOCK_SCALING) += emc.o
 obj-$(CONFIG_TEGRA_PMU) += pmu.o
diff --git a/arch/arm/mach-tegra/tegra210/Makefile b/arch/arm/mach-tegra/tegra210/Makefile
index cfcba5b68f..5cc718d276 100644
--- a/arch/arm/mach-tegra/tegra210/Makefile
+++ b/arch/arm/mach-tegra/tegra210/Makefile
@@ -6,6 +6,5 @@
 #
 
 obj-y	+= clock.o
-obj-y	+= funcmux.o
 obj-y	+= xusb-padctl.o
 obj-y	+= ../xusb-padctl-common.o
diff --git a/arch/arm/mach-tegra/tegra30/Makefile b/arch/arm/mach-tegra/tegra30/Makefile
index 28dd486d8d..ee0e6f5b94 100644
--- a/arch/arm/mach-tegra/tegra30/Makefile
+++ b/arch/arm/mach-tegra/tegra30/Makefile
@@ -5,4 +5,4 @@
 obj-$(CONFIG_SPL_BUILD) += cpu.o
 obj-$(CONFIG_$(SPL_)CMD_EBTUPDATE) += bct.o
 
-obj-y	+= clock.o funcmux.o pinmux.o
+obj-y	+= clock.o
diff --git a/drivers/pinctrl/tegra/Makefile b/drivers/pinctrl/tegra/Makefile
index be97474816..75d3cabc62 100644
--- a/drivers/pinctrl/tegra/Makefile
+++ b/drivers/pinctrl/tegra/Makefile
@@ -6,3 +6,11 @@ else
 obj-y += pinctrl-tegra.o
 endif
 endif
+
+obj-y += pinmux-common.o
+
+obj-$(CONFIG_TEGRA20) += pinmux-tegra20.o funcmux-tegra20.o
+obj-$(CONFIG_TEGRA30) += pinmux-tegra30.o funcmux-tegra30.o
+obj-$(CONFIG_TEGRA114) += pinmux-tegra114.o funcmux-tegra114.o
+obj-$(CONFIG_TEGRA124) += pinmux-tegra124.o funcmux-tegra124.o
+obj-$(CONFIG_TEGRA210) += pinmux-tegra210.o funcmux-tegra210.o
diff --git a/arch/arm/mach-tegra/tegra114/funcmux.c b/drivers/pinctrl/tegra/funcmux-tegra114.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra114/funcmux.c
rename to drivers/pinctrl/tegra/funcmux-tegra114.c
diff --git a/arch/arm/mach-tegra/tegra124/funcmux.c b/drivers/pinctrl/tegra/funcmux-tegra124.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra124/funcmux.c
rename to drivers/pinctrl/tegra/funcmux-tegra124.c
diff --git a/arch/arm/mach-tegra/tegra20/funcmux.c b/drivers/pinctrl/tegra/funcmux-tegra20.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra20/funcmux.c
rename to drivers/pinctrl/tegra/funcmux-tegra20.c
diff --git a/arch/arm/mach-tegra/tegra210/funcmux.c b/drivers/pinctrl/tegra/funcmux-tegra210.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra210/funcmux.c
rename to drivers/pinctrl/tegra/funcmux-tegra210.c
diff --git a/arch/arm/mach-tegra/tegra30/funcmux.c b/drivers/pinctrl/tegra/funcmux-tegra30.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra30/funcmux.c
rename to drivers/pinctrl/tegra/funcmux-tegra30.c
diff --git a/arch/arm/mach-tegra/pinmux-common.c b/drivers/pinctrl/tegra/pinmux-common.c
similarity index 100%
rename from arch/arm/mach-tegra/pinmux-common.c
rename to drivers/pinctrl/tegra/pinmux-common.c
diff --git a/arch/arm/mach-tegra/tegra114/pinmux.c b/drivers/pinctrl/tegra/pinmux-tegra114.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra114/pinmux.c
rename to drivers/pinctrl/tegra/pinmux-tegra114.c
diff --git a/arch/arm/mach-tegra/tegra124/pinmux.c b/drivers/pinctrl/tegra/pinmux-tegra124.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra124/pinmux.c
rename to drivers/pinctrl/tegra/pinmux-tegra124.c
diff --git a/arch/arm/mach-tegra/tegra20/pinmux.c b/drivers/pinctrl/tegra/pinmux-tegra20.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra20/pinmux.c
rename to drivers/pinctrl/tegra/pinmux-tegra20.c
diff --git a/drivers/pinctrl/tegra/pinmux-tegra210.c b/drivers/pinctrl/tegra/pinmux-tegra210.c
new file mode 100644
index 0000000000..27abec274a
--- /dev/null
+++ b/drivers/pinctrl/tegra/pinmux-tegra210.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2013-2014, NVIDIA CORPORATION. All rights reserved.
+ */
+
+#include <asm/io.h>
+#include <asm/arch/pinmux.h>
+
+#define PIN(pin, f0, f1, f2, f3)	\
+	{				\
+		.funcs = {		\
+			PMUX_FUNC_##f0,	\
+			PMUX_FUNC_##f1,	\
+			PMUX_FUNC_##f2,	\
+			PMUX_FUNC_##f3,	\
+		},			\
+	}
+
+#define PIN_RESERVED {}
+
+static const struct pmux_pingrp_desc tegra210_pingroups[] = {
+	/*  pin,                  f0,         f1,     f2,    f3 */
+	/* Offset 0x3000 */
+	PIN(SDMMC1_CLK_PM0,       SDMMC1,     RSVD1,  RSVD2, RSVD3),
+	PIN(SDMMC1_CMD_PM1,       SDMMC1,     SPI3,   RSVD2, RSVD3),
+	PIN(SDMMC1_DAT3_PM2,      SDMMC1,     SPI3,   RSVD2, RSVD3),
+	PIN(SDMMC1_DAT2_PM3,      SDMMC1,     SPI3,   RSVD2, RSVD3),
+	PIN(SDMMC1_DAT1_PM4,      SDMMC1,     SPI3,   RSVD2, RSVD3),
+	PIN(SDMMC1_DAT0_PM5,      SDMMC1,     RSVD1,  RSVD2, RSVD3),
+	PIN_RESERVED,
+	PIN(SDMMC3_CLK_PP0,       SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN(SDMMC3_CMD_PP1,       SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN(SDMMC3_DAT0_PP5,      SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN(SDMMC3_DAT1_PP4,      SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN(SDMMC3_DAT2_PP3,      SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN(SDMMC3_DAT3_PP2,      SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN_RESERVED,
+	PIN(PEX_L0_RST_N_PA0,     PE0,        RSVD1,  RSVD2, RSVD3),
+	PIN(PEX_L0_CLKREQ_N_PA1,  PE0,        RSVD1,  RSVD2, RSVD3),
+	PIN(PEX_WAKE_N_PA2,       PE,         RSVD1,  RSVD2, RSVD3),
+	PIN(PEX_L1_RST_N_PA3,     PE1,        RSVD1,  RSVD2, RSVD3),
+	PIN(PEX_L1_CLKREQ_N_PA4,  PE1,        RSVD1,  RSVD2, RSVD3),
+	PIN(SATA_LED_ACTIVE_PA5,  SATA,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI1_MOSI_PC0,        SPI1,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI1_MISO_PC1,        SPI1,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI1_SCK_PC2,         SPI1,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI1_CS0_PC3,         SPI1,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI1_CS1_PC4,         SPI1,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI2_MOSI_PB4,        SPI2,       DTV,    RSVD2, RSVD3),
+	PIN(SPI2_MISO_PB5,        SPI2,       DTV,    RSVD2, RSVD3),
+	PIN(SPI2_SCK_PB6,         SPI2,       DTV,    RSVD2, RSVD3),
+	PIN(SPI2_CS0_PB7,         SPI2,       DTV,    RSVD2, RSVD3),
+	PIN(SPI2_CS1_PDD0,        SPI2,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI4_MOSI_PC7,        SPI4,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI4_MISO_PD0,        SPI4,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI4_SCK_PC5,         SPI4,       RSVD1,  RSVD2, RSVD3),
+	PIN(SPI4_CS0_PC6,         SPI4,       RSVD1,  RSVD2, RSVD3),
+	PIN(QSPI_SCK_PEE0,        QSPI,       RSVD1,  RSVD2, RSVD3),
+	PIN(QSPI_CS_N_PEE1,       QSPI,       RSVD1,  RSVD2, RSVD3),
+	PIN(QSPI_IO0_PEE2,        QSPI,       RSVD1,  RSVD2, RSVD3),
+	PIN(QSPI_IO1_PEE3,        QSPI,       RSVD1,  RSVD2, RSVD3),
+	PIN(QSPI_IO2_PEE4,        QSPI,       RSVD1,  RSVD2, RSVD3),
+	PIN(QSPI_IO3_PEE5,        QSPI,       RSVD1,  RSVD2, RSVD3),
+	PIN_RESERVED,
+	PIN(DMIC1_CLK_PE0,        DMIC1,      I2S3,   RSVD2, RSVD3),
+	PIN(DMIC1_DAT_PE1,        DMIC1,      I2S3,   RSVD2, RSVD3),
+	PIN(DMIC2_CLK_PE2,        DMIC2,      I2S3,   RSVD2, RSVD3),
+	PIN(DMIC2_DAT_PE3,        DMIC2,      I2S3,   RSVD2, RSVD3),
+	PIN(DMIC3_CLK_PE4,        DMIC3,      I2S5A,  RSVD2, RSVD3),
+	PIN(DMIC3_DAT_PE5,        DMIC3,      I2S5A,  RSVD2, RSVD3),
+	PIN(GEN1_I2C_SCL_PJ1,     I2C1,       RSVD1,  RSVD2, RSVD3),
+	PIN(GEN1_I2C_SDA_PJ0,     I2C1,       RSVD1,  RSVD2, RSVD3),
+	PIN(GEN2_I2C_SCL_PJ2,     I2C2,       RSVD1,  RSVD2, RSVD3),
+	PIN(GEN2_I2C_SDA_PJ3,     I2C2,       RSVD1,  RSVD2, RSVD3),
+	PIN(GEN3_I2C_SCL_PF0,     I2C3,       RSVD1,  RSVD2, RSVD3),
+	PIN(GEN3_I2C_SDA_PF1,     I2C3,       RSVD1,  RSVD2, RSVD3),
+	PIN(CAM_I2C_SCL_PS2,      I2C3,       I2CVI,  RSVD2, RSVD3),
+	PIN(CAM_I2C_SDA_PS3,      I2C3,       I2CVI,  RSVD2, RSVD3),
+	PIN(PWR_I2C_SCL_PY3,      I2CPMU,     RSVD1,  RSVD2, RSVD3),
+	PIN(PWR_I2C_SDA_PY4,      I2CPMU,     RSVD1,  RSVD2, RSVD3),
+	PIN(UART1_TX_PU0,         UARTA,      RSVD1,  RSVD2, RSVD3),
+	PIN(UART1_RX_PU1,         UARTA,      RSVD1,  RSVD2, RSVD3),
+	PIN(UART1_RTS_PU2,        UARTA,      RSVD1,  RSVD2, RSVD3),
+	PIN(UART1_CTS_PU3,        UARTA,      RSVD1,  RSVD2, RSVD3),
+	PIN(UART2_TX_PG0,         UARTB,      I2S4A,  SPDIF, UART),
+	PIN(UART2_RX_PG1,         UARTB,      I2S4A,  SPDIF, UART),
+	PIN(UART2_RTS_PG2,        UARTB,      I2S4A,  RSVD2, UART),
+	PIN(UART2_CTS_PG3,        UARTB,      I2S4A,  RSVD2, UART),
+	PIN(UART3_TX_PD1,         UARTC,      SPI4,   RSVD2, RSVD3),
+	PIN(UART3_RX_PD2,         UARTC,      SPI4,   RSVD2, RSVD3),
+	PIN(UART3_RTS_PD3,        UARTC,      SPI4,   RSVD2, RSVD3),
+	PIN(UART3_CTS_PD4,        UARTC,      SPI4,   RSVD2, RSVD3),
+	PIN(UART4_TX_PI4,         UARTD,      UART,   RSVD2, RSVD3),
+	PIN(UART4_RX_PI5,         UARTD,      UART,   RSVD2, RSVD3),
+	PIN(UART4_RTS_PI6,        UARTD,      UART,   RSVD2, RSVD3),
+	PIN(UART4_CTS_PI7,        UARTD,      UART,   RSVD2, RSVD3),
+	PIN(DAP1_FS_PB0,          I2S1,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP1_DIN_PB1,         I2S1,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP1_DOUT_PB2,        I2S1,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP1_SCLK_PB3,        I2S1,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP2_FS_PAA0,         I2S2,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP2_DIN_PAA2,        I2S2,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP2_DOUT_PAA3,       I2S2,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP2_SCLK_PAA1,       I2S2,       RSVD1,  RSVD2, RSVD3),
+	PIN(DAP4_FS_PJ4,          I2S4B,      RSVD1,  RSVD2, RSVD3),
+	PIN(DAP4_DIN_PJ5,         I2S4B,      RSVD1,  RSVD2, RSVD3),
+	PIN(DAP4_DOUT_PJ6,        I2S4B,      RSVD1,  RSVD2, RSVD3),
+	PIN(DAP4_SCLK_PJ7,        I2S4B,      RSVD1,  RSVD2, RSVD3),
+	PIN(CAM1_MCLK_PS0,        EXTPERIPH3, RSVD1,  RSVD2, RSVD3),
+	PIN(CAM2_MCLK_PS1,        EXTPERIPH3, RSVD1,  RSVD2, RSVD3),
+	PIN(JTAG_RTCK,            JTAG,       RSVD1,  RSVD2, RSVD3),
+	PIN(CLK_32K_IN,           CLK,        RSVD1,  RSVD2, RSVD3),
+	PIN(CLK_32K_OUT_PY5,      SOC,        BLINK,  RSVD2, RSVD3),
+	PIN(BATT_BCL,             BCL,        RSVD1,  RSVD2, RSVD3),
+	PIN(CLK_REQ,              SYS,        RSVD1,  RSVD2, RSVD3),
+	PIN(CPU_PWR_REQ,          CPU,        RSVD1,  RSVD2, RSVD3),
+	PIN(PWR_INT_N,            PMI,        RSVD1,  RSVD2, RSVD3),
+	PIN(SHUTDOWN,             SHUTDOWN,   RSVD1,  RSVD2, RSVD3),
+	PIN(CORE_PWR_REQ,         CORE,       RSVD1,  RSVD2, RSVD3),
+	PIN(AUD_MCLK_PBB0,        AUD,        RSVD1,  RSVD2, RSVD3),
+	PIN(DVFS_PWM_PBB1,        RSVD0,      CLDVFS, SPI3,  RSVD3),
+	PIN(DVFS_CLK_PBB2,        RSVD0,      CLDVFS, SPI3,  RSVD3),
+	PIN(GPIO_X1_AUD_PBB3,     RSVD0,      RSVD1,  SPI3,  RSVD3),
+	PIN(GPIO_X3_AUD_PBB4,     RSVD0,      RSVD1,  SPI3,  RSVD3),
+	PIN(PCC7,                 RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(HDMI_CEC_PCC0,        CEC,        RSVD1,  RSVD2, RSVD3),
+	PIN(HDMI_INT_DP_HPD_PCC1, DP,         RSVD1,  RSVD2, RSVD3),
+	PIN(SPDIF_OUT_PCC2,       SPDIF,      RSVD1,  RSVD2, RSVD3),
+	PIN(SPDIF_IN_PCC3,        SPDIF,      RSVD1,  RSVD2, RSVD3),
+	PIN(USB_VBUS_EN0_PCC4,    USB,        RSVD1,  RSVD2, RSVD3),
+	PIN(USB_VBUS_EN1_PCC5,    USB,        RSVD1,  RSVD2, RSVD3),
+	PIN(DP_HPD0_PCC6,         DP,         RSVD1,  RSVD2, RSVD3),
+	PIN(WIFI_EN_PH0,          RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(WIFI_RST_PH1,         RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(WIFI_WAKE_AP_PH2,     RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(AP_WAKE_BT_PH3,       RSVD0,      UARTB,  SPDIF, RSVD3),
+	PIN(BT_RST_PH4,           RSVD0,      UARTB,  SPDIF, RSVD3),
+	PIN(BT_WAKE_AP_PH5,       RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(AP_WAKE_NFC_PH7,      RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(NFC_EN_PI0,           RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(NFC_INT_PI1,          RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(GPS_EN_PI2,           RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(GPS_RST_PI3,          RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(CAM_RST_PS4,          VGP1,       RSVD1,  RSVD2, RSVD3),
+	PIN(CAM_AF_EN_PS5,        VIMCLK,     VGP2,   RSVD2, RSVD3),
+	PIN(CAM_FLASH_EN_PS6,     VIMCLK,     VGP3,   RSVD2, RSVD3),
+	PIN(CAM1_PWDN_PS7,        VGP4,       RSVD1,  RSVD2, RSVD3),
+	PIN(CAM2_PWDN_PT0,        VGP5,       RSVD1,  RSVD2, RSVD3),
+	PIN(CAM1_STROBE_PT1,      VGP6,       RSVD1,  RSVD2, RSVD3),
+	PIN(LCD_TE_PY2,           DISPLAYA,   RSVD1,  RSVD2, RSVD3),
+	PIN(LCD_BL_PWM_PV0,       DISPLAYA,   PWM0,   SOR0,  RSVD3),
+	PIN(LCD_BL_EN_PV1,        RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(LCD_RST_PV2,          RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(LCD_GPIO1_PV3,        DISPLAYB,   RSVD1,  RSVD2, RSVD3),
+	PIN(LCD_GPIO2_PV4,        DISPLAYB,   PWM1,   RSVD2, SOR1),
+	PIN(AP_READY_PV5,         RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(TOUCH_RST_PV6,        RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(TOUCH_CLK_PV7,        TOUCH,      RSVD1,  RSVD2, RSVD3),
+	PIN(MODEM_WAKE_AP_PX0,    RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(TOUCH_INT_PX1,        RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(MOTION_INT_PX2,       RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(ALS_PROX_INT_PX3,     RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(TEMP_ALERT_PX4,       RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(BUTTON_POWER_ON_PX5,  RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(BUTTON_VOL_UP_PX6,    RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(BUTTON_VOL_DOWN_PX7,  RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(BUTTON_SLIDE_SW_PY0,  RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(BUTTON_HOME_PY1,      RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(PA6,                  SATA,       RSVD1,  RSVD2, RSVD3),
+	PIN(PE6,                  RSVD0,      I2S5A,  PWM2,  RSVD3),
+	PIN(PE7,                  RSVD0,      I2S5A,  PWM3,  RSVD3),
+	PIN(PH6,                  RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(PK0,                  IQC0,       I2S5B,  RSVD2, RSVD3),
+	PIN(PK1,                  IQC0,       I2S5B,  RSVD2, RSVD3),
+	PIN(PK2,                  IQC0,       I2S5B,  RSVD2, RSVD3),
+	PIN(PK3,                  IQC0,       I2S5B,  RSVD2, RSVD3),
+	PIN(PK4,                  IQC1,       RSVD1,  RSVD2, RSVD3),
+	PIN(PK5,                  IQC1,       RSVD1,  RSVD2, RSVD3),
+	PIN(PK6,                  IQC1,       RSVD1,  RSVD2, RSVD3),
+	PIN(PK7,                  IQC1,       RSVD1,  RSVD2, RSVD3),
+	PIN(PL0,                  RSVD0,      RSVD1,  RSVD2, RSVD3),
+	PIN(PL1,                  SOC,        RSVD1,  RSVD2, RSVD3),
+	PIN(PZ0,                  VIMCLK2,    RSVD1,  RSVD2, RSVD3),
+	PIN(PZ1,                  VIMCLK2,    SDMMC1, RSVD2, RSVD3),
+	PIN(PZ2,                  SDMMC3,     CCLA,   RSVD2, RSVD3),
+	PIN(PZ3,                  SDMMC3,     RSVD1,  RSVD2, RSVD3),
+	PIN(PZ4,                  SDMMC1,     RSVD1,  RSVD2, RSVD3),
+	PIN(PZ5,                  SOC,        RSVD1,  RSVD2, RSVD3),
+};
+const struct pmux_pingrp_desc *tegra_soc_pingroups = tegra210_pingroups;
diff --git a/arch/arm/mach-tegra/tegra30/pinmux.c b/drivers/pinctrl/tegra/pinmux-tegra30.c
similarity index 100%
rename from arch/arm/mach-tegra/tegra30/pinmux.c
rename to drivers/pinctrl/tegra/pinmux-tegra30.c
-- 
2.40.1

