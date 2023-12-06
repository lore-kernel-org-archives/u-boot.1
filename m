Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A71BC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2191886EEE;
	Wed,  6 Dec 2023 10:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2K5W1idi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1655E86CF4; Wed,  6 Dec 2023 10:32:40 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F269887771
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpMDHneoa3HvIjXWEntFCbEKzW/6IHyi85ueGcy7bCW4w1QWLY8NVbGq2S+NBI243uoITVTn2snMcVc7K4biDOjvdugzmSRynoA/ElYtp88AcHlNUv8Nficff3ZSID2FgZ1bN5LYRUJQAwO5j1KJujmxuSyPg1km8C3fIJnDvPqUN+q6lqzL6QfMQjslHUti+UVWy1QumS8WLThBG6BsyXqfcPUgnWlvl1XvVTRebcKQzo29KkLM5IVp90s2CC+KwhsOs8TCaa/wciQCKWQDE/8VQJBwDn+O3XppRV/rOnfb7rjn1maZ+zXdQ2a/hvGG2GRq2mwtMVx0UShCZMJJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IRSubOpM741MuPWxoyEHPROr10vNA5mqzQNVj454C0=;
 b=Cu0oC/DZrpDFY23weoLAcFZSQDmpuJmxRpdTIZIRGJjhawikiNpqoJkVb/zsCTXeiIdgmImNfqS8aQJyDComkD+5vHfMpCycGmDop4ZIJyJUjKjrUl0F8KnDGGe37UM4u/Yv45pQkLldDb0yU23gXUdwlzIRK9kOuTtM6+wI1KQK4tkvEQ8zbOfVo1e8hjxP0Um3Ry+MtRrv5z3zPLV5Gp5fdG4U6tqWLLrVaABf0f49fre1ThYX0ks5DNhL1H2Z/4Vg+14Iel+WxI0z8f+bJKpUCON+W9+W8zdGUfN2RzU1XSOo6KyC5NR5SuePITcXo46Y6kPEDQ2GVKSeKLZx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IRSubOpM741MuPWxoyEHPROr10vNA5mqzQNVj454C0=;
 b=2K5W1idi57AmopyjP/KE4c3eeIX2jSd6TZtD/2m/VCUMOt4K4QAWtPxWEx+doc4WnC+gOr4SBeY2vty7sUMfcgDy5/jWG+O5WJFIsm2vBjmWVKw+QSLQjuCZr3YL3tvHrx3nfNm42yqbVqjpYLdpg+bjlTrwpeaD+nnW65aocPM=
Received: from CYZPR02CA0012.namprd02.prod.outlook.com (2603:10b6:930:a1::7)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Wed, 6 Dec
 2023 09:32:33 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::bc) by CYZPR02CA0012.outlook.office365.com
 (2603:10b6:930:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:31 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:29 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 13/30] mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only
 if SFDP is enabled
Date: Wed, 6 Dec 2023 15:01:24 +0530
Message-ID: <283fdb83bc6d91c1598d6fb56b21f9651932acd3.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a0b6c0-1437-46a3-feae-08dbf63e4692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9EywoCQYiH5EHi1qF91e6ppJ0+DARQQjy7/F14W0dZm8esGATTqsrBrq72SLhrizkj1A7jy3gbEt8fUT3cw18bW1QeX1JKHjukqE0y+QIskv5iNM/nmmV52TOeXsABxWUkRRsyJKhdmtEJrONOlQ+6sjlpRvGWiU2VyKXQTgKDxorFYRAwiazeF/VQpCJzweelCKIu2HNUv7AlHDpyiWoQ4xOKutr0HLtLv4O6gE1IhucG7ed71/MD7u+j/bYEzErtJTdEO/BiL26cRGBWwELxG0giwbjW4mD11ytlh5vABNFhI2o1ozyr9ilztDyYC+YI3iva/+4yQcE768ahBZn/7kFzRITwneGzXBjypM5bLmwo6P9dW0VWxzAsy/vpv/VeAMexPzGQKrTk8aGQ8UVXiLEJEgapE+KvgVydDQJeWFtGMi8eUIJCTWD1IDE6PTiQQOPMJ9DTTNQx/tn+7rsoIdBczCWbZwPEE+Hg6VlmRbl8EftEx5lpcCTkCw2ZeFvHn1JeiM8REANohHBLKu2daE9Pj5Ah0XcpZd5r5bKPh8+uFoU2KeXGuwRAEeW+2JnS8W89lxHuOSqSEr2V5VftDAGlEW8hDRLImU+7vSh7DH7JBSI4WfWhscDUoj5Un/CBh9ZLbp1548Vc8HmXfVOA6DHzN5hQwLYZlBbRzkufaTfxY3M22UlNlboNHJuuD6g8DtgtEQFCvajDQow7i4Vmmj0mjYaTQiB/BFyrcbjCtaGu7CGIcoz7bLc1pJ+NCucqKeho0yPyVYZJ6jMoJlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(5660300002)(41300700001)(2906002)(54906003)(6916009)(316002)(4326008)(8676002)(8936002)(40480700001)(478600001)(6666004)(336012)(36860700001)(426003)(26005)(83380400001)(2616005)(70206006)(40460700003)(47076005)(70586007)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:33.0813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a0b6c0-1437-46a3-feae-08dbf63e4692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

With 'commit bebdc237507c ("mtd: spi-nor: Parse SFDP SCCR Map")', support
for spi_nor_parse_sccr is added under SFDP. But the flag
SNOR_F_IO_MODE_EN_VOLATILE in spi_nor_octal_dtr_enable is always
checked. Check this flag only if SPI_FLASH_SFDP_SUPPORT enabled.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 43435e79cc..ccda722df5 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4252,8 +4252,9 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor)
 	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
 		return 0;
 
-	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
-		return 0;
+	if (CONFIG_IS_ENABLED(SPI_FLASH_SFDP_SUPPORT))
+		if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
+			return 0;
 
 	ret = nor->octal_dtr_enable(nor);
 	if (ret)
-- 
2.27.0

