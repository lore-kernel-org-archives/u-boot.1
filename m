Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8607C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 15:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 377E188B47;
	Thu, 22 Aug 2024 17:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724340251;
	bh=vyXfQoAQfCPJ7gAsRe8pF1DlGskkp/bRyDdFJ70Ztl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T14uBbb/bDImJw8vnA1dKlBbu1zbZPUd7mLv50fdsSMhTCq59Yi8G/NXLa4d5ihEQ
	 F802gFf66EIB9MWWJpDEZDaKOXRC7qmiDmCo6vJutJdC2uG3c4Fner/lQ6oUMNuGVB
	 9YThXn3Hw7ZqVR5widZnpjZ+nZlgXuMFBM6ixduLWWGaHWS5WUqA615DinEc/1xRrJ
	 Vah80Pmrez14YyRWknVNdxkUEjXDZ11qwEst4POwpEmjy8/rR9TGP3/F98qCT7Na4E
	 xl6GQFRKMtfNL0kVHNk1kfFOrxITznRqEu9HtkxuhNHSgQLXhKnpYYBQ8Rl0qWPkKX
	 wWX9GlkLsFI7w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4A48088B1D;
 Thu, 22 Aug 2024 17:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724340249;
 bh=vyXfQoAQfCPJ7gAsRe8pF1DlGskkp/bRyDdFJ70Ztl0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yRiGb6LHM1Vnpl+fEss9Ic6psLzmMZHw1wJThyCXaaSLpE9LnX7gqUv9uu3h6Mpo/
 iZgAhdwecF40VdngLPoa4bBX/EGjdXrxE9muWVIcDiISwux7SsAPpbpiLYXZo1G5jV
 5p9FYEK+nxdf9nf2bHn8uku+Kra2njYlge+7e5P60B6zXd+I/0ZDjvJUUKFXin+UeI
 fkEy7U6F7ML5RwJJuI8veAyI1VsI635hCF5NlSy1+Qq/jb2PTb9had4D/ck38anlYA
 oOIcqA0DiauH+9VaEd+9fHeO1pe3WeUmBBHoD6twzQC32cmW1b0BMLhCOArCLeaUt+
 XLud9NTdc5OIQ==
Message-ID: <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
Date: Thu, 22 Aug 2024 17:19:40 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
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

On 8/22/24 11:11 AM, Zixun LI wrote:
> Hi,

Hi,

> On Thu, Aug 22, 2024 at 1:26 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Would it be possible to fix up the g_dnl ?
> 
> g_dnl's interface is pretty different from usb_ether, I can't find a
> way to access
> usb_gadget struct in g_dnl_register().

Can you change the g_dnl_register() prototype and pass he structure in ? 
I suspect it should be available in the commands which register g_dnl ?

> Meanwhile it can be fixed in udc core, by doing gadget_driver bind
> after udc start,
> in addition to keeping the controller in disconnected state.
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c
> b/drivers/usb/gadget/udc/udc-core.c
> index 6bb419ae2a..b917a79892 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -300,15 +300,17 @@ static int udc_bind_to_driver(struct usb_udc
> *udc, struct usb_gadget_driver *dri
> 
>       usb_gadget_udc_set_speed(udc, driver->speed);
> 
> -    ret = driver->bind(udc->gadget);
> -    if (ret)
> -        goto err1;
>       ret = usb_gadget_udc_start(udc);
>       if (ret) {
> -        driver->unbind(udc->gadget);
>           goto err1;
>       }
> -    usb_gadget_connect(udc->gadget);
> +
> +    /* Keep pullup disabled until interrupt is available */
> +    usb_gadget_disconnect(udc->gadget);

This is no good, this is a workaround, let's not do this.

> +    ret = driver->bind(udc->gadget);
> +    if (ret)
> +        goto err1;
> 
>       return 0;
>   err1:

[...]
