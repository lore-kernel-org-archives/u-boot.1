Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B169E7FDF3
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 00:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CA383F54;
	Tue,  3 Feb 2026 01:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t1j9mIJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BC383F59; Tue,  3 Feb 2026 01:21:42 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBA583F53
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 01:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV90F1dD/KBVGuyWgWxB9WgWBpBZcfAV/hmg3FgYGDLBv+GdqtHu5jnyffOu9KeDdXuztELRG+kRo/aE6hvgKP4muIxqh3R/is2UXeutGtvvTurskVY8wHzvY9tG2ul1ykzpvh0IrCKQlVG4//3RajZm7WiPOyBazqQbSFa0wuURz+vCA6a+DlkewbeyP9Tym9wWvQJsdWv1hHh6FMiXndhl9W5eh1CYYHsUb01CSIO5JMgPyPBocAlibArHJlENwXDiK+RrAbs41oj9M8PAp4OyveB16MStr2mWaiHPts8nUmmUBzqB+Jsbs3FUcI3h28oRuEZ39BxTfOGbOAHQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP9fRz8EfWmTwdl6datV5Ul8uq3KERitBmYUDtsmqQc=;
 b=wvcctkphep/mRZFiwl7nuKof4QLWtX6qU5z6kJ88KwBLhDt4jbvim35yqRdwSTrRlHzTfK9KfV2H2qB15exImMuyVcqkCC/N1KkyyE5fSUQ72nmvp0IqiOixHYiu2N6Xjv9X7lenPHZdZaKnViXXbsI1q7+8Xxb+ad/S7JFxc6JQVUdqQFGDBhC5A+8gEgnzJ8xwVZif8qXCvzE5pcxRcn1CmxRK/giOhKmAn9YzDtBoaWf0r/uIoEsNc/TdIsJ6+xEkoSUHZwLj9iVqG2LQ6fSKPVQfGLn7L/gVqk7wFYNp9d8sZmczPUrVfK7iytCWjo3qdXQS2cheZkqBE2breA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP9fRz8EfWmTwdl6datV5Ul8uq3KERitBmYUDtsmqQc=;
 b=t1j9mIJul/KW53Zn1ZMVYo/27yP8CuqTV9eKxQRPRmP7bmifICSnp4s7gIEFNC9c9z7O+ggz9qWmgY8t2ZwIOkZlHnSiySDtP3v6yhwnNvuhcXcm3ww13v9wlQR84lWMONT8yrE2O/u/OreZO6NRGWGpzfCK3qsJJBD9Su5Sw46dpDxX0LQhrPpSv+atfjRlrfY/lqaqoVG+APfLoCwkJnai2QyeLGQS1Jm1yznaRiUYSHlDPx4e+p3a074G1AYP40ABHJFE8logxfqvcFj1NUgXcCr4g28jsAcjSjssuda/9rHfYhublDPc4WId6cPGoJ1QmaYEV6qpQBNRnfdT9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:21:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 00:21:32 +0000
Date: Tue, 3 Feb 2026 09:36:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 1/3] gpio: Add GPIO delay driver
Message-ID: <aYFRE69oIA9Dk1WH@nxa18884-linux.ap.freescale.net>
References: <cover.1769086229.git.michal.simek@amd.com>
 <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
 <aXxb7L03qQ3jdnuT@shlinux89>
 <de5823b9-2214-47ae-9b4c-77cd413e34f1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5823b9-2214-47ae-9b4c-77cd413e34f1@amd.com>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ede489-0e78-41dc-9cfe-08de62ba2eed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bqnQf8nd/N0ItxdnIUdmKlRYVpgrU7KMjrLR7HN2vOOfH+ws5XesZwmHIA2n?=
 =?us-ascii?Q?mx0EuSpC7OM5IJfUqnX8Ip2E+M6wyaZ/CF/ax8RflG604/j2emK1+B2N/p7T?=
 =?us-ascii?Q?KuJRWta9WPUnM4icxWo6bVAaCcKeTMBHwDzBCNuS4duJJN6dK/RGpxUjknLA?=
 =?us-ascii?Q?L91W7RFKJ4xQDDClyB+8Jm5mA/icYyLPvHiTEjQIt0pWvd616qr7al4ZyAA5?=
 =?us-ascii?Q?lcVLIssUJm6602RhfyeE+ZNoEGKlA78da9oMiXI5ZAZQqtOs7m2s0UN7mN6X?=
 =?us-ascii?Q?sYC5xHamLcGVcsRgchFKeWwLEwhDFPJmMmk3VpcUAPK0bmRPRn1MQveea9Iw?=
 =?us-ascii?Q?ZF8DlTgUb8HR7tG6XID2VaxeQLMMnwuCj+2GUdorzCOBv5r98fq78EYlferA?=
 =?us-ascii?Q?wleRWGcdBmZ7dVYscCMuBYczLEKAEwqUZ/sE06jYJJlRwSbGarywHvY8y4VP?=
 =?us-ascii?Q?2FSM4toLoJlT9cVZ5FGugC54drBl5r1SFaGBovZcIcqAuZn23T7RM+No9ql8?=
 =?us-ascii?Q?MKNHFup2LLZBQJpdF+bpLZ7HDYE3Ye/0MbfYpy/0cJrQY3+Mh4jw9gKMkvnt?=
 =?us-ascii?Q?F1TKsPj7h73NIV6T5JyCZP1j1LP6q4l0WHta7Fv3qgQF2qSbmmHz/D0mGpsn?=
 =?us-ascii?Q?CWq+cevvR8xETr7Rgw3Wr745Rgf7qgowl3i8KLp5KZE5RMLWUJb2DKK3wB+0?=
 =?us-ascii?Q?tRk1PZrvgt+DHjmjqz628gfJvK8GgQ656Uelz8QjKNNGDJ6zIRv9XjjlXrZs?=
 =?us-ascii?Q?OSYQ2bhWKJgQDXBYr2TbIGZcevmrjdsNaC2P2cmY68/i20pzVgjvTwrZUzcj?=
 =?us-ascii?Q?nqm6oC0ZtrRrwzc0/efLlzYhXHbT2m4dk87VQBw/vbV0yaN4lZh26+MhGKnU?=
 =?us-ascii?Q?PQ9JzBRMZpCMlBe/a/1MbJaxAbF1U+UD0PspzPw3eyML7Ihs+D21U1sSXbMH?=
 =?us-ascii?Q?kvSQ1S58KrBQIEXI/Ztm1W4BPz8QqrVn/gvngg6tX9nQPLVnU0w3u2yB8+SG?=
 =?us-ascii?Q?nEOy++igsohGvCa2xQhajFGmCa4agyj4Fs7UthwfMyoyyFotHeMeo6HJawnz?=
 =?us-ascii?Q?gJMh8Paqt/m0S4/8w3bTdOpq3BEo2cDpbK3u5TVBl+K1lSkMgnbXbRgWDihM?=
 =?us-ascii?Q?PTLJi4LQ7t00KvaWHQ4M1YAQK/p9eTh3LOXjuX9dmFa+hG3dW9eG6KCPlFQs?=
 =?us-ascii?Q?9u/Xdbt6erSQ0Q8xOIrkMbuLcMlyRCT7GlilaaUfGisxYzso6AKgI7Jj5e9l?=
 =?us-ascii?Q?AEcWIw5mBqvQVdk5PruByDHBxQ69BP7nVOJG5o3VsbzkZ3afNp8VVMLjvFIB?=
 =?us-ascii?Q?qujBTmJrlpp3oyRDstbZrigcb66c/5FkWnDNyepcMNiAJi+TyJyFxl7/qrWb?=
 =?us-ascii?Q?Wh5NCsGl7lqKgZ9eBHU+xdTJ7HsQ7YxnFJkZNjzLVcfLcCzIdgolBsC0X4Wd?=
 =?us-ascii?Q?RORJOrcxQEz4Yhr6ElC+OGFu+QvNES216mgsbzwKtTimS9LQ37+ahgUp1E1y?=
 =?us-ascii?Q?ngleYfcrN/WqUC7bZbz/idPaTd+4iLqCvQFFkTtv6WsOm/LK8Q6Xdgwraly8?=
 =?us-ascii?Q?6ejBFeBm2b60QYkaVcR5RHnNBvFy5GR9oYN5zaVK+0f67ieLjhLfhW/K63AK?=
 =?us-ascii?Q?MhAxMvXm9/ei52MogZrQJYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wewOAfWETlZSxoAeXl0GfGQoY+bGtYGlfMu0ql+trIQN1YwQp9t7yxb2DtZP?=
 =?us-ascii?Q?M6Ells6Ung7rhwz1Ho+kqowmNDOhhD7uPimcPqrzP7O9rb1wSMMFwBvmDN1N?=
 =?us-ascii?Q?8AvFtYQBxOX3Chvsd8h/oeizm+0P69z19p9R8WfC884EPC8bfx+qPaDonfm7?=
 =?us-ascii?Q?dRPf3Ez7AjMIhRfgGCNcJNGhD5E5HVZCfF9csfG2A5MHsHoZk7cEBvwpTSoP?=
 =?us-ascii?Q?ro41v4vtoJnw74Fe9uCvbjqHBeW9Ykk2W0Kn6GwB9xpxLvEh5lAL+8tJ4CiT?=
 =?us-ascii?Q?MkC3QSWrzoEHxJWOC3RP8rgFgXwvvnzABADv/bEk9mN9WIg7ON0Yt1QqWXxk?=
 =?us-ascii?Q?xVKmWVDNn+OeEuYKrgxHg819biuOipmyKnduyWgwsDn/LYUd2arVY6ih83CJ?=
 =?us-ascii?Q?pB9XefzAdSBy9vwjwPrBwsw55tvGTPsROzcb7Ybg5vuDCifq26LOWtIs8bx0?=
 =?us-ascii?Q?XZu/xBuiE4TGcoWJpi6nQveFYK28EDH9Kap7UJyQQfMljiHjhMECdhyCULpB?=
 =?us-ascii?Q?pHIRHyKlgMvLgMiSBFPA/enxnYlU1xGORZWvaaWh/uylFNbQrlKhVoBcnVNO?=
 =?us-ascii?Q?t2AB0LFlZ63etkkmkE+t2C9760Q/vhq/hj1xYm/QumMFcnfTvCOakGPWpTz3?=
 =?us-ascii?Q?kO3ES/TSlwLQCKxr6eLKsllhTDi1xWcL5OhxHNC238K73+Nqxf2LL1XANcFx?=
 =?us-ascii?Q?g6RkwEgGnySFhYT+Ml8gJZI1fu7lX/DYMmEcSjujs/HCrXxnUTdUSoc/Hk1X?=
 =?us-ascii?Q?R8MH7h2KhHSHqHMUKB5TxOfI4UlTUQRqr+vFbuO/L6xeTEkORKTvfYPpkq5J?=
 =?us-ascii?Q?mdNJf2AHf0oM7+vEzUaTa52qW/Rw/GRwZ+pXAGnZ3o1HgAFiEch7RV+GdBgE?=
 =?us-ascii?Q?Aak5qs26/GiuVGxTttUGC/OldpooQTecFg6HwswbizKHb7R1MrdU/eR4X4jf?=
 =?us-ascii?Q?RhuOv5LDLmn+BnyRKz8K/lTpSZWJVVLyCvUfeaQYY90S4rpzoQ6e0zpS4wtE?=
 =?us-ascii?Q?euAmPryHMwcgEJ7HpsZkM5fLz+dZklz8s4UzizVJYTyuiV2ZCc2VYgQW4UrB?=
 =?us-ascii?Q?IaiIIbk0fKSXS2GfQFygLls7D2ri8mpGT1lSdiQJbriPYjO0LTB+kg4N25nC?=
 =?us-ascii?Q?BZl0c9AcbxGyzevmVtQJGYIiWSB7oFmhmo/Gk3PskkRGu9wsKQRncd5XvkMh?=
 =?us-ascii?Q?GpTIuQartQ/nHgmvlKSG347LiAUfDUveE5VQA+09mBS7jXeCOTxpfNRB6pWW?=
 =?us-ascii?Q?4F31nQItv+B9AnmcppXS56zo1zPEUl5hTdziU+vZVvo+fC+wD1tMBVjb+kBN?=
 =?us-ascii?Q?FshhAscoaKS2XGNUhAwsyAJRDJC8tdmsLlI+u3Jznubfg0d2vLVJXFarNo2a?=
 =?us-ascii?Q?Hv6VFR3zzFDRZ5Z69tNk/FiUpu/Zd6fRKxb+8D6XhUkteLpbyhRNPL4QIdnJ?=
 =?us-ascii?Q?+PYkKeV9+quNqpJh7LrWWLE1tvXzfOzBfuYwlVCb9CIOqX5dpEHB/GWYOHzM?=
 =?us-ascii?Q?+zZuP2wYcPBEeh+9u/5QJMtBs99Nie5YTwNHmIB8eBjz+cGZRdpZyr4tHH+Z?=
 =?us-ascii?Q?KMfSoJDYxnPG7wiuqjPW21nZVEazfsoeyfT5RlFtcTZPa7001RfvYb3VsfwC?=
 =?us-ascii?Q?nOd9IT/V+EY7kOiBdO9dk6hL5/9uIpt9ovWzpDecCXoEzYyVP0ayk24qZZts?=
 =?us-ascii?Q?3uMEMTx8TR8gc++2D6dx4KjDwrh92hPSypT5MmnSXWmmixxIGlHM6p3yiLyL?=
 =?us-ascii?Q?VZfK+PXtmw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ede489-0e78-41dc-9cfe-08de62ba2eed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:21:32.6785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghwPj8mxMPzTHaL4OHKlGOBrGJRC03/0TtHIRsJbgnzf/dOouWXHHSqssEnl8gIJrUW7SkdJYeaV+j3pF+l4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762
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

Hi Michal,

On Fri, Jan 30, 2026 at 09:29:49AM +0100, Michal Simek wrote:
>
>
>> 
>> Add an entry for SPL?
>
>Why? I don't have a need for it and someone should test it if this should be
>used in SPL. That can be done on the top of this when tested.

I see. 

>
>
>> > #
>> > + * Copyright (C) 2025 - 2026, Advanced Micro Devices, Inc.
>> 
>> Drop 2025?
>
>Why? Driver was developed in 2025 but upstreaming happens in 2026.

I think the year should start from the day of upstreaming. Not sure.
Tom may comment.

>
>> 
>> > + *
>> > +
>> > +	/* Request all GPIOs described in the controller node */
>> > +	for (i = 0; i < ngpio; i++) {
>> > +		d = &priv->descs[i];
>> > +		ret = gpio_request_by_name_nodev(node, "gpios", i,
>> > +						 &d->real_gpio, GPIOD_IS_OUT);
>> 
>> This will configure the GPIO as output and ACTIVE high/low flag will also
>> be used per my understanding.
>> 
>> Should the dir and value be deferred until set_value is invoked?
>
>It is clear that it should be output because you just setting it up later.
>But I don't have any issue not to pass any flag here.
>Please let me know if you want me to change it to 0.

Yes, please. Configure it only when user request.

Thanks,
Peng

>
>Thanks,
>Michal
>
>
