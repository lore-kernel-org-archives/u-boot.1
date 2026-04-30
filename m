Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B37FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579C1846A7;
	Thu, 30 Apr 2026 11:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Gi7zQlCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FA6846AD; Thu, 30 Apr 2026 11:54:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7EF53846A1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB311A9A;
 Thu, 30 Apr 2026 02:54:22 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C6E123F7B4; Thu, 30 Apr 2026 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777542867; bh=CxElS4XTNrwXiUHwFIyL0TTqxPlFbyxApw7ED+H4PaM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Gi7zQlCphF2oShCewAWOezqcOjQYHPBOVbC2/RHFLraEJQ/nka+gG3kaENjUjFQhu
 Vo2P1NY70+vuLaNdG4nwQIoZJVna904dFmnDSh6ILcDmQQxmPJWayXU7QPd74ffb2f
 v/ytkayb+6lX+lOhqCiI+W5Z+X3379uQayj9fu0w=
Message-ID: <e10c1362-59d2-46bf-914f-ef5163336e1f@arm.com>
Date: Thu, 30 Apr 2026 11:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: sunxi: wait for TX/RX fifo reset done
To: Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20260421-02-spi-fifo-reset-v1-1-e2cdd4bd474d@gentoo.org>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260421-02-spi-fifo-reset-v1-1-e2cdd4bd474d@gentoo.org>
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

Hi,

On 4/21/26 06:47, Yixun Lan wrote:
> Once reset SPI TX or RX fifo, the underlying hardware need to take
> some time to actually settle down, the two bits will automatically
> clear to 0, so use a poll mechanism to check status bits to make sure
> it's done correctly.

Ah, interesting, thanks for posting this!
I looked into some manuals, and it seems like this self-clearing 
property is already used in the A10, so it's fine to use unconditionally.

> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Acked-by: Andre Przywara <andre.przywara@arm.com>

If you don't mind, I would pull the below paragraph into the commit 
message, since it's useful to have in the git history.

Cheers,
Andre.

P.S. Just curious if we need a similar fix for Linux, or are we saved by 
the Linux code spending more time in setup before doing a transfer?

> ---
> On Cubie A7A board which using A733 SoC, we encoutered a SPI nor flash
> timeout issue, it turns out that the SPI fifo reset take a few time to
> settle down, Add a loop to poll the status.
> 
> This was the error message shows on A7A board once this issue happened.
> 
> => sf probe
> ERROR: sun4i_spi: Timeout transferring data
> Failed to initialize SPI flash at 0:0 (error -2)
> ---
>   drivers/spi/spi-sunxi.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
> index e00532a371b..cf41905c7b7 100644
> --- a/drivers/spi/spi-sunxi.c
> +++ b/drivers/spi/spi-sunxi.c
> @@ -347,7 +347,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   	struct sun4i_spi_priv *priv = dev_get_priv(bus);
>   	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
>   
> -	u32 len = bitlen / 8;
> +	u32 rst, val, len = bitlen / 8;
>   	u8 nbytes;
>   	int ret;
>   
> @@ -363,8 +363,11 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   		sun4i_spi_set_cs(bus, slave_plat->cs[0], true);
>   
>   	/* Reset FIFOs */
> -	setbits_le32(SPI_REG(priv, SPI_FCR), SPI_BIT(priv, SPI_FCR_RF_RST) |
> -		     SPI_BIT(priv, SPI_FCR_TF_RST));
> +	rst = SPI_BIT(priv, SPI_FCR_RF_RST) | SPI_BIT(priv, SPI_FCR_TF_RST);
> +	setbits_le32(SPI_REG(priv, SPI_FCR), rst);
> +	ret = readl_poll_timeout(SPI_REG(priv, SPI_FCR), val, !(rst & val), 20);
> +	if (ret)
> +		return -EBUSY;
>   
>   	while (len) {
>   		/* Setup the transfer now... */
> 
> ---
> base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> change-id: 20260220-02-spi-fifo-reset-25e371314c3f
> 
> Best regards,

