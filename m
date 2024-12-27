Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB094E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 04:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC768036D;
	Fri, 27 Dec 2024 05:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2U2ZfWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BDBC8036E; Fri, 27 Dec 2024 05:50:04 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5752A80362
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 05:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5ENTvgyzzIp5WyJhEP+RcVX7m17yOyzAVqV3qh2f2DVGI4mvjHKrHk6/SbTPqS1frC0UrhEXFDr1gFOuo0pUSPPqMeGIIyjsQa55U8q1Xsg/ZiuEa0fxMalKzQUnipYgVnDMbYK23wsJKbj23ij7QyV+vA+T44du6wbIBhLbs0hMXWy09JjAw7zLgNEUakWTHlEfTUhHzMr1LwSdiFwf18vuo8Q1E/kZgSKALGqYzd1Efwn9YP/Owy7Rc9I2APfDVuwMvbkeO2w6Eeg0bWgTVvA7pAWqzckQgynDQ0wj56qyL1E7Wpin7atT8mAQiukF+iQAB2t/qIu3sF83zagOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7uAeZIi1Q6m4K4q3aZ4RHhcvynsNPgnCIoFLBJik4U=;
 b=fM4r5p5WULl7YjiBhOQvh+5bQb8oItfwM/cm6r79/L88kyOFJpfInZenVu5aAglo+0uuSbVbw/qCMyznLdjYxApw3lMsEJF6ZjKYjf5etyUiZHcjSU5SITOLQBuXlIhEzaQWWPECrH/pp8fg2YK3Q8HxMgwEj8/7qelgbQcj3sSvQyQ0JEvm9tGrI8+EtFRAURS0rvfzRy9HDyZ07oOObn57GiFZuUiSOtEswkiCyU+4BlYvEPBtgFkRBqQ22eYl8CCFWMDCNan5WcmjwwU0DoVeh1JmDY0NHKO6Nf1qiQGWQK1zEGdsinU+1CDcSnhYUtCDn8d6lYvpnb+GMDtKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7uAeZIi1Q6m4K4q3aZ4RHhcvynsNPgnCIoFLBJik4U=;
 b=t2U2ZfWJyUtVbHrfkJB0y8jOCHksb5O51F8ptp/t/3OYfSnNVcSzvVinviWNJZ6uH03HtXvLi5CmmS/WEGkQGKlckfTgDjCsbp1S4lHD1aRK8vEaEMosgiCGPLvM2muJiTFXaH6NHTj+zBHVCyWq97YqSq5/bHDZ4USh88OEXJE=
Received: from BN8PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:70::22)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 04:49:52 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::b9) by BN8PR04CA0009.outlook.office365.com
 (2603:10b6:408:70::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Fri,
 27 Dec 2024 04:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Fri, 27 Dec 2024 04:49:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 22:49:50 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Dec 2024 22:49:46 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Date: Fri, 27 Dec 2024 10:19:34 +0530
Message-ID: <20241227044934.2109997-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b69785b-4aa0-4629-ad86-08dd2631e696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EejDZTV74GzL1Dk3vYZ0LF9QypD34CSi4SLdzVO6W+xmEY4CfRE5PL3aVF0B?=
 =?us-ascii?Q?CBOgoeR9ERYuAF46oNNJhxwFQjHdhhg6xEwrk2Faeu9CtObwLA2XPSUI4dMI?=
 =?us-ascii?Q?uv6o0x/dTpwCeJAJwjieajN0QA+ECdv8CZCRuDRCqTbCrxdLUsJgDTleWxaB?=
 =?us-ascii?Q?+ycVVVemdMCdMfjvI3Kj9I6zus/17tpD9WdxiV2eypjpAGw9hybF8wV0eHnH?=
 =?us-ascii?Q?ON3LIM9FScpyX+73xiDr1t1Kd7VdqqndOZL5Osx3llsal5sY0X51ksoXkQDn?=
 =?us-ascii?Q?2ns0oQ3qRVboTSJOrR9rnfTfc4NfxrpMqrAHD4S99F9vDpVSUyRm5sFH3aNh?=
 =?us-ascii?Q?wOEX4e0H17n1Gz7Jlr8/opCF7X2pZ42v/Irz1Lo7ygwLtmP/CVPHJacX7vvD?=
 =?us-ascii?Q?xYg3woGMLzp/GlUOX5v1FjwvznuADemEjnafXL2HK3Mwil7x1sEntd4vfhjV?=
 =?us-ascii?Q?/LbJmIUuTksGlnN95+Wta0I8H5+PvRvMRo7smaHvZN3wX1DQMQej86dcCgMP?=
 =?us-ascii?Q?dsvf1d/U237GdQDvbcjiZQVoNQnnNXRD+lyceA1U4O7u2VxOqtRyxf0kR4Sw?=
 =?us-ascii?Q?DYSgtzGtp8Ya5GqJ160xSu37ZWWBd8lcuDjmIbgS07jIDZu6SVxX89eWKxNZ?=
 =?us-ascii?Q?MUYcNktkT2foaaJPOEcWZefPGmw5VEBbIom004fm014PoaYE1VeN+oAsjCxb?=
 =?us-ascii?Q?eNyK6OQXLZG4/m+QA5vBPOE8Z+FTKuSANMTst7P18xRv1Kcf2Ens/NKy/Ki6?=
 =?us-ascii?Q?XPU5/b7i6APfi2pd1e0G2t4wlnLA8+vMDe2yrwDmO0VBHUx48j7Z1Xl3Qsld?=
 =?us-ascii?Q?4Jx4iod7U0ysDlQBiJuYzi2B7BtSMMTEazx4SMpEGYLJtUDcPxeFrFCAWL1R?=
 =?us-ascii?Q?rYA3n24Jeq1IaLOx6QeLhWIoMeGBYf28Ie+BDyobpL0HB5fCMvHoEPKDQp33?=
 =?us-ascii?Q?qHADzyBQsW0VJy2Nb2xEViMAhygtN9BLVe/6bdATd4GS41+seTNXMIgaVak4?=
 =?us-ascii?Q?cdqbfqrPv3h2zeigvcrBtLAteZ1Se6qsAdBLU3uocm6/csGYu8q1DCOQJ237?=
 =?us-ascii?Q?o2usQ6eROZQXGEzPplwkx6tUt/ErxPHG9C+I61gE+16aBrYkCfakLb5eyel2?=
 =?us-ascii?Q?VN4ywLqPnENJKYAXKDcE00WsWpWsjDt5Ax2VTup19sbkXE5a13Ksc53uyhDx?=
 =?us-ascii?Q?nWzO6ZOULWRbh0ortboSh5BEQyCAGm1hm0nDHhJWXJF24nREPBtoKqsCp+Q0?=
 =?us-ascii?Q?TV66bt+XQ4pSBQkHgK+sIadcX3Tx731XbMtW0vgOyJFmkNzFP0yP1uOKc/sA?=
 =?us-ascii?Q?MATHGPKLXzLfkl/AKlYCSHtdbHYTruuwBAulEgo8+dNbCoYtI7REMqw9rRYq?=
 =?us-ascii?Q?YG7+OKwjZibeqejijmo5HM0xbpySj0p19r1fS9NTiaSWiv5RyGb63/3pJdWN?=
 =?us-ascii?Q?+aI0KTc9Z+XrqkV+I1qHPza1hhAPnu2ehR9NKsNEMEIEsQljSK4IyUq0dyyQ?=
 =?us-ascii?Q?FeeExVC5mmfBpvU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 04:49:51.9584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b69785b-4aa0-4629-ad86-08dd2631e696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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

Update the spi_nor_read() function based on the config SPI_FLASH_BAR
and update the length and bank calculation by spliting the memory of
16MB size banks only when the address width is 3byte.
Fix the read issue for 4byte address width by passing the entire
length to the read function. Also update the size when the configuration
is stacked.

Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Update the nor read for parallel configuration and for other case
  keep the code as is.
- Fixed the commit description.
 - Tested the changes with s25fl128s flash  Zynq> sf probe 0 0 0
 SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB,  total 16 MiB  Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;time  Zynq> sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;time  Zynq> sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
 SF: 16777216 bytes @ 0x0 Erased: OK

 time: 32.464 seconds
 device 0 whole chip
 SF: 16777216 bytes @ 0x0 Written: OK

 time: 15.515 seconds
 device 0 whole chip
 SF: 16777216 bytes @ 0x0 Read: OK

 time: 1.557 seconds
 Total of 16777216 byte(s) were the same

Changes in v3:
- Compile out the parallel code in spi_nor_erase() if the SPI_STACKED_PARALLEL
  is enabled.

Changes in v4:
- Update the bank calculation only when SPL_FLASH_BAR is enabled.

Changes in v5:
- Update the parallel code in the spi_nor_read() only if the SPI_STACKED_PARALLEL
  config is enabled.
---
 drivers/mtd/spi/spi-nor-core.c | 76 ++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13bd..2e41cf74430 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1130,17 +1130,19 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			goto erase_err;
 		}
 		offset = addr;
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			offset /= 2;
-
-		if (nor->flags & SNOR_F_HAS_STACKED) {
-			if (offset >= (mtd->size / 2))
-				nor->spi->flags |= SPI_XFER_U_PAGE;
-			else
-				nor->spi->flags &= ~SPI_XFER_U_PAGE;
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				offset /= 2;
+
+			if (nor->flags & SNOR_F_HAS_STACKED) {
+				if (offset >= (mtd->size / 2))
+					nor->spi->flags |= SPI_XFER_U_PAGE;
+				else
+					nor->spi->flags &= ~SPI_XFER_U_PAGE;
+			}
 		}
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
+		ret = write_bar(nor, offset);
 		if (ret < 0)
 			goto erase_err;
 #endif
@@ -1152,7 +1154,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
 		} else {
-			ret = spi_nor_erase_sector(nor, addr);
+			ret = spi_nor_erase_sector(nor, offset);
 		}
 		if (ret < 0)
 			goto erase_err;
@@ -1576,11 +1578,12 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
 	loff_t offset = from;
-	u32 read_len = 0;
 	u32 rem_bank_len = 0;
+	u32 stack_shift = 0;
+	size_t read_len;
 	u8 bank;
+	int ret;
 	bool is_ofst_odd = false;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
@@ -1593,35 +1596,48 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
+		read_len = len;
 		offset = from;
 
-		if (nor->flags & SNOR_F_HAS_STACKED) {
-			if (offset >= (mtd->size / 2)) {
-				offset = offset - (mtd->size / 2);
-				nor->spi->flags |= SPI_XFER_U_PAGE;
-			} else {
-				nor->spi->flags &= ~SPI_XFER_U_PAGE;
+		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
+			bank = (u32)from / SZ_16M;
+			if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+				if (nor->flags & SNOR_F_HAS_PARALLEL)
+					bank /= 2;
+			}
+			rem_bank_len = SZ_16M * (bank + 1);
+			if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+				if (nor->flags & SNOR_F_HAS_PARALLEL)
+					rem_bank_len *= 2;
 			}
+			rem_bank_len -= from;
 		}
 
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			offset /= 2;
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (nor->flags & SNOR_F_HAS_STACKED) {
+				stack_shift = 1;
+				if (offset >= (mtd->size / 2)) {
+					offset = offset - (mtd->size / 2);
+					nor->spi->flags |= SPI_XFER_U_PAGE;
+				} else {
+					nor->spi->flags &= ~SPI_XFER_U_PAGE;
+				}
+			}
+		}
+
+		if (nor->addr_width == 4)
+			rem_bank_len = (mtd->size >> stack_shift) - offset;
+
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				offset /= 2;
+		}
 
 #ifdef CONFIG_SPI_FLASH_BAR
 		ret = write_bar(nor, offset);
 		if (ret < 0)
 			return log_ret(ret);
 #endif
-
 		if (len < rem_bank_len)
 			read_len = len;
 		else
-- 
2.34.1

