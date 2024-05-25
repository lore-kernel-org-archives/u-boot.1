Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB95C25B74
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 03:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEA488571;
	Sat, 25 May 2024 05:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iuhHVK83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C150388653; Sat, 25 May 2024 05:33:03 +0200 (CEST)
Received: from mail-m17247.xmail.ntesmail.com (mail-m17247.xmail.ntesmail.com
 [45.195.17.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C71087ED1
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 05:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iuhHVK83tpXJP5RZLcYa3ab6JFeNOZds0jt0y/uiOqYvpvii1+nde8p6pHhGPX6GOjT1vBLkhEWNjiFMLmy7QHTlh/VbaoVZhZFt7bprvA1Z2nblMNk9OvG7cHJ6+OTwUx0Bp4f0hl8ITTBqQuag6gP7k0Gvyrm/DAbiutGH6QI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=eULtKCQ2BGFLF11Xhf7vs1FZdrDXb6wU/RTrXxPyr8g=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 87857900302;
 Sat, 25 May 2024 11:32:51 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240525
Date: Sat, 25 May 2024 11:32:51 +0800
Message-Id: <20240525033251.1418456-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsaSVYeSRoZQhlDHR0dHUhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fadcef14303a9kunm87857900302
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Lxw6ODNOFxZWTywKNQEI
 IRoaCg1VSlVKTEpNTUtMQkxJS01MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOT05JNwY+
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
- new board: rk3566 Powkiddy X55, rk3588s Indiedroid Nova;
- rv1126 migrate to OF_UPSTREAM;
- Fix for px30 ringneck board;
- Fix for rk3588 SPLL clock init;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/20844

Thanks,
- Kever

The following changes since commit a7f0154c412859323396111dd0c09dbafbc153cb:

  Prepare v2024.07-rc3 (2024-05-20 10:05:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240525

for you to fetch changes up to 5c7caa95982c481cc0d6a0e9997629afb0d2ce10:

  board: rockchip: Add Indiedroid Nova (2024-05-25 10:28:19 +0800)

----------------------------------------------------------------
Anand Moon (1):
      rockchip: rv1126: Migrate to OF_UPSTREAM

Chris Morgan (2):
      board: rockchip: add Powkiddy X55
      board: rockchip: Add Indiedroid Nova

Fabio Estevam (1):
      rockchip: rv1108: Remove unneeded local rv1108-cru.h

Heiko Stuebner (1):
      clk: rockchip: rk3588: Set SPLL frequency during SPL stage

Quentin Schulz (3):
      rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30 Kconfig level
      rockchip: Use common bss and stack addresses on PX30
      rockchip: ringneck_px30: Use common bss and stack addresses

 arch/arm/dts/Makefile                             |   3 -
 arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi      |   9 +
 arch/arm/dts/rv1126-edgeble-neu2-io.dts           | 112 ----
 arch/arm/dts/rv1126-edgeble-neu2.dtsi             | 345 ------------
 arch/arm/dts/rv1126-pinctrl.dtsi                  | 341 ------------
 arch/arm/dts/rv1126-sonoff-ihost.dts              |  29 -
 arch/arm/dts/rv1126-sonoff-ihost.dtsi             | 404 --------------
 arch/arm/dts/rv1126.dtsi                          | 623 ---------------------
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h   |   4 +
 arch/arm/mach-rockchip/Kconfig                    |   1 +
 arch/arm/mach-rockchip/px30/Kconfig               |   8 +-
 arch/arm/mach-rockchip/rk3568/Kconfig             |   6 +
 arch/arm/mach-rockchip/rk3588/Kconfig             |  10 +
 board/indiedroid/nova/Kconfig                     |  12 +
 board/indiedroid/nova/MAINTAINERS                 |   6 +
 board/powkiddy/x55/Kconfig                        |  15 +
 board/powkiddy/x55/MAINTAINERS                    |   7 +
 board/powkiddy/x55/Makefile                       |   6 +
 board/powkiddy/x55/x55.c                          |  39 ++
 configs/evb-px30_defconfig                        |   1 -
 configs/firefly-px30_defconfig                    |   1 -
 configs/neu2-io-rv1126_defconfig                  |   2 +-
 configs/nova-rk3588s_defconfig                    |  69 +++
 configs/odroid-go2_defconfig                      |   1 -
 configs/powkiddy-x55-rk3566_defconfig             |  58 ++
 configs/px30-core-ctouch2-of10-px30_defconfig     |   1 -
 configs/px30-core-ctouch2-px30_defconfig          |   1 -
 configs/px30-core-edimm2.2-px30_defconfig         |   1 -
 configs/ringneck-px30_defconfig                   |  19 +-
 configs/sonoff-ihost-rv1126_defconfig             |   2 +-
 doc/board/rockchip/rockchip.rst                   |   2 +
 drivers/clk/rockchip/clk_rk3588.c                 |  30 +-
 include/configs/nova-rk3588s.h                    |  15 +
 include/configs/powkiddy-x55-rk3566.h             |  12 +
 include/dt-bindings/clock/rockchip,rv1126-cru.h   | 632 ----------------------
 include/dt-bindings/clock/rv1108-cru.h            | 356 ------------
 include/dt-bindings/power/rockchip,rv1126-power.h |  35 --
 37 files changed, 310 insertions(+), 2908 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rv1126-edgeble-neu2-io.dts
 delete mode 100644 arch/arm/dts/rv1126-edgeble-neu2.dtsi
 delete mode 100644 arch/arm/dts/rv1126-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dts
 delete mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dtsi
 delete mode 100644 arch/arm/dts/rv1126.dtsi
 create mode 100644 board/indiedroid/nova/Kconfig
 create mode 100644 board/indiedroid/nova/MAINTAINERS
 create mode 100644 board/powkiddy/x55/Kconfig
 create mode 100644 board/powkiddy/x55/MAINTAINERS
 create mode 100644 board/powkiddy/x55/Makefile
 create mode 100644 board/powkiddy/x55/x55.c
 create mode 100644 configs/nova-rk3588s_defconfig
 create mode 100644 configs/powkiddy-x55-rk3566_defconfig
 create mode 100644 include/configs/nova-rk3588s.h
 create mode 100644 include/configs/powkiddy-x55-rk3566.h
 delete mode 100644 include/dt-bindings/clock/rockchip,rv1126-cru.h
 delete mode 100644 include/dt-bindings/clock/rv1108-cru.h
 delete mode 100644 include/dt-bindings/power/rockchip,rv1126-power.h
