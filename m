Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A98FE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70EBB86D20;
	Wed, 27 Sep 2023 04:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iiJnTT5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC97486D20; Wed, 27 Sep 2023 04:45:32 +0200 (CEST)
Received: from mail-m12765.qiye.163.com (mail-m12765.qiye.163.com
 [115.236.127.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D08805CA
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iiJnTT5IBcP7iJREbCByc5rvOIX147VXpV1ywak5etuRcObc9hCoJE+ahCEacToa7zK3U8G+8cGaiDKlNT6q7QQbbeTekzL4EjX5cd0iUZRkUGgOdDQ9SGCSuTPAr1tLVV+nX9UpxTMt4PduLsPUToKrSCmZkmdX6Lf17bM6xZo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Y7iQRfpN8wRr5SX4w9MDTKJ/2Tc/hQ56iGpdjcKIZ/E=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id E3A0E40018D;
 Wed, 27 Sep 2023 10:45:25 +0800 (CST)
Message-ID: <3674a8c4-c1eb-a223-fcad-be982446e8e3@rock-chips.com>
Date: Wed, 27 Sep 2023 10:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/7] pci: pcie_dw_rockchip: Configure number of lanes
 and link width speed
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwYH1ZMSk9LTx8aSE0dSEtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad486ea442eb3kusne3a0e40018d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6Ahw6MDw2OjYtPAM6PjQ5
 E0MwCQ9VSlVKTUJOTENJTElNTEJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNT0lNNwY+
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


On 2023/8/3 03:04, Jonas Karlman wrote:
> Set number of lanes and link width speed control register based on the
> num-lanes property.
>
> Code imported almost 1:1 from dw_pcie_setup in mainline linux.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   drivers/pci/pcie_dw_rockchip.c | 58 +++++++++++++++++++++++++++++-----
>   1 file changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
> index 1a35fae5c3a8..bc4635f67136 100644
> --- a/drivers/pci/pcie_dw_rockchip.c
> +++ b/drivers/pci/pcie_dw_rockchip.c
> @@ -18,6 +18,7 @@
>   #include <asm/io.h>
>   #include <asm-generic/gpio.h>
>   #include <dm/device_compat.h>
> +#include <linux/bitfield.h>
>   #include <linux/iopoll.h>
>   #include <linux/delay.h>
>   #include <power/regulator.h>
> @@ -43,6 +44,7 @@ struct rk_pcie {
>   	struct reset_ctl_bulk	rsts;
>   	struct gpio_desc	rst_gpio;
>   	u32		gen;
> +	u32		num_lanes;
>   };
>   
>   /* Parameters for the waiting for iATU enabled routine */
> @@ -152,12 +154,13 @@ static inline void rk_pcie_writel_apb(struct rk_pcie *rk_pcie, u32 reg,
>    * rk_pcie_configure() - Configure link capabilities and speed
>    *
>    * @rk_pcie: Pointer to the PCI controller state
> - * @cap_speed: The capabilities and speed to configure
>    *
>    * Configure the link capabilities and speed in the PCIe root complex.
>    */
> -static void rk_pcie_configure(struct rk_pcie *pci, u32 cap_speed)
> +static void rk_pcie_configure(struct rk_pcie *pci)
>   {
> +	u32 val;
> +
>   	dw_pcie_dbi_write_enable(&pci->dw, true);
>   
>   	/* Disable BAR 0 and BAR 1 */
> @@ -167,11 +170,49 @@ static void rk_pcie_configure(struct rk_pcie *pci, u32 cap_speed)
>   	       PCI_BASE_ADDRESS_1);
>   
>   	clrsetbits_le32(pci->dw.dbi_base + PCIE_LINK_CAPABILITY,
> -			TARGET_LINK_SPEED_MASK, cap_speed);
> +			TARGET_LINK_SPEED_MASK, pci->gen);
>   
>   	clrsetbits_le32(pci->dw.dbi_base + PCIE_LINK_CTL_2,
> -			TARGET_LINK_SPEED_MASK, cap_speed);
> +			TARGET_LINK_SPEED_MASK, pci->gen);
> +
> +	/* Set the number of lanes */
> +	val = readl(pci->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
> +	val &= ~PORT_LINK_FAST_LINK_MODE;
> +	val |= PORT_LINK_DLL_LINK_EN;
> +	val &= ~PORT_LINK_MODE_MASK;
> +	switch (pci->num_lanes) {
> +	case 1:
> +		val |= PORT_LINK_MODE_1_LANES;
> +		break;
> +	case 2:
> +		val |= PORT_LINK_MODE_2_LANES;
> +		break;
> +	case 4:
> +		val |= PORT_LINK_MODE_4_LANES;
> +		break;
> +	default:
> +		dev_err(pci->dw.dev, "num-lanes %u: invalid value\n", pci->num_lanes);
> +		goto out;
> +	}
> +	writel(val, pci->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
> +
> +	/* Set link width speed control register */
> +	val = readl(pci->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> +	switch (pci->num_lanes) {
> +	case 1:
> +		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> +		break;
> +	case 2:
> +		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> +		break;
> +	case 4:
> +		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> +		break;
> +	}
> +	writel(val, pci->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
>   
> +out:
>   	dw_pcie_dbi_write_enable(&pci->dw, false);
>   }
>   
> @@ -231,11 +272,10 @@ static int is_link_up(struct rk_pcie *priv)
>    * rk_pcie_link_up() - Wait for the link to come up
>    *
>    * @rk_pcie: Pointer to the PCI controller state
> - * @cap_speed: Desired link speed
>    *
>    * Return: 1 (true) for active line and negetive (false) for no link (timeout)
>    */
> -static int rk_pcie_link_up(struct rk_pcie *priv, u32 cap_speed)
> +static int rk_pcie_link_up(struct rk_pcie *priv)
>   {
>   	int retries;
>   
> @@ -245,7 +285,7 @@ static int rk_pcie_link_up(struct rk_pcie *priv, u32 cap_speed)
>   	}
>   
>   	/* DW pre link configurations */
> -	rk_pcie_configure(priv, cap_speed);
> +	rk_pcie_configure(priv);
>   
>   	rk_pcie_disable_ltssm(priv);
>   	rk_pcie_link_status_clear(priv);
> @@ -341,7 +381,7 @@ static int rockchip_pcie_init_port(struct udevice *dev)
>   	rk_pcie_writel_apb(priv, 0x0, 0xf00040);
>   	pcie_dw_setup_host(&priv->dw);
>   
> -	ret = rk_pcie_link_up(priv, priv->gen);
> +	ret = rk_pcie_link_up(priv);
>   	if (ret < 0)
>   		goto err_link_up;
>   
> @@ -419,6 +459,8 @@ static int rockchip_pcie_parse_dt(struct udevice *dev)
>   	priv->gen = dev_read_u32_default(dev, "max-link-speed",
>   					 LINK_SPEED_GEN_3);
>   
> +	priv->num_lanes = dev_read_u32_default(dev, "num-lanes", 1);
> +
>   	return 0;
>   
>   rockchip_pcie_parse_dt_err_phy_get_by_index:
