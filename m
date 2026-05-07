Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C33CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D98284B58;
	Thu,  7 May 2026 18:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Q9ILIRM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4824D84B53; Thu,  7 May 2026 18:03:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9519484B5D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm3jTWebs516h6D8obMvCpWdrPnwgL6h+p3oNIOs91qNCo5NRjBIxhenzJJLh71ySVkSz7qi0VLhYlMmHu5Y0cyuKRt/whiI0HCxwYieid1b+yDFa3rvvX6ap2m9mux3BJtOewRmenxRnYp9NLUOhmJT10YwrwYS9VXHhezSjOvYGKYbo8B/vYNz31braz8PjCV0V8jRjUZE0jIHpAm9/3tDoGADMjYozwYZCmpWqIJQR69pGcyVtgyy9OPGmKHvVwHVef6uM/A3KH+ar87BH8wqNtxHdoi8phCu2YvJKXbcDSX64o//2n/J2rxEHfcpW44yGKZxZpMHmoUImK1hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7BcN8Xx9dBYxP6+5nQ3EkfurA6Gx/WKogM7JyNng8w=;
 b=ud0wV0nEO7BxV4Sa06fSf91lE3wWyUxUyD6bN/cHmYHw5BhKY5FF7E/kVmYnsdpzVDY6YYr14ExmlyyU0pfmI6gGMeC1jj+4Ta+UoPigptDsQRZ0E3qTPwRsN0XmW0ZMCu2F21PtUDULznUFluPLcTSW74Z4+yGcCWMK8zPYIIL28bR9GDjncsxDyD4STkoM+0EqQdFQ3rxG9hEPlcQ03tSw573qfpMFoAD8BctQFAzLLTTeja29s7Z6NOjA2SuHOWbRk2HSimn+MG1ydqc6Ph50SW9xZR4WgSoTRp5o+jEcDsbA7/mkTO4/qJ9dzz+G2FqEY59E8FuB8TadD8mbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7BcN8Xx9dBYxP6+5nQ3EkfurA6Gx/WKogM7JyNng8w=;
 b=Q9ILIRM3R/1G4sW9GZ4HeuzgCJQE1+dE2qiDiqD+F8Xgyi0AHmZYMe4s7kTY6Q/DulT65DqLDcXAP5MT7MyOS82i2zmXkmxGf9SGqYcFRN8ZkqAzvSN1Dvr7FZmPdzs7hPJ+7b8X7orqzhavEQuhiKbAlB9JAnxNdbtIOsj9Vhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11926.eurprd04.prod.outlook.com (2603:10a6:10:628::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 16:03:22 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:03:22 +0000
Message-ID: <33b4ac8b-6c00-4204-95be-bd0c70a49e8e@cherry.de>
Date: Thu, 7 May 2026 18:03:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: binman: fit: support engine override via
 argument
To: Julian Haller <julian.haller@philips.com>, u-boot@lists.denx.de
References: <20260504164849.108849-1-julian.haller@bbl.ms.philips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260504164849.108849-1-julian.haller@bbl.ms.philips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::39) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11926:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e37602-8482-46dc-060b-08deac522a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: VjlpK6OJ9EIJtyQLJ2POJGxkJaFekbB7GpbsByZD6uAQwWkRWWIOX6g/BWkxbK4DEhOJH7nEChz/v6pTn4mHSZWFsWQNwqX9XKdlIhDI1OLRgdAR1ipiafzXuojE21zFV9K+sBqLGzAc80pxwfc5a2I1jniynYekGHDyl6x1s3M9yohA995yCaY7rZd3psyAd1AvrGOO1BHHRm5R0p2hkZYvZ3l6TkYYAPNKk7Fbm66XmWTMvOTHmWT915AC7knEThrTJdxFxJy03t6jvG+5QLOIQDL4LOxgbkjZ0dTSqRqlfaYzYAH89WwaB08sFx0NMTM9v9HwlVY8WFewLUpTeOI8rlBHYcqXOJBLVmngTYFjfXkC81ekShZS675wqTxWRR1VP+whwd3RN7Y2prDcsVCHrNpaIcWj/FZsl2RhWwoRjb98QbpPSV+7MF/86kUNELieD0afvuZoD6idHwSC1TPL2hFhiUFoEQl/yoPsoms6Deusyq1Z8SYT88diAncPWJtrP9R631IV7UKGQzC7fRLj5vX36W+KeStRnLx43EKT1ghBHKjKaBM45Mdd8/o05DdJcWHSUvd+r1PqKVa1oH1kZjj1arWvaf16yvFfnZW8IfSbm2Z6ekukWUqdkMIBySpbM/AlWo71IHmSigQxXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRYd0R3OW1GMmFOeDB2RWtWZFA2V05mdzBya1FITVNUa2Q2SUFveVhzSTV4?=
 =?utf-8?B?VzFLbm8wOURTMVdONkxRM3Vrd05POWxTbVJWNFE0M1Q1dU04emttUHRYQjlp?=
 =?utf-8?B?TWpNR0xBdjJaRm9TdDBRYUJURUJaNWo4c0F2WHVFaFAxb3A1a2t6a0pwSkJu?=
 =?utf-8?B?a1BqSUFOK3JUL0xiM1lMSHB1SFBreWIzUENobHBDMWtCdFRmQUFyTmVpbDlz?=
 =?utf-8?B?anlGRi95TnJ0a0U5QlZjdWtibktNWW9McHc2eTJQb2FvdUV2Y1RlQy8wSkFh?=
 =?utf-8?B?RkZWc1dPenJ2V1dZeXdyNXh1alNtaGRsRFNQc3g2cVhTc05mc25pdnREWTZU?=
 =?utf-8?B?RXN2SW5JQXJpT2R0NVlvK0ZwNVE3bXk3N2ZPQ1QrbGtwVHdxNEY1ZVJyNEN2?=
 =?utf-8?B?N0xGUjg0dEtzTGZCWkxnYjZVbU5yNWIrR1NNTEZqZ1BwTnN3eVJVOTc5clJk?=
 =?utf-8?B?a1N4S3Y1MDFYMHBibzJnS3k1Rjg4bTdpOVh3VHNGNktJQ1MvZXB5akc5dUFt?=
 =?utf-8?B?RWcvVGFhRDVtSTBNTEl6NjV3d2s5NlJoa2R3Z3MwMHAxenBrMFRpemFMbDda?=
 =?utf-8?B?VU5ndFY0elVLcjdVTWV5eWN5a1ZFQzZzWldNSktUcTUwQUdaK2pCUUJUNEYx?=
 =?utf-8?B?dnhtYUJzdGk1UDlpbXNhR0Y4Ymp0dXRBT24zUE1jckpjcEt3K0RvVTlSWVRu?=
 =?utf-8?B?WmtCQy9xQk0vaDR1azFXVHBySTNjZGJpcnBGLys4NGpCKy92ZzRwS0VDVktp?=
 =?utf-8?B?VHNyS0RXRUFYbmJ1bHRKQkExRUZUQnFiTnI1NThwY1pQRTdjQjl5QjUwNGJI?=
 =?utf-8?B?dk00Sk1tMGtSQUNLK1JnN21kaGF5Y2RYRTJXNWNpSktvWjNhVy9tTGhXY05n?=
 =?utf-8?B?bmczcjVmR0ErdlRIODNueFRqNzFldkVIRkJXUnphVHlCZUo1QVRwODlpbFVF?=
 =?utf-8?B?SzlQYWp4MWJ5cmkrK0NKRVlvYm5Cd0VhbG9zemQ4NkpWLzNDbG1MRXVPVGNZ?=
 =?utf-8?B?VnVFTGsxWVNBaTJTcExKNUd1aVJsdDNtd1dUaTl6d1dQa1JwSEwzaDN1Y1dG?=
 =?utf-8?B?ejN1ZnlnMnpIUkxrcjJybStkQXA4akVUUXdDSERVNVlQUU01clBQQm8xYkNI?=
 =?utf-8?B?eWxRdmNueDZhUXBKeXR4aXhFeXYydHVrOXhpYkp6Vzc4TXJqZmR5ZjFOMzlJ?=
 =?utf-8?B?YnhjbWNJaGo1WHl0WHdreG1Iam53cFdKM2dIRWNmWXZhWVBqQmZDaCtkN1Rt?=
 =?utf-8?B?NjNMTHRXb09XbjROQ0RLREZJMnAzVTloWWdEQ25yV2hGRU8wc0RMbndtSWhy?=
 =?utf-8?B?L2FnZFZJTFFZVXlvdWJzdEdJUUI1UmFmNkFKS0swYXFNZGRicFgvZW4yTEVV?=
 =?utf-8?B?ajhQQnV6OVFwRG9SYVVBS3JMblFXMHJhcEgyY0lwLzNaSkNzcVpoZkhCMVlx?=
 =?utf-8?B?T2JBV0ttc0JYYzhITTZmM0xITmhsdkVGcjFGb2gzRXh1TUJzUjVuU2Jld1Fm?=
 =?utf-8?B?SkorWVprY2lMV0hyUGc5ZThXbm96VjI5VXNrc2t2bDhSM2JjcnhQSlh4cTNM?=
 =?utf-8?B?enhBWnErYU9OSEc3Q3RreFFEcU1uL3R4NkFHNWVrY3Zmb0c5UGYvNWRpMkgr?=
 =?utf-8?B?aHgrRHhDY2lqQm1QTm1jWmFYN2ZrRldrQzMrb1Q1VjQyK0YvRXIrd2R4RWVt?=
 =?utf-8?B?MWxQMG01QUtmMUcrTFcvS1ZrbWIxSXU2ZW41RWs4ZEdNakpla3hGUU5oVW1s?=
 =?utf-8?B?YmF0ZDdtOXQxTUlsbHNVcllIbDk2VG5WK3RrVU9SUXc4dVFPYUtsY0t2UE5E?=
 =?utf-8?B?UXROYUtodmhwNEdaMmFIdElQVEo2bzlSc2Q3REdTVnUyN0YwTy9tWTNIK3FR?=
 =?utf-8?B?SFFQVE5BQVNIeVlkcHhBSTVucy9TM1E0Yi96cCtQRlFIYm93WHpYVkFKckJh?=
 =?utf-8?B?aDBWb1dWQjd4aTI3Y1VZVDZGTjNpY0V6V2o0UnZZZGhyYlp6VndQbTJPbUVL?=
 =?utf-8?B?WFB1UVhkYStnUGdyN084eG1nNUNSbjI1THJCTkEwZ3dvQmRxZ2xiRmIxNHA3?=
 =?utf-8?B?L1M4bUV6NS9yZDBrK2xGbWg4cEVmTmpuN1ZRVkRWYVJyeSt0UDNvdWc0TExo?=
 =?utf-8?B?dEMxSzZuaTZxTytFSGFwb1RKQThqd29zQ29SMi9FWGJINElLd1Uxa1Jxd3FC?=
 =?utf-8?B?cElYR3Zrc1JnS04rT3ZyejUwdTVqbVBUa2Nva3llZVlMQVdnRzFBZXRqSW1X?=
 =?utf-8?B?QTFEbmxNTGs2SnNOSGJUUm1KSkE5ZU1XWXovZWk4Vnc1dEFzVzNQVUhMbE9T?=
 =?utf-8?B?b3BjUmhSYWEwR1hjS2s3YlZmcGYwTnprY2NCVnJOMHAreWpjQ2FSZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e37602-8482-46dc-060b-08deac522a07
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:03:22.6489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSAaYkKwPFDd6XOxoHUUsVgevsuu7NiYt+/i927uDPzwoqOC5G9Dv2mNsn9zKo4MC45WSRckK5inAPvAGYZ0cWb3QYaB2tnkGR98vAOz2c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11926
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

Hi Julian,

Please follow the instructions for patch submission, c.f. 
https://docs.u-boot.org/en/latest/develop/sending_patches.html#general-patch-submission-rules

Your patches are clearly missing Cc and To recipients to maintainers and 
reviewers. You'll get less eyes on your patches missing those, and 
possibly they'll never be looked at.

On 5/4/26 6:48 PM, julian.haller@bbl.ms.philips.com wrote:
> [You don't often get email from julian.haller@bbl.ms.philips.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Julian Haller <julian.haller@philips.com>
> 
> Allow overriding fit,engine and fit,engine-keydir via arguments,
> enabling engine selection at build time without modifying the device
> tree.
> 

Nice, I like that.

We do need to document and test that though!

Please update the docstring in tools/binman/etype/fit.py to mention the 
environment variables that can be used in lieu of a DT property.

Please add a couple tests in tools/binman/ftest.py to check this works 
as expected.

I see at minimum the following tests to add:

- fit image (.its) without a fit,engine property, but with FIT_ENGINE 
environment variable set,
- fit image (.its) with a fit,engine property AND also FIT_ENGINE 
environment variable (with a different one), the one specified in 
FIT_ENGINE must be used,

> Signed-off-by: Julian Haller <julian.haller@philips.com>
> ---
>   Makefile                  |  2 ++
>   tools/binman/etype/fit.py | 13 +++----------
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 49d9740327e..ffcc639382b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1701,6 +1701,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>                  -a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
>                  -a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
>                  -a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
> +               $(if $(FIT_ENGINE),-a fit$(comma)engine=$(FIT_ENGINE)) \
> +               $(if $(FIT_ENGINE_KEYDIR),-a fit$(comma)engine-keydir=$(FIT_ENGINE_KEYDIR)) \

What if we want to use FIT_ENGINE without a fit,engine-keydir (so we do 
NOT pass FIT_ENGINE_KEYDIR) but it is set in the fit.its? Should we have 
a mechanism to "unset" this property?

I'm thinking, maybe we should check if fit,engine is passed via binman 
arguments instead of DT properties and ignore fit,engine-keydir from the 
DT and only take it if it's from binman arguments too? @Simon/Tom, an 
opinion maybe here? If we go this route, we also need to test those 
cornercases.

Or do we go the other route of forbidding both the binman argument and 
the DT to provide the same property? (in that case, yet another test to 
make sure we fail in that scenario)

Cheers,
Quentin
