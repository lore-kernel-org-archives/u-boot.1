Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EC4D2ECEF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 23:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE8583A1E;
	Tue, 20 Jan 2026 00:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2368389A; Tue, 20 Jan 2026 00:11:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B992683A3B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 00:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 850731476;
 Mon, 19 Jan 2026 15:10:58 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6F763F632;
 Mon, 19 Jan 2026 15:11:03 -0800 (PST)
Date: Tue, 20 Jan 2026 00:09:57 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Paul Kocialkowski <contact@paulk.fr>, Samuel
 Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 2/9] power: regulator: enable AWP318W SPL support
Message-ID: <20260120000957.4843aa84@ryzen.lan>
In-Reply-To: <20260113-01-a733-soc-support-v3-2-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
 <20260113-01-a733-soc-support-v3-2-f19dcd098f60@gentoo.org>
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

On Tue, 13 Jan 2026 12:01:56 +0800
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Add the descriptions for the DC/DC regulators of the AXP318W, and enable
> it when CONFIG_AXP318W_POWER is enabled.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/power/Kconfig   | 10 ++++++++++
>  drivers/power/Makefile  |  1 +
>  drivers/power/axp_spl.c | 20 ++++++++++++++++++++
>  3 files changed, 31 insertions(+)
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
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 3363191fdc8..1a54898c874 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_AXP152_POWER)	+= axp152.o
>  obj-$(CONFIG_AXP209_POWER)	+= axp209.o
>  obj-$(CONFIG_AXP305_POWER)	+= axp_spl.o
>  obj-$(CONFIG_AXP313_POWER)	+= axp_spl.o
> +obj-$(CONFIG_AXP318W_POWER)	+= axp_spl.o
>  obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
>  obj-$(CONFIG_AXP809_POWER)	+= axp809.o
>  obj-$(CONFIG_AXP818_POWER)	+= axp818.o
> diff --git a/drivers/power/axp_spl.c b/drivers/power/axp_spl.c
> index 7c51a9b3dfb..b40f13c2261 100644
> --- a/drivers/power/axp_spl.c
> +++ b/drivers/power/axp_spl.c
> @@ -67,6 +67,26 @@ static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
>  #define AXP_SHUTDOWN_REG	0x1a
>  #define AXP_SHUTDOWN_MASK	BIT(7)
>  
> +#elif defined(CONFIG_AXP318W_POWER)				/* AXP318W */
> +
> +static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
> +	{ 0x10, BIT(0), 0x12, 0x1f, 1000, 3400, 100,  0 },

That should be same "NA" symbol as the last entry, but I can fix this
up while committing.

The rest looks fine, so with that fixed, and for the records (and
patchworks):

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +	{ 0x10, BIT(1), 0x13, 0x7f,  500, 1540,  10, 70 },
> +	{ 0x10, BIT(2), 0x14, 0x7f,  500, 1540,  10, 70 },
> +	{ 0x10, BIT(3), 0x15, 0x7f,  500, 1540,  10, 70 },
> +	{ 0x10, BIT(4), 0x16, 0x7f,  500, 1540,  10, 70 },
> +	{ 0x10, BIT(5), 0x17, 0x7f,  500, 1540,  10, 70 },
> +	{ 0x10, BIT(6), 0x18, 0x7f,  500, 1840,  10, 70 },
> +	{ 0x10, BIT(7), 0x19, 0x7f,  500, 1840,  10, 70 },
> +	{ 0x11, BIT(0), 0x1a, 0x7f,  500, 1840,  10, 70 },
> +};
> +
> +#define AXP_CHIP_VERSION	0
> +#define AXP_CHIP_VERSION_MASK	0
> +#define AXP_CHIP_ID		0
> +#define AXP_SHUTDOWN_REG	0x55
> +#define AXP_SHUTDOWN_MASK	BIT(7)
> +
>  #elif defined(CONFIG_AXP305_POWER)				/* AXP305 */
>  
>  static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
> 

