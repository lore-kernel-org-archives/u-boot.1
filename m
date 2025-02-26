Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861EEC18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC74805C3;
	Wed, 26 Feb 2025 17:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NFmD8HJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BF1807EE; Wed, 26 Feb 2025 17:18:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC25B8004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586730; x=1772122730;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/rmgZyw2Xuq/CTCWsKKF0HrXgdO+6ai259mQfK0FleI=;
 b=NFmD8HJJ7T6CnlBhnL5BoEhOyqz5LTa5oTS9kkxKqc5mZxRVTwuEF/0M
 nRvA1MrPyiEClITgU+6PKZiIqyxTZmNPTCY1bgnmCsFKkkIRmjz8Ep79e
 BC0P1V2q5tdg7V+RXPSEYP8kV/98El3sz9JSzY+/1NPlA5hcdbo3er+of
 CzfNWrrE/5gvc6dG2527CtOwpmV3QDprsTHfyD9kqiJFaw8jhQ3wc3N4f
 zsWdq2fbdw7KBul3hAJN354TjpOkBDwePNrID9Z1W1tynfYpotTQdllRE
 1TV/AiXhQmYbPBegAMZQRH2PwHWXZYD3m9NIBsS5iHqJfPBJNaFC5++N0 Q==;
X-CSE-ConnectionGUID: IDQHYUviQSqbfFznJjGOtg==
X-CSE-MsgGUID: 5R+vVWp7RfOPJCoSEHLHRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41639879"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41639879"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:18:48 -0800
X-CSE-ConnectionGUID: XQVHFMXXQC2MAsvH5r9b2g==
X-CSE-MsgGUID: dvRzgh5gTdueWk7TFe26UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602523"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:18:43 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v3 00/19] Add Cadence NAND Driver support
Date: Thu, 27 Feb 2025 00:18:14 +0800
Message-Id: <20250226161833.53689-1-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patchset add Cadence NAND driver support for
Intel Agilex5 devices.

The NAND driver is leveraged from the cadence-nand-controller.c
from Linux version 6.11.2. U-Boot will support read, write and erase
NAND with Cadence driver. The driver further enhanced in U-Boot
to support NAND booting from FSBL and support boot to kernel
via UBIFS.

Patch status:
Have changes: All patches expect Patch 19

Detail changelog can find in commit message.

v1->v2:
--------
Patch 1 - 18:

- remove the "this patch is to" commit phrases

Patch 4;
- minor refactoring of code to match the stable version 6.11.2.

Patch 14:
- Add maintainer and "#include" mechanism for new variant

Patch 16:
- leverage the existing nand_spl_load_image

v2->v3:
--------
Patch: arm: dts: agilex5: Enabled cdns-nand dts setting
- Move &nand from uboot.dtsi to socdk.dts

Patch: include: asm: Add support to read/write 64-bit
- Dropped because redefinition of readsq & writesq

Patch: drivers: mtd: nand: Add driver for Cadence Nand
- Remove redundant clk_free func

Patch: drivers: mtd: nand: Enabled Kconfig and Makefile for SPL_NAND_FRAMEWORK
- New

Patch: drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE dependency
- New

Patch: configs: nand2_defconfig: Enable configs for nand boot
- Remove CONFIG_OF_UPSTREAM in order to get correct dts for compilation

Patch: drivers: mtd: nand: base: Add support for Hardware ECC for check bad block
- Remove copyright

Patch: drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependency
- Dropped because SPL NAND have dependency with SYS_NAND_BLOCK_SIZE

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.13854-1-dinesh.maniyam@intel.com/
[v2]: https://patchwork.ozlabs.org/project/uboot/cover/20241205092315.25060-1-dinesh.maniyam@intel.com/

Dinesh Maniyam (19):
  dt: nand: add cadence nand dt-bindings
  arm: dts: agilex5: Enabled cdns-nand dts setting
  drivers: mtd: nand: Add driver for Cadence Nand
  drivers: mtd: nand: cadence: Add support for read status command
  drivers: mtd: nand: cadence: Add support for readid command
  drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
  drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
  drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
  drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
  drivers: mtd: nand: cadence: Poll for desc complete status
  drivers: mtd: nand: cadence: Use bounce buffer
  drivers: nand: Enabled Kconfig and Makefile for cdns-nand
  configs: nand2_defconfig: Enable configs for nand boot
  drivers: mtd: nand: base: Add support for Hardware ECC for check bad
    block
  drivers: mtd: nand: spl: Add support for nand SPL load image
  drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
  drivers: mtd: nand: Enabled Kconfig and Makefile for
    SPL_NAND_FRAMEWORK
  drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE dependency
  drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL

 arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |    9 +-
 arch/arm/dts/socfpga_agilex5_socdk.dts        |   19 +
 board/intel/agilex5-socdk/MAINTAINERS         |    2 +
 configs/socfpga_agilex5_nand2_defconfig       |   32 +
 .../mtd/cadence,nand.yaml                     |   98 +
 drivers/mtd/nand/raw/Kconfig                  |   26 +-
 drivers/mtd/nand/raw/Makefile                 |   12 +
 drivers/mtd/nand/raw/cadence_nand.c           | 2423 +++++++++++++++++
 drivers/mtd/nand/raw/cadence_spl.c            |   59 +
 drivers/mtd/nand/raw/nand_base.c              |   69 +-
 include/cadence-nand.h                        |  529 ++++
 include/linux/mtd/rawnand.h                   |   12 +
 13 files changed, 3278 insertions(+), 26 deletions(-)
 create mode 100644 configs/socfpga_agilex5_nand2_defconfig
 create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
 create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
 create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
 create mode 100644 include/cadence-nand.h

-- 
2.19.0

