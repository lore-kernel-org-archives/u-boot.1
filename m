Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95856106289C
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08C783F8A;
	Wed, 11 Mar 2026 14:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Gvelz82t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C7883FB6; Wed, 11 Mar 2026 14:08:43 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFF383F2A
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aasntT0/va3nyfi5KcaH7KBpDZ1jedMKe5GpO9pHzxYbWzxneKM7iIRqYijrH5B39RgzF3bOI8kUKO5oypfFXgysXfxaoVH/vKAPObe3mog/ErOMTdj6kN7dAMYXfva2YQS3UNA4H/nmNVkOTi3m0HAFFqQSGGb2q14Hah6J70dBsWZKvcfE9f6te9gNPkqvEFxotebOchsXkwdfjj/pMGywB7zIJye/qqz3OuxLaTHGpbHfQh1EfF86eMVMnVG6/WkdboFaSaPif0mflX1ATBN85SKzlxbLMKqns2SNRtONqqGRM0wIIxjNL8MF2UKU5BBkqSxZ24vVL/lWOfl9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvFKxYU46EDg+3Vy6PyHYD7s7ZPWwqh61b0xkGNzWQ=;
 b=rG3Ysl8RNax85Q8dAbCnqacp12arHPkLwO19xA7t/BqdKYh6OAh3p3w7arLQ6f8GNWNpjNNzyuXO6tJOPgSLzcPBtbIdBQsWw4CIbeMOuukJ8wguxMx9H47DezJS8m0hJEVMXOcYNzxnqlyFmmg85gW4xeSy/fMukJuWK/stT/L9TPYafBCi7aXX+jIVHdGSqr6in+s/nTfMdm5bjaG2R7XOiHRYxUsrowLTvDEFNffta08/R2LqzERrKVkWlSMPAZN9nglkTqa5/DUgRuntvOQhwmE5pSJKBplxUCZLsqdM5gqKUm3smU0psjbtPxcqIRJKkekmBExG096g5ZzAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvFKxYU46EDg+3Vy6PyHYD7s7ZPWwqh61b0xkGNzWQ=;
 b=Gvelz82tGKnmO9nvkOQhFznv8/F+Kucw1PCETXXiPQi23F3dd6/1WwOD6Jwt5c20oaXCeVTFrpRz1NqTCErlRW0IBWRq7boMUH2E3Ty3nRLHBWwTSwPu/nfAUQcvMNBqR4OVaKDPsqG4qbYHinCtHDPRoxnY9b5DlWo5MEjBFfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 13:08:37 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:08:37 +0000
Message-ID: <abd3d7c1-b56e-4639-85d8-3083f9d0842b@cherry.de>
Date: Wed, 11 Mar 2026 14:08:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: test: allow using [ as alias for test
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-2-ravi@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260311120910.3934114-2-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cc0ca1-3407-4876-1ddf-08de7f6f4f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wy76QTjZpGXcBuRKePc4WOQdGA+TAl5Ix26nnuKDU6sR+2a+zlVtoISJYeAfG/XWhQkBMjy+Qx5ILbTACWONs0T8yiipVEoXolZWrs4ytAtmXi10cvWHebb35mVQY6pGjkaB89/yeAlZbewdjjSus4g9w3pid4MJQIbcSW/MXy0C2Icdeo260qC5QSfsFJLTT1BRq7oq2NtajLvpWesuD8lB9CflESJ8tMiJUP/mHtd3XCC1o8T84nviYk9FKmLJToAa9xiWlf0LaxDUAjtZXwYybweIbo26ZAPTbiU5W8B3iwWpb0ZNmEXLxLvRGjgb5GUE/EMf3sZT4+bvkj/4Hb573XgIPcpMpxn4PW9Qk86ZF1nYqHdi79T4PBKR9x9+zVtTTPsJcIOqtZZKioEnvgJlgqR50G4WADwb2nAtu6GD9TG8Ltg0Gz6aExZhA3JwmH/4Hx2fHuAmNSEQWHgGcmQJoWwiFsKdqJnPHMigARAq/xiPRW1D1CPWYaW0t+l7A0sZTtqjXIE2/z4a7UsdZNeZLkicl3wsGcM3LVrA5BMLBtOfm/NhSDoORdbx/XhlqQVZX+KtPtJzu6V5+fOHOenQr1CioPxZ1piMi8pf1aSlhTlugm8MSAtAWPN8kjTskwYL7eljVlh9U8Fv4bYipsTNKdmerOlP7RwDIv6VZZqIq6qBxI8lvR3tx7Q5HVMH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJjdnZld1hhaExFRk0vcG81UW5SVkdHWVFxMVdmNGhMQlNYaDhhRlY1RkE4?=
 =?utf-8?B?U2dORTE1UDhTbDBDNmU3cUVIVHhqU0phc3lXNEljUzFvU3hsajN1WVQ1ZXhw?=
 =?utf-8?B?OTlmeHBNZHZPTFlXMnZvZVdJNEdEamh5b0tKMjJJclBGRHl1eDRhZDJFaVpn?=
 =?utf-8?B?d09XMHI1cGt4VDlWOUQybThhTktjYUNXMkR6dmRhTkx0eFRqZXY2a2haYzR1?=
 =?utf-8?B?WVZrMzI3NjBieVNBY1huZmNTKzhHd29DMWxtbHpkRVRaWitBbFp2eTduZXc0?=
 =?utf-8?B?T3k2YWhJcjFiNXhqb0tNVEc4c3M2YnVvckxaT3ZYblBXbzFIYUNIWEhYK2pa?=
 =?utf-8?B?MkJhVVFEaFBpVWJiOU10eTNvbWZZQ0VhOVFxb2Q3WTRyY0EzYjA2WVNGOGZN?=
 =?utf-8?B?TTM4K1Z4Q3doK2hXTzYvM0FRbmZxeGZPZXRWbjk4VEFIOUdMR3N0YzZnT0Va?=
 =?utf-8?B?SFpHVEEvMitCbkFnNkwreFVGNWFsbkZQRmcvNmhuVEU4QnRvS1oxTmVEemc4?=
 =?utf-8?B?ZTlpNlpFR1l4QnBmRUNFdjhYVjBhTFY2bWh1bnFNRnZoV3FsNFNteXdXd2dZ?=
 =?utf-8?B?Y1ZBTGJBY0dpbDIvU1lLQmVWc1R1TVJhMGltL09INkxidkc1aUUvaG1LMVRE?=
 =?utf-8?B?cW96OCtNMDBTR2xvMi91WjBBa1UxRCtQeUFudGdFZWN5dWI5ZFMzMmNwSUJ5?=
 =?utf-8?B?N0hVR3ZCVC9ySjVhaWR3ZVhOY1NlVVBiemFUekRnMlZBMUhBTkNudnlWMmhS?=
 =?utf-8?B?MHFDSlRFbWt3c1ROdzU0SEFFdmJiMHRlU2lQUXpwOUNHV1NQT3hLN2ZrTGlQ?=
 =?utf-8?B?NVF0aEdYYjk1MUN4RHNUbXQ4Qk0vTlBNYnBKQVlSS1d2Y1lEano5UEJGNkRZ?=
 =?utf-8?B?dDVjYVBkQlo5VUtpclJjalNjMi83S2t1RmhYQ0QxY3ZacHZhZkEvRkZwWmdB?=
 =?utf-8?B?V1QrUWgvSG14MDVzMHlPM1lBaXVrUXdrOUNyVlJDUEN4ak5YZjcxRG9YUjYw?=
 =?utf-8?B?NHJhaDNUUExzZm1xd0NXdkw2dnUzMmF6cVlnaitWTlJEc3k4UlNrZXZaaFFT?=
 =?utf-8?B?cGxaZ1VaVHlDbTlONi84REE2YzcwSGI0QWd0SjZXTWFFNGlKRXA0a3AxMktn?=
 =?utf-8?B?Z1VPeXRIRFdiN2JUa0dBMzZaVWRxaWlGZHR0a0IxY0YvTnVkYjE4QitpVG85?=
 =?utf-8?B?SktPQ01Oa1ZzZEdLZVlRTkNDNEx1S05ZZUdEaU1PR0Vybkp5N0x6aVNFNzRL?=
 =?utf-8?B?ZHlvbkNTaWY1Z0hxTkkwSGd6QUxDQ0FNQzhqMCtOZzlHU0szQ1RLdGdSdisz?=
 =?utf-8?B?OUFSWGNnYzBxUWliSUFIZmNGOGQvVWZCQm5EWElJYi9CVjJpWFFFaUJUTWt2?=
 =?utf-8?B?TEtCMzdDb2tCMGxKK3JaZ0MxQnBQVmN4V3JQM2FFQ0szK3h0dFYwdGNYc2dn?=
 =?utf-8?B?d3pHbmgwVVNnWWErc0pUeWpVdmxoOURhM3Q1QXVGem8zb0xMbTJ6NVdBalo0?=
 =?utf-8?B?cnZ3cmpYOTEvcHNzaHlsTW5XSlFHTzRqMzA1RjdLSXJWUjgvdllRRTBmSVdv?=
 =?utf-8?B?NmM1WWNXc0xwTGN0Ny9XVGR4bEhmV0lDZjM1dmIrNThQQXdIQzIvSEkvRVFR?=
 =?utf-8?B?NjJWaFh5V3NSSVQ2Z2xLYnNQUTliN3l5aHl6V1NUbnFkZTkxYmpPWHAvdzBX?=
 =?utf-8?B?NTYyeWhaa0gwWElUenlBd0lnWFR4b0c5OHNDdlhWMXB2dDY2YXNrNWZ4WDFI?=
 =?utf-8?B?VGl4dzhHeHhib3cwdU1lY3dleCswdDdUZ2ZscktOZ011RUFUR0F4V1E5SHQy?=
 =?utf-8?B?NFlZc3haSGJQcGZzcEhlcVppMU40bTdHaUx2NjRWc2VhaVF5VzU2ZXlUaUY5?=
 =?utf-8?B?Wi9VbVhpZUxqRVRXNC9yZVNpdnJHNkZ6Sm9KejZDWStVeE42VkJIZHo4WWdw?=
 =?utf-8?B?UC9EOXBhZ0JsK1B3NnppbWd6a3owWElISE9IaE5rNml5VkMzaU1pVVFzZXNH?=
 =?utf-8?B?R1VxMk9FWWFtVzhTNjZSRFRjdmdjVnJHTUova2NSbUhxRkR1SnpjNTFxVDdT?=
 =?utf-8?B?dGM1ME5LOTVodGRxblhwT3QxM09JejN0TURmR0FVNW9FL0E3U1RCcm81MDhO?=
 =?utf-8?B?R0pYQWhnOHZ2eVBaeWtZWVdxcjdaMTVBaEZMNys5V1Zza0x6eEUyTDdPYTQ5?=
 =?utf-8?B?ZXJZdk03WW1lRWk4ckFRS09DMDh1U0krclJSRURFWmhUWmNmOUdQTEx0RjQ0?=
 =?utf-8?B?WDNsSHdYeDVDQVhOdVc0ckdxRCtXUWlFT21iM01PSGlwRVp0TTNhVUJtOGh6?=
 =?utf-8?B?b0ZvelJTTVhFMlN1bVBPMDMraEZsWjA5WDNIMGpScE1kQ1BXMkFLUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cc0ca1-3407-4876-1ddf-08de7f6f4f01
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:08:37.7970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06TQGYBasdfki0FL2vOXkUCc84D4ufmb2wLcm738gVnS98aec3GxvJqmPnKNpj43Mgm+dNw7AQ4FcR/erCiQI3HDC5veTkK+tsM9fvB3y6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841
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

On 3/11/26 1:09 PM, Rasmus Villemoes wrote:
> I often find myself writing something like
> 
>    if [ "$somevar" = 123 ] ; then ...
> 
> only to realize that that syntax doesn't work in U-Boot shell, and
> must be spelled
> 
>    if test "$somevar" = 123 ; then
> 
> It only takes a few lines of code to support this POSIX-standardized
> alias for test, and helps developers focus on their actual problems
> instead of dealing with such unexpected quirks of the shell.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   cmd/test.c | 19 +++++++++++++++++++

Please don't forget to update the docs. It still states "Unlike in 
ordinary shells, it cannot be spelled [.", c.f. 
https://docs.u-boot.org/en/latest/usage/cmd/test.html#description. The 
synopsis should also have a few examples using the new syntax.

Another question is if you have thought about/tested multi-expressions?

e.g.

[ aaa = aaa -a bbb = bbb ]

and possibly also

[ ! aaa = aaa ]

which I'm assuming should be equivalent to [ aaa != aaa ] (of course 
this test doesn't make much sense, but there seems to be support for the 
-e operator for checking file existence). I think adding tests for those 
would be nice too?

Cheers,
Quentin
