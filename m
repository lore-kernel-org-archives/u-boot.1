Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4136ECF6488
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 22:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563738911B;
	Sat, 28 Sep 2024 00:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nhZVZReo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB15289036; Sat, 28 Sep 2024 00:32:01 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A288911B
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 00:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so278716266b.1
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727476317; x=1728081117; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewD3fPtFwNL8viTbTeITjW8GO7c3+LHbJkaTynw9miE=;
 b=nhZVZReodWLxasc2TpS//P1mJk2tgol9UmNOKWq3ien0HvNAk+pgcBBW4xDpTJhzja
 ovf7z6IpfvWfoQ8G7ncAp88pE1OIv7jy2tlCNKpQCbZKhJWeqn5SPDuPCAkFOtasannl
 Sr+0j2TuaiXVMkylb3mQnmmHYun4/PpyaDmuDbm/Ja8vstS6GRqTROtVRSQK4mtbYyEY
 bfAJoJkBsCZ5U/11ek16Jk/3ZiqibL3l7WbA8y0PRZNp5trS1iGctWBj6qdCJqYg/6E7
 i4aT6FpnNeCDUHGT2ApdTMXU9zYzZMpERyj672tJAe16fpOipjwZQqOOOFijuaL6Zgld
 HlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727476317; x=1728081117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewD3fPtFwNL8viTbTeITjW8GO7c3+LHbJkaTynw9miE=;
 b=GIVktqPSj4TWZGPYz0YJxqql5e42M0JL0e+UMxPt/gCKdYNy3G7Z7MbWXOgTVeSvk0
 hnBEXOlM2QoUfvK3julZayNvf3IFnnsYT02x+3cZVS2l322ub66JP0u2pbHNBO6dRa8j
 UBYlHAPbfgm46xdPamPQ9LRb1isoTLiPF6T6j0Gzb0DzqWbhXrxXixsf6HOT3yYyqpHS
 zlmja21UVBd+FrZJufvXuXaY8ZXM8tDPNxPtWBarp3Vl+Umk/QugUuj8y9071ehnTZrZ
 OHhtZ56eZsWLiLNYfpJIDZCn94hZoaEMqGdTggT/A3FL/5FbywoWwO5DUQkDgl0V4hy1
 aCqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGm4s6H1yAMApwDhh0XkLLeamq+9xsz5Uf7mnpFMWY5y22/zYQmU06ip8NzwlU4g2bFC/Y36E=@lists.denx.de
X-Gm-Message-State: AOJu0YwnBVGytXICzIzKUaMa7a8FergbFECKdBGWbQYJr9MKe8hXrHYW
 RRDmCDCMgaN23LKVIBOO7z9sSkNT4jwwUfQskH5MplQIroIEIngf1sfGZIpaAyZSnpsbZYcBuH1
 UDcABDJ8Hg/TXRBsfloGfR9FpJfo=
X-Google-Smtp-Source: AGHT+IGClPb9kbbNagWyFQJf1/xsQuREN+0KTQuhK0Y5fIIDSX7hYVTuce4RL25wadxxs9R4xRy1OBvQsNG/rbLYVVo=
X-Received: by 2002:a17:907:7e8c:b0:a8d:2ab2:c9a0 with SMTP id
 a640c23a62f3a-a93c4aae066mr392350466b.53.1727476316484; Fri, 27 Sep 2024
 15:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240905151707.59101-1-sebastian.reichel@collabora.com>
 <20240905151707.59101-3-sebastian.reichel@collabora.com>
In-Reply-To: <20240905151707.59101-3-sebastian.reichel@collabora.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Sat, 28 Sep 2024 01:31:44 +0300
Message-ID: <CALHCpMgaryXwLufJ8yz1WO0xxRw=qz-JeeNx8DRJE2BhNoJ5tA@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] usb: tcpm: fusb302: add driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, 
 Soeren Moch <smoch@web.de>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
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

=D1=87=D1=82, 5 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 18:26=
, Sebastian Reichel
<sebastian.reichel@collabora.com>:
>
> Now that the TCPM framework exists we can introduce fusb302
> driver using it. This chip is a very common USB-C controller
> chip with PD support, which can be found in the Radxa Rock 5B
> among many other boards. Apart from Power Delivery, it also
> handles detection of the cable orientation. That can be used
> to control a mux for connecting the right USB3 lane pair to
> the USB3 controller.
>
> The driver is originally from the Linux kernel, but has been
> adapted to the requirements of U-Boot and its TCPM framework.
>
> Co-developed-by: Wang Jie <dave.wang@rock-chips.com>
> Signed-off-by: Wang Jie <dave.wang@rock-chips.com>
> Tested-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/usb/tcpm/Kconfig       |    8 +
>  drivers/usb/tcpm/Makefile      |    1 +
>  drivers/usb/tcpm/fusb302.c     | 1323 ++++++++++++++++++++++++++++++++
>  drivers/usb/tcpm/fusb302_reg.h |  177 +++++
>  4 files changed, 1509 insertions(+)
>  create mode 100644 drivers/usb/tcpm/fusb302.c
>  create mode 100644 drivers/usb/tcpm/fusb302_reg.h
>
> diff --git a/drivers/usb/tcpm/Kconfig b/drivers/usb/tcpm/Kconfig
> index 55bf8e202b90..9be4b496e82f 100644
> --- a/drivers/usb/tcpm/Kconfig
> +++ b/drivers/usb/tcpm/Kconfig
> @@ -6,3 +6,11 @@ config TYPEC_TCPM
>         help
>           The Type-C Port Controller Manager provides a USB PD and USB Ty=
pe-C
>           state machine for use with Type-C Port Controllers.
> +
> +config TYPEC_FUSB302
> +       tristate "Fairchild FUSB302 Type-C chip driver"
> +       depends on DM && DM_I2C && TYPEC_TCPM
> +       help
> +         The Fairchild FUSB302 Type-C chip driver that works with
> +         Type-C Port Controller Manager to provide USB PD and USB
> +         Type-C functionalities.
> diff --git a/drivers/usb/tcpm/Makefile b/drivers/usb/tcpm/Makefile
> index a0f76436f3fd..668d33155bf1 100644
> --- a/drivers/usb/tcpm/Makefile
> +++ b/drivers/usb/tcpm/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_TYPEC_TCPM) +=3D tcpm.o tcpm-uclass.o
> +obj-$(CONFIG_TYPEC_FUSB302) +=3D fusb302.o
> diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
> new file mode 100644
> index 000000000000..fe93ff3d3397
> --- /dev/null
> +++ b/drivers/usb/tcpm/fusb302.c
> @@ -0,0 +1,1323 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2016-2017 Google, Inc
> + *
> + * Fairchild FUSB302 Type-C Chip Driver
> + */
> +
> +#include <dm.h>
> +#include <i2c.h>
> +#include <asm/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <dm/device_compat.h>
> +#include <usb/tcpm.h>
> +#include "fusb302_reg.h"
> +
> +#define FUSB302_MAX_MSG_LEN 0x1F
> +
> +enum toggling_mode {
> +       TOGGLING_MODE_OFF,
> +       TOGGLING_MODE_DRP,
> +       TOGGLING_MODE_SNK,
> +       TOGGLING_MODE_SRC,
> +};
> +
> +enum src_current_status {
> +       SRC_CURRENT_DEFAULT,
> +       SRC_CURRENT_MEDIUM,
> +       SRC_CURRENT_HIGH,
> +};
> +
> +static const u8 ra_mda_value[] =3D {
> +       [SRC_CURRENT_DEFAULT] =3D 4,      /* 210mV */
> +       [SRC_CURRENT_MEDIUM] =3D 9,       /* 420mV */
> +       [SRC_CURRENT_HIGH] =3D 18,        /* 798mV */
> +};
> +
> +static const u8 rd_mda_value[] =3D {
> +       [SRC_CURRENT_DEFAULT] =3D 38,     /* 1638mV */
> +       [SRC_CURRENT_MEDIUM] =3D 38,      /* 1638mV */
> +       [SRC_CURRENT_HIGH] =3D 61,        /* 2604mV */
> +};
> +
> +struct fusb302_chip {
> +       enum toggling_mode toggling_mode;
> +       enum src_current_status src_current_status;
> +       bool intr_togdone;
> +       bool intr_bc_lvl;
> +       bool intr_comp_chng;
> +
> +       /* port status */
> +       bool vconn_on;
> +       bool vbus_present;
> +       enum typec_cc_polarity cc_polarity;
> +       enum typec_cc_status cc1;
> +       enum typec_cc_status cc2;
> +};
> +
> +static int fusb302_i2c_write(struct udevice *dev, u8 address, u8 data)
> +{
> +       int ret;
> +
> +       ret =3D dm_i2c_write(dev, address, &data, 1);
> +       if (ret)
> +               dev_err(dev, "cannot write 0x%02x to 0x%02x, ret=3D%d\n",
> +                       data, address, ret);
> +
> +       return ret;
> +}
> +
> +static int fusb302_i2c_block_write(struct udevice *dev, u8 address,
> +                                  u8 length, const u8 *data)
> +{
> +       int ret;
> +
> +       if (!length)
> +               return 0;
> +
> +       ret =3D dm_i2c_write(dev, address, data, length);
> +       if (ret)
> +               dev_err(dev, "cannot block write 0x%02x, len=3D%d, ret=3D=
%d\n",
> +                       address, length, ret);
> +
> +       return ret;
> +}
> +
> +static int fusb302_i2c_read(struct udevice *dev, u8 address, u8 *data)
> +{
> +       int ret, retries;
> +
> +       for (retries =3D 0; retries < 3; retries++) {
> +               ret =3D dm_i2c_read(dev, address, data, 1);
> +               if (ret =3D=3D 0)
> +                       return ret;
> +               dev_err(dev, "cannot read %02x, ret=3D%d\n", address, ret=
);
> +       }
> +
> +       return ret;
> +}
> +
> +static int fusb302_i2c_block_read(struct udevice *dev, u8 address,
> +                                 u8 length, u8 *data)
> +{
> +       int ret;
> +
> +       if (!length)
> +               return 0;
> +
> +       ret =3D dm_i2c_read(dev, address, data, length);
> +       if (ret)
> +               dev_err(dev, "cannot block read 0x%02x, len=3D%d, ret=3D%=
d\n",
> +                       address, length, ret);
> +       return ret;
> +}
> +
> +static int fusb302_i2c_mask_write(struct udevice *dev, u8 address,
> +                                 u8 mask, u8 value)
> +{
> +       int ret;
> +       u8 data;
> +
> +       ret =3D fusb302_i2c_read(dev, address, &data);
> +       if (ret)
> +               return ret;
> +       data &=3D ~mask;
> +       data |=3D value;
> +       ret =3D fusb302_i2c_write(dev, address, data);
> +       if (ret)
> +               return ret;
> +
> +       return ret;
> +}
> +
> +static int fusb302_i2c_set_bits(struct udevice *dev, u8 address, u8 set_=
bits)
> +{
> +       return fusb302_i2c_mask_write(dev, address, 0x00, set_bits);
> +}
> +
> +static int fusb302_i2c_clear_bits(struct udevice *dev, u8 address, u8 cl=
ear_bits)
> +{
> +       return fusb302_i2c_mask_write(dev, address, clear_bits, 0x00);
> +}
> +
> +static int fusb302_sw_reset(struct udevice *dev)
> +{
> +       int ret =3D fusb302_i2c_write(dev, FUSB_REG_RESET, FUSB_REG_RESET=
_SW_RESET);
> +
> +       if (ret)
> +               dev_err(dev, "cannot sw reset the fusb302: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int fusb302_enable_tx_auto_retries(struct udevice *dev, u8 retry_=
count)
> +{
> +       int ret;
> +
> +       ret =3D fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL3, retry_count =
|
> +                                  FUSB_REG_CONTROL3_AUTO_RETRY);
> +
> +       return ret;
> +}
> +
> +/*
> + * mask all interrupt on the chip
> + */
> +static int fusb302_mask_interrupt(struct udevice *dev)
> +{
> +       int ret;
> +
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MASK, 0xFF);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MASKA, 0xFF);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MASKB, 0xFF);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL0,
> +                                  FUSB_REG_CONTROL0_INT_MASK);
> +               return ret;
> +}
> +
> +/*
> + * initialize interrupt on the chip
> + * - unmasked interrupt: VBUS_OK
> + */
> +static int fusb302_init_interrupt(struct udevice *dev)
> +{
> +       int ret;
> +
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MASK,
> +                               0xFF & ~FUSB_REG_MASK_VBUSOK);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MASKA, 0xFF);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MASKB, 0xFF);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_clear_bits(dev, FUSB_REG_CONTROL0,
> +                                    FUSB_REG_CONTROL0_INT_MASK);
> +       return ret;
> +}
> +
> +static int fusb302_set_power_mode(struct udevice *dev, u8 power_mode)
> +{
> +       int ret;
> +
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_POWER, power_mode);
> +
> +       return ret;
> +}
> +
> +static int fusb302_init(struct udevice *dev)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       int ret;
> +       u8 data;
> +
> +       ret =3D fusb302_sw_reset(dev);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_enable_tx_auto_retries(dev, FUSB_REG_CONTROL3_N_R=
ETRIES_3);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_init_interrupt(dev);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_set_power_mode(dev, FUSB_REG_POWER_PWR_ALL);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS0, &data);
> +       if (ret)
> +               return ret;
> +       chip->vbus_present =3D !!(data & FUSB_REG_STATUS0_VBUSOK);
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_DEVICE_ID, &data);
> +       if (ret)
> +               return ret;
> +       dev_info(dev, "fusb302 device ID: 0x%02x\n", data);
> +
> +       return ret;
> +}
> +
> +static int fusb302_get_vbus(struct udevice *dev)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +
> +       return chip->vbus_present ? 1 : 0;
> +}
> +
> +static int fusb302_set_src_current(struct udevice *dev,
> +                                  enum src_current_status status)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       int ret;
> +
> +       chip->src_current_status =3D status;
> +       switch (status) {
> +       case SRC_CURRENT_DEFAULT:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL0,
> +                                            FUSB_REG_CONTROL0_HOST_CUR_M=
ASK,
> +                                            FUSB_REG_CONTROL0_HOST_CUR_D=
EF);
> +               break;
> +       case SRC_CURRENT_MEDIUM:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL0,
> +                                            FUSB_REG_CONTROL0_HOST_CUR_M=
ASK,
> +                                            FUSB_REG_CONTROL0_HOST_CUR_M=
ED);
> +               break;
> +       case SRC_CURRENT_HIGH:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL0,
> +                                            FUSB_REG_CONTROL0_HOST_CUR_M=
ASK,
> +                                            FUSB_REG_CONTROL0_HOST_CUR_H=
IGH);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int fusb302_set_toggling(struct udevice *dev,
> +                               enum toggling_mode mode)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       int ret;
> +
> +       /* first disable toggling */
> +       ret =3D fusb302_i2c_clear_bits(dev, FUSB_REG_CONTROL2,
> +                                    FUSB_REG_CONTROL2_TOGGLE);
> +       if (ret)
> +               return ret;
> +       /* mask interrupts for SRC or SNK */
> +       ret =3D fusb302_i2c_set_bits(dev, FUSB_REG_MASK,
> +                                  FUSB_REG_MASK_BC_LVL |
> +                                  FUSB_REG_MASK_COMP_CHNG);
> +       if (ret)
> +               return ret;
> +       chip->intr_bc_lvl =3D false;
> +       chip->intr_comp_chng =3D false;
> +       /* configure toggling mode: none/snk/src/drp */
> +       switch (mode) {
> +       case TOGGLING_MODE_OFF:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL2,
> +                                            FUSB_REG_CONTROL2_MODE_MASK,
> +                                            FUSB_REG_CONTROL2_MODE_NONE)=
;
> +               break;
> +       case TOGGLING_MODE_SNK:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL2,
> +                                            FUSB_REG_CONTROL2_MODE_MASK,
> +                                            FUSB_REG_CONTROL2_MODE_UFP);
> +               break;
> +       case TOGGLING_MODE_SRC:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL2,
> +                                            FUSB_REG_CONTROL2_MODE_MASK,
> +                                            FUSB_REG_CONTROL2_MODE_DFP);
> +               break;
> +       case TOGGLING_MODE_DRP:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_CONTROL2,
> +                                            FUSB_REG_CONTROL2_MODE_MASK,
> +                                            FUSB_REG_CONTROL2_MODE_DRP);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (ret)
> +               return ret;
> +
> +       if (mode =3D=3D TOGGLING_MODE_OFF) {
> +               /* mask TOGDONE interrupt */
> +               ret =3D fusb302_i2c_set_bits(dev, FUSB_REG_MASKA,
> +                                          FUSB_REG_MASKA_TOGDONE);
> +               if (ret)
> +                       return ret;
> +               chip->intr_togdone =3D false;
> +       } else {
> +               /* Datasheet says vconn MUST be off when toggling */
> +               if (chip->vconn_on)
> +                       dev_warn(dev, "Vconn is on during toggle start\n"=
);
> +               /* unmask TOGDONE interrupt */
> +               ret =3D fusb302_i2c_clear_bits(dev, FUSB_REG_MASKA,
> +                                            FUSB_REG_MASKA_TOGDONE);
> +               if (ret)
> +                       return ret;
> +               chip->intr_togdone =3D true;
> +               /* start toggling */
> +               ret =3D fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL2,
> +                                          FUSB_REG_CONTROL2_TOGGLE);
> +               if (ret)
> +                       return ret;
> +               /* during toggling, consider cc as Open */
> +               chip->cc1 =3D TYPEC_CC_OPEN;
> +               chip->cc2 =3D TYPEC_CC_OPEN;
> +       }
> +       chip->toggling_mode =3D mode;
> +
> +       return ret;
> +}
> +
> +static const enum src_current_status cc_src_current[] =3D {
> +       [TYPEC_CC_OPEN]         =3D SRC_CURRENT_DEFAULT,
> +       [TYPEC_CC_RA]           =3D SRC_CURRENT_DEFAULT,
> +       [TYPEC_CC_RD]           =3D SRC_CURRENT_DEFAULT,
> +       [TYPEC_CC_RP_DEF]       =3D SRC_CURRENT_DEFAULT,
> +       [TYPEC_CC_RP_1_5]       =3D SRC_CURRENT_MEDIUM,
> +       [TYPEC_CC_RP_3_0]       =3D SRC_CURRENT_HIGH,
> +};
> +
> +static int fusb302_set_cc(struct udevice *dev, enum typec_cc_status cc)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       const u8 switches0_mask =3D FUSB_REG_SWITCHES0_CC1_PU_EN |
> +                                 FUSB_REG_SWITCHES0_CC2_PU_EN |
> +                                 FUSB_REG_SWITCHES0_CC1_PD_EN |
> +                                 FUSB_REG_SWITCHES0_CC2_PD_EN;
> +       u8 rd_mda, switches0_data =3D 0x00;
> +       int ret;
> +
> +       switch (cc) {
> +       case TYPEC_CC_OPEN:
> +               break;
> +       case TYPEC_CC_RD:
> +               switches0_data |=3D FUSB_REG_SWITCHES0_CC1_PD_EN |
> +                                 FUSB_REG_SWITCHES0_CC2_PD_EN;
> +               break;
> +       case TYPEC_CC_RP_DEF:
> +       case TYPEC_CC_RP_1_5:
> +       case TYPEC_CC_RP_3_0:
> +               switches0_data |=3D (chip->cc_polarity =3D=3D TYPEC_POLAR=
ITY_CC1) ?
> +                                 FUSB_REG_SWITCHES0_CC1_PU_EN :
> +                                 FUSB_REG_SWITCHES0_CC2_PU_EN;
> +               break;
> +       default:
> +               dev_err(dev, "unsupported CC value: %s\n",
> +                       typec_cc_status_name[cc]);
> +               ret =3D -EINVAL;
> +               goto done;
> +       }
> +
> +       ret =3D fusb302_set_toggling(dev, TOGGLING_MODE_OFF);
> +       if (ret) {
> +               dev_err(dev, "cannot set toggling mode: %d\n", ret);
> +               goto done;
> +       }
> +
> +       ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_SWITCHES0,
> +                                    switches0_mask, switches0_data);
> +       if (ret) {
> +               dev_err(dev, "cannot set pull-up/-down: %d\n", ret);
> +               goto done;
> +       }
> +       /* reset the cc status */
> +       chip->cc1 =3D TYPEC_CC_OPEN;
> +       chip->cc2 =3D TYPEC_CC_OPEN;
> +
> +       /* adjust current for SRC */
> +       ret =3D fusb302_set_src_current(dev, cc_src_current[cc]);
> +       if (ret) {
> +               dev_err(dev, "cannot set src current %s: %d\n",
> +                       typec_cc_status_name[cc], ret);
> +               goto done;
> +       }
> +
> +       /* enable/disable interrupts, BC_LVL for SNK and COMP_CHNG for SR=
C */
> +       switch (cc) {
> +       case TYPEC_CC_RP_DEF:
> +       case TYPEC_CC_RP_1_5:
> +       case TYPEC_CC_RP_3_0:
> +               rd_mda =3D rd_mda_value[cc_src_current[cc]];
> +               ret =3D fusb302_i2c_write(dev, FUSB_REG_MEASURE, rd_mda);
> +               if (ret) {
> +                       dev_err(dev, "cannot set SRC measure value: %d\n"=
, ret);
> +                       goto done;
> +               }
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_MASK,
> +                                            FUSB_REG_MASK_BC_LVL |
> +                                            FUSB_REG_MASK_COMP_CHNG,
> +                                            FUSB_REG_MASK_BC_LVL);
> +               if (ret) {
> +                       dev_err(dev, "cannot set SRC irq: %d\n", ret);
> +                       goto done;
> +               }
> +               chip->intr_comp_chng =3D true;
> +               break;
> +       case TYPEC_CC_RD:
> +               ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_MASK,
> +                                            FUSB_REG_MASK_BC_LVL |
> +                                            FUSB_REG_MASK_COMP_CHNG,
> +                                            FUSB_REG_MASK_COMP_CHNG);
> +               if (ret) {
> +                       dev_err(dev, "cannot set SRC irq: %d\n", ret);
> +                       goto done;
> +               }
> +               chip->intr_bc_lvl =3D true;
> +               break;
> +       default:
> +               break;
> +       }
> +done:
> +       return ret;
> +}
> +
> +static int fusb302_get_cc(struct udevice *dev, enum typec_cc_status *cc1=
,
> +                         enum typec_cc_status *cc2)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +
> +       *cc1 =3D chip->cc1;
> +       *cc2 =3D chip->cc2;
> +       dev_dbg(dev, "get cc1 =3D %s, cc2 =3D %s\n", typec_cc_status_name=
[*cc1],
> +               typec_cc_status_name[*cc2]);
> +
> +       return 0;
> +}
> +
> +static int fusb302_set_vconn(struct udevice *dev, bool on)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       int ret;
> +       u8 switches0_data =3D 0x00;
> +       u8 switches0_mask =3D FUSB_REG_SWITCHES0_VCONN_CC1 |
> +                           FUSB_REG_SWITCHES0_VCONN_CC2;
> +
> +       if (chip->vconn_on =3D=3D on) {
> +               ret =3D 0;
> +               dev_dbg(dev, "vconn is already %s\n", on ? "on" : "off");
> +               goto done;
> +       }
> +       if (on) {
> +               switches0_data =3D (chip->cc_polarity =3D=3D TYPEC_POLARI=
TY_CC1) ?
> +                                FUSB_REG_SWITCHES0_VCONN_CC2 :
> +                                FUSB_REG_SWITCHES0_VCONN_CC1;
> +       }
> +       ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_SWITCHES0,
> +                                    switches0_mask, switches0_data);
> +       if (ret)
> +               goto done;
> +       dev_dbg(dev, "set vconn =3D %s\n", on ? "on" : "off");
> +done:
> +       return ret;
> +}
> +
> +static int fusb302_set_vbus(struct udevice *dev, bool on, bool charge)
> +{

I did a patch that adds vbus-supply regulator support. Because the vbus
regulator actually used on my custom board. And the connected sink device
doesn't get supply unless it is turned on.

I can send my patch here for you to take a look.
Or I can send it as standalone patch later.

> +       return 0;
> +}
> +
> +static int fusb302_pd_tx_flush(struct udevice *dev)
> +{
> +       return fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL0,
> +                                   FUSB_REG_CONTROL0_TX_FLUSH);
> +}
> +
> +static int fusb302_pd_rx_flush(struct udevice *dev)
> +{
> +       return fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL1,
> +                                   FUSB_REG_CONTROL1_RX_FLUSH);
> +}
> +
> +static int fusb302_pd_set_auto_goodcrc(struct udevice *dev, bool on)
> +{
> +       if (on)
> +               return fusb302_i2c_set_bits(dev, FUSB_REG_SWITCHES1,
> +                                           FUSB_REG_SWITCHES1_AUTO_GCRC)=
;
> +       return fusb302_i2c_clear_bits(dev, FUSB_REG_SWITCHES1,
> +                                     FUSB_REG_SWITCHES1_AUTO_GCRC);
> +}
> +
> +static int fusb302_pd_set_interrupts(struct udevice *dev, bool on)
> +{
> +       int ret;
> +       u8 mask_interrupts =3D FUSB_REG_MASK_COLLISION;
> +       u8 maska_interrupts =3D FUSB_REG_MASKA_RETRYFAIL |
> +                             FUSB_REG_MASKA_HARDSENT |
> +                             FUSB_REG_MASKA_TX_SUCCESS |
> +                             FUSB_REG_MASKA_HARDRESET;
> +       u8 maskb_interrupts =3D FUSB_REG_MASKB_GCRCSENT;
> +
> +       ret =3D on ?
> +               fusb302_i2c_clear_bits(dev, FUSB_REG_MASK, mask_interrupt=
s) :
> +               fusb302_i2c_set_bits(dev, FUSB_REG_MASK, mask_interrupts)=
;
> +       if (ret)
> +               return ret;
> +       ret =3D on ?
> +               fusb302_i2c_clear_bits(dev, FUSB_REG_MASKA, maska_interru=
pts) :
> +               fusb302_i2c_set_bits(dev, FUSB_REG_MASKA, maska_interrupt=
s);
> +       if (ret)
> +               return ret;
> +       ret =3D on ?
> +               fusb302_i2c_clear_bits(dev, FUSB_REG_MASKB, maskb_interru=
pts) :
> +               fusb302_i2c_set_bits(dev, FUSB_REG_MASKB, maskb_interrupt=
s);
> +       return ret;
> +}
> +
> +static int fusb302_set_pd_rx(struct udevice *dev, bool on)
> +{
> +       int ret;
> +
> +       ret =3D fusb302_pd_rx_flush(dev);
> +       if (ret) {
> +               dev_err(dev, "cannot flush pd rx buffer: %d\n", ret);
> +               goto done;
> +       }
> +       ret =3D fusb302_pd_tx_flush(dev);
> +       if (ret) {
> +               dev_err(dev, "cannot flush pd tx buffer: %d\n", ret);
> +               goto done;
> +       }
> +       ret =3D fusb302_pd_set_auto_goodcrc(dev, on);
> +       if (ret) {
> +               dev_err(dev, "cannot turn %s auto GoodCRC: %d\n",
> +                       on ? "on" : "off", ret);
> +               goto done;
> +       }
> +       ret =3D fusb302_pd_set_interrupts(dev, on);
> +       if (ret) {
> +               dev_err(dev, "cannot turn %s pd interrupts: %d\n",
> +                       on ? "on" : "off", ret);
> +               goto done;
> +       }
> +       dev_dbg(dev, "set pd RX %s\n", on ? "on" : "off");
> +done:
> +       return ret;
> +}
> +
> +static int fusb302_set_roles(struct udevice *dev, bool attached,
> +                            enum typec_role pwr, enum typec_data_role da=
ta)
> +{
> +       int ret;
> +       u8 switches1_mask =3D FUSB_REG_SWITCHES1_POWERROLE |
> +                           FUSB_REG_SWITCHES1_DATAROLE;
> +       u8 switches1_data =3D 0x00;
> +
> +       if (pwr =3D=3D TYPEC_SOURCE)
> +               switches1_data |=3D FUSB_REG_SWITCHES1_POWERROLE;
> +       if (data =3D=3D TYPEC_HOST)
> +               switches1_data |=3D FUSB_REG_SWITCHES1_DATAROLE;
> +       ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_SWITCHES1,
> +                                    switches1_mask, switches1_data);
> +       if (ret) {
> +               dev_err(dev, "unable to set pd header %s, %s, ret=3D%d\n"=
,
> +                       typec_role_name[pwr], typec_data_role_name[data],=
 ret);
> +               goto done;
> +       }
> +       dev_dbg(dev, "pd header : %s, %s\n", typec_role_name[pwr],
> +               typec_data_role_name[data]);
> +done:
> +
> +       return ret;
> +}
> +
> +static int fusb302_start_toggling(struct udevice *dev,
> +                                 enum typec_port_type port_type,
> +                                 enum typec_cc_status cc)
> +{
> +       enum toggling_mode mode =3D TOGGLING_MODE_OFF;
> +       int ret;
> +
> +       switch (port_type) {
> +       case TYPEC_PORT_SRC:
> +               mode =3D TOGGLING_MODE_SRC;
> +               break;
> +       case TYPEC_PORT_SNK:
> +               mode =3D TOGGLING_MODE_SNK;
> +               break;
> +       case TYPEC_PORT_DRP:
> +               mode =3D TOGGLING_MODE_DRP;
> +               break;
> +       }
> +
> +       ret =3D fusb302_set_src_current(dev, cc_src_current[cc]);
> +       if (ret) {
> +               dev_err(dev, "unable to set src current %s, ret=3D%d",
> +                       typec_cc_status_name[cc], ret);
> +               goto done;
> +       }
> +       ret =3D fusb302_set_toggling(dev, mode);
> +       if (ret) {
> +               dev_err(dev, "unable to start drp toggling: %d\n", ret);
> +               goto done;
> +       }
> +       dev_info(dev, "fusb302 start drp toggling\n");
> +done:
> +
> +       return ret;
> +}
> +
> +static int fusb302_pd_send_message(struct udevice *dev,
> +                                  const struct pd_message *msg)
> +{
> +       int ret;
> +       /* SOP tokens */
> +       u8 buf[40] =3D {FUSB302_TKN_SYNC1, FUSB302_TKN_SYNC1, FUSB302_TKN=
_SYNC1,
> +                     FUSB302_TKN_SYNC2};
> +       u8 pos =3D 4;
> +       int len;
> +
> +       len =3D pd_header_cnt_le(msg->header) * 4;
> +       /* plug 2 for header */
> +       len +=3D 2;
> +       if (len > FUSB302_MAX_MSG_LEN) {
> +               dev_err(dev, "PD message too long %d (incl. header)", len=
);
> +               return -EINVAL;
> +       }
> +       /* packsym tells the FUSB302 chip that the next X bytes are paylo=
ad */
> +       buf[pos++] =3D FUSB302_TKN_PACKSYM | (len & FUSB302_MAX_MSG_LEN);
> +       memcpy(&buf[pos], &msg->header, sizeof(msg->header));
> +       pos +=3D sizeof(msg->header);
> +
> +       len -=3D 2;
> +       memcpy(&buf[pos], msg->payload, len);
> +       pos +=3D len;
> +
> +       /* CRC */
> +       buf[pos++] =3D FUSB302_TKN_JAMCRC;
> +       /* EOP */
> +       buf[pos++] =3D FUSB302_TKN_EOP;
> +       /* turn tx off after sending message */
> +       buf[pos++] =3D FUSB302_TKN_TXOFF;
> +       /* start transmission */
> +       buf[pos++] =3D FUSB302_TKN_TXON;
> +
> +       ret =3D fusb302_i2c_block_write(dev, FUSB_REG_FIFOS, pos, buf);
> +       if (ret)
> +               return ret;
> +       dev_dbg(dev, "Send PD message (header=3D0x%x len=3D%d)\n", msg->h=
eader, len);
> +
> +       return ret;
> +}
> +
> +static int fusb302_pd_send_hardreset(struct udevice *dev)
> +{
> +       return fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL3,
> +                                   FUSB_REG_CONTROL3_SEND_HARDRESET);
> +}
> +
> +static const char * const transmit_type_name[] =3D {
> +       [TCPC_TX_SOP]                   =3D "SOP",
> +       [TCPC_TX_SOP_PRIME]             =3D "SOP'",
> +       [TCPC_TX_SOP_PRIME_PRIME]       =3D "SOP''",
> +       [TCPC_TX_SOP_DEBUG_PRIME]       =3D "DEBUG'",
> +       [TCPC_TX_SOP_DEBUG_PRIME_PRIME] =3D "DEBUG''",
> +       [TCPC_TX_HARD_RESET]            =3D "HARD_RESET",
> +       [TCPC_TX_CABLE_RESET]           =3D "CABLE_RESET",
> +       [TCPC_TX_BIST_MODE_2]           =3D "BIST_MODE_2",
> +};
> +
> +static int fusb302_pd_transmit(struct udevice *dev, enum tcpm_transmit_t=
ype type,
> +                              const struct pd_message *msg, unsigned int=
 negotiated_rev)
> +{
> +       int ret;
> +
> +       switch (type) {
> +       case TCPC_TX_SOP:
> +               /* nRetryCount 3 in P2.0 spec, whereas 2 in PD3.0 spec */
> +               ret =3D fusb302_enable_tx_auto_retries(dev, negotiated_re=
v > PD_REV20 ?
> +                                                    FUSB_REG_CONTROL3_N_=
RETRIES_2 :
> +                                                    FUSB_REG_CONTROL3_N_=
RETRIES_3);
> +               if (ret)
> +                       dev_err(dev, "cannot update retry count: %d\n", r=
et);
> +
> +               ret =3D fusb302_pd_send_message(dev, msg);
> +               if (ret)
> +                       dev_err(dev, "cannot send PD message: %d\n", ret)=
;
> +               break;
> +       case TCPC_TX_HARD_RESET:
> +               ret =3D fusb302_pd_send_hardreset(dev);
> +               if (ret)
> +                       dev_err(dev, "cannot send hardreset: %d\n", ret);
> +               break;
> +       default:
> +               dev_err(dev, "type %s not supported", transmit_type_name[=
type]);
> +               ret =3D -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static enum typec_cc_status fusb302_bc_lvl_to_cc(u8 bc_lvl)
> +{
> +       if (bc_lvl =3D=3D FUSB_REG_STATUS0_BC_LVL_1230_MAX)
> +               return TYPEC_CC_RP_3_0;
> +       if (bc_lvl =3D=3D FUSB_REG_STATUS0_BC_LVL_600_1230)
> +               return TYPEC_CC_RP_1_5;
> +       if (bc_lvl =3D=3D FUSB_REG_STATUS0_BC_LVL_200_600)
> +               return TYPEC_CC_RP_DEF;
> +       return TYPEC_CC_OPEN;
> +}
> +
> +static void fusb302_bc_lvl_handler(struct udevice *dev)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       enum typec_cc_status cc_status;
> +       u8 status0, bc_lvl;
> +       int ret;
> +
> +       if (!chip->intr_bc_lvl) {
> +               dev_err(dev, "BC_LVL interrupt is turned off, abort\n");
> +               goto done;
> +       }
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS0, &status0);
> +       if (ret)
> +               goto done;
> +
> +       dev_dbg(dev, "BC_LVL handler, status0 =3D 0x%02x\n", status0);
> +       if (status0 & FUSB_REG_STATUS0_ACTIVITY)
> +               dev_info(dev, "CC activities detected, delay handling\n")=
;
> +       bc_lvl =3D status0 & FUSB_REG_STATUS0_BC_LVL_MASK;
> +       cc_status =3D fusb302_bc_lvl_to_cc(bc_lvl);
> +       if (chip->cc_polarity =3D=3D TYPEC_POLARITY_CC1) {
> +               if (chip->cc1 !=3D cc_status) {
> +                       dev_dbg(dev, "cc1: %s -> %s\n",
> +                               typec_cc_status_name[chip->cc1],
> +                               typec_cc_status_name[cc_status]);
> +                       chip->cc1 =3D cc_status;
> +                       tcpm_cc_change(dev);
> +               }
> +       } else {
> +               if (chip->cc2 !=3D cc_status) {
> +                       dev_dbg(dev, "cc2: %s -> %s\n",
> +                               typec_cc_status_name[chip->cc2],
> +                               typec_cc_status_name[cc_status]);
> +                       chip->cc2 =3D cc_status;
> +                       tcpm_cc_change(dev);
> +               }
> +       }
> +
> +done:
> +       return;
> +}
> +
> +static int fusb302_enter_low_power_mode(struct udevice *dev,
> +                                       bool attached, bool pd_capable)
> +{
> +       unsigned int reg;
> +       int ret;
> +
> +       ret =3D fusb302_mask_interrupt(dev);
> +       if (ret)
> +               return ret;
> +       if (attached && pd_capable)
> +               reg =3D FUSB_REG_POWER_PWR_MEDIUM;
> +       else if (attached)
> +               reg =3D FUSB_REG_POWER_PWR_LOW;
> +       else
> +               reg =3D 0;
> +
> +       return fusb302_set_power_mode(dev, reg);
> +}
> +
> +static const char * const cc_polarity_name[] =3D {
> +       [TYPEC_POLARITY_CC1]    =3D "Polarity_CC1",
> +       [TYPEC_POLARITY_CC2]    =3D "Polarity_CC2",
> +};
> +
> +static int fusb302_set_cc_polarity_and_pull(struct udevice *dev,
> +                                           enum typec_cc_polarity cc_pol=
arity,
> +                                           bool pull_up, bool pull_down)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       int ret;
> +       u8 switches0_data =3D 0x00;
> +       u8 switches1_mask =3D FUSB_REG_SWITCHES1_TXCC1_EN |
> +                           FUSB_REG_SWITCHES1_TXCC2_EN;
> +       u8 switches1_data =3D 0x00;
> +
> +       if (pull_down)
> +               switches0_data |=3D FUSB_REG_SWITCHES0_CC1_PD_EN |
> +                                 FUSB_REG_SWITCHES0_CC2_PD_EN;
> +
> +       if (cc_polarity =3D=3D TYPEC_POLARITY_CC1) {
> +               switches0_data |=3D FUSB_REG_SWITCHES0_MEAS_CC1;
> +               if (chip->vconn_on)
> +                       switches0_data |=3D FUSB_REG_SWITCHES0_VCONN_CC2;
> +               if (pull_up)
> +                       switches0_data |=3D FUSB_REG_SWITCHES0_CC1_PU_EN;
> +               switches1_data =3D FUSB_REG_SWITCHES1_TXCC1_EN;
> +       } else {
> +               switches0_data |=3D FUSB_REG_SWITCHES0_MEAS_CC2;
> +               if (chip->vconn_on)
> +                       switches0_data |=3D FUSB_REG_SWITCHES0_VCONN_CC1;
> +               if (pull_up)
> +                       switches0_data |=3D FUSB_REG_SWITCHES0_CC2_PU_EN;
> +               switches1_data =3D FUSB_REG_SWITCHES1_TXCC2_EN;
> +       }
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_SWITCHES0, switches0_data=
);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_mask_write(dev, FUSB_REG_SWITCHES1,
> +                                    switches1_mask, switches1_data);
> +       if (ret)
> +               return ret;
> +       chip->cc_polarity =3D cc_polarity;
> +
> +       return ret;
> +}
> +
> +static int fusb302_handle_togdone_snk(struct udevice *dev,
> +                                     u8 togdone_result)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       int ret;
> +       u8 status0;
> +       u8 bc_lvl;
> +       enum typec_cc_polarity cc_polarity;
> +       enum typec_cc_status cc_status_active, cc1, cc2;
> +
> +       /* set polarity and pull_up, pull_down */
> +       cc_polarity =3D (togdone_result =3D=3D FUSB_REG_STATUS1A_TOGSS_SN=
K1) ?
> +                     TYPEC_POLARITY_CC1 : TYPEC_POLARITY_CC2;
> +       ret =3D fusb302_set_cc_polarity_and_pull(dev, cc_polarity, false,=
 true);
> +       if (ret) {
> +               dev_err(dev, "cannot set cc polarity %s, ret =3D %d\n",
> +                       cc_polarity_name[cc_polarity], ret);
> +               return ret;
> +       }
> +       /* fusb302_set_cc_polarity() has set the correct measure block */
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS0, &status0);
> +       if (ret < 0)
> +               return ret;
> +       bc_lvl =3D status0 & FUSB_REG_STATUS0_BC_LVL_MASK;
> +       cc_status_active =3D fusb302_bc_lvl_to_cc(bc_lvl);
> +       /* restart toggling if the cc status on the active line is OPEN *=
/
> +       if (cc_status_active =3D=3D TYPEC_CC_OPEN) {
> +               dev_info(dev, "restart toggling as CC_OPEN detected\n");
> +               ret =3D fusb302_set_toggling(dev, chip->toggling_mode);
> +               return ret;
> +       }
> +       /* update tcpm with the new cc value */
> +       cc1 =3D (cc_polarity =3D=3D TYPEC_POLARITY_CC1) ?
> +             cc_status_active : TYPEC_CC_OPEN;
> +       cc2 =3D (cc_polarity =3D=3D TYPEC_POLARITY_CC2) ?
> +             cc_status_active : TYPEC_CC_OPEN;
> +       if (chip->cc1 !=3D cc1 || chip->cc2 !=3D cc2) {
> +               chip->cc1 =3D cc1;
> +               chip->cc2 =3D cc2;
> +               tcpm_cc_change(dev);
> +       }
> +       /* turn off toggling */
> +       ret =3D fusb302_set_toggling(dev, TOGGLING_MODE_OFF);
> +       if (ret) {
> +               dev_err(dev, "cannot set toggling mode off, ret=3D%d\n", =
ret);
> +               return ret;
> +       }
> +       /* unmask bc_lvl interrupt */
> +       ret =3D fusb302_i2c_clear_bits(dev, FUSB_REG_MASK, FUSB_REG_MASK_=
BC_LVL);
> +       if (ret) {
> +               dev_err(dev, "cannot unmask bc_lcl irq, ret=3D%d\n", ret)=
;
> +               return ret;
> +       }
> +       chip->intr_bc_lvl =3D true;
> +       dev_dbg(dev, "detected cc1=3D%s, cc2=3D%s\n",
> +               typec_cc_status_name[cc1],
> +               typec_cc_status_name[cc2]);
> +
> +       return ret;
> +}
> +
> +/* On error returns < 0, otherwise a typec_cc_status value */
> +static int fusb302_get_src_cc_status(struct udevice *dev,
> +                                    enum typec_cc_polarity cc_polarity,
> +                                    enum typec_cc_status *cc)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       u8 ra_mda =3D ra_mda_value[chip->src_current_status];
> +       u8 rd_mda =3D rd_mda_value[chip->src_current_status];
> +       u8 switches0_data, status0;
> +       int ret;
> +
> +       /* Step 1: Set switches so that we measure the right CC pin */
> +       switches0_data =3D (cc_polarity =3D=3D TYPEC_POLARITY_CC1) ?
> +               FUSB_REG_SWITCHES0_CC1_PU_EN | FUSB_REG_SWITCHES0_MEAS_CC=
1 :
> +               FUSB_REG_SWITCHES0_CC2_PU_EN | FUSB_REG_SWITCHES0_MEAS_CC=
2;
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_SWITCHES0, switches0_data=
);
> +       if (ret < 0)
> +               return ret;
> +
> +       fusb302_i2c_read(dev, FUSB_REG_SWITCHES0, &status0);
> +       dev_dbg(dev, "get_src_cc_status switches: 0x%0x", status0);

\n missed

> +
> +       /* Step 2: Set compararator volt to differentiate between Open an=
d Rd */
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MEASURE, rd_mda);
> +       if (ret)
> +               return ret;
> +
> +       udelay(100);
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS0, &status0);
> +       if (ret)
> +               return ret;
> +
> +       dev_dbg(dev, "get_src_cc_status rd_mda status0: 0x%0x", status0);

here

> +       if (status0 & FUSB_REG_STATUS0_COMP) {
> +               *cc =3D TYPEC_CC_OPEN;
> +               return 0;
> +       }
> +
> +       /* Step 3: Set compararator input to differentiate between Rd and=
 Ra. */
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MEASURE, ra_mda);
> +       if (ret)
> +               return ret;
> +
> +       udelay(100);
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS0, &status0);
> +       if (ret)
> +               return ret;
> +
> +       dev_dbg(dev, "get_src_cc_status ra_mda status0: 0x%0x", status0);

and here too

> +       if (status0 & FUSB_REG_STATUS0_COMP)
> +               *cc =3D TYPEC_CC_RD;
> +       else
> +               *cc =3D TYPEC_CC_RA;
> +
> +       return 0;
> +}
> +
> +static int fusb302_handle_togdone_src(struct udevice *dev,
> +                                     u8 togdone_result)
> +{
> +       /*
> +        * - set polarity (measure cc, vconn, tx)
> +        * - set pull_up, pull_down
> +        * - set cc1, cc2, and update to tcpm state machine
> +        * - set I_COMP interrupt on
> +        */
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       u8 rd_mda =3D rd_mda_value[chip->src_current_status];
> +       enum toggling_mode toggling_mode =3D chip->toggling_mode;
> +       enum typec_cc_polarity cc_polarity;
> +       enum typec_cc_status cc1, cc2;
> +       int ret;
> +
> +       /*
> +        * The toggle-engine will stop in a src state if it sees either R=
a or
> +        * Rd. Determine the status for both CC pins, starting with the o=
ne
> +        * where toggling stopped, as that is where the switches point no=
w.
> +        */
> +       if (togdone_result =3D=3D FUSB_REG_STATUS1A_TOGSS_SRC1)
> +               ret =3D fusb302_get_src_cc_status(dev, TYPEC_POLARITY_CC1=
, &cc1);
> +       else
> +               ret =3D fusb302_get_src_cc_status(dev, TYPEC_POLARITY_CC2=
, &cc2);
> +       if (ret)
> +               return ret;
> +       /* we must turn off toggling before we can measure the other pin =
*/
> +       ret =3D fusb302_set_toggling(dev, TOGGLING_MODE_OFF);
> +       if (ret) {
> +               dev_err(dev, "cannot set toggling mode off, ret=3D%d\n", =
ret);
> +               return ret;
> +       }
> +       /* get the status of the other pin */
> +       if (togdone_result =3D=3D FUSB_REG_STATUS1A_TOGSS_SRC1)
> +               ret =3D fusb302_get_src_cc_status(dev, TYPEC_POLARITY_CC2=
, &cc2);
> +       else
> +               ret =3D fusb302_get_src_cc_status(dev, TYPEC_POLARITY_CC1=
, &cc1);
> +       if (ret)
> +               return ret;
> +
> +       /* determine polarity based on the status of both pins */
> +       if (cc1 =3D=3D TYPEC_CC_RD && (cc2 =3D=3D TYPEC_CC_OPEN || cc2 =
=3D=3D TYPEC_CC_RA)) {
> +               cc_polarity =3D TYPEC_POLARITY_CC1;
> +       } else if (cc2 =3D=3D TYPEC_CC_RD &&
> +                   (cc1 =3D=3D TYPEC_CC_OPEN || cc1 =3D=3D TYPEC_CC_RA))=
 {
> +               cc_polarity =3D TYPEC_POLARITY_CC2;
> +       } else {
> +               dev_err(dev, "unexpected CC status cc1=3D%s, cc2=3D%s, re=
starting toggling\n",
> +                       typec_cc_status_name[cc1],
> +                       typec_cc_status_name[cc2]);
> +               return fusb302_set_toggling(dev, toggling_mode);
> +       }
> +       /* set polarity and pull_up, pull_down */
> +       ret =3D fusb302_set_cc_polarity_and_pull(dev, cc_polarity, true, =
false);
> +       if (ret < 0) {
> +               dev_err(dev, "cannot set cc polarity %s, ret=3D%d\n",
> +                       cc_polarity_name[cc_polarity], ret);
> +               return ret;
> +       }
> +       /* update tcpm with the new cc value */
> +       if (chip->cc1 !=3D cc1 || chip->cc2 !=3D cc2) {
> +               chip->cc1 =3D cc1;
> +               chip->cc2 =3D cc2;
> +               tcpm_cc_change(dev);
> +       }
> +       /* set MDAC to Rd threshold, and unmask I_COMP for unplug detecti=
on */
> +       ret =3D fusb302_i2c_write(dev, FUSB_REG_MEASURE, rd_mda);
> +       if (ret)
> +               return ret;
> +       /* unmask comp_chng interrupt */
> +       ret =3D fusb302_i2c_clear_bits(dev, FUSB_REG_MASK,
> +                                    FUSB_REG_MASK_COMP_CHNG);
> +       if (ret) {
> +               dev_err(dev, "cannot unmask comp_chng irq, ret=3D%d\n", r=
et);
> +               return ret;
> +       }
> +       chip->intr_comp_chng =3D true;
> +       dev_dbg(dev, "detected cc1=3D%s, cc2=3D%s\n",
> +               typec_cc_status_name[cc1],
> +               typec_cc_status_name[cc2]);
> +
> +       return ret;
> +}
> +
> +static int fusb302_handle_togdone(struct udevice *dev)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       u8 togdone_result, status1a;
> +       int ret;
> +
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS1A, &status1a);
> +       if (ret < 0)
> +               return ret;
> +       togdone_result =3D (status1a >> FUSB_REG_STATUS1A_TOGSS_POS) &
> +                        FUSB_REG_STATUS1A_TOGSS_MASK;
> +       switch (togdone_result) {
> +       case FUSB_REG_STATUS1A_TOGSS_SNK1:
> +       case FUSB_REG_STATUS1A_TOGSS_SNK2:
> +               return fusb302_handle_togdone_snk(dev, togdone_result);
> +       case FUSB_REG_STATUS1A_TOGSS_SRC1:
> +       case FUSB_REG_STATUS1A_TOGSS_SRC2:
> +               return fusb302_handle_togdone_src(dev, togdone_result);
> +       case FUSB_REG_STATUS1A_TOGSS_AA:
> +               /* doesn't support */
> +               dev_err(dev, "AudioAccessory not supported\n");
> +               fusb302_set_toggling(dev, chip->toggling_mode);
> +               break;
> +       default:
> +               dev_err(dev, "TOGDONE with an invalid state: %d\n",
> +                       togdone_result);
> +               fusb302_set_toggling(dev, chip->toggling_mode);
> +               break;
> +       }
> +       return ret;
> +}
> +
> +static int fusb302_pd_reset(struct udevice *dev)
> +{
> +       return fusb302_i2c_set_bits(dev, FUSB_REG_RESET,
> +                                   FUSB_REG_RESET_PD_RESET);
> +}
> +
> +static int fusb302_pd_read_message(struct udevice *dev,
> +                                  struct pd_message *msg)
> +{
> +       int len, ret;
> +       u8 crc[4];
> +       u8 token;
> +
> +       /* first SOP token */
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_FIFOS, &token);
> +       if (ret)
> +               return ret;
> +       ret =3D fusb302_i2c_block_read(dev, FUSB_REG_FIFOS, 2,
> +                                    (u8 *)&msg->header);
> +       if (ret)
> +               return ret;
> +       len =3D pd_header_cnt_le(msg->header) * 4;
> +       /* add 4 to length to include the CRC */
> +       if (len > PD_MAX_PAYLOAD * 4) {
> +               dev_err(dev, "PD message too long %d\n", len);
> +               return -EINVAL;
> +       }
> +       if (len > 0) {
> +               ret =3D fusb302_i2c_block_read(dev, FUSB_REG_FIFOS, len,
> +                                            (u8 *)msg->payload);
> +               if (ret)
> +                       return ret;
> +       }
> +       /* another 4 bytes to read CRC out */
> +       ret =3D fusb302_i2c_block_read(dev, FUSB_REG_FIFOS, 4, crc);
> +       if (ret)
> +               return ret;
> +       dev_dbg(dev, "Received PD message (header=3D0x%x len=3D%d)\n", ms=
g->header, len);
> +
> +       /*
> +        * Check if we've read off a GoodCRC message. If so then indicate=
 to
> +        * TCPM that the previous transmission has completed. Otherwise w=
e pass
> +        * the received message over to TCPM for processing.
> +        *
> +        * We make this check here instead of basing the reporting decisi=
on on
> +        * the IRQ event type, as it's possible for the chip to report th=
e
> +        * TX_SUCCESS and GCRCSENT events out of order on occasion, so we=
 need
> +        * to check the message type to ensure correct reporting to TCPM.
> +        */
> +       if (!len && (pd_header_type_le(msg->header) =3D=3D PD_CTRL_GOOD_C=
RC))
> +               tcpm_pd_transmit_complete(dev, TCPC_TX_SUCCESS);
> +       else
> +               tcpm_pd_receive(dev, msg);
> +
> +       return ret;
> +}
> +
> +static void fusb302_interrupt_handle(struct udevice *dev)
> +{
> +       struct fusb302_chip *chip =3D dev_get_priv(dev);
> +       u8 interrupt;
> +       u8 interrupta;
> +       u8 interruptb;
> +       u8 status0;
> +       bool vbus_present;
> +       bool comp_result;
> +       bool intr_togdone;
> +       bool intr_bc_lvl;
> +       bool intr_comp_chng;
> +       struct pd_message pd_msg;
> +       int ret;
> +
> +       /* grab a snapshot of intr flags */
> +       intr_togdone =3D chip->intr_togdone;
> +       intr_bc_lvl =3D chip->intr_bc_lvl;
> +       intr_comp_chng =3D chip->intr_comp_chng;
> +
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_INTERRUPT, &interrupt);
> +       if (ret)
> +               return;
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_INTERRUPTA, &interrupta);
> +       if (ret)
> +               return;
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_INTERRUPTB, &interruptb);
> +       if (ret)
> +               return;
> +       ret =3D fusb302_i2c_read(dev, FUSB_REG_STATUS0, &status0);
> +       if (ret)
> +               return;
> +
> +       /*
> +        * Since we are polling the IRQs, avoid printing messages when th=
ere
> +        * no interrupts at all to avoid spamming the log.
> +        */
> +       if (interrupt !=3D 0 || interrupta !=3D 0 || interruptb !=3D 0)
> +               dev_dbg(dev, "IRQ: 0x%02x, a: 0x%02x, b: 0x%02x, status0:=
 0x%02x\n",
> +                       interrupt, interrupta, interruptb, status0);
> +
> +       if (interrupt & FUSB_REG_INTERRUPT_VBUSOK) {
> +               vbus_present =3D !!(status0 & FUSB_REG_STATUS0_VBUSOK);
> +               dev_dbg(dev, "IRQ: VBUS_OK, vbus=3D%s\n",
> +                       vbus_present ? "On" : "Off");
> +               if (vbus_present !=3D chip->vbus_present) {
> +                       chip->vbus_present =3D vbus_present;
> +                       tcpm_vbus_change(dev);
> +               }
> +       }
> +
> +       if ((interrupta & FUSB_REG_INTERRUPTA_TOGDONE) && intr_togdone) {
> +               dev_dbg(dev, "IRQ: TOGDONE\n");
> +               ret =3D fusb302_handle_togdone(dev);
> +               if (ret) {
> +                       dev_err(dev, "handle togdone error: %d\n", ret);
> +                       return;
> +               }
> +       }
> +
> +       if ((interrupt & FUSB_REG_INTERRUPT_BC_LVL) && intr_bc_lvl) {
> +               dev_dbg(dev, "IRQ: BC_LVL, handler pending\n");
> +               fusb302_bc_lvl_handler(dev);
> +       }
> +
> +       if ((interrupt & FUSB_REG_INTERRUPT_COMP_CHNG) && intr_comp_chng)=
 {
> +               comp_result =3D !!(status0 & FUSB_REG_STATUS0_COMP);
> +               dev_dbg(dev, "IRQ: COMP_CHNG, comp=3D%s\n",
> +                       comp_result ? "true" : "false");
> +               if (comp_result) {
> +                       /* cc level > Rd_threshold, detach */
> +                       chip->cc1 =3D TYPEC_CC_OPEN;
> +                       chip->cc2 =3D TYPEC_CC_OPEN;
> +                       tcpm_cc_change(dev);
> +               }
> +       }
> +
> +       if (interrupt & FUSB_REG_INTERRUPT_COLLISION) {
> +               dev_dbg(dev, "IRQ: PD collision\n");
> +               tcpm_pd_transmit_complete(dev, TCPC_TX_FAILED);
> +       }
> +
> +       if (interrupta & FUSB_REG_INTERRUPTA_RETRYFAIL) {
> +               dev_dbg(dev, "IRQ: PD retry failed\n");
> +               tcpm_pd_transmit_complete(dev, TCPC_TX_FAILED);
> +       }
> +
> +       if (interrupta & FUSB_REG_INTERRUPTA_HARDSENT) {
> +               dev_dbg(dev, "IRQ: PD hardreset sent\n");
> +               ret =3D fusb302_pd_reset(dev);
> +               if (ret) {
> +                       dev_err(dev, "cannot PD reset, ret=3D%d\n", ret);
> +                       return;
> +               }
> +               tcpm_pd_transmit_complete(dev, TCPC_TX_SUCCESS);
> +       }
> +
> +       if (interrupta & FUSB_REG_INTERRUPTA_TX_SUCCESS) {
> +               dev_dbg(dev, "IRQ: PD tx success\n");
> +               ret =3D fusb302_pd_read_message(dev, &pd_msg);
> +               if (ret) {
> +                       dev_err(dev, "cannot read in PD message, ret=3D%d=
\n", ret);
> +                       return;
> +               }
> +       }
> +
> +       if (interrupta & FUSB_REG_INTERRUPTA_HARDRESET) {
> +               dev_dbg(dev, "IRQ: PD received hardreset\n");
> +               ret =3D fusb302_pd_reset(dev);
> +               if (ret) {
> +                       dev_err(dev, "cannot PD reset, ret=3D%d\n", ret);
> +                       return;
> +               }
> +               tcpm_pd_hard_reset(dev);
> +       }
> +
> +       if (interruptb & FUSB_REG_INTERRUPTB_GCRCSENT) {
> +               dev_dbg(dev, "IRQ: PD sent good CRC\n");
> +               ret =3D fusb302_pd_read_message(dev, &pd_msg);
> +               if (ret) {
> +                       dev_err(dev, "cannot read in PD message, ret=3D%d=
\n", ret);
> +                       return;
> +               }
> +       }
> +}
> +
> +static void fusb302_poll_event(struct udevice *dev)
> +{
> +       fusb302_interrupt_handle(dev);
> +}
> +
> +static int fusb302_get_connector_node(struct udevice *dev, ofnode *conne=
ctor_node)
> +{
> +       *connector_node =3D dev_read_subnode(dev, "connector");
> +       if (!ofnode_valid(*connector_node)) {
> +               dev_err(dev, "'connector' node is not found\n");
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct dm_tcpm_ops fusb302_ops =3D {
> +       .get_connector_node =3D fusb302_get_connector_node,
> +       .init =3D fusb302_init,
> +       .get_vbus =3D fusb302_get_vbus,
> +       .set_cc =3D fusb302_set_cc,
> +       .get_cc =3D fusb302_get_cc,
> +       .set_vconn =3D fusb302_set_vconn,
> +       .set_vbus =3D fusb302_set_vbus,
> +       .set_pd_rx =3D fusb302_set_pd_rx,
> +       .set_roles =3D fusb302_set_roles,
> +       .start_toggling =3D fusb302_start_toggling,
> +       .pd_transmit =3D fusb302_pd_transmit,
> +       .poll_event =3D fusb302_poll_event,
> +       .enter_low_power_mode =3D fusb302_enter_low_power_mode,
> +};
> +
> +static const struct udevice_id fusb302_ids[] =3D {
> +       { .compatible =3D "fcs,fusb302" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(fusb302) =3D {
> +       .name =3D "fusb302",
> +       .id =3D UCLASS_TCPM,
> +       .of_match =3D fusb302_ids,
> +       .ops =3D &fusb302_ops,
> +       .priv_auto =3D sizeof(struct fusb302_chip),
> +};
> diff --git a/drivers/usb/tcpm/fusb302_reg.h b/drivers/usb/tcpm/fusb302_re=
g.h
> new file mode 100644
> index 000000000000..edc0e4b0f1e6
> --- /dev/null
> +++ b/drivers/usb/tcpm/fusb302_reg.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2016-2017 Google, Inc
> + *
> + * Fairchild FUSB302 Type-C Chip Driver
> + */
> +
> +#ifndef FUSB302_REG_H
> +#define FUSB302_REG_H
> +
> +#define FUSB_REG_DEVICE_ID                     0x01
> +#define FUSB_REG_SWITCHES0                     0x02
> +#define FUSB_REG_SWITCHES0_CC2_PU_EN           BIT(7)
> +#define FUSB_REG_SWITCHES0_CC1_PU_EN           BIT(6)
> +#define FUSB_REG_SWITCHES0_VCONN_CC2           BIT(5)
> +#define FUSB_REG_SWITCHES0_VCONN_CC1           BIT(4)
> +#define FUSB_REG_SWITCHES0_MEAS_CC2            BIT(3)
> +#define FUSB_REG_SWITCHES0_MEAS_CC1            BIT(2)
> +#define FUSB_REG_SWITCHES0_CC2_PD_EN           BIT(1)
> +#define FUSB_REG_SWITCHES0_CC1_PD_EN           BIT(0)
> +#define FUSB_REG_SWITCHES1                     0x03
> +#define FUSB_REG_SWITCHES1_POWERROLE           BIT(7)
> +#define FUSB_REG_SWITCHES1_SPECREV1            BIT(6)
> +#define FUSB_REG_SWITCHES1_SPECREV0            BIT(5)
> +#define FUSB_REG_SWITCHES1_DATAROLE            BIT(4)
> +#define FUSB_REG_SWITCHES1_AUTO_GCRC           BIT(2)
> +#define FUSB_REG_SWITCHES1_TXCC2_EN            BIT(1)
> +#define FUSB_REG_SWITCHES1_TXCC1_EN            BIT(0)
> +#define FUSB_REG_MEASURE                       0x04
> +#define FUSB_REG_MEASURE_MDAC5                 BIT(7)
> +#define FUSB_REG_MEASURE_MDAC4                 BIT(6)
> +#define FUSB_REG_MEASURE_MDAC3                 BIT(5)
> +#define FUSB_REG_MEASURE_MDAC2                 BIT(4)
> +#define FUSB_REG_MEASURE_MDAC1                 BIT(3)
> +#define FUSB_REG_MEASURE_MDAC0                 BIT(2)
> +#define FUSB_REG_MEASURE_VBUS                  BIT(1)
> +#define FUSB_REG_MEASURE_XXXX5                 BIT(0)
> +#define FUSB_REG_CONTROL0                      0x06
> +#define FUSB_REG_CONTROL0_TX_FLUSH             BIT(6)
> +#define FUSB_REG_CONTROL0_INT_MASK             BIT(5)
> +#define FUSB_REG_CONTROL0_HOST_CUR_MASK                (0xC)
> +#define FUSB_REG_CONTROL0_HOST_CUR_HIGH                (0xC)
> +#define FUSB_REG_CONTROL0_HOST_CUR_MED         (0x8)
> +#define FUSB_REG_CONTROL0_HOST_CUR_DEF         (0x4)
> +#define FUSB_REG_CONTROL0_TX_START             BIT(0)
> +#define FUSB_REG_CONTROL1                      0x07
> +#define FUSB_REG_CONTROL1_ENSOP2DB             BIT(6)
> +#define FUSB_REG_CONTROL1_ENSOP1DB             BIT(5)
> +#define FUSB_REG_CONTROL1_BIST_MODE2           BIT(4)
> +#define FUSB_REG_CONTROL1_RX_FLUSH             BIT(2)
> +#define FUSB_REG_CONTROL1_ENSOP2               BIT(1)
> +#define FUSB_REG_CONTROL1_ENSOP1               BIT(0)
> +#define FUSB_REG_CONTROL2                      0x08
> +#define FUSB_REG_CONTROL2_MODE                 BIT(1)
> +#define FUSB_REG_CONTROL2_MODE_MASK            (0x6)
> +#define FUSB_REG_CONTROL2_MODE_DFP             (0x6)
> +#define FUSB_REG_CONTROL2_MODE_UFP             (0x4)
> +#define FUSB_REG_CONTROL2_MODE_DRP             (0x2)
> +#define FUSB_REG_CONTROL2_MODE_NONE            (0x0)
> +#define FUSB_REG_CONTROL2_TOGGLE               BIT(0)
> +#define FUSB_REG_CONTROL3                      0x09
> +#define FUSB_REG_CONTROL3_SEND_HARDRESET       BIT(6)
> +#define FUSB_REG_CONTROL3_BIST_TMODE           BIT(5)  /* 302B Only */
> +#define FUSB_REG_CONTROL3_AUTO_HARDRESET       BIT(4)
> +#define FUSB_REG_CONTROL3_AUTO_SOFTRESET       BIT(3)
> +#define FUSB_REG_CONTROL3_N_RETRIES            BIT(1)
> +#define FUSB_REG_CONTROL3_N_RETRIES_MASK       (0x6)
> +#define FUSB_REG_CONTROL3_N_RETRIES_3          (0x6)
> +#define FUSB_REG_CONTROL3_N_RETRIES_2          (0x4)
> +#define FUSB_REG_CONTROL3_N_RETRIES_1          (0x2)
> +#define FUSB_REG_CONTROL3_AUTO_RETRY           BIT(0)
> +#define FUSB_REG_MASK                          0x0A
> +#define FUSB_REG_MASK_VBUSOK                   BIT(7)
> +#define FUSB_REG_MASK_ACTIVITY                 BIT(6)
> +#define FUSB_REG_MASK_COMP_CHNG                        BIT(5)
> +#define FUSB_REG_MASK_CRC_CHK                  BIT(4)
> +#define FUSB_REG_MASK_ALERT                    BIT(3)
> +#define FUSB_REG_MASK_WAKE                     BIT(2)
> +#define FUSB_REG_MASK_COLLISION                        BIT(1)
> +#define FUSB_REG_MASK_BC_LVL                   BIT(0)
> +#define FUSB_REG_POWER                         0x0B
> +#define FUSB_REG_POWER_PWR                     BIT(0)
> +#define FUSB_REG_POWER_PWR_LOW                 0x1
> +#define FUSB_REG_POWER_PWR_MEDIUM              0x3
> +#define FUSB_REG_POWER_PWR_HIGH                        0x7
> +#define FUSB_REG_POWER_PWR_ALL                 0xF
> +#define FUSB_REG_RESET                         0x0C
> +#define FUSB_REG_RESET_PD_RESET                        BIT(1)
> +#define FUSB_REG_RESET_SW_RESET                        BIT(0)
> +#define FUSB_REG_MASKA                         0x0E
> +#define FUSB_REG_MASKA_OCP_TEMP                        BIT(7)
> +#define FUSB_REG_MASKA_TOGDONE                 BIT(6)
> +#define FUSB_REG_MASKA_SOFTFAIL                        BIT(5)
> +#define FUSB_REG_MASKA_RETRYFAIL               BIT(4)
> +#define FUSB_REG_MASKA_HARDSENT                        BIT(3)
> +#define FUSB_REG_MASKA_TX_SUCCESS              BIT(2)
> +#define FUSB_REG_MASKA_SOFTRESET               BIT(1)
> +#define FUSB_REG_MASKA_HARDRESET               BIT(0)
> +#define FUSB_REG_MASKB                         0x0F
> +#define FUSB_REG_MASKB_GCRCSENT                        BIT(0)
> +#define FUSB_REG_STATUS0A                      0x3C
> +#define FUSB_REG_STATUS0A_SOFTFAIL             BIT(5)
> +#define FUSB_REG_STATUS0A_RETRYFAIL            BIT(4)
> +#define FUSB_REG_STATUS0A_POWER                        BIT(2)
> +#define FUSB_REG_STATUS0A_RX_SOFT_RESET                BIT(1)
> +#define FUSB_REG_STATUS0A_RX_HARD_RESET                BIT(0)
> +#define FUSB_REG_STATUS1A                      0x3D
> +#define FUSB_REG_STATUS1A_TOGSS                        BIT(3)
> +#define FUSB_REG_STATUS1A_TOGSS_RUNNING                0x0
> +#define FUSB_REG_STATUS1A_TOGSS_SRC1           0x1
> +#define FUSB_REG_STATUS1A_TOGSS_SRC2           0x2
> +#define FUSB_REG_STATUS1A_TOGSS_SNK1           0x5
> +#define FUSB_REG_STATUS1A_TOGSS_SNK2           0x6
> +#define FUSB_REG_STATUS1A_TOGSS_AA             0x7
> +#define FUSB_REG_STATUS1A_TOGSS_POS            (3)
> +#define FUSB_REG_STATUS1A_TOGSS_MASK           (0x7)
> +#define FUSB_REG_STATUS1A_RXSOP2DB             BIT(2)
> +#define FUSB_REG_STATUS1A_RXSOP1DB             BIT(1)
> +#define FUSB_REG_STATUS1A_RXSOP                        BIT(0)
> +#define FUSB_REG_INTERRUPTA                    0x3E
> +#define FUSB_REG_INTERRUPTA_OCP_TEMP           BIT(7)
> +#define FUSB_REG_INTERRUPTA_TOGDONE            BIT(6)
> +#define FUSB_REG_INTERRUPTA_SOFTFAIL           BIT(5)
> +#define FUSB_REG_INTERRUPTA_RETRYFAIL          BIT(4)
> +#define FUSB_REG_INTERRUPTA_HARDSENT           BIT(3)
> +#define FUSB_REG_INTERRUPTA_TX_SUCCESS         BIT(2)
> +#define FUSB_REG_INTERRUPTA_SOFTRESET          BIT(1)
> +#define FUSB_REG_INTERRUPTA_HARDRESET          BIT(0)
> +#define FUSB_REG_INTERRUPTB                    0x3F
> +#define FUSB_REG_INTERRUPTB_GCRCSENT           BIT(0)
> +#define FUSB_REG_STATUS0                       0x40
> +#define FUSB_REG_STATUS0_VBUSOK                        BIT(7)
> +#define FUSB_REG_STATUS0_ACTIVITY              BIT(6)
> +#define FUSB_REG_STATUS0_COMP                  BIT(5)
> +#define FUSB_REG_STATUS0_CRC_CHK               BIT(4)
> +#define FUSB_REG_STATUS0_ALERT                 BIT(3)
> +#define FUSB_REG_STATUS0_WAKE                  BIT(2)
> +#define FUSB_REG_STATUS0_BC_LVL_MASK           0x03
> +#define FUSB_REG_STATUS0_BC_LVL_0_200          0x0
> +#define FUSB_REG_STATUS0_BC_LVL_200_600                0x1
> +#define FUSB_REG_STATUS0_BC_LVL_600_1230       0x2
> +#define FUSB_REG_STATUS0_BC_LVL_1230_MAX       0x3
> +#define FUSB_REG_STATUS0_BC_LVL1               BIT(1)
> +#define FUSB_REG_STATUS0_BC_LVL0               BIT(0)
> +#define FUSB_REG_STATUS1                       0x41
> +#define FUSB_REG_STATUS1_RXSOP2                        BIT(7)
> +#define FUSB_REG_STATUS1_RXSOP1                        BIT(6)
> +#define FUSB_REG_STATUS1_RX_EMPTY              BIT(5)
> +#define FUSB_REG_STATUS1_RX_FULL               BIT(4)
> +#define FUSB_REG_STATUS1_TX_EMPTY              BIT(3)
> +#define FUSB_REG_STATUS1_TX_FULL               BIT(2)
> +#define FUSB_REG_INTERRUPT                     0x42
> +#define FUSB_REG_INTERRUPT_VBUSOK              BIT(7)
> +#define FUSB_REG_INTERRUPT_ACTIVITY            BIT(6)
> +#define FUSB_REG_INTERRUPT_COMP_CHNG           BIT(5)
> +#define FUSB_REG_INTERRUPT_CRC_CHK             BIT(4)
> +#define FUSB_REG_INTERRUPT_ALERT               BIT(3)
> +#define FUSB_REG_INTERRUPT_WAKE                        BIT(2)
> +#define FUSB_REG_INTERRUPT_COLLISION           BIT(1)
> +#define FUSB_REG_INTERRUPT_BC_LVL              BIT(0)
> +#define FUSB_REG_FIFOS                         0x43
> +
> +/* Tokens defined for the FUSB302 TX FIFO */
> +enum fusb302_txfifo_tokens {
> +       FUSB302_TKN_TXON =3D 0xA1,
> +       FUSB302_TKN_SYNC1 =3D 0x12,
> +       FUSB302_TKN_SYNC2 =3D 0x13,
> +       FUSB302_TKN_SYNC3 =3D 0x1B,
> +       FUSB302_TKN_RST1 =3D 0x15,
> +       FUSB302_TKN_RST2 =3D 0x16,
> +       FUSB302_TKN_PACKSYM =3D 0x80,
> +       FUSB302_TKN_JAMCRC =3D 0xFF,
> +       FUSB302_TKN_EOP =3D 0x14,
> +       FUSB302_TKN_TXOFF =3D 0xFE,
> +};
> +
> +#endif
> --
> 2.45.2
>
