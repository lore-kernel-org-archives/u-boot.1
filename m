Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FC5C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C05E8043C;
	Tue, 18 Feb 2025 10:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iFukEreg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E7E8043C; Tue, 18 Feb 2025 10:35:15 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFB680079
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3EEyGUTsrKXNRGeondjKxk23ojExOpaw/ZkalgZ/pdYlO15NmfHCAFDcVtt8da29KxISYdKaLTVULMdOPizZFcfs55BoR2qfFjj6XpWelhxtSE5EBjw6kdJCkkFN3SaBzEh+9FYDnWp8xg5LLN1njcz3upMUIIw5V1LR5AidU97y9rpUJW8sjwFyHKBp7dV37gao97aJfxQuWS9NnPsr/bi3pqvZS7TqXNBspMx/DQgd9BTFJa1K17/t0fd+s+zisZtWVeB4swNjnNsD76I8XEvvmZ4JNNlmkWozcozzOhy1Zzzbkq3Dpbgu4HMBil8mayB0DH8ZQH1n1+WQ6D3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atJWl8V3WfDij+TwwzPJ9uVm1FT/G7kFHnCHOsnYWaQ=;
 b=yJN7asLhKZifzoxkHaL4+j7ET4atnCsj2ASmQaRvvc/Zr4FvBN+FJXTyL3EcLJy4KotxmDaOjI6sw43w5L2V7er4qdRRNjXWjcU8vjZ5/vCwl8XtL1YcHu0w+ZCre6N42zEDq88G+hjfLJHyNYi6SLGEHeH1+ukfKeZv8qTrJIcBYfF2uL0icxZAFbYKwIRh+VUdJrRqZsEXDZ7e3U0tppXbdvFxxx2v1iUms8x9k8vHoQai6PgKQdeoZIjQU9wKPFeI59Oza51G79XOQ/x3taG3taWQ/+QqkeeKrzEMwxy1MZe1w1L0QPcrOsTuAMUswDGGEcva29Zuj+CoSHSP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atJWl8V3WfDij+TwwzPJ9uVm1FT/G7kFHnCHOsnYWaQ=;
 b=iFukEregJ0qeQVrmBnUtziNkFeeTD53EMSS7e4WiYX0JP3qsYqKEQiMubB2dJSHQqjS2a+2GDxBDUz4D/3n/tnnFpYG76AcBRuKYqVe2XDB7duA4yXSoU7fW+Lv4Cj0sIKiWILcFs+OVRn6gfj4d5qCwHugVn36s9J2I8KAmnvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB9063.eurprd04.prod.outlook.com (2603:10a6:20b:446::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 09:35:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 09:35:09 +0000
Message-ID: <0ff42558-ef5b-43d6-868d-fbbeadcd198b@cherry.de>
Date: Tue, 18 Feb 2025 10:35:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] board: acer: picasso: add Acer Iconia Tab A500
 support
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 u-boot@lists.denx.de
References: <20250216181641.194424-1-clamor95@gmail.com>
 <20250216181641.194424-2-clamor95@gmail.com>
 <92bb6e6c-2bb4-46ac-ace8-466f48146c09@cherry.de>
 <CAPVz0n3yMh4O0_JfeL7EC_kcGFyOYV_2pMDs9fS3Xt29JYk24g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPVz0n3yMh4O0_JfeL7EC_kcGFyOYV_2pMDs9fS3Xt29JYk24g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d4160a-0c3b-48c3-97f1-08dd4fff8961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHZ0UktpSHBOaUpEN2h4OHBXQ21jT2ZXWHlLQTlNTmhDdzdCczFraVdxc2R3?=
 =?utf-8?B?M3QwaVdPc01YU3VSUkdKR0ttYXVCRytCaTR5ZnNOV2RaV01wcEltK3I1WXdr?=
 =?utf-8?B?MGRQOW1BdGx4a250Ti9nWit2RnM2QmpncjlnUkVoYnV6bFl4d2xWNDFabDE1?=
 =?utf-8?B?T2JBa1NFVnBZQzlNSlZuQkxBSmkrczdpdUNqK2w3TlMvbytIN0crNjBxREFL?=
 =?utf-8?B?TDBidWhVaEJvVk5IWUpnbWhIekYzSmJRRUJqbGtyMzRYWDBka2lDb2Y2NzJ0?=
 =?utf-8?B?VUV6cTlIYlBlOWhOUFRpTnJwd1ZKcTdFYnNNSDR6VEd3dHhWeHFUQWNoR1NO?=
 =?utf-8?B?Vjg0Rzlyc21kVkUwbHpPUExxa0NWa1BjVHZDeEc0SnFLb1REWDNPMTZsVWg2?=
 =?utf-8?B?QXNNY0orTzlNTFBCdjBCc0hIZlJwaTFNSU4wQlIyL3RyVExYKzRDVmJ6bmxE?=
 =?utf-8?B?NE1OR1NxOCtQejNVNDRwa0dKMmhlZU8xMHFDclJibytQZFhmeGR6b1ZwTTNY?=
 =?utf-8?B?NjUrdFdBNFFVVThuRGQ3aldta3BGWEJva2VJajk5eHRVWUVLU3B0NFJtOEtp?=
 =?utf-8?B?UDBWNlo2L3VlTG1SNkN0Q05HdXFINlZJbEJHczhNNXFVbnJXeDQzQ2ZuMGlB?=
 =?utf-8?B?NG0xb2Rkc3FQWXNucm12WWgvc0VWc3ROcTdnTXRGdFBEUnVJVTZtN0F3WWVF?=
 =?utf-8?B?WVIzQ1hvVS9BMzhPNytOS3oxR1FWOHZwbXVyZUtVdDQ5TERYSE5raW1uL1JY?=
 =?utf-8?B?NjU5QzRENWYrZWlGL1N2RFFSTzJvOTJEL0xKREVTOE5CemlQNnN0RlZEelZE?=
 =?utf-8?B?MS8vZGxhTm5ISlZJbnRkakMydlRoNWVHL2M2NlBXOEptYm95RkkrQU1jalgv?=
 =?utf-8?B?b21CaHMyeHRiWVNTVlB0c0JmcnJIMTYzcVVDN2FNSDNQZndES29UNUdSY2lz?=
 =?utf-8?B?OGowOE5yUWl0Z3RMTk1tZjhXK1ZxQ2tkUkhjS0VwamhiY1RUdFNNdXVRS0ta?=
 =?utf-8?B?Qk5hQStIYjRVVmV0bFhmbXdDbU1IcU1jUGtMU2JFdkJFQUVTSlZBRnMwN0dE?=
 =?utf-8?B?ZDBlRFprQ20yOGdCSEtFT0RoaGZ5TWRGSjNSNkYxbjAyVHZNa0kvSUNhb25Q?=
 =?utf-8?B?YlhGT3o4NmsrYkpNUVRrNjFuVUVEak1tQ3Npa0I1dUY0RnNobXo4S0QyM09U?=
 =?utf-8?B?RTRTMU9kU3lRU2tWaHZKZ2I3dWViUSt3WlVPbmY0UHhBWjhnRnFjcGhCTzRI?=
 =?utf-8?B?ZVFtTTBkekZhd01VMGZrRkRHQ1RaZDlMYjJqcTgxS0kxd3R4ZU9ydE5KS2hS?=
 =?utf-8?B?T1RvdTZ0cFNydDF0dk11dUI3dEhud3Q0UFFwOE5FdlU5Q0dPaXhDa0VjNzNP?=
 =?utf-8?B?YVpva2RZODRpZFkzanNCbWpmaWZaS0wwWXNleXorZkFiTi9mMlBBV3BObWZo?=
 =?utf-8?B?SmhLQzh6b2Y1MnV3VUJqaS9nNDlQbnFxZEpDYmRlQXJYNnFya2JDY3g2amJF?=
 =?utf-8?B?WnBYM0d5RndiVnd2SnFYbmRtejRyQVNESUhhb05CSzNTTlVuZTZPMStmSjJW?=
 =?utf-8?B?RFdDNUZFVmNlSTBTYngweGtGSm9KTGcza1BJSWFQdml3czYzWW16OHRGd2dz?=
 =?utf-8?B?a3FIT0luM2dCc0dWTTdQRFlheFFnNm9GWTZLVFo2dDYwZEZIZ1haTG1JZWRR?=
 =?utf-8?B?VVJBTU5WK0VPTHNDL2llMk5tM3ZyUUMybnZTaGZ2R1h1cG5yUEM5QUdOaFRy?=
 =?utf-8?B?T2JZaUc0bVFwM3dpUTVnVkU4SkNvY2lIdWMxTG9zWDJUU3VROHY3QldOcENW?=
 =?utf-8?B?dkVDZnFkblY5NG4yRnZJM25rdEh4RUJhc0E2anVBUTgwcCtlVkdXbUJQM0wy?=
 =?utf-8?Q?Xa87C1IenM6Ds?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVTMWg0TjY0dEhtZlR2MGNXcUsvV2NXcklMZGdCcG1PQk1mbEtDQnhoTjM3?=
 =?utf-8?B?Ni9XVXVkc2dnMnJNRURmNStsbkhiKy9WU2d5QXV0d2FZbkdQMlFWcEZ1YU9M?=
 =?utf-8?B?bGgzdTlLTTdDRnRmVlQvY3BpbzdzWVB6amNmOW0wNXE3YkdDWlFNVWhlc3No?=
 =?utf-8?B?bDN1anJtNHFlNFhFQnFBNDRoMlkxR0swZkpFbjNYOTE0c0FEdTdEWVRQMEZ6?=
 =?utf-8?B?ZnFEZEVnSFltSWluUEhWWk1vamJlTVhiODluOTNuNzJia0lJbWsyRTZ4MTJq?=
 =?utf-8?B?L3NjMVFYdy9vRCtxU0V3UXJxZVp6V0VvdzhXa1o3R3ppSllwVVIyRmJabGNs?=
 =?utf-8?B?aFQ5ekxudklzY21tMmJya0ptSVZRb2grN1pKcHdmVk00WUtLb3pJbzVqSUJI?=
 =?utf-8?B?cmN3OS9FbFNSUjlGOEo5ZzdZS3VRMkc3UWkvdEpiWU5XbVZadC9CbnJlZWl4?=
 =?utf-8?B?T0hOcWdTeVBoS21ScW5wczZ1RkVyVGNaeFBRbG1PM09NZVIycmN3bE5HZmpo?=
 =?utf-8?B?VStMbWlNMXBHTkxDRERONmIyNGhjaFJXTXR0WXBaSXROay9EaHArMGF1WEg1?=
 =?utf-8?B?MEpvay9WSjVBVmRUTHNCN3NpcXpFT1BIRDVBVC9kcGt4RlFkVElaYkVUYUpC?=
 =?utf-8?B?aGk2b0ZvejhxMTRoRVVWVVRoMHZoVEIzNUNEdDdiSkdnckUzY3M5OFc3THkw?=
 =?utf-8?B?TUoyd1VOcytvMTVBMktzLzhXZ2d6MVdBOEgwdFk5U0lQWWxwLzZUbm9lWFFm?=
 =?utf-8?B?YjREMHprTXkyZEZsZkRMd2JldHlUcXMrMWRCbHZzL1dhTG9XcFRKQUVkbUc0?=
 =?utf-8?B?Z0g2Y2tZbmkwOUVmQnFFYmhMUE9jalVNTExLYVhQdEQ3WU8wY2d5N2pxVm1N?=
 =?utf-8?B?Tit2YlRIK28rc21RSHd4cHJOUytzNzFRYUVpbEg3T0JBekoycDdXNzBFYlFn?=
 =?utf-8?B?ZG15aW1ZTjdKbVM5NnZhb0grZENvR21VU1ZnTVN1UWg3ajhOLzNmZTd1YW1X?=
 =?utf-8?B?VUJQamk1ek1mR29lODFqZEZYZ082ODFGRTl2MzArQWVManNwWGFtb1FGNStW?=
 =?utf-8?B?MzdCZEh3WUd0S0hwNWUwYWFvekVZSG1Wc0c4dXdQc0Zqa2M5Q2lRVFQ5UG5O?=
 =?utf-8?B?UXR2dFBGSHl0NncwYy9XeXdlazNDWUpmWHNnZ21BOHFHdnU0REVYY0hIblp5?=
 =?utf-8?B?c0FBdXBqNmdmd1c1aEpWRC9xWWZ4c09NVk9zdlBxVDJwbEd3Nk5UTXJrUU9p?=
 =?utf-8?B?R3ZzMGt2Ymg5bVYrVjkxTDJIYUE5c1l1MmErODAvdy9HZlVJOEdma0FGMmQ2?=
 =?utf-8?B?bitYZk1mdWdxZXhiYXF2SU5zaE1HS2s4NHh5MmpUbFBjZVdwajNkVXJQb005?=
 =?utf-8?B?OUFZWXJpMEMxMkRobTE0cllHZEZ2Wmp1d3RpQU1oMUU1bHV2NU1vTEw0dkxa?=
 =?utf-8?B?S1kxbUt6aXd1SUd1eGZ2K3R3aHNmTmd4NEZ4S0tzcWpSaW91YnZIRy9nZ0p5?=
 =?utf-8?B?ZW1Hc3J3bE9tVlpMSGxBVk1YVFowTXNhdjdPSGVqUFNpbEJtakNZWjdQejVD?=
 =?utf-8?B?Z0RnWlNiY1RLMU9nVmJ0WUJHcms0eElSbm5KSk1ZVnhIWkEyQjhLUTNYYVRJ?=
 =?utf-8?B?TUFNOGYxVlU4ZjQ3eW5wWVBkeVBEYWxZTnMxUjR0KzA0WHA1dDFzWTJodytt?=
 =?utf-8?B?bnhUaE14Z2xjUGd0VXpwWElacHc4elVocCtZRFgyZnJKV1lTTHpXQ1dIRFVo?=
 =?utf-8?B?bFh6ZlFWZnNScnMwcEhDamZvUVp6OGNuV3ZpMnlhVzdpdk0ySG9hRktuVnMy?=
 =?utf-8?B?ang0d0xKb3owaUFjaDBZRFBIM2RzVDM0VTJNcnMxSlpsajFYT3BwTkVxalV5?=
 =?utf-8?B?UFUzY2tMSzZrZHZTL2lIMUxPYy9lbEE4Um5FR1lQUWFBdWJCZ0Y1V0FQMjMx?=
 =?utf-8?B?RHZ1SUM5YVN2SjR1bExPaTVqSEY1NTZnSVVvWVltRWgwc2NlYnZlWDArVTF3?=
 =?utf-8?B?bjZJUjVWazBmV1NTTU1NUkpnSDVSVzNOcjFmYTJhU1JZUUdvODZOekZTOFJw?=
 =?utf-8?B?V3I3ZzhSRlN2ZjRVSUtTbGZScVFPbFpaK0lORzdsVkNLdGk5R2x4VkRCWVRS?=
 =?utf-8?B?dC9LWWQyblJ6OTBYaDFUOXJKcDZWd1N6YVlwQWg0TzZKbDdiai9vbGQxRnNW?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d4160a-0c3b-48c3-97f1-08dd4fff8961
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:35:09.8946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waaul+T+Gx1R1tJGDkfkh6IBzP+TmOsAvUSxvh+5V7ftCJyaNDl/zJrB2IrH1AFNi5pBw6wjPH2xsp5sqsNdjLaXIuRTktmslw+CBT0FUgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9063
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

On 2/18/25 8:12 AM, Svyatoslav Ryhel wrote:
> пн, 17 лют. 2025 р. о 18:51 Quentin Schulz <quentin.schulz@cherry.de> пише:
>>
>> Hi Svyatoslav,
>>
>> On 2/16/25 7:16 PM, Svyatoslav Ryhel wrote:
>>> The Acer Iconia A500 is a tablet computer designed, developed and
>>> marketed by Acer Inc. It is powered by 1 GHz Nvidia Tegra 2 processor
>>> and 1GB DDR2 RAM. The A500 is sold with 64 GB, although both 16 GB
>>> and 32 GB models are available.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    arch/arm/dts/Makefile                      |   1 +
>>>    arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 +++++++++++++++++++++
>>>    arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
>>>    board/acer/picasso/Kconfig                 |  12 +
>>>    board/acer/picasso/MAINTAINERS             |   7 +
>>>    board/acer/picasso/Makefile                |   9 +
>>>    board/acer/picasso/picasso.c               |  57 +++
>>>    board/acer/picasso/picasso.env             |  18 +
>>>    configs/picasso_defconfig                  |  83 ++++
>>>    doc/board/acer/index.rst                   |   9 +
>>>    doc/board/acer/picasso.rst                 | 125 +++++
>>>    doc/board/index.rst                        |   1 +
>>>    include/configs/picasso.h                  |  23 +
>>>    13 files changed, 858 insertions(+)
>>>    create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
>>>    create mode 100644 board/acer/picasso/Kconfig
>>>    create mode 100644 board/acer/picasso/MAINTAINERS
>>>    create mode 100644 board/acer/picasso/Makefile
>>>    create mode 100644 board/acer/picasso/picasso.c
>>>    create mode 100644 board/acer/picasso/picasso.env
>>>    create mode 100644 configs/picasso_defconfig
>>>    create mode 100644 doc/board/acer/index.rst
>>>    create mode 100644 doc/board/acer/picasso.rst
>>>    create mode 100644 include/configs/picasso.h
>>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index 0bf3697bdbe..acea0cc2ec1 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
>>>        meson-a1-ad401.dtb
>>>
>>>    dtb-$(CONFIG_ARCH_TEGRA) += \
>>> +     tegra20-acer-a500-picasso.dtb \
>>>        tegra20-asus-sl101.dtb \
>>>        tegra20-asus-tf101.dtb \
>>>        tegra20-asus-tf101g.dtb \
>>> diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dts/tegra20-acer-a500-picasso.dts
>>> new file mode 100644
>>> index 00000000000..0c301483180
>>> --- /dev/null
>>> +++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts
>>
>> Small drive-by comment.
>>
>> This is quite different from the Device Tree in the Linux kernel tree,
>> and it hasn't been changed a lot in the last few years.
>>
>> 1) Is there any reason for not sync'ing with upstream Linux kernel
>> instead of having our own Device Tree?
>> 2) Do you think it'd be possible to use OF_UPSTREAM instead which would
>> make it possible to use the device tree from the Linux kernel (it is
>> available in dts/upstream/src/arm/nvidia/tegra20-acer-a500-picasso.dts)?
>> I don't think it's a straightforward thing to do but haven't do it
>> myself, so no clue what's required and the amount of effort to put into
>> it. The benefit is that fixes to the DT will eventually make it to
>> U-Boot as well and we hopefully lower the maintenance burden on U-Boot
>> contributors/maintainers.
>>
>> Cheers,
>> Quentin
> 
> Short answers yes and yes.
> 
> Long answer:
> 1. Using Linux Kernel device tree will result in at least total
> failure of entire video subsystem since Linux gpu/drm changed
> extremely quick. All devices I have submitted, including A500 heavily
> relay on video output to be operated correctly (being a production
> devices there is no exposed uart or any other output, besides the
> panel). This is only at the first glance, there may be more under the
> surface. At the same time, even if we switch to Linux device trees,
> this will not remove need of *-u-boot.dts to adjust Linux tree to
> U-Boot reality.
> 

Yeah, most if not all our Rockchip-based boards have a -u-boot.dtsi to 
fix things up but mainly add binman nodes and add bootph properties 
(though those should be upstreamable to the kernel DTS, just that we're 
still struggling to get it right on the first try and kernel DTS updates 
really takes a long time for us to be merged in U-Boot.

> 2. It is possible and it is even one of my current priorities.
> Hopefully, by the fall I will be able to configure existing frameworks
> and drivers to comply existing Linux trees. A small example, atm
> U-Boot has no helpers to parse of_graph bindings, which are heavily
> used by Linux to link video devices (that is expected since there is
> not so much devices are using video output so no one bothered). This
> makes most Linux bindings of video devices useless for U-Boot. Don't
> assume that each or nearly each framework has such flows, they are
> uncommon, but nonetheless they occur and destroy full picture.

I think Qualcomm does have support for display in U-Boot as well, maybe 
there's something to be learned/adapted/shared with them as well.

In any case, good luck and have fun!

Cheers,
Quentin
