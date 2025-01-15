Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65227C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F9A80040;
	Wed, 15 Jan 2025 11:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="me3F/HWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AFB800C2; Wed, 15 Jan 2025 11:58:37 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830A980027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gp+9MNv4rp9EbvFGKsWDvNjhEzIXxaoytQZL35MaUdp2K5laUrKRnHPcosjRyaPuT32ZSgIyg3fD9Jnj+Ju+RjFCjgO7VtjK2+1308Xjq45huS/4n9e0+t5B4N7h9A+hgUSa/rTdKXWG0q1z3MKhPecqa093CPS1a7jLh74+Ov7LUmcdEzQ3F0w770oNk9EQZB1Leftc6RP+bhA5sCemNqts6Wy8luq5H4Q29tNaDbXBXk879xZLhHTZ7+dVY2tl9ylXPMm1dNTfBEyy6QkyppoRXx9od7FGOGvH/vGUvIjY9ccPHfHZeHm9Se73qzmW1xCs+h+JQzCf1HsAUYaWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rJCOSf5xnao0uWUYmQVh6JuM+Vc7cdYQ8S3+ZL5PIw=;
 b=O7KfJVebY+t9R92MM0LoDwDQn7ZmB19zYkmG2IvzO1RCrOAOP2e2+mxRkWtnRnuWENVW4uNsY+kORHnvpebLpWMnF8g+iBrZSVKZmSSYo1ucC7towxyyDdaoGoN0xJLKmwhoeK9KcG2AmEzq0dnHWUJaYZjw9QDfUkPQSt5D2Bhv4QsGaL5K5pptC9xcdpSkvl9j5p/KrUX8/ruLPer8Y6JcR+9Bjr/2dP4jmYdP5/BAU8p7cz/D9mfPJEnfpqbbY1+WupbCSYFwz1TTEAxcZ24uNnK/U1eusb2jKMqovdQeuaS+xCVmTfhDiMl9sDmbcu8CpUTDvVyn81tgnxSDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rJCOSf5xnao0uWUYmQVh6JuM+Vc7cdYQ8S3+ZL5PIw=;
 b=me3F/HWqX2rdNRnK4MVMyYOOKHZBni8drckz3wDc3UZdDvcb5tK5Zz7NpfCfmGt91qsZQjmTtujTwGYbq25phEvvsYZJv2Lp5wAyevaNzAwyQwXjvuLkjqdV7Ep0pGgX5s1nqhb1MMOWfwJhiIssin0e8qFfPIhud/Cdq43/iuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10657.eurprd04.prod.outlook.com (2603:10a6:150:217::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 10:58:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 10:58:30 +0000
Message-ID: <3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de>
Date: Wed, 15 Jan 2025 11:58:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linker_lists: Update the alignment using
 CONFIG_LINKER_LIST_ALIGN
To: 1425075683@qq.com, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <tencent_9739C1044069984893BE3E6D3DB783BB6C08@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <tencent_9739C1044069984893BE3E6D3DB783BB6C08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10657:EE_
X-MS-Office365-Filtering-Correlation-Id: fb759d5b-5d56-4f87-7873-08dd35538be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2dLNjI4RTkzRVNhYW9ld3NTcTFPQ2lqNGR3VVdQd2p2cDljeUtneENpUFlZ?=
 =?utf-8?B?VTdJVklwbndobmdhK1RsVTMxaFQ4S0lGMUpYOFJaUHhlM3JJaFZCRGt2N0tZ?=
 =?utf-8?B?VlFWcThvNXBFM3VOck82eFBEdlh4MWdtak9SSGJvWU41UGZYTGM1ajJzcUtj?=
 =?utf-8?B?U1k0N0M5K2RPdjYrRURldGFNTkNzZzYrWklJOURtbkJpenNYcWRlb3FQVHZF?=
 =?utf-8?B?U0liZk43a3BJVmxRc3R4R1BwZFpvazNKb0Ezd2g4WXFITGhvS3pOSEZrRWpa?=
 =?utf-8?B?TWpLU3JYWDB1N0dvZkY4Z2lzdExTajE4TVVpcnhwQzZlSzMwMU9tVWIrYXVD?=
 =?utf-8?B?QXFXUDBXTUxtc0orcGhhWVQ3OFhmZmNtdnlDMU9ucmFvb2FCV2VUWnVXZWkw?=
 =?utf-8?B?YlVHWG5sdHY4d1BwNDhYSXRUK1p3Y1Z2OE9Vc08zM1pKWjB4bVRKWExxSEFY?=
 =?utf-8?B?eG1xY0g3ZXl4L2daakJoUHh6anVOT0pLck85dnRLL1p4VEpqQzBwN2ZxMnkx?=
 =?utf-8?B?clJibVUydTRVb1djbFNwb0d1QWxNWU1VL0JmUXE0cjd6VUpvOUJlU0JyUzVS?=
 =?utf-8?B?QVA3SUdwY0JJSGlZWHljdWZ5VDJNSlphYVZNaE43dXFUUHAvYjZLL3lTTnds?=
 =?utf-8?B?c2oveDI3bllabW94OUorMG9SUjBXcEZpeGtLYThkYWQ0YkJ6YTMxZTU0T1lv?=
 =?utf-8?B?c0xEZDkvMDFrUjE1a1BYODBYbm5uYjhvWlZkaWtUTGJtWTZuZnhaSldlc2ZQ?=
 =?utf-8?B?cndXWTBGNVBKMkJLSFZKaEI5cXNXSTVCYnl6WmtwRGQ0NXg2N0N3VlpPZUZo?=
 =?utf-8?B?Y3F4M09UMVo1Y1NiMjRneTBQenNNWWp3dTdRNHJVUm5wTmFqNmJXSjZPVk41?=
 =?utf-8?B?cUxBbTRuenN0RTVnMGl6bmozOUEzL3FKN3JaOGxTSFlaODRUb2pkNFJuOGRP?=
 =?utf-8?B?L0duTHE1N3hxL2RBZTdIVWEwZlBqVVNNMncvN3B1LzVYUFdaZm9UYzIxZXRV?=
 =?utf-8?B?c3g4QzlvMVZGY2VnRzBYV2Mxd3VGMDJjZmJyMFFaV3VyRG5QZDJUMFBmZHhW?=
 =?utf-8?B?T2JIYmMveTFHTFA2V1N6a1k0OG1uL25ycXJ4YmsybzBuYzE1UlFYek8vbHFQ?=
 =?utf-8?B?S2wwVkJTM08rVXdUUWg1MmZHSWVwTnhDVUk3NVEzdi9qZUl2dlU4MjRMTGlQ?=
 =?utf-8?B?VS9RZGpiQ3NpVnpSc1hNaXJ6MC9hb3Z4Q09KSmd0YmZ2bU5Mc0IrbXBWQTVR?=
 =?utf-8?B?emgxbUpRZVdlaGNqN0xEaXNEOHNyQlRoUWNaTExqOE5IWVB4d2pjLzZCdVdZ?=
 =?utf-8?B?YlB3NHNMZTZOZ3NLcTQzUStmRW9UR2YyQTJsTHdwZG5ablpoeUFqMEtqeFFz?=
 =?utf-8?B?b096V2RxZ2xwT29tbHRNdHVTekhIK0w0R1B1L3FwYnJaa2wrUWNYNkszUHJQ?=
 =?utf-8?B?U0lQcDRzbkJGUzNLUGlMYlJJTElObU8xK1RrblZPZzJETDVSSG1YdEQvQXZm?=
 =?utf-8?B?NFRRdkIzWkgvQTRLbGwyT0FORnk2L1BSYUtJWTZJaDZYbFhLOUdXQ2ZtaUcy?=
 =?utf-8?B?NVlzdnp5ZzIyTExKZnJ1R0YzdE4rOFBaSVNwUXhYZFkxSi9hK1FRLzJKVXFi?=
 =?utf-8?B?QjlOSC94VWFTQkk0Qlc3UFFTUVNaSGphd2w1SDh6amtTUkpOUDhhbW9OaEUr?=
 =?utf-8?B?N1lZTmpxc2lOTEJXQVh2d3lvR3ptSTdYN2JDZEtOdkViUmRjNVE5bVVVSm5Q?=
 =?utf-8?B?ZE1BUjYyY2ZFQmgrRGRwOEpJZ2FXR2tJT0ZOdDRwS2IwOWJSSm9iUStQTjhF?=
 =?utf-8?B?d1k4ZkVQZjhmWlNVVEh4WERXTExRSi9MMHRjVjNLeGVnNVFsM1dDaVJ2ZFli?=
 =?utf-8?Q?Chm5WfKAWMRmL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldxMHJvSE8yQnI2REtsL3cxMy9pQTZmNS93bGsvUjZrdHZOV2ovRXBEK3Zy?=
 =?utf-8?B?ODNvOVpQZHk1VjBqNVpqT0FyL25YWWlDZmFqWGNzalJCQ3JzK2pGRVNNK2Yw?=
 =?utf-8?B?OUlGZFNXVFFPWGtlSzdOVGdUZjhwZHZZS2dPVFNDc283TE80QVlLc3VlQlZq?=
 =?utf-8?B?UTR5Ymdod2FWSDY1dE5udEVwTUtDQURRRUMrSDBOU3IrZ3k3TmtCemVpZlBQ?=
 =?utf-8?B?M3Zpc2tmRG9zSk56Q1p0UTNNdkZpZTUyYSt5em90eFVtSHJ0Y0pTaTg2cXYz?=
 =?utf-8?B?Q3pUYXYxVCt3ZWNuUmxSZmI3cFFCeWJjdmpCQ0tzb0NEQXFEVlNlNFF6dVNV?=
 =?utf-8?B?SG9QRHZXdE04NTlFS2hhandRY0hCc0JrNHUyMmViZ3BINDJjblM5VkxCMkJE?=
 =?utf-8?B?T2RBTDRpVW1GZDZVOFFHSnhyT2JJMHB2VkZSc0w5VlRwVHlpblVZWFdZdVBG?=
 =?utf-8?B?YWYwcE5Ycm5vV083QjRsbnFEN082a2V2aHpjd2t5VFFCdUVsdXR1ekcvaEpG?=
 =?utf-8?B?SjlaMTRTMS9lV1NCZzlWbWczT2FaN3dtT2Jia0dlNEJyVStGSEJzVXpHS0pQ?=
 =?utf-8?B?cFNqWENCSlgrUnNNMURSRFYrSVRVNFpEb3dNWnEzZnJDVHQ0VzlRd05nWUpq?=
 =?utf-8?B?VGFuNit4MUEyNWllUDc0SW81aFJna25mcThHV1JvNXV5Q0puVzh0RW0zbGtR?=
 =?utf-8?B?aWhLYVRoR1YrV2tCWmJDK0hVcnQ2bCtCcGVTNWdqajBRelI1V2hQMGR2ai9F?=
 =?utf-8?B?b1hCdWsrRU1YSW1mZTNqaWkvU3dUSzJkODEvM21oVmFiUXFKWFFoVXE4NGt1?=
 =?utf-8?B?cW5ZOHRoY2tlZ3NVQ2hmcWZlOVUvTFR3alZsampRbFFhL21GU0dKbmFQQklL?=
 =?utf-8?B?bVpCR3lma3RwdFZoaXAwUktJM0NTcEcvVHZzVUtlTVBOT2VDVldlcWV6OHBi?=
 =?utf-8?B?aldzNjFVNStNNzFXZjBaTEMxK1ZxVkZDS004c2xKVFFESEVld0Z6VkV6clJi?=
 =?utf-8?B?L2pOaU9aajE4VFQvQkt6Q1ZjK3RLaFk4OUlqbmVjSU96T1FEV1hvUlU3dlky?=
 =?utf-8?B?Q0kwblowUkQ3eDlja0V6U3N1S0IzLzRiK21STzV2Q2w0SElFTCtPOTZIQ0hs?=
 =?utf-8?B?TTB4Lzdta1ExbjF3VENTMUFNNHYvYTZLMm4wT214N0dOZHFra2RBM2orT1BY?=
 =?utf-8?B?U253K0VKeFVpVlZnMVR3WElqV2F1OG1sZU9rd2NTemtHSEN4YmYvWmE2WUxk?=
 =?utf-8?B?UWlPNklqWDBlU3hBMnVDZ3lacFA2RFVDdncxN1pGWFhKUDkwRDRrdFcyb052?=
 =?utf-8?B?bmpsbEJHU3NQT1RNNGZmNWRKRjNuVXVXdzJYQjFDWit0WWZHSmFzbm5sNXky?=
 =?utf-8?B?eHV1dGkxNlZWYy9qQ2pIUTNYK2dKQy9jNFJOdHNaVTJBdVpvemZuU2JNcWV4?=
 =?utf-8?B?eG0wSzMxWFFtVlpQeTVxOWgxcUsvM2UxTWEyZFhPbThUZ1RpVVF4V3JlVDc0?=
 =?utf-8?B?YVJuanpDL1BMQWdpN2ZMaGxCeEtLN3BaaENYNFhNUHVZU2pFZmxoVkhWdDNY?=
 =?utf-8?B?bTVPM2N1OHdqY2g3eGVWdi9iV3doTUhiU0ZRZ1dScXQ3eDRwK2lmVUZtWGF6?=
 =?utf-8?B?a3A2NytVblZUenZENVZNSklHTTNIcGJVZHFjYW5qVW1UblFKd0lYdldUY1hq?=
 =?utf-8?B?dkdhbnB0ZncyTGlDOXBvZXpld1JjTUlBOG1TUFpvNmYvdXFrS1RiYXh6dGg0?=
 =?utf-8?B?ek9rWFJlUmxTV3YweXcvQWNjVDBmVG10aXF2NFF5Rk9TVEdrS04wWWloRmhr?=
 =?utf-8?B?OTR4QkRpOUZPWUZQMnMxZXdLU2pSSWRWOEJGZTFwMXhmUWFhTFcyOXBnRWow?=
 =?utf-8?B?aVI0UW9jdS9iZzgrS2lsbVBob3hqNWxITGdTNU1oVElYYUk2N2hwTVE2aXFM?=
 =?utf-8?B?NE05bk9pM1lYVUN5RGYyT1I5QUJwcE9DL2ZFRGVqQnZESWowS1JUTk1XbFcz?=
 =?utf-8?B?LzZaamp3Q1JPdzdlUjZ5Qk5ZVG81NmtZUkpjVXBYWjF5SS81M3NXdFI4MUJy?=
 =?utf-8?B?ZHpYcFBhQXAzYTBIYjh1RVZWTVM0dXJLdk5UV0RxMUE5T1BUVDNFV2kzZXFU?=
 =?utf-8?B?c3c1OEhrMzZZc1EyVUc1WE9ka2V4MThOci84aWh3eTBycXVnMWhzek1XUmor?=
 =?utf-8?Q?MzKCKRp84Mrn0ZYuvBayNn0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb759d5b-5d56-4f87-7873-08dd35538be4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:58:30.3371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waCRRVKSiKzBzvdcPRV8rcBs5VsBzo5Iblfxu3L5BNlwlRlMa6aLP4+R/+kHNBj4bodLY7kE1JtDwJmfy168QzJJUgZ9IRgkvMnOFC8L50w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10657
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

Hi Liya,

On 1/14/25 8:09 AM, 1425075683@qq.com wrote:
> [You don't often get email from 1425075683@qq.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Liya Huang <1425075683@qq.com>
> 
> This patch updates the alignment of linker lists to use the
> CONFIG_LINKER_LIST_ALIGN macro instead of a hardcoded value.
> This ensures that the alignment is consistent with the configuration.
> Replace __attribute__((unused)) with __maybe_unused and
> __always_unused to eliminate the warning of checkpatch.pl.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

This... is odd. I don't see an earlier version of that patch and your 
name/mail only returns two patches on the U-Boot mailing list. I believe 
Reviewed-by needs to be publicly given on the ML as they are a proof of 
review by the mentioned person and is usually a trust mark for 
maintainers to merge code. Here it may have been added without Simon's 
consent. Now imagine Simon is not answering for a few days/weeks, the 
maintainer could still believe Simon went through a proper review and 
merge that patch taking that into account while no review may actually 
have been conducted. This is making me uncomfortable.

Same issue for 
https://lore.kernel.org/u-boot/tencent_CCE8303926957C427AAE06F9D91282458109@qq.com/.

I'm not saying review wasn't done properly, but its acknowledgment 
should be made public by the mentioned person instead of being put into 
the v1.

Have I missed an earlier version or discussion maybe?

Cheers,
Quentin
