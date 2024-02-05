Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E2DC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 10:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057288777F;
	Mon,  5 Feb 2024 11:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dHNqv9a8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1914B8657F; Mon,  5 Feb 2024 11:20:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E1187811
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 11:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415AKRx1129425;
 Mon, 5 Feb 2024 04:20:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707128427;
 bh=vJeYNy0aJ75sJAglxz3UySDGCyFmMp1S0Zokze0wT3c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dHNqv9a8LrgoLCPubxspJ23TMhTxug+szEYqDvzTRYKrmPEttw51W7b8dvlaUMm/J
 WGPCijmsKDbPu2DJi4le/qPi727PH8pPNYytyLKaxOZpXb+WdZ0A99WektyvXkuOOD
 i2863nAZc4rSb/uac7cgxMY/7wXErCiWJiTwPSX0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415AKRsj017201
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Feb 2024 04:20:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 04:20:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 04:20:27 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415AKMP4120481;
 Mon, 5 Feb 2024 04:20:23 -0600
Message-ID: <c042c7a5-1561-4efb-b7c4-461bda1f6c36@ti.com>
Date: Mon, 5 Feb 2024 15:50:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>
References: <20240130063322.2345057-1-danishanwar@ti.com>
 <e72403f9-a0aa-4286-97d2-456735fd3aac@kernel.org>
 <8bc580b4-5faf-48f4-9d68-052fb9e114e8@ti.com>
 <d0b4530d-b12a-4b2c-8171-35ca003d4234@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <d0b4530d-b12a-4b2c-8171-35ca003d4234@kernel.org>
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



On 05/02/24 3:36 pm, Roger Quadros wrote:
> 
> 
> On 02/02/2024 18:40, Anwar, Md Danish wrote:
>> Hi Roger,
>>
>> On 2/2/2024 4:49 PM, Roger Quadros wrote:
>>>
>>>
>>> On 30/01/2024 08:33, MD Danish Anwar wrote:
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
>>>> Changes from v3 to v4:
>>>> *) No functional change. Splitted the patch out of the series as suggested
>>>>    by Nishant.
>>>> *) Droppped the RFC tag.
>>>>
>>>> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/
>>>>
>>>>  drivers/remoteproc/Kconfig        |  1 +
>>>>  drivers/remoteproc/rproc-uclass.c | 85 +++++++++++++++++++++++++++++++
>>>>  include/remoteproc.h              | 35 +++++++++++++
>>>>  3 files changed, 121 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>> index 781de530af..0fdf1b38ea 100644
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
>>>> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
>>>> index 28b362c887..76db4157f7 100644
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
>>>> @@ -961,3 +962,87 @@ unsigned long rproc_parse_resource_table(struct udevice *dev, struct rproc *cfg)
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
>>>
>>> This can return NULL and you shuould error out if it does.
>>>
>>
>> Sure.
>>
>>>> +
>>>> +	len = strcspn(fw_name, "\n");
>>>> +	if (!len) {
>>>> +		debug("can't provide empty string for firmware name\n");
>>>
>>> how about "invalid filename" ?
>>>
>>
>> Sure.
>>
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	p = strndup(fw_name, len);
>>>> +	if (!p)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	uc_pdata->fw_name = p;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>> +{
>>>> +	struct dm_rproc_uclass_pdata *uc_pdata;
>>>> +	struct udevice *fs_loader;
>>>> +	void *addr = malloc(fw_size);
>>>
>>> I will suggest to do malloc just before you need the buffer.
>>> You need to free up the buffer an all return paths after that.
>>>
>>
>> That is correct. I will do malloc just before calling
>> request_firmware_into_buf() API.
>>
>>>> +	int core_id, ret = 0;
>>>> +	char *firmware;
>>>> +	ulong rproc_addr;
>>>
>>> do you really need rproc_addr? You could use addr itself.
>>>
>>
>> Sure.
>>
>>>> +
>>>> +	if (!rproc_dev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!addr)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
>>>> +	core_id = dev_seq(rproc_dev);
>>>> +	firmware = uc_pdata->fw_name;
>>>> +
>>>> +	if (!firmware) {
>>>> +		debug("No firmware set for rproc core %d\n", core_id);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* Initialize all rproc cores */
>>>> +	rproc_init();
>>>
>>> 	if (!rproc_is_initialized()) {
>>> 		ret = rproc_init()
>>> 		if (ret) {
>>> 			debug("rproc_init() failed: %d\n", ret);
>>> 			return ret;
>>> 		}
>>> 	}
>>>
>>
>> Sure.
>>
>>>> +
>>>> +	/* Loading firmware to a given address */
>>>> +	ret = get_fs_loader(&fs_loader);
>>>> +	if (ret) {
>>>> +		debug("could not get fs loader: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = request_firmware_into_buf(fs_loader, firmware, addr, fw_size, 0);
>>>> +	if (ret < 0) {
>>>> +		debug("could not request %s: %d\n", firmware, ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	rproc_addr = (ulong)addr;
>>>> +
>>>> +	ret = rproc_load(core_id, rproc_addr, ret);
>>>
>>> ret = rproc_load(coare_id, (ulong)addr, ret);
>>>
>>>> +	if (ret) {
>>>> +		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
>>>> +		      uc_pdata->fw_name, core_id, rproc_addr, ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = rproc_start(core_id);
>>>> +	if (ret) {
>>>> +		debug("failed to start rproc core %d\n", core_id);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>
>>> return 0;
>>>
>>>> +}
>>>> diff --git a/include/remoteproc.h b/include/remoteproc.h
>>>> index 91a88791a4..e53f85ba51 100644
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
>>>> @@ -705,6 +707,35 @@ unsigned long rproc_parse_resource_table(struct udevice *dev,
>>>>  struct resource_table *rproc_find_resource_table(struct udevice *dev,
>>>>  						 unsigned int addr,
>>>>  						 int *tablesz);
>>>> +/**
>>>> + * rproc_set_firmware() - assign a new firmware
>>>
>>> firmware/firmware name.
>>>
>>>> + * @rproc_dev: device for wich new firmware is being assigned
>>>
>>> firmware/firmware name
>>> wich/which
>>>
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
>>>> + * @fw_size: Size of the memory to allocate for firmeware
>>>
>>> firmeware/firmware
>>>
>>
>> I'll fix all these typos.
>>
>>> How does caller know what firmware size to set to?
>>> This should already be private to the rproc as it knows 
>>> how large is its program memory.
>>>
>>
>> Caller is trying to boot the rproc with a firmware binary. Caller should
>> know the size of binary that it wants to load to rproc core. Caller will
>> specify the binary size to rproc_boot(). Based on the size provided by
>> caller, rproc_boot() will then allocate that much memory and call
>> request_firmware_into_buf() with the size and allocated buffer. If the
>> caller doesn't provide minimum size rproc_load() will fail.
> 
> Caller only knows the filename. It need not know more details.

Caller is trying to load a file of it's choice to a rproc. Caller should
know the size of file it is trying to load or atleast the max size that
the firmware file could be of.


> Also see my comment below about rproc_boot() API.
> 
>>
>> rproc_load() calls respective driver ops, for example: pru_load().
>> pru_load() [1] API checks the required size of firmware to load by
>> casting the buffer into Elf32_Ehdr and Elf32_Phdr and returns error if
>> size provided by caller is less than this.
>>
>>
>> 	if (offset + filesz > size) {
>> 		dev_dbg(dev, "truncated fw: need 0x%x avail 0x%zx\n",
>> 			offset + filesz, size);
>> 		ret = -EINVAL;
>> 		break;
>> 	}
>>
>>>> + *
>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>> + *
>>>> + * This function first loads the firmware set in the uclass pdata of Remote
>>>> + * processor to a buffer and then loads firmware to the remote processor
>>>> + * using rproc_load().
>>>> + *
>>>> + * Return: 0 on success, and an appropriate error value otherwise
>>>> + */
>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
>>>
>>> Was wondering if you need separate API for rproc_set_firmware or we can just
>>> pass firmware name as argument to rproc_boot()?
>>>
>>
>> Technically we can. But when we discussed this approach first in v1, you
>> had asked to keep the APIs similar to upstream linux. Upstream linux has
>> these two APIs so I kept it that way. If you want I can drop the first
>> API. Please let me know.
> 
> Sure you can keep it as it is in Linux, but there, rproc_boot doesn't
> take fw_size argument. So wondering why you should have it in u-boot.
> 

For loading firmware to a rproc core in u-boot, it's first neccassry to
load the firmware into buffer and then load that buffer into rproc core
using rproc_load() API. Now to load the firmware to a buffer ther is an
API request_firmware_into_buf(). This API takes size of firmware as one
of it's argument. So in order to call this API from rproc_boot() we need
to pass fw_size to rproc_boot()

Other u-boot drivers using request_firmware_into_buf() are also passing
size of firmware from their driver.

If rproc_boot() doesn't take fw_size as argument then within
rproc_boot() we need to figure out the fw_size before calling
request_firmware_into_buf().

If we don't know the size / maximum size of the firmware to load, how
will we call request_firmware_into_buf(). Someone has to tell
request_firmware_into_buf() the size of firmware. I am expecting that to
be the caller. Do you have any other way of getting the firmware size
before request_firmware_into_buf() is called?

>>
>>>>  #else
>>>>  static inline int rproc_init(void) { return -ENOSYS; }
>>>>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
>>>> @@ -744,6 +775,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>>>>  					   ulong fw_size, ulong *rsc_addr,
>>>>  					   ulong *rsc_size)
>>>>  { return -ENOSYS; }
>>>> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>> +{ return -ENOSYS; }
>>>> +static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>> +{ return -ENOSYS; }
>>>>  #endif
>>>>  
>>>>  #endif	/* _RPROC_H_ */
>>>
>>
>> [1]
>> https://elixir.bootlin.com/u-boot/latest/source/drivers/remoteproc/pru_rproc.c#L324
>>
> 

-- 
Thanks and Regards,
Danish
