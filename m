Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006ADE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 23:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0098D80202;
	Wed, 11 Dec 2024 00:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ww1QMBRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20DE780207; Wed, 11 Dec 2024 00:05:02 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521BA801DA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 00:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so60455947b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733871898; x=1734476698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nCnSOXh00vwOzBF6Bbpd2dMg7fwjc4/q15nCZFjpeig=;
 b=ww1QMBRxL9zNsOi8WdMjEL1pnNsnA86VjjoaDRFcznWsYFNqz388DtFpK4sGqKeBef
 lBmu+zgfVkSO/+RAHeDMYMJVsVrOWqMqwMVo2DNfHEUlCnITQ7M40QCaCDS8suejHwLp
 7SRqACCPls1+G23m0aWc3JqeVixzexopm6Nr44L3dHcYISyNWI7Wglgp4oV7Oy/jhJrr
 DvaCDlC/D2nrv+5ujEIi8nOLSYgEMWSBsXVW605GFxSoaUWRHLWFjy7GmL8zWlO/W6KW
 XXBa9WnFk1IvinENCiAswaCnALkGoG64C/0ZVgWg8UJUpyatFofd6ShbtE4Bh75TtNS2
 h8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733871898; x=1734476698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCnSOXh00vwOzBF6Bbpd2dMg7fwjc4/q15nCZFjpeig=;
 b=KSuRODmqY99lzeX0/3YVizyNUsvfoKYiLdYvooyBp2jO/Eqp49XAblTaDOzE1ffHKq
 qTpriZNYzeOb4VqqLvAwcgSbZuLi1qV7003OKUK2Vu1xrq1HkKmZqmwe88SRftcqVe1a
 Hm6BEu/8EH+YMUkry/sIOR+lFyRo6og6UuPsPB7dec2UuU34wPmrUVxs45oMgk5HRCXK
 TZaaKY4UrU7ADoWgmOAfFFQr366pOxmnCxiuUin9EL/ctTqovmFoTsQNjTptadKF5nZf
 AWan3TLKqbWL2912lpoUy4qkmPsaD9k4m0wP0bhSR1a7GnBcT2w4txJSW9CPPCM3G8BD
 2yZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFJrlaTqPapfiPg4btJdd66RClfyieMr28cr7sxbwzlEXB33ap1Cwwydx4SoUwPt1G8D/Tyyc=@lists.denx.de
X-Gm-Message-State: AOJu0YyQUJO0Hxziz+hTTxMqZXeZjWECU/uSRd5N/LT+DOJ15hcq58uY
 ZQ+dsq0Fc+RxOG/Bk1YhJe6s3+G5KKUGaQzpIu8t/kOFsxeIYoCgo2OAwcQBsKIgiAoMmEN6EV7
 StNnNd3oxlthH5I4TPd0EJgQPS474PoyOSDaGlw==
X-Gm-Gg: ASbGncud32K42FUnlbMHpOoLepLE/Cr2bhzZilnwJ424/xvIxmdVjbgs3pqHdZqXzcg
 6fBAp1kgpV84a86RwKs8HL6m9Xqam9AVmk88=
X-Google-Smtp-Source: AGHT+IHgNveD8mdd1/1mpHsaabkC9e3czbbBmFBrmqlimHiYUvQK2C6S1RGdTdUmomcGlwJk8O3K/h07uh4OfGq9W1Y=
X-Received: by 2002:a05:690c:c14:b0:6ef:7640:e18a with SMTP id
 00721157ae682-6f1480463cemr11939577b3.31.1733871898099; Tue, 10 Dec 2024
 15:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
 <CADg8p97-pEi7OTWwGQiDiTOvPaF+sq96UaK0bRhgU=YyQzTvRg@mail.gmail.com>
 <CAFLszTgu-sUN=cGkUEtqfw08J8dqTLLyXw4tVE2NG2qNi3U+QA@mail.gmail.com>
 <CAC_iWjJbL=93UFfkGAm4T4UitfHM0Cuz7VGFhdmiswXFt=qciQ@mail.gmail.com>
 <CAFLszTiwDSGA_uNpeimUha2V0e7CYCnC=jUWJ4wdw1Dtmms5Xg@mail.gmail.com>
In-Reply-To: <CAFLszTiwDSGA_uNpeimUha2V0e7CYCnC=jUWJ4wdw1Dtmms5Xg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 01:04:22 +0200
Message-ID: <CAC_iWjJ75FdGdrPSnAvL-Gx3fxK+Uj65JaCuOwHEGFNT6n7+Qg@mail.gmail.com>
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

Thanks Simon,

On Tue, 10 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 10 Dec 2024 at 11:00, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> >
> > On Tue, 10 Dec 2024 at 18:16, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, 10 Dec 2024 at 02:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Sun, 8 Dec 2024 at 16:22, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
> > > > > There's not much we gain from this abstraction, so let's remove the
> > > > > former and make the code a bit easier to follow.
> > > > >
> > > > > The code size increase is minimal - e.g for sandbox which includes all
> > > > > of the LMB tests
> > > > >
> > > > > add/remove: 0/1 grow/shrink: 12/0 up/down: 46/-4 (42)
> > > > > Function                                     old     new   delta
> > > > > lib_test_lmb_overlapping_reserve            1018    1030     +12
> > > > > version_string                                70      76      +6
> > > > > test_get_unreserved_size                    1032    1038      +6
> > > > > test_alloc_addr                             2933    2939      +6
> > > > > test_multi_alloc.constprop                  3034    3036      +2
> > > > > test_bigblock                                911     913      +2
> > > > > load_serial                                  946     948      +2
> > > > > lib_test_lmb_flags                          2101    2103      +2
> > > > > do_bootz                                     526     528      +2
> > > > > do_bootm_linux                              2067    2069      +2
> > > > > bootm_run_states                            5275    5277      +2
> > > > > boot_relocate_fdt                            599     601      +2
> > > > > lmb_reserve                                    4       -      -4
> > > > > Total: Before=2492742, After=2492784, chg +0.00%
> > > > >
> > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > ---
> > > >
> > > > Fwiw, I had attempted this earlier on similar lines -- have a single
> > > > API, which would take the flag as a parameter [1], but was asked not
> > > > to take this approach as part of the review [2].
> > > >
> > >
> > > You missed that sandbox has LTO enabled. With that disabled (like many boards):
> > >
> > >    sandbox: (for 1/1 boards) all -32.0 text -32.0
> > >
> > > We just had a patch and discussion to remove a single function call to
> > > save 8 bytes[3]
> > >
> > > For firefly-rk3399 this adds 36 bytes:
> > >
> > >    aarch64: (for 1/1 boards) all +68.0 bss +48.0 text +20.0
> >
> > Did you include DM tests in that config? Because applying the series
> > says otherwise
> >
> > for firefly-rk3399_defconfig
> > add/remove: 0/5 grow/shrink: 14/0 up/down: 480/-544 (-64)
> > Function                                     old     new   delta
> > lmb_alloc_base_flags                          76     324    +248
> > lmb_alloc_addr_flags                           4     144    +140
> > version_string                                50      70     +20
> > boot_relocate_fdt                            488     508     +20
> > boot_ramdisk_high                            268     284     +16
> > tftp_handler                                1304    1308      +4
> > load_serial                                  512     516      +4
> > lmb_alloc                                      8      12      +4
> > image_setup_libfdt                           380     384      +4
> > do_spi_flash                                2164    2168      +4
> > do_load                                      732     736      +4
> > do_bootz                                     332     336      +4
> > do_booti                                     520     524      +4
> > bootm_run_states                            2176    2180      +4
> > lmb_reserve                                    8       -      -8
> > lmb_alloc_addr                                 8       -      -8
> > lmb_alloc_base                                80       -     -80
> > _lmb_alloc_addr                              144       -    -144
> > _lmb_alloc_base                              304       -    -304
> > Total: Before=691587, After=691523, chg -0.01%
>
> OK good
>
> >
> > >
> > > You could run buildman on all arm64 boards to check it, perhaps.
> >
> > I did test on non-LTO platforms as well, building for all is kind of
> > pointless no? It's either LTO or no LTO.
>
> Right
>
> > FWIW you need to apply the entire series, not just a single patch.
> >
>
> Yes, understood, I was just replying to that one patch.
>
> > rpi_arm64_defconfig
> > add/remove: 0/5 grow/shrink: 11/0 up/down: 452/-544 (-92)
> > Function                                     old     new   delta
> > lmb_alloc_base_flags                          76     324    +248
> > lmb_alloc_addr_flags                           4     144    +140
> > boot_relocate_fdt                            516     536     +20
> > boot_ramdisk_high                            268     284     +16
> > tftp_handler                                1552    1556      +4
> > load_serial                                  512     516      +4
> > lmb_alloc                                      8      12      +4
> > image_setup_libfdt                           456     460      +4
> > do_load                                      728     732      +4
> > do_booti                                     520     524      +4
> > bootm_run_states                            1824    1828      +4
> > lmb_reserve                                    8       -      -8
> > lmb_alloc_addr                                 8       -      -8
> > lmb_alloc_base                                80       -     -80
> > _lmb_alloc_addr                              144       -    -144
> > _lmb_alloc_base                              304       -    -304
> > Total: Before=542062, After=541970, chg -0.02%
> >
> > qemu_arm64_lwip_defconfig
> > add/remove: 0/5 grow/shrink: 11/0 up/down: 452/-544 (-92)
> > Function                                     old     new   delta
> > lmb_alloc_base_flags                          76     324    +248
> > lmb_alloc_addr_flags                           4     144    +140
> > boot_relocate_fdt                            488     508     +20
> > boot_ramdisk_high                            268     284     +16
> > load_serial                                  548     552      +4
> > lmb_alloc                                      8      12      +4
> > image_setup_libfdt                           368     372      +4
> > do_load                                      728     732      +4
> > do_bootz                                     332     336      +4
> > do_booti                                     520     524      +4
> > bootm_run_states                            2176    2180      +4
> > lmb_reserve                                    8       -      -8
> > lmb_alloc_addr                                 8       -      -8
> > lmb_alloc_base                                80       -     -80
> > _lmb_alloc_addr                              144       -    -144
> > _lmb_alloc_base                              304       -    -304
> > Total: Before=1020122, After=1020030, chg -0.01%
> >
> >
> > >
> > > The other thing is that there is actually only one place apart from
> > > tests where the flag is needed - in boot_fdt_add_mem_rsv_regions().
> > > Boards don't use that flag. It is the flags themselves which are
> > > confusing.
> > >
> >
> > I still think it's way easier to read without two levels of
> > abstraction. Since the series decreases the size -- unless you include
> > all DM Tests, I'd like to keep the flags as is for now, so I can send
> > the next round which is the actual cleanup.
> > We can re-introduce them if someone finds a 'size problem'. But since
> > it's only when you enable DM I doubt anyone wants to have them working
> > in SPL or production firmware.
>
> OK, well I don't mind, if there is no growth. I wonder if you could do
> better overall without this patch, but perhaps not.

Probably yes, but we are not looking into anything more than a few
bytes -- probably under 4 as well.
TBH if we all agree that removing the non-flag variants is fine, I can
name the functions without it.

/Ilias
>
> >
> > /Ilias
> > > Regards,
> > > Simon
> > >
> > > > -sughosh
> > > >
> > > > [1] - https://lists.denx.de/pipermail/u-boot/2024-July/559790.html
> > > > [2] - https://lists.denx.de/pipermail/u-boot/2024-August/561607.html
> > > >
> > > > >  arch/powerpc/cpu/mpc85xx/mp.c |  2 +-
> > > > >  arch/powerpc/lib/misc.c       |  2 +-
> > > > >  boot/bootm.c                  |  3 ++-
> > > > >  boot/image-board.c            |  2 +-
> > > > >  boot/image-fdt.c              |  5 +++--
> > > > >  cmd/booti.c                   |  2 +-
> > > > >  cmd/bootz.c                   |  2 +-
> > > > >  cmd/load.c                    |  2 +-
> > > > >  include/lmb.h                 |  1 -
> > > > >  lib/lmb.c                     |  5 -----
> > > > >  test/lib/lmb.c                | 30 +++++++++++++++---------------
> > > > >  11 files changed, 26 insertions(+), 30 deletions(-)
> > > > >
> > >
> > > [3] https://patchwork.ozlabs.org/project/uboot/patch/f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com/
>
> Regards,
> SImon
