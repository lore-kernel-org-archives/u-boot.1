Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9F0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CE2876E7;
	Wed,  1 Nov 2023 21:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="DAzNtauW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84138876EE; Wed,  1 Nov 2023 21:33:23 +0100 (CET)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn20818.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::818])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABCA8707A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSdOOrshb72v5CwXvR9lhTCC7fIL6OE+l9hiWenFnIRuLg7AHxs5kSneEVT1NYLGKhKLSbkDohQjtI+FSPLY9v9XYcbvQJFE78P+NXa2FmH/UuPv0ailcITp15pIgNQcihEruZhfb9syYKDM1vkBYEPh7IyZWZPC9zf8KRUwVqhMwmiAv+ZYPScI61GbTgmh25V8YwfkuMz+DPaTk+CxnXTufhfR8MITg+ArgXIIlLS08+Es0JVha/6lkJd6mS81wPh2s+pDRmXYSj5WX7U7gMoCkoezdxxhIlp+aCFqIUMIa/cuzCdgnCsuOGA7TlcK38azcHiCj72YCP7V2ZMbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4HpiXymH+UTPQ24tb7Z5IiRCQjvgVNjOG9Inp+sqqE=;
 b=SleGr6MmgfVzCsT9VIkr3qFwEb4HkCmoKNixq5QNqZOA1pZ2rgrWrauBmlJQ24ly3TLHUzYray2yx0Exb3de5AQ4jInVZKPswnlAubwyEMOgLecX0evaOfMzBOfOa0Ftyo2mE6HZ/mk3YCwtC385xaLxeSMgBsl5oFyqntuucHhIv4KS9zxeptluAqbIeEkAcb6VnS2z1y2HMnA6AI9Bo1QXK/l7beiiieqQmyWsJNdZ/iLqE0nIaHiMDkZkRw1rMaM8dk9sG633zxmVm/WlpllO0U9McbrZ6AtPORfgWXu9gmLBhYrgFgZMq7nX0+Si5Xo89kABEBhPXxS/Zi4IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4HpiXymH+UTPQ24tb7Z5IiRCQjvgVNjOG9Inp+sqqE=;
 b=DAzNtauWGP4G5RKrjDDRXhxbfbbnXMCEcvEeatw97oqsCbj7XUcBxl0ZuGRXxFX5gzBSx2vSoel1ZzUUOOo0bNPCam7It8i2DnmvRGi5wQ0VArENAZPcxiLa7syZ+wFaX+Kw6KIwGTJ5GHLGyrtGav2p7ynYzTRSk1ciB8Pc4iaPbMYNthNn+kNc5LDkgCuslJJLrYK12IWUhKzft1jCEdKiQ6jOumuemOzkDKSICL4GZ7+OedHLgbbFHunTVzqezwzmP1TamqaIdp1U4Ud1/7CEQYPOWP++Ul8gzkBJPV3wqkpfG0oZylC44I31yxEoCkgjUJklvUEhECkfuEC7cw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5886.apcprd06.prod.outlook.com (2603:1096:301:11c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 20:33:16 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::db16:27b7:bf88:9c9c]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::db16:27b7:bf88:9c9c%7]) with mapi id 15.20.6954.020; Wed, 1 Nov 2023
 20:33:15 +0000
Message-ID: <SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 2 Nov 2023 04:33:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5/5] clk: ccf: call clock provided ops directly for
 endisable()
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
To: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-5-49ec18f820bf@outlook.com>
 <f996c4ea-81c6-815e-cab1-2d0b09b22135@gmail.com>
 <f94b7313-0dd4-477b-b144-d3b2d08d14ad@outlook.com>
In-Reply-To: <f94b7313-0dd4-477b-b144-d3b2d08d14ad@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [1gHnT1tF48u4vID8SqvZ0d+VVav2t/o6]
X-ClientProxiedBy: TYCP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::14) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <9b7f1481-864c-4785-be60-239517d1e924@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 9326cd33-9720-4549-3fc8-08dbdb19c5c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjTxWFqX30FH/oKiKvZRJcrDKt+VykyQ35EumgMi6MIPIubiASqb1x6o1JnGUoxi4VNVBSO/KMKbzLpz2ELxyCczjkzgSbqQGtk+QbW1LuON2bBrJX+BG7+8uqcu4pETTvHrRCbwypn5sOUZFL9Z6aDUWiEE6is5h3jxLWWZx90ba8ucpXk9fIgDgg4gtUmNctj99NoK7n7gGmoJR3oMKDaiaXdMk4mg+EgZ2dLzxxsSlE1YsXIE3A4N+1hctbgtmjYYE3XerzhvJSq6PNKLLku9kW41u3VrnZnkW7eV035AwZieN83w1T20sdGGs1hVpvqON7tYzoqHIwvke6Kupo2yABf+NzT939hdkJyT1AyxC73LuejCO6o4dPPO15c6xs8D4r3qiCiWPo5WZLB+WXlL9WX5Ks7JxVrwgnyzF2QWMQ4k2BKGkmuAeBL08Br1KmOQR7YY79HG0FpnYT7HNOuQQZ6b577LZ3NytlqX+svtglPncidRDDaH/EoYEii2aQTp0AD5GKTIHsfETFUJ3VrBszExGotNIHHrsxAwpwlIrQn78iTtdteT3q9mlXLpdgkWNCgc9czHv3alEuiVFIpXzFuYGQ205g2ZpggDftc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGd3b09UcU5JYjFGdDIyUWZOaUlPTHkvRGhxOFZzcUduck9jUm9rNlh1TFJq?=
 =?utf-8?B?NXYwSTFnMmorTk40V2pKS3VvaGVtaVJOVFVtTFhvVXk1bUQ2SHUrWXZLVmg4?=
 =?utf-8?B?cXRIZFY0R0dhV3ZlNFVUM0M5Ujd4TlVCeWQ5clRpK1ZEN3RTQ05NWEtlUzcr?=
 =?utf-8?B?L2haSWh0eEVSVmREWXkrSlpXa1BsZHV2ZjBERlJDRjQwL0ZrNEVaU3pBeW1H?=
 =?utf-8?B?WUhncXczdWZEcUtEdTBrQjlhTlRkYTVMVGQvQThDbkdSTmEzdGo4L21yTVJr?=
 =?utf-8?B?cXM1cFFGM0M1cHRyL2tqRWdML1hKUzFQZ0JDendZdkpZamVrRDhVNGtHYlN4?=
 =?utf-8?B?K1J1OS96VWpaejE4ZER6dkd4QnJ3VS9OQ3U4R1cyODFCcXhMTHdScXVpK1hp?=
 =?utf-8?B?UEovRnhnRTM3OCthT2Rldk02MTdERmRDQ1dWOUQxeCtRdmdWMGFLNEhIMEk3?=
 =?utf-8?B?aVZFb2tjRmZHdW5vNUxId21UZkJpRUdYOGlxUmdGTUhMejVralk2WkRtUC91?=
 =?utf-8?B?UW9JNWdpcUI0UjRBNEg3STVTWm45T0Q2QTBYaVA1cWFxQW05MlVuT2dZTFlr?=
 =?utf-8?B?YjR2MXlZT0d1akF3ZDNEUnVyb0FLMmE2MkcyS1pBNXJoN01VOENIZkh3UDYz?=
 =?utf-8?B?VUhzSVU2RXg5bEVqdlVxNVdQaldCSVpPSUgyWFhuRDFPQjd0QXhCUngyazN0?=
 =?utf-8?B?SUVPVzRNc2UxdjExOUc5ZnFRYmRqczN2Mi90clBCRmFQc01jOFpwUXBLcm5y?=
 =?utf-8?B?dE9xUTkrL2xhcUZod1MzRHVUakZLV3lhK3VtSXZvbUpMZGV1MStZZEROMjI2?=
 =?utf-8?B?SlNXM1pXTFpqWkdhck9KVkNnTmhpVmt6dzlPU0tHNmZUQXowNXB5alZpcmE3?=
 =?utf-8?B?dzJ2WFVHdldYaEF5KzB0TE94bzRJdXRBYTlwNFU5Yi9HdThtNm4yWUM4bE9s?=
 =?utf-8?B?N1gzVDBIbG1kYk9LWXNOaDFpNlZySVVpVXgxY0wwOS85cHIwK1hwNVpXK1d2?=
 =?utf-8?B?YnhheEIwUjNnNURvZGlDKzVEQ25BbUNzaGlyVjhoWmsvMFVHK3FsQ1QwVTJS?=
 =?utf-8?B?Y2QxTktCUHRoNisyU0tiMTZYQzZkVzFuNitNWnRpd2hMdmpaRHdNVnVpbzdp?=
 =?utf-8?B?YXNpYlQzdmVTbXErbzVRMGU0VzR5MWg5YWs0M3grQ3dtZ0F1ajY2MFJ6Sith?=
 =?utf-8?B?Q1Qzb2t2OTFSK0xOU21YWWRxUGZIY3hjc3RxemhWOEo0VWYxR3FrTVNRV0pj?=
 =?utf-8?B?N21ZOFNhMThsRURyKzFaMC9XZE1BdWpONjZWWE1zbVNHbkpZbHl5aXd6VmNX?=
 =?utf-8?B?dUJZSzRNaUVmWlZaY01OL0tyeUxGaS96dTR4Y1BqeEpLN1JLZ01WMGlQZzJk?=
 =?utf-8?B?TEZ5QTJPenpVdXJFeVVpMzZIQzhOTjZHU29idjVUMFltVWVmdVphdUozNk9n?=
 =?utf-8?B?Skp5blRJR1FId0JUWm01VkFJclZEbnNoZ0dyVHhKQ0svbnBXTlNYZC9JV2t1?=
 =?utf-8?B?Uk41RlZoV0dZVWUxNm5vd3hmS0dDWEs2OTgyVUNDdmFPN2xBSnE2U0dWOUxi?=
 =?utf-8?B?RFlOaXVjWUU1MGNwa01ROXdRWnIyQlREM1R5Y3k5K0c4T2hsSlQzZStlMWtJ?=
 =?utf-8?Q?krzHpI6ZJV6o2x4BHEAspE03583ha8opJp7exwR7hhIQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9326cd33-9720-4549-3fc8-08dbdb19c5c9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:33:14.4078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5886
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

On 11/2/2023 2:50 AM, Yang Xiwen wrote:
> On 11/2/2023 2:19 AM, Sean Anderson wrote:
>> On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Calling into CCF framework will cause a clock being enabled twice
>>> instead of once (clk->enable_count becomes 2 rather than 1), thus making
>>> it hard to disable (needs to call clk_disable() twice).
>>> Fix that by calling clock provided ops directly.
>>
>> Can you describe this scenario more? From what I can tell, clk_enable
>> doesn't
>> increment enable_count for CCF clocks.
>>
> Well, it's hard to describe clearly. But I can only tell this patch
> fixed the issue when i was trying to write an Ethernet driver[1] which
> calls clk_disable() and expects the clock to be disabled after that.
> Also I found that CCF driver does not have a corresponding test file. I
> will try to write a test for that in next release.
Okay, fine. I read the source again and let me try to explain the whole
thing to you briefly. Let's see what happens when we are calling
clk_enable(gate).

The source of clk.c is listed below and labeled for clarity:

```
1	if (CONFIG_IS_ENABLED(CLK_CCF)) {
2		/* Take id 0 as a non-valid clk, such as dummy */
3		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
4			if (clkp->enable_count) {
5				clkp->enable_count++;
6				return 0;
7			}
8			if (clkp->dev->parent &&
9			    device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
10				ret = clk_enable(dev_get_clk_ptr(clkp->dev->parent));
11				if (ret) {
12					printf("Enable %s failed\n",
13					       clkp->dev->parent->name);
14					return ret;
15				}
16			}
17		}
18
19		if (ops->enable) {
20			ret = ops->enable(clk);
21			if (ret) {
22				printf("Enable %s failed\n", clk->dev->name);
23				return ret;
24			}
25		}
26		if (clkp)
27			clkp->enable_count++;
28	} else {
29		if (!ops->enable)
30			return -ENOSYS;
31		return ops->enable(clk);
```

The following steps are executed:

1. Actually, a "fake" clk is passed to clk_enable() and only clk->id is
valid. The actual clk is "clkp";
2. Initially, we runs till `ret = ops->enable(clk)`(line 20), i.e.
ccf_clk_enable(clk);
3. Thankfully, ccf_clk_enable() calls clk_get_by_id() to get the real
clk and call clk_enable(clkp) again so we won't have an endless loop here.
4. So ops->enable(clk) actually equals to clk_enable(clkp). It's obvious
that there is a `clkp->enable_count++` inside the nested function call
since it's still 0. Now it becomes 1;
5. The nested clk_enable(clkp) now returns to the outer clk_enable(clk);
6. Unfortunately, there is a `if (clkp) clkp->enable_count++;`(line 26)
afterwards. Now it becomes 2.
7. Finally, we got a clk being enabled twice. "clkp->enable_count" is 2 now.

Obviously it's not the intended behavior. We can either fix clk_enable()
or ccf_clk_endisable() to resolve this. But I choose to touch
ccf_clk_endisable() since it's less commonly used.
>> --Sean
>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   drivers/clk/clk.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index a38daaac0c..00d082c46f 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -14,6 +14,7 @@
>>>   #include <dm/uclass.h>
>>>   #include <dm/lists.h>
>>>   #include <dm/device-internal.h>
>>> +#include <linux/clk-provider.h>
>>>     int clk_register(struct clk *clk, const char *drv_name,
>>>            const char *name, const char *parent_name)
>>> @@ -115,11 +116,20 @@ int ccf_clk_set_parent(struct clk *clk, struct
>>> clk *parent)
>>>   static int ccf_clk_endisable(struct clk *clk, bool enable)
>>>   {
>>>       struct clk *c;
>>> +    const struct clk_ops *ops;
>>>       int err = clk_get_by_id(clk->id, &c);
>>>         if (err)
>>>           return err;
>>> -    return enable ? clk_enable(c) : clk_disable(c);
>>> +    else
>>> +        ops = clk_dev_ops(c->dev);
>>> +
>>> +    if (enable && ops->enable)
>>> +        return ops->enable(c);
>>> +    else if (!enable && ops->disable)
>>> +        return ops->disable(c);
>>> +
>>> +    return -ENOSYS;
>>>   }
>>>     int ccf_clk_enable(struct clk *clk)
>>>
>>
> [1]
> https://lore.kernel.org/all/20230814-wip-hisi_femac-trunk-v2-0-1e29f400585d@outlook.com/
> 

-- 
Best regards,
Yang Xiwen
