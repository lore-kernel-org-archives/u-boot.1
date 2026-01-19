Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A3ECCF2D1
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BC483015;
	Mon, 19 Jan 2026 10:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JZmcivS9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JZmcivS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9E283015; Mon, 19 Jan 2026 10:29:30 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7382800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ptsUNie/LrlxvhTsmtgI8+4OaHKxafuZUCultVFWIKbgS63Jl9GD/1owN7qoiAsY7GC3w+1aaY9cVCo3zwHR34i745wZOUw0bsmSKBXNpDeWFpMAc1G/tK8Ddba/y4ebIMDVTXmTRScjDh/YE2jAsYDgIOckXZ7tG8LPuN661t9ygH521mMn8FyYhbV2w7GM6cvNrQRC6HarT6u/1nfk2M+/+9XdnLETnLSZWoBgI+cBBcARLMCUDI3uBb+uT4Dw11TT8I1PF8lqOzR5Ms8fEX7O3tGjqEoyZp/oR5SuBYoL7WcPKg6+ar1kUK6COeJoiO291ODMfRHe3cuhts5p9A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whrkBKlS5W28FPz7oJgQQjc3LCIKVyu+dmHojF2e9Ug=;
 b=Cp3zontRh90GvYpg2LuHd0smacyfX30n9fzS+ZgcgOXU+LdIdDj03gf636cVzbLiButdC52Mr/GBRlyCHo010Ge+yrQ2+UwBiLBaThjMPtKCEO0o3BZq7FeQNu33fXRPOAkE+YH1aM0V4dwgowJlRSgM1pZSyQqLaNHQr/x/B6L4Qxy4wTP2bxV96BIHGEIVEsWs6s1RbyY0iHGnhmuMMgArb25sn2pYuNhZsFcluHMFsEzc/5tJRmFiFPGXXEXdUxgaLfjOWGYCYHbFD1JN/IYmzMyR+jXUubGjJjt6QQUPLhLwKcdctAHgeUtcdlW8FskB9LUtc9rbmn1OFMl1zw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whrkBKlS5W28FPz7oJgQQjc3LCIKVyu+dmHojF2e9Ug=;
 b=JZmcivS9fI1j0SwRkm4tpue/WlBbE31xW5USRByUXgj1HKHVlxNlKIzLJ0+geVv7MwhSPiiHbEVI1bUgB+7be3wKX895R4twf5eOqjqf12VvEBq/V3MAk7fB3cUc2HuQ8kC4oYPgInVp0x4xEu6v3Xlw93hsuCGXtoSpPUB5YmE=
Received: from DUZPR01CA0255.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::27) by AMBPR08MB11570.eurprd08.prod.outlook.com
 (2603:10a6:20b:6f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:29:19 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::47) by DUZPR01CA0255.outlook.office365.com
 (2603:10a6:10:4b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 09:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeXFuKARqQlfSxiXjdhWdjswRBqs2mC4ojRpy463OK0tfK++Y3hvSgQ7uZG+hyaRDFvsi7nEIH3tDjx92mysjPB/m7wXhA+28/DxafVLdSj4jFtBonQC93XKCi+Hp5KHvm/xDZURCukbbISa5dBy09/Xgx7CVxXFg14jnK4oZJsiI1ELqdy8eXTy+BQUx/AKF0LW431QCjjWGlJ8zyt2vPqYVyOFgyidIm6hYL1O9j9RYD5vR7QXa6t2Vc6mFqiS2QgFiZ/KiimTnnTJ+hT6EiNzI30itXZyBLkRncQNhNICShu2ims3hIdWr1hzLbuXVetWm+w3fLh5sD0p0/WVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whrkBKlS5W28FPz7oJgQQjc3LCIKVyu+dmHojF2e9Ug=;
 b=FRBg3d8/yyyZwZAXANsle72WR4d67JIEG+GClOL59tJMCRSdJJ+nJRbeTQEpzwDiy48+HT86uhe34sLO36iEl2TNfKcS0ikdwIwTe7QZtUn+WDahzhg7Lj2HleZJ99fc+UEaHIyaseDECRjXumou63I8bxSv5UOQ9xPMwPNCFL0xqC0k1dK4cEuNof+/ZcWRfA+DPpxCX+uEehzl/AEzlhzwXIZI15o0YqByHylSchNMFtEuh6P64P1bx4oQNmdgfyqeVh0RTq0aeTfu2Snn1KhltBmMuqRS8RfORNxByFYDdVMZL6aoJ5FXtpNNsiEB18mMsD4Sz+GP0ciBjoBMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whrkBKlS5W28FPz7oJgQQjc3LCIKVyu+dmHojF2e9Ug=;
 b=JZmcivS9fI1j0SwRkm4tpue/WlBbE31xW5USRByUXgj1HKHVlxNlKIzLJ0+geVv7MwhSPiiHbEVI1bUgB+7be3wKX895R4twf5eOqjqf12VvEBq/V3MAk7fB3cUc2HuQ8kC4oYPgInVp0x4xEu6v3Xlw93hsuCGXtoSpPUB5YmE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXPR08MB6527.eurprd08.prod.outlook.com
 (2603:10a6:102:156::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 09:12:26 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:26 +0000
Message-ID: <ffcb15a8-ab6c-40c9-b87f-d6b0f332e677@arm.com>
Date: Mon, 19 Jan 2026 10:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] net: lwip: Command fixes and improvements
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260117002452.1026310-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXPR08MB6527:EE_|DB1PEPF00039232:EE_|AMBPR08MB11570:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b50206-48b7-4a87-57bb-08de573d3804
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Y21qRDV6QzJpZTJWR1UyVnZHOHgzV1lyYWQzTEpmaUpwRjg2MWJ1am5SQmNW?=
 =?utf-8?B?dTZqWXJJdzVLcjVQL3dvY3Y5c2Y5MS82TFQzNklUQ1J4NzJtSHU3dGR2V1Ns?=
 =?utf-8?B?dUNISjBDcWVWT00rYkxqbTFaekFETGVEYUJXY0Z6dGhoUVFDOFFzUHB1b1NR?=
 =?utf-8?B?dENmejBaRzF1OFIvVWNYMVdvOVh0NEkrVDBkbzVIKzZ2TEtaMjczWkNPTlkr?=
 =?utf-8?B?QnAvTmdQbHJGV1dvZlZUbnMzaU52aFhsZ2RTTDRYcmZ3V1UxbzhyN2dybHRI?=
 =?utf-8?B?aU5QdkFWU3UyVUtkNGY0NUlyV25FeWduZGtTMzR3d29qRUkyN2NHOGdob1pR?=
 =?utf-8?B?STQyR0ZmSjFQTUlSdjA2SUlNaE9QdXc5aWtVSVFBQXVUeTQ0Z1lJb05tc1NL?=
 =?utf-8?B?NnMvdnFlOUpJUUZLd0tja1BpTGRrdDhoL3plZ0xqMkU4Q0VpVFBaWWVwZGpE?=
 =?utf-8?B?d2ZXMDBkLzVXdWpxVDBNWGJzOVBZRUJsVk5Kb1MyMk54L0JIQjdPWjFvMGNx?=
 =?utf-8?B?WlJkVXNhNGRXY0wyOFJacUxVcXk1NGxCSGJ4OGc4UU5qeC90VEJOTVJNTm9r?=
 =?utf-8?B?NHNmc01TRFBzUUhkaGZoYktSUnE1aGxkMElyUGdNSmZ0cHlXZUZNcWFGY3do?=
 =?utf-8?B?MzdudHFGK3VhM0d5dWdZQ2tpWmlTd2dJbjBPbGl4QWkxTUJWdHF6dFBLdkRJ?=
 =?utf-8?B?WFB6Z3Z6SnZIdkpUVGk0RzdOVmpUcGEzRHZ1OWQxaXpzRnJ6MHlMaXpGZlRy?=
 =?utf-8?B?azhVckdQT3h2MzArYzV4SlhaMmZoTVBQYUxib0dnQ3FoWDFQU3N2VUFLdWZV?=
 =?utf-8?B?Q1JuTmlPenBMYnhMKzU4VjBrSWhsY2toR0NTWHk4d3dLTngzT2pnLzBucS9n?=
 =?utf-8?B?blQ1Y2ptTG9kSitha0VUTFg3NXpWb1BqM1pmT3BQR3NPcVNTMWM2RUhOMjVZ?=
 =?utf-8?B?MmxqNWNzenUxVjFVZjdabDBIQzZhR1JQZDBTMERjTW5jMkpoM3NDUkRZWjJ6?=
 =?utf-8?B?MjJENlhWQVVudTNKdlNzUkJpVm14SVlYNkFIRzlhbFd6WXEzNnZmS2Q1VXJx?=
 =?utf-8?B?c21hcm5uNmhvLzN2N1U3YldKM1pMY040SXNSdTJTdHdMdm5rVXM1MlRNQUNo?=
 =?utf-8?B?T1ZBYlM3UUFxcVFtekw3N0lVNS85ZjUyaERuY2hXZ01RWWx3VmN1RTRQVVdo?=
 =?utf-8?B?dEVmNE1Ud2QraytJL3JXREh0UG5BcmpObW41MW5jY05qTlpsN0x3R0RFMlFv?=
 =?utf-8?B?aldaRE82c2xRdkxrQ1dER2V4bkFndTdnTGlucnhTbEFBTHdBd2ZYeU1LMWlL?=
 =?utf-8?B?bEJjL2czU1NnSFU1U3BGTjlqVFByempFMHV5VjNUZnJLV0h1VzVia2p0VGVu?=
 =?utf-8?B?djFJMHZOWkJyUlpJcDhpQ2VQalpYODJ2OWZLbDhLSkJ3dkVMR2VybUs5eHJ5?=
 =?utf-8?B?c0FJbEdNSm04Qks1ZjB4aGJvTUxlQVk4L1dVb2hZSVVZR2s3N3g1Zjk1TzJH?=
 =?utf-8?B?aDc2cDJsejhsWURhdGRpYjg0NWpJbTVYM2J1OU12MzNKb2xVZWxBZVhRNXpI?=
 =?utf-8?B?aXhNM3dHSm9KUlZTdm0xTW5XNWRSRFliaXFteHdRQWM2M0RHYTBpTTA2TFla?=
 =?utf-8?B?VFArSXJrM1ZsYXF4QzMya2MyaERwU21qZ05ibEZjTTJPRFgzL0lzd1R3RVdB?=
 =?utf-8?B?TEh5bmpLdGhTUWgzZGJIcUhOQ3ptWXI2VytOek8vOXM5YjNyYjR4ZzFyK3l4?=
 =?utf-8?B?Qy9mMlJlMkZDZngyM2h4b1JVcVVOajNyL1hzVWlmZldQV1RIc1ROeSt5MGVR?=
 =?utf-8?B?WFBXNjN6LzhUUFdMUHdDV1lKWXNGd0ZVeXJjUzdFOWpvdXpia01NMEpaeCtO?=
 =?utf-8?B?TUpOQnk1MVRXSXZncWxJcFl3OFpuSmsrbkFmclE0MkpWVFlobTFsWTdzRS9U?=
 =?utf-8?B?RjVDYk5aQW1NOSsrS29PR1dSY01MU0ticWFuRFE4YTRud3lrbStBMXoxbDBP?=
 =?utf-8?B?Z1FSSmYxUjl6WDZTcFRLTEJOWHh5OGVMQXZJNHdOUGhkVko4MUlkYkp0ekM5?=
 =?utf-8?B?VDB2Z0YvTWhMUlFaUFM4RjV2MXNSRmxZcnFLaFpPS0JxNS9uUUxFNWdsSFJU?=
 =?utf-8?Q?z1T8=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6527
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d9ba3a79-80dc-4f34-0038-08de573adbf9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|14060799003|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENEUWRoNkhwbzJzOWEvMXBBTnhDOEo2bTd0RXA1a0N1NXdtNkxqOG8zc1cv?=
 =?utf-8?B?S2FNVm94RStJMlVPc25VSlp1YlRqZXNvVDQ4aE4xYWtVTVZDZ1lXRk9ud3A3?=
 =?utf-8?B?MENLcjdSVU5jRVVZK2p1bG00eEpUNktGV05qZGowYnBYMG1zSzcydTJXNTdh?=
 =?utf-8?B?ZzNIdURPWW1qSmVDb3I0TEUzRERqbU5zWHNVVE5CM3RiUVZyU0cwOXJyclNv?=
 =?utf-8?B?dVJUUlFKMC84RTFrTHBrYVFPaXBKSnhHZWdlWFNQQVk2RE1nSlg1Q2FzaFpS?=
 =?utf-8?B?OEdwMm9WUGNvMk1hMUF6UkxiUWhGOWpPcXJ1RTlYVE5qV2RVUUJNK0E0cktT?=
 =?utf-8?B?d1U3clpraG1DTnEzRU1Lc0M4eXU0ZGRBM3dNV3Q5L2tZQXBLbmFSMlpkMlZU?=
 =?utf-8?B?andWUWlVSUJlQmhJUFUvYnh1c0ZVRWx6ZVQ0ak56MDVUVE4rN0pjMFdiQnZU?=
 =?utf-8?B?eHJWeGZ6R1hPakc1OWNUN0IrampvLzJNZHJ0TmlrcVNralA4UENXRjZrTmU2?=
 =?utf-8?B?VGkzNTBsamdrUEhLcTJTYkZLYk1CRnJrNWE3MTJQR2YvYnFrVEZreFdSUmJ5?=
 =?utf-8?B?RnpZWnVsY092UzdmeEl4S0tQYVI2a0QzWG8yZGhtR3kvVVVpNk93MWFXUE9O?=
 =?utf-8?B?cU1OaDAwZjE4UlBRVzhYNUh1bURuczl6aXk5OWc3U09YZGd2QkpXMEJZQjlY?=
 =?utf-8?B?dnFOV2ZidVg5WXB4TmNsNUZTaUh2bGlQNWcxOHhlUUM1S3BTTWU0QkxEOWRn?=
 =?utf-8?B?YTd0R0l1T0FrR3ZnRURQMXZmTmJqOTd6VUc5ZnovZ003S2pzMXFsK2pNRlVy?=
 =?utf-8?B?ekhJS09FSnNRYzdNR2c4K0c2NmFFaittUGE4d3ZLMVFpZXBJeS9yWXJuRUNt?=
 =?utf-8?B?V1FIU1ZBNngvWDlidGc3eGxudTliSGE3bGlzTUpLcE1TZERzKzZNT25iTS9C?=
 =?utf-8?B?QnJrZXZJak0yOFpoaGtsUDNzTE0zYklQOExZOTdkTzg4L0pyU3J5S29TNzIw?=
 =?utf-8?B?ZGZha00rV3FMWitjMUhnSWRyUUhSaU5qcFNmMmdvOW9NeFpBL0JDcWVJMmtT?=
 =?utf-8?B?MHYrWmFmaStneTB0UXFUMU80ajR1dlorN1psVGNtcHVvbkR3VlFDcnF2allt?=
 =?utf-8?B?QW9Yc2p4Z3dqYmFRa2ppYlR3WlZYeGxOVkZCVnFTNTRhcVIrazNqK1FpTHg5?=
 =?utf-8?B?emlZZXp2QkgvVHZBOXltSFBsTkxTU3hQOFRPaTdHTy94dFJ1aU9za0ZpY3ht?=
 =?utf-8?B?RzFySnJ3QWdIRHJYa3RJb0luNCtPbnlOV1dyeFUxN0EyTmVIeDZFNVVsemtS?=
 =?utf-8?B?VTlDSjl0SURiWEM5U3FJeTRNWFB1UHZBV01VTFZvMVFBNDh4a05wdS95S2Jh?=
 =?utf-8?B?QUhLbHRiSHhnV3BmT3pwOFEzNjYxajd1R0k3NFhBMnMrVzNPTENVUE5laEYv?=
 =?utf-8?B?MEs2S3I1VXpRZVBiWlozbjV6S1F0R2hmU3lHMGU0dVhoMFFGai9sZVRTbXZY?=
 =?utf-8?B?aUlicVBsemZTNXR6YlFEQTNiQ1U0WkdHTTN0TDFhU1hhWFlyOHZROHJNdW1K?=
 =?utf-8?B?QSs5dVowaGJKMHd2T0d0b2tzd0ZTdzgvYm0zMGtYN0ZBSDFibTRjSXBPUVpy?=
 =?utf-8?B?bTI1Qy90R2xXUGRMYlYwZmZkNjVQcDIrVlVQT2gyd1lZODAxVnBrMDZIYkw3?=
 =?utf-8?B?TDNtU1VKRisrcFhFbFJIVVlLV2dtRGczcnFMQ0l0ZkxXaklGVmNyOEhhYnRU?=
 =?utf-8?B?Q3ZoeURuTWUxYXd5TkNwTFhUKzRqQVNOaFdBS2gxZm9HKytWZFNUdnQyRy9h?=
 =?utf-8?B?RG80T1pNWWZWdEtwZDFSM2UwM2l3ZkV1Q0lRNS9wcy9UODNKVGRJeU45TmVi?=
 =?utf-8?B?YVJscmllam1uUHlQQnNPdENDNGNvc1BzdTgwa0YzQSt6VHNBYms5dGV1c0N4?=
 =?utf-8?B?YkVVSGsrUmlVQy94dE9sa0c2bVRmNXh5d1NueTNXYWxXQ3NnWUJZNWJXZ3Ji?=
 =?utf-8?B?R1hNREVKSzBCVG9ET0cyd3pNbjdtblJrcUc0YXpiOHVBalpKMStNYWFMZStI?=
 =?utf-8?B?S2ZDQ1NaQTVLVjdsVWFEaHY4MWcrVWRDdzc4NG95SXdNeGwzSS9IK2tjWFpN?=
 =?utf-8?B?RW02L2hhSXVLK3V4T1FvT0lWbnl2MFVQY29TWnZsSXlmNG4yKytoVFk4Wjdm?=
 =?utf-8?B?NE9EMS9UMzBaMjhHS216M2tjeHFiZjVrc2NFQmR6aDNSYVMrUU9QZnhsdUU4?=
 =?utf-8?B?SXl4TGw0bDZDcm52R29adnk5Y0F3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(14060799003)(82310400026)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:29:17.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b50206-48b7-4a87-57bb-08de573d3804
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11570
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

Hi Jonas,

On 17/01/2026 01:24, Jonas Karlman wrote:
> This series fixes a minor issue with the lwIP dns command, print device
> name from udevice in nfs command, changes to use ipaddr helper functions
> instead of accessing the internal addr field.
> 
> It also ensure the DHCP siaddr field is saved to the 'tftpserverip' env
> var so that correct next server is used for bootstrap.
> 
> Finally it make the nfs command behave in similar way as tftp in that
> it will prefer to use 'nfsserverip' env var before falling back to use
> 'serverip' env var.
> 
> Jonas Karlman (6):
>   net: lwip: dns: Fix print of resolved IP address
>   net: lwip: nfs: Print device name based on current udevice
>   net: lwip: dns: Call env_set() from dns loop instead of found callback
>   net: lwip: Use ipaddr helpers
>   net: lwip: dhcp: Save DHCP siaddr field to tftpserverip env var
>   net: lwip: nfs: Prefer nfsserverip over serverip when set
> 
>  cmd/lwip/ping.c |  2 +-
>  net/lwip/dhcp.c |  7 +++++--
>  net/lwip/dns.c  | 24 +++++++++---------------
>  net/lwip/nfs.c  | 13 ++++++++-----
>  net/lwip/tftp.c |  2 +-
>  5 files changed, 24 insertions(+), 24 deletions(-)

Nice cleanup, thanks!

-- 
Jerome
