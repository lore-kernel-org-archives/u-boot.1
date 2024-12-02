Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198DAE69E81
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 19:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60135894F4;
	Mon,  2 Dec 2024 20:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733167422;
	bh=U3DQAyE9dmYNShW/oH7GkBzFUxVfOJCsWjq1sN5oD6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnlFtN32hmIaYXDF+7gzQ1VR0nh8wS2sYZCDnBBpwW2BDkFtDv1XYp37SBOi8tTjS
	 DQlGMUxuhjG60qrhkl9348jLBDje5j2lxs/mrmyBPjOlpmh9YTbXr9Y3l12yAuLZnJ
	 Hie6okG6gXNscvtJQqbIRfQ1gbmEgb7xUTC6PF3BEeQii2Mh5XbmOirPO0AJI/2eMQ
	 H2OJNVMKFA37PCUA19RoBUHC2X0Pc28URTyoeE0QQGQUXc65R8hZbcNdEE65wQwfXm
	 rKF5UFo4fBAB9/+Lx6IbKFSskiYqrsl4T6tzt7fkREgZLz3qCrZp5aaflP0uQ6to92
	 eVw40bL7nOVOQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2720F894B7;
 Mon,  2 Dec 2024 20:23:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733167421;
 bh=U3DQAyE9dmYNShW/oH7GkBzFUxVfOJCsWjq1sN5oD6w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UfRZ6He7CaaZx+wvO6cIewKvhk8jFoMql7BHnaBzdReNWJ+L0p6qBJQBBdqvcClpF
 EV6bRtIacwRp4MRxYGMVtld1QNzlzoH45jUWjpKENTblU8W8acOkFxVcN5Jxv0vkXQ
 oWCo650BHLYxfb26MWPcoIOXxSHnom0Ub0ewbilxAIBRRdaDlw4ZtRi17WXrz6aXWx
 mpwbE2EfEbz9EHoMVbi2ZiVj9ioDyJix8pDem4Jxzp03RKGH1yi7x6B1DZEJNcZwYw
 LgokFdLc0h1QgRtKAruVwglsuHX1yQUa8eO04EUGhmrEV31s64wR6UYXOQ+26wJ8Gi
 N9kHYvji4kNmg==
Message-ID: <ccccd1ec-0d2d-456e-aea8-9311f16be552@denx.de>
Date: Mon, 2 Dec 2024 20:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/5] usb: onboard-hub: Bail out if peer hub is already
 probed
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
 <20241125041202.980-6-venkatesh.abbarapu@amd.com>
 <b06d178a-3300-4f20-a852-bb9cf349a8b8@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b06d178a-3300-4f20-a852-bb9cf349a8b8@foss.st.com>
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

On 12/2/24 4:16 PM, Patrice CHOTARD wrote:
> 
> 
> On 11/25/24 05:12, Venkatesh Yadav Abbarapu wrote:
>> The .bind function is implemented to bind the correct
>> "half" of the hub that the driver wants to bind,
>> and returning -ENODEV for the other "half".
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>> ---
>>   common/usb_onboard_hub.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>> index bf71266272..6f28036e09 100644
>> --- a/common/usb_onboard_hub.c
>> +++ b/common/usb_onboard_hub.c
>> @@ -176,6 +176,26 @@ err:
>>   	return ret;
>>   }
>>   
>> +static int usb_onboard_hub_bind(struct udevice *dev)
>> +{
>> +	struct ofnode_phandle_args phandle;
>> +	const void *fdt = gd->fdt_blob;
>> +	int ret, off;
>> +
>> +	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>> +	if (ret)  {
>> +		dev_err(dev, "peer-hub not specified\n");
>> +		return ret;
>> +	}
>> +
>> +	off = ofnode_to_offset(phandle.node);
>> +	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
>> +	if (!ret)
>> +		return 0;
>> +
>> +	return -ENODEV;
>> +}
>> +
>>   static int usb_onboard_hub_remove(struct udevice *dev)
>>   {
>>   	struct onboard_hub *hub = dev_get_priv(dev);
>> @@ -218,6 +238,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>>   U_BOOT_DRIVER(usb_onboard_hub) = {
>>   	.name	= "usb_onboard_hub",
>>   	.id	= UCLASS_USB_HUB,
>> +	.bind   = usb_onboard_hub_bind,
>>   	.probe = usb_onboard_hub_probe,
>>   	.remove = usb_onboard_hub_remove,
>>   	.of_match = usb_onboard_hub_ids,
> 
> Hi All
> 
> This patch has been merged in v2025.01-rc3 (sha1 57e30b09fcfc88da72c310f979b35ed99a9b277c)
> and it avoids the STM32MP157c-DK2 board to boot:
> 
> U-Boot 2025.01-rc3 (Dec 02 2024 - 16:10:28 +0100)
> 
> CPU: STM32MP157CAC Rev.B
> Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
> Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
> Board: MB1272 Var2.0 Rev.C-01
> DRAM:  512 MiB
> usb_onboard_hub hub@1: peer-hub not specified
> initcall failed at call c0123da5 (err=-2: No such file or directory)
> ### ERROR ### Please RESET the board ###
> 
> This boards embeds a "usb424,2514" hub, regarding the Documentation/devicetree/bindings/usb/microchip,usb2514.yaml,
> this kind of hub doesn't need the "peer-hub" property.
Sigh ... thanks for testing.

Clearly this property is only needed for some devices, likely a boolean 
flag should be added to driver data to indicate a device requires this 
property ?

Please remind me if there is no fix by rc4 and I'll revert the series so 
it is not broken in 2025.01. Thank you!
