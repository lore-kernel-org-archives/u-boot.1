Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C671CD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 00:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870BF881B0;
	Wed,  3 Apr 2024 02:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Jx5SuxOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F717879DC; Wed,  3 Apr 2024 02:02:30 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF4F881B6
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 02:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240403000225epoutp01485578dfc9861a2d5de0a3360d23e57a~CnDGUmhyg1269812698epoutp01G
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 00:02:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240403000225epoutp01485578dfc9861a2d5de0a3360d23e57a~CnDGUmhyg1269812698epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712102545;
 bh=eobNXejZUon8omLqyG4z3h0J4nyHzGoJJ5ng1WcNGn4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Jx5SuxOu8thmypiGyvjBYUPiC7K9Az6ziKHCFJ+GBN9OwPhu3r/Vc3bj93SWWlrYc
 eDJZABGak8sy71JkFw5hBpatzJxg4/ztufJvMgVHM+/2v+9iT4u+QeeVnJRr6ZBHZE
 pDlcsMDEmY5odtiU4W/B81x9gGCuYaldFYPT2Eo8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240403000224epcas1p3d9c078275593f3a5a1a8d4865ad94dd9~CnDF9dWYz2519325193epcas1p39;
 Wed,  3 Apr 2024 00:02:24 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4V8Q0v3Hlbz4x9Q0; Wed,  3 Apr
 2024 00:02:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 33.BE.08627.F8C9C066; Wed,  3 Apr 2024 09:02:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240403000223epcas1p14279f53844b770f4f1b402e9309e100e~CnDEhH4YX0651806518epcas1p1m;
 Wed,  3 Apr 2024 00:02:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403000223epsmtrp218f5ec2afbafb43eef003d80eff0bbcf~CnDEgcAJg0329803298epsmtrp2S;
 Wed,  3 Apr 2024 00:02:23 +0000 (GMT)
X-AuditID: b6c32a33-d59fa700000021b3-53-660c9c8fd0a1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C9.5D.08390.E8C9C066; Wed,  3 Apr 2024 09:02:23 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403000222epsmtip11074309418f6d6341be749305d02aa14~CnDEEaCiA1158711587epsmtip1a;
 Wed,  3 Apr 2024 00:02:22 +0000 (GMT)
Message-ID: <ac386b15-e7fe-41b5-8be4-6fd1a5d5dc36@samsung.com>
Date: Wed, 3 Apr 2024 09:02:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Add SPL_MMC_PWRSEQ to fix link issue when
 building SPL
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever
 Yang <kever.yang@rock-chips.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240127171237.320834-1-jonas@kwiboo.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmgW7/HJ40g675EhYn31xlsdg2/Seb
 xfudtxgtfqz6wmrRvbLa4tuWbYwWUydtZreYNOEXm8XbvZ3sFgefnGVx4PKY3XCRxWN+53cm
 j1cHVrF7nJhwicnjzrU9bB5n7+xg9Nj4bgeTR0/bJiaPv7P2s3jsvP2QKYArKtsmIzUxJbVI
 ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hcJYWyxJxSoFBAYnGx
 kr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJucWleul5eaomVoYGBkSlQYUJ2xsM3YQV/lCum
 vOpkbWBcJ9vFyMkhIWAicXlhF2MXIxeHkMAORonZD/uhnE+MEi+f7WKGcL4xSjx8/Z0RpmXh
 g61MEIm9jBKbJu9gg3DeM0qs3/OTBaSKV8BOYvmGf+wgNouAisSvb5OZIeKCEidnPgGrERWQ
 l7h/awZYjbBAqMS9/3fBdosItDJJtP09wwSSYBZIl2i9dBfKFpe49WQ+mM0moCOx/dtxIJuD
 g1PATGLtIimIEnmJ7W/ngJ0tIXCGQ2Lvi81QZ7tIHFx6hg3CFpZ4dXwLO4QtJfH53V42iIZm
 RomlSw6yQjg9jBL/Gq5DdRhL7F86GWwbs4CmxPpd+hDb+CTefe1hBQlLCPBKdLQJQVSrSFx6
 /ZIJZv7dJ/9ZIWwPib8TZ7NCQquTUeLCupOMExgVZiEFzCwkf85C8tAshM0LGFlWMYqlFhTn
 pqcmGxYYwuM7OT93EyM4MWsZ72C8PP+f3iFGJg7GQ4wSHMxKIrw/vTnThHhTEiurUovy44tK
 c1KLDzGaAqNnIrOUaHI+MDfklcQbmlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQWgTT
 x8TBKdXAZOVRUNos35syZ9o3BX432YxGw93lO/NmHSt7JtL2RKogd42w/b6Hgd9e+wbNEFim
 /+fF49cTH8sY1Zu1GtyK+JL3yqH8QuCSk//VKw/1NnLfv+WWtnRFwfHf70p2F1Ts+qByJ8pZ
 /d7nZwu1405sWRmmb7B9pUjYiv33Ly5P37H63MFVgW+V8+9JT93RO9FvS7fZOjUnhq/dS1Pi
 hVhs1ifo70w/bel7vZ6h+GjELAve+mufluwWO9hcp9qZJ5TPudZrcuqbUzre3jdtzQ2bll2f
 Irqs26mN9f8r12NN4V3HWi79jhDsYy667fyt5/Yby+Co2m9HPFLMvndxJN9gim/6VWHqXPt7
 +9XCMy1blViKMxINtZiLihMBwBphU1UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG7/HJ40g1tTmCxOvrnKYrFt+k82
 i/c7bzFa/Fj1hdWie2W1xbct2xgtpk7azG4xacIvNou3ezvZLQ4+OcviwOUxu+Eii8f8zu9M
 Hq8OrGL3ODHhEpPHnWt72DzO3tnB6LHx3Q4mj562TUwef2ftZ/HYefshUwBXFJdNSmpOZllq
 kb5dAlfGwzdhBX+UK6a86mRtYFwn28XIySEhYCKx8MFWpi5GLg4hgd2MElcWfGaESEhJfH46
 la2LkQPIFpY4fLgYJCwk8JZRYv+GPBCbV8BOYvmGf+wgNouAisSvb5OZIeKCEidnPmEBsUUF
 5CXu35oBViMsECpx7/9dRpBdIgKtTBJnN60FSzALpEu8e3qbGWKBqcS0/Y1sEHFxiVtP5jOB
 2GwCOhLbvx1nArmHU8BMYu0iKRCTWUBdYv08IYhqeYntb+cwT2AUmoXkillIBs1C6JiFpGMB
 I8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg6NPS2sG4Z9UHvUOMTByMhxglOJiV
 RHh/enOmCfGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cAk
 65sZ6K74dvVaF89SgX2Pik6mc96fNZczZdK/uft37tvxYc/nSW/23lY2YjYqdfKc19Cyo4T/
 w2FpLYvZiquSPzolCQlefP3mxEkll8v1U9SnshoV7FKXX1T7LsQ37uSlM6xBT3PCbj8T/qaz
 xUl3WxTnlSVavYVut9OOB0VHtvEuzV28cZcG+65ze+75Zt4Qn9qwWrIpRarceu3azjS3BZnN
 U+Ntrz9e9Krtj1NH/U6dXQGrrN3/inRlHFR6cXSCZ7pkUMGauBv+1QY87gdmz7/L5Bri7Pmy
 8VGqpviR0n4Oz05fKUX+3wVXfhzLETz81jD12pE3F7yuv6490Vb1Ruz8moNv367VV58WGBSp
 xFKckWioxVxUnAgAThx2qC0DAAA=
X-CMS-MailID: 20240403000223epcas1p14279f53844b770f4f1b402e9309e100e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403000223epcas1p14279f53844b770f4f1b402e9309e100e
References: <20240127171237.320834-1-jonas@kwiboo.se>
 <CGME20240403000223epcas1p14279f53844b770f4f1b402e9309e100e@epcas1p1.samsung.com>
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

On 1/28/24 02:12, Jonas Karlman wrote:
> With MMC_PWRSEQ enabled the following link issue may happen when
> building SPL and SPL_PWRSEQ is not enabled.
> 
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meson_mmc_probe':
>   drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_power'
> 
> Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
> pwrseq support in SPL.
> 
> Also add depends on DM_GPIO to fix following link issue:
> 
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pwrseq_set_power':
>   drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_name'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined reference to `dm_gpio_set_value'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined reference to `dm_gpio_set_value'
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to u-boot-mmc/master, thanks! Sorry for late.

Best Regards,
Jaehoon Chung

> ---
> Changes in v2:
> - Fix Ths typo
> - Collect r-b and a-b tags
> 
> Link to v1: https://patchwork.ozlabs.org/patch/1839392/
> ---
>  drivers/mmc/Kconfig           | 12 ++++++++++--
>  drivers/mmc/Makefile          |  2 +-
>  drivers/mmc/meson_gx_mmc.c    |  2 +-
>  drivers/mmc/rockchip_dw_mmc.c |  2 +-
>  include/mmc.h                 |  4 ++--
>  5 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 17618c3bdcc1..a141007a576f 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -20,11 +20,19 @@ config MMC_WRITE
>  
>  config MMC_PWRSEQ
>  	bool "HW reset support for eMMC"
> -	depends on PWRSEQ
> +	depends on PWRSEQ && DM_GPIO
>  	help
> -	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
> +	  This select Hardware reset support aka pwrseq-emmc for eMMC
>  	  devices.
>  
> +config SPL_MMC_PWRSEQ
> +	bool "HW reset support for eMMC in SPL"
> +	depends on SPL_PWRSEQ && SPL_DM_GPIO
> +	default y if MMC_PWRSEQ
> +	help
> +	  This select Hardware reset support aka pwrseq-emmc for eMMC
> +	  devices in SPL.
> +
>  config MMC_BROKEN_CD
>  	bool "Poll for broken card detection case"
>  	help
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index e9cf1fcc6400..2b94cc2f1c34 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
>  endif
>  
>  obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
> -obj-$(CONFIG_MMC_PWRSEQ) += mmc-pwrseq.o
> +obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) += mmc-pwrseq.o
>  obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
>  
>  ifndef CONFIG_$(SPL_)BLK
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index fcf4f03d1e24..0825c0a2a838 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -288,7 +288,7 @@ static int meson_mmc_probe(struct udevice *dev)
>  
>  	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
>  
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	/* Enable power if needed */
>  	ret = mmc_pwrseq_get_power(dev, cfg);
>  	if (!ret) {
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 72c820ee6330..ad4529d6afa8 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -145,7 +145,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>  
>  	host->fifo_mode = priv->fifo_mode;
>  
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	/* Enable power if needed */
>  	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
>  	if (!ret) {
> diff --git a/include/mmc.h b/include/mmc.h
> index 1022db3ffa7c..9aef31ea5deb 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -590,7 +590,7 @@ struct mmc_config {
>  	uint f_max;
>  	uint b_max;
>  	unsigned char part_type;
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	struct udevice *pwr_dev;
>  #endif
>  };
> @@ -808,7 +808,7 @@ int mmc_deinit(struct mmc *mmc);
>   */
>  int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
>  
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  /**
>   * mmc_pwrseq_get_power() - get a power device from device tree
>   *

