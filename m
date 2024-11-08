Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E0BD5C0C5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A8588B1F;
	Fri,  8 Nov 2024 14:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsL6yvLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E8F889DA; Fri,  8 Nov 2024 14:49:56 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B20E88B1F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7f3f1849849so1560576a12.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073793; x=1731678593; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yNYHPFVpKv1MDUI4fleX67IexhRVaQww6XeKamT6E0=;
 b=nsL6yvLbvypyrYC9I4ivDGBwWNP1ww+Yl6ih863UHkLMRjIi8IfTNvGUbNMR0FsCSQ
 RMzwOcVYuS1jCL+c06PoP97utkYGmAnRuDZSlxGTTMOawNi8mosyQDaXUGZred/exTNB
 rbEgoBVrtzBM7yvClTarBp9FjhM7P3/xw36/bMdsMQluTgBr1auYn2Dz6YZf5ESEzqoh
 WQW2Esi3m0wZfq7oS3VYjC4GGDTPg4q0AV81I1du8G0r0RDK7uvEViitERhhCbW5mdfe
 EIbQY4uU5dTAwB7MHj4b8rdj0v9/djfkw55GIgh3vWd6eCqiLOJuH3NZUR/LX/JLjJ1T
 q9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073793; x=1731678593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yNYHPFVpKv1MDUI4fleX67IexhRVaQww6XeKamT6E0=;
 b=swC+2Hdufa1Jilvl18HXy/L72ziQ86q8Y+bfM/COuWWpX015n6FZ/5BOC7ve81cCPQ
 F6atIvdyX3b4eK3ewnyPiuyffsz/nIcGEXUl+FadQgivFWItnwHVXF26w/8dSumWG9AX
 X671+3zSNkWEe/0Okyi/eZMvpIRIWnmt5HDjcpSvgrhGlc+cmAkYGrh5nx1JncSq/H9B
 oU/dEiNQC4JnoWn5hJ7O/ZqrBU19CKq0e32KUFoXBouubOfTEaS+qZdoa2x0571jqPE1
 KaSnQKddof6lhL01SN/JbniLuUAGITptmpmVhwp18NfgPC4f3R7lioReJHBNxw4GnBmB
 J9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxi8b4VhY1t3byiVpJKzrGtZr85bDxXzTfn+tGs8nrpuraCQ34XIcCNYvQ8WNKRxmz0NGLfVU=@lists.denx.de
X-Gm-Message-State: AOJu0YzISeGokkUB7n8PcZkWL0Lsp8ahfmTbjO6ZbZ0kFJQhlYKWQa7T
 uJi4fJjTLz+kiGWTqHI9pNRAmkO4QnZ8mS7KuP3Iw1D5u49KHb7gGVFez67tjvmZlbazjLT0oFs
 cjrDpkkUvPsfDdatQKIM2Rzc6zWg=
X-Google-Smtp-Source: AGHT+IFHxgJgLnqbajVJdw2raMEqBUpQC0BIvtioadlxBANfSc6302fneNgILIP5jpDdqAeWDWV/231OD2ae/vcbJ8s=
X-Received: by 2002:a17:90b:2ec3:b0:2e2:8fb4:502d with SMTP id
 98e67ed59e1d1-2e9b1681d9cmr4284600a91.16.1731073792529; Fri, 08 Nov 2024
 05:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-1-bbc3747a60e8@phytec.de>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 8 Nov 2024 07:49:40 -0600
Message-ID: <CAHCN7x+2XzhyERLmAaO-PVwkT6K_rcQgG-+xgTX8HaqstdZyOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm: imx8m: add OP-TEE node
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>, 
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

On Thu, Nov 7, 2024 at 2:42=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrote=
:
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

I think this would need to vary based on the platform.  I think the
addresses may be different depending on Mini, Nano and Plus and also
dependent on the available SDRAM.
> +
> +
>  choice
>         prompt "NXP i.MX8M board select"
>         optional
>
> --
> 2.43.0
>
