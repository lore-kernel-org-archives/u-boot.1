Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE13C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7288865E;
	Wed,  1 May 2024 18:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0D38874E; Wed,  1 May 2024 18:38:43 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4010E8833F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 441GcIdA092713;
 Thu, 2 May 2024 00:38:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 2 May 2024 00:38:15 +0800
Date: Thu, 2 May 2024 00:38:11 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <ycliang@andestech.com>, <rick@andestech.com>, <u-boot@lists.denx.de>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZjJv89FBY8JofG2T@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 441GcIdA092713
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

The following changes since commit ff0de1f0557ed7d2dab47ba976a37347a1fdc432:

  Merge patch series "Update PHYTEC SOM Detection" (2024-04-29 10:56:05 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 19b762cf83f68b9d9a1f14e75d75781cedf4049f:

  board: starfive: Rename spl_soc_init() to spl_dram_init() (2024-05-02 00:01:18 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/20596 
----------------------------------------------------------------

- RISC-V: cmd: Add SBI implementation ID and extension ID
- Board: Rename spl_soc_init to spl_dram_init
- Board: milkv_duo: Add SPI NOR flash, Ethernet, Sysreset support

----------------------------------------------------------------
Heinrich Schuchardt (2):
      cmd: sbi: add Supervisor Software Events extension
      cmd: sbi: add coreboot and oreboot implementation IDs

Kongyang Liu (10):
      mmc: cv1800b: Add transmit tap delay config to fix write error
      sysreset: cv1800b: Add sysreset driver for cv1800b SoC
      board: sophgo: milkv_duo: Bind sysreset driver
      configs: milkv_duo: Add sysreset configs
      board: milkv_duo: Add init code for Milk-V Duo ethernet
      riscv: dts: sophgo: Add ethernet node
      configs: milkv_duo: Add ethernet configs
      spi: cv1800b: Add spi nor flash controller driver for cv1800b SoC
      riscv: dts: sophgo: Add spi nor flash controller node
      configs: milkv_duo: Add spi nor configs

Lukas Funke (2):
      board: sifive: Rename spl_soc_init() to spl_dram_init()
      board: starfive: Rename spl_soc_init() to spl_dram_init()

Yu Chien Peter Lin (1):
      riscv: andesv5: Set default cache line size to 64-bytes

 arch/riscv/cpu/andesv5/Kconfig           |   1 +
 arch/riscv/cpu/fu540/spl.c               |   2 +-
 arch/riscv/cpu/fu740/spl.c               |   2 +-
 arch/riscv/cpu/jh7110/spl.c              |   2 +-
 arch/riscv/dts/cv1800b-milkv-duo.dts     |  18 ++
 arch/riscv/dts/cv18xx.dtsi               |  40 ++++
 arch/riscv/include/asm/arch-fu540/spl.h  |   2 +-
 arch/riscv/include/asm/arch-fu740/spl.h  |   2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h |   2 +-
 arch/riscv/include/asm/sbi.h             |   1 +
 board/sifive/unleashed/spl.c             |   4 +-
 board/sifive/unmatched/spl.c             |   4 +-
 board/sophgo/milkv_duo/Makefile          |   3 +-
 board/sophgo/milkv_duo/board.c           |  10 +
 board/sophgo/milkv_duo/ethernet.c        |  79 ++++++++
 board/sophgo/milkv_duo/ethernet.h        |  11 ++
 board/starfive/visionfive2/spl.c         |   4 +-
 cmd/riscv/sbi.c                          |   3 +
 configs/milkv_duo_defconfig              |  10 +
 drivers/mmc/cv1800b_sdhci.c              |   4 +-
 drivers/net/designware.c                 |   1 +
 drivers/spi/Kconfig                      |   8 +
 drivers/spi/Makefile                     |   1 +
 drivers/spi/cv1800b_spif.c               | 321 +++++++++++++++++++++++++++++++
 drivers/sysreset/Kconfig                 |   5 +
 drivers/sysreset/Makefile                |   1 +
 drivers/sysreset/sysreset_cv1800b.c      |  64 ++++++
 27 files changed, 591 insertions(+), 14 deletions(-)
 create mode 100644 board/sophgo/milkv_duo/ethernet.c
 create mode 100644 board/sophgo/milkv_duo/ethernet.h
 create mode 100644 drivers/spi/cv1800b_spif.c
 create mode 100644 drivers/sysreset/sysreset_cv1800b.c
 
 Best regards,
 Leo
