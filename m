Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3635D1118C
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 19:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105E488C53;
	Sun,  3 Nov 2024 20:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y3vIJEZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2148A88A4C; Sun,  3 Nov 2024 20:06:56 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0223C88C7B
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 20:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9abe139088so535820966b.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730660813; x=1731265613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2GUdJUj5EJ+bQ4YMmma82JOZxeyxTQLQaPInT1IyJJU=;
 b=Y3vIJEZh4AnB/CiSFIsIkB4uZtADjEqao2zWrWPt+UqFaT5tPiGFVSt1oo4bvKWq91
 VdDgFOvvo1/sJxqDxEPmtFmFF8xvkWFiZd7R2rjHRAIAEPqs8BvfCFlBrgnE3ymW4Wd8
 ObJ34pgVs+H5Pd1Anmx3UC6MnBtzhgcVFZ+Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730660813; x=1731265613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GUdJUj5EJ+bQ4YMmma82JOZxeyxTQLQaPInT1IyJJU=;
 b=HqCQJC05iTexYQOQm4ayzx9CZZTZ2rNG6hAdFtJaDFiK/kQKXPCO28ck0tFuv5yQE7
 Q4Gg5FIeR8ImjfdSJeTl4xo3olvfOacHrwY/4z6/iluZgsBtPFJI/eiPioUWb8NlCj2P
 9Gjhz9WlKA5Erdo/yYsIGqKycwQa1IVosLsgP/SeF93erXXYgZGvRxAdPchX3hrzRSQ8
 0cMR8nUUP8Eplf5ChoLU/LNXWWUcuMAcyXHphaAMpZfQmkQDPg8xdQeNRi/cwDboMmuw
 CtJkEhM/G3GqgVbbyBkUVxamfKE22Aw47yh7iNQYmGG/lbCzEIr4X2KtkH8ymh8p+kCr
 FuGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo1CJLai2Cl7xTk84/PIHKfatrN+Ln6RRLKnARO+tMibZS3p71Y5WxD8JBSn8y3a3TWAHKYgI=@lists.denx.de
X-Gm-Message-State: AOJu0YyRWiubfZJUWMrl7TmyV97D/elBZKubREZcJaLYVQX7Wi9+sHsh
 LnC/Zzvae82rFAyFguK7WCdOjne+32hoBejqJ4dbmqfXJdmBOF6Btjl0ENdgbWqygkvnHnCmKtL
 5wypdekGGufvFGxCuos/WTh+f25hpjKHhyPBAN4aN+wlYMEw=
X-Google-Smtp-Source: AGHT+IGOgfBkgrzms4PU9HMtP5HFp11uHY9GJKjInZIXeKEJg4eBNgDERqZiHId5xy9JRlSxS9g7LRgeYpks2s7C+74=
X-Received: by 2002:a17:907:3f02:b0:a9a:e0b8:5b7c with SMTP id
 a640c23a62f3a-a9de5c91d25mr3049929266b.7.1730660813204; Sun, 03 Nov 2024
 11:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
 <20241103103626.0d5c76a6@minigeek.lan>
 <CAFLszThAGC-aBmpk4fDJ0gg+MnNYj+=uJYLQv5kgWjAkaDpyqg@mail.gmail.com>
 <87msig47li.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87msig47li.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Nov 2024 12:06:41 -0700
Message-ID: <CAFLszTjKQ937e6C2cabJQ1WKcwxXK-CDRGC4JoJcLFpNZNqr4Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: andre.przywara@arm.com, u-boot@lists.denx.de, jagan@amarulasolutions.com, 
 quentin.schulz@cherry.de, trini@konsulko.com, caleb.connolly@linaro.org, 
 csokas.bence@prolan.hu, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, Oliver.Gaskell@analog.com, pbrobinson@gmail.com, 
 rayagonda.kokatanur@broadcom.com, sumit.garg@linaro.org, 
 venkatesh.abbarapu@amd.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Mark,

On Sun, 3 Nov 2024 at 09:15, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Sun, 3 Nov 2024 07:46:44 -0700
>
> Hi Simon,
>
> > Hi Andre,
> >
> > On Sun, 3 Nov 2024 at 03:36, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Sat, 2 Nov 2024 11:35:31 -0600
> > > Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > > On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Drop support for distroboot and move to using bootstd instead.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v2)
> > > > >
> > > > > Changes in v2:
> > > > > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> > > > >
> > > > >  arch/arm/Kconfig | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > Could this series be applied, please?
> > >
> > > So I played with that a bit:
> > > - The FEL script boot method works: it has the highest priority, which
> > >   is what we want, because the script would be deliberately injected by
> > >   the user to be executed. So thanks for the changes!
> > > - However the other global boot method (efimgr) takes precedence over
> > >   other, *higher* priority methods (extlinux.conf/boot.scr). This
> > >   leads to behavioural regressions, I think, like:
> > >   - Say there is a bootaa64.efi on some ESP on the eMMC. If you now
> > >     boot from SD card, with boot.scr or extlinux.conf on there, U-Boot
> > >     will still find the EFI app first and execute that. I don't think
> > >     that's what we want?
> > >   - Similar, if you have a boot script on the eMMC, and boot from
> > >     there, but with a USB stick carrying a bootaa64.efi plugged in.
> > >     Then EFI would win as well. This might be intended, but maybe not,
> > >     and I don't see how one would influence that?
> > >
> > > Is there a way to change the bootflow to look for any boot payload on
> > > the *boot* media first? So when I boot from SD, it checks this first for
> > > EFI, boot.scr, extlinux.conf, then goes to eMMC and USB. Similarly, when
> > > booting from eMMC, check there first before considering SD and USB.
> > > Maybe I am missing something obvious here?
> > >
> > > So while I am personally happy with EFI being a prominent citizen, I
> > > think many sunxi users would still expect more traditional boot methods
> > > to at least work - at the moment they might be permanently "shadowed" by
> > > some bootaa64.efi sitting *somewhere*. That actually bites me at the
> > > moment when working on a new SoC port, where I use an extlinux.conf as
> > > an override, to load a custom dev kernel and DTB, but bootstd still
> > > finds that grub on that SD card and uses that first :-(
> > >
> > > So I feel like EFI should still be the preferred boot method, but the
> > > more custom ways should be allowed to override that.
> > >
> > > Do you have any ideas how to solve that, or am I holding it wrong?
> >
> > Given that we are past rc1 the easiest thing might be to revert this:
> >
> > f2bfa0cb179 bootstd: Make efi_mgr bootmeth work for non-sandbox setups
> >
> > until we can figure this out.
> >
> > Can you try that?
>
> That will break setups that use the EFI bootmanager on platforms
> already converted to bootstd (such as various Rockchip boards and the
> Apple machines).  I don't think that is acceptable as we've been
> shipping releases with working EFI bootmanager support on those
> platforms for several years already.

This patch only went in in 2024.01 so I'm not sure how you have been
shipping releases for several years. Are you sure those devices won't
boot without bootmgr?

This issue will presumably block all bootstd migration if we don't
find a solution, meaning that over 1000 boards will be stuck with the
scripts, etc.

Regards,
SImon
