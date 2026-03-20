Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489481099B4C
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A563684008;
	Sat, 21 Mar 2026 00:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="HoerrRRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821ED83CF3; Fri, 20 Mar 2026 20:05:50 +0100 (CET)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B278A805D7
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 20:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
Message-ID: <10c2f29a-a463-46ee-a4ac-102dd2ea9d73@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774033545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjiEGbroRHAVU2JhiOWMoK4YcV6k3KXJvtmhDWKM7Do=;
 b=HoerrRRZk1YgyZuxjHUecOTntPj+aGhHQDQIW1fN9SoCl6BdMOrYhYwwfU0djZLI1xrTiF
 yJoIxhADSFJ3mMpgw9wLFKDpS9n0GKehO1/MSAL8dJN9t/UykruMqNZnRiNiCfteQ22pb5
 FqsCUoAAZs/8Yd7LXhetWy2DXavZwp6CdK2mVYFI8dTQe8WbDAdNUC0tkqQ9o4SrXV2QeT
 e8IpcxVXmZuLkXJ7eJIAaKEoD4yzecq7Weq3aHW4WjIK1+y+tPPbowDM1QbYe2E20fXC9X
 0xY5yfO9ygG+kvlTwupRK8VKD/vqMqj9+kV4CMAOVBGwSultKDj2IDJfgYtf1A==
Date: Fri, 20 Mar 2026 20:05:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to
 U-Boot
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>,
 linux@analog.com, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Luca Weiss
 <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marex@denx.de>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
 <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Casey Connolly <kcxt@postmarketos.org>
In-Reply-To: <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:20 +0100
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

Hi Simon,

(replying from a different email since gmail rate limited me :grimace:)

On 20/03/2026 17:52, Simon Glass wrote:
> Hi Casey,
> 
> On Thu, 19 Mar 2026 at 14:56, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>> This RFC provides a proof of concept for using the full Linux CCF in
>> U-Boot and consequently porting full Linux clock drivers with extremely
>> minimal changes.
> 
> As a general question, what is the boot flow for the Qualcomm devices
> you are are targeting, i.e. where does U-Boot come in the chain from
> reset? Does it use xPL?

Ideally we replace Qualcomms EDK2, but this is only possible on dev
boards and the few secureboot-off devices out there (like the Pocket S2
I've been using for a lot of this work).

In that case we run after Qualcomms SBL which sets up most of the low
level hardware (secure world, always-on co-processor, hyp, DDR training,
etc), of relevance to us the serial port is usually set up as are a few
other things like UFS but we reset that anyway.

On most of the phones though U-Boot is chainloaded, replacing the kernel
in the Android boot flow. This typically means the display is set up so
we get a framebuffer, there are usually some other differences in
hardware state but we try to avoid relying on that and re-init things
ourselves to stay consistent.

> 
>>
>> == Overview ==
>>
>> This RFC is pretty long but can be separated into a few chunks. The
>> first patches relate to Linux API compatibility and just contain small
>> self contained changes, these can go upstream regardless of CCF.
>>
>> The next group of changes prepare for importing CCF from Linux, the
>> standalone fixed clock drivers are moved to clk/basic, the existing
>> U-Boot CCF drivers are moved to clk/uccf, and struct clk_ops is renamed
>> to clk_ops_uboot.
>>
>> Additionally, clk_set_rate() is changed so that it returns a signed
>> long, since it can return negative values. This is also done to align
>> with CCF but it's a standalone improvement nonetheless.
> 
> Agreed.
> 
>>
>> The next changes import CCF from Linux 6.19 and then adjust it to
>> compile and work with U-Boot. These commits are split up mostly to
>> try and reduce the size. Finally clk-uclass is adjusted for CCF, this
>> definitely will need some additional passes to be a bit cleaner.
>>
>> With CCF done, sandbox clk-ccf driver gets a CCF_FULL port, the clk_ccf
>> tests are adjusted to pass.
> 
> Minor point - perhaps CLK_LINUX ? CCF_FULL seems cryptic to me and
> some would argue that the existing CLK_CCF is already full..

I'm not super keen on identifying this functionality just based on the
fact that it's ported from Linux. The existing CLK_CCF in U-Boot is a
"micro" version of CCF built on top of U-Boots driver model, this is
just a fully featured version...

> 
>>
>> Lastly, a PoC port of Qualcomms Linux clock drivers is done, this
>> only has sm8650 clocks but they serve the desired purpose. The changes
>> necessary to the Linux drivers are mostly to deal with U-Boots driver
>> model, the actual platform specific clock drivers require essentially
>> zero changes!
>>
>> === Feedback ===
>>
>> I'd like to get feedback on the overall architecture and ideas, feel
>> free to point out any dead code or printf's I forgot about, but I'll for
>> sure do a more detailed cleanup before the next revision.
>>
>> I would definitely like to input on how to deal with clk-uclass, since
>> it's now supporting 3 different clock frameworks, but I'm now sure how
>> best to separate the code out without duplicating code.
> 
> Perhaps a justification can be expressed in terms of code size / capabilities:
> 
> Small - can boot in xPL from limited SRAM, only simple clocks
> Medium - smaller code size but still provides good access to clocks
> Large - Linux compatible, full capability but lots of code

It gets tricky because uCCF (I guess "medium" in your definition?) is
built on top of "small", but full CCF ("large") is a separate standalone
implementation.

I think it might make sense to move the small/medium business logic
(like clk lookup, ops, and clk_set_defaults()) to a separate file and
just have the common functions in clk-uclass.c call into the appropriate
abstraction. It is unfortunate to have this additional layer of
indirection but it should all get nicely inlined by the compiler and
will probably make the code a whole lot more readable heh.

> 
>>
>> In terms of overall architecture, CCF is a departure from the uclass
>> model that U-Boot has stuck too for so long. If this is a success then
>> I think it could make a lot of sense to make similar changes for power
>> domains and resets. I think this change offers a lot of additional
>> flexibility which has been sorely missed.
> 
> While those are separate, does this mean that there will be a
> significant delta from Linux's clock drivers on Qualcomm, or will it
> be minor?

It does affect the gdsc (power domain) and reset drivers but it's not
too bad, this is done in patch 37
(https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3673ad5bbc73f7907473f833524fb899abaefd3f)

Basically just adjusting the API, defining a U_BOOT_DRIVER and adding a
function to allocate driver data and bind the child device.

Looking over it again this could be cleaned up quite a bit, the current
code is a bit convoluted since it took a few attempts to find a sensible
implementation.

>>
>> == Motivation ==
>>
>> There were quite a few motivating factors behind this effort which I
>> think provide useful context for this series:
>>
>> 1. Existing UCLASS_CLK support in U-Boot (even with U-Boots minimal CCF)
>>    doesn't provide a fully cohesive API nor implement the necessary
>>    functionality to support complex modern platforms without a lot of
>>    additional effort.
>>
>> 2. While trying to enable display support on Qualcomm, it became clear
>>    that U-Boots clock framework was a severe limiting factor,
>>    particularly for more complicated setups like "bonded" dual-DSI.
> 
> It seems that 1 and 2 could be merged? The question here is how much
> effort would someone want to put in. Providing an easy way to pull in
> the Linux clock driver makes sense. Some people may wish to put in
> effort to at least support the basic clocks for xPL, etc.

Yeah, it's obviously platform/board specific but if there's space for
CCF_FULL in SPL (and you get dcache enabled!) then great, but in
basically all cases I think it's a lot more sensible to more tightly
hardcode the clock configuration and use UCLASS_CLK (kinda like what we
do for qcom currently).

> 
>>
>> 3. The current state of Qualcomm clock drivers in U-Boot is pretty poor,
>>    as the old very basic driver code is being expected to support more
>>    and more complicated usecases. Clock support is generally the most
>>    complicated part of bringing up any new Qualcomm platform, so being
>>    able to properly reuse Linux drivers with the familiar API greatly
>>    reduces the amount of friction when working on U-Boot support for
>>    complicated peripherals like the display.
>>
>> Consequently, My aim with this effort was primarily to provide API
>> compatibility with Linux as much as possible, minimising the changes
>> that have to be made to clock drivers to port them from Linux, and
>> reducing the chance of introducing U-Boot specific bugs.
>>
>> === clk_ops/UCLASS_CLK ===
>>
>> CCF_FULL drivers should NOT use UCLASS_CLK, since CCF uses a totally
>> independent clock API. If the clocks are provided by another device like
>> a phy, they can simply be registered with the clk core the same way they
>> are in Linux. Standalone clock drivers should use UCLASS_NOP.
> 
> Bypassing UCLASS_CLK entirely is a big departure. It means DM can't
> track these clock devices properly - no uclass_find_device(), no
> sequence numbers, no standard device iteration.

Right, better discuss this here than it get lost in the IRC logs heh.

I can appreciate why the old CCF port used the driver model to manage
the clock tree and made each clock its own device, but this comes with
its own set of issues and is kinda abusing DM a bit imo.

The model that CCF implements basically treats clocks as components of a
single device (be that a clk controller, phy, etc). Clocks are not
devices in and of themselves.

With that in mind, I can't really imagine a way to impose the driver
model on CCF, unless I really misunderstand what you mean.

The clock of_provider is at the root of things, if your device has
clocks you register them with CCF and then give CCF a callback function
it can use to map the DT phandle/args from a consumer to the appropriate
clk_hw. This is not all that different to UCLASS_CLK (without CCF)
except the clock driver is entirely responsible for mapping an id to
whatever internal state it needs, much more complexity and cognative
load for anyone reading that code.

struct clk_hw describes how to actually control the clock, it might be
defined statically but that's not something we can assume or enforce
(that's an implementation detail of the clock provider).

In the end, the clock provider device is responsible for ensuring that
clocks (and of_provider) are de-registered with CCF if the driver is
removed. CCF itself only needs to manage the runtime state which it does
through clk_core.

Where I'm a little confused is why do you think DM should "track these
clock devices properly"? If you want to interact with the clock tree you
do that through CCF... Since clocks are independant of devices, devices
of any uclass can provide clocks with CCF, this is how Linux does this
and it makes things soooo much easier.

(small tangent here)

I don't think I can really overstate how much nicer it is... In the case
of the Qualcomm DSI PHY, the earlier U-Boot port had to arbitrarily
split the phy into phy and clock devices, the pll, dividers and mux
can't be easily expressed and propagating rate changes is quite
frustrating. If you want to understand in more detail see the old
version here (start with line 1073):

https://gitlab.com/LinaroLtd/qcom-eco/u-boot/-/blob/casey/8650-pockets2-display/drivers/video/qcom/phy/qcom_dsi_phy.c

And compare that to what we get with CCF:

https://gitlab.com/LinaroLtd/qcom-eco/u-boot/-/blob/casey/ccf-full/drivers/video/qcom/phy/dsi_phy_7nm.c?ref_type=heads#L838

All the complexity is offloaded to CCF!

> 
> The suggestion to do the same for power domains and resets would
> fragment driver model further.

It depends, today we impose a very strict view that a reset controller
has to be it's own device with (ostensibly) its own state and lifetime,
even though in many cases (like qcom UFS phy) it's really just a single
register on a device that does a lot of other stuff.

If we want to properly model the hardware, a device per DT node
generally feels a lot more appropriate to me. If a device has
"#reset-cells" and registers a reset with the reset core then we can
nicely follow a phandle to the device and get a handle to the correct reset.

The UCLASS model with it's strict limitations has it's advantages for
sure, abstracting a lot of stuff away from subsystems and imposing
order! But maybe it's possible to find a better approach.

Blue sky thinking here, I can't really think of particular reasons why
we need a generic uclass_for_each_device() rather than
subsystem-specific functions (like when do you want to iterate over
every reset device?) except for maybe introspection/debugging which is
for sure good justification.

> 
> How about having a single UCLASS_CLK_LINUX device?

You mean to back the entire CCF? I think this would be pretty convoluted
and not serve any practical purpose.

Being able to keep track of resets/clocks/pds/etc is useful for sure,
but I think we should aim to do this using either the ofnode or the
provider udevice as the handle. This is already built in compared to
adding something like your proposed multi-uclass support.

Maybe it would help if you could expand a bit on why you want DM here,
what are the issues with not using DM to track clocks?

> 
>>
>> Clocks must all be registered during driver probe, the CCF will ensure
>> that a given clock provider is probed (via a global ofnode -> device
>> lookup) before checking the of_providers, thus making sure the clocks
>> are registered so that the consumer can use them. There is currently no
>> special handling for cyclical dependencies.
> 
> Driver model normally registers devices during a bind step, which
> helps to remove the problem of cyclic dependencies. Is there any need
> to wait until probe()? Also, can we statically declare it, to save
> code size? Most of the definitions are static

We can't do this statically, this works for like, qcom gcc because there
is only ever one of each clock, but there can be many fixed/divider
clocks so we need to be able to allocate clk_hw at runtime.

Registering clocks during bind would be fine, but it kinda goes against
the lazy-registration philosophy of U-Boot.

Thinking through it a bit more, I don't think it's actually possible to
get in a recursion loop here since device_probe() checks and then sets
the DM_FLAG_ACTIVATED flag. This handles the case where two devices have
assigned-clocks referencing each other or they explicitly fetch clocks
from each other during probe, easily resolved by registering their own
clocks before requesting each others.

If two clocks from different devices reference each other as their
parent I don't *think* that could cause a deadlock either, so we should
be good here. In any case these kinds of issues would only be triggered
by extremely wrong drivers or DT.

Maybe it would be nice to have a recursion counter in
of_clk_get_hw_from_clkspec() and warn if it exceeds some unreasonably
large value, but it's just a QoL issue at that point.

> 
> The global ofnode -> device lookup to force probe ordering is
> reinventing what DM already does with uclass probing. This feels like
> it should integrate with DM rather than work around it.

I mean the only difference is doing a global ofnode lookup rather than
uclass_get_device_by_ofnode()... It's not totally ideal since we often
break the 1 device per ofnode assumption but this can be avoided in the
clock provider driver (either dont register the clocks from a child
device or make sure the child is probed when the parent is).

This issue goes away if we eventually reach the point of having a
device-per-ofnode, or we just walk and probe all the children in CCF
(bad hack imo, just use BIND_AFTER_PROBE!).

> 
>>
>> === struct clk ===
>>
>> It's definitely debatable if it makes sense to have 3 different structs
>> for each clk (clk_hw, clk_core and clk). I do think clk_hw and clk_core
>> are justified, since clk_hw is more tied to the hardware description and
>> typically nested in a clk-specific descriptor while clk_core contains
>> the internal runtime state of the clk which should remain private to
>> CCF core.
> 
> Probably we should follow Linux, since we would start to lose the
> benefit of your series if we merged two structs.

Agreed!

> 
>>
>> It could make sense to merge clk and clk_core, but since struct clk is
>> public in U-Boot, where it's an opaque pointer in Linux this would be
>> a substantial effort. In Linux struct clk objects are allocated inside
>> CCF, but in U-Boot they're allocated by the driver, this would need to
>> be resolved before we investigate combining these structs.
>>
>> === Memory/perf overhead ===
>>
>> The memory and size overhead of CCF is undoubtably bigger than uCCF,
>> although I suspect the difference is less than it might seem at
>> first glance. In particular: clk_core is only ~50 bytes larger than
>> struct udevice on ARM64, and an additional 120 bytes is saved for each
>> U_BOOT_DRIVER used by uCCF.
>>
>> On the other hand, the CPU overhead is probably more significant,
>> but not an unreasonable cost to ensure correctness and propagate rate
>> changes across the clock tree.
> 
> We already struggle with slow pre-relocation performance, something I
> have never really dug into.

The full SLOW FDT scan with dcache disabled would be where I'd start ;P

Even with OF_LIVE we walk the FDT pre-reloc which is considerably
slower... It would be great if we could just skip board_f entirely, I
don't think we need to relocate at all on qcom, we can enable dcache and
build OF_LIVE immediately before doing literally anything else...

> 
>>
>> Just comparing the binary size of sandbox64_defconfig with uCCF vs
>> CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
>> haven't done any more detailed analysis here (still haven't got buildman
>> to play nice...).
> 
> Sandbox may overestimate the size here, not sure. Ping on irc if you
> need update with the buildman setup.

yeah the sandbox values seemed weird, on ARM64 it looks to be about 8K,
and no size change if CLK_CCF_FULL is disabled.

> 
>>
>> === SPL ===
>>
>> This RFC doesn't have any SPL specific support, I think this role is
>> better fulfilled by UCLASS_CLK.
>>
>> === U-Boot's old CCF port ===
>>
>> The original CCF port done for IMX platforms is vastly different in API,
>> scope, and function to CCF_FULL, to differentiate I refer to it
>> as "uCCF".
>>
>> I have kept support for this in and made it mutually exclusive with
>> CCF_FULL. uCCF drivers have been moved to drivers/clk/uccf, with the new
>> CCF port in drivers/clk/ccf.
>>
>> Included near the end of this series is a port of Sandbox's clk-ccf
>> driver from uCCF over to CCF_FULL, this might be a useful reference for
>> other drivers (although it's probably better to just adapt the Linux
>> drivers).
>>
>> === Compat shim ===
>>
>> Lastly, this series includes a compat shim which allows UCLASS_CLK
>> drivers to somewhat work with CCF, I would imagine this being useful
>> if some generic peripheral device provides a clock for example, but in
>> almost all cases I think it's better to implement a proper CCF clock
>> device. Unless there is a particular usecase for this I would probably
>> not include it in the next revision.
>>
>> == TODO/Outstanding issues ==
>>
>> * Clean up clk-uclass.c, does it make sense to somewhow split it in two?
>> * Assess test coverage, have basic sandbox tests, would like to mostly
>>   use integration tests (i.e. diff the clk summary) once more platforms
>>   are supported.
>> * pre-relocation support is currently missing, on Qualcomm at least I
>>   would prefer to completely skip FDT scanning pre-reloc, there is a
>>   patch in this series which does that. It is very non-trivial to try
>>   and handle clocks pre-reloc.
> 
> Does this mean that only serial is needed and the clock for it is
> already set up by some pre-U-Boot phase?

Yeah exactly

> 
> Regards,
> SImon

-- 
// Casey (she/her)

