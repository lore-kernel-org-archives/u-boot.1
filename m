Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A9DC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 08:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9962888BAE;
	Sat, 20 Jul 2024 10:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="itckdAS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7129F886FF; Sat, 20 Jul 2024 10:00:39 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C3288BAE
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77e2f51496so271218166b.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721462434; x=1722067234;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yhz+xnkAma7Zb11vCdjBVlQRnaKLW1Rprc0aeKnP00=;
 b=itckdAS4PNo1gyctjgsSl/igb4LMgwdfyC4AAROk1gJ3DoAXqMMNdjPwfMpduzj6xG
 gVG8vlPDJQrV2jdxnVSiwE27tpVmL5k1jigr353CqvPf7LBG+jgZaoi3HWjg87O/odKB
 VjvCiLTiUIpmrjq+lUFbLtEEHeloYcqrRRJsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721462434; x=1722067234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yhz+xnkAma7Zb11vCdjBVlQRnaKLW1Rprc0aeKnP00=;
 b=YOkXy59AqfL6MQkGvYLyIjvOVzZRcdsYBzs1wa1tUKfEce6W+/39f6PDLVzE5jz8+P
 z85zc//WGEuva8lfG37jYeL0WxlPFV+lPnTnqjkyx4cOe+EemcrU3fD6B6GI2wZwxov3
 Z+X3s/U0JYXxZZHkgaSfdUXINitVukPhOU2jCCWYiJiiNhZs+xd5qi9aVI6ztapah+wx
 nkz5jxpPiu87kpSO8Nb4Tp/LfngG/lDTJyyH3TwDUD1+g01OeBo0d9ZraWbGrYiWtAWP
 kEfPA/eMZtEaHtRv0V05m+0H2OE7FfvWWcLZZ1K8dyR7G2MPlFXtTtziFEWHNMdhnI0L
 bSqw==
X-Gm-Message-State: AOJu0YwsvSyhuvJGJuUkbfDQFGXLIDPdf6FSDzm+VzIgSauerN+2cRHu
 3HSEFbDglJqFfP8pFi0cxkY1fyIKSzduXDofC0aMK3HY5Vgl6PNxf//mzZcoW+OcXi6QKvkYMC/
 wN5krL56p7AbEJGXbZuPAqSlkuhb82t5KBDo1Uw==
X-Google-Smtp-Source: AGHT+IGfCJtHbifB0rkPxzdHuIdXwXWqcV5sBB0IFhzmsSU27HAR00YLXYdSMoBbagKiW5RTsbwmwqyVHWmZplVvD3M=
X-Received: by 2002:a17:907:72c9:b0:a72:b803:a1ac with SMTP id
 a640c23a62f3a-a7a4c438becmr53088666b.56.1721462434022; Sat, 20 Jul 2024
 01:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-14-sjg@chromium.org>
In-Reply-To: <20240720061706.2644229-14-sjg@chromium.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 20 Jul 2024 10:00:19 +0200
Message-ID: <CAOf5uwnRiM9vY-YVqBqpeGRsYBQFBoYskCMo7vFrcFa=uFMKKQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] spl: Create a function to init spl_load_info
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Chanho Park <chanho61.park@samsung.com>, Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Maksim Kiselev <bigunclemax@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Stefano Babic <sbabic@denx.de>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Xavier Drudis Ferran <xdrudis@tinet.cat>
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

Hi

On Sat, Jul 20, 2024 at 8:20=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Rather than having every caller set this up individually, create a
> common init function. This allows new fields to be added without the
> risk of them being left uninited.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/arm/mach-imx/spl_imx_romapi.c  | 14 ++-------
>  arch/arm/mach-sunxi/spl_spi_sunxi.c |  3 +-
>  common/spl/spl_blk_fs.c             |  9 ++----
>  common/spl/spl_ext.c                |  3 +-
>  common/spl/spl_fat.c                | 10 +++----
>  common/spl/spl_mmc.c                |  4 +--
>  common/spl/spl_nand.c               |  4 +--
>  common/spl/spl_net.c                |  3 +-
>  common/spl/spl_nor.c                |  6 ++--
>  common/spl/spl_ram.c                |  3 +-
>  common/spl/spl_semihosting.c        |  4 +--
>  common/spl/spl_spi.c                |  4 +--
>  common/spl/spl_ymodem.c             |  4 +--
>  drivers/usb/gadget/f_sdp.c          |  8 ++----
>  include/spl.h                       | 44 ++++++++++++++++++++---------
>  test/image/spl_load.c               |  4 +--
>  test/image/spl_load_os.c            |  6 +---
>  17 files changed, 55 insertions(+), 78 deletions(-)
>
> diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_i=
mx_romapi.c
> index bdaea439d7f..3982f4cca18 100644
> --- a/arch/arm/mach-imx/spl_imx_romapi.c
> +++ b/arch/arm/mach-imx/spl_imx_romapi.c
> @@ -108,18 +108,13 @@ static int spl_romapi_load_image_seekable(struct sp=
l_image_info *spl_image,
>         if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) && image_get_magic(header) =
=3D=3D FDT_MAGIC) {
>                 struct spl_load_info load;
>
> -               memset(&load, 0, sizeof(load));
> -               spl_set_bl_len(&load, pagesize);
> -               load.read =3D spl_romapi_read_seekable;
> +               spl_load_init(&load, spl_romapi_read_seekable, NULL, page=
size);
>                 return spl_load_simple_fit(spl_image, &load, offset, head=
er);
>         } else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
>                    valid_container_hdr((void *)header)) {
>                 struct spl_load_info load;
>
> -               memset(&load, 0, sizeof(load));
> -               spl_set_bl_len(&load, pagesize);
> -               load.read =3D spl_romapi_read_seekable;
> -
> +               spl_load_init(&load, spl_romapi_read_seekable, NULL, page=
size);
>                 ret =3D spl_load_imx_container(spl_image, &load, offset);
>         } else {
>                 /* TODO */
> @@ -341,10 +336,7 @@ static int spl_romapi_load_image_stream(struct spl_i=
mage_info *spl_image,
>                 ss.end =3D p;
>                 ss.pagesize =3D pagesize;
>
> -               memset(&load, 0, sizeof(load));
> -               spl_set_bl_len(&load, 1);
> -               load.read =3D spl_romapi_read_stream;
> -               load.priv =3D &ss;
> +               spl_load_init(&load, spl_romapi_read_stream, &ss, 1);
>
>                 return spl_load_simple_fit(spl_image, &load, (ulong)phdr,=
 phdr);
>         }
> diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/sp=
l_spi_sunxi.c
> index d7abdc2e401..5f72e809952 100644
> --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> @@ -390,8 +390,7 @@ static int spl_spi_load_image(struct spl_image_info *=
spl_image,
>                 struct spl_load_info load;
>
>                 debug("Found FIT image\n");
> -               spl_set_bl_len(&load, 1);
> -               load.read =3D spi_load_read;
> +               spl_load_init(&load, spi_load_read, NULL, 1);
>                 ret =3D spl_load_simple_fit(spl_image, &load,
>                                           load_offset, header);
>         } else {
> diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
> index bc551c5c074..bbf90a9741e 100644
> --- a/common/spl/spl_blk_fs.c
> +++ b/common/spl/spl_blk_fs.c
> @@ -80,11 +80,8 @@ int spl_blk_load_image(struct spl_image_info *spl_imag=
e,
>                 return ret;
>         }
>
> -       load.read =3D spl_fit_read;
> -       if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
> -               spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
> -       else
> -               spl_set_bl_len(&load, 1);
> -       load.priv =3D &dev;
> +       spl_load_init(&load, spl_fit_read, &dev,
> +                     IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN) ?
> +                     ARCH_DMA_MINALIGN : 1);
>         return spl_load(spl_image, bootdev, &load, filesize, 0);
>  }
> diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> index 76f49a5a8a6..c5478820a9b 100644
> --- a/common/spl/spl_ext.c
> +++ b/common/spl/spl_ext.c
> @@ -51,8 +51,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image=
,
>                 goto end;
>         }
>
> -       spl_set_bl_len(&load, 1);
> -       load.read =3D spl_fit_read;
> +       spl_load_init(&load, spl_fit_read, NULL, 1);
>         err =3D spl_load(spl_image, bootdev, &load, filelen, 0);
>
>  end:
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index bd8aab253a9..fce451b7664 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -83,12 +83,10 @@ int spl_load_image_fat(struct spl_image_info *spl_ima=
ge,
>                 size =3D 0;
>         }
>
> -       load.read =3D spl_fit_read;
> -       if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
> -               spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
> -       else
> -               spl_set_bl_len(&load, 1);
> -       load.priv =3D (void *)filename;
> +       spl_load_init(&load, spl_fit_read, (void *)filename,
> +                     IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN) ?
> +                     ARCH_DMA_MINALIGN : 1);
> +
>         err =3D spl_load(spl_image, bootdev, &load, size, 0);
>
>  end:
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 3cb4b698f7f..22714bc4d90 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -46,9 +46,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *sp=
l_image,
>         struct blk_desc *bd =3D mmc_get_blk_desc(mmc);
>         struct spl_load_info load;
>
> -       load.priv =3D bd;
> -       spl_set_bl_len(&load, bd->blksz);
> -       load.read =3D h_spl_load_read;
> +       spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
>         ret =3D spl_load(spl_image, bootdev, &load, 0, sector << bd->log2=
blksz);
>         if (ret) {
>                 puts("mmc_load_image_raw_sector: mmc block read error\n")=
;
> diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
> index 5631fa6d563..22883f4e8b9 100644
> --- a/common/spl/spl_nand.c
> +++ b/common/spl/spl_nand.c
> @@ -71,9 +71,7 @@ static int spl_nand_load_element(struct spl_image_info =
*spl_image,
>  {
>         struct spl_load_info load;
>
> -       load.priv =3D &offset;
> -       spl_set_bl_len(&load, 1);
> -       load.read =3D spl_nand_read;
> +       spl_load_init(&load, spl_nand_read, &offset, 1);
>         return spl_load(spl_image, bootdev, &load, 0, offset);
>  }
>
> diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
> index be7278bb933..2be7b73ed35 100644
> --- a/common/spl/spl_net.c
> +++ b/common/spl/spl_net.c
> @@ -47,8 +47,7 @@ static int spl_net_load_image(struct spl_image_info *sp=
l_image,
>                 return rv;
>         }
>
> -       spl_set_bl_len(&load, 1);
> -       load.read =3D spl_net_load_read;
> +       spl_load_init(&load, spl_net_load_read, NULL, 1);
>         return spl_load(spl_image, bootdev, &load, 0, 0);
>  }
>  #endif
> diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
> index ed76b5e1293..1021d933999 100644
> --- a/common/spl/spl_nor.c
> +++ b/common/spl/spl_nor.c
> @@ -49,8 +49,7 @@ static int spl_nor_load_image(struct spl_image_info *sp=
l_image,
>                         int ret;
>
>                         debug("Found FIT\n");
> -                       spl_set_bl_len(&load, 1);
> -                       load.read =3D spl_nor_load_read;
> +                       spl_load_init(&load, spl_nor_load_read, NULL, 1);
>
>                         ret =3D spl_load_simple_fit(spl_image, &load,
>                                                   CONFIG_SYS_OS_BASE,
> @@ -93,8 +92,7 @@ static int spl_nor_load_image(struct spl_image_info *sp=
l_image,
>          * Load real U-Boot from its location in NOR flash to its
>          * defined location in SDRAM
>          */
> -       spl_set_bl_len(&load, 1);
> -       load.read =3D spl_nor_load_read;
> +       spl_load_init(&load, spl_nor_load_read, NULL, 1);
>         return spl_load(spl_image, bootdev, &load, 0, spl_nor_get_uboot_b=
ase());
>  }
>  SPL_LOAD_IMAGE_METHOD("NOR", 0, BOOT_DEVICE_NOR, spl_nor_load_image);
> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 5a23841f698..71b7a8374bb 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -69,8 +69,7 @@ static int spl_ram_load_image(struct spl_image_info *sp=
l_image,
>                 struct spl_load_info load;
>
>                 debug("Found FIT\n");
> -               spl_set_bl_len(&load, 1);
> -               load.read =3D spl_ram_load_read;
> +               spl_load_init(&load, spl_ram_load_read, NULL, 1);
>                 ret =3D spl_load_simple_fit(spl_image, &load, 0, header);
>         } else {
>                 ulong u_boot_pos =3D spl_get_image_pos();
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index 2047248f39b..f36863fe48d 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -43,9 +43,7 @@ static int spl_smh_load_image(struct spl_image_info *sp=
l_image,
>         }
>         len =3D ret;
>
> -       load.read =3D smh_fit_read;
> -       spl_set_bl_len(&load, 1);
> -       load.priv =3D &fd;
> +       spl_load_init(&load, smh_fit_read, &fd, 1);
>         ret =3D spl_load(spl_image, bootdev, &load, len, 0);
>         if (ret)
>                 log_debug("could not read %s: %d\n", filename, ret);
> diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
> index 8ab4803f7c4..691a431a926 100644
> --- a/common/spl/spl_spi.c
> +++ b/common/spl/spl_spi.c
> @@ -77,9 +77,7 @@ static int spl_spi_load_image(struct spl_image_info *sp=
l_image,
>                 return -ENODEV;
>         }
>
> -       load.priv =3D flash;
> -       spl_set_bl_len(&load, 1);
> -       load.read =3D spl_spi_fit_read;
> +       spl_load_init(&load, spl_spi_fit_read, flash, 1);
>
>  #if CONFIG_IS_ENABLED(OS_BOOT)
>         if (spl_start_uboot()) {
> diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
> index 4c7222af612..2be957134c1 100644
> --- a/common/spl/spl_ymodem.c
> +++ b/common/spl/spl_ymodem.c
> @@ -132,11 +132,9 @@ int spl_ymodem_load_image(struct spl_image_info *spl=
_image,
>                 struct ymodem_fit_info info;
>
>                 debug("Found FIT\n");
> -               load.priv =3D (void *)&info;
> -               spl_set_bl_len(&load, 1);
> +               spl_load_init(&load, ymodem_read_fit, (void *)&info, 1);
>                 info.buf =3D buf;
>                 info.image_read =3D BUF_SIZE;
> -               load.read =3D ymodem_read_fit;
>                 ret =3D spl_load_simple_fit(spl_image, &load, 0, (void *)=
buf);
>                 size =3D info.image_read;
>
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index 89496917a61..8a962c038fe 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -843,9 +843,7 @@ static int sdp_handle_in_ep(struct spl_image_info *sp=
l_image,
>                                 struct spl_load_info load;
>
>                                 debug("Found FIT\n");
> -                               load.priv =3D header;
> -                               spl_set_bl_len(&load, 1);
> -                               load.read =3D sdp_load_read;
> +                               spl_load_init(&load, sdp_load_read, heade=
r, 1);
>                                 spl_load_simple_fit(spl_image, &load, 0,
>                                                     header);
>
> @@ -856,9 +854,7 @@ static int sdp_handle_in_ep(struct spl_image_info *sp=
l_image,
>                             valid_container_hdr((void *)header)) {
>                                 struct spl_load_info load;
>
> -                               load.priv =3D header;
> -                               spl_set_bl_len(&load, 1);
> -                               load.read =3D sdp_load_read;
> +                               spl_load_init(&load, sdp_load_read, heade=
r, 1);
>                                 spl_load_imx_container(spl_image, &load, =
0);
>                                 return SDP_EXIT;
>                         }
> diff --git a/include/spl.h b/include/spl.h
> index 2f6a3e64c10..12bf308e890 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -282,28 +282,32 @@ static inline void *spl_image_fdt_addr(struct spl_i=
mage_info *info)
>  #endif
>  }
>
> +struct spl_load_info;
> +
> +/**
> + * spl_load_reader() - Read from device
> + *
> + * @load: Information about the load state
> + * @offset: Offset to read from in bytes. This must be a multiple of
> + *          @load->bl_len.
> + * @count: Number of bytes to read. This must be a multiple of
> + *         @load->bl_len.
> + * @buf: Buffer to read into
> + * @return number of bytes read, 0 on error
> + */
> +typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong secto=
r,
> +                                ulong count, void *buf);
> +
>  /**
>   * Information required to load data from a device
>   *
> + * @read: Function to call to read from the device
>   * @priv: Private data for the device
>   * @bl_len: Block length for reading in bytes
> - * @read: Function to call to read from the device
>   */
>  struct spl_load_info {
> +       spl_load_reader read;
>         void *priv;
> -       /**
> -        * read() - Read from device
> -        *
> -        * @load: Information about the load state
> -        * @offset: Offset to read from in bytes. This must be a multiple=
 of
> -        *          @load->bl_len.
> -        * @count: Number of bytes to read. This must be a multiple of
> -        *         @load->bl_len.
> -        * @buf: Buffer to read into
> -        * @return number of bytes read, 0 on error
> -        */
> -       ulong (*read)(struct spl_load_info *load, ulong sector, ulong cou=
nt,
> -                     void *buf);
>  #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
>         int bl_len;
>  #endif
> @@ -328,6 +332,18 @@ static inline void spl_set_bl_len(struct spl_load_in=
fo *info, int bl_len)
>  #endif
>  }
>
> +/**
> + * spl_load_init() - Set up a new spl_load_info structure
> + */
> +static inline void spl_load_init(struct spl_load_info *load,
> +                                spl_load_reader h_read, void *priv,
> +                                uint bl_len)
> +{
> +       load->read =3D h_read;
> +       load->priv =3D priv;
> +       spl_set_bl_len(load, bl_len);
> +}
> +
>  /*
>   * We need to know the position of U-Boot in memory so we can jump to it=
. We
>   * allow any U-Boot binary to be used (u-boot.bin, u-boot-nodtb.bin,
> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> index 7cbad40ea0c..3b6206955d3 100644
> --- a/test/image/spl_load.c
> +++ b/test/image/spl_load.c
> @@ -343,9 +343,7 @@ static int spl_test_image(struct unit_test_state *uts=
, const char *test_name,
>         } else {
>                 struct spl_load_info load;
>
> -               spl_set_bl_len(&load, 1);
> -               load.priv =3D img;
> -               load.read =3D spl_test_read;
> +               spl_load_init(&load, spl_test_read, img, 1);
>                 if (type =3D=3D IMX8)
>                         ut_assertok(spl_load_imx_container(&info_read, &l=
oad,
>                                                            0));
> diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
> index 7d5fb9b07e0..dc09ba191bf 100644
> --- a/test/image/spl_load_os.c
> +++ b/test/image/spl_load_os.c
> @@ -49,9 +49,7 @@ static int spl_test_load(struct unit_test_state *uts)
>         int ret;
>         int fd;
>
> -       memset(&load, '\0', sizeof(load));
> -       spl_set_bl_len(&load, 512);
> -       load.read =3D read_fit_image;
> +       spl_load_init(&load, read_fit_image, &text_ctx, 512);
>
>         ret =3D sandbox_find_next_phase(fname, sizeof(fname), true);
>         if (ret)
> @@ -64,8 +62,6 @@ static int spl_test_load(struct unit_test_state *uts)
>         ut_asserteq(512, os_read(fd, header, 512));
>         text_ctx.fd =3D fd;
>
> -       load.priv =3D &text_ctx;
> -
>         ut_assertok(spl_load_simple_fit(&image, &load, 0, header));
>
>         return 0;
> --
> 2.34.1
>

Look straight forward with nice clean up

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
