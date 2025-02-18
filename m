Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD71C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F74B80FA6;
	Tue, 18 Feb 2025 09:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d24SGIKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6085D80F60; Tue, 18 Feb 2025 09:36:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AF1807F1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867764; x=1771403764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Tzm7DIV3vqiFTcT8TQK8o8kG+aiDYy/qPy06dh/8A0=;
 b=d24SGIKdXvfyK20IFivXwdZv2eUPQm8AR1aNxTAI+TM+/jPKxiaxf6Wk
 +A6MDQFHzy5qTDTiDFH6okZwafZgnjoV7a8t/09G/2DwdQebXtuUtY/MY
 9F0hyMX/DdToqVKrORAC7Va2Kei0r+SUB2Z4bp5gBSKIL1BCC3ZE0wFPr
 bxBbWZ5MbizdUTv44mHtKg7YQNDu2NRF4N1IN9OfWt5VV023dOnOzW0ZK
 DO5uoGB+9U/dtZ1PvK0xwAqigzdZ6sbvaVvVlRAE4aBrE465B0/B0Wbe3
 yglQfNUhFqh9/7eCddl/w8NJBs8lhZjTWHHbpfWfmvn77yW6Lx3/HvHlE g==;
X-CSE-ConnectionGUID: AiFjWWemQ/yI5AjjIn5l8g==
X-CSE-MsgGUID: 4elVFw9wQCaaKrl0QH21yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028189"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028189"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:04 -0800
X-CSE-ConnectionGUID: 0YTzLrrzR4C/jBVkmyfTGA==
X-CSE-MsgGUID: Ho9ilk+STyCjLz54RT+gJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237789"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:01 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v2 18/26] arm: socfpga: smc: Add memory coherency support to
 mailbox command
Date: Tue, 18 Feb 2025 16:35:03 +0800
Message-Id: <20250218083511.29249-19-alif.zakuan.yuslaimi@intel.com>
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

As cache is enabled in U-Boot and disabled in ATF(BL31). We need to
perform cache flush of buffers that are shared between U-Boot and
ATF using secure monitor calls.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- cast as uintptr_t instead of u64
---
 arch/arm/mach-socfpga/smc_api.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index ebaa0b8fa17..b212a94b321 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
+#include <cpu_func.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/errno.h>
@@ -40,10 +42,16 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urgent, u32 *resp_buf_len,
 	args[2] = len;
 	args[3] = urgent;
 	args[4] = (u64)resp_buf;
-	if (resp_buf_len)
+
+	if (arg && len > 0)
+		flush_dcache_range((uintptr_t)arg, (uintptr_t)arg + len);
+
+	if (resp_buf && resp_buf_len && *resp_buf_len > 0) {
 		args[5] = *resp_buf_len;
-	else
+		flush_dcache_range((uintptr_t)resp_buf, (uintptr_t)resp_buf + *resp_buf_len);
+	} else {
 		args[5] = 0;
+	}
 
 	ret = invoke_smc(INTEL_SIP_SMC_MBOX_SEND_CMD, args, ARRAY_SIZE(args),
 			 resp, ARRAY_SIZE(resp));
-- 
2.25.1

