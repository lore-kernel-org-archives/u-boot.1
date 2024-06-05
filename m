Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CBCC27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 08:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C552C87A09;
	Wed,  5 Jun 2024 10:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HePtR/MZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573B48780E; Wed,  5 Jun 2024 10:36:13 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B9F87D43
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 10:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8V1MU8isLh/iVQEJt0bl/HvE1SU/g3B/Jzum/C3RODDc7mCi3rdg0kPJeDszvAY3BCGLgqgNpkJv517DFVdQgfPcbC4liB/1r+ebdVjOaLHLODqHprgpsLM2WDemMjw/H5aRDLhjqgiAiZZUj4F4LQDLc7pMNPpz9spRt3yuMF3+uDhHYkrdDeGS72bCavHB/2Cg4z2kBnWIBbGd6WrPbp5ALzktFSfsa1Wi4+/Z1mqhPzSYfl9SZXBgmlLIR3iAORPf37s2EKR1n5Q3ba519Ghn8/YuoJMJVpmVt92l1BaRHnYRybJcsbsGqWhs6AK/IG4c0DBBhF9ieu95VrsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzaOusTjezORlSVvRlxjhScizWhbO8pTEktIQv6V0Ps=;
 b=MwvkfQwOIIVTwY+iRiCf2I/dKzm6rfSM4wD4LoTxUhESHe3fqapQooZ07JlvgdD5xETOHFP4IH/z6jgxN9PaBREDzft1lcKaK/Xl0fSjvq1jAnQ6lSNw+b+LC80xnuwNVARtbbTSt2kicuWBmqobmWMkKEoJp61rycbhXo/kkweSgUNeeesQjiJHM0sxdK+i7NLk7WP0ccCMuJpuEUzoHFU0AbjSt/ayRVdPNonPzfbFlVyyIb7EfYG1mmHul1i0ncjsGXZSt1m5oV4S1BlpLa8GK8Xml5QRL/y3b1qGBP3EwbFkvW2bzZaLX553X7eal/XdY3oNmNSGSB7YpiUAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzaOusTjezORlSVvRlxjhScizWhbO8pTEktIQv6V0Ps=;
 b=HePtR/MZBPnI61NxmGxsjY0PzV3o4mDASMzBJSBsTxyHyQRTFY9P4qnsH16sHJFM/BoZA6hiN9ZWezzKCErqTagEUInoOl/MVu+XfNxqaxtGOjOmOjFwxsOsr9YuFTWVrb41qoxaVr0XUZGUtmvcJVtHv2zmZLbKb92uziAvKi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10548.eurprd04.prod.outlook.com (2603:10a6:800:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 08:36:08 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:36:08 +0000
Message-ID: <bfe289ff-eb98-477f-bda5-ab8559166ec3@cherry.de>
Date: Wed, 5 Jun 2024 10:36:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] rockchip: veyron: Add logging for power init
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605032521.1142768-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10548:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cbaf05-0da8-4133-e386-08dc853a8bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWpBcElMbFRTZDhiRHBITlFDdHdwNThVZ2hyNkRUem9IeGlYOVJob2pyKys3?=
 =?utf-8?B?UWhnZDFBZkdmdlBQRGNPRWpRUnZNdUx5RjVNSVU1RkxxMEhXZEJ2WG1lRXlq?=
 =?utf-8?B?ZkdjL0lSYWdLMEFwMDFMVUxrcW1MWkVoL2VUNjUyNm9LZmZMV1lRdElheVBP?=
 =?utf-8?B?ZW1pS0NvUURJNjE1SXJWVnJGQnZGY0d3cGJQYXhhckd3bmx0Q0tVSjBWbElx?=
 =?utf-8?B?djV5OVFOMGhKMFBJTTFaTEV3bEtqbytpQVJjSVRQcHUxNDBuR1prNzMwU3Jx?=
 =?utf-8?B?QkdDSUcyUUtJR25iYXBzMjZnaGUraE8zalprUzRzMFdpS2F0NUhBcGlFYWJG?=
 =?utf-8?B?dEpMNTBPOFFSbjlyYytmRUp4SFU5TlpRTWdNK1ArcnZCL29ta0FXTk9EUE13?=
 =?utf-8?B?UDErZ24xbktKdFZoRGcyWE5oaWFTTWxDNnVJY3VUZk9vUTZ3bFQ1Rnc5QzFY?=
 =?utf-8?B?RjEwKzBKQnE1UlprUzRFWUdpTFcyc25FaWhUM2ZIdUxhanhZMWtScy90RVdp?=
 =?utf-8?B?elUwSzJwKzBWWUpoVGs0TjRqVk1ZVlRkV0xPdEZ5dVRLbGxHYVRtSVlhUkta?=
 =?utf-8?B?alJFdzFTZHZERXRkTDZDelZiUEZ0bFJUazJuQjFkbzNiUnJyb3diMU9JVlQz?=
 =?utf-8?B?aUQvMTg2Y256SEZpMXNXN2Y5Wi9xVlZNWlV3VmxRenlPTXFGamUvMzJIMnh4?=
 =?utf-8?B?WE5xaTM4RVQ2eXk2Sm9KUUdQOVNFTGF6c29jRW9iRDVUUUErRFpTNy9tWDFD?=
 =?utf-8?B?WVEzSWM4c2k2ZUQrdXRBNXdGNjF1TWpBcUNRdElMMUZrNS9ZU3FRQTU3bUJX?=
 =?utf-8?B?R3hKY09sNG5DMUtFQnI2bU1TaFMzRTNLMGRJMnZRckZiMlFFeUVZZ2h6UkFE?=
 =?utf-8?B?VDgvbGNJeXlzSWdmNXI2SEwxNjN3Qjh6dW04ZTZPSVUrQU9qYXVlNitGRlk2?=
 =?utf-8?B?K1FMVytZOCtkNTgyUHlqMDB1VmpOYTNQTDFoUnhaSmowMGsxcHRKczBpYXc1?=
 =?utf-8?B?S0tTMDNHNlJ3STJSNFNmeVBPQVZaZTRKL2s3a0RMNUV4TFQvdXdtZmx6VWhM?=
 =?utf-8?B?cjlrRlEvUHRKaGlIbjRYaThmRFNDL1ptejg3SnVLNzFQR05aczMrNHpuaG9P?=
 =?utf-8?B?NkJVMGt0a3BJaGxNaWVMNGRBZGV6eitYVzRpbEFiQ0w3QXdLZDd6SUNreWdO?=
 =?utf-8?B?V3VtSno0Yk1hY2kyT1pOcGZCSjNPYTJJMU96bWZSRlRLclNhbng3d0ZnNjVY?=
 =?utf-8?B?MFlyQVh0aCtaOVZ1UEJPN1Rhc1V4NTdIa0VLYm1iSlMva25rbDNyaWxQejNw?=
 =?utf-8?B?U3VUQzExMTA1R1pJQWNqVitSaU5qLzNTZ2xQbUN6UXhOUWpIOFlCSVEzTVZ4?=
 =?utf-8?B?eklRZ3ozei9nQXE4T3Q5UEhodG5EYkFvMisvb0w4NEpxZytpbDBRUzNNQkRZ?=
 =?utf-8?B?eklzN2RqSGFwMzNaeWdVKzlRaHRrWnVkMERsSnQ1QXMzbkgxMGRKYXcrSDB2?=
 =?utf-8?B?WHBtQy9PaXlCcHFjVE4yN0NsR3VsUTNUeCtNd0dONzM1MFd0YXNWZEx6TTh5?=
 =?utf-8?B?bER6NDZoYjZuM3FMQTBxTjdhZHM1RWhRUmFWUDkyYzVjZTNoZklKNWlpT2ZH?=
 =?utf-8?B?NTJNRnh2QnlId1RkWk02OVkrSlBnQnBOdDBtWFpWTWFDY1NVdFhhbWdaMFJH?=
 =?utf-8?B?MWhWWlpveWo2QzRhRzR0TG11c21tRWxINklOWFdEQ1gxdUdvVllBVTdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBVK3R1L2xXclVwVWF3Z1l0ZzY5YTR1R1pXL1gvNW1ydzAwbzd6dEluSVRu?=
 =?utf-8?B?dGpPaUlGV1NpTjJWU2dCVmdvemlPKzZ0UjYyV0w0MWtqeEZNMEdraDN4Skk4?=
 =?utf-8?B?TjY1WDFBRzVMNXRoSWR0ZndPbmp2a2xVYndzM0ZIdnFyWkZZQURpdVp1WFYz?=
 =?utf-8?B?TnNZMTRZKzFLbGZqbHJhWHE1eGVJU3lSaXVFeUN6cTdKSHBYbFRiYmhBaDRC?=
 =?utf-8?B?UlRWM1hia3FvM01Dd09DeXdsaDFPOEdYLzR2MHZnbTBKd3FpYzVFcjFOLzJt?=
 =?utf-8?B?UmpxbCtERDl2SkNicXlIU1pDUFpDQUMyeUQ2eEg0WTVZTDR4Rlg5OTF4SXpB?=
 =?utf-8?B?OFAxaFd1NDI3SVBQeEEwWk9yT3pWVFBydTl0U3Y1K2c3dUppSWZxRXZxRXQx?=
 =?utf-8?B?WUtGenJJd1g2ZGt3c0FFNWxISzN0MEJwRS9qRmlQTUdMUnhxd0kwZS93TGFY?=
 =?utf-8?B?UVBLNmlEMFNOYXlIdlNJQlNEZGcvTkh0WkhNY1JLVjllSjhoNjdjc0p5aHZ1?=
 =?utf-8?B?K1pNZkIvWG1idmJYSXd4WlVXSnlZcGhUbzdGeDB3em1KdURtaDhaMEEvWGtB?=
 =?utf-8?B?Wml0dFoxQnVLZmpNT2RyLzBCMFBuWlRYS2JwUm53Zk8xWWNzRGVrS1FjVmFD?=
 =?utf-8?B?T3BzS2ZLOFkzbnBVZGNvYWtMMkhoMWE0NG05cFdRRFBUeGlaYk5lOHN3bmV5?=
 =?utf-8?B?NXRWcU82Sk92SjI1blo0TzBMV1FJS2dxK1R3Wkd6YUd6TitsNGhYbldRNEpk?=
 =?utf-8?B?NVBLTUZuNmsrY2x4MTNIT3hsd2U1VDhkVkdyaWJvWE5DRWtnNW5Cd0ZacXNT?=
 =?utf-8?B?b3FqMm8yS2UvREZwS0NOaFF3Y2dWNmpnQy9VeGVyMVRkTkpsRm9tODVhU2Nk?=
 =?utf-8?B?THdNSHNXU2dod1BJY085MmhrS25OMGZIY2VLUS9kT1pjaW1KVDNCYlRRZmRh?=
 =?utf-8?B?U1RzVXFjU24xU202REFvb0ZZRzVQdm9VRkdxV1c5V2QzdmxJQTlkVDVHR2FB?=
 =?utf-8?B?Vk1IZFVRaVArS2Jic1Q5SDBGZDFNa2RaRTR1RHcwQUN3RFl1MUlxV0Z1Sko0?=
 =?utf-8?B?bmpuODFZOTB4MU5BdnVxQ3RudTA1R2wzYi9VMlBsMDMrSSt4MWZpZ1grREtU?=
 =?utf-8?B?UVRjc3VzZW4wWWhLTjVpOHBkREdSRDhDTVlhazFnMTRRdkZFaEtpdlQwT1Uy?=
 =?utf-8?B?YWxpRzZxOHlFSlFMYnJNdERpeFE5Wm1GUmE0S0FIVVpYSHhsQ3FncStTYmZM?=
 =?utf-8?B?YTVISkxLTFRtUTN1NDRkWGdkcFh4N2RjaEsxRzNiYmtPY1JEaGIzcmpZVjFx?=
 =?utf-8?B?SW00Z1V2WXRpZWRBUmpRcmVWNmVweXE1TGdRZUVTWlJrZzZBR0tnaE5Sc05C?=
 =?utf-8?B?YWZ2WUlwT2pSM3U4ano3WHJTTzR6T21CWHZqSmRXazdYWmlwdE9LL1k0aDdL?=
 =?utf-8?B?WEc2RHhrKzZSQVA1Z2UyYnZQSEpMV0RaQUNHSUFXMkx3OW5CRWlSaE5pa1dK?=
 =?utf-8?B?M1JsUC9jRks3UGpkQTE3R1l4Wkc3d1o3eDFVQm01aGpCOVNXZVRyWG5MN1Ar?=
 =?utf-8?B?L2xHcXdTTHlxM1M3VHFFNGtqMDdRaW5EMjBEV1hTZS8vRm9RQVY2dlF3SU1k?=
 =?utf-8?B?MDVHbS9aM0ZBYnV2Zi9mMkc4aGtxdnJMcExxUDJSVmhBbXd0WDFUQi9wTlFu?=
 =?utf-8?B?ZDRGQldvTmROdTAyWmxGcnFNZzgyNEZHYk4zZXZjWEw0d2VhaUdjRDRYWmV6?=
 =?utf-8?B?aWowLzcwSEhIWlpYNUlrZjk3ME1DODFJaSt0NHdpM2lVRHplVFdtNUZzWjlh?=
 =?utf-8?B?MWErRGRkb3FPZzFQZURXWmRVTThEemlIby9LUkR6YmMzQkJuUXh4cmFMdzJR?=
 =?utf-8?B?ejVDZEhoOUVFem52VDdwc3E0MnRhWUZzRk8wcm9jbVJMbGxlTGFKbkdLcGRM?=
 =?utf-8?B?Q3U2VmZDbGE3S1o5am1kUXc4MzJQWTd0ZE83WU4wL2FNNUhoZDNOTjVZWXR1?=
 =?utf-8?B?TmtkME9kMFluVGxWenQzK1VqZUs3Y2laaUltZ1VvRGpLc2trcll2ellDZUFF?=
 =?utf-8?B?OHVEdXhKM1BwbWp6a0RwcGZZU29GeFNQcTVNcHJtZ2lxTXdBR2VsVDBMekJR?=
 =?utf-8?B?VWJaaGFZNzUwaVFmZHBxYjdacDB1VFI4aFVxdEEyMU5JcXVLU094WXVubWFX?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cbaf05-0da8-4133-e386-08dc853a8bb0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:36:07.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEHr3g5ZpCFfLkwSrmUZ4QnrJGf1MeQ28yNLXVzQ1GeLXMRXyKS7AJMpyoamLiglZN7lysIkneQGmOpZQxZEn35FESaV/gwBpEO+tf+fJT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10548
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

Hi Simon,

On 6/5/24 5:25 AM, Simon Glass wrote:
> Add better logging for power init so that CONFIG_LOG_ERROR_RETURN can
> be enabled.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   board/google/veyron/veyron.c | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
> index 32dbcdc4d10..23fe8bf088c 100644
> --- a/board/google/veyron/veyron.c
> +++ b/board/google/veyron/veyron.c
> @@ -29,44 +29,41 @@ static int veyron_init(void)
>   	int ret;
>   
>   	ret = regulator_get_by_platname("vdd_arm", &dev);
> -	if (ret) {
> -		debug("Cannot set regulator name\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return log_msg_ret("vdd", ret);
>   

Those log messages aren't for code in SPL as far as I could tell, is 
there any reason to make them that small/cryptic?

>   	/* Slowly raise to max CPU voltage to prevent overshoot */
>   	ret = regulator_set_value(dev, 1200000);
>   	if (ret)
> -		return ret;
> +		return log_msg_ret("s12", ret);
>   	udelay(175); /* Must wait for voltage to stabilize, 2mV/us */
>   	ret = regulator_set_value(dev, 1400000);
>   	if (ret)
> -		return ret;
> +		return log_msg_ret("s14", ret);
>   	udelay(100); /* Must wait for voltage to stabilize, 2mV/us */
>   
>   	ret = rockchip_get_clk(&clk.dev);
>   	if (ret)
> -		return ret;
> +		return log_msg_ret("clk", ret);
>   	clk.id = PLL_APLL;
>   	ret = clk_set_rate(&clk, 1800000000);
>   	if (IS_ERR_VALUE(ret))
> -		return ret;
> +		return log_msg_ret("s18", ret);
>   
>   	ret = regulator_get_by_platname("vcc33_sd", &dev);
>   	if (ret) {
>   		debug("Cannot get regulator name\n");
> -		return ret;
> +		if (ret)
> +			return log_msg_ret("vcc", ret);

I think you can just merge the debug and log_msg_ret here?

Otherwise looking good to me,

Cheers,
Quentin
