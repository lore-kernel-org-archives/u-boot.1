Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E745CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF47484B95;
	Thu,  7 May 2026 18:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lTrd3cYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41BDE84B23; Thu,  7 May 2026 18:24:34 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C3984B9C
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1S+67VAynXPWo9MrECYCfj8VbWV0953DtvjQk6yvYOS1w6PYSR3xZJjswDWMoVl5KbiAvsXaxKIaA1xAszqtG2NANzC/oiSSKhC8P7uo0BGCnLt4y9KvuBrqcbSYLaADKCF953ts8244YYpXRLk54bdYlc4XODI0mFzp+Xo/MIfk7i7ywA1+s9YOveVWiF+ES84h21I8BYsCmXbPhKpDuUaTdjR8V5Wyzp19SnfuCpSDya5NPaoGumoOd4VwSwPH3q1BRrKfhqGfDPl4rb5UHWumLsOOw5iI2JpEoTq0XrVJUexOZ6NBjTvC8XUO0VdUWHYbmmtBq4QHKFEr2y1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRX9L9m8NxPvG6R2jVEpHgtzDcjzCzuEAd0a6Ros5/4=;
 b=PYkp9Hi7JkQCy6NQALiJFKJzEEXoodADk/goqs36ahMm+9LMPDEINw/jo0cvagUTYSS1PCrpMfHEbWXi6/Hy27EACQa9Ly2F7IFHyZpYm3WSD4svSodqmhFt72RNpnMp6AhUNaifgW4TaVVn5KGHecUjX95Nm7s4cpSnmZu/RBXAoBoCJv1QwYYGWDm6LNZSuEmzUX2r+J7KIA5hZBWD5i6qtUwcFjm0HIzC5h9KWfacKY/vbjnb+eQ8uNZAwXbk8G5DcoJO2T2RrOYK29AAe4MR7ZPqgINk7B7KloNVFBZY+gsIUBzLItm+5wspCYZL+BDtlm2sxcCwz57yjE2mXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRX9L9m8NxPvG6R2jVEpHgtzDcjzCzuEAd0a6Ros5/4=;
 b=lTrd3cYpCY0vH0b2zWAgE7UWtTSVe97OMPDp17o+h0o4lUjvuUCfQpwRSjCrAuDN2tWc9LpbvGYYUz+MfdbwIn0T2VG/JAksa8rdtVQGaDibDmJ/r5QupbYipz7R/uTLLUX9BCGrpZkWRR6Ak2vJxlKs8S68Ts+yzX4wHpj3E50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 16:24:30 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:24:29 +0000
Message-ID: <b3638642-cfa7-4d70-b646-c2841260b4d3@cherry.de>
Date: Thu, 7 May 2026 18:24:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: agilex5_emmc: Remove kernel node from binman
 for non-VAB flow
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
References: <20260505015712.4266-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260505015712.4266-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: de649652-4899-4d5b-ae8a-08deac551d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: u5tSnfWypurRdvLHn3JevBvYSLgtTvHnDoGROZRdlzOb0z+RS4cIJA0qSUwUm6d5gLYA3a3s51O86eN1wVYl99n1rNeF0HziklDqcsC9cg5Egrp2D2u4ozNc33up8e2Kt1grrNuWUxW7UI8q/advWtlBTAxMwbMNeS6DnnXPirQvg0XLGSmJL3ehA/iWSIuUWiqK6yHl/PwzSQI5f315rg2kxPGtgzOlo5wxWjoisiOdNEDJYt7YqqaYDcS451qKjRWdWABekqtuyDruFu4V9aPSoqHLWCXC1qFhq+bfNptfraD+aqPSIqXl8G8HfB9OZuYbuCIUF5W+vM0hVxOU56zyj02VBOqrWDaxUgRz4DptFWbQIVybKi7+eO4myIWoE5qJDHCtFOSFm3Ryw/NAWrhIR8NqhOOkZIhuCcZ2u2j+fg8hBbSyiVnLeBFaddqchmoRo3u6TurmXTfcmP0iNPaiJMNwB3afSKBMyYOvyvXHwBhveNmcPjwkoINlXrveD2tv0UXnfZmkUw3WG8LEQNOQWTdu8zG5zpYhsCfK0Jq9B97VoLaVTCZ0rDuBAQfNvkRP+TM/ECLPwk+Z991iOm/yYzwro7aK7dBfCTNLAKy6q3DQ2pl7mOh60kp8gGnESvllxW+k1ii45TuyV22nNnpRAUkl851n/6YwWlvC3vTtIgXj+Rsw4TNkAS2rTRa2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU0zdzRFeE1Rd1JyWkRqOCtSQ1JmdmJYdnh2Vy9Zc0kxZU9VSzFiY3I2eGNT?=
 =?utf-8?B?T3lPVkswdDdZRmJZUFJVNjh5REQxRmZseXNhZmNJdjF1bm84Ym1ZSi9oVFdm?=
 =?utf-8?B?RncvNVg1K21sOW5zdnVQaUlIbUdmNGhQMXUzNXdSVDk3K3Z2cEtHRW9GT0Q0?=
 =?utf-8?B?MFY5VFJDV2FadlZNS21PYlBkRjVnakpRNXQwMVNzQ25sc0VhVjYySE96dlpS?=
 =?utf-8?B?TXYxbE1GMVU4OEdmK3RnSElBektDbGFFdGtWRmp3OEYwcWFRSmtJY2V0Q01i?=
 =?utf-8?B?V3BIRWlEUm8zcGxZbHAxRFZ0Z0ZYVWMyczdSY1hMNElkM0drQ2pnSVh4T0R0?=
 =?utf-8?B?VDdxZVFPd29YRy9RSkpkWXJxMVhBTFlqQjFzZStDR016ck1tUWNubEtnTCtv?=
 =?utf-8?B?NGxNdW1BNnFQc0Jwb0E4UnZvb3JmVForUE5HSTVZbkZ3UVpOc0ZhMGFXMkd5?=
 =?utf-8?B?aTVsMVhkdmVYSkpkMmo0SW9oRTBxVFYzT2NlM2t2Mk03Z1VOYkZTeThsdXhY?=
 =?utf-8?B?aGc5b1pVOEFSNC9idFBvaVhTU1VUWW9OazNMMjkvRm0zOEJLZm9oRVduS2JW?=
 =?utf-8?B?c3NsTnVzTEQ3ajM3Q1VHOU1iTC9SQTZ6R2h6RnErck15ZFRveE1WOGdTTzFk?=
 =?utf-8?B?MHZYUHNNWlpRZE15c005ZWNHeitqT2dWcWFML1ppWUdVa1FRLzlXRVRYZjFv?=
 =?utf-8?B?c3dkNDNGZERucHdQZ0ltaW5pU05ycE1pNzNnQVQzTjl2V013K2lmY294MUcr?=
 =?utf-8?B?RWJTR1ZvMkNMTFhTUkRGem9jVGthQTFQYkJnVjZlV0Mra0FoQ3dBaytPd3Ja?=
 =?utf-8?B?UlhVdkN4djY4cXp1WkEyUUhSZkI4VzV4QWc4V1ZyMnBLZkRkNnloV1p2cHhY?=
 =?utf-8?B?bSt3OEZOTkVxd0hHRmk5TU9MbGdWSDF0UVZ2MXpvM21RQk1mdnZuejJlOEg2?=
 =?utf-8?B?bzE5SmdYbEMzakY1M2F6RU10dVpJRjFCOWZCVm1HbDlpZHJQVkN5Q1UvYlU3?=
 =?utf-8?B?TzN1NjdhYlJGNUNnR2J6Z1RneGNpQk9Oem0rMUl4VzRvV3JHejlPUi83WlZs?=
 =?utf-8?B?OG9Rd0UreHhENEtnTHAreW44V2h5QjB1U0QxZis5ODk1UXk0UWU1MGgxa1NM?=
 =?utf-8?B?NzFQUnZNSTlLUmlBcjBqbjdEVnpacWJLN21IV1hidGtaQ2tyRHJlNUhxc3Bv?=
 =?utf-8?B?b3Z1WE8rTndPdldML1VSbHZvaFl1elIwVURqajgwckFPUnREOXBwOVdVdVJU?=
 =?utf-8?B?Smt3M2tPSHIyMmxZM1gxbkdxZDdNQjBZUHVvSXFIMXpJK1paZHppaldzVG0v?=
 =?utf-8?B?bFcrWU0weEw2Zk5DNzhnWTMyZjN5Y05VVkRWbU1kZEJkSndvdDlZblhVVHE1?=
 =?utf-8?B?ZnFoSEl4MDNKL3RhN1lOOWFMdDU0L013bmdOK1lldk4yck9WMngzaEVGTml4?=
 =?utf-8?B?VjNaRkJCemZoeFBtdnZEZHBzVU1UdkpEOHN4ZjkrMjJmcmVoVmY1ZHNIUktF?=
 =?utf-8?B?RFRFN0FMbVg5a0JqMmhETDlGc0Y1Q0t6RDYrRkgzZFhBeWc1NUl6Zm95WlFG?=
 =?utf-8?B?QjZ2Qkg2Y2wrV0tiNmdOL0xabUpDdnJEZ094QzB2TU5HSkphMzlKRG5yS3lL?=
 =?utf-8?B?WVoxTnNRZ0pCNW0yMHF2bW1mMFNZYUIwTytVclJHVnd0RDlWUjk1Ynd3Nmdl?=
 =?utf-8?B?UmNiVllIOUNiaG5lU1V6WVdna1hvTEkycFM3Z294QWRqcEJhL29kOUtaTk5J?=
 =?utf-8?B?NURpdENoemtSN081aE1JYjE0TGoyZSt4ZWJFR0Q3NVBYWHd6aEpoSlRHNHdK?=
 =?utf-8?B?U0c0Z1ZvZHZNRDZXSjcyQjM1SU5XMWJFb01JMThPNUN0eERLeDViV1J2ejBM?=
 =?utf-8?B?MlUxQ1FxREdySXVGVjJZMEt1Qm1UTmFTdDgyYlVmbnMwWU9ZV3NoU0RScDRh?=
 =?utf-8?B?MFN1OXU4RlhrbGxPejJGQUJ0RTA5RkkrZnJGckVmSTUxNW5DY3ltWXZ5TkI2?=
 =?utf-8?B?WlNzN1FGajMvR2xqYmJpa1FoaXpDWHpjcWljZDZwVmdvazNZWDV5dU9zSkgw?=
 =?utf-8?B?eGxCdnNaeHZueWhKTE5LeldyRHdpNVRiNDVxMXF5U3FmcU5ONjBIQ3l5MWhj?=
 =?utf-8?B?SGZSbHRWV1FtNGowZzlwOERneURvV3VaTzNRcVl2eGozMWZWUW9jdWVZdWdr?=
 =?utf-8?B?S2xrbVJiNTh5bWRlNHNwOGduYlhlV2UwNmIxUVU5RVZtWUZYbjJ3aWw0ODdO?=
 =?utf-8?B?WEtkSjZFdGZUbHZTMVduM3kyblRycHoyQTZla0RIWXVTWTNrVnc0YThnM0lG?=
 =?utf-8?B?VlhpOHZ3ZmJIY0xRU0E2aElWbmhGVEF2N0ZVUjRXREhhMnJCU3dTdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de649652-4899-4d5b-ae8a-08deac551d48
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:24:29.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/zSu1fiyK8AzxpRKNCFpV0Gxe9W9TKdDVZI0EsB5gFPPZa7Y0r/1dWf3LDKEQR1nd4gqO3m4xYR6qaXZa0+8IY+Y4H3zCZsQea/aOuJSd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
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

Hi Alif,

On 5/5/26 3:57 AM, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> Binman will attempt to package kernel.itb during U-Boot build, expecting
> Image and linux.dtb files that are not available in standard U-Boot-only
> builds. This would cause build warnings with missing blob errors.
> 
> Add conditional deletion of the kernel node from binman when FIT is enabled
> CONFIG_SOCFPGA_SECURE_VAB_AUTH is not defined.
> 

Why is this specific to socfpga_agilex5_socdk_emmc?

Should we rather guard the definition of &binman/kernel with 
defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH) in 
arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi instead?

Also, please use CONFIG_IS_ENABLED/IS_ENABLED macros instead of defined()

Cheers,
Quentin
