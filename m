Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBD7ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCF783D5D;
	Wed, 11 Feb 2026 19:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uXN57Zfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BD783CBD; Wed, 11 Feb 2026 19:23:40 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 606FF83E85
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj9AGRs4e63AFblmut9JsQ2Y/QAg74gpnmWieWZQG3IzVMNkgrS6PqsLRqfHd5z8FSJ4+fVswWbIlCuui7DdXLp3+Crm0J1n788pYyqYjm1ghD+y7sXOkbd+ZA6Po/N58tVkoaj+q1QS+BySm9ofjaeCa16SlnM8zzOxOKQX+ODoet5HvvQN48EWco5xRpBHOyvJicVyFtcj1E5Js1WRSBNzyate9KjPf66oezUQH/X3H2rIsZzlzOVQAG1ixgyWmB+9iJ8sv2/qo9fk8RXYJu2xK34O3eBSxGW4QJ6xbASRz0qQdBNa0La5PS+edHfJbYmMU7q8yDNq0u606MSMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP5hFIJdztqe4dteaml2rhz0MQ9qVdie8uIftd1AI2w=;
 b=qdlZRpf30xyYcvGMrjNtyd9IH72eFf5rDGL1c4r5t4ENbCh8oLGpsfeLOJtABHWYC0KXLjrL70lu/d12Y4iNpNi0xCNdO4hpaUvF96j/QJpGGCYtkIkIgLZsbt9bs2jjMIqC2ZTTxLKaxc3or0y26jk6RbljQo3u//PHjzYe5DwyzBcQRpRurQu6bFLp4/Xci6/IU1Fw0xxegMk0+w43Wy1wWBGzTuV8m3Ge4j5fZ/6qVX8q8Ie1VZSoc8Rk6KSOjoNABiVkjiSKQSvcXAF9ytPzY17965rTMOqscWAFzA9ShKkeu9OhFctEUdUxOju2VT3dztaba6zOHHx7RSaHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP5hFIJdztqe4dteaml2rhz0MQ9qVdie8uIftd1AI2w=;
 b=uXN57Zfr0qiKoAJcZXYXBxnKQCBVenvDytFTlCdxoiuC50T61K3ehiX8xKLcAyCLYkwZDUymlxZGefKTBhDy8WkCkZnWBWBPQrmyy9ZK47QTyfEsgdJSu1xJCnYXiOHI27bVQzGT11f4YXi/8XekvOqJznku+aG1TMcVWYz/sYZDsxo2RK0EuSaumszgl1p0UkSbtKcEzVcOIYl0+qt7MwbWulcNVjmIKDD54/MhU9IMKsyZXFNDxa5B0q3ILK/FFhQn1b1GrjEL8GArJglu9jNkAnQ0pUYQC3ipSMalMYl9TPZvw6BR0xK+Des1xYy4URAYO/soAGHU0rY+wcwsLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB11040.eurprd08.prod.outlook.com (2603:10a6:102:46f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:37 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 14/16] net: airoha: fill in support for PCS/PHY in Airoha
 Ethernet driver
Date: Wed, 11 Feb 2026 21:22:28 +0300
Message-ID: <20260211182230.968921-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4e581a-1167-41c9-9011-08de699aac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hK2Cl419PiNWmI/2OfeLgCOA4ARZHU/e2/oLEMCRmRZxE30V4hWZObHIs6Mv?=
 =?us-ascii?Q?JqYZupfTcFnkQpAZJk78zmO2fAmZcrasmLh/e1QsBu4FGPgZGVD6tvBsGr1T?=
 =?us-ascii?Q?MJoP2YAFoka4tVQFRoJAk0liqPbmVOE/ZMdvBf6TQC17asDK9DpL/EhnpJOZ?=
 =?us-ascii?Q?I+uuCbNRT9mrjnbEvFABa3dSu41dYxSYO2KnWNZWruZUQZKDhzXSuiYg0dUx?=
 =?us-ascii?Q?urHjeztdpJjB5q+NRXM2P0fxAqf8nKrAbrytdhllVNMKhUqQ5WmZQwWzPIi1?=
 =?us-ascii?Q?Pq391tkBKn+eue/Bh5GUc4FqjmX92Ulgm2ZY+QHpbD6DPxtg4aMvo80NDc+r?=
 =?us-ascii?Q?VRLvbR4RlKiH4qFdco98V5MUAFocNklvZO4UwKUqmPdpDJJtXvzR1rbSiGYO?=
 =?us-ascii?Q?ioVxhvdvWE5J6DLo196POIFCDAhi5G0ymxjk3ctz3/NbzvFA0gTY/pMiplk1?=
 =?us-ascii?Q?tYbfbl2aOUWJkpSjMZWJYMwceRkmZ7wjewOjOawszG0R3wC/jmdA2kmSOzf/?=
 =?us-ascii?Q?BQIcVzXX5Qz7HKI6J/mFsaqMWENVztRB61MVPJ5w+qxWLQFj641LlpGJKx1D?=
 =?us-ascii?Q?OBjoSf4mgsVN1y2zo008NcHgoEnmeTi/dwltSQOqMsYMqfW5GebHcVPEYyn+?=
 =?us-ascii?Q?S5BTmoQ4jtdnTQAM9zHrdIZNpJlN49sqTsn+LQtrBwFd/c8gdC7PoigOOnZg?=
 =?us-ascii?Q?XV01DwFDyldF9S35t021ugn3ClEVmkbRtwEhJ5fVcjByPY3XS/JfeE31cSmy?=
 =?us-ascii?Q?coinswG7DTlnvom0P4H+astQO7TQDkxt7ie+dzwkMf5UQpn7iCckWwh5WeVn?=
 =?us-ascii?Q?XEnK/JTz4kIesbv2Djs8ERd5UN5OTYiWlmR2T1wgDbdYCIO0s3pqh4e5zfxg?=
 =?us-ascii?Q?KU/wyLIpv77wZqFwUjvDNdsGCJL8KHPG8MT9qiRYAKw5z973Fu702LDDAizb?=
 =?us-ascii?Q?M7M8pnjFX6f7MJJnXj4mP6Er2omq3s4Lx1MkDxd6pw1vnedzqC59fUNG8ZZW?=
 =?us-ascii?Q?kritJn86gTznhunoh9fZDXG6QtYE6Wv8l6EnNHoOYtJkwTdqDJR2tBGGcZFW?=
 =?us-ascii?Q?96g1gkO4ZSXsW33p18Vivxn32ftUQ82Cz1yAncFGJZdX7NTmCGgnXh6+K5A9?=
 =?us-ascii?Q?5/rnLG67QMoYRNZg3Q7qN8OvFBX7CopaUFQOkOvPpbCzx9ifVV78Kfp1ghpQ?=
 =?us-ascii?Q?br1pr6b0n6Cox7fpkgdxg/pC7hHdUQC20M/jSd4CH5IqdlwqHmgozdlIuoia?=
 =?us-ascii?Q?lWzZhah1q/KfnVPTc7Wz0JggdvWtTWDLZBSsrCAEQ7yBeF+HFBxSh2W4W6C5?=
 =?us-ascii?Q?dYW5rcA2iaee+xLSYlP1/2XwiQ9hQ2sb1ju80ETZPsDdsbkA5SWXYrzTKQmn?=
 =?us-ascii?Q?+Vwu7dQyP642wX2cR3e3eeEhvz7k30bN6tI1CTVCQZq25gb4nE0hV72hmEVo?=
 =?us-ascii?Q?DSVCM2eSo7oyFBb/D2Yml7UWMte0BcIjFwrFD+/iDSUUMPp+KluHqcMq2s8m?=
 =?us-ascii?Q?FggK9k2lHFL/ZsMcX/TmhCihNwLO9y1l+uBwG4rsgRScgPKpfYnLEBZbuYE9?=
 =?us-ascii?Q?8vAPGRj9Rz3Fz3aVJ3zVCqwLnho64mwf5/yqneeaHDAmxqocUzkoRyuaBYxI?=
 =?us-ascii?Q?Dwi8uP4RhSVrAK0JPBzYq7TYh2Zgp/xF65+XsJC24Kdz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ua/zpWMWgn/V/DxtftCuov5tM1qKTjvhCA7ByWNBEXWtaBJINzyqAen7Ld4n?=
 =?us-ascii?Q?DFvZ5QK1n2hPx9roMOAu/6o1b3kp5/sWbrrRMfbz5GPfsmtQgQganJn2Bm0z?=
 =?us-ascii?Q?9+HlFIUskSnYpx/mde2WrzeCV7IYlb1pBuULcfk6Th53kXluMaaoclozoAo0?=
 =?us-ascii?Q?XTv6RJnWq7vLmuYapg6x3vd/2Ck0bPvsQOXwl8Yugd0vQw+NZpefMfCZm2h1?=
 =?us-ascii?Q?bYm+KiliDU9p1+CNRqgHiF30Xkjog3LNCPLe4gkOB2u5thsbukPaCNoeh7/I?=
 =?us-ascii?Q?QlRXyXsuZR+aTBCJvKsUbJhfn3F+s/CKGsgayXyXmH3iRj8ozJ2hvfVDt3kQ?=
 =?us-ascii?Q?qb/IP/RU4drdsyqEvSoBO5zE2sjAuZm47VtyltfyWRuQjCMzhT2V1fbMXA5K?=
 =?us-ascii?Q?/lLluvUnob4L+lYmtSQoZ6iypJbynwXoTujDlqg4jvkqVDfYixRO36En/SjY?=
 =?us-ascii?Q?OPoRX5zx0ibRhPYsS02AhnSeAXwFe7zEXLMOG2cPyoqfNXl04/SkoUfDCtQh?=
 =?us-ascii?Q?OnFnancrHtFsGDTDUG1SeF/mTD3aw6gD3Z6ettX1A5ZSeeiArKi1uoaAZIly?=
 =?us-ascii?Q?N8JKvGivvzs9PP66jy/NdGmJ+W6KGzMlp7ZyF26ThldwZOyb5mj20s7QoTkV?=
 =?us-ascii?Q?R67YyjK6Rgu1NJNus8+f4zn1AJy9NiG3j/hegcRrDk3CaQEInF/F5x9vYlXQ?=
 =?us-ascii?Q?mbQVTYjvtN+1k00y9RlKeH5ghiHi3HFwKNxcfetydFPr+aDPkJ4SY9hahPQB?=
 =?us-ascii?Q?nlOqDbiLbOiLpsJoKh3LAnSZXPI3JUeaqT8ZYnXIO9Vd55GsISBxWWJf6uD7?=
 =?us-ascii?Q?r+44YoToD4Z/UDsKjmb7vaK2pd7GkKH2Lx/He6ozyVVTaqZH9OrVGpdphHqv?=
 =?us-ascii?Q?lMaQaB5HkZLWpL+3Knt5pJrdk1I0e5+OI2fjHHeTAtpsAYtypYV52a/Pe+H6?=
 =?us-ascii?Q?G8Z/6vrxn035AUgtsWfPHFMeSvZCY7QjclFTl/q7ScWRKdzbe22yT+QS2o2p?=
 =?us-ascii?Q?cfP58Ce1+v0d1zWBBSJMxYmtY8aJ8xe4tNbcbBYnS3s1i4Q+zv2/OYfs0QCd?=
 =?us-ascii?Q?SVv+2yTEdGnkQlXezKhTaiD1Wt1vm4S1XHROXE92k6TWfjxM/LcGJxXAB2bz?=
 =?us-ascii?Q?JDH5TJsJp+gr1vjW1ikGyjih0Sa5cmMfGfVhMRsfDOy6PwsPdsxEO4uGkSEL?=
 =?us-ascii?Q?nR18/C7TyclUhHz7fOsAhZ9o6wvvOCQy85qKskHpeCV1aqvbHxVttWEY3wwl?=
 =?us-ascii?Q?NLN/0UJdJSxWzdw5S5Cz9qTkhMje0J44dyPtwqqI+HKgq0BUM9CN1Ls0eSoB?=
 =?us-ascii?Q?jeh2Pdt5w5TfHIgmZTLbhlxzuR5y6360qBRr8/VD8oZ0Z6jJkL/8UAklY0WU?=
 =?us-ascii?Q?2YgZpkx1ca9FBq5xgGS+9CHaGdX2xjsf/O676TkUtQsWfs7I6WsP/TZgCh1D?=
 =?us-ascii?Q?K1W7rh2Se66mNMyzfrXGVJP6tqoc3tk2D2uv/jZFxH2LgfMZIr4arJ5f+bDj?=
 =?us-ascii?Q?xwZyfaAl380l5LCcxpTSP816Kc3GaeVl7OvZUgzgcbcxjkzb4QMQXADkXbOf?=
 =?us-ascii?Q?gTO3IsM5AvFxuRCk4gLtNAF6GMGfp9DaJ+l7YaDzilGWCwLY7I2dj88b+fRJ?=
 =?us-ascii?Q?D/PHIRR9VDSmZ5tlRMzku+NSIxV1M35WLjCOVgg01geFfZHGgEctlppIuRaK?=
 =?us-ascii?Q?4Ge5KyaSexsldaF+HB6q5Ygx80UXYGpdflDqYam9FPvhKOpFsO0uM4cEiQmw?=
 =?us-ascii?Q?LM7nrklMNyNnuPE/IUaTm0KoB2ZarQw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4e581a-1167-41c9-9011-08de699aac2b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:36.9915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KVZKOsPA6zOjerJJfMpcKiE4nhlFD66spocHekp6qswmxca3BR9CGrvq+1qChrbb5KOHzgyZPCS9bzsCbxYC39deh3Y2k22XcFAHsmRwUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11040
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add required changes to call PCS function to configure the Serdes Port.
The Ethernet driver is adapted following Upstream Kernel node structure.

Function calling order is the same of Phylink upstream kernel.

With the PCS support, also add support for attaching PHY. With
"in-band-status" set in DT for the managed property, a rudimental
support for SFP module is present.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 99 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8ed6ff2fe3d..27c6a61de39 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -128,6 +128,7 @@ config AIROHA_ETH
 	depends on ARCH_AIROHA
 	select PHYLIB
 	select DEVRES
+	select DM_ETH_PHY
 	select DM_RESET
 	select MDIO_MT7531_MMIO
 	help
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index fef803ca167..d5b9da6bc18 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -13,6 +13,7 @@
 #include <dm/devres.h>
 #include <dm/lists.h>
 #include <mapmem.h>
+#include <miiphy.h>
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
@@ -20,11 +21,14 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
+#include "airoha/pcs-airoha.h"
+
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
@@ -319,6 +323,12 @@ struct airoha_qdma {
 struct airoha_gdm_port {
 	struct airoha_qdma *qdma;
 	int id;
+
+	struct udevice *pcs_dev;
+	phy_interface_t mode;
+	bool neg_mode;
+
+	struct phy_device *phydev;
 };
 
 struct airoha_eth {
@@ -694,6 +704,34 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+static int airoha_pcs_init(struct udevice *dev)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct udevice *pcs_dev;
+	const char *managed;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_MISC, dev, "pcs",
+					   &pcs_dev);
+	if (ret || !pcs_dev)
+		return ret;
+
+	port->pcs_dev = pcs_dev;
+	port->mode = dev_read_phy_mode(dev);
+	managed = dev_read_string(dev, "managed");
+	port->neg_mode = !strncmp(managed, "in-band-status",
+				  sizeof("in-band-status"));
+
+	airoha_pcs_pre_config(pcs_dev, port->mode);
+
+	ret = airoha_pcs_post_config(pcs_dev, port->mode);
+	if (ret)
+		return ret;
+
+	return airoha_pcs_config(pcs_dev, port->neg_mode,
+				 port->mode, NULL, true);
+}
+
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
 {
@@ -714,6 +752,10 @@ static int airoha_hw_init(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	ret = reset_deassert_bulk(&eth->xsi_rsts);
+	if (ret)
+		return ret;
+
 	mdelay(20);
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
@@ -884,6 +926,7 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	int ret;
 
 	port->qdma = &eth->qdma[0];
 
@@ -891,6 +934,14 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (port->id > 1) {
+		ret = airoha_pcs_init(dev);
+		if (ret)
+			return ret;
+
+		port->phydev = dm_eth_phy_connect(dev);
+	}
+
 	return 0;
 }
 
@@ -910,6 +961,47 @@ static int airoha_eth_init(struct udevice *dev)
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
+	if (port->id > 1) {
+		struct phy_device *phydev = port->phydev;
+		int speed, duplex;
+		int ret;
+
+		if (phydev) {
+			ret = phy_config(phydev);
+			if (ret)
+				return ret;
+
+			ret = phy_startup(phydev);
+			if (ret)
+				return ret;
+
+			speed = phydev->speed;
+			duplex = phydev->duplex;
+		} else {
+			duplex = DUPLEX_FULL;
+
+			/* Hardcode speed for linkup */
+			switch (port->mode) {
+			case PHY_INTERFACE_MODE_USXGMII:
+			case PHY_INTERFACE_MODE_10GBASER:
+				speed = SPEED_10000;
+				break;
+			case PHY_INTERFACE_MODE_2500BASEX:
+				speed = SPEED_2500;
+				break;
+			case PHY_INTERFACE_MODE_SGMII:
+			case PHY_INTERFACE_MODE_1000BASEX:
+				speed = SPEED_1000;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+
+		airoha_pcs_link_up(port->pcs_dev, port->neg_mode, port->mode,
+				   speed, duplex);
+	}
+
 	return 0;
 }
 
@@ -918,6 +1010,13 @@ static void airoha_eth_stop(struct udevice *dev)
 	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+	if (port->id > 1) {
+		if (port->phydev)
+			phy_shutdown(port->phydev);
+
+		airoha_pcs_link_down(port->pcs_dev);
+	}
+
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
 			  GLOBAL_CFG_RX_DMA_EN_MASK);
-- 
2.51.0

