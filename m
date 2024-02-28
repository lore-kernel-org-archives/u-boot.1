Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70480C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 16:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D345E8807D;
	Wed, 28 Feb 2024 17:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EDxH0m7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7071879E8; Wed, 28 Feb 2024 17:24:33 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7252B879E8
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 17:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvvv7ckua3Pl3UDBkAeQ2AyO9paJopcIF8EWwoxx3DB/YJuLgniPMWbyaThacukZQ606r7EGshAZCWHZzKkNplLAYLJd7XaDnn3SAo4dt416Usf7w8p/UxwqXnPLngsdZhHpLZYSmWN7c7w160Gr4QiFB1VrKfNCZ+KHl5XqHYtC0CVZZJJTefx4bCdfjmwqEEjjRjJeUpBmNhBkohgkHh2qXZf4oPPFjw+4j7kDjwN1fcJHZaQeovHI4BdKxaJdgHBs+7vCtZ5g/I/5pbD8jcVo7Hv6BrbDcdPmgCUHWLM22wEkO24jDpSgbYYR0qkL4Uaw4sVcgmC6Ezy8np4wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak7VSBoE7z5sndN2lGUch+XPE6x+uKve3XZfQcYcuCY=;
 b=icyEUnGq7GDKQj3dc8nbshmJhLGZXecK0ZpRc1LFZ6A4igO7PTuy7RQXCBPQYjFg/g+kaUkH0UtunfQEoU3ybHM2WGnAsd4ar+6EklvrrGz40z3eFNRMf1RZe0Hgj1mc26vPN86Ca6HNQvMqLZKDMDKVy0cb2WzYi/7d5/sEOd5EbCr4d2VH6cF0uQ/hvZAjl69USZOoCuxHCwRC0BUIGdBp/C+5tTs3qKsi6FWSekoiCmQLCQdj6GbHKChLW9+q3ef6NYwI/gbgddeh2q8GLL1l1ROCH6GoaCPVqotDXUpi7JKcQl0F79EKepAzxzhEF4QoYXofGrUeFDI32R7Z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak7VSBoE7z5sndN2lGUch+XPE6x+uKve3XZfQcYcuCY=;
 b=EDxH0m7W7z/KR8RTDX/4eiESWe2AvMo5aIDQpoTlbPTHjWoePoVpTg2UD5iCan89r9Pz/8Cs6hqJqFW708Hj4zNaArZ3OvUY1vJ8Yjyc455j0zpJV8ZDlbDTyn+hgwoinplNnAed8g+dcPGWqVragr9z3MxVakoy1CMnaG78mq8=
Received: from SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Wed, 28 Feb
 2024 16:24:25 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::d4) by SN7PR04CA0014.outlook.office365.com
 (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 16:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 16:24:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 10:24:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 10:24:24 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 28 Feb 2024 10:24:22 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <michal.simek@amd.com>,
 <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH] mtd: spi-nor: ids: Enable Octal read for IS25LX512M flash
Date: Wed, 28 Feb 2024 21:54:15 +0530
Message-ID: <20240228162415.1658361-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: c1221d03-8f73-452a-17b4-08dc3879baa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI8RI9KDW31IgaaJ/ntbuKHiPjoS9NpyNkfRqoWOoJ2q6bahmhhTHcOC6+zf5hyqpPxxeeKX5o2i2wyHPNIFaNeTIBKCGnO9YtkpMQ/FeF8/tnCvHz6Nrdj0cMdSy5tWTCNElKv0X+DegYZ1dU6qbJhNlwI/O83KtIfd4Gbq6xSzdXOw9flOMhYQOlKIy2hBeWOLE7upQh2bLbt+pikWp0JBKItT8ClEjs2xFGzsSGwo9xgJTxhYPMi6DyCqGLx/BZyMe+13QwyVoqnNIFwYrqUFOyi9+td1MiUrJFMySoqSH9A9d26pb6pZbUETUHFYd0D0p9y0JJvzKPfKTPUtAC9rjdAGhbCnw6v52YDvKwev1blIDBXY1+1xAw3cPA4dskgV+VaXk4i+UY1ep6l5IdF44PIqZbK5llN+NdA/ob9WQcwpBYRmJNe7CTLYySMErooVkyzEQokbn+3BGXwtXaDzA6wDvWQ32qEq0svSaqHtWqcfMCxz6yM+rbNzD8s67VNfFxgKFen9UyLJJcWNzBVnBGDYmipP/FsrKzemoB+P/zKrDu2BxBpjWaXTz91PI4sLPTpMDVspYKE1mT8YvnOXUENBALcM2QrwRehFi6G5Bk0dsxA6YYn3Cv2Fh/v9ylzjqTxMIizQTqjet4q7a44fPBfqmtpXZSQOoMfSCUmfQFGGw78WvyBBDxZ+tvZFxz4qV5BiTALqX6fUADxw+rruCGcE2VK0ngm1ts/HMBnMB69b0rRR7qOnCq6VT6q8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:24:25.2526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1221d03-8f73-452a-17b4-08dc3879baa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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

The addition of the "SPI_NOR_OCTAL_READ" flag enables the use of 7Ch 
4-byte octal output fast read command for IS25LX512M flash.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..8786b6f862 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -241,7 +241,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
 			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
 #endif
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
-- 
2.37.6

