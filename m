Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2507FD5CC8C
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 10:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9DC88FAB;
	Wed, 30 Oct 2024 11:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J0qKrsPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EBFC89204; Wed, 30 Oct 2024 11:39:36 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489CA88C05
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 11:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sozmPYvWiANQZm1q7SNmJgQLUjmTrX2BnHGY+acFxeDYqz0DmMHi55A2jbjnayBU3xr5lDOF3mXRQLr3mP9w+xZChrOpR6dxNOVKDv3c8jKeq1HKIOIwqieYFzYawWZlwL/kO/pe8Qi26pNGQ+JEJA4q0YBsBxPxzKqboPtRXMcROAqY0GnOiLt5rqo2jUFeYRqWqKl1fwCoi8gyQlvuHDlQRCWu5r3pfwnEFJApc8/4HFNOU0iSqYkUYfz61JkCIpY0XhbyM75R0uTLWym6/EgPpE8HYn36RKsrLZzuvAnoJILxahL7DWsQsQseMLmA94xuVomsp9cpQIfCkFuaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFIve7NH6MS5+eSIDh5xmJ042OnQWNVMfRh2svl2brk=;
 b=ixUUjwnUetc8MnXzsXKmMorhLsnkexO1syDOXZ2ia6rlN2dBuRv1vhZc6VGqpDUBxJPWggzNgzFwpvo+gal8IZ9PbOAdezsaHH1rYoDlEXWyPoxx7x214iY5We3cLCefNgeFVlxmA+af011QODo7GJaoAeSfGVHSx+yK6VqtTvOBK4yFHtQFSCSVmG/u7d/qI9PSMYmwQYKCZZMUNAjfRDktT1b7uC6jOEknFFMv1unm4n4wY0pLcSmCHYnXmAA00LgoY5nF303JKmrcv7fu8B+gq12qJtD7Nom/LptpIlLPp6HescU1OD3WP//CNxRAb9zDjFDXPJf+a8QnXYOy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFIve7NH6MS5+eSIDh5xmJ042OnQWNVMfRh2svl2brk=;
 b=J0qKrsPuhcX23eKxlfTkloAx27gVFyGelrOOtqL8VySnBHjdMow40rCrk+cnGFRSe/1fYzh+lcVZFlA7qwZus4dvcRTGRJVBjpY0tmyayrvD82ADINDoZysZgPkMts+wQlcewEFuJhOV6LgR8hMKSWx+AAXnq9O2Yk7nS2w3u7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7461.eurprd04.prod.outlook.com (2603:10a6:10:1a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 10:39:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 10:39:31 +0000
Message-ID: <9cbadcce-3e12-45ba-95f3-a35e29f4dd88@cherry.de>
Date: Wed, 30 Oct 2024 11:39:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: add support for Radxa ROCK 5A with SPI
 NOR flash module
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se, sumit.garg@linaro.org
References: <20240824223343.98577-1-naoki@radxa.com>
 <20240824223343.98577-2-naoki@radxa.com>
 <A486B5CC87D82BA9+a72f088c-d1ac-442a-86d5-9e1611492000@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <A486B5CC87D82BA9+a72f088c-d1ac-442a-86d5-9e1611492000@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2562ae15-36c9-46e8-714d-08dcf8cf2380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anNDRXA1NGNmb2x5MUlBaVlLODdCRi93R2gzZzZXWTVabVhaditNcTIzVnVa?=
 =?utf-8?B?N1kyS3A1bjUrRkhIYksyL0EySGdJZDUrclNZcjFqaE5sWk10dGE2MmY0UFFU?=
 =?utf-8?B?NWZkTktoMXZOcUg1WTg0SjA5aHdaWDkrL3VDWVRKS2hwdE5iY2I4VTBGUEVy?=
 =?utf-8?B?VDZIWmJxOUMzVEdIUHVIMHRsMG44cTJTOEZuV3NEQVpnODRJWGZkYnZIT3pw?=
 =?utf-8?B?SWRpa2tWM2gyVUh1blZ3VDJTY21tZzVaOG93VFhDS0dXVXpoMTRvb2UxekN2?=
 =?utf-8?B?WVNPMmJiY09PV28vUGNIZDhGcmFyQTV4SkhBSEUyWG84amUrMnFHVTRCMzNH?=
 =?utf-8?B?YjlpZnBRSzhmcDNKZWExQ0o3VXlyaGpWSytWSWwwM201ZkZJUkdtS21MTHFs?=
 =?utf-8?B?bjNESFl2cC9LVk5HYXNRM3NWVTE5WUJacGFTWG1hZnJUZXdpYnJMcTY4T3Np?=
 =?utf-8?B?RG15My9FdkRGVDI5T1VnNHpVQmR4VCtvUmVxKzJrOGdLcm5YZG5MR0xHVWx1?=
 =?utf-8?B?MWNxSm44UEE0OFFNT3pMTzFRVFptTWxNYTgzQ2NZQU0vMFo0TUErVVZsQnRv?=
 =?utf-8?B?WU9MMTZhb3JOaittc2NmMnkySU1CWkg2WGxIaHJIU0hteU9ubVptdFFoMXZr?=
 =?utf-8?B?alJZN2ttM1lFd1QwQWxKNmhERjlzY3FXaGFuMmxFU0p5SkxrczJCVHBrQU9r?=
 =?utf-8?B?OG0xL2tkbWt2Y1N1NVJtRkdLV1VQRld4bm1oRDNuR09LZEk4OFpmZFRXWktC?=
 =?utf-8?B?WmxIc2l1UHhMd0FjRHFnMS9PcFRkbkFERUEzZUgyS0lZU1J3OElISEZ2QXFB?=
 =?utf-8?B?SitiTngzeDBVWllhNmN6YS9TVFFFS3E1NDg3b0lkQXU0WFdBZ2NMcmFSa3NH?=
 =?utf-8?B?enNiUXk2eW9aT25IbzdXQ0pWK1hvdVpndERieUhYelQ5S0M0ekVEYTBtVk5F?=
 =?utf-8?B?SFRIeURRbVR4Um1LMHlvQnh5MzJrUDN2VE1vbDQ1OEY3MXp4RkowM2lpck94?=
 =?utf-8?B?V0paSTJmY25uNndueU5icXpxNW5xV1FnU1JGTDc3bmtNYmRSY1pxY0NrZHdR?=
 =?utf-8?B?S1FTSkVkNEFKRkllN2RSZ0w3VG44VHg2WmZFMHQweURaV3dpaFJJNGVqQWdx?=
 =?utf-8?B?ZDlsU1RQOUJBTEdqbXJUdDBsV2cyT0JsdEdPeUpCOElRUHdyL1RjZkY1SlZ4?=
 =?utf-8?B?T3NobFZHaE9NdGo3VWZkS2FaNHFjSFlwMlB5YzU0RW1MamZJZC9kdCsvVGRo?=
 =?utf-8?B?eENUdlE5OVlZSURaTDV0MmZMQWY2TUlmckxDQ2RmRDNoUjROR0UzTjFMaVQ0?=
 =?utf-8?B?MytvQWkrNkk2UUtDa1BYNXpjT2Z4TXZKQ3loTWl4Zm83S01OYnV3WjZlUmUw?=
 =?utf-8?B?ZjNUbUhzbnhBRXQ4WGZCaEplTXVsUG14SWxqMTNQdmRUS3BaaG84VHVuZjZ5?=
 =?utf-8?B?TGNMNW1hTVZuL2Q4a3FKZUNyNS9kUng3UVptMGswemd6K0RwYzFJN2RUMEIx?=
 =?utf-8?B?bTVUbnlpSXhGMEF0MjVQS1oxODJSQUJEVGpFSkFXS2dQZ20yb0gyeUNjUTN0?=
 =?utf-8?B?SHpNT3I1QWxxZWhUZTg5K0EwTVFvS25WbzlzQWdGUnlHdnBYS2pXeGpubEpD?=
 =?utf-8?B?dHNhS0V3RmhraWFtdEZhS3lSSHNqQmY2enJrSXRUL3NWbHBSSXNvUXRQdW9I?=
 =?utf-8?B?VXBOY2Y3dXliWlZOZ3YyQkszS2dJYUNlcUVQTXFYUWhHeHp0a016Rk5HdFRs?=
 =?utf-8?Q?qxaRgckiDFkAAI3mqE89oIB/ejqUHSZ+jqwWd2w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFVUEgwK0RnblFKeWVYSlh4VTBEc1hJc0xhcU9YR0FSQjV1OUhLRDVNZVdG?=
 =?utf-8?B?Q2VnLzlIRjlWSWV1eWtQc0ZVYjQ3aVRkWjVqT0htb2t3bXQ0eUtFeHdQV3Mx?=
 =?utf-8?B?TTJpVGpKRVE2RDJ2V1hNSGZ0aHlPMFFJS3hueFVqRkhlRjBpWGxKM2dLbWFL?=
 =?utf-8?B?Z2svYVpDakV0U0U4QzR2dmVEV09hY1pSNTExMjlSanZPa0QwZGxYeWFURFQ4?=
 =?utf-8?B?NDU5Zng5TUtxLzdlaDJuS2lINFd4a2JyWFVQL3gzc1lQV2w0YUprMnhxazdp?=
 =?utf-8?B?dk1QR3NGL2NTY083cWFaZzZlYXlQZmYzN0ZiZmhlczVGYmg3NkZXV0ZseURw?=
 =?utf-8?B?Qm9jc21CNDZhV3ZNaVd3TERtdHlURGRpQ1dDN1l1OXZvN3ZiVHpGZmNHeGts?=
 =?utf-8?B?Y2dQU3RGckc3Nlp6VTE0amdUZkRSdXhHUENWbnVPVGtGLzh3NjE3OUJJR0JH?=
 =?utf-8?B?WXhMZ2tlRVF6VVc2S2FiSjJVRkJ2ZzBkeTFEemtteXVKR2NJMU50eUFKNG5i?=
 =?utf-8?B?Qit2WEoyaU84SlJCMlBDbDJ5RzlnUHIzTXRhWThyZmwvaCtLeXJoclFTTEJR?=
 =?utf-8?B?VnI3TlF5R25lRFFkSHlKd1BzYWVrdTB6M1owNXNkZ2I4elFZK1hSMXZQUGxV?=
 =?utf-8?B?QjZQSThCSFlUampLYmFFdVFsd2x6ejhRMENzN1ZBRGR6MklOQTRLN1RSN25H?=
 =?utf-8?B?Y3RSWFNUMG9mdjI1UTk1dGg2OUxzMWQ5Sjl2UStBTm9BU29EUGl2RyttZEZQ?=
 =?utf-8?B?azI3ZDA5aXVVaVdUenpwbTNhK3p6RTdGWkQ3eEI3VmdpcC9mck9qN3IxZ3pF?=
 =?utf-8?B?TjdQWUZ6MUVZNGg2d1VGWTFLVloyMW9yUzR0b241SGlvV0dJS2pLc09GblJ4?=
 =?utf-8?B?M25pdk5GR0hsZkw4aTZXRTVZeTRXQzJnM29ubENSeFRsQ3JRa21WbFBXR2RQ?=
 =?utf-8?B?ckhBaDZvZU9reXdxdU5hQWw0ekhsYzR2ZytFVkV0dE5CTW56RjZHYlBGVFQz?=
 =?utf-8?B?YjBEWWpSTFpTdHlIWFh3eDZpU29WV2pIa2FUZThNOU02clZYaUtsaXYrcmty?=
 =?utf-8?B?b3ZESlZVRE9jdkUvWStqblN4ay85dHJsL1pNZVdHN2svbGJtRVZUSHZxSkls?=
 =?utf-8?B?S2ZYVTdaWTNhRVlra0JoTWZKOFRQaVVhZGJ1Q0dVOFBXcFJrNWFPcXFheHgx?=
 =?utf-8?B?TGNyL2xzVURkYUtzSElwQytWMnBVd0hYUTdEUmdaVXp3Z2ZvZHJHd0d3U1l0?=
 =?utf-8?B?SVluRWpYTkphZFFHOHc3YTZpVS8vSzlyR2FHYzRpK0J5MDVPdi9uYnA4dzNh?=
 =?utf-8?B?YUhLSGl1NzBxd21waTBqOWRCSEE4S2J6RGFkWElTS1krdWVTcXROZktKa05a?=
 =?utf-8?B?MDNmZ3JiWEo5ZE9TYlBJMzJiQksxZ3NJM092dHlWczdkZWwyVnhwQ2dtd0pn?=
 =?utf-8?B?NXl4M253bURzWWNKL3NPSnFQRTBJMUx4VjdERzFpRGxJaWRqNHJnMEVZMWtP?=
 =?utf-8?B?T1R6NHUxT2hvUDQvZlpoZkhRMmRFYmhSKzJMRnMzZzRuTzd1MlBBRVFWUTd4?=
 =?utf-8?B?cTdOQlhXUmR5Z1hGT2hVSktid3RhaWZacHk0VnpwV09QeEc5SzF2VVhKM2pm?=
 =?utf-8?B?UWhSZUdYREhpRURVWnV5OFRGVVAxZVdha3p0RzNvbDRINjVQVnU5RTFIZjJh?=
 =?utf-8?B?dmd5ODFQVGl0ay9qekFXcm9vVXYzNFF4YkdzQ1owZnZPYVlTSlJWZ2hkbktK?=
 =?utf-8?B?enR6dlJKemhyWnFzcXozZUt4dkREN1V5VE5pNW55S3RNV3FNNDdqWFNjYWJo?=
 =?utf-8?B?YWNNRzJzMURYcEFUc0lnT1p4bitnbHZhU2lMb2tTQ0hCUXZFd1E3aUwyYnlT?=
 =?utf-8?B?L0p1T2dOdzVWUlQ2QWRScTQ3T1M2Q1NPVUFyWHZGakh3bjdNcVlhNVQzRjBi?=
 =?utf-8?B?QXBoZElMQTA2VWVvMXB6ZFFORVlwc2FiUm1qRVJRb0dhRW5vVk5tMjlWSDlx?=
 =?utf-8?B?a21ZL3FxNElBQVBTeXVFVlU0L1Z2TDF3VUlwQXR6a2RianZXdUVXbDkzSUhH?=
 =?utf-8?B?dnlCNW5YMEVzakpWL2xCUTJZazBuUGltSWR1MTVrOVZtR24rR2JwOXc1TlJz?=
 =?utf-8?B?UXc3VmdCU0dublE1dnRNaGZ2clJsamt2b0pUOXIvajRrU2ZaU1hvMlJObmZl?=
 =?utf-8?Q?a1Iv74/UbOjbHzcTiYj8k0k=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2562ae15-36c9-46e8-714d-08dcf8cf2380
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 10:39:31.8823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOEPJ4mvT6g4jn2xTdx6BzSfj3VQFzfkqd3pJ/+ckoPP4bFUVVUr450qob2AF6WGsI+zXBC2OE3YkHCZKDsHrTq7S9dw0mRXG9S78xhO4mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7461
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

Hi Naoki,

On 10/30/24 4:09 AM, FUKAUMI Naoki wrote:
> Hi,
> 
> could you review this patch, anyone?
> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> On 8/25/24 07:33, FUKAUMI Naoki wrote:
>> on Radxa ROCK 5A, sdhci(eMMC) and fspim0(SPI NOR flash) share pins
>> (i.e. eMMC and SPI NOR flash are exclusive), new defconfig and dts
>> specifically for SPI NOR flash is required.
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>> Changes in v2
>> - fix subject
>> ---
>>   arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi | 24 ++++++
>>   arch/arm/dts/rk3588s-rock-5a-spi.dts         |  4 +
>>   board/radxa/rock5a-rk3588s/MAINTAINERS       |  5 +-
>>   configs/rock5a-spi-rk3588s_defconfig         | 83 ++++++++++++++++++++
>>   4 files changed, 113 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi.dts
>>   create mode 100644 configs/rock5a-spi-rk3588s_defconfig
>>
>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi b/arch/arm/ 
>> dts/rk3588s-rock-5a-spi-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..5cd131d3cb1
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2023 Collabora Ltd.
>> + */
>> +
>> +#include "rk3588s-u-boot.dtsi"
>> +
>> +&fspim0_pins {
>> +    bootph-pre-ram;
>> +    bootph-some-ram;
>> +};
>> +
>> +&sdhci {
>> +    status = "disabled";
>> +};
>> +
>> +&sfc {
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        bootph-pre-ram;
>> +        bootph-some-ram;
>> +    };
>> +};

I assume the board can only be fitted with an SPI NOR or an eMMC and not 
both at the same time? If that's the case, then the status = disabled 
and status = okay should be in the dts. I assume we want this to be in 
the Linux kernel first too, either as a separate DTS or with a DTSO (not 
sure what they will want).

>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi.dts b/arch/arm/dts/ 
>> rk3588s-rock-5a-spi.dts
>> new file mode 100644
>> index 00000000000..780e90d041b
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi.dts
>> @@ -0,0 +1,4 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +#include "rk3588s-rock-5a.dts"
>> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/ 
>> rock5a-rk3588s/MAINTAINERS
>> index a569efa74e3..06ebc9829f4 100644
>> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
>> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
>> @@ -4,6 +4,5 @@ R:    Jonas Karlman <jonas@kwiboo.se>
>>   S:    Maintained
>>   F:    board/radxa/rock5a-rk3588s
>>   F:    include/configs/rock5a-rk3588s.h
>> -F:    configs/rock5a-rk3588s_defconfig
>> -F:    arch/arm/dts/rk3588s-rock-5a.dts
>> -F:    arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
>> +F:    configs/rock5a*
>> +F:    arch/arm/dts/rk3588s-rock-5a*
>> diff --git a/configs/rock5a-spi-rk3588s_defconfig b/configs/rock5a- 
>> spi-rk3588s_defconfig
>> new file mode 100644
>> index 00000000000..297278c7a06
>> --- /dev/null
>> +++ b/configs/rock5a-spi-rk3588s_defconfig

If Radxa starts having many such options, maybe it won't make a lot of 
sense to duplicate configs but rather have config fragments to change 
the default DT and add a few symbols that differ from the base (I assume 
we may have something similar needed for rock 5b+ compared to rock5b for 
example?

Keeping all configs in sync for essentially same board with small 
differences may be difficult, maybe using config fragments will help?

>> @@ -0,0 +1,83 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_SF_DEFAULT_SPEED=24000000
>> +CONFIG_SF_DEFAULT_MODE=0x2000
>> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a-spi"
>> +CONFIG_ROCKCHIP_RK3588=y
>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_TARGET_ROCK5A_RK3588=y
>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> +CONFIG_SPL_SPI=y
>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>> +CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x40000
>> +CONFIG_SPL_PAD_TO=0x7f8000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_SPI_LOAD=y
>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>> +CONFIG_SPL_ATF=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_SPL_OF_CONTROL=y
>> +CONFIG_OF_LIVE=y
>> +# CONFIG_OF_UPSTREAM is not set
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned- 
>> clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>> +CONFIG_SPL_REGMAP=y
>> +CONFIG_SPL_SYSCON=y
>> +CONFIG_SPL_CLK=y
>> +CONFIG_ROCKCHIP_GPIO=y
>> +CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_MISC=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_ROCKCHIP=y

I assume out of the MMC_DW_ROCKCHIP and MMC_SDHCI_ROCKCHIP drivers, one 
isn't needed anymore as it's the one for the eMMC and the other for the 
SD card?

Cheers,
Quentin
