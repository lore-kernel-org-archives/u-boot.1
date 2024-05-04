Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0088AC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E50A8858E;
	Sat,  4 May 2024 21:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="X84HDz77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A8A8804B; Sat,  4 May 2024 21:45:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC3E688584
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851886; bh=1T9JKfOkZGEY7oFGtERkf/NlWw8HvSmP3dHbAeDgGgI=;
 b=X84HDz77jmVvOHOq1te44utBWnne6WFoDLPy7w/vUg9/l5uXuYGJJFyOr9WjFVR8rCtCvV/3u
 ivUNLuWehG8ASZGHiMPI8dTTrYHrk6WjzvPzcMt9IUYdcgZ46Q1GbLSctggBQV1cY32ClBfStlJ
 632ASm3FijmwKPPDJlNPU4gWvkU/aT8OlRh6ZXWs3cPF/AgnTI1f1/YZqF6YzGYqOgG0vVfBKP0
 yvQPUVFnCqFCwiKN+7L+XDoeya7bd4dYucE674LfPAnASZHtz3n5iiklz47Y9ragSTkzhePluly
 oZfB1oYdjxJUJnSK4U0rGaqj2Slxx/iMOXVI9ZX+iJiw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>, Frank Wunderlich
 <frank-w@public-files.de>, Joseph Chen <chenjh@rock-chips.com>, Jonas
 Karlman <jonas@kwiboo.se>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Akash Gajjar
 <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 08/16] rockchip: rk356x: Migrate to OF_UPSTREAM
Date: Sat,  4 May 2024 19:43:00 +0000
Message-ID: <20240504194346.2462489-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240504194346.2462489-1-jonas@kwiboo.se>
References: <20240504194346.2462489-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663690292b8e4dad13276de6
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

Migrate RK356x boards that exists in Linux v6.8 to use OF_UPSTREAM.

Following targets is not migrated to use OF_UPSTREAM:
- anbernic-rgxx3-rk3566: Multi device target
- generic-rk3568: Generic target only meant for U-Boot use
- pinetab2-rk3566: Merged in v6.9-rc1

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile                     | 20 --------------------
 arch/arm/mach-rockchip/Kconfig            |  1 +
 configs/anbernic-rgxx3-rk3566_defconfig   |  1 +
 configs/bpi-r2-pro-rk3568_defconfig       |  2 +-
 configs/evb-rk3568_defconfig              |  4 ++--
 configs/generic-rk3568_defconfig          |  1 +
 configs/lubancat-2-rk3568_defconfig       |  2 +-
 configs/nanopi-r5c-rk3568_defconfig       |  2 +-
 configs/nanopi-r5s-rk3568_defconfig       |  2 +-
 configs/odroid-m1-rk3568_defconfig        |  2 +-
 configs/pinetab2-rk3566_defconfig         |  1 +
 configs/quartz64-a-rk3566_defconfig       |  2 +-
 configs/quartz64-b-rk3566_defconfig       |  2 +-
 configs/radxa-cm3-io-rk3566_defconfig     |  2 +-
 configs/radxa-e25-rk3568_defconfig        |  2 +-
 configs/rock-3a-rk3568_defconfig          |  2 +-
 configs/soquartz-blade-rk3566_defconfig   |  2 +-
 configs/soquartz-cm4-rk3566_defconfig     |  2 +-
 configs/soquartz-model-a-rk3566_defconfig |  2 +-
 19 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7a65d98635ae..1dfcc05a14be 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -98,26 +98,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) += \
 	rk3368-geekbox.dtb \
 	rk3368-px5-evb.dtb \
 
-dtb-$(CONFIG_ROCKCHIP_RK3568) += \
-	rk3566-anbernic-rgxx3.dtb \
-	rk3566-pinetab2-v0.1.dtb \
-	rk3566-pinetab2-v2.0.dtb \
-	rk3566-quartz64-a.dtb \
-	rk3566-quartz64-b.dtb \
-	rk3566-radxa-cm3-io.dtb \
-	rk3566-soquartz-blade.dtb \
-	rk3566-soquartz-cm4.dtb \
-	rk3566-soquartz-model-a.dtb \
-	rk3568-bpi-r2-pro.dtb \
-	rk3568-evb.dtb \
-	rk3568-generic.dtb \
-	rk3568-lubancat-2.dtb \
-	rk3568-nanopi-r5c.dtb \
-	rk3568-nanopi-r5s.dtb \
-	rk3568-odroid-m1.dtb \
-	rk3568-radxa-e25.dtb \
-	rk3568-rock-3a.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588s-coolpi-4b.dtb \
 	rk3588-coolpi-cm5-evb.dtb \
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a2c81489452e..03f6bf43fdf4 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -322,6 +322,7 @@ config ROCKCHIP_RK3568
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply OF_UPSTREAM
 	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index fcade9172b71..a03509bf4671 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_MMC=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 # CONFIG_NET is not set
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index a0caa367f9db..eccc15a0ae51 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2-pro"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-bpi-r2-pro"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index e71d6705568f..2076f55122be 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-evb1-v10"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
@@ -14,7 +14,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-evb.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-evb1-v10.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 033702fd149f..66a33afbbaf0 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -37,6 +37,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_NET is not set
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index ea67b6a72864..88593bfa7051 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-lubancat-2"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-lubancat-2"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 00743b7f926c..4a6c320faf5c 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5c"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-nanopi-r5c"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 91e3a19dea6d..7ab12e619acf 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5s"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-nanopi-r5s"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index e749f9af9d23..b5263caff6dc 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x1000
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-odroid-m1"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-odroid-m1"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index ad237edf8d93..e46acf3a3b58 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_LIST="rk3566-pinetab2-v0.1 rk3566-pinetab2-v2.0"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index 535e34fb9903..1ea8e0f40cc4 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-quartz64-a"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-quartz64-a"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index e197defd3af3..f61b2c181a1f 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-quartz64-b"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-quartz64-b"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index d23ab57ada57..48c8fcf5a66b 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-radxa-cm3-io"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-radxa-cm3-io"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index dbb77b85f5d9..496fee0e0a44 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-radxa-e25"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-radxa-e25"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index b06b57fe0bf3..66ac2f6d7aac 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_DEFAULT_DEVICE_TREE="rk3568-rock-3a"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-rock-3a"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 9d565c162ef2..82910daf7cc6 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-blade"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-soquartz-blade"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index fe2c771db71b..5744f1baa81a 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-cm4"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-soquartz-cm4"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index db9eee217514..920df9b622d7 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-model-a"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-soquartz-model-a"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_QUARTZ64_RK3566=y
-- 
2.43.2

