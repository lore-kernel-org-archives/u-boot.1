Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED3BC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 03:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD55A87738;
	Fri,  1 Dec 2023 04:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eINJDVrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58A287684; Fri,  1 Dec 2023 04:19:54 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9975287755
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 04:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy9ukXNX/X2aCgIDlFgCSeD+YjWPx2nZqz8/ouCd0PK55mBdlQ45aARdvCDhGjOI3tJgw2D7Y2xBW39tqrzbf508dhqTVqz+z23NlOHEk1z72j013xpvgBAYFz15AhqM3GG1zhIzU66oaCiu35huWmjNKtBHnJ1HhmadLQiG+y5fovErrQ7kCy8o4Y16C1PKNLWFBSzr9tBeyvgacz0wrX5Jh974PBdSqwLGQdK4tZ/Bn1erDgwOZmTNINH2qpueprSm4NeY0wr9alc95ouQpWWdhwMP6jYyitAZVj2Oo+xGZ1IZQ7xxNMsmRN1sVIeb0nVVGd0qSrXwaaGb9Rp9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yv0iWnlzU0kTpe2+e4Vpo+dUFHQ67EI4yRij3Mz+hTE=;
 b=PC8aC3ctuci/6I2f169roXwRtukhunRhsU8jaJfF0KkydUv/14ArAHUbB3CKPbeobsgH4uJtc2cs3tmYJRkealWvdDQBkx7vofDN8S+gAYy2IFTvNaXYVfB8D4boQtc9KJ90+9Npc3xAzzaJgo3HzG853zs+Ds0ShVQSdH+EUqDCzVNcLlyMVe0DTe+I/BzmnH0myQ2RR49xgmrPBU9WPK9yVMc07HIKgKbNMVgPqaiQPTuliCAQOriO1oNI86vut7+ny/OX62s1OyVImt8Wku3IRYO1Q9m9t31CfP2NAxavQ5XOw/hNugY2t7oRvHPjP/WQ9EOdC4SU0nbwnlQuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv0iWnlzU0kTpe2+e4Vpo+dUFHQ67EI4yRij3Mz+hTE=;
 b=eINJDVrNm9P2X/+EXw7QF8FJiIHFxhQm6oVxzHktBcMCLGQOZGGh7MFjw+skpbrY3GKEJwLSNGjvfn3WzJa4RPUFUkKt2GTOeTYTVkdV5tESlRtrbEMnkDBjv08bqF4OY4ygYRtzgb0JNya2sEbowdoV8PZY9vclRYJhJuFVuQ4=
Received: from BL0PR0102CA0059.prod.exchangelabs.com (2603:10b6:208:25::36) by
 LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Fri, 1 Dec 2023 03:19:49 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::ba) by BL0PR0102CA0059.outlook.office365.com
 (2603:10b6:208:25::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Fri, 1 Dec 2023 03:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 03:19:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 21:18:52 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 21:18:50 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v5 2/6] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Fri, 1 Dec 2023 08:48:35 +0530
Message-ID: <20231201031839.239567-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
References: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b074020-8f5c-43a9-a19c-08dbf21c6050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpJCzel1VwfR7Ixj3BrrPsNCma1+PDoXpcgDZd7eJQ0NPbI4ziPxC5M1vHf5nHN3N7aS6CcRT2tzT2ysdrdLSjCqojMO/Cy5/wGX9f+ufAJb6mj4mJo0joTm0KYbn7eIX+YvsUq24LQXuofUBZQM74+I/fFCFTCGxzrNV3zmiUd2VspU1qSEvm/wrEf8A5aDIGXQzxWceKgU3wKuMZ/enw75g2eNMlUsG/eSl40b+HzqX0s4e5v4+VCRLRlLauihK/S4J/Nqvl9ecek5G/Mr7DEnOuvMJfP6JzK8NJ//mZnPt2O7wopuc3XAMCVNC0RM608EFiXXjoEhOUsxHq+QqpkGCeypw+oGRinWL/+O/F8s4F4YHp26wr6VyxpH9qQf1BS1gP6vW6Uu+S2GKMdblWMNgaDhaeWxdlNfDZ2i+vEEjWlLbXXY7aRHOGze4HNh63PDuUhDhi/8GkkA9OguhzEyfOdXyNlqmJ0lU8heXGoTvcfbzkLYpngq5VYqUQsPc78ipP5PR2ye3MmvtJNwVbEseLkJku/j1Q5pb1C9N6gurqyFBIKSlOhuq//IO9kI2owHAGYnLqgMFbhQ8fbdl6WD9SwoDjFBK226mHiL+lY9ts3nwf5mgrvPt7Tsy57ikNshNVWx/qg05N8lqHDr3SzEu3xOCOcoiJSbBOsZbUZioHcXeMfeqjkJNgwIWuAafufW7sXZwq6SsZ8kNVHPvcTkecTxWyQyPUKo+6sGGdgJpu5YijOj54KdIiDj3ZJM9IQTsOOJ6UfbJLTGqKNxMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(6666004)(6916009)(41300700001)(4326008)(8936002)(8676002)(70206006)(70586007)(36756003)(2906002)(478600001)(2616005)(1076003)(5660300002)(316002)(54906003)(86362001)(26005)(36860700001)(426003)(336012)(40460700003)(356005)(47076005)(81166007)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:19:49.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b074020-8f5c-43a9-a19c-08dbf21c6050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

Add support for parallel memories flash configuration in read status
register and read flag status register functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 4e2d8c8231..0e29b3020c 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -438,8 +438,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 }
 
 /*
- * Read the status register, returning its value in the location
- * Return the status register value.
+ * Return the status register value. If the chip is parallel, then the
+ * read will be striped, so we should read 2 bytes to get the sr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_sr(struct spi_nor *nor)
@@ -471,18 +472,29 @@ static int read_sr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading SR\n", (int)ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] |= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
- * Read the flag status register, returning its value in the location
- * Return the status register value.
+ * Return the flag status register value. If the chip is parallel, then
+ * the read will be striped, so we should read 2 bytes to get the fsr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_fsr(struct spi_nor *nor)
@@ -514,13 +526,23 @@ static int read_fsr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading FSR\n", ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] &= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading FSR\n", ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
-- 
2.25.1

