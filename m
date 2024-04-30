Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2A5C10F16
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1968889AD;
	Tue, 30 Apr 2024 17:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UBodkVZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D67889B6; Tue, 30 Apr 2024 17:31:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0FC8899F
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714491064;
 bh=gtQse0TCtgrO1HhR4/ILIvGW1lKMXLtnNpamIZGQwvg=;
 b=UBodkVZyAYKqptKIRr2pTOWpOVCsgOHhYSGpaCVBwGYlBbe5+1hUvj7aUM6TnIEoEIFJTqhcr
 9uRdrl0khbu/LzaTsJvJOY4xI6ueBG+lBhNW2j2d6IUsSWR5a873i1QsQqrhlQYLGZ2uvEW1Y2P
 nqnyIEb3c7dkrt8VwQgjJzJA550Bxf5JoXJKQUMNS1Mod/xO9PibMMhFOmPV6+Ta9WhPvlbS3WP
 d5J4AVR6ZAPKiSYNvvWSY2KZaL1WwELZw45gFlNR7HD5UeSuZXy8WHTfPcE27GwdIu7FiCVPYGq
 z7ZCctHNIZa/whpeI63OTQND4WDUOTG9yWZB88SHQeSg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 00/18] rockchip: rk3399: Fix loading FIT from SD-card when
 booting from eMMC
Date: Tue, 30 Apr 2024 15:30:07 +0000
Message-ID: <20240430153053.308788-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310eb4d99e42224315b7bc
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

This series enables use of FIT signature check for checksum validation
in SPL and fixes loading FIT from SD-card when loading FIT from eMMC or
SPI flash fails.

Changes in v2:
- Split series in two, this is the first part, second part will follow
- Split a big patch into smaller and more reviewable parts
- Change rk3399-puma to use common bss and stack addresses
- Skip UART related pinctrl nodes at pre-reloc phase to not slow down
  boot for i.e. rk3399-puma
- Rebase on latest master branch
- Collect r-b tags

I have runtime tested this series on following devices:
- 96boards Rock960
- Khadas Edge Captain
- Pine64 PineBook Pro
- Pine64 RockPro64
- Radxa ROCK 4C+
- Radxa ROCK 4SE
- Radxa ROCK Pi 4A
- Radxa ROCK Pi 4B+

Boot times before this series using rock-pi-4-rk3399:

  => bootstage report
  Timer summary in microseconds (11 records):
         Mark    Elapsed  Stage
                 204,349  SPL
      494,212    289,863  end phase
        8,637      8,637  board_init_f
    1,314,991  1,306,354  board_init_r
    3,483,389  2,168,398  eth_common_init
    3,814,525    331,136  eth_initialize
    3,814,762        237  main_loop
    3,823,030      8,268  cli_loop
  
  Accumulated time:
                  22,295  dm_spl
                 852,152  dm_f
                  60,268  dm_r

After this series the boot time have improved, mostly thanks to the use
of ARMv8 crypto, OF_LIVE and reduced clutter in FDT:

  => bootstage report
  Timer summary in microseconds (12 records):
         Mark    Elapsed  Stage
                 165,322  SPL
      419,002    253,680  end phase
        8,620      8,620  board_init_f
    1,314,364  1,305,744  board_init_r
    2,234,295    919,931  eth_common_init
    2,399,375    165,080  eth_initialize
    2,406,203      6,828  main_loop
    2,406,499        296  cli_loop
  
  Accumulated time:
                  28,365  dm_spl
                 864,210  dm_f
                  11,943  of_live
                  13,085  dm_r

After this the board still spend a long time waiting for timeout during
probe of display/hdmi driver (~1200 ms) or reading FDT during pre-reloc
phase (~600ms).

A copy of this series can be found at [1].

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-dt-sync-v2-part1

Jonas Karlman (18):
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

 arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi     |   1 -
 arch/arm/dts/rk3399-evb-u-boot.dtsi           |  26 +++--
 arch/arm/dts/rk3399-ficus-u-boot.dtsi         |  12 ++-
 arch/arm/dts/rk3399-firefly-u-boot.dtsi       |   6 --
 arch/arm/dts/rk3399-gru-u-boot.dtsi           |  24 +++++
 arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi   |   6 --
 arch/arm/dts/rk3399-leez-p710-u-boot.dtsi     |   6 --
 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi       |  14 ++-
 arch/arm/dts/rk3399-orangepi-u-boot.dtsi      |  12 +++
 arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi  |  23 ++--
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |  12 ---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi   |  25 ++---
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi        |  31 ++++--
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi  |  10 ++
 arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi     |   6 --
 arch/arm/dts/rk3399-rock960-u-boot.dtsi       |  13 ++-
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi     |  22 ++--
 arch/arm/dts/rk3399-u-boot.dtsi               | 101 +++++++++++++-----
 .../arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi |   6 --
 arch/arm/mach-rockchip/Kconfig                |  36 ++++---
 configs/chromebook_bob_defconfig              |   6 +-
 configs/chromebook_kevin_defconfig            |   6 +-
 configs/eaidk-610-rk3399_defconfig            |   2 +-
 configs/evb-rk3399_defconfig                  |   4 +-
 configs/ficus-rk3399_defconfig                |  16 +--
 configs/firefly-rk3399_defconfig              |   4 +-
 configs/khadas-edge-captain-rk3399_defconfig  |   2 +-
 configs/khadas-edge-rk3399_defconfig          |   2 +-
 configs/khadas-edge-v-rk3399_defconfig        |   2 +-
 configs/leez-rk3399_defconfig                 |   3 +-
 configs/nanopc-t4-rk3399_defconfig            |   4 +-
 configs/nanopi-m4-2gb-rk3399_defconfig        |   4 +-
 configs/nanopi-m4-rk3399_defconfig            |   4 +-
 configs/nanopi-m4b-rk3399_defconfig           |   4 +-
 configs/nanopi-neo4-rk3399_defconfig          |   4 +-
 configs/nanopi-r4s-rk3399_defconfig           |   4 +-
 configs/orangepi-rk3399_defconfig             |   4 +-
 configs/pinebook-pro-rk3399_defconfig         |   7 +-
 configs/pinephone-pro-rk3399_defconfig        |   5 +-
 configs/puma-rk3399_defconfig                 |  14 +--
 configs/roc-pc-mezzanine-rk3399_defconfig     |   4 +-
 configs/roc-pc-rk3399_defconfig               |   6 +-
 configs/rock-4c-plus-rk3399_defconfig         |   3 +-
 configs/rock-4se-rk3399_defconfig             |   5 +-
 configs/rock-pi-4-rk3399_defconfig            |   5 +-
 configs/rock-pi-4c-rk3399_defconfig           |   3 +-
 configs/rock-pi-n10-rk3399pro_defconfig       |   2 +-
 configs/rock960-rk3399_defconfig              |   4 +-
 configs/rockpro64-rk3399_defconfig            |   9 +-
 49 files changed, 298 insertions(+), 236 deletions(-)

-- 
2.43.2

