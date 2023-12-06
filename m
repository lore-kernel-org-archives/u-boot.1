Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D92EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCADE877DA;
	Wed,  6 Dec 2023 06:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TcjXgGxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA5F877E4; Wed,  6 Dec 2023 06:35:22 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E468778C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuxFqfxNtMjFaIK0EuN9gLqn9+GtjOHY+1b6doHc561c0CmqSgPLhO871kVlkqsh3TYHEBDryTKuL2mFuLmwMokLYKam3SSXu/QK4wpxu9KL1zIY/mzBS2sIeo9qqfsPefsCflWvY4j+YhTS+DfU0xyXdkTruLjX6fq93+P0tcauDMDH3+pwAkixWAAYU/PNEi/sqXH8P9XzO7ipOmP07Fiw5vy3sCKMAn1XWbevIEQTc+iNEPXi2M9zVG4Inz2ePQwyu7Ma/NWrpnhSjDzLET8ugQKYXRZ2Uu5gBAK0Bm3YUdmDK3Min0a6Yf/Fl9UzlOnh+qaLSBVwFA49laz5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg1Sur1rkRIAz4YlIZHiJx0/GGwSVH8HPtBDANkDUZM=;
 b=Rw4P2zFHnRsu7qf3ZO4sQU3mh0bkvSS4E800VfS06YRL132F11jjuQt6lP+JVarOMlD7q9Qp0TNzi/PhO1vDalg0frcOdzekhTVdDtrUXd2NrVzovOU2tG2bCOQFmLEZ6SvvWNyJAdvJyPN3Q8BtXaMLFBq8Wt5I8RxKJYerVD8r5ldBRvMZFak+hlKbbsErFTR6uswGt36p7QMFoV/FzQjgP6NyFMlq0wyrsK1kUkJc3gq0JDRewK7youqZ/+y7K7lro77KPHLt0kTQTGnybJ2eXxd59/x4zkx9pgjYcRox28lV4kSkNyEJx/4tSWmLsa9G1MPmThotls8m+wT+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg1Sur1rkRIAz4YlIZHiJx0/GGwSVH8HPtBDANkDUZM=;
 b=TcjXgGxaKlAlQKFl8MDziO9lp1Aq4/LmOK5D8OnICy4kkwDlOJ/1JszxLC13hARpoCXKfM6l6p0HojWe+fmcVrBV5gEVo1lhaWB+1yRs3+3b2ckP94X/1Fyx5bCVpVCvh7dj2qoRTyN74yUUiUBGO7amln6YexzsCgrEwYXAHKw=
Received: from PH0PR07CA0056.namprd07.prod.outlook.com (2603:10b6:510:e::31)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 6 Dec
 2023 05:34:59 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::78) by PH0PR07CA0056.outlook.office365.com
 (2603:10b6:510:e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:57 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:55 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH 22/30] spi: cadence_qspi: Add spi mem dtr support ops
Date: Wed, 6 Dec 2023 11:04:36 +0530
Message-ID: <20231206053443.3746237-3-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c91c10-e49d-4fe5-cba4-08dbf61d1629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0BuXtIHADCyy7WGEf0cNHykODmWn0htSqCArbyZqOULItBCx8rnP1Ec0XLWPlp9+dQcWO2Qaxcgpus8DoGzjFdC0vPYiqmi6m3WLjPehHCnln1cicjZTYtVZCAS+yTElNxLLDYpalKqxM/yqYd48raV5X9W31XGBk+52ltKOs8ZVKeQ/GJF2pZxfY/pCnChGsOTQNydvV+NxO78ntImogqk6cjkZ2yFURTS8NfgYkM2IfdZ1dSP5Y287JqInGkemnxOgOCC5m0wsMGyXCk2gI2ShJzE368nFFwO7MulwCzHyy12/24CuVBt+0DxnguAK+vU1qScOdAOb9SnBF0hgO2DRtTOOKXFjKOmU0mG3ibg7TAVot5ALnmn9+8UTe1xTHuLg9bCsAMRdwQz/8QXUFILS/WggMCNN7At4PkhTa4PmJ0gKsYv+raKUzp7H/9wn4A6S3hihRtyr4fdZIl5dDJQKkLGNhrIcLL++oM//WveK8OCORcZEuNHLSkDZsYmQdlXnJrdpSoYA/yIeBDyU8A8jjhuGdhosYyfkwMZCSPNxE4Do58bO/vWyFkC/ylIl31h+c6cE1FVSNgZnW76SCxMStVTlMBKKwturguG+nySK0Ao9TelmAKZzTZGRR9sbHVxrBXVxqN0hZwT99zwcRBVaoyMevLPODwMGfnK+EgN3T6fefHJc/rKu7rYHGMrwgOnE0tqJ/X2CEEQ5rEGgqAotly7xpNRzXeuhOEfhhjRGf2XjW9B/n4ap+nLu5srKbHZDFPg06aQZV1uG2QqQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(40480700001)(81166007)(54906003)(26005)(356005)(4326008)(70206006)(86362001)(70586007)(8936002)(47076005)(8676002)(336012)(82740400003)(316002)(6666004)(36860700001)(5660300002)(6916009)(478600001)(36756003)(2906002)(41300700001)(103116003)(426003)(2616005)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:58.8754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c91c10-e49d-4fe5-cba4-08dbf61d1629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

In DDR mode, current default spi_mem_dtr_supports_op() function does
not allow mixed DTR operation functionality. So implement cadence
specific cadence_spi_mem_dtr_supports_op() function to verifying only
the command buswidth and command opcode bytes which satisfies the DTR
protocol.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 710c4a532d..282028c845 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -718,6 +718,21 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	return err;
 }
 
+static bool cadence_spi_mem_dtr_supports_op(struct spi_slave *slave,
+					    const struct spi_mem_op *op)
+{
+	/*
+	 * In DTR mode, except op->cmd all other parameters like address,
+	 * dummy and data could be 0.
+	 * So lets only check if the cmd buswidth and number of opcode bytes
+	 * are true for DTR to support.
+	 */
+	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
+		return false;
+
+	return true;
+}
+
 static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 					const struct spi_mem_op *op)
 {
@@ -740,7 +755,7 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 		return false;
 
 	if (all_true)
-		return spi_mem_dtr_supports_op(slave, op);
+		return cadence_spi_mem_dtr_supports_op(slave, op);
 	else
 		return spi_mem_default_supports_op(slave, op);
 }
-- 
2.27.0

