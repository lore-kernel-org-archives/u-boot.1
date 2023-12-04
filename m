Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666D1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 03:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A652F8777F;
	Mon,  4 Dec 2023 04:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5rQe4njj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA3A8779D; Mon,  4 Dec 2023 04:27:54 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7110387708
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 04:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWQ78mtqGtTZ7ZewCsOwArSXl2n6MeoAOZzqDKKa10hh0gyxECjg79j7X0eA0zV62R3kh0NzEYf8f3hOvorHL0s8z1Ezfdc4Os9rDaiQLheJfORhj4bR00C1pp6gOuQIw4XtBOW75BIRe1l9DDJC9eZZJhbsydIV8BAzzz3/lIrndFke580b71TDNFySZZDzxWUnjZTOPdvZmiT3ibjhvOBoO7FcyccIyOjn38ZDN+IUVWapizfPjrCj/3dhM+ICqysWyM6pAD5B1mfjYURwU+THveDZhh2c9NjPLjqnDjsbW4XS4A7H4MXnFKSCQpFFGdAuELAQxsuWjkDrvUI+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps9Nqlw8Mivw/UgRlx2Xs4prveNMU1GzODKazst8WFw=;
 b=Y9S+iNOm3OKy2OWtLib/y5n4CHPeQVMYehIqzH4VRnbjthqqmgbGbcHsUdy3pFTQ47qbIjoAMlzcg7jWTIf9w797TEZiFtVCMJmPm1qvhuUgYYlHBtkXejkH2Ao5SP+xSjclOwe8Ke0gJXMjtdvY1SAuezkhQ9eJmwd0kNfwJucI7tTJm4tt5l75gywTYpGSBzCCvVXttQgUDL4GpSQQvGefwVJ9XuwzvXNzS5OB3waYaE+L2hJbnA/5DLVG32GVv1sv4efAwSYJ76dgGo/c9bEEdbL3+AUnSTcD962xJcIbFTA9vX7YagS+IrvtYvHjW6xQPJBig8pmxrV+2BOimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps9Nqlw8Mivw/UgRlx2Xs4prveNMU1GzODKazst8WFw=;
 b=5rQe4njjgC7Gm7R+pDVH889eTE1EVX7wq0V+emWneN1d0Sl6egkdmGk41b992AwbQhaRmeo/mb7svEuSdG9OtMmtqYeryQIMy4g4QRdc6/1AWYcVIM76bIMeyQMCd8+9cnMRJWPn96fPa2yJjWxPnJcYLFUIEI2qJ0PgMLapwVw=
Received: from MN2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:208:1b4::14)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 03:27:49 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::3e) by MN2PR15CA0001.outlook.office365.com
 (2603:10b6:208:1b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25 via Frontend
 Transport; Mon, 4 Dec 2023 03:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 03:27:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 3 Dec
 2023 21:27:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 3 Dec
 2023 19:27:48 -0800
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Sun, 3 Dec 2023 21:27:47 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 sreekanth sunnam <sreekanth.sunnam@amd.com>
Subject: [PATCH] mtd: spi-nor: Add IS25LP02G flash support
Date: Mon, 4 Dec 2023 08:57:35 +0530
Message-ID: <20231204032735.9786-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: d6048109-a16b-42fa-9fd2-08dbf478fde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKb/S3krxEMaCcGZEmE1C2dqnfO5TtXy79TiTqouSceYZjSB98Ua99lEbZXVA20TufTts8HivQ3kCBzt5KD/lnZrrTl6nF4jpNgp1kQVt1bSq4ov6Tg1sHumX6E075wnjg6P0qRc1dx36Owkw1z9APSlybi2e+5P2tCOxJBDw884yi0KsORvXVIKqHjOEa5aF71tYeQMqjo42RFDIQWopsXkWMQUQy/xL0gEIJfKKr2UOXGW72k+xSoVF7hiyX+Vy5tTko3o1y2fpX/Z3CvOPTqKMC/V9RsfpwiEkB70kf7K/ij6kH71HNJu+v5K89x9n8JLiLJgt8yIa+HmIpEkjSeliO3bTG/l3t2eLd9P/1MwnLiB+uK6GNRBSAXq5gTwZqPAFXmD3b9JnpoBcEe8jnB2FhvfDfXea0dw7Gc1y0rD5s1GskJ9YQ1r7M2zTw3KXZ4agmSKAEy656T2pwac+8jx5FPOwYK8wtBvEA2eXuS7A5/QRBxuzjHyNhAS2SyrXzZdsrgBmPDDMk08FyBj5Z1NDbdV9degSC4obHOgWiXhpM6HemhPzRUNQBBJtzTz44KukojqntW27GBgP6yUy0X4nVfFG/XFYp9/IWJoDsokm/JIWCestnOzZwowYd3jTT1q0/ndwuL/lBh3ZynESkzjrj6BrT0SzSWH8ekUO0CcANiZYQQgl6cGbZAIol+D8W4fOekHg+lyyXBBGeK/qtKmbPdCTkzvjh2yXS5Upj/91Ey7ephV1yl8PuYSsATEWecpIvgjIR9vfoHWsWUqzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(54906003)(6916009)(70586007)(70206006)(4326008)(8676002)(8936002)(316002)(478600001)(40460700003)(6666004)(5660300002)(36756003)(41300700001)(2906002)(86362001)(40480700001)(81166007)(356005)(47076005)(82740400003)(426003)(2616005)(26005)(336012)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 03:27:49.5197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6048109-a16b-42fa-9fd2-08dbf478fde0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

Signed-off-by: sreekanth sunnam <sreekanth.sunnam@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

