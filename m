Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24A7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A808789A;
	Mon,  4 Dec 2023 09:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4sV5xK9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36D387904; Mon,  4 Dec 2023 09:53:07 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB558779B
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrpRXYtzIEOdGcqkTb0o1uOwBl8nUIUXiOQpL9tg4NxDPkG6/pGzFlS1lS0JpgmobdHRDpPeQjRIPr1FHK3v7DIgjl+KEGfXe5A6wHnyMS1jYXDR3RqcS+Cl2B+Q+cVwThzFzF87GDUUvLCG2G3A6S3rgvy42KF/ugZA54GTjj/78l1HsVVarvQJjlUY164fqmvS3fJBW4QfF+HYJuFdLe1qGuxHLoCzw6KlE2Ma6LJsLM6B1iHwK5BDA/EGUYqYLCqhuVRRswStp4nItuHKlQWcGDQh3+mJ3sfUqIbmpEacekHJPup27wVwPJ2b0WxZcBIAFa0IezmY+t9xLEjVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P30187VWQyTNqyXIYiQz1WgVIJzm0uwQSbgAAI4ugHU=;
 b=U5fA1U2mYtDkfXhjD6VHnpDNc+lgg/bfRl6TKmHRq2GXJBc79viCR8UBzudZOH7lqbhV1cqYUNjq+nUxzK/4kKdM3UEzFRsxO0+6I1sMb8J5F3BOYSktXay9tQQ63Al6v1ImOSXtTmBuAqda0ghCoEKA+TlI/OCHJXy8xE3dunFVN6Mk9tjmqS1E2JSnfm5qzTkgyKWT/MzUiRem6IEOsQaYhaHm2B0kOhlj8+425ebbJyTEbh0ubED/lIg5GOMR6O+jN/F/kZYxnjMRdeQvpRatrCdj9txwctL+ownJez2IqiS8VXGf7f3EY25VNCJzYgh8tPMzjpkgXMcuFuc6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P30187VWQyTNqyXIYiQz1WgVIJzm0uwQSbgAAI4ugHU=;
 b=4sV5xK9LrZn+ECbS5RBgDRR6F1nYR7lBoW2mA3pURrLQt/KWnOEsGzM4JYB6J8OQXthXdBwHMdgZutLBLB/L1phDDHSgQRYuk9SFAAQLKa9JtavBecNFWE/BxHka9E7CtzeQqU+hqO+TcmUNfCHF7kcIfYj4+Rc381OsNUpfS30=
Received: from CYZPR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:8a::27)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 08:53:02 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::fe) by CYZPR10CA0015.outlook.office365.com
 (2603:10b6:930:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 08:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 08:53:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 02:53:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 4 Dec
 2023 00:53:00 -0800
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 4 Dec 2023 02:52:59 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
Subject: [PATCH v2] mtd: spi-nor: Add IS25LP02G flash support
Date: Mon, 4 Dec 2023 14:22:47 +0530
Message-ID: <20231204085247.9772-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: f546f79b-4b9c-43a7-67bd-08dbf4a66c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWT8i0BCsSKuVGCIArSINCT19jwgLMzM2MMwBQnkGztlcdERUCO6hAkAzhlV7pjVeejzVpZjqqQDSypVHPuwngetihhMzKQ3znYVUfeDGCaUaTeIybjZ4lnPalrBLRv5EIffnaW2mWgsXqFT4T801zIaxivyTc39gyZsrOLQZ2fpcRkXYbO6ChpQogCzfEpcgCD30GuRm0vqT1/aZhUeimNCWtvM/Dt8geDFeivC3b6rUpZSivMxXdQlkrrEVwUg/rJeU9v4MnwHWETJzs8W0UOEwUullbDpnb2baZ+4R0kMyD/hk9d000E5TArjrESD1Z7seiITtQW2HEK/f/E8RlSjC9f219HvD2LQLDClQu/Yj6NvmAnurZFHbpGYQ2MXDtWxSHeZpYmO4ith3dheLSs6L7ROrIQyxuiA+zMOc7sVYhLrL4MeGWA9eAcxBUhWxOL11RzQWN+R826Vqs6wV4e7bJt6yjf5iUSilrxdrmUVz+U9LaFF+7874W7hKr/R29K8CD/XfotT5fLV4C5PjiN5dYymqDRc/YUQrXa/JOdfFTpz2CkVdk6SzJT1U8CtmNTKS18kSdQ7G2WTEWOUDuHefSE9LixbFNpo4CV16IyaXcZMocnGDeBN2BYsLcn0USHdTq5daWDh3VGbgM7CnES9hXvXKtDYcTb5TecMaqQieGgaymtEzq0Bgg62wwRY5g7t685sGK2XSOMWABvkSyYFX4/01TAOSgXr0eEOH62iTR6HmYKcaD4Y9vM/0nRhbdcIylL5VqiOt2vCryu4ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(1076003)(2616005)(4326008)(8936002)(8676002)(47076005)(40480700001)(356005)(81166007)(36860700001)(336012)(426003)(82740400003)(26005)(478600001)(40460700003)(6666004)(54906003)(70206006)(70586007)(316002)(6916009)(2906002)(41300700001)(36756003)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 08:53:01.8455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f546f79b-4b9c-43a7-67bd-08dbf4a66c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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

Add support for ISSI 256MB flash IS25LP02G. This part supports 4byte
opcodes. It also supports dual and quad read.

Signed-off-by: Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Fixed the name to Sreekanth Sunnam.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3cb132dcff..9a73198227 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -217,6 +217,8 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("is25lp02g",  0x9d6022, 0, 64 * 1024, 4096,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp008", 0x9d7014, 0, 64 * 1024,  16, SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp016", 0x9d7015, 0, 64 * 1024,  32, SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp032",  0x9d7016, 0, 64 * 1024,  64,
-- 
2.17.1

