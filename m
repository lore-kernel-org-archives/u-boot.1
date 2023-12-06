Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76459C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16318644E;
	Wed,  6 Dec 2023 06:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHlsqvj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDAF5875F5; Wed,  6 Dec 2023 06:31:52 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7DA87494
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+nmyVKkWaY4c4AFS/TZ8KR+KwNIftrNjRj5vIJTyJM/fqaN9BbMRrmsyvfg9moB0OWMY3VoDis8WTzEARo8D09MpWVmUQFFZPjYn9wSeA+zf3qIBhMIFEL9TxL6HZkasuRLb0+K3nOXYQ9vGf/b6hSWG71oz2lsFeQhKxC68/FD8UxPahzjKqHUhoOoiPioGNNureD8Hh3+txtiYuD3p03y6IjL0WALhGQY2As7QkrWoK6LF+EF7gFXK4l3ZxQf81KMKfvDrh/1OubtpXgHN7mf3hMaJMo8wFgOTDtzyWK6vtkkq7zpwrezO0zoqEyX3qB2+9Es4sx4fEWh45tLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3EQGPJlUUXN1TmTgPut+mR6jFDIQNHbaVZtkjbqmqw=;
 b=ijqbwPXtO14xJS2QnGnclHsJQWYLW58L3YP/em/raptX7BsXVeZdVkB42Q3Ch8qz1GV1sJNnvxAgfZ4CQht/AJmEMOe1oLo/SG3zIhhy54EDGIjHtw74MemNaqIf5hzjmbSArn5uAeo6v4q0/oKz2e3lnbwsEqWs/QfnMpdfDbCdMa3Z9cnzy4IgtP8wlGoRzNOX9RnQYX/DlOksHvLgsEXlVIbvKoAnFhn1MP8C4kwcqPYNc+x24SMXOyCBrAptxMvUWfpzMcltmklZIUNUlx3em/B1RguXX5YLGUzS3Fa5AcGCqc2T/HWZFKuB2cpImCealbtJGhfYvIB7MfFA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3EQGPJlUUXN1TmTgPut+mR6jFDIQNHbaVZtkjbqmqw=;
 b=tHlsqvj5nU33tjeUiYjv/Fkmv4QDoVTo0sPnTuhP436ZPC6qtL35bqwamT3maQeOluNSTxabBM3404lZavrm+hnCBCDhRUPD0S5/Vtjnmv8jmkmsUsbbMoAQHzCo28ECFbCNlNqgNLZB0PRp0KS9OP8dTK35ucA1gE/9ewzG5uM=
Received: from CYZPR05CA0033.namprd05.prod.outlook.com (2603:10b6:930:a3::22)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:31:47 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::f3) by CYZPR05CA0033.outlook.office365.com
 (2603:10b6:930:a3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 05:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:31:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:31:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 21:31:44 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:31:42 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH 03/30] arm64: versal: Enable defconfig for Micron octal flashes
Date: Wed, 6 Dec 2023 11:01:35 +0530
Message-ID: <20231206053135.3744877-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 9807943d-850f-4404-0667-08dbf61ca3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCIKfKNp7KRxj3fOVkMtWvSxWCl62CJoLc8iK7uxVbHr3f2qghyBcb4n7NeYjcRl9eA+SmZHMyU+Hk+ixkuOUV2mAQzi0EEHl2ojYrukDXMLwfB27Bw3OKss6BLeOgIzTps7J9Ecb8yEEggoZG7/obJkDw9PSjkyH9ImlZTIITdUffc/hqj3UR7q5MNa2//dmBbXEdHuCqfgwfdZ8Ph5CEjvPR6SkHs30UCwQl01cW1JYke6dlhreNL6otOSMoueUxZEvFhfFsQRZWGwbjLR32m7Ttk5ptcuIvhwTgvwvR4klxlXvYpp2EGet0atkLlOjfoHxdTtJZMr0lN/rG8bBIpkVbQNdwf7gdH6zDZPfOY1T+Sg5Ctnq0w/YQo99HNR2vlwK2z3uXocOnNFdLCwFqWVvb6le/Y1/VxtHUW2dOkEcVxJ4pp2DMALevhJl3CcNZYe+1K93b1dVQS/TYBq9sgyoBfI0mvAqeFV/KhpWPvVJ4NzQMeApXc9bt45ARBqSdu6MrtZ+153hjmN0SN0KZH95LULovshxw4gpKVMjaAasKeupQ4P/rODfUZQ8ptOB6aH6/vj6p4RjjxOkaqbm4VzvEut2F//fczuNTeZs3mbDZkMIzIzWnnz8/etfFrXWCRmmLN9gfkyO0iZ7upc1LgWcGsJlH6/WUHxlwRJ4omSj+qywT+EotfQTT6Kl/ZHmGEQrEdS83OCtOQ9rMLGPEDfUM1tc2ZEeVlIrH/1fqeG4UNyE4J2hfF6Uk6ugalWjnW9shj4rZ4GU4AYpkzUxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(6666004)(40480700001)(478600001)(54906003)(356005)(70586007)(70206006)(81166007)(316002)(26005)(107886003)(2616005)(1076003)(47076005)(83380400001)(4326008)(8676002)(8936002)(6916009)(426003)(336012)(82740400003)(5660300002)(40460700003)(4744005)(2906002)(41300700001)(103116003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:31:46.9144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9807943d-850f-4404-0667-08dbf61ca3c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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

The Micron MT35 series octal flashes can be activated
through the configuration option CONFIG_SPI_FLASH_MT35XU.
To ensure their detection, enable this option in the
default defconfig for octal flashes.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 6a2c03ccdd..ec7caacca0 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -95,6 +95,7 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
-- 
2.27.0

