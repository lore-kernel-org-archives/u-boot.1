Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D3C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 05:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D358861E;
	Sun, 30 Jun 2024 07:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719725976;
	bh=3W0ivFgcso3E4lKlf2MgzeqloQgQdeUtBtoa6EAVwxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qr11zUhhXPmoGkpJ7jdBSv6QVwO490u/cFMo1YTDydFjraO2cpL4aXPfBaGrVJ6FS
	 hZ+IrkBm3w+stC2BWLsMlzvgyUJEM3U4OClO80XGaD0Gc9F8FrZACDQiBLvj9H7lbA
	 +r4/HBGSW8i9UUPRkLIsYx32nZDfe+KNKq8IleyhI3GtISNb0hMAleE5jcdEhwrxUu
	 AehEuVwlXLrDyvAwybXNjDaXVgdIwJVoB//kC3YC9g2uWxc5U4q+p1Lpgd3186YjU6
	 rM/07d44SC1Ai352G2RsDJpKsBxkD264HyEoJItdmxOvjT/+OfJ+dgEF+UKVLJdyQL
	 t6ULZ1dlLxjYg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CCDBB87FC7;
 Sun, 30 Jun 2024 07:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719725974;
 bh=3W0ivFgcso3E4lKlf2MgzeqloQgQdeUtBtoa6EAVwxk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n5eoxCOaC0M9xJi/TH9Wibdb2JyB79sRVG18yLYcyItFgl4kH5Ns1WWN7n18V6YYP
 yVF5hphagcU4vqXjhWwLDKtKw0c79PNXRP8ypaCdnxrBa55ScFLx2ODrjn+C1bnVH5
 psP6+mQID2pTkxMEUZTdDi3Jeb2CMXSWh3iPet807ayKY5tOveelmf0tA21DjFksKs
 dzImiykn9zmAMSLcAK3R2OkEs2Lu2SQfKDqdPjv07KxOuGOusvHzUuq3DVQuVmQhV3
 vxG5H+EGCQi5zPnXkPK9sEwWCv8qVtxquZ4ValdScIm7Wm9+DhI0gL0mcM8jMvia/U
 cfNKimrpL40Qg==
Message-ID: <94f5509d-2a99-49cb-96b4-f405a6143ee7@denx.de>
Date: Sun, 30 Jun 2024 07:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 3/5] net: dwc_eth_qos: Adapt probe() for PCI
 devices
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com,
 philipp.tomsich@vrull.eu, rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 xypron.glpk@gmx.de
References: <20240624083450.90297-1-pro@denx.de>
 <20240624083450.90297-4-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240624083450.90297-4-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/24/24 10:34 AM, Philip Oberfichtner wrote:
> PCI devices do not necessarily use a device tree. In that case, the
> driver currently fails to find eqos->config and eqos->regs.
> 
> This commit factors out the respective functionality. Device tree usage
> remains default, but board specific implementations will be possible as
> well.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   drivers/net/dwc_eth_qos.c          | 28 +++++++++++++++++++++++++---
>   drivers/net/dwc_eth_qos.h          |  3 +++
>   drivers/net/dwc_eth_qos_imx.c      |  1 +
>   drivers/net/dwc_eth_qos_qcom.c     |  1 +
>   drivers/net/dwc_eth_qos_rockchip.c |  1 +
>   drivers/net/dwc_eth_qos_starfive.c |  1 +
>   drivers/net/dwc_eth_qos_stm32.c    |  1 +
>   7 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index b87634f1f5..34e29301cc 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1376,6 +1376,21 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
>   	return 0;
>   }
>   
> +/*
> + * Get driver data based on the device tree. Boards not using a device tree can
> + * overwrite this function.
> + */
> +__weak void *eqos_get_driver_data(struct udevice *dev)
> +{
> +	return (void *)dev_get_driver_data(dev);
> +}
> +
> +/* Function to get base address, useable for all boards having a device tree. */
> +fdt_addr_t eqos_get_base_addr_dt(struct udevice *dev)
> +{
> +	return dev_read_addr(dev);
> +}
> +
>   static int eqos_probe(struct udevice *dev)
>   {
>   	struct eqos_priv *eqos = dev_get_priv(dev);
> @@ -1384,13 +1399,19 @@ static int eqos_probe(struct udevice *dev)
>   	debug("%s(dev=%p):\n", __func__, dev);
>   
>   	eqos->dev = dev;
> -	eqos->config = (void *)dev_get_driver_data(dev);
>   
> -	eqos->regs = dev_read_addr(dev);
> +	eqos->config = eqos_get_driver_data(dev);
> +	if (!eqos->config) {
> +		pr_err("Failed to get driver data.\n");
> +		return -ENODEV;
> +	}
> +
> +	eqos->regs = eqos->config->ops->eqos_get_base_addr(dev);
>   	if (eqos->regs == FDT_ADDR_T_NONE) {
> -		pr_err("dev_read_addr() failed\n");
> +		pr_err("Failed to get device address.\n");
>   		return -ENODEV;
>   	}
> +
>   	eqos->mac_regs = (void *)(eqos->regs + EQOS_MAC_REGS_BASE);
>   	eqos->mtl_regs = (void *)(eqos->regs + EQOS_MTL_REGS_BASE);
>   	eqos->dma_regs = (void *)(eqos->regs + EQOS_DMA_REGS_BASE);

Could you factor out the entirety of:

          eqos->regs = dev_read_addr(dev);
          if (eqos->regs == FDT_ADDR_T_NONE) {
                  pr_err("dev_read_addr() failed\n");
                  return -ENODEV;
          }
          eqos->mac_regs = (void *)(eqos->regs + EQOS_MAC_REGS_BASE);
          eqos->mtl_regs = (void *)(eqos->regs + EQOS_MTL_REGS_BASE);
          eqos->dma_regs = (void *)(eqos->regs + EQOS_DMA_REGS_BASE);
          eqos->tegra186_regs = (void *)(eqos->regs + 
EQOS_TEGRA186_REGS_BASE);

into some common function, like eqos_get_base_addr_dt() , and call it 
from .eqos_probe_resources callback instead ? That way you wouldn't have 
to add new callback specifically for register address.
