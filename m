Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A2EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDFA878B0;
	Wed,  6 Dec 2023 10:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3yC35syl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14AA875EB; Wed,  6 Dec 2023 10:34:00 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17361878A2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeuVnIuk+spADUq6aszgKYvYSRYzkiZzVCdvCqj1MLMxYV2HtGdCrmwX29k/eAAd9h0bcanawXa7gMMJjCc8duS6DNrm0bCn8Ula6vtph4fzr4MMHPykHunbwoJKorC9stcJ2BJKplyqRW58UdsO9bOH0j3uAd3FTA9NPdDfIPcsudL6+lNfzkubAlc/NRTHCH96hSjGA5F61nxpLiZTLMKL30CDVicsGPjqFuKpy+m8BEyqQl1y2hsuBRyB6HD84PEp8RWWg3rIOrsOIO1dacBybV5X3Ws6BB/bhfVVus5BQeAx58s/q0LIMFn+f24+mWeG6BZHUZgEPNV4cvAjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZQgfw/kQadVzfl28kAct8jBXQTiaToF5eTOHG85dFE=;
 b=fwg2q16na9Wlxp+9DHsm9HJ6RWoxvWUiK+m/T+9vYaLBWnmwtZbe1sASARqcC/bPI9eOihk1oidfHxEfuwca6mha2ziR9IN9Oy834JvuJqt2NqtfKZOysYV43QTgPM8lcL92tmoI2EXMHrQucVOYEplgzi248SxLgD+0FPAGZJlpXNUkNsbvTNwwyZoJuMPBgehcNy06KMHr3AhmoyVkgfssvyYxR2gUcu3zo0jaybXGvM5fUgNfKbH3HcmeQw53XyyJZA36oOgq7J4yl1aJpNOxAIl6/IRlpok0b5DlH2dr96VrUKcTzfUQTjYC33141Eg2nGErRINJ/UUKiQMwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZQgfw/kQadVzfl28kAct8jBXQTiaToF5eTOHG85dFE=;
 b=3yC35sylVGf4cLievnnyaKU5ALwm1wJHTUbMDNFbMGsxYmi5QOSvFP49BfSg0X3N96Rorm1UOnvSZvlpGXyZoUqj0HVZz8goOV4nJbntoQh76/exeui8tfniEBYBW2EncvxyZxu1o3oLzpDpHxAW0/1+0T7RF8c5k1If+YbR3tc=
Received: from CH0PR03CA0406.namprd03.prod.outlook.com (2603:10b6:610:11b::14)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:33:54 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::e3) by CH0PR03CA0406.outlook.office365.com
 (2603:10b6:610:11b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:50 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:48 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 28/30] mtd: spi-nor: Add support for locking on ISSI nor
 flashes
Date: Wed, 6 Dec 2023 15:01:39 +0530
Message-ID: <d790f6bfea6a79a9561c37ae257f541a5eb83584.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe5ed90-0dc7-4e96-d2ca-08dbf63e76fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEWkv4YsuTrKF6V8ZMmiOD0Foe3cJ2dtbiZt6mEjXmZpBlZrmz2eOca+qsG8cazdATxnxuZXHF8vG1jcjOa0ffe4c3HviqpvNl3m+NoctclWWbU04ITmMU/1w/Vl7tLmgfGahOnv6zUlRfhrS53Y7dwGOdnSbTsdc4ClKgPqNrOWQ4iPlMoafKksgNvJdyOl2ux1Y40Ec0sjGmNhqYadCFDmfTudlwhhYQxE3KbKseX5BWykzI7NMdCHbOqVKJFTiDbRxLYRPGWUPCcX0goQ+wePrna71pKWL0AHOyRtRuYab1Df1arWl0LMphTa4JgZMaxRAE9+UcSlFcg+wWpOfhST5OmKqSuvOv5t0S+LppGVgIjEM/VRIbCww56hEbWTQS4DSBbbydDJJL6FHdEe5hgbF0oAGwSwTE6x7QgVEo/vdLTXCIUmXBfWUCksb7Y4WBskzR+l4TMvtqqf6oR0g2LGMdR6CVQx2Qg4mC38h7zNDRi8UbIBJhn8Z6yp2hvxw2oAjjFbrxfytjEpB10f0oHswexL/BpL/j9oaTtG3wJ2nWHFmE5tngeYxSrXw6Y+cTkisMgCaw1Blr14GxC3/e7Mqter00v4QfwJIeJH2gl+uEDxBVqt/nHiusPa+kInp3f3/+1+xjqQyy84jSjbTR6+Qf+v1Lnbet56mVAPGOdG/eZ0q/DJnj9H4S/X/w5z513F6qgqvvDyHdp0KU6wEbhv8RJksWK11uasjbNUjbZN1dNJOre79YatYIQLM/K88uCo/BGkxlZ8T42kD8r6v5LjS7Uj7JATtTy+FWqxtcE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(81166007)(356005)(82740400003)(2906002)(30864003)(86362001)(26005)(336012)(426003)(83380400001)(47076005)(40480700001)(36860700001)(40460700003)(5660300002)(478600001)(36756003)(6666004)(8936002)(2616005)(8676002)(4326008)(41300700001)(54906003)(6916009)(316002)(70586007)(70206006)(69594002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:54.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe5ed90-0dc7-4e96-d2ca-08dbf63e76fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

ISSI chips implements locking in (power-of-two multiple of) 64K
blocks, not as a fraction of the chip's size. Bit 5 in the status
register is not a top/bottom select bit, but instead a fourth value
bit, allowing locking between 2^0 and 2^14 64K blocks (so up to 1GiB),
either from top or bottom.

The top/bottom select is instead done via a bit in the function
register, which is OTP, so once set to use bottom protect, one cannot
use top. On top of that, reading the function register uses a
opcode SPINOR_OP_RDFR (0x48) and writing to the function register uses the
opcode SPINOR_OP_WRFR(0x42).

Here's an attempt at implementing a locking feature for ISSI flash memory
devices. This implementation has been rigorously tested and proven to work
on the chip used in our boards. Additionally, after examining data sheets
for various other ISSI chips, it appears that they follow a similar
behavior.

Used "bottom protect" to test the lock and unlock functionality on the
Versal Tenzing board. Please note that the Block Protection table is
specific to the IS25LP01G, which has a size of 128MB, a sector size
of 64KB, and comprises 2048 sectors.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/sf_internal.h  |   6 +
 drivers/mtd/spi/spi-nor-core.c | 340 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   7 +
 3 files changed, 353 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 2cbdea60b0..aaa8520838 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -71,6 +71,12 @@ struct flash_info {
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
 #define SPI_NOR_OCTAL_DTR_PP	BIT(18) /* Flash supports Octal DTR page program */
 #define SPI_NOR_MULTI_DIE	BIT(19) /* Flash has multi dies & need split reads*/
+#define SPI_NOR_HAS_BP3		BIT(20) /* Flash SR has block protect bits
+					 * for lock/unlock purpose, few support
+					 * BP0-BP2 while few support BP0-BP3.
+					 * This flag identifies devices that
+					 * support BP3 bit.
+					 */
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 08f6fb66be..3bf1e5471b 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4832,6 +4832,338 @@ static int mx_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return mx_check_lock_status(nor, ofs, len, sr, cr, false);
 }
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
+
+#if defined(CONFIG_SPI_FLASH_ISSI)
+/**
+ * spi_nor_read_fr() - read function register
+ * @nor: pointer to a 'struct spi_nor'.
+ *
+ * ISSI devices have top/bottom area protection bits selection into function
+ * reg. The bits in FR are OTP. So once it's written, it cannot be changed.
+ *
+ * Return: Value in function register or negative if error.
+ */
+static int spi_nor_read_fr(struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDFR, &val, 1);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d reading FR\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
+static void issi_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
+				  uint64_t *len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	u8 mask = 0, fr = 0;
+	int pow, shift;
+	u32 sector_size;
+
+	mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_ISSI;
+	shift = ffs(mask) - 1;
+	sector_size = nor->sector_size;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		sector_size >>= 1;
+
+	if (!(sr & mask)) {
+		/* No protection */
+		*ofs = 0;
+		*len = 0;
+	} else {
+		pow = ((sr & mask) >> shift) - 1;
+		*len = sector_size << pow;
+		if (*len > mtd->size)
+			*len = mtd->size;
+		/* ISSI device's have top/bottom select bit in function reg */
+		fr = spi_nor_read_fr(nor);
+		if (fr & FR_TB)
+			*ofs = 0;
+		else
+			*ofs = mtd->size - *len;
+	}
+}
+
+/**
+ * issi_check_lock_status_sr() - check the status register and return
+ * the region is locked or unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ * @locked: locked:1 unlocked:0 value
+ *
+ * Return: 1 if the entire region is locked (if @locked is true) or unlocked (if
+ * @locked is false); 0 otherwise.
+ */
+static int issi_check_lock_status_sr(struct spi_nor *nor, loff_t ofs, u64 len,
+				     u8 sr, bool locked)
+{
+	loff_t lock_offs;
+	u64 lock_len;
+
+	if (!len)
+		return 1;
+
+	issi_get_locked_range(nor, sr, &lock_offs, &lock_len);
+	if (locked)
+		/* Requested range is a sub-range of locked range */
+		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+
+	/* Requested range does not overlap with locked range */
+	return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+}
+
+/**
+ * spi_nor_is_locked_sr() - check if the memory region is locked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ *
+ * Check if memory region is locked.
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				u8 sr)
+{
+	return issi_check_lock_status_sr(nor, ofs, len, sr, true);
+}
+
+/**
+ * spi_nor_is_unlocked_sr() - check if the memory region is unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ *
+ * Check if memory region is unlocked.
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				  u8 sr)
+{
+	return issi_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/**
+ * issi_is_unlocked() - check if the memory region is unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ *
+ * Check if memory region is unlocked
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int issi_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int sr;
+
+	sr = read_sr(nor);
+	if (sr < 0)
+		return sr;
+
+	return issi_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/**
+ * spi_nor_select_zone() - Select top area or bottom area to lock/unlock
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ * @sr: status register
+ * @tb: pointer to top/bottom bool used in caller function
+ * @op: zone selection is for lock/unlock operation. 1: lock 0:unlock
+ *
+ * Select the top area / bottom area pattern to protect memory blocks.
+ *
+ * Return: negative on errors, 0 on success.
+ */
+static int spi_nor_select_zone(struct spi_nor *nor, loff_t ofs, uint64_t len,
+			       u8 sr, bool *tb, bool op)
+{
+	int retval = 1;
+	bool can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB, can_be_top = true;
+
+	if (op) {
+		/* Select for lock zone operation */
+
+		/*
+		 * If nothing in our range is unlocked, we don't need
+		 * to do anything.
+		 */
+		if (spi_nor_is_locked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is unlocked, we can't use 'bottom'
+		 * protection.
+		 */
+		if (!spi_nor_is_locked_sr(nor, 0, ofs, sr))
+			can_be_bottom = false;
+
+		/*
+		 * If anything above us is unlocked, we can't use 'top'
+		 * protection.
+		 */
+		if (!spi_nor_is_locked_sr(nor, ofs + len,
+					  nor->mtd.size - (ofs + len), sr))
+			can_be_top = false;
+	} else {
+		/* Select unlock zone */
+
+		/*
+		 * If nothing in our range is locked, we don't need to
+		 * do anything.
+		 */
+		if (spi_nor_is_unlocked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is locked, we can't use 'top'
+		 * protection
+		 */
+		if (!spi_nor_is_unlocked_sr(nor, 0, ofs, sr))
+			can_be_top = false;
+
+		/*
+		 * If anything above us is locked, we can't use 'bottom'
+		 * protection
+		 */
+		if (!spi_nor_is_unlocked_sr(nor, ofs + len,
+					    nor->mtd.size - (ofs + len), sr))
+			can_be_bottom = false;
+	}
+
+	if (!can_be_bottom && !can_be_top)
+		return -EINVAL;
+
+	/* Prefer top, if both are valid */
+	*tb = can_be_top;
+	return retval;
+}
+
+/**
+ * issi_flash_lock() - set BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Lock a region of the flash.Implementation is based on stm_lock
+ * Supports the block protection bits BP{0,1,2,3} in status register
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_flash_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	u32 sector_size;
+	u16 n_sectors;
+	unsigned int bp_slots, bp_slots_needed;
+	int status_old, status_new, blk_prot, fr, shift;
+	loff_t lock_len;
+	u8 pow, ret;
+	bool use_top = false;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_ISSI;
+
+	shift = ffs(mask) - 1;
+
+	status_old = read_sr(nor);
+	/* if status reg is Write protected don't update bit protection */
+	if (status_old & SR_SRWD) {
+		dev_err(nor->dev,
+			"SR is write protected, can't update BP bits...\n");
+		return -EINVAL;
+	}
+
+	fr = spi_nor_read_fr(nor);
+	log_debug("SPI Protection: %s\n", (fr & FR_TB) ? "bottom" : "top");
+
+	ret = spi_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
+	/* Older protected blocks include the new requested block's */
+	if (ret <= 0)
+		return ret;
+
+	/* lock_len: length of region that should end up locked */
+	if (use_top)
+		lock_len = nor->mtd.size - ofs;
+	else
+		lock_len = ofs + len;
+
+	sector_size = nor->sector_size;
+	n_sectors = (nor->size) / sector_size;
+
+	bp_slots = (1 << hweight8(mask)) - 2;
+	bp_slots_needed = ilog2(n_sectors);
+
+	if (bp_slots_needed > bp_slots)
+		sector_size <<= (bp_slots_needed - bp_slots);
+
+	pow = ilog2(lock_len) - ilog2(sector_size) + 1;
+	blk_prot = pow << shift;
+	status_new = status_old | blk_prot;
+	if (status_old == status_new)
+		return 0;
+
+	return write_sr_and_check(nor, status_new, mask);
+}
+
+/**
+ * issi_flash_unlock() - clear BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to unlock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Bits [2345] of the Status Register are BP[0123].
+ * ISSI chips use a different block protection scheme than other chips.
+ * Just disable the write-protect unilaterally.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_flash_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret, val;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_ISSI;
+
+	val = read_sr(nor);
+	if (val < 0)
+		return val;
+
+	if (!(val & mask))
+		return 0;
+
+	write_enable(nor);
+
+	write_sr(nor, val & ~mask);
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
+	ret = read_sr(nor);
+	if (ret > 0 && !(ret & mask)) {
+		dev_info(nor->dev, "ISSI block protect bits cleared SR: 0x%x\n",
+			 ret);
+		ret = 0;
+	} else {
+		dev_err(nor->dev, "ISSI block protect bits not cleared\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+#endif /* CONFIG_SPI_FLASH_ISSI */
 #endif /* CONFIG_SPI_FLASH_LOCK */
 
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET
@@ -5059,6 +5391,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	}
 #endif
 
+#if  defined(CONFIG_SPI_FLASH_ISSI)
+	if (JEDEC_MFR(info) == SNOR_MFR_ISSI) {
+		nor->flash_lock = issi_flash_lock;
+		nor->flash_unlock = issi_flash_unlock;
+		nor->flash_is_unlocked = issi_is_unlocked;
+	}
+#endif
+
 #ifdef CONFIG_SPI_FLASH_SST
 	/*
 	 * sst26 series block protection implementation differs from other
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 8ca874068a..9a560d94a2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -77,6 +77,8 @@
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
 #define SPINOR_OP_SRSTEN	0x66	/* Software Reset Enable */
 #define SPINOR_OP_SRST		0x99	/* Software Reset */
+#define SPINOR_OP_RDFR		0x48	/* Read Function register */
+#define SPINOR_OP_WRFR		0x42	/* Write Function register 1 byte */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
@@ -169,6 +171,7 @@
 #define SR_BP2			BIT(4)	/* Block protect 2 */
 #define SR_BP3			BIT(6)  /* Block protect 3 */
 #define SR_BP3_MX		BIT(5)	/* Block protect 3 (Macronix) */
+#define SR_BP3_ISSI		BIT(5)	/* Block protect 3 (ISSI) */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 
@@ -192,6 +195,9 @@
 #define FSR_P_ERR		BIT(4)	/* Program operation status */
 #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
 
+/* Function register bit */
+#define FR_TB			BIT(1)	/*ISSI: Top/Bottom protect */
+
 /* Configuration Register bits. */
 #define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
 #define CR_TB_MX		BIT(3)	/* Macronix Top/Bottom protect */
@@ -322,6 +328,7 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
 	SNOR_F_HAS_STACKED	= BIT(9),
 	SNOR_F_HAS_PARALLEL	= BIT(10),
+	SNOR_F_HAS_BP3		= BIT(11),
 };
 
 struct spi_nor;
-- 
2.27.0

