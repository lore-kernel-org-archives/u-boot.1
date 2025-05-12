Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2649CC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 12:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F02E82162;
	Mon, 12 May 2025 14:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FE6826AA; Mon, 12 May 2025 14:39:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8043380050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E140C150C;
 Mon, 12 May 2025 05:39:39 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C226C3F673;
 Mon, 12 May 2025 05:39:49 -0700 (PDT)
Date: Mon, 12 May 2025 13:39:41 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, <u-boot@lists.denx.de>, Yixun
 Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
Message-ID: <20250512133941.23462a23@minigeek.lan>
In-Reply-To: <11fe3319-8a26-47b7-873e-774140c146f6@cherry.de>
References: <20250417000539.3709-1-andre.przywara@arm.com>
 <20250417000539.3709-3-andre.przywara@arm.com>
 <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
 <20250421222939.69832f73@minigeek.lan>
 <e2d354dd-4be6-45b0-b263-7112b9320692@cherry.de>
 <20250422131121.7a491909@donnerap.manchester.arm.com>
 <11fe3319-8a26-47b7-873e-774140c146f6@cherry.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Apr 2025 16:30:04 +0200
Quentin Schulz <quentin.schulz@cherry.de> wrote:

Hi Quentin,

just found this in my draft folder. It's not really related to this
patch anymore, but you seemed to be interested, and I am happy to
explain some of the specialities for sunxi in U-Boot, since it differs
in many things from other platforms.
So see below...

> Hi Andre,
> 
> On 4/22/25 2:11 PM, Andre Przywara wrote:
> > On Tue, 22 Apr 2025 12:49:40 +0200
> > Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > 
> > Hi,
> >   
> >> Hi Andre and Yixun Lan,
> >>
> >> On 4/21/25 11:29 PM, Andre Przywara wrote:  
> >>> On Fri, 18 Apr 2025 13:28:23 +0200
> >>> Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>
> >>> Hi Quentin,
> >>>
> >>> thanks for having a look!
> >>>      
> >>>> Hi Andre,
> >>>>
> >>>> On 4/17/25 2:05 AM, Andre Przywara wrote:  
> >>>>> Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
> >>>>> labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
> >>>>> power-on or reset. This allows to access the SoC's memory via USB OTG,
> >>>>> and to upload and execute code. There is a tool to upload our U-Boot image
> >>>>> and immediately boot it, when the SoC is in FEL mode.
> >>>>>
> >>>>> To mimic this convenient behaviour on boards without such a dedicated key,
> >>>>> we can query a GPIO pin very early in the SPL boot, then trigger the
> >>>>> BootROM FEL routine.  There has not been much of a SoC or board setup at
> >>>>> this point, so we enter the BROM in a rather pristine state still. On
> >>>>> 64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.
> >>>>>
> >>>>> Any GPIO can be used for that, the signal is expected to be active low,
> >>>>> consequently we enable the pull-up resistors for that pin. A board (or a
> >>>>> user) is expected to specify the GPIO name using the
> >>>>> CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable. When this variable is not set,
> >>>>> the compiler will optimise away the call.
> >>>>>
> >>>>> Call the code first thing in board_init_f(), which is the first sunxi
> >>>>> specific C routine.
> >>>>>
> >>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>>>> ---
> >>>>>     arch/arm/mach-sunxi/Kconfig | 10 ++++++++++
> >>>>>     arch/arm/mach-sunxi/board.c | 31 +++++++++++++++++++++++++++++++
> >>>>>     2 files changed, 41 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> >>>>> index ab432390d3c..f1cfdb548bc 100644
> >>>>> --- a/arch/arm/mach-sunxi/Kconfig
> >>>>> +++ b/arch/arm/mach-sunxi/Kconfig
> >>>>> @@ -825,6 +825,16 @@ config USB3_VBUS_PIN
> >>>>>     	---help---
> >>>>>     	See USB1_VBUS_PIN help text.
> >>>>>     
> >>>>> +config SUNXI_FAKE_FEL_PIN
> >>>>> +	string "fake FEL GPIO pin"
> >>>>> +	default ""
> >>>>> +	---help---
> >>>>> +	Define a GPIO that shall force entering FEL mode when a button
> >>>>> +	connected to this pin is pressed at boot time. This must be an
> >>>>> +	active low signal, the internal pull-up resistors are activated.
> >>>>> +	This takes a string in the format understood by sunxi_name_to_gpio,
> >>>>> +	e.g. PH1 for pin 1 of port H.
> >>>>> +  
> >>>>
> >>>> Why not use the DT for that? Then you wouldn't even need to assume the
> >>>> polarity of the signal or whether pull-up/downs need to be activated, etc.  
> >>>
> >>> As Yixun Lan already pointed out, the DT is not available at this
> >>> point, and doing several pull-ups to get this information from the DT
> >>> into the SPL image are really over the top for this purpose.  
> >>
> >> OK, we do have something "similar" for Rockchip boards, via the
> >> sysreset-gpio DT property in /config, see
> >> arch/arm/mach-rockchip/rk3399/rk3399.c and
> >> arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi.
> >>
> >> I guess something similar could be implemented IFF there's an actual DT
> >> in SPL (or even TPL). We for sure have DT in SPL for most if not all
> >> Rockchip devices, and probably in TPL as well. Hence why I sometimes
> >> forget other Arm boards may not have DT in those stages :)  
> > 
> > Yeah, I know, there is some push for DT anywhere, but it would be quite
> > some pain for sunxi, for very little benefit. We are very tight in the SPL
> > code size for some SoCs, up to the point where for instance enabling this
> > code here made the build break on some SoCs (I found something to free
> > some code space elsewhere, might send that later). So pulling libfdt and
> > DM code in would require going TPL, I guess. But I don't see the reason,  
> 
> We are also very limited on some Rockchip SoCs, see PX30 which has a TPL 
> without DM support and where adding a printf (there are already some) is 
> sometimes too much to fit into the SRAM, so I understand. We do have 
> some other SoCs that have DM enabled in TPL, e.g. RK3399 imply it.

Yes, the size problem is *one* aspect. The early Allwinner SoCs have
24KB usable SRAM, but it's fine there because their code size is smaller
because of ARMv7 and Thumb2. The A64 has a 32KB limit, and it's really
tight there, because it's 64-bit, so no Thumb and larger pointers.
Later SoCs lifted the 32K limit, though we still try to keep it as small
as possible.

> > really, as I tend to see the SPL more as the continuation of the BootROM,
> > which manages without board specific knowledge at all. And for the small
> > bits of info we need, we can happily use Kconfig. Most of it is actually
> > SoC specific, not board specific, so users don't get bothered normally,
> > and it just works (TM).  
> 
> Jonas has started to support "generic" images for Rockchip boards based 
> on the recommended hardware design specified by Rockchip themselves. 
> Most companies do mostly respect it, so that seems to be working quite 
> nicely.

I wouldn't be aware of a "recommended" board design for Allwinner, but
as a matter of fact many companies copy their reference design -
probably more out of laziness ;-). This brings the variation down to a
manageable level, so we can define default values in Kconfig, so
defconfigs stay small.

> Depending on what exactly you want to support with U-Boot, a DM-less SPL 
> may be difficult. e.g. if you want to support a fallback storage medium 
> for loading u-boot.itb (or proper, don't know what's being used on 
> Allwinner) that differs from the one used to load the SPL by the 
> BootROM, then you possibly cannot rely on the BootROM initializing the 
> PHYs, controllers, pinmuxes and pinconfs.

We do not rely on any of those bits being setup, actually, but we
naturally follow the BootROM in its decision process. The BROM stores
the boot media used in a byte in SRAM, so we know where we have been
loaded from, so can continue loading from there. But this is just a
decision between SD card, eMMC, NOR flash and FEL mode (maskROM in RK
lingo). We know that SD card boot must have been from MMC0 on the PortF
pins, and NOR flash is only SPI0 on PortC, on so on. The mux values and
MMIO base addresses are per SoC, so those two values are easily stored
in a header or in Kconfig, where we put them *once*, when we add
support for a new SoC - and they are also quite stable across
generations. So there is really not a strong case for DT here. In fact
so far the mux *value* required isn't even stored in the DT, but in a
table in the pinctrl driver.

> KConfig may be usable for this 
> but that will make things cumbersome to support.
> 
> > There is tons of work and cleanup to do on the sunxi side, and were
> > already have quite some backlog, so I want to avoid introducing more
> > construction sites.
> 
> Fair, it also doesn't mean that what's currently added cannot be 
> migrated later on :)

Sure, but at the moment we are severely review limited, so unless that
changes dramatically, I don't see that happening any time soon.

> 
> [...]
> 
> >>>> You can have the property in the -u-boot.dtsi then if you want?
> >>>>
> >>>> While the FEL button on the X96 is "fake", it does what it says, just in
> >>>> software, maybe that is close enough to "hardware definition" which
> >>>> would make it suitable for the DT (well, we also store binman nodes in  
> >>>
> >>> Yes, I have a patch to add this particular button as a GPIO button into
> >>> the DT, so people can use it for whatever they want in Linux (trigger
> >>> reboot, update, you name it). But this is rather orthogonal to this
> >>> problem, as mentioned above.
> >>>      
> >>
> >> Mmmmm but this will be in the Linux kernel DT and I assume you want the
> >> same GPIO to be used in U-Boot and in Linux, so it would probably be
> >> best to make sure they stay in sync? How are you planning to do that?  
> > 
> > On the Allwinner side we were syncing the DTs regularly for years already,
> > and had no conflicting or different bindings at all. So I prefer to think
> > of "the DT", with Linux or U-Boot just carrying slightly different
> > versions for some time.
>   
> If the kernel DTB is coming from U-Boot, it should be much less 
> difficult to keep this synced.

Yes, that's what I am pushing for: don't bother loading a DTB, just use
the one already provided by U-Boot, as this makes the whole kernel boot
much less board specific: just give it a kernel with the right drivers
in and it boots. And it works really nicely with U-Boot on SPI flash or
on the eMMC boot partition.

> But if it isn't, you would need to patch 
> it live before booting the kernel for example.

We do this for the MAC address and the memory info, but I'd really like
to keep this minimal, and be it as an incentive for people to use
$fdtcontroladdr ;-)

Cheers,
Andre

> In any case, I think the conclusion is that DT cannot be used (yet?) for 
> that so this thread is now essentially just me being curious :)
> 
> Cheers,
> Quentin

