Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65BDC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224718836C;
	Wed,  5 Jun 2024 13:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nSAtMyc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FEB98836E; Wed,  5 Jun 2024 13:20:30 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D37B88286
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421338c4c3bso20497755e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717586427; x=1718191227;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7nvIJra7+OoogoXiIAQKzdVv2FP9HEJQ7dUwTDLI91o=;
 b=nSAtMyc+SK/l//YXxa3riiCXO/Us8IIKaOR8Go0YJY0RZ6icld7+7Vce05PbsQ8G/F
 gHa5xJETcI+Weko4UpBuld3NSlfZXBrhCOdE+pab817aBUT3A2uHOTgcUvJkXDoPT+/1
 q1qTlVuvCZkS302WNYKxqjb7k10kOhg404xRy8s0b+dwORT1rLxydQYsthkAovSbkAQL
 pB/oVYj8WPqDEFU8lEADVffkfEjgT6pQ+YhS5P1Jnrhtv1L9JkesyBmQDqk66Vyg3sS2
 Ivk5VTmXrsJbhtTu5b8UfZ/AT42gJWqnedGhvVwZeWEc1ENVxH+mHwjIcNuG6dI7TzMx
 oRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586427; x=1718191227;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7nvIJra7+OoogoXiIAQKzdVv2FP9HEJQ7dUwTDLI91o=;
 b=rt08Gb3CXzCfqkm6MP6l3sOmm3KL5M4sElrFXlNWQt1iVlQ1GvoyRFogkbZ9hf/SBp
 R349h4e1IxPIBRbGTeO4SWYmbuRh/lRza5Ks9l0+Ns0ftsGgblAMhUdu4d+px0TtQQTN
 JYC9PhfgTk1QmDXKoWlXQQ1oHqf22QSiF3VoXrfE9sty3a94zFyn0dFQ6h6R7s24JHZB
 sghcAXgBdClgY4eIgTSmTICA2YhQisaiqGUm5REYUxN5ZfSsgkgcTUz+AIxHogQWvETT
 COdD7UZxUx+0yh30yt+JF0GtoC7YLQzymjfw8xKH0McMjGGa3Y5MOvu9DysNZL00qZH1
 2S+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0dAmv+SO9TG7FZJDazrak/aC0svYmIB3AVe1NpTA+IVj6SPdL3jsM6Du2CC3uaZCw5m2qLAkrgRdFXGXz7QICsN2hYQ==
X-Gm-Message-State: AOJu0YymWGzqhkNz3MiwB0TE/XkcyWmxgZQnnXSIC5DiV+LCwYKmRojr
 aVcl3rJcjljMsddF4c/WdTTDgdQnyP+N6c/r+CUW9oFqDLVbpdbxTzZWZBvUkQQ=
X-Google-Smtp-Source: AGHT+IH/rh1TklRviLyrIG+w+HtZt9sB7bbfMAZqcOCSaciEEw+J54i9E3Y1/BkJf/9gEd/F2k8JAw==
X-Received: by 2002:a05:600c:3d9b:b0:41c:ab7:fa0f with SMTP id
 5b1f17b1804b1-42156338fd4mr18572545e9.34.1717586427311; 
 Wed, 05 Jun 2024 04:20:27 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158148ffasm18605905e9.38.2024.06.05.04.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:20:26 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Quentin Schulz <foss+uboot@0leil.net>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] regulator: rk8xx: clarify operator precedence
In-Reply-To: <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
Date: Wed, 05 Jun 2024 13:20:26 +0200
Message-ID: <87y17jhc05.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Quentin,

Thank you for the patch.

On mer., juin 05, 2024 at 11:33, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> My linter complains that the order isn't clear enough so let's put
> parentheses around the ternary condition to make it happy.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/power/regulator/rk8xx.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index bd5a37e718f..3125835bc07 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -520,7 +520,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ret & mask ? true : false;
> +	return (ret & mask) ? true : false;
>  }
>  
>  static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
> @@ -585,7 +585,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>  		val = pmic_reg_read(pmic, RK816_REG_DCDC_SLP_EN);
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>  		break;
>  	case RK806_ID:
>  		{
> @@ -608,7 +608,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>  		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF1);
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>  		break;
>  	case RK809_ID:
>  	case RK817_ID:
> @@ -620,7 +620,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>  		val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(0));
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -723,7 +723,7 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ret & mask ? true : false;
> +	return (ret & mask) ? true : false;
>  }
>  
>  static int _nldo_get_enable(struct udevice *pmic, int nldo)
> @@ -980,7 +980,7 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>  		val = pmic_reg_read(pmic, RK816_REG_LDO_SLP_EN);
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>  		break;
>  	case RK808_ID:
>  	case RK818_ID:
> @@ -988,7 +988,7 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>  		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF2);
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>  		break;
>  	case RK809_ID:
>  	case RK817_ID:
> @@ -997,13 +997,13 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>  			val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(0));
>  			if (val < 0)
>  				return val;
> -			ret = val & mask ? 1 : 0;
> +			ret = (val & mask) ? 1 : 0;
>  		} else {
>  			mask = 1 << ldo;
>  			val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(1));
>  			if (val < 0)
>  				return val;
> -			ret = val & mask ? 1 : 0;
> +			ret = (val & mask) ? 1 : 0;
>  		}
>  		break;
>  	}
> @@ -1438,7 +1438,7 @@ static int switch_get_enable(struct udevice *dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ret & mask ? true : false;
> +	return (ret & mask) ? true : false;
>  }
>  
>  static int switch_set_suspend_value(struct udevice *dev, int uvolt)
> @@ -1493,21 +1493,21 @@ static int switch_get_suspend_enable(struct udevice *dev)
>  		val = pmic_reg_read(dev->parent, REG_SLEEP_SET_OFF1);
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>  		break;
>  	case RK809_ID:
>  		mask = 1 << (sw + 6);
>  		val = pmic_reg_read(dev->parent, RK817_POWER_SLP_EN(0));
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>  		break;
>  	case RK818_ID:
>  		mask = 1 << 6;
>  		val = pmic_reg_read(dev->parent, REG_SLEEP_SET_OFF1);
>  		if (val < 0)
>  			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>  		break;
>  	}
>  
>
> -- 
> 2.45.1
