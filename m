Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DF4C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 10:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A8288681;
	Thu, 30 May 2024 12:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kx4iQt7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12ED08867C; Thu, 30 May 2024 12:39:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9BD88681
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 12:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwDdUjb7jxHgEKaGJhYRi7+uK0SBp24a7og7pPzLJHHSsb65MHLUkjIERfyXl/g1YD5mWoIsY1dJLStrv7S2s2HhzgmtTn2D2oGhyC0G2BOvECL0Q+aquONYU+mkXuq2ZsiOZKmeX9d4Z0MoLVHKV9e4I/NU7FQmk3nIPouRBAWRZ6gDZSLaMbU0Ult7L4h2r7sgQjueyb8HN9zorwjqPzfKWtLCByd22YewjxZr2O7hefX1rxyWHJXqOOvvXh/HZ9QzN9LSQWbE5WywFlr0qu+STSBABeXFIa4WDEbTrrhOfrSFhjxDxy5tmgwFQa5KWqVgsUBfGWu0RuKbeRwxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOkpnpUZPnpjRo0QWRhBdalOPcInVnCRUdBde42Usso=;
 b=QH/F4WAKkSKESPsqz8ERRQQKUCBp6U0l+99MbV7VMVSsYkhB42yqeKqMBlUy8TNM6vnKpJ/Q4+kRMqPH46FP9J/erT8+lVWVQuV3PdHhpxkMJKAjKRkSFBY1/FuRNkT/xKTMeTqxKc2K4jvr/EjvMo5SJMvLC7LLP2+/GYfsiDQzGh2LXGBgroSVORypdx5LbQODw1r9iw4ayNQ9DSGh05VTPxu0sVxP5oYSBuTladW8qe19DbgsYK2qzv+ZlzjwgjyrGtMYGB3RCQUeWiO0M10oYyXhIiN++LC5tcN6SLzZ+baK+GBw8qXHQ5wraAFcVxNdgoL484I2Z+W6w7ydsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOkpnpUZPnpjRo0QWRhBdalOPcInVnCRUdBde42Usso=;
 b=Kx4iQt7SDqugqZYPOEhJNI1B6KUe3vyvB4cXdul+B/OHaH2FcohIUuTQVRttJ/bXvSg+7PclaclHsd0fGhhEKG/E41KLl7O/ZGBA+Aa0qDVw0Xgg1Bkjh3wQhbOPQbZiJuBeTPEsNxOoSk54GMMEfY+rTl8d3lKKOUNQwX+DJMY=
Received: from DM6PR01CA0017.prod.exchangelabs.com (2603:10b6:5:296::22) by
 BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 10:39:27 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::52) by DM6PR01CA0017.outlook.office365.com
 (2603:10b6:5:296::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 10:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 10:39:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 05:39:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Update rproc node
Date: Thu, 30 May 2024 12:39:23 +0200
Message-ID: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4068; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wf9A1mlHfZc8wEzz6iJxKl8WkKmrwAEbjf3Fb9VYwCw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSI8NADcwNa3rNmvJx8RyObjee43ob1GSxdjF5vFuuf3
 ppWdbSzI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkmibD/NpnZbMvnv/ocoz5
 970VyS4a2VfPcTDML+z+I6ey6U7L24u2O8+FPpy3WmTKXwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3086d1f7-d92f-4e41-78ae-08dc8094c7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBE2sedheEnWZburmhLOLB0XE/ZTcGKx3E7Rb4/i9RJHkSS7qX4UbdwHvJ0j?=
 =?us-ascii?Q?Vhe2jQt3KN0O1slQU3hUkwhEBo8ZfGGccvUwEgdpdBL9OG+94sLHBllvHklv?=
 =?us-ascii?Q?QgLwpv25IjH6HNJOPyPvlT5NjE5uZ95sc1VvAztB3LijpmU945l6BykMfl6j?=
 =?us-ascii?Q?SLJalduSbwFhRM7l/BcpJLQcgFP38POBxzLJiqw9z6is47VKgHeCVjL8UNag?=
 =?us-ascii?Q?THdudJVmN15/kamKGX+El8uv28ULr/EVyDJQmhBz9M4+FOkVC7BprBw9ZxBG?=
 =?us-ascii?Q?p/9enW9oxvlF2RkfDg6I8iAMaqywt7rmXB5DC/IQXuEOLgmP2IsQbCoKlJkd?=
 =?us-ascii?Q?WhUtq3pZJCZL2JPFcg2z4ZU9F2kcbeqYsaJo4KSl2fb2jyrbabFfPgmtI+c5?=
 =?us-ascii?Q?xFEhFykqo4ZccWPaOiYY+3SoQn54zVFXVR9rfG6Ut9jh9/BzJ7Chnf9MFqCp?=
 =?us-ascii?Q?N5y6rqPb/adzOZe+2+w7SNJl0UxySh39CIFHUAvU3uZTYV6D3T0aOpSt/fIU?=
 =?us-ascii?Q?++ixtLs/Q1vmFGfny6J4zFHR/OW3f0xF9pVGVgq1R97SxU8Xv5zQhpcvNn1V?=
 =?us-ascii?Q?lH+yxqEwcvY0o6vo4e9+CagXMS9W646St2HFbfciGSOD9ALziqF1l3PnedJS?=
 =?us-ascii?Q?N/sTsT6GQjUL0N/aVc71G3enPwb0PNxlMSZlDRqIwCcvGl25pbmNfUxijCwE?=
 =?us-ascii?Q?5k20TEZ8g38jSNvX4igt5CRkV0kLvHEv82No4fkdb/PQ9CEV/zLo/NIcoPdi?=
 =?us-ascii?Q?uLn8uCps5lZem3C8h448EFjxBKNaO+/kqAkvyVpl4j1xihUH0IwCH3DA8RaP?=
 =?us-ascii?Q?a5HCR2Kj9CIcM0SPBfZAZf+3/p9v0bD8NWb++lMmsMQeR8eG8JTcqNxlGTDs?=
 =?us-ascii?Q?qa/Yif3/1xoCFZ46SJygAHQtHwv2s3RoklyOxsiguIe9o6ItdGaxPTmJBvsu?=
 =?us-ascii?Q?8g5fe/sK1ko93A14Ao6PNov80LSjOvxVSQ0XeQ2UiwMCBX/oUyOoNO+J/w0r?=
 =?us-ascii?Q?k5SUgGJInw7L//M+vgrLduR8Vu/z8t8C206Y/W9tkIO/9XPal5KLgEAxkr0e?=
 =?us-ascii?Q?Y2c+lKT+ET9yJXOXjUPIkNNxclVJt+WFS0FwqyIOJlEuOG3zln15veO6nShE?=
 =?us-ascii?Q?ndUbVQPFmgcwQ7AtmSklQ+e0CqDZ7yV9mT24N5NLdENUxSi1l74Dvq9uquWq?=
 =?us-ascii?Q?7sGTl3PBJrmAqBjrtV+DPyvrbAs13eL1Uwz0ZT7YqXCirRSmsyfF1Um3XK2w?=
 =?us-ascii?Q?twCiF1jSzrOwuhKjaPOJFHCwsUac8LVFThrhXt+9aLH3Pcn2UUmozjhfrI13?=
 =?us-ascii?Q?sR5bOtUk+YVgxZlQLkJ9UWPPkCdChbpPM2jgYCCQKpsH87/wbGpJcASwgz8j?=
 =?us-ascii?Q?htYeX+k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 10:39:27.5198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086d1f7-d92f-4e41-78ae-08dc8094c7d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

remoteproc node should be updated to be aligned with the latest dt-schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Once we push all dts to Linux we can change to OF_UPSTREAM but till that
time we need to keep DTSes in sync.
---
 arch/arm/dts/zynqmp.dtsi                      | 67 +++++++++++++++++--
 include/dt-bindings/power/xlnx-zynqmp-power.h | 17 ++---
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 53a606c340a4..34f592c1a85f 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -314,19 +314,76 @@
 		ranges;
 	};
 
-	remoteproc {
+	rproc_lockstep: remoteproc@ffe00000 {
 		compatible = "xlnx,zynqmp-r5fss";
 		xlnx,cluster-mode = <1>;
+		xlnx,tcm-mode = <1>;
 
-		r5f-0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
+			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
+
+		r5f@0 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x0 0x0 0x0 0x10000>,
+			      <0x0 0x20000 0x0 0x10000>,
+			      <0x0 0x10000 0x0 0x10000>,
+			      <0x0 0x30000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f@1 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
+			memory-region = <&rproc_1_fw_image>;
+		};
+	};
+
+	rproc_split: remoteproc-split@ffe00000 {
+		status = "disabled";
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <0>;
+		xlnx,tcm-mode = <0>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+		r5f@0 {
 			compatible = "xlnx,zynqmp-r5f";
-			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>;
 			memory-region = <&rproc_0_fw_image>;
 		};
 
-		r5f-1 {
+		r5f@1 {
 			compatible = "xlnx,zynqmp-r5f";
-			power-domains = <&zynqmp_firmware PD_RPU_1>;
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm0", "btcm0";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
 			memory-region = <&rproc_1_fw_image>;
 		};
 	};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
index e7eb0960480a..618024cbb20d 100644
--- a/include/dt-bindings/power/xlnx-zynqmp-power.h
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -6,16 +6,12 @@
 #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
 #define _DT_BINDINGS_ZYNQMP_POWER_H
 
-#define		PD_RPU_0	6
-#define		PD_RPU_1	7
-#define		PD_OCM_BANK_0	11
-#define		PD_OCM_BANK_1	12
-#define		PD_OCM_BANK_2	13
-#define		PD_OCM_BANK_3	14
-#define		PD_TCM_BANK_0	15
-#define		PD_TCM_BANK_1	16
-#define		PD_TCM_BANK_2	17
-#define		PD_TCM_BANK_3	18
+#define		PD_RPU_0	7
+#define		PD_RPU_1	8
+#define		PD_R5_0_ATCM	15
+#define		PD_R5_0_BTCM	16
+#define		PD_R5_1_ATCM	17
+#define		PD_R5_1_BTCM	18
 #define		PD_USB_0	22
 #define		PD_USB_1	23
 #define		PD_TTC_0	24
@@ -45,6 +41,5 @@
 #define		PD_CAN_1	48
 #define		PD_GPU		58
 #define		PD_PCIE		59
-#define		PD_PL		69
 
 #endif
-- 
2.40.1

