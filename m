Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381CCC001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 04:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE1887585;
	Sat, 21 Oct 2023 06:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="YAXfwUxZ";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nczTPYBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A18387480; Sat, 21 Oct 2023 06:34:46 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D6C86F42
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 06:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4DD2E5C010C;
 Sat, 21 Oct 2023 00:34:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sat, 21 Oct 2023 00:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697862878; x=1697949278; bh=76ObXIxf9p7pGRKRLLeIC7m0oYHSCFmbA83
 uHdn/shg=; b=YAXfwUxZVQJcu6mDSx7QhmDC0Fh51s+PJbcjNaITUUb6WfjGKL3
 AFe2H8IluDVFUmgqS4aX44VjKvYbRoqCGDIhyIS14G23GJZH5JA7HEfWdhP+wMKJ
 xE72YURBk4fNLKkDZETuUy+KBw6O6YgRND7j1cVjxS+BDJSA4wlgJzbG6lyuhFQf
 zRVtYyiZ4zTGz8kFjQYAHoR1Tjj8M9l1Ly1affYF2u3pVmvHLwXEy3sQVOJgUUrm
 fqG9k1QJ6M2WPwmW2M6QWmhVEbd3uu0o3niEsvdtyj91zXrXqHaGBFQ1k5YNwUws
 nGZyvLeWgiH3YClswre2T1VKuG95aK2qbOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697862878; x=1697949278; bh=76ObXIxf9p7pGRKRLLeIC7m0oYHSCFmbA83
 uHdn/shg=; b=nczTPYBeN6X87Vkl4smnTWxWIQozBkvMFuHd4GUF+VC+gLWNjA6
 E60qj5yTXJvXgwpeHowLHc2vBZ1neZyuX3nY4g8xpisaOkg3lciTyVQez8XImawZ
 /gOI1XhSiieb3eddgHMJfypaF7Wza9EqlFcvZef6+XKfWif+3Py1Y4g/JyYOhn0s
 fJQMFnlXyb69PY15p0/Sq1BcDkovQiVPkkQ8nz16df6N/ZuD1hPE8qplZkdip3sX
 HUhTGwayuY/TaZfuAG1dH0ITl8ig7T+eLfD9gpjhnHoxXhPhpKhfpriBrXwCK988
 7k/SMrI+bljZFt7v/aN+m+6UKocwe7KQZXw==
X-ME-Sender: <xms:3FQzZYyfVnWReRlPzs6IS0bOZI7SbKReapzy5cmDwQ0Y2rligoXgSQ>
 <xme:3FQzZcTSP45buf9BH50LMOsQ8D8rAl8M4ecclljYJoP-ADpXmekxPtMCsSvAxjBMD
 MkGeOUZ0SrNyrR8kQ>
X-ME-Received: <xmr:3FQzZaUtmSTOPcRqI5c5JamYJRI4Me5kM4-ugyPH0tjUW4FEKmAUktPJy0DZhDJ7yT8kn4FyekoInyn9qka7Kt4gSSw9utFZQ3NFv6KGL4LnzYj0Fa8_-oC_wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeelgdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3FQzZWgZOqNe0VfifhpusiZ9tQrsCXrgH2jtMkgP8qaVhJtaW6il9g>
 <xmx:3FQzZaAFtIqYZeFwrHIJthQIDy0ysXbJuFMnpBe019zgN9bwnSVj0Q>
 <xmx:3FQzZXLBGjzLT7f3uvBQlEgRDKtOReFDF7hgOJ-NypLHIhrEGOz8eA>
 <xmx:3lQzZW3JskPKypQR8cDTlds-BwNOgMIoMUS0Tm0z3J2DWTkuM4I7WQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 00:34:35 -0400 (EDT)
Message-ID: <a9afd926-32f5-de64-6714-341ffea3bfb2@sholland.org>
Date: Fri, 20 Oct 2023 23:34:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 11/22] pinctrl: sunxi: add Allwinner D1 pinctrl
 description
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-12-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-12-andre.przywara@arm.com>
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
> Apart from using the new pinctrl MMIO register layout, the Allwinner D1
> and related SoCs still need to usual set of mux values hardcoded in
> U-Boot's pinctrl driver.
> Add the values we need so far to this list, so that DM based drivers
> will just work without further ado.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/pinctrl/sunxi/Kconfig         |  4 ++++
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 28 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 77da90836b6..c8f937d91e9 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -124,4 +124,8 @@ config PINCTRL_SUN50I_H616_R
>  	default MACH_SUN50I_H616
>  	select PINCTRL_SUNXI
>  
> +config PINCTRL_SUN20I_D1
> +	bool "Support for the Allwinner D1/R528 PIO"
> +	select PINCTRL_SUNXI
> +
>  endif
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index fc80fe50b14..66876d9954a 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -748,6 +748,28 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun50i_h616_r_pinctrl_desc
>  	.num_banks	= 1,
>  };
>  
> +static const struct sunxi_pinctrl_function sun20i_d1_pinctrl_functions[] = {

Please keep these sections (and the OF match data) sorted numerically.

> +	{ "emac",	8 },	/* PE0-PE15 */
> +	{ "gpio_in",	0 },
> +	{ "gpio_out",	1 },

My local patch had a few more entries. Feel free to add them:

+       { "i2c0",       4 },    /* PB10-PB11 */

> +	{ "mmc0",	2 },	/* PF0-PF5 */

+       { "mmc1",       2 },    /* PG0-PG5 */

> +	{ "mmc2",	3 },	/* PC1-PC7 */

Should be PC2-PC7. Everything else looks correct.

> +	{ "spi0",	2 },	/* PC2-PC7 */
> +#if IS_ENABLED(CONFIG_UART0_PORT_F)
> +	{ "uart0",	3 },	/* PF2,PF4 */
> +#else
> +	{ "uart0",	6 },	/* PB0-PB1, PB8-PB9, PE2-PE3 */
> +#endif

+       { "uart1",      2 },    /* PG6-PG7 */
+       { "uart2",      7 },    /* PB0-PB1 */

Regards,
Samuel

> +	{ "uart3",	7 },	/* PB6-PB7 */
> +};
> +
> +static const struct sunxi_pinctrl_desc __maybe_unused sun20i_d1_pinctrl_desc = {
> +	.functions	= sun20i_d1_pinctrl_functions,
> +	.num_functions	= ARRAY_SIZE(sun20i_d1_pinctrl_functions),
> +	.first_bank	= SUNXI_GPIO_A,
> +	.num_banks	= 7,
> +};
> +
>  static const struct udevice_id sunxi_pinctrl_ids[] = {
>  #ifdef CONFIG_PINCTRL_SUNIV_F1C100S
>  	{
> @@ -904,6 +926,12 @@ static const struct udevice_id sunxi_pinctrl_ids[] = {
>  		.compatible = "allwinner,sun50i-h616-r-pinctrl",
>  		.data = (ulong)&sun50i_h616_r_pinctrl_desc,
>  	},
> +#endif
> +#ifdef CONFIG_PINCTRL_SUN20I_D1
> +	{
> +		.compatible = "allwinner,sun20i-d1-pinctrl",
> +		.data = (ulong)&sun20i_d1_pinctrl_desc,
> +	},
>  #endif
>  	{}
>  };

