Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16EDC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E44F82F42;
	Mon,  7 Apr 2025 17:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yl2Qw08e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903D482F5D; Mon,  7 Apr 2025 17:18:28 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BEC82F42
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so816860466b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744039105; x=1744643905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fwPapPotj7nH8h4JQ6bPzVJDiDRp8Yh+8iyEmr/8ZVo=;
 b=Yl2Qw08egk9kRcTMtSz/YoaZ5xmqVKGM9HwL7S+WhJe+hNtjB8QamHlu+UMLmEa+53
 F5fY7yynshnUVsMCfkXeAqgfDCPiVxoblnriw4HBxG8rR6armcrKInpzHrSx6nSDzirR
 D2fgKU2uOvG5eM1rrFsq4wnPL4oryzg0UYJSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744039105; x=1744643905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwPapPotj7nH8h4JQ6bPzVJDiDRp8Yh+8iyEmr/8ZVo=;
 b=uoNNcY8gnYrWzbPIC8BUkOzg1wGkBARBJdcWmwuTrCCfOSz69ZMliZ00TjAHq1MalI
 kWq0oQgAhSWXKavM7lFad/81e/BLNwL2e6eNxA8itTgXD4dnUZBpUqTq2sbIgt4GXmdT
 yKjOz8clk7r598Tzw+yphf5B30x0MKHW1Kypp4+czhcn1y8cqFteqx8W3QbIwxdGUgWn
 I3iBdDkPyzUPyP80O2q5J67+7QcLQyyb7ZkOdCVAHR3viE7KLR7lfO8z8kbN4PXK3z08
 ewLJOO9TOTw2rNj/g44dm+Nii1Uy/TJOD8wKp7AGU7bLPPEZ0CRlMOb7IDS0XEAWBxGC
 tKeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvR7z0dVUBhEnbtggnF7U0gJ1RwfUkIQ+gUxD7ysyMXpIiNsZZ5VhAu3F8L40iv9FQz5mEg5M=@lists.denx.de
X-Gm-Message-State: AOJu0YxzxtIUOUMQ1LAC0TOGeJZ0d1illgA1VF0s/lioXYqBfkjNq/nh
 SSjg5eUEdjyc73Z4eE2KguKLkvUFGbMhldXezwMcpkoo59L3GDNCESsi09JRupN+jQpcDvgYNjI
 Q8Z/kVy0Y7FGKEqcgniok/OCtnQ7O3KiMUZ2H
X-Gm-Gg: ASbGncs/zX6yESCAHXdli7rv9/rSO+rTc4IAtCAO6+P29pvxAFmO9jluk1g0U2vi4UY
 9dLs52T776M7zFNBBiXwKfNjA2rfeEqg6STrRUydChn4SDQQROXuS/HJFD6isrpXsqrbfLYNe7b
 n+6c0EJHbpCayFOk7JXXbZiHX14APIUYzuhUR/p4urgJbRWCnJwAbt/hx6Zfw=
X-Google-Smtp-Source: AGHT+IFcHTEZOVTCMMoPTpXdUB1bB3cc/qGX/u6aYkQBKm71VVUCVnJ+uOioByHWiDkUXYgF4/00EaYdLYMSnjsRqq4=
X-Received: by 2002:a17:907:2ce1:b0:ac7:cc23:840e with SMTP id
 a640c23a62f3a-ac7e71b2575mr759694366b.15.1744039105096; Mon, 07 Apr 2025
 08:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat> <20250405144823.GZ5495@bill-the-cat>
 <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
 <20250405232346.GB5495@bill-the-cat>
 <CAFLszTj4+GXkmEk3pq-iwJ=8CcJsSreJFKfqWsvW1LQKDz04_w@mail.gmail.com>
 <20250406224826.GF5495@bill-the-cat>
 <CAFLszTgc6UHvw6kRnGMkcbAMc1UDCX12HDSyW0YG+716Pq0Yzw@mail.gmail.com>
 <20250407135310.GJ5495@bill-the-cat>
In-Reply-To: <20250407135310.GJ5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 09:18:12 -0600
X-Gm-Features: ATxdqUGmAc-BHzdBrgToqh37qVcGoSp-G9ekWX9OWbR0isUaiO028E7c9w30wL8
Message-ID: <CAFLszTjw_MJbK9tpzVYi3XKGazcv55auBAdgVzcAVUta7dRqcg@mail.gmail.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Bin Meng <bmeng.cn@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Mon, 7 Apr 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 07, 2025 at 01:07:34PM +1200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 7 Apr 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Apr 07, 2025 at 09:12:32AM +1200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 6 Apr 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Apr 06, 2025 at 08:46:31AM +1200, Simon Glass wrote:
> > > > > > (question for Heinrich below)
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sun, 6 Apr 2025 at 02:48, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> > > > > > > > On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> > > > > > > > > On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On 2025-04-04 00:30, Simon Glass wrote:
> > > > > > > > > > > Hi Jonas,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > > > > > > > > >>
> > > > > > > > > > >> Hi Tom and Simon,
> > > > > > > > > > >>
> > > > > > > > > > >> On 2025-03-19 00:21, Tom Rini wrote:
> > > > > > > > > > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > > > > > > > > > >>>
> > > > > > > > > > >>>> This series includes some patches related to allowing read_all() to be
> > > > > > > > > > >>>> used with the extlinux / PXE bootmeths.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> These patches were split out from the stb4 series, since it will need to
> > > > > > > > > > >>>> have additional patches for LWIP, to avoid breaking PXE booting when
> > > > > > > > > > >>>> LWIP is used.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> [...]
> > > > > > > > > > >>>
> > > > > > > > > > >>> Applied to u-boot/next, thanks!
> > > > > > > > > > >>
> > > > > > > > > > >> This series broke booting a compressed arm64 defconfig Linux kernel
> > > > > > > > > > >> (without module loading) due to changes in decompression buffer length.
> > > > > > > > > > >>
> > > > > > > > > > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
> > > > > > > > > > >> uncompressed.
> > > > > > > > > > >>
> > > > > > > > > > >> Before this series the decompression buffer was 10x the kernel_comp_size
> > > > > > > > > > >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
> > > > > > > > > > >>
> > > > > > > > > > >> A broken boot using current next branch:
> > > > > > > > > > >>
> > > > > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > > > > >>   append: earlycon
> > > > > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > > > > > > > > > >>      kernel data at 0x02080000, len = 0x00000000 (0)
> > > > > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > > > > >>   find_other type 2 os 5
> > > > > > > > > > >>   ## Flattened Device Tree blob at 3df16350
> > > > > > > > > > >>      Booting using the fdt blob at 0x3df16350
> > > > > > > > > > >>   Working FDT set to 3df16350
> > > > > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > > > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > > > > >>   Error: inflate() returned -5
> > > > > > > > > > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > > > > > > > > > >>   Must RESET board to recover
> > > > > > > > > > >>   Resetting the board...
> > > > > > > > > > >>
> > > > > > > > > > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
> > > > > > > > > > >>
> > > > > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > > > > >>   append: earlycon
> > > > > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > > > > > > > > > >>      kernel data at 0x02080000, len = 0x00000000 (0)
> > > > > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > > > > >>   find_other type 2 os 5
> > > > > > > > > > >>   ## Flattened Device Tree blob at 3df16430
> > > > > > > > > > >>      Booting using the fdt blob at 0x3df16430
> > > > > > > > > > >>   Working FDT set to 3df16430
> > > > > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > > > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > > > > >>      kernel loaded at 0x08000000, end = 0x0d3b5a00
> > > > > > > > > > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > > > > > > > > > >>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df ... OK
> > > > > > > > > > >>   Working FDT set to 3cb3f000
> > > > > > > > > > >>
> > > > > > > > > > >>   Starting kernel ...
> > > > > > > > > > >>
> > > > > > > > > > >> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> > > > > > > > > > >
> > > > > > > > > > > Are you using the 'booti' command? Can you post a bit more console
> > > > > > > > > > > output or a script here as it isn't clear what boot command you are
> > > > > > > > > > > using? For now I'm going to assume booti
> > > > > > > > > >
> > > > > > > > > > Above was using an extlinux.conf with bootstd, not using the booti cmd.
> > > > > > > > > >
> > > > > > > > > > Use of booti cmd is not affected as it continue to use a 10x multiple
> > > > > > > > > > of the kernel_comp_size env var for buffer size.
> > > > > > > > > >
> > > > > > > > > > The change this series introduced was instead of the 10x multiple of
> > > > > > > > > > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32 MiB).
> > > > > > > > > >
> > > > > > > > > > And because cmd/booti.c was not converted there is now two different
> > > > > > > > > > handling of this decompression buffer size.
> > > > > > > > > >
> > > > > > > > > > If the change to now use SYS_BOOTM_LEN was intended this need to be
> > > > > > > > > > changed as it has mostly been irrelevant for booting Linux on AArch64
> > > > > > > > > > boards prior to this series.
> > > > > > > > >
> > > > > > > > > We need to clean things up such that the path which is using 10x
> > > > > > > > > multiple (and we lmb_alloc an area iirc) is used in all cases.
> > > > > > > >
> > > > > > > > Looking at the code this morning, I was confusing this with what we do
> > > > > > > > for compressed FIT images, oops.
> > > > > > >
> > > > > > > Ugh. Simon, can you go and fix this whole problem? Both do_bootz and
> > > > > > > do_booti have non-trivial amounts of code that's missed by changing from
> > > > > > > calling do_bootX() to bootX_run().
> > > > > >
> > > > > > For do_bootz() I believe the current code is correct. It does call
> > > > > > bootz_start() and then doesn't call it again when bootz_run() starts.
> > > > > > It looks like you have taken my Ubuntu test so perhaps I can add a
> > > > > > bootz test for another board in my lab.
> > > > > >
> > > > > > For do_booti(), the code in booti_start() is used for the
> > > > > > non-compressed case, so I believe it is still needed and that bootm
> > > > > > doesn't currently honour 'Image' relocation when using an uncompressed
> > > > > > image. But then there is the issue of SYS_BOOTM_LEN, below.
> > > > > >
> > > > > > bootm_load_os() has code for ARM at the end, which I suspect needs to
> > > > > > run on RISC-V too, in case the image needs to be relocated. Marek
> > > > > > added this 7 years ago[1] so it predates RISC-V and Heinrich perhaps
> > > > > > didn't notice it when adding his support , if it is actually needed.
> > > > > >
> > > > > > SYS_BOOTM_LEN is a 'last bastion' security feature to avoid people
> > > > > > loading images that wrap around memory, etc. I could put bootm_len
> > > > > > into struct bootm_info so that a 10x value can be used for the booti
> > > > > > case.
> > >
> > > I'm not sure any of the above is 100% correct. My very quick look was
> > > that it seems like if we want to have the command part of bootX be able
> > > to be equivalently called via API, more of most of the commands needs to
> > > be moved out of cmd/cmdX.c and to boot/bootX.c and put in to some state.
> >
> > Yes, my intent has been to move code out of commands into boot/ and
> > have things work as before.
>
> Then none of this should be in a "pxe" series, and you should have
> been removing a bunch more code out of the command part of the file.
>
> > Also don't forget that booting a FIT with a compressed boot kernel did
> > not work before my series. The series was largely written to fix bugs
> > (in one place) rather that just to refactor for the fun it.
>
> I'm not sure which FIT use case you're talking about here exactly and
> when it got broken (because if it was in use already, someone would have
> reported it).
>
> > > > > > Tom, we also have the issue that you haven't taken the rest of the PXE
> > > > > > series (due to the lwip case), so our trees are out of sync in this
> > > > > > area. It would really help if you could take that series, and again, I
> > > > > > am happy to do the lwip case once it is landed.
> > >
> > > Your further PXE rework is irrelevant to this discussion. Except in that
> > > it points out there's still further changes that could break other
> > > things even more.
> >
> > Yes, any change in untested code has the potential to create bugs. I
> > do the best I can, but I could use a little more support in this
> > effort.
>
> And the best way to get support for that is to slow down and make
> smaller more easily testable series. There's yet another bug in this
> series too that Svyatoslav has or will post about shortly.
>
> > > > > > So for now, if people agree, I can do a small series to use a
> > > > > > different SYS_BOOTM_LEN for the booti command and perhaps add RISC-V
> > > > > > as above.
> > >
> > > Well, no, that sounds like a step in the wrong direction. I'd like to
> > > instead restore the expected behavior, and then perhaps we could clean
> > > it up such that the compressed case for booti-Images works like FIT
> > > images where we lmb allocate a larger area if needed.
> >
> > Yes, restoring the 10x decompression size is what I am talking about
> > here. Is there anything else?
>
> Functional wise, the being reported now issue Svyatoslav found too.
>
> Implementation wise, yes, I don't want to refactor and re-wrtie a bunch
> of this as the first step. The first step should be just what's needed
> to move the working functionality out of cmd/bootX.c and in to
> boot/bootX.c and let people verify things haven't regressed. Then some
> rework can be reviewed on its own.
>
> > > > > > Later, I could continue the boot-unification effort, e.g. delete the
> > > > > > booti_start() function. and incorporate the uncompressed case into
> > > > > > bootm code.
> > > > >
> > > > > I'm not sure your reading of the situation is right. I'm more inclined
> > > > > to revert this merge rather than take on more rework in the area.
> > > >
> > > > Well that would be a pretty poor show. No one else has spent effort
> > > > trying to clean up and rationalise this code in the last 10 years, so
> > > > far as I can see. This is in -next so there is plenty of time to
> > > > resolve any issues.
> > >
> > > Yes, things haven't broken in 10 years. This is why I don't value "tidy
> > > up and refactor" in and of itself. Massive reworks then require a long
> > > time to check all of the corner cases. This has been true of many of the
> > > massive reworks you've done over the years.
> >
> > Well, do you want to be able to boot without CMDLINE, or not?
>
> It's an interesting long term goal. But since there's always some
> distribution or another that ships with each release we do, not having
> functional regressions is more important than speed of new features.
> Being able to practically disable the command line has been a feature
> for forever. Being able to literally has implications for both security
> and end user rights that need to be considered too.
>
> > > > I believe my reading of the situation is right, but if you disagree
> > > > with some of it, please indicate which.
> > >
> > > Your answer is not "Oh, I'll go understand what I broke and restore
> > > expected behavior". It's "you should take more of my big rework and I'll
> > > rework this area even more". That is not convincing that we won't have
> > > v2025.07 broken here.
> >
> > You only took half of the series, remember. We are talking about a
> > tiny corner case here, with no test coverage. I'm offering to fix the
> > case that has been reported. I can also even add a test for it.
>
> It wasn't half of the series. I didn't take more because it was either
> the stuff that broke other functionality or because it wasn't used until
> some further series from you. It's not a tiny corner case. A test case
> is nice, sure, but we'll never have 100% test coverage and need physical
> testing too. Which most people only have time for around releases. Which
> is why we need to go slow. Which again is why you need to split up your
> changes more and expect them to go slower. So there's time to test
> things.

In summary, I think it is clear that I don't have your support for
this effort. Please go ahead and revert it in -next if that is what
you prefer.

Regards,
Simon
