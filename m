Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F7DC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13BE86C39;
	Mon, 15 Jan 2024 10:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pEnluQhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788EA86DD1; Mon, 15 Jan 2024 10:43:13 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC01865D0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so5728508276.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705311788; x=1705916588;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAN0la30p3o6NMK4MIGgfOGmkOMGokZLvBtrNkzyBvQ=;
 b=pEnluQhGRTbW2JOvlAvy0PyPZweVF+HFUdfYQkWC4tHsEQIPuEbd3uHqZ85iQ8Ap/3
 rjuqy4szxmEMtRpV/YjtkHRYjKcFYc2eBClkl+ziDw/GeA9taiUFYZ8l8Aerqp6hy7mc
 /inxPEAL+SA8gdIGaR4o/a93OriqtadC27JW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705311788; x=1705916588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAN0la30p3o6NMK4MIGgfOGmkOMGokZLvBtrNkzyBvQ=;
 b=d59o4dHnlB/rzHEoWdHNJc88QSEBim8NSMll7GaucedhB+RYPy2dhtQcxvVMOlPZmr
 UO2I71nndMhhGImWc6EDsACxR5bYB+Su2cIqbkwaZwCwFx4ZH1YJa/fN9JKMycsNrYmq
 VFkJHoUJFSF3R5yw60g+TedH3rgapgnQbskRlNKHDSRZqpzCh+apiZtOLiMbH3sT16k2
 KDxexkjxPh/JHNqrp8yW2jixf5Gr1miw2qUg1JpuKax2zjiFxH9TiWkxVfEFocLqSki0
 yx0r59gTIjBibQ3EdvqzcMDDyIiqUc3BnFc7RjJ0R0PiNdcjuVpYpGtXEpAOOMyV2WvO
 nl0w==
X-Gm-Message-State: AOJu0YykzDD2zZxR5s2QFd6LbMfWpXkKG8hABtPeJelhEfiywGDCYqzS
 lUGU0u4MOMZ9Y2jBrw7vbTNQO1OR50WV9K78YOFjq/RiAhR+Zw==
X-Google-Smtp-Source: AGHT+IFnRezFJCIeUfDSTMGYgot67GhIx5SOxoxyzZoreCn9b42+vvhI8WkKgKB1e75ctpJwl/waBvcHpshMqngSvh0=
X-Received: by 2002:a05:6902:2748:b0:dbd:74e4:9a39 with SMTP id
 ea8-20020a056902274800b00dbd74e49a39mr1914305ybb.118.1705311788258; Mon, 15
 Jan 2024 01:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20240111131920.73691-1-rogerq@kernel.org>
In-Reply-To: <20240111131920.73691-1-rogerq@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 15 Jan 2024 10:42:57 +0100
Message-ID: <CABGWkvqMCV1WxtZkA+_rh0nrRHSJpSqbxLqTodCCzBF1FZ+zBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mtd: omap_gpmc: Fix GPMC & NAND drivers
To: Roger Quadros <rogerq@kernel.org>
Cc: trini@konsulko.com, michael@amarulasolutions.com, vigneshr@ti.com, 
 nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com, u-boot@lists.denx.de
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

On Thu, Jan 11, 2024 at 2:19=E2=80=AFPM Roger Quadros <rogerq@kernel.org> w=
rote:
>
> Hi,
>
> When testing the driver with K3 platform, build and functional
> issues were found in the ti-gpmc and omap_gpmc NAND driver.
> Fix those.
>
> cheers,
> -roger
>
> Changelog:
>
> v2:
> - Added "mtd: rawnand: omap_gpmc: fix OF based partition parsing for NAND=
".
> - Dropped defconfig patch.
>
> CI test results: https://github.com/u-boot/u-boot/pull/467
>
> v1:
> https://lore.kernel.org/all/20240109122605.51951-1-rogerq@kernel.org/
>
> Roger Quadros (4):
>   memory: ti-gpmc: Fix build
>   mtd: rawnand: omap_gpmc: Use DT provided IO address
>   mtd: rawnand: omap_gpmc: fix OF based partition parsing for NAND
>   arm: mach-k3: am642: Define NAND boot device
>
>  arch/arm/mach-k3/am642_init.c            |  3 +++
>  arch/arm/mach-k3/include/mach/am64_spl.h |  1 +
>  drivers/memory/ti-gpmc.c                 |  2 +-
>  drivers/mtd/nand/raw/omap_gpmc.c         | 21 ++++++++++++++++-----
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
>
> base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
> prerequisite-patch-id: e0465f3e924302d1c4bd47f2129b4eb3bd9faead
> --
> 2.34.1
>

Applied to nand-next,

Thanks and regards,
Dario
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
