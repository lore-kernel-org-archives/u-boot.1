Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C309AEE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550F684129;
	Wed, 31 Dec 2025 18:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cUxuoW5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDED840DE; Wed, 31 Dec 2025 18:37:12 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9765284148
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmdBMxYPX9wchbFSbynLUjrRqq6NrzTRYhGrVX9OOUFOzFmkd499V48+5OCdlmZ4AozUp7V0K0WYLdl9BnKwe0ZhGqKB9zRGiMLjkFA+z0Jd5yiFx2n2JYQV90ANJTGWscnVLTr/ZkdnjlnTUEK9lKL2mhKw4OYaLd66puNCsnlJ/1WblMxgpktVUSQpHIcvZSc3kBUpqhfA0PJlCpRVnN5P74RyN8u+eWbNLWPzyKwmrM/Zrq7dbsrhgfel0tWgjmJtMdqWQbDrptSH7oGKto77eH1TAriy8HBQD0HbgMvnjBVcE2dPiuKvl3yLSu6ItrAl7hH+FldCc5IEXwe3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z51kc8numzwSGTYuc5c/ZQFtRZveFrP5BfqorkTE8yg=;
 b=jOkY7A2b3FAOD2tPlMe8JTFExfwobaRLAmWBtmJ1QjZgXAviTXLkAVtNwGkVjZ/jH4Kh39k55S34O+f/1meyZOhXXx5OlyXcBa5VWuqeObKcl6ZY5YWr1HpVOj/Y8nVkYy1mmWWbUaompD2TdMp/kymsnV2riQRp01nbMUSWXEdHmRftiwvFrjFSKJgfQWpVpVlNbWnuoF3RDwcKQatHD3eVId+fofne+RVlgr21Nm4yydCyR7YFu+hLq+qorKy84mUMC4jxsq187xj6xi2HRrDL1v+i7dtkB9CeR+PZxdt/XNwiPbzmCTWh38TNjvnAdTNaWDBkE+eQ03NA+Kn0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z51kc8numzwSGTYuc5c/ZQFtRZveFrP5BfqorkTE8yg=;
 b=cUxuoW5qyHcxoyED0BD3C+WsOKnP6n7mKkg/4+sz7G35TXATgOo5AcUm0H0QNXaYSxKs1OiKd4vw0A1u+FmopKn0N//0kRyamPAwQwnHWwfiUaa+KunoN7IeBJ87qoSetoY7CpQWneUME998oruc4PRpIeXenzpYpEScCU3wO84=
Received: from CH2PR14CA0054.namprd14.prod.outlook.com (2603:10b6:610:56::34)
 by SN7PR10MB6362.namprd10.prod.outlook.com (2603:10b6:806:26e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:37:06 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::94) by CH2PR14CA0054.outlook.office365.com
 (2603:10b6:610:56::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:37:03 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:59 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:59 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOr02541396;
 Wed, 31 Dec 2025 11:36:56 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 09/11] remoteproc: k3-hsm: Introduce a remoteproc driver
 for K3 HSM core
Date: Wed, 31 Dec 2025 23:06:19 +0530
Message-ID: <20251231173621.1069988-10-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SN7PR10MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7f5925-92a1-4410-8c88-08de48933601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JWfcgLKz5w8f9kQCWUJpyX0PnFoexhZj+K/wRSH1yUE0xYHS5aOUltPwHFji?=
 =?us-ascii?Q?LvUKeUavRwHaV6QkvKQgR8lWMrtsyRSpr0RkonqIvy1rgX2OXRfyXw/6WPQk?=
 =?us-ascii?Q?sYeZIcHmZb+UBcXP/AoB+U6ESe+bvNuzmlpCCuwKYYs4BBTFd8xDFxzQ+mbK?=
 =?us-ascii?Q?qGIrJnGd5vfQTfl4mZTZrJJavz5w1uHluMYxUfFeyIaVRuPgAnkUaMOds5xg?=
 =?us-ascii?Q?w292WWaHLpevD+oV1SLg/2u6g7EORkavFWnQ+ublNAwNXyuCBLWfBucII8/L?=
 =?us-ascii?Q?pUcfYeQaWHa4BlWDfIBOzelCbqxKccwAkSGwKf9fNPaO7VD5AVrIdGie4Hob?=
 =?us-ascii?Q?CD/CGCs5HO8HkeZeSCmWJQA/LeC5JkntD6uxwB3k9pVWiqCxIcIn082nvJ6H?=
 =?us-ascii?Q?QG4Z/W8hKIaoZUlF0zN3AYKaxpBuTeyc8nnFv6tkKPr7QZyUvMEtV2GMFO7+?=
 =?us-ascii?Q?PtGxUQxRpsULi1RrlJz7Rdmp2qHebG21hSxBcctLL1/Efvt9FBf+CQEZxZPB?=
 =?us-ascii?Q?Mx/1YO4Tq2Pbuh0Zt9B+vPwruqFbd0XVPBCZw6TzAwvh6p1J2UggGNXHTqow?=
 =?us-ascii?Q?62NI8sLE5A+ZeecOfr7aP6Wx+SldVzFEkgR5iZZBms2zYtjy92bf4YCvTyDf?=
 =?us-ascii?Q?A1m8GmkWjCPA2D8+myjaTliORhtV51h963oV0zNhkAbbNo8nho1Dpzpbo8DI?=
 =?us-ascii?Q?7bMtJlGhGS2bex7xSq66clbID7qMe6EiMYJ4JhbfkxFNEIuUYpL6C1PbIDr8?=
 =?us-ascii?Q?dMT3YPyrD0IG3OVv7nIc27dc3YABwKRPv0v23A9qW+5zv3SCBZM4hM3hQNAW?=
 =?us-ascii?Q?KWhNEGbRraCFFqU0X1S38rYZ09hvukM4I73ggxgPecagOQowpOvItkuQvkoQ?=
 =?us-ascii?Q?aFAoHX/5zElCN6IXUR14KesOAWzqkXJUz5YsQqguadSHzWODXhf0IeCVGvV1?=
 =?us-ascii?Q?l9IjWb/PB0e9Q0mnPjcDhazFGG6OsEIrrXv8Qkh8kfJ+RNqxxm8So0ZRTdFs?=
 =?us-ascii?Q?PqL9Pz+OtL8Kp+ftUMnR4yFLS9xZDg1Y7uUiom0ekHReVjPIM2xJJJbdBFMW?=
 =?us-ascii?Q?zjhDGGin+coF9P8JABVCYegdmh7ocrfLlM7u+HVxMJflsHmucbE0mCAxrFnn?=
 =?us-ascii?Q?Ep56KkVUQ990Ih3ufuo8gGs6n33IA6rvR693fbmjGhmN0JtOQpPyFXQbPTWG?=
 =?us-ascii?Q?idqPp9n1gmq6ew555JsOBK4AsZ9fpouWdMXfY9BFnZsUcMBbX4LzVpcPenTG?=
 =?us-ascii?Q?AQg93RjUIVJvgcXtzzpGtxRmZqCsDdk3rikqepvzUHr2CN8s8Qoss0+FBR1+?=
 =?us-ascii?Q?Bm6igB34sC7fh5FwEle50uLLDuzF0FHnDDINZLAgnIn0UrUBRM9pc8wJItuw?=
 =?us-ascii?Q?jLSKD4RZR2ScdTnG/KiVZJxnfEsiMSTWrd5cs1kDyaCCC8PLEQ7eE5EUEPKB?=
 =?us-ascii?Q?mpcZbydNmwvmz2abWW3Khyb2eraDqOmgXky7ULTX4e4+xekbQ6du7xB1p45L?=
 =?us-ascii?Q?Uv373AgNpwBTiaE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:37:03.5740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7f5925-92a1-4410-8c88-08de48933601
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6362
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
v3: Changelog:
1. New patch. Add a dedicated remoteproc driver to boot HSM core.

 MAINTAINERS                          |   1 +
 drivers/remoteproc/Kconfig           |  10 ++
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c | 252 +++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ce0bbce13d..1a11b580a66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,6 +802,7 @@ F:	drivers/phy/ti-pipe3-phy.c
 F:	drivers/ram/k3*
 F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
+F:	drivers/remoteproc/ti_k3_hsm_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
 F:	drivers/remoteproc/pruc_rpoc.c
 F:	drivers/remoteproc/ti*
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 8056f210abc..5514f092615 100644
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

