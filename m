Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6959CE7719D
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 10:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF37801F5;
	Fri, 10 Jan 2025 11:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P3AoluZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65EE98036B; Fri, 10 Jan 2025 11:09:14 +0100 (CET)
Received: from mail-m32124.qiye.163.com (mail-m32124.qiye.163.com
 [220.197.32.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C996A800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 11:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 856632fb;
 Fri, 10 Jan 2025 18:09:00 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250110
Date: Fri, 10 Jan 2025 18:08:56 +0800
Message-Id: <20250110100856.1567840-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUJDVh1ITx5IHhpNGUpIQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a944fb0487203afkunm856632fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6Ogw5PDINOQ4qP1EOI09I
 LkgwCzhVSlVKTEhNTktITE9KTEhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpIT0hKNwY+
DKIM-Signature: a=rsa-sha256;
 b=P3AoluZfG/UzqM03wbjvJ99QE1F3q3mg1C+ps9ZCAayhs0+YYw320U9gy68h8CHVVOvZ0dfikyHgaA+mLF655ZnIPKzrH1M3c4EyDSM+ELwMaDFVILY1ezYcamRYUOdc25dKe8dfjT1BXIy85oD3wc59EACljWThE8uAivXQyEI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=xvaLoIIiviDxCIhLHCEDgf4qMffTyoBQi7uRlgB/9QE=;
 h=date:mime-version:subject:message-id:from;
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

Please pull the updates for rockchip platform:
- Add boards:
	rk3566: FriendlyARM NanoPi R3S
	rk3588s: Radxa ROCK 5C,
	rk3588: Khadas Edge2
- Migrate to OF_UPSTREAM:
	rk3066a/rk3188;
	rk3288: tinker, miqi, firefly;
- Migrate to TPL: rk3399 kevin and bob;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/24129

Thanks,
- Kever

The following changes since commit 38a371110308ebeb277e20531a7b698b7981bbfa:

  Merge tag 'tpm-master-07012025' of https://source.denx.de/u-boot/custodians/u-boot-tpm (2025-01-09 11:11:27 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250110

for you to fetch changes up to 34df868161e470e5de04db059daa90f12e824693:

  rockchip: rk3308: Implement checkboard() to print SoC variant (2025-01-10 15:17:26 +0800)

----------------------------------------------------------------
Cristian Ciocaltea (1):
      arm64: dts: rockchip: Add HDMI0 node to rk3588

Daniel Semkowicz (1):
      board: theobroma-systems: Update TF-A setup steps for RK3588 boards

FUKAUMI Naoki (3):
      arm64: dts: rockchip: add Radxa ROCK 5C
      rockchip: Add support for Radxa ROCK 5C
      rockchip: rk3399: expand space for decompressed kernel

Heiko Stuebner (1):
      clk: rockchip: rk3588: fix mask define for aclk_vop_root

Jacobe Zang (1):
      board: rockchip: add Khadas Edge2 RK3588 board

Johan Jonker (2):
      rockchip: use OF_UPSTREAM for rk3066a/rk3188
      rockchip: rk3066a/rk3188: use includes from dts/upstream

Jonas Karlman (56):
      rockchip: rk3288: Use rk3288-power.h from dts/upstream
      rockchip: clk: rk3288: Drop use of SCLK_MAC_PLL
      rockchip: rk3288: Use rk3288.dtsi from dts/upstream
      rockchip: rk3288: Fix bootph prop for vop nodes
      board: rockchip: rk3288-tinker: Add myself as reviewer to MAINTAINERS
      rockchip: rk3288-tinker: Sort u-boot.dtsi nodes alphabetically
      rockchip: rk3288-tinker: Only include required DT nodes in TPL
      rockchip: rk3288-tinker: Drop unused vcc_sd regulator from SPL
      rockchip: rk3288-tinker: Include mmc nodes in pre-reloc for env load
      rockchip: rk3288-tinker: Set cpuid and serial env var
      rockchip: rk3288-tinker: Sync defconfig options from rk3288-tinker-s
      rockchip: rk3288-tinker: Use common bss and stack addresses
      rockchip: rk3288-tinker: Drop use of silent console and late boardinfo
      rockchip: rk3288-tinker: Drop USE_PREBOOT Kconfig option
      rockchip: rk3288-tinker: Migrate to OF_UPSTREAM
      rockchip: rk3288-tinker: Fix slow Ethernet initializion
      rockchip: rk3288-tinker: Change to use FIT
      rockchip: rk3288-miqi: Sort u-boot.dtsi nodes alphabetically
      rockchip: rk3288-miqi: Remove unused work led node from xPL
      rockchip: rk3288-miqi: Set ethaddr env based on cpuid
      rockchip: rk3288-miqi: Use TPL with common bss and stack addresses
      rockchip: rk3288-miqi: Include required DT nodes in xPL
      rockchip: rk3288-miqi: Include sdmmc regulator in SPL
      rockchip: rk3288-miqi: Drop use of silent console and late boardinfo
      rockchip: rk3288-miqi: Drop USE_PREBOOT Kconfig option
      rockchip: rk3288-miqi: Migrate to OF_UPSTREAM
      rockchip: rk3288-miqi: Fix slow Ethernet initializion
      rockchip: rk3288-miqi: Change to use FIT
      rockchip: rk3288-firefly: Drop unused SPL_LED related code
      rockchip: rk3288-firefly: Sort u-boot.dtsi nodes alphabetically
      rockchip: rk3288-firefly: Set ethaddr env based on cpuid
      rockchip: rk3288-firefly: Use common bss and stack addresses
      rockchip: rk3288-firefly: Include required DT nodes in xPL
      rockchip: rk3288-firefly: Include sdmmc regulator in SPL
      rockchip: rk3288-firefly: Drop use of silent console and late boardinfo
      rockchip: rk3288-firefly: Drop USE_PREBOOT Kconfig option
      rockchip: rk3288-firefly: Migrate to OF_UPSTREAM
      rockchip: rk3288-firefly: Fix slow Ethernet initializion
      rockchip: rk3288-firefly: Change to use FIT
      rockchip: rk3399: Fix TPL build of bob and kevin
      rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in offset prop
      rockchip: rk3399-gru: Move SPI flash payload offset for bob and kevin
      rockchip: rk3399-gru: Fix include of TPL in u-boot.rom image
      rockchip: rk3399-gru: Use TPL with common bss and stack addresses
      rockchip: rk3399-gru: Include binman generated FIT in u-boot.rom image
      rockchip: rk3399: Drop common Kconfig options already implied
      rockchip: rk3399-gru: Remove unused nodes from xPL control FDT
      rockchip: rk3399-gru: Enable dcache and signature validation in SPL
      rockchip: rk3399-gru: Use SDMA mode to read from eMMC
      rockchip: rk3399-gru: Include pinctrl and regulators in SPL
      rockchip: rk3399: Drop unneeded bob and kevin board specific code
      rockchip: rk3588-nanopc-t6-lts: Add missing board -u-boot.dtsi
      rockchip: rk3399-rock-pi-4: Fix Synchronous Abort
      rockchip: rk356x: Implement checkboard() to print SoC variant
      rockchip: rk3588: Implement checkboard() to print SoC variant
      rockchip: rk3308: Implement checkboard() to print SoC variant

Paul Kocialkowski (3):
      rockchip: rk3399-roc-pc: Hook sysreset gpio to enable full reset
      rockchip: rk3399-rockpro64: Hook sysreset gpio to enable full reset
      rockchip: rk3399-rockpro64: Disable bootstage instrumentation config

Sam Edwards (1):
      arm64: dts: rockchip: Split up RK3588's PCIe pinctrls

Tianling Shen (7):
      arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
      arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
      arm64: dts: rockchip: replace deprecated snps, reset props for NanoPi R3S
      arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
      arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
      arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
      board: rockchip: add FriendlyElec NanoPi R3S

 arch/arm/dts/Makefile                              |   10 -
 arch/arm/dts/rk3066a-mk808.dts                     |  241 ---
 arch/arm/dts/rk3066a-u-boot.dtsi                   |   20 -
 arch/arm/dts/rk3066a.dtsi                          |  880 ---------
 arch/arm/dts/rk3188-radxarock.dts                  |  389 ----
 arch/arm/dts/rk3188-u-boot.dtsi                    |   17 -
 arch/arm/dts/rk3188.dtsi                           |  815 --------
 arch/arm/dts/rk3288-firefly-u-boot.dtsi            |   91 +-
 arch/arm/dts/rk3288-firefly.dts                    |   43 -
 arch/arm/dts/rk3288-firefly.dtsi                   |  491 -----
 arch/arm/dts/rk3288-miqi-u-boot.dtsi               |   83 +-
 arch/arm/dts/rk3288-miqi.dts                       |   16 -
 arch/arm/dts/rk3288-miqi.dtsi                      |  417 ----
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi           |   13 +-
 arch/arm/dts/rk3288-tinker-s.dts                   |   29 -
 arch/arm/dts/rk3288-tinker-u-boot.dtsi             |   53 +-
 arch/arm/dts/rk3288-tinker.dts                     |   33 -
 arch/arm/dts/rk3288-tinker.dtsi                    |  533 -----
 arch/arm/dts/rk3288-u-boot.dtsi                    |   13 +-
 arch/arm/dts/rk3288.dtsi                           | 2035 --------------------
 arch/arm/dts/rk3399-gru-u-boot.dtsi                |   29 +-
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi             |    8 +
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi          |    8 +
 arch/arm/dts/rk3399-u-boot.dtsi                    |   14 +-
 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi         |    8 +
 arch/arm/dts/rk356x-u-boot.dtsi                    |    4 +
 arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi      |    3 +
 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi           |   11 +
 arch/arm/dts/rk3588s-u-boot.dtsi                   |    4 +
 arch/arm/dts/rk3xxx.dtsi                           |  488 -----
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h    |    2 +-
 arch/arm/mach-rockchip/Kconfig                     |    2 +
 arch/arm/mach-rockchip/rk3288/Kconfig              |   10 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c             |   16 +
 arch/arm/mach-rockchip/rk3399/Kconfig              |   12 -
 arch/arm/mach-rockchip/rk3399/rk3399.c             |   23 +-
 arch/arm/mach-rockchip/rk3568/rk3568.c             |   61 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |   44 +
 arch/arm/mach-rockchip/rk3588/rk3588.c             |   52 +
 board/firefly/firefly-rk3288/MAINTAINERS           |    1 +
 board/firefly/firefly-rk3288/Makefile              |    7 -
 board/firefly/firefly-rk3288/firefly-rk3288.c      |   46 -
 board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS    |    3 +-
 board/khadas/khadas-edge2-rk3588s/Kconfig          |   12 +
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS      |    6 +
 board/mqmaker/miqi_rk3288/MAINTAINERS              |    1 -
 board/radxa/rock-5c-rk3588s/Kconfig                |   12 +
 board/radxa/rock-5c-rk3588s/MAINTAINERS            |    7 +
 board/radxa/rockpi4-rk3399/rockpi4-rk3399.c        |    2 +
 board/rockchip/evb_rk3568/MAINTAINERS              |    7 +
 board/rockchip/tinker_rk3288/MAINTAINERS           |    7 +-
 board/rockchip/tinker_rk3288/tinker-rk3288.c       |    2 +-
 configs/chromebook_bob_defconfig                   |   24 +-
 configs/chromebook_kevin_defconfig                 |   24 +-
 configs/firefly-rk3288_defconfig                   |   39 +-
 configs/khadas-edge2-rk3588s_defconfig             |  215 +++
 configs/miqi-rk3288_defconfig                      |   43 +-
 configs/mk808_defconfig                            |    4 +-
 configs/nanopi-r3s-rk3566_defconfig                |   75 +
 configs/rock-5c-rk3588s_defconfig                  |   84 +
 configs/rock_defconfig                             |    4 +-
 configs/rockpro64-rk3399_defconfig                 |    3 -
 configs/tinker-rk3288_defconfig                    |   41 +-
 configs/tinker-s-rk3288_defconfig                  |   38 +-
 doc/board/rockchip/rockchip.rst                    |    3 +
 doc/board/theobroma-systems/jaguar_rk3588.rst      |    6 +-
 doc/board/theobroma-systems/tiger_rk3588.rst       |    6 +-
 drivers/clk/rockchip/clk_rk3288.c                  |    8 +-
 .../src/arm64/rockchip/rk3566-nanopi-r3s.dts       |  554 ++++++
 .../src/arm64/rockchip/rk3588-base-pinctrl.dtsi    |  271 ++-
 dts/upstream/src/arm64/rockchip/rk3588-base.dtsi   |   41 +
 .../src/arm64/rockchip/rk3588s-rock-5a.dts         |    6 +-
 .../src/arm64/rockchip/rk3588s-rock-5c.dts         |  920 +++++++++
 include/configs/khadas-edge2-rk3588s.h             |   15 +
 include/configs/rk3399_common.h                    |   16 +-
 include/configs/rock-5c-rk3588s.h                  |   15 +
 include/dt-bindings/clock/rk3066a-cru.h            |   31 -
 include/dt-bindings/clock/rk3188-cru-common.h      |  261 ---
 include/dt-bindings/clock/rk3188-cru.h             |   47 -
 include/dt-bindings/power/rk3066-power.h           |   22 -
 include/dt-bindings/power/rk3188-power.h           |   24 -
 include/dt-bindings/power/rk3288-power.h           |   32 -
 82 files changed, 2760 insertions(+), 7246 deletions(-)
 delete mode 100644 arch/arm/dts/rk3066a-mk808.dts
 delete mode 100644 arch/arm/dts/rk3066a.dtsi
 delete mode 100644 arch/arm/dts/rk3188-radxarock.dts
 delete mode 100644 arch/arm/dts/rk3188.dtsi
 delete mode 100644 arch/arm/dts/rk3288-firefly.dts
 delete mode 100644 arch/arm/dts/rk3288-firefly.dtsi
 delete mode 100644 arch/arm/dts/rk3288-miqi.dts
 delete mode 100644 arch/arm/dts/rk3288-miqi.dtsi
 delete mode 100644 arch/arm/dts/rk3288-tinker-s.dts
 delete mode 100644 arch/arm/dts/rk3288-tinker.dts
 delete mode 100644 arch/arm/dts/rk3288-tinker.dtsi
 delete mode 100644 arch/arm/dts/rk3288.dtsi
 create mode 100644 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-nanopc-t6-lts-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3xxx.dtsi
 delete mode 100644 board/firefly/firefly-rk3288/Makefile
 delete mode 100644 board/firefly/firefly-rk3288/firefly-rk3288.c
 create mode 100644 board/khadas/khadas-edge2-rk3588s/Kconfig
 create mode 100644 board/khadas/khadas-edge2-rk3588s/MAINTAINERS
 create mode 100644 board/radxa/rock-5c-rk3588s/Kconfig
 create mode 100644 board/radxa/rock-5c-rk3588s/MAINTAINERS
 create mode 100644 configs/khadas-edge2-rk3588s_defconfig
 create mode 100644 configs/nanopi-r3s-rk3566_defconfig
 create mode 100644 configs/rock-5c-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-rock-5c.dts
 create mode 100644 include/configs/khadas-edge2-rk3588s.h
 create mode 100644 include/configs/rock-5c-rk3588s.h
 delete mode 100644 include/dt-bindings/clock/rk3066a-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3188-cru-common.h
 delete mode 100644 include/dt-bindings/clock/rk3188-cru.h
 delete mode 100644 include/dt-bindings/power/rk3066-power.h
 delete mode 100644 include/dt-bindings/power/rk3188-power.h
 delete mode 100644 include/dt-bindings/power/rk3288-power.h
