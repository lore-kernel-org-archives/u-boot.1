Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE01C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D284C82CA8;
	Mon, 16 Jun 2025 11:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HjSXgYdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA0B82D18; Mon, 16 Jun 2025 11:45:55 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575C382B18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drwFeR/d9px+WztmdKP0hGfoLoPNAoV/Ack+NdIppTVdhtxLiUF976K4DveYgw2s/v+xpHoR9QMIBLolPOUx0wHSP0/55vNA3b8kWGdV5s4CO2VmKU0yd3E8+yWBVIVhhMVHtcoXyWP3wAmq7cH322hhbzLvU/J0dHgxOP76thGPt54dx8P3YHU9KSQn0XE1cAbgUhVB8ctRdFdeehazKHjN77LmPLEBYsz+kTiApbCICilAc5r37yCY6lLV/N8qsPsHx+xMS2YKQZ94VDW2COjAxQx7bPS8+uV3WYal/43nj1vYnh7t10S9hs0eSxluBxDWfR9BhwBUYG14AARnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZapQeYCe1oOvSZXW+E886+vYmr18goDQzS4WXf3S00=;
 b=WOcuMqE8GfMFCqGYbeDrKaA5YGw4qJ0miv0HKxf+H95sdZMO+db3KRvI/64ppXJ8i3SEwNTDyTTicLQckZbv1YXADk6ABvKsjo+gEx+6HiwS/FgAXxsOGCbjjdyj8YsdITpwYIF1ecqvoGHj2JXKY2vH4OVvHa1j+XPhrsHquu2ExKvZGPgV+hLlestDnzOYdyS9e/VvZq3Hp0MsQNjIR+IGnSj7uSKqIeWbycZdi01tK1+IyqzKH2ixvGt/6dmX5MM2s6d0meLaat9AKC7A16oRd7Wh1kjuneg3fEuLFraih8YShxHx/Qj1H5BlwsLQxnoSiKbeNztUWRpTEp21MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZapQeYCe1oOvSZXW+E886+vYmr18goDQzS4WXf3S00=;
 b=HjSXgYdSzTfkFLMENgizXRBc8jIr7y4fE7dV0oSmo+iStMecMdRPLPFseO9tMc0E4VLMrQn7PVDEtTO9qmmGSGWg02uZfLf0b4wOB1jdG7miwJsMtPupm+t527PPQjDux2MIg01wfrcbAS5f/qL1znTQdWwGkli6q7UHZJ1VcDU=
Received: from MN2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:c0::22)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 09:45:48 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::c7) by MN2PR05CA0009.outlook.office365.com
 (2603:10b6:208:c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 09:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:45:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 04:45:42 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 04:45:40 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <sughosh.ganu@linaro.org>, <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/2] FWU: Add platform hook support for fwu metadata
Date: Mon, 16 Jun 2025 15:15:30 +0530
Message-ID: <20250616094531.4158505-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616094531.4158505-1-padmarao.begari@amd.com>
References: <20250616094531.4158505-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: d86d9d97-ce23-485e-8e65-08ddacba9266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jn2MQvnph1aFvlg0EFAE37zkAIHDhebNIsYbGjx34XkMrEV3rDEYAu3+Dan2?=
 =?us-ascii?Q?a+j1E8DtM1ne2BVgTUCxGg0G+2WNO/ZivTeEOtxceL8AVqsFxn+Cr78pI4Zs?=
 =?us-ascii?Q?2sScYTrO0KXaU113qLUgi/YjHOQGvr89onT30bZV5Ha+T518a45MXWz1bVXZ?=
 =?us-ascii?Q?mMx6tPupoM7MBA4xYmsOS22hWoZeSWIOJmqZkIqWTRMCqwpLaX8AvnlImSm8?=
 =?us-ascii?Q?ScU8yeqFsDlLja1ABiz5Zlj1OP8R6QWc3T3pdyUZRmhrP6NZ51tlHQT3kPzl?=
 =?us-ascii?Q?d8GMhhVqEK7RrjKJJa/YBujYri5lIpvUSC+zUkoU4SysDDdkpO2nBrMUELAR?=
 =?us-ascii?Q?cMNc/V5LlrQuEz62YWUNuTpY7zf7PPpaPytg1eKaKJkdrRqQCTsqa2kp8IYt?=
 =?us-ascii?Q?TqNCHihSMcWu2CedOOSFjqQCGaGS1EQf+OtPlsl9N5xT9KbT6lwutSRQPRUx?=
 =?us-ascii?Q?0IQaW9sgQ6Yt158VddohH+RE+OKQFWA2TBeJ/lGlVVetDn4DWCd1YB3fLIzo?=
 =?us-ascii?Q?Bhg0xmXZNQizgFA+zQM9a6IJuDjOoH8H/trdGhxyaEApFIngpu0iRX57q8s8?=
 =?us-ascii?Q?kayVk3PyS1kMhOwfOQXVr+R6GWERgyGEgedK/vqzqdvWRztUSv9L2pe9hwog?=
 =?us-ascii?Q?obpSvpJuknbyg13quJiEP9KSCQVsnJWTa4xFfoi1z1hBxDzIL2Zmudn1RpGi?=
 =?us-ascii?Q?Q/6VVNZoT3Kj7RsFbJkO+m+hfmwNvTE9wPhGmUu+G7PgavLDWt8H2sG34DwZ?=
 =?us-ascii?Q?AUjtAPQofOiY65EXMDQFVVA4okiHne6TzLGTSpPIQAs2QaTRxYQsE+v2yFZG?=
 =?us-ascii?Q?W3s57CEvCDheHHZdoufu7ALOn3F9yRgL9dvKKeyaknx/cCbk++7eppxfdfcW?=
 =?us-ascii?Q?PXiZi8FxpIIUD0us+xxBwe94+GkGnyaLKOANwVglM2cQBuqwzWioKun1q9py?=
 =?us-ascii?Q?BRHKUR7h2082CpmSJmsgFbsnR0I5As5oCBwPmkPP3qCjUWQqIQugosP75oZL?=
 =?us-ascii?Q?YuwSIB7bxXrDV6fxcuZ9YzhkylVPM4KJSeMW2FKGsDYLjqAk2qBy8QG0OJYm?=
 =?us-ascii?Q?V7wwEBSJYP86IEWgDoyLuvoDamPD9zLyU1KcKUfybuHjk0UdszUSTbm9AVbI?=
 =?us-ascii?Q?OpmItsw3SAVwqrjEaLIwofftnXWF0+2OtupjLiXvHTmOte76PZwWVnyMmYW3?=
 =?us-ascii?Q?IKqZKpUtHFyqW8yQ34dNwyx2Ut4FewSBJda2Zn+9JikptnjWNOwBXkpn6fj6?=
 =?us-ascii?Q?MenmPl03/VpPBI7+LziPCx97qT6KnQy3T3TyFqcTo130vaIP7BrLaUvXMU0G?=
 =?us-ascii?Q?EevsecwXvnVXFCeD8fDL/IlLZcrE9I3OwATxb/VYgi7uAjfNGDrWO4NiixSp?=
 =?us-ascii?Q?t3geIuK1ziKk+cgahVuaO9h38Fit5dXt2tBeldOipSdOgYGQCIK4ga9mcwTH?=
 =?us-ascii?Q?SAZ0Ww40rYfke73sEAP+koUUc5cMLU06RjNxG97BCZpJxdql+lDYQTreneMm?=
 =?us-ascii?Q?Aka8+WI92ZYxXt6+DLEr7WbdeKVyqEnu7iTZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:45:47.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d9d97-ce23-485e-8e65-08ddacba9266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

FWU metadata information is unavailable for platform-specific
operations since FWU initialization has not yet occurred.
The initialization function is invoked as part of the main
loop event. To address this, the FWU platform hook function
is introduced during FWU initialization, allowing metadata
processing with platform-specific operations.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/fwu-mdata/fwu-mdata-uclass.c | 17 +++++++++++++++
 drivers/fwu-mdata/raw_mtd.c          |  6 ++++++
 include/fwu.h                        | 32 ++++++++++++++++++++++++++++
 lib/fwu_updates/fwu.c                |  8 +++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/fwu-mdata/fwu-mdata-uclass.c b/drivers/fwu-mdata/fwu-mdata-uclass.c
index 92abb94dcc9..f63ee234c87 100644
--- a/drivers/fwu-mdata/fwu-mdata-uclass.c
+++ b/drivers/fwu-mdata/fwu-mdata-uclass.c
@@ -50,6 +50,23 @@ int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata, bool primary,
 	return ops->write_mdata(dev, mdata, primary, size);
 }
 
+/**
+ * fwu_platform_hook() - Wrapper around fwu_mdata_ops.platform_hook()
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	const struct fwu_mdata_ops *ops = device_get_ops(dev);
+
+	if (!ops->platform_hook) {
+		log_debug("platform_hook() method not defined\n");
+		return -ENOSYS;
+	}
+
+	return ops->platform_hook(dev, data);
+}
+
 UCLASS_DRIVER(fwu_mdata) = {
 	.id		= UCLASS_FWU_MDATA,
 	.name		= "fwu-mdata",
diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index 78a709f766c..f7542474632 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -106,6 +106,11 @@ static int fwu_mtd_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 	return mtd_io_data(mtd, offs, size, mdata, FWU_MTD_WRITE);
 }
 
+__weak int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	return 0;
+}
+
 static int flash_partition_offset(struct udevice *dev, const char *part_name, fdt_addr_t *offset)
 {
 	ofnode node, parts_node;
@@ -272,6 +277,7 @@ static int fwu_mdata_mtd_probe(struct udevice *dev)
 static struct fwu_mdata_ops fwu_mtd_ops = {
 	.read_mdata = fwu_mtd_read_mdata,
 	.write_mdata = fwu_mtd_write_mdata,
+	.platform_hook = fwu_mtd_platform_hook,
 };
 
 static const struct udevice_id fwu_mdata_ids[] = {
diff --git a/include/fwu.h b/include/fwu.h
index 6441de370c9..65797190f3e 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -77,6 +77,15 @@ struct fwu_mdata_ops {
 	 */
 	int (*write_mdata)(struct udevice *dev, struct fwu_mdata *mdata,
 			   bool primary, uint32_t size);
+
+	/**
+	 * platform_hook() - Hook the given FWU data copy
+	 * @dev: FWU metadata device
+	 * @data: Copy of the FWU metadata to hook
+	 *
+	 * Return: 0 if OK, -ve on error
+	 */
+	int (*platform_hook)(struct udevice *dev, struct fwu_data *data);
 };
 
 #define FWU_IMAGE_ACCEPTED	0x1
@@ -129,6 +138,29 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 		    bool primary, uint32_t size);
 
+/**
+ * fwu_platform_hook() - Wrapper around fwu_mdata_ops.platform_hook()
+ * @dev: FWU metadata device
+ * @data: FWU metadata
+ *
+ * It is a platform-specific function that processes fwu metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data);
+
+/**
+ * fwu_mtd_platform_hook() - Hook the given FWU data copy
+ * @dev: FWU metadata device
+ * @data: FWU metadata
+
+ * This function extracts the FWU metadata and prepares it for processing.
+ *
+ * Return: 0 if OK, -ve on error
+ *
+ */
+int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data);
+
 /**
  * fwu_get_mdata() - Read, verify and return the FWU metadata
  *
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 7f085a0211f..47aa6fad1ab 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -712,6 +712,7 @@ static int fwu_boottime_checks(void)
 {
 	int ret;
 	u32 boot_idx, active_idx;
+	struct fwu_data *data;
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
@@ -770,6 +771,13 @@ static int fwu_boottime_checks(void)
 	if (!ret)
 		boottime_check = 1;
 
+	data = fwu_get_data();
+	ret = fwu_platform_hook(g_dev, data);
+	if (ret && ret != -ENOSYS) {
+		log_err("fwu_platform_hook() failed\n");
+		return ret;
+	}
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
-- 
2.25.1

