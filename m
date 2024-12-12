Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E023E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 21:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44611801BD;
	Thu, 12 Dec 2024 22:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a7IyoMnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5461801BE; Thu, 12 Dec 2024 22:31:06 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B87800B5
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 22:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ef60e500d7so9020007b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734039062; x=1734643862; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHbEYb+jytdp+8GIvFL1LAigtHy9QZQl7jnhltMVqv8=;
 b=a7IyoMnWd33v+YHquCP/prXd6t4rvtXQ3gUkgXZKsy3LK2rO5ZoTB6uJ9Bu6OQdcNH
 uyepOW8QcEZFSRo7vQsPhne+ATsVHEhpojWHfoPDGqsZFMxn1jn3iNsWDqNXCuPh2baY
 cRloxsljgTXc3EOvshQKnve78l8kqem59HOVPEsVinQa8gxrUUxZE7dpq0mhkXuy6sIo
 dZAgOS+tG3kzDMFnG09rAIbLsO5X/cxx2TtBpyQJT+JNph1pfMAKrJj+FRkXOVHJtaiS
 3DChBM+yhoMxz9CH7IiD1PnVXlMnQddHs8X6AsBhDcJIv0j4C3PcfIG8CbiCnDqIQj7i
 71NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734039062; x=1734643862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHbEYb+jytdp+8GIvFL1LAigtHy9QZQl7jnhltMVqv8=;
 b=klzlkobxeyINk/7tMRpXZR5Xg6KF+gEO2qVwoQBs6VbgTGnowX6JhPxL/VU3SKkJtn
 TPlM6SsrVgXXkNhravvJQFsfBH+XtjvuSZG0/bXNYJ6gYSoTLhW6TEpA+37Aea8ylNmD
 2LR6TjKvfJwHS/6+y2p1IsNJNIL4QtYU6opxyaFFO5Xvb1oaFxSipSNV8r90TXoABc4S
 Ajy/p+9OvkiK2cEm16zx655phHLi30lRZ9F08kiY1hIqxyFa3GgnS+HHEKjN7u/OpZs+
 sbU9OSuCHT1PaVRoCOdsSEI1rHa2axH3yI94HgWKwUA3OgsNNgYnwc5FG7ilQiE+d9Jq
 cy9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV3bbYjKxwgmG7YaiPL0XpHSs8ezJC4uLN8up45U0JTqLWFzeKhPJZshXdBySt0RTjCMYxDzo=@lists.denx.de
X-Gm-Message-State: AOJu0YxqCPDRX7OV1pl/pxlL8mYLUSC+0x3b5ogz6+iuTD7zNG4Gu+aJ
 Zc8+BS+ts9rYqxM3x3OtPY+/j7ERg+Q37gN1E0ARKXlLQUgFyN2C3VSaCe6hU3PV1OIJixIB0ee
 ZoHshkB9lTGmXrmQINTGq/TEelszoIRNKJ4w4YA==
X-Gm-Gg: ASbGncvdvJKMZiGuyv9jHT4Nna6cbKkah8ADmiNEgz7VEM4zGvnfn3gWrzbukInl5SS
 dvGQ7AfRZd0XcoWmDXNzwMLQTL6USCNZwZndxOQ==
X-Google-Smtp-Source: AGHT+IEz5sI+gKK4XC+E79RhnHc+MI/I3R3u3BDbXGW2XwyDqLO67cHlbX2eUkggB5ItwW3GpZEn4pDd41eIAlxi9FE=
X-Received: by 2002:a05:690c:48c1:b0:6ef:993a:29b4 with SMTP id
 00721157ae682-6f2798e22femr3534447b3.0.1734039061825; Thu, 12 Dec 2024
 13:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 15:30:51 -0600
Message-ID: <CAPLW+4nTJ-hPA6d6PD5siVkW3VcbDkPbkmujVe5rAqFCPfUGFQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Cleanup the LMB subsystem
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> This is v1 of the rfc [0]
>
> The LMB subsystem was used opportunistically for a number of years.
> A while back Sughosh merged it with the EFI subsystem in order to have a
> common allocator and avoid subsystems overwriting memory they shouldn't.
>
> This is an initial cleanup of all the crud we gathered over the years.
> There's no functional change expected from the patches as they just clean=
up
> some abstraction functions and rename a few variables to make more
> sense.
>
> I plan to make even bigger changes -- e.g I don't see the point of
> having *_alloc() and *_reserve() versions of the functions since they mos=
tly
> do the same thing and just cause confusion. lmb_alloc_addr_flags()
> returning the base address on success makes little sense since we
> already *request* the address on the function arguments, etc.
> Since this patchset grew enough already, I'd like to get it in
> before more refactoring happens.
>
> It's worth noting that although some patches slightly increase the code
> size due to an extra flags argument being carried around, the final
> result is eventually smaller.
>
> # qemu_arm64_lwip_defconfig (version string adds another 20b)
> add/remove: 0/5 grow/shrink: 15/1 up/down: 568/-628 (-60)
> Function                                     old     new   delta
> lmb_alloc_base                                80     324    +244
> lmb_alloc_addr                                 8     144    +136
> lmb_reserve                                    8      96     +88
> version_string                                50      70     +20
> boot_relocate_fdt                            488     508     +20
> boot_ramdisk_high                            268     284     +16
> lmb_add_region_flags                         696     704      +8
> boot_fdt_reserve_region                      100     108      +8
> load_serial                                  548     552      +4
> lmb_alloc                                      8      12      +4
> image_setup_libfdt                           368     372      +4
> do_load                                      728     732      +4
> do_bootz                                     332     336      +4
> do_booti                                     520     524      +4
> bootm_run_states                            2176    2180      +4
> lmb_alloc_addr_flags                           4       -      -4
> boot_fdt_add_mem_rsv_regions                 284     280      -4
> lmb_alloc_base_flags                          76       -     -76
> lmb_reserve_flags                             96       -     -96
> _lmb_alloc_addr                              144       -    -144
> _lmb_alloc_base                              304       -    -304
> Total: Before=3D1020102, After=3D1020042, chg -0.01%
>
> # sandbox_defconfig (version string adds another 20b)
> add/remove: 0/3 grow/shrink: 24/3 up/down: 523/-501 (22)
> Function                                     old     new   delta
> lmb_alloc_base                                48     299    +251
> lmb_alloc_addr                                 4      92     +88
> lmb_reserve                                    4      58     +54
> test_alloc_addr                             2933    2963     +30
> version_string                                50      70     +20
> lib_test_lmb_overlapping_reserve            1018    1030     +12
> lmb_add_region_flags                         600     610     +10
> test_multi_alloc.constprop                  3034    3042      +8
> test_get_unreserved_size                    1032    1038      +6
> boot_relocate_fdt                            599     605      +6
> boot_fdt_reserve_region                       67      73      +6
> lmb_alloc                                      4       9      +5
> lmb_free_flags                               190     194      +4
> wget_handler                                1530    1533      +3
> tftp_handler                                1190    1192      +2
> test_noreserved                             1207    1209      +2
> test_bigblock                                911     913      +2
> load_serial                                  946     948      +2
> lib_test_lmb_flags                          2101    2103      +2
> do_spi_flash                                3150    3152      +2
> do_bootz                                     526     528      +2
> do_bootm_linux                              2067    2069      +2
> bootm_run_states                            5275    5277      +2
> _fs_read.lto_priv                            331     333      +2
> lmb_dump_region.lto_priv                     356     353      -3
> lmb_add                                       59      52      -7
> efi_allocate_pages.part                      303     249     -54
> lmb_reserve_flags                             65       -     -65
> _lmb_alloc_addr.lto_priv                      92       -     -92
> _lmb_alloc_base.lto_priv                     280       -    -280
> Total: Before=3D2492722, After=3D2492744, chg +0.00%
>
> [0] https://lore.kernel.org/u-boot/20241208105223.2821049-1-ilias.apalodi=
mas@linaro.org/T/#m43927af3f758f8d0be897a8a6c77b4325546afd5
>
> Changes since v1:
> - Rebased on top of
>   https://lore.kernel.org/u-boot/20241211021703.2333-1-semen.protsenko@li=
naro.org/
>   https://lore.kernel.org/u-boot/20241211022550.2995-1-semen.protsenko@li=
naro.org/
> - Converted enum lmb_flags to a u32
> - Removed the _flags from all the functions
> - Added a patch that removes lmb_align_down()
> - Picked up r-b tags. Tom I kept your on patch #3 since I only changed th=
e name
>   of the function and assumed you are ok with it.
>
> Ilias Apalodimas (8):
>   lmb: Remove lmb_align_down()
>   lmb: Move enum lmb_flags to a u32
>   lmb: Remove lmb_reserve_flags()
>   lmb: Rename free_mem to available_mem
>   lmb: Remove lmb_add_region()
>   lmb: Remove lmb_alloc_addr_flags()
>   lmb: Remove lmb_alloc_base_flags()
>   lmb: Rename _lmb_alloc_addr() to lmb_alloc_addr_flags()
>
>  arch/powerpc/cpu/mpc85xx/mp.c |   2 +-
>  arch/powerpc/lib/misc.c       |   2 +-
>  boot/bootm.c                  |   3 +-
>  boot/image-board.c            |  20 +++--
>  boot/image-fdt.c              |  15 ++--
>  cmd/booti.c                   |   2 +-
>  cmd/bootz.c                   |   2 +-
>  cmd/load.c                    |   2 +-
>  fs/fs.c                       |   2 +-
>  include/lmb.h                 |  58 ++++++---------
>  lib/efi_loader/efi_memory.c   |   6 +-
>  lib/lmb.c                     | 136 +++++++++++-----------------------
>  test/cmd/bdinfo.c             |   4 +-
>  test/lib/lmb.c                |  92 +++++++++++------------
>  14 files changed, 145 insertions(+), 201 deletions(-)
>
> --

Hi Ilias,

This series doesn't apply as is on current master (tried MBOX file
from lore). I'll still try to review it by merging conflicts locally,
but please double check it on your side, and re-submit in case of
actual conflicts.

> 2.45.2
>
