Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC72CD37B1
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 22:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143F788C21;
	Wed,  4 Sep 2024 00:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="GaWJjW2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B48588B49; Wed,  4 Sep 2024 00:26:59 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FDB881C1
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 00:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1725402405; x=1726007205; i=smoch@web.de;
 bh=Io7lryWBpJd/da8zllIhrJlG+AkvpQTFAF/PlgP/x/U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GaWJjW2mhsT0DY1gVSjShs7AkXkCVrPkhndLdSbo/exIZNmcgzs5dxlupRdLBvb9
 xaN3IbohiUrZ1EdyDE7j8WrTXIKKY5P+a+GQ4rxlKQskLbb4xPC2blsdpre0kpitS
 ery7GqLxmiTATFfotgRSWuVQX1YDzBj+LhmxfQIECKODQJjWqBSeuQ/ojwMV3FeQ9
 GXZObuvAzAuq1iOmv8Mb40IJ3lrLt8ur9t374P3a7dSLVdOJptTrLMFyClRG4VB+U
 uBvHBNxXuhHIvuxS4kTFU8ENxaCeXK0qIj2eke26/zSqCkGQh7WhLjbjMtgw4uQeN
 RfFiohyxnhu848Kq1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([77.191.123.194]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFdB-1sVRug1qEV-00YqdB; Wed, 04
 Sep 2024 00:26:45 +0200
Message-ID: <d17f96a6-8e24-41e6-900e-1e546b6bc42c@web.de>
Date: Wed, 4 Sep 2024 00:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240903182136.153196-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240903182136.153196-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nPJcOaMUTZuWYvDHaSELM1yCVoghoeHR9YYbZ65KyM14XIt5kDS
 1Sme23f3OaMwta91jggp9y9trOX+tb3BBXtml2wwmstuXa712A9m5YSBN8yjKhKoPEkcKZD
 ic8WSGxlw0XuwbwqDEASaBJ+47O2jtgr6zro9Ph5fNXzJct3VRbQLdm8GjfmIT9UCMuoFU/
 278YvffxHPY42SzG8ySNw==
UI-OutboundReport: notjunk:1;M01:P0:07DNaWmXwHU=;dYMXq9OIrj6VgcSRDHnav+ctFrF
 lyAfK0AbGndht8gWdheHyE7wymYJdSZq0kCfSxWbZL4Hvski11yj5IGGtHlummIh/r+QsHA5u
 O9CMGZO899E2O6B1o4IadNAALUWHcrmi/R+oa8oECMi/PcplObvkxv7s1G1mErl/gSZ/3qfVg
 m4QebVgbfRvgvvf2yOaQQneAC8DXg/vhDDPRO0R8SCOaNTBKuXphyfb3Gmy++yUULoT1DarDB
 cGv5P3CC1Qy87G1y5Bh/zYGjQmAshwQqR35z+7tQtgmQsBf0//p1RqQBDWEznEhLOShOR8BER
 Sx0k2lBUv5ITZxglQWvD6ncYrg1q+j8N24zW+l3T1I5gYBKAvrTluI65EvlQxszKPiXMeHiHp
 +Og7IRrBiY+lmkAZ5Oro2pQgGDoarePhaw0itQCZxpjIERgh+/LJVio13VqBSKU+5JtVAvlwR
 fE2UPwKIXwyrZTma5G7hPOjJJ1ksQLbRPhbSqoHroYHGiIdFqCi3YpChca+TwlnmXGcLhun8w
 tSxHLwe1VP2gTEtA+cfRq+C8cqRVXDbnKKX53/tmSZzYBdxyHnQFQENAnQzVODkRCWLKzDk0o
 NDdGUO6MbD0bRetSAQvZa/xlfAwDYFsgeS+4TZo3WpY8KA2+gBSbjwA1LcdfT+q6CoN5b3qIO
 x4D4wE7BXb/SeoovYHfxpE3WQVJDIs2qKLa79PJmgdAzIVT8DS6ZLOVXGk+b4/a52+crqEvw0
 MB8U8dHjEhyxvpLU6hGRpi0VeZqOKbWlOoJUcXBMm9swOahrrf/W+ukT/o8OGcYMqi+AAKb46
 vktLNKS3PPkfRQ+LYACzBrfw==
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

Hi Sebastian,

Thanks for new patch version!

On 03.09.24 20:16, Sebastian Reichel wrote:
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
> This version has been tested on Radxa Rock 5B using the open source TF-A
> (patches recently got merged into master branch) using the following pow=
er
> supplies:
>
>   * non PD capable (reports 5V 0A)
With a dumb power supply (actually 12V w/o USB-PD) I see a error message
(not really sure if that makes sense, but no strong opinion from my side)
and 5V/1.5A reported with 'tcpm info', see below.
Can we expect 1.5A as fallback supply w/o USB-PD negotiation? 5V OK, but
I'm not sure if USB2/USB3 type A to type C cables are allowed according
to the USB spec, with lower possible currents.

I'm not sure what the 'right' thing is to report in this situation
(also cable orientation makes no sense).
Just want to mention that I see something different here.
>   * RavPower 90W
>   * UGREEN 100W
>   * Anker 45W
>   * RavPower PB
>
> Changes since PATCHv4:
>   * Rebase to latest master (v2024.10-rc4)
>   * Fix regression introduced in PATCHv3: The exit code for fusb302_set_=
vconn()
>     when vconn stays the same should be 0 instead of undefined
>   * Fix regression introduced in PATCHv3: tcpm_set_polarity() needs to u=
pdate
>     port->polarity when there is no driver specific set_polarity functio=
n
I can confirm that these fixes indeed fix my reported regression from v2.
Booting to Linux works perfectly fine when powering from simple USB-PD
supplies (12V, 20V), as well as with power from my notebook computer.

So for the v5 series:
Tested-by: Soeren Moch <smoch@web.de>

I also tested powering from a UGREEN USB-C dock (see boot log below).
This also worked well. Only the data role was not switched correctly
to host as required for the dock. At least we got this 'not supported'
message probably related to that. Maybe that can be fixed later in
follow-up patches.

Thanks again for this great and very helpful rock-5b USB-PD support,
Soeren


Boot Logs:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D dumb power supply w/o USB-PD =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

U-Boot 2024.07-00006-g8b9f4ed46f (Sep 03 2024 - 22:11:56 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In:=C2=A0=C2=A0=C2=A0 serial@feb50000
Out:=C2=A0=C2=A0 serial@feb50000
Err:=C2=A0=C2=A0 serial@feb50000
Model: Radxa ROCK 5 Model B
Net:=C2=A0=C2=A0 No ethernet found.
Hit any key to stop autoboot:=C2=A0 0
=3D> tcpm list
| Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Parent name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Parent uclass
@ seq
| usb-typec@22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c@feac0000=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c @ 4 |
status: 0
=3D> tcpm dev usb-typec@22
dev: 0 @ usb-typec@22
=3D> tcpm info
Orientation: normal
PD Revision: rev3
Power Role:=C2=A0 sink
Data Role:=C2=A0=C2=A0 device
Voltage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.000 V
Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.500 A
=3D>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D dock + 20V USB-PD supply =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

U-Boot 2024.07-00006-g8b9f4ed46f (Sep 03 2024 - 22:11:56 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
fusb302 usb-typec@22: TCPM: Currently not supported type 0xb
Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In:=C2=A0=C2=A0=C2=A0 serial@feb50000
Out:=C2=A0=C2=A0 serial@feb50000
Err:=C2=A0=C2=A0 serial@feb50000
Model: Radxa ROCK 5 Model B
Net:=C2=A0=C2=A0 No ethernet found.
Hit any key to stop autoboot:=C2=A0 0
=3D> tcpm list
| Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Parent name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Parent uclass
@ seq
| usb-typec@22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c@feac0000=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c @ 4 |
status: 0
=3D> tcpm dev usb-typec@22
dev: 0 @ usb-typec@22
=3D> tcpm info
Orientation: reverse
PD Revision: rev3
Power Role:=C2=A0 sink
Data Role:=C2=A0=C2=A0 device
Voltage:=C2=A0=C2=A0=C2=A0=C2=A0 20.000 V
Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.750 A
=3D>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

