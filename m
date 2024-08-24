Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5252CC52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 23:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E3288A2F;
	Sun, 25 Aug 2024 01:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724541791;
	bh=c6x8cAJw1rfq03/tYVDICRvtzfaJfc6qq/8x5KwaaI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o16BeHxHvDPiJK4VOoyJfNhtOxqJxNQs7ov9Uva19MrM72Hx0r/fVWl2FvXDSOHyJ
	 xOmHuy4SD8jDOe+9IXgqLDfX83bUn+ufJqlJTCXibgTM6QiNCiH8vZCE72wA8Io1nO
	 ZlkDLs1ibKCnTb2spA12fj+SVXMw1wG6yn6qBcpCzvb69lZEqh3+4//y7Ph2giwI5m
	 zXAfVlxyXQQzjFga5CQSzbsu+DYp4Utn/ee7TP+3MZt9IkoQ0akmwGXK5Mufn36UBS
	 W+BIPcyW3Keyl9+oY2ONrlQfGsrTUNHJqYto8SyznawRqExXV3gT1wcNwSoYd1u/jC
	 A7MuUIv84hgKg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 86B5D8877E;
 Sun, 25 Aug 2024 01:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724541790;
 bh=c6x8cAJw1rfq03/tYVDICRvtzfaJfc6qq/8x5KwaaI0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xTTnOdkAps544tJ+bD1i8rI4fXhMxkytaA7GscEYp5nuSrP+NNoFKWgjWRRrOjgie
 2LlBVMXOU8sIk7hqvW76W2XY+5UfNhRN2StWVCH5ud5g3M6X1EvpLR8L5c51YAkjVM
 iN3VboYs8SHXeCNAqMZvAnJdzixQcgYcDsuerwNpJgPJI9ORQFCcpQ8V+zVZSkg5bR
 Ma7rWOFOxOAzKyUma+aXatJCGhrpCLbo8j4VjBT5tskVVuvF+ST52d1rt++/Gj9QXb
 c50vyFO03GWeR9gZzet07r0tsqNXHb5+f4Iae5X8GKkjRghGPd1Oabvc5p3nqUXsw5
 dvFi2KOjNSFNg==
Message-ID: <5a278214-6343-418d-b1b4-05804585319c@denx.de>
Date: Sun, 25 Aug 2024 01:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+Gyqeair5Ak2-b32JL9PkoPrJaa9dg1NwQ3s+8+ycCxdv-HDg@mail.gmail.com>
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

On 8/23/24 11:22 AM, Zixun LI wrote:
> On Fri, Aug 23, 2024 at 4:54 AM Marek Vasut <marex@denx.de> wrote:
>>
>> I think udc_bind_to_driver() should not call usb_gadget_connect() , that
>> connect should likely be called by at some later point.
> 
> Yes it's more logical, to keep it in disconnected state you prefer modify
> controllers drivers init (I can do usba_udc and dwc2) or add a disconnect()
> call ?

I think modify the init is the best option.

>> I also think
>> that drivers/usb/gadget/udc/udc-core.c might have to be extended to
>> provide some way to convert controller struct udevice to struct
>> usb_gadget , so when e.g. run_usb_dnl_gadget() calls
>> udc_device_get_by_index() and obtains struct udevice * , it can also get
>> matching struct usb_gadget * , and call the usb_gadget_connect().
>>
>> What do you think ?
> 
> I think it's a good idea.
> 
> If there are multiple gadget controllers (very rare), since
> usb_gadget_probe_driver() simply takes the first one from udc list,
> is there a chance that the one to be started is different from the one
> used by udc_device_get_by_index() ?

Yes, I think that chance exists.

I am looking at the usb_add_gadget_udc_release() and 
usb_gadget_probe_driver() and I am thinking, sigh, all that code is 
ready to be replaced by something cleaner which does not use this 
special struct usb_udc and udc_list, but instead only uses U-Boot DM 
udevices . But I am reluctant to ask you to do all that rework, because 
that is WAY out of scope of the problem you are trying to fix.
