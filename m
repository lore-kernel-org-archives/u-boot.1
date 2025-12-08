Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312A6CEBF88
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 06:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1568083971;
	Mon,  8 Dec 2025 07:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A917083981; Mon,  8 Dec 2025 07:20:25 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8375E8006D
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 07:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B86JTaC017041
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 8 Dec 2025 14:19:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Dec
 2025 14:19:28 +0800
Date: Mon, 8 Dec 2025 14:19:25 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <rick@andestech.com>, <conor@kernel.org>,
 <e@freeshell.de>, <heinrich.schuchardt@canonical.com>
Subject: [GIT PULL] u-boot-riscv/next
Message-ID: <aTZt7Xzv6W2M3H8v@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B86JTaC017041
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

The following changes since commit 8e12d6ccb3cfa84dd275a1b852b2a235de0162b0:

  Merge patch series "Azure: Rework world build to directly use the container" (2025-12-07 12:53:09 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 2da2c01cd1238e210009c4aea5d429bea431754d:

  configs: starfive: enable wget https (2025-12-08 12:11:06 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/28674
----------------------------------------------------------------
- riscv: Implement private GCC library
- mpfs: Add MPFS CPU Implementation
- andes: Stop disabling device tree relocation and some minor fixes
- sifive: Stop disabling device tree relocation
- starfive: Cleanup size types and typos
----------------------------------------------------------------
Che-Wei Chuang (1):
      configs: Change default baud rate to 115200

Conor Dooley (2):
      riscv: create a custom CPU implementation for PolarFire SoC
      riscv: mpfs: move SoC level options to the CPU Kconfig

E Shattow (4):
      ram: starfive: drop references to 16GB memory size
      ram: starfive: use SZ_8G for 8GB memory size
      ram: starfive: fix typo for unsupported DDR size
      configs: starfive: enable wget https

Heinrich Schuchardt (2):
      RISC-V: implement private GCC library
      test: provide unit tests for the RISC-V private GCC library

Leo Yu-Chi Liang (1):
      riscv: cpu: Beautify the warning message

Randolph (1):
      falcon: support booting linux from MMC/Parallel Flash

Tom Rini (2):
      ae350: Stop disabling device tree relocation
      sifive-unleashed: Stop disabling device tree relocation

 arch/Kconfig                            |   1 +
 arch/riscv/Kconfig                      |   1 +
 arch/riscv/cpu/cpu.c                    |   2 +-
 arch/riscv/cpu/mpfs/Kconfig             |  33 ++++++++++
 arch/riscv/cpu/mpfs/Makefile            |   5 ++
 arch/riscv/cpu/mpfs/dram.c              |  38 ++++++++++++
 arch/riscv/dts/ae350_32.dts             |   4 +-
 arch/riscv/dts/ae350_64.dts             |   4 +-
 arch/riscv/include/asm/arch-mpfs/clk.h  |   8 +++
 arch/riscv/lib/Makefile                 |   2 +
 arch/riscv/lib/clz.c                    | 105 ++++++++++++++++++++++++++++++++
 arch/riscv/lib/ctz.c                    |  95 +++++++++++++++++++++++++++++
 board/microchip/mpfs_generic/Kconfig    |  24 +-------
 common/spl/Kconfig                      |   1 +
 configs/ae350_rv32_defconfig            |   2 +-
 configs/ae350_rv32_falcon_defconfig     |   2 +-
 configs/ae350_rv32_falcon_xip_defconfig |   5 +-
 configs/ae350_rv32_spl_defconfig        |   2 +-
 configs/ae350_rv32_spl_xip_defconfig    |   2 +-
 configs/ae350_rv32_xip_defconfig        |   2 +-
 configs/ae350_rv64_defconfig            |   2 +-
 configs/ae350_rv64_falcon_defconfig     |   2 +-
 configs/ae350_rv64_falcon_xip_defconfig |   5 +-
 configs/ae350_rv64_spl_defconfig        |   2 +-
 configs/ae350_rv64_spl_xip_defconfig    |   2 +-
 configs/ae350_rv64_xip_defconfig        |   2 +-
 configs/starfive_visionfive2_defconfig  |   2 +
 drivers/ram/starfive/ddrcsr_boot.c      |   3 -
 drivers/ram/starfive/ddrphy_start.c     |   1 -
 drivers/ram/starfive/starfive_ddr.c     |   5 +-
 drivers/ram/starfive/starfive_ddr.h     |   1 -
 include/configs/ae350.h                 |   1 -
 include/configs/sifive-unleashed.h      |   1 -
 lib/Kconfig                             |   2 +-
 test/lib/Makefile                       |   4 ++
 test/lib/test_clz.c                     |  53 ++++++++++++++++
 test/lib/test_ctz.c                     |  53 ++++++++++++++++
 37 files changed, 427 insertions(+), 52 deletions(-)
 create mode 100644 arch/riscv/cpu/mpfs/Kconfig
 create mode 100644 arch/riscv/cpu/mpfs/Makefile
 create mode 100644 arch/riscv/cpu/mpfs/dram.c
 create mode 100644 arch/riscv/include/asm/arch-mpfs/clk.h
 create mode 100644 arch/riscv/lib/clz.c
 create mode 100644 arch/riscv/lib/ctz.c
 create mode 100644 test/lib/test_clz.c
 create mode 100644 test/lib/test_ctz.c

 Best regards,
 Leo
