Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D311CF58CB
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 04:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2DD88C4D;
	Fri, 20 Sep 2024 06:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="coc9tY5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A9A088C4D; Fri, 20 Sep 2024 06:18:14 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA23088B31
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLeJ9IhVUJBtGcX9JFv20sRbX3BKUbzePhQuImRyPuzW4gOpo8mIKYun0tLbtR7fZzFhyOwtNyY82LOQClFoILILtjYGdNml2cOWLph4ELQItQajU0+n6gM4QU8NUITEjl1M8HIgvHBp7y11RnhLY7Bc97GiCNrLtB5E1yjP5mgSTf2wxz62g/059b4E+SDeEdF4CAUKbedcd1wONM6bGhTLTeC9erYZDfzNeu60PbrePLDMwx0vRnK4Wxlymf8QiK7ldD84kGjQQ/KQIjUoi1wpL0a+Xfg19EqUJv5UMi9RKsIWxAsYNjdflUCFI3IA83jmJmTBOw9G3iX9dwi6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2IXfKs/UTtRZC9d5qbrABMLQVkGtVm+ETluMNZaua8=;
 b=rrRbAmUdMs2byrzK80iQVwHC7l3tfcN1eKL08jkQHsgu3kiK3R8NRtZt8clqQxtdQHQ4eHcslFEd1i2/C7OlMyXxf6FUw1QW8NoavUcuPHRS0gRnf6MmjL7ogZH4u1aIHASWV+5ysCrENQIG8NY7li7s17dS4UNeFzGCuTTG8mpq/sxylSQhTPaIUJYdnhqkLGx9kCPtWYP1hHS3lNs0dt/umi7qBScdccHgcHlTUgmu1uwN7J7SWwogEb2AgTfbyBVAQ/og3lR6kgFzAHH2HXIc3Nu/uJfz99JUQUJN2JWMbpM9yOQhECgpxb+rFIn6+DwrKgXruKuWpLT0yxdB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2IXfKs/UTtRZC9d5qbrABMLQVkGtVm+ETluMNZaua8=;
 b=coc9tY5pMkVtpOx2ZvBqquvTB63o4a5znfBqkmkKxMq5wQSiZ6MtzkNXMsuFja9hSUAIGQkR+fTRej7egA06L+AEPPRE2Ephzq/e9w0r9y3r98hLjNLbX5LCuEhDFLkuETrFdOdRFw0uR/wIeJFR47JVVzDaXhWmVkPNA3/yeqY=
Received: from BN0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:408:ec::19)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 04:18:07 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::d3) by BN0PR04CA0104.outlook.office365.com
 (2603:10b6:408:ec::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Fri, 20 Sep 2024 04:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Fri, 20 Sep 2024 04:18:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 23:17:09 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 23:17:08 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH v2 1/3] ufs: add support for DesignWare Controller
Date: Fri, 20 Sep 2024 09:46:49 +0530
Message-ID: <20240920041651.18173-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
References: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: bd293800-2c4b-4db8-7db3-08dcd92b3ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WZLFlQ8KFUnVj0OFiRBwldLkn7j58N3CTr36joKJ4bdVgWUNPCQGBXwxugwl?=
 =?us-ascii?Q?GZ6DG/X3KLAi/HC5tZ6A9s5MEbKlLpxoCEOn1A1jxbxIwfoX6Ybv23LN/Ta8?=
 =?us-ascii?Q?KevgK2lOfRenBm0lOVcRQpUAxrQCrZ9UqHTdR2LLK/sgAVHxwLDVk8uBnyAr?=
 =?us-ascii?Q?4z616a15K8O3S/LJAlthN5c+DXZs3pI1CZ87vDe3Pcueie2zx35hILMo0fGe?=
 =?us-ascii?Q?lZaHKTxUCsuvLwFHqI8/QQR8Vv3YFZ/kfBdOWR/36ZfZdTz48rW/s8cDcE51?=
 =?us-ascii?Q?BdZAO22l/jUFh34dIsY/venKLpHznta5o9M9I6iwXouovNre5JAdMw3gewgh?=
 =?us-ascii?Q?uJwsLDdk8wRwa2UyW0clnrj9c/r+ETTEdqnDsN3J7mMZYTspR08yYGrJQ+RF?=
 =?us-ascii?Q?pPuXNDwOPskZuZimTkKOaNGzy5Y63nT2ykoK3PQFjmHEnVaFEwFAs+LPNJh9?=
 =?us-ascii?Q?SS9sjqNhOMOFV30fE+C0FKijybyd0pQY0dnPKVUXyGRaxz6+/HTu0sYPjcIs?=
 =?us-ascii?Q?A43QM1C52G6QbGICJeRhqDJCQdAgVbxsXNTaQmh54VO6f5PyWJUml5QVQ4kt?=
 =?us-ascii?Q?U0/GszQQm7kqAK49DOZrSMfWo0y5coPDLwixaujjila/aHhF1pyoYeXoymug?=
 =?us-ascii?Q?XhFfl4PvIiIdXVKQp2IzpeF0WsRbgsDkWZQjgdza8Oy4hxt8gxWxC4x2KkGs?=
 =?us-ascii?Q?ByryWoxveKpooRVS6O+hJ0udS6VL2oBT0EoQSLaD7mamUw9vrQj7oHZdyMVw?=
 =?us-ascii?Q?XaPueAhnpow0HtAuk+eB64dTe3zmB056EeryqvSoOjQSgSlHnc+kCFf6hc+K?=
 =?us-ascii?Q?N3vH/fHv+AXz7KVjfHumQiGSZf0jRK3Ce6ZGLfqqHM82Q4WZZ+3lsoHWv7sh?=
 =?us-ascii?Q?0Im6iOcmHjNdp7BwJ0K0efLX6c814eZMngVUvAljg7uZoFkNp4bLA9Jq0txT?=
 =?us-ascii?Q?eo68oqf6XE5KNaNr2xO5j+mvVj+t1LDjmgGZiTCqcTwlzjsJpYHMyMJWv+8H?=
 =?us-ascii?Q?N8GGhgeeBm88LlL70o49cFtWBWJcWVtgb0Ut+ieNIb4LN6PPrmCl4w1Iwgv6?=
 =?us-ascii?Q?QJlEuQ533pRLYn9OBnQsTc5Th8c6BpRJSISP98D6MpID9yEfIaYkIBcSp7A7?=
 =?us-ascii?Q?keEZ4Hfo5W7XHD429BAJNxgQ0YpvCUGA/uETi4GQf4UhTrHz3/D0ecEoo/Yv?=
 =?us-ascii?Q?tgs6dVxdBvzyj03kX9kPVFL2BZmarMtjGmV+eL0tzDAVzxRR4hPaF+Vw96QM?=
 =?us-ascii?Q?3ucymU+7QhqxXIQI9uUHQkRc4Ee6KsaV5rfBC6F9FtQ6hLK5JuvQlUZwiRZs?=
 =?us-ascii?Q?zNazCUR7yvu9bgbqBUqlyITytZfA+GZpL5xxdjPmQeHaitzbIZpazKae+Q/H?=
 =?us-ascii?Q?YAQv+hTwysnCJG2RMHqOFk1FE9Tm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 04:18:07.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd293800-2c4b-4db8-7db3-08dcd92b3ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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
Changes in v2:
- Removed the ufshcd_vops_phy_initialization function.
- Removed the ufshcd_set_link_active function.

 drivers/ufs/ufshcd-dwc.c | 133 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufshcd-dwc.h |  23 +++++++
 drivers/ufs/ufshci-dwc.h |  32 ++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/ufs/ufshcd-dwc.c
 create mode 100644 drivers/ufs/ufshcd-dwc.h
 create mode 100644 drivers/ufs/ufshci-dwc.h

diff --git a/drivers/ufs/ufshcd-dwc.c b/drivers/ufs/ufshcd-dwc.c
new file mode 100644
index 0000000000..3f62e59a06
--- /dev/null
+++ b/drivers/ufs/ufshcd-dwc.c
@@ -0,0 +1,133 @@
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
+	if (dme_result == UFSHCD_LINK_IS_UP)
+		return 0;
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

