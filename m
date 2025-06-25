Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6A8C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E00282E05;
	Wed, 25 Jun 2025 15:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2RC1WjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A995082E08; Wed, 25 Jun 2025 15:29:45 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F29D82DF2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcWHyuXdHyM7IplDLM75XvwYE1PNKH/te+LkUtx21tAmzoSH3odY84lvpfEb2UXjPKHDjvMe7Qky9PZBBUD4mKi96IU2dVhdbTL4nd/Y6VhUp/imgVBRqz4hbTF9uGbIKLvISyrYODHg2hHe+OMbO8SMhoK/vDL9xhZlAlmFG4Qwn1mObcu0RP1nl0SqC2jTuVp6qUSEV03eecDJIpomF9LpwSzIlJVoHA09IXfU4nrRizN8Tn2sU7+JQJNGWj0J6wt94aqKTuMmtxg7teKpmjvqh+GjwkhGkDRBin4Ay+du9UhSna5RvV2FFuSWciJky3XzIWFQJAoocc9xKsz2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0OPTkAdAXfwbDB/3X6H+nP1w3GatAlMTUqDX5Fxp1c=;
 b=h1e/xYn/Mbh4nkI8QXBy712g+boLc3eyZq/YN65qy4Z9jXXFBYr8YjP1DNBnxAkY2SoZ63JMkQa3NzWlS3Vc6arKTB9HSRdHMFuu+arA3QcRr6M8LveCwhynbzsNSJkWN+nBF7gJGBzZEncWXKwm5k5YL6rnVueAQkB6E20JBPk42DLksXlOxZxT8P5GNpNnPpNKW6m8Ex7iN43xoPkcu2CjWEiXPXTik5baCg6gxfYRFE0giwVVs3aOQIb3Oh6Yq/6IDS1j9cmPemlIU186yH9Indo2mmnV9U00fAlfUPxC45an6ghUDrmQ8JQeonmu0U2V7nHIxi3h9QY8eogVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0OPTkAdAXfwbDB/3X6H+nP1w3GatAlMTUqDX5Fxp1c=;
 b=Q2RC1WjYsN7sBmuMmcRIoEbvUgXFgEmA1q0UvQvY9UcVgKPzLgHyLCRM8KyjMVg3BbPNKjZ4IzbSt5mQNamJr9Mc3pApxKKCYKe7HZL/e1IFGjpHmezwD4fqnM4KRfH8oyE8AY8TkD6dgzV1WlV+2tITOkhfpaR+Px0/Thdhirs=
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 25 Jun
 2025 13:29:36 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::86) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 13:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 13:29:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 08:29:34 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Jun 2025 08:29:34 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] firmware: xilinx: Prepare code for new SMC firmware format
Date: Wed, 25 Jun 2025 15:29:27 +0200
Message-ID: <cf99fe1af82bc004de3e313d4018464f4504f380.1750858165.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LRJ9v1qcavUuQ3wqPc0+6fRkf4Ej2GkOAUqDEFRxUCw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRE/9zRajPjGGPAdO0HT0r8igtktLZwvxOzfC77wE3a4
 HW8u25jRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEyE4xrDX7GNN6psvpb/N+Ix
 SFbmNdq7Yc+yoEOaAdwnZBkuf+VbLMvwP0v4xZ3VNhavNYxf1N5yXBbpo94nlM1Y9/bbQb/0ps3
 n+QA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d392e3a-37f9-4bde-834f-08ddb3ec5448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?56MYTj6hGp7bCq7eFNIfcy/J4DJ0bOmnZWSvvoONlyN26hHaX/fpvUgp7uMx?=
 =?us-ascii?Q?LXn5Z4rlhN43DgcRfbbcqS0AUMbkb4ZdhgkkNG7yGXzWg3y51SGrFuBQccjJ?=
 =?us-ascii?Q?IyGycK6hGJVYt1VpJyMti53/Dz9setoGR1Fir/8Hmf+NLm9UreKtjiZIMvla?=
 =?us-ascii?Q?/JDrxkg5TAZyW6+A3EcjfwUxErulQaCpgedw4/oGBoEyM+xpdpzAZmqJcVGH?=
 =?us-ascii?Q?1GnyJO+aOmw3UpvGRI20xufG9xFdsgjRug7i+bUNXTwM+i/dHUa7UUFWJBYj?=
 =?us-ascii?Q?P16kFVArmHHtabWr5CCaea/y+UEceYcTvov906Wek/oX6THQl2BkR9/+4xKL?=
 =?us-ascii?Q?+1va3+6LJHWJTd4P9ZXS3PIeedVuOdmWPa3gJ8bM29b50u42YDkIjpHOKScY?=
 =?us-ascii?Q?YGe8uGnJtOs2nVRu2kGqhar1YwG5o6+O7nzYeCVAqziPiSKP7kGcwakkPA15?=
 =?us-ascii?Q?X6TDZXRMNdLEGPVLcIhFOhDvX4NP3CEbaraw7iP5ISEtlVIME9YtQvI8KoTp?=
 =?us-ascii?Q?Mq2JoiDHqIkCnnCvKo7db8vLhbF+5hkTKS5aNo1pAKLi35vg3251zUBZfWcZ?=
 =?us-ascii?Q?9ERiMxwQHEQPfAuWBOxKO3DljaugxaEH6G4NQVF1F8UvzWDirARGUnKeu2fN?=
 =?us-ascii?Q?SLLUnakemBIS3nhNV4k3g3DBehfXAK88qTMooO8ZddzOfiF9nGmNzU2KmYk7?=
 =?us-ascii?Q?XQBs6Bhd/uoZyR8GkA16bHtsS3+C1Cq7Y+GD62zc++AnYVxDRDIlkBmEYJQ6?=
 =?us-ascii?Q?sd0CR8FGSLYmnMTe66osZes+5BXvWAVA7uSFW7mEBlwrMuPaVq0TDU78sdnD?=
 =?us-ascii?Q?n6qCBP5pVJGY5kzOc+7QE9mBbUHR0GlkseoSqRQcCPJryhHA0HN1NLXMf5rI?=
 =?us-ascii?Q?U5G1t6zKX+EAnV372pqGtr5GC5hxpPEnB6oABK3CmzlZfA9NZFXCgfMy8jRd?=
 =?us-ascii?Q?2dg0no/hDInsKTjqVM6h9gNN76Tieb7tRigVTLK9f+ogERuCYXSGTZNT1qsP?=
 =?us-ascii?Q?tBqu+JAn6uJs7Kkq5mxe4wBLiJL/SNa3JtjjVY6UcrXer4GrY+yAult+ijYM?=
 =?us-ascii?Q?7NYq0QkqnogaACDLebhIdq+nhEG/FkpXbTFVUkVwemngNtJ/0Ywu+oXqAuXR?=
 =?us-ascii?Q?0FoS9Ky8eppv+ZhvEgLuMHgOnEY3nF6O3i4L7BXKs4MGLDI9qvAMytgA5g6U?=
 =?us-ascii?Q?dliFwpeu+/6t3Uc/oUZ9qwXHair2rGFVzgOUhVdJvhOArJEG0CmHEEsXXmRO?=
 =?us-ascii?Q?T6dZN1g/U0k2WmfS3DN3Kw1kfWD0dx0MAaXGjMP129X4iNAzXR36s+vXBG4O?=
 =?us-ascii?Q?XauLa1/HGl9qCdM8bGHzHLql7rZen5+Uva5CYgu23wF4fkKnKtn+QL+z7ars?=
 =?us-ascii?Q?8ksS7rbs8Doareridxdpt9nKKlpWwAt6j8tGp1hys+bFqDUJgOItIRnv3GQa?=
 =?us-ascii?Q?BENqtW7u6L+/InatpZKVIR7GuGJAcJYGjdLBljGa23ALx+JQxxft43f5Dmi9?=
 =?us-ascii?Q?CtvKls+y02/3CSTcL1udzPTJd9TQpq9SN+um?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:29:36.3733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d392e3a-37f9-4bde-834f-08ddb3ec5448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

Separate code to own function to be able to add new enhancement format.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/firmware-zynqmp.c | 60 +++++++++++++++++-------------
 include/zynqmp_firmware.h          |  9 +++++
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 2940181e83e9..d18ae523b6bc 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -422,6 +422,30 @@ U_BOOT_DRIVER(zynqmp_power) = {
 };
 #endif
 
+smc_call_handler_t __data smc_call_handler;
+
+static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
+			   u32 arg3, u32 *ret_payload)
+{
+	struct pt_regs regs;
+
+	regs.regs[0] = PM_SIP_SVC | api_id;
+	regs.regs[1] = ((u64)arg1 << 32) | arg0;
+	regs.regs[2] = ((u64)arg3 << 32) | arg2;
+
+	smc_call(&regs);
+
+	if (ret_payload) {
+		ret_payload[0] = (u32)regs.regs[0];
+		ret_payload[1] = upper_32_bits(regs.regs[0]);
+		ret_payload[2] = (u32)regs.regs[1];
+		ret_payload[3] = upper_32_bits(regs.regs[1]);
+		ret_payload[4] = (u32)regs.regs[2];
+	}
+
+	return (ret_payload) ? ret_payload[0] : 0;
+}
+
 int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 				     u32 arg3, u32 *ret_payload)
 {
@@ -450,38 +474,20 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 			      PAYLOAD_ARG_CNT);
 		if (ret)
 			return ret;
+
+		return (ret_payload) ? ret_payload[0] : 0;
 #else
 		return -EPERM;
 #endif
-	} else {
-		/*
-		 * Added SIP service call Function Identifier
-		 * Make sure to stay in x0 register
-		 */
-		struct pt_regs regs;
-
-		regs.regs[0] = PM_SIP_SVC | api_id;
-		regs.regs[1] = ((u64)arg1 << 32) | arg0;
-		regs.regs[2] = ((u64)arg3 << 32) | arg2;
-
-		smc_call(&regs);
-
-		if (ret_payload) {
-			ret_payload[0] = (u32)regs.regs[0];
-			ret_payload[1] = upper_32_bits(regs.regs[0]);
-			ret_payload[2] = (u32)regs.regs[1];
-			ret_payload[3] = upper_32_bits(regs.regs[1]);
-			ret_payload[4] = (u32)regs.regs[2];
-		}
-
 	}
-	return (ret_payload) ? ret_payload[0] : 0;
+
+	return smc_call_handler(api_id, arg0, arg1, arg2, arg3, ret_payload);
 }
 
 static const struct udevice_id zynqmp_firmware_ids[] = {
-	{ .compatible = "xlnx,zynqmp-firmware" },
-	{ .compatible = "xlnx,versal-firmware"},
-	{ .compatible = "xlnx,versal-net-firmware"},
+	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
+	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
+	{ .compatible = "xlnx,versal-net-firmware", .data = (ulong)smc_call_legacy },
 	{ }
 };
 
@@ -490,6 +496,10 @@ static int zynqmp_firmware_bind(struct udevice *dev)
 	int ret;
 	struct udevice *child;
 
+	smc_call_handler = (smc_call_handler_t)dev_get_driver_data(dev);
+	if (!smc_call_handler)
+		return -EINVAL;
+
 	if ((IS_ENABLED(CONFIG_XPL_BUILD) &&
 	     IS_ENABLED(CONFIG_SPL_POWER_DOMAIN) &&
 	     IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) ||
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index dc06abc52fce..7ef8a58847f4 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -8,6 +8,8 @@
 #ifndef _ZYNQMP_FIRMWARE_H_
 #define _ZYNQMP_FIRMWARE_H_
 
+#include <compiler.h>
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_SET_CONFIGURATION = 2,
@@ -512,4 +514,11 @@ struct zynqmp_ipi_msg {
 #define PM_REG_PMC_GLOBAL_NODE		0x30000004
 #define PMC_MULTI_BOOT_MODE_REG_OFFSET	0x4
 
+#define __data __section(".data")
+
+typedef int (*smc_call_handler_t)(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
+				  u32 arg3, u32 *ret_payload);
+
+extern smc_call_handler_t __data smc_call_handler;
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.43.0

base-commit: aca610317c621731ef48c9b5bd1a865be68685cd
