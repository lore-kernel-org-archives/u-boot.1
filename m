Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E500BCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 06:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13A48394E;
	Wed,  8 Oct 2025 08:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DVSdwjZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE80839A7; Wed,  8 Oct 2025 08:25:36 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58FF83942
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 08:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5986PW4d240897;
 Wed, 8 Oct 2025 01:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759904732;
 bh=o2tPLHQ6MDk9gvtpSH4xAwFoJ2wXJXrynzHzIydAaMU=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=DVSdwjZacnlrVUtERHDQjUIFb+0fXr7EKhVfBxEQzCytcgylvKbEJ0V+Qob7/Xd0M
 QQS5Omb1iCp5mQ+L9W9AnFBvVC5BTrDqlOY70n/nQcmfC6vyhwAImWQtWjnRdp8u1H
 0B6pnw+kv9aDwemdK1coDHMKi55TXOjFl2GfgepY=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5986PVQJ441261
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Oct 2025 01:25:31 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 01:25:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 01:25:31 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5986PUn42339033;
 Wed, 8 Oct 2025 01:25:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 8 Oct 2025 11:55:30 +0530
Message-ID: <DDCQ5RP50L04.1YSUG6EFNTU84@ti.com>
Subject: Re: [PATCH] i2c: add support for the MT7621 I2C controller
From: Anshul Dalal <anshuld@ti.com>
To: Justin Swartz <justin.swartz@risingedge.co.za>, <u-boot@lists.denx.de>
CC: Weijie Gao <weijie.gao@mediatek.com>, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251006230659.8021-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20251006230659.8021-1-justin.swartz@risingedge.co.za>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Justin,

On Tue Oct 7, 2025 at 4:36 AM IST, Justin Swartz wrote:
> This commit introduces a port of the Linux kernel's driver for the
> Mediatek's MT7621 I2C controller.
>
> The port was undertaken as the existing driver intended for Mediatek
> I2C controllers (mtk_i2c.c) is not compatible with the MT7621.
>
> To use the driver:
>
>   1.  Ensure that the mode of the i2c pin group is
>       configured for "i2c" rather than "gpio".
>
>   2.  Delete the existing (bitbanged) i2c node from
>       arch/mips/dts/mt7621.dtsi, or specify:
>
>         /delete-node/ &i2c;
>
>   3.  Declare:
>
>         i2c: i2c@1e000900 {
>                 compatible =3D "mediatek,mt7621-i2c";
>                 reg =3D <0x1e000900 0x100>;
>
>                 clocks =3D <&clk50m>;
>                 clock-names =3D "sys_clock";
>
>                 resets =3D <&rstctrl RST_I2C>;
>                 reset-names =3D "i2c_reset";
>
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&i2c_pins>;
>
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 status =3D "okay";
>         };
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  drivers/i2c/Kconfig      |   7 +
>  drivers/i2c/Makefile     |   1 +
>  drivers/i2c/mt7621_i2c.c | 378 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 386 insertions(+)
>  create mode 100644 drivers/i2c/mt7621_i2c.c
>
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 108b24b3dd2..bdd3c60118c 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -308,6 +308,13 @@ config SYS_I2C_MTK
>  	  If you want to use MediaTek I2C interface, say Y here.
>  	  If unsure, say N.
> =20
> +config SYS_I2C_MT7621
> +	bool "Mediatek MT7621 I2C driver"
> +	help
> +	  This selects the Mediatek MT7621 I2C driver.
> +	  If you want to use the MediaTek MT7621 I2C controller, say Y here.
> +	  If unsure, say N.
> +
>  config SYS_I2C_MICROCHIP
>  	bool "Microchip I2C driver"
>  	help
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index 42326db85f6..5fe30d0df4f 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_SYS_I2C_MV) +=3D mv_i2c.o
>  obj-$(CONFIG_SYS_I2C_MVTWSI) +=3D mvtwsi.o
>  obj-$(CONFIG_SYS_I2C_MXC) +=3D mxc_i2c.o
>  obj-$(CONFIG_SYS_I2C_MTK) +=3D mtk_i2c.o
> +obj-$(CONFIG_SYS_I2C_MT7621) +=3D mt7621_i2c.o
>  obj-$(CONFIG_SYS_I2C_NEXELL) +=3D nx_i2c.o
>  obj-$(CONFIG_SYS_I2C_NPCM) +=3D npcm_i2c.o
>  obj-$(CONFIG_SYS_I2C_OCORES) +=3D ocores_i2c.o
> diff --git a/drivers/i2c/mt7621_i2c.c b/drivers/i2c/mt7621_i2c.c
> new file mode 100644
> index 00000000000..82b75dde957
> --- /dev/null
> +++ b/drivers/i2c/mt7621_i2c.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot driver for the MediaTek MT7621 I2C controller.
> + *
> + * Derived from the Linux kernel driver:
> + *   drivers/i2c/busses/i2c-mt7621.c
> + *
> + * Copyright (C) 2013 Steven Liu <steven_liu@mediatek.com>
> + * Copyright (C) 2014 Sittisak <sittisaks@hotmail.com>
> + * Copyright (C) 2016 Michael Lee <igvtee@gmail.com>
> + * Copyright (C) 2018 Jan Breuer <jan.breuer@jaybee.cz>
> + * Copyright (C) 2025 Justin Swartz <justin.swartz@risingedge.co.za>
> + */
> +
> +#include <asm/io.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/printk.h>
> +#include <dm.h>
> +#include <clk.h>
> +#include <common.h>
> +#include <i2c.h>
> +#include <log.h>
> +#include <reset.h>
> +
> +#define SM0CFG2                       0x28
> +#define SM0CTL0                       0x40
> +#define SM0CTL1                       0x44
> +#define SM0D0                         0x50
> +#define SM0D1                         0x54

Are these macros for the registers of the peripheral? If so, they should
be appended with '_REG' to make it more clear.

> +#define PINTEN                        0x5c
> +#define PINTST                        0x60
> +#define PINTCL                        0x64
> +

We are not making use of these macros in the driver, are they necessary?

> +#define SM0CFG2_MODE_MANUAL           0
> +
> +#define SM0CTL0_ODRAIN                BIT(31)
> +#define SM0CTL0_CLK_DIV_MASK          (0x7ff << 16)
> +#define SM0CTL0_CLK_DIV_MAX           0x7ff
> +#define SM0CTL0_EN                    BIT(1)
> +#define SM0CTL0_SCL_STRETCH           BIT(0)
> +
> +#define SM0CTL1_TRI                   BIT(0)
> +#define SM0CTL1_TRI_IDLE              0
> +#define SM0CTL1_START                 (1 << 4)
> +#define SM0CTL1_WRITE                 (2 << 4)
> +#define SM0CTL1_STOP                  (3 << 4)
> +#define SM0CTL1_READ_LAST             (4 << 4)
> +#define SM0CTL1_READ                  (5 << 4)
> +#define SM0CTL1_PGLEN(x)              ((((x) - 1) << 8) & SM0CTL1_PGLEN_=
MASK)
> +#define SM0CTL1_PGLEN_MASK            (0x7 << 8)
> +#define SM0CTL1_ACK_MASK              (0xff << 16)
> +
> +#define TIMEOUT_1SEC                  1000
> +#define I2C_MAX_STD_MODE_FREQ         100000
> +
> +#define MASK(n)                       (BIT(n) - 1)

We could use GENMASK(n, 0) in place of this macro.

> +
> +struct mt7621_i2c_priv
> +{
> +	void __iomem *base;
> +	uint speed;
> +	u32 clk_div;
> +	struct clk clk;
> +	struct reset_ctl reset_ctl;
> +};
> +
> +static int mt7621_i2c_wait_idle(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	ulong start_time =3D get_timer(0);
> +	u32 value;
> +
> +	while (get_timer(start_time) < TIMEOUT_1SEC) {
> +		value =3D readl(priv->base + SM0CTL1);
> +		if ((value & SM0CTL1_TRI) =3D=3D SM0CTL1_TRI_IDLE)
> +			return 0;
> +
> +		udelay(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int mt7621_i2c_reset(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	u32 value;
> +=09
> +	reset_assert(&priv->reset_ctl);
> +	udelay(100);
> +	reset_deassert(&priv->reset_ctl);
> +=09
> +	value =3D readl(priv->base + SM0CTL0);
> +	value &=3D ~SM0CTL0_CLK_DIV_MASK;
> +	value |=3D (priv->clk_div << 16) & SM0CTL0_CLK_DIV_MASK;
> +	value |=3D SM0CTL0_EN | SM0CTL0_SCL_STRETCH;
> +	writel(value, priv->base + SM0CTL0);
> +
> +	writel(SM0CFG2_MODE_MANUAL, priv->base + SM0CFG2);
> +	return 0;
> +}
> +
> +static int mt7621_i2c_master_start(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	writel(SM0CTL1_START | SM0CTL1_TRI, priv->base + SM0CTL1);
> +	return mt7621_i2c_wait_idle(dev);
> +}
> +
> +static int mt7621_i2c_master_stop(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	writel(SM0CTL1_STOP | SM0CTL1_TRI, priv->base + SM0CTL1);
> +	return mt7621_i2c_wait_idle(dev);
> +}
> +
> +static int mt7621_i2c_master_cmd(struct udevice *dev, u32 cmd, int len)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	writel(cmd | SM0CTL1_TRI | SM0CTL1_PGLEN(len), priv->base + SM0CTL1);
> +	return mt7621_i2c_wait_idle(dev);
> +}
> +
> +static int mt7621_i2c_7bit_address(struct udevice *dev, struct i2c_msg *=
msg)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +
> +	u32 addr =3D (msg->addr << 1) | ((msg->flags & I2C_M_RD) ? 1 : 0);
> +	writel(addr, priv->base + SM0D0);
> +
> +	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 1);
> +}
> +
> +static int mt7621_i2c_10bit_address(struct udevice *dev, struct i2c_msg =
*msg)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +
> +	u16 addr =3D 0xf0 | ((msg->addr >> 7) & 0x06) | (msg->addr & 0xff) << 8=
;
> +	if (msg->flags & I2C_M_RD)
> +		addr |=3D 1;
> +	writel(addr, priv->base + SM0D0);
> +
> +	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 2);
> +}
> +
> +static int mt7621_i2c_address(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	int ret;
> +
> +	if (msg->flags & I2C_M_TEN) {
> +		ret =3D mt7621_i2c_10bit_address(dev, msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	else {
> +		ret =3D mt7621_i2c_7bit_address(dev, msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mt7621_i2c_check_ack(struct udevice *dev, struct i2c_msg *msg, u32 expec=
ted)
> +{

This should instead be formatted as:

static int mt7621_i2c_check_ack(struct udevice *dev, struct i2c_msg *msg,
				u32 expected)
{
	...
}

And same for the following functions.

Regards,
Anshul

> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +
> +	if (msg->flags & I2C_M_IGNORE_NAK)
> +		return 0;
> +
> +	u32 status =3D *(volatile u32 *)(priv->base + SM0CTL1);
> +	u32 mask =3D (expected << 16) & SM0CTL1_ACK_MASK;
> +=09
> +	if ((status & mask) !=3D mask)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
> +static int
> +mt7621_i2c_master_read(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	int offset, length, last, ret;
> +	u32 cmd;
> +	u32 data[2];
> +
> +	for (offset =3D 0; offset < msg->len; offset +=3D 8) {
> +		if (msg->len - offset >=3D 8)
> +			length =3D 8;
> +		else
> +			length =3D msg->len - offset;
> +
> +		last =3D msg->len - offset <=3D 8;
> +		cmd =3D last ? SM0CTL1_READ_LAST : SM0CTL1_READ;
> +		ret =3D mt7621_i2c_master_cmd(dev, cmd, length);
> +		if (ret)
> +			return ret;
> +
> +		data[0] =3D readl(priv->base + SM0D0);
> +		data[1] =3D readl(priv->base + SM0D1);
> +		memcpy(&msg->buf[offset], data, length);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mt7621_i2c_master_write(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	int offset, length, ret;
> +	u32 data[2];
> +
> +	for (offset =3D 0; offset < msg->len; offset +=3D 8) {
> +		if (msg->len - offset >=3D 8)
> +			length =3D 8;
> +		else
> +			length =3D msg->len - offset;
> +
> +		memcpy(data, &msg->buf[offset], length);
> +		writel(data[0], priv->base + SM0D0);
> +		writel(data[1], priv->base + SM0D1);
> +	=09
> +		ret =3D mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, length);
> +		if (ret)
> +			return ret;
> +	=09
> +		ret =3D mt7621_i2c_check_ack(dev, msg, MASK(length));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mt7621_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
> +{
> +	struct i2c_msg *msg;
> +	int index, ret;
> +=09
> +	for (index =3D 0; index < count; index++) {
> +		msg =3D &msgs[index];
> +	=09
> +		ret =3D mt7621_i2c_wait_idle(dev);
> +		if (ret)
> +			goto reset;
> +	=09
> +		ret =3D mt7621_i2c_master_start(dev);
> +		if (ret)
> +			goto reset;
> +	=09
> +		ret =3D mt7621_i2c_address(dev, msg);
> +		if (ret)
> +			goto reset;
> +	=09
> +		ret =3D mt7621_i2c_check_ack(dev, msg, BIT(0));
> +		if (ret)
> +			goto stop;
> +	=09
> +		if (msg->flags & I2C_M_RD) {
> +			ret =3D mt7621_i2c_master_read(dev, msg);
> +			if (ret)
> +				goto reset;
> +		}
> +		else {
> +			ret =3D mt7621_i2c_master_write(dev, msg);
> +			if (ret)
> +				goto reset;
> +		}
> +	}
> +=09
> +	ret =3D mt7621_i2c_wait_idle(dev);
> +	if (ret)
> +		goto reset;
> +
> +	ret =3D mt7621_i2c_master_stop(dev);
> +	if (ret)
> +		goto reset;
> +=09
> +	return 0;
> +=09
> +stop:
> +	ret =3D mt7621_i2c_master_stop(dev);
> +	if (ret)
> +		goto reset;
> +	return -ENXIO;
> +
> +reset:
> +	mt7621_i2c_reset(dev);
> +	return ret;
> +}
> +
> +static int mt7621_i2c_set_speed(struct udevice *dev, uint speed)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	ulong clk_rate =3D clk_get_rate(&priv->clk);
> +
> +	priv->speed =3D speed;
> +	priv->clk_div =3D clk_rate / priv->speed - 1;
> +
> +	if (priv->clk_div < 99)
> +		priv->clk_div =3D 99;
> +
> +	if (priv->clk_div > SM0CTL0_CLK_DIV_MAX)
> +		priv->clk_div =3D SM0CTL0_CLK_DIV_MAX;
> +=09
> +	return 0;
> +}
> +
> +static const struct dm_i2c_ops mt7621_i2c_ops =3D {
> +	.xfer          =3D mt7621_i2c_xfer,
> +	.set_bus_speed =3D mt7621_i2c_set_speed,
> +	.deblock       =3D mt7621_i2c_reset,
> +};
> +
> +static int mt7621_i2c_of_to_plat(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	priv->base =3D dev_remap_addr(dev);
> +	return 0;
> +}
> +
> +int mt7621_i2c_probe(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv =3D dev_get_priv(dev);
> +	int ret;
> +
> +	priv->base =3D dev_remap_addr(dev);
> +	if (!priv->base) {
> +		dev_err(dev, "failed to get base address\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D clk_get_by_name(dev, "sys_clock", &priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to get clock source\n");
> +		return ret;
> +	}
> +
> +	ret =3D reset_get_by_name(dev, "i2c_reset", &priv->reset_ctl);
> +	if (ret) {
> +		dev_err(dev, "failed to get reset control\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_enable(&priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	mt7621_i2c_set_speed(dev, I2C_MAX_STD_MODE_FREQ);
> +	mt7621_i2c_reset(dev);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id mt7621_i2c_ids[] =3D {
> +	{ .compatible =3D "mediatek,mt7621-i2c" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(mt7621_i2c) =3D {
> +	.name       =3D "mt7621_i2c",
> +	.id         =3D UCLASS_I2C,
> +	.of_match   =3D mt7621_i2c_ids,
> +	.of_to_plat =3D mt7621_i2c_of_to_plat,
> +	.probe      =3D mt7621_i2c_probe,
> +	.priv_auto  =3D sizeof(struct mt7621_i2c_priv),
> +	.ops        =3D &mt7621_i2c_ops,
> +};

