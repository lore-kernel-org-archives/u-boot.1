Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2578EC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC30488164;
	Thu, 28 Mar 2024 12:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZcRPGMHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF3E880BE; Thu, 28 Mar 2024 07:26:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B05983330
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 07:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wan.yee.lau@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711607158; x=1743143158;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=92NVJokzEoeojFY/CdV0eLReTX21ZYzoQTyWSMubJb8=;
 b=ZcRPGMHTJtuZ1sx5F0/mvn7o4sZitxqlUZZM7R6YuRxQHr6yLSCueEX7
 CT033uwZqEb45m69kN7bp0alvjXeriYLTi1c84zx1CSwizjPl14yOWhVi
 3pj53QL6pHKrbpOFodWczY4nc2jTGQIe6CxlaLn3YvM4IEJZJ/P5Wp9ss
 BBZTu5yMyPYhBI/8xYPt8o60cSTMg6PIv85Oon/5tamlZxiq1a2c2YegO
 UwnukGXGX0cqvm/tX2OJza5eWppt/k/IAKHe9jbVHbAkooX5hLNSiAJri
 b2rfPcfHE8ByUbpwZQ8IJHN1UiomaR8qiBVtQQl2Ph6asNywsE0J/Cv0W w==;
X-CSE-ConnectionGUID: CxirCGqHRb63SrV3RFqTTA==
X-CSE-MsgGUID: DfqjNoorRUiYLWj/otH/kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17890171"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="17890171"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 23:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="39669916"
Received: from pgli0078.png.intel.com ([10.221.240.41])
 by fmviesa002.fm.intel.com with ESMTP; 27 Mar 2024 23:25:55 -0700
From: wan.yee.lau@intel.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>, Marek <marex@denx.de>,
 Kok Kiang <kok.kiang.hea@intel.com>
Subject: [PATCH v1 1/1] [U-Boot] drivers: misc: Fixes: Rename
 CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_REG
Date: Thu, 28 Mar 2024 14:24:00 +0800
Message-Id: <20240328062400.11208-1-wan.yee.lau@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 12:43:31 +0100
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

Commit 3f190c55a4211215914126b74357344342329943
("drivers: misc: Add socfpga_dtreg driver for Intel SoCFPGA")

This commit rename CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_REG
in Makefile.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
---
 drivers/misc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1522f6c3b7..5bb1b315cd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -90,4 +90,4 @@ obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
-obj-$(CONFIG_SPL_SOCFPGA_SEC_REG) += socfpga_dtreg.o
+obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
-- 
2.25.1

