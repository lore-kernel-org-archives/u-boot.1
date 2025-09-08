Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E6BCAC582
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 23:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859FC80422;
	Tue,  9 Sep 2025 01:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nwmttymr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA66C82A9E; Tue,  9 Sep 2025 01:02:43 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B720800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 01:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cLMt65cLNz9swp;
 Tue,  9 Sep 2025 01:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757372558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEu5ekoXkTtBquCs6tXdG9WeSp+mTbkWRYY/HxhD/wQ=;
 b=nwmttymrIHLSP9cxI2+NzP4NDKdgRfgdnv2AYkLNWjmb+slF2+BIilJcvwBDqaK0hZ7VPc
 TiHKTpB6UBztclWQ9ZQHX0sEjb4duHs41xpU+izH0uXFt9zHoBO6TZ5eUqCEFXwaTDhkZT
 sXrdRn33D62MrPnNEqt9nul7EZnLRP+tLlxP9R5/iumzkEIrChJL9Xrgs9kDURgnnHYNg2
 3BAzT/X0fop/RtNGInkCqNeSw87f/+dSq2+UrC/BvlpmdttuQ/zpLuRy67ZbDYSBNul4it
 NfYfty0zCLb1Cx3CmuZvpadRzUD0EzGjiENyNza66HB8Khfbf2BLHs41t8F6mQ==
Message-ID: <74c4935c-1f8e-4fbd-a595-37fdc5c6ac3a@mailbox.org>
Date: Tue, 9 Sep 2025 01:02:37 +0200
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
 <c5b7a8b4-2674-4857-a9f0-0576c1602f86@mailbox.org>
 <0c103ea7-07af-4d01-a1e4-3d4d4819657c@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0c103ea7-07af-4d01-a1e4-3d4d4819657c@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fb428ab0be9de07cc97
X-MBO-RS-META: jxqxwumajpomfcrp36rkgxin8g7bagct
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

On 9/8/25 3:41 PM, Ravulapalli, Naresh Kumar wrote:
> 
> 
> On 08-Sep-25 6:32 PM, Marek Vasut wrote:
>>
>> On 9/8/25 10:44 AM, Ravulapalli, Naresh Kumar wrote:
>>> Hi Marek
>>>
>>> On 02-Sep-25 11:48 PM, Marek Vasut wrote:
>>>> [CAUTION: This email is from outside your organization. Unless you
>>>> trust the sender, do not click on links or open attachments as it may
>>>> be a fraudulent email attempting to steal your information and/or
>>>> compromise your computer.]
>>>>
>>>> On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
>>>>>
>>>>>
>>>>> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>>>>>
>>>>>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>>>>>> Hi Marek
>>>>>>>
>>>>>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>>>>>
>>>>>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>>>>>> Some USB devices need more time to be initialized. Hence,
>>>>>>>>> increasing the default USB Hub debounce timeout value for
>>>>>>>>> devices to be discovered, connected to Agilex5 boards.
>>>>>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>>>>>
>>>>>>>> Which devices are those, include that in the commit message.
>>>>>>>
>>>>>>> Yes, timeout is related to USB connect/disconnect signal bounces not
>>>>>>> about bus stability during init.
>>>>>>>
>>>>>>> Issue was mainly observed with legacy flash drives. Maybe I will
>>>>>>> change
>>>>>>> commit text from "Some USB devices need more time to be
>>>>>>> initialized..."
>>>>>>> to "Some old USB flash drives need more time to be initialized 
>>>>>>> during
>>>>>>> connect or disconnect events ..."?
>>>>>>>
>>>>>>> Note that I am not modifying the default Kconfig value in general;
>>>>>>> change is only made for an SoCFPGA devkit we tested.
>>>>>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>>>>>> higher too ?
>>>>>
>>>>> No, changing USB HUB debounce timeout is working for us.
>>>> Look at this code:
>>>>
>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c?
>>>> ref_type=heads#L199
>>>>
>>>> "
>>>> #if CONFIG_IS_ENABLED(ENV_SUPPORT)
>>>>         env = env_get("usb_pgood_delay");
>>>>         if (env)
>>>>                 pgood_delay = max(pgood_delay,
>>>>                                   (unsigned)simple_strtol(env, NULL, 
>>>> 0));
>>>> #endif
>>>>         debug("pgood_delay=%dms\n", pgood_delay);
>>>>
>>>>         /*
>>>>          * Do a minimum delay of the larger value of 100ms or 
>>>> pgood_delay
>>>>          * so that the power can stablize before the devices are 
>>>> queried
>>>>          */
>>>>         hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);
>>>>
>>>>         /*
>>>>          * Record the power-on timeout here. The max. delay (timeout)
>>>>          * will be done based on this value in the USB port loop in
>>>>          * usb_hub_configure() later.
>>>>          */
>>>>         hub->connect_timeout = hub->query_delay + HUB_DEBOUNCE_TIMEOUT;
>>>>         debug("devnum=%d poweron: query_delay=%d connect_timeout=%d\n",
>>>>               dev->devnum, max(100, (int)pgood_delay),
>>>>               max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
>>>> "
>>>>
>>>> Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>>>> should have the same effect. How come it does not ?
>>>
>>> CONFIG_USB_HUB_DEBOUNCE_TIMEOUT and pgood_delay are used for different
>>> purposes. If I am not mistaken I think I explained this in my earlier
>>> comments.
>>>
>>> Anyway, to further elaborate, CONFIG_USB_HUB_DEBOUNCE_TIMEOUT is used
>>> for debounce timeouts during device connect events and pgood_delay is
>>> used during initial VBus stabilization.
>>>
>>> You would be able to see this difference in the link below, where
>>> pgood_delay which is populated into "hub->query_delay" is used for
>>> voltages to stabilize before initiating communication and "hub-
>>>  >connect_timeout" where "HUB_DEBOUNCE_TIMEOUT" is populated is used
>>> after getting the port status.
>>>
>>> https://github.com/u-boot/u-boot/ 
>>> blob/328747974a0620d0996113fe2b3906b06e96de00/common/usb_hub.c#L455
>>>
>>> Also, the change made as part of the comment is not applicable to the
>>> USB stack in general; it is only for our devkit defconfig.
>> But none of this answers my question, looking at the aforementioned code
>> -- Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>> should have the same effect. How come it does not in your case ?
> 
> Maybe I wasn't explicit in my earlier comment, "No, changing USB HUB 
> debounce timeout is working for us."

USB_HUB_DEBOUNCE_TIMEOUT is basically the hard-coded-into-U-Boot-binary 
version of "usb_pgood_delay" . The upside of "usb_pgood_delay" is that 
users can change the value at runtime, which helps in case users need to 
use some broken USB storage device which takes more than 
"usb_pgood_delay" ms to start up. You cannot do that with 
USB_HUB_DEBOUNCE_TIMEOUT .

Since the commit description talks about "Some USB devices need more 
time to be initialized." , this looks more like "usb_pgood_delay" type 
of issue.

> What I meant is I didn't want to modify usb_pgood_delay as my issue was 
> with HUB_DEBOUNCE_TIMEOUT, so modifying this value worked for us.

Does it also work if you modify usb_pgood_delay instead ?
