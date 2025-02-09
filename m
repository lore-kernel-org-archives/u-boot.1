Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E64C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F1180C5A;
	Sun,  9 Feb 2025 17:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aq62+uda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F33808AF; Sun,  9 Feb 2025 16:39:36 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8790F80821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso7137258a12.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739115574; x=1739720374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TxDX57Us77NROO5Ec5TX34LYq5OKR6zKAuP7dpzV+Dc=;
 b=Aq62+udaW6Mh7HlonfKhrI59b6JQETQgkD0B6A2TyLPahcEtpX/55tS7N8Ocf5EkJp
 xVlKHp5PMvFylz8hL//D9e/Gydqq1qmzbYTy9DrAF7WA9lRonRy5e9M/HlPC60cuoE8Z
 DuVAocpNMZFK1AVyve2xNqMTxL2wXUXM3hEow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739115574; x=1739720374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxDX57Us77NROO5Ec5TX34LYq5OKR6zKAuP7dpzV+Dc=;
 b=iMeDW9RSm5maCE9wf04HysbE6BdosfiaQLngnH+GaR03uSZjc9bVK+5M0/DQKjGcq5
 FoTjXgLGw3i/AzMc4ZtpBD/oj37cga9U8hm5lZzpcVEREqbxJIKO0x6+XDVG2mR2QERC
 Jd1xm3z6AgKNQUEHQGHOPmeGJyZmUSM7Q9v6pJdGwEHo1jvv9hxtWTcLczTOl9ZQbSUl
 Ijso/a406Ae9h2XRaGSpLBV04nEKh/x889ddVcX6Va55cIr0iCy2grcfzizpDeITh4jA
 v9zszLL9BgNKDj+aJuCCQCgwrhfPMd/ziPHCGe01IfpRYQJs0uV06PamPQpw8qic5V8K
 s1EA==
X-Gm-Message-State: AOJu0YyuawZCskSrMyxHyCJYyKx7hNDxr++O/pg+dPVFmhbCfMgxhtYT
 DckudE2i0avLLwFFmNxiYCvTRoe+dSL8rcR1p9Llhf1CtOUCOfFNyvR+eoi7CQZe78iC6U3l/wx
 G5eWlIJn5XkNFewxJ2Ro4Q4g9Qt5Oa1Jz6WFd
X-Gm-Gg: ASbGnctH6LPAE5NNBb2L3IygQqVT2+2fNzJfjmBhwz1xEmIDhG9ii4EQoultlPdR2lL
 u+dJ5z7daed7t6UMyz99n2yJg7tOeL2iT9AEjHsfULIpXHzQA7DmVI0juYF5hSM78otOG+5PZPQ
 ==
X-Google-Smtp-Source: AGHT+IEg3SxPh5olYanomReK+yNqAbjvmaOed7x7ZwJ5lx4NKO1BNZyOg6nF/JjYjNI34d5XUVAMMY+gPZSOsv7Pm9I=
X-Received: by 2002:a05:6402:2084:b0:5dc:7fbe:7310 with SMTP id
 4fb4d7f45d1cf-5de45040046mr11256620a12.6.1739115573913; Sun, 09 Feb 2025
 07:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208212912.GE1233568@bill-the-cat>
 <CAFLszTg6oqMWK05Ldrk4wFUJ7Yr0Xha_z-RJpp1ez=3R5Jdn6A@mail.gmail.com>
 <20250209000350.GJ1233568@bill-the-cat>
 <CAFLszTg42JLpdhkHNqB-594SbJ4bF9nAud-3n7tJ2BsFFRbScA@mail.gmail.com>
 <CAFLszThMAaj8xssHreBu=wZiXo-xz8CAUJ1V23meuqXQMABPsw@mail.gmail.com>
In-Reply-To: <CAFLszThMAaj8xssHreBu=wZiXo-xz8CAUJ1V23meuqXQMABPsw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 08:39:22 -0700
X-Gm-Features: AWEUYZnmNnXfhP5_Wq7KbRe7DIOtCnaUO66-c2eI6MpV-F2uaMYo97zsgoE9vo0
Message-ID: <CAFLszTjRJ4K0e5KN=-dyNPzLWOkB6qMEiugBokUtXLQaufk8Ow@mail.gmail.com>
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
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

On Sat, 8 Feb 2025 at 18:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Sat, 8 Feb 2025 at 18:43, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Sat, 8 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 08, 2025 at 03:40:07PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 8 Feb 2025 at 14:29, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Feb 08, 2025 at 10:11:20AM -0700, Simon Glass wrote:
> > > > >
> > > > > [snip]
> > > > > > Changes in v2:
> > > > > > - Depend on CONFIG_EFI_APP instead
> > > > > > - Drop change to u-boot-elf rule
> > > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > > - Drop the word 'Sadly'
> > > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > > - Add new patch to rename VENDOR_EFI to ARCH_EFI
> > > > > > - Update to use ARCH_EFI instead of VENDOR_EFI
> > > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > > - Rework the commit message to clarify the relationship to link-scripts
> > > > > > - Expand commit message to explains that EFI_APP skips relocation
> > > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > > - Document the x86 field better and add a comment for ARM too
> > > > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > > > - Put the EFI-app case first in setup_mon_len(), for clarity
> > > > > > - Use ARCH_EFI instead of VENDOR_EFI
> > > > > > - Merge the linker-script rules into Kconfig in this patch
> > > > > > - Drop patch 'Select the EFI linker script for the app'
> > > > >
> > > > > There's things that were mentioned for v1 that aren't in this list, did
> > > > > you miss them or disagree with them?
> > > > >
> > > >
> > > > The only one I think I didn't do was ' Drop exception code'. I'm not
> > > > actually using / enabling an SPL symbol so I think you have the wrong
> > > > end of the stick.
> > >
> > > No, you missed my comments about copyright, and tidying up the
> > > compile/link flags for EFI_APP, and the exceptions.o / exception_level.o
> > > thing too. I forget if there was anything else.
> >
> > Oh yes, I sorry all of those but somehow lost the memory when I was
> > testing my work-in-progress. Sorry about that.
> >
> > The LDS thing is a bit of yak shaving but shouldn't be too bad.
>
> Now I remember...I added it to the Kconfig, but in a different patch,
> then left the EFI_LDS in because I got confused with sandbox. But it
> can go.

Well I only partially remembered. It can't, since the EFI_LOADER apps need it.

>
> >
> > For SPL, I'm still stuck as to what you are getting at, but I'll try
> > redoing the commit message and see if that helps.

Regards,
Simon
