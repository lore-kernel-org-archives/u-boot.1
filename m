Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A50D11187
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 17:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D025D890D1;
	Sun,  3 Nov 2024 18:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="VhHK5+L0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736558911B; Sun,  3 Nov 2024 18:54:42 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4144488D70
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 18:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b216c2fb-9a0c-11ef-93fe-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b216c2fb-9a0c-11ef-93fe-005056994fde;
 Sun, 03 Nov 2024 18:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=7tV+CyWnfKppQCNddMyDJG/h0vEcvGyWsPcJq3uA9n0=;
 b=VhHK5+L0zeWYapQvfG1MwKp6u+cIOI6UXnlyHBbISWJK6RvSL3JbvGQKwI0wM/JpKzxq5zSLOJnX4
 kFGnDabw+c1TJfVbuEINiZXfGfHjIMGq9f+zG2H+lOKp0EFojcbabtLTMugOnOGLB4zqC8vL8rgJ5/
 8BlzgxAA+ZcZLCmTlFfcYbLN8g0GDCyRVD1EYn2McRamhRuoVduewArtdcAbIUya87FBCVS8LgERce
 sWImNWTLrREDmLNz4OI1gclXxiTOa8HasBNMgn4BXPWFfzuoAw1dDs8b8lA6mahpRecBrMOZX+79BK
 OV7uIPFHw4R+lWOhZ2hz4m2997DAIPw==
X-KPN-MID: 33|WMes2u5gT9YDhf4lX1Vf8HhlspBloYJrdCK3eKy0Bv04wKBzsoSknTR9lgkIKKk
 lqV9V3anqjFj4r+N2Ywn6T6wMj4xzHzfJM0NOsONHqJ4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JfOb6fkg8tfeST/G1FIYZ8YppA0wKG4UvPGwfk5Lk3BQ13tvGjVvHoWacVpAVQE
 XerrirdHtf03e4vO5oaHSkQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b1caa454-9a0c-11ef-891f-00505699d6e5;
 Sun, 03 Nov 2024 18:54:39 +0100 (CET)
Date: Sun, 03 Nov 2024 18:54:38 +0100
Message-Id: <87ldy042zl.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Andre Przywara <andre.przywara@arm.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de,
 jagan@amarulasolutions.com, quentin.schulz@cherry.de,
 trini@konsulko.com, caleb.connolly@linaro.org,
 csokas.bence@prolan.hu, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, Oliver.Gaskell@analog.com,
 pbrobinson@gmail.com, rayagonda.kokatanur@broadcom.com,
 sumit.garg@linaro.org, venkatesh.abbarapu@amd.com
In-Reply-To: <20241103103626.0d5c76a6@minigeek.lan> (message from Andre
 Przywara on Sun, 3 Nov 2024 10:36:26 +0000)
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
 <20241103103626.0d5c76a6@minigeek.lan>
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

> Date: Sun, 3 Nov 2024 10:36:26 +0000
> From: Andre Przywara <andre.przywara@arm.com>

Hi Andre,

> On Sat, 2 Nov 2024 11:35:31 -0600
> Simon Glass <sjg@chromium.org> wrote:
> 
> Hi Simon,
> 
> > On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Drop support for distroboot and move to using bootstd instead.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> > >
> > >  arch/arm/Kconfig | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)  
> > 
> > Could this series be applied, please?
> 
> So I played with that a bit:
> - The FEL script boot method works: it has the highest priority, which
>   is what we want, because the script would be deliberately injected by
>   the user to be executed. So thanks for the changes!
> - However the other global boot method (efimgr) takes precedence over
>   other, *higher* priority methods (extlinux.conf/boot.scr). This
>   leads to behavioural regressions, I think, like:
>   - Say there is a bootaa64.efi on some ESP on the eMMC. If you now
>     boot from SD card, with boot.scr or extlinux.conf on there, U-Boot
>     will still find the EFI app first and execute that. I don't think
>     that's what we want?
>   - Similar, if you have a boot script on the eMMC, and boot from
>     there, but with a USB stick carrying a bootaa64.efi plugged in.
>     Then EFI would win as well. This might be intended, but maybe not,
>     and I don't see how one would influence that?
> 
> Is there a way to change the bootflow to look for any boot payload on
> the *boot* media first? So when I boot from SD, it checks this first for
> EFI, boot.scr, extlinux.conf, then goes to eMMC and USB. Similarly, when
> booting from eMMC, check there first before considering SD and USB.
> Maybe I am missing something obvious here?

The issue here is that the EFI bootmanager by its very nature
considers all possible devices for which boot options have been
included in the BootOptions EFI variable.  So if you have enabled
bootmeth_efi_mgr (and you probably should), and you have an active
boot option (that is a boot option that is included in the BootOptions
EFI variable) that points at eMMC or USB, it will try too boot using
that boot option.  So you'd think things would be fine as long as you
don't add boot options for eMMC or USB to the BootOrder variable.

Unfortunately the EFI_LOADER code will automatically generate media
device boot options for all the block devices that get added and adds
those to the BootOrder variables in an attempt to implement the
requirement to boot from removable media if everything else fails.
But I think that's a mistake.  I can't find a requirement to add boot
options for these in the spec, let alone a requirement to add those to
BootOrder.  I suppose this fallback could be implemented as a separate
bootmeth that can be low priority.

> So while I am personally happy with EFI being a prominent citizen, I
> think many sunxi users would still expect more traditional boot methods
> to at least work - at the moment they might be permanently "shadowed" by
> some bootaa64.efi sitting *somewhere*. That actually bites me at the
> moment when working on a new SoC port, where I use an extlinux.conf as
> an override, to load a custom dev kernel and DTB, but bootstd still
> finds that grub on that SD card and uses that first :-(
> 
> So I feel like EFI should still be the preferred boot method, but the
> more custom ways should be allowed to override that.
> 
> Do you have any ideas how to solve that, or am I holding it wrong?
> 
> Cheers,
> Andre
> 
