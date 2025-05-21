Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53D5C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D98A82E2D;
	Wed, 21 May 2025 11:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8677F82E31; Wed, 21 May 2025 11:50:18 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B0D82E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 54L9o6mj054918
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 21 May 2025 17:50:07 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 17:50:06 +0800
Date: Wed, 21 May 2025 17:50:03 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <aC2hyzxwKzO4k1im@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 54L9o6mj054918
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

The following changes since commit a3e09b24ffd4429909604f1b28455b44306edbaa:

  Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2025-05-20 08:35:31 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to ff6e20c32ff33c6963f7d0a79a0914681461f4fa:

  riscv: dts: th1520: Complete clock tree (2025-05-21 16:49:58 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/26259

----------------------------------------------------------------
- Initial SPL support for T-Head TH1520 SoC
- Improve usability of TH1520 with mainline SPL
- Support building RV32 & RV64 images
- riscv: Improve jh7110 support
----------------------------------------------------------------
E Shattow (3):
      riscv: starfive: jh7110: move uart0 clock frequency to config header
      riscv: dts: jh7110: remove redundant parent nodes
      riscv: dts: jh7110: override syscrg assigned clock rates with defaults

Mayuresh Chitale (4):
      riscv: image: Add new image type for RV64
      riscv: Select appropriate image type
      booti/bootm: riscv: Verify image arch type
      riscv: insn-def.h: Fix header guard

Yao Zi (16):
      riscv: dts: binman.dtsi: Drop filename property for proper U-Boot
      riscv: Access gd with inline assembly when building with LTO or Clang
      riscv: lib: Split out support for T-Head cache management operations
      configs: th1520_lpi4a: Add UART clock frequency
      riscv: cpu: Add TH1520 CPU support
      ram: thead: Add initial DDR controller support for TH1520
      riscv: dts: th1520: Preserve necessary devices for SPL
      riscv: dts: lichee-module-4a: Preserve memory node for SPL
      riscv: dts: th1520: Add DRAM controller
      riscv: dts: th1520: Add binman configuration
      board: thead: licheepi4a: Enable SPL support
      doc: thead: lpi4a: Update documentation
      riscv: cpu: th1520: Initialize IOPMPs in SPL
      clk: thead: Port clock controller driver of TH1520 SoC
      riscv: cpu: th1520: Select clock driver
      riscv: dts: th1520: Complete clock tree

 arch/riscv/Kconfig                                 |    9 +
 arch/riscv/cpu/cpu.c                               |    6 +
 arch/riscv/cpu/cv1800b/Kconfig                     |    1 +
 arch/riscv/cpu/cv1800b/Makefile                    |    1 -
 arch/riscv/cpu/th1520/Kconfig                      |   22 +
 arch/riscv/cpu/th1520/Makefile                     |    8 +
 arch/riscv/cpu/th1520/cache.c                      |   32 +
 arch/riscv/cpu/th1520/cpu.c                        |   21 +
 arch/riscv/cpu/th1520/dram.c                       |   21 +
 arch/riscv/cpu/th1520/spl.c                        |   96 ++
 arch/riscv/dts/binman.dtsi                         |   15 +-
 arch/riscv/dts/jh7110-common-u-boot.dtsi           |    1 -
 arch/riscv/dts/jh7110-u-boot.dtsi                  |   73 +-
 arch/riscv/dts/th1520-lichee-module-4a.dtsi        |    9 +-
 arch/riscv/dts/th1520-lichee-pi-4a.dts             |    1 +
 arch/riscv/dts/th1520.dtsi                         |   91 +-
 arch/riscv/dts/thead-th1520-binman.dtsi            |   55 ++
 arch/riscv/include/asm/arch-th1520/cpu.h           |    9 +
 arch/riscv/include/asm/arch-th1520/iopmp.h         |   42 +
 arch/riscv/include/asm/arch-th1520/spl.h           |   10 +
 arch/riscv/include/asm/global_data.h               |   19 +
 arch/riscv/include/asm/insn-def.h                  |    6 +-
 arch/riscv/include/asm/u-boot.h                    |    4 +
 arch/riscv/lib/Makefile                            |    1 +
 arch/riscv/lib/bootm.c                             |    4 +
 .../riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} |    0
 board/thead/th1520_lpi4a/Kconfig                   |    5 +-
 board/thead/th1520_lpi4a/Makefile                  |    1 +
 board/thead/th1520_lpi4a/spl.c                     |   48 +
 boot/image.c                                       |    3 +-
 cmd/booti.c                                        |    7 +-
 common/board_r.c                                   |    4 +-
 common/init/board_init.c                           |    7 +-
 configs/th1520_lpi4a_defconfig                     |   18 +
 doc/board/thead/lpi4a.rst                          |   58 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/thead/Kconfig                          |   19 +
 drivers/clk/thead/Makefile                         |    5 +
 drivers/clk/thead/clk-th1520-ap.c                  | 1031 ++++++++++++++++++++
 drivers/ram/Kconfig                                |    1 +
 drivers/ram/Makefile                               |    4 +
 drivers/ram/thead/Kconfig                          |    5 +
 drivers/ram/thead/Makefile                         |    1 +
 drivers/ram/thead/th1520_ddr.c                     |  787 +++++++++++++++
 include/configs/starfive-visionfive2.h             |    2 +
 include/configs/th1520_lpi4a.h                     |    1 +
 include/image.h                                    |    3 +-
 48 files changed, 2459 insertions(+), 110 deletions(-)
 create mode 100644 arch/riscv/cpu/th1520/Kconfig
 create mode 100644 arch/riscv/cpu/th1520/Makefile
 create mode 100644 arch/riscv/cpu/th1520/cache.c
 create mode 100644 arch/riscv/cpu/th1520/cpu.c
 create mode 100644 arch/riscv/cpu/th1520/dram.c
 create mode 100644 arch/riscv/cpu/th1520/spl.c
 create mode 100644 arch/riscv/dts/thead-th1520-binman.dtsi
 create mode 100644 arch/riscv/include/asm/arch-th1520/cpu.h
 create mode 100644 arch/riscv/include/asm/arch-th1520/iopmp.h
 create mode 100644 arch/riscv/include/asm/arch-th1520/spl.h
 rename arch/riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} (100%)
 create mode 100644 board/thead/th1520_lpi4a/spl.c
 create mode 100644 drivers/clk/thead/Kconfig
 create mode 100644 drivers/clk/thead/Makefile
 create mode 100644 drivers/clk/thead/clk-th1520-ap.c
 create mode 100644 drivers/ram/thead/Kconfig
 create mode 100644 drivers/ram/thead/Makefile
 create mode 100644 drivers/ram/thead/th1520_ddr.c

 Best regards,
 Leo
