Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B4DE7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C0C8748F;
	Tue,  3 Oct 2023 15:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jlf9oo0V";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M+PcW+kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1425987484; Tue,  3 Oct 2023 15:40:59 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971938725E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S0Jqr3pfVz9spF;
 Tue,  3 Oct 2023 15:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMN9NFXw4KjmT17f+p8ytrbqW8Tjp7P9sueS2Ckpd4M=;
 b=jlf9oo0VZyOBYgnGRNMG5DBiRsL2n2W0OjlmXSjKP9EkXOJ1Y2EignlxEcBUv7/YFGhhEW
 iOB2bawq9r9Y+jnzeq4EadBpQpqeNsi8NtK2VA/Etqs3y+gl4mSeZCShyS9x9NFkR5T6lL
 GoAVh5IGm6TotCAGo3RLBa26TpeWIZcKQ0VxU8no/TN/ZykcDdT3T/FaJERgQxBOwD3mZu
 bSlU1Ayb3pgUAPd6d8MatZJW5yH9zkxDwejDbKEvlmXCQqbR6LnKo/6bVwvR8UslgBHIrv
 Wn1F93jG60Mez3/YlCNXTMGM0NtKraGLctFzq9HyUD1p6sN68Jxib0YjK2ImrA==
Message-ID: <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMN9NFXw4KjmT17f+p8ytrbqW8Tjp7P9sueS2Ckpd4M=;
 b=M+PcW+klwyaqk7FX9kp6wl5WPcnP3tKEqnLVeMgC1Z+q2tKMoHeKcjXqVFCaq906XNe2/6
 qmO2Jbb3EUL8nkBvZd50OoGwR3EHbCNGuLWqNZ3Zoov+fqPC7sgWLD6zVLyrqgsZGPceYq
 S4WL5oN7JOBu5hyN9ngyTsl/F3G4vU8dWZICqW25CFg3vEHPOZgirLBQE7xssVKuKLaxB1
 /1LR93y/T+RKtIltjxrotJhOWcTub+9Zu64I5sQHBfTdjZAFVWtFcGyWri0TsbFlXn+QSw
 htOZj00ZiS1ZDJU3wjXAK/49x5bVJtVCXnMQ4bOPTW7u8vHKqbr4Nd3pk3P8IQ==
Date: Tue, 3 Oct 2023 15:20:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6955f289b678b55c2b7
X-MBO-RS-META: uw17ruz1g1rypsn9ddnzs8rpzyq6yyjy
X-Rspamd-Queue-Id: 4S0Jqr3pfVz9spF
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

On 9/20/23 14:42, Paul Barker wrote:
> This driver provides pinctrl and gpio control for the Renesas RZ/G2L
> (R9A07G044) SoC.
> 
> This patch is based on the corresponding Linux v6.5 driver.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig       |   1 +
>   drivers/pinctrl/renesas/Kconfig     |   9 +
>   drivers/pinctrl/renesas/Makefile    |   1 +
>   drivers/pinctrl/renesas/rzg2l-pfc.c | 906 ++++++++++++++++++++++++++++
>   4 files changed, 917 insertions(+)
>   create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index 91f544c78337..973e84fcf7ba 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -76,6 +76,7 @@ config RZG2L
>   	imply SYS_MALLOC_F
>   	imply RENESAS_SDHI
>   	imply CLK_RZG2L
> +	imply PINCTRL_RZG2L

Keep the list sorted

[...]

Drop the parenthesis around values please, fix globally and in other 
patches too.

> +#define PWPR			(0x3014)
> +#define SD_CH(n)		(0x3000 + (n) * 4)
> +#define QSPI			(0x3008)
> +
> +#define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
> +#define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
> +
> +#define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
> +#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
> +
> +#define PM_MASK			0x03
> +#define PVDD_MASK		0x01
> +#define PFC_MASK		0x07
> +#define IEN_MASK		0x01
> +#define IOLH_MASK		0x03
> +
> +#define PM_HIGH_Z		0x0
> +#define PM_INPUT		0x1
> +#define PM_OUTPUT		0x2
> +#define PM_OUTPUT_IEN		0x3
> +
> +struct rzg2l_pfc_driver_data {
> +	uint num_dedicated_pins;
> +	uint num_ports;
> +	const u32 *gpio_configs;
> +};
> +
> +struct rzg2l_pfc_data {
> +	void __iomem *base;
> +	uint num_dedicated_pins;
> +	uint num_ports;
> +	uint num_pins;
> +	const u32 *gpio_configs;
> +	bool pfc_enabled;
> +};
> +
> +struct rzg2l_dedicated_configs {
> +	const char *name;
> +	u32 config;
> +};
> +
> +/*
> + * We need to ensure that the module clock is enabled and all resets are
> + * de-asserted before using either the gpio or pinctrl functionality. Error
> + * handling can be quite simple here as if the PFC cannot be enabled then we
> + * will not be able to progress with the boot anyway.
> + */
> +static int rzg2l_pfc_enable(struct udevice *dev)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	struct reset_ctl_bulk rsts;
> +	struct clk clk;
> +	int ret;
> +
> +	if (data->pfc_enabled)

When does this get triggered ?

> +		return 0;

[...]

> +static int rzg2l_gpio_set_value(struct udevice *dev, unsigned int offset,
> +				int value)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 port = RZG2L_PINMUX_TO_PORT(offset);
> +	u8 pin = RZG2L_PINMUX_TO_PIN(offset);

A lot of this can also be const

> +	rzg2l_gpio_set(data, port, pin, (bool)value);
> +	return 0;
> +}
> +
> +static void rzg2l_gpio_set_direction(struct rzg2l_pfc_data *data,
> +				     u32 port, u8 pin, bool output)
> +{
> +	u16 reg16;
> +
> +	reg16 = readw(data->base + PM(port));
> +	reg16 &= ~(PM_MASK << (pin * 2));

See clrsetbits_le32() function and co .

> +	reg16 |= (output ? PM_OUTPUT : PM_INPUT) << (pin * 2);
> +	writew(reg16, data->base + PM(port));
> +}
> +
> +static int rzg2l_gpio_direction_input(struct udevice *dev, unsigned int offset)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 port = RZG2L_PINMUX_TO_PORT(offset);
> +	u8 pin = RZG2L_PINMUX_TO_PIN(offset);
> +
> +	rzg2l_gpio_set_direction(data, port, pin, false);
> +	return 0;
> +}
> +
> +static int rzg2l_gpio_direction_output(struct udevice *dev, unsigned int offset,
> +				       int value)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 port = RZG2L_PINMUX_TO_PORT(offset);
> +	u8 pin = RZG2L_PINMUX_TO_PIN(offset);
> +
> +	rzg2l_gpio_set(data, port, pin, (bool)value);
> +	rzg2l_gpio_set_direction(data, port, pin, true);
> +	return 0;
> +}
> +
> +static int rzg2l_gpio_request(struct udevice *dev, unsigned int offset,
> +			      const char *label)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 port = RZG2L_PINMUX_TO_PORT(offset);
> +	u8 pin = RZG2L_PINMUX_TO_PIN(offset);
> +	u8 reg8;
> +
> +	if (!rzg2l_port_validate(data, port, pin)) {
> +		dev_err(dev, "Invalid GPIO %u:%u\n", port, pin);
> +		return -EINVAL;
> +	}
> +
> +	/* Select GPIO mode in PMC Register */
> +	reg8 = readb(data->base + PMC(port));
> +	reg8 &= ~BIT(pin);
> +	writeb(reg8, data->base + PMC(port));

clrbits here too

> +	return 0;
> +}
> +
> +static int rzg2l_gpio_get_function(struct udevice *dev, unsigned int offset)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 port = RZG2L_PINMUX_TO_PORT(offset);
> +	u8 pin = RZG2L_PINMUX_TO_PIN(offset);
> +	u16 pm_state;
> +	u8 pmc_state;
> +
> +	if (!rzg2l_port_validate(data, port, pin)) {
> +		/* Running `gpio status -a` at the u-boot command line will
> +		 * iterate through all GPIO offsets with no understanding of
> +		 * which are valid and which are not. So we need to return
> +		 * something meaningful even for the invalid GPIOs.
> +		 */
> +		return GPIOF_UNKNOWN;

Would it make sense to add some GPIOF_SKIP flag and handle it in the 
command to avoid displaying invalid GPIOs ?

> +	}
> +
> +	/* Check if the pin is in GPIO or function mode. */
> +	pmc_state = readb(data->base + PMC(port)) & BIT(pin);
> +	if (pmc_state)
> +		return GPIOF_FUNC;
> +
> +	/* Check the pin direction. */
> +	pm_state = (readw(data->base + PM(port)) >> (pin * 2)) & PM_MASK;
> +	switch (pm_state) {
> +	case PM_INPUT:
> +		return GPIOF_INPUT;
> +	case PM_OUTPUT:
> +	case PM_OUTPUT_IEN:
> +		return GPIOF_OUTPUT;
> +	default:	/* PM_HIGH_Z */
> +		return GPIOF_UNUSED;
> +	}
> +}
> +
> +static const struct dm_gpio_ops rzg2l_gpio_ops = {
> +	.direction_input	= rzg2l_gpio_direction_input,
> +	.direction_output	= rzg2l_gpio_direction_output,
> +	.get_value		= rzg2l_gpio_get_value,
> +	.set_value		= rzg2l_gpio_set_value,
> +	.request		= rzg2l_gpio_request,
> +	.get_function		= rzg2l_gpio_get_function,
> +};
> +
> +static int rzg2l_gpio_probe(struct udevice *dev)
> +{
> +	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
> +	struct ofnode_phandle_args args;
> +	int ret;
> +
> +	uc_priv->bank_name = "rzg2l-pfc-gpio";
> +	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
> +					     NULL, 3, 0, &args);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to parse gpio-ranges\n");

It is a good idea to include the return value in error message to ease 
debugging.

> +		return -EINVAL;
> +	}
> +
> +	uc_priv->gpio_count = args.args[2];
> +	return rzg2l_pfc_enable(dev);
> +}
> +
> +U_BOOT_DRIVER(rzg2l_pfc_gpio) = {
> +	.name		= "rzg2l-pfc-gpio",
> +	.id		= UCLASS_GPIO,
> +	.ops		= &rzg2l_gpio_ops,
> +	.probe		= rzg2l_gpio_probe,
> +};

Can you please split the GPIO and PFC drivers into separate files ?

> +static const char * const rzg2l_gpio_names[] = {
> +	"P0_0", "P0_1", "P0_2", "P0_3", "P0_4", "P0_5", "P0_6", "P0_7",
> +	"P1_0", "P1_1", "P1_2", "P1_3", "P1_4", "P1_5", "P1_6", "P1_7",
> +	"P2_0", "P2_1", "P2_2", "P2_3", "P2_4", "P2_5", "P2_6", "P2_7",
> +	"P3_0", "P3_1", "P3_2", "P3_3", "P3_4", "P3_5", "P3_6", "P3_7",
> +	"P4_0", "P4_1", "P4_2", "P4_3", "P4_4", "P4_5", "P4_6", "P4_7",
> +	"P5_0", "P5_1", "P5_2", "P5_3", "P5_4", "P5_5", "P5_6", "P5_7",
> +	"P6_0", "P6_1", "P6_2", "P6_3", "P6_4", "P6_5", "P6_6", "P6_7",
> +	"P7_0", "P7_1", "P7_2", "P7_3", "P7_4", "P7_5", "P7_6", "P7_7",
> +	"P8_0", "P8_1", "P8_2", "P8_3", "P8_4", "P8_5", "P8_6", "P8_7",
> +	"P9_0", "P9_1", "P9_2", "P9_3", "P9_4", "P9_5", "P9_6", "P9_7",
> +	"P10_0", "P10_1", "P10_2", "P10_3", "P10_4", "P10_5", "P10_6", "P10_7",
> +	"P11_0", "P11_1", "P11_2", "P11_3", "P11_4", "P11_5", "P11_6", "P11_7",
> +	"P12_0", "P12_1", "P12_2", "P12_3", "P12_4", "P12_5", "P12_6", "P12_7",
> +	"P13_0", "P13_1", "P13_2", "P13_3", "P13_4", "P13_5", "P13_6", "P13_7",
> +	"P14_0", "P14_1", "P14_2", "P14_3", "P14_4", "P14_5", "P14_6", "P14_7",
> +	"P15_0", "P15_1", "P15_2", "P15_3", "P15_4", "P15_5", "P15_6", "P15_7",
> +	"P16_0", "P16_1", "P16_2", "P16_3", "P16_4", "P16_5", "P16_6", "P16_7",
> +	"P17_0", "P17_1", "P17_2", "P17_3", "P17_4", "P17_5", "P17_6", "P17_7",
> +	"P18_0", "P18_1", "P18_2", "P18_3", "P18_4", "P18_5", "P18_6", "P18_7",
> +	"P19_0", "P19_1", "P19_2", "P19_3", "P19_4", "P19_5", "P19_6", "P19_7",
> +	"P20_0", "P20_1", "P20_2", "P20_3", "P20_4", "P20_5", "P20_6", "P20_7",
> +	"P21_0", "P21_1", "P21_2", "P21_3", "P21_4", "P21_5", "P21_6", "P21_7",
> +	"P22_0", "P22_1", "P22_2", "P22_3", "P22_4", "P22_5", "P22_6", "P22_7",
> +	"P23_0", "P23_1", "P23_2", "P23_3", "P23_4", "P23_5", "P23_6", "P23_7",
> +	"P24_0", "P24_1", "P24_2", "P24_3", "P24_4", "P24_5", "P24_6", "P24_7",
> +	"P25_0", "P25_1", "P25_2", "P25_3", "P25_4", "P25_5", "P25_6", "P25_7",
> +	"P26_0", "P26_1", "P26_2", "P26_3", "P26_4", "P26_5", "P26_6", "P26_7",
> +	"P27_0", "P27_1", "P27_2", "P27_3", "P27_4", "P27_5", "P27_6", "P27_7",
> +	"P28_0", "P28_1", "P28_2", "P28_3", "P28_4", "P28_5", "P28_6", "P28_7",
> +	"P29_0", "P29_1", "P29_2", "P29_3", "P29_4", "P29_5", "P29_6", "P29_7",
> +	"P30_0", "P30_1", "P30_2", "P30_3", "P30_4", "P30_5", "P30_6", "P30_7",
> +	"P31_0", "P31_1", "P31_2", "P31_3", "P31_4", "P31_5", "P31_6", "P31_7",
> +	"P32_0", "P32_1", "P32_2", "P32_3", "P32_4", "P32_5", "P32_6", "P32_7",
> +	"P33_0", "P33_1", "P33_2", "P33_3", "P33_4", "P33_5", "P33_6", "P33_7",
> +	"P34_0", "P34_1", "P34_2", "P34_3", "P34_4", "P34_5", "P34_6", "P34_7",
> +	"P35_0", "P35_1", "P35_2", "P35_3", "P35_4", "P35_5", "P35_6", "P35_7",
> +	"P36_0", "P36_1", "P36_2", "P36_3", "P36_4", "P36_5", "P36_6", "P36_7",
> +	"P37_0", "P37_1", "P37_2", "P37_3", "P37_4", "P37_5", "P37_6", "P37_7",
> +	"P38_0", "P38_1", "P38_2", "P38_3", "P38_4", "P38_5", "P38_6", "P38_7",
> +	"P39_0", "P39_1", "P39_2", "P39_3", "P39_4", "P39_5", "P39_6", "P39_7",
> +	"P40_0", "P40_1", "P40_2", "P40_3", "P40_4", "P40_5", "P40_6", "P40_7",
> +	"P41_0", "P41_1", "P41_2", "P41_3", "P41_4", "P41_5", "P41_6", "P41_7",
> +	"P42_0", "P42_1", "P42_2", "P42_3", "P42_4", "P42_5", "P42_6", "P42_7",
> +	"P43_0", "P43_1", "P43_2", "P43_3", "P43_4", "P43_5", "P43_6", "P43_7",
> +	"P44_0", "P44_1", "P44_2", "P44_3", "P44_4", "P44_5", "P44_6", "P44_7",
> +	"P45_0", "P45_1", "P45_2", "P45_3", "P45_4", "P45_5", "P45_6", "P45_7",
> +	"P46_0", "P46_1", "P46_2", "P46_3", "P46_4", "P46_5", "P46_6", "P46_7",
> +	"P47_0", "P47_1", "P47_2", "P47_3", "P47_4", "P47_5", "P47_6", "P47_7",
> +	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
> +};
> +
> +static const u32 r9a07g044_gpio_configs[] = {
> +	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x28, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x29, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(3, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
> +	RZG2L_GPIO_PORT_PACK(2, 0x36, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x37, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
> +	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
> +};
> +
> +static const struct {
> +	struct rzg2l_dedicated_configs common[35];
> +	struct rzg2l_dedicated_configs rzg2l_pins[7];
> +} rzg2l_dedicated_pins = {
> +	.common = {
> +		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
> +		 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
> +		{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
> +		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
> +		{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
> +		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
> +		{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x4, 0, PIN_CFG_IEN) },
> +		{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x4, 1, PIN_CFG_IEN) },
> +		{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x6, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x6, 2,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x7, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x7, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x7, 2,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x7, 3,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x7, 4,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x7, 5,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x7, 6,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x7, 7,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
> +		{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x8, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD1)) },
> +		{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x8, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
> +		{ "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x9, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
> +		{ "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x9, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
> +		{ "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x9, 2,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
> +		{ "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x9, 3,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
> +		{ "QSPI0_SPCLK", RZG2L_SINGLE_PIN_PACK(0xa, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0xa, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0xa, 2,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0xa, 3,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0xa, 4,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI0_SSL", RZG2L_SINGLE_PIN_PACK(0xa, 5,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI_RESET#", RZG2L_SINGLE_PIN_PACK(0xc, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI_WP#", RZG2L_SINGLE_PIN_PACK(0xc, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0xd, 0, (PIN_CFG_IOLH_A | PIN_CFG_SR)) },
> +		{ "RIIC0_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 0, PIN_CFG_IEN) },
> +		{ "RIIC0_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 1, PIN_CFG_IEN) },
> +		{ "RIIC1_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 2, PIN_CFG_IEN) },
> +		{ "RIIC1_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 3, PIN_CFG_IEN) },
> +	},
> +	.rzg2l_pins = {
> +		{ "QSPI_INT#", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI1_SPCLK", RZG2L_SINGLE_PIN_PACK(0xb, 0,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI1_IO0", RZG2L_SINGLE_PIN_PACK(0xb, 1,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI1_IO1", RZG2L_SINGLE_PIN_PACK(0xb, 2,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI1_IO2", RZG2L_SINGLE_PIN_PACK(0xb, 3,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI1_IO3", RZG2L_SINGLE_PIN_PACK(0xb, 4,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR  | PIN_CFG_IO_VMC_QSPI)) },
> +		{ "QSPI1_SSL", RZG2L_SINGLE_PIN_PACK(0xb, 5,
> +		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
> +	}
> +};
> +
> +static void rzg2l_rmw_pin_config(struct rzg2l_pfc_data *data, u32 offset,
> +				 u8 pin, u32 mask, u32 val)
> +{
> +	void __iomem *addr = data->base + offset;
> +	u32 reg;
> +
> +	/* handle _L/_H for 32-bit register read/write */
> +	if (pin >= 4) {
> +		pin -= 4;
> +		addr += 4;
> +	}
> +
> +	reg = readl(addr) & ~(mask << (pin * 8));
> +	writel(reg | (val << (pin * 8)), addr);

clkbits_le32()

> +}
> +
> +static int rzg2l_get_pins_count(struct udevice *dev)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +
> +	return data->num_dedicated_pins + data->num_pins;
> +}
> +
> +static const char *rzg2l_get_pin_name(struct udevice *dev, unsigned int selector)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	int port;
> +	u8 pin;
> +
> +	if (selector < data->num_dedicated_pins) {
> +		if (selector >= ARRAY_SIZE(rzg2l_dedicated_pins.common)) {
> +			unsigned int u = selector - ARRAY_SIZE(rzg2l_dedicated_pins.common);
> +			return rzg2l_dedicated_pins.rzg2l_pins[u].name;
> +		} else {
> +			return rzg2l_dedicated_pins.common[selector].name;
> +		}
> +	}
> +
> +	port = rzg2l_selector_decode(data, selector, &pin);
> +	if (port < 0)
> +		return "(invalid pin)";
> +	return rzg2l_gpio_names[pin + 8 * port];
> +}
> +
> +static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
> +			     unsigned int param, unsigned int argument)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 cfg, port_offset;
> +	u8 pin;
> +
> +	if (pin_selector >= data->num_dedicated_pins) {
> +		/* The pin selector refers to a multiplexed pin */
> +		int port = rzg2l_selector_decode(data, pin_selector, &pin);
> +		if (port < 0) {
> +			dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
> +			return port;
> +		}
> +
> +		cfg = data->gpio_configs[port];
> +		port_offset = port + 0x10;

What does 0x10 mean ? A macro would help .

> +	} else {
> +		/* The pin selector refers to a dedicated function pin */
> +		const struct rzg2l_dedicated_configs *dedicated_config;
> +
> +		if (pin_selector >= data->num_dedicated_pins) {
> +			dev_err(dev, "Invalid dedicated pin %u\n", pin_selector);
> +			return -EINVAL;
> +		}
> +
> +		if (pin_selector >= ARRAY_SIZE(rzg2l_dedicated_pins.common)) {
> +			pin_selector -= ARRAY_SIZE(rzg2l_dedicated_pins.common);
> +			dedicated_config = &rzg2l_dedicated_pins.rzg2l_pins[pin_selector];
> +		} else {
> +			dedicated_config = &rzg2l_dedicated_pins.common[pin_selector];
> +		}
> +
> +		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(dedicated_config->config);
> +		pin = RZG2L_SINGLE_PIN_GET_BIT(dedicated_config->config);
> +		cfg = RZG2L_SINGLE_PIN_GET_CFGS(dedicated_config->config);
> +	}
> +
> +	switch (param) {
> +	case PIN_CONFIG_INPUT_ENABLE: {
> +		if (!(cfg & PIN_CFG_IEN)) {
> +			dev_err(dev, "pin does not support IEN\n");
> +			return -EINVAL;
> +		}
> +
> +		dev_dbg(dev, "port off %u:%u set IEN=%u\n",
> +			port_offset, pin, argument);
> +		rzg2l_rmw_pin_config(data, IEN(port_offset), pin, IEN_MASK, !!argument);
> +		break;
> +	}
> +
> +	case PIN_CONFIG_POWER_SOURCE: {
> +		void __iomem *addr;
> +		u32 pwr_reg = 0x0;
> +
> +		/* argument is in mV */
> +		if (argument != 1800 && argument != 3300) {
> +			dev_err(dev, "Invalid mV %u\n", argument);
> +			return -EINVAL;
> +		}
> +
> +		if (cfg & PIN_CFG_IO_VMC_SD0) {
> +			dev_dbg(dev, "port off %u:%u set SD_CH 0 PVDD=%u\n",
> +				port_offset, pin, argument);
> +			pwr_reg = SD_CH(0);
> +		} else if (cfg & PIN_CFG_IO_VMC_SD1) {
> +			dev_dbg(dev, "port off %u:%u set SD_CH 1 PVDD=%u\n",
> +				port_offset, pin, argument);
> +			pwr_reg = SD_CH(1);
> +		} else if (cfg & PIN_CFG_IO_VMC_QSPI) {
> +			dev_dbg(dev, "port off %u:%u set QSPI PVDD=%u\n",
> +				port_offset, pin, argument);
> +			pwr_reg = QSPI;
> +		} else {
> +			dev_dbg(dev, "pin power source is not selectable\n");
> +			return -EINVAL;
> +		}
> +
> +		addr = data->base + pwr_reg;
> +		writel((argument == 1800) ? PVDD_1800 : PVDD_3300, addr);

Does RZG2L not do 2V5 IO ? If not, please ignore the comment .

> +		break;
> +	}
> +
> +	default:
> +		dev_err(dev, "Invalid pinconf parameter\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
> +{
> +	struct rzg2l_pfc_data *data =
> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> +	u32 port, pin, func, pfc_state, reg;
> +	u8 pmc_state;
> +
> +	func = RZG2L_PINMUX_TO_FUNC(pinmux_group);
> +	if (func > 5) {
> +		dev_err(dev, "Invalid pin function %u\n", func);
> +		return -EINVAL;
> +	}
> +
> +	port = RZG2L_PINMUX_TO_PORT(pinmux_group);
> +	pin = RZG2L_PINMUX_TO_PIN(pinmux_group);
> +	if (!rzg2l_port_validate(data, port, pin)) {
> +		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
> +		return -EINVAL;
> +	}
> +
> +	/* Check current PMC & PFC to decide if we need to change anything. */
> +	pmc_state = readb(data->base + PMC(port)) & BIT(pin);
> +	pfc_state = (readl(data->base + PFC(port)) >> (pin * 4)) & PFC_MASK;
> +	if (pmc_state && pfc_state == func)
> +		return 0;
> +
> +	dev_dbg(dev, "pinmux port %u pin %u func %u\n", port, pin, func);
> +
> +	/* Set pin to 'Non-use (Hi-Z input protection)'  */
> +	reg = readw(data->base + PM(port));
> +	reg &= ~(PM_MASK << (pin * 2));
> +	writew(reg, data->base + PM(port));
> +
> +	/* Temporarily switch to GPIO mode with PMC register */
> +	reg = readb(data->base + PMC(port));
> +	writeb(reg & ~BIT(pin), data->base + PMC(port));
> +
> +	/* Set the PWPR register to allow PFC register to write */
> +	writel(0x0, data->base + PWPR);        /* B0WI=0, PFCWE=0 */
> +	writel(PWPR_PFCWE, data->base + PWPR);  /* B0WI=0, PFCWE=1 */
> +
> +	/* Select Pin function mode with PFC register */
> +	reg = readl(data->base + PFC(port));
> +	reg &= ~(PFC_MASK << (pin * 4));
> +	writel(reg | (func << (pin * 4)), data->base + PFC(port));

clrbits_le32() , please fix globally .

> +	/* Set the PWPR register to be write-protected */
> +	writel(0x0, data->base + PWPR);        /* B0WI=0, PFCWE=0 */
> +	writel(PWPR_B0WI, data->base + PWPR);  /* B0WI=1, PFCWE=0 */
> +
> +	/* Switch to Peripheral pin function with PMC register */
> +	reg = readb(data->base + PMC(port));
> +	writeb(reg | BIT(pin), data->base + PMC(port));
> +
> +	return rzg2l_selector_encode(data, port, pin);
> +}

[...]
