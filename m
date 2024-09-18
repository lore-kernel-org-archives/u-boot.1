Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4221FCDD54B
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 16:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9442288F4B;
	Wed, 18 Sep 2024 18:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K8gAU40o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C296488F4C; Wed, 18 Sep 2024 18:59:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA33488E91
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 18:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkHpOWhNetpfUwD4YmyPZ2N0yyvtdyQ/0eo/xyMWjpIDBT0CmOTxPGorJhz91EcH85cCeLcFYn9JnzneH+aXBFWy2KytNi/G2uwLy2B0DuRHGyh1rzrNZ0Z0KOs63t2FXjVt649fdCozuTWMaLaf0x1H3phPNrVtzOh+M+UI5CPXjjdrglwSFqBXCXqLKGv+BfLQgxDxO4jLQuXCHY6XV+ZCdHff+3UjpR5/Rqir1sZrki+Y+2DYJx4632HDJQuXLjhtb6RpWuS3YNwOA3hVtpI+P8fFNtfpwhncr4K+iSGu+T/8HnRQYOaXDb/XHfTQ8eKed+Iy1Wyf75seoAr0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzHPfuFFF4Ojevnkkz2WW2p83Mms9SMH0c/4obm/h0A=;
 b=Trxjnzyp45050Ac+LASXEHCi10D/0exUSWBF6zQn6FLzFdlO1AxIi+pzYmXV4GJyLQnX54yjyWH5jJpVg9tcjLAoBC4Z7wxB+1AYH3VrrKRZSzv83pX/aaEjwoek/WE95TPm4xWboLasb/1ySMZjCyQWmBH/68i7HqiU708HUFdfjGocXk0e2fnL4YTr9B1bfxO0+tbMmQxUAbRnwqDAD2K34ZKLYlfDLdwrcMUBD40SAiSufBmePIgV7oa8oEKnhEaXpI+S9u4QR5gmYZj5Ovj2QzGAxWUuqb6cjAetnnasUw4kaoHIgvxSrVxRB6a64fOiOwUWUCh9zi+kV27A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzHPfuFFF4Ojevnkkz2WW2p83Mms9SMH0c/4obm/h0A=;
 b=K8gAU40o8IMQPTjRrZaitzfC8nB++7OtgQ63cDJWEj9aCzb2hCNfjT8wr+IMTLp1kwVfV0/VYFtG/6nbN/iaMPkmkYyc+Yru+zgD44nwKqoKEgJcv6716LSTSZzB9wj2DZd79MxentYXCuCrz6CKSIkmp6SiGcsFef97H4zjvtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10209.eurprd04.prod.outlook.com (2603:10a6:800:244::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 16:59:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Wed, 18 Sep 2024
 16:59:31 +0000
Message-ID: <72e37714-bdac-4334-a2a9-18d6ea954b73@cherry.de>
Date: Wed, 18 Sep 2024 18:59:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] env: mmc: rework mmc_env_partition_by_guid() to work
 with two separate partitions
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Marek Vasut
 <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <20240912134141.4143855-4-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240912134141.4143855-4-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: f4deb0a6-2dc7-48a3-2ec7-08dcd8034353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUJoWTR1ZjAzR3hxbXhtbzhhV054S1FsVHJ2QllGbEFTUFBqSVZlY2RaRFBZ?=
 =?utf-8?B?NW9xRmxOUGxpS2x4YkUvdHJ0M3NURW4rSWh4NEtpNUtjS0F3b2wrUEJqaldT?=
 =?utf-8?B?MWNKekpmOUxBbXE0UlJ2eWI5dmhCWjYxb3VIRTZvOHVZRVJWS1dSVkpjNkhL?=
 =?utf-8?B?cm1qYlNsMkNqWW5DTk5yWFFoMzVPSHFaZ20yWTFGWEtRNER1SVVvRHBRWnRj?=
 =?utf-8?B?bmlKREl6NSt3M0Z4N3hodDN5NWlGYU5icGJyd2VhMDBIcE1CUXBYdElWajlv?=
 =?utf-8?B?WnVXSzcwQVI2WjdEMmYrNGEvYnZYZzlFMDJYSThiN0N1Z2dHb0xmTU9odkpO?=
 =?utf-8?B?ZkVpV3IxTzZYZzVrdXpYUkhEQVpwMm9pL2k1L1RycEZpVWFhVkluWDdlaGVm?=
 =?utf-8?B?TG9ETHhMSjk0OWxjeTV1a2ZSbnR6amVLbmw4V253cC9IcVMydCtNaTc3TjhX?=
 =?utf-8?B?dnNFM0hXQlQwZElxdlh6Nk5sRUkxcEo3SWVRdmVtVHg0SytlaVppMXVNUXg4?=
 =?utf-8?B?MFNnOTVNMmpkOGtlL1RlcWh1aHBFaXhuaVlWaEZqalZybEMxeHVGQzVlOGE2?=
 =?utf-8?B?cXlPbGZRT1B0QUhjaFpaZWpEdnM1dWNISHpQbXZIWmdNTnpzcU9uaGR6REd3?=
 =?utf-8?B?SHIrL2dtdm1qQUhzQmdNelhBUkZGay8yVll2bkVpclZxNXAvZjdXRE1sYmJ3?=
 =?utf-8?B?Zm1JSU02NzRnMEg1VWxYUzc4TExyNjZrOUNyckV1MXJXRk9Pakk4NTdmWnJh?=
 =?utf-8?B?SVJtejdXbUVrd1c1WW1IUE5HM2JoNjVEYWUrNmZpRDg1KzcrM3pUY2tmWnRX?=
 =?utf-8?B?amdZZmY0Q1BzK0Y1bzBYZFBDMnBZaWdQUUVvdERDZHAwU2ViN2t2OFNvNmZp?=
 =?utf-8?B?NHdJbDlhMjJjSUpFZ2s2OTNWaE5ET3JGS21vTWJRbHZIVFl6RGpkc0QyNkpZ?=
 =?utf-8?B?R2lqeUx1bmRvYjQ1VmhXQVdyUElic1l0R3BnZUdVamJwaFMvVytFWlB1dWpv?=
 =?utf-8?B?RXVsWmpnYnlMYWxMWko1UmJFRjFHS0dPcFJKcU90Q2IzYkNiYU1wenprN0lC?=
 =?utf-8?B?L21DSzlCT2psY0ZaS1pRVVIyaHBzQ2gvdFk5UkUvNld0dTJWczQveFM5bjJK?=
 =?utf-8?B?b09oSjE5clMwK0cvZVUyVDZUemN3SFpUMjNIQW5rM3cwYWlYUU1qTmUwR3FX?=
 =?utf-8?B?N25PZDdkSmVTWnVEN1Y4WDRQekszQjljdEVEeCtWT3pwQVVJWjFRZHJQM252?=
 =?utf-8?B?cVNLT0drWjM4OVl3VE1mQW1DSi85Mno4cUZwYVdIUDY2OVhzRG0rTHBnV1B5?=
 =?utf-8?B?by9TWVU0SnhLOHpTUC9OQVhmeW9DcjBoSmJmS3hlN2NNNGpYRUsrSGFBYXp5?=
 =?utf-8?B?YUI5a3R0RkliOE5PdFE5Q2t3dzJ0Q0k2SnUyRnVvK2pyZEY4Q2I3ZnU4WmVj?=
 =?utf-8?B?UWowWk9pSTRHSmYwdG9NaHdWdU1kVWhKVDhlREZtYnMvT1N4Sk1NVW9qZnl6?=
 =?utf-8?B?WTJQSnJ6Nm9Qc3VCcExPRXkrcEtpQUFHMzYrNkFTa0Jhb1JkQnhjVHlUSWQz?=
 =?utf-8?B?UGREeXRLNnBXYTNWVk9WTVZTemY0Ull2RFZMeTBIWjBidjdiMlNmUUNTb0sy?=
 =?utf-8?B?VWpObmoyYko1SHFHVUFJT1A5dkFmZlowMGxOUEFVaVZ3UkExbTRhVUE0TUVi?=
 =?utf-8?B?dDgzUjlLa1BuYWRDYnZlTVFYalczQjNHclY5Q0xtLzJpd3gvNlgyTVZiRE9o?=
 =?utf-8?B?TnZvTXJtWFcvaHZKN01FMjhQMU5tSEgzTzhaTGVnZldrQmJRMXVEYmM3eVp2?=
 =?utf-8?B?bUs5OEx0YmczT0E4bjdndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtQNndrUS94aGdrazVJY2tvQnhuZmpNMXFnMlkvV3J3Ykwvdyt5S2pyZFNa?=
 =?utf-8?B?cy90YnNiYVpBZm1uOWZZMnFGY1RoWkk1TTRwd1JPOHRHQmt0VXNqcVI0NXVs?=
 =?utf-8?B?a1o0VzZrZUVoM1BLV0I2RC83dkp1NGdvNHYrQkFITXpWZzJtRmFoR01FeHEr?=
 =?utf-8?B?ckhkSlNoL000WEdJUTMxNnpTNGZhRFNoUGVOQ1RTdzBwMVhHdTdxSmMrcmQz?=
 =?utf-8?B?VzFlT3NZT1FRZHdyV0oxeFU2RFpGcDVCamsxellHY2FmUDZMd21RVHNncjU1?=
 =?utf-8?B?clEvOU5kd2xtcXFsNnRkMkQwa0JBLzl6ZEJHaGVVYXRyZm95MHlYL0dvMnZH?=
 =?utf-8?B?VEU2WDQwRU9KU0l0b1kwMHZDeG9SUVVrdFZKWDl1UE5WWDBWMlNtenZhenQy?=
 =?utf-8?B?ZDJHRkdPMXR4aDV5MGJiZVRTeExzTjdSeDg1aUV2NExaWnJ0M1F4b3hPNzg3?=
 =?utf-8?B?eWlqeFZ3M1hMSHpOeGhNQ0cxSHk0VFVVZDRuejVqUUU4UHlheXM1Z1BXenhB?=
 =?utf-8?B?S0doK2ppdVpjU3pmRUg1RjJhVXpmMUpVZ3l1WEV1SDFsNjVSa0srYVkxejlz?=
 =?utf-8?B?UytpN3pDTGZRc1l4Vlhva0xEaTg0RzJBYloyZUpNUGNRRjk3d3lmQ0JPaTJm?=
 =?utf-8?B?ak13Rk5hSlh2SVYrMTFUTEZHb20yRksxWmVwSTI2ZHVxVWwvRFB1NDc3Rzd2?=
 =?utf-8?B?NnVvUmo0WHdPbGp3Z1d4dmtmaGhjZzR2bUdtc3BUZjh1c3FlbTZ2QUc0UW5I?=
 =?utf-8?B?aWJJNmhCTFF5dDVOdDZmME1FRFMvWUEyYTU5MkVBV2VmNlF1STFWaHdrbFh3?=
 =?utf-8?B?K2NWMmNDbzdNcGFPbERucFMyeDNxaklMWVlrbGlLdTZpamJpaS9sTUxCRU9G?=
 =?utf-8?B?ODB1ZWlrS0QyM2tibEpvS3BWdE1YUXBKSXB0dnlJWTloT2VJeEQ3MHNGb09n?=
 =?utf-8?B?YVRUSkRrUmRRL2lhSjlEUlRONGlmdStjNzlZd0xubmFNQU1PSEV1TEUwcDRM?=
 =?utf-8?B?OXlkRE8rSWwrTnJNZHZnQjRNUDg1bm1tVHprT0p1ZFA0ckErZ0l2NUk3YkMz?=
 =?utf-8?B?YkFFZVJIYW1YWmUyWGNlT3AyTERKOEtUNzhkNFV1L2NaRGVRUW1yQkQ4dEVG?=
 =?utf-8?B?TUkyemsxYWNpUXRkdXdYOVR4Z1pPVm5iQVZBaE1INGV2ZGNybTF4RjhxRHNu?=
 =?utf-8?B?MjRjQXlYdkhjNmd1ck5aNUwzRFd0eUkxSDdIbHZKenBMQ3NRV0t6b2pjNnVB?=
 =?utf-8?B?cUhIT3BSaUVOTm1GamZVRDRwZTVtWndncm55S3Y0ZnFqWm1uR29NdkxVaFZ5?=
 =?utf-8?B?SllFTTRtd0xHUnRCalJKZDVNbTh3SkpNYTlWUXR6ZllGR1BDOFdJWkxnc3lX?=
 =?utf-8?B?KzNYUHg2dDYvWkljN2RoY2V6dUt0TVhUME1VUUpBTytVQndsMmFzektqNkQ1?=
 =?utf-8?B?Vlg2TnMwRVBoMHdqY1ZpQTVtbklEWkdVaWV6UXZGZzQ0bS94NktYaUd1QzFl?=
 =?utf-8?B?OVl1MjJkU0hDdWRLUUEzQ2htQWx5VzRMcDZ5QStSMkd2UDR6cERUVTE1UUll?=
 =?utf-8?B?N1djNFhYaXRWWXAvS25JMEEzc1Q3SFdnWmlYOTlMNjNnUmZVZkxhT2pBZnBm?=
 =?utf-8?B?K253eEZ2dUpGWWhGYldEZHBzYW9IaEI5R3ozbzZSNWRsRjdudlg1OXFnWGNJ?=
 =?utf-8?B?bENSNkFLSjY1ZnZTL0dUU0xzai8xR2Q0NGd4VkY3WEhkYS9LTzBkQWcxdEJO?=
 =?utf-8?B?RDh1bGxGYTZRYUNtZEhOZFM3WCtRRzJSNk1ZNVZXaE00RGMxaDU1Um12TVNq?=
 =?utf-8?B?aXpMY0wzSmhPV2M2SHphS2h2dzNoUG53ZXpFKy90ZnlOYUd4Nk5qbTNERk1Z?=
 =?utf-8?B?VUE4cEJ1dHJoZWl3L2dzY3ZldU9Sc3A5R01aM0YvRi9rUWo5cVR6OW9UUG5X?=
 =?utf-8?B?Q0Mvc2xFRVkvTFNTVEJPL244ZnN3THdJenNJdVJncWdjbjk1ZkYxUm5oZTZz?=
 =?utf-8?B?TEh5RzNtcmwzR1hKcTFVa1N0YlR1QVFMS3FyNW5ZODl4TzRDS2hkSElFMFht?=
 =?utf-8?B?MTJjVnNHQWEwOHArcHpxdzJoZnBTaVBwREVSQnpZVnJDTTBia1ZwYkZzNy9Q?=
 =?utf-8?B?MzZoNVQxK213ekF4MUxBL2hhbXpSQ2xPbG45K2xlbG9YVk5rY3lEbjRCektv?=
 =?utf-8?Q?rhyPZit3NFWE2GEHBT4wtHQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f4deb0a6-2dc7-48a3-2ec7-08dcd8034353
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:59:31.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i02+J0dmk2ioiWNEDnuiTWDNcVnUsCOfaJEaSMPXbK+mopGzvCg1hhIO7pAbCoih3jZb+8nO7IVSjwT34izhi87OVUY9RuFcvp1H+hmluZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10209
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

Hi Rasmus,

For this patch and the previous one, should we have test(s) to make sure 
we don't regress?

Cheers,
Quentin

On 9/12/24 3:41 PM, Rasmus Villemoes wrote:
> Having two separate partitions for use in a redundant environment
> setup works just fine, if one only relies on setting CONFIG_ENV_OFFSET
> and CONFIG_ENV_OFFSET_REDUND. However, if CONFIG_PARTITION_TYPE_GUID
> is enabled, the current logic in mmc_env_partition_by_guid() means
> that only the first partition will ever be considered, and prior to
> the previous commit, lead to silent data corruption.
> 
> Extend the logic so that, when we are looking for the location for the
> second copy of the environment, we keep track of whether we have
> already found one matching partition. If a second match is found,
> return that, but also modify *copy so that the logic in the caller
> will use the last ENV_SIZE bytes of that second partition - in my
> case, and I suppose that would be typical, both partitions have been
> created with a size of exactly the desired ENV_SIZE.
> 
> When only a single matching partition exists, the behaviour is
> unchanged: We return that single partition, and *copy is left as-is,
> so the logic in the caller will either use the last (copy==0) or
> second-to-last (copy==1) ENV_SIZE bytes.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   env/mmc.c | 46 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 5d09140655f..e2f8e7ece28 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -69,21 +69,49 @@ static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
>   	}
>   }
>   
> -static int mmc_env_partition_by_guid(struct blk_desc *desc, struct disk_partition *info)
> +/*
> + * Look for one or two partitions with the U-Boot environment GUID.
> + *
> + * If *copy is 0, return the first such partition.
> + *
> + * If *copy is 1 on entry and two partitions are found, return the
> + * second partition and set *copy = 0.
> + *
> + * If *copy is 1 on entry and only one partition is found, return that
> + * partition, leaving *copy unmodified.
> + */
> +static int mmc_env_partition_by_guid(struct blk_desc *desc, struct disk_partition *info,
> +				     int *copy)
>   {
>   	const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
>   	efi_guid_t type_guid;
> -	int i, ret;
> +	int i, ret, found = 0;
> +	struct disk_partition dp;
>   
>   	for (i = 1;; i++) {
> -		ret = part_get_info(desc, i, info);
> +		ret = part_get_info(desc, i, &dp);
>   		if (ret < 0)
> -			return ret;
> -
> -		uuid_str_to_bin(disk_partition_type_guid(info), type_guid.b, UUID_STR_FORMAT_GUID);
> -		if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
> -			return 0;
> +			break;
> +
> +		uuid_str_to_bin(disk_partition_type_guid(&dp), type_guid.b, UUID_STR_FORMAT_GUID);
> +		if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t))) {
> +			memcpy(info, &dp, sizeof(dp));
> +			/* If *copy is 0, we are only looking for the first partition. */
> +			if (*copy == 0)
> +				return 0;
> +			/* This was the second such partition. */
> +			if (found) {
> +				*copy = 0;
> +				return 0;
> +			}
> +			found = 1;
> +		}
>   	}
> +
> +	/* The loop ended after finding at most one matching partition. */
> +	if (found)
> +		ret = 0;
> +	return ret;
>   }
>   
>   
> @@ -103,7 +131,7 @@ static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
>   	if (str) {
>   		ret = mmc_env_partition_by_name(desc, str, &info);
>   	} else if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) && !str) {
> -		ret = mmc_env_partition_by_guid(desc, &info);
> +		ret = mmc_env_partition_by_guid(desc, &info, &copy);
>   	}
>   	if (ret < 0)
>   		return ret;

