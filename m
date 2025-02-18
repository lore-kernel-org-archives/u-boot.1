Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0523C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C9E809A4;
	Tue, 18 Feb 2025 09:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GFze+nRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8551D80BAD; Tue, 18 Feb 2025 09:35:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3567F8043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867721; x=1771403721;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DaZ4AT8sdoL1kkffpyLHDvTij6mlPsitTxmV4ow1MUI=;
 b=GFze+nRl63z6tjclbX9cQWerZr8sye54tf13rh9VTp/c1X7cggUgdUDr
 jhIfE/fAw5wvtnZtKOqSQJkrIKhxHMNUKmCfA6edlHHb5qvTi/fSQlx3d
 9NTRezQHSWTIABuU+8fE6fu3iNlblVzmZ/RVcvnLtSdti/QZF34kuj/OI
 zDIFfA80MEVShVCQMvvcnwdaHRwUz6p3+Lvb1OoEKG2bLBS8Wff3imETY
 DPadwBm1LpEAHgQFzIbw3xKPzwkl7BAwGrHXOC5gPE33GL04nffAlKr+1
 vw69LuRA3kDA+KStyO47Izs/b1SZ2PWcKGO7rsiuCQcwDYqAOjDpHXvwT w==;
X-CSE-ConnectionGUID: 2R0TOkItSBeboptxCNNB6A==
X-CSE-MsgGUID: WWxFnN60ReKWD5QYYRmFxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028088"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028088"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:19 -0800
X-CSE-ConnectionGUID: UhGX1V+yRXiSafCdvnEDvQ==
X-CSE-MsgGUID: A1BvaZ4cSkegibaX63+02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237637"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:17 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 00/26] SoCFPGA: Add Boot Support for Agilex 5 in U-Boot
Date: Tue, 18 Feb 2025 16:34:45 +0800
Message-Id: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

This patch set introduces boot support for the Altera SoCFPGA Agilex 5 platform in U-Boot. The changes include:
	1. Board-specific configurations and setup required to enable Agilex 5
	   operation in U-Boot.
	2. Integration of cache coherency unit (CCU) initialization routine,
	   including CCU conguration in DT.
	3. Clock, firewall (configured in DT), SMMU, low level initialization
	   specific to Agilex 5.
	4. Integration of memory initialization routine, including DDR setup.

This patch set has been tested on Agilex 5 devkit with QSPI boot (UBI/UBIFS) and RAM boot (TFTP & ARM DS debugger).

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20240920070242.20884-1-tien.fong.chee@intel.com/

v1->v2:
--------
Patch 1
- Converted system manager base address probing from header file to DT

Patch 2
- Updated Agilex5 clock driver to probe base address from DT

Patch 3
- Use common ARMv8 linker script instead of SoC64 linker script

Patch 4
- Use common ARMv8 low level script instead of new Agilex5 low level script

Patch 8
- Add Linux lore link for XGMAC enablement in Agilex5 Linux DT

Patch 9
- Use common PSCI reset driver instead of new Agilex5 reset driver

Patch 12
- Simplify printout logic writing format

Patch 13
- Use env_set_ulong() instead of env_set

Patch 15
- Cast as uintptr_t instead of u64

Alif Zakuan Yuslaimi (14):
  arm: socfpga: misc: Exclude Agilex5 from clock manager base address
    retrieval
  drivers: clk: agilex5: Configure intosc as boot_clk source
  drivers: clk: agilex5: Replace status polling with wait_for_bit_le32()
  drivers: clk: agilex5: Set PLL to asynchronous mode
  arm: socfpga: agilex5: Add warm reset mask for Agilex5
  arm: socfpga: Disable GIC for Agilex5
  arch: arm: Enable PSCI reset driver for Agilex5
  firmware: psci: Flush cache before warm reset
  arm: socfpga: agilex5: Update CPU info
  arm: socfpga: Export board ID as U-Boot environment
  arm: socfpga: smc: Add memory coherency support to mailbox command
  arm: armv8: Improve SPL data save and restore implementation
  configs: socfpga: soc64: agilex5: Use common ARMv8 linker script
  configs: socfpga: soc64: agilex5: Enable QSPI boot with UBI / UBIFS

Tien Fong Chee (11):
  arm: socfpga: agilex5: Add new system manager base addresses
  arm: socfpga: Add handoff data support for SoCFPGA Agilex5 device
  arm: dts: agilex5: Add HPS cache coherency unit configuration settings
  arm: dts: agilex5: Add firewall configure settings
  arm: dts: agilex5: Enable XGMAC
  arm: socfpga: agilex5: Enable cache flush for system memory cache in
    CCU
  arm: socfpga: agilex5: Add SMMU initialization
  configs: agilex5: Add configuration for malloc pool
  arm: socfpga: agilex5: Add SPL for Agilex5 SoCFPGA
  configs: socfpga: soc64: agilex5: Enable XGMAC
  arm: socfpga: soc64: Add support for board_boot_order()

Tingting Meng (1):
  ddr: altera: Add DDR driver for Agilex5 series

 MAINTAINERS                                   |   2 +
 arch/arm/Kconfig                              |   2 +-
 arch/arm/cpu/armv8/spl_data.c                 |  13 +-
 arch/arm/cpu/armv8/u-boot-spl.lds             |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 661 ++++++++++++++++
 arch/arm/dts/socfpga_agilex5.dtsi             |   8 +
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  71 +-
 arch/arm/mach-socfpga/Kconfig                 |   5 +-
 arch/arm/mach-socfpga/Makefile                |   8 +-
 arch/arm/mach-socfpga/altera-sysmgr.c         | 113 +++
 arch/arm/mach-socfpga/board.c                 |  32 +-
 arch/arm/mach-socfpga/ccu_ncore3.c            |  64 ++
 .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +
 arch/arm/mach-socfpga/include/mach/board.h    |  11 +
 arch/arm/mach-socfpga/include/mach/firewall.h |  21 +-
 .../mach-socfpga/include/mach/handoff_soc64.h |   5 +-
 arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
 .../include/mach/reset_manager_soc64.h        |   9 +-
 .../include/mach/system_manager_soc64.h       | 128 +--
 arch/arm/mach-socfpga/misc.c                  |  70 +-
 arch/arm/mach-socfpga/misc_soc64.c            |  32 +-
 arch/arm/mach-socfpga/smc_api.c               |  12 +-
 arch/arm/mach-socfpga/spl_agilex5.c           | 110 +++
 arch/arm/mach-socfpga/spl_soc64.c             | 119 +++
 arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   9 +-
 board/intel/agilex5-socdk/Makefile            |   7 +
 board/intel/agilex5-socdk/socfpga.c           |  12 +
 configs/socfpga_agilex5_defconfig             |  17 +-
 drivers/clk/altera/clk-agilex5.c              |  53 +-
 drivers/ddr/altera/Makefile                   |   3 +-
 drivers/ddr/altera/iossm_mailbox.c            | 748 ++++++++++++++++++
 drivers/ddr/altera/iossm_mailbox.h            | 136 ++++
 drivers/ddr/altera/sdram_agilex5.c            | 420 ++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  76 +-
 drivers/ddr/altera/sdram_soc64.h              |  10 +
 drivers/firmware/psci.c                       |   1 +
 include/configs/socfpga_soc64_common.h        |   6 +
 37 files changed, 2879 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/altera-sysmgr.c
 create mode 100644 arch/arm/mach-socfpga/ccu_ncore3.c
 create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/board.h
 create mode 100644 arch/arm/mach-socfpga/spl_agilex5.c
 create mode 100644 board/intel/agilex5-socdk/Makefile
 create mode 100644 board/intel/agilex5-socdk/socfpga.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.h
 create mode 100644 drivers/ddr/altera/sdram_agilex5.c

-- 
2.25.1

