Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D40C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A22A87896;
	Wed,  6 Dec 2023 10:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="di4P2OmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA9387890; Wed,  6 Dec 2023 10:33:46 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1DA86CF4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYlEikpmiu/XfwJnqcbIUzYGN4ct5PO/9L6mf6OgTqiTd1meGQup4vTFuMp4NcLafN2UDGy9KBgKY2srVJxVznVh9PgyXXVEz/SeBy0d8no7FN9r7RM4Bup1/9NudgAPFzSiMvKMrqhe80AHSd9+Pz0Zuz7VQ+cP0E4G8tkxAinIbjmFevhhTaKwUqo3ol7+9K/ST2tL/GdSf+mhRau1yRkNt/FnU42xPJGEGOsvs8sBA8pexAm4ao2ic8quF+ArDfv7wsMskXpmFME5rDyCsF5+J9ZpYv3QP/d7Tg/6wL5QIq1YFle/Yw5CfuU0e52366BeVkhsVwNa8sEmq7UDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RhWx2Z5GG4Qt/4vk/WG6Rol49RvR0Q+eKE6lqk/WJc=;
 b=CbbqqTi+7FsHWlc3y4fO/vtWlC2Q5mrhX5l3ha9uNdSwLhNR8hCFt7t79JgJAOOZW85z9WiDaj7tBWICWzcPnVkYKkyUC0rL2qAh3bqppT6/mLbSyvtMfg6FnM4T4b/R/yx46G7+Z/9qWzwccrZTs7uLbokASP9PXx3gbYRlD62LiYMg4rZpiwLgrDyOiXnZt4h8ESehiNns2v5kZyi2OKY5W4fLUrnoVtyqVAeO55n2Ob5udgiF88MRCDCYdD/Rg+cIOT72ClxXaMtxOmaZCrawZV2GF0ir7YHnvsdqhbET/Alz9hvY8pNWiiogE8P2BkIGsZLZtZWaEr9EJ3xqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RhWx2Z5GG4Qt/4vk/WG6Rol49RvR0Q+eKE6lqk/WJc=;
 b=di4P2OmD2tbsQC1XzQGyPOqVzlAOnTGtEZVh/wdIaAiXH2NxKE7Ci56ngp1CLsX8GYh7I0c6EKhjyfImebcwguG8xuwDTNZj65VEM4Ifh32vYecLRQYNWozehoRubJrpKwGqeJ4ixBnHPmvLGlmbWzVkCYtHEA1rc7n64iK6AkE=
Received: from DM5PR08CA0046.namprd08.prod.outlook.com (2603:10b6:4:60::35) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:33:40 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::a4) by DM5PR08CA0046.outlook.office365.com
 (2603:10b6:4:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:39 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:37 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH v2 24/30] arm64: versal: Enable soft reset support for xspi
 flashes
Date: Wed, 6 Dec 2023 15:01:35 +0530
Message-ID: <2d016a05ace4d4d09400074a5e4363e57528dee5.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8951de-f932-46fc-1aa9-08dbf63e6e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHVZlxgu5Do56aZpl04WJSgh/jZsoUxk2JmuD4+HLCKOjWIwBH/Oebrxp8Gyuk7CIu2GM1K2DhmV5Hbh9ceMYgHcU9dg5r4rAWZni4MegzpCkhjUCm68HjCIFTC1rmrq7JJsYHMFJAWC5lJsW+4vbZvYUHFm9JeAHl4Mq2F4VbSK/L7bnJswegxpGexkbBXFuw65Jn5icxCGfiFIKdikGqCkNF2PnZEoZ7lOaGGhmEMNbsRohRCUmYDoUV3l9UElHGUHJ9HVYSJoFbygQ6W4P2YM7qhN7JnGo5myWyOqfCKXXIoJegcUy/13sgAq7LzFPAxrbgesnMFIRRNkP808rk/Q8+31y2xxaYfnZ1VJapPO2FQGatNBMkuyQpam6IggWoWTmkNtLk5rlH7ggfFztpsfP3AA3/ud4JC6YrN8CxxSDTDjTXSsYXplaeawMXWMo42lxJ63qy88wdI77OTyxdFpum5AZedQaR3+oc81yH6ic8/Si/c9pDBMSz2Se4y3jFhj+zcxQvuCSOW9G63v3cPNt7zBp+9dwIo8gEMFsUTbzPHpYG3lTHRFO5dQIjwziC8L686dQhg2oR1qnSFZd9MZhBTWvTSY+2Sn8DGqCWtd0VlxEe0/mzx741X0po6spKNYv7TsHqpEpvowKwECZBtJOuDfq8q+XZ5viKYkdGSjjzP8OshYK6fagSPdVVWcTj5YkKyMbpS3Ev1U3Tjn19+ACJRJ+LsKEIgOjPMX9EZtxG3p1KYBswxsVWTOAA26+fk1itcoqJ/lmXDoGaLqRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(478600001)(316002)(54906003)(4326008)(8676002)(6916009)(86362001)(8936002)(70586007)(70206006)(41300700001)(36756003)(5660300002)(2906002)(4744005)(81166007)(47076005)(36860700001)(356005)(26005)(83380400001)(82740400003)(336012)(426003)(40480700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:40.1923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8951de-f932-46fc-1aa9-08dbf63e6e5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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

Activate the xSPI Software Reset support, which will be
utilized to transition from octal DTR mode to legacy
mode during shutdown and boot (if enabled).

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ec7caacca0..ee247b905f 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -95,6 +95,8 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
-- 
2.27.0

