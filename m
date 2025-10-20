Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E10CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A05082E34;
	Mon, 20 Oct 2025 19:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i7BVnqGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C17282C84; Mon, 20 Oct 2025 19:02:29 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C53182C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 19:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzU4swgKkM9vpLm8xaZpCS1B3wsMSE2NEbt5j6savdgSfvwec56lVjZYbTEmZTeKetIogKg9BCJVFcCE5zADdt+8O1wQ55CYK6sj1FhfT8Fk+egcQFSGq49ERQIe1iRO3M9USANZGaFuA4X89/kfOhi4HPzstMwoLi3VG4iBGOBqOcAHg9MneSa7GyRW65sV3dusP9RP98unZOU0SvGgB+/HH0WD2QbX0SdA6ez7U713LNmVXbTJzcjxqPxxnYDgEy1SqNscN8ol7jbJI9hUCaVWZIS5tQXD+QsWSE5QWJB9+Ogamf8fNum12a63vFxFTScXWOQ8sawR1ce282RM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zbEAr6PK7GrxMDLpDqCFX2TxbyMQ64/PKqcd2aWTmM=;
 b=HtGwZV1tl6W5fC5AxBvfkRlTFPxL6yUWdHYKjoxvbzKlDmh+3HqzzHybiU+UPUAn6eX8643+3rLWWHDuj040oACKOZA0T4CrFWdXoki8A844zRlpl/oALx9IgwxfRYFbhN+rODEdms1Duwu++A8fyHb7T3X9XmKikMwcJUVjvWcO0igz8xkt0crwzRKPvIlHQ/2JL9S+C5f+6CyFhqgfB9Sf8ajA9eVQpn0LqWUefGknK+CPUYw5n1sI/a5KGQN6sMW67gwBg8sWk70/qFJCQgM7kOkVtfgyBY2OeeOsHpijKmiDib4vckbkHnu7Fq6Ot35F6FxvIvtdo/v4Mv2Oaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zbEAr6PK7GrxMDLpDqCFX2TxbyMQ64/PKqcd2aWTmM=;
 b=i7BVnqGpuYdxLZmZM+M+AbqffJt7k3z4q2EdzDhpg4CagX/2YHlk7K6znmGegU99HMRKc4FMxofmgTEur/3Kyt7xkgXs1sR9jvDe6gOv+P7NFIZUAXehnHs92NG7vjuKQn4nKEdv9pT27xO9A6d6DX2/tWBHFyoR74c1N1+HzfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 17:02:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 17:02:24 +0000
Message-ID: <1eb9da8c-4eaa-4aa6-b13b-4790e4d0bc04@cherry.de>
Date: Mon, 20 Oct 2025 19:02:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20251019052607.61702-1-ziyao@disroot.org>
 <20251019052607.61702-3-ziyao@disroot.org>
 <55af1d20-4dd0-4b77-8cab-035921c405a0@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <55af1d20-4dd0-4b77-8cab-035921c405a0@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: cb72edc2-a9ef-4f10-0282-08de0ffa70a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjY0QW80bmZyWXNmOGVzcVJTTmt1L3ZBK0luQy9ZRXFpcWlpZ2hxU2pLRUFZ?=
 =?utf-8?B?bVJZQjAwWnZoUDFTRWVUS1dGSEg0a1FQWWV1OU5hTGV0dXZzY2Z2d1dSTHhN?=
 =?utf-8?B?WlZha21kbG13WDJCb096REJLeFBOajc5VzJpU3B6TWpLQXdoMVU2T0NDemxz?=
 =?utf-8?B?TGlDbERPSnA4Yml1eWpCbm9rVFdFV1cxcHZuelBZK1pOM2FCR2JBemRlVUZ0?=
 =?utf-8?B?RVc2N2JFdXpjUjFLUXE2eDFuckVsbXgzU2kyNU1uMWRBNWtubmFOdXJWb21B?=
 =?utf-8?B?cHN2UkNOMTRNNVdNY3RTMlVoQWVZNGw4OTFNYjE1K0dyc1c1WEhrTW9BR1Fh?=
 =?utf-8?B?VDdBVU5iMGw3aHZlbW1jbWFKdng4blM4TG1rdG52enoyRWpmZ0I2WGRHNDVC?=
 =?utf-8?B?aGVMQUJYZXFCWWU4dFZveUV1SGRZSEhPaVIyT3RRUll3OXRJcWQyMldFdWNN?=
 =?utf-8?B?cStlUEc3OTFTVGtyeU5zTlptMENKWi8zNjVnK2h1Vkx6aXpBOUo3YWxUV2ZJ?=
 =?utf-8?B?bU1ZWWlOMG5IRDRsT2tSbzU1VjFadEtjK2NiZEUyQ29QbldiSWJuSTNTRnJ0?=
 =?utf-8?B?Tmh2TjJZTHZaQk9uZ2oxN2lzR0dkbHdDbDhrb05aMVBLWHIvTVJiRFJuMTgy?=
 =?utf-8?B?MU1EZzluOUZVT3ZkTWM3Qk1ZKzNDSHNWdUgrNENKanpyLzVrZ3hHMER3S2JC?=
 =?utf-8?B?RG5WUmxFSExpZ3htaWFoTDBLWXlRSHZXN25CZUkreDF3WVZvOUhjRkJydlgx?=
 =?utf-8?B?WmtLRVE5V0JMQ3pEYndrTlFlOEVQSXJpVFZrV0l0czlsVFBYWXR2WTg2L0Uy?=
 =?utf-8?B?UFpjQlFMdHM2dnlMc04wRUpFUmhjUGttb0lXbmJ5ZUJEdUdKTENBckd1c3dJ?=
 =?utf-8?B?VnJoenA4aFQ2dzBwaWo0UzJqS1hkeHpKVGtkNm9tRkNVN1E0NUdzUWxNVXl3?=
 =?utf-8?B?U1NFZXNhSFhMT2ZpMkZFVEg3WExpNW5tcXZlNGQ1Z2pYUmVXWHBTY3B5Nk54?=
 =?utf-8?B?MDVVa1oxYXIxZDNBWEljSngxTWo1cDhmcjZ5SkpvUVMzZnQ5TmFEOGJXNmZw?=
 =?utf-8?B?bWMvaHlhS3hzRC9DNlJudXo1MVN0dEg4WVJJNTBlSnRQMGFFQW91RTdDV0Y3?=
 =?utf-8?B?Z1NCUjk5MGhNZ0Q5V1JuZmRqankrZUFnS1ZvNkhyZ0tBT2h2UHFTOXBaRVE1?=
 =?utf-8?B?ZzRhK1RiS2xxWWR0STcweWJKL2YyYzdOcFU2NkxDVGtxUXYyeDFUR2VBd3Fv?=
 =?utf-8?B?R2Y4SEJpbHA0NGhYTkV2L1B0REF0dnVtdk5OYlAvUSticE9SajRLTXQ5d1Jj?=
 =?utf-8?B?ZmFTSnhzbDZ1cktONkpuUk9SbnRQVXBad2srSnY4WG9FSjcwK2xQalQ3d2xl?=
 =?utf-8?B?akc1ZlBjNXdLSjVNcWJyTlZQS2pRVno4OGJHUVdsUndvNCt0WWdIU2lWRk9P?=
 =?utf-8?B?VUVoaDMzVU1SSGlzbk9pREFFK0JYRjM5aUZybDM0SmVJMmZWVGRjTTVjWTND?=
 =?utf-8?B?WVlXYk01Qk5LRnZ4dU05cmFUSDZicGpVVm9ESkl4RTNMUmRpME5maVlaS21s?=
 =?utf-8?B?dDJUdUY5YTlPbHRMVUNwejMvUktxNkhxbW5WS0RuNHQ0SmhZaGRxNUx4Smxi?=
 =?utf-8?B?V3FpdzlKc2ZDZGdDQ0tGUGZDcVkrTnRGeHZQZTROdkF1TWFMSmZpd2V6L0Vy?=
 =?utf-8?B?SzZNY3VYa1NqRU9KZXN3bzV3TjBES2pOU1RRaVB6dTJqdVVyRkVmMEM3d2tk?=
 =?utf-8?B?a2JEUmx4dHhZRnNnOElyb2pBbStIa3BhSm9mY0hxVkYvWEV1Tks4T0dmRXND?=
 =?utf-8?B?czhQUVA0Q0MwUzNLdkxpL1V6QVAxTVMxQmovU0p6NGwrZm04bFhvaFRTQkZh?=
 =?utf-8?B?VzJ0dzRxZzVvYzN6ZkdBRDVUNWVEb243ZWNnaU8zN2htbE1mbEVVTUNORG1y?=
 =?utf-8?Q?BOgS9GyzOXQtF4SAkkLAS0v1DAggf+79?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE91VVMza3NtTkdxK2cvVnNvMEcrV0ZXa3FDRXR6cTVCM2x3TXlkUEZQbFJN?=
 =?utf-8?B?NTdoY0lENlNWemZNcmpTd2dzQVNOc3B3U2NKTHlGWE1kMEhBOXdpbTRKTmFR?=
 =?utf-8?B?Z2RvbXg1dzVsdVZRMHAxOGxTdFFFS0tRN1ZVTmZoR2grdlhhaVBXa3hJMFM4?=
 =?utf-8?B?a3JtQXN2ODJ6NmY5QVFYaTByMG1wd3lhZ21pV21rSXVFOE1RNnZSb0ZBblpQ?=
 =?utf-8?B?NFdpeDk4SW1DRk9RdDdqVVI1dmt2QmFrMmV5UTZSVDREUXZKMUY3NUs0ZXFK?=
 =?utf-8?B?R0FYUkdlZjRkVmwzT1VEU0pGYlpjaGMwZ1JOaktPTzFhc202MlZvaDBHZW1w?=
 =?utf-8?B?UVZPM0ZBcUVuWlZOOXU3VW9CTTdWWTA0c0hFU3hwb0RoQ1BBbmE0NFR2RUlK?=
 =?utf-8?B?YTVHbE1VZFFRb1dpZk5XeUhOL1JMdkU4YWZaRC9mRG5iWk9zb1dHQmZOWTRu?=
 =?utf-8?B?WlBoMzZic2lQUjM2YjFuVFQ1SmVtTUZSbjI3eWluWktwWWZkRmFzYXMzVnBD?=
 =?utf-8?B?Zm13d0xSaHQyWU42YmZaOUhRWURqYTBNRjhYWmJMcVVWa0ExOFJxUlJKT2xR?=
 =?utf-8?B?QlhuWXV3UmQxUHVkaTRobnhNT0pQWUdqYU9yNC9xcjBCbi9GRGhaVnNGVzJq?=
 =?utf-8?B?ckVjZVhSdmZ2cG1YTTFha0RTNnFrZGZuaWgxVENXYWthNkdjRkdEME1oM3lC?=
 =?utf-8?B?SUZhQ1FVMmZwbzFiWU1YdGg4SVFZOGR0UktYZTJ3R0Z6eWN5dzU2S0t2WUMw?=
 =?utf-8?B?VHJNcm9mWjEvbU1kUlMwMzc3ZERjanpPbTlOTTR1dFZVSlA2bGxkZ2syWDF3?=
 =?utf-8?B?VHM0WWgyL3FrSjA4N1lrMkZVTXFUOC9zbmVka3k0UXpXaVQ4eXdTZG9kTTd6?=
 =?utf-8?B?R3Iyank2eTlvaCs0WGxUY005V2pIUW0vWUsyR3ozamVzeGRiM3BpWG1aMnVo?=
 =?utf-8?B?UVE2ZHpET3R4eG1yQlZwaml3RjVBTmxMN0ZFYzdtbHRscmtKMytBUEJFSlc5?=
 =?utf-8?B?akRpWFpFTFRlcVE0dzFjOXJGSzBDZHY4SXFFWVpIRjhrelJ3enpqRW5YeDVp?=
 =?utf-8?B?K0t5c09hYU9PeDhVQlVZM2h2MkJBS2dsN3Vxb1NLYXJwS2cvYWh4UFdhcjY3?=
 =?utf-8?B?VFFFUUdaOGFtR2xYNDdaTi9mTzBNTm8xaHlnN2xDdWRYd3h1Z3FDYlordGM1?=
 =?utf-8?B?a1VOY0xtb1pxL1Vjc2xnNFZmRGdtUXhrMzRZMnpua3FoSGpxUVAxakpBNURJ?=
 =?utf-8?B?ZjFFVXlFOGgycHdTQkQvQ0UxMlFRS1l0cnpPR1VSeG5ramdyVlNta1dLVmVl?=
 =?utf-8?B?R0NhQnlOSExvejV3UmVVb0R2bnI1U1lnMWtlWE5YQ2ZtYnZXR2NmWmVraldJ?=
 =?utf-8?B?NkF2cVlCK0pYNlA1NWVlQlVlRjFlNWlWZzJ0VjNyVzB6eGJLRzZwVDlhbU53?=
 =?utf-8?B?TG9kYytOSnZPRHFKWUNUY1orZzF5ZzFzUzMzei80TmFVTGFIYnh6Zk5UTmcy?=
 =?utf-8?B?SXJ0VUFmaXFsRjdacEFqT1VIaFRkZUxCa21DeFZnLzJWOWZUVTRFOWVHWFY5?=
 =?utf-8?B?V0pSZ0xhMUk0OHFXVzdnMHlSS1MyeStTdG5JOFNxZ0ZFM2ZDTjRLMmV4Szg4?=
 =?utf-8?B?YW9xOFlJdnExUnNJYTg0VnI5bXVNUkh3TWxrNExRS21XRUFnZ0ZZU1Ivckkx?=
 =?utf-8?B?dEZqQk5ycFJVVW5RMnhwWjlFMWJTQzMwN0dSMUZWQ0ZwOThGMURSVkp1VUtl?=
 =?utf-8?B?WTYyWElKWFBJdDl3N3pHYTFYMzFQUTlwTnVHZys5Q1ZMMjhhUlNQUy8zR2t6?=
 =?utf-8?B?czZLQldIRzVCdWwvMyt3YVBNK0xJa2RCRmk2S3lRVmhCTXhEdU5SN1M1WEpP?=
 =?utf-8?B?YlROQUZWL3VpN0EwMFNya1pPYWNpbEM3N05tSjZTWUdWZGYzc0dSUitWY2lu?=
 =?utf-8?B?SkxWWWNtZnNnU0FVWDd1UlUrZ1o5VFBMRWV2YTA2S2lMOVNTZjFnWW1GQjBj?=
 =?utf-8?B?ajE0VnRuWUpUWG1XMkRYbWxXYU14UTdmRUlCYlZHUEw3M1BaVndBSVlxbTkv?=
 =?utf-8?B?NDhHd2tzb1crS0RoYUEveUNOS1pKUUxaYW1jSUpPT01jQlhRdXNXRkEwZTRa?=
 =?utf-8?B?SExtK1RWaVZSRHd5RU9oY0JpTVRpQlFuSUhQeDhTd3FEYUcwNE1jZFVPQmx2?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb72edc2-a9ef-4f10-0282-08de0ffa70a6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:02:24.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOCjTWZsEGrbbFdwg055rsQQHoxKNMdLYVtHFGXotICK7gLq4DpTqgg0634lT+fkl/H0E51el7rsGkoqu8s2iPEpxJk6qo8Q3I1DHNnX+ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531
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

On 10/19/25 12:52 PM, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 10/19/2025 7:26 AM, Yao Zi wrote:
[...]
>> +CONFIG_DM_REGULATOR_GPIO=y
>> +CONFIG_PWM_ROCKCHIP=y
>> +CONFIG_BAUDRATE=1500000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550_MEM32=y
> 
> Please add following to prepare for future USB support:
> 

I don't like this. Whatever is enabled in the defconfig, I'm expecting 
it to work when I'm testing, so I would rather suggest to postpone this 
to when it actually works?

In the end, I don't own the device nor do I plan to, so whatever floats 
your boat :)

Cheers,
Quentin
