Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A102CF34BE
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 18:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9391B88EE0;
	Thu,  3 Oct 2024 20:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727980089;
	bh=D9XPX4Nf+UR/VW2DwwbEH+emKy7+/tMZCZMBjcKhbA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKCL/nbBCEfspxyBhXPK0nh6DUJywmukXbmottrttSU+OMVDDYewkc+Spc8xub2LY
	 CPm5kayN55CEUxliLoBsdmoRRBQ1gveprTji/y5kFEhlUxRks59gvuS5RMUWelY3Gr
	 xdr9jqgPnwtp8+eHY45OJULjx8vPURRqP4o6xwDlWg1b3LP/E8FqzoEKykTZJ+37Rw
	 WYaZJcpgdJlYEf0rhZDHs49031ClT5RsB/v7FAFD/FnlOMEWeyot9539zi5WFeez0g
	 wB4x21BQ8EhUAhr6KYLjfzig61cwp1dYkxkm+ppuMYgU/6wJa/qn+FkzONGtWaMw7Z
	 NqUdmmvyaTPsg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4223688E7A;
 Thu,  3 Oct 2024 20:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727980088;
 bh=D9XPX4Nf+UR/VW2DwwbEH+emKy7+/tMZCZMBjcKhbA8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wyl3ppS4OHc7gQ6KHUfiTFhsP5KmVgTgQ4QBwF0p51J+zRCSiUTXcyzqqAwmlzCkN
 ZrtQBJ/egHXEq2U4VdQV4l0rK5g3aKIexqk2YW2eL5QiZxRE5z+nUwAcfcpCPDhVJ+
 tgeBHEppZXbkfGjZ6CfHKO23HE8mbr3pBUzoZV8NYdbDbFXxI21ZysEAC8i0Gb8Pf1
 MDbVNf2b92KI3Ag+JZgfa4dQwqVimUkI7DSo8uRw1lo94CYj+ufFDQ8jZUbNjJbkQx
 903xoUVLqlVsOCOMJ23NvgzxVjbWAanZwbkvt2jx8tZlbUqXBdyRXc5j3Wd88df6hX
 mrc0AiHXl8Ttg==
Message-ID: <c40f47cb-7245-43b7-9b01-6b8d1cdff04c@denx.de>
Date: Thu, 3 Oct 2024 19:05:04 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB8697682FEEE48B015EE82E0398712@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 10/3/24 4:54 PM, Abbarapu, Venkatesh wrote:
> Hi Marek,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Thursday, October 3, 2024 5:38 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
>>
>> On 10/3/24 6:40 AM, Abbarapu, Venkatesh wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>>>> @@ -30,7 +40,24 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>>>>>     	if (ret)
>>>>>     		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
>>>>>
>>>>> -	return ret;
>>>>> +	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>>>>> +						  GPIOD_IS_OUT |
>>>> GPIOD_ACTIVE_LOW);
>>>>> +	/* property is optional, don't return error! */
>>>>> +	if (hub->reset_gpio) {
>>>>
>>>> if (!hub->reset_gpio)
>>>>      return 0;
>>> <Venkatesh> As reset_gpio is optional property,  by returning 0 the i2c sequence
>> wont be executed.
>> The code in if (hub->reset_gpio) { ... } only toggles the GPIO reset ?
> <Venkatesh> Yes...if(hub->reset_gpio) only toggles the GPIO reset.
So you can return 0 if reset_gpio is NULL and exit early . What's the 
problem ?
