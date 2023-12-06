Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D201DC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA56876EF;
	Wed,  6 Dec 2023 06:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XO1PmJ4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5536A87751; Wed,  6 Dec 2023 06:37:15 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76582875F8
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA35sgc0/ibOm8pjdmaHN+I/IrR2dDLM0p6yk69ut+0NLfhwd+ORZzgManxaUEoGwRHAxgRgYCD5P3MG8carhVdMe94xNUzZPzVk82XZQD6EY3v/JnbZC2kIDpaXYb1PcBM0mU/xEEySgaxisaNDMJa8EWUrgcvdGVQj/pfZDvzLmzDJce3fMvJuxPC54v88rU99rUn4ShVeMjZV2yg1+R5+2brAtZn3LswggfCfL0TsKBI5lLMFY9cUyDvDF6u/zlnmo+4j6AlTZ12O1XpQr+yqgd8kltkFBfGyYAwPGE/qVwoKkVjBfApXLxxKnq3BiQpDTPe0booDUsJYZ9CD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTJuQjLKzVV1Ev3noRcjUcY1QFgrSZH5SKs5nmf8Nbc=;
 b=ZcegGMg35tBxbYS5USTL1/55eb/86tCgREBypmegBrKNZ+PglZVjdQR8nYqakIeMeJwQ2Cp5/ojVxRKZ1z2ihQGSwwMFP9vLGd/2EbSFVROXV+De8fFVHCfRbuVuXDoRvKdqTZjfMH6QG3TTSFZatpcCwcDgyfjqAzlQExaj+Me8n1G5gSpOlZAoprzQkyDl1wfFicwr+2xDc4eY6xVCtXJgeMpa+y6G7OhL1JeRv8xXiW/2xL6uBgzjjdys+YlmeBtKYwTTDSewKEUGf+2qJKhQ2yXbSVmjFxJDAVCUPx4VkwNc77ZBCfm0O+8Wy6zYbHQ2Rv+EJeqhj7VjVjadPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTJuQjLKzVV1Ev3noRcjUcY1QFgrSZH5SKs5nmf8Nbc=;
 b=XO1PmJ4AoGM1q4NyepPv2c5Kzy2DJtFSlOHNV7QZgJsbsxJK3Hjta70cEtcdFfnAohbHcdB+/WwtcjhbH/5ZRY8OaC2uPwVDr0LvSLW2qth/cXP4a1Y8kK0Lq4UdPb7vZvrmOVX1UjXIWo6jr7TRDSwOKvXbBj4qxrJhks60ywM=
Received: from MN2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:208:239::23)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:37:08 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::ac) by MN2PR08CA0018.outlook.office365.com
 (2603:10b6:208:239::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 6 Dec 2023 05:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:37:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:37:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:36:42 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:36:40 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 30/30] mtd: spi-nor: Add support for locking on Spansion nor
 flashes
Date: Wed, 6 Dec 2023 11:06:28 +0530
Message-ID: <20231206053628.3746861-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: f30bdbc3-0ea2-464b-971c-08dbf61d634b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gjc1NQ1Kjjdx2NLw957wLCnSej7669wWCnnHUuik2LzROFQ4Z/l0ulEetu1l0lJ1n0SZZ4Ecyax1KRibyAxBQ+Te9OVtXTmLznLqB+tOzuyLxshKy7N7RhgbK2C1zzpnGcYO6GaFNw6wNXgzQ+0hGnHGOwtr3Unea6oqUmU4vKdoEPFR3ckK2Be89lCkVwzXJCOaO5pzl/Q7cnYxvU09fVhXUyb6/NXnFW/JPqKH0xw/Ssz9bdAN/BywW83kROoJLDcN79lgL5kXx1ZD91GrdSE1SoCwt9dhqKcxIYHC0xxm92+jwANy259uWs4nb7IDMSPqQcrIBqtJWcf0hQa7uVMQPA4deln91gOIH7Q+PoVTiH2wfegimcubzFx8uY6QjizEH9WcrYSE1dxuk+8EFM5sRAc/6nLmKaZ8DB5SNqj+Z1Ui2IlwCDtpjSpp/CBspGh39GUSkYhtCJVJpd9DhivXYZETdrmp6zB0usdf5J8DLTcSrHKa/frGv4t4uPFDCiHZg42osyzhXfySw54cTg8ZfTRDiOxoV3T8CpYp0F/H+97ZxijvQPTMVamU9FMVWoO5Eu2e1Dl5smwroLtJurXXpwJgZJ9JElmqrpvMH2bbr+2GFv3DQ5Yow1KCyVwRrQxaSTs9lUeVNZ7rbIS/hS8N4GEgetJQ5szCKmoIp7sGKL2AoTtl5JldGrVlZqz3xKgy2qxrBJXVCYJaZ37cFiTsb6yGUeO4JR8Cs9C0p4ITZRqBh3Kml+upfYVEUJ8xc+vqAWRnWMHqpWbaGj5Kpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(36840700001)(40470700004)(46966006)(40460700003)(54906003)(6916009)(316002)(86362001)(8676002)(4326008)(8936002)(478600001)(70206006)(70586007)(41300700001)(36756003)(30864003)(2906002)(5660300002)(103116003)(36860700001)(356005)(47076005)(81166007)(2616005)(26005)(1076003)(6666004)(83380400001)(82740400003)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:37:08.2971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30bdbc3-0ea2-464b-971c-08dbf61d634b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
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

Spansion nor flashes provide block protection support using
BP0, BP1, BP2 bits in status register.

The top/bottom select is instead done via a bit in the configuration
register, which is OTP, so once set to use bottom protect, one cannot
use top. On top of that, reading the configuration register uses a
different opcode (0x15) than the existing SPINOR_OP_RDCR (0x35).

Used bottom protect to test s25fl512s flash part lock/unlock
on zc1751+dc1 board.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 372 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   1 +
 2 files changed, 373 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 3e2491cc3e..42483caaaa 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -5465,6 +5465,370 @@ static int giga_flash_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return ret;
 }
 #endif /* CONFIG_SPI_FLASH_GIGADEVICE */
+
+#if defined(CONFIG_SPI_FLASH_SPANSION)
+/**
+ * spansion_read_cr() - read configuration register
+ * @nor: pointer to a 'struct spi_nor'.
+ *
+ * Spansion devices have top/bottom area protection bits selection into
+ * configuration reg. The bits in CR are OTP. So once it's written,
+ * it cannot be changed.
+ *
+ * Return: Value in configuration register or negative if error.
+ */
+static int spansion_read_cr(struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDCR, &val, 1);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d reading CR\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
+static void spansion_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
+				      uint64_t *len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int pow, cr;
+	int shift = 0;
+	u8 mask =  SR_BP0 | SR_BP1 | SR_BP2;
+
+	shift = ffs(mask) - 1;
+
+	cr = spansion_read_cr(nor);
+	if (!(sr & mask)) {
+		/* No protection */
+		*ofs = 0;
+		*len = 0;
+	} else {
+		pow = ((sr & mask) ^ mask) >> shift;
+		*len = mtd->size >> pow;
+		/* SPANSION device's have top/bottom select bit in configuration reg */
+		if (nor->flags & SNOR_F_HAS_SR_TB && cr & CR_TB_SPAN)
+			*ofs = 0;
+		else
+			*ofs = mtd->size - *len;
+	}
+}
+
+/**
+ * spansion_check_lock_status_sr() - check the status register and return
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
+static int spansion_check_lock_status_sr(struct spi_nor *nor, loff_t ofs, u64 len,
+					 u8 sr, bool locked)
+{
+	loff_t lock_offs;
+	u64 lock_len;
+
+	if (!len)
+		return 1;
+
+	spansion_get_locked_range(nor, sr, &lock_offs, &lock_len);
+	if (locked)
+		/* Requested range is a sub-range of locked range */
+		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+
+	/* Requested range does not overlap with locked range */
+	return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+}
+
+/**
+ * spansion_is_locked_sr() - check if the memory region is locked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ *
+ * Check if memory region is locked.
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int spansion_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				 u8 sr)
+{
+	return spansion_check_lock_status_sr(nor, ofs, len, sr, true);
+}
+
+/**
+ * spansion_is_unlocked_sr() - check if the memory region is unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ * @sr:  status register
+ *
+ * Check if memory region is unlocked.
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int spansion_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				   u8 sr)
+{
+	return spansion_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/**
+ * spansion_is_unlocked() - check if the memory region is unlocked
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset of the flash
+ * @len: length to be locked
+ *
+ * check if memory region is unlocked
+ *
+ * Return: false if region is locked 0 otherwise.
+ */
+static int spansion_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int sr;
+
+	sr = read_sr(nor);
+	if (sr < 0)
+		return sr;
+
+	return spansion_check_lock_status_sr(nor, ofs, len, sr, false);
+}
+
+/**
+ * spansion_nor_select_zone() - Select top area or bottom area to lock/unlock
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
+static int spansion_nor_select_zone(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				    u8 sr, bool *tb, bool op)
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
+		if (spansion_is_locked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is unlocked, we can't use 'bottom'
+		 * protection.
+		 */
+		if (!spansion_is_locked_sr(nor, 0, ofs, sr))
+			can_be_bottom = false;
+
+		/*
+		 * If anything above us is unlocked, we can't use 'top'
+		 * protection.
+		 */
+		if (!spansion_is_locked_sr(nor, ofs + len,
+					   nor->mtd.size - (ofs + len), sr))
+			can_be_top = false;
+	} else {
+		/* Select unlock zone */
+
+		/*
+		 * If nothing in our range is locked, we don't need to
+		 * do anything.
+		 */
+		if (spansion_is_unlocked_sr(nor, ofs, len, sr))
+			return 0;
+
+		/*
+		 * If anything below us is locked, we can't use 'top'
+		 * protection
+		 */
+		if (!spansion_is_unlocked_sr(nor, 0, ofs, sr))
+			can_be_top = false;
+
+		/*
+		 * If anything above us is locked, we can't use 'bottom'
+		 * protection
+		 */
+		if (!spansion_is_unlocked_sr(nor, ofs + len,
+					     nor->mtd.size - (ofs + len), sr))
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
+static int spansion_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
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
+/**
+ * spansion_flash_lock() - set BP[012] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Lock a region of the flash.Implementation is based on stm_lock
+ * Supports the block protection bits BP{0,1,2} in status register
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spansion_flash_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	u64 lock_len;
+	u32 sector_size;
+	u16 n_sectors;
+	unsigned int bp_slots, bp_slots_needed;
+	int cr, can_be_top, val, status_old;
+	u8 pow, ret, shift, sr_cr[2];
+	bool use_top = false;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2;
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
+	cr = spansion_read_cr(nor);
+	if (cr < 0)
+		return cr;
+
+	log_debug("SPI Protection: %s\n", (cr & CR_TB_SPAN) ? "bottom" : "top");
+
+	/* CR_TB is OTP, so we can't use 'top' protection if that is already set. */
+	can_be_top = !(cr & CR_TB_SPAN);
+
+	ret = spansion_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
+	/* Older protected blocks include the new requested block's */
+	if (ret <= 0)
+		return ret;
+
+	use_top = can_be_top;
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
+	val = pow << shift;
+	sr_cr[0] = status_old & ~mask;
+	sr_cr[0] |= val;
+
+	sr_cr[1] = cr | (use_top ? 0 : CR_TB_SPAN);
+	ret = spansion_write_sr_cr(nor, sr_cr);
+	if (ret)
+		return ret;
+
+	/* Check that the bits got written as expected */
+	ret = read_sr(nor);
+	if (ret < 0)
+		return ret;
+
+	ret = spansion_read_cr(nor);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * spansion_flash_unlock() - clear BP[012] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to unlock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Bits [234] of the Status Register are BP[012].
+ * Clear the corresponding BP status bits.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spansion_flash_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret, val;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2;
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
+	return 0;
+}
+#endif /* CONFIG_SPI_FLASH_SPANSION */
 #endif /* CONFIG_SPI_FLASH_LOCK */
 
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET
@@ -5708,6 +6072,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	}
 #endif
 
+#if defined(CONFIG_SPI_FLASH_SPANSION)
+	if (JEDEC_MFR(info) == SNOR_MFR_SPANSION) {
+		nor->flash_lock = spansion_flash_lock;
+		nor->flash_unlock = spansion_flash_unlock;
+		nor->flash_is_unlocked = spansion_is_unlocked;
+	}
+#endif
+
 #ifdef CONFIG_SPI_FLASH_SST
 	/*
 	 * sst26 series block protection implementation differs from other
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 797f0f275a..07d6c4ff93 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -203,6 +203,7 @@
 /* Configuration Register bits. */
 #define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
 #define CR_TB_MX		BIT(3)	/* Macronix Top/Bottom protect */
+#define CR_TB_SPAN		BIT(5)	/* Spansion Top/Bottom protect */
 
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
-- 
2.27.0

