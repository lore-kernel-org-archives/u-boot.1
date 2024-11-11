Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC2AD3ABD1
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 17:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3F989340;
	Mon, 11 Nov 2024 18:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731346327;
	bh=OjmdmSvNOgaNGisxz/3EvbuCYSsfygaFJ4KtERRdUpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AIHoQpBYVWeoJgYo12RKcJWvq1RZwEoJPrrsUQsdbKG/Mh3CqSljNqDERp8FqYiNz
	 ikPgoy+0XAltlJ5+2w4saOFOIeujRuvt0Cqg9kl1EJGVqxdM4IHe6aYeMsD/Pmu4IB
	 B8xttt/Vxr2QGJcI++PaIF81wN1qO7uZrTz9F3P0+flN0/nd0ikGNgiws/LGJCDSUf
	 Upx97kYYAvX8UXRyHZp2YvIiqE3Zb1HBR6FUNoyEBKVfTk+DcOed7eW4Ib9YkPk9Ny
	 U2AAWaf0nknJoYM+YGwCOAAfsFDGF7SJVdEpUzRGpqdCPkz8xv9JsxA7Ji7mX59mHv
	 ZRlBAz/E0yMQQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 287AB89330;
 Mon, 11 Nov 2024 18:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731346326;
 bh=OjmdmSvNOgaNGisxz/3EvbuCYSsfygaFJ4KtERRdUpo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ao2/YK1pJtO6WiSmetqIjVGgfIuEEvowWbyKgsR7T9s3oDLIjFVwv+i8imdaQL3wk
 2YXdLhvY+dZZnGHEYXFNDRs8JnO/66Br42HVqI5LGVltYOXanRIYooINDO2GN/UsVB
 FMxyIYZoTJNJ89lj15ynnxI5SJN2mqy9s8DmGhwNkVyr/7YR0nh1HJTAw/JUIl9BF4
 U4mAzI7KdvMXDVa6B2kHxjvytWpA+Ks/lYj1D0wuZYJJILxXwNHvFwbWxhqB+QBsOh
 yfdvQIVbdAPxVZ/FWuHR0fo9MdPqhQdlYxZyHQWn/EI7pH9tPVI5seb9KR3TlyOg91
 n6PaFCXJz0cQA==
Message-ID: <a8ab9096-deaa-4266-90d5-c746f62515c7@denx.de>
Date: Mon, 11 Nov 2024 18:03:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
 <20241108035959.19970-4-venkatesh.abbarapu@amd.com>
 <33e22746-20fc-4956-a4c9-ef6723af33e0@denx.de>
 <SA1PR12MB869768EB5D98BA2231B89C3898582@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB869768EB5D98BA2231B89C3898582@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 11/11/24 3:10 PM, Abbarapu, Venkatesh wrote:
> Hi Marek,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Monday, November 11, 2024 5:44 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v10 3/7] usb: onboard-hub: add support for Microchip
>> USB5744
>>
>> On 11/8/24 4:59 AM, Venkatesh Yadav Abbarapu wrote:
>>> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
>>> The usb5744 driver trigger hub reset signal after soft reset.
>>> The usb5744 hub need to reset after the phy initialization, which
>>> toggles the gpio.
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>> ---
>>>    common/usb_onboard_hub.c | 15 +++++++++++++--
>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c index
>>> 827ecf9b02..e604c86d8a 100644
>>> --- a/common/usb_onboard_hub.c
>>> +++ b/common/usb_onboard_hub.c
>>> @@ -88,10 +88,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>>>    	return ret;
>>>    }
>>>
>>> +static const struct onboard_hub_data usb5744_data = {
>>> +	.power_on_delay_us = 10000,
>>> +	.reset_us = 10000,
>>> +};
>>> +
>>>    static const struct udevice_id usb_onboard_hub_ids[] = {
>>>    	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>>> -	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
>>> -	{ }
>>> +	{	.compatible = "usb424,2514" /* USB2514B USB 2.0 */
>>
>> Does this hub need any power_on_delay_us / reset_us delay too ?
>> Probably yes ? If so, please add the delay in 1/7 , otherwise there will be a fast reset
>> pulse on the reset GPIO line which the hub may either not recognize, or worse, may
>> make the hub latch up.
> 
> The hub "usb424,2514" is not part of this series,

That does not mean it is OK to break support for that chip by adding 
more functionality into a driver.

[...]

> Am not sure about the power_on_delay_us / reset_us delay for this hub.
I think it is in the table below Figure 5-1 of the public documentation 
for this Microchip USB2514 hub. Page 36 .
