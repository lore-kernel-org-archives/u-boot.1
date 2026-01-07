Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE38CF6C00
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 08:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039BC83B5E;
	Wed,  7 Jan 2026 09:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nurT9r6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7125683B64; Wed,  7 Jan 2026 09:20:34 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5843383B4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 09:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dmLZQ38gRz9tgJ;
 Wed,  7 Jan 2026 09:20:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767774030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=td25tqROpK8F5KnwCut/noFT+iTD26+xGBCMgXSzFiQ=;
 b=nurT9r6HgWFbSDXtMHSydnbZQ56PSHr4iuJYksVjD0lT45Fdp8NjGm16s10DumJnunVr5V
 GeBOu3XbJiAQbDlluLmpgawva7LBvrdsc6hfQmPNMsG0F1fG3OE4sYVRcbgcxjrCbXx+Tk
 dNGwk6gruz+hAsuvskQ6MtRn15/GBM5Iw1Z0sEacJGoVySsilhV250Gyl6J9R2+5Bw97/e
 nye7O1EvK0Bi/EJ1/LUJJ3dhxJ3YCVtVpH/uvNXfrDck227jB3/3WqB4H4qyVcVt/DcJp+
 ZZQrol0VepTVWmqx943Qdwct6ZdgvrZcX9HbDBBaxdTH2kgziky5vI+uxwAhdg==
Message-ID: <4290b4ca-7cf2-4141-a804-fc6f53a8d2bf@mailbox.org>
Date: Wed, 7 Jan 2026 09:20:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: xilinx-nwl: Avoid crashing if configuring when the
 link is down
To: Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <20260106220853.731358-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260106220853.731358-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 125f9f9f5996804b25b
X-MBO-RS-META: 8a74o6ohbmf3m774zds57p6tuqrebidp
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

Hi Sean,

On 1/6/26 23:08, Sean Anderson wrote:
> The ECAM will return a slave error if we access non-root devices while
> the link is down. Add a check for this like Linux does so we don't
> crash.
> 
> Fixes: 2f5ad77cfea ("PCI: zynqmp: Add ZynqMP NWL PCIe root port driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
> 
>   drivers/pci/pcie-xilinx-nwl.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie-xilinx-nwl.c b/drivers/pci/pcie-xilinx-nwl.c
> index e03ab3be912..ab597c83e47 100644
> --- a/drivers/pci/pcie-xilinx-nwl.c
> +++ b/drivers/pci/pcie-xilinx-nwl.c
> @@ -135,6 +135,13 @@ struct nwl_pcie {
>   	u32 ecam_value;
>   };
>   
> +static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
> +{
> +	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
> +		return true;
> +	return false;
> +}
> +
>   static int nwl_pcie_config_address(const struct udevice *bus,
>   				   pci_dev_t bdf, uint offset,
>   				   void **paddress)
> @@ -142,6 +149,9 @@ static int nwl_pcie_config_address(const struct udevice *bus,
>   	struct nwl_pcie *pcie = dev_get_priv(bus);
>   	void *addr;
>   
> +	if (PCI_BUS(bdf) != dev_seq(bus) && !nwl_pcie_link_up(pcie))
> +		return -EIO;
> +
>   	addr = pcie->ecam_base;
>   	addr += PCIE_ECAM_OFFSET(PCI_BUS(bdf) - dev_seq(bus),
>   				 PCI_DEV(bdf), PCI_FUNC(bdf), offset);
> @@ -181,13 +191,6 @@ static inline void nwl_bridge_writel(struct nwl_pcie *pcie, u32 val, u32 off)
>   	writel(val, pcie->breg_base + off);
>   }
>   
> -static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
> -{
> -	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
> -		return true;
> -	return false;
> -}
> -
>   static bool nwl_phy_link_up(struct nwl_pcie *pcie)
>   {
>   	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PHY_RDY_LINKUP_BIT)

