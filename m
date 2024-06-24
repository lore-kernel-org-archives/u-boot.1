Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA6CC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01D1882BE;
	Mon, 24 Jun 2024 15:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719237101;
	bh=l5esLF822d2YDovQTMfJaX00noifNIxMB1HWdd+c4Z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TB/VlWysRyMAJGBpaT+2TWpPRhRgIcSkou9MfREW9DOf42pfSREXrN2UUZ31GQL3r
	 rkNpUdzZRj1pVZouXxeicdrHuDsnqwebJmhIaXoKeQZ5g8qkwXpYEEKGuuJSZl6x7N
	 bjnI4g0efkodZRamSrKdWtTFnse2msm5DNu180uBTVaBTLsHCHXU+PXQ9qOtEfKBkJ
	 eELeBtiTd/Xc28X9+vnl8ticuIeW758/cor4pDZe3HMf6UH9LjiEPC0cjHt81Isi9k
	 9wFWppi4g/FHrVHBa0l7EYijR3MCNTLTF5aT52WZ1ESmgOzxWreTvsOD1bHbt2T+vk
	 OIrQP4vrKY15Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C3F2F809A8;
 Mon, 24 Jun 2024 15:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719237100;
 bh=l5esLF822d2YDovQTMfJaX00noifNIxMB1HWdd+c4Z4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=thMRcMWFY+2JoetMl4dzv0LKLDnxVrtxC6Oxk3XiUAIAIl6Ha9c+E9BCzYpg5/N36
 QwzTub1x3gA9BemmwREdprzr24VVbWKZggkuev9845ltmwUTY+aHf51mE8s9fFfQBH
 /2k1s2NkHFsIJqQdDleCYsci4jZ2EBzDAXUKh1xR1d6TygBGpq5yFQtZkxHCtVVNBs
 5COxKPAwg7X9u0uqlK3uDqafyx3xPqinEYBzzYAOtUsDgsxKwa0Wmw98U6GdWjNS1H
 amAmF5tLpCeoK/ydyHA29PnhpF4elm+o4AZqHV7PzltRKCGGUao4u12YnVVp8aF74T
 G0JY5tYRjGYXg==
Message-ID: <df42a5b3-a0f5-4db9-b13c-44e44f23a968@denx.de>
Date: Mon, 24 Jun 2024 14:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: respect role-switch-default-mode
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20240621021135.1600847-2-caleb.connolly@linaro.org>
 <be9fafa8-c3a1-4434-b344-caf32527460a@denx.de>
 <d6b9c6a2-235b-4f9f-8e88-9ba7a4f11f50@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d6b9c6a2-235b-4f9f-8e88-9ba7a4f11f50@linaro.org>
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

On 6/24/24 1:41 PM, Caleb Connolly wrote:
> Hi Marek,
> 
> On 24/06/2024 02:33, Marek Vasut wrote:
>> On 6/21/24 4:11 AM, Caleb Connolly wrote:
>>> * Factor out the common pattern of checking the dr_mode property on
>>>    the usb node and it's parent
>>> * Respect the usb-role-switch property, rather than requiring dr_mode be
>>>    set
>>> * Override OTG mode with the value in role-switch-default-mode
>>>
>>> The devicetree bindings don't dictate that dr_mode is a required
>>> property, but the dwc3 driver would refuse to probe if it was unset
>>> (this breaks the Qualcomm RB2 board which doesn't set it).
>>>
>>> Here, we update the driver to respect the other properties that can be
>>> used to describe the controller, and more gracefully handle some of the
>>> edge cases.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/usb/dwc3/dwc3-generic.c | 56 +++++++++++++++++++++++++--------
>>>   1 file changed, 43 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c 
>>> b/drivers/usb/dwc3/dwc3-generic.c
>>> index cbb5d61dfb0b..1cf8b90e8bbf 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -49,8 +49,46 @@ struct dwc3_generic_host_priv {
>>>       struct dwc3_generic_priv gen_priv;
>>>       struct udevice *vbus_supply;
>>>   };
>>> +/**
>>> + * dwc3_get_preferred_dr_mode() - Get the preferred DR mode for the 
>>> USB node
>>> + *
>>> + * Since we don't support dynamic role switching yet in dwc3, this 
>>> is a slightly
>>> + * opinionated wrapper around usb_get_dr_mode() which will respect the
>>> + * role-switch-default-mode property if it is present and the 
>>> dr_mode is OTG.
>>> + *
>>> + * @child: Node to get the DR mode for
>>> + */
>>> +static enum usb_dr_mode dwc3_get_preferred_dr_mode(ofnode node)
>>> +{
>>> +    enum usb_dr_mode mode;
>>> +    bool is_role_switch = ofnode_has_property(node, "usb-role-switch");
>>
>> The usb-role-switch DT property is not DWC3 specific, even in U-Boot 
>> it is used by e.g. STM32MP15xx which is DWC2. This should be added to 
>> core code.
> 
> I couldn't see an obvious way to add this desired behaviour without 
> risking breaking some existing boards. Do you mean keep this as a new 
> function but just move it to core code?

Yes, make this available to other drivers by placing it into core code.

> Or update the existing 
> get_dr_mode() function?

Better keep the get_dr_mode() as-is , I think the 
get_preferred_dr_mode() is a superset, right ?

You could prepare a conversion series and switch other drivers over to 
it, people can then test and selectively revert if something breaks.

>> Also, it would be really good to sync the DWC3 driver with more up to 
>> date Linux state, but that's out of the scope of this patch obviously.
> 
> Yes, I'm definitely feeling this. Last time I tried updating dwc3 as you 
> suggested (reverting all patches since the Linux import, updating, 
> re-applying)... But there have just been too many changes on the Linux 
> side for this to work anymore, and too many arch specific dwc3 glue 
> drivers which call into the core that might break.

I am hoping these arch/ drivers should have been cleaned up by now, what 
is there that is still open ?

> I would love it if we could figure out some path forward here, even if 
> that's just someone spending more than half a day on the porting effort :D

I'd love to find a way to update too.
