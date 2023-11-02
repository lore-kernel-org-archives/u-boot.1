Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C140C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 10:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F99F8772F;
	Thu,  2 Nov 2023 11:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B7A87746; Thu,  2 Nov 2023 11:54:01 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303668771C
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 11:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3A2Arl8f083230;
 Thu, 2 Nov 2023 18:53:47 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 2 Nov 2023 18:53:46 +0800
Date: Thu, 2 Nov 2023 18:49:56 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZUN-1ADrFIKePtRs@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3A2Arl8f083230
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

The following changes since commit a803f87202aa48974bdff4d8100464a8288931e4:

  Merge https://source.denx.de/u-boot/custodians/u-boot-mmc (2023-11-01 09:44:33 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 9d22d4a7cef7f2fdaf5c060b71574e6f82ea5ff0:

  configs: visionfive2: Enable JH7110 RNG driver (2023-11-02 17:45:53 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18407
----------------------------------------------------------------

+ CI: Use OpenSBI 1.3.1 release for testing
+ riscv: Support resume after exception
+ rng: Support RNG provided by RISC-V Zkr ISA extension
+ board: starfive VF2: Support jtag
+ board: starfive VF2: Support TRNG driver
+ board: sifive unmatched: Move kernel load address

----------------------------------------------------------------
Chanho Park (7):
      riscv: cpu: jh7110: Add gpio helper macros
      board: starfive: spl: Support jtag for VisionFive2 board
      riscv: import read/write_relaxed functions
      clk: starfive: jh7110: Add security clocks
      rng: Add StarFive JH7110 RNG driver
      riscv: dts: jh7110: Add rng device tree node
      configs: visionfive2: Enable JH7110 RNG driver

Heinrich Schuchardt (3):
      CI: use OpenSBI 1.3.1 for testing
      riscv: allow resume after exception
      rng: Provide a RNG based on the RISC-V Zkr ISA extension

Samuel Holland (3):
      riscv: Sort target configs alphabetically
      riscv: Align the trap handler to 64 bytes
      riscv: Weakly define invalidate_icache_range()

Yong-Xuan Wang (1):
      board: sifive: unmatched: move kernel load address to 0x80200000

 .azure-pipelines.yml                      |   8 +-
 .gitlab-ci.yml                            |   8 +-
 arch/riscv/Kconfig                        |  18 +-
 arch/riscv/cpu/mtrap.S                    |   2 +-
 arch/riscv/dts/jh7110.dtsi                |  10 ++
 arch/riscv/include/asm/arch-jh7110/gpio.h |  85 +++++++++
 arch/riscv/include/asm/io.h               |  45 +++++
 arch/riscv/lib/cache.c                    |   2 +-
 arch/riscv/lib/interrupts.c               |  13 ++
 board/starfive/visionfive2/spl.c          |  23 +++
 configs/starfive_visionfive2_defconfig    |   2 +
 doc/api/index.rst                         |   1 +
 doc/api/interrupt.rst                     |   6 +
 drivers/clk/starfive/clk-jh7110.c         |  10 ++
 drivers/rng/Kconfig                       |  14 ++
 drivers/rng/Makefile                      |   2 +
 drivers/rng/jh7110_rng.c                  | 274 ++++++++++++++++++++++++++++++
 drivers/rng/riscv_zkr_rng.c               | 116 +++++++++++++
 include/configs/sifive-unmatched.h        |   2 +-
 include/interrupt.h                       |  45 +++++
 20 files changed, 666 insertions(+), 20 deletions(-)
 create mode 100644 arch/riscv/include/asm/arch-jh7110/gpio.h
 create mode 100644 doc/api/interrupt.rst
 create mode 100644 drivers/rng/jh7110_rng.c
 create mode 100644 drivers/rng/riscv_zkr_rng.c
 create mode 100644 include/interrupt.h

 Best regards,
 Leo
