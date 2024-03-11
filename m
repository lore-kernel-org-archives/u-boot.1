Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C007DC54791
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 01:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF25687EB5;
	Mon, 11 Mar 2024 02:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KriDTCup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14EB87EB5; Mon, 11 Mar 2024 02:51:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AD9879F6
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 02:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=jitloonl@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710121901; x=1741657901;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ntgb0IgfdOrVbAl/R4TV/1VbDhX5WA9BoDx10HtCOeY=;
 b=KriDTCup70pkYx0d/JhJ84aV6JysfM0OZiqd5Lpj9cDzkQhV3sXoH0zQ
 99VsY2Semc5/wKgW5QD4ECWrWrdAqPH1lAr7Z10ZpRufqURGwzsMBx0eE
 ObGELHoRVFX1UCQ3vLBYAOnhcxgEVgEZXf3gESYZWJLVnggzwGNyc+bJY
 Q1w17rM1oXnN6VsnVTbbdqqVbd8/pjEV3skEJIPgVMJK5hxrZKgANeeLs
 rmrby5ip4ygMnbnAZ/VEu+MD6JomkYLBGs1upaQGnai+5yVu+kI/mcvPk
 fi0yOlH1L7FwrrwwP5M+4PZKsPIqdQm3LiUCN5HQLeYNS32dcqdc1SqU8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22289959"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22289959"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 18:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="48471242"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by orviesa001.jf.intel.com with ESMTP; 10 Mar 2024 18:51:35 -0700
Received: from localhost (pgli0121.png.intel.com [10.221.240.84])
 by pglmail07.png.intel.com (Postfix) with ESMTP id E00761644C;
 Mon, 11 Mar 2024 09:51:33 +0800 (+08)
Received: by localhost (Postfix, from userid 12048045)
 id DB9FA2385B; Mon, 11 Mar 2024 09:51:33 +0800 (+08)
From: Jit Loon Lim <jit.loon.lim@intel.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 0/1] Agilex5 enablement
Date: Mon, 11 Mar 2024 09:51:30 +0800
Message-Id: <20240311015131.24528-1-jit.loon.lim@intel.com>
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

V1: https://patchwork.ozlabs.org/project/uboot/patch/20240220143603.22091-1-jit.loon.lim@intel.com/
V2: Fixed Git auto-merge causing misalignment of code and insert/delete
V3: Added 240G FPGA DDR region

Jit Loon Lim (1):
  arch: arm: Agilex5 enablement

 arch/arm/Kconfig                              |   4 +-
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  71 ++
 arch/arm/dts/socfpga_agilex5.dtsi             | 575 ++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 133 ++++
 arch/arm/dts/socfpga_agilex5_socdk.dts        | 163 ++++
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |  38 +-
 arch/arm/mach-socfpga/Kconfig                 |  19 +-
 arch/arm/mach-socfpga/Makefile                |  14 +-
 arch/arm/mach-socfpga/board.c                 |  56 +-
 arch/arm/mach-socfpga/clock_manager_agilex5.c |  89 +++
 .../include/mach/base_addr_soc64.h            |  38 +-
 .../mach-socfpga/include/mach/clock_manager.h |   4 +-
 .../include/mach/clock_manager_agilex5.h      |  12 +
 .../mach-socfpga/include/mach/handoff_soc64.h |  31 +-
 .../mach-socfpga/include/mach/mailbox_s10.h   |   1 +
 arch/arm/mach-socfpga/mmu-arm64_s10.c         |  59 +-
 board/intel/agilex5-socdk/MAINTAINERS         |   8 +
 configs/socfpga_agilex5_defconfig             | 116 +++
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-agilex5.c              | 743 ++++++++++++++++++
 drivers/clk/altera/clk-agilex5.h              | 284 +++++++
 include/configs/socfpga_agilex5_socdk.h       |  12 +
 include/configs/socfpga_soc64_common.h        | 143 +++-
 include/dt-bindings/clock/agilex5-clock.h     |  71 ++
 include/dt-bindings/reset/altr,rst-mgr-agx5.h |  80 ++
 26 files changed, 2730 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
 create mode 100644 arch/arm/mach-socfpga/clock_manager_agilex5.c
 create mode 100644 arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
 create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
 create mode 100644 configs/socfpga_agilex5_defconfig
 create mode 100644 drivers/clk/altera/clk-agilex5.c
 create mode 100644 drivers/clk/altera/clk-agilex5.h
 create mode 100644 include/configs/socfpga_agilex5_socdk.h
 create mode 100644 include/dt-bindings/clock/agilex5-clock.h
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-agx5.h

-- 
2.26.2

