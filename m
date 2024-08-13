Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBD3C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3374886A7;
	Tue, 13 Aug 2024 15:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UwYbX7Ya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80154889B4; Tue, 13 Aug 2024 14:17:32 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0DA889B4
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso38845746d6.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551448; x=1724156248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O8/fiV3BPLtjiPwEPWXfUymeD18LjbHdBUpRyuEmM60=;
 b=UwYbX7Ya61vXJQGhzeqYhR8d4BOwpkTWAi9zABcD3bXQE7LfjpJLzGBlwK4DzJLL2c
 7MeNrqGA+95JQCmhDVdXx22CrPydCtQd1LN7iQLoLMSmT1w9qyYeRrj55/HYYizdkW1Z
 fIQSWZc1DDcvrdmMupChmf9i9UJSmFPruStz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551448; x=1724156248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8/fiV3BPLtjiPwEPWXfUymeD18LjbHdBUpRyuEmM60=;
 b=LHqOOqf1+7+C9iIThVffXUErMqvmlYTPRAE8X61cvg8enCeCDEIFTVkLGEn/8d4TeJ
 4go3vunoBeQr54VARQFSrcmckVAyC1/cNCHfbkpMwqXIAY5KHBnOD1fICP/iQKCINY6e
 Pn/v8W+aJJEPr7OwqfftN7+WTsme/CkHS1qVX7FW/HHzPuusyulNI1RnY+fWWtzmYLXO
 aMNYJQyCGftN14Sv0dSTUxTdRU/P2W9po0oNJAohEGh+RewFaNHeukrrjGaOzJrIropc
 /TBFdBzr0aBJh+sega2Dcoy3k3f9MbD+BWHNHyuxhxNLywPYBGMPyXKcMI/6B/ET03Id
 R/Lg==
X-Gm-Message-State: AOJu0YzpjDkIyUMjQfMiehb6DW+xR2jNJmNFbwGjGPj+/Pb6O49kyGN+
 JrjKEv7lewVKhgijBIP4YrNULIUIQhm4PbJuovJFT7fRJAor+wNrpsA9kD+aXtLadfcn0rJGRvV
 ziYOMpWfemVYjdq825Jim8UvZ+phOzFtwNagg
X-Google-Smtp-Source: AGHT+IHCxfmFUk6nynDaqf97/MkvV8HFJoKcCx9NPfXCUvqCSKULQrKqUZEZVrZlW7Kgnx3q5EZbc2JO959wfPuv2t0=
X-Received: by 2002:a05:6214:3d88:b0:6b5:d90d:ea3c with SMTP id
 6a1803df08f44-6bf4f79cf8cmr46057866d6.3.1723551448602; Tue, 13 Aug 2024
 05:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240807205032.3745680-1-sjg@chromium.org>
 <20240812165952.7d0da18d@donnerap.manchester.arm.com>
In-Reply-To: <20240812165952.7d0da18d@donnerap.manchester.arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:17:17 -0600
Message-ID: <CAFLszThv2wHzV6FStwb3qfrR+Qq82kdp7qynWC4=xsw5m-JVxg@mail.gmail.com>
Subject: Re: [PATCH 0/6] bootstd: sunxi: Migrate to standard boot
To: Andre Przywara <andre.przywara@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Eddie James <eajames@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janne Grunau <j@jannau.net>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Mikhail Kalashnikov <iuncuim@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Edwards <cfsworks@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 13 Aug 2024 15:22:56 +0200
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

Hi Andre,

On Mon, 12 Aug 2024 at 10:00, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Wed,  7 Aug 2024 14:50:26 -0600
> Simon Glass <sjg@chromium.org> wrote:
>
> Hey Simon,
>
> > This series attempts to migrate all sunxi boards to use standard boot,
> > along with a text environment.
>
> Ah, many thanks for that! I figured that we need a bootmeth for FEL, but
> never got around to have a closer look.
> On a coarse glance, this looks roughly OK, and doing a super quick boot
> test on one board, it seems to still work(TM), though the priority of the
> FEL boot is not right?

Does it need to be the top priority, perhaps?

> And I guess ditching the old kernel support might be a bit controversial.
> I think this is about the vendor kernels, which some people still rely on?

OK, perhaps it is. It might be a little tricky to handle it, but I
suspect another bootmeth might be enough.

>
> I will have a closer look this week and give you a review, just wanted to
> acknowledge the series and thank you for your efforts.

OK thank you.

Regards,
Simon


>
> Cheers,
> Andre
>
> > Simon Glass (6):
> >   sunxi: Drop BOOTCMD_SUNXI_COMPAT
> >   sunxi: Add a bootmeth for FEL
> >   sunxi: Move to bootstd
> >   sunxi: Drop old distro boot variables
> >   env: Provide a work-around for unquoting fdtfile
> >   sunxi: Move to text environment
> >
> >  Makefile                                      |   1 +
> >  arch/arm/Kconfig                              |   2 +-
> >  arch/arm/include/asm/arch-sunxi/clock_sun4i.h |  10 -
> >  arch/arm/mach-sunxi/Kconfig                   |  12 -
> >  arch/arm/mach-sunxi/dram_sun4i.c              |   4 -
> >  board/sunxi/sunxi.env                         | 138 ++++++++++
> >  boot/Kconfig                                  |  14 ++
> >  boot/Makefile                                 |   1 +
> >  boot/bootmeth_fel.c                           |  81 ++++++
> >  configs/icnova-a20-swac_defconfig             |   1 -
> >  doc/usage/environment.rst                     |  12 +
> >  include/configs/sunxi-common.h                | 238 ------------------
> >  12 files changed, 248 insertions(+), 266 deletions(-)
> >  create mode 100644 board/sunxi/sunxi.env
> >  create mode 100644 boot/bootmeth_fel.c
> >
>
