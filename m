Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B079C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3BA888313;
	Fri,  3 May 2024 18:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N7DTYT7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A24C8832A; Fri,  3 May 2024 18:10:39 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48B2882F6
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-571be483ccaso9323963a12.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714752636; x=1715357436; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XkKbmgnLmb223n5fD9wngy3wxboF9qqHMKAocqU2heU=;
 b=N7DTYT7j7yiITgeGg0yxNoGNC0ZepNwJPUhO5I54hT6gpI1SN3GweqbchJFxwf56YJ
 Lhxdpbt1pjOCxDCb1yOq8GHzmIXrxXyC+kWj9tIamceJssmOGQUl+7QDkWC2Z81ruNuy
 8GqSpyFppGc7pConbqgX7pns5d30ca7j5KSCL7yIZmo+Y7w3LllgnlXRB0dHW33hUYcx
 TD1TiHzlVgSHi1W9oCAkomI2UXxup6evSgP+4YJ+1OLuLWmjnd+dRNphEcxBucXpZk7w
 JV1BTsTUgvMo5po15jih5j/mEaog8HK+5vNF/CmhfvKqx6lkLH+9Itt7mg6F2I5BQ+FS
 1PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714752636; x=1715357436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XkKbmgnLmb223n5fD9wngy3wxboF9qqHMKAocqU2heU=;
 b=lYUJMspbZwfFvZJSF4Rv2HbZGQ5BmdM4zpwbNgvp5lRNCaNg7GhGYK2Gg3HbBfb3OQ
 ST53EWbvTrV6T1rreAk70a4E/ssu9M3HzeqklrmVIIVFcMCvBG6XIn2eV+wxzOjHDNdW
 yJTEklFiMZZ5l0bvnylge5nb+hMsFuMol+qpNZqhzVOddm63lgFG/ikRVElEUKf0IAEc
 A+2IX2UdTPYcqAeVAGOwEZGVUPrSloSBOgIfmjME95kHYEttaKkVCYFiQveb78V4NpU4
 1CugOS9CN6EECvgY7o9qUP4aUHF8Wo8aD98P0bpu7pGKKEt97gGTdlu7qbz8E8pEuiKu
 D/eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU35VHq7ZN73zlZn7G8unrKDm/9KwU3QK+Wo77tOZBPJrtNnVGkjCvhCR0N1n8LQtqAgdw4GMUtS2mTKO0Z3YfWSUo2iA==
X-Gm-Message-State: AOJu0YzK92u5zAUGbGizIgEvyQ207awbeMusmD6su4/AETuQMdGZnrIl
 bvRMAZspf9K7lKfJBVXzhS03CslkyI5mQRk/Ebl9oMzCMtzN7nrvG7cnS04Q7Ak=
X-Google-Smtp-Source: AGHT+IHtMgitlxO89hDOlepVOlUN96kLC/i/ka7rLzR6Rq+M2IuaEhXvDAnko7aRgQnHuvL6yj7hpQ==
X-Received: by 2002:a50:d691:0:b0:56e:22b6:d924 with SMTP id
 r17-20020a50d691000000b0056e22b6d924mr1845496edi.13.1714752636203; 
 Fri, 03 May 2024 09:10:36 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::11db? ([2a02:8109:aa0d:be00::11db])
 by smtp.gmail.com with ESMTPSA id
 s8-20020aa7d788000000b00562d908daf4sm1796328edq.84.2024.05.03.09.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 09:10:35 -0700 (PDT)
Message-ID: <b175c238-deb2-4560-8579-34f5d269bbcf@linaro.org>
Date: Fri, 3 May 2024 18:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dm: core: add support for fallback drivers
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
 <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
 <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 10/04/2024 19:27, Heinrich Schuchardt wrote:
> 
> 
> Am 10. April 2024 19:06:57 MESZ schrieb Caleb Connolly <caleb.connolly@linaro.org>:
>> Introduce support for a uclass to provide a fallback/stub driver which
>> can be used when no device is found for a given node. This might be
>> useful for handling non-essential clock controllers like the RPMh on
>> Qualcomm platforms, or during early bringup to get UART output before a
>> real clock driver has been created.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> drivers/core/Kconfig  | 10 ++++++++++
>> drivers/core/uclass.c | 24 +++++++++++++++++++++++-
>> include/dm/uclass.h   |  3 +++
>> 3 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>> index 1081d61fcf01..09075b9b7a15 100644
>> --- a/drivers/core/Kconfig
>> +++ b/drivers/core/Kconfig
>> @@ -466,5 +466,15 @@ config BOUNCE_BUFFER
>>
>> 	  A second possible use of bounce buffers is their ability to
>> 	  provide aligned buffers for DMA operations.
>>
>> +menuconfig FALLBACK_DRIVERS
> 
> Wouldn't it be preferable to mark individual drivers as fallback drivers in their declaration?
> 
> This would allow alternative fallback drivers and would not require any definitions at uclass level.

I don't see an obvious usecase for having multiple stub drivers for a 
given uclass. Maybe as a result of that, I have no idea how we'd go 
about choosing which stub to use if multiple were available.

I don't think it would be particularly hard to switch over if at some 
point in the future we have such a need, but I don't see a benefit to 
this added complexity now.
> 
> Just by building a fallback driver you would enable the fallback behavior for its uclass.

I could drop the CONFIG_FALLBACK_DRIVERS option, it's just there to make 
it possible to opt in/out of all stub drivers at once, but maybe this 
isn't very useful.

Kind Regards,
> 
> Best regards
> 
> Heinrich
> 
>> +	bool "Enable per-uclass fallback drivers"
>> +	depends on DM
>> +	help
>> +	  If a driver requests a resource (like a clock) from a node which
>> +	  isn't bound to a driver, the driver model will look for a fallback
>> +	  driver to "stub" the resource. These stubs usually do nothing and
>> +	  are therefore only suitable in instances where the resource is not
>> +	  required.
>> +
>> endmenu
>> diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
>> index e46d5717aa62..91d3a48d77b8 100644
>> --- a/drivers/core/uclass.c
>> +++ b/drivers/core/uclass.c
>> @@ -378,8 +378,26 @@ int uclass_find_device_by_of_offset(enum uclass_id id, int node,
>>
>> 	return -ENODEV;
>> }
>>
>> +static int uclass_bind_fallback(struct uclass *uc, ofnode node, struct udevice **devp)
>> +{
>> +	struct driver *drv;
>> +
>> +	log(LOGC_DM, LOGL_ERR, "   - binding fallback '%s' driver '%s'\n",
>> +	    uc->uc_drv->name, uc->uc_drv->fallback_drv_name);
>> +
>> +	drv = lists_driver_lookup_name(uc->uc_drv->fallback_drv_name);
>> +	if (!drv) {
>> +		log(LOGC_DM, LOGL_DEBUG, "   - Can't find stub driver '%s' for uclass '%s'\n",
>> +		    uc->uc_drv->fallback_drv_name, uc->uc_drv->name);
>> +		return -ENOENT;
>> +	}
>> +
>> +	return device_bind_with_driver_data(gd->dm_root, drv,
>> +					  ofnode_get_name(node), 0, node, devp);
>> +}
>> +
>> int uclass_find_device_by_ofnode(enum uclass_id id, ofnode node,
>> 				 struct udevice **devp)
>> {
>> 	struct uclass *uc;
>> @@ -401,9 +419,13 @@ int uclass_find_device_by_ofnode(enum uclass_id id, ofnode node,
>> 			*devp = dev;
>> 			goto done;
>> 		}
>> 	}
>> -	ret = -ENODEV;
>> +
>> +	if (CONFIG_IS_ENABLED(FALLBACK_DRIVERS) && uc->uc_drv->fallback_drv_name)
>> +		ret = uclass_bind_fallback(uc, node, devp);
>> +	else
>> +		ret = -ENODEV;
>>
>> done:
>> 	log(LOGC_DM, LOGL_DEBUG, "   - result for %s: %s (ret=%d)\n",
>> 	    ofnode_get_name(node), *devp ? (*devp)->name : "(none)", ret);
>> diff --git a/include/dm/uclass.h b/include/dm/uclass.h
>> index 456eef7f2f31..b99e36485bc5 100644
>> --- a/include/dm/uclass.h
>> +++ b/include/dm/uclass.h
>> @@ -67,8 +67,10 @@ struct udevice;
>>   * @child_pre_probe: Called before a child in this uclass is probed
>>   * @child_post_probe: Called after a child in this uclass is probed
>>   * @init: Called to set up the uclass
>>   * @destroy: Called to destroy the uclass
>> + * @stub_drv_name: Name of a stub driver to use for devices that are not
>> + * supported by any other driver.
>>   * @priv_auto: If non-zero this is the size of the private data
>>   * to be allocated in the uclass's ->priv pointer. If zero, then the uclass
>>   * driver is responsible for allocating any data required.
>>   * @per_device_auto: Each device can hold private data owned
>> @@ -98,8 +100,9 @@ struct uclass_driver {
>> 	int (*child_pre_probe)(struct udevice *dev);
>> 	int (*child_post_probe)(struct udevice *dev);
>> 	int (*init)(struct uclass *class);
>> 	int (*destroy)(struct uclass *class);
>> +	const char *fallback_drv_name;
>> 	int priv_auto;
>> 	int per_device_auto;
>> 	int per_device_plat_auto;
>> 	int per_child_auto;
>>
> 

-- 
// Caleb (they/them)
