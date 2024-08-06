Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD7BC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A5B88A05;
	Tue,  6 Aug 2024 14:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3ED889EB; Tue,  6 Aug 2024 14:36:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0146788A10
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C336CFEC;
 Tue,  6 Aug 2024 05:37:05 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C64E3F766;
 Tue,  6 Aug 2024 05:36:39 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:36:36 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] spi: sunxi: fix CDR2 calculation
Message-ID: <20240806133636.6ddb9505@donnerap.manchester.arm.com>
In-Reply-To: <20240718204253.1180233-1-mwalle@kernel.org>
References: <20240718204253.1180233-1-mwalle@kernel.org>
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

On Thu, 18 Jul 2024 22:42:52 +0200
Michael Walle <mwalle@kernel.org> wrote:

Hi,

> The CDR2 divider calculation always yield a frequency greater than the
> requested one. Use DIV_ROUND_UP() to keep the frequency equal or below
> the requested one. This way, we can also drop the "if div > 0" check
> because we know for a fact that div cannot be zero.
> 
> FWIW, this aligns the CDR2 calculation with the linux driver.

Thanks, that looks alright now. I tested some corner cases, and it seems
to do the right thing (TM) now.

> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied to sunxi/master.

Cheers,
Andre.

> ---
>  drivers/spi/spi-sunxi.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
> index bfb402902b8..f110a8b7658 100644
> --- a/drivers/spi/spi-sunxi.c
> +++ b/drivers/spi/spi-sunxi.c
> @@ -233,7 +233,7 @@ err_ahb:
>  static void sun4i_spi_set_speed_mode(struct udevice *dev)
>  {
>  	struct sun4i_spi_priv *priv = dev_get_priv(dev);
> -	unsigned int div;
> +	unsigned int div, div_cdr2;
>  	u32 reg;
>  
>  	/*
> @@ -259,15 +259,12 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
>  	 */
>  
>  	div = DIV_ROUND_UP(SUNXI_INPUT_CLOCK, priv->freq);
> +	div_cdr2 = DIV_ROUND_UP(div, 2);
>  	reg = readl(SPI_REG(priv, SPI_CCR));
>  
> -	if ((div / 2) <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> -		div /= 2;
> -		if (div > 0)
> -			div--;
> -
> +	if (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
>  		reg &= ~(SUN4I_CLK_CTL_CDR2_MASK | SUN4I_CLK_CTL_DRS);
> -		reg |= SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
> +		reg |= SUN4I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN4I_CLK_CTL_DRS;
>  	} else {
>  		div = fls(div - 1);
>  		/* The F1C100s encodes the divider as 2^(n+1) */

