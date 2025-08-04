Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3CDC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECDB8411C;
	Tue,  5 Aug 2025 00:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZFiiJBe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A0A840D8; Tue,  5 Aug 2025 00:12:10 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4798401A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNQmNGa6FFRQZwxIpY/DRF05MWoBOZ3DJ7m07mz8skP4Olpzln1IkJd961msR5PxjFRkCjLqMUIMthGj6ZkupO/3Ajp3ATpyVQGdcGYd2nKN1gVbDcsE7lK+lgym57VB2JVkCfMLnRr0e9OCWbGNUt43pxvs1eBA7aQKTcnZGav+3GTDaKdXR32ORSaENzW5JXUQBWrtA1kHZ8VrA59MwWWXWyDVRpGIWwRB1DOgfZJVhpSDMOykWcpc/PtwD4dnvUbbmr1ACRM5Kg73PUD1QgvBEgAoUurOnwlKAjCIKA8FOGa5Y00sbMWt11H375EjArXJUUisOP6NcNgDMza/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmBvzpv+nhSYHiO7t9NoFmiD6hs9R3wxs+pJUmi+wSQ=;
 b=nS4lKCht2hmFGDaYIpW7/agepDBnQW1F5WmESvzgJctgLZD/QF7vuIz1rhCflySxYlzhRfPM1yEddMDuMUlZtHs6SH2SiH9dAJYXcl/4BND8pv3FfA2314gjilGM+lIvuFpBvr0ooLPlBP0nfuUOfUT77AZ4B1st0g52a2hGH8UXQKXgpatutozsh6BChIElXqjaa7vK0khonI5ve89oiXNEBIv/WMf/FPv9TpTCkJbRFG9/+NVTQ/UkICt3yGAoOAA83wDfcoPy8e1vfehyGCra/hUuqpI96i+5J3eFUhG/7C5XBJZML4VVB9RC+8yq85FDAUWOfSPhvnpHkmDybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmBvzpv+nhSYHiO7t9NoFmiD6hs9R3wxs+pJUmi+wSQ=;
 b=ZFiiJBe6AdqKwPr14XJsXl7bM9Bbon3SNz3tKvUaWZifNdGbOQR5ug6hmwp+QuO+3MqVZhD8xEiWwL94ANz7qz6znL77hDeUccFMkoie4GBbXVThp1R5tXydwrFs8Y2VVqmPIzJ8VpKmHot8QEfdZChONXMVsDC7E2uYuMNEJdTG+h29WiM6qGENX7ft7HsrwTvv3tVZWh4laxCPDb1vU/INRhATzc/XhpfoLuIlHNqCk58LPA5Cf/ULqPSnz0vA4UIuk1qhN0HWbhjDO+y2NfybFPSM8C7jnalMZL4RRNaEv1SI19APlW3sxmBJ9kJZcuTe6pSC6pJIy3UWW7zIXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:53 +0000
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
Subject: [PATCH v2 18/22] drivers: mtd: spi-nand: Enhance the logic when
 picking a variant
Date: Tue,  5 Aug 2025 01:11:18 +0300
Message-ID: <20250804221122.1420516-19-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 3ce16775-ec0f-4fb8-925b-08ddd3a3eb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBYoZy4gD1cJayI4V3AOdOqTiizLB1cLcPK3lcKouqGRDRPiRYB4558DclUb?=
 =?us-ascii?Q?Zze/oO+T0cqePuJhNSjUfWgZjesy1ZcSw8BfMNsresa2LgWcex00acrUnvd3?=
 =?us-ascii?Q?aoe87gPAhBqcLHpJhq2i0XJPF5tvKrS2t+30KlzfAq0hQyYuMQ1W+poAeKbZ?=
 =?us-ascii?Q?odoxgjFGUkZbmYfFbmThtLSijOc926SpmLUgXSRJR6g1Ntu5MBsLY0p7F7L6?=
 =?us-ascii?Q?C7yFRU2YB/+bP6vbgmb9rEsXSQVPaKyKS0rOhxS32eWyYNeWGL7KQ9cuvFZJ?=
 =?us-ascii?Q?JAEL3O6s2X8OPBZCUKqZd1z3mwWcEShKFjP5DTfPjiJNDROWudiXrX8cxagt?=
 =?us-ascii?Q?i/oF9ttFjIFmBcI0bG4wxiINIUISY7itZfIKuYnKD6Ivu0SdZTpSxZFmwEgQ?=
 =?us-ascii?Q?BJtx88fDXcaIuudUfIAC+aM3qOFY4632vEWGOs2VBEoo68dh2EVzYuLCNNMR?=
 =?us-ascii?Q?5eKcZpOfPxMPDb+ryiOK2QwgkrwkDDbN/nvz1i3+aVOR5sRJ7OGDYr0yBhGM?=
 =?us-ascii?Q?uPk8PHWtqWSijfsBdgBrXifT91yeC4ZvxtFPuhsaYHL0d4jFQgYy6V8T4Jem?=
 =?us-ascii?Q?b6ks19pAPfPj7KC4zIBxnjoKD4PedJhTawHW3HYEC2hxQhYL9OudJP//x520?=
 =?us-ascii?Q?JP3x6lBMYdMilLQj6JEXb6bG0DlmW1aRinN6qB6+an1impr8MrMmF8v+wO3L?=
 =?us-ascii?Q?MIYubrOnCclHzFFlXF9kbPIemOt0CJE+DHrnsmjbcZEwXiXbb5VkEEd4+Bqm?=
 =?us-ascii?Q?OJ+zDRQSFAu4UJi6hOC9eFxKTWHrBi4MNXBhtqpvf+9gYpUVgaTU1DIq0Sbq?=
 =?us-ascii?Q?4IjOwcbvLDdF+FfSEUu24Fx+2z9BCbkdSElD1+pIaDFZrau9TyFk0IFtPS2x?=
 =?us-ascii?Q?r4wtspS7lSR1kXIWJ5hRUn9WyAyFLwTrWzcW3rMh1PN6W/5+sXEIUdJQadaz?=
 =?us-ascii?Q?b86YLHEhZg8/gOMLKF5F8k7lH7KBuXghEI1KzjG3zcogpLsgwyPzuTjps2mA?=
 =?us-ascii?Q?3uen8ZVYqS65FVqvWTKA4SHJHmolbA849g55YjeaJ0+8/oernfnoeDbtF6O9?=
 =?us-ascii?Q?luBkUMVvzDH6bQHJZYQ+p+MICEpignbApnMXvZD6/58IKAn3kQPdaheQyxBa?=
 =?us-ascii?Q?4dYizphveBXuw7YObK6E5q4xonkFR8FU0bVEcvUG+vO9HwKOqjJBPAgh7O5C?=
 =?us-ascii?Q?nJ/xT4tWwCpZNcb4QQePCYqnsMZvmDW8eU0h4bTlvoRyKdaxFxYn8ACnsRNM?=
 =?us-ascii?Q?CSCSXaFNh+AX2AFBsRW+QY+mliZvzsLUIf4yA54lAvQ9FO3Cotjl7n0mUkce?=
 =?us-ascii?Q?Jc5h7/K9xfWOMYKyXS7mFyBEDX5VVEgJHWFPzcQcLZBH8aXHTgNkiQBmdti5?=
 =?us-ascii?Q?2nDGDCS6r5sbsiXa1HN1VwRbvDWmbZ8U/mIXzvMwS4+CyWj0qv9ZPX0GFUPz?=
 =?us-ascii?Q?jtdIsDxs1pdK1o6W9q5CFLU1uxYKVkzZNpxFoLmtyL+Pv5DTuYLKGH4SEcWH?=
 =?us-ascii?Q?JrS/fTkhD1sXfvA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Or89N/A4vXdenZGzPAIRgx4g4nZZhQJN2Sb7ML2SLc7iS7EFnoiXFxCpufUi?=
 =?us-ascii?Q?URV70Hzm/wRapbEcIRYjC97ZjW6u1WDxpCsqOFP8njm2fxONqv3dW4gyG29M?=
 =?us-ascii?Q?adFb2ZffsuqeePj9UFnJ6F29XASLyhI42MZvVdKsFU7aHsB8KEANYRfecCwr?=
 =?us-ascii?Q?BiKcKNnPFQ1kO6EtNbyiO5gtudzGz6E63J1CtKt/41TKyBSqr5Vnxzc2hSvr?=
 =?us-ascii?Q?hm03Yb94IM46PCyytB/6jk8hIOsBUeN7F7Rlv8WytX4Mv8Ol9cz6GDfW6si8?=
 =?us-ascii?Q?fmvwLqRkqY3rSq8tm+TUSNGqoKCoypSNgW/ldCM73VelMyYNvqDF34z0wcP7?=
 =?us-ascii?Q?WBXY7hkHffW/rsbHDUru1F4+IF2KjGBLnn5I0LhljfvOHdS/j6HWwTGEBEkX?=
 =?us-ascii?Q?HU+Sw1GI0vPK9r3FC3/5+v+v0lNlYwjZgwiTVRHoyEZZw5To2+KdLEmAktaF?=
 =?us-ascii?Q?y4CkLs4gBWTGUMLQqzvIttlSbQq6bfi58nxX6bTv7Q2XHHGswkRfMo8oSTgx?=
 =?us-ascii?Q?DQlXsdnxIyg+h9xyTeXCJt/qkVWkbHQkqyAYkTWKB9BDZ2IEGAjf2FOp8Rhc?=
 =?us-ascii?Q?gmRtntoJSVi9JXgkbxAE1MPwzkQiKYneEYVgYzOEFoHS2nHvXwbvvlBmu54Q?=
 =?us-ascii?Q?36GzB5q3rLMSGABMCu3U8Qmq4q/KL5Puf06E5QI/UUBLJC1/aEZkIYfYpFX8?=
 =?us-ascii?Q?gE32hpct0fsx2gV3YdqsZWwrEpiVUtZ15OQKug2POW5mk//RD+ATdPICKU2B?=
 =?us-ascii?Q?1F7YXW/EoGA3ND3qK28zxQDOoLL0BzgKMu+3rU/nSDstF0e0B4BPuLUVUs0F?=
 =?us-ascii?Q?m+uPFLbtKDhKWqEj6SM2iAkTcklT54GzzHB0oF/n7QiRhz4TSMvK4iU7VOdK?=
 =?us-ascii?Q?UKpfD6pPksopqS7cWbJkU0m17lLlwAyNuKsq+XrW0lycHeswu3RuqdpKmwnF?=
 =?us-ascii?Q?GF4V1wRvyp8oJTsnQLonl9Cm27LlJGbv9BirpUdYExzj29A5sy74UfgdBpDb?=
 =?us-ascii?Q?30iE6mnjKFdZ6k6XcXTFDBh5CKFaSyOfG9o1M7UwVsa2jAqoGN12sMMeUbLH?=
 =?us-ascii?Q?yRD2DIP6UGBGu5TqOetZxmBiVj1Q7Jlfb7mZqydkOPWGaC0SET9QOZHgGcoY?=
 =?us-ascii?Q?d8iD+tUQrV8OGEGLNMvpGaw82aVziWx1/+V24CkH4jUD6rZzxrBtN5b1eavA?=
 =?us-ascii?Q?1r05x3lVhboR9kage4ZJdm75O674sIzUP5wfrh2GPUQP9crp7ewJHasmht5Z?=
 =?us-ascii?Q?xRhVO1oJ1cF4wTQanFfa0TVbg1oA+ETXPtQXqErZE6n34qnHVMRIgcAr6ko9?=
 =?us-ascii?Q?vt3KgB5CuiAS+OU6Qe3Vy6pSnkdg4oMiwv64kvjRqobJgN4BfRbiuTxCwoZM?=
 =?us-ascii?Q?CWs8+N+uB91MslbgxNeMHa9JIGVn7FxSnNSCMYqsgro5zcHQM20xpKZxCpgB?=
 =?us-ascii?Q?Amtj7fO+NYapMEvqK3DoMF8+HQMBLpQRWE4We5In6TizBBHU48H8IY8KmkWM?=
 =?us-ascii?Q?wF+Mj/IVB8uBR4l/EOy4kJPBsgTSkfkgUfTIq/rNl2V2G2Qk7F3eJL/wpN8K?=
 =?us-ascii?Q?TdFGMInMSkj2vb3SZy4L468O4gMD3jdDWvbM2K3iMtXKbVA0vboF77CHs/3u?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce16775-ec0f-4fb8-925b-08ddd3a3eb04
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:53.4094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C74cWOtrxhTK+bCUA30RZIOxbp06Cv3BoBcm/upu8WNwFLKVA5kQqFsz6P6sXbPw3Hz2yyEHmzCGqcQrfuJOCRe1D7jSfyZDMkfkiQkGOj8=
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

Currently the best variant picked in the first one in the list provided
in the manufacturer driver. This worked well while all operations where
performed at the same speed, but with the introduction of DTR transfers
this no longer works correctly.

Let's continue iterating over all the alternatives, even if we find a
match, keeping a reference over the theoretically fastest
operation. Only at the end we can tell which variant is the best.

This logic happening only once at boot.

The patch is based on linux commit 666c299be696f02c3354da104295fb94b8f65d25
(mtd: spinand: Enhance the logic when picking a variant)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 13 ++++++++++---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/spi-mem.h           |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f16d3b0335f..daf6efb87d8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1266,10 +1266,13 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
+	const struct spi_mem_op *best_variant = NULL;
+	u64 best_op_duration_ns = ULLONG_MAX;
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
 		struct spi_mem_op op = variants->ops[i];
+		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
@@ -1286,13 +1289,17 @@ spinand_select_op_variant(struct spinand_device *spinand,
 				break;
 
 			nbytes -= op.data.nbytes;
+
+			op_duration_ns += spi_mem_calc_op_duration(&op);
 		}
 
-		if (!nbytes)
-			return &variants->ops[i];
+		if (!nbytes && op_duration_ns < best_op_duration_ns) {
+			best_op_duration_ns = op_duration_ns;
+			best_variant = &variants->ops[i];
+		}
 	}
 
-	return NULL;
+	return best_variant;
 }
 
 static int spinand_setup_slave(struct spinand_device *spinand,
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6f06650384c..db44a7b26eb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -499,6 +499,38 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+/**
+ * spi_mem_calc_op_duration() - Derives the theoretical length (in cpu cycles)
+ *				of an operation. This helps finding the best
+ *				variant among a list of possible choices.
+ * @op: the operation to benchmark
+ *
+ * Some chips have per-op frequency limitations, PCBs usually have their own
+ * limitations as well, and controllers can support dual, quad or even octal
+ * modes, sometimes in DTR. All these combinations make it impossible to
+ * statically list the best combination for all situations. If we want something
+ * accurate, all these combinations should be rated (eg. with a time estimate)
+ * and the best pick should be taken based on these calculations.
+ *
+ * Returns a estimate for the time this op would take.
+ */
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+{
+	u64 ncycles = 0;
+
+	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
+	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+
+	return ncycles;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/spi-mem.h b/include/spi-mem.h
index e68e2b50e85..36281a62f77 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -392,6 +392,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* __UBOOT__ */
 
 int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
 bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-- 
2.47.2

