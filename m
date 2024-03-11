Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAAAC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6D087F00;
	Mon, 11 Mar 2024 18:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hTzqs4tU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4B687E6F; Mon, 11 Mar 2024 18:23:41 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5262B87ECC
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBf3BtfMmm8ys5GK7xjxkA0xOh4IvhFLcTV9CDtX328G5kQXmiiYlSH8vqtnWSaPMW1purcfR2HFRp8Em06Knxz2cYHAAj1Z767OeMWbZ1PuDjzxBpnCmFetC7Q4OzO6prJ67wkY1kJXhBr0Vtj8D96MrXgJDQVwLgkpJ/6v6oKNhH9mLuHvxOLN5pCiPHzd8LEGHcqyQ0FDJFuS+MsKWNhAIZODYuusQ3dTfcn2FeHOwzlu2jdHfApwCpsAfQC/2JA4zzyBZV0EFmQzCAW7ta1d+d2nyzwpzx2tubR9E3whXNlTcJRoToduTO2ogWoITWxRUcP756l28P/s7Eyf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BZ5O3aekSr8HaHRoVteQsF4Ghhc3mgicTbE5CJaWwc=;
 b=mJP/lzQFbw8qgF7Xkl+FRL5GWb0rODCAr8fLtzPTl/s2A0PiqX7l3nEvhJzA64JRX+zdpYI7yJ78TO7REaV1F2G2P4bYqPZJ0yXGFV4bfyw81uC4cg0sv7G9DHEl0jVbJ13aKLnR1218XGv+JhCq19r/CsyjKWTORD/AjAq5MqQxKr4IAteNpcXlGsrtTrtXmq05tsdEgXXD6MH2ljb29pfAAe0p3pJ7rzRPJ7d/+Ndq3PO0YAItoh7Nr2UanOAObzwDB7r6hlNwXkh5GwglFpqNdA++XUTjYeZzs08RlGTnYfWyEy/lK1ou9RCemCmK7uErEA6IqTUUJt1VPtOdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BZ5O3aekSr8HaHRoVteQsF4Ghhc3mgicTbE5CJaWwc=;
 b=hTzqs4tUI197OtYkdJyKNMBxdZOkM6y3DxxKKvh32eYDqGF7pBW1smJ6TsJvli7JDK8lc2PIE7v2Jv11Hi7ZgPktx4LqcMATT6DKJSTyJG3oqjrRMnBXtMScmqAq7y3n5C59vCx7V+LkSwbEAXzKfmAaN49GZxb3FOmWddFcEOs=
Received: from CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::21)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:34 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::9c) by CH5P223CA0016.outlook.office365.com
 (2603:10b6:610:1f3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:33 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:31 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 14/19] mtd: spi-nor: Enable DTR octal flash program
Date: Mon, 11 Mar 2024 22:52:44 +0530
Message-ID: <129ff01c27054889665b58ea5df15702baa8808a.1710098033.git.tejas.arvind.bhumkar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea5b0a3-a835-47f3-097b-08dc41effae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xo9Wkl3Gjxy4IDGXpvff2N4ET41rmp6u/vGRNM0rvF6l47dLnF/QUN7SmoED2TwEjuU4/FzmEtnN///xl+r/Lry+O1I7KTleodHXVf+5+3ABeM9W+2NaVajm85oAXkrv15ZqzQqB9EcGcU1pfr3Z00ext8WDsSYk2AKkjkipcwAFgkC+NQUEgm9vHQV043Y1hNMSjaAEdjgFThvCT4NmCOmGZewDXE7LZjy0ti0kXR6P9vdh/FHPJmbw9RsP6hXtLjK7jB+tgJe3JyGNUQgE1QqI0ugxhstUCAuN2n1nqHO/rT/5dyxjnz3+sKwWZwHdCOVO51ITSrAtb+od3fK2MiHEIvF8SO1EXW/M1n+URIUfyVAM+mwb2IhLvX9IsIvDv1SusjzAeIUXWuLMtFz8JVI/CsSkb4k2noOzZUvl6ejnFoIgxu6YYS0Ggh1vXQjwffY9gnQPcCoJKpQLk+yWFTKFMe5m4BfK0wJRWbTVvI3ywV4Xxv67pk8Lu1feOvWloAj61LaCx36jhGWW7XkhjiSE26JNTnArNBP6vnV6EYPA1t7bStVI4+v4yGb1xvQ/hS2ldo67FXS0F3vvkgWP6ywxq9OAtafeVex60xGOUdaSxEmDWMGBBPVNjLSz9jjqjJ9nciR8EhI2aXY43hm9c4cJ3ImydBtDKmuEGS+MMnn5GFeXyJkESXFdKl/AKZzyZ5NTc+eVnRkAKKdMyNK7I1Fe8F4K448+IP3Z3ulzzAjI9c/L5YCMyF1NfW0XUqgd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:34.1552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea5b0a3-a835-47f3-097b-08dc41effae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

Define a flag SPI_NOR_OCTAL_DTR_PP and if enabled in spi-nor-ids table,
enable octal DTR page program in the framework.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/sf_internal.h  | 1 +
 drivers/mtd/spi/spi-nor-core.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index d3ef69ec74..9c09f97ce2 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -69,6 +69,7 @@ struct flash_info {
 #define SPI_NOR_HAS_SST26LOCK	BIT(15)	/* Flash supports lock/unlock via BPR */
 #define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
+#define SPI_NOR_OCTAL_DTR_PP	BIT(18) /* Flash supports Octal DTR page program */
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ffb9a48316..8a3cff94db 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3076,8 +3076,11 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	 * Since xSPI Page Program opcode is backward compatible with
 	 * Legacy SPI, use Legacy SPI opcode there as well.
 	 */
-	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
-				SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
+	if (info->flags & SPI_NOR_OCTAL_DTR_PP) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
+					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
+	}
 
 	if (info->flags & SPI_NOR_QUAD_READ) {
 		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
-- 
2.27.0

