Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF499D597AA
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 21:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2947088F70;
	Tue, 12 Nov 2024 22:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731448426;
	bh=uTsapN8GRsewUGr7+LqoF6gvMusv1iIVoP5Sec/i8Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrWvY1Cv9z1YUsEW35w4UlM0jZQNCxLeYNv6WE2aw5KMg3WBCJ0CF2ZBjOKjHCAoU
	 srxtce/336oQl7IFI+cUNmOSi7MqqZUQFT9o8yQ/Iyu1cucVR093vI7+oOA6G73NR6
	 pQFkvPlyzGBuyo35LggG/e1t+Ig7qkU8Lo8DE0P8IMPjiV2ZW3c7ZE4xGmkR8S6Xvy
	 bSJGY7+0AtYkzIEJotWu1NcMSIM2R59QdaFi0qm/AOlZRYGpUXAo30VeoUF3jvV4JI
	 2VJ8HzkR3IyFGMOGKyBeHfjIhIUriugX7/yEVZ0aP89JS4hQy32JV/xiE95YgexQO4
	 E5LBaVwDetmEw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 47E7588D9E;
 Tue, 12 Nov 2024 22:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731448425;
 bh=uTsapN8GRsewUGr7+LqoF6gvMusv1iIVoP5Sec/i8Ro=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WvBOWbbp0xLKIzDf7qawuFYN1aFURCSJbOeIS4TJKD2OdJXapVFgJ55dA6KfnmRw8
 boNzTbBGW0YkxbwyGE5X4O8xuUbyO5QDWxV0CrjcbNPAxiZTSoPkWhH5o3LfzlRGTX
 +140NcdJM51zI5zKs3r9xLbThN9sU/41OmofTrWROnFnzh6oOmNFfE6lKiMZoJ592V
 qn71qMCVuCuXDxiN2lr/BgIu+Fz52g9FbM1JfkP7rDfgimmj+dzJ7lU30+1gUROGyU
 Cc6V3E0oqngQj5x1mVOBiHdoSTOFejBNcN1Hl38fPx8RYI+Q4qd+GHs+Lv1i2Zf2y0
 YfTm6FMfQONsg==
Message-ID: <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
Date: Tue, 12 Nov 2024 20:45:26 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 11/12/24 7:42 AM, Abbarapu, Venkatesh wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Tuesday, November 12, 2024 11:28 AM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
>> USB5744
>>
>> On 11/12/24 6:07 AM, Venkatesh Yadav Abbarapu wrote:
>>> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
>>> The usb5744 driver trigger hub reset signal after soft reset.
>>> The usb5744 hub need to reset after the phy initialization, which
>>> toggles the gpio.
>>> Also update the usb2514 hub_data with the reset delay as 1us.
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>> ---
>>>    common/usb_onboard_hub.c | 20 ++++++++++++++++++--
>>>    1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c index
>>> 827ecf9b02..1d146eccee 100644
>>> --- a/common/usb_onboard_hub.c
>>> +++ b/common/usb_onboard_hub.c
>>> @@ -88,10 +88,26 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>>>    	return ret;
>>>    }
>>>
>>> +static const struct onboard_hub_data usb2514_data = {
>>> +	.reset_us = 1,
>>> +};
>>> +
>>> +static const struct onboard_hub_data usb5744_data = {
>>> +	.power_on_delay_us = 10000,
>>> +	.reset_us = 10000,
>>> +};
>>> +
>>>    static const struct udevice_id usb_onboard_hub_ids[] = {
>>>    	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>>> -	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
>>> -	{ }
>>> +	{	.compatible = "usb424,2514", /* USB2514B USB 2.0 */
>>> +		.data = (ulong)&usb2514_data,
>> This ^ hub has to be updated in 1/7 , otherwise if only 1/7 is applied (e.g. during
>> bisect), this hub reset will be operated out of specification.
>>
>> Also, looking at the USB2514 datasheet figure 5-3, it seems the hub needs t4=500us
>> recovery time in SMBus mode. Does that mean usb2514_data .power_on_delay_us
>> = 500 is missing too ?
>>
>> Also, it seems t_rstio is 5us in USB5477 datasheet figure 10-4 , where do these
>> 10000us figures above come from ?
> 
> We were seeing i2c failures when we update the reset delay and power on delay values mentioned from the datasheet so updated to 10000us, the linux reference is below
> https://github.com/torvalds/linux/commit/908f61bedb2c40c6d856bbfd7f870b967a4cb498
Is there a matching delay requirement specified in the USB hub datasheet 
or is this a workaround for some board-specific behavior ?
