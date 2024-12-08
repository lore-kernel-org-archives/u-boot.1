Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513D1E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 23:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD80E89538;
	Mon,  9 Dec 2024 00:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lz1aKzXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324F989541; Mon,  9 Dec 2024 00:07:05 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204B988DB6
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso2443733a12.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733699220; x=1734304020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G0/15tX1XKidaQxLj5EY/NX/QCz6XUxVxPWW5gs0OqI=;
 b=lz1aKzXT2UA2XnhCNTE3jrC1TsGLkuCXS2JmTJm6mjnsZOwzwEgbFpzGgsWEaod71p
 aZyWHHWzObrMVWdyMvlEGS+kOsLBRH3s9xvtvGQSX2EYLXpskpszjdUqnvCWUB6BX7VI
 PoVwyoI1qhmgWRZEvZBY5aOAYq+d8cgAfZ5f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733699220; x=1734304020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0/15tX1XKidaQxLj5EY/NX/QCz6XUxVxPWW5gs0OqI=;
 b=k00NXsQAABA9Jvl/4Ay5I/0msatUAzgAK3hsN1pqoaLDB5YnNIJjWTskykSOJxI920
 p0ybHlm+ReV1crPMx+s00Ji22zTdAEdUvY4Rjpgxe2/aJMLv7+5/VgTmbMR2nm9+0Xbf
 pWU5c87VjAqttpw7tLW8/qcijD8NVihOTxG+nrtd6XYg/cUZ7Fikm12OzAlLSLD4W0m8
 0b1HAvmxw4p+fRVQnGe1pOdORt7S7tr1Ar74JO1HFM/hGkMTWkaH47//gZcXFFMMy4fn
 FL1PZJ7q3AoAzMBEXhoMLokFzgmeWCo0jxcj7fMiMzTLl6VuozOhFL1P3RyX8xcfFkq0
 pmyQ==
X-Gm-Message-State: AOJu0YwsBcX5hDBzMqYcCRf5896wj8wzq7yMAvoB375LyW/wmm+w/9xB
 DZieo9qZ5UsauGoAvCgHiD0PwptAMptwroP8QUDBAt599I+mUoOyb3OwLehJvbw4j2jjOSUlK8+
 IxCI8UvCS4KFvsqZoBTZyWfaTDQUUzNxfShCG
X-Gm-Gg: ASbGnct3ReUkSW5himhYb34SZlcyL6DoPC9Fs5O1WWLWPBBdHxowRJ5smKxJq1ZV4Yx
 eYhwy3iobvND1CwXgCoE9TY4jEZTLCA==
X-Google-Smtp-Source: AGHT+IEnkRzf00hyWmeXXmFhUzvYk1Fq/rfHvPWl1bkrAb5jgYF8QSZIBVsTPOV2YV0jQ8yHs4cGcCAK2+7WknI/2xw=
X-Received: by 2002:a05:6402:5292:b0:5d0:d328:3a43 with SMTP id
 4fb4d7f45d1cf-5d3bd66a55bmr11267701a12.6.1733699220438; Sun, 08 Dec 2024
 15:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
 <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
 <20241207000029.GC2457179@bill-the-cat>
 <CAFLszTiLFe80OQy1q5eVCoZ-v0AhaKUOzdcLsWK9wEwn_SzZ9w@mail.gmail.com>
 <20241207005246.GD2457179@bill-the-cat>
 <CAFLszTju5G+icA4aLWWsYTZaEzZp+qUgvgtZ38azndH+A-6Okg@mail.gmail.com>
 <20241208161525.GH2457179@bill-the-cat>
In-Reply-To: <20241208161525.GH2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 16:06:47 -0700
Message-ID: <CAFLszTjvozAhrejprXvfoPBKor12p-KZOwvXNHk82Avjp3wYoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

Hi Tom,

On Sun, 8 Dec 2024 at 09:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Dec 07, 2024 at 04:51:34PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 6 Dec 2024 at 17:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 05:10:39PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 6 Dec 2024 at 17:00, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Dec 06, 2024 at 04:56:31PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 6 Dec 2024 at 16:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > > > > > > > > > >
> > > > > > > > > > > > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > > > > > > > > > > > ramdisk, by expanding the available space.
> > > > > > > > > > > >
> > > > > > > > > > > > It also tidies up some strange behaviour with the provided FDT, where a
> > > > > > > > > > > > separate pointer is maintained to it, even though U-Boot has copied it
> > > > > > > > > > > > and placed it in its own space. This avoids strange bugs where it
> > > > > > > > > > > > accidentally gets overwritten when loading a file into memory.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Simon Glass (3):
> > > > > > > > > > > >   rpi: Update environment to support booti and large initrd
> > > > > > > > > > > >   fdt: Allow expanding the devicetree during relocation
> > > > > > > > > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > > > > > > > > >
> > > > > > > > > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > > > > > > > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > > > > > > > > >  common/board_f.c              |  6 ++++--
> > > > > > > > > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > > > > > > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > My feedback here is the same feedback I gave the last person that wanted
> > > > > > > > > > > to update the Pi addresses, and I forget if they came back and did that
> > > > > > > > > > > (and it's in Peter / Matthias' queue) or not. Disabling device tree
> > > > > > > > > > > relocation is a bug and must be removed.
> > > > > > > > > > >
> > > > > > > > > > > After that, given the range of memory sizes available on Pi platforms,
> > > > > > > > > > > allocating the kernel / initrd / kernel decompression buffer at run
> > > > > > > > > > > time, ala mach-apple would make life easier in the long run.
> > > > > > > > > >
> > > > > > > > > > Yes, of course, but for now, this resolves the problem and I don't
> > > > > > > > > > believe it creates any other problem.
> > > > > > > > >
> > > > > > > > > Yes. I think you missed that:
> > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251-1-walter.lozano@collabora.com/
> > > > > > > > > is also outstanding and should solve the problem.
> > > > > > > >
> > > > > > > > No, it doesn't support decompression, although I have to wonder why
> > > > > > > > that patch was never applied.
> > > > > > >
> > > > > > > See Peter's response elsewhere about having a lot of things to do and
> > > > > > > not a lot of time. I know he's intended to pick up and post a Pi PR for
> > > > > > > a while.
> > > > > >
> > > > > > OK, but let's drop that patch since it doesn't support decompression, right?
> > > > >
> > > > > No? No one has done all of the work required (remove fdt_high /
> > > > > initrd_high) and this also solves the larger kernel issue.
> > > >
> > > > No, that is a separate issue. We need kernel_comp_addr and kernel_comp_size
> > >
> > > Yes, those are required for automatic decompression, which is handy. But
> > > the highest priority is removing fdt_high / initrd_high because those
> > > lead to so much time being wasted by everyone. Your time digging in to
> > > and making patch #2 for example.
> >
> > Can you remind me why fdt_high is so bad, or even what it is supposed
> > to help with? Perhaps file an issue? I'm not necessarily offering to
> > do it, but if I understand it better, then it is more likely that I
> > will take it on.
>
> There's nothing to take on? The fdt_high and initrd_high environment
> variables are documented, along with the other relevant bootm variables.
> In general, at least bootm_low / bootm_size are useful and the correct
> way to solve the problem of "ensure device tree and initrd are where the
> OS can see them", when we are NOT in the use case of "we have an API to
> cooperate on this task".  The problem is that for in hind sight
> extremely bad reasons, we allowed for the magic value of -1 to mean "Do
> not move the device tree" (or initrd). In the latter case, it's a boot
> time optimization that's quite useful and handy at least on the
> processors of the time. In the case of the former, man years (I'm not
> exaggerating at this point) of engineering time has been wasted over the
> device tree being in an unaligned or about to be overwritten location
> and we (U-Boot) don't fix it. The only remaining problem really is to
> remove fdt_high / initrd_high from the platforms that disabled
> relocation before I finally got all of my tooling right such that when a
> new platform did set it, I would see it and go off on an
> explanatory-rant about why that needs to be fixed.

OK, yes it seems like fdt_high is a hack. But 'git grep fdt_high |grep
fffff |wc' shows 74 matches, so it is still there.

Going back to my patch, do you have any comments about it? I am not
about to boil the fdt_high ocean, sorry, but I will happily drop the
fdt_high on rpi, since it seems unnecessary, at least for 64-bit
kernels. I do see that kernels <4.2 require fdt_high on arm so that
the kernel and FDT are within the same 512MB section. Is that still a
concern?

I'll also add myself as a rpi maintainer since the current ones seem
pretty busy.

I am planning to continue with the bootstd work, part of which will be
to drop the need for these variables. If there are constraints, we can
specify those either in the kernel FIT or in U-Boot's config, and
implement them in C code (with tests), not scripts, variables, etc.

Regards,
Simon
