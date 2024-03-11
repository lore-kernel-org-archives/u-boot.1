Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A391BC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A511487FA1;
	Mon, 11 Mar 2024 18:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kf1ZPSYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB5387F95; Mon, 11 Mar 2024 18:23:47 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD5D87F9F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5UJke69ISO6yLLI5MqufnapyRLdB9OXvSFBynCg1OswTT8QsOEfbdbmtCvraQGqXFueoY3HGZnsWAHB1/O6BDJbQrAUGQCAITDMNAjy30kBZPh/4AVe9BzHB0oK7g8lpuszjuo8CmvOtoycLZ2lvJ5C22T0Br9j0eE9LS46mz5tDDkaAT+QDgPLjzmCSkGu4rFlNgYwn182uNHPfPsjqZy/0O9NzI80IZDlBjMb9DJpCNf8VkdWSfeNha3nceh33WgH1EecDZ+fWQwng5iGt7T8ZSXl/hAF+k22qol2mGkyGzrQwN3B1bvsWBI+pL6A0yHuQvfVHMC/Ures1HLHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3UVtbfV5cvl8z2ltnOlB1XZyEta98UXL8JTx5gAiLo=;
 b=AhjCFnf0z9VWTwj+/UbAHFIgwuGQgR7r3JwEsY/6i7DUy4FpiWAapnREniWVhXvB6KN5LY2suis9KYh8u1VYbcLvdiGlQBtTMBUQa8+rJxz0luO6J1bixtXoDaBYbsnvhwaOENyN/5bG7/jp9N7ePU6GX7nFHZtHj0uYfZTIysNOgDiWp2BxfR20u/dtmfbi5E85aQ9riiMBqku82QWJY/Hg6yY/DzqtMq3S9Pc1f65KWd859ISWCcbtEg1TOON46QYM4blsjYEzBglZ3XEuDfwJ/snhxKXyqCtdvhMfNuJkdlJnv6flJmogYCokVuCqDHU8sZbhZs4JvozulU2B1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3UVtbfV5cvl8z2ltnOlB1XZyEta98UXL8JTx5gAiLo=;
 b=Kf1ZPSYeHkA0Vum8SlRSIqdoxJb+F151hiUOS+VAlWdX4ZLhBbpHpvuyGgwWvdVeO1CKpEvBRfbaJDRn79BZDcKiltttgqKkkZFOcauK0WxkQNBABHEqgh1Ff6v3tfLNZYksYqLCGqN/ni7ny0mSQ4r3BHISoYLJJWPHphlBW00=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:42 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::89) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:40 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:38 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 17/19] mtd: spi-nor: Enable DDR mode functionality with ISSI
 flash
Date: Mon, 11 Mar 2024 22:52:47 +0530
Message-ID: <12e89f942322f9e243f0e63bd3c10170e1fcd478.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 858aa16a-4d79-47e4-308d-08dc41efff69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hp4CI5+LS1I9a0Foyf4YiKbwDQBc+6RTdgfd0xKTnTKvbTxflwQFeBSsQcb+GDy4rLU65IUIDBj5BEg7xyclF+rKh4JFWgSuAeFACSl4PB/+nBkvzncd71/3eoT6l8XgVP7YHIuDGP9HAse1aSXUAkcpdx96QZywKBmbpUco1IhGTXt+jDnt0aAtnPf1aScOabVJHXFKUaAJOzGppG1gfsKtPNIopE1nQKibaKpmo3uqXtEwxcKFjO/zZ3TQJp+W1DW7F711cnbZyuKBurX0emylwwDfFN1tlxIz152HtdpzDi13/z0ZITLB1NhK3uuOGprtCB1c7uxfSaOnRRHCqUIS2Jbl82wdKxQvrETdQINsxMvfe+nvYhAIf16Feh3CQuFHfMVlDNEKMevTOsls32tdcHHgZUy2DwhWYT/K29ZQwkxiN9TFi9hXRk7gQr8hE5VtIffYKVkprS9+e4trhawYwgOa9SdkKO/JDLHR4Yvty272GbfO7aR69+Ciy3jcSii18tyATMl+soYRo4YVC9gAyTvn4NoYCmqjNUNGqvx3svm8HSgJ/HJgYdygS6+r7b7JspGnpBtkalakkjOmqXeLEPHKK6w5eBOUxLIe5IxUZdq/g1jdljJZiFpn/89hwaT2E9f2aEkonf6KBz/ojGX2S6/wkn+3YvXhuIkk7NZIp3hmTJsl7KWWkCQpyN/0QXioqIXUhq4eXoBjtEhO3nTq2IMwbidTLKN7i4AAyy+TjsJaQ6pYPRA5+eA9swLf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:41.7215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858aa16a-4d79-47e4-308d-08dc41efff69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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

Enable the utilization of mt35xu512aba_fixups for ISSI octal
flash to operate in DDR mode.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 10 +++++++++-
 drivers/mtd/spi/spi-nor-ids.c  |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f1dbeb4725..27579cbf15 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3977,7 +3977,7 @@ static struct spi_nor_fixups s28hx_t_fixups = {
 };
 #endif /* CONFIG_SPI_FLASH_S28HX_T */
 
-#ifdef CONFIG_SPI_FLASH_MT35XU
+#if defined(CONFIG_SPI_FLASH_MT35XU) || defined(CONFIG_SPI_FLASH_ISSI)
 static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
@@ -4348,6 +4348,14 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 	}
 #endif
 
+#if defined(CONFIG_SPI_FLASH_ISSI)
+	if (!strcmp(nor->info->name, "is25wx256") ||
+	    !strcmp(nor->info->name, "is25lx512")) {
+		nor->fixups = &mt35xu512aba_fixups;
+		return;
+	}
+#endif
+
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
 	nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index f8ef87783e..c5c46c1a0c 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -239,9 +239,9 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
-			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
 	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
+			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
 #endif
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
-- 
2.27.0

