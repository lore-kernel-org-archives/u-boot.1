Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6653CC5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B336C8806B;
	Wed, 28 Feb 2024 12:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qaEaXTfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0976A8806B; Wed, 28 Feb 2024 12:46:14 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD24088074
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SBjska048362;
 Wed, 28 Feb 2024 05:45:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709120754;
 bh=LHFIOlPX+/64iHaUiQvvqff+6+aT6wdJwdw8tEbuL88=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qaEaXTfVP19z3MFW6SJoTz09pci9sWhfJrqMQ4OigpcavJwfag9owa+VXX5qlQcT7
 awx/wLjbWa3Fj6MNNMGD+YAz4Xyh6Td9QJnaHMx5GGSr8t2gSHuZ5NmYseWHlU3Y5i
 W48J8sI415seLoIxGdPL/zgvLt0+i6t7YFHosWz8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SBjsm2002563
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 05:45:54 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 05:45:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 05:45:53 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SBjnE8057781;
 Wed, 28 Feb 2024 05:45:50 -0600
Message-ID: <82141c67-1518-4649-a5e2-24d3f0d63788@ti.com>
Date: Wed, 28 Feb 2024 17:15:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Max Krummenacher
 <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>
References: <20240217122602.3402774-1-danishanwar@ti.com>
 <4af54b6e-d3a9-4de5-81fd-9e7d99ef6331@kernel.org>
 <468bd0ee-cab9-46c3-81ef-16df8347989b@ti.com>
 <a2b480af-abc0-41f9-a230-5420dfd6142b@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <a2b480af-abc0-41f9-a230-5420dfd6142b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 28/02/24 4:12 pm, Roger Quadros wrote:
> 
> 
> On 28/02/2024 12:35, MD Danish Anwar wrote:
>>
>>
>> On 28/02/24 3:30 pm, Roger Quadros wrote:
>>>
>>>
>>> On 17/02/2024 14:26, MD Danish Anwar wrote:
>>>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>>>> same firmware.
>>>>
>>>> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
>>>> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
>>>> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
>>>> load the firmware file to the remote processor and start the remote
>>>> processor.
>>>>
>>>> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
>>>> Kconfig so that we can call request_firmware_into_buf() from remoteproc
>>>> driver.
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>> Changes from v4 to v5:
>>>> *) Added Kconfig option REMOTEPROC_MAX_FW_SIZE to set max firmware size
>>>>    that can be loaded to a rproc.
>>>> *) Added freeing of address in rproc_boot() as pointed out by Ravi.
>>>> *) Allocating the address at a later point in rproc_boot()
>>>> *) Rebased on latest u-boot/master [commit 
>>>>    9e00b6993f724da9699ef12573307afea8c19284]
>>>>
>>>> Changes from v3 to v4:
>>>> *) No functional change. Splitted the patch out of the series as suggested
>>>>    by Nishant.
>>>> *) Droppped the RFC tag.
>>>>
>>>> v4: https://lore.kernel.org/all/20240130063322.2345057-1-danishanwar@ti.com/
>>>> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/
>>>>
>>>>  drivers/remoteproc/Kconfig        |   8 +++
>>>>  drivers/remoteproc/rproc-uclass.c | 100 ++++++++++++++++++++++++++++++
>>>>  include/remoteproc.h              |  34 ++++++++++
>>>>  3 files changed, 142 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>> index 781de530af..759d21437a 100644
>>>> --- a/drivers/remoteproc/Kconfig
>>>> +++ b/drivers/remoteproc/Kconfig
>>>> @@ -10,6 +10,7 @@ menu "Remote Processor drivers"
>>>>  # All users should depend on DM
>>>>  config REMOTEPROC
>>>>  	bool
>>>> +	select FS_LOADER
>>>>  	depends on DM
>>>>  
>>>>  # Please keep the configuration alphabetically sorted.
>>>> @@ -102,4 +103,11 @@ config REMOTEPROC_TI_IPU
>>>>  	help
>>>>  	  Say 'y' here to add support for TI' K3 remoteproc driver.
>>>>  
>>>> +config REMOTEPROC_MAX_FW_SIZE
>>>> +	hex "Maximum size of firmware that needs to be loaded to rproc"
>>>
>>> firmware file?
>>>
>>> /rproc/the remote processor
>>>
>>>> +	default 0x10000
>>>> +	help
>>>> +	  Maximum size of the firmware file (elf, binary) that needs to be
>>>> +	  loaded to th rproc core.
>>>
>>> s/th/the
>>> s/rproc/remote processor
>>>
>>
>> Will fix these typos.
>>
>>>> +
>>>>  endmenu
>>>> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
>>>> index 28b362c887..784361cef9 100644
>>>> --- a/drivers/remoteproc/rproc-uclass.c
>>>> +++ b/drivers/remoteproc/rproc-uclass.c
>>>> @@ -13,6 +13,7 @@
>>>>  #include <log.h>
>>>>  #include <malloc.h>
>>>>  #include <virtio_ring.h>
>>>> +#include <fs_loader.h>
>>>>  #include <remoteproc.h>
>>>>  #include <asm/io.h>
>>>>  #include <dm/device-internal.h>
>>>> @@ -961,3 +962,102 @@ unsigned long rproc_parse_resource_table(struct udevice *dev, struct rproc *cfg)
>>>>  
>>>>  	return 1;
>>>>  }
>>>> +
>>>> +int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>> +{
>>>> +	struct dm_rproc_uclass_pdata *uc_pdata;
>>>> +	int len;
>>>> +	char *p;
>>>> +
>>>> +	if (!rproc_dev || !fw_name)
>>>> +		return -EINVAL;
>>>> +
>>>> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
>>>> +	if (!uc_pdata)
>>>> +		return -EINVAL;
>>>> +
>>>> +	len = strcspn(fw_name, "\n");
>>>> +	if (!len) {
>>>> +		debug("invalid firmware name\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	p = strndup(fw_name, len);
>>>> +	if (!p)
>>>> +		return -ENOMEM;
>>>
>>> Aren't we leaking memory if rproc_set_firmware() is called multiple times?
>>> Can we check if uc_pdata->fw_name exists and free it before the strndup?
>>>
>>
>> Sure, How does the below diff looks to you?
>>
>> diff --git a/drivers/remoteproc/rproc-uclass.c
>> b/drivers/remoteproc/rproc-uclass.c
>> index 784361cef9..f373b64da4 100644
>> --- a/drivers/remoteproc/rproc-uclass.c
>> +++ b/drivers/remoteproc/rproc-uclass.c
>> @@ -982,6 +982,9 @@ int rproc_set_firmware(struct udevice *rproc_dev,
>> const char *fw_name)
>>                 return -EINVAL;
>>         }
>>
>> +       if (uc_pdata->fw_name)
>> +               free(uc_pdata->fw_name);
>> +
>>         p = strndup(fw_name, len);
>>         if (!p)
>>                 return -ENOMEM;
> 
> This is OK. Please see below.
> 
>>
>>
>>>> +
>>>> +	uc_pdata->fw_name = p;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int rproc_boot(struct udevice *rproc_dev)
>>>> +{
>>>> +	struct dm_rproc_uclass_pdata *uc_pdata;
>>>> +	struct udevice *fs_loader;
>>>> +	int core_id, ret = 0;
>>>> +	char *firmware;
>>>> +	void *addr;
>>>> +
>>>> +	if (!rproc_dev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
>>>> +	if (!uc_pdata)
>>>> +		return -EINVAL;
>>>> +
>>>> +	core_id = dev_seq(rproc_dev);
>>>> +	firmware = uc_pdata->fw_name;
>>>> +
>>> unnecessary blank line.
>>>
>>>> +	if (!firmware) {
>>>> +		debug("No firmware set for rproc core %d\n", core_id);
>>>
>>> No firmware name...
>>>
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* Initialize all rproc cores */
>>>> +	if (!rproc_is_initialized()) {
>>>> +		ret = rproc_init();
>>>> +		if (ret) {
>>>> +			debug("rproc_init() failed: %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	/* Loading firmware to a given address */
>>>> +	ret = get_fs_loader(&fs_loader);
>>>> +	if (ret) {
>>>> +		debug("could not get fs loader: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	if (CONFIG_REMOTEPROC_MAX_FW_SIZE) {
>>>
>>> if (defined(CONFIG_REMOTEPROC_MAX_FW_SIZE)) {
>>>
>>
>> sure.
> 
> This I'm not so sure. I think 'defined' can only be used with
> the pre-processor e.g. #if defined()
> But such usage is no longer encouraged.
> 

My first approach was this as well. But this threw the checkpatch
warning so I changed it to if (IS_ENABLED(CONFIG...)). But that was
always returning 0 for hex value. As a result I kept the if condition as,

if (defined(CONFIG_REMOTEPROC_MAX_FW_SIZE))


> e.g.
> Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
> 
> And I'm not sure if IS_ENABLED works for hex options.
> 


No IS_ENABLED doesn't work for hex options. It only works for boolean.
For hex value it will always return 0.

/*
 * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y',
 * 0 otherwise.
 */
#define IS_ENABLED(option)	config_enabled(option, 0)

> If it does not then just keep it the way it was in this patch.
> 

Sure. I will leave it as it is then.

>>
>>>> +		addr = malloc(CONFIG_REMOTEPROC_MAX_FW_SIZE);
>>>> +		if (!addr)
>>>> +			return -ENOMEM;
>>>> +	} else {
>>>> +		debug("CONFIG_REMOTEPROC_MAX_FW_SIZE not defined\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	ret = request_firmware_into_buf(fs_loader, firmware, addr, CONFIG_REMOTEPROC_MAX_FW_SIZE,
>>>> +					0);
>>>> +	if (ret < 0) {
>>>> +		debug("could not request %s: %d\n", firmware, ret);
>>>> +		goto free_buffer;
>>>> +	}
>>>> +
>>>> +	ret = rproc_load(core_id, (ulong)addr, ret);
>>>> +	if (ret) {
>>>> +		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
>>>> +		      uc_pdata->fw_name, core_id, (ulong)addr, ret);
>>>> +		goto free_buffer;
>>>> +	}
>>>> +
>>>> +	ret = rproc_start(core_id);
>>>> +	if (ret)
>>>> +		debug("failed to start rproc core %d\n", core_id);
>>>> +
>>>> +free_buffer:
>>>> +	free(addr);
>>>> +	return ret;
>>>> +}
>>>> diff --git a/include/remoteproc.h b/include/remoteproc.h
>>>> index 91a88791a4..6f8068e149 100644
>>>> --- a/include/remoteproc.h
>>>> +++ b/include/remoteproc.h
>>>> @@ -403,6 +403,7 @@ enum rproc_mem_type {
>>>>   * @name: Platform-specific way of naming the Remote proc
>>>>   * @mem_type: one of 'enum rproc_mem_type'
>>>>   * @driver_plat_data: driver specific platform data that may be needed.
>>>> + * @fw_name: firmware name
>>>>   *
>>>>   * This can be accessed with dev_get_uclass_plat() for any UCLASS_REMOTEPROC
>>>>   * device.
>>>> @@ -412,6 +413,7 @@ struct dm_rproc_uclass_pdata {
>>>>  	const char *name;
>>>>  	enum rproc_mem_type mem_type;
>>>>  	void *driver_plat_data;
>>>> +	char *fw_name;
>>>>  };
>>>>  
>>>>  /**
>>>> @@ -705,6 +707,34 @@ unsigned long rproc_parse_resource_table(struct udevice *dev,
>>>>  struct resource_table *rproc_find_resource_table(struct udevice *dev,
>>>>  						 unsigned int addr,
>>>>  						 int *tablesz);
>>>> +/**
>>>> + * rproc_set_firmware() - assign a new firmware name
>>>> + * @rproc_dev: device for which new firmware name is being assigned
>>>> + * @fw_name: new firmware name to be assigned
>>>> + *
>>>> + * This function allows remoteproc drivers or clients to configure a custom
>>>> + * firmware name. The function does not trigger a remote processor boot,
>>>> + * only sets the firmware name used for a subsequent boot.
>>>> + *
>>>> + * This function sets the fw_name field in uclass pdata of the Remote proc
>>>> + *
>>>> + * Return: 0 on success or a negative value upon failure
>>>> + */
>>>> +int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name);
>>>> +
>>>> +/**
>>>> + * rproc_boot() - boot a remote processor
>>>> + * @rproc_dev: rproc device to boot
>>>> + *
>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>> + *
>>>> + * This function first loads the firmware set in the uclass pdata of Remote
>>>> + * processor to a buffer and then loads firmware to the remote processor
>>>> + * using rproc_load().
>>>> + *
>>>> + * Return: 0 on success, and an appropriate error value otherwise
>>>> + */
>>>> +int rproc_boot(struct udevice *rproc_dev);Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
>>>>  #else
>>>>  static inline int rproc_init(void) { return -ENOSYS; }
>>>>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
>>>> @@ -744,6 +774,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>>>>  					   ulong fw_size, ulong *rsc_addr,
>>>>  					   ulong *rsc_size)
>>>>  { return -ENOSYS; }
>>>> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>> +{ return -ENOSYS; }
>>>> +static inline int rproc_boot(struct udevice *rproc_dev)
>>>> +{ return -ENOSYS; }
>>>>  #endif
>>>>  
>>>>  #endif	/* _RPROC_H_ */
>>>
>>
> 

-- 
Thanks and Regards,
Danish
