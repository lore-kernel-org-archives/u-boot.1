Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD1FC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B301D881BF;
	Sat,  4 May 2024 21:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VXoiY3i2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0F888231; Sat,  4 May 2024 21:44:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8449F88137
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714851835;
 bh=DqVVU2H3Gb2+bU5uj7CVq4VHu/WUjRJC64vBfQYIZFg=;
 b=VXoiY3i25bwocG3hCJpCKHY/QXcXS6LCgmvBZOBVj5Jlnza6UoIZ9ffQlekYinSJMn4ST/uUZ
 TCzkzgJfqE8MAuUkZhYazJ1YUuZGqHCZR5QBXRZMgX87JaWwFX7lxLj9pBQpCVRG71co6nx1UbE
 w0MxRNolyXzE4sznpU7cjirHaqfavsyPOb1lHgUfmyCzHz8udXsAE+Rzq1lzPHDTKkIhO0t7Iq7
 ouFDJPAnDAUX6v6v2ksi4vkBxT17OZlEQuFjGQ7PQWyTF9OsszEqb5f/K00R94DdX6qJMQTUWOi
 9KLlaOr/bbxcZV/c9I0aeMOZMqbPTn3zIRPlg9/kNYAg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/16] rockchip: Migrate RK3308, RK3328,
 RK356x and RK3588 to OF_UPSTREAM
Date: Sat,  4 May 2024 19:42:52 +0000
Message-ID: <20240504194346.2462489-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66368ff92b8e4dad13276d44
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

This series migrate RK3308, RK3328, RK356x and RK3588 boards that exists
in Linux kernel v6.8 to use OF_UPSTREAM.

The usbdp phy driver is also updated to work with the DT binding that
is targeted for v6.10.

And the usb3 related nodes currently part of the SoC u-boot.dtsi is 
updated to match the soc/board DT that is targeted for v6.10 in order to
avoid breaking changes in future when dts/upstream gets updated.

Following targets has not been migrated to use OF_UPSTREAM:
- anbernic-rgxx3-rk3566: Multi device target
- generic-rk3568: Generic target only meant for U-Boot use
- generic-rk3588: Generic target only meant for U-Boot use
- nanopi-m4-2gb-rk3399: DDR3 variant of nanopi-m4-rk3399 (LPDDR3)
- pinetab2-rk3566: Merged in v6.9-rc1
- toybrick-rk3588: Merged in v6.9-rc1

This series depends on the following series:
- rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC [1]
- rockchip: rk3399: Sync DT with v6.8 and update defconfigs [2]

A copy of this series and its depends can also be found at [3].

[1] https://patchwork.ozlabs.org/cover/1929673/
[2] https://patchwork.ozlabs.org/cover/1930271/
[3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-of-upstream-v1

Jonas Karlman (16):
  rockchip: rk3308: Migrate to OF_UPSTREAM
  rockchip: rk3308: Remove redundant device tree files
  rockchip: rk3328: Migrate to OF_UPSTREAM
  rockchip: rk3328: Remove redundant device tree files
  rockchip: rk3399: Migrate to OF_UPSTREAM
  rockchip: rk3399: Remove redundant device tree files
  rockchip: rk356x: Add rk3568-u-boot.dtsi
  rockchip: rk356x: Migrate to OF_UPSTREAM
  rockchip: rk356x: Remove redundant device tree files
  phy: rockchip: usbdp: Find phy-id from the io address
  phy: rockchip: usbdp: Drop rockchip_u3phy_uboot_init()
  phy: rockchip: usbdp: Adopt driver to work with upstream DT
  rockchip: rk3588-rock-5b: Drop usb-typec node from u-boot.dtsi
  rockchip: rk3588: Update USB3 related nodes in u-boot.dtsi
  rockchip: rk3588: Migrate to OF_UPSTREAM
  rockchip: rk3588: Remove redundant device tree files

 arch/arm/dts/Makefile                         |   84 -
 arch/arm/dts/rk3308-evb.dts                   |  230 --
 arch/arm/dts/rk3308-roc-cc.dts                |  190 -
 arch/arm/dts/rk3308-rock-pi-s.dts             |  314 --
 arch/arm/dts/rk3308.dtsi                      | 1888 ---------
 arch/arm/dts/rk3328-evb.dts                   |  289 --
 arch/arm/dts/rk3328-nanopi-r2c-plus.dts       |   33 -
 arch/arm/dts/rk3328-nanopi-r2c.dts            |   40 -
 arch/arm/dts/rk3328-nanopi-r2s.dts            |  410 --
 arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts  |   42 -
 arch/arm/dts/rk3328-orangepi-r1-plus.dts      |  374 --
 arch/arm/dts/rk3328-roc-cc.dts                |  384 --
 arch/arm/dts/rk3328-rock-pi-e.dts             |  445 ---
 arch/arm/dts/rk3328-rock64.dts                |  394 --
 arch/arm/dts/rk3328.dtsi                      | 1944 ----------
 arch/arm/dts/rk3399-eaidk-610.dts             |  940 -----
 arch/arm/dts/rk3399-evb.dts                   |  485 ---
 arch/arm/dts/rk3399-ficus.dts                 |  174 -
 arch/arm/dts/rk3399-firefly.dts               |  944 -----
 arch/arm/dts/rk3399-gru-bob.dts               |   95 -
 arch/arm/dts/rk3399-gru-chromebook.dtsi       |  590 ---
 arch/arm/dts/rk3399-gru-kevin.dts             |  328 --
 arch/arm/dts/rk3399-gru.dtsi                  |  865 -----
 arch/arm/dts/rk3399-khadas-edge-captain.dts   |   31 -
 arch/arm/dts/rk3399-khadas-edge-v.dts         |   31 -
 arch/arm/dts/rk3399-khadas-edge.dts           |   13 -
 arch/arm/dts/rk3399-khadas-edge.dtsi          |  837 ----
 arch/arm/dts/rk3399-leez-p710.dts             |  653 ----
 arch/arm/dts/rk3399-nanopc-t4.dts             |  137 -
 arch/arm/dts/rk3399-nanopi-m4.dts             |   66 -
 arch/arm/dts/rk3399-nanopi-m4b.dts            |   52 -
 arch/arm/dts/rk3399-nanopi-neo4.dts           |   50 -
 arch/arm/dts/rk3399-nanopi-r4s.dts            |  133 -
 arch/arm/dts/rk3399-nanopi4.dtsi              |  762 ----
 arch/arm/dts/rk3399-op1-opp.dtsi              |  166 -
 arch/arm/dts/rk3399-opp.dtsi                  |  133 -
 arch/arm/dts/rk3399-orangepi.dts              |  896 -----
 arch/arm/dts/rk3399-pinebook-pro.dts          | 1111 ------
 arch/arm/dts/rk3399-pinephone-pro.dts         |  621 ---
 arch/arm/dts/rk3399-puma-haikou.dts           |  306 --
 arch/arm/dts/rk3399-puma.dtsi                 |  532 ---
 arch/arm/dts/rk3399-roc-pc-mezzanine.dts      |  111 -
 arch/arm/dts/rk3399-roc-pc.dts                |   12 -
 arch/arm/dts/rk3399-roc-pc.dtsi               |  844 ----
 arch/arm/dts/rk3399-rock-4c-plus.dts          |  709 ----
 arch/arm/dts/rk3399-rock-4se.dts              |   65 -
 arch/arm/dts/rk3399-rock-pi-4.dtsi            |  792 ----
 arch/arm/dts/rk3399-rock-pi-4a.dts            |   24 -
 arch/arm/dts/rk3399-rock-pi-4c.dts            |   80 -
 arch/arm/dts/rk3399-rock960.dts               |  156 -
 arch/arm/dts/rk3399-rock960.dtsi              |  673 ----
 arch/arm/dts/rk3399-rockpro64.dts             |   30 -
 arch/arm/dts/rk3399-rockpro64.dtsi            |  956 -----
 arch/arm/dts/rk3399-t-opp.dtsi                |  114 -
 arch/arm/dts/rk3399.dtsi                      | 2945 --------------
 arch/arm/dts/rk3399pro-rock-pi-n10.dts        |   22 -
 arch/arm/dts/rk3399pro-vmarc-som.dtsi         |  477 ---
 arch/arm/dts/rk3399pro.dtsi                   |   22 -
 arch/arm/dts/rk3566-anbernic-rgxx3.dtsi       |  788 ----
 arch/arm/dts/rk3566-quartz64-a.dts            |  838 ----
 arch/arm/dts/rk3566-quartz64-b.dts            |  737 ----
 arch/arm/dts/rk3566-radxa-cm3-io.dts          |  281 --
 arch/arm/dts/rk3566-radxa-cm3.dtsi            |  425 --
 arch/arm/dts/rk3566-soquartz-blade.dts        |  198 -
 arch/arm/dts/rk3566-soquartz-cm4.dts          |  196 -
 arch/arm/dts/rk3566-soquartz-model-a.dts      |  236 --
 arch/arm/dts/rk3566-soquartz.dtsi             |  684 ----
 arch/arm/dts/rk3566.dtsi                      |   35 -
 arch/arm/dts/rk3568-bpi-r2-pro.dts            |  852 ----
 arch/arm/dts/rk3568-evb.dts                   |  689 ----
 arch/arm/dts/rk3568-lubancat-2.dts            |  730 ----
 arch/arm/dts/rk3568-nanopi-r5c.dts            |  112 -
 arch/arm/dts/rk3568-nanopi-r5s.dts            |  136 -
 arch/arm/dts/rk3568-nanopi-r5s.dtsi           |  587 ---
 arch/arm/dts/rk3568-odroid-m1.dts             |  741 ----
 arch/arm/dts/rk3568-pinctrl.dtsi              | 3214 ---------------
 arch/arm/dts/rk3568-radxa-cm3i.dtsi           |  412 --
 arch/arm/dts/rk3568-radxa-e25.dts             |  236 --
 arch/arm/dts/rk3568-rock-3a.dts               |  859 ----
 arch/arm/dts/rk3568-u-boot.dtsi               |    3 +
 arch/arm/dts/rk3568.dtsi                      |  267 --
 arch/arm/dts/rk356x.dtsi                      | 1886 ---------
 arch/arm/dts/rk3588-coolpi-cm5-evb.dts        |  216 --
 arch/arm/dts/rk3588-coolpi-cm5.dtsi           |  649 ----
 arch/arm/dts/rk3588-edgeble-neu6a-io.dts      |   23 -
 arch/arm/dts/rk3588-edgeble-neu6a.dtsi        |   31 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts      |   89 -
 arch/arm/dts/rk3588-edgeble-neu6b.dtsi        |  389 --
 arch/arm/dts/rk3588-evb1-v10.dts              | 1080 ------
 arch/arm/dts/rk3588-generic-u-boot.dtsi       |    4 -
 arch/arm/dts/rk3588-jaguar.dts                |  803 ----
 arch/arm/dts/rk3588-nanopc-t6.dts             |  916 -----
 arch/arm/dts/rk3588-orangepi-5-plus.dts       |  847 ----
 arch/arm/dts/rk3588-pinctrl.dtsi              |  516 ---
 arch/arm/dts/rk3588-quartzpro64.dts           | 1137 ------
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  115 +-
 arch/arm/dts/rk3588-rock-5b.dts               |  776 ----
 arch/arm/dts/rk3588-turing-rk1.dts            |   21 -
 arch/arm/dts/rk3588-turing-rk1.dtsi           |  612 ---
 arch/arm/dts/rk3588-u-boot.dtsi               |   36 +-
 arch/arm/dts/rk3588.dtsi                      |  341 --
 arch/arm/dts/rk3588j.dtsi                     |    7 -
 arch/arm/dts/rk3588s-coolpi-4b.dts            |  812 ----
 arch/arm/dts/rk3588s-orangepi-5.dts           |  667 ----
 arch/arm/dts/rk3588s-pinctrl.dtsi             | 3447 -----------------
 arch/arm/dts/rk3588s-rock-5a.dts              |  744 ----
 arch/arm/dts/rk3588s-u-boot.dtsi              |   34 +-
 arch/arm/dts/rk3588s.dtsi                     | 2485 ------------
 arch/arm/mach-rockchip/Kconfig                |    5 +
 configs/anbernic-rgxx3-rk3566_defconfig       |    1 +
 configs/bpi-r2-pro-rk3568_defconfig           |    2 +-
 configs/chromebook_bob_defconfig              |    2 +-
 configs/chromebook_kevin_defconfig            |    2 +-
 configs/coolpi-4b-rk3588s_defconfig           |    2 +-
 configs/coolpi-cm5-evb-rk3588_defconfig       |    2 +-
 configs/eaidk-610-rk3399_defconfig            |    2 +-
 configs/evb-rk3308_defconfig                  |    2 +-
 configs/evb-rk3328_defconfig                  |    2 +-
 configs/evb-rk3399_defconfig                  |    2 +-
 configs/evb-rk3568_defconfig                  |    4 +-
 configs/evb-rk3588_defconfig                  |    2 +-
 configs/ficus-rk3399_defconfig                |    2 +-
 configs/firefly-rk3399_defconfig              |    2 +-
 configs/generic-rk3568_defconfig              |    1 +
 configs/generic-rk3588_defconfig              |    1 +
 configs/jaguar-rk3588_defconfig               |    2 +-
 configs/khadas-edge-captain-rk3399_defconfig  |    2 +-
 configs/khadas-edge-rk3399_defconfig          |    2 +-
 configs/khadas-edge-v-rk3399_defconfig        |    2 +-
 configs/leez-rk3399_defconfig                 |    2 +-
 configs/lubancat-2-rk3568_defconfig           |    2 +-
 configs/nanopc-t4-rk3399_defconfig            |    2 +-
 configs/nanopc-t6-rk3588_defconfig            |    2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig        |    1 +
 configs/nanopi-m4-rk3399_defconfig            |    2 +-
 configs/nanopi-m4b-rk3399_defconfig           |    2 +-
 configs/nanopi-neo4-rk3399_defconfig          |    2 +-
 configs/nanopi-r2c-plus-rk3328_defconfig      |    2 +-
 configs/nanopi-r2c-rk3328_defconfig           |    2 +-
 configs/nanopi-r2s-rk3328_defconfig           |    2 +-
 configs/nanopi-r4s-rk3399_defconfig           |    2 +-
 configs/nanopi-r5c-rk3568_defconfig           |    2 +-
 configs/nanopi-r5s-rk3568_defconfig           |    2 +-
 configs/neu6a-io-rk3588_defconfig             |    2 +-
 configs/neu6b-io-rk3588_defconfig             |    2 +-
 configs/odroid-m1-rk3568_defconfig            |    2 +-
 configs/orangepi-5-plus-rk3588_defconfig      |    2 +-
 configs/orangepi-5-rk3588s_defconfig          |    2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |    2 +-
 configs/orangepi-r1-plus-rk3328_defconfig     |    2 +-
 configs/orangepi-rk3399_defconfig             |    2 +-
 configs/pinebook-pro-rk3399_defconfig         |    2 +-
 configs/pinephone-pro-rk3399_defconfig        |    2 +-
 configs/pinetab2-rk3566_defconfig             |    1 +
 configs/puma-rk3399_defconfig                 |    2 +-
 configs/quartz64-a-rk3566_defconfig           |    2 +-
 configs/quartz64-b-rk3566_defconfig           |    2 +-
 configs/quartzpro64-rk3588_defconfig          |    2 +-
 configs/radxa-cm3-io-rk3566_defconfig         |    2 +-
 configs/radxa-e25-rk3568_defconfig            |    2 +-
 configs/roc-cc-rk3308_defconfig               |    2 +-
 configs/roc-cc-rk3328_defconfig               |    2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig     |    2 +-
 configs/roc-pc-rk3399_defconfig               |    2 +-
 configs/rock-3a-rk3568_defconfig              |    2 +-
 configs/rock-4c-plus-rk3399_defconfig         |    2 +-
 configs/rock-4se-rk3399_defconfig             |    2 +-
 configs/rock-pi-4-rk3399_defconfig            |    2 +-
 configs/rock-pi-4c-rk3399_defconfig           |    2 +-
 configs/rock-pi-e-rk3328_defconfig            |    2 +-
 configs/rock-pi-n10-rk3399pro_defconfig       |    2 +-
 configs/rock-pi-s-rk3308_defconfig            |    2 +-
 configs/rock5a-rk3588s_defconfig              |    2 +-
 configs/rock5b-rk3588_defconfig               |    2 +-
 configs/rock64-rk3328_defconfig               |    2 +-
 configs/rock960-rk3399_defconfig              |    2 +-
 configs/rockpro64-rk3399_defconfig            |    2 +-
 configs/soquartz-blade-rk3566_defconfig       |    2 +-
 configs/soquartz-cm4-rk3566_defconfig         |    2 +-
 configs/soquartz-model-a-rk3566_defconfig     |    2 +-
 configs/toybrick-rk3588_defconfig             |    1 +
 configs/turing-rk1-rk3588_defconfig           |    2 +-
 .../clock/rockchip,rk3399-dmc.txt             |   42 -
 drivers/phy/rockchip/phy-rockchip-usbdp.c     |  126 +-
 include/dt-bindings/clock/rk3308-cru.h        |  387 --
 include/dt-bindings/clock/rk3328-cru.h        |  393 --
 include/dt-bindings/clock/rk3399-cru.h        |  751 ----
 include/dt-bindings/clock/rk3568-cru.h        |  926 -----
 .../dt-bindings/clock/rockchip,rk3588-cru.h   |  766 ----
 include/dt-bindings/power/rk3328-power.h      |   19 -
 include/dt-bindings/power/rk3399-power.h      |   53 -
 include/dt-bindings/power/rk3568-power.h      |   32 -
 include/dt-bindings/power/rk3588-power.h      |   69 -
 .../dt-bindings/reset/rockchip,rk3588-cru.h   |  754 ----
 194 files changed, 161 insertions(+), 62287 deletions(-)
 delete mode 100644 arch/arm/dts/rk3308-evb.dts
 delete mode 100644 arch/arm/dts/rk3308-roc-cc.dts
 delete mode 100644 arch/arm/dts/rk3308-rock-pi-s.dts
 delete mode 100644 arch/arm/dts/rk3308.dtsi
 delete mode 100644 arch/arm/dts/rk3328-evb.dts
 delete mode 100644 arch/arm/dts/rk3328-nanopi-r2c-plus.dts
 delete mode 100644 arch/arm/dts/rk3328-nanopi-r2c.dts
 delete mode 100644 arch/arm/dts/rk3328-nanopi-r2s.dts
 delete mode 100644 arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
 delete mode 100644 arch/arm/dts/rk3328-orangepi-r1-plus.dts
 delete mode 100644 arch/arm/dts/rk3328-roc-cc.dts
 delete mode 100644 arch/arm/dts/rk3328-rock-pi-e.dts
 delete mode 100644 arch/arm/dts/rk3328-rock64.dts
 delete mode 100644 arch/arm/dts/rk3328.dtsi
 delete mode 100644 arch/arm/dts/rk3399-eaidk-610.dts
 delete mode 100644 arch/arm/dts/rk3399-evb.dts
 delete mode 100644 arch/arm/dts/rk3399-ficus.dts
 delete mode 100644 arch/arm/dts/rk3399-firefly.dts
 delete mode 100644 arch/arm/dts/rk3399-gru-bob.dts
 delete mode 100644 arch/arm/dts/rk3399-gru-chromebook.dtsi
 delete mode 100644 arch/arm/dts/rk3399-gru-kevin.dts
 delete mode 100644 arch/arm/dts/rk3399-gru.dtsi
 delete mode 100644 arch/arm/dts/rk3399-khadas-edge-captain.dts
 delete mode 100644 arch/arm/dts/rk3399-khadas-edge-v.dts
 delete mode 100644 arch/arm/dts/rk3399-khadas-edge.dts
 delete mode 100644 arch/arm/dts/rk3399-khadas-edge.dtsi
 delete mode 100644 arch/arm/dts/rk3399-leez-p710.dts
 delete mode 100644 arch/arm/dts/rk3399-nanopc-t4.dts
 delete mode 100644 arch/arm/dts/rk3399-nanopi-m4.dts
 delete mode 100644 arch/arm/dts/rk3399-nanopi-m4b.dts
 delete mode 100644 arch/arm/dts/rk3399-nanopi-neo4.dts
 delete mode 100644 arch/arm/dts/rk3399-nanopi-r4s.dts
 delete mode 100644 arch/arm/dts/rk3399-nanopi4.dtsi
 delete mode 100644 arch/arm/dts/rk3399-op1-opp.dtsi
 delete mode 100644 arch/arm/dts/rk3399-opp.dtsi
 delete mode 100644 arch/arm/dts/rk3399-orangepi.dts
 delete mode 100644 arch/arm/dts/rk3399-pinebook-pro.dts
 delete mode 100644 arch/arm/dts/rk3399-pinephone-pro.dts
 delete mode 100644 arch/arm/dts/rk3399-puma-haikou.dts
 delete mode 100644 arch/arm/dts/rk3399-puma.dtsi
 delete mode 100644 arch/arm/dts/rk3399-roc-pc-mezzanine.dts
 delete mode 100644 arch/arm/dts/rk3399-roc-pc.dts
 delete mode 100644 arch/arm/dts/rk3399-roc-pc.dtsi
 delete mode 100644 arch/arm/dts/rk3399-rock-4c-plus.dts
 delete mode 100644 arch/arm/dts/rk3399-rock-4se.dts
 delete mode 100644 arch/arm/dts/rk3399-rock-pi-4.dtsi
 delete mode 100644 arch/arm/dts/rk3399-rock-pi-4a.dts
 delete mode 100644 arch/arm/dts/rk3399-rock-pi-4c.dts
 delete mode 100644 arch/arm/dts/rk3399-rock960.dts
 delete mode 100644 arch/arm/dts/rk3399-rock960.dtsi
 delete mode 100644 arch/arm/dts/rk3399-rockpro64.dts
 delete mode 100644 arch/arm/dts/rk3399-rockpro64.dtsi
 delete mode 100644 arch/arm/dts/rk3399-t-opp.dtsi
 delete mode 100644 arch/arm/dts/rk3399.dtsi
 delete mode 100644 arch/arm/dts/rk3399pro-rock-pi-n10.dts
 delete mode 100644 arch/arm/dts/rk3399pro-vmarc-som.dtsi
 delete mode 100644 arch/arm/dts/rk3399pro.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
 delete mode 100644 arch/arm/dts/rk3566-quartz64-a.dts
 delete mode 100644 arch/arm/dts/rk3566-quartz64-b.dts
 delete mode 100644 arch/arm/dts/rk3566-radxa-cm3-io.dts
 delete mode 100644 arch/arm/dts/rk3566-radxa-cm3.dtsi
 delete mode 100644 arch/arm/dts/rk3566-soquartz-blade.dts
 delete mode 100644 arch/arm/dts/rk3566-soquartz-cm4.dts
 delete mode 100644 arch/arm/dts/rk3566-soquartz-model-a.dts
 delete mode 100644 arch/arm/dts/rk3566-soquartz.dtsi
 delete mode 100644 arch/arm/dts/rk3566.dtsi
 delete mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
 delete mode 100644 arch/arm/dts/rk3568-evb.dts
 delete mode 100644 arch/arm/dts/rk3568-lubancat-2.dts
 delete mode 100644 arch/arm/dts/rk3568-nanopi-r5c.dts
 delete mode 100644 arch/arm/dts/rk3568-nanopi-r5s.dts
 delete mode 100644 arch/arm/dts/rk3568-nanopi-r5s.dtsi
 delete mode 100644 arch/arm/dts/rk3568-odroid-m1.dts
 delete mode 100644 arch/arm/dts/rk3568-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/rk3568-radxa-cm3i.dtsi
 delete mode 100644 arch/arm/dts/rk3568-radxa-e25.dts
 delete mode 100644 arch/arm/dts/rk3568-rock-3a.dts
 create mode 100644 arch/arm/dts/rk3568-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3568.dtsi
 delete mode 100644 arch/arm/dts/rk356x.dtsi
 delete mode 100644 arch/arm/dts/rk3588-coolpi-cm5-evb.dts
 delete mode 100644 arch/arm/dts/rk3588-coolpi-cm5.dtsi
 delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6a-io.dts
 delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6a.dtsi
 delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6b-io.dts
 delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6b.dtsi
 delete mode 100644 arch/arm/dts/rk3588-evb1-v10.dts
 delete mode 100644 arch/arm/dts/rk3588-jaguar.dts
 delete mode 100644 arch/arm/dts/rk3588-nanopc-t6.dts
 delete mode 100644 arch/arm/dts/rk3588-orangepi-5-plus.dts
 delete mode 100644 arch/arm/dts/rk3588-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
 delete mode 100644 arch/arm/dts/rk3588-rock-5b.dts
 delete mode 100644 arch/arm/dts/rk3588-turing-rk1.dts
 delete mode 100644 arch/arm/dts/rk3588-turing-rk1.dtsi
 delete mode 100644 arch/arm/dts/rk3588.dtsi
 delete mode 100644 arch/arm/dts/rk3588j.dtsi
 delete mode 100644 arch/arm/dts/rk3588s-coolpi-4b.dts
 delete mode 100644 arch/arm/dts/rk3588s-orangepi-5.dts
 delete mode 100644 arch/arm/dts/rk3588s-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/rk3588s-rock-5a.dts
 delete mode 100644 arch/arm/dts/rk3588s.dtsi
 delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3399-dmc.txt
 delete mode 100644 include/dt-bindings/clock/rk3308-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3328-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3399-cru.h
 delete mode 100644 include/dt-bindings/clock/rk3568-cru.h
 delete mode 100644 include/dt-bindings/clock/rockchip,rk3588-cru.h
 delete mode 100644 include/dt-bindings/power/rk3328-power.h
 delete mode 100644 include/dt-bindings/power/rk3399-power.h
 delete mode 100644 include/dt-bindings/power/rk3568-power.h
 delete mode 100644 include/dt-bindings/power/rk3588-power.h
 delete mode 100644 include/dt-bindings/reset/rockchip,rk3588-cru.h

-- 
2.43.2

