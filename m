Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC97C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D9E828BC;
	Thu,  8 May 2025 09:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HCX+GTCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C335828F8; Thu,  8 May 2025 09:30:02 +0200 (CEST)
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com
 [220.197.32.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F9D82A65
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 145aec9c1;
 Thu, 8 May 2025 15:29:53 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250508
Date: Thu,  8 May 2025 15:29:51 +0800
Message-Id: <20250508072951.538794-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0tJVkNNT0hMGUIdTUtLT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96aecd02b303afkunm145aec9c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6ECo4SDJDIw8ZTBgPSTA6
 Di4KCT5VSlVKTE9NTUNCSEJPSkJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUxOT0M3Bg++
DKIM-Signature: a=rsa-sha256;
 b=HCX+GTCarOaxS/LAyHuIJrMlkN894xoPX3f0j6fYIsM7eFrHCX4pGTlelmbRtlSwlob3DnnT6P9g0FvHRRHJ6uJH6mVwloGy3qIxn5o6ecJ6CcEgDqdb8SeT2Y4vl6hw4fUz5SkGvLFYeve5JFfq00+I36yEgNCWpC9RjCByiNk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=MrkmPdoocNbtbvxkLVRNy6XoTof5DPahjtpzaMcRhow=;
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
- New Board support: rk3566 LCKFB TaishanPi, rk3588 Xunlong Orange Pi 5 Max;
- Add rk3288 rmii support;
- pinctrl driver fix;
- binman description update;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/26117

Thanks,
- Kever

The following changes since commit 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541:

  fs: exfat: Inhibit unused exfat_humanize_bytes() and exfat_print_info() (2025-05-05 14:19:20 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250508

for you to fetch changes up to 115a0cb9a28e0e85c9bf8680c537f087e3b15abc:

  net: gmac_rockchip: Add RMII support for rk3288 (2025-05-08 11:48:13 +0800)

----------------------------------------------------------------
Chen-Yu Tsai (1):
      rockchip: io-domain: Enable by default for all supported SoCs

Christoph Fritz (2):
      rockchip: rk3288: grf: Unify speed/flowctrl fields for clarity
      net: gmac_rockchip: Add RMII support for rk3288

Heiko Stuebner (1):
      configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS for px30 to rk3308/etc

Ilya Katsnelson (1):
      board: rockchip: add Xunlong Orange Pi 5 Max

Jiehui He (1):
      board: rockchip: Add LCKFB TaishanPi RK3566 Board

Jonas Karlman (2):
      rockchip: Add SPL_PAD_TO Kconfig default value
      rockchip: binman: Support use of crc32 hash for FIT images

Quentin Schulz (15):
      rockchip: rk3399: do not generate u-boot.rom anymore
      rockchip: rk3288: do not generate u-boot.rom anymore
      pinctrl: rockchip: fix bank's pin_base computing
      pinctrl: rockchip: constify rockchip_pin_ctrl for PX30
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3036
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3066
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3128
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3188
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3228
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3288
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3308
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3328
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3368
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3399
      pinctrl: rockchip: constify rockchip_pin_ctrl for RV1108

Simon Glass (5):
      rockchip: binman: Correct the OS prop for U-Boot
      rockchip: binman: Factor out arch and compression
      rockchip: binman: Create a template for the FIT
      rockchip: binman: Un-indent the FIT template
      rockchip: binman: Include a compatible string in each configuration

 arch/arm/dts/rk3288-u-boot.dtsi                  |  24 --
 arch/arm/dts/rk3288-veyron-u-boot.dtsi           |   8 +
 arch/arm/dts/rk3399-gru-u-boot.dtsi              |   4 +-
 arch/arm/dts/rk3399-u-boot.dtsi                  |  35 ---
 arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi       |  11 +
 arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi   |  20 ++
 arch/arm/dts/rockchip-u-boot.dtsi                | 291 ++++++++++++-----------
 arch/arm/include/asm/arch-rockchip/grf_rk3288.h  |  16 +-
 arch/arm/mach-rockchip/rk3288/Kconfig            |   5 -
 arch/arm/mach-rockchip/rk3399/Kconfig            |   2 -
 board/rockchip/evb_rk3568/MAINTAINERS            |   6 +
 board/rockchip/evb_rk3588/MAINTAINERS            |   6 +
 common/spl/Kconfig                               |   1 +
 configs/chromebook_bob_defconfig                 |   1 -
 configs/chromebook_kevin_defconfig               |   1 -
 configs/eaidk-610-rk3399_defconfig               |   1 -
 configs/evb-rk3399_defconfig                     |   1 +
 configs/ficus-rk3399_defconfig                   |   1 -
 configs/firefly-rk3399_defconfig                 |   1 -
 configs/khadas-edge-captain-rk3399_defconfig     |   1 -
 configs/khadas-edge-rk3399_defconfig             |   1 -
 configs/khadas-edge-v-rk3399_defconfig           |   1 -
 configs/lckfb-tspi-rk3566_defconfig              |  78 ++++++
 configs/leez-rk3399_defconfig                    |   1 -
 configs/nanopc-t4-rk3399_defconfig               |   1 -
 configs/nanopi-m4-2gb-rk3399_defconfig           |   1 -
 configs/nanopi-m4-rk3399_defconfig               |   1 -
 configs/nanopi-m4b-rk3399_defconfig              |   1 -
 configs/nanopi-neo4-rk3399_defconfig             |   1 -
 configs/nanopi-r4s-rk3399_defconfig              |   1 -
 configs/orangepi-5-max-rk3588_defconfig          |  89 +++++++
 configs/orangepi-rk3399_defconfig                |   1 -
 configs/pinebook-pro-rk3399_defconfig            |   1 -
 configs/pinephone-pro-rk3399_defconfig           |   1 -
 configs/puma-rk3399_defconfig                    |   1 -
 configs/ringneck-px30_defconfig                  |   1 -
 configs/roc-pc-mezzanine-rk3399_defconfig        |   1 -
 configs/roc-pc-rk3399_defconfig                  |   1 -
 configs/rock-4c-plus-rk3399_defconfig            |   1 -
 configs/rock-4se-rk3399_defconfig                |   1 -
 configs/rock-pi-4-rk3399_defconfig               |   1 -
 configs/rock-pi-4c-rk3399_defconfig              |   1 -
 configs/rock-pi-n10-rk3399pro_defconfig          |   1 -
 configs/rock-pi-s-rk3308_defconfig               |   1 -
 configs/rock-s0-rk3308_defconfig                 |   1 -
 configs/rock960-rk3399_defconfig                 |   1 -
 configs/rockpro64-rk3399_defconfig               |   1 -
 doc/board/rockchip/rockchip.rst                  |   2 +
 drivers/misc/Kconfig                             |   6 +-
 drivers/net/gmac_rockchip.c                      |  69 ++++--
 drivers/pinctrl/rockchip/pinctrl-px30.c          |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3036.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3066.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3128.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3188.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk322x.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3288.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3308.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3328.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3368.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3399.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3568.c        |   1 -
 drivers/pinctrl/rockchip/pinctrl-rk3588.c        |   1 -
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c |   5 +-
 drivers/pinctrl/rockchip/pinctrl-rockchip.h      |   1 -
 drivers/pinctrl/rockchip/pinctrl-rv1108.c        |   2 +-
 drivers/pinctrl/rockchip/pinctrl-rv1126.c        |   1 -
 include/configs/px30_common.h                    |  12 +-
 68 files changed, 469 insertions(+), 281 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
 create mode 100644 configs/lckfb-tspi-rk3566_defconfig
 create mode 100644 configs/orangepi-5-max-rk3588_defconfig
