Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17A7C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 14:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB9980BA3;
	Thu,  6 Feb 2025 15:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="B5utPjST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F6080B9F; Thu,  6 Feb 2025 15:30:09 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E2980AE6
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 15:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mId552m9YKqBHAcaxp8a4bt3nfNqe0eovaRqK/masrlx6jGoMJLnkHrDnPLxMUd1yWXOD8mmBWhoHT9nP4XNsLY1xSVxP+tMRk/H4IEsGVinS6cz29TvOiBq2NjLSyZjLS5+EGK853YUFZRWWSKK3RvGFs2ZZBHqStaXM7DAsefqR4WScR1aQcT0C36o+JKxvKEjr2td+O39F/I5m4+LZzRx64g4qh+A+fAALBshfjgDPTZSYa904qCzyJrkqo2kc8NzUxQna1QkkugVwB19XMeDxmOEbUUiwOGlW/kh1bAYbYFRnxW+nueDIWplmJGFIQHCcyvfvG8TMEKTCYQwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m/TvYkSQLsGe7BFvLtr6uPT7CG0VlO3Gu/mb7tZl9A=;
 b=pilezYz4x4LaLGrb0tiKshFxThChGg5D5E4uAL9QjeUXZ0PxFpt8nG0PyIm/gLgeTkCDVpyjdFkZT5C3PVlkn3adLRONIunzPrNHGHCWO7983lYdgdSQRtiNhqQwys9d6PTSxTUvnbDh9cptzBirx7XTWGdtni0WFRnss3TRSz1a7Fvrw6/Oj4zZ9CfBabTrPyeUBCQAp5HSUVZEFszaJO+myXO13t2iHBussnfIEbpJ0y5spts/TE8kPR9yh7Pmu46tudqeuTh9LDnu9Ya9VjV4HO0rMkzsxLuVx2lh3ycMM5kv6/kRU1/vwE2ajytsOZoa0L8SQOFqy8GMCI9a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m/TvYkSQLsGe7BFvLtr6uPT7CG0VlO3Gu/mb7tZl9A=;
 b=B5utPjSTOmmRhgaZFdHg3eRdI5U2A4sdOjTFrro5E78YqBp6VaAAerU6y//tsSv8qiNqs0GFU32ibHZeXov9M7StxkzdLwTeuwhYPik9KHg3kXbiwuDNbOq4vpTpnA00NWlA8B2Cv61GW39T9iG7PECxV+ru5tOtMloh8JdYJok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10840.eurprd04.prod.outlook.com (2603:10a6:10:58a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 14:30:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:30:02 +0000
Message-ID: <f9dbae87-585c-4ad3-874f-e49e1a63ef9e@cherry.de>
Date: Thu, 6 Feb 2025 15:30:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: mkimage: Add option for image load address
 and flag
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-7-jonas@kwiboo.se>
 <35d4ce24-ffc8-4500-97d7-d1da8791e435@cherry.de>
 <fc174546-e071-4ca6-939a-c9e1bfceffc2@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fc174546-e071-4ca6-939a-c9e1bfceffc2@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR06CA0098.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1813cc92-1335-426d-823a-08dd46babdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlkvcUg1VnJCYWtyeG9jTUZuTnV0Lzg0b3BwbFNGbE5EcWRKdFFudVRUbzJa?=
 =?utf-8?B?VzN6Q2QyWUdCRXpTTUtvRCtEOGUrSGFrRi95RGtlRjVFWEdEbzdGOVlhbmJ1?=
 =?utf-8?B?Y05OVEhWMlZBSkZpaTViSHMvTCtEeFdieE1XUEpxZlVTZXo1Mms5V004L0F3?=
 =?utf-8?B?NTd0SjUyT2hFTkcrWGtTVnoyRVd0QlZFRVRaeGp3N1RvYUw4Uys0dlZSekhN?=
 =?utf-8?B?RjVJWHlRdVc4dXVKNWJ1Ky9uay9GY1lYNVVucW0yeHhRSFc3Yk55TmRQc1hY?=
 =?utf-8?B?eGRkZzNIbmZiYlRQOTFnT3VWTFNvekpXci9hdzgzVmMyQnFpYTVGWTY3blVM?=
 =?utf-8?B?MjZvWnpYakVsdlZTQXJNZlp1cEtZYWJ3Y00vbWFtczhHVFBEM3dFd1pYU2R3?=
 =?utf-8?B?UHAvRW4vMVJ5c0VneHk3R1QzNHJ1TitrdDBWZlJpQ2lRNG9HclhFZ1Bwczhp?=
 =?utf-8?B?UXBQR1Q0RTdIWTNybWpOWnFkcVdvUWl3K1RvTnFkQTIrbGw2eTdrUld3ZXJN?=
 =?utf-8?B?MzJwdDBteHFRMEREaWVOd3hTamozUW5oZ2tQampGQzBOQkNCNFI4RHp3ZXFr?=
 =?utf-8?B?Y1cyTlJtV0tneXgwbW9NUEdSWHpQUlpseWZnak4yc2ljdGtoK21UVkFBK0x1?=
 =?utf-8?B?K3V3Sy9TNms1VFBoaG5ja1RwZ1hQcy9xUHZBaGRjMG55Q3BlUy83bGxFVlpS?=
 =?utf-8?B?ckJydklFNnVSUEFLUnZSa2R5VkN2OXkvazBJRGwxTExaSk1lSTJZWTZJZ1J3?=
 =?utf-8?B?ZlQrVGxYYXlmWUNzOG5UUzNxM0xCNlhaMlE0OE9tT3BkNFRzKzFpdUJMK2RL?=
 =?utf-8?B?ZGhJUTlJMGxnVlJFb0VvaWV0Mk8rd05Ia2Y4NXVLR3gyOFhwVXBkTkgxVVMx?=
 =?utf-8?B?dnJDNHlkaXZTNGljNUI1Qi85dzd6dUlRdWhhb2pQYlVaWmwwYWlkNG9SRE84?=
 =?utf-8?B?SUE2aWxiV0lXOXJDNnBnV1lIT1BiMnlxRm9qRXNjV2RJUUVpQzExdW9yUW1N?=
 =?utf-8?B?UThZRHVzdDl3RXEyZXYwS3R2eVNUSXNpamFVc0hJaE9VSEhTRU9MQ2RFVE5n?=
 =?utf-8?B?YjJ5aGpOcm1XdjltdXQrUi9Qb3VKNUZkODJrQUNLZTV3SzRFcGhFNjNTeVRV?=
 =?utf-8?B?ZWpMYjkwTE9hOGVJbElVODRlOXdQR29DWnhSQ3VZZjdORGMrLzJnWlZNL1cx?=
 =?utf-8?B?NEFKMG5BNFBaWGE0d1J0d2g0THZ6U0VRWDBQVER4TU1WbFN1cHlYTWNkN01M?=
 =?utf-8?B?UksrV0lqOEtCclZGd3BwZjFCSzJaMVN5T0hkRzMzTWJNR09oNFFKWFZBNENP?=
 =?utf-8?B?Z2FCVUpSeGZoVzV3dm1xQmxkS1R0Ly91cjNiYmhmVGFOYUN5ckhzaXlCRTdV?=
 =?utf-8?B?TjVja1ZyMTR0V0FPZWh3amhVejdjRFVNL0ZwbjROTklKTGlZWkYxTFdYMy9H?=
 =?utf-8?B?Vno5cm4rdEVmTjFlRFNGbU52WnZNd2J0dVpGdUI5NllWaTFqZy9KTDNYZDdF?=
 =?utf-8?B?ZlhFMGxKaTdXaUROQWZKZDA3L2phb0ZDOUJWaEY0ZFY3cVlsQko5UnQyUFFH?=
 =?utf-8?B?aTl2UmpRVCtsaktNeXBQTUE4OURkaUFkT0tRL0FETFFLMkdHUzZCa0xRM0o1?=
 =?utf-8?B?cGlTSEhTMkxha2FNK3RlRFNmWjNjaXoxK3dSbCtKcTRxQWJPOE1UeTVmd28y?=
 =?utf-8?B?MkMxSzN3TmFDTFZMT0FRRSs5UEhwM2xaR0ZYRGpmTWx3T2dIUVVTbHVwdWsy?=
 =?utf-8?B?YlBwdWJqYThhWURyUzlyQXl1ckpYVDVNTXpmN0lsVFVyN1ZET09uOER5REx1?=
 =?utf-8?B?ZjBtWmkzcVRuVk15OUx0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZVb0lsb3ZlbTl4aXYxcXUycW43Z2J0OU5FTFUwNFZjUTgrSFdsUzV3VDY2?=
 =?utf-8?B?b0lxeDlySWZJZU9sa1BGRnlCSGhDMnRvT2RtOTV4QWdCTDd6QUd1MGxzZkFt?=
 =?utf-8?B?VmtwQWlEK2ZKOUREM0swM1ZnVExoOTQyTkt2Um9LczlhajQ2TVBjMnNibDBk?=
 =?utf-8?B?Z3N4ZVArYkV0UkdvNmtVaGhFRGVFc0FpMHl1WWFZaHgvOGhWY3lzU2lUSlNt?=
 =?utf-8?B?MFFUamFxdzZ5QzArSnBSeVFMVjFtV0hxTjRwWlBlTkxHb2huV3gxR2E5Wi9F?=
 =?utf-8?B?czB0cWdQQndxSXNJWU84V00yZkZPdk1hc0U3aDBqZUxEMy96c3ZpMkpRNmhS?=
 =?utf-8?B?Ty91ZG51NU1URDJ4emU1dmJkUjBmZ1lNcVRZQnBVWjVNSDJjc1BvM256WDc0?=
 =?utf-8?B?UVRUVGVDak9QOE9JaXdXenRhaEhJNjhQNi8rRFBoYUxMSEdaSW9DT2FNWGdn?=
 =?utf-8?B?NVBsODIyM212c1ZUT0ZWa3l0VW9mVTdURjUwc0szZk10ZHZVKzkwQjdvUUd2?=
 =?utf-8?B?UlBHeEUvbENUWGZXZTI0RHB6S3U1bElPaUwzcWRuM3hSMElJcVJoZ1hsNndO?=
 =?utf-8?B?UXJhRS9kUEV1U2kva25mN1FXbU96TzhzTUxUN0c5TlhGUTQ5NysxcHNrM09n?=
 =?utf-8?B?clpzSUdRVUNpTFo3NlBEejhSbkhyQVdldzlINVZPZ25yNEVINlRsaFQ2NFZJ?=
 =?utf-8?B?N0tIZ3N1OWszRjE0Y05RcHcwZmZJa201THRGWjdrZlZMdURZL1F4TlBRazhn?=
 =?utf-8?B?aGE0aTVlUlBWcEYrNFNHemQ5eUJ1U0NvMy9OUjk0bDZBTnFhOUZkS2R0dUVl?=
 =?utf-8?B?M3JPRHp2alBpQzBLWVlZOGY4QkVZRTYwTDh3TGhHTG4xRlY0cXcvdjRsc0ZO?=
 =?utf-8?B?V256TUUyeWQ2ODdDZlVpVWkyQlJlOFdOckNZU2xOM3Y2U0dLRFJ1dVB2SUN6?=
 =?utf-8?B?UkdncmNocytWWVJGMldEaVNYNThZLzZFNk1jY0VjTy90MDBJZHY0eTNHNVYw?=
 =?utf-8?B?QmVMQmdNaVRzVXdOaVdmdFpYR3FYNis3MGt0Sm9MaVk2OHBHb29YY2pSYllX?=
 =?utf-8?B?ekNIK1pQWjB0cEJJRWhuUFBpclZ1MjRxaTEwYjhHV3JlOGVHTEswZlJPWUdz?=
 =?utf-8?B?bVB2OGppdzVEanFLVGUvektCR3FyY1U5dFV0bjI0aXF2TzRHdGZpSkV6dzhh?=
 =?utf-8?B?TTh2aGorTTI2OVM1Q2N4RnRIS0NCQjhmRmQyaDVMSm0zZHFyT2gvUGJ5QjVO?=
 =?utf-8?B?S0tHUGNHSXpkVFBYaDRhbzIxRGdrNmlrTGhFb1U5eDc2R0l5M1MvMzEyMmZH?=
 =?utf-8?B?WmxEQ0ptS21pUGhPMjlWVWFRMDkyQ00valNtRENQNS9wZ0xPUmJTbVFYOEl4?=
 =?utf-8?B?UVZ0QUtCRWdyYzhQdmppWUFWOXd2QzF0UGU1ZWsyTUxFRHIwUE13Q0ZLZ1JM?=
 =?utf-8?B?NXE3M3ByQnE2RmsxWmZwak40ZG1jMXpHVWdJN29BOVRMUklmc2RnZngvNVFm?=
 =?utf-8?B?Y3VacHBtZ0tHZGozRlF2S3ZGcVF1UHBKWU5XWGg1MUpzSFNtWWY1RnhZOXFN?=
 =?utf-8?B?djhzM01IZklXZjM4ZmhTWkZNcTZFZDFFTU1xcU5TSE9OT2hDVDYxZFNBeTJV?=
 =?utf-8?B?bjRoZ0Q5SlNZcGtFR29TZEl4YUxieGNSSWMxNlQ1WWJqMXVjeDBMK3V4UXdX?=
 =?utf-8?B?TkRkeVRyZXNVT0VCbFFEVTVBWlFocHlLVHpZWmR3c0FxcHNZV25POGtYMzJC?=
 =?utf-8?B?bzFTMjJZMXpISnJwNmN2ME92dm85QzFaMjEycHN1N3Q0TnZ3NFIrZ2gvTVI2?=
 =?utf-8?B?ZDYvdTFoNG8wdzFmTWtLQm1NazE2QzNmcWtkMC9VVnIwYXI3Nm9RWXYwUk41?=
 =?utf-8?B?dUd2WWJsVGlFOWVXQ1o4MExETGdUQ3lxZnFabURFT2dFRGdFU0RFcWt1dTlH?=
 =?utf-8?B?OUV5NThPUnY1bzJOMVFDMmIreXBPQkhVVGppeTdaNXp2YktuQXRQbzBJNTVp?=
 =?utf-8?B?dUh3YnRwbjNyUUxkS3p1dVJvU1J2c3FOUytqWDJEVnJweDBlUlVmbEJHNnNW?=
 =?utf-8?B?SnR1d1VZZEFYdlpvNjBqSE0zL3ZZWml1VjRGV2s3NFJvR0JEMWFKWlA3b2hw?=
 =?utf-8?B?VVBIRlRiKzg2UGJQNWZGb0VVWFpiTUFqc25NN3kvUnI2NTB1UW5CSUpzWW0r?=
 =?utf-8?Q?mF9t7gyEr4XVamrAvnPxTTU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1813cc92-1335-426d-823a-08dd46babdcd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:30:02.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QxubYC70zeqW2FEKdhgPSkAvTLAwqcWIsPbFiHQ550vt4f/6x7Bcz2XwF4Ph+uF0NnjSBSrWemqbQJACTRH+vvwj/7MO3PmBtnC1SfdzMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10840
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

On 2/5/25 8:54 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-05 17:51, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>>> The v2 image format supports defining a load address and flag for each
>>> embedded image.
>>>
>>> Add initial support for writing the image load address and flag to the
>>> v2 image format header.
>>>
>>> This may later be used for RK3576 to embed a minimal initial image that
>>> if required to fix booting from SD-card due to a BootROM issue.
>>>
>>
>> Would have been better with RK3576 support so we can see how it will be
>> used. Especially, the flag member is very obscure. If we do nothing with
>> it and document it as "no use", should we really add code for it?
> 
> I fully agree that this patch should possible be dropped from this
> series and instead be included in a future rk3576 sd-card workaround
> series.
> 
> I can only find FLAG=0x10007 for RV1106 in rkbin/RKBOOT, i.e. "no use"
> in current state for mainline. However, a few SoCs seem to have use for
> a LOAD_ADDR= different from the BootROM default.
> 
> Below is what I am playing with. I am not happy with current state and
> would instead like to embed the binary code in some way, similar to [1].
> See my rk3576-2025.04-wip branch at [2] for the full commit.
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250103215904.2590769-3-jonas@kwiboo.se/
> [2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3576-2025.04-wip/
> 
> commit e431562260a6313f765dbea9ed4f696fa97c5abc
> Author: Jonas Karlman <jonas@kwiboo.se>
> Date:   Tue Jan 28 01:30:12 2025 +0000
> 
>      WIP: rockchip: mkimage: Add rk3576 align and sd-card workaround
>      
>      The BootROM on RK3576 has an issue loading boot images from an SD-card.
>      This issue can be worked around by injecting an initial boot image
>      before TPL that:
>      
>        writel(0x3ffff800, 0x3ff803b0)
>      

Extrapolating here, but I guess it works good enough to load this small 
boost.bin but not enough for the full TPL (which is the DRAM init blob 
from Rockchip) and thus adding boost.bin before Rockchip's DRAM init 
blob makes it the whole thing able to boot from SD?

Shouldn't that rather be fixed by Rockchip in their blob? Ideally we 
shouldn't need this trick if and once we get an open-source DRAM init.

>      Prepend an image containing binary code that does this and return to
>      BootROM to load next image, TPL.
>      
>      TODO: embed the binary code into rkcommon.c
>      
>      Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index 8b57ba69cde6..7125b1de9fe9 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -143,7 +143,7 @@ static struct spl_info spl_infos[] = {
>   	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>   	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
> -	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
> +	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2, 8 },
>   	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
>   };
>   
> @@ -271,6 +271,22 @@ int rkcommon_check_params(struct image_tool_params *params)
>   		return EXIT_FAILURE;
>   	}
>   
> +	if (!strcmp(params->imagename, "rk3576")) {
> +		size = rkcommon_get_aligned_filesize(params, "rk3576-boost.bin");
> +		if (size < 0)
> +			return EXIT_SUCCESS;
> +
> +		for (i = ARRAY_SIZE(spl_params.images) - 1; i > 0; i--) {
> +			spl_params.images[i] = spl_params.images[i - 1];
> +		}
> +
> +		spl_params.images[0].file = "rk3576-boost.bin";
> +		spl_params.images[0].size = size;
> +
> +		spl_params.images[0].address = 0x3ffc0000;
> +		spl_params.images[1].address = 0x3ff81000;
> +	}
> +

Can't we add a new node to the rk3576-u-boot.dtsi in 
/binman/simple-bin/mkimage which is before rockchip-tpl which generates 
this new binary?

Cheers,
Quentin
