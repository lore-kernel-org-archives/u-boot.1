Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FDBC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447748346B;
	Wed,  9 Jul 2025 11:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0DLa4XlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C998344C; Wed,  9 Jul 2025 11:28:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73158344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP38RQLX5CwLQNBMNDT1ON71hElTHfU7aAZKyCjuVcA3lW+Phef6RmsjRBDDHtRJfX8UuRcNrWiI3moK29nPJTJaIv2CN2U9p8dZmQnkpOxwNXtz9CLy9pmH87e0ZF/4QMeMqtm443D+7u8ClbO4+kaWTbYzTMtuXeN0whw1XWPX60qOL0LnRkEIDlL/dNoRIHcgRenLg1t+RZ3VRVOfcedb7kp1CLoLg7oov1a9XoO3ocMsVX5RBLnUBCW2YK8W1gtdI7tNMw4EB0NGMcsgleSzpe46q5Pqw8KvjZo93b2pELwN3E9wgf+Q72nJ0tHIKFnDbTxXGL2YrKTElMjMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=ba6HoOSJzGwipkeDDWBW3TV2TAvbP8UPa/VANkteKeWka6ESQ61XaLbM3jTkEnBjUQq61o3oD5frnG8vEG1Z4CDe+oXUQUreaJcRsddD3EEEmFuj21cZWOaUyAWWMJOePdiTBhvPy8viDjWQWyL6A0PTpYlIO/LOoZhHIdUJ8ifAl8qU9LuIMO/af32gldRqGzNgEbv8admpPKkPmJ3aFq10nF6lBnwR1GormmNOqQ/6sV7NvnF0B7s0yTykswenO4PCqLbyVU2vHzhbwz2amo55BoeJmD/n0UVyef6v92dhsQ4QvOTzf/ql15ZeqGKPuH+IGWRvi9+e5KRUlfaRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=0DLa4XlLW0iWsnu6NZbvKWQ2Cja0Lcp0/I49Mj6o8+eCI/bZRdtdHy5bro3JaI9X7zjJK50n3/fLszFrBdfTYuq9LkgayFAImqyrdffAYtn6LnL3tTNm2tT6bCun5RmWd4KYux9xs7q6kzsvsg87sdtBUucrXSKv6E7liycp8ByIuxAx06um4xAjYTWfbZHcNMM51NlkMcLWueIyPJnMVy7pcn1tBIrkXIAfVDGuNqMbJN+mVFxK/iNjPHkGVvUFUUR4rQsmv/dG6/kq/4sHJPOP5xSeL16bZP7X1I3JpeWbeWoy530am4q9wHJzzZBdRey9b5AyclT1B+7KC2iULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10805.eurprd08.prod.outlook.com (2603:10a6:150:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:28:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 09:28:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v4 1/4] drivers/net/airoha_eth: add missing terminator
 for compatible devices list
Date: Wed,  9 Jul 2025 12:28:07 +0300
Message-ID: <20250709092810.4032971-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250709092810.4032971-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: da9596bf-b7f9-4e04-897e-08ddbecaf1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITM/j0FrTJlQ0ufg+u4jmOS3jSbMgBfpree1KgDJvFXEAdp0JnooexOj07Jx?=
 =?us-ascii?Q?DIgQKbl0yOPrKEGMPz1J0QpYNk9mYQKRrCCaNc87V85bGyQIbGNFooeKm5CR?=
 =?us-ascii?Q?3nhAIaBWftRfoperongWT7ahEladrTwNXPIZ+cR7PU3teLSp0Yg0JcCu6o35?=
 =?us-ascii?Q?384xOYl4nJ3biLJXMckjcwyRoF2SOOIo0vg8/Piu9F4pl3OatwPi6wk5k7sw?=
 =?us-ascii?Q?JGMXYFULdKimCuhf/JYTsFXqQ5usdLCshVoaKfxiBorYAGJi9e+FQ3GsPFYV?=
 =?us-ascii?Q?c0lvQvr04iPQyDZES6HVdL/sIxKpWxxPyDjZpaUYiQucqS+qYGbSKR05HRKL?=
 =?us-ascii?Q?332mpRmwr85HM3MJp9LjoEOtheyW3qkBYS3EvElh0sChZVsn920Ot0u8x6CN?=
 =?us-ascii?Q?ae5AlUASFNJOUTO0oADnqxnFuFUO0une5tsbVCo0yAZ8zLzROcsOVbvcS+e4?=
 =?us-ascii?Q?NryNqqLqtr8R8xUN2MBG+SRb0CfaWazC9DiRmvByEsEahtA7u6IeTwa0Jnmr?=
 =?us-ascii?Q?MmVlFgUzNpuq9TT/6cq470rlFsiKLu5pdHpZ0u8CDj6b8DxNb+wQE2P99i5v?=
 =?us-ascii?Q?o9wA0yDbXI4c1VgoXn6eXwy+Z6tTem3xNwUcGkXi+VDpFDi6sj9IQLhX/6S2?=
 =?us-ascii?Q?HN29EvNuzLc4/B7w7TgTL3mlPqUCYni79/3DPebyQO0vzIm0Af0L0/geLW8b?=
 =?us-ascii?Q?VDtGZBeeZhvxgA7G0xT9zXX67FoTb/9KVzchQqEDocvR9f7PoF6YbWgyBdqn?=
 =?us-ascii?Q?0mae9tmGmQpjLt6FZiAJQE6rMv+6+3uHeBsdLxNFYvLqzAs22goq2Rh20Zmd?=
 =?us-ascii?Q?bGUp9I2aqYoMQ4z58Lcsba3j45L2WbQRZ/j+rnogHMqtwQBOs1n/qT9GFmNj?=
 =?us-ascii?Q?QNF5fILOgzOYhwbaYolj3yMWUaFIyrIrP5q/G+tAmna+RwkiQCFEuwkkG3M2?=
 =?us-ascii?Q?QE7R59gXlYfxGeXEtvDE/BdkD4pibS+MLMRYQxWRtydvlXTKE3EX+rw7ZRP8?=
 =?us-ascii?Q?0CFTU8UKrEs7M+yEypS7opd/0ytEptAyNNy9beu71ZV1zlILyPi9W868ICxe?=
 =?us-ascii?Q?sJGDj3DhUyFD55gKKxmrVXQhXoKyhw8WBnq43nFYwOtoyXgGHxyK8tVcAY7B?=
 =?us-ascii?Q?ltUOPaFGRxIBYb/2cN66h1myrwp18tCTPSMzTuP43eXgSmR8W7X3pGHkX2nM?=
 =?us-ascii?Q?/RCgawovFyBSodw+2ahcmCLt+cz1W069gZE92uYm74N0c5wiSQ1DV2+rlFJf?=
 =?us-ascii?Q?hg6Nv4YYgQqVvYo+jkI+YRFnSGSwCMSzsJM3xTg9XOHcofO4QL2g8b9HuKwq?=
 =?us-ascii?Q?lXKuUIqZ7M86aBwhcT+yDY9gTKHsd6yki3xtkXFKnbF2GZdYYBXZQthWE9OI?=
 =?us-ascii?Q?xbNJ2gZ/dGNgCHxXKlKjGiTCdKH1xYLyqBsGX8YFcL9yLuKkQvYHO5iLl7uC?=
 =?us-ascii?Q?uDv6KgW14MEFxtS7UQJM60yFiWS2BdeFfBsM0DIq08pz4ZOTaYyenA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/toSM0hvMc3Us9LVDezjb+GZJ5C33zZjtYjPYXHKvadyjmUs/BIhzY6IWFE3?=
 =?us-ascii?Q?koE90JO8HRdfDD8jrgksk/qeDSPd4M0PL7nJnEfHtAlM7G3pllLZgtOFoi57?=
 =?us-ascii?Q?Uwp3FteeK9nPQB1xuBERv0R0fg/crjOxHSgHrYzgIsOeaBGxUOij2LfM/mh0?=
 =?us-ascii?Q?b9ixpuYOzh4a2Jvcd8lA3plioxXRLvOjymN9m/B0LUDG/GFKrBlBV9uoXF0P?=
 =?us-ascii?Q?ipfrqFTXHiPsVw31HOx6Y8BdWJ2COBrQjkDPiN2kId4Bg65323HizYiewbPL?=
 =?us-ascii?Q?M0JqoqtaHhNY/mQJrrRbC8GCRtA60ZJh2I5f906zhuH3Wj5TeBE65vaH4QPt?=
 =?us-ascii?Q?9727ObSxr2Vv1zFb82mHPKrH/2Bz2v1kw8pz0ZcGer5ktm+Ml0RDTulibtD6?=
 =?us-ascii?Q?NAlmAQH2/NY+u4IJaTTDUp9qYlAhAB9mHamStDT1RBLFaxnuI3KsprYipRvn?=
 =?us-ascii?Q?3684y2mLgwRQ35JNpgHm5LGX8EAf557EXH4TLgmoYbfI9r7eikFOxlOeoqrb?=
 =?us-ascii?Q?NYq8xf9lWaz7HL0zKZE9mN5A/2Mr2rA8EuAu2v2zOyf7wVNoZXA4vZ+bvSDs?=
 =?us-ascii?Q?BMllLzcTdqtFWR5tT0qqEHTBeGwPjzxAZlpQ32iKUwA787VADOiOB92OzuHK?=
 =?us-ascii?Q?UZ0HDqSct98E39/iOJtar3KSlOuQi984ybhgZHT1zePIR2sOpZnNxnRrKEwB?=
 =?us-ascii?Q?mzsQjLNB42ecJCS+5zbyxR6kyJglVAeI2EC+e3Ci283MUcO8AensSasp2m7h?=
 =?us-ascii?Q?xQmllYIAJHJlR7JrYfslP/wyHbbx3uQ+649ek0+AgPT6pRsZlTA55jOwXrEw?=
 =?us-ascii?Q?CkbITFv9trP1HEqJZbPmZR56N5IaGeZ385WUexvqJqY4cUuKqOz7mG1RVtvQ?=
 =?us-ascii?Q?vP3aGuGufaeIhG07DW+5LeCH1trl+lfisbfk/9dsG4VpmXo8DUeUxedqLy87?=
 =?us-ascii?Q?UzxDJO7Kf+kqOXKeVJYW4Kg78xZttwwxIWjO3eePbB9Mo0XAdwkEy/kdKwI+?=
 =?us-ascii?Q?FoVEK0f4FbAsrzW7qJ86Zs9YFdYoxOnnnNB2r4rP7cAbeXp4TLY4EOV4ZgeW?=
 =?us-ascii?Q?SQ9nVKUBcgCjDZ+AV3deTpvr3TDZDdYYoMu2oNIpplhpLasLe+K7V6A1qPBz?=
 =?us-ascii?Q?lw8eX8ATttFpitRHdaYHA5z5HTg3tRfcZrOwri5ID3thRzVpQc2TgG8UpEcZ?=
 =?us-ascii?Q?357UU3TfS4qXqfGEN7PZcrGsw8MMIVRxll175bLtnNiJTVXBv2YsAEeyW6l3?=
 =?us-ascii?Q?E2QBV78LVh/5OzKXeIaOkjUZSF7evWBMsO84egpzePzPS6SwnD944x0MZDdq?=
 =?us-ascii?Q?VVnvlMqS9HcuJXoW+sWLaVUAt29fwxFhhQXv5mPhw+Adk16G1otkdsai5VEn?=
 =?us-ascii?Q?BhASKX264IpcKGWD2AMGCFrgjL2bMQqcEx8xsu6lhu8nPpFIk2Mzo0UQ8mXb?=
 =?us-ascii?Q?FJXpoHh5tT3ilRrfEL/0lJ1FJW50nGGhybDbUJ/4YJdIDt3KBS7NAv5LyLDO?=
 =?us-ascii?Q?Ec4lMJzZAY+i6vEQU4V2IXEZ5ly01pLlxxllAqbxV5K89HckJWVDv6k7WY1F?=
 =?us-ascii?Q?5/siv2I2gtAfxTirf0DegOD/v7WJVtyfUAco2w8gDPu5YZWNEFSyu1E+rkrm?=
 =?us-ascii?Q?KJ38bqWvtoaUXozFU0r1uv0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: da9596bf-b7f9-4e04-897e-08ddbecaf1c3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:28:20.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmPqPPB2gDKdbayMmgw9CX+uacLuvWVftW0703mCuveOmciTyMwaIpbZOPjfamhGtsXcrP5YCR0wM+h3MeK07orByJssIZE6vRFEat9kuBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10805
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

Compatible device list must have a terminator. If terminator is missed
the u-boot driver subsystem will access random data placed after the
list in the memory.

The issue can be observed with the "dm compat" command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7e35e1fd41d..2aa42b3d727 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -926,6 +926,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
+	{ }
 };
 
 static const struct eth_ops airoha_eth_ops = {
-- 
2.47.2

