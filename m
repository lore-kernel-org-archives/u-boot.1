Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03F3C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB54808E6;
	Sun,  9 Feb 2025 03:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lVqfFIwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1123580141; Sun,  9 Feb 2025 03:00:03 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6485980141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dccc90a52eso5638645a12.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066400; x=1739671200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=igpzJidQaZ/paHUduZiMR0A0v+J/X6I9e7PloM4nPmY=;
 b=lVqfFIwjU5seR3oKJIAdN3i4g7OjRuEcnd11vhI6THFHQPi7nP3/Vkqv/McI3asw1e
 lyFWLUMBGkRmKlu2eMM0HXJwlFDOLpPoQhC8dag77Ua+tfaKAS3BabdNJ8tqdclYp5RW
 Ydo+az5y1jW5wbje4RQ1YcG2ijKkYFi+FEP5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066400; x=1739671200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igpzJidQaZ/paHUduZiMR0A0v+J/X6I9e7PloM4nPmY=;
 b=ISJBolJbQuTgSnaO4n7xp0zvuw5BIXSoe8ki9IGsFdl3XDJPHudKrfeUZlkSU0p2l+
 bsAJjNlA7Lvz31P5/0xV17PBjykhO9Y5/mkvMobGRGbTdy/NYOnzBmOBE7jcXhuUtzJB
 n5LucV4CZAVVJ1rtb/GZNVNEeiLrz2t9rQRO4hp6r3JV3QX/gQfbiavWLikAU+EVK5hc
 2U6XaeOlmDQGVBMaqJukdVL2OQOENygRvaxX1b7TRWOnjhtUqRcyXElvU0rtFpYNjIKI
 O2mhTXXOYXhuALFfrErUt/9Gr7GytsBCCFCmHRtPgDsKFQ+yFWFw/qGGMYWBf4M2KFZm
 QlNA==
X-Gm-Message-State: AOJu0YzuUf6TRfuMrt83HdHFzzQrxEVg/eQzMyQ2If+uTLQV16jQNALg
 pclo1KeNwWRqGdbGnj6AtRWUpmVHDUZtpdbmgO3V1e7j/Ccbr9JqHqx/mfYYtcsRRusTzTkVnaz
 rg5n2/XJSqi0k0UBNVyWtKYvSyh3cvSpxb8LO
X-Gm-Gg: ASbGnctKplqAeXzT0fxgWoe42fqQ2WvSgeZ9t3qB4pLRUEDjO7EpWf37shtXW5XMsCZ
 fMEMksowTvG2SUv0/QFa9EDC691G2ZJqjEynHhAOTvLwmzbI/lMkMBuybQ+T0mvDH7LaG3hIzxg
 ==
X-Google-Smtp-Source: AGHT+IETgZB5h2MX5vxDc34MwAc+B4vaMfi1hS7UrqlUzza2pAlrUJBk5HBuCegKtwyb/0dhZkEGBwtPp21DKxmjEng=
X-Received: by 2002:a05:6402:3907:b0:5dc:7823:e7e4 with SMTP id
 4fb4d7f45d1cf-5de450479f9mr9950646a12.12.1739066399902; Sat, 08 Feb 2025
 17:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208212912.GE1233568@bill-the-cat>
 <CAFLszTg6oqMWK05Ldrk4wFUJ7Yr0Xha_z-RJpp1ez=3R5Jdn6A@mail.gmail.com>
 <20250209000350.GJ1233568@bill-the-cat>
 <CAFLszTg42JLpdhkHNqB-594SbJ4bF9nAud-3n7tJ2BsFFRbScA@mail.gmail.com>
In-Reply-To: <CAFLszTg42JLpdhkHNqB-594SbJ4bF9nAud-3n7tJ2BsFFRbScA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Feb 2025 18:59:47 -0700
X-Gm-Features: AWEUYZmZryd-n-aJkhYAQvELIF0FD6quPlnFxdwA-Q74ELlCe9qXMoLTaRC6T6Q
Message-ID: <CAFLszThMAaj8xssHreBu=wZiXo-xz8CAUJ1V23meuqXQMABPsw@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] arm: Support building as an EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Heiko Schocher <hs@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>, 
 Matthias Brugger <mbrugger@suse.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Weinberger <richard@nod.at>, 
 Rick Chen <rick@andestech.com>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 09 Feb 2025 03:09:46 +0100
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

Hi Tom,

On Sat, 8 Feb 2025 at 18:43, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Sat, 8 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 08, 2025 at 03:40:07PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 8 Feb 2025 at 14:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 08, 2025 at 10:11:20AM -0700, Simon Glass wrote:
> > > >
> > > > [snip]
> > > > > Changes in v2:
> > > > > - Depend on CONFIG_EFI_APP instead
> > > > > - Drop change to u-boot-elf rule
> > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > - Drop the word 'Sadly'
> > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > - Add new patch to rename VENDOR_EFI to ARCH_EFI
> > > > > - Update to use ARCH_EFI instead of VENDOR_EFI
> > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > - Rework the commit message to clarify the relationship to link-scripts
> > > > > - Expand commit message to explains that EFI_APP skips relocation
> > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > - Document the x86 field better and add a comment for ARM too
> > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > - Put the EFI-app case first in setup_mon_len(), for clarity
> > > > > - Use ARCH_EFI instead of VENDOR_EFI
> > > > > - Merge the linker-script rules into Kconfig in this patch
> > > > > - Drop patch 'Select the EFI linker script for the app'
> > > >
> > > > There's things that were mentioned for v1 that aren't in this list, did
> > > > you miss them or disagree with them?
> > > >
> > >
> > > The only one I think I didn't do was ' Drop exception code'. I'm not
> > > actually using / enabling an SPL symbol so I think you have the wrong
> > > end of the stick.
> >
> > No, you missed my comments about copyright, and tidying up the
> > compile/link flags for EFI_APP, and the exceptions.o / exception_level.o
> > thing too. I forget if there was anything else.
>
> Oh yes, I sorry all of those but somehow lost the memory when I was
> testing my work-in-progress. Sorry about that.
>
> The LDS thing is a bit of yak shaving but shouldn't be too bad.

Now I remember...I added it to the Kconfig, but in a different patch,
then left the EFI_LDS in because I got confused with sandbox. But it
can go.

>
> For SPL, I'm still stuck as to what you are getting at, but I'll try
> redoing the commit message and see if that helps.

Regards,
Simon
