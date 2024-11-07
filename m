Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30582D5D67D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 17:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645D5881A2;
	Thu,  7 Nov 2024 18:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="BeC7Vbx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B275882BA7; Thu,  7 Nov 2024 18:43:07 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF5B881A2
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 18:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ea7c26e195so14196367b3.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 09:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1731001384; x=1731606184; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akmg6ATJD3kJThSzBm1ds51ZjVmuhMWD4iVTd2vjc90=;
 b=BeC7Vbx0W66FNb74y7Mcpec6GQdPkJ3Bhrzga7RCgGIx+N6cpbViC5ac8bAs1su0kD
 zvwUWeOLbK5t/FVfJHFGops4uNrWhIURIvRmnO1G2MuVKsyftfGcnE3IPYnFX07svflY
 aSKnbAugBoIJElcunp3PCtrXkGZezWPdSfICdeWcgotaUBvKbs2FTkiVAVWvG7SbmgHk
 gmnUSVzjwgLvRKVhqytbzFfM7t4cfz8nrE9bNOF+Ql0KxOYjaX41CHXy2m4aj5+bXJOW
 qX7OMIBR88zAPJrfDJBWJIdnZDygrn7mSGJSqYcYa3AE4noEgEhNCw4XgpGdJj6GFtQh
 m2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731001384; x=1731606184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akmg6ATJD3kJThSzBm1ds51ZjVmuhMWD4iVTd2vjc90=;
 b=dY40sQgCDxHfIzBBl0doQcldCmkS8CkqF7EcQResrEvkzzwA7K2r7y5hI0TsgqyR8k
 nqaSNoNVcQh+IjBY0hDz2jz9GTeoJBQpsvjXQQBK7OZOZLtuYhucnKE/w09kYnITzCC1
 4t5RUI/L0xn0rEnVOqzSVm2z7dFIx4KJBSZfKb2eZoKvXrqSEDkDmGcVQ8hOC2i5bu/s
 I0UJraTuHZwgoYhJWbQlJewPDykhEqH8vHlA7jJNpAsg/wpQh8+hidDGLV/wbz3ODg9x
 FBs+gzbBq8LmxGIWd7CyAVnVMZYTMOCSTUOuqxCK7VaJ7M5LM9D28f3Sw2snres1+Hke
 sugg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN9rPoP+G/KiZRfvfmHPq9507fzPyI70TBp05i3fc83bDnLtzRTencYRg+KssjgN4vcfL/lyo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0fSRFzxzTlPKNAKTajyqg2EpSXfSQXUDE7HIpbzEBQ9oR0A0h
 NhfBg3iZjfTw/qbml+lqY1Tj3/A9H2jiFAXAA1Q7YdEAUp0BAJ5eKWagny5kC2qNE2UhRutirFs
 y1gYvEGQLGMBY97a1zzLZj5zlwUYU87f4hA4hWQ==
X-Google-Smtp-Source: AGHT+IEXgD+Tkg++Jj7iVkafCkfxX6G4BPjaZ/hTE3EbEGBg8fbqBbYoxlS6XBR2lLi7beKTy0yHb7eBKR70WSr0nVM=
X-Received: by 2002:a05:690c:6405:b0:6e2:413:f19 with SMTP id
 00721157ae682-6eadaf9ec1emr12187157b3.27.1731001383750; Thu, 07 Nov 2024
 09:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 7 Nov 2024 09:42:52 -0800
Message-ID: <CAJ+vNU2=QyLw_hjfjR_vk8xmk2s4Y7wfXfHbyzuqhynfVpw4Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm: imx8m: add OP-TEE node
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Manuel Traut <manut@mecka.net>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Thu, Nov 7, 2024 at 12:24=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> Add tee node in SoC u-boot device trees. Use a kconfig entry to specify
> load and entry addresses for the op-tee image in the respective
> defconfig.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/dts/imx8mn-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/dts/imx8mp-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/mach-imx/imx8m/Kconfig |  8 ++++++++
>  4 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index d31bc822532..ecc2319279e 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -164,6 +164,21 @@
>                                         };
>  #endif
>
> +                                       tee: tee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "tee";
> +                                               arch =3D "arm64";
> +                                               compression =3D "none";
> +                                               os =3D "tee";
> +                                               load =3D <CONFIG_IMX8M_OP=
TEE_LOAD_ADDR>;
> +                                               entry =3D <CONFIG_IMX8M_O=
PTEE_LOAD_ADDR>;
> +
> +                                               tee-os {
> +                                                       filename =3D "tee=
.bin";
> +                                                       optional;
> +                                               };
> +                                       };
> +

Hi Yannic,

Thanks for working on this.

Don't you need to protect this block with an #ifdef
CONFIG_IMX8M_OPTEE_LOAD_ADDR? I would expect binman to fail if it
doesn't find tee.bin and has an empty load/entry address.

Also, when I attempted this patch some time ago it was accepted but
failed CI which is something I never had time to figure out and
address. The failure had something to do with adding the Kconfig and
you should be able to find the discussion with a pointer to the
failure in your references above.

Did you make sure CI passes?

Best Regards,

Tim

>                                         binman_fip: fip {
>                                                 arch =3D "arm64";
>                                                 compression =3D "none";
> @@ -192,7 +207,7 @@
>                                                 fdt =3D "fdt-SEQ";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 6875c6d44ff..f9108cb75c7 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -235,6 +235,21 @@
>                                         };
>  #endif
>
> +                                       tee: tee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "tee";
> +                                               arch =3D "arm64";
> +                                               compression =3D "none";
> +                                               os =3D "tee";
> +                                               load =3D <CONFIG_IMX8M_OP=
TEE_LOAD_ADDR>;
> +                                               entry =3D <CONFIG_IMX8M_O=
PTEE_LOAD_ADDR>;
> +
> +                                               tee-os {
> +                                                       filename =3D "tee=
.bin";
> +                                                       optional;
> +                                               };
> +                                       };
> +
>                                         binman_fip: fip {
>                                                 arch =3D "arm64";
>                                                 compression =3D "none";
> @@ -263,7 +278,7 @@
>                                                 fdt =3D "fdt-SEQ";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot=
.dtsi
> index 56749ccacd2..9ede98a11e4 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -185,6 +185,21 @@
>                                         };
>  #endif
>
> +                                       tee: tee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "tee";
> +                                               arch =3D "arm64";
> +                                               compression =3D "none";
> +                                               os =3D "tee";
> +                                               load =3D <CONFIG_IMX8M_OP=
TEE_LOAD_ADDR>;
> +                                               entry =3D <CONFIG_IMX8M_O=
PTEE_LOAD_ADDR>;
> +
> +                                               tee-os {
> +                                                       filename =3D "tee=
.bin";
> +                                                       optional;
> +                                               };
> +                                       };
> +
>                                         @fdt-SEQ {
>                                                 description =3D "NAME";
>                                                 type =3D "flat_dt";
> @@ -204,7 +219,7 @@
>                                                 fdt =3D "fdt-SEQ";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };
> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kc=
onfig
> index b254a50b091..14f14db6a35 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -37,6 +37,14 @@ config SYS_HAS_ARMV8_SECURE_BASE
>           If enabled, please also define the value for ARMV8_SECURE_BASE,
>           for i.MX8M, it could be some address in OCRAM.
>
> +config IMX8M_OPTEE_LOAD_ADDR
> +       hex "Load address of OPTEE image"
> +       default 0x56000000
> +       help
> +         The load and entry address for the OPTEE image. This value defa=
ults to
> +         0x56000000 if not provided in the board defconfig file.
> +
> +
>  choice
>         prompt "NXP i.MX8M board select"
>         optional
>
> --
> 2.43.0
>
