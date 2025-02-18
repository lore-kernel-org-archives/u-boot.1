Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0DC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A7C80BA8;
	Tue, 18 Feb 2025 10:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U66iyKuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D147280BAD; Tue, 18 Feb 2025 10:38:32 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40D180079
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31656965e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739871510; x=1740476310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wmiJDv90JB3Qkq3VQmzW8+GiDvRsmzK1mbubOtI8qM=;
 b=U66iyKuFvZYqk6S41Xim/IvbDbAeuA7+zMQbzVavTV6W7dHhRwu1bbGbyWuxV4fuLL
 5WcuNT6K2oDVWZT/7XLrPFLGn2qyk9+oAhyEde59ck0b+Ab9LNzQUGb1cg/O5nB46qBA
 VTMLWb59TpNCUtDdFPr44q839wfcECWJrk3CUsv7ZRWYSHMumfnz9LufRgJFk14NSjGX
 SOooIoFdwX41y1Obt3bShD/0oAqwiVPB0TWDwTmU91eBxdhAUDJKAdLKEovNM4VHnNVe
 eQCCDG3Lyy6AfZ96EG9rpsm5p0YlpKQF/uMiYUDwmWoJ6KBfQuMPcv/Cp0BPaee8ZEuX
 6nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739871510; x=1740476310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wmiJDv90JB3Qkq3VQmzW8+GiDvRsmzK1mbubOtI8qM=;
 b=EtcZgbULgxBLOga2TMLsYp8GGUEeHX0lMQ62srzE+oqPGfK/iAm16fIl4vqifl6oul
 MSXUeuSZDbTyXYJdiVttx6sfyo5w55dCdlg7TINsmMkOfmrCrna8FpfwTOb+hjJZeMXp
 Z62fmLTLuWkSheEk7T3xFoHs6dIRSGXN3i2emQVZC20M8ZtMFT4Nl0/2Lpq8g8gbEcHT
 9ytxwkp6Nw7gi3qlQQsf6ztzS2AW0+D1o0nm0oYsa05jjDmmSRWaHf9/K7O4bdY3xpkY
 +Q7TWM/Skn0+EkzPSLd0TxjLSUEQ1/tHqt11DaZEiiMiN1GO/yCXvK6yOLEKOemuRCEE
 eREA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrg+BRuiD1yvuUKUMO7ePNzht5wvXNw9sLo0AVBz1ZCgRc+6Y+gnYuxeke7HOGAHoNkILVYOY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx59HxkjNCZk5iSVgFO2c7QgXaAwje60JOs0AudTEJ8TWhyAM28
 VHpWtBxC/sL4LCuv4B0RzzNi3+9+vJ2ie5ZUYYk+Wwg/savDk7pSa+5N3iLj4k4cZ+Jna/7l3Mv
 H+0/ioV2rWcGyIQXPLBfogtADIGQ=
X-Gm-Gg: ASbGnctOISQy3OR7TRtwJN1ORA5wh8XpDQj5n/+Am3UGGHp3/ehLzvlBoRDKW6qrvyC
 KLngL2lT7yghlCeNGF+iEq+JBfVJmuBRdpykcH1G4FNKHioKuo8JTRbqzfdsHOq+Cw0vlV3SSww
 ==
X-Google-Smtp-Source: AGHT+IFhaiSpIfoqRKtTYcCUaGqyrntMZj7rYvMapgNsxkuQ41ZhvtUWn0jP/9kVtUQi0m6vx1uRLP67an+BHRxA5P0=
X-Received: by 2002:a05:600c:1d22:b0:439:932c:e0d9 with SMTP id
 5b1f17b1804b1-439932ce481mr19712515e9.10.1739871509773; Tue, 18 Feb 2025
 01:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20250216181641.194424-1-clamor95@gmail.com>
 <20250216181641.194424-2-clamor95@gmail.com>
 <92bb6e6c-2bb4-46ac-ace8-466f48146c09@cherry.de>
 <CAPVz0n3yMh4O0_JfeL7EC_kcGFyOYV_2pMDs9fS3Xt29JYk24g@mail.gmail.com>
 <0ff42558-ef5b-43d6-868d-fbbeadcd198b@cherry.de>
In-Reply-To: <0ff42558-ef5b-43d6-868d-fbbeadcd198b@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 18 Feb 2025 11:38:18 +0200
X-Gm-Features: AWEUYZnF1Rf1tM3igvVb4dM2MC1PZIvIIBSgvmhcJD0Y_IUP-TQcR0fCDIUzVIg
Message-ID: <CAPVz0n0kdBy5-G5p+3jrXBDyd6At-Be+CNMxGZqFJpJ3X9deKQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] board: acer: picasso: add Acer Iconia Tab A500
 support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 u-boot@lists.denx.de
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

=D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 11:35 Quen=
tin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 2/18/25 8:12 AM, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 18:51 =
Quentin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hi Svyatoslav,
> >>
> >> On 2/16/25 7:16 PM, Svyatoslav Ryhel wrote:
> >>> The Acer Iconia A500 is a tablet computer designed, developed and
> >>> marketed by Acer Inc. It is powered by 1 GHz Nvidia Tegra 2 processor
> >>> and 1GB DDR2 RAM. The A500 is sold with 64 GB, although both 16 GB
> >>> and 32 GB models are available.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    arch/arm/dts/Makefile                      |   1 +
> >>>    arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 +++++++++++++++++=
++++
> >>>    arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
> >>>    board/acer/picasso/Kconfig                 |  12 +
> >>>    board/acer/picasso/MAINTAINERS             |   7 +
> >>>    board/acer/picasso/Makefile                |   9 +
> >>>    board/acer/picasso/picasso.c               |  57 +++
> >>>    board/acer/picasso/picasso.env             |  18 +
> >>>    configs/picasso_defconfig                  |  83 ++++
> >>>    doc/board/acer/index.rst                   |   9 +
> >>>    doc/board/acer/picasso.rst                 | 125 +++++
> >>>    doc/board/index.rst                        |   1 +
> >>>    include/configs/picasso.h                  |  23 +
> >>>    13 files changed, 858 insertions(+)
> >>>    create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
> >>>    create mode 100644 board/acer/picasso/Kconfig
> >>>    create mode 100644 board/acer/picasso/MAINTAINERS
> >>>    create mode 100644 board/acer/picasso/Makefile
> >>>    create mode 100644 board/acer/picasso/picasso.c
> >>>    create mode 100644 board/acer/picasso/picasso.env
> >>>    create mode 100644 configs/picasso_defconfig
> >>>    create mode 100644 doc/board/acer/index.rst
> >>>    create mode 100644 doc/board/acer/picasso.rst
> >>>    create mode 100644 include/configs/picasso.h
> >>>
> >>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> >>> index 0bf3697bdbe..acea0cc2ec1 100644
> >>> --- a/arch/arm/dts/Makefile
> >>> +++ b/arch/arm/dts/Makefile
> >>> @@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
> >>>        meson-a1-ad401.dtb
> >>>
> >>>    dtb-$(CONFIG_ARCH_TEGRA) +=3D \
> >>> +     tegra20-acer-a500-picasso.dtb \
> >>>        tegra20-asus-sl101.dtb \
> >>>        tegra20-asus-tf101.dtb \
> >>>        tegra20-asus-tf101g.dtb \
> >>> diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dt=
s/tegra20-acer-a500-picasso.dts
> >>> new file mode 100644
> >>> index 00000000000..0c301483180
> >>> --- /dev/null
> >>> +++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts
> >>
> >> Small drive-by comment.
> >>
> >> This is quite different from the Device Tree in the Linux kernel tree,
> >> and it hasn't been changed a lot in the last few years.
> >>
> >> 1) Is there any reason for not sync'ing with upstream Linux kernel
> >> instead of having our own Device Tree?
> >> 2) Do you think it'd be possible to use OF_UPSTREAM instead which woul=
d
> >> make it possible to use the device tree from the Linux kernel (it is
> >> available in dts/upstream/src/arm/nvidia/tegra20-acer-a500-picasso.dts=
)?
> >> I don't think it's a straightforward thing to do but haven't do it
> >> myself, so no clue what's required and the amount of effort to put int=
o
> >> it. The benefit is that fixes to the DT will eventually make it to
> >> U-Boot as well and we hopefully lower the maintenance burden on U-Boot
> >> contributors/maintainers.
> >>
> >> Cheers,
> >> Quentin
> >
> > Short answers yes and yes.
> >
> > Long answer:
> > 1. Using Linux Kernel device tree will result in at least total
> > failure of entire video subsystem since Linux gpu/drm changed
> > extremely quick. All devices I have submitted, including A500 heavily
> > relay on video output to be operated correctly (being a production
> > devices there is no exposed uart or any other output, besides the
> > panel). This is only at the first glance, there may be more under the
> > surface. At the same time, even if we switch to Linux device trees,
> > this will not remove need of *-u-boot.dts to adjust Linux tree to
> > U-Boot reality.
> >
>
> Yeah, most if not all our Rockchip-based boards have a -u-boot.dtsi to
> fix things up but mainly add binman nodes and add bootph properties
> (though those should be upstreamable to the kernel DTS, just that we're
> still struggling to get it right on the first try and kernel DTS updates
> really takes a long time for us to be merged in U-Boot.
>
> > 2. It is possible and it is even one of my current priorities.
> > Hopefully, by the fall I will be able to configure existing frameworks
> > and drivers to comply existing Linux trees. A small example, atm
> > U-Boot has no helpers to parse of_graph bindings, which are heavily
> > used by Linux to link video devices (that is expected since there is
> > not so much devices are using video output so no one bothered). This
> > makes most Linux bindings of video devices useless for U-Boot. Don't
> > assume that each or nearly each framework has such flows, they are
> > uncommon, but nonetheless they occur and destroy full picture.
>
> I think Qualcomm does have support for display in U-Boot as well, maybe
> there's something to be learned/adapted/shared with them as well.
>

Qualcomm does not initiate entire video pipe from scratch and does not
support use of u-boot as primary bootloader.

> In any case, good luck and have fun!
>
> Cheers,
> Quentin
