Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E36E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3794A89229;
	Thu,  5 Dec 2024 10:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jbd/URla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA1889229; Thu,  5 Dec 2024 10:23:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CEC18909B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390617; x=1764926617;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qu5OPX4aeMuiYYS/ZLYToVUm2qf/wPgLXeaBxZ2yZJ4=;
 b=jbd/URla5Bqy5Ikl4cRd8AJRvzPfPqK4QFdIvJSchi2DaTfnta4M2JuR
 SJiv0q8kBx4UbNRTcjbtLh6qIfiBVBMcNiqBQy62TQVGyjTPnPBLZTktW
 ifql6QhcvaS2acOwX0nZ6eOU3nh5CKnPzgHGB7d724SWaY5gQMvhAWMqM
 zMAdfB6CFYK+1+VutAfmRzSoqGHhahRnjqYMMLI0WES3++Rp8aObdFvB5
 bJHJIUcWPIYpqvON1QqvrBSQaf2uskkYkevfG4eWnLvHe/Zfj4Olmt2lu
 zHul8N4QAPuoOm1se0voOx4or2mWW0Jb1X2AHvT5tIxTtrVCFafOsB4n1 Q==;
X-CSE-ConnectionGUID: O/6+ZEo6RPupaNDyHio6nw==
X-CSE-MsgGUID: fp8H13UNRZqbJ2pXLLGWyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610076"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610076"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:23:29 -0800
X-CSE-ConnectionGUID: B8MK9idFR6aEXIK1NH9Ngg==
X-CSE-MsgGUID: g7b8P+zTS7mat3HmNqvtJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121764"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:23:24 -0800
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
Subject: [resend v2 00/19] Add Cadence NAND Driver support
Date: Thu,  5 Dec 2024 17:22:56 +0800
Message-Id: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.13854-1-dinesh.maniyam@intel.com/

Dinesh Maniyam (19):
  dt: nand: add cadence nand dt-bindings
  arm: dts: agilex5: Enabled cdns-nand dts setting
  include: asm: Add support to read/write 64-bit
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
  drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependency
  drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL

 arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   28 +
 arch/arm/include/asm/io.h                     |   25 +
 board/intel/agilex5-socdk/MAINTAINERS         |    2 +
 configs/socfpga_agilex5_nand2_defconfig       |   33 +
 .../mtd/cadence,nand.yaml                     |   98 +
 drivers/mtd/nand/raw/Kconfig                  |   19 +-
 drivers/mtd/nand/raw/Makefile                 |    2 +
 drivers/mtd/nand/raw/cadence_nand.c           | 2424 +++++++++++++++++
 drivers/mtd/nand/raw/cadence_spl.c            |   59 +
 drivers/mtd/nand/raw/nand_base.c              |   71 +-
 include/cadence-nand.h                        |  529 ++++
 include/linux/mtd/rawnand.h                   |   14 +
 13 files changed, 3293 insertions(+), 25 deletions(-)
 create mode 100644 configs/socfpga_agilex5_nand2_defconfig
 create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
 create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
 create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
 create mode 100644 include/cadence-nand.h

-- 
2.19.0

