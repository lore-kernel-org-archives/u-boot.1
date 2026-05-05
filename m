Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE3CD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 04:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147EC847D9;
	Wed,  6 May 2026 06:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FAF849D8; Wed,  6 May 2026 01:28:40 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9A984996
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 01:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux@timmermann.space
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g9F7p4qd2z9v4m;
 Wed,  6 May 2026 01:28:38 +0200 (CEST)
Date: Wed, 6 May 2026 01:28:31 +0200
From: Lukas Timmermann <linux@timmermann.space>
To: Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>
Subject: Re: [PATCH RFC v3 2/2] gpio: s5p: Disable when using upstream DTS
Message-ID: <afp807qAJ0IV9EKP@archstation>
References: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
 <20260506-pinctrl-exyno5250-v3-2-11649fe82210@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-pinctrl-exyno5250-v3-2-11649fe82210@timmermann.space>
X-Mailman-Approved-At: Wed, 06 May 2026 06:52:22 +0200
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

On Wed, May 06, 2026 at 01:13:30AM +0200, Lukas Timmermann wrote:
> Prevent the older s5p_gpio driver from probing when using upstream DTs
> because of incompatibilities. pinctrl_exynos5250 driver should be used
> instead which binds the s5p_gpio for gpio features but replaces pinctrl.
> 
> Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
> ---
>  drivers/gpio/s5p_gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
> index c072f146514..f32c5f7ae1a 100644
> --- a/drivers/gpio/s5p_gpio.c
> +++ b/drivers/gpio/s5p_gpio.c
> @@ -353,7 +353,9 @@ static const struct udevice_id exynos_gpio_ids[] = {
>  	{ .compatible = "samsung,s5pc110-pinctrl" },
>  	{ .compatible = "samsung,exynos4210-pinctrl" },
>  	{ .compatible = "samsung,exynos4x12-pinctrl" },
> +#if IS_ENABLED(CONFIG_OF_UPSTREAM)
I just noticed, that this if should be inverted. Will be fixed in the
next patch. Sorry for the noise.
>  	{ .compatible = "samsung,exynos5250-pinctrl" },
> +#endif
>  	{ .compatible = "samsung,exynos5420-pinctrl" },
>  	{ .compatible = "samsung,exynos78x0-gpio" },
>  	{ }
> 
> -- 
> 2.54.0
> 

Best regards

Lukas Timmermann
