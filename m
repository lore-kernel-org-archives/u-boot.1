Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF051C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 12:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498948186D;
	Mon, 24 Mar 2025 13:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FYZQjqO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEE08197D; Mon, 24 Mar 2025 13:39:47 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916EE817EC
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 13:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4W2GjNk332ewtBHEymh3nbAX1Eykjs+/DvRHuRsSp/FpYP169LeqEzzgP5kCMR1kFUG/QUxwBW7bhLhCud/kbC3Me1SvywRyh78ksU8hSOTlwo5eVz6STFZl6IA0WExW8p3xG+ISZB4BQo/bFGfFvjAmzFNddub6atUmS+ETQwZ11EzjJYUJHqOvXTSe24v3WEYfC+vPFCnVliaY4QfejDWei9BbyCI0HkfcZlcweObMTWCL0Egfy70a8gwA8/g0GlybImI8sOpUhx7t1SAHuxQd20W/DlQXd3C81EBU+ogURXt5jpVqgJFmZdkdNamlhx4lNlQYR/4mB+PaI6S6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWxuJTkiI1goDETAKz7tjeAM5TyGk8Dpl76kv8CnsWc=;
 b=L+QqYksmpbRFab4LRkiHzauucdmfPdVbRaHti2k9fE8Np6hD7uckxD9WhjNinNo++L0QIqhnJIzLSMGsgox+npsRkUlqfjiWeZyKEimFkFI4FE64pyCln9x2IU/9B70yKbuqrmsezlFCOTcV8KJjU8PmnIUtITNdaWNA7i+2aAZImGzN5htfSdLlZyHs8idn2ihFnriKADbjqlB+j4bWGdXZf1EICoif0rUsbK91N5udk3U9L4+5K1HbirIy0oDAAKeUdJ94ujyPVbXBNmsr+bwum2FtfPLIIh5NIcqRFY7NWHhPNzTv1Ir4u0V9zSr8At2cPaU9GlgCyiriH3wyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWxuJTkiI1goDETAKz7tjeAM5TyGk8Dpl76kv8CnsWc=;
 b=FYZQjqO3EDonblz+SXmbX7uU9Rnii9gPSPghRZYdF93FcxvTb1JsfJhuoIYvOCM39XDSP+Ky4Y1W0eqlKRpVzQAQgoaKVSaNoeB73yzz4fMRXa0disM0lLSNPCkgqL5DAJqsSbI1wT0adnG3cC4WuOkyoJvn9bD7otRPlojinTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:39:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 12:39:41 +0000
Message-ID: <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
Date: Mon, 24 Mar 2025 13:39:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8f8ace-cf8b-4de8-bccd-08dd6ad0f267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajhOMkxDNzV5UklMK0pQOUZJNm1vSEVOdTR2TFVIK3ozSEZFMk4xSk5JYjdt?=
 =?utf-8?B?UWQvbXdlV0JCZXhicGZ3TDB6R05BZTJwQnpyTnZ2Ym1GM0d0U3NIWkR6VmFM?=
 =?utf-8?B?WHhTOHhrNUt3YTJFb1Y5RWJwaWwrUEF3QjViOFpjdGlNQmxVVHdQT1FaaUow?=
 =?utf-8?B?RnFGdWMrZVZNL0tud0Z2NWsyWDVZWUpXSUtIZU9hd3oyNWxYQktJWnY2VG1O?=
 =?utf-8?B?bGRtQU9WTU5uNHBnMFJ4c1FudFVlblIycnVRZ05GdWFaTVM0YWpRRkRnVGc2?=
 =?utf-8?B?c2NsS3Fxbi9EZytQMEtjSjhYZitGcFhwTTZWWGIvall1UnJBY05rbGtuYUN3?=
 =?utf-8?B?VnBJNnBDMVNQU2I5dUNXd0VaMEc1M25RK1JkdGJwNU9hQ0ZLMjVucjdVRHU5?=
 =?utf-8?B?TDlsakkycTRMZVAzdktCdEZ3dVA3MkNaMUpraHFZNU8rU1U3aWRnaHUrWUJq?=
 =?utf-8?B?T2ZLbENWMWJDWlZrQ25ia1NoamRMOS9wdFNkNXc2ZmdpMkZqc2VUTlY0aDJM?=
 =?utf-8?B?bC80elFRNms5ajZPZWlGZkFLOE1BeHc3K0Y5Slc0UTlSc0dOQUhkRDJ4QW51?=
 =?utf-8?B?VTNzdGxjblBQVXhjcTJEb3NYaExEMzJTcVM1cEdjQTdNK1hhUnlwVmhOWGxP?=
 =?utf-8?B?VFFzditUOHorYWFkd2E2ekVwRFdVZGdsTDdYbnA4NHAva3VYeHhHaTNhaVMw?=
 =?utf-8?B?dVhCNGRDV0FJYmZIZmhSV2dsVklJeXhpRlorTjBkRVp0QkpJQ210TVhPVDlh?=
 =?utf-8?B?MXJmR3JaTkVPNnNCWU5iNmZicC9qU0k5bm9XZDBBSGRpYXZWaHNMK2JnZlRv?=
 =?utf-8?B?aDZKei9pVlZ1dkw3U3N0MWx0ODVHc1FkMjV3NG0zVldYeEVtbzV2bitVWG10?=
 =?utf-8?B?Rk9LOEplUjVLeXJQRUg1VUxzRGpHWTlwZGdUUU00b1dSd3NIMXZDSDBnckR4?=
 =?utf-8?B?U2tCWlZkUlA5eUFPL0ZKOEEvSzN1RThuTnZnWEhvK2xlMWNGMHFPLzhIdmxN?=
 =?utf-8?B?OWpxMjY4d3JyT0xvTktBaCtiNUt5U1VvUHQzYWdEUnJrMkhqRGpCeVlWazJX?=
 =?utf-8?B?b2JEcG00aHVzcnE2RnROb1VBT3J3eWdwSndEdFk2M1o5RGpNQVhHTlBGSnVQ?=
 =?utf-8?B?OXloQVBWSWxnVTBDRnIzTW44VkFmV29GNWN2aWZCS2tuaGpJSmlnLzQ2RXRw?=
 =?utf-8?B?TVpGcG5hUm90RXMrOVpyR0t4N1NJMTI5NHZNS3JSQWdwS210V0t3YW90ZnpK?=
 =?utf-8?B?YXArVnVhTE1BMjJHQko1ZEpTL3YxTkFFNlFsMEVGOWpnNHlKS1UvdUU2SW5O?=
 =?utf-8?B?ZzNmRHFUakZzOFVFOXBGTTdieTVRTzBrVG1LejcxV3l3TFZUVWd0OVIvaVV6?=
 =?utf-8?B?K2F5Wm5zbmd1MU5ZQkM4MXdZckM0N0dOUnNuYzd1NEp3Nm9iRVhqVEoyYzM4?=
 =?utf-8?B?MzJCYzNIS3ZsVFJhS0xQVVJlditpOEVTVDNxYmt3b3A0aU41STgxQWNQK0ZP?=
 =?utf-8?B?TWZIYU1MbUcrenppTkJIWlRKWUQ1NlFoazkvOFNKRzhzMCtxZHRFRUJYclRy?=
 =?utf-8?B?K2Zjc0V4RkE3UGwyUDFuQmxWVDVpaHpES2NOQVlscVpicTZ0UHF0bkZBYlJE?=
 =?utf-8?B?UGtNRTFmbEljWlpPWmJWcVBZdjJPTmpDN1FFc1FtZ0dzcTRCdTJrWnh0WU0x?=
 =?utf-8?B?TmtoUVJvREd0T0p6cjRvMm5hWHFUeVFiMGp5bjU2MndjeW1RYytsOE9aNnh3?=
 =?utf-8?B?UTBjeVFTZzhCK3FweU5idlh3WDB5R0N6c1d2Y3Q5dm05UjRjMkduOTRuUk9Z?=
 =?utf-8?B?b1JFc2RTeFpSVHg3REVjclEvUDNLWXRDSUoveXcrSk00b2VDdkNSSmNZOTFZ?=
 =?utf-8?Q?sfO5qV8ASSZio?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5weUg3K0ZLTFpDb0JJOHo5M1JBNWhucCtuSFN2YjQyeXo4SHpGaUp3R2cy?=
 =?utf-8?B?SHRPTGRmeEJVNFpyZnpYZDgycU1uU1pUZ0Q5WEhkVDN3ZVBLUCtLb0Q4T1o4?=
 =?utf-8?B?NTUySDk4TzNCV0ZCbkVjWTlhQ3BvbEVjY0lHaG43UVhqa2RrbDFrZytmN0RG?=
 =?utf-8?B?MUNGRTUvZzlxTmRMRVRtdUpRS296QUc0Y1RzOVliMXc3dzF6RHQ3VXVwbTVm?=
 =?utf-8?B?VUExYlZTdEV5dm50d05Xb1lXVFhtajlyV04zazNNMlVRTy9tZWxwSHpsbFJQ?=
 =?utf-8?B?YUdqSUtYOERyWEFCYlVPVitLT0ErRTFZTHplQ0M4aTVHblFyOWhoUVVRUDZz?=
 =?utf-8?B?Q0hEVW5LM0lWOU1NTlI3Z1pFZllyMkd0RUsxajhzY3lMTGc4cGN2WXRYQ2hn?=
 =?utf-8?B?R2VFdFNBVHlRbGlBempwTVRDNXB0TmxPR0lJdUJRS3Ztc0FBcXBna3YyYU1D?=
 =?utf-8?B?WWFuNTZUcndaWGtJcG0zaU4xeFJFemNtakZTQStWSFFoeE1kYVpQc0wzODVj?=
 =?utf-8?B?a2VvSFRLVnZwNERxbHdpQ01HcFFmTEI1ejF4SVM4RGx0UC9KSzJGampwTUlh?=
 =?utf-8?B?SnVJTmZzalk4VXNxaVUwak02MFlZS0ZxWVNSU2pkWDFZQ0hzOWVCd1RmMDdl?=
 =?utf-8?B?d2pUMnN4eURhRzNpb3o3T3VwT1poSlE5OUJqSllPaXRiYWhhRDUyVHJ3TGdE?=
 =?utf-8?B?d3BsbmZtMjFWSm5VcCtzVXRDVFBLSHJCTU9HSGdXRXE5VitDZlRLZHdUM0N0?=
 =?utf-8?B?dy9PVTJQN0ZTSnc4OWpBbVU5ZGUzWlc4eE1TcUZaSis1cmJZaUEvN1JEQXVV?=
 =?utf-8?B?c3lxMFRqZVRMT3E5WmdmNXlwKzZ3N1Uwd2pSalptcFVFZHlrMmtiZFZOQUVx?=
 =?utf-8?B?dnNJYThEQ296bnlIZlpaSElDWkxuZXIrTGhsb2FMdGZZTnNocXY1NVdyYVlu?=
 =?utf-8?B?bFloSk4yNzRHSllLbW40MW4zdFMzSFc4T2lQYlFxdkFCcmluMTA0Sm0wYTZt?=
 =?utf-8?B?RzVuYS9NWlZ3elVpTnlwT0EvdlZWK2NPckNoU21rcVVaVnpQQlVQQko3di9E?=
 =?utf-8?B?MGtreXNreGlYOU95QVE0VTFJS2lRV0hrN0piVFEyWkF0aU52dTgyNUdZNTVm?=
 =?utf-8?B?SDAraktlZzBLSk5kZ0hrc3VSSmZ5K0pXOHZYaFFIc3dFVUxkaGpwWGpwb2xG?=
 =?utf-8?B?UGF3VnVSQk84cHpFUUV6a2VrSVloWERBblBrMTVNNGtFdFhKL1hJVmFML1h1?=
 =?utf-8?B?M1lZWUVHYmYzSitkcnJ6dlQ2Z3NZcml2YVVnd1hlUE1pRHBKdHZsczljWTBF?=
 =?utf-8?B?czZjam5rNTBkWXkwU0ZkOTQxNnUwRG5tZURsY1gySWxIOWJ1RHg4TEV1MU5Z?=
 =?utf-8?B?OW9ZSXMxdTJ6TGFHem83bzFwSHA4dWxYbGhRa0dVUzh0V3ZwK0lCSmF1ekVx?=
 =?utf-8?B?bUJ3d21PZjlNRWtQNUVjMzNsOW92ZkkrNWxRK2xvdkh1a215ZHpIM3psaVZi?=
 =?utf-8?B?dFFiTzJnMFlVRk0vOVZrejY1Vmg3RDBiS3JVaDlUcDhJNVQxSDdiTkFqcnNZ?=
 =?utf-8?B?WEhXZmh1ZVdncEYrTmZ6dWdvN3UzdnJTcndtVUw2LzJYMVFWRmphTGJ5ckZN?=
 =?utf-8?B?NHF1Q3d6WDI0Z1ZwNEh4bnEyOW9mYzEzMng0dUtqVTRJQnRob2tBTTVtUjlo?=
 =?utf-8?B?N0lPMU9tQU1jeUZLY2twa1dOSGw3WW9FOXEvV1BlT1V4VDBkSHRnR1hyZkZ2?=
 =?utf-8?B?TzhUUFpXVzdtMmpmQndDeHdWY3FCRTJXV2k1dy9FOUN0N0lOcFd1M3B5WUpo?=
 =?utf-8?B?cjRUNlZpUUhvdFdlb09kOTRBVG9GTzhuQnJuOUowbk9qa25DWjFsRGNaUkMx?=
 =?utf-8?B?QnNDZ2Q0NXUrSnRyQ1ZHMW1aWi9CWngvM21CbnM3cW05Q2JzaDFzdXhDQk1y?=
 =?utf-8?B?WHdJamFxeHFCQmI4RXhPdUErZ2syekJxQXJBdUJtYjMwMUtySWJ3WjIyWDh1?=
 =?utf-8?B?RlU5WFd5NnptM21lZGlZU2xaakNhZ0daaVNHbnYxWEc0RUxFUnJpbG5YbG9n?=
 =?utf-8?B?RktXNFRPVnR3SUIwODJwelRZeHRCeWE1ZGJhUm9aY0IybkR3Z1huOGxmU1lK?=
 =?utf-8?B?ZDlPbEF1M3FqQzRkdWt1UnUrN2JhdkJ1UnpKbXo3THlMVGtySzBOQ3hKUG1B?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8f8ace-cf8b-4de8-bccd-08dd6ad0f267
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:39:41.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQIECyUV8kBAspddBqbTfCr6PSKE0oO3T+PYLMHjKNGkMY3jSMoDBgndf/qPRK785tJk/zcJqkdlOepXgQRyf7xbp/h9j/108tMf7gwMLY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827
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

Hi Marek,

On 3/22/25 10:55 PM, Marek Vasut wrote:
> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
> 
> Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
> index, a number, as enumerated by U-Boot. Update the help text
> accordingly.
> 

I disagree with this part of the rename (MMC->SDMMC), our drivers all 
are using mmc (env/mmc.*, drivers/mmc/*, cmd/mmc.c, ...) for both SD and 
MMC. We also have ENV_IS_IN_MMC which is for both. I don't think it's 
worth the confusion.

SYS_ prefix to ENV_ is fine though!

DEVICE_INDEX could be DEV_IDX too if we want to shorten the symbol name.

Cheers,
Quentin
