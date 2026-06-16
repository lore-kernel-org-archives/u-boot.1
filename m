Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16205CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 20:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCA3848D8;
	Tue, 16 Jun 2026 22:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="X0HnwNjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1087848DF; Tue, 16 Jun 2026 22:27:59 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E7B848BF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 22:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs6JfxXRKvLyXCYf1JO0ZQQha7LiYvy7EpSmrLMYlgwz/ds0JobChBFsIHzxRi1c+yFpF77HmXU7I44pbf1fxgXxi2LFLNPDd2e6S4KTNa2t8hVuZ79VSff7dmviVIeUEqNSMr6tqRx1YTq5kU6WAUgr82gon80wZvoqJk7Xjtobof/SufuNvR395gdrpGmPB7VeQoIlHqbF8OMlEFsamXEcFMULJB9COs6xprvYQmKp6ZEJL+NOl9hsCVvWfeKW990G4Yvycgq/cf54j9YyU/gBF8jtIKWF/wqqqvQYPG6zGz0mjlIo6vpVx0kthJwYOtHa7YY9TRk/yoKrEkJlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeZNi1P0eFaBUdMFzDQRfvbYwU6nnxqukklGCKsyptE=;
 b=ReFmbW1nilI0ZsY0Xw1ebag6IQgV7dEWZqbo0tt19RNFloDcIGK/fX+wvTU0pfaCFNzJXfr0ZCjF7KH7Ki27gzAZpQHWhwkOi1tVX3pKRAvSZl2gIHeSzk59SkMMkJ5B22N6U8lOZLAomP0Mrs3zioOY34pgBpaSis+KYVqtCtCST1mcqW8vxqOidi8CjuvYH5wt7iqzQkzZDij3g5AARPw9/LLUBooIubatg9kuz2BV9WDoXuP65/pZIA5Ve+yC3uv4GkH4hxAzDjr6kZotZKur5ve5k6xjO65fg+rMzFxI1kDkjvw0WD3a5sYoesoa0G/17BhhGJNtUnCy7CASzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeZNi1P0eFaBUdMFzDQRfvbYwU6nnxqukklGCKsyptE=;
 b=X0HnwNjts1au1yQrh6kn5xO5gim4Gx+ThhqI/C+7/ha0zA8qlxUjuxqdQr0fIBFYcLo6/BwJmiOlaqrFZiVMfzwZsN3WbOp/05dC1Q/zTOzKb1viC55ttGK5HGmWSMRTnVT7WL1F2XB8M0weg2W5Y7mLImu6hII1IlnP29O4NzUSzz4yAv9mNfD5R2pghIXeWDPNT3kS/a8/c9lfpoQkBB2GIwdPgm66M1Oj+ccNAuJKR5Z9atCWqMlHzpV0Gpid9OiYrexzrMKBHrHVaR9VCwaPJI0a6HwmJhgB6qO4u+SOGZKw8wtFTMLvJYndzhWfByC6tS0DJsrB8JlfVWWDWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PAXP195MB1198.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:27:55 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.21.0139.009; Tue, 16 Jun 2026
 20:27:55 +0000
Message-ID: <e88d88b5-1671-4d47-b2f8-70993dcd943a@phytec.de>
Date: Tue, 16 Jun 2026 22:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
To: Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
 <20260605193829.395161-2-vishalm@ti.com>
 <b5ff80b6-d40e-42b0-a8a5-99f72e61aaa6@phytec.de>
 <20260616122417.olghe5g5hksmxoud@bryanbrattlof.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260616122417.olghe5g5hksmxoud@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::6) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PAXP195MB1198:EE_
X-MS-Office365-Filtering-Correlation-Id: 47380fed-c3c3-4091-8cd1-08decbe5bf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: cOMLrrcWv82Z2DUmBYN1VLxz/meIY75cmGS/612apOvwbDTDR9Fl2jJt0jjK7WGFOzc72CNfjnHYo8KKL31KaN4Z9pNzlQc3SHItEGbcGxw9M2qs3q/oemJ4+wb5XZk74Izfgdplh+/9VNhfX5xMauGG16o6xQO2lWA7jocd+BmB7aHkU5q4Dfzot2ktPvrGuR2CSpg2jHg83M8xJw1qEJW0QlfTFG2g3Lu2KWSa6elb2Zq/+fhPLkmMnn3g1RVQjfkaIYtvWyoG0CbR4L91IQNN0CYcEmaiuvh/6IiPL+hJHNXzQa8H8pxaQfiLbmKXCi6+0QZarCVRMFqCHj7jyyzKCPJ7wTMIlT6ydhR76WViwmZIRMTKMffUVK+9sdUsHgxBz7wQp28xPgGpsQoXuMKsDrINHfJ5aLuzn8RRNMO1XmVFIkZzs70XZQkQHWcfizoGr0djdDS0Ut9ZAQ60OGrcPioklrQFHZLy/J4egvha5BwYGEqYbLZ3XZZA0WLVOsUdgkq/QvoaVioFS1oHZ3ctBudyIvPO3wyKVyU7A7XN+U9mjX3guCfhALz1jpnxbNcGxel3jwDk5umZ7O3cl2/OfbzpWIJ96xsbU5EcN2pn9Ar9X/Z6UT/lUvtfpB4F01Hh8CuJ/Hc0moPiyr8cW6EmO86h5NBManiPePqllhdK273BbgI1lYMQP527n8CR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0owVlBIL3czblRVejROSytsNldSTTMwWUE5OFRpU2duVjh2a1ZyRUVaa3hs?=
 =?utf-8?B?SjBZbUFsZzl3RXBpWDdpeFBMYVQvaCt2UzRKRkN1MUhqSmlPOVloKzJmV1Fy?=
 =?utf-8?B?eTRYWGt6TGUrMGpWNDF5cGZocDVCcVdjOUpmdE1SUEx1MGxCQ3lybmlwT1M5?=
 =?utf-8?B?QVJmcmE2RWp6d3NST2hJalF4QXhmMU1taE1MRno3ZTUwQmNGZnRZNzNZQXJN?=
 =?utf-8?B?UzdFWUF5bHRnZDAzNFFQcVpoOFkvYlhtQzFQdlNQWUdhZ2p3bE9iS0pkaWhv?=
 =?utf-8?B?QlZ0YTJJSmE3UHUyMWdGTzNYQ3FzdFBhQWxYRVppRVRiVmFTYnMwZi8rc2gr?=
 =?utf-8?B?SFowYi9PKzIyd0R3MWhob1JWMGJBN2lmUFV4Y0t4M2NoVTA0cGN3YVNaQklQ?=
 =?utf-8?B?OXZkR2QzVS8xc3Vkd2ZRajdmVE5ET2dTYzRtL3dtNHFrQjRCQk0relhYamJU?=
 =?utf-8?B?U1daOGluanMwWVUwR09MK2VvKzNZQnZqT2duN295OXZwRjFza3ZVZzlsbytx?=
 =?utf-8?B?RVE0UXpmK0V1ZGdnUDFlcVNQVWNGV1VvSEsrLzdzUktvV3lNMGtJSFdZR1d5?=
 =?utf-8?B?ZmhEWUR2dEJ0NjM3RTNFYUtmaVBBY2lCdVZZYmpndDlCR3hKek9SbDdUMEpL?=
 =?utf-8?B?WmwzZXhuMDZEM1FGc0dzQzdGS2Z6ZEhqaVZ3K3paMVZIckRjNThyVzc0ZEZ6?=
 =?utf-8?B?UC84dkVPb20wUk5iNkFTaUlmazMrWG15T05COU5NNXhTamFrVGE5Slp0eEpK?=
 =?utf-8?B?WGd3My83dWlrQWR2RGs1ZlYrb3RCKzBUcFA5aDNvaUNUY2wwc29Sbk4zWjNS?=
 =?utf-8?B?bWJtNTVnc1FMeVZicklIUmVvT0FPYWVFMVNGM2o5UE14YmNBRXI3bU5ZaWEz?=
 =?utf-8?B?ZW1GbG1iWjdtdW1wZFErOVFmaDc2Y3pRVzFhcVU0Z1N0REF5SmJMTmVUS0NI?=
 =?utf-8?B?ZzlnbEE5ODBxV1JTOGdlUHNRTjA2NVh1TmtFb3NFdWxzaG9pbHVCQWlVNzRl?=
 =?utf-8?B?aXM5aUM0cGZWN0V3b3ZXTllza0kwTjRwcjZUWm0zWnQvTlNhVGJSSnd3YlZw?=
 =?utf-8?B?SEJyVGRMYkljeHlYRlMrdnpBWEp2aHVrWWRISUdwUTRrcTFQQ04zanhaVVBV?=
 =?utf-8?B?ZlZrekxaMDhaYTRpNG5ERU1jTFBiT0ptR2tkRktGMExERDZaclM2NkIvRTFq?=
 =?utf-8?B?KzRLeCt6Sm1TUlhTUEVDZWcxelZRclVLd3RIcXhYN2ZaSThsSC9lZlZWcHlI?=
 =?utf-8?B?SmdQVUdrTWpqbVVGMk5qb2pqRytBWlJ0SnNvZkQ2cXNEVWhwTlJHT3A3RXg5?=
 =?utf-8?B?V3pMTkhJMFgrYy80OFpXTkQ1SmdVNlVzSWltU3ZUZldxRnZHMWlTcGtPSUVs?=
 =?utf-8?B?U3pVMWM3a2haV0JubnN1MFpGblBuSnhjNzJQblZjcThiTFdrZWVVQUdaby9J?=
 =?utf-8?B?TmpJTHdKQkVJWWVlYlQvM00wOHJSTmY1UWEwTmpxVXlWb0NSQXV3bERnLzFD?=
 =?utf-8?B?TnFEcjdaaG1ZTWRpa3hPSGJCUkFPamJNakgxOWlNLzkzOVNFZ29LeDRpN0Zw?=
 =?utf-8?B?enBGbmpxOE1PT1pQOUFtV0U3Qm05UTAza2NpTWNIS3VxbHVHYTVBeUlLNEgr?=
 =?utf-8?B?UjVWc3hLUnpuNGZ5QTZPN0xObzZ1c0xyTGtneHlqb284RnpmNEp3bmtqTjdB?=
 =?utf-8?B?SThmYmhoOUNwUzNDWXdnV1doYldtU2ltcjF2cW5qdmZnVEhXcG80ZFBrUWZY?=
 =?utf-8?B?M0VDTysvMXFLcXN0cS8wT1Jham1vS2JJU1BITW5yODZEanowQXZWdm5acmZU?=
 =?utf-8?B?VVU2NjJXdjFDWVdVSWF1d1lKSTA1Nzk1ZkhKcjB5R1ZkOVBTWk42TlBLWkxF?=
 =?utf-8?B?UE55RC9GVVZtdVBQR3JkMWMxL1htKzZRSUI1akEvVG1BUkxNM1pYN0p2dGRJ?=
 =?utf-8?B?N1p3ZlFOYWVFem01ZHhOUmdXa1B3SE5JaUNheFF1MktsVWs4cVB2UnlMVDhP?=
 =?utf-8?B?MldnWGJ3KzRzZWk1Tk5Xc0hxNTdIMUFBTnZJaWlqRGFKcmttNjN0b2txUExO?=
 =?utf-8?B?b25PUlZCemNYREQ5YnhrelFIczV1NC8xMHM1cmJtTHM5UzVZdE9CVFV1TjNY?=
 =?utf-8?B?Zm9TTHFjZktaN0pFT1ZnRTNGZUxMMWVmMU9FQzNsN1FSY0gzRkwyY094WGlX?=
 =?utf-8?B?cEtlcWI3WkY5QmtrZFRhVy9WdlhmOWl1ZnJxd1o5U3loSVRmc0d2dHZrUkMz?=
 =?utf-8?B?L0x6ejlKR2JvNC9yK2VNdEJLSEtsUGl5RWoxbWg5UTFGME9DRzBPVUVnTmFK?=
 =?utf-8?B?S3BBcmdOaTV5bTVSMDIzWkJWci8xSUJkYTBLdEtuMWhLZjJXS2tlbmRQR1Y0?=
 =?utf-8?Q?Jurlu4yBWP8xcmh2T2K0+jkRwVebaOkISppogLqasCZYn?=
X-MS-Exchange-AntiSpam-MessageData-1: sb0YfvRBcvmocQ==
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 47380fed-c3c3-4091-8cd1-08decbe5bf5e
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:27:55.3490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN3Iswti1Cfmg3IkZYfDMnotPv8FE0NjG4KdGxC1+PqN23JBxUCYorLj0KMuObzKpW2TOpuYdtlS0jEHXVaAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1198
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



On 6/16/26 2:24 PM, Bryan Brattlof wrote:
> On June 16, 2026 thus sayeth Wadim Egorov:
>> Hi,
>>
>> On 6/5/26 9:38 PM, Vishal Mahaveer wrote:
>>> The upstream device tree changed the serial alias for MAIN UART1 from
>>
>> upstream where? Can you point me to the related change?
>>
> 
> Hmm a quick scan through the history nothing seems to be standing out. 
> Serial1 looks to have always been where DMSC put its traces. I wonder if 
> this was ever working.

Our boards do not reserve the main_uart1. But so far we never noticed any strange behavior on it. Maybe because no tracing is enabled per default?
I wonder if we can change the uart DMSC is using?


> 
> I'll try to see if older versions worked but I'm thinking we may need:
> 
>    Fixes: d2edabfa8de5 ("arm: mach-k3: am642: Load SYSFW binary and config from boot media")
> 
> ~Bryan

