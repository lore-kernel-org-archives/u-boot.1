Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE10C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 18:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD4088CE9;
	Mon, 19 Aug 2024 20:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724090450;
	bh=7p8OK6+3TH9G33gjJbrI0xtgoCeeW1HXXzrE3awtRTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JzAFBMVIjAQvf7EcKd2CxCT+K67SUtBf72/Dh6mfnMe5+d0qqbv0McVP4LP9VzwhT
	 tDYUyUt/z0Ne1pUyZfA7ds5JqPqByp8fAzBW9V4jmCqkG3pfz1PUNf6VTgG6B2MSkr
	 bWFA3L5YWmZ/tDUYareDJ3oI8ZHcqvKVtg4aHP76zRQY/mIiLLHA1T4bq+9TMCRZcn
	 zNeG72GGm9vf0sfGDa0/x3a4AEZsHOFrLG+RC+3m+tfj8b1MVejrm+Q46+GqatKKRD
	 4lLacYVENgUMHfCzSPq27CYqbIiNj8GAlyJFprShPTDqgInYqZtfMpJqf5y2OmmBw4
	 3HLzVoQKqEXPg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B987888C9F;
 Mon, 19 Aug 2024 20:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724090449;
 bh=7p8OK6+3TH9G33gjJbrI0xtgoCeeW1HXXzrE3awtRTg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q3Ev6GyOIoTh0ABO9IKihtU5CRuySTu64MNGxYc4fba2aknVz7a7E1J98+DEewb/8
 wo2DAhCV4fbhyIJVduPGocG1du3EEKPO1h6lBjoOXy6BWNO/SSewso2GTQKRKSpenG
 jHxSmJwfU7hX4udQknvv9VBZGo2xkvxApFSVe3WaahBYUy8P0uPuUGRrH2hNX1QYhu
 HiMHMbgcLl7iwT7868ttnRozXQHXf8DNT8VYidnaMbmZYDC40HsLiLxrrC9w9hM+Bi
 xGFleHN58aquDNqM+oIDR1XjK4ZTXFE+MClrpQHcMuVWy77UDb+oK2fkqZeKXEJsVS
 fv9FACBL5/R6g==
Message-ID: <10150334-e1af-418d-9713-429bf53c3366@denx.de>
Date: Mon, 19 Aug 2024 20:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
 <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
 <baf69a18-e19f-49e5-82d8-c6a128147672@denx.de>
 <yi6wmt52ro5wg7baydfn6hixmv5ctfzcdfs7rrxy73oht3rc54@mxzn67zhfglt>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <yi6wmt52ro5wg7baydfn6hixmv5ctfzcdfs7rrxy73oht3rc54@mxzn67zhfglt>
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

On 8/19/24 7:38 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Aug 19, 2024 at 07:08:37PM GMT, Marek Vasut wrote:
>> On 8/18/24 11:43 PM, Jonas Karlman wrote:
>>>>> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
>>>>> data lines connected to RK3588, VBUS connected to the input regulator and
>>>>> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
>>>>> accessed via I2C from RK3588. The USB-C controller is needed to figure out
>>>>> the USB-C cable orientation, but also to do USB PD communication. Thus it
>>>>> would be great to enable support for it in the operating system.
>>>>>
>>>>> But the USB-PD specification requires, that a device reacts to USB-PD messages
>>>>> send by the power-supply within around 5 seconds. If that does not happen the
>>>>> power-supply assumes, that the device does not support USB-PD. If a device
>>>>> later starts sending USB-PD messages it is considered an error, which is solved
>>>>> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
>>>>> removed for a short period of time. For boards, which are solely powered
>>>>> through their USB-C port, like the Radxa Rock 5B, this results in an machine
>>>>> reset. This is currently worked around by not describing the FUSB302 in the
>>>>> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>>>>>
>>>>> 1. the USB-C port cannot be used at all
>>>>> 2. the board will be running via fallback supply, which provides limited
>>>>>       power capabilities
>>>>>
>>>>> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
>>>>> that we react to the power-supply's queries in time. The code, which is
>>>>> originally from the Linux kernel, consists of two parts:
>>>>>
>>>>> 1. the tcpm state machine, which implements the Type C port manager state
>>>>>       machine as described in the USB PD specification
>>>>> 2. the fusb302 driver, which knows about specific registers
>>>>>
>>>>> Especially the first part has been heavily modified compared to the
>>>>> kernel, which makes use of multiple delayed works and threads. For this
>>>>> I used a priorly ported version from Rockchip, removed their hacks and
>>>>> any states not necessary in U-Boot (e.g. audio accessory support).
>>>>>
>>>>> Sorry for the delay in getting PATCHv3 ready.
>>>>
>>>> I am the one who should be sorry here, really, sorry for the abysmal
>>>> delay in my replies.
>>>>
>>>> So ... this series looks good to me. Thank you for working on this !
>>>>
>>>> Jonas, are your concerns resolved ?
>>>
>>> No, for ROCK 5B the full overwrite of the Rockchip common misc_init_r()
>>> in mach-rockchip/board.c should be fixed, rockchip_early_misc_init_r()
>>> could probably be used instead (or possible a PREBOOT cmd), see [1].
>>
>> Can you use DM_FLAG_PROBE_AFTER_BIND instead of misc_init_r for this ?
>>
>> drivers/led/led-uclass.c: dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>>
>> This will probe the driver after it got bound, and you won't have to hack
>> around board files or arch files for this.
> 
> Jonas suggested the same. My response still applies:
> 
> Depending on the remote side (i.e. the power-supply) the TCPM state
> machine can take quite some time to get it into the "final" state.
> The worst I have seen was around 2 seconds.
> 
> Boards, which are not powered via their TCPM controller can survive
> a USB hard reset and do not need any U-Boot support. I think we do
> not want to add this penality to these boards.

Could you set the DM_FLAG_PROBE_AFTER_BIND flag only for systems where 
this is applicable ? Maybe use some DT property to decide whether or not 
to set the flag ?
