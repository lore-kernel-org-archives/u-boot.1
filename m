Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6804CE65D17
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 09:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E743897DF;
	Fri, 22 Nov 2024 10:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtvTCvW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FFE897DF; Fri, 22 Nov 2024 10:20:51 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDBA89351
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 10:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ffa8df8850so3395091fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732267248; x=1732872048; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3K3SUY3xO5QbPfN7fmdGHi9q13Fg8NDAEgdDQKxMjA=;
 b=dtvTCvW/ZY+qdLVOVQRubCBBWKHRcU6XUUUvOB3X+wWb/0YoZfcp49b4aQrohHPAnj
 uvc9BDsLZWVCQ/wnUyL5TNdbWCjVM98iKn3IhwZgsJYIdrmQ9qEKY0g53O8OnOKHUNGo
 DHArA/BGEvgWJfDm+/AKqggK1bpfezChGnK/FgJSYVEwyiKGIvTNlrm6pl9qInml4dn4
 9iSVjkZB0bh7EkLEVTLh/Wk3eQ6zeXNh/UD+L7doC0u4c7F6m/5aoGZt3wRRkYaYos+c
 IydnmeNlP5NMf6gIWpbi1Cls/M38WUqur7YgdgXbcb8puiy1sJwjGoCa51FJYglAcMSL
 GuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732267248; x=1732872048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3K3SUY3xO5QbPfN7fmdGHi9q13Fg8NDAEgdDQKxMjA=;
 b=VswCdV0iADk9J8uJcyTTP7MwXwlcZ9UPXC/dko+AnRhndnizKIjgUTZqvVz/YT1540
 h7SzO48UhhtwPFKxIx/S1BxN+jg1JY7RSGv0uSuZYXPibkIOycJXKtcNMW2plmQvmeBe
 vDu2LXIBvijtP87vN5BtB+4gZqsQLlOCIW6Eo7VBE5dTNh2YhW1uUiXPsgzcATyUiDp2
 QrhFL9N7hiOHxgwb2OLUDHMWXUECNSgAqXGsQk0Xsvy3Book2Sxp5J6eKWcNAk+UqR2+
 PvMMI5bhUHuEyYElcp1UHyM4xatRKVm/yhE1gH3jbI8Kpx9bfaFeDS2KI5SpP6t/01Ee
 oNQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefvZblI/X7ikbq1TEZhKKuB7LngdAmZNB5Dy7deBRpDhjeZFoIixj/6huvXrHeYTXsSGNnCc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0P+A6VT30sIuMg8ZjCt+GjIpIl/NmU8q+coGf6e1rdzfv19U7
 3KDuv9mDqQz8L1IkgiwiU7dFx/FmZ77dmAyAZiqMh73NNJ3Aq17jvJmffgYbU2vFWBSkt5EL6p7
 RhrGA8XCIAgV3P9UYJeIU/es5afhp+zTUYWo=
X-Gm-Gg: ASbGnctUs/B/C4ekjkTOfnAqmUcIFOd4jcdXpWrR8JGe2YF88IN4c7RxQ4qmilx/9zj
 +upB4QOnmoxARkcJg45PtZbejgJGgUpeK33HHB/+q8JwbpGUrLGAEV/A36fmeIxCLUg==
X-Google-Smtp-Source: AGHT+IHn1BaSIs04p5xMMyNP6kz4rYCMqbuxp9Tf6GZdWEP5aq65bPlWMshq9ei/KOMnBN0SfYbkTDaDnaTxOh6qxRQ=
X-Received: by 2002:a05:651c:553:b0:2ff:991a:fb96 with SMTP id
 38308e7fff4ca-2ffa716d0b6mr9213931fa.12.1732267247502; Fri, 22 Nov 2024
 01:20:47 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-9-hal.feng@starfivetech.com>
In-Reply-To: <20241119020425.51989-9-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 22 Nov 2024 01:20:36 -0800
Message-ID: <CANV2PTNBzZUaMGmOU6xQzsz7fBcxs4XkA+OksQmbvGQX0zqC8g@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] riscv: dts: jh7110: Support multiple DTBs in a
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

On Mon, Nov 18, 2024 at 6:06=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> Support multiple DTBs for JH7110 based boards, so they can
> select the correct DT at runtime.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/dts/jh7110-common-u-boot.dtsi | 60 ++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh=
7110-common-u-boot.dtsi
> index c44553455e..3928d551c9 100644
> --- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> @@ -113,20 +113,74 @@
>                 fit {
>                         images {
>                                 fdt-1 {
> -                                       description =3D "NAME";
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
> +                               fdt-2 {
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
> +                               fdt-3 {
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
> +                               fdt-4 {
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
>                                 conf-1 {
> +                                       description =3D "jh7110-starfive-=
visionfive-2-v1.3b";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
>                                         fdt =3D "fdt-1";
>                                 };
> +
> +                               conf-2 {
> +                                       description =3D "jh7110-starfive-=
visionfive-2-v1.2a";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-2";
> +                               };
> +
> +                               conf-3 {
> +                                       description =3D "jh7110-milkv-mar=
s";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-3";
> +                               };
> +
> +                               conf-4 {
> +                                       description =3D "jh7110-pine64-st=
ar64";
> +                                       firmware =3D "opensbi";
> +                                       loadables =3D "uboot";
> +                                       fdt =3D "fdt-4";
> +                               };
>                         };
>                 };
>         };
> --
> 2.43.2
>

Are we sure it is a good idea to have sequential numbering for things
that ought to be ordered by alphanumeric? Sounds to me like a noisy
commit in the future when adding board support and trying to sort, or
just piling on sequential additions.

fit{ images{ fdt-1 { ... } } }
configurations{ conf-1 { description =3D
"jh7110-starfive-visionfive-2-v1.3b" ... fdt =3D "fdt-1" } }

This is perhaps not as good as it can be, for being git commit
friendly when adding board support that is sorted by name.

What about?:

fit{ images{ fdt-starfive-visionfive-2-v1.3b { ... } } }
configurations{ conf-starfive-visionfive-2-v1.3b { description =3D
"jh7110-starfive-visionfive-2-v1.3b" ... fdt =3D
"fdt-starfive-visionfive-2-v1.3b" } }

based on the compatible identifier for that board or does that break someth=
ing?

-E
