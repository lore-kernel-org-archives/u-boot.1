Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B695AC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 13:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB55E86D4C;
	Tue,  6 Feb 2024 14:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NEOXYHh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D35C87C1F; Tue,  6 Feb 2024 14:41:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD9C86308
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 14:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5966A61349;
 Tue,  6 Feb 2024 13:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFE7C433F1;
 Tue,  6 Feb 2024 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707226887;
 bh=lEd9pekSgZxvJO3dswYWDnPf9CX7AC3pGvs+367DLJ8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NEOXYHh2KBHZdPbDMCf9UGM5utTWkdL+3Py28C+Zi3HM8l861l3HeQ414j4Cdwfc+
 43a6vcIbuP4op914N+p4rjlb/2TAQKqt7I7fcmJKoiPLwQ9MM376BfKq1uA8q3gEaV
 JhoziRqWbL4S5whxOT4XUSbBxdjQTGSvj6IZOFheBGOHBmUnK6tgjsmwQaYgTuU1NN
 vmmiqVf/5eWSjUOrgaFNAHViB6KRjQkCcF2tpiFZxOcf8VKTvn6S4DkMjLjJa21c3p
 E140VThWYaXaODXOEAk5QBzoa20mZBlI1ScptMhr6VzVARXec0lVvGl2G3FLGFbA1b
 TvB41QuhR1x6w==
Message-ID: <3ddc45e4-e0d4-4ae7-90ed-b273b3c1ac09@kernel.org>
Date: Tue, 6 Feb 2024 15:41:21 +0200
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
 <1646d8b2-7e0d-4716-956f-41b6f61f8626@kernel.org>
 <9f3b093c-89fd-4f4c-abad-650c03cb8118@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <9f3b093c-89fd-4f4c-abad-650c03cb8118@ti.com>
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



On 06/02/2024 07:31, MD Danish Anwar wrote:
> 
> 
> On 05/02/24 6:07 pm, Roger Quadros wrote:
>>
>>
>> On 05/02/2024 12:20, MD Danish Anwar wrote:
>>>
>>>
>>> On 05/02/24 3:36 pm, Roger Quadros wrote:
>>>>
>>>>
>>>> On 02/02/2024 18:40, Anwar, Md Danish wrote:
>>>>> Hi Roger,
>>>>>
>>>>> On 2/2/2024 4:49 PM, Roger Quadros wrote:
>>>>>>
>>>>>>
>>>>>> On 30/01/2024 08:33, MD Danish Anwar wrote:
>>>>>>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>>>>>>> same firmware.
>>>>>>>
> 
> <snip>
> 
>>>>>
>>>>>> How does caller know what firmware size to set to?
>>>>>> This should already be private to the rproc as it knows 
>>>>>> how large is its program memory.
>>>>>>
>>>>>
>>>>> Caller is trying to boot the rproc with a firmware binary. Caller should
>>>>> know the size of binary that it wants to load to rproc core. Caller will
>>>>> specify the binary size to rproc_boot(). Based on the size provided by
>>>>> caller, rproc_boot() will then allocate that much memory and call
>>>>> request_firmware_into_buf() with the size and allocated buffer. If the
>>>>> caller doesn't provide minimum size rproc_load() will fail.
>>>>
>>>> Caller only knows the filename. It need not know more details.
>>>
>>> Caller is trying to load a file of it's choice to a rproc. Caller should
>>> know the size of file it is trying to load or atleast the max size that
>>> the firmware file could be of.
>>>
>>>
>>>> Also see my comment below about rproc_boot() API.
>>>>
>>>>>
>>>>> rproc_load() calls respective driver ops, for example: pru_load().
>>>>> pru_load() [1] API checks the required size of firmware to load by
>>>>> casting the buffer into Elf32_Ehdr and Elf32_Phdr and returns error if
>>>>> size provided by caller is less than this.
>>>>>
>>>>>
>>>>> 	if (offset + filesz > size) {
>>>>> 		dev_dbg(dev, "truncated fw: need 0x%x avail 0x%zx\n",
>>>>> 			offset + filesz, size);
>>>>> 		ret = -EINVAL;
>>>>> 		break;
>>>>> 	}
>>>>>
>>>>>>> + *
>>>>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>>>>> + *
>>>>>>> + * This function first loads the firmware set in the uclass pdata of Remote
>>>>>>> + * processor to a buffer and then loads firmware to the remote processor
>>>>>>> + * using rproc_load().
>>>>>>> + *
>>>>>>> + * Return: 0 on success, and an appropriate error value otherwise
>>>>>>> + */
>>>>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
>>>>>>
>>>>>> Was wondering if you need separate API for rproc_set_firmware or we can just
>>>>>> pass firmware name as argument to rproc_boot()?
>>>>>>
>>>>>
>>>>> Technically we can. But when we discussed this approach first in v1, you
>>>>> had asked to keep the APIs similar to upstream linux. Upstream linux has
>>>>> these two APIs so I kept it that way. If you want I can drop the first
>>>>> API. Please let me know.
>>>>
>>>> Sure you can keep it as it is in Linux, but there, rproc_boot doesn't
>>>> take fw_size argument. So wondering why you should have it in u-boot.
>>>>
>>>
>>> For loading firmware to a rproc core in u-boot, it's first neccassry to
>>> load the firmware into buffer and then load that buffer into rproc core
>>> using rproc_load() API. Now to load the firmware to a buffer ther is an
>>> API request_firmware_into_buf(). This API takes size of firmware as one
>>> of it's argument. So in order to call this API from rproc_boot() we need
>>> to pass fw_size to rproc_boot()
>>>
>>> Other u-boot drivers using request_firmware_into_buf() are also passing
>>> size of firmware from their driver.
>>
>> But in your driver you didn't use size of firmware but some 64K
>> https://lore.kernel.org/all/20240124064930.1787929-8-danishanwar@ti.com/
>>
> 
> Yes, in driver I am hardcoding the size to 64K. That's because I know
> the size of ICSSG firmwares are less than 64K. Instead of hardcoding I

What if you enable debugging symbols in the firmware file. Won't it exceed 64KB?
It is not a good idea to assume any firmware file size as it will eventually
break sometime in the future and will be a pain to debug.

> can also define macro or provide a config option where we set the size
> and the driver will read the size from the config and call rproc_boot()
> with size.
> 
> For example, fm.c driver reads the size from config option
> CONFIG_SYS_QE_FMAN_FW_LENGTH [1] and calls request_firmware_into_buf()
> 
> [1]
> https://elixir.bootlin.com/u-boot/latest/source/drivers/net/fm/fm.c#L458
> 
>> So neither does the caller have a clue of firmware size?
>>
>>>
>>> If rproc_boot() doesn't take fw_size as argument then within
>>> rproc_boot() we need to figure out the fw_size before calling
>>> request_firmware_into_buf().
>>>
>>> If we don't know the size / maximum size of the firmware to load, how
>>> will we call request_firmware_into_buf(). Someone has to tell
>>> request_firmware_into_buf() the size of firmware. I am expecting that to
>>> be the caller. Do you have any other way of getting the firmware size
>>> before request_firmware_into_buf() is called?
>>
>> /**
>>  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
>>  * @dev: An instance of a driver.
>>  * @name: Name of firmware file.
>>  * @buf: Address of buffer to load firmware into.
>>  * @size: Size of buffer.
>>  * @offset: Offset of a file for start reading into buffer.
>>
>> It needs size of pre-allocated buffer which can be smaller than file size.
>> It also has the option of offset. So you can load portions of the file limited
>> by buffer size.
>>
>> My suggestion is that Remoteproc layer should take care of how much buffer
>> to allocate and pass that buffer size to request_firmware_into_buf().
>> You are doing the malloc here itself anyways.
>>
> 
> But how would the remoteproc driver know how much buffer it needs to
> allocate before calling request_firmware_into_buf().

Only the filesystem driver knows what exactly is the firmware file size.
fs_size() API can be used for that.

> 
>>>
>>>>>
>>>>>>>  #else
>>>>>>>  static inline int rproc_init(void) { return -ENOSYS; }
>>>>>>>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
>>>>>>> @@ -744,6 +775,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>>>>>>>  					   ulong fw_size, ulong *rsc_addr,
>>>>>>>  					   ulong *rsc_size)
>>>>>>>  { return -ENOSYS; }
>>>>>>> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>>>>> +{ return -ENOSYS; }
>>>>>>> +static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>>>>> +{ return -ENOSYS; }
>>>>>>>  #endif
>>>>>>>  
>>>>>>>  #endif	/* _RPROC_H_ */
>>>>>>
>>>>>
>>>>> [1]
>>>>> https://elixir.bootlin.com/u-boot/latest/source/drivers/remoteproc/pru_rproc.c#L324
>>>>>
>>>>
>>>
>>
> 

-- 
cheers,
-roger
