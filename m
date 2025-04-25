Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC80CC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A4D81F45;
	Fri, 25 Apr 2025 12:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A59D81F4D; Fri, 25 Apr 2025 12:08:09 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BAF81F0D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 53PA7vx5051457
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 25 Apr 2025 18:07:57 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 18:07:57 +0800
Date: Fri, 25 Apr 2025 18:07:54 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <aAte-nS8ZhO_Odw1@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 53PA7vx5051457
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

The following changes since commit 10f48365112b164bee6564033ab682747efcb483:

  Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 5ac699efe94f24df561d33e420d3c73f5fb797e8:

  board: starfive: visionfive2: Order board detection logic to match config (2025-04-25 17:04:09 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/25940
----------------------------------------------------------------
- riscv: lib: Simplify FDT retrieving process
- board: k1: pinctrl: Add pinctrl support for bananapi-f3
- binman: riscv: Fix binman_sym functionality
- board: starfive: visionfive2: Reorder board detection logic
- board: starfive: Add DeepComputing FML13V01 support
----------------------------------------------------------------
E Shattow (2):
      doc: board: starfive: visionfive2: add missing format command to Flashing
      board: starfive: visionfive2: Order board detection logic to match config

Heinrich Schuchardt (9):
      configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
      configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
      riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
      board: starfive: DeepComputing FML13V01 fdt selection
      board: starfive: spl: support DeepComputing FML13V01
      doc: add DeepComputing FML13V01 documentation
      doc: starfive: use consistent formatting
      doc: starfive: use jh7110_common.rst
      doc: jh7110: describe debug UART

Huan Zhou (2):
      riscv: dts: k1: add pinctrl property in dts.
      config: Enable pinctrl in bananapi-f3

Minda Chen (1):
      MAINTAINERS: visionfive2: Add match N: starfive pattern

Yao Zi (7):
      riscv: lib: Add a default implementation of board_fdt_blob_setup
      board: qemu: riscv: Remove duplicated board_fdt_blob_setup
      board: starfive: Remove duplicated board_fdt_blob_setup
      board: sifive: Remove dead board_fdt_blob_setup
      riscv: dts: binman.dtsi: Switch to u-boot-nodtb entry for proper U-Boot
      riscv: dts: starfive: Prevent binman from relocating symbols in SPL
      riscv: Provide __image_copy_{start_end} symbols in linkerscript

 arch/riscv/cpu/u-boot-spl.lds                      |   2 +
 arch/riscv/cpu/u-boot.lds                          |   3 +
 arch/riscv/dts/binman.dtsi                         |   2 +-
 .../dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi  |   7 ++
 arch/riscv/dts/k1-bananapi-f3.dts                  |   3 +
 arch/riscv/dts/k1-pinctrl.dtsi                     |  19 ++++
 arch/riscv/dts/k1.dtsi                             |   8 +-
 arch/riscv/dts/starfive-visionfive2-binman.dtsi    |   1 +
 arch/riscv/lib/Makefile                            |   1 +
 arch/riscv/lib/board.c                             |  19 ++++
 board/emulation/qemu-riscv/qemu-riscv.c            |   8 --
 board/sifive/unleashed/unleashed.c                 |  11 ---
 board/sifive/unmatched/unmatched.c                 |  10 --
 board/starfive/visionfive2/MAINTAINERS             |   2 +-
 board/starfive/visionfive2/spl.c                   |  43 +++++----
 board/starfive/visionfive2/starfive_visionfive2.c  |  16 +---
 configs/bananapi-f3_defconfig                      |   2 +
 configs/qemu-riscv32_defconfig                     |   1 -
 configs/qemu-riscv32_smode_defconfig               |   1 -
 configs/qemu-riscv32_spl_defconfig                 |   1 -
 configs/qemu-riscv64_defconfig                     |   1 -
 configs/qemu-riscv64_smode_defconfig               |   1 -
 configs/qemu-riscv64_spl_defconfig                 |   1 -
 configs/starfive_visionfive2_defconfig             |   2 +-
 doc/board/starfive/deepcomputing_fml13v01.rst      |  80 ++++++++++++++++
 doc/board/starfive/index.rst                       |   1 +
 doc/board/starfive/jh7110_common.rst               | 103 +++++++++++++++++++++
 doc/board/starfive/milk-v_mars.rst                 |  18 +---
 doc/board/starfive/pine64_star64.rst               |  26 +-----
 doc/board/starfive/visionfive2.rst                 |  48 ++--------
 30 files changed, 292 insertions(+), 149 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 create mode 100644 arch/riscv/dts/k1-pinctrl.dtsi
 create mode 100644 arch/riscv/lib/board.c
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
 create mode 100644 doc/board/starfive/jh7110_common.rst


Best regards,
Leo
