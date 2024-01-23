Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4A5C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3D187D36;
	Tue, 23 Jan 2024 15:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DE587D93; Tue, 23 Jan 2024 15:50:24 +0100 (CET)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [45.157.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B0087DAE
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK94025HyzMrcS7;
 Tue, 23 Jan 2024 15:50:08 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TK93z0hfTzX3V; Tue, 23 Jan 2024 15:50:07 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 15/18] rockchip: migrate hardware.h inclusion into appropriate
 files
Date: Tue, 23 Jan 2024 15:49:23 +0100
Message-ID: <20240123-jaguar-v1-15-1eec1c34953c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Nothing of the hardware.h is used in include/configs, therefore, let's
move that include to the files that actually require this include.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/rk3066/rk3066.c | 1 +
 drivers/ram/rockchip/dmc-rk3368.c      | 1 +
 drivers/ram/rockchip/sdram_rk3188.c    | 1 +
 drivers/ram/rockchip/sdram_rk3288.c    | 1 +
 include/configs/rk3036_common.h        | 1 -
 include/configs/rk3066_common.h        | 1 -
 include/configs/rk3188_common.h        | 1 -
 include/configs/rk322x_common.h        | 1 -
 include/configs/rk3288_common.h        | 1 -
 include/configs/rk3368_common.h        | 1 -
 include/configs/rv1108_common.h        | 1 -
 11 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3066/rk3066.c b/arch/arm/mach-rockchip/rk3066/rk3066.c
index 78c7d894f90..6661b788295 100644
--- a/arch/arm/mach-rockchip/rk3066/rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/rk3066.c
@@ -7,6 +7,7 @@
 #include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3066.h>
+#include <asm/arch-rockchip/hardware.h>
 
 #define GRF_BASE	0x20008000
 
diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
index f36be941a38..74d8aed571c 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -20,6 +20,7 @@
 #include <asm/arch-rockchip/ddr_rk3368.h>
 #include <asm/arch-rockchip/sdram.h>
 #include <asm/arch-rockchip/sdram_rk3288.h>
+#include <asm/arch-rockchip/hardware.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
index ad9f936df55..16a68885f1f 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -25,6 +25,7 @@
 #include <asm/arch-rockchip/pmu_rk3188.h>
 #include <asm/arch-rockchip/sdram.h>
 #include <asm/arch-rockchip/sdram_rk3288.h>
+#include <asm/arch-rockchip/hardware.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index c99118fd612..ec6bdcb2015 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -25,6 +25,7 @@
 #include <asm/arch-rockchip/pmu_rk3288.h>
 #include <asm/arch-rockchip/sdram.h>
 #include <asm/arch-rockchip/sdram_rk3288.h>
+#include <asm/arch-rockchip/hardware.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <power/regulator.h>
diff --git a/include/configs/rk3036_common.h b/include/configs/rk3036_common.h
index c2abd14e114..0bf9e8b9a2e 100644
--- a/include/configs/rk3036_common.h
+++ b/include/configs/rk3036_common.h
@@ -5,7 +5,6 @@
 #ifndef __CONFIG_RK3036_COMMON_H
 #define __CONFIG_RK3036_COMMON_H
 
-#include <asm/arch-rockchip/hardware.h>
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
diff --git a/include/configs/rk3066_common.h b/include/configs/rk3066_common.h
index d70c8f77d48..6a3b6900463 100644
--- a/include/configs/rk3066_common.h
+++ b/include/configs/rk3066_common.h
@@ -6,7 +6,6 @@
 #ifndef __CONFIG_RK3066_COMMON_H
 #define __CONFIG_RK3066_COMMON_H
 
-#include <asm/arch-rockchip/hardware.h>
 #include "rockchip-common.h"
 
 #define CFG_IRAM_BASE		0x10080000
diff --git a/include/configs/rk3188_common.h b/include/configs/rk3188_common.h
index a8cee1e44d4..98f2c25f3cf 100644
--- a/include/configs/rk3188_common.h
+++ b/include/configs/rk3188_common.h
@@ -6,7 +6,6 @@
 #ifndef __CONFIG_RK3188_COMMON_H
 #define __CONFIG_RK3188_COMMON_H
 
-#include <asm/arch-rockchip/hardware.h>
 #include "rockchip-common.h"
 
 #define CFG_IRAM_BASE	0x10080000
diff --git a/include/configs/rk322x_common.h b/include/configs/rk322x_common.h
index 15f77df3e17..bab4ca015f7 100644
--- a/include/configs/rk322x_common.h
+++ b/include/configs/rk322x_common.h
@@ -5,7 +5,6 @@
 #ifndef __CONFIG_RK322X_COMMON_H
 #define __CONFIG_RK322X_COMMON_H
 
-#include <asm/arch-rockchip/hardware.h>
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
index 3063076a97a..0c449e31099 100644
--- a/include/configs/rk3288_common.h
+++ b/include/configs/rk3288_common.h
@@ -6,7 +6,6 @@
 #ifndef __CONFIG_RK3288_COMMON_H
 #define __CONFIG_RK3288_COMMON_H
 
-#include <asm/arch-rockchip/hardware.h>
 #include "rockchip-common.h"
 
 #define CFG_SYS_HZ_CLOCK		24000000
diff --git a/include/configs/rk3368_common.h b/include/configs/rk3368_common.h
index ccb5369b901..d488f8d477a 100644
--- a/include/configs/rk3368_common.h
+++ b/include/configs/rk3368_common.h
@@ -8,7 +8,6 @@
 
 #include "rockchip-common.h"
 
-#include <asm/arch-rockchip/hardware.h>
 #include <linux/sizes.h>
 
 #define CFG_SYS_SDRAM_BASE		0
diff --git a/include/configs/rv1108_common.h b/include/configs/rv1108_common.h
index 3bf70a0e0ae..ff28236a21d 100644
--- a/include/configs/rv1108_common.h
+++ b/include/configs/rv1108_common.h
@@ -5,7 +5,6 @@
 #ifndef __CONFIG_RV1108_COMMON_H
 #define __CONFIG_RV1108_COMMON_H
 
-#include <asm/arch-rockchip/hardware.h>
 #include "rockchip-common.h"
 
 #define CFG_IRAM_BASE		0x10080000

-- 
2.43.0

