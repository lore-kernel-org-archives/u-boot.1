Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DC4C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F50B8899C;
	Tue,  6 Aug 2024 14:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16E5889E1; Tue,  6 Aug 2024 14:37:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4E5CB880A7
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC2D1063;
 Tue,  6 Aug 2024 05:37:57 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0A53F766;
 Tue,  6 Aug 2024 05:37:31 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:37:28 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] spi: sunxi: fix clock divider calculation for
 max frequency setting
Message-ID: <20240806133728.006aa260@donnerap.manchester.arm.com>
In-Reply-To: <20240718204253.1180233-2-mwalle@kernel.org>
References: <20240718204253.1180233-1-mwalle@kernel.org>
 <20240718204253.1180233-2-mwalle@kernel.org>
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

On Thu, 18 Jul 2024 22:42:53 +0200
Michael Walle <mwalle@kernel.org> wrote:

> If the maximum frequency is requested, we still fall into the CDR2
> handling. But there the minimal divider is 2. For the sun6i and sun8i we
> can do better with the CDR1 setting where the minimal divider is 1:
>   SPI_CLK = MOD_CLK / 2 ^ cdr with cdr = 0
> 
> Thus, handle the div = 1 case specially.
> 
> While at it, correct the comment above the calculation.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied to sunxi/master.

Cheers,
Andre

> ---
>  drivers/spi/spi-sunxi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
> index f110a8b7658..81f1298adea 100644
> --- a/drivers/spi/spi-sunxi.c
> +++ b/drivers/spi/spi-sunxi.c
> @@ -249,6 +249,8 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
>  	 * We have two choices there. Either we can use the clock
>  	 * divide rate 1, which is calculated thanks to this formula:
>  	 * SPI_CLK = MOD_CLK / (2 ^ (cdr + 1))
> +	 * Or for sun6i/sun8i variants:
> +	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
>  	 * Or we can use CDR2, which is calculated with the formula:
>  	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
>  	 * Whether we use the former or the latter is set through the
> @@ -256,13 +258,16 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
>  	 *
>  	 * First try CDR2, and if we can't reach the expected
>  	 * frequency, fall back to CDR1.
> +	 * There is one exception if the requested clock is the input
> +	 * clock. In that case we always use CDR1 because we'll get a
> +	 * 1:1 ration for sun6i/sun8i variants.
>  	 */
>  
>  	div = DIV_ROUND_UP(SUNXI_INPUT_CLOCK, priv->freq);
>  	div_cdr2 = DIV_ROUND_UP(div, 2);
>  	reg = readl(SPI_REG(priv, SPI_CCR));
>  
> -	if (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> +	if (div != 1 && (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1))) {
>  		reg &= ~(SUN4I_CLK_CTL_CDR2_MASK | SUN4I_CLK_CTL_DRS);
>  		reg |= SUN4I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN4I_CLK_CTL_DRS;
>  	} else {

