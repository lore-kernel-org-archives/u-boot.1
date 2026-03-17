Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3AEF506FF
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 06:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FBF840CC;
	Tue, 17 Mar 2026 07:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB13840CF; Tue, 17 Mar 2026 07:02:19 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AC8840B5
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62H61nnf076494;
 Tue, 17 Mar 2026 14:01:49 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 14:01:49 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>,
 <hal.feng@starfivetech.com>, <e@freeshell.de>,
 <jamie.gibbons@microchip.com>
Subject: [GIT PULL] u-boot-riscv/next
Date: Tue, 17 Mar 2026 14:01:46 +0800
Message-ID: <20260317060146.3983817-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62H61nnf076494
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

The following changes since commit 841856ed9675b26ec517fdd00b5cc0aef8db508e:

  Merge patch series "Add PCIe Boot support for TI J784S4 SoC" (2026-03-16 08:24:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to b51e59c8b34c780e28728bc0cb58783855c7ffbf:

  riscv: Add support for BeagleV-Fire (2026-03-17 11:39:18 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/29548
----------------------------------------------------------------
- board: starfive: Add Xunlong OrangePi RV
- board: starfive: Add VisionFive 2 Lite
- board: beagle: Add BeagleV-Fire
----------------------------------------------------------------
E Shattow (5):
      board: starfive: visionfive2: Add Orange Pi RV selection by product_id
      configs: starfive: Add Orange Pi RV to visionfive2
      doc: board: starfive: Add Xunlong OrangePi RV
      doc: board: starfive: jh7110 common give build output dir by env not arg
      doc: board: starfive: jh7110 common update OPENSBI build env reference

Hal Feng (7):
      eeprom: starfive: Simplify get_ddr_size_from_eeprom()
      eeprom: starfive: Correct get_pcb_revision_from_eeprom()
      eeprom: starfive: Support eeprom data format v3
      pcie: starfive: Add a optional power gpio support
      configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
      board: starfive: spl: Support VisionFive 2 Lite
      board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection

Jamie Gibbons (1):
      riscv: Add support for BeagleV-Fire

 arch/riscv/Kconfig                                 |   4 +
 arch/riscv/cpu/jh7110/spl.c                        |   2 +-
 arch/riscv/include/asm/arch-jh7110/eeprom.h        |  13 ++-
 board/beagle/beaglev_fire/Kconfig                  |  43 ++++++++
 board/beagle/beaglev_fire/MAINTAINERS              |   7 ++
 board/beagle/beaglev_fire/Makefile                 |   6 ++
 board/beagle/beaglev_fire/beaglev_fire.c           | 117 +++++++++++++++++++++
 board/starfive/visionfive2/spl.c                   |   6 ++
 board/starfive/visionfive2/starfive_visionfive2.c  |   4 +
 .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |  64 ++++++-----
 configs/beaglev_fire_defconfig                     |  29 +++++
 configs/starfive_visionfive2_defconfig             |   2 +-
 doc/board/starfive/index.rst                       |   1 +
 doc/board/starfive/jh7110_common.rst               |  11 +-
 doc/board/starfive/orangepi_rv.rst                 |  35 ++++++
 drivers/pci/pcie_starfive_jh7110.c                 |   8 ++
 include/configs/beaglev_fire.h                     |  57 ++++++++++
 17 files changed, 375 insertions(+), 34 deletions(-)
 create mode 100644 board/beagle/beaglev_fire/Kconfig
 create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
 create mode 100644 board/beagle/beaglev_fire/Makefile
 create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
 create mode 100644 configs/beaglev_fire_defconfig
 create mode 100644 doc/board/starfive/orangepi_rv.rst
 create mode 100644 include/configs/beaglev_fire.h

 Best regards,
 Leo
