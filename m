Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB43EE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 18:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2DF802C2;
	Tue, 10 Dec 2024 19:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cdmiEyNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0DA802C6; Tue, 10 Dec 2024 19:00:52 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41C280274
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 19:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6efed201f1dso32007327b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733853648; x=1734458448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fI+gVZ0zrWXfcBfPbGreKfRTxqj/37NQflArVf4fQRc=;
 b=cdmiEyNBvOx+E+nxsGraDKvZZb7jd6bzs2qHAdZRgoYJOjbF8yegP9Q2fdL9qBRj9T
 GzMbJ6z3EF0ehNV09d2naLmsvoiisBar9nQ6XM7tf3At3QLz0iPWZtuEfzXu5lSl5V9N
 O00iQjYhrkicAbNb/xDC3rmXGk18PFw83a5oQWnHJZB8tS3cW04anDu6VozgR+K+2uLw
 T7iMXtkHDkHKbs749rm++1WQYXf3AiAzLtD9bOk2xoE/+qZalGfjGWVydCn70MzEvUgB
 FGPjeS5YDBJwTd5UudH2W97e8kQCXBNmsb8ikMd1/Bs7RDwl2kk/4rzY1nw0oHMr+H+o
 radw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733853648; x=1734458448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fI+gVZ0zrWXfcBfPbGreKfRTxqj/37NQflArVf4fQRc=;
 b=NNn4+6bNvIznrUwLYc2BKp1K6+6lXedHMOOEiGdFaeS18yPZENJ7uApxHIch3YxA5J
 iLuYJR8RMhvHI1BHInbDwTjnH+dI9CDuwmc98kpLSzf+N/WYcZMs3sofdamivT17rr2n
 QOfe/iDddiqHonjY+heCUzDfR4sryCZyZ62QGcdz7UR2MNXzdBSMhyOG7DXCMbAG/oay
 7YIUyH+5vcC94VhN294dIq773b+B+99Q9UGkoSGwGW98yT6kpec+AS/IdLgmlOFahr/E
 C9ZIZuxPRw9FL10u8v7TlSZOZ9ykz895m9i1fTws5+Zue2VWJOMT6dJffl4pnfhjvDb3
 ns6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDaAXVNTTINlnGNz72cqyVctuCMKI6OmkzzI3ttVJwQMNvd2jySPrrMtijQWXCnfJkDKyUlnM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4E9opCvjk4V35a3tAfIaJdrWNyKgv0aOp4EJbspU9cMNIbD2D
 ZOBVX2hjXj+qBAeZ0+/yuG3y9D45V/XL/FiDXUsMBSi2GHkmlGrMQXDCQD3Ntpkc8HeLmM9PsCg
 amf0vljiBCq2LzYwf+EJLLqmFtNIIHuGxQR0bZA==
X-Gm-Gg: ASbGncvJJoFq2yFTr7ok0FJJ1S1IqWSRz/pil3CW+fXgUn7je2nIVyOLP1POJwPh9Gy
 SIqtBi+ejTPp0AWlxigsNYdLI30Sa4ufQt8g=
X-Google-Smtp-Source: AGHT+IEOajT18diekmcLIHAKnJaJ4zHyHa0RbCRS3fHorsLBcMsdSo9Th7tgsFLgQOOOYjp1FBQsKa+cfYuYZirgzgE=
X-Received: by 2002:a05:690c:48c3:b0:6ef:a227:c0b5 with SMTP id
 00721157ae682-6f147ff2306mr687267b3.25.1733853648603; Tue, 10 Dec 2024
 10:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
 <CADg8p97-pEi7OTWwGQiDiTOvPaF+sq96UaK0bRhgU=YyQzTvRg@mail.gmail.com>
 <CAFLszTgu-sUN=cGkUEtqfw08J8dqTLLyXw4tVE2NG2qNi3U+QA@mail.gmail.com>
In-Reply-To: <CAFLszTgu-sUN=cGkUEtqfw08J8dqTLLyXw4tVE2NG2qNi3U+QA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Dec 2024 20:00:12 +0200
Message-ID: <CAC_iWjJbL=93UFfkGAm4T4UitfHM0Cuz7VGFhdmiswXFt=qciQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] lmb: Replace lmb_reserve() with
 lmb_reserve_flags()
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

Hi Simon,


On Tue, 10 Dec 2024 at 18:16, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Tue, 10 Dec 2024 at 02:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Sun, 8 Dec 2024 at 16:22, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
> > > There's not much we gain from this abstraction, so let's remove the
> > > former and make the code a bit easier to follow.
> > >
> > > The code size increase is minimal - e.g for sandbox which includes all
> > > of the LMB tests
> > >
> > > add/remove: 0/1 grow/shrink: 12/0 up/down: 46/-4 (42)
> > > Function                                     old     new   delta
> > > lib_test_lmb_overlapping_reserve            1018    1030     +12
> > > version_string                                70      76      +6
> > > test_get_unreserved_size                    1032    1038      +6
> > > test_alloc_addr                             2933    2939      +6
> > > test_multi_alloc.constprop                  3034    3036      +2
> > > test_bigblock                                911     913      +2
> > > load_serial                                  946     948      +2
> > > lib_test_lmb_flags                          2101    2103      +2
> > > do_bootz                                     526     528      +2
> > > do_bootm_linux                              2067    2069      +2
> > > bootm_run_states                            5275    5277      +2
> > > boot_relocate_fdt                            599     601      +2
> > > lmb_reserve                                    4       -      -4
> > > Total: Before=2492742, After=2492784, chg +0.00%
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> >
> > Fwiw, I had attempted this earlier on similar lines -- have a single
> > API, which would take the flag as a parameter [1], but was asked not
> > to take this approach as part of the review [2].
> >
>
> You missed that sandbox has LTO enabled. With that disabled (like many boards):
>
>    sandbox: (for 1/1 boards) all -32.0 text -32.0
>
> We just had a patch and discussion to remove a single function call to
> save 8 bytes[3]
>
> For firefly-rk3399 this adds 36 bytes:
>
>    aarch64: (for 1/1 boards) all +68.0 bss +48.0 text +20.0

Did you include DM tests in that config? Because applying the series
says otherwise

for firefly-rk3399_defconfig
add/remove: 0/5 grow/shrink: 14/0 up/down: 480/-544 (-64)
Function                                     old     new   delta
lmb_alloc_base_flags                          76     324    +248
lmb_alloc_addr_flags                           4     144    +140
version_string                                50      70     +20
boot_relocate_fdt                            488     508     +20
boot_ramdisk_high                            268     284     +16
tftp_handler                                1304    1308      +4
load_serial                                  512     516      +4
lmb_alloc                                      8      12      +4
image_setup_libfdt                           380     384      +4
do_spi_flash                                2164    2168      +4
do_load                                      732     736      +4
do_bootz                                     332     336      +4
do_booti                                     520     524      +4
bootm_run_states                            2176    2180      +4
lmb_reserve                                    8       -      -8
lmb_alloc_addr                                 8       -      -8
lmb_alloc_base                                80       -     -80
_lmb_alloc_addr                              144       -    -144
_lmb_alloc_base                              304       -    -304
Total: Before=691587, After=691523, chg -0.01%

>
> You could run buildman on all arm64 boards to check it, perhaps.

I did test on non-LTO platforms as well, building for all is kind of
pointless no? It's either LTO or no LTO.
FWIW you need to apply the entire series, not just a single patch.

rpi_arm64_defconfig
add/remove: 0/5 grow/shrink: 11/0 up/down: 452/-544 (-92)
Function                                     old     new   delta
lmb_alloc_base_flags                          76     324    +248
lmb_alloc_addr_flags                           4     144    +140
boot_relocate_fdt                            516     536     +20
boot_ramdisk_high                            268     284     +16
tftp_handler                                1552    1556      +4
load_serial                                  512     516      +4
lmb_alloc                                      8      12      +4
image_setup_libfdt                           456     460      +4
do_load                                      728     732      +4
do_booti                                     520     524      +4
bootm_run_states                            1824    1828      +4
lmb_reserve                                    8       -      -8
lmb_alloc_addr                                 8       -      -8
lmb_alloc_base                                80       -     -80
_lmb_alloc_addr                              144       -    -144
_lmb_alloc_base                              304       -    -304
Total: Before=542062, After=541970, chg -0.02%

qemu_arm64_lwip_defconfig
add/remove: 0/5 grow/shrink: 11/0 up/down: 452/-544 (-92)
Function                                     old     new   delta
lmb_alloc_base_flags                          76     324    +248
lmb_alloc_addr_flags                           4     144    +140
boot_relocate_fdt                            488     508     +20
boot_ramdisk_high                            268     284     +16
load_serial                                  548     552      +4
lmb_alloc                                      8      12      +4
image_setup_libfdt                           368     372      +4
do_load                                      728     732      +4
do_bootz                                     332     336      +4
do_booti                                     520     524      +4
bootm_run_states                            2176    2180      +4
lmb_reserve                                    8       -      -8
lmb_alloc_addr                                 8       -      -8
lmb_alloc_base                                80       -     -80
_lmb_alloc_addr                              144       -    -144
_lmb_alloc_base                              304       -    -304
Total: Before=1020122, After=1020030, chg -0.01%


>
> The other thing is that there is actually only one place apart from
> tests where the flag is needed - in boot_fdt_add_mem_rsv_regions().
> Boards don't use that flag. It is the flags themselves which are
> confusing.
>

I still think it's way easier to read without two levels of
abstraction. Since the series decreases the size -- unless you include
all DM Tests, I'd like to keep the flags as is for now, so I can send
the next round which is the actual cleanup.
We can re-introduce them if someone finds a 'size problem'. But since
it's only when you enable DM I doubt anyone wants to have them working
in SPL or production firmware.

/Ilias
> Regards,
> Simon
>
> > -sughosh
> >
> > [1] - https://lists.denx.de/pipermail/u-boot/2024-July/559790.html
> > [2] - https://lists.denx.de/pipermail/u-boot/2024-August/561607.html
> >
> > >  arch/powerpc/cpu/mpc85xx/mp.c |  2 +-
> > >  arch/powerpc/lib/misc.c       |  2 +-
> > >  boot/bootm.c                  |  3 ++-
> > >  boot/image-board.c            |  2 +-
> > >  boot/image-fdt.c              |  5 +++--
> > >  cmd/booti.c                   |  2 +-
> > >  cmd/bootz.c                   |  2 +-
> > >  cmd/load.c                    |  2 +-
> > >  include/lmb.h                 |  1 -
> > >  lib/lmb.c                     |  5 -----
> > >  test/lib/lmb.c                | 30 +++++++++++++++---------------
> > >  11 files changed, 26 insertions(+), 30 deletions(-)
> > >
>
> [3] https://patchwork.ozlabs.org/project/uboot/patch/f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com/
