Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03326C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5386381DD6;
	Tue, 13 May 2025 11:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SKbDO64F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDBA8129F; Tue, 13 May 2025 11:05:26 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02AC281FAB
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 958C9260AF;
 Tue, 13 May 2025 11:05:23 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stZ1q5srpgY1; Tue, 13 May 2025 11:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747127121; bh=n4Xsdfhe6FNR7bazaTFnb+KNZRtZa2/RLV0d7pfhSSk=;
 h=From:To:Cc:Subject:Date;
 b=SKbDO64F1+jYxQzhAvLKL2ur7D8izDfVSLZJWQAOUJXoVc8iG9UK7bc6XTXTRmSKM
 P7c5+bnvRhwzl4bg4VdR4uMUBnTFWgPK03jHwaWYC5s8p6SNCOSC/jHkR0d294iJlE
 u2ccsgX7qXAOZ55Sw2JjbWCqctksg4FSDDLkFlXywXX+6gkzLilFv1AwSTIbpeozPl
 0MaGBOpWUxQxcYgdyxrD9DDeBnWV1BMjebopMu8TXAQ3cegOcruF6FZeHrU55yIpyc
 D7aMEbDU+dF1wLTbII5kaOmG/Px3+IkhTgXBZtMe8gHMcmXS1GzDECUpBlNz8sh/bE
 g9QPnx7hzTBmw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 00/10] Initial SPL support for T-Head TH1520 SoC
Date: Tue, 13 May 2025 09:04:53 +0000
Message-ID: <20250513090503.46670-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds initial SPL support for T-Head TH1520 SoC and Sipeed
Lichee Pi 4A board. Key changes include,

- Support for T-Head-specific cache management operations is split out
  of CV1800B port and adapted for usage in other ports.
- A new CPU target, THEAD_TH1520, is added with SPL support enabled.
- Driver for TH1520's DDR controller is cleaned up from the vendor
  U-Boot source.
- For building the bootable image, of which TH1520's BROM executes from
  the start, from SPL, DDR firmware and proper U-Boot, a binman
  configuration for TH1520 is added.

Note that the binman configuration doesn't inherit the default one for
RISC-V, as our proper U-Boot runs in M-Mode and reusing
riscv/dts/binman.dtsi doesn't help much.

Tested on the 16GiB variant of Sipeed Lichee Pi 4A. Loading
u-boot-with-spl.bin to SRAM with fastboot through BROM, I've
successfully booted into U-Boot console with DRAM initialized.

This series is based on the latest master branch. Thanks for your time
and review.

Changed from v1
- Remove patch "riscv: dts: th1520: Add clock-frequency for UART0",
  UART clocks are now described with CFG_SYS_NS16550_CLK in
  th1520_lpi4a.h for SPL.
- Add missing SPDX and copyright header for the DDR driver.
- Link to v1: https://lore.kernel.org/all/20250426165704.35523-1-ziyao@disroot.org/

Yao Zi (10):
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

 arch/riscv/Kconfig                            |   9 +
 arch/riscv/cpu/cv1800b/Kconfig                |   1 +
 arch/riscv/cpu/cv1800b/Makefile               |   1 -
 arch/riscv/cpu/th1520/Kconfig                 |  21 +
 arch/riscv/cpu/th1520/Makefile                |   8 +
 arch/riscv/cpu/th1520/cache.c                 |  32 +
 arch/riscv/cpu/th1520/cpu.c                   |  21 +
 arch/riscv/cpu/th1520/dram.c                  |  21 +
 arch/riscv/cpu/th1520/spl.c                   |  31 +
 arch/riscv/dts/th1520-lichee-module-4a.dtsi   |   1 +
 arch/riscv/dts/th1520-lichee-pi-4a.dts        |   1 +
 arch/riscv/dts/th1520.dtsi                    |  16 +
 arch/riscv/dts/thead-th1520-binman.dtsi       |  55 ++
 arch/riscv/include/asm/arch-th1520/cpu.h      |   9 +
 arch/riscv/include/asm/arch-th1520/spl.h      |  10 +
 arch/riscv/lib/Makefile                       |   1 +
 .../{cpu/cv1800b/cache.c => lib/thead_cmo.c}  |   0
 board/thead/th1520_lpi4a/Kconfig              |   5 +-
 board/thead/th1520_lpi4a/Makefile             |   1 +
 board/thead/th1520_lpi4a/spl.c                |  48 ++
 configs/th1520_lpi4a_defconfig                |  18 +
 doc/board/thead/lpi4a.rst                     |  58 +-
 drivers/ram/Kconfig                           |   1 +
 drivers/ram/Makefile                          |   4 +
 drivers/ram/thead/Kconfig                     |   5 +
 drivers/ram/thead/Makefile                    |   1 +
 drivers/ram/thead/th1520_ddr.c                | 787 ++++++++++++++++++
 include/configs/th1520_lpi4a.h                |   1 +
 28 files changed, 1161 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/cpu/th1520/Kconfig
 create mode 100644 arch/riscv/cpu/th1520/Makefile
 create mode 100644 arch/riscv/cpu/th1520/cache.c
 create mode 100644 arch/riscv/cpu/th1520/cpu.c
 create mode 100644 arch/riscv/cpu/th1520/dram.c
 create mode 100644 arch/riscv/cpu/th1520/spl.c
 create mode 100644 arch/riscv/dts/thead-th1520-binman.dtsi
 create mode 100644 arch/riscv/include/asm/arch-th1520/cpu.h
 create mode 100644 arch/riscv/include/asm/arch-th1520/spl.h
 rename arch/riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} (100%)
 create mode 100644 board/thead/th1520_lpi4a/spl.c
 create mode 100644 drivers/ram/thead/Kconfig
 create mode 100644 drivers/ram/thead/Makefile
 create mode 100644 drivers/ram/thead/th1520_ddr.c

-- 
2.49.0

