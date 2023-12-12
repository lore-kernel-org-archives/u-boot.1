Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08496C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 18:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D3386FF4;
	Tue, 12 Dec 2023 19:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E462A871DE; Tue, 12 Dec 2023 19:12:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A4EDB86F40
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69378FEC;
 Tue, 12 Dec 2023 10:13:06 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0D013F762;
 Tue, 12 Dec 2023 10:12:18 -0800 (PST)
Date: Tue, 12 Dec 2023 18:12:16 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Hans de Goede
 <hdegoede@redhat.com>, Samuel Holland <samuel@sholland.org>, Jesse Taube
 <mr.bossman075@gmail.com>, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, John Watts
 <contact@jookia.org>
Subject: Re: [PATCH 1/8] sunxi: SPL SPI: extract code for doing SPI transfer
Message-ID: <20231212181216.4ebd980b@donnerap.manchester.arm.com>
In-Reply-To: <20221014030520.3067228-2-uwu@icenowy.me>
References: <20221014030520.3067228-1-uwu@icenowy.me>
 <20221014030520.3067228-2-uwu@icenowy.me>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Fri, 14 Oct 2022 11:05:13 +0800
Icenowy Zheng <uwu@icenowy.me> wrote:

Hi,

> To support SPI NAND flashes, more commands than Read (03h) are needed.
> 
> Extract the code for doing SPI transfer from the reading code for code
> reuse.

I was looking for a better solution than this inflated function parameter
list, but everything I came up with is actually worse. So it's fine like
you wrote it here.
I think it now even looks a bit better, since that long list is now
wrapped completely by the spi0_xfer() function.
It increases the code size by 20 (Thumb2) and 28 bytes (AArch64), that's
not great, but acceptable.

> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

With that one array index change that Samuel suggested (I can fix this up
myself):

Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/mach-sunxi/spl_spi_sunxi.c | 105 ++++++++++++++++------------
>  1 file changed, 59 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> index 925bf85f2d..7975457758 100644
> --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> @@ -243,77 +243,90 @@ static void spi0_deinit(void)
>  
>  #define SPI_READ_MAX_SIZE 60 /* FIFO size, minus 4 bytes of the header */
>  
> -static void sunxi_spi0_read_data(u8 *buf, u32 addr, u32 bufsize,
> -				 ulong spi_ctl_reg,
> -				 ulong spi_ctl_xch_bitmask,
> -				 ulong spi_fifo_reg,
> -				 ulong spi_tx_reg,
> -				 ulong spi_rx_reg,
> -				 ulong spi_bc_reg,
> -				 ulong spi_tc_reg,
> -				 ulong spi_bcc_reg)
> +static void sunxi_spi0_xfer(const u8 *txbuf, u32 txlen,
> +			    u8 *rxbuf, u32 rxlen,
> +			    ulong spi_ctl_reg,
> +			    ulong spi_ctl_xch_bitmask,
> +			    ulong spi_fifo_reg,
> +			    ulong spi_tx_reg,
> +			    ulong spi_rx_reg,
> +			    ulong spi_bc_reg,
> +			    ulong spi_tc_reg,
> +			    ulong spi_bcc_reg)
>  {
> -	writel(4 + bufsize, spi_bc_reg); /* Burst counter (total bytes) */
> -	writel(4, spi_tc_reg);           /* Transfer counter (bytes to send) */
> +	writel(txlen + rxlen, spi_bc_reg); /* Burst counter (total bytes) */
> +	writel(txlen, spi_tc_reg);         /* Transfer counter (bytes to send) */
>  	if (spi_bcc_reg)
> -		writel(4, spi_bcc_reg);  /* SUN6I also needs this */
> +		writel(txlen, spi_bcc_reg);  /* SUN6I also needs this */
>  
> -	/* Send the Read Data Bytes (03h) command header */
> -	writeb(0x03, spi_tx_reg);
> -	writeb((u8)(addr >> 16), spi_tx_reg);
> -	writeb((u8)(addr >> 8), spi_tx_reg);
> -	writeb((u8)(addr), spi_tx_reg);
> +	for (u32 i = 0; i < txlen; i++)
> +		writeb(*(txbuf++), spi_tx_reg);
>  
>  	/* Start the data transfer */
>  	setbits_le32(spi_ctl_reg, spi_ctl_xch_bitmask);
>  
>  	/* Wait until everything is received in the RX FIFO */
> -	while ((readl(spi_fifo_reg) & 0x7F) < 4 + bufsize)
> +	while ((readl(spi_fifo_reg) & 0x7F) < txlen + rxlen)
>  		;
>  
> -	/* Skip 4 bytes */
> -	readl(spi_rx_reg);
> +	/* Skip txlen bytes */
> +	for (u32 i = 0; i < txlen; i++)
> +		readb(spi_rx_reg);
>  
>  	/* Read the data */
> -	while (bufsize-- > 0)
> -		*buf++ = readb(spi_rx_reg);
> +	while (rxlen-- > 0)
> +		*rxbuf++ = readb(spi_rx_reg);
> +}
> +
> +static void spi0_xfer(const u8 *txbuf, u32 txlen, u8 *rxbuf, u32 rxlen)
> +{
> +	uintptr_t base = spi0_base_address();
>  
> -	/* tSHSL time is up to 100 ns in various SPI flash datasheets */
> -	udelay(1);
> +	if (is_sun6i_gen_spi()) {
> +		sunxi_spi0_xfer(txbuf, txlen, rxbuf, rxlen,
> +				base + SUN6I_SPI0_TCR,
> +				SUN6I_TCR_XCH,
> +				base + SUN6I_SPI0_FIFO_STA,
> +				base + SUN6I_SPI0_TXD,
> +				base + SUN6I_SPI0_RXD,
> +				base + SUN6I_SPI0_MBC,
> +				base + SUN6I_SPI0_MTC,
> +				base + SUN6I_SPI0_BCC);
> +	} else {
> +		sunxi_spi0_xfer(txbuf, txlen, rxbuf, rxlen,
> +				base + SUN4I_SPI0_CTL,
> +				SUN4I_CTL_XCH,
> +				base + SUN4I_SPI0_FIFO_STA,
> +				base + SUN4I_SPI0_TX,
> +				base + SUN4I_SPI0_RX,
> +				base + SUN4I_SPI0_BC,
> +				base + SUN4I_SPI0_TC,
> +				0);
> +	}
>  }
>  
>  static void spi0_read_data(void *buf, u32 addr, u32 len)
>  {
>  	u8 *buf8 = buf;
>  	u32 chunk_len;
> -	uintptr_t base = spi0_base_address();
> +	u8 txbuf[4];
>  
>  	while (len > 0) {
>  		chunk_len = len;
> +
> +		/* Configure the Read Data Bytes (03h) command header */
> +		txbuf[0] = 0x03;
> +		txbuf[1] = (u8)(addr >> 16);
> +		txbuf[2] = (u8)(addr >> 8);
> +		txbuf[3] = (u8)(addr);
> +
>  		if (chunk_len > SPI_READ_MAX_SIZE)
>  			chunk_len = SPI_READ_MAX_SIZE;
>  
> -		if (is_sun6i_gen_spi()) {
> -			sunxi_spi0_read_data(buf8, addr, chunk_len,
> -					     base + SUN6I_SPI0_TCR,
> -					     SUN6I_TCR_XCH,
> -					     base + SUN6I_SPI0_FIFO_STA,
> -					     base + SUN6I_SPI0_TXD,
> -					     base + SUN6I_SPI0_RXD,
> -					     base + SUN6I_SPI0_MBC,
> -					     base + SUN6I_SPI0_MTC,
> -					     base + SUN6I_SPI0_BCC);
> -		} else {
> -			sunxi_spi0_read_data(buf8, addr, chunk_len,
> -					     base + SUN4I_SPI0_CTL,
> -					     SUN4I_CTL_XCH,
> -					     base + SUN4I_SPI0_FIFO_STA,
> -					     base + SUN4I_SPI0_TX,
> -					     base + SUN4I_SPI0_RX,
> -					     base + SUN4I_SPI0_BC,
> -					     base + SUN4I_SPI0_TC,
> -					     0);
> -		}
> +		spi0_xfer(txbuf, 4, buf8, chunk_len);
> +
> +		/* tSHSL time is up to 100 ns in various SPI flash datasheets */
> +		udelay(1);
>  
>  		len  -= chunk_len;
>  		buf8 += chunk_len;

