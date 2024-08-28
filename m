Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A24C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969F6889D2;
	Thu, 29 Aug 2024 00:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TgPqdPUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C174889D1; Thu, 29 Aug 2024 00:17:15 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C3C8862E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so11002276d6.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724883426; x=1725488226; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cBiGxGPlgc7Gd3Sxj1IEiXxIsm4OQtxebqsqGuSoAvo=;
 b=TgPqdPUv8yB8mvtIe7lt19soUjqWewvBC8gF457APmv5zu3dYcDwGvbv/+KQzTF+QI
 Oizwc/D+yrd9Q/IwEDBu1PuYltre8P8iSh9t0Rt2s3+h3xNtVYQngaJ9Jo31NThUvpAX
 TGautNBkIsBLnn4NuCJeldVuwj4qpV8XlBBR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724883426; x=1725488226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cBiGxGPlgc7Gd3Sxj1IEiXxIsm4OQtxebqsqGuSoAvo=;
 b=o7VPU8UcZA4cV0ZScS6kkQFRJFNfFWVZqZkySCtQhQc6ESSqfI/65VMcQARFmi0TbH
 e4/xnj5xSbxXggnhAw7IqCkxn1lccy5/4NL5+eKndekSpdPt6q8j9gxngeXYiw6R8g9/
 b5YEo6/0Rw3vBm3Eg72BikPwBhK5x+C+nZZ4XQuFRfuLUlpusYZmvKHjCZr60TuQebPG
 1Lr3YEbibPsvGzM1Hp/8G7tDB3yrycn853DluVQVtn3U7E5jRdgz5C2dIbPkTicmNvPi
 MxdAJN/2RrDR3+XofildJHo0qd9jfLQ4DYfkfPwspVJ/OkGfNCmDWsrSyFx5rC9FINH1
 W8Zg==
X-Gm-Message-State: AOJu0YzAHC+6oh8HN0NMwMuBm8h180DcXQUKuJRqd+xok4iiDROWXXXa
 uKAAUJDaQfQMcR7dbD5BUfX/aiu1c7vKG+HilhS+OX96m8+LLcZtP9W9dJr1HGtHftyDphNvbRV
 R99oTm8w5dlO1klQst4F82G7nc7rxWWXQ2sPk
X-Google-Smtp-Source: AGHT+IHrplIwR+/eznMDBMmzg2EJ8hzoJ8wq+Bg7ce1DHY2s8EbO+77UEJPLBbO7R1bq9QCkX8Jsv4OGkJYdBy9sARY=
X-Received: by 2002:a05:6214:23c8:b0:6b5:2be1:cd6e with SMTP id
 6a1803df08f44-6c33f32490bmr10664166d6.4.1724883426247; Wed, 28 Aug 2024
 15:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
In-Reply-To: <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 16:16:55 -0600
Message-ID: <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 huang lin <hl@rock-chips.com>
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

Hi Peter,

On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > This includes various patches towards implementing the VBE abrec
>
> What is abrec?

It's a VBE method which supports A, B and recovery images and permits
updating from SPL onwards. The idea is that you can safely update
without bricking a device.

>
> > bootmeth in U-Boot.
> >
> >
> > Simon Glass (18):
> >   sandbox: Add missing header file
> >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> >   gzip: Correct function comment for gunzip()
>
> Is this from upstream gzip code somewher?

I'm not sure, actually.

>
> >   fdtdec: Support separate BSS for all XPL builds

Needed so that VPL can use DDT

> >   tiny-printf: Correct return values

I can't remember, sorry.

> >   tpl: Support numbered aliases in device tree

The MMC needs to be accessed using its sequence number

> >   ram: Support driver model in TPL

That should say VPL...but again I'm not quite sure

> >   serial: Support debug UART in TPL

This allows debugging of the jump from TPL to VPL

> >   armv8: Support not having separate BSS

VPL doesn't want a separate BSS since SDRAM isn't available that early

> >   arm: cache: Drop a stale comment

Just something I noticed

> >   arm: Fix up a stale comment in sections.c

Another thing I noticed

> >   mmc: Support driver model in TPL

TPL needs to read VPL from MMC

> >   mmc: Add more debugging for SPL
> >   mmc: Log the error when init fails
> >   mmc: rockchip: Log some error returns
> >   mmc: rockchip: Allow clocks to be missing

These all help with debugging reading of VPL from the correct MMC device

> >   rockchip: mmc: Fix a missing colon

Just something I noticed

> >   rockchip: Provided SPL control over efuse presence

We don't want this driver in TPL or VPL

>
> I'm not sure what most of these patches have to do with VBE?

Basically there are a lot of little tweaks needed.

>
> >  arch/arm/cpu/armv8/u-boot-spl.lds   | 12 ++++++++++++
> >  arch/arm/lib/cache.c                |  2 --
> >  arch/arm/lib/sections.c             |  2 +-
> >  arch/sandbox/include/asm/sections.h |  1 +
> >  common/spl/spl_mmc.c                | 13 +++++++++++++
> >  drivers/core/Kconfig                |  8 ++++++++
> >  drivers/misc/Makefile               |  2 +-
> >  drivers/mmc/Kconfig                 | 12 ++++++++++++
> >  drivers/mmc/mmc.c                   |  2 +-
> >  drivers/mmc/rockchip_dw_mmc.c       | 10 ++++------
> >  drivers/mmc/rockchip_sdhci.c        | 11 +++++------
> >  drivers/ram/Kconfig                 |  9 +++++++++
> >  drivers/serial/Kconfig              |  7 +++++++
> >  include/bootdev.h                   |  8 ++++++++
> >  include/gzip.h                      |  6 ++++--
> >  lib/fdtdec.c                        |  2 +-
> >  lib/tiny-printf.c                   | 15 ++++++---------
> >  17 files changed, 93 insertions(+), 29 deletions(-)
> >
> > --
> > 2.34.1
> >

Regards,
SImon
