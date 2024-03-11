Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B8CC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB9487FB5;
	Mon, 11 Mar 2024 18:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UU5HvktD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11ABF87FBC; Mon, 11 Mar 2024 18:23:52 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1DB87FB5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwN9l1jA5F8oIDPjdo+4t8y7lwv5dIrzt6gMGMIMbdozWDjKPcoHNTcYDgpIL/q0/ebiTHiNdPr7D15tCdxhAae+ToTv2unqDCECrd5FYxpZ6HB9mcUbPSSx4Bl01jIifLLgqdp/b8QjBqcWXAGJ8VlSWbwUmylcGTN20VltVgSdj35XuDYf4Lo1KuvAITN8DVvR+c0GKbc7PrtL+5MpW1GJGaJMYWPE5c8HmwzXQcCpiNVUJIvPNcPJxs7zJgJoEov9fnv5BtuB9ENxVmVAJgaM4MTRr4n46Fzh9odSMR4w3xHNgS0LDTH1s/YbOYUa/fM1sFDSTsePmys0DpRKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmBMeC2Ztqlhq0OpaoBx3r+wy/zMAH5eT4jCObxFDFw=;
 b=ScGPdErqbv49W8FNos2JH3YsB3xakvEPwqbfUSNWGjFV2WMDcfiXsJDekIV7wwrAABscGaNmdGt+CH7VNNq6ms1OrKQZLArvmwLJyp5FACftjj8bONAqLvOMOq6ufF3phKSqAWpbnxtTEQLRfT7PiOX5OslHfSwydRO/R9DtY5uFjxO+Rwehka/kEhdjDf8cVQZUY/ImBUhWZ1DmxC2KrGTaCqgN0ZDphMFNAGIbWhm6H/AkfMTZp+I3OTJUh0rpCIUQEIbZq3iRVxgHpCiO1ZalP9LiOPZnUhIWQGjXaUAKFss6TliFf2fj/cCB82v2YxbHjRewz0oR+zjiGCjZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmBMeC2Ztqlhq0OpaoBx3r+wy/zMAH5eT4jCObxFDFw=;
 b=UU5HvktD/vNL9QzuHnRh5xKKOMaXh68lXKtPPNoqPbWHxEbVTSBDhXSjvmBR1mAesZay92Mctyx4CFKswo3cp8tbVg8Qs2VmD2Kdem8hDVzNKd7YnshrUEk02uKbV7FgKdo9pLiITFa7hKKDjWEK6tOCK0bDpbv3xAabse5ivjI=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:46 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::86) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:45 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:43 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 19/19] mtd: spi-nor: Enable DDR mode functionality with
 Macronix flash
Date: Mon, 11 Mar 2024 22:52:49 +0530
Message-ID: <b29870266e42a6f1d8ca12900297b8bbe11dc628.1710098034.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: cb84ba66-5773-43a4-0bdd-08dc41f00220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zD7dzkDGRE4PVvUIeWvHj5rADVhfTexe0pMmPCKaZZ9ofgnKMEDDY6lRk2lg8BuBVGU3/KfOW+89AuC+GPGSOr3HYJTY6vmUgCzYXWPARb+aacwhhOFFRd0KPZWpQLxSjmnctEF6LBipow5jflWcFeTgEl9Rjm6Cfl5KopJboLqsZKf6s1nLr+uiB29XV08Htz5+TKshkupqgQAu9Ozq68lgfGcAHs649+BkT5AMkOAMKKgcmKiWcDKHyICZan5DiAM987QDsKmE3OFXc47bQ+PsVZIv6KjRv6uLaeexS8MPHhOy0BHvi/egNJh0yszMI1dyv1riumDM8AN5o6Z3cYK4ilzzUT64jgzk4Jdf8lfcWVQt7AoNaJkA7Xw9eLReSoWQ0/ZPicYB5cA0JX4G/2KT6MTedaYxZf4LLhczHnJDQtvqjL4O3b4+HFujr6uzO5VEnBSZkentn6nMn0savJzeC2jk+UDVzYqxu+wvJci7YaoJUAj4rkTAB2USYJhHaNixe7KVENjCCA1wp4KuCX/8G2u5WzZqBAvw9wgsn3bMUK08egKpbR007YlkWmLZP9fCEBsI/2nVI5IUtXaf08XOdwxJxW0IN1B71eJGR//yM0qFMe6kXAOlHSmlyDDMYcsUXr2irXtTqReOm8mnqBjvhIHV8dui/0Jt9I8ogjpFsDRdqenRTPL8vtxRP9W7hzhOOArJzu9CtOMsLYieZn/zxh/24xryUudUoS1IZ2VoOh9m3LTz54N2JQkecSNR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:46.2441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb84ba66-5773-43a4-0bdd-08dc41f00220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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

Added SFDP fixups for Macronix octal flash, with the requirement
of the Invert Dual-byte opcode in Octal DDR mode.

Reference: linux-xlnx@08cf794

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 49 +++++++++++++++++++++++++++++-----
 drivers/mtd/spi/spi-nor-ids.c  |  2 ++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6b396ce681..9c2d70585a 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4089,18 +4089,18 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
 	int ret;
-	u8 buf;
+	u8 *buf = nor->cmd_buf;
 
 	ret = write_enable(nor);
 	if (ret)
 		return ret;
 
-	buf = SPINOR_REG_MXIC_DC_20;
+	*buf = SPINOR_REG_MXIC_DC_20;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
 			   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_DC, 1),
 			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, &buf, 1));
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
 
 	ret = spi_mem_exec_op(nor->spi, &op);
 	if (ret)
@@ -4115,18 +4115,33 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	buf = SPINOR_REG_MXIC_OPI_DTR_EN;
+	nor->spi->flags |= SPI_XFER_SET_DDR;
+	*buf = SPINOR_REG_MXIC_OPI_DTR_EN;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
 			   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_MODE, 1),
 			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, &buf, 1));
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
 
 	ret = spi_mem_exec_op(nor->spi, &op);
 	if (ret) {
 		dev_err(nor->dev, "Failed to enable octal DTR mode\n");
 		return ret;
 	}
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
+			   SPI_MEM_OP_ADDR(4, 0, 1),
+			   SPI_MEM_OP_DUMMY(4, 1),
+			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2), buf, 1));
+
+	spi_nor_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spi, &op);
+	if (ret)
+		return ret;
+
 	nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
 
 	return 0;
@@ -4134,6 +4149,20 @@ static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor)
 
 static void macronix_octal_default_init(struct spi_nor *nor)
 {
+	u8 id_byte1, id_byte2;
+	/*
+	 * Macronix Read Id bytes are always output in STR mode. Since tuning
+	 * is based on Read Id command, adjust the Read Id bytes that will
+	 * match the Read Id output in DTR mode.
+	 */
+	id_byte1 = nor->spi->device_id[1];
+	id_byte2 = nor->spi->device_id[2];
+	nor->spi->device_id[1] = nor->spi->device_id[0];
+	nor->spi->device_id[2] = id_byte1;
+	nor->spi->device_id[3] = id_byte1;
+	nor->spi->device_id[4] = id_byte2;
+	nor->spi->device_id[5] = id_byte2;
+
 	nor->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
 }
 
@@ -4144,8 +4173,16 @@ static void macronix_octal_post_sfdp_fixup(struct spi_nor *nor,
 	 * Adding SNOR_HWCAPS_PP_8_8_8_DTR in hwcaps.mask when
 	 * SPI_NOR_OCTAL_DTR_READ flag exists.
 	 */
-	if (params->hwcaps.mask & SNOR_HWCAPS_READ_8_8_8_DTR)
+	if (params->hwcaps.mask & SNOR_HWCAPS_READ_8_8_8_DTR) {
 		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+					  0, 20, SPINOR_OP_MXIC_DTR_RD,
+					  SNOR_PROTO_8_8_8_DTR);
+		nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
+		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+		params->rdsr_dummy = 8;
+		params->rdsr_addr_nbytes = 0;
+	}
 }
 
 static struct spi_nor_fixups macronix_octal_fixups = {
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 34fba49592..cd3fcda70c 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -275,6 +275,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
 	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
+	{ INFO("mx25um51345g",   0xc2813a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
+	{ INFO("mx66um2g45g",    0xc2803c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
 	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
-- 
2.27.0

