Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BC5D11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 23:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF0E88F3C;
	Mon,  4 Nov 2024 00:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="QtBOoJ0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F48488ED9; Mon,  4 Nov 2024 00:08:08 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E1785B66
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 00:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8456c7ee-9a38-11ef-bc49-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8456c7ee-9a38-11ef-bc49-005056992ed3;
 Mon, 04 Nov 2024 00:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=t8am1MFl7CghZoFwdzyTNqVNPEcMKFbEARJiTSqga1c=;
 b=QtBOoJ0THDNiuw86jXUOYrEPEV8Iv94SKVrpo4vI+oZmkGSsXdZGH5CMfL7PBRDV35L/8HbwQXWwe
 BgK+804itM3hioYMcLyqJ1zSxoLpCAoamf+8ZqbHFtImuY6l+vIBYw1ZYDGTV/hpo/TL2IMlvtBZtf
 E7qqiPPtindWK+pE5lNhNrnpgaQcd7TMwIoJQZc6sqpiAOe1pJCXm58w5duOIFsfYQkXWV2jMLRcuV
 9lozvR6PGhaNZmBvbXTJ9GKqvLLCock/g8tPFhuwU8FZvAHSPCwoeTrOaV1bzfRqsQMfu41Zlu099l
 tV7jZ4KUR2zh5thKSH/86FKW3lVRKPg==
X-KPN-MID: 33|t8GvQq9qP6ipWn9hXlkdmoB0ZKCoduadGOoMA4nl8KRwmiqr8SHMWwqofR/5gRi
 A+c8ZkwvUb8rXSkX+9ziKLA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TjWcCO57Sm2byPxVS83UqSdgNWefW83S+njOs0plGV79PnEyBlNJYZjwMktR8Dh
 /UkI5AZlf8Ynv68bqC2NkJw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7a6132dd-9a38-11ef-974a-005056998788;
 Mon, 04 Nov 2024 00:08:04 +0100 (CET)
Date: Mon, 04 Nov 2024 00:08:03 +0100
Message-Id: <87ikt3531o.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: andre.przywara@arm.com, u-boot@lists.denx.de,
 jagan@amarulasolutions.com, quentin.schulz@cherry.de,
 trini@konsulko.com, caleb.connolly@linaro.org,
 csokas.bence@prolan.hu, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, Oliver.Gaskell@analog.com,
 pbrobinson@gmail.com, rayagonda.kokatanur@broadcom.com,
 sumit.garg@linaro.org, venkatesh.abbarapu@amd.com
In-Reply-To: <CAFLszTjKQ937e6C2cabJQ1WKcwxXK-CDRGC4JoJcLFpNZNqr4Q@mail.gmail.com>
 (message from Simon Glass on Sun, 3 Nov 2024 12:06:41 -0700)
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
 <20241103103626.0d5c76a6@minigeek.lan>
 <CAFLszThAGC-aBmpk4fDJ0gg+MnNYj+=uJYLQv5kgWjAkaDpyqg@mail.gmail.com>
 <87msig47li.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTjKQ937e6C2cabJQ1WKcwxXK-CDRGC4JoJcLFpNZNqr4Q@mail.gmail.com>
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
> Date: Sun, 3 Nov 2024 12:06:41 -0700

Hi Simon,

> Hi Mark,
> 
> On Sun, 3 Nov 2024 at 09:15, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Sun, 3 Nov 2024 07:46:44 -0700
> >
> > Hi Simon,
> >
> > > Hi Andre,
> > >
> > > On Sun, 3 Nov 2024 at 03:36, Andre Przywara <andre.przywara@arm.com> wrote:
> > > >
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
> > > >
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
> > >
> > > Given that we are past rc1 the easiest thing might be to revert this:
> > >
> > > f2bfa0cb179 bootstd: Make efi_mgr bootmeth work for non-sandbox setups
> > >
> > > until we can figure this out.
> > >
> > > Can you try that?
> >
> > That will break setups that use the EFI bootmanager on platforms
> > already converted to bootstd (such as various Rockchip boards and the
> > Apple machines).  I don't think that is acceptable as we've been
> > shipping releases with working EFI bootmanager support on those
> > platforms for several years already.
> 
> This patch only went in in 2024.01 so I'm not sure how you have been
> shipping releases for several years. Are you sure those devices won't
> boot without bootmgr?

The old distrboot scripts call the bootmgr; see the
BOOTENV_EFI_BOOTMGR define in include/config_distro_bootcmd.h.  So
before boards were converted to standard boot they had a working EFI
bootmanager.  When bootstd was introduced that broke, and the patch
you mention fixed that.  So yes, reverting that patch would remove
functionality that has been there for several years.

> This issue will presumably block all bootstd migration if we don't
> find a solution, meaning that over 1000 boards will be stuck with the
> scripts, etc.

Then let's fix the bootstd implementation.

> Regards,
> SImon
> 
