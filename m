Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255F5CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9658939A;
	Fri, 20 Sep 2024 09:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mG+4IxEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEDD89394; Fri, 20 Sep 2024 09:03:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8C489357
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815822; x=1758351822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VMxjvPDP15bgcOVs4blEaWXFcHbrmAXQkKQgVueFPEM=;
 b=mG+4IxEH432M22eIVLje7cIypKSykL6omWVxneurq0yJ/EWrRDbYOvCE
 eT8EH2nQep2S1pmb/SbIL5+Kl6TqPHBFujgPybpcAL0FIoemd1haHta5i
 nNUEtsqow4mpxedYrVwOio93yerh6MEIAbVBJC3xeALkbnMHpQ2Gauvin
 Lu00pymOn5LCJ2SZIN5OpeHKCIpL1dcK5EJcrrPnrU5eT5lBAcvqb1nUO
 DVMFZn7bptQa1ffoDw5H1ASaDrGeGcktQQmppqLqbJPDpYt+BRqBgHUee
 QupM2kcYcV+gRiu29iCdn/UgwGK1Oph/3XRw293vW/eBuzg5WwMfzv23i g==;
X-CSE-ConnectionGUID: RISwr5fSQKm3JKgjrQfFiA==
X-CSE-MsgGUID: gPgoEtLNRuyi5yoqzOFU4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961072"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961072"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:39 -0700
X-CSE-ConnectionGUID: o//TV7sPSwCAP8bUhd5A1A==
X-CSE-MsgGUID: EH8EIMFBTty5I6uWA0m45A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235172"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:37 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 12/20] arm: socfpga: agilex5: Update CPU info
Date: Fri, 20 Sep 2024 15:02:34 +0800
Message-Id: <20240920070242.20884-13-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

Update the print info per Agilex 5.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/misc_soc64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index a6cc78454da..95e1c07e39f 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -45,7 +45,12 @@ static Altera_desc altera_fpga[] = {
 #if defined(CONFIG_DISPLAY_CPUINFO)
 int print_cpuinfo(void)
 {
-	puts("CPU:   Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A53)\n");
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
+		puts("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A55/A76)");
+		puts("\n");
+	} else {
+		puts("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-A53)\n");
+	}
 
 	return 0;
 }
-- 
2.25.1

