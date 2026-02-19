Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE99AE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C753B83D2E;
	Thu, 19 Feb 2026 14:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gD+XUBl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC6983E76; Thu, 19 Feb 2026 14:11:36 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D2B83CF2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65808bb859cso1058618a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506688; cv=none;
 d=google.com; s=arc-20240605;
 b=HI7OG+MjC018XS+WjW1tGz28gnon/9RdL8Kb1HZOOvw70lqzycif7TqUAjE4o2B1M9
 DVLt+lTmCYgZDGq2Oyq3jnIV4krawK1QO4VjG4Ue9NG2d3mxVtS3Q+j1f0EMksFrCALH
 3/mV93Pbm8mB7BOBIEQV6H78ozDuIP9h2Wype9QBZEDofPOzZdcfTVtW3vvW0fOXELP4
 Gshpjx/d6UmWeHtMCJJdZgdutnzUlR1O+1kaqbR172NS9XdaAPaTCcq0zKGhANUYU1vd
 JLfTncGKqxlfLOyOlpE4g1HKe86ATRkRWOu5uwMMIW35fKnaDhXX12/CCImH9He+7lyW
 hvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9iKFDIbUi/1yS5mnTz1erKr9/I/xp8/d37gOfqbVrMU=;
 fh=kEdMW50BavKSH/Q9ISVZzVKPqpodRV5rvoRpMQfBTD4=;
 b=YGW/QBvcJSNSM0XRotSzamckpJNltUzU5HtUh+xT89iXyfbHdtQWJ+resfQGlL6bx7
 SuamNPKlY64MoI55nplqGc+9z/QeD7meHWcRHm/vrm8lxUgGI50yYSVy4CuAnM5JFCFC
 vDbME1jYt4hJgMmNeX49l5ySpyKWmPY9yyJZFIh7pJlpm5/8QSrcJrerxZ+2hwk0sUJR
 UzSZ7BzM91mXViavWIWA9/ZpahOM+ahO12LP0F+bHhOS5S/xtush9Ydg2gJq4rZWkwrJ
 /IAwku+nn4JUfKNHjPI8nUYMfmfGKNydgzAq+g2UuXj+jQJAgTt0LGC+g4MU5kzFAUw1
 XyWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506688; x=1772111488; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iKFDIbUi/1yS5mnTz1erKr9/I/xp8/d37gOfqbVrMU=;
 b=gD+XUBl1M78rpFmBQupOxMN0dmoLJbVI5inrWKnYzivON0mI5BobzH5rZUGa+q2+Zu
 qOEGIz1iyIae77Vit5YlOpYb+SLFjrpuN5fMbOgphwtn/A6AAF5MvYst6+IreoSFMGSU
 wm5Mi9g6t4hZdmikjlLmyTGs5AObcBqnrozFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506688; x=1772111488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9iKFDIbUi/1yS5mnTz1erKr9/I/xp8/d37gOfqbVrMU=;
 b=Owp3aB6XtCfFJ7bEpXJj6B5/PCenDzRFcCoVNBQx+eT4p7JQ9xHBVz67KfTfH5uhY+
 6oSxhZFwaDff+SBnj9usymMdldZg8XvkzlotmwBeOTVbxMr7DB/4Dg/oJj3CLST6SbYx
 qTH91ylyWLaI8/JR+unG0zFXc/cVTSLDiEQ2Hpdo0IY8BxYY+EjuPgTfHeSvyGU5kJv2
 S2J9WoDJVWVqs762suiXv+JsTOpvYFR1AMeaT4W7ug0ZaC3T71PnQspzUBNNQwatvdeN
 RZ4mb63MoL/opGKdyxBeZS/4X3I4yG8dEEdGrY62fDHbR15LapXCAm6V9LPFXycIhFcr
 nTNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8bJujc6BFGGPEr/YjTGmBTKThUoJExr+rdcZRJ13xxOkxnWnXaVWDX3sU69iQXhNbo/Z91vU=@lists.denx.de
X-Gm-Message-State: AOJu0YypJqmoJ52Le0LPm5KrHFelKT9UVKanHVHOHxTGu6LvnHWUrUiC
 fGml7p2RugM5ErYJcAQP7flKCkR2g+1GH1cZ8cbdZ9tF4JEZ53oVA+qnufBauTuJZJDklr7WLuD
 luhDgC4fjkOIqbHwQ5s8VHu630H5J84Q0XLdXihPF
X-Gm-Gg: AZuq6aI05Iam+eOnV7KgiVyuKyWm0BjxEQayaFY4P9WHC4pWsQrQKMaSrVTkPPuiMSE
 GYYs69o3VKlfKt0Ion82hZkre0mtqiBeEOQSuQi84AeJKASq3t6XFljPAVUylpjmIOhGrKgh/Tx
 4Shj6H6Lw5Z5bzj89/kYYVkV7m6k3QmqsnjZjCHwqidrr67ft6hfubsVFlnxxVVKfzjE5pmgfCv
 U3x/NVkWqmfoEk9hGINp0qdm3J+hW0OYU+4uXCQkoW00RA+RAsFxo8mcKmMUp4c6MFt2Iq1Yzue
 xD+b29DV0BNIKmNa
X-Received: by 2002:a05:6402:42ce:b0:65a:4209:f83b with SMTP id
 4fb4d7f45d1cf-65bb13c1463mr9231522a12.29.1771506687448; Thu, 19 Feb 2026
 05:11:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <5b30234322e3efdc4efb4c1e2b312418bc3e90a4.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <5b30234322e3efdc4efb4c1e2b312418bc3e90a4.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:25 -0700
X-Gm-Features: AaiRm53g1xOh-dt90sfXA5O5FkNf_4d-DAwrYWSf0fQpOxSwTQbI1mXhIPAnCO8
Message-ID: <CAFLszTh6daFP2ia=3OLWjgNgxW4p9rNkKL4iG2rNMV33wXQrLg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/20] cmd: bootm: accept storage device as image
 source
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Extend the bootm command to accept a storage device type keyword as
> the first argument:
>
>     bootm mmc <dev>:<part>    - boot from MMC/SD/eMMC partition
>     bootm mtd <name>          - boot from MTD partition
>     bootm ubi <volume>        - boot from UBI volume
>
> When a known device-type keyword is found, an image_loader is
> constructed using the corresponding backend and stored in
> images.loader. The rest of the bootm flow proceeds unchanged:
> boot_get_kernel() uses image_loader_map() for format detection and
> FDT structure loading, then fit_image_load() uses the on-demand
> storage path for sub-image data.
>
> If the first argument does not match a device-type keyword (i.e. it
> looks like a hex address, or is absent), images.loader remains NULL
> and the existing in-memory path is taken -- full backward compatibility.
>
> The #config suffix follows the same convention as existing bootm FIT
> config selection. Multiple # suffixes can be chained to select a
> base config and one or more device-tree overlays:
>
>     bootm mmc 0:4#config-1#overlay-wifi#overlay-lcd
>     bootm mtd firmware#config-1
>
> Gated by CONFIG_BOOTM_STORAGE.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig    |  13 +++++
>  boot/bootm.c    |  62 +++++++++++++++++---
>  cmd/bootm.c     | 148 ++++++++++++++++++++++++++++++++++++++++++++++--
>  include/bootm.h |   2 +
>  4 files changed, 212 insertions(+), 13 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 89832014af6..1f870c7d251 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1211,6 +1211,19 @@ config IMAGE_LOADER_UBI
>           framework. Auto-attaches the UBI device from the device tree
>           if not already attached.
>
> +config BOOTM_STORAGE
> +       bool "Allow bootm to load images directly from storage"
> +       depends on CMDLINE && FIT && IMAGE_LOADER
> +       help
> +         Extends the bootm command to accept "mmc <dev>:<part>",
> +         "mtd <name>", or "ubi <volume>" as the image source instead
> +         of a RAM address. Sub-images (kernel, FDT, ramdisk, etc.)
> +         are loaded from storage on demand; filesystem sub-images are
> +         never read.
> +
> +         Requires at least one IMAGE_LOADER backend to be enabled
> +         (IMAGE_LOADER_BLK, IMAGE_LOADER_MTD, or IMAGE_LOADER_UBI).
> +
>  config DISTRO_DEFAULTS
>         bool "(deprecated) Script-based booting of Linux distributions"
>         select CMDLINE
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 4bdca22ea8c..67d161f6e3a 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -13,6 +13,7 @@
>  #include <env.h>
>  #include <errno.h>
>  #include <fdt_support.h>
> +#include <image-loader.h>
>  #include <irq_func.h>
>  #include <lmb.h>
>  #include <log.h>
> @@ -146,7 +147,22 @@ static int boot_get_kernel(const char *addr_fit, str=
uct bootm_headers *images,
>
>         /* check image type, for FIT images get FIT kernel node */
>         *os_data =3D *os_len =3D 0;
> -       buf =3D map_sysmem(img_addr, 0);
> +       if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader) {
> +               /*
> +                * Storage path: read enough bytes to detect the image
> +                * format. genimg_get_kernel_addr_fit() above still
> +                * parsed any #config / :subimage suffix so the FIT
> +                * selection variables are populated.
> +                */
> +               buf =3D image_loader_map(images->loader, 0, 64);
> +               if (!buf) {
> +                       puts("Cannot read image header from storage\n");
> +                       return -EIO;
> +               }
> +               img_addr =3D map_to_sysmem(buf);
> +       } else {
> +               buf =3D map_sysmem(img_addr, 0);
> +       }
>         switch (genimg_get_format(buf)) {
>  #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
>         case IMAGE_FORMAT_LEGACY:
> @@ -192,6 +208,20 @@ static int boot_get_kernel(const char *addr_fit, str=
uct bootm_headers *images,
>  #endif
>  #if CONFIG_IS_ENABLED(FIT)
>         case IMAGE_FORMAT_FIT:
> +               if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader) {
> +                       /*
> +                        * Extend the mapping to cover the full FIT
> +                        * FDT structure so all metadata is accessible.
> +                        */
> +                       size_t fdt_sz =3D fdt_totalsize(buf);
> +
> +                       buf =3D image_loader_map(images->loader, 0, fdt_s=
z);
> +                       if (!buf) {
> +                               puts("Cannot read FIT header from storage=
\n");
> +                               return -ENOMEM;
> +                       }
> +                       img_addr =3D map_to_sysmem(buf);
> +               }
>                 os_noffset =3D fit_image_load(images, img_addr,
>                                 &fit_uname_kernel, &fit_uname_config,
>                                 IH_ARCH_DEFAULT, IH_TYPE_KERNEL,
> @@ -991,11 +1021,21 @@ int bootm_run_states(struct bootm_info *bmi, int s=
tates)
>          * Work through the states and see how far we get. We stop on
>          * any error.
>          */
> -       if (states & BOOTM_STATE_START)
> +       if (states & BOOTM_STATE_START) {
>                 ret =3D bootm_start();
> +               /*
> +                * bootm_start() zeroes the global images struct. Restore
> +                * the loader pointer so the storage-backed path works.
> +                */
> +               if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && bmi->loader)
> +                       images->loader =3D bmi->loader;
> +       }
>
> -       if (!ret && (states & BOOTM_STATE_PRE_LOAD))
> -               ret =3D bootm_pre_load(bmi->addr_img);
> +       if (!ret && (states & BOOTM_STATE_PRE_LOAD)) {
> +               /* Pre-load verification is not applicable to storage boo=
t */
> +               if (!IS_ENABLED(CONFIG_BOOTM_STORAGE) || !images->loader)
> +                       ret =3D bootm_pre_load(bmi->addr_img);
> +       }
>
>         if (!ret && (states & BOOTM_STATE_FINDOS))
>                 ret =3D bootm_find_os(bmi->cmd_name, bmi->addr_img);
> @@ -1003,8 +1043,11 @@ int bootm_run_states(struct bootm_info *bmi, int s=
tates)
>         if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
>                 ulong img_addr;
>
> -               img_addr =3D bmi->addr_img ? hextoul(bmi->addr_img, NULL)
> -                       : image_load_addr;
> +               if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader)
> +                       img_addr =3D images->os.start;
> +               else
> +                       img_addr =3D bmi->addr_img ? hextoul(bmi->addr_im=
g, NULL)
> +                               : image_load_addr;
>                 ret =3D bootm_find_other(img_addr, bmi->conf_ramdisk,
>                                        bmi->conf_fdt);
>         }
> @@ -1097,8 +1140,13 @@ int bootm_run_states(struct bootm_info *bmi, int s=
tates)
>         }
>
>         /* Now run the OS! We hope this doesn't return */
> -       if (!ret && (states & BOOTM_STATE_OS_GO))
> +       if (!ret && (states & BOOTM_STATE_OS_GO)) {
> +               /* Release storage backend before jumping =E2=80=94 no re=
turn expected */
> +               if (IS_ENABLED(CONFIG_BOOTM_STORAGE) && images->loader)
> +                       image_loader_cleanup(images->loader);
> +
>                 ret =3D boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn)=
;
> +       }
>
>         /* Deal with any fallout */
>  err:
> diff --git a/cmd/bootm.c b/cmd/bootm.c
> index 2c5aea26d98..6c26dd8e36d 100644
> --- a/cmd/bootm.c
> +++ b/cmd/bootm.c
> @@ -12,6 +12,7 @@
>  #include <env.h>
>  #include <errno.h>
>  #include <image.h>
> +#include <image-loader.h>
>  #include <malloc.h>
>  #include <nand.h>
>  #include <asm/byteorder.h>
> @@ -132,14 +133,123 @@ static int do_bootm_subcommand(struct cmd_tbl *cmd=
tp, int flag, int argc,
>  /* bootm - boot application image from image in memory */
>  /*******************************************************************/
>
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)

Avoid #if - use if() and the toolchain will handle eliminating the code.

> +/**
> + * bootm_init_loader() - Try to parse a storage device spec from argv
> + *
> + * If argv[0] is a known device-type keyword ("mmc", "mtd", "ubi"),
> + * initialise @ldr as the corresponding backend and return the number
> + * of argv entries consumed. The optional #config[#overlay...] suffix
> + * is stripped from the device spec and returned via @conf_name.
> + *
> + * @ldr:       loader to initialise
> + * @argc:      argument count (after removing the "bootm" verb)
> + * @argv:      argument vector
> + * @conf_name: on output, points to the #config string (incl. '#') or NU=
LL
> + * Return: number of argv entries consumed (>0), 0 if no storage keyword
> + *         was found, or negative errno on init failure
> + */
> +static int bootm_init_loader(struct image_loader *ldr,
> +                            int argc, char *const argv[],
> +                            const char **conf_name)
> +{
> +       const char *devtype;
> +       char *devspec;
> +       char *hash;
> +       int ret;
> +
> +       if (argc < 2)
> +               return 0;
> +
> +       devtype =3D argv[0];
> +       devspec =3D (char *)argv[1];
> +       *conf_name =3D NULL;
> +
> +       /* Locate the first '#' =E2=80=94 its meaning depends on the back=
end */
> +       hash =3D strchr(devspec, '#');
> +
> +       if (IS_ENABLED(CONFIG_IMAGE_LOADER_BLK) &&
> +           !strcmp(devtype, "mmc")) {
> +               /*
> +                * Block device specs use '#' for partition names when no=
 ':'
> +                * precedes it (e.g. "0#kernel"). Only treat the first '#=
'
> +                * as the FIT config separator when ':' appears before it
> +                * (e.g. "0:4#config-1"), otherwise the first '#' is the
> +                * partition name and a second '#' starts the config
> +                * (e.g. "0#kernel#config-1").
> +                */
> +               char *colon =3D strchr(devspec, ':');
> +
> +               if (!(colon && hash && colon < hash) && hash)
> +                       hash =3D strchr(hash + 1, '#');
> +               if (hash) {
> +                       *conf_name =3D hash;
> +                       *hash =3D '\0';
> +               }
> +               ret =3D image_loader_init_blk(ldr, "mmc", devspec);
> +               if (hash)
> +                       *hash =3D '#';
> +       } else if (IS_ENABLED(CONFIG_IMAGE_LOADER_MTD) &&
> +                  !strcmp(devtype, "mtd")) {
> +               if (hash) {
> +                       *conf_name =3D hash;
> +                       *hash =3D '\0';
> +               }
> +               ret =3D image_loader_init_mtd(ldr, devspec);
> +               if (hash)
> +                       *hash =3D '#';
> +       } else if (IS_ENABLED(CONFIG_IMAGE_LOADER_UBI) &&
> +                  !strcmp(devtype, "ubi")) {
> +               if (hash) {
> +                       *conf_name =3D hash;
> +                       *hash =3D '\0';
> +               }
> +               ret =3D image_loader_init_ubi(ldr, devspec);
> +               if (hash)
> +                       *hash =3D '#';
> +       } else {
> +               return 0;   /* not a storage keyword */
> +       }
> +
> +       if (ret) {
> +               printf("Failed to init %s loader: %d\n", devtype, ret);
> +               return ret;
> +       }
> +
> +       return 2;   /* consumed: keyword + device-spec */
> +}
> +#endif
> +
>  int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[])
>  {
>         struct bootm_info bmi;
>         int ret;
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
> +       struct image_loader ldr =3D {};
> +       const char *conf_name =3D NULL;
> +       int consumed =3D 0;
> +#endif
>
>         /* determine if we have a sub command */
>         argc--; argv++;
> +
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
> +       /* Try storage device spec before checking for hex/subcommand */
> +       consumed =3D bootm_init_loader(&ldr, argc, argv, &conf_name);
> +       if (consumed < 0)
> +               return CMD_RET_FAILURE;
> +       if (consumed > 0) {
> +               ldr.alloc_ptr =3D image_load_addr;
> +               argc -=3D consumed;
> +               argv +=3D consumed;
> +       }
> +#endif
> +
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
> +       if (argc > 0 && !consumed) {
> +#else
>         if (argc > 0) {
> +#endif
>                 char *endp;
>
>                 hextoul(argv[0], &endp);
> @@ -156,12 +266,25 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
>         }
>
>         bootm_init(&bmi);
> -       if (argc)
> -               bmi.addr_img =3D argv[0];
> -       if (argc > 1)
> -               bmi.conf_ramdisk =3D argv[1];
> -       if (argc > 2)
> -               bmi.conf_fdt =3D argv[2];
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
> +       if (consumed > 0) {
> +               bmi.addr_img =3D conf_name;       /* "#config-1" or NULL =
*/
> +               bmi.loader =3D &ldr;
> +               if (argc > 0)
> +                       bmi.conf_ramdisk =3D argv[0];
> +               if (argc > 1)
> +                       bmi.conf_fdt =3D argv[1];
> +       } else {
> +#else
> +       {
> +#endif
> +               if (argc)
> +                       bmi.addr_img =3D argv[0];
> +               if (argc > 1)
> +                       bmi.conf_ramdisk =3D argv[1];
> +               if (argc > 2)
> +                       bmi.conf_fdt =3D argv[2];
> +       }
>
>         /* set up argc and argv[] since some OSes use them */
>         bmi.argc =3D argc;
> @@ -169,6 +292,11 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>
>         ret =3D bootm_run(&bmi);
>
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
> +       if (ldr.read)
> +               image_loader_cleanup(&ldr);
> +#endif
> +
>         return ret ? CMD_RET_FAILURE : 0;
>  }
>
> @@ -204,6 +332,14 @@ U_BOOT_LONGHELP(bootm,
>         "\taddr#<conf_uname>   - configuration specification\n"
>         "\tUse iminfo command to get the list of existing component\n"
>         "\timages and configurations.\n"
> +#endif
> +#if IS_ENABLED(CONFIG_BOOTM_STORAGE)
> +       "\nAlternatively, boot directly from a storage device:\n"
> +       "\tbootm mmc <dev>:<part>[#conf]  - boot from MMC/SD partition\n"
> +       "\tbootm mtd <name>[#conf]        - boot from MTD partition\n"
> +       "\tbootm ubi <volume>[#conf]      - boot from UBI volume\n"
> +       "\tThe #conf suffix selects a FIT configuration; additional\n"
> +       "\t#overlay suffixes select device-tree overlays.\n"
>  #endif
>         "\nSub-commands to do part of the bootm sequence.  The sub-comman=
ds "
>         "must be\n"
> diff --git a/include/bootm.h b/include/bootm.h
> index 4060cec7fc0..ebc014b3468 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -40,6 +40,7 @@ struct cmd_tbl;
>   *     boot_get_fdt() for processing, or NULL for none
>   * @boot_progress: true to show boot progress
>   * @images: images information
> + * @loader: image loader for storage-backed boot (NULL for in-memory)
>   * @cmd_name: command which invoked this operation, e.g. "bootm"
>   * @argc: Number of arguments to the command (excluding the actual comma=
nd).
>   *     This is 0 if there are no arguments
> @@ -51,6 +52,7 @@ struct bootm_info {
>         const char *conf_fdt;
>         bool boot_progress;
>         struct bootm_headers *images;
> +       struct image_loader *loader;

This will probably end up being a struct udevice *

>         const char *cmd_name;
>         int argc;
>         char *const *argv;
> --
> 2.53.0

Regards,
Simon
