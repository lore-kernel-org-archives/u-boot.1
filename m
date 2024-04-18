Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90D0C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF4088553;
	Thu, 18 Apr 2024 05:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713409498;
	bh=8rhaBNavASX6RhwVkYCNzs7doKIATBSg8oGnAFmVPpQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzATxaIuUL7vcykmT2+shL6gaw7tfu5jn+SUTbeP/3JdL0ir1f7cfa3vMlAu6mhrR
	 TZP3SuF/clJs6oDv9x1L3uzjrFqK3lkEMaVgc6DoWz+hr/acn29mPAv0MVndRoLqc4
	 UevRxXfaTSxR8lOLKj2T3/FwvZRHVT/mg4+v1cFBsDaNTAe7Yl6BN/WgTPfYbGEjZo
	 CrmBffjyPU7yyute4kgMB+lr83nzJy6LubFmVE83crQFbvrPYTK7Rk6siM8vPrE0mk
	 npl9ccHN7l30qkP43sUfwwhXhF4at6wZ6d+SPDGiVE7s0NrceUsgNxLvNzd49OKjoI
	 R+eoxHMtYHsuA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 696DB884E9;
 Thu, 18 Apr 2024 05:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713409496;
 bh=8rhaBNavASX6RhwVkYCNzs7doKIATBSg8oGnAFmVPpQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=OawqI3DuubpKAq5xfSH7PoUTC9HCF3QBQqzPXNC+yG2S8OaNGL6EWjrgGXIJ4/RGl
 j0aSrlHe2v3/mKbixWUBpVLJoDWP6zrhAMQnrgRdWikmXc4glpgO4/hVT2daBeOStc
 5T31VGvUWv7dGoClAcP6PrBF/ZvxWRqgw65fRsOvTbaBiWyQlEJ7Av6HjWlwVKYdkz
 uMJ1A2rtD1KZxmQYvj4scIhprTbW1xnBYFGPAJm2PkBjvktMNdt1B6ZwF3ISpw32Ku
 GJ7kgUhn+PZdTiDbHBPl41DpYFkqVUTE1c8vp8Ps7Zv4UPGJztvi99j0XZT1LlqHqw
 lW8PFShzCXR4A==
Message-ID: <121f8e1c-4ca1-4a7b-acff-364fa64f2a6a@denx.de>
Date: Thu, 18 Apr 2024 03:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pci: dw_imx: add support for IMX8MM
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Fabio Estevam <festevam@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240417200922.3749671-1-tharvey@gateworks.com>
 <20240417200922.3749671-2-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240417200922.3749671-2-tharvey@gateworks.com>
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

On 4/17/24 10:09 PM, Tim Harvey wrote:
> Add support for the IMX8MM SoC by adding driver data with the compatible
> string of the GPR controller.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   drivers/pci/pcie_dw_imx.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> index a2ee228224b5..10d926c30645 100644
> --- a/drivers/pci/pcie_dw_imx.c
> +++ b/drivers/pci/pcie_dw_imx.c
> @@ -45,6 +45,10 @@
>   #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
>   #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE		BIT(11)
>   
> +struct pcie_chip_info {
> +	const char *gpr;
> +};
> +
>   struct pcie_dw_imx {
>   	/* Must be first member of the struct */
>   	struct pcie_dw			dw;
> @@ -54,6 +58,15 @@ struct pcie_dw_imx {
>   	struct reset_ctl		apps_reset;
>   	struct phy			phy;
>   	struct udevice			*vpcie;
> +	struct pcie_chip_info		*info;
> +};
> +
> +static const struct pcie_chip_info imx8mm_chip_info = {
> +	.gpr = "fsl,imx8mm-iomuxc-gpr",
> +};
> +
> +static const struct pcie_chip_info imx8mp_chip_info = {
> +	.gpr = "fsl,imx8mp-iomuxc-gpr",
>   };
>   
>   static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
> @@ -246,6 +259,8 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
>   	ofnode gpr;
>   	int ret;
>   
> +	priv->info = (void *)dev_get_driver_data(dev);
> +

Does this really have to be cached in priv ?

The priv->info seems used only in this function.

[...]
