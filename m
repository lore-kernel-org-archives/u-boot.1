Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51913C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B176876E8;
	Wed,  6 Dec 2023 06:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vy3Lf15W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F11B4876E8; Wed,  6 Dec 2023 06:35:25 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9727B87721
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oANKm/EJRalDNWFSjwTuHmdLlAkGGAxNVDHGUv2CYcZdsh0qJJX7jI2+1LnJF89Jza33IpnqaOPQBDNzk7y7Q8K+6yPvk9USpMFzFrquSc4kEd6KQz41G+SzJHnQcwaEPtpcV7jF98O0Gf98axgQBqCK+/76keVr7gporZduFnxxvQIGm7q1whvToLAxAOi5GB1fNwW0lHqWcT16+NWXxnZfMxR/WwiXk6sKZhtlB5p7QZV+8z2WmSMidqbuDC/IN3NCu7K+DJsw3okMIb00Wgab2KOwywmqBDRA/QypzPjHQ2k4DMCb5ZVxQczdeyiZeObmJjlffXYdvWhY6Vpmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbL647UcEHlj0GiXoNktZv2UVy5GWTfSY+rtkn/2hq4=;
 b=W3nPJT/2R8HKXZncBhs+oOH8pK4aYx+lAzo3fzA+A6TngKz01UrFmjggYhHa8QW4XwtmVN8UhZTeKMrbeYcyDnJe6iTN5yzdcE61uJDJ0s1tmFFzYdu8kb3tr+DNKr4nwPtnsd9IqLzzm/14996raveHsWkjUlCppl3x6XBgAghMkdHkiM3mLEW3q3rFirfLWQ8Y0iFFnLJbFU0i1vRIWG5ttw3p7/NB2nkY9YkFBxkl31FG+y0x6PG9NiNAzaWd2dRwSZifYRLTULYf2m+mNmsndidWb2cwBUTFz7Q6CMk06DwcrijGvJeRZJsqfJNBLRuJom+7MkHLmfinn+4DGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbL647UcEHlj0GiXoNktZv2UVy5GWTfSY+rtkn/2hq4=;
 b=Vy3Lf15W33xl+5weHH66Bu1cBAirPRcEtnSLOcuCGJpljSrnLlp8Mdq1CDJzqYePzAvpqy7IxQqvMyAZeBZCR0PuAq7C1udzMUU2iaXxt7KDuJx+7JSWOVFSrA34bWyWU188oWDGSMSW+RFJx/M8OWOeAsnCV9lY2mULXRWhGrI=
Received: from MN2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:c0::17)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:35:10 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::35) by MN2PR05CA0004.outlook.office365.com
 (2603:10b6:208:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 05:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:35:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:35:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:35:08 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:35:05 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>, Siva Durga Prasad Paladugu
 <siva.durga.paladugu@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 26/30] mtd: spi-nor: Add block protection support for micron
 flashes
Date: Wed, 6 Dec 2023 11:04:40 +0530
Message-ID: <20231206053443.3746237-7-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eab3025-d5ca-47b9-b74c-08dbf61d1d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgGtABpI1TsWjKpHbrawnIqHAul27bZRvoeCPEZvCNk21aGpK6hetWidOAsCoIinI7brcVCdUoDLA53kVU3zYbTnbp2C7IfYCbH7j8eyDxr92OnVo0i7jg1ckYlYRnW4TLy7dS9uuylWLDjQ5KHA6Zb8Mr/deuonlZGRz1nfyf+97lKn6s5YZutgN+pfoxoVnU0jVvnID/1QWs+x47bGobkTf5pEbQe3ZpAdDFiP1vz8qn8PeJmZ6DAPGkwe2MNETwcubEM7tTrhW70Ieo8TI1qqFMNCT2LxrQ9/kCrc/r63RpnyT5+km2rzDuZ5Dbf2YlrRFAiWHORQqIv84qQ8SwUHlliQzmm++nOmYOdZZNTO+BC+6f1wk3adMt/AxnQ+A3/LTQ80aPz/o/qQvgo4KToHzF04fFOiEKggmF3bCbHF+HeDwWnhISaOPVRIeTJxWQdFwTZh4JTHgkWiKlmUexFyQXKDj6DMfagj52wR+Pg93GxCcA829Qv8w1R2AxhBM55I8EwM5uMsbJsRh0HOdqHDZi5kYKMvcsDsBzP6lteePy2xAT1WKklQzX4CSbRrbsrwi94NBBYL5b1WrjONbLcLzIbgdJWSxjDBfGDL63W6MrK1nTHEIBlLj9KYLA5CqUNVaU8XSvaU8c7fJ1/yF3f8vGUKraOlD0EwdT5FrjaLQ3REziV7ZyB1xm4VXR90eeH4ISUj+KAiCRsgf5WbpX2LBaKnxrlBLUVwA5FQSUGPIiNJYTDaKl+MinxfOPikIsFMOPuDJkvvNKiDNbCVFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(8936002)(4326008)(8676002)(5660300002)(36756003)(6666004)(1076003)(2616005)(316002)(54906003)(70206006)(6916009)(70586007)(478600001)(41300700001)(36860700001)(2906002)(81166007)(356005)(82740400003)(103116003)(40480700001)(47076005)(40460700003)(86362001)(26005)(336012)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:35:10.4248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eab3025-d5ca-47b9-b74c-08dbf61d1d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

Micron nor flashes provide block protection support using
BP0, BP1, BP2, BP3 & TB bits in status register. This patch
supports for micron nor flashes with manufacturer id 0x20
and 0x2c.

Where BP(Block Protection) bits defines memory to be software
protected against PROGRAM or ERASE operations. When one or more
block protect bits are set to 1, a designated memory area is
protected from PROGRAM and ERASE operations. TB(Top/Bottom) bit
determines whether the protected memory area defined by the block
protect bits starts from the top or bottom of the memory array.

Block Protection table for N25Q00AA with size 128MB, sector size 64KB
and with 2048 sectors.

Top protection:
--------------
TB	BP3	BP2	BP1	BP0	Protected Area		Un-Protected Area
0	0	0	0	0	None			All sectors
0	0	0	0	1	Sector 2047		Sectors (0 to 2046)
0	0	0	1	0	Sectors (2046 to 2047)	Sectors (0 to 2045)
0	0	0	1	1	Sectors (2044 to 2047)  Sectors (0 to 2043)
0	0	1	0	0	Sectors (2040 to 2047)  Sectors (0 to 2039)
0	0	1	0	1	Sectors (2032 to 2047)  Sectors (0 to 2031)
0	0	1	1	0	Sectors (2016 to 2047)  Sectors (0 to 2015)
0	0	1	1	1	Sectors (1984 to 2047)  Sectors (0 to 1983)
0	1	0	0	0	Sectors (1920 to 2047)  Sectors (0 to 1919)
0	1	0	0	1	Sectors (1792 to 2047)  Sectors (0 to 1791)
0	1	0	1	0	Sectors (1936 to 2047)  Sectors (0 to 1535)
0	1	0	1	1	Sectors (1024 to 2047)	None

Bottom protection:
-----------------
TB	BP3	BP2	BP1	BP0	Protected Area		Un-protected Area
1	0	0	0	0	None			All sectors
1	0	0	0	1	sector 0		Sectors (1 to 2047)
1	0	0	1	0	Sectors (0 to 1)	Sectors (2 to 2047)
1	0	0	1	1	Sectors (0 to 3)	Sectors (4 to 2047)
1	0	1	0	0	Sectors (0 to 7)	Sectors (8 to 2047)
1	0	1	0	1	Sectors (0 to 15)	Sectors (16 to 2047)
1	0	1	1	0	Sectors (0 to 31)	Sectors (32 to 2047)
1	0	1	1	1	Sectors (0 to 63)	Sectors (64 to 2047)
1	1	0	0	0	Sectors (0 to 127)	Sectors (128 to 2047)
1	1	0	0	1	Sectors (0 to 255)	Sectors (256 to 2047)
1	1	0	1	0	Sectors (0 to 511)	Sectors (512 to 2047)
1	1	0	1	1	Sectors (0 to 1023)	Sectors (1024 to 2047)

Signed-off-by: Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 255 +++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |   7 +
 2 files changed, 262 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ccda722df5..c40899a281 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4336,6 +4336,253 @@ static int spi_nor_init(struct spi_nor *nor)
 	return 0;
 }
 
+#if defined(CONFIG_SPI_FLASH_LOCK)
+#if defined(CONFIG_SPI_FLASH_STMICRO)
+static inline uint16_t min_lockable_sectors(struct spi_nor *nor,
+					    uint16_t n_sectors)
+{
+	/* lock granularity */
+	return 1;
+}
+
+static inline uint32_t get_protected_area_start(struct spi_nor *nor,
+						u8 lock_bits,
+						bool is_bottom)
+{
+	u16 n_sectors;
+	u32 sector_size, flash_size;
+	int ret;
+
+	sector_size = nor->sector_size;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		n_sectors = (nor->size >> 0x01) / sector_size;
+		flash_size = nor->size >> 0x01;
+	} else {
+		n_sectors = nor->size / sector_size;
+		flash_size = nor->size;
+	}
+
+	if (!is_bottom)
+		ret = flash_size - ((1 << (lock_bits - 1)) * sector_size *
+				    min_lockable_sectors(nor, n_sectors));
+	else
+		ret = (1 << (lock_bits - 1)) * sector_size *
+		       min_lockable_sectors(nor, n_sectors);
+
+	return ret;
+}
+
+static uint8_t min_protected_area_including_offset(struct spi_nor *nor,
+						   u32 offset,
+						   bool is_bottom)
+{
+	u8 lock_bits, lockbits_limit;
+
+	lockbits_limit = MAX_LOCKBITS;
+
+	for (lock_bits = 1; lock_bits < lockbits_limit; lock_bits++) {
+		if (!is_bottom) {
+			/* top protection */
+			if (offset >= get_protected_area_start(nor,
+							       lock_bits,
+							       is_bottom))
+				break;
+		} else {
+			/* bottom protection */
+			if (offset <= get_protected_area_start(nor,
+							       lock_bits,
+							       is_bottom))
+				break;
+		}
+	}
+	return lock_bits;
+}
+
+static int write_sr_modify_protection(struct spi_nor *nor, u8 status,
+				      u8 lock_bits, bool is_bottom)
+{
+	u8 status_new, bp_mask;
+	int ret;
+
+	status_new = status & ~BP_MASK;
+	bp_mask = (lock_bits << BP_SHIFT) & BP_MASK;
+
+	status_new &= ~SR_BP3;
+	/* Protected area starts from top */
+	status_new &= ~SR_TB;
+
+	/* If bottom area is to be Protected set SR_TB */
+	if (is_bottom)
+		status_new |= SR_TB;
+
+	if (lock_bits > 7)
+		bp_mask |= SR_BP3;
+
+	status_new |= bp_mask;
+
+	write_enable(nor);
+
+	nor->spi->flags |= SPI_XFER_LOWER;
+
+	ret = write_sr(nor, status_new);
+	if (ret)
+		return ret;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		nor->spi->flags |= SPI_XFER_UPPER;
+		ret = write_sr(nor, status_new);
+		if (ret)
+			return ret;
+	}
+
+	return write_disable(nor);
+}
+
+static void micron_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
+				    uint64_t *len)
+{
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2;
+	int shift = ffs(mask) - 1;
+	int pow;
+	u64 norsize = nor->size;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		norsize /= 2;
+
+	if (!(sr & (mask | SR_BP3))) {
+		/* No protection */
+		*ofs = 0;
+		*len = 0;
+	} else {
+		pow = (sr & mask) >> shift;
+		pow |= sr & SR_BP3 ? BIT(3) : 0;
+
+		if (pow)
+			pow--;
+
+		*len = nor->sector_size << pow;
+		if (*len >= norsize)
+			*len = norsize;
+
+		if (!(sr & SR_TB))
+			*ofs = norsize - *len;
+		else
+			*ofs = 0;
+
+		debug("%s, ofs:0x%lx, len:0x%lx\n", __func__,
+		      (unsigned long)*ofs, (unsigned long)*len);
+	}
+}
+
+static int micron_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				 u8 sr)
+{
+	loff_t lock_offs;
+	u64 lock_len;
+	int given_range, locked_range;
+	bool locked_value = false;
+	bool offset_value = false;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		ofs /= 2;
+
+	/* Avoid dividing by 2 of data length for size 1 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL && len != 1)
+		len /= 2;
+
+	debug("%s, ofs:0x%lx, len:0x%lx\n", __func__,
+	      (unsigned long)ofs,
+	      (unsigned long)len);
+
+	micron_get_locked_range(nor, sr, &lock_offs, &lock_len);
+
+	given_range = ofs + len;
+	locked_range = lock_offs + lock_len;
+
+	if (given_range <= locked_range)
+		locked_value = true;
+
+	if (ofs >= lock_offs)
+		offset_value = true;
+
+	if (sr & SR_TB)
+		return !locked_value;
+
+	return !(locked_value && offset_value);
+}
+
+static int micron_flash_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	u8 status_old, status_old_up;
+	u8 lock_bits;
+	loff_t lock_len;
+	int ret = 0;
+	bool is_bottom = false; /* Use TOP protection by default */
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
+	status_old = read_sr(nor);
+	if (status_old < 0)
+		return status_old;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		nor->spi->flags |= SPI_XFER_UPPER;
+		status_old_up = read_sr(nor);
+		if (status_old_up < 0)
+			return status_old_up;
+		if ((status_old & BPTB_MASK) != (status_old_up & BPTB_MASK)) {
+			printf("BP is different in both flashes lo:0x%x, up:0x%x\n",
+			       status_old, status_old_up);
+			return -EINVAL;
+		}
+	}
+
+	if (ofs < nor->size / 2)
+		is_bottom = true;	/* Change it to bottom protection */
+
+	debug("Status in both flashes lo:0x%x, up:0x%x\n",
+	      status_old, status_old_up);
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		ofs /= 2;
+		len /= 2;
+	}
+
+	if (!is_bottom)
+		lock_len = ofs;
+	else
+		lock_len = ofs + len;
+
+	lock_bits = min_protected_area_including_offset(nor, lock_len,
+							is_bottom);
+
+	if (lock_bits > ((status_old & (BP_MASK << BP_SHIFT)) >> 2))
+		ret = write_sr_modify_protection(nor, status_old, lock_bits,
+						 is_bottom);
+
+	return ret;
+}
+
+static int micron_flash_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return write_sr_modify_protection(nor, 0, 0, 0);
+}
+
+static int micron_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int status;
+
+	status = read_sr(nor);
+	if (status < 0)
+		return status;
+
+	return micron_is_unlocked_sr(nor, ofs, len, status);
+}
+#endif /* CONFIG_SPI_FLASH_STMICRO */
+#endif /* CONFIG_SPI_FLASH_LOCK */
+
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET
 /**
  * spi_nor_soft_reset() - perform the JEDEC Software Reset sequence
@@ -4545,6 +4792,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	}
 #endif
 
+#if defined(CONFIG_SPI_FLASH_STMICRO)
+	if (JEDEC_MFR(info) == SNOR_MFR_ST || JEDEC_MFR(info) == SNOR_MFR_MICRON) {
+		nor->flash_lock = micron_flash_lock;
+		nor->flash_unlock = micron_flash_unlock;
+		nor->flash_is_unlocked = micron_is_unlocked;
+	}
+#endif
+
 #ifdef CONFIG_SPI_FLASH_SST
 	/*
 	 * sst26 series block protection implementation differs from other
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 34e0aedc24..03413063ae 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -166,8 +166,15 @@
 #define SR_BP0			BIT(2)	/* Block protect 0 */
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
+#define SR_BP3			BIT(6)  /* Block protect 3 */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
+
+#define BPTB_MASK		0x7C	/* BP & TB bits mask */
+#define BP_MASK			0x1C	/* BP bits mask */
+#define BP_SHIFT		0x2	/* BP shift*/
+#define MAX_LOCKBITS		15
+
 /* Spansion/Cypress specific status bits */
 #define SR_E_ERR		BIT(5)
 #define SR_P_ERR		BIT(6)
-- 
2.27.0

