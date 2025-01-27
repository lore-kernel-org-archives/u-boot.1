Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3FC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D2C28198B;
	Tue, 28 Jan 2025 00:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738019026;
	bh=t9xou8zxoABtQ9r7aZ0ZLA6hiWzc8PVB3TyhF/9gOWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nbGC8lKKfuNyfPWk9o7pDVGwrBpNrAzDXWko7Tcbbi030KmlKU9UX36zCwxdivwn+
	 +whzSxLepZELg/GTjCWtG1JrN41NuAbg8Uuk9ov4H0iihjE9fPChIU/lfFfvrj4J6Z
	 ggDUCiVJ3nDmi+kInskkG0pK6Zax+9c2tKuCPbtzL0lrABDUaUdWsGEtS1FXJHKKUv
	 4T62CzyVTpCDsKQpQVy5IxA0xp09IUDrLmBXHYuduvYnsF1MSkOUhNBCXdcSDINv4d
	 wwkwBDKjA6iSscHYwpYKvgX1dHp1jA1kBNbZBpw5djP498AQCC4U6AndrVMsd/Br3c
	 HVWQxXZB1mIBw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545CE819B1; Tue, 28 Jan 2025 00:03:45 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C99812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cGjA9wQQ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 07FDA103802C2; Tue, 28 Jan 2025 00:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738019022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9xou8zxoABtQ9r7aZ0ZLA6hiWzc8PVB3TyhF/9gOWo=;
 b=cGjA9wQQz+qMU1fix9oOHSUz5RLVDTXLuF6wAXlmTz7eCmjbQkNBF+nK6OZC46GAPLmwnb
 760eI2umPoEx3JnT+xfuX3zbywCepnf52e8QUaZotBP13sr+l1knoP56L+mSBMturMqf8/
 T0jF7Zx729ZNFmnuz5/2PlqPMiDfln3mbw0F/MyfSxBzDqqImy/kPbAmKoCP7X+NXY8luZ
 pSDBDY/97ckUqH1WjUggL2AuIl+Uf6XF5YNM84DShaIS+S3AwEa3syu1booQaUEX0KBsZ/
 HkURVOauih9B5h7NZ364Ysx3dEpVnqOAv7mvGVkz08CHZ0ntUTFsqCHImS9h/w==
Message-ID: <8628a4ca-ca32-4f07-889f-0df66d6dee59@denx.de>
Date: Tue, 28 Jan 2025 00:03:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Make what it takes for "usbkbd" to work in "stdin"
 clear
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>,
 Piotr Zalewski <pZ010001011111@proton.me>
References: <4079f51c0141711cb4cb27f7aeb050b1b1e17828.1737312317.git.dsimic@manjaro.org>
 <29df2235-79c5-4cd3-bd78-cf7c93552167@denx.de>
 <6e2b3f3cdfbed67122725d22055d8877@manjaro.org>
 <5f794a65-eab4-4dde-9b44-eec6c97ff335@denx.de>
 <828c2c778a42fb2bad8d2318b24956bd@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <828c2c778a42fb2bad8d2318b24956bd@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/27/25 11:42 PM, Dragan Simic wrote:
> On 2025-01-27 23:23, Marek Vasut wrote:
>> On 1/27/25 11:20 PM, Dragan Simic wrote:
>>> On 2025-01-27 22:55, Marek Vasut wrote:
>>>> On 1/19/25 7:50 PM, Dragan Simic wrote:
>>>>> Selecting the CONFIG_SYS_CONSOLE_ENV_OVERWRITE option actually 
>>>>> prevents the
>>>>> CONFIG_USB_KEYBOARD option from working as expected, i.e. USB 
>>>>> keyboards end
>>>>> up not working as console inputs when "usbkbd" is properly 
>>>>> specified as part
>>>>> of the value of the "stdin" environment variable.  Describe this 
>>>>> clearly in
>>>>> the two relevant Kconfig files, to prevent any possible confusion.
>>>>>
>>>>> In more detail, the console_init_r() function ends up overwriting 
>>>>> the "stdin"
>>>>> environment variable so it contains only the devices available at 
>>>>> that point
>>>>> (which doesn't include "usbkbd"), while the "usb start" operation 
>>>>> is performed
>>>>> much later, at which point the probe_usb_keyboard() function cannot 
>>>>> assign any
>>>>> discovered USB keyboards to the console because "usbkbd" is no 
>>>>> longer present
>>>>> in the "stdin" environment variable.
>>>>
>>>> Wouldn't it be better to patch console_init_r() , check if "stdin"
>>>> variable contains 'usbkbd' and if so, start USB and register the
>>>> keyboard as stdin device at this point ? This is called after
>>>> relocation, so starting USB should be OK to do here. The behavior
>>>> should then be less confusing to users too.
>>>
>>> Please correct me if I'm wrong, but isn't "usb start" deliberately
>>> left to be executed as desired by the supported boards, or as part
>>> of distroboot, i.e. in include/config_distro_bootcmd.h?
>>
>> It is, but if the user needs USB keyboard as input device, shouldn't
>> we probe for that (which yes, will make the start up slower) ?
> 
> I agree that the way the whole thing works now, with or without this
> patch, leaves a fair amount of room for confusion.  That's exactly
> how I felt while writing this patch -- I was confused a bit about
> the possible outcomes of different combinations of the configuration
> options.  Though, I also felt that the way it works now also makes
> the whole thing as flexible as possible, so the users can choose
> whatever configuration they want, even the broken one.
> 
> I'm also afraid that, effectively, starting USB forcedly at that
> point may cause some unforeseen issues or regressions.
> 
> It also crossed my mind that perhaps a good solution would be to
> automatically deselect SYS_CONSOLE_ENV_OVERWRITE when the user
> selects USB_KEYBOARD, because that's needed for USB keyboards to
> actually work.  That should also have lower potential for causing
> some issues or regressions.

No, that's not good, users might want env overwrite to preconfigure 
their input devices and USB keyboard support at the same time.

> Maybe another good option would be to modify the console_init_r()
> function to simply leave "usbkbd" in the environment variables when
> USB_KEYBOARD is selected, so the "usb start" executed later can
> actually make USB keyboards work?  I think such an approach should
> have the lowest potential for causing some issues or regressions,
> while it would pretty much eliminate any confusion.

Yes, this looks like the best option, because if 'usbkbd' is in 'stdin' 
environment variable, the user likely expects the USB keyboard will show 
up later, but it is not available this early yet and removing it from 
stdin variable would be unhelpful.

Please also update SYS_CONSOLE_ENV_OVERWRITE Kconfig symbol description 
to reflect this change .
