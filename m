Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA115C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 22:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D56C812BB;
	Mon, 27 Jan 2025 23:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738016595;
	bh=qdFS7AT/dT+hrirgh61lDqTXHh2fI1Jm37/xFkEy3p4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNGZQPbNGSuqi6LbCbHjMYqSTZdwcgwmEppetV8uAdrujm70TaxaVGDDmJSGALpVt
	 IcwITNsjI2kCzr4s+F6cHB6p14FD8LeqMGUICX0mO+pqDFA6YzsHkekSUqel8RrWax
	 waKdnPLPxZQMtH6hM7vqZA0eCip6ITowpD0bIG0nhReW7aZ5zO3/jxa4HEQ8tnyzi4
	 8+NbpSgyLYwwxvbaH/nzgdZx89x16hBmJGgo8p5QJmU4TrJkrwmMkBH2x6tM1BxL2D
	 1in0Y5iHG8NiUsOXiOXNha8inyNKmx34tjrpHZsSoGG019wVNfOQvHsMbbySCdSQrp
	 NAE3PbamvjePw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B19A812C8; Mon, 27 Jan 2025 23:23:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6330D81265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 23:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="e5S//gq2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B96E103802C2; Mon, 27 Jan 2025 23:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738016591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdFS7AT/dT+hrirgh61lDqTXHh2fI1Jm37/xFkEy3p4=;
 b=e5S//gq2QE7AsCnVBoDX2/LBLsQz8wir+ho3WgqVJV57XFkkvMdzlMjEwq1crJQyB33JRA
 Vsy+xrqV/FLgfuDN65LUumVpUWD/5QVzlkx0dxwQI+Bw5G47nEGtr1SNtCW/EzceE8Adv/
 JNVr488n3rHupqu4PdJhY/P56ZY0N8M1xI22RKlBFmTdZSqjV6HV0wUBjBF/Y8WTOz19kz
 j9Mg41SiF9MoUd9qe9hyPIX38HjYfIGTOvQXJ2RX3EpuwskRdl03UEG3c1sf4fHYY8AkSi
 oPycNQkVLPS6Wxbu/UoV695ihsjy6u1eTvkuiPyeO/rerx5oGsV0U3SAacInKg==
Message-ID: <5f794a65-eab4-4dde-9b44-eec6c97ff335@denx.de>
Date: Mon, 27 Jan 2025 23:23:09 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <6e2b3f3cdfbed67122725d22055d8877@manjaro.org>
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

On 1/27/25 11:20 PM, Dragan Simic wrote:
> Hello Marek,
> 
> On 2025-01-27 22:55, Marek Vasut wrote:
>> On 1/19/25 7:50 PM, Dragan Simic wrote:
>>> Selecting the CONFIG_SYS_CONSOLE_ENV_OVERWRITE option actually 
>>> prevents the
>>> CONFIG_USB_KEYBOARD option from working as expected, i.e. USB 
>>> keyboards end
>>> up not working as console inputs when "usbkbd" is properly specified 
>>> as part
>>> of the value of the "stdin" environment variable.  Describe this 
>>> clearly in
>>> the two relevant Kconfig files, to prevent any possible confusion.
>>>
>>> In more detail, the console_init_r() function ends up overwriting the 
>>> "stdin"
>>> environment variable so it contains only the devices available at 
>>> that point
>>> (which doesn't include "usbkbd"), while the "usb start" operation is 
>>> performed
>>> much later, at which point the probe_usb_keyboard() function cannot 
>>> assign any
>>> discovered USB keyboards to the console because "usbkbd" is no longer 
>>> present
>>> in the "stdin" environment variable.
>>
>> Wouldn't it be better to patch console_init_r() , check if "stdin"
>> variable contains 'usbkbd' and if so, start USB and register the
>> keyboard as stdin device at this point ? This is called after
>> relocation, so starting USB should be OK to do here. The behavior
>> should then be less confusing to users too.
> 
> Please correct me if I'm wrong, but isn't "usb start" deliberately
> left to be executed as desired by the supported boards, or as part
> of distroboot, i.e. in include/config_distro_bootcmd.h?

It is, but if the user needs USB keyboard as input device, shouldn't we 
probe for that (which yes, will make the start up slower) ?
