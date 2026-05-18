Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454BCCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8448460E;
	Mon, 18 May 2026 23:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uzQ5yB9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077EA84688; Mon, 18 May 2026 23:41:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5AAF84119
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=584b=DQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779140474;
 bh=a68lbvKfiT6KFmYAZuz9mwh36JMWf5RV3eD+KGKRLT8=;
 b=uzQ5yB9gt1z9YN3KnpoKP1qCf7PNertPMMreojIW4q9LkvAybeSJx1lKdqJbYvCPTPCSCdXxF
 efLXVa2i/tJY3WzyGslUbzia72CgAQX6qmEh+Ac3IjZV5OwWTS/SAwODhx4WJGWfPv0NvJ8HAXb
 VvQ1Trw2JcLqOoq4wdBaHu4v88qdBZVVEyGq/NWos5RSmLhR7/MpFRMkQR5bchk+opIVCk6Xbl6
 SOTTMbJABS1Trphso7LFUm/GrXY1ifEn7tSPlSm4sHzwNQ+18uGXIhbBHMBJH8eUL6qGkg8ssAI
 yHYJWqJsl5WlUPVQ9mVkM8pCqNEt/5FTsY3moSNOOltQ==
X-Forward-Email-ID: 6a0b8767d74291a564fdd3f8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2c1a3b7f-7bec-4ec4-a2bc-4eba2fac8cab@kwiboo.se>
Date: Mon, 18 May 2026 23:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: rock-5-itx: drop pcie3 refclk from
 u-boot dtsi
To: Daniele Briguglio <hello@superkali.me>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
References: <20260518-rock-5-itx-pcie-refclk-dtsi-v1-1-faf8626039fc@superkali.me>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260518-rock-5-itx-pcie-refclk-dtsi-v1-1-faf8626039fc@superkali.me>
Content-Type: text/plain; charset=UTF-8
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

Hi Daniele,

On 5/18/2026 11:04 PM, Daniele Briguglio wrote:
> The Rock 5 ITX uses a PI6C 100MHz oscillator to drive its M.2 M-key
> and SATA PCIe3 controllers. In the Linux DTS the oscillator is
> described as a "gated-fixed-clock" node and added to the clocks
> list of pcie3x4 and pcie3x2 so that either controller's probe
> enables the supply.
> 
> U-Boot has no driver for the gated-fixed-clock compatible, so
> clk_get_bulk() in pcie_dw_rockchip fails with -ENODEV on the
> phandle and the PCIe3 controllers never come up:
> 
>   pcie_dw_rockchip pcie@fe150000: Can't get clock: -19
>   pcie_dw_rockchip pcie@fe160000: Can't get clock: -19
> 
> Override the clocks/clock-names of pcie3x4 and pcie3x2 in the
> u-boot dtsi to keep only the CRU clocks. vcc3v3_mkey is already
> regulator-always-on here and is the same regulator node as
> vcc3v3_pi6c_05, so the oscillator stays powered and the "ref"
> input ticks regardless. The Linux DTB is unchanged.

Linux and other OSs can be and are affected by U-Boot changes to the DT,
especially when UEFI is used to boot or when no external DT is supplied
while booting.

Please instead look into adding a simple UCLASS_CLK driver for the
gated-fixed-clock compatible, it should likely be a very simple driver.

clock-frequency prop value should be returned from .get_rate() clk ops
the vdd-supply regulator should be enabled in the .enable() clk ops, and
possible also request the enable-gpios pin to be active.

Following could possible be something for you to build upon (untested):

struct gated_fixed_clock_priv {
	struct udevice *supply;
};

int gated_fixed_clock_enable(struct clk *clk)
{
	struct gated_fixed_clock_priv *priv = dev_get_priv(clk->dev);
	
	return regulator_set_enable_if_allowed(priv->supply, true);
}

int gated_fixed_clock_disable(struct clk *clk)
{
	struct gated_fixed_clock_priv *priv = dev_get_priv(clk->dev);

	return regulator_set_enable_if_allowed(priv->supply, false);
}

static int gated_fixed_clock_probe(struct udevice *dev)
{
	struct gated_fixed_clock_priv *priv = dev_get_priv(dev);

	return device_get_supply_regulator(dev, "vdd-supply", &priv->supply);
}

static struct clk_ops gated_fixed_clock_ops = {
	.enable = gated_fixed_clock_enable,
	.disable = gated_fixed_clock_disable,
};

static const struct udevice_id gated_fixed_clock_ids[] = {
	{ .compatible = "gated-fixed-clock" },
	{ /* sentinel */ }
};

U_BOOT_DRIVER(gated_fixed_clock) = {
	.name = "gated_fixed_clock",
	.id = UCLASS_CLK,
	.of_match = gated_fixed_clock_ids,
	.probe = gated_fixed_clock_probe,
	.priv_auto = sizeof(struct gated_fixed_clock_priv),
	.ops = &gated_fixed_clock_ops,
};

Regards,
Jonas

> 
> Link: https://lore.kernel.org/r/20240906082511.2963890-6-heiko@sntech.de
> Signed-off-by: Daniele Briguglio <hello@superkali.me>
> ---
> Tested on a Rock 5 ITX with an NVMe drive in the M.2 M-key slot.
> ---
>  arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
> index 1e5c2674e..51ca79653 100644
> --- a/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include "rk3588-u-boot.dtsi"
> +#include <dt-bindings/clock/rockchip,rk3588-cru.h>
>  
>  &fspim2_pins {
>  	bootph-pre-ram;
> @@ -20,3 +21,22 @@
>  &vcc3v3_mkey {
>  	regulator-always-on;
>  };
> +
> +/* Drop pcie30_port{0,1}_refclk: U-Boot has no gated-fixed-clock driver. */
> +&pcie3x4 {
> +	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
> +	clock-names = "aclk_mst", "aclk_slv",
> +		      "aclk_dbi", "pclk",
> +		      "aux", "pipe";
> +};
> +
> +&pcie3x2 {
> +	clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
> +		 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
> +		 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>;
> +	clock-names = "aclk_mst", "aclk_slv",
> +		      "aclk_dbi", "pclk",
> +		      "aux", "pipe";
> +};
> 
> ---
> base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
> change-id: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d
> 
> Best regards,
> --  
> Daniele Briguglio <hello@superkali.me>
> 

