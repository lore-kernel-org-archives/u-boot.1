Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4953C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DC8882CF;
	Fri, 17 May 2024 14:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KogKHtX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1E88848D; Fri, 17 May 2024 07:27:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3B388375
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923638; x=1747459638;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eFXsExPesMutfhq4dhKKY+f9xn/YWDptDnTh5a969SY=;
 b=KogKHtX7NZs7wT4L6puh7vGz5S5wSuJynJuCy0h52TLN4wyEOCOyfbs1
 SClgEzh8dNu+2l5nkiUMuP3Bt7Tj+sQAfhgVlDxNTSFrN5jWe3XTFyjV9
 o9Jsfy8y4T431L+skO8A2UKb1gsFM1WkmjBYoXOu6rjGIadGZnZH1ej8q
 RVFlicQ6f+xBBEHibxDZCPYlh1WVcdNcK78/81ciN3iEffyl7HfHDr6BH
 WTrVbiPxaMrGgpGIH6l/qZMPA8wL0mO1UoqsCJogLIRn+patoqwjiC4YT
 lP3d/4u7/UOo30mrv4A8WomVKnsPFie25SJCwKmXiZc1s4vis+zj/DA6N w==;
X-CSE-ConnectionGUID: D6MhpheJT/6HqJ8v/YM/xw==
X-CSE-MsgGUID: 2e39r8f1Q9GdbaitKXdBGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929895"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929895"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:16 -0700
X-CSE-ConnectionGUID: snsVq1soSZi8cVhqcILM1w==
X-CSE-MsgGUID: Ic3mOPyiS7Gjvem4G2mIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188182"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:12 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 00/16]
Date: Fri, 17 May 2024 13:26:45 +0800
Message-Id: <20240517052701.12949-1-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Tingting Meng <tingting.meng@intel.com>

Intel Agilex7 M-Series is the highest peformance FPGA targeted for compute and
memory-intensive application,this series is built using intel 7 process 
technology and expands upon I-Series device feature, offering in-package 
high bandwidth memory (HBM), memory interfaces for DDR5 SDRAM, and a hard memory
Network-on-Chip (NoC) to maximize memory bandwidth. The series of patches  include 
adding clock driver, IOSSM mailbox driver, UIBSSM mailbox driver,
DDR driver and HBM driver needed for Agilex 7 M-Series platform enablement and
supports linux boot from SD card.
 
This series patches based on  master branch https://source.denx.de/u-boot/u-boot
 
Complete compilation check on different devices, ran checkpatch and tested on board


Siew Chin Lim (1):
  include: configs: soc64: Use CONFIG_SPL_ATF to differentiate bootfile

Sin Hui Kho (1):
  ddr: altera: soc64: Restructure SDRAM firewall function

Teik Heng Chong (5):
  arch: arm: mach-socfpga: Improve help info.
  clk: altera: Add clock support for Agilex7 M-series
  ddr: altera: Add uibssm mailbox for Agilex7 M-series
  ddr: altera: soc64: Clean up bit-shift by zero bit
  ddr: altera: soc64: Fix dram size calculation in clamshell mode

Wan Yee Lau (9):
  arch: arm: dts: Add dts and dtsi for new platform Agilex7 M-series
  arch: arm: mach-socfpga: Add Agilex7 M-series mach-socfgpa enablement
  arch: arm: mach-socfpga: Update handoff settings for Agilex7 M-series
  include: configs: Add config header file for Agilex7 M-series
  ddr: altera: Add iossm mailbox for Agilex7 M-series
  ddr: altera: Add DDR driver for Agilex7 M-series
  arch: arm: mach-socfpga: Update kconfig for new platform Agilex7
    M-series
  arch: arm: dts: Update Makefile for new platform Agilex7 M-series
  configs: Add defconfig for Agilex7 M-series

 arch/arm/Kconfig                              |   7 +-
 arch/arm/dts/Makefile                         |   1 +
 .../dts/socfpga_agilex7m_socdk-u-boot.dtsi    |  80 +++
 arch/arm/dts/socfpga_agilex7m_socdk.dts       | 185 +++++
 arch/arm/dts/socfpga_soc64_u-boot.dtsi        | 127 ++++
 arch/arm/mach-socfpga/Kconfig                 |  19 +
 arch/arm/mach-socfpga/Makefile                |  18 +
 .../include/mach/base_addr_soc64.h            |   6 +-
 .../mach-socfpga/include/mach/clock_manager.h |   2 +-
 .../mach-socfpga/include/mach/handoff_soc64.h |  14 +-
 arch/arm/mach-socfpga/include/mach/misc.h     |   3 +-
 .../include/mach/system_manager_soc64.h       |   7 +-
 arch/arm/mach-socfpga/misc.c                  |   6 +-
 arch/arm/mach-socfpga/spl_agilex7m.c          |  98 +++
 arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   4 +
 board/intel/agilex7m-socdk/MAINTAINERS        |   7 +
 board/intel/agilex7m-socdk/Makefile           |   7 +
 board/intel/agilex7m-socdk/socfpga.c          |   4 +
 configs/socfpga_agilex7m_sdmmc_defconfig      | 114 ++++
 drivers/clk/altera/Makefile                   |   1 +
 drivers/ddr/altera/Makefile                   |   3 +-
 drivers/ddr/altera/iossm_mailbox.c            | 637 ++++++++++++++++++
 drivers/ddr/altera/iossm_mailbox.h            | 182 +++++
 drivers/ddr/altera/sdram_agilex7m.c           | 527 +++++++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  42 +-
 drivers/ddr/altera/sdram_soc64.h              |  40 +-
 drivers/ddr/altera/uibssm_mailbox.c           | 311 +++++++++
 drivers/ddr/altera/uibssm_mailbox.h           | 117 ++++
 include/configs/socfpga_agilex7m_socdk.h      |  12 +
 29 files changed, 2551 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex7m_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex7m_socdk.dts
 create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi
 create mode 100644 arch/arm/mach-socfpga/spl_agilex7m.c
 create mode 100644 board/intel/agilex7m-socdk/MAINTAINERS
 create mode 100644 board/intel/agilex7m-socdk/Makefile
 create mode 100644 board/intel/agilex7m-socdk/socfpga.c
 create mode 100644 configs/socfpga_agilex7m_sdmmc_defconfig
 create mode 100644 drivers/ddr/altera/iossm_mailbox.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.h
 create mode 100644 drivers/ddr/altera/sdram_agilex7m.c
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.c
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.h
 create mode 100644 include/configs/socfpga_agilex7m_socdk.h

-- 
2.25.1

