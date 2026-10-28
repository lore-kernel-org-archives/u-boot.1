Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC794606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VezDxpM0;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=jx4B8oO6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B55B84078E;
	Wed, 28 Oct 2026 14:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nB0HpRhuW-rB; Wed, 28 Oct 2026 14:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B829840742
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199328;
	b=JNo1rOUlJiJU8DC17/swTF3/fX80qU3lZGF3OCWQtrHdTJvdrMKhxUE5o7MOmCcZrEMH
	 0CIJzJ3Ar+ipqX6BO3TXUoOwmxauBz2UNRrglK0/cRsKl9hepkEPfaixyRK0ufXOiEI+Z
	 d0e6mJGkE7IgdnoXCyCnrkloyC8/dEWs2/XIpPyGcvOnuHjLs6WHWIuwZal53LMJPcr7u
	 LEH0stQU6OrMxp21z5YuZyv/XuIZE50Mn072T3n3lgnUm3XeSEaZZtEJBbnVooo81C34z
	 rv2n9LxCMfr69jImwNCJAqIKYkTK3SSJJXimsffCylYrqY5/fzy7XIidvx8grJpSWFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kn7n0LoaAR+coxWEISRR3y83QRG0wljHlF3IUXpJcbQ=;
	b=C6fhDpw8HXGBBR9eeKJdZGx0ryZq7FN+39hYe2iMTCfSzn7e6Txby75NhPIXIFHVkmK2
	 tin8f0aLxLvGL8qW/SpkfI1USbDXI0YEPf3vmAbLeJsGLsB9aO+3G+m7oy9idfPet0LHa
	 vVdPlx6jcaqwryv64kw3+P+K02Rvx/P4ZXMKlQDcc710VY3/r9HNp4NikRY5nixPJ1834
	 Z0cIsDyyHN+bvwGzMewApTXi/22mjXCQApMvYPudtn/m3WTwzL7JYTwcU1X6IkJthfvNM
	 5NIrpqDhOA02eQ+763F5scFcg90uVMaVZaLRa/KZ0Xf91rAi34rZ/xWUHkfRSffP0ew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199328;
	bh=kn7n0LoaAR+coxWEISRR3y83QRG0wljHlF3IUXpJcbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VezDxpM0AfbZczXY9M58HEGWp6cRSuUwo3GhNeK5UaM1XQEPXL++iMbBmVl56VXpN
	 GaChxQzCDaMyVqOWHaGJ6viqV4bAsf4pYmHSJEry3AP1rnSaX5uCTB+IAgufr0/5Kc
	 gTHsFgW3pN8hAABShqLdi6NBoOfG1N5HSySEfGWfAuR4mhap5jLJnxaksDf3PBnAqx
	 R56dfmyXG3TSsXklJi2dul/AaBBpjgvS6wc4iKxDq+Z/LQYwMkuqem1gtZWDLXRNb2
	 ShMtAXT/4GX4lPky8VbRzfmDqyES/GBiNAgUNFbLiv8hjEGiGTk3zDVETXPviZPVV+
	 fr9yvR/rUJs7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B829840742;
	Wed, 28 Oct 2026 14:55:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECCB64D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2C6C81162
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96UUh5f4C4QR for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A54581108
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199324;
 b=dc6xAKO99UYu5gCaFkYmvj27W/B6ny752aiHU//wJEdn8FPJ2yMQmhwZmOB7C/8cvSsb
 s9h2PAaKOFbXBUOul1LgL/VDP7FS6moKEo7Paac+D5eeWBuTqT1WJz5QHUKqHzi6WCE32
 Xw222FI0nhLREXjtIGAqh7b0kk+oh99ThetkiZsQb6JXkuP1ArAhRTx4m29e6/mqEziOX
 FzNfjrZLBztKAO1h8hQ0BxmF6l98OHVUHvqISta2ZOxzD2qOex9KJM93cB3wm3ynrFDwd
 +jYx++hqDb3z9JaCLYfsHPQlNo+8UamHHaFZi6GfhXB9UL7N/K7FppDRK5QiohWaIkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199324;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=kn7n0LoaAR+coxWEISRR3y83QRG0wljHlF3IUXpJcbQ=;
 b=XyRCNlIgYFi0WZwkB28hFcrJr5qShu1LpENCt0ecsUhUBbsINav66eOCeD2qNQ19f/1p
 xeSBfmbiBj107Kp2meUdzuDj0h3oy4KB3xhEgxv3HJwXyyVsXulMWKTt7hyM9xqoalTHi
 8buQQT3oi+hXIHnF+Xvl/zr+QbjNMnchVmm6Mhfp1yGcPF+s8jsdR2kNxHro8UateNGPh
 ZqPYH9IBU77XlBcPYZHozy2jLSjB5vB62gQuU9D9Fm9uxINgEEmiycFs5HOYG45a7284A
 o+87zkf93BziVC9ceCE+XKWKNZVxyp6eMNVMgxGSHKIW3LoNN0R74L1IvK0c5kLa5Vw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jx4B8oO6; 
 arc=none smtp.remote-ip=45.157.188.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.13;
 helo=smtp-bc0d.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jx4B8oO6
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A54581108
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:55:23 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jF9QK1qrpz2G3m;
 Wed, 28 Oct 2026 15:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793199321;
 bh=kn7n0LoaAR+coxWEISRR3y83QRG0wljHlF3IUXpJcbQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jx4B8oO60H+NUB5mRnit8kv+4EycpqRRJpE82YWcmcWgrPOgX6eStAvpHTddbEA6Q
 Kq7vY8Wh4ZUplyWFKfLkzVt1EezrYyUnP5FZItFElP4exAVjx3ON5n7YNK1h10bs/v
 YTXF6LHZyZCY213lRpLZ1vQcrZcIMwLxzcXqGEXSCEmYZCu/utv2qWhH2syqq1WMCn
 qCrHGrRSDVWkm/I/zb8MBv+Ai17SNVItwHEE2kyxjHZV9gtc1Tyu4XIIwQH3aK2CZi
 IHW+zscvIbJJ0xUP1tLqnPX1U+Vet+uc03Y/4hVwVgs68Q/E96LoJaIJI/zP41W5yq
 xH+pTghWKm61w==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jF9QJ1swLzS56; Wed, 28 Oct 2026 15:55:20 +0100 (CET)
Message-ID: <2d4f0189-e3f2-48a9-9a11-c639f25f5e9d@0leil.net>
Date: Wed, 28 Oct 2026 15:55:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ram: rockchip: improve ddr type configs selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
 <20260829-ddr-multi-v1-1-c0c7837aed20@gmail.com>
 <8a92f1ee-08c4-4f55-b0df-8098c4da7c1f@0leil.net>
 <CAC928HZy+Gf+bTk3OHGD=zsUT0D_OzEU2MZ9_Tuf0VdBOnM6rQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928HZy+Gf+bTk3OHGD=zsUT0D_OzEU2MZ9_Tuf0VdBOnM6rQ@mail.gmail.com>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/22/26 7:57 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno gio 8 ott 2026 alle ore 22:49 Quentin Schulz ha scritto:
>>
>> Hi Massimo,
>>
>> Thanks for the patches. Note that the timing is interesting as we were
>> considering having two variants of the same product, one with DDR3 and
>> one with DDR4 and we don't want to have with deal with multiple binaries
>> just for that.
> 
> Good to know!
> 
>>
>> On 8/29/26 7:03 PM, Massimo Pegorer wrote:
>>> Not all the DDR type config options named in the Kconfig are supported
>>> by each one of the Rockchip SoCs. Moreover, the LPDDR4 option has a
>>> different meaning in the context of the RK3399 SoC than in the RV1126
>>> one. Improve clarity splitting config options, using SoC specific help
>>> sections and adding depends on conditionals.
>>
>> Yeah, we shouldn't do that.
>>
>>>
>>> Involved Rockchip SoCs are: RK3399, PX30, RV1126.
>>>
>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>> ---
>>>    drivers/ram/rockchip/Kconfig | 29 ++++++++++++++++++++++++++++-
>>>    1 file changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
>>> index d707d09c1c8..61a3193b3f5 100644
>>> --- a/drivers/ram/rockchip/Kconfig
>>> +++ b/drivers/ram/rockchip/Kconfig
>>> @@ -26,26 +26,53 @@ config RAM_ROCKCHIP_DEBUG
>>>
>>>    config RAM_ROCKCHIP_DDR4
>>>        bool "DDR4 support for Rockchip SoCs"
>>> +     depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>>
>> This kind of change is very welcome.
>>
>>>        help
>>>          This enables DDR4 sdram support instead of the default DDR3 support
>>>          on Rockchip SoCs.
>>>
>>
>> We should get rid of the part that says "instead of the default DDR3
>> support". We should have instead an option for DDR3 which is enabled by
>> default and then we don't have to care about that part.
> 
> OK, I can add a new config option for DDR3. But in this case, we will also need
> to check at build time that at least one config option has been selected.
> 

That could easily be done by having an invisible Kconfig symbol which is 
selected by all of the DRAM types. Then we can have a

ifneq (CONFIG_ROCKCHIP_AT_LEAST_ONE_DRAM_TYPE,y)
$(error At least one DRAM type needs to be selected)
endif

in drivers/ram/rockchip/Makefile or something like that.

>>
>>> +       Note that even if multiple DDR/LPDDR types are selected, support is
>>> +       enabled only for the selected one that comes first in the following
>>> +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
>>
>> This one change though is less welcome. I don't want to have this in the
>> Kconfig help text. I suspect nobody will maintain this in the long term.
> 
> I'm just describing the status quo. I agree there is a risk, but what do we
> prefer? The risk that nobody will maintain this in the long term, or the
> certainty the config options help is providing wrong information?
> 

Fail the build if there's more than one selected in a driver that only 
supports one at a time.

> A trivial Kconfig choice would solve the issue, of course, but as I would like
> to support multiple DDR configurations with the next patch, it is not the way.
> 

Yes, that's not the right choice indeed.

>>
>>> +
>>>    config RAM_ROCKCHIP_LPDDR2
>>>        bool "LPDDR2 support for Rockchip SoCs"
>>> +     depends on ROCKCHIP_PX30
>>>        help
>>>          This enables LPDDR2 sdram support instead of the default DDR3 support
>>>          on Rockchip SoCs.
>>>
>>> +       Note that even if multiple DDR/LPDDR types are selected, support is
>>> +       enabled only for the selected one that comes first in the following
>>> +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
>>> +
>>>    config RAM_ROCKCHIP_LPDDR3
>>>        bool "LPDDR3 support for Rockchip SoCs"
>>> +     depends on ROCKCHIP_PX30
>>>        help
>>>          This enables LPDDR3 sdram support instead of the default DDR3 support
>>>          on Rockchip SoCs.
>>>
>>> +       Note that even if multiple DDR/LPDDR types are selected, support is
>>> +       enabled only for the selected one that comes first in the following
>>> +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
>>> +
>>>    config RAM_ROCKCHIP_LPDDR4
>>> +     depends on ROCKCHIP_RV1126
>>>        bool "LPDDR4 support for Rockchip SoCs"
>>>        help
>>> -       This enables LPDDR4 sdram code support for the platforms based
>>> +       This enables LPDDR4 sdram support instead of the default DDR3 support
>>>          on Rockchip SoCs.
>>>
>>> +       Note that even if multiple DDR/LPDDR types are selected, support is
>>> +       enabled only for the selected one that comes first in the following
>>> +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
>>> +
>>> +config RAM_ROCKCHIP_LPDDR4
>>> +     bool "LPDDR4 support for Rockchip SoCs"
>>> +     depends on ROCKCHIP_RK3399
>>> +     help
>>> +       This enables LPDDR4 sdram code support for the platforms based
>>> +       on Rockchip RK3399 SoC.
>>> +
>>
>> Please do not duplicate the same symbol twice just to change its helptext.
> 
> Ok, but please consider that RAM_ROCKCHIP_LPDDR4 has two different meanings,
> one in the context of RK339 and another in the context of RV1126.
> 
> Within RV1126, it means including LPDDR4 support and not including neither the
> support for DDR4 nor the one for DDR3 (RV1126 can support: LPDDR4, DDR4, DDR3).
> This is like all other DDR config options that apply to PX30 and/or RV1126.
> 
> Within RK3399, it means including LPDDR4 support and... ...not clear to me
> (indeed I left its help text unchanged): the RK3399 SDRAM driver seems able to
> support multiple DDR types by default (which ones I do not know, DDR3 and LPDDR3
> at least), and LPDDR4 support seems to have been added on top. I would say that
> with this config option selected DDR types other than LPDDR4 will not work, but
> I am not sure.
> 
> Therefore, would you prefer a single help text with two paragraphs, one
> describing the RV1126 scenario and another for the RK3399 one? But for the
> RK3399 default case, what config option should be used? The suggested new DDR3
> one would not fit. For all these reasons, I would suggest having an RK3399
> specific LPDDR4 config option, something like RAM_ROCKCHIP_LPDDR4_RK3399,
> because it is a really different scenario.
> 

Just don't describe any of it outside of "DDR4 support". The symbol 
should only be selectable if the SoC supports the DRAM type. For drivers 
that support multiple types at once, let them be all selectable. 
Otherwise, have the build fail if more than one are selected (e.g. from 
within the driver directly). I would say most boards will only select 
one anyway and you likely know which one you need for your board.

>>
>> For drivers that support multiple DRAM types but not at the same time,
>> the easiest answer would be to enforce that outside of Kconfig with
>> something like:
>>
>> #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4) +
>> defined(CONFIG_RAM_ROCKCHIP_DDR4) + defined(CONFIG_RAM_ROCKCHIP_LPDDR2) > 1
>> #error "This driver only supports one DRAM configuration at a time"
>> #endif
>>
>> in the driver. I don't like it too much as this should really be in the
>> Kconfig symbol but I couldn't think of a way to easily have only one
>> symbol among a list to be allowed to be selected (that's typically a
>> choice Kconfig) and also have the same symbols allowed to be selected as
>> many as possible, depending on the SoC. I think it's a good compromise
>> for now to fail the build by having this kind of check in the driver.
> 
> I agree with you, both on what you do not like and on what should really be,
> too. I will follow the suggested approach in v2.
> 
>> However, this won't play nice with COMPILE_TEST so not sure if it's
>> acceptable to Tom.
> 
> I know nothing about COMPILE_TEST, but I see xPL builds depends on
> !COMPILE_TEST. And PX30 and RV1126 SDRAM support code is part of xPL,
> therefore could not be a problem, maybe.
> 

CONFIG_RAM exists, so it's also available in proper, where COMPILE_TEST 
could be selected?

>>
>> Ideally, we should also figure out which DRAM type(s) are supported by
>> DRAM drivers that do not make use of the Kconfig symbols. e.g. RK3066
>> for example, and have them explicitly enabled in Kconfig for
>> completeness. That isn't required for this series.
> 
> With which purpose? If there is nothing to select/deselect at configuration
> level, I would avoid this. Instead, I would add the information in the
> documentation.
> 

Consistency but also to prepare the driver for more types to be 
supported in the future. But again, nothing required for this series.

Cheers,
Quentin
