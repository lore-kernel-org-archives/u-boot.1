Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4DCCF9C69
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34E388B79;
	Wed, 25 Sep 2024 03:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0U35Z2Qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFB388B11; Wed, 25 Sep 2024 03:41:33 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D028C88C4D
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzUoZKaGF4LvuZVO+1L1LK87CmGTG5kvhNed/tldauDFKm4OsvUK6IWGwOVG6KIFGadXKDk0+icE/VGXjFUigK1Ep/Pr6mZeFMDKYoLQ/3Cfu4/wXJ3qcCLSJVeqgQIZL4GLzAlHGP60C5L461mB7zTyX4+Gm4OWksg8yd0NRNB3ZF+4GMTC2JM8DYds8a95NdmBwrf6iSOMFBtugh9AhNf+KGY5RZSicwzxPknk/7Kzw0tDkVkEGudYOSfNbHO0XP1WYfqzTd4uR3Z3EemEb5CgSsZ5MsSP1NVdPMhJUCMfT8KwTmEROoLmGPedxYFMA3kLIICz8oiklMcvBMRfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWxga44Exx31SK/nLCWA1BNlOy7Q4PLjJS17taa2qvk=;
 b=nOeYBJnnzU5c5D8eKVtlZRGgnmjxJxKuY/q6MXuzZV2zKybgXhWYVedSdcc5Dly8ZJ3+aastwsFSFiRRxY6nKtlVwF9Xs32k6MlyBi7Z/LfdZk3+Rxfp6+RB/y8aGeL08M6vyULGNnMYDz/qdpz6sAiCZLWvj7ZOGCcCUkvsE2AulZznxUzV2SnTlqgdCZ2oBpNJ6baqC0i1NYzwIWdMVu0oBABgUqZxO86gf18S6VhFJ5qIbIN3B1/B5dT1vCEyGfAZERIYzMRu/6udw2OI/i5x0HBx+Q8Nc5yVuBQx+9jsF5XQlEM/iOQxJJJrPPKhquv66Se+mQ+1PLtpGVz2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWxga44Exx31SK/nLCWA1BNlOy7Q4PLjJS17taa2qvk=;
 b=0U35Z2QrI0fetyoDigwTFfTRI3XVA0gtG2v44Bz/mN5OnfIJ2QWslOcCgFpR9QWnoMwu1dHgewL/i2+ahB1I1oMOfCOBpjMu8LtlHAwamspFb0ZiVloZoB3Qd+au+6ExvkSE1sR2g4MYwC1/jxtAor6FQlxPgAw1gacQZ2vjVTKbkPzRAL75pSy1VMijvtsqH0DbM6nz1nK0b3R251YL8m0kQ24I+TkiaZfgnJkWLwQ+C/ttIpTFj/Kr5KJL0AftAq1RUAzlPuWvTdrKLUlq2FH7LH2by8wQdr2xfUw+YF57aquDQqgFLI7QpexVd8butqGMlc6vfi2YURkwv0eARA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:22 +0000
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
Subject: [PATCH v8 11/13] net/netcat: add netcat over tcp support
Date: Wed, 25 Sep 2024 04:40:56 +0300
Message-ID: <20240925014058.1679074-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 23e69418-db80-4717-0b30-08dcdd032955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eLlSof4PK1YLstfdljBH6W2z7dSPy16h0rbU2gVC4w2Qb5nhgWfyNipTreOC?=
 =?us-ascii?Q?4IA8FZr1gdpseawbvBPdtmk1J6l0kdb5XqFTWNJi3WHIDz+0XsFysvdG0vLb?=
 =?us-ascii?Q?J8iZmCfIKZMyJBDncp9Mk8h+RfarWpRiP6mzhIyrrxbTqWqxyn0syCVIe6PZ?=
 =?us-ascii?Q?4nnSRAJNhCGAEvBtjYbOsbFsb9JeeVclWqyQbGoCjf+Zvz9vhCAkIfiAAGqo?=
 =?us-ascii?Q?TBnzc2Y5TQHHRUerNBsO9wdTP4kPgUUdQSWFd5AIXgzWe4jPrwPx+f0sTyuO?=
 =?us-ascii?Q?U8WCp5nuXtcsQogTNvPQWG6sWEJEwIyty6yiY++h0t/wayjI/x4u3aQeVOVA?=
 =?us-ascii?Q?qK1J6nTGbBSLQsmBFEtNdHNNgbaCAZirRBbqbkdt8OUB7lx4p/UynUxo0kGl?=
 =?us-ascii?Q?JhXV6hshpINmzYuFI+yH1vtFzuCbDUUvWiDCJntMwjE45wedfc6OAA8Sj1T4?=
 =?us-ascii?Q?LCiONsmas6UEBBJFdPkIRLg3H+qtHZnJRzzmQ5anUyBjXubUyAY0hMGtRVqk?=
 =?us-ascii?Q?jAYfKUVZTRpXlMGsXySBSHUwuTehjS1QJhQSFfqAJQCsyA3Ar+rMbflkwh4R?=
 =?us-ascii?Q?ajmCU4sgiJA9/Z8TO/PHhSUNBRACBinfAwcuPs82Ouh9po5RxuuXX+ZmEdsq?=
 =?us-ascii?Q?0zD7lRgf2TRW0IMc/Z6PMY95ll1x45FRy+lruBxiT2Ql0blBWxBXo+v1CBf/?=
 =?us-ascii?Q?XXPA/1RgxlEFXz4qnEqiEeYI1Jp53Xd+Y799p+C6YG6eSCqmjeh/wlgCNqtX?=
 =?us-ascii?Q?S2/Z0RurcpqdnWzEPyDino0IKVu9YlcErghStMxkAaj940t1cUoBFaQTv3jD?=
 =?us-ascii?Q?e8Is4E1O5u05bzrBhHvmeXePq68JaKrvjYHNgdo4PEfBotW8Q81Yq5DmAWhz?=
 =?us-ascii?Q?wrEt0Kp0egYvLiSkxVXXHBBGg4fYVppHMMGFb7//N/KNNFYOhC3Re4Y3ik1X?=
 =?us-ascii?Q?pJFQKzQUkp4LbWkQdEWEmmd6/Mz/jnn9VAqajUbXpOkq+n2wizjUckB1TSal?=
 =?us-ascii?Q?D/tUG+RKFoupnsMh17py+Wt0mlPrW+tnLCep1rfLG0FuZwdQm7Y+d/mhucrg?=
 =?us-ascii?Q?CDl53ZC6lNJXVpSQ98ev2fc16rtMrJiuEgDwgZ8WFHWdc+eEmYl8cJ90p9LD?=
 =?us-ascii?Q?8jEGqBymHu+HF8RkB1n7PwBoH84AWCKrx61G9x2CmjkQaiI2ZcD1ur3vPL2I?=
 =?us-ascii?Q?whXAYrmNtvayGaWBtP5XgTq7XEZYxBYaEpKZhTWxiQxaIDw2qO8txuQzoELf?=
 =?us-ascii?Q?/CVLdUsBZ3Y04sgsBcuh7gPi1SCMaIDEMbc46jfEKDfWuVg1SvzTipe8WEa1?=
 =?us-ascii?Q?a6hp67ePi0lkErU7bNbMk9urd+PNG4ZpwxzigiGGUSYdxR+/ZOH2wV/Ai3YW?=
 =?us-ascii?Q?Pe9nj8yTXiWPUavT53W+yGOYVEpvt2cdroz0jOjBHHhX1cGckvbMRiv0yvV3?=
 =?us-ascii?Q?g8dR4JZ61kM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ow9S9RGZb0iF2GY96pqEPGlGUPxlP7WM9m7uhvAeYlW2LgoBn/OXJt5aXswt?=
 =?us-ascii?Q?lZGtP4QYSq+5P7ZR3JwxUTUS/YUUqxkkdNY61ab/3WyWiNOsm2VWPiMMS+Fl?=
 =?us-ascii?Q?UzCceGd18EUmpOYgovv1IShLPnRUSAZuy477C4s906prhqnZr0BHWCxWiYdy?=
 =?us-ascii?Q?djkLxV4nGVwmmZ6RL99foCa77ttfN3VIW/YxE1o3R2iK3LffKy3uh2ue/4ob?=
 =?us-ascii?Q?ojW57zG/k6pJCqsVw+xOlD3Z+hxih4RlwUhxekepEXQ+7lLfmPEsAM5bNVjB?=
 =?us-ascii?Q?FX5BqjPStN+vkUEIcW9T7TM5k+QbcodAKPek8U5mKy4xWbVk3WyXT3Royx23?=
 =?us-ascii?Q?PXzj1DjIATEPLI1kdsUmcSKxc2N+uf0Ugz67caG21HYdN9AS80jFJ7Ngh0+f?=
 =?us-ascii?Q?SBUa39Zvz/SKINOkVfclA8xZuweR6ezb2wYy8gEfSva8Szd7j95S2Md2RDnk?=
 =?us-ascii?Q?JEfocaKzg9aWHMeeajLTq+K3OsGiVwVCs5AK9hInxpuW3nZxzTlDQorCzkJ6?=
 =?us-ascii?Q?oyj7MJGXBYLmoGHJNuxs/EuXnwmedphKynsE/ykJWWqJI54W1n6wLeXEvvRi?=
 =?us-ascii?Q?vyBy/3CfOJWiEnCc+GIgilkwADfVEhr8rd2fafuQ15xiYy3X/jLJl2oCvkdl?=
 =?us-ascii?Q?OYsap1PzuiouQYdo9PeGyP2I+UZvHxYosRu8fuxNOviw+oA1sZfmjyCDGUC0?=
 =?us-ascii?Q?pNwTCT/ghEz2bAIvYT/rpIkDVU18XVramFVXxr6Mw4a4sQ3+UqaifbBM5XLU?=
 =?us-ascii?Q?9QSuOBiNfmGp/3eq7z7lggw9dm/vGyCxkMeuqO1gZE8ImJePjt8Z3hW8QSSv?=
 =?us-ascii?Q?IzhWUBni6+pXe0zyxaIRz4xIXxJt8kbUv2Akmau+oZ2SCl4vhOo1orR51rvT?=
 =?us-ascii?Q?uiyz6lzR6T7i2K9E461CBKPOgLcuWsEulb/2uekeNBTgH51hmvkagVc1kyFM?=
 =?us-ascii?Q?DoqVlxn3ifolc5mn8myQgUdF8ye7F/UUm8pcmsJ7pA/ri4Wouzj+zAUaSfHD?=
 =?us-ascii?Q?h7GELnaSOjobClzQzfHP8u2vPgmj+Tq69dFBuFe9UiTzJcqXNCBF6R83OsgI?=
 =?us-ascii?Q?uDFuouOFA9KVgNoANhdOmwZDT6znTS5gCHGa0Adge6K7AU/5pXd+AY45prks?=
 =?us-ascii?Q?GUooj5DWWicDFdXvnWkhETizbiljohlkJzenHFtocmqWqBsXTWAjf4BeroRb?=
 =?us-ascii?Q?LbgHMe4pz4yZ4wkkCK7Ia/SiuMLNokKixbSAHteIsOZxNR7S4NuOTIJDqwJ1?=
 =?us-ascii?Q?suS1Dee1TkLbd6MabKqTvqiyyXqEvrszO52P8CMVlGN7R/PCPl5oBTNXdyMf?=
 =?us-ascii?Q?Z8v7FM8GHUF9EhcXztZsIywvTqLQDRbRskOQ+6MedkJpwTryoW3j+fRFEIjy?=
 =?us-ascii?Q?lP742eZpKpcst4ILLpV5WV39R2+9cfuRRyZDShZ67njU2UBgQ2hzg04TNWHC?=
 =?us-ascii?Q?4rLljfj7duNAa84EvnihXBqR7VolyjK0s8f2Ew+FFhPRuBD/Wzv7KP3vJwWi?=
 =?us-ascii?Q?GSktgdEWuvti5CDM/kyQhYrns54MuZ0PiLh+m2l4B82e+fEwgjPMDDiKZ1vA?=
 =?us-ascii?Q?tf9mS7GpFFaj4KGTQ1npMMqJFlcR7UcXKQayM4ui7Ej0686ZOcGUgm228oLd?=
 =?us-ascii?Q?M4U0/4zHHW9sA6gSAeDENyg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e69418-db80-4717-0b30-08dcdd032955
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:22.9018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtIUWsCkU/isC9TeB7+9L4JzSDYRE0glxqbnfZmsqBg+1za5jc9ZrdtnrJpSAHEdc8e4ZeK2YOhS6vesd/sGDIVOCoubIUW2lfI9OCguRuo=
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig          |  10 +++
 cmd/net.c            |  35 ++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 265 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..cfdc53e494a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2007,6 +2007,16 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using well-known netcat (nc) utility. Unlike classic netcat utility
+	  this command supports TCP-based data transfer only, thus no data
+	  will be lost or reordered. Any netcat implementation should work,
+	  but openbsd one was tested only.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..79bb126dbd4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,29 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
+}
+
+static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
+}
+
+U_BOOT_LONGHELP(netcat,
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]");
+
+U_BOOT_CMD_WITH_SUBCMDS(netcat,
+	"load/store data over plain TCP via netcat utility", netcat_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 1, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +346,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +378,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +390,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 92156b5058b..acc9a6edb36 100644
--- a/net/net.c
+++ b/net/net.c
@@ -102,6 +102,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -566,6 +567,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..f0c387e58e1
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+#define MARKER_STEP		10
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static unsigned int		packets;
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	for (; marker + MARKER_STEP <= packets; marker += MARKER_STEP) {
+		marks_in_line++;
+		putc('#');
+		if (marks_in_line == HASHES_PER_LINE) {
+			marks_in_line = 0;
+			puts("\n");
+		}
+	}
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted", packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker();
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker();
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void *ptr;
+
+	packets++;
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
+	packets++;
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if (tcp->rhost.s_addr != server_ip.s_addr ||
+		    tcp->rport != server_port)
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	packets = 0;
+	marker = 0;
+	marks_in_line = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (!strchr(net_boot_file_name, ':')) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (!tcp) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+
+	return netcat_start();
+}
-- 
2.45.2

