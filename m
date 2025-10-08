Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29861CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 10:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9A28394A;
	Wed,  8 Oct 2025 12:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="SNXqtTXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB9D8394E; Wed,  8 Oct 2025 12:49:52 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C10A8393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 12:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5FF291030D5; Wed,  8 Oct 2025 12:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759920589;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=w4cMj24BbS1xLjadLPUGaFJnlIwgC3DXCFDeLZoKFgM=;
 b=SNXqtTXI145MAzi6M5my6IPfBIQvwy41MWfwuLTN66A7pMWDfpqolNff7MqL055jxfIgNR
 +OVSksu/s0gbtAV5w19PSBBMCtO20751ZUK6KZZd6WbspsuXbSrTfIhSm5ZlAYKyXH1AhL
 0hGPs4qPP2nSDr2rfnw6HUDFZyhJFz8TZm4Y0IkrHuKABs/bxVuqCqjG23jwq2Yz70rvFs
 dyveJRXXyOVv5EVIsXMqBCcnnptKyfJsUDTSw0Ko69Ghlcft33V9hA8oiiZUkuKH8mx+uQ
 A1jCSvevoVgSup3w5pYlP0sB6fy2F+r6ZKnittrcugYpM6InRmwXVFyFGBxaJg==
Message-ID: <37009072-adf9-01a2-7ecd-ce509967c216@nabladev.com>
Date: Wed, 8 Oct 2025 12:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: add support for the MT7621 I2C controller
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>, u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Tom Rini <trini@konsulko.com>
References: <20251008102256.26660-1-justin.swartz@risingedge.co.za>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251008102256.26660-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Justin,

On 08.10.25 12:22, Justin Swartz wrote:
> This commit introduces a port of the Linux kernel's driver for the
> Mediatek's MT7621 I2C controller.
> 
> The port was undertaken as the existing driver intended for Mediatek
> I2C controllers (mtk_i2c.c) is not compatible with the MT7621.
> 
> To use the driver:
> 
>    1.  Ensure that the mode of the i2c pin group is
>        configured for "i2c" rather than "gpio".
> 
>    2.  Delete the existing (bitbanged) i2c node from
>        arch/mips/dts/mt7621.dtsi, or specify:
> 
>          /delete-node/ &i2c;
> 
>    3.  Declare:
> 
>          i2c: i2c@1e000900 {
>                  compatible = "mediatek,mt7621-i2c";
>                  reg = <0x1e000900 0x100>;
> 
>                  clocks = <&clk50m>;
>                  clock-names = "sys_clock";
> 
>                  resets = <&rstctrl RST_I2C>;
>                  reset-names = "i2c_reset";
> 
>                  pinctrl-names = "default";
>                  pinctrl-0 = <&i2c_pins>;
> 
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  status = "okay";
>          };
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
> 
> Notes:
>      [PATCH v2]
>      
>      - Add "REG_" prefix to I2C (Serial Master 0) register definitions.
>      - Remove unused "PINT" (Peripheral Interrupt) register definitions.
>      - Adjust function definition style.
>      
>      - Refactor mt7621_i2c_check_ack() to accept the number of bytes
>        expected to have been acknowledged, instead of accepting a
>        literal value (which represents the acknowledgement status of
>        (up to) 8 bytes, encoded as 8 independent bit values) expected
>        in the SM0_ACK field (bits 23:16) of the SM0CTL1 register.
> 
>   drivers/i2c/Kconfig      |   7 +
>   drivers/i2c/Makefile     |   1 +
>   drivers/i2c/mt7621_i2c.c | 372 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 380 insertions(+)
>   create mode 100644 drivers/i2c/mt7621_i2c.c

Thanks, some nitpicks...

[...]
> diff --git a/drivers/i2c/mt7621_i2c.c b/drivers/i2c/mt7621_i2c.c
> new file mode 100644
> index 00000000000..292e582fd8d
> --- /dev/null
> +++ b/drivers/i2c/mt7621_i2c.c
> @@ -0,0 +1,372 @@
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
> +#define REG_SM0CFG2                   0x28
> +#define REG_SM0CTL0                   0x40
> +#define REG_SM0CTL1                   0x44
> +#define REG_SM0D0                     0x50
> +#define REG_SM0D1                     0x54
> +
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
> +#define SM0CTL1_PGLEN(x)              ((((x) - 1) << 8) & SM0CTL1_PGLEN_MASK)
> +#define SM0CTL1_PGLEN_MASK            (0x7 << 8)
> +#define SM0CTL1_ACK_MASK              (0xff << 16)
> +
> +#define TIMEOUT_1SEC                  1000
> +#define I2C_MAX_STD_MODE_FREQ         100000
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
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	ulong start_time = get_timer(0);
> +	u32 value;
> +
> +	while (get_timer(start_time) < TIMEOUT_1SEC) {
> +		value = readl(priv->base + REG_SM0CTL1);
> +		if ((value & SM0CTL1_TRI) == SM0CTL1_TRI_IDLE)
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
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	u32 value;
> +	
> +	reset_assert(&priv->reset_ctl);
> +	udelay(100);
> +	reset_deassert(&priv->reset_ctl);
> +	
> +	value = readl(priv->base + REG_SM0CTL0);
> +	value &= ~SM0CTL0_CLK_DIV_MASK;
> +	value |= (priv->clk_div << 16) & SM0CTL0_CLK_DIV_MASK;
> +	value |= SM0CTL0_EN | SM0CTL0_SCL_STRETCH;
> +	writel(value, priv->base + REG_SM0CTL0);
> +
> +	writel(SM0CFG2_MODE_MANUAL, priv->base + REG_SM0CFG2);
> +	return 0;
> +}
> +
> +static int mt7621_i2c_master_start(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);

one empty line please after variable declaration please.
fix this please for all functions

> +	writel(SM0CTL1_START | SM0CTL1_TRI, priv->base + REG_SM0CTL1);
> +	return mt7621_i2c_wait_idle(dev);
> +}
> +
> +static int mt7621_i2c_master_stop(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	writel(SM0CTL1_STOP | SM0CTL1_TRI, priv->base + REG_SM0CTL1);
> +	return mt7621_i2c_wait_idle(dev);
> +}
> +
> +static int mt7621_i2c_master_cmd(struct udevice *dev, u32 cmd, int len)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	writel(cmd | SM0CTL1_TRI | SM0CTL1_PGLEN(len),
> +	       priv->base + REG_SM0CTL1);
> +	return mt7621_i2c_wait_idle(dev);
> +}
> +
> +static int mt7621_i2c_7bit_address(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +
> +	u32 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) ? 1 : 0);

please add here an empty line, and remove the above empty line

> +	writel(addr, priv->base + REG_SM0D0);
> +
> +	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 1);
> +}
> +
> +static int mt7621_i2c_10bit_address(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +
> +	u16 addr = 0xf0 | ((msg->addr >> 7) & 0x06) | (msg->addr & 0xff) << 8;

here too,

> +	if (msg->flags & I2C_M_RD)
> +		addr |= 1;

and here...

> +	writel(addr, priv->base + REG_SM0D0);
> +
> +	return mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, 2);
> +}
> +
> +static int mt7621_i2c_address(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	int ret;
> +
> +	if (msg->flags & I2C_M_TEN) {
> +		ret = mt7621_i2c_10bit_address(dev, msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	else {

please make this into one line
"""
} else {
"""

> +		ret = mt7621_i2c_7bit_address(dev, msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt7621_i2c_check_ack(struct udevice *dev, struct i2c_msg *msg,
> +				u32 length)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +
> +	if (msg->flags & I2C_M_IGNORE_NAK)
> +		return 0;

Does this not drop a compiler warning? Please do not mix declaration
and code...

> +
> +	u32 status = *(volatile u32 *)(priv->base + REG_SM0CTL1);
> +	u32 expected = GENMASK(length - 1, 0);
> +	u32 mask = (expected << 16) & SM0CTL1_ACK_MASK;
> +	
> +	if ((status & mask) != mask)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
> +static int mt7621_i2c_master_read(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	int offset, length, last, ret;
> +	u32 cmd;
> +	u32 data[2];
> +
> +	for (offset = 0; offset < msg->len; offset += 8) {
> +		if (msg->len - offset >= 8)
> +			length = 8;
> +		else
> +			length = msg->len - offset;
> +
> +		last = msg->len - offset <= 8;
> +		cmd = last ? SM0CTL1_READ_LAST : SM0CTL1_READ;
> +		ret = mt7621_i2c_master_cmd(dev, cmd, length);
> +		if (ret)
> +			return ret;
> +
> +		data[0] = readl(priv->base + REG_SM0D0);
> +		data[1] = readl(priv->base + REG_SM0D1);
> +		memcpy(&msg->buf[offset], data, length);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt7621_i2c_master_write(struct udevice *dev, struct i2c_msg *msg)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	int offset, length, ret;
> +	u32 data[2];
> +
> +	for (offset = 0; offset < msg->len; offset += 8) {
> +		if (msg->len - offset >= 8)
> +			length = 8;
> +		else
> +			length = msg->len - offset;
> +
> +		memcpy(data, &msg->buf[offset], length);
> +		writel(data[0], priv->base + REG_SM0D0);
> +		writel(data[1], priv->base + REG_SM0D1);
> +		
> +		ret = mt7621_i2c_master_cmd(dev, SM0CTL1_WRITE, length);
> +		if (ret)
> +			return ret;
> +		
> +		ret = mt7621_i2c_check_ack(dev, msg, length);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt7621_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
> +{
> +	struct i2c_msg *msg;
> +	int index, ret;
> +	
> +	for (index = 0; index < count; index++) {
> +		msg = &msgs[index];
> +		
> +		ret = mt7621_i2c_wait_idle(dev);
> +		if (ret)
> +			goto reset;
> +		
> +		ret = mt7621_i2c_master_start(dev);
> +		if (ret)
> +			goto reset;
> +		
> +		ret = mt7621_i2c_address(dev, msg);
> +		if (ret)
> +			goto reset;
> +		
> +		ret = mt7621_i2c_check_ack(dev, msg, 1);
> +		if (ret)
> +			goto stop;
> +		
> +		if (msg->flags & I2C_M_RD) {
> +			ret = mt7621_i2c_master_read(dev, msg);
> +			if (ret)
> +				goto reset;
> +		}
> +		else {

please "} else {"

> +			ret = mt7621_i2c_master_write(dev, msg);
> +			if (ret)
> +				goto reset;
> +		}
> +	}
> +	
> +	ret = mt7621_i2c_wait_idle(dev);
> +	if (ret)
> +		goto reset;
> +
> +	ret = mt7621_i2c_master_stop(dev);
> +	if (ret)
> +		goto reset;
> +	
> +	return 0;
> +	
> +stop:
> +	ret = mt7621_i2c_master_stop(dev);
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
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	ulong clk_rate = clk_get_rate(&priv->clk);
> +
> +	priv->speed = speed;
> +	priv->clk_div = clk_rate / priv->speed - 1;
> +
> +	if (priv->clk_div < 99)
> +		priv->clk_div = 99;
> +
> +	if (priv->clk_div > SM0CTL0_CLK_DIV_MAX)
> +		priv->clk_div = SM0CTL0_CLK_DIV_MAX;
> +	
> +	return 0;
> +}
> +
> +static const struct dm_i2c_ops mt7621_i2c_ops = {
> +	.xfer          = mt7621_i2c_xfer,
> +	.set_bus_speed = mt7621_i2c_set_speed,
> +	.deblock       = mt7621_i2c_reset,
> +};
> +
> +static int mt7621_i2c_of_to_plat(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	priv->base = dev_remap_addr(dev);
> +	return 0;
> +}
> +
> +int mt7621_i2c_probe(struct udevice *dev)
> +{
> +	struct mt7621_i2c_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	priv->base = dev_remap_addr(dev);
> +	if (!priv->base) {
> +		dev_err(dev, "failed to get base address\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_get_by_name(dev, "sys_clock", &priv->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to get clock source\n");
> +		return ret;
> +	}
> +
> +	ret = reset_get_by_name(dev, "i2c_reset", &priv->reset_ctl);
> +	if (ret) {
> +		dev_err(dev, "failed to get reset control\n");
> +		return ret;
> +	}
> +
> +	ret = clk_enable(&priv->clk);
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
> +static const struct udevice_id mt7621_i2c_ids[] = {
> +	{ .compatible = "mediatek,mt7621-i2c" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(mt7621_i2c) = {
> +	.name       = "mt7621_i2c",
> +	.id         = UCLASS_I2C,
> +	.of_match   = mt7621_i2c_ids,
> +	.of_to_plat = mt7621_i2c_of_to_plat,
> +	.probe      = mt7621_i2c_probe,
> +	.priv_auto  = sizeof(struct mt7621_i2c_priv),
> +	.ops        = &mt7621_i2c_ops,
> +};
> 

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
