Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A99CA0ED1
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 10:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE9F83865;
	Thu, 14 Aug 2025 12:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684DD8388C; Thu, 14 Aug 2025 12:41:26 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A008B83855
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 12:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57EAedwi073622
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 14 Aug 2025 18:40:39 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 18:40:39 +0800
Date: Thu, 14 Aug 2025 18:40:36 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>,
 <heinrich.schuchardt@canonical.com>, <ben.dooks@codethink.co.uk>,
 <jamie.gibbons@microchip.com>, <michal.simek@amd.com>,
 <sputnik@on-the-web.ch>, <ycliang@andestech.com>
Subject: [GIT PULL, v2] u-boot-riscv/master
Message-ID: <aJ29JN0YOKGS5tBn@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57EAedwi073622
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

The following changes since commit 869217ee2907595919261b6d4ae81fd76a8ddd81:

  Merge tag 'qcom-fixes-13Aug2025' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2025-08-13 08:57:49 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 35d6caad6de93b3a5545df7bcdc6d322a4edb93c:

  arch/riscv/lib: update memmove and memcpy for big-endian (2025-08-14 15:33:00 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/27379
----------------------------------------------------------------
- Board: mbv: Prepare MBV for CI
- Board: MPFS Icicle Kit cleanup
- Board: Add Andes Voyager board support
- RISCV: Update SYS_BOOTM_LEN to commonly used value
- starfive: fix return code of `mac write_eeprom`
- arch/riscv/lib: update memmove and memcpy for big-endian
----------------------------------------------------------------
Ben Dooks (1):
      arch/riscv/lib: update memmove and memcpy for big-endian

Heinrich Schuchardt (1):
      starfive: fix return code of `mac write_eeprom`

Jamie Gibbons (6):
      configs: microchip_mpfs_icicle: enable CONFIG_OF_BOARD_SETUP
      board: microchip: mpfs_icicle: make use of ft_board_setup()
      mailbox: add PolarFire SoC mailbox driver
      misc: add PolarFire SoC system controller
      board: microchip: mpfs_icicle: enable new driver configs
      board: microchip: mpfs_icicle: update to use system controller

Leo Yu-Chi Liang (7):
      common: spl: fix compilation warning
      riscv: board: Add Andes Voyager board Kconfig support
      riscv: dts: andes: Add Voyager device tree
      board: andestech: Add Voyager board support
      configs: andes: add Voyager board defconfig
      doc: board: voyager: Add documentation for Voyager
      board: MAINTAINERS: Add Voyager board maintainer

Martin Herren (4):
      riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
      riscv: Set SYS_BOOTM_LEN default to 0x4000000
      riscv: Remove default SYS_BOOTM_LEN from defconfig
      riscv: Increase Microchip Icicle's SYS_BOOTM_LEN

Michal Simek (5):
      riscv: cpu: Use CONFIG_IS_ENABLED(CPU) instead of plain ifdef
      xilinx: mbv: Disable OF_HAS_PRIOR_STAGE
      xilinx: mbv: Add missing mmu-type cpu property
      xilinx: mbv: Fix dt properties in interrupt controller node
      xilinx: mbv: Use separate DTB for binman nodes

 arch/riscv/Kconfig                                 |   4 +
 arch/riscv/cpu/cpu.c                               |  14 +-
 arch/riscv/dts/Makefile                            |   2 +
 arch/riscv/dts/qilai-voyager.dts                   | 227 +++++++++++++++++++++
 arch/riscv/dts/voyager-u-boot.dtsi                 |  52 +++++
 arch/riscv/dts/xilinx-binman.dts                   |  12 ++
 arch/riscv/dts/xilinx-mbv32.dts                    |   8 +-
 arch/riscv/dts/xilinx-mbv64.dts                    |   8 +-
 arch/riscv/lib/memcpy.S                            |  12 +-
 arch/riscv/lib/memmove.S                           |  12 +-
 board/andestech/voyager/Kconfig                    |  44 ++++
 board/andestech/voyager/MAINTAINERS                |   8 +
 board/andestech/voyager/Makefile                   |   6 +
 board/andestech/voyager/voyager.c                  |  70 +++++++
 board/microchip/mpfs_icicle/Kconfig                |   4 +
 board/microchip/mpfs_icicle/mpfs_icicle.c          | 121 ++++++-----
 .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |   8 +-
 board/xilinx/mbv/Kconfig                           |   1 -
 boot/Kconfig                                       |   2 +-
 common/spl/spl.c                                   |   4 +-
 configs/ae350_rv32_defconfig                       |   1 -
 configs/ae350_rv32_falcon_defconfig                |   1 -
 configs/ae350_rv32_falcon_xip_defconfig            |   1 -
 configs/ae350_rv32_spl_defconfig                   |   1 -
 configs/ae350_rv32_spl_xip_defconfig               |   1 -
 configs/ae350_rv32_xip_defconfig                   |   1 -
 configs/ae350_rv64_defconfig                       |   1 -
 configs/ae350_rv64_falcon_defconfig                |   1 -
 configs/ae350_rv64_falcon_xip_defconfig            |   1 -
 configs/ae350_rv64_spl_defconfig                   |   1 -
 configs/ae350_rv64_spl_xip_defconfig               |   1 -
 configs/ae350_rv64_xip_defconfig                   |   1 -
 configs/ibex-ast2700_defconfig                     |   1 -
 configs/k230_canmv_defconfig                       |   1 +
 configs/microchip_mpfs_icicle_defconfig            |   3 +
 configs/milkv_duo_defconfig                        |   1 -
 configs/qemu-riscv32_defconfig                     |   1 -
 configs/qemu-riscv32_smode_defconfig               |   1 -
 configs/qemu-riscv32_spl_defconfig                 |   1 -
 configs/qemu-riscv64_defconfig                     |   1 -
 configs/qemu-riscv64_smode_defconfig               |   1 -
 configs/qemu-riscv64_spl_defconfig                 |   1 -
 configs/sifive_unleashed_defconfig                 |   1 -
 configs/sifive_unmatched_defconfig                 |   1 -
 configs/sipeed_licheerv_nano_defconfig             |   1 -
 configs/sipeed_maix_bitm_defconfig                 |   1 +
 configs/sipeed_maix_smode_defconfig                |   1 +
 configs/starfive_visionfive2_defconfig             |   1 -
 configs/th1520_lpi4a_defconfig                     |   1 -
 configs/voyager_spl_defconfig                      |  65 ++++++
 configs/xilinx_mbv32_defconfig                     |   2 +
 configs/xilinx_mbv32_smode_defconfig               |   2 +
 configs/xilinx_mbv64_defconfig                     |   2 +
 configs/xilinx_mbv64_smode_defconfig               |   2 +
 doc/board/andestech/index.rst                      |   1 +
 doc/board/andestech/voyager.rst                    |  81 ++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   1 +
 drivers/mailbox/mpfs-mbox.c                        | 177 ++++++++++++++++
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/mpfs_syscontroller.c                  | 156 ++++++++++++++
 include/configs/voyager.h                          |  40 ++++
 include/mpfs-mailbox.h                             |  66 ++++++
 64 files changed, 1146 insertions(+), 116 deletions(-)
 create mode 100644 arch/riscv/dts/qilai-voyager.dts
 create mode 100644 arch/riscv/dts/voyager-u-boot.dtsi
 create mode 100644 arch/riscv/dts/xilinx-binman.dts
 create mode 100644 board/andestech/voyager/Kconfig
 create mode 100644 board/andestech/voyager/MAINTAINERS
 create mode 100644 board/andestech/voyager/Makefile
 create mode 100644 board/andestech/voyager/voyager.c
 create mode 100644 configs/voyager_spl_defconfig
 create mode 100644 doc/board/andestech/voyager.rst
 create mode 100644 drivers/mailbox/mpfs-mbox.c
 create mode 100644 drivers/misc/mpfs_syscontroller.c
 create mode 100644 include/configs/voyager.h
 create mode 100644 include/mpfs-mailbox.h

Best regards,
Leo
