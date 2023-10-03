Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AD0E7AD56
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 14:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A8986E34;
	Tue,  3 Oct 2023 16:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="X5IIhttE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A69A86E3B; Tue,  3 Oct 2023 16:06:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABE786E23
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 16:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c8e=FS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696341964;
 bh=4qSkRveuzjPc1EWNJz2bd3iyF+8gP74+1bviCH1iJy4=;
 b=X5IIhttEthPakWV3ljrEoK499KvgyLJiV+bPRv4BhfXuxBjO2CcgifwdR/Qxr6wusqGz8BnTS
 yS2ePVcLFMPLH/Z19LWhwhTlQ5DaH1UOV0AM0q0mB7FBK1oNktqTlSxOmln683R6wECDW+m0pBh
 /DRxkoVWx0aKqKzBYp7RMEr8I54p2TKwuwGwMispRRuRuQwI/FBtyr2hJp8Qh+T9tmhYvKgq/1r
 jA4P26HA1T6/5tPNC7fWB0RsmEdDmMRmtEJ3DvVVDe/fTs1ZqXey/itWDewFK9hpge+3OrV5iRM
 mtCMPiHEgGHcSvlFDazSLuHm855Pj+hwSBQLpcdCHdeA==
Message-ID: <d0d9508c-e181-040b-946c-308d8500528b@kwiboo.se>
Date: Tue, 3 Oct 2023 16:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 3/4] power: regulator: Perform regulator setup inside
 uclass
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Eugen Hristev
 <eugen.hristev@collabora.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
References: <20231003062126.42026-1-clamor95@gmail.com>
 <20231003062126.42026-4-clamor95@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231003062126.42026-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 651c1fcb83e069af5ee471ff
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
> Regulators initial setup was previously dependent on board call.
> To move from this behaviour next solution is proposed: on post_bind
> boot-on/always-on properties are checked, all regulators with
> such props will be probed just after binding which ensures that
> essential regulators are set, then in the post probe regulator
> autoset is called so that correct regulator state according to
> device tree is reached.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> [jonas@kwiboo.se: use autoset func, only probe with always/boot-on prop]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/power/regulator/regulator-uclass.c | 30 ++++++++++++++++++----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 4b2c6c2964..69d6d6428d 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -473,6 +473,7 @@ static int regulator_post_bind(struct udevice *dev)
>  {
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	const char *property = "regulator-name";
> +	int ret;
>  
>  	uc_pdata = dev_get_uclass_plat(dev);
>  
> @@ -486,13 +487,20 @@ static int regulator_post_bind(struct udevice *dev)
>  			return -EINVAL;
>  	}
>  
> -	if (regulator_name_is_unique(dev, uc_pdata->name))
> -		return 0;
> +	ret = regulator_name_is_unique(dev, uc_pdata->name);
> +	if (!ret) {
> +		debug("'%s' of dev: '%s', has nonunique value: '%s'\n",
> +		      property, dev->name, uc_pdata->name);
> +		return -EINVAL;
> +	}
>  
> -	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> -	      property, dev->name, uc_pdata->name);
> +	uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> +	uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>  
> -	return -EINVAL;
> +	if (uc_pdata->always_on || uc_pdata->boot_on)
> +		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
> +	return 0;
>  }
>  
>  static int regulator_pre_probe(struct udevice *dev)
> @@ -546,6 +554,17 @@ static int regulator_pre_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int regulator_post_probe(struct udevice *dev)
> +{
> +	int ret;
> +
> +	ret = regulator_autoset(dev);
> +	if (ret == -EMEDIUMTYPE || ret == -ENOSYS)

Would be good to also check for || ret == -EALREADY here.

Following pending patch extend regulator_autoset to also return
-EALREADY when it has already been called for a regulator.

power: regulator: Only run autoset once for each regulator
https://patchwork.ozlabs.org/patch/1823770/

Regards,
Jonas

> +		return 0;
> +
> +	return ret;
> +}
> +
>  int regulators_enable_boot_on(bool verbose)
>  {
>  	struct udevice *dev;
> @@ -603,5 +622,6 @@ UCLASS_DRIVER(regulator) = {
>  	.name		= "regulator",
>  	.post_bind	= regulator_post_bind,
>  	.pre_probe	= regulator_pre_probe,
> +	.post_probe	= regulator_post_probe,
>  	.per_device_plat_auto	= sizeof(struct dm_regulator_uclass_plat),
>  };

