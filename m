Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5130E7F14B
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 01:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88212803AE;
	Wed, 27 Sep 2023 03:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SRTb3f1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988FE80422; Wed, 27 Sep 2023 03:31:36 +0200 (CEST)
Received: from mail-m12774.qiye.163.com (mail-m12774.qiye.163.com
 [115.236.127.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFA780282
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 03:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SRTb3f1Ryb/U0k2EJZgHoX1iCYrl0ImIs9zPSeW7PUZIFtkNdA5XvqIPqdDuaW0mBxRtFPBUKY78DbCqjB9u4xxpwAnNSLuiw82A7aOyxDTqMI39Sw590i5XNFWO8TIqPUdvRRkSyssDIkTPZ7DB4tM/JoBJvYaMHH3tRbzTBUw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=HS4IRRdSgFYpY2eMcipnEoEWmtCta3XF72DJRdj6UKg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 7DFB4400171;
 Wed, 27 Sep 2023 09:31:13 +0800 (CST)
Message-ID: <2161e326-b920-0d8e-e45c-06d310d36232@rock-chips.com>
Date: Wed, 27 Sep 2023 09:31:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building
 SPL
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20230925215516.1528643-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230925215516.1528643-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5OSlZOSk0fT0pMSR1KGkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad442f9b42eb3kusn7dfb4400171
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OS46Azo4Tjw*CDYwEj0NDDQ9
 LTEaCxxVSlVKTUJOTExDSUxPSE5LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQ0hINwY+
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


On 2023/9/26 05:55, Jonas Karlman wrote:
> With MMC_PWRSEQ enabled the following link issue may happen when
> building SPL and SPL_PWRSEQ is not enabled.
>
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meson_mmc_probe':
>    drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_power'
>
> Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
> pwrseq support in SPL.
>
> Also add depends on DM_GPIO to fix following link issue:
>
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pwrseq_set_power':
>    drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_name'
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined reference to `dm_gpio_set_value'
>    aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined reference to `dm_gpio_set_value'
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mmc/Kconfig           | 10 +++++++++-
>   drivers/mmc/Makefile          |  2 +-
>   drivers/mmc/meson_gx_mmc.c    |  2 +-
>   drivers/mmc/rockchip_dw_mmc.c |  2 +-
>   include/mmc.h                 |  4 ++--
>   5 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index de01b9687bad..a9931d39412d 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -20,11 +20,19 @@ config MMC_WRITE
>   
>   config MMC_PWRSEQ
>   	bool "HW reset support for eMMC"
> -	depends on PWRSEQ
> +	depends on PWRSEQ && DM_GPIO
>   	help
>   	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
>   	  devices.
>   
> +config SPL_MMC_PWRSEQ
> +	bool "HW reset support for eMMC in SPL"
> +	depends on SPL_PWRSEQ && SPL_DM_GPIO
> +	default y if MMC_PWRSEQ
> +	help
> +	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
> +	  devices in SPL.
> +
>   config MMC_BROKEN_CD
>   	bool "Poll for broken card detection case"
>   	help
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 2c65c4765ab2..0a79dd058bef 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
>   endif
>   
>   obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
> -obj-$(CONFIG_MMC_PWRSEQ) += mmc-pwrseq.o
> +obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) += mmc-pwrseq.o
>   obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
>   
>   ifndef CONFIG_$(SPL_)BLK
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index fcf4f03d1e24..0825c0a2a838 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -288,7 +288,7 @@ static int meson_mmc_probe(struct udevice *dev)
>   
>   	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
>   
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   	/* Enable power if needed */
>   	ret = mmc_pwrseq_get_power(dev, cfg);
>   	if (!ret) {
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 72c820ee6330..ad4529d6afa8 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -145,7 +145,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>   
>   	host->fifo_mode = priv->fifo_mode;
>   
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   	/* Enable power if needed */
>   	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
>   	if (!ret) {
> diff --git a/include/mmc.h b/include/mmc.h
> index 1022db3ffa7c..9aef31ea5deb 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -590,7 +590,7 @@ struct mmc_config {
>   	uint f_max;
>   	uint b_max;
>   	unsigned char part_type;
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   	struct udevice *pwr_dev;
>   #endif
>   };
> @@ -808,7 +808,7 @@ int mmc_deinit(struct mmc *mmc);
>    */
>   int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
>   
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>   /**
>    * mmc_pwrseq_get_power() - get a power device from device tree
>    *
