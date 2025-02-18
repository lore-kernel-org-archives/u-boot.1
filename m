Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E877C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6150E80F95;
	Tue, 18 Feb 2025 09:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MIUMSwjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD2280F92; Tue, 18 Feb 2025 09:35:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE5880C72
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867752; x=1771403752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zKG2YZv6zr+jCvT/x+d52eVabMxnuNzjSeA1psr5oO4=;
 b=MIUMSwjDQ/ZKS3wApX/s/JEnY8k2WjeBjUeGm8KlLXWcdaqtj+PAKF5S
 jYcwykteNTVuxZBOEAhiFTJk2cmD6fKpHPx7NBIytlEk8Yeqevocdc+7V
 zf9fe5UEkCxLAbNRkgbch0e7lJJa3sdCxDNwW6zAhjlKxqBWNPzZFX4T2
 +OWq4ZbYcnEQNSNiziT3hQg7zEvWrZBXuI0g+Fzzena9klicUmiw+2IwT
 xF4tps4SnQlh+Y0NfexMxR2SL2pJwRutgXt7AcHDVM8zGb9pFjGWNJ9EQ
 VEnidxMgqCxWsCTaQxCT1PguPCP3f99vsVcNOgm9lbSJwVBjKOh4/KbdB A==;
X-CSE-ConnectionGUID: WsparB4WSkuDPc0yHxiuVg==
X-CSE-MsgGUID: Y2v/AqzHT++Bu/tH8LKQ5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028161"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028161"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:51 -0800
X-CSE-ConnectionGUID: 7/yJUQERTxeMJMtzxwDbHQ==
X-CSE-MsgGUID: tOPz2L5KRVqvLklWmMxG3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237747"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:49 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 13/26] arm: socfpga: agilex5: Enable cache flush for system
 memory cache in CCU
Date: Tue, 18 Feb 2025 16:34:58 +0800
Message-Id: <20250218083511.29249-14-alif.zakuan.yuslaimi@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

set/way instructions "dc cisw" which is used by the "dcache flush" command
only flushing CPU data caches from L1 -> L2 -> L3 to system memory cache in
cache coherency unit, hence this patch enables data flush from system
memory cache of CCU into DDR memory.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Makefile     |  1 +
 arch/arm/mach-socfpga/ccu_ncore3.c | 64 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/ccu_ncore3.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index cd9e9272024..b6897ba42b1 100644
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
index 00000000000..a399aedcd10
--- /dev/null
+++ b/arch/arm/mach-socfpga/ccu_ncore3.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
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

