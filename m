Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1F7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 04:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7AE8718D;
	Tue, 14 Nov 2023 05:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qPhF7dn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F1B8715E; Tue, 14 Nov 2023 05:57:06 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2A687129
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny9JYwap8y61neyQ0lQjeeMhDmI856/OscaBKmVaOCh7KnPowmdpDrVdW2/mygG9ZwqxVw7AtD9f8Zb6FYWm8ovSFWTsg6/o4ZGEilU53nbCE1cbzoQkIocL0CCFWWl5xicM89XaGw92ZauJVHsklqLRbW0t/7sX4spLn3DkKRU3Zb7sVh+TKyj6bOkfg2kLUAl+s+yd5pNdSTsL9J+am1GtaYOLj6W2lyh9pxZxJR089h3MExNIRkKFYaVR66c7R1sTAqFMkciRQ8EWf4lU9PVrtwN2Y/+Ep9KYGv9NIunBZ64D1YGB2/AD5+lw0G1iffwJRixj4yXH7npPY62cKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEzwL25yAekxJ5KhiDMCXskSaY1CsekMQk5WprtxsVo=;
 b=H5vOVVoa+v7Q3IXJIktdd3s4n8EkI0+ndM/8h/xtscpGdl9xT9QEuTwQo0527qwWh6KFyXerEyj/HpeiXb/g5WFcbq7FmTQVDE8a39rMeGk96aFV3YYw2CJJkMYmED99RKyUu4wRha/w0wPefqyK/cDd6Lkh/6ng+g3/ndZ9QUW4x3xfZgRCe4g87UtCp+JUaka0YIHN+NSrnA3NWUW2W3YVqqHzMVB4cMhWCB1kdgFmAar6ASxsSue24lYt0vrMUXhhCDD2M5mD0APSI/mePG5CYbJaTz4NjZoLR/+syh2ObdsbIJ3Z5Kz+lc3Gu3VDmOSoZYaV8ocN7sT8zuD1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEzwL25yAekxJ5KhiDMCXskSaY1CsekMQk5WprtxsVo=;
 b=0qPhF7dnCyIKkSBJiefuEjvuPrlCWDjawAdrrTAx/VwcrbWhombPiZ83Rt0GVB0Phxa7dps9uH4jVq113ZNrW2h0RIBEqGESUfUJzfGS+RT/71ELzfG4QdoaB1ZmGdyW1R5GB/tAy3kUHnGEXbhtrJtWFdc7Wb4o6Om79cMLCGQ=
Received: from CY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:930:1e::34)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:56:59 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::d2) by CY5PR04CA0008.outlook.office365.com
 (2603:10b6:930:1e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28 via Frontend
 Transport; Tue, 14 Nov 2023 04:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 04:56:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 22:56:55 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Mon, 13 Nov 2023 22:56:47 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v4 1/6] mtd: spi-nor: Add parallel and stacked memories support
Date: Tue, 14 Nov 2023 10:26:33 +0530
Message-ID: <20231114045638.6463-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
References: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abb098d-a52b-4041-1099-08dbe4ce2213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzIRFS0ApwM5HJVe1nX0UL2SDbOgAvGLpvGLKuVMq5qklr4PBHOai4Nxd/3l45CHmHjRTx6TUl+RdVNAm0zgjLpCQUrrEI6ehaTfR8Yfx1RQ7bswPrwrgT4BSQ74wX8/vIqrOGEhdyHZ0tvthVKn9eHoPbW9UfESN7lCCoolwCrS0b6/g+12ZJNAL4X7nDF9vTrk+VmgHWkGz0AOB5JqNCDDKTyoCCnZXIiBBFA4RojbHJSu2j5trMWUN2Ahxbbsyk+mD7rjO9DrWytX2wCl6VpuXfUgs/YGN/1CR82BHOwdiYlovWvzWFSSz8eS/v0oQ4TqdzgWKbGlOC5w9dMvIyciGU47qdUnO7XF5vnH+tSXPBipciKGC9pimTca6DVtnGA+n/7X+4QTdHe2Q3Yeh5+UmaxshQblQ8e6k6L9AjYN0bhuduxlMiGcnpt8JrNQewNmYjS3I0/Urp4nPeqp/HOcWQuAtadR2iMa3MHpdhOGy7Lq9SF/EFO0TPMbwnAvOuVeGbSknpbCTp5E/GSoZ+/I/rKZRDghlraG6DnMaH2ugGXRgrEVCXgGiJWfxhbl+wIGxHHVDmKGuvbZTezZa+qD/CTa6yg3iS2WWsw1/VXehpdiwG9stEu69vK4gj0yKMKGVpmgKmOTS+vAjf72p8I/BBuyzKrzHwS/IARaGIK/sGKqurXrqNea2IXAenncp51NcMDqcaCq3hfYGqatd4m5hRrinURSatINyKvscmNz0Ct3akIWknPtaq6LQ3HR2C4RZzj5MhbMXRWWv7bRsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70206006)(54906003)(6916009)(70586007)(82740400003)(81166007)(356005)(36756003)(86362001)(36860700001)(83380400001)(336012)(426003)(26005)(1076003)(2616005)(6666004)(30864003)(41300700001)(2906002)(478600001)(316002)(5660300002)(47076005)(4326008)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 04:56:58.8034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abb098d-a52b-4041-1099-08dbe4ce2213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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
 drivers/mtd/spi/spi-nor-core.c | 284 +++++++++++++++++++++++++++++----
 include/linux/mtd/spi-nor.h    |  13 ++
 include/spi.h                  |  12 ++
 3 files changed, 281 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9a1801ba93..2f49ca3365 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -639,12 +639,17 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
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
@@ -965,8 +970,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	u32 addr, len, rem, offset;
 	bool addr_known = false;
-	u32 addr, len, rem;
 	int ret, err;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
@@ -991,6 +996,19 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			ret = -EINTR;
 			goto erase_err;
 		}
+
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
@@ -1396,6 +1414,9 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 	u8			id[SPI_NOR_MAX_ID_LEN];
 	const struct flash_info	*info;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
 	if (tmp < 0) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
@@ -1420,28 +1441,57 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
+	u32 offset = from;
+	u32 stack_shift = 0;
+	u32 read_len = 0;
+	u32 rem_bank_len = 0;
+	u8 bank;
+	u8 is_ofst_odd = 0;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
-	while (len) {
-		loff_t addr = from;
-		size_t read_len = len;
+	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
+	    /* We can hit this case when we use file system like ubifs */
+		from = (loff_t)(from - 1);
+		len = (size_t)(len + 1);
+		is_ofst_odd = 1;
+	}
 
-#ifdef CONFIG_SPI_FLASH_BAR
-		u32 remain_len;
+	while (len) {
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
+
+		if (nor->flags & SNOR_F_HAS_STACKED) {
+			stack_shift = 1;
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
-			read_len = len;
-		else
-			read_len = remain_len;
+		if (nor->addr_width == 3) {
+#ifdef CONFIG_SPI_FLASH_BAR
+			ret = write_bar(nor, offset);
+			if (ret < 0)
+				return log_ret(ret);
 #endif
+		}
 
-		ret = nor->read(nor, addr, read_len, buf);
+		ret = nor->read(nor, offset, read_len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1746,6 +1796,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	size_t page_offset, page_remain, i;
 	ssize_t ret;
+	u32 offset;
 
 #ifdef CONFIG_SPI_FLASH_SST
 	/* sst nor chips use AAI word program */
@@ -1755,6 +1806,27 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
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
@@ -1772,17 +1844,37 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 			page_offset = do_div(aux, nor->page_size);
 		}
-		/* the size of data remaining on the first page */
-		page_remain = min_t(size_t,
-				    nor->page_size - page_offset, len - i);
 
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
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
-		if (ret < 0)
-			return ret;
+			ret = write_bar(nor, offset);
+			if (ret < 0)
+				return ret;
 #endif
+		}
+
+		page_remain = min_t(size_t, nor->page_size - page_offset,
+				    len - i);
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto write_err;
+
 		write_enable(nor);
-		ret = nor->write(nor, addr, page_remain, buf + i);
+		ret = nor->write(nor, offset, page_remain, buf + i);
 		if (ret < 0)
 			goto write_err;
 		written = ret;
@@ -1790,8 +1882,20 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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
+		if (written != page_remain) {
+			dev_err(nor->dev,
+				"While writing %zu bytes written %zd bytes\n",
+				page_remain, written);
+			ret = -EIO;
+			goto write_err;
+		}
 	}
 
 write_err:
@@ -1830,6 +1934,10 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
 	ret = read_sr(nor);
 	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
 		dev_err(nor->dev, "Macronix Quad bit not set\n");
@@ -1891,7 +1999,7 @@ static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
 		return -EINVAL;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 #endif
 
@@ -2067,6 +2175,10 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 	nor->read_dummy = 8;
 
 	while (len) {
+		/* Both chips are identical, so should be the SFDP data */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			nor->spi->flags |= SPI_XFER_LOWER;
+
 		ret = nor->read(nor, addr, len, (u8 *)buf);
 		if (!ret || ret > len) {
 			ret = -EIO;
@@ -2731,6 +2843,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       const struct flash_info *info,
 			       struct spi_nor_flash_parameter *params)
 {
+#if CONFIG_IS_ENABLED(DM_SPI)
+	struct udevice *dev = nor->spi->dev;
+#endif
+	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
+	u32 idx = 0, i = 0;
+	int rc;
+
 	/* Set legacy flash parameters as default. */
 	memset(params, 0, sizeof(*params));
 
@@ -2849,6 +2968,62 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		}
 	}
 
+
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
+
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL))
+		for (idx = 1; idx < SNOR_FLASH_CNT_MAX; idx++)
+			params->size += flash_size[idx];
+
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
@@ -3163,16 +3338,54 @@ static int spi_nor_select_erase(struct spi_nor *nor,
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
 	}
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
+	}
+
 	return 0;
 }
 
@@ -3872,6 +4085,9 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_NOR_ENABLE_MULTI_CS;
+
 	err = spi_nor_octal_dtr_enable(nor);
 	if (err) {
 		dev_dbg(nor->dev, "Octal DTR mode not supported\n");
@@ -4038,6 +4254,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	struct spi_slave *spi = nor->spi;
 	int ret;
 	int cfi_mtd_nb = 0;
+	bool shift = 0;
 
 #ifdef CONFIG_FLASH_CFI_MTD
 	cfi_mtd_nb = CFI_FLASH_BANKS;
@@ -4175,7 +4392,9 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->addr_width = 3;
 	}
 
-	if (nor->addr_width == 3 && mtd->size > SZ_16M) {
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
+		shift = 1;
+	if (nor->addr_width == 3 && (mtd->size >> shift) > SZ_16M) {
 #ifndef CONFIG_SPI_FLASH_BAR
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
@@ -4185,6 +4404,7 @@ int spi_nor_scan(struct spi_nor *nor)
 #else
 	/* Configure the BAR - discover bank cmds and read current bank */
 	nor->addr_width = 3;
+	set_4byte(nor, info, 0);
 	ret = read_bar(nor, info);
 	if (ret < 0)
 		return ret;
@@ -4202,6 +4422,14 @@ int spi_nor_scan(struct spi_nor *nor)
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
index 2861b73edb..72206f51ad 100644
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
@@ -185,6 +188,13 @@
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/*
+ * Maximum number of flashes that can be connected
+ * in stacked/parallel configuration
+ */
+#define SNOR_FLASH_CNT_MAX	2
+
+
 /* For Cypress flash. */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
@@ -298,6 +308,8 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	= BIT(6),
 	SNOR_F_SOFT_RESET	= BIT(7),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
+	SNOR_F_HAS_STACKED	= BIT(9),
+	SNOR_F_HAS_PARALLEL	= BIT(10),
 };
 
 struct spi_nor;
@@ -555,6 +567,7 @@ struct spi_nor {
 	u8			bank_read_cmd;
 	u8			bank_write_cmd;
 	u8			bank_curr;
+	u8			upage_prev;
 #endif
 	enum spi_nor_protocol	read_proto;
 	enum spi_nor_protocol	write_proto;
diff --git a/include/spi.h b/include/spi.h
index 1bc18e6552..2a3ccaa754 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -39,6 +39,16 @@
 
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
+
 /**
  * struct dm_spi_bus - SPI bus info
  *
@@ -156,6 +166,8 @@ struct spi_slave {
 #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
 #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
+#define SPI_XFER_U_PAGE		BIT(4)
+#define SPI_XFER_STACKED	BIT(5)
 };
 
 /**
-- 
2.17.1

