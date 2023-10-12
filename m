Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD19CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 665D086DCE;
	Thu, 12 Oct 2023 15:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EJkPCisL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5DF86E39; Thu, 12 Oct 2023 15:38:05 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0962286CA1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMzdQEtJOV4Y+5+eZNqio5kjUiLPO8JGe+TAvB6Hlw/lbxkGGdmszNgUGDUDo2RcQGx6Fg+z8ufb4YGE6KRKON7Zvs2GB15nxrC07p+U0BrO54/5HjqQzRrlMLgTOSKLlLdogO6RYkvUuOQAmksXfSLxSQBtszzGm9w0XXSVIVpwGh0hS5BcdJBKV3Byb18/WoTVIXjMWoYw7zx5Q49OKHx5f4Y5zBkD+H9Xrqw6UJ47/BtesrAQY+fN9ilAgxi+jdtc8hmIW3T/YnXxLoA9GAOOxhNU3cy4o2iQyClm7NxXXRe0VX7g5zq0U34jjRaEv6AXmoZL00SN4EhcLGz6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcgdmf+XlL96Ebm240IybpfVdVMdHQmgfcenX/TpQ7w=;
 b=KhZfN6+XO9Qf9b3VESCMkHBbExbnLY+eWapx8iweeyrq1aTRVyqY/gshvA3ICL9eVB1/824S2filmRqq8dHotjabyvLk/fX33up/ye75pjlR23KbW6bA43K8fA5aKSAAvKHCAQKydLaUGde4nUAiqdS4G/E6aXDBwyZ6bWWWF3oNI6fBCSR9JXKR2PXeAEr57DP5UbLZmYeIKL0HLTg9bGlNQJnAOKtIFHMpU5pD9zTdQsCHVxhkp652RHsiPvibJet9WEbYLk9vHAI3ent/pXoh3KDJR7qVaXDPuKWyRH8mOGeXY7HTOEWVQEPoGQolKb3EHX1zlkWsUlClscMt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcgdmf+XlL96Ebm240IybpfVdVMdHQmgfcenX/TpQ7w=;
 b=EJkPCisL4rV1N8wTo8mBgEZPClRp3kayvWzKOvz+Ty3gAGCV0juQv818UyIZRg61QCRnTdUTqZVaO9oPwQdfhmn4w0/Hr9pKm0way0/kQJz16HUeJvyT/JoP1/XU4JINk+C1a6MZ0W1hL1FvrcwUw3FvhPIPvh9tRjbxrmDD8wA=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:37:56 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::74) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 13:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:37:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:37:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Disable the lock option for mini qspi
Date: Thu, 12 Oct 2023 15:37:52 +0200
Message-ID: <374d6b3a46d19b7ee171dfe8071676098db93e25.1697117869.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5+6O9kuR3NesbUafEDad5Y8Nqqwk3knn2Mur0A6395o=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1b+s0XwgK9kaZ+80rPr727QfJoJayWQ5llXJPGU7v/
 W+lYM3cEcPCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaSJs8wT43/g9qVh0n7Mve+
 PW6/Is92gUlgPsOMG+rKqt7SxddUL2eHzVZhrlZQ8AMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1dd751-c697-4117-1e98-08dbcb287074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nl4S4WG55XEiIQrCIjd0Uwp6CpT/N/TuVdz+8Uw2RmZlb/qwJr/11PMHJ0nscSxj1b8VrbWSG9SeLtx5OIsg+jchMUniti8Naq061W47ijFvRvFmqpJ9gwAT+QWzoRiYGJw6EozeA7M8LQwtZpQJZj9pRTQK4TW0f/GfgliEJZO7u4AasfkJjVVv2bpwCMaq2JClfD0rQFMfor5Q7SUJ2ZKxFIRtyu2SyEovydonIxRYDwTZY2oaj5r6if41tkoektfAY/j8nq7B3HMWEtQSJYaVAilZ1leN8rir/+wkPl7BqO91QAdjAXQuIp58ejBY4ukhBwuLZP9Es90y3HlwMxthNy0DIsLe6BKnuMzLYu4QH6q/YIRgZz8ufQReS5Aw7MXuv95Ld6H0k7VsoyqkthXhiRBwSVkDKcoXvjlYlzH99cSxveZ8pcIbMUQ9NRro6G3VSINTVnkATfK4CU1BRzZvYHvDgoO1UqpPHF4PcQaYx4oeyKvd9R3Yd8/6ntDhE04TaQAtjMxsenfd61ZU6IZtlVPfCypLO1+927Z37lDqCe6hnOy4ZiU2rPtXkxbdDSkhQWS7WVeIFeY79Lyas7lnrT706atmBUhLV+yh8HFrMk1daIhO5V+CB03rXVQ+CamtgarirT5EuoxIYn1eo5McvdyBKS3mu3h80B5EY5aYc81NwerTAsho4C7UKmxWZVGw/6xdW+61h7WFFi9QIlvQZpSx6zwhG/cDIEyuJa6h2TfEiCz0mCimohQpoODyFSlrSNxd/abvNTES/2zgPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(36860700001)(36756003)(83380400001)(478600001)(47076005)(316002)(966005)(70586007)(70206006)(16526019)(426003)(336012)(2616005)(26005)(110136005)(356005)(41300700001)(81166007)(44832011)(8936002)(8676002)(4326008)(40460700003)(5660300002)(82740400003)(4744005)(2906002)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:37:54.7908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1dd751-c697-4117-1e98-08dbcb287074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

As mini configs are required only for flashing the images, so
disabling the lock config which will save nearly 6KB of memory.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Depends on
https://lore.kernel.org/all/20230928034940.2220-2-venkatesh.abbarapu@amd.com/
---
 configs/xilinx_zynqmp_mini_qspi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index a1adfb9e5d14..4a74ca76a281 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -77,6 +77,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
+# CONFIG_SPI_FLASH_LOCK is not set
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
-- 
2.36.1

