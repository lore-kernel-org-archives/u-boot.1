Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B482E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159B58060C;
	Tue, 14 Jan 2025 14:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JVCgyMOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D23180657; Tue, 14 Jan 2025 14:46:23 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A238D805CD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkBG7VlV/aU32JzF1jBlr7bhHvTQ5Q/sBmH5OY1+BzaJZ7U5aFO1vUiqnlxiDwqvXBthBGc80VM/zuZB7c+J6idUpAv2qu9MGSDDes2Wk/2XwQUtVX7OpvZyrcWKOkjvVykSErFC9zV2S+hFRdAXdzwKP6N5/BrFDs5jJfUebVMQ0sxAs1BFL+zLLHCMyMCtfByM4AuEQYwh4ekIS+lMBETNRZpDHjfak3XtcygmMGAn1wR8gGEJVM1RgTysILNUryD7x+kW33Acj28IhvVXIvbqlFxq2VWIOJ6TlAy9QdimbIDfjrmkz4vJnpRctCpZAIYpDpzGhxCVtd9PJSGLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbxXddySi+euEjrzfMgW3ZsitR9SQudW+E+vdJU0xQA=;
 b=VIsZEUvzCjee6l5q9sjc13jtQYoQCBthOKvntGB6DmyCL3YYZT/+raOP9ImI2lskDUBkuefhtiYLjPyOrd/LQd6R75qdlLMKC8rnU+sH9YOq9TzSeVQvzVo6uAS7dqLHWDrVlaImFT0HVoUwjV7aZB1ZZmh7mu8UfSjsOJDjcs0bylk/2f0yOm0SUuSUyBYIPIS3FBTOBmgWTRKjl7Sngvml9ww7aGsVKJmQs3M1OxZZPd7ohl/Z3s05NR3HN8OCu9Li6jasX51PrGipn2PVtAaPc1Re17JPtMHsG91t3S1gQoaSIayMfvbzmMCsCek7Wmoxjn+dFCjahi/KNfGq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbxXddySi+euEjrzfMgW3ZsitR9SQudW+E+vdJU0xQA=;
 b=JVCgyMOzgKXsC9/bI6TWbGl0cMARbouWjbVqVwtrSUMB+yeWPhhhoUFN1eTJGYSf5QdrFNW7o1HpFXeSQzzz1d0VWwvxnsO5IEA+CfiwrsmLkyYLwLaupXVAhShzHanKcEWV57gzdu3JQl1CLkJnyPoIqj4heyDiBs9aqWiKk2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:46:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:46:19 +0000
Message-ID: <e8db56de-0d9a-404c-b062-4112dd33c0d6@cherry.de>
Date: Tue, 14 Jan 2025 14:46:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mtd: Correct dependency of BLK
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Kyungmin Park <kmpark@infradead.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-6-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220222612.1757884-6-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 731b1d52-623b-4bed-e16b-08dd34a1d313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEFnYkNKaEQ3WWJXaFl5a083QlZiQytMaEJYOStJa0U3OTlYVmdha2ltWkpP?=
 =?utf-8?B?LytEWXpHTDh0Q3B5TndnODU2Tmd4UVZ0bUxqZE8wTXZTcGhNWlhaRHhBRVUy?=
 =?utf-8?B?TW4yNDRsdklncnFSYVp1U2pIQUVGd1o2cXpBR2JKOUFFYllIQTVrNnNZUG04?=
 =?utf-8?B?SDAyTVdmbWM0enlGbEJmVjgzUG92S3VnVFdHdUV4dlhvbEx2TXIzQzJmU3ZQ?=
 =?utf-8?B?OVFuV0dRNDhpeEdvN0E4dzZlcTlLa29CQUIvNGdwQUsxRzN5dFpPMTR1NGhJ?=
 =?utf-8?B?bmJNdTM1cytsQ0RYWUdDbXo5VzBFZW0wTmxQNi8yYTZOOXZXMjJTMGxPdVlX?=
 =?utf-8?B?eHlXMyt6Nk05djlFSHF0K3pwbStpbGgyOXoxdUJueTl6bk9CVEJoRUZRMDVU?=
 =?utf-8?B?aW9sd1F0ZkxjSC9aYWNhQjFaQWNsamZEM2hoYnYzQlY2UlQ5amxjU2JJWVB1?=
 =?utf-8?B?dGdUZnREOXRRdHRYaFpVT1FLaUVUQVNEMjBEb0FhUk5EUmhXcVFPb2R3dmRm?=
 =?utf-8?B?cWpwRmJPMTREOHVXZFQybThuLzBRZzFBQ1R5UmFaS21rT3Z4SHA3QmxWV2tR?=
 =?utf-8?B?a2hrcHQ0UWFRRHZQYnhZK2QxQmVHaEljbWFGS05EYzBObnNGL1N4TFkwTit6?=
 =?utf-8?B?ZlIwbDV6NWJKeis3bEtuQlZWc1h0TW9QZHZienNTdE43SGc4MllhaDI0NFJB?=
 =?utf-8?B?d3VmZENaQ24zWHV4UXp3bHRLY1NUWlBpZWxOVjZiQ09xUzgxSzZyOUY1VzRo?=
 =?utf-8?B?Uy8yRlZxMGVKWUNIODI0WXBYeW5jUUhqdFNna0JTK2daN245Y1ZiM21DamNM?=
 =?utf-8?B?RHY4b3o3VmkzMm9FeWVubnlLUDVEWlE0WGIrNGU3bllxempVTmQ4YkZjWHFw?=
 =?utf-8?B?MWNjQXJiUDVCWkxIbTNxbnBTVy8vSThQcHp1aS9WUlJEUThFWVJsMDkveVlZ?=
 =?utf-8?B?WFo2ZHp0eXpHQzVVaTZEc3NPUjF4RHVnQlVYcGRoUTJsR3AzK00xK1liVzh3?=
 =?utf-8?B?WCs4R2dXTGdOVDVSSEROT0laa0ZMUFplcG8ydEQ5K2xEbkZnbUh5NFhtcW9M?=
 =?utf-8?B?eWwwbC9jSWlKR3FxY3dWOGwxdUJ5cGFJWStQUTBteG9IVmdVZnhnUVkzUS81?=
 =?utf-8?B?L0xISmU2dCtrL21BUWRXcmFRWTNLVHBBWENOclQrQXZsS2dsWVVsbTAxSjc1?=
 =?utf-8?B?VGQrc3htaC9EZ0JIOHhEb0dOMDVDZHB0aHY0bFZDaXlyd1NudVJEY01oczRK?=
 =?utf-8?B?dnVjM0Y4cXUrUlM4cnlvVXdjelpwc3dCN0VSSlg1RDlUVUcwcEREbXZ5TVBU?=
 =?utf-8?B?Q1hLeThXUUZMcWFXZ1lnUHNQMVNpNzlWb0w5Sm5IQnVyY0hFNWtCOTFlamQx?=
 =?utf-8?B?ZWpvRHNQc0xCeHFDZEZxa0tqQkVBZG1DRHd5NkVuem90WTBBWkdWZGw2OEYr?=
 =?utf-8?B?aUxwN3VQZDVsSVptNDhBd0RxVWN6ang0NklXM3N5TTBueDlpWWQ5RDQwOHNu?=
 =?utf-8?B?VHpTNDUzeE1ROUNueVZDM2xmODk2L0RqNlZuczBOOVB4d0dOYU9HTFdhWWho?=
 =?utf-8?B?aU50ZHJTZHArSERmZ0NKelZOZW9NdEdZN3Bvd2xWZ0lxQmxoTjBNNWRTNGtX?=
 =?utf-8?B?dU9Hck51czVCNURCWU8xQnlSZ3NiMGgzVnpqYUw3U2tnckFMRENLZHloejFX?=
 =?utf-8?B?cktDY0d3WGtSVVBZOG90dEJxVURUTVRpelFjY2xOZWZSR2tpdFJaYlc1OEFx?=
 =?utf-8?B?RGNYVUZ1MVpmRmNkREY4K3VhVGNUdVI5dlNpejhmN0FjUmV2bzZuTjdoTXhw?=
 =?utf-8?Q?twHHK8FZzGrIVIUFi19h+/KQuDwJ/OmaA2bj4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0MvMUs1K3hxNDhOalhrcno1MGlOZmJhUEkrUGo1U3B1eTBDZmVoMFFNdHFU?=
 =?utf-8?B?YWt6SHQ0Wnd3ZS9IcE5td1hQQ2pJSGkzcnl1dDAxb0ZLQ3l1YWxXd0cwdkFZ?=
 =?utf-8?B?c1JFVlJVREtDSXpaYUplazkzL1c0cm1QaWs1SWsrNHVWTHBiai9kNkZLdytk?=
 =?utf-8?B?WHZPalBxTW9UWmQrNVFsMW5oVFBLaHJpUGJudDEwZWVCaVVzcTZBRHJROUZD?=
 =?utf-8?B?eXNTa3BBMi9JU2RsU0pVcmlIZVpTd0xlR2phYUhraU9DOFhveU1Qbld3UDhQ?=
 =?utf-8?B?dXRFQThRKzJaUjQ4eGxyeG9hV05pR2hOU0dwZUhTMWRneUZWdld2U3BUUlZK?=
 =?utf-8?B?Q0hqcFRkekhZQ3A4dG1aTkZLNmdKUHpQU2d2TUc2Y0ZTSmFkc2lOaUlKaGhv?=
 =?utf-8?B?S0tvTlRoVjFHRU1YZlYyNkZWR0w2OERqaGNuUDNheWloV1lyZndST3hzaDIy?=
 =?utf-8?B?cERLbkNaL0oycWxZRzArNjJyR0I1VTQ2Nzd5MktGVDlPbFp4bTFHcGtEU1hR?=
 =?utf-8?B?ZnNoaG8yWTBFWC9xZUFKMWNKcVJkdDdVRkdhMDY3Nm5UYXIvWUlUcFJzT3Zi?=
 =?utf-8?B?MFpMNnd5aGlGOUpYZXNObjdtQjNtNEhCV1B5T016S0ZZTGEzVXZmR2V5TVpq?=
 =?utf-8?B?YmlSTWVrczB3TDdRQnhjM2VNOHRUL0dpOG5vT1hiS1FoS09Ud3N0SG9kVW1L?=
 =?utf-8?B?MGlBSXEvMHdTTnpYVEFKc0p5eGkzQTh4L2poRnFhemVFRDBmSTNFL2ZjWmhS?=
 =?utf-8?B?cEIwZzFVbkRsalEyQzlLc2hmMG9XZGZwOUZqaDdOakEwekxFOVZ1QmhHZ2pz?=
 =?utf-8?B?dnN1cnpEbXNPVEJ6QTRZTGsvNElpQ3RJSHBFbUdxR29rNTRId28yMmN0ckY0?=
 =?utf-8?B?MVZDZWtKTjZtZkZENUgvVHF4a3FTQWFSbmVVQXJvUjhtQ0RPbktxVXpjN01l?=
 =?utf-8?B?ZUwySFkvTzFnRnJjY0F2ajF3a1pBQ0lNcCswbDR5YVVRVmhUaElnRnpGNnVv?=
 =?utf-8?B?TEd5YlZGMi9vM3I3UDdPNFNSOGtNR0RUNkVhZTlLRzNwVlgrSjhkc2I5d0J5?=
 =?utf-8?B?eUNsLzErN0Z3WXZhZWVJNmhWVzhXY1EwS0ZYaVFoNWJoNnBzaGw3bGxZMHFj?=
 =?utf-8?B?bFlKeTBvTXh1RW9VK2tyVzBoVjJpekpWTW9FQ2tiOEFJVzVoRWZWellmcFFV?=
 =?utf-8?B?alJKY2RBbDF4VWp2dlB5UGt3cHhpTTFaSVBtNklNNnJKOURYOTg0ZDJHa2Ex?=
 =?utf-8?B?MWwxSUN2dDhmZHROdFdiOGEwWWFyUzlCQlNoTUFhU3ZhRFB5Z2prZnZYcGw1?=
 =?utf-8?B?UjRUOFZJb3AwSDZ4dGlpRmlCM2RRR0JGdGZ1QS85SFFsNkFKM2FSb2xiWFJI?=
 =?utf-8?B?cWtRQ1JTMVpVWTVCcG1YQkpRTGJnRGNtMXFPRTFhdHZLMnVoQWFEMG11emU5?=
 =?utf-8?B?Y2FlY2E5NTVYQ1o5NVM3bkM4bGlkeURZZm1NeDFCRThrZTgranNET3FKVFJr?=
 =?utf-8?B?V3Uya0JJbEFCcG0venVwMkY5SG5lYllUNE1ZUHY3ZElJLzBPZ25hQTJMZlVz?=
 =?utf-8?B?OGFjUUt3ZVJ3c3ZESzRTQnlOM3ZPaC94QUJkaHBFdGl6MVVpNE5SQ2hqRE1R?=
 =?utf-8?B?MWZvRmliSjFqRS80TndUalNxZDZvOGJXaEQ0blAyam5ybmkzTGxCZ2Z1UUhr?=
 =?utf-8?B?aWowM0c4bmV0RTdGMTB0QlFrU3NQVHQ0TENHejROWUh4TDQ3SkcwNktpZjF0?=
 =?utf-8?B?cXNNZThFQ2lUMVVLUVB1YUFlYk5YZmJSNTZTcGprWG5zVElHRnMrWkdyMm45?=
 =?utf-8?B?TG9aV1JMd21TWDAzWW15Z2lvMEMxV3luT3R4M3psTUdveVlvV2VDOG9YdmZ0?=
 =?utf-8?B?cFFQcktFVGhVak1taGxjWUsyUXJpSXFvbzErWDcwMVI1R3Ivb3dlZ0ljUENx?=
 =?utf-8?B?dE5nTG11UUJDRnRyeFZNd1Y1M28wRCtralNJSGgwM3JrWFZkZmpSalorQnVZ?=
 =?utf-8?B?NVcrM3paenFnYTZSOElsQjRDckdSYVRZaUxud2VQYytRbWRNUjRNRkNoaWNs?=
 =?utf-8?B?cDdVeGcvbzZnL0Z6LzlDTThxczZzdnhQQ3BYRkw3YTJRekdVamxhRVlJdG5a?=
 =?utf-8?B?QitWSXNXMmZuQW5nT3JRMXFKei9Hc2U1eko2WEJvU2dmc3VtVlRVRVF4Qmwr?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 731b1d52-623b-4bed-e16b-08dd34a1d313
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:46:19.3394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYb8mmvpkaHfsSUK/xEIzk/0W9j7BvsT1aoFYj52q5XbZXHlnLZQ2bCedaY5jFxv8OoV7CZtu/XfNKiOV3oS6p1STx5Eg359L+4qasOyxcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
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

Hi Tom,

On 12/20/24 11:22 PM, Tom Rini wrote:
> In the case of MTD_BLOCK and UBI_BLOCK they should be select'ing BLK as
> they provide block device functionality and not depending on some other
> block device already being enabled too (as is the typical case).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Makes sense to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
