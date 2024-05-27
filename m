Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18FAC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 18:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE06E881A9;
	Mon, 27 May 2024 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="THJY8UYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988AC88256; Mon, 27 May 2024 20:15:04 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0AD8813F
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 20:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-80327fdd618so15557241.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716833701; x=1717438501; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wH4qeGhsKfmECBD8IgmJT0C6sksNVp2p//9Ox29+E+s=;
 b=THJY8UYRwhlXe6AtyQZvh8Bxb9JMA1qt/5TknDazHvALp1CbG+cWZ+iX0EehQQOodn
 q0Dl9Ce3bqYNZz3+1Td3uEcECsFg2quteHr5mInsusUOzoVwMUd1jX7kgZxs5XF8+yHS
 V3nEC3BArKliOHTiINzgHAPMo0BwfwXt+BU7c14jk6fM5LFfETde026nnBH4+ISzuA4Y
 Sry8PzQ6u/+GDRaOvAm4Z4x6CKdZCPyVmF5mVQl+ueRPuJfx5JxM2BqNaLk+WOKyk0o4
 d5EWgYh8KZ8iqokG5idwyV3nk47DdXynxLPb621J7eh820Ew0Tk0sBE3oWJROQrgptC3
 Aldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716833701; x=1717438501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wH4qeGhsKfmECBD8IgmJT0C6sksNVp2p//9Ox29+E+s=;
 b=T4EzjPICfRzRHdZxPMSXPVv7JPZK3cbBvBoCfxyRVPKOA9Ebze8NE3ncvedmQEpCA9
 ZEPxUWevgqC0gCOY9qzn6i3YhC+x9oe+rr373BqBeIqUIJw2FrNN6aMIOTDYuGgdBmxa
 WMI+vQzmlM/LvjBPKAZsTAuy0foPFg5K/mEn5Kl1HB784qAzCeO0V/r2rOPMjUWyuVT9
 rArcAdLd2mFEz7yd0Bcc9bt+IFfSxjaitmO3SllRlFbgELPAC7A5NYQ+wsthG8wAnqT0
 Dppw6qBpY/4NdjR5t5vTVSsY0d0lWBjpfjv9FNme+kSpd8RBs5mdv5ss0ETSBfkWFJRH
 V3Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKu7Kqzc8aMkVYbl04G0Cj8zgipPHeOGZp+MH6QBoZx9P9PkI9YFt82jmwQFaRGn4uA8s6uLq03j6H5AA9DcAimHkXcw==
X-Gm-Message-State: AOJu0YwdI2TIkdaIurBVg/SW4/+pqQf6zZlP93i38rKZaZy0GwbAy3eb
 HRSht+C0my0TokJYEoGqMOhx6IrsoDVU0Edp5zVJGH39o5gpGJlzrnRyYuIJUg5M26OLaaZvmPF
 NGiQgp4D7fJOC8pgqkPXXYFWEtVk=
X-Google-Smtp-Source: AGHT+IHngPOUDmR7Ov5R8xZUGzeSZuZJp89I+wwDjegS85FT210TlkDufNKmwPfeoxSUqe6TMNL0VfzTR8KPAHciiaU=
X-Received: by 2002:a05:6102:12cf:b0:48a:3550:a0d5 with SMTP id
 ada2fe7eead31-48a38506538mr8194252137.5.1716833701139; Mon, 27 May 2024
 11:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240527104730.20244-1-matthias.bgg@kernel.org>
In-Reply-To: <20240527104730.20244-1-matthias.bgg@kernel.org>
From: E Shattow <lucent@gmail.com>
Date: Mon, 27 May 2024 11:14:49 -0700
Message-ID: <CANV2PTOMZrZg9E8qY-AEJzupLxipsppqy5VEygPkDJsw+JHB+A@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: jh7110: Update qspi node with upstream
To: matthias.bgg@kernel.org
Cc: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com, 
 minda.chen@starfivetech.com, heinrich.schuchardt@canonical.com, 
 jh80.chung@samsung.com, xingyu.wu@starfivetech.com, u-boot@lists.denx.de, 
 mason.huo@starfivetech.com, duwe@suse.de, hal.feng@starfivetech.com, 
 yanhong.wang@starfivetech.com, Matthias Brugger <mbrugger@suse.com>, 
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Nam Cao <namcao@linutronix.de>
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

Hi,

On Mon, May 27, 2024 at 3:47=E2=80=AFAM <matthias.bgg@kernel.org> wrote:
>
> From: Matthias Brugger <mbrugger@suse.com>
>
> Upstream node uses a specific SoC compatible to make the kernel driver
> work. Copy over the upstream node to fullfill that need.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>
>  .../jh7110-starfive-visionfive-2-u-boot.dtsi  |  2 +-
>  .../dts/jh7110-starfive-visionfive-2.dtsi     | 29 ++++++++++++++++---
>  arch/riscv/dts/jh7110.dtsi                    | 19 +++++++-----
>  3 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/ar=
ch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> index 3012466b305..a69d8fcb391 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> @@ -40,7 +40,7 @@
>  &qspi {
>         bootph-pre-ram;
>
> -       nor-flash@0 {
> +       nor_flash@0 {
>                 bootph-pre-ram;
>         };
>  };
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/risc=
v/dts/jh7110-starfive-visionfive-2.dtsi
> index e11babc1cde..375449b73a8 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -305,17 +305,38 @@
>  };
>
>  &qspi {
> -       spi-max-frequency =3D <250000000>;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
>         status =3D "okay";
>
> -       nor-flash@0 {
> +       nor_flash: nor_flash@0 {
>                 compatible =3D "jedec,spi-nor";
> -               reg=3D<0>;
> -               spi-max-frequency =3D <100000000>;
> +               reg =3D <0>;
> +               cdns,read-delay =3D <5>;
> +               spi-max-frequency =3D <12000000>;
>                 cdns,tshsl-ns =3D <1>;
>                 cdns,tsd2d-ns =3D <1>;
>                 cdns,tchsh-ns =3D <1>;
>                 cdns,tslch-ns =3D <1>;
> +
> +               partitions {
> +                       compatible =3D "fixed-partitions";
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +
> +                       spl@0 {
> +                               reg =3D <0x0 0x80000>;
> +                       };
> +                       uboot-env@f0000 {
> +                               reg =3D <0xf0000 0x10000>;
> +                       };
> +                       uboot@100000 {
> +                               reg =3D <0x100000 0x400000>;
> +                       };
> +                       reserved-data@600000 {
> +                               reg =3D <0x600000 0xa00000>;
> +                       };
> +               };
>         };
>  };
>
> diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> index 2cdc683d49b..2b331e58497 100644
> --- a/arch/riscv/dts/jh7110.dtsi
> +++ b/arch/riscv/dts/jh7110.dtsi
> @@ -480,19 +480,22 @@
>                 };
>
>                 qspi: spi@13010000 {
> -                       compatible =3D "cdns,qspi-nor";
> -                       reg =3D <0x0 0x13010000 0x0 0x10000
> -                               0x0 0x21000000 0x0 0x400000>;
> -                       clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>;
> -                       clock-names =3D "clk_ref";
> +                       compatible =3D "starfive,jh7110-qspi", "cdns,qspi=
-nor";
> +                       reg =3D <0x0 0x13010000 0x0 0x10000>,
> +                             <0x0 0x21000000 0x0 0x400000>;
> +                       interrupts =3D <25>;
> +                       clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>,
> +                                <&syscrg JH7110_SYSCLK_QSPI_AHB>,
> +                                <&syscrg JH7110_SYSCLK_QSPI_APB>;
> +                       clock-names =3D "ref", "ahb", "apb";
>                         resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>,
>                                  <&syscrg JH7110_SYSRST_QSPI_AHB>,
>                                  <&syscrg JH7110_SYSRST_QSPI_REF>;
> -                       reset-names =3D "rst_apb", "rst_ahb", "rst_ref";
> +                       reset-names =3D "qspi", "qspi-ocp", "rstc_ref";
>                         cdns,fifo-depth =3D <256>;
>                         cdns,fifo-width =3D <4>;
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
> +                       cdns,trigger-address =3D <0x0>;
> +                       status =3D "disabled";
>                 };
>
>                 syscrg: clock-controller@13020000 {
> --
> 2.44.0
>

Please consider OF_UPSTREAM. Linux Kernel has now merged the Milk-V
Mars dts patch series which introduces a jh7110-common.dtsi and also
the PLDA PCIe HOST patch set is queued for-next, so it is a good time
to do so.

-E
