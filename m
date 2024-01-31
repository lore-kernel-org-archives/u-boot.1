Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B242C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 10:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279138760D;
	Wed, 31 Jan 2024 11:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4B48784B; Wed, 31 Jan 2024 11:21:50 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12484874CC
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 11:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40VALe25099690;
 Wed, 31 Jan 2024 18:21:40 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 18:21:37 +0800
Date: Wed, 31 Jan 2024 18:21:34 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZbofLkNaJVFNIbj5@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40VALe25099690
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

The following changes since commit 28760ce8640ff6266bd1c1c568a4a231576f3919:

  Merge tag 'clk-2024.04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-clk (2024-01-30 07:54:28 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 6882255ac3107c58e1153311df8a8270087f8cb3:

  riscv: dts: starfive: add regulator device (2024-01-31 16:52:53 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/19505
----------------------------------------------------------------

* Add RISC-V falcon mode documentation
* Add Clang build support
* Add cmd to detect Debug Trigger Extension support

* Add PWM setting for Unmatched board
* Add Milk-V Duo board support
* Add new device node and enable new config option for VisionFive2 board
* Add second virtio device for RISC-V QEMU

----------------------------------------------------------------
Aurelien Jarno (3):
      board: starfive: handle compatible property in dynamic DT configuration
      riscv: qemu: enable booting on a second virtio device
      configs: visionfive2: Disable ENV_IS_NOWHERE

Heinrich Schuchardt (1):
      cmd: sbi: add support for Debug Trigger Extension

Kongyang Liu (3):
      riscv: dts: sophgo: add basic device tree for Milk-V Duo board
      riscv: sophgo: milkv_duo: initial support added
      doc: sophgo: milkv_duo: document Milk-V Duo board

Lukasz Tekieli (2):
      net: phy: motorcomm: configure pad drive strength register
      board: visionfive2: configure PHY pad drive strength

Nam Cao (2):
      riscv: dts: jh7110: add power management unit controller node
      riscv: dts: starfive: add regulator device

Randolph (3):
      doc: falcon: riscv: Falcon Mode boot on RISC-V
      spl: riscv: falcon: move fdt blob to specified address
      configs: andes: add the fdt blob copy address for SPL

Vincent Chen (1):
      board: sifive: spl: Initialized the PWM setting in the SPL stage

kleines Filmröllchen (1):
      riscv: Support building with Clang

 arch/riscv/Kconfig                               |   4 +
 arch/riscv/config.mk                             |   2 +-
 arch/riscv/dts/Makefile                          |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts             |  38 +++++
 arch/riscv/dts/cv1800b.dtsi                      |  18 +++
 arch/riscv/dts/cv18xx.dtsi                       | 192 +++++++++++++++++++++++
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi |   5 +
 arch/riscv/dts/jh7110.dtsi                       |   6 +
 arch/riscv/include/asm/arch-fu740/eeprom.h       |  15 ++
 arch/riscv/include/asm/sbi.h                     |   1 +
 board/AndesTech/ae350/ae350.c                    |  25 ---
 board/sifive/unmatched/spl.c                     |  52 ++++++
 board/sophgo/milkv_duo/Kconfig                   |  28 ++++
 board/sophgo/milkv_duo/MAINTAINERS               |   6 +
 board/sophgo/milkv_duo/Makefile                  |   5 +
 board/sophgo/milkv_duo/board.c                   |   9 ++
 board/starfive/visionfive2/spl.c                 |  12 ++
 cmd/riscv/sbi.c                                  |   1 +
 common/spl/Kconfig                               |   2 +-
 common/spl/spl_opensbi.c                         |  15 ++
 configs/ae350_rv32_falcon_defconfig              |   1 +
 configs/ae350_rv32_falcon_xip_defconfig          |   1 +
 configs/ae350_rv64_falcon_defconfig              |   1 +
 configs/ae350_rv64_falcon_xip_defconfig          |   1 +
 configs/milkv_duo_defconfig                      |  23 +++
 configs/starfive_visionfive2_defconfig           |   1 -
 doc/board/index.rst                              |   1 +
 doc/board/sophgo/index.rst                       |   8 +
 doc/board/sophgo/milkv_duo.rst                   |  64 ++++++++
 doc/develop/falcon.rst                           | 158 +++++++++++++++++++
 drivers/net/phy/motorcomm.c                      | 130 +++++++++++++++
 include/configs/milkv_duo.h                      |  12 ++
 include/configs/qemu-riscv.h                     |   1 +
 33 files changed, 811 insertions(+), 28 deletions(-)
 create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
 create mode 100644 arch/riscv/dts/cv1800b.dtsi
 create mode 100644 arch/riscv/dts/cv18xx.dtsi
 create mode 100644 arch/riscv/include/asm/arch-fu740/eeprom.h
 create mode 100644 board/sophgo/milkv_duo/Kconfig
 create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
 create mode 100644 board/sophgo/milkv_duo/Makefile
 create mode 100644 board/sophgo/milkv_duo/board.c
 create mode 100644 configs/milkv_duo_defconfig
 create mode 100644 doc/board/sophgo/index.rst
 create mode 100644 doc/board/sophgo/milkv_duo.rst
 create mode 100644 include/configs/milkv_duo.h

 Best regards,
 Leo
