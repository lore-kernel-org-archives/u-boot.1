Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81026CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28CA83DFE;
	Mon,  6 Oct 2025 22:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DQ1qBJy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1FB83E1B; Mon,  6 Oct 2025 22:38:54 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099B783C46
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-637dbabdb32so10680791a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783131; x=1760387931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SuVcjI7WPk9hHfG4gXi9DW9Tn5rBiS6vFkjMLoBoWYs=;
 b=DQ1qBJy2A0MZIlefsH7A6nDgkTp7F0kxqgMlOIPCYOaCN5tjnTgO6DIYDydgXaoH13
 8EsvtNAlWdpK8JQz/MKYV1hzLZfESApufTgYSExyc6PVlWIqaCeUOxbMcnbIOtgf1OCZ
 YyqAS12oH/9nZcBf0Vc1hNMCUumN4wxVFKWzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783131; x=1760387931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SuVcjI7WPk9hHfG4gXi9DW9Tn5rBiS6vFkjMLoBoWYs=;
 b=DXg/vTyfI/sakYuzX+CXB1K5Hi+TIn8rHnyOelZL5xBaYvwFsVU8Adw7mChQxhGl2h
 iBPHpb0ODwxqO9FN8Z+FppOHEXUsWo7erOBgPQ+HOBbN1K6ufo+Kp2LmuIiQq8H+GnFj
 APVCz+41iicBLAmLBz8hunlw9oEaYLkSdk3ZfBLyEmpxPNvFevBeJVQ5ECv8vfghgFYM
 2u4Nq5Hher/8Iq2cedlmExGk3IJbVhpSSmkZvBNakHdk9Q6WOnEHcfWaVsdzIztqT98o
 jGxkeaWxgP1OuG5HEZvZgM/UExxyge1O5vYX6/kgkCM8XAldBEswgSyAzyB9Uv94nhAU
 Gd2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvOMm+Slf+M0+4wRMCVmudUrNNzhPPby3tQA6AQVhdshSCvyP/9M7pY6Nmaz60BzrX5Oj8YfU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8t+vwau+Iy199SguG37N1XtsFRTnZ4XCZncfakMdGv+ez+TVp
 ITBk81oYQqW+wPvA/9xXXhe0kwY27qAaw2FOp5GtSZilJxbLv/w+bw6utkrKhx/C1xxJAQNAPyI
 h/g9qsyeOiWQUco9CJC/quzlyMKRnnHUK7A8Md7g5
X-Gm-Gg: ASbGncsZghnmG9nKaLJ1j3CjruFcfPvAg7A50zSCQEgPv0AEZwAw2MCVqhGUJy9d4j3
 BsEv0SxdZ0Y87xTLEUNj0uN6LRLFAQu7DIB5WwgpJgbgRu5DxM5P48nxIdEEuQeDGPDZ49ZgP6l
 p8awCo80IBUMTcsE0ko3Y3eT+WShAxNdvA9TWC7u46DYVOPXLWUGNKOgw1rUedww9F+MYurPaFs
 /+KiPa3W4rUso1+B/ZSbXVsJdGNuW3nSpf2CbawdRo=
X-Google-Smtp-Source: AGHT+IHyTIvCKdNrkawpWXW0JXOR/KWiMOLvT1VvlH6Rb/D3T6h6bk6bsWZO0wh1C/VcKc/bKIazXQ8qriLdGLOXTYo=
X-Received: by 2002:a05:6402:40c4:b0:634:cd66:9cdd with SMTP id
 4fb4d7f45d1cf-639348d2d54mr15990245a12.10.1759783131466; Mon, 06 Oct 2025
 13:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:38:23 -0600
X-Gm-Features: AS18NWBf_7fEPamYip6cOLv1G3OfIoLe4YGom0DOgmVm6edkmJkBBTmYwkaaLIY
Message-ID: <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Kory,

On Fri, 3 Oct 2025 at 10:34, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> Migrate TI board cape detection from legacy extension support to the
> new UCLASS-based extension board framework.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
>  arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
>  board/ti/common/cape_detect.c      | 24 +++++++++++-------------
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
> index dff4f1cf202..77f7938305b 100644
> --- a/arch/arm/mach-omap2/am33xx/Kconfig
> +++ b/arch/arm/mach-omap2/am33xx/Kconfig
> @@ -15,7 +15,7 @@ config TARGET_AM335X_EVM
>         select DM_GPIO
>         select DM_SERIAL
>         select TI_I2C_BOARD_DETECT
> -       select SUPPORT_EXTENSION_SCAN
> +       select SUPPORT_DM_EXTENSION_SCAN
>         imply CMD_DM
>         imply SPL_DM
>         imply SPL_DM_SEQ_ALIAS
> diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap2/omap5/Kconfig
> index 5394529658b..819490a8cf8 100644
> --- a/arch/arm/mach-omap2/omap5/Kconfig
> +++ b/arch/arm/mach-omap2/omap5/Kconfig
> @@ -38,7 +38,7 @@ config TARGET_AM57XX_EVM
>         select CMD_DDR3
>         select DRA7XX
>         select TI_I2C_BOARD_DETECT
> -       select SUPPORT_EXTENSION_SCAN
> +       select SUPPORT_DM_EXTENSION_SCAN
>         imply DM_THERMAL
>         imply SCSI
>         imply SPL_THERMAL
> diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
> index 7786bdda5d1..23c93964dc3 100644
> --- a/board/ti/common/cape_detect.c
> +++ b/board/ti/common/cape_detect.c
> @@ -22,7 +22,7 @@ static void sanitize_field(char *text, size_t size)
>         }
>  }
>
> -int extension_board_scan(struct list_head *extension_list)
> +static int ti_extension_board_scan(struct alist *extension_list)
>  {
>         unsigned char addr;
>         int num_capes = 0;
> @@ -31,7 +31,7 @@ int extension_board_scan(struct list_head *extension_list)
>                 struct am335x_cape_eeprom_id eeprom_header;
>                 char process_cape_part_number[17] = {'0'};
>                 char process_cape_version[5] = {'0'};
> -               struct extension *cape;
> +               struct extension cape = {0}, *_cape;
>                 struct udevice *dev;
>                 u8 cursor = 0;
>                 int ret, i;
> @@ -78,22 +78,20 @@ int extension_board_scan(struct list_head *extension_list)

I suppose that a method called scan() could be added to the uclass and
implemented by this driver.

>
>                 printf("BeagleBone Cape: %s (0x%x)\n", eeprom_header.board_name, addr);
>
> -               cape = calloc(1, sizeof(struct extension));
> -               if (!cape) {
> -                       printf("Error in memory allocation\n");
> -                       return num_capes;
> -               }
> -
> -               snprintf(cape->overlay, sizeof(cape->overlay), "%s-%s.dtbo",
> +               snprintf(cape.overlay, sizeof(cape.overlay), "%s-%s.dtbo",
>                          process_cape_part_number, process_cape_version);
> -               strlcpy(cape->name, eeprom_header.board_name,
> +               strlcpy(cape.name, eeprom_header.board_name,
>                         sizeof(eeprom_header.board_name));
> -               strlcpy(cape->version, process_cape_version,
> +               strlcpy(cape.version, process_cape_version,
>                         sizeof(process_cape_version));
> -               strlcpy(cape->owner, eeprom_header.manufacturer,
> +               strlcpy(cape.owner, eeprom_header.manufacturer,
>                         sizeof(eeprom_header.manufacturer) + 1);
> -               list_add_tail(&cape->list, extension_list);
> +               _cape = alist_add(extension_list, cape);
> +               if (!_cape)
> +                       return -ENOMEM;
>                 num_capes++;
>         }
>         return num_capes;
>  }
> +
> +U_BOOT_EXTENSION(cape, ti_extension_board_scan);

Can the extension information go in the devicetree, so boards can
select their scheme that way?

>
> --
> 2.43.0
>

Regards.
So,pm
