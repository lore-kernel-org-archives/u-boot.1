Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A7CCCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 17:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4045F838AB;
	Thu, 30 Oct 2025 18:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="Ptmf6+fU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE1B836D1; Thu, 30 Oct 2025 18:59:27 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBA6838AB
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2EtdFb9xJhC04yvKAAnVzGnbgG95Ds1DqPPNsZZYc6u5m1SH7IEKEET5kFvN9YvDgXxrnZQ3jupxrBL0zY8fIEBFn1ekYqUeoKgk/pU9u4TNfyHL7HEAPdEpcZB/5S6sIrGD+CvqW8yUKKDXay+CxvUVatgxiJ+9tlU209gQTnwPQ3HUxxoCouoonuMOK0Qhb2CX753v/3uq9FUxvjEyIj8npv0M7axkb5IR7lv1qFraVix5rzs7MwFe7tBCCTRKAn84ePfPsNCRd/glYflTrlsGdEEeo5BxDN7N0+k5P6BgL4iwrgW3eu27EmbWiU1guBRount27bHf9/2q9gmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx9zUVmcvxRWv6hz6ACzEljAEHinPvMfLHokEraipXk=;
 b=F4Ob4Lt4VzwHumPWdSgcY2rtore9a3Gv9PHUudaTKfa/hhwqSP3itAgHX9BMOPUgJeEbFqEPp78oVa6CuVwUINy/mZ8Cd3Hr66NXCM+1K3W8HgjqwXr9kvKSsKSB6ogbqfk6MSQR7ZUrpLuauYRjjPfkCTvedqsOtU2y6o5/CtTSvE/3TGdvKJGaaMqV30EC9nqsR+ZZf/A5Wb2cCvGlVKlo85NIlRWyoKYbFP75TEROYPEGM1i208feZaDKff/2LCZ8UsBrzWSkUWt4XK8NFWv9I2u+wY6WGzFKMbrYX1YOL7DYkGZWgL0jfA0LlKtf5Lf95qJxGfOzyVdMHaYtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx9zUVmcvxRWv6hz6ACzEljAEHinPvMfLHokEraipXk=;
 b=Ptmf6+fUJhGPess+VakdBTp4TZO10yfQXwbqenL4/lFq7IyoBNLZfp8wQlrWikgVSW+rFIY5zrzQdQ55bawRGRBbbtxgjU/3CeZMRiOTDq8uiekSWeC2t8UJ6o3+RfS7KmC3dhokdx0aPjBDd+Vywa7byEN2xWFpk1fQl7JDoEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by OSQPR06MB7231.apcprd06.prod.outlook.com (2603:1096:604:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:59:21 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 17:59:21 +0000
From: Victor <vlim@gigadevice.com>
To: u-boot@lists.denx.de, git@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, tudor.ambarus@linaro.org, trini@konsulko.com,
 Takahiro.Kuwano@infineon.com, venkatesh.abbarapu@amd.com,
 marek.vasut+renesas@mailbox.org, havish.mutya@amd.com
Cc: vlim@gigadevice.com
Subject: [PATCH V1 1/1] MTD/SPI: Add new part numbers and modify one part
 number
Date: Thu, 30 Oct 2025 10:58:56 -0700
Message-Id: <20251030175856.115246-2-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030175856.115246-1-vlim@gigadevice.com>
References: <20251030175856.115246-1-vlim@gigadevice.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To SI6PR06MB7813.apcprd06.prod.outlook.com
 (2603:1096:4:26f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7813:EE_|OSQPR06MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d40d0ec-86a6-44de-9200-08de17de0dda
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tqnTDTIVoLLKLfOpDXsrW8HtJKzOXIu10UvplW7fM/kmLFMyJba2yVyKeK6k?=
 =?us-ascii?Q?Aew1tu2ZxSG7nPMWlos7IS4HN97dmJ1BxHU+1ikgJNI4LqB3JXEl35gM9XWf?=
 =?us-ascii?Q?g7lC3tScfpsxYjy5yQppYiYRxHLtdFp9h8eXiueq/NSuC4W0RSOsAU4dCyBl?=
 =?us-ascii?Q?pQXj9fKKMZseuxSkWKryvI5AwzSmIw8kvUAQC/5tCkNDOMu3CVhdFUOQqBQO?=
 =?us-ascii?Q?vuCMqO+prPbpX2r5oRmNJsP7Z/NlWVfHhezSW2n+VjbZuwR9XUEwqJiCqoNq?=
 =?us-ascii?Q?4EzcLkxcP4VNcxUbBg0jNN/KL6IbHfRBNyH2qzR0B1SJf12QtBP2KZ5d1zVn?=
 =?us-ascii?Q?31/SRCs71aYbjEYgQarJEjwJYTJkFhFJQWtnSOgGrDPckvcverb5s4UAdX/v?=
 =?us-ascii?Q?Wel8QavMjobZUpZ84oNeWxLtqZBodXE9344p1HlMk6dVoVsns1LEN1iGUITK?=
 =?us-ascii?Q?LjdmvQJniOBBLTAKHjvzVuwUah7MrK8plY065/fSLZY9r6bqJk1BrCvWJRiB?=
 =?us-ascii?Q?W0P+loDHZlWiYaO/CIQPLWPqdaKNn45HW1cl0wwlflD6gou2+HSZ18qobJGw?=
 =?us-ascii?Q?BonJhVK5plrqqWz99lEWV1ugb24lfYW7OzX4fa9rr/6wVhJOLO2trp6CThaS?=
 =?us-ascii?Q?yic7K9KBUCeKsmgSLH3p9pkaknf4ze+EkyIJb6RApIFeYzysdsvSCH0tDMbB?=
 =?us-ascii?Q?hR6+fyLijK1FSBefy+Bm+zwL6skdgriaPQ4/QzdsDgfBItwuwyJ2eIUzAXRV?=
 =?us-ascii?Q?k3lSVMIGmF2KRXOuBSo4TMVWdyNTB82maa+RjxnRB81CiDlN4UqzGkPZg+pw?=
 =?us-ascii?Q?KL/ZbYiUv626/LQ+xcC7lBBXTOZewXxOON+993zT24sUm5BbMaM1+CTkS0PO?=
 =?us-ascii?Q?FSKxG8YhOPyDBveI3tHrwwUgxizmBa24Y8uqYsw4XtusFsNz9LVAxSYtuYUJ?=
 =?us-ascii?Q?dx50D5FOlV/KhSV27951hZxEubOIevXXBUDeXO70XlSvci11peCwfYycMv2D?=
 =?us-ascii?Q?NT9ftpIPowle/egf3Ydz7ATn76z7XskphIGjSJbzGfxYFkodk4mMWkGCFni0?=
 =?us-ascii?Q?pYjxOruVYvWvm19MaFYezFSU3fnU7ZCLra0p4QiqAejvc0BcTdOKCKI8U7jx?=
 =?us-ascii?Q?EtEzzgrPnRvFpA9KofXYPib7Z56leqGRHEA5BJj2Qm/HgLUbQM/eaOZQMu0C?=
 =?us-ascii?Q?p2dTO1kdsXwK3HgcyFSgoIxllakR75qBekbivk4oMFEMV9Hmb5Y9ZOdUrB2w?=
 =?us-ascii?Q?u8fqHB2ju6Jns+t/DMgpR76Sz+1pi69pDCwTIlB9hYQ/AUB3ep4zWOFFgb7Z?=
 =?us-ascii?Q?8GF3SvYhcCwntslIpI+kvMq7HJjF4Ys4mLyR7KIUvJY9T85BaNDuo7D9GMuD?=
 =?us-ascii?Q?xWHzgIAO4SwUJHDqw63lZdN7NDnGeiVS2gbPGgkbaNJrN08cDl2gNO7LowmE?=
 =?us-ascii?Q?tjA4nnlABQdLfeIyF++niltlfVfVHplu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9jGhlePCyO25g0xBhSb5wqG6aFCd2ylmB7Gim17JJsV3Gi67WgdgR9QoIOY?=
 =?us-ascii?Q?cQLXNXxx+hwJZqzf9QV/3oBHJoHF6WSGExK+9fyImv6TTVzkL/sQIZkcZJ9i?=
 =?us-ascii?Q?6bG/znUdeGZMRyDMZPpdJRX6LvWf3IT+erj4P1poDL6FQZVVk5+61+Y/d50M?=
 =?us-ascii?Q?kZX2c6ggRqKflSOO7pt2dbKYjuI4fOeVrnD6LdThisGmhV46w1rFObW71cry?=
 =?us-ascii?Q?NmB8QqPcP3YvmxTeWWtjsuN6Dz4tr3fVfHK8tRWiV8Jx3SQG0hzGQYdE2/Ku?=
 =?us-ascii?Q?3vOZupqWLTpDPYbjXH3BpLN+XHWtbkaeVlERz9Lr1y/YHkUxwtFGHdHlVDKq?=
 =?us-ascii?Q?6hXdwGYgtg+GiAZeuGpjb5shXhmTlEeNCwGxnEUz2sdw2vRIAxOUPB3Lq1lH?=
 =?us-ascii?Q?zDH1LHKOHItxFAqgKjk9qAxRXLVQFjOU7i8JKG/CCybx0VzV1GCy/GSI/j29?=
 =?us-ascii?Q?7YRRSyAv/iIwLhH9357GW5MfkfzrR5OsSanhdHwYamdzTfK87VdWlCEL5ygO?=
 =?us-ascii?Q?Qijguz50/2t/Gzh4MsqJN4eD5rlwU5U/+HvjIND9hU7UYTNcs284l2JAZSHL?=
 =?us-ascii?Q?h55f7zFVvJlFRg45yVBQNyMZCfVe+kbLkyOgU13v2XB1uMu95xpChEGM33Ls?=
 =?us-ascii?Q?innF5bsDyY3ZdrazQ6KsnRrLDAeyteyVVYCxpHv/aM/5Zk6hJo61+rpfMj4y?=
 =?us-ascii?Q?gv5CTIu1Q8zB5b69wWSsh7JxPvoBaTG+J7SsfCIZpLCh53E3eSSC4VWfRq5d?=
 =?us-ascii?Q?gHkLdWyU/qd3/TXXCT3qFpEan4cyjSAxdFvkYPGLzuf3gaEyAnxs/RIg2BWb?=
 =?us-ascii?Q?zLS49TzSNrSh6SdizB5TgZIZWVRyNhGi1z2EOXlKvGCS3vGADUfaB8iOgqtn?=
 =?us-ascii?Q?cVJm+hBumY8BrPaEIxTS8x2NC74MwqtKsrraHjHTDWBpY9Vpm7fgVxGbMkF5?=
 =?us-ascii?Q?vFcc91AEBym7hoauDpbH8opKZY/QJzqCyS3AJ0qa1c57x3CCt2AZjfTwY7On?=
 =?us-ascii?Q?EOp5VEK1k/mytI7nDk1YoLMB+YVXqqHXevUViK0fF0DXz9QkpLlZOsC/0+a1?=
 =?us-ascii?Q?j/hkZeWh0W0hOtMmz4VSjIeXeZvieLJFK1mAx6BJUkiYTKnjGqL6ep7fxlo9?=
 =?us-ascii?Q?b3fWMZBJRCjDx+X0D2QnMiQKGQYvblVAcs1PLIBIqYFWocJ+V+SKlPBmltyc?=
 =?us-ascii?Q?VLlAdQSjVNg0+WZSVh1+P4GlcwRf40sj+2uNh9p52gDDabKhs7zG4bgpVG+q?=
 =?us-ascii?Q?cTaCN5/24vQHbRdcIxJzfZnoPefsqFg5iEAsLdnRIV/jGB0+EmS5QsmTsM+D?=
 =?us-ascii?Q?tHbEh2raTgZCVNzL8yH7XQzSy4blgZTkwYP1Fi0mTJSZNNdrCsWOFN2wpegf?=
 =?us-ascii?Q?ZMHI8mHPYthoXOnkxX89hiuq8UesWeYH6J8oK/SLz/XZ8MCYrZK+LxiiVDRK?=
 =?us-ascii?Q?3CG07NsAFR3KhUHHFkV2tAvbD2DNUmO15HqcHPyY1IdJgf4X6KdL8C+Q4/7f?=
 =?us-ascii?Q?wX+4UzDXOAF5CA7zlsrA5bMPI633I6s2ci9WVmtk4QcMtirkM0vehTgeMrF4?=
 =?us-ascii?Q?sPG2xymfTzT9ghnelaFPtC4E91zu97UxlSEnZ2hl6+dtqxzKyWn/S8Db4u8Q?=
 =?us-ascii?Q?4q2IHzFRXHR2kJDGWDoEVOZ9uClbDPixlq5mEefygxiX?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d40d0ec-86a6-44de-9200-08de17de0dda
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:59:21.6953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKHpfStq5SNmOmXYW5rHNdiB2b4H7/lW/XaufxpOl4PlbGCqsdG2aqWLd913WYF+FvRumUIQE5LGohgxMIyzeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7231
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

gd25lq256d: add SPI_NOR_4B_OPCODES to definition

gd25lb512: 1.8V 512Mbit
https://download.gigadevice.com/Datasheet/DS-01014-GD25LB512MF-Rev1.1.pdf

gd55lb01g: 1.8V 1Gbit
https://download.gigadevice.com/Datasheet/DS-01013-GD55LB01GF-Rev1.1.pdf

gd55lb02g: 1.8V 2Gbit
https://download.gigadevice.com/Datasheet/DS-01015-GD55LB02GF-Rev1.2.pdf

gd55lf01g: 1.8V 1Gbit high performance
Can send datasheet over email.

gd55lf02g: 1.8V 2Gbit high performance
Can send datasheet over email.

These parts have been tested on Xilinx ZC702 board.

Signed-off-by: Victor <vlim@gigadevice.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 5c6fc8a5155..e744d93591b 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -166,8 +166,14 @@ const struct flash_info spi_nor_ids[] = {
 	{
 		INFO("gd25lq256d", 0xc86019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB	| SPI_NOR_4B_OPCODES)
+	},
+	{INFO("gd25lb512", 0xc8601A, 0, 64 * 1024, 1024,	SECT_4K | SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |	SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55lb01g", 0xc8601b, 0, 64 * 1024, 2048,	SECT_4K | SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |	SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55lb02g", 0xc8601c, 0, 64 * 1024, 4096,	SECT_4K | SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |	SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	/* adding these 1.8V QSPI flash parts */
 	{INFO("gd25lb256", 0xc86719, 0, 64 * 1024, 512,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
@@ -191,6 +197,10 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25lf511", 0xc8631A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55lf01g", 0xc8631B, 0, 64 * 1024, 2048,	SECT_4K |	SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55lf02g", 0xc8631C, 0, 64 * 1024, 4096,	SECT_4K |	SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25lt256", 0xc86619, 0, 64 * 1024, 512,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25lt512", 0xc8661A, 0, 64 * 1024, 1024,	SECT_4K |
-- 
2.34.1

