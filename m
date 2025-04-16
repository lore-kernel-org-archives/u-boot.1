Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2EDC369AB
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 01:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5ECE82BDC;
	Wed, 16 Apr 2025 03:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="PaM70ijk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531BD82C2B; Wed, 16 Apr 2025 03:14:26 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24BC82BC1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 03:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel.holland@sifive.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d589227978so765275ab.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744766062; x=1745370862; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L3e6B/JqtdZrMe9EU5bSt8c3j3ZDZN+9NOJPragMol8=;
 b=PaM70ijkmXIv4EtztdZ+ogbWWQNaosYcvkNdFs5MxqU2hSqGKOM5Po77OjeEjfr+mV
 9HZ1CZLkCGoYpe9LWAgHnByh8jDcKfjblUNtISAmaewG19BKLtm2AoV2VydrSuBCwTql
 lWxiMm5Ur+baLn1HPNEF8Kc3MNInQF9952AP541Zzj6JPC/ORG8a76tqawMYA7yImHuK
 exPyUpgh23OgsG1xwxoFzMI1dzn74d5Bl8eQ2gTlTmzUQC2Wkhg3LRhVahgtFKnhjlp4
 WTYUYWsefeC8dgQyGLt+V1AgfdwfyNDcA0BbGf4suvYwdPzTvqu0SfolD1fWOFzcZTcI
 HllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744766062; x=1745370862;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L3e6B/JqtdZrMe9EU5bSt8c3j3ZDZN+9NOJPragMol8=;
 b=qpK4Wi6aPYruqck1T2J2KvvbBoSAa4LndWYHM4u3Yxd5IoUY7yUrP9Svlcky4Cxfro
 GOxtsCkYMPIl7mSn6EkOxw7rSxXLBq/XDL4eXFgWc/cfz4RjBjagXmnleTR55hUHidEz
 EsTojVzEEnr7OUMXvpMCgk+waqHhFhWCTANGyBp+3bbgqdQ5rHFXfoLL52tskTo/nhy+
 vUnF6SFIAsu947qYGIWzSnc5XU8vQV4DEfnTNORlESLOS3ZL29lWbt5j3W2TC4an7a9P
 SMZiSx2YGtY1n9l7SeTphk6XD/DoONwL5zhkI0LJJCZTJzNRRnudm6wbGdXh8pgUvRLA
 noRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMzqyjHxKMEQ7N0LbilMhyNbL/ID1VQpj8ConzqKamWCzBBgI5/s8N8QQRG3TG8qGOGjMg6Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6f5rPUlViFtrz4FbiT/ybnXiJoQFCagxu1JxVCFKOHfk8YpVg
 uWkI3wYyRVlbiYvJQKO5ClNXATBhQbe2kdCq+HCJbkTmspzoxd24Nn06PnEb5rk=
X-Gm-Gg: ASbGncsQoLl000A7ykoogyUUHXT5Wtiq2TQnfMJOY0u6Xj3z/zDfA3r8+tvwf/l7PDK
 84cLzCMAEv8DTPOt3lvlR94cSQ7tLlLH2NbLuCthU/rHhxAHmIayCOrpEbtNdbnRKxZ3zYYUhCr
 D9+ePMlxMinI3kTuZaG5Z2YnOJmt4Z2UKU2osdHbBnS4Y9BksijISnAyCbGyR21dBpCbwUaRmSL
 aEIeAzu5XwS5UdYjJpBxpN4ggP8Jc4mlbo8z09ZFpuOzrY9kvPx+m+54J3mKscZ5RLK584H/vW2
 d4OmxywvH1E/Zad6p0gtC3Tx/qtHhID/Ofw=
X-Google-Smtp-Source: AGHT+IGJAAITS69vrs96Pun3NszYPq/VPK/eST+HZ+chkNEyOvfmWq488J2WvV+wqfe4o+4RwYD3Kw==
X-Received: by 2002:a05:6e02:1565:b0:3d4:2acc:81fa with SMTP id
 e9e14a558f8ab-3d8120f9dbamr20337285ab.2.1744766062476; 
 Tue, 15 Apr 2025 18:14:22 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dc591f82sm35225115ab.65.2025.04.15.18.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 18:14:22 -0700 (PDT)
Message-ID: <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
Date: Tue, 15 Apr 2025 20:14:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Miquel,

On 2025-04-03 2:39 AM, Miquel Raynal wrote:
> It is very surprising that such an uclass, specifically designed to
> handle resources that may be shared by different devices, is not keeping
> the count of the number of times a power domain has been
> enabled/disabled to avoid shutting it down unexpectedly or disabling it
> several times.
> 
> Doing this causes troubles on eg. i.MX8MP because disabling power
> domains can be done in recursive loops were the same power domain
> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> timings to respect and it is easy to produce a race condition that puts
> the power domains in an unstable state, leading to ADB400 errors and
> later crashes in Linux.
> 
> CI tests using power domains are slightly updated to make sure the count
> of on/off calls is even and the results match what we *now* expect.
> 
> As we do not want to break existing users while stile getting
> interesting error codes, the implementation is split between:
> - a low-level helper reporting error codes if the requested transition
>   could not be operated,
> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>   EBUSY.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
>  drivers/power/domain/power-domain-uclass.c       | 40 ++++++++++++++--
>  drivers/power/domain/sandbox-power-domain-test.c |  1 +
>  include/power-domain.h                           | 60 ++++++++++++++++++++----
>  test/dm/power-domain.c                           |  2 +-
>  5 files changed, 91 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
> index 96c2922b067e2886b3fa963bcd7e396f4569a569..9f253b0fd40f703a5ec11d34c197423d27ad8b01 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
> @@ -163,4 +163,5 @@ U_BOOT_DRIVER(sandbox_scmi_devices) = {
>  	.priv_auto = sizeof(struct sandbox_scmi_device_priv),
>  	.remove = sandbox_scmi_devices_remove,
>  	.probe = sandbox_scmi_devices_probe,
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
> index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..a6e5f9ed0369eb9d2dfa66edc9e938bac6720dab 100644
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -12,6 +12,10 @@
>  #include <power-domain-uclass.h>
>  #include <dm/device-internal.h>
>  
> +struct power_domain_priv {
> +	int on_count;
> +};
> +
>  static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
>  {
>  	return (struct power_domain_ops *)dev->driver->ops;
> @@ -107,22 +111,49 @@ int power_domain_free(struct power_domain *power_domain)
>  	return ops->rfree ? ops->rfree(power_domain) : 0;
>  }
>  
> -int power_domain_on(struct power_domain *power_domain)
> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>  {
> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
>  	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
> +	int ret;
>  
>  	debug("%s(power_domain=%p)\n", __func__, power_domain);
>  
> -	return ops->on ? ops->on(power_domain) : 0;
> +	if (priv->on_count++ > 0)
> +		return -EALREADY;

This change is broken for power domain providers with #power-domain-cells = <1>,
which can have multiple domains per provider device. There would need to be a
separate reference count per domain, and currently the uclass doesn't know the
range of valid domain IDs.

Regards,
Samuel

> +
> +	ret = ops->on ? ops->on(power_domain) : 0;
> +	if (ret) {
> +		priv->on_count--;
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
> -int power_domain_off(struct power_domain *power_domain)
> +int power_domain_off_lowlevel(struct power_domain *power_domain)
>  {
> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
>  	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
> +	int ret;
>  
>  	debug("%s(power_domain=%p)\n", __func__, power_domain);
>  
> -	return ops->off ? ops->off(power_domain) : 0;
> +	if (priv->on_count <= 0) {
> +		debug("Power domain %s already off.\n", power_domain->dev->name);
> +		return -EALREADY;
> +	}
> +
> +	if (priv->on_count-- > 1)
> +		return -EBUSY;
> +
> +	ret = ops->off ? ops->off(power_domain) : 0;
> +	if (ret) {
> +		priv->on_count++;
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  #if CONFIG_IS_ENABLED(OF_REAL)
> @@ -180,4 +211,5 @@ int dev_power_domain_off(struct udevice *dev)
>  UCLASS_DRIVER(power_domain) = {
>  	.id		= UCLASS_POWER_DOMAIN,
>  	.name		= "power_domain",
> +	.per_device_auto = sizeof(struct power_domain_priv),
>  };
> diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
> index 08c15ef342b3dd3ce01807ee59b7e97337f7dde5..5b530974e942ffcba453e53be330baaf3a113a13 100644
> --- a/drivers/power/domain/sandbox-power-domain-test.c
> +++ b/drivers/power/domain/sandbox-power-domain-test.c
> @@ -51,4 +51,5 @@ U_BOOT_DRIVER(sandbox_power_domain_test) = {
>  	.id = UCLASS_MISC,
>  	.of_match = sandbox_power_domain_test_ids,
>  	.priv_auto	= sizeof(struct sandbox_power_domain_test),
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> diff --git a/include/power-domain.h b/include/power-domain.h
> index 18525073e5e3534fcbac6fae4e18462f29a4dc49..ad33dea76ce5808beaa4fbf4388438a504e36027 100644
> --- a/include/power-domain.h
> +++ b/include/power-domain.h
> @@ -147,37 +147,81 @@ static inline int power_domain_free(struct power_domain *power_domain)
>  #endif
>  
>  /**
> - * power_domain_on - Enable power to a power domain.
> + * power_domain_on_lowlevel - Enable power to a power domain (with refcounting)
>   *
>   * @power_domain:	A power domain struct that was previously successfully
>   *		requested by power_domain_get().
> - * Return: 0 if OK, or a negative error code.
> + * Return: 0 if the transition has been performed correctly,
> + *         -EALREADY if the domain is already on,
> + *         a negative error code otherwise.
>   */
>  #if CONFIG_IS_ENABLED(POWER_DOMAIN)
> -int power_domain_on(struct power_domain *power_domain);
> +int power_domain_on_lowlevel(struct power_domain *power_domain);
>  #else
> -static inline int power_domain_on(struct power_domain *power_domain)
> +static inline int power_domain_on_lowlevel(struct power_domain *power_domain)
>  {
>  	return -ENOSYS;
>  }
>  #endif
>  
>  /**
> - * power_domain_off - Disable power to a power domain.
> + * power_domain_on - Enable power to a power domain (ignores the actual state
> + *		      of the power domain)
>   *
>   * @power_domain:	A power domain struct that was previously successfully
>   *		requested by power_domain_get().
> - * Return: 0 if OK, or a negative error code.
> + * Return: a negative error code upon error during the transition, 0 otherwise.
> + */
> +static inline int power_domain_on(struct power_domain *power_domain)
> +{
> +	int ret;
> +
> +	ret = power_domain_on_lowlevel(power_domain);
> +	if (ret == -EALREADY)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +/**
> + * power_domain_off_lowlevel - Disable power to a power domain (with refcounting)
> + *
> + * @power_domain:	A power domain struct that was previously successfully
> + *		requested by power_domain_get().
> + * Return: 0 if the transition has been performed correctly,
> + *         -EALREADY if the domain is already off,
> + *         -EBUSY if another device is keeping the domain on (but the refcounter
> + *         is decremented),
> + *         a negative error code otherwise.
>   */
>  #if CONFIG_IS_ENABLED(POWER_DOMAIN)
> -int power_domain_off(struct power_domain *power_domain);
> +int power_domain_off_lowlevel(struct power_domain *power_domain);
>  #else
> -static inline int power_domain_off(struct power_domain *power_domain)
> +static inline int power_domain_off_lowlevel(struct power_domain *power_domain)
>  {
>  	return -ENOSYS;
>  }
>  #endif
>  
> +/**
> + * power_domain_off - Disable power to a power domain (ignores the actual state
> + *		      of the power domain)
> + *
> + * @power_domain:	A power domain struct that was previously successfully
> + *		requested by power_domain_get().
> + * Return: a negative error code upon error during the transition, 0 otherwise.
> + */
> +static inline int power_domain_off(struct power_domain *power_domain)
> +{
> +	int ret;
> +
> +	ret = power_domain_off_lowlevel(power_domain);
> +	if (ret == -EALREADY || ret == -EBUSY)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
>  /**
>   * dev_power_domain_on - Enable power domains for a device .
>   *
> diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
> index 896cf5b2ae9d26701150fad70e888f8b135a22b0..8a95f6bdb903be9d1993528d87d5cae0075a83e4 100644
> --- a/test/dm/power-domain.c
> +++ b/test/dm/power-domain.c
> @@ -27,7 +27,7 @@ static int dm_test_power_domain(struct unit_test_state *uts)
>  
>  	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "power-domain-test",
>  					      &dev_test));
> -	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
> +	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
>  						  TEST_POWER_DOMAIN));
>  	ut_assertok(sandbox_power_domain_test_get(dev_test));
>  
> 

