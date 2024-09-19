Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639DCCE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7BC88D25;
	Thu, 19 Sep 2024 05:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dnVTIy7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A2888D7D; Thu, 19 Sep 2024 05:55:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8671F889C3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718124; x=1758254124;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x1mgRoLwKshY/WQrxRt1fWSEXDJRUYFwt1QD4t6R+TI=;
 b=dnVTIy7zjCxDzq5DpPyUleIg3El8WHqHoW2rZhas+O0XP4S3BAZsGsW5
 rdj73TRVyVkxAysgYuWMi9SSq8Kn4fAGWwxUxTrV6TySJbGxcJbkuyid+
 RWj40sXsEK2urmTqCFwpR/pJRiMf2GIL4Yoym09FX4pXk7mMI4fIQVQ91
 eWE+LLm7+a/6X9X9QIraPq7fXKiC1f7YGv1cDK2S+RjQ1RIyIKmWg81vu
 aTa+SFCPDzZ5fAXMyYvAIv6awhaOKIBWIcFSSkFhqdQZL/QnJ8Bxdz7UG
 0Jzpkk3cwi/lx2wsdauUjLEjkS6pZm8I5OT2xYNk5hUx1Oqj5i+jSCp6d Q==;
X-CSE-ConnectionGUID: b4766tHGS7mwqtpE3M2NIw==
X-CSE-MsgGUID: Nm+1leU5TZumNDRXpWD51w==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43177915"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43177915"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:55:21 -0700
X-CSE-ConnectionGUID: 2vVUQ7nkQHO+K7C+Smn+4g==
X-CSE-MsgGUID: AK9aD9GRTKCsWyFnlrR/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253684"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:16 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 00/19] Add Cadence NAND Driver support
Date: Thu, 19 Sep 2024 11:54:53 +0800
Message-Id: <20240919035512.13854-1-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
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
from Linux. U-Boot will support read, write and erase NAND with
Cadence driver. The driver further enhanced in U-Boot to support
NAND booting from FSBL and support boot to kernel
via UBIFS.

Dinesh Maniyam (19):
  dt: nand: add cadence nand dt-bindings
  arm: dts: agilex5: Enabled cdns-nand dts setting
  include: asm: Add support to read/write 64-bit
  drivers: mtd: nand: Add driver for Cadence Nand
  drivers: mtd: nand: cadence: Add support for read status command
  drivers: mtd: nand: cadence: Add support for readid command
  drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
  drivers: mtd: nand: cadence: Support NAND_CMD_RESET
  drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
  drivers: mtd: nand: cadence: Flush dma descriptor
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
 configs/socfpga_agilex5_nand2_defconfig       |  169 ++
 .../mtd/cadence,nand.yaml                     |   98 +
 drivers/mtd/nand/raw/Kconfig                  |   19 +-
 drivers/mtd/nand/raw/Makefile                 |    2 +
 drivers/mtd/nand/raw/cadence_nand.c           | 2386 +++++++++++++++++
 drivers/mtd/nand/raw/cadence_spl.c            |   96 +
 drivers/mtd/nand/raw/nand_base.c              |   71 +-
 include/cadence-nand.h                        |  528 ++++
 include/linux/mtd/rawnand.h                   |   13 +
 12 files changed, 3424 insertions(+), 25 deletions(-)
 create mode 100644 configs/socfpga_agilex5_nand2_defconfig
 create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
 create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
 create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
 create mode 100644 include/cadence-nand.h

-- 
2.26.2

