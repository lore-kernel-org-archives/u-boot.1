Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5830D63934
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C92895D7;
	Wed, 20 Nov 2024 13:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LVehU/PR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481C9896A6; Wed, 20 Nov 2024 13:40:49 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED3C8932B
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9ed7d8c86cso1080321766b.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732106446; x=1732711246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nxrvbXSjyp8kL+ntZgb12bDnlU5No5uA35K0hJcGqVs=;
 b=LVehU/PRdDJgRnO4FSLuueQO+/M1blzdUdXHdcTEuWR1O3YWCzQwC80olRFX1xGDgw
 0LyeWBCGQeUvhinMjOnEkrUliKTlz4IrEO82ykd09kyhHST4Byt07UkfOpkpPDdQ1GuN
 ji9epeGwolhuNdrcUHq/nsVBttOOMUrNH5k9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732106446; x=1732711246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxrvbXSjyp8kL+ntZgb12bDnlU5No5uA35K0hJcGqVs=;
 b=MlUHCI8SUSnB5CN4bnCY76bXkH7HfZI2X6YAOsf0gdBVQfRPRhynyKSC9nPczH4jgj
 ABAKy8PP4AdAaCboSov8/bMg64z2W7qASvUDcPzES5febCQXDQVDvHu6NpColh6nfJhI
 PIETkRLDZfU53wQySlNOn4ZmSfq3T+t3fa3KXQo02aY5Qz/rOMehXxOkJV7AUG8Dh8ad
 7x371p1IuG3bUhvngA50sNrWM4z6tnFhgVs8SplQc5dHVE0pBE4pBPoce9mSGqTd7fG8
 +qoy1El225Zjz65Vg8k3qjA3CFWmVDEBP9A4UkHmk/PA5X//W3WTelBWasBngNuufi5x
 ybdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc64IaZoV4UfOcEqAOw4xcnUxfc/47+Mjg11l6A37ifpeZXRgNmCIyQtpl0WZ722Hj0KzQ0vw=@lists.denx.de
X-Gm-Message-State: AOJu0YzKSURNUI1oF839F4cfj/rjQkSlo4sdts2jCONW6EP5VilEkF1F
 spsbGKwibWtosWQ9449KuXrlardT7RyhbMU732KIGoQnMUODFKCLlv+4ECkfJQ79+/qXjvgl5Qa
 7Peaxb+7re0D72lAIU3DK6RcpMFo+QIYz0zfO
X-Google-Smtp-Source: AGHT+IHTy4g4VWnXjuFW9H+cHJguV0hWroWJOc9KVdHacnDkSQ65eIDDTHLmvMdWrtcu6jmpFvUkHGPgKqcS3E2JaTw=
X-Received: by 2002:a17:906:ee86:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-aa4dd76f714mr224914366b.61.1732106446272; Wed, 20 Nov 2024
 04:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20241119195039.15177-1-mibodhi@gmail.com>
In-Reply-To: <20241119195039.15177-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 05:40:33 -0700
Message-ID: <CAFLszTjG+o=-1tr_dSf4EsOGSazRFdnSJ_VsMFR9k+vntcdRuA@mail.gmail.com>
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd for Sheevaplug board
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tony,

On Tue, 19 Nov 2024 at 12:50, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Enable bootstd for Sheevaplug board.
> Remove JFFS2 support. See JFFS2 Vulnerability[1].
> Enable LTO to keep board size within limit.
>
> [1] https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#m2fc25da1d2c019bc3cd8676991fdd64b8a21aa9b
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  configs/sheevaplug_defconfig | 16 ++--------------
>  include/configs/sheevaplug.h | 20 +++++++++++++++-----
>  2 files changed, 17 insertions(+), 19 deletions(-)

Can I suggest that you move to a test-based environment, too?

>
> diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
> index 9ac40b9e57..a7f6c73ecb 100644
> --- a/configs/sheevaplug_defconfig
> +++ b/configs/sheevaplug_defconfig
> @@ -16,16 +16,14 @@ CONFIG_ENV_OFFSET=0x80000
>  CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-sheevaplug"
>  CONFIG_SYS_LOAD_ADDR=0x800000
>  CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
> +CONFIG_LTO=y
>  CONFIG_HAS_BOARD_SIZE_LIMIT=y
>  CONFIG_BOARD_SIZE_LIMIT=524288
> +CONFIG_BOOTSTD_FULL=y
>  CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; bootm 0x6400000;"
>  CONFIG_USE_PREBOOT=y
>  # CONFIG_DISPLAY_BOARDINFO is not set
> -CONFIG_HUSH_PARSER=y
>  CONFIG_SYS_MAXARGS=32
> -CONFIG_CMD_BOOTZ=y
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set
> @@ -35,19 +33,10 @@ CONFIG_CMD_MMC=y
>  CONFIG_CMD_NAND=y
>  CONFIG_CMD_SATA=y
>  CONFIG_CMD_USB=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_CMD_JFFS2=y
>  CONFIG_CMD_MTDPARTS=y
>  CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>  CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:512K(uboot),512K(env),4M(kernel),-(rootfs)"
>  CONFIG_CMD_UBI=y
> -CONFIG_ISO_PARTITION=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_NAND=y
> @@ -68,6 +57,5 @@ CONFIG_DM_RTC=y
>  CONFIG_RTC_MV=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> -CONFIG_USB_STORAGE=y
>  CONFIG_LZMA=y
>  CONFIG_BZIP2=y
> diff --git a/include/configs/sheevaplug.h b/include/configs/sheevaplug.h
> index 4e0b3c663c..c08d29892c 100644
> --- a/include/configs/sheevaplug.h
> +++ b/include/configs/sheevaplug.h
> @@ -12,13 +12,23 @@
>
>  #include "mv-common.h"
>
> +#define KERNEL_ADDR_R  __stringify(0x800000)
> +#define FDT_ADDR_R     __stringify(0x2c00000)
> +#define RAMDISK_ADDR_R __stringify(0x01100000)
> +#define SCRIPT_ADDR_R  __stringify(0x200000)
> +
> +#define LOAD_ADDRESS_ENV_SETTINGS \
> +       "kernel_addr_r=" KERNEL_ADDR_R "\0" \
> +       "fdt_addr_r=" FDT_ADDR_R "\0" \
> +       "ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
> +       "scriptaddr=" SCRIPT_ADDR_R "\0"
>  /*
>   *  Environment variables configurations
>   */
> -#define CFG_EXTRA_ENV_SETTINGS "x_bootargs=console"    \
> -       "=ttyS0,115200 mtdparts=" CONFIG_MTDPARTS_DEFAULT       \
> -       "x_bootcmd_kernel=nand read 0x6400000 0x100000 0x400000\0" \
> -       "x_bootcmd_usb=usb start\0" \
> -       "x_bootargs_root=root=/dev/mtdblock3 rw rootfstype=jffs2\0"
> +#define CFG_EXTRA_ENV_SETTINGS \
> +       LOAD_ADDRESS_ENV_SETTINGS \
> +       "fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +       "mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
> +       "console=ttyS0,115200\0"
>
>  #endif /* _CONFIG_SHEEVAPLUG_H */
> --
> 2.39.5
>

REgards,
Simon
