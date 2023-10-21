Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56531C004C0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 04:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CF0874C3;
	Sat, 21 Oct 2023 06:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="C5RElYg4";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lA97rjj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A35287567; Sat, 21 Oct 2023 06:35:50 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B90874C0
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 06:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 08CDB5C0195;
 Sat, 21 Oct 2023 00:35:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sat, 21 Oct 2023 00:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697862945; x=1697949345; bh=ZORMa6kcHT25pnqSFbXpPvUnJnkrqh6KVvu
 xatejkJk=; b=C5RElYg45JKvUCqDSWPgCZtuJ/RhflRYHx+mXl6dg+s88tk1SYa
 6rBp3ARSNas5W+6sIfQFLYuHK8d7Z7vOrSRAPtcQHUupW33zcLcRN54VTW0Tia2I
 HG5X9d4hGDF8gCz3oB+Bdy9rK1dDThh2DiPS8G34DGxBcixj9JJegnwD6gEWLPVZ
 sJDRXPbiFYGYs7A1W7UqPhAhytuDBt2e9Klc/0ybJMb/Nh+ojmbqpODII3wLg7d+
 pciZiztHGCC4/Izupmz34TQT4qZk6S//mStVRk3pRtyDPvzGHvg39zXtufdcMe20
 yhjQ2DtbaX4GotzXG70pdmPrWaZcz73gC6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697862945; x=1697949345; bh=ZORMa6kcHT25pnqSFbXpPvUnJnkrqh6KVvu
 xatejkJk=; b=lA97rjj2+hMhhe0r68eJpuythIxiK2/J5d/8zTrkTQ01CLA++tq
 01jBfVXqNaX6S77mckPvVBKhSkPAkwkv0mB/1xJIezScf4atjZeawPD++6qCOp9Z
 d26OwVoVvcqINzdO2x8TE0q+5c8v+YmlownCA3QNrXgtf0jYTFBd7S7X6e1gP5yJ
 jYmyaNh6vUmybaLiTcnCJf3kJsnqcmlnaJhM1svpTxZt6DZhaFE5Y3uQ1VlQPFaT
 2TTklmi22a73C05PVUJVUR9ux1/If+g/S8s7Pnh8+Fefi35JyyRoaO4rkDE25a5k
 thsngx+lwbivlRansgHSl8wJZ3Z1fl0iKpw==
X-ME-Sender: <xms:IFUzZXHdoXLpUwqgxo53hma3IYH6C7k_lx7k0t2ldc-Dzvkx8fhSKw>
 <xme:IFUzZUXrAKYU_4UFzD9rl00Wm458KmzF9BcsBlRofchL-9gUWcN69CcFeTijZtniX
 wc6rZD0T0BuVxPfuQ>
X-ME-Received: <xmr:IFUzZZKCwDJJHnHBE5oinVNqci6EXFTyZMkmphfM7M58F7QnR8TK3G5F3MmKmcIOKiNdIdExL8DA4vmsztbHOio_zLdsfiU-D_NnXfJ288jht64Ezm34CDArrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeelgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
 jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:IFUzZVEwwtAjCPrYLlOwFqRnd1_QqQ7vLY_IZcugDkUmTnJgtqhHCw>
 <xmx:IFUzZdUcB18rZJpjjD06SQCapmLj0UXQTGHjgmmsVMc08nJrwBhn_g>
 <xmx:IFUzZQNBMaWXbGxiJFJl1uErMEutTvLXLGjSITEdDhA3oCZxT7e5AA>
 <xmx:IVUzZZozvYUjfMHQNNf2iPaz5i-sOyZzTZIe-cP6u9um4drtQ1M9XQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 00:35:44 -0400 (EDT)
Message-ID: <03f8e143-ea51-c9f1-2151-622c4abe098d@sholland.org>
Date: Fri, 20 Oct 2023 23:35:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-4-andre.przywara@arm.com>
Content-Language: en-US
From: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 03/22] sunxi: remove CONFIG_MACPWR
In-Reply-To: <20230928215455.28094-4-andre.przywara@arm.com>
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

Hi Andre,

On 9/28/23 16:54, Andre Przywara wrote:
> The CONFIG_MACPWR Kconfig symbol is used to point to a GPIO that enables
> the power for the Ethernet "MAC" (mostly PHY, really).
> In the DT this is described with the phy-supply property in the MAC DT
> node, pointing to a (GPIO controlled) regulator. Since we need Ethernet
> only in U-Boot proper, and use a DM driver there, we should use the DT
> instead of hardcoding this.
> 
> Add code to the sun8i_emac and sunxi_emac drivers to check the DT for
> that regulator and enable it, at probe time. Then drop the current code
> from board.c, which was doing that job before.
> This allows us to remove the MACPWR Kconfig definition and the respective
> values from the defconfigs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig           |  7 -------
>  board/sunxi/board.c                   | 12 +-----------
>  configs/Bananapi_M2_Ultra_defconfig   |  1 -
>  configs/Bananapi_defconfig            |  1 -
>  configs/Bananapro_defconfig           |  1 -
>  configs/Lamobo_R1_defconfig           |  1 -
>  configs/Mele_A1000_defconfig          |  1 -
>  configs/Orangepi_defconfig            |  1 -
>  configs/Orangepi_mini_defconfig       |  1 -
>  configs/bananapi_m1_plus_defconfig    |  1 -
>  configs/bananapi_m2_plus_h3_defconfig |  1 -
>  configs/bananapi_m2_plus_h5_defconfig |  1 -
>  configs/i12-tvbox_defconfig           |  1 -
>  configs/jesurun_q5_defconfig          |  1 -
>  configs/mixtile_loftq_defconfig       |  1 -
>  configs/nanopi_m1_plus_defconfig      |  1 -
>  configs/nanopi_neo_plus2_defconfig    |  1 -
>  configs/nanopi_r1s_h5_defconfig       |  1 -
>  configs/orangepi_pc2_defconfig        |  1 -
>  configs/orangepi_plus2e_defconfig     |  1 -
>  configs/orangepi_plus_defconfig       |  1 -
>  configs/orangepi_win_defconfig        |  1 -
>  configs/pine_h64_defconfig            |  1 -
>  configs/zeropi_defconfig              |  1 -
>  drivers/net/sun8i_emac.c              |  9 +++++++--
>  25 files changed, 8 insertions(+), 42 deletions(-)
> 
> [...]
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 04c3274fbe1..7b60a60ad52 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -29,6 +29,7 @@
>  #include <net.h>
>  #include <reset.h>
>  #include <wait_bit.h>
> +#include <power/regulator.h>
>  
>  #define MDIO_CMD_MII_BUSY		BIT(0)
>  #define MDIO_CMD_MII_WRITE		BIT(1)
> @@ -167,9 +168,8 @@ struct emac_eth_dev {
>  	struct clk ephy_clk;
>  	struct reset_ctl tx_rst;
>  	struct reset_ctl ephy_rst;
> -#if CONFIG_IS_ENABLED(DM_GPIO)
>  	struct gpio_desc reset_gpio;
> -#endif

This is sort of an unrelated cleanup, and there are several more
instances of this in the same file. Maybe split this to a separate patch?

Regards,
Samuel

> +	struct udevice *phy_reg;
>  };
>  
>  
> @@ -720,6 +720,9 @@ static int sun8i_emac_eth_probe(struct udevice *dev)
>  
>  	sun8i_emac_set_syscon(sun8i_pdata, priv);
>  
> +	if (priv->phy_reg)
> +		regulator_set_enable(priv->phy_reg, true);
> +
>  	sun8i_mdio_init(dev->name, dev);
>  	priv->bus = miiphy_get_dev_by_name(dev->name);
>  
> @@ -829,6 +832,8 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
>  
>  	priv->sysctl_reg = (void *)syscon_base + priv->variant->syscon_offset;
>  
> +	device_get_supply_regulator(dev, "phy-supply", &priv->phy_reg);
> +
>  	pdata->phy_interface = -1;
>  	priv->phyaddr = -1;
>  	priv->use_internal_phy = false;

