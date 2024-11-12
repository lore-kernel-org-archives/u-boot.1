Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A38D42BB3
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 17:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84F9892CF;
	Tue, 12 Nov 2024 18:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD1A893C2; Tue, 12 Nov 2024 18:12:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E8B798902E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 18:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 160D925E0;
 Tue, 12 Nov 2024 09:12:41 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA4B3F6A8;
 Tue, 12 Nov 2024 09:12:08 -0800 (PST)
Date: Tue, 12 Nov 2024 17:12:05 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@chromium.org, u-boot@lists.denx.de, jagan@amarulasolutions.com,
 quentin.schulz@cherry.de, trini@konsulko.com, caleb.connolly@linaro.org,
 csokas.bence@prolan.hu, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, Oliver.Gaskell@analog.com, pbrobinson@gmail.com,
 rayagonda.kokatanur@broadcom.com, sumit.garg@linaro.org,
 venkatesh.abbarapu@amd.com
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
Message-ID: <20241112171205.4e80548d@donnerap.manchester.arm.com>
In-Reply-To: <87cyjb3tm7.fsf@bloch.sibelius.xs4all.nl>
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
 <20241103103626.0d5c76a6@minigeek.lan>
 <87ldy042zl.fsf@bloch.sibelius.xs4all.nl>
 <20241104133429.09cc7a72@donnerap.manchester.arm.com>
 <87cyjb3tm7.fsf@bloch.sibelius.xs4all.nl>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Mon, 04 Nov 2024 16:29:20 +0100
Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

Hi Mark, Simon,

> > Date: Mon, 4 Nov 2024 13:34:29 +0000
> > From: Andre Przywara <andre.przywara@arm.com>
> > 
> > On Sun, 03 Nov 2024 18:54:38 +0100
> > Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > 
> > Hi Mark,
> >   
> > > > Date: Sun, 3 Nov 2024 10:36:26 +0000
> > > > From: Andre Przywara <andre.przywara@arm.com>    
> > > 
> > > Hi Andre,
> > >   
> > > > On Sat, 2 Nov 2024 11:35:31 -0600
> > > > Simon Glass <sjg@chromium.org> wrote:
> > > > 
> > > > Hi Simon,
> > > >     
> > > > > On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:    
> > > > > >
> > > > > > Drop support for distroboot and move to using bootstd instead.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v2)
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> > > > > >
> > > > > >  arch/arm/Kconfig | 10 +++++-----
> > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)      
> > > > > 
> > > > > Could this series be applied, please?    
> > > > 
> > > > So I played with that a bit:
> > > > - The FEL script boot method works: it has the highest priority, which
> > > >   is what we want, because the script would be deliberately injected by
> > > >   the user to be executed. So thanks for the changes!
> > > > - However the other global boot method (efimgr) takes precedence over
> > > >   other, *higher* priority methods (extlinux.conf/boot.scr). This
> > > >   leads to behavioural regressions, I think, like:
> > > >   - Say there is a bootaa64.efi on some ESP on the eMMC. If you now
> > > >     boot from SD card, with boot.scr or extlinux.conf on there, U-Boot
> > > >     will still find the EFI app first and execute that. I don't think
> > > >     that's what we want?
> > > >   - Similar, if you have a boot script on the eMMC, and boot from
> > > >     there, but with a USB stick carrying a bootaa64.efi plugged in.
> > > >     Then EFI would win as well. This might be intended, but maybe not,
> > > >     and I don't see how one would influence that?
> > > > 
> > > > Is there a way to change the bootflow to look for any boot payload on
> > > > the *boot* media first? So when I boot from SD, it checks this first for
> > > > EFI, boot.scr, extlinux.conf, then goes to eMMC and USB. Similarly, when
> > > > booting from eMMC, check there first before considering SD and USB.
> > > > Maybe I am missing something obvious here?    
> > > 
> > > The issue here is that the EFI bootmanager by its very nature
> > > considers all possible devices for which boot options have been
> > > included in the BootOptions EFI variable.  So if you have enabled
> > > bootmeth_efi_mgr (and you probably should), and you have an active
> > > boot option (that is a boot option that is included in the BootOptions
> > > EFI variable) that points at eMMC or USB, it will try too boot using  
> > 
> > I think that's the point: sunxi is one of the platforms that doesn't
> > feature persistent UEFI variables, at least not when set via UEFI RT
> > services. So we don't typically have any UEFI variables to help us
> > point at the right boot location, which leaves us only with ...  
> 
> Right.  One of the suggested solutions for this was to store EFI
> variables on the ESP in a well-defined format and have the OS update
> that file directly.  Ilias posted a diff for that some time ago, but I
> don't think this was committed.  I did some testing of that approach
> on OpenBSD and I'm fairly confident I could make it work.  But you'd
> probably need support from at least a few Linux distros to make this
> feasable.  Anyway...
> 
> > > that boot option.  So you'd think things would be fine as long as you
> > > don't add boot options for eMMC or USB to the BootOrder variable.
> > > 
> > > Unfortunately the EFI_LOADER code will automatically generate media
> > > device boot options for all the block devices that get added and adds
> > > those to the BootOrder variables in an attempt to implement the
> > > requirement to boot from removable media if everything else fails.  
> > 
> > ... exactly removable media. So UEFI boot so far was relying on
> > efi/boot/bootaa64.efi, though I think you can construct a more specific
> > entry by manually setting (and storing!) this on the U-Boot shell.  
> 
> You can.  But I don't think that is something you could expect the
> average user to do.

Exactly, I don't think anyone really does that outside of testing.

> > Another complication is that very often microSD cards are either the
> > only or the preferred "hard disk" for those boards, and they are surely
> > removable, even though in those scenarios they are treated more like
> > "fixed" disks.  
> 
> Well "removable media" is a bit of a misnomer here.  The current UEFI
> spec says:
> 
>   Searching for a default application to boot happens on both
>   removable and fixed media types.

Ah, has that changed lately? I remember that was always a problem years
ago, when this was quite PC centric, where CD-ROM / USB stick vs. harddisk
was a quite clear distinction.
And I dimly remember some Linux distribution were ignoring this anyway
already, to make things work?

> So the fallback actually needs to happen on "fixed" disks as well.  At
> least that is what most UEFI implementations do (and is what EDK2
> does).  At this point OpenBSD (on all architectures, include amd64)
> pretty much relies on this as we don't configure any boot options at
> the moment.  And it works on 99% of the machines out there.

Well, that certainly sounds good enough for me. While I wish it would
behave like "real computers", the reality in sunxi land is somewhat
different, and there are a lot of people still using some custom boot
scripts.

> > The Allwinner BootROM is writing a boot source ID into SRAM, so we know
> > whether we were booted from SD card, eMMC, or SPI flash, and set
> > $mmc_bootdev accordingly. I need to check whether and how this is
> > reflected in bootstd.
> >   
> > > But I think that's a mistake.  I can't find a requirement to add boot
> > > options for these in the spec, let alone a requirement to add those to
> > > BootOrder.  I suppose this fallback could be implemented as a separate
> > > bootmeth that can be low priority.  
> > 
> > Yeah, I also feel like splitting this up might help. So one bootmeth for
> > removable media, and one BootOrder variable based.
> > 
> > But I think the culprit in this particular situation is this "global" flag,
> > which makes it live outside of the priority scheme, IIUC:
> > "When global bootmeths are available, these are typically checked before
> > the above bootdev scanning."
> > 
> > Not sure if there is a good solution to this problem? Maybe check at least
> > the boot device first, for all bootmeth's, and only then consult global
> > bootmeth's? But then again we want to current behaviour for FEL script
> > booting, I wonder if this could be modelled as some pseudo bootdev instead
> > of marked as global (because we are booting via the BootROM's USB-OTG
> > routines in this case).  
> 
> To some extent, we already have a solution.  We have
> BOOTMETH_EFILOADER, which is a per-device boot method which loads the
> default application.  So that pretty much does what's needed for the
> fallback.

Ah, so that is separate, right? In that case just BOOTMETH_EFILOADER sounds
good enough for me!

> So if it was possible to disabled the autogeneration of the default
> media boot options you'd probably be closer to what you want for
> sunxi.  I believe that'd make you lose the EFI boot menu options for
> the different devices though.  So maybe the solution is for
> BOOTMETH_EFI_MGR to simply skip the autogenerated options and let
> BOOTMETH_EFILOADER take care of those?

Not sure if that breaks something else, but could we just disable
CONFIG_EFI_BOOTMETH_EFI_BOOTMGR for sunxi? default y if !ARCH_SUNXI?
At least for now, until this is sorted? As this would probably unblock
this series. I need to test this at home, but if the old boot scripts and
bootaa64.efi still work in the right order, I am happy with bootstd.

Cheers,
Andre
> 
> > > > So while I am personally happy with EFI being a prominent citizen, I
> > > > think many sunxi users would still expect more traditional boot methods
> > > > to at least work - at the moment they might be permanently "shadowed" by
> > > > some bootaa64.efi sitting *somewhere*. That actually bites me at the
> > > > moment when working on a new SoC port, where I use an extlinux.conf as
> > > > an override, to load a custom dev kernel and DTB, but bootstd still
> > > > finds that grub on that SD card and uses that first :-(
> > > > 
> > > > So I feel like EFI should still be the preferred boot method, but the
> > > > more custom ways should be allowed to override that.
> > > > 
> > > > Do you have any ideas how to solve that, or am I holding it wrong?
> > > > 
> > > > Cheers,
> > > > Andre
> > > >     
> > 
> >   

