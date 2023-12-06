Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43393C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0988D8787C;
	Wed,  6 Dec 2023 10:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqeyuSlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8AD0875EB; Wed,  6 Dec 2023 10:33:56 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6415B878AA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSLI3A1c4MWQXKdIw685eF4C2Pay1dYT5Ub84YiIF4Rfmc4PPdTC+fHXJfPYXhXF3Ar/xIJYyZ4DO78JEvsTopP862BkA+yeTRPa6XGI+8MaS5POc7XpfqfqPSoHq9xPUxPTigi6BFC5118xX0eIodICY/q+WT80UJRX84Qc44cNJtZ4Qam9fM821EEDEfqPnVQfs5ir06AL/af7ljBLzbZ7XxIoHSgnOZN7cpRkqq/L4IZAGiZBpPWf6oM0HGMUNdrzUhMXw8lt/QiSxvL0Q6vnZDD9BRt9L5e0fR6F6U4nRmagbTqGtYZyuNvpD5WBM3OSrdWm4NkeatR5mAGUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxoHgbVIt495oMyqcXaHf4T9G6zFlgAa5hqq6TdMiLs=;
 b=KPkhm9sgjrioWNttUEvjSc6m5n62tV+VM7RLKDqxKTncxJo4MRCvjUFV4NXVuiT5mqGx3OkNVaoefSNmeL6bqAE9TJhn5gYNMe/nEFJHB7r6Evd2zb6Uu3iXubN+NEfT6UDVROmkjQTjSI82C/fklucZPHHN8jCpVNeFLg8la8OceKI6kM3wQr/ODc8t48ERGe2MAV0xbHDtrDJt1tXVALRCLqG6FyEuc7weAnK/TaeZGf/+5PDgQRwbCsMZBrolKcL9+dXdelRv/i4iO2nPIFX798SbuJ4Xk7zpPx9y2+Kz+Zgo3T9DGCz8UPQJRvrhAn2BFg/Araeh52JPTigK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxoHgbVIt495oMyqcXaHf4T9G6zFlgAa5hqq6TdMiLs=;
 b=vqeyuSlE/cLP0QJ5RvQ+XQrUwrhtTM/k/9kHwoeNbJLUQflFBg8bJZcDwadyG+SNtA3/5nkDLM//fe060w/Q1YOudnHSYAkKPjvQP8hTRd8hib9gX4pLxeqEeUNwpMfQwElk1Dt4XSoRdNrkGDsRbrGT1/fXUvjoTxLiac5AmUw=
Received: from DM6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:333::28)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:33:49 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::3c) by DM6PR03CA0095.outlook.office365.com
 (2603:10b6:5:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:33:47 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:45 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 27/30] mtd: spi-nor: Add support for locking on Macronix
 nor flashes
Date: Wed, 6 Dec 2023 15:01:38 +0530
Message-ID: <0085dc3bd6374e39a7792db4150ac3cf2aa4a0d8.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc398f3-2796-4056-7286-08dbf63e738b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNVSLnc2+I21gPV3sxW2nhWBW+JndN8JtA6rDieVMRQ34GrEzrCl0XWO8uEp653bhdp/ZmQEneJiBkHkkQA0Qg8OW3wW+R9AvxYxVeKU5VpJyGJZoYwHE4LRAzzXD/RJQRo2Bv0P4Q1TemQv8yvigsrT93nPondwtYkjEY+VXwMUZd9csvHVIDbp+v7+Xi7GEzEHSv9oHcwQbnmq+H4AWOYpQXkuCcBkgt6r4/R5kZL/YsEo5Wv20u+0WJIDjAOk2J+cGbl0SymB/yf7AWoE8kV3GqxnJnaJsgAISuXygYKE1szYwluT6jzDl2vy6LY9As2BFSRWq+NkhdWtsRfpIbPn6DIIKNQTZUiheEStWKelNjG3JtagWo3PtraN2lC6JcD4ACTMSyP6fv9/3HgQTd4EqRyurMMtaT2McKHmD3XzE8Lmle85/Chi86j8iJQpx2IT0DkIk80PMiu81e2u0t0dDxmB5XSEs4UMk1zoV3PLovLBbE75nNXnq9rLf4sODFMJ8kcBYqYjdORs69TJ3TXnnO5NzALQpmdhohrA9JE7tDxezJrRERdnibt6KUJt1dnbtL399sbV1Rh3GwqqvMlWQd3F9hB/xFjW5Grkg3oGlxpi25ih/SGE9uSTujhWMXMMcQfE7JCKh9FvAyet1CG0A5Y4oyAwJlZQMIQWxFtHWiQA65m+rgZ1hkGQerBT6TIjdp6FqQPjU7/enfyH4effk7/yddxGetG4E4dBy8S28teyIANSXKdP8xLGYbYhWvZ18ao/80yw/NjNOPnxVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(426003)(478600001)(83380400001)(2616005)(26005)(336012)(6666004)(316002)(6916009)(54906003)(36756003)(8676002)(86362001)(8936002)(70206006)(41300700001)(4326008)(70586007)(36860700001)(40480700001)(2906002)(5660300002)(82740400003)(81166007)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:48.9043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc398f3-2796-4056-7286-08dbf63e738b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Macronix chips implements locking in (power-of-two multiple of) 64K
blocks, not as a fraction of the chip's size. Bit 5 in the status
register is not a top/bottom select bit, but instead a fourth value
bit, allowing locking between 2^0 and 2^14 64K blocks (so up to 1GiB),
either from top or bottom.

The top/bottom select is instead done via a bit in the configuration
register, which is OTP, so once set to use bottom protect, one cannot
use top. On top of that, reading the configuration register uses a
different opcode (0x15) than the existing SPINOR_OP_RDCR (0x35).

Here's an attempt to implement locking support for Macronix flash
memory devices. This implementation has been tested and confirmed to
work on the specific chip used on our boards. Additionally, based
on the information from data sheets of various other Macronix chips,
suggest they behave in the same way.

Used bottom protect to test the locking and unlocking functionality
on the zc1751+dc1 board.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 259 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   3 +
 2 files changed, 262 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index c40899a281..08f6fb66be 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4581,6 +4581,257 @@ static int micron_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return micron_is_unlocked_sr(nor, ofs, len, status);
 }
 #endif /* CONFIG_SPI_FLASH_STMICRO */
+
+#if defined(CONFIG_SPI_FLASH_MACRONIX)
+/**
+ * mx_write_sr_cr() - write status and configuration register
+ * @nor: pointer to a 'struct spi_nor'
+ * @sr_cr: pointer status and configuration register
+ *
+ * Write status Register and configuration register with 2 bytes
+ * The first byte will be written to the status register, while the
+ * second byte will be written to the configuration register.
+ *
+ * Return: 0 on success, -errno if error occurred.
+ */
+static int mx_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
+{
+	int ret;
+
+	write_enable(nor);
+
+	ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
+	if (ret < 0) {
+		dev_dbg(nor->dev,
+			"error while writing configuration register\n");
+		return -EINVAL;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret) {
+		dev_dbg(nor->dev,
+			"timeout while writing configuration register\n");
+		return ret;
+	}
+
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mx_read_cr(struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDCR_MX, &val, 1);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d reading CR\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
+/**
+ * mx_get_locked_range() - get the locked range
+ * @nor: pointer to a 'struct spi_nor'
+ * @sr:  status register
+ * @cr:  configuration register
+ * @ofs: flash offset
+ * @len: length to be locked
+ *
+ * Macronix flashes do not work by locking some 1/2^k fraction of the
+ * flash - instead, the BP{0,1,2,3} bits define a number of protected
+ * 64K blocks.
+ */
+static void mx_get_locked_range(struct spi_nor *nor, u8 sr, u8 cr,
+				loff_t *ofs, uint64_t *len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int pow, shift;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_MX;
+
+	shift = ffs(mask) - 1;
+
+	pow = ((sr & mask) >> shift) - 1;
+	if (pow < 0) {
+		/* No protection */
+		*ofs = 0;
+		*len = 0;
+	} else {
+		*len = (uint64_t)SZ_64K << pow;
+		if (*len > mtd->size)
+			*len = mtd->size;
+		if (cr & CR_TB_MX)
+			*ofs = 0;
+		else
+			*ofs = mtd->size - *len;
+	}
+}
+
+/**
+ * mx_check_lock_status() - check the locked status
+ * @nor: pointer to a 'struct spi_nor'
+ * @ofs: flash offset
+ * @len: length to be locked
+ * @sr:  status register
+ * @cr:  configuration register
+ * @locked: locked:1 unlocked:0 value
+ *
+ * Return: 1 if the entire region is locked (if @locked is true) or unlocked (if
+ * @locked is false); 0 otherwise.
+ */
+static int mx_check_lock_status(struct spi_nor *nor, loff_t ofs, u64 len,
+				u8 sr, u8 cr, bool locked)
+{
+	loff_t lock_offs;
+	u64 lock_len;
+
+	if (!len)
+		return 1;
+
+	mx_get_locked_range(nor, sr, cr, &lock_offs, &lock_len);
+
+	if (locked)
+		/* Requested range is a sub-range of locked range */
+		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+
+	/* Requested range does not overlap with locked range */
+	return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+}
+
+static int mx_lock_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len, bool lock)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int sr, cr, ret, val;
+	loff_t lock_len, blocks;
+	bool can_be_top, can_be_bottom, use_top;
+	u8 sr_cr[2], shift;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_MX;
+
+	shift = ffs(mask) - 1;
+
+	sr = read_sr(nor);
+	if (sr < 0)
+		return sr;
+
+	cr = mx_read_cr(nor);
+	if (cr < 0)
+		return cr;
+
+	log_debug("SPI Protection: %s\n", (cr & CR_TB_MX) ? "bottom" : "top");
+
+	/* CR_TB is OTP, so we can't use 'top' protection if that is already set. */
+	can_be_top = !(cr & CR_TB_MX);
+	can_be_bottom = true;
+
+	/* If the whole range is already locked (unlocked), we don't need to do anything */
+	if (mx_check_lock_status(nor, ofs, len, sr, cr, lock))
+		return 0;
+
+	/* To use 'bottom' ('top') protection, everything below us must be locked (unlocked). */
+	if (!mx_check_lock_status(nor, 0, ofs, sr, cr, lock)) {
+		if (lock)
+			can_be_bottom = false;
+		else
+			can_be_top = false;
+	}
+
+	/* To use 'top' ('bottom') protection, everything above us must be locked (unlocked). */
+	if (!mx_check_lock_status(nor, ofs + len, mtd->size - (ofs + len), sr, cr, lock)) {
+		if (lock)
+			can_be_top = false;
+		else
+			can_be_bottom = false;
+	}
+
+	if (!can_be_bottom && !can_be_top)
+		return -EINVAL;
+
+	/* Prefer top, if both are valid */
+	use_top = can_be_top;
+
+	/* lock_len: length of region that should end up locked */
+	if (lock)
+		lock_len = use_top ? mtd->size - ofs : ofs + len;
+	else
+		lock_len = use_top ? mtd->size - (ofs + len) : ofs;
+
+	/* lock_len must be a power-of-2 (2^0 .. 2^14) multiple of 64K, or 0 */
+	if (lock_len & (SZ_64K - 1))
+		return -EINVAL;
+
+	blocks = lock_len / SZ_64K;
+	if ((blocks != 0 && !is_power_of_2(blocks)) || blocks > 1 << 14)
+		return -EINVAL;
+
+	/* Compute new values of sr/cr */
+	val = blocks ? ilog2(blocks) + 1 : 0;
+	sr_cr[0] = sr & ~mask;
+	sr_cr[0] |= val << shift;
+	/*
+	 * Disallow further writes if WP pin is asserted, but remove
+	 * that bit if we unlocked the whole chip.
+	 */
+	if (lock_len)
+		sr_cr[0] |= SR_SRWD;
+	else
+		sr_cr[0] &= ~SR_SRWD;
+
+	sr_cr[1] = cr | (use_top ? 0 : CR_TB_MX);
+
+	/* Don't bother if they're the same */
+	if (sr == sr_cr[0] && cr == sr_cr[1])
+		return 0;
+
+	ret = mx_write_sr_cr(nor, sr_cr);
+	if (ret)
+		return ret;
+
+	/* Check that the bits got written as expected */
+	sr = read_sr(nor);
+	if (sr < 0)
+		return sr;
+
+	cr = mx_read_cr(nor);
+	if (cr < 0)
+		return cr;
+
+	if ((sr & mask) != (sr_cr[0] & mask) ||
+	    (cr & CR_TB_MX) != (sr_cr[1] & CR_TB_MX))
+		return -EIO;
+
+	return 0;
+}
+
+static int mx_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return mx_lock_unlock(nor, ofs, len, true);
+}
+
+static int mx_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return mx_lock_unlock(nor, ofs, len, false);
+}
+
+static int mx_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int sr, cr;
+
+	sr = read_sr(nor);
+	if (sr < 0)
+		return sr;
+
+	cr = mx_read_cr(nor);
+	if (cr < 0)
+		return cr;
+
+	return mx_check_lock_status(nor, ofs, len, sr, cr, false);
+}
+#endif /* CONFIG_SPI_FLASH_MACRONIX */
 #endif /* CONFIG_SPI_FLASH_LOCK */
 
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET
@@ -4800,6 +5051,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	}
 #endif
 
+#if defined(CONFIG_SPI_FLASH_MACRONIX)
+	if (JEDEC_MFR(info) == SNOR_MFR_MACRONIX) {
+		nor->flash_lock = mx_lock;
+		nor->flash_unlock = mx_unlock;
+		nor->flash_is_unlocked = mx_is_unlocked;
+	}
+#endif
+
 #ifdef CONFIG_SPI_FLASH_SST
 	/*
 	 * sst26 series block protection implementation differs from other
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 03413063ae..8ca874068a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -70,6 +70,7 @@
 #define SPINOR_OP_RDID		0x9f	/* Read JEDEC ID */
 #define SPINOR_OP_RDSFDP	0x5a	/* Read SFDP */
 #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
+#define SPINOR_OP_RDCR_MX	0x15	/* Read configuration register (Macronix) */
 #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
@@ -167,6 +168,7 @@
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
 #define SR_BP3			BIT(6)  /* Block protect 3 */
+#define SR_BP3_MX		BIT(5)	/* Block protect 3 (Macronix) */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 
@@ -192,6 +194,7 @@
 
 /* Configuration Register bits. */
 #define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
+#define CR_TB_MX		BIT(3)	/* Macronix Top/Bottom protect */
 
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
-- 
2.27.0

