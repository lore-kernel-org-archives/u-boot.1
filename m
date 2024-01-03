Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193DAC47073
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEFD8771B;
	Wed,  3 Jan 2024 20:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJkwZRMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32439874AC; Wed,  3 Jan 2024 20:31:54 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 794A087775
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9b760610bso609563b3a.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704310307; x=1704915107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUr95NFETEo25gqDDXLmHjHpm9wp+s6rd5OX6/mDtV4=;
 b=aJkwZRMyOFQwe17cHu1wHjBUnGJpatT9IvlBLc/e+nvVdV+vjPshoU1pjmMN0WB5aI
 4YhxOfLgXgwHELB41H9iZe3K9gzQIj8xL9mxiMcboZQQHsUsDh44rmUtGDqGTXnlVjCx
 cu16Lgg/IE3ZsMFkJisdmVzKm48BemCu+R8H47Vx9eYP31vyOcF13059FG6iSt7SOZy6
 OBqNMKEfq6pNHfDUYO/MurEjP8sQ9xU4jNGBszkcz+wP6JzcpQmTrQMQqzc5UdItrYC3
 pAtQjjTct8S6Xm3P1j5wE50xcF3Z9ofbMdFxlAHrTbqZ6BMFm1Ms0sxpztIu115gC9U2
 sJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704310307; x=1704915107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUr95NFETEo25gqDDXLmHjHpm9wp+s6rd5OX6/mDtV4=;
 b=UZDpPTy97vaWKUNMkl4IYHiiU1TcCoZYKzGPEHK6dlOEq6AB/v35Rdg7bptQQagXwc
 SK7z/mOb3+/G7s+KPfTNfEo/A43K6kR75fyCARkgwpUatT4EJY+m2KRhBhNVkKArdP6r
 owzXgW3XR555swaC9I+cnw8BnfG4FTJMWZfl8Ls/hgeiZPZ0nHC2tSA2CgGisOL2k2FM
 gEXegMq2ASJUS6/l3cW+91ex/UyPQYPJOp9VKaE9XYMByr4tRmI9PrN/V0Uv86wIimAn
 JQMLd6U4oewgRIdZc4QsU9mmtUqZ+iXRfLldHLaTi3oNIbmWEehpdLyHik5IEQUtRAN1
 miow==
X-Gm-Message-State: AOJu0YyyoWk01zXltOrwJa+p322PQkaGrOu6DKwQPBfjT/0RI/zdF+H0
 YPkeegcCR7XrHsYW1PSMjMm9xwVf5dAtPLwcDqU=
X-Google-Smtp-Source: AGHT+IGggsttOz0lJPvDyPtlU5fMBeShd6mz7T9EyQFE6RxMgtpn02nQ7GPCdxAj0oNj6+obHaCPg+wZ9+fih5tFngo=
X-Received: by 2002:a05:6a00:658d:b0:6d9:edd1:4ede with SMTP id
 hd13-20020a056a00658d00b006d9edd14edemr23623930pfb.2.1704310306042; Wed, 03
 Jan 2024 11:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20231229111701.10696-1-othacehe@gnu.org>
 <20231229111701.10696-4-othacehe@gnu.org>
In-Reply-To: <20231229111701.10696-4-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 16:31:34 -0300
Message-ID: <CAOMZO5B-mrLdm1yYMEZq8+Gbn64VNua3fcmB2LfQ6AzOi5B8xg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Add imx93-var-som support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

Hi Mathieu,

On Fri, Dec 29, 2023 at 8:17=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> From: Mathieu Othacehe <m.othacehe@gmail.com>
>
> Add support for the Variscite VAR-SOM-IMX93 evaluation kit. The SoM
> consists of an NXP iMX93 dual A55 CPU. The SoM is mounted on a Variscite
> Symphony SBC.
>
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>

I applied this patch against U-Boot's next branch.

I had to manually add:

--- a/board/variscite/imx93_var_som/spl.c
+++ b/board/variscite/imx93_var_som/spl.c
@@ -21,6 +21,7 @@
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch-mx7ulp/gpio.h>
 #include <asm/mach-imx/syscounter.h>
+#include <asm/sections.h>
 #include <dm/uclass.h>
 #include <dm/device.h>
 #include <dm/uclass-internal.h>

so that it can be built.

Also noticed some checkpatch warnings:

ERROR: Do not add common.h to files
#802: FILE: board/variscite/common/eth.c:5:
+#include <common.h>

ERROR: Do not add common.h to files
#886: FILE: board/variscite/common/imx9_eeprom.c:6:
+#include <common.h>

ERROR: Do not add common.h to files
#1172: FILE: board/variscite/common/mmc.c:7:
+#include <common.h>

ERROR: Do not add common.h to files
#1296: FILE: board/variscite/imx93_var_som/imx93_var_som.c:7:
+#include <common.h>

ERROR: Do not add common.h to files
#3050: FILE: board/variscite/imx93_var_som/spl.c:7:
+#include <common.h>

and also got a warning when applying it:

$ git am ~/Downloads/Add-imx93-var-som-support.patch
Applying: spl: binman: Disable u_boot_any symbols for i.MX93 boards
Applying: mach-imx: Add i.MX93 binman support.
Applying: Add imx93-var-som support
.git/rebase-apply/patch:3025: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

> --- /dev/null
> +++ b/arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +#include "imx93-u-boot.dtsi"

This file should be included by default. No need to manually include it.

> diff --git a/board/variscite/common/eth.c b/board/variscite/common/eth.c
> new file mode 100644
> index 00000000000..9e05dee51c2
> --- /dev/null
> +++ b/board/variscite/common/eth.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 Variscite Ltd.
> + */
> +#include <common.h>
> +#include <net.h>
> +#include <miiphy.h>
> +#include <env.h>
> +#include "../common/imx9_eeprom.h"
> +
> +#define CHAR_BIT 8
> +
> +static u64 mac2int(const u8 hwaddr[])
> +{
> +       s8 i;

Why does i need to be signed?

> +       u64 ret =3D 0;
> +       const u8 *p =3D hwaddr;
> +
> +       for (i =3D 5; i >=3D 0; i--)
> +               ret |=3D (u64)*p++ << (CHAR_BIT * i);
> +
> +       return ret;
> +}
> +
> +static void int2mac(const u64 mac, u8 *hwaddr)
> +{
> +       s8 i;

Ditto.

> +int var_carrier_eeprom_read(const char *bus_name, int addr, struct var_c=
arrier_eeprom *ep)
> +{
> +       int ret;
> +       struct udevice *bus;
> +       struct udevice *dev;
> +
> +       ret =3D uclass_get_device_by_name(UCLASS_I2C, bus_name, &bus);
> +       if (ret) {
> +               debug("%s: No bus '%s'\n", __func__, bus_name);
> +               return ret;
> +       }
> +
> +       ret =3D dm_i2c_probe(bus, addr, 0, &dev);
> +       if (ret) {
> +               debug("%s: Carrier EEPROM I2C probe failed\n", __func__);
> +               return ret;
> +       }
> +
> +       /* Read EEPROM to memory */
> +       ret =3D dm_i2c_read(dev, 0, (void *)ep, sizeof(*ep));
> +       if (ret) {
> +               debug("%s: Carrier EEPROM read failed, ret=3D%d\n", __fun=
c__, ret);
> +               return ret;

Better print all these error messages.


> +       return 0;
> +}
> +
> +int var_carrier_eeprom_is_valid(struct var_carrier_eeprom *ep)
> +{
> +       u32 crc, crc_offset =3D offsetof(struct var_carrier_eeprom, crc);
> +
> +       if (htons(ep->magic) !=3D VAR_CARRIER_EEPROM_MAGIC) {
> +               debug("Invalid carrier EEPROM magic 0x%x, expected 0x%x\n=
",

Same here.

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2023 Variscite Ltd.
> + */
> +
> +#include <common.h>
> +#include <env.h>
> +#include <init.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/arch-imx9/imx93_pins.h>
> +#include <asm/arch/clock.h>
> +#include <power/pmic.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <usb.h>
> +#include <dwc3-uboot.h>

These USB-related header files could be removed.

> +       /* SDRAM ENV */
> +       snprintf(sdram_size_str, SDRAM_SIZE_STR_LEN, "%d",
> +                (int)(gd->ram_size / 1024 / 1024));
> +       env_set("sdram_size", sdram_size_str);
> +
> +       /* Carrier Board ENV */
> +       var_carrier_eeprom_read(VAR_CARRIER_EEPROM_I2C_NAME, CARRIER_EEPR=
OM_ADDR, &carrier_eeprom);

No error checking?

> +       var_carrier_eeprom_get_revision(&carrier_eeprom, carrier_rev, siz=
eof(carrier_rev));

No error checking?

> diff --git a/board/variscite/imx93_var_som/imx93_var_som.env b/board/vari=
scite/imx93_var_som/imx93_var_som.env
> new file mode 100644
> index 00000000000..84814e6d935
> --- /dev/null
> +++ b/board/variscite/imx93_var_som/imx93_var_som.env
> @@ -0,0 +1,104 @@
> +initrd_addr=3D0x83800000
> +emmc_dev=3D0

Not used anywhere. Please remove it.

> +sd_dev=3D1

Not used anywhere. Please remove it.

> +scriptaddr=3D0x83500000

Not used anywhere. Please remove it.

> +kernel_addr_r=3D __stringify(CONFIG_SYS_LOAD_ADDR)

Not used anywhere. Please remove it.

> +image=3DImage.gz
> +img_addr=3D0x82000000
> +splashimage=3D0x90000000

There is no splash screen support. Please remove it.

> +console=3DttyLP0,115200 earlycon

earlycon is only useful for development. Please remove it.

> +#include <linux/kernel.h>
> +#include <asm/arch/ddr.h>
> +
> +struct dram_cfg_param ddr_ddrc_cfg[] =3D {

Please make it 'static'.

> +/* ddr phy trained csr */
> +struct dram_cfg_param ddr_ddrphy_trained_csr[] =3D {

Please make it 'static'.

> +struct dram_fsp_msg ddr_dram_fsp_msg[] =3D {
Please make it 'static'.

> +#include <common.h>
> +#include <command.h>
> +#include <cpu_func.h>
> +#include <hang.h>

Is this needed?

> +Get and Build the ARM Trusted firmware
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get ATF from: https://github.com/varigit/imx-atf
> +branch: lf_v2.8_var02

Please use a more generic repo, such as NXP https://github.com/nxp-imx/imx-=
atf/
branch: lf_v2.8

> +/* Using ULP WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR

Not needed to be done in this series, but in the future, it would be
nice to convert this wdog driver to DM.
