Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55A7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 10:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18AC86496;
	Tue, 31 Oct 2023 11:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YR6+04Zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CD587B14; Tue, 31 Oct 2023 11:51:26 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375E2875E1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 11:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ksodcc1hCH4mShSQBNc31fmY4AwSrqTgk9lqkR5LwDtyVEYQVez2lxV2nkjXSuKmzTkL5c5XGeOuqgZcBqhC9k6FdJ1NKlBNmp86KTSAaeno7FkSr+cTJvqTWyWJeTLaV2LYFdiPX4LjVFxG4J6n4/bLHPIJyN7Ulecu+gKGX49f+F87yFnL2yC7sXEfUEHWJCOblb62T5DY/kwRDsSrDkiny7wRx9XfWLjwiYVAXNclSOuIBSUkWmA2TCyH1Taun2ySlMeQM4ToCfqUeI0wCKb4+q9hg41ccLBsMp3IziH/kLC4D5Tp+USwKstIhNE2eNhJtkl1U0ch0hvJZGUz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gWZKTscmml5D/uyCj7WuI3K56N50Z2HOCJffH/mdqM=;
 b=B8GpGv0udXb4boZnmiCUmYY3yq4tkypWVzmUqONavx7PLqvHr6rlQkdvDNoB+8FdT44d7rDbquDur5hiCyTteulbTQoDgRfTyOiPV8ctM7xqIGRFqQSgQH/2F7Dbv1+415fzwrGRYKnqAtNmBxGdvfBhYkTyDH22atviKQdrYBuQo/ONFzjEuclOSEdIFOCTZduMmZ/KPjJ8Sa6uQrLLgnht6mU49xAkvLMHaMDdqWfktg+W2g3QXVBqt/TnH+QDCfa8hXmJfGs6Qg18GBwyKn3ZL1Wn08zg5hUc+6qWCS5nvUf7i0dURTWa2XLyuy8RYNjEC5ggFtL1hkVzbHheeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gWZKTscmml5D/uyCj7WuI3K56N50Z2HOCJffH/mdqM=;
 b=YR6+04ZjqSjdpnTVFpQw3yMathThcaBNMauMFekunnnknpGCLZhTI9MwPtaJE0YcF6iQEVuMz9LDmPlhhr0+fP1SqtB9U86tQewIzeVTk9w45V67qSMA9f1nkSOUQWMrKv/9VTEVp2C447nyJsjHUwBYTHo6E1VCI06aJJrseJg=
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 10:51:15 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8d) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18 via Frontend
 Transport; Tue, 31 Oct 2023 10:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 10:51:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 05:51:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [RESEND PATCH v2] xilinx: versal: Setup 30MHz as default spi frequency
Date: Tue, 31 Oct 2023 11:50:54 +0100
Message-ID: <c1d6ebd659f3002649b1200c926f8b9ed3132085.1698749448.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ISQFyUTcsBLjhafbpVytfUp3Fk21iIjmTk2IFXwE+oo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSHO5wP2uN9LnKpy806lCnjWM5779r6P/a1h0OXbHl2p
 3r1ig32HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAin0wYZrOEG07oCEif+9rY
 zbHB415+j52UJ8OCluJJOl2/xB6UzT9V/0ZtsfrGaLdiAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 035b1cef-070d-4746-17e4-08dbd9ff4cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhwtxvEApa3Var8yXM4zXxqBWYx5UHzKaWllzE5G+h0KLkCScQPFtEZ4K+reGMF49cxPo3z47IGVm30ciApoK1gmIG38DVUhBaEsRL52UYV6vnDxve7wFhZ2DMGcORmuu/LCjrVQS3jcfD6urmUcPRk4R4XDYXHd3ssxokJvX9BGs6l/LFjgoaasI2oIR5bDJrrflHSUga9aJ9kg/sUGaKLrZsD4LpzVtOGJNUtyTIBq6uWtoOdd5nffyj4CH+Cz/A1yd0K09mB2kR9JTccOYMb57LPYcCPH4tNNAHGEhlaXn1CFwqaDQm1kQEuRX5C8U65QyRmejUh6DsMbnHcaiQ3aRaeBwqH69X1vJGlANt/3jczTejbYzjAtLn03TIXgzR+ZPF9KBuGqV9CKlI1hLGS0irA7yEPAuUlV0vmXU7TEemfODrTR8p9cpFyCdB3vn4/vkiyBLIq+Z8EwrS9DBopB7RxGXF2vN/1CTWdUfRlvWJzEpASYbCUkc4QUVnhvbYdlSGlIRloCEWLnQSo5c23YJBB6nwGO2GAf7AbzqftjJlXkff0Jolc5bisq9KKluEaZk827vx2T6IS8rP1wn50p0DK2D6yfflo26JPkN/4iWZYa7rEssxOvuHmcSyui5bhne/qmSm3t0T0F5vrRhNK7wA9Y+eA+VxGg74Bzu9jZjs9kjLOaPCt5BfRRffDby4/r4iVghaal/TC9Tm6bq0LqUs6fzvejjxCzIPXCxSh8TzfHYxgdy+F1tRwAFJCE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(16526019)(2616005)(47076005)(356005)(81166007)(36860700001)(336012)(110136005)(70206006)(70586007)(426003)(316002)(5660300002)(8936002)(8676002)(44832011)(6666004)(966005)(26005)(41300700001)(4744005)(478600001)(36756003)(86362001)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 10:51:13.0884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035b1cef-070d-4746-17e4-08dbd9ff4cd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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

Align default SPI configuration with ZynqMP/Versal NET.
There is no reason to run on lower frequencies.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- sync Kconfig location

v2 didn't land in lore.kernel.org but it is present here
https://lists.denx.de/pipermail/u-boot/2023-October/535418.html
that's why resend it to be able to have link to lore.

---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index be86d446cf46..276ec2526ba2 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_VERSAL=y
 CONFIG_TEXT_BASE=0x8000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
 CONFIG_NR_DRAM_BANKS=36
+CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-versal-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.36.1

