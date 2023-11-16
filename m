Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FA4C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 23:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CD886E64;
	Fri, 17 Nov 2023 00:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B6886E64; Fri, 17 Nov 2023 00:24:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E72FB86F7C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 00:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EEE41595;
 Thu, 16 Nov 2023 15:24:36 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8783F6C4;
 Thu, 16 Nov 2023 15:23:49 -0800 (PST)
Date: Thu, 16 Nov 2023 23:22:29 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Nils Le Roux <gilbsgilbert@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: designware: Support high memory nodes
Message-ID: <20231116232229.084127c9@slackpad.lan>
In-Reply-To: <20231111152619.95185-1-gilbsgilbert@gmail.com>
References: <20231111152619.95185-1-gilbsgilbert@gmail.com>
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

On Sat, 11 Nov 2023 16:26:14 +0100
Nils Le Roux <gilbsgilbert@gmail.com> wrote:

Hi Nils,

> Some platforms (such as the Lichee Pi 4A) have their dwmac device
> addressable only in high memory space. Storing the node's base address
> on 32 bits is not possible in such case.

That's indeed true, so thanks for the patch.
Some comments below.

> Use platform's physical address type to store the base address.
> 
> Signed-off-by: Nils Le Roux <gilbsgilbert@gmail.com>
> ---
> 
>  drivers/net/designware.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index a174344b3e..327732fbf7 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -678,8 +678,8 @@ int designware_eth_probe(struct udevice *dev)
>  {
>  	struct eth_pdata *pdata = dev_get_plat(dev);
>  	struct dw_eth_dev *priv = dev_get_priv(dev);
> -	u32 iobase = pdata->iobase;
> -	ulong ioaddr;
> +	phys_addr_t iobase = pdata->iobase;
> +	phys_addr_t ioaddr;

So I agree that iobase should be a phys_addr_t, since pdata->iobase is
of this type, but ioaddr seems to be a virtual address, not a physical
one. So either we make this a void*, or keep it at ulong.

>  	int ret, err;
>  	struct reset_ctl_bulk reset_bulk;
>  #ifdef CONFIG_CLK
> @@ -740,7 +740,7 @@ int designware_eth_probe(struct udevice *dev)
>  	 * or via a PCI bridge, fill in plat before we probe the hardware.
>  	 */
>  	if (IS_ENABLED(CONFIG_PCI) && device_is_on_pci_bus(dev)) {
> -		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &iobase);
> +		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, (u32 *)&iobase);

This looks sketchy, relies on little endian, and assumes that iobase
has been initialised to 0 before. Since the read is explicitly 32 bits
wide, I'd declare a new local u32 variable (inside this if-statement)
and read it into there, then assign this to iobase.

>  		iobase &= PCI_BASE_ADDRESS_MEM_MASK;
>  		iobase = dm_pci_mem_to_phys(dev, iobase);
>  
> @@ -748,7 +748,7 @@ int designware_eth_probe(struct udevice *dev)
>  		pdata->phy_interface = PHY_INTERFACE_MODE_RMII;
>  	}
>  
> -	debug("%s, iobase=%x, priv=%p\n", __func__, iobase, priv);
> +	debug("%s, iobase=%llx, priv=%p\n", __func__, (u64)iobase, priv);

This assumes that u64 is always %llx, which is not universally true.
Fortunately we have %pa for that (see doc/develop/printf.rst), so you
can just use this and drop the cast.

Cheers,
Andre

>  	ioaddr = iobase;
>  	priv->mac_regs_p = (struct eth_mac_regs *)ioaddr;
>  	priv->dma_regs_p = (struct eth_dma_regs *)(ioaddr + DW_DMA_BASE_OFFSET);

