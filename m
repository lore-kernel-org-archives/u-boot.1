Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D85E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CCEB8021D;
	Wed, 18 Dec 2024 08:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D3B8022B; Wed, 18 Dec 2024 08:50:01 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4347780214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4BI7nluL081212
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 18 Dec 2024 15:49:47 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 15:49:47 +0800
Date: Wed, 18 Dec 2024 15:49:44 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/next
Message-ID: <Z2J-mMspCN0ZWjx3@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4BI7nluL081212
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

The following changes since commit 3b3c7280b82b1f08807a070ac066cd02919dfde1:

  smbios: address build warning (2024-12-15 11:41:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to e59241f8b1315168b7a8a2645c3d3fe73ea5d6d9:

  riscv: spl: add FIT name for RISC-V Falcon mode (2024-12-18 13:19:16 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/23926
----------------------------------------------------------------
- Board: Support LicheeRV Nano
- Board: Support bananapi-f3
- Board: Switch to OF_UPSTREAM for StarFive JH7110
- Board: Add sdhci driver for TH1520 SoC
----------------------------------------------------------------
Hal Feng (12):
      dts: starfive: Switch to using upstream DT
      riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
      mmc: dw_mmc: Add "starfive, jh7110-mmc" compatible to match upstream DT
      pcie: starfive: Make the driver compatible with upstream DT
      riscv: dts: jh7110: Move common code to the new jh7110-common-u-boot.dtsi
      riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
      board: starfive: spl: Drop the unneeded DT modification code
      configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board DT
      riscv: dts: jh7110: Support multiple DTBs in a Fit image
      board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
      board: starfive: spl: Support multiple DTBs for JH7110 based boards
      riscv: cpu: jh7110: Sort the list of imply statements

Kongyang Liu (2):
      riscv: spacemit: bananapi_f3: initial support added
      doc: spacemit: bananapi_f3: document Banana Pi F3 board

Maksim Kiselev (3):
      mmc: snps_sdhci: Add sdhci driver support for TH1520 SoC
      riscv: dts: t-head: Add sdhci and emmc nodes
      configs: th1520_lpi4a: enable mmc controller support

Randolph (1):
      riscv: spl: add FIT name for RISC-V Falcon mode

Thomas Bonnefille (3):
      doc: add LicheeRV Nano and SG2002 SoC
      riscv: dts: sophgo: add device tree for LicheeRV Nano
      board: add support for LicheeRV Nano

 arch/riscv/Kconfig                                 |   9 +
 arch/riscv/cpu/jh7110/Kconfig                      |  19 +-
 arch/riscv/cpu/k1/Kconfig                          |  18 +
 arch/riscv/cpu/k1/Makefile                         |   6 +
 arch/riscv/cpu/k1/cpu.c                            |   9 +
 arch/riscv/cpu/k1/dram.c                           |  54 ++
 arch/riscv/dts/Makefile                            |   4 +-
 arch/riscv/dts/jh7110-common-u-boot.dtsi           | 195 ++++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi       |   6 +
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi    |   6 +
 .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 117 ----
 .../jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 .../jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi |   6 +
 arch/riscv/dts/jh7110-starfive-visionfive-2.dts    |  11 -
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi   | 380 ----------
 arch/riscv/dts/jh7110-u-boot.dtsi                  |  27 +-
 arch/riscv/dts/jh7110.dtsi                         | 761 ---------------------
 arch/riscv/dts/k1-bananapi-f3.dts                  |  25 +
 arch/riscv/dts/k1.dtsi                             | 459 +++++++++++++
 arch/riscv/dts/sg2002-licheerv-nano-b.dts          |  45 ++
 arch/riscv/dts/sg2002.dtsi                         |  34 +
 arch/riscv/dts/th1520-lichee-module-4a.dtsi        |  18 +
 arch/riscv/dts/th1520.dtsi                         |  34 +
 board/sophgo/licheerv_nano/Kconfig                 |  28 +
 board/sophgo/licheerv_nano/MAINTAINERS             |   5 +
 board/sophgo/licheerv_nano/Makefile                |   5 +
 board/sophgo/licheerv_nano/board.c                 |   9 +
 board/spacemit/bananapi-f3/Kconfig                 |  25 +
 board/spacemit/bananapi-f3/MAINTAINERS             |   6 +
 board/spacemit/bananapi-f3/Makefile                |   5 +
 board/spacemit/bananapi-f3/board.c                 |   9 +
 board/starfive/visionfive2/spl.c                   | 391 +----------
 common/spl/Kconfig                                 |   1 +
 configs/bananapi-f3_defconfig                      |  20 +
 configs/sipeed_licheerv_nano_defconfig             |  47 ++
 configs/starfive_visionfive2_defconfig             |   4 +-
 configs/th1520_lpi4a_defconfig                     |  11 +-
 doc/board/index.rst                                |   1 +
 doc/board/sophgo/index.rst                         |   1 +
 doc/board/sophgo/licheerv_nano.rst                 |  72 ++
 doc/board/spacemit/bananapi-f3.rst                 | 106 +++
 doc/board/spacemit/index.rst                       |   9 +
 drivers/clk/starfive/clk-jh7110-pll.c              |   6 +-
 drivers/clk/starfive/clk-jh7110.c                  |  44 +-
 drivers/mmc/Kconfig                                |  12 +
 drivers/mmc/Makefile                               |   1 +
 drivers/mmc/snps_dw_mmc.c                          |   1 +
 drivers/mmc/snps_sdhci.c                           | 444 ++++++++++++
 drivers/pci/pcie_starfive_jh7110.c                 |  59 +-
 include/configs/bananapi-f3.h                      |  13 +
 include/configs/licheerv_nano.h                    |  24 +
 include/dt-bindings/clock/starfive,jh7110-crg.h    | 258 -------
 include/dt-bindings/reset/starfive,jh7110-crg.h    | 183 -----
 53 files changed, 1909 insertions(+), 2140 deletions(-)
 create mode 100644 arch/riscv/cpu/k1/Kconfig
 create mode 100644 arch/riscv/cpu/k1/Makefile
 create mode 100644 arch/riscv/cpu/k1/cpu.c
 create mode 100644 arch/riscv/cpu/k1/dram.c
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
 create mode 100644 arch/riscv/dts/k1.dtsi
 create mode 100644 arch/riscv/dts/sg2002-licheerv-nano-b.dts
 create mode 100644 arch/riscv/dts/sg2002.dtsi
 create mode 100644 board/sophgo/licheerv_nano/Kconfig
 create mode 100644 board/sophgo/licheerv_nano/MAINTAINERS
 create mode 100644 board/sophgo/licheerv_nano/Makefile
 create mode 100644 board/sophgo/licheerv_nano/board.c
 create mode 100644 board/spacemit/bananapi-f3/Kconfig
 create mode 100644 board/spacemit/bananapi-f3/MAINTAINERS
 create mode 100644 board/spacemit/bananapi-f3/Makefile
 create mode 100644 board/spacemit/bananapi-f3/board.c
 create mode 100644 configs/bananapi-f3_defconfig
 create mode 100644 configs/sipeed_licheerv_nano_defconfig
 create mode 100644 doc/board/sophgo/licheerv_nano.rst
 create mode 100644 doc/board/spacemit/bananapi-f3.rst
 create mode 100644 doc/board/spacemit/index.rst
 create mode 100644 drivers/mmc/snps_sdhci.c
 create mode 100644 include/configs/bananapi-f3.h
 create mode 100644 include/configs/licheerv_nano.h
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h

Best regards,
Leo
