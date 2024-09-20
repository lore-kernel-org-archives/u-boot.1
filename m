Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CEACF58CB
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 04:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98EC38930C;
	Fri, 20 Sep 2024 06:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0zqmmzi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46A089144; Fri, 20 Sep 2024 06:17:47 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E00B88C4D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pon5YcTDBw3LBRloSJR8HDgkiFJCIe++uQ+TCnazba4LHlbemzN1QNL/PSx4NKpb1hYhh+MilHinBnTxn2mZ2tfgvu0nxAUxEMiyZT31BoYm/1k2bxMSiy59iy5GEe/cuwVPM0RFKiB97mXQf8OCESvmc+cVw1SgTfXPZDhPe1ttGCyXpc2jbFjrmbX3w7HPZW1NNF7tb5sdss7fhs9Pic2Pas2GDBShsW9dF2ooq1d6gykoGQ3653s78s/MqcAN/Nx8hKtD0DdGTcx18qgJm4/3vsA5cr2nCBcYQ+euQ7C9z8n4JtbyHOEpjvHwG3C0kuMlUPfeDf6yMttni4kRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVHIxv87o3LWU4buj/IftHE7B1GIyGOPcUuqERSoSsk=;
 b=WnHLXcMai+yb6ZMYvwNkVRfXHyawFgstZpSyFRxMlLoUwU39yitmUTC21qp9ccXiEgBHmsY1e520KT4XXfY3nPLDrX/N/S5vqAq8FWecpKscFcc+7DZb/a6D5QTzgbs8qZThSsyHwwp0A+uAgKr88QWQK0w7y850Epo8iCpi6zoMFkZTN5NyDQ6K3s83NzkyaGiIhkb7qMKHuKvkcJqn3CE/zfMnCMX9huK7n/8SjsUbD/qGtZse4y+WkRU/7EUaWF6QWflSXs+fr8bk34JCXIGDs14sImT81H9DVGIkdJt23CSrM0yOVJioPa4OYcOlr2Ng/rLqMBcJXbeHj43B0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVHIxv87o3LWU4buj/IftHE7B1GIyGOPcUuqERSoSsk=;
 b=0zqmmzi7mRhDtTj87oXSEYPumdjbQlCEKYelOoIqEeYmSWTtM8NR7wRHjRMJxXfuURKA0wQz53EXZbyLLMD8NhN7XhdnxRmaj8WDvcfuE/6TdANiMh7AeC0UDI4MV1sQvDDojXCpirXBDoVF6VwEVVU+YhF2qxoucgYYyTzSGgc=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 04:17:39 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::db) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28 via Frontend
 Transport; Fri, 20 Sep 2024 04:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 04:17:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:12 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 23:17:10 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH v2 2/3] ufs: ufs-amd-versal2: Add support for AMD UFS
 controller
Date: Fri, 20 Sep 2024 09:46:50 +0530
Message-ID: <20240920041651.18173-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
References: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c457a9-fcea-48b7-330e-08dcd92b29a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cd0zYm88lMJ2r2jvM1RrJJ1q6lA8Jnjdn/hhSErxK1EKxxUV15DqyANhmhEm?=
 =?us-ascii?Q?96bsM/3uVGH+2eKsKSLAI9E8MKnFZMy3yMPyZo731pM8NRYj2VvKdmK3JxPg?=
 =?us-ascii?Q?GyAe5QO4XtdURzx3sSszE7GuchgqiKUnYU4+mB57n4+TmFsHBXNXISOb+exF?=
 =?us-ascii?Q?j5qoFt1rq9kZVhTdeXn56JX1rv6YONZeKhMUgBPC+BOtG5fA0BfemoohaPp4?=
 =?us-ascii?Q?rIai/iMkVgKrN2tZdOp8hS2IUtOR/cqA5bg2JTbfaQ6wLFy2Y4BRsoL8nhVC?=
 =?us-ascii?Q?pr6samVy4rjDf6LphL7QmHD/qCrDKP7EPGQyUG6+b+J6kDuggW6Xj0poQ3Z2?=
 =?us-ascii?Q?ZsaSvcdV6uNPIqcH4QtrdlUpi/1iW+DuurQ1F6FPf6B2uOnr6Cwq1zociibp?=
 =?us-ascii?Q?JuzyEu5YhpP1V99GHZOz9WSuEsaumZrpzZ47u5mGbnLlLGZ+mfgKRTVWAkIh?=
 =?us-ascii?Q?xj/JlQVlDkloo8lHiaIxHrqLhxIq5iglAuP74OaqJWNVdmRsWXWHYeqyuNDb?=
 =?us-ascii?Q?IYsY9oc1edypaoE+qJwfhcM6SrzDyl/vcffouflmLfl9v4nwAWB1zf1tj5M4?=
 =?us-ascii?Q?T5iObiH51GZcvxLAXUz+SKdyuni8pikQVMODY3kJ/qUEqszIMzyvY/LKZ2Ua?=
 =?us-ascii?Q?zxkOplOiY2ME34BvWz8CdZZ4yNaK1OhY1oMYGzpnhpIcN2OPJH6r6h/S+Ie+?=
 =?us-ascii?Q?6LpTlZTie+Sisn6fuuQk23L+F5gaTkbXpHg5s6/6/O4QMjVTWr+C223RW07w?=
 =?us-ascii?Q?OEYptqSHvDz3MJTX/NEh36KFEbhZqX56LieLIFG2n3b9QLuR51HnoNe4sCyt?=
 =?us-ascii?Q?o+2WnCDWcObue5jZEZUoH+8FVGz+grEgaAOnlhDO0VGULNNmMFJcLlWDikJ8?=
 =?us-ascii?Q?Y3jYzEHrS5YbL4FYmqGYB/rD+6GORXnpVmTqAVk4hULr75+r2iLp5d3cU9LZ?=
 =?us-ascii?Q?e4NhPshmQWIWBEqa8DGbMlw0LSHFwo97ZpHeeUs6B/ignws5eECDZ/icX0Cn?=
 =?us-ascii?Q?Sy30iHsZunCQyoccHzU533en0poiBAmh0XmgzhHNwFd+cN+KC0yQqGHlelin?=
 =?us-ascii?Q?hgmPqgHv05cuksDg45+YogzQWbyhWTcEKuFPJqq11o5Q4WfP85G3uvTVFVw2?=
 =?us-ascii?Q?KuLHOmrhM8ZeDq/i/MVgGuGg9HqVud97zU4nxaaX2XAjWRFnNFzDEBWz7QJ1?=
 =?us-ascii?Q?FPgMIJjcRXOu8YYcfJslfbHeIYiieBWbIGe9mcm0JRpEKi+B8uCEXSh+uLDy?=
 =?us-ascii?Q?i47jELeONaPCj5BL1QZl9L0Y86NG1M14o5RY68chi4H9gmxqfSsnG+CQzVBP?=
 =?us-ascii?Q?KWQk1L6CRiBLWQmKfk8Njt9gF70Wi1+sGkBMfdBD4Wc5i4L9T9/kw43/MjCP?=
 =?us-ascii?Q?kr9chx36oeGwm0PbJwb1djCe837z9fJGqeEBdwtdMDo1s0tGwdozxfV7yFns?=
 =?us-ascii?Q?/PtOGiY75zWS+WzY8eRVGeLklXDfdznF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 04:17:38.4762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c457a9-fcea-48b7-330e-08dcd92b29a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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

Add UFS AMD platform support on top of the UFS DWC
and UFS platform driver. UFS AMD platform requires
some platform specific configurations like M-PHY/RMMI/UniPro
and vendor specific registers programming before doing the LINKSTARTUP.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/Kconfig           |   8 +
 drivers/ufs/Makefile          |   1 +
 drivers/ufs/ufs-amd-versal2.c | 501 ++++++++++++++++++++++++++++++++++
 drivers/ufs/ufshcd-dwc.h      |  46 ++++
 drivers/ufs/unipro.h          |   1 +
 5 files changed, 557 insertions(+)
 create mode 100644 drivers/ufs/ufs-amd-versal2.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 7da46faed6..ad5d0316f6 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -41,4 +41,12 @@ config UFS_RENESAS
 	  UFS host on Renesas needs some vendor specific configuration before
 	  accessing the hardware.
 
+config UFS_AMD_VERSAL2
+	bool "AMD Versal Gen 2 UFS controller platform driver"
+	depends on UFS && ZYNQMP_FIRMWARE
+	help
+	  This selects the AMD specific additions to UFSHCD platform driver.
+	  UFS host on AMD needs some vendor specific configuration before accessing
+	  the hardware.
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 67c42621ab..745de5c3db 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
+obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
new file mode 100644
index 0000000000..bfd844e419
--- /dev/null
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <ufs.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <zynqmp_firmware.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/time.h>
+#include <reset.h>
+
+#include "ufs.h"
+#include "ufshcd-dwc.h"
+#include "ufshci-dwc.h"
+
+#define VERSAL2_UFS_DEVICE_ID		4
+
+#define SRAM_CSR_INIT_DONE_MASK		BIT(0)
+#define SRAM_CSR_EXT_LD_DONE_MASK	BIT(1)
+#define SRAM_CSR_BYPASS_MASK		BIT(2)
+
+#define MPHY_FAST_RX_AFE_CAL		BIT(2)
+#define MPHY_FW_CALIB_CFG_VAL		BIT(8)
+
+#define TX_RX_CFG_RDY_MASK		GENMASK(3, 0)
+
+#define TIMEOUT_MICROSEC		1000000L
+
+#define IOCTL_UFS_TXRX_CFGRDY_GET	40
+#define IOCTL_UFS_SRAM_CSR_SEL		41
+
+#define PM_UFS_SRAM_CSR_WRITE		0
+#define PM_UFS_SRAM_CSR_READ		1
+
+struct ufs_versal2_priv {
+	struct ufs_hba *hba;
+	struct reset_ctl *rstc;
+	struct reset_ctl *rstphy;
+	u32 phy_mode;
+	u32 host_clk;
+	u32 pd_dev_id;
+	u8 attcompval0;
+	u8 attcompval1;
+	u8 ctlecompval0;
+	u8 ctlecompval1;
+};
+
+static int ufs_versal2_phy_reg_write(struct ufs_hba *hba, u32 addr, u32 val)
+{
+	static struct ufshcd_dme_attr_val phy_write_attrs[] = {
+		{ UIC_ARG_MIB(CBCREGADDRLSB), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCREGADDRMSB), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCREGWRLSB), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCREGWRMSB), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCREGRDWRSEL), 1, DME_LOCAL },
+		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
+	};
+
+	phy_write_attrs[0].mib_val = (u8)addr;
+	phy_write_attrs[1].mib_val = (u8)(addr >> 8);
+	phy_write_attrs[2].mib_val = (u8)val;
+	phy_write_attrs[3].mib_val = (u8)(val >> 8);
+
+	return ufshcd_dwc_dme_set_attrs(hba, phy_write_attrs, ARRAY_SIZE(phy_write_attrs));
+}
+
+static int ufs_versal2_phy_reg_read(struct ufs_hba *hba, u32 addr, u32 *val)
+{
+	u32 mib_val;
+	int ret;
+	static struct ufshcd_dme_attr_val phy_read_attrs[] = {
+		{ UIC_ARG_MIB(CBCREGADDRLSB), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCREGADDRMSB), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCREGRDWRSEL), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
+	};
+
+	phy_read_attrs[0].mib_val = (u8)addr;
+	phy_read_attrs[1].mib_val = (u8)(addr >> 8);
+
+	ret = ufshcd_dwc_dme_set_attrs(hba, phy_read_attrs, ARRAY_SIZE(phy_read_attrs));
+	if (ret)
+		return ret;
+
+	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(CBCREGRDLSB), &mib_val);
+	if (ret)
+		return ret;
+
+	*val = mib_val;
+	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(CBCREGRDMSB), &mib_val);
+	if (ret)
+		return ret;
+
+	*val |= (mib_val << 8);
+
+	return 0;
+}
+
+int versal2_pm_ufs_get_txrx_cfgrdy(u32 node_id, u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_TXRX_CFGRDY_GET,
+				0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
+int versal2_pm_ufs_sram_csr_sel(u32 node_id, u32 type, u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	if (type == PM_UFS_SRAM_CSR_READ) {
+		ret =  xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
+					 type, 0, ret_payload);
+		*value = ret_payload[1];
+	} else {
+		ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
+					type, *value, 0);
+	}
+
+	return ret;
+}
+
+static int ufs_versal2_enable_phy(struct ufs_hba *hba)
+{
+	u32 offset, reg;
+	int ret;
+
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYDISABLE), 0);
+	if (ret)
+		return ret;
+
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYCFGUPDT), 1);
+	if (ret)
+		return ret;
+
+	/* Check Tx/Rx FSM states */
+	for (offset = 0; offset < 2; offset++) {
+		u32 time_left, mibsel;
+
+		time_left = TIMEOUT_MICROSEC;
+		mibsel = UIC_ARG_MIB_SEL(MTX_FSM_STATE, UIC_ARG_MPHY_TX_GEN_SEL_INDEX(offset));
+		do {
+			ret = ufshcd_dme_get(hba, mibsel, &reg);
+			if (ret)
+				return ret;
+
+			if (reg == TX_STATE_HIBERN8 || reg == TX_STATE_SLEEP ||
+			    reg == TX_STATE_LSBURST)
+				break;
+
+			time_left--;
+			mdelay(5);
+		} while (time_left);
+
+		if (!time_left) {
+			dev_err(hba->dev, "Invalid Tx FSM state.\n");
+			return -ETIMEDOUT;
+		}
+
+		time_left = TIMEOUT_MICROSEC;
+		mibsel = UIC_ARG_MIB_SEL(MRX_FSM_STATE, UIC_ARG_MPHY_RX_GEN_SEL_INDEX(offset));
+		do {
+			ret = ufshcd_dme_get(hba, mibsel, &reg);
+			if (ret)
+				return ret;
+
+			if (reg == RX_STATE_HIBERN8 || reg == RX_STATE_SLEEP ||
+			    reg == RX_STATE_LSBURST)
+				break;
+
+			time_left--;
+			mdelay(5);
+		} while (time_left);
+
+		if (!time_left) {
+			dev_err(hba->dev, "Invalid Rx FSM state.\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int ufs_versal2_setup_phy(struct ufs_hba *hba)
+{
+	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
+	int ret;
+	u32 reg;
+
+	/* Bypass RX-AFE offset calibrations (ATT/CTLE) */
+	ret = ufs_versal2_phy_reg_read(hba, FAST_FLAGS(0), &reg);
+	if (ret)
+		return ret;
+
+	reg |= MPHY_FAST_RX_AFE_CAL;
+	ret = ufs_versal2_phy_reg_write(hba, FAST_FLAGS(0), reg);
+	if (ret)
+		return ret;
+
+	ret = ufs_versal2_phy_reg_read(hba, FAST_FLAGS(1), &reg);
+	if (ret)
+		return ret;
+
+	reg |= MPHY_FAST_RX_AFE_CAL;
+	ret = ufs_versal2_phy_reg_write(hba, FAST_FLAGS(1), reg);
+	if (ret)
+		return ret;
+
+	/* Program ATT and CTLE compensation values */
+	if (priv->attcompval0) {
+		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_ATT_IDAC(0), priv->attcompval0);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->attcompval1) {
+		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_ATT_IDAC(1), priv->attcompval1);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->ctlecompval0) {
+		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_CTLE_IDAC(0), priv->ctlecompval0);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->ctlecompval1) {
+		ret = ufs_versal2_phy_reg_write(hba, RX_AFE_CTLE_IDAC(1), priv->ctlecompval1);
+		if (ret)
+			return ret;
+	}
+
+	ret = ufs_versal2_phy_reg_read(hba, FW_CALIB_CCFG(0), &reg);
+	if (ret)
+		return ret;
+
+	reg |= MPHY_FW_CALIB_CFG_VAL;
+	ret = ufs_versal2_phy_reg_write(hba, FW_CALIB_CCFG(0), reg);
+	if (ret)
+		return ret;
+
+	ret = ufs_versal2_phy_reg_read(hba, FW_CALIB_CCFG(1), &reg);
+	if (ret)
+		return ret;
+
+	reg |= MPHY_FW_CALIB_CFG_VAL;
+	return ufs_versal2_phy_reg_write(hba, FW_CALIB_CCFG(1), reg);
+}
+
+static int ufs_versal2_phy_init(struct ufs_hba *hba)
+{
+	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
+	u32 reg, time_left;
+	int ret;
+	static const struct ufshcd_dme_attr_val rmmi_attrs[] = {
+		{ UIC_ARG_MIB(CBREFCLKCTRL2), CBREFREFCLK_GATE_OVR_EN, DME_LOCAL },
+		{ UIC_ARG_MIB(CBCRCTRL), 1, DME_LOCAL },
+		{ UIC_ARG_MIB(CBC10DIRECTCONF2), 1, DME_LOCAL },
+		{ UIC_ARG_MIB(VS_MPHYCFGUPDT), 1, DME_LOCAL }
+	};
+
+	/* Wait for Tx/Rx config_rdy */
+	time_left = TIMEOUT_MICROSEC;
+	do {
+		time_left--;
+		ret = versal2_pm_ufs_get_txrx_cfgrdy(priv->pd_dev_id, &reg);
+		if (ret)
+			return ret;
+
+		reg &= TX_RX_CFG_RDY_MASK;
+		if (!reg)
+			break;
+
+		mdelay(5);
+	} while (time_left);
+
+	if (!time_left) {
+		dev_err(hba->dev, "Tx/Rx configuration signal busy.\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = ufshcd_dwc_dme_set_attrs(hba, rmmi_attrs, ARRAY_SIZE(rmmi_attrs));
+	if (ret)
+		return ret;
+
+	/* DeAssert PHY reset */
+	ret = reset_deassert(priv->rstphy);
+	if (ret) {
+		dev_err(hba->dev, "ufsphy reset deassert failed\n");
+		return ret;
+	}
+
+	/* Wait for SRAM init done */
+	time_left = TIMEOUT_MICROSEC;
+	do {
+		time_left--;
+		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
+						  PM_UFS_SRAM_CSR_READ, &reg);
+		if (ret)
+			return ret;
+
+		reg &= SRAM_CSR_INIT_DONE_MASK;
+		if (reg)
+			break;
+
+		mdelay(5);
+	} while (time_left);
+
+	if (!time_left) {
+		dev_err(hba->dev, "SRAM initialization failed.\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = ufs_versal2_setup_phy(hba);
+	if (ret)
+		return ret;
+
+	return ufs_versal2_enable_phy(hba);
+}
+
+static int ufs_versal2_init(struct ufs_hba *hba)
+{
+	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
+	struct clk clk;
+	unsigned long core_clk_rate = 0;
+	int ret = 0;
+
+	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
+	priv->pd_dev_id = VERSAL2_UFS_DEVICE_ID;
+
+	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
+	if (ret) {
+		dev_err(hba->dev, "failed to get core_clk clock\n");
+		return ret;
+	}
+
+	core_clk_rate = clk_get_rate(&clk);
+	if (IS_ERR_VALUE(core_clk_rate)) {
+		dev_err(hba->dev, "%s: unable to find core_clk rate\n",
+			__func__);
+		return core_clk_rate;
+	}
+	priv->host_clk = core_clk_rate;
+
+	priv->rstc = devm_reset_control_get(hba->dev, "ufshc-rst");
+	if (IS_ERR(priv->rstc)) {
+		dev_err(hba->dev, "failed to get reset ctl: ufshc-rst\n");
+		return PTR_ERR(priv->rstc);
+	}
+	priv->rstphy = devm_reset_control_get(hba->dev, "ufsphy-rst");
+	if (IS_ERR(priv->rstphy)) {
+		dev_err(hba->dev, "failed to get reset ctl: ufsphy-rst\n");
+		return PTR_ERR(priv->rstphy);
+	}
+
+	return ret;
+}
+
+static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
+					 enum ufs_notify_change_status status)
+{
+	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
+	u32 sram_csr;
+	int ret;
+
+	switch (status) {
+	case PRE_CHANGE:
+		/* Assert RST_UFS Reset for UFS block in PMX_IOU */
+		ret = reset_assert(priv->rstc);
+		if (ret) {
+			dev_err(hba->dev, "ufshc reset assert failed, err = %d\n", ret);
+			return ret;
+		}
+
+		/* Assert PHY reset */
+		ret = reset_assert(priv->rstphy);
+		if (ret) {
+			dev_err(hba->dev, "ufsphy reset assert failed, err = %d\n", ret);
+			return ret;
+		}
+
+		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
+						  PM_UFS_SRAM_CSR_READ, &sram_csr);
+		if (ret)
+			return ret;
+
+		if (!priv->phy_mode) {
+			sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
+			sram_csr |= SRAM_CSR_BYPASS_MASK;
+		} else {
+			dev_err(hba->dev, "Invalid phy-mode %d.\n", priv->phy_mode);
+			return -EINVAL;
+		}
+
+		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
+						  PM_UFS_SRAM_CSR_WRITE, &sram_csr);
+		if (ret)
+			return ret;
+
+		/* De Assert RST_UFS Reset for UFS block in PMX_IOU */
+		ret = reset_deassert(priv->rstc);
+		if (ret)
+			dev_err(hba->dev, "ufshc reset deassert failed, err = %d\n", ret);
+
+		break;
+	case POST_CHANGE:
+		ret = ufs_versal2_phy_init(hba);
+		if (ret)
+			dev_err(hba->dev, "Phy init failed (%d)\n", ret);
+
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ufs_versal2_link_startup_notify(struct ufs_hba *hba,
+					   enum ufs_notify_change_status status)
+{
+	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
+	int ret = 0;
+
+	switch (status) {
+	case PRE_CHANGE:
+		if (priv->host_clk) {
+			u32 core_clk_div = priv->host_clk / TIMEOUT_MICROSEC;
+
+			ufshcd_writel(hba, core_clk_div, DWC_UFS_REG_HCLKDIV);
+		}
+		break;
+	case POST_CHANGE:
+		ret = ufshcd_dwc_link_startup_notify(hba, status);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static struct ufs_hba_ops ufs_versal2_hba_ops = {
+	.init = ufs_versal2_init,
+	.link_startup_notify = ufs_versal2_link_startup_notify,
+	.hce_enable_notify = ufs_versal2_hce_enable_notify,
+};
+
+static int ufs_versal2_probe(struct udevice *dev)
+{
+	int ret;
+
+	/* Perform generic probe */
+	ret = ufshcd_probe(dev, &ufs_versal2_hba_ops);
+	if (ret)
+		dev_err(dev, "ufshcd_probe() failed %d\n", ret);
+
+	return ret;
+}
+
+static int ufs_versal2_bind(struct udevice *dev)
+{
+	struct udevice *scsi_dev;
+
+	return ufs_scsi_bind(dev, &scsi_dev);
+}
+
+static const struct udevice_id ufs_versal2_ids[] = {
+	{
+		.compatible = "amd,versal2-ufs",
+	},
+	{},
+};
+
+U_BOOT_DRIVER(ufs_versal2_pltfm) = {
+	.name           = "ufs-versal2-pltfm",
+	.id             = UCLASS_UFS,
+	.of_match       = ufs_versal2_ids,
+	.probe          = ufs_versal2_probe,
+	.bind           = ufs_versal2_bind,
+};
diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
index d997045d3c..fc1bcca8cc 100644
--- a/drivers/ufs/ufshcd-dwc.h
+++ b/drivers/ufs/ufshcd-dwc.h
@@ -10,6 +10,52 @@
 #ifndef _UFSHCD_DWC_H
 #define _UFSHCD_DWC_H
 
+/* PHY modes */
+#define UFSHCD_DWC_PHY_MODE_ROM		0
+
+/* RMMI Attributes */
+#define CBREFCLKCTRL2		0x8132
+#define CBCRCTRL		0x811F
+#define CBC10DIRECTCONF2	0x810E
+#define CBCREGADDRLSB		0x8116
+#define CBCREGADDRMSB		0x8117
+#define CBCREGWRLSB		0x8118
+#define CBCREGWRMSB		0x8119
+#define CBCREGRDLSB		0x811A
+#define CBCREGRDMSB		0x811B
+#define CBCREGRDWRSEL		0x811C
+
+#define CBREFREFCLK_GATE_OVR_EN		BIT(7)
+
+/* M-PHY Attributes */
+#define MTX_FSM_STATE		0x41
+#define MRX_FSM_STATE		0xC1
+
+/* M-PHY registers */
+#define FAST_FLAGS(n)		(0x401C + ((n) * 0x100))
+#define RX_AFE_ATT_IDAC(n)	(0x4000 + ((n) * 0x100))
+#define RX_AFE_CTLE_IDAC(n)	(0x4001 + ((n) * 0x100))
+#define FW_CALIB_CCFG(n)	(0x404D + ((n) * 0x100))
+
+/* Tx/Rx FSM state */
+enum rx_fsm_state {
+	RX_STATE_DISABLED = 0,
+	RX_STATE_HIBERN8 = 1,
+	RX_STATE_SLEEP = 2,
+	RX_STATE_STALL = 3,
+	RX_STATE_LSBURST = 4,
+	RX_STATE_HSBURST = 5,
+};
+
+enum tx_fsm_state {
+	TX_STATE_DISABLED = 0,
+	TX_STATE_HIBERN8 = 1,
+	TX_STATE_SLEEP = 2,
+	TX_STATE_STALL = 3,
+	TX_STATE_LSBURST = 4,
+	TX_STATE_HSBURST = 5,
+};
+
 struct ufshcd_dme_attr_val {
 	u32 attr_sel;
 	u32 mib_val;
diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
index b30b17fa5a..2f5726d4d3 100644
--- a/drivers/ufs/unipro.h
+++ b/drivers/ufs/unipro.h
@@ -148,6 +148,7 @@
 #define VS_MPHYCFGUPDT		0xD085
 #define VS_DEBUGOMC		0xD09E
 #define VS_POWERSTATE		0xD083
+#define VS_MPHYDISABLE		0xD0C1
 
 #define PA_GRANULARITY_MIN_VAL	1
 #define PA_GRANULARITY_MAX_VAL	6
-- 
2.17.1

