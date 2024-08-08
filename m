Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45320C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B064D889E6;
	Thu,  8 Aug 2024 16:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="jYM7XjSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C51889E6; Thu,  8 Aug 2024 16:35:11 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C4B8896F
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1723127688; x=1723732488; i=smoch@web.de;
 bh=7g9IPU7RIPspzOpDPrDdRc+3LnQ+Bt3yqjS07InbD/k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jYM7XjSarDZV9R3B4fyNn8iViWNfh7LoGrlfrIBAripiMphbQYmVuE2YRCOgy9FW
 u78LQ9dY/qEK5Fr2UapQisoM9aDUhDYyQr7tjXPqQL+P5wekv/kA8pd0QfhcavXqs
 tN5Zg8RMvXXmUxClCeBLJbWKiRNF/d1E9PSIofquwfuaJ2M8blLUc1TjrB37A0yee
 AfEZyskm43P/6SSPvJCb9jTY2a3caVd4FGkVVpm/7OeyPd3DuGzuwMlpjVOPyTssx
 E1w8UmP9FKq4+BIOwYkVoT79IOMCT/1mW8TatMdL1HFUxtrwBa1PVEMOkmzreyimh
 yeYLYsVx3v8Lu7yKvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.58.28] ([93.241.254.39]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7usw-1sYCLV3Df8-006yEp; Thu, 08
 Aug 2024 16:34:47 +0200
Message-ID: <7f7acdaa-c220-49c3-8cfb-023a1f493d20@web.de>
Date: Thu, 8 Aug 2024 16:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
From: =?UTF-8?Q?S=C3=B6ren_Moch?= <smoch@web.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <9c5078f1-ba80-464c-8778-365117457eaa@web.de>
Content-Language: en-US
In-Reply-To: <9c5078f1-ba80-464c-8778-365117457eaa@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kWc6K0aG8HA2wNHSfXIVtuzBgadbaEaiHa8VcUug6DYVplI3CBZ
 QllL2CLLzTxbSN2wYWmrc55goG2ZTAiKf5PJEGwaT35ZGQ6NEwOnqT7BkGuNnt6nXN1kxOY
 9oCwGLSnAsMNH79cPNbgTC3XTwpZVy8ql5wtjpeey3JOuiV6aeradYjq7bRx4+BK2kPPP8k
 Abu3Q6NQ3+ppxPXWx1xHw==
UI-OutboundReport: notjunk:1;M01:P0:GIyooAVY2k4=;hKW6iu5uJjcwXR6bUp08CIoIgpo
 0u4Gn7XDOtmTH+bwKTiGG5VuOTGg14IA84qUa72So9uHTnZ5j0Vy77IYa+OPDO7+eqBrmf/l8
 mQaEA6BWphKA1dyRV3BvL66HjRYlIzsUuAHyotYLYaKK+qOnjTxoSGJavYgBbN8FE1uJNTbPK
 d+Y0twNjUfsXRx3ubar/yPJVrSNawZ2DqQ3ztUkTLZd9njBILbEWHNPC59GiOEXGcwhiQShPs
 v98BU5k7OfGSlq10i4MoSxi80amErigCS48ORTZeJ7zfske8Xkj31n68ge7hpRvMXV5BuCg9H
 t9hLGdjUCSmmcsS60iapkRasqwxSPx4orutypbk9c1jH9/VbekLiycudB0Zgg7znppfMVWQDV
 aP8otPiLc4zU7kWTQAe8fsUIh595QLmZFh/jcDcoTQpKMrds/9S9w8220x6pZBXkw1shGRE92
 yy0t1Ix1vuaH7w/x7YCtfCbmIWzuxPpFuFx58yJn2LM6vUJUy1/NCsoOGsECi1EnXdRAMIrO1
 S14DWT0Kjh+90wagSJ1NISxzCsRSzpBeiLLQZKsYyPlDlk2a/7CRv1HN+7Aga20fXcqzxHIjZ
 q45fXGGha/y/8A2KKq/2XFvwkGwnU4+3BSxdgUAisRMgRK0K91q20yq67YsBYqHzT8AnSRurS
 BrRdbX2g3qOxMoCNhb4IG2DYLSFAFEMY3ySM4+1YNxZmE3uVikZbkngbjOkSwrFcW/p6bfXsf
 kNAU5a00UupCXFb+26bOFGgPamWJka/vTOdphvAy2oBvB61rQdu7QCzGXVLdASKYlWTeFJhPz
 M3CdBauFGdbH3TS7fWYz8hOg==
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



On 08.08.24 15:58, Soeren Moch wrote:
>
>
> On 02.08.24 19:59, Sebastian Reichel wrote:
>> Hi,
>>
>> On ROCK 5B power is usually supplied via it's USB-C port. This port
>> has the
>> data lines connected to RK3588, VBUS connected to the input regulator
>> and
>> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which
>> can be
>> accessed via I2C from RK3588. The USB-C controller is needed to
>> figure out
>> the USB-C cable orientation, but also to do USB PD communication.
>> Thus it
>> would be great to enable support for it in the operating system.
>>
>> But the USB-PD specification requires, that a device reacts to USB-PD
>> messages
>> send by the power-supply within around 5 seconds. If that does not
>> happen the
>> power-supply assumes, that the device does not support USB-PD. If a
>> device
>> later starts sending USB-PD messages it is considered an error, which
>> is solved
>> by doing a hard reset. A USB-PD hard reset means, that all supply
>> voltages are
>> removed for a short period of time. For boards, which are solely powere=
d
>> through their USB-C port, like the Radxa Rock 5B, this results in an
>> machine
>> reset. This is currently worked around by not describing the FUSB302
>> in the
>> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>>
>> 1. the USB-C port cannot be used at all
>> 2. the board will be running via fallback supply, which provides limite=
d
>> =C2=A0=C2=A0=C2=A0 power capabilities
>>
>> In order to avoid the hard reset, this adds FUSB302 support to
>> U-Boot, so
>> that we react to the power-supply's queries in time. The code, which is
>> originally from the Linux kernel, consists of two parts:
>>
>> 1. the tcpm state machine, which implements the Type C port manager
>> state
>> =C2=A0=C2=A0=C2=A0 machine as described in the USB PD specification
>> 2. the fusb302 driver, which knows about specific registers
>>
>> Especially the first part has been heavily modified compared to the
>> kernel, which makes use of multiple delayed works and threads. For this
>> I used a priorly ported version from Rockchip, removed their hacks and
>> any states not necessary in U-Boot (e.g. audio accessory support).
>>
>> Sorry for the delay in getting PATCHv3 ready.
>>
>> Changes since PATCHv2:
>> =C2=A0 * Rebase to latest master (a70d991212c9)
>> =C2=A0 * Drop Wang Jie from Cc, since his address bounces
>> =C2=A0 * I did not add a test suite. I fully agree, that it would be ni=
ce
>> to have
>> =C2=A0=C2=A0=C2=A0 one, but it is also a lot of work. Just emulating a =
FUSB302 is
>> not enough,
>> =C2=A0=C2=A0=C2=A0 we also need to emulate the remote USB-PD device to =
make this
>> useful.
>> =C2=A0=C2=A0=C2=A0 Without that we would only test what happens when a
>> non-responsive USB-PD
>> =C2=A0=C2=A0=C2=A0 supply is attached and that is the boring, very simp=
le path in
>> this code.
>> =C2=A0=C2=A0=C2=A0 On the other hand implementing an emulated USB-C PD =
remote side
>> more or less
>> =C2=A0=C2=A0=C2=A0 requires implementing another big state machine.
>> =C2=A0 * Add documentation for the 'tcpm' command (Simon Glass)
>> =C2=A0 * I also got asked to add more documentation for the feature in
>> general. I'm
>> =C2=A0=C2=A0=C2=A0 not really sure what is needed. At least Tim Harvey =
managed to
>> use it
>> =C2=A0=C2=A0=C2=A0 considering he got stusb4500 working on top of PATCH=
V2. If there
>> are more
>> =C2=A0=C2=A0=C2=A0 specific requests I can write something.
>> =C2=A0 * Just like PATCHv1, PATCHv2 received a 'Tested-by: Soeren Moch
>> <smoch@web.de>',
>> =C2=A0=C2=A0=C2=A0 which I did not take over. This time the changes are=
 a lot
>> smaller, but
>> =C2=A0=C2=A0=C2=A0 the different handling of timeouts might have broken=
 something.
>> (On my end
>> =C2=A0=C2=A0=C2=A0 things still behave correctly of course, otherwise I=
 wouldn't
>> have sent
>> =C2=A0=C2=A0=C2=A0 this series)
>
> FWIW
> I retested this v3 series on top of v2024.07. Everything still works
> as expected on my rock-5b board with different USB-PD power supplies
> (5V, 12V, 20V).
>
> Tested-by: Soeren Moch <smoch@web.de>
One difference between patch versions 2 and 3 I can observe when
powering from a mini-PC (USB-C port) though:

*** Patch version v2:

U-Boot 2024.07-00005-g2000ac570b (Aug 08 2024 - 16:20:40 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In: serial@feb50000
Out: serial@feb50000
Err: serial@feb50000
Model: Radxa ROCK 5 Model B
Net:=C2=A0=C2=A0 No ethernet found.
Hit any key to stop autoboot: 0
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
Power Role: sink
Data Role: device
Voltage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.000 V
Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.000 A
=3D>

*** Patch version v3:

U-Boot 2024.07-00007-g642d8a1c14 (Aug 08 2024 - 15:32:24 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
Core:=C2=A0 355 devices, 33 uclasses, devicetree: separate
MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In: serial@feb50000
Out: serial@feb50000
Err: serial@feb50000
Model: Radxa ROCK 5 Model B
fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
Net:=C2=A0=C2=A0 No ethernet found.
Hit any key to stop autoboot: 0
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
Power Role: sink
Data Role: device
Voltage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.000 V
Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.000 A
=3D>

So patch version 2 worked better for this use case.

Regards,
Soeren
>
> Thanks,
> Soeren
>
>> =C2=A0 * Address feedback from Marek Vasut
>> =C2=A0=C2=A0 - TCPM core
>> =C2=A0=C2=A0=C2=A0=C2=A0 - drop useless "failure" function
>> =C2=A0=C2=A0=C2=A0=C2=A0 - replace printf with log in TCPM command code
>> =C2=A0=C2=A0=C2=A0=C2=A0 - invert some conditions to reduce indent
>> =C2=A0=C2=A0=C2=A0=C2=A0 - use read_poll_timeout() in tcpm_pd_transmit(=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0 - did not add any more 'static' keywords to fu=
nctions, the
>> non-static
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCPM functions are exported and ca=
lled from the fusb302 driver.
>> =C2=A0=C2=A0=C2=A0=C2=A0 - add a safety guard to tcpm_send_queued_messa=
ge(), which stops
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the loop if more than 100 messages=
 are send directly after each
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other. This should never happen an=
yways, but it's better to exit
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cleanly if the code runs astray.
>> =C2=A0=C2=A0 - FUSB302 driver
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Drop default initialization for most local r=
et variables
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Make some local variables constant
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Make set_polarity callback optional on the u=
class level and
>> drop the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 empty FUSB302 implementation
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Change buffer initialization in send message=
 function
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Create define for max. message length magic =
value
>> =C2=A0=C2=A0 - Rock 5B board code
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Add comment why misc_init_r explicitly initi=
alizes PD
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Split defconfig and DT into separate patches=
 (Kever Yang)
>>
>> Changes since PATCHv1:
>> =C2=A0 * tcpm: split uclass specific code to tcpm-uclass
>> =C2=A0 * tcpm_print_info: move printing part to cmd/tcpm.c
>> =C2=A0 * tcpm_print_info: report more information
>> =C2=A0=C2=A0=C2=A0 - PD revision
>> =C2=A0=C2=A0=C2=A0 - Cable orientation
>> =C2=A0=C2=A0=C2=A0 - Power role
>> =C2=A0=C2=A0=C2=A0 - Data role
>> =C2=A0=C2=A0=C2=A0 - Print TCPM state based on connection status
>> =C2=A0 * tcpm: use "struct udevice *dev" instead of "struct tcpm_port *=
port"
>> =C2=A0=C2=A0=C2=A0 as function argument in most places and drop dev fro=
m the tcpm_port
>> =C2=A0=C2=A0=C2=A0 struct
>> =C2=A0 * tcpm: avoid useless kzalloc + copy + free for incoming events
>> =C2=A0 * tcpm: use dev_get_uclass_plat() for tcpm_port
>> =C2=A0 * tcpm: run tcpm_port_init() and tcpm_poll_event() from UCLASS
>> post_probe()
>> =C2=A0 * tcpm/fusb302: get rid of tcpc_dev by using dm_tcpm_ops() for t=
he
>> =C2=A0=C2=A0=C2=A0 function pointers and introducing get_connector_node=
() for the
>> =C2=A0=C2=A0=C2=A0 ofnode
>> =C2=A0 * fusb302: use "struct udevice *dev" instead of "struct
>> fusb302_chip *chip"
>> =C2=A0=C2=A0=C2=A0 as function argument and drop dev from the fusb302_c=
hip struct
>> =C2=A0 * fusb302: drop multiple unused members from fusb302_chip
>> =C2=A0 * fusb302: directly use udelay instead of usleep_range define
>> =C2=A0 * fusb302: use fusb302_ prefix for all functions. Afterwards tcp=
m_
>> prefix
>> =C2=A0=C2=A0=C2=A0 is only used for the tcpm code itself
>> =C2=A0 * fusb302: move fusb302_poll_event() to avoid forward defintion
>> =C2=A0 * fusb302: drop probe function
>> =C2=A0 * fusb302: drop unused LOG_BUFFER defines
>> =C2=A0 * roughly 20% of all lines of the series changed between v1 and =
v2, so
>> =C2=A0=C2=A0=C2=A0 I did not collect the Tested-by from Soeren Moch
>>
>> Greetings,
>>
>> -- Sebastian
>>
>> Sebastian Reichel (7):
>> =C2=A0=C2=A0 usb: tcpm: add core framework
>> =C2=A0=C2=A0 usb: tcpm: fusb302: add driver
>> =C2=A0=C2=A0 board: rock5b-rk3588: add USB-C controller support
>> =C2=A0=C2=A0 board: rock5b-rk3588: enable USB-C in operating system
>> =C2=A0=C2=A0 rockchip: rk3588-rock-5b: Add USB-C controller to u-boot.d=
tsi
>> =C2=A0=C2=A0 rockchip: rock5b-rk3588: Enable USB-C PD support
>> =C2=A0=C2=A0 MAINTAINERS: add TCPM section
>>
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 9 +
>> =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi=C2=A0=C2=A0 |=C2=A0=C2=
=A0 28 +
>> =C2=A0 board/radxa/rock5b-rk3588/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
>> =C2=A0 board/radxa/rock5b-rk3588/rock5b-rk3588.c |=C2=A0=C2=A0 46 +
>> =C2=A0 cmd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 7 +
>> =C2=A0 cmd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 =
+
>> =C2=A0 cmd/tcpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 136 +=
+
>> =C2=A0 configs/rock5b-rk3588_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
>> =C2=A0 doc/usage/cmd/tcpm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 66 +
>> =C2=A0 doc/usage/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +
>> =C2=A0 drivers/usb/tcpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 16 +
>> =C2=A0 drivers/usb/tcpm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 4 +
>> =C2=A0 drivers/usb/tcpm/fusb302.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1322 ++++++++++++
>> =C2=A0 drivers/usb/tcpm/fusb302_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 177 ++
>> =C2=A0 drivers/usb/tcpm/tcpm-internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 173 ++
>> =C2=A0 drivers/usb/tcpm/tcpm-uclass.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 88 +
>> =C2=A0 drivers/usb/tcpm/tcpm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22=
77 +++++++++++++++++++++
>> =C2=A0 include/dm/uclass-id.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 include/usb/pd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 516 +++++
>> =C2=A0 include/usb/tcpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 99 +
>> =C2=A0 22 files changed, 4981 insertions(+)
>> =C2=A0 create mode 100644 board/radxa/rock5b-rk3588/Makefile
>> =C2=A0 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>> =C2=A0 create mode 100644 cmd/tcpm.c
>> =C2=A0 create mode 100644 doc/usage/cmd/tcpm.rst
>> =C2=A0 create mode 100644 drivers/usb/tcpm/Kconfig
>> =C2=A0 create mode 100644 drivers/usb/tcpm/Makefile
>> =C2=A0 create mode 100644 drivers/usb/tcpm/fusb302.c
>> =C2=A0 create mode 100644 drivers/usb/tcpm/fusb302_reg.h
>> =C2=A0 create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>> =C2=A0 create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>> =C2=A0 create mode 100644 drivers/usb/tcpm/tcpm.c
>> =C2=A0 create mode 100644 include/usb/pd.h
>> =C2=A0 create mode 100644 include/usb/tcpm.h
>>

