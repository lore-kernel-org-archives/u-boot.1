Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48208C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 16:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 804368650A;
	Tue, 29 Aug 2023 18:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b+caQlI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C1D86516; Tue, 29 Aug 2023 18:47:17 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F4286504
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 18:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so6044558a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693327634; x=1693932434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HWVNMX7vd1WEG64vlkMHyu6kzBuXWTENo6ohVJELThc=;
 b=b+caQlI/401KPAPMU//z/Ht2t6hZHQ4IAWOwNM721F6UysEq/uoDeAdDdGHeCPFaHl
 6lW4SkF6cF3utkY7wSaM5pFGIwKgXgZGbzePoDELI8CnMt+6EHlPCeGvUkuZlMLzsd7T
 WGnIHDadDvAGC8pzhQftmU1vtMmHXxQebdChY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327634; x=1693932434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWVNMX7vd1WEG64vlkMHyu6kzBuXWTENo6ohVJELThc=;
 b=B/QK/5rLZGCQxkzCmSeBVYu1fKbKyfGHf66Hu+JTeVTcEj2Z2Je18gc/40fLJUFnuM
 uLeb7oBTlNqq0m1YjxmAFUjlfxlk7F3haDLuPe+arM4IrQTUb2/7v1MCJihzhSvW6mA1
 bMBnJLKHJQQdSqn/8ZT6IJbTZ/lYc0tkF73GX3QMGxYRt5ZbR6vP/foqMZmAEmfe0RHM
 VGNQpGSLGBhjHAoCaUkXqXkhv6wnFy+60VbYUMUR4Jg16e/2qdjSmZH05A3yWMJsdWuJ
 4JQUAR5Xf6xrMLRVNPVEvCbP6kJ3enajNzdoXzwt8Yfgg672XxWpnUdf3eVEO5l9SM0i
 4ZGw==
X-Gm-Message-State: AOJu0Yz4SEydhQqm3nxUHywAQig+DMuBOY0yMPBV8EmyWTRxd+HcNUNK
 34fXD90UenjYx1N88OGIcKziwymGmICsRNLdEaDy7Q==
X-Google-Smtp-Source: AGHT+IFB4LonKWnxzsaox1lVJIKNcCc9trneRXqOetw+ZOQIoApMVWm/htwuN4COX9WPAoU4iz7eq10akZkCfxlrwfs=
X-Received: by 2002:aa7:d3d2:0:b0:523:d715:b7b3 with SMTP id
 o18-20020aa7d3d2000000b00523d715b7b3mr19983465edr.41.1693327634028; Tue, 29
 Aug 2023 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <bba71d2b-09f9-6715-535e-da8275d22628@ti.com>
In-Reply-To: <bba71d2b-09f9-6715-535e-da8275d22628@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 10:47:02 -0600
Message-ID: <CAPnjgZ2ybVuAGngBjYcv9jY-=_AkAGvyWS3qW3VOJbxAiQ4pfg@mail.gmail.com>
Subject: Re: Config fragments
To: Andrew Davis <afd@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Andrew,

On Wed, 23 Aug 2023 at 10:44, Andrew Davis <afd@ti.com> wrote:
>
> On 8/23/23 10:30 AM, Simon Glass wrote:
> > Hi,
> >
> > Up until 2023.04 it has been possible to build all the defconfigs but
> > with 2023.07 that changed. Tom mentioned this to me recently.
> >
> > Up until 2023.04 we can enumerate all the board configs that can be
> > built. We can build any of them using a single name and a single
> > defconfig. The boards.cfg file which buildman creates contains a full
> > list of things that can be built.
> >
> >  From 2023.07 this changes and we now have random .config files
> > sprinkled about the place. I say random because they are not connected
> > to anything. For example, here is
> > board/ti/am62x/MAINTAINERS:
> >
> > AM62x BOARD
> > M: Dave Gerlach <d-gerlach@ti.com>
> > M: Tom Rini <trini@konsulko.com>
> > S: Maintained
> > F: board/ti/am62x/
> > F: include/configs/am62x_evm.h
> > F: configs/am62x_evm_r5_defconfig
> > F: configs/am62x_evm_a53_defconfig
> >
> > BEAGLEPLAY BOARD
> > M:     Nishanth Menon <nm@ti.com>
> > M:     Robert Nelson <robertcnelson@gmail.com>
> > M:     Tom Rini <trini@konsulko.com>
> > S:     Maintained
> > N:     beagleplay
> >
> > In most cases the MAINTAINERS file tells us about each board and until
> > [1] I had assumed that was the case. With that patch reverted, these
> > are the only 'orphaned' MAINTAINERS entries (buildman
> > --maintainer-check):
> >
> > WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> > ending at line 8
> > WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending at line 44
> > WARNING: orphaned defconfig in
> > board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> > WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at line 6
> > WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at line 15
> >
> > But Tom advised me that MAINTAINERS is not intended for this purpose,
> > so the check has been dropped. I am not suggesting we bring it back,
> > necessarily, but if we did, we could use it to specify the .config and
> > defconfig files which are used by each board.
> >
> > *Failing that*, I suggest a new 'name.brd' file in the board directory
> > to contain this information, e.g.
> >
> > # Contents of board/ti/am62x/beagleplay.brd:
> > beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> > beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> >
> > This could be parsed by buildman and other tools, to produce a list of
> > available boards and to build each using a single name (e.g. make
> > beagleplay-r5_defconfig)
> >
> > What do people think?
> >
>
> How about instead of needing this new 'name.brd' files, we look into
> "include" directives inside these configs? So we could have a file:
>
> beagleplay_r5_defconfig
>
> in the normal configs/ directory, but with the contents:
>
> #include "configs/am62x_evm_r5_defconfig"
>
> CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
> CONFIG_OF_LIST="k3-am625-beagleplay"
> ...
>
> The # is already a comment line so these should be safe
> for existing tools, and then we have in our Makefile
> an automatic pass through the C preprocessor.
>
> Some boards have can build with and without the fragments,
> so to have complete CI coverage, we have dummy defconfigs
> that have both the base and a fragment include:
>
> #include "configs/am62x_evm_r5_defconfig"
> #include "board/ti/am62x/high_security.config"
>
> Something like that, then as Heinrich mentioned, simply
> enumerating configs/*defconfig should yield all valid
> combinations for building/testing.

I do agree it would be nice to have this information in the file it
relates to. But wouldn't that involve changing kconf and other tools?
What tools will parse those files? We really want 'make xxx_defconfig'
to work for these new 'combined config' boards and my understanding is
that kconf is used here.

Your proposal certainly allows each 'combined config' to have a name -
it is just the filename of the defconfig file.

Any ideas?

Regards,
Simon
