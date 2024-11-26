Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328C0D3B993
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5ED89C81;
	Tue, 26 Nov 2024 15:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDxWBwnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043AF89C83; Tue, 26 Nov 2024 15:17:55 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A09889C7D
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffc7a2c5d5so20317981fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732630672; x=1733235472; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANgMcg0gauMiTM+tjXR5I/GPlhUy0JBsCe6FAQki/2s=;
 b=DDxWBwnbzcd+u7c5h/nG8pJ8iYrWASrYKO3QWK9zm+XEr9kgbR8QxEQc1OjEZE+4yA
 /138Y7Gf//8hXPTrfKyl4r7knfx9C0B061qB8QvyPB/kRJk6Lx+wOhCT+4Flj5sz05fu
 yW5YrjDMuuF0n7eh/MwE12ywPeBRPVPAgmuP9r+fHqsvDMwJdD0vTpvEjoGjobIdWzTL
 LHYhCVqdWa0c4L1QqLI+dwS1haxsYDEB9fANdROphxFQVeQ0BApsesyfIwqop18NKGwr
 Ny/NGhvu9g9e6RjoG+n8toEnYlAhH5e9P2fpj2kp6wIPAwYU6QW1Xm04qySY3Yk4Hc/C
 1Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630672; x=1733235472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANgMcg0gauMiTM+tjXR5I/GPlhUy0JBsCe6FAQki/2s=;
 b=CdQjWolKIyupwlIai2lrz1X8hffQLLpwcnrzUU+PVAilpPJSAYO4tx4eODoN82XVUu
 sroAlhEp6NfiBCkfkzyRezjKg2L/PqiZX9TsS3Z7FM4ybW/rPZal+5YVjSizD187u/Ed
 +I55UFzQ5H9WbxjzkW6mxmHVnNEYNm8RtLXj2I/gaib2sxXELVL+QUhLmKzB9ukfaxGT
 Ww4H9ZacOY6Ft7Oiqsy+YStBCaU8Q/UgbytF8wF+7oH/GAwobgf7HER8YQ/ingKQpnwa
 PiBZd36YsE0kksEOU6OzsKxGUxPmxbqXGcp0hD1+4oohI17/1qOswWtYNLD/4bax9JVd
 OB6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3AxewHkvGGHUCGPk+r9+9dSf4KiCT4T2qNwkuuKV+/AZkD2wbBSacF/jksThzbqmeBkbpGdY=@lists.denx.de
X-Gm-Message-State: AOJu0YyWLwsfln5YnpK6t6Tlwfrx5bsqWcHVLg53qAAci543CO1VjsOM
 PxcwDhSnBLjTsBlo3WdgDo7c+Bb9kyGozQwu4gkftb2fYs9ZTKw+bYd298xklOdRSQEF59Svtjh
 87xRogT4uz6FIXVLaEZycxAzj8Uc=
X-Gm-Gg: ASbGncscQ2GX1u/DhYt3igg6C6uM6cCnc77My9x2uM/QKLM+/Ju2RQInhpf5rlUMEQp
 ph67//dNX1kvqTt/dPPwnufvXETU0I+XXE1Si2aNLOIoMn0fPj28Rm6enW2ekj5Ek+g==
X-Google-Smtp-Source: AGHT+IFyivSy+oyvThR/ss1wVfjyCmSWT5dnItM1KhBaXlKCP7AWbaGnN5Yj8L9fUFFptAOeM1tUchP/AnIZvK0neUE=
X-Received: by 2002:a05:651c:555:b0:2ff:54d6:4d9f with SMTP id
 38308e7fff4ca-2ffa710614fmr71781241fa.11.1732630671495; Tue, 26 Nov 2024
 06:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
 <20241125003205.75327-9-hal.feng@starfivetech.com>
In-Reply-To: <20241125003205.75327-9-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 26 Nov 2024 06:17:40 -0800
Message-ID: <CANV2PTMmB1Zg9n7i1BAN7P0oGqkqjr2UX5on8R-mQ2xwS7TV0A@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] riscv: dts: jh7110: Support multiple DTBs in a
 Fit image
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

Hi Hal, this is better than it was before, thank you.

On Sun, Nov 24, 2024 at 4:33=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> Support multiple DTBs for JH7110 based boards, so they can
> select the correct DT at runtime.
>
> Tested-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-common-u-boot.dtsi | 66 +++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh=
7110-common-u-boot.dtsi
> index c44553455e..64b4d04884 100644
> --- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> @@ -112,20 +112,74 @@
>         itb {
>                 fit {
>                         images {
> -                               fdt-1 {
> -                                       description =3D "NAME";
> +                               fdt-jh7110-starfive-visionfive-2-v1.3b {
> +                                       description =3D "jh7110-starfive-=
visionfive-2-v1.3b";
>                                         load =3D <0x40400000>;
>                                         compression =3D "none";
>
> -                                       uboot_fdt_blob: blob-ext {
> -                                               filename =3D "u-boot.dtb"=
;
> +                                       blob-ext {
> +                                               filename =3D "dts/upstrea=
m/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> +                                       };
> +                               };
> +
> +                               fdt-jh7110-starfive-visionfive-2-v1.2a {
> +                                       description =3D "jh7110-starfive-=
visionfive-2-v1.2a";
> +                                       load =3D <0x40400000>;
> +                                       compression =3D "none";
> +
> +                                       blob-ext {
> +                                               filename =3D "dts/upstrea=
m/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
> +                                       };
> +                               };
> +
> +                               fdt-jh7110-milkv-mars {
> +                                       description =3D "jh7110-milkv-mar=
s";
> +                                       load =3D <0x40400000>;
> +                                       compression =3D "none";
> +
> +                                       blob-ext {
> +                                               filename =3D "dts/upstrea=
m/src/riscv/starfive/jh7110-milkv-mars.dtb";
> +                                       };
> +                               };
> +
> +                               fdt-jh7110-pine64-star64 {
> +                                       description =3D "jh7110-pine64-st=
ar64";
> +                                       load =3D <0x40400000>;
> +                                       compression =3D "none";
> +
> +                                       blob-ext {
> +                                               filename =3D "dts/upstrea=
m/src/riscv/starfive/jh7110-pine64-star64.dtb";
>                                         };
>                                 };
>                         };
>
>                         configurations {
> -                               conf-1 {
> -                                       fdt =3D "fdt-1";
> +                               conf-jh7110-starfive-visionfive-2-v1.3b {
> +                                       description =3D "jh7110-starfive-=
visionfive-2-v1.3b";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-jh7110-starfive-visi=
onfive-2-v1.3b";
> +                               };
> +
> +                               conf-jh7110-starfive-visionfive-2-v1.2a {
> +                                       description =3D "jh7110-starfive-=
visionfive-2-v1.2a";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-jh7110-starfive-visi=
onfive-2-v1.2a";
> +                               };
> +
> +                               conf-jh7110-milkv-mars {
> +                                       description =3D "jh7110-milkv-mar=
s";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-jh7110-milkv-mars";
> +                               };
> +
> +                               conf-jh7110-pine64-star64 {
> +                                       description =3D "jh7110-pine64-st=
ar64";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-jh7110-pine64-star64=
";
>                                 };
>                         };
>                 };
> --
> 2.43.2
>

Referring to the U-Boot documentation

https://docs.u-boot.org/en/v2024.10/usage/fit/howto.html

gives an example as you have it here unsorted with "images" before
"configurations".

However, nodes in images{} and configurations{} should be sorted:

fdt-jh7110-milkv-mars
fdt-jh7110-pine64-star64
fdt-jh7110-starfive-visionfive-2-v1.2a
fdt-jh7110-starfive-visionfive-2-v1.3b

conf-jh7110-milkv-mars
conf-jh7110-pine64-star64
conf-jh7110-starfive-visionfive-2-v1.2a
conf-jh7110-starfive-visionfive-2-v1.3b

With that,

Reviewed-by: E Shattow <lucent@gmail.com>
