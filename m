Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D6D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8604893DB;
	Fri, 11 Oct 2024 23:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GliE2dxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F92893CC; Fri, 11 Oct 2024 20:25:36 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383A788B63
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea07610762so1635591a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728671133; x=1729275933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w2HxRjk48m9qyRiGZ20TjbuNpZNbEZcNYkRQAlfc4Sw=;
 b=GliE2dxMCR9CclXSSZUYq5dPuUTTcWHspOWPiWZ74eVPDZK0DWUimjilfTjWX3Qa2v
 E38Vnxj23lms9V6QWtpVdp7sWL2OeTynV03Dq2utsyx+WaUAb/8P//QBTUlkeP19G+Gq
 j1MIxDaSL5GC5+b7U23+lCx3H1IQXOQMszL/IcjKy7zDKMP1VCwBx7PZ+MaHpSDnLLq6
 JJ50gN3TLB8Gpp1lLIw6Sz5yg8Rcssq5hI9n/8fbJ95rYYM4tKGa+Pd1dAgREyZwTEuO
 RrDxqcOcLxt7Oee9dLGyPtQssMxu1r8HZdU4XFv8x9GV8Uu8CXXcrihRhX+AXQI6HOqv
 KSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728671133; x=1729275933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2HxRjk48m9qyRiGZ20TjbuNpZNbEZcNYkRQAlfc4Sw=;
 b=KIdtvlK7ybOrldWJitQnkdW8/43qj2cPpKMQhjiYq+K4X3mXSRcDqFDDDbF9qYFQHn
 q9nyjsIdnwJHMsPjiDdTd1nVHpj5cCvnwwhMwrWZ1b8KIRLhh1ozb1UyV1/zBkmZroKP
 cqSXp9YZtNljEV4nv1Ro4GKL0Dv99hyDDrNdtatJTC35mR7jkrqIMyUchvtyTKbDHHYN
 Yug687rkJx3dk5aDheWLoyMvlhvxNcLjAGUiq1kbz66S6vfZ7BiLlVUgjHEUwFWo0Itv
 1sUFVn0cl/KGTRrvCMZYHBIUFAPyrMJWm+es/GBwQkLVgp8TROfL5qK3ffHBmqvpOTMD
 VHsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSp6h8GwqKtUGFBbevx7Dqj0DTd0o2yiU7qOsGm6KDx7ILtY4XSV1PXnF9cd7xKWlsogEe1U0=@lists.denx.de
X-Gm-Message-State: AOJu0YwQk9vzwPtWFA18V9+kpHZbShphBWRGkvimFKNrJAIMlR8Oa9nB
 Gzp6+RHOjuAJB+9bAEsMaGNsOT3KzCFNH4ka5FhpQoInvSWnUDwC29a0YNvc41Dkq3jM9YNrBHW
 KdjUsDksPDe6xnR5D0Yfl54hFEfew28pKMtJyY4+cnqGpAM88a08=
X-Google-Smtp-Source: AGHT+IHxBMxDv/n/UZAshmJYSe2E07GrX/bUeBfecT6l1F7IPDAa2o4UAcrQwj2S9vCsBBMeLuc0vpafAwywtktBaHA=
X-Received: by 2002:a05:6a21:6e4a:b0:1d8:a6bb:2770 with SMTP id
 adf61e73a8af0-1d8bcf22b42mr5564875637.14.1728671132661; Fri, 11 Oct 2024
 11:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
 <20241009143824.GJ14210@bill-the-cat>
 <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
 <CAC_iWj+dBpgCM-WaJBgRyXmn1jWO--tGRTXjAT0hJL5G0V8D0g@mail.gmail.com>
 <20241009175243.GL14210@bill-the-cat>
In-Reply-To: <20241009175243.GL14210@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 11 Oct 2024 14:25:20 -0400
Message-ID: <CAEfUkUKT9JJHUcpNn8rFFbRVfpQ8wyYmka4zwZkBKYj2-F-ofA@mail.gmail.com>
Subject: Re: [PATCH v8 03/27] lib: Adapt digest header files to MbedTLS
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 manish.pandey2@arm.com, Stefan Bosch <stefan_b@posteo.net>, 
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
X-Mailman-Approved-At: Fri, 11 Oct 2024 23:11:27 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 9 Oct 2024 at 13:52, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Oct 09, 2024 at 08:32:29PM +0300, Ilias Apalodimas wrote:
> > On Wed, 9 Oct 2024 at 18:32, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Wed, 9 Oct 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:
> > >>
> > >> > Adapt digest header files to support both original libs and MbedTLS
> > >> > by switching on/off MBEDTLS_LIB_CRYPTO.
> > >> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> > >> > sha256.o should depend on SHA256 kconfig only but not
> SUPPORT_EMMC_RPMB,
> > >> > SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.
> > >> >
> > >> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> > >> > including <linux/kconfig.h> causes undefined reference on schedule()
> > >> > with sandbox build, as <linux/kconfig.h> includes
> <generated/autoconf.h>
> > >> > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no
> schedule()
> > >> > are defined in sandbox build,
> > >> > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
> > >> >
> > >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >>
> > >> There's three platforms where we see something like:
> > >>        arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0
> text +5400.0
> > >>             o4-imx6ull-nano: all +5651 data +112 rodata +139 text
> +5400
> > >>                u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
> > >>                  function                                   old
>  new   delta
> > >>                  hash_command                               108
>  296    +188
> > >>                  sha1_finish                                  -
>  156    +156
> > >>                  static.sha1_update                           -
>  114    +114
> > >>                  hash_algo                                    -
>  112    +112
> > >>                  sha1_padding                                 -
> 64     +64
> > >>                  hash_lookup_algo                             -
> 60     +60
> > >>                  sha1_starts                                  -
> 52     +52
> > >>                  crc16_ccitt_wd_buf                           -
> 36     +36
> > >>                  sha256_csum_wd                               -
> 34     +34
> > >>                  sha1_csum_wd                                 -
> 34     +34
> > >>                  hash_finish_sha256                           -
> 34     +34
> > >>                  hash_finish_sha1                             -
> 34     +34
> > >>                  crc32_wd_buf                                 -
> 34     +34
> > >>                  hash_finish_crc32                            -
> 28     +28
> > >>                  hash_finish_crc16_ccitt                      -
> 28     +28
> > >>                  hash_init_sha256                             -
> 22     +22
> > >>                  hash_init_sha1                               -
> 22     +22
> > >>                  hash_update_crc32                            -
> 20     +20
> > >>                  hash_update_crc16_ccitt                      -
> 20     +20
> > >>                  hash_init_crc32                              -
> 20     +20
> > >>                  hash_init_crc16_ccitt                        -
> 20     +20
> > >>                  hash_update_sha256                           -
> 16     +16
> > >>                  hash_update_sha1                             -
> 16     +16
> > >>                  sha1_update                                  -
>  8      +8
> > >>
> > >> This is because:
> > >> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > >> > index 982e84dc3bc..5d7fd904950 100644
> > >> > --- a/drivers/mmc/Kconfig
> > >> > +++ b/drivers/mmc/Kconfig
> > >> > @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
> > >> >  config SUPPORT_EMMC_RPMB
> > >> >       bool "Support eMMC replay protected memory block (RPMB)"
> > >> >       imply CMD_MMC_RPMB
> > >> > +     select SHA256
> > >> >       help
> > >> >         Enable support for reading, writing and programming the
> > >> >         key for the Replay Protection Memory Block partition in
> eMMC.
> > >>
> > >> Wasn't true / required before now, no hashing algorithms were enabled.
> > >> This was fine because:
> > >> [snip]
> > >> > diff --git a/lib/Makefile b/lib/Makefile
> > >> > index c4950b78a29..33755778283 100644
> > >> > --- a/lib/Makefile
> > >> > +++ b/lib/Makefile
> > >> > @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) += xxhash.o
> > >> >  obj-y += net_utils.o
> > >> >  obj-$(CONFIG_PHYSMEM) += physmem.o
> > >> >  obj-y += rc4.o
> > >> > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += sha256.o
> > >> >  obj-$(CONFIG_RBTREE) += rbtree.o
> > >> >  obj-$(CONFIG_BITREVERSE) += bitrev.o
> > >> >  obj-y += list_sort.o
> > >>
> > >> Got us the library access without bringing in everything else. And
> since
> > >> two of the platforms that are hitting this now are "nano" this is an
> > >> important thing to figure out how to continue to support. If there's
> > >> just no way around it, we can likely live with the size increase, but
> > >> I'd like to see this looked in to specifically first, thanks!
> > >>
> > > To address this, I think there are two options.
> > > 1. Introduce SUPPORT_EMMC_RPMB into the MbedTLS sub makefile.
> > > 2. Make MBEDTLS_LIB_CRYPTO depends on !SUPPORT_EMMC_RPMB.
> > > 1) looks to be ugly, I prefer 2) if you agree.
> >
> > 2 is not a good idea either. We can't just drop RPMB support when
> > mbedTLS is enabled
>
> To be clear, while I hope we can do something about this growth, I would
> rather live with it (as it's not an unreasonable amount) than do 2, and
> if 1 is too ugly, probably skip that as well. If it's not a matter of
> loosening some select statements, or maybe introducing a library type
> symbol we can see if anyone else more motivated has a better idea as
> it's literally 3 platforms (ev-imx280-nano-x-mb is the other nano, and
> then uniphier_v8 where it's arguably a missing feature anyhow) rather
> than a large number of them. And not even other "mini" or "nano"
> configs.
>
> Yes. I figured out what the problem is.
The "select SHA256" change doesn't matter, but size growth was introduced by
the inline function in sha1_alt.h I added in patch #2 of v8.
I already fixed this in my working branch:

   aarch64: (for 1/1 boards) all +8502.0 data +224.0 rodata +218.0 text
+8060.0
            uniphier_v8    : all +8502 data +224 rodata +218 text +8060
       arm: (for 2/2 boards) all +5649.0 data +112.0 rodata +137.0 text
+5400.0
            o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
            ev-imx280-nano-x-mb: all +5647 data +112 rodata +135 text +5400

Now there is no "u-boot: add" any more on these three boards.
I will update v9 with this fix, and we don't need either 1) or 2) options
mentioned
in my previous reply.

Regards,
Raymond
