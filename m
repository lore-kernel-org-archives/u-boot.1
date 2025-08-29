Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB311C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0455A835B2;
	Fri, 29 Aug 2025 09:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0r01lF8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1FE283487; Fri, 29 Aug 2025 09:55:47 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F70583542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhhTBCGdF8A3tkTrhhXpbN/vNq/XGROHXkgz7wCbvh7SV1WfFZ0djQZvXNZfZzSCfGt2grev645OX64X2UzZdApHpPmgDWyql1yG71+ZH1WRBLquiut+fiFDZtl7usox3PB7Sk0rxtpMjMvb7lsG1rw2GzdiX2uZfQVIwAaGemkHDb0GSMLlOY+vyUpDeTD+HFqLqcd9dvrcdI4uX38Vqy+gdEx09Yg+lS7vpM/riPQQkhusuz1LIvHhJ7NodLwsWjMhnX5ah+z5NCES4/B0QqlRk/0gYKe5QgAdSAvBZxkdnMl1vLyBfjoGErom3jmJG1Jos3AoJ6LnHhjg04PvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeolcsmTOsZ1cxagsgLFq/4zhJZStPv+4a4IlmYlEOI=;
 b=MB7vMIgtcixpnUXt6bjlr3ZqISv+NkrtW3qEq/BBo9KS8LYHXVmK2LarMjw2jgMXVmj0RLWE/yfLLxhxyOCZmHKxXu1CwPwpN3NdyS8rwJuAprlz3NHE+dKT+368fiAOhqHkBlB6mWlTWWzXkhaDWCW9rkiOsdgeZiMpIEr4CqYebnYM7Z14+aSi4Qmrif6mxRs5/so6YRKBIqrfaD7mDmAuQlTewMu3XM+j4cjAtsPn195jmtvJPAZp2PhdVCE74TmCpxPueRUw4MjK+N0dfYh3hcq3JwtRbUv8CAFIJZFZhsFmzDLoetxqryR1a9jdQR8UnKVdFDoDlEenC5Aykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeolcsmTOsZ1cxagsgLFq/4zhJZStPv+4a4IlmYlEOI=;
 b=0r01lF8U+KLJsj1i5+ptQXRDqeDcngip7t1Fk4WzcrccX8cDUcPQgGWKcvc64Wizi/FQF1ibyDYGhD+YFZUOk+VEHX36yWC7Ul0Rl/7M6cHvPSe31DXWa27zn+6g2EYkvePJdKH3fmwNIR99EWm3lqhLRYKipybQob7ID9JrIDAUgRlUZTLrhFvf6x+xvoUvcKSXne3jqnhekmVfzBaooSbHtsm/PR8gjz2juEmTKbOmCYjvZXlnCmMcEJV+qIZzCDG59vhdWI+pabxIh6Srg/CPoMeXuHbexggmWgdkXZn2FPIzEheIa3RUllwaLbHnVW1pCeqgHQHOlxJdniCtoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10425.eurprd08.prod.outlook.com (2603:10a6:800:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 07:55:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:55:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 1/2] Prepare v2025.10-rc3
Date: Fri, 29 Aug 2025 10:55:33 +0300
Message-ID: <20250829075534.2895148-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829075534.2895148-1-mikhail.kshevetskiy@iopsys.eu>
References: <87tt1r6api.fsf@bootlin.com>
 <20250829075534.2895148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AFB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: d161d627-d3a0-4549-6bda-08dde6d173b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ktMp1fMMAnaXbyKY13FrBcA6MOPFOAfS3kWMnS8jda5k2aRq1aYOPi1m2oWp?=
 =?us-ascii?Q?D4G8XlYWkXHkQ/MaCypwCNKIfhcC4GfeeFcnb2oaWBZlN2ou7+1ygieoBpRW?=
 =?us-ascii?Q?nIAhVRhja6ItXk++AqVeDpssvmbFBkeqZ+QnxM39PU22Pp6RAOLPA7M51Iku?=
 =?us-ascii?Q?v89DA2cgVFJhQ60QLx4Q/yQQ45hy0pq7CLQ3ephXtx5ZIU7jHUmq6UwzdJqY?=
 =?us-ascii?Q?4R/C9rhTxOyXBa26hDPZvDy/mibtniLKmBPG/h8XHZ86EfQ0V2Vrh0r4/qDP?=
 =?us-ascii?Q?KSH56UdHP4an8PLrql7FZMQ7XlHY+jBUErnqzIlI8MlT2KXrq0WbkmUTyHWa?=
 =?us-ascii?Q?mH1CdaFQSTtdNU1hFMlN7nx8QOa6veWS1sh6YecxFzQyLkQ+/dqxXCDegqXd?=
 =?us-ascii?Q?pSnPcKU4OwiKnpOmU7Wp6w63RunIvujJRNOf2GkCH2SELGuBFh9lEnS40xfl?=
 =?us-ascii?Q?pQgMNumT2z9bUKv1LNEwyl1qwT9SwMfG4HcMD+tfkdsbtd0npHIbyhvzdZKy?=
 =?us-ascii?Q?rI9sJEpwtmlMm2aqHLArqenrMv/p9AjBl9NuXnYRJizm4TpAH5MvlN4bAfeG?=
 =?us-ascii?Q?nglIX96s7OWmZY8oQQE8d0EScYbRk4COjeD38KIxJx3v0M4qXI9bm72JeR4r?=
 =?us-ascii?Q?atFp6GWcaK8LB/PqtLekhGyFTCTQuL+R9B0OBNrVfOPjnHWC2P9wdy6x8hgn?=
 =?us-ascii?Q?QGJLnV0fmlGaonZM4jIj4SKYUaG66Hnnic/5AaZcXtSbe4D9k2XkKv8+ANjW?=
 =?us-ascii?Q?CNxDKTqaVf8tiaVCm7NEco2NTCfKhAaK+HBZrSaHkFV3MVrCOir24/9nYpB+?=
 =?us-ascii?Q?1PlvNzx/YXQUvWeGbS9HJ6SGZgxnlELE9yKzW1kX2GCDh2q+pweeuhr3lR6l?=
 =?us-ascii?Q?v1EKsbi61YWJ1az7R9zruTqvakX8P4+wk1tAA/pCrpOD1f9lc9KUBPW3sqD1?=
 =?us-ascii?Q?DfxLvzqzqdzCofF1oJqjMoM86RENgSi1NzITHprRAk3wPmz2EOFBw3/BJ9h3?=
 =?us-ascii?Q?B1wWknj65uVigzeOTm9kkE3qaXNht+uKqdW3A8A2PnslQ0nnTnwn3PINq4Dc?=
 =?us-ascii?Q?5zM5nFu/SrlEgxqr1VxUnl8ZZLAvTJyWaHMoILFGzutRQy52KmQstktV3GdF?=
 =?us-ascii?Q?dsxQIWJKPyrZq/piPGm9gCw5q2dAlirYA0wUp8OH69RB6+z0xzGzUTXP8Uwb?=
 =?us-ascii?Q?AVbGBQyLJS3zWRNuowcJbfJu+/lrNXOW9yknvzOe09f283xq1Zo4eZ8DihST?=
 =?us-ascii?Q?3wiVIaosSBVhG0HBtkBb6kT85ZZZuiyK88paJeUnhxdCj0eKkXE+TWIy9DFC?=
 =?us-ascii?Q?0aZ+Ua37qqQsFOK2gx2CXgBB3Ht0DexX9KxbxqaEjPNtqjUxBGU6uZ9qmOs7?=
 =?us-ascii?Q?XjbhPd2+cj/WxZux9AV3SycLZyVx+dw8Se6769aDTacclc9FVkKShF9GqxYf?=
 =?us-ascii?Q?gZxcUj4kh4SEQdCQMR2rSFrLwr8ZZ90YjH7cV0yKIIOWcWbJSr866A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYmbI4d7l5VbMUbWuF/do+rQySMBAlmnuE1IJz4NPCqlGQgc0Spx0xW6LURm?=
 =?us-ascii?Q?OFkhZSYemRrziKw6EFbm7KfgF48/fmMGMFEEo9rmL3eAu7BaTXcrIptVGJ2+?=
 =?us-ascii?Q?VshRl4alg2tdmnAj+YmmgxY0tN/Pq7sZSWAbY61tNfzNoBTBX0BKKnPsrRvZ?=
 =?us-ascii?Q?5hmKl93E7DOWnIBlZCJgJi4ZKz24eb1bX3KYuRC28TovNcqxKKjJVVU5YTPn?=
 =?us-ascii?Q?sdVtHmWYNirWN0ams++evZjI86OXzT12QCYU0iic4DogTQszyCGvuK0FyOh7?=
 =?us-ascii?Q?dwXnAXyP9BtFMriofcszJ525wzsG9ZSHnRx7MfPzNQZ1N44dFwttiO9IFyLG?=
 =?us-ascii?Q?Tfx2hSSwBxv3rolc6FZ7baGoCe6ua79DzpeHkQfkW1mxJGQIO1O9+7YNzPyK?=
 =?us-ascii?Q?a9jW0m0SioLQlEPfdeaXrfX9XHHjee8cOxYpRf43rjfFs30Y8dVaxPEI3h0h?=
 =?us-ascii?Q?zoePXra8sQ2uk0oZTF19Xw5ps5+V+DyphmUWIWZdaviZyo2xPK94XRPbJOyD?=
 =?us-ascii?Q?YihheQSw7qfFSFn0Yk3ZJOYGVFp+JDGgNI2qnD1vchqtYpm+OJ666u/iTysO?=
 =?us-ascii?Q?a9WhlgQzPSiXecUDF2MOALrw5fkh9vYUb9lVgo5rbYEJMAWGGmuAY26WljN8?=
 =?us-ascii?Q?zbmnPc53sDHxeSCx2qZTOZzMd32/KXsGmbHu1JzT5L0EzIg4vir0t7+FLWTU?=
 =?us-ascii?Q?bkOVEMPl36J27LmFwpzjBTotsgYfqKqBKrgAL/5p/W0GmtmFhqxWeCeCXWeT?=
 =?us-ascii?Q?0NBxid5uBloOdiQp//pxkHtsGPJTQGdnSxdmUVz4KK4gNahxeJcQoHU0rE5I?=
 =?us-ascii?Q?s1iaIfn4qzCGbl4r4eLXX0yAGJJiX3xgBfPnDJDCU2+wbtlwPh5MESBsAChH?=
 =?us-ascii?Q?u3ysP3Avtrm9kaZocmVdgY9qgmd45ckifz14NwtxGWbHgWgjrMpLecR5Xhko?=
 =?us-ascii?Q?bWHqfikVvnD66UZZ/tKtgmYVsfbNVQVMov2zb2RnIeHLubZeA+ODlDBxSo8s?=
 =?us-ascii?Q?gLoUdjv+HxU1uBAe5E+8AQxiG6dFkJQAPs9ZLRNffT+sjRocSlsxkNdYUzZI?=
 =?us-ascii?Q?jqMBtTcP9cbMmfgao9LTyTVTPdMELTGeLzOXDB15RwXZYu/ew+YgA2y4Wk1J?=
 =?us-ascii?Q?5QODtFvBaMNEZhxK9qdGLVSpfXbn1l1IDuLRpmvUmAHnTJLXy7MhYNzl8Hoj?=
 =?us-ascii?Q?bsGK1+cdSC30SXjnl+hw8weHzOWykgvON3HMrZlyly86KfhRxhc74ev6gMj/?=
 =?us-ascii?Q?z3SWiJ3fhNPDjzYmXR2oYIyw0t8SCsKL2smZfglcCVkzZTxW111lNtq7ycZN?=
 =?us-ascii?Q?KWGwCYcx7hu0IzW+/vXOD3yGcozsNQUtYk2UG8Az8gaL+b/6BeDCOsF7mVlA?=
 =?us-ascii?Q?LxIHmLAOsPoTRY0paicBvsza3a53o6fnw3oA01xGwv3cj99fWVxvvG9rAZsZ?=
 =?us-ascii?Q?c3XlYbQ6Xxi1/+rkuAKPExxh3Dfk9ck9v8hdadEaQU9w0CDVLIjd9S5ktl6B?=
 =?us-ascii?Q?sGbKoW6gpuRAEcdmI+kGR95K73cbbp1FiC5YTyW8hbjRNmDQMxBRXnMHXwEQ?=
 =?us-ascii?Q?6WYVu0l63aXlAUfwPVLJk6Bm7Np6RGiIe3i5hbe+10De6bHUiMl23829YOfv?=
 =?us-ascii?Q?/QtvqxgEjw4q+0hZsYAwYio=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d161d627-d3a0-4549-6bda-08dde6d173b0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:55:42.1890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GvFbNS8t/LznwFat9c1fmupbtLnNiApq1JzZL6j22LUxIFXEA/MyqmxbrHYr7wqqqqMF/hQZ6cEZ8A8qCUdvb1DMdxsU1FTjWGVYZ+4nZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
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

From: Tom Rini <trini@konsulko.com>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile                      | 2 +-
 doc/develop/release_cycle.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 63e23886cde..b4f10c08d75 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,7 @@
 VERSION = 2025
 PATCHLEVEL = 10
 SUBLEVEL =
-EXTRAVERSION = -rc2
+EXTRAVERSION = -rc3
 NAME =
 
 # *DOCUMENTATION*
diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.rst
index 354ab1b5d74..ae6200a1880 100644
--- a/doc/develop/release_cycle.rst
+++ b/doc/develop/release_cycle.rst
@@ -75,7 +75,7 @@ For the next scheduled release, release candidates were made on::
 
 * U-Boot |next_ver|-rc2 was released on Mon 11 August 2025.
 
-.. * U-Boot |next_ver|-rc3 was released on Mon 25 August 2025.
+* U-Boot |next_ver|-rc3 was released on Mon 25 August 2025.
 
 .. * U-Boot |next_ver|-rc4 was released on Mon 08 September 2025.
 
-- 
2.50.1

