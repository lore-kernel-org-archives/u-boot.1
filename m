Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE79C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465D4840F6;
	Tue,  5 Aug 2025 00:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="i8WQDarW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0EB5840F8; Tue,  5 Aug 2025 00:12:09 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF2F840F6
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6kZ8VCPnyfwQMmDbi1SY/I4lTVGrel2fLvLUAaxKWCasXUZCRWsqd/F/sG507KOeVeD/vHZRHUxCPWjimwxvb8C7+vFLBpXs7Td0pA1bWOHkMaW5RziiT2C+0DDUPZi3L454a2lWfwZlobB2hQUeGcnoCXzXux2kAtzdjKvWfuzzivPqwbgy2yV61p8/lid41eYqisLVRjbOL/6kuobXBrudI7TWRuhVlzN8NrsNhMniS4G9MZUCFAUw28ilP82qmCXopHL8okBsBS4m7frBJ3KWhiKeUTbiW1qLxE275Z0XvEjCYZV4THVkEvdqP3a1Ga7uPb87T1mb6Klm9fN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdWU62a6x+zzcG6IZXhQlU5s0fTm0z24RCBXc9Tw3wI=;
 b=UAo5oPyLfoscrgfYpPhB9mOhyfWQzocHDqDyhZJM46E9q0lBCfgOxj+UhBbSwdwQ26dsX4r1wsH/LG0eMrazffR9c/KoO6AJUMe2eImitpTJG1d+Qy0dzAOZqhZuTbJthTGRZh/GPNeoGhQV6FJtlcLhGHCsLO8PDz80F3NmwRQ+wKsVysMr3rCebpKtCaRf5A0h72ofBaXzn9JtVeZmfV4ecthWYAhEdEeMsM23vYDriMrsNlz1C5CZPT7VkSWJXHQp/5zvDxFzXqnqX7BAE/rXGsTgaZlbcU9Fcn6+n0NMhAAWFTuiAbubCbnh7kFmtTZdoddHq2CPvH/0cxeS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdWU62a6x+zzcG6IZXhQlU5s0fTm0z24RCBXc9Tw3wI=;
 b=i8WQDarWhul1YbWxXZSOV8W46s9/JO+p/DvevjhC0T94bc6wB/icmwbuFJ8HhGJ5HRqqgHbbhbh/ftyn2hFFlN6yDbG+cGOygA72XoVYizAK92A5E4/KZOc7yvKmkU7l5pO4z47u6Pl/lDSGsYAhFDVOCzPFiEl3NJQ25sFeKOKbGH23RMEAmkJqHl17tEYItuFuTOcJb0SRMdy019KZs6+GL9Xos/w/Jvv0ImlEVfG3+ZctF+i88rnTkSjxa8kMCVBR2O+Mktfv3eDCixlhhA198A57t586N/IrtWo6hqUcmZWp0G4xZKfTZMHL3+JkQNRCYkULJBAug53KGNmidQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 20/22] drivers: mtd: spi-nand: fix direct mapping creation
 sizes.
Date: Tue,  5 Aug 2025 01:11:20 +0300
Message-ID: <20250804221122.1420516-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 245c53b7-6f68-4e57-162f-08ddd3a3ec90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i/1IzH9sQpM3twk0zWRuoIloZh395PSfYZD7sbcDUasdcEXwg0HVRcfflAZv?=
 =?us-ascii?Q?cuo6pPk8Pi7QjqE8FYikcrn8lZdPfnHY2fTn7rLfK3Fs+dIEeSfFtjDuOJxb?=
 =?us-ascii?Q?eHM4i+RAUVqlMjQmMaZY2hsPyWyO9jSvgKzTqxh9grBbIxvsAxCKFJbCNCPG?=
 =?us-ascii?Q?lg21kHk/8midBylwBaZciGMNR5iEYt73gJKtyrlFWiyOM9Nfgl2x5NnxANoy?=
 =?us-ascii?Q?k84jqskwfP7fwFZHGf9uAjQhyiuPZeaEcDJ0CcJXixfKTU7p0yOtlrNFiOGH?=
 =?us-ascii?Q?TeZU4ziNXPjYIdAfa1UWLuVdQuamyodiSrSbF34lBA9r6OGlWVI5gKIQKrfd?=
 =?us-ascii?Q?KhVcySHQlpZ83BSXhU2MNHCP/z3OPKJcpNY4+zoSk/qoaAIZsFkIwSDg5p/o?=
 =?us-ascii?Q?Rqt/tLtDA1j5KOECNBvx9r1djW0Q61ivzM+WhiQEkStq3jNFOQFDzmv9HyWb?=
 =?us-ascii?Q?k3fGLH8k7li1KJbN49zlQqi6p2PJr+NKRDOefm6GXwKsukS1B08jSVkA2WhN?=
 =?us-ascii?Q?Gs3+c5sNque5GKBOwCVD7/RhrcQwrqqdgCr1z8xxKCMk40q0wImIajNR6MW2?=
 =?us-ascii?Q?Qhn0d703jn1MZzKXw8st4cztGZnJuoq67iGneIPTp8IaNnOcYHpT6Fz1YVv3?=
 =?us-ascii?Q?9ejNTdxXg4pqQ0/wPNH0s/8MS57RmXlqgaWNZnxxF0mYX45wTvtXwgOMwZAv?=
 =?us-ascii?Q?dIgWKNEnNd+G1GyBc5iqqgJbNxf6SG1cDlKw1SfDogyhpB7BYtP2EdBaXykc?=
 =?us-ascii?Q?RsA1nSorBfuEYQY1Jvmve4OVU/FInz0bOpx1DnDoWP8+2HPhwQgeJL97sLVr?=
 =?us-ascii?Q?S2WJmG96As+pjMXcKmBIYJ1yeKHgrMxNOQ7dFohMNsagoVzdfKTTR8G+pQvP?=
 =?us-ascii?Q?fIULfy8ZAxf9okCF4rwoSM91NPTJRJJIKYbontKiMWdsNxhZqSiIkQ1TObQO?=
 =?us-ascii?Q?gRdClauPdSAxUUN0T9cypPOuWe0XuVxLeG9TTiodNNrkyS9R3D0oMM2PQYO5?=
 =?us-ascii?Q?NzZ7Ez7xFFGRyMIgT1efdM3pPCCR8rzqB/5Nc0YHwHwY8g0W1KyzaBmHaQXs?=
 =?us-ascii?Q?5BVhxU3PQjJcziP88LW2x4LCnxDB0qF37mxuXfnE9LHFAiWdydqi/Sjm1GY8?=
 =?us-ascii?Q?w+bdPll51IfFX25VMM5RdACh8Xv6YNR8ObDoSvEMDGYcU7YRpoKmLUlaJD+W?=
 =?us-ascii?Q?6CJuxhP0l2m4EDG+2suXKQpD/EOoeRoRYLK6LWap5p123prOJe0gj8HGOwD6?=
 =?us-ascii?Q?b3KbijvLDcD/Od7JcxXcCB82n9gu3WPZm69UZgHJZUNpue4ePVvddyB90soR?=
 =?us-ascii?Q?cjCMLXBcBtywg3vPRRewzVWNbyWTs7CVhXh/Hp5OQGrIPJlCfVLhNy3EhdVR?=
 =?us-ascii?Q?9yYoFfIEJ9Og/LmEouoyLR8Bc8YHyM4w3Sa9NYGBEj5YfKJeWvWV5cRUcAGz?=
 =?us-ascii?Q?w5+7OBTytQpi5RYkZVitxGgKFc57NlUZ0NJE1aZGpLMCgPQ62eSup8hchhwQ?=
 =?us-ascii?Q?XJp8TDSk4hVxSBU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1y4Xm6fgTje4dk3IMf42pN/0Y2Hf9l0/nA2XxC6b596rZBSmVmctQQqxdr8N?=
 =?us-ascii?Q?d1wnh9emWwQJk/XZBPsa9BOdA4NQIZrgGch6rJ5EaqC2/5fnp78Ko0W+5Gg2?=
 =?us-ascii?Q?B35u9qp6Kh6qP36eYnE4ohvanFP7ZymCkh3SVX5KRnx4P8mhrv8FvWEIsCNR?=
 =?us-ascii?Q?yrddd8AgjPGR42HioMvknepDziBOovsQJWJmN4WSIWmfKhgdZ6ppPrNxtB+q?=
 =?us-ascii?Q?Z6P39h6aPkoq31A/917BjAZg3eity9YXFBnlJsb3bUlSKJJoZNXIDzmUt4Uz?=
 =?us-ascii?Q?+jiL5aLLgVC//8V/2jeNST+8DpBqVRxqv0skg0/sBgIFwIlWf6SL1vadJvyF?=
 =?us-ascii?Q?wJrOcFPN1iMZSaA3TYjROr74a3SBTc3IjWSBm1t1pzQ055/slqbv0BRM55dW?=
 =?us-ascii?Q?v7MN+Vs7Opim/DEdHQZBBRJ/jsmIumOPYldRrroNuGm5DsJSYnkvArdyrcAF?=
 =?us-ascii?Q?tUkcWPIKWka851Imu8ISxrEkrwZWYQHVaOueHqm12OxwBCx5UnlqrlG5MrYt?=
 =?us-ascii?Q?Z+NM1ewzmEROKQFzZrRKCbvfC+pTQ12UUQ5JlMxKOVkogJ3AylgUg0loXkU/?=
 =?us-ascii?Q?Zo0tl9ZS4PAPFrDaMXw3KJQ/IJmY3aSoVF8RjjwmmNmtHlE+Nej0mPU/LmXS?=
 =?us-ascii?Q?yDTLgLgJrTg4QBGlUJa/zKS4hwmRbUoU3tycvUePN3HdoOk0EpsNeFYSKbwY?=
 =?us-ascii?Q?fPOt/0Bd0ywCKkjwAaAhxbPmx5QN6UchQEZSoiork1xCY+jBNd1YE+SWjdod?=
 =?us-ascii?Q?snJ1JtFHPqtxj8ON5K1qhhYT+u9FSOR9veJGzE6LZRDd/l7OjyTqno/e1fsV?=
 =?us-ascii?Q?Z5S7tsNtKyvzEzZUgyIeAovcChdf+lin25jCRkGaKNKd60ef66CTceZuv9j8?=
 =?us-ascii?Q?EtlMGLqwlDpEL3LBjGdinfbEG1jyvY61qxCArdbq68sD/vMRPm7pyU3NwshB?=
 =?us-ascii?Q?PuxQacpN1NhOcIL6ufLB2gzvrfeaUw6buKUHsreQXuhAEvAtKOHDVbAwFyZJ?=
 =?us-ascii?Q?beOrf9nYHYPVnKbiJ93ZSXu4hycVkvw1Yba59KW82PIRs7CBroSTw24X8r0W?=
 =?us-ascii?Q?gTvZqQV2EI8UfDir5ILW9AVF6pEiXz9H2hIx64RXtZM8mPbNHBLSmXi4c+Ns?=
 =?us-ascii?Q?1Fb5RDCxckyQyFhMI4NmsFaW3GY67e4lC7RLfRxnJ8A7ePM/DjTQfOGQDqB/?=
 =?us-ascii?Q?EBzFyQdDDVHXz5nV/nT3LrniCHANgd0OGmqGDL0tmMbLOw+A2ppyNsH4rHCw?=
 =?us-ascii?Q?URU2sprKFiU4xCJprmZE+Nz1hdwUWd+If+Sxi3LBBZMBcZfHAwk7fPLQnX6q?=
 =?us-ascii?Q?vstVkzmPOrTyIFh6gORVDXEFNvLszT0JhaGaTJmwVHcb58UnnP6KTcAVALgx?=
 =?us-ascii?Q?J44Pte4gWQpSdvJpkBy2t9k67ICcToDxayuwKy08lbXjwdr0TKkg42iCYy3A?=
 =?us-ascii?Q?hJs/e0yVsrCQq09DXDeJMJMzS+FyH2LNp105WELv+6zdwZW5Vg10EWkmZwnw?=
 =?us-ascii?Q?wai31/axAvhsG5oq1MCK12BiUr12x0VUxiiZbJ8FXmKX3GDMWcnBxbe/IcAX?=
 =?us-ascii?Q?w1SZsukpwbDGbs+hVz709jeLeiVF6xPuk0HT47nF1EOoKvjySpEewtws/tbF?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 245c53b7-6f68-4e57-162f-08ddd3a3ec90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:56.0287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F02j2o/Qnw+P+S78f8wNmnMU9R/l73fxfbkxTu6uv8PuGFf881gEQetYl4ufmtx/FdLIrkodBfRDdMLZiWB6AMDCeiVmtB8t3kcOMkUhhnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

Continuous mode is only supported for non-raw data reads, thus raw I/O
or non-raw writing requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a76878abab1..07ea66825d5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1121,9 +1121,6 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1134,6 +1131,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc)) {
-- 
2.47.2

