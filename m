Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94840C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B2D80312;
	Fri, 17 Jan 2025 02:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DB48069D; Fri, 17 Jan 2025 02:54:01 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2FE8022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 50H1rm96071553
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 17 Jan 2025 09:53:48 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 09:53:48 +0800
Date: Fri, 17 Jan 2025 09:53:45 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <Z4m4KZ3IS8emTeLT@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 50H1rm96071553
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

The following changes since commit 178f6ecb21fe12ada74a9a1a08093c812b15eea5:

  Merge patch series "bootstd: Support recording images" (2025-01-15 19:27:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to b3ce35900cfa500a31fad652302a92cab604d6b5:

  doc: canaan: Add K230 CanMV board (2025-01-16 15:55:27 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/24215
----------------------------------------------------------------
- RISC-V: Add "riscv,isa-extensions" and multi-letter extension parsing support
- RISC-V: Add default cache line size
- Board: Canaan: Add K230-CanMV support
- Board: VisionFive2: Split out target specific configuration
----------------------------------------------------------------
E Shattow (1):
      riscv: dts: starfive: split out visionfive2 target specific configuration

Junhui Liu (5):
      usb: dwc2: Add support for Canaan K230
      riscv: dts: canaan: Add basic device tree for K230 CanMV board
      riscv: cpu: k230: Add support for Canaan Kendryte K230 SoC
      riscv: canaan: k230_canmv: Add initial support
      doc: canaan: Add K230 CanMV board

Mayuresh Chitale (2):
      riscv: Enhance extension probing
      riscv: Fallback to riscv,isa

Yu-Chien Peter Lin (1):
      Kconfig: Add a default cache line size for RISC-V

 arch/Kconfig                                       |   3 +-
 arch/riscv/Kconfig                                 |   5 +
 arch/riscv/cpu/cpu.c                               | 600 +++++++++++++++++++--
 arch/riscv/cpu/k230/Kconfig                        |  14 +
 arch/riscv/cpu/k230/Makefile                       |   6 +
 arch/riscv/cpu/k230/cpu.c                          |   9 +
 arch/riscv/cpu/k230/dram.c                         |  21 +
 arch/riscv/dts/Makefile                            |   1 +
 arch/riscv/dts/jh7110-common-u-boot.dtsi           |  95 ----
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi       |   1 +
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi    |   1 +
 .../jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |   1 +
 .../jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi |   1 +
 arch/riscv/dts/k230-canmv.dts                      |  31 ++
 arch/riscv/dts/k230-u-boot.dtsi                    |  25 +
 arch/riscv/dts/k230.dtsi                           | 175 ++++++
 arch/riscv/dts/starfive-visionfive2-binman.dtsi    | 102 ++++
 arch/riscv/include/asm/cpufeature.h                |  37 ++
 arch/riscv/include/asm/hwcap.h                     | 105 ++++
 arch/riscv/lib/cache.c                             |  26 +-
 board/canaan/k230_canmv/Kconfig                    |  19 +
 board/canaan/k230_canmv/MAINTAINERS                |   6 +
 board/canaan/k230_canmv/Makefile                   |   5 +
 board/canaan/k230_canmv/board.c                    |   9 +
 configs/k230_canmv_defconfig                       |  19 +
 doc/board/canaan/index.rst                         |   8 +
 doc/board/canaan/k230_canmv.rst                    |  88 +++
 doc/board/index.rst                                |   1 +
 doc/device-tree-bindings/usb/dwc2.txt              |   1 +
 29 files changed, 1261 insertions(+), 154 deletions(-)
 create mode 100644 arch/riscv/cpu/k230/Kconfig
 create mode 100644 arch/riscv/cpu/k230/Makefile
 create mode 100644 arch/riscv/cpu/k230/cpu.c
 create mode 100644 arch/riscv/cpu/k230/dram.c
 create mode 100644 arch/riscv/dts/k230-canmv.dts
 create mode 100644 arch/riscv/dts/k230-u-boot.dtsi
 create mode 100644 arch/riscv/dts/k230.dtsi
 create mode 100644 arch/riscv/dts/starfive-visionfive2-binman.dtsi
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/include/asm/hwcap.h
 create mode 100644 board/canaan/k230_canmv/Kconfig
 create mode 100644 board/canaan/k230_canmv/MAINTAINERS
 create mode 100644 board/canaan/k230_canmv/Makefile
 create mode 100644 board/canaan/k230_canmv/board.c
 create mode 100644 configs/k230_canmv_defconfig
 create mode 100644 doc/board/canaan/index.rst
 create mode 100644 doc/board/canaan/k230_canmv.rst

Best regards,
Leo
