Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96982EDE9B3
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE0B8704F;
	Thu, 14 Sep 2023 14:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPSNrB6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1252D86660; Thu, 14 Sep 2023 12:48:42 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EB9865B0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 12:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9XvhXwpKXOVcWw15rT+FjzEubJ8/ptHbFHc39ZGQxIXXcSvouwkDQ5RCqcOfgRAZIuCTETKeT1klNPqx4ykRDSX6X0WDB6o8I60TeOqHkXyoReMw2ZSotcGeB5zfRuUuo527EPlAKgohqw+3C4RRBawqucHRttQ+Nii1zrTPf6jhTV4pnCejV0U9mkMooQDnLPUhx1CloXgDoWZCDJ3ndm3v451Ghx6BQT58giqrKcOwrK+HJLYOliG1wbHjiSBB8ixfyvgC8R+whE6sEkafJCILc+r2hTKWnjLQcXLlgq+hl6Hvii0ToEGS6xry68LerzXQCEQ+ql7R1u4XfmKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynMHvMI+MGed962qLaau+RzGR987E846RgvQsRjNTbg=;
 b=h8NQb2iEkP/Mn/tO60YbrmO5qM06X9YgMU0cIOVG8K4aUQt9JQp65FglXnv0U0duN9EaUzpuTBzv1i/AjMWFzD3NFsjxIBNeaZkUlVZfNYCE7T/P3WZjeV1q1mlMyiAqDSkcpuiD2v1/RRok/vj7k0h8iOBgiRnPi2VZgQjgtsTBSs17rIwatSYP0if3dsnhgeFpeSNhQnyLM6h+4zbjxSG8AVuUE13aPMrjhl2rGpSK6AJpCQPK8ISh2UBasNJ9zLhEY/M8v9NkHImpbTKhFjRWdDszDxJTs+ZpRke5mgstGtV1kFLLgIdncEoHcivWExa6yl2RHMs24T8H5Pjmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMHvMI+MGed962qLaau+RzGR987E846RgvQsRjNTbg=;
 b=kPSNrB6o+5ZnZ+r/Y5X5QSyu7TYUn4qPAjkUHWzWwpIK6P2laDTnaGavRx9oyvqGaKlWQrsAuGYD5in+RC1A77yDl0Ie6GB5rkPmrItdrZgdLBavkBXy6rLIUHR9jGd7AS6et0YTbLpKUmtbAIcop3yt6vxq+KPuKwALcGHw1xw=
Received: from CY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:930:17::11)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 14 Sep
 2023 10:48:36 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::a5) by CY5PR17CA0003.outlook.office365.com
 (2603:10b6:930:17::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 10:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 10:48:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 05:48:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 03:48:35 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 05:48:33 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH] spi: zynqmp_qspi: Workaround for small data cache issue
Date: Thu, 14 Sep 2023 16:18:26 +0530
Message-ID: <20230914104826.30153-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: d85fdf0e-dc12-480f-d957-08dbb5102601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: My0+jWXQGUbJJEW//4gLabHtHSlJk5U1k6jAQ8c3nLF8IYDicj6mhWDPbAXDpaUgWvomHLieSlhGDTjCENC3RBeOITvf4CSVB/dWRdJ9UBIhbuFOyGODlo1RzQ2XE/Q1TH0gbK4linW6yB5VYujCU91keZIhXqTvkrZy6FQGrJhB+ceW6Og26xY6rTf9o6MTI4DZFZ50k6NOmTc8gaR8KgiGnz6HbAoxyIVEzPXhfAPyg8mqECUz9MrHzOqIucAglI862RKEfH0uAUNLnookjM8gcrejiLKnK2GIsntfHOLE/hnZ30S4fJYuq8dQrH+ftGumxZyrg7J66M1OfoTxJTQ6WAFNRwWHsViedhBI8cWd5BCAkJ/l4sZolXXjPHtbtljIUfXo4sdxjt4cdrGw+REM7J04YRqnDfZtkVD6FVXPgQNZt6U8YXO2uNrKtaVYV5NjOOFx226FlBk+t7vwDSGSIckzjEsSKe4zFOuJnwMUgjyrnojAYMX0VeY6MsF5xoFOQ6ItgS4V6DLi1BLMnWwDoN1y80weE5hZoo5M5QBIYsY8KqrvWz3ymyQdOrwfKFriaeUu1WbbYLEQt/VICXxpjSN0m7CFZ8qK8MZSwjvPMPpUQBflfZkgQGhcWj3P5jGFmK75pAMyhx9enUnkUqGbDMJmVtFry/a1lowKFTGbjN7dtSgox3xovgdt7JQBZXU7cGCxR7DmbxXobx64qsSOZkyimj9JI4nX/YmrQPvcmG6TgvOPQOJ1M9S9BiirHNpL4jRoEQi5kS9+e27LtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(426003)(83380400001)(26005)(1076003)(2616005)(36860700001)(336012)(47076005)(41300700001)(316002)(6916009)(8676002)(6666004)(54906003)(8936002)(2906002)(5660300002)(478600001)(4326008)(4744005)(70206006)(70586007)(40480700001)(86362001)(356005)(81166007)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:48:36.3722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85fdf0e-dc12-480f-d957-08dbb5102601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
X-Mailman-Approved-At: Thu, 14 Sep 2023 14:09:23 +0200
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

Cache related issues are seen with small sized data reads.
Due to this, proper data is not read. Also some times sf probe
fails randomly. To workaround this issue, invalidate dcache after read DMA
is triggered.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index a506d15227..ec59ef5804 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -707,6 +707,8 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 			return -ETIMEDOUT;
 		}
 
+		invalidate_dcache_range(addr, addr + size);
+
 		writel(GQSPI_DMA_DST_I_STS_DONE, &dma_regs->dmaisr);
 
 		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
-- 
2.17.1

