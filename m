Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE51CE8FDA7
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9F2839DE;
	Fri, 26 Dec 2025 15:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xNOqxkyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01AFE839E4; Fri, 26 Dec 2025 15:29:22 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0548D839DD
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw6xQ1WwAA8GRVYJAtQ2guuEERnobpmOYjWi6X7ZASptEGi5LtsbnuffeCrDwmrRcqKoZJdHnYQg7CiJPZVKgmxCtTgR1rlgpN94IkxN9xVjOfHYb48btCBC0LL0810jyLbLFmyunH7DjShDCBLWflrAnbNpoGwUTj21XdpLsmi+5celohYU5jpuSlzevBIfGTQ88FxCRTLmC1ruT3QBckUEsSg/oNrqLxZ9OlT4qzzMAGjcJrUoG8o8aojLCQJVZfvSkFALEVHChEFhMVEMhquGXabgdk5Rbyl2bHccfPNJSWqv1rM7sCCJjvRVFatW+Nk6hpZPYjtOH0gp7Fy41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djGWsS2xedWZntaoG8S0PTnHEL8rkMlVcy94+hcApQA=;
 b=zDcWAUhMxp6cqTE4I49Y9pKmByfNNKP75r9FFqu0oYANYUY+2hMHgp8E6NKy1sW1QtEjj8wf11NzCMurda4kVHCLeyMXyS/01U1iQd0pS6w8+ulEK+KTEAHyTgSdc5lZiF/QwkeuzAsaJygmiDoeOYApltFVol2/CoOkQR+ZqquWZW2ntJ1JWuoYPhY3yDPFYhJ4LA9c/T7MCusHUx3AC2b7yBbYRLiNOxndLjwt8JKjKkWah+QxqMEU7GLggUcL2vGac1Vd7/s5kpDzf+mdsFdofLVDiKxz70uulcUKuDJBwzpAuLsqmDdJWldHcJk9TshdZ77EdKfNjUPQzwcCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djGWsS2xedWZntaoG8S0PTnHEL8rkMlVcy94+hcApQA=;
 b=xNOqxkyu6B3j6Tg/SWK/UsLWhixfDJv0QhcEZwh7WVoIG4Dg4RqkcrIxWiOK+CSGa/Z8afN7VuXfCxq3kmSKC9azlpxq1Emt6qG1a/wrwMAtQ7TWTcoJcv0Htj8yaSzfDQB7jC4yYAsZKYTLoBROla7hdeiXX6cxbMlBULCmUMAdiOm8Pj/ZK96zFQ+OOiXxvsvu80BTXB+vGK+lrhpwICvg5H0tYdOEi4t9F/IgPF7CSstsn10CKSw0pI/sO4ufPP+O4rM1ARrg0creL6Nr1oGnXhbdeSAGklWiziK7D2LwMDjwY8L7zHIvuy6vhnO+TQeJyFM53+RVmpKQWjW9Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7033.eurprd04.prod.outlook.com (2603:10a6:10:125::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 14:29:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 14:29:17 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 26 Dec 2025 22:27:43 +0800
Subject: [PATCH v2 4/4] imx943_evk: Enable XSPI1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-xspi-v1-4-4bb116750dba@nxp.com>
References: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
In-Reply-To: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: a8796c1d-dc7c-49fd-eb3a-08de448b26ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVJ0TWJWQTRMRGl2NW1hSnNVeGJhNmxBaXNIcHVsUCtjZkt0RFp1djI3S0Ew?=
 =?utf-8?B?clYwQUFUeGF6N2RXZDN6NkRxbmQrYStueVZmNkRaeXZXVVVTenh4dzRLd0tP?=
 =?utf-8?B?M252ZjlQZkpWS2hNUkFPWndwd2Jpa1kzcHB0REtQQmVNck5MTk9HMGRHMUhL?=
 =?utf-8?B?VGhRUGdNbmJEN3N5akQ4ZmkvS3hyank0dFVYempBbmN3WURkS3N4WFdRZFZE?=
 =?utf-8?B?aDRMR1UwVEFMRmdoUXZBazRMNkY3Qy8ycWhOYUhDQnhRWDhoRjIzbFZZQWRJ?=
 =?utf-8?B?Mk1LSGt6QkQ0Q0FMY2YwOEFzS0hnNEVlMENVbG5UMkVtN3psajRrT2lRS3la?=
 =?utf-8?B?SDIzb3R1UjFOVnI2MWhhN0RuNXpBeTlVRnVBVUI2WWh2bFVveVdEVEJsT0FJ?=
 =?utf-8?B?SEJDemxuSFZxVkVwbmJvVHVWOHFZUkFHa1Q0UXhxV05JeW9BU1Q2NVNXOUYy?=
 =?utf-8?B?NGdLVTV1ZGNjdDNyVGRURjF2S09uNjBQYjVjeGV1N3ZRRHpGUkk5dUZYcXNq?=
 =?utf-8?B?SnpRQ2Z4dEFKa3FhL214ZW52OTNDczNhNzIzSHJLRjZoQThiUUNrL3ViRVBi?=
 =?utf-8?B?Mk9OSG9uZzZHU3I5MnhJd1BRV05IbWpqZnhHZFUxSWRoYWVvQlE3Nmh1aDhS?=
 =?utf-8?B?OFJvZWNFNTBMWFdTbm5ZTTRPa3dQYW10WEE4UFBLUDI1Mno2R1pwVGNveDA0?=
 =?utf-8?B?NVpQZ2IrbUVlcGFBMTFmYno2KzBPLzlBaU1VcC81cUxaNVVONXdVRzVGWG8v?=
 =?utf-8?B?UDdPc013RU5hbmQ0UEV0a01ZdFE4dUFPUEl3QzE3WGNVeHBKOG1pNXg4WDdE?=
 =?utf-8?B?ZTljcGRSVVpkUUhRWWVBVlNoamQzOXYvb2Vnd0diMjF4WUs3Vy95SVd2Nklj?=
 =?utf-8?B?TVNkL0M2bXJ4azhJYTk3STVpODVDOW80WG81K2ZIbnRxUTIwZVMvK20vMHYz?=
 =?utf-8?B?TlRDODRpbDZBZkY2UGo4VEJZMVZ3c3JtUnQvZ1JVZFVvaHZVRUNuS3BwOFBy?=
 =?utf-8?B?OVZZR2FXaWlFNTJWZGtGZkt5bmlGWlhPaDRvaGo2MERDcjhUcnFMVWNpeWIw?=
 =?utf-8?B?U01ZbHIwN3h2emtrK0dRMm5iWnFWWE44OHlxNkRCQ2RhSEp0TDZJNUk0anJp?=
 =?utf-8?B?WmR5d2tiMGZUcmVUTWx2bnZQYllQV1g0c0JaVC9tK2FmdUxJNWtQVWdIaUJI?=
 =?utf-8?B?dm9kbCtCQmRmMHA3eVVmUVpkOFhFODk5T3c1ZXllamdVTlhQZFZYWnYyWlVZ?=
 =?utf-8?B?Zm9YYXhEWFRTTFRVZkpyMkRIb3kzcUNyYlZmc25pZ1RWUTdSc1liMi83OVZ3?=
 =?utf-8?B?UCtYMjFwU0lmQTZ4YUFYRlhNVDA1TkZoeGZGeFZJOG5udGYwRjVYNGhKbjNT?=
 =?utf-8?B?T3VxOWFxWGkwcDR5TDFEWjZBVmdaTGlSd2w5SlluZGRkc0lqaGx4ckxOYVBN?=
 =?utf-8?B?anFLUWZaNitveVpXcHgvOTEwdVg4STRaTzkrcXlOaFY0NkdlbGcyS3VMTHpl?=
 =?utf-8?B?OHM4TnRsNVlKeXRKNWcvRUFBTElrd1Fid2d5TmxBbUJ6M2tlZ2N6N3J2STNU?=
 =?utf-8?B?UVM4aXlJZ2xlV0hRR0JpVW0xVHVWSG1yK1NENkRPb1E0Rk5RZXVPODVJRG5o?=
 =?utf-8?B?a1hWSy9mMXkxVXFvTG9wYTlHdlhaNUxDZkZpSEVPMUNrNTNSUUdPeGw2TUtT?=
 =?utf-8?B?cGhWVG05aHNwRmtKMXVBcHlQZjI0RzZIaG04MUZXQ1lRNFVDQUxxMUNqeXJw?=
 =?utf-8?B?aXFmOEJEeFU2alJYY2dpRTJlOVJQM0ltVmR2SGMvYy9xTFFweG15RFMrbkpH?=
 =?utf-8?B?Qjd4YzN4TlBiYnE0TGc1S082a3l1cGZOK1VyV1pqTlV6MkhDRi8xRkRqQWpk?=
 =?utf-8?B?NzFMdDRtYUVEeXVObnlQSHRwQS9HSlAybm9yQ3pIYWdMSzAxTmJiZWM2MnVl?=
 =?utf-8?B?TXkrQ1V4R2VkMzUxZE5ubDJLbjNHcytmWUl1Z05xM0hoZkVwSHQ5YnVpSFRM?=
 =?utf-8?B?U1BwZUpTS0ljUnhMY3dGS0tyQUpyeExNY2Q1REdYVjBnMGx1bE80YTVGYzJI?=
 =?utf-8?Q?4WdZej?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFaWnIrdkJSZWJrbUNvMlUrQWZyRmg5V24vUlg3WFF3YXZpQ3k1RlQ4aE4r?=
 =?utf-8?B?bmRYUkNicXltSGFuUVVnbkFhTDhvZnNkZm5sREtrSXdobzJDbTgxY3lMTGh5?=
 =?utf-8?B?QjE3UytMR0U3Y2VSZnQ2TG5VZk9PQ1hxTVJQNWxsOW9WZ2JGNVd6bkpzUnJV?=
 =?utf-8?B?cTJWMG1xS2g0VVUrOFNkd1dIREdQMVdiTVdmYXdKSVJqd0w0dEhBazB1WlpS?=
 =?utf-8?B?dTl5UkZnZzhzWDRRUHlSN1BqRWxSSmZTaHBwT1dnS2tEemdHTTlvTVExdzdp?=
 =?utf-8?B?VWxMbDMxMFgycmRmWjYrWDh5ZUVSbys1S094Z25ZdkNwd2pEaG93c3AzN25s?=
 =?utf-8?B?dmY2ZjFsaENMKzBJOGZjYlpNdHgvNDZYakZaTmYrOWdyYzhnSGxzRis0L2lw?=
 =?utf-8?B?eU9zWjc3U2c3L21uMWt3eUdhZjUrdVhtWXppMnZoSHp3OTE4Q1dlY2xWUDVS?=
 =?utf-8?B?akNHU0hXM1ovYnE3NGx3enQvN1FrZThQRmpPNTVFakRJcFhZTURrSkFOL0tm?=
 =?utf-8?B?eVUyc0NWRVdhRCtnclRPTVlvZjJNeW81N2RmWEVyRWhMM2ZraHFyOC9xU0pi?=
 =?utf-8?B?UGtmc0ZpaEhSdkZmSnErTWN1MVBQWkZwRzR3RzQyUmM3VDEwWjZuVGdxV3dJ?=
 =?utf-8?B?REdoaExFUUVNaG5zUGFTa3h2SW90OWJtWXJwL3gvY2pkUEF0TjJUYmVHc21B?=
 =?utf-8?B?MnVSVE5LRERqdm5pdDMxU2p3RWM0MzErMDltSktqaGwvbnpMWitLdDhiODRW?=
 =?utf-8?B?Mm9FYjdod1ZKakE2WGllR0JTWDlIUi9BMFpkT1cydU9OUWJYZDk5NnZaWDRY?=
 =?utf-8?B?dzZvNFJtbldBUmdoMmpMY1N5cUpENFFOdFVmSjNtU3kxRjZHN0RmRlVGYllQ?=
 =?utf-8?B?SlhIYUJEc2pnZjJ5ZmhNcjZMRXdiQTIvN2pDWEhQeTRXSTgrQnFYSnNuejRI?=
 =?utf-8?B?NjY4VFZUTGJ0RENPM1lubE40SGtiTGdjN1NWbi91NnVIRzd2d05sS3VKSkVK?=
 =?utf-8?B?eHhOZE4vMERaVXBpMWQ4R0JJQXNCYlg1VUNHb0tRejZiTEs0ZjRYYjVHRm1k?=
 =?utf-8?B?YzVlWnVFOVdiQ0pPVUR6ZEZMMCtIQVM1T1pHZTIzeWFDRW4rRW5tLy9CWW9j?=
 =?utf-8?B?RE5wbW1IWDIzS3NWbDVuVHdWdGxNbkNNWUc5OGFiS0pHaWxNdnJWRXFyWUNr?=
 =?utf-8?B?MERKZXlHRG9JVTBjbng2c3VtZ2J2dktiWWgyUmUxbTV2ZFdRaEJZM3JrSGJL?=
 =?utf-8?B?ZnM0bWMyQ3pJQStzZlhla0puTjlmYmFQNDg5aVpQR2Y4M0lxbmdxajB4bnI4?=
 =?utf-8?B?N1BwWm1MdzM4aE9EMWdYelQ0WUQ0Q2hNSWZJcVdHQVZ2Umx1S3F5cktHdTVH?=
 =?utf-8?B?eUVTTmErYWhtenRjUlZPVXhHVUdaTUU3dVlpeHZScnVYMmhxbE9hbjBXdEU4?=
 =?utf-8?B?ZmNiQ3dwZHVSNFREd3FYQ0RJTDBGd2JCZGlNT2F4NExqZGdWQXhDaUt4NHhk?=
 =?utf-8?B?Mi9WNSt3YUdHK0c3VCtuVk5JUHpvSjBVcmpzdlA0bWI5anZPSFk2aERMZ1RI?=
 =?utf-8?B?YktjQXlRd1lnTzlld1JHSk11WDhBV1VqSkdxWjdkM1g0UjZrZFAwNWdPaWNN?=
 =?utf-8?B?cVAwaDkxeUFGbkpZSFVsa0g4S1I4ajVsQ0pvZk15MSt3WjV2SEFMZVRYRUov?=
 =?utf-8?B?ZU91Ynloejc3UEJyM05ETHFLTzRNOE5JOXU3WEl4Z2xaT2c1dUpUUW5iY3l0?=
 =?utf-8?B?OG53a1pDekNSTWh2TWtpcmE4Sk5tNXlCNXdtOGw2RGNBcklJMzlXYnhMV0p4?=
 =?utf-8?B?a1BMaG4yd1JwWjhrTFlGcUw0Ymc1NXZRQXFpblRqNTVEaUplclRVZDhZNzRY?=
 =?utf-8?B?c2RHMVhOUE94Rk54R1g5QzY1SWxHc2pDVFZHMUNNOE9xM05KbVJGNlJMejg0?=
 =?utf-8?B?cUZEY3F4V2dIQloxb2I1Z0pJY3A2R3Z0bXYyeWJ3cXlHWTl6VE5JMVBXZlFB?=
 =?utf-8?B?a2xMazV3RnVSUWtKU3A2dXlpcFlPNXF2M2w3bjk1ejRnUUNVeDZINWZFb1NX?=
 =?utf-8?B?OXZ2Y082ZUozSnNXaXJiaFNpVGVUc1ZjaGdnL3JRemNxdzlFZ21jeG9VWkxX?=
 =?utf-8?B?TCtZZDA0WnVrUWh1Smpoc0liWEIwR3Q4MGZub0p1dVdSbmRBMVF0c1YvcWs1?=
 =?utf-8?B?eXh2UmV5K2tyTXdjVDhqU21uSndhbVdpUk9Cb3pBYzJHck9ocTJGS0N5T0JL?=
 =?utf-8?B?SlB1bmo1aEo0MnI4YW9wYk42M1E4YTZNSTNKd2xEcW8vWXlYNU9ES0syT0JM?=
 =?utf-8?B?NWZBUTM4clI0aFMwYTB0SHcyeUlHR3c1bStzTzI1YVQ5bE9QSkt5QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8796c1d-dc7c-49fd-eb3a-08de448b26ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 14:29:17.8566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmCGZDMkFkwSqDQQfemCUipX22dP2I1SkOBAgRazUlYGlV/GGtggtpIbK8jkIpY8QrmVYw/Oio3or0OdNu0+kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7033
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

From: Alice Guo <alice.guo@nxp.com>

With this patch, XSPI1 are functional on the i.MX943 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 16 ++++++++++++++++
 configs/imx943_evk_defconfig        |  9 +++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 528b3b02a3f..247a7ed6838 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -157,6 +157,24 @@
 	status = "disabled";
 };
 
+&xspi1 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_xspi1>;
+	status = "okay";
+
+	mt35xu512aba: flash@0 {
+		bootph-pre-ram;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &scmi_iomuxc {
 	pinctrl_emdio: emdiogrp {
 		fsl,pins = <
@@ -205,6 +223,22 @@
 			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
 		>;
 	};
+
+	pinctrl_xspi1: xspi1grp {
+		fsl,pins = <
+			IMX94_PAD_XSPI1_SCLK__XSPI1_A_SCLK	0x3fe
+			IMX94_PAD_XSPI1_SS0_B__XSPI1_A_SS0_B	0x3fe
+			IMX94_PAD_XSPI1_DATA0__XSPI1_A_DATA0	0x3fe
+			IMX94_PAD_XSPI1_DATA1__XSPI1_A_DATA1	0x3fe
+			IMX94_PAD_XSPI1_DATA2__XSPI1_A_DATA2	0x3fe
+			IMX94_PAD_XSPI1_DATA3__XSPI1_A_DATA3	0x3fe
+			IMX94_PAD_XSPI1_DATA4__XSPI1_A_DATA4	0x3fe
+			IMX94_PAD_XSPI1_DATA5__XSPI1_A_DATA5	0x3fe
+			IMX94_PAD_XSPI1_DATA6__XSPI1_A_DATA6	0x3fe
+			IMX94_PAD_XSPI1_DATA7__XSPI1_A_DATA7	0x3fe
+			IMX94_PAD_XSPI1_DQS__XSPI1_A_DQS	0x3fe
+		>;
+	};
 };
 
 &pinctrl_reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 2b93ba9a38b..3457442a3b0 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -141,6 +141,22 @@
 
 &aips3 {
 	bootph-all;
+
+	xspi1: spi@42b90000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx94-xspi";
+		reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
+		reg-names = "xspi_base", "xspi_mmap";
+		interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,       // EENV0
+			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,	      // EENV1
+			     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,       // EENV2
+			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,       // EENV3
+			     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;       // EENV4
+		clocks = <&scmi_clk IMX94_CLK_XSPI1>;
+		clock-names = "xspi";
+		status = "disabled";
+	};
 };
 
 &clk_ext1 {
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 0371dbe28a9..04ac97c1b49 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -108,6 +108,12 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
@@ -128,6 +134,9 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_XSPI=y
 CONFIG_USB=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y

-- 
2.43.0

