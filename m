Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569E3C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3848781A;
	Fri,  9 Feb 2024 10:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IHS6Hdv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE7287C43; Fri,  9 Feb 2024 10:16:17 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05B2876D3
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4199G4dH130311;
 Fri, 9 Feb 2024 03:16:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707470164;
 bh=mNTzCAYZvD8I33oJ3M3T1uGlIYBCZZKX/iWKm5V0bqQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IHS6Hdv9Au/kO1fF+1I4HVB/TsFbTDDBlD/HAGBiUYMBNyK9FVyfqLrLW68197pr1
 A8/SBhSGynkUDnuqWvF6RAfGj62cvjCN+gb8bkOnKegBVfIplmv8N430NDDTaZQ3XG
 1WmKgR8r4Ixogxn0rsZdVytZK5jBUhcDasArGCGQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4199G4xa004029
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Feb 2024 03:16:04 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 03:16:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 03:16:03 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4199FwUL124725;
 Fri, 9 Feb 2024 03:16:00 -0600
Message-ID: <b2e70bc1-caea-45d8-aabf-774715aefccc@ti.com>
Date: Fri, 9 Feb 2024 14:45:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: "Anwar, Md Danish" <a0501179@ti.com>, Roger Quadros <rogerq@kernel.org>,
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
 <c042c7a5-1561-4efb-b7c4-461bda1f6c36@ti.com>
 <1646d8b2-7e0d-4716-956f-41b6f61f8626@kernel.org>
 <9f3b093c-89fd-4f4c-abad-650c03cb8118@ti.com>
 <3ddc45e4-e0d4-4ae7-90ed-b273b3c1ac09@kernel.org>
 <2e16f56b-d022-4d19-a070-b099ae562e77@ti.com>
 <911d8755-d162-4987-852a-8ce060454a26@kernel.org>
 <ea38db1d-0939-4497-8fc8-9266f5d0d4cc@ti.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <ea38db1d-0939-4497-8fc8-9266f5d0d4cc@ti.com>
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

On 07/02/24 6:27 pm, Anwar, Md Danish wrote:
> On 2/7/2024 6:05 PM, Roger Quadros wrote:
>>
>>
>> On 07/02/2024 09:15, MD Danish Anwar wrote:
>>> Hi Roger
>>>
>>> On 06/02/24 7:11 pm, Roger Quadros wrote:
>>>>
>>>>
>>>> On 06/02/2024 07:31, MD Danish Anwar wrote:
>>>>>
>>>>>
>>>>> On 05/02/24 6:07 pm, Roger Quadros wrote:
>>>>>>
>>>>>>
>>>>>> On 05/02/2024 12:20, MD Danish Anwar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 05/02/24 3:36 pm, Roger Quadros wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 02/02/2024 18:40, Anwar, Md Danish wrote:
>>>>>>>>> Hi Roger,
>>>>>>>>>
>>>>>>>>> On 2/2/2024 4:49 PM, Roger Quadros wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 30/01/2024 08:33, MD Danish Anwar wrote:
>>>>>>>>>>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>>>>>>>>>>> same firmware.
>>>>>>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>>>
>>>>>>>>>> How does caller know what firmware size to set to?
>>>>>>>>>> This should already be private to the rproc as it knows 
>>>>>>>>>> how large is its program memory.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Caller is trying to boot the rproc with a firmware binary. Caller should
>>>>>>>>> know the size of binary that it wants to load to rproc core. Caller will
>>>>>>>>> specify the binary size to rproc_boot(). Based on the size provided by
>>>>>>>>> caller, rproc_boot() will then allocate that much memory and call
>>>>>>>>> request_firmware_into_buf() with the size and allocated buffer. If the
>>>>>>>>> caller doesn't provide minimum size rproc_load() will fail.
>>>>>>>>
>>>>>>>> Caller only knows the filename. It need not know more details.
>>>>>>>
>>>>>>> Caller is trying to load a file of it's choice to a rproc. Caller should
>>>>>>> know the size of file it is trying to load or atleast the max size that
>>>>>>> the firmware file could be of.
>>>>>>>
>>>>>>>
>>>>>>>> Also see my comment below about rproc_boot() API.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> rproc_load() calls respective driver ops, for example: pru_load().
>>>>>>>>> pru_load() [1] API checks the required size of firmware to load by
>>>>>>>>> casting the buffer into Elf32_Ehdr and Elf32_Phdr and returns error if
>>>>>>>>> size provided by caller is less than this.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 	if (offset + filesz > size) {
>>>>>>>>> 		dev_dbg(dev, "truncated fw: need 0x%x avail 0x%zx\n",
>>>>>>>>> 			offset + filesz, size);
>>>>>>>>> 		ret = -EINVAL;
>>>>>>>>> 		break;
>>>>>>>>> 	}
>>>>>>>>>
>>>>>>>>>>> + *
>>>>>>>>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>>>>>>>>> + *
>>>>>>>>>>> + * This function first loads the firmware set in the uclass pdata of Remote
>>>>>>>>>>> + * processor to a buffer and then loads firmware to the remote processor
>>>>>>>>>>> + * using rproc_load().
>>>>>>>>>>> + *
>>>>>>>>>>> + * Return: 0 on success, and an appropriate error value otherwise
>>>>>>>>>>> + */
>>>>>>>>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
>>>>>>>>>>
>>>>>>>>>> Was wondering if you need separate API for rproc_set_firmware or we can just
>>>>>>>>>> pass firmware name as argument to rproc_boot()?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Technically we can. But when we discussed this approach first in v1, you
>>>>>>>>> had asked to keep the APIs similar to upstream linux. Upstream linux has
>>>>>>>>> these two APIs so I kept it that way. If you want I can drop the first
>>>>>>>>> API. Please let me know.
>>>>>>>>
>>>>>>>> Sure you can keep it as it is in Linux, but there, rproc_boot doesn't
>>>>>>>> take fw_size argument. So wondering why you should have it in u-boot.
>>>>>>>>
>>>>>>>
>>>>>>> For loading firmware to a rproc core in u-boot, it's first neccassry to
>>>>>>> load the firmware into buffer and then load that buffer into rproc core
>>>>>>> using rproc_load() API. Now to load the firmware to a buffer ther is an
>>>>>>> API request_firmware_into_buf(). This API takes size of firmware as one
>>>>>>> of it's argument. So in order to call this API from rproc_boot() we need
>>>>>>> to pass fw_size to rproc_boot()
>>>>>>>
>>>>>>> Other u-boot drivers using request_firmware_into_buf() are also passing
>>>>>>> size of firmware from their driver.
>>>>>>
>>>>>> But in your driver you didn't use size of firmware but some 64K
>>>>>> https://lore.kernel.org/all/20240124064930.1787929-8-danishanwar@ti.com/
>>>>>>
>>>>>
>>>>> Yes, in driver I am hardcoding the size to 64K. That's because I know
>>>>> the size of ICSSG firmwares are less than 64K. Instead of hardcoding I
>>>>
>>>> What if you enable debugging symbols in the firmware file. Won't it exceed 64KB?
>>>> It is not a good idea to assume any firmware file size as it will eventually
>>>> break sometime in the future and will be a pain to debug.
>>>>
>>>>> can also define macro or provide a config option where we set the size
>>>>> and the driver will read the size from the config and call rproc_boot()
>>>>> with size.
>>>>>
>>>>> For example, fm.c driver reads the size from config option
>>>>> CONFIG_SYS_QE_FMAN_FW_LENGTH [1] and calls request_firmware_into_buf()
>>>>>
>>>>> [1]
>>>>> https://elixir.bootlin.com/u-boot/latest/source/drivers/net/fm/fm.c#L458
>>>>>
>>>>>> So neither does the caller have a clue of firmware size?
>>>>>>
>>>>>>>
>>>>>>> If rproc_boot() doesn't take fw_size as argument then within
>>>>>>> rproc_boot() we need to figure out the fw_size before calling
>>>>>>> request_firmware_into_buf().
>>>>>>>
>>>>>>> If we don't know the size / maximum size of the firmware to load, how
>>>>>>> will we call request_firmware_into_buf(). Someone has to tell
>>>>>>> request_firmware_into_buf() the size of firmware. I am expecting that to
>>>>>>> be the caller. Do you have any other way of getting the firmware size
>>>>>>> before request_firmware_into_buf() is called?
>>>>>>
>>>>>> /**
>>>>>>  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
>>>>>>  * @dev: An instance of a driver.
>>>>>>  * @name: Name of firmware file.
>>>>>>  * @buf: Address of buffer to load firmware into.
>>>>>>  * @size: Size of buffer.
>>>>>>  * @offset: Offset of a file for start reading into buffer.
>>>>>>
>>>>>> It needs size of pre-allocated buffer which can be smaller than file size.
>>>>>> It also has the option of offset. So you can load portions of the file limited
>>>>>> by buffer size.
>>>>>>
>>>>>> My suggestion is that Remoteproc layer should take care of how much buffer
>>>>>> to allocate and pass that buffer size to request_firmware_into_buf().
>>>>>> You are doing the malloc here itself anyways.
>>>>>>
>>>>>
>>>>> But how would the remoteproc driver know how much buffer it needs to
>>>>> allocate before calling request_firmware_into_buf().
>>>>
>>>> Only the filesystem driver knows what exactly is the firmware file size.
>>>> fs_size() API can be used for that.
>>>>
>>>
>>> To use fs_size() we first need to call fs_set_blk_dev() to set the
>>> storage interface, device partition and fs_type. eg.
>>> fs_set_blk_dev("mmc, "1:2", FS_TYPE_ANY)
>>>
>>> Since we are setting the envs for storage_interface and partition I'll
>>> use the envs to call fs_set_blk_dev()
>>>
>>> This is how rproc_boot() will look now.
>>>
>>> int rproc_boot(struct udevice *rproc_dev)
>>> {
>>> 	struct dm_rproc_uclass_pdata *uc_pdata;
>>> 	char *storage_interface, *dev_part;
>>> 	struct udevice *fs_loader;
>>> 	int core_id, ret = 0;
>>> 	char *firmware;
>>> 	loff_t fw_size;
>>> 	void *addr;
>>>
>>> 	if (!rproc_dev)
>>> 		return -EINVAL;
>>>
>>> 	uc_pdata = dev_get_uclass_plat(rproc_dev);
>>> 	if (!uc_pdata)
>>> 		return -EINVAL;
>>>
>>> 	core_id = dev_seq(rproc_dev);
>>> 	firmware = uc_pdata->fw_name;
>>>
>>> 	if (!firmware) {
>>> 		debug("No firmware set for rproc core %d\n", core_id);
>>> 		return -EINVAL;
>>> 	}
>>>
>>> 	/* Initialize all rproc cores */
>>> 	if (!rproc_is_initialized()) {
>>> 		ret = rproc_init();
>>> 		if (ret) {
>>> 			debug("rproc_init() failed: %d\n", ret);
>>> 			return ret;
>>> 		}
>>> 	}
>>>
>>> 	/* Loading firmware to a given address */
>>> 	ret = get_fs_loader(&fs_loader);
>>> 	if (ret) {
>>> 		debug("could not get fs loader: %d\n", ret);
>>> 		return ret;
>>> 	}
>>>
>>> 	storage_interface = env_get("fw_storage_interface");
>>> 	dev_part = env_get("fw_dev_part");
>>>
>>> 	if (storage_interface && dev_part) {
>>> 		ret = fs_set_blk_dev(storage_interface, dev_part, 	FS_TYPE_ANY);
>>> 	} else {
>>> 		debug("could not get env variables to load firmware\n");
>>> 		return -EINVAL;
>>> 	}
>>
>> I'm not very sure about this as we are using firmware loader
>> specific environment variables outside the firmware loader driver.
>>
>> I can see 2 solutions here:
>>
>> 1) ask firmware loader driver to tell us the firmware file size.
>> fw_get_filesystem_firmware() also deals with UBI filesystem.
>>
>> 2) use a large enough buffer whose size is set in Kconfig.
>>
> 
> Roger, I still think 2 is a better option. In ICSSG driver also I am
> setting the fw_size to 64K. Instead of hard-coding, this can be set in
> the config. The ICSSG firmware is usually 40KB so 64K should be OK.
> Other clients, if they use rproc_boot() in future, can specify there max
> firmware size in their config. And to rproc layer it will be abstract.
> 
> We can also get the size from config (Setting somethinig like
> CONFIG_RPROC_MAX_FW_SIZE=64K) directly inside rproc_boot() eliminating
> the need for the client to pass the size. But in future when there are
> many clients using rproc_boot() for different firmware files, It will
> become difficult for remoteproc to hardcode a firmware size that can be
> bigger than any firmware that any client is using.
> 
> It's simpler if each client specify there max fw size instead of
> remoteproc driver specifying max possible size.
> 
>> Tom, any insights?
>>

Hi Tom, any suggestions?

Roger, If Tom doesn't have any comment I will respin the patch by
defining REMOTEPROC_MAX_FW_SIZE in drivers/remoteproc/Kconfig. I will
keep the default size as 0x10000 (64K)

>>>
>>> 	if (ret) {
>>> 		debug("fs_set_blk_dev failed %d\n", ret);
>>> 		return ret;
>>> 	}
>>>
>>> 	ret = fs_size(firmware, &fw_size);
>>> 	if (ret) {
>>> 		debug("could not get firmware size %s: %d\n", firmware, ret);
>>> 		return ret;
>>> 	}
>>>
>>> 	addr = malloc(fw_size);
>>> 	if (!addr)
>>> 		return -ENOMEM;
>>>
>>> 	ret = request_firmware_into_buf(fs_loader, firmware, addr, fw_size, 0);
>>> 	if (ret < 0) {
>>> 		debug("could not request %s: %d\n", firmware, ret);
>>> 		goto free_buffer;
>>> 	}
>>>
>>> 	ret = rproc_load(core_id, (ulong)addr, ret);
>>> 	if (ret) {
>>> 		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
>>> 		      uc_pdata->fw_name, core_id, (ulong)addr, ret);
>>> 		goto free_buffer;
>>> 	}
>>>
>>> 	ret = rproc_start(core_id);
>>> 	if (ret)
>>> 		debug("failed to start rproc core %d\n", core_id);
>>>
>>> free_buffer:
>>> 	free(addr);
>>> 	return ret;
>>> }
>>>
>>> Please let me know if this looks ok. Without calling fs_set_blk_dev()
>>> first, fs_size() results in error.
>>>
>>>
>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>>>  #else
>>>>>>>>>>>  static inline int rproc_init(void) { return -ENOSYS; }
>>>>>>>>>>>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
>>>>>>>>>>> @@ -744,6 +775,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>>>>>>>>>>>  					   ulong fw_size, ulong *rsc_addr,
>>>>>>>>>>>  					   ulong *rsc_size)
>>>>>>>>>>>  { return -ENOSYS; }
>>>>>>>>>>> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>>>>>>>>> +{ return -ENOSYS; }
>>>>>>>>>>> +static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>>>>>>>>> +{ return -ENOSYS; }
>>>>>>>>>>>  #endif
>>>>>>>>>>>  
>>>>>>>>>>>  #endif	/* _RPROC_H_ */
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [1]
>>>>>>>>> https://elixir.bootlin.com/u-boot/latest/source/drivers/remoteproc/pru_rproc.c#L324
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Thanks and Regards,
Danish
