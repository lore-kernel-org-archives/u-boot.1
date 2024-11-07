Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE4D4334D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 11:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C7A89235;
	Thu,  7 Nov 2024 12:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730979337;
	bh=GOeYsgrlfC48dOaATB9UkADdr0uG/hVm7zSqiv4X7fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mVb0o3FiXT82WhD5SQvAgffkotHEcgRtkrK7E/STUHucMiLb4xk/V3mAljMihPj1b
	 FnorHWC8M50RAUxU1YGDSZKHcpGt5TfIMhNfQGHijitKM47cCzofnytaTUkBaTvNxK
	 f/aOE7Br3JE0NJnVj6azdNCWg662rj/MmjE//+yt/SFzbD/v0/FiHOaFbngb+I/VBH
	 1kn//4sSS3JO+gmzEB56RogWlzpZY04po8jDOFvkp1v8zxTfJgx1tnG+VCZOvnCF1P
	 QmY57Yg2VTL3H2GKykqZ+3xx53R8qhWgpgazhuEcy4OL814bNerBeFiaW2/8MX2Ilm
	 E1uVzW6N4+biQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C6E9488FF6;
 Thu,  7 Nov 2024 12:35:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730979336;
 bh=GOeYsgrlfC48dOaATB9UkADdr0uG/hVm7zSqiv4X7fk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=obdG0scFJqHkhiYa3DlDI1rPgQnFfxWl3mju7ASWojDmgS2q/yjcTBEzG8V//pWFz
 G6sG7KD2S+Imxb/14esIo7AtukK9vjM2DH57q5tuv0VODavKOub0x5yYhK4DSKbCgG
 w6Xy1kITpFOhNy67FTA6L6duczz9jzTXAK4U1B//KnuElaA+oUkbuite/hBVIXnF1P
 dFFT3B7Y3eDJ5GA384Q+GAhF+qWUSeCrLX1DiBGxIhvru3K3FMbcrVVUl6YTeFuODa
 r7fWTTRvAGNuigZlkUGIoLFt60ONQZO0emDdaM4aOTYRqTPKOnf1nB4ENV0htVekoA
 7RvwVQhWZwhZQ==
Message-ID: <fd5c36fb-8e27-4146-bec1-52c87045dd71@denx.de>
Date: Thu, 7 Nov 2024 12:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
 <20241030064314.28604-2-venkatesh.abbarapu@amd.com>
 <1ab82f5b-6e89-4c1d-990e-3936c8ffa489@denx.de>
 <SA1PR12MB869760E4493442CBBFFE6D41985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB869760E4493442CBBFFE6D41985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 11/7/24 7:05 AM, Abbarapu, Venkatesh wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Wednesday, November 6, 2024 6:04 AM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
>>
>> On 10/30/24 7:43 AM, Venkatesh Yadav Abbarapu wrote:
>>> As part of the reset, sets the direction of the pin to output before
>>> toggling the pin. Delay of millisecond is added in between low and
>>> high to meet the setup and hold time requirement of the reset.
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>> ---
>>>    common/usb_onboard_hub.c | 42
>> +++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c index
>>> 68a04ac041..4174575893 100644
>>> --- a/common/usb_onboard_hub.c
>>> +++ b/common/usb_onboard_hub.c
>>> @@ -7,14 +7,51 @@
>>>     * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
>>>     */
>>>
>>> +#include <asm/gpio.h>
>>>    #include <dm.h>
>>>    #include <dm/device_compat.h>
>>> +#include <linux/delay.h>
>>>    #include <power/regulator.h>
>>>
>>>    struct onboard_hub {
>>>    	struct udevice *vdd;
>>> +	struct gpio_desc *reset_gpio;
>>>    };
>>>
>>> +struct onboard_hub_data {
>>> +	unsigned long reset_us;
>>> +	unsigned long power_on_delay_us;
>>> +};
>>> +
>>> +int usb_onboard_hub_reset(struct udevice *dev) {
>>> +	struct onboard_hub_data *data =
>>> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
>>> +	struct onboard_hub *hub = dev_get_priv(dev);
>>> +	int ret;
>>> +
>>> +	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>>> +						  GPIOD_IS_OUT |
>> GPIOD_ACTIVE_LOW);
>> Is the reset GPIO always active low or should this respect the GPIO flags in DT
>> instead ?
> Yes...the reset GPIO is always active low.
How did you arrive at that conclusion ?

I can very much predict there will show up a hub which expects the reset 
to be active HIGH and this will have to be removed, so better remove it now.
