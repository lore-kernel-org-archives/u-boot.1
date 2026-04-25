Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86C7FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 827A2841DF;
	Sat, 25 Apr 2026 18:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EXBNU67o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 229CD841DF; Sat, 25 Apr 2026 18:19:13 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FB3840CB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 16:19:08 +0000
Received: from DM4PR10MB7508.namprd10.prod.outlook.com (2603:10b6:8:17d::13)
 by IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Sat, 25 Apr
 2026 05:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0F5W2xhvOn+CHNflQOohZxN1E+Q03TRICgIecJgq7CInXZbNPYkAmDjqBBBv3cRmm4DPs9pSG5iI+nYf5rPTSVBzMQWMqgWA1nYwhvucrbaKeB9vX/ZhUrLxzLhHP/bgXTb9+Zf9TIJX9wJYsb311lIcClYnYQz4fVK92DDorcW+E89oE9yoMsUeCoel3+HtnTrbtqHRJ8STBphBYrtBhqXlePMSgAPTX9iqEe6nMjuvBh2ca9SU9ySG4HtcKmnGX3/kp1jQs8CBCH4OIta3l0LA/hiUHSjCgx7xpSIU5CY3uRvD1K+67lSrrauC3CPWMC+7rx1ohJprlknRxOimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyZvgal0xdhxn50f03PuWGivdysxKM7woLEhLX4Gi7Y=;
 b=tpVWBMcgR6H9+v3MjBY60cgEFmJY2LtlVrtgXX3JRipaGCVijZ+5vwKVPcZ/cIJdr3QwNzpbQ4zy8qftHSPLH7JSMkpAU608bd1lh8jcpw12wpjq8lEBXQvAi42Wkjn3zlHpbhn+9mJd3P0EXfWdteH8zRMhhpt7jCwn+4fanUI+57P8ONKJAkZMDQtT0NpS+5cww9JzOL8b+IhHtjiy8BUiLYWVXFdU84ok8lPJ1pPQAvv+aNsRzm5oriBm/NySGONLq0A46hu6vfY19b08jsNqUtUlo88TCObdnxNKqmDvhBk1J/Zqlpznzuj31TYDTE6X5azICBIjbHcs+4JtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyZvgal0xdhxn50f03PuWGivdysxKM7woLEhLX4Gi7Y=;
 b=EXBNU67ontYgLhbtgxnZypfMIZ1b4bCI08/hSoOAYKFK9lnNHWrIcUeXLqQd7r+3raR6UPs1piUHGdPE6m1B1ZTmdpz7b5HPlPLB2pkcaDZWwvNf5QQliK1KIssnleTVuo2AP7+IEwpgFML8x+7Fo+oCmvBFJfufojKGCNPEQYY=
Received: from PH8P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::6)
 by DM4PR10MB7508.namprd10.prod.outlook.com (2603:10b6:8:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 03:38:32 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::a0) by PH8P221CA0027.outlook.office365.com
 (2603:10b6:510:2d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:29 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:28 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:28 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk892903263; Fri, 24 Apr 2026 22:38:25 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 10/11] remoteproc: k3-hsm: Introduce a remoteproc driver
 for K3 HSM core
Date: Sat, 25 Apr 2026 09:07:41 +0530
Message-ID: <20260425033742.1519298-11-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR10MB7508:EE_|IA0PR10MB7229:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e349925-fcde-4e0d-17a5-08dea27c1deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z8hrJkLsuRzvCeq7OQiQXwpzk7Vt7vfawEgzzSq+45i884HpuhAQNKV32PWRE+6YR8m8wBRhJjNDgAuvMBoUu1zwAJEymxYQr7UkB2cpzgcp7LFNv3TiIjtIG1wi9T+S0IseCnwNDFcl721cqE0hG3vMhc5Is1Wd1klmc1OVu+gBvqSgRzyZV78sPd/yMuDz3m/DbOBO80/yMX53oGxXbOVGZCbkbVNkHKk03fVNj9sIpGmN5lIpaQxLZ8/k4fc/idL1CQS/DLX8h6jQuaIfguP4Wizf4vph0rMaJHaYXJQynlD7LcFTxhzv55dDfGRaoKFCKFWpa81HD7FZs3ZaKSQmMEk3oA5tKz13gx1X0TNCeVGM1tAnMUzqKylZJupU/KnMZsjqnnMbd/poJLALz2Y9GVSypdQBoKoZGhmLcy8fM7UCG0dBIn4VzwxqJW3BTmr2yZAHgCYrZW5BGass5fKTkJ+m0dAqWn5gNbV6BwM1jP4V9lCKBYbboIBriNNK6X8xp52kg7LuXm1sAK3LFIzmqlkJys4ERmNX2z5rDlmlX1Px3HIM8U/pee1oNvXVaTM3AYHeXMrooe7VR9Gd4gJyDnBAgoG7Wyuhj+QG0vCGV7XfN9RGMNlOpWUGrvmaYHX9ESh+5Um0+Q+AVHjjJE4bOR9I9YSoppapzAuA7zRNIaZOVHFYhs4AS3AYWd+tgknsSqZR0j29FSimNcNMPUUrWP+EzFKk6gHZ1HRPV4U=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JQHuKQ2byAXvsfMw6UQz1TZbIOWCH3uElMC71UuBy3SeL0ubF6/ZQCJpmt3j7/T7su4gO9jPHfq44x397/tmvgnbCovCKtDkGryVgZwSAWlVW5auAU9151irIbqft4LkCY3eL95M59C/ZnhMuTYa32qwp2lAqnvR1ore4l/3fWJwUijxYxO2eA8hDCn2gdikBI3NCtY3d4446hCORwphmV7mHRWbBeMTg81Wt+5VEIMjpfYm9QDQ9O7Xo3vMdvagBTl9QP6IpYyWW9PiQC9aBB0Als15YROYy5bRkc8rN27H2OmogS2K8/4UedkaoOIfQNjFZDaGdGbMthUfu6Aa8bK+Exmc9sD1wUAel5id7QNPkpXnRpjAWfvkbCa1KpEAf4S1+4Ki4B2P6goJxlo1vaSXbNMB+ubtEpg05Y6aKb2o1nQZzN3S/5enC+i+ak10
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:29.3938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e349925-fcde-4e0d-17a5-08dea27c1deb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7508
X-OriginatorOrg: ti.com
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

Some K3 SoCs like J721S2, J784S4, J722S, AM62X and AM62PX have a HSM
(High Security Module) M4F core in the Wakeup Voltage Domain which could
be used to run secure services like Authentication. Boot flow for HSM M4
core is different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. For HS devices, Request Secure Entity to Authenticate and Load HSM
   firmware into core's internal SRAM memory region. For GP devices,
   load the unsigned firmware manually.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

Add a new remoteproc driver to support this boot flow for HSM M4F core.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-10-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add a dedicated remoteproc driver to boot HSM core.

 MAINTAINERS                          |   1 +
 drivers/remoteproc/Kconfig           |  10 ++
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c | 252 +++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc5cd553ec3..0678f4d59e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -814,6 +814,7 @@ F:	drivers/phy/ti-pipe3-phy.c
 F:	drivers/ram/k3*
 F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
+F:	drivers/remoteproc/ti_k3_hsm_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
 F:	drivers/remoteproc/pruc_rpoc.c
 F:	drivers/remoteproc/ti*
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index f07ae903a28..c09905b46d7 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -99,6 +99,16 @@ config REMOTEPROC_TI_K3_M4F
 	  on various TI K3 family of SoCs through the remote processor
 	  framework.
 
+config REMOTEPROC_TI_K3_HSM_M4F
+	bool "TI K3 HSM M4F remoteproc support"
+	select REMOTEPROC
+	depends on ARCH_K3
+	depends on TI_SCI_PROTOCOL
+	help
+	  Say y here to support TI's HSM M4F remote processor subsystems
+	  on various TI K3 family of SoCs through the remote processor
+	  framework.
+
 config REMOTEPROC_TI_K3_R5F
 	bool "TI K3 R5F remoteproc support"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 7ea8023c50b..d29e1bf9db2 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_DSP) += ti_k3_dsp_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_M4F) += ti_k3_m4_rproc.o
+obj-$(CONFIG_REMOTEPROC_TI_K3_HSM_M4F) += ti_k3_hsm_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_R5F) += ti_k3_r5f_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_POWER) += ti_power_proc.o
 obj-$(CONFIG_REMOTEPROC_TI_PRU) += pru_rproc.o
diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
new file mode 100644
index 00000000000..4c05fef487a
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_hsm_rproc.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' K3 HSM M4 Remoteproc driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - http://www.ti.com/
+ *	Beleswar Padhi <b-padhi@ti.com>
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <remoteproc.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <linux/sizes.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include "ti_sci_proc.h"
+#include <mach/security.h>
+
+#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4 0x00000001
+
+/**
+ * struct k3_hsm_mem - internal memory structure
+ * @cpu_addr: MPU virtual address of the memory region
+ * @bus_addr: Bus address used to access the memory region
+ * @dev_addr: Device address from remoteproc view
+ * @size: Size of the memory region
+ */
+struct k3_hsm_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	phys_addr_t dev_addr;
+	size_t size;
+};
+
+/**
+ * struct k3_hsm_mem_data - memory definitions for hsm remote core
+ * @name: name for this memory entry
+ * @dev_addr: device address for the memory entry
+ */
+struct k3_hsm_mem_data {
+	const char *name;
+	const u32 dev_addr;
+};
+
+/**
+ * struct k3_hsm_privdata - Structure representing Remote processor data.
+ * @tsp:	Pointer to TISCI proc control handle
+ * @mem:	Array of available memories
+ * @num_mems:	Number of available memories
+ */
+struct k3_hsm_privdata {
+	struct ti_sci_proc tsp;
+	struct k3_hsm_mem *mem;
+	int num_mems;
+};
+
+/**
+ * k3_hsm_load() - Load up the Remote processor image
+ * @dev:	rproc device pointer
+ * @addr:	Address at which image is available
+ * @size:	size of the image
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	size_t image_size = size;
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+	if (ret)
+		goto proc_release;
+
+	ti_secure_image_post_process((void *)&addr, &image_size);
+
+	if (image_size == size) {
+		debug("Loading HSM GP binary into SRAM0_0\n");
+		memcpy((void *)hsm->mem[0].cpu_addr, (void *)(u32)addr, size);
+		flush_dcache_range((unsigned long)hsm->mem[0].cpu_addr,
+				   (unsigned long)(hsm->mem[0].cpu_addr + size));
+	}
+
+proc_release:
+	ti_sci_proc_release(&hsm->tsp);
+	return ret;
+}
+
+/**
+ * k3_hsm_start() - Start the remote processor
+ * @dev:	rproc device pointer
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+static int k3_hsm_start(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp, 0,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static int k3_hsm_stop(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ti_sci_proc_request(&hsm->tsp);
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static const struct dm_rproc_ops k3_hsm_ops = {
+	.load = k3_hsm_load,
+	.start = k3_hsm_start,
+	.stop = k3_hsm_stop,
+};
+
+static int ti_sci_proc_of_to_priv(struct udevice *dev, struct ti_sci_proc *tsp)
+{
+	u32 ids[2];
+	int ret;
+
+	tsp->sci = ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(tsp->sci)) {
+		dev_err(dev, "ti_sci get failed: %ld\n", PTR_ERR(tsp->sci));
+		return PTR_ERR(tsp->sci);
+	}
+
+	ret = dev_read_u32_array(dev, "ti,sci-proc-ids", ids, 2);
+	if (ret) {
+		dev_err(dev, "Proc IDs not populated %d\n", ret);
+		return ret;
+	}
+
+	tsp->ops = &tsp->sci->ops.proc_ops;
+	tsp->proc_id = ids[0];
+	tsp->host_id = ids[1];
+	tsp->dev_id = dev_read_u32_default(dev, "ti,sci-dev-id",
+					   TI_SCI_RESOURCE_NULL);
+	if (tsp->dev_id == TI_SCI_RESOURCE_NULL) {
+		dev_err(dev, "Device ID not populated %d\n", ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct k3_hsm_mem_data hsm_mems[] = {
+	{ .name = "sram0_0", .dev_addr = 0x0 },
+	{ .name = "sram0_1", .dev_addr = 0x20000 },
+	{ .name = "sram1",   .dev_addr = 0x30000 },
+};
+
+static int k3_hsm_of_get_memories(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int i;
+
+	hsm->num_mems = ARRAY_SIZE(hsm_mems);
+	hsm->mem = calloc(hsm->num_mems, sizeof(*hsm->mem));
+	if (!hsm->mem)
+		return -ENOMEM;
+
+	for (i = 0; i < hsm->num_mems; i++) {
+		hsm->mem[i].bus_addr = dev_read_addr_size_name(dev,
+							       hsm_mems[i].name,
+							       (fdt_addr_t *)&hsm->mem[i].size);
+		if (hsm->mem[i].bus_addr == FDT_ADDR_T_NONE) {
+			dev_err(dev, "%s bus address not found\n",
+				hsm_mems[i].name);
+			return -EINVAL;
+		}
+		hsm->mem[i].cpu_addr = map_physmem(hsm->mem[i].bus_addr,
+						   hsm->mem[i].size,
+						   MAP_NOCACHE);
+		hsm->mem[i].dev_addr = hsm_mems[i].dev_addr;
+	}
+
+	return 0;
+}
+
+/**
+ * k3_hsm_probe() - Basic probe
+ * @dev:	corresponding k3 remote processor device
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_probe(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm;
+	int ret;
+
+	hsm = dev_get_priv(dev);
+
+	ret = ti_sci_proc_of_to_priv(dev, &hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = k3_hsm_of_get_memories(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int k3_hsm_remove(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+
+	free(hsm->mem);
+
+	return 0;
+}
+
+static const struct udevice_id k3_hsm_ids[] = {
+	{ .compatible = "ti,hsm-m4fss" },
+	{}
+};
+
+U_BOOT_DRIVER(k3_hsm) = {
+	.name = "k3_hsm",
+	.of_match = k3_hsm_ids,
+	.id = UCLASS_REMOTEPROC,
+	.ops = &k3_hsm_ops,
+	.probe = k3_hsm_probe,
+	.remove = k3_hsm_remove,
+	.priv_auto = sizeof(struct k3_hsm_privdata),
+};
-- 
2.34.1

