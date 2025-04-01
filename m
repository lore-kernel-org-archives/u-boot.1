Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D23EC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FA282047;
	Tue,  1 Apr 2025 15:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XtEfj+uH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EED82040; Tue,  1 Apr 2025 15:49:05 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756B280584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so37390455e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743515342; x=1744120142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHTboLpAQca7cdWYd36y115pCgMrEmQV9eillq/I8ec=;
 b=XtEfj+uHCzEjKvwlzdXh0GBDK6H9DgYL4tqDnPQj9a8T0g0Bii/XVmf7lviLjPskHF
 xKsIkLq7Ij9dmZBLqh6ijXzei19UkxnLt9BjxgqKsNjTn5m3jbS5zlmo7eDzjkKmYFqU
 LkWcoc8AgaS+rjNAL+gtmBk6atGMgFsYZ2SZdFJBIv0c7AjOjLJq6DPnGHBGkOkYaulH
 J/oMS0Nwa91dNeh/asw8/JVCneTttCUEMoYfam/4ve5jxcscvYt7WaOoLdwuKtW7VUfN
 fFref9YDwbl8k/vgPQ7Lkrjq9nOvHS++o0Bf6Za0jGwN2S104A43YJB4UPmA9L3Koulw
 Tg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743515342; x=1744120142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHTboLpAQca7cdWYd36y115pCgMrEmQV9eillq/I8ec=;
 b=HlEpTrtFDNaEWb3NvArZZqTT6D4qnoZfPxs3u+ErJ3RnqL8rpDimt3Hi8D9fw4JARb
 N+i6X1tIGPxzvXcGfDd9ssS2UvwNfk198Vjd0iVl5eoLlUbwt4nudeA5SlWI3PudC7U6
 /QRXAZzwLqDfxgoowGhV6y3GPnj+lbn5C6OkGMm5MdFXUPseMnV60m/DAohxsQhTl6pS
 WdPHGvhzD1GHnempW/qDcCSb+fLJvnFeeTreEdz7WGeG+wHIVVEUsyVQ0bLmgW1fzedg
 8URhde31M8+ZHxzGs1BwaxlsH2RzgkqgiQwaTBlBW2RTEzitJAS3RkKRZvwnB607rz4G
 ncsg==
X-Gm-Message-State: AOJu0YxokT5RciaKNF65Y4runC4OTI0NakhiQJFXrrRIC/Y/aAPUQZdb
 JinV6aNoShdbP2h/jgIoCkgDAEPC98f6hAfXvgXu+rwA1QMWR3R+ax3MNmJqGuccDtzj8t3u77S
 8cqqyCzN63be085rifVxJ79q6Wr4=
X-Gm-Gg: ASbGncv29+LWuBpspwoZgEFrv6SiQLgxWNbXZ9GU5Nz/n7ryWZNcBt1viRhZOSGC/0x
 qvaA1fz8CqImBTZB4PUxAGTf5xsYfxXn9Ne854FKcV5gW4e6BxZ2XtYIBkO9AYiZi3XzYsnb3pk
 ln/wHpRUxLX1ZshcKiQ92+pI0t+rQ=
X-Google-Smtp-Source: AGHT+IE8MlhR1upULTx2pEGBTgopb1y6+KlrM3P5XKDB8EoMEYgh08pmCSdZV3hWXyBft4xkzo+Pp9xSfXXGrorIFYI=
X-Received: by 2002:a05:6000:18a2:b0:39c:dfa:e86c with SMTP id
 ffacd0b85a97d-39c27efc018mr35067f8f.13.1743515341684; Tue, 01 Apr 2025
 06:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.3.I45a1ec3470905b1a7313ef907a83999f1163bb3b@changeid>
 <CAPVz0n0fRLgc7aOCpjVVRaX=dPMB9D9UDyNck8gsCJTpfh1pBg@mail.gmail.com>
 <0709393f-51f7-43e9-91b0-18ef5a7c0866@gmail.com>
In-Reply-To: <0709393f-51f7-43e9-91b0-18ef5a7c0866@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 1 Apr 2025 16:48:50 +0300
X-Gm-Features: AQ5f1JqUZGY6B5TC9_3i-ZN_2jslUAwGRUgJrRYdgBzhT4Dbo3bjhEz30InQszY
Message-ID: <CAPVz0n0umNySqe2QoRKknpktV-iRLF=xg4+vASaQApzMKqhY3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tegra: allow to expose UART on microSD slot
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
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

=D0=B2=D1=82, 1 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:34=
 Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> W dniu 31.03.2025 o 07:51, Svyatoslav Ryhel pisze:
> > =D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:27 =
Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >> Tegra20 has mux allowing to repurpose microSD as UART on boards which
> >> use sdmmc3 controller for microSD. Add TEGRA_UARTA_MICROSD to enable
> >> this feature. It is currently supported on Transformer T20, support fo=
r
> >> other boards may require Device Tree changes.
> >>
> >> Update Transformer T20 DTS to select correct pinmux and stdout-path
> >> based on TEGRA_UARTA_MICROSD.
> >>
> >> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> >> ---
> >>
> >> Changes in v2:
> >> - added TEGRA_UARTA_MICROSD Kconfig option
> >> - removed .dtsi for enabling UART over microSD
> >> - modified transformer DT to use UARTA and correct pinmux when
> >>    TEGRA_UARTA_MICROSD is enabled; it is enough to flip a single
> >>    switch to enable/disable UART over microSD
> >>
> >>   arch/arm/dts/tegra20-asus-transformer.dtsi | 24 ++++++++++++++++++++=
++
> >>   arch/arm/mach-tegra/tegra20/Kconfig        | 15 ++++++++++++++
> >>   2 files changed, 39 insertions(+)
> >>
> >> diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts=
/tegra20-asus-transformer.dtsi
> >> index 49efabbfd92..9ea323c81f3 100644
> >> --- a/arch/arm/dts/tegra20-asus-transformer.dtsi
> >> +++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
> >> @@ -5,7 +5,13 @@
> >>
> >>   / {
> >>          chosen {
> >> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
> >> +               stdout-path =3D &uarta;
> >> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
> >>                  stdout-path =3D &uartd;
> >> +#else
> >> +#error Unsupported UART
> >> +#endif
> >>          };
> >>
> >>          aliases {
> >> @@ -195,10 +201,17 @@
> >>                                  nvidia,function =3D "i2c1";
> >>                          };
> >>
> >> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_SDB_SDD)
> >> +                       dbguart {
> >> +                               nvidia,pins =3D "sdb", "sdd";
> >> +                               nvidia,function =3D "uarta";
> >> +                       };
> >> +#else
> >>                          sdb {
> >>                                  nvidia,pins =3D "sdb", "sdc", "sdd", =
"slxc", "slxk";
> >>                                  nvidia,function =3D "sdio3";
> >>                          };
> >> +#endif
> >>
> >>                          sdio1 {
> >>                                  nvidia,pins =3D "sdio1";
> >> @@ -376,7 +389,13 @@
> >>                  };
> >>          };
> >>
> >> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
> >> +       uarta: serial@70006000 {
> >> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
> >>          uartd: serial@70006300 {
> >> +#else
> >> +#error Unsupported UART
> >> +#endif
> >>                  status =3D "okay";
> >>                  clock-frequency =3D <216000000>;
> >>          };
> >> @@ -434,7 +453,12 @@
> >>          };
> >>
> >>          sdmmc3: sdhci@c8000400 {
> >> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_MICROSD)
> >> +               /* Can't use both at the same time */
> >> +               status =3D "disabled";
> >> +#else
> >>                  status =3D "okay";
> >> +#endif
> >>                  bus-width =3D <4>;
> >>
> >>                  cd-gpios =3D <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>=
;
> >> diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra=
/tegra20/Kconfig
> >> index 3349f1e2786..c2c51660216 100644
> >> --- a/arch/arm/mach-tegra/tegra20/Kconfig
> >> +++ b/arch/arm/mach-tegra/tegra20/Kconfig
> >> @@ -77,6 +77,21 @@ endchoice
> >>   config SYS_SOC
> >>          default "tegra20"
> >>
> >> +config TEGRA_UARTA_MICROSD
> >> +       bool "UARTA on MicroSD breakout board"
> >> +       default n
> >> +       depends on TEGRA_ENABLE_UARTA && TARGET_TRANSFORMER_T20
> >> +       select TEGRA_UARTA_SDB_SDD
> >> +       help
> >> +         Repurpose the SD card slot for getting access to the UARTA s=
erial
> >> +         console. Primarily useful only for low level u-boot debuggin=
g on
> >> +         tablets, where normal UARTD is difficult to access and requi=
res
> >> +         device disassembly and/or soldering. Enabling this option ca=
uses
> >> +         UARTA TX to become exposed on SDD and RX on SDB pins which c=
orrespond
> >> +         to microSD CLK and CMD pins respectively. Currently this is =
supported
> >> +         only on Transformer T20, support for other platforms may req=
uire DT
> >> +         and configs (from include/configs/*) updates.
> >> +
> >>   source "board/nvidia/harmony/Kconfig"
> >>   source "board/avionic-design/medcom-wide/Kconfig"
> >>   source "board/compal/paz00/Kconfig"
> >> --
> >> 2.48.1
> >>
> > This is not applicable since this is a hack by nature, BUT if you
> > contain this in the transformer t20 board and Kconfig (no dts
> > changes), this may be applied.
> Ok, then I'll drop DTS changes. I will add few words about this option
> in Transformer documentation
> and a note in Kconfig help to not surprise users with not booting U-Boot
> as enabling this option without
> changing DTS causes U-Boot to hang.

You should remove then Kconfig option as well. Add a new chapter to
Transformer T20 documentation which describes this method, here[1] you
may find a similar approach but info is in the commit message of
tegra30 uart-e funcmux. Additionally, as I have said previously, these
changes can be contained in the transformer t20 board file by using
some device tree manipulations from there.

---
1 https://source.denx.de/u-boot/u-boot/-/commit/b515d7ae0de51a26f73b2ddb5ea=
4db0d95b67d7a
