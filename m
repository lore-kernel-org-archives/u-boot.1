Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C79C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0086187947;
	Thu,  6 Jun 2024 08:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BxswgLgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6126587C86; Thu,  6 Jun 2024 08:45:56 +0200 (CEST)
Received: from mail-m12790.qiye.163.com (mail-m12790.qiye.163.com
 [115.236.127.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EA2878ED
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BxswgLgNZGAkBTa8CK8EYf87fwsZYNhhcjp85VVe0jajIiRFyugy536lm+A0WfxhO+TIn1jnSY4AxwSMOQxSo/sKyQWt/J/QnaZVMquLtB+57XcCwRgEvwvEGLeO4TKk8x8TGdCdPYunWvMBgAHIeZK7xjEC5jI1XOu7iqLzwPA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jw9a62TAkxNSfNXQ9o7vCwybXdYTJU/lqyb58wwIiY8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D68E5900538;
 Thu,  6 Jun 2024 14:45:20 +0800 (CST)
Message-ID: <4153ba15-916c-416b-a73b-0659c6b4b132@rock-chips.com>
Date: Thu, 6 Jun 2024 14:45:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] regulator: rk8xx: fix incorrect device used for
 _ldo_[sg]et_suspend_value
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-1-2349fdf68aa0@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240605-pmic-rk8xx-v1-1-2349fdf68aa0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlNGVZPTk8eGk9PH0MeTk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec4b7c9403a9kunmd68e5900538
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6FCo4OTNOQzYONSIjIgIC
 VhxPCzZVSlVKTEpMTU5NSElKTElJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSk9KNwY+
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
> _ldo_get_suspend_value and _ldo_set_suspend_value get passed the parent
> of the regulator (so the pmic) as first argument, therefore this udevice
> should be used for pmic_* callbacks instead of using the parent of the
> pmic.
>
> To avoid further confusion, let's rename the argument to pmic instead of
> dev, highlighting which kind of device we expect as argument.
>
> Fixes: f047e4ab9762 ("regulator: rk8xx: add indirection level for some ldo callbacks")
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/regulator/rk8xx.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 1bd4605d43a..cce3502f89c 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -1216,7 +1216,7 @@ static int pldo_set_value(struct udevice *dev, int uvolt)
>   	return _ldo_set_value(dev, info, uvolt);
>   }
>   
> -static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
> +static int _ldo_set_suspend_value(struct udevice *pmic, const struct rk8xx_reg_info *info, int uvolt)
>   {
>   	int mask = info->vsel_mask;
>   	int val;
> @@ -1232,7 +1232,7 @@ static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_in
>   	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
>   	      __func__, uvolt, info->vsel_sleep_reg, mask, val);
>   
> -	return pmic_clrsetbits(dev->parent, info->vsel_sleep_reg, mask, val);
> +	return pmic_clrsetbits(pmic, info->vsel_sleep_reg, mask, val);
>   }
>   
>   static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
> @@ -1259,7 +1259,7 @@ static int pldo_set_suspend_value(struct udevice *dev, int uvolt)
>   	return _ldo_set_suspend_value(dev->parent, info, uvolt);
>   }
>   
> -static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info)
> +static int _ldo_get_suspend_value(struct udevice *pmic, const struct rk8xx_reg_info *info)
>   {
>   	int mask = info->vsel_mask;
>   	int val, ret;
> @@ -1267,7 +1267,7 @@ static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_in
>   	if (info->vsel_sleep_reg == NA)
>   		return -ENOSYS;
>   
> -	ret = pmic_reg_read(dev->parent, info->vsel_sleep_reg);
> +	ret = pmic_reg_read(pmic, info->vsel_sleep_reg);
>   	if (ret < 0)
>   		return ret;
>   
>
