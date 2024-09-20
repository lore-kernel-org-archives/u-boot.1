Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAF3CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94878934C;
	Fri, 20 Sep 2024 09:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S1v8Dxrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA00589323; Fri, 20 Sep 2024 09:03:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FF189124
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815795; x=1758351795;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=61tKiH2IOUhRN3vtIicUNjBQ3Kp7FGrezsrhocWeT7Y=;
 b=S1v8Dxrg4XYA3lacCfOuSN9q+yNOzFiBJLuLFQt5/ny2q84MrCgof5Ax
 /arB8HbdrnTz5kospfF4omOEbOob12PP3u10r2Uu5LYx11OAzJW73nIX/
 X813kEsQ/QoDRyaDyBDyhhjCjZUlS4Ar+YH3BkLGbbuV6lHDa7v520t/V
 cD0sts7cZkMXG4cQlaG/5NW3KOxV/7TwDDvDKyS/ULgk4OQzpNncfZOjG
 1HurVoHFWkdxfAHecL4jwTOvhxc9UafluVmJ7TyydnAD+kkcpbHe7VGLJ
 PIp44w3Rayoo+ksxCQmacqB3s9f74qbxeEZi6WUKIytPmMmsD3wsEnWan A==;
X-CSE-ConnectionGUID: K1kFj52FSx+2DnqR9rGUog==
X-CSE-MsgGUID: ojUFpy0wRk60bW50rRpuAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961012"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:13 -0700
X-CSE-ConnectionGUID: ZXkRioVDTcqmXD7ZrXKnCQ==
X-CSE-MsgGUID: qnxPt9WaTE+29xoUsnlfyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235007"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:10 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 00/20] SoCFPGA: Add Boot Support for Agilex 5 in U-Boot
Date: Fri, 20 Sep 2024 15:02:22 +0800
Message-Id: <20240920070242.20884-1-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

This patch set introduces boot support for the Altera SoCFPGA Agilex 5
platform in U-Boot. The changes include:
	1. Board-specific configurations and setup required to enable Agilex 5
	   operation in U-Boot.
	2. Integration of cache coherency unit (CCU) initialization routine,
	   including CCU conguration in DT.
	3. Clock, firewall (configured in DT), SMMU, low level initialization
	   specific to Agilex 5.
	4. Integration of memory initialization routine, including DDR setup.

This patch set has been tested on Agilex 5 devkit with QSPI boot (UBI/UBIFS)
and RAM boot (TFTP & ARM DS debugger).

Alif Zakuan Yuslaimi (1):
  configs: socfpga: soc64: agilex5: Enable QSPI boot with UBI / UBIFS

Tien Fong Chee (18):
  arm: socfpga: agilex5: Add new system manager base addresses
  arm: socfpga: Add support for agilex5 clock manager
  linker: Add SPL linker script for SoC64 devices
  arm: socfpga: agilex5: Add low level initialization
  arm: socfpga: Add handoff data support for SoCFPGA Agilex5 device
  arm: dts: agilex5: Add HPS cache coherency unit configuration settings
  arm: dts: agilex5: Add firewall configure settings
  arm: dts: agilex5: Enable XGMAC
  sysreset:  Add reset support to SoCFPGA Agilex5 device
  arm: socfpga: agilex5: Enable cache flush for system memory cache in
    CCU
  arm: socfpga: agilex5: Add SMMU initialization
  arm: socfpga: agilex5: Update CPU info
  arm: socfpga: Export board ID as U-Boot environment variable
  configs: agilex5: Add configuration for malloc pool
  arm: socfpga: smc: Add memory coherency support to mailbox command
  arm: socfpga: agilex5: Add SPL for Agilex5 SoCFPGA
  configs: socfpga: soc64: agilex5: Enable XGMAC
  arm: socfpga: soc64: Add support for board_boot_order()

Tingting Meng (1):
  ddr: altera: Add DDR driver for Agilex5 series

 MAINTAINERS                                   |   2 +
 arch/arm/Kconfig                              |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 660 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5.dtsi             |   7 +
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  33 +
 arch/arm/mach-socfpga/Makefile                |   6 +
 arch/arm/mach-socfpga/ccu_ncore3.c            |  64 ++
 arch/arm/mach-socfpga/include/mach/firewall.h |  23 +-
 .../mach-socfpga/include/mach/handoff_soc64.h |   4 +-
 arch/arm/mach-socfpga/include/mach/misc.h     |   1 +
 .../include/mach/reset_manager_soc64.h        |  12 +-
 .../include/mach/system_manager_soc64.h       | 129 ++--
 arch/arm/mach-socfpga/lowlevel_init_agilex5.S |  57 ++
 arch/arm/mach-socfpga/misc.c                  |  24 +-
 arch/arm/mach-socfpga/misc_soc64.c            |  12 +-
 arch/arm/mach-socfpga/smc_api.c               |  13 +-
 arch/arm/mach-socfpga/spl_agilex5.c           |  84 +++
 arch/arm/mach-socfpga/spl_soc64.c             | 120 +++-
 arch/arm/mach-socfpga/u-boot-spl-soc64.lds    |  80 +++
 arch/arm/mach-socfpga/wrap_handoff_soc64.c    |  10 +-
 configs/socfpga_agilex5_defconfig             |   6 +
 drivers/ddr/altera/Makefile                   |   1 +
 drivers/ddr/altera/iossm_mailbox.c            | 613 ++++++++++++++++
 drivers/ddr/altera/iossm_mailbox.h            | 186 +++++
 drivers/ddr/altera/sdram_agilex5.c            | 377 ++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  78 ++-
 drivers/ddr/altera/sdram_soc64.h              |  32 +-
 drivers/sysreset/Kconfig                      |   7 +
 drivers/sysreset/Makefile                     |   1 +
 drivers/sysreset/sysreset_socfpga_agilex5.c   |  47 ++
 include/configs/socfpga_soc64_common.h        |   5 +
 31 files changed, 2605 insertions(+), 90 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/ccu_ncore3.c
 create mode 100644 arch/arm/mach-socfpga/lowlevel_init_agilex5.S
 create mode 100644 arch/arm/mach-socfpga/spl_agilex5.c
 create mode 100644 arch/arm/mach-socfpga/u-boot-spl-soc64.lds
 create mode 100644 drivers/ddr/altera/iossm_mailbox.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.h
 create mode 100644 drivers/ddr/altera/sdram_agilex5.c
 create mode 100644 drivers/sysreset/sysreset_socfpga_agilex5.c

-- 
2.25.1

