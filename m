Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E2ACD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D36DE84A6E;
	Tue, 23 Jun 2026 14:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HRp/6J9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAF484A6D; Tue, 23 Jun 2026 14:55:33 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE3C849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8MEwUWQhr7Kk6RyWmo0t+Bi/qvwWJ8MNrjbETBS0dNbWzRru0SI1mEEeJCkkFlamXQOxb2NBvaz7bTwecSGBa5gB2Br6Fx2LmxuwBppFFzsBch9PS40FWGD1VXsDvoWcTuxQlZ/OpDhIxOokI7t+Q8gyjLvGnpCzbskQ7IbnyBBR/Z+PQuliglXAuSNRYkJ7piENX/k/ydtKn4fytwnBWiOWd4SsRjVuWSKYEwtrFMxw8x5XajWIanf7l+E8Yu5kJbKfbuAAvwSVO1MrsIxFzLgmKy3UFevwnnEM/onJxHJCCfEc5oo6Z2lmRRReyuZWJCGemgngz2BRWjg8w7/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXKm6LAZZ7z8CvR/2zIYmdjDh25ZGRu2pHlTSNip59c=;
 b=Ob5LdAWDixwdNETPUUxeVqe/mnn6zoutPM1NRNnLvV3ePj5MdYtqzMtEA11Y2hFGDyJxzp95t5rNWASF7T77YS1lYsTRfujiQbceqRPQFdHNe22l1ovacosIwbIDwx/KNbvseQ619AmK2YQIGlK+lIwjSeZD5JZ8DW+VgO8wEkGMytqQg8iNbIptk40wAdc9zFaeH7Y8vpM08bKLLonfpBwIENwBhOEdzJH9g0yympAksG5Z2gxM3793f06CUlfp/TnUBDYxLqmDvgqq/vFvhmKrDbc+FEDnj3howZS39EpscBchqeRgQXK1C0RoCpreisHG3j6rEsMX9ocLWbbElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXKm6LAZZ7z8CvR/2zIYmdjDh25ZGRu2pHlTSNip59c=;
 b=HRp/6J9OU+2cLY135eLt8Qd15c9TqcTAxvsrHqDflABOjcOOTHtuTWMU1Eg1D5ugXnjMhwd6TvEwRx8bxvKwFWZ2xup0kImbEgTJ3qm3MTFpSqTxMVvnLzON/Dbmb5SzMYM6N0fR8JDfMVshrUu8HJuZu48GWilsbbFtRti7DGY=
Received: from SN7PR18CA0022.namprd18.prod.outlook.com (2603:10b6:806:f3::21)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 12:55:20 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::95) by SN7PR18CA0022.outlook.office365.com
 (2603:10b6:806:f3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 12:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:18 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/18] arm64: versal-net: Do not print bootmode from
 spi_get_env_dev()
Date: Tue, 23 Jun 2026 14:53:41 +0200
Message-ID: <ae257af9d2fe026306b32c647e406450319a3c7a.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2379; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tyOrwboujMzENxpgpJDXfnUH+b2OfEciKiCvOsTHqh4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNX60+zF9G+/Subb1XZ8qXj+52ltxrlj3rOXdOI34v
 ramHrvZHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRoo0M/8NXLZEp8+AwXP3M
 g2Xrt7Mqsufm5T87fJN7jvGK6a3PDzEwMrycwCK8oOSQyYnYqpRFjPvzkx8FFtgfiFwp4r1vWYm
 RHRcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: be593e63-ab61-42f5-c59a-08ded126af02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: KtJDTSMS98NOgNmd8XkFO+7ZfcMhnUt4dYJejsIBJ8pg2W9hJYOlCP5So/I9FZT8RbJz9Qf1VbXVWiu977P2Lyn+rAzqr/WqVekYXHIArkFdRePTMN9N2VSHdq0y66JCvasgbo1+R5lnAC2OnL5xhd6UGCoCGIZTIhdtfSJ46F9j7sTf9KBRnuwTyk0m+EgHZwIMmb7jLD2LQXjZqne5ITWE2hTmrpTnjvSZxNTFOmwOOruh6tSYH9FcnpRaUL2OS85VOOH+RbfZl6+rFGkyI9HJy7H+kzvQjnZOaH7QZgIVMRaTF991lMnebLQiMO9EhaH4Ms4U7fVEzSGJIMdehCFpX+ShEXJm8N2B6KYTSAybUDltPJsnGlFXjcL5ypXVx/VOGsAmIylnRTVoz3YJHuMomy0iLA5Odcs5x6rFcHW1/0y09cILfOKqJxXHvVQa1HFO72QyN3q3QxxhuJdP9mVMqq0uf0u37RuSVH/BUW4O5riH/L/1yoAr+YeEsIy02dwZG1AX5cgjxS9q48Ih1NwRqFwj+276oZWmBnTB32zCk6clWg5JR/6RUVrGhOSQ1CALoyJJ0M0x8FCu8UeEfVj4UKovuGfaf30odtG8OI5k74WnP0z5krGyjYnTqWLVvNUQBwWemcrXuTwYd/tlvZCwwzIcOMwEWUFhFCDAxFhyl4BjgM8KnxneGYJTWyklLiXrj+keKzSBaoIHv2hrMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OJiMna1m0i4H0yq32PL0SV56LC4O1/5YPoP76NQJRslDe7QdlCF/I518+hO8tiLbf8cBhPbt/qSMCQGADYLXNKgDcHaKVse2fe6xM6deWK9gISB8/Mxq0Yi1OTEQvY3YTXvKxZnvFqZ6eUyg7nEFV5ggG3zvQAVtmOUzZKyMSJ73w4ivgGEUL2Gp52rJ0AczHCLIN/QGPUHUTIo4aLyuzUox81fXpRUbbgZNEtHRrOhym4hL9SzmUlC8Ixj97DoEO2k/BtVt6mbFuGTIvuzZaoVTDfmvtMB10MsqgIU8SzsjzwNZa42rX9l9TmwJtAxb5GFwsk5kmucNjbLIsI94Mz1OE176Njqacp39CYyI6IiyJKXpTATTdcEl/28ypSNR5N5nkqPfM7sdKLAm+q0uIWdTBbTN79JFMj+kz79CzfpfZ1olsty/PZZLf/5fWbjR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:20.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be593e63-ab61-42f5-c59a-08ded126af02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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

spi_get_bootseq() printed the QSPI/OSPI mode banner, which is noise when
called from spi_get_env_dev() during environment setup. The banner is
only meaningful for the "Bootmode:" announcement in boot_targets_setup().

Make spi_get_bootseq() a pure lookup that returns the banner string
through an optional output argument instead of printing it.
spi_get_env_dev() passes NULL and stays silent, while
boot_targets_setup() prints the returned mode name as before.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 50dd49927be2..687d042d1062 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -68,7 +68,7 @@ int board_early_init_r(void)
 	return 0;
 }
 
-static int spi_get_bootseq(u8 bootmode)
+static int spi_get_bootseq(u8 bootmode, const char **modename)
 {
 	struct udevice *dev;
 	const char *name;
@@ -76,15 +76,18 @@ static int spi_get_bootseq(u8 bootmode)
 
 	switch (bootmode) {
 	case QSPI_MODE_24BIT:
-		puts("QSPI_MODE_24\n");
+		if (modename)
+			*modename = "QSPI_MODE_24\n";
 		name = "spi@f1030000";
 		break;
 	case QSPI_MODE_32BIT:
-		puts("QSPI_MODE_32\n");
+		if (modename)
+			*modename = "QSPI_MODE_32\n";
 		name = "spi@f1030000";
 		break;
 	case OSPI_MODE:
-		puts("OSPI_MODE\n");
+		if (modename)
+			*modename = "OSPI_MODE\n";
 		name = "spi@f1010000";
 		break;
 	default:
@@ -104,7 +107,7 @@ static int spi_get_bootseq(u8 bootmode)
 
 int spi_get_env_dev(void)
 {
-	return spi_get_bootseq(versal_net_get_bootmode());
+	return spi_get_bootseq(versal_net_get_bootmode(), NULL);
 }
 
 static int boot_targets_setup(void)
@@ -115,6 +118,7 @@ static int boot_targets_setup(void)
 	int bootseq_len = 0;
 	int env_targets_len = 0;
 	const char *mode = NULL;
+	const char *modename = NULL;
 	char *new_targets;
 	char *env_targets;
 
@@ -133,7 +137,9 @@ static int boot_targets_setup(void)
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
 	case OSPI_MODE:
-		bootseq = spi_get_bootseq(bootmode);
+		bootseq = spi_get_bootseq(bootmode, &modename);
+		if (modename)
+			puts(modename);
 		if (bootseq >= 0)
 			mode = "xspi";
 		break;
-- 
2.43.0

