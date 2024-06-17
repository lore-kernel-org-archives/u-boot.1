Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE5DC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F6888323;
	Mon, 17 Jun 2024 19:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="R3sGhiVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3FC88398; Mon, 17 Jun 2024 19:57:25 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F79882EF
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718647042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpuPdpNlnrDhH4AsMFQxXQdITqcU5am1x7kBjLlxsDo=;
 b=R3sGhiVMbUyouek7v9rWjH89RGxhGBdc6nz307H+svI4gmtyYiOfy0YzrficJl8uTYEfGi
 Uxn3TOugTmsNDvFjC30H0tnivOBW28AxBmiTPPIWUU81UoXpvf5DkUq5gy0yTX5HuwL31Z
 uWMN3kNboVZtTTyyu/DLaIWtog1etRikz34fmfHlCvmRQdFeJ9C6a2NNpPhorpnC0PC993
 R9G6rc/6K0gU+s/5vRdIpd4+vkzmlLef2r8LmIpljgcGYEJbbHfKE1uSYS5YjLM7kmVrqg
 lN2q2fwirTPpElywd18tJ3ba41QZWOGz23vjjXfeyAzzy85oWXpudQ+LeRvjEw==
Date: Mon, 17 Jun 2024 19:57:22 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH next] power: rk8xx: fix display name for RK808
In-Reply-To: <20240617-rk808-show-variant-v1-1-62143a89bafb@cherry.de>
References: <20240617-rk808-show-variant-v1-1-62143a89bafb@cherry.de>
Message-ID: <9134de0e83da76ac2ceb047074e69155@manjaro.org>
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

On 2024-06-17 18:48, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Commit 2ce40542e0eb ("power: rk8xx: properly print all supported PMICs
> name") fixed all PMICs name that were broken but broke the only one 
> that
> was not broken already: RK808. This one is a special case because the 
> ID
> registers are marked as reserved and always return 0, so the variant
> cannot be derived the same way it is done for other PMICs from 
> Rockchip.
> 
> Fixes: 2ce40542e0eb ("power: rk8xx: properly print all supported PMICs 
> name")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Looking good to me, but I'd still suggest [1] that reading the MSB/LSB 
ID
registers (i.e. 0x17 and 0x18) is skipped on the RK808 altogether, 
because
the RK808 datasheet lists those two registers as reserved and provides 
no
methods for determining the chip name.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

[1] 
https://lore.kernel.org/u-boot/7ef07d9b9b8a1b9064eb506c96ca8213@manjaro.org/

> ---
> Tested on RK3399 Puma.
> ---
>  drivers/power/pmic/rk8xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 617bb511e4e..4d5a5ceafad 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -281,6 +281,8 @@ static int rk8xx_probe(struct udevice *dev)
>  	show_variant = bitfield_extract_by_mask(priv->variant, RK8XX_ID_MSK);
>  	switch (priv->variant) {
>  	case RK808_ID:
> +		/* RK808 ID is 0x0000, so fix show_variant for that PMIC */
> +		show_variant = 0x808;
>  		break;
>  	case RK805_ID:
>  	case RK816_ID:
> 
> ---
> base-commit: e242cd95130b64cf91692da41363ac59b25fc08d
> change-id: 20240617-rk808-show-variant-2121df41caf7
> 
> Best regards,
