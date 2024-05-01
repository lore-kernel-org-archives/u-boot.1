Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C49C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594CF88B62;
	Wed,  1 May 2024 18:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rDz0ss2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49D488B62; Wed,  1 May 2024 18:23:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502AF88B89
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714580595;
 bh=RWO2bItd37nNWTFSrtLrH2+nAXYC0tAOr08ICCTymTA=;
 b=rDz0ss2yP5XsaCyyavUx7OeiY/rHkK4agfSpkxLeCNFKU7Ynr3Yn9EE3PbU28O8X7sthogmCz
 UkaTvjKGZuxDvaBpBiKKEdY86B+7BgCGVCWvaB+fHpSu2qP3KuHOhKBnIDlYVuF5KVozAu2EAkK
 qHT3Ac6FZ5RvODLh52CwGTADO+d0hsw4LRfCrLF3fIOQpj430YdOwAOhshqDsOwMPfgujtmd5oS
 uNfiT9XW6fIblK893BA+OR0ls9DvFBM2Ja2bSBK4DhP3MMl3CMalGT5OQWeAtILGn7g0CN0HtU+
 VxWDqJt5XajzI3s1Svy0Wxb3Nb71zTw5RnmgT47qSYRQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 00/22] rockchip: rk3399: Sync DT with v6.8 and update
 defconfigs
Date: Wed,  1 May 2024 16:22:17 +0000
Message-ID: <20240501162308.875193-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66326c713e72fadc559db881
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

This series adds support for new clocks used in Linux kernel v6.8 DTs,
sync device trees with v6.8 and updates board defconfigs to enable
common features that is known to be working on RK3399 boards.

A follow up series will be sent that fully move RK3399 and a few other
RK SoCs that recently synced DTs to v6.8 to use OF_UPSTREAM.

Changes in v2:
- Split series in two, this is the second part
- Implement partial instead of dummy support for SCLK_PCIEPHY_REF
- Temporarily add ethernet0 alias to rk3399-u-boot.dtsi
- Keep dfi node for all boot phases
- Only enable AHCI/SCSI on boards that have PCIe slot or board vendor
  sell a SATA HAT
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

Boot times after this series using rock-pi-4-rk3399:

  => bootstage report
  Timer summary in microseconds (12 records):
         Mark    Elapsed  Stage
                 172,783  SPL
      434,458    261,675  end phase
        8,810      8,810  board_init_f
    1,381,128  1,372,318  board_init_r
    2,304,264    923,136  eth_common_init
    2,472,339    168,075  eth_initialize
    2,479,534      7,195  main_loop
    2,479,847        313  cli_loop
  
  Accumulated time:
                  29,672  dm_spl
                 893,082  dm_f
                  12,854  of_live
                  13,792  dm_r

This series depends on the following series:
- rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC [1]

A copy of this series and its depend can be found at [2]

[1] https://patchwork.ozlabs.org/cover/1929673/
[2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-dt-sync-v2-part2

Jonas Karlman (22):
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

 arch/arm/dts/rk3288-vmarc-som.dtsi            |  48 +++
 arch/arm/dts/rk3399-eaidk-610.dts             |   3 +-
 arch/arm/dts/rk3399-evb-u-boot.dtsi           |  11 +-
 arch/arm/dts/rk3399-evb.dts                   |   3 +-
 arch/arm/dts/rk3399-ficus.dts                 |   4 +
 arch/arm/dts/rk3399-firefly.dts               |  17 +-
 arch/arm/dts/rk3399-gru-bob.dts               |   8 +-
 arch/arm/dts/rk3399-gru-chromebook.dtsi       | 200 +++++++++++-
 arch/arm/dts/rk3399-gru-kevin.dts             |   3 +-
 arch/arm/dts/rk3399-gru-u-boot.dtsi           |  10 +-
 arch/arm/dts/rk3399-gru.dtsi                  |  52 +++-
 arch/arm/dts/rk3399-khadas-edge-captain.dts   |   4 +
 arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi   |   5 +
 arch/arm/dts/rk3399-khadas-edge-v.dts         |   4 +
 arch/arm/dts/rk3399-khadas-edge.dtsi          |  10 +-
 arch/arm/dts/rk3399-leez-p710.dts             |   8 +-
 arch/arm/dts/rk3399-nanopc-t4.dts             |   2 +-
 arch/arm/dts/rk3399-nanopi-m4-2gb.dts         |  55 +---
 arch/arm/dts/rk3399-nanopi-m4b.dts            |   2 +-
 arch/arm/dts/rk3399-nanopi-r4s.dts            |   4 +-
 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi       |   4 +
 arch/arm/dts/rk3399-nanopi4.dtsi              |   7 +-
 arch/arm/dts/rk3399-op1-opp.dtsi              |  31 +-
 arch/arm/dts/rk3399-opp.dtsi                  |   6 +-
 arch/arm/dts/rk3399-orangepi.dts              |  12 +-
 arch/arm/dts/rk3399-pinebook-pro.dts          |  24 +-
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |  12 +
 arch/arm/dts/rk3399-pinephone-pro.dts         | 147 +++++++++
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi   |  16 +-
 arch/arm/dts/rk3399-puma-haikou.dts           |  42 ++-
 arch/arm/dts/rk3399-puma.dtsi                 |  17 +-
 arch/arm/dts/rk3399-roc-pc.dtsi               |  15 +-
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi  |  12 +
 arch/arm/dts/rk3399-rock-4c-plus.dts          |   1 +
 arch/arm/dts/rk3399-rock-4se-u-boot.dtsi      |  12 +
 arch/arm/dts/rk3399-rock-pi-4.dtsi            |   4 +-
 arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi    |   7 +
 arch/arm/dts/rk3399-rock-pi-4c.dts            |  10 +
 arch/arm/dts/rk3399-rock960.dtsi              |   5 +-
 arch/arm/dts/rk3399-rockpro64.dtsi            |  98 +++++-
 arch/arm/dts/rk3399-u-boot.dtsi               |  54 ++--
 arch/arm/dts/rk3399.dtsi                      | 289 ++++++++++++++++--
 arch/arm/dts/rk3399pro-vmarc-som.dtsi         |  20 +-
 .../dts/rockchip-radxa-dalang-carrier.dtsi    |  21 ++
 configs/eaidk-610-rk3399_defconfig            |  11 +-
 configs/evb-rk3399_defconfig                  |   6 +-
 configs/ficus-rk3399_defconfig                |  22 +-
 configs/firefly-rk3399_defconfig              |   9 +-
 configs/khadas-edge-captain-rk3399_defconfig  |  29 +-
 configs/khadas-edge-rk3399_defconfig          |  27 +-
 configs/khadas-edge-v-rk3399_defconfig        |  29 +-
 configs/leez-rk3399_defconfig                 |  10 +-
 configs/nanopc-t4-rk3399_defconfig            |  10 +-
 configs/nanopi-m4-2gb-rk3399_defconfig        |  18 +-
 configs/nanopi-m4-rk3399_defconfig            |  18 +-
 configs/nanopi-m4b-rk3399_defconfig           |  18 +-
 configs/nanopi-neo4-rk3399_defconfig          |  11 +-
 configs/nanopi-r4s-rk3399_defconfig           |  11 +-
 configs/orangepi-rk3399_defconfig             |  10 +-
 configs/pinebook-pro-rk3399_defconfig         |   6 +-
 configs/pinephone-pro-rk3399_defconfig        |   8 +-
 configs/roc-pc-mezzanine-rk3399_defconfig     |   7 +-
 configs/roc-pc-rk3399_defconfig               |   7 +-
 configs/rock-4c-plus-rk3399_defconfig         |  24 +-
 configs/rock-4se-rk3399_defconfig             |  23 +-
 configs/rock-pi-4-rk3399_defconfig            |   8 +
 configs/rock-pi-4c-rk3399_defconfig           |  24 +-
 configs/rock-pi-n10-rk3399pro_defconfig       |   8 +-
 configs/rock960-rk3399_defconfig              |  10 +-
 configs/rockpro64-rk3399_defconfig            |   7 +-
 drivers/clk/rockchip/clk_rk3399.c             |  67 +++-
 include/dt-bindings/clock/rk3399-cru.h        |  30 +-
 72 files changed, 1462 insertions(+), 325 deletions(-)

-- 
2.43.2

