Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F40BC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 10:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95AF9866BB;
	Fri, 25 Aug 2023 12:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692959981;
	bh=1LIxYZrZKFXC4gm7tT+VX/Sk/q13pUXvMylj/WaA2pY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hgI0KKwoMEAa6RAS1SaCNl1y0gYvZORi+8vbHXEWddTItNRs0hxnYNhNjtn6EkXJz
	 jSoJbHwD2o1wHDVK8F4tx1pjabGZZMHpgiKrroWnzYKP4n26K2fX5cT6wm0LzW9Uro
	 R0kJupXm4Lo5r5/leOHNlbUDPXuq3kG0ZfX4jG6aNNoXTdx8ctPErOIVelxGAKKsky
	 NLsVNSsvSXeFbr1U18ZzafMz4eaItKiOneVrS+LNZLHILf8P2zb4WPEQu7BtOgitd8
	 cvocv4rtaf1ObdGgrmDinSBLSOch7yG2ibLZXweHkuP/d8x6rnQf1ZCt7Vh9MA67aU
	 bjCgmTtANA1AQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DAB93865D1;
 Fri, 25 Aug 2023 12:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692959980;
 bh=1LIxYZrZKFXC4gm7tT+VX/Sk/q13pUXvMylj/WaA2pY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BXqFsE1qfHYq8QEHW6KrYNVF3GAnC7z2egEaSP/fr941oSye6kixcASuCRidWnHox
 x4VuCu+o8RAdFie6/sU5ruI8U5UryUhphlO9TYGBJJiqVjppcpnYzFZZOosxQpTC24
 8CuGpdxgThnDozWIArBTsqAuIFY9jbn8CPRIrcG8mrLTaEBlFzo5KqNscSY7rcGdWL
 nFrS9Vn+ZUk5Fvlkm0MiIPhZAM765kjzqb7c3HVMOR6suZwz5GW5vLYbNfOMnm7Eub
 lj47g7XNotmAFQ6pQoHvvinjVoL2Zi79tPXwEifWD2hio1OSxwSXFaDx6e1eowDjYc
 Xgy1a5/KQSzvQ==
Message-ID: <7f4953cd-f0cb-2fba-e4d3-b1a24f35004a@denx.de>
Date: Fri, 25 Aug 2023 12:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
Content-Language: en-US
To: Oleksandr Suvorov <cryosay@gmail.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
References: <20230823182156.32353-1-oleksandr.suvorov@foundries.io>
 <3ff9dce0-4eee-16b8-9e8b-26842b4c9aef@denx.de>
 <CAGgjyvGj1WgvSMefWLopS+rPnbomDM17RgK8ahxRktTifTUYJw@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAGgjyvGj1WgvSMefWLopS+rPnbomDM17RgK8ahxRktTifTUYJw@mail.gmail.com>
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

On 8/25/23 12:27, Oleksandr Suvorov wrote:
> On Wed, Aug 23, 2023 at 9:29 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/23/23 20:21, Oleksandr Suvorov wrote:
>>> In the usb/dwc3-layerscape driver the first option should be renamed
>>> to the latter as well. Do it.
>>>
>>> Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
>>> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
>>> ---
>>>
>>> Changes in v2:
>>> - [asked by Tom Rini] shrink the code using CONFIG_IS_ENABLED()
>>>
>>>    drivers/usb/dwc3/dwc3-layerscape.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
>>> index 79cf71f7a85..58baa017ad1 100644
>>> --- a/drivers/usb/dwc3/dwc3-layerscape.c
>>> +++ b/drivers/usb/dwc3/dwc3-layerscape.c
>>> @@ -134,8 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) = {
>>>    };
>>>    #endif
>>>
>>> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
>>> -     !defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
>>> +#if CONFIG_IS_ENABLED(USB_HOST)
>>>    static int dwc3_layerscape_host_probe(struct udevice *dev)
>>>    {
>>>        struct xhci_hcor *hcor;
>>> @@ -194,7 +193,7 @@ static int dwc3_layerscape_bind(struct udevice *dev)
>>>                driver = "dwc3-layerscape-peripheral";
>>>                break;
>>>    #endif
>>> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || !defined(CONFIG_SPL_BUILD)
>>> +#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
>>
>> Why not CONFIG_IS_ENABLED(USB_HOST) here too ?
> 
> The original logic is not equivalent to CONFIG_IS_ENABLED(USB_HOST),
> so IMHO it would be better to fix it in a separate commit.

What's the difference ?
