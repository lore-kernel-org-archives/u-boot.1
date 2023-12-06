Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7031C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF1E876EA;
	Wed,  6 Dec 2023 06:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3BoCZ2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D1B876F9; Wed,  6 Dec 2023 06:34:30 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CB0876EA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfSgIiQlAL+pQUi08g273tMlklYwpAbatoqxR3flzfDKZwg15CRXgbM8dBFfIadKxfeIyGUItLGN6vaTSkl7Hk376KpY0CNcgpepk6R7z0uJJ72fSINgXBT2Vm0ebC/k8S5KSsRiWFUhn86OFsgI7F6hiJPYf7WZ4K3iaZByfOJkFat0DtHC0Zv9Nlq5x+7X0+DvYdLUYggzwHv6MHTy5p8ziRAzbbesAqk+AWnwY9kLX/dDD7AlrWWQeOkzQUJlYOIKmteVgvA0Q8jO/X4pKt49QP7kEW895fJRcld21fG418KsP2c6BOnPI2bEwrAvt8hQ1uml9/6kT70OlBNTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IRSubOpM741MuPWxoyEHPROr10vNA5mqzQNVj454C0=;
 b=R6z3B+OOkO1yK27TUpCtH8YIv0FbVEscche8Twe3DD4pJTmByM32E7d/MK1w1ajhkDziYNVp850UcTGuaa0xx8hZyVOYF/S/lLMcUdFQm2aThgNJQ8OHeqf94zba+KDo2XUl9IR1qinS80F4mrdThtoRr/EpCTIpTupjSq8aPT0cZaltdOfNXqn62vClFOjopxtaXbkvS8xKuj7F0LA6koN2Kj6B5QEPDma4QwONUto9OW/Wbkv04gYJ0qXbSQkbqcEUN7RMMfTjdDjHJ1uvNPXe4spiWCQeo2g/dXekrQnoDMJbpCgfnSrPDIqY3w38iiV1c3c8dhjpwRLPen1wiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IRSubOpM741MuPWxoyEHPROr10vNA5mqzQNVj454C0=;
 b=L3BoCZ2g7V9QPaG6bUjMY1u8EM5L7+a0BhV1BNo4GH0nOrWpr2o70WSE/+ltHppbdI9AIYp1ZrgG+0lGT++GHXr+R27N8MO3KzUJaHzdFloeFRzQEBbeHjB+OcdbEOFv9XC1A87lMTCVUM0tiAZ4cq+gzVlp8RSH+Rz7lvIZtbQ=
Received: from BLAPR03CA0066.namprd03.prod.outlook.com (2603:10b6:208:329::11)
 by CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:34:16 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::b1) by BLAPR03CA0066.outlook.office365.com
 (2603:10b6:208:329::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:13 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:11 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 13/30] mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if
 SFDP is enabled
Date: Wed, 6 Dec 2023 11:03:47 +0530
Message-ID: <20231206053353.3745918-4-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CO6PR12MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: f37acbf1-93b0-4b38-d825-08dbf61cfc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w23+8eBEudPA59wRFWM7cPPJoGoCKwi432DFnJVErXZEO7gfS2OFD9+14S4zqe01wVvg0hhPOflaQPzlsVx2JSFx0CpCAzMVTUZz4P24V3Z9nuREq3RII8o2v9o7xVMhT9cvfgnTBj0zAlDi1P42aenqWoSuo8JGpc/SRprvZv/Gu1dxu7rFuVt2yCl54DtDyeBIlXGMJUpLRkQiIhoVyD39shUPql49sJwZG18LaHF5+bnLcC4Opy9t93PIDHM5AS8s08kgDIeNlyPRElY7QVlLz3gHKYphBJBufMtZydVF+f08rd99hyJk4ZU7S1p9RRR/YpUbQTAK1PdNV/t00dGmZL34s51g+HgJpP5YXHzK/jno5gjy73qxAKQh54cQ31zsbTQLXLypjXTkfQt87Pu42icY/yePE9EyurvOsLn42Ifd7H5loRHdILWSxqPKTUL9PLURadNPpXV2JfHSpCTW2iqZyVF6/AboN/A3ESfCeiatXdBapAdaHCVK9OgVp8LsDmvCMtMysuZ+x/3ImvU5zFE5eWuSLwNm8iJGNO6SzNzB9OJkfEJ3r4z/p1Ujs7PTipkYqmpCAxS9pMGyW6cp+4jw0dZM5enOS23fZEClmjNJaQHq0CZJOArsek97cbpSFrtSIdFVP2UAdzPvLK25DrFx3gxx50hdXkqDrzU3S6P0qLPe5pADhl/Xi5SQpBLYqf27ye/2QcGiB0aVOV/t9GqZ7adZqKaVsJnL12VcpNO9Zilmw4SoFupzyAhz/Gbvhws3JAbHGPxTBSMbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(86362001)(40460700003)(5660300002)(2906002)(103116003)(2616005)(26005)(1076003)(40480700001)(82740400003)(83380400001)(426003)(6666004)(336012)(478600001)(47076005)(81166007)(356005)(36860700001)(4326008)(8936002)(8676002)(54906003)(70206006)(316002)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:15.5262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37acbf1-93b0-4b38-d825-08dbf61cfc50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412
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

