Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B093CD43FF8
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 09:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8B089294;
	Mon, 18 Nov 2024 10:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzQy56W5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A2289373; Mon, 18 Nov 2024 10:07:24 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A4B890D0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 10:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjUBQVKfP32q8gQOyHA2QzF+Mc6v3wKWCEs0ALAC/hDMpeiF9rp4+WQkKLSAsyZuQG4Tpoa8Y70ypLW+CYtiAzXSIKAgdZBtqQrTkhPNF+AWkNZJQjMVi2FxGxBKPsoWlOVq1hhj7bWjdsx9PppwgD/NQ0zSLbQv/tkKNXbXOTl/upJcVh64DBN5HJVA03lT/1urV9nx2wfvyybF4shVuHCSLzqCCaIHhUNGHjQZ5qsKFyFM1g3QKehj7xisuB/kVoTZzwASTg1qhN9B2tM/iB/kD6TCEt4asnmZ5p76i55GddytS8EXVUUCbv0r+Amrkj6vWW0Hkt2MP5NMxeP1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbaXoDQPqn5B2d8/Qpx+QGreW/yYSC8pr2cC2BHvHw4=;
 b=oDFAbzcQmFgRVQH+E6KXWIcPLrVNzKQhXzctsymkoHNIJFXUkAWX++Bxd9G0LC2KCSypYrDH7e8d2anjs342yWH00KRM7ggfcUfRlfdtfH1odJofCwcyZESSsco0HOiocUeyqs6oTwPb2FK9Bn1qRvmiRbfsZoEDBtOlTSasZMdhx/sKlHee6249OZlEqhcYeizbcFDo20FOLr15fLFdtuZxZ36i1S5XWaaVvIJx5o6mpe2v1hjwAg6vfx0AKZlY3/gtDRJpdjB8E+wcJjkqdRb3d5NZf0YWBVLqF8CtHk3As1f0DK2Y78RTQ4KG/7cB3widzw4pqqEDMeONdG/6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbaXoDQPqn5B2d8/Qpx+QGreW/yYSC8pr2cC2BHvHw4=;
 b=NzQy56W58X2SuhZHBpOZlRy+pA1JzfUIGs55hiy7Nc4JUNbJrVrTvgwd3AXh75MgZDCJbNnEr39wKHS6tIMKitN18wxnfi3++jwYsq5RI/fuMjHPzoj6pnNJZXUKRwOeZMB9c4I8Jwq95vLbMMuAgstEB9YCxh4yqMSV+8AQAFw=
Received: from BLAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:32b::7)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 09:07:16 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::d5) by BLAPR03CA0002.outlook.office365.com
 (2603:10b6:208:32b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 09:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 09:07:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 03:05:54 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 03:05:51 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <j-humphreys@ti.com>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <git@amd.com>
Subject: [PATCH] mtd: spi-nor: Fix the read issue when addr_width is 4byte
Date: Mon, 18 Nov 2024 14:35:44 +0530
Message-ID: <20241118090544.21956-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: fd407593-7196-448e-7d9a-08dd07b065bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YRnEpNE0IJS2C5476yQY33IBtDq657/pTFxRMqGX2cBbkMuee6ojKnR8b0Ky?=
 =?us-ascii?Q?D/jjhNa8EuOidte496O17nvoRplwKnEG4Ck72c8QOb7F4Dp08PBZ6mbP8L4i?=
 =?us-ascii?Q?FZ52SHbwXLKA2P32Zq/xDxOyt3fFFmhxtHeZtIz1mBd+/0Cj6BIQEGLL+xwB?=
 =?us-ascii?Q?sLb0dPywJ7a4vCGTHBcdkBK9RLSkwjkk+jfuTbVn1+4YjMnxxt5ALvobEWKZ?=
 =?us-ascii?Q?eRNJGslp9vgjbrR5Bk5q5MerODzUrhJHELMQWC0RO6fgf310xDIPfipeC35T?=
 =?us-ascii?Q?Nge3b6uj7RQGbscvlUIdLCEX2BNsfDcZp1F82dpSbU7WaCtlHcFvt6UOQv87?=
 =?us-ascii?Q?ec95nLpkTwHq8GkmFW7L9q4twSML1r26TXo176eGuFdx0eNH94CmBKVsKWh2?=
 =?us-ascii?Q?BPnPpWjXuF+bz4n+DoG6so73J+I6C/JM5VpSLFXmvrQTJqzSjKvRPTWmGSR7?=
 =?us-ascii?Q?5uML95jYSUOAA7GCEh4txsosBObGc1bpWwVn0aIh7+Z3omYONXNmrTy/8IA8?=
 =?us-ascii?Q?RzPNmCLnVGJZZsqqHK9RiH70oR8MH4QCX37LhB04ml/MyEXgs5wWljOsKX5T?=
 =?us-ascii?Q?M9YHB7bt8SzWMIp7uYtupHrXqTDV+kRMH4uoBGWe2c0/aUKLtJ1Z9zBrlZBR?=
 =?us-ascii?Q?J/qjN0btFXPSrr5jGiSMQbZnC8fGAul9S18TcSjMS/TgcD0OKxbL7EywAoev?=
 =?us-ascii?Q?TgR86N2MsOgOTUYY+uHgCaykmkIJhLCAcQtNQUlolX0HeBbFnkOlclZp1wta?=
 =?us-ascii?Q?3qszbne8TBS3Mv59OC4lWmXRcdx6oxKcNuyMTch0QD+a7y1kDwtUq12CvX9w?=
 =?us-ascii?Q?A2vtCBzsuLKo5lYB1kVIJXVZWl/1bkBjVJXDwBxY44SG3FrHtnMyO+QeO6ob?=
 =?us-ascii?Q?+QlhLclRN3eptPEURDk9u5w80Uh2uQ8KzW78GSUJ+X2nHSBBHjVyPAjeacip?=
 =?us-ascii?Q?U5UGABFapEJ0zqiA10RlHnoX6CJBT0iRFASR5r1jHxJjfkKyud6uIL7utwIz?=
 =?us-ascii?Q?Mw5GM0acelJb1CjbeTiCCwnHqnxJ023EoxDA1eAm5P8uUdnrzv8yGtBVPcul?=
 =?us-ascii?Q?fhvONb+sETKedOjdrGGin4aXEnxE5FMhf4AEiw8+b8ek3vDrNRIxEnFp28xh?=
 =?us-ascii?Q?+GWcXfQno4tV/pSWSjUmDLE8FAmVn+Qo5Tga3/SmYStDA/A2O7IVd/Cs1ONx?=
 =?us-ascii?Q?n1mzO03ZMAWiv3OJb3fj3lzS/g0qyrH0KVzCtObCIzrosa+f4POWmWDEY+gD?=
 =?us-ascii?Q?ETwuZTlgZ+JFKi8fhfggFBoMjMgX67WjVfv1LoosMqR4l7YGwS46wguLydkt?=
 =?us-ascii?Q?ATRO2ihXTg8B4ybHfudo/VjkfE+V4Xj96v0i+cNcgymUUjhF6OdHxxGbDdTy?=
 =?us-ascii?Q?O8dKauuYOLC4UwwQVmMqPb0moRBBDPQ0p0nlSJVn40tOlPYzGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:07:15.8187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd407593-7196-448e-7d9a-08dd07b065bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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

Fix the read issue for 4byte address width by passing the entire
length to the read function, split the memory of 16MB size banks
only when the address width is 3byte. Also update the size when
the configuration is stacked.

Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..c37a9bce74 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1580,6 +1580,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	loff_t offset = from;
 	u32 read_len = 0;
 	u32 rem_bank_len = 0;
+	u32 stack_shift = 0;
 	u8 bank;
 	bool is_ofst_odd = false;
 
@@ -1593,18 +1594,20 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	}
 
 	while (len) {
-		bank = (u32)from / SZ_16M;
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			bank /= 2;
-
-		rem_bank_len = SZ_16M * (bank + 1);
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			rem_bank_len *= 2;
-		rem_bank_len -= from;
-
+		if (nor->addr_width == 3) {
+			bank = (u32)from / SZ_16M;
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				bank /= 2;
+
+			rem_bank_len = SZ_16M * (bank + 1);
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				rem_bank_len *= 2;
+			rem_bank_len -= from;
+		}
 		offset = from;
 
 		if (nor->flags & SNOR_F_HAS_STACKED) {
+			stack_shift = 1;
 			if (offset >= (mtd->size / 2)) {
 				offset = offset - (mtd->size / 2);
 				nor->spi->flags |= SPI_XFER_U_PAGE;
@@ -1616,6 +1619,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
 
+		if (nor->addr_width == 4)
+			rem_bank_len = (mtd->size >> stack_shift) - offset;
+
 #ifdef CONFIG_SPI_FLASH_BAR
 		ret = write_bar(nor, offset);
 		if (ret < 0)
-- 
2.17.1

