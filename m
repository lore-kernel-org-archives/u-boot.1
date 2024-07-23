Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C4DC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 04:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E143B88266;
	Tue, 23 Jul 2024 06:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmwV13Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77E3886E6; Tue, 23 Jul 2024 06:58:45 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D37B187D1A
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3cabac56b38so3230528b6e.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 21:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721710720; x=1722315520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otaCMEXUGR6FM+82Afkpz4R/n41GN+sA53rDGorlx9M=;
 b=gmwV13Lewith8L2qR2QniRygO/KJ4yccpyrQB4Ene80BIZQUDtGzdEF+2XSaj9UwIC
 F4TEB4+NSNXNYp5gsF+1hSu5dZIeH5MG/B9nXsKDPp7Ip+PlSt3DAtEGuyOFDOic6UiV
 P90IEVAB5KrQF0J1GBg9pj9urXy3ByDskeYMVf1Wm8zZwHbNRC5dd+TE72YGG1DC0KPD
 pbRA6fgF1XFwy8OtZcPbxY54pe3VYW+pJQ4S0E5hbvSwIPNOv/MphT1NinjpHTjeIZQf
 zGMXN6DjNMnq2HZF4svRqojFDHJXztwRF5vWm3eNx/pNyKX1DYYjKUJRtzkj+LTbIgEP
 +rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721710720; x=1722315520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otaCMEXUGR6FM+82Afkpz4R/n41GN+sA53rDGorlx9M=;
 b=oMpv2XXankKDHLsSJhNcWCGQmLH7Rd3ObDOfdqg2f2CbMz+eD7LYKqBeEiffTyBufI
 4q0QqRwc7sk1iPZcbPYTeKlFZFCYUw3LF7TpN6QKHTGERKzX4KsnqhLmo6lk8VVbp4/3
 GKtfx7m8rm6hhYgtbBErSrxz1nYqfyqB6bcNshWbOwfhM7pa6HUXtjykbRRSN6z/F/km
 RdEJbiry9nEcgxYuy/jT7mcfVAQ9109043tR5uFs/kt2KFXkBxCqNMIr7es7O72V0dA2
 Yd3cgFHmLqcx8EjRjMyq0h25k6FewJ4CLOPLVlWKeIv/5nh1qbV6kTd3yuOSWY7Px59Z
 5EOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvbvRXhAlCD/O/0JL+2VCOF0HJcJUC1cMA83QLMHcVSR8tM13WHzanbZyzVpVP5wgn+YrisSrR4zXzasNUXosxVDJjIA==
X-Gm-Message-State: AOJu0YxxApVadXkJeV2aXcHGY37GBTX1ns5YhmPDY/MUuL1b4+64CZtU
 nL+LkMUqMX3B+l2lb2S5BElrkBr4y1eG/VdslgNnh4bhk+KJ2PMzo8mKKmPZ/Q+N8rElXkJDzKc
 SK/4I5qqavm19L33EndmmrqUrZUE=
X-Google-Smtp-Source: AGHT+IFeqKuCCzRX2DJphiGBXmFTbiiGK8endU635T5ciIzKo1JVeJ+/KXsdBt5Bf5GB8Fw2mTSjxPGOEfvaIL9KKqA=
X-Received: by 2002:a05:6808:1443:b0:3d5:6413:2138 with SMTP id
 5614622812f47-3dafd0cffaamr2384851b6e.12.1721710720495; Mon, 22 Jul 2024
 21:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
 <CAPLW+4mAqpgWwiX4fvZFjWMWPtY9Mx11b9oPghzfpFoD8FU98A@mail.gmail.com>
In-Reply-To: <CAPLW+4mAqpgWwiX4fvZFjWMWPtY9Mx11b9oPghzfpFoD8FU98A@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 23 Jul 2024 13:58:29 +0900
Message-ID: <CALrBrZ1d-1Ytxtos9-NzDjNwyyY8T+aOqHU03+KDhJLdMYPt6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] arm: exynos: Enable TRNG for E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2024=EB=85=84 7=EC=9B=94 23=EC=9D=BC (=ED=99=94) 03:17, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Minkyu,
>
> Can you please take a look at this series? And also my MMC series [1]
> has been pending for a while now, if it's ok with you -- can you
> please apply it?
>
> Thanks!
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-July/559602.html
>
> On Mon, Jul 15, 2024 at 10:17=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > This series enables True Random Number Generator (TRNG) for E850-96
> > board. Here is a short breakdown of features implemented in this series=
:
> >
> >   1. Load LDFW (Loadable Firmware) on E850-96 board. It's needed to mak=
e
> >      TRNG SMC commands functional. To do so, add the default eMMC
> >      partition table and implement reading and applying LDFW in
> >      board_init().
> >   2. Add Exynos TRNG driver
> >   3. Enable Exynos TRNG driver on E850-96 board. It requires SSS clocks
> >      to be enabled, so add those clocks as well.
> >
> > With this series it's possible to generate random numbers in U-Boot
> > (e.g. using 'rng' command). The main reason for RNG enablement on
> > E850-96 board -- it's needed for EFI_RNG_PROTOCOL and kaslr, so it's on=
e
> > of the requirements to enable EFI boot support on E850-96 board, which
> > in turn is needed (among other things) for EBBR spec and SystemReady IR
> > certification. With this series it's also possible to use TRNG in Linux
> > kernel (which was recently added, see [1] for details), as Linux kernel
> > Exynos TRNG driver also relies on LDFW firmware to be loaded in the
> > bootloader.
> >
> > Changes in v2:
> >   - Addressed comments for [PATCH 4/5] rng: Add Exynos TRNG driver
> >
> > [1]
> https://lore.kernel.org/all/20240618003743.2975-1-semen.protsenko@linaro.=
org/T/#me6ba1762a254ca438a9715f011d32820babfe2d8
> >
> > Sam Protsenko (5):
> >   board: samsung: e850-96: Add default partitions
> >   board: samsung: e850-96: Load LDFW firmware on board init
> >   clk: exynos: Add SSS clocks for Exynos850
> >   rng: Add Exynos TRNG driver
> >   arm: exynos: Enable TRNG on E850-96 board
> >
> >  arch/arm/dts/exynos850-e850-96-u-boot.dtsi |  11 +
> >  arch/arm/mach-exynos/Kconfig               |   2 +
> >  board/samsung/e850-96/Makefile             |   4 +-
> >  board/samsung/e850-96/e850-96.c            |   6 +-
> >  board/samsung/e850-96/e850-96.env          |  26 ++
> >  board/samsung/e850-96/fw.c                 | 131 ++++++++++
> >  board/samsung/e850-96/fw.h                 |  12 +
> >  configs/e850-96_defconfig                  |   1 +
> >  drivers/clk/exynos/clk-exynos850.c         |  10 +
> >  drivers/rng/Kconfig                        |  13 +
> >  drivers/rng/Makefile                       |   1 +
> >  drivers/rng/exynos-trng.c                  | 291 +++++++++++++++++++++
> >  12 files changed, 504 insertions(+), 4 deletions(-)
> >  create mode 100644 board/samsung/e850-96/e850-96.env
> >  create mode 100644 board/samsung/e850-96/fw.c
> >  create mode 100644 board/samsung/e850-96/fw.h
> >  create mode 100644 drivers/rng/exynos-trng.c
> >
> > --
> > 2.39.2
> >


Your patch was failed to apply to u-boot-samsung due to the
e850-96_defconfig.
please rebase the patch.

and about mmc patches, those have delegated to mmc maintainers.

Thanks,
Minkyu Kang.
