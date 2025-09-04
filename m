Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8543CA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312E483B85;
	Thu,  4 Sep 2025 16:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hVY5/Tkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D59A837B9; Thu,  4 Sep 2025 16:32:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2080183B0B
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm0GhvY5JNJZlD7c8yuxiNpwEwc1tKy5oRwzzucjT8uCS6H5d8hpzpV7Qta+XioOv6K8NuJ6u9L3eDtTKBhu9t3zPf7GFQZEWkKbJTcYtZMek+TtB3xIxqvXXz2oUYYF5UW7YmkCKMYMnpJ52ANLeL3LWNnkp1HGWnsr9W19ECCC5c5KWdHGiQJDQNql+7jDzm1RuUuJHR+Ktu0K6hHpFuNm8/XwZKo5jAx7NRUkBGV22Lodn4y/YsWe/mNAjd/lYYk4CLiniRXJKDV+SfwH+eDL4npSDs5U1XCMVD3SjZWzWjuuWHj2aNB49GudkE8BJ1J47GuqWIwCGmbB1Zs2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y90FpddiJyTGPvWE3kxw3xsLlW0nEo9pZN6eYRUznLg=;
 b=ShqnDyZDHfeB1+tVbsOiQ2VfC8M1AHVbEKcdeEgehGkSTtEMLkEHs8SEL9N+gwQUhucvi9UFypNmGR+D56kPZUzXkyypSr7cCS7ne2MJ8fu68jFfsArLLXjULiE+VYM48SObl4Gc+ABcFY0nWl0/q2RkGfhQf7fJcw2c2SLBdMlbktWFxRuPUjCV4+v6P7NwwaWaVbMv8OF0jVSBZr3tPJ0PB+kGPqWS7jTRcok+NpznLJBfjpSD3dEoQL3fqHdElz/fGruoDJKEvw64+D+sGfL1Hl91iEtSH34dziURUIvRL3Hrj5kXjHgRrfK/I3kEhpL83i+eBxYMc5rl51yRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y90FpddiJyTGPvWE3kxw3xsLlW0nEo9pZN6eYRUznLg=;
 b=hVY5/TkbBLz/vCiGAAViZuKJuf7KNfDT/64HAk33Ur19DeuI6Zbnf7HIPKY8VJHgiNRGE0RdtYZtdBQAMbqv8Xs1szU8JU5i3Ioh/1Ao59wicCEP9qNOXEHKvbauRGuTRJ9MYU82bWLTEWLyhS/0juV5rQ/8IDsJRd5P52NPlTiK8BD2iDdwSLFhzJvKbnbnak7Lx5iGX2tSzkNIKk1+MuvIS5ArUc490LS9bweAsMtW/V2vJZVK5Zv7oP3F51NB98J2jm+3DERAb7pZ66udEKHA+gBfVd1FSKbzfWTP5IY7T8l5X/Vdu9enN90eImytWb6dpEhQXaEIgqe4p92i2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9231.eurprd08.prod.outlook.com (2603:10a6:150:d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:32:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:32:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 2/2] cmd: mtd: add benchmark option to the help
Date: Thu,  4 Sep 2025 17:32:24 +0300
Message-ID: <20250904143224.657971-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904143224.657971-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904143224.657971-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f464653-3f54-422c-9a80-08ddebbfe2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GxaWeYRmtHTI/CKkf8sunCn/oMYiNVlWzzfxxAmsHw+0P2Ee4ccRL5Jaym/Q?=
 =?us-ascii?Q?vfHxo2yLgbGiGuPd0unBzR2EKJfLL4N6/dDpJr0hS4n7pIo8ol1Rj5pFPhc5?=
 =?us-ascii?Q?ab3Jrt8ZG16RHzo5lyztMVqKeL4XCDU0J+9RF0056h8TtF/HYmpKuK5Rr8v1?=
 =?us-ascii?Q?Yyc9Dv9Jg8sF0B10wuyk4KSAbG6rO33cJ6+IENh18A3X+nmd9OkYodm2+3o8?=
 =?us-ascii?Q?HNGgQUjk/CvF5KtygD7nwoclQK6ePC4rMGTddeCrT8VnRksJZ3kUyuobVMTz?=
 =?us-ascii?Q?q1LvXGE1uDpv7pyZ4Z7Om11br2xC+M306dmDS8BbL4eldLbfFOTlqadCxbIb?=
 =?us-ascii?Q?tIHgkBIVZ0K6SnJy1doz3iQBW/prQ4KWU0N09vwXS2o3niDO8D5LKI9KvuTI?=
 =?us-ascii?Q?2Q9IVVKPB2M8qli3homTCN1Sv778kCNtbzRFTFQhJrMxljNKrHPDqTw/bFuF?=
 =?us-ascii?Q?ziK8W2BzI20e2oQ3a9YJZY0tSZQx+0l1SUnzV3qxAG+34sd+wNso4CHW5Wyt?=
 =?us-ascii?Q?+hFh9p7TBHPNl5GTOvCFeNsm4vJSkKJ2ODnOUqoJhL4cd0eZrZg3SGTUYOXv?=
 =?us-ascii?Q?FmGaEipfsRLgBvSzY0/HA/Qa5/m6eCfPwAL27njiT01oMP1PuDUsRpBpsG2s?=
 =?us-ascii?Q?FW3pqSZWjyO0At2p9Jn9YBj/nHM2din7Gh/euVF5jOx5HHodh/S1+NdlmHWh?=
 =?us-ascii?Q?oZoMwVcxtEWZQOFRN8unbFwnFgCqdOJa0Y6ecsTGTxLnv4zekWfaT0K0dK02?=
 =?us-ascii?Q?NYh6Ue7ta7rdIgSYNuFrMtXo8j/610YXgOHTGt/pf+C43q8eN6slhjo+w07d?=
 =?us-ascii?Q?3jhRWJEwfsI304ETMmVerPvThlQGyN52y85f1F2kVlZzTrE6ATW4W9KqNFtm?=
 =?us-ascii?Q?IhlYznyu2yx7B8tUVI7RA4IZY7AjBBMTpGbEEV0a7tdAKY+TjAyaO8C3rj5c?=
 =?us-ascii?Q?5eVUxaLhFZfYhXukZdJwKKYz4D+qbnn54LRAkRxMVx6Uetj3vTomdD1REuAL?=
 =?us-ascii?Q?fIrk764DFqutvoukoPJFGOHLM7jpsZUMCfm4QPdeCxd7ToYFxTlVMEUn7rxC?=
 =?us-ascii?Q?bIoA4DLTCR3PmhdZ/ebd6S+ojnbaoKlZDa2nwUaZP4lwlQhxZeypPjyd57gF?=
 =?us-ascii?Q?22s20dMNcwRk2Xogwg65P0PlQC4Jxk/I1r+ueWRsGV0p4IoUlhotaumBbs7t?=
 =?us-ascii?Q?zfjnu4uc/mZqnz9+7/5UAePgpDF0TEwtJc+0yeMXwfGwNQDWT76oV7KvJ78c?=
 =?us-ascii?Q?vYmeZcJB7J8I75dvCL1My6JYvMDxyEDdExqIBwFtdyYkf+KT8xYCLXuWNb5y?=
 =?us-ascii?Q?zZ0n1Xnm3fcFC0mZGiUZtkGwM8d6fTCQu2gmCUbCak+L+B+uiLTY09yLBtcO?=
 =?us-ascii?Q?9LUP9QbnAh73riDpU647QrhER5YdLPzq47GxacxwQAFTvFIkteaa5TkG6VBk?=
 =?us-ascii?Q?K9eS9fDd3O206zu5UZdBJZmKqscTBnRFvR8WP7CBTHCegjzmLl4mWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FoOAQuS9+eMpQo0u2rAD7Tt3cLnsc+Ge7Cc+2cCtDu4us+NjFLSsb6ZGbVV0?=
 =?us-ascii?Q?tvPS7jo9OlNC8Ny17pGGTP9UxYuOZZ9b0wEMz82AYNfAX+JFGLPmp7XTReZr?=
 =?us-ascii?Q?e/+DKA1BtV1gWDe6HYAE/qtS0OQS5F+8LUaVu3yVeBPJF1JhKkGjusHzIXv1?=
 =?us-ascii?Q?ufR59RmwcXRS8KcdoMxa4Op248Noj9H4JsCSkvOv+yGrxjIpS9QeH7v8yj5n?=
 =?us-ascii?Q?txxFQBV8AzQmTqT5OTJgpAS9vAX+Smn0Ssohi4Kve0k92QOn8fwehD0BYygu?=
 =?us-ascii?Q?DMWcUqjHY9hfkt8DqJDQsVEbZ1w9CpHTPOpvtlJjLqSug33vN1PwySUqcSVo?=
 =?us-ascii?Q?Dzq82dwZZf9LBvxGFad+oOU6UQzQ5uMq5ATxzKZNIRIoCbJKFqdE2qbO5itT?=
 =?us-ascii?Q?JRY2LgrHwB1bHDuxeRT0GFmWUpw9kzlp4L/roa5263x2qoEcc27lm+YFckpR?=
 =?us-ascii?Q?wbts2zsCJSBlovYUD/9unz94bkBGFTFeOnKfISRqjo9bAYF885DRT6qO+avz?=
 =?us-ascii?Q?VqHkd6ikE4TnQtpKpoo7YRF0mA9mCvCXH2dnfzjGZTLVL08QVxgS4iw/rOv0?=
 =?us-ascii?Q?Xv5L32ASW+MN+2KyhwGLu2Meo1Mtsa32pUQSR3/RoWuRs2+CI+rkKIueDDer?=
 =?us-ascii?Q?MbBYpZaz3z+q5bo6dJWKqOvsYVnVYUBbBxTqyLfzYkcgv5+jtGgkcR5Icem3?=
 =?us-ascii?Q?zYVGSkt0PpuYFYQ/KaL+pNyiz90DuWf8SAogMlPUgmwJ1Jb0Za2rmjOPOFQk?=
 =?us-ascii?Q?/XgV7ltnoxIX7Pou3OpmotKqYd+brTcU3iPApupG/gMSIwHxEZU4Da+D+Kq5?=
 =?us-ascii?Q?9u/+cElzTkjJNcnXfhOrA2NYxLDeYiUnm3O5lRnLmctx7evKzJ3o6fq5lv2s?=
 =?us-ascii?Q?VbuW2I488N1cWgwhW+Ya7Cg6E1INNv7e+p9oVxH8wOA8B7NHzSMbELRWG3dR?=
 =?us-ascii?Q?5A8a16WEWv3TgzQ13GcBlAKr0TwV0N9X/M2DNYjv/PUmavvUpKBH0nSlJIfv?=
 =?us-ascii?Q?LipyLeqHhBAclYEHCv/ttp5Mk+u7qYb98tAyQHLu0367ttM08o8ljFdiONnm?=
 =?us-ascii?Q?ytcbF+boYg+oFptU2zvqdJBL+TjPseyMwO9W+k8zhyNbKuDIb24bzKmd6ytX?=
 =?us-ascii?Q?DhsWHVX8T0aZ3bXRjxucKC+QLfmFYzdyzj38LyW4G+2NdlWUNNUuS+pTFzZr?=
 =?us-ascii?Q?32wsQfPSshwHedVPCzHuc0WjJsPPhDwu1vM+EX05lIA7lOB9DRXsSrcnWyup?=
 =?us-ascii?Q?/70Qj4A5ybgoI0lLTo3B3+r9nD+wL/Jq86yo9FQ7TyW6X3OruLBkkZ8CS5Aq?=
 =?us-ascii?Q?UWbQdFqzk5QpQwuNZNjFZY7hIlIIs4FyQHe3YKDVoyz3RnCKceV2g2fIL3lK?=
 =?us-ascii?Q?5pWqeg7HYIGK96HYJnQDHs1t6lJOuLGHBT/eIc/Ua5Br9WMsKxAHBsatjni2?=
 =?us-ascii?Q?mS93Qr26A9Q6lOo0egM79pX5g/W9hi7/+eZ++YrXK0WSciJ17IbTQYzTxtqb?=
 =?us-ascii?Q?2fcoxTOHxCRF0IzrmHzwn6p/DRb/6HFQxKUZ7skk99x15OZGoHWF89tIuD8/?=
 =?us-ascii?Q?10LdjPIayg3YYCJxo46ftBM5b1leaKcPMPIFOcAFWefKIkVV4wNDROvXNavO?=
 =?us-ascii?Q?9nLrqB63Yil1IjavYiaQD+k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f464653-3f54-422c-9a80-08ddebbfe2bb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:32:33.3761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tWektIPwhA3p6zEx7sAeMSc4a4969rrF214ZC+L5tgQmuh32j4VVDpa5Zu046GHANELf/JBsqk+O2CsV0pXOsldRmh//N8J186UKxY/pmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9231
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

The patch adds benchmark option to the help of mtd command. For the
'mtd write' case the help line exceed 80 characters. Ignore this issue
as modern terminals are capable to handle more characters.

The patch also formats other command to make sure all device names
starts on the same collumn.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 57f6c700f1d..f053dbadd78 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -782,18 +782,18 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
-	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
-	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
-	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
-	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
+	"mtd read[.raw][.oob][.benchmark]                <name> <addr> [<off> [<size>]]\n"
+	"mtd dump[.raw][.oob]                            <name>        [<off> [<size>]]\n"
+	"mtd write[.raw][.oob][.dontskipff][.benchmark]  <name> <addr> [<off> [<size>]]\n"
+	"mtd erase[.dontskipbad]                         <name>        [<off> [<size>]]\n"
 	"\n"
 	"Specific functions:\n"
-	"mtd bad                               <name>\n"
+	"mtd bad                                         <name>\n"
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
-	"mtd otpread                           <name> [u|f] <off> <size>\n"
-	"mtd otpwrite                          <name> <off> <hex string>\n"
-	"mtd otplock                           <name> <off> <size>\n"
-	"mtd otpinfo                           <name> [u|f]\n"
+	"mtd otpread                                     <name> [u|f] <off> <size>\n"
+	"mtd otpwrite                                    <name> <off> <hex string>\n"
+	"mtd otplock                                     <name> <off> <size>\n"
+	"mtd otpinfo                                     <name> [u|f]\n"
 #endif
 	"\n"
 	"With:\n"
-- 
2.50.1

