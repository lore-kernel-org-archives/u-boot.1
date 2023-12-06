Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6668CC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59128878AD;
	Wed,  6 Dec 2023 10:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q+PvCJWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57545878AF; Wed,  6 Dec 2023 10:34:06 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BD6878AD
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvvPDhE9o/pCJ6MSvhxSh3Udgq/Ha3C0aahXhTLZgsmA5RtuFFHC8FOQHgdPYVPk4teinj7hh93zpaeCsk/GeTSantbVpBeFhQnAVf+xejZlvqW0EYjIn+OSYtIrlyRY64CJaNJBPUwb8100gGZFXmlKn4hnSraDJ0xKLo7XQvS1DDQkNAlOiZKkaF8jhf/sSkRxJ01jXl1bVr8uodDzooB2hdQabmhpCdtwT8wWqgaT7BzD4j3gNZ8yZYbKxc9iaVXd3PR363H3HASbrYMb04cCiZ14IP8UobTveEN1qtGc4Y2HzwryuV8C361FA1qQu6kz44Tk6tJq320kKZF7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8z3alzYiQiRYQJ74JUHCx6SVAr3CYoc/Z0A+ooF580=;
 b=DCA3U4sByC/3BW6dbrw8NIItRZlSUwJ3uYvetLzTeNVd3R8bXlBNkDR54nSf9Zryeg4A10v576FF/jKBm1KcLNzNc9Jr8ICTQcPSSsrfO4q4a7kFENtvEimQlgxaVAQ6uwzXFJ7XMAVaDfHChq2Nz/mdVK6Eb2TfBLIVKUXC+dDJyksYo1OipeDd9ZyLrHdzxvk8OedGEPn2T2n2kJfEvvvlgBWm3hpLbYcxKpgMTPr4pm/A9Dq9EcvPGBm2O+v4iRHqBCob7EAJssaEZX96Aje42FFYay3mDgwu28i1vCAEOpzUjYboY1Pm9vflEYGM/JRtXuEl4VgNmaWS/QHffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8z3alzYiQiRYQJ74JUHCx6SVAr3CYoc/Z0A+ooF580=;
 b=Q+PvCJWZsfWhJsxMEaPdn9BvWwZeFFWUd3WuD2H+1bJ7cOWpjmp4G6ZgLxapEcwdrpE+zhdxTomYmHzW0cSOr0E9MvL1AdZKf1O77qKRoc1DSAmxBedrn46Mj+bvesu/2uyC2OTSuRZjHK7c1czpn+LbQ9lllxaQcy675uNhbb4=
Received: from CH0PR03CA0405.namprd03.prod.outlook.com (2603:10b6:610:11b::15)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:33:58 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::ee) by CH0PR03CA0405.outlook.office365.com
 (2603:10b6:610:11b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:33:53 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:51 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 29/30] mtd: spi-nor: Add support for locking on GIGADEVICE
 nor flashes
Date: Wed, 6 Dec 2023 15:01:40 +0530
Message-ID: <1e991a2dcc6fac0c6be16a7573deddffaa83026a.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 69df38fc-44d0-4293-6e70-08dbf63e78e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5zz6/k4OH5gdCNSVIkkuOfwFHTxf/K6nN6GvtAoZzKhfKd7wj29E8aJtWq6lO9dlhmdXlgH+KnDRBrGmU1yguJB/ScOjuF72OqOsQogX6tYvomUJqqD3jX2IWHVfTNBvEBQaUcvE+db7yR7iZxpl5SR8/vXcZ+7Gwud+5xQ+A7c38Fsr/oxLaO1CI94DXgzi/Cms1xBGl0UnF8DluNvK6xKmeB5fjXBPFthfiyn0XMD4gQ0gwBKfC3zPu5UHouGOGGqj46EwfFvhHMie2Hm+tnJYEfualO4iY+JLmoxQOBpRXbf0dFrMw9GZiEnh3QRyJf/zf3PgrfXGf+N314ceFUswlFa7ClPd/YtUqQuDJJxyNzNX8bKSx3vXfvEi6YEwx4QkojkO34lIZk1w+TtlULJe255jSUtUne1H9G6EtISNyQgzTcwTsrGS0kpRcxXHTAlibSqzNCDO0j8Krh1rwU9cTX1gUdMAr2M5PLby0qErz6jEtIipwM+sKGEIAXeDsL1+yHTfqYXizj8kgKOIsCVsXT3HjgCXgdxqYoUE4z3XzsH4kyaAtb/w/3dKjkBUbcYalRD3LvYi8hcA7zlJqYmL1kMxjCdPGXh8z+4WaqOiAF/zkA4e0fGEUf/2raBhwvpWn1EanNb7Xg8MMbgN+tXpATWv1nquhNjye2Qakf5f3yz5Eonfc0DafXKr5yq3svKKm7xzyu51csvgIK1x5bLoUxMhTVDB0zGJTwfNcCVA9ytsMFPM4TtIVraBxEY1imXaKEP7qsMkQ5IIv2hFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(81166007)(47076005)(356005)(2906002)(5660300002)(82740400003)(83380400001)(336012)(426003)(6666004)(26005)(2616005)(478600001)(70206006)(70586007)(54906003)(36756003)(41300700001)(4326008)(8676002)(6916009)(8936002)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:57.3655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69df38fc-44d0-4293-6e70-08dbf63e78e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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

GIGADEVICE nor flashes provide block protection support using
BP0, BP1, BP2, BP3 & TB bits in status register.

BP(Block Protection) bits defines memory to be software
protected against PROGRAM or ERASE operations. When one or more
block protect bits are set to 1, a designated memory area is
protected from PROGRAM and ERASE operations. TB(Top/Bottom) bit
determines whether the protected memory area defined by the block
protect bits starts from the top or bottom of the memory array.

Used bottom/top protect to test lock/unlock on zc1751+dc1 board.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 309 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   2 +
 2 files changed, 311 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 3bf1e5471b..3e2491cc3e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -5164,6 +5164,307 @@ static int issi_flash_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return ret;
 }
 #endif /* CONFIG_SPI_FLASH_ISSI */
+
+#if defined(CONFIG_SPI_FLASH_GIGADEVICE)
+static void giga_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
+				  uint64_t *len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int shift = 0;
+	int pow;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_GIGA;
+	u32 sector_size;
+
+	sector_size = nor->sector_size;
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		sector_size >>= 1;
+
+	shift = ffs(mask) - 1;
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
+		/* GIGA device's have top/bottom select bit in status reg */
+		if (nor->flags & SNOR_F_HAS_SR_TB && sr & SR_TB_GIGA)
+			*ofs = 0;
+		else
+			*ofs = mtd->size - *len;
+	}
+}
+
+/**
+ * giga_check_lock_status_sr() - check the status register and return
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
+static int giga_check_lock_status_sr(struct spi_nor *nor, loff_t ofs, u64 len,
+				     u8 sr, bool locked)
+{
+	loff_t lock_offs;
+	u64 lock_len;
+
+	if (!len)
+		return 1;
+
+	giga_get_locked_range(nor, sr, &lock_offs, &lock_len);
+	if (locked)
+		/* Requested range is a sub-range of locked range */
+		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+
+	/* Requested range does not overlap with locked range */
+	return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+}
+
+/**
+ * giga_is_locked_sr() - check if the memory region is locked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ *
+ * Check if memory region is locked.
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int giga_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+			     u8 sr)
+{
+	return giga_check_lock_status_sr(nor, ofs, len, sr, true);
+}
+
+/**
+ * giga_is_unlocked_sr() - check if the memory region is unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ *
+ * Check if memory region is unlocked.
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int giga_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+			       u8 sr)
+{
+	return giga_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/**
+ * giga_is_unlocked() - check if the memory region is unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ *
+ * Check if memory region is unlocked
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int giga_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int sr;
+
+	sr = read_sr(nor);
+	if (sr < 0)
+		return sr;
+
+	return giga_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/**
+ * giga_nor_select_zone() - Select top area or bottom area to lock/unlock
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
+static int giga_nor_select_zone(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				u8 sr, bool *tb, bool op)
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
+		if (giga_is_locked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is unlocked, we can't use 'bottom'
+		 * protection.
+		 */
+		if (!giga_is_locked_sr(nor, 0, ofs, sr))
+			can_be_bottom = false;
+
+		/*
+		 * If anything above us is unlocked, we can't use 'top'
+		 * protection.
+		 */
+		if (!giga_is_locked_sr(nor, ofs + len,
+				       nor->mtd.size - (ofs + len), sr))
+			can_be_top = false;
+	} else {
+		/* Select unlock zone */
+
+		/*
+		 * If nothing in our range is locked, we don't need to
+		 * do anything.
+		 */
+		if (giga_is_unlocked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is locked, we can't use 'top'
+		 * protection
+		 */
+		if (!giga_is_unlocked_sr(nor, 0, ofs, sr))
+			can_be_top = false;
+
+		/*
+		 * If anything above us is locked, we can't use 'bottom'
+		 * protection
+		 */
+		if (!giga_is_unlocked_sr(nor, ofs + len,
+					 nor->mtd.size - (ofs + len), sr))
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
+ * giga_flash_lock() - set BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Lock a region of the flash.Implementation is based on stm_lock
+ * Supports the block protection bits BP{0,1,2,3} in status register
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int giga_flash_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int status_old, status_new, blk_prot;
+	loff_t lock_len;
+	u8 pow, ret, shift;
+	bool use_top = false;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_GIGA;
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
+	log_debug("SPI Protection: %s\n", (status_old & SR_TB_GIGA) ? "bottom" : "top");
+
+	ret = giga_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
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
+	pow = order_base_2(lock_len);
+	blk_prot = mask & (((pow + 1) & 0xf) << shift);
+	if (lock_len <= 0) {
+		dev_err(nor->dev, "invalid Length to protect");
+		return -EINVAL;
+	}
+
+	status_new = status_old | blk_prot;
+	if (!use_top)
+		status_new |= SR_TB_GIGA;
+	else
+		status_new &= ~SR_TB_GIGA;
+
+	if (status_old == status_new)
+		return 0;
+
+	return write_sr_and_check(nor, status_new, mask);
+}
+
+/**
+ * giga_flash_unlock() - clear BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to unlock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Bits [2345] of the Status Register are BP[0123].
+ * Clear the corresponding BP status bits.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int giga_flash_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret, val;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3_GIGA;
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
+		dev_info(nor->dev, "block protect bits cleared SR: 0x%x\n",
+			 ret);
+		ret = 0;
+	}
+	return ret;
+}
+#endif /* CONFIG_SPI_FLASH_GIGADEVICE */
 #endif /* CONFIG_SPI_FLASH_LOCK */
 
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET
@@ -5399,6 +5700,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	}
 #endif
 
+#if defined(CONFIG_SPI_FLASH_GIGADEVICE)
+	if (JEDEC_MFR(info) == SNOR_MFR_GIGADEVICE) {
+		nor->flash_lock = giga_flash_lock;
+		nor->flash_unlock = giga_flash_unlock;
+		nor->flash_is_unlocked = giga_is_unlocked;
+	}
+#endif
+
 #ifdef CONFIG_SPI_FLASH_SST
 	/*
 	 * sst26 series block protection implementation differs from other
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 9a560d94a2..797f0f275a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -172,6 +172,8 @@
 #define SR_BP3			BIT(6)  /* Block protect 3 */
 #define SR_BP3_MX		BIT(5)	/* Block protect 3 (Macronix) */
 #define SR_BP3_ISSI		BIT(5)	/* Block protect 3 (ISSI) */
+#define SR_TB_GIGA		BIT(6)  /* Top/Bottom protect (GIGADEVICE)*/
+#define SR_BP3_GIGA		BIT(5)	/* Block protect 3 (GIGADEVICE) */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 
-- 
2.27.0

