Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBFECD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774BC84869;
	Tue, 16 Jun 2026 16:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iI6ImxEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9158E84895; Tue, 16 Jun 2026 16:11:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A882D8484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C263612;
 Tue, 16 Jun 2026 07:11:03 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 BE13C3F915; Tue, 16 Jun 2026 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781619067; bh=b/ayjUDrHl41zP2i3o6J3EHCVKcuw2jRXFcNh/p5wGg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iI6ImxEz9QExWpNU1gwFp88ERUGWafZIeWP6yYdsBVJ1JXb2DoiHFaAyMW/qxZiHp
 CEHtmoLqpFGMcvnrQuNXDqYry8XWUP7mxFo0y5CxJb8UkSFCiBXJ+h3FcRFMyVeSrn
 qTlmpKggjUy3hZssmbOl24ZxHsTxo6EPqruIqgaA=
Message-ID: <bd873f94-32af-43f2-be0a-a807fa1ad263@arm.com>
Date: Tue, 16 Jun 2026 16:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
 <ai6yjsgw-3hnNgNM@collins>
 <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Alexander,

thanks for taking care of solving the problem upstream, but ... ;-)

On 6/14/26 20:57, Alexander Sverdlin wrote:
> Hi Paul,
> 
> On Sun, 2026-06-14 at 15:54 +0200, Paul Kocialkowski wrote:
>>> Currently some ARM-based platforms reserve TF-A memory in their own ways:
>>> - Mediatek gets BL31 region via SMC call in ft_system_setup()
>>> - K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()
>>>
>>> And others like Allwinner simply forget to do it, which results in Linux
>>> overwriting TF-A and crashing.
>>
>> To be fair we've been adding the reserved memory regions statically in
>> the Linux device-trees to mitigate the issue.
> 
> once for H616, but it could be the only SoC among ARM64 platforms doing
> this and discouraged for A133:
> https://lore.kernel.org/all/b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com/
> 
>> But another thing we do overwrite current is the cpu idle states, which
>> are added by fdt_add_cpu_idle_states in tf-a. These are only set when the
>> SCP firmware is available (which is checked at run-time) and they are
>> never propagated to the final device-tree. Including the definitions
>> statically would result in cpu idle calls done even without the SCP
>> firmware, which would probably fail (although maybe some states can
>> still be supported).
> 
> Do you refer to some unmerged code? Didn't find it in the current TF-A
> sources...
> 
>> Also note that the usual way to deal with this is to not load any
>> device-tree when booting the kernel, which will implicitly let U-Boot
>> use its current device-tree for Linux (with the modifications brought by
>> tf-a).
> 
> ?!
> We definitely want to load the very device tree coming in the FIT image
> and pass it to the kernel from this FIT image. Sometimes people would
> have several DTs to chose from. The thing in U-Boot is basically to
> get U-Boot up and running. OF_UPSTREAM is rather to reduce the traffic
> on the U-Boot mailing list and maintainers effort, but in most of the
> cases we shall expect this DT to be not from the kernel we actually load.

Sorry, buy I completely and strongly disagree here. This concept of "let 
me load the DT that shipped with the kernel I am going to load" was 
ill-fated from the very beginning, but back 15 years ago it was just the 
only practical way of handling things, because the bootloaders were not 
ready. I understand that this is how embedded people use to do things 
ever since, but I don't think we should continue doing so.

By definition firmware (the combination of SPL, TF-A, U-Boot, crust in 
our case) is device specific, so the board DT living in firmware is a 
good match. As you said, U-Boot needs the DT anyway, and since the DT 
describes the hardware, it's the same DT the kernel gets. Following this 
idea, there should be one best (golden) DT for a board at any point in 
time, probably the one from the latest kernel tree. And that's the one 
that goes into the firmware image, and that both U-Boot and the kernel use.

For distro boot this is basically essential, and for UEFI based boot 
there is actually no other choice. And I like to treat the classic 
embedded boot methods more as special cases of the more generic ones.

I see a point of loading a custom DT during development, to play around 
with nodes and properties, but I think there are better ways to handle this:
- Do the DT changes in the U-Boot tree, and load 
u-boot-sunxi-with-spl.bin via FEL. That's what I typically do.
- Put your changes in DT overlays, and load and apply them in U-Boot:
  > fdt copy $fdtcontroladdr $fdt_addr_r
  > load mmc 0 fdtoverlay_addr_r my_ovl.dtbo
  > fdt apply $fdtoverlay_addr_r
- Patch your changes in using U-Boot's fdt command:
  > fdt copy $fdtcontroladdr $fdt_addr_r
  > fdt set /path/to/node your-property <42>

And even if you really want to completely load your custom DT, this is 
probably changed anyway, so you could patch in the things that need 
adjustment, like the reserved memory nodes.

Cheers,
Andre

>> But of course I agree that it is very desirable to "forward" the
>> device-tree modifications to the kernel device-tree so we are not stuck
>> with whatever device-tree U-Boot was built with.
>>
>>> Unfortunately seems that the things are not much better on TF-A side and
>>> there is no universal way to get the reserved memory region across
>>> platforms. But there is at least a most common way in TF-A, namely
>>> reserving  memory range in the FDT, in particular:
>>> - Allwinner	("tf-a@40000000" node)
>>> - ARM FPGA	("tf-a@80000000" node)
>>> - Xilinx	("tf-a" node)
>>
>> RaspberryPi seems to be using "atf@0". Generally speaking the property
>> is a free-form argument to fdt_add_reserved_memory in tf-a and I don't
>> think we can have a common way to match them.
>>
>> Introducing a Kconfig property for the prefix would be a satisfying
>> solution in my opinion.
> 
> This was a very conservative patch solving the A133 case, but actually
> I don't see anything wrong with just copying all the reserved areas from
> the U-Boot live tree to the device tree we are going to pass to the
> kernel. Maybe fdtdec_add_reserved_memory() needs to be taught to detect
> overlapping ranges and extend them properly, or maybe yet another function
> has to be created for this purpose, to avoid duplicated reserved-memory
> nodes by all means, but would also solve the PSCI cpuidle issue, as well
> as potentially Raspi case of TF-A side and simplify TI K3 on U-Boot side.
> 
>>> While this patch aims to improve the situation for Allwinner platforms,
>>> it's deliberately adding more generic code to pave the potential way of
>>> unification for other platforms.
>>>
>>> Note that fdtdec_add_reserved_memory() has a check for an already existing
>>> carveout with exactly matching boundaries and will not create a duplicate
>>> even if the name doesn't match. It would not however detect an already
>>> existing bigger carveout fully containing the one requested.
>>>
>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>>> ---
>>> The patch has been developed to faciliate Allwinner A133 SoC support, where
>>> most of the work currently happens on TF-A [1] and Linux [2] sides, but
>>> I wanted to send this patch upfront to get the first feedback and because
>>> already supported H616 SoC would already benefit from the patch.
>>
>> Thanks for looking at this!
>>
>> Like I said, I guess the same needs to be done for the cpuidle psci
>> nodes.
> 
> See above, maybe there is a way to carefully copy all /reserved-memory nodes?
> Maybe this full copy shall be configurable, but with a proper overlapping-aware
> implementation maybe even a Kconfig option is not required...
> 

