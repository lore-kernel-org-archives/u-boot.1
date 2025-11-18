Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB32CE8D6B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 00:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4686383C53;
	Tue, 18 Nov 2025 01:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43AE83C5A; Tue, 18 Nov 2025 01:57:33 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 949AF83AEF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 01:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 654BAFEC;
 Mon, 17 Nov 2025 16:57:22 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5CA3F66E;
 Mon, 17 Nov 2025 16:57:28 -0800 (PST)
Date: Tue, 18 Nov 2025 00:57:21 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 10/11] pmu: axp318w: implement pmic/regulator support
Message-ID: <20251118005721.3fb65479@minigeek.lan>
In-Reply-To: <20251116-01-a733-soc-support-v1-10-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
 <20251116-01-a733-soc-support-v1-10-fb4c8db78e75@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 16 Nov 2025 14:44:01 +0000
Yixun Lan <dlan@gentoo.org> wrote:

> The PMIC is also known as AXP819 in vendor pmu code
> 
> For DCDC6, 8, 9, the underlying hardware support more than two levels
> voltage step tuning, but for now only first two levels are implemented
> in this driver, hence highest voltage will be limited at seccond level.
> It actual meets board requirement in current design, and we've verified
> it in Radxa Cubie A7A board.
> 
> Following are detail explanation of voltage tuning stpes for those DCDCs:
> 
> DCDC | voltage range  | units | steps | implemented
>  6   | 0.5   -  1.2   | 10 mV | 71    | Y
>  .   | 1.22  -  1.54  | 20 mV | 17    | Y
>  .   | 1.8   -  2.4   | 20 mV | 31    | N
>  .   | 2.44  -  2.76  | 40 mV | 9     | N
>  --------------------------------------------------
>  8/9 | 0.5   -  1.2   | 10 mV | 71    | Y
>  .   | 1.22  -  1.84  | 20 mV | 32    | Y
>  .   | 1.9   -  3.4   | 100mV | 16    | N
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/power/Kconfig                   | 10 +++++++
>  drivers/power/pmic/axp.c                |  1 +
>  drivers/power/regulator/axp_regulator.c | 50 +++++++++++++++++++++++++++++++++
>  include/axp_pmic.h                      |  1 +
>  4 files changed, 62 insertions(+)
> 
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index d17337c0c3f..1b06d8a66c7 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -58,6 +58,7 @@ choice
>  	default AXP209_POWER if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
>  	default AXP221_POWER if MACH_SUN6I || MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_R40
>  	default AXP818_POWER if MACH_SUN8I_A83T
> +	default AXP318W_POWER if MACH_SUN60I_A733
>  	default SUNXI_NO_PMIC if MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_V3S
>  
>  config SUNXI_NO_PMIC
> @@ -140,6 +141,14 @@ config AXP818_POWER
>  	Say y here to enable support for the axp818 pmic found on
>  	A83T dev board.
>  
> +config AXP318W_POWER
> +	bool "axp318w pmic support"
> +	select AXP_PMIC_BUS
> +	select CMD_POWEROFF
> +	---help---
> +	Select this to enable support for the AXP318W PMIC found on some
> +	A733 boards.
> +
>  config SY8106A_POWER
>  	bool "SY8106A pmic support"
>  	depends on MACH_SUNXI_H3_H5
> @@ -154,6 +163,7 @@ config AXP_I2C_ADDRESS
>  	depends on ARCH_SUNXI && !SUNXI_NO_PMIC
>  	default 0x36 if AXP305_POWER
>  	default 0x36 if AXP313_POWER
> +	default 0x36 if AXP318W_POWER
>  	default 0x30 if AXP152_POWER
>  	default 0x34
>  	---help---

So up until here the changes are for the SPL version of the AXP driver,
though actually it wouldn't work, since there is no code built for the
new symbol. You would need to add just the required DCDC regulators
into axp_spl.c, and then add the new symbol to drivers/power/Makefile.
Please do this (together with the changes above) in one patch.


The part below if for U-Boot proper, and looks superficially alright,
but should be in a patch of its own.

Thanks,
Andre

> diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
> index 1204ec00f8d..7d8348b0769 100644
> --- a/drivers/power/pmic/axp.c
> +++ b/drivers/power/pmic/axp.c
> @@ -95,6 +95,7 @@ static const struct udevice_id axp_pmic_ids[] = {
>  	{ .compatible = "x-powers,axp806", .data = AXP806_ID },
>  	{ .compatible = "x-powers,axp809", .data = AXP809_ID },
>  	{ .compatible = "x-powers,axp813", .data = AXP813_ID },
> +	{ .compatible = "x-powers,axp318w", .data = AXP318_ID },
>  	{ }
>  };
>  
> diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
> index 7794a4f5d92..34c575e16eb 100644
> --- a/drivers/power/regulator/axp_regulator.c
> +++ b/drivers/power/regulator/axp_regulator.c
> @@ -189,6 +189,55 @@ static const struct axp_regulator_plat axp313_regulators[] = {
>  	{ }
>  };
>  
> + /*
> +  * Only two level step tuning is implemented for DCDC6, 8, 9
> +  * so the voltage below is not support in this driver
> +  * DCDC6:   20  (v1.8 - 2.4v), 40 (2.44v - 2.76v)
> +  * DCDC8,9: 100 (1.9v - 3.4v)
> +  */
> +static const struct axp_regulator_plat axp318_regulators[] = {
> +	{ "dcdc1", 0x10, BIT(0), 0x12, 0x1f,  1000, 3400,  100, 0 },
> +	{ "dcdc2", 0x10, BIT(1), 0x13, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc3", 0x10, BIT(2), 0x14, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc4", 0x10, BIT(3), 0x15, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc5", 0x10, BIT(4), 0x16, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc6", 0x10, BIT(5), 0x17, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc7", 0x10, BIT(6), 0x18, 0x7f,  500, 1840,  10, 70 },
> +	{ "dcdc8", 0x10, BIT(7), 0x19, 0x7f,  500, 1840,  10, 70 },
> +	{ "dcdc9", 0x11, BIT(0), 0x1a, 0x7f,  500, 1840,  10, 70 },
> +	{ "aldo1", 0x20, BIT(0), 0x24, 0x1f,  500, 3400, 100, NA },
> +	{ "aldo2", 0x20, BIT(1), 0x25, 0x1f,  500, 3400, 100, NA },
> +	{ "aldo3", 0x20, BIT(2), 0x26, 0x1f,  500, 3400, 100, NA },
> +	{ "aldo4", 0x20, BIT(3), 0x27, 0x1f,  500, 3400, 100, NA },
> +	{ "aldo5", 0x20, BIT(4), 0x28, 0x1f,  500, 3400, 100, NA },
> +	{ "aldo6", 0x20, BIT(5), 0x29, 0x1f,  500, 3400, 100, NA },
> +	{ "bldo1", 0x20, BIT(6), 0x2a, 0x1f,  500, 3400, 100, NA },
> +	{ "bldo2", 0x20, BIT(7), 0x2b, 0x1f,  500, 3400, 100, NA },
> +	{ "bldo3", 0x21, BIT(0), 0x2c, 0x1f,  500, 3400, 100, NA },
> +	{ "bldo4", 0x21, BIT(1), 0x2d, 0x1f,  500, 3400, 100, NA },
> +	{ "bldo5", 0x21, BIT(2), 0x2e, 0x1f,  500, 3400, 100, NA },
> +	{ "cldo1", 0x21, BIT(3), 0x2f, 0x1f,  500, 3400, 100, NA },
> +	{ "cldo2", 0x21, BIT(4), 0x30, 0x1f,  500, 3400, 100, NA },
> +	{ "cldo3", 0x21, BIT(5), 0x31, 0x1f,  500, 3400, 100, NA },
> +	{ "cldo4", 0x21, BIT(6), 0x32, 0x1f,  500, 3400, 100, NA },
> +	{ "cldo5", 0x21, BIT(7), 0x33, 0x1f,  500, 3400, 100, NA },
> +	{ "dldo1", 0x22, BIT(0), 0x34, 0x1f,  500, 3400, 100, NA },
> +	{ "dldo2", 0x22, BIT(1), 0x35, 0x1f,  500, 3400, 100, NA },
> +	{ "dldo3", 0x22, BIT(2), 0x36, 0x1f,  500, 3400, 100, NA },
> +	{ "dldo4", 0x22, BIT(3), 0x37, 0x1f,  500, 3400, 100, NA },
> +	{ "dldo5", 0x22, BIT(4), 0x38, 0x1f,  500, 3400, 100, NA },
> +	{ "dldo6", 0x22, BIT(5), 0x39, 0x1f,  500, 3400, 100, NA },
> +	{ "eldo1", 0x22, BIT(6), 0x3a, 0x1f,  500, 1500, 25, NA },
> +	{ "eldo2", 0x22, BIT(7), 0x3b, 0x1f,  500, 1500, 25, NA },
> +	{ "eldo3", 0x23, BIT(0), 0x3c, 0x1f,  500, 1500, 25, NA },
> +	{ "eldo4", 0x23, BIT(1), 0x3d, 0x1f,  500, 1500, 25, NA },
> +	{ "eldo5", 0x23, BIT(2), 0x3e, 0x1f,  500, 1500, 25, NA },
> +	{ "eldo6", 0x23, BIT(3), 0x3f, 0x1f,  500, 1500, 25, NA },
> +	{ "dc1sw1", 0x11, BIT(3),  NA,   NA,   NA,   NA, NA, NA },
> +	{ "dc1sw2", 0x11, BIT(4),  NA,   NA,   NA,   NA, NA, NA },
> +	{ }
> +};
> +
>  /*
>   * The "dcdc2" regulator has another range, beyond 1.54V up to 3.4V, in
>   * steps of 100mV. We cannot model this easily, but also don't need that,
> @@ -318,6 +367,7 @@ static const struct axp_regulator_plat *const axp_regulators[] = {
>  	[AXP221_ID]	= axp22x_regulators,
>  	[AXP223_ID]	= axp22x_regulators,
>  	[AXP313_ID]	= axp313_regulators,
> +	[AXP318_ID]	= axp318_regulators,
>  	[AXP323_ID]	= axp313_regulators,
>  	[AXP717_ID]	= axp717_regulators,
>  	[AXP803_ID]	= axp803_regulators,
> diff --git a/include/axp_pmic.h b/include/axp_pmic.h
> index 1806a7270a0..2f547da74c2 100644
> --- a/include/axp_pmic.h
> +++ b/include/axp_pmic.h
> @@ -39,6 +39,7 @@ enum {
>  	AXP806_ID,
>  	AXP809_ID,
>  	AXP813_ID,
> +	AXP318_ID,
>  };
>  
>  int axp_set_dcdc1(unsigned int mvolt);
> 

