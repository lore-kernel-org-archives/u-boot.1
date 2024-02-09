Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF088C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5C787E85;
	Fri,  9 Feb 2024 10:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773B887E60; Fri,  9 Feb 2024 10:50:18 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3589587E56
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TWTc3551Hzbs2;
 Fri,  9 Feb 2024 10:50:11 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TWTc13zW0zMppKV; Fri,  9 Feb 2024 10:50:09 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 00/20] rockchip: add support for Theobroma JAGUAR
 SBC-RK3588-AMR
Date: Fri, 09 Feb 2024 10:49:56 +0100
Message-Id: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAET1xWUC/2XMSw7CIBSF4a00dyyGR9HoyH2YDpBeCiYUw8XGp
 mHvYqcO/5OTbwPCHJDg2m2QcQkU0txCHjqw3swTsjC2Bsllz4VU7Gmmt8kM3cg56rPTJwvt/Mr
 owmeH7kNrH6ikvO7uIn7rH7EIxplAtMKq/qKVvRWP6ZFTNIxWKhjpaFOEodb6BQSm0d2oAAAA
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
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
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.12.4
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

This adds all the necessary bits for adding support for Theobroma's new
SBC.

JAGUAR is a Single-Board Computer (SBC) based around the rk3588 SoC and
is targeting Autonomous Mobile Robots (AMR).

It features:
 * LPDDR4X (up to 16GB)
 * 1Gbps Ethernet on RJ45 connector (KSZ9031 or KSZ9131)
 * PCIe 3.0 4-lane on M.2 M-key connector
 * PCIe 2.1 1-lane on M.2 E-key
 * USB 2.0 on M.2 E-key
 * 2x USB3 OTG type-c ports with DP Alt-Mode
 * USB2 host port
 * HDMI output
 * 2x camera connectors, each exposing:
   * 2-lane MIPI-CSI
   * 1v2, 1v8, 2v8 power rails
   * I2C bus
   * GPIOs
 * PPS input
 * CAN
 * RS485 UART
 * FAN connector
 * SD card slot
 * eMMC (up to 256GB)
 * RTC backup battery
 * Companion microcontroller
   * ISL1208 RTC emulation
   * AMC6821 PWM emulation
 * On/off buzzer control
 * Secure Element
 * 80-pin Mezzanine connector for daughterboards:
   * GPIOs
   * 1Gbps Ethernet
   * PCIe 2.1 1-lane
   * 2x 2-lane MIPI-CSI
   * ADC channel
   * I2C bus
   * PWM
   * UART
   * SPI
   * SDIO
   * CAN
   * I2S
   * 1v8, 3v3, 5v0, dc-in (12-24V) power rails

While at it, do some code cleanup and factoring out for Rockchip SoCs.

This also fixes issues with the SDMMC controller on all RK3588 boards
being muxed into JTAG automatically and breaking SD card support.

This also binds the MMC controllers from RK3588 in U-Boot proper before
relocation so that it's available for env_init(), be there any need for
it (there's for Theobroma's RK3588 based products), and match all
(except the RK356x family) Rockchip SoCs behavior.

Special attention should be brought to the rockchip_early_misc_init_r
migration for Pinephone Pro and Pinebook Pro since they now also call
rockchip_setup_macaddr() which they didn't until now.

This also do a few non-code changes for Ringneck PX30 and Puma RK3399.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v2:
- added missing dtb Make target in arch/arm/dts/Makefile
- added some Rb
- reworded some commit logs
- fixed typo in pinebook/pinephone commits missing the -pro suffix
- added removal of DDR52 and HS mode for eMMC following discussions from
  https://lore.kernel.org/u-boot/20240204205312.2342868-1-jonas@kwiboo.se/
- migrated plaintext board/theobroma-systems/jaguar_rk3588/README from
  earlier version to doc/board/theobroma-systems/jaguar_rk3588.rst in
  rST format
- added commit for migration of plaintext
  board/theobroma-systems/puma_rk3399/README to
  doc/board/theobroma-systems/puma_rk3399.rst in rST format
- added commit for migration of plaintext
  board/theobroma-systems/ringneck_px30/README to
  doc/board/theobroma-systems/ringneck_px30.rst in rST format
- updated DTS in MAINTAINERS entry for Puma to match all Puma DTSes
- updated product URL in ringneck's MAINTAINERS entry to work around
  HTTP404
- Link to v1: https://lore.kernel.org/r/20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com

---
Quentin Schulz (20):
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
      rockchip: rk3588: fix non-working SD controller if booting from other media
      rockchip: rk3588: add constants for some register address spaces
      rockchip: migrate hardware.h inclusion into appropriate files
      rockchip: include asm/io.h directly in asm/arch-rockchip/hardware.h
      rockchip: rk3588: bind MMC controllers in U-Boot proper pre-reloc
      board: rockchip: add Theobroma-Systems RK3588 Jaguar SBC
      rockchip: puma-rk3399: MAINTAINERS: use glob for dtses
      rockchip: rk3399-puma: migrate README to doc/board in rST format
      rockchip: ringneck_px30: migrate README to doc/board in rST format
      rockchip: ringneck_px30: update website link

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/rk3588-jaguar-u-boot.dtsi             |  38 +
 arch/arm/dts/rk3588-jaguar.dts                     | 803 +++++++++++++++++++++
 arch/arm/dts/rk3588s-u-boot.dtsi                   |   4 +-
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h    |   2 +
 arch/arm/include/asm/arch-rockchip/grf_rk3588.h    |  24 +
 arch/arm/include/asm/arch-rockchip/hardware.h      |   2 +
 arch/arm/include/asm/arch-rockchip/ioc_rk3588.h    |   6 +
 arch/arm/include/asm/arch-rockchip/misc.h          |  14 -
 arch/arm/mach-rockchip/Makefile                    |   1 -
 arch/arm/mach-rockchip/board.c                     | 139 +++-
 arch/arm/mach-rockchip/cpu-info.c                  |   1 -
 arch/arm/mach-rockchip/misc.c                      | 135 ----
 arch/arm/mach-rockchip/px30/px30.c                 |   1 -
 arch/arm/mach-rockchip/rk3036/rk3036.c             |   1 -
 arch/arm/mach-rockchip/rk3036/sdram_rk3036.c       |   1 -
 arch/arm/mach-rockchip/rk3066/rk3066.c             |   2 +-
 arch/arm/mach-rockchip/rk3188/rk3188.c             |   1 -
 arch/arm/mach-rockchip/rk322x/rk322x.c             |   1 -
 arch/arm/mach-rockchip/rk3288/rk3288.c             |   1 -
 arch/arm/mach-rockchip/rk3308/rk3308.c             |   1 -
 arch/arm/mach-rockchip/rk3328/rk3328.c             |   1 -
 arch/arm/mach-rockchip/rk3368/rk3368.c             |   1 -
 arch/arm/mach-rockchip/rk3399/rk3399.c             |   1 -
 arch/arm/mach-rockchip/rk3568/rk3568.c             |   1 -
 arch/arm/mach-rockchip/rk3588/Kconfig              |  28 +
 arch/arm/mach-rockchip/rk3588/rk3588.c             |  12 +-
 arch/arm/mach-rockchip/rv1126/rv1126.c             |   1 -
 board/elgin/elgin_rv1108/elgin_rv1108.c            |   1 -
 board/firefly/firefly-rk3308/roc_cc_rk3308.c       |   1 -
 board/google/gru/gru.c                             |  21 +-
 .../pinebook-pro-rk3399/pinebook-pro-rk3399.c      |  19 +-
 .../pinephone-pro-rk3399/pinephone-pro-rk3399.c    |  18 +-
 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c   |  21 +-
 board/rockchip/evb_rv1108/evb_rv1108.c             |   1 -
 board/theobroma-systems/jaguar_rk3588/Kconfig      |  16 +
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |  13 +
 board/theobroma-systems/jaguar_rk3588/Makefile     |  10 +
 .../jaguar_rk3588/jaguar_rk3588.c                  |  52 ++
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   3 +-
 board/theobroma-systems/puma_rk3399/README         |  90 +--
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  |  21 +-
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   3 +-
 board/theobroma-systems/ringneck_px30/README       |  70 +-
 .../ringneck_px30/ringneck-px30.c                  |  20 +-
 board/vamrs/rock960_rk3399/rock960-rk3399.c        |   1 -
 configs/jaguar-rk3588_defconfig                    | 115 +++
 doc/board/index.rst                                |   1 +
 doc/board/rockchip/rockchip.rst                    |   1 +
 doc/board/theobroma-systems/index.rst              |  11 +
 doc/board/theobroma-systems/jaguar_rk3588.rst      | 100 +++
 doc/board/theobroma-systems/puma_rk3399.rst        | 126 ++++
 doc/board/theobroma-systems/ringneck_px30.rst      |  95 +++
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
 drivers/gpio/rk_gpio.c                             |   1 -
 drivers/net/gmac_rockchip.c                        |   1 -
 drivers/ram/rockchip/dmc-rk3368.c                  |   2 +-
 drivers/ram/rockchip/sdram_px30.c                  |   1 -
 drivers/ram/rockchip/sdram_rk3066.c                |   1 -
 drivers/ram/rockchip/sdram_rk3188.c                |   2 +-
 drivers/ram/rockchip/sdram_rk322x.c                |   1 -
 drivers/ram/rockchip/sdram_rk3288.c                |   2 +-
 drivers/ram/rockchip/sdram_rk3399.c                |   1 -
 drivers/ram/rockchip/sdram_rv1126.c                |   1 -
 drivers/rng/rockchip_rng.c                         |   1 -
 drivers/sysreset/sysreset_rockchip.c               |   1 -
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
 include/configs/rv1108_common.h                    |   1 -
 99 files changed, 1626 insertions(+), 491 deletions(-)
---
base-commit: a4650bf65e4b7d3ef04c90ba8031374428e4a682
change-id: 20240123-jaguar-efd00e57f56c

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

