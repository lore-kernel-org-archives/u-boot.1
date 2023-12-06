Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12499C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792B4876E2;
	Wed,  6 Dec 2023 10:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rrh9o6py";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E758871D7; Wed,  6 Dec 2023 10:32:26 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AE2876F4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6GA2mUmiH9acny2ilpLRR9nt2F7+9FJcmbspgPMiimUpYNRVyfti0L8b2bSsTlHenR/0YcLNwjULVS9jyBrKd2E3YbKgbPk7AGmjahZlxEVIY59e0Igmrs+hkElsnX4xuoeWsUsnfoffU3mQ3JFoi3u9EVAxhKNPHenxOTz5ziP8HAsE7U6EJYeuq2ldRHCbF69VR5+4f/BzCMfcSt+ppq0MpeMDK04+uyIfCJwvQDZ6qVvTkMK916V83X+EJqH2VdMl+o4FdG+uFri1dnGqj+2Casnk5N9kJphPm6otdWcOWheVKVFB3sG9IC87HlRAcMN8zkO5ykj/AUmSnDKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdxayJW/Q7ePaUdtYoRRLuMsmtr5yDtixj+hr7zWiI8=;
 b=M9e8tX3abSn3ems2YiCCDs/YHQJNOKkHyb5NTYsxnAtWTVtRZce5Iw+6iw/VzFxQf9T0BHWoExE58nTSg6uNGTZTeB9423poQd1tYaCEG7tD+uyskT/TZjZ0asbDdzn2DjwO8A55iKzGidtubQS1Lbs+RtvmFa8JJDRuBJeDnhOnlyKxzHi+TeqnMNSjzdSXDtBKMaGttc/UFvvIhz7jK6/jOv5yA1tqSxCLPE6q0niwOrrYxqig5hM8bsj/LONwcij8kBsAwtaBhxJPeictLYpLXJ4X/edvRhPs/Jup6Hmqjkdy4CA4jXjHLZv8VgHDxOsKW/JBee4vTTljiSue5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdxayJW/Q7ePaUdtYoRRLuMsmtr5yDtixj+hr7zWiI8=;
 b=Rrh9o6pyKRHbij7Bl3isBpWOwnwjceIfpoRfmIi50u1zTdQL3lwNM772S5dt/s80fGFu32hdxt05DqOPmFApJzoWn0hV9bYjhwfCvk8DXx7GQPidMm/0fkdvKSeg4cDqYxAQW5DjmnuOdD1LklacpUZeVUT7SgAJfSjJErPtK8Q=
Received: from MN2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:236::11)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:32:21 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::a9) by MN2PR05CA0042.outlook.office365.com
 (2603:10b6:208:236::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:20 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:17 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 09/30] mtd: spi-nor-ids: Add support for W25Q02NW
Date: Wed, 6 Dec 2023 15:01:20 +0530
Message-ID: <1d090458a47c8651b7051ed7bfe637111fee58cf.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f5fae7-c7f3-4ec7-77b3-08dbf63e3f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73WuK4tV47WMz/DNuQNxlrQYQ0tiuJtASr/HjUl9EHyH05MN0ViAcItiqtTv5rTAfA2PcguUUXKTutoukLq7UfJOmTyoh8o1QrRAZxXZyb0vZ6Tl3b57ve+y3RqBmXTxKLcZ3v/CIGZougShp0Xf3nUdzEcV9Ip1VgvJHyZ5IfLnLDjTg/IfEzEMJjVV6qbBed4slIrYz90Say+5xQwYaSWR1X2DXUbr/9k6eHCYFQPuPf6KONC6bqCsdWMJ/BWTDBkxJ5ZGuSjSaZM9uvpuWNmsATkK8LFMJ5yrysM7SJYhxyPODBPRdv5oPng5ll9uCmq4RHf2u6y8tpXv8v0GGuNKoiTszOh8KKxj+0sMRD5WAeyVIQMeKyiXxeY5vyqav5NAuWQAUtJdcws5PiIsmmtFKOJWUA41T0j9ZlpiCLxQPu3EWMVC0HYvQXmzll6xyP+WBn2ouquaINeNMI353tOvM8/POFKm4lzAxI7iiWDFXKJ5dnwrsZsvFTYA7CEx9UJ2E1c9Ye51dfcvcOWWrs5z4JknPRwKR0bzv/kIErk1Xx7I+TstU1CEVY1z0zacAH9Nw+SMAf0lQm4h8SurBSYdtQ9rB+v1M1jzDsc3hehyf3BUhuTlXDTNkTf7nnfW/T1YUjtbNIJr9p9KyL/6r3uqs/tGdJrieE1W4zodURxNyZkqGgOpq48YDM33z+YoTsjbtEExADoB+798F8wjsT4nYrJjTccxrdPzpyxpQC7Lw/lzRdHit3m1jpVK/uywyEw9woa9/8FTBdc4wTDYyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(2616005)(316002)(40460700003)(426003)(83380400001)(336012)(6916009)(26005)(70586007)(70206006)(54906003)(478600001)(6666004)(36860700001)(5660300002)(40480700001)(82740400003)(47076005)(2906002)(356005)(81166007)(4326008)(86362001)(41300700001)(36756003)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:21.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f5fae7-c7f3-4ec7-77b3-08dbf63e3f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

From: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>

Add support for Winbond 256MB flash W25Q02NW which supports 4byte
opcodes and also dual and quad read.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0dbd385265..51e8cce407 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -517,6 +517,12 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		INFO("w25q02nw", 0xef8022, 0, 64 * 1024, 4096,
+		     SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4B_OPCODES |
+			SPI_NOR_MULTI_DIE)
+	},
 	{ INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K) },
 	{ INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q16cl", 0xef4015, 0, 64 * 1024,  32, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.27.0

