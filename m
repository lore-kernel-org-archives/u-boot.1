Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E1606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WnoV7EhG;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Uu5i2rHF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA2786073F;
	Mon, 16 Nov 2026 10:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENbXqB1lFY00; Mon, 16 Nov 2026 10:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26E696067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794825143;
	b=X2UaDs6SJttjFjNRkB8swhLKviYK5Yz9GAY11oK9YAzi/Kz9XlXbskJy7uTg/1SROuNJ
	 5MRAMOj5ylYD+jEafgUoGQ3pkUncJtssHUrl+Q9dIa/5FLsC32DTrtFAwwgJ/TU0B2XaP
	 TimZGub+xTlPVlR2clBreJnDnKNMEa4gh0euzox5nfp8WmnFq5hviqKH9P8te5wt4iY4h
	 EgQGY+fCTmRsMf/k81RGu+HzjzNO++XOJQP5dYFqeFHBJe5HP2zaXA20PVsoVjAuc7loJ
	 Bx5J3Zk/dLcsM5CVN6egtublWuloyY94+Q126Jh2pRx8pSyeLOff50ibU3rVcILhCng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794825143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wQQ81SBk+ypbxpko5+RwgOCsaglhHPIN9h8ZhHoq8k8=;
	b=V6OT5inaxlHrqCF9DpVZjjt/fHoAyLlGk2Oo3Ny6o/qfyDyC678pjeL8gzQ62dooSJ8b
	 JXutvosMnORn2Xulpz5ZSCb4GArMuCcu4nrXbrtLPeNgQrABs4tEGb0JY6qDBa3uyM8K/
	 ncYsfTcV85PsPBcDVoPZ049q3WmRUgA3swkdZ9i6uP56C6R0QEH6iY7rt2JqAlPJpUM+j
	 NvNLBCCuKO6nZdI1spU9Os7GUp7VEYvE/9E80HgOu6tgFno6X5ASe677QE2ikVcS/rCce
	 D2pf6D0XbDVWF4zbcYpwZhKN/7lgC4V7QPQSAmEtzKn3bbddUiNixbd4aTd70KkVpsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794825143;
	bh=wQQ81SBk+ypbxpko5+RwgOCsaglhHPIN9h8ZhHoq8k8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WnoV7EhGFigmxuzuD8UReCaxDk5Fc7fAlT31KvkO9Ukv9CoSmd/HZlhk7FPR4FOpk
	 B2vfVBNzpHfpy+o1hvVd2t3r6zqLVfehqNljTwUd+MuiyiYA9afS1XaVt7LGAgdG4J
	 mFc7DwfzamPooOvs4vULUtICgAdP5VePaC+sEtWbKCavs5Wvk+mMTjFwMsR6LEP0sP
	 IqUUk20Z7L6JRkSWFDNvB9P+lFYcZuNrh8Y6wdqx23quYz+6zjrIt7X234h19ZmE24
	 Sl6Stw8tH8TLYTFVp8+eV04asFCLEU8iKHjQcTS4ZfLDuAm3zv4ty0SsKGYa6Y5EPd
	 yQPw+9Eez6DUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E696067D;
	Mon, 16 Nov 2026 10:32:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB8001A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F090400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u0Lx5dftcuXW for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:32:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0941F4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::bc09"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::bc09; helo=smtp-bc09.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Uu5i2rHF
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0941F4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:32:18 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSkgz6fTdzlcr;
 Mon, 16 Nov 2026 11:32:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794825135;
 bh=wQQ81SBk+ypbxpko5+RwgOCsaglhHPIN9h8ZhHoq8k8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Uu5i2rHFrw0OgNNbo/80L1PZrYF/Fm4alRDZvKLQuFicxcsUnEdWUcBR+zo1/tYRn
 kQ954MuphwnqGwSqxEzSgxgnUZ0yuvUpdRvjTv8KjxLLxPi29MLFwtqnKixjoA3HVT
 eBcpPzObZgGDWBv7onO3y4rUSjTsDGtKfIsD6fS1zGfStrqTtExhHceG72GpiZYlYo
 +odWBr8OS/oVEbMEhRO5Q/LXEswxer2s0yA1hOQ42LubydQBSiuj4YYSY9wQRtDH/V
 RPyjELRwIZZ0h9X5g2aqC7uGij40cOxQWJuif2SCsRi/kg2cvRR2ZrfaF6Mf88WEB9
 iRqTB5A39zKUw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSkgy45Yvz13CB; Mon, 16 Nov 2026 11:32:14 +0100 (CET)
Message-ID: <57d42d3e-6b0c-40af-a16d-0643e4e63a72@0leil.net>
Date: Mon, 16 Nov 2026 11:32:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ram: rockchip: px30: allow multiple SDRAM types
 selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Joseph Chen <chenjh@rock-chips.com>,
 Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
 <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
 <CAC928Hanm2_mSEo3vuLnDQnHZ9uXTbV9pMmHfhXne7H3ONor=A@mail.gmail.com>
 <cfb5d923-8148-4087-a090-a20077a4a627@0leil.net>
 <CAC928HZvN5daTputdUxkZOkGPz-d4icga9sj+CzxtE0W6w4bsA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928HZvN5daTputdUxkZOkGPz-d4icga9sj+CzxtE0W6w4bsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo.

On 11/15/26 11:32 AM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mer 11 nov 2026 alle ore 19:08 Quentin Schulz ha scritto:
>> On 11/11/26 6:55 PM, Massimo Pegorer wrote:
>>> Hi Quentin,
>>>
>>> Il giorno mer 11 nov 2026 alle ore 16:41 Quentin Schulz ha scritto:
>>>>
>>>> Hi Massimo, Joseph,
>>>>
>>>> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
>>>>> Allow the inclusion of more than one SDRAM parameters set in the PX30
>>>>> sdram driver. The driver applies included sets in alphabetical order
>>>>> (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
>>>>> SDRAM initialization function to complete with success. This order is
>>>>> debatable and not based on any specific reason.
>>>>>
>>>>> Due to limited PX30 TPL maximum size, including support for more than
>>>>> one SDRAM type can require disabling some configuration options such
>>>>> as CONFIG_RAM_ROCKCHIP_DEBUG.
>>>>>
>>>>
>>>> @Joseph, can you help us out here?
>>>>
>>>> We are trying to do the same thing that px30_ddr_333MHz_v*.bin from
>>>> Rockchip's rkbin is doing: do DDR initialization without knowing which
>>>> kind of DDR is soldered on the PX30-based device. Is there something
>>>> special we need to do or know? For now, we are trying to initialize with
>>>> DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, then
>>>> LPDDR3 if all fails. The first DDR init that doesn't fail is deemed
>>>> successful. I do not know if this is correct, can you please provide
>>>> some guidance?
>>>>
>>>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>>>> ---
>>>>>     drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
>>>>>     1 file changed, 17 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
>>>>> index c7ff924b2c5..7f51b9c4f8f 100644
>>>>> --- a/drivers/ram/rockchip/sdram_px30.c
>>>>> +++ b/drivers/ram/rockchip/sdram_px30.c
>>>>> @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
>>>>>
>>>>>     struct dram_info dram_info;
>>>>>
>>>>> -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
>>>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
>>>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
>>>>> -     IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
>>>>> -#error "This driver only supports one DRAM configuration at a time"
>>>>> -#endif
>>>>> -
>>>>>     struct px30_sdram_params sdram_configs[] = {
>>>>>     #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
>>>>>     #include    "sdram-px30-ddr3-detect-333.inc"
>>>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>>>> +#endif
>>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>>>>     #include    "sdram-px30-ddr4-detect-333.inc"
>>>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>>>> +#endif
>>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>>>>     #include    "sdram-px30-lpddr2-detect-333.inc"
>>>>> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>>>> +#endif
>>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>>>>     #include    "sdram-px30-lpddr3-detect-333.inc"
>>>>> -#else
>>>>> -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
>>>>>     #endif
>>>>>     };
>>>>>
>>>>> +static_assert(ARRAY_SIZE(sdram_configs) > 0,
>>>>> +           "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
>>>>> +
>>>>>     struct ddr_phy_skew skew = {
>>>>>     #include    "sdram-px30-ddr_skew.inc"
>>>>>     };
>>>>> @@ -691,19 +688,11 @@ out:
>>>>>         return ret;
>>>>>     }
>>>>>
>>>>> -struct px30_sdram_params
>>>>> -             *get_default_sdram_config(void)
>>>>> -{
>>>>> -     sdram_configs[0].skew = &skew;
>>>>> -
>>>>> -     return &sdram_configs[0];
>>>>> -}
>>>>> -
>>>>>     /* return: 0 = success, other = fail */
>>>>>     int sdram_init(void)
>>>>>     {
>>>>>         struct px30_sdram_params *sdram_params;
>>>>> -     int ret = 0;
>>>>> +     int ret = 1;
>>>>
>>>> @Massimo: question: why the need to change ret to 1?
>>>>
>>>> Because the driver enforces sdram_configs array to be non-empty, we're
>>>> guaranteed to do at least one loop and thus ret is guaranteed to be set
>>>> properly.
>>>
>>> You are right, the static assert guarantees ret to be set at least once.
>>>
>>> For variables - and logic in general - which are in the local scope, I'm used
>>> to rely as little as possible on conditions and assumptions out of that local
>>> scope. But I respect different opinions and approaches, so if you prefer I can
>>> drop the initialization at all, or restore the zero init.
>>>
>>
>> Up to you, but if you keep a change to ret, have it at least -1 so it
>> obviously shows when reading that an error is expected to be returned by
>> default.
> 
> Right. BTW, the line just above sdram_init() definition says:
> /* return: 0 = success, other = fail */
> ...so 1 should be considered a valid error return value too... ;)
> 

Yeah but having this documented in the C file instead of the header is 
the wrong place, but fair enough :)

>>
>> You can also check if not setting ret doesn't actually save you some
>> bytes in the final binary.
>>
>> suggestion: Maybe:
>>
>>          for (int i = 0; i < ARRAY_SIZE(sdram_configs); i++) {
>>                  sdram_configs[i].skew = &skew;
>>                  sdram_params = &sdram_configs[i];
>>                  if(sdram_init_detect(&dram_info, sdram_params))
>>                          continue;
>>
>>                  sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
>>                  return 0;
>>          }
>>
>>          return -1;
>> }
> 
> I will try some alternatives to find the best in size, thanks for the
> suggestion.
> 
> BTW, do you mean that I can also drop the printascii("out\n")? Really?! More

Yes.

> than six years ago Miquel Rynal provided a patch that Kever accepted [1][2]

Probably was forgotten :)

> but it has never landed into main (master at that time) branch really.
> That "out" on console really annoys me!
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20200317153217.1493-1-miquel.raynal@bootlin.com/
> [2] https://lore.kernel.org/u-boot/32e592dd-4a7e-ddaa-a4e0-e61686006a3f@rock-chips.com/
> 
>>
>> can make the binary even smaller without the need for the ret variable
>> at all and removes a bunch of if conditions/jumps and is also valid
>> without the static_assert on the sdram_configs array.
>>
>> thought: I'm also not sure why we have a global dram_info? If it's not
>> needed, then we can have it as a function-local variable in sdram_init
>> and initialized in one go:
>>
>> struct dram_info dram_info = {
>>          .phy = (void *)DDR_PHY_BASE_ADDR,
>>          .pctl = [...]
>> };
>>
>> if it needs to be global, we can still initialize it in one go and avoid
>> the multiple assignments in sdram_init.
> 
> I have a few other optimizations, as mentioned. I will send a dedicated series
> for them, after this one.
> 

So... I would really like to have someone with knowledge about DRAM init 
in general (and/or someone at Rockchip) tell us how to correctly init 
the DRAM if we don't know its type before merging the "support multiple 
DRAM type at once and try all types to find one that works" part of the 
series. At the same time, I don't think we should make all improvements 
to DRAM init/drivers in U-Boot depend on that part being merged, so I 
think we can maybe split this into two series. One for preparing for 
support for multiple DRAM types, and one (a single patch I'm guessing) 
for enabling multiple DRAM types on PX30 so that it can take more time 
and not block the rest? What do you think?

Cheers,
Quentin
