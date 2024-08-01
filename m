Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525DDC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD308827D;
	Thu,  1 Aug 2024 12:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KWqcGF4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F226E8827D; Thu,  1 Aug 2024 12:33:32 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EDF88210
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 12:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT/dEzgtjWcscof1ZzKqQoN2yo8bNKo/jKLV2Q/32gzF/WRp4rBxeLkB7XCZohf3V/XHY+AmKXKm22ZIN+B9R4q1S6Zei82WHJAvw41Ugx/FTTOkugy5yzXm27YWLKTcNkGH8K+U0nxsG02gFAbqwnR4vDH5h1dhFyEMoJe/TEBukqenDgObW87ijbu3ww5SAHjPYc01Ij2MwbkmmIxw0XNqLp6knGEyPrlEnoMUJuiz3Od8Sjo1rU13HP2XGdcaNuWukMVahXRXJ/ntnqMI+HOX3fZiyr/4+8diZVgquzyf/UwGzkgT46B3obcysTqGR//UmU+Mo+H/kWxtLlBslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmgWYAjrD1OZU/IPGGWQ+aMwaUvngKJhBFhrvHVIiGk=;
 b=Qmf1kaqeMfj2z5C/ko2ZhyQkV7moYkc64/rF1t1ga1NHJTF5Xjh5pLOmWEtByRvpX8ZqqhL6P1Yw/d2YTIgwlwsA9yTfN0PY9tGpev9iWDUCIDzyea07+EVxTOlJyHfM+AnxlEVpRoGtPWTe48G+Oyh/q4QjIWM+uE/1yKuPcQXpUHDxYWWFOsB+D6dOE+V1YNChvCuqPSIhJMP+WlIubUN0DjunixXTCWjacq5zQvGnrsSSoG4qIarFYN8wCJItLg2dAD6WMXF0hhLstIAEJSEhueLRyk2/TFtdY22yEdAgFg8nRiXHBgOHzpxuFTwkJL9cbV3Vtw/GfUr9ErHU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmgWYAjrD1OZU/IPGGWQ+aMwaUvngKJhBFhrvHVIiGk=;
 b=KWqcGF4eT2wE1Qy5paMKhsATC+Pfdr6dLxAsfzhUpqBzEUkJzOumdoy20n32Yc59gnY0VC59cwT5wy0DhXIjdInpqXY65EGk0m3KiOwTR/u77RknnUeFj8nvJ+STQJHcC6WzdS/NvC0L5in/sLkaJXO11pQ/dkkTN57Antl+jZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VE1PR04MB7437.eurprd04.prod.outlook.com (2603:10a6:800:1b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 10:33:27 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 10:33:27 +0000
Message-ID: <10b8ae68-36a1-47c1-bdea-2612659101b4@cherry.de>
Date: Thu, 1 Aug 2024 12:33:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: document the pwm command
To: Emil Kronborg <emil.kronborg@protonmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20240801100754.44732-1-emil.kronborg@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240801100754.44732-1-emil.kronborg@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::7) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VE1PR04MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8078c6e3-9390-40fb-61a8-08dcb2156112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NllhTjJ2L0U0TWlrU1d3VUN0NVhxWHl4MFpnVzVnVEtjNlg3ZUt0NFcwVWRK?=
 =?utf-8?B?cmcyMlpWUkx6TFNyRHlYTlBDMCtCSnFDbTcrUWdUVyt5WndxcW1ib0t3SlhX?=
 =?utf-8?B?YTUwQ0V6UnkrNW1ndUsyRTlabzJldWxERkUwWE9PR3RSN3Q1cGNkeHlJdUdL?=
 =?utf-8?B?VVFwVjVpUXhKRW1weDV0UnVVYVRJWExLQzV6NGRma1pNQ2lHdVRodXJYbUlZ?=
 =?utf-8?B?OG9mTUo2Y2JySTl6ZkhxTS9ZWTU4RWJ6Wi9LL1dJWThTV2h2VTBiUHB1ZnBE?=
 =?utf-8?B?d000TW9Bc2UrcXRFdnZNMW5rcGtubm9GRWxueXZZNTBtMTY2UHJXcUxTdXQ3?=
 =?utf-8?B?R3g0V0JienhZeE90RGVxZ3dFZllnOEhBYUZKRmU0a0hHRk43Z3U5dkxUaTNm?=
 =?utf-8?B?OE5hanRqK2VPWWlmaytuZUVTTHcwRTR5VnhNR2FrWlRVRWU1Vzd5Wm1VYVFq?=
 =?utf-8?B?ZGpVNkp5SlNjdmNTL2xuMHFuWkFiQ01ZMUxPY25XZzhOejVkYU5kckdBZzRJ?=
 =?utf-8?B?OXdMUjhrUlhyMktsb0ZpdENHRkZ2bFNLbEZpQk9HeDhCem5yUk95a0RKRW9I?=
 =?utf-8?B?K0hxcUl1VXhkQzlpaFFCU09DaGNTYXQ3SWszQkZ5VnZKMlp0ZUpONUpRZlBU?=
 =?utf-8?B?ejdnWG5oY0xBaUQ0TjJHMXEvUld6TVcwcHczemhjZE5iUjFadzk2aEhLbmhw?=
 =?utf-8?B?T0R0b3VZMUFScmN0d0l5SnRzVk9lV0t0MDlKL3VhRi8wdXBpRmJ4bjVpL0xK?=
 =?utf-8?B?QXdxQ20rUU8rSmJXMnBUVHhGL0l2eUtyNjhKTnhFaUNQY3pVQmROdTZLVGNX?=
 =?utf-8?B?RG9lUVFNT1FlKzkvd2IrL25ndFE4VUR4elhQTGtwdTNac3B1bFJ2Nk1LWUxZ?=
 =?utf-8?B?WmhRVThWMy9RbjBXWCtsMlNZTTJpY0JJdEp4M2xQZ0JBVDAvZEU3N2xDQ3hl?=
 =?utf-8?B?NXpuWUcvUWM0ZFlTUGYvbDllaDNwUXhHZDFtRnJSc3M4eXdPQWllbmVTVGlC?=
 =?utf-8?B?MkV4Z3dzNlBwL2R3VkhRTXRUZ2ZoZGZSVFNRQnRGRi9oOHVUWjloeTRmNHpP?=
 =?utf-8?B?T09lbTZiekxkRzZ1eUNuaGMvL09CWkx1Ry9NcHBKclh4WmRFUVArVXAzelJs?=
 =?utf-8?B?a2F6d3VjL3d2cGJFazlvTVByVS8yemFGaFNWdTlSVWtodmIzaHd3Yks3OXgz?=
 =?utf-8?B?NitaMEFIVFhPYmM3WTFWYkdMWlZCWFRWNUt2cWxSRld0NWRRQmhPV1pYUEhl?=
 =?utf-8?B?cHNqVjJpREVjcTdWck81NWJ4L0NKRTVkaS81b3FSUWFGR0t3THJQR2dxVkhN?=
 =?utf-8?B?N0JjZ1RtUGdzRzdGckVxSWZXb0MybHJaZk9TNzVQYk9vTXZXaVVYSjN1c3Fi?=
 =?utf-8?B?TEdkMUx1L0JYbEVwb2ZhbTVlTzNCeHZoMEJSamtnK21tcE9mbTc1S1BLNHg3?=
 =?utf-8?B?ZTM3Y0dxWGpibWFvL3ZIU0Jxbmp0YVZJY0EyZ0d6Zy9rZUdIWlY2dnVpZ01r?=
 =?utf-8?B?V0hMUk5ucUQzb3ZHV0xpNHVFYjA1QXZUeEJGODF2UkRNeE5kSXNsL0p6dkQ0?=
 =?utf-8?B?MkwyeGhvNVJxb3RLTVRZSndpejZIdVY0V3d0NFhhQ2NyYkVvcytaRW5UZ1Ez?=
 =?utf-8?B?RVBKbDNxRlNHbGMxblA2bExRY3prRHhVcnkyeUlrdHJOaGhYRnoyKzNRdHgw?=
 =?utf-8?B?RkRybTdWSlpZdjVUR2JPTHBaSlNNZE8yb0F4UEs0RFVNSUkxTitPbjVDcVJI?=
 =?utf-8?Q?4rhliJNCBf2sb2ytO8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3Fhc3NUUXFyTk5PS1lHQnRkcTFOOHArTTNyOEplVjRhK1BvRndJOUVPNitC?=
 =?utf-8?B?Q1hLUmh4YmR0TXRDN1pWRnNubm1VazZ0S2x2SnVGSWNESXJaSjFwS3g2ejJL?=
 =?utf-8?B?eC9LMjhHR1dlVU9BL20zdW1pd0J0eW84TjJHdnVoZ2h4a293YlRYbHFTQ0xs?=
 =?utf-8?B?alAzSGYyQTUvL3VvQjJzak1lY2ZEZU9RT0lBemVPZVMxOUl4RCs5T0pzL3dr?=
 =?utf-8?B?N0xGWk9LOHR6K2JKTngzWjJxRDFBbGFRc3YrWmt4Rno0b1p2cGNZeTI1d2o2?=
 =?utf-8?B?eDRoSitWeDJ5K1E5WFlsWFJ5YURFSi9nd29wQXdISFpXcXNwZElmcjFUTk9p?=
 =?utf-8?B?NEUrWE0xVDRwSytYWnZrTEprbHhxbTNwbjduNS94SVMzZnY5VHFiV2NybEY1?=
 =?utf-8?B?SXlCU0JKYXdxTlBzd3Z6ckNBLzE0S2daVXFSVy81RkFsRXFzN3g0cTA2dEln?=
 =?utf-8?B?V1Z4dFJXOFhkTWdNaDFkb0RQRE1RY0xSeGRyNmxxRDRwQzRVWlErOE5IRGxI?=
 =?utf-8?B?ZFJHTVJLYTlyR1RxaEpLMXoxaEN0VWxONm1RdkJwS3JraVJwZyt6ZWIrYnJB?=
 =?utf-8?B?UnIvS2FrR1BjMW1aN1ZFc05YclhDRmJUc3ZCaldHNUIwS1VQQlpRWVB3TjhJ?=
 =?utf-8?B?NVAyK0l1UUhVOUZuNmx6RWFqTW83TXByZS9qNXJFeng3U0prTlRrT2pUbTMy?=
 =?utf-8?B?QXErcUpxMU5WTzd1T2c2VVZDQVNHaEVKOUJOVlhEeUZ1NlJsNjBZQktkUmdp?=
 =?utf-8?B?N0ZXSnRMUWRSVVI4Slhia3k1WnBWL0wyUVRMNkZ5S2EzU3M1bkNaeVUxd2Jz?=
 =?utf-8?B?eHNERW1zaTg0SUI3eEZvT1BxMTZabjM1cmpBZVNDcTg3bjFxcGc5NHpKY25x?=
 =?utf-8?B?Y05ISklLTXlYMW16SS9ZQlN4d1FScXdPelZ4SEE2WXNoOFhXY3Q5TDdYLzFi?=
 =?utf-8?B?YXduem53d3NBM2hCYWJkUzRqS2pyRVNKWTRldGUzNXRZYkEwa2M5ODBMcm1Z?=
 =?utf-8?B?UXF4S1BWN2M3cHVNSnlaMmZEZlVrcGhEUHNmRXRpZGEraXZUQllXUnJtT0la?=
 =?utf-8?B?ZkpuMnplMmdMcjVPdVZmeGF0bW4rb3JoMitOS3l6TS8zdWFrazJ4UUZoa0FY?=
 =?utf-8?B?UnV1QzFabmsraVRocTdvNit0MUplTkE0U0tMbk1HekVVWkZiU2ppaGpiV1c1?=
 =?utf-8?B?ZjhJWlNndVRLS3dYeEtDMDcxQ2dFRUpiaFZQb3VKVmJzMS9UU2R6a1UydGpR?=
 =?utf-8?B?eld2VkdFMlFSWUR1cG1ueE1oTFVwb2ZZQThrVDVDNGw3a05iUkxVM3Q5UlBr?=
 =?utf-8?B?MWhWaXUxYVlvVzBVSXNMSXZnMnNxWkl4RG5BdlZkdkkvN3BrTnJHR05RKytx?=
 =?utf-8?B?Uk94TGNDUytydkhIdGFKRjl6UzlWaXdLSmpIZlVIU1BwR3ZGWGFwcnd3c1Rr?=
 =?utf-8?B?K3g1ZjM1M0VsZVpWQThkU2VubVhrREdYcHNKb0xvZEFzdTZKajM4SUhIdllQ?=
 =?utf-8?B?d0QwZ1JhdEgwRWlCV2tmQlpXNHo1ejk3eVdWWVRQK0s4WXdScGkvb2oybnpY?=
 =?utf-8?B?RjI4aUVrcmJKRlYyR05ZbmdPdmZNTUZYbGMyTmN4S3EyQnZMbkowNUt2TjZ6?=
 =?utf-8?B?cVlaZ3JVbDRmUVdNRm9VY2o5WHdhelRNY3BwYkpYQUt0ZHdyMm1kSVVvbEVr?=
 =?utf-8?B?eGZ1MVkzYUNCR2tRQU5keHI2cExEL1I5VFpGRTBLQ01EaEMvUzJXYTNQSWNu?=
 =?utf-8?B?ZnMxN0ViTUo2TUZUN1JHYkNvRHFVd3dOUEFPOFl2cHYwZU90VEJlNG1GK1Nv?=
 =?utf-8?B?ZmM2Z2orTllTbVl1TDJJcThUWjNPSDBCeTNUZXZYZGppMXJsd2lmemZ0ZEo5?=
 =?utf-8?B?TlUxSWRoOFZ3RjdncWFrb3dYalJ6TklTcWV5V0l5TmljSkkyZlo5VUNiOTFS?=
 =?utf-8?B?VEtvaWFCazdQamlBTENrbnE5cmxweVB6eGZLNWtrR1Zpa1doQmJOS1krQWpN?=
 =?utf-8?B?bjFXYUlGcmxyN3UvbnpLS29JTEZlQVdCWSticXRoU0U3Q1pPQWQzV3lKVGh6?=
 =?utf-8?B?SXJja3RhN2g4WENFYThNaUZvZERwVzdNOUhydU53dTJwblkzWUh6SjBORWd6?=
 =?utf-8?B?Y2dialVPNFFJbXhGL2x5NCtPMll2SjdPN2w4TWppckNYVmlVeW1ub0lkMXA4?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8078c6e3-9390-40fb-61a8-08dcb2156112
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:33:27.3147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY4P92bHMXEqlXw26QdNVls3u4kJ4kViAyvSBn3oD5F6WvQADQfzck9MO+Yb/9OoUn+5hAMHOjs/k6HPVMb81fhA62ZAfrYuad61V04srgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7437
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

Hi Emil,

On 8/1/24 12:07 PM, Emil Kronborg wrote:
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
> Changes in v3:
> - The help text for 'pwm config' in the examples section is more
>    explicit about 20 us and 14 us for the period and duty cycle,
>    respectively.
> - Fixed 'pwm enable' and 'pwm disable' in the examples section to only
>    expect 2 arguments.
> - Rebased on top of master.
> 
>   doc/usage/cmd/pwm.rst | 80 +++++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst   |  1 +
>   2 files changed, 81 insertions(+)
>   create mode 100644 doc/usage/cmd/pwm.rst
> 
> diff --git a/doc/usage/cmd/pwm.rst b/doc/usage/cmd/pwm.rst
> new file mode 100644
> index 000000000000..bd1255d82186
> --- /dev/null
> +++ b/doc/usage/cmd/pwm.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0+:

This isn't a valid identifier (spurious ':') I believe.

Also, I would highly suggest to change it to GPL-2.0-or-later which is 
the current naming scheme for the same license, c.f. 
https://spdx.org/licenses/

Otherwise, looking good so with that changed:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
