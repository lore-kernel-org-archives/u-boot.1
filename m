Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2ADC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4002D88634;
	Fri, 26 Apr 2024 17:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="QwLXSOlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7928A88679; Fri, 26 Apr 2024 17:30:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D793888399
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51a7d4466bso278539466b.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714145435; x=1714750235; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQ/gOSn7/3ViahvFK+vaXfktrY2AAJbrzlBwYk7CdVk=;
 b=QwLXSOlbosOad2ITh+WBCI15zvZ4hGQ+hQJlv9mG1z2zMHSGJcK0bMH0eBrWcy/QWJ
 p3c+sQsoR17l9uFBh3MSKb2ODjCAfqu2VhRTvGpyYlm/P8KKxme113NsA666gIN+8FM1
 KHrwnAiL2ukyHWwAogjXs54jGnvGdS2KYPSv5ylHx6N5YHx0mD/Zd+gCsMtL4sZNiGIN
 59NeTl65T/sHY9jzFWgAnxYAtUE3wL384s/6sLDdSegroDfSBVpes45oaG2rZRWe9tc1
 Cp5cPr8SkPXF6G5n0+fOmjAemMV9CDguCNc4s7zhE5ParjIk+Gz7IfGotLWfyC5L7/Ao
 CNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145435; x=1714750235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQ/gOSn7/3ViahvFK+vaXfktrY2AAJbrzlBwYk7CdVk=;
 b=Pv2tLPhvuXa2LHUHlt8yj4jWXz5wEx+ahZkPFgCAweqFgkQ9ecQS3DU3PjFCNMdW7m
 XgrjGz/RxzPAV7bkS1ja9vdtepYNCWqk7x0I1DGHPRhxnCFy/21H+nSfdxIXmSe9kuxT
 V+taKUTGYiRP5zL3rH5FuzdDXjHsGyypsKlrI4hMS5TtO46gM5FARpbkzOCM0nioNgpC
 BsZjuVcKviQsai3MUCpzFIvoe2PxImyxitMiXYcnfi246i+tLzpe95hmlLG5rtZQs3YA
 A+76mUeQcXWl5MCEuHsr6yoBBHCSjaQQg9X2awhNKw8LzwM4tI5yAk0WbdeGc30g5u8F
 Z7Gw==
X-Gm-Message-State: AOJu0YwrldARblAFIhe8DNdUsRSYAGqG5tq8zNgHh8f5JDXd0neE0loL
 gfZoyT2WEOq32yYQ7owgfVeN2OhWjKEs9rCIO/zRil6q0M6FkseLiPXhUsbo4HPlA9zbbQ+ZHPG
 SUNxcCrna1nXJm2z4FT4LyX1kjTCAPHeIolauuQ==
X-Google-Smtp-Source: AGHT+IH+JDKm8K24Kf/0+xfoz3YWo+XTmt95Cd9SlZK7GmwlP7ts0tSizRAkhr3jE7dl/lgKS+1FcchcA2Faw8wKZOQ=
X-Received: by 2002:a17:906:abc8:b0:a58:5ee1:db43 with SMTP id
 kq8-20020a170906abc800b00a585ee1db43mr2382397ejb.23.1714145435289; Fri, 26
 Apr 2024 08:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240425230721.497441-1-marex@denx.de>
 <20240425230721.497441-2-marex@denx.de>
In-Reply-To: <20240425230721.497441-2-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 08:30:23 -0700
Message-ID: <CAJ+vNU34Zrn8znALzZqsDnkWifhVbz3D4D_hyNurKzH0cn30Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: hab: Use nxp_imx8mcst etype for i.MX8M flash.bin
 signing
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, kernel@puri.sm, 
 u-boot@dh-electronics.com
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

On Thu, Apr 25, 2024 at 4:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Update documentation and use nxp_imx8mcst binman etype for signing
> of flash.bin instead of previous horrible shell scripting.

Hi Marek,

To be completely fair we are just replacing a shell script and
template file with a python script
(tools/binman/etype/nxp_imx8mcst.py) which also creates the template
file.

I could care less about shell vs python but do put huge value in the
idea of making signing easier and doing so without modification of
U-Boot code. The current implementation requires a couple of things to
be enabled in defconfig which can be done with a seperate
'out-of-tree' defconfig but this new proposed implementation requires
changing a u-boot.dtsi which is a tracked file.

>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: kernel@puri.sm
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>  doc/imx/habv4/csf_examples/mx8m/csf.sh        |  92 ------------
>  doc/imx/habv4/csf_examples/mx8m/csf_fit.txt   |  30 ----
>  doc/imx/habv4/csf_examples/mx8m/csf_spl.txt   |  33 ----
>  doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 141 +++++++-----------
>  4 files changed, 55 insertions(+), 241 deletions(-)
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf.sh
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
>
<snip>

> +to authenticate, which keys to install, use and etc. The CSF is generate=
d
> +using the CST Code Signing Tool based on input configuration file. This =
tool
> +input configuration file is generated using binman, and the tool is invo=
ked
> +from binman as well.
> +
> +The SPL and fitImage sections of the generated image are signed separate=
ly.
> +The signing is activated by wrapping SPL and fitImage sections into nxp-=
imx8mcst
> +etype, by adding the following modification into the binman node:
> +

Can we avoid having to modify code to sign an image? If we add a
Kconfig then you can wrap the following changes with an ifdef.

I've run into a similar issues enabling OPTEE and was able to wrap the
entries with ifdefs with the exception of one that requires a unique
load address which I guess requires another Kconfig to solve [1]

Best Regards,

Tim
[1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891=
-1-tharvey@gateworks.com/

> +"
> +    diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u=
-boot.dtsi
> +    index c4c1a177102..ccd44bf9d0b 100644
> +    --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +    +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> +    @@ -86,6 +86,12 @@
> +            section {
> +                    pad-byte =3D <0x00>;
> +
> +    +               nxp-imx8mcst@0 {
> +    +                       filename =3D "u-boot-spl-mkimage.signed.bin"=
;
> +    +                       nxp,loader-address =3D <CONFIG_SPL_TEXT_BASE=
>;
> +    +                       nxp,unlock;
> +    +                       args;   /* Needed by mkimage etype superclas=
s */
> +    +
> +                    nxp-imx8mimage {
> +                            filename =3D "u-boot-spl-mkimage.bin";
> +                            nxp,boot-from =3D "sd";
> +    @@ -129,6 +135,14 @@
> +                            };
> +                    };
> +
> +    +               };
> +    +
> +    +               nxp-imx8mcst@1 {
> +    +                       filename =3D "u-boot-fit.signed.bin";
> +    +                       nxp,loader-address =3D <CONFIG_SPL_LOAD_FIT_=
ADDRESS>;
> +    +                       offset =3D <0x58000>;
> +    +                       args;   /* Needed by mkimage etype superclas=
s */
> +    +
> +                    fit {
> +                            description =3D "Configuration to load ATF b=
efore U-Boot";
> +     #ifndef CONFIG_IMX_HAB
> +    @@ -191,5 +205,6 @@
> +                                    };
> +                            };
> +                    };
> +    +               };
> +            };
> +     };
> +"
> +
> +Build of flash.bin target then produces a signed flash.bin automatically=
.
>
>  1.4 Closing the device
>  -----------------------
> --
> 2.43.0
>
