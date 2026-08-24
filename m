Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C75DC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9937B80AF3;
	Mon, 24 Aug 2026 13:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWb-hh0qwck3; Mon, 24 Aug 2026 13:17:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577448;
	bh=lCIA45YXn1NdbFwgFszvuF8rU1lrxJIWjSOT1GO0nBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fp0MMcxQ/8rBsX0SZ2wtKjOb3dhtI2REJCSkFuVCwMEmpGJnCP0qU+zzI7QKl7CoY
	 o9N2hzNnYaYy5A4K2XvWrD3hheBRgqyvCSqXtMLdVdtFi4zSu9Xo4mnYEHYi/+4ZTl
	 4Y+uzJhZmUB5P1j64MVZB/8cRyuQfOYO74b/t0mbwlPo37jaxQ5pxf8o8QkivAG4c4
	 nBm3A90CHwnThN3snLUozy99cMw74C2PlreAS44EYKH8e6AQe3DRJzijnOcXJZF6mP
	 udw5LulgX/Noag+aET7U1uKGByRteubt7G+HHKDz0V3BVwdR3BU+PxQfhc4KHt8GZO
	 tewCS2g6wOGCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99C19809EB;
	Mon, 24 Aug 2026 13:17:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 57949396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4907C80A9F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGl_ckj865WN for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:17:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JTfKh8Ma
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D81EA80798
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:17:24 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c160420289bso505564366b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787577443; x=1788182243;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lCIA45YXn1NdbFwgFszvuF8rU1lrxJIWjSOT1GO0nBg=;
 b=JTfKh8MaYmi6TmNCdCbK5A9OBNNSYQHdSxizdZU6zYAdYA3O1DghVrxWQmx2L7fJ46
 lbBPUuUyK7G/2j83pz0o4Gc6RBevetmqvSqwq0CDIWHspRPoaG/DprU9CUIlauy31IiW
 f+mjM1sFlLonBwTgbWRsmgAkyndUx0W1DWOFcEXT+A8oxmnSds7S8AuSlEJgvLz6lZrI
 sT7BpYbMDls+RClWbuhpYDBv0HiPeN/zmkryz3e/k4fnMdHbRTXUE1XxHV0UcGK6YEO+
 fS0RrzocyqJbjAOvOv7OALiIcHaUgpQwLxXN3qqg5VYM2obTqG6bN1+fM4XIZgy3t4tj
 Lutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577443; x=1788182243;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lCIA45YXn1NdbFwgFszvuF8rU1lrxJIWjSOT1GO0nBg=;
 b=UOehfEeT8BGscu5DhqtLLg5mwk9RCLNT9bZIJ+riQIYq0biSSDkD22FtFdBAIOgczN
 T1vsIhXnXSgU9IR1s3iwbOZuET36TrCKG3qmjusNb33wTfc8BYYONIFjuLOEwmEZovJQ
 ckFj3yBJsl965T/tNhgATrd3WUQ6Q9TP6mnhykaUFhl3u/KD/3KFCS1/lgq6I2one4+Q
 rh+b2diGwa3KdnFptWQzMJO4ZWkEFHeeU9tRNUEHJSeVBAk3BC6wac7w8DZ1wGqEd+fP
 kmvenKdWh554sQPjs8qRcDRhnmdvPn2doNjVZgf5kxdrrERxqne1mCWqgq5A7QV2RYnE
 sLsA==
X-Gm-Message-State: AFuF++kA2t2cEdoI/Cc1nzdhDZMXpT3Sx8mxagaYAbwqIEe6KXZhi3dh
 gDsCRb2LkjikOzdz3en3/zH05+KLUAP3O9gf+pgv6LGQIu8PCZcd+HtEaR6W+px7p/QyQdd8q58
 LGUAerZg=
X-Gm-Gg: AR+sD12YlPKGGLJuoo3pMooQ4rAZp6I4PwLEGg4rCBzMlPMbdJJV+Gv8o4jq/hYD3kk
 dwzGkGb73dWQ0flQ2WRg07zZa8ditWOdzhNEhNyNkOYkrSu0FV9pwdmoLLQ8LXb5rmiXOi6zHgA
 FY25o2PPM6Vrqiv9wEQ4KsjxPJZrirjH5Eb4HDEYaCY6YFuEgdfmTBRGBUUW/FB4MzgTdL/pVrw
 Qv8S/M0yHtZsIAi0xJ+C8zUiOJlAqfYdeJ60VT86U1+S77jJcjA1F4sKeaz8oaXFdfTHFPipwHs
 Ed1p9Q9qUWH1SdT0jS9+8eZwevPttaKjv7tWdd8BjAXot/LY6+8m+1kTDmdkSv/IY1vJHk3FsVn
 Szz7PJW570auFYazUjET/q8Q23iamORiUJZPi9qTNbz+W61FoMEtHi8LGWtkF8B6QC8HNAB0NAn
 0HaDHeZbTiI/hHaWnIy8nJra+w/YGZmPUMbCS7ZPXdjGNZO0BTDvBT+Lt4zKys50RExFbMo18=
X-Received: by 2002:a17:907:9629:b0:c24:d6f0:f4a with SMTP id
 a640c23a62f3a-c24d6f1021amr337474966b.10.1787577442974; 
 Mon, 24 Aug 2026 06:17:22 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e7esm1391099366b.46.2026.08.24.06.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:17:22 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:17:17 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 01/13] pinctrl: Add compact Nomadik pin controller
Message-ID: <aoxEXcQ9dDZ4MDkf@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-1-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-1-07ca794e2b94@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Aug 23, 2026 at 10:39:20PM +0200, Linus Walleij wrote:
> Add the minimal pin control support needed to consume default states from
> the upstream DB8500 device trees. Resolve the nine Nomadik GPIO banks
> through nomadik-gpio-chips and apply the mux, direction, value, pull and
> low-EMI settings directly to their registers.
> 
> Only the DB8500 binding and default-state configuration needed by
> U-Boot are supported. There is no GPIO ownership or sleep-state
> handling.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks!

> ---
>  MAINTAINERS                       |   1 +
>  arch/arm/Kconfig                  |   2 +
>  drivers/pinctrl/Kconfig           |   7 ++
>  drivers/pinctrl/Makefile          |   1 +
>  drivers/pinctrl/pinctrl-nomadik.c | 230 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 241 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb48eea55c5a..a5d6b5be29dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -787,6 +787,7 @@ S:	Maintained
>  F:	arch/arm/dts/ste-*
>  F:	arch/arm/mach-u8500/
>  F:	drivers/gpio/nmk_gpio.c
> +F:	drivers/pinctrl/pinctrl-nomadik.c
>  F:	drivers/phy/phy-ab8500-usb.c
>  F:	drivers/power/pmic/ab8500.c
>  F:	drivers/timer/nomadik-mtu-timer.c
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1b474a346bf2..5b02ff18bd0e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1278,6 +1278,8 @@ config ARCH_U8500
>  	imply DM_RTC
>  	imply NOMADIK_GPIO
>  	imply NOMADIK_MTU_TIMER
> +	imply PINCTRL
> +	imply PINCTRL_NOMADIK
>  	imply PHY
>  	imply PL01X_SERIAL
>  	imply PMIC_AB8500
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index fd30aaeeaa89..04785a927fec 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -75,6 +75,13 @@ config PINCONF_RECURSIVE
>  	  configuration; you can save memory footprint when this feature is
>  	  no needed.
>  
> +config PINCTRL_NOMADIK
> +	bool "Nomadik pin control driver"
> +	depends on PINCTRL_FULL
> +	help
> +	  Enable pin multiplexing and configuration support for the Nomadik
> +	  GPIO blocks in the ST-Ericsson DB8500.
> +
>  config SPL_PINCTRL
>  	bool "Support pin controllers in SPL"
>  	depends on SPL && SPL_DM
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 91149796bb5f..23219626e392 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_PINCTRL_K210)		+= pinctrl-k210.o
>  obj-$(CONFIG_PINCTRL_MESON)		+= meson/
>  obj-$(CONFIG_PINCTRL_MSCC)		+= mscc/
>  obj-$(CONFIG_PINCTRL_MTK)		+= mediatek/
> +obj-$(CONFIG_PINCTRL_NOMADIK)		+= pinctrl-nomadik.o
>  obj-$(CONFIG_PINCTRL_PIC32)		+= pinctrl_pic32.o
>  obj-$(CONFIG_PINCTRL_QCOM)		+= qcom/
>  obj-$(CONFIG_PINCTRL_QE)		+= pinctrl-qe-io.o
> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
> new file mode 100644
> index 000000000000..12d032226608
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-nomadik.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Linus Walleij <linusw@kernel.org> */
> +
> +#include <dm.h>
> +#include <dm/pinctrl.h>
> +#include <dt-bindings/pinctrl/nomadik.h>
> +#include <vsprintf.h>
> +#include <asm/io.h>
> +
> +#define NMK_GPIO_BANKS		9
> +#define NMK_GPIO_PER_BANK	32
> +
> +struct nmk_gpio_regs {
> +	u32 dat;
> +	u32 dats;
> +	u32 datc;
> +	u32 pdis;
> +	u32 dir;
> +	u32 dirs;
> +	u32 dirc;
> +	u32 slpm;
> +	u32 afsla;
> +	u32 afslb;
> +	u32 lowemi;
> +};
> +
> +struct nmk_pinctrl_priv {
> +	struct nmk_gpio_regs *bank[NMK_GPIO_BANKS];
> +};
> +
> +enum nmk_alt {
> +	NMK_ALT_GPIO,
> +	NMK_ALT_A,
> +	NMK_ALT_B,
> +	NMK_ALT_C,
> +};
> +
> +static int nmk_pinctrl_parse_pin(const char *name, unsigned int *pin)
> +{
> +	char *end;
> +
> +	if (strncmp(name, "GPIO", 4))
> +		return -EINVAL;
> +
> +	*pin = dectoul(name + 4, &end);
> +	if (end == name + 4 || *end != '_' ||
> +	    *pin >= NMK_GPIO_BANKS * NMK_GPIO_PER_BANK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static struct nmk_gpio_regs *
> +nmk_pinctrl_bank(struct udevice *dev, unsigned int pin)
> +{
> +	struct nmk_pinctrl_priv *priv = dev_get_priv(dev);
> +
> +	return priv->bank[pin / NMK_GPIO_PER_BANK];
> +}
> +
> +static void nmk_pinctrl_set_mux(struct udevice *dev, unsigned int pin,
> +				unsigned int alt)
> +{
> +	struct nmk_gpio_regs *regs = nmk_pinctrl_bank(dev, pin);
> +	u32 mask = BIT(pin % NMK_GPIO_PER_BANK);
> +	u32 val;
> +
> +	val = readl(&regs->afsla);
> +	if (alt & NMK_ALT_A)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +	writel(val, &regs->afsla);
> +
> +	val = readl(&regs->afslb);
> +	if (alt & NMK_ALT_B)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +	writel(val, &regs->afslb);
> +}
> +
> +static int nmk_pinctrl_set_config(struct udevice *dev, ofnode node,
> +				  unsigned int pin)
> +{
> +	struct nmk_gpio_regs *regs = nmk_pinctrl_bank(dev, pin);
> +	u32 mask = BIT(pin % NMK_GPIO_PER_BANK);
> +	u32 val;
> +
> +	if (!ofnode_read_u32(node, "ste,input", &val)) {
> +		writel(mask, &regs->dirc);
> +		if (val == INPUT_NOPULL) {
> +			setbits_le32(&regs->pdis, mask);
> +		} else {
> +			clrbits_le32(&regs->pdis, mask);
> +			if (val == INPUT_PULLUP)
> +				writel(mask, &regs->dats);
> +			else if (val == INPUT_PULLDOWN)
> +				writel(mask, &regs->datc);
> +			else
> +				return -EINVAL;
> +		}
> +	}
> +
> +	if (!ofnode_read_u32(node, "ste,output", &val)) {
> +		if (val == OUTPUT_HIGH)
> +			writel(mask, &regs->dats);
> +		else if (val == OUTPUT_LOW)
> +			writel(mask, &regs->datc);
> +		else
> +			return -EINVAL;
> +		writel(mask, &regs->dirs);
> +	}
> +
> +	if (!ofnode_read_u32(node, "ste,lowemi", &val)) {
> +		if (val)
> +			setbits_le32(&regs->lowemi, mask);
> +		else
> +			clrbits_le32(&regs->lowemi, mask);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nmk_pinctrl_get_alt(ofnode node, unsigned int *alt)
> +{
> +	const char *group;
> +
> +	if (ofnode_read_string_index(node, "groups", 0, &group))
> +		return -EINVAL;
> +
> +	if (strstr(group, "_a_"))
> +		*alt = NMK_ALT_A;
> +	else if (strstr(group, "_b_"))
> +		*alt = NMK_ALT_B;
> +	else if (strstr(group, "_c_"))
> +		*alt = NMK_ALT_C;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int nmk_pinctrl_set_state(struct udevice *dev, struct udevice *config)
> +{
> +	unsigned int alt = NMK_ALT_GPIO;
> +	ofnode node;
> +	int count;
> +	int ret;
> +	int i;
> +
> +	dev_for_each_subnode(node, config) {
> +		if (ofnode_read_string(node, "function")) {
> +			ret = nmk_pinctrl_get_alt(node, &alt);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	dev_for_each_subnode(node, config) {
> +		ofnode cfg;
> +
> +		count = ofnode_read_string_count(node, "pins");
> +		if (count < 0)
> +			continue;
> +
> +		cfg = ofnode_parse_phandle(node, "ste,config", 0);
> +		if (!ofnode_valid(cfg))
> +			cfg = node;
> +
> +		for (i = 0; i < count; i++) {
> +			const char *name;
> +			unsigned int pin;
> +
> +			ret = ofnode_read_string_index(node, "pins", i, &name);
> +			if (ret)
> +				return ret;
> +			ret = nmk_pinctrl_parse_pin(name, &pin);
> +			if (ret)
> +				return ret;
> +			ret = nmk_pinctrl_set_config(dev, cfg, pin);
> +			if (ret)
> +				return ret;
> +			nmk_pinctrl_set_mux(dev, pin, alt);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int nmk_pinctrl_probe(struct udevice *dev)
> +{
> +	struct nmk_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct ofnode_phandle_args args;
> +	fdt_addr_t addr;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < NMK_GPIO_BANKS; i++) {
> +		ret = dev_read_phandle_with_args(dev, "nomadik-gpio-chips",
> +						 NULL, 0, i, &args);
> +		if (ret)
> +			return ret;
> +
> +		addr = ofnode_get_addr(args.node);
> +		if (addr == FDT_ADDR_T_NONE)
> +			return -EINVAL;
> +		priv->bank[i] = (struct nmk_gpio_regs *)addr;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pinctrl_ops nmk_pinctrl_ops = {
> +	.set_state = nmk_pinctrl_set_state,
> +};
> +
> +static const struct udevice_id nmk_pinctrl_ids[] = {
> +	{ .compatible = "stericsson,db8500-pinctrl" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_nomadik) = {
> +	.name = "pinctrl_nomadik",
> +	.id = UCLASS_PINCTRL,
> +	.of_match = nmk_pinctrl_ids,
> +	.probe = nmk_pinctrl_probe,
> +	.priv_auto = sizeof(struct nmk_pinctrl_priv),
> +	.ops = &nmk_pinctrl_ops,
> +};
> 
> -- 
> 2.55.0
> 
