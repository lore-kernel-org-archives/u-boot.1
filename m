Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3218606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OiD3IRMz;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=i/D2LZw1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 576E6606CA;
	Mon, 16 Nov 2026 10:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHrii8mNvy6I; Mon, 16 Nov 2026 10:24:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9250960607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824655;
	b=jktNyB+tzkh8tdSrcpbMLvH26e2GZEAviJ9RUt9fvwkbEjKqMq6wOf50iKjFB3cJc5KH
	 1T3XHoEPsK0Vh4kY0qFLvWt/eZvOMgolxn6EqxPE2Dbw9IUyUIC7x5JSLVn1R0v75wOjm
	 kWiL294wxbbpEJ48k9pgGC0rP095E2VhJYzT1L/Bp8j+tWhMJM7tJIwHWnZvnpz0DYmfW
	 ufSr1qAcdLnCWaF3PsR7xVj3zxJkOp/esMe8mmAJU5E35FnaNlhiN8gm3VXqjG1E41i06
	 1mmfAYjt9umptjnJhWmr2dVHS3R8gsy0QT9thRr17ktwm16tc7a/LMs02qwiurhY4vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=asVi+bqFwbbHbwHjAx6iJ78NBtSMSB5fJYf1KJFCxN4=;
	b=BGYOIygFzCST8kUPkpbV+esp6YgraUdgK9O/KMDDgYqSnL/UKKaKBdOc8jq1OPwzupNd
	 KBbUMq+3IPRjfc71p2csEWp5bWUcHLtcc37pBAuC6/agSDgneDh3E0N1+gONROUKH09in
	 GsYAiBN7vOL/uPMjelOHfN5u3aUr/vRQnWYpTsNXKWx99i8vBFwiPp9tdwiKqJG++HFui
	 a2nt5qhKLLrpjy5NWT651li6OxLU2ya8erXqOcA1DM+6sww8mVJnD09Mkz3iROVvuJVNw
	 11j9KeWBcQCJDH2i9tBBbUyvOR7F/Xom5FZpdFAmYPykjxnonDc5pW0jYLdSFN4jqmg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824655;
	bh=asVi+bqFwbbHbwHjAx6iJ78NBtSMSB5fJYf1KJFCxN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OiD3IRMzFT+el+AKKEmqtkm82xtZmD5w6ryc+5Qm6ntF8tWDmDYg6qe7euRTPenFv
	 SqMtiSscT8a7ak3utl9L+ma+KJCQ7skE4b9DYPbKoQsjxTx0ubMlmu4E4aA5Mcur9U
	 pqlHcSofKlFlz9JYjtwRhc2p92uM97rHKslSIHCgQBhkurARs44vosJDe83SsQ9HMF
	 tMlgfFSdra85EWjXqsmnpQSa+JpHfq7h8cGt0CXYEM2qfISzecaNPDceMQ1nLn4eFh
	 wq0pA8m7KZXQXr8b4f6KPFS5kXKPai0qE3imtVJq9bFmQbANIknpiAvQRUX+9BLsOd
	 Q2WjooVCyZytg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9250960607;
	Mon, 16 Nov 2026 10:24:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7AB81E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77FCB4061B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMZFZNiIgHiP for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB66A405FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::8fae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::8fae; helo=smtp-8fae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=i/D2LZw1
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::8fae])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB66A405FF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:24:10 +0000 (UTC)
Received: from smtp-4-0001 (unknown [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSkVb6RvfzqcH;
 Mon, 16 Nov 2026 11:24:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794824647;
 bh=asVi+bqFwbbHbwHjAx6iJ78NBtSMSB5fJYf1KJFCxN4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i/D2LZw1vJZmFSdb1y/w63cR/wOVkFagATQMdASmvWWELsJYABQ13rclV++WZiA8Z
 ws8EJlozpmS4aA2ytif8pVUEW9ZTcdzPqQher2UEp3jRKQ3zphsLnPOEEIOpNSOre1
 a/x24vttNLV6JK+ELDR/8ZRkDOY3dqnVukEOJ9iYfVZ+aKpk3rCGi+a9Ghjjlgi4w6
 YRAF0n3UcZeHbKNpUOUxgzds8j7i/9RbcInJv7iUdSsolcFx2LFCAyz1r1vfNiHJhJ
 7jQZ31b83ZIv12QcpNPycyy56neNgALnXB1A3B2TGKV75VCqpVLovRhV3I81AN4qlc
 seHeeW784MHCw==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jSkVZ6Jxjzs83; 
 Mon, 16 Nov 2026 11:24:06 +0100 (CET)
Message-ID: <aebb12b4-2d27-455d-a801-468c1952d41f@0leil.net>
Date: Mon, 16 Nov 2026 11:24:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ram: rockchip: improve sdram type configs selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-1-b82ff9c860ba@gmail.com>
 <1fba6d0c-acac-4495-bdf4-58765efedce0@0leil.net>
 <9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net>
 <CAC928HaChzVVKU1LzcO13pMiQuCiq66z3v47zcLxyuodD3pL3g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928HaChzVVKU1LzcO13pMiQuCiq66z3v47zcLxyuodD3pL3g@mail.gmail.com>
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

On 11/15/26 11:30 AM, Massimo Pegorer wrote:
> Hi Quentin
> 
> Il giorno mer 11 nov 2026 alle ore 17:08 Quentin Schulz ha scritto:
>> On 11/11/26 4:31 PM, Quentin Schulz wrote:
>>> Hi Massimo,
>>>
>>> On 10/25/26 8:30 PM, Massimo Pegorer wrote:
>>>> Not all the SDRAM types config options named in the Kconfig are
>>>> supported by each of the Rockchip SoCs: improve clarity adding SoC
>>>> dependencies to the options.
>>>>
>>>> Add a new RAM_ROCKCHIP_DDR3 option and remove PX30 and RV1126 sdram
>>>> drivers fallback behaviour when no SDRAM type option is selected,
>>>> raising a compile time error in this case, instead. The new option
>>>> has a default true value if no other SDRAM option is true to avoid
>>>> impacts on defconfigs.
>>>>
>>>> Moreover, these drivers support only one SDRAM type at a time: when
>>>> more options are selected, avoid debatable preemption of one over the
>>>> others, and raise a compile time error instead.
>>>>
>>>> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>>> ---
>>>>    drivers/ram/rockchip/Kconfig        | 24 +++++++++++------
>>>>    drivers/ram/rockchip/sdram_px30.c   | 17 +++++++++---
>>>>    drivers/ram/rockchip/sdram_rv1126.c | 54 ++++++++++++++++++++
>>>> +----------------
>>>>    3 files changed, 60 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
>>>> index d707d09c1c8..f51ae6a4542 100644
>>>> --- a/drivers/ram/rockchip/Kconfig
>>>> +++ b/drivers/ram/rockchip/Kconfig
>>>> @@ -24,28 +24,36 @@ config RAM_ROCKCHIP_DEBUG
>>>>          This is an option for developers to understand the ram drivers
>>>>          initialization, configurations and etc.
>>>> +config RAM_ROCKCHIP_DDR3
>>>> +    bool "DDR3 support for Rockchip SoCs"
>>>> +    depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>>>> +    default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
>>>> +        !RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
>>>> +    help
>>>> +      Enable DDR3 sdram support on Rockchip SoCs.
>>>> +
>>>
>>> issue: too much done in one commit
>>>
>>> Please split this into multiple commits. I could identify:
>>> - add SoC dependency for existing DRAM Kconfig symbols (with the change
>>> to the helptext to make it generic)
> 
> I will do it in v3.
> 
>>> - add new DDR3 symbol and gate existing code with it. That is, rv1126
>>> and px30 should have their #else for their DDR3 timings gated by this
>>> symbol. A new #else can call #error so the build fails in case of
>>> incorrect configuration, like you did here,
> 
> I will do it in v3. Do you agree on keeping in this commit the default y for
> the new DDR3 symbol if none of the other RAM_ROCKCHIP symbols are selected?
> This should avoid affecting defconfigs.
> 

For now yes, but we should think mid-term/long-term about just enabling 
the symbol in the defconfigs then it makes explicit what the board is 
supposed to use?

Looking at qconfig.py output:

$ ./tools/qconfig.py -f SPL_RAM RAM_ROCKCHIP '~ROCKCHIP_EXTERNAL_TPL' 
'~RAM_ROCKCHIP_DDR4' '~RAM_ROCKCHIP_LPDDR2' '~RAM_ROCKCHIP_LPDDR3' 
'~RAM_ROCKCHIP_LPDDR4'
47 matches
chromebit_mickey chromebook_bob chromebook_jerry chromebook_kevin 
chromebook_minnie chromebook_speedy eaidk-610-rk3399 evb-px30 evb-px5 
evb-rk3229 evb-rk3288-rk808 evb-rk3328 evb-rk3399 ficus-rk3399 
firefly-px30 firefly-rk3288 firefly-rk3399 miqi-rk3288 mk808 
nanopc-t4-rk3399 nanopi-m4-2gb-rk3399 nanopi-m4-rk3399 nanopi-m4b-rk3399 
nanopi-neo4-rk3399 nanopi-r2c-plus-rk3328 nanopi-r2c-rk3328 
nanopi-r2s-plus-rk3328 nanopi-r2s-rk3328 odroid-go2 
orangepi-r1-plus-lts-rk3328 orangepi-r1-plus-rk3328 orangepi-rk3399 
phycore-rk3288 popmetal-rk3288 puma-rk3399 roc-cc-rk3328 
rock-pi-e-rk3328 rock-pi-e-v3-rk3328 rock-pi-n10-rk3399pro 
rock-pi-n8-rk3288 rock2 rock64-rk3328 rock960-rk3399 rock tinker-rk3288 
tinker-s-rk3288 vyasa-rk3288

For RK3288/RK3328, it doesn't seem to matter which DDR type is enabled 
in Kconfig as all is compiled, and the DDR type is detected from the 
boards' Device Tree (via OF_PLATDATA) at runtime. If we want to be 
pedantic, we can check the dram type selected in the Device Tree via the 
rockchip,sdram-params property and select that in the defconfig as well.

For RK3399, the only thing that matters right now is "LPDDR4 enabled or 
not", the "not" part seemingly means "DDR3/LPDDR3". We can know which 
applies to which board by looking at which of 
arch/arm/dts/rk3399-sdram-* dtsi is included in the Device Tree used in 
U-Boot, and then update the defconfigs to reflect that.

For PX30, it's explicitly DDR3 when nothing else is selected, so we can 
simply enable it in all defconfigs that don't enable any other, so 
evb-px30, firefly-px30, odroid-go2).

For PX5/RK3368, only DDR3 is supported, so we could enable it for all 
defconfigs.

For RK322x, while the driver supports multiple DDR types, we only have 
DDR3 used in the EVB, so we can simply enable it on that device tree.

> I will also drop defined/IS_ENABLED substitutions, see below about this topic.
> 
>>> - enforce only one selectable DRAM init for PX30 and RV1126,
> 
> I will do it in v3.
> 
>>>
>>>>    config RAM_ROCKCHIP_DDR4
>>>>        bool "DDR4 support for Rockchip SoCs"
>>>> +    depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>>>>        help
>>>> -      This enables DDR4 sdram support instead of the default DDR3
>>>> support
>>>> -      on Rockchip SoCs.
>>>> +      Enable DDR4 sdram support on Rockchip SoCs.
>>>>    config RAM_ROCKCHIP_LPDDR2
>>>>        bool "LPDDR2 support for Rockchip SoCs"
>>>> +    depends on ROCKCHIP_PX30
>>>>        help
>>>> -      This enables LPDDR2 sdram support instead of the default DDR3
>>>> support
>>>> -      on Rockchip SoCs.
>>>> +      Enable LPDDR2 sdram support on Rockchip SoCs.
>>>>    config RAM_ROCKCHIP_LPDDR3
>>>>        bool "LPDDR3 support for Rockchip SoCs"
>>>> +    depends on ROCKCHIP_PX30
>>>>        help
>>>> -      This enables LPDDR3 sdram support instead of the default DDR3
>>>> support
>>>> -      on Rockchip SoCs.
>>>> +      Enable LPDDR3 sdram support on Rockchip SoCs.
>>>>    config RAM_ROCKCHIP_LPDDR4
>>>> +    depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
>>>>        bool "LPDDR4 support for Rockchip SoCs"
>>>>        help
>>>> -      This enables LPDDR4 sdram code support for the platforms based
>>>> -      on Rockchip SoCs.
>>>> +      Enable LPDDR4 sdram support on Rockchip SoCs.
>>>
>>> Because I checked, and for future reference:
>>>
>>> PX30 supports LPDDR2/LPDDR3/DDR3/DDR4. Only one selectable at a time
>>> currently.
>>> RK3368 only supports DDR3.
>>> RK3066 supports DDR3/LPDDR3 but only DDR3 is used (MK808 device,
>>> configuration via Device Tree and OF_PLATDATA)
>>> RK3188 supports DDR3/LPDDR3 but only DDR3 is used (Radxa Rock,
>>> configuration via Device Tree and OF_PLATDATA)
>>> RK322x supports DDR3/LPDDR2/LPDDR3 but only DDR3 is used (RK3229 EVB,
>>> configuration via Device Tree and OF_PLATDATA)
>>> RK3288 supports DDR3/LPDDR3, both used via e.g. Rock Pi N8 (LDDR3) and
>>> Rock2 Square (DDR3), configuration via device tree and OF_PLATDATA)
>>> RK3328 supports DDR3/LPDDR3/DDR4, all used, via e.g. Rock Pi E (DDR3),
>>> Rock64 (LPDDR3) and Orange Pi R1S Plus (DDR4).
>>> RK3399 supports DDR3/LPDDR3/LDDR4, all used, via e.g. Puma (DDR3), Gru
>>> Bob (LPDDR3), PinePhone Pro (LPDDR4). Either DDR3/LPDDR3 or LPDDR4, not
>>> both. We should check for this in the driver.
>>> RV1126 supports DDR3/DDR4/LPDDR3/LPDDR4, but no timings for LPDDR3. Only
>>> one selectable at a time currently.
>>>
>>
>> And RK3036 only has DDR3 boards supported.
> 
> I think this information, even if available in the public domain, could be
> useful also in U-Boot Rockchip documentation: would you like me to try to add
> it to the documentation within another series? It could be useful to know if
> these drivers have ever been tested/used in the past with RAM types currently
> not used by any of the boards maintained in U-Boot.
> 

The reported support is for the DDR driver, not the DDR controller, just 
to be clear. There may be more supported by the controller (or fewer if 
the DDR driver was copied over from another SoC's DDR driver). I also 
didn't do an in-depth check, just that the code checks for the 
dram_type/dramtype and does something remotely useful with it.

I don't know where you'd want to put this information, even less so if 
it's really relevant? Can you tell me what you're thinking, maybe 
that'll give me some idea or inspiration where to put this section :)

But in general, more documentation = better from my side :)

>>
>>> The common theme though is that they are all configured via Device Tree
>>> (via OF_PLATDATA) where the dramtype is hardcoded, and this here would
>>> be the first to try to do autodetection of the DRAM and init properly.
>>>
>>>>    endif # RAM_ROCKCHIP
>>>> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/
>>>> sdram_px30.c
>>>> index 37e62120504..c7ff924b2c5 100644
>>>> --- a/drivers/ram/rockchip/sdram_px30.c
>>>> +++ b/drivers/ram/rockchip/sdram_px30.c
>>>> @@ -123,15 +123,24 @@ u32 addrmap[][8] = {
>>>>    struct dram_info dram_info;
>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
>>>> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
>>>> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
>>>> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
>>>> +#error "This driver only supports one DRAM configuration at a time"
>>>> +#endif
>>>> +
>>>>    struct px30_sdram_params sdram_configs[] = {
>>>> -#if defined(CONFIG_RAM_ROCKCHIP_DDR4)
>>>> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
>>>> +#include    "sdram-px30-ddr3-detect-333.inc"
>>>> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>>>>    #include    "sdram-px30-ddr4-detect-333.inc"
>>>> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>>> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>>>>    #include    "sdram-px30-lpddr2-detect-333.inc"
>>>> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>>> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>>>
>>> question: what's the benefit to switch defined() to IS_ENABLED?
> 
> None. Having checkpatch complain with - WARNING: Use 'if
> (IS_ENABLED(CONFIG...))'
> instead of '#if or #ifdef' where possible - I misinterpreted and
> supposed to make
> it quiet in this way. I was wrong and I did not notice checkpatch was
> not quieter
> at all, obviously. Sorry. I will avoid in v3.
> 

Yeah, sometimes we cannot avoid the checkpatch warning, the usecase here 
for example. But no worries, I was just wondering if I had missed 
something :)

>>>
>>> It almost made me miss the fact this reorders the DRAM timings array.
> 
> I wrote about the reordering based on alphabetical criteria in the cover letter
> description, and cited it in the v2 changes list, too. Can I help if I put the
> version changes list per patch instead of grouped in the cover letter?
> 

Yes but it'd be best if we don't have to look at the cover letter to 
understand why a specific change was made.

>>>
>>> I think the reordering should be made in a separate commit, possibly the
>>> one where it's possible to select more than one
> 
> In v3, the reordering will be within the "more than one" commit. Right now,
> that commit affects PX30 only, but reordering will impact RV116 code, too:
> I would prefer to keep the ordering criteria (alphabetical) shared between
> all Rockchip SoCs.
> 

I think it may be premature to do the same for the RV1126 as we don't 
know if it's going to work with multiple DDR types, except if you have 
access to boards with an RV1126 with different DRAM? I agree it'd be 
best if we had the same order for DDR types... for drivers that actually 
try to auto-detect the DDR type at runtime, which none do at the moment 
except PX30 with this series.

I think we need to document which configurations are tested for which 
SoCs. So for example, for PX30 we could say in the docs that DDR3+DDR4 
enabled in the same config is tested, but nothing else. At least it'd 
set the expectations.

> If you prefer reordering in a dedicated commit instead, let me know and I will
> split reordering from "more than one".
> 
> I will send the v3 rebased on next after Monday merging.
> 
> Thanks for your time and your support. I really appreciate.
> 

And thanks for reviewing other people's patches :)

Cheers,
Quentin
