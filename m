Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC611ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F83583CE3;
	Wed, 11 Feb 2026 19:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p2QjvNhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCD283015; Wed, 11 Feb 2026 19:22:58 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63B283D2E
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yROSqcvXx1gIpMEuhaZYY2o9sjzfu+Fknlr+jrfZ/QXB/1eiH+17bZmmrd+ihHWBg+M1xIexfZ2DCBoRi3tepbRN0d+VnGvJ1UelkmYnkBSlT50Ngd1LVg1O1z2UOx08SttsARRPWLhNY/wwqrIfS7cyU62V5cDTBCWGbSV2GWlS53qSC+Rs2vSySVspHf1xGgIFbgIFVH06yZo4Ecdcqy6MEibkdP+76UNLSbAN1eUttciSu3VoZygME6B/xZUVdnm6LFKjDSlYUujjFyhEGz5penFWZK72Ej5/VV6M8BXSYhA7lXnqnK9syEDS/fYkv/aaYc9+V8ygfUnowE1w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ka23LAg+7GGWc4DEImE4WmVP/Z4E+M0+455+IN+vQ=;
 b=pZzpm8jg55flcDs5zDySMA4E6qugRGxsgJOv2hehhrNfCABAuYmLLe6b7cHz8MZ98q6QN9zYH8K41xl/Gw+d+3otUUvI4mqKImHJKU7v2Cs3GE1hltZCS5R1Y5eaChlsMWjpT7VYCJPbsUQgNk/uiXEc54eHfTcr51xhG/arFXvnseF7iWZxzHGFpuBfMf4zMN5a0QLnRwJuvmGYpDSWcEB9oKamLpVn0ZBDdgCAPRVDFwzsPtnm3Okl/0umX53Kc+5OqH4L6FX7QW66pV2biRvcW0EjtK1Iwz2qh6hgNsl6WZqhEaSTnJZCSih7GidI5sFfY7XiyWtexa2GIAYhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ka23LAg+7GGWc4DEImE4WmVP/Z4E+M0+455+IN+vQ=;
 b=p2QjvNhRk7Cr3RpoZCpqbugHSfhLWEAZT+a1XCtgiSLO+ItLDBf9+SvheXBFWAw1O9iV7rpfxbxEgixfdJvH+uTjxDv135b1bO0UR8eQX9IaNkmeDy5idht8YwuEP6mLqmu5alHppxE6RtYPr80l4RJ0bXo6mpOGJ1ta2UUaeQ2vRkmOYLej2iFQfGvblKerc9o6UbvoCAavLbwlVWGSnmhFJ097GsJXtO9+43q2k69Iu4nT2fEkENbmJg49mDT/vfsIsjwZqHbomgw+CP0douNban5iMZUCJLaXm7CyaBt/3yOtEvTuJzpLZR/4IlfOOC4F8SnbcNxJ82T9l2MJ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:22:55 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:22:54 +0000
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
Subject: [PATCH v2 03/16] net: airoha: avoid out of boundary writing/access to
 gdm_port_str[] array
Date: Wed, 11 Feb 2026 21:22:17 +0300
Message-ID: <20260211182230.968921-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 201f55c0-0e5d-4f02-b318-08de699a932d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MhquuAh/RIpRFbN074kiB/VFye0JbDOEUZn9u7t1L22M7BG4xyNHvFJTVONj?=
 =?us-ascii?Q?r+DgezP/JvpY7ZGrqhL94KcZfjOneAEuamOdTgoo7fYfU7bGIBL3vmXObXF6?=
 =?us-ascii?Q?OII6REoeJI7pnYY+tQWYBY9J5shj114Om4g110aanfCEQq7X9e2LRmuE8PgV?=
 =?us-ascii?Q?YWLmymYlO7HhXLXnpi3uBqYH0I6Lj4U+DuQe5SZOjs5+8sWA54eNn6zh5co7?=
 =?us-ascii?Q?JkOohDB8r/hOtn43QQcA42Z4Hx8EkdyosTwF9zmrKgjMSmupkDdyNPWjIYK/?=
 =?us-ascii?Q?4PyxGYNSYxeTKMB3o5XuO5yQ1mHnAo1LABbONWvq2CcRAZ83PfT70Tu0BN20?=
 =?us-ascii?Q?ORgLlTU1+7TVIg0YJ5nhTKaHtr2p+k5TnDnvn3XVTOBMKmmbTQaEXocSAoWd?=
 =?us-ascii?Q?aqZIsaivxGvyUyI+Jr4FkvwgBfAUoyen2w7oFeTS7OhIjmvXF8COkw87uvXe?=
 =?us-ascii?Q?USfI46MNYFqw89Ugtmsb6pF/Pb7IkRUKqFz/HjKJLXLiRwleNzz87JGRjR0U?=
 =?us-ascii?Q?bC0GZSSj1qaXUQUVfWxY05exnFMxoYMj4K5ZlNe8KZGUCdHwg4jRnLEXbpp7?=
 =?us-ascii?Q?AVNyE4FPVh/IjjJw0y/abU0OjdN4laNrGRSEKgnM0U9uhxxGWu7cDT2BXMHG?=
 =?us-ascii?Q?8XEZ/1dIipbKjgEf4VqQWsPQKdK98/HLLzymckBqZEJg3ab2Hh6nEwvz+7xt?=
 =?us-ascii?Q?u2S8XP9abW7Nb29AP9SQYD84e4Wo6DO+VGUZtks9EbX0Q1OLOB/aQ+DVaKYX?=
 =?us-ascii?Q?6nqw+paSjii7fbLFX+AeSq7kBLu83OMDyp2PL3/JWsurX09qyDDKAphIrsBS?=
 =?us-ascii?Q?QbFy0Ou/1sqLtvgkDuVc3mWu2VYoVaG28YUwU5HT1p3PVOJztPNhLfBuCWoW?=
 =?us-ascii?Q?r43fInG5SADpqMjxK5dtMEzKqMK1JRY8zfYI8q5ttkxO3E/5DsPS1+fUuWEd?=
 =?us-ascii?Q?+g8oaxykX0rr98OtXjLj/ZbzMmIvrm0p+oQ+Y+W27qomP6jStUWZW4mN4lOg?=
 =?us-ascii?Q?ImQw6ZoaeXK2iSjC8op7MFZpcVR8rKsFLf1w8169hiS7bgUmSxfHfLHOaAEQ?=
 =?us-ascii?Q?p9dhHq354wJrubCrp1jPyQHz0gIBLxfEn7sSE/8W7dMNnjDBl6masfZy4aBQ?=
 =?us-ascii?Q?cLaqQT2BDBpYOLZfDPyfiibrmWOvCmXq1ABY0XbqQkkR5w+JU+tjwSL0Oikm?=
 =?us-ascii?Q?KeJW5EzpSV/gJqTTVm32rqPV6d8H+JY8dQMgnmjiCEaumVLOb4xogXNVIHeo?=
 =?us-ascii?Q?7X3Ch1Tpu83dx/Cw48b6l6qLscsW5oa6zwT0B+P6nA0FIAqsLh6UQ4O41Phs?=
 =?us-ascii?Q?OFYO5/3hVS9JGAO6XKIWuIR9Ak13m84qcE0fiHryRoFAiJ1XcKdTPbjBafkq?=
 =?us-ascii?Q?0vZpi3QIcfvt+CgzljVJ+8tDmYybeQuVBglXe8qUpUuR18cX4eMdAW2hEXNz?=
 =?us-ascii?Q?WLtVK8kuEZPW49n6nmy9ZfVduHARZMcwQ/73L8qDeJmIzF7VIWlZGwxo2VZ9?=
 =?us-ascii?Q?w1Zk9OSN9+SxnX6HtmBvQ5z+aPjQ344gv2szdGO88NvsoL7XnVGdoZlCJozU?=
 =?us-ascii?Q?i83pSa03ECooF008q2DMthZaVDRhs8qVCRyu7omI87bIx2dVaVgtaWjI3WdW?=
 =?us-ascii?Q?qDMARwaAEU/5RYO1fEVfqBv1IQyNWjIBkzHUbuBHFIJt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r6BMvLpromORTTkzzm5E6k3+cpsU+2oy6qtuyg2excK1cHgOAXEfEqg5mCoa?=
 =?us-ascii?Q?7FOBv4G08ZEzC3wvEmZFSsNuzUnuUf+JFdpcYvnlNLHqxeo5R7X1Qocljkdf?=
 =?us-ascii?Q?JokVC1FHPMUjnYnnq6jCPaC1EhwjCdn1U7JHG2aP6P3qsgVcY+pmUzIbYApd?=
 =?us-ascii?Q?+TG88+7uEX3ZhE/nplGOB0taOFXNdnMmgTQ1eM0zSxsF5vhcw4Gc9/IO8YhC?=
 =?us-ascii?Q?7g4Bvl39Mhv/i7btTj1MpPmf+bAHJnPlDflVIPsycb2r5kZ+ZFktwG6zSr9A?=
 =?us-ascii?Q?YYRko1c8SoV7b/xc88s3LVTgvbjibpHZ33t4MZEZHz52G76pVKWE3oz/3Bfd?=
 =?us-ascii?Q?0bIHhakscwldnSkyUjtBVdhxsyCrIN7dTtlFelJjB9huU02DU2FeuSjIBNBH?=
 =?us-ascii?Q?e2AjjvVPNRz/IrHSz1TkpN5+whCClguPq6mUKmZ6G7mLj99zHIbw2yGxADCm?=
 =?us-ascii?Q?80csJ/Cs4TmrkIwgCd7PD+PEMqWWpJWh0RVlPcyxsiL3ODd9JS36g9XZsFbt?=
 =?us-ascii?Q?GlLFcjMmV56NASfePPCPqbctJDPmdUL6X2BDntW8AcXwcH3GBscdnblapMii?=
 =?us-ascii?Q?BPWH+SMxMAsMlfaV2otpMuWQMlIu9CiaF6qzj0yt2szqSBDuRqUraz2sB6rc?=
 =?us-ascii?Q?yABaXlyEO4voLQSa50f49gLxfF/+md2JhRkbIMihi33vYgz2eOoGq5y0vVxg?=
 =?us-ascii?Q?93IPUKzUMlyINiq/izrg7DHlweA90thyh4aSlhuj45rKyw7TqCLZpI+gBCCB?=
 =?us-ascii?Q?NlbTBuNyvaizEO9ueSC5MokDzbPfZAV4aW8eO6UuA/EuxZ7nNZDvs1GOywEF?=
 =?us-ascii?Q?s5yK//lTr01l82InpDaV+jpfsQqOzClHsE4M0nyTC+Fhox4PfZ58Lm9uHa7G?=
 =?us-ascii?Q?eeI8u9lDraDO6KiulsMbacwWuo93GK2uo0NYUy8+q2lw8n+HwQUaVxK+Kotm?=
 =?us-ascii?Q?c3xXrjURhks13sOWtjFEt09/VKWjbKBk6ZtZtMKAN49scpRTHNpKW57DLm2N?=
 =?us-ascii?Q?P6XxofdrPYLlcr1xAJuQLJQ3k6eTWlcFCzGeVz3GA0XnokrhlcWIP49jcmd/?=
 =?us-ascii?Q?1Dng5M6bD2TQkRRc54OZnWgB1qkF5Z044qIwY1zBgvZyahauk2ChQArM60BM?=
 =?us-ascii?Q?ISI5DMLX45Uq5f7Y466WF4bUMTMe5FKWTbiN5xqhEQHTlnMiy2GvJxln+MpZ?=
 =?us-ascii?Q?OgBTFU/raIbz7Lim6P3MEnO2APhUye/qOwRB7633Ld92NfQ1XKWhb7tobHA3?=
 =?us-ascii?Q?Mm93z2PC0Y5BVpQ1fgFoNWpY5LBVjMdTui8QUIBSAA3p4D3SBYLz4o2rn3SU?=
 =?us-ascii?Q?jRwigcYaeBzEzGSYBBpOIv89YZO3i4E+A+F+ToyiW6+XJF5GW+8JUJRpDYW/?=
 =?us-ascii?Q?N3xN13OsBPwQW01Rn2dYaxHSK/Rj5bWOnQguxTHq7f2EPe7soL3IKuo960Nd?=
 =?us-ascii?Q?QcAWCllVCZUGsapAJOFdjbeq1u1IFoNoYmKIFL1snVz4mt771EPnidQPGFWm?=
 =?us-ascii?Q?gvAM7LeQkoMwT72/VAXRgDQhnNleHPtibWktVSdkLADrT9w6f3QNff1CN925?=
 =?us-ascii?Q?ySAjW7Dmxumu6IF7No6HTFhc126ASL8L+FiVzQvobg83FA7o3KL2G6qs03l7?=
 =?us-ascii?Q?9IrM+nZyFXGWGlrQEngpOPrj46GJwiyg+Ic5geFXTpX/fP6SsnCoCAEfWqGE?=
 =?us-ascii?Q?6dX1/FXlWutWg+W7bgT4L3clR+8Huv7DI1U6M8THe8UDOjpkDOgcOlqC+eam?=
 =?us-ascii?Q?ie8FZg6UuCaAy91XhczUCwsTyr6eP/Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f55c0-0e5d-4f02-b318-08de699a932d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:22:54.9229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGQ8vjOjVgPUtzbQmAfV/kYj8EbNRvhxjQJs6sfRU3ctTQryuL6j6B5ww3m+pk5KHgcd90ZmZFB6/D1cU4TrZ60McLUtNsT4c/c0QFpHDbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

In the case of an7581 possible GDM port id are: 1, 2 and 4.
Initialization of port GDM4 will lead to out of boundary writing
to gdm_port_str[] array.

Let's increase the array size by 1 to avoid it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 2007642ebae..171fb0825fa 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -331,7 +331,7 @@ struct airoha_eth {
 	struct airoha_eth_soc_data *soc;
 
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS][AIROHA_GDM_PORT_STRING_LEN];
+	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS + 1][AIROHA_GDM_PORT_STRING_LEN];
 };
 
 struct airoha_eth_soc_data {
-- 
2.51.0

