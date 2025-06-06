Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB8AC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1932A828F8;
	Sat,  7 Jun 2025 00:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0BC82998; Sat,  7 Jun 2025 00:46:11 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F46826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DF329B4C34CA;
 Sat,  7 Jun 2025 00:46:07 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 0/7] Hex value prefix case cleanup
Date: Fri,  6 Jun 2025 15:44:55 -0700
Message-ID: <20250606224558.1117422-1-e@freeshell.de>
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

Make consistent use of lowercase hexadecimal prefix '0x' throughout U-Boot.

There are a few remaining uses of uppercase 'X' to denote hexadecimal prefix
or placeholder in documentation and error messages.

External devicetree-rebasing dts/upstream and the generated code of
xilinx/zynq are ignored for the series.

E Shattow (7):
  configs: use lowercase hex prefix style
  board: use lowercase hex prefix style
  drivers: use lowercase hex prefix style
  tools: use lowercase hex prefix style
  lib: use lowercase hex prefix style
  arch: use lowercase hex prefix style
  include: use lowercase hex prefix style

 arch/arm/dts/fsl-imx8qxp-ai_ml.dts            | 16 +++---
 arch/arm/dts/hi3660.dtsi                      |  2 +-
 arch/arm/dts/imx7-colibri.dtsi                |  2 +-
 .../asm/arch-fsl-layerscape/immap_lsch3.h     |  2 +-
 arch/arm/include/asm/arch-mx6/mx6sl_pins.h    |  8 +--
 arch/arm/include/asm/arch-rockchip/cru_px30.h |  6 +--
 .../arm/include/asm/arch-rockchip/f_rockusb.h |  2 +-
 .../include/asm/arch-rockchip/sdram_px30.h    |  2 +-
 .../include/asm/arch-rockchip/sdram_rk3328.h  |  2 +-
 .../include/asm/arch-rockchip/sdram_rv1126.h  |  2 +-
 arch/arm/include/asm/iproc-common/sysmap.h    | 20 ++++----
 arch/arm/mach-at91/include/mach/at91_wdt.h    |  2 +-
 arch/arm/mach-exynos/include/mach/dsim.h      |  2 +-
 arch/arm/mach-imx/iomux-v3.c                  |  2 +-
 .../mach-keystone/include/mach/hardware-k2g.h |  4 +-
 arch/arm/mach-kirkwood/include/mach/mpp.h     |  2 +-
 arch/arm/mach-omap2/lowlevel_init.S           |  2 +-
 arch/arm/mach-sc5xx/init/dmcinit.c            |  2 +-
 .../include/mach/clock_manager_s10.h          |  6 +--
 arch/arm/mach-uniphier/bcu/bcu-ld4.c          |  2 +-
 arch/arm/mach-zynqmp/include/mach/hardware.h  |  2 +-
 arch/mips/mach-jz47xx/jz4780/pll.c            |  2 +-
 arch/powerpc/include/asm/immap_85xx.h         |  6 +--
 arch/powerpc/include/asm/processor.h          |  4 +-
 board/freescale/common/qixis.h                |  4 +-
 board/gateworks/gw_ventana/gw_ventana_spl.c   | 28 +++++------
 board/kontron/sl-mx6ul/spl.c                  |  2 +-
 configs/am62x_evm_r5_ethboot_defconfig        |  2 +-
 configs/starfive_visionfive2_defconfig        |  2 +-
 drivers/ata/dwc_ahsata_priv.h                 |  4 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c       |  2 +-
 drivers/clk/stm32/clk-stm32mp1.c              |  2 +-
 drivers/ddr/altera/iossm_mailbox.c            |  2 +-
 drivers/mmc/sdhci-cadence6.c                  |  2 +-
 drivers/mmc/zynq_sdhci.c                      |  2 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |  4 +-
 drivers/net/fsl-mc/mc.c                       |  2 +-
 drivers/net/phy/ca_phy.c                      |  2 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     |  2 +-
 drivers/power/regulator/act8846.c             |  4 +-
 drivers/ram/k3-ddrss/k3-ddrss.c               |  2 +-
 drivers/ram/octeon/octeon3_lmc.c              |  2 +-
 drivers/sound/max98088.h                      | 50 +++++++++----------
 drivers/sound/max98095.h                      |  2 +-
 drivers/video/bridge/dp501.c                  |  2 +-
 drivers/video/hx8238d.c                       |  2 +-
 drivers/video/zynqmp/zynqmp_dpsub.h           |  2 +-
 include/fsl_esdhc.h                           |  2 +-
 include/fsl_esdhc_imx.h                       |  2 +-
 include/mc13892.h                             |  2 +-
 .../external/mbedtls/library/ecp_curves_new.c | 46 ++++++++---------
 tools/Kconfig                                 |  2 +-
 52 files changed, 142 insertions(+), 142 deletions(-)


base-commit: b3f69c14187d413610abbc2b82d1a3752cb342c1
-- 
2.49.0

