Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE4EE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 23:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D318C893B3;
	Sun,  8 Dec 2024 00:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O/k0cKWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B792893C4; Sun,  8 Dec 2024 00:51:49 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03D7B8939B
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 00:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so513683766b.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 15:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733615506; x=1734220306; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WcphBQk42TI0Ljxe5NAopPsFK1aiJVYfiEh5oAJOFjY=;
 b=O/k0cKWyJlrqnoZRt2PRzRHXKecs/Hkyj5K2wk7oeU8/1iONWlRevUFb1aUbW+nofi
 4YY6ZUk/XjT3tz3QYpIKyJJhr+UCcy41h47M3UR/sBWsMxh/VN3I+CQ6XdnRDQpBoASJ
 JGEvD6H8iZnhg2p5v60zMdi2ZJflK0J2tfm88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733615506; x=1734220306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcphBQk42TI0Ljxe5NAopPsFK1aiJVYfiEh5oAJOFjY=;
 b=XP9LgU7zgBBixcCZjF9UyVMFwoIk2ObKJxK1kjn9a0B6KyovTNu1adwzSMDeYwc4Fu
 +8iH/VNSuvsl/lHiKRV01sbSHxLp4ywmqZXIV5ch25KVh1JjBHJUisgICbQ/6Zr80Xhq
 tPxqAmaEQQ68JJZ7SsIzp6y+CaQJKNMxsFYFzhI4afJBkSsBSjS59Kr2AlWolzBLwq8j
 1DCegjtcH2IjBk8HHmGp5i8v07Nq1L9wH8GL7lHHr3y4NFZ2WDYpPk62+dTW5I83DJ87
 jtqv+QmBFH+cLMoO3oI1oGNaxqhp4cOTmfv07/0HVMX3JgstG0nGpTcK812QwAk8wwLZ
 rbKQ==
X-Gm-Message-State: AOJu0YzWX/avDVlOuOOt8x9Rr6iN08ivAQKiSycxT/ERqLY7OlbzGcAU
 pkc2Xr5MD3fylzbhhNCo2ECsCd6+EnGZpkf6teU9cC8tP6KLfhZkRHeLR5bngiKcN8SCLIGlsd5
 SJDOWmePWzJxAc/SCqdJmCmbntzh9WHzxMZ1k
X-Gm-Gg: ASbGncsc3gMu/vJg1gkeEhK11A+Ipj/c+pv11IcdtQD4TSfFkfPeCSiG1/w1TYAB+s7
 OH5K4l4k8nZcS/V33uN4w9+2lj0COw7nD
X-Google-Smtp-Source: AGHT+IEFn7Q/6OZhs5ztYfSOPt7x+c0RaF6hJir8t2TrfM+hQYfyIKgbYszjUO76E1Xz3Q5BVB8DF1s+M3UgzO6wXqE=
X-Received: by 2002:a05:6402:1913:b0:5d1:1064:326a with SMTP id
 4fb4d7f45d1cf-5d3be69a19amr19243269a12.15.1733615506403; Sat, 07 Dec 2024
 15:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
 <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
 <20241207000029.GC2457179@bill-the-cat>
 <CAFLszTiLFe80OQy1q5eVCoZ-v0AhaKUOzdcLsWK9wEwn_SzZ9w@mail.gmail.com>
 <20241207005246.GD2457179@bill-the-cat>
In-Reply-To: <20241207005246.GD2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Dec 2024 16:51:34 -0700
Message-ID: <CAFLszTju5G+icA4aLWWsYTZaEzZp+qUgvgtZ38azndH+A-6Okg@mail.gmail.com>
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

On Fri, 6 Dec 2024 at 17:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 06, 2024 at 05:10:39PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 6 Dec 2024 at 17:00, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 04:56:31PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 6 Dec 2024 at 16:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > > > > > > > > > ramdisk, by expanding the available space.
> > > > > > > > > >
> > > > > > > > > > It also tidies up some strange behaviour with the provided FDT, where a
> > > > > > > > > > separate pointer is maintained to it, even though U-Boot has copied it
> > > > > > > > > > and placed it in its own space. This avoids strange bugs where it
> > > > > > > > > > accidentally gets overwritten when loading a file into memory.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Simon Glass (3):
> > > > > > > > > >   rpi: Update environment to support booti and large initrd
> > > > > > > > > >   fdt: Allow expanding the devicetree during relocation
> > > > > > > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > > > > > > >
> > > > > > > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > > > > > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > > > > > > >  common/board_f.c              |  6 ++++--
> > > > > > > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > > > > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > > > > > > >
> > > > > > > > > My feedback here is the same feedback I gave the last person that wanted
> > > > > > > > > to update the Pi addresses, and I forget if they came back and did that
> > > > > > > > > (and it's in Peter / Matthias' queue) or not. Disabling device tree
> > > > > > > > > relocation is a bug and must be removed.
> > > > > > > > >
> > > > > > > > > After that, given the range of memory sizes available on Pi platforms,
> > > > > > > > > allocating the kernel / initrd / kernel decompression buffer at run
> > > > > > > > > time, ala mach-apple would make life easier in the long run.
> > > > > > > >
> > > > > > > > Yes, of course, but for now, this resolves the problem and I don't
> > > > > > > > believe it creates any other problem.
> > > > > > >
> > > > > > > Yes. I think you missed that:
> > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251-1-walter.lozano@collabora.com/
> > > > > > > is also outstanding and should solve the problem.
> > > > > >
> > > > > > No, it doesn't support decompression, although I have to wonder why
> > > > > > that patch was never applied.
> > > > >
> > > > > See Peter's response elsewhere about having a lot of things to do and
> > > > > not a lot of time. I know he's intended to pick up and post a Pi PR for
> > > > > a while.
> > > >
> > > > OK, but let's drop that patch since it doesn't support decompression, right?
> > >
> > > No? No one has done all of the work required (remove fdt_high /
> > > initrd_high) and this also solves the larger kernel issue.
> >
> > No, that is a separate issue. We need kernel_comp_addr and kernel_comp_size
>
> Yes, those are required for automatic decompression, which is handy. But
> the highest priority is removing fdt_high / initrd_high because those
> lead to so much time being wasted by everyone. Your time digging in to
> and making patch #2 for example.

Can you remind me why fdt_high is so bad, or even what it is supposed
to help with? Perhaps file an issue? I'm not necessarily offering to
do it, but if I understand it better, then it is more likely that I
will take it on.

>
> > > > > > > > The solution should not be board-specific though. Once I have the
> > > > > > > > bootstd files stuff is finished, I believe that bootstd will be able
> > > > > > > > to do this and I plan to do this. Then the variables will be unused
> > > > > > > > for rpi and we can just drop them for any bootstd boards.
> > > > > > > >
> > > > > > > > As of now, we have 390 boards using bootstd and 381 using distro
> > > > > > > > scripts, so it is progress!
> > > > > > >
> > > > > > > Yes, it will be interesting to see what the future holds, and any of the
> > > > > > > solutions handle some of the trickier corner cases that lead to the
> > > > > > > current situation. Or perhaps the best outcome is that in current times,
> > > > > > > those corner cases don't really appear anymore (with 512MiB DDR being
> > > > > > > the lower bound for example on all the Pi families).
> > > > > >
> > > > > > Well rpi is a bit unusual...
> > > > >
> > > > > Sure, but not in this case? Lots of examples of multiple models with
> > > > > different memory sizes, and especially with 32bit platforms smaller (by
> > > > > current standards) overall DDR.
> > > >
> > > > I mean in the sense that it puts the devicetree in the middle of RAM.
> > >
> > > Which and where? Or do you mean it being exacerbated by disabling
> > > relocation (which is why I keep going on and on about removing that from
> > > platforms that do it)? Most platforms will load to the "middle" and
> > > that's why you must not disable relocation because it's only a problem
> > > when, well, relocation is disabled and U-Boot says "Gee, you're going to
> > > break but you told me you want that, so, alright then."
> >
> > No, the rpi relocates. I just mean that it puts the DT at about 512MB
> > in RAM, which is annoying.
>
> I guess we've once again lost some details. With fdt_high=0xffffffff we
> do not relocate the device tree we're going to pass to the OS from
> wherever it happens to be at the time. That is what I mean by
> relocation. Looking at a Pi 4 here real quick, it has
> fdtcontroladdr=3aea8b30. But if you mean fdt_addr, yes, that's around
> 512MiB (fdt_addr=2eff2d00) and likely the previous stage throwing it
> there for the OS as a likely always accessible option.

Yes.

Regards,
SImon
