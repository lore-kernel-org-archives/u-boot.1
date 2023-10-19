Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F17CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936958747C;
	Thu, 19 Oct 2023 17:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697729747;
	bh=iy1A7w3RaHI2M1dyANScMFkhG01ZpCDII2A/bzovIgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Th58R8OkBg5WpRRo6qJ11LLOUtYSO5zFHY1/ckrwodrJC6YbPULETNUXZmoC4368m
	 W3b4E6KiEhcDCqTKbEilSAADsLwjqxQB9kDDA4GVE14smqoEGRLyGVRfefzWmvp8i2
	 Vn8luBe4+LWX/C5A+W5by+lJO2P2vsV9G/k/nYmo0Zqtjn8xHg/+lBNQrsauItSEFK
	 a3foWoEyqb6MberC0EhfPkuCP1NuKOQvdowZPgPtkYq0cNm6vxfCRzwjYwKFfXxayx
	 2wyS5YSXvt461SUbmXvvKmECWbzX+QdxmBmJgp6QwAS0ebibEKyHnC+l9vzgeUQMCX
	 FYDjui1FMDCcw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EE00E8746F;
 Thu, 19 Oct 2023 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697729744;
 bh=iy1A7w3RaHI2M1dyANScMFkhG01ZpCDII2A/bzovIgU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yvOp+KfraCRucjtRYM383oVVextub9E2eMz6jQyKEbDEas4NpwUG5SJk7rXMrqezp
 OJ0xH3QtpwssMT2t6HUcw6bLd75oMLvzgf1w+f4sfJaMGQoGu53oSsdW1u4pHKXQOR
 Far9E3d5IdHtRWNxt5zPlZSF3yg92dsrsos9GeZrHgcFZhlbjoWUZeqUckn2xfGtrl
 Ni7HJyTQkhlqUyfvRDokdjvJyrtjQ4voJ+bpK+4oamR3ElnW2skZltIZBuLG5nBxfJ
 X2F4mYAOYcriLYpcFc7wgETlxMEOteEBQ78evN5JgQ8BN+V5HNxRuA1OCevv542uP5
 7na+Cw0Tz0STA==
Message-ID: <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
Date: Thu, 19 Oct 2023 15:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
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

On 10/19/23 11:58, Rasmus Villemoes wrote:
> If the driver's own .bind method has populated uc_plat->label, don't
> override that. This is necessary for an upcoming driver for ti,lp5562,
> where the DT binding unfortunately says to use "chan-name" and not
> "label".
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   drivers/led/led-uclass.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 5a5d07b9a7..0232fa84de 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
>   	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>   	const char *default_state;
>   
> -	uc_plat->label = dev_read_string(dev, "label");
> +	if (!uc_plat->label)
> +		uc_plat->label = dev_read_string(dev, "label");
> +

One thing I have to wonder about is, why does this controller have label 
property in the top-level node , what is that used for ?

(see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml)

Reviewed-by: Marek Vasut <marex@denx.de>
