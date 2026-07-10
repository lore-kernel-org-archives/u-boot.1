Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46523C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C366184AA8;
	Fri, 10 Jul 2026 17:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="km+PqQqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4EF284AED; Fri, 10 Jul 2026 17:34:26 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7C7F84A3C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSjhjJPkCEADzIFttUvPRy7junXJXRE2pYRkW9vUmElONxV/imvfEw3iQKARyevCrFA6HJblB3zZT8X2wMAHQrCb/AR43CCAcdExb2mtypniW9Qkz3sPuzwLS4vOYSL/VsaHAtpHGYflSh6cg2AJvLvu37LoRqgXsRKML/I+3BvHRotcgt4m9IszInaUJZ0dTZX7YKJqYElCOdAj6qo1vYGgnxUn5PuZj7JpUI174oWMZwoNkR2sDgzqp3fDXcYMpLtXfMDw8+l5Wblv7M+ogaMbc46S0YBOxfwx6cugJpRd9PTl7722MPZoLKXmMtBzXinf0UnAHv2Xl1MRMOy6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyI0EXC7BQpNfqCCeKMD5vsJdaqbeSrFUYHEDY08oXc=;
 b=Bmxp/WRkYOqZRA9XmCu0IRw32BZsug/PDjslhvBiudLCUBigOO6LpI0o8w+YjpuKsX9ooL04gYJT4VlVIuwjTytJWBg4skW/hDMp9XulUNAvX/1+bigZaRxNpTKITyu1tM7yLE4ytbFrvV2BvoLmiXRbH8sCiJ3Nl7dSTbkerpXQvZrn5sXW6spS+Iw4LX25odiNNJ4kdD8NceuU2X2DGGXpmyCnjbumfkIWMuLpweloVNMt6eTd5hjIFdf0G/SgVRTAmqihZY/OUSVu3CHNJdGmy0g+/qb26SexBdIa/vh3Bs5i9RfmNJlA+ZwRUM/2kegIsy4boQkt3Hsnft3e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyI0EXC7BQpNfqCCeKMD5vsJdaqbeSrFUYHEDY08oXc=;
 b=km+PqQqMMoay/4SdWoLAQdf3BOb9ugpJTMttq/byrh0qpBQUpRUG/XrhnEXO/6zUWvNIXi1V8R18oYJPDSwkUU3WIwiD7fd4I6WHdrnOhj1wxIZALLJAxoq7olgljmMbWVVChPsxVIj+4umpZmZQaE3+YNKxLEbLOHasTCtxcIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA2PR04MB10121.eurprd04.prod.outlook.com (2603:10a6:102:408::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 15:34:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 15:34:20 +0000
Message-ID: <3939b025-f5e6-43df-8fde-79bc6b4eb721@cherry.de>
Date: Fri, 10 Jul 2026 17:34:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: led: reject unknown LED state instead of silently
 returning success
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <ifny32czr2jodibz3wyerwqfjzbepdkt3tfhvgw5qp6ymm736m@kmqqewswdxqq>
 <b6336f00-4c3f-4cde-9702-353bf9a0f7fd@cherry.de>
 <za2nl6cv6cpqajy25eb2y5nvin2o6rkxotiussamspnvsdze5f@aq6ebysavqth>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <za2nl6cv6cpqajy25eb2y5nvin2o6rkxotiussamspnvsdze5f@aq6ebysavqth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B9C.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::634) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA2PR04MB10121:EE_
X-MS-Office365-Filtering-Correlation-Id: 83eca305-7c8a-42ca-1d4f-08dede98b64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Twf493DaKYAuHHtKZRg5SvfiTmj3RMMgnTBvCsUMxyuINkeaH0fRdTmOShUwgUAwWz5sX9k+cH3aqOd6TCOWqDUFo7TdS8gmlo9QPfhme2TV3VT6ExCa9+NOyVqx2+zW9cVXjU/3XiutBI8Rhx5HTTZtZ/kkKLjFXh4k7pTw2oV5dqy7rnPKMxpmDX4fw4L/lJtqbYeVznF7jOk2duehgSW4d6IKljI+vqvJcf2p/ZBMsZjCYxYuPCyeaOQ6HYTFM7ZPG6EfBQR4AdjmqMhjNMj8GxrOMdp1l0wyXrcpA+Z3B3oZU4mxtRduc+0sZToDSFYLyn0lujMk1PW9eKAuSpaWrEDQLFNEMILRReY2H508JdRKCMyhqtaD0oNiSg6waohNkBB0KtxfUdjoEcBGqyH1nSf4aCbaVFgbrgMYFd7BC3+CkuvVC0B7HQsnGfs3Hod0O04bKEseB367UoDm6scN5VYa4Mhw7KUeXztw5E2NMZOobmLKbKe8DdIQK+4sAhYuSPZGOhL3JAmHNiRpAJ5ONOT3ubTK831d4YvYruIQBmrGWWv7LYr7Y8LlF9DhnaFwDS8fU8Bv03iwiA6z6sZNfbHwugEc3J4HCZKM7nmUYynKd+mDvDXH+jb/fcj5csbEFG95Up7vU/6sJ4sMdeo2mmxjPMWwNvC/DA3ztxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJlc0dUUHJGUzRoRTdqN0lvem9scllLcm9vZ1Qxa1FCSmsxeHBzNTF3ZjND?=
 =?utf-8?B?SEdaVkdaWDJlL3k3Z083SnhBOVEwZXBOVlNVUVJYeHNHT2NOYThyUnJ2Ujdt?=
 =?utf-8?B?TFB5TVFmMWk5UUlXczNiT3JaVElUeFI2T3VGN25JQTVxaDZqSHgxK0s4QU40?=
 =?utf-8?B?a1hpUjU4dGQ3YVZmeTJiTWhoRDdycnVYZWdBT2wwbnExOEcwQUkwY1dVT0pW?=
 =?utf-8?B?L1JHcUNBQVdSZDV0VU9uLzhYMW4rYWsyZzBrNUM0L0xUUFBDeFBQSnU0N1B3?=
 =?utf-8?B?aTdZSGpieUN3ZG4wNnBZVU9pekFZNXVMN25XRjFRbDRSM0ZBcWlEL2JzWXF1?=
 =?utf-8?B?UXdVbVJTdEl4WWM0ZTM0T05nV0ZsTFV1UzVvWTRkamdZTmZxWUdTRUN3MlFJ?=
 =?utf-8?B?eXhlVzlKamVmMXAwN0xMbDRXcEtOcWRXZGRSSERIWXQ0bmVpeGd3NFRWRGs5?=
 =?utf-8?B?Syt3TTNubmsxSi9pbTNranJXL2I2MjY2RlVBVFh6ckVzYVdsVk9zR0kzc1J2?=
 =?utf-8?B?WW1iaXpVQjJ2MHhQSDhFemRDVHltempqNDdqNU9Rb25iRU55Q0ErempyZWQ0?=
 =?utf-8?B?RzQwU0hrZFNHcWYzM2gyS0tsUXVBQlVnV0RKZGtURGx6Z3hMeGQ0Z1kwV0Vi?=
 =?utf-8?B?cUh4VG5KUzJFbE4wcmwxK0NvZnA3Vm9iSjdBc1YxOGc3WkJFL09IdEc2TCtM?=
 =?utf-8?B?dkxaUDFMT2VKWFJqQWkveGJBNzk1emdMWEFzY1YvUlZTaDlYeFVMRXZvTEZW?=
 =?utf-8?B?RlBta1pZNnlGMEVBSEpab1h6akRQTDY1UHQzTDY4L0cxNEJvQnhpOEd3eGZD?=
 =?utf-8?B?RWxVWmw3dU1vc2lFSmExQmtoNTE0SU1FbnhUTHdsNXBaNVpnM3RKMk5MOW5s?=
 =?utf-8?B?QlhGUmpZaU01TUFiOW1oUll2eVFzRFRHZVBQeSsyc3JWUmdBcGZ0NGNURmFz?=
 =?utf-8?B?VVcvMHRhTjIxdWZlZE5BNkZaTFNZUTVzcTdhaHR5bm4wVm9vdUNVbHVETWlV?=
 =?utf-8?B?bzhkOXJ3SFNjTnNWNDh3WFhNRFB0SCtYUzFSYngzRUpjWHVCRGw2ZHYxMjVS?=
 =?utf-8?B?NVRkeXFiVnhVbFFFazJnMExiN3JOQjlHNnFwc0FMTjlETHZMOWtoaEJaTEN4?=
 =?utf-8?B?MDVUNDJBQzFGUDB4a0VLcG8wa3Y1N0lFcjE5cGFKSEdQRE1TVG5YMTkzaDJE?=
 =?utf-8?B?V2pHVnM0MSs3Y0I4L2dxMlFtWVR6dnVLSC83aW1tL1RWbXpVMzh0UzFQMzh3?=
 =?utf-8?B?RVJEMDRlblRZN2pGUmlzdTBpTUt3TEkwYnJUWUU4Mjg1WFRhZFpReDE0bWpS?=
 =?utf-8?B?NGpScE1GejVKZXVLRzlyNWoxTmxyMW91MGFDV3RNM240L1U2dWF2SStlZWlB?=
 =?utf-8?B?S0xQNjEvLzhHYituZ0pKZmpheCt2dk1yM25RYi9nei9FTDVmUjFWYVFOWkJk?=
 =?utf-8?B?bmN1RHF6MjZ5VXBUNVJSWFlWakw4SWhxdXlRTS82Q21CZ2dRRlp5R1ppb09F?=
 =?utf-8?B?UDVxVDFVSXZhejhOMjVvd2tNU1dpTnVYdXBlTHFLems5d2FlNTZvY3ZEL1Bt?=
 =?utf-8?B?dUNNL1c4RWd1NFA0Sk1jWDVBQTZlMjdlSzlCT2UrUG9ZVEMwWkp6clNzQTRl?=
 =?utf-8?B?SkRVYUR6SFlFUGVBNlg3aDNaTzVYUUd5UTVhYmU3N2RwbmZ5Nms3ZXMwYzBV?=
 =?utf-8?B?eGVKYmFMVFduR2wxSGhrYUZmVUZHTi9GQ25TUTdRb1pQNExnZ24rOXdnNXlZ?=
 =?utf-8?B?Q2xQK0pOZlRIYS9CUnpaSTdZTU5uMndURktWVEhOOUc0K1dKSE50S3ZaUWpk?=
 =?utf-8?B?THpqYi9ScmhHaUptbWp0OVdtc3FmOFlIQVp1SGFHMWwzbXUzTU1Ha1FhY3N1?=
 =?utf-8?B?cUhCZWNPaGZHZ1VaUmRkKzZoYjRIYngvWW9vQndOTlp4TUhtTmIvaDV1c3dn?=
 =?utf-8?B?L2hBYXJGWUszMVBTYmFXT00vMEViSVVTOEJ0RWY3dW1oNTlzRjQvWXk0ZEZO?=
 =?utf-8?B?MjVqOXd1WVFkcXhNOUwrZ09UMlFzT3BGZkZrSHY1eDVIeng4MmdTZldkV1RX?=
 =?utf-8?B?YnZxUUpLYldxS09jc0NZSHlpT3JiMkd4MEpYaUg4UnRtREhEWVU3aWVNM2Rx?=
 =?utf-8?B?Q3lKUE50N29XWWR3QkdXU1hDUUlGdm9KVi91bncvNXlxY0VoM0ZOWG9UMGJa?=
 =?utf-8?B?SmJHMGNsOVY3Z0VJYXdPTFRVempZbGZ4ZzRwQnVNcEVrUUVQSWpyM25kS0lx?=
 =?utf-8?B?NjJob0NIZXBvQ2MzaktTS3lYY1pKWEFkelduZ3N0UGNZTVF0eUxOK0ZmWE1N?=
 =?utf-8?B?SzNCWWlGdndZZWw0MVlrb2FzR1R0SXQ0eG5McmI2NW4rbEJsTlZlZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eca305-7c8a-42ca-1d4f-08dede98b64e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:34:20.9064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOrQs9UZMpWZ9hOhG5l3KXp9kVDaTE5tZoqK66nRu3CtrfLD/rxR4EjcDuO/Q53qOt0Hrh2SCjdGwPm1OiBNj1oQ7b+UY4z4NkagCTFiy8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10121
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

Hi Naveen,

Please do not top-post but rather answer inline, like I'm going to do now.

On 7/10/26 5:16 PM, Naveen Kumar Chaudhary wrote:
> After the commit 72675b063b6e changed led states to an enum, I honestly
> don't see any problem (others can correct me). The current

Well, if we add another operation to enum led_state_t without adding a 
new mapping in state_label[] and the user writes e.g. "led 
does-not-exist" on the command line, we'll have a null-pointer 
dereference in get_led_cmd(). So today it's fine, sure. It's not 
future-proof though. We can add a simple check on state_label[i] being 
non-NULL before passing to strncmp and this would be covered.

> implementation is more readable than if-else ladder, specially when the
> list grows for whatever reason.
> 

I disagree but that's matter of taste so I don't care too much here :)

> However, thanks to your comment, I went through the implementation once
> more and found that the below define in led.c seems leftover and buggy
> to me and needs to be removed :
> 
> #define LED_TOGGLE LEDST_COUNT
> 
> Thoughts?
> 

I think that's a leftover from the legacy LED API that we got rid of 
last release. It's not used anyway so can be safely removed.

Cheers,
Quentin

> Regards,
> Naveen
> 
> On Wed 08 Jul 06:00 PM, Quentin Schulz wrote:
>> Hi Naveen,
>>
>> On 7/8/26 4:32 PM, Naveen Kumar Chaudhary wrote:
>>> get_led_cmd() searches state_label[] for a matching name and returns
>>> -1 on no match, but its declared return type is enum led_state_t.
>>> All enumerators of that enum are non-negative, so the compiler is
>>> free to pick an unsigned underlying type (and does so with
>>> -fshort-enums, which several U-Boot targets enable). In that case
>>> -1 is reinterpreted as a large positive value and any subsequent
>>> comparison against -1 silently misbehaves.
>>>
>>> In do_led() the returned value is stored into an enum led_state_t
>>> and dispatched through a switch that has no default arm and no case
>>> for the sentinel. When the user supplies an unknown state name the
>>> switch falls through, ret was already set to 0 by led_get_by_label(),
>>> and the command reports success without doing anything.
>>>
>>> Return LEDST_COUNT from get_led_cmd() on no match. LEDST_COUNT is
>>> already a valid enumerator, so this avoids all questions about the
>>> enum's underlying representation. In do_led(), when a state argument
>>> was actually supplied (argc > 2) and the lookup produced LEDST_COUNT,
>>> reject it with a diagnostic and CMD_RET_USAGE; the existing
>>> LEDST_COUNT switch arm continues to handle the "no state argument"
>>> case where it means "show current state".
>>>
>>
>> That looks correct to me, but I think get_led_cmd() is overengineered and
>> actually still flawed. Indeed, we iterate up to LEDST_COUNT-1 times on the
>> state_label[] array, but nothing guarantees the array is that big (it is
>> right now) so we could theoretically have out-of-bounds access in the
>> future. It also isn't handling the case when there's no matching string at a
>> given index (e.g. holes in the array or padding at the end due to the last
>> element in the array not being LEDST_COUNT-1), where state_label[i] would be
>> NULL and strncmp doesn't seem to be handling that case (it isn't in
>> lib/string.c for example).
>>
>> I think the answer is to instead get rid of this and drastically simplify.
>>
>> Remove get_led_cmd() and state_label[] and do something like the following
>> in do_led() (NOT TESTED):
>>
>> """
>> diff --git a/cmd/led.c b/cmd/led.c
>> index 296c07b3b38b..d1fc9dc8cdbd 100644
>> --- a/cmd/led.c
>> +++ b/cmd/led.c
>> @@ -9,27 +9,6 @@
>>   #include <led.h>
>>   #include <dm/uclass-internal.h>
>>
>> -#define LED_TOGGLE LEDST_COUNT
>> -
>> -static const char *const state_label[] = {
>> -	[LEDST_OFF]	= "off",
>> -	[LEDST_ON]	= "on",
>> -	[LEDST_TOGGLE]	= "toggle",
>> -	[LEDST_BLINK]	= "blink",
>> -};
>> -
>> -enum led_state_t get_led_cmd(char *var)
>> -{
>> -	int i;
>> -
>> -	for (i = 0; i < LEDST_COUNT; i++) {
>> -		if (!strncmp(var, state_label[i], strlen(var)))
>> -			return i;
>> -	}
>> -
>> -	return -1;
>> -}
>> -
>>   static int show_led_state(struct udevice *dev)
>>   {
>>   	int ret;
>> @@ -83,12 +62,24 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc,
>> char *const argv[])
>>   	if (strncmp(led_label, "list", 4) == 0)
>>   		return list_leds();
>>
>> -	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
>> -	if (cmd == LEDST_BLINK) {
>> +	if (argc == 2) {
>> +		cmd = LEDST_COUNT;
>> +	} else if (!strncmp(argv[2], "off", strlen(argv[2]))) {
>> +		cmd = LEDST_OFF;
>> +	} else if (!strncmp(argv[2], "on", strlen(argv[2]))) {
>> +		cmd = LEDST_ON;
>> +	} else if (!strncmp(argv[2], "toggle", strlen(argv[2]))) {
>> +		cmd = LEDST_TOGGLE;
>> +	} else if (!strncmp(argv[2], "blink", strlen(argv[2]))) {
>>   		if (argc < 4)
>>   			return CMD_RET_USAGE;
>> +
>> +		cmd = LEDST_BLINK;
>>   		freq_ms = dectoul(argv[3], NULL);
>> +	} else {
>> +		return CMD_RET_USAGE;
>>   	}
>> +
>>   	ret = led_get_by_label(led_label, &dev);
>>   	if (ret) {
>>   		printf("LED '%s' not found (err=%d)\n", led_label, ret);
>> """
>>
>> What do you think?
>>
>> I wouldn't necessarily add a printf for when the user mistypes, just return
>> CMD_RET_USAGE where we list what's possible. If you really want to keep it
>> at least replace "state" with "operation" as it's something we do on the LED
>> not its state (e.g. one can request "toggle" which definitely isn't a
>> state).
>>
>> Please also add
>> Fixes: ffe2052d6e8a ("dm: led: Add a new 'led' command")
>>
>> to your commit log also as that's the commit introducing the error.
>>
>> Cheers,
>> Quentin
>>
>>> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>>> ---
>>>    cmd/led.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/cmd/led.c b/cmd/led.c
>>> index 296c07b3b38..d547276e480 100644
>>> --- a/cmd/led.c
>>> +++ b/cmd/led.c
>>> @@ -27,7 +27,7 @@ enum led_state_t get_led_cmd(char *var)
>>>    			return i;
>>>    	}
>>> -	return -1;
>>> +	return LEDST_COUNT;
>>>    }
>>>    static int show_led_state(struct udevice *dev)
>>> @@ -84,6 +84,10 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>    		return list_leds();
>>>    	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
>>> +	if (argc > 2 && cmd == LEDST_COUNT) {
>>> +		printf("Unknown LED state '%s'\n", argv[2]);
>>> +		return CMD_RET_USAGE;
>>> +	}
>>>    	if (cmd == LEDST_BLINK) {
>>>    		if (argc < 4)
>>>    			return CMD_RET_USAGE;
>>

