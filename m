Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2D5CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3161489387;
	Fri, 20 Sep 2024 09:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UAzzjXTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4F68938C; Fri, 20 Sep 2024 09:03:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E2989357
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815813; x=1758351813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Kx9xynE0bKh0Xuiqj2UFjj2/BmZ7FW5HMaQmtxUcKQ=;
 b=UAzzjXTaRlsn4y6b9M1MZg2MhYK7U54Pi+QxKMyGq8tuRu7W8Mfm9IRo
 tA3VVwevu2Krx7a/07VXsNNGQcYd6OUJVt+UQE5/VB53EkfgOL395P2DX
 3g4BZlqZRiLautriLG9PoSel3mBIsoaFEk1u1+edhdvNUr49wahN9mHCc
 EgKe57VzskGqI8SRqy42JbXfj0Ql92Qq528yBRRURtYGy7ETJZjWmlM2I
 4O4Vs6CHcMGef1OzuTLvb0Qb2nSTU+2p5AYdz9w9hQTWhSveoooc2UFJy
 VK/nUwmsQy/tUg+6vIsHxEEVWSeCBbrQm9r8rWI7+ohQ0RhO+xmxIOUtb A==;
X-CSE-ConnectionGUID: 4VKV4bJBSP6OIEUv24Ailw==
X-CSE-MsgGUID: V+OrjJRRQYyBVV7REDHGRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961057"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961057"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:32 -0700
X-CSE-ConnectionGUID: wKaQqltxSzaGQu5/GV47qg==
X-CSE-MsgGUID: Xtv+Bf+FRjijM92uufUFQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235126"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:30 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 09/20] sysreset: Add reset support to SoCFPGA Agilex5 device
Date: Fri, 20 Sep 2024 15:02:31 +0800
Message-Id: <20240920070242.20884-10-tien.fong.chee@intel.com>
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

The reset driver can support both cold reset and warm reset with SMCC
to ATF.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/Kconfig                            |  1 +
 drivers/sysreset/Kconfig                    |  7 +++
 drivers/sysreset/Makefile                   |  1 +
 drivers/sysreset/sysreset_socfpga_agilex5.c | 47 +++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_socfpga_agilex5.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba0359fed5a..8e9a39e7d23 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1123,6 +1123,7 @@ config ARCH_SOCFPGA
 	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
 	  TARGET_SOCFPGA_SOC64
+	select SYSRESET_SOCFPGA_AGILEX5 if TARGET_SOCFPGA_AGILEX5
 	imply CMD_DM
 	imply CMD_MTDPARTS
 	imply CRC32_VERIFY
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 121194e4418..8dc1e7fec58 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -156,6 +156,13 @@ config SYSRESET_SOCFPGA_SOC64
 	  This enables the system reset driver support for Intel SOCFPGA
 	  SoC64 SoCs.
 
+config SYSRESET_SOCFPGA_AGILEX5
+	bool "Enable support for Intel SOCFPGA AGILEX5 device"
+	depends on ARCH_SOCFPGA && TARGET_SOCFPGA_AGILEX5
+	help
+	  This enables the system reset driver support for Intel SOCFPGA
+	  AGILEX5 device.
+
 config SYSRESET_TEGRA
 	bool "Tegra PMC system reset driver"
 	depends on ARCH_TEGRA
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index a6a0584585c..c090db48af4 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
 obj-$(CONFIG_SYSRESET_SBI) += sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
+obj-$(CONFIG_SYSRESET_SOCFPGA_AGILEX5) += sysreset_socfpga_agilex5.o
 obj-$(CONFIG_SYSRESET_TEGRA) += sysreset_tegra.o
 obj-$(CONFIG_SYSRESET_TI_SCI) += sysreset-ti-sci.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_TPS65910) += sysreset_tps65910.o
diff --git a/drivers/sysreset/sysreset_socfpga_agilex5.c b/drivers/sysreset/sysreset_socfpga_agilex5.c
new file mode 100644
index 00000000000..3cb7849ec88
--- /dev/null
+++ b/drivers/sysreset/sysreset_socfpga_agilex5.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <env.h>
+#include <errno.h>
+#include <sysreset.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/system.h>
+
+static int socfpga_sysreset_request(struct udevice *dev,
+				    enum sysreset_t type)
+{
+#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+	const char *reset = env_get("reset");
+
+	if (reset && !strcmp(reset, "warm")) {
+		/* Ensure content in dcache is flushed to system memory */
+		flush_dcache_all();
+
+		/* request a warm reset */
+		puts("Do warm reset now...\n");
+
+		/* doing architecture system reset */
+		psci_system_reset2(0, 0);
+	} else {
+		puts("Issuing cold reset REBOOT_HPS\n");
+		psci_system_reset();
+	}
+#endif
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops socfpga_sysreset = {
+	.request = socfpga_sysreset_request,
+};
+
+U_BOOT_DRIVER(sysreset_socfpga) = {
+	.id	= UCLASS_SYSRESET,
+	.name	= "socfpga_sysreset",
+	.ops	= &socfpga_sysreset,
+};
-- 
2.25.1

