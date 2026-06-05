Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ACDCD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFAE849BD;
	Fri,  5 Jun 2026 21:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oPQZsQhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C17849CA; Fri,  5 Jun 2026 21:05:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FB2848A1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68cebdc1723so322768a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780686303; x=1781291103; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcyBy01huvdvfw48Zt+EmCWidR4l+2+2ECQixfbXyMc=;
 b=oPQZsQhXLoLrVxk1Vyc/KPR7fzzbv8NbWUaNkx/ah6YXvVcQHmioLS6AgUFBxHy8oI
 mM0GtjjdLQOWdtLoDqSzOXb5z9QKxd7MWMOKVB7ZgKUJaC4ELjt3BHHmVnj2ZmvGwfdO
 eSo+DfJib+yi5eDBSfzkYJxaZEN3UrVCJicoWahd9ocUuenmtcV240FF6Li7Mp+pQTBI
 s9YGOb+AZ3zN9BvfqNdhQdHAi0DGJEZEJQipjRYwowN7QfLnxWHqVTcw6Hf/Q4mkObfA
 VOs/EOou7Ftp922JbmWhi651lOUQlNKvrchnkM9gXysvYnRESIkBIj5Gcifat/f3dVdc
 tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780686303; x=1781291103;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zcyBy01huvdvfw48Zt+EmCWidR4l+2+2ECQixfbXyMc=;
 b=BDi3j5NRiY8vTYPaAqY36ZFpxkXALSiY8vggJWnhUwMwhav7r/yWGU/COAt2X53KSh
 4DNzsTVPR2q4+5LdVRMDrlzwprpJQwaecQrDCBqiw1JLqSqtlPl6KvfwNfRF33gn4mqw
 GrBM1hEs3Lz3FvnKyfk67/JtyS5sQlvCsgrHygRgpuvjzic8nPwRMt763YJAU4ds5gpJ
 v7pwsuSetPiAxn81iCJoHG+ZTTifj8OJ8yewj9dQWtlpdqQvQyXVr7DUJvJrAP8RDozd
 yPWtYPhceBhz0A3AR6fo4HCaS8YdHGtX7xnWDmaH1H/iv0iD6SeMQZ5F+tmUg2OeTprz
 yz2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qkQbuIDkRQQc1aHBCAHpBqgUt8zlvs/O4bJ514CvN2R2TW7WjXEF6De/p3TRfq6tGf4yvleI=@lists.denx.de
X-Gm-Message-State: AOJu0YySvKPYVoB0AoBdRe8107C681Opwops1fD38LRj/3tXZqPeB9pV
 cYEpz1pD/F9Kev09QafTSZuxfAyNICK/kgjg+uBTIpjOkpTjo+m7qLSH
X-Gm-Gg: Acq92OGURoPVoP5C4pLLU9c5JWhibWHB2QRU2gG0ubd2vyIouMFEuU7GcPXsXbUcXmn
 Ocxkopk4KX7Th+/7SfISrVj+NJXl2aMdFHPw27sGw+vP2ZERZHli3/GaC9MwsY2LDukoK/ipZdB
 PfmG0Q6GV9SFdWO3bX4TVefGpokdAtZQ9h2e/dwNMJkCIZVvQvtoRmEbRtlSryqvpZMgD+T+2Y8
 pu4anhLwWWoGJFjZcAUDSNA2coW4bxf47hjQupINDgvRZhlSQV9dzz4EHKH8had0+V4nsKBav+r
 NoOWhkmMjff0OW9orVp0wQ5tCU4plEL7LxqmjG+EU8ffxLg7ilhm87TfYkorDxewESaHusF+ZqJ
 9xil5qD4xHb9Jf/EZMo7FLCwKX53CdqBOU2iUHDxACNaOf9AII5WyKFUvIetYGBOcwyoBlJL0fg
 iDlIKiBHMt1eYIeD6YBk1EGaw9W8f5JRXN6NW84FNXb+GDISAeIVV2bOGyhpzag+g/4nRx+puKY
 7H2rrSJWAw=
X-Received: by 2002:a05:6402:5243:b0:689:ac19:3fb4 with SMTP id
 4fb4d7f45d1cf-68fa4c16bf6mr1370615a12.1.1780686301736; 
 Fri, 05 Jun 2026 12:05:01 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051e9aa33sm502235966b.24.2026.06.05.12.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 12:05:01 -0700 (PDT)
Message-ID: <89147ab9-5167-4be0-818f-30e2b39021ec@gmail.com>
Date: Fri, 5 Jun 2026 21:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] Kconfig: replace deprecated help word
To: trini@konsulko.com
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 andre.przywara@arm.com, daniel.schwierzeck@gmail.com, hs@nabladev.com,
 jerome.forissier@arm.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 mateusz.kulikowski@gmail.com, marex@denx.de, ag.dev.uboot@gmail.com,
 u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Replace deprecated help word.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

find . -name 'Kconfig' -exec sed -i -e 's/---help---/help/g' {} \;
---
 arch/arm/cpu/armv7/Kconfig      |   8 +-
 arch/arm/mach-rockchip/Kconfig  |   2 +-
 arch/arm/mach-sunxi/Kconfig     | 126 ++++++++++++++++----------------
 arch/mips/Kconfig               |   2 +-
 drivers/gpio/Kconfig            |   2 +-
 drivers/i2c/Kconfig             |   2 +-
 drivers/net/phy/Kconfig         |   8 +-
 drivers/power/Kconfig           |  80 ++++++++++----------
 drivers/power/pmic/Kconfig      |  58 +++++++--------
 drivers/power/regulator/Kconfig |  58 +++++++--------
 drivers/spmi/Kconfig            |   6 +-
 drivers/usb/Kconfig             |  10 +--
 drivers/usb/eth/Kconfig         |  16 ++--
 drivers/usb/host/Kconfig        |  44 +++++------
 drivers/usb/musb-new/Kconfig    |   2 +-
 drivers/video/Kconfig           |  20 ++---
 16 files changed, 222 insertions(+), 222 deletions(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index 3a3c1784e188..0f4018c709ba 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -13,14 +13,14 @@ config ARMV7_NONSEC
 	bool "Enable support for booting in non-secure mode" if EXPERT
 	depends on CPU_V7_HAS_NONSEC
 	default y
-	---help---
+	help
 	Say Y here to enable support for booting in non-secure / SVC mode.

 config ARMV7_BOOT_SEC_DEFAULT
 	bool "Boot in secure mode by default" if EXPERT
 	depends on ARMV7_NONSEC
 	default y if ARCH_TEGRA
-	---help---
+	help
 	Say Y here to boot in secure mode by default even if non-secure mode
 	is supported. This option is useful to boot kernels which do not
 	suppport booting in non-secure mode. Only set this if you need it.
@@ -74,7 +74,7 @@ config ARMV7_VIRT
 	bool "Enable support for hardware virtualization" if EXPERT
 	depends on CPU_V7_HAS_VIRT && ARMV7_NONSEC
 	default y
-	---help---
+	help
 	Say Y here to boot in hypervisor (HYP) mode when booting non-secure.

 config ARMV7_PSCI
@@ -115,7 +115,7 @@ config ARMV7_LPAE
 	bool "Use LPAE page table format" if EXPERT
 	depends on CPU_V7A
 	default y if ARMV7_VIRT
-	---help---
+	help
 	Say Y here to use the long descriptor page table format. This is
 	required if U-Boot runs in HYP mode.

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 108713488af1..2f3dea494f74 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -659,7 +659,7 @@ config ROCKCHIP_BOOT_MODE_REG
 config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
 	bool "Disable device boot on power plug-in"
 	depends on PMIC_RK8XX
-	---help---
+	help
 	  Say Y here to prevent the device from booting up because of a plug-in
 	  event. When set, the device will boot briefly to determine why it was
 	  powered on, and if it was determined because of a plug-in event
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ceba96b61a5c..bc35625b4383 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -223,7 +223,7 @@ config SUNXI_SRAM_ADDRESS
 	default 0x44000 if MACH_SUN55I_A523
 	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
 	default 0x0
-	---help---
+	help
 	Older Allwinner SoCs have their mask boot ROM mapped just below 4GB,
 	with the first SRAM region being located at address 0.
 	Some newer SoCs map the boot ROM at address 0 instead and move the
@@ -236,7 +236,7 @@ config SUNXI_RVBAR_ADDRESS
 	default 0x08000040 if MACH_SUN55I_A523
 	default 0x09010040 if SUN50I_GEN_H6
 	default 0x017000a0
-	---help---
+	help
 	The read-only RVBAR system register holds the address of the first
 	instruction to execute after a reset. Allwinner cores provide a
 	writable MMIO backing store for this register, to allow to set the
@@ -248,7 +248,7 @@ config SUNXI_RVBAR_ALTERNATIVE
 	depends on ARM64
 	default 0x08100040 if MACH_SUN50I_H616
 	default SUNXI_RVBAR_ADDRESS
-	---help---
+	help
 	The H616 die exists in at least two variants, with one having the
 	RVBAR registers at a different address. If the SoC variant ID
 	(stored in SRAM_VER_REG[7:0]) is not 0, we need to use the
@@ -282,13 +282,13 @@ config SUNXI_A64_TIMER_ERRATUM
 # not supported by Kconfig
 config SUNXI_GEN_SUN4I
 	bool
-	---help---
+	help
 	Select this for sunxi SoCs which have resets and clocks set up
 	as the original A10 (mach-sun4i).

 config SUNXI_GEN_SUN6I
 	bool
-	---help---
+	help
 	Select this for sunxi SoCs which have sun6i like periphery, like
 	separate ahb reset control registers, custom pmic bus, new style
 	watchdog, etc.
@@ -299,7 +299,7 @@ config SUN50I_GEN_H6
 	select SPL_LOAD_FIT if SPL
 	select MMC_SUNXI_HAS_NEW_MODE
 	select SUPPORT_SPL
-	---help---
+	help
 	Select this for sunxi SoCs which have H6 like peripherals, clocks
 	and memory map.

@@ -307,13 +307,13 @@ config SUNXI_GEN_NCAT2
 	bool
 	select MMC_SUNXI_HAS_NEW_MODE
 	select SUPPORT_SPL
-	---help---
+	help
 	Select this for sunxi SoCs which have D1 like peripherals, clocks
 	and memory map.

 config SUNXI_DRAM_DW
 	bool
-	---help---
+	help
 	Select this for sunxi SoCs which uses a DRAM controller like the
 	DesignWare controller used in H3, mainly SoCs after H3, which do
 	not have official open-source DRAM initialization code, but can
@@ -322,13 +322,13 @@ config SUNXI_DRAM_DW
 if SUNXI_DRAM_DW
 config SUNXI_DRAM_DW_16BIT
 	bool
-	---help---
+	help
 	Select this for sunxi SoCs with DesignWare DRAM controller and
 	have only 16-bit memory buswidth.

 config SUNXI_DRAM_DW_32BIT
 	bool
-	---help---
+	help
 	Select this for sunxi SoCs with DesignWare DRAM controller with
 	32-bit memory buswidth.
 endif
@@ -576,7 +576,7 @@ config MACH_SUN8I
 config RESERVE_ALLWINNER_BOOT0_HEADER
 	bool "reserve space for Allwinner boot0 header"
 	select ENABLE_ARM_SOC_BOOT0_HOOK
-	---help---
+	help
 	Prepend a 1536 byte (empty) header to the U-Boot image file, to be
 	filled with magic values post build. The Allwinner provided boot0
 	blob relies on this information to load and execute U-Boot.
@@ -587,7 +587,7 @@ config ARM_BOOT_HOOK_RMR
 	depends on ARM64
 	default y
 	select ENABLE_ARM_SOC_BOOT0_HOOK
-	---help---
+	help
 	Insert some ARM32 code at the very beginning of the U-Boot binary
 	which uses an RMR register write to bring the core into AArch64 mode.
 	The very first instruction acts as a switch, since it's carefully
@@ -622,7 +622,7 @@ config SUNXI_DRAM_DDR3_1333
 	bool "DDR3 1333"
 	select SUNXI_DRAM_DDR3
 	depends on !DRAM_SUN50I_A133
-	---help---
+	help
 	This option is the original only supported memory type, which suits
 	many H3/H5/A64 boards available now.

@@ -630,7 +630,7 @@ config SUNXI_DRAM_LPDDR3_STOCK
 	bool "LPDDR3 with Allwinner stock configuration"
 	select SUNXI_DRAM_LPDDR3
 	depends on !DRAM_SUN50I_A133
-	---help---
+	help
 	This option is the LPDDR3 timing used by the stock boot0 by
 	Allwinner.

@@ -638,7 +638,7 @@ config SUNXI_DRAM_H6_LPDDR3
 	bool "LPDDR3 DRAM chips on the H6 DRAM controller"
 	select SUNXI_DRAM_LPDDR3
 	depends on DRAM_SUN50I_H6
-	---help---
+	help
 	This option is the LPDDR3 timing used by the stock boot0 by
 	Allwinner.

@@ -646,7 +646,7 @@ config SUNXI_DRAM_H6_DDR3_1333
 	bool "DDR3-1333 boot0 timings on the H6 DRAM controller"
 	select SUNXI_DRAM_DDR3
 	depends on DRAM_SUN50I_H6
-	---help---
+	help
 	This option is the DDR3 timing used by the boot0 on H6 TV boxes
 	which use a DDR3-1333 timing.

@@ -694,7 +694,7 @@ config SUNXI_DRAM_DDR2_V3S
 	bool "DDR2 found in V3s chip"
 	select SUNXI_DRAM_DDR2
 	depends on MACH_SUN8I_V3S
-	---help---
+	help
 	This option is only for the DDR2 memory chip which is co-packaged in
 	Allwinner V3s SoC.

@@ -720,7 +720,7 @@ config DRAM_TYPE
 	int "sunxi dram type"
 	depends on MACH_SUN8I_A83T
 	default 3
-	---help---
+	help
 	Set the dram type, 3: DDR3, 7: LPDDR3

 config DRAM_CLK
@@ -734,7 +734,7 @@ config DRAM_CLK
 	default 744 if MACH_SUN50I_H6
 	default 720 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 1200 if MACH_SUN55I_A523
-	---help---
+	help
 	Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
 	must be a multiple of 24. For the sun9i (A80), the tested values
 	(for DDR3-1600) are 312 to 792.
@@ -743,7 +743,7 @@ if MACH_SUN5I || MACH_SUN7I
 config DRAM_MBUS_CLK
 	int "sunxi mbus clock speed"
 	default 300
-	---help---
+	help
 	Set the mbus clock speed. The maximum on sun5i hardware is 300MHz.

 endif
@@ -760,7 +760,7 @@ config DRAM_ZQ
 	default 3881979 if MACH_SUNXI_H3_H5 || MACH_SUN8I_R40 || MACH_SUN50I_H6
 	default 4145117 if MACH_SUN9I
 	default 3881915 if MACH_SUN50I
-	---help---
+	help
 	Set the dram zq value.

 config DRAM_ODT_EN
@@ -772,7 +772,7 @@ config DRAM_ODT_EN
 	default y if MACH_SUN8I_R40
 	default y if MACH_SUN50I
 	default y if MACH_SUN50I_H6
-	---help---
+	help
 	Select this to enable dram odt (on die termination).

 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
@@ -780,13 +780,13 @@ config DRAM_EMR1
 	int "sunxi dram emr1 value"
 	default 0 if MACH_SUN4I
 	default 4 if MACH_SUN5I || MACH_SUN7I
-	---help---
+	help
 	Set the dram controller emr1 value.

 config DRAM_TPR3
 	hex "sunxi dram tpr3 value"
 	default 0x0
-	---help---
+	help
 	Set the dram controller tpr3 parameter. This parameter configures
 	the delay on the command lane and also phase shifts, which are
 	applied for sampling incoming read data. The default value 0
@@ -797,7 +797,7 @@ config DRAM_TPR3
 config DRAM_DQS_GATING_DELAY
 	hex "sunxi dram dqs_gating_delay value"
 	default 0x0
-	---help---
+	help
 	Set the dram controller dqs_gating_delay parmeter. Each byte
 	encodes the DQS gating delay for each byte lane. The delay
 	granularity is 1/4 cycle. For example, the value 0x05060606
@@ -813,17 +813,17 @@ config DRAM_DQS_GATING_DELAY
 choice
 	prompt "sunxi dram timings"
 	default DRAM_TIMINGS_VENDOR_MAGIC
-	---help---
+	help
 	Select the timings of the DDR3 chips.

 config DRAM_TIMINGS_VENDOR_MAGIC
 	bool "Magic vendor timings from Android"
-	---help---
+	help
 	The same DRAM timings as in the Allwinner boot0 bootloader.

 config DRAM_TIMINGS_DDR3_1066F_1333H
 	bool "JEDEC DDR3-1333H with down binning to DDR3-1066F"
-	---help---
+	help
 	Use the timings of the standard JEDEC DDR3-1066F speed bin for
 	DRAM_CLK <= 533MHz and the timings of the DDR3-1333H speed bin
 	for DRAM_CLK > 533MHz. This covers the majority of DDR3 chips
@@ -834,7 +834,7 @@ config DRAM_TIMINGS_DDR3_1066F_1333H

 config DRAM_TIMINGS_DDR3_800E_1066G_1333J
 	bool "JEDEC DDR3-800E / DDR3-1066G / DDR3-1333J"
-	---help---
+	help
 	Use the timings of the slowest possible JEDEC speed bin for the
 	selected DRAM_CLK. Depending on the DRAM_CLK value, it may be
 	DDR3-800E, DDR3-1066G or DDR3-1333J.
@@ -847,7 +847,7 @@ if MACH_SUN8I_A23
 config DRAM_ODT_CORRECTION
 	int "sunxi dram odt correction value"
 	default 0
-	---help---
+	help
 	Set the dram odt correction value (range -255 - 255). In allwinner
 	fex files, this option is found in bits 8-15 of the u32 odt_en variable
 	in the [dram] section. When bit 31 of the odt_en variable is set
@@ -888,7 +888,7 @@ config SUNXI_MINIMUM_DRAM_MB
 	default 32 if MACH_SUNIV
 	default 64 if MACH_SUN8I_V3S
 	default 256
-	---help---
+	help
 	Minimum DRAM size expected on the board. Traditionally we assumed
 	256 MB, so that U-Boot would load at 160MB. With co-packaged DRAM
 	we have smaller sizes, though, so that U-Boot's own load address and
@@ -897,7 +897,7 @@ config SUNXI_MINIMUM_DRAM_MB

 config UART0_PORT_F
 	bool "UART0 on MicroSD breakout board"
-	---help---
+	help
 	Repurpose the SD card slot for getting access to the UART0 serial
 	console. Primarily useful only for low level u-boot debugging on
 	tablets, where normal UART0 is difficult to access and requires
@@ -907,20 +907,20 @@ config UART0_PORT_F

 config OLD_SUNXI_KERNEL_COMPAT
 	bool "Enable workarounds for booting old kernels"
-	---help---
+	help
 	Set this to enable various workarounds for old kernels, this results in
 	sub-optimal settings for newer kernels, only enable if needed.

 config MMC1_PINS_PH
 	bool "Pins for mmc1 are on Port H"
 	depends on MACH_SUN4I || MACH_SUN7I || MACH_SUN8I_R40
-	---help---
+	help
 	Select this option for boards where mmc1 uses the Port H pinmux.

 config MMC_SUNXI_SLOT_EXTRA
 	int "mmc extra slot number"
 	default -1
-	---help---
+	help
 	sunxi builds always enable mmc0, some boards also have a second sdcard
 	slot or emmc on mmc1 - mmc3. Setting this to 1, 2 or 3 will enable
 	support for this.
@@ -930,7 +930,7 @@ config I2C0_ENABLE
 	default y if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_R40
 	default n if MACH_SUN6I || MACH_SUN8I
 	select CMD_I2C
-	---help---
+	help
 	This allows enabling I2C/TWI controller 0 by muxing its pins, enabling
 	its clock and setting up the bus. This is especially useful on devices
 	with slaves connected to the bus or with pins exposed through e.g. an
@@ -939,7 +939,7 @@ config I2C0_ENABLE
 config I2C1_ENABLE
 	bool "Enable I2C/TWI controller 1"
 	select CMD_I2C
-	---help---
+	help
 	See I2C0_ENABLE help text.

 if SUNXI_GEN_SUN6I || SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
@@ -948,20 +948,20 @@ config R_I2C_ENABLE
 	# This is used for the pmic on H3
 	default y if SY8106A_POWER
 	select CMD_I2C
-	---help---
+	help
 	Set this to y to enable the I2C controller which is part of the PRCM.
 endif

 config AXP_GPIO
 	bool "Enable support for gpio-s on axp PMICs"
 	depends on AXP_PMIC_BUS
-	---help---
+	help
 	Say Y here to enable support for the gpio pins of the axp PMIC ICs.

 config AXP_DISABLE_BOOT_ON_POWERON
 	bool "Disable device boot on power plug-in"
 	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
-	---help---
+	help
 	  Say Y here to prevent the device from booting up because of a plug-in
 	  event. When set, the device will boot into the SPL briefly to
 	  determine why it was powered on, and if it was determined because of
@@ -982,7 +982,7 @@ config VIDEO_SUNXI
 	imply VIDEO_DAMAGE
 	imply VIDEO_DT_SIMPLEFB
 	default y
-	---help---
+	help
 	Say Y here to add support for using a graphical console on the HDMI,
 	LCD or VGA output found on older sunxi devices. This will also provide
 	a simple_framebuffer device for Linux.
@@ -991,19 +991,19 @@ config VIDEO_HDMI
 	bool "HDMI output support"
 	depends on VIDEO_SUNXI && !MACH_SUN8I && !MACH_SUNIV
 	default y
-	---help---
+	help
 	Say Y here to add support for outputting video over HDMI.

 config VIDEO_VGA
 	bool "VGA output support"
 	depends on VIDEO_SUNXI && (MACH_SUN4I || MACH_SUN7I)
-	---help---
+	help
 	Say Y here to add support for outputting video over VGA.

 config VIDEO_VGA_VIA_LCD
 	bool "VGA via LCD controller support"
 	depends on VIDEO_SUNXI && (MACH_SUN5I || MACH_SUN6I || MACH_SUN8I)
-	---help---
+	help
 	Say Y here to add support for external DACs connected to the parallel
 	LCD interface driving a VGA connector, such as found on the
 	Olimex A13 boards.
@@ -1011,7 +1011,7 @@ config VIDEO_VGA_VIA_LCD
 config VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH
 	bool "Force sync active high for VGA via LCD controller support"
 	depends on VIDEO_VGA_VIA_LCD
-	---help---
+	help
 	Say Y here if you've a board which uses opendrain drivers for the vga
 	hsync and vsync signals. Opendrain drivers cannot generate steep enough
 	positive edges for a stable video output, so on boards with opendrain
@@ -1021,21 +1021,21 @@ config VIDEO_VGA_EXTERNAL_DAC_EN
 	string "LCD panel power enable pin"
 	depends on VIDEO_VGA_VIA_LCD
 	default ""
-	---help---
+	help
 	Set the enable pin for the external VGA DAC. This takes a string in the
 	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

 config VIDEO_COMPOSITE
 	bool "Composite video output support"
 	depends on VIDEO_SUNXI && (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
-	---help---
+	help
 	Say Y here to add support for outputting composite video.

 config VIDEO_LCD_MODE
 	string "LCD panel timing details"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
+	help
 	LCD panel timing details string, leave empty if there is no LCD panel.
 	This is in drivers/video/videomodes.c: video_get_params() format, e.g.
 	x:800,y:480,depth:18,pclk_khz:33000,le:16,ri:209,up:22,lo:22,hs:30,vs:1,sync:0,vmode:0
@@ -1046,14 +1046,14 @@ config VIDEO_LCD_DCLK_PHASE
 	depends on VIDEO_SUNXI || VIDEO
 	default 1
 	range 0 3
-	---help---
+	help
 	Select LCD panel display clock phase shift

 config VIDEO_LCD_POWER
 	string "LCD panel power enable pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
+	help
 	Set the power enable pin for the LCD panel. This takes a string in the
 	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

@@ -1061,7 +1061,7 @@ config VIDEO_LCD_RESET
 	string "LCD panel reset pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
+	help
 	Set the reset pin for the LCD panel. This takes a string in the format
 	understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

@@ -1069,7 +1069,7 @@ config VIDEO_LCD_BL_EN
 	string "LCD panel backlight enable pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
+	help
 	Set the backlight enable pin for the LCD panel. This takes a string in the
 	the format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of
 	port H.
@@ -1078,7 +1078,7 @@ config VIDEO_LCD_BL_PWM
 	string "LCD panel backlight pwm pin"
 	depends on VIDEO_SUNXI
 	default ""
-	---help---
+	help
 	Set the backlight pwm pin for the LCD panel. This takes a string in the
 	format understood by sunxi_name_to_gpio, e.g. PH1 for pin 1 of port H.

@@ -1086,14 +1086,14 @@ config VIDEO_LCD_BL_PWM_ACTIVE_LOW
 	bool "LCD panel backlight pwm is inverted"
 	depends on VIDEO_SUNXI
 	default y
-	---help---
+	help
 	Set this if the backlight pwm output is active low.

 config VIDEO_LCD_PANEL_I2C
 	bool "LCD panel needs to be configured via i2c"
 	depends on VIDEO_SUNXI
 	select DM_I2C_GPIO
-	---help---
+	help
 	Say y here if the LCD panel needs to be configured via i2c. This
 	will add a bitbang i2c controller using gpios to talk to the LCD.

@@ -1101,7 +1101,7 @@ config VIDEO_LCD_PANEL_I2C_NAME
 	string "LCD panel i2c interface node name"
 	depends on VIDEO_LCD_PANEL_I2C
 	default "i2c"
-	---help---
+	help
 	Set the device tree node name for the LCD i2c interface.

 # Note only one of these may be selected at a time! But hidden choices are
@@ -1123,7 +1123,7 @@ config VIDEO_DE2
 	select VIDEO_DW_HDMI
 	imply VIDEO_DT_SIMPLEFB
 	default y
-	---help---
+	help
 	Say y here if you want to build DE2 video driver which is present on
 	newer SoCs. Currently only HDMI output is supported.

@@ -1131,7 +1131,7 @@ config VIDEO_DE2
 choice
 	prompt "LCD panel support"
 	depends on VIDEO_SUNXI
-	---help---
+	help
 	Select which type of LCD panel to support.

 config VIDEO_LCD_PANEL_PARALLEL
@@ -1146,7 +1146,7 @@ config VIDEO_LCD_PANEL_MIPI_4_LANE_513_MBPS_VIA_SSD2828
 	bool "MIPI 4-lane, 513Mbps LCD panel via SSD2828 bridge chip"
 	select VIDEO_LCD_SSD2828
 	select VIDEO_LCD_IF_PARALLEL
-	---help---
+	help
 	7.85" 768x1024 LCD panels, such as LG LP079X01 or AUO B079XAN01.0

 config VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804
@@ -1154,7 +1154,7 @@ config VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804
 	select VIDEO_LCD_ANX9804
 	select VIDEO_LCD_IF_PARALLEL
 	select VIDEO_LCD_PANEL_I2C
-	---help---
+	help
 	Select this for eDP LCD panels with 4 lanes running at 1.62G,
 	connected via an ANX9804 bridge chip.

@@ -1162,14 +1162,14 @@ config VIDEO_LCD_PANEL_HITACHI_TX18D42VM
 	bool "Hitachi tx18d42vm LCD panel"
 	select VIDEO_LCD_HITACHI_TX18D42VM
 	select VIDEO_LCD_IF_LVDS
-	---help---
+	help
 	7.85" 1024x768 Hitachi tx18d42vm LCD panel support

 config VIDEO_LCD_TL059WV5C0
 	bool "tl059wv5c0 LCD panel"
 	select VIDEO_LCD_PANEL_I2C
 	select VIDEO_LCD_IF_PARALLEL
-	---help---
+	help
 	6" 480x800 tl059wv5c0 panel support, as used on the Utoo P66 and
 	Aigo M60/M608/M606 tablets.

@@ -1178,7 +1178,7 @@ endchoice
 config GMAC_TX_DELAY
 	int "GMAC Transmit Clock Delay Chain"
 	default 0
-	---help---
+	help
 	Set the GMAC Transmit Clock Delay Chain value.

 config SPL_STACK_R_ADDR
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 36612756294b..b23357440cd5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -351,7 +351,7 @@ config MIPS_RELOCATION_TABLE_SIZE
 	range 0x100 0x10000
 	default "0xc000" if TARGET_MALTA
 	default "0x8000"
-	---help---
+	help
 	  A table of relocation data will be appended to the U-Boot binary
 	  and parsed in relocate_code() to fix up all offsets in the relocated
 	  U-Boot.
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0b5466b39b8d..a824c7948eee 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -459,7 +459,7 @@ config SUNXI_GPIO
 config SUNXI_NEW_PINCTRL
 	bool
 	depends on SUNXI_GPIO
-	---help---
+	help
 	The Allwinner D1 and other new SoCs use a different register map
 	for the GPIO block, which we need to know about in the SPL.

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 55465dc1d463..306a7aa0d041 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -110,7 +110,7 @@ config I2C_CROS_EC_TUNNEL
 config I2C_CROS_EC_LDO
 	bool "Provide access to LDOs on the Chrome OS EC"
 	depends on CROS_EC
-	---help---
+	help
 	On many Chromebooks the main PMIC is inaccessible to the AP. This is
 	often dealt with by using an I2C pass-through interface provided by
 	the EC. On some unfortunate models (e.g. Spring) the pass-through
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 0025c895f125..864b5aed2085 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -317,13 +317,13 @@ config PHY_TERANETICS

 config PHY_TI
 	bool "Texas Instruments Ethernet PHYs support"
-	---help---
+	help
 	  Adds PHY registration support for TI PHYs.

 config PHY_TI_DP83867
 	select PHY_TI
 	bool "Texas Instruments Ethernet DP83867 PHY support"
-	---help---
+	help
 	  Adds support for the TI DP83867 1Gbit PHY.

 config SPL_PHY_TI_DP83867
@@ -333,13 +333,13 @@ config SPL_PHY_TI_DP83867
 config PHY_TI_DP83869
 	select PHY_TI
 	bool "Texas Instruments Ethernet DP83869 PHY support"
-	---help---
+	help
 	  Adds support for the TI DP83869 1Gbit PHY.

 config PHY_TI_GENERIC
 	select PHY_TI
 	bool "Texas Instruments Generic Ethernet PHYs support"
-	---help---
+	help
 	  Adds support for Generic TI PHYs that don't need special handling but
 	  the PHY name is associated with a PHY ID.

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 1b06d8a66c7c..2f924927c299 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -63,7 +63,7 @@ choice

 config SUNXI_NO_PMIC
 	bool "board without a pmic"
-	---help---
+	help
 	Select this for boards which do not use a PMIC.

 config AXP152_POWER
@@ -71,7 +71,7 @@ config AXP152_POWER
 	depends on MACH_SUN5I
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the axp152 pmic found on most
 	A10s boards.

@@ -80,7 +80,7 @@ config AXP209_POWER
 	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3S
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the axp209 pmic found on most
 	A10, A13 and A20 boards.

@@ -89,7 +89,7 @@ config AXP221_POWER
 	depends on MACH_SUN6I || MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_R40
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the axp221/axp223 pmic found on most
 	A23 and A31 boards.

@@ -98,7 +98,7 @@ config AXP305_POWER
 	depends on MACH_SUN50I_H616
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the axp305 pmic found on most
 	H616 boards.

@@ -107,7 +107,7 @@ config AXP313_POWER
 	depends on MACH_SUN50I_H616
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the AXP313 PMIC found on some
 	H616 boards.

@@ -115,13 +115,13 @@ config AXP717_POWER
 	bool "axp717 pmic support"
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the AXP717 PMIC found on some boards.

 config AXP803_POWER
 	bool "AXP803 PMIC support"
 	select AXP_PMIC_BUS
-	---help---
+	help
 	Select this to enable support for the AXP803 PMIC found on some boards.

 config AXP809_POWER
@@ -129,7 +129,7 @@ config AXP809_POWER
 	depends on MACH_SUN9I
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Say y here to enable support for the axp809 pmic found on A80 boards.

 config AXP818_POWER
@@ -137,7 +137,7 @@ config AXP818_POWER
 	depends on MACH_SUN8I_A83T
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Say y here to enable support for the axp818 pmic found on
 	A83T dev board.

@@ -145,14 +145,14 @@ config AXP318W_POWER
 	bool "axp318w pmic support"
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
+	help
 	Select this to enable support for the AXP318W PMIC found on some
 	A733 boards.

 config SY8106A_POWER
 	bool "SY8106A pmic support"
 	depends on MACH_SUNXI_H3_H5
-	---help---
+	help
 	Select this to enable support for the SY8106A pmic found on some
 	H3 boards.

@@ -166,7 +166,7 @@ config AXP_I2C_ADDRESS
 	default 0x36 if AXP318W_POWER
 	default 0x30 if AXP152_POWER
 	default 0x34
-	---help---
+	help
 	I2C address of the AXP PMIC, used for the SPL only.

 config AXP_DCDC1_VOLT
@@ -174,7 +174,7 @@ config AXP_DCDC1_VOLT
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
 	default 3300 if AXP818_POWER || MACH_SUN8I_R40 || AXP803_POWER
 	default 3000 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dcdc1 at, set to 0 to
 	disable dcdc1. On A23 / A31 / A33 (axp221) boards dcdc1 is used for
 	generic 3.3V IO voltage for external devices like the lcd-panal and
@@ -194,7 +194,7 @@ config AXP_DCDC2_VOLT
 	default 1200 if MACH_SUN6I
 	default 1100 if MACH_SUN8I
 	default 0 if MACH_SUN9I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dcdc2 at, set to 0 to
 	disable dcdc2.
 	On A10(s) / A13 / A20 boards dcdc2 is VDD-CPU and should be 1.4V.
@@ -214,7 +214,7 @@ config AXP_DCDC3_VOLT
 	default 1100 if AXP313_POWER
 	default 1100 if MACH_SUN8I_R40
 	default 1200 if MACH_SUN6I || MACH_SUN8I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dcdc3 at, set to 0 to
 	disable dcdc3.
 	On A10(s) / A13 / A20 boards with an axp209 dcdc3 is VDD-INT-DLL and
@@ -235,7 +235,7 @@ config AXP_DCDC4_VOLT
 	default 0 if MACH_SUN8I
 	default 900 if MACH_SUN9I
 	default 1500 if AXP305_POWER
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dcdc4 at, set to 0 to
 	disable dcdc4.
 	On A10s boards with an axp152 dcdc4 is VDD-INT-DLL and should be 1.25V.
@@ -249,7 +249,7 @@ config AXP_DCDC5_VOLT
 	int "axp pmic dcdc5 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
 	default 1500 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dcdc5 at, set to 0 to
 	disable dcdc5.
 	On A23 / A31 / A33 / A80 / A83T / R40 boards dcdc5 is VCC-DRAM and
@@ -261,7 +261,7 @@ config AXP_ALDO1_VOLT
 	default 0 if MACH_SUN6I || MACH_SUN8I_R40
 	default 1800 if MACH_SUN8I_A83T
 	default 3000 if MACH_SUN8I || MACH_SUN9I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic aldo1 at, set to 0 to
 	disable aldo1.
 	On A31 boards aldo1 is often used to power the wifi module.
@@ -277,7 +277,7 @@ config AXP_ALDO2_VOLT
 	default 0 if MACH_SUN6I || MACH_SUN9I
 	default 1800 if MACH_SUN8I_A83T
 	default 2500 if MACH_SUN8I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic aldo2 at, set to 0 to
 	disable aldo2.
 	On A10(s) / A13 / A20 boards aldo2 is AVCC and should be 3.0V.
@@ -293,7 +293,7 @@ config AXP_ALDO3_VOLT
 	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0 if AXP209_POWER || MACH_SUN9I
 	default 3000 if MACH_SUN6I || MACH_SUN8I
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic aldo3 at, set to 0 to
 	disable aldo3.
 	On A10(s) / A13 / A20 boards aldo3 should be 2.8V.
@@ -307,7 +307,7 @@ choice
 	prompt "axp pmic (a)ldo3 voltage rate control"
 	depends on AXP209_POWER
 	default AXP_ALDO3_VOLT_SLOPE_NONE
-	---help---
+	help
 	The AXP can slowly ramp up voltage to reduce the inrush current when
 	changing voltages.
 	Note, this does not apply when enabling/disabling LDO3. See
@@ -316,20 +316,20 @@ choice

 config AXP_ALDO3_VOLT_SLOPE_NONE
 	bool "No voltage slope"
-	---help---
+	help
 	Tries to reach the next voltage setting near instantaneously. Measurements
 	indicate that this is about 0.0167 V/uS.

 config AXP_ALDO3_VOLT_SLOPE_16
 	bool "1.6 mV per uS"
-	---help---
+	help
 	Increases the voltage by 1.6 mV per uS until the final voltage has
 	been reached. Note that the scaling is in 25 mV steps and thus
 	the slew rate in reality is about 25 mV/31.250 uS.

 config AXP_ALDO3_VOLT_SLOPE_08
 	bool "0.8 mV per uS"
-	---help---
+	help
 	Increases the voltage by 0.8 mV per uS until the final voltage has
 	been reached. Note that the scaling is in 25 mV steps however and thus
 	the slew rate in reality is about 25 mV/15.625 uS.
@@ -340,7 +340,7 @@ endchoice
 config AXP_ALDO3_INRUSH_QUIRK
 	bool "axp pmic (a)ldo3 inrush quirk"
 	depends on AXP209_POWER
-	---help---
+	help
 	The reference design denotes a value of 4.7 uF for the output capacitor
 	of LDO3. Some boards have too high capacitance causing 	an inrush current
 	and resulting an AXP209 shutdown.
@@ -349,7 +349,7 @@ config AXP_ALDO4_VOLT
 	int "axp pmic (a)ldo4 voltage"
 	depends on AXP209_POWER
 	default 0 if AXP209_POWER
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic aldo4 at, set to 0 to
 	disable aldo4.
 	On A10(s) / A13 / A20 boards aldo4 should be 2.8V.
@@ -358,7 +358,7 @@ config AXP_DLDO1_VOLT
 	int "axp pmic dldo1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dldo1 at, set to 0 to
 	disable dldo1. On sun6i (A31) boards with ethernet dldo1 is often used
 	to power the ethernet phy. On A23, A33 and A80 boards this is often
@@ -369,7 +369,7 @@ config AXP_DLDO2_VOLT
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 3000 if MACH_SUN9I
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dldo2 at, set to 0 to
 	disable dldo2.
 	On A80 boards dldo2 normally powers the PL pins and should be 3.0V.
@@ -378,7 +378,7 @@ config AXP_DLDO3_VOLT
 	int "axp pmic dldo3 voltage"
 	depends on AXP221_POWER || AXP818_POWER
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dldo3 at, set to 0 to
 	disable dldo3.

@@ -386,7 +386,7 @@ config AXP_DLDO4_VOLT
 	int "axp pmic dldo4 voltage"
 	depends on AXP221_POWER || AXP818_POWER
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic dldo4 at, set to 0 to
 	disable dldo4.

@@ -394,7 +394,7 @@ config AXP_ELDO1_VOLT
 	int "axp pmic eldo1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic eldo1 at, set to 0 to
 	disable eldo1.

@@ -402,7 +402,7 @@ config AXP_ELDO2_VOLT
 	int "axp pmic eldo2 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic eldo2 at, set to 0 to
 	disable eldo2.

@@ -411,7 +411,7 @@ config AXP_ELDO3_VOLT
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 3000 if MACH_SUN9I
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic eldo3 at, set to 0 to
 	disable eldo3. On some A31(s) tablets it might be used to supply
 	1.2V for the SSD2828 chip (converter of parallel LCD interface
@@ -422,7 +422,7 @@ config AXP_FLDO1_VOLT
 	int "axp pmic fldo1 voltage"
 	depends on AXP818_POWER
 	default 0 if MACH_SUN8I_A83T
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic fldo1 at, set to 0 to
 	disable fldo1.
 	On A83T / H8 boards fldo1 is VCC-HSIC and should be 1.2V if HSIC is
@@ -432,7 +432,7 @@ config AXP_FLDO2_VOLT
 	int "axp pmic fldo2 voltage"
 	depends on AXP818_POWER
 	default 900 if MACH_SUN8I_A83T
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic fldo2 at, set to 0 to
 	disable fldo2.
 	On A83T / H8 boards fldo2 is VCC-CPUS and should be 0.9V.
@@ -441,21 +441,21 @@ config AXP_FLDO3_VOLT
 	int "axp pmic fldo3 voltage"
 	depends on AXP818_POWER
 	default 0
-	---help---
+	help
 	Set the voltage (mV) to program the axp pmic fldo3 at, set to 0 to
 	disable fldo3.

 config AXP_SW_ON
 	bool "axp pmic sw on"
 	depends on AXP809_POWER || AXP818_POWER
-	---help---
+	help
 	Enable to turn on axp pmic sw.

 config SY8106A_VOUT1_VOLT
 	int "SY8106A pmic VOUT1 voltage"
 	depends on SY8106A_POWER
 	default 1200
-	---help---
+	help
 	Set the voltage (mV) to program the SY8106A pmic VOUT1. This
 	is typically used to power the VDD-CPU and should be 1200mV.
 	Values can range from 680mV till 1950mV.
@@ -467,7 +467,7 @@ config TWL4030_POWER
 	depends on OMAP34XX
 	bool "Enable driver for TI TWL4030 power management chip"
 	imply CMD_POWEROFF
-	---help---
+	help
 	The TWL4030 in a combination audio CODEC/power management with
 	GPIO and it is commonly used with the OMAP3 family of processors

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 5bc14842e666..0763fba8cb58 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -1,7 +1,7 @@
 config DM_PMIC
 	bool "Enable Driver Model for PMIC drivers (UCLASS_PMIC)"
 	depends on DM
-	---help---
+	help
 	This config enables the driver-model PMIC support.
 	UCLASS_PMIC - designed to provide an I/O interface for PMIC devices.
 	For the multi-function PMIC devices, this can be used as parent I/O
@@ -16,7 +16,7 @@ config SPL_DM_PMIC
 	bool "Enable Driver Model for PMIC drivers (UCLASS_PMIC) in SPL"
 	depends on SPL_DM
 	default y
-	---help---
+	help
 	This config enables the driver-model PMIC support in SPL.
 	UCLASS_PMIC - designed to provide an I/O interface for PMIC devices.
 	For the multi-function PMIC devices, this can be used as parent I/O
@@ -28,7 +28,7 @@ config SPL_DM_PMIC
 config PMIC_CHILDREN
 	bool "Allow child devices for PMICs"
 	default y
-	---help---
+	help
 	This allows PMICs to support child devices (such as regulators) in
 	SPL. This adds quite a bit of code so if you are not using this
 	feature you can turn it off. Most likely you should turn it on for
@@ -38,7 +38,7 @@ config SPL_PMIC_CHILDREN
 	bool "Allow child devices for PMICs in SPL"
 	depends on SPL_DM_PMIC
 	default y
-	---help---
+	help
 	This allows PMICs to support child devices (such as regulators) in
 	SPL. This adds quite a bit of code so if you are not using this
 	feature you can turn it off. In this case you may need a 'back door'
@@ -57,7 +57,7 @@ config PMIC_AB8500
 config PMIC_ACT8846
 	bool "Enable support for the active-semi 8846 PMIC"
 	depends on DM_I2C
-	---help---
+	help
 	This PMIC includes 4 DC/DC step-down buck regulators and 8 low-dropout
 	regulators (LDOs). It also provides some GPIO, reset and battery
 	functions. It uses an I2C interface and is designed for use with
@@ -173,20 +173,20 @@ config SPL_DM_PMIC_PCA9450

 config DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC PFUZE100. The driver implements read/write operations.

 config SPL_DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100 in SPL"
 	depends on SPL_DM_PMIC
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC PFUZE100 in SPL. The driver implements read/write operations.

 config DM_PMIC_MAX8907
 	bool "Enable Driver Model for PMIC MAX8907"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC MAX8907. The driver implements read/write operations.
 	This is a Power Management IC with a decent set of peripherals from which
@@ -195,7 +195,7 @@ config DM_PMIC_MAX8907

 config DM_PMIC_MAX77663
 	bool "Enable Driver Model for PMIC MAX77663"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC MAX77663. The driver implements read/write operations.
 	This is a Power Management IC with a decent set of peripherals from which
@@ -204,13 +204,13 @@ config DM_PMIC_MAX77663

 config DM_PMIC_MAX77686
 	bool "Enable Driver Model for PMIC MAX77686"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC MAX77686. The driver implements read/write operations.

 config DM_PMIC_MAX8998
 	bool "Enable Driver Model for PMIC MAX8998"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC MAX8998. The driver implements read/write operations.

@@ -222,7 +222,7 @@ config DM_PMIC_MC34708

 config PMIC_MAX8997
 	bool "Enable Driver Model for PMIC MAX8997"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for PMIC MAX8997. The driver implements read/write operations.
 	This is a Power Management IC with RTC, Fuel Gauge, MUIC control on Chip.
@@ -236,7 +236,7 @@ config PMIC_MAX8997

 config PMIC_QCOM
 	bool "Enable Driver Model for Qualcomm generic PMIC"
-	---help---
+	help
 	The Qcom PMIC is connected to one (or several) processors
 	with SPMI bus. It has 2 slaves with several peripherals:
 	- 18x LDO
@@ -252,7 +252,7 @@ config PMIC_QCOM
 config PMIC_RK8XX
 	bool "Enable support for Rockchip PMIC RK8XX"
 	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF
-	---help---
+	help
 	The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
 	an RTC and two low Rds (resistance (drain to source)) switches. It is
 	accessed via an I2C interface. The device is used with Rockchip SoCs.
@@ -261,7 +261,7 @@ config PMIC_RK8XX
 config SPL_PMIC_RK8XX
 	bool "Enable support for Rockchip PMIC RK8XX in SPL"
 	depends on SPL_DM_PMIC
-	---help---
+	help
 	The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
 	an RTC and two low Rds (resistance (drain to source)) switches. It is
 	accessed via an I2C interface. The device is used with Rockchip SoCs.
@@ -269,7 +269,7 @@ config SPL_PMIC_RK8XX

 config PMIC_S2MPS11
 	bool "Enable Driver Model for PMIC Samsung S2MPS11"
-	---help---
+	help
 	The Samsung S2MPS11 PMIC provides:
 	 - 38 adjustable LDO regulators
 	 - 9 High-Efficiency Buck Converters
@@ -282,7 +282,7 @@ config PMIC_S2MPS11

 config DM_PMIC_SANDBOX
 	bool "Enable Driver Model for emulated Sandbox PMIC"
-	---help---
+	help
 	Enable the driver for Sandbox PMIC emulation. The emulated PMIC device
 	depends on two drivers:
 	- sandbox PMIC I/O driver - implements dm pmic operations
@@ -316,7 +316,7 @@ config DM_PMIC_CPCAP

 config PMIC_S5M8767
 	bool "Enable Driver Model for the Samsung S5M8767 PMIC"
-	---help---
+	help
 	The S5M8767 PMIC provides a large array of LDOs and BUCKs for use
 	as a SoC power controller. It also provides 32KHz clock outputs. This
 	driver provides basic register access and sets up the attached
@@ -324,7 +324,7 @@ config PMIC_S5M8767

 config PMIC_RN5T567
 	bool "Enable driver for Ricoh RN5T567 PMIC"
-	---help---
+	help
 	The RN5T567 is a PMIC with 4 step-down DC/DC converters, 5 LDO
 	regulators Real-Time Clock and 4 GPIOs. This driver provides
 	register access only.
@@ -332,14 +332,14 @@ config PMIC_RN5T567
 config SPL_PMIC_RN5T567
 	bool "Enable driver for Ricoh RN5T567 PMIC in SPL"
 	depends on SPL_DM_PMIC
-	---help---
+	help
 	The RN5T567 is a PMIC with 4 step-down DC/DC converters, 5 LDO
 	regulators Real-Time Clock and 4 GPIOs. This driver provides
 	register access only.

 config PMIC_TPS65090
 	bool "Enable driver for Texas Instruments TPS65090 PMIC"
-	---help---
+	help
 	The TPS65090 is a PMIC containing several LDOs, DC to DC convertors,
 	FETs and a battery charger. This driver provides register access
 	only, and you can enable the regulator/charger drivers separately if
@@ -347,32 +347,32 @@ config PMIC_TPS65090

 config PMIC_PALMAS
 	bool "Enable driver for Texas Instruments PALMAS PMIC"
-	---help---
+	help
 	The PALMAS is a PMIC containing several LDOs, SMPS.
 	This driver binds the pmic children.

 config PMIC_LP873X
 	bool "Enable driver for Texas Instruments LP873X PMIC"
-	---help---
+	help
 	The LP873X is a PMIC containing couple of LDOs and couple of SMPS.
 	This driver binds the pmic children.

 config PMIC_LP87565
 	bool "Enable driver for Texas Instruments LP87565 PMIC"
-	---help---
+	help
 	The LP87565 is a PMIC containing a bunch of SMPS.
 	This driver binds the pmic children.

 config DM_PMIC_TPS65910
 	bool "Enable driver for Texas Instruments TPS65910 PMIC"
-	---help---
+	help
 	The TPS65910 is a PMIC containing 3 buck DC-DC converters, one boost
 	DC-DC converter, 8 LDOs and a RTC. This driver binds the SMPS and LDO
 	pmic children.

 config DM_PMIC_TPS80031
 	bool "Enable driver for Texas Instruments TPS80031/TPS80032 PMIC"
-	---help---
+	help
 	This config enables implementation of driver-model pmic uclass features
 	for TPS80031/TPS80032 PMICs. The driver implements read/write operations.
 	This is a Power Management IC with a decent set of peripherals from which
@@ -385,7 +385,7 @@ config PMIC_STPMIC1
 	bool "Enable support for STMicroelectronics STPMIC1 PMIC"
 	depends on DM_I2C
 	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF && !ARM_PSCI_FW
-	---help---
+	help
 	The STPMIC1 PMIC provides 4 BUCKs, 6 LDOs, 1 VREF and 2 power switches.
 	It is accessed via an I2C interface. The device is used with STM32MP1
 	SoCs. This driver implements register read/write operations.
@@ -445,7 +445,7 @@ endif

 config PMIC_TPS65217
 	bool "Enable driver for Texas Instruments TPS65217 PMIC"
-	---help---
+	help
 	The TPS65217 is a PMIC containing several LDOs, DC to DC convertors,
 	FETs and a battery charger. This driver provides register access
 	only, and you can enable the regulator/charger drivers separately if
@@ -485,7 +485,7 @@ config POWER_PFUZE3000

 config POWER_MC34VR500
 	bool "Enable driver for Freescale MC34VR500 PMIC"
-	---help---
+	help
 	The MC34VR500 is used in conjunction with the FSL T1 and LS1 series
 	SoC. It provides 4 buck DC-DC convertors and 5 LDOs, and it is accessed
 	via an I2C interface.
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index ca5de5b87269..fad13f669cf3 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -1,7 +1,7 @@
 config DM_REGULATOR
 	bool "Enable Driver Model for REGULATOR drivers (UCLASS_REGULATOR)"
 	depends on DM
-	---help---
+	help
 	This config enables the driver model regulator support.
 	UCLASS_REGULATOR - designed to provide a common API for basic regulator's
 	functions, like get/set Voltage or Current value, enable state, etc...
@@ -19,7 +19,7 @@ config DM_REGULATOR
 config SPL_DM_REGULATOR
 	bool "Enable regulators for SPL"
 	depends on DM_REGULATOR && SPL_POWER
-	---help---
+	help
 	Regulators are seldom needed in SPL. Even if they are accessed, some
 	code space can be saved by accessing the PMIC registers directly.
 	Enable this option if you need regulators in SPL and can cope with
@@ -28,7 +28,7 @@ config SPL_DM_REGULATOR
 config REGULATOR_ACT8846
 	bool "Enable driver for ACT8846 regulator"
 	depends on DM_REGULATOR && PMIC_ACT8846
-	---help---
+	help
 	Enable support for the regulator functions of the ACT8846 PMIC. The
 	driver implements get/set api for the various BUCKS and LDOS supported
 	by the PMIC device. This driver is controlled by a device tree node
@@ -127,7 +127,7 @@ config DM_REGULATOR_PFUZE100
 	bool "Enable Driver Model for REGULATOR PFUZE100"
 	depends on DM_REGULATOR && DM_PMIC_PFUZE100
 	default DM_PMIC_PFUZE100
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for REGULATOR PFUZE100. The driver implements get/set api for:
 	value, enable and mode.
@@ -136,7 +136,7 @@ config SPL_DM_REGULATOR_PFUZE100
 	bool "Enable Driver Model for REGULATOR PFUZE100 in SPL"
 	depends on SPL_DM_REGULATOR && SPL_DM_PMIC_PFUZE100
 	default SPL_DM_PMIC_PFUZE100
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for REGULATOR PFUZE100. The driver implements get/set api for:
 	value, enable and mode.
@@ -144,7 +144,7 @@ config SPL_DM_REGULATOR_PFUZE100
 config REGULATOR_PWM
 	bool "Enable driver for PWM regulators"
 	depends on DM_REGULATOR && DM_PWM
-	---help---
+	help
 	Enable support for the PWM regulator functions which voltage are
 	controlled by PWM duty ratio. Some of Rockchip board using this kind
 	of regulator. The driver implements get/set api for the various BUCKS.
@@ -154,7 +154,7 @@ config REGULATOR_PWM
 config DM_REGULATOR_MAX8907
 	bool "Enable Driver Model for REGULATOR MAX8907"
 	depends on DM_REGULATOR && DM_PMIC_MAX8907
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for REGULATOR MAX8907. The driver supports both DC-to-DC
 	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
@@ -163,7 +163,7 @@ config DM_REGULATOR_MAX8907
 config DM_REGULATOR_MAX77663
 	bool "Enable Driver Model for REGULATOR MAX77663"
 	depends on DM_REGULATOR && DM_PMIC_MAX77663
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for REGULATOR MAX77663. The driver supports both DC-to-DC
 	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
@@ -172,7 +172,7 @@ config DM_REGULATOR_MAX77663
 config DM_REGULATOR_MAX77686
 	bool "Enable Driver Model for REGULATOR MAX77686"
 	depends on DM_REGULATOR && DM_PMIC_MAX77686
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for REGULATOR MAX77686. The driver implements get/set api for:
 	value, enable and mode.
@@ -221,7 +221,7 @@ config DM_REGULATOR_FIXED
 	bool "Enable Driver Model for REGULATOR Fixed value"
 	depends on DM_REGULATOR
 	select DM_REGULATOR_COMMON
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for fixed value regulators. The driver implements get/set api
 	for enable and get only for voltage value.
@@ -230,7 +230,7 @@ config SPL_DM_REGULATOR_FIXED
 	bool "Enable Driver Model for REGULATOR Fixed value in SPL"
 	depends on DM_REGULATOR_FIXED && SPL
 	select SPL_DM_REGULATOR_COMMON
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for fixed value regulators in SPL.

@@ -238,7 +238,7 @@ config DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR"
 	depends on DM_REGULATOR && DM_GPIO
 	select DM_REGULATOR_COMMON
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for gpio regulators. The driver implements get/set for
 	voltage value.
@@ -247,7 +247,7 @@ config DM_REGULATOR_QCOM_RPMH
 	bool "Enable driver model for Qualcomm RPMh regulator"
 	depends on DM_REGULATOR && QCOM_RPMH
 	select DEVRES
-	---help---
+	help
 	  Enable support for the Qualcomm RPMh regulator. The driver
 	  implements get/set api for a limited set of regulators used
 	  by u-boot.
@@ -255,7 +255,7 @@ config DM_REGULATOR_QCOM_RPMH
 config DM_REGULATOR_QCOM_USB_VBUS
 	bool "Enable driver model for Qualcomm USB vbus regulator"
 	depends on DM_REGULATOR && DM_PMIC
-	---help---
+	help
 	  Enable support for the Qualcomm USB Vbus regulator. The driver
 	  implements get/set api for the regulator to be used by u-boot.

@@ -263,14 +263,14 @@ config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
 	depends on DM_REGULATOR_GPIO && SPL_DM_GPIO
 	select SPL_DM_REGULATOR_COMMON
-	---help---
+	help
 	This config enables implementation of driver-model regulator uclass
 	features for gpio regulators in SPL.

 config REGULATOR_RK8XX
 	bool "Enable driver for RK8XX regulators"
 	depends on DM_REGULATOR && PMIC_RK8XX
-	---help---
+	help
 	Enable support for the regulator functions of the RK8XX PMIC. The
 	driver implements get/set api for the various BUCKS and LDOs supported
 	by the PMIC device. This driver is controlled by a device tree node
@@ -288,7 +288,7 @@ config SPL_REGULATOR_RK8XX
 config DM_REGULATOR_S2MPS11
 	bool "Enable driver for S2MPS11 regulator"
 	depends on DM_REGULATOR && PMIC_S2MPS11
-	---help---
+	help
 	This enables implementation of driver-model regulator uclass
 	features for REGULATOR S2MPS11.
 	The driver implements get/set api for: value and enable.
@@ -296,7 +296,7 @@ config DM_REGULATOR_S2MPS11
 config REGULATOR_S5M8767
 	bool "Enable support for S5M8767 regulator"
 	depends on DM_REGULATOR && PMIC_S5M8767
-	---help---
+	help
 	This enables the regulator features of the S5M8767, allowing voltages
 	to be set, etc. The driver is not fully complete but supports most
 	common requirements, including all LDOs and BUCKs. This allows many
@@ -305,7 +305,7 @@ config REGULATOR_S5M8767
 config DM_REGULATOR_SANDBOX
 	bool "Enable Driver Model for Sandbox PMIC regulator"
 	depends on DM_REGULATOR && DM_PMIC_SANDBOX
-	---help---
+	help
 	Enable the regulator driver for emulated Sandbox PMIC.
 	The emulated PMIC device depends on two drivers:
 	- sandbox PMIC I/O driver - implements dm pmic operations
@@ -335,7 +335,7 @@ config DM_REGULATOR_SANDBOX
 config REGULATOR_TPS65090
 	bool "Enable driver for TPS65090 PMIC regulators"
 	depends on PMIC_TPS65090
-	---help---
+	help
 	The TPS65090 provides several FETs (Field-effect Transistors,
 	effectively switches) which are supported by this driver as
 	regulators, one for each FET. The standard regulator interface is
@@ -345,7 +345,7 @@ config REGULATOR_TPS65090
 config DM_REGULATOR_PALMAS
 	bool "Enable driver for PALMAS PMIC regulators"
        depends on PMIC_PALMAS
-	---help---
+	help
 	This enables implementation of driver-model regulator uclass
 	features for REGULATOR PALMAS and the family of PALMAS PMICs.
 	The driver implements get/set api for: value and enable.
@@ -355,7 +355,7 @@ config DM_REGULATOR_PBIAS
 	depends on DM_REGULATOR
 	select REGMAP
 	select SYSCON
-	---help---
+	help
 	This enables implementation of driver-model regulator uclass
 	features for pseudo-regulator PBIAS found in the OMAP SOCs.
 	This pseudo-regulator is used to provide a BIAS voltage to MMC1
@@ -366,7 +366,7 @@ config DM_REGULATOR_PBIAS
 config DM_REGULATOR_LP873X
 	bool "Enable driver for LP873X PMIC regulators"
         depends on PMIC_LP873X
-	---help---
+	help
 	This enables implementation of driver-model regulator uclass
 	features for REGULATOR LP873X and the family of LP873X PMICs.
 	The driver implements get/set api for: value and enable.
@@ -374,7 +374,7 @@ config DM_REGULATOR_LP873X
 config DM_REGULATOR_LP87565
 	bool "Enable driver for LP87565 PMIC regulators"
         depends on PMIC_LP87565
-	---help---
+	help
 	This enables implementation of driver-model regulator uclass
 	features for REGULATOR LP87565 and the family of LP87565 PMICs.
 	LP87565 series of PMICs have 4 single phase BUCKs that can also
@@ -393,7 +393,7 @@ config DM_REGULATOR_STM32_VREFBUF
 config DM_REGULATOR_TPS65910
 	bool "Enable driver for TPS65910 PMIC regulators"
 	depends on DM_PMIC_TPS65910
-	---help---
+	help
 	The TPS65910 PMIC provides 4 SMPSs and 8 LDOs. This driver supports all
 	regulator types of the TPS65910 (BUCK, BOOST and LDO). It implements
 	the get/set api for value and enable.
@@ -401,7 +401,7 @@ config DM_REGULATOR_TPS65910
 config DM_REGULATOR_TPS65911
 	bool "Enable driver for TPS65911 PMIC regulators"
 	depends on DM_PMIC_TPS65910
-	---help---
+	help
 	This config enables implementation of driver-model regulator
 	uclass features for the TPS65911 PMIC. The driver supports Step-Down
 	DC-DC Converters for Processor Cores (VDD1 and VDD2), Step-Down DC-DC
@@ -422,7 +422,7 @@ config DM_REGULATOR_TPS62360
 config DM_REGULATOR_TPS80031
 	bool "Enable driver for TPS80031/TPS80032 PMIC regulators"
 	depends on DM_PMIC_TPS80031
-	---help---
+	help
 	This enables implementation of driver-model regulator uclass
 	features for TPS80031/TPS80032 PMICs. The driver implements
 	get/set api for: value and enable.
@@ -439,7 +439,7 @@ config DM_REGULATOR_TPS6287X
 config DM_REGULATOR_STPMIC1
 	bool "Enable driver for STPMIC1 regulators"
 	depends on DM_REGULATOR && PMIC_STPMIC1
-	---help---
+	help
 	Enable support for the regulator functions of the STPMIC1 PMIC. The
 	driver implements get/set api for the various BUCKS and LDOs supported
 	by the PMIC device. This driver is controlled by a device tree node
@@ -534,7 +534,7 @@ config REGULATOR_RZG2L_USBPHY
 config DM_REGULATOR_CPCAP
 	bool "Enable driver for CPCAP PMIC regulators"
 	depends on DM_REGULATOR && DM_PMIC_CPCAP
-	---help---
+	help
 	Enable implementation of driver-model regulator uclass features for
 	REGULATOR CPCAP. The driver supports both DC-to-DC Step-Down Switching
 	(SW) Regulators and Low-Dropout Linear (LDO) Regulators	found in CPCAP
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index ab4878ebae4e..44305680357a 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -3,7 +3,7 @@ menu "SPMI support"
 config SPMI
 	bool "Enable SPMI bus support"
 	depends on DM
-	---help---
+	help
 	  Select this to enable to support SPMI bus.
 	  SPMI (System Power Management Interface) bus is used
 	  to connect PMIC devices on various SoCs.
@@ -11,13 +11,13 @@ config SPMI
 config SPMI_MSM
 	bool "Support Qualcomm SPMI bus"
 	depends on SPMI
-	---help---
+	help
 	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs.

 config SPMI_SANDBOX
 	bool "Support for Sandbox SPMI bus"
 	depends on SPMI
-	---help---
+	help
 	  Demo SPMI bus implementation. Emulates part of PM8916 as single
           slave (0) on bus. It has 4 GPIO peripherals, pid 0xC0-0xC3.
 endmenu
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 93c5ee69b253..396a753fa060 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -1,7 +1,7 @@
 menuconfig USB
 	bool "USB support"
 	select BLK
-	---help---
+	help
 	  Universal Serial Bus (USB) is a specification for a serial bus
 	  subsystem which offers higher speeds and more features than the
 	  traditional PC serial port.  The bus supplies power to peripherals
@@ -94,7 +94,7 @@ comment "USB peripherals"

 config USB_STORAGE
 	bool "USB Mass Storage support"
-	---help---
+	help
 	  Say Y here if you want to connect USB mass storage devices to your
 	  board's USB port.

@@ -103,7 +103,7 @@ config USB_KEYBOARD
 	depends on DM_USB
 	select DM_KEYBOARD
 	select SYS_STDIO_DEREGISTER
-	---help---
+	help
 	  Say Y here if you want to use a USB keyboard for U-Boot command line
 	  input.

@@ -111,7 +111,7 @@ config USB_ONBOARD_HUB
 	bool "Onboard USB hub support"
 	depends on DM_USB
 	select DEVRES
-	---help---
+	help
 	  Say Y here if you want to support discrete onboard USB hubs that
 	  don't require an additional control bus for initialization, but
 	  need some non-trivial form of initialization, such as enabling a
@@ -163,7 +163,7 @@ choice
 	prompt "USB keyboard polling"
 	default SYS_USB_EVENT_POLL_VIA_INT_QUEUE if ARCH_SUNXI
 	default SYS_USB_EVENT_POLL
-	---help---
+	help
 	  Enable a polling mechanism for USB keyboard.

 config SYS_USB_EVENT_POLL
diff --git a/drivers/usb/eth/Kconfig b/drivers/usb/eth/Kconfig
index 2f6bfa8e71b8..b9b77f467437 100644
--- a/drivers/usb/eth/Kconfig
+++ b/drivers/usb/eth/Kconfig
@@ -1,6 +1,6 @@
 menuconfig USB_HOST_ETHER
 	bool "USB to Ethernet Controller Drivers"
-	---help---
+	help
 	  Say Y here if you would like to enable support for USB Ethernet
 	  adapters.

@@ -9,14 +9,14 @@ if USB_HOST_ETHER
 config USB_ETHER_ASIX
 	bool "ASIX AX8817X (USB 2.0) support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support ASIX AX8817X based USB 2.0
 	  Ethernet Devices.

 config USB_ETHER_ASIX88179
 	bool "ASIX AX88179 (USB 3.0) support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support ASIX AX88179 based USB 3.0
 	  Ethernet Devices.

@@ -24,7 +24,7 @@ config USB_ETHER_LAN75XX
 	bool "Microchip LAN75XX support"
 	depends on USB_HOST_ETHER
 	depends on PHYLIB
-	---help---
+	help
 	  Say Y here if you would like to support Microchip LAN75XX Hi-Speed
 	  USB 2.0 to 10/100/1000 Gigabit Ethernet controller.
 	  Supports 10Base-T/ 100Base-TX/1000Base-T.
@@ -34,7 +34,7 @@ config USB_ETHER_LAN78XX
 	bool "Microchip LAN78XX support"
 	depends on USB_HOST_ETHER
 	depends on PHYLIB
-	---help---
+	help
 	  Say Y here if you would like to support Microchip LAN78XX USB 3.1
 	  Gen 1 to 10/100/1000 Gigabit Ethernet controller.
 	  Supports 10Base-T/ 100Base-TX/1000Base-T.
@@ -43,14 +43,14 @@ config USB_ETHER_LAN78XX
 config USB_ETHER_MCS7830
 	bool "MOSCHIP MCS7830 (7730/7830/7832) suppport"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support MOSCHIP MCS7830 based
 	  (7730/7830/7832) USB 2.0 Ethernet Devices.

 config USB_ETHER_RTL8152
 	bool "Realtek RTL8152B/RTL8153 support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support Realtek RTL8152B/RTL8153 base
 	  USB Ethernet Devices. This driver also supports compatible devices
 	  from Samsung, Lenovo, TP-LINK and Nvidia.
@@ -58,7 +58,7 @@ config USB_ETHER_RTL8152
 config USB_ETHER_SMSC95XX
 	bool "SMSC LAN95x support"
 	depends on USB_HOST_ETHER
-	---help---
+	help
 	  Say Y here if you would like to support SMSC LAN95xx based USB 2.0
 	  Ethernet Devices.

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d75883e28650..6bbed9cb513b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -24,7 +24,7 @@ config USB_XHCI_HCD
 	bool "xHCI HCD (USB 3.0) support"
 	depends on DM && OF_CONTROL
 	select USB_HOST
-	---help---
+	help
 	  The eXtensible Host Controller Interface (xHCI) is standard for USB 3.0
 	  "SuperSpeed" host controller hardware.

@@ -149,7 +149,7 @@ config USB_EHCI_HCD
 	select USB_HOST
 	select EHCI_DESC_BIG_ENDIAN if SYS_BIG_ENDIAN
 	select EHCI_MMIO_BIG_ENDIAN if SYS_BIG_ENDIAN
-	---help---
+	help
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
 	  If your USB host controller supports USB 2.0, you will likely want to
@@ -174,14 +174,14 @@ config USB_EHCI_ATMEL
 	bool  "Support for Atmel on-chip EHCI USB controller"
 	depends on ARCH_AT91
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on Atmel chips.

 config USB_EHCI_EXYNOS
 	bool "Support for Samsung Exynos EHCI USB controller"
 	depends on ARCH_EXYNOS
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on Samsung Exynos
 	  SoCs.

@@ -191,7 +191,7 @@ config USB_EHCI_MARVELL
 	default y
 	select USB_EHCI_IS_TDI if !ARM64
 	select USB_EHCI_IS_TDI if ALLEYCAT_5
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on MVEBU SoCs.

 config USB_EHCI_MX5
@@ -205,7 +205,7 @@ config USB_EHCI_MX6
 	depends on ARCH_MX6 || ARCH_MX7ULP || ARCH_IMXRT
 	select EHCI_HCD_INIT_AFTER_RESET
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on i.MX6 SoCs.

 config USB_EHCI_MX7
@@ -215,7 +215,7 @@ config USB_EHCI_MX7
 	select PHY if IMX8M || IMX9
 	select NOP_PHY if IMX8M || IMX9
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

 config USB_EHCI_MXS
@@ -230,7 +230,7 @@ config USB_EHCI_MXS
 config USB_EHCI_NPCM
 	bool "Support for Nuvoton NPCM on-chip EHCI USB controller"
 	depends on ARCH_NPCM
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on
 	  Nuvoton NPCM chips.

@@ -240,7 +240,7 @@ config USB_EHCI_OMAP
 	select PHY
 	imply NOP_PHY
 	default y
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on OMAP3 and later
 	  SoCs.

@@ -255,7 +255,7 @@ if USB_EHCI_MX6 || USB_EHCI_MX7

 config MXC_USB_OTG_HACTIVE
 	bool "USB Power pin high active"
-	---help---
+	help
 	  Set the USB Power pin polarity to be high active (PWR_POL)

 endif
@@ -265,7 +265,7 @@ config USB_EHCI_MSM
 	depends on DM_USB
 	select USB_ULPI
 	select MSM8916_USB_PHY
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on Qualcomm
 	  Snapdragon SoCs.

@@ -280,7 +280,7 @@ config USB_EHCI_TEGRA
 	bool "Support for NVIDIA Tegra on-chip EHCI USB controller"
 	depends on ARCH_TEGRA
 	select USB_EHCI_IS_TDI
-	---help---
+	help
 	  Enable support for Tegra on-chip EHCI USB controller. If you enable
 	  ULPI and your PHY needs a different reference clock than the standard
 	  24 MHz then you have to define CFG_ULPI_REF_CLK to the appropriate
@@ -291,14 +291,14 @@ config USB_EHCI_ZYNQ
 	depends on ARCH_ZYNQ
 	default y
 	select USB_EHCI_IS_TDI
-	---help---
+	help
 	  Enable support for Zynq on-chip EHCI USB controller

 config USB_EHCI_GENERIC
 	bool "Support for generic EHCI USB controller"
 	depends on DM_USB
 	default ARCH_SUNXI
-	---help---
+	help
 	  Enables support for generic EHCI controller.

 config EHCI_HCD_INIT_AFTER_RESET
@@ -310,7 +310,7 @@ config USB_EHCI_FSL
 	select EHCI_HCD_INIT_AFTER_RESET
 	select SYS_FSL_USB_INTERNAL_UTMI_PHY if MPC85xx && \
 		!(ARCH_B4860 || ARCH_B4420 || ARCH_P4080 || ARCH_P1020 || ARCH_P2020)
-	---help---
+	help
 	  Enables support for the on-chip EHCI controller on FSL chips.

 config SYS_FSL_USB_INTERNAL_UTMI_PHY
@@ -340,7 +340,7 @@ config USB_OHCI_HCD
 	depends on DM && OF_CONTROL
 	select USB_HOST
 	select USB_OHCI_NEW
-	---help---
+	help
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
 	  UHCI specification.  If your USB host controller follows the OHCI spec,
@@ -361,7 +361,7 @@ config USB_OHCI_PCI
 config USB_OHCI_GENERIC
 	bool "Support for generic OHCI USB controller"
 	default ARCH_SUNXI
-	---help---
+	help
 	  Enables support for generic OHCI controller.

 config USB_OHCI_DA8XX
@@ -374,7 +374,7 @@ config USB_OHCI_DA8XX
 config USB_OHCI_NPCM
 	bool "Support for Nuvoton NPCM on-chip OHCI USB controller"
 	depends on ARCH_NPCM
-	---help---
+	help
 	  Enables support for the on-chip OHCI controller on
 	  Nuvoton NPCM chips.

@@ -391,7 +391,7 @@ config SYS_OHCI_SWAP_REG_ACCESS
 config USB_UHCI_HCD
 	bool "UHCI HCD (most Intel and VIA) support"
 	select USB_HOST
-	---help---
+	help
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
 	  host controller). If your USB host controller conforms to this
@@ -410,7 +410,7 @@ config USB_DWC2
 	bool "DesignWare USB2 Core support"
 	depends on DM && OF_CONTROL
 	select USB_HOST
-	---help---
+	help
 	  The DesignWare USB 2.0 controller is compliant with the
 	  USB-Implementers Forum (USB-IF) USB 2.0 specifications.
 	  Hi-Speed (480 Mbps), Full-Speed (12 Mbps), and Low-Speed (1.5 Mbps)
@@ -421,7 +421,7 @@ if USB_DWC2
 config USB_DWC2_BUFFER_SIZE
 	int "Data buffer size in kB"
 	default 64
-	---help---
+	help
 	  By default 64 kB buffer is used but if amount of RAM avaialble on
 	  the target is not enough to accommodate allocation of buffer of
 	  that size it is possible to shrink it. Smaller sizes should be fine
@@ -433,7 +433,7 @@ config USB_R8A66597_HCD
 	bool "Renesas R8A66597 USB Core support"
 	depends on DM && OF_CONTROL
 	select USB_HOST
-	---help---
+	help
 	  This enables support for the on-chip Renesas R8A66597 USB 2.0
 	  controller, present in various RZ and SH SoCs.

diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index f8daaddc657e..ae9c7f3a6efe 100644
--- a/drivers/usb/musb-new/Kconfig
+++ b/drivers/usb/musb-new/Kconfig
@@ -81,7 +81,7 @@ config USB_MUSB_SUNXI
 	depends on PHY_SUN4I_USB
 	select USB_MUSB_PIO_ONLY
 	default y
-	---help---
+	help
 	Say y here to enable support for the sunxi OTG / DRC USB controller
 	used on almost all sunxi boards.

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c0..f07e52cb39e1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -508,7 +508,7 @@ config FRAMEBUFFER_VESA_MODE

 config VIDEO_LCD_ANX9804
 	bool "ANX9804 bridge chip"
-	---help---
+	help
 	Support for the ANX9804 bridge chip, which can take pixel data coming
 	from a parallel LCD interface and translate it on the fy into a DP
 	interface for driving eDP TFT displays. It uses I2C for configuration.
@@ -654,7 +654,7 @@ config VIDEO_LCD_SHARP_LQ101R1SX01

 config VIDEO_LCD_SSD2828
 	bool "SSD2828 bridge chip"
-	---help---
+	help
 	Support for the SSD2828 bridge chip, which can take pixel data coming
 	from a parallel LCD interface and translate it on the fly into MIPI DSI
 	interface for driving a MIPI compatible LCD panel. It uses SPI for
@@ -664,7 +664,7 @@ config VIDEO_LCD_SSD2828_TX_CLK
 	int "SSD2828 TX_CLK frequency (in MHz)"
 	depends on VIDEO_LCD_SSD2828
 	default 0
-	---help---
+	help
 	The frequency of the crystal, which is clocking SSD2828. It may be
 	anything in the 8MHz-30MHz range and the exact value should be
 	retrieved from the board schematics. Or in the case of Allwinner
@@ -676,7 +676,7 @@ config VIDEO_LCD_SSD2828_RESET
 	string "RESET pin of SSD2828"
 	depends on VIDEO_LCD_SSD2828
 	default ""
-	---help---
+	help
 	The reset pin of SSD2828 chip. This takes a string in the format
 	understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.

@@ -697,7 +697,7 @@ config VIDEO_LCD_HITACHI_TX10D07VM0BAA

 config VIDEO_LCD_HITACHI_TX18D42VM
 	bool "Hitachi tx18d42vm LVDS LCD panel support"
-	---help---
+	help
 	Support for Hitachi tx18d42vm LVDS LCD panels, these panels have a
 	lcd controller which needs to be initialized over SPI, once that is
 	done they work like a regular LVDS panel.
@@ -723,7 +723,7 @@ config VIDEO_LCD_SPI_CS
 	string "SPI CS pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
 	default ""
-	---help---
+	help
 	This is one of the SPI communication pins, involved in setting up a
 	working LCD configuration. The exact role of SPI may differ for
 	different hardware setups. The option takes a string in the format
@@ -733,7 +733,7 @@ config VIDEO_LCD_SPI_SCLK
 	string "SPI SCLK pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
 	default ""
-	---help---
+	help
 	This is one of the SPI communication pins, involved in setting up a
 	working LCD configuration. The exact role of SPI may differ for
 	different hardware setups. The option takes a string in the format
@@ -743,7 +743,7 @@ config VIDEO_LCD_SPI_MOSI
 	string "SPI MOSI pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
 	default ""
-	---help---
+	help
 	This is one of the SPI communication pins, involved in setting up a
 	working LCD configuration. The exact role of SPI may differ for
 	different hardware setups. The option takes a string in the format
@@ -753,7 +753,7 @@ config VIDEO_LCD_SPI_MISO
 	string "SPI MISO pin for LCD related config job (optional)"
 	depends on VIDEO_LCD_SSD2828
 	default ""
-	---help---
+	help
 	This is one of the SPI communication pins, involved in setting up a
 	working LCD configuration. The exact role of SPI may differ for
 	different hardware setups. If wired up, this pin may provide additional
@@ -768,7 +768,7 @@ config VIDEO_MVEBU
 	bool "Armada XP LCD controller"
 	depends on ARCH_MVEBU
 	imply VIDEO_DAMAGE
-	---help---
+	help
 	Support for the LCD controller integrated in the Marvell
 	Armada XP SoC.

--
2.39.5

