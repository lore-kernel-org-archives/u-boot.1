Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E1ECF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29799892B9;
	Thu, 19 Sep 2024 19:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aESNq109";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26132891F7; Thu, 19 Sep 2024 16:12:02 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A038089216
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso593016b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755118; x=1727359918; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gPW+Poi1FJhbuFAYgw5+8pjlGSE8C4GCCFye7URGxWo=;
 b=aESNq109x7xutP0f77cKsRFpmcoHz/73t0vZRkmTAT3MuwJvvHO5voO5AYpzmqUtfh
 GG25afinoXlW/VdV6nItVBoaghbY76cCbBKlM5JnQkXmGSjo5Rmqd4ZCdnQjo4J6S0xE
 opwh1xN3G1fluqJO3dGSpTH2GLCYH39W/4c4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755118; x=1727359918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gPW+Poi1FJhbuFAYgw5+8pjlGSE8C4GCCFye7URGxWo=;
 b=lx27C4UKntaMmOxeXmswSkLrR2/4vF5TJfST/sWflZEbUr4M/JJMNEhl/+e6WpNOiX
 H0Tgu0KFTXAyrmX6tPyxyru+mO4G+q14YVhc7jotr9yX2KRY0Oup1LMERIeQyJ/rLM5X
 /PkHpFeECSLx4K/i3uddE5Hd5kcsN1hm+JW9+9zki3zcUdLG/+pHdPF3bRrYCT6x/I8c
 9xBUUf754IHqDbH+LtB4etF/AezsyHa7BWBVai8yA8L1rrKquJSBGemEc6fleQX62lvr
 GbApKBw8mOm1GRuRaS57V1/yWF3wejhhUDLdoUA0cpM1q4Cm1f6KNvOVgdUSQZVY4MYO
 Iqxg==
X-Gm-Message-State: AOJu0Yz2rAiRJYwpB1JEVUTNqtODOLC/AbwrugeBjTSWae33YGViKxQF
 PV/iHsfpOBG5lEWGf8sTNJkEK8dIHS1ear2mOsIP+d3wB/gWHRlxmVhEDTQWtNr2baOixM6pvJ2
 dkXmoHN2nWcktkAHrc57PiwTFSsEVntlo5+U5
X-Google-Smtp-Source: AGHT+IFzaXSEILjm/X26Ji3RG2+Gx0cxw/6eDlu9UaaI8w3vqmLGc8JMwnbiz2ZUqkGe7OzeGc2xB2tZ9Kh0O5e4/6k=
X-Received: by 2002:a05:6a00:2287:b0:714:228d:e9f2 with SMTP id
 d2e1a72fcca58-7198e25e649mr5369428b3a.3.1726755117868; Thu, 19 Sep 2024
 07:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <58cd740a-da83-4ce2-91de-5fc228977e75@linaro.org>
In-Reply-To: <58cd740a-da83-4ce2-91de-5fc228977e75@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:44 +0200
Message-ID: <CAFLszTjQ7Xxsq9GXJs4+v87e4SU8M_nZwjAikVH2sw8ziVeaiQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] vbe: Series part E
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Chanho Park <chanho61.park@samsung.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Eddie James <eajames@linux.ibm.com>, 
 Gary Bisson <bisson.gary@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 19 Sep 2024 19:29:35 +0200
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

Hi Caleb,

On Fri, 30 Aug 2024 at 14:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 29/08/2024 15:57, Simon Glass wrote:
> >
> > This includes various patches towards implementing the VBE abrec
> > bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> > fatures are available in VPL.
>
> It would be helpful if you could include some context as to what VBE is,
> how this series fits in to previous ones, etc... If this is part of some
> overarching changes then having some common background justification /
> context which is copy-pasted to all the relevant patch series would make
> sense imo.

Yes, please see [1]. It is essentially an effort to replace UEFI with
something simpler, more efficient, better-specified and easier to
test.

Regards,
Simon

>
> Thanks and regards,
> >
> >
> > Simon Glass (19):
> >    image: Add a prototype for fit_image_get_phase()
> >    serial: ns16550: Allow clocks to be missing
> >    boot: Allow FIT to fall back from best-match option
> >    bootstd: Avoid sprintf() in SPL when creating bootdevs
> >    boot: Respect the load_op in fit_image_load()
> >    malloc: Show amount of used space when memory runs out
> >    malloc: Provide a simple malloc for VPL
> >    Support setting a maximum size for the VPL image
> >    spl: Report a loader failure
> >    spl: Allow serial to be disabled in any XPL phase
> >    spl: Support a relocated stack in any XPL phase
> >    spl: Drop use of uintptr_t
> >    spl: Drop a duplicate variable in boot_from_devices()
> >    spl: Add some more debugging to load_simple_fit()
> >    spl: lib: Allow for decompression in any SPL build
> >    boot: Allow use of FIT in TPL and VPL
> >    lib: Allow crc8 in TPL and VPL
> >    boot: Imply CRC8 with VBE
> >    hash: Plumb crc8 into the hash functions
> >
> >   boot/Kconfig                  | 71 ++++++++++++++++++++++++++++++++++-
> >   boot/Makefile                 |  4 +-
> >   boot/bootdev-uclass.c         | 10 ++++-
> >   boot/image-fit.c              | 29 ++++++++------
> >   common/hash.c                 |  8 ++++
> >   common/malloc_simple.c        |  3 +-
> >   common/spl/Kconfig.vpl        | 17 +++++++++
> >   common/spl/spl.c              | 15 +++++---
> >   common/spl/spl_atf.c          | 36 +++++++++---------
> >   common/spl/spl_fit.c          | 12 +++++-
> >   common/spl/spl_legacy.c       |  8 ++--
> >   configs/sandbox_vpl_defconfig |  3 +-
> >   drivers/serial/ns16550.c      |  2 +-
> >   include/image.h               | 16 +++++++-
> >   include/spl.h                 | 28 +++++++-------
> >   include/u-boot/crc.h          |  3 ++
> >   lib/Kconfig                   | 53 ++++++++++++++++++++++++++
> >   lib/Makefile                  |  8 ++--
> >   lib/crc8.c                    |  6 +++
> >   19 files changed, 263 insertions(+), 69 deletions(-)
> >
>
> --
> // Caleb (they/them)

[1] https://docs.u-boot.org/en/latest/develop/vbe.html
