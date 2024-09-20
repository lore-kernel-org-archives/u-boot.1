Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E742CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB9389398;
	Fri, 20 Sep 2024 09:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HSwc+mb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667F3893A0; Fri, 20 Sep 2024 09:03:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C69289394
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815827; x=1758351827;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BCBe+N5WRh5SmVzCtd/poysuRUMIbYh8AH6JpKtCzEM=;
 b=HSwc+mb37UggA4K0sCAPc8BHIc6YmoTDJIX/62/doH3fZTO87dzBHKwR
 L+1+NvOTFIcsSmgHbng4/UQrAYbzqS9HdQopKCWILAIRlf1huyzFrsiiR
 1ASmyn0HDgNp4dVcZ96np18O4SvFJwtD1VWl5PT3MNZnunYKNmJZSup0C
 H8X2b+FSCWfvD9YY1Wi3pcyGiAHMDKVDsCu3fdsWoD5pbWODVSIi8TR+T
 oO3a6YgCUL2vNezeQ0HtIgtlPuFIWvPpLhdyul3iPbT04RGXTROXitRrL
 BTDdig0Pp8vfwKiKYyypSmrkiX82NuGk+KctGY6FdfGkaQZ3ud9+zV8i9 w==;
X-CSE-ConnectionGUID: EL+iePQFRAeWXLTpiofBIw==
X-CSE-MsgGUID: xpRECENWREyoCm3wL8tupw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961096"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:46 -0700
X-CSE-ConnectionGUID: G7f9pX2uTE6RQ7eC/tBapg==
X-CSE-MsgGUID: NWInAH4bRQmnKL+lLFmRLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235242"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:43 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Mahesh Rao <mahesh.rao@intel.com>
Subject: [PATCH v1 15/20] arm: socfpga: smc: Add memory coherency support to
 mailbox command
Date: Fri, 20 Sep 2024 15:02:37 +0800
Message-Id: <20240920070242.20884-16-tien.fong.chee@intel.com>
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

As cache is enabled in U-Boot and disabled in ATF(BL31). We need to
perform cache flush of buffers that are shared between U-Boot and
ATF using secure monitor calls.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/smc_api.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index ebaa0b8fa17..dac888c399f 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ * Copyright (C) 2020-2024 Intel Corporation <www.intel.com>
  *
  */
 
+#include <cpu_func.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/errno.h>
@@ -40,10 +41,16 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urgent, u32 *resp_buf_len,
 	args[2] = len;
 	args[3] = urgent;
 	args[4] = (u64)resp_buf;
-	if (resp_buf_len)
+
+	if (arg && len > 0)
+		flush_dcache_range((u64)arg, (u64)arg + len);
+
+	if (resp_buf && resp_buf_len && *resp_buf_len > 0) {
 		args[5] = *resp_buf_len;
-	else
+		flush_dcache_range((u64)resp_buf, (u64)resp_buf + *resp_buf_len);
+	} else {
 		args[5] = 0;
+	}
 
 	ret = invoke_smc(INTEL_SIP_SMC_MBOX_SEND_CMD, args, ARRAY_SIZE(args),
 			 resp, ARRAY_SIZE(resp));
-- 
2.25.1

