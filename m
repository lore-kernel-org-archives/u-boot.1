Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AD2C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 11:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AE784CFD;
	Tue, 14 Jul 2026 13:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="g0a+S157";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ADCE84CFE; Tue, 14 Jul 2026 13:35:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D697484CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1EJj+J12sp/eFeLVm0eGfK8/7kpzHR5hgvNTFJC0P8DQWoy+1wBZ2UwWKE4p9Lyxf/xrzpCjcLEDf9L/0ya7qYRbwmg/GZBMhNGtfF9A7ZQf5vMUALiBSI8NOVCgor/jIQSSdjkXec15nqHwpCNFiBxwhBuzAhhzIYEUzYXl5f5thKfjFt1uaa9AvBmDaXJEZknX4TZxF9lO2e+HK1gJoTgZ3sD2DVJ1wyJ11ZuNFEntstdIQIVFQSqlg/OftjPTIpqxvo52K+OwqmhrMHMJQhrDiKt59tBtkH9qlUY3B6C/X7+m6mb3BkuLRXtNQwXNGOO2wRbSNdjviNtnIEJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7NWy7AYVHtKYKapVzleBK4edtXs/IknfBGprkEJIp8=;
 b=W5+XL9cv9OYTBHnFZhGXGBw3h8WmbAjeNUTRInKY2OABN6i+vak6CjLUx8NF7qkPYeshcexW3GVa6Lq4NOqGE8mP9rtFgljgQ0apQnw4JUwegeQ467fxsFAXdza1w2Hx8u5otvK4FyXuJ9ZhZKK9ZXwD+evI1tDR67AmRs3R5sW3bPgdA1Dh7xpc5olRoUbHA/FTzDh2jFsYwjaGbdhGZNuewyYtZCoVYtyzD1TKChIe2NFM3u5BBQadEzhO3X7C4M90YxpSKf+HjwqOUPVP2PYQ8sGs98WIUgQh6n1PcfM2rBf3ffZ/szpGyD/giP4DRdtW0L7fAKNftQXREo9hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7NWy7AYVHtKYKapVzleBK4edtXs/IknfBGprkEJIp8=;
 b=g0a+S157iYHWMMVLcccs+DV7KCTcdg/vPi0all5gzbT+C2KM5uWUwFROh5aD3t+k9vE54BJLJaa6rj2DETIRisB0DHL/Wit2j6F55YSfPA/giCiMvTyHZQeKnF/Vb6r7ohj3tTlBhREmpgG6weggtKTduh1yjwrr5/E8Ql2xqnbav0NXzm2ctsA+WakyR2qioSx9ncE1UD1DpHAAP8Jm+KXLgEdKwL2h0KLf40www8B8DAwvONUh/irjIkkuzfS2AVnBomcXBeAPkAndMylMDW/f4HDAPzZyAo7zsEqD7yLffyFOajE8n3m+FA4a/WGC8mN/Iki67LY0zBMqgPo0yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PAXP195MB1199.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 11:35:36 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%5]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 11:35:36 +0000
Message-ID: <53d46b60-1529-44f4-95cd-be224ff66bf1@phytec.de>
Date: Tue, 14 Jul 2026 14:35:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm: dts: k3-am62a7-sk-u-boot: Enable DM services
 for main_pktdma
To: Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>
Cc: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260710102229.2980029-1-c-vankar@ti.com>
 <20260710102229.2980029-4-c-vankar@ti.com>
 <178402710826.246195.6210593528035580821.b4-review@b4>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <178402710826.246195.6210593528035580821.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PAXP195MB1199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca5f6a9-95a0-4e39-13ca-08dee19c05dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AJ/IFHoMFfRW+ssrqBDdu5yAQF7Q6/OOC2ppCxzMsK9cdwqOMRuydmtD1r8iItrpoeaD8T3HOvRtVe63dC2P4vAdGxLLHi+87DuEeyKkbGs1pWCCdjSNTOTkQeMKnvmU8Rhok6MALu8QWox6glfFVFcwXW0MzNrf9fNmsmc2RmBbaqEI0L6E9DM0p/X6Dd9YfMHTD8Em+z7QXr8KpbLbZYMMZT3PfhDJAMXVIg5ZuXCQo6VwzObRF/EyY5mER0RvBmzCDN0HO+GYWiJeadb4MUSoX1IEWN68RIK9R552iBllqcahZ65i8l9nh3vwExkZGSo75f5KUIRRKSwxOQLsB4RgPXQnqpmxZhQgomiNGyZhm0znoSbEJkwJrkfHrlprygk7CBhxBOruco1Z4+KJYNNMPLT60pS47ezcpU/b7YkdhwE/s6k7BwIZJlhNJgI2Q8gnne7kT7ctMbfh+drvD7QGEdz0pmgx5xi0tr0ipna0y5m0O7L5/Mqo0xjfzIPtVYR4OARRrl+g0iWDaSOanMz+LKhnafdP86RfSoh7gf9smlT69C2ycPcWg8XDu0kb32RABGtRQT/dAXFnVTd2WpoYkxOReFVqHJH4O1B0HJ3hZ8JqSbIokTvHakOfFkLTNNw0XELg74ATDzLiAKmYYcCiCFkG5zc/6YHf/kp5Esk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlmSTVqMXo0ekp0Q0JCbFdGbHpmVzhMYXpNM1hKRTFNV3N5cFpLQ2VjVFlH?=
 =?utf-8?B?SkE1S3BPQ1R2SDFMWG1EVWhvOG1UNnlkdDN2REhzc29zRm1naUZ5c1gzajRy?=
 =?utf-8?B?aFVVL0dyd29uTnlvcVlqN1JvRnBkODlxNTBpV3FEY3huL3k5RG9ndVJaSGUx?=
 =?utf-8?B?TVNzbXdrekdRYXVtNGdxQXlLMHBSbWpuZmtVWEtuM2h3T0RlelBFeFVsWDdy?=
 =?utf-8?B?aG9mYjZhMXFNTE9SVEhXZEw3YWMrdVAxTFkwdGZnM2VMS3BOSnlkNVlOaE9V?=
 =?utf-8?B?TWZ5U1phaDhYWTRZZVRVVHUrY0QxUGlUYzFwYmlCa2pXcHFYREc2MFJ1aXJx?=
 =?utf-8?B?Q2RqUnk1UWVtT0FZL05xSXo0SjhYV0UzMmt3WGp3UVVVK2lhRHY5bWVUUklU?=
 =?utf-8?B?NXFMMEkxeHA2ZDRIZ25jdkNuN0lacW9GWks5U0N5VnRUdytMUmpXU0VVTzhL?=
 =?utf-8?B?SVcyYnZjL09aRHR5UDJsR1BiNklnYnZJM1V3K3RBVjY5Z0U5cXhYK3RXSkJK?=
 =?utf-8?B?UStOdWR5RlJJWlpKZm1Qdm42YWJCRFRSWnUxQUt0K2FoUUVybEdhRUp3WFd5?=
 =?utf-8?B?aFB0ZnQ0Z1dFQUMyNmNwUy9QcnhGVmlCQWhpMU4vOTA3UjAzaHhoZDBOeVlO?=
 =?utf-8?B?UkZaSnBEWU9Rb0F4K3dtSHYwWEJGcnh5MXh1eDljbmRIY2VYVHI5d2FKUTVG?=
 =?utf-8?B?R21Dd2hCSEkva2IzTERFMkg4bDV3b1RFS2M5YU9NS0RBOFNHS0laU2Q1bTFH?=
 =?utf-8?B?RnNpZUlvS3RocEg3T0ZYK2RkaHNPbVZKeHEzRTlVeGJCTkd4M3VGd3M5MFdj?=
 =?utf-8?B?N0xvMlZGUXNzMVc3QXA0YjNuUi8wTGFZaEpLeS9EODBudlE4NC9OeFA3bGc3?=
 =?utf-8?B?bURwb1pySkZMZU83U1V4VGc1M3JTZU96VTVNL0VpYUVwSGI5eVA5ZjFVYmtq?=
 =?utf-8?B?RnRRSlFxVUpodVlTMDJ6a2hla1hicHhSclcvWisxcExCSGwwclFtRW5rcGp4?=
 =?utf-8?B?aXVtVkNCN1NCOTM1cXB6bm40MGEzZ01nSGFaOGhNOVM3UTFLSFdNWERNeFkx?=
 =?utf-8?B?N2k0T2htNU5nYXR2c0dRdWdhc1MwWVc2ZlVuR2lqcExoVnhVMmEwdjRSSXVh?=
 =?utf-8?B?aG44ZE5laE9Lb0ZKT3crSm5RSVZkb1dHYlNjRFhKb2h2dmtJL2RiVmE5ZWFt?=
 =?utf-8?B?WXhMQUpVYTNGelJEbUl3amNGQ0p5RTkzYmdtalVFaXdNRHpXNStDZ3FBOGE2?=
 =?utf-8?B?eWxhL1FDSkxTOUJUSWJrcGZzYmNudlprcWY2NVdTeURVbUU4M3ZNNUw1L0Ux?=
 =?utf-8?B?cGcwWGlPQWVoZ3JpcUdoTzZZcXJPN2VOay96ZFBNQitMSThWMEt6UWFpN3hM?=
 =?utf-8?B?UjNEQ1hTejlsTmhLMS8zd2g2TVJrSkdnSnNMRy92SkdYUGxSZHlWWFNHZkxM?=
 =?utf-8?B?NHIydVNpbGNub3Z1eUVET3YrM2JoK2NqSktNZHd5MlZOREVqNmtiYkpZNkRj?=
 =?utf-8?B?Q0JhdytEcE5SZEdoQTRTajllbEZmNlRsMGNMT3FPaUxJY2FTUVBwME0yR2Zt?=
 =?utf-8?B?WXFtN01GclJ4Rndlc3Ava2k4ZjdKZXJWaGhJMlFmTnRnd1pCY0dWNkozWFRB?=
 =?utf-8?B?RXIwUC9wdHpKVlQyTnl4eTBNMklGMnJnSFBnMlhOdEYzSCtGOGFJMnJoeUNJ?=
 =?utf-8?B?cUdiN2duNldHOWRHNGl0ME5pamR1ZmpxaGlxZmxmWXlsMVFVQ1RVZW5hRklX?=
 =?utf-8?B?L1NIUzlHcVJWV3gyWEFlT1hibWMxaDdRMms2Ym43Vml3NkZqNCsyTi9zMlZa?=
 =?utf-8?B?MkxrUGp5S1dvTldOTExOQ2Y1K2I2aHRUa25vTWlmWmFFVmlEUDVpL09Ea3Fw?=
 =?utf-8?B?QkUvVW02UnF1UjdhaW5xQXJlbEtDUjZjVlJUSGh2dlB2Y0JqZ1dCS29SbzBn?=
 =?utf-8?B?YU13cUNzMUhNQ1BSbWs4ZkhFWmliT1JKQWJKVkcxZnd5SFRJQmdldmpMUlJl?=
 =?utf-8?B?Y2x5UUxWaW5ra3ZDL3RrSG01clRQa2JwM1B6L21FcmROM2EyczNTQmlzQm82?=
 =?utf-8?B?dzAyaVEzNndxZlBCVnQ1bFdqazBCRGNKOFFDOVBKZS9sUzRDM2ZRaHFDb0Y0?=
 =?utf-8?B?b3ZPNjIvZUI5aGhucGJMcE1maUt0ZFlxTEFBaFNscnpBamJXYjNTT3p1dnF3?=
 =?utf-8?B?d2hMYnBIQWV0aFhsNHB1V1ZHVHFIUzMwbFBwaVBhR0hnOXMvNVFVQ08ydTlV?=
 =?utf-8?B?NUlFZGdiSmd1ZEIxUWtOeE1wVFpCbHY0OC8zcWE3YzdWQi9hTHZuNDhVMWxR?=
 =?utf-8?B?UVQyVXA5aTNZaUoxczBJK2E3OTFlanRBbTY0SDhNUFRmNk05M3lobnU0WnNz?=
 =?utf-8?Q?rdI6GlrL6gwM3xjqOVQKVG0GMw4neN26hm3Xt2ZNBLp6U?=
X-MS-Exchange-AntiSpam-MessageData-1: hC824ZHhbbdIcQ==
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca5f6a9-95a0-4e39-13ca-08dee19c05dc
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:35:36.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsQf/DDgwr9jbv/HCHUVx2qWcbqepV3DMI30yOODSpE98k2h+ESFIoR2tJmgcBAJqbXmtukzl0abqtA8HwLPMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1199
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



On 7/14/26 2:05 PM, Anshul Dalal wrote:
> On Fri, 10 Jul 2026 15:52:29 +0530, Chintan Vankar <c-vankar@ti.com> wrote:
>> diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
>> index 4570ff6edbf7..9c2a6bf89a92 100644
>> --- a/arch/arm/dts/k3-am62a7-r5-sk.dts
>> +++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
>> @@ -42,3 +42,8 @@
>>  	status = "okay";
>>  	bootph-pre-ram;
>>  };
>> +
>> +&main_pktdma {
>> +	ti,sci = <&dm_tifs>;
>> +	bootph-all;
>> +};
> 
> We should have this as part of 'k3-am62a7-r5.dtsi' so that other boards can
> also get OOB ethernet boot by just modifying their defconfig.
> 

You can set the boot phase tag in the Linux/upstream device tree. This is also what is done for other nodes required for booting.
