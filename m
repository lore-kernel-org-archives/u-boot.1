Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B83C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E81D88A2F;
	Tue, 30 Apr 2024 15:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bAOxon1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C2C88A22; Tue, 30 Apr 2024 15:36:12 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FFE08858A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b514d3cf4so61354936d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484169; x=1715088969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPnmB2HmIWuzIO6LnX5p/D35OmsO9bm6WriCrr1sCs4=;
 b=bAOxon1SK7Ct4jTP9qlnvsOuCvrmQ6bCaWjpqcfIeKzuVQwvBkaLjYAq8H50Nk44by
 v6ETPJUOFfvXDHrTxPt0/qznJJnYE7eFsaTnRZ7ibfo9vpLCdr8YzcZzLkt9EfcHBzBo
 QfUFiAhywbqgFoFI1+M9U1ptg+vuHc3Cru0nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484169; x=1715088969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPnmB2HmIWuzIO6LnX5p/D35OmsO9bm6WriCrr1sCs4=;
 b=N9ccfSBiGU4QEjygCwkdl/5EpkqsHhqjusHQMLOhIH0WvbkYGuqQaSl+z/eYXw06j5
 DtqzN8fL86KAM/XwwT5NsTmlXAtXV3aL5UK7brds6oj+7q3ZAyPkp6cSq3bsN1Nmc7be
 3UM02f7XBWilS26/Y/Ot4EIbwCYtn8jWuZM3AJwJ/PRBd4/XkNkNzvN+BQTf0AHStm6m
 2X4ivgTANKe819Lc2nJnuQlRjyK2VFaj1Zed+Y8odSZNbb7QnN+ZMuaMxm7sqOi4L4Zk
 oXqmUjb+/ww9wie/BCq5GF2pTPmMy531mZQs54j0SDYzusE34hwOzcOR7dS7u9N0VhTz
 KRFw==
X-Gm-Message-State: AOJu0YzZD8WV1OkA731uxXa3wREoHysB9RS8mSlEFR6KZHNckPTpgmx3
 zpz8HhmotJ6qkygPkHO2b/o8xkdZw96kZ2I8r0XDpBX2EGRtyjZUlb09Tj7nZkNdzYx5amzYNHG
 5BA+neg==
X-Google-Smtp-Source: AGHT+IHBIKF1XBIscG72r6GMhxZp4wLW697ojJ+mUwdLwFMpRPomBOFaORww/rJvMNEHC1+bJLpCEQ==
X-Received: by 2002:ad4:5cc3:0:b0:6a0:d099:c1da with SMTP id
 iu3-20020ad45cc3000000b006a0d099c1damr5756784qvb.31.1714484169231; 
 Tue, 30 Apr 2024 06:36:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 06/33] arm: stm32/stm32mp: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 07:35:32 -0600
Message-Id: <20240430133559.1836389-6-trini@konsulko.com>
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

Remove <common.h> from all mach-stm32 and mach-stm32mp files and when
needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32/soc.c                              | 1 -
 arch/arm/mach-stm32mp/boot_params.c                    | 2 +-
 arch/arm/mach-stm32mp/bsec.c                           | 1 -
 arch/arm/mach-stm32mp/cmd_stm32key.c                   | 1 -
 arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c    | 1 -
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c | 2 +-
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c    | 1 -
 arch/arm/mach-stm32mp/dram_init.c                      | 1 -
 arch/arm/mach-stm32mp/stm32mp1/cpu.c                   | 1 -
 arch/arm/mach-stm32mp/stm32mp1/fdt.c                   | 2 +-
 arch/arm/mach-stm32mp/stm32mp1/psci.c                  | 2 +-
 arch/arm/mach-stm32mp/stm32mp1/pwr_regulator.c         | 2 +-
 arch/arm/mach-stm32mp/stm32mp1/spl.c                   | 2 +-
 arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c            | 2 +-
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c            | 1 -
 arch/arm/mach-stm32mp/syscon.c                         | 1 -
 16 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-stm32/soc.c b/arch/arm/mach-stm32/soc.c
index 0bd8d7b22c4d..737e6809f8d3 100644
--- a/arch/arm/mach-stm32/soc.c
+++ b/arch/arm/mach-stm32/soc.c
@@ -4,7 +4,6 @@
  * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/armv7_mpu.h>
diff --git a/arch/arm/mach-stm32mp/boot_params.c b/arch/arm/mach-stm32mp/boot_params.c
index 158bf40cb97e..ebddf6a7dbcc 100644
--- a/arch/arm/mach-stm32mp/boot_params.c
+++ b/arch/arm/mach-stm32mp/boot_params.c
@@ -5,7 +5,7 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
index 5b869017ec1a..9ba7a6c9a892 100644
--- a/arch/arm/mach-stm32mp/bsec.c
+++ b/arch/arm/mach-stm32mp/bsec.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_MISC
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
index c7fe232f86e0..0cb3c7a9fa44 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32key.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <log.h>
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index adee6e05b636..967fa4e06c0e 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <command.h>
 #include <dfu.h>
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
index 35bed3199422..07c5e0456f82 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_serial.c
@@ -3,12 +3,12 @@
  * Copyright (C) 2020, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <dfu.h>
 #include <malloc.h>
 #include <serial.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/lists.h>
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
index d18455bf36f1..4b1ed50e9fe5 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog_usb.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <dfu.h>
 #include <g_dnl.h>
 #include <usb.h>
diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index fb1208fc5d57..78b12fcbb6ac 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <dm.h>
 #include <image.h>
 #include <init.h>
diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 524778f00c67..478c3efae73e 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <clk.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
diff --git a/arch/arm/mach-stm32mp/stm32mp1/fdt.c b/arch/arm/mach-stm32mp/stm32mp1/fdt.c
index d0b6c3cc5a55..e1e4dc04e01c 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/fdt.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/fdt.c
@@ -5,11 +5,11 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <fdtdec.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <tee.h>
+#include <mach/stm32.h>
 #include <asm/arch/sys_proto.h>
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
index 4f2379df45fb..7772546b2fef 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/armv7.h>
 #include <asm/cache.h>
 #include <asm/gic.h>
@@ -13,6 +12,7 @@
 #include <asm/secure.h>
 #include <hang.h>
 #include <linux/bitops.h>
+#include <linux/errno.h>
 
 /* PWR */
 #define PWR_CR3					0x0c
diff --git a/arch/arm/mach-stm32mp/stm32mp1/pwr_regulator.c b/arch/arm/mach-stm32mp/stm32mp1/pwr_regulator.c
index 846637ab162e..79c44188cc56 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/pwr_regulator.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/pwr_regulator.c
@@ -5,10 +5,10 @@
 
 #define LOG_CATEGORY UCLASS_REGULATOR
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <syscon.h>
+#include <time.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index 6c79259b2c82..7a8fd3178adf 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -5,7 +5,7 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <hang.h>
diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c
index 845d973ad1b2..4a811065fc31 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c
@@ -5,7 +5,7 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <syscon.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index d75ec99d6a17..f096fe538d88 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY LOGC_ARCH
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-stm32mp/syscon.c b/arch/arm/mach-stm32mp/syscon.c
index a2e351d74a7a..8bcbd9793404 100644
--- a/arch/arm/mach-stm32mp/syscon.c
+++ b/arch/arm/mach-stm32mp/syscon.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <syscon.h>
-- 
2.34.1

