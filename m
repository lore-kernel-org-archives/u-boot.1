Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BF7E7716A
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 01:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F07689543;
	Wed,  4 Dec 2024 02:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733276656;
	bh=P4a+xfyAC/go58ANdAJJd9j2aaKURCXXCb2jP6MKRpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IFI8HEDsCKeChQbWVrfPTDYTD9Wd6VLBumxxlvcUqUipNIlSMVKVGQU4E/t/HF/bu
	 cc8Rmewrk04/Kp9vpfiqO8tpnzFpNEKOLTyzKpbVuDn5liOwdYQd/4wBN7bfRgg7FX
	 S+ZWAXYXHpA07C+l1UB+a8wajflFudGEU83MZXl6LqKZ6tdeiLk0p2kQBOWHQz0pNO
	 t5LLZakNZ+5DJCMGaq8bPMjd3CCu5WmIQLCIgAerKsxtn/nx1MSH0f6HG5gCMyNJ2d
	 bkL8f6ZVUjthMBK0Df/M//YPjtzBeOXMB2/AYCUjhxNwz8hx+tk1PtIcvsxNL6h85T
	 aW4ghH6ZC9fBA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DE68A893A7;
 Wed,  4 Dec 2024 02:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733276653;
 bh=P4a+xfyAC/go58ANdAJJd9j2aaKURCXXCb2jP6MKRpc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zn7xlvtuCjrcL9y6A3U/uH107FNTrmLqQmWvEcwq3/JpjtCOEZyH4gFoYyWgi6sqb
 hiZj8jTBObLSAst29DFNjFQhFkQTsgHYtj6Eotnz8Z9g7EPfUwf9QRmEWRMyQoQd+C
 amlbkvNw5/+QFRYr8dobsWyM+1wRZid/7vhLOHNkwLO8WsiypsvD2LHWEkQJnw16tB
 aDQuQq6NK8lwwrp5urDcoVXib8bZG/jc2FfU496ATiJircrAIRLnm9EcG/jBghDISr
 Y+H3fWWrjZtPAWq8ROLJwl41hakTuC2nts8RvqvSedUPnSl9AECvbjN/oKHgjSPD71
 00+2bcVhCLAbQ==
Message-ID: <51f91bd8-e7c2-48de-9839-95694e8e86b4@denx.de>
Date: Wed, 4 Dec 2024 00:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Update the bind function based on
 "peer_hub" property
To: Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: fabrice.gasnier@foss.st.com, git@amd.com
References: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
 <d1abaa7c-cf34-457a-9b5b-f665b0fa4790@amd.com>
 <eeea93d6-c006-499b-b999-e50604669166@denx.de>
 <fc165f17-36e3-45f9-8522-588cd6fa682e@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <fc165f17-36e3-45f9-8522-588cd6fa682e@amd.com>
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

On 12/3/24 6:02 PM, Michal Simek wrote:
> 
> 
> On 12/3/24 17:24, Marek Vasut wrote:
>> On 12/3/24 2:44 PM, Michal Simek wrote:
>>>
>>>
>>> On 12/3/24 05:49, Venkatesh Yadav Abbarapu wrote:
>>>> Add the bool variable "peer_hub" and set this only for the
>>>> hubs which have the "peer-hub" property in their DT nodes.
>>>> Skip the bind function for usb hubs which don't have "peer-hub"
>>>> property.
>>>>
>>>> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is 
>>>> already probed")
>>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>> ---
>>>>   common/usb_onboard_hub.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>> index 6f28036e09..0a8fac38ee 100644
>>>> --- a/common/usb_onboard_hub.c
>>>> +++ b/common/usb_onboard_hub.c
>>>> @@ -26,6 +26,7 @@ struct onboard_hub {
>>>>   struct onboard_hub_data {
>>>>       unsigned long reset_us;
>>>> +    bool peer_hub;
>>>>       unsigned long power_on_delay_us;
>>>>       int (*init)(struct udevice *dev);
>>>>   };
>>>> @@ -178,10 +179,15 @@ err:
>>>>   static int usb_onboard_hub_bind(struct udevice *dev)
>>>>   {
>>>> +    struct onboard_hub_data *data =
>>>> +        (struct onboard_hub_data *)dev_get_driver_data(dev);
>>>>       struct ofnode_phandle_args phandle;
>>>>       const void *fdt = gd->fdt_blob;
>>>>       int ret, off;
>>>> +    if (!data->peer_hub)
>>>> +        return 0;
>>>> +
>>>>       ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, 
>>>> &phandle);
>>>>       if (ret)  {
>>>>           dev_err(dev, "peer-hub not specified\n");
>>>> @@ -212,12 +218,14 @@ static int usb_onboard_hub_remove(struct 
>>>> udevice *dev)
>>>>   }
>>>>   static const struct onboard_hub_data usb2514_data = {
>>>> +    .peer_hub = false,
>>>>       .power_on_delay_us = 500,
>>>>       .reset_us = 1,
>>>>   };
>>>>   static const struct onboard_hub_data usb5744_data = {
>>>>       .init = usb5744_i2c_init,
>>>> +    .peer_hub = true,
>>>>       .power_on_delay_us = 1000,
>>>>       .reset_us = 5,
>>>>   };
>>>
>>> I don't think this is correct solution. I think if optional property 
>>> peer-hub is not present in DT bind should return 0 and that should 
>>> fix issue on stm board where only one hub is present.
>> Shouldn't the 'peer-hub' property be mandatory for this hub ?
> 
> You can use this hub with usb2.0 only or with usb3.0 only. It means 
> peer-hub is correctly optional property. It is just saying when it is 
> there hub should be configured only once not twice.
> 
> It means right fix is when peer-hub property is missing bind should just 
> pass because it is just hub which don't use another ID.
OK
