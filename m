Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56AACA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 17:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F76831BB;
	Wed, 27 Aug 2025 19:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="eJmKJ2K4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCA2831BE; Wed, 27 Aug 2025 19:10:28 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7870A830F6
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 19:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0334b8dfa9=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RFjqtH032180;
 Wed, 27 Aug 2025 19:10:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 avlwJY0WjF1QyXBDdB2q/Zkqabm6Evn+A0dvU006MIo=; b=eJmKJ2K4W/W73QV1
 e1bZXGpuzaj59I9DHfkwkjjPqsfnOjhHvGdAjL7EfnkBl8rDyw/xurOemUyWW4Z3
 5oRw/KT/y3weNQyzCnnaY6oIc93xcSA0aUPjsMR7C0tpGJlsXdeMeLdhTSUXMUG7
 H/qMZc31gOEJmXsumBAC9lCWCu4iEVG+9qUEZgkuxkTGwTnUawNrNlKCvNxpDqma
 vgM2n+WWSaH+a+HP59X/b6cdDvzlej43xBoQyifIj6do4RI1jksFHhbhy6iUQQZz
 5OpylT4HOuNBQn4ZhcPFxdEmdZDVsFqArPHf4zdsXVB8mDyDjigJRUxFt+J2moU8
 t3WiCw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5v098cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 19:10:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 098EB4007A;
 Wed, 27 Aug 2025 19:08:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BE44726F00;
 Wed, 27 Aug 2025 19:08:02 +0200 (CEST)
Received: from [10.48.87.108] (10.48.87.108) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 19:08:01 +0200
Message-ID: <aa8d1d52-fe7e-4d67-a150-0d2b884f26f9@foss.st.com>
Date: Wed, 27 Aug 2025 19:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: introduce of_clk_detect_critical helper
To: Quentin Schulz <quentin.schulz@cherry.de>, Maxim Kochetkov
 <fido_max@inbox.ru>, Christian Marangi <ansuelsmth@gmail.com>
CC: <u-boot@lists.denx.de>, <jonas@kwiboo.se>, <marex@denx.de>,
 <semen.protsenko@linaro.org>, <miquel.raynal@bootlin.com>,
 <patrice.chotard@foss.st.com>, <sjg@chromium.org>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <lukma@denx.de>
References: <20250812162946.892728-1-fido_max@inbox.ru>
 <689b6eb9.050a0220.d7261.4aab@mx.google.com>
 <9294dcae-42fa-45c2-962b-691fdaada13a@inbox.ru>
 <2ad54e51-96cb-4f42-85f3-6a9d606951dd@cherry.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <2ad54e51-96cb-4f42-85f3-6a9d606951dd@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.108]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
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

Hi,

On 8/19/25 09:41, Quentin Schulz wrote:
> Hi Maxim,
>
> On 8/12/25 8:56 PM, Maxim Kochetkov wrote:
>> [You don't often get email from fido_max@inbox.ru. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> 12.08.2025 19:41, Christian Marangi wrote:
>>> On Tue, Aug 12, 2025 at 07:29:46PM +0300, Maxim Kochetkov wrote:
>>>> This helper find clock-critiacl property in dts and assign
>>>
>>> clock-critiacl -> typo
>>
>>
>> Thanks. Will fix it in v2
>>
>>>
>>>> CLK_IS_CRITICAL flag to the clock.
>>>>
>>>> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
>>>> ---
>>>>   drivers/clk/clk-uclass.c | 17 +++++++++++++++++
>>>>   drivers/core/of_access.c | 22 ++++++++++++++++++++++
>>>>   include/clk.h            | 28 ++++++++++++++++++++++++++++
>>>>   include/dm/of_access.h   | 17 +++++++++++++++++
>>>>   4 files changed, 84 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>>>> index 7262e89b512..4f35b90382f 100644
>>>> --- a/drivers/clk/clk-uclass.c
>>>> +++ b/drivers/clk/clk-uclass.c
>>>> @@ -835,6 +835,23 @@ struct clk *devm_clk_get(struct udevice *dev, 
>>>> const char *id)
>>>>      return clk;
>>>>   }
>>>>
>>>> +int of_clk_detect_critical(struct device_node *np, int index,
>>>> +                       unsigned long *flags)
>>>> +{
>>>> +    struct property *prop;
>>>> +    const __be32 *cur;
>>>> +    uint32_t idx;
>>>> +
>>>> +    if (!np || !flags)
>>>> +            return -EINVAL;
>>>> +
>>>> +    of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
>>>> +            if (index == idx)
>>>> +                    *flags |= CLK_IS_CRITICAL;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   int clk_uclass_post_probe(struct udevice *dev)
>>>>   {
>>>>      /*
>>>> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
>>>> index b11e36202c1..59dda3ae152 100644
>>>> --- a/drivers/core/of_access.c
>>>> +++ b/drivers/core/of_access.c
>>>> @@ -666,6 +666,28 @@ int of_property_read_string_helper(const 
>>>> struct device_node *np,
>>>>      return i <= 0 ? -ENODATA : i;
>>>>   }
>>>>
>>>> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 
>>>> *cur,
>>>> +                           u32 *pu)
>>>> +{
>>>> +    const void *curv = cur;
>>>> +
>>>> +    if (!prop)
>>>> +            return NULL;
>>>> +
>>>> +    if (!cur) {
>>>> +            curv = prop->value;
>>>> +            goto out_val;
>>>> +    }
>>>> +
>>>> +    curv += sizeof(*cur);
>>>> +    if (curv >= prop->value + prop->length)
>>>> +            return NULL;
>>>> +
>>>> +out_val:
>>>> +    *pu = be32_to_cpup(curv);
>>>> +    return curv;
>>>> +}
>>>> +
>>>>   static int __of_root_parse_phandle_with_args(struct device_node 
>>>> *root,
>>>>                                           const struct device_node 
>>>> *np,
>>>>                                           const char *list_name,
>>>> diff --git a/include/clk.h b/include/clk.h
>>>> index f94135ff778..ea708f54fd5 100644
>>>> --- a/include/clk.h
>>>> +++ b/include/clk.h
>>>> @@ -589,6 +589,27 @@ bool clk_dev_binded(struct clk *clk);
>>>>    */
>>>>   ulong clk_get_id(const struct clk *clk);
>>>>
>>>> +/**
>>>> + * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device 
>>>> Tree
>>>> + * @np: Device node pointer associated with clock provider
>>>> + * @index: clock index
>>>> + * @flags: pointer to top-level framework flags
>>>> + *
>>>> + * Detects if the clock-critical property exists and, if so, sets the
>>>> + * corresponding CLK_IS_CRITICAL flag.
>>>> + *
>>>> + * Do not use this function. It exists only for legacy Device Tree
>>>> + * bindings, such as the one-clock-per-node style that are outdated.
>>>> + * Those bindings typically put all clock data into .dts and the 
>>>> Linux
>>>> + * driver has no clock data, thus making it impossible to set this 
>>>> flag
>>>> + * correctly from the driver. Only those drivers may call
>>>> + * of_clk_detect_critical from their setup functions.
>>>> + *
>>>> + * Return: error code or zero on success
>>>> + */
>>>> +int of_clk_detect_critical(struct device_node *np, int index,
>>>> +                       unsigned long *flags);
>>>> +
>>>>   #else /* CONFIG_IS_ENABLED(CLK) */
>>>>
>>>>   static inline int clk_request(struct udevice *dev, struct clk *clk)
>>>> @@ -665,6 +686,13 @@ static inline ulong clk_get_id(const struct 
>>>> clk *clk)
>>>>   {
>>>>      return 0;
>>>>   }
>>>> +
>>>> +int of_clk_detect_critical(struct device_node *np, int index,
>>>> +                       unsigned long *flags)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   #endif /* CONFIG_IS_ENABLED(CLK) */
>>>>
>>>>   /**
>>>> diff --git a/include/dm/of_access.h b/include/dm/of_access.h
>>>> index 44143a5a391..dba725498f5 100644
>>>> --- a/include/dm/of_access.h
>>>> +++ b/include/dm/of_access.h
>>>> @@ -405,6 +405,17 @@ int of_property_read_string_helper(const 
>>>> struct device_node *np,
>>>>                                 const char *propname, const char 
>>>> **out_strs,
>>>>                                 size_t sz, int index);
>>>>
>>>> +/*
>>>> + * struct property *prop;
>>>> + * const __be32 *p;
>>>> + * u32 u;
>>>> + *
>>>> + * of_property_for_each_u32(np, "propname", prop, p, u)
>>>> + *         printk("U32 value: %x\n", u);
>>>> + */
>>>> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 
>>>> *cur,
>>>> +                           u32 *pu);
>>>> +
>>>>   /**
>>>>    * of_property_read_string_index() - Find and read a string from 
>>>> a multiple
>>>>    * strings property.
>>>> @@ -701,4 +712,10 @@ int of_remove_property(struct device_node *np, 
>>>> struct property *prop);
>>>>    */
>>>>   int of_remove_node(struct device_node *to_remove);
>>>>
>>>> +#define of_property_for_each_u32(np, propname, prop, p, u) \
>>>> +    for (prop = of_find_property(np, propname, NULL), \
>>>> +            p = of_prop_next_u32(prop, NULL, &u);           \
>>>> +            p; \
>>>> +            p = of_prop_next_u32(prop, p, &u))
>>>> +
>>>>   #endif
>>>> -- 
>>>
>>> I would split these of additional function to a separate commit also
>>> where they come from? They are ported from Linux Kernel?
>>
>> Ok, I will split it.
>> Yes these function are ported from Linux Kernel.
>>
>>>
>>> Also would be ideal to have some scenario where it's needed to 
>>> declare a
>>> clock in DT that is critical. Isn't that handled directly by the clock
>>> driver internally?
>>>
>>
>> Yes. Now we can use this property from DT by custom drivers to mark
>> critical clocks.
>>
>
> How this is typically handled today is by hardcoding the clock that is 
> critical in the SoC clock controller driver directly, c.f. 
> https://lore.kernel.org/linux-rockchip/20241214224820.200665-1-heiko@sntech.de/ 
>
>
> This is of course then forced-enabled for all boards based on this 
> SoC. If that is something that isn't desirable, then we need to 
> properly need to represent this clock in the Device Tree. You haven't 
> really explained the real life example that would benefit from this. 
> Is there one? What is it?
>
> Finally, we do not accept Device Tree properties anymore if they 
> aren't part of the Device Tree binding coming from the kernel, the 
> Device Tree specification or the dt-schema. So it needs to go through 
> those channels first before we can make use of this property here in 
> U-Boot. Our ultimate goal is to have the exact same Device Tree for 
> U-Boot than in the Linux kernel (and I assume even further than that, 
> anything that requires DT use the same one across all SW stack).
>
> Cheers,
> Quentin


See Linux commit d56f8994b6fb

it is a legacy feature for Linux side, not part of generic clock binding

and no  used in Linux's device tree

-----------------------------------------------------------

Author: Lee Jones <lee@kernel.org>
Date:   Thu Feb 11 13:19:11 2016 -0800

     clk: Provide OF helper to mark clocks as CRITICAL

     This call matches clocks which have been marked as critical in DT
     and sets the appropriate flag.  These flags can then be used to
     mark the clock core flags appropriately prior to registration.

     Legacy bindings requiring this feature must add the clock-critical
     property to their binding descriptions, as it is not a part of
     common-clock binding.

     Cc: devicetree@vger.kernel.org
     Signed-off-by: Lee Jones <lee.jones@linaro.org>
     Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
     Signed-off-by: Michael Turquette <mturquette@baylibre.com>
     Link: 
lkml.kernel.org/r/1455225554-13267-4-git-send-email-mturquette@baylibre.com

Regards.

---------------------------------------------------------


=> custom drivers never mark a clock critical ...

       is a is a clock driver decision (common for all board, for 
mandatory clock in SoC,

       root clock or CPU clock for example = no need to be cutomized in 
DT for each board)


for information:  with CLK_CCF, this custom driver (device or board) can 
enable a clock found

in the device tree,  and its user counter become >1 (@enable_count),

the clock is always enable for your use case (if enable/disabled are 
correctly paired in other

drivers and with activate CCF) .... and you have no need to set it 
critical at SoC / Clock driver level


Regards


Patrick





