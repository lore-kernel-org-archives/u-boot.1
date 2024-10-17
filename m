Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D68AD2F7E1
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFD288E36;
	Thu, 17 Oct 2024 05:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729135006;
	bh=7eiNSibJRPXyVH26i7T4aB4KZ4+mnz4aF2UZoeiywds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dd7C3dATmPPmzfgIQIoOYCzz6IoxrYB2horTbRFkpcC2F3Pdyp4adlvQJlhD+yqVj
	 2kHt7sSChN56shdaFCZcIuF6shxdDmKv8EtAh4shRjyeHtJUy53iBJuOMHZhANu49r
	 +LRLhgVoz/M3TrFaRFyimW+WN/R+arcMZJzygJ3EX8h7kSJ7LMueB7WTlWcd8uaZd+
	 +iFOP3aP4i8O8gSuYoLpMUbFJj7w9T7rrf16ALKaTtf98hoEAULbxkCBvQNtOEJbmH
	 ryX3zl2IAVQ4cmD4P3qYLGjTIPnaec9rkIqm2axefH4rm3uXQHc89E8ybGx1XlImEG
	 gFHNcjFPejuHg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2C93688DE1;
 Thu, 17 Oct 2024 05:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729135005;
 bh=7eiNSibJRPXyVH26i7T4aB4KZ4+mnz4aF2UZoeiywds=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nvq7+wZfJZQIlyuXfiKslwMr/B9AlBxhgm8qJe0AH1/tRrrwbjOw1jVOd6sWVfuqF
 aNqWPc8j24xv53r5JCXm9OHlc1iO+YKXrfb09+ys+pHVteu7VQiKHoTesiLHq0Js99
 8+bi8EIcXOB1lt7qUVVxNlJDnCf6qhPV3SrwXCY8AnHYMRxJqVCH8PS1is9DX2TdWE
 /FrEKaXUdtzlTKPfA40G1Nn6e83kbidS6wzIfkqB5hGYmihyOCqwe+S/MdRCIF370w
 BTWup8bHwC3Dz6zyBYt6E9xwKebY2nzsIY4ox2JaDfrcNKJEeXUh21aLR5GgM4+UT8
 xOJf9Z8WVtC3w==
Message-ID: <d565c2a3-7cfc-4e4b-9e4d-1fbb6ba7243a@denx.de>
Date: Thu, 17 Oct 2024 05:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Maxim Kiselev <bigunclemax@gmail.com>
References: <20241015152719.88678-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241015152719.88678-1-sebastian.reichel@collabora.com>
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

On 10/15/24 5:26 PM, Sebastian Reichel wrote:
> Hi,

Hi,

> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
> data lines connected to RK3588, VBUS connected to the input regulator and
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
> accessed via I2C from RK3588. The USB-C controller is needed to figure out
> the USB-C cable orientation, but also to do USB PD communication. Thus it
> would be great to enable support for it in the operating system.
> 
> But the USB-PD specification requires, that a device reacts to USB-PD messages
> send by the power-supply within around 5 seconds. If that does not happen the
> power-supply assumes, that the device does not support USB-PD. If a device
> later starts sending USB-PD messages it is considered an error, which is solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an machine
> reset. This is currently worked around by not describing the FUSB302 in the
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
> 
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>     power capabilities
> 
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
> 
> 1. the tcpm state machine, which implements the Type C port manager state
>     machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
> 
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).
> 
> This version has been tested on Radxa Rock 5B using the open source TF-A
> (patches recently got merged into master branch) using the following power
> supplies:
> 
>   * non PD capable (reports 5V 0A)
>   * RavPower 90W
>   * UGREEN 100W
>   * Anker 45W
>   * RavPower PB
Applied all, thanks !
