Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F365CC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4F981875;
	Tue, 28 Jan 2025 00:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="FvqXkDRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4ADF8187B; Tue, 28 Jan 2025 00:22:40 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA8E8186D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1738020157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bj8p6xL/3rRBw1CR6cZ9X/KLx199zh2no9rlqVwLxHg=;
 b=FvqXkDRbxr36s0ojI6l0Zd5Y+9/jbMu3pSlTnZw7Q0xztnHJ+c1L20tkJ8vb8W8i5EaDaG
 cN1b2qdVtTip8NxEmZf6fjjnUaKSFIpfoYzJGAL2I919Jw2jAUpUetI1IRIkLSRrOgh5AW
 tMFZidUM4Xg4Itwm3WX4wvfYXhjgMNHkhGei4JOzcZwJW5469lu2Ku6XE2cyP7/LVNcNg7
 bF6ASdRSH75jOQVHsLk3Rt/pxXDHdEIYX9/VgZ+uS303a510tmI/Htr0PzSCnJqEGns46k
 SoQ4JRA9JA4dz7eCj4hlr3u/8vU+qt+rwihipXDBLxibyCQBOXxhZKbN/F160Q==
Date: Tue, 28 Jan 2025 00:22:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>, Piotr Zalewski
 <pZ010001011111@proton.me>
Subject: Re: [PATCH] usb: Make what it takes for "usbkbd" to work in "stdin"
 clear
In-Reply-To: <8628a4ca-ca32-4f07-889f-0df66d6dee59@denx.de>
References: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
 <29df2235-79c5-4cd3-bd78-cf7c93552167@denx.de>
 <6e2b3f3cdfbed67122725d22055d8877@manjaro.org>
 <5f794a65-eab4-4dde-9b44-eec6c97ff335@denx.de>
 <828c2c778a42fb2bad8d2318b24956bd@manjaro.org>
 <8628a4ca-ca32-4f07-889f-0df66d6dee59@denx.de>
Message-ID: <34164148c3973297ab7eda29bf292846@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2025-01-28 00:03, Marek Vasut wrote:
> On 1/27/25 11:42 PM, Dragan Simic wrote:
>> On 2025-01-27 23:23, Marek Vasut wrote:
>>> On 1/27/25 11:20 PM, Dragan Simic wrote:
>>>> On 2025-01-27 22:55, Marek Vasut wrote:
>>>>> On 1/19/25 7:50 PM, Dragan Simic wrote:
>>>>>> Selecting the CONFIG_SYS_CONSOLE_ENV_OVERWRITE option actually 
>>>>>> prevents the
>>>>>> CONFIG_USB_KEYBOARD option from working as expected, i.e. USB 
>>>>>> keyboards end
>>>>>> up not working as console inputs when "usbkbd" is properly 
>>>>>> specified as part
>>>>>> of the value of the "stdin" environment variable.  Describe this 
>>>>>> clearly in
>>>>>> the two relevant Kconfig files, to prevent any possible confusion.
>>>>>> 
>>>>>> In more detail, the console_init_r() function ends up overwriting 
>>>>>> the "stdin"
>>>>>> environment variable so it contains only the devices available at 
>>>>>> that point
>>>>>> (which doesn't include "usbkbd"), while the "usb start" operation 
>>>>>> is performed
>>>>>> much later, at which point the probe_usb_keyboard() function 
>>>>>> cannot assign any
>>>>>> discovered USB keyboards to the console because "usbkbd" is no 
>>>>>> longer present
>>>>>> in the "stdin" environment variable.
>>>>> 
>>>>> Wouldn't it be better to patch console_init_r() , check if "stdin"
>>>>> variable contains 'usbkbd' and if so, start USB and register the
>>>>> keyboard as stdin device at this point ? This is called after
>>>>> relocation, so starting USB should be OK to do here. The behavior
>>>>> should then be less confusing to users too.
>>>> 
>>>> Please correct me if I'm wrong, but isn't "usb start" deliberately
>>>> left to be executed as desired by the supported boards, or as part
>>>> of distroboot, i.e. in include/config_distro_bootcmd.h?
>>> 
>>> It is, but if the user needs USB keyboard as input device, shouldn't
>>> we probe for that (which yes, will make the start up slower) ?
>> 
>> I agree that the way the whole thing works now, with or without this
>> patch, leaves a fair amount of room for confusion.  That's exactly
>> how I felt while writing this patch -- I was confused a bit about
>> the possible outcomes of different combinations of the configuration
>> options.  Though, I also felt that the way it works now also makes
>> the whole thing as flexible as possible, so the users can choose
>> whatever configuration they want, even the broken one.
>> 
>> I'm also afraid that, effectively, starting USB forcedly at that
>> point may cause some unforeseen issues or regressions.
>> 
>> It also crossed my mind that perhaps a good solution would be to
>> automatically deselect SYS_CONSOLE_ENV_OVERWRITE when the user
>> selects USB_KEYBOARD, because that's needed for USB keyboards to
>> actually work.  That should also have lower potential for causing
>> some issues or regressions.
> 
> No, that's not good, users might want env overwrite to preconfigure
> their input devices and USB keyboard support at the same time.

Indeed, I also don't like that approach very much.  It would reduce
the flexibility of configuration options significantly.

>> Maybe another good option would be to modify the console_init_r()
>> function to simply leave "usbkbd" in the environment variables when
>> USB_KEYBOARD is selected, so the "usb start" executed later can
>> actually make USB keyboards work?  I think such an approach should
>> have the lowest potential for causing some issues or regressions,
>> while it would pretty much eliminate any confusion.
> 
> Yes, this looks like the best option, because if 'usbkbd' is in
> 'stdin' environment variable, the user likely expects the USB keyboard
> will show up later, but it is not available this early yet and
> removing it from stdin variable would be unhelpful.
> 
> Please also update SYS_CONSOLE_ENV_OVERWRITE Kconfig symbol
> description to reflect this change .

I'm glad that you like it, I'll move forward with that approach.

I was also thinking about making sure that "usbkbd" gets removed
from the "stdin" environment variable if there are actually no USB
keyboards detected during the "usb start", but that would actually
be wrong, because a USB keyboard should be detected after being
plugged in (in interactive mode, of course) after "usb start" is
executed, followed by executing "usb reset" on the UART console.
