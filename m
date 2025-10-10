Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B7CCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5953D83F2B;
	Fri, 10 Oct 2025 18:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1OVpZhH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D142583F2F; Fri, 10 Oct 2025 18:51:17 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9F183F17
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkt1XWs1gFCxCiCf8FHQZ7j4vm/+p5/s6NaoDoq99kRkg20xKTG7IvvO0x3RmUW3OmhvuXnYgvTVFQYgmmSNfZdeREqWygA/pz6STDOSRHOg+n7vMvX5iDt7lNRtzBGYUYpSxKK/3XEY/XDPisBpqdJZPQ7MXLMvzWDYvT15uJLRR/0Q0DJtIwbog3AWJwLG36FYRQBVOHI8eZA9MXb8EXJegLYAtPN5DTaxhIbIpUYEyCGuCVJHl4sj1aHkDtFNYja3zu2dth2SiM9xe9OvyJiok0JZF0vlsOUmf5noQQEPeujB1ldP/sZKT8A+03ECJf+Fmu/w/5Ciw3JjFep/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sz1cgzvf8bMb8AGqDSZ9UyivXvpcnZsvqtvyzdQzeM=;
 b=j4lPEBeKNoD3djra6q5n6GjjFR+uqWn8H9fdpofe25PSJ9ZV1MEmqXvFexVAevNBfQXa9M3r0XEjbzeazOnSUIZTdYmL1ux8D+8y7lL26xw7OBogu8t2fO+xPSCsfdWC5VpXwMNVSS8j3Rd/MZKO+vxJDApITJdMkcPFdXckv/cO8hktT/6Knc+TgsM0H6KuazsiXZKIb+CXBPGr2N2fU61T01sUnVHbmFk0qEmgx358ctF4I/N+bcLgnBGzs+4D5NylkbbCKDdkaWQpZBvz8o89yFLKIIK7gQpVAoXirPMWnJCe6CfkwjrW9iIX9PC+HfP7xq/k60ESBsConjaPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sz1cgzvf8bMb8AGqDSZ9UyivXvpcnZsvqtvyzdQzeM=;
 b=1OVpZhH20BBfsG+UTCIMNmMenOE0ZD53yI1WbF+gzsAjDBUYaf5TIoEK7jDKGyxjfmAueMS1FLBfmuYQB1GjvO44Eezxden372eALDLdv2uPgTsUsu/l/Zo32vMNW0ue9qphuPOY7wZHY0J/jiIAF3dELtZvSWEeC6TGjqoJhSWjAQJLydG8U+8LPw5mJp8ixqR2rl+R1TJuuG9WqYj5BJP56XXB4JKSSqQE+o0yBF+DcV6b16ysQXOfrslD/p50Tsooosas3NifINl8oYE0Rqfz4glKfxo+/cUU8RXrkZHF8WQly7Hu3i4NYMikb8NlZ6/an9d8u3FdXP1HbsM90A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10931.eurprd08.prod.outlook.com (2603:10a6:150:1f3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 16:51:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 16:51:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH] cmd: mtd: benchmark: use lldiv() instead of 64-bit division
Date: Fri, 10 Oct 2025 19:51:03 +0300
Message-ID: <20251010165103.1572444-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A90.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dccac35-c04b-4ac9-4f5d-08de081d3705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dckJavt7l/3gQEIdnliXgPoR3m9OssuKyJ6kdjOKysmfV5uqtQME7HNttGfy?=
 =?us-ascii?Q?Hw7/grJ/cQ7JuqwGoXjRFBHmictxc4BsFDd9oxleIs5mgMfQ8GIG7Qv5AQpS?=
 =?us-ascii?Q?fsNe/TcogfhO/A03vUcMKbfFOkLcWcsFqQcyf+eYAmw+488PM4yEXiqcZ+6d?=
 =?us-ascii?Q?fa3oqqOHtsuKM8Eeqat7bEuSJSb1/QA+2xCmxrRrzOOt2jO39bwqABXG1L5o?=
 =?us-ascii?Q?JN0nPpmIe61xKCY+y4qPte2snoiYo2F3lRKwHvGOFE/GHBxRvFErujRR8GbW?=
 =?us-ascii?Q?eMj/kqsQPdvbOtWCeimaIMCgNybu2ple2piDAVmVZo0yIif8zjstufkI8q+j?=
 =?us-ascii?Q?LLOFNuOipsvDSncBVDxclfywqU81gr/mgY32YR5bOF+r++fjjmn2cSmJXcSu?=
 =?us-ascii?Q?qEr5jiNYmd3f/5TrNwoCfKW/8+7jRCCt7sYgCmsz4Vvsq4DD3KgKn+z7DRPn?=
 =?us-ascii?Q?o0/fMJA81VmxyHO1Ie0lW4CHOpnEbZ3MNUCwo6jpEFdBYt6yOCnpkOAka6AP?=
 =?us-ascii?Q?Ho6r9u3+Ax2CE1drRdjn3TXPfA4S8Y3MOEKNLoC4r0TD6vLWJ1tR37s0nNEX?=
 =?us-ascii?Q?RrnONEh0UUAh3JsagHRYuDwYAOaCqeYs58I27SSt1+Ji40ppYsa3QUwXW2DE?=
 =?us-ascii?Q?LzScfCk2o/pM4jZ8b5xidFTayFIAOPgX5ww2vneokXljB/gkAub7KRRf0QqC?=
 =?us-ascii?Q?N/SWpAB/HwOtShIPmlZG9ZPFo6soOflOhHs/PdefekbDi1NqfeBhdVMzSBKH?=
 =?us-ascii?Q?HyCoTzf31nbfbhjqVGUVO7gyb6BRO0HtoEwDo2PBp9rdmkmhULOJdeJVNN6E?=
 =?us-ascii?Q?ozh+lDRS4JaRO6QjZA49cOZ+wfXttORp3DHbzJnTdvxcwgRdR2+7tBPxTEx6?=
 =?us-ascii?Q?fTYdZy+Ruu/2ejmvqpgvNwrGHbiMzajvmg3XVW3Dt7DnHsCOxbdNtNqYgM3a?=
 =?us-ascii?Q?KdiVySPn+rJfrW/RJRa88wskNtYLcTkjj6JwfPBNyWUjagEgZXDy9vAGfPB9?=
 =?us-ascii?Q?0oJS73zOgSBM38kvW9GP8ye3435X3e4FEIs3nYmPRPZdV6wkCuX+4rH6xQF0?=
 =?us-ascii?Q?ajWQwH0HuzUuOjoMdMDigfK9EmcYFOpzO2B2usW2WbM7eUEFqMLsDD4lSPHz?=
 =?us-ascii?Q?KRDbGAYResHYUtlSH4oAVVIIslrREr7owx7pv70DxXByH+TOLjvT4j040+jG?=
 =?us-ascii?Q?gNaZ0reK6lRhz8b+OfUro6FRLQrOCj+G812y9/pjpx4oJ6nIZz2QNyMx41Eg?=
 =?us-ascii?Q?TnJ6tVZaogWqgbT8mF1PGK3DLfzVYMNZT6VMpi3jJXZODQJS3rab2Sea4R24?=
 =?us-ascii?Q?UNdkfCWxgSaiGOfNpmUHK0ph4zBReDCR8Vwk5ef2jN1C3mou2eskVWNCHhZu?=
 =?us-ascii?Q?YQfwR2KpMdWXAmneI/jE3fF2HK67L/t3nqnZHY7M6xDL0HOzoplhuAnj9pLK?=
 =?us-ascii?Q?UwAXf90s9qi/zzlfCYBxIVAJC+mr7h8jDkD/WT/ZheJqEyEFCPG80HaNnEFx?=
 =?us-ascii?Q?Xu2mOXCy4NX/1fvTNMyOvDhHLATBo9/p102n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iyTBNHid64i7LzJIyRCKw+BpggVQMWMXC1UW0i/GXiwT/Dx3IRp82XqHKXXG?=
 =?us-ascii?Q?qOyPMeQBxpeTz7d7y8XKFfsWXtdTZopyfup3i8PRQmr+gHK8zhdITic3rTND?=
 =?us-ascii?Q?j0itdgyG8HYucLqCF1Jn644TVR9qmbhZEYmKVqwSluX6wUpExI9lCtxlO1oU?=
 =?us-ascii?Q?n5tdCHFeI5YMPIvqAtBZleI7fYnUk/mQ7+V7uR/UYktZbByqC/HFfKub7DqQ?=
 =?us-ascii?Q?mRy6iyNVHjPUXx+qhviktat03SAAg6f/UwvsYnE5TLWJ8nfZaUGab7KkLJKU?=
 =?us-ascii?Q?+UGYrJkDJ3ErqwKqgtsvUSy0ciBm9V+WEXrtnVEYw71MrlZsulZb8L8a8YWc?=
 =?us-ascii?Q?5xPC7Zre5rTMmtccTgg9pLD+ofvorv0qdtyDS44vqXHoj3TY/DP1zWJTOzAd?=
 =?us-ascii?Q?XyNEQ2sU/29pnCj0ZMIEDUmOrix4pwpt0iM78c6yTEph4e9UGBnYSTswgPmZ?=
 =?us-ascii?Q?MD0HTYh6Uj/zx9AJyY8tRczpW4nzGfIPLSBL919X+kHXlCWFflPXRR9pEC6X?=
 =?us-ascii?Q?gFto+a6lqO5S6geIPvLb+8DHDIV5H17gqn2KnnNUsb6fUYc2Zm+n10GwgUGw?=
 =?us-ascii?Q?JpvUcZaaRozT6ujxbtrvO4XN44UZUj8THjp9n2tQzqUW3XZ7r2TaiAPEQ1se?=
 =?us-ascii?Q?QW6dziGLFqtKGgZfB8V967Mp++zT4/Ey8xl07UqszdSB5UAQC8qI3Sa4A6wO?=
 =?us-ascii?Q?Q7XaJsqq7gTqMhjk1pGAQsVW3oO5ljnSPaySWbhMveP+ZC8BcnRMivtkigIG?=
 =?us-ascii?Q?frc7YTt4CO846U6Q07hmZUjzTDD0oc7E9qMNbHeknncgT3lLP1sJiU2Ec9mh?=
 =?us-ascii?Q?TyL9YYQzEhwhSpu8yTasRWOr4y36IGMrp1zUJ4R4W41YK+wV36sJXxXMt87C?=
 =?us-ascii?Q?jV2jLj94xp7N9cfj5hgj1sU8qnw7wqQSOv1JNsxOJffQ7L9e8GJmJSP7RlQ5?=
 =?us-ascii?Q?erjUNj4LEQdMqAA7O5P7Saig2+KWYOt5XUIBGTExxzuITqv6kO7mBvLO1cPl?=
 =?us-ascii?Q?DiM5abq4MShjIdaRENYYnpx1MSdGN7apr/Bh7BdgtbjffWJAA6AsuoDye6Ge?=
 =?us-ascii?Q?OAKWOY3KV0S12hZijo/oJOq8iPtsw5yLwSQoqRBa3PatU0eq/Vy+0XrExGNp?=
 =?us-ascii?Q?q2rr5X5GfGr1j6gzgRD5TvPZqhcPzl2c33Fd9FG9M8fU2yHJv4/9Z/UeThY9?=
 =?us-ascii?Q?rcJPgs6gSaKi7aJSC6Uc8hvSJlkEHkRLUrpYu6olHjFocdYlQd7ARn9bXqy7?=
 =?us-ascii?Q?CEgmsFQ2DgyF7O404W68FWeqGt5RkzBWHezFmUzj/AHlStnIXksPxwJM5OuP?=
 =?us-ascii?Q?EF1JFoarNk5nLKVk0lbHxtv6oRfwb6eNQNq3EN+tgFYeHhIUftgGX1c1aSxR?=
 =?us-ascii?Q?gYZaJv5njAxdnU/1+ZxwzDc182geNQqD9V3pJtSqMPHuv+KKYRmK/fnWOzwc?=
 =?us-ascii?Q?H+90yxw83Sya0ljyh721YKSLxHY+qv3LDgn1pb+S0XfaoRwLAtQWSNj48JMb?=
 =?us-ascii?Q?5zz+SBafOkPBEY6pGdzDDUHg5PRwRvov5fBfp9xyX3RAha+o8DaJvNKuUmpO?=
 =?us-ascii?Q?EoV7HFZnvTKx6Qer8Ary6/9Y2jXzAznWrjDb1ThRk9vwls9CKH+m77o9pUXB?=
 =?us-ascii?Q?nfteBjrje/+CeGMgJLHA2Uk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dccac35-c04b-4ac9-4f5d-08de081d3705
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:51:10.6619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rC18gyvqh2C9LvU19gxrUnHCy1mimzsIXOlpDhIxwzaLbyEAgcox+EqT80/CTdb2qnhmS1P4F1TYVoCl+mZ95UGTs86wwu75ySgbVumy/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10931
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

As was noted by Heinrich Schuchardt, some SoCs may not support 64-bit
divisions. Fix an issue by using lldiv() instead.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index acd886da6da..2bc9fea697c 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <div64.h>
 #include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
@@ -595,7 +596,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
-		speed = (len * 1000000) / (bench_end - bench_start);
+		speed = lldiv(len * 1000000, bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
 		       (unsigned long)(speed / 1024));
-- 
2.51.0

