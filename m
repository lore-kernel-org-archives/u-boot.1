Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F30BE77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 07:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47581804CE;
	Mon, 30 Dec 2024 08:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKflBD8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF42A804CE; Mon, 30 Dec 2024 08:03:24 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBDD8021A
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 08:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNDLavLaQuWuQlUp543WqKMVMJFP1jYS8hKO/0P2wH9o+tYlRJ7rmuVYrMcDT7LAaLhiGB54QEwWv6LR3t9itJI1/7vBwiLFfuHIO8oVB9o2gXkq+FCDUiIbBsvrLrmbsdyd9ZW0/xE7c9ZFmNfbaN4x/ik+wqH5IJBRD0OzXqphc+Q228fHiURpcD1xddMwiQl78g9rGFJJSq59J8WFF1xM9qcyPTeXm5pFSSWBx77zWgFdpmqb1OxYgHAMFlIf0OB1NsWfw+03IPqwYaSUOeXVwLBRSyXSedE4Gq3ZmZ3nKVywq+h0O1QzTR8I3aGN/c/jTQkGQ8NkDgvXlIVhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCcblFkeq6NyGEZlJz1Aiqd3rdF0J3B7M9lrmnp3nK4=;
 b=GXuSds+8E/tC9swShTDNjrUcakNgXbrIUt7Gm1g6S8im6yiBOKUUXWdqywVcoY3Rqkg3ISsl2eIPxOrLoDdPRjnB0NCNmDteSjSwU9Pl2+TJ5NXi+fsp+w+2dR71XeKD0gzlIWPkM+KeUDsL2767o4i7XCYIwetaE9ugdgskeUSUIKYndH/zToKDm8hbJ6r4Z808wP+56J6Fwy1UmdhjgSzpHneQTEZ/bMEzEd9Qht+7iLYYXlAzNai5L5N/5gp9nqidRNn/jdvzj2IIZCAoHZfDCKIRwPdWxLUGPh9SiioC8ftng1UD8du7r05CvgHb0iiOYtxNcoPS/P3CTA8lCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCcblFkeq6NyGEZlJz1Aiqd3rdF0J3B7M9lrmnp3nK4=;
 b=GKflBD8w1ndKMGAHSmOwd8iPKE776kkXgSyNeXrLtF1KxZ8HmygmxHv19Qhw/Wvuc3URb80wDofb7Y9cujladJeXF6v4M12RzFVlpowVW23i+q+gi+6raclOdgJm0WJrQZuRQxT9pvIX9aM56V82M16O45aBAEsK9zfEnVW8vYo=
Received: from SN7PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:f2::17)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 07:03:13 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::f0) by SN7PR04CA0012.outlook.office365.com
 (2603:10b6:806:f2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 07:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 30 Dec 2024 07:03:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 01:03:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 01:02:23 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 01:02:18 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v6] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Date: Mon, 30 Dec 2024 12:32:06 +0530
Message-ID: <20241230070206.2178551-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bc6fb9-4462-4b46-efde-08dd28a006df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NscTp+iR3PcV4Rbmqrp0rJiAPu2EOzh2z8n/RWbEPygh951+IXwUzFilYmvY?=
 =?us-ascii?Q?n4LN9ouqS7W/rl2HZBI5DittqNPfdtgLL7xktcxmkZsGu7zVGq4ygw6K8ZuM?=
 =?us-ascii?Q?TOUf9LrF4sOjumrL1HoTWwMMoYzNEObp1djGrqiHYJ8/1t3cPWRn3SnOtIsv?=
 =?us-ascii?Q?xYN6n88YPRj6qWrr02Ra3GWvwRPp9lIpzNEQudpbiJ4dEei8OihoYbeBSndH?=
 =?us-ascii?Q?/N0aNL58CqK8dzdRjkIhklVD6yG7OttS2BjW1VcV0VenHtpgBOy7gUb9rDKK?=
 =?us-ascii?Q?9PJdz2ilxCN1LBbfH6nLbPOB1+fvcbtslNG2bvuVAU/L/0/hCdKjS/huWhRJ?=
 =?us-ascii?Q?F7bJ1AcFEx5lpqUZ0KUb+IZYBjlkqCL0wpkjzbZxbR0/estri6sZXgKJQCoF?=
 =?us-ascii?Q?qk7fBw+ZqYyissuHKIeeTYrafXZmh6nP6YrnMPaEKhlt2oVwZPETIOl8lGP2?=
 =?us-ascii?Q?wVpxGXjlyrgTdBvcOy4N89av2nBGUB04l+hQI6qZwgUqMxJS1KbGTILUf7lP?=
 =?us-ascii?Q?7EnrXh/gfJ/xewIa9V8csDaOaPxnYHMOtWW6iY6JcZyJOR+whSMf/Tb4sL4u?=
 =?us-ascii?Q?dPwh9LEj7m1x8m4rS1cYH4zq6JdLPfK54TtUcfImbfivoQeDTd64v0aH2uXP?=
 =?us-ascii?Q?cdChsUUTj+CSusETS8XvBG/O270kMZnxpPoPRzcpesG7N1RGus7IqPd3PFRy?=
 =?us-ascii?Q?irQ3ZgFtaWMR1OIGhrjXhch0sgf4Pi5nZxn4WyDTvY+0Ip5RI+V70M+DqBWY?=
 =?us-ascii?Q?f0sqNzC8k4Ai+mSkCj6PukLpkVMgrsEIaDigiM8i+/PNLCZ+lxrTgK0bheAA?=
 =?us-ascii?Q?uyjwGpKPKo9LWmVo2IEMW+wNb8QX1XVjqE8svJt+Jk2KFpb6rSNcFAP0Nufp?=
 =?us-ascii?Q?zxcfEjpJztUjkVqBmvv75c2VkoCV54kWX/EQWq/8AVRD5yJKM2lRAx9YxqW8?=
 =?us-ascii?Q?AJedAV71wKBC8xO6c7klFxHRyT1khR5GxPkBns9a3ltqiQTGsuUzudPS9esP?=
 =?us-ascii?Q?9XNUmRTMvajwnY2Ik70SXRtv9BucwsTAhK4YLP6ofWaQiB2oOkcTCpKWAJzj?=
 =?us-ascii?Q?stVJhc6S37i1POlTWSXlmBGckLWqJxX0hdi3v26o5VILO1b0wwryKwFLpwGG?=
 =?us-ascii?Q?lt4ginwSLfskBX0hzajh4RZdCIVl5ryiJahAkquWRYmgPunL2LObUVBQ+sux?=
 =?us-ascii?Q?WgsKnejvavT/rAaGfQLrCpZaPEtp9OGWa1RA57/FsOPublKije5XGIgVmoEn?=
 =?us-ascii?Q?aJYuMFG0pQpTeMmMOCyQ61JwG0oUcqvssB693c7dS3XDF9NelzZa3LbKHrs1?=
 =?us-ascii?Q?9C0PcV+WUqyAVq6noUIv02XbrsJCWeOkxP4yZ9JvR69RhZBPJOnBIhe0nNMr?=
 =?us-ascii?Q?gwKI4hBcZ0Z4KH552VLd3x/lYGLwVViG9sHPbicKU1Z73SWshpgvs3+Wc29F?=
 =?us-ascii?Q?LHYBsW52K0zYm4URJ3sqaxNJOcLG6kdhtJHvTqYEqSa94DOHAVMvLPRuiN90?=
 =?us-ascii?Q?tOKdKTwHv2QTBsY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 07:03:13.0914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc6fb9-4462-4b46-efde-08dd28a006df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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
length to the read function.

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

Changes in v6:
- Remove the hardcoded address width for 4byte.
- Move the length condition with rem_bank_len under SPI_FLASH_BAR flag.
---
 drivers/mtd/spi/spi-nor-core.c | 75 ++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13bd..6f352c5c0e2 100644
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
@@ -1593,39 +1596,49 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				offset /= 2;
+		}
 
 #ifdef CONFIG_SPI_FLASH_BAR
 		ret = write_bar(nor, offset);
 		if (ret < 0)
 			return log_ret(ret);
-#endif
-
 		if (len < rem_bank_len)
 			read_len = len;
 		else
 			read_len = rem_bank_len;
+#endif
 
 		if (read_len == 0)
 			return -EIO;
-- 
2.34.1

