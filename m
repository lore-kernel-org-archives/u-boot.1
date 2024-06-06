Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF37C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D327B87DE9;
	Thu,  6 Jun 2024 08:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hrVA2Fwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B9787FED; Thu,  6 Jun 2024 08:46:54 +0200 (CEST)
Received: from mail-m118211.qiye.163.com (mail-m118211.qiye.163.com
 [115.236.118.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F55286FB2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hrVA2FwlwMUfPW+EJY8Z1udQ7rKhCRTAt5eZkpbhwZg/Wccv46dW0xrXqcSImJv+5FARn/UFlRX5lBpHJAaNR6ugEd+MrYDFqK68K2veZ/oHOcEYeSQb+XZvFO3/QmINYV4m7d4gB4PMoxyW96IBIGWi4LuJA5TL6EkBJJNIACw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Oeopl+xNih8e0cetxfTKtkbMDX2/3c0clf66KrMOHiI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D61349004DE;
 Thu,  6 Jun 2024 14:46:20 +0800 (CST)
Message-ID: <f02c7366-1554-4dad-9d1d-9362bfc9905b@rock-chips.com>
Date: Thu, 6 Jun 2024 14:46:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] regulator: rk8xx: clarify operator precedence
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240605-pmic-rk8xx-v1-3-2349fdf68aa0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9OSVZPS0lJGkgaTEpNShpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec4c67bf03a9kunmd61349004de
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDI6FSo*LDNMMDY9NRocIQtK
 OBAwCUhVSlVKTEpMTU5NSENKQ0NDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTEhPNwY+
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


On 2024/6/5 17:33, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> My linter complains that the order isn't clear enough so let's put
> parentheses around the ternary condition to make it happy.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/regulator/rk8xx.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index bd5a37e718f..3125835bc07 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -520,7 +520,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>   	if (ret < 0)
>   		return ret;
>   
> -	return ret & mask ? true : false;
> +	return (ret & mask) ? true : false;
>   }
>   
>   static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
> @@ -585,7 +585,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   		val = pmic_reg_read(pmic, RK816_REG_DCDC_SLP_EN);
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>   		break;
>   	case RK806_ID:
>   		{
> @@ -608,7 +608,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF1);
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>   		break;
>   	case RK809_ID:
>   	case RK817_ID:
> @@ -620,7 +620,7 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   		val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(0));
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -723,7 +723,7 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
>   	if (ret < 0)
>   		return ret;
>   
> -	return ret & mask ? true : false;
> +	return (ret & mask) ? true : false;
>   }
>   
>   static int _nldo_get_enable(struct udevice *pmic, int nldo)
> @@ -980,7 +980,7 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>   		val = pmic_reg_read(pmic, RK816_REG_LDO_SLP_EN);
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>   		break;
>   	case RK808_ID:
>   	case RK818_ID:
> @@ -988,7 +988,7 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>   		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF2);
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>   		break;
>   	case RK809_ID:
>   	case RK817_ID:
> @@ -997,13 +997,13 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>   			val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(0));
>   			if (val < 0)
>   				return val;
> -			ret = val & mask ? 1 : 0;
> +			ret = (val & mask) ? 1 : 0;
>   		} else {
>   			mask = 1 << ldo;
>   			val = pmic_reg_read(pmic, RK817_POWER_SLP_EN(1));
>   			if (val < 0)
>   				return val;
> -			ret = val & mask ? 1 : 0;
> +			ret = (val & mask) ? 1 : 0;
>   		}
>   		break;
>   	}
> @@ -1438,7 +1438,7 @@ static int switch_get_enable(struct udevice *dev)
>   	if (ret < 0)
>   		return ret;
>   
> -	return ret & mask ? true : false;
> +	return (ret & mask) ? true : false;
>   }
>   
>   static int switch_set_suspend_value(struct udevice *dev, int uvolt)
> @@ -1493,21 +1493,21 @@ static int switch_get_suspend_enable(struct udevice *dev)
>   		val = pmic_reg_read(dev->parent, REG_SLEEP_SET_OFF1);
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>   		break;
>   	case RK809_ID:
>   		mask = 1 << (sw + 6);
>   		val = pmic_reg_read(dev->parent, RK817_POWER_SLP_EN(0));
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 1 : 0;
> +		ret = (val & mask) ? 1 : 0;
>   		break;
>   	case RK818_ID:
>   		mask = 1 << 6;
>   		val = pmic_reg_read(dev->parent, REG_SLEEP_SET_OFF1);
>   		if (val < 0)
>   			return val;
> -		ret = val & mask ? 0 : 1;
> +		ret = (val & mask) ? 0 : 1;
>   		break;
>   	}
>   
>
