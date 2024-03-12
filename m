Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4129DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C2F87D8E;
	Tue, 12 Mar 2024 15:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n5Z8I+XV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11D587D3C; Tue, 12 Mar 2024 15:01:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651E987D8E
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=jitloonl@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710252071; x=1741788071;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e5W/yE54rYfrEUOYynlj3e/gGgQqjPvddJMzsiGbC7U=;
 b=n5Z8I+XVHqHd2K7/sd7OQIwlBwqJfaIdOx25/DWY2+tqtIZQ0EGLvvai
 W9MJtHU1i3oWbK33PBns3vY7fAHIOS+U/fwZ7lzU5oJfEX/USpgDOXkUw
 fOScRNsNLAhvgFl4eWVIZIKf+paQnpKWbU2kBFuZz2r7P0yFIumJxnLDz
 yJGUtbJVynJ0lmA1hnVqOSqw5a48x6sQZyL/8kPgbc7FG1+FMrm4/KhrK
 Htd0jZlYNSjWpV09JYvSl7SVFRctylMxu9FX+RSbMoIlLa+Kik5TspVBr
 Rgz2LTxql5Ht0JAHQtg0QRY3R6JQBw88HpsXjRkQX5r3mclZFT1Dd+rT7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5131247"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5131247"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 07:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11519960"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by orviesa010.jf.intel.com with ESMTP; 12 Mar 2024 07:01:05 -0700
Received: from localhost (pgli0121.png.intel.com [10.221.240.84])
 by pglmail07.png.intel.com (Postfix) with ESMTP id 6EEC016910;
 Tue, 12 Mar 2024 22:01:04 +0800 (+08)
Received: by localhost (Postfix, from userid 12048045)
 id 6986725A4; Tue, 12 Mar 2024 22:01:04 +0800 (+08)
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
Subject: [PATCH v4 0/1] Agilex5 enablement
Date: Tue, 12 Mar 2024 22:01:02 +0800
Message-Id: <20240312140103.31226-1-jit.loon.lim@intel.com>
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
V4: Update defined to is_enabled

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

