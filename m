Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D9EC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A123C88AE4;
	Thu,  1 Aug 2024 12:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Gu9r07Xj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BD788B11; Thu,  1 Aug 2024 12:26:18 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CF288ACC
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 12:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF6Q4bA2QK7VQZ2ZYztS2Hi6qK19SKVv5NM3TO18KyU5FKSlkG8udijcyYQRyY/acyj4EYDogHgaBQDLZU1cFSmzaD0y1Fkio8JT3Ip8hPFQzZ4a4ggl194IUZnPDeMCkIKfWApD7sylmQt6QJWA27e19dibmRTmRcpQrpI2NX/powMnAfCBeYurag6WSkBTTK6oxwVR3q4akxLgRxMbX45H7a0FBdyZtJRNHznXt+m8wVN+ddAXKYy4UznwOK75/OJvHvTKGEfQzCV7YzFURLzEC9ICix+Eba5I1Yp8G8mgpYR/J2RmuWAQoH5AVuNxnTDGH+RyQo4RUJVi53UHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpI1LxNuNhos9gam5FmJUfFF/8qukV3q3j6aJWd82Xo=;
 b=ZRlr5Hjfb4rjU104w/SBXhrADbGocCXs7rVSTMuZK36higmbLFFYuLo9L2y/TDxeN+L/wEOHMetlWetXszgVwBXi3El9qDIu/gYsGF93C6HGY4ePSy0OW1b4yqvYqBnmpXU/zbGexkIt/rEVn3BumfGrbmYvu0Jvm5Shf2KrUtbnCW5wqOj9BSieaIu8+ejAlMJxP92i++ka3qPM2zkJkGanKGhK0vBSDgMTSMdTQm1eFWB7+oDJJe1Xbu2PiRVqWWfz+aaJEM6htTO6C3gJhdfpiUl9KSTD69xhRdBsekY8gyou4K1OEymtwJKbo16/YNkn753p/Xg5yaL0XuUMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpI1LxNuNhos9gam5FmJUfFF/8qukV3q3j6aJWd82Xo=;
 b=Gu9r07XjSOF4Wbi486bq/FPC6I5fDYBRGAC+pOcZifkZWbWGXO90SmVhtuUYTlxHKW8az5GYAPmDiWUJX5xoAeK/y65RdWVS6JdkAugyPZ8lLFpoYWBI6pLTXShsxc7g7ThHQEgoUZvpzcxP5299Gpk0p+fPxUcWTNIsi2v71Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 10:26:14 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 10:26:14 +0000
Message-ID: <d1f9b069-1c07-44d6-8dbc-fc6cd07b576c@cherry.de>
Date: Thu, 1 Aug 2024 12:26:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: clk: add UART0 clock getter/setter
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com
References: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::15) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA4PR04MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d29a476-54ea-495c-706b-08dcb2145ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm5uK2FXOVNkb2hOalF1QzB4UmMybE5ZT2UvdDlROHVkazZwcktvNUQyNkdL?=
 =?utf-8?B?Y2ExOVJVNlJRVVZYakRjaWxVYVdMb2oxM3NIUElpSjU2Vjk4WlJpZFhmRERO?=
 =?utf-8?B?UXR6QmU1NnpkdEJ5bkIrbWc4SFZGRno4QTBqOERJTDY4NmgwdFRoMlFScXk4?=
 =?utf-8?B?Sm8vYnhnNHk3ajdBT0JldWQ3RE5IM3YrK2lzVDltelhzS1I3dnBJcVlFUHpj?=
 =?utf-8?B?bkVuaGRpRzBIQWl0ZHFqbkRvQ0tlTjFWdUFZS3VheDZmK0dvcStrbUJ2Nmt0?=
 =?utf-8?B?T0dGdGM3QnJGRHJFODJkQVRZQ3poc0p2Yy93NWpRcnR4dUpuV2tzeUVLTU5B?=
 =?utf-8?B?TXkybFIyV1UwWmhuMys4S2Qxa01FS2ZURWFWemRwajhhalpYU1JrZVdiSGFO?=
 =?utf-8?B?ODBJaUpaTm42MmU3QzR4cFJmUWR5RCtxMm5COEU5K1JJTlBQdjc2SXg4Q1dk?=
 =?utf-8?B?WTd5bzZyM2pONVlJSzF0RDM5OERNYnoxV3g1dW1zZXpMM0F6MmpXaEtGUHZs?=
 =?utf-8?B?Zjh0dUNYQ1lvcUZYVCs5MVphc1hnazFKN1liWTBIclRSbEw4OHA5cjRDU09L?=
 =?utf-8?B?MXRnU1FmZW9qMFlHUXFVK1VBVVNaTXRaZmRiaTlnZ1prMHJLbWZhamZLOEda?=
 =?utf-8?B?WmpHdUlweXlEaEdHQzVibjBLSDBFUUovcHphS0NzR2pPSE5kNmVKWVhlWDNi?=
 =?utf-8?B?MDNETkpSeTJiaTJtV2crM1hoR0VIZ2R2QnZLVHVraEdzNzl3UW1aSEt0eEFv?=
 =?utf-8?B?d1J2VWU4cTF3K3hlOHhOaWR6cVorY0JWOWFpSksyUWphOVVSaytYQ2hjblZN?=
 =?utf-8?B?U1lqbCtNazJXZ2gxbDNvUk1pVmtDK1UyZno0SVp2OXhqdjNnUmJYcW9ycGlt?=
 =?utf-8?B?ZlVQejQ4N0lEeTFRY0Jiak1iQm9OaHR5NzJBN3czYkdia2JoMUZqbktJdHVr?=
 =?utf-8?B?VEVxV1N2MUtudyt6Q3FXTHJlNTAzNkhKNlpYQ25xYjVoUVBpOEVQMnlBWWc3?=
 =?utf-8?B?UHJUN3haTUhzeGZPakM3MEl4WUN2a3J0ZU1pV1NsUnU3bUpDUjFudTNzdmRQ?=
 =?utf-8?B?SUwrZzl3WVVDVE1aNXowdWJKUUp6RlYrRlNKMzYwWVNPMStOYWQweFZmS24x?=
 =?utf-8?B?U2ljejQ4bW1qbFc1UkNkZ1ppa1ZQaEVKWWRPVkhXaFpYeFd5V2ZHZTBidjVL?=
 =?utf-8?B?RnE0NnlwbWtuSm5jMVZSbVk4d0R1Mm5mMVZabXpXNTB5dXFwVUhrcXRQdmx4?=
 =?utf-8?B?NWdJaVNFaUdhT0ZFRjBIeHZwNTh3Z3pRaUJyeXc0L0U0S1Rtc2JTd2RtL0dH?=
 =?utf-8?B?VHl4NWswcWZqWVZFSTh5KzRYQjBIVXZpWWRFK0d1NFd0MXFqMi9KV1puSDJR?=
 =?utf-8?B?TVBjVXNXd3cxeW1Jb25xWXJvbnN6dGNnZWhhdlZtYVRzSEZGczFBSGdkNWk5?=
 =?utf-8?B?bmxFVEZxVWJCSTY4bkplSVZ4OTJHUnhWTk5iYWUxUVhXYWZjODI2RTVpRHV5?=
 =?utf-8?B?Ukw0QnNZdmNMeHJTZmpkL2htUEFIWVNPbFBJTTloR1F0ck5KQnpjSzVTcFJ6?=
 =?utf-8?B?Z243UEtFNDVYOC8xWVVwb2xubGl3d3Y4c3ZJZVhKSWpIUFYwVTRXOWt4TXFs?=
 =?utf-8?B?MGRGVVZxVFVDSHBLSCtWeHdYZ2ZoS09mYkVLRnZYRnJyeHFKd2l2ckxWTzA3?=
 =?utf-8?B?UkpSYm1veGh0RC9UaW9zWjRrUVFETzBqaUVIbEVKQmtUa2FsR2ZLNnB2ZXJV?=
 =?utf-8?Q?blv7Vw3ClXrBDfSeiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29BYnJhOFRqeGUwaitBYXBrdVpxbFNyTFhFN3FrbnVGdmxMcy8rNG5NeGJu?=
 =?utf-8?B?OE9DV0RVWE8yVTF5TGxjKzJZNU0zdnJKV2JwbWNRWHpxODIvazVkelhuZ3Mz?=
 =?utf-8?B?UElDTEJ4K00vY1AxUXY1TFBEdStHS3lTY05pSGZDZ3JRWG9FMnFHODBQbnZ5?=
 =?utf-8?B?VytyaWpoV29mRldhSTJxUXU3RUlIaDB1QkFOb1NVNTIwTU9adkZrOE4wSnVB?=
 =?utf-8?B?NXBiREZwV0lOWTMvZk1qcmYzSnhyc29KenUyN3ZDY0RyREFlUDU4NDkrOHNF?=
 =?utf-8?B?U28vaVhtRXV4TWJMa2wvMUlBUDAveFFOMlZibFY0dE5aSVU0NUdhR2VvSjRH?=
 =?utf-8?B?WlZYWjRNYkk5aEJzc3pJbDR2USs2aGxpczJWc1J3cG90ZDhYQ3NmYjdqYmk3?=
 =?utf-8?B?eXVvd0FxMkNTZUlPR0sxblQzMDJscE5VUjViSmdhMjU3c1pFN0pOUGlGV1Vj?=
 =?utf-8?B?UTR0SC9udWlnVS9kZW4zeUhQNVdDNUg0Q0QxblZ6eEQ3d1VQR0QrMzB6Z1Vl?=
 =?utf-8?B?am4xbWN0NWdjVlJtMU9lcVRSVzRoUThzQStSeEdPS2I0QWZib2JCOUl5TFA4?=
 =?utf-8?B?ZGt2STloamRJdVcvUUEvTkZKblBmNWFybDBFVFUvS28ya3Y4NmJBNHhTVUNp?=
 =?utf-8?B?UlFGZ2FHUGJYVW9CYkNONUhzcStoTzk4eW9tc25qL0J4dnlHcnlhdm5BTUJO?=
 =?utf-8?B?Y1F4dHNzc0tid2pVUzdLS0FySXJ6VVQ2ZVNPdVY5VVdTZFJra1hmcnVnSmJX?=
 =?utf-8?B?MHovZ1ppekl2UWdOc0VjMkdQckhsNjlteEVYOUFsRW0rcDZ6dUtQa25DM25H?=
 =?utf-8?B?VWttcU8rY2hkOWNGdU5mYWduTFE5MVlhSzQrWktsdlBqOGt4U3BvOTJpUlpG?=
 =?utf-8?B?RDZLNEVucm5IOUJGb2RuVkZaakZnUnpaeGVSNGV3YVU3dUNsajFRamkwYTN0?=
 =?utf-8?B?R2FKSnNGMEdzSTV5TkdJd1JHdXR0N1R6bG8wYWZodDNqL1FBb0pQcVF6eHpH?=
 =?utf-8?B?MmFISHdpS1Q0c0ozTHIwdnkzdmM2UURPdlFYMlU2Z29JS0R6NGlvUzVhaWV4?=
 =?utf-8?B?OThlUklPUU5TaXpWdFQ1MUZ3cXpTZ0RCeHVuRGRQZWlSdzhQYlhJOENNV0NO?=
 =?utf-8?B?aHFrYWVpd29HZVhMeW5GbzU3cnlWWVoveGx5blZiMFh0ejh3ekRHbCt1Nmsr?=
 =?utf-8?B?NUtQRFgxVlBTb1VrNUJiS1JGYjd3cWNMNGxlZVpYMzJPT3g5RFdnZGIxUEx6?=
 =?utf-8?B?UDFDOXp2Nlc5VWhrVmNpTHBudjUrajZvZGRxY2RoejI2ZHlybFliNnZEcE42?=
 =?utf-8?B?bjk3V0JGTEdETTdPSmMwNWxwZjdOOW1nZUpqc0t4SnFRL040Q1hIc0V1Q010?=
 =?utf-8?B?amhLZnpiVUEwY2pMUm81dG51THVVdmhQQ2dveXZ4aWcxbFhxUkNtZDRuMHU4?=
 =?utf-8?B?WDgwVW1pL3FSblVmNHdwYVdnZituS3FlZW52bzQ4WmhCRTVEdEFEaTBFU3Rx?=
 =?utf-8?B?SDh4L0VPM0tma0laNFYxd0dnK3NmcnRrVmNaZnFidms5S2JVK2Znbi9rdExQ?=
 =?utf-8?B?SFhaM2NZMytVOTAvOHNQOUx1UGFsMkllQU1VdG5Qci9uVnlHcW90U1h4dWRI?=
 =?utf-8?B?RnBjN2Jid2xXWjhHbnMzMnFNd0VxT2xrOWF5SUpIb0JHWnJjek5wU01yTDBl?=
 =?utf-8?B?bTd6cGNiZ09NL2w5ZGtmNU9PVDZsUkZTYjZ0cmRxZDJzVlRIdHE1aVZoYWVP?=
 =?utf-8?B?ZkwrdlI5ckpvQWVxNVFiQjdLTk9ieGI3dkc3ZGRoTDc5SkRSTHNRdngrb1k5?=
 =?utf-8?B?RGwvMzUzaEFFWlhyMTZpSzVGZUVsRmd0aml2Q28rZFc1Nm0rL3dYblVIN3Vu?=
 =?utf-8?B?a0FvZ1JBL3ZjWm1qTjFBM0xJbGhBT05RNU11NFoyZGRSUkVLcUdPcVZ1M2g4?=
 =?utf-8?B?ZENyNGViU2JLNTZ2YnV5ZHUvaWc4b1EyRFBFc0ZmQWNwc3R2Q0NSN0lVa3Jz?=
 =?utf-8?B?VkJEdk04STRRcVk1TTB6Z0RUVVZQN290RUtycHFkZ2FNT0hwZFM2WkRZUmF0?=
 =?utf-8?B?ZUxpdktHbjZVN1lNN3VMVnVZbldGYzRqaFdKcktnZDFDYkNDakFDWjhRT0c3?=
 =?utf-8?B?UytzUVlDbGQzd21MTCtheWthcDVodW5TeTVJclMvKzlrQk1lZWRDUWpDQ2FJ?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d29a476-54ea-495c-706b-08dcb2145ede
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:26:14.1576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABLSYt8Q79Pxc4WPZ75+Qozt1NPiZVPhwBXWIGesu/NYdth9BggiV3cGWZfrkYpeJWlNW8KjjnAO2LcYM39B2kA+G2pTpHp7vfT4qd5H3oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871
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

Hi Lukasz,

On 7/31/24 11:43 AM, Lukasz Czechowski wrote:
> Add dedicated getter and setter for SCLK_UART0_PMU.
> This allows the driver to correctly handle UART0 clocks, and thus
> it fixes the issues with UART0 not working in case DEBUG_UART is
> disabled.
> Unlike other Rockchip SoCs, i.e. rk3399, in the PX30 the default
> clock source for UART is GPLL, instead of external oscillator.
> If the DEBUG_UART is enabled, the clock source is changed in
> board_debug_uart_init function to 24Mhz oscillator, which also
> matches the fallback value obtained from DT node.
> In case the DEBUG_UART is disabled, the UART clock source remains
> default, and the DM serial driver wrongly configures the baud rate,
> resulting in broken communication.
> By implementing the UART clock getter/setter, the serial driver
> can probe the actual configuration and corectly configure itself.
> The DEBUG_UART settings now should not affect it.
> 
> The driver supports GPLL and 24M oscillator. NPLL and USBPHY480M
> sources, that are managed by CRU, are not yet handled, as likely
> they won't be used in real scenarios.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   arch/arm/include/asm/arch-rockchip/cru_px30.h |   7 ++
>   drivers/clk/rockchip/clk_px30.c               | 107 ++++++++++++++++++
>   2 files changed, 114 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h b/arch/arm/include/asm/arch-rockchip/cru_px30.h
> index b66277fc7f3..504459bd93d 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
> @@ -464,5 +464,12 @@ enum {
>   	UART0_CLK_SEL_UART0_FRAC,
>   	UART0_DIVNP5_SHIFT		= 0,
>   	UART0_DIVNP5_MASK		= 0x1f << UART0_DIVNP5_SHIFT,
> +
> +	/* CRU_PMU_CLKSEL5_CON */
> +	CLK_UART_FRAC_NUMERATOR_SHIFT	= 16,
> +	CLK_UART_FRAC_NUMERATOR_MASK	= 0xffff << CLK_UART_FRAC_NUMERATOR_SHIFT,
> +	CLK_UART_FRAC_DENOMINATOR_SHIFT	= 0,
> +	CLK_UART_FRAC_DENOMINATOR_MASK =
> +	    0xffff << CLK_UART_FRAC_DENOMINATOR_SHIFT,
>   };
>   #endif
> diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
> index 2875c152b20..64f1a335cb0 100644
> --- a/drivers/clk/rockchip/clk_px30.c
> +++ b/drivers/clk/rockchip/clk_px30.c
> @@ -1589,6 +1589,107 @@ static ulong px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
>   	return priv->gpll_hz;
>   }
>   
> +static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
> +{
> +	struct px30_pmucru *pmucru = priv->pmucru;
> +	u32 clk_uart0_div_con;
> +	u32 clk_uart0_pll_sel;
> +	u32 clk_uart0_sel;
> +	u32 con;
> +	ulong pll_rate;
> +	ulong clk_uart0;
> +

You could group all declarations of the same type on the same line and 
also respect reverse xmas tree ordering 
(https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs) 
(though I don't think we are that strict in U-Boot).

> +	con = readl(&pmucru->pmu_clksel_con[3]);
> +	clk_uart0_div_con = bitfield_extract_by_mask(con, UART0_DIV_CON_MASK);
> +	clk_uart0_pll_sel = bitfield_extract_by_mask(con, UART0_PLL_SEL_MASK);
> +
> +	switch (clk_uart0_pll_sel) {
> +	case UART0_PLL_SEL_GPLL:
> +		pll_rate = px30_pmuclk_get_gpll_rate(priv);
> +		break;
> +	case UART0_PLL_SEL_24M:
> +		pll_rate = OSC_HZ;
> +		break;
> +	case UART0_PLL_SEL_480M:
> +	case UART0_PLL_SEL_NPLL:
> +		/* usbphy480M and NPLL clocks, generated by CRU, are not supported yet */
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	clk_uart0 = DIV_TO_RATE(pll_rate, clk_uart0_div_con);
> +	con = readl(&pmucru->pmu_clksel_con[4]);
> +	clk_uart0_sel = bitfield_extract_by_mask(con, UART0_CLK_SEL_MASK);
> +
> +	switch (clk_uart0_sel) {
> +	case UART0_CLK_SEL_UART0:
> +		return clk_uart0;
> +	case UART0_CLK_SEL_UART0_NP5:{
> +			u32 clk_uart0_divnp5_div_con;
> +
> +			clk_uart0_divnp5_div_con =
> +			    bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
> +			return DIV_TO_RATE((2 * clk_uart0),
> +					   (2 * clk_uart0_divnp5_div_con + 3));

Are you sure about this DIV_TO_RATE here?

The TRM states:

clk_uart0_divnp5_div_con
clk_uart0_np5=2*clk_uart0/(2*div_con+3)

but this would make it
clk_uart0_np5=2*clk_uart0/((2*div_con+3) + 1)

I believe?

The kernel seems to be handling it like the TRM says (but I wouldn't be 
100% certain here as the clock subsystem and Rockchip drivers have many 
indirections and I may have gotten lost at some point :) ).

I think we're fine also regarding u32 overflows as we would hit this if 
the rates were abore 2.1GHz and I think GPLL and NPLL aren't that fast.

> +		} > +	case UART0_CLK_SEL_UART0_FRAC:{
> +			u32 fracdiv, n, m;
> +
> +			fracdiv = readl(&pmucru->pmu_clksel_con[5]);
> +			n = bitfield_extract_by_mask(fracdiv,
> +						     CLK_UART_FRAC_NUMERATOR_MASK);
> +			m = bitfield_extract_by_mask(fracdiv,
> +						     CLK_UART_FRAC_DENOMINATOR_MASK);
> +			return (u64) clk_uart0 * n / m;
> +		}
> +	default:
> +		return -ENOENT;
> +	}
> +}
> +
> +static ulong px30_pmu_uart0_set_clk(struct px30_pmuclk_priv *priv, ulong rate)
> +{
> +	struct px30_pmucru *pmucru = priv->pmucru;
> +	ulong gpll_rate;
> +	u32 clk_uart0_div_con;
> +	u32 clk_uart0_pll_sel;
> +	u32 clk_uart0_sel;
> +	ulong m = 0, n = 0;
> +
> +	gpll_rate = px30_pmuclk_get_gpll_rate(priv);
> +	if (gpll_rate % rate == 0) {
> +		clk_uart0_pll_sel = UART0_PLL_SEL_GPLL;
> +		clk_uart0_sel = UART0_CLK_SEL_UART0;
> +		clk_uart0_div_con = DIV_ROUND_UP(priv->gpll_hz, rate);
> +	} else if (rate == OSC_HZ) {
> +		clk_uart0_pll_sel = UART0_PLL_SEL_24M;
> +		clk_uart0_sel = UART0_CLK_SEL_UART0;
> +		clk_uart0_div_con = 1;
> +	} else {
> +		clk_uart0_pll_sel = UART0_PLL_SEL_GPLL;
> +		clk_uart0_sel = UART0_CLK_SEL_UART0_FRAC;
> +		clk_uart0_div_con = 1;
> +		rational_best_approximation(rate, priv->gpll_hz,
> +					    GENMASK(16 - 1, 0),
> +					    GENMASK(16 - 1, 0), &m, &n);

I guess we could try to find whether OSC_HZ could produce a closer 
approximation than GPLL but I'm not sure it's worth it right now.

Otherwise looking good,
Cheers,
Quentin
