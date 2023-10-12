Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02DECDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 08:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0770386DCE;
	Thu, 12 Oct 2023 10:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3cae7w4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3D686DE7; Thu, 12 Oct 2023 10:23:24 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F4786C21
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8gyIYkfmJbncOppvYtYU1q0GLT9sEH4aBNImwcPIsqkoZipax+LjYakkHbqRMuLq6Ln1169S6JWe8wScXi/m9YtsvAn6jP/BYyhgnxYRw+V7vZ0UnGzNxrqx13LHfCj6wLSo0kMJRNeC6dvBK6zYsqrk5j4tJjNbquwGQiOSmhoQ+w+PT+6L0nGGIG2FU4t60S20BfFCDa2Bjuy4mkx+raxJ7x27PyUSnlm8qZTzlmGVaPmeDpBUwbCRUDMJOSNrm6pRreBjgT4RqFbq/rB5NIJ2J/qu8O/SvzOLpAqTMuSDqhwFhu21IvfqAxCc1OJUK/GCYzQf+8DFdlz1ENAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOjcmxAX6yRm5V0bhwED3tN3FPvG7pJI3D3S3VRJy8w=;
 b=kcK6T1hEfWdchSG1Mb3YrTNn816+D0hlxsh9Tg+20aaSE7kqefthbk8B6OlPfQ/uPChgAJqTS85bVS+/YfIz5WgJSfmiyX1OJ0zVjlhfF980ncrxdd8bcipy1TxvhQQWzzODbRRBWDSXNUpy+AsYqVtDY28DQTkvJ5eULoHhvHkgcS31j/EoBfZXeDBcg3gDTRN6L+woKn8N6JhYzjrObWtpWSngyLhuCY8ZkS1GVkt+VyDHnBntukgPbeuqqgnhleVRGIUbiGm/wYsCgQHshHOR8oJMpgQi8euJE7RNqUhy2n0V4C/wbj+S/SzrBxLda1yRYVSJuCUijil4ZiVDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOjcmxAX6yRm5V0bhwED3tN3FPvG7pJI3D3S3VRJy8w=;
 b=3cae7w4A4OBrBwyedD5I6aTgFdrJBORsszPVikkSMA5bXNzRAgdv9Qd/JhoKMwMZ0TYBh6MXluzOgWYwQwPjJIL2sM2kxdVayPJW61uPgQ9Ev0/TTm/QmDbmLNb/iMypvBV2He21JhIDZ7080k914HwC6FkMj24RoRO4v7uJMdE=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Thu, 12 Oct 2023 08:23:16 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::1d) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 08:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 08:23:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 03:22:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Remove fclk driver
Date: Thu, 12 Oct 2023 10:22:16 +0200
Message-ID: <fbb8665b8a58dbe96349abfe5492a509939e165b.1697098930.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tDKwowUerLpzZ43adufRM590xZH7Y0IFSVQuF+SXDzM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1NZsuzTh0myvHh9G2rjFSkLNmbsPzfXf5eDqOKW4RV
 Cr/0hbcEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbikcQwh6OLZcPG9PUfS93P
 zHKY+Hy95UnhYwzzA/o2NCxafafc8PH+h3MqVySdn1zyFAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: ec81ece9-c192-4c1a-bcf6-08dbcafc7b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0ap0U0ngRzX5NfErgSx6YVs2dKcb82l4umy2GqXdwxRqtGhmsNw/aNcRNeK+NFG/DSRRNiZWc7OH9cHXfpCY5hGQNz0xPqEuthbIR18ua5RPRf/zn11ViO7y9Ahzq+FTydl1aKXCoHWqGc6rsKJQWZgS+nEbiO/ZYoBanrPIin1+R06kSxTlqjZX/CXtjfJYk76To+qTp64YMitpHv04F4o2mVr1TeS87Y0feXSr9klb6sM3W+9PQX8n3d/xcBgrNRlWKoftHRS9g/DzeM7kXqM46uf9HYjOIoyDPI0VQk8t3ueQvddycmdaU3Hs73BIe01Q8QPJMOoxyPMtTNKRYsRMHvpfaghTklYRWQP4PX4KV4mOyVTYPRTcFthrGCGrn4H10qVyFXSEWXRnwvjUF5HuPwmPbkwik2Esm8KP6Pzmfl0uuA+anJfU2ego45DZrecI8lMDmSZAtYrl5sdZ1gPeNPPjCzpwwEx4WKbJ++dJN4/mcwuKkS8WmBJo8swy5Er5p46hWJ3YhDSNJC5ln0Us8AZRqdyKtCDtN5vEdzhiMnV59I1fHpOH8K7ruuhFlVK+3uULGp05ZDWDs5LBHgMcDPa/9ta4ek268ZQdFMk65cBTr6V2OhaVauoDWSi7h56WLzSfWpZ1xlSLPnqJr7PIAqg4QJ6JMh1X5UbmeWSNaRWOJXLe7VCmuCmK2DEbrSAJXtq1k5Bd9DVCa883Hf2RGuyAehk4f8TWnrPbW6RKeBQ6I7jKFgbfetRpljn0vIUU6KSQELycY9qPuBRmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(81166007)(356005)(26005)(426003)(336012)(316002)(2616005)(16526019)(4744005)(83380400001)(36860700001)(2906002)(86362001)(82740400003)(44832011)(6666004)(5660300002)(47076005)(8936002)(8676002)(478600001)(40480700001)(36756003)(41300700001)(70586007)(40460700003)(70206006)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:23:15.6724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec81ece9-c192-4c1a-bcf6-08dbcafc7b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

fclk will never go upstream that's why removing this node from DT.
All PL (programmable logic) based IPs should handle clocks self without
using this workaround.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-clk-ccf.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 5f1b0b23c124..dd4569e7bd95 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -10,12 +10,6 @@
 
 #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 / {
-	fclk0: fclk0 {
-		status = "okay";
-		compatible = "xlnx,fclk";
-		clocks = <&zynqmp_clk PL0_REF>;
-	};
-
 	pss_ref_clk: pss_ref_clk {
 		bootph-all;
 		compatible = "fixed-clock";
-- 
2.36.1

