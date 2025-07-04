Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D422C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422198206E;
	Fri,  4 Jul 2025 23:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oxBBD4yO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211F382F00; Fri,  4 Jul 2025 23:45:49 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D989282063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-611e20dd2ffso412441eaf.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665545; x=1752270345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=08NS9+g6Luc9uijoJj86oscsoKN17OAHf+GAe6mYX1A=;
 b=oxBBD4yOuaoNHqv2J+xN4hq6FaBULjXyRZ+yq/jwveoOxlIG3lt5oiLE/wdNVbvtz/
 90CulHF5KpYw5O5RyS3kRipcfhDxOIQFo36axktz3VuUHDGfJ/HOplWCLAPIPtcpeFB7
 Zbsr7242bWbJtN+FAVD6oRlQAM2ZZ/3V5DZ+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665545; x=1752270345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08NS9+g6Luc9uijoJj86oscsoKN17OAHf+GAe6mYX1A=;
 b=dFZF5uZaR5jASsfE/Kat/z5ko420kZnCpcSthCQyUuh76CiOEiDhXnaM7gtco2jyN4
 T1xFLOPFoghHutiAgosCcY/7BwdyC/M6TzkabmUQpp4km1pa7wzfQXBnzf6sO40l2d8t
 QR+I3LKEAZPAqMrgk3Y9ck5+txeEJzU8PgLs3btsPfZViB2w3AKSjFk0AXf21wVrciDU
 S8VgDlWJran1mnV/pLqAmoG+LK/yM3PjIwm1Sk23lC4o82eJQdpD5jei8rL6mugwGjH/
 i4OTPNH0wUd8TAoDPZdytAnUWOORcGw0u1/TrMaWOHdqNuOwTcF6aV4EJTB6nklGLPhi
 oHcg==
X-Gm-Message-State: AOJu0YzmOcgd6/p6MmnvnLrInCbbq/VvB78xUtKt6Ndlc0JTwAkIpEOv
 Nmx64Fn2mlK68tStLI6hbc7YaAkQlItpTRHyFlKnwsOZ1/56A/qL5F9cTx8vHzt8MT1Bru7PrG4
 O0A4orsk=
X-Gm-Gg: ASbGncvoQEzDGCEkPtsFyVJSYsrLy4CRWSVcaprDzhZ2M1uPzYkPBcj2bBWrWS+ibJa
 +jGvzTwy6BwlwYjWkocxZ+yxp65F2IgJrTWCy9ih4S+eGedzA055QPnrui+cpeSHntTsIRgzr40
 UYXvF7vfvo5AmzsneCNH6uKgBxlYLcxiELs2VU+Y5pWpe3ah49x+Q8R1E5AM9lpJMim0J5vbycs
 u3KrhKFTaV/RQ/jLYC3z+7iaB7jxuKgtHEuAEEP40XzEoB1dBjvmSDqzGAKuYXyGCAxSMXFIzbs
 /6Idl7ZHXAGT+t4J+swgrae3mK6TD1GZAUBvDLZkMky4d+Pv5FDKrzqBbEcU8NIhXM6ayDXbo8i
 Pd5bu9kI3FQdKlv9pINCdYOw=
X-Google-Smtp-Source: AGHT+IFlOdWT6PY0nnbdcHqVG6pnpx3jfnVeLh08lu0aUtVefuZNT7C5UWjHgTBv6+YkO0cqYXVcxg==
X-Received: by 2002:a05:6830:8206:b0:727:3664:ca3a with SMTP id
 46e09a7af769-73ca1015d35mr2567357a34.0.1751665545457; 
 Fri, 04 Jul 2025 14:45:45 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f9628d8sm519370a34.60.2025.07.04.14.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:45:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 1/2] toradex: Switch from ARCH_MISC_INIT to MISC_INIT_R in
 some cases
Date: Fri,  4 Jul 2025 15:45:41 -0600
Message-ID: <20250704214542.3418805-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The hook arch_misc_init was not intended to be used for per-board hooks.
This can be done with misc_init_r instead, which is what follows
immediately after arch_misc_init. Switch a few platforms.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis-tk1/apalis-tk1.c   | 2 +-
 board/toradex/apalis_t30/apalis_t30.c   | 2 +-
 board/toradex/colibri_t20/colibri_t20.c | 2 +-
 board/toradex/colibri_t30/colibri_t30.c | 2 +-
 configs/apalis-tk1_defconfig            | 2 +-
 configs/apalis_t30_defconfig            | 2 +-
 configs/colibri_t20_defconfig           | 2 +-
 configs/colibri_t30_defconfig           | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/board/toradex/apalis-tk1/apalis-tk1.c b/board/toradex/apalis-tk1/apalis-tk1.c
index 4557ed1f1f2f..168840764a1d 100644
--- a/board/toradex/apalis-tk1/apalis-tk1.c
+++ b/board/toradex/apalis-tk1/apalis-tk1.c
@@ -36,7 +36,7 @@
 #define VCC_USBO1	TEGRA_GPIO(T, 5)
 #define VCC_USBO1_V1_0	TEGRA_GPIO(N, 4)
 
-int arch_misc_init(void)
+int misc_init_r(void)
 {
 	if (readl(NV_PA_BASE_SRAM + NVBOOTINFOTABLE_BOOTTYPE) ==
 	    NVBOOTTYPE_RECOVERY) {
diff --git a/board/toradex/apalis_t30/apalis_t30.c b/board/toradex/apalis_t30/apalis_t30.c
index 02e8f8eb1fed..2c785da41eaa 100644
--- a/board/toradex/apalis_t30/apalis_t30.c
+++ b/board/toradex/apalis_t30/apalis_t30.c
@@ -35,7 +35,7 @@ DECLARE_GLOBAL_DATA_PTR;
 static int pci_reset_status;
 #endif /* CONFIG_APALIS_T30_PCIE_EVALBOARD_INIT */
 
-int arch_misc_init(void)
+int misc_init_r(void)
 {
 	if (readl(NV_PA_BASE_SRAM + NVBOOTINFOTABLE_BOOTTYPE) ==
 	    NVBOOTTYPE_RECOVERY)
diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibri_t20/colibri_t20.c
index d432fd2b843d..05c3377a60bc 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -29,7 +29,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define PMU_SUPPLYENE_SYSINEN	(1<<5)
 #define PMU_SUPPLYENE_EXITSLREQ	(1<<1)
 
-int arch_misc_init(void)
+int misc_init_r(void)
 {
 	/* Disable PMIC sleep mode on low supply voltage */
 	struct udevice *dev;
diff --git a/board/toradex/colibri_t30/colibri_t30.c b/board/toradex/colibri_t30/colibri_t30.c
index 342673ac506c..1b091ea1694e 100644
--- a/board/toradex/colibri_t30/colibri_t30.c
+++ b/board/toradex/colibri_t30/colibri_t30.c
@@ -18,7 +18,7 @@
 #include "pinmux-config-colibri_t30.h"
 #include "../common/tdx-common.h"
 
-int arch_misc_init(void)
+int misc_init_r(void)
 {
 	if (readl(NV_PA_BASE_SRAM + NVBOOTINFOTABLE_BOOTTYPE) ==
 	    NVBOOTTYPE_RECOVERY)
diff --git a/configs/apalis-tk1_defconfig b/configs/apalis-tk1_defconfig
index de30fa1b961c..846c7bde2343 100644
--- a/configs/apalis-tk1_defconfig
+++ b/configs/apalis-tk1_defconfig
@@ -27,7 +27,7 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_STDIO_DEREGISTER=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_ARCH_MISC_INIT=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/apalis_t30_defconfig b/configs/apalis_t30_defconfig
index e9c9cfe940e4..57e1eb733a87 100644
--- a/configs/apalis_t30_defconfig
+++ b/configs/apalis_t30_defconfig
@@ -22,7 +22,7 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_STDIO_DEREGISTER=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_ARCH_MISC_INIT=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/colibri_t20_defconfig b/configs/colibri_t20_defconfig
index c8a17cd40a2f..02e33ba5e3cb 100644
--- a/configs/colibri_t20_defconfig
+++ b/configs/colibri_t20_defconfig
@@ -20,7 +20,7 @@ CONFIG_SYS_PBSIZE=1055
 CONFIG_SYS_STDIO_DEREGISTER=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_ARCH_MISC_INIT=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/colibri_t30_defconfig b/configs/colibri_t30_defconfig
index 8d7a6bf7060c..63b695c1e54b 100644
--- a/configs/colibri_t30_defconfig
+++ b/configs/colibri_t30_defconfig
@@ -21,7 +21,7 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_STDIO_DEREGISTER=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_ARCH_MISC_INIT=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

