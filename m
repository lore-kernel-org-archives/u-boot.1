Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789F0D64072
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 18:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E46F08900E;
	Fri,  8 Nov 2024 19:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iEY++ZH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE6989080; Fri,  8 Nov 2024 19:43:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA3388F23
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 19:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/jdt19h9B6YqceV+a0JlL+xEa8guGHHZrI+5+u3khaDI5Yx+3zKecEidm3T7sQrCSPd+J+hnQeRKJlRO0rSw/5GIl719tyioyokjSkoGGpwsHFpayy0e3M1FXVXwJ8btSQUsYSWWvsqLl+5/7dFa+1umB+cYrjLBkPP4XcuYb4g2q37w5/siZSo0ufNM6CZ5hB6LNXcCD03kUBCGZL2XDk/Eq53p9XmfEdu1zX22rH5aQWclFO3oOTuUy8JJUES2dwu0Pyl4+A8YrY7hjI/RNsF0I7f4o0yYuNWkDbAafFnnhybSL+wGXNXJ4t7wOVexcQi/03cdeUodsMiids4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4mBSXtTwrmhUtcMY0WzR3YNQKyiiIjFJ1oWVIHbH08=;
 b=KJlL1MkhsbJU4g05a+Dgz8sKpBLDAwSj7YbXJ321shIPlsZTR30z1Ylm+Pp8Ms7kDGKqBEqhn54ffFrLCVkc0edWGX8Abs+WA3eD9RgV5mN9ARWxA4Y8EpBhzDboYhjt+b5vFpSn6ZXK9dfuIbUbg9xJxYZIjq6umY/ALsJomKRBs0HyeUKb+nmZ67mOxbnDyGVd96JY+KaPoG2XF5ICOw4LklUvKoh0frxljcalYHeSCsRvOsuNHMawXBxWjzO1yrT5sgbctrdGOWC4/ZvZ8h6r3UAYEZ3qjZfTw1WUMtB6s1TmjMujEu0ewTox3Cd2mhkNXsMHFULfxi8MUaJQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4mBSXtTwrmhUtcMY0WzR3YNQKyiiIjFJ1oWVIHbH08=;
 b=iEY++ZH/deYdxNp3P06Yi7aQbQhnceMDCZVveQF5927vV5+uyRIGJZrflBSGocVLh+kIta0aeoExaQ6pLoUs5fQy7fZ8ghWM53Xrp0dZYD90khDq8LKOsefdRMVL0ImG5AvfmW0J0TwrwjOhkHW1I/CSAuPAy4myEY7Lm4tjQGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 18:43:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 18:43:26 +0000
Message-ID: <8e39d20e-9161-4565-afef-16c62bc0ed84@cherry.de>
Date: Fri, 8 Nov 2024 19:43:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next RFC 5/5] ram: rk3399: fail DRAM init when pctl
 channel init fails instead of hanging
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
 <20241105-rk3399-dram-init-v1-5-1e29acdf0966@cherry.de>
 <59e455f8-234d-4c5e-9cdb-d808e0f3cb45@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <59e455f8-234d-4c5e-9cdb-d808e0f3cb45@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0144.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::37) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd18d34-f042-461f-0f4c-08dd00253a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkhJcTlxWGhFVkJEU1J6Rk4vRzlMY3RTNVFQZFRaYnpSSTQ5UEQ5ejBwZ3A1?=
 =?utf-8?B?N3JwRXlxS2tma2N4R1g1V3RSQW5TcUcvYXhmbzdsd3lOWGUraERpdkg4ZXIr?=
 =?utf-8?B?UjdTRkNLNGthUFRpRzlZN09GVU1LUHpYU01xL3dob3BmWFkwSE1ZVWR6Z25p?=
 =?utf-8?B?UlNBYU1nSkRiYUVCbm01RTNua2VRa3V1SWIwb3FzMmRDdFZ5WXRjSzNxT3dO?=
 =?utf-8?B?QUNqQ3dkNXAybGEraWcxbmQyU3piaXBPaUNiUU9OUEtjZWprV3EwbE1IWDRs?=
 =?utf-8?B?amIvc2JmN3R3UDI3YmN0ZHNkQXQ5TDJzbTFwWjJBM3pFa1VUeXVnekJnU1Vr?=
 =?utf-8?B?QjhnQnAzT1F3VlBsM1JhbnR0eGJSemZxS0c2eEJZd0xSSDNSNVpLMmVVYllI?=
 =?utf-8?B?eVA1czBOL1U0VE4xbkxqaWFab1JpSlowdEhPdUlncExKRlNKNmFRNkRmeTF4?=
 =?utf-8?B?bWtVN1VkK01yMEY5bm5MeHAyUWI0V0dGaGg5L3pwR0NIT2l2cTZxai9nWXJp?=
 =?utf-8?B?MVB2Mm9FWHpGa0NLZEh1djNCaUQ4TGxydXZaaldJM3hIcUlUTldxbVJIQ0l3?=
 =?utf-8?B?eXdOWktNWWV4ZU1YSHdTS2t1cXFta1RyeXRULzJTNFhDeGk4OHlIWE90Sm1U?=
 =?utf-8?B?Zmx5Ui8zb1JmalRBY0oyZGVLazJKSmw5eS9sdmhqNjVXbkVQZUdCSGpMb3VE?=
 =?utf-8?B?OXVpRTFreWRiQnJKWWFTVWFHa2szblFBUElNSkx1dW5wOEhMNXRvVGdSeFpU?=
 =?utf-8?B?aThGakVsSEVLdUxzcSs0OUtXVi9hQUpoQmhXc2E4L3ptbmVjcU9hdE80N01x?=
 =?utf-8?B?aE82VDE2MnJ6WnB2bnErdGFVbnQxSGFvUkF2cS9IMmppUG92OGpFVExjb1Bl?=
 =?utf-8?B?aTFVVjFWTjVZYmFRTlBpaGYwUGcwMjlRZVN5VWh1akNRUzZCeEczaUJPVUpW?=
 =?utf-8?B?Q0Nrb2ZGSzZHNGtBZC9TRHZBU3JNVHFGNDVEWnliTHA5OWFURTJuM2NTSHNn?=
 =?utf-8?B?VE5DeUJDN1BucTZxbjQvcE5ZZmQ4eDk4NW9BaXE0WXZLMDlWL2F4TG8vRVFH?=
 =?utf-8?B?bkxwdTNKZzRaUjFsaHBRaE1yN3dlL0J6MmFTeXluaUV5eGhjVC9udlFYK1dq?=
 =?utf-8?B?Lys2YWdvVFFubjhOYmxCYjFaWmdHZDdSQWRGS3QxdU1LS205enVRQTJnR3pW?=
 =?utf-8?B?eGRrRDdNNTR3L3JVRHRrWHExOU1Rc0pzU0dlT1dvUW9OdXlyYXNKSkFEc1pi?=
 =?utf-8?B?dDFWcC94S0NMWlZMa2dtRmZKdi9RUG1UOTZmUzFLSVBXeTdWNTJIUDFWUlVo?=
 =?utf-8?B?S0dJSERuSEd3c1RSVE9BSG9HRzFPWUVvU3ZJUnNOLzZSOFp3eGhCb0RUZm9R?=
 =?utf-8?B?RHlMamJ6RW5qd1NXTHJxYnpuaklTTmQrRE1vYU1JdDdFNnRtZXl2K3pRZGUv?=
 =?utf-8?B?Wm01TFY2Tm9qd3g5SjZ6VTZpc0xsZ3NOR0o0OTZqWVh4R1VkVitIY0JKU09l?=
 =?utf-8?B?N0h1TTBUVitRTE91Q3ZpUjBEdHo3bkd6ZFAwdkMvSTVZTVlDblVKTnhRYnBC?=
 =?utf-8?B?VmRqWTBRcHRURU9LQjBLWkYrWDAycjN6VkJpbU4wcnQwSk5VNUIxd0VhOGFO?=
 =?utf-8?B?cUdSRFdGbThWMUxCQlRwU2dxYld4aUUzTm5BK3pQcWEvZmdERGJLaU1Td0Jy?=
 =?utf-8?B?M0k2bG9mR1VvQ0NIekJzdUZab0d6UUI4blNTMmUvMWM5Vmx5QysxVlRSMk5p?=
 =?utf-8?Q?3sKKxJGWcuvg4A0YPs06DZsY/idbr088U1dxkzF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdnVHY2MUU3YWRZSXBoK1NpTFEwTVdQVHhhVHRSUWEvUkNuRzMzMkVGY01J?=
 =?utf-8?B?VlZaQ1JpSEVUbFdldDNVQlc0cGpQUTd1YTdLZFFJZVhzTW1tM21jdUk3QTdL?=
 =?utf-8?B?d2hteVdWZ2Foc1RmQnRIK2Nza2RERWNPZGoyb2trVVRadE81dW9YWHlIU3ll?=
 =?utf-8?B?ZWZ5OS9hd3ZiTUp3dXJZY3FtMWF1amJ3QnlQcFdFNG1nTlVKZEVNZzNHZzVI?=
 =?utf-8?B?TEc1RUpJTWRZM0FYenZ2Y0p3VWdtb2UzdkdPQ1ZtYTVxVVlWTUh5UG5ZbmNl?=
 =?utf-8?B?b1dHQWt1L29qOWMwZTRGUmd3MHZTWnV1RVlVejZiTWZBYzhWNWFGaDB1dUpK?=
 =?utf-8?B?bGZSbk5TT3I4c0xSQXZOM2dvczBSeHJBYW4rczVSSDFGL3lCQWJzOFBEeFBR?=
 =?utf-8?B?b1V0MlN4cmkwdDRRV3ZCUU5UVG5xUXBJNnBVcVZ5QmNiV1JVb1VPclJnekVw?=
 =?utf-8?B?aE1TUENpMGNnTFpTR3AzWlpzM0xZc0N3dndwdThUNldnbEM5cmF3b1hpYmxr?=
 =?utf-8?B?OVg3RzR6VlN2NCs0STR6Q0V2aktBaC8yeXQyZDJodHdxc29hYUQ4OFRlckRl?=
 =?utf-8?B?RTFvTFhWeWhacHRRWW9HV3NJbmMzcGZuSnhuZDhzWGR0MkZ1SzFQYm1laWdq?=
 =?utf-8?B?K1VTSXQ3Y3ZxSWh0Q05kck1lbDk2WFBPcGJVRUlsMERrZWwxaHdjN2x0Mm10?=
 =?utf-8?B?ek9EVURNb0dYbnpxcVRvcEpGWkU3UnIrOS93RUs5R1p5OGJVajd6RDNobHlh?=
 =?utf-8?B?M0dkK253NXVoQjZ0c1ZYeU9wMUlDN3VGcU9EUUZDZHZ3RE0xeldRa0cyN2FF?=
 =?utf-8?B?bE40M0ZVTE5MNCtEMU45bHlyWXVqelpqa2N0T1FKOFFudEJQZ3hzZGdVSGJ2?=
 =?utf-8?B?Ymtadnp0WWg5T2M4N0w1MFcyMWdxbEV5c1g5ZnJ2SzAzMlozWS8zMW1lSXJ5?=
 =?utf-8?B?NXoyMXlFSFNWTHhuWFpZZnNDYnIvOG1vdVRPUUd4TlRFUlZmNzRHT01sUkl1?=
 =?utf-8?B?Yy9MT2NaSldqb2hmZjQrSllxZmR1QkhqcE9YUVlWR3F1a25pRHNyRE5Rems0?=
 =?utf-8?B?VWMwWXhvb3UwSmlRd0VwUlN3WE1nVWFOT3JGd25PVVc0QXhXZzlFWVlGMjEy?=
 =?utf-8?B?S2ZEVDRoSlJHSG1GWkQ1Vnc2VWYycXR0K2gxQ0lhdU1jUDFxeURTRHZYVm5X?=
 =?utf-8?B?YmNHMDI1aWtHREVqNWRudXQ3R1FobVZBaWExUGluWFV2QUVCY0FOTjNhbmxz?=
 =?utf-8?B?NElVT2RhdHphS1hiWEFrbWJ4VldhaVNrQVV6NVRRdWc3OXZ4cUxnSXR3S211?=
 =?utf-8?B?OGozZzFndWpIMEdjQ3k2VExTKzVxNUVmbkZnbUY5cGFBSmE3dFVKQjI4Zjdy?=
 =?utf-8?B?YWhLVHY1ZzdYMmR2elpDais1ZXZIbC9nVERBRFBjNUo2OTR0V1ZZZVhHeWEx?=
 =?utf-8?B?Qm1DNWxMSTdxRmUyTU9sR3dyRUVmNWVBSUpJdFhhK3pEVWRZMm53S2crRXNN?=
 =?utf-8?B?SzFsSFpwYXM5R2ExRkQwMEh6a2ljUEFSdTcrakNBRXRvL0ZvWDk5dWNBUGRN?=
 =?utf-8?B?QVFpYnVoUmoxUGxsQUQweTNPU0FRZ3pDNk1sT0lsQlpseS9RdjJYNXJqMjQx?=
 =?utf-8?B?MVhNK1dpZmlKQU4xa0xWTm4rekduajhhemtkTmlnRnhqQkNSQTdkWTVHWVdz?=
 =?utf-8?B?UC95L3U5aWhGNlZ2S1JGSVlDSU1tZCt6UEZaRkVZQzJZQlBJNmtKTUwycW9G?=
 =?utf-8?B?elpwWWN5S25SV2I4eXpEZHI0RENTR0dVM3k5cnVoM0FFVEhVTXMwM1NDdWdr?=
 =?utf-8?B?VG1zL2dLSnB2YTkvWkRYQlRrQzQ5L05JWnRwb2FJejNkWjlVdU9Dc3NpUEdz?=
 =?utf-8?B?K1BkRUdaVVpQUmR3cnJKNjZ5NklGcElLNVk5bVJUb1pCVlNFUHVwN2lTQWpW?=
 =?utf-8?B?RTJ3eXJFdFJhbDVBWldHby9yUlFZc0F4TXpnaHRPYkxyY05WWXkzMHBteGVL?=
 =?utf-8?B?Tnp0Rkx1cmx6V1NaUXRmeEcycHAxWHhkanhGQVk5bjl3Kzhsejd1UUl5Tk9l?=
 =?utf-8?B?VVpTeFBJNlFHYStmYWVOVHFDMDM4NzJlNGQwU2drUHVHaVRtR0xIU0QwYVNJ?=
 =?utf-8?B?QnBKR3RnUmIzTXJEZUdicVRWYW1TKy9PNHpnVVkzekNkNUFXWG40OU9XWTlS?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd18d34-f042-461f-0f4c-08dd00253a5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 18:43:26.4589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diiH6bjMtKIWys9/3Yia++3tsGSzheISoaUUB+vMDJdj4o59pFzYnpg05EPsww5fy3fOzlRoPhmn+tja1nC/73attg5r/Brx7i4BIMWoaiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047
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

Hi Kever,

On 11/8/24 4:19 AM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/11/6 01:21, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Instead of hanging via an infinite while loop, propagate the fail to the
>> caller and let it handle the fail. For RK3399, this means that panic()
>> will be called, (by default) resetting the CPU and giving another chance
>> at doing a DRAM init.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   drivers/ram/rockchip/sdram_rk3399.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/ 
>> rockchip/sdram_rk3399.c
>> index 
>> d953dda13cd3daa689fa362dc511c372db454064..591e1469afb25ba606d8f7e44f63e50905b4ab31 100644
>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>> @@ -817,8 +817,7 @@ static int pctl_start(struct dram_info *dram,
>>               if (count > 1000) {
> 
> Could you try with increase the timeout count from 1000 to 1000000?
> 

Just tested, didn't help, failed at the same place.

Cheers,
Quentin
