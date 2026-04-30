Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D76CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58E184658;
	Thu, 30 Apr 2026 10:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hYiuBhtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D61784661; Thu, 30 Apr 2026 10:39:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8918460D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOkvI3fyUMKsK9sEG4aCjx58FRasZlEfTxDQ9BoCWHBoSyxLFK5EWOHwJPpghSswJIm8B111Q+AhW5ggJmGETQC4DNeVA1PDRCECpsWnB9h2KtrkDVSnMoCxmfj7oHHszq+lRFpazZM0EBkZdbQI47d9j+F84xEWcyDYmxrl9kRw+ykldF8rhXIlT/uXJ+66uRSEJom9L/5lryTsb81x93L3csZyd/eL+upc8UuolvA9R+iYwj3WgGdjxOaXPZPnVap3Y7xlX9EGc4TLQ4IaCh335mm1bfMLwXFqAL4gKUqytkwdCoGKcfiumgRXNH8QLrbGmIlpo2d9uyEhG5ESxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyYwZfHJKo/12fx9NsJMZ4ToCvxdKeFCVuPeD0Lnl38=;
 b=WSIYTuueHoddoJfyD1a1wFnTmJu4saDi8iEFDZ/hWu1PNDVW3nQ5sbVUoMkM2sdkl2MKn+iVJT6lCR7qpHAUws6VRU8737a4/qGYOgKAcu1QumJz2de1Jtff6Gdm2jAMYQY8aCUF4t6LNr+iyLw0HUpwWsnReTzPl8a5OCi4bshcp469tPrqrdag/X6NDLWBFioiCpoeeJt5hDNRL+cR+YMLCBv1TBUN9dQn4nZQUpZeXt4TDPERuGwYLlcZaUlo1LLhdk5q5dHgkUgZese1CN1QAQAyDX3+LoVXWbHcqvJc1IOSOJdi5pt4Twwxyys8fY4ICzGOXMLxIE3bXo/fIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyYwZfHJKo/12fx9NsJMZ4ToCvxdKeFCVuPeD0Lnl38=;
 b=hYiuBhtUiK+f+kOcjb98Z2xqVc6E6sGmNDEIHkqEvShXJOiwToTvnY+y9ie2Wamv/Fb1obbPQIG+2G+ZBj4OFcwoVNUSNqsvVQOMgLqt70ALlDIbo2Bt5qbYZpDKNcp87hniXBt/5Vwu9OT0jvhm4poyohnJsZoQ+xbSJuWC9lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB10917.eurprd04.prod.outlook.com (2603:10a6:150:210::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 08:38:57 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:38:55 +0000
Message-ID: <eac3ccea-c465-4cc8-a46a-6f828017cd6d@cherry.de>
Date: Thu, 30 Apr 2026 10:38:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] usb: onboard-hub: fix compile issue with gpio.h
 import
To: Mathew McBride <matt@traverse.com.au>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
 <CAFLszTh=NVKYe2NS5t_kj2t9C+3oCfUqpY919fqEr9jyHgpN5w@mail.gmail.com>
 <35038a9a-fa5a-4f9f-b34e-17cc80a7824c@cherry.de>
 <0f64c232-1f6d-48ab-bb55-379f50245458@app.fastmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0f64c232-1f6d-48ab-bb55-379f50245458@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000912.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::936) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB10917:EE_
X-MS-Office365-Filtering-Correlation-Id: d5efdb44-305a-4f15-cffe-08dea693ea65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vjTrjzgZM87kOVB2wbWj+udNu+12e494xuk8Xw43Akh/5AQ8qVGRXLEahWejAdyiKy9WtP7iV7LY8e8BGHpq79ZdBXyiVKG7c8ZSsQcTj4UAtO3rKx4DkHDnQwA37pc4xSeMDC4jaiDuTObna6EtwrTxSaoL9lfmffXuWLyphzS//gYKDCbeig8HKtH/bxQeaGKSKvjsUu9k05wOaj9/EwH64nYYIzvL8cjMZ9+GBkGQv3NWd4Zrw1AKPsSq49KHp1a+tshZbRQx5s5RsCu1eHTEmbyb0TKWZd9ZalGCMbNBWi2DVhRkcs0Wan92Zevg3RgQA+Mngtit80w68KkT+FeU9q6xvwWq+0jrUepHJBxFsKtUPIj3KZNOliNMS5fHUAPMutLTWpnfbSurq/kLh4ZTm3kKmCi1HkA3CwPnMdKc/4HjIlqoj/uMhgFE5BSbrHVEVp+3g4k9uHmMb+kucGo5a0hBlcZdRZU7z4ASMnO4B4iNoY/QOSmDKTsPwx3bBntMDSQDvJ84GjE8PYMer2nmxE8U4+5hwcOiIdcRE1vXsh0fE5GYsWb5F1Z3jKfx0CeRXprtOcap3IJGu5U7pkEBdbS1vWyQzXJYUcwy7XJK4cZvxgdM4WYtqFAOn1FWfCY1ZyDY94SON9NaCchmEBVn5sf4aks3pBEzI0hfaEmD776eHzWaLfabeTEPHK3haf65HupACCQtH2A4jDc/Axw7t0hCAhGyszFJ2zhoVTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJOamw4TjMxaWptVnN5ZlI2YWsrR3I0TGRYL3g3RnI0bGtJMTRIM0VPdEU0?=
 =?utf-8?B?UDNubVRwRmVZeXdiZ0Z1YWtROTRHUE93bkZQNmVQUXpXQW9JMUsvVitUbW0w?=
 =?utf-8?B?U1plc2dmakgwdzZDdlY3YUI4QXZCS1Z5NkpodS9hMldwZmVrQXNiRVh3ajNF?=
 =?utf-8?B?djBQM0JueklhazRQVGF6RU1JTlRIN040aFpWazVnU2dzSUN6VGEwNFNjQ2tU?=
 =?utf-8?B?dEZvNUVjYTlOZGxsMFpnWmZDTDhIY0wzSUpZbFFTbE91MTJxZHhlWDI1N3Jt?=
 =?utf-8?B?UEJwU3VBeU1RNHFYeDk0Nk9qOFpidFJ2bFplMm9jZG00TG1BWHhSVExLSFJx?=
 =?utf-8?B?amFJL1R5VkV2am1uYWFJdUN5a3lTSkVBRXpBb05INjFmVTlHa1dBcE1GRm1M?=
 =?utf-8?B?UHpOM25yZnZ3Skw3OFRrd2NiQ0JKTytXMm4zMThUVEN0eHEwTnN1NGh0UEFy?=
 =?utf-8?B?NmVRbUUxRzdlWTU0TGZCdUFWM2h5dWIvMTNOd3M1bkhrOHJ5N2hMRW5CN1Vh?=
 =?utf-8?B?ZjZ4YW8wNTNpUHdsZFl1dUt4dFBUd0JNa3phM2E4Q21uNlFZVURyTnpESVZa?=
 =?utf-8?B?R0NwdkRTQlM4cVI0b3I1WkE0U2JHSHFjNkNlbTR6TjlqYk1LTUUvenB6QWpW?=
 =?utf-8?B?UEhaSVRFN0VsbU5NalkwbFJDK1hqa2xUK1VMNFBpR3VVV2ZpSUJyNldGMW9J?=
 =?utf-8?B?VmgvN0pwaHc2alNlaWl1ZFM5S0ZtdENUdlBweGlheUp3NHdGY21NcFduTVNP?=
 =?utf-8?B?SHNwcG5ZUFd3ZGorTExqR3dLTlVhejJkS3BtbjhodklmTVNYNCtTTWpmUEhw?=
 =?utf-8?B?NkFJUXhOYXdQeEJPY3ozeTRBTVJTcXcwVml0bXczbTZjZ1MzNE5LMHJqdW1H?=
 =?utf-8?B?RmxCdkViQ1ZJTWVvblcyV3JIWGxiMXZlQmFqTENwVjNwYlBNeWZSQ2JDbURz?=
 =?utf-8?B?TWVFQStJWCtiOHZXekZ5Z2gxL3RTSjNsVTdjTVc5T0NIVjRsYUMwR2pDbTBS?=
 =?utf-8?B?YTMvZHVmQkNzc0dySDJUek90alY3WnZIeWZiaXE2dERGNzduQzhTZUk1TU9P?=
 =?utf-8?B?MDNMd1gvdFVFa3I0TkNxVmZ3bG43REpBR0R1eUpVZHN4Z3IyRnFud09VNnlH?=
 =?utf-8?B?a3JHQUw2aG5oL3NMa0RwS0hQdkhyRTNxOGhCeHNLVndaWDB4dUttZUtJY0ta?=
 =?utf-8?B?cGdhUVgxUi9PeGVuZ3NDY010RDFsQlNsaDNxWUd1N01rcjFaMWlsc2ZtZGZ5?=
 =?utf-8?B?NTM1SXkwcFhLMEF6NEtMNkZ2OCt0QUtXV09TczZzR3NhTS9WK0xTMm1saFRF?=
 =?utf-8?B?RW1MbThRVERMWnpxRmRieldabThTMldqYVprTXI0WmlodmVGdDYzQWVtaUFo?=
 =?utf-8?B?WFdYVEt2dTM3bFAwVkFCcW0vUzRoaDkzbWVta2VtcnQxRHZqVzVtcHMwMGFW?=
 =?utf-8?B?UHkrRFgwcHVlTzBiNlZ3R3d0WlYyQlRFc0luRHY5MDZBakFncysyZDRhMmsv?=
 =?utf-8?B?d2UvK2F4QjkzQ0tDZjN3VHVub1F1eXh3bE9SSU9OREE4U00wWEdtOFFzUjQx?=
 =?utf-8?B?aS9sSVRoTGkwbytORkltdVRPc251Kzg0TEZBZDFaWFZMSFJRMkRhSG83N3Fn?=
 =?utf-8?B?YkVPcUhXL1A4cTcrcFkxR0ZhODNDK1FacGo5anJVQWErWXpxYzdsNVlLNVFB?=
 =?utf-8?B?YW80UzlWdE9JQkdYcjZpNFBhWGszeVpsb2wxOXpPenBaUFZTbHNMTi9TV3Z1?=
 =?utf-8?B?enhJL3JEclV0cjZDYWE0OFFvVEtiRjFsZ0E4eUFOSEZkbmtFa1BzK1ZoU2Fl?=
 =?utf-8?B?WlVVRzJsMzFFYVF4N01veUpvK3M0bHNaSkhhbnkrU2p3U0tqWTNRTGh6Ulh0?=
 =?utf-8?B?eHRFeG9qeGEzS3JRK3VQS21ZRk1qNGlZUnBkaXgrYTN5K1lCSjRzNk4yaFI4?=
 =?utf-8?B?bWtMMUJBOElZNSs1MDJwM1FLS1d4cTl6RDFpdkVUQThHN0hkc2FLd1lWVVht?=
 =?utf-8?B?a1lHVGtrbmYzanZ3VkVwYU1laEM4SkZlanZBamlaQjBVa3Fld1R1UFB0elBn?=
 =?utf-8?B?NHpudTRJL3pEQkllcmNNR2U0V28yeTE2U2tzZlQ1cUdUYWRMSkVBc2NNb3RS?=
 =?utf-8?B?cVBLVnpDeWRFZlhObVpKcmo5N0xQcmQ4ME52V0FGQ214RWVYRDRUdFY0NHhD?=
 =?utf-8?B?Q0ZUYjVsYkpEajhpOW01M3RaUnNpWmRUeEkvNFZ5RXpraVRmSEtVNWRjKytG?=
 =?utf-8?B?MjJxSUdrVStkTDhOMWNZRlNiK1Jkb0NaR25tWEM4Q3c1dUFyNDM1T0FNdFZu?=
 =?utf-8?B?ckVNRko0cytWdnlGNmRTYmZKNnZFckdoT2RwTWVXMWJ5ekN2SGoyTklDdHBr?=
 =?utf-8?Q?iV7b/EmPw8i981wb/6kPrQYWqSafF7vD0DYeb?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d5efdb44-305a-4f15-cffe-08dea693ea65
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:38:55.7680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO6QvdW0xfU9uvfwcRXjNpUqu0c2cym1V/7lhxuFwdrT4UF5MF9YFaF2/Q9PmIelOBp6yfqK4blxFPPmJvKH3n+ieiE/j8qGzNbUdgPkRdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10917
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

Hi Mathew,

On 4/30/26 5:08 AM, Mathew McBride wrote:
> Hi Quentin,
> 
> On Sat, Apr 25, 2026, at 3:55 AM, Quentin Schulz wrote:
>> Hi Mathew,
>>
>> On 4/22/26 3:15 AM, Simon Glass wrote:
>>> On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
>>>> usb: onboard-hub: fix compile issue with gpio.h import
>>>>
>>>> This resolves the following compile error when compiling
>>>> ten64_tfa_defconfig:
>>>>
>>>> In file included from ./arch/arm/include/asm/gpio.h:2,
>>>>                    from common/usb_onboard_hub.c:10:
>>>> ./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
>>>>      17 |         ulong addr;
>>>> ./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
>>>>      18 |         ulong size;
>>>> ./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
>>>>      19 |         uint ngpios;
>>>>
>>>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>>> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>>>> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org <mailto:%2Busb@mailbox.org>>
>>>>
>>>> common/usb_onboard_hub.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Only received the v1 so commenting here again:
>>
>> Well, it doesn't fix the actual issue which is include/asm/arch/gpio.h
>> use types that aren't defined in its scope.
>>
>> So what I think we should be doing instead is to add the proper include
>> in include/asm/arch/gpio.h such that the types are defined, I'm assuming
>> it should be as simple as adding
>>
>> #include <linux/types.h>
>>
>> to include/asm/arch/gpio.h (or replace the unknown types with something
>> that actually exist in that context). Otherwise, we'll end up having to
>> fix all users of asm/gpio.h which do not include linux/types.h one way
>> or the other. Can you please test that?
>>
> Adding #include <linux/types.h> to the top of arch/arm/include/asm/gpio.h
> does solve the issue, while leaving common/usb_onboard_hub.c untouched.
> (The CI does not detect any build errors as a result of this change on other boards).
> 
> There are other versions of asm/gpio.h for other archs (arc, mips, powerpc, sandbox, x86 etc.),
> but I think we should leave them alone unless a problem occurs?
> 

There are many others gpio.h missing proper includes. I'm not sure 
what's the best thing to do here but I wouldn't mind if you just fix the 
issue you encountered here.

Cheers,
Quentin
