Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B6BC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1D887683;
	Wed,  6 Dec 2023 06:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1Zp/sC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1302087682; Wed,  6 Dec 2023 06:33:00 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB5987683
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqFkFMJ4PmYzwvc36Zg+uNvYyF9kI0L+vIo2y9HybxJu2zVzwRf+bJB5x714hilvJK2TAja6IL/N8cKxtnVxMLrNPZO9y3ZAyXl/x1rLVy5oMXJyrwSQs2Gk6dO8mlcTvspwIrVDT2gQWB7d+O/Y4+gEVHHU7QTk+mWC+VfiHEhRx38zNT8Kn8KaiBCKFQH5PEI3NsgRE5a/2H4mrVBeXNEBEBsVChQts3Kf7bshXRxaIwNORzYajMqBWdDJrMJ456b3SPPZruImXa0g8O88nO6h8UkNggM5yrzCytd2FFguZUHLvyiyDu1C/GtmojyIUjFQfHgUG4UBh+8dE2kP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqBJRaeByGb+I+hyhX9O54Cs/hVOi01imTQWmnMj5/U=;
 b=BHztlAnKtpTDD4jxC5D5kzu6wBOCy+A3KrEkv92QceUo7fTvLAX7nJODuMBI/MZtuu1zc/aXtLlhx+5449Qk0lzJEPuUMOtEVgS0HcyJn0sDk2j7y5NfhBlROjcvS6zCmEHT2o2LEvUsI6BRc+xmoCc+rfNNZf0y4anJKMLNu9QfzwtcFA7TR51x5aeGh8RMvFk0sgauhBQoCgUzxNE2l4tGKtxx3c30DJc7Ui/+Ahbkq61fyisgCFjpOq/MXBmPUGiV1yS9CxxQa+phIHIn9vXJpuxG/D0mA2EUvhNUQ8GZqwSjielN4grDxfnWRyrqbZji75UZA0/kt1/XNNQqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqBJRaeByGb+I+hyhX9O54Cs/hVOi01imTQWmnMj5/U=;
 b=v1Zp/sC536syV4nxJS3S52GV/B76g6mGfAovHFPuY+B3RyOBvX2EgzkxiauklH/Eg2VHLXbsFnx6D//QGRp9hwOObEmchC9DNki5junGjoanVQda3GS/O8jOHjqzrOK0OoFEBne3yQOC18owR/5HpZf6/VAqESFJS3nvPuvFNBE=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 05:32:55 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::4d) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:32:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:32:53 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:32:51 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>
Subject: [PATCH 07/30] spi: mtd: Use split reads if multi-die flag is set
Date: Wed, 6 Dec 2023 11:02:39 +0530
Message-ID: <20231206053239.3745393-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 6727f9b5-bba7-4453-fc34-08dbf61ccc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4BggcYsJ6RoyBE0WcQ16Lhm00/BodgP4Zh0YsSB6Kjjx1bKp5LLa+xDgQw83+3KV4GYnJCS/6t92WPnolx0sAAp+D0gmqIaQdDfGporgWdhQPOOcSVbAzcbTSjJp6yKo5HkRNt4fT4TzobExhY61gVtAgMnzwlQTdzpo+fSbjR/j1lUp3I1BwAC3BSmj7AzW73BbGCKVSScUF05k/Mq9u+cvbjSidWBHSjGakUGuWKNXYiEdesDc9bUTkBS6cHWJXsdlgssL+wAoZYmjels9/S3uCiYlr1S+nAfVmdqqeLYk74OQ4I/mvDsCHDins00eq3BJ/GTecktpRf3h53XSeBaR4ldHl+DwxnxHKqiTASnaop4yrfXnhfFjsvXEah1JaSTXU6/IzfKLXy5y3mTybxgt8ZMT7Rz+hlpL/5ypZSvoAM3PA2WbMkhjX/lY18SmZOdbzO23uLBhkTHIFXmwRY4JPr7CnKhHHnU4YVTGa86w3rmpwjZ9SGdz04fMaTMMkDtOReWTyEmJFP1302PNZdSVauIPedyCkNSQSsg9oVjPXdWV+sIeN+GhNNAOsFBrIaZa5L1Mi17Yb63E/Ag/COKRZmoEs5FMX90UicaD9b264h/v9EiUOpAmuzsyY/4l/LLv4J5wX3uXBrPrExY/pZjWwgSpJo/wCD4RAHgrW2NvJB1Fkf/uHByZgyn+yyIzKCe/8RGMBMVesEqRDY8anjGr3WggrI7xpRXI29Fde9ITJMxhA+vSWrReJQmc6moKtIQDrlPJJUrE7kQFWbK1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(86362001)(5660300002)(40480700001)(54906003)(6916009)(478600001)(36756003)(2906002)(316002)(6666004)(41300700001)(103116003)(70206006)(70586007)(8936002)(8676002)(4326008)(2616005)(26005)(336012)(1076003)(426003)(40460700003)(47076005)(82740400003)(81166007)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:32:54.5276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6727f9b5-bba7-4453-fc34-08dbf61ccc12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

Some flash devices have multiple dies in it & has die cross over
issue. When SPI_NOR_MULTI_DIE flag is set in flash id table use
it to enable split reads to avoid above issue. Define SPI_NOR_MULTI_DIE
new flag to flash id flags. Remove SPI_FLASH_SPLIT_READ config and
related code from the zynq and zynqmp qspi drivers as it is redundant.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/sf_internal.h  | 1 +
 drivers/mtd/spi/spi-nor-core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 9c09f97ce2..2cbdea60b0 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -70,6 +70,7 @@ struct flash_info {
 #define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
 #define SPI_NOR_OCTAL_DTR_PP	BIT(18) /* Flash supports Octal DTR page program */
+#define SPI_NOR_MULTI_DIE	BIT(19) /* Flash has multi dies & need split reads*/
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 63f78baaf4..ace5da9591 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4485,6 +4485,9 @@ int spi_nor_scan(struct spi_nor *nor)
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 
+	if (info->flags & SPI_NOR_MULTI_DIE)
+		nor->spi->multi_die = true;
+
 	nor->page_size = params.page_size;
 	mtd->writebufsize = nor->page_size;
 
-- 
2.27.0

