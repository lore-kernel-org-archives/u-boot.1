Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84BCC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14A388AF8;
	Mon, 26 Aug 2024 16:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724683210;
	bh=NaTfE2AKrDesEDs8xtu3+Qf2Y5sWuKIGEDVRtCzGzok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lf1w2V3BFtI4e26b51enrJ3yi5jfh0B6Nfwgq6F0SENHnk/FAqfW2w3WM26/MeOfM
	 drbE0AXtWZyvarYGu9hfrIJeoveLkMwlZl0XwFaToR/3OsKgEFUAy0OKGV7O4qfDKw
	 BQzdrKfZw4kbJsMGDReAjyfbdI1VRBLKGiMv/QkgWwQxR9yKR77zDb+hf7vqy/uJYN
	 xvUW4fprYdWeVU/dqY2so/ptotdraKpH8oB8kMyWDg/DzA8mrHYCYxfCUhUji62T2Q
	 Zdjr28NN8e5SgTLh0AHuCyTzVlvbHCW57zbZwSaYp4Sh8754om2Za006PK0o5CrAC7
	 DQ4SPWMnK/GJA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DCF0E88AD2;
 Mon, 26 Aug 2024 16:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724683210;
 bh=NaTfE2AKrDesEDs8xtu3+Qf2Y5sWuKIGEDVRtCzGzok=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KioOReVSSZ19sP7UMFO2tqTV0r60AWhYviHvGcOsyf0T/YiDHqUZ58vVinjhW7Fbs
 Cx1mAJZqvTeShxTLCLkfGanxSGoy8ZePkFwABUOhqRBRR2lzvaHN2DM5HTGrH+3RCz
 aoKiHjW996aRHjt1CyHsDgvjWt62TvcN3nzLmnXDIo8Zv8et9mHxfIoId6Y59dtgT3
 Jnuemt1asn2zGgH7XQcQAPPAWNbtwUb0hONao440F2L7Q3uefX744r4XfXILwOfrrW
 6wmUoXe5s9mOKux+VpEI/enZYPaW6EpuDfqmb9gHFwReY9PUfX8PWeWS6s3PFMMuq9
 WSMqy8sGRJs2g==
Message-ID: <4e154bda-6d7d-45b8-bb7d-ba4d0623a932@denx.de>
Date: Mon, 26 Aug 2024 16:40:09 +0200
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
 <5a278214-6343-418d-b1b4-05804585319c@denx.de>
 <c4e92485-439a-4216-a4d9-ab192e0bca80@denx.de>
 <CA+GyqeZ+_Lg7Jrga5N2+kAvWcM4Vtkv3hyqEs=+o583PoGw0Gw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+GyqeZ+_Lg7Jrga5N2+kAvWcM4Vtkv3hyqEs=+o583PoGw0Gw@mail.gmail.com>
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

On 8/26/24 11:12 AM, Zixun LI wrote:
> On Sun, Aug 25, 2024 at 2:13 AM Marek Vasut <marex@denx.de> wrote:
>>
>>>
>>> I am looking at the usb_add_gadget_udc_release() and
>>> usb_gadget_probe_driver() and I am thinking, sigh, all that code is
>>> ready to be replaced by something cleaner which does not use this
>>> special struct usb_udc and udc_list, but instead only uses U-Boot DM
>>> udevices . But I am reluctant to ask you to do all that rework, because
>>> that is WAY out of scope of the problem you are trying to fix.
>>
> 
> Thank you for looking into this, refactor udc core could make things clear.

Sigh, yeah, I think you ran into part of the UDC code which is just ... 
not great ... sorry about that.

>> Maybe this could be a start (compile tested only):
>>
>> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/usb-udc-udevice
> 
> Tested no regression with usba_udc.

Thanks for testing, patches posted.
