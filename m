Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEAEE7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F5F87476;
	Tue,  3 Oct 2023 15:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IwWbTsrS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bdqbpAqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CC887460; Tue,  3 Oct 2023 15:40:54 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26238725E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0Jql5sLTz9sqW;
 Tue,  3 Oct 2023 15:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUDPr0Rbt7tnEtejdR7STGAOqXhOOq0AUZyAlSmYTbQ=;
 b=IwWbTsrSto0Rsmt2cTJ/5/9mJJzfZFYtjtP2PO3rAAcrznFZm2EbrbjF/YpWuuCT2048+1
 4BWJXHmrHwGiVnwN002Z99Avwb9GNLyCCtiqUeTxu1eRf5l/5Lz/Us2VD4CCRJLgQvodJ/
 YZ1hA+EiJUUc5XX9SpWMc2oFIIfDG0YYKOV+CFFwL5CVm8qc/yabmW7PEkpR0VYYd29EXi
 OAgVddffpRLbBzAkDe1n/j6YcT1z9G9xN/U6tocTQlok32KJpCj1xN4TEbeQyeY64Q+d9T
 bu2xbZMIWob5ZTzxhds8L+PDYtEUyFjHwkkkCuHrQXS1dmTnKq58IogZJQA1IQ==
Message-ID: <cf94aea9-e750-8636-9f31-941617e8b8be@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUDPr0Rbt7tnEtejdR7STGAOqXhOOq0AUZyAlSmYTbQ=;
 b=bdqbpAqymPFniVZgD7ZnQ9N5aeHBUOgDxT1xrxdYH0aNPTB4Fz7NIhbhvG3VAFZF8Mec4d
 FPmjK/mmzrueehQnKTq2Mc/4ToHwTpyzyjLhD4PshSaXWzxXaLx+M5BwN9Va2h1QkAu6vR
 lmsdGgIBMkLB4zNiInbhf5r3xO+Df2iZohqMxzoleCr8gQCNeNUGPigoD934AylXJGLO7m
 6tvQm7euB4NI3B/LUrZ6jozR7T6RrD5JhWtKL1bQzTaRAfHZv1aL/UZiJF0k2A6tcdxYqV
 upM+30nmCwOnkTyhsEf9hAXk6Dd+97npNmuL8+/WOyt2gPzaWbCAL+Xj+AWSNw==
Date: Tue, 3 Oct 2023 14:56:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 07/16] clk: renesas: Add RZ/G2L CPG driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-8-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-8-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: a8pwqw3drf8yg3qfp68cdcwruaqkazg1
X-MBO-RS-ID: ffa69b63126a3f72697
X-Rspamd-Queue-Id: 4S0Jql5sLTz9sqW
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
> This driver provides clock and reset control for the Renesas RZ/G2L
> (R9A07G044) SoC. It consists of two parts:
> 
> * driver code which is applicable to all SoCs in the RZ/G2L family
> 
> * static data describing the clocks and resets which are specific to the
>    R9A07G044 SoC.
> 
> clk_set_rate() and clk_get_rate() are implemented only for the clocks
> that are actually used in u-boot.
> 
> The CPG driver is marked with DM_FLAG_PRE_RELOC to ensure that its bind
> function is called before the SCIF (serial port) driver is probed. This
> is required so that we can de-assert the relevant reset signal during
> the serial driver probe function.
> 
> This patch is based on the corresponding Linux v6.5 driver.

Same thing as 02/16..04/16 applies here.

> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig       |   1 +
>   arch/arm/mach-rmobile/Kconfig.rzg2l |   1 +
>   drivers/clk/renesas/Kconfig         |   9 +
>   drivers/clk/renesas/Makefile        |   2 +
>   drivers/clk/renesas/r9a07g044-cpg.c | 384 +++++++++++++++++++++
>   drivers/clk/renesas/rzg2l-cpg.c     | 502 ++++++++++++++++++++++++++++
>   drivers/clk/renesas/rzg2l-cpg.h     | 318 ++++++++++++++++++
>   7 files changed, 1217 insertions(+)
>   create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
>   create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
>   create mode 100644 drivers/clk/renesas/rzg2l-cpg.h
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index fd240832d83d..fc37f6c79e50 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -74,6 +74,7 @@ config RZG2L
>   	imply MULTI_DTB_FIT_USER_DEFINED_AREA
>   	imply SYS_MALLOC_F
>   	imply RENESAS_SDHI
> +	imply CLK_RZG2L

Keep the list sorted

>   	help
>   	  Enable support for the Renesas RZ/G2L family of SoCs, including the
>   	  the RZ/G2L itself (based on the R9A07G044 SoC).
> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
> index 266f82c18085..7d268e8c366a 100644
> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
> @@ -5,6 +5,7 @@ if RZG2L
>   
>   config R9A07G044L
>   	bool "Renesas R9A07G044L SoC"
> +	imply CLK_R9A07G044

Why not CLK_R9A07G044L (with L at the end) ?

>   	help
>   	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
>   
> diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
> index 437a82cd48be..927d62cf99a3 100644
> --- a/drivers/clk/renesas/Kconfig
> +++ b/drivers/clk/renesas/Kconfig
> @@ -156,3 +156,12 @@ config CLK_R9A06G032
>   	depends on CLK_RENESAS
>   	help
>   	  Enable this to support the clocks on Renesas R9A06G032 SoC.
> +
> +config CLK_RZG2L
> +	bool "Renesas RZ/G2L family clock support"
> +	depends on CLK_RENESAS
> +	select DM_RESET
> +
> +config CLK_R9A07G044
> +	bool "RZ/G2L (R9A07G044L) clock support"
> +	depends on CLK_RZG2L
> diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
> index 48373e61b901..df7e225e9ca4 100644
> --- a/drivers/clk/renesas/Makefile
> +++ b/drivers/clk/renesas/Makefile
> @@ -23,3 +23,5 @@ obj-$(CONFIG_CLK_R8A779A0) += r8a779a0-cpg-mssr.o
>   obj-$(CONFIG_CLK_R8A779F0) += r8a779f0-cpg-mssr.o
>   obj-$(CONFIG_CLK_R8A779G0) += r8a779g0-cpg-mssr.o
>   obj-$(CONFIG_CLK_R9A06G032) += r9a06g032-clocks.o
> +obj-$(CONFIG_CLK_RZG2L) += rzg2l-cpg.o
> +obj-$(CONFIG_CLK_R9A07G044) += r9a07g044-cpg.o
> diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
> new file mode 100644
> index 000000000000..e215db7caf15
> --- /dev/null
> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/G2L CPG driver
> + *
> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
> + */
> +
> +#include <common.h>
> +#include <dm/device.h>
> +#include <dt-bindings/clock/r9a07g044-cpg.h>
> +#include <linux/clk-provider.h>
> +
> +#include "rzg2l-cpg.h"
> +
> +/* Divider tables */
> +static const struct clk_div_table dtable_1_8[] = {
> +	{0, 1},
> +	{1, 2},
> +	{2, 4},
> +	{3, 8},
> +	{0, 0},
> +};
> +
> +static const struct clk_div_table dtable_1_32[] = {
> +	{0, 1},
> +	{1, 2},
> +	{2, 4},
> +	{3, 8},
> +	{4, 32},
> +	{0, 0},
> +};
> +
> +static const struct clk_div_table dtable_16_128[] = {
> +	{0, 16},
> +	{1, 32},
> +	{2, 64},
> +	{3, 128},
> +	{0, 0},
> +};
> +
> +/* Mux clock tables */
> +static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
> +static const char * const sel_pll5_4[] = { ".pll5_foutpostdiv", ".pll5_fout1ph0" };
> +static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };

Is this mixed tabs and spaces here ?

(please fix this in Linux too)

> +static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
> +static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };

[...]

> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c

[...]

> +static int rzg2l_cpg_clk_set(struct clk *clk, bool enable)
> +{
> +	struct rzg2l_cpg_data *data =
> +		(struct rzg2l_cpg_data *)dev_get_driver_data(clk->dev);
> +	unsigned int cpg_clk_id = CPG_CLK_ID(clk->id);
> +	const struct rzg2l_mod_clk *mod_clk = NULL;
> +	u32 value;
> +	unsigned int i;
> +
> +	dev_dbg(clk->dev, "%s %s clock %u\n", enable ? "enable" : "disable",
> +		is_mod_clk(clk->id) ? "module" : "core", cpg_clk_id);
> +	if (!is_mod_clk(clk->id)) {
> +		dev_err(clk->dev, "ID %lu is not a module clock\n", clk->id);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < data->info->num_mod_clks; i++) {
> +		if (data->info->mod_clks[i].id == cpg_clk_id) {
> +			mod_clk = &data->info->mod_clks[i];
> +			break;
> +		}
> +	}
> +
> +	if (!mod_clk) {
> +		dev_err(clk->dev, "Module clock %u not found\n", cpg_clk_id);
> +		return -ENODEV;
> +	}
> +
> +	value = (BIT(mod_clk->bit) << 16);

Parenthesis not needed around this statement.

> +	if (enable)
> +		value |= BIT(mod_clk->bit);
> +	writel(value, data->base + mod_clk->off);
> +
> +	if (enable && readl_poll_timeout(data->base + CLK_MON_R(mod_clk->off),
> +					 value, (value & BIT(mod_clk->bit)),
> +					 10)) {
> +		dev_err(clk->dev, "Timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_cpg_clk_enable(struct clk *clk)
> +{
> +	return rzg2l_cpg_clk_set(clk, true);
> +}
> +
> +static int rzg2l_cpg_clk_disable(struct clk *clk)
> +{
> +	return rzg2l_cpg_clk_set(clk, false);
> +}
> +
> +static int rzg2l_cpg_clk_of_xlate(struct clk *clk,
> +				  struct ofnode_phandle_args *args)
> +{
> +	struct rzg2l_cpg_data *data =
> +		(struct rzg2l_cpg_data *)dev_get_driver_data(clk->dev);
> +	u32 cpg_clk_type, cpg_clk_id;
> +	bool found = false;
> +	unsigned int i;
> +
> +	if (args->args_count != 2) {
> +		dev_dbg(clk->dev, "Invalid args_count: %d\n", args->args_count);
> +		return -EINVAL;
> +	}
> +
> +	cpg_clk_type = args->args[0];
> +	cpg_clk_id = args->args[1];
> +
> +	switch (cpg_clk_type) {
> +	case CPG_CORE:

Is this copied from RCAR clock driver ?

Can this be deduplicated someohw ?

> +		for (i = 0; i < data->info->num_core_clks; i++) {
> +			if (data->info->core_clks[i].id == cpg_clk_id) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			dev_dbg(clk->dev,
> +				"Invalid second argument %u: Must be a valid core clock ID\n",
> +				cpg_clk_id);
> +			return -EINVAL;
> +		}
> +		break;
> +	case CPG_MOD:
> +		for (i = 0; i < data->info->num_mod_clks; i++) {
> +			if (data->info->mod_clks[i].id == cpg_clk_id) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			dev_dbg(clk->dev,
> +				"Invalid second argument %u: Must be a valid module clock ID\n",
> +				cpg_clk_id);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		dev_dbg(clk->dev,
> +			"Invalid first argument %u: Must be CPG_CORE or CPG_MOD\n",
> +			cpg_clk_type);
> +		return -EINVAL;
> +	}
> +
> +	clk->id = CPG_CLK_PACK(cpg_clk_type, cpg_clk_id);
> +
> +	return 0;
> +}
> +
> +static ulong rzg2l_sdhi_clk_get_rate(struct udevice *dev, const struct cpg_core_clk *cc)
> +{
> +	struct rzg2l_cpg_data *data =
> +		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
> +	ulong offset = CPG_CONF_OFFSET(cc->conf);
> +	int shift = CPG_CONF_BITPOS(cc->conf);
> +	u32 mask = CPG_CONF_BITMASK(cc->conf);
> +	unsigned int sel;
> +
> +	sel = (readl(data->base + offset) >> shift) & mask;
> +
> +	if (!sel || sel > cc->num_parents) {
> +		dev_err(dev, "Invalid SEL_SDHI%d_SET value %u\n", shift / 4, sel);
> +		return -EIO;
> +	}
> +	return rzg2l_cpg_clk_get_rate_by_name(dev, cc->parent_names[sel - 1]);
> +}
> +
> +static ulong rzg2l_div_clk_get_rate(struct udevice *dev, const struct cpg_core_clk *cc)
> +{
> +	struct rzg2l_cpg_data *data =
> +		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
> +	ulong offset = CPG_CONF_OFFSET(cc->conf);
> +	int shift = CPG_CONF_BITPOS(cc->conf);
> +	u32 mask = CPG_CONF_BITMASK(cc->conf);

Can these be 'const' too ?

Fix globally please.

> +	unsigned int sel, i;
> +
> +	sel = (readl(data->base + offset) >> shift) & mask;
> +
> +	for (i = 0; cc->dtable[i].div; i++) {
> +		if (cc->dtable[i].val == sel)
> +			return rzg2l_cpg_clk_get_rate_by_id(dev, cc->parent) / cc->dtable[i].div;
> +	}
> +	dev_err(dev, "Invalid selector value %u for clock %s\n", sel, cc->name);
> +	return -EINVAL;
> +}

[...]

> +static ulong rzg2l_core_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
> +{
> +	if (cc->type == CLK_TYPE_SD_MUX)
> +		return rzg2l_sdhi_clk_set_rate(dev, cc, rate);
> +

No netdev style comments please, use full block comment starting with /* 
and newline.

> +	/* The sdhi driver calls clk_set_rate for SD0_DIV4 and SD1_DIV4, even
> +	 * though they're in a fixed relationship with SD0 and SD1 respectively.
> +	 * To allow the driver to proceed, simply return the current rates
> +	 * without making any change.
> +	 */
> +	if (cc->id == CLK_SD0_DIV4 || cc->id == CLK_SD1_DIV4)
> +		return rzg2l_core_clk_get_rate(dev, cc);
> +
> +	dev_err(dev, "set_rate needed for clock %u, type %d\n", cc->id, cc->type);
> +	return -ENOSYS;
> +}

[...]

> diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
> new file mode 100644
> index 000000000000..f7a9a2156319
> --- /dev/null
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -0,0 +1,318 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RZ/G2L Clock Pulse Generator
> + *
> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
> + *
> + */
> +
> +#ifndef __RENESAS_RZG2L_CPG_H__
> +#define __RENESAS_RZG2L_CPG_H__
> +
> +#define CPG_SIPLL5_STBY		(0x140)

Parenthesis not needed, fix globally.

> +#define CPG_SIPLL5_CLK1		(0x144)
> +#define CPG_SIPLL5_CLK3		(0x14C)
> +#define CPG_SIPLL5_CLK4		(0x150)
> +#define CPG_SIPLL5_CLK5		(0x154)
> +#define CPG_SIPLL5_MON		(0x15C)
> +#define CPG_PL1_DDIV		(0x200)
> +#define CPG_PL2_DDIV		(0x204)
> +#define CPG_PL3A_DDIV		(0x208)
> +#define CPG_PL6_DDIV		(0x210)
> +#define CPG_PL2SDHI_DSEL	(0x218)
> +#define CPG_CLKSTATUS		(0x280)
> +#define CPG_PL3_SSEL		(0x408)
> +#define CPG_PL6_SSEL		(0x414)
> +#define CPG_PL6_ETH_SSEL	(0x418)
> +#define CPG_PL5_SDIV		(0x420)
> +#define CPG_RST_MON		(0x680)
> +#define CPG_OTHERFUNC1_REG	(0xBE8)
> +
> +#define CPG_SIPLL5_STBY_RESETB		BIT(0)
> +#define CPG_SIPLL5_STBY_RESETB_WEN	BIT(16)
> +#define CPG_SIPLL5_STBY_SSCG_EN_WEN	BIT(18)
> +#define CPG_SIPLL5_STBY_DOWNSPREAD_WEN	BIT(20)
> +#define CPG_SIPLL5_CLK4_RESV_LSB	(0xFF)
> +#define CPG_SIPLL5_MON_PLL5_LOCK	BIT(4)
> +
> +#define CPG_OTHERFUNC1_REG_RES0_ON_WEN	BIT(16)
> +
> +#define CPG_PL5_SDIV_DIV_DSI_A_WEN	BIT(16)
> +#define CPG_PL5_SDIV_DIV_DSI_B_WEN	BIT(24)
> +
> +#define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
> +#define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
> +
> +#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	20000
> +
> +/* n = 0/1/2 for PLL1/4/6 */
> +#define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * n))
> +#define CPG_SAMPLL_CLK2(n)	(0x08 + (16 * n))

Parenthesis around 'n' need to be added.

> +
> +#define PLL146_CONF(n)	(CPG_SAMPLL_CLK1(n) << 22 | CPG_SAMPLL_CLK2(n) << 12)
> +
> +#define DDIV_PACK(offset, bitpos, size) \
> +		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
> +#define DIVPL1A		DDIV_PACK(CPG_PL1_DDIV, 0, 2)
> +#define DIVPL2A		DDIV_PACK(CPG_PL2_DDIV, 0, 3)
> +#define DIVDSILPCLK	DDIV_PACK(CPG_PL2_DDIV, 12, 2)
> +#define DIVPL3A		DDIV_PACK(CPG_PL3A_DDIV, 0, 3)
> +#define DIVPL3B		DDIV_PACK(CPG_PL3A_DDIV, 4, 3)
> +#define DIVPL3C		DDIV_PACK(CPG_PL3A_DDIV, 8, 3)
> +#define DIVGPU		DDIV_PACK(CPG_PL6_DDIV, 0, 2)
> +
> +#define SEL_PLL_PACK(offset, bitpos, size) \
> +		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
> +
> +#define SEL_PLL3_3	SEL_PLL_PACK(CPG_PL3_SSEL, 8, 1)
> +#define SEL_PLL5_4	SEL_PLL_PACK(CPG_OTHERFUNC1_REG, 0, 1)
> +#define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
> +#define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
> +
> +#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
> +#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
> +
> +#define SEL_SDHI_533MHz		1
> +#define SEL_SDHI_400MHz		2
> +#define SEL_SDHI_266MHz		3
> +#define SEL_SDHI_WRITE_ENABLE	0x10000
> +
> +/* Unpack CPG conf value create by DDIV_PACK() or SEL_PLL_PACK(). */
> +#define CPG_CONF_OFFSET(x)	((x) >> 20)
> +#define CPG_CONF_BITPOS(x)	(((x) >> 12) & 0xff)
> +#define CPG_CONF_SIZE(x)	(((x) >> 8) & 0xf)
> +#define CPG_CONF_BITMASK(x)	GENMASK(CPG_CONF_SIZE(x) - 1, 0)
> +
> +#define EXTAL_FREQ_IN_MEGA_HZ	(24)

Drop parenthesis around integer value please.

[...]
