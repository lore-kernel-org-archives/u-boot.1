Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD73CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFF988A5D;
	Mon,  2 Sep 2024 12:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDv8qzNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D229D88785; Mon,  2 Sep 2024 12:27:30 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F44885B9
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0VFVJXgicm0r4+rVJlwSk+xf42T+WGMlcwlDK+Jat/R7nQq8yDRIdBnKzXdCDiSbU2Fzrf/K2MJvOi0d47ZglGifP9LemLTgLbRel5HXSv15k8tEen+qL+ATF3dRNBS/td7qz422VURVevt5Kl8pImygxu6de9SJasQluXh8UNNbkLcORpbogvZ5S93liCwBLOFWoIvZteM3SyxvObL6lroeLTFjlt4Hhc22FMI80TD87fpdNuW7FE4pYKPFBkYOy32madrOiXLWpWDnptio+v03+xwEAGncG1nxlQbH457MWy04yRFNM9rNTUxIWu92SvEgFf5gMiWsFGruSq8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPSOkNAoRYKDQ5ujMl1lLSL+AX7Pkde9kQGWwX/plZ8=;
 b=lv888rvmSzg/0XVd8yhjY0BnEW9toAYQLGc2bpz/DpkfaqNrRlov8pB/CEqA23Zb5O6I0mkKLxfVneFziziGvCOgEqT4USia/CCx0OvwCziX8rLgQcxEUGHOtK5L8JGAdwfNFrQp8HeSKiVgaKZDDhj4Ejuj4DDlq1kTJ59hdSejjAyGWDH0VHK6SgGKkyueiSGYK4twcYnyiUgfbSH40X0BOYkUTd5j/zUfpELFUF7OKjrCjTQ6QLWv2EJCAsi8x+0SnsVOjZsNvMNF+EL9qaOGFVrSmXT6js/2ygQ0s+qfx54UjVeFSIZWM/8ZxsKW7hcuS/2y2HNlkYOD5YnDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPSOkNAoRYKDQ5ujMl1lLSL+AX7Pkde9kQGWwX/plZ8=;
 b=eDv8qzNcwcAH2NNfltXycTKi6w6/kEr0vyiA2eu6Ri2lw5m/Uw5UOgEfDdv+n5e+AqioXLogoSHA+NoMBGF0EuJ7g5BB8/ysNQ4ho2oDHox5Lvk09AxZhuCY7Dkq4Koa0nlpFmQCj23eXv/JHkVnoN63wK+qTOOHdeHqUKm3zvc=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 2 Sep
 2024 10:27:20 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::3b) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:17 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:15 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v12 1/9] mtd: spi-nor: Add parallel and stacked memories
 support
Date: Mon, 2 Sep 2024 15:56:58 +0530
Message-ID: <20240902102706.1107-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 0799f999-a745-4605-5025-08dccb39d3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IdqtifuEda+Vy1OAu9R/h5oB/4wa0++tTPAYAR3oIoBV1HsMinZEar3iNNb0?=
 =?us-ascii?Q?nz1mf4SZlXb+hBxYl1Owjm75NxNP3HY0ZjB6uQq1gLJWuNQhe50kRd6u+Di1?=
 =?us-ascii?Q?Z7r0EaR2/VYjMPjTj+V4gbJ8yP8mSa1289pbp8+bjpM9mwTGfDRWYm0zobdr?=
 =?us-ascii?Q?SZ/KmSadRjBW01LrsazbvvU11QVRx5km6kFYha0+YhUT5zK8x9hwZU2uRsuA?=
 =?us-ascii?Q?J0yN1UbK06EY4B9B08cE+wKTvTs629JykQfsS1/Ef3Psy5tG4ZKLibXuSnKA?=
 =?us-ascii?Q?xryYYur9cBnBB50V/G4H/jUOZtjl4wITF+sEXhZLuPL8E0GgiQD7fF5x6TQd?=
 =?us-ascii?Q?nKPFg/8VKJ8Nb8tPwBHJ9liiA+7hRXRbUkuAT0gDpkWf9T1WTDpcYQFBPp7Y?=
 =?us-ascii?Q?AHd6nrNOyTTB/6X4DdvdE4aHzqd/gv6pdoEI6zf7ZmP1p7appgnSyHkKEBUk?=
 =?us-ascii?Q?+loOG8yuK3YsoSkrwNh9ZFhd4BAgO1UccEPtFyyZdi0/nKwcB03SWLUaWzji?=
 =?us-ascii?Q?eJB8s4wKGQs73GYuJzw6FHHg4YW5o1JlAFpIekZz6sFC/Yz0egLLobjg8TyG?=
 =?us-ascii?Q?6h+hntQCz/3W2eCTZO5MjL4DnOik05+k0qSkikWHP6nfaCx0kNs5YPHoMHgY?=
 =?us-ascii?Q?yq2jHWSIvIKu9KwGCZbyjTC+pQrA1rFnASmF8YP1TaceqK8ClHordt2qSw/0?=
 =?us-ascii?Q?po8KmlTHx/JHH1CJAoXfttvXLKMkioP6CYvtjlaCufMIGaj8hMJsyGFpLhFB?=
 =?us-ascii?Q?gW3q7wnmULuqTwhmuNe1jlAvJn62EOQBHxNZM2FCs2EaKyNQnm+xrJ4ARn8h?=
 =?us-ascii?Q?WLoVeIVxxw6BFO2DpWxyI+s5966Vlbq6GEnSkngOS/pE1cYOXJhknxoxk0Dq?=
 =?us-ascii?Q?11f/uJNO/pmPGRFluYinVr+ffaByL9wAw9rGusNZ7CKKXpfAgHciuQXBkqBb?=
 =?us-ascii?Q?epD73vx2v7yeXVObq/LxwpbMFeTJjmi6MSofilBhEXwrwInf9GmLs2voDjt7?=
 =?us-ascii?Q?4q0AYtDkCIhoqXLeWTZYLTup6g0Z5GvKua8xWvXwR3T6gqcusJ2mNy325a0u?=
 =?us-ascii?Q?vCzKWX5ATfJJr+uJ20etxrM6YkQEfq8Hr1J2QHO3KPQsAuFb/HmmEh/r1aPX?=
 =?us-ascii?Q?cnaH2JT6KtU3OOBXz264J/HaxQkYLfuG9bCirxHyce87D5iFMc1TiexPPruN?=
 =?us-ascii?Q?gWxF3+o2qeCyyMgZ2tmB5zpbhPyGIuHoJLz9R3K2Pm1Cx/UrHs+pKEDGuGgS?=
 =?us-ascii?Q?LKGL0lsld/Ztx691nUCsX8Cah2tNX7lH6lPNgjCWaD0uan6+7mj1AQdze/OM?=
 =?us-ascii?Q?TcxhghXGt2dEh814nEBJHUVsD7NMDjo9/uNAjavvr2jjgtqFC7jWqfieDi3M?=
 =?us-ascii?Q?hqPj6QbpbmJWXd4/Wt+U9at7b7asdsmkJvnKTsabTOw47LATWY9s2Po5ff53?=
 =?us-ascii?Q?nn8pGV5IOBxBpJhW/thM74Ii4AI7pAsQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:20.5262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0799f999-a745-4605-5025-08dccb39d3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 295 +++++++++++++++++++++++++++++----
 include/linux/mtd/spi-nor.h    |  12 ++
 include/spi.h                  |  11 ++
 3 files changed, 287 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index aea611fef5..afe6527a83 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -662,12 +662,17 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
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
@@ -988,8 +993,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	u32 addr, len, rem, offset;
 	bool addr_known = false;
-	u32 addr, len, rem;
 	int ret, err;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
@@ -1014,6 +1019,18 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
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
@@ -1419,6 +1436,9 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 	u8			id[SPI_NOR_MAX_ID_LEN];
 	const struct flash_info	*info;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
 	if (tmp < 0) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
@@ -1443,28 +1463,67 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			offset /= 2;
+
+		if (nor->addr_width == 3) {
+#ifdef CONFIG_SPI_FLASH_BAR
+		ret = write_bar(nor, offset);
 		if (ret < 0)
 			return log_ret(ret);
-		remain_len = (SZ_16M * (nor->bank_curr + 1)) - addr;
+#endif
+		}
 
-		if (len < remain_len)
+		if (len < rem_bank_len)
 			read_len = len;
 		else
-			read_len = remain_len;
-#endif
+			read_len = rem_bank_len;
 
-		ret = nor->read(nor, addr, read_len, buf);
+		if (read_len == 0)
+			return -EIO;
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto read_err;
+
+		ret = nor->read(nor, offset, read_len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1473,8 +1532,15 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
@@ -1769,6 +1835,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	size_t page_offset, page_remain, i;
 	ssize_t ret;
+	u32 offset;
 
 #ifdef CONFIG_SPI_FLASH_SST
 	/* sst nor chips use AAI word program */
@@ -1778,6 +1845,27 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
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
@@ -1795,18 +1883,35 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
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
@@ -1814,7 +1919,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		 * address and end address are even.
 		 */
 		if (spi_nor_protocol_is_dtr(nor->write_proto) &&
-		    ((addr | page_remain) & 1)) {
+		    ((offset | page_remain) & 1)) {
 			u_char *tmp;
 			size_t extra_bytes = 0;
 
@@ -1825,10 +1930,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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
@@ -1836,13 +1941,13 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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
 
@@ -1855,7 +1960,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			 */
 			written = ret - extra_bytes;
 		} else {
-			ret = nor->write(nor, addr, page_remain, buf + i);
+			ret = nor->write(nor, offset, page_remain, buf + i);
 			if (ret < 0)
 				goto write_err;
 			written = ret;
@@ -1864,6 +1969,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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
@@ -1904,6 +2014,10 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
 	ret = read_sr(nor);
 	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
 		dev_err(nor->dev, "Macronix Quad bit not set\n");
@@ -1965,7 +2079,7 @@ static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
 		return -EINVAL;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 #endif
 
@@ -2141,6 +2255,10 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 	nor->read_dummy = 8;
 
 	while (len) {
+		/* Both chips are identical, so should be the SFDP data */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			nor->spi->flags |= SPI_XFER_LOWER;
+
 		ret = nor->read(nor, addr, len, (u8 *)buf);
 		if (!ret || ret > len) {
 			ret = -EIO;
@@ -2835,6 +2953,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       const struct flash_info *info,
 			       struct spi_nor_flash_parameter *params)
 {
+#if CONFIG_IS_ENABLED(DM_SPI)
+	struct udevice *dev = nor->spi->dev;
+	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
+	u32 idx = 0, i = 0;
+	int rc;
+#endif
+
 	/* Set legacy flash parameters as default. */
 	memset(params, 0, sizeof(*params));
 
@@ -2952,7 +3077,62 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			memcpy(params, &sfdp_params, sizeof(*params));
 		}
 	}
+#if CONFIG_IS_ENABLED(DM_SPI)
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
@@ -3267,16 +3447,54 @@ static int spi_nor_select_erase(struct spi_nor *nor,
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
 
@@ -3898,6 +4116,9 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_NOR_ENABLE_MULTI_CS;
+
 	err = spi_nor_octal_dtr_enable(nor);
 	if (err) {
 		dev_dbg(nor->dev, "Octal DTR mode not supported\n");
@@ -4064,6 +4285,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	struct spi_slave *spi = nor->spi;
 	int ret;
 	int cfi_mtd_nb = 0;
+	bool shift = 0;
 
 #ifdef CONFIG_FLASH_CFI_MTD
 	cfi_mtd_nb = CFI_FLASH_BANKS;
@@ -4201,7 +4423,9 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->addr_width = 3;
 	}
 
-	if (nor->addr_width == 3 && mtd->size > SZ_16M) {
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
+		shift = 1;
+	if (nor->addr_width == 3 && (mtd->size >> shift) > SZ_16M) {
 #ifndef CONFIG_SPI_FLASH_BAR
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
@@ -4211,6 +4435,7 @@ int spi_nor_scan(struct spi_nor *nor)
 #else
 	/* Configure the BAR - discover bank cmds and read current bank */
 	nor->addr_width = 3;
+	set_4byte(nor, info, 0);
 	ret = read_bar(nor, info);
 	if (ret < 0)
 		return ret;
@@ -4228,6 +4453,14 @@ int spi_nor_scan(struct spi_nor *nor)
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
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadb..b0e9df4271 100644
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
@@ -294,6 +303,8 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	= BIT(6),
 	SNOR_F_SOFT_RESET	= BIT(7),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
+	SNOR_F_HAS_STACKED	= BIT(9),
+	SNOR_F_HAS_PARALLEL	= BIT(10),
 };
 
 struct spi_nor;
@@ -551,6 +562,7 @@ struct spi_nor {
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
2.17.1

