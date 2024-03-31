Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A89CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260AA87FEC;
	Sun, 31 Mar 2024 22:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Dv9mbEKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1106687FE8; Sun, 31 Mar 2024 22:30:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4C787FC0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711916986; bh=dLYS4q1J7OdmRux3+8UwJtsbHXt8WSiLwgJRNfZrqCw=;
 b=Dv9mbEKvp4FdlUh8xLtwX0Oe3BhDd1pLkXGkucwGA44W2lPcCFxDgx+xIGlztCRd3R5rjwphv
 HVVGqOMXCWgn3VNOtoLkI8EqwhJGs6LEPn8hGCGG1HVuzdzhsgqsDwphlX+KumrRkMrZAVZQmwj
 MMom+5HX3HmhTi9s8c+sdQM+/TZrs7iBfJMkzqewgcgzP7OBOS/54MkZ2fIhcym2DTRt7rUhvb3
 MCkehDgyO94mor68eQMWaFgD5XXhoJtEJreW/LFY+NJgC2w6SlxznkBG1KFILnKUJ6U+P4G/oDl
 KVBADjkPumxZoEt8ItmT4FQ0y1uBm5De919CEpbVRLkA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, Jagan Teki
 <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 04/31] rockchip: rk3399: Enable ARMv8 crypto and FIT checksum
 validation
Date: Sun, 31 Mar 2024 20:28:10 +0000
Message-ID: <20240331202921.262323-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7b88fc6b45ed44f7292
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

The RK3399 SoC support the ARMv8 Cryptography Extensions, use of ARMv8
crypto can speed up FIT checksum validation in SPL.

Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
extensions for SHA256 when validating checksum of FIT images.

Imply SPL_FIT_SIGNATURE and LEGACY_IMAGE_FORMAT to enable FIT checksum
validation to almost all RK3399 boards.

The following boards have been excluded:
- chromebook_bob: SPL max size limitation of 120 KiB
- chromebook_kevin: SPL max size limitation of 120 KiB
- puma-rk3399: SPL stack in SRAM and TPL+SPL combined max size
               limitation of 224 KiB

Also imply OF_LIVE to help speed up init of U-Boot proper and disable
CONFIG_SPL_RAW_IMAGE_SUPPORT on leez-rk3399 to ensure SPL does not try
to jump to code that failed checksum validation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig     | 5 +++++
 configs/chromebook_bob_defconfig   | 1 +
 configs/chromebook_kevin_defconfig | 1 +
 configs/leez-rk3399_defconfig      | 1 +
 configs/puma-rk3399_defconfig      | 2 +-
 configs/rock-4se-rk3399_defconfig  | 2 --
 configs/rock-pi-4-rk3399_defconfig | 1 -
 configs/rockpro64-rk3399_defconfig | 2 --
 8 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index c0010fbb6887..eb74cd850409 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -260,15 +260,20 @@ config ROCKCHIP_RK3399
 	select DM_PMIC
 	select DM_REGULATOR_FIXED
 	select BOARD_LATE_INIT
+	imply ARMV8_CRYPTO
+	imply ARMV8_SET_SMPEN
 	imply BOOTSTD_FULL
 	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
+	imply LEGACY_IMAGE_FORMAT
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_LIVE
 	imply PARTITION_TYPE_GUID
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
+	imply SPL_FIT_SIGNATURE
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply TPL_CLK
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 58e76f11472c..5d8037d31422 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
+# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 5adc276a746a..54ba2fdd136f 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -24,6 +24,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
+# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index e5088341389a..2831cfb36689 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-leez-p710.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index c2759e1a9520..fe7aac791271 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
+# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
@@ -52,7 +53,6 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 712502517eb2..04622df3c0a0 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -15,8 +15,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 315b8b853fc3..9036c51de421 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -19,7 +19,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index d66b4a9d8900..062477286708 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -17,8 +17,6 @@ CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_USE_PREBOOT=y
-- 
2.43.2

