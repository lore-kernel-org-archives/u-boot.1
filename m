Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ADAC5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 02:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E653888C2;
	Fri, 23 Aug 2024 04:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724381700;
	bh=Qj+KL64u4A6yrh4VPYuP5sCWtvP3+y7Is96MIXgvobw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qu829/K6POhrLf7urDWI1HbTOVnLnXYPEhEIAMsBaJFnNOAMH28XDl6YTr/9ogopN
	 U/qT4mPqewoR9U9y459bhKGaUflUGi1KkpG+XdgJ+UtFkxRICbVyxll5riBcwAuvuh
	 s2um3wKDjX4zxaxxjE24tuC1zz0wOkfv1/QLEavMTIvJDT4rutAglDmoGbl2FrSOB0
	 3Gimm8RHS/3V55RWX7vaR0YOxUvUgY7wBUGbfe18DmdFZdt6HbXnl13oB5YD0WScJ2
	 nkBnmDjCWaBeoq1zcpWkv2GETVYLUOmoyyozRwVN+cDD54XQQhdmMCFIO6IwmNWjfW
	 +rdPzSk3hJNbA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8BA1488670;
 Fri, 23 Aug 2024 04:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724381698;
 bh=Qj+KL64u4A6yrh4VPYuP5sCWtvP3+y7Is96MIXgvobw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AQab/ar+2rriuYVO+T2IzBFwUgmQIauCILvau6XzKkhA98OTHv7B4yjIcQcXOHqKE
 jmRH/8dhZOKwK9q962c8+lnxhPNrjA9emjo+1WaJEum1kOduSS42xbdHr5jgmSd7Kj
 hNYITSafMNI7Tc3cYwSSZHo0DDSx+Z+RKNJELdI9jN7HE68h51WjyUy3UfDGQoyI/a
 MFHggZl5qE0Yu+QO+t8DhgL73kpfMxCJjiiC0TqdYecTw9y2GRF23wVFW+GS6ZpfnD
 g4CCfaU6mRQAZOlQMsy08FrGJiYNxCIhp2tlGxcwyOERBvhAS2Ih8zbryAe2vaalD2
 Wudi/kwqAteqw==
Message-ID: <a86dd37e-2e55-4947-b665-06d68831b63a@denx.de>
Date: Fri, 23 Aug 2024 03:23:15 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+GyqebS7gVMpLJuMdxN9c8U=CpBLiTuFkqm_4-bA+LstLJpsQ@mail.gmail.com>
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

On 8/22/24 5:53 PM, Zixun LI wrote:
> On Thu, Aug 22, 2024 at 5:24 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Can you change the g_dnl_register() prototype and pass he structure in ?
>> I suspect it should be available in the commands which register g_dnl ?
>>
> 
> There are many places where g_dnl_register() is called, like fastboot, dfu, ums,
> etc, need to modify all of them ?

I think that should be possible with 'git grep' and 'sed' mechanically.

>> This is no good, this is a workaround, let's not do this.
>>
> 
> You mean which part, order change or disconnect call ?

Yes

> Is there a fixed order of udc_start (device init) and driver->bind ?
> In non-DM mode most device drivers do init first in their
> usb_gadget_register_driver(), except udc-core and DWC2 who does
> driver->bind first.

The driver .bind callback is called when the driver is instantiated 
(e.g. matching compatible string is found in DT, or some board file 
instantiates a driver and binds it to a DT node). This can happen very 
early.

The driver .probe callback initializes the controller hardware and is 
called only the first time the controller is used. U-Boot uses lazy 
hardware initialization to speed up the boot process, i.e. hardware is 
initialized the first time it is used, using the .probe callback.

The .udc_start callback in usb_gadget_ops must be called after the 
controller driver .bind and .probe were called.

The usb_composite_driver .bind has to be called after controller driver 
.bind (but it may be called before controller driver .probe).

I think udc_bind_to_driver() should not call usb_gadget_connect() , that 
connect should likely be called by at some later point. I also think 
that drivers/usb/gadget/udc/udc-core.c might have to be extended to 
provide some way to convert controller struct udevice to struct 
usb_gadget , so when e.g. run_usb_dnl_gadget() calls 
udc_device_get_by_index() and obtains struct udevice * , it can also get 
matching struct usb_gadget * , and call the usb_gadget_connect().

What do you think ?

> Call usb_gadget_disconnect here could avoid modifying all device driver's init.

[...]
