Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E6EE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CB1801BF;
	Wed, 11 Dec 2024 13:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpFebim5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCAC6801C3; Wed, 11 Dec 2024 13:07:06 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285F1801BE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpoaUTo1QnvQAPoD1Df0drnP00MNZLHLPDUxIKnq4PywiKbtd9wHuR5aIQqXfnCWIzGOhh0Vj2kgKLiiCzEo0UQ183rZ1EAAo/Ie5F83avg/eeUt128f0SrHDfe22NntFmfMX1ryoAXUy6AoZz4zAO+Kcpkt5H+ZBKJndQZjex75YldrN/2p6YfBo4xgsJf/rc45EZvZ14BJTRSsmYHqg/A21870XSO4mPijsMnkQG5UpVUKOdtuXazlwGvg/XWc6wDLugKZzsZU0/Hxj3ocONSI8nWMxhv77KYr53dxic0oyO43J4OgHzMGwUs3LImkz/zKYFw6mPMBrFLZCJtjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAHfBvK9L/G+AnhcF17n1gR9rgfZ0eCDC6ufcLA6XkM=;
 b=fpYaRI2zm91y0qtzo3BaNL3m6bD9ZKOHCXCkENMC3WaB3LgHGw1iJHJnztIcwXtlpIb93xuHZ+03+z9i7R8o0sv2dl2V8wd6BEuYavtdDFvDxBaaJ+gD4I0AXGctlf0LWuCT7WP9oKreN8MNF8lkBb06B+UVC8dgKBopmvw25artWRCxG22ypztTafoyj0DRcbpvq2hKsoubQ7krVfuWH0YQcz9b4sGN1lvOMdIGOe72L3x/1ubfgZ4AsTlSB3si57uGFTE+IPaKAwebIhSmRWV4Ap3CmCMcCQY0fRWTmLpIMURMK77iaDzTlUFbL6ENVDo6L17OXiwevv1TwZ311w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAHfBvK9L/G+AnhcF17n1gR9rgfZ0eCDC6ufcLA6XkM=;
 b=jpFebim5kunF7B0qbroE9GK5HxBVWuaSNVjbmBm3rQNSNZdi6sN0ly0P7Ayfy2pRpkHfcP7ZnSsH5imlWKn2gORnOcb0Rn/RoM7jKaXfEdyqZRWKDd8trFLqXahPd36mAIoBN1L11e2AplVGc1etsyJfG+9PIAIYiMs3xwb24Gc=
Received: from PH0PR07CA0082.namprd07.prod.outlook.com (2603:10b6:510:f::27)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 12:06:58 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::6e) by PH0PR07CA0082.outlook.office365.com
 (2603:10b6:510:f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 12:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:06:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:06:55 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 06:06:51 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Date: Wed, 11 Dec 2024 17:36:44 +0530
Message-ID: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 26889709-036c-493c-7fd0-08dd19dc4f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FVTH/j2Semi7d+a8/kypBRQvlXsOHHXSZzEWBa257kbxwm0apgUDODT//2Hb?=
 =?us-ascii?Q?P8EvZrAkV7mv44huIgHv8vJP5vgxDT4JHowmwHpsnbWNz0rLSGwTr1xep/km?=
 =?us-ascii?Q?jLFNldBW8D4kWjINPdIBFZZRwKw8Y9qBS973PgccBkSOfV3oVEdRGMCJeK8F?=
 =?us-ascii?Q?iT5h3tpMMA67/Fwjz+sb7Bs4Fm6T5UlEqwx6uuK4PtTGMImFGBX1WTZn6md2?=
 =?us-ascii?Q?cf4nItob6TR0HIeyIpxwlK5NtLFmjjoUSMjJdRq2tQWxaQBkDKj7TYwuBYBl?=
 =?us-ascii?Q?fIHqMPDiSW1xksydhPWrlZ3mOgTSEskR6gBjhDSXwD1fmH4v/lYjDcA2oaOX?=
 =?us-ascii?Q?YVi8gn+JF8LUWhbDox9zyoRqArihPD54S6BJXyNefLLG//jFLE+KFqevu9on?=
 =?us-ascii?Q?dxR/nZqAXHKWIM1Cs7P5UN+7IrRJHSmpnAqyNtAG8ZW0awBgReC+WhNSPXST?=
 =?us-ascii?Q?WFpTe6oK9ON9et/ca9nnmp547ZylpTqh1LsC//yZRxP87dap1JzZ0J4/ivlt?=
 =?us-ascii?Q?uMkOuxGAU2mWOVOEBCM45JhaaThwNYPB9oDJ/BvL5EXFljRqjeomNB2FyJxd?=
 =?us-ascii?Q?IDX3p043qRHzscgPpjgGRsVLMUJCmjCjcnvGTPEOc2PDxP7KV5FruX2FC/xW?=
 =?us-ascii?Q?dmW70eOXyPCECWIaIZX5DICYX06eoC/HCrv4DKvzpzytlCx9x++nyt9a/zqz?=
 =?us-ascii?Q?oryBdhSp82UIAeipHoiWDC+Von7jODCtGnBpYAE1DXKf7+z036ZFPOq70Nni?=
 =?us-ascii?Q?3OeDhNKwsBehprjEgAa1z6x9VoAnsaVtOSGwTCJKzY7DHFiIePFG3Y7LOVmu?=
 =?us-ascii?Q?RQFVjABf84sWTZLVytq0Put7+51l+aHFMm2XQMaJUeSXMBQYDavFc5/Gg03U?=
 =?us-ascii?Q?tvKkWmCN5/CBli+cPBt9eDmoIIxvjSMwb+/e+kx3bR9OhGb9SSSgXvpGR++h?=
 =?us-ascii?Q?9HDfhN16TNvA0YwVnnUtYjmeA434f8uFQOMs2FirEVvaolY751WrCbqZAxNI?=
 =?us-ascii?Q?uTWuN+QoB35AjmGeMwgRcrbT0leQsr6Fcz/PU6pMD1N8szm1gLrPZT5z5MD0?=
 =?us-ascii?Q?twqhq/LsuTTGUO0+rHU7rAMOaHv8gXW+9FM27ma08qsBfitrqKjqY4SBV5Mi?=
 =?us-ascii?Q?Ij2DjfPScUVtYItu5BoylkaX6NlvDGQ/NvZo9wJxZzVZZoVKhynCx7dTNa5X?=
 =?us-ascii?Q?5/Uh8d1ZWwk4cY1fD/7+5Jv+NwnK8rp1yW6GQJ2xKOufJSbbdI7fAQ1xPI4n?=
 =?us-ascii?Q?mpdLJkT5dl2dKbdgqvG+V7dyrt6JNAMfXCSt7X58f/gs/C9tAiDdjRzBsv9y?=
 =?us-ascii?Q?/GHvKXRxDWhqEu2hY1e/ht1JNJJ2L6SfmSOmlg2ZbyVvYDZC7RGbfs6riHl5?=
 =?us-ascii?Q?ftciLx//EkEaPD4yLtiKHWS8jXzDAQCVAfyi8Cw6vQa1PSpFM2qO6MjfWaQw?=
 =?us-ascii?Q?PA/xa9yhGu6mZl7tQakBSLBKV3fOGoVh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:06:57.2206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26889709-036c-493c-7fd0-08dd19dc4f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

Update the spi_nor_read() function only for parallel configuration
when config SPI_STACKED_PARALLEL is enabled and keep the default
code as is. For parallel configurations fix the read issue for
4byte address width by passing the entire length to the read
function, split the memory of 16MB size banks only when the
address width is 3byte. Also update the size when the
configuration is stacked.

Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Update the nor read for parallel configuration and for other case
  keep the code as is.
- Fixed the commit description.
- Tested the changes with s25fl128s flash
Zynq> sf probe 0 0 0
SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB, total 16 MiB
Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;time sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;time sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
SF: 16777216 bytes @ 0x0 Erased: OK

time: 32.464 seconds
device 0 whole chip
SF: 16777216 bytes @ 0x0 Written: OK

time: 15.515 seconds
device 0 whole chip
SF: 16777216 bytes @ 0x0 Read: OK

time: 1.557 seconds
Total of 16777216 byte(s) were the same
---
 drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..8d7087b5c9 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1140,7 +1140,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 				nor->spi->flags &= ~SPI_XFER_U_PAGE;
 		}
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
+		ret = write_bar(nor, offset);
 		if (ret < 0)
 			goto erase_err;
 #endif
@@ -1152,7 +1152,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
 		} else {
-			ret = spi_nor_erase_sector(nor, addr);
+			ret = spi_nor_erase_sector(nor, offset);
 		}
 		if (ret < 0)
 			goto erase_err;
@@ -1578,8 +1578,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 	loff_t offset = from;
-	u32 read_len = 0;
 	u32 rem_bank_len = 0;
+	u32 stack_shift = 0;
 	u8 bank;
 	bool is_ofst_odd = false;
 
@@ -1593,18 +1593,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
+		size_t read_len = len;
 		offset = from;
 
+	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
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
+
 		if (nor->flags & SNOR_F_HAS_STACKED) {
+			stack_shift = 1;
 			if (offset >= (mtd->size / 2)) {
 				offset = offset - (mtd->size / 2);
 				nor->spi->flags |= SPI_XFER_U_PAGE;
@@ -1613,20 +1618,31 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			}
 		}
 
+		if (nor->addr_width == 4)
+			rem_bank_len = (mtd->size >> stack_shift) - offset;
+
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
+	}
 
 #ifdef CONFIG_SPI_FLASH_BAR
+		u32 remain_len;
+
 		ret = write_bar(nor, offset);
 		if (ret < 0)
 			return log_ret(ret);
-#endif
-
-		if (len < rem_bank_len)
+		remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
+		if (len < remain_len)
 			read_len = len;
 		else
-			read_len = rem_bank_len;
-
+			read_len = remain_len;
+#endif
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (len < rem_bank_len)
+				read_len = len;
+			else
+				read_len = rem_bank_len;
+		}
 		if (read_len == 0)
 			return -EIO;
 
-- 
2.34.1

