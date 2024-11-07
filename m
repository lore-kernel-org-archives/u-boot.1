Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D495D43366
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 845F2892A0;
	Thu,  7 Nov 2024 15:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="mk5PvBzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A74892B8; Thu,  7 Nov 2024 15:24:13 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF368927A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f43d17ef-9d13-11ef-9dde-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f43d17ef-9d13-11ef-9dde-00505699b430;
 Thu, 07 Nov 2024 15:24:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=3mbZuZpvxZNvqnCt1mxCmV/8VCma1LUOVnlL6g6MrlU=;
 b=mk5PvBzqTrPOhWV63DNlsnBqtUGW7rF8knJuzl9Iipbi1yMWdNt9xgSJ/d19bRz/7dOYR7XR5ulP0
 +OgPsmKj60PCk5FqpdXxUZo+kNjGC1Z2mHDQ8d+KwpFHmFQX2WFy+/OIF7MjR5ghK2BSe9Je5qrEEq
 9D08WjgvKHyP7PIufWGUUJ31HF2TGcXqLK5fzJ4aBFGvWtqcivClR4NsagFCwyOD1GCLj2KCo04bBw
 mFVO25A0uHMSstvhl801iaPlQB8ZHgzKvTzRcJO4ChoUfLPlUm7tL6Kkaz0nPyn6RbQcT/i6OdyH8F
 DzmUQNiqef4eq6lxiJeUqlwZ0ABvezQ==
X-KPN-MID: 33|v4l1poB35I15rxx+F4M5WN75K8NmBffNayM38QgWvdJFfmG2oxnkBr2bgQYxli8
 qAHhbAu0DgGXPgmJXrbHO9tkyUnBburP8dm+1s+pNwWQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|5n3lIxMDJ6uqTcD7EC3E4N/SKef1nJjAnTfAnTy3e2Z8brOuYiubOo5WyeqmZ4n
 mCQ2KA4e/R+qoCdSuJVE7qg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f4420c9a-9d13-11ef-974c-005056998788;
 Thu, 07 Nov 2024 15:24:10 +0100 (CET)
Date: Thu, 07 Nov 2024 15:24:09 +0100
Message-Id: <87cyj72kc6.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>, xypron.glpk@gmx.de
Cc: andre.przywara@arm.com, u-boot@lists.denx.de,
 jagan@amarulasolutions.com, quentin.schulz@cherry.de,
 trini@konsulko.com, caleb.connolly@linaro.org,
 csokas.bence@prolan.hu, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, Oliver.Gaskell@analog.com,
 pbrobinson@gmail.com, rayagonda.kokatanur@broadcom.com,
 sumit.garg@linaro.org, venkatesh.abbarapu@amd.com
In-Reply-To: <CAFLszTjv3z0cfVO8N-+=7J866q6jvCqd7xcvhtqnNg3RUcB8VQ@mail.gmail.com>
 (message from Simon Glass on Tue, 5 Nov 2024 08:14:53 -0700)
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
 <20241103103626.0d5c76a6@minigeek.lan>
 <87ldy042zl.fsf@bloch.sibelius.xs4all.nl>
 <20241104133429.09cc7a72@donnerap.manchester.arm.com>
 <87cyjb3tm7.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTjv3z0cfVO8N-+=7J866q6jvCqd7xcvhtqnNg3RUcB8VQ@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Tue, 5 Nov 2024 08:14:53 -0700

Heinrich, did you see this discussion concerning the EFI boot manager?

Simon,

> H Mark, Peter,
> 
> On Mon, 4 Nov 2024 at 08:29, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Mon, 4 Nov 2024 13:34:29 +0000
> > > From: Andre Przywara <andre.przywara@arm.com>
> > >
> > > On Sun, 03 Nov 2024 18:54:38 +0100
> > > Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >
> > > Hi Mark,
> > >
> > > > > Date: Sun, 3 Nov 2024 10:36:26 +0000
> > > > > From: Andre Przywara <andre.przywara@arm.com>
> > > >
> > > > Hi Andre,
> > > >
> > > > > On Sat, 2 Nov 2024 11:35:31 -0600
> > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Drop support for distroboot and move to using bootstd instead.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v2)
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> > > > > > >
> > > > > > >  arch/arm/Kconfig | 10 +++++-----
> > > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > Could this series be applied, please?
> > > > >
> > > > > So I played with that a bit:
> > > > > - The FEL script boot method works: it has the highest priority, which
> > > > >   is what we want, because the script would be deliberately injected by
> > > > >   the user to be executed. So thanks for the changes!
> > > > > - However the other global boot method (efimgr) takes precedence over
> > > > >   other, *higher* priority methods (extlinux.conf/boot.scr). This
> > > > >   leads to behavioural regressions, I think, like:
> > > > >   - Say there is a bootaa64.efi on some ESP on the eMMC. If you now
> > > > >     boot from SD card, with boot.scr or extlinux.conf on there, U-Boot
> > > > >     will still find the EFI app first and execute that. I don't think
> > > > >     that's what we want?
> > > > >   - Similar, if you have a boot script on the eMMC, and boot from
> > > > >     there, but with a USB stick carrying a bootaa64.efi plugged in.
> > > > >     Then EFI would win as well. This might be intended, but maybe not,
> > > > >     and I don't see how one would influence that?
> > > > >
> > > > > Is there a way to change the bootflow to look for any boot payload on
> > > > > the *boot* media first? So when I boot from SD, it checks this first for
> > > > > EFI, boot.scr, extlinux.conf, then goes to eMMC and USB. Similarly, when
> > > > > booting from eMMC, check there first before considering SD and USB.
> > > > > Maybe I am missing something obvious here?
> > > >
> > > > The issue here is that the EFI bootmanager by its very nature
> > > > considers all possible devices for which boot options have been
> > > > included in the BootOptions EFI variable.  So if you have enabled
> > > > bootmeth_efi_mgr (and you probably should), and you have an active
> > > > boot option (that is a boot option that is included in the BootOptions
> > > > EFI variable) that points at eMMC or USB, it will try too boot using
> > >
> > > I think that's the point: sunxi is one of the platforms that doesn't
> > > feature persistent UEFI variables, at least not when set via UEFI RT
> > > services. So we don't typically have any UEFI variables to help us
> > > point at the right boot location, which leaves us only with ...
> >
> > Right.  One of the suggested solutions for this was to store EFI
> > variables on the ESP in a well-defined format and have the OS update
> > that file directly.  Ilias posted a diff for that some time ago, but I
> > don't think this was committed.  I did some testing of that approach
> > on OpenBSD and I'm fairly confident I could make it work.  But you'd
> > probably need support from at least a few Linux distros to make this
> > feasable.  Anyway...
> >
> > > > that boot option.  So you'd think things would be fine as long as you
> > > > don't add boot options for eMMC or USB to the BootOrder variable.
> > > >
> > > > Unfortunately the EFI_LOADER code will automatically generate media
> > > > device boot options for all the block devices that get added and adds
> > > > those to the BootOrder variables in an attempt to implement the
> > > > requirement to boot from removable media if everything else fails.
> > >
> > > ... exactly removable media. So UEFI boot so far was relying on
> > > efi/boot/bootaa64.efi, though I think you can construct a more specific
> > > entry by manually setting (and storing!) this on the U-Boot shell.
> >
> > You can.  But I don't think that is something you could expect the
> > average user to do.
> >
> > > Another complication is that very often microSD cards are either the
> > > only or the preferred "hard disk" for those boards, and they are surely
> > > removable, even though in those scenarios they are treated more like
> > > "fixed" disks.
> >
> > Well "removable media" is a bit of a misnomer here.  The current UEFI
> > spec says:
> >
> >   Searching for a default application to boot happens on both
> >   removable and fixed media types.
> >
> > So the fallback actually needs to happen on "fixed" disks as well.  At
> > least that is what most UEFI implementations do (and is what EDK2
> > does).  At this point OpenBSD (on all architectures, include amd64)
> > pretty much relies on this as we don't configure any boot options at
> > the moment.  And it works on 99% of the machines out there.
> >
> > > The Allwinner BootROM is writing a boot source ID into SRAM, so we know
> > > whether we were booted from SD card, eMMC, or SPI flash, and set
> > > $mmc_bootdev accordingly. I need to check whether and how this is
> > > reflected in bootstd.
> > >
> > > > But I think that's a mistake.  I can't find a requirement to add boot
> > > > options for these in the spec, let alone a requirement to add those to
> > > > BootOrder.  I suppose this fallback could be implemented as a separate
> > > > bootmeth that can be low priority.
> > >
> > > Yeah, I also feel like splitting this up might help. So one bootmeth for
> > > removable media, and one BootOrder variable based.
> > >
> > > But I think the culprit in this particular situation is this "global" flag,
> > > which makes it live outside of the priority scheme, IIUC:
> > > "When global bootmeths are available, these are typically checked before
> > > the above bootdev scanning."
> > >
> > > Not sure if there is a good solution to this problem? Maybe check at least
> > > the boot device first, for all bootmeth's, and only then consult global
> > > bootmeth's? But then again we want to current behaviour for FEL script
> > > booting, I wonder if this could be modelled as some pseudo bootdev instead
> > > of marked as global (because we are booting via the BootROM's USB-OTG
> > > routines in this case).
> >
> > To some extent, we already have a solution.  We have
> > BOOTMETH_EFILOADER, which is a per-device boot method which loads the
> > default application.  So that pretty much does what's needed for the
> > fallback.
> >
> > So if it was possible to disabled the autogeneration of the default
> > media boot options you'd probably be closer to what you want for
> > sunxi.  I believe that'd make you lose the EFI boot menu options for
> > the different devices though.  So maybe the solution is for
> > BOOTMETH_EFI_MGR to simply skip the autogenerated options and let
> > BOOTMETH_EFILOADER take care of those?
> >
> > Cheers,
> >
> > Mark
> >
> > > > > So while I am personally happy with EFI being a prominent citizen, I
> > > > > think many sunxi users would still expect more traditional boot methods
> > > > > to at least work - at the moment they might be permanently "shadowed" by
> > > > > some bootaa64.efi sitting *somewhere*. That actually bites me at the
> > > > > moment when working on a new SoC port, where I use an extlinux.conf as
> > > > > an override, to load a custom dev kernel and DTB, but bootstd still
> > > > > finds that grub on that SD card and uses that first :-(
> > > > >
> > > > > So I feel like EFI should still be the preferred boot method, but the
> > > > > more custom ways should be allowed to override that.
> > > > >
> > > > > Do you have any ideas how to solve that, or am I holding it wrong?
> > > > >
> > > > > Cheers,
> > > > > Andre
> > > > >
> > >
> > >
> 
> I am not seeing an obvious solution here, certainly not one we can
> implement at rc1.
> 
> Perhaps, Mark, you can carry a patch for your needs until we sort this
> out? I certainly did not understand the complexities introduced by the
> patch[1] to enable bootmgr within bootstd.

Well obviously that is possible.  But it doesn't make sense to me.  I
don't think we should convert more boards to use standard boot if that
means that U-Boot's EFI bootmanager can't be used for booting those
boards.

Another thing that doesn't make sense to me is that if you revert that
commit, the efi_mgr bootmeth only "works" in sandbox.  At that point
enabling it by default makes no sense anymore.

If you really wanted to switch sunxi to use standard boot and drop the
EFI bootmanager support, I think you should just disable
BOOTMETH_EFI_BOOTMGR option for sunxi.

> Regards,
> SImon
> 
> [1] f2bfa0cb179 bootstd: Make efi_mgr bootmeth work for non-sandbox setups
> 
