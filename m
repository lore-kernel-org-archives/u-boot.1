Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5633FC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35A082F75;
	Tue,  8 Apr 2025 00:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="a069grIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E218782E86; Tue,  8 Apr 2025 00:47:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B2E82E9A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1744066075;
 bh=6JgBVj1ecarjYBYCW8PEUBzarEExdnISclTKKmDXDek=;
 b=a069grIufswaUYQa3+CnZawscoHWXb9OG1okLdfcH9f04it68ysIvoYURUlgkF4qYTO5dTZV/
 zvHEf9mvAacoa72qPI8+Odjku7gP+g5Kzx/uMLILMleuLOQmrB5YZjTwR+EmGFEBTJuV5FdwB41
 zDp7DAWZ60tR0JnO84pUBj4gdH5BjRAQ5dy2Edsae5LtD3a2K/2D8vb1/fMrylF9aM1qBr28SlK
 vN01FAaBIPUmbhxYpjLgvXTLDkW0PTQp7vxAXTRbl6nL6bchEu2FrUdRrw9SvaEvgNYKVfKtIQj
 96frpgCXunYRyQ9HYrOJwxEvErDaCUqdgqTwAiAB91pQ==
X-Forward-Email-ID: 67f456139fd75b9b96512730
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/30] rockchip: Add initial support for RK3528
Date: Mon,  7 Apr 2025 22:46:33 +0000
Message-ID: <20250407224743.2423921-1-jonas@kwiboo.se>
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

This series add initial support for the Rockchip RK3528 SoC.

Clk, pinctrl and rng drivers have been imported from vendor U-Boot with
minor adjustments and fixes.

Upstream DT for RK3528 is now more complete and this series only add a
few missing nodes to -u-boot.dtsi files to have a bootable system.

Changes in v2:
- Pick device tree commits from devicetree-rebasing v6.15-rc1-dts
- Update clk and reset driver to work with mainline Linux dt-bindings
- Add RK3528 support in otp, saradc, inno-usb2 and dwc_eth_qos drivers

Features tested on a ArmSoM Sige1:
- SD-card boot
- eMMC boot

Features tested on a FriendlyElec NanoPi Zero2:
- SD-card boot
- eMMC boot

Features tested on a Radxa E20C v1.104:
- SD-card boot
- eMMC boot

Features tested on a Radxa ROCK 2A v1.202:
- SD-card boot

Boot log on a Radxa ROCK 2A:

  DDR 44ec2e0a51 huan.he 24/07/12-14:38:48,fwver: v1.10
  [...]
  out
  
  U-Boot SPL 2025.04-rc5 (Apr 07 2025 - 21:08:38 +0000)
  Trying to boot from MMC2
  ## Checking hash(es) for config config-1 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-1 ... sha256+ OK
  ## Checking hash(es) for Image atf-2 ... sha256+ OK
  ## Checking hash(es) for Image atf-3 ... sha256+ OK
  INFO:    Preloader serial: 0
  NOTICE:  BL31: v2.3():v2.3-857-g059b3c586:derrick.huang, fwver: v1.18
  NOTICE:  BL31: Built : 17:43:24, Nov 18 2024
  INFO:    rk_otp_init finish!
  INFO:    ARM GICv2 driver initialized
  INFO:    nonboot_cpus_off: clst_st=0xc0e, core_st=0xe1e0 boot_cpu=0
  INFO:    dfs DDR fsp_param[0].freq_mhz= 1056MHz
  INFO:    dfs DDR fsp_param[1].freq_mhz= 324MHz
  INFO:    dfs DDR fsp_param[2].freq_mhz= 528MHz
  INFO:    dfs DDR fsp_param[3].freq_mhz= 780MHz
  INFO:    idle_st=0x0, pd_st=0x0
  INFO:    Using opteed sec cpu_context!
  INFO:    boot cpu mask: 1
  INFO:    rk_otp_init finish!
  INFO:    RK3528 SoC (0x101)
  INFO:    BL31: Initializing runtime services
  WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
  ERROR:   Error initializing runtime service opteed_fast
  INFO:    BL31: Preparing for EL3 exit to normal world
  INFO:    Entry point address = 0x800000
  INFO:    SPSR = 0x3c9
  
  
  U-Boot 2025.04-rc5 (Apr 07 2025 - 21:08:38 +0000)
  
  Model: Generic RK3528
  SoC:   RK3528A
  DRAM:  4 GiB (effective 3.9 GiB)
  Core:  130 devices, 20 uclasses, devicetree: separate
  MMC:   mmc@ffbf0000: 0, mmc@ffc30000: 1
  Loading Environment from nowhere... OK
  In:    serial@ff9f0000
  Out:   serial@ff9f0000
  Err:   serial@ff9f0000
  Hit any key to stop autoboot:  0
  =>

This series depends on the following series:
- rockchip: ROCKCHIP_COMMON_STACK_ADDR improvements
- rockchip: Update rng compatible for RK356x and RK3588

Chukun Pan (2):
  arm64: dts: rockchip: Add rk3528 QoS register node
  arm64: dts: rockchip: enable SCMI clk for RK3528 SoC

Jonas Karlman (21):
  arm64: dts: rockchip: Add pinctrl and gpio nodes for RK3528
  arm64: dts: rockchip: Add SARADC node for RK3528
  arm64: dts: rockchip: Add SDHCI controller for RK3528
  arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
  arm64: dts: rockchip: Add leds node to Radxa E20C
  arm64: dts: rockchip: Add user button to Radxa E20C
  arm64: dts: rockchip: Add maskrom button to Radxa E20C
  arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
  ram: rockchip: Add basic support for RK3528
  arm: dts: rockchip: Add rk3528-u-boot.dtsi
  arch: arm: rockchip: Add initial support for RK3528
  mmc: rockchip_sdhci: Extend variant configuration
  mmc: rockchip_sdhci: Add initial support for RK3528
  mmc: rockchip_sdhci: Gate clock for glitch free phase switching
  rockchip: otp: Add support for RK3528
  adc: rockchip-saradc: Add support for RK3528
  phy: rockchip-inno-usb2: Add support for clkout_ctl_phy
  phy: rockchip-inno-usb2: Add support for RK3528
  net: dwc_eth_qos_rockchip: Add support for RK3528
  board: rockchip: Add minimal generic RK3528 board
  board: rockchip: Add Radxa E20C

Joseph Chen (1):
  clk: rockchip: Add support for RK3528

Lin Jinhan (1):
  rng: rockchip: Add support for rkrng variant

Steven Liu (1):
  pinctrl: rockchip: Add support for RK3528

Yao Zi (3):
  dt-bindings: clock: Document clock and reset unit of RK3528
  arm64: dts: rockchip: Add clock generators for RK3528 SoC
  arm64: dts: rockchip: Add UART clocks for RK3528 SoC

Yifeng Zhao (1):
  rockchip: mkimage: Add support for RK3528

 arch/arm/dts/rk3528-generic-u-boot.dtsi       |   12 +
 arch/arm/dts/rk3528-generic.dts               |   31 +
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi    |   12 +
 arch/arm/dts/rk3528-u-boot.dtsi               |  148 ++
 arch/arm/include/asm/arch-rk3528/boot0.h      |    9 +
 arch/arm/include/asm/arch-rk3528/gpio.h       |    9 +
 arch/arm/include/asm/arch-rockchip/clock.h    |   17 +
 .../include/asm/arch-rockchip/cru_rk3528.h    |  388 ++++
 arch/arm/mach-rockchip/Kconfig                |   51 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rk3528/Kconfig         |   15 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS     |   11 +
 arch/arm/mach-rockchip/rk3528/Makefile        |    5 +
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |   16 +
 arch/arm/mach-rockchip/rk3528/rk3528.c        |  137 ++
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c |   19 +
 arch/arm/mach-rockchip/sdram.c                |    3 +-
 configs/generic-rk3528_defconfig              |   40 +
 configs/radxa-e20c-rk3528_defconfig           |   56 +
 doc/board/rockchip/rockchip.rst               |   13 +
 drivers/adc/rockchip-saradc.c                 |   10 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_pll.c                |   23 +-
 drivers/clk/rockchip/clk_rk3528.c             | 1754 +++++++++++++++++
 drivers/misc/rockchip-otp.c                   |    4 +
 drivers/mmc/rockchip_sdhci.c                  |   39 +-
 drivers/net/dwc_eth_qos.c                     |    4 +
 drivers/net/dwc_eth_qos_rockchip.c            |  138 ++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   63 +-
 drivers/pinctrl/rockchip/Makefile             |    1 +
 drivers/pinctrl/rockchip/pinctrl-rk3528.c     |  273 +++
 drivers/ram/rockchip/Makefile                 |    1 +
 drivers/ram/rockchip/sdram_rk3528.c           |   33 +
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/rst-rk3528.c                    |  302 +++
 drivers/rng/rockchip_rng.c                    |   73 +
 drivers/usb/gadget/Kconfig                    |    1 +
 .../Bindings/clock/rockchip,rk3528-cru.yaml   |   64 +
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  453 +++++
 .../dt-bindings/reset/rockchip,rk3528-cru.h   |  241 +++
 .../src/arm64/rockchip/rk3528-pinctrl.dtsi    | 1397 +++++++++++++
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts  |  133 ++
 dts/upstream/src/arm64/rockchip/rk3528.dtsi   |  378 +++-
 include/configs/rk3528_common.h               |   38 +
 tools/rkcommon.c                              |    1 +
 45 files changed, 6398 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/dts/rk3528-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-generic.dts
 create mode 100644 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-rk3528/boot0.h
 create mode 100644 arch/arm/include/asm/arch-rk3528/gpio.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3528.h
 create mode 100644 arch/arm/mach-rockchip/rk3528/Kconfig
 create mode 100644 arch/arm/mach-rockchip/rk3528/MAINTAINERS
 create mode 100644 arch/arm/mach-rockchip/rk3528/Makefile
 create mode 100644 arch/arm/mach-rockchip/rk3528/clk_rk3528.c
 create mode 100644 arch/arm/mach-rockchip/rk3528/rk3528.c
 create mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
 create mode 100644 configs/generic-rk3528_defconfig
 create mode 100644 configs/radxa-e20c-rk3528_defconfig
 create mode 100644 drivers/clk/rockchip/clk_rk3528.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3528.c
 create mode 100644 drivers/ram/rockchip/sdram_rk3528.c
 create mode 100644 drivers/reset/rst-rk3528.c
 create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3528-cru.yaml
 create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3528-cru.h
 create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3528-cru.h
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-pinctrl.dtsi
 create mode 100644 include/configs/rk3528_common.h

-- 
2.49.0

