Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690A6C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 07:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97ADB801DE;
	Fri, 21 Feb 2025 08:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b7DNM2mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2006D806FE; Fri, 21 Feb 2025 08:26:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC2C8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740122793; x=1771658793;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BSrkzHY1IN9PCLxRMBR3GdASQFFgnYbK9pG7nOoaJdk=;
 b=b7DNM2mzDR/NMReEc2N3JInY3X2iebMwhcMd0Q9CpyQyE1n9ibTynQco
 iTM6SSgpaehJ/u5Fsx5vqqg2SdtFFrxbHkAI70bidYaYMJcZ7UBqnn959
 aEuyANtMBNFw3eiF+k71uWURlgGPpcrkpfcDR9GHCyWmnESzwsEzdxzIG
 TcHAQXWBqh0ROP5tHN72/y1NggOJNka+fTNjKSHfPu/Bu/o1soPLbx3Kt
 UuZcD6m4I/Q07KLBRxlG059HV7+phHVaYY4zd+ZEvOFhTVaKgLTTQPEOb
 fSA3JyjCeNF9A+MNLOK7bfBvYgfa6nEPR40IYIJ2wzhVfWpxq2PuLifGp Q==;
X-CSE-ConnectionGUID: cxVXPp/hT+qyPW9heormcg==
X-CSE-MsgGUID: bszqiGn9T/2z1ZOPYorS8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44719494"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="44719494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 23:26:31 -0800
X-CSE-ConnectionGUID: l0n0deV/RmOY6cneyTC3mg==
X-CSE-MsgGUID: CdB+p1zJTD2a0C2tFQxkMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115241292"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by orviesa006.jf.intel.com with ESMTP; 20 Feb 2025 23:26:29 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v1] arm: socfpga: soc64: boot_scratch_cold 8 and 9 usage
 documentation
Date: Fri, 21 Feb 2025 15:26:22 +0800
Message-Id: <20250221072622.24035-1-alif.zakuan.yuslaimi@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

The boot_scratch_cold register is generally used for passing
critical system info between SPL, U-Boot and Linux.

Documenting the usage of boot_scratch_cold8 and boot_scratch_cold9
sticky registers for capturing the Uncorrected Errors
(UE) and the UE Address. This is to avoid overlapping usage in the
code for S10 and Agilex.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/system_manager_soc64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 78eff247978..bfc31a14cfe 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -65,7 +65,9 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD6		0x218
 /* store VBAR_EL3 value */
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD7		0x21c
+/* store ECC DBE register */
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD8		0x220
+/* store ECC DBE address */
 #define SYSMGR_SOC64_BOOT_SCRATCH_COLD9		0x224
 #define SYSMGR_SOC64_PINSEL0			0x1000
 #define SYSMGR_SOC64_IOCTRL0			0x1130
-- 
2.26.2

