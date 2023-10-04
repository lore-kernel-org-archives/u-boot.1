Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB984E7B601
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01EB874CB;
	Wed,  4 Oct 2023 14:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nDfJJkpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91AA874C4; Wed,  4 Oct 2023 14:24:51 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C36887445
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S0v5P4X0Sz9scQ;
 Wed,  4 Oct 2023 14:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696422281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1j8UdZBwvy3EL4XS8S9p5WzTVP6vF6+GnLC3mztY4c=;
 b=nDfJJkpZNppfJCEOgy5e6GBOvvOpNO553Z9HhVnKa80EUiihTUdWBwLT2pk8OXCBXEXoHo
 KdGnhQtQJE+4ZJDzLrR0gqmF839loQ0IJhwnhY8X3yNIVvp2yI/dhNEMyLdcTs3HmIKRuu
 OxoP4Z94duMUMml793d5YUrQaM6O5d00C193l6PNQpm2369nrmjR/mH0KnhIO9M6aXBXzc
 HReURwPzVi5iJyVbiNAAhX1fwPLoOSPF0Cs9K6wQtA5+kQ5Ob6rUsTHYNjMKyF1ZBZjOaL
 o0SiAZSKGx/MLro81IV2D+wvibuSbenRwjhPH7RK1WQVPF4wrVl2Aql7JGdoyQ==
Message-ID: <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
Date: Wed, 4 Oct 2023 14:24:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2f63dcbe51e11cdb66e
X-MBO-RS-META: dq8uaeqmc7worga8pgycysae7s7e8jqd
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

On 10/4/23 10:40, Paul Barker wrote:
> On 03/10/2023 14:20, Marek Vasut wrote:
>> On 9/20/23 14:42, Paul Barker wrote:
>>> This driver provides pinctrl and gpio control for the Renesas RZ/G2L
>>> (R9A07G044) SoC.
>>>
>>> This patch is based on the corresponding Linux v6.5 driver.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>    arch/arm/mach-rmobile/Kconfig       |   1 +
>>>    drivers/pinctrl/renesas/Kconfig     |   9 +
>>>    drivers/pinctrl/renesas/Makefile    |   1 +
>>>    drivers/pinctrl/renesas/rzg2l-pfc.c | 906 ++++++++++++++++++++++++++++
>>>    4 files changed, 917 insertions(+)
>>>    create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
>>>
>>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
>>> index 91f544c78337..973e84fcf7ba 100644
>>> --- a/arch/arm/mach-rmobile/Kconfig
>>> +++ b/arch/arm/mach-rmobile/Kconfig
>>> @@ -76,6 +76,7 @@ config RZG2L
>>>    	imply SYS_MALLOC_F
>>>    	imply RENESAS_SDHI
>>>    	imply CLK_RZG2L
>>> +	imply PINCTRL_RZG2L
>>
>> Keep the list sorted
>>
>> [...]
>>
>> Drop the parenthesis around values please, fix globally and in other
>> patches too.
>>
>>> +#define PWPR			(0x3014)
>>> +#define SD_CH(n)		(0x3000 + (n) * 4)
>>> +#define QSPI			(0x3008)
>>> +
>>> +#define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
>>> +#define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
>>> +
>>> +#define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
>>> +#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
>>> +
>>> +#define PM_MASK			0x03
>>> +#define PVDD_MASK		0x01
>>> +#define PFC_MASK		0x07
>>> +#define IEN_MASK		0x01
>>> +#define IOLH_MASK		0x03
>>> +
>>> +#define PM_HIGH_Z		0x0
>>> +#define PM_INPUT		0x1
>>> +#define PM_OUTPUT		0x2
>>> +#define PM_OUTPUT_IEN		0x3
>>> +
>>> +struct rzg2l_pfc_driver_data {
>>> +	uint num_dedicated_pins;
>>> +	uint num_ports;
>>> +	const u32 *gpio_configs;
>>> +};
>>> +
>>> +struct rzg2l_pfc_data {
>>> +	void __iomem *base;
>>> +	uint num_dedicated_pins;
>>> +	uint num_ports;
>>> +	uint num_pins;
>>> +	const u32 *gpio_configs;
>>> +	bool pfc_enabled;
>>> +};
>>> +
>>> +struct rzg2l_dedicated_configs {
>>> +	const char *name;
>>> +	u32 config;
>>> +};
>>> +
>>> +/*
>>> + * We need to ensure that the module clock is enabled and all resets are
>>> + * de-asserted before using either the gpio or pinctrl functionality. Error
>>> + * handling can be quite simple here as if the PFC cannot be enabled then we
>>> + * will not be able to progress with the boot anyway.
>>> + */
>>> +static int rzg2l_pfc_enable(struct udevice *dev)
>>> +{
>>> +	struct rzg2l_pfc_data *data =
>>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
>>> +	struct reset_ctl_bulk rsts;
>>> +	struct clk clk;
>>> +	int ret;
>>> +
>>> +	if (data->pfc_enabled)
>>
>> When does this get triggered ?
> 
> This is initialised to false in rzg2l_pfc_bind(), then this function
> rzg2l_pfc_enable() sets it to true before a successful return. The
> effect is that the PFC is enabled just once, regardless of whether the
> pinctrl or gpio driver is probed first.

Why would be call to rzg2l_pfc_enable() a problem in the first place ?
It just grabs and enables clock and ungates reset, the second time this 
is called the impact on harware should be no-op , right ?

>>> +		return 0;
>>
>> [...]
>>
>>> +static int rzg2l_gpio_set_value(struct udevice *dev, unsigned int offset,
>>> +				int value)
>>> +{
>>> +	struct rzg2l_pfc_data *data =
>>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
>>> +	u32 port = RZG2L_PINMUX_TO_PORT(offset);
>>> +	u8 pin = RZG2L_PINMUX_TO_PIN(offset);
>>
>> A lot of this can also be const
> 
> This is aligned with the Linux driver to make it easier to port any
> future fixes across.

Maybe send patches to Geert and see what happens ?

[...]

>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	uc_priv->gpio_count = args.args[2];
>>> +	return rzg2l_pfc_enable(dev);
>>> +}
>>> +
>>> +U_BOOT_DRIVER(rzg2l_pfc_gpio) = {
>>> +	.name		= "rzg2l-pfc-gpio",
>>> +	.id		= UCLASS_GPIO,
>>> +	.ops		= &rzg2l_gpio_ops,
>>> +	.probe		= rzg2l_gpio_probe,
>>> +};
>>
>> Can you please split the GPIO and PFC drivers into separate files ?
> 
> I assume you mean gpio and pinctrl here - the PFC handles both. I can
> move the gpio driver out to drivers/gpio.

Thanks. R-Car already does it that way.

[...]

>>> +		if (cfg & PIN_CFG_IO_VMC_SD0) {
>>> +			dev_dbg(dev, "port off %u:%u set SD_CH 0 PVDD=%u\n",
>>> +				port_offset, pin, argument);
>>> +			pwr_reg = SD_CH(0);
>>> +		} else if (cfg & PIN_CFG_IO_VMC_SD1) {
>>> +			dev_dbg(dev, "port off %u:%u set SD_CH 1 PVDD=%u\n",
>>> +				port_offset, pin, argument);
>>> +			pwr_reg = SD_CH(1);
>>> +		} else if (cfg & PIN_CFG_IO_VMC_QSPI) {
>>> +			dev_dbg(dev, "port off %u:%u set QSPI PVDD=%u\n",
>>> +				port_offset, pin, argument);
>>> +			pwr_reg = QSPI;
>>> +		} else {
>>> +			dev_dbg(dev, "pin power source is not selectable\n");
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		addr = data->base + pwr_reg;
>>> +		writel((argument == 1800) ? PVDD_1800 : PVDD_3300, addr);
>>
>> Does RZG2L not do 2V5 IO ? If not, please ignore the comment .
> 
> 2V5 IO is supported on the Ethernet interfaces. Support for configuring
> those interfaces will be added along with the Ethernet driver in future
> patches.

Add a TODO comment please.
