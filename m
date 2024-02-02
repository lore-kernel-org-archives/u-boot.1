Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09F3C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 04:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A03787C66;
	Fri,  2 Feb 2024 05:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2e/qDk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE94287CDB; Fri,  2 Feb 2024 05:26:03 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AC787C66
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 05:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55ff5f6a610so114884a12.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 20:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706847961; x=1707452761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iccfjty7abi6Xet5UzZI9gLS4u2H7b83x4vuR+eibrw=;
 b=D2e/qDk0zwWA+2fDY1TEr30LIM7lp44KDOwhiy/VKJUXaX2r8qUR8IbhbROhRjGj29
 KcpWWUMPjjgly19YFDzxDRD8O+l98cwNPJ6ZFfG3en+i1B9QYzbOhuYpmwwevsrSqZjZ
 8D8PAr8Y9/ODV/nOXEmmVi2aay9mBEouet4hRZFrT95E4enSkvPEbG0LFauptZf2Prio
 AoYvIquve8PMLXGSwldszyJq2qa+Eut01oux9l9QuW7Jz/8qFPVCUuQG2UqPAyL2DLQ6
 xU5I/IiNrgcU/bsFra1yFaJrZeodnwX7pJhUhdP7qhHW9G7JGWR5r/cPtrd7iFKW7FDM
 CNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706847961; x=1707452761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iccfjty7abi6Xet5UzZI9gLS4u2H7b83x4vuR+eibrw=;
 b=ZaV16qKARoyRccgO39DmLy+lg8LDNThAt5uZJN7SpvNO77AWvG5fWa6kxPNCuzVwZT
 bHzlh5M07LqD8f25HKW6EjlfIrMfo/UMYI/vWC/w2vrAFAfmvdYQexDbUsKnt7J66jjC
 fW5MQ0k0DWKWvOzraVPlNtBMvUow8OZW61thhwgMQAV/lW7ZDWVq5Rg16ySk6swWeFDa
 etND/ztBMtzeHd6HKuyRJAIo8JV6of/+oRYHFv8lMa1YTbm/h/Qs9vVkjMzXnHnSagpY
 Q4Sw+qavZu3COKPde+1KXcZVnqnVuzzBMciqMo9oJl4yDNjv4PKAlaUhOVdVLt5jKpkn
 6i7w==
X-Gm-Message-State: AOJu0YzFI986aclP4uVMX31uRSIK4jCdpPjcFSO7wesVCI1DDmqPVfwd
 4EWhfw1liTD7rg9VB/ybMm4fypu7hnzD8jTnjs7Q84vx6kPxlw29xgIQd1Ym4YmABQx/gf2peiH
 oFnSmz6rtg23Tj6O4FC5GW04eQzmGHa8LWtDOWTT5oYYAvw==
X-Google-Smtp-Source: AGHT+IEardeAMcJf4IF432vtKd9QLI3vJDuqjasWHHFKtEql5tiiQbTNhfKaIZz5kBD+DgrlkcsSBpr5aSbq2aeID+M=
X-Received: by 2002:a05:6402:2d1:b0:55e:d8a8:ef6d with SMTP id
 b17-20020a05640202d100b0055ed8a8ef6dmr4971723edx.35.1706847960165; Thu, 01
 Feb 2024 20:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-1-1eec1c34953c@theobroma-systems.com>
In-Reply-To: <20240123-jaguar-v1-1-1eec1c34953c@theobroma-systems.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Fri, 2 Feb 2024 12:25:48 +0800
Message-ID: <CAHk0Hov=ZOozDt9zjkQC3_sDwRWNXTfcbUoi1t2y+JqsRMdMmA@mail.gmail.com>
Subject: Re: [PATCH 01/18] rockchip: rk3588: use mainline pmu-grf compatible
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>,
 heiko@sntech.de, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

On Tue, Jan 23, 2024 at 10:50=E2=80=AFPM Quentin Schulz <foss+uboot@0leil.n=
et> wrote:
>
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> The compatible for the pmugrf in the mainline kernel is dfferent from the
> one currently used in u-boot. Adapt the -u-boot.dtsi and syscon driver
> to use the correct compatible.

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

BR,
Weizhao

>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/dts/rk3588s-u-boot.dtsi              | 2 +-
>  arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-bo=
ot.dtsi
> index c0fd16c4022..9a5ffec926e 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -66,7 +66,7 @@
>
>         pmu1_grf: syscon@fd58a000 {
>                 bootph-all;
> -               compatible =3D "rockchip,rk3588-pmu1-grf", "syscon";
> +               compatible =3D "rockchip,rk3588-pmugrf", "syscon";
>                 reg =3D <0x0 0xfd58a000 0x0 0x2000>;
>         };
>
> diff --git a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c b/arch/arm/mac=
h-rockchip/rk3588/syscon_rk3588.c
> index e8772d3a382..7b2cf37d9da 100644
> --- a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
> @@ -10,7 +10,7 @@
>
>  static const struct udevice_id rk3588_syscon_ids[] =3D {
>         { .compatible =3D "rockchip,rk3588-sys-grf", .data =3D ROCKCHIP_S=
YSCON_GRF },
> -       { .compatible =3D "rockchip,rk3588-pmu1-grf", .data =3D ROCKCHIP_=
SYSCON_PMUGRF },
> +       { .compatible =3D "rockchip,rk3588-pmugrf",  .data =3D ROCKCHIP_S=
YSCON_PMUGRF },
>         { .compatible =3D "rockchip,rk3588-vop-grf", .data =3D ROCKCHIP_S=
YSCON_VOP_GRF },
>         { .compatible =3D "rockchip,rk3588-vo-grf",  .data =3D ROCKCHIP_S=
YSCON_VO_GRF },
>         { .compatible =3D "rockchip,pcie30-phy-grf", .data =3D ROCKCHIP_S=
YSCON_PCIE30_PHY_GRF },
>
> --
> 2.43.0
>
