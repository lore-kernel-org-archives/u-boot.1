Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80033C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 07:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC74F87E2E;
	Mon, 26 Feb 2024 08:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="npom1dT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B14687E06; Mon, 26 Feb 2024 08:07:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646A187E2E
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 08:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=jitloonl@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708931232; x=1740467232;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RKSxgMgSK5Hw1xk1TAzErHatYMqWaJAeJty/J12Lxe0=;
 b=npom1dT9WIzUCqPwHumo79TGo5lMkVpwlJSx7RLwiz/l1n1vsje9z3Eh
 oRr4iMrv3AT1wkwY1vLroIYhFrjdqLr5m//0XKj9KajbWG2kq4t7oVx3b
 9iPjIWkcuDVE7Afgrye3L5jEwpW9xjnDEj5cNfuP7Ofc6kOzFYl+CEzVT
 AbL/yPQ0Uhmnk8udpBp7XlQ9dVKwpMgb8+aZXu0C+ujzuFTsX0siKsZj7
 X520zz1lNAb39tONXknuGK8BuXAr0PKgLIq+oXqRKz7Wf36yXXSp6YnTU
 D75QIFapMeJTzlIQ6tZhUXVZrAtiYcTbBQRnUNnAKTLjJ61OE3FJoMWXv w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3061223"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3061223"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:07:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11160119"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2024 23:07:07 -0800
Received: from localhost (pgli0121.png.intel.com [10.221.240.84])
 by pglmail07.png.intel.com (Postfix) with ESMTP id 831EF1644B;
 Mon, 26 Feb 2024 15:07:06 +0800 (+08)
Received: by localhost (Postfix, from userid 12048045)
 id 7B8B21688D; Mon, 26 Feb 2024 15:07:06 +0800 (+08)
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
Subject: [PATCH v2 0/1] Agilex5 enablement
Date: Mon, 26 Feb 2024 15:07:03 +0800
Message-Id: <20240226070704.15153-1-jit.loon.lim@intel.com>
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

V1: https://patchwork.ozlabs.org/project/uboot/patch/20240220143603.22091-1-jit.loon.lim@intel.com/
V2: Fixed Git auto-merge causing misalignment of code and insert/delete

Jit Loon Lim (1):
  arch:arm: Agilex5 enablement

 arch/arm/Kconfig                              |  13 +-
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 458 ++++++++++++
 arch/arm/dts/socfpga_agilex5.dtsi             | 654 ++++++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 144 ++++
 arch/arm/dts/socfpga_agilex5_socdk.dts        | 163 +++++
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |  38 +-
 arch/arm/mach-socfpga/Kconfig                 |  69 +-
 arch/arm/mach-socfpga/Makefile                |   4 +-
 arch/arm/mach-socfpga/board.c                 |  56 +-
 .../include/mach/base_addr_soc64.h            |  44 +-
 board/intel/agilex5-socdk/MAINTAINERS         |   8 +
 board/intel/agilex5-socdk/Makefile            |   7 +
 configs/socfpga_agilex5_defconfig             | 113 +++
 include/configs/socfpga_agilex5_socdk.h       |  12 +
 include/configs/socfpga_soc64_common.h        | 209 +++++-
 16 files changed, 1957 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
 create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
 create mode 100644 board/intel/agilex5-socdk/Makefile
 create mode 100644 configs/socfpga_agilex5_defconfig
 create mode 100644 include/configs/socfpga_agilex5_socdk.h

-- 
2.26.2

