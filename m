Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D70CA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 18:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FADB8331C;
	Tue,  2 Sep 2025 20:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LJ2laqDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644158331D; Tue,  2 Sep 2025 20:18:45 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2E7832EB
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 20:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cGYsD3BQMz9t9B;
 Tue,  2 Sep 2025 20:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756837120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MR6EE1kjKa0e11ol8aakADxwX3i89OniXPGgVg6+JXk=;
 b=LJ2laqDO32FZxLi1JGrukdeaFZ8owjzoAiSspFCVWQOGWMq6K+mg1NuFxBGlwMQd6NgrNG
 V8azLSKg5w4bHpHniszVMceMqqGbuTeD8hh7gjVmNzLw6FEldsz3hkY8WZixeikuoxP5fI
 aWv5GxP3qIfUlg51P8qjb1QCq06bbcZ6qFbhqgvy4brtfoCrAgBx9avJWw9NDuOcOSqiAY
 w7e0D4l69y+x85v2hke7DEkruchNQP38RahiEahivm1Ii5UPVMYnbkS2ff7996oUm+OQTY
 rxBBrXHElFgLLROT6e1DfFymdUuSs+PwhsNQ759ZWz/LkmF2Ar7mK6/NsA2YNg==
Message-ID: <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
Date: Tue, 2 Sep 2025 20:18:38 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ao3bmab8j6r58fwb396tj7a3q67grfck
X-MBO-RS-ID: 85c98edd8c5ab0a7119
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

On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
> 
> 
> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>
>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>> Hi Marek
>>>
>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>
>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>> Some USB devices need more time to be initialized. Hence,
>>>>> increasing the default USB Hub debounce timeout value for
>>>>> devices to be discovered, connected to Agilex5 boards.
>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>
>>>> Which devices are those, include that in the commit message.
>>>
>>> Yes, timeout is related to USB connect/disconnect signal bounces not
>>> about bus stability during init.
>>>
>>> Issue was mainly observed with legacy flash drives. Maybe I will change
>>> commit text from "Some USB devices need more time to be initialized..."
>>> to "Some old USB flash drives need more time to be initialized during
>>> connect or disconnect events ..."?
>>>
>>> Note that I am not modifying the default Kconfig value in general;
>>> change is only made for an SoCFPGA devkit we tested.
>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>> higher too ?
> 
> No, changing USB HUB debounce timeout is working for us.
Look at this code:

https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c?ref_type=heads#L199

"
#if CONFIG_IS_ENABLED(ENV_SUPPORT)
	env = env_get("usb_pgood_delay");
	if (env)
		pgood_delay = max(pgood_delay,
			          (unsigned)simple_strtol(env, NULL, 0));
#endif
	debug("pgood_delay=%dms\n", pgood_delay);

	/*
	 * Do a minimum delay of the larger value of 100ms or pgood_delay
	 * so that the power can stablize before the devices are queried
	 */
	hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);

	/*
	 * Record the power-on timeout here. The max. delay (timeout)
	 * will be done based on this value in the USB port loop in
	 * usb_hub_configure() later.
	 */
	hub->connect_timeout = hub->query_delay + HUB_DEBOUNCE_TIMEOUT;
	debug("devnum=%d poweron: query_delay=%d connect_timeout=%d\n",
	      dev->devnum, max(100, (int)pgood_delay),
	      max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
"

Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT 
should have the same effect. How come it does not ?
