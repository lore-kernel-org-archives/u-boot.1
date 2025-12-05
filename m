Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2ACD374A2
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 21:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B778421A;
	Fri,  5 Dec 2025 22:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+TQfIdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DCC8421C; Fri,  5 Dec 2025 22:16:24 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45F98420D
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 22:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5942b58ac81so1860767e87.2
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 13:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764969377; x=1765574177; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2rejyuBbB6f8vY0iE5H+hHbF5pm2J22kcLd+aAX5iU=;
 b=k+TQfIdV+HJ7eyheStvWyKsCngj2QOmuk+AZ6LkSIxNw3DTjFGLDl0Wqnnj6KriOfw
 7FzqA3FZkawf92ugW+pwCyzw5OoF/R9kjcwiRnsfdEKAUVmay1T8uIHcKiro2M7xR/1u
 HOrlSL9wD/PijZGGEN5PVhOzodcC/chXJjVD+7XsVlvzjpFutXWGVo2xV3JjSulVxT1s
 wzUw+4OqYk+WJN8jcd5AMmTOyomB6RWCJqS3ltF2vjXxMMZuavfDvIBwiNOy4y0KYBEu
 NvVUCnpMWFaFzSlZaVkW7j1JwA7K7YtCafNsaoubul2p1+sPDYeYqthY5R01F0woUQ9i
 Azfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764969377; x=1765574177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2rejyuBbB6f8vY0iE5H+hHbF5pm2J22kcLd+aAX5iU=;
 b=RxO+EYFmppPOtrP8rUJ31IOf8QyhNCqjWR6Z9YnI2h7jdBogp3sIYPAX2mr5oL7T8r
 L54j0c5khZEIBIvjYEd2QibopWeawv8FNL8kDRlAVw7k8ARGrt3mO2navR2TRJsSWU81
 mqwcymlBsQvLRmLczBc+C+0XBEd+6JHHbiFYy3XQJfhRKIMaVytYswDn9ZBLIDaGRd1M
 ZH8QLemPk5pvktwjinrPk49QXLmHe8wEFCL2pvp7PfUwNPYNG8g6nBoLRc4M+PIDZTJ5
 zhGv7Qb62e9wNUjQV67S/oqR5kC/2N/WesXHsSon7RC/mU6l5RCR7ZaGVxpVSWPWaMxG
 1jbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV57NuoKhED3erIZx0Nquyc/qs0KHDLfsPtnASAoEfQrks6/EPlUwDIMMnUfCBOGfMAOypkPqE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf8FVDmZOuH7c4Kcqr+0BEhbf9yDRL2966t7lmXtZUfI9pnkih
 +9BI1qmG9vYFqbb13Je/4HRhJbEWQyVCBsMJsHlIBOr6jkb1WTeTdolte+k3ZMLAgxvPZYd5q6L
 mTnJK/B72zdiueN7UF83KWgX+OK1zGqM=
X-Gm-Gg: ASbGncsE//bt43SMOGJPFl1FPKjk4xbpHza8SQhOSHi93Zypta2nEcOCKGsd68DhQz+
 nmC5ExU67734AjhgHZNXEJmCKgbVpSOY6aenwcByiYJm9SAfekO/mGuk6HGeQkcjcXclQtv685D
 /O6ERu9pa/QBPULf3vehZJz+WML0VzfRgVuKW9QtnyGL8Edsa5SQ5Ynv3kWw7e/DDDpZSAvomGT
 0Lc/cXtg1ffQdEsIDfIGxzcmyrIlAUIcP7aTTLMfzI8tetDfz8tL/+j0AZT5GrFSeBVlszuy6nM
 KsCRbkQcbBGV6ErPM+iHLeiHdBxm7re4jmOIDg==
X-Google-Smtp-Source: AGHT+IF0Nr+YIblsPEExFtlf391mNeICQslNdQRnpQC7Ovg8YwZcx0RZMYM+/IKnLTAihRz21mM8Gitlw+m3LC4BJ/w=
X-Received: by 2002:a05:6512:b8e:b0:595:9dbc:2ed7 with SMTP id
 2adb3069b0e04-598853de408mr79715e87.43.1764969376555; Fri, 05 Dec 2025
 13:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20251203100212.78546-1-william.martin@muxen.fr>
In-Reply-To: <20251203100212.78546-1-william.martin@muxen.fr>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Dec 2025 18:16:04 -0300
X-Gm-Features: AWmQ_bn2KSfFeD_oeviSGZpl40hBnmsSPYohl3pzlZe4nqbkwPg_9eOYDcBlbtA
Message-ID: <CAOMZO5CnohMeGvxrVNhxdWQijd_LT8mNGvA8UDW1XMRwJ=Dwtg@mail.gmail.com>
Subject: Re: [PATCH v2] arm: imx: imx8m: soc: Add support for 'boot_device'
 and 'boot_instance' environment variablesAdd setup_boot_mode for imx8m
To: William MARTIN <william.martin@muxen.fr>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: herve codina <herve.codina@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi William,

The Subject line ended up super long.

On Wed, Dec 3, 2025 at 7:02=E2=80=AFAM William MARTIN <william.martin@muxen=
.fr> wrote:
>
> Some SoCs have supports for 'boot_device' and 'boot_instance' environment
> variable. Those variables help to choose the right boot media during the
> execution of the boot command.
>
> The i.MX8M SoC doesn't have support for those variables but provides
> internally all the needed information to create those variables.
>
> Fill this lack adding support for those variables in the i.MX8M SoC.


Peng/Ye Li,

Could you please help review this patch?

Thanks

>
> Signed-off-by: William MARTIN <william.martin@muxen.fr>
> ---
>  arch/arm/mach-imx/imx8m/soc.c | 67 +++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.=
c
> index 1fe083ae94f..f39f2e90e55 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -1472,6 +1472,71 @@ void reset_cpu(void)
>  #endif
>
>  #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
> +static void setup_boot_mode(void)
> +{
> +       enum boot_device dev =3D get_boot_device();
> +
> +       log_debug("setup_boot_mode =3D %u\n", dev);
> +
> +       switch (dev) {
> +       case USB_BOOT:
> +               env_set("boot_device", "usb");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case QSPI_BOOT:
> +               env_set("boot_device", "spi-nand");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case SPI_NOR_BOOT:
> +               env_set("boot_device", "nor");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case NAND_BOOT:
> +               env_set("boot_device", "nand");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case SD1_BOOT:
> +               env_set("boot_device", "sdcard");
> +               env_set("boot_instance", "1");
> +               break;
> +
> +       case SD2_BOOT:
> +               env_set("boot_device", "sdcard");
> +               env_set("boot_instance", "2");
> +               break;
> +
> +       case SD3_BOOT:
> +               env_set("boot_device", "sdcard");
> +               env_set("boot_instance", "3");
> +               break;
> +
> +       case MMC1_BOOT:
> +               env_set("boot_device", "mmc");
> +               env_set("boot_instance", "1");
> +               break;
> +
> +       case MMC2_BOOT:
> +               env_set("boot_device", "mmc");
> +               env_set("boot_instance", "2");
> +               break;
> +
> +       case MMC3_BOOT:
> +               env_set("boot_device", "mmc");
> +               env_set("boot_instance", "3");
> +               break;
> +
> +       default:
> +               env_set("boot_device", "invalid");
> +               env_set("boot_instance", "");
> +               log_err("unexpected boot mode =3D %x\n", dev);
> +               break;
> +       }
> +}
> +
>  int arch_misc_init(void)
>  {
>         if (IS_ENABLED(CONFIG_FSL_CAAM)) {
> @@ -1483,6 +1548,8 @@ int arch_misc_init(void)
>                         printf("Failed to initialize caam_jr: %d\n", ret)=
;
>         }
>
> +       setup_boot_mode();
> +
>         return 0;
>  }
>  #endif
> --
> 2.47.3
>
