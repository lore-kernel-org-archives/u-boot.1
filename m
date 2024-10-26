Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6214DD10BE8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 09:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2BD88DF8;
	Sat, 26 Oct 2024 11:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XdIRhiVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A66088DF8; Sat, 26 Oct 2024 11:14:06 +0200 (CEST)
Received: from mail-m1032.netease.com (mail-m1032.netease.com [154.81.10.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F8788DB6
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 11:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [59.56.82.81])
 by smtp.qiye.163.com (Hmail) with ESMTP id f6a2261;
 Sat, 26 Oct 2024 17:13:56 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20241026
Date: Sat, 26 Oct 2024 17:13:56 +0800
Message-Id: <20241026091356.608645-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU5MVkMdSRlIGE9NQhkfSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSVVDSllXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a92c81a8fe703abkunmf6a2261
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6Cio*OTIeTBYXNzAVM1YZ
 OTkwCyNVSlVKTElCQkhPS0hMTU5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQlVOTVVDSVVDSllXWQgBWUFMQ0xLNwY+
DKIM-Signature: a=rsa-sha256;
 b=XdIRhiVrlaODXDuRK+alKXWe7NoYrvHCNONiWEcpudjadPxNDsXajVYFbqdAScWPvFanLTrXaiscaJPzZhBjau8XB6mmAOli++MROzA/lOH5zZi51qIbmNs0HV4NdeJ3fdTw4qVAacXol3LWaQRddcX2/jPhrdbxUxG2sGSyGxU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Of/eyc0ytbBwmR9Cginktz3mYcbOWxzDljaFjXZmFdw=;
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

Please pull the update for rockchip platform:
- New boards:
	rk3566: Hardkernel ODROID-M1S
	rk3588s: Hardkernel ODROID-M2
	rk3588: NanoPC-T6 LTS
- Migrate to use USB_DWC3_GENERIC for rk3328
- Other board level config and dts update

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22993

Thanks,
- Kever

The following changes since commit 08ae12be8509daf3d1c5a148b8a50c0ffb6457c2:

  Mark a few functions static inline (2024-10-24 11:21:48 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20241026

for you to fetch changes up to 7cec3e701940064b2cfc0cf8b80ff24c391c55ec:

  rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS (2024-10-26 10:46:48 +0800)

----------------------------------------------------------------
Alex Shumsky (1):
      rockchip: board: Increase rng-seed size to make it sufficient for modern Linux

Chris Morgan (4):
      board: rockchip: Convert Anbernic RGxx3 to OF_UPSTREAM
      board: rockchip: Add vdd_cpu reg fixup for RGXX3 Series
      board: rockchip: Remove ARM SCMI Support from RGxx3
      board: rockchip: Enable PD_VO before driver access

Daniel Semkowicz (1):
      rockchip: rk3399: Weaken dependency on SPL serial

FUKAUMI Naoki (3):
      arm: dts: rockchip: fix dts for Radxa ROCK 4C+
      configs: rockchip: enable gpio-leds driver for Radxa boards
      arm: dts: rockchip: turn LEDs on at boot for Radxa boards

Jonas Karlman (12):
      arm64: dts: rockchip: Add Hardkernel ODROID-M2
      board: rockchip: Add Hardkernel ODROID-M2
      rockchip: Migrate to use USB_DWC3_GENERIC on RK3328
      arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
      arm64: dts: rockchip: Add Hardkernel ODROID-M1S
      board: rockchip: Add Hardkernel ODROID-M1S
      rockchip: rk3588-rock-5b: Drop upstream props from u-boot.dtsi
      rockchip: rk3399-pinephone-pro: Drop upstream props from u-boot.dtsi
      rockchip: rk3588-nanopc-t6: Drop upstream props from u-boot.dtsi
      adc: Allow use of adc with DM_REGULATOR disabled
      adc: rockchip-saradc: Use vdd-microvolts prop as fallback
      rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS

Lukasz Czechowski (1):
      rockchip: px30: clk: add UART0 clock getter/setter

Marcin Juszkiewicz (4):
      arm64: dts: rockchip: prepare NanoPC-T6 for LTS board
      arm64: dts: rockchip: move NanoPC-T6 parts to DTS
      arm64: dts: rockchip: add NanoPC-T6 LTS
      arm64: dts: rockchip: add SPI flash on NanoPC-T6

 arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi     |   6 +
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi      |   5 -
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi       |  28 +-
 arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi          |   8 +
 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi    |  34 +
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi     |  52 --
 arch/arm/dts/rk3566-anbernic-rgxx3.dts             |  28 -
 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi         |   3 +
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi       |   8 +
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi          |  23 +
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi            |   8 +
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi          |  16 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            |  17 +-
 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi         |   3 +
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi           |   8 +
 arch/arm/include/asm/arch-rockchip/cru_px30.h      |   7 +
 arch/arm/mach-rockchip/Kconfig                     |   2 +-
 arch/arm/mach-rockchip/board.c                     |  11 +-
 arch/arm/mach-rockchip/rk3568/Kconfig              |   6 +
 arch/arm/mach-rockchip/rk3568/rk3568.c             |   6 +
 arch/arm/mach-rockchip/rk3588/Kconfig              |   7 +
 board/anbernic/rgxx3_rk3566/MAINTAINERS            |   4 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c         | 359 ++++++--
 board/friendlyelec/nanopc-t6-rk3588/Makefile       |   3 +
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c            |  59 ++
 board/hardkernel/odroid_m1s/Kconfig                |  12 +
 board/hardkernel/odroid_m1s/MAINTAINERS            |   6 +
 board/hardkernel/odroid_m2/Kconfig                 |  12 +
 board/hardkernel/odroid_m2/MAINTAINERS             |   7 +
 common/Kconfig                                     |   3 +
 configs/anbernic-rgxx3-rk3566_defconfig            |  12 +-
 configs/evb-rk3328_defconfig                       |   3 +-
 configs/nanopc-t6-rk3588_defconfig                 |  12 +
 configs/nanopi-r2c-plus-rk3328_defconfig           |   3 +-
 configs/nanopi-r2c-rk3328_defconfig                |   3 +-
 configs/nanopi-r2s-rk3328_defconfig                |   3 +-
 configs/odroid-m1s-rk3566_defconfig                |  93 ++
 configs/odroid-m2-rk3588s_defconfig                |  96 +++
 configs/orangepi-r1-plus-lts-rk3328_defconfig      |   3 +-
 configs/orangepi-r1-plus-rk3328_defconfig          |   3 +-
 configs/radxa-cm3-io-rk3566_defconfig              |   2 +
 configs/radxa-e25-rk3568_defconfig                 |   2 +
 configs/rock-3a-rk3568_defconfig                   |   2 +
 configs/rock-4c-plus-rk3399_defconfig              |   2 +
 configs/rock-4se-rk3399_defconfig                  |   2 +
 configs/rock-pi-4-rk3399_defconfig                 |   2 +
 configs/rock-pi-4c-rk3399_defconfig                |   2 +
 configs/rock-pi-e-rk3328_defconfig                 |   2 +
 configs/rock-pi-e-v3-rk3328_defconfig              |   2 +
 configs/rock5a-rk3588s_defconfig                   |   2 +
 configs/rock5b-rk3588_defconfig                    |   2 +
 doc/board/rockchip/rockchip.rst                    |   2 +
 doc/usage/environment.rst                          |   5 +
 drivers/adc/adc-uclass.c                           |   4 +-
 drivers/adc/rockchip-saradc.c                      |   9 +-
 drivers/clk/rockchip/clk_px30.c                    | 105 +++
 .../src/arm64/rockchip/rk3566-odroid-m1s.dts       | 663 +++++++++++++++
 .../src/arm64/rockchip/rk3568-odroid-m1.dts        |   2 +-
 .../src/arm64/rockchip/rk3588-nanopc-t6-lts.dts    |  60 ++
 .../src/arm64/rockchip/rk3588-nanopc-t6.dts        | 909 +-------------------
 .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi       | 943 +++++++++++++++++++++
 .../src/arm64/rockchip/rk3588s-odroid-m2.dts       | 903 ++++++++++++++++++++
 include/configs/odroid_m2.h                        |  11 +
 include/fdt_support.h                              |   3 +-
 64 files changed, 3520 insertions(+), 1103 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dts
 create mode 100644 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 create mode 100644 board/hardkernel/odroid_m1s/Kconfig
 create mode 100644 board/hardkernel/odroid_m1s/MAINTAINERS
 create mode 100644 board/hardkernel/odroid_m2/Kconfig
 create mode 100644 board/hardkernel/odroid_m2/MAINTAINERS
 create mode 100644 configs/odroid-m1s-rk3566_defconfig
 create mode 100644 configs/odroid-m2-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-odroid-m2.dts
 create mode 100644 include/configs/odroid_m2.h
