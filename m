Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D279CC6B29
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F62C406A3;
	Wed, 14 Oct 2026 08:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAV53UQIHv38; Wed, 14 Oct 2026 08:48:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C8D0405B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967684;
	b=ZMepaVCxAO5Ftz0kZaFRby8ksF1BlcM9/rh7bDlzJ1b0oP4TSTj8z/uoQSgXFhZT5Ub3
	 9+gErw7OSqm7T3sqnp6Aq1HcOhNtWNMrHjBSlp1+vgEn3McJIc+8PI3pSjZXgc3ceuVRE
	 aFR5LY/5zmch4+PQ0Vt36pVe5wEEUSm7TybBxl02XlUFZUTPPVJ45GfZ8t5/kluMZxqZw
	 rERKYbzr4Wa4GXvED/TgiGCeY2dHMwk0BVvY1R3UDYrf+juvZZG9Bl5yuK3pzY1Hf+cnq
	 YOQ3g8ZPY2U0DZSM7M/iZsqPSlVZy0h1mfuJu3jSEUWnZmnZhca+cgWc3iEv5dZxf7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9FTXtPIYYmSfgfdSnZ8evLeSo5wEIlHgi2+MmtN9nto=;
	b=mFeMuq85ceVfj7rhR5Vobj47PWOBW1kU8USLqOkrzqmk+n69Yv59OuIT2MydRGUgaxqh
	 wVd/VdCMfiSnXF0E570QNqxKnVN1sUWU8yOQhs/7zYVZNXPtu41dJmnQR3gFuLU+I10/g
	 hARDnjUvA5mzoyLOOPjlTjFqv9fEeaZwtQXR+xnTOHpF6Rpcynr2LEBkJ+rgXJayLNO2z
	 YC36xJ+jb8x5pDtk2NixdkGkxhQi67Lx2BpIs5iyrpMmugBdYsQf/xQUoNnD5eZKxYSUs
	 +mLkVDDYJGVT+gditKJ6GZ3PYJBEqaaDeDgWjdT01vTCjdqPtJz7Gco3UeHWvR8K7mQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967684;
	bh=9FTXtPIYYmSfgfdSnZ8evLeSo5wEIlHgi2+MmtN9nto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U0HgKI2RUxDVV+2V72ReujprhIyCdcibZpBQDviWSt1W6DjxKio7sdtejWSKsgjFJ
	 6CZF+fP9UjPykyivxZjQ88loGBtPjG8X/A1sqHatVAeEZ7+KjlodvteeNgm67iDgTr
	 Re4TpDMIgPcLd0ibITEUtHF7yM6qLpRtMukVF9gC8V33iNtkYvPGQv+TaeIi06Cz1f
	 VSVWrC1X/P1gfq3ozHSDBFzlyHr6+IQVwUtWFM+R3+yjngaxdV6f+KKrCZvb2QfqT4
	 c4BEAOqxXWPskLywZ7pfhlF5agsI4/o1CMF27/bb9cm8zWWwDbaBing7VDMucyYOnm
	 WFjUNpHlGou1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C8D0405B0;
	Wed, 14 Oct 2026 08:48:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65EAA255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57A0C607EC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEEQhrvZVnlx for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:48:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4ED086079F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.173
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967682;
 b=pBXWLZ/Ok+NEDSBzBq6CZw1b2v4ieZr7B6NdWG6CVrnWYBM6GpvZETVh9hmEztPQwoBE
 KmseYejzgEeGk92VupJSXUwMrcP+4ZLBTbPUZQEh6yV7J71Q3snrTuH6NYLGnHX5nF/+X
 h7/9Ky8TSKnwfwuhl2vfFzQyL6ox6L9PCkpxs7GDDRAlSjEgvv4IHrp9Qsm3P7mfvhWyj
 jcEWUN/zij7rrwKfGUmygHZzJjNv6afUXX2fTNNL31YhIWFyFAvf4nXoGkaBvRKw45zss
 AvG/WbPPfU2Z4hP74MyMhu5RILpPhvFdl1PLDQfsiKFXGymtRjwyiefo2VlzLDUZOIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967682;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=9FTXtPIYYmSfgfdSnZ8evLeSo5wEIlHgi2+MmtN9nto=;
 b=Z/uGVyGjpjr2RwmUWyKMiBvM4J0OJRPYY0JkqVAjfIvge1NnWopSoNj5eZUnY2ts7Ve6
 P343wRR9mAxQ2Fi7h3SqSE/zzXSKE+3j+bfJYZ9RyJjVjETG5tVl5nInKsXAtEwtYxKrG
 U16GHGFU/0S2DGwc8FR3L7M2vECwl5pn/ML3rhgM4/uVHz+nyuugjbgHbBvCamXxJmSBR
 BElgeivbAfMcQT9joYYp3+7hEhzjS8BU3qT/3F2ghE1YqavKctgQ3ZJNQHOs5zhr6Cdgc
 4VqH+MByjfrqXkP8JtLtOyZJZ0gLL7yEa3r3dr6ZSi06LJ2+q+W03njPaOh7ROk9MVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=LM1dbCuJ; 
 arc=none smtp.remote-ip=84.16.66.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.173;
 helo=smtp-42ad.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=LM1dbCuJ
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4ED086079F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:48:00 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4Pws2grDzBwV;
 Wed, 14 Oct 2026 10:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791967677;
 bh=9FTXtPIYYmSfgfdSnZ8evLeSo5wEIlHgi2+MmtN9nto=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LM1dbCuJrbhX3aZ+3v4q1cnySBZ6v+bvMXdy1D2gamb9rtycmlSvQ6PkAg/ZX5rcR
 wi1O9cYsZ0hOTqhMkibGDsebfTmhUel9eDFavYw+mp5/NTJLQpqbCb8gCLjxkLqZgG
 alOlj9q9ILRfnFraoQWaqayF2faqLrY2ZeLq785Emkmk3Ipv7TV8ZMYHv+Ezo0YuU1
 Gx735Bkab/pprWitAZJ8NZSM/D3u0r6aD/QtFLFcittwKMID5qE2+RTUTJ9PUpBZf4
 DxoehWhMDH0HVnZw8sAeiDHCl9wc8rTL/06vaKPElrmZ7A1epDQselMOP70CaDLpiF
 Ufji9EyRiE4RA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j4Pwr0WFBzRw5; Wed, 14 Oct 2026 10:47:55 +0200 (CEST)
Message-ID: <4b42f4e7-4555-4f6e-927f-92e2d93652e9@0leil.net>
Date: Wed, 14 Oct 2026 10:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ram: rockchip: rk3568: Simplify get_info() ops
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-2-jonas@kwiboo.se>
 <f2a4bf52-8532-4f57-9354-1d2a3e33d875@0leil.net>
 <973f0112-e7f7-4cfa-bc01-2e0328592fad@kwiboo.se>
 <4ddd7d43-d5ab-45df-8823-1833d26a793c@0leil.net>
 <d6dd6077-dec9-404e-a48a-8231d483cbbb@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <d6dd6077-dec9-404e-a48a-8231d483cbbb@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

On 10/13/26 10:46 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/13/2026 1:04 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/9/26 5:47 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 10/9/2026 12:29 AM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 8/4/26 12:57 PM, Jonas Karlman wrote:
>> [...]
>>>> 1) I would really like to avoid hardcoding stuff. Did you try using
>>>> syscon_regmap_lookup_by_phandle(dev, "rockchip,grf"); after adding a
>>>> rockchip,grf = <&pmugrf>; property to the dmc node? (maybe it'd make
>>>> sense to name the property rockchip,pmugrf but that's a detail). I also
>>>> see benefit in being consistent across all drivers using the GRF when DM
>>>> is enabled. One issue I could foresee is that this typically will be
>>>> part of the TPL once we have an open DRAM init, and then we don't have
>>>> DM in TPL so we won't be able to read the device tree to get GRF via
>>>> that property. Is this your current worry?
>>>
>>> I agree that we should avoid hardcoding stuff in general, with the CRU,
>>> RAM and arch_cpu_init()+board_debug_uart_init() in xPL as exceptions.
>>>
>>> Those are that core parts that typically may be needed in xPL, where
>>> size and speed is important and/or DM or OF_PLATDATA may or may not be
>>> involved.
>>>
>>> Resolving values from DT has been proven to be very very slow in xPL
>>> and pre-relocation phases, primarily due to slow API for navigating
>>> nodes.
>>>
>>> I also cannot understand why we should need to waste multiple CPU cycles,
>>> energy and code size on resolving a fixed known constant value that
>>> never is going to change. So no I have not nor do I plan to try and use
>>> any DT lookup here ;-)
>>>
>>
>> OK so I'm going to push this even further. Why do we even need a driver
>> for this?
>>
>> I've been bothered for a long time by this DMC node not being described
>> in the bindings and nobody bothering to upstream it. Now that I've
>> looked a bit into it, I think except rk3288 and rk3399 (due to
>> Chromebooks), they all serve no real purpose once we are out of the xPL
>> stage that actually initializes the DRAM, they just report whatever size
>> the DRAM controller reports, by directly reading some register.
> 
> Correct, and to be technical the register is also only used as a way to
> pass DRAM info from TPL (or vendor blob) to the next phases, for open

Ugh, I had completely missed that.

> DRAM init we could use something else, e.g. a bloblist or similar to
> pass this information along to SPL and/or U-Boot proper. However, for
> vendor blob we have the register and for newer blobs we also have some
> information passed as rk atags.
> 

Even if we have an open DRAM init, I believe we should still support the 
blob because it's useful at the very least to compare behavior between 
the two in case we need to debug something later on. Once detected, 
can't we simply use the global pointer (aka gd) instead of having this 
ram_get_info() abstraction?

>> I would essentially remove all DMC nodes whose driver do not actually do
>> anything with the Device Tree, then remove the compatible from the
>> driver since we don't need it to probe the RAM driver. I hope the DRAM
>> driver still probes without a compatible (there for sure is some
>> mechanism as DM-less TPL can probe the DRAM driver just fine for the
>> SoCs for which we have an open DRAM init). Then it's clear there is no
>> mix between DT and non-DT logic.
>> But maybe we could push even more, and delete the part of the DMC driver
>> that does nothing but report the size and base of the DRAM. We can move
>> this code to arch/arm/mach-rockchip/ for example with a weak function
>> that we need to implement for each SoC. Then we would be left with DMC
>> drivers that actually do DRAM initialization (if there's an open DRAM
>> init!), and not something completely different when it's in a different
>> stage. We likely would need to know when we can then call
>> uclass_get_device(UCLASS_RAM,...) and expect it to work (I guess
>> CONFIG_IS_ENABLED(RAM)?), e.g. in arch/arm/mach-rockchip/tpl.c and
>> arch/arm/mach-rockchip/sdram.c. ram_get_info() can then be replaced with
>> this new weak SoC-specific function.
>>
>> Does this make sense? What do you think?
> 
> For some parts it make sense, however not if we want to try and follow
> driver model or want to be able to one day support multiple SoCs using
> a single U-Boot proper build (using existing building blocks).
> 
> We could even fully change how xPL pass DRAM info to next phase, however
> that would likely break mixing vendor DRAM init or SPL with mainline
> U-Boot proper, so may not be ideal if we want to keep backward
> compatibility with vendor blobs. One option could possible be to read
> register in SPL and pass information to U-Boot proper using a bloblist.
> 

Considering dram_init() from arch/arm/mach-rockchip/sdram.c sets 
gd->ram_base and gd->ram_size based on information from the DRAM (DMC) 
driver, we could simply use the gd in U-Boot proper.

I think we will need to support the blob forever, but that should be 
easy to detect as ROCKCHIP_TPL needs to be set. I would prefer if we 
used the same logic but I think we need to find a compromise at some 
point between having nice and useful features and supporting a blob we 
have no control over. Clearly documenting that one could use this or 
that feature only when using open TPL could be fine. I don't have a 
mental model right now on what would be acceptable or not.

> For TPL only doing DRAM init I fully buy that we do not really need DM
> and it is enough to call a sdram_init(), similar to what we do on PX30.
> This is even the pattern I have done for bare minimal TPL testing on
> RK35xx SoCs in my work-in-progress rk3562 branch. However, there the
> sdram "driver" only export sdram_init() in TPL and works as the dummy
> DM driver for SPL/proper.
> 

Yeah, I'm thinking we don't need the latter. I'm not sure a DM-able DMC 
driver in TPL makes sense (I guess this would only be possible with 
TPL_OF_PLATDATA though).

> For reading DRAM info in SPL, it could easily be a weak SoC-specific
> function. However, if we dream of a shared U-Boot proper binary for
> multiple SoCs, any use weak SoC-specific functions could likely make

I know Barebox has done this but I haven't had the time to look at how 
they handle SoC/board-specific code. Likely 
root-device-tree-compatible-based like you say a few lines under? I 
think this would be nice, I just don't know how far away we are.

> that harder. As long as we keep board or SoC specific functions out of
> U-Boot proper this is something that theoretically should be possible.
> If we need to do something board/SoC specific, we could possible use
> something that is matched on board/soc compatible.
> 

How about making SPL write to gd->ram_size/ram_base and use that in 
U-Boot only?

> If we in future end up passing DRAM info to U-Boot proper using a SoC
> agnostic way, use of current read register RAM drivers would really be
> completely unnecessary.
> 
> When it comes to the DMC node, we could possible instead bind the driver
> to root-node or something similar, however root-node is currently not
> being matched to any driver using compatible, so not sure how feasible
> that would be.
> 

Not *more* hacks please :D If I had to pick between a U-Boot-only DMC 
node and reusing the root node, I pick the former 100% of the time.

> Reducing complexity of the read register driver and keeping an awkward
> DMC node is at least something that has been proven to work ;-)
> >>
>>>>
>>>> 2) why rename to match the compatible? What really matters is that they
>>>> are unique across the whole U-Boot code base. I don't see really the
>>>> benefit, but if it scratches an itch, I could see one commit that
>>>> renames all Rockchip DRAM drivers to be consistently named
>>>> rockchip_<soc>_dmc. Not a blocker.
>>>
>>> The rename is "for possible use with OF_PLATDATA". With OF_PLATDATA the
>>> driver is looked up using a DT compatible to driver name mapping.
>>>
>>
>> I only see very old SoCs using that. SPL_OF_PLATDATA is only enabled for
>> the RK3288 Chromebooks, MK808 (rk3066) and Rock (RK3188).
>> TPL_OF_PLATDATA is enabled for PX5 (RK3368), RK3288, RK3328 and RV1126
>> (ok this one's not so old :) ). Do you have anything in mind related to
>> OF_PLATDATA? I just read doc/develop/driver-model/of-plat.rst and the
>> caveats section is scary.
> 
> I know OF_PLATDATA is scary and I would avoid it when possible. Mostly
> just want to make it possible for use in case the open TPL for RK3568
> may need it, and also the driver name not matching device name and/or
> compatible is bugging me ;-)
> 

OK, that's fine with me, in a separate commit explaining that. Is this 
something we should do for all drivers (at least the ones used by 
Rockchip)? I guess for drivers that have multiple compatibles, we should 
have a DM_DRIVER_ALIAS() for each entry in the list. Wondering if 
there's any way to automate that (maybe Coccinelle?) to make sure we 
don't miss new ones if and once the migration is done. Thinking aloud, 
not a request from me to do this.
>>>>
>>>> 3) What is removing probe+priv_auto helping with? We now need to call
>>>> rockchip_sdram_size for each call to ram_get_info(), which we only have
>>>> one so it's not such a big deal but it's still a bit odd to me when the
>>>> DRAM isn't going to change between calls (so somewhat joining Simon on
>>>> the caching thing that's done here before your patch)
>>>
>>> Simons concern where mostly related to caching the base address from DT,
>>> not really related to caching the RAM size, if I understood correctly.
>>>
>>> As mentioned in commit message, to simplify the driver. There is really
>>> no need to do an extra malloc for priv data or pre-calculate DRAM size
>>> at probe() time. Also to align with the RAM drivers that was added later
>>> i.e. rk3576, rk3528 and rk3506. And that I have prepared for rk3562,
>>> rv1126b, rv1106, rv1103b, rk3538 and rk3572 in [2] ;-).
>>>
>>
>> Separate commit please, with its own justification, but fine with me on
>> the reasoning.
> 
> Spiting this into following seem reasonable to me:
> - ram: rockchip: <soc>: Simplify get_info() ops
> - ram: rockchip: <soc>: Use a constant for the PMUGRF base
> - ram: rockchip: <soc>: Rename driver to support xPL_OF_PLATDATA
> 

Works for me.

>>
>>> On a technical side; to simplify and prepare for possible future DRAM
>>> init. We typically need two completely different parts from the RAM
>>> driver depending on what phase is running.
>>>
>>> During DRAM init (in TPL or possible SPL for older SoCs) we only need to
>>> initialize DRAM and write encoded DRAM info to OS_REGx, before returning
>>> to BROM.
>>>
>>> During next xPL phase and in proper we typically only need to read and
>>> decode the DRAM info from the same OS_REGx.
>>>
>>> To keep the driver as simple as possible we only need to implement
>>> following ops to help keep the complexity low:
>>>
>>> .probe = init DRAM in TPL and do nothing in remaining phases
>>> .get_info = return the decoded DRAM size
>>>
>>> And for size constrained targets the entire driver could be replaced
>>> with a size optimized sdram_init() function in TPL.
>>>
>>
>> Circling back to what I suggested earlier in this mail, I'm not sure the
>> next xPL phase/proper part of the driver really makes sense to me. It's
>> like a massive overhead for what is essentially a call to one function
>> with one base register address.
> 
> I fully agree, and this is one of the reasons I really do not like
> current DM lookup of a GRF/SYSCON udevice just to get the reg address to
> do a simple readl(). A lot of plumbing for a very simple and
> deterministic task.
> 
> With this I at least think we remove some of that unnecessary plumbing,
> and we are just left with a bare minimum driver model wrapper that
> likely can be stripped away in future.
> 

Agreed.

Cheers,
Quentin
