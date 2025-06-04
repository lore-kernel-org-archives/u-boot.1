Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E230DC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 07:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD7282BD9;
	Wed,  4 Jun 2025 09:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="O1w+LQmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913B082C8A; Wed,  4 Jun 2025 09:06:08 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98C082B07
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 09:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8250fb800b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5546LeSk029853;
 Wed, 4 Jun 2025 09:05:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 +vnvyFrWsq+TqI/EBxhTjT2bDkUF1GXEbilnWIHwJ2w=; b=O1w+LQmOqiui8A/H
 cabtr6Kd1nBcL63uBgWIU5RbzFQbHW05rmoj5yK2uSFai/XvAeg9BtfNRljLg6uB
 FWtuVgfGPxgZ3tMi+tYlfH+myj1FKvNPnhaub2OYQRjMTSuPzKg+4Zli0l5abFAM
 syynz+vahgWKvUSnKmQDmBaV43wZDIUiuR1v/DC7mXQj5/f8l3gKoWrq1tyJqF+I
 1fXw8+hVzeeUF0LlcAILk9FN5rzAO5EqALaAosWj2zmGbZBUMB2SEQ+EDUSIeE+y
 YYt+h/NJdVCvNK7tWwTBBz4t6nqmCxXkliezx8U100sQfB25lRJB5DLrsjOEHnKd
 WyOWTQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8syr1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 09:05:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C75E24005C;
 Wed,  4 Jun 2025 09:02:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC6DBB054CA;
 Wed,  4 Jun 2025 09:01:55 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 09:01:55 +0200
Message-ID: <f319bd79-6d65-4bd0-af12-4a62f96566e1@foss.st.com>
Date: Wed, 4 Jun 2025 09:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] clk: add CONFIG_CLK_AUTO_ID
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Alexander Dahl
 <ada@thorsis.com>, Casey Connolly <casey.connolly@linaro.org>, Gabriel
 Fernandez <gabriel.fernandez@foss.st.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonas
 Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>, Marek
 Vasut <marex@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
 <20250527132755.2169508-5-patrice.chotard@foss.st.com>
 <156e1773-fa76-4b22-80e7-cf26cb7bf7b3@foss.st.com>
 <CAOf5uwmNz3JRoEoEVxMYk1Mb5PnYEMSWKbbh=kMXp=tqufPB2g@mail.gmail.com>
 <05a41190-87a4-4d32-b3d9-44e3101ea858@foss.st.com>
 <CAOf5uwkpj9HA+nhiOTPFz8WTGihyiVgZoCfZDKyCPu68zrRe9A@mail.gmail.com>
 <CAOf5uwn0VBV_swPt=JVJEazWrLh6hzhXDn8P2RSN34dmuu_aNA@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAOf5uwn0VBV_swPt=JVJEazWrLh6hzhXDn8P2RSN34dmuu_aNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
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



On 6/4/25 08:50, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Wed, Jun 4, 2025 at 8:48 AM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>>
>> Hi Patrice
>>
>> On Wed, Jun 4, 2025 at 8:46 AM Patrice CHOTARD
>> <patrice.chotard@foss.st.com> wrote:
>>>
>>>
>>>
>>> On 6/4/25 08:14, Michael Nazzareno Trimarchi wrote:
>>>> Hi
>>>>
>>>> On Wed, Jun 4, 2025 at 8:02 AM Patrice CHOTARD
>>>> <patrice.chotard@foss.st.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 5/27/25 15:27, Patrice Chotard wrote:
>>>>>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>>>
>>>>>> Add a new config CONFIG_CLK_AUTO_ID to support a unique clk id
>>>>>> for all the clock providers, managed by clk uclass, when the clock
>>>>>> reference arg[0] is the same.
>>>>>>
>>>>>> When the CONFIG is activated, the clock id is limited to the lower
>>>>>> CLK_ID_SZ = 24 bits in default clock xlate function
>>>>>> and the sequence number + 1 of the clk provider device is
>>>>>> added for the 8 higher bits.
>>>>>>
>>>>>> We use sequence number + 1 to avoid the "dummy" clock id = 0,
>>>>>> used for invalid clock when CCF is activated.
>>>>>>
>>>>>> When this config is activated, the new function clk_get_id()
>>>>>> should be used to get back the internal reference to clock
>>>>>> for the each clock provider.
>>>>>>
>>>>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>> Cc: Lukasz Majewski <lukma@denx.de>
>>>>>> Cc: Sean Anderson <seanga2@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> (no changes since v1)
>>>>>>
>>>>>>  drivers/clk/Kconfig                | 10 ++++++++++
>>>>>>  drivers/clk/clk-uclass.c           |  9 +++++++--
>>>>>>  drivers/clk/stm32/clk-stm32-core.c |  3 ++-
>>>>>>  include/clk.h                      | 24 ++++++++++++++++++++++++
>>>>>>  include/linux/clk-provider.h       |  9 ++++++++-
>>>>>>  5 files changed, 51 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>>>>> index 18bd640a68b..b2e53fe325e 100644
>>>>>> --- a/drivers/clk/Kconfig
>>>>>> +++ b/drivers/clk/Kconfig
>>>>>> @@ -10,6 +10,16 @@ config CLK
>>>>>>         feed into other clocks in a tree structure, with multiplexers to
>>>>>>         choose the source for each clock.
>>>>>>
>>>>>> +config CLK_AUTO_ID
>>>>>> +     bool "Enable support of an unique clock id with several provider"
>>>>>> +     depends on CLK
>>>>>> +     help
>>>>>> +       Add the uclass sequence number of clock provider in the 8 higher bits
>>>>>> +       of the clk id to guaranty an unique clock identifier in clk uclass
>>>>>> +       when several clock providers are present on the device and when
>>>>>> +       default xlate are used.
>>>>>> +       This feature limit each identifier for each clock providers (24 bits).
>>>>>> +
>>>>>>  config SPL_CLK
>>>>>>       bool "Enable clock support in SPL"
>>>>>>       depends on CLK && SPL && SPL_DM
>>>>>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>>>>>> index 2167cd5ad0f..7262e89b512 100644
>>>>>> --- a/drivers/clk/clk-uclass.c
>>>>>> +++ b/drivers/clk/clk-uclass.c
>>>>>> @@ -34,6 +34,11 @@ struct clk *dev_get_clk_ptr(struct udevice *dev)
>>>>>>       return (struct clk *)dev_get_uclass_priv(dev);
>>>>>>  }
>>>>>>
>>>>>> +ulong clk_get_id(const struct clk *clk)
>>>>>> +{
>>>>>> +     return (ulong)(clk->id & CLK_ID_MSK);
>>>>>> +}
>>>>>> +
>>>>>>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>>>>>>  int clk_get_by_phandle(struct udevice *dev, const struct phandle_1_arg *cells,
>>>>>>                      struct clk *clk)
>>>>>> @@ -43,7 +48,7 @@ int clk_get_by_phandle(struct udevice *dev, const struct phandle_1_arg *cells,
>>>>>>       ret = device_get_by_ofplat_idx(cells->idx, &clk->dev);
>>>>>>       if (ret)
>>>>>>               return ret;
>>>>>> -     clk->id = cells->arg[0];
>>>>>> +     clk->id = CLK_ID(dev, cells->arg[0]);
>>>>>>
>>>>>>       return 0;
>>>>>>  }
>>>>>> @@ -61,7 +66,7 @@ static int clk_of_xlate_default(struct clk *clk,
>>>>>>       }
>>>>>>
>>>>>>       if (args->args_count)
>>>>>> -             clk->id = args->args[0];
>>>>>> +             clk->id = CLK_ID(clk->dev, args->args[0]);
>>>>>>       else
>>>>>>               clk->id = 0;
>>>>>>
>>>>>> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
>>>>>> index 358ee56682a..df3b35b1003 100644
>>>>>> --- a/drivers/clk/stm32/clk-stm32-core.c
>>>>>> +++ b/drivers/clk/stm32/clk-stm32-core.c
>>>>>> @@ -46,7 +46,8 @@ int stm32_rcc_init(struct udevice *dev,
>>>>>>
>>>>>>               if (cfg->setup) {
>>>>>>                       clk = cfg->setup(dev, cfg);
>>>>>> -                     clk->id = cfg->id;
>>>>>> +                     /* set identifier of clock provider*/
>>>>>> +                     dev_clk_dm(dev, cfg->id, clk);
>>>>>>               } else {
>>>>>>                       dev_err(dev, "failed to register clock %s\n", cfg->name);
>>>>>>                       return -ENOENT;
>>>>>> diff --git a/include/clk.h b/include/clk.h
>>>>>> index a6ef4e02692..f94135ff778 100644
>>>>>> --- a/include/clk.h
>>>>>> +++ b/include/clk.h
>>>>>> @@ -13,6 +13,15 @@
>>>>>>  #include <linux/errno.h>
>>>>>>  #include <linux/types.h>
>>>>>>
>>>>>> +#ifdef CONFIG_CLK_AUTO_ID
>>>>>> +#define CLK_ID_SZ    24
>>>>>> +#define CLK_ID_MSK   GENMASK(23, 0)
>>>>>> +#define CLK_ID(dev, id)      (((dev_seq(dev) + 1) << CLK_ID_SZ) | ((id) & CLK_ID_MSK))
>>>>>> +#else
>>>>>> +#define CLK_ID_MSK   (~0UL)
>>>>>> +#define CLK_ID(dev, id)      id
>>>>>> +#endif
>>>>>> +
>>>>>>  /**
>>>>>>   * DOC: Overview
>>>>>>   *
>>>>>> @@ -570,6 +579,16 @@ int clk_get_by_id(ulong id, struct clk **clkp);
>>>>>>   */
>>>>>>  bool clk_dev_binded(struct clk *clk);
>>>>>>
>>>>>> +/**
>>>>>> + * clk_get_id - get clk id
>>>>>> + *
>>>>>> + * @clk:     A clock struct
>>>>>> + *
>>>>>> + * Return: the clock identifier as it is defined by the clock provider in
>>>>>> + * device tree or in platdata
>>>>>> + */
>>>>>> +ulong clk_get_id(const struct clk *clk);
>>>>>> +
>>>>>>  #else /* CONFIG_IS_ENABLED(CLK) */
>>>>>>
>>>>>>  static inline int clk_request(struct udevice *dev, struct clk *clk)
>>>>>> @@ -641,6 +660,11 @@ static inline bool clk_dev_binded(struct clk *clk)
>>>>>>  {
>>>>>>       return false;
>>>>>>  }
>>>>>> +
>>>>>> +static inline ulong clk_get_id(const struct clk *clk)
>>>>>> +{
>>>>>> +     return 0;
>>>>>> +}
>>>>>>  #endif /* CONFIG_IS_ENABLED(CLK) */
>>>>>>
>>>>>>  /**
>>>>>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>>>>>> index 267757939e0..2d754fa4287 100644
>>>>>> --- a/include/linux/clk-provider.h
>>>>>> +++ b/include/linux/clk-provider.h
>>>>>> @@ -15,10 +15,17 @@
>>>>>>
>>>>>>  struct udevice;
>>>>>>
>>>>>> +/* update clock ID for the dev = clock provider, compatible with CLK_AUTO_ID */
>>>>>> +static inline void dev_clk_dm(const struct udevice *dev, ulong id, struct clk *clk)
>>>>>> +{
>>>>>> +     if (!IS_ERR(clk))
>>>>>> +             clk->id = CLK_ID(dev, id);
>>>>>> +}
>>>>>> +
>>>>>>  static inline void clk_dm(ulong id, struct clk *clk)
>>>>>>  {
>>>>>>       if (!IS_ERR(clk))
>>>>>> -             clk->id = id;
>>>>>> +             clk->id = CLK_ID(clk->dev, id);
>>>>>>  }
>>>>>>
>>>>>>  /*
>>>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>
>>>>
>>>> I think you should ask to be picked by Tom. I don't have objection on this patch
>>>>
>>>> Michael
>>>
>>> Hi Michael
>>>
>>> For which reason ?
>>> For information, this series has been submitted to CI test : https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26358
>>> without any issue.
>>
>> Because I haven't seen activity on the clock maintainer for months.
>>
> 
> I think you misread it (or my english was really bad). Anyway I'm fine
> with this change

No worries, your english is correct ;-)
I just wondered why you requested me to ask to Tom to pick up this patch.

You are right, no one else reacted to this patch.

Tom, 

Will you pick this patch and also patches 5/6/7 to be coherent on your side ?
If not, i expect to submit a STM32 pull request before end of this week included these patches ?

Thanks
Patrice

> 
> Michael
> 
> 
>> Michael
>>
>>
>>>
>>> Thanks
>>> Patrice
>>>
>>>>
>>>>> Thanks
>>>>> Patrice
>>>>
>>>>
>>>>
>>
>>
>>
>> --
>> Michael Nazzareno Trimarchi
>> Co-Founder & Chief Executive Officer
>> M. +39 347 913 2170
>> michael@amarulasolutions.com
>> __________________________________
>>
>> Amarula Solutions BV
>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
>> T. +31 (0)85 111 9172
>> info@amarulasolutions.com
>> www.amarulasolutions.com
> 
> 
> 
