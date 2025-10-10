Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EA5CCD187
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 20:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9678584042;
	Fri, 10 Oct 2025 22:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="hmG+K5Ms";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="hmG+K5Ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41019841E6; Fri, 10 Oct 2025 22:55:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE8984042
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 22:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Fo2IA3I0dChssJxJ9ajHzvxUcXVpSZP/UIKCsfm7go6T4XJUa3z4JHyV0gf56RLPn2z7h4ShAyU3kuyZ+soDdbXxN/crp32lom1xpTOqJRf1v4mTbJYT2QcYt9DgCRKPv+P9TmIp2IOMNRiULKdN5QDe7zh+UQCwpA5MtUyS0PVuh/o67jFhHn6HUfiCZ9+O+MmYhkSt46P6APuSPRfb6S2gNCOjiil2hOe007fyKcSOyynu7NcaANYQ9+fDqssylDf0KWwDSlkf8B97qAftOshLONPzPy1ffdkHEl9iZAQGUdTL3tL9hUHNW+d3E32yuruIj5vllzhvcIvAD6JZEw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5FOVvnlQPUj9LQNLsXd/amPJ7fNLPMosJHTclZOak4=;
 b=KcQaeDp2yZBM7S7zL0NzWim3Qb6ghZ+kp3Y/eyzbSN1Gemu5SfJmithXpRahsGyvSpIX65O6FWcU2IjEK3dRejLDnVT2e7p7THlnEkELRRTsmeTCdbO43CvxBgHdorfEkk/7XLYLQir/MnYJSkLvwJ2W2ng12WQEEYJJtqNUIF2Hgp2owu50q3EWtKFfjy73fIRN6B8jtRn/ml+q6FU/M16xT3BL05hDf4YqUpihl8O7AmfODwI4aoY9QVgebsHdBxZK0eIV2mM7idEaUJN+GzXu6uyFxj1i6mFE5TzwjCK0+de9o3un8qY86OFj5sde0CWmNqiLgLR9gPa3Q3GZuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5FOVvnlQPUj9LQNLsXd/amPJ7fNLPMosJHTclZOak4=;
 b=hmG+K5Ms6DvM73PwerOOTeQWMk5pcNekBfSjbWZ8ZIB/61SWyoWJDkrDmkrYN1W6F5YqhmZNRVeBSNUYKP9+N35jB8agBkCCILIwPu3/Vh0J9N64+UYg4+LvtcSLBe8CyyX9/NS6VhULGzsT8luGQnyP1Pnqxk+Ugo82p9OC77EaF5IMtlzKjGagOgehcz4MQaKdEdzPPLk45pcSgSIiCMqGw4z99d2zSyC0r2AUAds+8NAvqmVPvt1yyNIiBqAKcUubKK75Gt9WLg3Z1sIpvgpLrPAm6VBI4yjbGBqtPqPh8a6Af4Ba/zt+6cYf6FCOsD6OrN0W5WTZHc9xxGzf/A==
Received: from DU2PR04CA0353.eurprd04.prod.outlook.com (2603:10a6:10:2b4::13)
 by PAVPR03MB9847.eurprd03.prod.outlook.com (2603:10a6:102:31b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:55:26 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::4e) by DU2PR04CA0353.outlook.office365.com
 (2603:10a6:10:2b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 20:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 20:55:24 +0000
Received: from outmta (unknown [192.168.82.134])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 1B10F20081625; Fri, 10 Oct 2025 20:55:24 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (unknown
 [40.107.162.73])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 911ED200C4FDE; 
 Fri, 10 Oct 2025 20:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+NWlF05fYLJ5DdgeYRPuxWm/aA8tWmiPMLA/xkSBh3Nqa7mHhs7P5KpaiKBRTdxzwf0qaAwCGVB13SxKcq2znta8ZRL8ae7tmrWdpvfPdlxvwTYM9FAqcQHTYdt5l3Wm9wtLdY73fHfBSw2I9uOx7bIgAwrOeUujxWIZHSbmMboZp2YOWG6m7FYguxVGtSI5aLa9pk0r97NCU0YnoBnWqwzrSyXudfzXsYm3yFIkh+RibkIeYVytPGSPzw4RCl6R4QOha+iHVqs46nc6uET3rgbKK6o394Ih9svDeWopQvaJZtngfInIEvrUZCGKualcoQnUdy54CUrZcgWD3QqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5FOVvnlQPUj9LQNLsXd/amPJ7fNLPMosJHTclZOak4=;
 b=BGvd3PGXmBvyNrpCy0YdYr2djpo5HNQ9EMeWz98sl9FFgZ6gRqp340IF8n68heHh72Y4UU2lpctImPfiUkOlOierxBbvc47x+6MxNyw70Lh8Ae9vAdjUGStshI4qMyWI9QLmZaLTlRHq2O3nG30B6jytoFBpzYQHhltwPojA0DUZGVpAgycn0FCwAXM+lwPWlj8hWVdeRYYuzVrZpO3OY9MZz1eALM1dSu+hPmKi9AaQ45v/PlzbaSi+/tIsA4jHSdN46YDsU04UX0+Vrt3aD/cTvWhGL2y0QlF4WEDiOSzQXmHKYaxMMz1K6mi0mqB+xgUimwq30CxxVxEqidmzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5FOVvnlQPUj9LQNLsXd/amPJ7fNLPMosJHTclZOak4=;
 b=hmG+K5Ms6DvM73PwerOOTeQWMk5pcNekBfSjbWZ8ZIB/61SWyoWJDkrDmkrYN1W6F5YqhmZNRVeBSNUYKP9+N35jB8agBkCCILIwPu3/Vh0J9N64+UYg4+LvtcSLBe8CyyX9/NS6VhULGzsT8luGQnyP1Pnqxk+Ugo82p9OC77EaF5IMtlzKjGagOgehcz4MQaKdEdzPPLk45pcSgSIiCMqGw4z99d2zSyC0r2AUAds+8NAvqmVPvt1yyNIiBqAKcUubKK75Gt9WLg3Z1sIpvgpLrPAm6VBI4yjbGBqtPqPh8a6Af4Ba/zt+6cYf6FCOsD6OrN0W5WTZHc9xxGzf/A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB8571.eurprd03.prod.outlook.com (2603:10a6:20b:548::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:55:21 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:55:20 +0000
Message-ID: <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
Date: Fri, 10 Oct 2025 16:55:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
 <20251010203134.GA1187059@bill-the-cat>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251010203134.GA1187059@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::7) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS8PR03MB8571:EE_|DB3PEPF00008859:EE_|PAVPR03MB9847:EE_
X-MS-Office365-Filtering-Correlation-Id: b140ac76-108a-45f7-92cf-08de083f5592
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?eVE5Rk5wMmYxaU56YkNNQXRDb3kyNDRqclg0NUxFT1dEditCeHlwTkVKOGRr?=
 =?utf-8?B?bmY0TVNmN0dkemdIUkxPWlVyY3FPWUxWZXFpMTIweUJMSjZsNEwxaUh1Y0VG?=
 =?utf-8?B?TFB2V3BPR05IWWR0UmRpWFpVaUNrdGpGZEtwSE9kdXByaktoTmJVb1hrQzRZ?=
 =?utf-8?B?aEZSNWRWMXdTaXorckQzMzVJZzVMSXRQOXdyVTh5bkUrTUJVdzN0c3JITyt2?=
 =?utf-8?B?NlNreFh3dWg0cUl1VjhDcjdIRWhoa0VMNVd4c1UzaC9CeVBpbHdHL3BCOHRE?=
 =?utf-8?B?NVdzMnRaYlAvM1ZnMWtLSG1nNWVkNWVYRmFOTWVNYXZJbVJjZGN4a3VCdzhy?=
 =?utf-8?B?Y1JsY3BMZjhON2c3eWZXaEV2OGhHTGErSVROVG01dDhRNFlZTVVYL2NXT0FD?=
 =?utf-8?B?OEo1TjR6U2ZtWGdxNVg0TmE5NjdqMVpSTFlIS3lqUnVOdnBkeWJPUFVlbGhB?=
 =?utf-8?B?TEc5bDdZOHdxQkIzU2VJUjVhamFUWndWTFNUejZMUUU4a1hhSXpJMmorZFd4?=
 =?utf-8?B?b2IrazdYVHloemJzZzRWbEdnNW5JWUdjZ2JBb1VqTXBtSXA4cHVuenVJS2xD?=
 =?utf-8?B?YUpUQ1RxdUtWR3oyYW1rUGVIbVRTMnFaZzlwN1lJVFZIOElldFI5L2hwekFJ?=
 =?utf-8?B?cEY5aGVFb2JzUFozK2lzZmI2a1I3M0ZoVFpQSU9ydlB3WTVBKzdSUmp5anZw?=
 =?utf-8?B?SXk2V2Irb0dVeTlwUGJ0VmNiaWU5Mis2TDlyVVdOMXFkVEFzOEZ3VHA2VTZy?=
 =?utf-8?B?SkZWeHhLWVJuRlgybkx4Vm12QUlCaFpRZUpqbVJQUDh4SXI2K3RXOXFhdkNC?=
 =?utf-8?B?Y1o3d3dRTVlxQytqYnJTd0E1MFNxZU1IajRMQTBvdFM3eTNoK0RNbXhFTU9u?=
 =?utf-8?B?STBCK1R1cjB3cTJNZm1saEpPN2pQNjM0SVdpWGVCYWFES0NkN1F6S0RBY29w?=
 =?utf-8?B?b0IyV3FGcVBLU0pqbm5MTS9GTlpOZ3RhV1FMNmZkLzAxVDY5V1pYbFpYQWZF?=
 =?utf-8?B?dkVUVG11Rmxod3MrTE5KdUdtU2hHcTQrUVBra2IwTFFQSGZkMmt5SVZlNFkv?=
 =?utf-8?B?UG1hYndySHV0enUzR3MzTEFPNjZ6TVl5ZTBjdXh4WTJtSlRQVmw0NEtqWFBl?=
 =?utf-8?B?UXM5cXN0Y3VBUXNqK3BCaVpsMWV5ZktodDZYdndldmh0aU4ybjM0NnBCWll5?=
 =?utf-8?B?QXo2bFh4b2txa1hNcEkvN3Q0WWxCOVkwd0RxTFliazBTak9GSW93WTNuelJN?=
 =?utf-8?B?RXk5QUg0U3JTOW5aUkZ2SmRpZzFoOUIwRWc1Wll0dGhFRlI0aVhKOE5nTXk3?=
 =?utf-8?B?WERKemM2NTlNMTliZHAvMlZXdDg1Q1JXMXA5QWxzRnIzZE9QeXBZK2NQSURm?=
 =?utf-8?B?NUo5SGVDa2g4WjZ5TkZwUG5zUlZvMnV4S2wwRW5JQlgrTVB3SVRlS3h4ZEJa?=
 =?utf-8?B?NTBKN2hwcCt4T00rN1JtMzBGYlgxaWd6Z2pzMmJaaWhTWk1XK2wyTDE3ckcv?=
 =?utf-8?B?QkFLZmNaSlJ1R3JOU1lIczFvbHNJMm0xc3RMaVFsWi8xMFRlS29scUoxU3ZX?=
 =?utf-8?B?cDRNck1tdnBmcXBmOWVtWGZXV0d1UVFheldSU3g1VDVGOHkwSWFSRlpPQ1VX?=
 =?utf-8?B?SG52VjQ5VlM0ZDZFanlldzdoQmplWUo2SzNHSjhxa2ZxNFZMeWtqcnd3blJz?=
 =?utf-8?B?RVlHY3hqZDNiU0pIS2pKSTMxRWF0UlZvY3d0ZCtiY0ozdFZUNnIvczZDQ21O?=
 =?utf-8?B?Zk03NU1hQmVkNFkrSHJQRG4rMzFFcUFBamFyaGZzZWlLNW0rMkZzaDdqOU43?=
 =?utf-8?B?amtObkxJVFB3ajNJQnI5bnpaNWJYazF5cnFHa3NVQnhFRjNiampLSGp6cXNF?=
 =?utf-8?B?Z2xvbzVxajZmRmNoVXJFOVRuUmNGMk1Jd0lNRlExNXNUZjJ4Tm9iVGVUdW4r?=
 =?utf-8?B?TDJwM25sczlIL3d6MlR6TmdsVy9rMUxtR0QwTU5IUEdtdVRLam5Lam5EYldP?=
 =?utf-8?B?VVJvVW82YlJRPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8571
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 35597117-4e6c-4637-59b2-08de083f533a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUdNUDlwcjZxYlJ2cWRKNU1EUlNONzhIdHM3cCtEckhobkxtbkZrbEJBRFRU?=
 =?utf-8?B?ZytNUnQrdmsvaTBML1hJVS92dTJMUEtFUnhiMmx1R0JwVkkwbk1OR0NhVkxi?=
 =?utf-8?B?UWgyZ2FPa0U2dWtSTGE4ZUxYVEU2Q3M2WGdZeDI1UFNMMmlxcHdWVWlPTG9Z?=
 =?utf-8?B?L0dvZjc3MlpkeFRSNlYrRHRUcTJvTERoZ2dkLzZDU0pGS2xnS1FNOUthTTh5?=
 =?utf-8?B?SW5OOHdldVcxWDU3RlpzZTBRRG9QTkhvMGVkTnpUL0kwaC80MXRwSDcrUGR6?=
 =?utf-8?B?ZmpoeEM4RDY1TjM2NUNoMk9JaE11STRGeitHMXlEZy9QTExES2dLR05FSFFR?=
 =?utf-8?B?b20vZE5JdDBDRmxFU3NlU1FxY0FJc2xKeTZPc2xSL1MySUxYb2ZpNjJrTzJt?=
 =?utf-8?B?d0M0R0FDZndiNXBFdjcrU1dLYmZwR2pJNWVkSExLOWUrbTVGSW1qWnNKZVBC?=
 =?utf-8?B?WkVzMnovNk5qa1RwaSt4azUvd3Z6a01aQVVXeitzR3RqcjNRbjhjRG1wNGhT?=
 =?utf-8?B?V0tEKzlVdk5NSGNuSVRxRmg0bnRUVHY2UDVtSjRYeFF3dDAyVXI5SzVQcmtk?=
 =?utf-8?B?SjA3Tk9jWHJQRXE5dk00WE42VTA0Mzk1RUlVWnoxNDR6QjVOdWprQnhsNy8v?=
 =?utf-8?B?RGxqN3kyTjU5TFlIM3hERmZNS21lVWxLb3JTT1FMM1M4N1E0VjN1SVVqZTVX?=
 =?utf-8?B?aUQ5aXNkcG5BcEt0c21JOHZjODNjR0R0dFFjUWs1T0ptTlR4RmEyRXBiTDJC?=
 =?utf-8?B?Z3J5Q3ora3N6d2JKaDE0NmY0TzA1a2xoQTlKUnBjdWtGUUtNamR1TVV4QlRk?=
 =?utf-8?B?MlRzYXgxVWdSbFZIVVBhdkJkUVdINnBtcTBBdXJaaExEbFA3Y3JHUVBFM1Yr?=
 =?utf-8?B?dGZxL1p2Y01WTHBjMnFIenVMOTl0VEZGSVNrT0ltYUZsL0JRL053S3hZT2tH?=
 =?utf-8?B?Szg1WExybDZwR2lmSWZ4ZUZzMUpTQnNKSUlveFovVnluTkR0Z01DT0thYXBD?=
 =?utf-8?B?TWNyVVpFZG44TGhVa0NIQ1ZvaVZMUzB3ZzVXNkZrVFRENUZqMDRkN2M3b2Mr?=
 =?utf-8?B?Y3N4bHp6VmdpSFR5alhhMzJVRSs1RGMrZVBWbXJ1ZUpVNkFka25Vb3R5ZldG?=
 =?utf-8?B?bnFsMC93TElkZjA5UUxObDdBcjVuZ0M2dm9mdG4vd2RDL1ZJOE5lMjZKTlB5?=
 =?utf-8?B?YVp1NVhmU2pRelZ0K1BDNEFmNU5aU2pQUG00WGYzc0FhdW4xdkh1ZHp3NkFk?=
 =?utf-8?B?aHhQdWJydzRYYjkvNWw4TTV5YWRNd1pQdUV1K0lrcGRXZDFRY1RzdGowa2dO?=
 =?utf-8?B?OGlYZnc5UjFJd0Q5ejU5QlhVdEtSbGhUUElEZzZibGZaaDV4SHVtYnBrNTVy?=
 =?utf-8?B?U0Y2TmdZaEtpR1lsS1RwZWZ6M2Q0V0NFQlRzOVNSSUE3YkI2UzhUVUZ3dVJ3?=
 =?utf-8?B?R0lUL0RkeWxyNTl2dVFySEI0czR0blg0alR0T2x0NDJNNnFITmEzVXJ1bGhZ?=
 =?utf-8?B?T1JkYWNYVjlKeVdVR1JMbTc2UjR0TG4rYlo3Zkh6K1h0SEVoZ2RKK1ZYZ21D?=
 =?utf-8?B?N0hnM0NFWlhMeXBPNVpVVStocDROVUxIRzBjaGFJWXAvVVlaR1o4OHhUK2xX?=
 =?utf-8?B?S000bEFVbWk4TFJZckw4RDRVRFBKNzE1N1lWQ3RjZ1RlZ3UzL3cxQno5eXhN?=
 =?utf-8?B?cm5EbEdCVzAwRWRUdHZKRThHazRUcFJOLzRteEpQdEJvditPODgrNm9EMER1?=
 =?utf-8?B?Y1NJcTQ0QmF4UlV1aGhMZVFUT1RvMTZKeWV3SEwxTVJzVU9iRDhZNVhUUGxl?=
 =?utf-8?B?ZzhmdmcxbFBkNmMwTXFmU1pPL21ZYjhCNTdrNzlEdElrcU5YOWdod0tvSzFz?=
 =?utf-8?B?RC94T3A3dzlqemRBNTNhNUY2WlA1MGhTMEFmdENyek5rTVNSUU5DeUlaeVVH?=
 =?utf-8?B?dHI5NFlWR1ZBTldJYTZKeVJUNkFjWkRmS3pINFFZR1h6MHczRDF4MG1SWDJx?=
 =?utf-8?B?eFBIZUdEUU9WUjR3Z1I4cTJ1QXBZc1BvR0J5dFAwUUFsUC81aE41RVA1QjlM?=
 =?utf-8?B?UldUdzM0Z0FGTHJYUzBnNVM2WkZzSk10OE5IUUd6NnJONDFEeHlPTjFrTjFM?=
 =?utf-8?Q?1qZg=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:55:24.4072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b140ac76-108a-45f7-92cf-08de083f5592
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9847
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

On 10/10/25 16:31, Tom Rini wrote:
> On Fri, Oct 03, 2025 at 10:03:57AM +0100, Andrew Goodbody wrote:
> 
>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>> not allow for file sizes > 2^31. Fixing this required changing the
>> signatures of the functions smh_flen and smh_read to allow file
>> sizes up to 2^32 - 2 and also being able to return errors that could be
>> tested for.
>> 
>> This issue was found by Smatch.

IMO this makes the API more awkward for no benefit, as no one actually
needs to read 2-4 GiB files (but no larger) with this interface. Aside
from this being unimaginably slow on real hardware and inferior to
virtio on emulated hardware, there are still other problems. Like, how
are you even going to address the RAM on a 32-bit system? U-Boot
(AFAIK) only does a linear mapping and most highmem systems will not
even have more than 1-2 GiB of memory without mapping over devices.

I think a much cleaner solution is to just limit lengths to 2 GiB where
appropriate.

>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> Changes in v3:
>> - V2 missed fixing up one use of smh_flen, fix it
>> - Link to v2: https://lore.kernel.org/r/20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org
>> 
>> Changes in v2:
>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>> - Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org
>> ---
>>  common/spl/spl_semihosting.c        | 13 +++++++------
>>  drivers/serial/serial_semihosting.c |  6 ++++--
>>  fs/semihostingfs.c                  | 23 +++++++++++++----------
>>  include/semihosting.h               | 13 +++++++------
>>  lib/semihosting.c                   | 25 +++++++++++++++++++------
>>  5 files changed, 50 insertions(+), 30 deletions(-)
>> 
>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>> --- a/common/spl/spl_semihosting.c
>> +++ b/common/spl/spl_semihosting.c
>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>>  			  ulong size, void *buf)
>>  {
>>  	long fd = *(long *)load->priv;
>> -	ulong ret;
>> +	long ret;
>> +	size_t bytes_read;
>>  
>>  	if (smh_seek(fd, file_offset))
>>  		return 0;
>>  
>> -	ret = smh_read(fd, buf, size);
>> -	return ret < 0 ? 0 : ret;
>> +	ret = smh_read(fd, buf, size, &bytes_read);
>> +	return ret < 0 ? 0 : bytes_read;
>>  }
>>  
>>  static int spl_smh_load_image(struct spl_image_info *spl_image,
>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>  {
>>  	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>  	int ret;
>> -	long fd, len;
>> +	long fd;
>> +	size_t len;
>>  	struct spl_load_info load;
>>  
>>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>  		return fd;
>>  	}
>>  
>> -	ret = smh_flen(fd);
>> +	ret = smh_flen(fd, &len);
>>  	if (ret < 0) {
>>  		log_debug("could not get length of image: %d\n", ret);
>>  		goto out;
>>  	}
>> -	len = ret;
>>  
>>  	spl_load_init(&load, smh_fit_read, &fd, 1);
>>  	ret = spl_load(spl_image, bootdev, &load, len, 0);
>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
>> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>> --- a/drivers/serial/serial_semihosting.c
>> +++ b/drivers/serial/serial_semihosting.c
>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>  {
>>  	char ch = 0;
>>  	struct smh_serial_priv *priv = dev_get_priv(dev);
>> +	size_t bytes_read;
>>  
>>  	if (priv->infd < 0)
>>  		return smh_getc();
>>  
>> -	smh_read(priv->infd, &ch, sizeof(ch));
>> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>  	return ch;
>>  }
>>  
>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>  static int smh_serial_getc(void)
>>  {
>>  	char ch = 0;
>> +	size_t bytes_read;
>>  
>>  	if (infd < 0)
>>  		return smh_getc();
>>  
>> -	smh_read(infd, &ch, sizeof(ch));
>> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>  	return ch;
>>  }
>>  
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>>  static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>  			  loff_t maxsize, loff_t *actread)
>>  {
>> -	long fd, size, ret;
>> +	long fd, ret;
>> +	size_t size;
>>  
>>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>  	if (fd < 0)
>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>  		return ret;
>>  	}
>>  	if (!maxsize) {
>> -		size = smh_flen(fd);
>> +		ret = smh_flen(fd, &size);
>>  		if (ret < 0) {
>>  			smh_close(fd);
>> -			return size;
>> +			return ret;
>>  		}
>>  
>>  		maxsize = size;
>>  	}
>>  
>> -	size = smh_read(fd, buffer, maxsize);
>> +	ret = smh_read(fd, buffer, maxsize, &size);
>>  	smh_close(fd);
>> -	if (size < 0)
>> -		return size;
>> +	if (ret < 0)
>> +		return ret;
>>  
>>  	*actread = size;
>>  	return 0;
>> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>  
>>  int smh_fs_size(const char *filename, loff_t *result)
>>  {
>> -	long fd, size;
>> +	long fd;
>> +	size_t size;
>> +	int ret;
>>  
>>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>  	if (fd < 0)
>>  		return fd;
>>  
>> -	size = smh_flen(fd);
>> +	ret = smh_flen(fd, &size);
>>  	smh_close(fd);
>>  
>> -	if (size < 0)
>> -		return size;
>> +	if (ret < 0)
>> +		return ret;
>>  
>>  	*result = size;
>>  	return 0;
>> diff --git a/include/semihosting.h b/include/semihosting.h
>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>> --- a/include/semihosting.h
>> +++ b/include/semihosting.h
>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>>   * @fd: A file descriptor returned from smh_open()
>>   * @memp: Pointer to a buffer of memory of at least @len bytes
>>   * @len: The number of bytes to read
>> + * @read_len: Pointer which will be updated with actual bytes read on success,
>> + *  with 0 indicating %EOF
>>   *
>> - * Return:
>> - * * The number of bytes read on success, with 0 indicating %EOF
>> - * * A negative error on failure
>> + * Return: 0 on success or negative error on failure
>>   */
>> -long smh_read(long fd, void *memp, size_t len);
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>  
>>  /**
>>   * smh_write() - Write data to a file
>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>  /**
>>   * smh_flen() - Get the length of a file
>>   * @fd: A file descriptor returned from smh_open()
>> + * @size: Pointer which will be updated with length of file on success
>>   *
>> - * Return: The length of the file, in bytes, or a negative error on failure
>> + * Return: 0 on success or negative error on failure
>>   */
>> -long smh_flen(long fd);
>> +int smh_flen(long fd, size_t *size);
>>  
>>  /**
>>   * smh_seek() - Seek to a position in a file
>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>> --- a/lib/semihosting.c
>> +++ b/lib/semihosting.c
>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>  	size_t len;
>>  };
>>  
>> -long smh_read(long fd, void *memp, size_t len)
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)

But really we just need to make this return size_t.

>>  {
>> -	long ret;
>> +	size_t ret;
>>  	struct smh_rdwr_s read;
>>  
>>  	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>  	read.len = len;
>>  
>>  	ret = smh_trap(SYSREAD, &read);

This is a separate fix. Please break it out into another patch.

>> -	if (ret < 0)
>> +	if (!ret) {
>> +		/* Success */
>> +		*read_len = len;
>> +		return 0;
>> +	} else if (ret == len) {
>> +		/* EOF */
>> +		*read_len = 0;
>> +		return 0;
>> +	} else {
>> +		/* Partial success */
>> +		*read_len = len - ret;
>>  		return smh_errno();
>> -	return len - ret;
>> +	}
>> +
>>  }
>>  
>>  long smh_write(long fd, const void *memp, size_t len, ulong *written)
>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>  	return 0;
>>  }
>>  
>> -long smh_flen(long fd)
>> +int smh_flen(long fd, size_t *size)
>>  {
>>  	long ret;
>>  
>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>  	ret = smh_trap(SYSFLEN, &fd);
>>  	if (ret == -1)

Just change this to

	if (ret < 0)
		return ret == -1 ? smh_errno() : -EOVERFLOW;

And now all the existing code works.

>>  		return smh_errno();
>> -	return ret;
>> +
>> +	*size = (size_t)ret;
>> +	return 0;

>>  }
>>  
>>  long smh_seek(long fd, long pos)
>> 
> 
> There was (as good thing!) much review and feedback on v1 and v2. Is
> everyone happy now with v3? Thanks!
> 

Sorry for the delay, I'm not working on U-Boot at $WORK at all right now
so I don't have much time for review.

--Sean
