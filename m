Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E587C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7766F876E8;
	Wed,  6 Dec 2023 06:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVsjUdtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD04876E8; Wed,  6 Dec 2023 06:34:28 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1AC876E9
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agtCm49yyjjalzDaUc1eyVVgxaDjfcbSkhpjFTENsmCCq0OuRBM4kLqL0BUiBoFaIbf8GPEQ4O0yRxN59a1PAGfc6N2ulJTTGwR2b4WTEKqNei5Qqo0y3GowfsaGeE9SqvWlM7i1hlF7j2B92OKTsCaOdrftRE8PUGAZB6tDkaRookB6SMVk2ojUF7VYq6h0QVcSMYkeTY7nlfONGLZukBxx+sWVlzIZsQpWfhHek7zxqD8p0v8r2xajLTm5qJM59sPFQhQI+NFVCHQrJvVnibdKpRSsSXZzPttU40/5s9TVxwAM56qWmnydIR/vuv1VFQt4mPigJbbwPc1qJyFPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37KMg7rdKxOezDj5+ToXT+phTsTTCsUSc6zqKwz/H04=;
 b=hrWlqVlYj+EeUayFCyxjcFP7uyzDLOA2k3zp72Y2QKP+DwgEsU+Ysary8I358MzpjISH9e6LsgdHhV6rguiew2rPViXJI5DSdmwXX3oHVe8+b54fxV9FIMfwiHv1hJ1HmaplRxS2Th8C/4HyYlT5BPwI3R1Xyz1emmHi3cy1xpeGg8oAVjkN5iVj6CgS12wSpG1BODuofRRB/1JNEoGgSwGJzhJDox5CbbZMmQE0M4xcLAlF8Ruh1P+hXW09b0hJwpGulWll6QjabDqHiBQjn19mQDPWpj3Fka+JH3SnSgPnHqPO9EvbmjYTNijDg4RglBv4gES4+mqX2rsTD3TM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37KMg7rdKxOezDj5+ToXT+phTsTTCsUSc6zqKwz/H04=;
 b=uVsjUdtEa3swYaiD8Qb1qx17ztA7/qiARPLm4DvFcnYtsD/ivClUB22z6JDSG2ra4jKGsuBFzCuf1YF0BQtes8+UKgjH6+gcF8r85Wugsh3cXYynuM0BjBfjAd8VF4ErRmBPk9qKHZzw54OZ9h1jLJvkTal120fSmcyjaJRGz40=
Received: from BLAPR03CA0070.namprd03.prod.outlook.com (2603:10b6:208:329::15)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Wed, 6 Dec
 2023 05:34:12 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::d0) by BLAPR03CA0070.outlook.office365.com
 (2603:10b6:208:329::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:10 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:08 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH 12/30] mtd: spi-nor: Update erase operation function
Date: Wed, 6 Dec 2023 11:03:46 +0530
Message-ID: <20231206053353.3745918-3-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1e46d3-5872-433e-27f4-08dbf61cfa9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4DKt2RsK4lPfngJFu1ntak6MXsjHKslrWjRHIqnubJRxZSzCCAlNpBmE+SVH8/ddNoSG0CWEUvTjxTm3nSZ1Ozlkv3wEOlzaP/9Ni4ev+zl/+Evm1QmiPvFTLzcPOfjfdbPFUi6waa/6uxHjbEezZ5wCwHH5y3m6Adl6VSjyducXZ8UKhWAynU0PMSLcllzGRJrm83bzqnD0mlZ6IB44Uqjv3xbOayEvwqYhT/Z5v1YfGGmwBYpf9E8gNTzDf+bAkxDEqL4y5Vu/cypfdimCP5C4vQWmH0RaWo/TTCottFNcxqo4rGzlSFPaaau3iTdFsKl8PEpMn1wQ4CV9gLo8+36e8XmaRqICZfh9AEhqr3X3myarB7E6TniHcujh7isi0MAKk9a29KLsj4qByeiw7707LHga1PHYzDBtRn/kVp5KHBUr/5qkyeez3XrFod/v2LOIs8wg7n5x1ndUp9V3zC/W0URtnAHkKjNLcjhyoY0V5Cn0L82FGQlvdcwHDmCbytQ8ySbvVf/Dxu06VxWdlCymjSCGJrR4O/QrvIdOi2/mn7p1qMhDIjTC0FtPMxQ/TPZu6vpvtwrqkwgswu1WF2YwYy8WWHAhC1W/uZBidm6hZBDvcxOz3SBna9terPVzT0k7PXs2FP18kJBrxZquKnRagtWikycBprnDNWhTXxZ5zZ7PGDO3x/1rvWjs6/Gdsa+Po0s0jgsS04Vf31Gd3CotQ79WqkI/iAu/+ImbbwJt6rLoZ/2W6CdeybsBVZhBMvlRWGje7ubSB4nfcCW6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(66899024)(107886003)(1076003)(2616005)(26005)(83380400001)(82740400003)(336012)(426003)(6916009)(316002)(54906003)(4326008)(8936002)(8676002)(478600001)(6666004)(70586007)(40480700001)(70206006)(36860700001)(356005)(81166007)(47076005)(36756003)(41300700001)(2906002)(15650500001)(86362001)(103116003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:12.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1e46d3-5872-433e-27f4-08dbf61cfa9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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

