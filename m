Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC64C25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 06:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242EB87FEE;
	Sat,  8 Jun 2024 08:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="yoOXOD6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB75088047; Sat,  8 Jun 2024 08:14:50 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98B087F6F
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 08:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717827288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UETrcSF5GT185lLhnkTLMM8V4FzcwAnnKjfaf2sl6WE=;
 b=yoOXOD6hTEwiNOWnzXwaVmg2AVm1NOYGnxEt983xhbfGITL2yM/Hvr7LrTdUeALygclLQs
 mVjK9ROfdq3rYn36NU2cvLZgk34Z3/0QC5WAjo0u2FtfPBvCO1Cb7IXK3rtHhM/bBZ9/lZ
 LYlMiwKUD0gdBp3h/BWcrWkEwijHa/AvDO88o/7fMKx4VWCCsNav4m8YN66I/COoY+wChp
 6IwqToiokCIenJltGQJpTRA9i5+WlfTSh7fmOEvO2mfDwX0AecO8pasYkNpf1ZpghzPiaC
 9g37v0hlaQf8TxSzzWlSULpCT2iu+uknV22gRr9e4xLgtPP69gSiJjhnLsRHCw==
Date: Sat, 08 Jun 2024 08:14:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Klaus Goger <klaus.goger@theobroma-systems.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next v2 5/6] power: rk8xx: properly print all supported
 PMICs name
In-Reply-To: <20240605-misc-tsd-v2-5-12479432c90f@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
 <20240605-misc-tsd-v2-5-12479432c90f@cherry.de>
Message-ID: <b118348058b2e1fb1ffddb22b6a70f79@manjaro.org>
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

On 2024-06-05 17:56, Quentin Schulz wrote:
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
> Additionally, when the PMIC variant is not found, print that value
> instead of the masked unshifted value as all PMICs we support for now
> have their LSB ignored to represent the actual part number.
> 
> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
> Ringneck).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/power/pmic/rk8xx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 12ff26a0855..4d07e630579 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -277,10 +277,9 @@ static int rk8xx_probe(struct udevice *dev)
>  		return ret;
> 
>  	priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
> -	show_variant = priv->variant;
> +	show_variant = bitfield_extract_by_mask(priv->variant, RK8XX_ID_MSK);
>  	switch (priv->variant) {
>  	case RK808_ID:
> -		show_variant = 0x808;	/* RK808 hardware ID is 0 */
>  		break;
>  	case RK805_ID:
>  	case RK816_ID:
> @@ -311,7 +310,7 @@ static int rk8xx_probe(struct udevice *dev)
>  		init_data_num = ARRAY_SIZE(rk806_init_reg);
>  		break;
>  	default:
> -		printf("Unknown PMIC: RK%x!!\n", priv->variant);
> +		printf("Unknown PMIC: RK%x!!\n", show_variant);
>  		return -EINVAL;
>  	}
