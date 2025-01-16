Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35056C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EE28073D;
	Fri, 17 Jan 2025 00:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="R7ASe39Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6E080755; Fri, 17 Jan 2025 00:16:25 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F08F80717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e39779a268bso2542268276.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737069382; x=1737674182; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ts1O73DaWKASpsB9KrgYFSH5IHI0NSsDITWumyZxh5I=;
 b=R7ASe39YZBydWgjNkWYUtjunpnU7XJ+KCG/vMfV+E9Ri8EgxfAJXK7T6BabJXzzB0x
 DI2NW5KXOLDfFa/XYU6hRZX4rgGF4X6apdXXhfZFumRgiWsUAUT3+Y6Vfdh6YQWfSgcn
 1G5qmlRKJq5A4yJR19Va1m1pz/RAS5Q/HDRZAZ9j6+B1h33lOc532WQlXv5kvz5ptSPn
 uJhqR+zxKAqbKQ4Tvez6ubDR42xuF8UH3u/fjeeECx6sAWskLghgksmCT9coUg3VVb2Q
 fyEuW+vYGLyK0DDWv1h+vRx6Zl6e+ZDfnZt8cAsPVNJWBwd46EnvnjYA4MWvQEZ1LUHI
 NICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737069382; x=1737674182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ts1O73DaWKASpsB9KrgYFSH5IHI0NSsDITWumyZxh5I=;
 b=mcl3p4ujn3yv+HUdxAYssM4zfySoX0RZHzpxNY5RtiRB1Fvigx76kmmeELLcwkwGb0
 Yhi3Wshpj3BChQG/qx+WMQrVbLS72H2eWVAWuKtr9nwDKEwLpruajJt3aMIwm6rDYRwj
 OaBJ1qL8gNxWjw+9WNlagRcbPFPCOBevy3FUW3Y7QiLbSKjucRDsIa/NHnwpJuCATWsY
 zoTBRgoItXosAROS0qgXfTpyxAPqL3QzE+nT+Kq3CQvwujL758X0+zsqUHpbKUyN7TdX
 hAacRYPvN/31VGxCp9/mLgmtN2XqRuN14Py2JsPJMbGLXtRh0chPIABBQTc5wnjdJKje
 aj5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl64JfVZYLloLTQN3jxrrE4VF7wAXoYj0LJhpwV96s7HJ3cGmH41fN4LrASGulbO9aN1/MQ5w=@lists.denx.de
X-Gm-Message-State: AOJu0YzF8+CRs7qAkcn8Xow/CURXpuA/Jv5ou0P480D0hmO0shrBZ0r1
 6x8Qn5k0uHTr+eoq9GtjwALyXEu4vu5QxVu3aTO9oG1ACNivLbu4b0zvVgt+BWu40aLCwIMAqqG
 C6ilEm0d9flIWODFT1MMwu7u8m1tK1KCF/oMLOQ==
X-Gm-Gg: ASbGnct92A3r2nBZAX2EafqSSX9TBbcfwSVyUjKZtREjjOnquPqkWZ46ETs6EvUQ+ZV
 AHWpz+E9yllwOfiomMOwl3cqon2V186cMUZl65Q==
X-Google-Smtp-Source: AGHT+IHgm654+rcS8YviEY3SlBlrjORCiF27YVX6hiNl8bohjVkSIdGelPhKWR13kcEwlpbpDRCuAb80U4qh4IRc28Y=
X-Received: by 2002:a05:6902:218a:b0:e54:d63a:911c with SMTP id
 3f1490d57ef6-e57b0baa830mr433740276.10.1737069382431; Thu, 16 Jan 2025
 15:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20250116231032.2312636-1-festevam@gmail.com>
In-Reply-To: <20250116231032.2312636-1-festevam@gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 15:16:11 -0800
X-Gm-Features: AbW1kvYA5tQL6PeRfDRlsUxHWQ0zcXDHeNYVNVhcYbNgo0g41zhLxEbUFwPT7Uk
Message-ID: <CAJ+vNU1kqoHFT6kjBg3Qkgr1Fez=Cj=SfQPKpEBpjBEHyYf+qA@mail.gmail.com>
Subject: Re: [PATCH] imx8m: Guard binman nodes with CONFIG_OPTEE
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, uboot-imx@nxp.com, peng.fan@nxp.com, y.moog@phytec.de, 
 u-boot@lists.denx.de, marex@denx.de, Fabio Estevam <festevam@denx.de>
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

On Thu, Jan 16, 2025 at 3:10=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Guard binman nodes with CONFIG_OPTEE to fix the following error
> when building without optee support:
>
>   BINMAN  .binman_stamp
> Image 'image' has faked external blobs and is non-functional: tee.bin
>
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Some images are invalid
> make: *** [Makefile:1135: .binman_stamp] Error 103
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi | 2 ++
>  arch/arm/dts/imx8mn-u-boot.dtsi | 2 ++
>  arch/arm/dts/imx8mp-u-boot.dtsi | 2 ++
>  arch/arm/dts/imx8mq-u-boot.dtsi | 2 ++
>  4 files changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index ecc2319279ea..f1cc3fd2532b 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -164,6 +164,7 @@
>                                         };
>  #endif
>
> +#ifdef CONFIG_OPTEE
>                                         tee: tee {
>                                                 description =3D "OP-TEE";
>                                                 type =3D "tee";
> @@ -178,6 +179,7 @@
>                                                         optional;
>                                                 };
>                                         };
> +#endif
>
>                                         binman_fip: fip {
>                                                 arch =3D "arm64";
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 4a4498b36b01..08a81ddc9cb2 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -240,6 +240,7 @@
>                                         };
>  #endif
>
> +#ifdef CONFIG_OPTEE
>                                         tee: tee {
>                                                 description =3D "OP-TEE";
>                                                 type =3D "tee";
> @@ -254,6 +255,7 @@
>                                                         optional;
>                                                 };
>                                         };
> +#endif
>
>                                         binman_fip: fip {
>                                                 arch =3D "arm64";
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot=
.dtsi
> index 9ede98a11e42..55be8e4f7cb0 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -185,6 +185,7 @@
>                                         };
>  #endif
>
> +#ifdef CONFIG_OPTEE
>                                         tee: tee {
>                                                 description =3D "OP-TEE";
>                                                 type =3D "tee";
> @@ -199,6 +200,7 @@
>                                                         optional;
>                                                 };
>                                         };
> +#endif
>
>                                         @fdt-SEQ {
>                                                 description =3D "NAME";
> diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot=
.dtsi
> index 93e2ef27f7ce..cdeacbac108b 100644
> --- a/arch/arm/dts/imx8mq-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mq-u-boot.dtsi
> @@ -144,6 +144,7 @@
>                                         };
>  #endif
>
> +#ifdef CONFIG_OPTEE
>                                         tee: tee {
>                                                 description =3D "OP-TEE";
>                                                 type =3D "tee";
> @@ -158,6 +159,7 @@
>                                                         optional;
>                                                 };
>                                         };
> +#endif
>
>                                         fdt {
>                                                 compression =3D "none";
> --
> 2.34.1
>

Hi Fabio,

Thanks, much better than the ugly message and make status code failure
if you don't have tee.bin.

I notice that loadables =3D "atf", "tee" now:
#ifndef CONFIG_ARMV8_PSCI
                                                loadables =3D "atf", "tee";
#endif

Does that need to be also protected against CONFIG_OPTEE?
#ifndef CONFIG_ARMV8_PSCI
#ifdef CONFIG_OPTEE
                                                loadables =3D "atf", "tee";
#else
#endif
                                                loadables =3D "atf";
#endif

Best Regards,

Tim
