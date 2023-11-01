Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E954C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EB287156;
	Wed,  1 Nov 2023 19:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="kXCPnt3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF2E87D99; Wed,  1 Nov 2023 19:54:45 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn20831.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::831])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC2F86FB2
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8adzI7D9Nl/1jXbwNcyeF/8ggFpoixijCJwjjfqYxg0MmdykN+yqNF9dIGLHnAR/z5pK1nDlL7dsBnAahIfuvaugQtln9DiCgnXqK49nYjDohnppjlEDf8gnpo/lmIdyLMaOOq08/plGuy8SSoNyd2H/PRRyyPDA2DZ+z1kjAbIWA9hvfYgxrUpVyjxtiw5BOHDfoZE6H1bjMDoFq13mlz0soTy3IO2uxqWwXYuQuq8Z8xTg4XhyRGGCXSFJLOiJNvKGx3Mvzdjwxf4KGppxAxICfbFLddInsk6l9YQCPyxQqFEFz09bdsizWGccLzDpig09LIkKX0W9LjJhDSQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROeB0JN7aS7IlGCEMxObyzJy0NQ9yjeS7+h4Tbgj5sE=;
 b=D0tqvAccLZVl/UZIJf8O7cbh5tvXqz4DzdCs0THQZimxOM5nyGzI/R+H7siEMaCTQQyrGNsPCsD7hfs9KWyxwywZWV2STqp6DRU7oFQ13wnyRw+ky88PMx6RoQDJjfy8n2ZQNFKNHcTsDTU2G7a6fO8Caw4/5WzNVY1UhjtBY3M7547kMW1IZmqosxK54f6x8TfSQ+EJkTo+Bn7X/63nF0ya69bBwFAnq9bj0dWGzmZLCPwA2yXd1VZqW6UFbcOr8xu4LzwKAoH8PGv24zC6obP3wCwFZKLH7PxpfQMmXBWwYdDfbJved5abZMok8P9Xs4wWxCysD75jQzRX46ZY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROeB0JN7aS7IlGCEMxObyzJy0NQ9yjeS7+h4Tbgj5sE=;
 b=kXCPnt3d1kDEaNXMiTzac4boncktoJG0F14Q4FxRFVd9mYWHJuu1SMgIfjtInl1r1X4pNJE7STEqa3P0f0D/fCQcdB04Tm/t7VWdFMnumup1krCdYeiewIfdYzBW0HM8L3JTialgJ/q+JBxFAjZMeoYEgnvd5sV20w3LQu0Wqy5IbE+F3T/C+jvZlAh1emddL3HysWOZoO8Y55z7ya9gIZyTefS09keyuJGWemLyifzoOkSYsnDkR82Gs/SZ1szXEWzh/TPE+kEHVtraO6cgr7E2Gclml31SUwQywESt/zmpWdlR9gDaEjZSQQJnNbJtxcJNyZy6EBQZHnmGpOPp8w==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by KL1PR06MB6986.apcprd06.prod.outlook.com (2603:1096:820:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 18:54:38 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::15b3:c9f7:221e:ead9]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::15b3:c9f7:221e:ead9%5]) with mapi id 15.20.6954.020; Wed, 1 Nov 2023
 18:54:38 +0000
Message-ID: <KL1PR06MB696493D1CDA82052D576BEC296A7A@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Thu, 2 Nov 2023 02:54:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/5] clk: call log_debug() instead to avoid console
 log printing
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-2-49ec18f820bf@outlook.com>
 <02b22344-bdab-ea52-cad7-637a94aa852f@gmail.com>
 <7d218787-b802-9ea7-9132-ae1e817b6997@gmail.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <7d218787-b802-9ea7-9132-ae1e817b6997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [e2TbOfnIEmBiuuIupC1m14Qr2VIEGCf/]
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID: <084796b5-8869-40a7-b5f6-1c4dc18ad6bf@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|KL1PR06MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: fffd7161-2ba7-4eec-97ff-08dbdb0bff85
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl18nYR2xrIkLjWg6YiVuLK2au1YiMy5/vCrNituc7hEI6P1jQIsUMu8kn+o40dwIgFKuvTVDOqzDcl72+UM5EN2yPGfVeCG9XIO1TN8aakjDTgBUZmnA6qgYIRiZ4zZR7NfKN2dI34mZBqlRWDgo4yNnxdFvO5+YTQ/17K0dta2ApGTJYT9u9HVi963z5MslZEWF4o0ZqFG0ZP600btz37WHU4uLE046SYTMWmShlpVagP+OlKl131bU2KX3lZdB4Awx82P/nZM3pUiSxj6c3a3TXkNDFZ2A2rZnSRtpPJ6rcMAw/O3n8QVMP8b0YtlnSCsa7io2cqHf+g3gB7HCfc9ETDtQM2is1YOBXBPWqZXM6vi/M7LUcTbaQ7x/kWehh/FJ3RgOU/iGpX84xnA3SXtlDGVSFjd9BV1DzJTK21bo9sWhJJKi2bXQd4eIG5nCGjdfHvNvn+i8ypYjYtMpd2xOvMh4XVXIgTJxi4j6XYHliiVOPlMmcIptmm0DAoxxI4bjCxNMsqPJ3OYzYNRJSVS02uxR9uFhT8tmAVwoy7Pj3r1M30nHqUSxNKblj38
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9ZZVZObFY3YVJzT2dEM1NjNXpFM2ZzeDNZYWpsM1Fmd0RLc21uTlZ4SlJs?=
 =?utf-8?B?VVEvVFErTDZJSzRCSk12L21PbERrZm1XUGlFQzM1cDA4dlo2cjRnTDhMN3R2?=
 =?utf-8?B?NTZPdVFvRCt3anRLV2IxWXFXVFVpZjZTbWlxWGR1TnkwRFM5UHRONmtYeUx5?=
 =?utf-8?B?VjdpZkJKUWNzL05jWndVa0tvb2xENys2T2N0d1JsQ2M1bTZvMDJQTHVXbGtt?=
 =?utf-8?B?aGZ6R2NaR05kbjU1Y2E0WnNzUWVoMFRDOFRKbUZ6OTZOaXhXcXc2cmhzdFhR?=
 =?utf-8?B?UlVmS0lPcU83THFOVXZhb0NsR2N1WGRsZHRZcnpRNmFLeVhsbmhoSnJ3N05m?=
 =?utf-8?B?Tjg2dU9rblc3ZjJQOHZQSzltTW95UktTOTVweXo0NERCNGwvcyt3SklNZFpL?=
 =?utf-8?B?d1dSRlFZWTNIMEcvYlA1K3RwbVg5b2Erb1lhLzlsQXRpWjgzNldoNDhxMThS?=
 =?utf-8?B?bkxFaVBOMTZiQ25taVNmMnpYakVGREw0RHRrSlhRazNhdTVDeXhyL0JuelVB?=
 =?utf-8?B?aGZlcWpSVXhVMk9Wb1J6OWRIc1pVeWQwT0F5WTZEZ28yY1hNdzlscHY0VDRR?=
 =?utf-8?B?cUJ2Y1gzVXVkZnM5RXFPMVZoUzcyRXVGYkpwTVA2RzN1eXgydkcxVXRydEl5?=
 =?utf-8?B?dks0QnBNaXVMc3l6b0NrZ0NDeEJvTkkvUU1iQkthY2hoRjVHSGlNOFEza2Jx?=
 =?utf-8?B?azB6bFRFNmlodHBYbENpV3hBN0JYYUFKSmdWMzZVbS9wRHhINkxNUm1QNGdK?=
 =?utf-8?B?WkdySCtQVFJNQTBxL2hYN0V2UmdTU0V2a05PZSt1eko5MVpGc2xGY1lybDVP?=
 =?utf-8?B?by9ScmdHVkFLMzROL0Y1bnZNK1pVUnBIcWlJVmtmVHNBaklXdEhmT1ZMUHZS?=
 =?utf-8?B?eEpQZU1NNnFsY3B5Sy90aDRVZFA5RFphdFFCL0N5aGh4dUlYODA4L3N4UkU3?=
 =?utf-8?B?cmJqVE02VFBoVFpzZHpUOWpaU3czSDN4bFNPSkNpUGFYYmp1ekpkb2lCMUdj?=
 =?utf-8?B?MFVTTU5TZ2ZWR0dtR0EwMWhvY0VnY0VHV21vckNEK08vd1daaW9jTkxaaXVi?=
 =?utf-8?B?TkpLb05xWUwwdE4xQ29nd0tZRTlxY2ZuTTh3Z1V1WTAwSldKMVZ6cC9iUHA1?=
 =?utf-8?B?RGpORGZLT3JGRHA0ZUpQRGJDVGREaWU4TTJPYWJVNjhOdy9kVTc1YTRDdUFz?=
 =?utf-8?B?WjFHVjF5MzU3Wk44bVcrek1xV2pEc0tSSmd4TjRPdXVhK2FqaVVjZkE5bmh3?=
 =?utf-8?B?dm5YYTRjajFmV1B5VGsyM2tMUWNNekdwWVNzOFo1QW1OL1Brc09Qak1PRzN6?=
 =?utf-8?B?TDYya3pWM29ZcXlocjFEZmo4VWluMTEvTko5QXZPNC9NVVd0cnBTYjNFeWds?=
 =?utf-8?B?LzRXNmF4dnV1cXVpbDJPcmFSZ3hMK0JSY0VqTnFsbEdzZXh1K0lDcFdlRWhu?=
 =?utf-8?B?UEdHT2t5WTNWR214b3Ava0lZdHhBV0tzNmMxVzJ3Y0gwWGR5a0g2cVhrS1B0?=
 =?utf-8?B?MUtPSGRyT05DdFhPWlFXNHFUcnVXa0ZRNStjMEJ2SGtVbjM5cTJXVmxuZWww?=
 =?utf-8?B?L2FLZEczNTdmUnJ3aThZbUR1bXlLUmRZNmpNbllTcnRMazRZdlFpeGF4a3Vq?=
 =?utf-8?Q?1K4/VkGbm9dieQS6sIHwLMemwJv73rVOzbre+Aq2UfAA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd7161-2ba7-4eec-97ff-08dbdb0bff85
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 18:54:38.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6986
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

On 11/2/2023 2:01 AM, Sean Anderson wrote:
> On 11/1/23 13:55, Sean Anderson wrote:
>> On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> it's a very common case to register a clock without a parent, such as
>>> clk_register_fixed_rate().
>>
>> Actually, that seems like the only place this is done.
>>
>>> Replace log_error() with log_debug() to avoid
>>> useless console log if not debugging.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   drivers/clk/clk.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index a5a3461b66..a38daaac0c 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -24,8 +24,8 @@ int clk_register(struct clk *clk, const char
>>> *drv_name,
>>>       ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
>>>       if (ret) {
>>> -        log_err("%s: failed to get %s device (parent of %s)\n",
>>> -            __func__, parent_name, name);
>>> +        log_debug("%s: failed to get %s device (parent of %s)\n",
>>> +              __func__, parent_name, name);
>>>       } else {
>>>           log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
>>>                 parent->name, parent);
>>>
>>
>> I think a correct fix would be
>>
>> diff --git i/drivers/clk/clk.c w/drivers/clk/clk.c
>> index a5a3461b66c..cb333c83f66 100644
>> --- i/drivers/clk/clk.c
>> +++ w/drivers/clk/clk.c
>> @@ -18,17 +18,19 @@
>>   int clk_register(struct clk *clk, const char *drv_name,
>>                   const char *name, const char *parent_name)
>>   {
>> -       struct udevice *parent;
>> +       struct udevice *parent = NULL;
>>          struct driver *drv;
>>          int ret;
>>
>> -       ret = uclass_get_device_by_name(UCLASS_CLK, parent_name,
>> &parent);
>> -       if (ret) {
>> -               log_err("%s: failed to get %s device (parent of %s)\n",
>> -                       __func__, parent_name, name);
>> -       } else {
>> -               log_debug("%s: name: %s parent: %s [0x%p]\n",
>> __func__, name,
>> -                         parent->name, parent);
>> +       if (parent_name) {
>> +               ret = uclass_get_device_by_name(UCLASS_CLK, parent_name,
>> +                                               &parent);
>> +               if (ret)
>> +                       log_err("%s: failed to get %s device (parent
>> of %s)\n",
>> +                               __func__, parent_name, name);
>> +               else
>> +                       log_debug("%s: name: %s parent: %s [0x%p]\n",
>> __func__,
>> +                                 name, parent->name, parent);
>>          }
>>
>>          drv = lists_driver_lookup_name(drv_name);
>>
>> --Sean
> 
> or you could modify the condition to be `if (ret && parent_name)` with
> appropriate
> modification of the second debug message.
> 
Thanks for your review. I'll use your patch with your SoB and drop mine
in next release.
> --Sean
-- 
Best regards,
Yang Xiwen

