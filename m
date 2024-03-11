Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87119C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D482787F7D;
	Mon, 11 Mar 2024 18:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxMXvhAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCE787F4E; Mon, 11 Mar 2024 18:23:38 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B04A87EFF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAySZqogxXPnmBwcF63r3wv/SaJaOI5zL4gTvNFVQP3ZMecPOq16JXVkXStRPV74sg/6Vw/GQH7I4WI/eZ49yq6283gAUsMveObn4QqaPfPyuUginnkBV05N1UaqQex5CtnS3Qppw3LePg5NlCFJ6RuBtyxuTL00Ukla+WTTJxEhYfiMSXnhANxxRjCE+nFqaUo7IqqShXrxpvYso0+Xb2HR9uS4utlZfd3Ro9EnQymjpPEEkvG6mOtj6DeIFOs6Duww9ZvjLMTfaLJs04T6brTEUk/pmKEvSnZbsJ2Xucx65eY3iQSjChzhWaksa+JzhgLNh+hTK00k9y9HZ3hs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZv98A1fn/7K0TMghBMOJKZrZ/mNjeLl9YJlJTrzMRw=;
 b=KpRKR8f8TWaUPeL++CXi3iIhAY4uzQj+6LgUfQ6EnxkHbdwmLPfKlBKq2AnKltpAkLiqlivkSYrRRpqwMyySGmtuQ86xaz8UyNR2FcHIY0qvWlOuoi/SkM49xYmCg6kfkPGPcAo1cFJZPFskaxjB59QCR2LNuTDISEr1dRlqJ3iO6R8GS3e/fQeRpHDb1TeY5U1xyhD9mTO1pkFnK79am4d1L7p0sGPicpBWE3ARcXEL5PydydiSF25PvEDQJACKAOHHhmofmP29eW8KjZnGGSGENoUL2vthq4/DxzUHywoFqZHpqkc0BPSWvBwWrMKOz9WEkWBbgCeA3/jgQZWzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZv98A1fn/7K0TMghBMOJKZrZ/mNjeLl9YJlJTrzMRw=;
 b=NxMXvhAj5cKtjf+Bos/t0PbSdLs2GEGjZiKU1JymfLEntLiU5LnAH+TXIr4z/J9ZO4Vb+UENUeE/5ZadTi6AnOW+Fz5a+kmirFQvtFhJQ/7Fus6D5PTmfUpL39wC3sY32ICotsF4s4Sthx1EDKIsLetVMimzMoPu7tykj/8+YM4=
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:32 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::89) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:30 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:28 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 13/19] mtd: spi-nor: Add support for cross die read in dual
 flash configuration
Date: Mon, 11 Mar 2024 22:52:43 +0530
Message-ID: <053fcdc0b80bba53d30b159d788621a9f6361c37.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 74322527-56b0-4905-deeb-08dc41eff972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9xVJkUOz7vKCW2GdJzv0i7eQ8pFWEpfk5FRGC1JteVo3LlMqkv5332aC0zENgwrXKmtAjJySSl6R73kaeyrmZ9YmCEfa4JFL4XSG2l7Oij6JZKnlNQ9MbOXlnbkprl6YzMQXby/aYQok2WU3KDfKY8teDuq/j7e0shO2ZSWUQalIa21GodDyPOA7oPdqu6OAZYPNlkFfIc2/59w3CVxSBKleNasU/RCF+9uXAjBj+gqB8te8q86GpeXQNyrzqEBA5fOx2NntrFlNuOlSyQHD659RukI049/g2aqfeJs7A81BbA0cZ0c5Rigs+ygKLlXa8nG0otCiaNn/+lNKDQBPeS+plWtOVdLMydjtdvZrhn9U64mR2JGa0SQfnLlWanvjJzT93d8DKZlS+Sgme385OYq91Nl8uVFX7lqs7asXVbtXln8zJB5BPXn2VMHGd69OKgN5ltesygj3js7B1H5ap7ByfWdR2xUSvFzpIrlFvpSAtDck/MaNPRdMv4xNMit1kh5WkQdZdRX6m+UOcGKl96+EwvsGqh6kJFwLEEPfNLJKFU9stJUzVzWjNhC126B3OdIzwGKDarBscyfg3lTninhks3QfR24+OkZSsu60rtqCJVj/u8C3hLj59isV8WNu5Igq7U7FmrFu8OSGIgyulS4tN77Zg8naDiOhrJT0kiPRiZbrnEgu3iXZKZ96ITxTCFlu6rWqZcMerhSdK+Yifzvh7aNQESpfPmv4E7FecrzkOfWuJIXCwzj7c3e9bBK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:31.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74322527-56b0-4905-deeb-08dc41eff972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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
 drivers/mtd/spi/spi-nor-core.c | 42 ++++++++++++++++++++++++++++++----
 include/spi.h                  |  3 ++-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index e0398a7a29..ffb9a48316 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1528,11 +1528,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
-	loff_t offset = from;
-	u32 read_len = 0;
-	u32 rem_bank_len = 0;
-	u8 bank;
-	bool is_ofst_odd = false;
+	u32 offset = from;
+	u32 bank_size, stack_shift = 0, read_len = 0, rem_bank_len = 0;
+	u8 bank, cur_bank, nxt_bank, is_ofst_odd = 0;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
@@ -1565,6 +1563,40 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
 
diff --git a/include/spi.h b/include/spi.h
index ade30fab73..7b6c49cfc5 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -166,7 +166,7 @@ struct spi_slave {
 	unsigned int max_write_size;
 	void *memory_map;
 
-	u8 flags;
+	u32 flags;
 #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
 #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
@@ -180,6 +180,7 @@ struct spi_slave {
 	 */
 	bool multi_cs_cap;
 	u32 bytemode;
+	bool multi_die;			/* flash with multiple dies */
 };
 
 /**
-- 
2.27.0

