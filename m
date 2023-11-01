Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFADC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E6487762;
	Wed,  1 Nov 2023 19:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="IYS0UJoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AFDF876DC; Wed,  1 Nov 2023 19:51:02 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn2082e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::82e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BC187762
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrGr4tkR4f9kRCx1WTmAyL3n3DerCfv9HJF6jo+djUJhTcDMFqx2+5blqhH2G9YkFRO9U8TQftfovud62i8aSoG2YALAObTvbwebPi2ICqL65zbHcO3ERwCw/dZfvAOssbFcv4UtelNA40euonToH07UJiS0zffOJqhf3bDNqnITOjMeU5CVpMcgZ+iaHgY2b9Ic3W5EYRrFZr+SPUrX/o2VRE+sv9zXM4Wfc+gbVi+pVQcRvxZleageyeAbKJyMXisxkce6DvTEaxkxUdLaGM2LYrHHeFzvjDC6rdq/AVZ5oQbBJHalqgMxjyW/l+xm0WhdgkyEUVumTQYCk0t8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzM8h2cjK4LgseGWQdhWFOIdDjENOKV8K5bktiel1nM=;
 b=Rh3aulE6OftuK+c+PO5lwSAUprisR6REH9DQKSsRJpajgoD0ZlF+pvySC0fzRoLImKeuS6Gb86WdF8hNx2B4ZJR3oxMj5iSMyFYJB9t2m+L9HjdNqePQRyIOncsU7ZtWUaBmKkho8wyZ4BmqmApKM+/aoQmg9Wrq39EFN1A6nPzklP6xOPlFThRKAG4Z3O2PVm1B2/e4xmlxrX1dHWEbZaCDlFrPJbPWq7ArigJG7hPKZ4onrjKUDl/7zCRxi6nHz/M1HjICcbQeAzXNh0FP+9LhBjk9eXaeeBs/f7oUruFJTeS/ac4sTWOdLkMPlwY0wcmB3EAPQymR+KgFpRu1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzM8h2cjK4LgseGWQdhWFOIdDjENOKV8K5bktiel1nM=;
 b=IYS0UJoLN/zQ8boEJtn2yYm/PiI1ROKV0eK2Abgxw+20j6AHy3NVVZ9bt7qu3hCFCjuJ25P2av0tnMzqtJeVy2yldhuoKZ7rynTWj7OFayUf6scnMsBiDBo0QeqEQF7Dd3hOtEeRRXPPc5mCKSBcZKvj85yaNnqwssVmuiD7CxDpwkBHJzcD2K4CEFYBmkwwSF/GlsPxxuXGtQHaxMcnD6K2k51bXJcsVsuIGVaWIvibu6dNkNfWpmSpcVMQWc2O1BU8KfeMOjNm3qEbpnwYWm1+Uiefy4Wkx+p67tJ+89i/a2H6DSQ/v4gVR/rbBN6I7gk0KaqTQaGmw7uuEgYmJQ==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by KL1PR06MB6986.apcprd06.prod.outlook.com (2603:1096:820:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 18:50:54 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::15b3:c9f7:221e:ead9]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::15b3:c9f7:221e:ead9%5]) with mapi id 15.20.6954.020; Wed, 1 Nov 2023
 18:50:54 +0000
Message-ID: <KL1PR06MB6964D09D62F826D2408DD6BA96A7A@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Thu, 2 Nov 2023 02:50:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5/5] clk: ccf: call clock provided ops directly for
 endisable()
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-5-49ec18f820bf@outlook.com>
 <f996c4ea-81c6-815e-cab1-2d0b09b22135@gmail.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <f996c4ea-81c6-815e-cab1-2d0b09b22135@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [OCW88NGMGYqLw8Ovx6OlPWywT91Arqpb]
X-ClientProxiedBy: TYXPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:403:a::29) To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID: <f94b7313-0dd4-477b-b144-d3b2d08d14ad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|KL1PR06MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c83713-ca6d-4105-a97f-08dbdb0b7982
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAlYl7k7R64ZPkQfwU99OZx+DWLBTmrQSL/oolR7UQq1aOF1fcSGvWWZt3Ytm/3eFjY9i7UUshyqqXh97a+3Lclujj0PHkriHhdObFYS0mzVfnW5CkdQ5pf1BrQ0YAvYpSAWdpjDEBUkiJsrMU10hnuv5j5KCO1M+DnLwLFJH3mJwPc5lYGzuePu/kns1Ww70FFuSAChM92Gm1lOZytkC1+6F1HrYzHl5ntFodwfgfMJ4T5FD9zBo1PswNO36de7BgHfs3h1jEkginZ+0+1+UhEzm0hcMlmlkjOL3I5DO6PLEMY/nJhck06Mi4VTFhJqTH/OvzCMnLcag3Q6AegYJbH0/Hs9nmXAE/Va7WSQjLf4fsVCqf/EuFq5sF+tYpW2dw0zuTEgrwo+EBwjPwp//mNlclotDgY0WrH91oQcgxvAPgJW8cmTy5F1osGddk6GgpXSFAXUkpUmGODp/kpEWnaB9tYm5wUwEij9FuL+mDCVmzaaOKxl6q+fck7weVsBUY0caAA4CYq48w8Z//bfmQWg6nDJr3OkH49idFc/0a2qa+B0kUv7r/vsRDBQnFbK80qxQabQU9YBxpWxsjplqhrKK2iKpLTtaGFqQfI33BE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGx4c04zbm94amFCRTQyL3U1MzE2OXJ6MjMvYUpoKzFrbDBlVGpIcVB3OUVE?=
 =?utf-8?B?dENFbTdtVVNmdGRnWlJFV2VUMzVwcEZtLy9pREFDWnVkYnQ3S2RZbktnNm93?=
 =?utf-8?B?S2RWTHNoMUlkSHNlMlpTQzQ1OFpGcHpVQ25SZVVFSnNDdDZ1WGloY3NBTGl3?=
 =?utf-8?B?TGkrMG16Z3B3RG1zTHNFUUQvWHJqcWkwZStqeCtLMUtVMCt2eFVpL3RDbThS?=
 =?utf-8?B?T3ZKN3FrZlNTQnJTZzNEb2Z0QUZFUXZmVCtVOUJMUjlxa0UwZEZ2VWdESnY2?=
 =?utf-8?B?OU94aElmQlV1RjY5eWdZc3BIV2J6U2FxYlJVQkJKMU10bUdEN0xkZWRoQXZp?=
 =?utf-8?B?Q0MrQmlZeElGSUE2TUo0MUlBTURTNXdhb09uLzZFWi95dlg0eEJHY3lxNnZS?=
 =?utf-8?B?SUhrblBZZEsvVGdqSHJLTkgrb0FxTmxhUlRrRU56cUJ0d09qTUhIZ2FrSldy?=
 =?utf-8?B?Y2VmYXlGRmZMMzVVZkVmZlA1MktUUU9pSDFOWEh3MFdvUUROYnRKaEwxMmtB?=
 =?utf-8?B?R1lHOG1lOWU1TVNUK0NkYjB3ZzFGVW0yKzRzb2pVWUFHa2NhdFJkNHJINWJ4?=
 =?utf-8?B?V1hCOUR2Q2hNTWNuNUZhOFQ2Sk4xTmV2Q01UWHVTWmI3Rm1vTzhKYytVeDRC?=
 =?utf-8?B?cDI2OXJhSlpXbE96cXY5TnJpUjU3NFhQRktCc2Q1bXc3QXQreXRGekxYc2ZL?=
 =?utf-8?B?OVFhU3ViS1FXa2xRdnJIeFJoUHJrWXI3cUkzZVFZYm9wVytlUjEwcEREd3lY?=
 =?utf-8?B?dDJXN1pQMnFiUUV1U281bVdVeGppbE83RUxRMm4xbElyZnVldnJJOXZKRmZi?=
 =?utf-8?B?WTV5ZTZVTTVBdXVTbVV6SzBtOEVwOFUvRDlCVGtLMDZzdktQekdUR2FWZkt6?=
 =?utf-8?B?cFpHeGFXcGZxTkJVMXo1cnVHWTNSbXFCdzVvMTUyUjA1ejdCdkZQaWsxek9u?=
 =?utf-8?B?T2xNNG5GRmhjNHVZVFoxYzhXelJCQXBPQm1VMzl4a1BOVHFPWWE4T0tSZHJt?=
 =?utf-8?B?d3RTNUQvZmI5N3J3T0I0T2daYXVmL1QrVWEzYTIzMDdFb0pYRTAwRmprbHlT?=
 =?utf-8?B?ZGtWbUxkR3RwUDFpd0NIbXZMWUZJdjBNYjZEdWZHVXorS2RYYStIR1d6ZEhU?=
 =?utf-8?B?MkhCbGt4dDBtUVFObnRTcktTMDhtV3gzYXc4Q1k4WithK2NuKzhra05jK3Q5?=
 =?utf-8?B?MFRzMzh6UXN4VjFocXk3cWlhbmREeXV3b1RMQjBWSUd4YU1Xb09TUmhZbTRD?=
 =?utf-8?B?MFBhZlJta1hzUHNGU1lvbExvWkJPWGxvS2ZSVjBQWk11WW1OdmcrRTZEWnNs?=
 =?utf-8?B?cGl2R0Mvbkh0TWx1L1VKMEZYNVNCTjdjUy9pbkk2WTEyR0VpN1BadWlrSXQx?=
 =?utf-8?B?NVVvZXpLWk5RUXRTS0pwWkhzbUFIWFQyQVJVMW5xSHhlNVp1TnNBSzZMekpw?=
 =?utf-8?B?V00yYWZTaEt4WWQrdTRHNHRsWWI1RTg3d1NNYUx3Wk5tOUtZaStUQ2cvaUdC?=
 =?utf-8?B?RERwblJ6MUkxc2t1RWg4WTJwbnJ1L2xob2dYMGo4Q1ZOaVlkZG5MdU12eVhj?=
 =?utf-8?B?K1ZJY3d3aDIxWm5CMGJlb0wzOGc0YzIxbldZK3F5RWJvbXE2ZThxWXlxMTEx?=
 =?utf-8?Q?BzmMGh12ylITzmozINFvas+CNZ9itnzhXVqf7C0pv7Dk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c83713-ca6d-4105-a97f-08dbdb0b7982
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 18:50:53.5157 (UTC)
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

On 11/2/2023 2:19 AM, Sean Anderson wrote:
> On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Calling into CCF framework will cause a clock being enabled twice
>> instead of once (clk->enable_count becomes 2 rather than 1), thus making
>> it hard to disable (needs to call clk_disable() twice).
>> Fix that by calling clock provided ops directly.
> 
> Can you describe this scenario more? From what I can tell, clk_enable
> doesn't
> increment enable_count for CCF clocks.
> 
Well, it's hard to describe clearly. But I can only tell this patch
fixed the issue when i was trying to write an Ethernet driver[1] which
calls clk_disable() and expects the clock to be disabled after that.
Also I found that CCF driver does not have a corresponding test file. I
will try to write a test for that in next release.
> --Sean
> 
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/clk/clk.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index a38daaac0c..00d082c46f 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -14,6 +14,7 @@
>>   #include <dm/uclass.h>
>>   #include <dm/lists.h>
>>   #include <dm/device-internal.h>
>> +#include <linux/clk-provider.h>
>>     int clk_register(struct clk *clk, const char *drv_name,
>>            const char *name, const char *parent_name)
>> @@ -115,11 +116,20 @@ int ccf_clk_set_parent(struct clk *clk, struct
>> clk *parent)
>>   static int ccf_clk_endisable(struct clk *clk, bool enable)
>>   {
>>       struct clk *c;
>> +    const struct clk_ops *ops;
>>       int err = clk_get_by_id(clk->id, &c);
>>         if (err)
>>           return err;
>> -    return enable ? clk_enable(c) : clk_disable(c);
>> +    else
>> +        ops = clk_dev_ops(c->dev);
>> +
>> +    if (enable && ops->enable)
>> +        return ops->enable(c);
>> +    else if (!enable && ops->disable)
>> +        return ops->disable(c);
>> +
>> +    return -ENOSYS;
>>   }
>>     int ccf_clk_enable(struct clk *clk)
>>
> 
[1]
https://lore.kernel.org/all/20230814-wip-hisi_femac-trunk-v2-0-1e29f400585d@outlook.com/

-- 
Best regards,
Yang Xiwen

