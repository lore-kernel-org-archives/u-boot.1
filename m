Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D49E74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9756584258;
	Wed, 24 Dec 2025 09:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qBa9X6K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9731B84230; Wed, 24 Dec 2025 09:25:08 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B4B84258
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd4A84Nue7hNtgn5zDH4Y62rU/Peg3W1V2Ue6xncfcHb1WLZ4GCc+FjHhPGY8MedfKVIxJL0/ry4Z6tYd8ZycmnXTFEnUkI8KZ27VOAjSTdgFW7WnXIsEkomphajivQadifU2Inw/qysWt656mtNFdRmGp9rG7UiIGdwvRjPGl6urmMjNrreE63RNvizNP1JPVOkjg9ALVNQUHZq7+FzTrX8LDRxz3cI3xLWr8qlIEx3mnqUFZfpmrX0bMQtkvBp6yLqV8IxtH9/O1GruSFJXcwaR2lYBntl16qzEtIJEx7dKCqvgHzZ4xXYI0Az8qln0gg0g4swYRqNxVFGhkFIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COKEekGdK7SmBXm9AMhbnA3X6abQnyH3CIk3Gv1CtWE=;
 b=HSW0ZPe9MT4d32cMMhiRf15xu1PWFIINx6zogPv6Vd+TilQTs/KJlYEFa4T2jwqEDAJ5L4Agi99+qfKDadHbyA+bMNyYkUX4wGTYj+jmBYHHDfxrchCvgpkaaFNbMa3AvcPgFXp0tv9Q2R0Py6IX+ODOlPCxoQbF1IpJangQnIGHFzOOoBeWvM0AVWNywHYxv09f51awFhbG3kBlKDuqSh/VZQ7ax3sPnfraLw8QX+zTkHaBZtBqxt+9g9T0C2ZENMwbclSoU4oFp1SnSwmauTj7MYs4cLSzKmZ8ExD/A85afzu2XKsJr8kkxSYK/ADkcEK6TbBHQdmjcpSqZ91CcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COKEekGdK7SmBXm9AMhbnA3X6abQnyH3CIk3Gv1CtWE=;
 b=qBa9X6K10CNY2+rZ/L9LXZNScNGjJEKUFvx5uiv+V6xf7+7Yflu1cyHB6Ff+NbUyi9bVg6vR5IPqU6aY2yiAczOa5br9wfJkOHXQkFS7tmI5vllZ04zCQMlNVBrqvB/t5bZPJzTOLh78DYeDkqWZy0mOJb6eqJv+Zt212VieXCrvaVS7dqmxoAwh8JTMZxyZvd4W3djaUAA6pm5+4JcPRnm42BIuWDroj6Rq1Fv6sU8Z6BZUr6js1ZDlh4IIHKjjs4ehUx7l9RVDtr6WfA5dqn4UIx6pEuQgtkcz7PAAbI23n3uyChlKET9i3TWr0N62SEdLkM0nsG8Bi9X6TNhgUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:25:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 15/19] net: airoha: makes PCS support optional
Date: Wed, 24 Dec 2025 11:24:05 +0300
Message-ID: <20251224082409.1347373-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b21395-6e7a-4577-f544-08de42c5f0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQKUlEZZEkxa7x3Ma8UyR3boImlFWzni5mxJRiP91/6Mr9GYu6nBDV9esrtn?=
 =?us-ascii?Q?eqW0G6XRdr3pqEcBpHIq+0UZ7t1eiH+/JlypTKCgkCR4MnEgz5jP8llmIUr6?=
 =?us-ascii?Q?CpCiMjho9lda9+4OzyFP0buOHGr0K4Yioax0YkX/bfBXeHEytnhB2oNWT2c4?=
 =?us-ascii?Q?LEbz1wcvq8j4Y/xM5Br5f8p2SdLg0ZdHgJvWd6mJRfOdN/SJmysBK5+WEBJI?=
 =?us-ascii?Q?J3u8zccbZtc/DzJC7iXpxv9hh5/qOwwQzOqWMLevXoUf6uCRC9wtumSDJdXr?=
 =?us-ascii?Q?/8HURxC1nl5fFQTeX1XvV0/dfCkiNaMo94IIVQVEWpaI8vxOXjzno2Uoh00g?=
 =?us-ascii?Q?6G3J30UD5iU1RTf4k43Tr5YxMXw4aIb87LPmhFA6uKtIWzjuXYzevReU9btz?=
 =?us-ascii?Q?fXqgvl0MZYqLN370GOU/XSn5v+DTxZ9iXrLnS+X8GavBTzQZM6UJ/Wo8JVhu?=
 =?us-ascii?Q?q+XGkLYT/GFzQjwJztTdBnfvTR0n6kPwEcAJgMiwrbxxmpEQRqFdSOAaTx07?=
 =?us-ascii?Q?UoV/Jba4pf28Qn1uF7+mjKuc82lN9wmU8yXCAoXvqMMwekRLmdpuIeTYIZTr?=
 =?us-ascii?Q?8uPcGgwdmfjU6H35EuGCiABOZDn99OYsHN7meLrJvoDVOECQ8QU04hdHcxXh?=
 =?us-ascii?Q?TfVLtxh2HED7k58Bp8Sx68TO+X3tIsFcBXPnlDzzP8X6IAgPjMtOhT20uVZ5?=
 =?us-ascii?Q?CpaH9EHKeQj5E+RiFo7T8Tscra8rfzCFilIaGREIDtwGSlc9uclLNLVB9X4r?=
 =?us-ascii?Q?iVl/g4tjy4tulKN8wDD5SXyybFpVPaAq6asdZA3dmz8wxIKLXPDjP84cq1Xl?=
 =?us-ascii?Q?z1/X6N/gXBqpTbBm6ZvyU7iiZ3MXqkO9C0nAmjJSpRC8wO4MIFTrxWJDRntp?=
 =?us-ascii?Q?421j3pKPrlv7U0EqV5W1mymxmNtnccNu2Mm+nIVau+Tcex6TJ9T3cLoJnuNl?=
 =?us-ascii?Q?KvmLZ3KSw2JOxKyqdaENHYY8XwvSbu1xyJDuqj9okOPi5zDAMz5j5QHxFNjk?=
 =?us-ascii?Q?hAdhlLcyuPwVJltKvpak4euoXHBfeusU44ywTpaJfTFjy8qbptWTb8otGS/G?=
 =?us-ascii?Q?fQZUQ6zE2OKIkpUpNLR/vYJbdrURr+jFetCJ1PfxfztqOLf9DUbVeYXlBZ1D?=
 =?us-ascii?Q?NMDSqN+atByHwreOwNCp2HrJZ5NekAXlXOTm7hmLond0b4OA4wBeJyMvxZom?=
 =?us-ascii?Q?9ViTM7VdTNtLJuFHElvePLST4WRmY0Ry2fFQncwTYJDdRG0pIuuJ30p6rj/F?=
 =?us-ascii?Q?okwW6ReAbVsqz7kQu+mNFFbTeK/WNPDawONo5eKhIVZa7mFfN98vZlZRd+lB?=
 =?us-ascii?Q?77+gtLz5iVAkMuBfe7j+WBGJJk0NvgmP01bQoWezFm202gdHtpK/zwzsCVXH?=
 =?us-ascii?Q?xS9BQehE1DO2qq3Y9vXgq72Ytiq3EBOONsimR+xr510xdVbrGjIyNs5hu9sw?=
 =?us-ascii?Q?0xXUpEVAVx+qMiexNpFHZ6vDpiiao4Fi6RTOdDDgb5gNva4j1MNsPCVCmQ2H?=
 =?us-ascii?Q?mtFp/XNBNHplyrGj2zq1StwFRgeiXFUqmeHmGbKabQqMRtbq7ieH0XpfdQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmLsdvS+frvt+NqmefE8sNQZzSyQr634ZT9/TTIMVJbELQ5z/P2cstvN42xf?=
 =?us-ascii?Q?OLIZd1ypPs7BQT3E82/dUj00IHYFQUGuxPGgfoL6MS2VUVJPHBQHEuWKqEty?=
 =?us-ascii?Q?iNBv0yzDU+fSYxwEnK8PFEGVzi0JjpOEKHhW94Fz5LZSCITF5Nt6OIGdddlu?=
 =?us-ascii?Q?xmro+oFVr4cLDZutkekfCAER8VtrCgwLnKZXEXp2zllHHxjHGZ6gKNEamXBw?=
 =?us-ascii?Q?JYhg/klK0GfyPxbWPAhTAbOZi70/r1WsrvSKb2XOtz6lJmZYH/h6gAV0/SGu?=
 =?us-ascii?Q?c+Gq8unkiYUmfY1mGoO3kyWT88rCGbclG5Sf+UIkcI93xTNicEUQJZ7H4dty?=
 =?us-ascii?Q?MPtSPhHMxF1/U0pY2L5QMrBq86iSPWAk3A1TGd1wXZYvw191saEM8tYsPjnV?=
 =?us-ascii?Q?gjDuDqWes8LXH/tO/uIWZbNvjydYBTOaVR6t44YyEa59txClM1J++wtjYA7m?=
 =?us-ascii?Q?iEeTStgavUKExfZnJasVf2SrXt9TYW8c53bSUm+D/kuvJALJ5oHIR3D8l3R8?=
 =?us-ascii?Q?24yKWB1Pa4TQ4X+pbvu/Ny1rOT89VJW6KtN4jRqH0dtSLfgfBfl+uPwpa4je?=
 =?us-ascii?Q?O5u2VlSWGX3fFsYu250ufjXH5dwxau9/2vCudFnoT9HlZObGBo0h98c+Lk+M?=
 =?us-ascii?Q?cR94bhgnZK/MPruFxB8lp0LpFBSidFxnxvefp9xySZB89jUIUQ0IYVD4sZqd?=
 =?us-ascii?Q?ZQDHucub1qb7VBVLZewZAzWOwJ/KmW4dmk7VJJnVnV+b6iXA5GqFYOyvDhBV?=
 =?us-ascii?Q?iGgW/A75WsaSvc1bJ2rra/iZlFAiBcSt2N9F3iVDNKuT84jC0xtapeRk3wSt?=
 =?us-ascii?Q?m0ri3I9ak2vQ58S5WrxSoVUcp5ys74xPh8sUaeHduBSwOcNQPRgjk6zVTkX6?=
 =?us-ascii?Q?eOPkwU1m3PmZmKqapo5QdWYqF+dTRdlIpSpXxRFXqPiN1ZUlFj3kRsrfhmk5?=
 =?us-ascii?Q?SNiHpPPe1FzSLaXx6t1FvkPV7QjriPzxFLicndazkxCCN0DQ20rcg+/HJk7P?=
 =?us-ascii?Q?/QEgf1vPx9CV2bbezEl8S5Gb6FhWdOng9B8mthguVaeUUh9tHmM9AKEC20id?=
 =?us-ascii?Q?21FIaVsEXyS+nr2ocZKDxY/CPtXNdeBtKWhcH++dgtY007P+QGqXB+R7g8Qp?=
 =?us-ascii?Q?Zcw8U87stqu2vd/ZreZYhgFBneN4nBg8zWa9MwxsrTFfDZUV1epO+vTCQn4P?=
 =?us-ascii?Q?eMD8DtSHGsnqKYitnnEVG+7PrzeOo+OjB9X5p7UqbJgZwLpWjsg35iyr+evB?=
 =?us-ascii?Q?tULLvW9Uv4PjSijaAvn4yUjO3EKjrfDzZGmdz/kB5gBQGQu4gelnQO2N15xU?=
 =?us-ascii?Q?DW0xAvJeTE/wWEgSZkQ4FyHSc26AYhaQlrJuzwKbDLtjNGopxXGBFbtwhStQ?=
 =?us-ascii?Q?BJtgdBabD7gZw0wR7FFAcPdSxX6I8IJyhLPSNDkgvg6YR2tEzoT3mpTPlP8U?=
 =?us-ascii?Q?Heiyd3msSI0wSpDZxE2yjBdy6ltzeISnDGrAAJEWFxgYIRK+dNF0R5iwafiM?=
 =?us-ascii?Q?67XgxzCHqyT6/9raYD6PPXE3IhaVOhKQbq8k57jnzqYbNxF+/h3DJ1mikrqM?=
 =?us-ascii?Q?creY5jo1pVm0WA0jNWj4iwpql9mNCnVk/uxKKEcbL3EwF9m22BIE8CL5L7Ji?=
 =?us-ascii?Q?zBfRLJ7nKz42GMuFjzKEEswl3uhgDORGd8hq469KU4KVgbg0KpZjo6wwsPNu?=
 =?us-ascii?Q?VXOHe7WTE9WP8673hdAhXcYDl9KUmgyifJjgxlyYOLMCbAp3Se+Em+gFsjs5?=
 =?us-ascii?Q?YEKBW5V7bSwIefyN/PuN0NUja0gpfK4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b21395-6e7a-4577-f544-08de42c5f0b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:04.9543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hK1Oyb699Pgj8l5Kx22C8J9s6hWuMah2aieg6Vle64KJWtw2hJYg7GyeBRaUOudZaNkMfMRcj5bShtKGcQTDEDTrdl3SZaSee0wsw9QTwdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

It's not possible to disable PCS support just now, an7581 u-boot will not
compile. This patch fixes an issue.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e300ff3bd52..1356ca36722 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -126,6 +126,7 @@ source "drivers/net/airoha/Kconfig"
 config AIROHA_ETH
 	bool "Airoha Ethernet QDMA Driver"
 	depends on ARCH_AIROHA
+	select MISC
 	select PHYLIB
 	select DM_ETH_PHY
 	select DM_RESET
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index f773318fe14..a0644f63366 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -702,6 +702,7 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+#if defined(CONFIG_PCS_AIROHA)
 static int airoha_pcs_init(struct udevice *dev)
 {
 	struct airoha_gdm_port *port = dev_get_priv(dev);
@@ -729,6 +730,7 @@ static int airoha_pcs_init(struct udevice *dev)
 	return airoha_pcs_config(pcs_dev, port->neg_mode,
 				 port->mode, NULL, true);
 }
+#endif
 
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
@@ -827,6 +829,11 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	if (id > AIROHA_MAX_NUM_GDM_PORTS)
 		return -EINVAL;
 
+#if !defined(CONFIG_PCS_AIROHA)
+	if (id != 1)
+		return -ENOTSUPP;
+#endif
+
 	str = malloc(AIROHA_GDM_PORT_STRING_LEN);
 	if (!str)
 		return -ENOMEM;
@@ -915,7 +922,7 @@ static int airoha_eth_probe(struct udevice *dev)
 			continue;
 
 		ret = airoha_alloc_gdm_port(dev, node);
-		if (ret)
+		if (ret && ret != -ENOTSUPP)
 			return ret;
 	}
 
@@ -942,11 +949,15 @@ static int airoha_eth_port_probe(struct udevice *dev)
 		return ret;
 
 	if (port->id > 1) {
+#if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
 		if (ret)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
+#else
+		return -EINVAL;
+#endif
 	}
 
 	return 0;
@@ -968,6 +979,7 @@ static int airoha_eth_init(struct udevice *dev)
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
+#if defined(CONFIG_PCS_AIROHA)
 	if (port->id > 1) {
 		struct phy_device *phydev = port->phydev;
 		int speed, duplex;
@@ -1008,6 +1020,7 @@ static int airoha_eth_init(struct udevice *dev)
 		airoha_pcs_link_up(port->pcs_dev, port->neg_mode, port->mode,
 				   speed, duplex);
 	}
+#endif
 
 	return 0;
 }
@@ -1017,12 +1030,14 @@ static void airoha_eth_stop(struct udevice *dev)
 	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+#if defined(CONFIG_PCS_AIROHA)
 	if (port->id > 1) {
 		if (port->phydev)
 			phy_shutdown(port->phydev);
 
 		airoha_pcs_link_down(port->pcs_dev);
 	}
+#endif
 
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
-- 
2.51.0

