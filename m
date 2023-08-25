Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CEAC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 08:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1342186A56;
	Fri, 25 Aug 2023 10:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7n2r7To";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DC086A28; Fri, 25 Aug 2023 10:11:07 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC3183F7B
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGMSrkFB4jj9ZuxYRX6K9AWtXcXWpczZxksxsyA2je5QDxPH6woo97FK6c8f6jWIIs9/9ntkvTiUsxsL5aDP7ytavTfgliHOc80c3d4DpzzOV/nmX/YTBUL2xc4CdKFbhqNJn0Z8gKyxrz+UwAzi1LjGIdfBFeEnw+eLVGu2MHczrJOmmLvOYq45fNWx45yuuC5TWaMmQOGgSVH8fET940h7cgJ3IeiDSmppvx95llajoeXlSdl8VNLGdPOc9vXQS29BLBAyKYfGFcpclN6bBGAzCAVa5HACa8Whf6r41dUAR+orIy30vkghlqi84MEMqOSBa+jsvnZyOlvtG6dywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTP5LnRUSCmVexZxg57wJaFy0A1xqMRN7d7gaYyNW1A=;
 b=AnZF49j3Cut+OCUyjPkj3mT9xCmEZI99S70xpWbpg2ONyprWwC15gFxsjpZ1xp19VhfWYSQVgbumG4cC64nF0t7mxpP3DDvuCtAihQJk8CMzpr786zRQT0JlP5iGrr9IZLbrtHjV9v+ck8lL3bPG9s4yglANZ1SHD3t3YtRPr/qIHJLIDqqL50oXXdSFNOoOVG+HrCa8sYRwnNEMSf3eAZvthjdufjn4niiqh1kI5LgyPYtTKGqVldNaP7jRnsYSwUO/vv/gJbfbYnObf/KKFVm5tcWASXYpqUqOgqBqibwYwCPI+8mBJc/sbmJGcSKWFBi36IbqnbO0EDRxu4q4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTP5LnRUSCmVexZxg57wJaFy0A1xqMRN7d7gaYyNW1A=;
 b=n7n2r7Too4IJ9xqKRRr/hOD4rS73y/FD6WEw+xT4J3V0jq6W8BNEOFoP5vbtFVrJaezYTKGrmW46/1NYltp/HdjiUFE+2HG2zCWDHePLGyk3vB90JA7pkj+Ki1Pj2UbmgDK+wXPnp5rzZe535hxYN2qSEMVVRuzFV/gv3RvrIec=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 08:10:58 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c0) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 25 Aug 2023 08:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 08:10:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 03:10:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Add support for K26 rev2 boards
Date: Fri, 25 Aug 2023 10:10:07 +0200
Message-ID: <6b9e68ebfb436da391daeb147f2a9985ac984c0c.1692951005.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=WM3dueeYqtFjh5Km4d909M7JeOdZbK4X4n0mGos8nUU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQXiXc/LPwvovXG1Yv97++fV90j9Vco5niURj4w2PpPy
 fPxPCPejlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCReZsY5jvufZyZlHeiVir7
 cv7ViQ/+ic2RO8QwP9/j9xRzjS1+KVaqP2XZNIQkjRaoAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 570eeba6-f273-48fa-b396-08dba542d007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGNhBfi42jk3D4qQGz+t0X4ZLNen6EPKE5YKcr5Ifjsf8n1mlUfUGAhTco0QOJlS+snJETCd80xQWoOkxpTByFy8YwnNcfQYfzh/kixHFw9neza8w8HUmCIwx096owAh/aIS/QGGrVx46wftVmgD7a8Uz57IPuTEgEYNP+uZ2ahuduIkNFYtw9XEp+sQqx+PzAhdFwvxHP2dS3goyfN+0S++gw88bge0psc7sBGW5GW0eklXqVbiyBTjLr2H307GbyfF6oS6YIZrkNw6ekmxpapWixM8kppu18E5G3WlyicTqgDY6vKHTgYR4lqq1PxjlS22p452RfdEm2VIefmiE7ZyfRQOjKIduwsNRMFTvIUAietYTWkdkNh/YYgyvOvKqVwthUlbUdStliOnUM6VadSXIXYe324aXlPPO+HWEIiKQKuzj67bKwqKQfi4j1lvCiNs6bCXNNdhFRBcd9NoUE3UdDLGLzMaC8upS8SLaF/cMja8EjMpGYGec46yq4Axil0bYosI3pgyJo1KBAvR7OylRCyYr82z/yL9pZdP8y/il1BzD8XwZRKONYOPhEHBJux9T7m2WcNUFycAAmhKoMm6yAPgNb7DiQqaqCG5dOInEy73j2Mb+huXpmZ3QsMKoFhOT0LNMJ4LaIKWjjsM9642CHp7LKFW8N/M415c/aZd/IxRkWNUy6KJF+o9lF11SbUZEwzpLzINCX9VfbAzqLKSkTtH2JfQDV137MaZxMqR2WtE/bJYTIT81oV1s4cO6yXBgoKH8aFT/jILrTNGZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(356005)(40460700003)(8676002)(8936002)(41300700001)(316002)(36756003)(110136005)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(36860700001)(44832011)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 08:10:57.8553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570eeba6-f273-48fa-b396-08dba542d007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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

Revision 2 is SW compatible with revision 1 but it is necessary to reflect
it in model and compatible properties which are parsed by user space.
Rev 2 has improved a power on boot reset and MIO34 shutdown glich
improvement done via an additional filter in the GreenPak chip.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts  | 8 +++++---
 arch/arm/dts/zynqmp-smk-k26-revA.dts | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index d718fec76065..80b9face7483 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dts file for Xilinx ZynqMP SM-K26 rev1/B/A
+ * dts file for Xilinx ZynqMP SM-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -17,8 +18,9 @@
 #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
 / {
-	model = "ZynqMP SM-K26 Rev1/B/A";
-	compatible = "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
+	model = "ZynqMP SM-K26 Rev2/1/B/A";
+	compatible = "xlnx,zynqmp-sm-k26-rev2",
+		     "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
 		     "xlnx,zynqmp-sm-k26-revA", "xlnx,zynqmp-sm-k26",
 		     "xlnx,zynqmp";
 
diff --git a/arch/arm/dts/zynqmp-smk-k26-revA.dts b/arch/arm/dts/zynqmp-smk-k26-revA.dts
index 85b0d1677240..719a4e49b574 100644
--- a/arch/arm/dts/zynqmp-smk-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-smk-k26-revA.dts
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dts file for Xilinx ZynqMP SMK-K26 rev1/B/A
+ * dts file for Xilinx ZynqMP SMK-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -10,8 +11,9 @@
 #include "zynqmp-sm-k26-revA.dts"
 
 / {
-	model = "ZynqMP SMK-K26 Rev1/B/A";
-	compatible = "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
+	model = "ZynqMP SMK-K26 Rev2/1/B/A";
+	compatible = "xlnx,zynqmp-smk-k26-rev2",
+		     "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
 		     "xlnx,zynqmp-smk-k26-revA", "xlnx,zynqmp-smk-k26",
 		     "xlnx,zynqmp";
 };
-- 
2.36.1

