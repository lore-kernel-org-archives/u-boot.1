Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21596C25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 13:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE494882D7;
	Sat, 25 May 2024 15:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="lODRpIzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90E7882F1; Sat, 25 May 2024 15:35:29 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CBED882D7
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 15:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1716644126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alKwGAdXgAKHRJ3odPCjRZ072+9aCVWezf5e530d2C0=;
 b=lODRpIzYZc7r+U49s1YxFMBHhEmTBb967JprtImkKMm6oYOLsBWpy/Eq/0tSMkD6BPY3dC
 q/fQcNWT1Q5rYq1yjUYWWS4BIAhU4x4zB7p0kKDIXXICD8w4i00AafqM7cw/XsXv9C93Pr
 eWL3gPGdUDj9tjvCO6Zjo6FmY/oOyPUcdmmE/3EfTxR23BGpgb5bRDnw2btbPJxSB3HTrG
 7cnxfLvD3PEAoHmNaJ+IA0EgNj1kIRRlqu8Yn/tp03qeNRiXmDX0cHjMkrDTxBN1e7QKcL
 jbjwGLO/1O6PLe6rQ0Vwl5x17pd8OXYtYY+vnCAUJ72ItpIFGkdGxIbZ8zWfRg==
Date: Sat, 25 May 2024 15:35:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Klaus Goger <klaus.goger@theobroma-systems.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 5/5] power: rk8xx: properly print all supported PMICs
 name
In-Reply-To: <20240524-misc-tsd-v1-5-b7bde1344b9e@cherry.de>
References: <20240524-misc-tsd-v1-0-b7bde1344b9e@cherry.de>
 <20240524-misc-tsd-v1-5-b7bde1344b9e@cherry.de>
Message-ID: <ba4d0ca90c26db5ec3ba2780664a8899@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

Thanks for fixing this issue!  Please see my comments below.

On 2024-05-24 13:42, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The ID of the PMIC is stored in the 2 16b registers but the only part
> that matters right now is the 3 MSB, which make the 3 digits (in hex) 
> of
> the part number.
> 
> Right now, only RK808 was properly displayed, with this all currently
> supported PMICs should display the proper part number.
> 
> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
> Ringneck).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/power/pmic/rk8xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 12ff26a0855..fe85fb13543 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -277,10 +277,10 @@ static int rk8xx_probe(struct udevice *dev)
>  		return ret;
> 
>  	priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
> -	show_variant = priv->variant;
> +	/* All currently supported PMICs store the variant in the 3 MSB */
> +	show_variant = priv->variant >> 4;

It would be better to use bitfield_shift() to produce the shift
value from RK8XX_ID_MSK, instead of using 4 as the hardcoded value.
Or even better, just use bitfield_extract_by_mask() directly.

>  	switch (priv->variant) {
>  	case RK808_ID:
> -		show_variant = 0x808;	/* RK808 hardware ID is 0 */
>  		break;
>  	case RK805_ID:
>  	case RK816_ID:

I'd suggest that show_variant is also used in the following line,
instead of priv-variant, for consistency with the printing of the
known PMIC variant:

315    printf("Unknown PMIC: RK%x!!\n", priv->variant);
