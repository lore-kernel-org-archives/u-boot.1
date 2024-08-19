Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49622C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 17:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB7A88D0E;
	Mon, 19 Aug 2024 19:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724088452;
	bh=Xd+D8MCcW7JMdt+syxVq009KEqHbSpVVTb+9+Pu6zzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pWbR/TNAV0L8P8mg3DDWfWecqw2hHYERockHTG4YgNZ686mnfcbeGjLMFnjtZs5Nz
	 Yy8FPkQbqKa0MzcPdRHulcz6iVxGS2We1OSzQYZuIoHWfu8fuxpCahLIhXr13meK9n
	 yLS81RoI7GWv7Y4T2PohUD71ebyYeP+NX2rqlAni2uMsYYDlIg29yT22ZvYIKGWFDA
	 QewbdKbrQLFU3v8IQ327ayTlGzAe/QYNph82wsamVOTusBraBLl1uJhuCN3pDa3jvZ
	 zU0BEiV0nEC5bQs7+73zGOlt9MdkEFCGIQWCzqb7ztpFECSjuc1loTMRXV+aXtM0dc
	 CkbKKmH7VePVw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C2C0E88CFB;
 Mon, 19 Aug 2024 19:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724088451;
 bh=Xd+D8MCcW7JMdt+syxVq009KEqHbSpVVTb+9+Pu6zzg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KM3bJJGkp08F9fWypYRFJmdhOuJ/EsFc/sj7sO51THIOZgEX+qscsWBbjr4AGQeei
 uWsHLoNnlZCK2ZEkfGhibtfjvugVWhkNHA4idIRy8nMXB011XDHPi0k831MlTIfURU
 WxKLpT3xFDZ3pghwIzPIZ3p7Mo/uoLZNbj1vNGoH/Em1JRtMdrMGD/fnuU5/0HhNzD
 MVou1aVX+gfTU59qSLv5WYpSknPCzc4a9vlAjM9Z0A1InNqgD2ceBx36UMxITXqQD6
 RX/i0GYIiVZ341fZMeZBIbo0JCrEUB0nspCLsnvh9WPC/2CPwmNBO5xEkrCpeAJ2aJ
 TJkAajjEfmVgw==
Message-ID: <baf69a18-e19f-49e5-82d8-c6a128147672@denx.de>
Date: Mon, 19 Aug 2024 19:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
To: Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
 <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
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

On 8/18/24 11:43 PM, Jonas Karlman wrote:

Hi,

>>> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
>>> data lines connected to RK3588, VBUS connected to the input regulator and
>>> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
>>> accessed via I2C from RK3588. The USB-C controller is needed to figure out
>>> the USB-C cable orientation, but also to do USB PD communication. Thus it
>>> would be great to enable support for it in the operating system.
>>>
>>> But the USB-PD specification requires, that a device reacts to USB-PD messages
>>> send by the power-supply within around 5 seconds. If that does not happen the
>>> power-supply assumes, that the device does not support USB-PD. If a device
>>> later starts sending USB-PD messages it is considered an error, which is solved
>>> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
>>> removed for a short period of time. For boards, which are solely powered
>>> through their USB-C port, like the Radxa Rock 5B, this results in an machine
>>> reset. This is currently worked around by not describing the FUSB302 in the
>>> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>>>
>>> 1. the USB-C port cannot be used at all
>>> 2. the board will be running via fallback supply, which provides limited
>>>      power capabilities
>>>
>>> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
>>> that we react to the power-supply's queries in time. The code, which is
>>> originally from the Linux kernel, consists of two parts:
>>>
>>> 1. the tcpm state machine, which implements the Type C port manager state
>>>      machine as described in the USB PD specification
>>> 2. the fusb302 driver, which knows about specific registers
>>>
>>> Especially the first part has been heavily modified compared to the
>>> kernel, which makes use of multiple delayed works and threads. For this
>>> I used a priorly ported version from Rockchip, removed their hacks and
>>> any states not necessary in U-Boot (e.g. audio accessory support).
>>>
>>> Sorry for the delay in getting PATCHv3 ready.
>>
>> I am the one who should be sorry here, really, sorry for the abysmal
>> delay in my replies.
>>
>> So ... this series looks good to me. Thank you for working on this !
>>
>> Jonas, are your concerns resolved ?
> 
> No, for ROCK 5B the full overwrite of the Rockchip common misc_init_r()
> in mach-rockchip/board.c should be fixed, rockchip_early_misc_init_r()
> could probably be used instead (or possible a PREBOOT cmd), see [1].

Can you use DM_FLAG_PROBE_AFTER_BIND instead of misc_init_r for this ?

drivers/led/led-uclass.c: dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);

This will probe the driver after it got bound, and you won't have to 
hack around board files or arch files for this.
