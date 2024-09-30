Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D507CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 08:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3EC88A29;
	Mon, 30 Sep 2024 10:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OI0OIfDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A443688A43; Mon, 30 Sep 2024 10:55:25 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BAB889C9
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 10:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI+6ykLI2bmt+GDuzS41Q2dGpwuJ/8E9E1iwLQTFXsLN69xA2XBlirYU5Iz7Ca58lLhI0V/fLAKU2JS4BhAG82vWJl5cbuUiCZAMe+d4cLCfzvKgpBHyFPjNnle4pjYxNEdLLZK32U6hV5kSBSUm1QLVEPqmmo3DG4BFmRlD9ED6BupVUO3IYshxSXytMlxs5KNfUTPsCToFIwxj0qkLkRc03thY1zlv5N0b/POeVZ/Znp6WpZNR8DhpA+zLWk9wFvJaHRkGD+/Wop97gdav+k2UDvCZlOHn1nITzMpaZ+5tFNQbsmG2cmoxHDI5qIKFqVW/wTEBNPbgFlcfHZQPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+URfLdrMa7bKzEaq2H9ISaxt5GhZqEJiW1tQrh4V40=;
 b=CdvE8f/d1s3LeUidtTpzd3anKg4WVFqMrsaHiByAV6x8G5DbwUudHgyI5PWKxoTbKVlFANahZA1LARBVxpWkeWl+ZzsB/8EmCNleh3gL8QcafS30YfGAi/NMwRCNnATQ/4iw/qD4WW+MOBDJTb1qPIYW88d1iYqjzbR5CLoOPFkZOwrIQw7nZI91IT7VR9ErOb8iv5iitZkt41kIfHO1o2h1tX8cmS6VsZC2QGT6dPLW3ZBxfakgJBKzI09vI7KNSaN5kOkWJKdxFMmgN4sc0lepBYi0vOYdMcRsmPKXDUJKYSMMC86d5NrzE87BkCTrfpxL1/W4xmeR0g6SBPEwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+URfLdrMa7bKzEaq2H9ISaxt5GhZqEJiW1tQrh4V40=;
 b=OI0OIfDg29XSjI+q3VtvzC8SehEmTEnTULrbtXkuDflehDNBhyHv5QH6S/kTB+XdSa5sBJghs+QM55JNsNlCulfrJr3Prpp6uMXx+dPKuTtG9j6Ci0Z73eOVmaf5M3d3nkha6OCY97VTsqNwZYDfXRopGiOYH2bwn0oXvC9ML4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:55:18 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 30 Sep 2024
 08:55:18 +0000
Message-ID: <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
Date: Mon, 30 Sep 2024 10:55:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ecca2a-ff83-453f-1745-08dce12d9bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkxaMGpwSTJ0N3ZCYlNFaW90STFUeFZ0QUlyMU1BSEx0TVAwbzdrYzdRanpQ?=
 =?utf-8?B?MUJONWtoWmtjcjR0VVJyUVc5WnVSWmNVenUvODdYUmJFS3JMbTdzZVhGNzAy?=
 =?utf-8?B?MktFekd3OFloVDNqcVZMUHJuSVc3a3lMTTdmOUNQSUd5aHlYUkF5cW92S0tT?=
 =?utf-8?B?Z2pFT1V1dzJXcGcxZDZPWmJHOUhRVTZJbnhVRVBVSHdTUVAvOTBjNjV5THBi?=
 =?utf-8?B?WS9sUVpqcUphYXRxM1ExQXZpYTVnT2VxcXYvTjZyWDgrajA5NEdoQkNZbitL?=
 =?utf-8?B?ekdzclhZSlUvNzhrcnhjbUVCZ3N2Q0NUMjcxc2VzWVNkb2V4OWtWYlQ4V3Ns?=
 =?utf-8?B?NVFBa1JTVUVOS2V0aDFHbE1rVzY3bldCYnBwOUhEMEpWV3Bvb2ZjQjJocVl0?=
 =?utf-8?B?UzZQRmpwbFBTZllEenhza2xCcGhhR0JZSlFKWW1NOXo4a3ZsRmU3bFo3S2JH?=
 =?utf-8?B?NS9lNU9YTnluaFIvdHI0ek9BRmlrK0RFZGdmTTV4K0JBQTRBeVpyaWM1ZEdk?=
 =?utf-8?B?dS8rU3R3eVg2LzhIUmRqSXpLOUs5RGhrV2lVbXlHcE9CRm9pYkczQ3hEWk1H?=
 =?utf-8?B?c0lJemoxUVBmcUpPbUVTRitsaGNweXpGa0d1ZnVyY3l6Vi9MQVF2K1RCQ0FK?=
 =?utf-8?B?dDBUeitxY0R5KzVrRlp2K0dGRFNSVm9pRUpnRzRPYi9rQlRQNkp1aG1RaHBY?=
 =?utf-8?B?TGcxZitIbVhUbmc0V3FNQVNVQ3lobGNmQWlXOWNoYnFKZHQ3enpIbTZHYWpk?=
 =?utf-8?B?MER4K1dXYWJHd0FwTm04aWwvZjQ2TUNMMjFReXAzVGtQT2loeXpab1V4Tlk5?=
 =?utf-8?B?dU5XV1FkUUM0MDBuMWQ3RkhtdG04Z3FDWnZhZkx2SmROL2F6SnQzTHZYWHR4?=
 =?utf-8?B?OHZqS3NvVkhTelpoMENUM1VISUt3UWF6MkJSeUhBUGR0N0tac3cvd2Y0VjFN?=
 =?utf-8?B?SVd5K3FSRnNadW9qdlNOeGtrR04vdUZpVTFZQ3JkVEFkWVRXNTdMOHA3VnhJ?=
 =?utf-8?B?VUdVV1RsSWc0V1V0ejM5U0pPV1p2SVB6SEc0WXl3SWEwK2pwSUd0QUQ3U0g4?=
 =?utf-8?B?WGwyaWpJbllYZ1ZmZjBNMUE4K0tGMjdjZFl5aUpUZ0lkSWRucGZiUzRydlhK?=
 =?utf-8?B?R0kvOFRtUTFBTnJ2R1FvcGgrTTIwUmcrc1licXJMNTh5S0pEKzlRdVRleUpl?=
 =?utf-8?B?U0FjdWtOZStsTGM5d3NhaVdlRFYrcVQ5QU1weEZKTGtYZW5MbTFOYTBpMnVm?=
 =?utf-8?B?d2tEeS9xT0tUbTd4QUNpMU94R3JsZGJkZW9DVGxndUdDVlAxQ0R2RnBLOFkw?=
 =?utf-8?B?aFd4Y09Yd3JiU2pGUDkvY25YalA1UVBZaGNyNkdwdWt1emdYK2QrTU5ZcDR3?=
 =?utf-8?B?N0J4clpQekI0RkN4UHF3MWw3dVlSNVVpVmRNSWRnM3JJMm9GYWJGZXBKa1U0?=
 =?utf-8?B?NzZhWS9CdE9OL3lkSHltVm9hTDd4K3JkWW5RN09KR2Nsek1PdVRBajExb1pO?=
 =?utf-8?B?SWQ4dXliNzdpclZqTGkydUVrY2JZRGhHd3dYSDM4L3ExWGR4Wm5EQVlkZWV5?=
 =?utf-8?B?SlEzQTBSd1VZVnFqd1d3NHFUK2xMRnV0OW1MUFVzVC9uOGJWZXhTcVUxTWRq?=
 =?utf-8?B?TlNvSUsxOWluYVluanZFcnVQdWFMODFiNHVqazNvVGFBSEVTMkc1dVhEU1h2?=
 =?utf-8?B?d3AzKzVabURxRVVOYjF3WU9NUG03RUxCcUxDeWRPWmlEby9QdHhmWEtScnh5?=
 =?utf-8?Q?80ObNmrkXo44BkMhMk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdtbWljWWwrZCtGMFVUbFg5UjU4TEtOWGZJYmpyV2NudHhVQ01FbXRuODVu?=
 =?utf-8?B?U2hkdFNMNUxhRGpiWjdDRFpZcGtYQlk4ZmZYU2VzanE0aGpLWHl1SStsWWYv?=
 =?utf-8?B?NDJyNCtPYXIrZCtHc09tSFhxbEIzRWs0MU9JU0ZXZDNQVFh3SmZlWklUYW1T?=
 =?utf-8?B?b1B1dFZVeGxiRG5DUVllZ2lCUHQyQU9lWnNJbUZQcFJXdW41cUtidUZacmtI?=
 =?utf-8?B?RlJoRGsyNko3b05RUkN2RnZOdnlWMjA5MkJqLytodTJjb1ZWYi9uTTVlTzBK?=
 =?utf-8?B?Nk13TGhQR09VQW1RcEx0RnU0RDdqbEp5eUEyYlRkUUJ3QmF2Sk84TjN5SUdD?=
 =?utf-8?B?TEI5b1Z1UDFaZnc2Qk1wcExqTFNBNDJ0aDdoWnpnS21lQXZWTTB5VVhQcjJG?=
 =?utf-8?B?Zmd3ZnFaR09JYWh6R0k3dzU5UGRvUW00OHVMZzc4MG9xZGdyTzBIUERyR2ps?=
 =?utf-8?B?ZTVtNmxObm1heXBRQU1aNU13TlNWRFE2WDBlTUxDZGdHQmgxcWxaRjNKTG5N?=
 =?utf-8?B?WTRrcDFHMDlPSUEwcDJQemZMSVN4SWtyWkhPWjZwR29SYWp0azRHZ3A3R2Ny?=
 =?utf-8?B?bVRLWkdFQUh4cEpFQ2JUQ3Z1dTRZVlNBL2kzS3RtSUswdW14N0h3QkVKN2pO?=
 =?utf-8?B?VVpwT284OEV0SFFmUkV2d3IvMmszcW4ybFl6Y0xwWTFjNWZ3ZnZVY1A5NVVh?=
 =?utf-8?B?eWJwWkRSRWkvRnMwMlBKOGZqWUFGWnU2UkVLaXhUTk4vcmlSNVVNc1dkL3Q1?=
 =?utf-8?B?ZVJUdG9jYlQ1bVd3d05pU3IwejQ1YUwvalh4RXhnU1czTHZITFhlb2xBcGpt?=
 =?utf-8?B?T1M0aVpUd2ZnNTBvNGE5Nys2QTdmNlhWVjFacFJpUWlXblV6VkNKaThTbW1u?=
 =?utf-8?B?V3lESGEwWjlLeDA5TGNSWEZ5UUFZMmNnV0JWa0NmWFVYckJENGlzSDFkM25U?=
 =?utf-8?B?Z29KYTJNRUxHdm4wMDdIUkoyQ0tVQ1VvOXU1MkZXblo1OTlwV01YUlFjSEJT?=
 =?utf-8?B?d1NMVCtCeFc1ODQwSEtUTStnajI2TmdkU1RvL2NmV3BYcnF0NGdkTG1FaERq?=
 =?utf-8?B?VkV4QUFHOUFrOEZvWmFLaE1uNnhpcTlhTW5aNlZRYnhLNktydVhIMEltblNP?=
 =?utf-8?B?cDVTVUF0V25DUnd1U0h3UEdMQzhLZ2VJYUFzcmNXYmxVa1RFbXkwWk52c2ND?=
 =?utf-8?B?TENiQ2R5MmozSFRmOGI0dkxvVlh5Wi8xY0pROEZNWHZQWStvQkhXWlFvVVVz?=
 =?utf-8?B?YjlaZWFkYWdJOWluSUlHSzN6c3RMWlgvdVNpZWpRS21EazVVd3R3T1RDVTE1?=
 =?utf-8?B?STBoRjljWGNodEpnMExKa29MTDhxMXZDY1BBZjk4RlVPVUhDZUw3Zmd2N2ZU?=
 =?utf-8?B?cS93RExhRnkrMUs5Vm01UWsydExFTUVSQzVjT1l6MkxGZE1TcTROTmZxaEVK?=
 =?utf-8?B?ZWZhbG9nWU1jNDBhODllY1BzV2JYZ3kxOFBuZXNhcE4xNUJycU1zc0p3Mjdo?=
 =?utf-8?B?WHBBZFBFZ2ViU2MrNlJ4NDBRTmN3c2dDYk52V3B5dDJ3QW0wTGRPTlMvSTEr?=
 =?utf-8?B?ejdCS3RKeHkvWVp4RitUdDRZQXNhL1lnQllNMFBXM0I4bWJFRTR6bEdLUXpV?=
 =?utf-8?B?K1ZjU3RaS1hmSWRTQ3d6SlB1aklIOTNXVU9Md3c0NzMvblg1SFVaVEJzU0FG?=
 =?utf-8?B?Qkt0bDRVMlZlYlpBcWZnRkVCNVdoVE9zQVY4d1ZXK0pYNXRveVpkb1BqT01P?=
 =?utf-8?B?RnR1THp3V1RYVFZWUVZ3eUV1M0RNdEw4VnBmQ1h0cTFzVEFBWGY1OHhxYXNH?=
 =?utf-8?B?dEFLYmFOV1VjOGtSOVVOQldqazNZUjIxQnE3WGpaZWxkcUhGeks4dlJWZm11?=
 =?utf-8?B?a0tJZlRReEh3WkpuRUNpTXZSVDhOSVRqaCs5SllkTFVhWVVaTWs3RHJwM1Vi?=
 =?utf-8?B?M1owcFBjNlJnaXNiSEdwaWtCVHIrM3NydnFWelgvdmRoN2ZiWDE2Sjk3ckVQ?=
 =?utf-8?B?djdyK1c0RzZUaUx5MVJBeEc4R1Z3aWFmdDJrVEtlUWVqRk1IV0E2QlhORGRy?=
 =?utf-8?B?THRWK3dOZkUvcFRWNU81SUw5Zm42bmlhaUJCbmpEZ3dlT3JSUDNaZ2dlbGN6?=
 =?utf-8?B?Y001QkdYU2FCZkxwWnd3WXNJdGlKcTFiRUJxSkFZOHEwbXpSTW9CS0gyVmF0?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ecca2a-ff83-453f-1745-08dce12d9bb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:55:18.3169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATSxkaE1SuKgHc1YCjCVVragQ6ohZzNhHzgaczv9jVgPH0K+EnX+fk0tRqUZmrKBm2xPHpvD3i1DPTmtwFqM/CgzB2c5tC5mYViw8sFhSgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316
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

Hi Kever,

On 9/29/24 3:53 AM, Kever Yang wrote:
> Hi Lukasz,
> 
>      I think this will make the error happen like this:
> 
> +common/console.c: In function 'puts':
> +common/console.c:746:29: error: unused variable 'ch' [-Werror=unused- 
> variable]
> +  746 |                         int ch = *s++;
> +      |                             ^~
> +cc1: all warnings being treated as errors
> +make[2]: *** [scripts/Makefile.build:257: common/console.o] Error 1
> 
> 
> The main reason is that below patch removes "#ifdef":
> 
> c04f856822a console: remove #ifdef CONFIG when it is possible
> 

Can you please always share the link to the pipelines that fail so 
people have an idea on how to reproduce it locally?

Here I assume it is: 
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22455

A simple way is to apply the patches, build the pine64-lts for example 
and then you'll see warnings (which aren't failing builds locally I 
believe but in CI, yes).

I think we can fool the compiler with the following:

diff --git a/include/debug_uart.h b/include/debug_uart.h
index dc0f1aa4c98..b19e44d6d0f 100644
--- a/include/debug_uart.h
+++ b/include/debug_uart.h
@@ -204,12 +204,12 @@ void printdec(unsigned int value);
  #define DEBUG_UART_FUNCS \
  	#warning "DEBUG_UART not defined!"

-#define printch(ch) do{}while(0);
-#define printascii(str) do{}while(0);
-#define printhex2(value) do{}while(0);
-#define printhex4(value) do{}while(0);
-#define printhex8(value) do{}while(0);
-#define printdec(value) do{}while(0);
+#define printch(ch) do{ (void)(ch); }while(0);
+#define printascii(str) do{ (void)(str); }while(0);
+#define printhex2(value) do{ (void)(value); }while(0);
+#define printhex4(value) do{ (void)(value); }while(0);
+#define printhex8(value) do{ (void)(value); }while(0);
+#define printdec(value) do{ (void)(value); }while(0);

  #endif

Does this make sense?

Cheers,
Quentin
