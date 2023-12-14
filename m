Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45E1C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 12:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E85878DB;
	Thu, 14 Dec 2023 13:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MFtNDmdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C75187630; Thu, 14 Dec 2023 13:17:03 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BA187980
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e36848f6c6so7560507b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702556216; x=1703161016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UEsp4i3qJzR4uyVVY5DUZ2T+IUOMKzY+vKPxgSyS0cg=;
 b=MFtNDmdAboWwi+imukKlttrUlRlzrCJuN6QsM5k73fjG3XEkWUca3vE/6JUfbbNWSw
 /k8j4BCN1iqALmEKaoXemt5rD+S61QYBbabZFXTuZIdLrbNdZil6kAD25pxI99b0aUTa
 B4vRwBjjCea4K6wtqxyv8BUKVqf/DTB9IR9go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702556216; x=1703161016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UEsp4i3qJzR4uyVVY5DUZ2T+IUOMKzY+vKPxgSyS0cg=;
 b=CAcPNeYMm5a8Dkf/1cZVoC5A7LSeKfdu4LtPRC5tQH1eMDN4HqzZkX4rnuktu9JnrK
 Hr3w8qXwu5uYFiOhAXghp+pim4WoGpe5B4xuYd414blPR0MwBgw3LYhCl4uxNHrffHEL
 fX45d1t+Jlmmol+Mtww8JiHHp++rTZLpLLG+wCKPuifUL1QE+9NIHnJwCbj4FX5YP6oW
 hzQG3Duk/+s+Z7+AuSH5or4Y70Z9OSZ3dazhLx9pgYNtpP6Df2/9RROhldmojIjlTU28
 +WfePO6GKDMQtmvNJMWiCf0lMdeslrYdYw5sqDhy908RHoHopZMHk9HUNdGDPLePJWxL
 osig==
X-Gm-Message-State: AOJu0Yy/bAxzPNBgSNiQUkTg9jmPabi4Jy19l5pp/YV7oxgsAdrzQEGR
 0VOEo7IJfPI7LCebJb1X0ZcNHNvmqFVFHRc7mXc=
X-Google-Smtp-Source: AGHT+IFQuJwaQNhDfrW36modJEM95p3kUyqzyj7VOSMwtlK1Mevvgc+uKqwqdmAhdAPbioS713HsfA==
X-Received: by 2002:a0d:e803:0:b0:5e3:561:3243 with SMTP id
 r3-20020a0de803000000b005e305613243mr2106606ywe.89.1702556216405; 
 Thu, 14 Dec 2023 04:16:56 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 b80-20020a0dd953000000b005e2ca09e751sm1277447ywe.110.2023.12.14.04.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 04:16:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] global: Restrict use of '#include <linux/kconfig.h>'
Date: Thu, 14 Dec 2023 07:16:54 -0500
Message-Id: <20231214121654.3042335-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

In general terms, we -include include/linux/kconfig.h and so normal
U-Boot code does not need to also #include it. However, for code which
is shared with userspace we may need to add it so that either our full
config is available or so that macros such as CONFIG_IS_ENABLED() can be
evaluated. In this case make sure that we guard these includes with a
test for USE_HOSTCC so that it clear as to why we're doing this.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/arch-fsl-layerscape/config.h | 1 -
 arch/arm/mach-rockchip/tpl.c                      | 1 -
 arch/arm/mach-sunxi/dram_sun50i_h6.c              | 1 -
 arch/arm/mach-sunxi/dram_sun50i_h616.c            | 1 -
 arch/arm/mach-sunxi/dram_sunxi_dw.c               | 1 -
 boot/image-fit.c                                  | 2 +-
 boot/image.c                                      | 2 +-
 drivers/timer/dw-apb-timer.c                      | 1 -
 env/embedded.c                                    | 2 ++
 include/bootstage.h                               | 2 ++
 include/configs/at91-sama5_common.h               | 2 --
 include/configs/tqma6.h                           | 1 -
 include/env_internal.h                            | 1 -
 include/u-boot/ecdsa.h                            | 1 -
 lib/rsa/rsa-verify.c                              | 2 +-
 test/dm/scmi.c                                    | 1 -
 tools/mkeficapsule.c                              | 1 -
 17 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-fsl-layerscape/config.h b/arch/arm/include/asm/arch-fsl-layerscape/config.h
index 516c9eab0478..faace43da710 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/config.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/config.h
@@ -7,7 +7,6 @@
 #ifndef _ASM_ARMV8_FSL_LAYERSCAPE_CONFIG_H_
 #define _ASM_ARMV8_FSL_LAYERSCAPE_CONFIG_H_
 
-#include <linux/kconfig.h>
 #include <fsl_ddrc_version.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index fdd0c592b3eb..2c3e9789cc89 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -16,7 +16,6 @@
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <linux/bitops.h>
-#include <linux/kconfig.h>
 
 #if CONFIG_IS_ENABLED(BANNER_PRINT)
 #include <timestamp.h>
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index bff2e42513cc..62bc2a0231e3 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -15,7 +15,6 @@
 #include <asm/arch/prcm.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/kconfig.h>
 
 /*
  * The DRAM controller structure on H6 is similar to the ones on A23/A80:
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index c5c1331a4c3c..e62d5711d0f6 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -22,7 +22,6 @@
 #include <asm/arch/prcm.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/kconfig.h>
 
 enum {
 	MBUS_QOS_LOWEST = 0,
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 9382d3d0be89..daef051d0c8e 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -16,7 +16,6 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 #include <linux/delay.h>
-#include <linux/kconfig.h>
 
 static void mctl_phy_init(u32 val)
 {
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3cc556b727f5..89e377563ce6 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <linux/libfdt.h>
 #include <u-boot/crc.h>
+#include <linux/kconfig.h>
 #else
 #include <linux/compiler.h>
 #include <linux/sizes.h>
@@ -36,7 +37,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
-#include <linux/kconfig.h>
 #include <u-boot/crc.h>
 #include <u-boot/md5.h>
 #include <u-boot/sha1.h>
diff --git a/boot/image.c b/boot/image.c
index 88b67bc3a199..fed5dda2025d 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -42,6 +42,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #else /* USE_HOSTCC */
 #include "mkimage.h"
+#include <linux/kconfig.h>
 #include <u-boot/md5.h>
 #include <time.h>
 
@@ -62,7 +63,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <relocate.h>
 #include <linux/lzo.h>
 #include <linux/zstd.h>
-#include <linux/kconfig.h>
 #include <lzma/LzmaTypes.h>
 #include <lzma/LzmaDec.h>
 #include <lzma/LzmaTools.h>
diff --git a/drivers/timer/dw-apb-timer.c b/drivers/timer/dw-apb-timer.c
index b171232c4844..6cd25251f945 100644
--- a/drivers/timer/dw-apb-timer.c
+++ b/drivers/timer/dw-apb-timer.c
@@ -13,7 +13,6 @@
 #include <reset.h>
 #include <timer.h>
 #include <dm/device_compat.h>
-#include <linux/kconfig.h>
 
 #include <asm/io.h>
 #include <asm/arch/timer.h>
diff --git a/env/embedded.c b/env/embedded.c
index 7cbe54c56e00..5b488ef818e8 100644
--- a/env/embedded.c
+++ b/env/embedded.c
@@ -4,7 +4,9 @@
  * Erik Theisen,  Wave 7 Optics, etheisen@mindspring.com.
  */
 
+#ifdef USE_HOSTCC
 #include <linux/kconfig.h>
+#endif
 
 #ifndef __ASSEMBLY__
 #define	__ASSEMBLY__			/* Dirty trick to get only #defines */
diff --git a/include/bootstage.h b/include/bootstage.h
index 59a76d0f0c40..f4e77b09d747 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -12,7 +12,9 @@
 #define _BOOTSTAGE_H
 
 #include <linux/types.h>
+#ifdef USE_HOSTCC
 #include <linux/kconfig.h>
+#endif
 
 /* Flags for each bootstage record */
 enum bootstage_flags {
diff --git a/include/configs/at91-sama5_common.h b/include/configs/at91-sama5_common.h
index 4aa876a9f79d..81c76ef52a72 100644
--- a/include/configs/at91-sama5_common.h
+++ b/include/configs/at91-sama5_common.h
@@ -9,8 +9,6 @@
 #ifndef __AT91_SAMA5_COMMON_H
 #define __AT91_SAMA5_COMMON_H
 
-#include <linux/kconfig.h>
-
 /* ARM asynchronous clock */
 #define CFG_SYS_AT91_SLOW_CLOCK      32768
 #define CFG_SYS_AT91_MAIN_CLOCK      12000000 /* from 12 MHz crystal */
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 8c75a75a9e59..2da76f154313 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -8,7 +8,6 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#include <linux/kconfig.h>
 #include <linux/stringify.h>
 
 /* place code in last 4 MiB of RAM */
diff --git a/include/env_internal.h b/include/env_internal.h
index 5c289d67f90c..cbd1ef3e9141 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -15,7 +15,6 @@
 #ifndef _ENV_INTERNAL_H_
 #define _ENV_INTERNAL_H_
 
-#include <linux/kconfig.h>
 
 /**************************************************************************
  *
diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index 6e0269e3aed6..53490c6b287f 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -8,7 +8,6 @@
 
 #include <errno.h>
 #include <image.h>
-#include <linux/kconfig.h>
 
 /**
  * crypto_algo API impementation for ECDSA;
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 2f3b34403913..096e7f6d178e 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -17,9 +17,9 @@
 #else
 #include "fdt_host.h"
 #include "mkimage.h"
+#include <linux/kconfig.h>
 #include <fdt_support.h>
 #endif
-#include <linux/kconfig.h>
 #include <u-boot/rsa-mod-exp.h>
 #include <u-boot/rsa.h>
 
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index e80667ef72a3..adf36ffaab1d 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -23,7 +23,6 @@
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
-#include <linux/kconfig.h>
 #include <power/regulator.h>
 #include <test/ut.h>
 
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index b8fc6069b584..6a261ff549dc 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -16,7 +16,6 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <uuid/uuid.h>
-#include <linux/kconfig.h>
 
 #include <gnutls/gnutls.h>
 #include <gnutls/pkcs7.h>
-- 
2.34.1

