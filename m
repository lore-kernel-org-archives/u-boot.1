Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69197C83030
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 10:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B533E88107;
	Thu, 29 Aug 2024 12:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hpPpk5dF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573FA82BA7; Thu, 29 Aug 2024 12:19:21 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A5288481
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 12:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wngYt0exxvhGQ4FqmzkiH14tD2gMeVi5/NdGCLAZUK4W8eBA/IJkvf1RbQySNtcj4Ykc8ScyZwhgIP9/dAVJFQPF+1m3iVe1m0GE0mmIsFyxwP+JR+jRxHPD/bcbkPR23r2ob4NwPqVigMhYg5HEzcXpMWex2VJUwkWpmXoM7iHYmKvEs73B+Rl3ved09SuNi3c8IIG66fsgWe6NJcbPiUCz8IXh37tDkTO2Z+vZe4B8B6xSRjmgtscJQUMKXGmLURK2U/frRtB+tnhXzn12wlHHVoqsHgNt8I9mJpsQlBl0kdLmVKIDiOOocyPWO/9QXOZ86tvELSbriOXpUPFKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmM21IRNXgfoJkulMIih6QJsJ3RFl4m2LkjxEZRZnkc=;
 b=nHJp1EI+dV/aMYA/uzgZvKj3YPudkO8+EBRDEH4+7IseaQS4tDaBFheKETV0NAE2J6mK5mc2a4o0q+iNo0Iy0GsFvE8sVhf2Fjl6VD3O2G2YJEmLQSiWDsJvvIFA2xtAuH+kcVGBvknvv735VAzGA3lsaqnQwFf87XEVnxs0tDJ3i4Pj2yWB0HJG1CQtHnpwY9aKMqoMWEXeTrKo7nqzv8kS1+toYuvs3eGhIJwO37DfljQ+9SEitQyBLrDiBXRgSpANPRxsZzNh3IXG42W45gbPKDVEKJQ9Oeo8cFmc1mMcMArulKrGXDiYS5rmMWRz4fCfXT/ojRAgDKtqTW+1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmM21IRNXgfoJkulMIih6QJsJ3RFl4m2LkjxEZRZnkc=;
 b=hpPpk5dFmYe4sNNgG/V0SNDb9r6G01skUq94P6ZoUfnbKtlcsemssCUGhApO1971gP8Q/6gzNGAvalL8E9jc1qrf34K8lrAH9B6IHKG9a/zs3FaK6MCY19EBCGSbVzDlwkyfqCEXJPGuj/WVFEghMv9SbpkiksPyz3WiZE/fAXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 10:19:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 10:19:16 +0000
Message-ID: <3c9b636d-2184-42dc-9604-cebe2535f11d@cherry.de>
Date: Thu, 29 Aug 2024 12:19:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ram: rockchip: Kconfig: Fix dependency of
 RAM_ROCKCHIP_DEBUG
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
 <20240827142058.594556-3-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240827142058.594556-3-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8ab68d-7264-46cb-f3c7-08dcc8140992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjZzODNhNVBKNE1sY21XTWNJaUYwQUYzK3JDTEQ5Z0dqMUVRZzJwWk5PSWdU?=
 =?utf-8?B?M1dQbU1ZYlpVazM4M0U4V0pMV1h6ODRkZ1l2OXJsNmlTUWxzZEYvbVlPS2p6?=
 =?utf-8?B?WGNnUlhhajIwUjJqMGpNbU14MjhFZEkreFBoOFVZSmtGSWdwOVlUVUhjU21z?=
 =?utf-8?B?RHoyRHRrV0FnaUNTVDlnT3A5ZFpxRXI2cit2em5OZEdhY0ZBVkdDdmlqa2x1?=
 =?utf-8?B?NTFoRDc5UlJGNVNWUnNoVUR6MzB5REtxOXErV25sODQ2TXZXTVRTMmpBRHNU?=
 =?utf-8?B?RkNmWkJuNTRidUtma05rNXl2N2xNVHRockdEL2pTZ3hJa1EvUERtRVpySytm?=
 =?utf-8?B?NDhKanhDT3pIbEZRcktDOWl5RHV3ZVR0TGpBbFNrSGMxRWR0UjdReUZqN0pk?=
 =?utf-8?B?NWYra2RUVUJxeWFIbk1PdEs1eXpRYXdrVnRldXVQVWEvQU9kRTJidmZUSmVU?=
 =?utf-8?B?dnU2R3hEcUwwNlhwZElXMlp5cFFjSEsrcCtyZnRBMWlNaDNUcXNhNHphcHdU?=
 =?utf-8?B?WG1zWlNBcVNMaWRZYzNleEVpMVpUd05CcC84VEFwNTZCN3puQWZQOVY1bzdG?=
 =?utf-8?B?bW5SOC9LQlFKVktpUzM0anU5NURpNEFPT1BDV2Z1M254dlhLeCt2UUs0bWVX?=
 =?utf-8?B?c2EzYmZvNjJqVUJKdlZvOHNxZldnMEVocmxzZ1ZxeGxUbUVCdWJPNVd4cjdU?=
 =?utf-8?B?K2p3Q1ozNExLdFpGWFpZT24yaTZ2MkhsbGkxUXBDbUx5M2dwbjVtUEhVa0Ez?=
 =?utf-8?B?Uk90K2poeVJ0YlE5MC9VRWFZdGdHUUxLOS9KTk9hT0hJS21MOUYyWFZERVZG?=
 =?utf-8?B?QUpuR3RwL1pWY2JWRFBNRjQ4MnNsalpvWm5Fc0xjQVliL25SUkQ4ZWxjcGsz?=
 =?utf-8?B?d2tteXp6b2I0cC9adnN4WFdhMWV1TS9KclVRU1VCQmFvY3pPNWlrUGxzUGls?=
 =?utf-8?B?cjBNbHlFVE9wWFJFcjNNeklkeis3YUpHMlZYS3FCNDVRVEhUdG9iVVBpRXFV?=
 =?utf-8?B?cjR4Yk9DREVQQlRNY1BmWWNYWmJUczg1cW42WmZ5RTNIK0xjL2Y3REJrT0V6?=
 =?utf-8?B?b0RpaVBiM2Y0bWgyekVvd0Ztb0k4TytWbTZ1ZE5QQWxrNTVhbHFFUmkwaVlJ?=
 =?utf-8?B?R2hpZGl5cUhjQWtrNVFQVlk3aEF1U0JpZ1JaZHdlaDFwV0R2NHVFQnBjWXBM?=
 =?utf-8?B?NHlGM3E5dnN1VWx5YzB4MVhNZTcvbXVCR3lpK3lQVm1RUW9PT1hJcjZ1Sm4w?=
 =?utf-8?B?dkduRWQxa2xteGlKZ3RTWmVTNm4vemNLQzE1WWVubEdGRXVaMmsvRnJpYWxx?=
 =?utf-8?B?a3NEcXd4OEpzdWlvT2x1ZVVuV2M2RE0zVURVdDB2a1VGRzdDR29VdEZXejk1?=
 =?utf-8?B?NmJlVEJXVjhxU0U4aWlLelFlTWI2dnhkU3NYSGZ3SDVJNVB0eDZFOW11SHNv?=
 =?utf-8?B?ZnFzbUNCWlF0aWhTNzdRTkFvWEt4MURHTnNsVGtPaEJhM1cxZFAwUW9Ia2JV?=
 =?utf-8?B?SDRGVHBNQ0hUckNxeGtSeFFOSnRrNDdPRTZndjluRmdTMGMwVmhQUGxjMVdU?=
 =?utf-8?B?MXlrbHIxNm5tdWVFS0VEWlRFMUlDckFiOHk0NXpIOW9yUnR2czRBOE5wNmR3?=
 =?utf-8?B?YmoyWWtkcFlWSEdTMVE4S1NZNFNseEttbDBNUEg0bG9NYmxUcTkxQVdaa1RO?=
 =?utf-8?B?VGVJYmtVQXo1T3FRSlhyS0ZvWlRBWmpSZ0pSTWtGS3ZOOWo3eVEyMWNlKy9Q?=
 =?utf-8?B?RW02bnhobzdYQm9HWkY3RnpEbUZBT1M2U3dURERSaG9CVFRmbkRqeEswZGJy?=
 =?utf-8?B?SnFPVGNNUXAwMzBzSnNtQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlENTF5TXZHSG9lMFR0ZE5NSXAyTnhkUDFzQTRlVFcwK25BVHdqRWZRamwv?=
 =?utf-8?B?c3JMVHdNMzgvdEYvZVJ6ajUyMHB2bERqc3lqVlllc0R0dmFUZytxcmJvYlZm?=
 =?utf-8?B?bFRwYlNuUkEzU3p4UWdnczBQbGY4bk42RkVCeGhSRzQ5cFNBNWJwbFVZcFFE?=
 =?utf-8?B?cTJUajg5K0JhaW96Ymd1ZW1qSVdwazBxL0Z0ckJNQkFsaFJWUFRldkdFL1lO?=
 =?utf-8?B?VFBOS2JTNFlTalUxcWdibUdMR3dKSDJNMjZxR0tBOFRoMmViZnNsRjNUUXJV?=
 =?utf-8?B?YnhRNU5BQXpBN2t2MmNYUEhXR2lxM0ZUYTcybDVmMGhWUzBpcmd2VTNic0FG?=
 =?utf-8?B?ZWxaSkZ4SU1hWlhGYWlKTDloVVl6amhQaTVlc3lkeGdMSGs1UFhMSjhjRGxr?=
 =?utf-8?B?UDJ1RkdxZVFJd0g0YUx2SnIvMzc2OFdpWGhrbWxScE5mYjNmMjRjbTJ6VlA5?=
 =?utf-8?B?T1NFNEYrcUEwYnlsbk1iTitRQ2FzR3RIYytPWU1TWVhUdG43QkhYaG1EMUVx?=
 =?utf-8?B?b092cUk1dXdDMUNpcjdHTHZ3d2hvYjdYcURtaVd3TFpWRHNJbE8wSXhrcnVj?=
 =?utf-8?B?eFp3WHRsYVBTOThHT29zM3Qzak5GRm4xa0pYVXpRUGJheGo5Si9lUzd2enhD?=
 =?utf-8?B?OXI0WWZzU1NhYnBIWE8rUDk5V2xWdWJTQzQyZE1BckgvWVZBS25pVHhOSEdC?=
 =?utf-8?B?cXVCUEV0UzZQUzFhVVRZZ082V1VEVDRWK0VyRFlaUXZyREFlamVvSmRXQkF0?=
 =?utf-8?B?NTZ6QXpTdjYzcmgyTzdoUjk0em5WV0JNUWpkMXZoenRNeU1FdmdEbVNqOXdw?=
 =?utf-8?B?dUh6eGorbVNoaW4ydjQvUDEwOE5nakFqK3NHTDc0U3NIK3c4Z0djaUw4Zk1H?=
 =?utf-8?B?VHF1NDdwRllnTW13ZTQxVGYrcVovYWVaNmRPeG91dnVkQmRzU3paWDdzSWJM?=
 =?utf-8?B?cTF2d01CcVh6ZWJVN29kcXhqQk4wMUpNeXhldmp6SWhldFMxRUtVbGdueDdH?=
 =?utf-8?B?ZExFV3B6cENYMDlvVGYveUxCZnBTTkdmdWJ0eW9nMzRteWdzL052dmhEaUNB?=
 =?utf-8?B?M0dSREtTZTZxY2pxRGJZNmVEa1BSRHM2Zmg4MGIzRC82L0xNRWVVQWpUNzky?=
 =?utf-8?B?ODEzeTdKN01HaFBlMGMrK1B0MkhPRDZCNk9ZNlZGZHY0QWdGZ0dTbUQ5YXlC?=
 =?utf-8?B?aGtOTnRCeHpqVDhOTlBZaXJjbkNtbFBYK0hiWXU4VFVkNm9WQWp4N09HdnA0?=
 =?utf-8?B?bXE1TU5oTWtPL0RNOFg5cVlIcldJUEszdFdMY1VpTWhtcWdUSWdkWURIdDJr?=
 =?utf-8?B?VnNEbWJDNlhpRkljOGptRGdsZjNzRThTSzVDc25NYUpEOTcvSUJ0Z3N0MElz?=
 =?utf-8?B?UnlFQ3JTdHNCVEtrMVJjSEM5SXYvRDFFTGM4b2ROdFFiaEh1MEIwb2JzUE5o?=
 =?utf-8?B?YjYrMUJ0N3dFbUpZN09jc3VUS0IwTkx3Y3RrdisyVEJJQ1V2aGsvUnQvWnpM?=
 =?utf-8?B?Ty9BSjN4TlpibXVoNjlVU0R2SmYveDNDdC9SdWRRYURzRE9rTEkvRkNkY3Av?=
 =?utf-8?B?S0h3eHYvalpabmxXcVpJMWM5TE5JbzE2dXdZNG1RMjZJbk1PejhLeXVNeGdY?=
 =?utf-8?B?aUNNWEM1OVB4dmIvcXdRRFE0alZQTTdVMFZ3MENPeW03K2twVEpRVnRHVUtT?=
 =?utf-8?B?cmlLOHNRR3BlUGtXNTlZbXRRaE50M2poUFFmSGl0RFVDTVRFc3NKSXpVVmN4?=
 =?utf-8?B?bWxDZ3JSKzBjZ0JIaWl3QmNVL0Y2OVB5cm9oQ04zM2dVa1dGVmpWTkJsdlBE?=
 =?utf-8?B?K0Z5RENLZlBlTS9aZVdaVUM1cWlSSk15MStpMFpEZDhETUIybTB1WXkxYTFW?=
 =?utf-8?B?a1RkUEljbTdNL0FPK2tRRzIyMzZpWUxnNnp5WDZZUk5KZm5QNitEYXphbUdX?=
 =?utf-8?B?K2FxZXZzV3ZmekxqT3FkMFZlQ3BkdUh1aDFKMmdlNlQ4QXdSZk8xREtpSmEw?=
 =?utf-8?B?NWtwQmxTbE1QRFhMalBFK2xWc29xL25uZjNQdmdmTTFKaVFGZzlUYlI2eFNF?=
 =?utf-8?B?ZmZ4bVoxZnBFOWxyT0Y1SU5DVFc5eWU1VHJxWTBQd0tBMUdjK0N3ditPeTlh?=
 =?utf-8?B?Zk9tQlFhNldVaXRzODkrdTdaUDkzdHlhZDl5S2NPSXpJSGdSN0JEL3lMYTNp?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8ab68d-7264-46cb-f3c7-08dcc8140992
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:19:16.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmqtkdxCu4rkdDA57e2JooZ2Qi7qf2p1L79wY+aah2HmgpJ2+ENe720mxbjFPcTeaXQQquZ2iCTsqIlsvdFL5TlpiJrcRciBPGAKmqrMsDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846
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

On 8/27/24 4:20 PM, Lukasz Czechowski wrote:
> The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
> available, otherwise it won't have any effect.
> Add negative dependency to TPL_SILENT_CONSOLE.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   drivers/ram/rockchip/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index 67c63ecba04..4a6a6328676 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -15,6 +15,8 @@ if RAM_ROCKCHIP
>   
>   config RAM_ROCKCHIP_DEBUG
>   	bool "Rockchip ram drivers debugging"
> +	depends on DEBUG_UART
> +	depends on !TPL_SILENT_CONSOLE

I am wondering if we should also do this for TPL-less systems? i.e. the 
ones for which the dram is configured in SPL.

Something like:

depends on !SPL_SILENT_CONSOLE if SPL_RAM
depends on !TPL_SILENT_CONSOLE if TPL_RAM

maybe?

Cheers,
Quentin
