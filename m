Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBAC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4AB88501;
	Fri, 17 May 2024 14:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SHc5WMBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1118848F; Fri, 17 May 2024 07:28:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40444882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923711; x=1747459711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IGiaYrocjxr2xRCuqQ2aOVYaPNNQCVbvwSDoKnVT6R4=;
 b=SHc5WMBVpcjSu90eEgSYUyrtqWVvn5kfB5NQQai4YZig2WYE8cWEmJOw
 wCIKXqHIvxv8tiAy6ftZ6IZtHnYDnr98gnuvruFMXsz+gX0O6J6vO6fsh
 +ZrdOs9s4tW8OnxRlX23YmmSmQ8zTDP8shAWXaD4TD3HF48LM85jQ2w8i
 G0EZELFLIaiXdIkRp4+b4EiTOLu2CzlcPhPqZRpdaRgqRL11e6BePt29V
 G4QDGGp59EFhrp+q1aGQlPm0rAgPfCfgS68GRH4oKASF69uaz6JrGFO36
 44RscPPSTFM29efTDdRWCxJ5UPec+w2JOG2PxH9V1MnHOlmgzF9monDTy A==;
X-CSE-ConnectionGUID: 5uFSlCisS7GUYwSPz3DC1A==
X-CSE-MsgGUID: k24ijzTtQQqc4uIbCxp/aw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930056"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930056"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:30 -0700
X-CSE-ConnectionGUID: Vu/g5S0KSfqpTXWFOsejRw==
X-CSE-MsgGUID: XmcuVA04QgeAM8OV5JAZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188418"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:26 -0700
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
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 14/16] arch: arm:
 mach-socfpga: Update kconfig for new platform Agilex7 M-series
Date: Fri, 17 May 2024 13:26:59 +0800
Message-Id: <20240517052701.12949-15-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Update Kconfig for new platform Agilex7 M-series.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/Kconfig              |  4 +++-
 arch/arm/mach-socfpga/Kconfig | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 56e190adf6..f68b680d82 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -32,7 +32,9 @@ config COUNTER_FREQUENCY
 			ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036
 	default 25000000 if ARCH_LX2160A || ARCH_LX2162A || ARCH_LS1088A
 	default 100000000 if ARCH_ZYNQMP
-	default 200000000 if ARCH_SOCFPGA && ARM64 && TARGET_SOCFPGA_AGILEX5
+	default 400000000 if ARCH_SOCFPGA && ARM64 && !TARGET_SOCFPGA_AGILEX7M
+	default 200000000 if ARCH_SOCFPGA && ARM64 && TARGET_SOCFPGA_AGILEX5 && \
+			TARGET_SOCFPGA_AGILEX7M
 	default 0
 	help
 	  For platforms with ARMv8-A and ARMv7-A which features a system
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 1008232cac..2ca6336f21 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -59,6 +59,18 @@ config TARGET_SOCFPGA_AGILEX
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
+config TARGET_SOCFPGA_AGILEX7M
+	bool
+	select ARMV8_MULTIENTRY
+	select ARMV8_SET_SMPEN
+	select BINMAN if SPL_ATF
+	select CLK
+	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
+	select NCORE_CACHE
+	select SPL_CLK if SPL
+	select TARGET_SOCFPGA_SOC64
+
 config TARGET_SOCFPGA_AGILEX5
 	bool
 	select BINMAN if SPL_ATF
@@ -139,6 +151,10 @@ config TARGET_SOCFPGA_AGILEX_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex)"
 	select TARGET_SOCFPGA_AGILEX
 
+config TARGET_SOCFPGA_AGILEX7M_SOCDK
+	bool "Intel SOCFPGA SoCDK (Agilex7 M-series)"
+	select TARGET_SOCFPGA_AGILEX7M
+
 config TARGET_SOCFPGA_AGILEX5_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex5)"
 	select TARGET_SOCFPGA_AGILEX5
@@ -216,6 +232,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 endchoice
 
 config SYS_BOARD
+	default "agilex7m-socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -238,6 +255,7 @@ config SYS_BOARD
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config SYS_VENDOR
+	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
@@ -261,6 +279,7 @@ config SYS_SOC
 	default "socfpga"
 
 config SYS_CONFIG_NAME
+	default "socfpga_agilex7m_socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
-- 
2.25.1

