Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A5DC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC7288262;
	Tue, 14 May 2024 15:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE2B88280; Tue, 14 May 2024 15:29:14 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E28D88223
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44EDSxri015323;
 Tue, 14 May 2024 21:28:59 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 14 May 2024 21:28:57 +0800
Date: Tue, 14 May 2024 21:28:54 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZkNnFj1klk0nCrTF@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44EDSxri015323
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

The following changes since commit c8ffd1356d42223cbb8c86280a083cc3c93e6426:

  Merge patch series "arm: dts: am62-beagleplay: Fix Beagleplay Ethernet" (2024-05-13 09:15:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 2b8dc36b4c515979da330a96d9fcc9bbbe5385fa:

  andes: Unify naming policy for Andes related source (2024-05-14 18:50:47 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/20690
----------------------------------------------------------------

- RISC-V: Add NULL check after parsing compatible string
- Board: Add Milk-V Mars CM board
- Andes: Unify naming policy 

----------------------------------------------------------------
Hanyuan Zhao (1):
      riscv: add NULL check before calling strlen in the riscv cpu's get_desc()

Heinrich Schuchardt (6):
      board: starfive: function to read eMMC size
      board: add support for Milk-V Mars CM
      doc: Milk-V Mars CM and Milk-V Mars CM Lite
      configs: visionfive2: enable SPL_YMODEM_SUPPORT
      starfive: add mac vendor sub-command
      riscv: simplify backtrace report

Leo Yu-Chi Liang (1):
      andes: Unify naming policy for Andes related source

 arch/riscv/Kconfig                                 |   4 +-
 arch/riscv/cpu/{andesv5 => andes}/Kconfig          |   4 +-
 arch/riscv/cpu/{andesv5 => andes}/Makefile         |   0
 arch/riscv/cpu/{andesv5 => andes}/cache.c          |  12 +-
 arch/riscv/cpu/{andesv5 => andes}/cpu.c            |   0
 arch/riscv/cpu/{andesv5 => andes}/spl.c            |   0
 arch/riscv/include/asm/arch-jh7110/eeprom.h        |   7 +
 arch/riscv/lib/interrupts.c                        |  16 +-
 board/{AndesTech => andestech}/ae350/Kconfig       |   6 +-
 board/{AndesTech => andestech}/ae350/MAINTAINERS   |   2 +-
 board/{AndesTech => andestech}/ae350/Makefile      |   0
 board/{AndesTech => andestech}/ae350/ae350.c       |   2 +-
 board/starfive/visionfive2/Kconfig                 |   9 +
 board/starfive/visionfive2/spl.c                   |  28 ++-
 board/starfive/visionfive2/starfive_visionfive2.c  |  11 +-
 .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |  43 ++++-
 configs/starfive_visionfive2_defconfig             |   1 +
 doc/board/{AndesTech => andestech}/adp-ag101p.rst  |   0
 doc/board/{AndesTech => andestech}/ae350.rst       |   0
 doc/board/{AndesTech => andestech}/index.rst       |   0
 doc/board/index.rst                                |   2 +-
 doc/board/starfive/index.rst                       |   3 +-
 doc/board/starfive/milk-v_mars_cm.rst              | 193 +++++++++++++++++++++
 drivers/cache/Kconfig                              |   6 +-
 drivers/cache/Makefile                             |   2 +-
 drivers/cache/{cache-v5l2.c => cache-andes-l2.c}   |  40 ++---
 drivers/cpu/riscv_cpu.c                            |   2 +-
 27 files changed, 337 insertions(+), 56 deletions(-)
 rename arch/riscv/cpu/{andesv5 => andes}/Kconfig (91%)
 rename arch/riscv/cpu/{andesv5 => andes}/Makefile (100%)
 rename arch/riscv/cpu/{andesv5 => andes}/cache.c (90%)
 rename arch/riscv/cpu/{andesv5 => andes}/cpu.c (100%)
 rename arch/riscv/cpu/{andesv5 => andes}/spl.c (100%)
 rename board/{AndesTech => andestech}/ae350/Kconfig (91%)
 rename board/{AndesTech => andestech}/ae350/MAINTAINERS (95%)
 rename board/{AndesTech => andestech}/ae350/Makefile (100%)
 rename board/{AndesTech => andestech}/ae350/ae350.c (99%)
 rename doc/board/{AndesTech => andestech}/adp-ag101p.rst (100%)
 rename doc/board/{AndesTech => andestech}/ae350.rst (100%)
 rename doc/board/{AndesTech => andestech}/index.rst (100%)
 create mode 100644 doc/board/starfive/milk-v_mars_cm.rst
 rename drivers/cache/{cache-v5l2.c => cache-andes-l2.c} (84%)

Best regards,
Leo
