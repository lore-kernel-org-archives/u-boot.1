Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF0CD6E44
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E50683FB0;
	Wed, 27 May 2026 14:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RBeEzJXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E773844CF; Wed, 27 May 2026 14:30:58 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672508341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gQTVk4ynWz9tkV;
 Wed, 27 May 2026 14:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779885054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sop72uevGj6asI61q+b6HvxGs95UHy0dT48IA561Eu4=;
 b=RBeEzJXG4TPh29ptxDxvf5mtGktVph9M08tqTwTsM/xp6NYzpVwXUEadAaeGjh8J4GQWjO
 A5rkjJoyFz5vhfVHiyzsdmaTprUW7vPFg7nLp0YoqM565nahX5J/R8RFLg7TkxZZVbcB2P
 8Ohs9mUtvVXWjxFdy083jmc3yf1fpinAg+HGGM5QNFisBDZoP11KjELWUlJ8u0uu127Zkc
 zAw6QGfsif7Gci9e79J/6FL4XoB8udDI+Th0cdigZY+DEno3js0h/U+kmTN/xzaLJjX5GX
 bvhBFh2uvRSc5V+qawelOkcNA3NEIKR5PDBWegy+jJ0daWt0xMoOxOCEDwhJ5w==
Message-ID: <6f24a280-2eed-40d4-bf65-0c681ec8a35f@mailbox.org>
Date: Wed, 27 May 2026 14:30:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mmc: xenon_sdhci: Use livetree API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Hiago De Franco <hfranco@baylibre.com>, Peng Fan <peng.fan@nxp.com>
References: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
 <20260525-devfdt-mmc-v1-1-018e94f1c87a@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-mmc-v1-1-018e94f1c87a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0dcd225e8d0985dbc27
X-MBO-RS-META: ekookwtg1p1kbx4fznax3t49ob5jryf8
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

On 5/25/26 05:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use livetree API which supports both live device tree and flat DT backends,
> avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/mmc/xenon_sdhci.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/xenon_sdhci.c b/drivers/mmc/xenon_sdhci.c
> index 0e4902fab77..6aa73792f96 100644
> --- a/drivers/mmc/xenon_sdhci.c
> +++ b/drivers/mmc/xenon_sdhci.c
> @@ -537,10 +537,9 @@ static int xenon_sdhci_of_to_plat(struct udevice *dev)
>   	host->ioaddr = dev_read_addr_ptr(dev);
>   
>   	if (device_is_compatible(dev, "marvell,armada-3700-sdhci"))
> -		priv->pad_ctrl_reg = devfdt_get_addr_index_ptr(dev, 1);
> +		priv->pad_ctrl_reg = dev_read_addr_index_ptr(dev, 1);
>   
> -	name = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), "marvell,pad-type",
> -			   NULL);
> +	name = ofnode_get_property(dev_ofnode(dev), "marvell,pad-type", NULL);
>   	if (name) {
>   		if (0 == strncmp(name, "sd", 2)) {
>   			priv->pad_type = SOC_PAD_SD;
> 

