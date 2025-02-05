Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859A1C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 11:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AEE800B3;
	Wed,  5 Feb 2025 12:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="REeEqZZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDC1805E7; Wed,  5 Feb 2025 12:09:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE34E80040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 12:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B6E835C693C;
 Wed,  5 Feb 2025 11:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6435C4CED1;
 Wed,  5 Feb 2025 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738753750;
 bh=Mqc9wjDP+9X+7BTxJFuTIqaqj8OjX1+QwRfIVv/Scmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=REeEqZZvvpa1MHtAl3PuTzs56KG4LEWyWdv5PoLOvU5UlnBOG/EStDzeNzGOcxrn8
 Lv/CGj2ACFxM2jsyJsALB4NK2nQUGCuFYJlyxeM/D6BIrU4+Abj8jF8GA5HkhWjtyD
 nBglJQhc8ecIMswcJ0lO2LcKWfdH5LNdqMqgNfkRINfXjvUt9nPnrRn61eiaogwppJ
 26dTaChR3+PKRqLaCSHpKpmfWugVuw25mZfmsWTFpvtjzfmaOJfol6g+Apxskveg84
 g0nMrSX3OmT8tTiyPEVlcbhryVd3E3dtvjqqAWEO4dskkjCe8eStw7WY+Hpp0xlfdw
 QzebucdDbjwZQ==
Date: Wed, 5 Feb 2025 12:09:02 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 11/20] drivers: gpio: add support of RP1 GPIO for
 Raspberry PI 5
Message-ID: <jt6m5lrewwhn67cmc56zaitgklldok73i5vm76quraeqogt7af@l5wytci4amzg>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <3f36c2863ec3dfc5efe297b80c25e315a59260e5.1738749764.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f36c2863ec3dfc5efe297b80c25e315a59260e5.1738749764.git.oleksii_moisieiev@epam.com>
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

On Wed, Feb 05, 2025 at 10:15:45AM +0000, Oleksii Moisieiev wrote:

...

> +#define RP1_PAD_DRIVE_LSB		4
> +#define RP1_PAD_IN_ENABLE_MASK		0x00000040
> +#define RP1_PAD_IN_ENABLE_LSB		6
> +#define RP1_PAD_OUT_DISABLE_MASK	0x00000080
> +#define RP1_PAD_OUT_DISABLE_LSB		7
> +
> +#define RP1_PAD_DRIVE_2MA		0x00000000
> +#define RP1_PAD_DRIVE_4MA		0x00000010
> +#define RP1_PAD_DRIVE_8MA		0x00000020
> +#define RP1_PAD_DRIVE_12MA		0x00000030

Can we use enumerator for these, instead of preprocessor macros?

Also in addition to BI(), can we use GENMASK() and FIELD_PREP_CONST(),
i.e.:

enum {
	...
	RP1_PAD_DRIVE_MASK = GENMASK(7, 4),
	RP1_PAD_DRIVE_2MA  = FIELD_PREP_CONST(RP1_PAD_DRIVE_MASK, 0),
	RP1_PAD_DRIVE_4MA  = FIELD_PREP_CONST(RP1_PAD_DRIVE_MASK, 1),
	RP1_PAD_DRIVE_8MA  = FIELD_PREP_CONST(RP1_PAD_DRIVE_MASK, 2),
	RP1_PAD_DRIVE_12MA = FIELD_PREP_CONST(RP1_PAD_DRIVE_MASK, 3),
	...
};

You need to import FIELD_PREP_CONST() into include/linux/bitfield.h,
from Linux sources, since we don't have it in U-Boot yet.


> +#define FLD_GET(r, f) (((r) & (f ## _MASK)) >> (f ## _LSB))
> +#define FLD_SET(r, f, v) r = (((r) & ~(f ## _MASK)) | ((v) << (f ## _LSB)))

Use FIELD_GET and FIELD_SET.

...

> +static void rp1_pad_update(struct rp1_pin_info *pin, u32 clr, u32 set)
> +{
> +	u32 padctrl = readl(pin->pad);
> +
> +	padctrl &= ~clr;
> +	padctrl |= set;
> +
> +	writel(padctrl, pin->pad);
> +}

Instead of implementing your own function, you can just use
clrsetbits_le32() ...

...

> +static void rp1_set_fsel(struct rp1_pin_info *pin, u32 fsel)
> +{
> +	u32 ctrl = readl(pin->gpio + RP1_GPIO_CTRL);
> +
> +	if (fsel >= RP1_FSEL_COUNT)
> +		fsel = RP1_FSEL_NONE_HW;
> +
> +	rp1_input_enable(pin, 1);
> +	rp1_output_enable(pin, 1);

Shouldn't this be done with one read-modify-write? It seems to be doing
two read-modify-writes to one register.

> +
> +	if (fsel == RP1_FSEL_NONE) {
> +		FLD_SET(ctrl, RP1_GPIO_CTRL_OEOVER, RP1_OEOVER_DISABLE);
> +	} else {
> +		FLD_SET(ctrl, RP1_GPIO_CTRL_OUTOVER, RP1_OUTOVER_PERI);
> +		FLD_SET(ctrl, RP1_GPIO_CTRL_OEOVER, RP1_OEOVER_PERI);
> +	}
> +	FLD_SET(ctrl, RP1_GPIO_CTRL_FUNCSEL, fsel);
> +
> +	writel(ctrl, pin->gpio + RP1_GPIO_CTRL);
> +}
> +
> +static int rp1_get_dir(struct rp1_pin_info *pin)
> +{
> +	return !(readl(pin->rio + RP1_RIO_OE) & (1 << pin->offset)) ?
> +		RP1_DIR_INPUT : RP1_DIR_OUTPUT;

Why use own constants (RP1_DIR_INPUT/OUTPUT) ?
1 << pin->offset  should be  BIT(pin->offset). This happens more time in
the subsequent code.

> +}
> +
> +static void rp1_set_dir(struct rp1_pin_info *pin, bool is_input)
> +{
> +	int offset = is_input ? RP1_CLR_OFFSET : RP1_SET_OFFSET;

size_t offset

> +
> +	writel(1 << pin->offset, pin->rio + RP1_RIO_OE + offset);
> +}
> +
> +static int rp1_get_value(struct rp1_pin_info *pin)
> +{
> +	return !!(readl(pin->rio + RP1_RIO_IN) & (1 << pin->offset));
> +}
> +
> +static void rp1_set_value(struct rp1_pin_info *pin, int value)
> +{
> +	/* Assume the pin is already an output */
> +	writel(1 << pin->offset,
> +	       pin->rio + RP1_RIO_OUT + (value ? RP1_SET_OFFSET : RP1_CLR_OFFSET));

In rp1_set_dir() you have helper variable offset, why not here?

> +}
> +
> +static int rp1_gpio_get(struct udevice *dev, unsigned int offset)
> +{
> +	struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +	int ret;
> +
> +	if (!pin)
> +		return -EINVAL;
> +
> +	ret = rp1_get_value(pin);
> +	return ret;

return rp1_get_value(pin); ? And you can drop the ret variable and save
two lines.

> +}
> +
> +static int rp1_gpio_set(struct udevice *dev, unsigned int offset, int value)
> +{
> +	struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +
> +	if (pin)
> +		rp1_set_value(pin, value);

Shouldn't this return some error if pin is NULL?

> +	return 0;
> +}
> +
> +static int rp1_gpio_direction_input(struct udevice *dev, unsigned int offset)
> +{
> +	struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +
> +	if (!pin)
> +		return -EINVAL;
> +
> +	rp1_set_dir(pin, RP1_DIR_INPUT);
> +	rp1_set_fsel(pin, RP1_FSEL_GPIO);

Empty line before return.

> +	return 0;
> +}
> +
> +static int rp1_gpio_direction_output(struct udevice *dev, unsigned int offset, int value)
> +{
> +	struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +
> +	if (!pin)
> +		return -EINVAL;
> +
> +	rp1_set_value(pin, value);
> +	rp1_set_dir(pin, RP1_DIR_OUTPUT);
> +	rp1_set_fsel(pin, RP1_FSEL_GPIO);

Empty line before return.

> +	return 0;
> +}
> +
> +static int rp1_gpio_get_direction(struct udevice *dev, unsigned int offset)
> +{
> +	struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +	u32 fsel;
> +
> +	if (!pin)
> +		return -EINVAL;
> +
> +	fsel = rp1_get_fsel(pin);
> +	if (fsel != RP1_FSEL_GPIO)
> +		return -EINVAL;
> +
> +	return (rp1_get_dir(pin) == RP1_DIR_OUTPUT) ?
> +			GPIOF_OUTPUT :
> +			GPIOF_INPUT;

rp1_get_dir() could have already returned GPIOF_INPUT/OUTPUT instead of
the custom constants.

> +}
> +
> +static const struct dm_gpio_ops rp1_gpio_ops = {
> +	.direction_input = rp1_gpio_direction_input,
> +	.direction_output = rp1_gpio_direction_output,
> +	.get_value = rp1_gpio_get,
> +	.set_value = rp1_gpio_set,
> +	.get_function = rp1_gpio_get_direction,
> +};

Align the '=' with tabs.

> +
> +static int rp1_gpio_probe(struct udevice *dev)
> +{
> +	int i;
> +	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	struct rp1_gpio_priv *priv = dev_get_priv(dev);

Reverse christmas tree variables declaration if possible:
	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
	struct rp1_gpio_priv *priv = dev_get_priv(dev);
	int i;

But you don't need declaring i here, see below.

> +
> +	priv->gpio_base = dev_remap_addr_index(dev, 0);
> +	if (!priv->gpio_base)
> +		return -EINVAL;
> +
> +	priv->rio_base = dev_remap_addr_index(dev, 1);
> +	if (!priv->rio_base)
> +		return -EINVAL;
> +
> +	priv->pads_base = dev_remap_addr_index(dev, 2);
> +	if (!priv->pads_base)
> +		return -EINVAL;
> +
> +	uc_priv->gpio_count = RP1_NUM_GPIOS;
> +	uc_priv->bank_name = dev->name;
> +
> +	for (i = 0; i < RP1_NUM_BANKS; i++) {

	for (int i = 0; ...)

> +		const struct rp1_iobank_desc *bank = &rp1_iobanks[i];
> +		int j;
> +
> +		for (j = 0; j < bank->num_gpios; j++) {

		for (int j = 0; ...)

> +			struct rp1_pin_info *pin =
> +				&priv->pins[bank->min_gpio + j];
> +
> +			pin->num = bank->min_gpio + j;
> +			pin->bank = i;
> +			pin->offset = j;
> +
> +			pin->gpio = priv->gpio_base + bank->gpio_offset +
> +				    j * sizeof(u32) * 2;
> +			pin->inte = priv->gpio_base + bank->inte_offset;
> +			pin->ints = priv->gpio_base + bank->ints_offset;
> +			pin->rio  = priv->rio_base + bank->rio_offset;
> +			pin->pad  = priv->pads_base + bank->pads_offset +
> +				    j * sizeof(u32);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id rp1_gpio_ids[] = {
> +	{ .compatible = "raspberrypi,rp1-gpio" },
> +	{ /* sentinel */ }

No need to write the sentinel comment. IMO we should drop this from all
drivers that use it.

> +};
> +
> +U_BOOT_DRIVER(rp1_gpio) = {
> +	.name = "rp1-gpio",
> +	.id = UCLASS_GPIO,
> +	.of_match = rp1_gpio_ids,
> +	.ops = &rp1_gpio_ops,
> +	.priv_auto	= sizeof(struct rp1_gpio_priv),
> +	.probe = rp1_gpio_probe,

Align '=' with tabs.

Marek
