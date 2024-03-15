Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B9AC54E60
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 00:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C4D87CF9;
	Fri, 15 Mar 2024 01:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H9Ux2AmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F8687C61; Fri, 15 Mar 2024 01:57:46 +0100 (CET)
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com
 [45.254.49.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED30687F5E
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 01:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=H9Ux2AmUNT9BzVr18yhXV1N9JW6po0zbZiOPX0444f3cfFMQ1LRAsXwIeWZtPNf4a7sLpvVG5GW016aE6jW5BknK8doxIhdA4oZA/oyybmwsAlG56qMn+dmUwm0vLlwGvTkmWuciw0GEyCfbH19LdAfx20WsPS+4OvCyG2JJ6Dk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=iau+NhxoauUo3IkLWvaQHTJVYSqUVcLTrP/QaW2uRnw=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 49A6B90015E;
 Fri, 15 Mar 2024 08:57:36 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip/for-next
Date: Fri, 15 Mar 2024 08:57:34 +0800
Message-Id: <20240315005734.1052500-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkxCVklMSk1KSB1IQhpCSFUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8e3f9d49d503a9kunm49a6b90015e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhA6Fzo5HzMSTy1LCw4NCQkS
 IyIaFB1VSlVKTEpLT01PSU5MS01OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNQ0hINwY+
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

Hi Tom,

This is for next;
Please pull the updates for rockchip platform:
- Add board: rk3588 Generic, Cool Pi CM5, Theobroma-Systems RK3588 Jaguar SBC,
	     Toybrick TB-RK3588X;
	     rk3588s Cool Pi 4B;
	     rk3566 Pine64 PineTab2;
- Add saradc v2 support;
- Add PMIC RK806 support;
- rk3588 disable force_jtag by default;
- Migrate to use IO-domain driver for all boards;
- Use common bss and stack addresses for rk33xx and rk35xx boards;
- Other updates for driver, config and dts;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/19951

Thanks,
- Kever

The following changes since commit 20a0ce574d6642e0dfe651467159039fac48cc4f:

  Merge tag 'v2024.04-rc4' into next (2024-03-11 15:27:20 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240315

for you to fetch changes up to 12bc1a5462a22f6dc5b91ecbf092cbaf94e66820:

  rockchip: boot_mode: fix rockchip_dnl_key_pressed requiring ADC support (2024-03-14 18:20:04 +0800)

----------------------------------------------------------------
Andy Yan (2):
      board: rockchip: Add support for rk3588s based Cool Pi 4B
      board: rockchip: Add support for rk3588 based Cool Pi CM5 EVB

Ben Wolsieffer (1):
      rockchip: load env from boot MMC device

Chen-Yu Tsai (5):
      rockchip: rk3328: Read cpuid and generate MAC address from efuse
      rockchip: rk3399: Read cpuid and generate MAC address from efuse
      rockchip: rk3328: regenerate defconfigs
      rockchip: rk3399: regenerate defconfigs
      rockchip: nanopi-r4s: Drop ROCKCHIP_OTP

Chris Morgan (4):
      arm: dts: rockchip: rk3566: Remove unnecessary clks from rgxx3
      board: rockchip: Add support for Powkiddy RGB10MAX3
      configs: Remove unnecessary options from RGxx3 config
      board: rockchip: Add early ADC button detect for RGxx3

Elon Zhang (1):
      board: rockchip: add Rockchip Toybrick TB-RK3588X board

Jonas Karlman (42):
      rockchip: rk3328: Update default u-boot, spl-boot-order prop
      rockchip: rk3328-evb: Update defconfig
      rockchip: rk3328-rock64: Update defconfig
      rockchip: rk3328-roc-cc: Update defconfig
      rockchip: rk3328-rock-pi-e: Update defconfig
      rockchip: rk3328-nanopi-r2: Update defconfig
      rockchip: rk3328-orangepi-r1-plus: Update defconfig
      rockchip: rk3328: Fix loading FIT from SD-card when booting from eMMC
      gpio: rockchip: Use gpio alias id as gpio bank id
      rng: rockchip: Use same compatible as linux
      rockchip: rk3328: Sync device tree from linux v6.8-rc1
      Revert "rockchip: Allow booting from SPI"
      rockchip: rk3328: Add support to build bootable SPI image
      rockchip: rk3328-rock64: Enable boot from SPI NOR flash
      rockchip: rk3328-orangepi-r1-plus: Enable boot from SPI NOR flash
      rockchip: spl: Enable caches to speed up checksum validation
      phy: rockchip-inno-usb2: Write to correct GRF
      phy: rockchip-inno-usb2: Limit changes made to regs
      rockchip: board: Add minimal generic RK3588S/RK3588 board
      board: rockchip: Add Pine64 PineTab2
      rockchip: Add common default bss and stack addresses
      rockchip: Use common bss and stack addresses on RK3308
      rockchip: Use common bss and stack addresses on RK3328
      rockchip: Use common bss and stack addresses on RK3399
      rockchip: Use common bss and stack addresses on RK356x
      rockchip: Use common bss and stack addresses on RK3588
      rockchip: Update the default USB Product ID value
      rockchip: board: Prepare for use of DM_USB_GADGET with DWC2_OTG
      rockchip: board: Use a common USB Product ID for UMS
      rockchip: Migrate to use DM_USB_GADGET on RK3328
      board: rockchip: rk3399: Add device tree files to MAINTAINERS
      board: rockchip: rk3399: Add myself as reviewer to MAINTAINERS
      board: rockchip: rk3399: Remove unused board_early_init_f functions
      board: rockchip: Add a common ROCK Pi 4 target
      rockchip: io-domain: Add support for RK3399
      rockchip: pine64: rockpro64: Migrate to use IO-domain driver
      rockchip: pine64: pinebook-pro: Migrate to use IO-domain driver
      rockchip: pine64: pinephone-pro: Migrate to use IO-domain driver
      rockchip: vamrs: rock960: Migrate to use IO-domain driver
      rockchip: theobroma-systems: puma: Migrate to use IO-domain driver
      rockchip: google: gru: Migrate to use IO-domain driver
      rockchip: board: Move gpt_capsule_update_setup() call

Quentin Schulz (35):
      rockchip: avoid out-of-bounds when computing cpuid
      rockchip: add weak function symbol called at the beginning of misc_init_r
      rockchip: google: gru: migrate to rockchip_early_misc_init_r
      rockchip: pine64: pinebook-pro: migrate to rockchip_early_misc_init_r
      rockchip: pine64: pinephone-pro: migrate to rockchip_early_misc_init_r
      rockchip: pine64: rockpro64: migrate to rockchip_early_misc_init_r
      rockchip: theobroma-systems: puma: migrate to rockchip_early_misc_init_r
      rockchip: theobroma-systems: ringneck: migrate to rockchip_early_misc_init_r
      rockchip: merge misc.c into board.c
      rockchip: transform rockchip_capsule_update_board_setup into a weak function symbol
      rockchip: rk3588: disable force_jtag by default
      rockchip: rk3588: add constants for some register address spaces
      rockchip: migrate hardware.h inclusion into appropriate files
      rockchip: include asm/io.h directly in asm/arch-rockchip/hardware.h
      rockchip: rk3588: bind MMC controllers in U-Boot proper pre-reloc
      board: rockchip: add Theobroma-Systems RK3588 Jaguar SBC
      rockchip: puma-rk3399: MAINTAINERS: use glob for dtses
      rockchip: rk3399-puma: migrate README to doc/board in rST format
      rockchip: ringneck_px30: migrate README to doc/board in rST format
      rockchip: ringneck_px30: update website link
      rockchip: spi: rk_spi: do not write bytes when in read-only mode
      regulator: rk8xx: remove unused functions
      regulator: rk8xx: add indirection level for some ldo callbacks
      power: rk8xx: add support for RK806
      pmic: reword help text
      rockchip: adc: rockchip-saradc: use union for preparing for v2
      rockchip: adc: rockchip-saradc: factor out channel_data callback
      rockchip: adc: rockchip-saradc: factor out start_channel callback
      rockchip: adc: rockchip-saradc: factor out stop callback
      rockchip: adc: rockchip-saradc: add support for RK3588
      power: pmic: rk8xx: fix duplicate prompt
      rockchip: jaguar-rk3588: enable SARADC and derivatives
      adc: add missing depends on ADC for controller drivers
      button: add missing ADC dependency for BUTTON_ADC
      rockchip: boot_mode: fix rockchip_dnl_key_pressed requiring ADC support

William Wu (1):
      regulator: rk8xx: fix SWITCH enable on RK809

 Kconfig                                            |   2 +-
 arch/arm/dts/Makefile                              |  10 +-
 arch/arm/dts/rk3328-evb-u-boot.dtsi                |   4 +
 arch/arm/dts/rk3328-evb.dts                        |   1 +
 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   6 -
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi         |  24 +-
 arch/arm/dts/rk3328-nanopi-r2s.dts                 |   3 +-
 .../dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi    |  34 +-
 arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts       |   4 +-
 arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  34 +-
 arch/arm/dts/rk3328-orangepi-r1-plus.dts           |   1 +
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi             |  22 +-
 arch/arm/dts/rk3328-roc-cc.dts                     |   3 +-
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi          |  18 +-
 arch/arm/dts/rk3328-rock-pi-e.dts                  |  55 ++
 arch/arm/dts/rk3328-rock64-u-boot.dtsi             |  32 +-
 arch/arm/dts/rk3328-rock64.dts                     |   1 +
 arch/arm/dts/rk3328-u-boot.dtsi                    | 106 ++-
 arch/arm/dts/rk3328.dtsi                           | 105 ++-
 arch/arm/dts/rk3399-u-boot.dtsi                    |   2 +-
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi     |  31 -
 arch/arm/dts/rk3566-anbernic-rgxx3.dts             |  16 +-
 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi           |  44 +
 arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi      |   3 +
 arch/arm/dts/rk3566-pinetab2-v0.1.dts              |  28 +
 arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi      |   3 +
 arch/arm/dts/rk3566-pinetab2-v2.0.dts              |  48 ++
 arch/arm/dts/rk3566-pinetab2.dtsi                  | 943 +++++++++++++++++++++
 arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi     |  29 +
 arch/arm/dts/rk3588-coolpi-cm5-evb.dts             | 216 +++++
 arch/arm/dts/rk3588-coolpi-cm5.dtsi                | 649 ++++++++++++++
 arch/arm/dts/rk3588-generic-u-boot.dtsi            |   3 +
 arch/arm/dts/rk3588-generic.dts                    |  44 +
 arch/arm/dts/rk3588-jaguar-u-boot.dtsi             |  33 +
 arch/arm/dts/rk3588-jaguar.dts                     | 803 ++++++++++++++++++
 arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi        |  12 +
 arch/arm/dts/rk3588-toybrick-x0.dts                | 688 +++++++++++++++
 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi         |  29 +
 arch/arm/dts/rk3588s-coolpi-4b.dts                 | 812 ++++++++++++++++++
 arch/arm/dts/rk3588s-u-boot.dtsi                   |   2 +
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h    |   2 +
 arch/arm/include/asm/arch-rockchip/grf_rk3588.h    |  24 +
 arch/arm/include/asm/arch-rockchip/hardware.h      |   2 +
 arch/arm/include/asm/arch-rockchip/ioc_rk3588.h    |   6 +
 arch/arm/include/asm/arch-rockchip/misc.h          |  14 -
 arch/arm/mach-rockchip/Kconfig                     |  85 ++
 arch/arm/mach-rockchip/Makefile                    |   1 -
 arch/arm/mach-rockchip/board.c                     | 199 ++++-
 arch/arm/mach-rockchip/boot_mode.c                 |   4 +
 arch/arm/mach-rockchip/cpu-info.c                  |   1 -
 arch/arm/mach-rockchip/misc.c                      | 135 ---
 arch/arm/mach-rockchip/px30/px30.c                 |   1 -
 arch/arm/mach-rockchip/rk3036/rk3036.c             |   1 -
 arch/arm/mach-rockchip/rk3036/sdram_rk3036.c       |   1 -
 arch/arm/mach-rockchip/rk3066/rk3066.c             |   2 +-
 arch/arm/mach-rockchip/rk3188/rk3188.c             |   1 -
 arch/arm/mach-rockchip/rk322x/rk322x.c             |   1 -
 arch/arm/mach-rockchip/rk3288/rk3288.c             |   1 -
 arch/arm/mach-rockchip/rk3308/Kconfig              |   7 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c             |   1 -
 arch/arm/mach-rockchip/rk3328/Kconfig              |  11 +-
 arch/arm/mach-rockchip/rk3328/rk3328.c             |   2 +-
 arch/arm/mach-rockchip/rk3368/rk3368.c             |   1 -
 arch/arm/mach-rockchip/rk3399/Kconfig              |  13 +-
 arch/arm/mach-rockchip/rk3399/rk3399.c             |   1 -
 arch/arm/mach-rockchip/rk3568/Kconfig              |   7 +-
 arch/arm/mach-rockchip/rk3568/rk3568.c             |   1 -
 arch/arm/mach-rockchip/rk3588/Kconfig              |  62 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c             |  16 +-
 arch/arm/mach-rockchip/rv1126/rv1126.c             |   1 -
 arch/arm/mach-rockchip/spl-boot-order.c            |   3 -
 arch/arm/mach-rockchip/spl.c                       |  16 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c         |  72 ++
 board/elgin/elgin_rv1108/elgin_rv1108.c            |   1 -
 board/firefly/firefly-rk3308/roc_cc_rk3308.c       |   1 -
 board/firefly/roc-pc-rk3399/MAINTAINERS            |   1 +
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c        |  22 +-
 board/google/gru/gru.c                             |  52 --
 board/pine64/pinebook-pro-rk3399/MAINTAINERS       |   6 +-
 board/pine64/pinebook-pro-rk3399/Makefile          |   1 -
 .../pinebook-pro-rk3399/pinebook-pro-rk3399.c      |  76 --
 board/pine64/pinephone-pro-rk3399/MAINTAINERS      |   5 +-
 board/pine64/pinephone-pro-rk3399/Makefile         |   1 -
 .../pinephone-pro-rk3399/pinephone-pro-rk3399.c    |  78 --
 board/pine64/quartz64_rk3566/MAINTAINERS           |  11 +
 board/pine64/rockpro64_rk3399/MAINTAINERS          |   3 +-
 board/pine64/rockpro64_rk3399/Makefile             |   7 -
 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c   |  56 --
 board/radxa/rockpi4-rk3399/Kconfig                 |  15 +
 board/radxa/rockpi4-rk3399/MAINTAINERS             |  22 +
 .../evb_rk3399 => radxa/rockpi4-rk3399}/Makefile   |   2 +-
 .../rockpi4-rk3399/rockpi4-rk3399.c}               |  33 +-
 board/rockchip/evb_rk3328/MAINTAINERS              |  11 +
 board/rockchip/evb_rk3328/README                   |  70 --
 board/rockchip/evb_rk3399/MAINTAINERS              |  48 +-
 board/rockchip/evb_rk3588/MAINTAINERS              |  22 +
 board/rockchip/evb_rv1108/evb_rv1108.c             |   1 -
 board/rockchip/tinker_rk3288/tinker-rk3288.c       |  12 -
 board/rockchip/toybrick_rk3588/Kconfig             |  12 +
 board/rockchip/toybrick_rk3588/MAINTAINERS         |   8 +
 board/rockchip/toybrick_rk3588/Makefile            |   6 +
 board/rockchip/toybrick_rk3588/toybrick-rk3588.c   |  39 +
 board/theobroma-systems/common/common.c            |  30 -
 board/theobroma-systems/jaguar_rk3588/Kconfig      |  16 +
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |  13 +
 board/theobroma-systems/jaguar_rk3588/Makefile     |  10 +
 .../jaguar_rk3588/jaguar_rk3588.c                  |  53 ++
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   3 +-
 board/theobroma-systems/puma_rk3399/README         |  90 +-
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  |  42 +-
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   3 +-
 board/theobroma-systems/ringneck_px30/README       |  70 +-
 .../ringneck_px30/ringneck-px30.c                  |  20 +-
 board/vamrs/rock960_rk3399/MAINTAINERS             |   2 +
 board/vamrs/rock960_rk3399/Makefile                |   6 -
 board/vamrs/rock960_rk3399/rock960-rk3399.c        |  28 -
 cmd/pmic.c                                         |   4 +-
 configs/anbernic-rgxx3-rk3566_defconfig            |  28 +-
 configs/bpi-r2-pro-rk3568_defconfig                |  13 -
 configs/chromebook_bob_defconfig                   |   4 +-
 configs/chromebook_kevin_defconfig                 |   4 +-
 configs/coolpi-4b-rk3588s_defconfig                | 100 +++
 configs/coolpi-cm5-evb-rk3588_defconfig            | 100 +++
 configs/eaidk-610-rk3399_defconfig                 |  11 -
 configs/evb-rk3308_defconfig                       |  13 -
 configs/evb-rk3328_defconfig                       |  45 +-
 configs/evb-rk3399_defconfig                       |  11 -
 configs/evb-rk3568_defconfig                       |  13 -
 configs/evb-rk3588_defconfig                       |  13 -
 configs/ficus-rk3399_defconfig                     |   1 +
 configs/firefly-rk3399_defconfig                   |  13 -
 configs/generic-rk3568_defconfig                   |  13 -
 configs/generic-rk3588_defconfig                   |  53 ++
 configs/jaguar-rk3588_defconfig                    | 109 +++
 configs/khadas-edge-captain-rk3399_defconfig       |  11 -
 configs/khadas-edge-rk3399_defconfig               |  11 -
 configs/khadas-edge-v-rk3399_defconfig             |  11 -
 configs/leez-rk3399_defconfig                      |  11 -
 configs/lubancat-2-rk3568_defconfig                |  13 -
 configs/nanopc-t4-rk3399_defconfig                 |  11 -
 configs/nanopc-t6-rk3588_defconfig                 |  13 -
 configs/nanopi-m4-2gb-rk3399_defconfig             |  11 -
 configs/nanopi-m4-rk3399_defconfig                 |  11 -
 configs/nanopi-m4b-rk3399_defconfig                |  11 -
 configs/nanopi-neo4-rk3399_defconfig               |  11 -
 configs/nanopi-r2c-plus-rk3328_defconfig           |  43 +-
 configs/nanopi-r2c-rk3328_defconfig                |  43 +-
 configs/nanopi-r2s-rk3328_defconfig                |  43 +-
 configs/nanopi-r4s-rk3399_defconfig                |  14 -
 configs/nanopi-r5c-rk3568_defconfig                |  13 -
 configs/nanopi-r5s-rk3568_defconfig                |  13 -
 configs/neu6a-io-rk3588_defconfig                  |  13 -
 configs/neu6b-io-rk3588_defconfig                  |  13 -
 configs/odroid-m1-rk3568_defconfig                 |  13 -
 configs/orangepi-5-plus-rk3588_defconfig           |  13 -
 configs/orangepi-5-rk3588s_defconfig               |  13 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig      |  52 +-
 configs/orangepi-r1-plus-rk3328_defconfig          |  52 +-
 configs/orangepi-rk3399_defconfig                  |  11 -
 configs/pinebook-pro-rk3399_defconfig              |  14 +-
 configs/pinephone-pro-rk3399_defconfig             |  14 +-
 configs/pinetab2-rk3566_defconfig                  | 105 +++
 configs/puma-rk3399_defconfig                      |   4 +-
 configs/quartz64-a-rk3566_defconfig                |  13 -
 configs/quartz64-b-rk3566_defconfig                |  13 -
 configs/quartzpro64-rk3588_defconfig               |  13 -
 configs/radxa-cm3-io-rk3566_defconfig              |  13 -
 configs/radxa-e25-rk3568_defconfig                 |  13 -
 configs/roc-cc-rk3308_defconfig                    |  13 -
 configs/roc-cc-rk3328_defconfig                    |  38 +-
 configs/roc-pc-mezzanine-rk3399_defconfig          |  13 -
 configs/roc-pc-rk3399_defconfig                    |  13 -
 configs/rock-3a-rk3568_defconfig                   |  13 -
 configs/rock-4c-plus-rk3399_defconfig              |  15 +-
 configs/rock-4se-rk3399_defconfig                  |  15 +-
 configs/rock-pi-4-rk3399_defconfig                 |  15 +-
 configs/rock-pi-4c-rk3399_defconfig                |  15 +-
 configs/rock-pi-e-rk3328_defconfig                 |  42 +-
 configs/rock-pi-n10-rk3399pro_defconfig            |  12 -
 configs/rock-pi-s-rk3308_defconfig                 |  13 -
 configs/rock5a-rk3588s_defconfig                   |  13 -
 configs/rock5b-rk3588_defconfig                    |  13 -
 configs/rock64-rk3328_defconfig                    |  47 +-
 configs/rock960-rk3399_defconfig                   |  13 +-
 configs/rockpro64-rk3399_defconfig                 |  14 +-
 configs/soquartz-blade-rk3566_defconfig            |  13 -
 configs/soquartz-cm4-rk3566_defconfig              |  13 -
 configs/soquartz-model-a-rk3566_defconfig          |  13 -
 configs/toybrick-rk3588_defconfig                  |  68 ++
 configs/turing-rk1-rk3588_defconfig                |  13 -
 doc/board/anbernic/rgxx3.rst                       |   1 +
 doc/board/index.rst                                |   1 +
 doc/board/rockchip/rockchip.rst                    |  15 +-
 doc/board/theobroma-systems/index.rst              |  11 +
 doc/board/theobroma-systems/jaguar_rk3588.rst      | 100 +++
 doc/board/theobroma-systems/puma_rk3399.rst        | 126 +++
 doc/board/theobroma-systems/ringneck_px30.rst      |  95 +++
 drivers/adc/Kconfig                                |   4 +
 drivers/adc/rockchip-saradc.c                      | 202 ++++-
 drivers/button/Kconfig                             |   1 +
 drivers/clk/rockchip/clk_pll.c                     |   1 -
 drivers/clk/rockchip/clk_px30.c                    |   1 -
 drivers/clk/rockchip/clk_rk3036.c                  |   1 -
 drivers/clk/rockchip/clk_rk3066.c                  |   1 -
 drivers/clk/rockchip/clk_rk3128.c                  |   1 -
 drivers/clk/rockchip/clk_rk3188.c                  |   1 -
 drivers/clk/rockchip/clk_rk322x.c                  |   1 -
 drivers/clk/rockchip/clk_rk3288.c                  |   1 -
 drivers/clk/rockchip/clk_rk3308.c                  |   1 -
 drivers/clk/rockchip/clk_rk3328.c                  |   1 -
 drivers/clk/rockchip/clk_rk3368.c                  |   1 -
 drivers/clk/rockchip/clk_rk3399.c                  |   1 -
 drivers/clk/rockchip/clk_rk3568.c                  |   1 -
 drivers/clk/rockchip/clk_rk3588.c                  |   1 -
 drivers/clk/rockchip/clk_rv1108.c                  |   1 -
 drivers/clk/rockchip/clk_rv1126.c                  |   1 -
 drivers/gpio/rk_gpio.c                             |   8 +-
 drivers/misc/rockchip-io-domain.c                  |  79 +-
 drivers/net/gmac_rockchip.c                        |   1 -
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      | 158 +---
 drivers/power/pmic/Kconfig                         |   2 +-
 drivers/power/pmic/rk8xx.c                         |  91 ++
 drivers/power/regulator/rk8xx.c                    | 595 ++++++++++++-
 drivers/ram/rockchip/dmc-rk3368.c                  |   2 +-
 drivers/ram/rockchip/sdram_px30.c                  |   1 -
 drivers/ram/rockchip/sdram_rk3066.c                |   1 -
 drivers/ram/rockchip/sdram_rk3188.c                |   2 +-
 drivers/ram/rockchip/sdram_rk322x.c                |   1 -
 drivers/ram/rockchip/sdram_rk3288.c                |   2 +-
 drivers/ram/rockchip/sdram_rk3399.c                |   1 -
 drivers/ram/rockchip/sdram_rv1126.c                |   1 -
 drivers/rng/rockchip_rng.c                         |  11 +-
 drivers/spi/rk_spi.c                               |  20 +-
 drivers/sysreset/sysreset_rockchip.c               |   1 -
 drivers/usb/gadget/Kconfig                         |  15 +-
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c      |   1 -
 drivers/video/rockchip/rk3288_hdmi.c               |   1 -
 drivers/video/rockchip/rk3288_mipi.c               |   1 -
 drivers/video/rockchip/rk3288_vop.c                |   1 -
 drivers/video/rockchip/rk3399_hdmi.c               |   1 -
 drivers/video/rockchip/rk3399_mipi.c               |   1 -
 drivers/video/rockchip/rk3399_vop.c                |   1 -
 drivers/video/rockchip/rk_edp.c                    |   1 -
 drivers/video/rockchip/rk_hdmi.c                   |   1 -
 drivers/video/rockchip/rk_lvds.c                   |   1 -
 include/configs/jaguar_rk3588.h                    |  15 +
 include/configs/rk3036_common.h                    |   1 -
 include/configs/rk3066_common.h                    |   1 -
 include/configs/rk3188_common.h                    |   1 -
 include/configs/rk322x_common.h                    |   1 -
 include/configs/rk3288_common.h                    |   1 -
 include/configs/rk3368_common.h                    |   1 -
 include/configs/rk3399_common.h                    |  16 -
 include/configs/rockpi4-rk3399.h                   |  32 +
 include/configs/rv1108_common.h                    |   1 -
 include/configs/toybrick_rk3588.h                  |  15 +
 include/power/rk8xx_pmic.h                         |  21 +-
 257 files changed, 7611 insertions(+), 2336 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1.dts
 create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0.dts
 create mode 100644 arch/arm/dts/rk3566-pinetab2.dtsi
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-evb.dts
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5.dtsi
 create mode 100644 arch/arm/dts/rk3588-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-generic.dts
 create mode 100644 arch/arm/dts/rk3588-jaguar-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-jaguar.dts
 create mode 100644 arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-toybrick-x0.dts
 create mode 100644 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-coolpi-4b.dts
 delete mode 100644 arch/arm/include/asm/arch-rockchip/misc.h
 delete mode 100644 arch/arm/mach-rockchip/misc.c
 delete mode 100644 board/pine64/pinebook-pro-rk3399/Makefile
 delete mode 100644 board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
 delete mode 100644 board/pine64/pinephone-pro-rk3399/Makefile
 delete mode 100644 board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
 delete mode 100644 board/pine64/rockpro64_rk3399/Makefile
 delete mode 100644 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
 create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
 create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
 rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile (79%)
 rename board/{rockchip/evb_rk3399/evb-rk3399.c => radxa/rockpi4-rk3399/rockpi4-rk3399.c} (65%)
 delete mode 100644 board/rockchip/evb_rk3328/README
 create mode 100644 board/rockchip/toybrick_rk3588/Kconfig
 create mode 100644 board/rockchip/toybrick_rk3588/MAINTAINERS
 create mode 100644 board/rockchip/toybrick_rk3588/Makefile
 create mode 100644 board/rockchip/toybrick_rk3588/toybrick-rk3588.c
 create mode 100644 board/theobroma-systems/jaguar_rk3588/Kconfig
 create mode 100644 board/theobroma-systems/jaguar_rk3588/MAINTAINERS
 create mode 100644 board/theobroma-systems/jaguar_rk3588/Makefile
 create mode 100644 board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
 delete mode 100644 board/vamrs/rock960_rk3399/Makefile
 delete mode 100644 board/vamrs/rock960_rk3399/rock960-rk3399.c
 create mode 100644 configs/coolpi-4b-rk3588s_defconfig
 create mode 100644 configs/coolpi-cm5-evb-rk3588_defconfig
 create mode 100644 configs/generic-rk3588_defconfig
 create mode 100644 configs/jaguar-rk3588_defconfig
 create mode 100644 configs/pinetab2-rk3566_defconfig
 create mode 100644 configs/toybrick-rk3588_defconfig
 create mode 100644 doc/board/theobroma-systems/index.rst
 create mode 100644 doc/board/theobroma-systems/jaguar_rk3588.rst
 create mode 100644 doc/board/theobroma-systems/puma_rk3399.rst
 create mode 100644 doc/board/theobroma-systems/ringneck_px30.rst
 create mode 100644 include/configs/jaguar_rk3588.h
 create mode 100644 include/configs/rockpi4-rk3399.h
 create mode 100644 include/configs/toybrick_rk3588.h
