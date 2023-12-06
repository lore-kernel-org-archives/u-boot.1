Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B7C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B32876F4;
	Wed,  6 Dec 2023 10:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVe4CcaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD928774E; Wed,  6 Dec 2023 10:32:36 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815E7871D7
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhlRCgE7qqEtvTsFcXpFajEHxlPEaNetot4fwvEQIZ16ejX0pavPXsjy5HUGPHBTruesjuJaRVaHEnqc1afcZOeAu5EOuV8KMcknUe4QtDtGMNYCntRrRjRjWyGNqjhlWWeR/LNTzKF6M3Tmk/pO7zgsjTWbEkdp77003PVnSNmnCOkLMlWny4YECzznYSS0VLqLv2blJpqy3urtTf88ihHa5Kg82STiHEGZ0xb4okd/agMipR7UG9ymz7DrDJmHD5rmxnmW7cxxVzMJaSE4wE+ydlOWeUK4SXHCXCwmAeFvN7vCc+vVZKzjI5z3Rzdf55VmtrjzPS3zZPrIu13uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37KMg7rdKxOezDj5+ToXT+phTsTTCsUSc6zqKwz/H04=;
 b=OyWuk7dkEcluvWoFnW0GiNtCwMRGn/RCrrsmtd7G3iV7Jx2XaS3gmIPyoNQwhJ+r/5f4xJWYmHmAZbtvDKOvWIDE2NUkHhW/LHDQerTwFsqqcsAP5EIekT5JpO5jsIrHKMunIWNfF0R0JmdWK5vb95PD0EPSe6Tw7ZuwLAnx3RWVLiJDhRu9meI0lqoJPdS5y9zluC4E9/1V3oOTuzAPjWfy7P+qzdbOBpgasl3tkxNQsokvwX8M7IZMbDpiEOJyNNDW6PQmTG45vgCYVbnz6pN52odMDwNBUQS36Io1Sx3Bms9oVVEpqr+78aQyGSHpK3FLDrEWGGmOcucOteKrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37KMg7rdKxOezDj5+ToXT+phTsTTCsUSc6zqKwz/H04=;
 b=UVe4CcaCVsbwAZZjs2ohO/+1EIXlFAc+yooq1yMUwRP64Y1gyPU5ZgZGgPFDU/wMRpa5f7DtRNYGQZ+lhYdwF7qyxWIPt9Q4sLr172SB4E6Wa9cGppO0WuV91rL/sjKBhteCgw5Hp3gpGFfAiabyi8urE3TyuqHiu3y+piWH/LE=
Received: from DM6PR10CA0002.namprd10.prod.outlook.com (2603:10b6:5:60::15) by
 DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.37; Wed, 6 Dec 2023 09:32:31 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::15) by DM6PR10CA0002.outlook.office365.com
 (2603:10b6:5:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:29 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:27 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH v2 12/30] mtd: spi-nor: Update erase operation function
Date: Wed, 6 Dec 2023 15:01:23 +0530
Message-ID: <3668c374b4c13124ef4bf697aeab62159a1ba9df.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8259c06c-8dcb-41ca-63eb-08dbf63e44b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+AumDPgKtKyJf+6raRkl9MmHpToaRT6KUp65Koa9WUpKFPgtMirLXc4O/DFQrt/3rzWCV3hvNsQq1TrogPgqD3iF00zrmLPOtDIYAlYrIvrjQPdmq8poUGEs2P5m/p3VAlFA4lVgUV6jOuAMgVwSVjOj3gnH3pbnFH+4pa4GcyTQxt0Xyr3c2mdBXs2yXmLCw0E8VWHYcxmbhjkp5r4QC0EyVtp3Qp3JbKAKfAWDwRvDjY+TkfkqI0syzG1VDwrbKYcF1iHFAWMP3Xx+sr7QsDVcO2PFmCT1qs3TRM4rczPeAOTkd0nCHOYr/YcgRqE9af0P3yjiJ302DDOu/mI+VOkNsU4l1r4erV/DPDFbberUauH+Fo9ryXcdPt+JDTKCm2Zvn8sIbjYGnP46PwQYUCPUkTYMvy5KXnHwgmd8l/RiyEUAWtKDXMcKT4euylWzo4eQLRPnWSbPab4JemI+2oUrrWen8Ngz9OItZzVVzCzdTkeYaZgg3DnmvKq51hB1IAiQYEgqJkYQA31JyG2Qurw/2yNpNdnJx+Z1p/l7P8ArmpQWD/TVnpuVLI38VCI70WsWWi1KKjjLgvnvx5YmzJQUk3KRz/7IkM/mTzKYMBNZfnDugNMHjQ3Oc1O5qhx1ECnBRkeuFEGubaUiqA0mmKY5HEENciW2dRVo/PCENCZRa/S9am1WXHdT+8Q/PG9sIFW9xdF8SO7ujxFo5k4K3F5hujb/X6HqD3DD0Vr+gzOEz9vW7fclxu6VRVT3AkhqJhim4EZbhXbfoT7n2hqqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(6916009)(70586007)(70206006)(54906003)(66899024)(8676002)(8936002)(4326008)(316002)(478600001)(40460700003)(6666004)(5660300002)(15650500001)(41300700001)(36756003)(2906002)(86362001)(426003)(336012)(26005)(2616005)(107886003)(40480700001)(83380400001)(82740400003)(36860700001)(81166007)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:30.2819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8259c06c-8dcb-41ca-63eb-08dbf63e44b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

If the system is in a dual parallel configuration, it's necessary to
halve the erase size since the erase command operates on two flashes
simultaneously. When dealing with a dual-stacked configuration,
determine whether the erase offset refers to the top or bottom flash,
and subsequently, adjust the flag for the relevant flash.
Consequently, the argument for the spi_nor_erase_sector function has
been modified from addr to offset.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index d790116994..43435e79cc 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1078,7 +1078,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (nor->addr_width == 3) {
 #ifdef CONFIG_SPI_FLASH_BAR
 		/* Update Extended Address Register */
-			ret = write_bar(nor, addr);
+			ret = write_bar(nor, offset);
 			if (ret < 0)
 				goto erase_err;
 #endif
@@ -1092,7 +1092,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
 		} else {
-			ret = spi_nor_erase_sector(nor, addr);
+			ret = spi_nor_erase_sector(nor, offset);
 		}
 		if (ret < 0)
 			goto erase_err;
-- 
2.27.0

