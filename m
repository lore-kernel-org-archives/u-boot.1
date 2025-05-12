Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E60EC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 07:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A05805D7;
	Mon, 12 May 2025 09:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsFw5h4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F3C8091A; Mon, 12 May 2025 09:29:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C46800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7390C61149;
 Mon, 12 May 2025 07:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0527AC4CEE7;
 Mon, 12 May 2025 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747034962;
 bh=J2JYc5kZYqDv97IC/vxPTEqkwGiBRVQDJjSbIfiwweU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WsFw5h4uI6+ATLYcU/grrf+mVCM2WWb5WVhljeh2icqNMAMzzF6Hkwadj6hoWlV39
 fFvZIqoRyDainrhGhsRqJpT0DpLLIsbPeYgxo/TjEzORaQ1k7UH+BKi6zkAQQ0mlFu
 B7k/K188zwupOpZCdF/kWG8ebZDkkJUTeXx5jG1u2OYPYjJLGLVhF294SeoenZ/w4T
 zYOJNPGkcYoz1aqpyF83oDWA6qIeMiadAhXwMQvP0xB+Yiab8KwEecVJ/fnT8XCJSI
 eOGnvTuKADLVyDzlXTtaFnNeVSNOmRSvOpRIApcpFnhOzLbujBV6RJPHhJ2Gh8FITL
 Q/Kcw8x3eGQAg==
Date: Mon, 12 May 2025 12:59:16 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] gpio: msm_gpio: return correct value for gpio read
Message-ID: <aCGjTLuK0_dz9P9E@sumit-X1>
References: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
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

On Thu, May 08, 2025 at 05:06:46PM +0530, Aswin Murugan wrote:
> In the current implementation, the GPIO read operation considers
> both the input and outbut bits (bits 0 and 1). It should only consider
> the state of input bit, i.e bit 0. To address this, mask input bit
> alone and read it.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/gpio/msm_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 6783fc756f4..7de332c66ae 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -202,7 +202,7 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>  	if (qcom_is_special_pin(priv->pin_data, gpio))
>  		return msm_gpio_get_value_special(priv, gpio);
>  
> -	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
> +	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) & BIT(GPIO_IN));
>  }
>  
>  static int msm_gpio_get_function_special(struct msm_gpio_bank *priv,
> -- 
> 2.34.1
> 
