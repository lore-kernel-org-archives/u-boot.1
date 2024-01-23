Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6A3C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596F387D4C;
	Tue, 23 Jan 2024 15:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DE287D49; Tue, 23 Jan 2024 15:49:51 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [45.157.188.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CECA87BFD
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK93c1GswzMs5DY;
 Tue, 23 Jan 2024 15:49:48 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TK93Y52WczXvt; Tue, 23 Jan 2024 15:49:45 +0100 (CET)
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
Subject: [PATCH 00/18] rockchip: add support for Theobroma JAGUAR
 SBC-RK3588-AMR
Date: Tue, 23 Jan 2024 15:49:08 +0100
Message-ID: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
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

This adds all the necessary bits for adding support for Theobroma's new=0D
SBC.=0D
=0D
JAGUAR is a Single-Board Computer (SBC) based around the rk3588 SoC and=0D
is targeting Autonomous Mobile Robots (AMR).=0D
=0D
It features:=0D
 * LPDDR4X (up to 16GB)=0D
 * 1Gbps Ethernet on RJ45 connector (KSZ9031 or KSZ9131)=0D
 * PCIe 3.0 4-lane on M.2 M-key connector=0D
 * PCIe 2.1 1-lane on M.2 E-key=0D
 * USB 2.0 on M.2 E-key=0D
 * 2x USB3 OTG type-c ports with DP Alt-Mode=0D
 * USB2 host port=0D
 * HDMI output=0D
 * 2x camera connectors, each exposing:=0D
   * 2-lane MIPI-CSI=0D
   * 1v2, 1v8, 2v8 power rails=0D
   * I2C bus=0D
   * GPIOs=0D
 * PPS input=0D
 * CAN=0D
 * RS485 UART=0D
 * FAN connector=0D
 * SD card slot=0D
 * eMMC (up to 256GB)=0D
 * RTC backup battery=0D
 * Companion microcontroller=0D
   * ISL1208 RTC emulation=0D
   * AMC6821 PWM emulation=0D
 * On/off buzzer control=0D
 * Secure Element=0D
 * 80-pin Mezzanine connector for daughterboards:=0D
   * GPIOs=0D
   * 1Gbps Ethernet=0D
   * PCIe 2.1 1-lane=0D
   * 2x 2-lane MIPI-CSI=0D
   * ADC channel=0D
   * I2C bus=0D
   * PWM=0D
   * UART=0D
   * SPI=0D
   * SDIO=0D
   * CAN=0D
   * I2S=0D
   * 1v8, 3v3, 5v0, dc-in (12-24V) power rails=0D
=0D
While at it, do some code cleanup and factoring out for Rockchip SoCs.=0D
=0D
This also fixes issues with the SDMMC controller on all RK3588 boards=0D
being muxed into JTAG automatically and breaking SD card support.=0D
=0D
This also binds the MMC controllers from RK3588 in U-Boot proper before=0D
relocation so that it's available for env_init(), be there any need for=0D
it (there's for Theobroma's RK3588 based products), and match all=0D
(except the RK356x family) Rockchip SoCs behavior.=0D
=0D
Special attention should be brought to the rockchip_early_misc_init_r=0D
migration for Pinephone Pro and Pinebook Pro since they now also call=0D
rockchip_setup_macaddr() which they didn't until now.=0D
=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
Heiko Stuebner (2):=0D
      rockchip: rk3588: use mainline pmu-grf compatible=0D
      rockchip: rk3588: sync rk3588s dtsi from v6.8-rc1=0D
=0D
Quentin Schulz (16):=0D
      rockchip: avoid out-of-bounds when computing cpuid=0D
      rockchip: add weak function symbol called at the beginning of misc_in=
it_r=0D
      rockchip: google: gru: migrate to rockchip_early_misc_init_r=0D
      rockchip: pine64: pinebook: migrate to rockchip_early_misc_init_r=0D
      rockchip: pine64: pinephone: migrate to rockchip_early_misc_init_r=0D
      rockchip: pine64: rockpro64: migrate to rockchip_early_misc_init_r=0D
      rockchip: theobroma-systems: puma: migrate to rockchip_early_misc_ini=
t_r=0D
      rockchip: theobroma-systems: ringneck: migrate to rockchip_early_misc=
_init_r=0D
      rockchip: merge misc.c into board.c=0D
      rockchip: transform rockchip_capsule_update_board_setup into a weak f=
unction symbol=0D
      rockchip: rk3588: fix non-working SD controller if booting from other=
 media=0D
      rockchip: rk3588: add constants for some register address spaces=0D
      rockchip: migrate hardware.h inclusion into appropriate files=0D
      rockchip: include asm/io.h directly in asm/arch-rockchip/hardware.h=0D
      rockchip: rk3588: bind MMC controllers in U-Boot proper pre-reloc=0D
      board: rockchip: add Theobroma-Systems RK3588 Jaguar SBC=0D
=0D
 arch/arm/dts/rk3588-jaguar-u-boot.dtsi             |  32 +=0D
 arch/arm/dts/rk3588-jaguar.dts                     | 803 +++++++++++++++++=
++++=0D
 arch/arm/dts/rk3588s-u-boot.dtsi                   |  40 +-=0D
 arch/arm/dts/rk3588s.dtsi                          | 152 ++++=0D
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h    |   2 +=0D
 arch/arm/include/asm/arch-rockchip/grf_rk3588.h    |  24 +=0D
 arch/arm/include/asm/arch-rockchip/hardware.h      |   2 +=0D
 arch/arm/include/asm/arch-rockchip/ioc_rk3588.h    |   6 +=0D
 arch/arm/include/asm/arch-rockchip/misc.h          |  14 -=0D
 arch/arm/mach-rockchip/Makefile                    |   1 -=0D
 arch/arm/mach-rockchip/board.c                     | 139 +++-=0D
 arch/arm/mach-rockchip/cpu-info.c                  |   1 -=0D
 arch/arm/mach-rockchip/misc.c                      | 135 ----=0D
 arch/arm/mach-rockchip/px30/px30.c                 |   1 -=0D
 arch/arm/mach-rockchip/rk3036/rk3036.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3036/sdram_rk3036.c       |   1 -=0D
 arch/arm/mach-rockchip/rk3066/rk3066.c             |   2 +-=0D
 arch/arm/mach-rockchip/rk3188/rk3188.c             |   1 -=0D
 arch/arm/mach-rockchip/rk322x/rk322x.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3288/rk3288.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3308/rk3308.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3328/rk3328.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3368/rk3368.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3399/rk3399.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3568/rk3568.c             |   1 -=0D
 arch/arm/mach-rockchip/rk3588/Kconfig              |  28 +=0D
 arch/arm/mach-rockchip/rk3588/rk3588.c             |  12 +-=0D
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c      |   2 +-=0D
 arch/arm/mach-rockchip/rv1126/rv1126.c             |   1 -=0D
 board/elgin/elgin_rv1108/elgin_rv1108.c            |   1 -=0D
 board/firefly/firefly-rk3308/roc_cc_rk3308.c       |   1 -=0D
 board/google/gru/gru.c                             |  21 +-=0D
 .../pinebook-pro-rk3399/pinebook-pro-rk3399.c      |  19 +-=0D
 .../pinephone-pro-rk3399/pinephone-pro-rk3399.c    |  18 +-=0D
 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c   |  21 +-=0D
 board/rockchip/evb_rv1108/evb_rv1108.c             |   1 -=0D
 board/theobroma-systems/jaguar_rk3588/Kconfig      |  16 +=0D
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |  12 +=0D
 board/theobroma-systems/jaguar_rk3588/Makefile     |  10 +=0D
 board/theobroma-systems/jaguar_rk3588/README       | 118 +++=0D
 .../jaguar_rk3588/jaguar_rk3588.c                  |  52 ++=0D
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  |  21 +-=0D
 .../ringneck_px30/ringneck-px30.c                  |  20 +-=0D
 board/vamrs/rock960_rk3399/rock960-rk3399.c        |   1 -=0D
 configs/jaguar-rk3588_defconfig                    | 115 +++=0D
 drivers/clk/rockchip/clk_pll.c                     |   1 -=0D
 drivers/clk/rockchip/clk_px30.c                    |   1 -=0D
 drivers/clk/rockchip/clk_rk3036.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3066.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3128.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3188.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk322x.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3288.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3308.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3328.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3368.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3399.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3568.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rk3588.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rv1108.c                  |   1 -=0D
 drivers/clk/rockchip/clk_rv1126.c                  |   1 -=0D
 drivers/gpio/rk_gpio.c                             |   1 -=0D
 drivers/net/gmac_rockchip.c                        |   1 -=0D
 drivers/ram/rockchip/dmc-rk3368.c                  |   2 +-=0D
 drivers/ram/rockchip/sdram_px30.c                  |   1 -=0D
 drivers/ram/rockchip/sdram_rk3066.c                |   1 -=0D
 drivers/ram/rockchip/sdram_rk3188.c                |   2 +-=0D
 drivers/ram/rockchip/sdram_rk322x.c                |   1 -=0D
 drivers/ram/rockchip/sdram_rk3288.c                |   2 +-=0D
 drivers/ram/rockchip/sdram_rk3399.c                |   1 -=0D
 drivers/ram/rockchip/sdram_rv1126.c                |   1 -=0D
 drivers/rng/rockchip_rng.c                         |   1 -=0D
 drivers/sysreset/sysreset_rockchip.c               |   1 -=0D
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c      |   1 -=0D
 drivers/video/rockchip/rk3288_hdmi.c               |   1 -=0D
 drivers/video/rockchip/rk3288_mipi.c               |   1 -=0D
 drivers/video/rockchip/rk3288_vop.c                |   1 -=0D
 drivers/video/rockchip/rk3399_hdmi.c               |   1 -=0D
 drivers/video/rockchip/rk3399_mipi.c               |   1 -=0D
 drivers/video/rockchip/rk3399_vop.c                |   1 -=0D
 drivers/video/rockchip/rk_edp.c                    |   1 -=0D
 drivers/video/rockchip/rk_hdmi.c                   |   1 -=0D
 drivers/video/rockchip/rk_lvds.c                   |   1 -=0D
 include/configs/jaguar_rk3588.h                    |  15 +=0D
 include/configs/rk3036_common.h                    |   1 -=0D
 include/configs/rk3066_common.h                    |   1 -=0D
 include/configs/rk3188_common.h                    |   1 -=0D
 include/configs/rk322x_common.h                    |   1 -=0D
 include/configs/rk3288_common.h                    |   1 -=0D
 include/configs/rk3368_common.h                    |   1 -=0D
 include/configs/rv1108_common.h                    |   1 -=0D
 91 files changed, 1553 insertions(+), 364 deletions(-)=0D
---=0D
base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe=0D
change-id: 20240123-jaguar-efd00e57f56c=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
