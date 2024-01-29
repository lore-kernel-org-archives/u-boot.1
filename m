Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D534C47258
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 00:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B9887B6B;
	Mon, 29 Jan 2024 01:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73DE487B7C; Mon, 29 Jan 2024 01:21:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2CABC879E0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 01:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E805E1FB;
 Sun, 28 Jan 2024 16:21:41 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38EEC3F5A1;
 Sun, 28 Jan 2024 16:20:57 -0800 (PST)
Date: Mon, 29 Jan 2024 00:20:01 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>, Sam Edwards
 <CFSworks@gmail.com>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] net: sun8i-emac: Add support for fixed-link phy
Message-ID: <20240129002001.5197aeeb@minigeek.lan>
In-Reply-To: <20240120162625.2413494-1-bigunclemax@gmail.com>
References: <20240120162625.2413494-1-bigunclemax@gmail.com>
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

On Sat, 20 Jan 2024 19:26:24 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> Make the "phy-handle" property optional, which allows support
> for a fixed-link phy configuration.
> 
> Thus if the "phy-handle" is present in a DT, then driver will work as
> before. Otherwise, phyaddr initialization will not be necessary,
> as it is not needed in case of a fixed-link config.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Thanks, looks good now:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Queued for the first PR.

Cheers,
Andre


> ---
>  drivers/net/sun8i_emac.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index a12f7e32e8..8bff4fe9a9 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -833,11 +833,8 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
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

