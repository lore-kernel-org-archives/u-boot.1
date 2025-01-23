Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEB6C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9753B80243;
	Thu, 23 Jan 2025 23:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MCckHi4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43454806DC; Thu, 23 Jan 2025 23:48:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA8B80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1737672533;
 bh=5XZ8E4msbtkV2d8dlotnF9uKKxqm0StDGKXDWzjtyJ0=;
 b=MCckHi4+mVzw1Ki/rvDaJ19O/ma/gUrK84Ot3R4RtN1665/oDi4DmUwl4YPrhzHN8XUeCQLb3
 Zm+bKV3e5XWSI9VoRALZKKD3Uns5tK6Uzr6SbNfyV2p8jm0tUcaSJsGHWOakiOzpD0OjRJxBt5b
 IiOP63bTc5ROtRGpaCZBdUbqjkUDkUa96hnBYcWzUkfGer97XuH5F2X3M0PmLNB65cEvMTngMNr
 cfK26KAdYRlkXNrLZ8+c2acxQbWIX11UTE8KzUyygzTw6Gh8XmbkCPGafPdyEljUXE0wGOEEYwN
 gJOIkCj8oz3RmRYQgghCnfLOmgS7fFietPUTz2QcyyeQ==
X-Forward-Email-ID: 6792c751f07771e5c89e0104
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/13] rockchip: Add initial support for RK3528
Date: Thu, 23 Jan 2025 22:48:12 +0000
Message-ID: <20250123224844.3104592-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

Upstream DT for RK3528 is at a very basic state at the moment and this
series instead add a few missing nodes to -u-boot.dtsi files to have
a bootable system.

Features tested on a ArmSoM Sige1:
- SD-card boot
- eMMC boot

Features tested on a Radxa E20C v1.104:
- SD-card boot
- eMMC boot

Features tested on a Radxa ROCK 2A v1.202:
- SD-card boot

Boot log on a ArmSoM Sige1:

  DDR 44ec2e0a51 huan.he 24/07/12-14:38:48,fwver: v1.10
  [...]
  out
  
  U-Boot SPL 2025.01 (Jan 23 2025 - 20:16:33 +0000)
  Trying to boot from MMC1
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
  INFO:    Entry point address = 0x200000
  INFO:    SPSR = 0x3c9
  
  
  U-Boot 2025.01 (Jan 23 2025 - 20:16:33 +0000)
  
  Model: Generic RK3528
  SoC:   RK3528A
  DRAM:  2 GiB
  Core:  98 devices, 20 uclasses, devicetree: separate
  MMC:   mmc@ffbf0000: 0, mmc@ffc30000: 1
  Loading Environment from nowhere... OK
  In:    serial@ff9f0000
  Out:   serial@ff9f0000
  Err:   serial@ff9f0000
  Hit any key to stop autoboot:  0
  =>

This series depends on the pending merge of devicetree-rebasing
v6.13-dts tag.

Jonas Karlman (8):
  arch: arm: rockchip: Add initial support for RK3528
  ram: rockchip: Add basic support for RK3528
  mmc: rockchip_sdhci: Extend variant configuration
  mmc: rockchip_sdhci: Add initial support for RK3528
  mmc: rockchip_sdhci: Gate clock for glitch free phase switching
  arm: dts: rockchip: Add rk3528-u-boot.dtsi
  board: rockchip: Add minimal generic RK3528 board
  board: rockchip: Add Radxa E20C

Joseph Chen (2):
  clk: rockchip: Add support for RK3528
  arm: dts: rockchip: Add rk3528-pinctrl.dtsi

Lin Jinhan (1):
  rng: rockchip: Add support for rkrng variant

Steven Liu (1):
  pinctrl: rockchip: Add support for RK3528

Yifeng Zhao (1):
  rockchip: mkimage: Add support for RK3528

 arch/arm/dts/rk3528-generic-u-boot.dtsi       |   31 +
 arch/arm/dts/rk3528-generic.dts               |   20 +
 arch/arm/dts/rk3528-pinctrl.dtsi              | 1397 +++++++++++++
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi    |   31 +
 arch/arm/dts/rk3528-u-boot.dtsi               |  249 +++
 arch/arm/include/asm/arch-rk3528/boot0.h      |    9 +
 arch/arm/include/asm/arch-rk3528/gpio.h       |    9 +
 arch/arm/include/asm/arch-rockchip/clock.h    |    7 +
 .../include/asm/arch-rockchip/cru_rk3528.h    |  388 ++++
 arch/arm/mach-rockchip/Kconfig                |   50 +
 arch/arm/mach-rockchip/Makefile               |    1 +
 arch/arm/mach-rockchip/rk3528/Kconfig         |   15 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS     |   11 +
 arch/arm/mach-rockchip/rk3528/Makefile        |    5 +
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |   16 +
 arch/arm/mach-rockchip/rk3528/rk3528.c        |  104 +
 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c |   19 +
 arch/arm/mach-rockchip/sdram.c                |    3 +-
 configs/generic-rk3528_defconfig              |   39 +
 configs/radxa-e20c-rk3528_defconfig           |   35 +
 doc/board/rockchip/rockchip.rst               |   13 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_pll.c                |   23 +-
 drivers/clk/rockchip/clk_rk3528.c             | 1744 +++++++++++++++++
 drivers/mmc/rockchip_sdhci.c                  |   39 +-
 drivers/pinctrl/rockchip/Makefile             |    1 +
 drivers/pinctrl/rockchip/pinctrl-rk3528.c     |  292 +++
 drivers/ram/rockchip/Makefile                 |    1 +
 drivers/ram/rockchip/sdram_rk3528.c           |   33 +
 drivers/rng/rockchip_rng.c                    |   73 +
 include/configs/rk3528_common.h               |   42 +
 include/dt-bindings/clock/rk3528-cru.h        |  751 +++++++
 tools/rkcommon.c                              |    1 +
 33 files changed, 5443 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/dts/rk3528-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-generic.dts
 create mode 100644 arch/arm/dts/rk3528-pinctrl.dtsi
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
 create mode 100644 include/configs/rk3528_common.h
 create mode 100644 include/dt-bindings/clock/rk3528-cru.h

-- 
2.48.1

