Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AD606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CDLu+8Di;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0QYuw+4Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8F7D80E03;
	Wed, 11 Nov 2026 12:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPSH8Glly3iM; Wed, 11 Nov 2026 12:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09CFD80D29
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398869;
	b=DT+h1Pe7CRAcZjJdgyMudeu492a2tRnVZWlFh3lNH0ETAB807qULBPA0Oop5dteR86pF
	 YQUBJkNlQhHn9o/+NgGKolO/WfD/ljFCBMjV3q9BRVvNF0POHjwoXQ5tFJR+frN8KOIMo
	 OJO3Npl2z9zGvhHs2s0juloF6Pz5ssXK9HYtW1LswQn2FKS/udGp31BUxPBAUadNkPzon
	 mm9BW36MVBbeRgygkUfwt/WJ3Nni2gv3TFYn7hRXhLXz917DMmdE2KocK3El+WmkeYI+y
	 R3gyoT46Fzvlsd1lOegQm1TRG13KD36XN0EuvSkzig3dMMB3sBdX1bzNE5z56I4/Pfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Hl5uy3vZM6bq4sAyCYEfv+Rj4pzqoBd4M/tr/w+lJjk=;
	b=Uwkl4YRTakARL+qSjKV+DknjDewyl4RTYREhLrgnx8C4exTPBi3Q6PfyfkzNOqdq2ME8
	 U8X+hXG/uT/SYvFgAn/3DX0BqbxTvqvRchCNDnkqzP4y3FOYjFY7YPSPfV/Na6sKvlgZW
	 F4LzwsEv6bRKM2G0GP3gTTA/1NriatjQnoJLwFKW3MywzlfA2IXYo+XlIp/2OtgsCpUMl
	 WvlhmtuyjiGwxiV7+DjluesbvYYGRYBbC6OzpTQhKqWyBnRiYBMl98/+2Y0HFB7BJVy/h
	 Wf1XmHJ2mpcjt6xkYdFVRYDqVlX40Quh/Yc/A9998lu0FhgYb3OyBXH7R07rfUuV5JA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0QYuw+4Y;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398869;
	bh=Hl5uy3vZM6bq4sAyCYEfv+Rj4pzqoBd4M/tr/w+lJjk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDLu+8DiiZAWNHYBGp7rQ1eqr6C50HF7YdBY8usBE4H0h0Mgv4OqFLTivNczN0kyt
	 UVfF7v/IXW309BFxe/ox2XU1p+jOMjAvljQ1P9LchZ/Y/Y8AKjLUCChB+mnlvDWK/a
	 r8m1wCyhqwObQzUprINkN6ukRsaHbruFzg/sU9RgWjqJWc1uScrCaa8EbwyfpTB41I
	 jIb9DqLVXUFHJx3J+J8dNZ4yYbvH9iuEdTcR2RH/bu4Rw2H9E5hyvtUfwYDYQ8AI4h
	 qG31yQLRGCgIT9x5UhWdYF5dPrRj+YHxTU77yU262Joey44EoSGusfXcGod9qOoykM
	 mrIm8sr2JxJqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09CFD80D29;
	Wed, 11 Nov 2026 12:07:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C369D17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4EB380D29
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVVBXmEMnzf3 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:07:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54AA880C04
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0QYuw+4Y
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54AA880C04
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl5uy3vZM6bq4sAyCYEfv+Rj4pzqoBd4M/tr/w+lJjk=;
 b=0QYuw+4YcIoYPD8Y7lsYRuZdtJ0Ie9TIwv29Ir9fKydYITcXakzZFpy8S/WjITKBC5uugsF2HNXBRYXBRt7y4HHUM4PPmPb2CO/V67sNrHA0jqhT5g1fYMfW4i7BKcDaTXvfJBPqQ6ivbscDj4xUDQIMCCO4OSBMnYObNoCtJdA=
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 12:07:41 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::5e) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 12:07:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:07:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:07:36 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 06:07:34 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Han Xu <han.xu@nxp.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Subject: [PATCH 2/5] mtd: spi-nor-ids: Match mt35xu01g before mt35xu01gaba
Date: Wed, 11 Nov 2026 17:36:42 +0530
Message-ID: <20261111120713.1526940-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111120713.1526940-1-padmarao.begari@amd.com>
References: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f9f9c0-ac20-4961-70d1-08df3fec6273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fSD6UVPySxCUaCv5E7Mp7ABnUtjpUTZZZ9paQYVIAL7AIUBhUedAX9yigyqxbu6OD7lIYltjTTJPh3UV4BEGnMIdDIB91NdeY9KqbjIYtNXvMGZvepDaXIMGstM6TVwjbz6683vDxxdesLLNciWt0YE5WBokbcvXbL0jVOeSl995+P6jyrSYL7uN4mRNFHH9V2SXWsHTALH+cCPlkc5ePL/mr0kIcdAKp5uBaxVfa/8UKd3H1HugmDpn0cVzAM8YmFTv0tb5WM8PXi9f/Eejlu19BYf0tvq64B8DbQg9hb2DhIuAHwLO7FASSheEw3dOjFtWsDLCK0XU/SnfSnUJYMskmY4gdnPtyOSDWY+LF7IZM/hem0nJjQks0ZLnCcZvmzbTcqLHTqVHekff8l7jB0rVnHSXUHmOmqxEduMzwE60iaRx3VSBUE7PeZ6gMUR8txKK0pxbtSaqxZc6V1QTpRiy5Xhzd37M9sSDeOaGo8gTx6tCz3U1qeRIOa/V0+ZCXkSSZhLZpumOZ6Rm0LKcaI7+paAx7N7kj3cWGgnmylV0MptMtHygqrD+rEVJZ/j5GlwomrtjPkVrz/O4BiZNtM3OQOD0pq7ZuGpIoZie8kEgjfrQtcde/Wo5nEQNwZGCUhMULw36IYL618+FCrlNpsC+RBuBYqaDUkdBBeMsDl/YkjaLlS7xIKrPB6zTi90knDQoCfZPQP3fwygVvLHQ2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fjEnb8OF4tcrao2zx3F264QlXx/RKGaS9XkgCNIw+mAvYH8mrZBLZddWyG9zmQUcmN8aMaxOZxsOdvQt3H1vkCYT8eM62TZ5cy1p/fu01Un8kYx4Lk1FFD7otEHWP2P5a+/rOYNrxNi1S7KeRm1teJR2YmwTgmcdAbnlwuyahs7llueopV2T2oW+r/Dic/ZTTD16iT+3MZ9rgi6gYHpWjWP2U0ed3T7Sx82kjp9rMl5XzvTiQh2/N1zqb1qHHWFTlmuu76geBnMVGlD+ZDvp+nD0F0RdOlqBgJ9X9LD7cj1mOoSKkcsH4hBH+eY9DG40Hx+z20suTuEEFAAtAQrWDBv7H7sIK0VC+H3vD1vX2KtILe0RE8hcmtXj5voPmEIVe13sKqj7cWiMt2tBGD8MriXXMRgfkPyqDvevMo2kl+fDoUmozYkFqMhiMRSE4b3K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:07:40.1115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f9f9c0-ac20-4961-70d1-08df3fec6273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mt35xu01gaba uses the 3-byte ID 2c5b1b, which is also the start of the
6-byte ID of mt35xu01g. As the first matching entry is used, and
mt35xu01gaba comes first, mt35xu01g is never detected.

Move mt35xu01g before mt35xu01gaba, so that a flash with the full
mt35xu01g ID is detected as mt35xu01g, while any other flash with the
ID 2c5b1b is still detected as mt35xu01gaba.

Fixes: a3384940edf3 ("mtd: spi-nor: Add mt35xu01gbba octal mode SPI NOR flash")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 7be2d950367..cca053ae9a7 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -436,10 +436,11 @@ const struct flash_info spi_nor_ids[] = {
 #ifdef CONFIG_SPI_FLASH_MT35XU
 	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024,
-		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
+	/* Must come before mt35xu01gaba, which matches the start of its ID */
 	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024,
 		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE | SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048,
 		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE | SPI_NOR_OCTAL_DTR_READ) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
-- 
2.34.1

