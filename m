Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471AFCF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0296889335;
	Fri, 20 Sep 2024 09:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ydra71Eb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687C589357; Fri, 20 Sep 2024 09:03:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C334F8937B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815815; x=1758351815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Fkc+LC652OlNLLIAj65gculo9hnLmfHHMof5OCtiJE=;
 b=Ydra71Ebt8YfsdwR+xsSE4merT5GuNYT4zaKVG2LlP+mpveLReQgxvKK
 VWRQ+hLWdZhL6P+85KcyB/rTbRAOj/KTmIPzIBN+vN2AZ4KS4LSPSHQnU
 ohN5QR+vuhEwXC9N16+97G3+WrYKqC8aibMAn+2SeH+kcpiLp+db0OcF0
 Xp161/VEOdtg6dVZvEtHToOTuoDtNuihZ1T8g728VIeD2XdEa58bd/6w7
 7HikqnJ1u8OLX0XBdgx02vW1EHKPpi7QsX2VX5LXUvAsRss+WIHNsQqGH
 tFRQ2PzzxYHcyoUecGmslXZdy9ODj8sKZtFtMlQrfDP1ysbSLVT2u9BDA w==;
X-CSE-ConnectionGUID: sbmepBVNR9GVER0lvs78cA==
X-CSE-MsgGUID: VXft35PJSOyYBOeKhIw5VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961061"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:35 -0700
X-CSE-ConnectionGUID: IX135KbcRGW7snQE3oPsZQ==
X-CSE-MsgGUID: WGwNCN8PR5uRzd8tgbW9+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235137"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:32 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 10/20] arm: socfpga: agilex5: Enable cache flush for system
 memory cache in CCU
Date: Fri, 20 Sep 2024 15:02:32 +0800
Message-Id: <20240920070242.20884-11-tien.fong.chee@intel.com>
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

set/way instructions "dc cisw" ehich is used by the "dcache flush" command
only flushing CPU data caches from L1 -> L2 -> L3 to system memory cache in
cache coherency unit, hence this patch enables data flush from system
memory cache of CCU into DDR memory.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/Makefile     |  1 +
 arch/arm/mach-socfpga/ccu_ncore3.c | 64 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/ccu_ncore3.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index e0ada69dd5a..32b3e7a57e2 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -65,6 +65,7 @@ obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
+obj-y	+= ccu_ncore3.o
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_N5X
diff --git a/arch/arm/mach-socfpga/ccu_ncore3.c b/arch/arm/mach-socfpga/ccu_ncore3.c
new file mode 100644
index 00000000000..18667131eb9
--- /dev/null
+++ b/arch/arm/mach-socfpga/ccu_ncore3.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
+ */
+#include <wait_bit.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <linux/bitfield.h>
+
+#define CCU_DMI0_DMIUSMCTCR				SOCFPGA_CCU_ADDRESS + 0x7300
+#define CCU_DMI0_DMIUSMCMCR				SOCFPGA_CCU_ADDRESS + 0x7340
+#define CCU_DMI0_DMIUSMCMAR				SOCFPGA_CCU_ADDRESS + 0x7344
+#define CCU_DMI0_DMIUSMCMCR_MNTOP		GENMASK(3, 0)
+#define MAX_DISTRIBUTED_MEM_INTERFACE	2
+#define FLUSH_ALL_ENTRIES				0x4
+#define CCU_DMI0_DMIUSMCMCR_ARRAY_ID	GENMASK(21, 16)
+#define ARRAY_ID_TAG					0x0
+#define ARRAY_ID_DATA					0x1
+#define CACHE_OPERATION_DONE			BIT(0)
+#define TIMEOUT_200MS					200
+
+int __asm_flush_l3_dcache(void)
+{
+	int i;
+	int ret = 0;
+
+	/* Flushing all entries in CCU system memory cache */
+	for (i = 0; i < MAX_DISTRIBUTED_MEM_INTERFACE; i++) {
+		/*
+		 * Skipping if the system memory cache is not enabled for
+		 * particular DMI
+		 */
+		if (!readl((uintptr_t)(CCU_DMI0_DMIUSMCTCR + (i * 0x1000))))
+			continue;
+
+		writel(FIELD_PREP(CCU_DMI0_DMIUSMCMCR_MNTOP, FLUSH_ALL_ENTRIES) |
+			   FIELD_PREP(CCU_DMI0_DMIUSMCMCR_ARRAY_ID, ARRAY_ID_TAG),
+			   (uintptr_t)(CCU_DMI0_DMIUSMCMCR + (i * 0x1000)));
+
+		/* Wait for cache maintenance operation done */
+		ret = wait_for_bit_le32((const void *)(uintptr_t)(CCU_DMI0_DMIUSMCMAR +
+				(i * 0x1000)), CACHE_OPERATION_DONE, false, TIMEOUT_200MS,
+				false);
+		if (ret) {
+			debug("%s: Timeout while waiting for flushing tag in DMI%d done\n",
+			      __func__, i);
+			return ret;
+		}
+
+		writel(FIELD_PREP(CCU_DMI0_DMIUSMCMCR_MNTOP, FLUSH_ALL_ENTRIES) |
+			   FIELD_PREP(CCU_DMI0_DMIUSMCMCR_ARRAY_ID, ARRAY_ID_DATA),
+			   (uintptr_t)(CCU_DMI0_DMIUSMCMCR + (i * 0x1000)));
+
+		/* Wait for cache maintenance operation done */
+		ret = wait_for_bit_le32((const void *)(uintptr_t)(CCU_DMI0_DMIUSMCMAR +
+				(i * 0x1000)), CACHE_OPERATION_DONE, false, TIMEOUT_200MS,
+				false);
+		if (ret)
+			debug("%s: Timeout waiting for flushing data in DMI%d done\n",
+			      __func__, i);
+	}
+
+	return ret;
+}
-- 
2.25.1

