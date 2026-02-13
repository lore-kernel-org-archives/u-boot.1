Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAE7EEA84E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C7483015;
	Fri, 13 Feb 2026 17:42:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iyZ/0+ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 315EA83AA9; Fri, 13 Feb 2026 17:42:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF8982A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/WepQLc5x+46kqqSW5zU0e/0bQAz5KK7F285rrJbUYG1h8bYj+cZKJRd7jXpJMikL8pTImXRiAFkTdN2SQHPL66DLXVC3YvLe+Q7V01DU6wKJEg/1XAMUeJNnsA/JoFCJGkxQRJTzmJP5a431PMwDR96/aUzVFOnOQ7lTWBKgKuH9hhl3+TZ7z5kYQiOGXYlpcbAztSUUCPD1a72ZotumujfM/Eo0dMk1c4hOvUYpd8AnLhmTKX2+ysi788ub9sxFNfswBKD7gx0pJzdlAQQWc121otSmil9e1hhRWuVV8I7r3De/2XAyuKeDVAYxV3c5nAwFg74UCCx5Je54Izsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeoaDn5fP5rsqzkooHun8N8l9iCm5E+isX92cLeka3M=;
 b=ibdtxDu7f6b0L5qsExzgCCK0NowfF+llxKPg/Os/lV/OSEr12x7AymccVtYBv3qgVNKlvpyOKiIUFi/iIxPZUGLIUAA/q17bBaBT8YyfnpsF/b7Im/C3JEFd6JsE47pLUmbd+az004xFVPlrlqf3TaBZhirsflDpMccSLmFHUq4gaLNwIA7KPg4Ig62durvVR7/0sQtrYq/xcO2wJjqI8gCO3EC5Q2sFQO3IQF9WXFs+fLBxP+wB+TDusELX/qwtjopjpwWXBJ+Urek+bRcv5IOXpqrce1xqYVgFCtA2547frdEXU5sqi/g4oDVp/6FaXmAD2kQTE/Tz/Z2ybeekFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeoaDn5fP5rsqzkooHun8N8l9iCm5E+isX92cLeka3M=;
 b=iyZ/0+ysSbyY/TS7zxZbN3vDMEQCakDgvarXjKVp3qysm+yjSY5tYj2QHPA0xWjrnckmsTE1mgH6iiSqb3cgpxRTN2vj/Td99aGL3DENGtIAXgBIu1IjK64EmDE+pB3sUqSrcBFsinW6s8ytUd7y79UPP/G64+9Shn+bk4XVMd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by OSKPR04MB11318.eurprd04.prod.outlook.com (2603:10a6:e10:97::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:42:08 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:42:08 +0000
Message-ID: <c9edc005-4689-430f-aeab-02d84c17410f@cherry.de>
Date: Fri, 13 Feb 2026 17:42:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] arm64: dts: rockchip: move cpu_thermal node to
 the correct position
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-8-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-8-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|OSKPR04MB11318:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9fdf37-b2f0-4fa0-9d84-08de6b1ed3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1lnUmhIRGdtYVBrVWp5MEJLVHVheXhHTDh2bGx3ODNuNzl0Q0JwU1M0WHRp?=
 =?utf-8?B?c3Eva3l0UXRmWUl4OWxqMjkwelBmRlpSSkx0ZG84S29FWGxBZGpmcEcyZ1ZN?=
 =?utf-8?B?UmxnOStrMHJjOHFlUG00VTlselF4Y2x2SC82K2ZNMDN2bDZsRjFnOUdNMStJ?=
 =?utf-8?B?MVpkdkZXRWpTRWRoejVQYnZneFVtU0diVUxuZnFTYnBzV1RoMWZlTHpJdGFG?=
 =?utf-8?B?ZWZKKzVRT2Raa2M3a3ZmbW1CazEyc29MWUNpeUJoaHRUK05oMzRVMmZqYXdj?=
 =?utf-8?B?K2RFcFZuS1J0OWtOUTF0WlU1TnpYdXlTV1JoMXBsVThOZFJ5REw5cVlDTUhO?=
 =?utf-8?B?VDlwU0tHU2FFejFrdkE5SnRPLzNLVCs1eWFPT2hyNEhtYWUrdkpvZkxqMFYr?=
 =?utf-8?B?ZGV3YW9lcDNaZXZNZDNnYURqOGw1aU9XcnUvM2dLSGQ2ekpHQlJKV3JYM3Vx?=
 =?utf-8?B?L1dwV2JRcUwyTmRKOG1zU3JNcWpuM2ZZNmViVVY4bVJWWlp6R0xUVWtpbkRR?=
 =?utf-8?B?bmZudDdpZlZBSWFXbjVtN2F1V2xUaWExS1UxUFB2Q041dVl3OFY5d0l6QXpS?=
 =?utf-8?B?a2NHdk9VdVlGRmZTb2IrVk5nVVdNZGJjbnJKendSQTNzVnQrY1l2REt1NW9V?=
 =?utf-8?B?TFh5a2lKUXVJdmJIckNQQ1JuTC8zVVpZVTFHQnRrcytIY2s0K01PajkxUkEw?=
 =?utf-8?B?L2ZCb05YaElOZVhUZnA5UkxpL2ZxdVlEQVM0U0U1cGJRZGF6cXhiaDlTYjVP?=
 =?utf-8?B?OGZML0JNOVBLYzJ4MjNzNmVSTTJqLzR6N2FBMm5LM1JzTnZhZ1Y1V1JrK1kw?=
 =?utf-8?B?OUl5QjRPcWFUVzdxakc5ckEvUFlTaEwxYlM5RVp0TnJYaTd1NEVnbFZzTHE4?=
 =?utf-8?B?SFFBVGpWNkdQY05nUmducENuMEY0WjcwVHBDdFA5RGZkVlJKOGIvL3ZJV0Mv?=
 =?utf-8?B?VklaNDRzcHF1UHFXcVBsUkYxZ3NTWTFlNmRnUThuRXNCc284Skt3UGNVOGd4?=
 =?utf-8?B?eDVmSHplZTVyLyt5NkZkKytCV091MmRpWEx6R05JUFBMeG52Vy9MZGtqMjJ2?=
 =?utf-8?B?VjBaZnVqTmo3YTN4R2lyL05seldXcTZSOGRSNHVJTXhEZ3U5ekVYZG5mbXZ5?=
 =?utf-8?B?TmxibjJXQXMybU5OTFhYdmVwQVB6WEVDSlZXR0JocmNFcXhvRTErZlgzbDBi?=
 =?utf-8?B?QlVxaFRqT0RNc2w5V2RDWGU0azhLbkY4MWNZRkVURzNWQldpTEw0N3ZScnM4?=
 =?utf-8?B?Vm9QSWxPVHkxUzgyVlRBUGx5ejQ0RjZDb09pTFE2cVBIeVFSdld5ZDYyYS9D?=
 =?utf-8?B?ZUpyRnNGYWJLZHhmME5iRjM2TUJZaVA5OW9CQ1l6WkdQbGVWT3R4NjhpQkFv?=
 =?utf-8?B?WVFaZWFTaUoveXJKalBpNEpJVVVBbjZhbndheGxRbVJrRE0vdDRZWHRwalow?=
 =?utf-8?B?bVFPVklacnJJUmNkaU8zUHhCTk0wTkhTYkMxWGM5U3FpOUxPL2JaeklIY2R0?=
 =?utf-8?B?TEVMaGRwaFlDdzJiajVxY3l2UlVCZTFBTFBtKzZ3a21zbGJoMjRxZ0pXZEM3?=
 =?utf-8?B?aTdsdHRrZzhCMEQyekFBdWRjNkZuem9NT1AxN3dsY3FkMVB5OVJzdVVXN1NU?=
 =?utf-8?B?Y21jYzdOUmViVnZJaElYM1NiMmhwNmxnVVBINXcxcDRVdmU3eXVJQldLZGcy?=
 =?utf-8?B?aG0zMkt2N0JVb0NiNzRoeU43eGFNeUhTVVM1UFlwQm5TWXhpZ2VaSDFDYVNY?=
 =?utf-8?B?NlNHb1JVNGtXaEJhMDZvblB4Y2RZZVpjMW1tajJXVEdnL3MwWDZLOEVnemVS?=
 =?utf-8?B?Q3JWOXRYOVF4NjhRQ0RJVS9yMnp5R1ErRmcvaUczRzlyZXc0b1dDY0N5WjJB?=
 =?utf-8?B?VWU1bHEyNFFKVytuS2Zhb1VFcER0UlZha2pVVDZwZ1R1TzVjRzNWQjJ5Tm9s?=
 =?utf-8?B?Z1hBSjRxeXFFeW5WUWJHV3BCT0lTUkVqR2VEcWkwRDhLeUtnY09UWmdSSy91?=
 =?utf-8?B?OGt4RmF1cGROZzd5U3ZTRXlCaVpqWTF6aTA4S2k1cERjVDF1Y0YveEhJMStl?=
 =?utf-8?B?NFNORHlNbW1SZWN6aXZpVDlhTXNPUUtOdVBacGtrdGFveEpLVUl0bFllVWF3?=
 =?utf-8?Q?lPsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STFNR1E4U09qTGNtWm1QN3RJcXNWbTB1cE5uVjcwM1QzRXRHSzAwdGhqRnBR?=
 =?utf-8?B?b2NuckZCYWViNVZVTFVHelNNT3U0Rmk2TDUrV0FKcmFQZGZ6aU9ERHl6b1ov?=
 =?utf-8?B?RnlHN2kxa0U1UmVrUGF6c05yelVyeVQ1ZzM1NzZvUDdwSHdUUmh4N0dGUllq?=
 =?utf-8?B?TW15SXNMRWZPNjc2cGU3Qi83Q1ZJZDZHbWppRUN5TkxQVjNZcjgwM1RTZVdV?=
 =?utf-8?B?SU9meVo4VWZ3cEliWFNlNEUxMWprMU4wKy8ya3JkajdvWkFwVVRDT3hoUlBO?=
 =?utf-8?B?MC9NdUNza1JwMVNQRFR2ak53YTlRM2NyakVibkpxdkgxV1FSbUZEb2pqeWpM?=
 =?utf-8?B?T0M2ZVNkUlVsMkMrdTFwalFUSlNqbXJNNzc1U0pUQjJFNS9pZW05aC9jOStD?=
 =?utf-8?B?TVVsZnlMSUVoRjVZWnk4bjNBRWhpalIwU3BncExBaWNHZjB4QSs2RnA0Smxk?=
 =?utf-8?B?RzFqTWNIL0UrdnJUenExYlNVaVlBZ3hROHp5cUQ1aGdqc2N6Y1FkdWlLS2Yw?=
 =?utf-8?B?VkVVNVROcEs4Sk9IVmQ4YkI1SjA2N1ZuSlNqQ2lrTEx2U0N5K282b0RXUU9M?=
 =?utf-8?B?dFVVSnJjTThVcHpEZnlGQ1JtTjdWanZ2YjZaS1dzdWRqKzRHMGhnYWJBbWVC?=
 =?utf-8?B?Wk1INWIwK293TjA1d01DdlVsUVNhazROalFxMFp1V3BsVi9Lc2NmRlp1bTVr?=
 =?utf-8?B?YnRNSFFWS1Uwc0l6NmsycU9ZVjlZUkl1QnhXSFI3eXVFTTFTak1rbTYwL1gy?=
 =?utf-8?B?ZlZRc2dmeWhETk5zaFh6aFF1ZVl6YTBCcGVNaWE1RlpUNmhRejlJOHdDSS8r?=
 =?utf-8?B?SGYwL21oVDJZN1VUZXNXbE5URDg5Y3V4ZXRKTURJbEZMdEQwbW5rNXVpYVFl?=
 =?utf-8?B?NzM5L3RKWWNjSXdzUlkrL1d6M3IyZTBWbnV2eDVKUDU3ajVlLysyaGllRFdy?=
 =?utf-8?B?SkZuLzdraU4vZHJ5RGVHenIyWGEwSnpRSWFqbWxwV0tEakFNNkpjaVFNUzNi?=
 =?utf-8?B?L3d4Nm9va1dSaDcvY1h2eE1EWGtwSllieEt4Y0s4RWZXbTZCRGRZMW1odXlu?=
 =?utf-8?B?WG5zZWZwSGxOTjJjL2phNzBrK1FyR0V5UnRRbWs4UnNHaVVNbmtkOHdHNW14?=
 =?utf-8?B?OHBNMi91NDNxQ0duRFJTMG1WM3l6SGdiK1Rpd1NQeUYvNDBPampTT1hOdkdm?=
 =?utf-8?B?S0dKT0xDcUc4Q2dQbkNXaUxJVFlYMHMyUVRFUFFPNEUrKzduUUxEMm9XUlZm?=
 =?utf-8?B?M3FGQXFGWmY4cHdCOEw4RjZ3ajRSUUdaQ0EwZmJ4K2YzVUN2TEpDWEpmdlN6?=
 =?utf-8?B?Y0MyUUlWV25qTEZtR1U1ZUZnTEE4Zko1VDIvNSs3ZDNxYjFMK0x2bStKa3c2?=
 =?utf-8?B?Q0lPaWRSNGRsZlJNMGI3M1J6eW1TWUpwNzNndXlTcVcxeEJDd0RIejBEUXVx?=
 =?utf-8?B?ZFdDbEprdmlWNGhUYm1oWTUxYUZ1dk9mang4OUJzUFFJNWpMWHNrWHhmYzJz?=
 =?utf-8?B?WHVRNzdBdmJpNzRoTndqMDlxdXBKNWVhOVhZWStJZXpmN3Y3VTJVNDlKU3ZR?=
 =?utf-8?B?VzZ1ZlFmejM4T2JNdmZ2YkxWNlJSakxqMnpoSU1zZlVpQ2RpVFBZcUJNSWJs?=
 =?utf-8?B?NmRpMjRoc05JeVVabkRYckQ1RjFXMmp3cC9XSXErbXdsUnZQVStIcUdsNGlj?=
 =?utf-8?B?dnJ4ZlZ4ZGlJYnFSaXBKN2VvRjhCWUVLRVZTTEM3V2U0bWpodzE4b0h5MGlO?=
 =?utf-8?B?cFZtaWRabE8xNkdQdFdsMnQ2alJ3bXA3THZQWjhmS1VBUHNkNFFOYXhWR2Vu?=
 =?utf-8?B?U0h2Z1hFTjYvU0NweWJoa1ltZC9lNkdPeThjNWJNOGRmcGtIQzZsYXlRK2Fz?=
 =?utf-8?B?NC9zYlVuNnVVYlJmMVFTNW5mWThBclpKOGVLeU5tcXZJNUZuZG1hdy8xbEFy?=
 =?utf-8?B?Z3R5RjEzS2pPVDVscitnY2xNMk1HZ3VqM1Z2VHJEdUt5NlRVNWE1QS9Lbjd1?=
 =?utf-8?B?NU5SR2V5WmhYQkhZR3NUWWpXT2xaamVhQ1owMHFISGE1Ly9pLzBvOTBoMURU?=
 =?utf-8?B?aGFUVEdnT0toUEYwSWZ6SVQxNnlJYzBTbXkyM3lXeFp3bWdXNlp4eWFaMmVW?=
 =?utf-8?B?bHZRMEJ5YXdOUDUzc2Uva2tBUkh4SEM3TEc3QlFuYlVnYkM1VERtZzFnb2Mx?=
 =?utf-8?B?VW1odDIwYzdsWHFoSlZvcFJIL3dzOVZxMzFmZG05djA5eGJoNkpkdmFnSFZ5?=
 =?utf-8?B?MXcvV2p4ZkhObHVDdVQycm5xaUdiRXltTUg0Sk1sZTlUSGFnUDRnSnE5YkpB?=
 =?utf-8?B?eFQ0RE82REtqSXN4RjRxcWt0WHAxK21KZTlYb2MyOHJXbEJaSEtQTmpoMzVT?=
 =?utf-8?Q?ptzgp1j5Ejrvnm+WGvykQ0DThGdcht3trnmBi?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9fdf37-b2f0-4fa0-9d84-08de6b1ed3c4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:42:08.0614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRL80F0Q4o6sYikDGtT36C2Dnw0GkHzGGyDdiA+T+SkY1pwBfQnAeY59p52C3d4bK25mgVIvmWhOnxQ33FdFD4jGnIMAteuU1+i1Szh3aIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11318
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

Hi Heiko,

As far as I could tell the DTS patches all are already in next, so 
please rebase on top of that for v3.

Cheers,
Quentin
