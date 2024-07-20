Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0EEC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 20:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344D2885A8;
	Sat, 20 Jul 2024 22:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721506843;
	bh=FACQwJMc13R0AINv6879XcXTD5ckw5pknnAoZSdcKBc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pESRHBlo/hmdtlpB3oUgtDX+npKmJoIuzr2RDPgoh4iA0U0+BhqTdVW2xSVMxJjqZ
	 SrkpWR7z+rlPTEXu4jracUf1JYEDy7S8ENZlCxuaLQy8iRuCmhxxT0xA/9ywLgQg1v
	 uZM5sKCuMZBPHVmXoSRa7Sksi5WMRD3n2OPM7o2gYpNpy2T2kiFPLvES/Md6G/TlAE
	 DakNtfLLEe80zo76t1I5rbQ60WuvXoi/Mp6bgyY6R69grcDODTmkHfBNi7QIupfQmN
	 +5FfIzjA/Cv36e8pZ4NVrnx8fvhDTKwQbiuLnL5qXkxcN3iFUlGuS8kTV8TpbOopTP
	 1iMH1wDY9tICg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EDB11885A8;
 Sat, 20 Jul 2024 22:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721506841;
 bh=FACQwJMc13R0AINv6879XcXTD5ckw5pknnAoZSdcKBc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=GKwZ5xn4uV5OCnhl+xU9X8afvpIW5rdDURjB+d2D5smYHMjFbdHk7XrraMnC5izam
 h6tnEw2jdXuQL33aTmCiya04tBrXaO75jGXYILcuCiJ30FwB/CNNk5nYh8kK2fvQ6W
 2PYan11l0HI2oafvbaY2Tib92XHZ/dVpIOtiKM2wOVqD5Fo2L1+qXB/HT8RD8Bowue
 dLmjLkKemNimHqt0I1oY9z+KNVaM6CL1UOlmgZHyP6GOFIQIqUWe8b81fbS30nD0qs
 hQU5iVdKrZ6WMOm3BXEj5Lk2VbD+ov4uCcsaWnkENtuHWw0mQc80aKk9f24iFC7iTG
 75wtDxUPGWBrQ==
Message-ID: <7cd7bc33-a9c3-4235-9861-65d50338be45@denx.de>
Date: Sat, 20 Jul 2024 22:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb gadget driver initialization issue
To: Zixun Li <zli@ogga.fr>, Lukasz Majewski <lukma@denx.de>,
 open list <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <PAZP264MB2974BB43BCE300D4A9E2FC63B1AE2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAZP264MB2974BB43BCE300D4A9E2FC63B1AE2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/20/24 1:21 PM, Zixun Li wrote:
> Hi,

Hi,

> In udc_bind_to_driver(), USB device controller is initialized by
> usb_gadget_udc_start() and entered connected state by usb_gadget_connect().
> 
>  From the host's point of view, a device is ready to be enumerated.
> However, since dm_usb_gadget_handle_interrupts() is only called inside
> function driver, at this stage USB events are not managed, host's
> enumeration attempts will fail and resulting error like:
>      usb 1-1: new high-speed USB device number 50 using xhci_hcd
>      usb 1-1: device descriptor read/64, error -110
>      usb 1-1: device descriptor read/64, error -110
>      usb usb1-port1: attempt power cycle
> 
> I think it's better to leave the device in disconnected state while
> probing and connect it once a gadget function is invoked.

Can you please send an RFC patch ?

> I see recently there are many DM related reworking, please forgive me
> if it's already on the Todo list.

It is not on the ToDo list, no.

+CC Mattijs
