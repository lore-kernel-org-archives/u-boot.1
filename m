Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3C7CD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 00:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E869881AC;
	Wed,  3 Apr 2024 02:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="AXy3gBP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E46A881BF; Wed,  3 Apr 2024 02:45:48 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36E98817C
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 02:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240403004542epoutp01cfca9d458047a980e047445021ec156b~Cno4-ot172490024900epoutp01P
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 00:45:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240403004542epoutp01cfca9d458047a980e047445021ec156b~Cno4-ot172490024900epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712105142;
 bh=NJEngI92ONkGwStz158JT/RzbnczCwVs5ls3uoN3z98=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=AXy3gBP32Og5/sDo6bN9KK+zE3vdrXKRZnSLr3/Ig4NZus64AMmUlqbaquMCLrFGU
 4NrTi1L83WrDMDmIj6wm7IFa2qT5tZmXLuZ+L1oXlH/2czYisCw2eG+p+AkVWBfGT3
 /TTc8g9JD5FbskqKQoxnaLtWxhgdCp0jiuAFKy9A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240403004541epcas1p21cb4c69d1f9a4f2ed12eac403dc71f80~Cno4eUjzh1718317183epcas1p2u;
 Wed,  3 Apr 2024 00:45:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8Qyr4jc1z4x9Q0; Wed,  3 Apr
 2024 00:45:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.AA.10158.4B6AC066; Wed,  3 Apr 2024 09:45:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240403004539epcas1p22a414027e51daffba353e16bfca94e96~Cno234e2S2647526475epcas1p2c;
 Wed,  3 Apr 2024 00:45:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240403004539epsmtrp10764a7f4f4199e3d56227887977bb939~Cno23Rs3J0073500735epsmtrp1S;
 Wed,  3 Apr 2024 00:45:39 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-87-660ca6b41a7f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B8.21.08924.3B6AC066; Wed,  3 Apr 2024 09:45:39 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240403004539epsmtip25bb78c212ea2c373ab99443dafc1dc72~Cno2nyQuI0586705867epsmtip2R;
 Wed,  3 Apr 2024 00:45:39 +0000 (GMT)
Message-ID: <8dc1fead-ffd4-40f7-83a8-dda235ae1188@samsung.com>
Date: Wed, 3 Apr 2024 09:45:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: arm_pl180_mmci: Rely on DM
To: Linus Walleij <linus.walleij@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>, Ole Orhagen
 <ole.orhagen@northern.tech>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240208-uboot-vexpress-ca9-v1-1-ad7bc1f2f433@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmge6WZTxpBs/XKVmsmPeT0WLKn+VM
 Fo//zWO3+LHqC6vF1Emb2S3e7u1kt5j7ZBOTA7vHmnlrGD1eHVjF7nHn2h42j7N3djB6nNw2
 j9Vj47sdTAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4B
 um6ZOUDHKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkus
 DA0MjEyBChOyMx5838teMFO14tiU9ywNjE9luxg5OSQETCROzpvD1MXIxSEksINR4tGvnywQ
 zidGiR3H57OCVAkJfGOUOHdFBqaj4cBsdoiivYwSrR9eQ7W/Z5T4fWk5O0gVr4CdxOdnb5hA
 bBYBFYm3k/ZBxQUlTs58wgJiiwrIS9y/NQMsLgw0dcelHcwgg0QE7jNKTDpwlxkkwSwgIbHk
 0H1WCFtc4taT+WBD2QR0JLZ/Ow5mcwq4S7x8uosdokZeYvvbOWCDJATmckicaPnDCHG3i8T3
 SV9YIGxhiVfHt7BD2FISL/vb2CEamhklli45yArh9DBK/Gu4zgZRZSyxf+lkoHUcQCs0Jdbv
 0ofYxifx7msPK0hYQoBXoqNNCKJaReLS65dMMPPvPvnPCmF7SPTumQYN4FmMEtef3mKbwKgw
 CylkZiF5dBaSh2YhbF7AyLKKUSy1oDg3PbXYsMAEHuHJ+bmbGMFpVctiB+Pctx/0DjEycTAe
 YpTgYFYS4f3pzZkmxJuSWFmVWpQfX1Sak1p8iNEUGD8TmaVEk/OBiT2vJN7QxNLAxMzI2MTC
 0MxQSZz3zJWyVCGB9MSS1OzU1ILUIpg+Jg5OqQamylduLyoeCHU+3qslfav2980s56cJhT+2
 fZhnscQ5PPIiQ8zC88p1n31bBbzPpWqLMuqyzlzHtaw/IU4ruMeAVS7hlv17ltm59458eat6
 a1PlV49+0QblqoOsjqvKrhtcmvOjqIYti+FLoKW3bMzEq3UPSz7OuHY+5mZw6Mqvya/PfBDZ
 1f9yfXfoROPvnXumbui5XllfHHk5bkrkl1UNe3TSV97wOBezvUyI5cIMjXvGiQ0TJix7bbch
 27c/df2h5CvnF+sZbbXh3taydG9i/CpexiXmCsZyxWxtPwX6zKd9k58vL6P53dkl8/iRqfs6
 LtfO77LMvJ6x/aF+Un3Hmc6M385r3Esn/eWaPOG7EktxRqKhFnNRcSIArqrQ2jQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvO7mZTxpBsfbDC1WzPvJaDHlz3Im
 i8f/5rFb/Fj1hdVi6qTN7BZv93ayW8x9sonJgd1jzbw1jB6vDqxi97hzbQ+bx9k7Oxg9Tm6b
 x+qx8d0OpgC2KC6blNSczLLUIn27BK6MB9/3shfMVK04NuU9SwPjU9kuRk4OCQETiYYDs9m7
 GLk4hAR2M0rM6trKDpGQkvj8dCpbFyMHkC0scfhwMUTNW0aJ953nWUFqeAXsJD4/e8MEYrMI
 qEi8nbSPHSIuKHFy5hMWEFtUQF7i/q0ZYHFhoGU7Lu1gBhkkIvCQUeLs/rmMIAlmAQmJJYfu
 gw0VEnCTuDxlEytEXFzi1pP5YAvYBHQktn87DmZzCrhLvHy6ix3kOGYBdYn184QgyuUltr+d
 wzyBUWgWkjNmIZk0C6FjFpKOBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxguNH
 S3MH4/ZVH/QOMTJxMB5ilOBgVhLh/enNmSbEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQ
 QHpiSWp2ampBahFMlomDU6qByeaT0U+WFusZv7XLfs5m+dL2Xf/Lu72B7UmLZYxy95Y2rPL7
 ERpbYfNz0t6EUsHcnactJ1u2JDw56e/zyt5rbd6ywDXnT//rnGS21f0eW9qP2K/aNqV29m2Z
 c32XeTwW6DxZnfdrXt2Jilzm09d9Jk5/c3xxi1Ja40SrqYcOGbwzUnv+TG9vFevuru2K2yea
 HKpwOJFj9fHt2atJ107s8F4iM69UZGkil//x5UWPP2cV73FJurdhz5ZV7kLzrup8Zq+XOGa9
 2+BbiebLlW9N9E98s2NL/d/a3TuVddWNDc8nNRx4ktv4k2/qg3ZX6cOzGN59a09pCjBKOrk/
 olP9rdD3k+FSK+X5P/pKLtnzR0+JpTgj0VCLuag4EQCMIISgDgMAAA==
X-CMS-MailID: 20240403004539epcas1p22a414027e51daffba353e16bfca94e96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403004539epcas1p22a414027e51daffba353e16bfca94e96
References: <20240208-uboot-vexpress-ca9-v1-1-ad7bc1f2f433@linaro.org>
 <CGME20240403004539epcas1p22a414027e51daffba353e16bfca94e96@epcas1p2.samsung.com>
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

On 2/8/24 18:33, Linus Walleij wrote:
> The PL180/MMCI driver is implied to use CONFIG_DM and the ARM
> defconfigs such as configs/vexpress_ca9x4_defconfig will get it
> as well.
> 
> With a simple oneline to default to not being the v2 variant,
> the original ARM MMCI variant works fine with the driver as well.
> The IP version actually needs to be read out from a register on
> the ARM versions, but we will simply assume we are running on the
> original hardware if arm,primecell-periphid is not explicitly
> specified in the device tree.
> 
> Drop the !CONFIG_DM code and depend on DM_MMC.
> 
> Tested on the Versatile Express CA9x4 board.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Sorry for late. I will apply this patch to u-boot-mmc/master. Thanks.

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/Kconfig          |  1 +
>  drivers/mmc/arm_pl180_mmci.c | 66 ++------------------------------------------
>  2 files changed, 3 insertions(+), 64 deletions(-)
> 
> 
> ---
> base-commit: 0101a2ffe125911ebf89172b495f5ff14f2fd058
> change-id: 20240208-uboot-vexpress-ca9-127bd6b163df
> 
> Best regards,
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 17618c3bdcc1..59716c3966e5 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -79,6 +79,7 @@ config MMC_SPI_CRC_ON
>  
>  config ARM_PL180_MMCI
>  	bool "ARM AMBA Multimedia Card Interface and compatible support"
> +	depends on DM_MMC
>  	help
>  	  This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
>  	  Interface (PL180, PL181 and compatible) support.
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index 5cf5502ed545..2666b65362bc 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -18,6 +18,7 @@
>  #include <malloc.h>
>  #include <mmc.h>
>  #include <dm/device_compat.h>
> +#include <dm.h>
>  
>  #include <asm/io.h>
>  #include <asm-generic/gpio.h>
> @@ -25,8 +26,6 @@
>  #include "arm_pl180_mmci.h"
>  #include <linux/delay.h>
>  
> -#ifdef CONFIG_DM_MMC
> -#include <dm.h>
>  #define MMC_CLOCK_MAX	48000000
>  #define MMC_CLOCK_MIN	400000
>  
> @@ -34,7 +33,6 @@ struct arm_pl180_mmc_plat {
>  	struct mmc_config cfg;
>  	struct mmc mmc;
>  };
> -#endif
>  
>  static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
>  {
> @@ -358,65 +356,6 @@ static int  host_set_ios(struct mmc *dev)
>  	return 0;
>  }
>  
> -#ifndef CONFIG_DM_MMC
> -/* MMC uses open drain drivers in the enumeration phase */
> -static int mmc_host_reset(struct mmc *dev)
> -{
> -	struct pl180_mmc_host *host = dev->priv;
> -
> -	writel(host->pwr_init, &host->base->power);
> -
> -	return 0;
> -}
> -
> -static const struct mmc_ops arm_pl180_mmci_ops = {
> -	.send_cmd = host_request,
> -	.set_ios = host_set_ios,
> -	.init = mmc_host_reset,
> -};
> -
> -/*
> - * mmc_host_init - initialize the mmc controller.
> - * Set initial clock and power for mmc slot.
> - * Initialize mmc struct and register with mmc framework.
> - */
> -
> -int arm_pl180_mmci_init(struct pl180_mmc_host *host, struct mmc **mmc)
> -{
> -	u32 sdi_u32;
> -
> -	writel(host->pwr_init, &host->base->power);
> -	writel(host->clkdiv_init, &host->base->clock);
> -	udelay(CLK_CHANGE_DELAY);
> -
> -	/* Disable mmc interrupts */
> -	sdi_u32 = readl(&host->base->mask0) & ~SDI_MASK0_MASK;
> -	writel(sdi_u32, &host->base->mask0);
> -
> -	host->cfg.name = host->name;
> -	host->cfg.ops = &arm_pl180_mmci_ops;
> -
> -	/* TODO remove the duplicates */
> -	host->cfg.host_caps = host->caps;
> -	host->cfg.voltages = host->voltages;
> -	host->cfg.f_min = host->clock_min;
> -	host->cfg.f_max = host->clock_max;
> -	if (host->b_max != 0)
> -		host->cfg.b_max = host->b_max;
> -	else
> -		host->cfg.b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
> -
> -	*mmc = mmc_create(&host->cfg, host);
> -	if (!*mmc)
> -		return -1;
> -	debug("registered mmc interface number is:%d\n",
> -	      (*mmc)->block_dev.devnum);
> -
> -	return 0;
> -}
> -#endif
> -
> -#ifdef CONFIG_DM_MMC
>  static void arm_pl180_mmc_init(struct pl180_mmc_host *host)
>  {
>  	u32 sdi_u32;
> @@ -477,7 +416,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
>  		host->version2 = true;
>  		break;
>  	default:
> -		host->version2 = true;
> +		host->version2 = false; /* ARM variant */
>  	}
>  
>  	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
> @@ -561,4 +500,3 @@ U_BOOT_DRIVER(arm_pl180_mmc) = {
>  	.priv_auto	= sizeof(struct pl180_mmc_host),
>  	.plat_auto	= sizeof(struct arm_pl180_mmc_plat),
>  };
> -#endif

