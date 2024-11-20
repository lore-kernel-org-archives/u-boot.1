Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DDED743CB
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 19:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488E989164;
	Wed, 20 Nov 2024 20:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4mBRh68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFACD89164; Wed, 20 Nov 2024 20:39:18 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77D58925A
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 20:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso94616a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732131555; x=1732736355; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrbl/a+dHtKybLr6KROZCrfEcdziNmhgX+SytHP9mZQ=;
 b=B4mBRh68ZEA7lGXMLK0dO7EfAyJtU97YPPlg/pWQoD7VjSBMKppzqItxESJP+r5qQQ
 fFqOconEfGXGZt+GJqW6myKagrqxXC6ERmrnpl4buuBgWbsaSaVipFiqVbvmpVNW5TEt
 0Nm5Sa+wkU1CzP9Y4sdA2J47gz/A7P8Pk7whTNfulUzcH0fkYK8QzS7JIfYCN6oDzel+
 /RAX93G7zN3FG1YHks1t3jySYM9KdnqttZCtIyI8PIpbTUzzBoUjfe7F3PHN4K3dpkz0
 uSXpL6KDQ8VQm6GiLPPXfQ560JslUx4kxn/N5Q60IIskLSd1h9lCRBd8iqrBHjwQLzzK
 ZtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732131555; x=1732736355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrbl/a+dHtKybLr6KROZCrfEcdziNmhgX+SytHP9mZQ=;
 b=YsR5Ox+H6Z69iSwh4Yd3Gtf4aACJsuMkWDE19SePDXUGop5kc+aCeHcguZhIGShJd1
 uZYe3M3eHTFYsMW+ls+vc8vwN9D9NPV3dxz7HlqoV8T2IbdwHEUR6C3SpAb2XYPoletu
 G+Wts1iiiyHpr04/36PTjLshZJG9RJk0ml2AIrzEbF6QL6iMPOSrO/76KqBThb57o0dD
 lN6rL+sBKj5X7OforKWAGFdlmyXiwju8TN6dCbNli3GPuYIlwLnBySANHl61hvICiyLe
 3jDkdy8kMKUC3IxTIwk2NR3jjYjPWk8rpWks/hnS5jEtT6WNsJpebNL6bgw95l2BIR82
 kA8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAy5mpl8rkFGSKAVzlv8p850EibXQSlrbWfOKdTVMAiZOMCU/dNtI4F1Bhg10KHsW6uekEQO0=@lists.denx.de
X-Gm-Message-State: AOJu0YzJ2ZucVB7SXJc5797Tg5VCXux8rRfO53yo2FNFbN7t3H8P7DCn
 iPg9d9r57DGjIUqiiIzrzTMihJ112+nqqwceLr2LHFKf7n7Tp3gB5XPDTS9SByZnTlGpIPGVxZl
 IPmhVaDRArTHUqVAefMjzl+7RIQc=
X-Google-Smtp-Source: AGHT+IFohkxcjJ/ilyQYU20mCQUihbTTlO7VKQR6xd56WAcXJxAPliLPWKlXNBzuKH+GN6gaauhHF6IExweca9NhTrY=
X-Received: by 2002:a05:6402:13d0:b0:5cf:e5e3:e0b8 with SMTP id
 4fb4d7f45d1cf-5cff4c4822dmr3275010a12.17.1732131554454; Wed, 20 Nov 2024
 11:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20241119195039.15177-1-mibodhi@gmail.com>
 <CAFLszTjG+o=-1tr_dSf4EsOGSazRFdnSJ_VsMFR9k+vntcdRuA@mail.gmail.com>
In-Reply-To: <CAFLszTjG+o=-1tr_dSf4EsOGSazRFdnSJ_VsMFR9k+vntcdRuA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 20 Nov 2024 11:39:02 -0800
Message-ID: <CAJaLiFxWYwR203y2REi0sNP0Ho1ZhQq-4cWcCm2og7mV7PRKYw@mail.gmail.com>
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd for Sheevaplug board
To: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Simon,

On Wed, Nov 20, 2024 at 4:40=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tony,
>
> On Tue, 19 Nov 2024 at 12:50, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Enable bootstd for Sheevaplug board.
> > Remove JFFS2 support. See JFFS2 Vulnerability[1].
> > Enable LTO to keep board size within limit.
> >
> > [1] https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-ca=
t/T/#m2fc25da1d2c019bc3cd8676991fdd64b8a21aa9b
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  configs/sheevaplug_defconfig | 16 ++--------------
> >  include/configs/sheevaplug.h | 20 +++++++++++++++-----
> >  2 files changed, 17 insertions(+), 19 deletions(-)
>
> Can I suggest that you move to a test-based environment, too?

Did you mean a "text-based environment" as in
board/<vendor>/<board>/<CONFIG_SYS_BOARD>.env ?

If yes, I have not tried it but my impression from my past reading is
that we need to repeat the bootcmd (bootcmd=3Dbootflow scan -lb) and
other boot #define's in the .env file. In that case the
include/confis/sheevaplug.h can be removed. I recall reading this
conversation here in the ML from way past. It'll be easier to maintain
and I'm all for it!

Is there a good example somewhere in the u-boot source tree? i.e. any
other envs that could be useful for bootstd should be in there too.

All the best,
Tony


>
> >
> > diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfi=
g
> > index 9ac40b9e57..a7f6c73ecb 100644
> > --- a/configs/sheevaplug_defconfig
> > +++ b/configs/sheevaplug_defconfig
> > @@ -16,16 +16,14 @@ CONFIG_ENV_OFFSET=3D0x80000
> >  CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/kirkwood-sheevaplug"
> >  CONFIG_SYS_LOAD_ADDR=3D0x800000
> >  CONFIG_IDENT_STRING=3D"\nMarvell-Sheevaplug"
> > +CONFIG_LTO=3Dy
> >  CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
> >  CONFIG_BOARD_SIZE_LIMIT=3D524288
> > +CONFIG_BOOTSTD_FULL=3Dy
> >  CONFIG_BOOTDELAY=3D3
> > -CONFIG_USE_BOOTCOMMAND=3Dy
> > -CONFIG_BOOTCOMMAND=3D"${x_bootcmd_kernel}; setenv bootargs ${x_bootarg=
s} ${x_bootargs_root}; bootm 0x6400000;"
> >  CONFIG_USE_PREBOOT=3Dy
> >  # CONFIG_DISPLAY_BOARDINFO is not set
> > -CONFIG_HUSH_PARSER=3Dy
> >  CONFIG_SYS_MAXARGS=3D32
> > -CONFIG_CMD_BOOTZ=3Dy
> >  # CONFIG_BOOTM_PLAN9 is not set
> >  # CONFIG_BOOTM_RTEMS is not set
> >  # CONFIG_BOOTM_VXWORKS is not set
> > @@ -35,19 +33,10 @@ CONFIG_CMD_MMC=3Dy
> >  CONFIG_CMD_NAND=3Dy
> >  CONFIG_CMD_SATA=3Dy
> >  CONFIG_CMD_USB=3Dy
> > -CONFIG_CMD_DHCP=3Dy
> > -CONFIG_CMD_MII=3Dy
> > -CONFIG_CMD_PING=3Dy
> > -CONFIG_CMD_EXT2=3Dy
> > -CONFIG_CMD_EXT4=3Dy
> > -CONFIG_CMD_FAT=3Dy
> > -CONFIG_CMD_FS_GENERIC=3Dy
> > -CONFIG_CMD_JFFS2=3Dy
> >  CONFIG_CMD_MTDPARTS=3Dy
> >  CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dorion_nand"
> >  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dorion_nand:512K(uboot),512K(env)=
,4M(kernel),-(rootfs)"
> >  CONFIG_CMD_UBI=3Dy
> > -CONFIG_ISO_PARTITION=3Dy
> >  CONFIG_OF_CONTROL=3Dy
> >  CONFIG_ENV_OVERWRITE=3Dy
> >  CONFIG_ENV_IS_IN_NAND=3Dy
> > @@ -68,6 +57,5 @@ CONFIG_DM_RTC=3Dy
> >  CONFIG_RTC_MV=3Dy
> >  CONFIG_USB=3Dy
> >  CONFIG_USB_EHCI_HCD=3Dy
> > -CONFIG_USB_STORAGE=3Dy
> >  CONFIG_LZMA=3Dy
> >  CONFIG_BZIP2=3Dy
> > diff --git a/include/configs/sheevaplug.h b/include/configs/sheevaplug.=
h
> > index 4e0b3c663c..c08d29892c 100644
> > --- a/include/configs/sheevaplug.h
> > +++ b/include/configs/sheevaplug.h
> > @@ -12,13 +12,23 @@
> >
> >  #include "mv-common.h"
> >
> > +#define KERNEL_ADDR_R  __stringify(0x800000)
> > +#define FDT_ADDR_R     __stringify(0x2c00000)
> > +#define RAMDISK_ADDR_R __stringify(0x01100000)
> > +#define SCRIPT_ADDR_R  __stringify(0x200000)
> > +
> > +#define LOAD_ADDRESS_ENV_SETTINGS \
> > +       "kernel_addr_r=3D" KERNEL_ADDR_R "\0" \
> > +       "fdt_addr_r=3D" FDT_ADDR_R "\0" \
> > +       "ramdisk_addr_r=3D" RAMDISK_ADDR_R "\0" \
> > +       "scriptaddr=3D" SCRIPT_ADDR_R "\0"
> >  /*
> >   *  Environment variables configurations
> >   */
> > -#define CFG_EXTRA_ENV_SETTINGS "x_bootargs=3Dconsole"    \
> > -       "=3DttyS0,115200 mtdparts=3D" CONFIG_MTDPARTS_DEFAULT       \
> > -       "x_bootcmd_kernel=3Dnand read 0x6400000 0x100000 0x400000\0" \
> > -       "x_bootcmd_usb=3Dusb start\0" \
> > -       "x_bootargs_root=3Droot=3D/dev/mtdblock3 rw rootfstype=3Djffs2\=
0"
> > +#define CFG_EXTRA_ENV_SETTINGS \
> > +       LOAD_ADDRESS_ENV_SETTINGS \
> > +       "fdtfile=3D" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> > +       "mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
> > +       "console=3DttyS0,115200\0"
> >
> >  #endif /* _CONFIG_SHEEVAPLUG_H */
> > --
> > 2.39.5
> >
>
> REgards,
> Simon
