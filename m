Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA8AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247C787D50;
	Fri, 12 Apr 2024 04:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="aIOb6lEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB9687F77; Fri, 12 Apr 2024 02:17:28 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE6688202
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-615826815c2so4039807b3.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 17:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712881043; x=1713485843;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgSk2LGp9Yh1NmosBObud2s96yHPot0gkCkW0QcA0sA=;
 b=aIOb6lEIe2q4oBDMnD/G+Ag/iXSJAK33Qe5eAej9a9D5H5PFgICvx5jJVegyJthRcp
 e14LWfhQpwNvlPSTIhcapyYtRc8zQy+Riyn22hHTPKnEvt9jKckCjZtUznRgIKj8QUWh
 8hT2ofqj6yBg+rXRjuX/xcdF1bGrFrVpnwKwOC/Os3LdA61FDv1Z0IpvslqsLmSQgFlV
 EGnAhBVj8ROJIYLbp+x5autZh7krCAeO6w4HENI7RQLM8xq+ryZSq2DyaJljdmfU0tDC
 KL/o86+kdogz4dvuwL70TbfXwO5d0POfWxMY1lHq0t6iuhVLU8lummpYt9e5mWbhvmpl
 SjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712881043; x=1713485843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgSk2LGp9Yh1NmosBObud2s96yHPot0gkCkW0QcA0sA=;
 b=rCHSBKrZVQFDfvqSE+sEITt894b/UToOgkSvQA60aE4xucMNFH43nBu9ESilRlKXXf
 /3hs8b//hDCW/Y/tLbNF+MZS7LhHH+neQPoj6Q5ATv5uMkhsRnEq0lxIGfwwEVlUIJ/S
 7ZHs9w3ZwvlMQkA7G6+zDA2jw6MPhgZzuOyBfgB/3VjdLU5x087J9agYmJLPcFcHc/xF
 Vc6080Ej9JovVzusiE6x3OuPczTL5rzlJpqQszSrp70Y5Y1YdLmzJvW6I4cYWKk9dGqt
 DntqNl3GQOjK9DfrmVPmwD7S+jdJ9jjQnomuvcVm9GQnCkYN5MCZK6ClFKd4UYwZhOvg
 qPfQ==
X-Gm-Message-State: AOJu0YypEoAGTdudoIREEPIs1iigfEKgQ11Apjj0yzPnSNnMC+vNj3H5
 PRQK/gj4N43Lm0in4chSezsRFHfbOlDZFz3EgjzujHnxQCnNvND7GNk4vj3yh52lQbh9cDW0nB7
 P3NXJdMWwIuFq3P2o/lijUHMiPSavPIwLf2Jf
X-Google-Smtp-Source: AGHT+IEaeCGT4OUVd+s82W9E33PBp5QicW1kN2fyx/7xjyzd+PLde0e8cyVtCIdFMIAeLqrI0paXaSuvRoHta0ij2uA=
X-Received: by 2002:a05:690c:ed4:b0:611:2a8b:1a40 with SMTP id
 cs20-20020a05690c0ed400b006112a8b1a40mr1229709ywb.33.1712881043233; Thu, 11
 Apr 2024 17:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240411234021.14534-1-greg.malysa@timesys.com>
 <20240411234021.14534-2-greg.malysa@timesys.com>
 <20240411235827.GL2493117@bill-the-cat>
In-Reply-To: <20240411235827.GL2493117@bill-the-cat>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Thu, 11 Apr 2024 20:17:01 -0400
Message-ID: <CAAjXUapCMdiPxWpfo34oz+bpnn48Kib-Cb=Hh0gXFpVG2xxpYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arch: arm: Add Analog Devices SC5xx machine type
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Matthew McClintock <Matthew.Mcclintock@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Scott McNutt <smcnutt@psyent.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Thomas Chou <thomas@wytron.com.tw>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Apr 2024 04:08:44 +0200
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

Hi Tom,

Thanks for the quick feedback. I'll go through our patches and review
the #include usage as part of preparing for v2, and we'll work out
switching to the plain text environment as well. I'll drop the custom
compiler options and make sure we weren't actually relying on
them--possibly it was just necessary for the initial set of init code
we started with. I believe we're not using the mach type constants
anywhere so that will be straightforward to drop as well.

Thanks,
Greg

On Thu, Apr 11, 2024 at 7:58=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Apr 11, 2024 at 07:37:28PM -0400, Greg Malysa wrote:
>
> > From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> >
> > Add support for the SC5xx machine type from Analog Devices. This
> > includes support for the SC57x, SC58x, SC59x, and SC59x-64 SoCs, which
> > have many common features such as common ADI IP blocks, and SHARC DSP
> > cores. This commit introduces core functionality required for all board=
s
> > using an SC5xx SoC, such as:
> >
> > - SPL configuration
> > - Required CPU hooks such as reset
> > - Boot ROM interaction to load the stage 2 bootloader in the reference
> >   configuration. Other options are possible but not officially supporte=
d
> >   at this time
> > - SoC-common configuration expected to be reused by all boards
> > - Early initialization for system clocks and DDR controller
> >
> > Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
> > Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> > Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> > Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> > Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> > Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> > Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> >
> > ---
> >
> >
> > ---
> >  MAINTAINERS                                  |  13 +
> >  arch/arm/Kconfig                             |   6 +
> >  arch/arm/Makefile                            |   1 +
> >  arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  | 115 +++
> >  arch/arm/include/asm/arch-adi/sc5xx/soc.h    |  18 +
> >  arch/arm/include/asm/arch-adi/sc5xx/spl.h    |  41 +
> >  arch/arm/include/asm/mach-types.h            |   4 +
>
> We shouldn't be adding more to mach-types.h.
>
> >  arch/arm/mach-sc5xx/Kconfig                  | 464 +++++++++
>
> Here and elsewhere I think I saw whitespace issues (help should be
> <TAB><space><space>) in the entries, along with adding "default n" for
> new options, and that's not needed as n is the default.
>
> [snip]
> > diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config=
.mk
> > new file mode 100644
> > index 0000000000..b80644d6dc
> > --- /dev/null
> > +++ b/arch/arm/mach-sc5xx/config.mk
> [snip]
> > +ifndef CONFIG_SC59X_64
> > +     # Select the Analog Devices processor.
> > +     PLATFORM_RELFLAGS +=3D -fno-stack-protector -std=3Dgnu89
> > +endif
>
> We should be using the defaults here.
>
> Also:
> - Please switch to plain text environment instead of defining in board.h
>   and so on.
> - Audit your #include usage, I saw more <config.h> that is likely needed
>   for example.
>
> --
> Tom



--=20
Greg Malysa
Timesys Corporation
