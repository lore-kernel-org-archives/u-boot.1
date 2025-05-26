Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82889C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E9382B2F;
	Mon, 26 May 2025 09:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hKAf1dFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6ED82B7C; Mon, 26 May 2025 09:08:19 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E9D82B26
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEfiMDNrKdbwAqOKL1C8tTkbcgsv83i0VCf7VnkDly1SPO4V7n4lLk2bomsOotc9zzRF8WYYrCv00Gm9EwmSsYhcPj7xdAIX8TDprs00mmL5rmVnTiJdWoJ5TvU3KJG7N++rGuDs1Kx1bipVVjgQ0QM4IZkgnmxlQokTh1B3P8KjzY7CSYFi3x5cwoHi0qN/K2grI8KO+UOyTzmhK+Pvj9pHyZWsebBsk5ZtHudncKAhpQQW2DywUpFF3fKZAu2sBN22mFFd1CVa2cvfLkhGAdOAyCsHa1CuCHnmfdp5L/I4hbz7QOkEbBPdqQcOBBMrMNUmMqQAFKCKiPRygJTBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtG7nwE2jSDXMs+J0MKWY2u3HB48UrV4DenUKFuYTYM=;
 b=DGPKAcEHfJ+aWFRzoNa8DTAuVb4HlKNMVzakaF0almXLGcJ5gz8RqtGixVa/Zjy1VdD3mD56tyoH6kIpPu9pQbnk0+uC25RAXCzcs1Mha3d8WBPWuyZrzyph7XTb1JzjpuXawgnyJzbHmzpWRZabLeHq/HX1h/deBNGm190JjJblSjHZgxleweQMKI3hBMFv/bGbqRatHTn+xj9O4+vgjTR3iBEsbbUHwhE+fa8+Yxf16BiSAQaVdV5pWNASokLnYUcD8CyzLytONzmClLqHSpOTi/V+rM0N1Xz0KAAwEv7ZPKGzdPVY4KWhHUFE8TtAs0CE+nQSwQpYENCS1UC7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtG7nwE2jSDXMs+J0MKWY2u3HB48UrV4DenUKFuYTYM=;
 b=hKAf1dFvUXgxYjvnEPqL0NdzPYvxBPdpSwNyjZnRnixVGpk9xGNrpgFtHdj2vLBZWRKVnnaGEMqmZjbfZWFjqxSfNVYuYhaFVnE90K6LWTo+BJ7kiKswNVtb+aE1mPKZg/QUibUTE69Bxhh6hoZGADR3y3jyabiJAykmSuUrztAqrFUnKoiBJ0U01Yl/RnLWH8DjIkw77E4x3SmE/vmgCMb0laXSqv+R1XDAH+ZfgNX1GbQF/QdRrVbVIS5Q3mxFaxpuDCCyDKpu2G1gMlGKbHlN2c7hMFjLLtItAWZDGTB9dCWGBVzjXbbFdkzvovhyLRM+S5G9H/KdsblBKxg1SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:08:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:08:11 +0000
Date: Mon, 26 May 2025 16:17:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 13/13] imx8mp-venice-gw74xx: add w_disable2 gpio
 configuration
Message-ID: <20250526081754.GC19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-13-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-13-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: cb573ad5-4f94-4504-4f62-08dd9c24137e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0VUhCL5t8HSa2C/lk8HgpctyF1yVWqEH8bIXIlh7isZ+a6IoZe/d/h3AFz2?=
 =?us-ascii?Q?yQEPB+EGocJEMqyRH7hWPdBCclgkHsR6KQEdMX4f5iLgrRNCOI9vOkYfyhfW?=
 =?us-ascii?Q?rjxvTsKsYh5K9uVC490CzljDcT3l7GMFaPM4wDfl1rIdEt5sGLJ3fOaObpzC?=
 =?us-ascii?Q?qlq8VdSTXMq2XL9jJ9sk4OUauDTWXUUyYLwnY+d71YJ8ohYT/rPh1JAf2kmB?=
 =?us-ascii?Q?HQYJz9LdlQ1klEm2BHhJpQgJAK+raYfTnTbF3b7XD8zSe37E/WOa7EU0eZGs?=
 =?us-ascii?Q?Pdl6gwcmw43YDJGEYHWAVB6PdsTQJsIaoIWEpSxBKU6iUCsC9bO5XfWg97Zm?=
 =?us-ascii?Q?0B3VIYanOt6fjgCwMc4W2p/tt3uAu89d/8OGaXh1cE4pA2R0wh8xBSEinWYB?=
 =?us-ascii?Q?otNQtYVKhF5Wr0DTz1RRUFWqMWX9tSAzCLJpbm1aBUPgFJ6AYJxmfi0KROq+?=
 =?us-ascii?Q?FxSmVTy9IfU9L0EwXNAHUWfCbfZn1BnpGwGPINfcfIhTeFrEnFgKa4JSPzSm?=
 =?us-ascii?Q?KxBg/Gy8oxR5wsmUt58NEonLIYqmGnlgUxPPvGC0dWYjYvBWGNMuPpu3VW9E?=
 =?us-ascii?Q?Zc3cggDEZdIRYqrQKGURpBcD7yxDCLzjxvNxS7Z0j0z5uok5pd4MeDSydpy7?=
 =?us-ascii?Q?CFmRdSdUuiUVkN+ERZaezN/PIe52zg1+yqw9uLpGl/jYr0qG1Y7VAEuxIbTF?=
 =?us-ascii?Q?qPvnLqicKHOJlgp851CoDs08nnzg8IyDl89hIhc3RlEEu1URCkxq0hzphoJY?=
 =?us-ascii?Q?wVcSgAmglXa9gPnXB7Qj7BtzXiGodnTld0QgmEhLPgOubnKk8f9UHPTaB5GV?=
 =?us-ascii?Q?x2tMqo4yfbrGuhY7c1DLF26dZRA50FydKwgrXUxaPqolq62OWc8Dr8aUoSiH?=
 =?us-ascii?Q?/wxO/DyqzZRRDxtucSJYKL9BiRAIAt+Rzu1/skPv01yGwe4fprF93PE7avw6?=
 =?us-ascii?Q?gPA8qFlmLWLpOxMKYVFuUVCHhdh41Xw43BdP8FKCVnX6gi2OFmkbNOfOmayY?=
 =?us-ascii?Q?/ix+A/RKhOCbj+rTnn8iKcoYdkezZBsP0uF7FSqV637aYyDwmUQK9UdzFAjz?=
 =?us-ascii?Q?kJgQHxf4ta/t5+52eu/h1uP3GBaiL73tuyUmemLN65VbNYz5aU+Vd9SeJZ9n?=
 =?us-ascii?Q?MrNoAzRb/Z8RVYr534ZY7zEKarVvnDDCXKasrop/xledTgRDK1nk1hjppaim?=
 =?us-ascii?Q?alGy/QfF/rk3BHPxXQsBXYwSjDNzpH0MtGTUgJmsBGnZygCeknfow0KcGBc8?=
 =?us-ascii?Q?HdZnQvmo57yr+xD672+P8zgW5T3Rk1eME9R5choDDzYnhKARhhF2GSzjACFh?=
 =?us-ascii?Q?yutJ31GIbyLjH7aeT579fx+WgFT9x1RChw62ahcxccQ6jzqORzaLQS2hk18l?=
 =?us-ascii?Q?vc9XaeLgPA/SfhTqEPuDt2T2+eA+SZ66dK3AkaG95DhnDO5rqO2IFPPIfSB1?=
 =?us-ascii?Q?11jt2eB3Ay2M9XIXdez4TbUsPNdq2ITTWvC9TcyeWJXAw4JoMCq6m67OPZ6u?=
 =?us-ascii?Q?trlCzok9v6HN9L4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTPMZ21eHio4HQidFmlbGS8a15N9/C/jgJ9etoT475p9h3yoH9+xdz1KreUi?=
 =?us-ascii?Q?/Rpql9CnViy6Bx/Lf45UGIC32cXvte1EJFpyWgTL2T2Ia9ICMhIkll42Vl9C?=
 =?us-ascii?Q?Ycs0iIpwIrxcXaUXSWmKHFbu0nrpI45mcST+E5w4INI9ifKS0dpgCHggbZM4?=
 =?us-ascii?Q?CtvNm+NFqs1EeBPvpiq7+czGHQckafVGUk6M6JdoCnrpr7sg4y4OwquEGKIt?=
 =?us-ascii?Q?9nZVBYUD8JYzFTFjAkkZoC7Kgkz1Ch2j6Goky2knAPCj3lfKIaqb8haUi6WR?=
 =?us-ascii?Q?461wgotAFzdyVWGYDAYlVIjyBvkO9smYutNeilsnAPFapphlq+c0j+79Tn82?=
 =?us-ascii?Q?FAGsnPHkDB8KxAmFcmWwncFHUBNXnMs/h3cOmehsqZZXcvt7ivyZeEWzFvhg?=
 =?us-ascii?Q?EcYyb918uYnbvhv0VpZBsmREBAD6nH+917ApGm9hQKpgX/QZRsn3wp6QzfRC?=
 =?us-ascii?Q?JOiJZjpb1bybTGiCmsFieDAMgSU2spARlFhgm7IRuzDDxgrhALnpLxIiOq3Q?=
 =?us-ascii?Q?Ue2hmXSLbT/PwLGd+OYmcY60NM8UGhdny1maIJTSEtUPw5WIJ8TQR3kHdWD+?=
 =?us-ascii?Q?RDmHTr8Aug+oYXz3io3tIWFBJmIlVnyVZ22CHdpGyEgPKWv1CFwFBEVmVcmq?=
 =?us-ascii?Q?/GGB6fEszt/WIHBYq8wBd0mK1pSmtXVLU19IvoUidm87ueJFNme0Jy89fzeC?=
 =?us-ascii?Q?8nRRFy9S1sKchO6JN1Nu3RX1R/IhAQJFpKDzy/aVv8bMDcCa09nFg1QAEMIF?=
 =?us-ascii?Q?W8IMOxV9z/N0/WEGbEWaL+t4GGYYqFWfCqtbp9SVVY0+7Wdba2o/DMUp7Y+T?=
 =?us-ascii?Q?aUoInjHQW4rTj3xwaHCF/RaDnGkKKUCcRYs5FkAzfBOI0Xr7yTOco+zhxKiw?=
 =?us-ascii?Q?uYQRVNPLDw1pijbD6/D9XO0EGvVRrSJkku0wPVvdiRNEBo3ZDXO3HbYrRKsq?=
 =?us-ascii?Q?LkLyrE9QheM3uQGTI11FL/0lKl9ZtxBbADjijPx9Jl3Sk10LIbnnX1R16Lya?=
 =?us-ascii?Q?xvXtEi63+M83GXwxYvpCAOs0bLe4lbUr4EDKFPjxGHCPL52j6YBhnFvkLvWP?=
 =?us-ascii?Q?1TdkgEWVv5Nm5L4Bip5tjpOX6gWh1LVcoZoPQbnieEl8Q7kl039cxMNe6yOx?=
 =?us-ascii?Q?lQJGLHmEiHZ7SzunmvWaxOM0/YK6ZCohoUhH4djOd8LBy60PQE+0Sa3tG8OZ?=
 =?us-ascii?Q?S5uqjTvYU34PRdqwm02eLigpDY5i/uYv6FX/8YAu/VjGFoePj/ZHFkje7noS?=
 =?us-ascii?Q?fHyKWm3wAYfwjdM24Fr37RDTuOPrkiNuB/1EdkjnCwIbzriteB+mg3eRXjHX?=
 =?us-ascii?Q?/2EY99b+axxBScS1Qoqqw8i75GndGBFoAapBX3VVkATjSWmmVqBKsgpJ+qvz?=
 =?us-ascii?Q?LCsOhWj0tc4il/28hvJiarn5CCePlX+GRhd1HPJzJdNubmD/GpXqQ6V9/1uE?=
 =?us-ascii?Q?hpTjDqOrMKEfxxnWIpBJqH5XLliYu2RxKbma18t6mD5WMTrQVT/TF/kfctZL?=
 =?us-ascii?Q?AyDmZmQn79TMbvxSkMqW/p/UKXarkUPtLmNkNcRAefswoUU6OhvZMHaxf5L1?=
 =?us-ascii?Q?6mfpUL+/NrYgZ+4bv3OK8zuxafMba++FTZ9EdUYw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb573ad5-4f94-4504-4f62-08dd9c24137e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:08:11.8416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wba1hL/oEx6rQslanwpZcXiZsTo4b2fWUYTU+wAqZPpdDtGv/ozEb+hIvamqLvjJ82TD1eBWBaSUhCgFnHcEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:18AM -0700, Tim Harvey wrote:
>The GW74xx D revision has added a M2SKT_WDIS2# GPIO which routes to the
>W_DISABLE2# pin of the M.2 socket.
>
>Add the iomux and a line name for this and rename the existing
>m2_wdis# signal to m2_wdis1#.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
