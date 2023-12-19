Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B95C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 09:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5939E86EEB;
	Tue, 19 Dec 2023 10:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6K9TJUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7275786EE0; Tue, 19 Dec 2023 10:55:11 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E6986EEB
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 10:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54cd2281ccbso5068408a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702979708; x=1703584508; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DG64c7dRFIL5Y3MImZBgQFQYMUNsfuD/yEeTvtHu888=;
 b=N6K9TJUs2oHwmR2BUwQn45HtFS4FInk0CIsE9uvAL/CzurOUUAkO8WuzxlF/+egkZY
 ym+1Z8xwkw1juenJrCepAGyd/0CMvvSnHWw/AHmKB3uLDRm+HaBwNTlxP4FZxAaaW6YN
 A/5geB3vapkPUzFijhrqAjO+nwaykItFrIIM/lqiB+Co9wYBU0so2G3G1ZXezTwh0OaG
 hK14ebZ4APZci/ag4FgiFvkd/AavxLAnKxx9WDDzniFgU+KgafPrSP6sbzgYbYRga1Wa
 2FcjB4fEGuiw/sgzejg//RFrf03GNfhJaZhHX+SNaJYVUskjxzSSb5fZeMkIbqtmwxdq
 gSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702979708; x=1703584508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DG64c7dRFIL5Y3MImZBgQFQYMUNsfuD/yEeTvtHu888=;
 b=rDlYKB4LEEuDy9W9QcWB1KAEcYt9Gh8naSlrtJiqNnM3ZJSG4VVy7yuRB0Er4sp1SE
 qLuBEK+wt58uVHk3z36NlNMoz1CVFX071pEr2NRy0jxZb1W/DVbJ1mk8+L4nc+62I0a5
 czYvog+ZUQzSOwFinmn0+DR4EFHmlPEqNMJgbLWUW1cPwEOQo2cfiuaYEBjIIk4vZfb+
 2aG5/npAgy6ll+biQM+Q4U/Ng3CcoyGCHjIFiYu6nrpvC4UGI1CwOQMKXXmPvCEjXHYL
 zqkbUX7QxZfHmXV+LGVYHMmzVTv+v8wXcPTOMUX2fbQul0YwyhUBzXeNoAPWP/Ifhvoo
 Jg9w==
X-Gm-Message-State: AOJu0YxGuQa3Icf2KuiqroHrz+CtIRb1EoKbVYGZPLFYJVCuVG2xqfUW
 3oPqLPM+YqsBfoBamae8ujg=
X-Google-Smtp-Source: AGHT+IFgsycW3lLLHo/b1K3oXGZiIye8ulRB1V67R2Tb1+vQZV6/Q4Pq5c7JsjoIyZKsaS6e2nvObw==
X-Received: by 2002:a17:907:7f8b:b0:a26:861f:c05c with SMTP id
 qk11-20020a1709077f8b00b00a26861fc05cmr58827ejc.114.1702979707884; 
 Tue, 19 Dec 2023 01:55:07 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.googlemail.com with ESMTPSA id
 s19-20020a170906c31300b00a236e9cfe74sm928058ejz.103.2023.12.19.01.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 01:55:07 -0800 (PST)
Message-ID: <ba8abaf6-6f16-4742-a3ea-ad00d4151698@gmail.com>
Date: Tue, 19 Dec 2023 10:55:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231218133722.16150-1-zajec5@gmail.com>
 <20231218133722.16150-4-zajec5@gmail.com> <20231218152116.59d59bad@xps-13>
 <13bc621c-5fcb-4710-912c-06e3e80d7337@gmail.com>
 <20231219085517.4b6ec4fc@xps-13>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20231219085517.4b6ec4fc@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 19.12.2023 08:55, Miquel Raynal wrote:
> Hi Rafał,
> 
> zajec5@gmail.com wrote on Mon, 18 Dec 2023 23:10:20 +0100:
> 
>> On 18.12.2023 15:21, Miquel Raynal wrote:
>>> Hi Rafał,
>>>
>>> zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:22 +0100:
>>>    
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> This patch moves all generic (NVMEM devices independent) code from NVMEM
>>>> device driver to NVMEM layout driver. Then it adds a simple NVMEM layout
>>>> code on top of it.
>>>>
>>>> Thanks to proper layout it's possible to support U-Boot env data stored
>>>> on any kind of NVMEM device.
>>>>
>>>> For backward compatibility with old DT bindings we need to keep old
>>>> NVMEM device driver functional. To avoid code duplication a parsing
>>>> function is exported and reused in it.
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>
>>> I have a couple of comments about the original driver which gets
>>> copy-pasted in the new layout driver, maybe you could clean these
>>> (the memory leak should be fixed before the migration so it can be
>>> backported easily, the others are just style so it can be done after, I
>>> don't mind).
>>>
>>> ...
>>>    
>>>> +int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
>>>> +		     enum u_boot_env_format format)
>>>> +{
>>>> +	size_t crc32_data_offset;
>>>> +	size_t crc32_data_len;
>>>> +	size_t crc32_offset;
>>>> +	size_t data_offset;
>>>> +	size_t data_len;
>>>> +	size_t dev_size;
>>>> +	uint32_t crc32;
>>>> +	uint32_t calc;
>>>> +	uint8_t *buf;
>>>> +	int bytes;
>>>> +	int err;
>>>> +
>>>> +	dev_size = nvmem_dev_size(nvmem);
>>>> +
>>>> +	buf = kcalloc(1, dev_size, GFP_KERNEL);
>>>
>>> Out of curiosity, why kcalloc(1,...) rather than kzalloc() ?
>>
>> I used kcalloc() initially as I didn't need buffer to be zeroed.
> 
> I think kcalloc() initializes the memory to zero.
> https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L659
> 
> If you don't need it you can switch to kmalloc() instead, I don't mind,
> but kcalloc() is meant to be used with arrays, I don't see the point of
> using kcalloc() in this case.
> 
>>
>> I see that memory-allocation.rst however says:
>>   > And, to be on the safe side it's best to use routines that set memory to zero, like kzalloc().
>>
>> It's probably close to zero cost to zero that buffer so it could be kzalloc().
>>
>>
>>>> +	if (!buf) {
>>>> +		err = -ENOMEM;
>>>> +		goto err_out;
>>>
>>> We could directly return ENOMEM here I guess.
>>>    
>>>> +	}
>>>> +
>>>> +	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
>>>> +	if (bytes < 0)
>>>> +		return bytes;
>>>> +	else if (bytes != dev_size)
>>>> +		return -EIO;
>>>
>>> Don't we need to free buf in the above cases?
>>>    
>>>> +	switch (format) {
>>>> +	case U_BOOT_FORMAT_SINGLE:
>>>> +		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
>>>> +		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
>>>> +		data_offset = offsetof(struct u_boot_env_image_single, data);
>>>> +		break;
>>>> +	case U_BOOT_FORMAT_REDUNDANT:
>>>> +		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
>>>> +		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
>>>> +		data_offset = offsetof(struct u_boot_env_image_redundant, data);
>>>> +		break;
>>>> +	case U_BOOT_FORMAT_BROADCOM:
>>>> +		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
>>>> +		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>>>> +		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>>>> +		break;
>>>> +	}
>>>> +	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
>>>
>>> Looks a bit convoluted, any chances we can use intermediate variables
>>> to help decipher this?
>>>    
>>>> +	crc32_data_len = dev_size - crc32_data_offset;
>>>> +	data_len = dev_size - data_offset;
>>>> +
>>>> +	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
>>>> +	if (calc != crc32) {
>>>> +		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
>>>> +		err = -EINVAL;
>>>> +		goto err_kfree;
>>>> +	}
>>>> +
>>>> +	buf[dev_size - 1] = '\0';
>>>> +	err = u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
>>>> +	if (err)
>>>> +		dev_err(dev, "Failed to add cells: %d\n", err);
>>>
>>> Please drop this error message, the only reason for which the function
>>> call would fail is apparently an ENOMEM case.
>>>    
>>>> +
>>>> +err_kfree:
>>>> +	kfree(buf);
>>>> +err_out:
>>>> +	return err;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(u_boot_env_parse);
>>>> +
>>>> +static int u_boot_env_add_cells(struct device *dev, struct nvmem_device *nvmem)
>>>> +{
>>>> +	const struct of_device_id *match;
>>>> +	struct device_node *layout_np;
>>>> +	enum u_boot_env_format format;
>>>> +
>>>> +	layout_np = of_nvmem_layout_get_container(nvmem);
>>>> +	if (!layout_np)
>>>> +		return -ENOENT;
>>>> +
>>>> +	match = of_match_node(u_boot_env_of_match_table, layout_np);
>>>> +	if (!match)
>>>> +		return -ENOENT;
>>>> +
>>>> +	format = (uintptr_t)match->data;
>>>
>>> In the core there is currently an unused helper called
>>> nvmem_layout_get_match_data() which does that. I think the original
>>> intent of this function was to be used in this driver, so depending on
>>> your preference, can you please either use it or remove it?
>>
>> The problem is that nvmem_layout_get_match_data() uses:
>> layout->dev.driver
> 
> I'm surprised .driver is unset. Well anyway, please either fix the core
> helper and use it or drop the core helper, because we have no user for
> it otherwise?

I believe it's because of a very minimalistic "nvmem_bus_type" bus
implementation.

 From a quick look it seems that default expected FORWARD-trace is:
driver_register()
bus_add_driver()
driver_attach()
__driver_attach()
driver_probe_device()
__driver_probe_device()
really_probe()

It's really_probe() that seems to set dev->driver pointer.


>> It doesn't work with layouts driver (since refactoring?) as driver is
>> NULL. That results in NULL pointer dereference when trying to reach
>> of_match_table.
>>
>> That is why I used u_boot_env_of_match_table directly.
>>
>> If you know how to fix nvmem_layout_get_match_data() that would be
>> great. Do we need driver_register() somewhere in NVMEM core?

