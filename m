Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C339CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1398988417;
	Thu,  4 Apr 2024 14:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712232502;
	bh=nuKOKjKI/c9r1fXxDbuIxScBsmIKz03AkwPfI89vsXE=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YTDm/IGsuTFR+de0ElBASGulZ4DEeGGxJ2IqUWROwdJEuON7PlFArp0WXEd046Dny
	 tUqnLY7ygL3a9Dgg0rwfU6bvWqjutKArzY6NsVhWNdb2joFt9MQdnIqcMuBlgg4oxU
	 xH3axg1yNNk0E2CKMGCTJ7zs26BhRyd9tx2TTZxe0JNJEIJhCZ4BpCC5kc3JDdewF1
	 82Pi14sqqNHyIekDhngJJI4xunqhg1ikA96uvz1UFmOpHgSMXxSa3/e6l+ZivW3XV3
	 TW3Ki8HZVVVZXwXIXiKUKjGXEias3ORmse3LAc9VFxXRf5PjvVq5g2/HxXopl5aIUL
	 xeOYU2qrcWgjQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A68E88444; Thu,  4 Apr 2024 14:08:21 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B634287842
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 14:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V9L403C3sz9sRW;
 Thu,  4 Apr 2024 14:08:16 +0200 (CEST)
Message-ID: <5f2e055c-bc20-471d-8b98-90807f1dba0c@denx.de>
Date: Thu, 4 Apr 2024 14:08:15 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tom,

please pull the first batch of mostly Marvell related patches:

----------------------------------------------------------------
- kirkwood: Switch to using upstream dts/dtsi files (Tony)
- mvebu: Turris Omnia - New board revision support (Marek)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=343&view=results

Thanks,
Stefan

The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea1a:

   Merge tag 'u-boot-dfu-next-20240402' of 
https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-04-02 22:37:23 
-0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 53bdcd1e9eacd6992d990b288fd6d48f43d94a0b:

   arm: mvebu: turris_omnia: Enable rng command in defconfig (2024-04-04 
10:45:27 +0200)

----------------------------------------------------------------
Marek Behún (18):
       arm: mvebu: turris_omnia: Enable LTO by default on Turris Omnia
       arm: mvebu: turris_omnia: Add header containing MCU command 
interface and use it
       arm: mvebu: turris_{omnia, mox}: Don't print model two times
       arm: mvebu: turris_omnia: Update MCU status and features reading
       arm: mvebu: turris_omnia: Implement getting board information 
from MCU
       arm: mvebu: turris_omnia: Print board ECDSA public key if available
       arm: mvebu: turris_omnia: Disable Atmel SHA node if not present
       arm: mvebu: spl: Do not build mvebu-reset in SPL
       arm: mvebu: system-controller: Rework to use UCLASS_SYSCON
       arm: mvebu: system-controller: Select mvebu-reset if DM_RESET && 
PCI_MVEBU
       arm: mvebu: system-controller: Add support for SYSRESET
       gpio: turris_omnia_mcu: Use byteorder conversion functions
       gpio: turris_omnia_mcu: Update firmware features reading
       gpio: turris_omnia_mcu: Add support for system power off via sysreset
       arm: mvebu: turris_omnia: Enable poweroff command via sysreset in 
defconfig
       cmd: rng: Print "Abort" on -EINTR
       misc: turris_omnia_mcu: Add support for rng provided by MCU
       arm: mvebu: turris_omnia: Enable rng command in defconfig

Tony Dinh (2):
       arm: dts: kirkwood: Enable upstream DT on Kirkwood boards
       arm: dts: kirkwood: Remove DTS files for Kirkwood boards

  arch/arm/dts/Makefile                          |  28 +-
  arch/arm/dts/kirkwood-6192.dtsi                |  88 ---
  arch/arm/dts/kirkwood-6281.dtsi                |  90 ---
  arch/arm/dts/kirkwood-6282.dtsi                | 161 -----
  arch/arm/dts/kirkwood-98dx4122.dtsi            |  53 --
  arch/arm/dts/kirkwood-blackarmor-nas220.dts    | 172 -----
  arch/arm/dts/kirkwood-d2net.dts                |  45 --
  arch/arm/dts/kirkwood-dns325.dts               |  63 --
  arch/arm/dts/kirkwood-dnskw.dtsi               | 235 -------
  arch/arm/dts/kirkwood-dockstar.dts             | 110 ----
  arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi    |   7 +
  arch/arm/dts/kirkwood-dreamplug.dts            | 131 ----
  arch/arm/dts/kirkwood-ds109.dts                |  40 --
  arch/arm/dts/kirkwood-goflexnet.dts            | 190 ------
  arch/arm/dts/kirkwood-guruplug-server-plus.dts | 133 ----
  arch/arm/dts/kirkwood-ib62x0.dts               | 146 -----
  arch/arm/dts/kirkwood-iconnect.dts             | 195 ------
  arch/arm/dts/kirkwood-is2.dts                  |  40 --
  arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi      |   6 +-
  arch/arm/dts/kirkwood-lschlv2.dts              |  20 -
  arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi        |   6 +-
  arch/arm/dts/kirkwood-lsxhl.dts                |  20 -
  arch/arm/dts/kirkwood-lsxl.dtsi                | 241 -------
  arch/arm/dts/kirkwood-net2big.dts              |  63 --
  arch/arm/dts/kirkwood-netxbig.dtsi             | 232 -------
  arch/arm/dts/kirkwood-ns2-common.dtsi          |  97 ---
  arch/arm/dts/kirkwood-ns2.dts                  |  40 --
  arch/arm/dts/kirkwood-ns2lite.dts              |  35 -
  arch/arm/dts/kirkwood-ns2max.dts               |  59 --
  arch/arm/dts/kirkwood-ns2mini.dts              |  60 --
  arch/arm/dts/kirkwood-nsa310s.dts              | 319 ---------
  arch/arm/dts/kirkwood-nsa325-u-boot.dtsi       |   7 +
  arch/arm/dts/kirkwood-nsa325.dts               | 231 -------
  arch/arm/dts/kirkwood-nsa3x0-common.dtsi       | 157 -----
  arch/arm/dts/kirkwood-openrd-base.dts          |  39 --
  arch/arm/dts/kirkwood-openrd-client.dts        |  73 ---
  arch/arm/dts/kirkwood-openrd-ultimate.dts      |  55 --
  arch/arm/dts/kirkwood-openrd.dtsi              | 122 ----
  arch/arm/dts/kirkwood-pogo_e02.dts             | 132 ----
  arch/arm/dts/kirkwood-pogoplug-series-4.dts    | 180 ------
  arch/arm/dts/kirkwood-sheevaplug-common.dtsi   | 104 ---
  arch/arm/dts/kirkwood-sheevaplug.dts           |  42 --
  arch/arm/dts/kirkwood-synology.dtsi            | 855 
-------------------------
  arch/arm/dts/kirkwood.dtsi                     | 393 ------------
  arch/arm/mach-kirkwood/Kconfig                 |   2 +
  arch/arm/mach-mvebu/Kconfig                    |  25 +
  arch/arm/mach-mvebu/Makefile                   |   3 +-
  arch/arm/mach-mvebu/cpu.c                      |   2 +
  arch/arm/mach-mvebu/system-controller.c        | 145 ++++-
  board/CZ.NIC/turris_atsha_otp.c                |  27 +-
  board/CZ.NIC/turris_common.c                   |  42 ++
  board/CZ.NIC/turris_common.h                   |  10 +
  board/CZ.NIC/turris_mox/turris_mox.c           |   5 +-
  board/CZ.NIC/turris_omnia/Makefile             |   2 +-
  board/CZ.NIC/turris_omnia/turris_omnia.c       | 310 ++++++---
  cmd/rng.c                                      |   7 +-
  configs/SBx81LIFKW_defconfig                   |   1 +
  configs/SBx81LIFXCAT_defconfig                 |   1 +
  configs/d2net_v2_defconfig                     |   2 +-
  configs/dns325_defconfig                       |   2 +-
  configs/dockstar_defconfig                     |   2 +-
  configs/dreamplug_defconfig                    |   2 +-
  configs/ds109_defconfig                        |   2 +-
  configs/goflexhome_defconfig                   |   2 +-
  configs/guruplug_defconfig                     |   2 +-
  configs/ib62x0_defconfig                       |   2 +-
  configs/iconnect_defconfig                     |   2 +-
  configs/inetspace_v2_defconfig                 |   2 +-
  configs/lschlv2_defconfig                      |   2 +-
  configs/lsxhl_defconfig                        |   2 +-
  configs/nas220_defconfig                       |   2 +-
  configs/net2big_v2_defconfig                   |   2 +-
  configs/netspace_lite_v2_defconfig             |   2 +-
  configs/netspace_max_v2_defconfig              |   2 +-
  configs/netspace_mini_v2_defconfig             |   2 +-
  configs/netspace_v2_defconfig                  |   2 +-
  configs/nsa310s_defconfig                      |   2 +-
  configs/nsa325_defconfig                       |   2 +-
  configs/openrd_base_defconfig                  |   2 +-
  configs/openrd_client_defconfig                |   2 +-
  configs/openrd_ultimate_defconfig              |   2 +-
  configs/pogo_e02_defconfig                     |   2 +-
  configs/pogo_v4_defconfig                      |   2 +-
  configs/sheevaplug_defconfig                   |   2 +-
  configs/turris_omnia_defconfig                 |   6 +
  drivers/gpio/Kconfig                           |   7 -
  drivers/gpio/Makefile                          |   1 -
  drivers/gpio/turris_omnia_mcu.c                | 316 ---------
  drivers/misc/Kconfig                           |  11 +
  drivers/misc/Makefile                          |   1 +
  drivers/misc/turris_omnia_mcu.c                | 411 ++++++++++++
  include/turris-omnia-mcu-interface.h           | 248 +++++++
  92 files changed, 1150 insertions(+), 6000 deletions(-)
  delete mode 100644 arch/arm/dts/kirkwood-6192.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-6281.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-6282.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-98dx4122.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-blackarmor-nas220.dts
  delete mode 100644 arch/arm/dts/kirkwood-d2net.dts
  delete mode 100644 arch/arm/dts/kirkwood-dns325.dts
  delete mode 100644 arch/arm/dts/kirkwood-dnskw.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-dockstar.dts
  create mode 100644 arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-dreamplug.dts
  delete mode 100644 arch/arm/dts/kirkwood-ds109.dts
  delete mode 100644 arch/arm/dts/kirkwood-goflexnet.dts
  delete mode 100644 arch/arm/dts/kirkwood-guruplug-server-plus.dts
  delete mode 100644 arch/arm/dts/kirkwood-ib62x0.dts
  delete mode 100644 arch/arm/dts/kirkwood-iconnect.dts
  delete mode 100644 arch/arm/dts/kirkwood-is2.dts
  delete mode 100644 arch/arm/dts/kirkwood-lschlv2.dts
  delete mode 100644 arch/arm/dts/kirkwood-lsxhl.dts
  delete mode 100644 arch/arm/dts/kirkwood-lsxl.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-net2big.dts
  delete mode 100644 arch/arm/dts/kirkwood-netxbig.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-ns2-common.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-ns2.dts
  delete mode 100644 arch/arm/dts/kirkwood-ns2lite.dts
  delete mode 100644 arch/arm/dts/kirkwood-ns2max.dts
  delete mode 100644 arch/arm/dts/kirkwood-ns2mini.dts
  delete mode 100644 arch/arm/dts/kirkwood-nsa310s.dts
  create mode 100644 arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-nsa325.dts
  delete mode 100644 arch/arm/dts/kirkwood-nsa3x0-common.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-openrd-base.dts
  delete mode 100644 arch/arm/dts/kirkwood-openrd-client.dts
  delete mode 100644 arch/arm/dts/kirkwood-openrd-ultimate.dts
  delete mode 100644 arch/arm/dts/kirkwood-openrd.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-pogo_e02.dts
  delete mode 100644 arch/arm/dts/kirkwood-pogoplug-series-4.dts
  delete mode 100644 arch/arm/dts/kirkwood-sheevaplug-common.dtsi
  delete mode 100644 arch/arm/dts/kirkwood-sheevaplug.dts
  delete mode 100644 arch/arm/dts/kirkwood-synology.dtsi
  delete mode 100644 arch/arm/dts/kirkwood.dtsi
  create mode 100644 board/CZ.NIC/turris_common.c
  create mode 100644 board/CZ.NIC/turris_common.h
  delete mode 100644 drivers/gpio/turris_omnia_mcu.c
  create mode 100644 drivers/misc/turris_omnia_mcu.c
  create mode 100644 include/turris-omnia-mcu-interface.h
