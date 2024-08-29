Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40AFC83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA37288C3E;
	Thu, 29 Aug 2024 16:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vv5C6VhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C91188C15; Thu, 29 Aug 2024 16:05:27 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BAB88B94
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d60f48a2ccso543535a91.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940322; x=1725545122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SsXvMepwcb+2NooEOdUKtrto+Ik20JOSutDAtVcaQsc=;
 b=Vv5C6VhCQGBsE5aKmGy4AtBrq3jsWQyOz+dIUnfY/PPuVIYS8NnxWtmnZwJeD9y84i
 Hp1nj3G/ByHN5pQR+pCdIwJG541EebZNEKFnGKA/w5azYE4Vu1USfoLYZ+b0Rz4SpjTu
 NgyHYNpORC4skngNdu8PZQxnnHJfId6H9lM2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940322; x=1725545122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SsXvMepwcb+2NooEOdUKtrto+Ik20JOSutDAtVcaQsc=;
 b=FT4IRVr13T0VSCgpDdPovW/VSTITcTRZjTP+4OlwgGqjUAxjske/oGH2EDMuB/d4jM
 SJp0enPQsete7idMI/Rha1/sTmrfpEOsQQ95HFsuF+T0Py+yXSUPh3uKAt6GoZSiL9h/
 2zhqw//19N3/nQnBYRgjgz0CuYbxvK1XoK6uvobRyKHXrp5xUkeERetEqtKkIqvDmthp
 OafLvt3/pUD/XRtQJCiekL1WViLkxQXtk2TWFJY+C8QxfNhEUhlLH5XlVy79xZ1O6IHN
 wddTKv+b7+4E9tXvpQLW4bH9cquC9Y8gfIk0r95SEQ3ZmL6oYFpiPaMaRQKlIkAPiF9/
 QFSA==
X-Gm-Message-State: AOJu0Yzd68bWg/2Dj3D0siC/4LzScSuBXycj62DuvPN6npijun7ktklv
 E5v9vg8DgUKX/C5b0rrn6BjVux4Tp4j6ErfI14EhfwXLFoOSUe0zFDy+VUjn0O0kZ4NeGqf2QdK
 D8IEqt3Hwm8sE/gOMXWbytM91k8WxQapX3tb6
X-Google-Smtp-Source: AGHT+IE+SGuL0LVYvTN5tSTDs6+QcraATX7xpcZiWmtnej0KrtY3HFJHrwCtO5O5bnUfV8Lhak9qs2DTU7EB/9K3bUc=
X-Received: by 2002:a05:6a20:6718:b0:1cc:e5bc:37ce with SMTP id
 adf61e73a8af0-1cce5bc39fcmr1030992637.17.1724940322236; Thu, 29 Aug 2024
 07:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-3-raymond.mao@linaro.org>
In-Reply-To: <20240816154658.1866186-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:01 -0600
Message-ID: <CAFLszTh4ZeqXacqddVEGTN+885PcEur6n0e1YUNfUYqp2A31Ew@mail.gmail.com>
Subject: Re: [PATCH 02/10] sysinfo: Add sysinfo driver and data structure for
 SMBIOS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Raymond,

On Fri, 16 Aug 2024 at 09:47, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add sysinfo interface and definitions to support SMBIOS type 0 to
> type 4.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  drivers/sysinfo/Makefile      |   1 +
>  drivers/sysinfo/smbios_plat.c | 270 ++++++++++++++++++++++++++++++++++
>  drivers/sysinfo/smbios_plat.h | 104 +++++++++++++
>  include/smbios.h              |  12 ++
>  include/sysinfo.h             |  58 +++++++-
>  lib/Makefile                  |   2 +
>  6 files changed, 446 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/sysinfo/smbios_plat.c
>  create mode 100644 drivers/sysinfo/smbios_plat.h
>
> diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
> index 680dde77fe8..3e478f87c23 100644
> --- a/drivers/sysinfo/Makefile
> +++ b/drivers/sysinfo/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
>  obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
>  obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
>  obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
> +obj-$(CONFIG_SYSINFO_SMBIOS) += smbios_plat.o
> \ No newline at end of file
> diff --git a/drivers/sysinfo/smbios_plat.c b/drivers/sysinfo/smbios_plat.c
> new file mode 100644
> index 00000000000..adbc8cf3cf2
> --- /dev/null
> +++ b/drivers/sysinfo/smbios_plat.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <dm.h>
> +#include <smbios_plat.h>
> +#include <sysinfo.h>
> +
> +struct sysinfo_plat_priv {
> +       struct sys_info *t1;
> +       struct baseboard_info *t2;
> +       struct enclosure_info *t3;
> +       struct processor_info *t4;
> +};
> +
> +/* weak function for the platforms not yet supported */
> +__weak int sysinfo_get_processor_info(struct processor_info *pinfo)
> +{
> +       return -ENOSYS;
> +}
> +
> +static int sysinfo_plat_detect(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static int sysinfo_plat_get_str(struct udevice *dev, int id,
> +                               size_t size, char *val)
> +{
> +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +       const char *str = NULL;
> +
> +       switch (id) {
> +       case SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER:
> +               str = priv->t1->manufacturer;
> +               break;
> +       case SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT:
> +               str = priv->t1->prod_name;
> +               break;
> +       case SYSINFO_ID_SMBIOS_SYSTEM_VERSION:
> +               str = priv->t1->version;
> +               break;
> +       case SYSINFO_ID_SMBIOS_SYSTEM_SERIAL:
> +               str = priv->t1->sn;
> +               break;
> +       case SYSINFO_ID_SMBIOS_SYSTEM_SKU:
> +               str = priv->t1->sku_num;
> +               break;
> +       case SYSINFO_ID_SMBIOS_SYSTEM_FAMILY:
> +               str = priv->t1->family;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER:
> +               str = priv->t2->manufacturer;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT:
> +               str = priv->t2->prod_name;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_VERSION:
> +               str = priv->t2->version;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL:
> +               str = priv->t2->sn;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG:
> +               str = priv->t2->asset_tag;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT:
> +               str = priv->t2->chassis_locat;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER:
> +               str = priv->t3->manufacturer;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION:
> +               str = priv->t3->version;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL:
> +               str = priv->t3->sn;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_ASSET_TAG:
> +               str = priv->t3->asset_tag;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_SKU:
> +               str = priv->t3->sku_num;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET:
> +               str = priv->t4->socket_design;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT:
> +               str = priv->t4->manufacturer;

This function is another example of where the devicetree would be a
much sensible solution. Otherwise every vendor has to create string
tables in the code. We have two vendors using the same SoC and they
have to have different drivers...it is just going to be a mess...

> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_VERSION:
> +               str = priv->t4->version;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_SN:
> +               str = priv->t4->sn;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG:
> +               str = priv->t4->asset_tag;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_PN:
> +               str = priv->t4->pn;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (!str)
> +               return -ENOSYS;
> +
> +       strlcpy(val, str, size);
> +
> +       return 0;
> +}
> +
> +static int sysinfo_plat_get_int(struct udevice *dev, int id, int *val)
> +{
> +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +
> +       switch (id) {
> +       case SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP:
> +               *val = priv->t1->wakeup_type;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE:
> +               *val = priv->t2->feature.data;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_TYPE:
> +               *val = priv->t2->type;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM:
> +               *val = priv->t2->objs_num;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE:
> +               *val = priv->t3->chassis_type;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP:
> +               *val = priv->t3->bootup_state;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_POW:
> +               *val = priv->t3->power_supply_state;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL:
> +               *val = priv->t3->thermal_state;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY:
> +               *val = priv->t3->security_status;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_OEM:
> +               *val = priv->t3->oem_defined;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT:
> +               *val = priv->t3->height;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM:
> +               *val = priv->t3->number_of_power_cords;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT:
> +               *val = priv->t3->element_count;
> +               break;
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN:
> +               *val = priv->t3->element_record_length;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_TYPE:
> +               *val = priv->t4->type;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE:
> +               *val = priv->t4->voltage;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK:
> +               *val = priv->t4->ext_clock;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED:
> +               *val = priv->t4->max_speed;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED:
> +               *val = priv->t4->curr_speed;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_STATUS:
> +               *val = priv->t4->status;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE:
> +               *val = priv->t4->upgrade;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT:
> +               *val = priv->t4->core_count;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN:
> +               *val = priv->t4->core_enabled;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT:
> +               *val = priv->t4->thread_count;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_CHARA:
> +               *val = priv->t4->characteristics;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2:
> +               *val = priv->t4->family2;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2:
> +               *val = priv->t4->core_count2;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2:
> +               *val = priv->t4->core_enabled2;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2:
> +               *val = priv->t4->thread_count2;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN:
> +               *val = priv->t4->thread_enabled;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sysinfo_plat_get_data(struct udevice *dev, int id, uchar **buf,
> +                                size_t *size)
> +{
> +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +
> +       switch (id) {
> +       case SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS:
> +               *buf = priv->t3->elements;
> +               *size = priv->t3->elements_size;
> +               break;
> +       case SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDLE:
> +               *buf = priv->t2->objs;
> +               *size = priv->t2->objs_size;
> +               break;
> +       case SYSINFO_ID_SMBIOS_PROCESSOR_ID:
> +               *buf = (uchar *)priv->t4->id;
> +               *size = sizeof(priv->t4->id);
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static int sysinfo_plat_probe(struct udevice *dev)
> +{
> +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +       struct sysinfo_plat *plat = dev_get_plat(dev);
> +
> +       priv->t1 = &plat->sys;
> +       priv->t2 = &plat->board;
> +       priv->t3 = &plat->chassis;
> +
> +       if (!sysinfo_get_processor_info(plat->processor))
> +               priv->t4 = plat->processor;
> +
> +       return 0;
> +}
> +
> +static const struct sysinfo_ops sysinfo_smbios_ops = {
> +       .detect = sysinfo_plat_detect,
> +       .get_str = sysinfo_plat_get_str,
> +       .get_int = sysinfo_plat_get_int,
> +       .get_data = sysinfo_plat_get_data,
> +};
> +
> +U_BOOT_DRIVER(sysinfo_smbios_plat) = {
> +       .name           = "sysinfo_smbios_plat",
> +       .id             = UCLASS_SYSINFO,
> +       .ops            = &sysinfo_smbios_ops,
> +       .priv_auto      = sizeof(struct sysinfo_plat_priv),
> +       .probe          = sysinfo_plat_probe,
> +};
> diff --git a/drivers/sysinfo/smbios_plat.h b/drivers/sysinfo/smbios_plat.h
> new file mode 100644
> index 00000000000..3576f492ecb
> --- /dev/null
> +++ b/drivers/sysinfo/smbios_plat.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef __SMBIOS_PLAT_H
> +#define __SMBIOS_PLAT_H
> +
> +#include <smbios.h>
> +
> +/*
> + * TODO:
> + * sysinfo_plat and all sub data structure should be moved to <asm/sysinfo.h>
> + * if we have this defined for each arch.
> + */
> +struct __packed sys_info {
> +       char *manufacturer;
> +       char *prod_name;
> +       char *version;
> +       char *sn;
> +       u8 wakeup_type;
> +       char *sku_num;
> +       char *family;
> +};
> +
> +struct __packed baseboard_info {
> +       char *manufacturer;
> +       char *prod_name;
> +       char *version;
> +       char *sn;
> +       char *asset_tag;
> +       union baseboard_feat feature;
> +       char *chassis_locat;
> +       u8 type;
> +       u8 objs_num;
> +       void *objs;
> +       size_t objs_size;
> +};
> +
> +struct __packed enclosure_info {
> +       char *manufacturer;
> +       char *version;
> +       char *sn;
> +       char *asset_tag;
> +       u8 chassis_type;
> +       u8 bootup_state;
> +       u8 power_supply_state;
> +       u8 thermal_state;
> +       u8 security_status;
> +       u32 oem_defined;
> +       u8 height;
> +       u8 number_of_power_cords;
> +       u8 element_count;
> +       u8 element_record_length;
> +       void *elements;
> +       size_t elements_size;
> +       char *sku_num;
> +};
> +
> +struct __packed processor_info {
> +       char *socket_design;
> +       u8 type;
> +       u8 family;
> +       char *manufacturer;
> +       u32 id[2];
> +       char *version;
> +       u8 voltage;
> +       u16 ext_clock;
> +       u16 max_speed;
> +       u16 curr_speed;
> +       u8 status;
> +       u8 upgrade;
> +       char *sn;
> +       char *asset_tag;
> +       char *pn;
> +       u8 core_count;
> +       u8 core_enabled;
> +       u8 thread_count;
> +       u16 characteristics;
> +       u16 family2;
> +       u16 core_count2;
> +       u16 core_enabled2;
> +       u16 thread_count2;
> +       u16 thread_enabled;
> +};
> +
> +struct sysinfo_plat {
> +       struct sys_info sys;
> +       struct baseboard_info board;
> +       struct enclosure_info chassis;
> +       struct processor_info *processor;
> +       /* add other sysinfo structure here */
> +};
> +
> +#if CONFIG_IS_ENABLED(SYSINFO_SMBIOS)
> +int sysinfo_get_processor_info(struct processor_info *pinfo);
> +#else
> +static inline int sysinfo_get_processor_info(struct processor_info *pinfo)
> +{
> +       return -ENOSYS;
> +}
> +#endif
> +
> +#endif /* __SMBIOS_PLAT_H */
> diff --git a/include/smbios.h b/include/smbios.h
> index 00119d7a60c..60e28a89af8 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -154,6 +154,18 @@ struct __packed smbios_type1 {
>  #define SMBIOS_BOARD_FEATURE_HOSTING   (1 << 0)
>  #define SMBIOS_BOARD_MOTHERBOARD       10
>
> +union baseboard_feat {
> +       struct {
> +               u8 hosting_board:1;
> +               u8 need_daughter_board:1;
> +               u8 removable:1;
> +               u8 replaceable:1;
> +               u8 hot_swappable:1;
> +               u8 rsvd:3;
> +       } fields;
> +       u8 data;
> +};
> +
>  struct __packed smbios_type2 {
>         u8 type;
>         u8 length;
> diff --git a/include/sysinfo.h b/include/sysinfo.h
> index 17b2b9c7111..6c9de7744c1 100644
> --- a/include/sysinfo.h
> +++ b/include/sysinfo.h
> @@ -42,18 +42,74 @@ struct udevice;
>  enum sysinfo_id {
>         SYSINFO_ID_NONE,
>
> -       /* For SMBIOS tables */
> +       /* BIOS Information (Type 0) */
> +       SYSINFO_ID_SMBIOS_BIOS_VENDOR,
> +       SYSINFO_ID_SMBIOS_BIOS_VER,
> +       SYSINFO_ID_SMBIOS_BIOS_REL_DATE,
> +
> +       /* System Information (Type 1) */
>         SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
>         SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
>         SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
>         SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> +       SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP,
>         SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>         SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
> +
> +       /* Baseboard (or Module) Information (Type 2) */
>         SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>         SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>         SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
>         SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
>         SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
> +       SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE,
> +       SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT,
> +       SYSINFO_ID_SMBIOS_BASEBOARD_TYPE,
> +       SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM,
> +       SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDLE,
> +
> +       /* System Enclosure or Chassis (Type 3) */
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_ASSET_TAG,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_POW,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_OEM,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS,
> +       SYSINFO_ID_SMBIOS_ENCLOSURE_SKU,
> +
> +       /* Processor Information (Type 4) */
> +       SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_TYPE,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_ID,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_VERSION,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_STATUS,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_SN,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_PN,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_CHARA,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2,
> +       SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN,

Just looking at the above suggests that this approach is not scalable.

>
>         /* For show_board_info() */
>         SYSINFO_ID_BOARD_MODEL,
> diff --git a/lib/Makefile b/lib/Makefile
> index 81b503ab526..1829647e83d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -42,6 +42,8 @@ obj-$(CONFIG_FIT) += fdtdec_common.o
>  obj-$(CONFIG_TEST_FDTDEC) += fdtdec_test.o
>  obj-$(CONFIG_GZIP_COMPRESSED) += gzip.o
>  obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
> +ccflags-$(CONFIG_SYSINFO_SMBIOS) += \
> +       -I$(srctree)/drivers/sysinfo
>  obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
>  obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
>  obj-y += initcall.o
> --
> 2.25.1
>

Regards,
SImon
