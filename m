Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA81C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 18:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F27E883BB;
	Mon, 17 Jun 2024 20:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iHA51DkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2C7883A8; Mon, 17 Jun 2024 20:54:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD8D8832D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 20:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7b9=NU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718650442;
 bh=FTqYd2rGd535vLy0irL3xfJvd2Oc8ctJ3+BpTj4GrWQ=;
 b=iHA51DkIaEmLqJDTQhHZa0TGf81hEB7kCJ/B1pquh44yQ6ygaElCkpTfYU9+mgrYjrQ7QyaET
 pdpfTtZNiQtYP78Cdro03aRax1v9F2dHIwbZD0A1PZyrk0k1unkVBJV8zu14KdNTsR+yJZa709m
 idrliZVKFMY9ltVRVyIltmOcws32ngKT37mLkxS6KgbyQriUdToxUM3R3bhs73lfiFimvR5AVeS
 Pxc5MeIAM9PhpHWTTG/Qa9XFGxfgpLAEXGps5MxRbZi+XfRxnAQRGrC7WoohoWKeC551PSAfPWr
 6WJVpewdG+NkMvuhPXUT6Gc7CxDfWjSvtuaTL7x9yyAw==
Message-ID: <173e84c9-9c0e-4ab8-add2-1f493ca14fe3@kwiboo.se>
Date: Mon, 17 Jun 2024 20:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
 <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
 <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
 <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
 <81133178-c476-49fb-ad49-dfc00d7a4adf@kwiboo.se>
 <f2183ce9-d7c3-4952-a585-be5138cad9a5@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f2183ce9-d7c3-4952-a585-be5138cad9a5@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6670864864ade33c9004c66e
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

Hi Quentin,

On 2024-06-17 16:03, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 6/17/24 3:44 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-06-17 15:29, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 6/17/24 3:26 PM, Jonas Karlman wrote:
>>>> Hi Quentin,
>>>>
>>>> On 2024-06-17 15:10, Quentin Schulz wrote:
>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>
>>>>> In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
>>>>> when booting from eMMC"), the spi1 bootph properties were mistakenly
>>>>> removed meaning, so re-add them back to fix SPI-NOR flash not being
>>>>> found in U-Boot pre-reloc as required for RK3399 Puma.
>>>>
>>>> Good catch, for TPL/SPL the bootph props is propagated, something that
>>>> is not done for pre-reloc.
>>>>
>>>
>>> Can you tell us a bit more about this? I know that the pinctrl nodes
>>> marked for pre-reloc recursively apply the same to their parent, but
>>> couldn't find anything similar for other subsystems for example. What
>>> did I miss in my 5m search?
>>
>> v2024.04-rc1 added support to propagate bootph props using fdtgrep for
>> the u-boot-tpl/spl.dtb files, however pre-reloc the main u-boot.dtb (or
>> possible the FDT included in FIT) that is not processed by fdtgrep.
>>
>> fdtgrep: Allow propagating properties up to supernodes
>> https://source.denx.de/u-boot/u-boot/-/commit/7a06cc2027c0169c462da63a68fa269c0d59a950
>>
>> Makefile: Use the fdtgrep -u flag
>> https://source.denx.de/u-boot/u-boot/-/commit/aca95282c1b72c41d8e72984b1dceb15f396b2f8
>>
> 
> Thanks for the pointers!
> 
> I'm wondering if we shouldn't do the same for U-Boot proper DTB as well?

I think that would be good, and should also remove the need for the
recursive pinctrl lookup for bootph props during pre-reloc.

> 
> i.e.
> 
> cmd_fdt_rm_props = cat $< | $(objtree)/tools/fdtgrep -r -O dtb - -o $@
> 
> to
> 
> cmd_fdt_rm_props = $(objtree)/tools/fdtgrep $(fdtgrep_props) -u  $< | 
> $(objtree)/tools/fdtgrep -r -O dtb - -o $@
> 
> I assume we need to add a bunch more options though.
> 
> But that would make sense to me, the fact that there's a pre-reloc stage 
> in U-Boot proper is already a bit odd (to me), but if we have something 
> that behaves differently than the pre-reloc stage in earlier stages... 
> I'm not sure this is a good idea?

Fully agree that part of the pre-reloc stage make little sense at least
on Rockchip platform where full memory is available before pre-reloc.

(I am hoping to get an initial series to remove time wasted during
pre-reloc for Rockchip platform out in near future, e.g. ~250ms is
currently wasted looking up e.g. CRU_BASE on rk3399, a constant that is
known at compile time).

> 
> While at it, I'm wondering if we didn't miss the removal of 
> bootph-some-ram in cmd_fdtgrep for the VPL/SPL/TPL?

I think so too, the bootph-some-ram should be safe to remove.

We can/should probably also extend fdtgrep to remove disabled nodes for
the VPL/SPL/TPL.

> 
> Additionally, we should be able to remove bootph-pre-sram and 
> bootph-pre-ram in U-Boot proper DT since those only apply to non-U-Boot 
> proper stages, don't you think?

I do not fully think we can remove them, due to the dual use of 
ofnode_pre_reloc(). During pre-reloc it will return true if node is
required, and after pre-reloc it return true if the node was required
during any prior phase. Unsure if anything depend on this secondry use.

Regards,
Jonas

> 
> Cheers,
> Quentin

