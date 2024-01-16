Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691D2C4707B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 00:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4114E870D2;
	Tue, 16 Jan 2024 01:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6C48701D; Tue, 16 Jan 2024 01:18:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6E181870DF
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 01:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD282F4;
 Mon, 15 Jan 2024 16:19:05 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B053F5A1;
 Mon, 15 Jan 2024 16:18:17 -0800 (PST)
Date: Tue, 16 Jan 2024 00:17:35 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v1] net: sun8i-emac: Add support for fixed-link phy
Message-ID: <20240116001735.7c48ea88@minigeek.lan>
In-Reply-To: <20230614214405.1038301-1-bigunclemax@gmail.com>
References: <20230614214405.1038301-1-bigunclemax@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Thu, 15 Jun 2023 00:44:06 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maxim,

> From: Maksim Kiselev <bigunclemax@gmail.com>
> 
> Based on dt-specs fixed-link doesn't require phy-handle to be used.

Do you have such a board? And where is that written down? I don't see
it explicitly mentioned as optional in ethernet-controller.yaml or in
the DT spec PDF. The sun8i EMAC binding lists phy-handle as required,
so that would need to be relaxed there then.

> Fix driver to only read phy related setting when phy-handle is found.

The patch itself looks fine, we already specify -1 as the default when
the PHY DT node does not contain a reg property, so that looks like it
would work.

Cheers,
Andre

> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/net/sun8i_emac.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 04c3274fbe..0e339d69e0 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -834,11 +834,8 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
>  	priv->use_internal_phy = false;
>  
>  	offset = fdtdec_lookup_phandle(gd->fdt_blob, node, "phy-handle");
> -	if (offset < 0) {
> -		debug("%s: Cannot find PHY address\n", __func__);
> -		return -EINVAL;
> -	}
> -	priv->phyaddr = fdtdec_get_int(gd->fdt_blob, offset, "reg", -1);
> +	if (offset >= 0)
> +		priv->phyaddr = fdtdec_get_int(gd->fdt_blob, offset, "reg", -1);
>  
>  	pdata->phy_interface = dev_read_phy_mode(dev);
>  	debug("phy interface %d\n", pdata->phy_interface);

