Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20641C3ABCC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE8282162;
	Fri,  9 May 2025 14:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ot6l1kIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE6B8210D; Fri,  9 May 2025 12:42:29 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7C08059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 12:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso12165685e9.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746787346; x=1747392146; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9orE2AIthIMI/Er4ptLTrEkA9++Hrk2dIXWzz4zUV+Q=;
 b=Ot6l1kIBhbo8LFCEVG+EZvR+cpjWtySaQNvWRF9VpyLwpUiFKjLBeElMD84EXOfxzb
 n5uoj6Ri8/Dv/0/v1ZUX1n/i58YH7ILxOW5Ig/rNhDVrrX7Q92R3MiId2hGH89XQQBlA
 lD39Wy4IgnneizIWK1itONvrPoUcBucBAp5uv9d6p7N/agZBirKH2UIM1GjX/c6uoObx
 6GIr6JYcia3l5+0cKW5m9Dg5yvXpLzu2JJFTjiOSHHDfTiNLWga7PS7tszobbbNeZ3Uk
 iSIkdi7tp17nNYpiugZ2T82ZwWY0BkIpaejAPgHaJuqnMJBWH1g70JjLoOTqv/j+cTVx
 9TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746787346; x=1747392146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9orE2AIthIMI/Er4ptLTrEkA9++Hrk2dIXWzz4zUV+Q=;
 b=aD6kg/SIcnipqFel9CnEBaumS2VCaOsJdBviesYKN4LA6r/o7whINTdfVRBYu2GxAh
 Lnk8DFWwukq1H8n0VzJBNk9/eN+pItkfITQWA2/Mh+p6LdOBplDNs4W9c0TmnJRttlCo
 KDCvimkn+MhScysGpbEAohEztQT7T/jiOjbmXPsW90SQM2GPSmt98uMYK6eN63d4X33U
 Mrm50UrPlWjAyRwO2RBaXgSOpisTb0amXOFGA5DIvMhK55w7tcT/aRhkTPWGq3Mz0D5k
 7elE9OI9BBFKlCt2mTK27nHl33QK0/t37aNrhf6mIXzC4Y2CKTyjMh6ceOkYJ4jbWSV+
 ZAfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3xyX4j3du5FCdhDEp+IqMs4ASFeUcr8wCmWY8DNfDTFkof6XvVODLD32Po62m4SBWUisntcs=@lists.denx.de
X-Gm-Message-State: AOJu0YzsNRyPhKpxxwb8wCw5IE9U1uHuatumJ9XwLqlCkQAL9E6qIzX4
 hvj07s+4WDS4cHozGzqlJAEHlY8ZZskPiio7BTLq4XUCM1BbdoD+yYTVLuwJnR4=
X-Gm-Gg: ASbGncsYdrfplVYQNsGdLjUHawlml9prEbxPUXRbVLQBoiHHrLO+9N9Egw6qFt9DzNM
 4GFazkOTkAgZgVhf4cSTiVKDimKO7FfRjKewvcLdleHi9lXD0gVdc1R1cqzOqOreuxI8CQob7VN
 KbYyUg3fCfw8nEp2pDBGuVg8ZLiq7J5gKrxzvOOovi5q16t9bXC4xBKeMC/ONjK6BCZYZfLomxT
 KB9Yh9S1qZxmEgBeiPrKS8PutbpNNZgzSvFPbympeWcOfRszTtbXv6fzJWIZ6aLJ6OkN6HGTWmw
 D/twnlXTWD7DsnI0wDwMds8QdPci8vFQt9uieeliDBdKcdg9clnLoHwFwpV/R7wVQh5WROagUV7
 wEdKSW9y+tEz1ICAmVm7Puuej
X-Google-Smtp-Source: AGHT+IG1UjBWH0ubulzzC5K15eRRAQ4Lf2iUV9s+O3sKoud5DFLQtgDn0oUjOdWeSjig0tguVTM6Xg==
X-Received: by 2002:a05:600c:1912:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-442d6d64a00mr19835095e9.16.1746787346609; 
 Fri, 09 May 2025 03:42:26 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c09sm25674615e9.7.2025.05.09.03.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:42:25 -0700 (PDT)
Message-ID: <70465689-6133-43d1-94d7-0a8ff26083bb@linaro.org>
Date: Fri, 9 May 2025 12:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] gpio: msm_gpio: return correct value for gpio read
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 13:36, Aswin Murugan wrote:
> In the current implementation, the GPIO read operation considers
> both the input and outbut bits (bits 0 and 1). It should only consider
> the state of input bit, i.e bit 0. To address this, mask input bit
> alone and read it.

oof, nice find :D>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>   drivers/gpio/msm_gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index 6783fc756f4..7de332c66ae 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -202,7 +202,7 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
>   	if (qcom_is_special_pin(priv->pin_data, gpio))
>   		return msm_gpio_get_value_special(priv, gpio);
>   
> -	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
> +	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) & BIT(GPIO_IN));
>   }
>   
>   static int msm_gpio_get_function_special(struct msm_gpio_bank *priv,

-- 
Casey (she/they)

