Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB092C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B35288027;
	Thu,  6 Jun 2024 08:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P/Xj9JG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529B886FB2; Thu,  6 Jun 2024 08:46:24 +0200 (CEST)
Received: from mail-m19731104.qiye.163.com (mail-m19731104.qiye.163.com
 [220.197.31.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FA38806A
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=P/Xj9JG9u7/Z2mRpIcGkRPFkzEVMIRoPKHGaB+4ZWRG5Q57rmMKcWhCdGFhRUoNGJgraWWvyw4fbdbYDXmhUPlCf7j/2OUk0OwIuYunezk+K6hHNcb2ssYSssuoY6hECOT5dfXp732rkb5BdKf3xPSLCFfpfAHOvRIy+R2GUh2s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=v5/7syVpEDA/wNxfElw45C9RpPbxxmh2JvK1OwkDyIw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CCF48900550;
 Thu,  6 Jun 2024 14:45:52 +0800 (CST)
Message-ID: <770db746-e154-4890-ba2a-3b17bfcfcbbf@rock-chips.com>
Date: Thu, 6 Jun 2024 14:45:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] regulator: rk8xx: pass pmic udevice instead of
 regulator to all internal functions
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-2-2349fdf68aa0@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240605-pmic-rk8xx-v1-2-2349fdf68aa0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tMSVZDGEJNT0xCSksaQkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec4bfa2403a9kunmccf48900550
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Cyo5MDNPHjZCHyIUIRky
 GhoKC0NVSlVKTEpMTU5NSE5IQ01JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTU9LNwY+
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
> For the sake of consistency, make all internal (starting with _)
> functions expect a pmic udevice instead of a regulator udevice.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/regulator/rk8xx.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index cce3502f89c..bd5a37e718f 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -1134,14 +1134,14 @@ static int buck_get_enable(struct udevice *dev)
>   	return _buck_get_enable(dev->parent, buck);
>   }
>   
> -static int _ldo_get_value(struct udevice *dev, const struct rk8xx_reg_info *info)
> +static int _ldo_get_value(struct udevice *pmic, const struct rk8xx_reg_info *info)
>   {
>   	int mask = info->vsel_mask;
>   	int ret, val;
>   
>   	if (info->vsel_reg == NA)
>   		return -ENOSYS;
> -	ret = pmic_reg_read(dev->parent, info->vsel_reg);
> +	ret = pmic_reg_read(pmic, info->vsel_reg);
>   	if (ret < 0)
>   		return ret;
>   	val = ret & mask;
> @@ -1154,7 +1154,7 @@ static int ldo_get_value(struct udevice *dev)
>   	int ldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
>   
> -	return _ldo_get_value(dev, info);
> +	return _ldo_get_value(dev->parent, info);
>   }
>   
>   static int nldo_get_value(struct udevice *dev)
> @@ -1162,7 +1162,7 @@ static int nldo_get_value(struct udevice *dev)
>   	int nldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, 0);
>   
> -	return _ldo_get_value(dev, info);
> +	return _ldo_get_value(dev->parent, info);
>   }
>   
>   static int pldo_get_value(struct udevice *dev)
> @@ -1170,10 +1170,10 @@ static int pldo_get_value(struct udevice *dev)
>   	int pldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, 0);
>   
> -	return _ldo_get_value(dev, info);
> +	return _ldo_get_value(dev->parent, info);
>   }
>   
> -static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
> +static int _ldo_set_value(struct udevice *pmic, const struct rk8xx_reg_info *info, int uvolt)
>   {
>   	int mask = info->vsel_mask;
>   	int val;
> @@ -1189,7 +1189,7 @@ static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info
>   	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
>   	      __func__, uvolt, info->vsel_reg, mask, val);
>   
> -	return pmic_clrsetbits(dev->parent, info->vsel_reg, mask, val);
> +	return pmic_clrsetbits(pmic, info->vsel_reg, mask, val);
>   }
>   
>   static int ldo_set_value(struct udevice *dev, int uvolt)
> @@ -1197,7 +1197,7 @@ static int ldo_set_value(struct udevice *dev, int uvolt)
>   	int ldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
>   
> -	return _ldo_set_value(dev, info, uvolt);
> +	return _ldo_set_value(dev->parent, info, uvolt);
>   }
>   
>   static int nldo_set_value(struct udevice *dev, int uvolt)
> @@ -1205,7 +1205,7 @@ static int nldo_set_value(struct udevice *dev, int uvolt)
>   	int nldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, uvolt);
>   
> -	return _ldo_set_value(dev, info, uvolt);
> +	return _ldo_set_value(dev->parent, info, uvolt);
>   }
>   
>   static int pldo_set_value(struct udevice *dev, int uvolt)
> @@ -1213,7 +1213,7 @@ static int pldo_set_value(struct udevice *dev, int uvolt)
>   	int pldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, uvolt);
>   
> -	return _ldo_set_value(dev, info, uvolt);
> +	return _ldo_set_value(dev->parent, info, uvolt);
>   }
>   
>   static int _ldo_set_suspend_value(struct udevice *pmic, const struct rk8xx_reg_info *info, int uvolt)
>
