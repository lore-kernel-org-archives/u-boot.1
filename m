Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F65ECF34C5
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 13:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C59889EB;
	Fri,  4 Oct 2024 15:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728050001;
	bh=U1zyNBuI57a3nA8Lh936xecyk9NIF0Dhm47dRUl9Udk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/+m6IXj8xH5kt7gkzL1BK1soLqmKJfEuWK3O6P+FAqEtZ4uccH3DIYI1PKT3froa
	 HrRviyONJPa3AswQYokLV5C2JfumLmFkhpMF5xeXN5UsLUmZnbXjuygyJe/qI12V+j
	 6F09I8UU3DylX2B+ysEqB/sAiIywTPc4Bm0R38zzHgOpUdCBMD6n2gnpbMSv1mZlmQ
	 6IYjXcr9mFpwIaNpaN7EPR/vkduwML4+aaDDNnbgncx5ehnWCeJo6pHachQkEGt74+
	 0yoQ+3oOX85/wqboMzLyIzbdfeo7hwV+cvagf92U63DDHMGyWOzyzpYfAMdCBmRc4/
	 oc10cCaex7Wbw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 512CD881C1;
 Fri,  4 Oct 2024 15:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728050000;
 bh=U1zyNBuI57a3nA8Lh936xecyk9NIF0Dhm47dRUl9Udk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H6KCSUyRVlEnOqRyxi6TfE6ANT8ZsenpZ/6CTeqc8Ecs5ttDa6QHRcZuTvLe3AAiA
 Y6m6MNdXjDTmXd5C+7t6GJXONjnf4LR6SMLgaBPmQ/31KPxcGWWDOd+afPGNI9gctX
 WaYUzwnYqocf2TQzvjh7kmZNWdHFmnMql5boXFLSHGhOEMyCbmF0soQ0jgatNcAL48
 0gkdzixAAbqK0vQ6zJXk8Dj2ejCCKjrJcYI3Z46Fb4cSWnB0K1BTL15SnxxBjMX/sI
 d/QMN5zOH8s5r1nfb02jfomYESXwfMCiPaLWZ+QpfT1ZbjynWrEcpfI6+lGJctXUDz
 0T5RkmnoIsmSQ==
Message-ID: <d542e169-cc19-4349-bfbe-4d3937da63a8@denx.de>
Date: Fri, 4 Oct 2024 15:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
 <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
 <SA1PR12MB8697873F2C2EF86E6E9DAF9B98712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <2e0928c8-e03a-44ae-aa36-3d664ed5bc6a@denx.de>
 <SA1PR12MB8697682FEEE48B015EE82E0398712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <c40f47cb-7245-43b7-9b01-6b8d1cdff04c@denx.de>
 <SA1PR12MB869735B41B6F7A86520E2D3D98722@SA1PR12MB8697.namprd12.prod.outlook.com>
 <02fe6fab-7e8c-4408-950f-e6df2a258b16@denx.de>
 <SA1PR12MB86972BBB9F22E0C98AA541A198722@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB86972BBB9F22E0C98AA541A198722@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 10/4/24 2:03 PM, Abbarapu, Venkatesh wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Friday, October 4, 2024 4:52 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
>>
>> On 10/4/24 5:02 AM, Abbarapu, Venkatesh wrote:
>>> Hi Marek,
>>>
>>>> -----Original Message-----
>>>> From: Marek Vasut <marex@denx.de>
>>>> Sent: Thursday, October 3, 2024 10:35 PM
>>>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>;
>>>> u-boot@lists.denx.de
>>>> Cc: Simek, Michal <michal.simek@amd.com>;
>>>> fabrice.gasnier@foss.st.com; git
>>>> (AMD-Xilinx) <git@amd.com>
>>>> Subject: Re: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
>>>>
>>>> On 10/3/24 4:54 PM, Abbarapu, Venkatesh wrote:
>>>>> Hi Marek,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Marek Vasut <marex@denx.de>
>>>>>> Sent: Thursday, October 3, 2024 5:38 PM
>>>>>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>;
>>>>>> u-boot@lists.denx.de
>>>>>> Cc: Simek, Michal <michal.simek@amd.com>;
>>>>>> fabrice.gasnier@foss.st.com; git
>>>>>> (AMD-Xilinx) <git@amd.com>
>>>>>> Subject: Re: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio
>>>>>> support
>>>>>>
>>>>>> On 10/3/24 6:40 AM, Abbarapu, Venkatesh wrote:
>>>>>>> Hi Marek,
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>>>> @@ -30,7 +40,24 @@ static int usb_onboard_hub_probe(struct
>>>>>>>>> udevice
>>>> *dev)
>>>>>>>>>       	if (ret)
>>>>>>>>>       		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
>>>>>>>>>
>>>>>>>>> -	return ret;
>>>>>>>>> +	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>>>>>>>>> +						  GPIOD_IS_OUT |
>>>>>>>> GPIOD_ACTIVE_LOW);
>>>>>>>>> +	/* property is optional, don't return error! */
>>>>>>>>> +	if (hub->reset_gpio) {
>>>>>>>>
>>>>>>>> if (!hub->reset_gpio)
>>>>>>>>        return 0;
>>>>>>> <Venkatesh> As reset_gpio is optional property,  by returning 0
>>>>>>> the i2c sequence
>>>>>> wont be executed.
>>>>>> The code in if (hub->reset_gpio) { ... } only toggles the GPIO reset ?
>>>>> <Venkatesh> Yes...if(hub->reset_gpio) only toggles the GPIO reset.
>>>> So you can return 0 if reset_gpio is NULL and exit early . What's the problem ?
>>> <Venkatesh> if reset_gpio is NULL by returning 0 we miss the below code which
>> does i2c initialization sequence.
>>> Need to toggle the gpio and then does the i2c sequence if the reset_gpio is
>> present, else we do the i2c initialization sequence.
>>
>> Please show me the i2c sequence that is missed in this patch hunk:
>>
>> +	if (hub->reset_gpio) {
>> +		ret = dm_gpio_set_value(hub->reset_gpio, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		udelay(data->reset_us);
>> +
>> +		ret = dm_gpio_set_value(hub->reset_gpio, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		udelay(data->power_on_delay_us);
>> +	}
>> +
>> +	return 0;
> 
> The i2c sequence change is part of   [PATCH v4 4/7] usb: onboard-hub: Add i2c initialization for usb5744 hub of the series
> 
> +	if (data->init) {
> +		ret = data->init(dev);
> +		if (ret) {
> +			dev_err(dev, "onboard i2c init failed: %d\n", ret);
> +			goto err;
> +		}
> +	}
> +
>   	return 0;
> +err:
> +	dm_gpio_set_value(hub->reset_gpio, 0);
> +	return ret;
>   }
This does not seem to be part of the if (hub->reset_gpio) { ... } code 
block ?
