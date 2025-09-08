Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ACFCAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 13:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2D282AE9;
	Mon,  8 Sep 2025 15:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PhJOk5IX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFA682C84; Mon,  8 Sep 2025 15:02:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971B9809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 15:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cL6Y832qkz9tFL;
 Mon,  8 Sep 2025 15:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757336524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktudsKXASCbagn79+oII8m08HIstYScfKbyPJ6U1jpo=;
 b=PhJOk5IXsTgBu4LSPB4rCJyUK2nkhMLaFInDO7Vb0vilPpNt4lFTs31kEmRI8DjqppYpmR
 kVShJ3qa4EVB04jfnpCEoRrAPr0GG/ThEcDfPswHfOXQB20iaaL3EBZ02dwhYP9aewdevo
 hmbteYPLH1dFTwkgVzlJ6hGlGOwgRuXb6lNqCZZ6L0qDqndvn1f7PMHTpmTcZXhkzMyhxs
 LSxfUVtyXCWAtAkcUF8OdJLTe3HluIuE9E+/6xz9wKTjmi5Y5tIKe7RQEm7ESyc0WukgLV
 RpJ3sYSjXPNnEDLIcAnnnVhrM7SVE3aaR/CnpIEzdEkkc2K+j1WXBttad25GWg==
Message-ID: <c5b7a8b4-2674-4857-a9f0-0576c1602f86@mailbox.org>
Date: Mon, 8 Sep 2025 15:02:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
 <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
 <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
 <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
 <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eb88117278ea0ef3148
X-MBO-RS-META: qrsopgnd3td9gney7qekgpjwxf8ptts9
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

On 9/8/25 10:44 AM, Ravulapalli, Naresh Kumar wrote:
> Hi Marek
> 
> On 02-Sep-25 11:48 PM, Marek Vasut wrote:
>> [CAUTION: This email is from outside your organization. Unless you 
>> trust the sender, do not click on links or open attachments as it may 
>> be a fraudulent email attempting to steal your information and/or 
>> compromise your computer.]
>>
>> On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
>>>
>>>
>>> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>>>
>>>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>>>> Hi Marek
>>>>>
>>>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>>>
>>>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>>>> Some USB devices need more time to be initialized. Hence,
>>>>>>> increasing the default USB Hub debounce timeout value for
>>>>>>> devices to be discovered, connected to Agilex5 boards.
>>>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>>>
>>>>>> Which devices are those, include that in the commit message.
>>>>>
>>>>> Yes, timeout is related to USB connect/disconnect signal bounces not
>>>>> about bus stability during init.
>>>>>
>>>>> Issue was mainly observed with legacy flash drives. Maybe I will 
>>>>> change
>>>>> commit text from "Some USB devices need more time to be 
>>>>> initialized..."
>>>>> to "Some old USB flash drives need more time to be initialized during
>>>>> connect or disconnect events ..."?
>>>>>
>>>>> Note that I am not modifying the default Kconfig value in general;
>>>>> change is only made for an SoCFPGA devkit we tested.
>>>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>>>> higher too ?
>>>
>>> No, changing USB HUB debounce timeout is working for us.
>> Look at this code:
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c? 
>> ref_type=heads#L199
>>
>> "
>> #if CONFIG_IS_ENABLED(ENV_SUPPORT)
>>         env = env_get("usb_pgood_delay");
>>         if (env)
>>                 pgood_delay = max(pgood_delay,
>>                                   (unsigned)simple_strtol(env, NULL, 0));
>> #endif
>>         debug("pgood_delay=%dms\n", pgood_delay);
>>
>>         /*
>>          * Do a minimum delay of the larger value of 100ms or pgood_delay
>>          * so that the power can stablize before the devices are queried
>>          */
>>         hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);
>>
>>         /*
>>          * Record the power-on timeout here. The max. delay (timeout)
>>          * will be done based on this value in the USB port loop in
>>          * usb_hub_configure() later.
>>          */
>>         hub->connect_timeout = hub->query_delay + HUB_DEBOUNCE_TIMEOUT;
>>         debug("devnum=%d poweron: query_delay=%d connect_timeout=%d\n",
>>               dev->devnum, max(100, (int)pgood_delay),
>>               max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
>> "
>>
>> Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>> should have the same effect. How come it does not ?
> 
> CONFIG_USB_HUB_DEBOUNCE_TIMEOUT and pgood_delay are used for different 
> purposes. If I am not mistaken I think I explained this in my earlier 
> comments.
> 
> Anyway, to further elaborate, CONFIG_USB_HUB_DEBOUNCE_TIMEOUT is used 
> for debounce timeouts during device connect events and pgood_delay is 
> used during initial VBus stabilization.
> 
> You would be able to see this difference in the link below, where 
> pgood_delay which is populated into "hub->query_delay" is used for 
> voltages to stabilize before initiating communication and "hub- 
>  >connect_timeout" where "HUB_DEBOUNCE_TIMEOUT" is populated is used 
> after getting the port status.
> 
> https://github.com/altera-innersource/applications.fpga.soc.uboot- 
> socfpga-dev/blob/b3772135cc63737dbe8e1180a2f8c0e2645590aa/common/ 
> usb_hub.c#L455
> 
> Also, the change made as part of the comment is not applicable to the 
> USB stack in general; it is only for our devkit defconfig.
But none of this answers my question, looking at the aforementioned code 
-- Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
should have the same effect. How come it does not in your case ?
