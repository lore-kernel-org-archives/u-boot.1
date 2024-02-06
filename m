Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A49C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 05:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04D087887;
	Tue,  6 Feb 2024 06:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JqIzwqVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E1B87964; Tue,  6 Feb 2024 06:31:30 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9D48786E
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 06:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4165VKUV031087;
 Mon, 5 Feb 2024 23:31:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707197480;
 bh=tYu6FOkGGvixDCnIC6ntuU7LnkWi8TNnQH82wRPtc88=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=JqIzwqVW5Pnmk1XyS/7Egt7fY4H4sLp/nE2O5fioD3gyFQi5ATLfPhFPFB7C8DqW7
 xW0raXQYz6agEJUk9a60IsfFOMrdg6YbxCzGp2HfQFHffQiu/ZB1MKDJ9ZKGa3M+nJ
 r1ZNFzStR5hwuZQiBhA0xomQk5IdyPwvbB/+HFo8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4165VJMp030721
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Feb 2024 23:31:19 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 23:31:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 23:31:19 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4165VFVq037391;
 Mon, 5 Feb 2024 23:31:15 -0600
Message-ID: <9f3b093c-89fd-4f4c-abad-650c03cb8118@ti.com>
Date: Tue, 6 Feb 2024 11:01:14 +0530
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
 <c042c7a5-1561-4efb-b7c4-461bda1f6c36@ti.com>
 <1646d8b2-7e0d-4716-956f-41b6f61f8626@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <1646d8b2-7e0d-4716-956f-41b6f61f8626@kernel.org>
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



On 05/02/24 6:07 pm, Roger Quadros wrote:
> 
> 
> On 05/02/2024 12:20, MD Danish Anwar wrote:
>>
>>
>> On 05/02/24 3:36 pm, Roger Quadros wrote:
>>>
>>>
>>> On 02/02/2024 18:40, Anwar, Md Danish wrote:
>>>> Hi Roger,
>>>>
>>>> On 2/2/2024 4:49 PM, Roger Quadros wrote:
>>>>>
>>>>>
>>>>> On 30/01/2024 08:33, MD Danish Anwar wrote:
>>>>>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>>>>>> same firmware.
>>>>>>

<snip>

>>>>
>>>>> How does caller know what firmware size to set to?
>>>>> This should already be private to the rproc as it knows 
>>>>> how large is its program memory.
>>>>>
>>>>
>>>> Caller is trying to boot the rproc with a firmware binary. Caller should
>>>> know the size of binary that it wants to load to rproc core. Caller will
>>>> specify the binary size to rproc_boot(). Based on the size provided by
>>>> caller, rproc_boot() will then allocate that much memory and call
>>>> request_firmware_into_buf() with the size and allocated buffer. If the
>>>> caller doesn't provide minimum size rproc_load() will fail.
>>>
>>> Caller only knows the filename. It need not know more details.
>>
>> Caller is trying to load a file of it's choice to a rproc. Caller should
>> know the size of file it is trying to load or atleast the max size that
>> the firmware file could be of.
>>
>>
>>> Also see my comment below about rproc_boot() API.
>>>
>>>>
>>>> rproc_load() calls respective driver ops, for example: pru_load().
>>>> pru_load() [1] API checks the required size of firmware to load by
>>>> casting the buffer into Elf32_Ehdr and Elf32_Phdr and returns error if
>>>> size provided by caller is less than this.
>>>>
>>>>
>>>> 	if (offset + filesz > size) {
>>>> 		dev_dbg(dev, "truncated fw: need 0x%x avail 0x%zx\n",
>>>> 			offset + filesz, size);
>>>> 		ret = -EINVAL;
>>>> 		break;
>>>> 	}
>>>>
>>>>>> + *
>>>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>>>> + *
>>>>>> + * This function first loads the firmware set in the uclass pdata of Remote
>>>>>> + * processor to a buffer and then loads firmware to the remote processor
>>>>>> + * using rproc_load().
>>>>>> + *
>>>>>> + * Return: 0 on success, and an appropriate error value otherwise
>>>>>> + */
>>>>>> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
>>>>>
>>>>> Was wondering if you need separate API for rproc_set_firmware or we can just
>>>>> pass firmware name as argument to rproc_boot()?
>>>>>
>>>>
>>>> Technically we can. But when we discussed this approach first in v1, you
>>>> had asked to keep the APIs similar to upstream linux. Upstream linux has
>>>> these two APIs so I kept it that way. If you want I can drop the first
>>>> API. Please let me know.
>>>
>>> Sure you can keep it as it is in Linux, but there, rproc_boot doesn't
>>> take fw_size argument. So wondering why you should have it in u-boot.
>>>
>>
>> For loading firmware to a rproc core in u-boot, it's first neccassry to
>> load the firmware into buffer and then load that buffer into rproc core
>> using rproc_load() API. Now to load the firmware to a buffer ther is an
>> API request_firmware_into_buf(). This API takes size of firmware as one
>> of it's argument. So in order to call this API from rproc_boot() we need
>> to pass fw_size to rproc_boot()
>>
>> Other u-boot drivers using request_firmware_into_buf() are also passing
>> size of firmware from their driver.
> 
> But in your driver you didn't use size of firmware but some 64K
> https://lore.kernel.org/all/20240124064930.1787929-8-danishanwar@ti.com/
> 

Yes, in driver I am hardcoding the size to 64K. That's because I know
the size of ICSSG firmwares are less than 64K. Instead of hardcoding I
can also define macro or provide a config option where we set the size
and the driver will read the size from the config and call rproc_boot()
with size.

For example, fm.c driver reads the size from config option
CONFIG_SYS_QE_FMAN_FW_LENGTH [1] and calls request_firmware_into_buf()

[1]
https://elixir.bootlin.com/u-boot/latest/source/drivers/net/fm/fm.c#L458

> So neither does the caller have a clue of firmware size?
> 
>>
>> If rproc_boot() doesn't take fw_size as argument then within
>> rproc_boot() we need to figure out the fw_size before calling
>> request_firmware_into_buf().
>>
>> If we don't know the size / maximum size of the firmware to load, how
>> will we call request_firmware_into_buf(). Someone has to tell
>> request_firmware_into_buf() the size of firmware. I am expecting that to
>> be the caller. Do you have any other way of getting the firmware size
>> before request_firmware_into_buf() is called?
> 
> /**
>  * request_firmware_into_buf - Load firmware into a previously allocated buffer.
>  * @dev: An instance of a driver.
>  * @name: Name of firmware file.
>  * @buf: Address of buffer to load firmware into.
>  * @size: Size of buffer.
>  * @offset: Offset of a file for start reading into buffer.
> 
> It needs size of pre-allocated buffer which can be smaller than file size.
> It also has the option of offset. So you can load portions of the file limited
> by buffer size.
> 
> My suggestion is that Remoteproc layer should take care of how much buffer
> to allocate and pass that buffer size to request_firmware_into_buf().
> You are doing the malloc here itself anyways.
> 

But how would the remoteproc driver know how much buffer it needs to
allocate before calling request_firmware_into_buf().

>>
>>>>
>>>>>>  #else
>>>>>>  static inline int rproc_init(void) { return -ENOSYS; }
>>>>>>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
>>>>>> @@ -744,6 +775,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>>>>>>  					   ulong fw_size, ulong *rsc_addr,
>>>>>>  					   ulong *rsc_size)
>>>>>>  { return -ENOSYS; }
>>>>>> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
>>>>>> +{ return -ENOSYS; }
>>>>>> +static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
>>>>>> +{ return -ENOSYS; }
>>>>>>  #endif
>>>>>>  
>>>>>>  #endif	/* _RPROC_H_ */
>>>>>
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/u-boot/latest/source/drivers/remoteproc/pru_rproc.c#L324
>>>>
>>>
>>
> 

-- 
Thanks and Regards,
Danish
