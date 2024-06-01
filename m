Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2A8C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 17:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CCA087D83;
	Sat,  1 Jun 2024 19:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="fBTjV3OD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85A98816D; Sat,  1 Jun 2024 19:01:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50B287D4A
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 19:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1717261290; x=1717866090; i=smoch@web.de;
 bh=wtHkpPh89bNSQWK3xPwrAfaVpS8CoO++CDFzYX2SPUo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fBTjV3ODXrWLTkS7vb234UcvRX1bUdhULqu5fM8H8D3bxh5vaCcaH1VpSLF84Fi0
 5auF1AxUuu8XcOkLIy+PIbHxSQ/8nzu9F58dsQ8U0fVkPu6LKi4qZCgUP45ldXtAm
 aGx1fOsAb2jVXr3BkO/5iA8gY4MYvG6qUPqbHto0Ltskp5UYuD7VSeOkSQ6BbF5OW
 dJL/DRDPOAAO6uUeIOtVKaDDmQ3CYHsJ45mrIXzZF8gr0TczhREjA2zRU9a8Ar463
 yaPoJBabLxIfiUYTYRKKg4LHZWdh296hY0cBKTHdXytwm8XDZ6A7kblfOjD7cVi3w
 vKPDWrLxHmrA+lYKyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([89.12.189.183]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1s449j41lS-00R4kH; Sat, 01
 Jun 2024 19:01:30 +0200
Message-ID: <42ed8ab4-1e0c-4ba8-8fd8-affc0d425e7d@web.de>
Date: Sat, 1 Jun 2024 19:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240531151026.84846-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240531151026.84846-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qBClbBxw1lmrJ20QH4Ge0IrOEfmhGfjNaS2ZjdBS7mDaHyM60Ng
 brVglGralq7QbULeBjkCbuUVDDC1h1wafGUlpxw2QDjl7+smBtUJHm+aW733vr9LCbswLtx
 myP5y2shYFRk6ZjW7zwJ6u9xaALj6ztJ4E6izH6Ty3kG6Aq5p5yfe/WbSO34WdogyyqJXHL
 dmtLct9F/HueHjdEbdmNA==
UI-OutboundReport: notjunk:1;M01:P0:Wb3RgRTJT64=;lS1CoIzRfvgVwMRnsWyMoTGMqNj
 mNQzWZkdrtZq0mnZjFpyrDonP44RF3nXvbPMjjdtLGV8Jzroe5yYursfgHBxsw2LUWvEjzpI0
 i/gKlL+Bp2VrI15E2O07EnrIaey9PXlU5jDtaA5BjKC75a+jXnrPdgX2yHMM/umrEH/j1B4mV
 Yj7X2q8dKdwks+JJ8nnEAxTHRtqPv5oK7LniwrAypVSqn2Tf3TxY9yHGUKVBL/rUMuCm5t0AT
 VYzqRF22tLpQ9RfaJAYeKScDRiMXRMosOGp2tf7PKEfKPc/T+eMh1pIe462uRwy0+eVy/0ufA
 2zf4jlU9mzy3T7v8Wmo0YetlNeA8ftsFMki0YnJS0+qHMwehQwLnME1EPLNNG2jq2Hdg4WVMz
 Mditj358Ocfh1Hvh5St8t58jVCNE4WyuXeoO5X7a4Mtu1wfkZJXGMNzR+FSyJhCrZuv6s1kvO
 dkEIs/VLOp0F1ryjYjwZ+7vmV3287AliO27EScLctnFdt2xOuiDH0RhdZhOtg/F9zLqlLQRXh
 IDQZtcdHMcKVgjEORQHovLGzEpf6LIqCeUpaSHfwsQFla07B9B5jI9yBBYsJE5bjDCuooZFDm
 7eWj+cGNGO5yDYrQJw+XoZdd8YCz+5DnjxrQc/5vU7/xM1LYbRw/Eby20cLms6DZus5+gUQJs
 OJmg9FFD83+an14nA+cJX8853BkxtS97Uk4rcE5et4rcPb//+G8q5+RO0qTt0zBNsT4AOpEUp
 eWSXLnqwvda1kuCVdalPti09xNF38p34dADDc790pJdOpdfEb+7jDJD2n8cAl7G4eDkhG97yV
 h4jUV5exMdZzn046h4XkRTzqywFACTbI1AQKNugj2jDhI=
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

On 31.05.24 17:08, Sebastian Reichel wrote:
> Hi,
>
> On ROCK 5B power is usually supplied via it's USB-C port. This port has =
the
> data lines connected to RK3588, VBUS connected to the input regulator an=
d
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can b=
e
> accessed via I2C from RK3588. The USB-C controller is needed to figure o=
ut
> the USB-C cable orientation, but also to do USB PD communication. Thus i=
t
> would be great to enable support for it in the operating system.
>
> But the USB-PD specification requires, that a device reacts to USB-PD me=
ssages
> send by the power-supply within around 5 seconds. If that does not happe=
n the
> power-supply assumes, that the device does not support USB-PD. If a devi=
ce
> later starts sending USB-PD messages it is considered an error, which is=
 solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltag=
es are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an mac=
hine
> reset. This is currently worked around by not describing the FUSB302 in =
the
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>     power capabilities
>
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, s=
o
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
>
> 1. the tcpm state machine, which implements the Type C port manager stat=
e
>     machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
>
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).
>
> Greetings,
>
> -- Sebastian
>
> Sebastian Reichel (5):
>    usb: tcpm: add core framework
>    usb: tcpm: fusb302: add driver
>    board: rock5b-rk3588: add USB-C controller support
>    board: rock5b-rk3588: enable USB-C in operating system
>    MAINTAINERS: add TCPM section
>

I successfully tested this series on top of v2024.07-rc3.

Tested-by: Soeren Moch <smoch@web.de>



The highest possible USB PD mode of my power supply is negotiated
as desired:

U-Boot 2024.07-rc3-00005-ge829b94820 (Jun 01 2024 - 17:49:07 +0200)





Model: Radxa ROCK 5 Model B


DRAM:  8 GiB


Core:  355 devices, 33 uclasses, devicetree: separate


MMC:   mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0


Loading Environment from nowhere... OK


In:    serial@feb50000


Out:   serial@feb50000


Err:   serial@feb50000


Model: Radxa ROCK 5 Model B


Net:   No ethernet found.


Hit any key to stop autoboot:  0


=3D> tcpm list


| Name                            | Parent name         | Parent uclass
@ seq

| usb-typec@22                    | i2c@feac0000        | i2c @ 4 |
status: 0

=3D> tcpm dev usb-typec@22


dev: 0 @ usb-typec@22


=3D> tcpm info


TCPM State: SNK_READY


Voltage:    12.000 V


Current:     2.500 A


=3D>

Thanks,
Soeren
