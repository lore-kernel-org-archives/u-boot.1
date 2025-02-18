Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B006C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC4180F62;
	Tue, 18 Feb 2025 09:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KP4k1qvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A3880F85; Tue, 18 Feb 2025 09:35:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40635807F1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867737; x=1771403737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hMamCRnULpzxGY+B+eo9gAH3QqwRAzc1naKBuKAPDUo=;
 b=KP4k1qvGnhVdEh2d2Lq9XyUnxUA2lrBzqMRkgL0zqlnvJ0UhDHu/MpJO
 Z8IqTj4wO/ujX3IoWNxRSkubUS8cwfslZr9ZQlpuPxSputOYjm+u/FtCY
 l1pgJycZYkk0kNuM7bf12hbQyNazFOXBtFeYf0mRVvqxsMs86CUzBhOap
 azkg4YMFXtiikIsfkwzakAPEbYSIwHMsG6ToGFWtINMoWbfdWjdNmWFfH
 Gl+QiCoLVlx976EgEYz+Ofrfa77oVgic2forDInTNZKlhTc6vLVcOWljn
 /+uRtvrjQbqx0BgsOGvu3ByWWJyVnMavYXY+cre5TfQF1S286QMo4zZre A==;
X-CSE-ConnectionGUID: 31d6+RIbRB6y45HvQwMKeA==
X-CSE-MsgGUID: GmDZsEFGS7GVFGu6uQUfqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028123"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028123"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:36 -0800
X-CSE-ConnectionGUID: CHJuxMNeSUyOEZCIboTh8g==
X-CSE-MsgGUID: btszcGJkT0eRo51fd15uKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237709"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:34 -0800
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
Subject: [PATCH v2 07/26] arm: socfpga: Disable GIC for Agilex5
Date: Tue, 18 Feb 2025 16:34:52 +0800
Message-Id: <20250218083511.29249-8-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

Status polling is used instead of using interrupt controller for Agilex5.

Disabling GICV3 in Agilex5 target, as well as disabling GICV2 enabled by
default for all SoCFPGA devices.

All the other SoCFPGA devices uses GICV2, thus enabling GICV2 in each of
the devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/Kconfig              | 1 -
 arch/arm/mach-socfpga/Kconfig | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3ed9494dfe4..865a56e2c8d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1110,7 +1110,6 @@ config ARCH_SOCFPGA
 	select CPU_V7A if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select DM
 	select DM_SERIAL
-	select GICV2
 	select GPIO_EXTRA_HEADER
 	select ENABLE_ARM_SOC_BOOT0_HOOK if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select OF_CONTROL
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 6b6a162f568..a76a9fb2a39 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -55,6 +55,7 @@ config TARGET_SOCFPGA_AGILEX
 	select BINMAN if SPL_ATF
 	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
@@ -64,7 +65,6 @@ config TARGET_SOCFPGA_AGILEX5
 	select BINMAN if SPL_ATF
 	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
-	select GICV3
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
@@ -74,6 +74,7 @@ config TARGET_SOCFPGA_ARRIA5
 
 config TARGET_SOCFPGA_ARRIA10
 	bool
+	select GICV2
 	select SPL_ALTERA_SDRAM
 	select SPL_BOARD_INIT if SPL
 	select SPL_CACHE if SPL
@@ -118,6 +119,7 @@ config TARGET_SOCFPGA_N5X
 	select ARMV8_SET_SMPEN
 	select BINMAN if SPL_ATF
 	select CLK
+	select GICV2
 	select FPGA_INTEL_SDM_MAILBOX
 	select NCORE_CACHE
 	select SPL_ALTERA_SDRAM
@@ -137,6 +139,7 @@ config TARGET_SOCFPGA_STRATIX10
 	select ARMV8_SET_SMPEN
 	select BINMAN if SPL_ATF
 	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
 	select TARGET_SOCFPGA_SOC64
 
 choice
-- 
2.25.1

