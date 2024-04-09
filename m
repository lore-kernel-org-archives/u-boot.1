Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B77C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 08:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C285487DEA;
	Tue,  9 Apr 2024 10:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585C087EA9; Tue,  9 Apr 2024 10:25:52 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0290287DCA
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 10:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4398PgE0016374;
 Tue, 9 Apr 2024 16:25:42 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 9 Apr 2024 16:25:39 +0800
Date: Tue, 9 Apr 2024 16:25:36 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZhT7gPuUWx2sNkXJ@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4398PgE0016374
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

The following changes since commit 069d07396e30aa9be396c1dd3fc158ac199e6843:

  Merge tag 'efi-2024-07-rc1' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-04-08 14:33:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to c1f78a4f632276bb4d77f8c79fe203709a9fa397:

  doc: describe Milk-V Mars board (2024-04-09 11:30:37 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/20256
----------------------------------------------------------------

- RISC-V: Support backtrace and improve isa extension parsing
- cpu: Add cv1800b SoC support
- board: Add Milk-V Mars board support
- board: Add Milk-V Duo SD card support

----------------------------------------------------------------
Ben Dooks (1):
      riscv: add backtrace support

Conor Dooley (2):
      riscv: don't read riscv, isa in the riscv cpu's get_desc()
      riscv: support extension probing using riscv, isa-extensions

Heinrich Schuchardt (7):
      riscv: starfive: MMC card detect
      riscv: do not set default fdt for VisionFive 2
      eeprom: starfive: function get_product_id_from_eeprom()
      riscv: set fdtfile on Milk-V Mars
      board: starfive: support Milk-V Mars board
      riscv: starfive: avoid including common.h
      doc: describe Milk-V Mars board

Kongyang Liu (5):
      riscv: cpu: cv1800b: Add support for cv1800b SoC
      riscv: cache: Implement dcache for cv1800b
      mmc: cv1800b: Add sdhci driver support for cv1800b SoC
      riscv: dts: sophgo: Add clk node and sdhci node
      configs: milkv_duo: Add SD card configs

Łukasz Stelmach (1):
      riscv: Move virtio scan to board_late_init()

 arch/riscv/Kconfig                                 |  22 ++++
 arch/riscv/Makefile                                |   4 +
 arch/riscv/cpu/cpu.c                               |  60 +++++++----
 arch/riscv/cpu/cv1800b/Kconfig                     |  12 +++
 arch/riscv/cpu/cv1800b/Makefile                    |   7 ++
 arch/riscv/cpu/cv1800b/cache.c                     |  45 ++++++++
 arch/riscv/cpu/cv1800b/cpu.c                       |   9 ++
 arch/riscv/cpu/cv1800b/dram.c                      |  21 ++++
 arch/riscv/cpu/start.S                             |   1 +
 arch/riscv/dts/cv1800b-milkv-duo.dts               |   8 ++
 arch/riscv/dts/cv1800b.dtsi                        |   4 +
 arch/riscv/dts/cv18xx.dtsi                         |  22 ++++
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi   |   2 +-
 arch/riscv/include/asm/arch-jh7110/eeprom.h        |   9 ++
 arch/riscv/lib/interrupts.c                        |  35 +++++++
 board/emulation/qemu-riscv/qemu-riscv.c            |  12 +--
 board/sophgo/milkv_duo/Kconfig                     |   4 +-
 board/starfive/visionfive2/spl.c                   | 100 +++++++++++++++---
 board/starfive/visionfive2/starfive_visionfive2.c  |  48 ++++++---
 .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |   9 +-
 configs/milkv_duo_defconfig                        |  10 ++
 configs/starfive_visionfive2_defconfig             |   1 -
 doc/board/starfive/index.rst                       |   1 +
 doc/board/starfive/milk-v_mars.rst                 | 111 ++++++++++++++++++++
 doc/board/starfive/visionfive2.rst                 |  18 ++++
 drivers/cpu/riscv_cpu.c                            |   8 +-
 drivers/mmc/Kconfig                                |  13 +++
 drivers/mmc/Makefile                               |   1 +
 drivers/mmc/cv1800b_sdhci.c                        | 116 +++++++++++++++++++++
 29 files changed, 649 insertions(+), 64 deletions(-)
 create mode 100644 arch/riscv/cpu/cv1800b/Kconfig
 create mode 100644 arch/riscv/cpu/cv1800b/Makefile
 create mode 100644 arch/riscv/cpu/cv1800b/cache.c
 create mode 100644 arch/riscv/cpu/cv1800b/cpu.c
 create mode 100644 arch/riscv/cpu/cv1800b/dram.c
 create mode 100644 doc/board/starfive/milk-v_mars.rst
 create mode 100644 drivers/mmc/cv1800b_sdhci.c

Best regards,
Leo
