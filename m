Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FF7C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 12:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8CBA86A3E;
	Fri, 25 Aug 2023 14:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxSlv1Mq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7316C869AF; Fri, 25 Aug 2023 06:57:03 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFA186A09
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 06:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiy7GPdS2HTdFD3KBvy9kXfvMM7SmzoXI5SdBRbZ3ItfJCoD04gnETT41hpiImevB1EzHchKBIivk0uX9wsgz4pdprUzvPWIV8K0bTpnZCfHzBbxdHKwSBGzyN4IFEQJBMPI2RxIqJ6+x98m3uwEM/tZzlqSluX4KhR2pD+n8Bq3AKfA3EPMYpsPjcL2IRA1BkYvWh5Ywhp1eofBRXKO0TuUbcXCUIwmyQudAoCPrmdlLMhRhpiInIV8ICTc1WodikxRMYBZE9NFefkBuwYAQp5flCUHS0Gxb3jNAM63164fIpjEI+4uUUHB2dMy2XMtw1tVwaHuh1uGxXVOK9Rowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zct3eSemp/JdYrfUErnkYW9VBEoXrAyrudU0CY9clro=;
 b=gsKS3TRhiGXLh58FliXNvslC0zEluYCf88aom1Ev2/39GXeoAzsJaaNRaz1Fw1566hSCUO7Dv9I2HSSigHteYta2IpBvdRKR+UlUZhoEgvZl3WGilg98vEJQURa6vuyz4Bj526tSmMxjebVvt2dYXPTyKeVUBqOwn13anchVDXTfq9tVRUDmUy6KX4G7l6MR4lO7ZewV4rIiCnjY0hrObUcMH9BdJxRyhh1czwPN8b6hqvfkK5Sglva0/41kOrOhjjo5YWDJTVQQ637eg2E/P9qUsYfqNsdkyiAZIf8DPii3M32UY8fqn6PwR515JlDVFcy+Shu6WasBPfe2FfneMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zct3eSemp/JdYrfUErnkYW9VBEoXrAyrudU0CY9clro=;
 b=pxSlv1MqyDGZ0mwTfosbP6xd0n6p81Z1nOwd3guY3IPBFQgWT27GiKMrH8auErctHgWPhefkvCwRfTSJCqBzCedRVkUiscOtPg656PJsY9EEwiQ1iO79Tt9LLi1+YFseb2Hgafoniqf4+F0KCRoCtwc60SLo/pvqdtKN/bv8vL0=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 04:56:56 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::a9) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 04:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 04:56:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:54 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 23:56:53 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 3/3] arm64: versal: Enable the config CMD_KASLRSEED
Date: Fri, 25 Aug 2023 10:26:41 +0530
Message-ID: <20230825045641.32728-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
References: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f351014-cd01-445a-382d-08dba527b45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhBe8r1oGkaFiRl/cAMcsMHbgRBi4J5zJtldgpP70jBXYQBktZzLhWzgp90T2Zvor1Z7YrYSWLxkcbzP6R+t+PCNARiKmy97Z9DgoixsbQsZFBeqsgI1Ck7+KnH+xclMVaIQkihEt8o+MXgVYbB7lS8kdjvMBIF3HUHg5RA8ufli1eyfkZ20q+6ns7PEnFvHjofLtQhrfjbsjj/M+2nlG3O73P/3DtctmRx+5iNuTFe3irPWYyJBjbvhAQC/+wTIc2+nI4iZYH7a2foZ1GtsKh5z+yXKevpzlEPr4tfDJhZK0sj8m39VYJYs46DcvDapS8+yRwu4TINi2NTyHHGIkraR8QOaNpV6XVuNP6Cmp1K7hkseAb3iJCwywuFFGigM/gpnWO0kd0Itt65In5WaR6BBIPXEH7Khytk6T0CixG2a4Wz/sNaHiZ/5iRodBVLYq63N9E4YTMsBan1FS2yAlOawS2MkmHoNb3aXcV/YmqnGDXH6ZvR1ZUlgFA3xBQCqfT22ZwSPOz87TbSW4/p7/2aQMp6T9+zxilOokM+KI8Y0QeMeRfmDcaZVHYeVTsnLzFwVBQxB8zcPzxNtvsIqnfcIRA9ztb+m74haDwtJXiMStN53X9C5oIbT6+zE17QH73e1fRlCvRQAVFW2ufcl8PVyH9opwBXHoleR9WdPVJSwqo7Vb0irWX7UBRoJsnZlLtOuA2LfNw0Uwd47DWW0jZ88yplTl+a5aJX1W+9JRa1Bt8AvCopqnQoY1/Veulo1DLyeJjbgqD5b24Uiv029Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(356005)(86362001)(82740400003)(81166007)(36756003)(40460700003)(6666004)(478600001)(5660300002)(70586007)(54906003)(316002)(6916009)(2906002)(70206006)(4326008)(8676002)(8936002)(40480700001)(26005)(426003)(336012)(83380400001)(36860700001)(47076005)(41300700001)(2616005)(1076003)(107886003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 04:56:55.0747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f351014-cd01-445a-382d-08dba527b45d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Mailman-Approved-At: Fri, 25 Aug 2023 14:39:25 +0200
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

Kernel Address Space Layout Randomization (KASLR) is a hardening
feature that aims to make it more difficult to take advantage
of known exploits in the kernel, by placing kernel data structures
at a random address at each boot.The bootloader supports randomizing
the virtual address at which the kernel image is loaded.
The bootloader must provide entropy by passing a random u64 value
in the /chosen/kaslr-seed device tree node.
When we run "kaslrseed" command from U-Boot, the bootloader will
genarate the kaslr-seed and update the /chosen/kaslr-seed DT property.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index b4082c3dee..69af916c3b 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_TPM=y
-- 
2.17.1

