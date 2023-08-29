Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77DDC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 19:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43AB86504;
	Tue, 29 Aug 2023 21:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OhCXH0uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57ABF86507; Tue, 29 Aug 2023 21:11:23 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A75A83F7F
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52a5c0d949eso4210511a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693336280; x=1693941080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/5XX1vUl8ankIBW9dxNgHIsOZxAyECvRrXJ70TUjcww=;
 b=OhCXH0uQnL/sMsegEN95FACzuzRIvg10iF67Tq82w9BrbaaS6Zhu6JanmL6478RkEo
 zJEDo+dqk+p+tAcsyeGsUtIsUL3hHCtgdQD1PEuuE2rZ+47H68QofZxZAuHvJm8msvnp
 /xbBi/l+OjYekI4GHtmXfOjmFV+ETD7+8Yhx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336280; x=1693941080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/5XX1vUl8ankIBW9dxNgHIsOZxAyECvRrXJ70TUjcww=;
 b=JMDnwgrAKkYKKtmxDDz7F0qwcCVrfEsQvozEPMSW/1fQ9+hKJ/5ep1bUrXnGqHReAT
 ZrWGkV7XlPuURsALVcfe8nzzJzXuKyLN37ZFREQY0IWW44LWl5lIsflg5acubRDXI7GJ
 3YKifdHt7STgDQAAxU95BGX1LfU9wKSNc+MYMN5L6e1oyFKsTwS6S5dQ1RhahowAERNl
 FMz6o4eYi2MBWsATQfe/TamJ9i8bBSN2NRACqs6K7nZ3/stvJRDl9pP70GzcUJPb0LyZ
 eI+Ru5KZmlRzDt/ZPhb4eerjPTgqe2mf/DR76Q9xxVckwtq5JsN9VngEpTs/vAA8C7zf
 zxXA==
X-Gm-Message-State: AOJu0YwUNY7FKT9lqSLh/Z/B49BZmPF8P3LE8pGItnWIq1kBtLd0qdSL
 LsixoNvoqK8InHusuy/bTUJ4OmxyGqJ9k8fT0RgW1g==
X-Google-Smtp-Source: AGHT+IGvYq69aIywQGmfMmaLdDlAdAGkkg3NFlwgYE8Qrbhh/PLItiy1Tgg+t9QKN3wAd8Pb11SfAV9TXQlAy5ohtr4=
X-Received: by 2002:a05:6402:383:b0:523:b37e:b83d with SMTP id
 o3-20020a056402038300b00523b37eb83dmr134486edv.41.1693336279640; Tue, 29 Aug
 2023 12:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <bba71d2b-09f9-6715-535e-da8275d22628@ti.com>
 <CAPnjgZ2ybVuAGngBjYcv9jY-=_AkAGvyWS3qW3VOJbxAiQ4pfg@mail.gmail.com>
 <6b9d747c-001a-d6e5-e18b-ab073fab6c13@ti.com>
In-Reply-To: <6b9d747c-001a-d6e5-e18b-ab073fab6c13@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 13:11:08 -0600
Message-ID: <CAPnjgZ3FUYU97g_9G4pxPcOU5dUqJ519hwJkQg6TgRfgc_+W=A@mail.gmail.com>
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

On Tue, 29 Aug 2023 at 11:05, Andrew Davis <afd@ti.com> wrote:
>
> On 8/29/23 11:47 AM, Simon Glass wrote:
> > Hi Andrew,
> >
> > On Wed, 23 Aug 2023 at 10:44, Andrew Davis <afd@ti.com> wrote:
> >>
> >> On 8/23/23 10:30 AM, Simon Glass wrote:
> >>> Hi,
> >>>
> >>> Up until 2023.04 it has been possible to build all the defconfigs but
> >>> with 2023.07 that changed. Tom mentioned this to me recently.
> >>>
> >>> Up until 2023.04 we can enumerate all the board configs that can be
> >>> built. We can build any of them using a single name and a single
> >>> defconfig. The boards.cfg file which buildman creates contains a full
> >>> list of things that can be built.
> >>>
> >>>   From 2023.07 this changes and we now have random .config files
> >>> sprinkled about the place. I say random because they are not connected
> >>> to anything. For example, here is
> >>> board/ti/am62x/MAINTAINERS:
> >>>
> >>> AM62x BOARD
> >>> M: Dave Gerlach <d-gerlach@ti.com>
> >>> M: Tom Rini <trini@konsulko.com>
> >>> S: Maintained
> >>> F: board/ti/am62x/
> >>> F: include/configs/am62x_evm.h
> >>> F: configs/am62x_evm_r5_defconfig
> >>> F: configs/am62x_evm_a53_defconfig
> >>>
> >>> BEAGLEPLAY BOARD
> >>> M:     Nishanth Menon <nm@ti.com>
> >>> M:     Robert Nelson <robertcnelson@gmail.com>
> >>> M:     Tom Rini <trini@konsulko.com>
> >>> S:     Maintained
> >>> N:     beagleplay
> >>>
> >>> In most cases the MAINTAINERS file tells us about each board and until
> >>> [1] I had assumed that was the case. With that patch reverted, these
> >>> are the only 'orphaned' MAINTAINERS entries (buildman
> >>> --maintainer-check):
> >>>
> >>> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> >>> ending at line 8
> >>> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending at line 44
> >>> WARNING: orphaned defconfig in
> >>> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> >>> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at line 6
> >>> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at line 15
> >>>
> >>> But Tom advised me that MAINTAINERS is not intended for this purpose,
> >>> so the check has been dropped. I am not suggesting we bring it back,
> >>> necessarily, but if we did, we could use it to specify the .config and
> >>> defconfig files which are used by each board.
> >>>
> >>> *Failing that*, I suggest a new 'name.brd' file in the board directory
> >>> to contain this information, e.g.
> >>>
> >>> # Contents of board/ti/am62x/beagleplay.brd:
> >>> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> >>> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> >>>
> >>> This could be parsed by buildman and other tools, to produce a list of
> >>> available boards and to build each using a single name (e.g. make
> >>> beagleplay-r5_defconfig)
> >>>
> >>> What do people think?
> >>>
> >>
> >> How about instead of needing this new 'name.brd' files, we look into
> >> "include" directives inside these configs? So we could have a file:
> >>
> >> beagleplay_r5_defconfig
> >>
> >> in the normal configs/ directory, but with the contents:
> >>
> >> #include "configs/am62x_evm_r5_defconfig"
> >>
> >> CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
> >> CONFIG_OF_LIST="k3-am625-beagleplay"
> >> ...
> >>
> >> The # is already a comment line so these should be safe
> >> for existing tools, and then we have in our Makefile
> >> an automatic pass through the C preprocessor.
> >>
> >> Some boards have can build with and without the fragments,
> >> so to have complete CI coverage, we have dummy defconfigs
> >> that have both the base and a fragment include:
> >>
> >> #include "configs/am62x_evm_r5_defconfig"
> >> #include "board/ti/am62x/high_security.config"
> >>
> >> Something like that, then as Heinrich mentioned, simply
> >> enumerating configs/*defconfig should yield all valid
> >> combinations for building/testing.
> >
> > I do agree it would be nice to have this information in the file it
> > relates to. But wouldn't that involve changing kconf and other tools?
> > What tools will parse those files? We really want 'make xxx_defconfig'
> > to work for these new 'combined config' boards and my understanding is
> > that kconf is used here.
>
> The U-Boot Makefile passes the provided xxx_defconfig into the kconfig
> scripts. All I'm suggesting is to have that Makefile run the passed
> in defconfig through the C preprocessor before handing it off to kconfig.

Could you take a look to see how hard that would be?

>
> For existing defconfigs the preprocessor will make no changes to the file.
> For the config fragments, the `#include` lines will be substituted with the
> contents, the result will be a normal defconfig file that can then also be
> passed into kconfig.

OK

>
> No changes to kconfig scripts, or anything other than the Makefile, are needed.
>
> >
> > Your proposal certainly allows each 'combined config' to have a name -
> > it is just the filename of the defconfig file.
> >
>
> Exactly, this keeps all current CI tooling/flows the exact same.

Indeed.

Regards,
SImon
