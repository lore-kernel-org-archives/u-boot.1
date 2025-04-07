Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC52C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8705A83158;
	Mon,  7 Apr 2025 22:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZLP+Woj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF82830F4; Mon,  7 Apr 2025 22:18:07 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F895830F4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac29af3382dso782574666b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744057084; x=1744661884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K9+PzoO6d5TUZ+XUDPS3qZ8zY8a6mkrtvNEsm3rW5xI=;
 b=ZLP+Woj82xbCcO1jQy/B9vWmq+LvoFjNcHuLzPNZ2UBfGgkfG+B/K8cCSLEoLlrpOa
 Z/OWKkYfcwD/8GeGO1q+KdRZaMqUfaQpRZxwAmR6OoBJtSDnXfQiGuDekE3idyelHrI1
 vpdaziwL8j9ixM0zJG727MbB95WRBu49POmr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744057084; x=1744661884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9+PzoO6d5TUZ+XUDPS3qZ8zY8a6mkrtvNEsm3rW5xI=;
 b=LD2v/1cEAYsSW6RfyF3FN89Ft3l7CsrdA2gbsoyHDyBGWUg7HVgabiwZud+FFBHSR/
 pGNTFcMdOS2vIuerxPq+4720lI+IdCeuQg5hgVo5RlXI011y32ro/sJM4W07c36BnzBO
 L6TaZ2oMXEQAVP2ooEeuYxtMSnRtk21UUqeobCNwgfA3Jae07UmodNHbbTih2Jses6c6
 kUP0ZawrMq6l1Cbk3hQdiqGlqLerG2/ums1nFpRZmUHGvXlQvZRdk07oaERLsNZf6qqF
 FQMXSeRCAQTcJ9Odg6utNBpxklxA2jaVJm6wBI0WdBqHbnATa5tWsV48KMC/SjYe99JU
 FRNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZSJv6YDonYqCC/Iwg73g0cKLSQ7hHBEyO3ISM/aZJ60MRr15W3nj8fB3rswZE3bEQskLAgo=@lists.denx.de
X-Gm-Message-State: AOJu0YyvLZsD+yC23otnF63q667FlMw8/yolhUw524eU3QxX0G3Y09nv
 sWzXDoDoVWML0LuEF4ulUlLn/0yUFPvL7BliafJoNrMhtQUAx0ZA00WOUCRK8g1fBWB2NtV0CLy
 BkgKbYDxfu3V5ED0/GiQUVyl/gPpTQCsxtZFH
X-Gm-Gg: ASbGncuUZENJYz5eoBdogTcypzbMA2BQrWSKFJcvyHkixLVvAdUfnChmDYDjBYwh6et
 H9pHI/9ZsbqJc5WXj7UoPT1ToJ7GTmGoA4rqEvFtl7Vz3718bRf9bqmQGH9Vse9jB06nRB0Nc6v
 6kLyZx3X/N4sYMCCOt2eQXTj7d/TE=
X-Google-Smtp-Source: AGHT+IG5FRncRgagvLKqFgI5zKtKbZCXKGUfRa5Huvtw7rkL4QzRtTi19kMGKW6jNCIFgwuhoTsv0gtzaiBcNSQIisI=
X-Received: by 2002:a17:906:1404:b0:ac7:e815:6e12 with SMTP id
 a640c23a62f3a-ac7e8157168mr733668266b.33.1744057083725; Mon, 07 Apr 2025
 13:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat>
 <20250405144823.GZ5495@bill-the-cat>
 <CAFLszTiJct7mhx5_7iPzt_4m1BZL72pp1QML62b=7R3AgBn3fw@mail.gmail.com>
 <20250405232346.GB5495@bill-the-cat>
 <CAFLszTj4+GXkmEk3pq-iwJ=8CcJsSreJFKfqWsvW1LQKDz04_w@mail.gmail.com>
 <20250406224826.GF5495@bill-the-cat>
 <CAFLszTgc6UHvw6kRnGMkcbAMc1UDCX12HDSyW0YG+716Pq0Yzw@mail.gmail.com>
 <20250407135310.GJ5495@bill-the-cat>
 <CAFLszTjw_MJbK9tpzVYi3XKGazcv55auBAdgVzcAVUta7dRqcg@mail.gmail.com>
 <20250407191541.GO5495@bill-the-cat>
In-Reply-To: <20250407191541.GO5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 14:17:51 -0600
X-Gm-Features: ATxdqUEVcRQV_FQ1utiqEr7xP-d13qEwr1DULJFJj_-68axdy4Tw8ptmfBRMJF4
Message-ID: <CAFLszTgMEPKN+e+Rfv5MkM-=EgVNbepA1jvZMYVxkzPduBPe5A@mail.gmail.com>
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

On Mon, 7 Apr 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 07, 2025 at 09:18:12AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 7 Apr 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Apr 07, 2025 at 01:07:34PM +1200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 7 Apr 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Apr 07, 2025 at 09:12:32AM +1200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sun, 6 Apr 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Apr 06, 2025 at 08:46:31AM +1200, Simon Glass wrote:
> > > > > > > > (question for Heinrich below)
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sun, 6 Apr 2025 at 02:48, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> > > > > > > > > > On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> > > > > > > > > > > On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > >
> > > > > > > > > > > > On 2025-04-04 00:30, Simon Glass wrote:
> > > > > > > > > > > > > Hi Jonas,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> Hi Tom and Simon,
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> On 2025-03-19 00:21, Tom Rini wrote:
> > > > > > > > > > > > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > > > > > > > > > > > >>>
> > > > > > > > > > > > >>>> This series includes some patches related to allowing read_all() to be
> > > > > > > > > > > > >>>> used with the extlinux / PXE bootmeths.
> > > > > > > > > > > > >>>>
> > > > > > > > > > > > >>>> These patches were split out from the stb4 series, since it will need to
> > > > > > > > > > > > >>>> have additional patches for LWIP, to avoid breaking PXE booting when
> > > > > > > > > > > > >>>> LWIP is used.
> > > > > > > > > > > > >>>>
> > > > > > > > > > > > >>>> [...]
> > > > > > > > > > > > >>>
> > > > > > > > > > > > >>> Applied to u-boot/next, thanks!
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> This series broke booting a compressed arm64 defconfig Linux kernel
> > > > > > > > > > > > >> (without module loading) due to changes in decompression buffer length.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
> > > > > > > > > > > > >> uncompressed.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> Before this series the decompression buffer was 10x the kernel_comp_size
> > > > > > > > > > > > >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> A broken boot using current next branch:
> > > > > > > > > > > > >>
> > > > > > > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > > > > > > >>   append: earlycon
> > > > > > > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > > > > > > > > > > > >>      kernel data at 0x02080000, len = 0x00000000 (0)
> > > > > > > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > > > > > > >>   find_other type 2 os 5
> > > > > > > > > > > > >>   ## Flattened Device Tree blob at 3df16350
> > > > > > > > > > > > >>      Booting using the fdt blob at 0x3df16350
> > > > > > > > > > > > >>   Working FDT set to 3df16350
> > > > > > > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > > > > > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > > > > > > >>   Error: inflate() returned -5
> > > > > > > > > > > > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > > > > > > > > > > > >>   Must RESET board to recover
> > > > > > > > > > > > >>   Resetting the board...
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
> > > > > > > > > > > > >>
> > > > > > > > > > > > >>   Retrieving file: /Image.gz
> > > > > > > > > > > > >>   Retrieving file: /initramfs.cpio.gz
> > > > > > > > > > > > >>   append: earlycon
> > > > > > > > > > > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > > > > > > > > > > > >>      kernel data at 0x02080000, len = 0x00000000 (0)
> > > > > > > > > > > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > > > > > > > > > > >>   find_other type 2 os 5
> > > > > > > > > > > > >>   ## Flattened Device Tree blob at 3df16430
> > > > > > > > > > > > >>      Booting using the fdt blob at 0x3df16430
> > > > > > > > > > > > >>   Working FDT set to 3df16430
> > > > > > > > > > > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > > > > > > > > > > >>      Uncompressing Kernel Image to 8000000
> > > > > > > > > > > > >>      kernel loaded at 0x08000000, end = 0x0d3b5a00
> > > > > > > > > > > > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > > > > > > > > > > > >>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df ... OK
> > > > > > > > > > > > >>   Working FDT set to 3cb3f000
> > > > > > > > > > > > >>
> > > > > > > > > > > > >>   Starting kernel ...
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Are you using the 'booti' command? Can you post a bit more console
> > > > > > > > > > > > > output or a script here as it isn't clear what boot command you are
> > > > > > > > > > > > > using? For now I'm going to assume booti
> > > > > > > > > > > >
> > > > > > > > > > > > Above was using an extlinux.conf with bootstd, not using the booti cmd.
> > > > > > > > > > > >
> > > > > > > > > > > > Use of booti cmd is not affected as it continue to use a 10x multiple
> > > > > > > > > > > > of the kernel_comp_size env var for buffer size.
> > > > > > > > > > > >
> > > > > > > > > > > > The change this series introduced was instead of the 10x multiple of
> > > > > > > > > > > > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32 MiB).
> > > > > > > > > > > >
> > > > > > > > > > > > And because cmd/booti.c was not converted there is now two different
> > > > > > > > > > > > handling of this decompression buffer size.
> > > > > > > > > > > >
> > > > > > > > > > > > If the change to now use SYS_BOOTM_LEN was intended this need to be
> > > > > > > > > > > > changed as it has mostly been irrelevant for booting Linux on AArch64
> > > > > > > > > > > > boards prior to this series.
> > > > > > > > > > >
> > > > > > > > > > > We need to clean things up such that the path which is using 10x
> > > > > > > > > > > multiple (and we lmb_alloc an area iirc) is used in all cases.
> > > > > > > > > >
> > > > > > > > > > Looking at the code this morning, I was confusing this with what we do
> > > > > > > > > > for compressed FIT images, oops.
> > > > > > > > >
> > > > > > > > > Ugh. Simon, can you go and fix this whole problem? Both do_bootz and
> > > > > > > > > do_booti have non-trivial amounts of code that's missed by changing from
> > > > > > > > > calling do_bootX() to bootX_run().
> > > > > > > >
> > > > > > > > For do_bootz() I believe the current code is correct. It does call
> > > > > > > > bootz_start() and then doesn't call it again when bootz_run() starts.
> > > > > > > > It looks like you have taken my Ubuntu test so perhaps I can add a
> > > > > > > > bootz test for another board in my lab.
> > > > > > > >
> > > > > > > > For do_booti(), the code in booti_start() is used for the
> > > > > > > > non-compressed case, so I believe it is still needed and that bootm
> > > > > > > > doesn't currently honour 'Image' relocation when using an uncompressed
> > > > > > > > image. But then there is the issue of SYS_BOOTM_LEN, below.
> > > > > > > >
> > > > > > > > bootm_load_os() has code for ARM at the end, which I suspect needs to
> > > > > > > > run on RISC-V too, in case the image needs to be relocated. Marek
> > > > > > > > added this 7 years ago[1] so it predates RISC-V and Heinrich perhaps
> > > > > > > > didn't notice it when adding his support , if it is actually needed.
> > > > > > > >
> > > > > > > > SYS_BOOTM_LEN is a 'last bastion' security feature to avoid people
> > > > > > > > loading images that wrap around memory, etc. I could put bootm_len
> > > > > > > > into struct bootm_info so that a 10x value can be used for the booti
> > > > > > > > case.
> > > > >
> > > > > I'm not sure any of the above is 100% correct. My very quick look was
> > > > > that it seems like if we want to have the command part of bootX be able
> > > > > to be equivalently called via API, more of most of the commands needs to
> > > > > be moved out of cmd/cmdX.c and to boot/bootX.c and put in to some state.
> > > >
> > > > Yes, my intent has been to move code out of commands into boot/ and
> > > > have things work as before.
> > >
> > > Then none of this should be in a "pxe" series, and you should have
> > > been removing a bunch more code out of the command part of the file.
> > >
> > > > Also don't forget that booting a FIT with a compressed boot kernel did
> > > > not work before my series. The series was largely written to fix bugs
> > > > (in one place) rather that just to refactor for the fun it.
> > >
> > > I'm not sure which FIT use case you're talking about here exactly and
> > > when it got broken (because if it was in use already, someone would have
> > > reported it).
> > >
> > > > > > > > Tom, we also have the issue that you haven't taken the rest of the PXE
> > > > > > > > series (due to the lwip case), so our trees are out of sync in this
> > > > > > > > area. It would really help if you could take that series, and again, I
> > > > > > > > am happy to do the lwip case once it is landed.
> > > > >
> > > > > Your further PXE rework is irrelevant to this discussion. Except in that
> > > > > it points out there's still further changes that could break other
> > > > > things even more.
> > > >
> > > > Yes, any change in untested code has the potential to create bugs. I
> > > > do the best I can, but I could use a little more support in this
> > > > effort.
> > >
> > > And the best way to get support for that is to slow down and make
> > > smaller more easily testable series. There's yet another bug in this
> > > series too that Svyatoslav has or will post about shortly.
> > >
> > > > > > > > So for now, if people agree, I can do a small series to use a
> > > > > > > > different SYS_BOOTM_LEN for the booti command and perhaps add RISC-V
> > > > > > > > as above.
> > > > >
> > > > > Well, no, that sounds like a step in the wrong direction. I'd like to
> > > > > instead restore the expected behavior, and then perhaps we could clean
> > > > > it up such that the compressed case for booti-Images works like FIT
> > > > > images where we lmb allocate a larger area if needed.
> > > >
> > > > Yes, restoring the 10x decompression size is what I am talking about
> > > > here. Is there anything else?
> > >
> > > Functional wise, the being reported now issue Svyatoslav found too.
> > >
> > > Implementation wise, yes, I don't want to refactor and re-wrtie a bunch
> > > of this as the first step. The first step should be just what's needed
> > > to move the working functionality out of cmd/bootX.c and in to
> > > boot/bootX.c and let people verify things haven't regressed. Then some
> > > rework can be reviewed on its own.
> > >
> > > > > > > > Later, I could continue the boot-unification effort, e.g. delete the
> > > > > > > > booti_start() function. and incorporate the uncompressed case into
> > > > > > > > bootm code.
> > > > > > >
> > > > > > > I'm not sure your reading of the situation is right. I'm more inclined
> > > > > > > to revert this merge rather than take on more rework in the area.
> > > > > >
> > > > > > Well that would be a pretty poor show. No one else has spent effort
> > > > > > trying to clean up and rationalise this code in the last 10 years, so
> > > > > > far as I can see. This is in -next so there is plenty of time to
> > > > > > resolve any issues.
> > > > >
> > > > > Yes, things haven't broken in 10 years. This is why I don't value "tidy
> > > > > up and refactor" in and of itself. Massive reworks then require a long
> > > > > time to check all of the corner cases. This has been true of many of the
> > > > > massive reworks you've done over the years.
> > > >
> > > > Well, do you want to be able to boot without CMDLINE, or not?
> > >
> > > It's an interesting long term goal. But since there's always some
> > > distribution or another that ships with each release we do, not having
> > > functional regressions is more important than speed of new features.
> > > Being able to practically disable the command line has been a feature
> > > for forever. Being able to literally has implications for both security
> > > and end user rights that need to be considered too.
> > >
> > > > > > I believe my reading of the situation is right, but if you disagree
> > > > > > with some of it, please indicate which.
> > > > >
> > > > > Your answer is not "Oh, I'll go understand what I broke and restore
> > > > > expected behavior". It's "you should take more of my big rework and I'll
> > > > > rework this area even more". That is not convincing that we won't have
> > > > > v2025.07 broken here.
> > > >
> > > > You only took half of the series, remember. We are talking about a
> > > > tiny corner case here, with no test coverage. I'm offering to fix the
> > > > case that has been reported. I can also even add a test for it.
> > >
> > > It wasn't half of the series. I didn't take more because it was either
> > > the stuff that broke other functionality or because it wasn't used until
> > > some further series from you. It's not a tiny corner case. A test case
> > > is nice, sure, but we'll never have 100% test coverage and need physical
> > > testing too. Which most people only have time for around releases. Which
> > > is why we need to go slow. Which again is why you need to split up your
> > > changes more and expect them to go slower. So there's time to test
> > > things.
> >
> > In summary, I think it is clear that I don't have your support for
> > this effort. Please go ahead and revert it in -next if that is what
> > you prefer.
>
> Well, Jonas reminded me on IRC that I reverted this series about a year
> ago because it had functional issues. I did not dig hard enough to see
> if they are the same issues or different issues.

Or even enough to see if it is the same series...

Regards,
Simon
