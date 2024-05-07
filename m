Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC03C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 08:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F7E88720;
	Tue,  7 May 2024 10:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="J9G2b/Aq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25A388723; Tue,  7 May 2024 10:51:49 +0200 (CEST)
Received: from mail-m15581.qiye.163.com (mail-m15581.qiye.163.com
 [101.71.155.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7018E88662
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 10:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=J9G2b/AqiggwhbE5kX/MTA6Qh0ap6SNWWlyDFhskc+m5ThVL00V/3033reFQVTZ2Q135wTJkIskr1tHB3tpGvf2J0mA3msgH8GKPHmdqIl9WM+yHOhWoS8m9KH+FLdJ9Gqkr/jcuME1GY4Z9wo89zPZmCkVc+rO77Y6wS57GTUc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=QeXNBNO6vr7TNMlExhLJmF/3bA1AB55DQo0H/9/b3oY=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4056B900359;
 Tue,  7 May 2024 16:51:40 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240507
Date: Tue,  7 May 2024 16:51:39 +0800
Message-Id: <20240507085139.35388-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5KH1ZJQ0JCTBlMShpLSxlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f52405ac803a9kunm4056b900359
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6SBw6DzNWCAtRNRw8EUkd
 TAFPCQ5VSlVKTEpOS0xKQktKS09OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTU9PTjcG
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

Please pull the updates for rockchip platform, this PR is mainly for:
- migrate to use OF_UPSTREAM for rv1108, rk3308, rk3328, rk356x, rk3588;

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/20628

Thanks,
- Kever

The following changes since commit 52835266d3e933656a217233eaf672dd9ccd7352:

  Prepare v2024.07-rc2 (2024-05-06 13:54:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240507

for you to fetch changes up to bc7cb4b67a4070129bbfc5bffb2f5e9fd206991e:

  configs: rk3588-turing-rk1: disable SPI flash by default (2024-05-07 15:56:10 +0800)

----------------------------------------------------------------
Fabio Estevam (1):
      rockchip: rv1108: Convert to OF_UPSTREAM

Jonas Karlman (58):
      rockchip: rk3399-gru: Fix max SPL size on bob and kevin
      rockchip: rk3399-puma: Update SPL_PAD_TO Kconfig option
      rockchip: rk3399-puma: Use common bss and stack addresses
      rockchip: rk3399-ficus: Enable TPL and use common bss and stack addr
      rockchip: rk3399: Sort imply statements alphabetically
      rockchip: rk3399: Enable ARMv8 crypto and FIT checksum validation
      rockchip: rk3399: Enable random generator on all boards
      rockchip: rk3399: Imply support for GbE PHY
      rockchip: rk3399: Enable DT overlay support on all boards
      rockchip: rk3399: Remove use of xPL_MISC_DRIVERS options
      rockchip: rk3399: Add a default spl-boot-order prop
      rockchip: rk3399: Remove inherited bootph-all props
      rockchip: rk3399: Sort nodes in u-boot.dtsi files
      rockchip: rk3399: Fix bootph prop for vop nodes
      rockchip: rk3399-puma: Move uart0 bootph to board u-boot.dtsi
      rockchip: rk3399: Include uart related pinctrl nodes in TPL/SPL
      rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC
      rockchip: rk3399: Configure sdmmc regulator pinctrl in SPL
      clk: rockchip: rk3399: Rename SCLK_DDRCLK to SCLK_DDRC
      clk: rockchip: rk3399: Add dummy support for ACLK_VDU clock
      clk: rockchip: rk3399: Improve support for SCLK_PCIEPHY_REF clock
      clk: rockchip: rk3399: Add SCLK_USB3OTGx_REF support
      rockchip: rk3399: Sync SoC DT from Linux kernel v6.8
      rockchip: rk3399-gru: Sync DT from Linux kernel v6.8
      rockchip: rk3399-puma: Sync DT from Linux kernel v6.8
      rockchip: rk3399-rock-pi-n10: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-eaidk-610: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-leez: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-evb: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-firefly: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-orangepi: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-roc-pc: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-nanopi-4: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-rock960: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-khadas: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-rock-pi-4: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-rockpro64: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-pinebook-pro: Sync DT from v6.8 and update defconfig
      rockchip: rk3399-pinephone-pro: Sync DT from v6.8 and update defconfig
      rockchip: rk3399: Drop ethernet0 alias from SoC u-boot.dtsi
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
      rockchip: rk3328: Add missing bootph-some-ram props
      clk: rockchip: rk3328: Add SCLK_USB3OTG_REF support

Sam Edwards (1):
      configs: rk3588-turing-rk1: disable SPI flash by default

 arch/arm/dts/Makefile                              |   88 -
 arch/arm/dts/rk3288-vmarc-som.dtsi                 |   48 +
 arch/arm/dts/rk3308-evb.dts                        |  230 --
 arch/arm/dts/rk3308-roc-cc.dts                     |  190 --
 arch/arm/dts/rk3308-rock-pi-s.dts                  |  314 --
 arch/arm/dts/rk3308.dtsi                           | 1888 -----------
 arch/arm/dts/rk3328-evb.dts                        |  289 --
 arch/arm/dts/rk3328-nanopi-r2c-plus.dts            |   33 -
 arch/arm/dts/rk3328-nanopi-r2c.dts                 |   40 -
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi         |    2 +-
 arch/arm/dts/rk3328-nanopi-r2s.dts                 |  410 ---
 .../dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi    |    7 +-
 arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts       |   42 -
 arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |    7 +-
 arch/arm/dts/rk3328-orangepi-r1-plus.dts           |  374 ---
 arch/arm/dts/rk3328-roc-cc.dts                     |  384 ---
 arch/arm/dts/rk3328-rock-pi-e.dts                  |  445 ---
 arch/arm/dts/rk3328-rock64-u-boot.dtsi             |    7 +-
 arch/arm/dts/rk3328-rock64.dts                     |  394 ---
 arch/arm/dts/rk3328-u-boot.dtsi                    |   20 +-
 arch/arm/dts/rk3328.dtsi                           | 1944 -----------
 arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi          |    1 -
 arch/arm/dts/rk3399-eaidk-610.dts                  |  939 ------
 arch/arm/dts/rk3399-evb-u-boot.dtsi                |   29 +-
 arch/arm/dts/rk3399-evb.dts                        |  484 ---
 arch/arm/dts/rk3399-ficus-u-boot.dtsi              |   12 +-
 arch/arm/dts/rk3399-ficus.dts                      |  170 -
 arch/arm/dts/rk3399-firefly-u-boot.dtsi            |    6 -
 arch/arm/dts/rk3399-firefly.dts                    |  937 ------
 arch/arm/dts/rk3399-gru-bob.dts                    |   89 -
 arch/arm/dts/rk3399-gru-chromebook.dtsi            |  400 ---
 arch/arm/dts/rk3399-gru-kevin.dts                  |  327 --
 arch/arm/dts/rk3399-gru-u-boot.dtsi                |   34 +-
 arch/arm/dts/rk3399-gru.dtsi                       |  829 -----
 arch/arm/dts/rk3399-khadas-edge-captain.dts        |   27 -
 arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi        |    7 +-
 arch/arm/dts/rk3399-khadas-edge-v.dts              |   27 -
 arch/arm/dts/rk3399-khadas-edge.dts                |   13 -
 arch/arm/dts/rk3399-khadas-edge.dtsi               |  837 -----
 arch/arm/dts/rk3399-leez-p710-u-boot.dtsi          |    6 -
 arch/arm/dts/rk3399-leez-p710.dts                  |  651 ----
 arch/arm/dts/rk3399-nanopc-t4.dts                  |  137 -
 arch/arm/dts/rk3399-nanopi-m4-2gb.dts              |   55 +-
 arch/arm/dts/rk3399-nanopi-m4.dts                  |   66 -
 arch/arm/dts/rk3399-nanopi-m4b.dts                 |   52 -
 arch/arm/dts/rk3399-nanopi-neo4.dts                |   50 -
 arch/arm/dts/rk3399-nanopi-r4s.dts                 |  133 -
 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi            |   18 +-
 arch/arm/dts/rk3399-nanopi4.dtsi                   |  761 -----
 arch/arm/dts/rk3399-op1-opp.dtsi                   |  141 -
 arch/arm/dts/rk3399-opp.dtsi                       |  133 -
 arch/arm/dts/rk3399-orangepi-u-boot.dtsi           |   12 +
 arch/arm/dts/rk3399-orangepi.dts                   |  894 -----
 arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi       |   23 +-
 arch/arm/dts/rk3399-pinebook-pro.dts               | 1121 -------
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi      |   24 +-
 arch/arm/dts/rk3399-pinephone-pro.dts              |  474 ---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi        |   37 +-
 arch/arm/dts/rk3399-puma-haikou.dts                |  276 --
 arch/arm/dts/rk3399-puma.dtsi                      |  517 ---
 arch/arm/dts/rk3399-roc-pc-mezzanine.dts           |  111 -
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi             |   31 +-
 arch/arm/dts/rk3399-roc-pc.dts                     |   12 -
 arch/arm/dts/rk3399-roc-pc.dtsi                    |  843 -----
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi       |   22 +
 arch/arm/dts/rk3399-rock-4c-plus.dts               |  708 ----
 arch/arm/dts/rk3399-rock-4se-u-boot.dtsi           |   12 +
 arch/arm/dts/rk3399-rock-4se.dts                   |   65 -
 arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi          |    6 -
 arch/arm/dts/rk3399-rock-pi-4.dtsi                 |  790 -----
 arch/arm/dts/rk3399-rock-pi-4a.dts                 |   24 -
 arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi         |    7 +
 arch/arm/dts/rk3399-rock-pi-4c.dts                 |   70 -
 arch/arm/dts/rk3399-rock960-u-boot.dtsi            |   13 +-
 arch/arm/dts/rk3399-rock960.dts                    |  156 -
 arch/arm/dts/rk3399-rock960.dtsi                   |  670 ----
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi          |   22 +-
 arch/arm/dts/rk3399-rockpro64.dts                  |   30 -
 arch/arm/dts/rk3399-rockpro64.dtsi                 |  870 -----
 arch/arm/dts/rk3399-t-opp.dtsi                     |  114 -
 arch/arm/dts/rk3399-u-boot.dtsi                    |  137 +-
 arch/arm/dts/rk3399.dtsi                           | 2714 ---------------
 arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi     |    6 -
 arch/arm/dts/rk3399pro-rock-pi-n10.dts             |   22 -
 arch/arm/dts/rk3399pro-vmarc-som.dtsi              |  467 ---
 arch/arm/dts/rk3399pro.dtsi                        |   22 -
 arch/arm/dts/rk3566-anbernic-rgxx3.dtsi            |  788 -----
 arch/arm/dts/rk3566-quartz64-a.dts                 |  838 -----
 arch/arm/dts/rk3566-quartz64-b.dts                 |  737 -----
 arch/arm/dts/rk3566-radxa-cm3-io.dts               |  281 --
 arch/arm/dts/rk3566-radxa-cm3.dtsi                 |  425 ---
 arch/arm/dts/rk3566-soquartz-blade.dts             |  198 --
 arch/arm/dts/rk3566-soquartz-cm4.dts               |  196 --
 arch/arm/dts/rk3566-soquartz-model-a.dts           |  236 --
 arch/arm/dts/rk3566-soquartz.dtsi                  |  684 ----
 arch/arm/dts/rk3566.dtsi                           |   35 -
 arch/arm/dts/rk3568-bpi-r2-pro.dts                 |  852 -----
 arch/arm/dts/rk3568-evb.dts                        |  689 ----
 arch/arm/dts/rk3568-lubancat-2.dts                 |  730 -----
 arch/arm/dts/rk3568-nanopi-r5c.dts                 |  112 -
 arch/arm/dts/rk3568-nanopi-r5s.dts                 |  136 -
 arch/arm/dts/rk3568-nanopi-r5s.dtsi                |  587 ----
 arch/arm/dts/rk3568-odroid-m1.dts                  |  741 -----
 arch/arm/dts/rk3568-pinctrl.dtsi                   | 3214 ------------------
 arch/arm/dts/rk3568-radxa-cm3i.dtsi                |  412 ---
 arch/arm/dts/rk3568-radxa-e25.dts                  |  236 --
 arch/arm/dts/rk3568-rock-3a.dts                    |  859 -----
 arch/arm/dts/rk3568-u-boot.dtsi                    |    3 +
 arch/arm/dts/rk3568.dtsi                           |  267 --
 arch/arm/dts/rk356x.dtsi                           | 1886 -----------
 arch/arm/dts/rk3588-coolpi-cm5-evb.dts             |  216 --
 arch/arm/dts/rk3588-coolpi-cm5.dtsi                |  649 ----
 arch/arm/dts/rk3588-edgeble-neu6a-io.dts           |   23 -
 arch/arm/dts/rk3588-edgeble-neu6a.dtsi             |   31 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts           |   89 -
 arch/arm/dts/rk3588-edgeble-neu6b.dtsi             |  389 ---
 arch/arm/dts/rk3588-evb1-v10.dts                   | 1080 ------
 arch/arm/dts/rk3588-generic-u-boot.dtsi            |    4 -
 arch/arm/dts/rk3588-jaguar.dts                     |  803 -----
 arch/arm/dts/rk3588-nanopc-t6.dts                  |  916 ------
 arch/arm/dts/rk3588-orangepi-5-plus.dts            |  847 -----
 arch/arm/dts/rk3588-pinctrl.dtsi                   |  516 ---
 arch/arm/dts/rk3588-quartzpro64.dts                | 1137 -------
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            |  115 +-
 arch/arm/dts/rk3588-rock-5b.dts                    |  776 -----
 arch/arm/dts/rk3588-turing-rk1.dts                 |   21 -
 arch/arm/dts/rk3588-turing-rk1.dtsi                |  612 ----
 arch/arm/dts/rk3588-u-boot.dtsi                    |   36 +-
 arch/arm/dts/rk3588.dtsi                           |  341 --
 arch/arm/dts/rk3588j.dtsi                          |    7 -
 arch/arm/dts/rk3588s-coolpi-4b.dts                 |  812 -----
 arch/arm/dts/rk3588s-orangepi-5.dts                |  667 ----
 arch/arm/dts/rk3588s-pinctrl.dtsi                  | 3447 --------------------
 arch/arm/dts/rk3588s-rock-5a.dts                   |  744 -----
 arch/arm/dts/rk3588s-u-boot.dtsi                   |   34 +-
 arch/arm/dts/rk3588s.dtsi                          | 2485 --------------
 arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi    |   21 +
 arch/arm/dts/rv1108-elgin-r1.dts                   |   59 -
 arch/arm/dts/rv1108-evb.dts                        |   79 -
 arch/arm/dts/rv1108.dtsi                           |  581 ----
 arch/arm/mach-rockchip/Kconfig                     |   42 +-
 configs/anbernic-rgxx3-rk3566_defconfig            |    1 +
 configs/bpi-r2-pro-rk3568_defconfig                |    2 +-
 configs/chromebook_bob_defconfig                   |    8 +-
 configs/chromebook_kevin_defconfig                 |    8 +-
 configs/coolpi-4b-rk3588s_defconfig                |    2 +-
 configs/coolpi-cm5-evb-rk3588_defconfig            |    2 +-
 configs/eaidk-610-rk3399_defconfig                 |   15 +-
 configs/elgin-rv1108_defconfig                     |    2 +-
 configs/evb-rk3308_defconfig                       |    2 +-
 configs/evb-rk3328_defconfig                       |    2 +-
 configs/evb-rk3399_defconfig                       |   12 +-
 configs/evb-rk3568_defconfig                       |    4 +-
 configs/evb-rk3588_defconfig                       |    2 +-
 configs/evb-rv1108_defconfig                       |    2 +-
 configs/ficus-rk3399_defconfig                     |   40 +-
 configs/firefly-rk3399_defconfig                   |   15 +-
 configs/generic-rk3568_defconfig                   |    1 +
 configs/generic-rk3588_defconfig                   |    1 +
 configs/jaguar-rk3588_defconfig                    |    2 +-
 configs/khadas-edge-captain-rk3399_defconfig       |   33 +-
 configs/khadas-edge-rk3399_defconfig               |   31 +-
 configs/khadas-edge-v-rk3399_defconfig             |   33 +-
 configs/leez-rk3399_defconfig                      |   15 +-
 configs/lubancat-2-rk3568_defconfig                |    2 +-
 configs/nanopc-t4-rk3399_defconfig                 |   16 +-
 configs/nanopc-t6-rk3588_defconfig                 |    2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig             |   23 +-
 configs/nanopi-m4-rk3399_defconfig                 |   24 +-
 configs/nanopi-m4b-rk3399_defconfig                |   24 +-
 configs/nanopi-neo4-rk3399_defconfig               |   17 +-
 configs/nanopi-r2c-plus-rk3328_defconfig           |    2 +-
 configs/nanopi-r2c-rk3328_defconfig                |    2 +-
 configs/nanopi-r2s-rk3328_defconfig                |    2 +-
 configs/nanopi-r4s-rk3399_defconfig                |   17 +-
 configs/nanopi-r5c-rk3568_defconfig                |    2 +-
 configs/nanopi-r5s-rk3568_defconfig                |    2 +-
 configs/neu6a-io-rk3588_defconfig                  |    2 +-
 configs/neu6b-io-rk3588_defconfig                  |    2 +-
 configs/odroid-m1-rk3568_defconfig                 |    2 +-
 configs/orangepi-5-plus-rk3588_defconfig           |    2 +-
 configs/orangepi-5-rk3588s_defconfig               |    2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig      |    2 +-
 configs/orangepi-r1-plus-rk3328_defconfig          |    2 +-
 configs/orangepi-rk3399_defconfig                  |   16 +-
 configs/pinebook-pro-rk3399_defconfig              |   15 +-
 configs/pinephone-pro-rk3399_defconfig             |   15 +-
 configs/pinetab2-rk3566_defconfig                  |    1 +
 configs/puma-rk3399_defconfig                      |   16 +-
 configs/quartz64-a-rk3566_defconfig                |    2 +-
 configs/quartz64-b-rk3566_defconfig                |    2 +-
 configs/quartzpro64-rk3588_defconfig               |    2 +-
 configs/radxa-cm3-io-rk3566_defconfig              |    2 +-
 configs/radxa-e25-rk3568_defconfig                 |    2 +-
 configs/roc-cc-rk3308_defconfig                    |    2 +-
 configs/roc-cc-rk3328_defconfig                    |    2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig          |   13 +-
 configs/roc-pc-rk3399_defconfig                    |   15 +-
 configs/rock-3a-rk3568_defconfig                   |    2 +-
 configs/rock-4c-plus-rk3399_defconfig              |   29 +-
 configs/rock-4se-rk3399_defconfig                  |   30 +-
 configs/rock-pi-4-rk3399_defconfig                 |   15 +-
 configs/rock-pi-4c-rk3399_defconfig                |   29 +-
 configs/rock-pi-e-rk3328_defconfig                 |    2 +-
 configs/rock-pi-n10-rk3399pro_defconfig            |   12 +-
 configs/rock-pi-s-rk3308_defconfig                 |    2 +-
 configs/rock5a-rk3588s_defconfig                   |    2 +-
 configs/rock5b-rk3588_defconfig                    |    2 +-
 configs/rock64-rk3328_defconfig                    |    2 +-
 configs/rock960-rk3399_defconfig                   |   16 +-
 configs/rockpro64-rk3399_defconfig                 |   18 +-
 configs/soquartz-blade-rk3566_defconfig            |    2 +-
 configs/soquartz-cm4-rk3566_defconfig              |    2 +-
 configs/soquartz-model-a-rk3566_defconfig          |    2 +-
 configs/toybrick-rk3588_defconfig                  |    1 +
 configs/turing-rk1-rk3588_defconfig                |   16 +-
 .../clock/rockchip,rk3399-dmc.txt                  |   42 -
 drivers/clk/rockchip/clk_rk3328.c                  |    4 +
 drivers/clk/rockchip/clk_rk3399.c                  |   67 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c          |  126 +-
 include/dt-bindings/clock/rk3308-cru.h             |  387 ---
 include/dt-bindings/clock/rk3328-cru.h             |  393 ---
 include/dt-bindings/clock/rk3399-cru.h             |  749 -----
 include/dt-bindings/clock/rk3568-cru.h             |  926 ------
 include/dt-bindings/clock/rockchip,rk3588-cru.h    |  766 -----
 include/dt-bindings/power/rk3328-power.h           |   19 -
 include/dt-bindings/power/rk3399-power.h           |   53 -
 include/dt-bindings/power/rk3568-power.h           |   32 -
 include/dt-bindings/power/rk3588-power.h           |   69 -
 include/dt-bindings/reset/rockchip,rk3588-cru.h    |  754 -----
 230 files changed, 994 insertions(+), 62636 deletions(-)
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
 delete mode 100644 arch/arm/dts/rv1108-elgin-r1.dts
 delete mode 100644 arch/arm/dts/rv1108-evb.dts
 delete mode 100644 arch/arm/dts/rv1108.dtsi
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
