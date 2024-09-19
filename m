Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0A7CE8D61
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EECA89112;
	Thu, 19 Sep 2024 11:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYg0BdSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1698989116; Thu, 19 Sep 2024 11:18:02 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545CD89118
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+N2Jh+H5w8GPlW1/Wb8p0sK/qeyjiuqLaLxDEwgI2X9vvarax2t8VPywnkhvcfye/u6/zCUdZrODEyji8OvDZWw9EKPiehMKYiFDolxhaBLlt4E0e2UOdxTWHEczJ0WQ8SR+6j9jNLloRAsmI79tpbkjp47Z7TguqIdn3mQMZgW4VmjZ7DtZ0d7eUzyYJr5nsMhtXnTzePZwIq+GQ7xbwsskQkJDKmVZByODmRSKQmGFot7sxnqbr5iDSRBpbriUdSAaz8MS7RgLxnuKZE/b4oqLLqTSskc3euJPnXRxlJZYvh5v3idVYtNn21bU7wce7dPghiZI8ETet1ZxpOvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNpYbI/Cier/2EcP/x29JMjLO2Kug3ZuBpQUhkwiUns=;
 b=SmR4He5dCJFx78Y/EvPxtokUhM/FGq5v1wCghAabtne02hdMrQgQLi72I9XX9YwMHjhgDNW+WMsC+6JD0D2T2sX+MuD9wYAyLYPMOARSCoYcGSRQLa5obWxmWtAI/hEH35hRt01YsPizMBZ/rzSIodE0KGuzruT+zfMGfy0GY/XghSsoo+nPxKsKXM03w7js1HAkSYFOTCMoVf5tp6+O5TvIxI0qqdfmLL9jZIuETux1Fu3LrvzEHuoCyE1ESzEp5dWN/E5SoF4DqZ8In9EaErpBmOML+J3NQ7arZCEmE5gTtuzSzXYdNhS1tOsv6eD4NUASHWk7VOJmK9rTwSdAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNpYbI/Cier/2EcP/x29JMjLO2Kug3ZuBpQUhkwiUns=;
 b=RYg0BdSEg+VgpVSNi5olpxGEXMy95WEHnbmdhSUx17KskDtYBp7LNiEgYt6nIpn0YDyi8FSIw3L0LH6hYbaJgIHU1lOlX/pBDFrHz+cN6n9m6XjdlmUkDHFqYK+EGRED1I4w1k7y3iUuBBxbkzs6n4QwAbeLHWf2qvFdnfYvrxs=
Received: from BN9PR03CA0759.namprd03.prod.outlook.com (2603:10b6:408:13a::14)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 09:17:50 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::d) by BN9PR03CA0759.outlook.office365.com
 (2603:10b6:408:13a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 09:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 09:17:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:45 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 04:17:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH 2/3] ufs: ufs-amd-versal2: Add support for AMD UFS controller
Date: Thu, 19 Sep 2024 14:47:30 +0530
Message-ID: <20240919091731.26338-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
References: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 962a64f4-344d-4b96-ca0d-08dcd88bee9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XlShFGL3FPpJqBy80QxOQC0wNjrpXmNU4hr8ElKcRtqpFGuFytmx9j+W2DOz?=
 =?us-ascii?Q?15DsG/spzC/rQ5QLzCnsnooM5uI/HWLNkiA7ZSQl+FTGGgpXCrfsIzkBHYL1?=
 =?us-ascii?Q?1hBG4H0TZeSnGK0I1uXC6LVNS0N2qC6IAkrQWpAyELWgWxjHd7+nBEBnV+mg?=
 =?us-ascii?Q?mYFWuR6C0fLHOJROcpsD/EvEpCs8+OV9XDUVhhkIGepSVFeghYpm3Gm3Xull?=
 =?us-ascii?Q?s+FJG8NKON0QPqDvuJr33KpY5n/z+FR5DCmv+5wMftTP0OVFVErFY0ZzXHMs?=
 =?us-ascii?Q?usORTXR/KjtoP0slnE2W4n9pE0nu3AUWVtBrExgEfFxJ6SFXMykqMbJfK+XF?=
 =?us-ascii?Q?6xUYgeCDWbtZwmWYtuX7YZDzi4OaCriurmNMu/BY6pT4lKWjknaOX9UNISxR?=
 =?us-ascii?Q?12lDEbu/KF53ecTi6R+crP9im1WRKuhK+/BDFq58kUTlU9V4rDGyB/9vFI9y?=
 =?us-ascii?Q?RAwJW9SbLIBVfVhXFGddctcbfaa2UFoqHTac+yyznatTchkzbaa8PMy9wEJJ?=
 =?us-ascii?Q?7toJnv5FFsfkKjbaD2wpEvSAy+ovBnM+dKubQFNu3JNhXX0BixSi++fGKhdO?=
 =?us-ascii?Q?rz2W6fFbArClFBk3zjPOYlXecDPhk8HP8E2cjdAnjldhlFRwsLQLP46LOFuE?=
 =?us-ascii?Q?CsJTaUM6HXw7oBt7cAvMWA2y3IN2CnI3Qk5R4e8xDM6i2J4J2ya0qJKZrL6s?=
 =?us-ascii?Q?b4nzUT34P4BVc4txhSS1nhla7xlMKsQNb6x7E52SjiNmdcOrhomojafhoBkm?=
 =?us-ascii?Q?cGwz0uKUKwDmTLAsEzC7HV0aao7AtHb7CU6UXcZNBcMD5dTu+9R2F180cSEY?=
 =?us-ascii?Q?Hm6LQDSekGLg8PygxT/paxjKd+r3bAh39Kb1bPSfUBYmEK5dNdt3U6bp7Ib+?=
 =?us-ascii?Q?ZdeOS5/qZMBuW/uCLpCIfPlDjcOXUQXvWKvEl/qGSXy7gbYsZJlWFR9Us9V+?=
 =?us-ascii?Q?YOYXvjz7co+BFRFzdWnFMpEq9FHqN7wFfaRX5Mn5CM1+aTgNC60peX1a6YvE?=
 =?us-ascii?Q?BXt/lPP7DE8155a8ZN5Z83bcu9PcDzLrFEikAZuNCqqWpi9ruf4KBu/iQQ4D?=
 =?us-ascii?Q?5JV0DfFna87dqyaKTIar+MTaKFoYh8LsTVw7cbNZjDnStkuxqR8UFB2Ih0+9?=
 =?us-ascii?Q?ExPtEa+qMh/lJ64RzUsql193+/ILx6p7xOaLJPZ5rvYBxMNIET25OmjhkkBF?=
 =?us-ascii?Q?QjTEd+4APNbttS7j8sGk7GWXAxtIDDYmuuNiFLQeTib1arG98y5EMis5rzIl?=
 =?us-ascii?Q?jBFbE9S6lVfxBBlD7Cb3EI6SmsS+JwLUzTxbiy8UWejb6JXUSOE4V1lVx8ML?=
 =?us-ascii?Q?48A/F5EjGsknjfME9ny2QBRr7qI+++FOnjbm13+IfR1k1QXxqKUvOK2ytMl3?=
 =?us-ascii?Q?ZmJNSmyXrZoXbtToCLQado2uF9mrxh9D3mSXiioQ1tlVtoWjjsfK6zrry0KQ?=
 =?us-ascii?Q?SmlpbALWUtH/X0C9xLbyGK4/h1HzaxTo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:17:49.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962a64f4-344d-4b96-ca0d-08dcd88bee9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

