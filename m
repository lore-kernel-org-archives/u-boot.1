Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A4CF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E8C88C10;
	Wed, 25 Sep 2024 03:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zurDolQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C9D88AD7; Wed, 25 Sep 2024 03:41:19 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB9B88B13
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1PdfuNjRrknBAHOmVyOa6YZ3l52CSGfXhtemczoUJpG7fe2xWaLfJaoy4WaU6rd63f9vzKqm0Eav1S4K9Mogc2yrsi5rDwQx9I2U8krr7ov2FUOQ1AFvJ8mDYxu1ZFJOFWwSbotJKriWoVj00zfYkgl8o2ANzD8JRZIiMwwNg4xnOzaJ1uVNoRMoCMU/MAZ5xLV/+O7HWiYVjqlxsXGRyUZ6u+QLO9nNdL/io4oy2GqqEsECKiObmy0L0wAp4cybjRyo5ZAYiGxHr5JFgkD4EYX+zjrK5CKVlfEbgEup/Hjo5/Xwcg9pQ9bQaJWaaeux/LgO0ymK1gM54r9FU5iLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=hR2VvHJ9UEzKY/kMglGA9tOf/eUFzvVXMNE7ONqiTdTZrkJiSBMRYfiv7ac6xvpEiywtg5SlJvof3lHl5XohjLkbUdtCFlFTIZqXBMcvFXK7cpnYw7bWsUrncYm3rVweQ0sn7qhiFyIAORIQ7XSKW/PLZCps9Oxc714G3GTgQ6WeAhR89uhbsSsfXhH/fAxETWybloprbPfcxwkn2X/ZWmDApR38j59/5aP85BK3lP4GvF7Lb8wMxJY3+r1RY3DQmk6PUyYkvVWT56MIY2cCMwP5R9Nw8e0LC7Zdmg0J8G343zQAMpjMq8VbuesOaKu5MH2zqeFO1L1w7GFuOMlgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=zurDolQi21iyAtDKKHcc/1ImUTAZJUppNfR742xKCcCEL3VASxlDshc5ln8dsTK57AJGudsVhCyYd7SPSMqkkHxKRn6vyyCFXTgJJsgBfrzOEj/jJQYVXJyuzj11d/Q+fNOs1yKd+LiWDiyxtsIgm8KC0BGM8ujoS0LBMjY7hRMUOHOSyoA4MYLV/J91GKjLZl3unGGBEOS4bjk8zL3y84rmOKe4Hqu4RIN9jPdJOZF4kYjVqsO970nkC1JHGA7oFS7lPR70wBeVwq6kdHZ5iGG/ibrLs70EeRer8Fj5f6Ulj1HwZsYxc5Fvx1MRiLFOGs876X44HV1w7y7WuHPWsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 01/13] net/tcp: fix TCP options processing
Date: Wed, 25 Sep 2024 04:40:46 +0300
Message-ID: <20240925014058.1679074-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: aef55939-d877-4fb5-1d77-08dcdd032102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aflcV7fIcFRwKtA416SQJQ/xwWh93WhcF3cVGqI26Ct/daZECrk3+rzN/dvb?=
 =?us-ascii?Q?JuVP2skKoTNpO6OSM26tmy7LaRTR2kDGT2VqqPG41RLeMcAJlmVuAKw1grYS?=
 =?us-ascii?Q?k6tlqJwX3fexmn3zz/GcuCLlGgoHKORYHkvQU5i8NElNIgYfxVAhkcIE8jlj?=
 =?us-ascii?Q?Sj6PF7iOZ8l3zlUPISGqOpYhWh9Mnk6eG86RvxTWtqh/mjIR/0nEG4TncDDa?=
 =?us-ascii?Q?499nsypWmif/T6hfdpcl7g+Fux2L9TzfLkeyf1ku2rw0ZDVHoD2C4moGysY7?=
 =?us-ascii?Q?trRqpoCbgAZNMZt+GBPHfOFFG0ml7+zEk8YOyV33MGD+tqsxRu9MISI4U4oh?=
 =?us-ascii?Q?eyakb2u2XvD+PGdZn8hVpHuLdKlVvnj+Y8GWGXPt7THzHPNXI+06QNAFqhDV?=
 =?us-ascii?Q?DmtaaDpTYGa+3Z4hRpiSF96tvT0DozNeHyUQpdGP9lLvEoJYneRqOQq0mtuh?=
 =?us-ascii?Q?XRbXolgqDJmGLJLn6D62XzJV4PG91QN0UC+PAI9+yvt22MGNciWkpv5a9Vkf?=
 =?us-ascii?Q?Ha0yGEaJxk4EJ2qT4t6MJjP9TaZ08J3MmWE0JbjkHt0Z+1YJ+u0bO2B9Dml1?=
 =?us-ascii?Q?s/KMiGA3dtlu77ytwbQqCT32ALUSIYZpoBHv+xbNrIjpf1beT/kvOa7LGKAR?=
 =?us-ascii?Q?V4TGOpPus4N8D2QziwgGP1izMYef7KU1g+r/5bVa2dwi83JrBsUPX7JKV3nn?=
 =?us-ascii?Q?Gi7txQb/vvhOOIghhVqGAA2oPacU9A0boCO8DAiwS9wmVTu6jJfNX99zTCcC?=
 =?us-ascii?Q?f3eovzJw9WkR8YTVs9LuMEpU31K4zVUQ48rwbeACIW13M9Lnk4VMP72Bv+tY?=
 =?us-ascii?Q?BfWuZH/dmrtgzYynv5wRAF0uzBXt56yrL+eyejK6BD6vvIZfloUWAQAvfd0q?=
 =?us-ascii?Q?mWBg/L0evxJWmOltNU6q7+NOxaSUNLoaFEy57jmzIo1w+YwFWzv6DCnmvKzH?=
 =?us-ascii?Q?laHYBTRQPNhb0hKhfrGWvircig3T3XpAzcOKjmP9CXqVMCYfW4tqfogRXxIf?=
 =?us-ascii?Q?Ueio8IVHdrn6WUougt8aptqnqfJX9l9cqcmIe1LX/vt5v93abf2dTdKtzR1K?=
 =?us-ascii?Q?IAcCZmbEcnK749EMPJpnaru3+ozendG854DX+vQTiaJuQmUlZ743hG5f7m1Q?=
 =?us-ascii?Q?3M+DCiQ5okZocEHNTqjB+TuDOArlFLmmVp1f+yeJMirvGWyWHtZVc3TMy2nL?=
 =?us-ascii?Q?PQzuHf3pXD5ovf4kYbGrQIlJ1Mw6HiQtLTRIi7+J7HC9QVq+pJ5WHtxfP+Lw?=
 =?us-ascii?Q?6413zl5rW0H8hhx/F8+ZDf0HUA6UZmU2432HxQcv3L9e+lRHfhJAOSSHxu3/?=
 =?us-ascii?Q?Y5AUgDp36Iz+3XM4HLo7K3hf3reaNeabh+1EOfCIn+0N1n0N+57NKXdhHTMG?=
 =?us-ascii?Q?Zf27OjWI6xq1YgfIK6+7YyJcOeo9+6Zzv4A0v100A1QjA8FKsCaFdWhJnwSg?=
 =?us-ascii?Q?/R5UJTx/ccE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pow0SrNa9MYW88Fg3FTa7xKFrckfGfg0GefsduKBMFa69vmJJ6oMWzp2BRvd?=
 =?us-ascii?Q?9dRetYLHBBzwPGXcAwcws5EDyyjfH+lcwUlnLQXzqfM00eyO6SHVAxpuiupb?=
 =?us-ascii?Q?2SfSHUIBGt1zX/A8hYxhJBIbP7InwEnpCRYunS20PZuKfZNJypFWydbGUeTg?=
 =?us-ascii?Q?MsdHVy0w6hWVMpCKw7iL1JWUVxBBAOrhQMWuMQpJGfi/Ci1wiJ0jq10ls8/K?=
 =?us-ascii?Q?xQ0ofq6hA9lyp4sQi0lG7S0rfYnE772EdG/986vnnGMtk/5jJ1YnosxyUOcH?=
 =?us-ascii?Q?E75QZ10qUH6zoAQ8/kL4EX037C6ZZgy2GqstxqT4y3Wu7x198Pyjrz4M5ux/?=
 =?us-ascii?Q?MAyShyOVM60EdTcSRMcpXq9OBiC+mLnkTruGcZBiOPls+YnM12tMUpuOX7gb?=
 =?us-ascii?Q?v1/h0TI+exXuR4BMLDxPZSk2ERuL+EEe/GHGAuphJJb18JUDr9DQx769U9PC?=
 =?us-ascii?Q?Kw1jf6R9mUxMe4WNATDmpy8KjhvAFkTSX2D01A103mO5huJMk2YzE0Sz84h/?=
 =?us-ascii?Q?sCgJQtHOwTfRyTiuiiBxP47ECMPijE4ugsWWQdnja0rDPHoa05XJBpyZeHkR?=
 =?us-ascii?Q?MLaL+cV11784DmAYgFD2yeqbLa9LTTVxat5yFYWvc5sY2HOA0hU+oCgxPKMf?=
 =?us-ascii?Q?8kjOoGRyL2qhJWnFjt3RxLMFJgJS5teQ1y1/RU1dQe2lO/qIToeYzQG4CW3N?=
 =?us-ascii?Q?dExCiNdpIcYrIBQtTey2fW1PGs24/+KW1FqZy1v/wxtgfd5fDS6aNkKAMHNG?=
 =?us-ascii?Q?aRMWLzlivpWXtuoTvnunoWPN5V/UDP7tvbQE5SW5iypm8Xt6FOKPzv0aqMmY?=
 =?us-ascii?Q?ePerzmV976cx7+1LRAoi6G5wO1W5gyyiZRGQRFIFLGV8GjZfDWvxSNpN9HOY?=
 =?us-ascii?Q?p5nKcBk3xJpZN7xMDJwD1UwEiAMaLu5vO2x0GdNzXmdkG4+DVKaTbx7LZzs8?=
 =?us-ascii?Q?toFFW9eC1qLVUselH4B1OhPDp8hufIgXc3CR0zPteta15K6GXGMzYXScJwzj?=
 =?us-ascii?Q?R/0VSN7qCX9J/TQoODWnTY2cvaSQFYfezeyCuJfomCq9AmaNo5yovZufTXN+?=
 =?us-ascii?Q?G3WUpsiHy3guERHqbQ+IaWP/bmW4n8P8KHn4MlfivIY8RspIKBWN9LbPfUtK?=
 =?us-ascii?Q?trCPsSx/IEJzOvk55UgXV32qaqETH1xg9ee89Yqdq8q0rSrwS+KrnuKzbE4q?=
 =?us-ascii?Q?t0Q5uicMewLDJNAtfFSaL8TFIE0XtBCjevyZw64t+Z4ROkuGGzlA27xR7EGC?=
 =?us-ascii?Q?3wXTmll54XSAxq3xhlLzsw5FR44rAVNKq7TJ0uJ+n5Xe1wEsC7nlyrGzWrcA?=
 =?us-ascii?Q?2xGwk6jc+f4dT7WQuvdYehomSyd8PN3Q2B66+170VeerryhdcKZBiX3uyp9F?=
 =?us-ascii?Q?SrkXUTDJqONCNrH5+tuWmFeZYLHvAGdEqRdUCx49bpSQnE3iiJhDag5UeNQB?=
 =?us-ascii?Q?TarNRKvqkiFaGqRQCK+eqW8cE6djXgIspEJhggHzy7Y12sxTjQuXgDL+3bcU?=
 =?us-ascii?Q?btWD1eW/1y7bmRtM7O+GMuP91y4Gk41P2h0NmMM2BAxH5kCSsnX5oFwalyCt?=
 =?us-ascii?Q?d6TX3Hyaek32gJAyEon4PWC83sqoDCou23NUdPFkbFddXMrSymwjfDBLfOoo?=
 =?us-ascii?Q?cSVVG7AZpZbt5DpZDD47e8c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: aef55939-d877-4fb5-1d77-08dcdd032102
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:08.9982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxxRkUGqbtoo6Uvy8Zv9HjP1nmAFz+CgQ+l6lwLl8oEW2DDwh3FmuTozKnJ7JUErW0nGy6G+xOYwMJsc/lIq78hdIskWXmHt2YyWwMtYJSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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

