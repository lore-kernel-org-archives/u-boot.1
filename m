Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B387DCCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CFF80F0E;
	Fri,  1 May 2026 14:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C0783A91; Fri,  1 May 2026 14:26:08 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D1080086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 14:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.124.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 6897D34205F;
 Fri, 01 May 2026 12:26:02 +0000 (UTC)
Date: Fri, 1 May 2026 12:25:51 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] spi: sunxi: wait for TX/RX fifo reset done
Message-ID: <20260501122551-GYB3258572@gentoo.org>
References: <20260421-02-spi-fifo-reset-v1-1-e2cdd4bd474d@gentoo.org>
 <e10c1362-59d2-46bf-914f-ef5163336e1f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10c1362-59d2-46bf-914f-ef5163336e1f@arm.com>
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

Hi Andre,

On 11:54 Thu 30 Apr     , Andre Przywara wrote:
> Hi,
> 
> On 4/21/26 06:47, Yixun Lan wrote:
> > Once reset SPI TX or RX fifo, the underlying hardware need to take
> > some time to actually settle down, the two bits will automatically
> > clear to 0, so use a poll mechanism to check status bits to make sure
> > it's done correctly.
> 
> Ah, interesting, thanks for posting this!
> I looked into some manuals, and it seems like this self-clearing 
> property is already used in the A10, so it's fine to use unconditionally.
> 
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> Acked-by: Andre Przywara <andre.przywara@arm.com>
> 
> If you don't mind, I would pull the below paragraph into the commit 
> message, since it's useful to have in the git history.
> 
No, feel free to adjust.. And thanks
I'd assume you will handle all this? so no need from my side to post new version

> Cheers,
> Andre.
> 
> P.S. Just curious if we need a similar fix for Linux, or are we saved by 
> the Linux code spending more time in setup before doing a transfer?
> 
I've not looked into Linux/Kernel side, since this is a hardware feature,
so yes, we should do something similar (to be safe)

> > ---
> > On Cubie A7A board which using A733 SoC, we encoutered a SPI nor flash
> > timeout issue, it turns out that the SPI fifo reset take a few time to
> > settle down, Add a loop to poll the status.
> > 
> > This was the error message shows on A7A board once this issue happened.
> > 
> > => sf probe
> > ERROR: sun4i_spi: Timeout transferring data
> > Failed to initialize SPI flash at 0:0 (error -2)
> > ---
> >   drivers/spi/spi-sunxi.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
> > index e00532a371b..cf41905c7b7 100644
> > --- a/drivers/spi/spi-sunxi.c
> > +++ b/drivers/spi/spi-sunxi.c
> > @@ -347,7 +347,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
> >   	struct sun4i_spi_priv *priv = dev_get_priv(bus);
> >   	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> >   
> > -	u32 len = bitlen / 8;
> > +	u32 rst, val, len = bitlen / 8;
> >   	u8 nbytes;
> >   	int ret;
> >   
> > @@ -363,8 +363,11 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
> >   		sun4i_spi_set_cs(bus, slave_plat->cs[0], true);
> >   
> >   	/* Reset FIFOs */
> > -	setbits_le32(SPI_REG(priv, SPI_FCR), SPI_BIT(priv, SPI_FCR_RF_RST) |
> > -		     SPI_BIT(priv, SPI_FCR_TF_RST));
> > +	rst = SPI_BIT(priv, SPI_FCR_RF_RST) | SPI_BIT(priv, SPI_FCR_TF_RST);
> > +	setbits_le32(SPI_REG(priv, SPI_FCR), rst);
> > +	ret = readl_poll_timeout(SPI_REG(priv, SPI_FCR), val, !(rst & val), 20);
> > +	if (ret)
> > +		return -EBUSY;
> >   
> >   	while (len) {
> >   		/* Setup the transfer now... */
> > 
> > ---
> > base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
> > change-id: 20260220-02-spi-fifo-reset-25e371314c3f
> > 
> > Best regards,
> 

-- 
Yixun Lan (dlan)
