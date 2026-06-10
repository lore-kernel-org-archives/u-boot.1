Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E99CCD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 15:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8159284928;
	Wed, 10 Jun 2026 17:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gghcam3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD398493F; Wed, 10 Jun 2026 17:06:08 +0200 (CEST)
Received: from mail-m9341.xmail.ntesmail.com (mail-m9341.xmail.ntesmail.com
 [103.126.93.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B618491C
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 17:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41ddc4f6b;
 Wed, 10 Jun 2026 23:05:56 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20260610
Date: Wed, 10 Jun 2026 23:05:56 +0800
Message-ID: <20260610150556.20064-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb211922d09cckunmfaaf550150d928
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEIeVh0ZGkhKSkoeGEMdTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=gghcam3fp1SsZMoGt2zG18Dy/D4rE/XhcCsjDiy14Abgrd38ykoxjeRFESiI6UVnbu01X5zO6hfGI8whX1MGtJG/MevCa30KmbmHg8hiGKvTWqtI0MCW3F20Vh/ugZXhpqfnQke+tzMT3iXNGf7MxedQgnxoalbfMc0qVXXVrE0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=5WqRo7hCp/wjRWqqfjFubLqjyZhQqvizrxlaD16DhuY=;
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
- New Board support: rk3588 FriendlyElec NanoPi R76S;
- UFS boot from SPL for rk3576 (NanoPi M5, ROCK 4D);
- Clock support for RK3576 GMAC 25MHz output and RK3528/RK3576 USB3 OTG;
- Switch rk3128/rk3229 boards to upstream devicetree;
- MAINTAINERS update for upstream devicetree references;
- rk3588-rock-5b: Remove USB-C controller from u-boot.dtsi;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/30398

Thanks,
- Kever

The following changes since commit 75daa277941702bf58c88d65c0cb6ed962899d9e:

  Merge tag 'u-boot-imx-master-20260604' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-06-04 18:56:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20260610

for you to fetch changes up to 22fa81fd8cce908ecc7e93b55ec4e8df8507779b:

  rockchip: MAINTAINERS: upstream devicetree update (2026-06-10 00:19:05 +0800)

----------------------------------------------------------------
Alexey Charkov (4):
      reset: rockchip: make device resets available in SPL
      rockchip: spl: Add support for booting from UFS
      rockchip: rk3576-nanopi-m5: Enable UFS support
      rockchip: clk: clk_rk3576: Add support for RK3576 GMAC 25MHz clock output

Johan Jonker (3):
      rockchip: Switch rk3128 boards to upstream devicetree
      rockchip: Switch rk3229 boards to upstream devicetree
      rockchip: MAINTAINERS: upstream devicetree update

Jonas Karlman (5):
      clk: rockchip: rk3528: Add CLK_REF_USB3OTG support
      clk: rockchip: rk3576: Add CLK_REF_USB3OTGx support
      rockchip: rk3588-rock-5b: Remove USB-C controller from u-boot.dtsi
      board: rockchip: Add FriendlyElec NanoPi R76S
      rockchip: rk3576-rock-4d: Enable UFS support

 arch/arm/dts/Makefile                             |    6 -
 arch/arm/dts/rk3128-evb.dts                       |   99 --
 arch/arm/dts/rk3128.dtsi                          |  780 -------------
 arch/arm/dts/rk3229-evb.dts                       |  256 ----
 arch/arm/dts/rk3229.dtsi                          |   52 -
 arch/arm/dts/rk322x.dtsi                          | 1293 ---------------------
 arch/arm/dts/rk3576-u-boot.dtsi                   |   33 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi           |   43 +-
 arch/arm/include/asm/arch-rockchip/bootrom.h      |    1 +
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h   |   14 +
 arch/arm/mach-rockchip/Kconfig                    |    2 +
 arch/arm/mach-rockchip/rk3576/MAINTAINERS         |    6 +
 arch/arm/mach-rockchip/rk3576/rk3576.c            |    1 +
 arch/arm/mach-rockchip/spl-boot-order.c           |   14 +
 board/edgeble/neural-compute-module-6/MAINTAINERS |    8 +-
 board/hardkernel/odroid_m1/MAINTAINERS            |    3 +-
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |    2 +-
 board/pine64/quartz64_rk3566/MAINTAINERS          |   21 +-
 board/pine64/quartzpro64-rk3588/MAINTAINERS       |    3 +-
 board/radxa/rock5a-rk3588s/MAINTAINERS            |    3 +-
 board/rockchip/evb_rk3229/MAINTAINERS             |    1 -
 board/rockchip/evb_rk3328/MAINTAINERS             |   14 +-
 board/rockchip/evb_rk3399/MAINTAINERS             |    7 +-
 board/rockchip/evb_rk3568/MAINTAINERS             |   38 +-
 board/rockchip/evb_rk3588/MAINTAINERS             |   21 +-
 board/rockchip/toybrick_rk3588/MAINTAINERS        |    3 +-
 board/turing/turing-rk1-rk3588/MAINTAINERS        |    4 +-
 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |    2 +-
 configs/evb-rk3128_defconfig                      |    4 +-
 configs/evb-rk3229_defconfig                      |    4 +-
 configs/nanopi-m5-rk3576_defconfig                |    7 +
 configs/nanopi-r76s-rk3576_defconfig              |   60 +
 configs/rock-4d-rk3576_defconfig                  |    7 +
 doc/board/rockchip/rockchip.rst                   |    1 +
 drivers/clk/rockchip/clk_rk3528.c                 |    2 +
 drivers/clk/rockchip/clk_rk3576.c                 |   54 +
 drivers/reset/Kconfig                             |    9 +
 drivers/reset/Makefile                            |    2 +-
 include/dt-bindings/clock/rk3128-cru.h            |  273 -----
 include/dt-bindings/clock/rk3228-cru.h            |  287 -----
 40 files changed, 253 insertions(+), 3187 deletions(-)
 delete mode 100644 arch/arm/dts/rk3128-evb.dts
 delete mode 100644 arch/arm/dts/rk3128.dtsi
 delete mode 100644 arch/arm/dts/rk3229-evb.dts
 delete mode 100644 arch/arm/dts/rk3229.dtsi
 delete mode 100644 arch/arm/dts/rk322x.dtsi
 create mode 100644 configs/nanopi-r76s-rk3576_defconfig
 delete mode 100644 include/dt-bindings/clock/rk3128-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3228-cru.h
