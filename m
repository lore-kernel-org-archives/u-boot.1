Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA1C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 08:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F71881E7;
	Thu,  1 Aug 2024 10:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="z+RuaAFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00FD88851E; Thu,  1 Aug 2024 10:37:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64D287FCD
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 10:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722501428;
 bh=xaUW1t7XK2kV3IhziMU6QyRJeFlVq1dJpDzdc2L314U=;
 b=z+RuaAFRsPq8TEZp3FBoapJzDN3RabHnt6vx4WBo7RVXcVzOap8Ilga8CcNHYy32ihe6Sdnp8
 O6bmPHdPS0YuCRFbY8t2p9CHHpuPUJ7QCB0S/XFAj0qB1gGemh9onbz0S7dl3zgkcAsx64fCQOZ
 uhfbpFdHqn+bQSCsS70+iaHH2CVWA/BeSnUAUkJmJKRmaIRhkLCN6vYVmeiqi+1TLZTAevekEkh
 EKdwyA54YaCaN1qWVbPySSww6Wzx8vi7Bu8b8xaWAzTrLH4HZix0QD/Zl0PwOxUu3tB3fpFb4Dv
 2rwEXpKymvyHJy53vPuyqj8Hj3ZceBiRMnluKCpVIquA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom
 Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [RFC] rockchip: rk3399: Migrate to use TPL on bob and kevin
Date: Thu,  1 Aug 2024 08:36:52 +0000
Message-ID: <20240801083656.1936910-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66ab4932c2a4dc9c472c4264
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

All Rockchip aarch64 boards, beside bob and kevin, use TPL to initialize
DRAM and SPL to load FIT with U-Boot proper and TF-A.

Bob and kevin currently does not use TPL and instead initialize DRAM
in SPL and directly after tries to load FIT with U-Boot proper and TF-A.

This RFC try to migrate bob and kevin to also use TPL to uniform TPL/SPL
use for all Rockchip aarch64 boards.

Notes and questions:
- Is u-boot.rom even used for bob/kevin? It use u-boot-img, yet SPL
  expect to load FIT and does not permit use of raw imgage.

  Q: Can we remove what looks to be a faulty u-boot.rom definition and
     just use u-boot-rockchip-spi.bin instead?

- FIT location moved from 0x40000 to 0xE0000 in SPI flash to allow for a
  larger SPL, up to 256 KiB, same as on other RK3399 boards.

  Q: Can we use this location?, or is there something external that
    expects fit or u-boot-img at this location?

Features that is now used:
- Use of Rockchip aarch64 common bss and stack addresses
- Checksum/signature check of FIT images in SPL
- Use of dcache to speed up checksum check in SPL
- SDMA use for eMMC access to speed up read/write in U-Boot proper

Changes that would be good for future:
- Include and use pinctrl in SPL
- Use dm gpio instead of spl_gpio functions in SPL

I do not have any bob or kevin so this has only been compile tested.

This should be broken down into smaller logical patches if this is
accepted and works on real hardware.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-gru-u-boot.dtsi    |  5 +++--
 arch/arm/dts/rk3399-u-boot.dtsi        | 10 +++++++++-
 arch/arm/mach-rockchip/Kconfig         |  1 +
 arch/arm/mach-rockchip/rk3399/Kconfig  | 12 ------------
 arch/arm/mach-rockchip/rk3399/rk3399.c |  2 +-
 configs/chromebook_bob_defconfig       | 20 ++++----------------
 configs/chromebook_kevin_defconfig     | 20 ++++----------------
 7 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index 6bdc892bd913..1d43e07091f4 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -11,7 +11,7 @@
 	};
 
 	config {
-		u-boot,spl-payload-offset = <0x40000>;
+		u-boot,spl-payload-offset = <0xE0000>;
 	};
 };
 
@@ -80,7 +80,8 @@
 
 &spi1 {
 	spi_flash: flash@0 {
-		bootph-all;
+		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 2bec139d8338..cb64c5fc3d4b 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -39,11 +39,19 @@
 
 		mkimage {
 			args = "-n rk3399 -T rkspi";
+			multiple-data-files;
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+			rockchip-tpl {
+			};
+#elif defined(CONFIG_TPL)
+			u-boot-tpl {
+			};
+#endif
 			u-boot-spl {
 			};
 		};
 		u-boot-img {
-			offset = <0x40000>;
+			offset = <0xE0000>;
 		};
 		u-boot {
 			offset = <0x300000>;
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fc1b638ff01d..c0a8bd929dd7 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -289,6 +289,7 @@ config ROCKCHIP_RK3399
 	imply SPL_FIT_SIGNATURE
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
+	imply TPL if !ROCKCHIP_EXTERNAL_TPL
 	imply TPL_CLK
 	imply TPL_DM
 	imply TPL_LIBCOMMON_SUPPORT
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index 04a84e2f6a04..500cfcd87afd 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -146,15 +146,6 @@ config SYS_SOC
 config ROCKCHIP_COMMON_STACK_ADDR
 	default y
 
-config SYS_MALLOC_F_LEN
-	default 0x4000 if !SPL_SHARES_INIT_SP_ADDR
-
-config SPL_LIBCOMMON_SUPPORT
-	default y
-
-config SPL_LIBGENERIC_SUPPORT
-	default y
-
 config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
@@ -164,9 +155,6 @@ config TPL_STACK
 config TPL_TEXT_BASE
         default 0xff8c2000
 
-config SPL_STACK_R_ADDR
-	default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR
-
 if BOOTCOUNT_LIMIT
 
 config BOOTCOUNT_BOOTLIMIT
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 2d7d0f82a2f1..3b6a9c7951a6 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -136,7 +136,7 @@ void board_debug_uart_init(void)
 	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
 	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_SPL_BUILD) && !IS_ENABLED(CONFIG_TPL_BUILD) &&
 	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
 	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
 		rk_setreg(&grf->io_vsel, 1 << 0);
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index b2ecfa6050c8..65854389789a 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -1,35 +1,22 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-bob"
-CONFIG_SPL_TEXT_BASE=0xff8c2000
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
-CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
 # CONFIG_SPL_MMC is not set
-CONFIG_SPL_STACK=0xff8effff
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
 CONFIG_DEBUG_UART_BASE=0xff1a0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
-# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -37,14 +24,14 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x1e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -75,6 +62,7 @@ CONFIG_MMC_PWRSEQ=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_GIGADEVICE=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 0fba5912e0e7..2f3ffb3db46c 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -1,36 +1,23 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-kevin"
-CONFIG_SPL_TEXT_BASE=0xff8c2000
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0
-CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
 # CONFIG_SPL_MMC is not set
 CONFIG_TARGET_CHROMEBOOK_KEVIN=y
-CONFIG_SPL_STACK=0xff8effff
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
 CONFIG_DEBUG_UART_BASE=0xff1a0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
-# CONFIG_SPL_FIT_SIGNATURE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -38,14 +25,14 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x1e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -76,6 +63,7 @@ CONFIG_MMC_PWRSEQ=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPI_FLASH_GIGADEVICE=y
-- 
2.45.2

