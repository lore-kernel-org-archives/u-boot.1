Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC3AE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2651586D9E;
	Wed, 27 Sep 2023 04:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iD9RerqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7161A86D9E; Wed, 27 Sep 2023 04:49:27 +0200 (CEST)
Received: from mail-m118112.qiye.163.com (mail-m118112.qiye.163.com
 [115.236.118.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB0686DA7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iD9RerqM2sIk4eiji3anom2JGkGazZU9x3HLf3yB9eVzXrw0/9664zk8EkAoClPoxGDaz8SAq7UZ9pzVSxEZZe2ioBgbPsDQcfcCD1hPoWnM+jPafamY3xfgBNV3wrSMrrih/4RSRtArobrV4szsVgaTb4gCXzhZRaIAbThOVBs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=NToOH+gfsi3gbklTQyRCtuf3p54GQKSL9XBHJNYtCNA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id C16A9400259;
 Wed, 27 Sep 2023 10:49:10 +0800 (CST)
Message-ID: <e49888ef-e5a4-e516-0363-f1f1fec3f751@rock-chips.com>
Date: Wed, 27 Sep 2023 10:49:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] power: regulator: Only run autoset once for each
 regulator
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
 <20230821223020.3918620-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230821223020.3918620-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09JGFYZThhOGUpKQx9OGUpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad48a58472eb3kusnc16a9400259
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6LCo*Kzw#HDZMIzkYGT0P
 KU4KCw9VSlVKTUJOTENJQk5KTktNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTkJPNwY+
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


On 2023/8/22 06:30, Jonas Karlman wrote:
> With the commit 4fcba5d556b4 ("regulator: implement basic reference
> counter"), keeping regulator enablement in balance become more important.
> Calling regulator_autoset multiple times on a fixed regulator increase
> the enable count for each call, resulting in an unbalanced enable count.
>
> Introduce a AUTOSET_DONE flag and use it to mark that autoset has run
> for the regulator. Return -EALREADY on any subsequent call to autoset.
>
> This fixes so that the enable count is only ever increased by one per
> regulator for autoset.
>
> Fixes: 4fcba5d556b4 ("regulator: implement basic reference counter")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
> v2:
> - No change
>
>   drivers/power/regulator/regulator-uclass.c | 18 ++++++++++++++----
>   include/power/regulator.h                  |  1 +
>   2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 3a6ba69f6d5f..77d101f262e2 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -293,6 +293,9 @@ int regulator_autoset(struct udevice *dev)
>   
>   	uc_pdata = dev_get_uclass_plat(dev);
>   
> +	if (uc_pdata->flags & REGULATOR_FLAG_AUTOSET_DONE)
> +		return -EALREADY;
> +
>   	ret = regulator_set_suspend_enable(dev, uc_pdata->suspend_on);
>   	if (ret == -ENOSYS)
>   		ret = 0;
> @@ -306,11 +309,15 @@ int regulator_autoset(struct udevice *dev)
>   			return ret;
>   	}
>   
> -	if (!uc_pdata->always_on && !uc_pdata->boot_on)
> -		return -EMEDIUMTYPE;
> +	if (!uc_pdata->always_on && !uc_pdata->boot_on) {
> +		ret = -EMEDIUMTYPE;
> +		goto out;
> +	}
>   
> -	if (uc_pdata->type == REGULATOR_TYPE_FIXED)
> -		return regulator_set_enable(dev, true);
> +	if (uc_pdata->type == REGULATOR_TYPE_FIXED) {
> +		ret = regulator_set_enable(dev, true);
> +		goto out;
> +	}
>   
>   	if (uc_pdata->flags & REGULATOR_FLAG_AUTOSET_UV)
>   		ret = regulator_set_value(dev, uc_pdata->min_uV);
> @@ -322,6 +329,9 @@ int regulator_autoset(struct udevice *dev)
>   	if (!ret)
>   		ret = regulator_set_enable(dev, true);
>   
> +out:
> +	uc_pdata->flags |= REGULATOR_FLAG_AUTOSET_DONE;
> +
>   	return ret;
>   }
>   
> diff --git a/include/power/regulator.h b/include/power/regulator.h
> index ff1bfc2435ae..200652cb3d7a 100644
> --- a/include/power/regulator.h
> +++ b/include/power/regulator.h
> @@ -134,6 +134,7 @@ struct dm_regulator_mode {
>   enum regulator_flag {
>   	REGULATOR_FLAG_AUTOSET_UV	= 1 << 0,
>   	REGULATOR_FLAG_AUTOSET_UA	= 1 << 1,
> +	REGULATOR_FLAG_AUTOSET_DONE	= 1 << 2,
>   };
>   
>   /**
