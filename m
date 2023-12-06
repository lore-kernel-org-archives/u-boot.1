Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA27C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D898752F;
	Wed,  6 Dec 2023 06:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/mzzbsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F39875F5; Wed,  6 Dec 2023 06:30:48 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AF487494
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKaIIJ7GiKA8i0cdkq3w3iWY0joIx/sD80PYfXNAl1+AVBGkm/9jRwMJ2VCk2Q/s325FSJMrTyGe1ZI9RM86UALU+0G7z9W4ing3pDqooUuD4Q7u1KmClCahO0s3eZooaHr6EWKFrpyd/5BAfzkaSSwvOwYOZNkZg/MNu5KDdcowtnD87/a/UvXRD11MVz11hOBBpxWF/KwbVTglYNeNwT4d3ucNmGYisubG6Sd/VU+jbrNJyCkkkF73ep7w0Jd6JAeR2KfjuZ8g87qGt9zsAukyapEiEYFzIKM2OEB/XB9WKgIewgkOJl4oX7vz4o2ru04Gt3Am0gzbczGcNbzdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTMxzbWUFvz0qsB7IkJnou34n9auXirQqy5KtfSlb0w=;
 b=DPaWJpydwI1SRmh8oRMEuoFte6F0UCXvFTpkWAq81MTUph+WRpnAYKxosHmOLwHyCG+4tDUkTwRpxgIR0ynZHVpWK7xO4KOrtrx0fknIn/03oQZZvvDGxqmGdpFA/kaYTOK0jeGkT5p8FH2MrmivB6nvg3Oxcb2wp38PsyyMpadC5V9tGR/pR1tG2bsf7RfnPkIySSGmF8iFEuJjNTeMEdK64lk3FMvN7+vUv8XuQ/jDX33k9AXz+aBb8W5UOBfey5R/we6Q5SQaTPsJbL9O9xaDpPHIRXXdqUv7HndVp3f2HjvTTHmczxsmP1mu/tXc7J1K1wSkNDeRHjOtf5czdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTMxzbWUFvz0qsB7IkJnou34n9auXirQqy5KtfSlb0w=;
 b=o/mzzbsI8yoXQdZBK6Q26sTNAtFYUzSPq9W0YunwSkqS057UTGxucwJHQpY93DCB/Y3df3a20OBUPjvP9BwAqTohnN4sQdw1VlV2OVAZTHEUaJ2aVLVW4wpRnUTVAMrpvj0ruaj9AZhqeg3Xunzvxc2jaO5HF/e1SrPj9hBLLJk=
Received: from DM6PR05CA0062.namprd05.prod.outlook.com (2603:10b6:5:335::31)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:30:41 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::e) by DM6PR05CA0062.outlook.office365.com
 (2603:10b6:5:335::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:30:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:30:40 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:30:37 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>
Subject: [PATCH 02/30] mtd: spi-nor-core: Set dummy buswidth equal to data
 buswidth
Date: Wed, 6 Dec 2023 11:00:24 +0530
Message-ID: <20231206053024.3744447-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 85919d9a-24d5-4a97-f803-08dbf61c7c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTuRgbhyTSp3g0PoPBcwrg0mjEucNI2REmi20jJhsjnGn5f3DnhrlQ4vGTwfHHbzHYRSKVqhW3YbY+H9YYp2f/jlOP1LUjZSOxUj+PTlkSAW3CNGceEsTWleepKx1XbB/FHwuQpbZz42nSgNINxlE/92g0G3Q+XC46qSyDc+Fg1xZMtOfcM67bLa8hqxCXivItuqZtsr5TeMggP9Fc1vv5TToN8RiWPYV+YitYFQoud40xf+/McNWmoKx65erMrj1VgXdFfYIAzX5dhT9D/ZYX2AItMwbSZStXtATQZhAacaaGperQQfznV+pxN9kG4lT1jlM48BKPp7O45gSj7wIlJ786Yyvtj2GLaiHN2BxQPSvX8hW6Q7C2H9QecWqGi4jO/7p30D490SpPSJLlDgTccQibQp0oEvElMgyFp8PEAdMu+ixEEInCQxgxdosLcwSsBD5ZiUUjqaR0Bxnu8eXEPH/vm2YgdQTayKqu1+Ykm8kxMRDM1AIel9N33cGvVcKsJXjLMVxKA5LAyb1W7gsZqhljFa6AX7cGEf1wBlY9y5IoWdrFel2s5guz0ouhAftBWus8KbtuLXU3blUfDj3LXzzaAuZlFkNEWAvIIFvhcAJEC3J0rm3b5TUU1lHDHlcET8i3uYEX8cBX/lJMRK5ABN5h+8L9kkClsX+zfZBIM0t6I6W3r2Y/RkPhczyS+YSpR15vKDr1Vn2HYpEOc926ygj/gBOWCAMtoWX7XVCHikmn9joE1A5NH98ZyxGUffr64+22hQhUDEwubgLDQdLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(83380400001)(478600001)(2616005)(26005)(1076003)(336012)(6666004)(316002)(54906003)(6916009)(86362001)(36756003)(41300700001)(8936002)(70206006)(70586007)(8676002)(4326008)(36860700001)(40480700001)(103116003)(2906002)(5660300002)(356005)(82740400003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:30:41.0987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85919d9a-24d5-4a97-f803-08dbf61c7c88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

In current implementation dummy buswidth is set equal to address
buswidth. In case of quad spi (mode 1-1-4), where address width is 1
the dummy bytes will be calculated to 1(8 dummy cycles) and dummy
buswidth is set to 1. Due to this, the controller driver will introduce
8 dummy cycles on data line(D0) during read operation.

But since we are using 4 data lines in case of qspi, we need to change
this dummy bus width to 4. This will make dummy bytes to 4 inplace of 1.
This will be taken care in controller driver by dividing with dummy
buswidth again as in below code, which makes dummy cycles to 8 as
earlier.

dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;

So with this change dummy cycles will be on all data lines(D0-D3) and it
is taken care for all the configurations(single, dual, quad and octal).

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 473d9f41f3..8949dab548 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -260,7 +260,7 @@ void spi_nor_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
-- 
2.27.0

