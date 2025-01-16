Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBBAC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 22:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC328033D;
	Thu, 16 Jan 2025 23:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="J1lrQSyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A17E8069D; Thu, 16 Jan 2025 23:45:29 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5FFB8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e53aa843a24so2822279276.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737067524; x=1737672324; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4GlBEvOvQuCotYtiwgNiSu9FQysCX1fwbDTyOp2EGY=;
 b=J1lrQSybpNsnmmvMxr8XmVk0lPB6dDdtI4fI5xqkEBhGqXE+K+tKQauZ0+TKCp18Ss
 Tv48QE7blqRIpBHf85XC6/UbsC7dAKrGwBR2jyNifbfX64Ptz4D+nX/RzAvlKJ9BoCjh
 0X6J/WLTf0R1xPZl3zfbXQlsGgQ403xXZTMDew9FPZo6IfwQ7Zbb7uixEN1ZlaiE6PGX
 sIJenowIRvBBz9I5tC35jt1FchQKMTSp7Bwoe9RJa2Oc6+yBNzHXue3R1TitbV+2TGGd
 76lB2J66yYGzlUDag6XDluEyFOMtGhNPIcc6m0KqkcZWN7CYkm17lxvqMnkCr9VByvj9
 ct/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737067524; x=1737672324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4GlBEvOvQuCotYtiwgNiSu9FQysCX1fwbDTyOp2EGY=;
 b=ZB6l4dl0KJdQecbiHQ2ZV+9IwCHvCfPEvIysKeALnWu28jmiCCdA/r451RwO8EhLqG
 6b+xbGfcCIx6dHIRdE3IpLYWV2hoV3pGFQkbuR74DCUMgLG9V0pmsydrNh4IwsnBlOGB
 S62HM2Ybc88Ontz2CIbFqAcxzXbNhF/12uBQNph4geZjEi2Of4aafLgBqcevsK09kVTS
 E17KHhdZIAW1H3TyBPvzKZYq8OCpQaUQPR2sabloOK5uezwPCRNpdnqy/RP+/5Xls61T
 HopkF5Sd1cCbA1Tt+/l6jhtNq8NDoOVsYtJ8YC+cAGsDXCmUtUdsbv75cQaLEOeI13Jv
 VO2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAAJDTug/9PWvLgzG3fwo6ZHYShhPKZrp29s3hMlv+oB1bvLp9Fk3VHlj/w1X/0vslL1dKYTk=@lists.denx.de
X-Gm-Message-State: AOJu0YxUCtkwR27ZnyuIWrh3ALNEj6azpXzyX5jQxvTk0e2pIXJwGnE4
 hXfgYoQp1WN5EpBwX3w2JL0t6kog+CNusri3N+HfTlqm5ZFlQmztwgi5rqmc8nZWez4pjxUPvqU
 vfYzkl51ioFaFs3wjJn7GAOPFYQwgOU2DeDQl7A==
X-Gm-Gg: ASbGnctELWP/KuiBbLbmICTC/8++WrclCSMuzq9TjwKjUkUuwEEqR5Ea6S7DFMrvFSh
 +p7qkKKoNUGXo6h7t/G3D4Q8ia9kzKN6c1G7sdA==
X-Google-Smtp-Source: AGHT+IGUfsl+qOyotB1cKM46us9VJ24QTu8fHX0v42SjbNn1DsSRf4BcW4ZW/XA+bDhXnM8dP0Ju5j1jVqNwFe5lBt8=
X-Received: by 2002:a25:6805:0:b0:e38:2a3b:ea58 with SMTP id
 3f1490d57ef6-e578a26f3bemr8906628276.20.1737067524573; Thu, 16 Jan 2025
 14:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
 <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 14:45:13 -0800
X-Gm-Features: AbW1kvZehEc1tpCzkrRyXCwo8QsRguLffE-zGKVd3dHBizzjrbp0524BCsEsr0Y
Message-ID: <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
To: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Manuel Traut <manut@mecka.net>, Benjamin Hahn <b.hahn@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, 
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

On Fri, Jan 10, 2025 at 4:35=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> Add tee node in SoC u-boot device trees. Use a kconfig entry to specify
> load and entry addresses for the op-tee image in the respective
> defconfig.
> Default IMX8M_OPTEE_LOAD_ADDR is supplied. To keep it simple, the same
> addresses are used for each SoC as are defined in upstream tf-a
> (BL32_BASE) [1].
>
> [1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat=
/imx/imx8m
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/dts/imx8mn-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/dts/imx8mp-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/dts/imx8mq-u-boot.dtsi | 17 ++++++++++++++++-
>  arch/arm/mach-imx/imx8m/Kconfig | 11 +++++++++++
>  5 files changed, 75 insertions(+), 4 deletions(-)
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
> index 6d80d856365..4a4498b36b0 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -240,6 +240,21 @@
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
> @@ -268,7 +283,7 @@
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
> diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot=
.dtsi
> index d7a83a78f4d..93e2ef27f7c 100644
> --- a/arch/arm/dts/imx8mq-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mq-u-boot.dtsi
> @@ -144,6 +144,21 @@
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
>                                         fdt {
>                                                 compression =3D "none";
>                                                 description =3D "NAME";
> @@ -164,7 +179,7 @@
>                                                 fdt =3D "fdt";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };

Hi Yannic,

As I mentioned before, I still don't see how this builds when tee.bin
is missing because someone isn't using tee?

It looks like Fabio has merged this already to imx/master which now
fails to build for imx8m*_venice boards because of it.

Fabio, did you realize that you merged this already and if so how does
it work for you?

Best Regards,

Tim

> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kc=
onfig
> index b254a50b091..8aeb1ea75f7 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -37,6 +37,17 @@ config SYS_HAS_ARMV8_SECURE_BASE
>           If enabled, please also define the value for ARMV8_SECURE_BASE,
>           for i.MX8M, it could be some address in OCRAM.
>
> +config IMX8M_OPTEE_LOAD_ADDR
> +       hex "Load address of OPTEE image"
> +       default 0xbe000000 if IMX8MM
> +       default 0xbe000000 if IMX8MN
> +       default 0x56000000 if IMX8MP
> +       default 0xfe000000 if IMX8MQ
> +       help
> +         The load and entry address for the OPTEE image. This value defa=
ults to
> +         the one defined in tf-a if not provided in the board defconfig =
file.
> +
> +
>  choice
>         prompt "NXP i.MX8M board select"
>         optional
>
> --
> 2.43.0
>
