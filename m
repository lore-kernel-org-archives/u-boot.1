Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C66AC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 15:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD7488AE5;
	Thu,  8 Aug 2024 17:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="rjI5augS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5A888B63; Thu,  8 Aug 2024 17:08:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119C88875C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 17:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1723129682; x=1723734482; i=smoch@web.de;
 bh=NC4wXngMwFS6u6sYSertB8HqZ6QkCUeOJ4bC3QPnWVI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rjI5augSWv4FWBD+8JVSxeWlUP9T5znJxpCo9L/4R6dm3tH4jUvFC299hjTvTukE
 hyTyYwP2eZNo2bZkc5otzNYG2xp3a0OH309AWFneI7gO/u1AlAj2U83y9MJrn191O
 vPV+mcQbbIOVD+4nzAYup1uwsttRRaYUIlTKw8iXb+q6UzhMiLB4ZPO3seidt8aoi
 pGIJYn7aIM0Y5Bwhs/0yRAEt0zds3/exPWX2kRQLo9CecgjgkCTd6/C9ZA0zGagiT
 P9jBQRxPmfUdKa99jNM680Phk+PDCtvP7lfZ5op7oipb8idHHMtUDePp3UzGyHVXU
 4kbmnncn7DQqUlNcWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1sodFM1rEc-00IeNs; Thu, 08
 Aug 2024 17:08:02 +0200
Message-ID: <98b8b3d1-aea4-4fea-af50-d8f2b675817e@web.de>
Date: Thu, 8 Aug 2024 17:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
From: Soeren Moch <smoch@web.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <9c5078f1-ba80-464c-8778-365117457eaa@web.de>
 <7f7acdaa-c220-49c3-8cfb-023a1f493d20@web.de>
Content-Language: en-US
In-Reply-To: <7f7acdaa-c220-49c3-8cfb-023a1f493d20@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nnn0RNRGAgfXJ6o8rD5ziJ6EJbjgzxtDwhs6aa5e/Q2RybF9hZb
 bsCseKMNuyxFCZoGmucAF9m/IO2YyBAxBaqX8BE/vF6cTPAp00v7eKJwXLDvO749OGNJKbH
 DqwDV+xz2SATYvVi326t8tQQ8gcd1EiGeg6ygLiuQMehmFk9+iXWZQsv0jXw3lDpK4VxK6d
 AZzmZKE1HEDbXGGx8jqEA==
UI-OutboundReport: notjunk:1;M01:P0:oyr4k9OObeg=;Zf1OFC+gNaIk+Y3h0uTrTh6YSfz
 DCGHvwfP8I+6eEsSIq6jPgJfJf/SKjcsdlzWmw07H5Aqio6uN2B4/C5XlUnYOCeAEyi3THps0
 DtgTkf+Ykm0Sn2gbpIdDwc76vH8X+gqP2/VnfGm/AQnbAssK1JBDpCE1OPhOr7Nm3fLH4gFAm
 maHoauXOmM8ZphH+Sgz0+XFnzDDqPhmSY7PGVQIHO7fE99Zq5HMcWlU+G0LdFvOGGbKft3RLI
 /xIyGqSsAmZcwlQu9UNO/wUfHUCREXkKcJG5EL/1fIbRBnLhj9t55DTv3U0YChEmTGG5zTdkP
 oxy0A+flEkEHJpESLO8Obmi4aeqe70zgO6SX7SV1DqmamXf95Jgq/Ox6GyEj3FxWB1viLuFH1
 fjnjvbcVSHZpU8f7vBu39wfKyMTzZKd7eV2C7bveERtMkjX6mZTceWQq+Qt12c8t9NOaCYqDj
 nxEZYHDthwiFAmpLKFPDH8r99yJSGSNx1fSIxRhs4t9wVnpXYU2v23fWqFhfwxL4T1EEJBsmQ
 VHgzj0iXIdTHXQ04mDvpH2rkyUblJV2j89kc1PM3xjCZhLbKv5EkVK2R/nF8OoMquGv2i+2Ls
 QZRlEd/W9nAqCfYvWj3HzjSjZGdMBfCEPGYuChHUKVuTi7iZXxIrJ/NN2SSXWdjr7s8+/q6Va
 lbAijZ5o3atyl7+/KSx8i+F6ATcdr0GC/X2SUSBXkr3lXNTgJ+I6tGKMs5/uA/51zqRgF9gMX
 A5zInfyzzXA3SMCF9Yt4G6cOolbwqw9fFkEObKiYz3oRGLyrgesQn6g3tVGD5AC+NffE8QGat
 9iunK/X9ZqvM8bRcHG9lC9AQ==
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



On 08.08.24 16:34, S=C3=B6ren Moch wrote:
>
>
> On 08.08.24 15:58, Soeren Moch wrote:
>>
>>
>> On 02.08.24 19:59, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On ROCK 5B power is usually supplied via it's USB-C port. This port
>>> has the
>>> data lines connected to RK3588, VBUS connected to the input
>>> regulator and
>>> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which
>>> can be
>>> accessed via I2C from RK3588. The USB-C controller is needed to
>>> figure out
>>> the USB-C cable orientation, but also to do USB PD communication.
>>> Thus it
>>> would be great to enable support for it in the operating system.
>>>
>>> But the USB-PD specification requires, that a device reacts to
>>> USB-PD messages
>>> send by the power-supply within around 5 seconds. If that does not
>>> happen the
>>> power-supply assumes, that the device does not support USB-PD. If a
>>> device
>>> later starts sending USB-PD messages it is considered an error,
>>> which is solved
>>> by doing a hard reset. A USB-PD hard reset means, that all supply
>>> voltages are
>>> removed for a short period of time. For boards, which are solely
>>> powered
>>> through their USB-C port, like the Radxa Rock 5B, this results in an
>>> machine
>>> reset. This is currently worked around by not describing the FUSB302
>>> in the
>>> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This mean=
s
>>>
>>> 1. the USB-C port cannot be used at all
>>> 2. the board will be running via fallback supply, which provides
>>> limited
>>> =C2=A0=C2=A0=C2=A0 power capabilities
>>>
>>> In order to avoid the hard reset, this adds FUSB302 support to
>>> U-Boot, so
>>> that we react to the power-supply's queries in time. The code, which i=
s
>>> originally from the Linux kernel, consists of two parts:
>>>
>>> 1. the tcpm state machine, which implements the Type C port manager
>>> state
>>> =C2=A0=C2=A0=C2=A0 machine as described in the USB PD specification
>>> 2. the fusb302 driver, which knows about specific registers
>>>
>>> Especially the first part has been heavily modified compared to the
>>> kernel, which makes use of multiple delayed works and threads. For thi=
s
>>> I used a priorly ported version from Rockchip, removed their hacks and
>>> any states not necessary in U-Boot (e.g. audio accessory support).
>>>
>>> Sorry for the delay in getting PATCHv3 ready.
>>>
>>> Changes since PATCHv2:
>>> =C2=A0 * Rebase to latest master (a70d991212c9)
>>> =C2=A0 * Drop Wang Jie from Cc, since his address bounces
>>> =C2=A0 * I did not add a test suite. I fully agree, that it would be n=
ice
>>> to have
>>> =C2=A0=C2=A0=C2=A0 one, but it is also a lot of work. Just emulating a=
 FUSB302 is
>>> not enough,
>>> =C2=A0=C2=A0=C2=A0 we also need to emulate the remote USB-PD device to=
 make this
>>> useful.
>>> =C2=A0=C2=A0=C2=A0 Without that we would only test what happens when a
>>> non-responsive USB-PD
>>> =C2=A0=C2=A0=C2=A0 supply is attached and that is the boring, very sim=
ple path in
>>> this code.
>>> =C2=A0=C2=A0=C2=A0 On the other hand implementing an emulated USB-C PD=
 remote side
>>> more or less
>>> =C2=A0=C2=A0=C2=A0 requires implementing another big state machine.
>>> =C2=A0 * Add documentation for the 'tcpm' command (Simon Glass)
>>> =C2=A0 * I also got asked to add more documentation for the feature in
>>> general. I'm
>>> =C2=A0=C2=A0=C2=A0 not really sure what is needed. At least Tim Harvey=
 managed to
>>> use it
>>> =C2=A0=C2=A0=C2=A0 considering he got stusb4500 working on top of PATC=
HV2. If there
>>> are more
>>> =C2=A0=C2=A0=C2=A0 specific requests I can write something.
>>> =C2=A0 * Just like PATCHv1, PATCHv2 received a 'Tested-by: Soeren Moch
>>> <smoch@web.de>',
>>> =C2=A0=C2=A0=C2=A0 which I did not take over. This time the changes ar=
e a lot
>>> smaller, but
>>> =C2=A0=C2=A0=C2=A0 the different handling of timeouts might have broke=
n something.
>>> (On my end
>>> =C2=A0=C2=A0=C2=A0 things still behave correctly of course, otherwise =
I wouldn't
>>> have sent
>>> =C2=A0=C2=A0=C2=A0 this series)
>>
>> FWIW
>> I retested this v3 series on top of v2024.07. Everything still works
>> as expected on my rock-5b board with different USB-PD power supplies
>> (5V, 12V, 20V).
>>
>> Tested-by: Soeren Moch <smoch@web.de>
> One difference between patch versions 2 and 3 I can observe when
> powering from a mini-PC (USB-C port) though:
Even worse when powering the rock-5b board from a notebook PC.
With patch version 2 also 5V/3V are negotiated and everything works
(including booting linux),
with patch version 3 there is a boot loop as without any tcpm patch.

So I have to withdraw my tested-by-tag for v3.

Regards,
Soeren
>
> *** Patch version v2:
>
> U-Boot 2024.07-00005-g2000ac570b (Aug 08 2024 - 16:20:40 +0200)
>
> Model: Radxa ROCK 5 Model B
> DRAM:=C2=A0 8 GiB
> Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
> MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
> Loading Environment from nowhere... OK
> In: serial@feb50000
> Out: serial@feb50000
> Err: serial@feb50000
> Model: Radxa ROCK 5 Model B
> Net:=C2=A0=C2=A0 No ethernet found.
> Hit any key to stop autoboot: 0
> =3D> tcpm list
> | Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Parent name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Parent
> uclass @ seq
> | usb-typec@22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c@feac0000=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c @ 4 |
> status: 0
> =3D> tcpm dev usb-typec@22
> dev: 0 @ usb-typec@22
> =3D> tcpm info
> Orientation: reverse
> PD Revision: rev3
> Power Role: sink
> Data Role: device
> Voltage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.000 V
> Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.000 A
> =3D>
>
> *** Patch version v3:
>
> U-Boot 2024.07-00007-g642d8a1c14 (Aug 08 2024 - 15:32:24 +0200)
>
> Model: Radxa ROCK 5 Model B
> DRAM:=C2=A0 8 GiB
> Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
> MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
> Loading Environment from nowhere... OK
> In: serial@feb50000
> Out: serial@feb50000
> Err: serial@feb50000
> Model: Radxa ROCK 5 Model B
> fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
> Net:=C2=A0=C2=A0 No ethernet found.
> Hit any key to stop autoboot: 0
> =3D> tcpm list
> | Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Parent name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Parent
> uclass @ seq
> | usb-typec@22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c@feac0000=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c @ 4 |
> status: 0
> =3D> tcpm dev usb-typec@22
> dev: 0 @ usb-typec@22
> =3D> tcpm info
> Orientation: normal
> PD Revision: rev3
> Power Role: sink
> Data Role: device
> Voltage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.000 V
> Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.000 A
> =3D>
>
> So patch version 2 worked better for this use case.
>
> Regards,
> Soeren
>>
>> Thanks,
>> Soeren
>>
>>> =C2=A0 * Address feedback from Marek Vasut
>>> =C2=A0=C2=A0 - TCPM core
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - drop useless "failure" function
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - replace printf with log in TCPM command cod=
e
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - invert some conditions to reduce indent
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - use read_poll_timeout() in tcpm_pd_transmit=
()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - did not add any more 'static' keywords to f=
unctions, the
>>> non-static
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCPM functions are exported and c=
alled from the fusb302 driver.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - add a safety guard to tcpm_send_queued_mess=
age(), which stops
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the loop if more than 100 message=
s are send directly after each
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other. This should never happen a=
nyways, but it's better to exit
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cleanly if the code runs astray.
>>> =C2=A0=C2=A0 - FUSB302 driver
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Drop default initialization for most local =
ret variables
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Make some local variables constant
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Make set_polarity callback optional on the =
uclass level and
>>> drop the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 empty FUSB302 implementation
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Change buffer initialization in send messag=
e function
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Create define for max. message length magic=
 value
>>> =C2=A0=C2=A0 - Rock 5B board code
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Add comment why misc_init_r explicitly init=
ializes PD
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Split defconfig and DT into separate patche=
s (Kever Yang)
>>>
>>> Changes since PATCHv1:
>>> =C2=A0 * tcpm: split uclass specific code to tcpm-uclass
>>> =C2=A0 * tcpm_print_info: move printing part to cmd/tcpm.c
>>> =C2=A0 * tcpm_print_info: report more information
>>> =C2=A0=C2=A0=C2=A0 - PD revision
>>> =C2=A0=C2=A0=C2=A0 - Cable orientation
>>> =C2=A0=C2=A0=C2=A0 - Power role
>>> =C2=A0=C2=A0=C2=A0 - Data role
>>> =C2=A0=C2=A0=C2=A0 - Print TCPM state based on connection status
>>> =C2=A0 * tcpm: use "struct udevice *dev" instead of "struct tcpm_port =
*port"
>>> =C2=A0=C2=A0=C2=A0 as function argument in most places and drop dev fr=
om the tcpm_port
>>> =C2=A0=C2=A0=C2=A0 struct
>>> =C2=A0 * tcpm: avoid useless kzalloc + copy + free for incoming events
>>> =C2=A0 * tcpm: use dev_get_uclass_plat() for tcpm_port
>>> =C2=A0 * tcpm: run tcpm_port_init() and tcpm_poll_event() from UCLASS
>>> post_probe()
>>> =C2=A0 * tcpm/fusb302: get rid of tcpc_dev by using dm_tcpm_ops() for =
the
>>> =C2=A0=C2=A0=C2=A0 function pointers and introducing get_connector_nod=
e() for the
>>> =C2=A0=C2=A0=C2=A0 ofnode
>>> =C2=A0 * fusb302: use "struct udevice *dev" instead of "struct
>>> fusb302_chip *chip"
>>> =C2=A0=C2=A0=C2=A0 as function argument and drop dev from the fusb302_=
chip struct
>>> =C2=A0 * fusb302: drop multiple unused members from fusb302_chip
>>> =C2=A0 * fusb302: directly use udelay instead of usleep_range define
>>> =C2=A0 * fusb302: use fusb302_ prefix for all functions. Afterwards tc=
pm_
>>> prefix
>>> =C2=A0=C2=A0=C2=A0 is only used for the tcpm code itself
>>> =C2=A0 * fusb302: move fusb302_poll_event() to avoid forward defintion
>>> =C2=A0 * fusb302: drop probe function
>>> =C2=A0 * fusb302: drop unused LOG_BUFFER defines
>>> =C2=A0 * roughly 20% of all lines of the series changed between v1 and
>>> v2, so
>>> =C2=A0=C2=A0=C2=A0 I did not collect the Tested-by from Soeren Moch
>>>
>>> Greetings,
>>>
>>> -- Sebastian
>>>
>>> Sebastian Reichel (7):
>>> =C2=A0=C2=A0 usb: tcpm: add core framework
>>> =C2=A0=C2=A0 usb: tcpm: fusb302: add driver
>>> =C2=A0=C2=A0 board: rock5b-rk3588: add USB-C controller support
>>> =C2=A0=C2=A0 board: rock5b-rk3588: enable USB-C in operating system
>>> =C2=A0=C2=A0 rockchip: rk3588-rock-5b: Add USB-C controller to u-boot.=
dtsi
>>> =C2=A0=C2=A0 rockchip: rock5b-rk3588: Enable USB-C PD support
>>> =C2=A0=C2=A0 MAINTAINERS: add TCPM section
>>>
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 9 +
>>> =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 1 +
>>> =C2=A0 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi=C2=A0=C2=A0 |=C2=A0=C2=
=A0 28 +
>>> =C2=A0 board/radxa/rock5b-rk3588/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
>>> =C2=A0 board/radxa/rock5b-rk3588/rock5b-rk3588.c |=C2=A0=C2=A0 46 +
>>> =C2=A0 cmd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 7 +
>>> =C2=A0 cmd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 =
+
>>> =C2=A0 cmd/tcpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13=
6 ++
>>> =C2=A0 configs/rock5b-rk3588_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
>>> =C2=A0 doc/usage/cmd/tcpm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 66 +
>>> =C2=A0 doc/usage/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>> =C2=A0 drivers/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +
>>> =C2=A0 drivers/usb/tcpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 16 +
>>> =C2=A0 drivers/usb/tcpm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 4 +
>>> =C2=A0 drivers/usb/tcpm/fusb302.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1322 ++++++++++++
>>> =C2=A0 drivers/usb/tcpm/fusb302_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 177 ++
>>> =C2=A0 drivers/usb/tcpm/tcpm-internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 173 ++
>>> =C2=A0 drivers/usb/tcpm/tcpm-uclass.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 88 +
>>> =C2=A0 drivers/usb/tcpm/tcpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22=
77
>>> +++++++++++++++++++++
>>> =C2=A0 include/dm/uclass-id.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>> =C2=A0 include/usb/pd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 516 +++++
>>> =C2=A0 include/usb/tcpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 99 +
>>> =C2=A0 22 files changed, 4981 insertions(+)
>>> =C2=A0 create mode 100644 board/radxa/rock5b-rk3588/Makefile
>>> =C2=A0 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>>> =C2=A0 create mode 100644 cmd/tcpm.c
>>> =C2=A0 create mode 100644 doc/usage/cmd/tcpm.rst
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/Kconfig
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/Makefile
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/fusb302.c
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/fusb302_reg.h
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>>> =C2=A0 create mode 100644 drivers/usb/tcpm/tcpm.c
>>> =C2=A0 create mode 100644 include/usb/pd.h
>>> =C2=A0 create mode 100644 include/usb/tcpm.h
>>>
>

