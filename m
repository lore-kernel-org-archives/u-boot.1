Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB521C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F9C805D7;
	Mon, 12 May 2025 11:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RIarr1Aq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851F28091A; Mon, 12 May 2025 11:21:40 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B1380050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx4arxfCOHvgJC4x8/wk1ssUSTuqBxDMy5nkW8jHVuaI1x2QT7V2rsd+hDGE9AuPej5EmBNJPXJUszC6GTt+Juk3GvlAo8qlcwTbkEo9akD5JP9QfUJR4owLV2uOIwCEWmnEPEiqb0WmzMpDOXMIhi5ZOWidHJlbPS0LD2EoUy/g/xz61XBb+YGec2v6ha406eozUuhk3IuS0+EYwtN4g8JtQax2PTimfpPCMaZgElEMquddjmmq+BOSTDD0tSSUeCC1yiagmVWPYSz69dwWaDbDIQgGtnuPREOPHD3rK8dBSHNfvAlVozoo+ZzW2r7mJk67HasldW0F2WdyHbHA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UZ5Ap+hEY6E5AO4GD5/xKpnvv9rux6jh2VxT0lrFRs=;
 b=WGrrAMbZWb+rREcfXlA4ZEpJh8wFJ5p2yj0Gf97m9gmiOZKNXQtn3/rCecXvccTzryJbxc68ohWn+r0AWzaO/euRPy919oG1qWwcm2kdIYXBG2r9NWULLxA5DCs9DieiO2T2hMscLdttWzNULp1Yh/D9rFU2VuqX4XNdLiCX9TbINJ0QWBi5pFa463rIpMpWJokSF2HdV5YaPQGI8zioChug3p+L3ScM5lXtV41uuk1el8fjEHdUaT7abuPmxmJr8I2cuGUX2lDBJl5wVpevHw7aj7134bTaU50OEOZd0FxDzZWbZwZeXUHBrWQ6ATFxasYZQS2wD5L+2aybKy8vWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UZ5Ap+hEY6E5AO4GD5/xKpnvv9rux6jh2VxT0lrFRs=;
 b=RIarr1AqIBZgeJl1+nv32HwoQ6KTZc70N+fxRbNi8b+4u5aIl9HYVm+XaAoHrncuOOn2HTQ6ndlY96QMEZ+Za81l90FzwZBucVA9an14ELJDzFu/EMHOeVxpwQSLwrHV1nosb6agFAFVRSvOWPotr52UBHrBQzLW6uUKulpyoGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10716.eurprd04.prod.outlook.com (2603:10a6:800:270::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 09:21:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:21:34 +0000
Message-ID: <abf4d18b-93c0-4384-ae00-ce19f1a7dbbc@cherry.de>
Date: Mon, 12 May 2025 11:21:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] sunxi: A133: add DRAM init code
To: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-2-andre.przywara@arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250511011003.15654-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5b461b-d774-462b-af47-08dd913663b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXlRcTdOT3dRV2I1WFZTOTJxRE11ZnJFa28zd0ZoZjUrQjh1cjVFQ3FMWkNX?=
 =?utf-8?B?MW4zK1JSb3BXZDJFWjkrZ3cxV002S1N6eHk1RUxUZmNjazB0L3o1U1NDR09I?=
 =?utf-8?B?aFQyVy81YWc3Q21DdmVVbjI5eVJsTHNKTXEvRk02bFZ0bVhBcmR0VlJVYnFj?=
 =?utf-8?B?M0FraGkyUDJqN08vQ1RCb2ZZcm16anBaYWdMaEZEVFpxZExLbHN3Ryt6VDVR?=
 =?utf-8?B?Q3ROdmo4WmVsUjArdmpjaWpzQWpRc1pGSlArNkZyR2pxS0wxNnFlcHFWSnZ6?=
 =?utf-8?B?Z0l2L3dkcW5ZbWV2WVVaVUM2aE1tWWRQQ0JtaWZ6TkdrV09JZC8vZEhZdXVv?=
 =?utf-8?B?M0R1cWlvb3BlaTNNbTI1akQ4SDFNeDE0T05lcVlHeUJ2WVBFa2xTTzdNc3lB?=
 =?utf-8?B?eFc0TnphWGlhVEJwVSt6MmNiMG0vU2FjaEU0a2E5NDB4RzVVT25vMnp6TVVq?=
 =?utf-8?B?Rk0vZ0lHS0JIT0wvMGxDaVMyQnEyWHpqTExLTXZBUG9JL2hGWG1tZzlZT3dM?=
 =?utf-8?B?c21CeGJkWG1JWE1WMkNrNFN5YVZ3RUg1dWErYlZKbmZyeGlrTXJTQS9LNlhB?=
 =?utf-8?B?UWNYRFM4Qk9SWHJjNWNqSC9vem9zb3BrRkRFeVV6V2VzbjczQWZTYXhjaWhM?=
 =?utf-8?B?cmVKMFpPWW5RSldQNjd1NTJoZFZBN094VEFHZVByeUJDcmVldnRpVWNsemJJ?=
 =?utf-8?B?UGM0dE0vRE1WdG5FcjdQYjIxMjBBdlVZN3RFR21YaXkwTjQrekx3VXZCdkht?=
 =?utf-8?B?ZTdoV0EzRUY3TS9UYTB0WE1NMHpIQ0N3NzR0M0gxUG84QVpzSlNPcUc5VFVw?=
 =?utf-8?B?elZyc2RMdEtVVDdldU8zQzIyRVBweTNwcHdKb0VoaWdpRVFaR09RM1lXZktL?=
 =?utf-8?B?QUFrckszZ3BzMGM5TWt3ZWFmcVlyS3pqcW4xWEYyL281c0xFWHJaaENQcjdI?=
 =?utf-8?B?czBvbHF5TUpseHNDcGhRU0lDZ1NHVGFnWk41VU1jQnFzTkpxblgxSUhmd0pM?=
 =?utf-8?B?OStZQnVjOHF0RTJPM2ZKKzkrWWx0TS93ajM0L2g5cSt0aE9TU0FjYWlRcmVE?=
 =?utf-8?B?a1V6bjdHeWdZZE9TTlZDUkFvL3hYdk9qSjJyd0s1OU44QXZjUy9Pd05GeHVm?=
 =?utf-8?B?Q3pKQmJKU3IzSlhYY0xxeDhYMzk5bDAvQzNKbFJEVjZyVFRIbU1BSXBCcjhU?=
 =?utf-8?B?OUI3YVd4bnV1M1dEQ1NXUGk3WFlWL0JsZVZ3VzFDNzF0K1FNK0ZmZlF6em5F?=
 =?utf-8?B?bjdIaFZrdXp2Yyt3OXBlME5mSkcxSVgrYit1ZVc5cUFIa1RBSVcvSXpaKzRO?=
 =?utf-8?B?elRMWkNMS1liTGEyZlJzNnRXQ2V3bXI4YkMxSllkVEtIZEJVekdidGNVNjJX?=
 =?utf-8?B?NWcvN0ZUVXI5U092dUlwMDF6VGUrR0hNLzJ6dXFMMVNRdGpKNm9xY09uNWZx?=
 =?utf-8?B?UnZ6OGpEckcyaDdXVWVBVE1sN2NETjdRak9EQ2FqZHQ0a1M1Nm05UzFVc2NL?=
 =?utf-8?B?UjVraDRBem5QR3ZwdFl0S1pSYmFTQ3oyNlA0UHNPeVNtci9TOHFkc2QrdEdm?=
 =?utf-8?B?a0JGQkJLY04yMHhVU0g5Y2RRbzhUeDZRdnptZ0t1Wk5XZ09iNDF0TFRRS051?=
 =?utf-8?B?djR1Mm9OYmtBSExxL1NiME9PSjFhbXdSbTU4TkhZUmRCWVk1UzFoa2hYU05R?=
 =?utf-8?B?MjVCdS9lNnRhV0hwWTNRdUlxd0pHUmFLWmwreXVWVTdEaWVUc3J2Y2VBY3A0?=
 =?utf-8?B?RHJWRmt4YWVHaVBrRUxsUC9uTDd6cFcxSlpMMExnSkdoZTl6emdja3VrVjk5?=
 =?utf-8?B?NTA0NW9LcWY2YzVVcWt6eVM0TVlmWkVaYVppYWxRbTBuL0NLcjFBYTJRTkRR?=
 =?utf-8?B?ZC9Ga3d6cG1vYnI1eW1CSWM5akFuVDFvaU44cGR2WXBkWEdubDVVTE1lYVg5?=
 =?utf-8?Q?c6A49vosYVc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9zOHljQ1FpdU9LMWk1VDRqc3gzeUJpYzA0eVNlQ2RZU0UzRmRuMXVaSXFq?=
 =?utf-8?B?MVMzaDdYQlU3QUhuU1htd2hpblR3Y0ZKUkhYeklJUEkvVi9CZHpsbkRNVExU?=
 =?utf-8?B?MjBKLzlnTHlSeVk1bU5NU3cxUHljeXB0WmdnVlYza05acmtoY2ZOcFJVY2NR?=
 =?utf-8?B?RE0wZ05qbGhYNWtNR1hJUUxOMUdUWWM4NVRsRHNUTVNyUHFtb2s1YmYvMEV6?=
 =?utf-8?B?UEFzdnFrVnZvcTdXQ2ZSNll6NFJTRnlmUTg0TXJuYXJWWlFrelUrN0RoYkFC?=
 =?utf-8?B?Q3VubFhRYzNwT2tNY0dPYWYvdE82VzFaUWRkUUZKU3J6c2NvcXh6NFA1LzdF?=
 =?utf-8?B?cng3Z0ZRY3MybmpRdGJxamlPcGpZR1RLUktIUTJleXBIbTgvVm5oLyswMHNa?=
 =?utf-8?B?TXZ4RVVRQ21xNFpHc2J0QUVWd05pL2ViZDdxSGJGdG5TbHBUbW5XL2ZTczZ2?=
 =?utf-8?B?bjNBRDlma2gxeW95bllQMlE5TFhqRi9RZWN4ZC9LWnJDU3ZLUlp2SGJRdjNC?=
 =?utf-8?B?TGo2V2R1bHgxV1lQdXdWTy8wSkQ2QWFPSkpoNlZ0TGRVN3NKNERlYlUyUEIv?=
 =?utf-8?B?MUp3VXM4U0JIWEYrVmViNFplTW96dUdicFFXbXBLUTJieXpuVEpIWTZSeHo5?=
 =?utf-8?B?YnpuYnN3eWI3WDJqeXpSTjlmelpBTDRKeUk1bmRZWWZDWlRxK0IwMWJDZTB0?=
 =?utf-8?B?TmZ1b0h2RlIySkhEOXc2ZDlhc0ovY2RIemd5UDYyNXg3cVVPOFoyVEpQdVJG?=
 =?utf-8?B?UkY1NEdILzlra1ZCcW1SSjR4d1FrNjM0S0dhYzhyaStBdEpHcFdOV2hUdjNa?=
 =?utf-8?B?Y3JlWWhNdzhIbWsrMjdwOW5TRU5ZdWlyaHhSV3pReGFnYUVENGtnR29ablo2?=
 =?utf-8?B?bXRvdHN0NEZLUElkeFRjMVFrbi9jd0l6L2htWk12ekpvaFRibTRIaVgwYkJL?=
 =?utf-8?B?d09NcnYrOXptVHdqWWpKRHlMV2pva2VIUXMyRTVPb2cvbUh3VE9ucFRIRkh5?=
 =?utf-8?B?MVJ1cUZTR084ejdRUlJKYjYwV1l3V1R0WFgrdmpvNmROa3BOVkZsYWVmUmhn?=
 =?utf-8?B?cDJkc0lIdkVXVmpIU1IvK2VSdVFCU0kwMm8ra3p0bGZreEVBNEVhUFBidGRN?=
 =?utf-8?B?RFl3N1drdjloR3Urb3J3VUJqUS8rdzNjcm1qdzZQdlp0emFrRGJ2OHI5Tldr?=
 =?utf-8?B?ZjRiM1ovL0ZhQzZpSGo5cHV6WnNuNTc4SWgrV1hvZkNoa3picWJ4blI0YVU1?=
 =?utf-8?B?dTdJVWIvWHg1WDZmWklrckdFMXZnR2I2cUNweGJla1k2M2Z2R2tRaWd1aGZt?=
 =?utf-8?B?NCtzNE85Ym1NcDdNakd3WlZnQ2U0d0Z5M1JUSTRyVEJBSENCM2tuSWF0VGFS?=
 =?utf-8?B?dGYzRytubW5BVkk0aXo1WHMzRjBEVENCNnBmbk5NL0tMbWZOaG1uS0hqNTVB?=
 =?utf-8?B?aDB0RWRWa0xGUHpmSXZ3ZXYyZ3R3NzVCZFpzWUR1NzhUKzRiQ2MrVmIyOVhz?=
 =?utf-8?B?bER1eEFNZ2tIUlFvVWdqWjFVSDcrZkZqakswSEF4U1BOZVBqNU5USUUvUnNB?=
 =?utf-8?B?dUJ0RlZJTktuM0RsODhlMURqcEEybGNsMlovQTMxMG01ZEtzM3hQM2xSaW9D?=
 =?utf-8?B?azkva0VEMytiMjlQK0FWVTlYWVFqMWIweC9HY050MU0vbXF4Tnh4SWsxSVJl?=
 =?utf-8?B?ajl2ekQwa2h6NnczMkwySUtlUFExdGxveGRmMEhpY3JITFBtTG9pcEFWeUg3?=
 =?utf-8?B?MDUwYk1PWFB4dzlzd3lyeURWY2VuTVQ2K2txKzdmL004RnB0YVUrRVI0NFcz?=
 =?utf-8?B?aFJlUDEzcUdNK0RmWnBTUUlxVVo1VDJVYTVFU2NFVU5ZSkw2Z3J2Mk9jL01H?=
 =?utf-8?B?RkFnR2RHa1pWZktZN1dXeXN2UkRFWFZGRytTUzV1UUZhZ240Qkd5ekZ5NFdS?=
 =?utf-8?B?NzBCamdmZkord0ZkVlQ1TDI5N3BoVWV5b0RBSEZBVnZYQUpYR09wSk5EY1Vt?=
 =?utf-8?B?OE5HOS9BQ1cwbTVtUmJIWDFpQVIzRVRkSzk3UGVxTEQyNGkrU2ZpYVlxa1FN?=
 =?utf-8?B?d2hpVnZYQUlKYllaZzMxTVgzU20zS09yVHlodXVOSHczbTRiTkpSWlRuZzB0?=
 =?utf-8?B?c1k2OEFEdDA1TFBaY1FVSHdxK0ZyeEFoK25jcks1ODhReXBXMFNSVW9peXZ3?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5b461b-d774-462b-af47-08dd913663b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:21:34.4921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fKVOhfys8eFxH87WsjDr0PeQZ049cSjCQdSuUuKjMiUw2hsc39x7jXdugDaJDsyFdA273q6TVkP8z+7emQhABHy/c1YYTDywwarqAq8pKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716
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

Hi Andre,

On 5/11/25 3:09 AM, Andre Przywara wrote:
> From: Cody Eksal <masterr3c0rd@epochal.quest>
> 
> This adds preliminary support for the DRAM controller in the Allwinner
> A100/A133 SoCs.
> This is work in progress, and has rough edges, but works on at least
> three different boards. It contains support for DDR4 and LPDDR4.
> 
> [Andre: formatting fixes, adapt to mainline, drop unused parameters,
> 	remove struct struct sunxi_mctl_com_reg, hardcode MR registers,
> 	switch to mctl_check_pattern(), remove simple DRAM check]

Missing Cody's and your Signed-off-by.

Cheers,
Quentin
