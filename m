Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6F5C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 16:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2CA8083C;
	Mon, 17 Feb 2025 17:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AMuoxYLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD8E80843; Mon, 17 Feb 2025 17:51:03 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C22807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 17:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p20OKuRpqfDnWC5pg+ecSSrDb80W2rvsz7a3pgS7OHsi+acCx2kNFmCSPvKD2CdbLDH+ZJYB7hiWqW/vr2hcxpGiol0L6Bfi6lY0+wBEqNLyBM88mURz0gSiQflj7DE/Um23KvNbnAvtckU6+W57gATbM6P6f92/3LeqT2EaMaosT6Y47146NFcU1u5chScGwGNUiHkbcPUCtwAVuwezCjAVnlWxEOIxM7h2mS3eAx2gwW1ismbRElphvl4RIISzkvK0pRoTUuDLERUyvU6/iFYI8YCeLoEVhfZ4kIDoo8sY+mqVJqWbBh2k19u+xvbxYE402fHrnmnSaKck3EqSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEbpO4qzVvGKxL6XyxN9Nkk55lkWUjpoj9ag1JdYLT0=;
 b=Tq1/faS6gU7grkHJqMG6ZOpyuAk5mE6Kt7baIjn7y1z7aKn9i1VT+maUlsypc1RrzaFh1qWcNL67XMahVd4Yt7S5Ze+YA57n4FfOJ+K2wujiwOpDndTJFpL53CJrgOHS6LGwUFYySzpyXQOXXYYvm/sB8K2VuSw8hfS7TkmwSfHhTOOqV8fCbpGmYSQOXaqSpG0+4w88VHYZ3cR5ApDTA56KCYfLXNPJuxf8Ndr0nFVkEK94VyjJQD5VrPnNubkpYZ+mlMnPfXdcS5L6u/FDWWrtw3aUbxpHpMVsntuwqTI5C/2H6iT0tcK4MMPO8met5UppeTMfBTkos4AmBpShHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEbpO4qzVvGKxL6XyxN9Nkk55lkWUjpoj9ag1JdYLT0=;
 b=AMuoxYLXgSsuCgf5VDb4EzJAARRgEpK56sqQv5LoVpX2VKbFoCGGG150XwlH6dwPDXOxCAe/C1WLz34aDfvc0faCvgLXeXBYktLv8e4TrfXGXESYMcFSdBv6IpPGrfJIm9o7eFEzU3Zb3tpvCPU8ZFtMEElcVs4NyJgsx+lOn7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6881.eurprd04.prod.outlook.com (2603:10a6:208:18b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 16:50:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 16:50:59 +0000
Message-ID: <92bb6e6c-2bb4-46ac-ace8-466f48146c09@cherry.de>
Date: Mon, 17 Feb 2025 17:50:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] board: acer: picasso: add Acer Iconia Tab A500
 support
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
References: <20250216181641.194424-1-clamor95@gmail.com>
 <20250216181641.194424-2-clamor95@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250216181641.194424-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: d97e635a-ef61-4aab-45a9-08dd4f734165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG9leHBFUElJdWxUQjB3RXlPcURxcjlVV0p5TmlpZTV6cGxXTW05cW9SYi9N?=
 =?utf-8?B?bjJOTUd6TklmdjRSTitiTkcwRDk1ZHd6T2ZUK1BORllxdiszVFJqbjlyOE9P?=
 =?utf-8?B?SW9QWVRKYTZybW5taWhSVlQzeVpvNEVtVjg5dVRmb2p0QWwrTGVxY0VvUStD?=
 =?utf-8?B?Y0xBQU5mK29UYUdBSnNTRUhRRFpjYVRiUzJMMERJNkczcFR5TEJMWkxubHVZ?=
 =?utf-8?B?YWM0ZWFSN05LV0pPOXhnUFZnU2Vlblc2K3R5OHhjTUYxTGhXZEFvRWFkeW9x?=
 =?utf-8?B?QlNFNndhZUJERWVJZ0RNVzUyczBrcUlHSU5LaHpjQ0F3dlhDOE9CNUdLMHc4?=
 =?utf-8?B?WjMxNGYyeFpoOE0rQktnMFhzc2NwaXEySGRZQWxUaXFTellKUkJDbGloK1Nx?=
 =?utf-8?B?enVBekhoU1JDSUxVWFJQdDc2aCszOHFyV0NPMzk4cmFGWVBQUnNUR016eVVy?=
 =?utf-8?B?bVRkS21PdERBTmZPeHZmajV0emwvMldRbGtGdTRkNG9sK0lQUVExbHpwRE5l?=
 =?utf-8?B?bjE5Q3B6bmNyZDZiTHdINm9wWFBGQ3A2eGJCYWlLcXByd3Y1b2o3T2pGQkxS?=
 =?utf-8?B?cUhTVmFTQWhJN05yUUVwNGgwemE4cHNWcVRXSTRpVUNXRlppZjA0bXhHQ3hr?=
 =?utf-8?B?VDlPWG1UNzByVXkzNk5mRklNNjBzTEdkaVV3QTVPSmZPQ1dhNFBhOHFiNzR2?=
 =?utf-8?B?RmdqZ2RGa0ZnckxIUThLRWFXNlVlRjFyUDNRZ1pCQ0N4YlYwZ2EwN2VZVEVZ?=
 =?utf-8?B?eFZweCtLdXUxNkY4aUxvNmZFTmthL1FPODl1UUlxQ0tvRlN3UnZCSDdEU3ox?=
 =?utf-8?B?Vzl1T0NNNDNZRTRoQmx6MEFYdE95N21DbDZQV0JRbE9qTlBLb01yaW81V2k1?=
 =?utf-8?B?WlpPcVpqNFNIdVJZRlBsRTB0WnBHRTlLZVJxYnZFbHptQUhPRDVWc3VjdGJs?=
 =?utf-8?B?V3N3NER1YmNhS05yeHpaVTI2N3dIdEhyRXlpZFJoZi8vL0dGTlNXTjVVT2lr?=
 =?utf-8?B?VFlKd2hhVkJZV2RZcXg5Z05aUFdLSzdXNXFiVzF0QVMyUjlUS0Y5R1hpeVhV?=
 =?utf-8?B?MlZLRzFMZkptMzE5REpEcjJqMWx3K3Z3cDZLTWJKbm1OMTN5d1czS0dxS003?=
 =?utf-8?B?enNod21qMktOTnhrZ0xPdkt6WWg2TE9lNXZQYXN6azJwUGRrWTNCU2JzMk92?=
 =?utf-8?B?bkVnL3QyekxnS2RmNWFGQ1BjeVpiSjk2dUwyV01BeHRydDNwN2pCQnZhaFhv?=
 =?utf-8?B?S2FsWGR6Q3d0ZHZJekR6MEFQQ2pQcDhuVzY4cG5IQjNoZ2thZEdMY3NGRUts?=
 =?utf-8?B?OHZYNlMwSSs2ay93MnkxL1g1bzc4ckoyelZkcGJpV2xFMDdiN3V5aGw2clB6?=
 =?utf-8?B?d0RDbnJ0QmFVNncvT0JRYUJMWnR5dzlIcVlQclZISmV5bGE3bU9kcEdWN2My?=
 =?utf-8?B?R3k2NWFUa0pBRUFtK2tpOG1oQW1WL2p6TjEvdU9tSk5wd1lCbHNtYUpvRjZu?=
 =?utf-8?B?bFNzZzNkR1hvMWFBQ3hrKzJTWUhjaTQxcEhFSW80OGRUUzE2YzdpVnhMbmd1?=
 =?utf-8?B?VnRnNVMralRtUm52ZEtUT1hGVlV0Wlc5OTNDb3NtUXczeWpDWGpMSEpwQjJj?=
 =?utf-8?B?RGlCc2p5Nis0aGpWTnFQNlZkbEMzYjVDWU41NW1WU0N3ZWpmSVhMcC9iMTVx?=
 =?utf-8?B?SU41NDlRbUUrUFUvYTQ1a2dQeUVKWmpITjZjV2liMHdZRW9NK01LWTlvOU9a?=
 =?utf-8?B?M2k2cEVjRTdKOU00V284citKMjdSYmY0eHVEcEhqdnRDVjJoZFJidm9ocUhU?=
 =?utf-8?B?d0NEMGtmc3orUEtyb1oyem83bXFMSWQ0clp4akxHdkhQS29WaW8raCtzTzlH?=
 =?utf-8?Q?4p5mq8i9woa9v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1RPbGZvdFdTNUF2VnJkdGc1ZTZsdWk0L1VDdnl5Um1Pc2VOU2RsU2VTYnQ4?=
 =?utf-8?B?YVM3OE1sVjlTckZ0cWFsbHlmQkNZSFd5aStsdGFNVkt5UU9pWG1MU1lINW0w?=
 =?utf-8?B?UTgzdXVBL2szNGI3TkZSVGQ3MjF0U1JtLzdQR3grVUMzNnlmVUlLNGJEZUVl?=
 =?utf-8?B?R0hsSWtIdzdkb1FaVXl0S1BUei82ZlJVVnhUUS9vU2FuOXVWNkJTL3l2TGQz?=
 =?utf-8?B?YWQxdjRxUWRrZFU4TFNGTlJWREVzdlpMZUxJcHpEclBrMWxWTXRPcUZqakdl?=
 =?utf-8?B?bjdDWk0rNXlUUk12Nm5YZlVodTViREc3dHQ0c0hBNDBFV09tRmRvR2s1dXZv?=
 =?utf-8?B?WnBKS1NPenUzckVKSDRUWUtxdEtYcWpiWWhCMFVUWGtTOGx3dVFtajJtTnhE?=
 =?utf-8?B?UmRUK3pXTkhnWXNpNi9MSWRDWktNWUtROUo5YlRGWWovZWcyYWV6QTZXUXd1?=
 =?utf-8?B?ckIzdEJJdHlNdmRjeUN5c01xVmNoVmFMM2JhUjVxRW5aakc3VVI4RzhldlI0?=
 =?utf-8?B?RlhYUGo5eVJpUVEweE55NzB4T3duRXNUQzVXdE41TFdGREw3Ky9LYysxTTN3?=
 =?utf-8?B?QnVBM2lHZXZEeDIzMFpxaVBYcFJQbno5Q0xYUzl1elZYaU8vRmlYRHROd2J1?=
 =?utf-8?B?SlhiQmhaaktWNE5vd0I1Q251L0haRGlzWkZLQnpUVnlWa0R2N252NXNMcjBx?=
 =?utf-8?B?L0M0UWk3a2JKSHhJZjg5bHFjUzczaGZWaCtGYU9jeTV2b3BTaFRBRHFHQzRl?=
 =?utf-8?B?bnVQZ0JKNFBYR3J4b2M1dldKWFU3aXNaakZKRmcwRXczdE11QVlNanVuR0Qx?=
 =?utf-8?B?bFh0QVI1b05YM212c0lqY1Q5K2w2Q3dvbHJyeHFrNkJDSmREKzRBUGpXM1ow?=
 =?utf-8?B?MlVQTkkrR1hNQk1abVhKRUJML3hUbStVSzEzeW5JcDkvdVNKT3hacVp1OTdV?=
 =?utf-8?B?K3lYVy90Nk9tWEtFSFV3QlNaUzh6eWlYV1E1QmNYYW1GZXROQjVJcFl1Qjdm?=
 =?utf-8?B?cnVrTVdTSngrWEI5WnFyZlBiT2ZqRmhXelptdHhaQzl3RDUrcUpFK3kwTFZx?=
 =?utf-8?B?OFNwMC85aEFnbDRsVEdjNS9jWnJzYm8yTkUvcTJBeE9nU0FhVDFzaVVtTWhS?=
 =?utf-8?B?Rjh4MitDUkpJczNhQ1k2SGY2U0ZNeFFQM09iMWU1S3diaU93akdJKzllcHU5?=
 =?utf-8?B?Zy94L2RuY1ROcldSZE9uSS92SlNueEpEYW1KZjNmM3JNQ3I5aWJhQUEvMm9E?=
 =?utf-8?B?VU1PRTZ2djdtVnAvQW4xcmpLcStkSHY5SnNhSk85c2dxYS84MTBhL2ZjcEJG?=
 =?utf-8?B?dlNxd3NMY0paSmFObFdxcGRmREtQSi9mMkFlSHhHT0VDTWl3YXVpdkIrL2Z6?=
 =?utf-8?B?NC8zU0lRYkt5Z3lkSjdVNUNRUXViM3VlS28vSTloL3NNd2EwTjY4ZGRmSHNF?=
 =?utf-8?B?ZmF5a1lYaDMvU1lPQUVsNDNlbVFpZktTS3MwaFVxZzcwaUc1KzdBMGlqamMx?=
 =?utf-8?B?QUI3Wks2QnMzcithWUppRmowZHB4NzJPQ0JNM1hEVjRZRTI0YW5TSms1TDNE?=
 =?utf-8?B?eVVUYjVYcTJmeCtPd3lNVnJOcWkrazFIK2I5bmVRQlQvV3ZBRWNwaFdrMHZT?=
 =?utf-8?B?anNZanp6YlRnR3BMVXVSRmFWSk9KeFdwT3FsL0NNWUZQZ1luSjNyMkF3VEF6?=
 =?utf-8?B?L1ZHNHdaOUhoUEg2UXU1dHZPMkhub3QzNzhEOWZVWnkyN3U5akhMN2t1VVdP?=
 =?utf-8?B?VWV1MklYZ3B2eUZ1dzdaMnRMb09EbWRqd3FHQTg0VmVSMWRzaWVBaVFYR3Ny?=
 =?utf-8?B?NzRaS1orZG5ORlJPZTFwdlFzaUtySGV0cGtwUnlwWTZPMXlpVzZGMWgwVGx2?=
 =?utf-8?B?SE9RcStzamtoTGFmZ0JxSVZMQWpQbm1Jd0FzVlZPZzlpZGFrOUx3NHFlcEpJ?=
 =?utf-8?B?aUF1V3pPaU91SnRrbnBHL250WXJhT0pyS3dvZ1orbVJQZ2xib3F5ZldsNytP?=
 =?utf-8?B?REIyRElsQy9leGR3VkFVaWtpNDB6YmZvQWlRVzF3a29EMG9ibUtqQjZ4bVZm?=
 =?utf-8?B?UUVrcGo0em0wWUFZRk4vTXB2bFRxU0lsa1B1dTkwbEVoaG40NzZtaHA2cngy?=
 =?utf-8?B?dWVpK0x1YzJzV3NQNk1SQkdpNkluT2YzTlRmUk1FZU9NRWsxVC9JQXVQdmZP?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d97e635a-ef61-4aab-45a9-08dd4f734165
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:50:59.4734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AR1dee95shCgBXYrPMEgkhUg+GRZfjDkcMl8hlNch08j0i6vrdNCmUkrvTYFIVcNvkdIKAM1ToGWQDZ3TodcarAryI0BeESu8/rPdrLbUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6881
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

Hi Svyatoslav,

On 2/16/25 7:16 PM, Svyatoslav Ryhel wrote:
> The Acer Iconia A500 is a tablet computer designed, developed and
> marketed by Acer Inc. It is powered by 1 GHz Nvidia Tegra 2 processor
> and 1GB DDR2 RAM. The A500 is sold with 64 GB, although both 16 GB
> and 32 GB models are available.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   arch/arm/dts/Makefile                      |   1 +
>   arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 +++++++++++++++++++++
>   arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
>   board/acer/picasso/Kconfig                 |  12 +
>   board/acer/picasso/MAINTAINERS             |   7 +
>   board/acer/picasso/Makefile                |   9 +
>   board/acer/picasso/picasso.c               |  57 +++
>   board/acer/picasso/picasso.env             |  18 +
>   configs/picasso_defconfig                  |  83 ++++
>   doc/board/acer/index.rst                   |   9 +
>   doc/board/acer/picasso.rst                 | 125 +++++
>   doc/board/index.rst                        |   1 +
>   include/configs/picasso.h                  |  23 +
>   13 files changed, 858 insertions(+)
>   create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
>   create mode 100644 board/acer/picasso/Kconfig
>   create mode 100644 board/acer/picasso/MAINTAINERS
>   create mode 100644 board/acer/picasso/Makefile
>   create mode 100644 board/acer/picasso/picasso.c
>   create mode 100644 board/acer/picasso/picasso.env
>   create mode 100644 configs/picasso_defconfig
>   create mode 100644 doc/board/acer/index.rst
>   create mode 100644 doc/board/acer/picasso.rst
>   create mode 100644 include/configs/picasso.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 0bf3697bdbe..acea0cc2ec1 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
>   	meson-a1-ad401.dtb
>   
>   dtb-$(CONFIG_ARCH_TEGRA) += \
> +	tegra20-acer-a500-picasso.dtb \
>   	tegra20-asus-sl101.dtb \
>   	tegra20-asus-tf101.dtb \
>   	tegra20-asus-tf101g.dtb \
> diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dts/tegra20-acer-a500-picasso.dts
> new file mode 100644
> index 00000000000..0c301483180
> --- /dev/null
> +++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts

Small drive-by comment.

This is quite different from the Device Tree in the Linux kernel tree, 
and it hasn't been changed a lot in the last few years.

1) Is there any reason for not sync'ing with upstream Linux kernel 
instead of having our own Device Tree?
2) Do you think it'd be possible to use OF_UPSTREAM instead which would 
make it possible to use the device tree from the Linux kernel (it is 
available in dts/upstream/src/arm/nvidia/tegra20-acer-a500-picasso.dts)? 
I don't think it's a straightforward thing to do but haven't do it 
myself, so no clue what's required and the amount of effort to put into 
it. The benefit is that fixes to the DT will eventually make it to 
U-Boot as well and we hopefully lower the maintenance burden on U-Boot 
contributors/maintainers.

Cheers,
Quentin
