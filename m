Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98816CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB217868AE;
	Fri,  1 Sep 2023 12:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693562407;
	bh=47qWRovg+RfbEfOZipvvkP0mqnAWDIbxU21iEsST3s8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ul5P2xpgMrCV3aqa0ZJBj0Ice9vaBLtD1FHJArWs/wtjN570UcyDUa3YAdC1VBIzS
	 3kN8omr/7Z+D2+66mWBNjVx3RQ90DEhAlWjUrbQh0lYVfCZm+eIxjnDCNNjjMfwLV8
	 0oPkgQr6WMQxBUkeVHjcoTz0v6nSFPW9l4TkCw8QhSZc649VVlbDqKj/8QjuOWWshX
	 9uVnzwm1C2NSqaVJuUafds5JMgibapwN1UpTGDUg2eYR7TI+CPZVZjqHEnxI7ZArVK
	 m3DlVwdBHL4JrRVHcN0WUa15xPRfCH5byiqEh4wo6uphAIpiohhayETc95CgcGTeSx
	 dD9KFO+CtLfjw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 191B3868B1;
 Fri,  1 Sep 2023 12:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693562406;
 bh=47qWRovg+RfbEfOZipvvkP0mqnAWDIbxU21iEsST3s8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jNZ80fSN3qvTwno6SE0u7bR9uFK7tu27OTCp/x5OPKJMRcpITwrFfugKoe6/OgAqS
 7eR91mDvyqzAreDUBOWnMzOnuJHBON2TcYYFumUHEZJV+FxqKyv1Bg7mwiNlHLlyxq
 GpPWgjzhz5RYsU36hS5M57CEloSGWsV9kWu5rdDH4r5dVE5vulnnpojudn7z9v5RxX
 huIEvJcxu4RF0JJApaTHuOgdsffygY9UZN2SXHxqgobGoXzgMxo9M1EpNHjmVj0uhi
 VQFrhQkxDvfMVCh5FaAWmPT8GUhjmc3WV6dYIH3urMVG8e7HXsebt80E2Ueyrgw929
 /GsJ0ErTEcp8w==
Message-ID: <5989fa34-b97c-2055-8fd7-504230f9a8d6@denx.de>
Date: Fri, 1 Sep 2023 12:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] usb: host: ehci-generic: check for companion controller
Content-Language: en-US
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20230830080008.455157-1-fabrice.gasnier@foss.st.com>
 <4e4f480f-8f97-cf8a-fb55-8d1ebaffb993@denx.de>
 <8f54491e-47f8-5e58-5a44-f991dcf66616@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8f54491e-47f8-5e58-5a44-f991dcf66616@foss.st.com>
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

On 9/1/23 11:49, Fabrice Gasnier wrote:
> 
> 
> On 8/30/23 17:12, Marek Vasut wrote:
>> On 8/30/23 10:00, Fabrice Gasnier wrote:
>>> EHCI is usually used with companion controller (like OHCI) as companion
>>> controller. This information on the companion is missing currently in
>>> companion drivers.
>>> So, if the usb-uclass isn't aware, it may scan busses in any order: OHCI
>>> first, then EHCI.
>>> This is seen on STM32MP1 where DT probing makes the probe order to occur
>>> by increasing address (OHCI address < EHCI address).
>>>
>>> When a low speed or full-speed device is plugged in, it's not detected as
>>> EHCI should first detect it, and give ownership (handover) to OHCI.
>>>
>>> Current situation on STM32MP1 (with a low speed device plugged-in)
>>> STM32MP> usb start
>>> starting USB...
>>> Bus usb@5800c000: USB OHCI 1.0
>>> Bus usb@5800d000: USB EHCI 1.00
>>> scanning bus usb@5800c000 for devices... 1 USB Device(s) found
>>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>>          scanning usb for storage devices... 0 Storage Device(s) found
>>>
>>> The "companion" property in the device tree allow to retrieve companion
>>> controller information, from the EHCI node. This allow marking the
>>> companion driver as such.
>>>
>>> With this patch (same low speed device plugged in):
>>> STM32MP> usb start
>>> starting USB...
>>> Bus usb@5800c000: USB OHCI 1.0
>>> Bus usb@5800d000: USB EHCI 1.00
>>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>> scanning bus usb@5800c000 for devices... 2 USB Device(s) found
>>>          scanning usb for storage devices... 0 Storage Device(s) found
>>> STM32MP> usb tree
>>> USB device tree:
>>>     1  Hub (12 Mb/s, 0mA)
>>>     |   U-Boot Root Hub
>>>     |
>>>     +-2  Human Interface (1.5 Mb/s, 100mA)
>>>          HP HP USB 1000dpi Laser Mouse
>>>
>>>     1  Hub (480 Mb/s, 0mA)
>>>        u-boot EHCI Host Controller
>>>
>>> This also optimize bus scan when a High speed device is plugged in, as
>>> the usb-uclass skips OHCI in this case:
>>>
>>> STM32MP> usb reset
>>> resetting USB...
>>> Bus usb@5800c000: USB OHCI 1.0
>>> Bus usb@5800d000: USB EHCI 1.00
>>> scanning bus usb@5800d000 for devices... 2 USB Device(s) found
>>>          scanning usb for storage devices... 1 Storage Device(s) found
>>> STM32MP> usb tree
>>> USB device tree:
>>>     1  Hub (480 Mb/s, 0mA)
>>>     |  u-boot EHCI Host Controller
>>>     |
>>>     +-2  Mass Storage (480 Mb/s, 200mA)
>>>          SanDisk Cruzer Blade 03003432021922011407
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>>
>>>    drivers/usb/host/ehci-generic.c | 24 ++++++++++++++++++++++++
>>
>> More of a design question -- shouldn't the usb-uclass handle this
>> property ad manipulate with private data of "remote" devices instead ?
> 
> Hi Marek,
> 
> That's an option I haven't really explored earlier. I was a bit confused
> when I figured out the usb-uclass was able to manage the companion
> controller, by using the "companion" flag. But I couldn't find any
> driver that was actually using this flag :-O.
> 
> So I had a look at the git log, and I found out:
> - Companion has been introduced in:
> b6de4d1093d3 dm: usb: Add support for companion controllers
> 
> - First user for this flag was introduced in same series:
> 6a72e804a2b2 sunxi: ohci: Add ohci usb host controller support
> e.g. drivers/usb/host/ohci-sunxi.c
> 
> So, in the original design, the flag was set in OHCI controller driver
> side. This is why I implemented this in controller driver, but in EHCI
> generic driver, because it has the companion property (not in OHCI node).
> 
> - Later this driver has been dropped in, to use the generic OHCI driver
> instead: 543049ab5906 usb: host: Drop [e-o]hci-sunxi drivers
> 
> It looks like that setting the companion flag has been missed when
> moving to OHCI generic driver. I admit the strange thing with current
> approach is: implementation is done in EHCI driver, to impact OHCI
> private struct.
> 
> I'll send a v2, to handle this in usb-uclass as you suggest. This makes
> sense.

Thank you ! Esp. for digging in properly and solving this properly.
