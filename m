Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2023CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 23:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED09683390;
	Wed,  3 Sep 2025 01:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CD6833D0; Wed,  3 Sep 2025 01:47:43 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C680A832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 01:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id AAE77B220274;
 Wed,  3 Sep 2025 01:47:39 +0200 (CEST)
Message-ID: <9b3b28cd-7ed7-454a-9bdb-1d56edf51719@freeshell.de>
Date: Tue, 2 Sep 2025 16:47:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/10] pcie: starfive: Add a optional power gpio support
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-7-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-7-hal.feng@starfivetech.com>
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



On 8/28/25 23:09, Hal Feng wrote:
> Get a optional power gpio and enable it if it is valid.
> 

I see this appears to be a normal thing that needs implemented in U-Boot
to have parity with Linux kernel, but the commit message should help me
understand why so I don't have to think so hard.

Expand why this is useful and how this is implemented in Linux kernel,
what is the API reference or something to give reason why U-Boot can
expect the devicetree property to be present from upstream
devicetree-rebasing.

> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/pci/pcie_starfive_jh7110.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
> index 51aca7359ff..f6b50d12a90 100644
> --- a/drivers/pci/pcie_starfive_jh7110.c
> +++ b/drivers/pci/pcie_starfive_jh7110.c
> @@ -45,6 +45,7 @@ struct starfive_pcie {
>  	struct pcie_plda plda;
>  	struct clk_bulk	clks;
>  	struct reset_ctl_bulk	rsts;
> +	struct gpio_desc	power_gpio;
>  	struct gpio_desc	reset_gpio;
>  	struct regmap *regmap;
>  	unsigned int stg_pcie_base;
> @@ -184,6 +185,10 @@ static int starfive_pcie_parse_dt(struct udevice *dev)
>  		dev_err(dev, "reset-gpio is not valid\n");
>  		return -EINVAL;
>  	}
> +
> +	gpio_request_by_name(dev, "enable-gpios", 0, &priv->power_gpio,
> +			     GPIOD_IS_OUT);
> +
>  	return 0;
>  }
>  
> @@ -205,6 +210,9 @@ static int starfive_pcie_init_port(struct udevice *dev)
>  		goto err_deassert_clk;
>  	}
>  
> +	if (dm_gpio_is_valid(&priv->power_gpio))
> +		dm_gpio_set_value(&priv->power_gpio, 1);
> +
>  	dm_gpio_set_value(&priv->reset_gpio, 1);
>  	/* Disable physical functions except #0 */
>  	for (i = 1; i < PLDA_FUNC_NUM; i++) {

-E
