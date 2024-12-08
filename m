Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6F8E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 11:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F3788BFC;
	Sun,  8 Dec 2024 12:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JYbWRF00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E74F89492; Sun,  8 Dec 2024 12:10:17 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718A388A43
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 12:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6efa1e49ef0so35554067b3.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 03:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733656213; x=1734261013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gvXh9sCPRytHL3H5XhIuyCQSL63E8GpCrVuovrhe7u4=;
 b=JYbWRF00tHf83klSfVCYK8Hq/02P2d112jBeuc5W91X1+cGh7KXCuv8udVoVOmfiTO
 ozX0Pux3EuGhzXNV7m3HKrlxd7woKLPEQjFLQedq0cvQNjpvf3RP5O+/IrCftvNM//6Y
 zJuwZbPKcQuZ7HCdLw9qnXIZvP976q00n6wWqp0GDfIwNxYXlSrttd8MAJtCc0VYuLh5
 G3xSUlkDMmdMCq9Y+oiCRnwT6vl57SXasUpZ4/IfL0VorjS/WOwcDkZ/ZKZWrPM1RNKV
 np55KdyyLxV11apF64FCJQ1lZpZabTZOMAqemJjh+3+RmN8JRm2WlbPC2SyZrHKcsJ+l
 6KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733656213; x=1734261013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gvXh9sCPRytHL3H5XhIuyCQSL63E8GpCrVuovrhe7u4=;
 b=mlxsl1wgsbrEl3LYkzikFQIXGHhM8abfC3GfmAItkf4iolxxsWzHjL99FrxvfFyoX6
 NJrZccyCjePyTS39pAo6w5KlDqGMsnnBXMuemK4JHgUVN5zCzqeBMUgYfFEPPva4YohO
 fykYqOKpse1garg8qbmUei3uep4bUGG4tVmzIxQZM7Bkich/vlJUa5tYcI/itxnK4Wzl
 n5tMxRuQZtRkcvsrQSw19bRO5r+Rwt6T+lOx90xELKo2LqrKC6tp0LSmYnmI2o2Avqzh
 j5mLzkaG75npcCA+pmcG555nKZQjzg+WHrLVGNV6ZEwb8hofXxz4NeJYAHgbwxRBaW5N
 Es/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs6JTkqcNbJKgmGcNay+8yyUYdIYBx/ahnKTxD6dZbGj4a/ceQ6YoAFWOvU1hcQJF7vP7FcK4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3jNGbNgpB/+qEj4YvTPBd/ohm8A3Lt76aFfILb+3bO+LUmKq1
 tj7g0PsWezGFtwR79k21uY/m6v5MqRTwK/ZXBOlqB7eNeb6LzKGJJsVPKez7zQHD8kVDsdx8gV9
 Nl+ZePmywShvW1CqoOQkLbEYD2qQNY+3IHR09tQ==
X-Gm-Gg: ASbGncvxkZ7iP3zsmp+1hprl68qIXQnS5h9lTG9c81OGAGuUUDXv+r5slFV1l8voIKh
 8tPYTCJWTKflnrV9axsTpy1ZkBjHPsF4=
X-Google-Smtp-Source: AGHT+IG/ggXsuk8sgc5Wv3CF1WltfT/1Zx7FuHukVaWgKU9PnhhC9z1pExL3qSlUUSVAuEFCixS8XDC2oBpdANKEjBI=
X-Received: by 2002:a05:690c:62c8:b0:6ef:4ed2:7dfe with SMTP id
 00721157ae682-6efe3c6c9f6mr103211547b3.31.1733656213243; Sun, 08 Dec 2024
 03:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 13:09:37 +0200
Message-ID: <CAC_iWj++EmhHYeALc-m7p4s+CpBpSoXWgEzSdkV2Bx36qSvT=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Cleanup the LMB subsystem
To: xypron.glpk@gmx.de, trini@konsulko.com
Cc: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

+CC Sam

Apologies, I forgot to CC you, I guess you can find the rest of the
series on lore?

On Sun, 8 Dec 2024 at 12:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The LMB subsystem was used opportunistically for a number of years.
> A while back Sughosh merged it with the EFI subsystem in order to have a
> common allocator and avoid subsystems overwriting memory they shouldn't.
>
> This is an initial cleanup of all the crud we gathered over the years.
> There's no functional change expected from the patches as they just cleanup
> some abstraction functions and rename a few variables to make more
> sense.
>
> This has to be rebased on top of Sam's [0] changes but that should be
> trivial.
>
> I plan to make even bigger changes -- e.g I don't see the point of
> having *_alloc() and *_reserve() versions of the functions since they mostly
> do the same thing and just cause confusion. lmb_alloc_addr_flags()
> returning the base address on success makes little sense since we
> already *request* the address on the function arguments, etc.
> But since this patchset grew enough already, I'd like to get it in
> before more refactoring happens.
>
> It's worth noting that although some patches slightly increase the code
> size due to an extra flags argument being carried around, the final
> result is eventually smaller.
>
> add/remove: 2/5 grow/shrink: 17/3 up/down: 479/-524 (-45)
> Function                                     old     new   delta
> lmb_alloc_base_flags                           -     299    +299
> lmb_alloc_addr_flags                           -      90     +90
> test_alloc_addr                             2933    2963     +30
> lib_test_lmb_overlapping_reserve            1018    1030     +12
> test_multi_alloc.constprop                  3034    3042      +8
> test_get_unreserved_size                    1032    1038      +6
> boot_relocate_fdt                            599     605      +6
> lmb_alloc                                      4       9      +5
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
> lmb_reserve                                    4       -      -4
> lmb_alloc_addr                                 4       -      -4
> lmb_overlaps_region                           62      52     -10
> lmb_add_region_flags                         600     568     -32
> lmb_alloc_base                                48       -     -48
> efi_allocate_pages.part                      303     249     -54
> _lmb_alloc_addr.lto_priv                      92       -     -92
> _lmb_alloc_base.lto_priv                     280       -    -280
> Total: Before=2492742, After=2492697, chg -0.00%
>
> [0] https://lore.kernel.org/u-boot/20241208002121.31887-1-semen.protsenko@linaro.org/
>
>
> Ilias Apalodimas (7):
>   lmb: Replace lmb_reserve() with lmb_reserve_flags()
>   lmb: Simplify lmb_addrs_overlap()
>   lmb: Rename free_mem to available_mem
>   lmb: Remove lmb_add_region()
>   lmb: Replace lmb_alloc_addr() with lmb_alloc_addr_flags()
>   lmb: Replace lmb_alloc_base() with lmb_alloc_base_flags()
>   lmb: Rename _lmb_alloc_addr_flags()
>
>  arch/powerpc/cpu/mpc85xx/mp.c |   2 +-
>  arch/powerpc/lib/misc.c       |   2 +-
>  boot/bootm.c                  |   3 +-
>  boot/image-board.c            |  24 +++++---
>  boot/image-fdt.c              |  11 ++--
>  cmd/booti.c                   |   2 +-
>  cmd/bootz.c                   |   2 +-
>  cmd/load.c                    |   2 +-
>  fs/fs.c                       |   2 +-
>  include/lmb.h                 |  11 ++--
>  lib/lmb.c                     | 111 +++++++++++-----------------------
>  test/cmd/bdinfo.c             |   2 +-
>  test/lib/lmb.c                |  68 +++++++++++----------
>  13 files changed, 105 insertions(+), 137 deletions(-)
>
> --
> 2.45.2
>
