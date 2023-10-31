Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B47C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 09:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2114487565;
	Tue, 31 Oct 2023 10:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TYLpyf3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4D987A22; Tue, 31 Oct 2023 10:08:53 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3E2874CE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so3414938f8f.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698743330; x=1699348130; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QZSMdk7qF8KgQXghYhKJPb2JSIHAlWNQZ4Id4iUQtY=;
 b=TYLpyf3Vy1THqIv0CQ7JI/lJhWtr6nlhJx53QVP4Pl4GnlIZMWxv2OZGB6HAVc6yQp
 VEAUzmguevj0o8JlNErqkjnexk0QnjWDsBd04TbhrNbJNsprYcOW3tsHyjVibtWAUjQB
 cnjrEpwjHty5NLG7kV5PBDMidJorFhltIDvZJevoGLxo18SCm00MkeIlgyaINDzwYTK3
 GKix6TJBkMSqPGsvbmxCEtrkCywfwMry9GIMY3k+R/JjZ9mIKXnAPaImkq21d9f9Yv6o
 /q3D18MSAL5su4CZnGpazolO+I4m9dIUcKRoa7FMiLNbQUy+r9Eq0neFyf5OTsU7TJRB
 kFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698743330; x=1699348130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QZSMdk7qF8KgQXghYhKJPb2JSIHAlWNQZ4Id4iUQtY=;
 b=QFToY8ej6ejWA9abEp4CS6SpMduYIN6IkpxbfZ/fNAsX6m+kGYEoFsSyu7bIW7+1wU
 tdvrUSyoyptUCovrfM11yFPZIZ/h13OXCOgsbmiaIXrVBGTK2mtOj/zKOpkpnDKP8p+4
 7BQtshb7sruI/AlnYnIP2FtJ4WW3eyQnR5nD5zkRkx1TraPgs5XLA4Tnt366DoFY3O3j
 rAJkJKlgsNPAp+sWbhdyOxlK3iJFB36kjTvbIuu7Z8Rya3k55SemILx1DuF5mozurqhb
 VlXNos5EVIlQmg/HGTEFbVBtZrWZJpKtOHbIKvjjdZH5IajXYjtWI8tBei/cgJIsksia
 3R7Q==
X-Gm-Message-State: AOJu0YzUfU2BY2m7p0peRlCFDa0Q4lMku0FWiE5QVvxSPe1PgaQistgs
 khVYNNsi//CMiTeVISXUq2KbJjRnnWl+UQlUxgg=
X-Google-Smtp-Source: AGHT+IFgW2MWpq8S3GHhLj5zAeEKRdjHipdy3neSmrqha74G8OtPtdHB7CQ+zoQOhw8LdrfoJH9yBfk513X4tWe5lS4=
X-Received: by 2002:a05:6000:154b:b0:32f:917a:db22 with SMTP id
 11-20020a056000154b00b0032f917adb22mr1988746wry.53.1698743329934; Tue, 31 Oct
 2023 02:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231027082615.306943-1-clamor95@gmail.com>
 <CGME20231027082635epcas1p4722707057e584787327a0b2bd5fb7df0@epcas1p4.samsung.com>
 <20231027082615.306943-4-clamor95@gmail.com>
 <008a01da0bd8$43960e80$cac22b80$@samsung.com>
In-Reply-To: <008a01da0bd8$43960e80$cac22b80$@samsung.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 31 Oct 2023 11:08:38 +0200
Message-ID: <CAPVz0n2L9JiEpqQ6JzaLi9Z_-PJUxkAgsWtHRf5U9T5G1wDTvw@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] power: pmic: add the base MAX77663 PMIC support
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
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

=D0=B2=D1=82, 31 =D0=B6=D0=BE=D0=B2=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 10:5=
7 Jaehoon Chung <jh80.chung@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> > -----Original Message-----
> > From: Svyatoslav Ryhel <clamor95@gmail.com>
> > Sent: Friday, October 27, 2023 5:26 PM
> > To: Tom Rini <trini@konsulko.com>; Jaehoon Chung <jh80.chung@samsung.co=
m>; Simon Glass
> > <sjg@chromium.org>; Svyatoslav Ryhel <clamor95@gmail.com>
> > Cc: u-boot@lists.denx.de
> > Subject: [PATCH v9 3/8] power: pmic: add the base MAX77663 PMIC support
> >
> > Add support to bind the regulators/child nodes with the pmic.
> > Also adds the pmic i2c based read/write functions to access pmic
> > registers.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Just add a minor comment at below.
>
> > ---
> >  doc/device-tree-bindings/pmic/max77663.txt | 84 ++++++++++++++++++++++
> >  drivers/power/pmic/Kconfig                 |  9 +++
> >  drivers/power/pmic/Makefile                |  1 +
> >  drivers/power/pmic/max77663.c              | 81 +++++++++++++++++++++
> >  include/power/max77663.h                   | 42 +++++++++++
> >  5 files changed, 217 insertions(+)
> >  create mode 100644 doc/device-tree-bindings/pmic/max77663.txt
> >  create mode 100644 drivers/power/pmic/max77663.c
> >  create mode 100644 include/power/max77663.h
> >
> > diff --git a/doc/device-tree-bindings/pmic/max77663.txt b/doc/device-tr=
ee-bindings/pmic/max77663.txt
> > new file mode 100644
> > index 0000000000..ddb7d3eb14
> > --- /dev/null
> > +++ b/doc/device-tree-bindings/pmic/max77663.txt
> > @@ -0,0 +1,84 @@
> > +MAXIM, MAX77663 PMIC
> > +
> > +This device uses two drivers:
> > +- drivers/power/pmic/max77663.c (for parent device)
> > +- drivers/power/regulator/max77663_regulator.c (for child regulators)
> > +
> > +This chapter describes the binding info for the PMIC driver and regula=
tors.
> > +
> > +Required properties for PMIC:
> > +- compatible: "maxim,max77663"
> > +- reg: usually 0x1c or 0x3c
> > +
> > +With those two properties, the pmic device can be used for read/write =
only.
> > +To bind each regulator, the optional regulators subnode should exists.
> > +
> > +Optional subnode:
> > +- name: regulators (subnode list of each device's regulator)
> > +
> > +Regulators subnode contains set on supported regulators.
> > +
> > +Required properties:
> > +- regulator-name: used for regulator uclass platform data '.name',
> > +
> > +List of supported regulator nodes names for max77663:
> > +- sd0, sd1, sd2, sd3, ldo0, ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, =
ldo8
> > +
> > +Optional:
> > +- regulator-min-microvolt: minimum allowed Voltage to set
> > +- regulator-max-microvolt: minimum allowed Voltage to set
> > +- regulator-always-on: regulator should be never disabled
> > +- regulator-boot-on: regulator should be enabled by the bootloader
> > +
> > +Linux driver binding for this driver is compatible.
> > +
> > +Example:
> > +
> > +max77663@1c {
> > +     compatible =3D "maxim,max77663";
> > +     reg =3D <0x1c>;
> > +
> > +     regulators {
> > +             sd0 {
> > +                     regulator-name =3D "vdd_cpu";
> > +                     regulator-min-microvolt =3D <800000>;
> > +                     regulator-max-microvolt =3D <1250000>;
> > +                     regulator-always-on;
> > +                     regulator-boot-on;
> > +             };
> > +
> > +             ...
> > +
> > +             ldo0 {
> > +                     regulator-name =3D "avdd_pll";
> > +                     regulator-min-microvolt =3D <1200000>;
> > +                     regulator-max-microvolt =3D <1200000>;
> > +             };
> > +
> > +             ...
> > +
> > +             ldo2 {
> > +                     regulator-name =3D "avdd_usb";
> > +                     regulator-min-microvolt =3D <3300000>;
> > +                     regulator-max-microvolt =3D <3300000>;
> > +                     regulator-always-on;
> > +                     regulator-boot-on;
> > +             };
> > +
> > +             ldo3 {
> > +                     regulator-name =3D "vdd_sdmmc3";
> > +                     regulator-min-microvolt =3D <3000000>;
> > +                     regulator-max-microvolt =3D <3000000>;
> > +                     regulator-always-on;
> > +                     regulator-boot-on;
> > +             };
> > +
> > +             ...
> > +
> > +             ldo8 {
> > +                     regulator-name =3D "avdd_dsi_csi";
> > +                     regulator-min-microvolt =3D <1200000>;
> > +                     regulator-max-microvolt =3D <1200000>;
> > +             };
> > +     };
> > +};
> > diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> > index 4a6f0ce093..54665d7e2b 100644
> > --- a/drivers/power/pmic/Kconfig
> > +++ b/drivers/power/pmic/Kconfig
> > @@ -184,6 +184,15 @@ config SPL_DM_PMIC_PFUZE100
> >       This config enables implementation of driver-model pmic uclass fe=
atures
> >       for PMIC PFUZE100 in SPL. The driver implements read/write operat=
ions.
> >
> > +config DM_PMIC_MAX77663
> > +     bool "Enable Driver Model for PMIC MAX77663"
> > +     ---help---
> > +     This config enables implementation of driver-model pmic uclass fe=
atures
> > +     for PMIC MAX77663. The driver implements read/write operations.
> > +     This is a Power Management IC with a decent set of peripherals fr=
om which
> > +     4 DC-to-DC Step-Down (SD) Regulators, 9 Low-Dropout Linear (LDO) =
Regulators,
> > +     8 GPIOs, Real-Time Clock (RTC) and more with I2C Compatible Inter=
face.
> > +
> >  config DM_PMIC_MAX77686
> >       bool "Enable Driver Model for PMIC MAX77686"
> >       ---help---
> > diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
> > index 0b3b3d62d0..414a9d8225 100644
> > --- a/drivers/power/pmic/Makefile
> > +++ b/drivers/power/pmic/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_$(SPL_TPL_)DM_PMIC) +=3D pmic-uclass.o
> >  obj-$(CONFIG_$(SPL_)DM_PMIC_FAN53555) +=3D fan53555.o
> >  obj-$(CONFIG_$(SPL_)DM_PMIC_DA9063) +=3D da9063.o
> > +obj-$(CONFIG_$(SPL_)DM_PMIC_MAX77663) +=3D max77663.o
> >  obj-$(CONFIG_DM_PMIC_MAX77686) +=3D max77686.o
> >  obj-$(CONFIG_DM_PMIC_MAX8998) +=3D max8998.o
> >  obj-$(CONFIG_DM_PMIC_MC34708) +=3D mc34708.o
> > diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max7766=
3.c
> > new file mode 100644
> > index 0000000000..fac97ed221
> > --- /dev/null
> > +++ b/drivers/power/pmic/max77663.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> > + */
> > +
> > +#include <dm.h>
> > +#include <dm/lists.h>
> > +#include <power/pmic.h>
> > +#include <power/max77663.h>
> > +
> > +static const struct pmic_child_info pmic_children_info[] =3D {
> > +     { .prefix =3D "ldo", .driver =3D MAX77663_LDO_DRIVER },
> > +     { .prefix =3D "sd", .driver =3D MAX77663_SD_DRIVER },
> > +     { },
> > +};
> > +
> > +static int max77663_write(struct udevice *dev, uint reg, const uint8_t=
 *buff,
> > +                       int len)
> > +{
> > +     int ret;
> > +
> > +     ret =3D dm_i2c_write(dev, reg, buff, len);
> > +     if (ret) {
> > +             log_debug("write error to device: %p register: %#x!\n", d=
ev, reg);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int max77663_read(struct udevice *dev, uint reg, uint8_t *buff,=
 int len)
> > +{
> > +     int ret;
> > +
> > +     ret =3D dm_i2c_read(dev, reg, buff, len);
> > +     if (ret) {
> > +             log_debug("read error from device: %p register: %#x!\n", =
dev, reg);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int max77663_bind(struct udevice *dev)
> > +{
> > +     ofnode regulators_node;
> > +     int children;
> > +
> > +     regulators_node =3D dev_read_subnode(dev, "regulators");
> > +     if (!ofnode_valid(regulators_node)) {
> > +             log_err("%s regulators subnode not found!\n", dev->name);
> > +             return -ENXIO;
> > +     }
> > +
> > +     debug("%s: '%s' - found regulators subnode\n", __func__, dev->nam=
e);
> > +
> > +     children =3D pmic_bind_children(dev, regulators_node, pmic_childr=
en_info);
> > +     if (!children)
> > +             log_err("%s - no child found\n", dev->name);
> > +
> > +     /* Always return success for this device */
> > +     return 0;
> > +}
> > +
> > +static struct dm_pmic_ops max77663_ops =3D {
> > +     .read =3D max77663_read,
> > +     .write =3D max77663_write,
> > +};
> > +
> > +static const struct udevice_id max77663_ids[] =3D {
> > +     { .compatible =3D "maxim,max77663" },
> > +     { }
> > +};
> > +
> > +U_BOOT_DRIVER(pmic_max77663) =3D {
> > +     .name =3D "max77663_pmic",
> > +     .id =3D UCLASS_PMIC,
> > +     .of_match =3D max77663_ids,
> > +     .bind =3D max77663_bind,
> > +     .ops =3D &max77663_ops,
> > +};
> > diff --git a/include/power/max77663.h b/include/power/max77663.h
> > new file mode 100644
> > index 0000000000..0f764bcbcc
> > --- /dev/null
> > +++ b/include/power/max77663.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> > + */
> > +
> > +#ifndef _MAX77663_H_
> > +#define _MAX77663_H_
> > +
> > +#define MAX77663_LDO_NUM             9
> > +#define MAX77663_SD_NUM                      5
> > +
> > +/* Drivers name */
> > +#define MAX77663_LDO_DRIVER          "max77663_ldo"
> > +#define MAX77663_SD_DRIVER           "max77663_sd"
> > +
> > +/* Step-Down (SD) Regulator calculations */
> > +#define SD_STATUS_MASK                       0x30
> > +
> > +#define SD0_VOLT_MAX_HEX             0x40
> > +#define SD1_VOLT_MAX_HEX             0x4c
> > +#define SD_VOLT_MAX_HEX                      0xff
> > +#define SD_VOLT_MIN_HEX                      0x02
> > +
> > +#define SD0_VOLT_MAX                 1400000
> > +#define SD1_VOLT_MAX                 1550000
> > +#define SD_VOLT_MAX                  3787500
> > +#define SD_VOLT_MIN                  625000
> > +
> > +#define SD_VOLT_BASE                 600000
> > +
> > +/* Low-Dropout Linear (LDO) Regulator calculations */
> > +#define LDO_STATUS_MASK                      0xc0
> > +#define LDO_VOLT_MASK                        0x3f
> > +#define LDO_VOLT_MAX_HEX             0x3f
> > +
> > +#define LDO01_VOLT_MAX                       2375000
>
> Does it mean ldo0~1 or only ldo1?
>

0 and 1, then 4 and then the rest. They are grouped by common the
properties (max voltage and step)

Best regards,
Svyatoslav R.

> > +#define LDO4_VOLT_MAX                        1587500
> > +#define LDO_VOLT_MAX                 3950000
> > +
> > +#define LDO_VOLT_BASE                        800000
> > +
> > +#endif /* _MAX77663_H_ */
> > --
> > 2.39.2
>
>
