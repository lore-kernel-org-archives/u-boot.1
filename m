Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B02CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4FC83FE6;
	Fri, 10 Oct 2025 13:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YFei0DUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32FE83FC1; Fri, 10 Oct 2025 13:13:29 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A09783FE6
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-639e34ffa69so2945373a12.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094806; x=1760699606; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01BhNXzf2MqrpCAMDzf/Wcl32spQY16KMyzTZ/8IoSg=;
 b=YFei0DUV+8lFwwcUfxeD60aiWkNPTFOPHB7DbMBePQlbB9/bOT34u/PLwB5md3Iuil
 QLHj/EBiMufHlqy5/A2y9j2J7b7e9TZH+Aj+ywKG/I70nj+2lCEqfTmjtJO0Qwtta3Rn
 xZ1LJmDfPAVrKn2o6dY/MAzj9+vnLKNTG37Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094806; x=1760699606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01BhNXzf2MqrpCAMDzf/Wcl32spQY16KMyzTZ/8IoSg=;
 b=D6RJPQIaEJIm/C0fdnksiEqaI+zln0IoZ5Pudu6prGEusnvo6vG78ca1R9hMN30hrz
 pNiEvGSABUkm5KGbgXgZx3iOo8diHNNvDToqjynGfKsMa9/pDohn4NniUAfFsmgzCqME
 AxTLzZukhqENZEOn4BgkclF+dExlIPFF6oXXbg0aWbc6BM9G6b1EJ9uY4baDuXR1aG9C
 Ig0YXyVVlJOB9TW2kugEsbv2wrrDje436yJUXNnGLmIiBDqxOlzVC3OmMz9GoAf3S18a
 oVRS0noag5dNlXoJcy1J/J/ULmvOBdI8dk+guESK9IdaaFHFA9nDHCzqv5pLLd5zsKb+
 I3oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn3oMa9P2TCn+LJSmsLT0N0j7LRAsM71LroAzTnLTgs3YuQZSW8SIRVBKSbiDnQr7XsdhT+Mo=@lists.denx.de
X-Gm-Message-State: AOJu0YxUQVjsdk1Wbd3KkpZutR6qggmuPjzQJnspAKiZ1673AziWonwn
 HvkJ0d+8kmv25Lqvi6YExBSZgMrseVgATrJAQg8El6UKvkXgIp5igO0rSN9afT9pbwa1AZZSA/O
 H2Ld9LcShmUhQb77K8Bwe6/e+UzgLFgOt0YZQFZUP
X-Gm-Gg: ASbGncvNmEDuyvDrAYguGo1f/TgeCNmVxi+cX00Yq8/7neByvAV50J45xJz8jJK78ye
 c0Av1WdVBh65AzT86ZAEAh5T+TyeS5jcCV/32DBSctSx6vccmvK99AK+wmlnZneWm19tdWztQ5r
 FcPd2qpCYLEFdttj0qkbrHDxoJYiFStm2cXbx6Kg0fXIDmZgTa3+kjZa9aNWZwLCxpEBdiCEerI
 Xfln39q7NMt82KOW8i7UA==
X-Google-Smtp-Source: AGHT+IHG/2n4+DmDml9gH5WFn6hZMmey07Nxj1yuvGL4J5nFdAgIEhwK7L04Vi0vt+D+HiA189gwZVnLg/oB26PhzVA=
X-Received: by 2002:a05:6402:b28:b0:634:6d87:1d28 with SMTP id
 4fb4d7f45d1cf-639d5c74a9fmr7016531a12.35.1760094806457; Fri, 10 Oct 2025
 04:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:11 +0100
X-Gm-Features: AS18NWCQjLDqFC35Ql2dWu7y5vzSlcF1gsteZtOvLPErnxGM3xI53HxSD6GaV24
Message-ID: <CAFLszTg-i7cDiN57pqat=bYwqucCOGqW6oh1CvnJz7-UhKaCwA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] boot: Add UCLASS support for extension boards
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Kory,

On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Introduce UCLASS-based extension board support to enable more
> standardized and automatic loading of extension board device tree
> overlays in preparation for integration with bootstd and pxe_utils.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  MAINTAINERS                 |   1 +
>  boot/Kconfig                |   3 +
>  boot/Makefile               |   1 +
>  boot/extension-uclass.c     | 196 ++++++++++++++++++++++++++++++++++++++=
++++++
>  cmd/Kconfig                 |   2 +-
>  cmd/extension_board.c       |  50 ++++++++++-
>  doc/usage/cmd/extension.rst |  24 +++---
>  include/dm/uclass-id.h      |   1 +
>  include/extension_board.h   |  64 +++++++++++++++
>  9 files changed, 326 insertions(+), 16 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c67d5ae9d6b..a63ffa14ef5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1187,6 +1187,7 @@ M:        Kory Maincent <kory.maincent@bootlin.com>
>  S:     Maintained
>  F:     board/sunxi/chip.c
>  F:     board/ti/common/cape_detect.c
> +F:     boot/extension-uclass.c
>  F:     boot/extension.c
>  F:     cmd/extension_board.c
>  F:     include/extension_board.h
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 62aa301f18f..159da81bec5 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1909,6 +1909,9 @@ endif # OF_LIBFDT
>  config SUPPORT_EXTENSION_SCAN
>          bool
>
> +config SUPPORT_DM_EXTENSION_SCAN
> +        bool
> +
>  config USE_BOOTARGS
>         bool "Enable boot arguments"
>         help
> diff --git a/boot/Makefile b/boot/Makefile
> index f60d13130b1..aa26070fbb8 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o bootm_os.o
>  obj-$(CONFIG_CMD_BOOTZ) +=3D bootm.o bootm_os.o
>  obj-$(CONFIG_CMD_BOOTI) +=3D bootm.o bootm_os.o
>  obj-$(CONFIG_SUPPORT_EXTENSION_SCAN) +=3D extension.o
> +obj-$(CONFIG_SUPPORT_DM_EXTENSION_SCAN) +=3D extension-uclass.o
>
>  obj-$(CONFIG_PXE_UTILS) +=3D pxe_utils.o
>
> diff --git a/boot/extension-uclass.c b/boot/extension-uclass.c
> new file mode 100644
> index 00000000000..9dfbeb60d20
> --- /dev/null
> +++ b/boot/extension-uclass.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2025 K=C3=B6ry Maincent <kory.maincent@bootlin.com>
> + */
> +
> +#include <alist.h>
> +#include <command.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <dm/uclass.h>
> +#include <env.h>
> +#include <extension_board.h>
> +#include <fdt_support.h>
> +#include <malloc.h>
> +#include <mapmem.h>

nit: Please correct the ordering

https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* For now, bind the extension device manually if none are found */
> +static struct udevice *extension_get_dev(void)

This should really return the error rather than gobbling it. Normally
we use 'int' as the return value, so:

static int extension_get_dev(struct udevice *devp)

> +{
> +       struct driver *drv =3D ll_entry_start(struct driver, driver);
> +       const int n_ents =3D ll_entry_count(struct driver, driver);
> +       struct udevice *dev;
> +       int i, ret;
> +
> +       /* These are not needed before relocation */
> +       if (!(gd->flags & GD_FLG_RELOC))
> +               return NULL;
> +
> +       uclass_first_device(UCLASS_EXTENSION, &dev);
> +       if (dev)
> +               return dev;
> +
> +       /* Create the extension device if not already bound */
> +       for (i =3D 0; i < n_ents; i++, drv++) {
> +               if (drv->id =3D=3D UCLASS_EXTENSION) {

If this is really what you want, you might as well just put a
U_BOOT_DRVINFO() declaration in the source. Then driver model does it
for you. We are supposed to use the devicetree, but it seems that that
idea is WIP at best.

> +                       char name[32];
> +
> +                       snprintf(name, sizeof(name), "%s_dev", drv->name)=
;
> +                       ret =3D device_bind_driver(gd->dm_root, drv->name=
,
> +                                                name, &dev);
> +                       if (ret) {
> +                               printf("Bind extension driver %s error=3D=
%d\n",
> +                                      drv->name, ret);
> +                               return NULL;
> +                       }
> +
> +                       ret =3D device_probe(dev);
> +                       if (ret) {
> +                               printf("Probe extension driver %s error=
=3D%d\n",
> +                                      drv->name, ret);
> +                               return NULL;
> +                       }
> +
> +                       /* We manage only one extension driver for now */
> +                       return dev;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +struct alist *dm_extension_get_list(void)
> +{
> +       struct udevice *dev =3D extension_get_dev();
> +
> +       if (!dev)
> +               return NULL;
> +
> +       return dev_get_priv(dev);
> +}
> +
> +int dm_extension_probe(struct udevice *dev)
> +{
> +       struct alist *extension_list =3D dev_get_priv(dev);
> +
> +       alist_init_struct(extension_list, struct extension);
> +       return 0;
> +}
> +
> +int dm_extension_remove(struct udevice *dev)
> +{
> +       struct alist *extension_list =3D dev_get_priv(dev);
> +
> +       alist_uninit(extension_list);
> +       return 0;
> +}
> +
> +int dm_extension_scan(void)
> +{
> +       struct alist *extension_list =3D dm_extension_get_list();
> +       struct udevice *dev =3D extension_get_dev();
> +       const struct extension_ops *ops;
> +
> +       if (!dev || !extension_list)
> +               return -ENODEV;
> +
> +       ops =3D device_get_ops(dev);

extension_get_ops()

> +       if (!ops->scan)
> +               return -ENODEV;

That is normally -ENOSYS - at this point we have a device, it's just
that it doesn't have the require method.

But it seem strange to me to allow a device that has no means to scan.

> +
> +       alist_empty(extension_list);
> +       return ops->scan(extension_list);
> +}
> +
> +static int _extension_apply(const struct extension *extension)
> +{
> +       ulong extrasize, overlay_addr;
> +       struct fdt_header *blob;
> +       char *overlay_cmd;
> +       int ret;
> +
> +       if (!working_fdt) {
> +               printf("No FDT memory address configured. Please configur=
e\n"
> +                      "the FDT address via \"fdt addr <address>\" comman=
d.\n");
> +               return -EINVAL;
> +       }
> +
> +       overlay_cmd =3D env_get("extension_overlay_cmd");
> +       if (!overlay_cmd) {
> +               printf("Environment extension_overlay_cmd is missing\n");
> +               return -EINVAL;
> +       }
> +
> +       overlay_addr =3D env_get_hex("extension_overlay_addr", 0);
> +       if (!overlay_addr) {
> +               printf("Environment extension_overlay_addr is missing\n")=
;
> +               return -EINVAL;
> +       }
> +
> +       env_set("extension_overlay_name", extension->overlay);
> +       ret =3D run_command(overlay_cmd, 0);
> +       if (ret)
> +               return ret;
> +
> +       extrasize =3D env_get_hex("filesize", 0);
> +       if (!extrasize)
> +               return -EINVAL;
> +
> +       fdt_shrink_to_minimum(working_fdt, extrasize);
> +
> +       blob =3D map_sysmem(overlay_addr, 0);
> +       if (!fdt_valid(&blob)) {
> +               printf("Invalid overlay devicetree %s\n", extension->over=
lay);
> +               return -EINVAL;
> +       }
> +
> +       /* Apply method prints messages on error */
> +       ret =3D fdt_overlay_apply_verbose(working_fdt, blob);
> +       if (ret)
> +               printf("Failed to apply overlay %s\n", extension->overlay=
);
> +
> +       return ret;
> +}
> +
> +int dm_extension_apply(int extension_num)
> +{
> +       struct alist *extension_list =3D dm_extension_get_list();
> +       const struct extension *extension;
> +
> +       if (!extension_list)
> +               return -ENODEV;

-ENODEV has a special meaning with driver model, which is that there
is no device. I think -ENOENT would be better.

> +
> +       extension =3D alist_get(extension_list, extension_num,
> +                             struct extension);
> +       if (!extension) {
> +               printf("Wrong extension number\n");
> +               return -ENODEV;

-EINVAL ?

> +       }
> +
> +       return _extension_apply(extension);
> +}
> +
> +int dm_extension_apply_all(void)
> +{
> +       struct alist *extension_list =3D dm_extension_get_list();
> +       const struct extension *extension;
> +       int ret;
> +
> +       if (!extension_list)
> +               return -ENODEV;

-ENOENT

> +
> +       alist_for_each(extension, extension_list) {
> +               ret =3D _extension_apply(extension);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +UCLASS_DRIVER(extension) =3D {
> +       .name   =3D "extension",
> +       .id     =3D UCLASS_EXTENSION,
> +};
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 986eeeba807..721bdb87c8a 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -548,7 +548,7 @@ config CMD_FDT
>  config CMD_EXTENSION
>         bool "Extension board management command"
>         select CMD_FDT
> -       depends on SUPPORT_EXTENSION_SCAN
> +       depends on SUPPORT_EXTENSION_SCAN || SUPPORT_DM_EXTENSION_SCAN
>         help
>           Enables the "extension" command, which allows to detect
>           extension boards connected to the system, and apply
> diff --git a/cmd/extension_board.c b/cmd/extension_board.c
> index 78d937ee6b6..d70394f36c7 100644
> --- a/cmd/extension_board.c
> +++ b/cmd/extension_board.c
> @@ -4,6 +4,7 @@
>   * K=C3=B6ry Maincent, Bootlin, <kory.maincent@bootlin.com>
>   */
>
> +#include <alist.h>
>  #include <exports.h>
>  #include <command.h>
>  #include <extension_board.h>
> @@ -13,9 +14,28 @@ LIST_HEAD(extension_list);
>  static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
>                              int argc, char *const argv[])
>  {
> +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
> +       struct alist *dm_extension_list;
> +#endif
>         struct extension *extension;
>         int i =3D 0;
>
> +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)

Is it possible to use if() ? Perhaps at the end of your series, when
all the conversions are done and you can delete the old code?

> +       dm_extension_list =3D dm_extension_get_list();
> +
> +       if (!alist_get_ptr(dm_extension_list, 0)) {
> +               printf("No extension registered - Please run \"extension =
scan\"\n");
> +               return CMD_RET_SUCCESS;
> +       }
> +
> +       alist_for_each(extension, dm_extension_list) {
> +               printf("Extension %d: %s\n", i++, extension->name);
> +               printf("\tManufacturer: \t\t%s\n", extension->owner);
> +               printf("\tVersion: \t\t%s\n", extension->version);
> +               printf("\tDevicetree overlay: \t%s\n", extension->overlay=
);
> +               printf("\tOther information: \t%s\n", extension->other);
> +       }
> +#else
>         if (list_empty(&extension_list)) {
>                 printf("No extension registered - Please run \"extension =
scan\"\n");
>                 return CMD_RET_SUCCESS;
> @@ -28,6 +48,7 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int=
 flag,
>                 printf("\tDevicetree overlay: \t%s\n", extension->overlay=
);
>                 printf("\tOther information: \t%s\n", extension->other);
>         }
> +#endif
>         return CMD_RET_SUCCESS;
>  }
>
> @@ -36,9 +57,19 @@ static int do_extension_scan(struct cmd_tbl *cmdtp, in=
t flag,
>  {
>         int extension_num;
>
> +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)

I'm hoping you can use if() instead of #if for all of these?

> +       extension_num =3D dm_extension_scan();
> +       if (extension_num =3D=3D -ENODEV)
> +               extension_num =3D 0;
> +       else if (extension_num < 0)
> +               return CMD_RET_FAILURE;
> +
> +       printf("Found %d extension board(s).\n", extension_num);
> +#else
>         extension_num =3D extension_scan(true);
> -       if (extension_num < 0)
> +       if (extension_num < 0 && extension_num !=3D -ENODEV)
>                 return CMD_RET_FAILURE;
> +#endif
>
>         return CMD_RET_SUCCESS;
>  }
> @@ -46,22 +77,34 @@ static int do_extension_scan(struct cmd_tbl *cmdtp, i=
nt flag,
>  static int do_extension_apply(struct cmd_tbl *cmdtp, int flag,
>                               int argc, char *const argv[])
>  {
> +#if !CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
>         struct extension *extension =3D NULL;
> -       int i =3D 0, extension_id, ret;
>         struct list_head *entry;
> +       int i =3D 0;
> +#endif
> +       int extension_id, ret;
>
>         if (argc < 2)
>                 return CMD_RET_USAGE;
>
>         if (strcmp(argv[1], "all") =3D=3D 0) {
>                 ret =3D CMD_RET_FAILURE;
> +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
> +               if (dm_extension_apply_all())
> +                       return CMD_RET_FAILURE;
> +#else
>                 list_for_each_entry(extension, &extension_list, list) {
>                         ret =3D extension_apply(extension);
>                         if (ret !=3D CMD_RET_SUCCESS)
>                                 break;
>                 }
> +#endif
>         } else {
>                 extension_id =3D simple_strtol(argv[1], NULL, 10);
> +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
> +               if (dm_extension_apply(extension_id))
> +                       return CMD_RET_FAILURE;
> +#else
>                 list_for_each(entry, &extension_list) {
>                         if (i =3D=3D extension_id) {
>                                 extension =3D list_entry(entry, struct ex=
tension,  list);
> @@ -76,9 +119,10 @@ static int do_extension_apply(struct cmd_tbl *cmdtp, =
int flag,
>                 }
>
>                 ret =3D extension_apply(extension);
> +#endif
>         }
>
> -       return ret;
> +       return CMD_RET_SUCCESS;

or just 0

>  }
>
>  static struct cmd_tbl cmd_extension[] =3D {
> diff --git a/doc/usage/cmd/extension.rst b/doc/usage/cmd/extension.rst
> index 4c261e74951..d82c3fbef0a 100644
> --- a/doc/usage/cmd/extension.rst
> +++ b/doc/usage/cmd/extension.rst
> @@ -25,9 +25,8 @@ Device Tree overlays depending on the detected extensio=
n boards.
>
>  The "extension" command comes with three sub-commands:
>
> - - "extension scan" makes the generic code call the board-specific
> -   extension_board_scan() function to retrieve the list of detected
> -   extension boards.
> + - "extension scan" makes the generic code call a board-specific extensi=
on
> +   function to retrieve the list of detected extension boards.
>
>   - "extension list" allows to list the detected extension boards.
>
> @@ -98,17 +97,18 @@ Simple extension_board_scan function example
>
>  .. code-block:: c
>
> -    int extension_board_scan(struct list_head *extension_list)
> +    static int foo_extension_board_scan(struct alist *extension_list)
>      {
> -        struct extension *extension;
> +        struct extension extension =3D {0};
>
> -        extension =3D calloc(1, sizeof(struct extension));
> -        snprintf(extension->overlay, sizeof(extension->overlay), "overla=
y.dtbo");
> -        snprintf(extension->name, sizeof(extension->name), "extension bo=
ard");
> -        snprintf(extension->owner, sizeof(extension->owner), "sandbox");
> -        snprintf(extension->version, sizeof(extension->version), "1.1");
> -        snprintf(extension->other, sizeof(extension->other), "Extension =
board information");
> -        list_add_tail(&extension->list, extension_list);
> +        snprintf(extension.overlay, sizeof(extension.overlay), "overlay.=
dtbo");
> +        snprintf(extension.name, sizeof(extension.name), "extension boar=
d");
> +        snprintf(extension.owner, sizeof(extension.owner), "sandbox");
> +        snprintf(extension.version, sizeof(extension.version), "1.1");
> +        snprintf(extension.other, sizeof(extension.other), "Extension bo=
ard information");
> +        alist_add(extension_list, extension);

This can fail, so:

if (!alist_add(...))
   return -ENOMEM

>
>          return 1;
>      }
> +
> +    U_BOOT_EXTENSION(foo_extension_name, foo_extension_board_scan);
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 6be59093160..eb6416b5917 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -63,6 +63,7 @@ enum uclass_id {
>         UCLASS_ETH,             /* Ethernet device */
>         UCLASS_ETH_PHY,         /* Ethernet PHY device */
>         UCLASS_EXTCON,          /* External Connector Class */
> +       UCLASS_EXTENSION,       /* Extension board */
>         UCLASS_FFA,             /* Arm Firmware Framework for Armv8-A */
>         UCLASS_FFA_EMUL,                /* sandbox FF-A device emulator *=
/
>         UCLASS_FIRMWARE,        /* Firmware */
> diff --git a/include/extension_board.h b/include/extension_board.h
> index 3f70416f005..78139cd7489 100644
> --- a/include/extension_board.h
> +++ b/include/extension_board.h
> @@ -8,9 +8,51 @@
>  #define __EXTENSION_SUPPORT_H
>
>  #include <linux/list.h>
> +#include <alist.h>
> +#include <dm/device.h>
>
>  extern struct list_head extension_list;
>
> +/**
> + * dm_extension_get_list - Get the extension list
> + * Return: The extension alist pointer, or NULL if no such list exists.

caller must free the list?

> + */
> +struct alist *dm_extension_get_list(void);

Is this the list of all extensions from all extension devices?

> +
> +/**
> + * dm_extension_probe - Probe extension device
> + * @dev: Extension device that needs to be probed
> + * Return: Zero on success, negative on failure.
> + */
> +int dm_extension_probe(struct udevice *dev);
> +
> +/**
> + * dm_extension_remove - Remove extension device
> + * @dev: Extension device that needs to be removed
> + * Return: Zero on success, negative on failure.
> + */
> +int dm_extension_remove(struct udevice *dev);
> +
> +/**
> + * dm_extension_scan - Scan extension boards available.
> + * Return: Zero on success, negative on failure.
> + */
> +int dm_extension_scan(void);
> +
> +/**
> + * dm_extension_apply - Apply extension board overlay to the devicetree
> + * @extension_num: Extension number to be applied
> + * Return: Zero on success, negative on failure.
> + */
> +int dm_extension_apply(int extension_num);

The uclass should have a method like apply(struct uclass *dev, int
extension_num). Is the numbering global across all devices?

> +
> +/**
> + * dm_extension_apply_all - Apply all extension board overlays to the
> + *                         devicetree
> + * Return: Zero on success, negative on failure.
> + */
> +int dm_extension_apply_all(void);
> +
>  struct extension {
>         struct list_head list;
>         char name[32];
> @@ -20,6 +62,28 @@ struct extension {
>         char other[32];
>  };

At some point in this series, please comment this struct

>
> +struct extension_ops {
> +       /**
> +        * scan - Add system-specific function to scan extension boards.
> +        * @dev: extension device to use

need to document extension_list here - I believe it is a list of
struct extension? Or is it struct extension * ?

> +        * Return: The number of extension or a negative value in case of
> +        *         error.
> +        */
> +       int (*scan)(struct alist *extension_list);

This is a bit of a strange uclass function! Since you are probing
drivers in this uclass, you can iterate through them using
uclass_foreach...() etc.

I am guessing that you just need to add a struct udevice * as the first arg=
.

> +};

We should have an extension_get_ops() and extension_scan() stub as
well, for calling this. See how other uclasses do this.

> +
> +#define U_BOOT_EXTENSION(_name, _scan_func) \
> +       U_BOOT_DRIVER(_name) =3D { \
> +               .name =3D #_name, \
> +               .id =3D UCLASS_EXTENSION, \
> +               .probe =3D dm_extension_probe, \
> +               .remove =3D dm_extension_remove, \
> +               .ops =3D &(struct extension_ops) { \
> +                      .scan =3D _scan_func, \
> +                      }, \
> +               .priv_auto =3D sizeof(struct alist), \
> +       }
> +
>  /**
>   * extension_board_scan - Add system-specific function to scan extension=
 board.
>   * @param extension_list       List of extension board information to up=
date.
>
> --
> 2.43.0
>

Regards,
Simon
