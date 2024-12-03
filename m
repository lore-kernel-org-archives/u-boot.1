Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A96E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B7689655;
	Wed,  4 Dec 2024 00:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2cuSykZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4130E8966B; Wed,  4 Dec 2024 00:01:03 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DBE8964A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPrSDcKHHfemOTMQ7T2CXdiBLMd8rz0yEPLUtzT1lA96nFPvsAK3UJZ/0xCTpkFWMaQkEhNGuqvdsesZEexqquguE0YV7wBf615fi3vEPc1gVWVN8mp1WgIh1Opc8eQ2Y+5ugLI5XJYBS499CYIzqYYfVK2REgyL22AQ40Tk2dXDeW3Ck3ymz0KThEGgk/H/t3pTL0aJP3IsoosuAM9aR6auiE/CcEit2I8EG2kEbLaW/1KC2BWW/u1HFZ3KBMuOVL7BqsNxbKBJpJzJRPpzW/bgyIp3LLow/BAg6U0FeK1pkIgXufqRBJ5Zv9/wV8YA4lWFS/blqndAGkfIn2fNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=hkqKQHsLVaL0rcCZ4ktajG8rLLhcXcAGgJoPtheqsppdBR6znK2Raa1+qZgX5cqyaXIG22JPTfFXMJi0BsQVysSkiOGJVpqD+Vx9OrSNneb+2lOyMAmwZtFbGlFUK01GrULqJIsC41lp33exk5Pd1EYjrs+7nqwDqCZxd/e2aYe7IGYR/4HBEefQadkfQjb04w/Fin7i8lRhKNOgzqdGB4pIhYE5yv/RmcoAsN1o7zkgxzX3vEZ6XR8rcYvmdNzdHgV08TiQ8ZcRCyhdfN+RgFq3k07FNzgDugAqJAArzKGPdsfd+DT+p744HJ+YLdxPCTMAVswvvplk3G7wiujV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=2cuSykZ6qGraFl5KSFekbPLTBZi8hvs3mX/O7ObjZQwLpjvI52OzNafrPfKf5NZGQo191JwHeLtS7UTbzB32ALFWPIqcGwAIbc/j5QOAdttUhtVw8knn+wNZD6a+Bpiz75rGwgHFP4OqovUlTNqUYWg0DWVhtJQG2lmqYCxJFQtJ6Sby8bdBltDMWgbrb+tl4Z0xO3LgGx3Bnt3UQ0jyn8OAJku1/F09TF8BgQtDbo9AHWt/f0G1xukN3VtK3PhQQDv32D1YtpXAgOJOCYrWacykQp9Dmbqkg6vJlZLYMbbiy+dbvpVlhV7CXUhd521cGRkvZtkeM9NvDyhlmJWMmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 23:00:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:00:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 01/10] net/tcp: fix TCP options processing
Date: Wed,  4 Dec 2024 02:00:40 +0300
Message-ID: <20241203230049.2677155-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241203230049.2677155-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fefdf4-c1f1-457f-bbd6-08dd13ee59f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9pMggsAfYkzb/pjz3P+wiKZdIbQx881hbwYb9ojDMGlbXijmYjx4g6DIuOtp?=
 =?us-ascii?Q?Bnhq9/Ru+Gq/qyXsRwMe+TQJm1KdlVMeEdqGaGG8V3ZRM+Uh6IvkcPtM9Wlg?=
 =?us-ascii?Q?QZozSdQZkzV3nFoIjgl/QhMEnPC6IY97fXR+2XFAbm3moUVX/7Tlc7PjubnC?=
 =?us-ascii?Q?D3aBST66U3994IhGnl8hq356SjSOAglsRO4UwiU1VeggTRjz/Qh5vPRPeIQw?=
 =?us-ascii?Q?YXKFYWfd02q1cs8uRiIoRdHyafdODhPfrP/IVwQxGcq0YeR4MA2zM7TZtrcq?=
 =?us-ascii?Q?jSPxZ8TOxzf4pfwk927NCkk2vde/fFtBNfSeYgBRy4RQHyuZQWOmxr/RAhC4?=
 =?us-ascii?Q?5oJrDwGUgspGHaUbfKZBT2t/fOevLMfJEHMFa5iEReHCvrDB3YhMapUKyaZf?=
 =?us-ascii?Q?P5FVRjBeifnzPzDcC8LPmylC3U78+AQasHYRTrACmHUt5an61Gln3V4AbnJr?=
 =?us-ascii?Q?R6wCWoZFzUVQbBjKTSIDRpgs9HooyE2/xL6R+jBHrGRAz+FMsYQk2keep9fd?=
 =?us-ascii?Q?VozXg2pqORafYGC06sUq+gjCj1BHn/+uY9vWUdkvoMzTrQx7gT6yMOzKREnS?=
 =?us-ascii?Q?bA8zM/FLtygvjuXTMU495yH5dPpRtKbqnZclPmqTmT0Rnh7gF/EJx/wtL4Z0?=
 =?us-ascii?Q?p3h4IqORjAzB60TLVRQx6QT1jPhLydGPHLgCF792zv1FMqWMA7lAtMvQfKKZ?=
 =?us-ascii?Q?gyf2ATFD1HRgFMVsxc8rXUADbGLBjYJYE7+To18k5BsO0JyRhg0BiA7HlL+o?=
 =?us-ascii?Q?P29AjNvSrTciHQgAw7KdzuU154QPFO2HexhNulJe5YBPa43G3ks+xVho9s1I?=
 =?us-ascii?Q?O/K9N7Ni+dwvVuvBMJ02DnwYRn8spHi1adrGTcK49n0UHuqmclu1x1IFoez2?=
 =?us-ascii?Q?vpwcWAPQ3ObwPzwpJsnTah1vuVRDJxWt7+u0oJOioUqlxc5LzFiq3Gbw3J53?=
 =?us-ascii?Q?SaOh/6SuK5e276N06IIsPgM6jtqG03tioa0sLO4uQwh8EKFuR+eX2mRLU6RA?=
 =?us-ascii?Q?PcK76PTMKUsiv1cD0IuZuSfQrvVaWMjFqURomoKF/+/fGRjG+hkPAx2EddAW?=
 =?us-ascii?Q?sRyrdcwKAMphHUbBIYgW1RbGwmEAatqk+8SrDrd0wZ0+o5VtwongbjHEaehe?=
 =?us-ascii?Q?WSD1vU/+bPdc/ZDR0FwNoqwxt/9V0q7xtC2g53Cur8wgf+dqGRCipZbjPoaK?=
 =?us-ascii?Q?QgZcz6z8OUQcgyGWXR0PGgA7Ghj+lyTkmA9n5XDGP3kT/8LowXJI12r9k0mC?=
 =?us-ascii?Q?fSRjSyQIbIjxrxk4XNM++HC0/ak+2tClPacOWnSGGxHiL288pKX1jJ/xyAct?=
 =?us-ascii?Q?AF+LpPmbFiSrx3EMZt3horh9pcfBx/WhcwT8QipZdGNN5Xuv6EAo8VTWfzD6?=
 =?us-ascii?Q?i599wsdEH8ocEVdiRj5Eci5gYvqEr0k2dNtUb0QEunmoLTzeOK0cgftPGEIW?=
 =?us-ascii?Q?ntn6forFc3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujjPmgqgmQPyib5kjyk2nRkOUsBwr98eORt/7Dhl0e7Ru1tkwsx8VPqX0UrP?=
 =?us-ascii?Q?ILx5CThPuUtsnEyRtKwIi50h9WuqdR51xFkQ5fHnkhUtFeRmsl6Sknjyi9m1?=
 =?us-ascii?Q?QCZiKaY97pQXXcGPRnVhTitcRquwo0TSvbc0ezofcxEwrE1wq34wJZJDqgID?=
 =?us-ascii?Q?F//3oxud3s1A5n2C8D1zFsW63JGFa4nbmo1ddjpk5XquX7xbQM4tsVIZfIEH?=
 =?us-ascii?Q?Sauu/KaYSxoL0IxT7iNs5y0mBMt3k2Zd2BZWY6YqJXmSZAd7DLleUIYKzfFT?=
 =?us-ascii?Q?423vweakyZUaa0cDGKxjApqp/IWGxNnd6ATepPn8ixoGD2X6xAi2Sy47Bn6D?=
 =?us-ascii?Q?REkatPBMl0M7+s6UIDU0elHr3lkrFH2uZhhfDWBNW5zpW0Q9aqjAwTEYsO/S?=
 =?us-ascii?Q?ywbJtg9NjQ/mV5hCypbbCImzhiQsMF07rLiLYVan5UsX55HAEfvVtpkVSCZn?=
 =?us-ascii?Q?jSFjbVWvdosq7WTYpxWU7Vg+q5bd/z6cCPRgRcMn/Us+FsBck7iJRCjcP+RA?=
 =?us-ascii?Q?4Ii7RcUXi0yUKpxTo9dC781CatZO+Yp5DJ5UmyuCiOgdOR5qV9x25buW+PKg?=
 =?us-ascii?Q?XpUWRuH8NJF5RiLeUBaP+dp09bbwsbA/1DJTY6nwtYnX+sMvl1BBRq/3JCrI?=
 =?us-ascii?Q?IL0FlnkXHeQx68WBrdNs7L1FLaLF7FJOt37hpfYcrn6Ug/mkvLLW5vJxMe/f?=
 =?us-ascii?Q?DSMUT32Av+A9o54Yk2nMCGF7N7es88CJXxEJGgycd44exODbqiYcm7TUDxFh?=
 =?us-ascii?Q?kBFZg3wxo2xZknrfmmPzR1w+R5nBRTf2EFOSsPklHhGGTLFbxr96uzG+JxVt?=
 =?us-ascii?Q?tktor84iOOe2aYk+5/dDBCJ7NgJC6jpa1zqT7GMlM1p1hzLAA6w2xt093Rbz?=
 =?us-ascii?Q?InUCIDl/ReUPBBxUod9uKv8vv9wOKe2elFJhQYvBFDoBQUn6TWwzG/vyY70u?=
 =?us-ascii?Q?TYvb8KboSe2P+G2/i0TmwsO0+lle2QNFXv6gytBGek/MceJDzdBd+Gz702zn?=
 =?us-ascii?Q?OYGCeCGMBMVgaT8nE0k9mf3wDHlw8HTAXka+f3ut48d3ChcuPRZJzc8I0fcs?=
 =?us-ascii?Q?EISiOHJTmeZTV/FQXCb5qqXnpu8xsnzoNXD4rmJKEMgfdzgaF8F8xECOY91V?=
 =?us-ascii?Q?252PKj7poxi5VHJz0COmlDF9BuC96DVhbkNhSZ+ztp4VikPOcKNsiABMtPvW?=
 =?us-ascii?Q?zG9xHV5nuXwEcNppcFW/2OJdWoyFofkHpoLEVPW42yj7zzYsyTdctwK7tNLd?=
 =?us-ascii?Q?AvniuguAHVG95uuSBj66OczgGuzqDFaG+UtfoibF1PCkzdJzFSzN0/vl+Qhp?=
 =?us-ascii?Q?i8RXFAlMXGVBDY5sApCNkEt//Hywt0Mi53Ywz0pvl+8FrD24DXSBXaoNvK77?=
 =?us-ascii?Q?41HSNg779wCE0DzAOtnr0Utvtoc/x1pHl3wQjlO8IMA6+3524kYXxZKL+8m2?=
 =?us-ascii?Q?/hHmgb5I8C0WZYCbH64eb2HGphZ9f7U1wScbA5vEoANlOyBNvo3guWuJt28l?=
 =?us-ascii?Q?31oHrWv/ruUDrbt3HeWM+u61DKeD2kDmIgjfrEXVXmFZvwE63NW/Ud3Izi55?=
 =?us-ascii?Q?S/RElaYh3FPVF+Wh2rbP3HkAQWkzj60XWpaJ8lsShdfFYZwWNmXYPhwLOWLN?=
 =?us-ascii?Q?iItRoniOmoExNFsSQwUXjz4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fefdf4-c1f1-457f-bbd6-08dd13ee59f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:00:59.1070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxRU4qTzA+VvOM8QFlV17azV9lED+E08s0Ty/n2hXQieB0eimLZArhJcceBMlJSz/q1MnJioucTo9hB2MfpLha6F3gJZHXUzz6uC5p3UzSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7611
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

