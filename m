Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D37AFD8FCA
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D46783EEF;
	Thu, 26 Feb 2026 16:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="U6QYKH/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB12883EF5; Thu, 26 Feb 2026 16:30:06 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571D083EC9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 16:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu96x0V1gs9BnjYjVEf0ObPjucph9MmW1gH8HrkEdaedRDu1BqiI4G3nDaExlpWr35Sb3RdCLTTl7w5U5xcqq2C4G/JVMH70m5cEjigvyBI71HztkSHM3Lcs4VGWiGxRZYgwUV146rJ9tazNupKU7IX9Z1Ju/mw0shkHO2ei9x6aKaKJboz/+RM/lDfDruJ9YcepcUbgcKAfhsUnDPBAOU8qRaVFSixP/6OGx2cDgp87cNs/ujr1E4uZi8SNptHNkx+D35ZFPzZ3wA/hfSGUIUm2cfhNrQRx9lGltOjfxIkfdRfR9/dwstR2vZcHvQ6JTsv91k9/TJzbBOo4Iuw3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOQTyN1o1ZA60DJKcJ7F4LhUYeAAYggEig9B8PA0yKw=;
 b=POk5m+OsFWSuBM2ihigVyMwx/ISJyNm/96tFR19UAHs+jIYLwJ6jWp72xQJaTJmkOY2fIHIKgK90rbkcZ6WemKb0cvejVWkAg6+CscXrVn5axeVeZFxcPdAPqoPUEs4SaK8HpzyknuhIpUU2E0SLFHGZSKWCqdCaQO2iYsVgYYsle4qApWgisd+Lao3ZCXwWC3KjVX3l47Azri5pmQuewXhZnLW8eSAg1AnuUS/pKMqOR41F0nfWoAI93dC/qXapSsDQUcfMFrslW9b9cmBSK4RnMWavzBUVCI33m3zCaycLBHIC/f17XhYx2EnP18ywOdb1DgbQ5C5irwN5CTWjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOQTyN1o1ZA60DJKcJ7F4LhUYeAAYggEig9B8PA0yKw=;
 b=U6QYKH/0Wjr2Dhxjgitqbtw36CIxh/0KtJd8fPwPtms65sRWOa1/3GI3X26PPO2oxUMSsevnBWoaYQ2MAgcmzN4Waq13MYZrEe8bZqr4QtIeMMiGb0JZa1P6Cj30fbN7d1IcASV3OqbCMwMzJzuFXSPnli6UZWOa5SK//doNP/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 15:30:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 15:30:00 +0000
Message-ID: <499c00f2-5722-46db-8f42-a8a526f89ea3@cherry.de>
Date: Thu, 26 Feb 2026 16:29:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] openpiton: imply CONFIG_SPL_CPU
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tianrui Wei <tianrui-wei@outlook.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260225121302.56052-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225121302.56052-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: ed307414-8f0b-4667-e178-08de754be7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: JzT1mKdB6LFuEPyH05fv4VgpfSXEdmuLKz9b9gqt0RgDHObdMfhI6qLMNyGl58B4ghsFYOmgaIHdN0ORJJQ5hR/HnFLq75Owl6COU+1MhD4jV43b7lk4BE37MteuLlFryBeXDrQDsQMjRYl6RQPZSY3Hi7HcIcgNjizZIOyX3RdcR7iz6+jqKW/XJJ/Ak0N3hw0XsJgH+YRoWUldSoEirWchzkwIBa8HsgejplNPY4y5/7+ZpF/H/zwGFh85nAvSMbBlP/ResG9cHFw/5vGKf/K1YRTPVaU8h1dE/eEes08uXRAxX1wKtmk/ytRgRlMX2ycXRHXPDcQt0rYQLozkxmLXT/cAr4VYgXqTDNH4NUufdo+C4q1vVqvUo0NGBj+VAKfBDk/jejj2NcdCJXi0UQ5JLrXNDbFxtn1npz6Eh//vsjS8RxL8m9yiw1DhrXR4e+8xwmVeM0xaop/hrWHme7yjHFBQ7j7l0uEC3191GP5t48Zun0e345Rgn7ziVhRCZMKwe9rV9GgI7nZtdFlWOFHvIrAvuOwwaOOYsIYazfKcTYlaoaBaRY+EGXAEMyBBnMX2SvYvNhFaDGvHAQCreEEs+sgmBKo9nRtKff3fOMWuPm6W3NHGgqgFf6FxYg+ef4SH3p/tbRXU6Vjafn0aJCctQMZ+NnRBxJmZzP9xjOweWnWrqlLcvVtuIX1FUlW93Dj11zLLO7BFZPedsUu3Fd1R3A2gWeLI/uKOqJqH1sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdITnJVMUlmU1h4ckgrWHcwZEZOZUJBTXpTQjJpZzVRQTh4QmE0WXVRcGkw?=
 =?utf-8?B?c0hsVVpCS1VWbmhyZWZmVUNvTTEwZUowY1pROE9KRWtpb1VuZldXVG1zMjYy?=
 =?utf-8?B?cDBhblp5cmVkQVBzYWN1aktoTTRuQ3haaW02Z1RFY3VzU1dWL3c5Sm1Yc3ZP?=
 =?utf-8?B?UFp1a0dUY0NadnhjMmtwcXpJZ2IxV1NsUkp2TEFQUzlnQ1JJdGc5K2xMK1Bs?=
 =?utf-8?B?eGw2TW9oNTAvTE5BejlGM2RWZDEvNDFFWkVEeHMrM1IvazZXaGdJMWdZOFJK?=
 =?utf-8?B?MkxURWJiSGVUTFNFWkJmUHVUcHd0d04zWUkxL2VUUXE0endlRktLR2xQbWE1?=
 =?utf-8?B?SEdxclIva1ZPSHhrZjlGQXNUM2xiSEVzMUVlUDIzcFl5ZEh1MHVNaTAvZVpu?=
 =?utf-8?B?UlYyb1NNUGYzd0U4cWdqR1U4b3ZjQ0tETG5DL1VodjlWRUVBckVwUCsrWmsz?=
 =?utf-8?B?Q3lkdU53VnF1dTlrYStxQzlmNk9xY2o3SlpFRTBkd3RUYXdCamE2ZW5kQll0?=
 =?utf-8?B?d3Y5YnUvRmNxdm4wMHhzNVNldm1namsxdmIzOHEvZ2NldnRlTW9vU2xYS05H?=
 =?utf-8?B?dGpJaU1jVVdvdSt0VEI5OWxqWmFmMWNRcVBjOC9BZFNIQ2JRa1lDa09mM0p1?=
 =?utf-8?B?azdOVjQzZVArQkRuUzBySW00bFBUS1JlMHVMM0pDY0FhNzErenJEOGVhV2dN?=
 =?utf-8?B?elMzTzZteVc1R0lOYmFvajdNZkwyWnprN2s4UDh2QTZnMnJidFBuaG1qeVJP?=
 =?utf-8?B?ZURSdEJxV1pPODU5ZDR0MExidnFHY05CUVZiU1lDZlhKL2NScEFSZjZUTGJI?=
 =?utf-8?B?Z2lGR1dMd2J5NEdtUXlVR0U1TE0xQ24zWVp3T1dMbjNzQlQ4MjJHY1R4WFJx?=
 =?utf-8?B?TVFCanRydFFlNGpkY3lXbno3TmtURjFzeDVqYWE0bENyZG9BMW5jYzVqL1Fn?=
 =?utf-8?B?THBISy9EV3U5YnRjWHRBZU1MNWpVNlVjejZJMU41Z0tlbC9EUk9Ia3Boc3A2?=
 =?utf-8?B?c0dqeFhGcG9JYXF3MnI0aW9RZVNseExXSTQ2M0JZcTZTd3R6VlBvL1ovSkNY?=
 =?utf-8?B?d3kvTlZSbU9qcURZR3AzZnY5dlZqTHFmNW5tQTNaUGUySDQvTjhTWnJHb0dF?=
 =?utf-8?B?UGZyWUpkdEF3OVBKejNLZWJKSU85aHBwV00xRENPeFRJcHY4UnU5YUI3MGxW?=
 =?utf-8?B?Tzl4ZXJUTEZVbWNOM1ZGekx6N0V6aGVoa1RtSGJPMDdQSHBnMVNpV2MzS215?=
 =?utf-8?B?cjF0SGwzMTcraTRZbXRBWG0vQ1Jkbmd1U3pycFJ2OUlqOE5pNU8zZ1FBbE51?=
 =?utf-8?B?L2QxckZRQjlqQ0trTlNaZGZ2SWFIaU1BOXdLT0F0cndKKzJPdG5FZjlOaWtu?=
 =?utf-8?B?ZnNDcnpma1hXSW5ZRXBaWHJoYWNPakVnZ3JicVZ5VmVXb3JlQXBzZjNEd0kz?=
 =?utf-8?B?blhDbmdXT2hUVGFoUzhKYk1IZi9QOGRYaVJCRmlENHNkQ0MwZkp6d2Iva05X?=
 =?utf-8?B?YnRCUC92b2FaYkhwdlZObTcrN005LzhObk4yanRFOGtYcWphSFczSVYrbzdK?=
 =?utf-8?B?clB0SXc4K0wzbGVMdm5WT09lMllvc3RpcmRTSTgyRVZKOThhZVk2bUc2Wlhz?=
 =?utf-8?B?NmNiYXpGajNqRHBBc0ZWTmptME9UZDRWNTgrRHM4NFZ0QmpGQzRBSXRETTR1?=
 =?utf-8?B?YlJKcTAvWXlVZ1JrTkQyNy91cTljeEduS1FFTTBidXRZQnZyZWlpUjlJOWZQ?=
 =?utf-8?B?TkJ6Y2hpbm5oTEZvRUlGeDlPMmRxaE9iUXk2ME5BM2lPM200MnhaV013Q1pQ?=
 =?utf-8?B?WFpVY2ZRWm9GNmx0VGg5V3ZsdmUrZ2kzcWFpa2Q2N3o4T25XOGRUaTZLUG5C?=
 =?utf-8?B?RGhIN3IzVE54ZHpteDNnK2U3Q3Bwb28xd2taRHFMd3NtT0pKUndKdGZSY1hu?=
 =?utf-8?B?ME5wTlZNalpsUVNPOEkvd3FLay9zRjVidW81NXpqbTRuS2lZcGc5MU1VT016?=
 =?utf-8?B?TTdPaHM5L2kvZmtLVC95NFFLcDVSbEUwald4UWlibDZNTlhYV2QxN3RnNEhS?=
 =?utf-8?B?VHZud1I5UWlXSlBjN0NvMmdJUXZ2OHhHQWZxRWhJc0d2S1l5SGp0L3FualJ4?=
 =?utf-8?B?THc0dVFBMVJuS2w4T2MzUXZrNkhhYnB2WlFUKzF6eitwZDl4ZHo2aElCcGVn?=
 =?utf-8?B?WDZCcEVTdEYzVit5Sks2QkZGcjRFcjZZd0RXY1hDTlhwQ2I2S2M0VWRCd2VJ?=
 =?utf-8?B?WXViaUxoRVFwWTREZ2IxdHJhelRwS3JzcW1ZckxzYkFKRmZvMWp1THZnYzJL?=
 =?utf-8?B?ZGp4QVIrYmpLTm1VVFlYM1MyUkl5dFBMMUI5UlJKVnVNci9va0x3Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed307414-8f0b-4667-e178-08de754be7b5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:30:00.5569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzObd7MBHuOPhE6oi23EFy0FpvNK0fcYPdBdoT9dBR/oeCn9Py7P0cWyTz+EyiZXM7SIH8aogCCA46GNLUf7SBbiq69HZONzNkk/GUuWWic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9183
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

Hi Heinrich,

On 2/25/26 1:13 PM, Heinrich Schuchardt wrote:
> There is no symbol CONFIG_SPL_CPU_SUPPORT.

There used to be, before 529d5f96cf7b ("cpu: Rename SPL_CPU_SUPPORT to 
SPL_CPU").

> The intended symbol is called CONFIG_SPL_CPU.
> 
Since the aforementioned commit, yes.

Thus:

Fixes: 8a44fe694394 ("board: riscv: add openpiton-riscv64 SoC support")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
