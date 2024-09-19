Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F6CE8D61
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A752A89109;
	Thu, 19 Sep 2024 11:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="inuojjHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E09788B3F; Thu, 19 Sep 2024 11:17:51 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF05E89103
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXbFSrviyB4VSmiZLPfud10ele+eXN0E98IPlchB3pHOl2yoyjH/M0PIbA0IcHNYBNKy79Fa1HWeeF+eb8NkZ/IzDkg//VQgL59cS4BCWzpf1BXuSna1YlXWhITnePX6HKTcxwGvds4PnHJIoHyqOnguE6drHVlbm61eHhhaE9q0/VJeR6mH0w2DCEI0QHM4UwJ6tS74fcX5npFJ/4ZNK0GPpEXTAVNXmjlvio/nBWGzp7L+UDLvQiqSSXNmG/VDBvGTRUTyamwTuh+s9cjxlQu3xv0/sgiqStheh8m6k4dIjZBxbH7i1pTTBle4fUtMN2Qi4Jip/ByKqBy6NA4Xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4NQzLmLA9Jug/NJurpoZ7Yh3R2nvsEHeeLmBE4WE7U=;
 b=lzbqbvi4m2cukXv6Mm8h0YV4RrOax4J21vuMazhLLK3P8plDGoSo2iPjji6XYF6RjRm/lJUgigtNHGzej4hw2KsjwFxKDvmbOf/hoywZCSkk4OpiBnC784bt5bfyDS1XqdtxUcFcBGtA9qwFjZYuRF5cg9jqzqaW04QJIums/Fs6jZylXmylMPCGhVCETTOIbf+RUMBIPMpAXLLL6gn5Uu9qYeebpaTE3W4uTe5HX4vAqkJ+nGekn8cRdFxpVtEarsX20xyID529r9dIYPTK3zqbrfglFhTkAMiWFVMdAdNjFB9LK8D8xEeR1aCouWgab9OsHH/PlMlrlxThy7sVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4NQzLmLA9Jug/NJurpoZ7Yh3R2nvsEHeeLmBE4WE7U=;
 b=inuojjHrWgZlfvz5oQuXr0GLl12ZDeZ8UYFUJrlPM1kH3Zs5DcVxAvdsGtqvz+mTQIi6e63pG9IJV2I4QTSldXZfmhX1V4wIQPzVc3BeAuFPnhb5bA/TSwWmyw2HnxaiQXc+AXp/c9tbKgBpuQzlQ08PxCutxXEPBWouesxMqzQ=
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28; Thu, 19 Sep
 2024 09:17:45 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:2c2:cafe::4) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Thu, 19 Sep 2024 09:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Thu, 19 Sep 2024 09:17:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:43 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 04:17:41 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH 1/3] ufs: add support for DesignWare Controller
Date: Thu, 19 Sep 2024 14:47:29 +0530
Message-ID: <20240919091731.26338-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
References: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e336d3-f4ec-4290-61ec-08dcd88bec42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i8Th9Kqn9SwZMpMdURB3DqAEVyCDEl9P5jXeSJbz5kEJvQISFcrWaa/Cz9vF?=
 =?us-ascii?Q?a+NXROGKAc3/6WDeb5xR9iC5uERzwWFySfUeRO8Hfl/4ONAd9DGVkN+rvf0p?=
 =?us-ascii?Q?xT8cKQyzRkbsy2veCPCBy0whTa+cF6DctkUvbOLgcpC19mRfH5CTjs28VMsH?=
 =?us-ascii?Q?KOJ+E1Q5b1piCd1sk0pzqLAQmtVx+XevPriJV/6MRz8hnqLYYvuiUDoanudp?=
 =?us-ascii?Q?SNuf+NwvacLRnjdXq3MZuJZCPFKmDcQllZccMtx3MjMBpxysTgo0iBfC6WR0?=
 =?us-ascii?Q?MppjWfLI7vboaF1Lz92OOEOELpM/BMC3QIeyeFNBzdIp3AhWmGsT2hM/81v7?=
 =?us-ascii?Q?+TNbqR/CWOnZw4onpbH/2o4vc+sbzgLpPCUcGcPGpLiZk3GYiLrsPNRe0tPf?=
 =?us-ascii?Q?jWDExEWfczjdMYKRFPZI1TNxcqdFm2stoNVPRrc7mEBMRYMoGt6WbkFqx4s0?=
 =?us-ascii?Q?Yt1UOrq0+xFnqq4Xi6LKTHQ71LWWzvn+iuxn/aDXyWd0TRVzqjPtqesuWa7E?=
 =?us-ascii?Q?Q03ZsycFCfTYEyd1JL+j9TSZtx3Yfd7rVCmO0cY5+gYbTSsW+Tkr/pb+PvoP?=
 =?us-ascii?Q?SJILg0dmO/uwIO7lhZUZAZH//iq6CeMvIOyPw1LFfmQ60Gk4ZkWMI0XI5R+F?=
 =?us-ascii?Q?qIQPQCbd3Mc9QqaCxIux3zdw/fpZZ5BFp7vRjgk2bkkSV5360eMKPdZ+EgWn?=
 =?us-ascii?Q?gXRpV72YT2rsgKI+tLq3zksBSPU8DTi3kst1xntlzObVvPjIaqIq9Vbkalpt?=
 =?us-ascii?Q?TwVPD+3a0Y4dR2PO4ldL2XLw20esS+dLW856fItiXMS9rx89DFtq2GMyv7Ht?=
 =?us-ascii?Q?TvOtFE0FNXGqOfUKaWgix/deS+ZsEZORtFmf2Xn/0fiKO81NdMeUR5/t1JK1?=
 =?us-ascii?Q?2VTzk23RP/qnZbX1gDXOQSEk12ag/oqcHbz4mFXV+UW644MnkEnvsE+KzS3S?=
 =?us-ascii?Q?EHdkvJkgavDezG8GjiFvwh85K7PiW7LbZL6A/AZgofrFBKw3XoKgNFyoFT7W?=
 =?us-ascii?Q?CpAKPcKxljCTpOyu+cUvt1o0D581afs3KfFaPKxbvOecII0aKyKjnUYsut6Y?=
 =?us-ascii?Q?jdxlp2wFxRjGNL7a3zXDIkEXIFo/QB7hyeeOCHjmJ5PqmWRgO5TcWZZnmvCN?=
 =?us-ascii?Q?Qg/7Mh4FEP1nGiTdAP6nHEri+07if0kp4RYmrvFm3AiZ5k8UwTiph2rPC27m?=
 =?us-ascii?Q?8DiKLquTjft5r1kwZP4isLpKV3/JU3UndwDa70v5KLkZz3uUY3JSLDX6cPfb?=
 =?us-ascii?Q?xmN9KDT5x2KpoegWOvrlAl7FXCf4Q4q3XJcxnyXZWIOgvEmKmwybYo6HKkAx?=
 =?us-ascii?Q?A4iPfft7Bf46/FyJBXUE25NeXmn3hrvOIGXdoRPEctDJFsEwwqb2ubYGlQ29?=
 =?us-ascii?Q?4YcmmDGY7HODQNYxtI2uoR1IDD7V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:17:45.4813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e336d3-f4ec-4290-61ec-08dcd88bec42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

This patch has the goal to add support for DesignWare UFS Controller
specific operations.

This is based on linux kernel commit:
"drivers/scsi/ufs/ufshcd-dwc.c: ufs: add support for DesignWare
Controller" (sha1: 4b9ffb5a353bdee49f1f477ffe2b95ab3f9cbc0c)
It is ported from linux kernel 6.11-rc1.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h        |  11 +++
 drivers/ufs/ufshcd-dwc.c | 141 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufshcd-dwc.h |  23 +++++++
 drivers/ufs/ufshci-dwc.h |  32 +++++++++
 4 files changed, 207 insertions(+)
 create mode 100644 drivers/ufs/ufshcd-dwc.c
 create mode 100644 drivers/ufs/ufshcd-dwc.h
 create mode 100644 drivers/ufs/ufshci-dwc.h

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index e8a1441156..83837d5817 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -850,6 +850,7 @@ struct ufs_hba {
 	struct ufs_pwr_mode_info max_pwr_info;
 
 	struct ufs_dev_cmd dev_cmd;
+	enum uic_link_state uic_link_state;
 };
 
 static inline int ufshcd_ops_init(struct ufs_hba *hba)
@@ -878,6 +879,14 @@ static inline int ufshcd_ops_link_startup_notify(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline int ufshcd_vops_phy_initialization(struct ufs_hba *hba)
+{
+	if (hba->ops && hba->ops->phy_initialization)
+		return hba->ops->phy_initialization(hba);
+
+	return 0;
+}
+
 /* Controller UFSHCI version */
 enum {
 	UFSHCI_VERSION_10 = 0x00010000, /* 1.0 */
@@ -1022,6 +1031,8 @@ enum {
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg) \
 	readl((hba)->mmio_base + (reg))
+#define ufshcd_set_link_active(hba) ((hba)->uic_link_state = \
+				    UIC_LINK_ACTIVE_STATE)
 
 /**
  * ufshcd_rmwl - perform read/modify/write for a controller register
diff --git a/drivers/ufs/ufshcd-dwc.c b/drivers/ufs/ufshcd-dwc.c
new file mode 100644
index 0000000000..db51a3b807
--- /dev/null
+++ b/drivers/ufs/ufshcd-dwc.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UFS Host driver for Synopsys Designware Core
+ *
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ */
+#include <clk.h>
+#include <dm.h>
+#include <ufs.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/time.h>
+
+#include "ufs.h"
+#include "ufshci-dwc.h"
+#include "ufshcd-dwc.h"
+
+int ufshcd_dwc_dme_set_attrs(struct ufs_hba *hba,
+			     const struct ufshcd_dme_attr_val *v, int n)
+{
+	int ret = 0;
+	int attr_node = 0;
+
+	for (attr_node = 0; attr_node < n; attr_node++) {
+		ret = ufshcd_dme_set_attr(hba, v[attr_node].attr_sel,
+					  ATTR_SET_NOR, v[attr_node].mib_val, v[attr_node].peer);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ufshcd_dwc_program_clk_div() - program clock divider.
+ * @hba: Private Structure pointer
+ * @divider_val: clock divider value to be programmed
+ *
+ */
+static void ufshcd_dwc_program_clk_div(struct ufs_hba *hba, u32 divider_val)
+{
+	ufshcd_writel(hba, divider_val, DWC_UFS_REG_HCLKDIV);
+}
+
+/**
+ * ufshcd_dwc_link_is_up() - check if link is up.
+ * @hba: private structure pointer
+ *
+ * Return: 0 on success, non-zero value on failure.
+ */
+static int ufshcd_dwc_link_is_up(struct ufs_hba *hba)
+{
+	int dme_result = 0;
+
+	ufshcd_dme_get(hba, UIC_ARG_MIB(VS_POWERSTATE), &dme_result);
+
+	if (dme_result == UFSHCD_LINK_IS_UP) {
+		ufshcd_set_link_active(hba);
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * ufshcd_dwc_connection_setup() - configure unipro attributes.
+ * @hba: pointer to drivers private data
+ *
+ * This function configures both the local side (host) and the peer side
+ * (device) unipro attributes to establish the connection to application/
+ * cport.
+ * This function is not required if the hardware is properly configured to
+ * have this connection setup on reset. But invoking this function does no
+ * harm and should be fine even working with any ufs device.
+ *
+ * Return: 0 on success non-zero value on failure.
+ */
+static int ufshcd_dwc_connection_setup(struct ufs_hba *hba)
+{
+	static const struct ufshcd_dme_attr_val setup_attrs[] = {
+		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(N_DEVICEID), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(N_DEVICEID_VALID), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(T_PEERDEVICEID), 1, DME_LOCAL },
+		{ UIC_ARG_MIB(T_PEERCPORTID), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(T_TRAFFICCLASS), 0, DME_LOCAL },
+		{ UIC_ARG_MIB(T_CPORTFLAGS), 0x6, DME_LOCAL },
+		{ UIC_ARG_MIB(T_CPORTMODE), 1, DME_LOCAL },
+		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 1, DME_LOCAL },
+		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 0, DME_PEER },
+		{ UIC_ARG_MIB(N_DEVICEID), 1, DME_PEER },
+		{ UIC_ARG_MIB(N_DEVICEID_VALID), 1, DME_PEER },
+		{ UIC_ARG_MIB(T_PEERDEVICEID), 1, DME_PEER },
+		{ UIC_ARG_MIB(T_PEERCPORTID), 0, DME_PEER },
+		{ UIC_ARG_MIB(T_TRAFFICCLASS), 0, DME_PEER },
+		{ UIC_ARG_MIB(T_CPORTFLAGS), 0x6, DME_PEER },
+		{ UIC_ARG_MIB(T_CPORTMODE), 1, DME_PEER },
+		{ UIC_ARG_MIB(T_CONNECTIONSTATE), 1, DME_PEER }
+	};
+	return ufshcd_dwc_dme_set_attrs(hba, setup_attrs, ARRAY_SIZE(setup_attrs));
+}
+
+/**
+ * ufshcd_dwc_link_startup_notify() - program clock divider.
+ * @hba: private structure pointer
+ * @status: Callback notify status
+ *
+ * Return: 0 on success, non-zero value on failure.
+ */
+int ufshcd_dwc_link_startup_notify(struct ufs_hba *hba,
+				   enum ufs_notify_change_status status)
+{
+	int err = 0;
+
+	if (status == PRE_CHANGE) {
+		ufshcd_dwc_program_clk_div(hba, DWC_UFS_REG_HCLKDIV_DIV_125);
+
+		err = ufshcd_vops_phy_initialization(hba);
+		if (err) {
+			dev_err(hba->dev, "Phy setup failed (%d)\n", err);
+			return err;
+		}
+	} else { /* POST_CHANGE */
+		err = ufshcd_dwc_link_is_up(hba);
+		if (err) {
+			dev_err(hba->dev, "Link is not up\n");
+			return err;
+		}
+
+		err = ufshcd_dwc_connection_setup(hba);
+		if (err)
+			dev_err(hba->dev, "Connection setup failed (%d)\n",
+				err);
+	}
+
+	return err;
+}
diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
new file mode 100644
index 0000000000..d997045d3c
--- /dev/null
+++ b/drivers/ufs/ufshcd-dwc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UFS Host driver for Synopsys Designware Core
+ *
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors: Joao Pinto <jpinto@synopsys.com>
+ */
+
+#ifndef _UFSHCD_DWC_H
+#define _UFSHCD_DWC_H
+
+struct ufshcd_dme_attr_val {
+	u32 attr_sel;
+	u32 mib_val;
+	u8 peer;
+};
+
+int ufshcd_dwc_link_startup_notify(struct ufs_hba *hba,
+				   enum ufs_notify_change_status status);
+int ufshcd_dwc_dme_set_attrs(struct ufs_hba *hba,
+			     const struct ufshcd_dme_attr_val *v, int n);
+#endif /* End of Header */
diff --git a/drivers/ufs/ufshci-dwc.h b/drivers/ufs/ufshci-dwc.h
new file mode 100644
index 0000000000..9e24c230c6
--- /dev/null
+++ b/drivers/ufs/ufshci-dwc.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UFS Host driver for Synopsys Designware Core
+ *
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors: Joao Pinto <jpinto@synopsys.com>
+ */
+
+#ifndef _UFSHCI_DWC_H
+#define _UFSHCI_DWC_H
+
+/* DWC HC UFSHCI specific Registers */
+enum dwc_specific_registers {
+	DWC_UFS_REG_HCLKDIV	= 0xFC,
+};
+
+/* Clock Divider Values: Hex equivalent of frequency in MHz */
+enum clk_div_values {
+	DWC_UFS_REG_HCLKDIV_DIV_62_5	= 0x3e,
+	DWC_UFS_REG_HCLKDIV_DIV_125	= 0x7d,
+	DWC_UFS_REG_HCLKDIV_DIV_200	= 0xc8,
+};
+
+/* Selector Index */
+enum selector_index {
+	SELIND_LN0_TX	= 0x00,
+	SELIND_LN1_TX	= 0x01,
+	SELIND_LN0_RX	= 0x04,
+	SELIND_LN1_RX	= 0x05,
+};
+#endif
-- 
2.17.1

