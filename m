Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098CC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF08807D7;
	Sun,  9 Feb 2025 03:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LrLYYsuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED84480821; Sun,  9 Feb 2025 02:44:06 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF3E807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 02:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dcea56d6e2so5960501a12.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 17:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739065444; x=1739670244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T0Ou31L+3Du+hxal/a8guu0bth2YzWHlm9NWBYkMb+c=;
 b=LrLYYsuSoH/YQuCajIf6iOHjdENPleyJIgokbAdQjIhYU/JkZywIbaqywyc2fVBTni
 tIVAjkLaUMQNfmQKVrzNAHHYZ+EEZQeSZdyGNdrNFZvIeRCFPLuxwU3ImBPacxC3svxD
 ccnTy8AYAPiRqxNqAc14TDaK9LsTa0qhVIViI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739065444; x=1739670244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0Ou31L+3Du+hxal/a8guu0bth2YzWHlm9NWBYkMb+c=;
 b=OOQ68uXq928rkxYKxGsudSqsXbbFIQhoXQT822DV1d6KZhguKJ6MWcyQDIath7wRS6
 FmrxgpueSEhS0+TK1VG85+6Vl8rzbrpEc9lruFYbEJeDs3EadhmNwgSGZlWTnXOv/Pe5
 3N8sU+IqKy/4F+VVcGfHiWJm9tyqFBgLKdKZW6Os99ByD7C4+jTC2LNu1HCMP5RHb2jw
 O64M9MNtmb8fbga4Fxl2IRx865CdrYS9j6MctgWWX6j/yIenKyyBYdQq7EmyBzU0BaMr
 T34u8j7RHH4M4zj3zhGQG4ZZff7Lm16sG4va+hwM06rDYBVw4k8TXJXWqIqLM6n34aTV
 rXww==
X-Gm-Message-State: AOJu0Ywx/INUDEFbCU/kuO4uhaxKQ14p4l9ZG/HOPTw23l+Ck+ZAwAVI
 YR1CFMPM/iY/h1ql5djD0RSoIje7L+unfo7dPUMD6HNCeLmAeJ10nAvpmB681hjYLsZDiHRuqsm
 VZiJLtIX12IqY+6Od2d6VfLi8XmumoYWSljdJIvK8PyqhBGU=
X-Gm-Gg: ASbGncv8KUL7Ibv/tYogqOzdBs3FT4g16aRJqTTq1379OIFgNs7NlgvvTce3NBindMp
 wwU4OK8B5x/xlFxJRVxoyIP8wD/oDwPsFcGEQcJk6bWYjwe0uwnumGihn3m9qjUpjjL9Wa8PZQw
 ==
X-Google-Smtp-Source: AGHT+IEzWx+uaC3fvH2YKbAmB/yNsXuI12u0XDbFN93/EiPUNlbcgW8HQXgWXrFp0ql3S5IbBv4+tdbDWi6tWSmX7eo=
X-Received: by 2002:a05:6402:440f:b0:5d9:fbb5:9ee with SMTP id
 4fb4d7f45d1cf-5de45005adbmr11676430a12.13.1739065443892; Sat, 08 Feb 2025
 17:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208212912.GE1233568@bill-the-cat>
 <CAFLszTg6oqMWK05Ldrk4wFUJ7Yr0Xha_z-RJpp1ez=3R5Jdn6A@mail.gmail.com>
 <20250209000350.GJ1233568@bill-the-cat>
In-Reply-To: <20250209000350.GJ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Feb 2025 18:43:52 -0700
X-Gm-Features: AWEUYZlAqnFBQGG_CmqjtpUSHzlHl42HCl7GJ8wDtMfVbSbXm-vSx-KH4vSds34
Message-ID: <CAFLszTg42JLpdhkHNqB-594SbJ4bF9nAud-3n7tJ2BsFFRbScA@mail.gmail.com>
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
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger <mbrugger@suse.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
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
 This contributor prefers not to receive mails <noreply@example.com>,
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

On Sat, 8 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 08, 2025 at 03:40:07PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 8 Feb 2025 at 14:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 08, 2025 at 10:11:20AM -0700, Simon Glass wrote:
> > >
> > > [snip]
> > > > Changes in v2:
> > > > - Depend on CONFIG_EFI_APP instead
> > > > - Drop change to u-boot-elf rule
> > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > - Drop the word 'Sadly'
> > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > - Add new patch to rename VENDOR_EFI to ARCH_EFI
> > > > - Update to use ARCH_EFI instead of VENDOR_EFI
> > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > - Rework the commit message to clarify the relationship to link-scripts
> > > > - Expand commit message to explains that EFI_APP skips relocation
> > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > - Document the x86 field better and add a comment for ARM too
> > > > - Mention '64-bit ARM' here, rather than just 'ARM'
> > > > - Put the EFI-app case first in setup_mon_len(), for clarity
> > > > - Use ARCH_EFI instead of VENDOR_EFI
> > > > - Merge the linker-script rules into Kconfig in this patch
> > > > - Drop patch 'Select the EFI linker script for the app'
> > >
> > > There's things that were mentioned for v1 that aren't in this list, did
> > > you miss them or disagree with them?
> > >
> >
> > The only one I think I didn't do was ' Drop exception code'. I'm not
> > actually using / enabling an SPL symbol so I think you have the wrong
> > end of the stick.
>
> No, you missed my comments about copyright, and tidying up the
> compile/link flags for EFI_APP, and the exceptions.o / exception_level.o
> thing too. I forget if there was anything else.

Oh yes, I sorry all of those but somehow lost the memory when I was
testing my work-in-progress. Sorry about that.

The LDS thing is a bit of yak shaving but shouldn't be too bad.

For SPL, I'm still stuck as to what you are getting at, but I'll try
redoing the commit message and see if that helps.

Regards,
Simon
