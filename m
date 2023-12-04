Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25C7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 01:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A098789A;
	Mon,  4 Dec 2023 02:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A081D8789F; Mon,  4 Dec 2023 02:10:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 668DD875B6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 02:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87FB152B;
 Sun,  3 Dec 2023 17:11:30 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F2AE3F6C4;
 Sun,  3 Dec 2023 17:10:43 -0800 (PST)
Date: Mon, 4 Dec 2023 01:09:30 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Nils Le Roux <gilbsgilbert@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2] net: designware: Support high memory nodes
Message-ID: <20231204010930.071a5ba7@slackpad.lan>
In-Reply-To: <20231202093952.33256-1-gilbsgilbert@gmail.com>
References: <20231202093952.33256-1-gilbsgilbert@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat,  2 Dec 2023 10:39:49 +0100
Nils Le Roux <gilbsgilbert@gmail.com> wrote:

Hi Nils,

> Some platforms (such as the Lichee Pi 4A) have their dwmac device
> addressable only in high memory space. Storing the node's base address
> on 32 bits is not possible in such case.
> 
> Use platform's physical address type to store the base address.
> 
> Signed-off-by: Nils Le Roux <gilbsgilbert@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>

many thanks for the changes, that looks good to me now. I have
compile-tested that for arm64 and arm.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> Changes in v2:
> - explicitly define and handle ioaddr as a virtual address
> - use an intermediate variable to assign the PCI base address
> - use appropriate placeholder to print physical addresses
> ---
>  drivers/net/designware.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index a174344b3e..78bfce07f6 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -678,8 +678,8 @@ int designware_eth_probe(struct udevice *dev)
>  {
>  	struct eth_pdata *pdata = dev_get_plat(dev);
>  	struct dw_eth_dev *priv = dev_get_priv(dev);
> -	u32 iobase = pdata->iobase;
> -	ulong ioaddr;
> +	phys_addr_t iobase = pdata->iobase;
> +	void *ioaddr;
>  	int ret, err;
>  	struct reset_ctl_bulk reset_bulk;
>  #ifdef CONFIG_CLK
> @@ -740,16 +740,18 @@ int designware_eth_probe(struct udevice *dev)
>  	 * or via a PCI bridge, fill in plat before we probe the hardware.
>  	 */
>  	if (IS_ENABLED(CONFIG_PCI) && device_is_on_pci_bus(dev)) {
> -		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &iobase);
> -		iobase &= PCI_BASE_ADDRESS_MEM_MASK;
> -		iobase = dm_pci_mem_to_phys(dev, iobase);
> +		u32 pcibase;
>  
> +		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &pcibase);
> +		pcibase &= PCI_BASE_ADDRESS_MEM_MASK;
> +
> +		iobase = dm_pci_mem_to_phys(dev, pcibase);
>  		pdata->iobase = iobase;
>  		pdata->phy_interface = PHY_INTERFACE_MODE_RMII;
>  	}
>  
> -	debug("%s, iobase=%x, priv=%p\n", __func__, iobase, priv);
> -	ioaddr = iobase;
> +	debug("%s, iobase=%pa, priv=%p\n", __func__, &iobase, priv);
> +	ioaddr = phys_to_virt(iobase);
>  	priv->mac_regs_p = (struct eth_mac_regs *)ioaddr;
>  	priv->dma_regs_p = (struct eth_dma_regs *)(ioaddr + DW_DMA_BASE_OFFSET);
>  	priv->interface = pdata->phy_interface;

