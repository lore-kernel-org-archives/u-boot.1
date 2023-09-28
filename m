Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3262EE732FE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 17:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA5F86545;
	Thu, 28 Sep 2023 19:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B498654D; Thu, 28 Sep 2023 19:18:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6D1E186529
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 19:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E5C1FB;
 Thu, 28 Sep 2023 10:19:24 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24003F5A1;
 Thu, 28 Sep 2023 10:18:45 -0700 (PDT)
Date: Thu, 28 Sep 2023 18:18:41 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: clbcjt@outlook.com
Cc: u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] board: LicheePi_Zero: add emac support
Message-ID: <20230928181841.567fde31@donnerap.manchester.arm.com>
In-Reply-To: <PH0PR19MB54288958D7F6329111F426BDCCFEA@PH0PR19MB5428.namprd19.prod.outlook.com>
References: <PH0PR19MB54288958D7F6329111F426BDCCFEA@PH0PR19MB5428.namprd19.prod.outlook.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Sat, 23 Sep 2023 16:53:49 +0800
clbcjt@outlook.com wrote:

Hi,

thanks for sending a patch. Please make sure to CC: the respective
maintainers, as listed by scripts/get_maintainer.pl.

First this needs some commit message, stating why this change is needed.

Looking down, this actually looks like several patches:
- one to add the clock gates and resets
- one to add the compatible string to the sun8i-emac driver
- one to introduce a defconfig for the LicheePi Zero docking board
I dimly remember Icenowy once sending something for this before?


> From: FH0 <clbcjt@outlook.com>

Please use your real name here ...

> Signed-off-by: FH0 <clbcjt@outlook.com>

and in particular here.

> ---
>  arch/arm/dts/sun8i-v3s-licheepi-zero.dts | 6 ++++++
>  configs/LicheePi_Zero_defconfig          | 4 +++-
>  drivers/clk/sunxi/clk_v3s.c              | 6 ++++++
>  drivers/net/sun8i_emac.c                 | 7 +++++++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
> index 2e4587d2..b3246b94 100644
> --- a/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
> +++ b/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
> @@ -49,6 +49,7 @@
>  	compatible = "licheepi,licheepi-zero", "allwinner,sun8i-v3s";
>  
>  	aliases {
> +		ethernet0 = &emac;
>  		serial0 = &uart0;
>  	};
>  
> @@ -99,3 +100,8 @@
>  	usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  };
> +
> +&emac {
> +	allwinner,leds-active-low;
> +	status = "okay";
> +};

But the normal LicheePi Zero does not have an Ethernet jack, right? That's
only on the "docking" board? And Ethernet is already described there, in
sun8i-v3s-licheepi-zero-dock.dts.

Also, in general: devicetree changes need to go through the Linux tree
first - though this shouldn't be needed in this case.

> diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
> index 009384ea..779d5c9d 100644
> --- a/configs/LicheePi_Zero_defconfig
> +++ b/configs/LicheePi_Zero_defconfig
> @@ -5,4 +5,6 @@ CONFIG_SPL=y
>  CONFIG_MACH_SUN8I_V3S=y
>  CONFIG_DRAM_CLK=360
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
> -# CONFIG_NET is not set
> +CONFIG_NET=y
> +CONFIG_NET_RANDOM_ETHADDR=y

Why is this? Is it that the V3s does not have a SID, so we don't have the
ID registers to derive a MAC address? That would be a good thing to
mention in the commit message.

> +CONFIG_SUN8I_EMAC=y
> diff --git a/drivers/clk/sunxi/clk_v3s.c b/drivers/clk/sunxi/clk_v3s.c
> index 6524c135..680a43f2 100644
> --- a/drivers/clk/sunxi/clk_v3s.c
> +++ b/drivers/clk/sunxi/clk_v3s.c
> @@ -37,6 +37,9 @@ static struct ccu_clk_gate v3s_gates[] = {
>  
>  	[CLK_DE]		= GATE(0x104, BIT(31)),
>  	[CLK_TCON0]		= GATE(0x118, BIT(31)),
> +
> +	[CLK_BUS_EMAC]  = GATE(0x060, BIT(17)),
> +	[CLK_BUS_EPHY]  = GATE(0x070, BIT(0)),

Please align this with the rest of the definitions.

>  };
>  
>  static struct ccu_reset v3s_resets[] = {
> @@ -56,6 +59,9 @@ static struct ccu_reset v3s_resets[] = {
>  	[RST_BUS_UART0]		= RESET(0x2d8, BIT(16)),
>  	[RST_BUS_UART1]		= RESET(0x2d8, BIT(17)),
>  	[RST_BUS_UART2]		= RESET(0x2d8, BIT(18)),
> +
> +	[RST_BUS_EMAC]		= RESET(0x2c0, BIT(17)),
> +	[RST_BUS_EPHY]		= RESET(0x2c8, BIT(2)),

Those two hunks (CLK + RST) should go into a separate patch.

>  };
>  
>  const struct ccu_desc v3s_ccu_desc = {
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 04c3274f..57e6857a 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -895,6 +895,11 @@ static const struct emac_variant emac_variant_h3 = {
>  	.support_rmii		= true,
>  };
>  
> +static const struct emac_variant emac_variant_v3s = {
> +	.syscon_offset		= 0x30,
> +	.soc_has_internal_phy	= true,
> +};
> +
>  static const struct emac_variant emac_variant_r40 = {
>  	.syscon_offset		= 0x164,
>  };
> @@ -914,6 +919,8 @@ static const struct udevice_id sun8i_emac_eth_ids[] = {
>  	  .data = (ulong)&emac_variant_a83t },
>  	{ .compatible = "allwinner,sun8i-h3-emac",
>  	  .data = (ulong)&emac_variant_h3 },
> +	{ .compatible = "allwinner,sun8i-v3s-emac",
> +	  .data = (ulong)&emac_variant_v3s },

The changes to this file would be another separate patch.

Cheers,
Andre

>  	{ .compatible = "allwinner,sun8i-r40-gmac",
>  	  .data = (ulong)&emac_variant_r40 },
>  	{ .compatible = "allwinner,sun50i-a64-emac",

