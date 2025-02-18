Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D7C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057258043C;
	Tue, 18 Feb 2025 08:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9oW2Pvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884D380737; Tue, 18 Feb 2025 08:12:31 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7C5800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so34705235e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739862748; x=1740467548; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VexGcNmsy805M2OcX8NDlngNDKIajxD12B/zoUQznE=;
 b=Z9oW2PvvzSgxI+1CDf7AH4/J9bKZrgT56O8RYFuwnLG8uEPf34GMsOh3km64d1afjg
 5Ynx/q47zEYKV/bkbrCr09bbwsUGeTgSpZOUmbafx22Oy3YAiCj7+PHZc+wFIn61H3yi
 1A0rNN8OAg0qBVuhmLO5kgqleAJc/F30uH2Uiryzypea3rOhQBjiwdFU7S7LD0j6YXSo
 AJa+AR7HfKmy8mSsw70XzWpxu2eIHnCf+BB94dAVwWA7i8Av0mw6y4o4OUWezuPh9FaL
 t15wgaXAU7PsAhwSKKa9+S5pn687YeO1xhgXEnMp6b+De4e67bJ7QZwwct9A8U+QZIbg
 HEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739862748; x=1740467548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VexGcNmsy805M2OcX8NDlngNDKIajxD12B/zoUQznE=;
 b=Qw1y5EcYkoN9od+cj1jQ2DPaoZLGjPsAY1Ej2xWAylrUVxQggkQMa8zP9pOjnxchM7
 E7RGvF1tsdUejShLZeRq3OQojWD5RfwjpQ9aXC2guPUTix4UZ0QZLvUXL7v9jbq0JNDE
 4cCR1sXgQ3g/HQp9pO6mMCe3dpgYya0jYoaPr4NB1Kali2yeeW8EvKx5DFYwL5ZV1Nqc
 l7znEa2e3Fx6K5FmWgM2S5aKT934E8igudvovHM5hYUQwskHoXYuk5tN76wiQK0EiJ7L
 4sbsqpOEKEHGsDTLfPwRAPe9e34GswD60DKyDqAOb+3Zha/DgU/yf1uxcJrsvGm3oeHy
 bkAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXS5/vmKvCz5AWT9Z3wgaH9YDLoj20rwmEzdMXONN3M1AFyDETSb+2Uw09esxrhDVs4jWXB6w=@lists.denx.de
X-Gm-Message-State: AOJu0YxCaf9R8kGtUanThZl74iLNvTySXO7T5FV5pbPRAj0ZckBo7Y1s
 ZRE7IMn4nqtuDXFdUi/IZesH8MLhW+8ePiHvWqgTi9Uyf5aw+eCXhoZEciaLnWNsOWW+TIbOZg4
 a038ICeKkRsSV/2tlQkYGyBmRms5lHw==
X-Gm-Gg: ASbGnctnJ5wyL/ANDGS6GL5diGmsZKNufzejudOf0tEamvXGQ6xN/NC773SIb1phTtv
 zn5ZWscKD+VaBEfMh9i9q2BVT/5p+39GqqhsggPX2hyO/xBtGUkVo+llMYqLRmZlxS+7CQnPACw
 ==
X-Google-Smtp-Source: AGHT+IG9RHv47st3LNxNeR290Uai7NX8sxpE/ACzBC2dyqX6/bQd3SpgLm8DFPwNjF8coPkDZLsh/IqP1waIGPyHAuo=
X-Received: by 2002:a05:600c:1d23:b0:439:68b0:ed7b with SMTP id
 5b1f17b1804b1-4396e6dd379mr108541005e9.12.1739862748358; Mon, 17 Feb 2025
 23:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20250216181641.194424-1-clamor95@gmail.com>
 <20250216181641.194424-2-clamor95@gmail.com>
 <92bb6e6c-2bb4-46ac-ace8-466f48146c09@cherry.de>
In-Reply-To: <92bb6e6c-2bb4-46ac-ace8-466f48146c09@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 18 Feb 2025 09:12:17 +0200
X-Gm-Features: AWEUYZmMaed-uTn9KGUoTbRDqaZI1QSED_wMsI4l1X4paZSQvO-i7OPgN-8thv4
Message-ID: <CAPVz0n3yMh4O0_JfeL7EC_kcGFyOYV_2pMDs9fS3Xt29JYk24g@mail.gmail.com>
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

=D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 18:51 Quen=
tin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 2/16/25 7:16 PM, Svyatoslav Ryhel wrote:
> > The Acer Iconia A500 is a tablet computer designed, developed and
> > marketed by Acer Inc. It is powered by 1 GHz Nvidia Tegra 2 processor
> > and 1GB DDR2 RAM. The A500 is sold with 64 GB, although both 16 GB
> > and 32 GB models are available.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   arch/arm/dts/Makefile                      |   1 +
> >   arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 ++++++++++++++++++++=
+
> >   arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
> >   board/acer/picasso/Kconfig                 |  12 +
> >   board/acer/picasso/MAINTAINERS             |   7 +
> >   board/acer/picasso/Makefile                |   9 +
> >   board/acer/picasso/picasso.c               |  57 +++
> >   board/acer/picasso/picasso.env             |  18 +
> >   configs/picasso_defconfig                  |  83 ++++
> >   doc/board/acer/index.rst                   |   9 +
> >   doc/board/acer/picasso.rst                 | 125 +++++
> >   doc/board/index.rst                        |   1 +
> >   include/configs/picasso.h                  |  23 +
> >   13 files changed, 858 insertions(+)
> >   create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
> >   create mode 100644 board/acer/picasso/Kconfig
> >   create mode 100644 board/acer/picasso/MAINTAINERS
> >   create mode 100644 board/acer/picasso/Makefile
> >   create mode 100644 board/acer/picasso/picasso.c
> >   create mode 100644 board/acer/picasso/picasso.env
> >   create mode 100644 configs/picasso_defconfig
> >   create mode 100644 doc/board/acer/index.rst
> >   create mode 100644 doc/board/acer/picasso.rst
> >   create mode 100644 include/configs/picasso.h
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 0bf3697bdbe..acea0cc2ec1 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
> >       meson-a1-ad401.dtb
> >
> >   dtb-$(CONFIG_ARCH_TEGRA) +=3D \
> > +     tegra20-acer-a500-picasso.dtb \
> >       tegra20-asus-sl101.dtb \
> >       tegra20-asus-tf101.dtb \
> >       tegra20-asus-tf101g.dtb \
> > diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dts/=
tegra20-acer-a500-picasso.dts
> > new file mode 100644
> > index 00000000000..0c301483180
> > --- /dev/null
> > +++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts
>
> Small drive-by comment.
>
> This is quite different from the Device Tree in the Linux kernel tree,
> and it hasn't been changed a lot in the last few years.
>
> 1) Is there any reason for not sync'ing with upstream Linux kernel
> instead of having our own Device Tree?
> 2) Do you think it'd be possible to use OF_UPSTREAM instead which would
> make it possible to use the device tree from the Linux kernel (it is
> available in dts/upstream/src/arm/nvidia/tegra20-acer-a500-picasso.dts)?
> I don't think it's a straightforward thing to do but haven't do it
> myself, so no clue what's required and the amount of effort to put into
> it. The benefit is that fixes to the DT will eventually make it to
> U-Boot as well and we hopefully lower the maintenance burden on U-Boot
> contributors/maintainers.
>
> Cheers,
> Quentin

Short answers yes and yes.

Long answer:
1. Using Linux Kernel device tree will result in at least total
failure of entire video subsystem since Linux gpu/drm changed
extremely quick. All devices I have submitted, including A500 heavily
relay on video output to be operated correctly (being a production
devices there is no exposed uart or any other output, besides the
panel). This is only at the first glance, there may be more under the
surface. At the same time, even if we switch to Linux device trees,
this will not remove need of *-u-boot.dts to adjust Linux tree to
U-Boot reality.

2. It is possible and it is even one of my current priorities.
Hopefully, by the fall I will be able to configure existing frameworks
and drivers to comply existing Linux trees. A small example, atm
U-Boot has no helpers to parse of_graph bindings, which are heavily
used by Linux to link video devices (that is expected since there is
not so much devices are using video output so no one bothered). This
makes most Linux bindings of video devices useless for U-Boot. Don't
assume that each or nearly each framework has such flows, they are
uncommon, but nonetheless they occur and destroy full picture.
