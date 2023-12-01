Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7A2C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 03:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2C18773F;
	Fri,  1 Dec 2023 04:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8Zipxbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF2B8774B; Fri,  1 Dec 2023 04:19:00 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 930D487738
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 04:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq42lVyT+ok5dfuHDDSMqrh/ujSrmSbEJdtPS5L26TMgqKQR6by9uIspN+EPm+H1eq6lYQSan+a2MmoclV2dquG8KBaygvjWeJHnnxACLEFNzgd9Km0ZEteLbshclVX7JIEOf7gjHz+9RTkA4aoWqKZYsr2YJie8e+AzQzRuDwhdl/Mjg2L66Sck9UguEcgVQHMjwHnomGvl8v1DgXtCkrh+NT4X1Qj2fnJ91tbSor9PE98qKtYHKd+nWE1tObR0e09lbTeP4FfOrhFfH/+mY7SmU3YfPKCSOY7Gu3rqwKdkWgC4JOtX7sBCCEKvVYFMG3DL7nHd3Z/RgJq/chzr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUT5yr4MNUgk1bDmiD+AE9qCFZmLSojjdVjUGd9uE1Q=;
 b=RMNf0a5K5wM5tkgSO4+LmtdWPapbYSXBUyMxjOuhLIECOQxFwx11ugCa/QZFN5I9jaSP0vP+pyW3nIgKGwEiuK2pzC7v++smh23jVEDHFYXidmxwJWXyNbMXJlrVXjzmMhhKhS73PrzAjJI39WmN/uZipKINpDdmBUls1fudpqb4f38zSOXwQakV3QWCziF9COl5XPfKbB8TnT4A5NvB+fWS94ycFSSMMT3FjDyEstRLUcOzTkWEoqVgv5WMz0bJg6drSpK+M0OIwO/ngYC2FpqG0Mz2AgCAEko3WJRvz5u62rm1G7uE6gGDQlA551b/eO90pt9AFMuBOgxM08KigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUT5yr4MNUgk1bDmiD+AE9qCFZmLSojjdVjUGd9uE1Q=;
 b=k8ZipxbtpWuQZGTqmjhbrsWs9Ui8PfiNJPQAl3Jj9iuz37+dI94zB9qXiIkf8a3Tt+p36Vql9mK1n5REAEGQ6TYz/nxvOZMbfDUPCg/JdNYycD++/FNTNOzKJmBxoXLOtWa/11NgDpX+9EOW1BzPqajs6l0JZyASqjjiRX/Bijs=
Received: from BN9PR03CA0478.namprd03.prod.outlook.com (2603:10b6:408:139::33)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 03:18:52 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::6d) by BN9PR03CA0478.outlook.office365.com
 (2603:10b6:408:139::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 03:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 03:18:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 21:18:50 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 21:18:48 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v5 1/6] mtd: spi-nor: Add parallel and stacked memories support
Date: Fri, 1 Dec 2023 08:48:34 +0530
Message-ID: <20231201031839.239567-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
References: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 674a5399-9984-45f6-1464-08dbf21c3da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQ4d6P5YuPmxsWdUnSs916a7aCrOjNVEGD8uCDrl6glzOTQrwGCfwmZgIqpsaLsOMUyZNBOPeqhj+VjEbfBkyQJG5+N1dOpOo3vunxXd1W/MzokMqlZFvqaQb73pBQd/anv9Ya3DUHOKgq6FJnju/q7YPFjS+1qZ4h3SD3B0mGYpKPhdMXhbKJ+4s923qW1VrqfWgaKiuHE6rvTW8W2zqqLjjYuue12Z+B1FPoehvOLiaKJbi/LaGFfIR8eAeYHrucrEb3Ib0AxnKSeHh07IElgEXTLX5y1nRxf7qUJNOXjWN/C8wXPmuXSaum2tIiIWkNBobZpIwUXHvOJeWz2agoqW2vZHmqCVG9bKHOzxpkyI0DNzJCzH9Eb/aT1VoDhdtTT6ebx2jk6r0JhDAqI+YbL644utgDgRrjaGEoXz2APrD3P1TUAO2Q1YXamZtIPUTU8O2SSgN9UAWv++wP2+F21/Zp7D+EXiNQYwBGmL5bGgqiIftiFG8Xvld1zWd6jK4k6MlLAKVPgbWJt/BVEN6SsRZUAbf/J7k3rkQNDIWELT5cXLEhscfs+EgIzh2XSLaIeGmYb+I5BdbAQlGvNOnPZWvowTVzSy7vTMzTCfahvednLpJXB0tr5FuvO8Dz2ScMQUBNf9F8I3d9s1w0Hlmn0myGWTFe6XjSYBBrX7yNA/U1fhOoKeaghx5SEj5mw0S8vAO8T8CjGUi1C8yt4PGpBWvzhqWaJzMzAIxefoCfwi9HH9FYu96mBMvcRI5gOSdNYJTjtzbDmkEke3hKVibw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(26005)(1076003)(6666004)(2616005)(47076005)(83380400001)(36860700001)(426003)(8676002)(8936002)(4326008)(30864003)(41300700001)(2906002)(478600001)(316002)(5660300002)(6916009)(70206006)(70586007)(54906003)(86362001)(336012)(36756003)(81166007)(82740400003)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:18:50.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674a5399-9984-45f6-1464-08dbf21c3da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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
 drivers/mtd/spi/spi-nor-core.c | 285 +++++++++++++++++++++++++++++----
 include/linux/mtd/spi-nor.h    |  13 ++
 include/spi.h                  |  12 ++
 3 files changed, 282 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9a1801ba93..4e2d8c8231 100644
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
 
@@ -2849,6 +2968,63 @@ static int spi_nor_init_params(struct spi_nor *nor,
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
@@ -3163,16 +3339,54 @@ static int spi_nor_select_erase(struct spi_nor *nor,
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
 
@@ -3872,6 +4086,9 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_NOR_ENABLE_MULTI_CS;
+
 	err = spi_nor_octal_dtr_enable(nor);
 	if (err) {
 		dev_dbg(nor->dev, "Octal DTR mode not supported\n");
@@ -4038,6 +4255,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	struct spi_slave *spi = nor->spi;
 	int ret;
 	int cfi_mtd_nb = 0;
+	bool shift = 0;
 
 #ifdef CONFIG_FLASH_CFI_MTD
 	cfi_mtd_nb = CFI_FLASH_BANKS;
@@ -4175,7 +4393,9 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->addr_width = 3;
 	}
 
-	if (nor->addr_width == 3 && mtd->size > SZ_16M) {
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
+		shift = 1;
+	if (nor->addr_width == 3 && (mtd->size >> shift) > SZ_16M) {
 #ifndef CONFIG_SPI_FLASH_BAR
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
@@ -4185,6 +4405,7 @@ int spi_nor_scan(struct spi_nor *nor)
 #else
 	/* Configure the BAR - discover bank cmds and read current bank */
 	nor->addr_width = 3;
+	set_4byte(nor, info, 0);
 	ret = read_bar(nor, info);
 	if (ret < 0)
 		return ret;
@@ -4202,6 +4423,14 @@ int spi_nor_scan(struct spi_nor *nor)
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
2.25.1

