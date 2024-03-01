Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C70C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 16:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53B98272A;
	Fri,  1 Mar 2024 17:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="1N8dDDTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6EC88153; Fri,  1 Mar 2024 17:08:50 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36FD8814C
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 17:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so370449666b.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709309327; x=1709914127;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG/rLVfsopSlrx+Z/6PPg/0XUIy8Dzdeg+EdBr7cUUY=;
 b=1N8dDDTS7V3kZ+8pbd4Oiy1V07+CVwsu1c6MnUYeno4veKe+nlf5Bz9ZI/Gm1H++gx
 DoIMxX0Q97JQ7I7Fmg1naTMgApwNFOLaZbp/Tu9i3heLd6L8NpsAwv/igTibwC8b7VOK
 QlEgNciUVCxqH3lBdZ5MgjkXxy4/isFTjb78FqMQ7WR9R18CzGdx20/Ivl/BpIoiklWq
 iJX9D3MbrmLaI96ctt4mb7uKpsKkWTU8hzMwcfjsDocWu1k/CJnM2hK5hzv9R8//IRGF
 IYF942V17N090YOdvmOFGBLFGwWqidVqxgcYsmiAXyaGHCjDPS8kA4RRaiMInMQWNOKe
 oMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709309327; x=1709914127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG/rLVfsopSlrx+Z/6PPg/0XUIy8Dzdeg+EdBr7cUUY=;
 b=TX4UHYRa21aJ5sAWJSduRShoxSfaw7it/QrUaxqUuoblIqmYZdrvL3LSlO2dSWW6gy
 PuxbmghECXZ/gPTXY/Bb3Bu2AH2sL2pyjxS9El1XxUpBUqhxX3dE2d0QNJdahtsWy60q
 cANQT+d0ht0+cGYX0pkAoUvZMR5fGu9loBtM97luZiwkTt1JpfxjiRpdjdvblnONM/3Q
 imlygAhY/UQgxqHCftzWYPC4a6WMjwl4v2fXaucNBj6c+2kHzZ0ysuoo2mm7lAl6t+Ir
 5Uiej4b3L75zgV5CiJxr7u0jkOdNvLNBLEsMvpRL0i34YA9ubAIfRw8cG7t7GIduyWvn
 7fSg==
X-Gm-Message-State: AOJu0YxppGqhCu+JvEFjAJftRNQTAkUjpYMbitywpS2G13aBkrOHzOYR
 sfPsMhce0L+Y1B2TzeuFn8e/vyAthjSTNdcv9nQjeg6qAQFiLPMd5tST/zhVdLEBGINUH6iDkL5
 yst5zvoXPiXudSexGlQ9KgRT2iHLoCVxbf93vWQ==
X-Google-Smtp-Source: AGHT+IFSawngVm2SlC4Rml8NUwhd4xcrybCEjAAaHLB3bexjN8XAqnPSn0pe+OBe98L5bqnAxRlca2HWKSNRNkRrGn8=
X-Received: by 2002:a17:906:3798:b0:a3f:bd94:4d80 with SMTP id
 n24-20020a170906379800b00a3fbd944d80mr1531812ejc.76.1709309327204; Fri, 01
 Mar 2024 08:08:47 -0800 (PST)
MIME-Version: 1.0
References: <ZeHDVr-Bzm935-5N@mecka.net>
In-Reply-To: <ZeHDVr-Bzm935-5N@mecka.net>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 1 Mar 2024 08:08:35 -0800
Message-ID: <CAJ+vNU2WcLOXY11d9zXy_deEc6kTjEGR7q-iCoURDE-FjTs9TA@mail.gmail.com>
Subject: Re: [PATCH] dts: imx8mm: Add optee entry for binman
To: Manuel Traut <manut@mecka.net>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>, 
 Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>
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

On Fri, Mar 1, 2024 at 4:00=E2=80=AFAM Manuel Traut <manut@mecka.net> wrote=
:
>
> Used to embed the OPTEE OS binary into flash.bin so it can be
> detected and loaded by trusted-firmware-arm.
>
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index 06f2f73a03..8ca4515c9f 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -130,6 +130,22 @@
>                                                 type =3D "atf-bl31";
>                                         };
>                                 };
> +
> +#ifdef CONFIG_OPTEE
> +                               optee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "firmware";
> +                                               arch =3D "arm";
> +                                               os =3D "tee";
> +                                               compression =3D "none";
> +                                               load =3D <0xbe000000>;
> +                                               entry =3D <0xbe000000>;
> +
> +                                               blob-ext {
> +                                                               filename =
=3D "tee.bin";
> +                                               };
> +                               };
> +#endif
>  #endif
>
>                                 binman_fip: fip {
> @@ -160,7 +176,11 @@
>                                         fdt =3D "fdt-SEQ";
>                                         firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> +#ifdef CONFIG_OPTEE
> +                                       loadables =3D "atf", "optee";
> +#else
>                                         loadables =3D "atf";
> +#endif
>  #endif
>                                 };
>                         };
> --
> 2.43.0
>

Hi Manuel,

The load/entry address of 0xbe000000 you are using is only appropriate
for a 2GiB DRAM config. You need to ensure that BL32_BASE used when
building the ATF and CFG_TZDRAM_START used when building OPTEE match
this address.

I have some documentation on this at [1] which assumes you have the
patch I added [2] to our downstream U-Boot to put the address in a
configurable variable

I submitted something similar a while back that does what your trying
to do for imx8mm/imx8mn/imx8mp via a new config variable but the
variable caused some issue [3] and needed some rework.

Could you look at that or explain to me why 0xbe000000 could work in
all DRAM size cases?

Best Regards,

Tim
[1] https://trac.gateworks.com/wiki/venice/secure_boot#OP-TEEonvenice
[2] https://github.com/Gateworks/uboot-venice/commit/0bfe0f8155dc9c4f8ec370=
c5cbdd2731b40c0c14
[3] https://lists.denx.de/pipermail/u-boot/2023-July/522513.html
