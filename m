Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDFE7AD4D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3F78725E;
	Tue,  3 Oct 2023 15:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="J3USMikJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659368725E; Tue,  3 Oct 2023 15:57:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D611F86D7E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c8e=FS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696341446;
 bh=ltL9G0FN3Zyrs9BE8EPuykyvETqgJVTIRocQUcmeAYQ=;
 b=J3USMikJ2hotZJaaEW+ionykRLq18EKMfwSCl500d3XaKbk1bSmS6ZBTHBPQ90tQ3mc0bC4eI
 XGNmjMeALcOCH0ekoFdwhOyIGhbS6VmVK+zSHJwDlVvCzwbkaA+hU9aabsXb9eBVpDz/LdCZEkg
 ixnGHaUclewZ5nTP32jTxKzn4x5lU0+tTVtDO9uGJDou9zWf+yFyjE/pf7k8vdVqevuDspeRy56
 qSGi8FM2OaZXCTNGnCAYNC0M6lDOXk+AzzSMj+UoL1Kha+ZpFSMjs+owWeSV4qUp6C55bqZL5gA
 RKjaXWeDoE/pZkRAWw2zwSLnvXg6XU5AXIR5TkkkwJSA==
Message-ID: <d071dce9-cc08-0998-81e7-f4f06e8f96a5@kwiboo.se>
Date: Tue, 3 Oct 2023 15:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/4] power: regulator: expand basic reference counter
 onto all uclass
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Eugen Hristev
 <eugen.hristev@collabora.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
References: <20231003062126.42026-1-clamor95@gmail.com>
 <20231003062126.42026-2-clamor95@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231003062126.42026-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 651c1dc5b856b1d4dfc17f19
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

On 2023-10-03 08:21, Svyatoslav Ryhel wrote:
> Commit is based on 4fcba5d ("regulator: implement basic reference
> counter") but expands the idea to all regulators instead of just
> fixed/gpio regulators.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  drivers/power/regulator/regulator-uclass.c | 41 ++++++++++++++++++++++
>  drivers/power/regulator/regulator_common.c | 22 ------------
>  drivers/power/regulator/regulator_common.h | 21 -----------
>  include/power/regulator.h                  |  2 ++
>  4 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index d5a79d861c..4b2c6c2964 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -159,6 +159,25 @@ int regulator_get_enable(struct udevice *dev)
>  	return ops->get_enable(dev);
>  }
>  
> +/*
> + * Enable or Disable a regulator
> + *
> + * This is a reentrant function and subsequent calls that enable will
> + * increase an internal counter, and disable calls will decrease the counter.
> + * The actual resource will be enabled when the counter gets to 1 coming from 0,
> + * and disabled when it reaches 0 coming from 1.
> + *
> + * @dev: regulator device
> + * @enable: bool indicating whether to enable or disable the regulator
> + * @return:
> + * 0 on Success
> + * -EBUSY if the regulator cannot be disabled because it's requested by
> + *        another device
> + * -EALREADY if the regulator has already been enabled or has already been
> + *        disabled
> + * -EACCES if there is no possibility to enable/disable the regulator
> + * -ve on different error situation
> + */

Maybe better to replace the existing comment for this function in
include/power/regulator.h ?

Regards,
Jonas

>  int regulator_set_enable(struct udevice *dev, bool enable)
>  {
>  	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
> @@ -172,6 +191,23 @@ int regulator_set_enable(struct udevice *dev, bool enable)
>  	if (!enable && uc_pdata->always_on)
>  		return -EACCES;
>  
> +	/* If previously enabled, increase count */
> +	if (enable && uc_pdata->enable_count > 0) {
> +		uc_pdata->enable_count++;
> +		return -EALREADY;
> +	}
> +
> +	if (!enable) {
> +		if (uc_pdata->enable_count > 1) {
> +			/* If enabled multiple times, decrease count */
> +			uc_pdata->enable_count--;
> +			return -EBUSY;
> +		} else if (!uc_pdata->enable_count) {
> +			/* If already disabled, do nothing */
> +			return -EALREADY;
> +		}
> +	}
> +
>  	if (uc_pdata->ramp_delay)
>  		old_enable = regulator_get_enable(dev);
>  
> @@ -187,6 +223,11 @@ int regulator_set_enable(struct udevice *dev, bool enable)
>  		}
>  	}
>  
> +	if (enable)
> +		uc_pdata->enable_count++;
> +	else
> +		uc_pdata->enable_count--;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index 0116fa01bb..62d06bf616 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -74,23 +74,6 @@ int regulator_common_set_enable(const struct udevice *dev,
>  		return 0;
>  	}
>  
> -	/* If previously enabled, increase count */
> -	if (enable && plat->enable_count > 0) {
> -		plat->enable_count++;
> -		return -EALREADY;
> -	}
> -
> -	if (!enable) {
> -		if (plat->enable_count > 1) {
> -			/* If enabled multiple times, decrease count */
> -			plat->enable_count--;
> -			return -EBUSY;
> -		} else if (!plat->enable_count) {
> -			/* If already disabled, do nothing */
> -			return -EALREADY;
> -		}
> -	}
> -
>  	ret = dm_gpio_set_value(&plat->gpio, enable);
>  	if (ret) {
>  		pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
> @@ -105,10 +88,5 @@ int regulator_common_set_enable(const struct udevice *dev,
>  	if (!enable && plat->off_on_delay_us)
>  		udelay(plat->off_on_delay_us);
>  
> -	if (enable)
> -		plat->enable_count++;
> -	else
> -		plat->enable_count--;
> -
>  	return 0;
>  }
> diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
> index d4962899d8..15f1fa4c93 100644
> --- a/drivers/power/regulator/regulator_common.h
> +++ b/drivers/power/regulator/regulator_common.h
> @@ -13,7 +13,6 @@ struct regulator_common_plat {
>  	struct gpio_desc gpio; /* GPIO for regulator enable control */
>  	unsigned int startup_delay_us;
>  	unsigned int off_on_delay_us;
> -	unsigned int enable_count;
>  };
>  
>  int regulator_common_of_to_plat(struct udevice *dev,
> @@ -21,26 +20,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
>  				char *enable_gpio_name);
>  int regulator_common_get_enable(const struct udevice *dev,
>  	struct regulator_common_plat *plat);
> -/*
> - * Enable or Disable a regulator
> - *
> - * This is a reentrant function and subsequent calls that enable will
> - * increase an internal counter, and disable calls will decrease the counter.
> - * The actual resource will be enabled when the counter gets to 1 coming from 0,
> - * and disabled when it reaches 0 coming from 1.
> - *
> - * @dev: regulator device
> - * @plat: Platform data
> - * @enable: bool indicating whether to enable or disable the regulator
> - * @return:
> - * 0 on Success
> - * -EBUSY if the regulator cannot be disabled because it's requested by
> - *        another device
> - * -EALREADY if the regulator has already been enabled or has already been
> - *        disabled
> - * -EACCES if there is no possibility to enable/disable the regulator
> - * -ve on different error situation
> - */
>  int regulator_common_set_enable(const struct udevice *dev,
>  	struct regulator_common_plat *plat, bool enable);
>  
> diff --git a/include/power/regulator.h b/include/power/regulator.h
> index 200652cb3d..1c7995bd5d 100644
> --- a/include/power/regulator.h
> +++ b/include/power/regulator.h
> @@ -159,6 +159,7 @@ enum regulator_flag {
>   * @name**     - fdt regulator name - should be taken from the device tree
>   * ctrl_reg:   - Control register offset used to enable/disable regulator
>   * volt_reg:   - register offset for writing voltage vsel values
> + * enable_count - counter of enable calls for this regulator
>   *
>   * Note:
>   * *  - set automatically on device probe by the uclass's '.pre_probe' method.
> @@ -185,6 +186,7 @@ struct dm_regulator_uclass_plat {
>  	u8 volt_reg;
>  	bool suspend_on;
>  	u32 suspend_uV;
> +	u32 enable_count;
>  };
>  
>  /* Regulator device operations */

