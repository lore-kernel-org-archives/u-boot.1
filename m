Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905F9D63930
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 11:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92DA89699;
	Wed, 20 Nov 2024 12:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732103098;
	bh=sGTN5fzBxMcjqJOfzTlpjIHwWR23fsJlrakwsK+K3w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qltZwvSl6x4w7KC5EdI8oo0Fm0/2pTHRWHEUXh3jRGd8Zpqxc9YJkbfqfSQf1cnIf
	 sqiomrYAen1vmklpta2o2S0YaiXUYrWehVR21JvtB9smd9Vgt+zilPdErD0/MitbXK
	 Y62+QsZyKT5Pfvjz0LYYacPrwsY98jt77L4EL7NqXHiAbIp7j1FVpZYo3Kn0Izigmo
	 emBNkeEtAG6pH6KPuQirl8UmaKFJN7ZJgVRtst1YWIEmGcZ2eEWNhK9j0xsOHScDvq
	 aRAWrYxyAXkOYfa0JUl2K+LyHM3XJbXdkif3Auo+LiEJtbaKIhE3qE+10u+WUnRtQF
	 Ph2EwO4s0OcwA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9306289685;
 Wed, 20 Nov 2024 12:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732103097;
 bh=sGTN5fzBxMcjqJOfzTlpjIHwWR23fsJlrakwsK+K3w0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o+F44B4IdVyXj1fsZVqNkJaU/HIOmLRE5FZHmOgIDNYuSx7Khok4h5TV80Zht8cX8
 lGo4/9kWLvhxxLJQYQ7oe4ur3BYFD7gimQlUQlh8t3PO1XJOUTJynYBy4fBErce3S/
 Le1iWqQmDhO3oCl5WhcfUsf8wLC7pdpDVV2j/HDminS5BcAV45I/0cSNvrR4g+kcMR
 mB5YYL3n5KCPO07xuMjqGz7CBtoH2GBAk00euApm3Rmtu+XE5FWWTV1w14jky/WWsV
 +KfiQkq0KXl/E6AIv0Hirhl733OBF4jHz/mCTkFyGQayeP0u4T6B/EFrt3zX574LVC
 sOMFWccyUmYow==
Message-ID: <63680409-ee94-4b2d-85cc-14640e77b9ab@denx.de>
Date: Wed, 20 Nov 2024 09:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <20241112050740.15343-4-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
 <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
 <SA1PR12MB8697C5004BB109302CE441B198272@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5cd2a342-7208-4cf1-8faa-90dfd82ae5b0@denx.de>
 <SA1PR12MB86972FD15A7312EF59F1A5D298202@SA1PR12MB8697.namprd12.prod.outlook.com>
 <da8d990f-b2fa-4f21-bee5-7d609e9364b2@denx.de>
 <SA1PR12MB8697282F71C84463633BC7D598212@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB8697282F71C84463633BC7D598212@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 11/20/24 5:22 AM, Abbarapu, Venkatesh wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Tuesday, November 19, 2024 7:49 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
>> USB5744
>>
>> On 11/19/24 4:22 AM, Abbarapu, Venkatesh wrote:
>>
>> [...]
>>
>>>>>>>> Is there a matching delay requirement specified in the USB hub
>>>>>>>> datasheet or is this a workaround for some board-specific behavior ?
>>>>>>> The matching delay is not specified in the USB5744 hub document,
>>>>>>> but based on
>>>>>> testing on 2 boards with the above-mentioned delay i2c failures
>>>>>> were not
>>>> observed.
>>>>>> Is this 10ms a board-specific reset delay ?
>>>>>> Why is it in a generic driver ?
>>>>> On our boards we observed i2c failures when we set the reset delay
>>>>> as 5us and power on delay as 1ms as per the USB5744 datasheet. The
>>>>> reason of adding 10ms delay is because of i2c failures and the linux
>>>>> reference is
>>>>> https://github.com/torvalds/linux/commit/908f61bedb2c40c6d856bbfd7f8
>>>>> 70
>>>>> b967a4cb498 Do you have anything with respect to these delays, as
>>>>> you might have tested on some other boards? If anything, please let me know.
>>>> If the 10ms delay is a board specific delay, then this has to be
>>>> handled in a board specific way, not hard-coded in the driver.
>>>> Probably add some new property which specifies the extra board
>>>> specific reset delay, but be sure to run that property by the Linux kernel
>> maintainers too.
>>> Thanks. I will check how to add the board specific delay as new property.
>>
>> Add some reset-...-us , similar to what ethernet PHYs already do in DT.
> Sure...will check and initiate discussion with the Linux team.
> 
>>
>>> As this delay might be specific to the boards which we tested.
>>> There won't be any issue if we can add the default "reset_delay"(5us) and
>> "power_on_delay" (1ms) from the USB5744 datasheet, as other boards will be
>> working without any board specific delay?
>> Right, the driver has to be generic , that means it should contain delays specified in
>> the datasheet. Board specific delays have to be configured in board specific DTs.
> Thanks. I have updated the delays based on usb5744 specification in the
> [PATCH v13 3/7] usb: onboard-hub: add support for Microchip USB5744
> Please review.
V13 also enables the hub driver for Xilinx hardware, does it not ?
If so, won't doing so lead to incorrect behavior due to -- now -- too 
short delay ? I suspect you will need V14 which adds those board 
specific delays via DT for the Xilinx hardware.
