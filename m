Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F9C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F9D87832;
	Wed,  6 Dec 2023 06:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/8vzObV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6178778C; Wed,  6 Dec 2023 06:35:25 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F398779C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfaLiAVs7oubFhdwmWl/Y4/oHgIOBkWNvaU2uF/KZiUTVZ7OYjvxthRpdUcphEmvzIgdCFHfU9NT70hEZNBsC/HlC2YYoxvPVl0ZBpIxZSivMJdxuWwaTN+jbmOpn9JF3Eiu/cqmewVV/J1OMzMFEda7RBx4f7MtPN56DoZOp0XhOKPseQdF+ZJRH/5kbWRiD1ZUG4E8Rd/7tW2B4GnroQxIiSGrEGrbE34ISVkU4ESIP6TSH37+xbu2Vp5zcPMk7UDMUAEc0XA/BBocutoPaiu//QOY0kqaepT4F6hp6zE5L6DpOTQZh/EtrcO1HbiRdqjcmD8ggud9P3DxdYz1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RhWx2Z5GG4Qt/4vk/WG6Rol49RvR0Q+eKE6lqk/WJc=;
 b=QLHgWR8j5XL2bXPLBcOF8sNyZGC1ANeF8opCv+oPWV4KNjlYwiXYMfhk73jSyuyy7pmbZLuJyqGEuBaNxHKpTEL/EdBtb7K+2BhECVBGneYQF9epVT8Nc8GU7XMFPlEhyaKzWnhNEaNAnw7yUwjtEqdlLzrmqZUr8ENTMMWiJz4rzqY5bvRA+VQbT/cDEsXoyHposG9WC//lv0abNTCCrQ4E5xYmS2Psh7Z/VvMXzrt4XpggCdcGcTKvyiR5ugV/kZleyChGRfQzm8293rnGh0Zac3o7MOSZfI6rIKznBObCF0ujPmUFea75RFnNw7PyUaH/6pJpEjG9GVPxwxT1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RhWx2Z5GG4Qt/4vk/WG6Rol49RvR0Q+eKE6lqk/WJc=;
 b=q/8vzObVeOldug83mYdvB6htWUX1NQ6cxuxpTNmBQ7yy7gMS8Z9SDwxZeAgpNne5HtKJ43SINEq05pNmoYRvThEiIdirm1QlleVIOK9dLSN/wGz8+JhYvF6ABP4I/kRZNbnwRYRF4KDlKtCdPZ3zTehMQc009SAkdtetxPgaGYw=
Received: from MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:35:03 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::7b) by MN2PR12CA0008.outlook.office365.com
 (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32 via Frontend
 Transport; Wed, 6 Dec 2023 05:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:35:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:35:03 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:35:01 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH 24/30] arm64: versal: Enable soft reset support for xspi
 flashes
Date: Wed, 6 Dec 2023 11:04:38 +0530
Message-ID: <20231206053443.3746237-5-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cbc025-13e1-440f-88c6-08dbf61d191e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tg6ZH9ZG2aKVVvG+kEjgsUkPSAmUs9j032mNWeRD6kOhspiJ774ZeZWG5+8LilJA6QoXwH7BAUwPofVxYcezmwSHvJBD/LAld+PqSTmQtZgiNJSzv922rGe96Gg2yW3XT6iNOrdWP7O7ltQID5+LptsYNeJjTl+7EB2n7BADZMWyLgq/PiME4gF2ZakXqEU8x0PdXNkBJ59OUqCfVBj5jvcSW4OQnYcIQFmAvnLSn2bgBdEgl0N2tcW7LSwGc9RKHIbv8MgxLFd1Va/O/3OKQVNTF/J5goL2gSNPmT2CH9sACjw6yvH1jtQrmjTWdVQvLkXVCc5u5bmXzLoF9IXadJETHfBh7adkRy9nBOcau9y2+BDPpEfylguUWMfjgSDGakpJlTdNX4q1XZ4IgNIlQjwAOcl+OY8NlbgXlw67CqKwth6huezD4YHWoy2DZ4Jv5bTIhk+Q7n4m6n3vCsHjtZErUR+7TkXYSA3kYYIQ/os6FsixfRsXdDspOVM5AC33aNZf7+UlY6iGvTj/mjfkVsBVXgORc2PgqnIq+MHTSrRBEFcdMwPimBUazVIW3aj59ubX3Vt6j+xbzcgATB3TlvfppqGCrP3zIFKmQ8O9zByc8V1qmCs8W1LNADydEbGFyh4yfny/AzPVdAf72f1f9IQbCAtCQeDKoV2ApXG70fI4rV20e0piRxKsLJCdBkdJjWdNpPaluVLZOlTyx/FaziR8Pu1xhCRlIvWSl37/lcAbNBHJG/dYLiNuifdHch/KEee8RIdhTKILrAzTBt43Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(6666004)(40480700001)(478600001)(54906003)(356005)(70586007)(70206006)(81166007)(316002)(26005)(2616005)(1076003)(47076005)(83380400001)(4326008)(8676002)(8936002)(6916009)(426003)(336012)(82740400003)(5660300002)(40460700003)(4744005)(2906002)(41300700001)(103116003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:35:03.8191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cbc025-13e1-440f-88c6-08dbf61d191e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

