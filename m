Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307CAD2127B
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 08:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6827F89119;
	Fri, 18 Oct 2024 10:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3HgPDGmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A914E89139; Fri, 18 Oct 2024 10:26:44 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD8689093
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljx1QbVFk/wapUNFjNB0uk9MjJBK1kwVm+RN4TZzYRk3WmUFV6wmutxmJNML+hFaKqpPpieghdhuDUIxc5Mfn7+NAwtGCfxYcJPOlkDJU8luZM1KfotCIUhwwBremPVCYwlPXOcGmeOdqHbv3Ozn95XLN3HQTbGxdny3zew0SEWCqyAfQOhPr3E/TIiu54kJxepBPWKjD/Zg07BejcLbSOlE9Ct0X+hFNggBHSaxmjQRT4LgGZvbYmuDoX2Y9eq1j/baEM5vWxyEONPsO0g6Oxd8uSNl9RSOrxPRYT80v/p3OWhRK+WMxDDupZoGPaFOZZDK3keqE/RnjP6BZutvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X082H/FygOUFDK7eCNINMTIL1XxvTWhK4JlpI2QdqBY=;
 b=unLwn7VUSlj1qSgiyY6xNN7QMgSleDpQpV6H6mpvlX1c6iGfc6d145AtCxDNruAl00zvkG8dcAzc2tf6FiN+s64NHLxIacfIRZAidd/VUyb9A6zX2XAwcMXhsier6gTU3LzeVrbYuDFcqenXSCVNglXLsAec6q6WmP/Am3eeDHNuK0EXQkAa4sGTIfBXijQe27O2AvVa7TimZ0x4jicY6Tw8+FbkC+UFGrN4YmS+98Uw9OaWT5E5QD5n7iXU53DcK/fkNHDVBc1+CyP9PCdcc9/RXckV2URF/g2Pbg1mpfTlCASiJCGDsQxtT8eRUjJGGb/GkNna8gix7y5IJErcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X082H/FygOUFDK7eCNINMTIL1XxvTWhK4JlpI2QdqBY=;
 b=3HgPDGmOJWcZCmFwwL2icVAvBrHssGe1PEYuVvGL+jvayj8lZYYy2hxN6XkI5cBQu+cgxTbK0cN1oIyoCiu9tmJdAt+cU30XpBXIdA5OOkngFPH8lztJ7MHHn32auFc+W5acTsZY81w2ExyVJXC9gQrSDHO0e0yGxr17mUf53AQ=
Received: from SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19) by
 SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 08:26:38 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::ef) by SN6PR01CA0006.outlook.office365.com
 (2603:10b6:805:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 08:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 08:26:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 03:26:36 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Oct 2024 03:26:34 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <git@amd.com>
Subject: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
Date: Fri, 18 Oct 2024 13:56:44 +0530
Message-ID: <20241018082644.22495-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 53634a2d-5856-43a5-5775-08dcef4e95d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2wB9rpphS8rGr7FhTm1MOefr56g3RGttDyvakywLKJ0vzlv/wuCJqKv4pTA9?=
 =?us-ascii?Q?N4vGkHp3rmL2+ZWbaYkCe9YzgRzuDn87bi2oRkebR9IK79esD39hS9dK2yAT?=
 =?us-ascii?Q?ZKjOjaEg1Iy9ket80L3OIy2u2b/+1VfddAVtC8usd791oYNp/K5fx38UfYR0?=
 =?us-ascii?Q?qdBmlE83n4K1rvALjU/wFkd/Rfb0wuC5pWXujhDXd/dDJ/PmSwkMjTChfEI8?=
 =?us-ascii?Q?7RAzIf/VHmRhcocmqE8007xKhukHvcLBRsxvtNvaIUuCFzFzBSsg8iOojtqI?=
 =?us-ascii?Q?uty/IuDEywSkVudzu/B+MOJ/RgMdJz8YFxbvDvV/+FozkfoPGJFozZWnZcxj?=
 =?us-ascii?Q?KnrQUrrtHx4ruXbyhkz/KizxdJau7B1Kwf5XRqlVAi0dZJz4WKvD1beZ+jLu?=
 =?us-ascii?Q?rfWg3e14Md7Ah+XiHmgZaQWbQP6lmnjId1AuuBpBUFYDR0iVE84Ev9Q/nnB6?=
 =?us-ascii?Q?HwwacwwC12KVTlnFJfufqHcjKCTO/sjcOClUBkvPYlVEVtvqFHE0eZuSM3GX?=
 =?us-ascii?Q?Yqodnx21/ZKGUYUVXoA4u+vWHKnXSx1lA/bqjIqkDw++m+PH30w2buJ+OEch?=
 =?us-ascii?Q?VQYfFjQCBpLIo69syq38fTVqbqhuI94eXmAaqhXgwxd7hdkGnUpv+d5q6r12?=
 =?us-ascii?Q?JBTAHTzHCbOwXTGecR+BzdDbaQxb9ZFsFBqbSuwdZmPYrG+Qr9NEPoCE1Bd1?=
 =?us-ascii?Q?OXatECszqc963CwrbEi5IHi+2WY/ceaYUZvwEvQeie1QrcXXdcJ9D7+rya++?=
 =?us-ascii?Q?C5zhWZ5ZnMVJV8z7JEDWcXWJlZxaazDovQl2UbDy549U/bRQyfnfCoWj4HOp?=
 =?us-ascii?Q?HtUWPHK2K/rL/vRXvE1Xs5gcWsm74KyWsxCIf9G8hwd5lS4wSBFGEtQFZikz?=
 =?us-ascii?Q?BvecbPz5aW0MYg9WatO1FYhVJ6J4ZHCmDYOehbcKbw4mgUTTkjmSwE6BI+ql?=
 =?us-ascii?Q?kl8o+eADLHFpR0TTcMVN+7iM2MjTmXeh5eIcZeiq8ORNc5F6PviCJhZEOVGB?=
 =?us-ascii?Q?c9UFuokZ02C4TKE3Afy4zmrQ+KlutCVBz8BhgDjWEzUA8IcTMiJkQOyTUcoT?=
 =?us-ascii?Q?BmSYhy5QwDWDYZ5kBMvRpNR0RRnkjusRpggw1Wsrn3LjG+I2quR/VpPW3qeW?=
 =?us-ascii?Q?IEz/2ibVEswWBIey4C3hM8Bd7Osr1bdJeVoBEOBa9eSgbF9YkTBuo/rpbV/S?=
 =?us-ascii?Q?7dL5X/t2bcxpz4tyHvHeuizdRYsarV2X/O98y2L0+gPyXFWhfsHvsEnysSK+?=
 =?us-ascii?Q?uorXQaxHm2SnTv39Ey1I2ldkKOrrhBZ80DNhEy/MYgzFtRhvXp4rGjE5a/+r?=
 =?us-ascii?Q?OcWoVR6BMBhug/pQUa/SFuFsSFanAR1Cvt1nCjcQyLb+2/nOv7/kNcGZWDWE?=
 =?us-ascii?Q?JDJGPuwabTMibqfZQkPZMFh6iW7n+DcdE2078dQUQXYV3/9Z+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:26:37.9326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53634a2d-5856-43a5-5775-08dcef4e95d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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

The below issues are fixed
1)Fix the read issue for 4byte address width as read_len
is getting zero.
2)Fix the spi_nor_erase function by passing the
correct offset when it is configured as dual parallel.
3)Update the write_bar() only if the address width is 3byte for
spi_nor_erase() function.

ZynqMP> sf read 0x4000000 0 100000
device 0 offset 0x0, size 0x100000
SF: 1048576 bytes @ 0x0 Read: ERROR -5

Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f5c9868bbc..2034d84251 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1141,11 +1141,14 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 				nor->spi->flags &= ~SPI_XFER_U_PAGE;
 			}
 		}
+		if (nor->addr_width == 3) {
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
-		if (ret < 0)
-			goto erase_err;
+			ret = write_bar(nor, offset);
+			if (ret < 0)
+				goto erase_err;
 #endif
+		}
+
 		ret = write_enable(nor);
 		if (ret < 0)
 			goto erase_err;
@@ -1154,7 +1157,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
 		} else {
-			ret = spi_nor_erase_sector(nor, addr);
+			ret = spi_nor_erase_sector(nor, offset);
 		}
 		if (ret < 0)
 			goto erase_err;
@@ -1582,6 +1585,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	loff_t offset = from;
 	u32 read_len = 0;
 	u32 rem_bank_len = 0;
+	u32 stack_shift = 0;
 	u8 bank;
 	bool is_ofst_odd = false;
 
@@ -1608,6 +1612,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		offset = from;
 
 		if (nor->flags & SNOR_F_HAS_STACKED) {
+			stack_shift = 1;
 			if (offset >= (mtd->size / 2)) {
 				offset = offset - (mtd->size / 2);
 				nor->spi->flags |= SPI_XFER_U_PAGE;
@@ -1616,6 +1621,10 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			}
 		}
 
+		if (nor->addr_width == 4)
+			rem_bank_len = (mtd->size >> stack_shift) -
+					offset;
+
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
 
-- 
2.17.1

