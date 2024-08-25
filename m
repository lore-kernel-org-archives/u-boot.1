Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06566C52D6F
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 00:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2893588A10;
	Sun, 25 Aug 2024 02:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724544808;
	bh=XRqwM7ysLpa1hCU22IV0getx5FT9dx+bdg+RrHae60Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ukQAQwVr184Mtwde7hn7aCAUDnwIjWx068SR0MBGqwoDiYHfztzyF4ouJUhTApjGx
	 9zTqsNsQgY7tj+OJy9dQf7sYF5/6CCkly9wHqTPttO23sO0rAeVelc4QcdxVdSufCH
	 PJhkBU7znHijdBpsCTgKILrxCuk+R/gupaUo+xp30KLTQuQro4wPOdiNkm/hmIj78b
	 6zVvqsel0nhEOdN4lPFcTBXG30PJwcS9OJSApF2BRKA6cHpZwya/fIzaZvG7srTkvs
	 eA8SaFHz1a5XK8uP8E3RzLfP4iBJUL/3QeH8RCBvf/eH1de1q3kjetfABrvFR1n0Dp
	 tYVg6a23bzdEA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF02E8839A;
 Sun, 25 Aug 2024 02:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724544806;
 bh=XRqwM7ysLpa1hCU22IV0getx5FT9dx+bdg+RrHae60Y=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=vKqDzKZBm/9M51KXaLCr5E1tko2KZOnfv/zioEOtiZfmKfWh1U00ILZdARIJju0fQ
 6vMGx2uxrguWJF80Y/pMmJSIDbPeMn9tEdUb4JQOJYktjWNLItw0qi+wzdLbFceA4w
 vQFaTVs5zXSgwAz1WidNwgWBm/LPuzqEX1BJwCffLPl5QdmZgcasDHuPc5PznFIinY
 PDh7HAw7f6aNEYNsidk0PyDUFpjQsF83n4kiSlPwAO/cUwcsMBGn/OfALlwcCBBbHU
 q0VkMnplKdcJB5EGwlV7JC+H7DLKc8UB+XuLLTVVp63Y3GJUDjmGbBRYFYm7nzzMlI
 8ZLOdoEm6JLig==
Message-ID: <c4e92485-439a-4216-a4d9-ab192e0bca80@denx.de>
Date: Sun, 25 Aug 2024 02:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
From: Marek Vasut <marex@denx.de>
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
 <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
 <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
 <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
 <CA+GyqebS7gVMpLJuMdxN9c8U=CpBLiTuFkqm_4-bA+LstLJpsQ@mail.gmail.com>
 <a86dd37e-2e55-4947-b665-06d68831b63a@denx.de>
 <CA+Gyqeair5Ak2-b32JL9PkoPrJaa9dg1NwQ3s+8+ycCxdv-HDg@mail.gmail.com>
 <5a278214-6343-418d-b1b4-05804585319c@denx.de>
Content-Language: en-US
In-Reply-To: <5a278214-6343-418d-b1b4-05804585319c@denx.de>
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

On 8/25/24 1:23 AM, Marek Vasut wrote:
> On 8/23/24 11:22 AM, Zixun LI wrote:
>> On Fri, Aug 23, 2024 at 4:54 AM Marek Vasut <marex@denx.de> wrote:
>>>
>>> I think udc_bind_to_driver() should not call usb_gadget_connect() , that
>>> connect should likely be called by at some later point.
>>
>> Yes it's more logical, to keep it in disconnected state you prefer modify
>> controllers drivers init (I can do usba_udc and dwc2) or add a 
>> disconnect()
>> call ?
> 
> I think modify the init is the best option.
> 
>>> I also think
>>> that drivers/usb/gadget/udc/udc-core.c might have to be extended to
>>> provide some way to convert controller struct udevice to struct
>>> usb_gadget , so when e.g. run_usb_dnl_gadget() calls
>>> udc_device_get_by_index() and obtains struct udevice * , it can also get
>>> matching struct usb_gadget * , and call the usb_gadget_connect().
>>>
>>> What do you think ?
>>
>> I think it's a good idea.
>>
>> If there are multiple gadget controllers (very rare), since
>> usb_gadget_probe_driver() simply takes the first one from udc list,
>> is there a chance that the one to be started is different from the one
>> used by udc_device_get_by_index() ?
> 
> Yes, I think that chance exists.
> 
> I am looking at the usb_add_gadget_udc_release() and 
> usb_gadget_probe_driver() and I am thinking, sigh, all that code is 
> ready to be replaced by something cleaner which does not use this 
> special struct usb_udc and udc_list, but instead only uses U-Boot DM 
> udevices . But I am reluctant to ask you to do all that rework, because 
> that is WAY out of scope of the problem you are trying to fix.

Maybe this could be a start (compile tested only):

https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/usb-udc-udevice
