Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0B5CCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574F88857C;
	Thu, 26 Sep 2024 06:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdpAqQNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F5988CE5; Thu, 26 Sep 2024 06:55:37 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5AC88C94
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOl406QZyNHqthywrDZn4OVMO50dc//3canVYN87RLxiZc2vzGyeW0zIG4mL/GS3JfsXeUg6WQjD9SPsVB9c6xwDsoxelA979Q2bcYh4vXU05l3fOMJxpyMqEcMg8i8kxzQxCqKkOSS1jXT3kge8SLuh7j5ganLJGNJpmrE4FJXCLEgghFh8Sva7g49zf203KO7/b2OlVwLSVgkP/d1QgOYpoxol2hqtZMBxXqxAbKP1Z4nG1p7+WeMUm12oTGUDXJp5dUGCgNafA8Sxc+FU/TNdzGMxkafIBccJdwE5EOVfN4Q359wyBuxCqFR9UhXnTRMi803dn/P+GiwycO2eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4g0lRDhsrFnyGcUCKaLDsQNU0Qm8TpFqqHz+dUUYT4=;
 b=pTTFuTTeNaRY29aCnBMIP71+wl8wNMEXxQJa3mC12F3IA+BTjfeOWB9X/hhu53SmjDPAmBu7cjepmuArdi2N+nlWJTtxFNXulCnvJpBCtOtBnCPK/LnhPaIUSPkl7pZfzoSBO/ix9qEBSpY/yEZfsItZcKfrCydk8DUn+nvNv3coJuC61b4ELxqgAsmYGXpZ8F1rhPmtEgBq8VVrxVe5ki9UH1Pg7NzHZF0q0vaJG2PVENyUUESa1vepbXBHF18b30y1xvSs/YMOhA8VII+tH1TYfzmQOxJPB+xnkud00pq8QLNS7QDbgRqjVzXERnsGJJ9+meE3EFXOSm6eWf08bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4g0lRDhsrFnyGcUCKaLDsQNU0Qm8TpFqqHz+dUUYT4=;
 b=XdpAqQNHcINdi09mpyBMOW+TnrqOWeO5CWL69NRZUeWlmKz3bMEpbRA7ckLR5jFXrHJ1H2vrIq8p1aQq/CYrJBsg2Op4bMOmqjTMtOy/uWI65c63T8dJtMh9DtnoeaKY9MagCaliNzkogJ++01ujA1YnlrMYdN0bjIXEIfBE7T0=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Thu, 26 Sep 2024 04:55:23 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::3d) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:21 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:19 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v14 2/8] mtd: spi-nor: Add parallel and stacked memories
 support
Date: Thu, 26 Sep 2024 10:25:02 +0530
Message-ID: <20240926045508.1492638-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6d2ab5-3b43-4217-3efe-08dcdde76e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7xiryiAQfLTXSOJQv6bB11PGKQTg1A/lH09Hf3HUdrtumXOepUxuZziErbPB?=
 =?us-ascii?Q?4QkR4N3adyVdOwDeeKKcNzXhDfDEflA/p5Y8xzuoxOUaDA9JFq/EtmCpu994?=
 =?us-ascii?Q?q66qifsd+BCzJvy9PTcuwQ0S4ymqcE6zpx55LzEiegzsUwO+Wt1kUP/JccBV?=
 =?us-ascii?Q?LugL0xwOZ+4fXlKZ26k/0nS5uyrs+NUBALWWYxQgAUfnohi6HsEmgUSQON+j?=
 =?us-ascii?Q?48HfnQsa9WXZPbTSYMn7a4HFxHQ2ocQPTgNIdMzuFKdv6ht095a6muxfelQj?=
 =?us-ascii?Q?Pp7s274hO1yUSMCoiOL0ICnv4k5/PeCV5U3hXBiBEjCVu7vY1DaZfcaLlcD+?=
 =?us-ascii?Q?+eZ4pEYeAicBxCIz98xjG310mVLFBbEVmGOAx/XbvM8r/LoM8Wof5jUJDaZZ?=
 =?us-ascii?Q?2bTdQtRbj7z1Ytuv/JaHHcTYBgReWHRbIcnCLOzZHmqhx4QYTpfVkq8ao5UL?=
 =?us-ascii?Q?DI6zZo3Fh5GL7a0j2oj95qlCwh6wWUft5HyaoiInAkow3rJVubq/K0OR3zBy?=
 =?us-ascii?Q?OLxZHlDigvHHDmTTynOqJE/ZpH+bMFJK/gEJvgQY9+6/fIfh7p6XtCrGhoAy?=
 =?us-ascii?Q?kX5adkWYS2T3JpOXP1V3cyQsH7A71PQzP9w1rtc1dwY2ffMVF567sNig3Tru?=
 =?us-ascii?Q?Kbuw3AToD1PVlSVcdtVUGFLxmP864k2BanEtC+Bt9XRFAcdXCQdJOzsbmAej?=
 =?us-ascii?Q?h8z2QmCREH9QLr8I/wm/rLsoCY5l3A/6XMMzoA4QIuqxOC5Ut1PBOx4wfyga?=
 =?us-ascii?Q?B6MwA+JNM2BbjpNyY3A8RMYK0pPHb9wPZX3wO0nWvoZCp7SSNPWgw6G1Upx0?=
 =?us-ascii?Q?eI9AZlTJOvLRncRiDt+ccPSRnyznwfJXrVv7o7h3NpViBGK9G7pEIQl6BhkS?=
 =?us-ascii?Q?+5cTtC7HOznBc9IJC9gYjD/enK8+AR5L5fc3lWo0XxZw+t7Sfpp2azmUyrOo?=
 =?us-ascii?Q?JBXJzuzpYVe9xyEzH9CXgAg4oVj7AxlcGdCfh32YhBMKUxvziMAb9U2i3FSx?=
 =?us-ascii?Q?nUdx7VX/1LTbr6P/wM0YjbT2MpjU5JrwsgZK00H3CFe1ddQMlShhaR0JEMqG?=
 =?us-ascii?Q?mpo6FTU6wPSTABAabKR3hYrC6EKkLrNiuXZoWQMLjKUNoeJQldh4Fq69D5lm?=
 =?us-ascii?Q?/GcvykVtw9TubE/GQXwTT9PBf4y3WKJ31b/lR5gqwwYBsmbMcquy5EjMuK0w?=
 =?us-ascii?Q?0xfHPnEMNe624wUeV71uXW42UHNlNqTFI3Tj3ywQJXdzEDez7dAUpmFc6vdt?=
 =?us-ascii?Q?nlKANLo7aBwDYpRlJfvU6y3qWEDcb1psgovVmNVH2vblyWJy/3sPTSkO+FTP?=
 =?us-ascii?Q?YauOvfAHVsQ4WaNpXmSUC8iSml5I1bUQF/Kz6EMqu95N14lAexOHSuk+bTu0?=
 =?us-ascii?Q?WglkId8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:23.4906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6d2ab5-3b43-4217-3efe-08dcdde76e36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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

In parallel mode, the current implementation assumes that a maximum of
two flashes are connected. The QSPI controller splits the data evenly
between both the flashes so, both the flashes that are connected in
parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->flags.

In stacked mode the current implementation assumes that a maximum of two
flashes are connected and both the flashes are of same make but can
differ in sizes. So, except the sizes all other flash parameters of both
the flashes are identical

Spi-nor will pass on the appropriate flash select flag to low level
driver, and it will select pass all the data to that particular flash.

Write operation in parallel mode are performed in page size * 2 chunks as
each write operation results in writing both the flashes. For doubling
the address space each operation is performed at addr/2 flash offset,
where addr is the address specified by the user.

Similarly for read and erase operations it will read from both flashes,
so size and offset are divided by 2 and send to flash.

Adding the config option SPI_ADVANCE for non SPL code.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 299 +++++++++++++++++++++++++++++----
 drivers/spi/Kconfig            |   6 +
 include/linux/mtd/spi-nor.h    |  17 ++
 include/spi.h                  |  11 ++
 4 files changed, 300 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8f7a77e716..8ba3a9bd60 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -668,12 +668,17 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
 static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
 				      const struct flash_info *info)
 {
+	bool shift = 0;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		shift = 1;
+
 	/* Do some manufacturer fixups first */
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_SPANSION:
 		/* No small sector erase for 4-byte command set */
 		nor->erase_opcode = SPINOR_OP_SE;
-		nor->mtd.erasesize = info->sector_size;
+		nor->mtd.erasesize = info->sector_size << shift;
 		break;
 
 	default:
@@ -1008,8 +1013,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	u32 addr, len, rem, offset, max_size;
 	bool addr_known = false;
-	u32 addr, len, rem, max_size;
 	int ret, err;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
@@ -1035,6 +1040,18 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			ret = -EINTR;
 			goto erase_err;
 		}
+		offset = addr;
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			offset /= 2;
+
+		if (nor->flags & SNOR_F_HAS_STACKED) {
+			if (offset >= (mtd->size / 2)) {
+				offset = offset - (mtd->size / 2);
+				nor->spi->flags |= SPI_XFER_U_PAGE;
+			} else {
+				nor->spi->flags &= ~SPI_XFER_U_PAGE;
+			}
+		}
 #ifdef CONFIG_SPI_FLASH_BAR
 		ret = write_bar(nor, addr);
 		if (ret < 0)
@@ -1446,6 +1463,9 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 	u8			id[SPI_NOR_MAX_ID_LEN];
 	const struct flash_info	*info;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
 	if (tmp < 0) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
@@ -1470,28 +1490,67 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
+	loff_t offset = from;
+	u32 read_len = 0;
+	u32 rem_bank_len = 0;
+	u8 bank;
+	bool is_ofst_odd = false;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
+	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
+	    /* We can hit this case when we use file system like ubifs */
+		from--;
+		len++;
+		is_ofst_odd = true;
+	}
+
 	while (len) {
-		loff_t addr = from;
-		size_t read_len = len;
+		if (nor->addr_width == 3) {
+			if (nor->flags & SNOR_F_HAS_PARALLEL) {
+				bank = (u32)from / (SZ_16M << 0x01);
+				rem_bank_len = ((SZ_16M << 0x01) *
+					(bank + 1)) - from;
+			} else {
+				bank = (u32)from / SZ_16M;
+				rem_bank_len = (SZ_16M * (bank + 1)) - from;
+			}
+		}
+		offset = from;
 
-#ifdef CONFIG_SPI_FLASH_BAR
-		u32 remain_len;
+		if (nor->flags & SNOR_F_HAS_STACKED) {
+			if (offset >= (mtd->size / 2)) {
+				offset = offset - (mtd->size / 2);
+				nor->spi->flags |= SPI_XFER_U_PAGE;
+			} else {
+				nor->spi->flags &= ~SPI_XFER_U_PAGE;
+			}
+		}
 
-		ret = write_bar(nor, addr);
-		if (ret < 0)
-			return log_ret(ret);
-		remain_len = (SZ_16M * (nor->bank_curr + 1)) - addr;
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			offset /= 2;
 
-		if (len < remain_len)
+		if (nor->addr_width == 3) {
+#ifdef CONFIG_SPI_FLASH_BAR
+			ret = write_bar(nor, offset);
+			if (ret < 0)
+				return log_ret(ret);
+#endif
+		}
+
+		if (len < rem_bank_len)
 			read_len = len;
 		else
-			read_len = remain_len;
-#endif
+			read_len = rem_bank_len;
+
+		if (read_len == 0)
+			return -EIO;
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto read_err;
 
-		ret = nor->read(nor, addr, read_len, buf);
+		ret = nor->read(nor, offset, read_len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1500,8 +1559,15 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (ret < 0)
 			goto read_err;
 
-		*retlen += ret;
-		buf += ret;
+		if (is_ofst_odd == true) {
+			memmove(buf, (buf + 1), (len - 1));
+			*retlen += (ret - 1);
+			buf += ret - 1;
+			is_ofst_odd = false;
+		} else {
+			*retlen += ret;
+			buf += ret;
+		}
 		from += ret;
 		len -= ret;
 	}
@@ -1796,6 +1862,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	size_t page_offset, page_remain, i;
 	ssize_t ret;
+	u32 offset;
 
 #ifdef CONFIG_SPI_FLASH_SST
 	/* sst nor chips use AAI word program */
@@ -1805,6 +1872,27 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
 
+	if (!len)
+		return 0;
+
+	/*
+	 * Cannot write to odd offset in parallel mode,
+	 * so write 2 bytes first
+	 */
+	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (to & 1)) {
+		u8 two[2] = {0xff, buf[0]};
+		size_t local_retlen;
+
+		ret = spi_nor_write(mtd, to & ~1, 2, &local_retlen, two);
+		if (ret < 0)
+			return ret;
+
+		*retlen += 1; /* We've written only one actual byte */
+		++buf;
+		--len;
+		++to;
+	}
+
 	for (i = 0; i < len; ) {
 		ssize_t written;
 		loff_t addr = to + i;
@@ -1822,18 +1910,35 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 			page_offset = do_div(aux, nor->page_size);
 		}
+		offset = (to + i);
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			offset /= 2;
+
+		if (nor->flags & SNOR_F_HAS_STACKED) {
+			if (offset >= (mtd->size / 2)) {
+				offset = offset - (mtd->size / 2);
+				nor->spi->flags |= SPI_XFER_U_PAGE;
+			} else {
+				nor->spi->flags &= ~SPI_XFER_U_PAGE;
+			}
+		}
+
+		if (nor->addr_width == 3) {
+#ifdef CONFIG_SPI_FLASH_BAR
+			ret = write_bar(nor, offset);
+			if (ret < 0)
+				return ret;
+#endif
+		}
 		/* the size of data remaining on the first page */
 		page_remain = min_t(size_t,
 				    nor->page_size - page_offset, len - i);
 
-#ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
-		if (ret < 0)
-			return ret;
-#endif
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto write_err;
 
 		write_enable(nor);
-
 		/*
 		 * On DTR capable flashes like Micron Xcella the writes cannot
 		 * start or end at an odd address in DTR mode. So we need to
@@ -1841,7 +1946,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		 * address and end address are even.
 		 */
 		if (spi_nor_protocol_is_dtr(nor->write_proto) &&
-		    ((addr | page_remain) & 1)) {
+		    ((offset | page_remain) & 1)) {
 			u_char *tmp;
 			size_t extra_bytes = 0;
 
@@ -1852,10 +1957,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			}
 
 			/* Prepend a 0xff byte if the start address is odd. */
-			if (addr & 1) {
+			if (offset & 1) {
 				tmp[0] = 0xff;
 				memcpy(tmp + 1, buf + i, page_remain);
-				addr--;
+				offset--;
 				page_remain++;
 				extra_bytes++;
 			} else {
@@ -1863,13 +1968,13 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			}
 
 			/* Append a 0xff byte if the end address is odd. */
-			if ((addr + page_remain) & 1) {
+			if ((offset + page_remain) & 1) {
 				tmp[page_remain + extra_bytes] = 0xff;
 				extra_bytes++;
 				page_remain++;
 			}
 
-			ret = nor->write(nor, addr, page_remain, tmp);
+			ret = nor->write(nor, offset, page_remain, tmp);
 
 			kfree(tmp);
 
@@ -1882,7 +1987,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			 */
 			written = ret - extra_bytes;
 		} else {
-			ret = nor->write(nor, addr, page_remain, buf + i);
+			ret = nor->write(nor, offset, page_remain, buf + i);
 			if (ret < 0)
 				goto write_err;
 			written = ret;
@@ -1891,6 +1996,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto write_err;
+
+		ret = write_disable(nor);
+		if (ret)
+			goto write_err;
+
 		*retlen += written;
 		i += written;
 	}
@@ -1931,6 +2041,10 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
 	ret = read_sr(nor);
 	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
 		dev_err(nor->dev, "Macronix Quad bit not set\n");
@@ -1992,7 +2106,7 @@ static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
 		return -EINVAL;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 #endif
 
@@ -2168,6 +2282,10 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 	nor->read_dummy = 8;
 
 	while (len) {
+		/* Both chips are identical, so should be the SFDP data */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			nor->spi->flags |= SPI_XFER_LOWER;
+
 		ret = nor->read(nor, addr, len, (u8 *)buf);
 		if (!ret || ret > len) {
 			ret = -EIO;
@@ -2862,6 +2980,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       const struct flash_info *info,
 			       struct spi_nor_flash_parameter *params)
 {
+#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
+	struct udevice *dev = nor->spi->dev;
+	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
+	u32 idx = 0, i = 0;
+	int rc;
+#endif
+
 	/* Set legacy flash parameters as default. */
 	memset(params, 0, sizeof(*params));
 
@@ -2979,7 +3104,62 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			memcpy(params, &sfdp_params, sizeof(*params));
 		}
 	}
+#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
+	/*
+	 * The flashes that are connected in stacked mode should be of same make.
+	 * Except the flash size all other properties are identical for all the
+	 * flashes connected in stacked mode.
+	 * The flashes that are connected in parallel mode should be identical.
+	 */
+	while (i < SNOR_FLASH_CNT_MAX) {
+		rc = ofnode_read_u64_index(dev_ofnode(dev), "stacked-memories",
+					   idx, &flash_size[i]);
+		if (rc == -EINVAL) {
+			break;
+		} else if (rc == -EOVERFLOW) {
+			idx++;
+		} else {
+			idx++;
+			i++;
+			if (!(nor->flags & SNOR_F_HAS_STACKED))
+				nor->flags |= SNOR_F_HAS_STACKED;
+			if (!(nor->spi->flags & SPI_XFER_STACKED))
+				nor->spi->flags |= SPI_XFER_STACKED;
+		}
+	}
+
+	i = 0;
+	idx = 0;
+	while (i < SNOR_FLASH_CNT_MAX) {
+		rc = ofnode_read_u64_index(dev_ofnode(dev), "parallel-memories",
+					   idx, &flash_size[i]);
+		if (rc == -EINVAL) {
+			break;
+		} else if (rc == -EOVERFLOW) {
+			idx++;
+		} else {
+			idx++;
+			i++;
+			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
+				nor->flags |= SNOR_F_HAS_PARALLEL;
+		}
+	}
 
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
+		params->size = 0;
+		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++)
+			params->size += flash_size[idx];
+	}
+	/*
+	 * In parallel-memories the erase operation is
+	 * performed on both the flashes simultaneously
+	 * so, double the erasesize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		nor->mtd.erasesize <<= 1;
+		params->page_size <<= 1;
+	}
+#endif
 	spi_nor_post_sfdp_fixups(nor, params);
 
 	return 0;
@@ -3294,16 +3474,54 @@ static int spi_nor_select_erase(struct spi_nor *nor,
 	/* prefer "small sector" erase if possible */
 	if (info->flags & SECT_4K) {
 		nor->erase_opcode = SPINOR_OP_BE_4K;
-		mtd->erasesize = 4096;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = 4096 * 2;
+		else
+			mtd->erasesize = 4096;
 	} else if (info->flags & SECT_4K_PMC) {
 		nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
-		mtd->erasesize = 4096;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = 4096 * 2;
+		else
+			mtd->erasesize = 4096;
 	} else
 #endif
 	{
 		nor->erase_opcode = SPINOR_OP_SE;
-		mtd->erasesize = info->sector_size;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = info->sector_size * 2;
+		else
+			mtd->erasesize = info->sector_size;
+	}
+
+	if ((JEDEC_MFR(info) == SNOR_MFR_SST) && info->flags & SECT_4K) {
+		nor->erase_opcode = SPINOR_OP_BE_4K;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = 4096 * 2;
+		else
+			mtd->erasesize = 4096;
 	}
+
 	return 0;
 }
 
@@ -3925,6 +4143,9 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_NOR_ENABLE_MULTI_CS;
+
 	err = spi_nor_octal_dtr_enable(nor);
 	if (err) {
 		dev_dbg(nor->dev, "Octal DTR mode not supported\n");
@@ -4091,6 +4312,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	struct spi_slave *spi = nor->spi;
 	int ret;
 	int cfi_mtd_nb = 0;
+	bool shift = 0;
 
 #ifdef CONFIG_FLASH_CFI_MTD
 	cfi_mtd_nb = CFI_FLASH_BANKS;
@@ -4228,7 +4450,9 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->addr_width = 3;
 	}
 
-	if (nor->addr_width == 3 && mtd->size > SZ_16M) {
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
+		shift = 1;
+	if (nor->addr_width == 3 && (mtd->size >> shift) > SZ_16M) {
 #ifndef CONFIG_SPI_FLASH_BAR
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
@@ -4238,6 +4462,7 @@ int spi_nor_scan(struct spi_nor *nor)
 #else
 	/* Configure the BAR - discover bank cmds and read current bank */
 	nor->addr_width = 3;
+	set_4byte(nor, info, 0);
 	ret = read_bar(nor, info);
 	if (ret < 0)
 		return ret;
@@ -4255,6 +4480,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	if (nor->flags & SNOR_F_HAS_STACKED) {
+		nor->spi->flags |= SPI_XFER_U_PAGE;
+		ret = spi_nor_init(nor);
+		if (ret)
+			return ret;
+		nor->spi->flags &= ~SPI_XFER_U_PAGE;
+	}
+
 	nor->rdsr_dummy = params.rdsr_dummy;
 	nor->rdsr_addr_nbytes = params.rdsr_addr_nbytes;
 	nor->name = info->name;
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd785aefd5..18dfd1796f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -20,6 +20,12 @@ menuconfig SPI
 
 if SPI
 
+config SPI_ADVANCE
+	bool "Enable the advance feature"
+	help
+	 Enable the SPI advance feature support. By default this is disabled.
+	 If you intend to use the advance feature support you should enable.
+
 config DM_SPI
 	bool "Enable Driver Model for SPI drivers"
 	depends on DM
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadb..d5f4faf0a6 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -13,6 +13,9 @@
 #include <linux/mtd/mtd.h>
 #include <spi-mem.h>
 
+/* In parallel configuration enable multiple CS */
+#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
+
 /*
  * Manufacturer IDs
  *
@@ -177,6 +180,12 @@
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/*
+ * Maximum number of flashes that can be connected
+ * in stacked/parallel configuration
+ */
+#define SNOR_FLASH_CNT_MAX	2
+
 /* For Cypress flash. */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
@@ -294,6 +303,13 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	= BIT(6),
 	SNOR_F_SOFT_RESET	= BIT(7),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
+#if defined(CONFIG_SPI_ADVANCE)
+	SNOR_F_HAS_STACKED	= BIT(9),
+	SNOR_F_HAS_PARALLEL	= BIT(10),
+#else
+	SNOR_F_HAS_STACKED	= 0,
+	SNOR_F_HAS_PARALLEL	= 0,
+#endif
 };
 
 struct spi_nor;
@@ -551,6 +567,7 @@ struct spi_nor {
 	u8			bank_read_cmd;
 	u8			bank_write_cmd;
 	u8			bank_curr;
+	u8			upage_prev;
 #endif
 	enum spi_nor_protocol	read_proto;
 	enum spi_nor_protocol	write_proto;
diff --git a/include/spi.h b/include/spi.h
index 9e9851284c..6e8e0cce7f 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -38,6 +38,15 @@
 
 #define SPI_DEFAULT_WORDLEN	8
 
+/* SPI transfer flags */
+#define SPI_XFER_STRIPE	(1 << 6)
+#define SPI_XFER_MASK	(3 << 8)
+#define SPI_XFER_LOWER	(1 << 8)
+#define SPI_XFER_UPPER	(2 << 8)
+
+/* Max no. of CS supported per spi device */
+#define SPI_CS_CNT_MAX	2
+
 /**
  * struct dm_spi_bus - SPI bus info
  *
@@ -155,6 +164,8 @@ struct spi_slave {
 #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
 #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
+#define SPI_XFER_U_PAGE		BIT(4)
+#define SPI_XFER_STACKED	BIT(5)
 };
 
 /**
-- 
2.25.1

