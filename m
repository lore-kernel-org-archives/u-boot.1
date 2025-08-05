Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E105CC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9F08388B;
	Tue,  5 Aug 2025 19:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C671838F0; Tue,  5 Aug 2025 19:49:06 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BA283885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 57F881F00036
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:49:02 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id AECEAB011F8; Tue,  5 Aug 2025 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 1C6F4B011E3;
 Tue,  5 Aug 2025 17:48:28 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH v2 00/11] Various V3/S3/V3s fixes and improvements
Date: Tue,  5 Aug 2025 19:48:16 +0200
Message-ID: <20250805174827.3696191-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
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

Changes since v1:
- Added a common MACH_SUN8I_V3_V3S option;
- Disabled secure RAM;
- Switched to OF_UPSTREAM;
- Added some pinmux support.
- Removed internal PHY default value;

Paul Kocialkowski (11):
  sunxi: Kconfig: Fix default order for V3s DRAM clock
  sunxi: Split V3 and V3s support with a common option
  sunxi: Disable secure SRAM on sun8i platforms missing it
  power: axp: Add default voltages for V3/S3
  sunxi: Switch V3/V3s device-tree source to OF_UPSTREAM
  sunxi: Add support for I2C1 on PB pins for the V3/V3s
  sunxi: Add support for UART1 on PG pins for the V3/S3
  sunxi: pinecube: Enable EMAC and network support
  sunxi: Add support for the Lichee Pi Zero with Dock
  net: sun8i-emac: Remove internal PHY config default value
  net: sun8i-emac: Add support for active-low leds with internal PHY

 arch/arm/cpu/armv7/Kconfig                    |   6 +-
 arch/arm/dts/Makefile                         |   5 -
 arch/arm/dts/sun8i-s3-elimo-impetus.dtsi      |  44 --
 arch/arm/dts/sun8i-s3-elimo-initium.dts       |  29 -
 arch/arm/dts/sun8i-s3-lichee-zero-plus.dts    |  53 --
 arch/arm/dts/sun8i-s3-pinecube.dts            | 228 ------
 arch/arm/dts/sun8i-v3-sl631-imx179.dts        |  12 -
 arch/arm/dts/sun8i-v3-sl631.dtsi              | 138 ----
 arch/arm/dts/sun8i-v3.dtsi                    |  63 --
 arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts   | 276 --------
 arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts | 105 ---
 arch/arm/dts/sun8i-v3s-licheepi-zero.dts      | 101 ---
 arch/arm/dts/sun8i-v3s.dtsi                   | 656 ------------------
 arch/arm/include/asm/arch-sunxi/cpu.h         |   2 +-
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h   |   2 +-
 arch/arm/mach-sunxi/Kconfig                   |  44 +-
 arch/arm/mach-sunxi/board.c                   |   6 +-
 arch/arm/mach-sunxi/cpu_info.c                |   2 +
 arch/arm/mach-sunxi/dram_sunxi_dw.c           |  18 +-
 arch/arm/mach-sunxi/spl_spi_sunxi.c           |   2 +-
 board/sunxi/board.c                           |   6 +-
 configs/Bananapi_M2_Ultra_defconfig           |   1 -
 configs/LicheePi_Zero_Dock_defconfig          |   6 +
 configs/LicheePi_Zero_defconfig               |   4 +-
 configs/bananapi_m2_berry_defconfig           |   1 -
 configs/pinecube_defconfig                    |  10 +-
 drivers/clk/sunxi/Kconfig                     |   2 +-
 drivers/net/sun8i_emac.c                      |  40 +-
 drivers/phy/allwinner/Kconfig                 |   2 +-
 drivers/pinctrl/sunxi/Kconfig                 |   2 +-
 drivers/power/Kconfig                         |  10 +-
 include/sunxi_gpio.h                          |   2 +
 32 files changed, 94 insertions(+), 1784 deletions(-)
 delete mode 100644 arch/arm/dts/sun8i-s3-elimo-impetus.dtsi
 delete mode 100644 arch/arm/dts/sun8i-s3-elimo-initium.dts
 delete mode 100644 arch/arm/dts/sun8i-s3-lichee-zero-plus.dts
 delete mode 100644 arch/arm/dts/sun8i-s3-pinecube.dts
 delete mode 100644 arch/arm/dts/sun8i-v3-sl631-imx179.dts
 delete mode 100644 arch/arm/dts/sun8i-v3-sl631.dtsi
 delete mode 100644 arch/arm/dts/sun8i-v3.dtsi
 delete mode 100644 arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts
 delete mode 100644 arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts
 delete mode 100644 arch/arm/dts/sun8i-v3s-licheepi-zero.dts
 delete mode 100644 arch/arm/dts/sun8i-v3s.dtsi
 create mode 100644 configs/LicheePi_Zero_Dock_defconfig

-- 
2.49.0

