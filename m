Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C246C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B389487EF5;
	Mon, 11 Mar 2024 11:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BbIPYfyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B6887F09; Mon, 11 Mar 2024 11:11:56 +0100 (CET)
Received: from mail-m49201.qiye.163.com (mail-m49201.qiye.163.com
 [45.254.49.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF0C86BDB
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BbIPYfyd02654/MLt59X8YJUD8EZzKES5rjcFBX80RraMbEhOk88E+hmt3ENmVCorITGWUz8HjkJ8LQTegZ8vhI2myMzWYrnhq5PDjGkC1oigCFm4PaXhtAwyAMh8sv03LlpGs5GXN7damfVOEB3pT+8nvzcJ4Tt/wXV1bHcVpo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=1VeCfWuvxOkPIzP7Nkziz7p13TLHuFr29nXLqQaeIrA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9FD2B9003E7;
 Mon, 11 Mar 2024 18:11:39 +0800 (CST)
Message-ID: <ebf0670b-82c9-4148-93c2-6ddc4e898306@rock-chips.com>
Date: Mon, 11 Mar 2024 18:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/16] regulator: rk8xx: add indirection level for some
 ldo callbacks
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-4-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-4-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NIHlYfQkkeQ05JGEIZGRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cff1c5503a9kunm9fd2b9003e7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTI6Tyo5FjMPDjAfSUoDNB9L
 TFYKCkJVSlVKTEpLSk5KQktLQ09KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTk9NNwY+
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


On 2024/3/4 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> By passing a rk8xx_reg_info directly to the internal get_value, it'd be
> possible to call this same function with a logic for getting the
> rk8xx_reg_info different from the current get_ldo_reg, e.g. for NLDO and
> PLDO support for RK806.
>
> No logic change is expected.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/regulator/rk8xx.c | 48 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index e905df3a800..212bb752a76 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -780,10 +780,8 @@ static int buck_get_enable(struct udevice *dev)
>   	return _buck_get_enable(dev->parent, buck);
>   }
>   
> -static int ldo_get_value(struct udevice *dev)
> +static int _ldo_get_value(struct udevice *dev, const struct rk8xx_reg_info *info)
>   {
> -	int ldo = dev->driver_data - 1;
> -	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
>   	int mask = info->vsel_mask;
>   	int ret, val;
>   
> @@ -797,10 +795,16 @@ static int ldo_get_value(struct udevice *dev)
>   	return info->min_uv + val * info->step_uv;
>   }
>   
> -static int ldo_set_value(struct udevice *dev, int uvolt)
> +static int ldo_get_value(struct udevice *dev)
>   {
>   	int ldo = dev->driver_data - 1;
> -	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
> +	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
> +
> +	return _ldo_get_value(dev, info);
> +}
> +
> +static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
> +{
>   	int mask = info->vsel_mask;
>   	int val;
>   
> @@ -812,16 +816,22 @@ static int ldo_set_value(struct udevice *dev, int uvolt)
>   	else
>   		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
>   
> -	debug("%s: volt=%d, ldo=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
> -	      __func__, uvolt, ldo + 1, info->vsel_reg, mask, val);
> +	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
> +	      __func__, uvolt, info->vsel_reg, mask, val);
>   
>   	return pmic_clrsetbits(dev->parent, info->vsel_reg, mask, val);
>   }
>   
> -static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
> +static int ldo_set_value(struct udevice *dev, int uvolt)
>   {
>   	int ldo = dev->driver_data - 1;
>   	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
> +
> +	return _ldo_set_value(dev, info, uvolt);
> +}
> +
> +static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
> +{
>   	int mask = info->vsel_mask;
>   	int val;
>   
> @@ -833,16 +843,22 @@ static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
>   	else
>   		val = ((uvolt - info->min_uv) / info->step_uv) + info->min_sel;
>   
> -	debug("%s: volt=%d, ldo=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
> -	      __func__, uvolt, ldo + 1, info->vsel_sleep_reg, mask, val);
> +	debug("%s: volt=%d, reg=0x%x, mask=0x%x, val=0x%x\n",
> +	      __func__, uvolt, info->vsel_sleep_reg, mask, val);
>   
>   	return pmic_clrsetbits(dev->parent, info->vsel_sleep_reg, mask, val);
>   }
>   
> -static int ldo_get_suspend_value(struct udevice *dev)
> +static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
>   {
>   	int ldo = dev->driver_data - 1;
> -	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
> +	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, uvolt);
> +
> +	return _ldo_set_suspend_value(dev->parent, info, uvolt);
> +}
> +
> +static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info)
> +{
>   	int mask = info->vsel_mask;
>   	int val, ret;
>   
> @@ -858,6 +874,14 @@ static int ldo_get_suspend_value(struct udevice *dev)
>   	return info->min_uv + val * info->step_uv;
>   }
>   
> +static int ldo_get_suspend_value(struct udevice *dev)
> +{
> +	int ldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_ldo_reg(dev->parent, ldo, 0);
> +
> +	return _ldo_get_suspend_value(dev->parent, info);
> +}
> +
>   static int ldo_set_enable(struct udevice *dev, bool enable)
>   {
>   	int ldo = dev->driver_data - 1;
>
