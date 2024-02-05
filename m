Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE40C48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 12:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F22587811;
	Mon,  5 Feb 2024 13:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vf4m5Sqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0918A8785A; Mon,  5 Feb 2024 13:37:29 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38380877CB
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 13:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7DE32CE0E6A;
 Mon,  5 Feb 2024 12:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D72AC433F1;
 Mon,  5 Feb 2024 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707136642;
 bh=jvsDQWGPAH6pr2NcrhIycTsuJxJ/9m1gF0SbIN1AAZU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Vf4m5SqngphjnrLLGwDVwkM0HozGHhDRHIH9mD3Mi5UnspUGuMd/8GoObHQ23PadU
 XfH69aYVCbSOKPFxj+U0izhTJHQSmWKFMl6IGfUFxBSWUNTo+sxOF6mqZWN2X4eLDM
 bDGlIcRFtRHhFtsNQPk/xIeMAHqfvam8D/5gGmLA1qSNcL2GxfGrJp02mYHw5ep2jp
 Ej7L9mBHaHsLkJwDXm/noKVBMCKz9+Z7Df+enwNcQnY9IxiNv+HfegoEJdSBTmMXGR
 Ljeuo1lBqoMw6Ff7SiW2IsjOwXNhLqL5cLAwg71nx6DSrc3LZSQ2ckpCDOEaRqNJaa
 194eViRNrOAyA==
Message-ID: <1646d8b2-7e0d-4716-956f-41b6f61f8626@kernel.org>
Date: Mon, 5 Feb 2024 14:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, "Anwar, Md Danish"
 <a0501179@ti.com>, Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com
References: <20240130063322.2345057-1-danishanwar@ti.com>
 <e72403f9-a0aa-4286-97d2-456735fd3aac@kernel.org>
 <8bc580b4-5faf-48f4-9d68-052fb9e114e8@ti.com>
 <d0b4530d-b12a-4b2c-8171-35ca003d4234@kernel.org>
 <c042c7a5-1561-4efb-b7c4-461bda1f6c36@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c042c7a5-1561-4efb-b7c4-461bda1f6c36@ti.com>
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



On 05/02/2024 12:20, MD Danish Anwar wrote:
> 
> 
> On 05/02/24 3:36 pm, Roger Quadros wrote:
>>
>>
>> On 02/02/2024 18:40, Anwar, Md Danish wrote:
>>> Hi Roger,
>>>
>>> On 2/2/2024 4:49 PM, Roger Quadros wrote:
>>>>
>>>>
>>>> On 30/01/2024 08:33, MD Danish Anwar wrote:
>>>>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>>>>> same firmware.
>>>>>
>>>>> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
>>>>> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
>>>>> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
>>>>> load the firmware file to the remote processor and start the remote
>>>>> processor.
>>>>>
>>>>> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
>>>>> Kconfig so that we can call request_firmware_into_buf() from remoteproc
>>>>> driver.
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>> Changes from v3 to v4:
>>>>> *) No functional change. Splitted the patch out of the series as suggested
>>>>>    by Nishant.
>>>>> *) Droppped the RFC tag.
>>>>>
>>>>> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/
>>>>>
>>>>>  drivers/remoteproc/Kconfig        |  1 +
>>>>>  drivers/remoteproc/rproc-uclass.c | 85 +++++++++++++++++++++++++++++++
>>>>>  include/remoteproc.h              | 35 +++++++++++++
>>>>>  3 files changed, 121 insertions(+)
>>>>>
>>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>>> index 781de530af..0fdf1b38ea 100644
>>>>> --- a/drivers/remoteproc/Kconfig
>>>>> +++ b/drivers/remoteproc/Kconfig
>>>>> @@ -10,6 +10,7 @@ menu "Remote Processor drivers"
>>>>>  # All users should depend on DM
>>>>>  config REMOTEPROC
>>>>>  	bool
>>>>> +	select FS_LOADER
>>>>>  	depends on DM
>>>>>  
>>>>>  # Please keep the configuration alphabetically sorted.
>>>>> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
>>>>> index 28b362c887..76db4157f7 100644
>>>>> --- a/drivers/remoteproc/rproc-uclass.c
>>>>> +++ b/drivers/remoteproc/rproc-uclass.c
>>>>> @@ -13,6 +13,7 @@
>>>>>  #include <log.h>
>>>>>  #include <malloc.h>
>>>>>  #include <virtio_ring.h>
>>>>> +#include <fs_loader.h>
>>>>>  #include <remoteproc.h>
>>>>>  #include <asm/io.h>
>>>>>  #include <dm/device-internal.h>
>>>>> @@ -961,3 +962,87 @@ unsigned long rproc_parse_resource_table(struct udevice *dev, struct rproc *cfg)
>>>>>  
>>>>>  	return 1;
>>>>>  }
>>>>> +
>>>>> +int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>>> +{
>>>>> +	struct dm_rproc_uclass_pdata *uc_pdata;
>>>>> +	int len;
>>>>> +	char *p;
>>>>> +
>>>>> +	if (!rproc_dev || !fw_name)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
>>>>
>>>> This can return NULL and you shuould error out if it does.
>>>>
>>>
>>> Sure.
>>>
>>>>> +
>>>>> +	len = strcspn(fw_name, "\n");
>>>>> +	if (!len) {
>>>>> +		debug("can't provide empty string for firmware name\n");
>>>>
>>>> how about "invalid filename" ?
>>>>
>>>
>>> Sure.
>>>
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	p = strndup(fw_name, len);
>>>>> +	if (!p)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	uc_pdata->fw_name = p;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>>> +{
>>>>> +	struct dm_rproc_uclass_pdata *uc_pdata;
>>>>> +	struct udevice *fs_loader;
>>>>> +	void *addr = malloc(fw_size);
>>>>
>>>> I will suggest to do malloc just before you need the buffer.
>>>> You need to free up the buffer an all return paths after that.
>>>>
>>>
>>> That is correct. I will do malloc just before calling
>>> request_firmware_into_buf() API.
>>>
>>>>> +	int core_id, ret = 0;
>>>>> +	char *firmware;
>>>>> +	ulong rproc_addr;
>>>>
>>>> do you really need rproc_addr? You could use addr itself.
>>>>
>>>
>>> Sure.
>>>
>>>>> +
>>>>> +	if (!rproc_dev)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	if (!addr)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
>>>>> +	core_id = dev_seq(rproc_dev);
>>>>> +	firmware = uc_pdata->fw_name;
>>>>> +
>>>>> +	if (!firmware) {
>>>>> +		debug("No firmware set for rproc core %d\n", core_id);
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	/* Initialize all rproc cores */
>>>>> +	rproc_init();
>>>>
>>>> 	if (!rproc_is_initialized()) {
>>>> 		ret = rproc_init()
>>>> 		if (ret) {
>>>> 			debug("rproc_init() failed: %d\n", ret);
>>>> 			return ret;
>>>> 		}
>>>> 	}
>>>>
>>>
>>> Sure.
>>>
>>>>> +
>>>>> +	/* Loading firmware to a given address */
>>>>> +	ret = get_fs_loader(&fs_loader);
>>>>> +	if (ret) {
>>>>> +		debug("could not get fs loader: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	ret = request_firmware_into_buf(fs_loader, firmware, addr, fw_size, 0);
>>>>> +	if (ret < 0) {
>>>>> +		debug("could not request %s: %d\n", firmware, ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	rproc_addr = (ulong)addr;
>>>>> +
>>>>> +	ret = rproc_load(core_id, rproc_addr, ret);
>>>>
>>>> ret = rproc_load(coare_id, (ulong)addr, ret);
>>>>
>>>>> +	if (ret) {
>>>>> +		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
>>>>> +		      uc_pdata->fw_name, core_id, rproc_addr, ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	ret = rproc_start(core_id);
>>>>> +	if (ret) {
>>>>> +		debug("failed to start rproc core %d\n", core_id);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	return ret;
>>>>
>>>> return 0;
>>>>
>>>>> +}
>>>>> diff --git a/include/remoteproc.h b/include/remoteproc.h
>>>>> index 91a88791a4..e53f85ba51 100644
>>>>> --- a/include/remoteproc.h
>>>>> +++ b/include/remoteproc.h
>>>>> @@ -403,6 +403,7 @@ enum rproc_mem_type {
>>>>>   * @name: Platform-specific way of naming the Remote proc
>>>>>   * @mem_type: one of 'enum rproc_mem_type'
>>>>>   * @driver_plat_data: driver specific platform data that may be needed.
>>>>> + * @fw_name: firmware name
>>>>>   *
>>>>>   * This can be accessed with dev_get_uclass_plat() for any UCLASS_REMOTEPROC
>>>>>   * device.
>>>>> @@ -412,6 +413,7 @@ struct dm_rproc_uclass_pdata {
>>>>>  	const char *name;
>>>>>  	enum rproc_mem_type mem_type;
>>>>>  	void *driver_plat_data;
>>>>> +	char *fw_name;
>>>>>  };
>>>>>  
>>>>>  /**
>>>>> @@ -705,6 +707,35 @@ unsigned long rproc_parse_resource_table(struct udevice *dev,
>>>>>  struct resource_table *rproc_find_resource_table(struct udevice *dev,
>>>>>  						 unsigned int addr,
>>>>>  						 int *tablesz);
>>>>> +/**
>>>>> + * rproc_set_firmware() - assign a new firmware
>>>>
>>>> firmware/firmware name.
>>>>
>>>>> + * @rproc_dev: device for wich new firmware is being assigned
>>>>
>>>> firmware/firmware name
>>>> wich/which
>>>>
>>>>> + * @fw_name: new firmware name to be assigned
>>>>> + *
>>>>> + * This function allows remoteproc drivers or clients to configure a custom
>>>>> + * firmware name. The function does not trigger a remote processor boot,
>>>>> + * only sets the firmware name used for a subsequent boot.
>>>>> + *
>>>>> + * This function sets the fw_name field in uclass pdata of the Remote proc
>>>>> + *
>>>>> + * Return: 0 on success or a negative value upon failure
>>>>> + */
>>>>> +int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name);
>>>>> +
>>>>> +/**
>>>>> + * rproc_boot() - boot a remote processor
>>>>> + * @rproc_dev: rproc device to boot
>>>>> + * @fw_size: Size of the memory to allocate for firmeware
>>>>
>>>> firmeware/firmware
>>>>
>>>
>>> I'll fix all these typos.
>>>
>>>> How does caller know what firmware size to set to?
>>>> This should already be private to the rproc as it knows 
>>>> how large is its program memory.
>>>>
>>>
>>> Caller is trying to boot the rproc with a firmware binary. Caller should
>>> know the size of binary that it wants to load to rproc core. Caller will
>>> specify the binary size to rproc_boot(). Based on the size provided by
>>> caller, rproc_boot() will then allocate that much memory and call
>>> request_firmware_into_buf() with the size and allocated buffer. If the
>>> caller doesn't provide minimum size rproc_load() will fail.
>>
>> Caller only knows the filename. It need not know more details.
> 
> Caller is trying to load a file of it's choice to a rproc. Caller should
> know the size of file it is trying to load or atleast the max size that
> the firmware file could be of.
> 
> 
>> Also see my comment below about rproc_boot() API.
>>
>>>
>>> rproc_load() calls respective driver ops, for example: pru_load().
>>> pru_load() [1] API checks the required size of firmware to load by
>>> casting the buffer into Elf32_Ehdr and Elf32_Phdr and returns error if
>>> size provided by caller is less than this.
>>>
>>>
>>> 	if (offset + filesz > size) {
>>> 		dev_dbg(dev, "truncated fw: need 0x%x avail 0x%zx\n",
>>> 			offset + filesz, size);
>>> 		ret = -EINVAL;
>>> 		break;
>>> 	}
>>>
>>>>> + *
>>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>>> + *
>>>>> + * This function first loads the firmware set in the uclass pdata of Remote
>>>>> + * processor to a buffer and then loads firmware to the remote processor
>>>>> + * using rproc_load().
>>>>> + *
>>>>> + * Return: 0 on success, and an appropriate error value otherwise
>>>>> + */
>>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
>>>>
>>>> Was wondering if you need separate API for rproc_set_firmware or we can just
>>>> pass firmware name as argument to rproc_boot()?
>>>>
>>>
>>> Technically we can. But when we discussed this approach first in v1, you
>>> had asked to keep the APIs similar to upstream linux. Upstream linux has
>>> these two APIs so I kept it that way. If you want I can drop the first
>>> API. Please let me know.
>>
>> Sure you can keep it as it is in Linux, but there, rproc_boot doesn't
>> take fw_size argument. So wondering why you should have it in u-boot.
>>
> 
> For loading firmware to a rproc core in u-boot, it's first neccassry to
> load the firmware into buffer and then load that buffer into rproc core
> using rproc_load() API. Now to load the firmware to a buffer ther is an
> API request_firmware_into_buf(). This API takes size of firmware as one
> of it's argument. So in order to call this API from rproc_boot() we need
> to pass fw_size to rproc_boot()
> 
> Other u-boot drivers using request_firmware_into_buf() are also passing
> size of firmware from their driver.

But in your driver you didn't use size of firmware but some 64K
https://lore.kernel.org/all/20240124064930.1787929-8-danishanwar@ti.com/

So neither does the caller have a clue of firmware size?

> 
> If rproc_boot() doesn't take fw_size as argument then within
> rproc_boot() we need to figure out the fw_size before calling
> request_firmware_into_buf().
> 
> If we don't know the size / maximum size of the firmware to load, how
> will we call request_firmware_into_buf(). Someone has to tell
> request_firmware_into_buf() the size of firmware. I am expecting that to
> be the caller. Do you have any other way of getting the firmware size
> before request_firmware_into_buf() is called?

/**
 * request_firmware_into_buf - Load firmware into a previously allocated buffer.
 * @dev: An instance of a driver.
 * @name: Name of firmware file.
 * @buf: Address of buffer to load firmware into.
 * @size: Size of buffer.
 * @offset: Offset of a file for start reading into buffer.

It needs size of pre-allocated buffer which can be smaller than file size.
It also has the option of offset. So you can load portions of the file limited
by buffer size.

My suggestion is that Remoteproc layer should take care of how much buffer
to allocate and pass that buffer size to request_firmware_into_buf().
You are doing the malloc here itself anyways.

> 
>>>
>>>>>  #else
>>>>>  static inline int rproc_init(void) { return -ENOSYS; }
>>>>>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
>>>>> @@ -744,6 +775,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>>>>>  					   ulong fw_size, ulong *rsc_addr,
>>>>>  					   ulong *rsc_size)
>>>>>  { return -ENOSYS; }
>>>>> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>>> +{ return -ENOSYS; }
>>>>> +static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>>> +{ return -ENOSYS; }
>>>>>  #endif
>>>>>  
>>>>>  #endif	/* _RPROC_H_ */
>>>>
>>>
>>> [1]
>>> https://elixir.bootlin.com/u-boot/latest/source/drivers/remoteproc/pru_rproc.c#L324
>>>
>>
> 

-- 
cheers,
-roger
