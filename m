Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8048CC46CA3
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDD4876D9;
	Wed,  6 Dec 2023 10:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gSBifXKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB8286D85; Wed,  6 Dec 2023 10:32:21 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70028753C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQEbjk0cTAe48z12YzH4VzGNUxwLW9YLe1LDgV/G0bvlvpPTYi65xU1M5LKm/CBD6jRo/lhcFb4jvz00kHo2MnCGT0B6oRqu1oT8Y2ZdHLX2O0XmibI2JWJMaH1RKN2ezVf4eqzsYsABEJi36XuIQqRPTzQbMNibPIlO247I3zrFcThVjxYAnVQmMwfGIinvDdrnJHUa0g9Du2lwl4dcyPqckyHxbIA2QMSgjgyQFRBvAeZPFozpeGxwIUGskIGu8MWQbHa6i8n2jcLS6DY/sZvdWuumln2pG47CzrGQcCb8v32LGUDvSWmL3btYzJNfj0eHrdTGyTQ33Ic74xYBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG+VRGfKAl45USZcFAExKOVlH9sDLFZFmNk/+xUbsBI=;
 b=InsnX7nLDbqWW0ABvDQLn4PumVDMJRusivDYYKbiElOlcEjxJowqnG45EWR6f8J513eox3jyew+mOoeI6taMPxsWT60mI0buoLGAZn9aPn1yTs4o54XNbZBXdsSmZdQxiAYvg+NdmwVT4Yqp5xMasIYh8QGOV4gZc7j+cL1cBi2DsU7d0W2H4c/obMtEixgyKqw9vJT95WsDd74cFvJVnCdo2jzjDUmURLqMpCCMZ3tpF06IhNqaHPz7xi8ka8O9OYUI2XeIhiDEmc2aHe08kC6sjJ8CqyCNkeHC2Q579cwJ5fLoH+UFEMECiI3jinpEYflotONDA06D9aBLoQPjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG+VRGfKAl45USZcFAExKOVlH9sDLFZFmNk/+xUbsBI=;
 b=gSBifXKJnmCB8fWf8bntjC2ceiPgRRyRTdHvZQIHsKLgQfN/69TMUV3aINDMv1Rxrx3b+/vtVyEK4aquKYZwb+7vNSZikGipJ0lRHHYYWf3XcNpTqGVK1iKZW3LOvRcjzA9xa15pQfeHIDd62XgWj2Z4KataXX8MUQWqs6LIpRw=
Received: from BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:32:16 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::32) by BLAPR03CA0012.outlook.office365.com
 (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.32 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:09 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:06 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@xilinx.com>, Michal Simek
 <michal.simek@xilinx.com>
Subject: [PATCH v2 05/30] mtd: spi-nor: Add support for cross die read in dual
 flash configuration
Date: Wed, 6 Dec 2023 15:01:16 +0530
Message-ID: <025b915f46b4aeffd0a224dae195de36fe68a9f7.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da05c80-8500-4a04-0750-08dbf63e3c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2x4v34xGZ05VQEBd44gwSBxo/Fw47EJ3bE20UlNyi06KoKkD48Li2ZIAObjVa/E+JlN5IpcBsnpc9i+6V6aYsHHWYEpVqeklv0jbG5GNDhlkKSpr5SinyYchjUxfLJ4ypIscngCIX5RH1CoBgfaWCX3an6o6fuhbGcg8LfmAxGgPlDW+JFnhAKfFakeUZGmGSgngjEFfciv8WhVHnT+mYgZyuX7Mbzgj3Cb+UpYyRg8yIBhWZKkLWF2gfvzjt+1iPR3R3RNdnlE5Cydsq6zYVD80sn52hWvVqRR4hQ10IsEd/JPTx2bAcOo5BpiIDsknLaPZ811uFFoVxEwpycaeRW0GloYbw71borFaesidIHHTxvE6uElF8+XB3Tk9xuUlHFrRwc3cLZMMeAvWO2TU39+ncPKRvj2Bhemi4CrMfWVm02oxnAi0YstWENVVbgJc2sVnMF/SudLFbMOoscttzEwnp5QcqDoTPDyTey9f5wWQpU4qseMcSkiitfTk3HUR/s1M08o8ILd82SpPQrFEuRcQIQbmu1V+2ur7DIv9oV/cKqKgA0WKnRY2mrvshjwyVx2HXvbpkiCatacogUMDdGYhnN/ET+fsN7ThitDTLe9F8jaVJElgl2gXmiL9J5JedoQsyKfqvughsnrrswWbGRbmrh18pFSyPZSw0jPP0uPGZfiwGRMrhwA73kM52JVTC3Lc76vIJ4iB0RsVGlLRpNlaS6puC9ABW6uEd6x0jkrctgB7KjdbGwf6Xj7KtfuIB6jH7ACnLv7PLO8PTI/Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(36756003)(41300700001)(86362001)(4326008)(8936002)(8676002)(316002)(70586007)(6916009)(54906003)(70206006)(40480700001)(36860700001)(47076005)(82740400003)(356005)(81166007)(478600001)(40460700003)(426003)(83380400001)(6666004)(336012)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:15.7537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da05c80-8500-4a04-0750-08dbf63e3c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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

From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>

In a dual parallel configuration, halve the read offset.
Determine whether the read offset points to the lower or
upper flash in a dual stacked configuration and set the
corresponding flags accordingly.

Include support for cases where the read involves an odd
number of bytes.

Extend support for cross-die reads in flash memory devices
that contain multiple dies within them.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 61 ++++++++++++++++++++++++++++++----
 include/spi.h                  |  3 +-
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index e505648e5d..f6e7592458 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1503,11 +1503,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 	u32 offset = from;
-	u32 stack_shift = 0;
-	u32 read_len = 0;
-	u32 rem_bank_len = 0;
-	u8 bank;
-	u8 is_ofst_odd = 0;
+	u32 bank_size, stack_shift = 0, read_len = 0, rem_bank_len = 0;
+	u8 bank, cur_bank, nxt_bank, is_ofst_odd = 0;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
@@ -1541,6 +1538,40 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			}
 		}
 
+		if (nor->addr_width == 4) {
+			/*
+			 * Some flash devices like N25Q512 have multiple dies
+			 * in it. Read operation in these devices is bounded
+			 * by its die segment. In a continuous read, across
+			 * multiple dies, when the last byte of the selected
+			 * die segment is read, the next byte read is the
+			 * first byte of the same die segment. This is Die
+			 * cross over issue. So to handle this issue, split
+			 * a read transaction, that spans across multiple
+			 * banks, into one read per bank. Bank size is 16MB
+			 * for single and dual stacked mode and 32MB for dual
+			 * parallel mode.
+			 */
+			if (nor->spi && nor->spi->multi_die) {
+				bank_size = SZ_16M;
+				if (nor->flags & SNOR_F_HAS_PARALLEL)
+					bank_size <<= 1;
+				cur_bank = offset / bank_size;
+				nxt_bank = (offset + len) / bank_size;
+				if (cur_bank != nxt_bank)
+					rem_bank_len = (bank_size *
+							(cur_bank + 1)) -
+							offset;
+				else
+					rem_bank_len = (mtd->size >>
+							stack_shift) -
+							offset;
+			} else {
+				rem_bank_len = (mtd->size >> stack_shift) -
+						offset;
+			}
+		}
+
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
 
@@ -1552,6 +1583,15 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 #endif
 		}
 
+		if (len < rem_bank_len)
+			read_len = len;
+		else
+			read_len = rem_bank_len;
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto read_err;
+
 		ret = nor->read(nor, offset, read_len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
@@ -1561,8 +1601,15 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (ret < 0)
 			goto read_err;
 
-		*retlen += ret;
-		buf += ret;
+		if (is_ofst_odd == 1) {
+			memcpy(buf, (buf + 1), (len - 1));
+			*retlen += (ret - 1);
+			buf += ret - 1;
+			is_ofst_odd = 0;
+		} else {
+			*retlen += ret;
+			buf += ret;
+		}
 		from += ret;
 		len -= ret;
 	}
diff --git a/include/spi.h b/include/spi.h
index eb015ecbf5..9014066ee3 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -165,7 +165,7 @@ struct spi_slave {
 	unsigned int max_write_size;
 	void *memory_map;
 
-	u8 flags;
+	u32 flags;
 #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
 #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
@@ -179,6 +179,7 @@ struct spi_slave {
 	 */
 	bool multi_cs_cap;
 	u32 bytemode;
+	bool multi_die;			/* flash with multiple dies */
 };
 
 /**
-- 
2.27.0

