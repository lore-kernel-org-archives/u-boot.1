Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98437E810B9
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 10:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B7486DA7;
	Wed, 27 Sep 2023 12:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="buS7JNRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EE786DBC; Wed, 27 Sep 2023 12:06:12 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F90E86413
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 12:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlB5Ynorq/9ieB2Zap8VV7z04hzIx60b89cPN7Y/QENwjr0W1MP4pLGsaCnD/LkuShJ1PzZP29iFV0LWmC8eTfYagCuMZQCBRMIDW53kTHdhR69woherftFrIGzdWEvsqXtTKHHJ9M+PRsypVTULSGtUqeHVCVOTaAAkh838SjWLJXAH9+l4xxwfmBpr6l+J1T8nezV+8w34clcpVcjw7Z43mbSKedQT+ICi02rDxIgmucbe5ODheZon6hWumvhXf0ToCItLW/57bxeB50l96WBh0fPDCZCBpKiHBoHDi6ya3gM5Wu73Ruy+XTsQXvm1+rHg/pmB6OJFmHX7mIoJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbXwR0v8VcY7RgXNJOjG939vLPuFZ+H68l2ULpZRuvc=;
 b=h2zzkmv4GY9cMSk0wghQE8Y3fykACY3E9pAH8wBK/xtOkY1yzr1ygMTY1HpJNZSU7viXdMPw6VaQncB9ieZaY9wQRM/eTrflAURB+aPBICSas2FEEGMOQzbzkXRzt3HvZVcY4QbCrs99HZBmuDrS6IFq3qpArQTCzVmvP2y4iFgRmOj9pj9PRXP6RnsRapH7FMSRVrI7etPAnbjz4qDEl1EGwFpCGDwifpnz8rHAGJ5sRVW6qut5Zxv5fJofTjmXtXj4XOO6g8LJ+hUEmhfnB6kLWm/sZzukkliWwExKDL3ww+U+WRa0bbuorqAvgQrXa0UxbDYEeR+UAgdhNJV7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbXwR0v8VcY7RgXNJOjG939vLPuFZ+H68l2ULpZRuvc=;
 b=buS7JNRubfBIIchn7FamioPptmG04qps4H5i99KB0ltzJsqklwiuy7sGH8s4y63WlnSG2LiGVbW9ug/7hw7lA/u047NmJAR0A/wSP6CtIO2QtzSBbodVJautgjTo4SIYLaa/tu6XlYVQse1teLukbFbmwyfZltrwtq9cSHhIatE=
Received: from BL1PR13CA0226.namprd13.prod.outlook.com (2603:10b6:208:2bf::21)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 10:06:07 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::38) by BL1PR13CA0226.outlook.office365.com
 (2603:10b6:208:2bf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.20 via Frontend
 Transport; Wed, 27 Sep 2023 10:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 10:06:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 05:05:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: xilinx: Do not use '_' in si5335 DT node names
Date: Wed, 27 Sep 2023 12:05:32 +0200
Message-ID: <ac752b1e27f02efb32608188992bb7ae50e4b1b0.1695809130.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=B7CZzDHgMBS4PoECzQaMXirv4pCkYMNOMA3qvUsTQiE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlThf1negtUtd17yvO+2KN5z7HpbYMWLPSvVJt5ma7nxN
 LHI6YxkRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIVzfDPDULjg0Tm8tK5C50
 7OgVjnv+JFXpIsN8B/Wynte3Xt7v8LR7vDxm/VImi87lAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1bddde-9993-4c67-5ca1-08dbbf415e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZM7mqJMotTofx8Amx2G5K/VRRKj0XwbrYCSw+OvsjZblUyWTcsTLPCA+7zA6NkEWte8yBXE0h3dWg0VUr7a9zeinM8EyUhsjCxBxRB3pONDXiP/FsGvNPge+A2LFdklRTmv3xbe73ZG759oDdf9HunHHQ/FPLILo6X21x7IApsuSmOthX+KvqayVGmB4zssMvqJHRigtIBy+a2P0PYmpIwkPKUDW6RwkhC1GaHvhPo+we3rS60Fmbw/SYEnR1xBojaDkYrL94rFvmV2sq2hkMVscWx5MthtectUHlV+ePvAhUo1v5Pg96Gs9gGIN153ljy7g7oaCnB7i/MS1ylgOheDrKzXW6tm7lyV0fGywXRW7xaZUm7sgvLaHMoJznPEvMOzP+nRnfEyp3hkiibFH1TZmqBrhJOeJNAsU2rCneelwmO+Of6mlZpgj9eQN4BBgw5CsCjxwe/nVj96n/+XJ8A5cDhDuqP2MfE9fJ4RmodVKgTsWfNoZJt4hWd5g0NJZQkZn4zzecg7NSpHEdmHVhqcpP2MlCSaCyxVNmvrer0ilnPrfJhA/8N+JXY1cHpE8x8WUJf1VLRpY445a394dEmczmWpbv/ye0vuMyMOSod6M4gzXEoDCld94LFApChagcRqQYdMzYUCWIKyhDSFVhwenSOhJz0JKr9vfwcA7CivHknpeR1g6C/QnO/R6/UPDERhQOM8MeOb9TOOaoF6JM9iwQSMrR7tU0SEVdkL9aRruPWqGk4wMTshepT27DpR/F2l1dmqjtN/B+SOvpynmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(86362001)(2616005)(356005)(316002)(82740400003)(110136005)(81166007)(70206006)(16526019)(478600001)(70586007)(426003)(36860700001)(26005)(47076005)(40460700003)(8676002)(44832011)(8936002)(2906002)(5660300002)(36756003)(336012)(40480700001)(41300700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 10:06:07.6399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1bddde-9993-4c67-5ca1-08dbbf415e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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

Character '_' not recommended in node name. Use '-' instead.
Pretty much run sed below for node names.
s/si5335_/si5335-/

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Till now I didn't heard back that different style should be used that's why
also sending this patch and separately from other similar change recently
sent.
---
 arch/arm/dts/zynqmp-zcu100-revC.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index a84cd86694e2..44d1b24677d1 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU100 revC
  *
- * (C) Copyright 2016 - 2021, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Nathalie Chan King Choy
@@ -131,13 +132,13 @@
 		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
 	};
 
-	si5335_0: si5335_0 { /* clk0_usb - u23 */
+	si5335_0: si5335-0 { /* clk0_usb - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5335_1: si5335_1 { /* clk1_dp - u23 */
+	si5335_1: si5335-1 { /* clk1_dp - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
-- 
2.36.1

