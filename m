Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE83DC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78190884CE;
	Fri, 17 May 2024 14:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HgNlHl1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAAD5883C7; Fri, 17 May 2024 07:28:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905888848D
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923715; x=1747459715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uN58CPHe8H/Z+b+d1zJADT0R04mXrEun4IRj8COLnvU=;
 b=HgNlHl1N27YiLfKAAtY0InMhvBJekNj7TpoHRGykgNagyt9qe8PbTpTI
 5pXaDJep4UNszRdfzAWszBXYZClFidauwYVJ+fMna8qEjzlvwKP+hzmvp
 xs9I04QnyUID0OE8sxl0ujwi9r9B7XBSylEvzXqs6UwhjWJWNDE7LqUKc
 iMJ1j5McmtUrnNckpx0gDFMlsHFSfub4IK7bVVz9ndV8CF2YkUc4GAEOG
 MtQYOvDqlnvR8fT+/2po5jDTOf7gydlRWSbOUr/MxyCCgd+Zl38R+C/NV
 2unX1L1cAyj9MtLBVJzHVfkXqZdpRF32T1yDspLkDzzNvVy9jjb98M6ST g==;
X-CSE-ConnectionGUID: V9sPUhYgSgOV3SqbWZq2RA==
X-CSE-MsgGUID: P+w/ssLKSsGb1ZTSDrm/4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930066"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:35 -0700
X-CSE-ConnectionGUID: NEO2flzeTCCGGCkU52+5jw==
X-CSE-MsgGUID: Hp1BmZ0nS1eHZY286Ruk7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188484"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:30 -0700
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
Subject: [Agilex7 M-series Platform Enablement v1 15/16] arch: arm: dts:
 Update Makefile for new platform Agilex7 M-series
Date: Fri, 17 May 2024 13:27:00 +0800
Message-Id: <20240517052701.12949-16-tingting.meng@intel.com>
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

Update Makefile to support Agilex7 M-series platform enablement.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/dts/Makefile               |  1 +
 arch/arm/mach-socfpga/Makefile      | 18 ++++++++++++++++++
 board/intel/agilex7m-socdk/Makefile |  7 +++++++
 3 files changed, 26 insertions(+)
 create mode 100644 board/intel/agilex7m-socdk/Makefile

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7b7788f755..c056e0e78e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -547,6 +547,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex_socdk.dtb			\
 	socfpga_agilex5_socdk.dtb			\
+	socfpga_agilex7m_socdk.dtb			\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 67c6a8dfec..856fd597f6 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -65,6 +65,21 @@ obj-y	+= reset_manager_s10.o
 obj-y	+= wrap_pll_config_soc64.o
 endif
 
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
+obj-y	+= clock_manager_agilex.o
+obj-y	+= lowlevel_init_soc64.o
+obj-y	+= mailbox_s10.o
+obj-y	+= misc_soc64.o
+obj-y	+= mmu-arm64_s10.o
+obj-y	+= reset_manager_s10.o
+obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-y	+= system_manager_soc64.o
+obj-y	+= timer_s10.o
+obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
+obj-y	+= wrap_handoff_soc64.o
+obj-y	+= wrap_pll_config_soc64.o
+endif
+
 ifdef CONFIG_TARGET_SOCFPGA_N5X
 obj-y	+= clock_manager_n5x.o
 obj-y	+= lowlevel_init_soc64.o
@@ -107,6 +122,9 @@ endif
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
 obj-y	+= spl_soc64.o
 endif
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
+obj-y	+= spl_agilex7m.o
+endif
 else
 obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
 obj-$(CONFIG_SPL_ATF) += smc_api.o
diff --git a/board/intel/agilex7m-socdk/Makefile b/board/intel/agilex7m-socdk/Makefile
new file mode 100644
index 0000000000..ff5d9dde3b
--- /dev/null
+++ b/board/intel/agilex7m-socdk/Makefile
@@ -0,0 +1,7 @@
+
+# Copyright (C) 2024 Intel Corporation <www.intel.com>
+#
+# SPDX-License-Identifier:	GPL-2.0
+#
+
+obj-y	:= socfpga.o
-- 
2.25.1

