Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B038CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EB283A8D;
	Sat,  1 Nov 2025 07:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lrEwqe5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18EC83A64; Sat,  1 Nov 2025 07:24:44 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB09883A64
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oondMgIjSxwGO0ZznI1CE/BAg+47VSrQC820z5hrR0/RjumxxNxzssVILBIqS3cc6/8l+osL0yD4dM3Wo7Y3YVIX2+XaVMyjlhk4rHqH1tk9L2s3Pmhbet0oHdaiswRsjuPI2uAv3vyxxdnZ1KJGGzhsMmm2mBDgv/q3T+0o7+rzFiJZ66m/6pISFAmaSCVwRQ9lO+XAUFY7Pe8EYcArscOd2xpLA4XgkklPddOC63MZPoDzrmDvR+RtnHTnXHkbXwSiR+Z1nR9U6vDvZED6PseQzoBOtlWFmTDHay5cAtJkfO9iDfzRecVFlD+h9TzGqP+Zwjw2lJc7kIDcYwKT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KifwzFij1JeBNaktiSu9d+psyqsmYDcicKouvz7+rNI=;
 b=MH6ukR7mKFaeReIRvMU3ac8wDUjYqJgiO1hwrqD7i1jaxAJIb6oRngjzPY8LYH1qFBLMatSiR3KLmX56zmJhv2Z9admh2icUuccYxfm2VX4SHF6aFEMufidzFIu2lJIx6ZkZEtYBLFLq1EbM813DDoqTxBGHr7zmXpgiHptSeMuxHi4RC1yW5cMNojx/xWI1DulDvQAwxyf/ONURrM0/KM7TYw8RCh2yLH9d+wDOlF578z05QHZt9Y2FwoxGUFl2Lkn2CYX8gjiQnEtT54lpmKDZUP6qzZS8poicec38N6EdtH89OD9LAjEhDuesyZQQWTqlC0S8s7N0V1mj4Mg8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KifwzFij1JeBNaktiSu9d+psyqsmYDcicKouvz7+rNI=;
 b=lrEwqe5OPeZsYRt9oMv318MMfCnFd8VtMYNLTE74KbUlecXTiBmWu5Uel5Fo4B3YdDF6n4AsfHk1yy3rTqw611q+ubjzlxOt8uOKgl40tFQg7kejLRs4vLTbsYjo4IrbbJ6IMXjrZMjHnRxV8xWQ9WHhXSApYHIXIk9qx4dZI4ra2ueiYGIu0MnkA6Unqwida4bB+Jz3Vo0OYPh9SksQ1DXR1jDXaMQm/5FEzGQu2nWpbU04Q94I3iRe0n3G9/BGoI46JEgJM6EAexYwhE/LPJDO10JkLcX13aIvFkeGqZqkcHDgagt4Pf9EIxXSl+4Ov/MAiv1EIOAWvFkSRn4RGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10488.eurprd08.prod.outlook.com (2603:10a6:800:203::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 06:24:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 06:24:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 1/2] cmd: mtd: benchmark: use lldiv() instead of 64-bit
 division
Date: Sat,  1 Nov 2025 09:24:23 +0300
Message-ID: <20251101062424.2488169-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101062424.2488169-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101062424.2488169-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d9e94f-ebd4-4ebd-f580-08de190f531c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vvD94sc7Hc+hZYY5+3DI7DA73PJxcAGDd44EmiX2BFLfMP8qWImd5wC0GcA0?=
 =?us-ascii?Q?zsqDvkEq1i6XHV/ShbhfcXHtTQk+hEXtlgV6f4l9FHtyAwN4wZDAMzJewhLm?=
 =?us-ascii?Q?IrvuwYhAWZyt+PInNR4/r3NU/gCezyfUTqd9/4WeIjaiX7xI84BWoMWtI/B2?=
 =?us-ascii?Q?bvxiPRvUIEP59f9mAXVxr2Hbm4q8Dl74d1fDXCKivnh0RiHevVKR/QfFLw8R?=
 =?us-ascii?Q?c/LtM80BKC3cuqV5cTchdIAiDcpS6DFLd8FTq9PCYkMTaHyUubKZMsU7FxH4?=
 =?us-ascii?Q?3PleL5HAIcSgFv1yHgWXQBmze6vx3gCqxcODunl8NMNpkK+DF1+pDFp5rqJ/?=
 =?us-ascii?Q?UBybL+i/sTk5USXOaTibEnqZlqWYm7wIUk3+Gx/SDqKlBQ8B7Ra7HdrCF8JV?=
 =?us-ascii?Q?QHrQDwVfgqTjrdDEDAREQCdLocC8vhYnfFo60AfyzqxO8HsRaNam1DPyMmnW?=
 =?us-ascii?Q?fRzmxxrDgGBFbsIVHi6J2eAR8Q1hHYbKgDsrHoLA7t2dqvHBGMCy7qEivFmK?=
 =?us-ascii?Q?v0f6ocsVtL5SoT5tQutbfUfRU3c4vMlclAmRuRLJBfTHZ044QquqnfMamAqQ?=
 =?us-ascii?Q?8+mqmf2KWSi6gqY8fjF+4Pyh+j6MgcCxvepee/WPnzggDqrjnB+f1HR8Rk6y?=
 =?us-ascii?Q?BtxZyMdl9lTjEfMdPzez9t3cGiCeyjR8huQAJHO8Xq6Qyiimidj/xUuw1PQr?=
 =?us-ascii?Q?QcXvbB/aHEogFynzNY01oVF5vBEl4doNfMqLmGQhE5usrL+3clbSyT02cFpv?=
 =?us-ascii?Q?jasBuUczAVZ5cezkmK1FAcpKIe3Oims9ze0Qsl/JGeNxBS9rwsLjJNLGMTyS?=
 =?us-ascii?Q?yg00EnvXvKnS4swPnztMHOAApojIFoxpomLJRoNVAOGXbiXYsjj6qYFNEtFx?=
 =?us-ascii?Q?hh7l5nmB4QZm57zDbCWfubeBjKj51AXAUjfRHc+jC/8c9jG0tjpEgGc1q4bT?=
 =?us-ascii?Q?8IbNIpUTU5iBx/SceGlKfzy9BEI6ED2XUslSYPtCvLfeGm8mKkrWhwffEz5G?=
 =?us-ascii?Q?nMO2VSBnhMvQpTJkK1Yn/5j4LtmbfFXPXviOW8UsYLYTLfUznT149/2jegX4?=
 =?us-ascii?Q?pkMFjZGslZoBzJyv9Pubjte4OcFbfHCyuFqd5EdIbdDufwljCSnJ/2O0sZK4?=
 =?us-ascii?Q?VplfyK2LH5rk4sKTposBKhXZT4Agusn02d5GMZ2qD0ZQItcygeBb5NNm05Ag?=
 =?us-ascii?Q?adevt3/T5U8SRhtyZFp+bGhfpS+COmkCmxplCAea+n6o1TfEaBpdGrCa2djH?=
 =?us-ascii?Q?i1gygfkoendp4L/5lfe2HQjD17jLdt42RDhDd7XWk8JcHUJw9msT4hSeoESA?=
 =?us-ascii?Q?ESdomeGPGbksC8SHG5A0514Aeh1kdVDBzp8fPdJSW8RHY2mJ3UnpRFIKEpwy?=
 =?us-ascii?Q?NDDzgiAfo6cxNVYeNLP+yJe/oEUkJ8eGCRl0mhXowGO2T+LXIHX1wY3Gavds?=
 =?us-ascii?Q?iuW9ghfUIRHEE4OXD5uD6jdcLH/SMVlt2/nGJJtYhT9XhhcBGSLNm+e+mia7?=
 =?us-ascii?Q?PEzLHPKpHOPUJ+iEum/ODSxIBzBq/4SVhiIh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RgepPSRe57GMu6ZBq+u6V4mmBunlNJVb6y1iT0ScVla0yVAqv4u4uINm5Py?=
 =?us-ascii?Q?2ZUbQmUzAEgROVSL11wcLc6MSPtQPApdhFKYQ1Oo+SdBIUWj5hEgbjo9yPr0?=
 =?us-ascii?Q?Tjr16ssTL6vU47XrqTphEgKGAzo5VJB8k/IQf/zhpGbzxbYdq1yE0zpti+FO?=
 =?us-ascii?Q?3QsHrNo4DXtd8UHHguA7nKDd3/LmcSjwrgX22TL49uAF3FQm+FQLnVqpoRGj?=
 =?us-ascii?Q?4CtkL6DQFbiHpRuwGxm0BrFgSTHW1TR12tLlmPIrpTghhds0xoOsV3z7TqNZ?=
 =?us-ascii?Q?4YEWl5E2sbcviK9Cb1TT9IMjvQ5tk8/umD0jKe6O7jeF2IECO1ZZ5R8WjWV+?=
 =?us-ascii?Q?QcFNc4DPdPTG91TK82XI6IR9Hb9al/ki5eckren6CzjHB7SWl6YuT7nDoxzv?=
 =?us-ascii?Q?hZLVpAr/8E5dnDtgwXcJ/lfjytEb2x3uzqeo/QAy9VBP0G52w9evKBA65QDn?=
 =?us-ascii?Q?BRdPwOlFwLgy53GthRhNc2gmTX2MFzJ4UjEK89ddOmtvwZOnBZ6is6IsA9kK?=
 =?us-ascii?Q?jD35spJDL2fG+MDIPrxRrK4rPnps64zWE85ydY2WOk2YJ767gWAVdqOIOsUI?=
 =?us-ascii?Q?PsRyuoGSjDyu6vJSmAzFN9tjD8PTjA2xqO8I2a2JMNhnWPlYg0L5u41+fJgW?=
 =?us-ascii?Q?V/BTpE047Xugz7dxYh5x3Rk2Hbea5Ttqj+rEZPeBuidRl3Fk4f1OW+zazvaW?=
 =?us-ascii?Q?jhKOhIgf7etD1vVm1i4nCj+vM779X8bxUzZlFw/Qf+207Ulqy71dcKq64jit?=
 =?us-ascii?Q?adQ1AfVpaZLkbmEIsH4gN8nnHwgfCn4V9xN8Pn/GlFKq2xsly5No1SD5Lpy3?=
 =?us-ascii?Q?XS2q8AAAe4zFTm2aeNa3PuG/CcEm3l6QtcceCd/DrRTgv2D4W8DQQalxzhau?=
 =?us-ascii?Q?KzHXO5tZpNSzNsHljG4bXsMgC3Eje867oamBIaY+nfMLBkMcFd0/+X2jP2Tz?=
 =?us-ascii?Q?15tfNQ+T48j5f0FPpXy6sZJUOB8m2FrNlnqa1WORUQAUIpTG/FrQMol+8aGp?=
 =?us-ascii?Q?F0aTwS3TTZXr5gW5D1RR99Pi8kdQaF8t6HGhDilumrvikaaPn3ApdNRcFe5S?=
 =?us-ascii?Q?w0RtAgMeOexHcBe8DjNEBabPCH/fF3hCGnyk3LaKF0HjKuoee+Kc84UDXsLX?=
 =?us-ascii?Q?+kWXN4d+eddiEmNojB8mmHtNJaBG6IOerd8CrbkahYm75SE6wPk0Hf0GsMTb?=
 =?us-ascii?Q?u/lg48bFD/QRB0h4BxF6W+AhNXibjsRSwyuOVq85HZFsIBjTTFa55HRl1IBi?=
 =?us-ascii?Q?M8IAd7RblfsZLemOUHnacbImtJlRRR80PAHKMQJsHy0d7eE7wDf+6ShEBzMf?=
 =?us-ascii?Q?PhHt0d5AR/FggF0NmeHo4ZQcwLFXPBWXGoOUrMhgAC2NURcoQtx9mvzJjsWC?=
 =?us-ascii?Q?q/IGoXu5MV6sOJQuBLWwpChZOJrIYAfKDmhW9Hht/RA0+noOehHErjwPLHOb?=
 =?us-ascii?Q?nJkO9ndYw2mO7c+VFDXUboOvP2vuv3r8hw3y9rj0FZPvpBBXr7IfbjjQMJuz?=
 =?us-ascii?Q?VM23tZtmrQ1lT/ZrIuM56OlVlAiJJ5f74MMygHqtuPH0ACdTlZ1xL5vcayb/?=
 =?us-ascii?Q?qpi4wkHhPofZuQj3hQ/KEEjhsv8DhdrcuO4aAaLt/FNwEle28lIBWh78k12D?=
 =?us-ascii?Q?lAp2J69BZEeiRdiOUGE+5hY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d9e94f-ebd4-4ebd-f580-08de190f531c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 06:24:34.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HLZAYnRX8E3bNuwucB+lrmMOZSHrR/MISlFqcVKVocmMpXaPtlpNgS1lXsrw4p2zgB7H6CAJPqahJKYboPH2fkAFHFFanrrW0oinhh6+fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10488
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

The code assumes that the benchmark never takes more than 4294 seconds
and thus the difference will be less than U32_MAX.

Also replace (speed / 1024) by (speed >> 10) to avoid potential 64-bit
division.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index d0072129659..7f25144098b 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <div64.h>
 #include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
@@ -595,10 +596,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
-		speed = (len * 1000000) / (bench_end - bench_start);
+		speed = lldiv(len * 1000000, bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       (unsigned long)(speed / 1024));
+		       (unsigned long)(speed >> 10));
 	}
 
 	led_activity_off();
-- 
2.51.0

