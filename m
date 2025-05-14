Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A116C3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 22:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC52782B12;
	Thu, 15 May 2025 00:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qpWhLiqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8902682B12; Thu, 15 May 2025 00:50:13 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F0882AE1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 00:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3f6dccdcadaso337766b6e.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747263009; x=1747867809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCO5JDQkbbgJV5IDlSvSYs5KHZkZdWD7XHtfzxez8v8=;
 b=qpWhLiqQa+tV0a5O0G/BVSFJQ7EmHPeEdiiOUgc4WiJ3VFc6jxT/NhS81cM51z3QQy
 aFZbWU+uWM/iN2RUOJ4h6w8LwXDOn5CN5+jHPEkyp5dhXFGi2JmeX3fnXX2676Vzl6vE
 RaGoAmNzAleVClwK9D2lrVdx0AbM0YgTMGNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747263009; x=1747867809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCO5JDQkbbgJV5IDlSvSYs5KHZkZdWD7XHtfzxez8v8=;
 b=hgXZ8b7ZbHml/jQZKRxOUWSTSU+W5LypAgiuw901xcOYIUDG4axWOSAT2nN0yFunop
 gfY6Rw0kjsfpGUJ4VcMXULI8Uwqyn/mWXD1cNWZQKStpoKCVGYD5vZ/ojaiRbP3pVHTf
 AHgb4fxx9ZvpLnJLLZ3rMfueTKROgiALic7womPe4KpB4EIe246oQJHQhwryfQThMS5T
 rTGsdG1DPfTbqua0bCwERbhApf/RDK1So7v/n9kMTgFCNsTt6mejtMxGRDeHUQWiehXZ
 erdTzCtrX3vUhopZpNXbxjdHCHSAN3HL2Quhh99K2S/b6aN/hAWETc35m3CrH1ryyIlQ
 7AaQ==
X-Gm-Message-State: AOJu0YxL7B/bJIM4kqXesZucPsHUAGa9OKi1QIYGB3t7IifGHzqX3qa4
 tGVJKjhd2wE5lhg/AUjrMP2QpBMX7wjn0EgaacoGWSGO4eBc9Z+wr2Gzi/+zddR65xsvNK4zv0A
 L
X-Gm-Gg: ASbGncutxufG/SmE/fPoXgU+smP566tqcQFy0RMVcPmRY1DjusYfNwJdtPs/SrcELTZ
 i7rsH9+GxkgRI+EHykHYivHfT3+3NSdwpPM18iUkgYhljGRslZVB0x15/HL9IqnHg6yKO4daO+E
 +uMCocogmuv08q6j8oWXYWvle8SpDaWVOhAfBCMaBmsNawlFWWcw173QhhaKse4Z4Vh0Y7nEdF9
 cRtV8uuQGhHPH0E1/KRaX5yPNdb5Vx2T0et0X7teIFEPmTADNEw42eVl+nVolUHDD+/GbB43lqV
 JfqefYq0r3GLA2liStC9/3zpxsnjMehyxRGevAMRw2Pc2ahGiOlT7a+mjVadwCt3AL4V3Y/Wj1m
 xwugfOsOVcr6JeHk=
X-Google-Smtp-Source: AGHT+IGw+GIzNXaThVU7o9+1p8e0Zbrc9DDkVhIfNFznLZTW7H9/RFbKjGZS5LRqy916XxJKXMRZUA==
X-Received: by 2002:a05:6808:2119:b0:3f6:ab22:4d37 with SMTP id
 5614622812f47-404c20db8c5mr3156747b6e.32.1747263009284; 
 Wed, 14 May 2025 15:50:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52271sm2636530eaf.21.2025.05.14.15.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 15:50:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 1/5] global: Add <linux/string.h> instead of long indirect
 include path
Date: Wed, 14 May 2025 16:46:00 -0600
Message-ID: <20250514225002.15361-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
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

In a number of cases we have C files which rely on a chain of indirect
include paths to get <linux/string.h> to be included via <command.h>. To
facilitate cleaning up <command.h> make this code directly include
<linux/string.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Andrew Davis <afd@ti.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Dai Okamura <okamura.dai@socionext.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: William Zhang <william.zhang@broadcom.com>
---
 arch/arm/mach-imx/mx5/clock.c             | 1 +
 arch/arm/mach-keystone/cmd_clock.c        | 1 +
 arch/arm/mach-tegra/tegra124/bct.c        | 1 +
 arch/arm/mach-tegra/tegra20/bct.c         | 1 +
 arch/arm/mach-tegra/tegra30/bct.c         | 1 +
 arch/arm/mach-uniphier/dram/cmd_ddrmphy.c | 1 +
 arch/arm/mach-uniphier/dram/cmd_ddrphy.c  | 1 +
 board/freescale/common/qixis.c            | 1 +
 board/freescale/ls1043ardb/cpld.c         | 1 +
 board/freescale/ls1046ardb/cpld.c         | 1 +
 board/freescale/p2041rdb/cpld.c           | 1 +
 board/freescale/t102xrdb/cpld.c           | 1 +
 board/freescale/t104xrdb/cpld.c           | 1 +
 board/freescale/t208xrdb/cpld.c           | 1 +
 board/freescale/t4rdb/cpld.c              | 1 +
 board/toradex/apalis_imx6/do_fuse.c       | 1 +
 board/toradex/colibri_imx6/do_fuse.c      | 1 +
 boot/image-pre-load.c                     | 1 +
 cmd/2048.c                                | 1 +
 cmd/armflash.c                            | 1 +
 cmd/bootstage.c                           | 1 +
 cmd/cache.c                               | 1 +
 cmd/diag.c                                | 1 +
 cmd/dm.c                                  | 1 +
 cmd/echo.c                                | 1 +
 cmd/flash.c                               | 1 +
 cmd/fuse.c                                | 1 +
 cmd/irq.c                                 | 1 +
 cmd/legacy_led.c                          | 1 +
 cmd/mp.c                                  | 1 +
 cmd/optee.c                               | 1 +
 cmd/sha1sum.c                             | 1 +
 cmd/sleep.c                               | 1 +
 cmd/smccc.c                               | 1 +
 cmd/stackprot_test.c                      | 1 +
 cmd/strings.c                             | 1 +
 cmd/test.c                                | 1 +
 cmd/timer.c                               | 1 +
 cmd/ufs.c                                 | 1 +
 cmd/x86/mtrr.c                            | 1 +
 drivers/tpm/sandbox_common.c              | 1 +
 41 files changed, 41 insertions(+)

diff --git a/arch/arm/mach-imx/mx5/clock.c b/arch/arm/mach-imx/mx5/clock.c
index 41116e2c6a2c..9901f8a7b56f 100644
--- a/arch/arm/mach-imx/mx5/clock.c
+++ b/arch/arm/mach-imx/mx5/clock.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <asm/io.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-keystone/cmd_clock.c b/arch/arm/mach-keystone/cmd_clock.c
index e9ecc05953a8..7b94a80b725e 100644
--- a/arch/arm/mach-keystone/cmd_clock.c
+++ b/arch/arm/mach-keystone/cmd_clock.c
@@ -8,6 +8,7 @@
 
 #include <vsprintf.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/psc_defs.h>
diff --git a/arch/arm/mach-tegra/tegra124/bct.c b/arch/arm/mach-tegra/tegra124/bct.c
index a71aa87fce12..4dc4b7138ab8 100644
--- a/arch/arm/mach-tegra/tegra124/bct.c
+++ b/arch/arm/mach-tegra/tegra124/bct.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <log.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/arch-tegra/crypto.h>
 #include "bct.h"
 #include "uboot_aes.h"
diff --git a/arch/arm/mach-tegra/tegra20/bct.c b/arch/arm/mach-tegra/tegra20/bct.c
index b647b6b26d2a..253cb2436761 100644
--- a/arch/arm/mach-tegra/tegra20/bct.c
+++ b/arch/arm/mach-tegra/tegra20/bct.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <log.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/arch-tegra/crypto.h>
 #include "bct.h"
 #include "uboot_aes.h"
diff --git a/arch/arm/mach-tegra/tegra30/bct.c b/arch/arm/mach-tegra/tegra30/bct.c
index 250009ea8d8e..398ba1de3869 100644
--- a/arch/arm/mach-tegra/tegra30/bct.c
+++ b/arch/arm/mach-tegra/tegra30/bct.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <log.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/arch-tegra/crypto.h>
 #include "bct.h"
 #include "uboot_aes.h"
diff --git a/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c b/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c
index 629f8b90c9d8..be4ce3265bb8 100644
--- a/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c
+++ b/arch/arm/mach-uniphier/dram/cmd_ddrmphy.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "../soc-info.h"
 #include "ddrmphy-regs.h"
diff --git a/arch/arm/mach-uniphier/dram/cmd_ddrphy.c b/arch/arm/mach-uniphier/dram/cmd_ddrphy.c
index ca519d1c7e0c..3ccafe206382 100644
--- a/arch/arm/mach-uniphier/dram/cmd_ddrphy.c
+++ b/arch/arm/mach-uniphier/dram/cmd_ddrphy.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
+#include <linux/string.h>
 
 #include "../soc-info.h"
 #include "ddrphy-regs.h"
diff --git a/board/freescale/common/qixis.c b/board/freescale/common/qixis.c
index 7815ba2dbce9..04cad48f033a 100644
--- a/board/freescale/common/qixis.c
+++ b/board/freescale/common/qixis.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <linux/time.h>
+#include <linux/string.h>
 #include <i2c.h>
 #include "qixis.h"
 
diff --git a/board/freescale/ls1043ardb/cpld.c b/board/freescale/ls1043ardb/cpld.c
index bda2f3ac3a69..39b6c6449cf7 100644
--- a/board/freescale/ls1043ardb/cpld.c
+++ b/board/freescale/ls1043ardb/cpld.c
@@ -7,6 +7,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include "cpld.h"
 
diff --git a/board/freescale/ls1046ardb/cpld.c b/board/freescale/ls1046ardb/cpld.c
index 7f8ca2e857fd..26a5962bd6ee 100644
--- a/board/freescale/ls1046ardb/cpld.c
+++ b/board/freescale/ls1046ardb/cpld.c
@@ -7,6 +7,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include "cpld.h"
 
diff --git a/board/freescale/p2041rdb/cpld.c b/board/freescale/p2041rdb/cpld.c
index 915a8b994d5c..2bba377d4d45 100644
--- a/board/freescale/p2041rdb/cpld.c
+++ b/board/freescale/p2041rdb/cpld.c
@@ -12,6 +12,7 @@
  */
 
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 
 #include "cpld.h"
diff --git a/board/freescale/t102xrdb/cpld.c b/board/freescale/t102xrdb/cpld.c
index cc933ccd5440..00ea9d8f5038 100644
--- a/board/freescale/t102xrdb/cpld.c
+++ b/board/freescale/t102xrdb/cpld.c
@@ -9,6 +9,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include "cpld.h"
 
diff --git a/board/freescale/t104xrdb/cpld.c b/board/freescale/t104xrdb/cpld.c
index c2d526ae15ac..038e40e2faef 100644
--- a/board/freescale/t104xrdb/cpld.c
+++ b/board/freescale/t104xrdb/cpld.c
@@ -12,6 +12,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 
 #include "cpld.h"
diff --git a/board/freescale/t208xrdb/cpld.c b/board/freescale/t208xrdb/cpld.c
index d2226af62786..838d88d977e5 100644
--- a/board/freescale/t208xrdb/cpld.c
+++ b/board/freescale/t208xrdb/cpld.c
@@ -7,6 +7,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include "cpld.h"
 
diff --git a/board/freescale/t4rdb/cpld.c b/board/freescale/t4rdb/cpld.c
index f076350c1c55..258581eee960 100644
--- a/board/freescale/t4rdb/cpld.c
+++ b/board/freescale/t4rdb/cpld.c
@@ -16,6 +16,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <linux/string.h>
 #include <asm/io.h>
 
 #include "cpld.h"
diff --git a/board/toradex/apalis_imx6/do_fuse.c b/board/toradex/apalis_imx6/do_fuse.c
index 698b05bc5ad5..8721276bed83 100644
--- a/board/toradex/apalis_imx6/do_fuse.c
+++ b/board/toradex/apalis_imx6/do_fuse.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
+#include <linux/string.h>
 
 static int mfgr_fuse(void)
 {
diff --git a/board/toradex/colibri_imx6/do_fuse.c b/board/toradex/colibri_imx6/do_fuse.c
index 698b05bc5ad5..8721276bed83 100644
--- a/board/toradex/colibri_imx6/do_fuse.c
+++ b/board/toradex/colibri_imx6/do_fuse.c
@@ -11,6 +11,7 @@
 #include <command.h>
 #include <console.h>
 #include <fuse.h>
+#include <linux/string.h>
 
 static int mfgr_fuse(void)
 {
diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index adf3b341a203..2f851ebb28c2 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -7,6 +7,7 @@
 #include "mkimage.h"
 #else
 #include <asm/global_data.h>
+#include <env.h>
 #include <mapmem.h>
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
diff --git a/cmd/2048.c b/cmd/2048.c
index 42cd171b0e41..aa0f82721dc1 100644
--- a/cmd/2048.c
+++ b/cmd/2048.c
@@ -8,6 +8,7 @@
 #include <rand.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define SIZE 4
 static uint score;
diff --git a/cmd/armflash.c b/cmd/armflash.c
index e292cf85c45d..83f616db4efb 100644
--- a/cmd/armflash.c
+++ b/cmd/armflash.c
@@ -9,6 +9,7 @@
 #include <console.h>
 #include <flash.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/io.h>
 
 #define MAX_REGIONS 4
diff --git a/cmd/bootstage.c b/cmd/bootstage.c
index 8248c41ca826..5c6d5a3ab453 100644
--- a/cmd/bootstage.c
+++ b/cmd/bootstage.c
@@ -6,6 +6,7 @@
 #include <bootstage.h>
 #include <command.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 static int do_bootstage_report(struct cmd_tbl *cmdtp, int flag, int argc,
 			       char *const argv[])
diff --git a/cmd/cache.c b/cmd/cache.c
index 3049f5c305f2..b7007877ab03 100644
--- a/cmd/cache.c
+++ b/cmd/cache.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <linux/compiler.h>
+#include <linux/string.h>
 
 static int parse_argv(const char *);
 
diff --git a/cmd/diag.c b/cmd/diag.c
index c6da5aae3fcd..4a88ab00a074 100644
--- a/cmd/diag.c
+++ b/cmd/diag.c
@@ -9,6 +9,7 @@
  */
 #include <command.h>
 #include <post.h>
+#include <linux/string.h>
 
 int do_diag(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/dm.c b/cmd/dm.c
index ec9cfd85376e..1f212c0f0309 100644
--- a/cmd/dm.c
+++ b/cmd/dm.c
@@ -9,6 +9,7 @@
 #include <command.h>
 #include <dm/root.h>
 #include <dm/util.h>
+#include <linux/string.h>
 
 static int do_dm_dump_driver_compat(struct cmd_tbl *cmdtp, int flag, int argc,
 				    char * const argv[])
diff --git a/cmd/echo.c b/cmd/echo.c
index 973213a03a66..d1346504cfb5 100644
--- a/cmd/echo.c
+++ b/cmd/echo.c
@@ -5,6 +5,7 @@
  */
 
 #include <command.h>
+#include <linux/string.h>
 
 static int do_echo(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
diff --git a/cmd/flash.c b/cmd/flash.c
index fd660ec477c9..76aa387ba596 100644
--- a/cmd/flash.c
+++ b/cmd/flash.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <log.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <u-boot/uuid.h>
 
 #if defined(CONFIG_CMD_MTDPARTS)
diff --git a/cmd/fuse.c b/cmd/fuse.c
index 6c42c0968093..e2206cdf0d54 100644
--- a/cmd/fuse.c
+++ b/cmd/fuse.c
@@ -14,6 +14,7 @@
 #include <mapmem.h>
 #include <vsprintf.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 
 static int confirm_prog(void)
 {
diff --git a/cmd/irq.c b/cmd/irq.c
index da223b4b2cce..58483d04de82 100644
--- a/cmd/irq.c
+++ b/cmd/irq.c
@@ -6,6 +6,7 @@
 #include <config.h>
 #include <command.h>
 #include <irq_func.h>
+#include <linux/string.h>
 
 static int do_interrupts(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 50de7e89d8f4..db312ae6e2dd 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <status_led.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 struct led_tbl_s {
 	char		*string;	/* String for use in the command */
diff --git a/cmd/mp.c b/cmd/mp.c
index 261bb8a07d43..686e1f8a82fc 100644
--- a/cmd/mp.c
+++ b/cmd/mp.c
@@ -6,6 +6,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 static int cpu_status_all(void)
 {
diff --git a/cmd/optee.c b/cmd/optee.c
index e3aae5e9f9bf..155c9f1bb732 100644
--- a/cmd/optee.c
+++ b/cmd/optee.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <tee.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 #define TA_HELLO_WORLD_CMD_INC_VALUE 0
 /* This needs to match the UUID of the Hello World TA. */
diff --git a/cmd/sha1sum.c b/cmd/sha1sum.c
index 52aa26c78d2f..f2757146bbaf 100644
--- a/cmd/sha1sum.c
+++ b/cmd/sha1sum.c
@@ -9,6 +9,7 @@
 
 #include <command.h>
 #include <hash.h>
+#include <linux/string.h>
 #include <u-boot/sha1.h>
 
 int do_sha1sum(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/cmd/sleep.c b/cmd/sleep.c
index 7616fed75566..a8c896e0c5ee 100644
--- a/cmd/sleep.c
+++ b/cmd/sleep.c
@@ -9,6 +9,7 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static int do_sleep(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/smccc.c b/cmd/smccc.c
index 3a4d885e37e1..fa04bb05ca42 100644
--- a/cmd/smccc.c
+++ b/cmd/smccc.c
@@ -9,6 +9,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/compiler.h>
 #include <linux/psci.h>
+#include <linux/string.h>
 
 static int do_call(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
diff --git a/cmd/stackprot_test.c b/cmd/stackprot_test.c
index e7ff4a061589..78e9beba5bf3 100644
--- a/cmd/stackprot_test.c
+++ b/cmd/stackprot_test.c
@@ -4,6 +4,7 @@
  */
 
 #include <command.h>
+#include <linux/string.h>
 
 static int do_test_stackprot_fail(struct cmd_tbl *cmdtp, int flag, int argc,
 				  char *const argv[])
diff --git a/cmd/strings.c b/cmd/strings.c
index 5bcb0f2b567c..beac2a6e6b3a 100644
--- a/cmd/strings.c
+++ b/cmd/strings.c
@@ -9,6 +9,7 @@
 #include <config.h>
 #include <command.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 static char *start_addr, *last_addr;
 
diff --git a/cmd/test.c b/cmd/test.c
index b4c3eabf9f60..4774d2964874 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -8,6 +8,7 @@
 #include <fs.h>
 #include <log.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 #define OP_INVALID	0
 #define OP_NOT		1
diff --git a/cmd/timer.c b/cmd/timer.c
index 04fcd84ac6a6..427309e108df 100644
--- a/cmd/timer.c
+++ b/cmd/timer.c
@@ -6,6 +6,7 @@
 
 #include <command.h>
 #include <time.h>
+#include <linux/string.h>
 
 static int do_timer(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
diff --git a/cmd/ufs.c b/cmd/ufs.c
index 6e21fbb1685c..790dab50f183 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <ufs.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 
 static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index 289865515ef5..91130453039d 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -6,6 +6,7 @@
 #include <command.h>
 #include <log.h>
 #include <vsprintf.h>
+#include <linux/string.h>
 #include <asm/msr.h>
 #include <asm/mp.h>
 #include <asm/mtrr.h>
diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
index 596e01563899..9d386fc32e5a 100644
--- a/drivers/tpm/sandbox_common.c
+++ b/drivers/tpm/sandbox_common.c
@@ -9,6 +9,7 @@
 
 #include <tpm-v1.h>
 #include <tpm-v2.h>
+#include <linux/string.h>
 #include <asm/unaligned.h>
 #include "sandbox_common.h"
 
-- 
2.43.0

