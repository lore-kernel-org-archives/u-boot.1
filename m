Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4BAC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6DE87683;
	Wed,  6 Dec 2023 06:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="owcZtfj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E27876D9; Wed,  6 Dec 2023 06:33:43 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430D786D85
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaThB+8Gf4MvzJrBlWsAxDe40nYpeBviRoQiK0h5D7/BfhozW9EJG+u512c93e67irW1k5Q7IUAosVGhdS1INcl5J3LFgjEibzdD+6ajkCxzC1bQcZYf7RjSw7PO2QzD0my9fiopt8l63vuWGEVJM0j5SYFehGFTmedT2cRBdz4JitR5JJ8Pkiro2StKX0PjKAHnzR7gEsF8qcPJgcLjekcAa0bNU69mpMQmP5jzLu1S4zegSmPCyny2zXne7xJxhLndHF9y3pLkBDD6Ihp23TF1kIJZ59fijZpNeRrol0XL/Qr1p4O18gj3ScHUIVbIBGNyjFK4ZXpJUPgBOwovug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaHXknuWWV3/YU/3d/T05xxJzBLgn1cmNRcOP51t3HI=;
 b=VhD3LsHycUUHery1KubYd++uwHAyyAEsf9S41f9smxLxGDL0QVYYqtuUeOZ0ocTxKgWdpoAPiWfLPT/rKNHPFpMVnE98HM5mbYobq0pi+qbLpkZk/eDkOYpWkBRGzzK3nFe5mVgiiyNDJZ044T9C1n+cLbMMNgqdmhvrdLi+cOu8g2+Cwtg1VWTV5KB2XxSdwx+nvlcvlQI9HqmENI4RUpXELaqf/dLIT1+/db71fv+PbtM+QFzn72qYDuq233OpjWknLlb5rcaQtxzR034ugOTVtGT/qPZrih8scXFunzkee/NWbAC0swoE7lPMok9dopwxLxpWAt2uTwu3BAPqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaHXknuWWV3/YU/3d/T05xxJzBLgn1cmNRcOP51t3HI=;
 b=owcZtfj0ryJiqkDnQTCRTnOEWd6Wb4g/MmQkEOlP2D3DKrejI2l6qyUgEKxLLkQqJSLoxqNG0xwWvPF3gzDGYWYcHOERbGK/pUW+KK/zG1gDO2EH9vYS0yBIZJYavvcSrWW7VsMimxiYr++L0nFcTBQFwKOwtB8fF3CXkaAXhZw=
Received: from SA0PR11CA0127.namprd11.prod.outlook.com (2603:10b6:806:131::12)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 6 Dec
 2023 05:33:36 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:131:cafe::db) by SA0PR11CA0127.outlook.office365.com
 (2603:10b6:806:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:33:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:33:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 21:33:33 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:33:31 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 09/30] mtd: spi-nor-ids: Add support for W25Q02NW
Date: Wed, 6 Dec 2023 11:03:19 +0530
Message-ID: <20231206053319.3745698-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: c294ac2e-1980-4361-f9d7-08dbf61ce4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4YF1/UFUnHeOQk08Iv30pVmjqwU0rab5X851oO3rxt//xXoJ1aNMO7Kmo2dYRq4VqArPsuolC7u4t3ovebhcCYNkva824KdbG6OivpfjVhSuU8Fm5AdzrLUgyrk7dZdY2gNGQTTT6DZDmJXib/8niZQqSitg5rjsTEwBPHGMFJwcNCLkZ/Dj+p/GPlFQGwLEcFM2aIBp3pc+NGGm8SkOEsKyuSxOWvCxWyv17ui9h4hIohdVxavw02gYoRHjpA3XDoEd43gXKUpJgd1RAOOYDXspC0GCSHQKACUD6oZST0lrBFcSSEJBJoJ4MZTIaSvvGlQptuF83gvdUm+FxKuCPMBC70T5U0V0cqUsnrwfPZc4jjkBfBuaV6UPNWgD6N97TxvJKa+P4TVHSGCwYF36i3hrfzGc9zsvSlCHjBX0toRjkE1sJhrRgTdzwaDSfPesfBvofM2navCIU0gcD8rGRmATvO/dKu2acmFE+a9k7FKmSmummXnw31MPwTCeku9HANp1TYrwlPFxk+RUm3fPRNwhazwJXg1Zd9CjmdqnS+OMkLy37TpVE7lWbVjRzdvkJZgVxSCfpdslW4556QgsRn2c27VtlfftBcd5H9POeDMjNmMftwuZe/cGoxa+zZOvEK4fdoko0OShZeA3GvNIJWeQA99WvBkv4lpnPkrS5I+dqG0EyGcl/gMDNlLIrFF6Hd1Uq9ZlUgv14GecbpVxW2NU7U6LHIcI1ykN5fO2DC2gTY6f7Ddgovnn584bnZ5XPfxIzOdEYtI/rC3RJTflg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(86362001)(356005)(82740400003)(36860700001)(103116003)(36756003)(81166007)(40460700003)(478600001)(6666004)(316002)(8936002)(5660300002)(4326008)(8676002)(70206006)(70586007)(41300700001)(54906003)(6916009)(2906002)(40480700001)(47076005)(26005)(83380400001)(336012)(2616005)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:33:35.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c294ac2e-1980-4361-f9d7-08dbf61ce4b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
index cb39c99fa8..7876874f97 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -519,6 +519,12 @@ const struct flash_info spi_nor_ids[] = {
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

