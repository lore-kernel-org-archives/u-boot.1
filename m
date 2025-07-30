Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8358C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 07:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20F282BA1;
	Wed, 30 Jul 2025 09:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N24PMn7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493A582BA1; Wed, 30 Jul 2025 09:23:31 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5202582B20
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 09:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso1121312a12.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753860208; x=1754465008; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aeuJspwy03GvUkcOMJa0AIny7FOgV0FWjMu9HjUosFs=;
 b=N24PMn7uFshp5GLOYQgOzulBVe92Q9v+fxiDQA7cNXfeIexzS6UjIsewQaZV12FyQd
 Ys10luGbCijH6sJixtTNwmnnFvUQRvxgCs7eoC1tWsttCz8TbB/fubSGfSygJDUHOB+7
 Ha0nIfxdZAJsp+FkhYyFMm+d6ZYgmqrQRlwK11aaUS9ltKPnB1HAP+4B3WkDVxJB+k1R
 4ooH8qGhCyb1uP/CbcvbmOnlyn/vSv/sZKFVnZzw1/6bGEI53nMQpdutUMChRqNFs5Bn
 Ow4DoT9Ag4mSW9ybh14KdbZoVTIvTRgyJlvZ3RsnHEa3BVIcFgO2/9iL+1KJtnSXvBFG
 dSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753860208; x=1754465008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aeuJspwy03GvUkcOMJa0AIny7FOgV0FWjMu9HjUosFs=;
 b=DqimtIvgZ6dv6NjFlGaLH/9UKAJe6lhTban7Rovze+m9UAFHQxhObUvj7d48vS2s4a
 01/H5tRYAF6xt5J5P5pAN4jcwli8BZXO/hdTDC1TORE9akRRGhEPkM0jYlfHP0yFLCHk
 z4lTy73NOECQvoRoA4D2r+5bLCLgFYlg1AMzHQG6uouQGEQLRLYilB0EYoNlUbTiMJ3a
 e/xMTQ2qtBjFVIyweFVmnnw4841BE7KUdNpfh+qB75FxzhSDJN0BEm8EP1B2NX2hUpTk
 a2Wgfb9noGjXtG1097n1Q7AJ5wmuYurZceercDNvcqZnRydGsYEOMewk/8XNCMQGAZnO
 0GQA==
X-Gm-Message-State: AOJu0YwpVQZMM2jZCSToEd5M/hKIKnso6HT3LHlvzKYfh8wBTe/HR75d
 TxijXjTYHsx7lcOlLsOPQuvJCbQw1MAzqkw9YlYAhpbnh+fS9HmZz221MWZnyhAq1o8=
X-Gm-Gg: ASbGncu6WhS99RakgD4ljwZxC2Vdg6n/YhftNIoDhdJwDYGye6vuajPGwXBXIBYVsn1
 UBQBM/VYaBgOMVd1grJ1rcjHasM4tshJgyS7pJQYoIoZqY/q/8ZHxCs+jyIH2QmA0mWal8CEYiw
 2KeTsCsNBWQXxcWDm4XzpJYCeP8ZwpIfbSW8XjBOOKNkJmzlo9jviBkWM8awJ7GfWTAsNCoG+7O
 TPSNW+KK/FcIBKNZWyaIz9Gln3x/9LcSfHXY6le+Nx730wug3ugiM3P7sCHQqx9ovbNRhvh+Q6O
 6OH0Kx/7tglmA3qrf24kyuNGUonJHONZvTjSMB2XkcSbUunuaVZBy3icRXnQc0v7/j8AM76v56r
 BJt616iZ09WsV4Xo5NQs0AonBqRqQFJk3w6FlOUJJMMDZ7z/7BnhJP7P1W/+EpZT/3G3ZuYvfdL
 JcFrkWeRM6JOlX
X-Google-Smtp-Source: AGHT+IEImBAEQ5noKQXVssmtXOb+r7uRP8SB2zjEtEkiJo6ZbeL/nM+7uSAVZvvZgK25VAm5irsEcQ==
X-Received: by 2002:a05:6402:180d:b0:606:a26c:6f46 with SMTP id
 4fb4d7f45d1cf-615870b14ebmr2136862a12.19.1753860207540; 
 Wed, 30 Jul 2025 00:23:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a542:3dbd:67dc:3d1d?
 ([2a01:e0a:3cb:7bb0:a542:3dbd:67dc:3d1d])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615226558d3sm4631282a12.45.2025.07.30.00.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 00:23:27 -0700 (PDT)
Message-ID: <2ee1be9d-7c8c-4db2-a10c-bb9dd9e87d49@linaro.org>
Date: Wed, 30 Jul 2025 09:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: phy: Support overriding Auto Negotiation timeout
 with env variable
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, alexthreed@gmail.com,
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com,
 paul.barker.ct@bp.renesas.com, romain.gantois@bootlin.com,
 lucienzx159@gmail.com, skylake.huang@mediatek.com
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com, nm@ti.com,
 srk@ti.com
References: <20250724141536.1222764-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250724141536.1222764-1-s-vadapalli@ti.com>
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

Hi Siddharth,

Replying since this patch has been standing in my queue (u-boot-net) and Tom
asked me to give my opinion.

On 7/24/25 16:15, Siddharth Vadapalli wrote:
> The Auto Negotiation procedure between two Ethernet PHYs consists of
> determining the best commonly supported parameters among Speed,
> Duplex Mode and Flow Control.
> 
> The time taken for this procedure is not only dependent on the local
> PHY used, but also on the link-partner PHY.
> 
> While a timeout can be specified in the form of a "CONFIG" on the basis
> of the local PHY present on the device, since the timeout also depends
> on the link-partner PHY, it might be necessary to modify the timeout.
> 
> To avoid rebuilding the bootloader for a given device, just because it
> may be connected to various link-partner PHYs, each with a different
> timeout, introduce an environment variable named "phy_aneg_timeout" and
> override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---

This looks sane to me. Based on a private email thread where various
options were discussed, I think that:
- Modifying the tree-wide default value for PHY_ANEG_TIMEOUT is probably
not a good idea. Sure it is a timeout not a delay, so increasing it will
go unnoticed for board that succeed the negotiation in less time. But it
will have an impact on boot time if it is expected that one phy times
out and another phy gets activated for example.
- Making the default different for TI boards makes little sense. This is
not an arch-specific thing.
- Therfore, allowing the user to override the timeout via an env var for
very specific deployment cases  seems like a good idea.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Regards,
-- 
Jerome

> 
> Hello,
> 
> This patch is based on commit
> 3532f1f5edf block: Remove blk_find_first/next
> of the master branch of Mainline U-Boot.
> 
> v2 of this patch is at:
> https://patchwork.ozlabs.org/project/uboot/patch/20250723062642.634345-1-s-vadapalli@ti.com/
> Changes since v2:
> - Addressed feedback from Quentin Schulz at:
>   https://patchwork.ozlabs.org/project/uboot/patch/20250723062642.634345-1-s-vadapalli@ti.com/#3550923
>   by performing the following changes:
>   1) Based the patch on the master branch of U-Boot instead of the next
>      branch.
>   2) Updated doc/usage/environment.rst by removing the default value of
>      CONFIG_PHY_ANEG_TIMEOUT which was taken from its Kconfig file.
>   3) Updated doc/usage/environment.rst by specificially mentioning the
>      base and unit of the "phy_aneg_timeout" variable as decimal and
>      millisecond.
>   4) Updated
>      a) drivers/net/phy/aquantia.c
>      b) drivers/net/phy/phy.c
>      c) drivers/net/xilinx_axi_emac.c
>      by using "u32" instead of "ulong" for storing the value of the
>      "phy_aneg_timeout" and also for the variable whose value is
>      compared against "phy_aneg_timeout".
> 
> v1 of this patch is at:
> https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/
> Changes since v1:
> - Switched to env_get_ulong() based on feedback from Marek Vasut at:
>   https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550426
> - Addressed feedback from Quentin Schulz at:
>   https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550263
>   by performing the following changes:
>   1) Updated drivers/net/phy/Kconfig by documenting that phy_aneg_timeout
>      env variable can override the value of CONFIG_PHY_ANEG_TIMEOUT
>   2) Updated doc/usage/environment.rst by documenting the base and unit
>      of phy_aneg_timeout
>   3) Updated drivers/net/phy/aquantia.c and drivers/net/xilinx_axi_emac.c
>      to support overriding CONFIG_PHY_ANEG_TIMEOUT with phy_aneg_timeout
> 
> Patch has been tested on J784S4-EVM validating the following cases:
> 1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
>    CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
>    => Auto Negotiation succeeds
> 2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 20,000.
>    "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>    [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>    => Auto Negotiation succeeds
> 3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 200.
>    "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>    [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>    => Auto Negotiation times out
> 
> Test Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/b1ee7ea655212c03e77a7eb1b9453728
> 
> Regards,
> Siddharth.
> 
>  doc/usage/environment.rst     | 9 +++++++++
>  drivers/net/phy/Kconfig       | 5 ++++-
>  drivers/net/phy/aquantia.c    | 9 +++++----
>  drivers/net/phy/phy.c         | 7 +++++--
>  drivers/net/xilinx_axi_emac.c | 4 +++-
>  5 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index bb6c351b441..77197d79380 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -335,6 +335,15 @@ netretry
>      Useful on scripts which control the retry operation
>      themselves.
>  
> +phy_aneg_timeout
> +    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT.
> +    This variable has the same base and unit as CONFIG_PHY_ANEG_TIMEOUT
> +    which is "decimal" and "millisecond" respectively. The default value
> +    of CONFIG_PHY_ANEG_TIMEOUT may be sufficient for most use-cases, but
> +    certain link-partners may require a larger timeout due to the Ethernet
> +    PHY they use. Alternatively, the timeout can be reduced as well if the
> +    use-case demands it.
> +
>  rng_seed_size
>      Size of random value added to device-tree node /chosen/rng-seed.
>      This variable is given as a decimal number.
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 8d88c142900..21bf983056a 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -23,7 +23,10 @@ config PHY_ANEG_TIMEOUT
>  	int "PHY auto-negotiation timeout"
>  	default 4000
>  	help
> -	  Default PHY auto-negotiation timeout.
> +	  Value of PHY auto-negotiation timeout with the base being
> +	  "decimal" and the unit being "millisecond". This can be
> +	  overridden by the "phy_aneg_timeout" environment variable
> +	  that has the same base (decimal) and unit (millisecond).
>  
>  if PHY_ADDR_ENABLE
>  config PHY_ADDR
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index d2db8d9f792..c29d8facdee 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -551,14 +551,15 @@ int aquantia_config(struct phy_device *phydev)
>  
>  int aquantia_startup(struct phy_device *phydev)
>  {
> -	u32 speed;
> -	int i = 0;
> +	u32 speed, i = 0;
>  	int reg;
>  
>  	phydev->duplex = DUPLEX_FULL;
>  
>  	/* if the AN is still in progress, wait till timeout. */
>  	if (!aquantia_link_is_up(phydev)) {
> +		u32 aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
> +						 CONFIG_PHY_ANEG_TIMEOUT);
>  		printf("%s Waiting for PHY auto negotiation to complete",
>  		       phydev->dev->name);
>  		do {
> @@ -566,9 +567,9 @@ int aquantia_startup(struct phy_device *phydev)
>  			if ((i++ % 500) == 0)
>  				printf(".");
>  		} while (!aquantia_link_is_up(phydev) &&
> -			 i < (4 * CONFIG_PHY_ANEG_TIMEOUT));
> +			 i < (4 * aneg_timeout));
>  
> -		if (i > CONFIG_PHY_ANEG_TIMEOUT)
> +		if (i > aneg_timeout)
>  			printf(" TIMEOUT !\n");
>  	}
>  
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index e6fed8c41d7..9702d042296 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -9,6 +9,7 @@
>   */
>  #include <console.h>
>  #include <dm.h>
> +#include <env.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <net.h>
> @@ -242,7 +243,9 @@ int genphy_update_link(struct phy_device *phydev)
>  
>  	if ((phydev->autoneg == AUTONEG_ENABLE) &&
>  	    !(mii_reg & BMSR_ANEGCOMPLETE)) {
> -		int i = 0;
> +		u32 i = 0;
> +		u32 aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
> +						 CONFIG_PHY_ANEG_TIMEOUT);
>  
>  		printf("%s Waiting for PHY auto negotiation to complete",
>  		       phydev->dev->name);
> @@ -250,7 +253,7 @@ int genphy_update_link(struct phy_device *phydev)
>  			/*
>  			 * Timeout reached ?
>  			 */
> -			if (i > (CONFIG_PHY_ANEG_TIMEOUT / 50)) {
> +			if (i > (aneg_timeout / 50)) {
>  				printf(" TIMEOUT !\n");
>  				phydev->link = 0;
>  				return -ETIMEDOUT;
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index 4d87e2d1f36..f072ac84990 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -343,6 +343,8 @@ static int axiemac_phy_init(struct udevice *dev)
>  
>  static int pcs_pma_startup(struct axidma_priv *priv)
>  {
> +	u32 aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
> +					 CONFIG_PHY_ANEG_TIMEOUT);
>  	u32 rc, retry_cnt = 0;
>  	u16 mii_reg;
>  
> @@ -361,7 +363,7 @@ static int pcs_pma_startup(struct axidma_priv *priv)
>  	 * and the external PHY is not obtained.
>  	 */
>  	debug("axiemac: waiting for link status of the PCS/PMA PHY");
> -	while (retry_cnt * 10 < CONFIG_PHY_ANEG_TIMEOUT) {
> +	while (retry_cnt * 10 < aneg_timeout) {
>  		rc = phyread(priv, priv->pcsaddr, MII_BMSR, &mii_reg);
>  		if ((mii_reg & BMSR_LSTATUS) && mii_reg != 0xffff && !rc) {
>  			debug(".Done\n");
