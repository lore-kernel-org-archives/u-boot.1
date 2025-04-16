Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEB2C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 08:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67E080FEC;
	Wed, 16 Apr 2025 10:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="liyw6u8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E6981026; Wed, 16 Apr 2025 10:36:29 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4099E8056A
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 10:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G8aCcl258394
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 03:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744792572;
 bh=BaO/d+WcPOL4szrBJjXuM+RuNaBgzYfHiHvwb4FCRMM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=liyw6u8cVrtPZcWJWHHuvMsob3i78lMNEqbvTa1XY/he746WlzRT5dprqF9CwoCwV
 TguOMgf2YsInNuwKPBlVIiCPp8yTTm5Hq3cqzpU6SCw7D/YcbxyiAImGTubA5cQUk4
 apZ3cvpG42ryG27J/aP92hYsPr5t52RdlXKyFHIQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G8aCoA031598
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 03:36:12 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 03:36:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 03:36:11 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G8a6H2014735;
 Wed, 16 Apr 2025 03:36:07 -0500
Message-ID: <c4b1e75d-6304-4bc5-b03c-546c4fe8b260@ti.com>
Date: Wed, 16 Apr 2025 14:06:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Samuel Holland <samuel.holland@sifive.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>
CC: Svyatoslav Ryhel <clamor95@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>, Ian Ray
 <ian.ray@gehealthcare.com>, Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin
 <agust@denx.de>, Fabio Estevm <festevam@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <27af893c-9711-49f8-8aa8-89d7d84eab59@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Samuel

On 16/04/25 06:44, Samuel Holland wrote:
> Hi Miquel,
> 
> On 2025-04-03 2:39 AM, Miquel Raynal wrote:
>> It is very surprising that such an uclass, specifically designed to
>> handle resources that may be shared by different devices, is not keeping
>> the count of the number of times a power domain has been
>> enabled/disabled to avoid shutting it down unexpectedly or disabling it
>> several times.
>>
>> Doing this causes troubles on eg. i.MX8MP because disabling power
>> domains can be done in recursive loops were the same power domain
>> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
>> timings to respect and it is easy to produce a race condition that puts
>> the power domains in an unstable state, leading to ADB400 errors and
>> later crashes in Linux.
>>
>> CI tests using power domains are slightly updated to make sure the count
>> of on/off calls is even and the results match what we *now* expect.
>>
>> As we do not want to break existing users while stile getting
>> interesting error codes, the implementation is split between:
>> - a low-level helper reporting error codes if the requested transition
>>   could not be operated,
>> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>>   EBUSY.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
>>  drivers/power/domain/power-domain-uclass.c       | 40 ++++++++++++++--
>>  drivers/power/domain/sandbox-power-domain-test.c |  1 +
>>  include/power-domain.h                           | 60 ++++++++++++++++++++----
>>  test/dm/power-domain.c                           |  2 +-
>>  5 files changed, 91 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
>> index 96c2922b067e2886b3fa963bcd7e396f4569a569..9f253b0fd40f703a5ec11d34c197423d27ad8b01 100644
>> --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
>> +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
>> @@ -163,4 +163,5 @@ U_BOOT_DRIVER(sandbox_scmi_devices) = {
>>  	.priv_auto = sizeof(struct sandbox_scmi_device_priv),
>>  	.remove = sandbox_scmi_devices_remove,
>>  	.probe = sandbox_scmi_devices_probe,
>> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>  };
>> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
>> index 938bd8cbc9ffd1ba2109d702f886b6a99288d063..a6e5f9ed0369eb9d2dfa66edc9e938bac6720dab 100644
>> --- a/drivers/power/domain/power-domain-uclass.c
>> +++ b/drivers/power/domain/power-domain-uclass.c
>> @@ -12,6 +12,10 @@
>>  #include <power-domain-uclass.h>
>>  #include <dm/device-internal.h>
>>  
>> +struct power_domain_priv {
>> +	int on_count;
>> +};
>> +
>>  static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
>>  {
>>  	return (struct power_domain_ops *)dev->driver->ops;
>> @@ -107,22 +111,49 @@ int power_domain_free(struct power_domain *power_domain)
>>  	return ops->rfree ? ops->rfree(power_domain) : 0;
>>  }
>>  
>> -int power_domain_on(struct power_domain *power_domain)
>> +int power_domain_on_lowlevel(struct power_domain *power_domain)
>>  {
>> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
>>  	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
>> +	int ret;
>>  
>>  	debug("%s(power_domain=%p)\n", __func__, power_domain);
>>  
>> -	return ops->on ? ops->on(power_domain) : 0;
>> +	if (priv->on_count++ > 0)
>> +		return -EALREADY;
> 
> This change is broken for power domain providers with #power-domain-cells = <1>,
> which can have multiple domains per provider device. There would need to be a
> separate reference count per domain, and currently the uclass doesn't know the
> range of valid domain IDs.

I didn't see this reply earlier, would've saved some time debugging to
come to the same conclusion :) but yes this is the reason for breaking.

> 
> Regards,
> Samuel
> 
>> +
>> +	ret = ops->on ? ops->on(power_domain) : 0;
>> +	if (ret) {
>> +		priv->on_count--;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>> -int power_domain_off(struct power_domain *power_domain)
>> +int power_domain_off_lowlevel(struct power_domain *power_domain)
>>  {
>> +	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
>>  	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
>> +	int ret;
>>  
>>  	debug("%s(power_domain=%p)\n", __func__, power_domain);
>>  
>> -	return ops->off ? ops->off(power_domain) : 0;
>> +	if (priv->on_count <= 0) {
>> +		debug("Power domain %s already off.\n", power_domain->dev->name);
>> +		return -EALREADY;
>> +	}
>> +
>> +	if (priv->on_count-- > 1)
>> +		return -EBUSY;
>> +
>> +	ret = ops->off ? ops->off(power_domain) : 0;
>> +	if (ret) {
>> +		priv->on_count++;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>>  #if CONFIG_IS_ENABLED(OF_REAL)
>> @@ -180,4 +211,5 @@ int dev_power_domain_off(struct udevice *dev)
>>  UCLASS_DRIVER(power_domain) = {
>>  	.id		= UCLASS_POWER_DOMAIN,
>>  	.name		= "power_domain",
>> +	.per_device_auto = sizeof(struct power_domain_priv),
>>  };
>> diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
>> index 08c15ef342b3dd3ce01807ee59b7e97337f7dde5..5b530974e942ffcba453e53be330baaf3a113a13 100644
>> --- a/drivers/power/domain/sandbox-power-domain-test.c
>> +++ b/drivers/power/domain/sandbox-power-domain-test.c
>> @@ -51,4 +51,5 @@ U_BOOT_DRIVER(sandbox_power_domain_test) = {
>>  	.id = UCLASS_MISC,
>>  	.of_match = sandbox_power_domain_test_ids,
>>  	.priv_auto	= sizeof(struct sandbox_power_domain_test),
>> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>  };
>> diff --git a/include/power-domain.h b/include/power-domain.h
>> index 18525073e5e3534fcbac6fae4e18462f29a4dc49..ad33dea76ce5808beaa4fbf4388438a504e36027 100644
>> --- a/include/power-domain.h
>> +++ b/include/power-domain.h
>> @@ -147,37 +147,81 @@ static inline int power_domain_free(struct power_domain *power_domain)
>>  #endif
>>  
>>  /**
>> - * power_domain_on - Enable power to a power domain.
>> + * power_domain_on_lowlevel - Enable power to a power domain (with refcounting)
>>   *
>>   * @power_domain:	A power domain struct that was previously successfully
>>   *		requested by power_domain_get().
>> - * Return: 0 if OK, or a negative error code.
>> + * Return: 0 if the transition has been performed correctly,
>> + *         -EALREADY if the domain is already on,
>> + *         a negative error code otherwise.
>>   */
>>  #if CONFIG_IS_ENABLED(POWER_DOMAIN)
>> -int power_domain_on(struct power_domain *power_domain);
>> +int power_domain_on_lowlevel(struct power_domain *power_domain);
>>  #else
>> -static inline int power_domain_on(struct power_domain *power_domain)
>> +static inline int power_domain_on_lowlevel(struct power_domain *power_domain)
>>  {
>>  	return -ENOSYS;
>>  }
>>  #endif
>>  
>>  /**
>> - * power_domain_off - Disable power to a power domain.
>> + * power_domain_on - Enable power to a power domain (ignores the actual state
>> + *		      of the power domain)
>>   *
>>   * @power_domain:	A power domain struct that was previously successfully
>>   *		requested by power_domain_get().
>> - * Return: 0 if OK, or a negative error code.
>> + * Return: a negative error code upon error during the transition, 0 otherwise.
>> + */
>> +static inline int power_domain_on(struct power_domain *power_domain)
>> +{
>> +	int ret;
>> +
>> +	ret = power_domain_on_lowlevel(power_domain);
>> +	if (ret == -EALREADY)
>> +		ret = 0;
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * power_domain_off_lowlevel - Disable power to a power domain (with refcounting)
>> + *
>> + * @power_domain:	A power domain struct that was previously successfully
>> + *		requested by power_domain_get().
>> + * Return: 0 if the transition has been performed correctly,
>> + *         -EALREADY if the domain is already off,
>> + *         -EBUSY if another device is keeping the domain on (but the refcounter
>> + *         is decremented),
>> + *         a negative error code otherwise.
>>   */
>>  #if CONFIG_IS_ENABLED(POWER_DOMAIN)
>> -int power_domain_off(struct power_domain *power_domain);
>> +int power_domain_off_lowlevel(struct power_domain *power_domain);
>>  #else
>> -static inline int power_domain_off(struct power_domain *power_domain)
>> +static inline int power_domain_off_lowlevel(struct power_domain *power_domain)
>>  {
>>  	return -ENOSYS;
>>  }
>>  #endif
>>  
>> +/**
>> + * power_domain_off - Disable power to a power domain (ignores the actual state
>> + *		      of the power domain)
>> + *
>> + * @power_domain:	A power domain struct that was previously successfully
>> + *		requested by power_domain_get().
>> + * Return: a negative error code upon error during the transition, 0 otherwise.
>> + */
>> +static inline int power_domain_off(struct power_domain *power_domain)
>> +{
>> +	int ret;
>> +
>> +	ret = power_domain_off_lowlevel(power_domain);
>> +	if (ret == -EALREADY || ret == -EBUSY)
>> +		ret = 0;
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * dev_power_domain_on - Enable power domains for a device .
>>   *
>> diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
>> index 896cf5b2ae9d26701150fad70e888f8b135a22b0..8a95f6bdb903be9d1993528d87d5cae0075a83e4 100644
>> --- a/test/dm/power-domain.c
>> +++ b/test/dm/power-domain.c
>> @@ -27,7 +27,7 @@ static int dm_test_power_domain(struct unit_test_state *uts)
>>  
>>  	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "power-domain-test",
>>  					      &dev_test));
>> -	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
>> +	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
>>  						  TEST_POWER_DOMAIN));
>>  	ut_assertok(sandbox_power_domain_test_get(dev_test));
>>  
>>
> 

-- 
Thanking You
Neha Malcom Francis
