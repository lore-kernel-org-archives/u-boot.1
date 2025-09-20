Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789EACAC5A0
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 10:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B91A8309A;
	Sat, 20 Sep 2025 12:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCAC8317B; Sat, 20 Sep 2025 12:21:50 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FDA8004F
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 12:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58KAK5TA032636
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Sat, 20 Sep 2025 18:20:05 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 20 Sep
 2025 18:20:05 +0800
Date: Sat, 20 Sep 2025 18:20:01 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>,
 <ziyao@disroot.org>, <randolph@andestech.com>,
 <heinrich.schuchardt@canonical.com>, <hal.feng@starfivetech.com>,
 <jamie.gibbons@microchip.com>, <eoin.dickson@microchip.com>,
 <wangruikang@iscas.ac.cn>, <greentime.hu@sifive.com>, <e@freeshell.de>
Subject: [GIT,PULL] u-boot-riscv/next
Message-ID: <aM5_0WpehgnK8wH-@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58KAK5TA032636
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

The following changes since commit a209627ed7921f40669f5c0795570d40e77e4cb7:

  Merge patch series "board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()" (2025-09-16 16:14:30 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 10fdc2735da3a4825a5172056090eaf41e061627:

  configs: starfive: Use visionfive2 DEVICE_TREE_INCLUDES dtsi named similar to defconfig (2025-09-19 19:23:32 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/27673
----------------------------------------------------------------
- Switch to upstream devicetree for TH1520 platform
- Remove fdt_high env variable
- Support SMP on RISC-V cores with Zalrsc only
- Make MPFS Generic
- riscv: dts: starfive: prune redundant jh7110-common
----------------------------------------------------------------
E Shattow (4):
      riscv: dts: starfive: prune redundant jh7110-common overrides
      riscv: dts: starfive: sync visionfive2 overrides with upstream Linux for-next
      riscv: dts: starfive: visionfive2 depend on SYS_CPU automatic dtsi inclusion
      configs: starfive: Use visionfive2 DEVICE_TREE_INCLUDES dtsi named similar to defconfig

Eoin Dickson (1):
      gpio: mpfs_gpio: fix compilation warnings

Greentime Hu (1):
      arch/riscv: Remove unused macro in encoding.h

Hal Feng (1):
      pcie: starfive: Remove the redundant print of probe success

Heinrich Schuchardt (1):
      starfive: avoid NULL dereference in fdt_check_header()

Jamie Gibbons (6):
      board: microchip: icicle: rename all icicle files to generic
      configs/microchip_mpfs_generic_defconfig: add board
      doc: microchip: introduce common sections
      doc: microchip: add mpfs_video.rst
      misc: mpfs_syscontroller: add functions to read device tree overlays
      board: microchip: mpfs_generic: include processing of dtbos

Randolph Lin (1):
      include: configs: andes: Remove fdt_high env variable

Vivian Wang (1):
      riscv: qemu: Remove fdt_high default

Yao Zi (7):
      configs: th1520_lpi4a: Enlarge SYS_MALLOC_F_LEN to 0x10000
      clk: thead: th1520-ap: Mark drivers as DM_FLAG_PRE_RELOC
      pinctrl: th1520: Mark driver as DM_FLAG_PRE_RELOC
      dts: th1520: Switch to upstream devicetree
      riscv: Add Kconfig options to distinguish Zaamo and Zalrsc
      configs: ibex-ast2700: Explicitly disable Zaamo and Zalrsc extension
      riscv: Add a Zalrsc-only alternative for synchronization in start.S

 arch/riscv/Kconfig                                 |  23 +-
 arch/riscv/Makefile                                |   7 +-
 arch/riscv/cpu/start.S                             |  26 +-
 arch/riscv/cpu/th1520/Kconfig                      |   1 +
 arch/riscv/dts/Makefile                            |   1 -
 arch/riscv/dts/jh7110-common-u-boot.dtsi           |  99 ---
 .../dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi  |   7 -
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi       |   7 -
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi    |   7 -
 .../jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |   7 -
 .../jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi |   7 -
 ...-boot.dtsi => starfive-visionfive2-u-boot.dtsi} |  82 +--
 arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi |  10 +
 arch/riscv/dts/th1520-lichee-module-4a.dtsi        | 164 -----
 arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi     |  27 +
 arch/riscv/dts/th1520-lichee-pi-4a.dts             |  33 -
 arch/riscv/dts/th1520-u-boot.dtsi                  |  44 ++
 arch/riscv/dts/th1520.dtsi                         | 530 ---------------
 arch/riscv/include/asm/encoding.h                  |   1 -
 .../{mpfs_icicle => mpfs_generic}/Kconfig          |   6 +-
 board/microchip/mpfs_generic/MAINTAINERS           |   7 +
 .../{mpfs_icicle => mpfs_generic}/Makefile         |   2 +-
 .../mpfs_icicle.c => mpfs_generic/mpfs_generic.c}  |   2 +
 board/microchip/mpfs_icicle/MAINTAINERS            |   7 -
 board/starfive/visionfive2/spl.c                   |   3 +-
 configs/ibex-ast2700_defconfig                     |   3 +-
 ..._defconfig => microchip_mpfs_generic_defconfig} |   5 +-
 configs/starfive_visionfive2_defconfig             |   1 +
 configs/th1520_lpi4a_defconfig                     |   4 +-
 doc/board/microchip/index.rst                      |   1 +
 doc/board/microchip/mpfs_build_boot.rst            |  29 +
 doc/board/microchip/mpfs_common.rst                | 666 ++++++++++++++++++
 doc/board/microchip/mpfs_design_hss.rst            |  37 +
 doc/board/microchip/mpfs_icicle.rst                | 743 +--------------------
 doc/board/microchip/mpfs_video.rst                 | 105 +++
 drivers/clk/thead/clk-th1520-ap.c                  |   3 +
 drivers/gpio/mpfs_gpio.c                           |   8 +-
 drivers/misc/mpfs_syscontroller.c                  | 200 ++++++
 drivers/pci/pcie_starfive_jh7110.c                 |   2 -
 drivers/pinctrl/pinctrl-th1520.c                   |   1 +
 ...chip_mpfs_icicle.h => microchip_mpfs_generic.h} |   0
 include/configs/qemu-riscv.h                       |   1 -
 include/configs/voyager.h                          |   1 -
 43 files changed, 1245 insertions(+), 1675 deletions(-)
 delete mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 rename arch/riscv/dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi} (54%)
 create mode 100644 arch/riscv/dts/th1520-lichee-module-4a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/dts/th1520-lichee-pi-4a-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520-lichee-pi-4a.dts
 create mode 100644 arch/riscv/dts/th1520-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/th1520.dtsi
 rename board/microchip/{mpfs_icicle => mpfs_generic}/Kconfig (92%)
 create mode 100644 board/microchip/mpfs_generic/MAINTAINERS
 rename board/microchip/{mpfs_icicle => mpfs_generic}/Makefile (85%)
 rename board/microchip/{mpfs_icicle/mpfs_icicle.c => mpfs_generic/mpfs_generic.c} (98%)
 delete mode 100644 board/microchip/mpfs_icicle/MAINTAINERS
 rename configs/{microchip_mpfs_icicle_defconfig => microchip_mpfs_generic_defconfig} (84%)
 create mode 100644 doc/board/microchip/mpfs_build_boot.rst
 create mode 100644 doc/board/microchip/mpfs_common.rst
 create mode 100644 doc/board/microchip/mpfs_design_hss.rst
 create mode 100644 doc/board/microchip/mpfs_video.rst
 rename include/configs/{microchip_mpfs_icicle.h => microchip_mpfs_generic.h} (100%)

Best regards,
Leo
